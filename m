Return-Path: <netdev+bounces-240638-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id CCB4CC77252
	for <lists+netdev@lfdr.de>; Fri, 21 Nov 2025 04:20:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id EE24935F75A
	for <lists+netdev@lfdr.de>; Fri, 21 Nov 2025 03:19:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABC1A2DF14A;
	Fri, 21 Nov 2025 03:19:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KEv6e7Us"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85F7C29B77C
	for <netdev@vger.kernel.org>; Fri, 21 Nov 2025 03:19:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763695158; cv=none; b=iJTiPa+fLhFiJMp11ANBiUMXXNe1CaHOexJLIXuYJMFQZ1cL/iyMU/HAneA7qLYHkhebas20vRZYj0JERBIluEc0nQUex6e0hG2kwtR1JZsOtA8Uh5lCUgePRny8GJcUOwdS7DC6CYP/Hb4EgrpjfNdIRAW/sl0HA9+t5tHx7cw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763695158; c=relaxed/simple;
	bh=9I0gmZTrLdx10DkU1dpqUfFndZ0psjEPqNUij5ibGxE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Jj2N4fnlLQ5SxULsEAOP1yKkQ99/lXEbMUlBdS4iteg4K6X1uBa7MGh5EfRrVm/CE9FZQ0CQy1oPOKhyiOJSGHY4yz3oOrw0bUCMmXWjZBgpX8pDEPH+jctmPod3FuqcYj35TjD1L7jIYlcyUyxXkjtF2MSjj7jCLlDj764LxME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KEv6e7Us; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1A37C4CEF1;
	Fri, 21 Nov 2025 03:19:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763695158;
	bh=9I0gmZTrLdx10DkU1dpqUfFndZ0psjEPqNUij5ibGxE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=KEv6e7Us+Qkum34IBevadL2Ll3TzsuootFBB66xhYXuAqdEB/jwsJZb6eg2dzGBcN
	 NOwEDAOC6F8DGhW+OQBU9fi17+fyxYxoiwb39OOaJFpczzcaySsV6jEaFP2e435RAH
	 mgCec1DomtI+P0D6CzzKmAawfpisdvao3edjGzW+0IqUwZGbWff6oZEGsSohWjsIlq
	 qdH/JSEZYyl8S+LqYsU/iSvi0eFLncJmaZXtXBgiv7LZyU+8aPuayDWlnBcPa9Z1fZ
	 6Zn06fVt7NCrDAo8Ib2DkukfkG3ZsuEwJFZog43a6C8SQiP6PJYosLtHIQhC/Xfgyd
	 Xz6rwsUz5xOmA==
Date: Thu, 20 Nov 2025 19:19:16 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: David Wei <dw@davidwei.uk>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, Daniel Borkmann <daniel@iogearbox.net>
Subject: Re: [PATCH net-next v1 4/7] selftests/net: add rand_ifname() helper
Message-ID: <20251120191916.4f91ee3a@kernel.org>
In-Reply-To: <20251120033016.3809474-5-dw@davidwei.uk>
References: <20251120033016.3809474-1-dw@davidwei.uk>
	<20251120033016.3809474-5-dw@davidwei.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 19 Nov 2025 19:30:13 -0800 David Wei wrote:
> For upcoming netkit container datapath selftests I want to generate
> randomised ifnames. Add a helper rand_ifname() to do this.

The kernel will generate a name automatically, why do we need to create
a specific one?

