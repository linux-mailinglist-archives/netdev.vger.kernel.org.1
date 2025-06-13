Return-Path: <netdev+bounces-197566-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 40BF1AD9339
	for <lists+netdev@lfdr.de>; Fri, 13 Jun 2025 18:54:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CDAA97A4859
	for <lists+netdev@lfdr.de>; Fri, 13 Jun 2025 16:52:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3A6522068F;
	Fri, 13 Jun 2025 16:53:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uhxMggEH"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E05821C176
	for <netdev@vger.kernel.org>; Fri, 13 Jun 2025 16:53:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749833628; cv=none; b=kV9qZBEy8NLYctAKyMpfzH+NqGHcel4JJv9c5mMIMpFTsX+hgub9KrPOHP0T/1XKbtvALsIfkY11IOpiAifhyT6O9IuyQXTXn6RxFWY80XCZNPeOR4REv7FfYANY0nV8iTwBt/waBTaV+ZBUSFmP6+lsVxXqyvfizWIjm6DfM48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749833628; c=relaxed/simple;
	bh=3PdsJA+jsNuQxw55IJtvLXFKtdhrC9plxU1PVZl6D/g=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OJEmYF0WYbHZZnYBrUoFp2C/lDPdQ8U28JbgoMLSmaE+VFQNehXtgUkmW89S10Uj+2KJEefTMIb1dr9XPwFqtCT50U9Ncei73ezDkpEgzpr3MP/d5A2bnwcfP/w94VtWAQQYp6KqtVaHVv3s/klaLJeTjJf5hOlIj/mYylnC4CA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uhxMggEH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF11BC4CEF2;
	Fri, 13 Jun 2025 16:53:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749833628;
	bh=3PdsJA+jsNuQxw55IJtvLXFKtdhrC9plxU1PVZl6D/g=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=uhxMggEHWR9sQ8Ilc/Q7x2wqbJGi5uPzPnqcTRTBu80LSFvYFbbm6LYhamGgB8E9j
	 G/opEpFLSx91KpzVE1sHdPcl4FYQiF6AR6mj4+kMpLb5YmYLOD/0Vwo3CsAbLF7VxB
	 Mo4V4nWUcs12EPhsDNQGokSoVCJrNJvQmIdHSbkIm6WySVOZyZ2whnJDiucIZnTptL
	 Nkbq5c6HzwsusgkDnQqSZe3n1FVDf59fPV3RKGv+LRYlZ59fLAHVS3RueUPQgOwJn/
	 AOPifZZcU45M6zey8/rYk2zzSfXLQ8rqSVCuiDhvecECEWXRzsFUDK1P+X9MfN2KrT
	 pzYJ6QyNTQSNg==
Date: Fri, 13 Jun 2025 09:53:47 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Petr Machata <petrm@nvidia.com>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, David Ahern
 <dsahern@gmail.com>, <netdev@vger.kernel.org>, Simon Horman
 <horms@kernel.org>, Nikolay Aleksandrov <razor@blackwall.org>, Ido Schimmel
 <idosch@nvidia.com>, <mlxsw@nvidia.com>
Subject: Re: [PATCH net-next v2 08/14] net: ipv6: ip6mr: Extract a helper
 out of ip6mr_forward2()
Message-ID: <20250613095347.59328a33@kernel.org>
In-Reply-To: <0bef079626b34bc6531d83d79e0fd5c056ee17da.1749757582.git.petrm@nvidia.com>
References: <cover.1749757582.git.petrm@nvidia.com>
	<0bef079626b34bc6531d83d79e0fd5c056ee17da.1749757582.git.petrm@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 12 Jun 2025 22:10:42 +0200 Petr Machata wrote:
> -static int ip6mr_forward2(struct net *net, struct mr_table *mrt,
> -			  struct sk_buff *skb, int vifi)
> +static int ip6mr_prepare_xmit(struct net *net, struct mr_table *mrt,
> +			      struct sk_buff *skb, int vifi)
>  {
>  	struct vif_device *vif = &mrt->vif_table[vifi];
> -	struct net_device *indev = skb->dev;
>  	struct net_device *vif_dev;
>  	struct ipv6hdr *ipv6h;
>  	struct dst_entry *dst;
> @@ -2098,6 +2097,20 @@ static int ip6mr_forward2(struct net *net, struct mr_table *mrt,
>  
>  	ipv6h = ipv6_hdr(skb);
>  	ipv6h->hop_limit--;
> +	return 0;
> +
> +out_free:
> +	kfree_skb(skb);
> +	return -1;
> +}

ipmr_prepare_xmit() does not free the skb on error, and ip6mr_prepare_xmit() 
does. The v6 version does lead to slightly cleaner code, but I wonder
if its worth the asymmetry ?

