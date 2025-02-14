Return-Path: <netdev+bounces-166557-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89A86A36733
	for <lists+netdev@lfdr.de>; Fri, 14 Feb 2025 22:06:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E30CE3B23DB
	for <lists+netdev@lfdr.de>; Fri, 14 Feb 2025 21:06:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB88C18DF81;
	Fri, 14 Feb 2025 21:06:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OYROLP+m"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B66BB17E
	for <netdev@vger.kernel.org>; Fri, 14 Feb 2025 21:06:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739567190; cv=none; b=Obzy3Ru0M+9fjZPlIp75yKl87RK9pXk3CHg3lovJkRCxp4yJ6EgBz2kHlNXi34snGyVOH7K9CuJzSBF+kEn+owyJr6ws/DN1xx0YwtpSdVvipoSgll0GDZ+mKRBiGu6PS/BHZu7C3KXKmWbvXGWoCl0nWXnsHrvMp04kE8BTmTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739567190; c=relaxed/simple;
	bh=rFR6pfjRPiB/HwktGUMwYHUAt8GrUTpcYFA1w2mb9RI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=u2e6w3BDso/RxugqHJHGGPEqPpkCXHZToV0VgSlNgSE60sAvl9/ML8uSD8dKzdaYB3SU4xG1M7M3eCr3lPZc/fQLZJPYl4CcL+96QLUmOWtmVYebl88ZMQXNiFfmJtzC5B7UPH18geH3JshANHIKcdpIgUHi73UZ2a+GakL1Cyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OYROLP+m; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EEBB2C4CED1;
	Fri, 14 Feb 2025 21:06:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739567190;
	bh=rFR6pfjRPiB/HwktGUMwYHUAt8GrUTpcYFA1w2mb9RI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=OYROLP+mEubjKcJDJ3V8Fqk67hg1SDqDEyKn8L/sTcf+NTbUabOUEcG0LHfrL0Ekr
	 pIkUrp+wiEFVy1tRyhkwsJIqeGt5VUdA7sqRR7+pYZWqVI1sed4F+xJqMoyP/KJ2Vi
	 nYAuZ0TTrk/hDL3mf5pKsUtA51TAS0/6B+MnLWLO7key8Ui0HIaIVjWajoHEjZNv2/
	 pSiPiVYjmx8y2VLzo6g95fJIgndJ/AaBeFEgcVY91TB0+j//D1Q0oOxH0exT5OQSzC
	 o+Q9UBF8i77C9iME2NyvBmw5Nx5JXFcAYCph0lufF0R5DfV7+v02JGywFGAjC+sbkj
	 Zezq4A+febY4Q==
Date: Fri, 14 Feb 2025 13:06:29 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, dsahern@kernel.org, horms@kernel.org, Willem de Bruijn
 <willemb@google.com>
Subject: Re: [PATCH net-next v2 0/7] net: deduplicate cookie logic
Message-ID: <20250214130629.00a35961@kernel.org>
In-Reply-To: <20250212021142.1497449-1-willemdebruijn.kernel@gmail.com>
References: <20250212021142.1497449-1-willemdebruijn.kernel@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 11 Feb 2025 21:09:46 -0500 Willem de Bruijn wrote:
> From: Willem de Bruijn <willemb@google.com>
> 
> Reuse standard sk, ip and ipv6 cookie init handlers where possible.
> 
> Avoid repeated open coding of the same logic.
> Harmonize feature sets across protocols.
> Make IPv4 and IPv6 logic more alike.
> Simplify adding future new fields with a single init point.

Sorry for noticing late, looks like this doesn't apply cleanly:

Applying: tcp: only initialize sockcm tsflags field
Applying: net: initialize mark in sockcm_init
Applying: ipv4: initialize inet socket cookies with sockcm_init
Applying: ipv4: remove get_rttos
Applying: icmp: reflect tos through ip cookie rather than updating inet_sk
Using index info to reconstruct a base tree...
M	net/ipv4/icmp.c
Falling back to patching base and 3-way merge...
Auto-merging net/ipv4/icmp.c
Applying: ipv6: replace ipcm6_init calls with ipcm6_init_sk
Applying: ipv6: initialize inet socket cookies with sockcm_init

So CI didn't consume it..

Could you rebase & repost?
-- 
pw-bot: cr

