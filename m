Return-Path: <netdev+bounces-248589-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id AA57AD0C1B8
	for <lists+netdev@lfdr.de>; Fri, 09 Jan 2026 20:50:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 817E0302353E
	for <lists+netdev@lfdr.de>; Fri,  9 Jan 2026 19:50:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDEAE35BDDC;
	Fri,  9 Jan 2026 19:50:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GfzadPhC"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BC1D204583
	for <netdev@vger.kernel.org>; Fri,  9 Jan 2026 19:50:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767988216; cv=none; b=L4F+nGlcAzOWBLnJEitFEFmwkKufNQ5FlgI/4bcignU70KHOSPq9EnuOg7N3j1V8o65AiYd587iGV6jGUoqVSbMczdQQ8hMgRiNVSThkYFrrwEo43EZ2r6VKopOONHoINk66lggZaUDX6vM255TQWbNdmrpOQIxtFm+a2pywKp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767988216; c=relaxed/simple;
	bh=CY9CUckz/9KgBFiL4k2nndH1tjpEz9rtFYrvcg4GLvI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BQPpqC1iLUWeuZ3RypDsTEGww8COb8gPW/GMsU9fljEMYsZSCdqZyBfYt4Lgml6YC78Fisfojn7/n7AjThVfv7EJdhSsqPST1rRNRVJL+yT1cD2OI/56XQFMtyCvRaKsAImyqb7DIOoaXtsTXMa8FRE45NMynpvaN2YkLS2WUDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GfzadPhC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10795C4CEF1;
	Fri,  9 Jan 2026 19:50:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767988216;
	bh=CY9CUckz/9KgBFiL4k2nndH1tjpEz9rtFYrvcg4GLvI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=GfzadPhCJLPWqmzN4aRQHQziScGSapympIPS10AZPfdHiZHk/j5i4y5kUtJjcs/I7
	 4hDxSsKax5bRh2JKrC7c72jkRad8g7enmwvNC5Xd9M8uT54w/H6OyI5+c1NceoIrQg
	 7sORXK+aty2rNfmapUZbN6M3rNLTRCLT9qrmDZtZIfEDFnNHj366CYsQ7vem8IMs5N
	 kxx68XSJN7vkPebSBj9ozUeGzMwwkLn75j4ABIDH9bPMJzm3a+As4AwxkY0WibHx+3
	 P5CGCvlkJDHxnWeHRMweOPz6nUDxeOEnxQQt1Y5st/uArvQyvZqebmTjKeJDKLuNCo
	 uqQdcsQBCs8dw==
Date: Fri, 9 Jan 2026 11:50:15 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Tom Herbert <tom@herbertland.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org
Subject: Re: [PATCH net-next v2 0/4] ipv6: Disable IPv6 Destination Options
 RX processing by default
Message-ID: <20260109115015.727c7e9e@kernel.org>
In-Reply-To: <20260108171456.47519-1-tom@herbertland.com>
References: <20260108171456.47519-1-tom@herbertland.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu,  8 Jan 2026 09:14:52 -0800 Tom Herbert wrote:
> This patchset set changes the interpretation of the Destination Options
> and Hop-by-Hop Options sysctl limits, net.ipv6.max_dst_opts_number and
> net.ipv6.max_dst_opts_number to mean that when the sysctl is zero
> processing of the associated extension header is disabled such that
> packets received with the extension header are dropped.

Hi Tom!

Unfortunately, this breaks GRE:
https://netdev.bots.linux.dev/contest.html?pw-n=0&branch=net-next-2026-01-09--18-00&pw-n=0&pass=0

