Return-Path: <netdev+bounces-190439-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 053FEAB6D42
	for <lists+netdev@lfdr.de>; Wed, 14 May 2025 15:50:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 950A616FF49
	for <lists+netdev@lfdr.de>; Wed, 14 May 2025 13:50:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF1A8192580;
	Wed, 14 May 2025 13:50:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Kt4Eu1FL"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AF4A2A1D1
	for <netdev@vger.kernel.org>; Wed, 14 May 2025 13:50:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747230649; cv=none; b=k8enPU9FrSxSoCnUMViaMhjVMv88Gfd1Py5cOihWlfg2fwdfcClNIeD3dxsLEiJzNeneGD2TT9Z2oMnNsq7GLEtRW50+NneiKPkqc++T73BACBrHfw6fq/sJKZ0R1dH5cNpXvRs7mJqdhYfXHwuhDHXV8KPCTWba+LjeK1J/CBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747230649; c=relaxed/simple;
	bh=t5m40B9XujV0QaZqm5uVdb4EJY/WBbb4nkiSA/Nzams=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=m0vVJmU4gMWKZaaHxR5krsCxB7wbEkZQMmnnRjFGvWCGH3yj1Wr4G1HsvvJodZt92eht4k7pccR2vAIdK1UHgEFtlhvJ4+FNDIDaZvfPnbvHRcAIWncDou83CFBUwNiz9U21a/qwUR9f38oWg0TQj3uQgqN0nMv/lYxTZcVET5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Kt4Eu1FL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7CFAC4CEEF;
	Wed, 14 May 2025 13:50:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747230649;
	bh=t5m40B9XujV0QaZqm5uVdb4EJY/WBbb4nkiSA/Nzams=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Kt4Eu1FLXNfJQgNTXv+nf0vLJAlaFNaIYWVvtkxU/mmKuPW6CD+7zxFkt6AQWKOU6
	 4YgBnHXLuHkFvTcvETDrPbo9RAcC2Kl8aYJlIHM5xJBUotRzbYG/d89UCPeQYQpC92
	 nSNTTiVgxFvQzT3a+rsjw38dSbF4kIrwjIApJqz5ATJb59tQn4Oo+MFSqG56tWxt+O
	 8EGfwsMOb/VxrNEpJvfJ7G5VJW2SBqJhBY6W8zf76GCKxhKx0gTrC8cIouBkWkB09q
	 pLW6hVh1k4XVKdEaWzjSp/ht16dC6GuF0FTdGjyddlO+msF/YYG7waKdcj5OGxjxO7
	 XUddbUGMOG0+w==
Date: Wed, 14 May 2025 06:50:48 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Antonio Quartulli <antonio@openvpn.net>
Cc: netdev@vger.kernel.org, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Sabrina Dubroca <sd@queasysnail.net>, David Ahern
 <dsahern@kernel.org>
Subject: Re: [PATCH net-next] ovpn: properly deconfigure UDP-tunnel
Message-ID: <20250514065048.3c14a599@kernel.org>
In-Reply-To: <20250514095842.12067-1-antonio@openvpn.net>
References: <20250514095842.12067-1-antonio@openvpn.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 14 May 2025 11:58:42 +0200 Antonio Quartulli wrote:
> +#if IS_ENABLED(CONFIG_IPV6)
> +	if (READ_ONCE(sk->sk_family) == PF_INET6)
> +		static_branch_dec(&udpv6_encap_needed_key);

udpv6_encap_needed_key is only exported for ipv6.ko
I think you need to correct the export, because with IPV6=y 
and UDP_TUNNEL=m we get:

ERROR: modpost: "udpv6_encap_needed_key" [net/ipv4/udp_tunnel.ko] undefined!
-- 
pw-bot: cr

