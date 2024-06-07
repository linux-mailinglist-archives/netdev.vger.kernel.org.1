Return-Path: <netdev+bounces-101603-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB1E68FF8BC
	for <lists+netdev@lfdr.de>; Fri,  7 Jun 2024 02:44:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 39C9FB20F1E
	for <lists+netdev@lfdr.de>; Fri,  7 Jun 2024 00:44:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 541D97E9;
	Fri,  7 Jun 2024 00:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hu5dGIcg"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 302A18F5E
	for <netdev@vger.kernel.org>; Fri,  7 Jun 2024 00:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717721069; cv=none; b=SmzeOeXhJL6AsA44OI+W2+2goqMR6LQnC/04IqRI+kKdyrTAe/foqCB6YO1QYlEvwsP/411y+7uBTxrzthL7uPHKNT02PxUTbdjK8AN8Zj1UqZYNqB1qL7roKnmuk7BrdWxiL2lckI1o+7oKVbxhK5YSF5vjvtu55xTsH6C+/6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717721069; c=relaxed/simple;
	bh=jArbs5qviBIHcbGV1A0kgcVjaxMhjy32z5+Nuna+g+Y=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QPv/CifNIn1TEO24M4lRxFOHWYYZuO/Ec4R3zofKd9e8buoi20Tw/TZPvZ2pxz6Tbn46O4eM1bCqH77jtdXBvPjHPPvGddQyplQ6j0KRHs5eIuJrKTpxzyK8r08wEzMRy0cTR6bXrsDfzzz2OIm3r4yOOBysYwdiIZjxL4gb8Qk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hu5dGIcg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78754C2BD10;
	Fri,  7 Jun 2024 00:44:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717721068;
	bh=jArbs5qviBIHcbGV1A0kgcVjaxMhjy32z5+Nuna+g+Y=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=hu5dGIcg6jFwLo/q/FBRjtvH/ks8TpVfhUyU9GvoAIW8lIiTT4ApeCkFPCTxcVPlw
	 r9QXS6pzD/CWikXO8YaYOYkM2ba1LT98oEQpfXyw7OQ9FAzkSOeT2pfaEFbnKTMRQu
	 3A7Ebau2wgL4VX3vuuS3n/QT9hYkYSC59N8f2F+2ftNkYT6Fahpcx6PBJoCyN/OpTJ
	 gk8Z/tejPuoBXX86es/KAcIIRonUlkHwnTxwrileHIIwRpmHjQZJvD8dKu1PbQ0aaS
	 iPPKYA55s9r2h2WKfIoEyQfG5oXoC6nT2JCLKkakpyWteEOa237zMD/XaOaKF879e3
	 0uDvJe5zcI56A==
Date: Thu, 6 Jun 2024 17:44:27 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Petr Malat <oss@malat.biz>
Cc: netdev@vger.kernel.org, edumazet@google.com, davem@davemloft.net
Subject: Re: [PATCH] ip6mr: Fix lockdep and sparse RCU warnings
Message-ID: <20240606174427.72db6750@kernel.org>
In-Reply-To: <20240605195355.363936-1-oss@malat.biz>
References: <20240605195355.363936-1-oss@malat.biz>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed,  5 Jun 2024 21:53:55 +0200 Petr Malat wrote:
> ip6mr_vif_seq_start() must lock RCU even in a case of error, because
> stop callback is called unconditionally.
> 
> When IPV6_MROUTE_MULTIPLE_TABLES is enabled, calls to ip6mr_get_table
> should be done under RCU or RTNL lock. Lock RCU before the call unless
> it's done already or RTNL lock is held.

Patch does not apply, please rebase on:
https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git
if its still legit.

And please add a Fixes tag, since its a fix.

> Signed-off-by: Petr Malat <oss@malat.biz>
> ---
>  net/ipv6/ip6mr.c | 52 +++++++++++++++++++++++++++++++-----------------
>  1 file changed, 34 insertions(+), 18 deletions(-)
> 
> diff --git a/net/ipv6/ip6mr.c b/net/ipv6/ip6mr.c
> index cb0ee81a068a..bf6932535d6d 100644
> --- a/net/ipv6/ip6mr.c
> +++ b/net/ipv6/ip6mr.c
> @@ -411,13 +411,14 @@ static void *ip6mr_vif_seq_start(struct seq_file *seq, loff_t *pos)
>  	struct net *net = seq_file_net(seq);
>  	struct mr_table *mrt;
>  
> +	rcu_read_lock();
> +
>  	mrt = ip6mr_get_table(net, RT6_TABLE_DFLT);
>  	if (!mrt)
>  		return ERR_PTR(-ENOENT);

Double check for bugs like missing unlock, too...

