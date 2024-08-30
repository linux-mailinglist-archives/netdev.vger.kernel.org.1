Return-Path: <netdev+bounces-123909-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FB6B966CD8
	for <lists+netdev@lfdr.de>; Sat, 31 Aug 2024 01:26:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AAF141C215EB
	for <lists+netdev@lfdr.de>; Fri, 30 Aug 2024 23:26:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1FF817CA14;
	Fri, 30 Aug 2024 23:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y3LN7mT1"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C71ED14AD38;
	Fri, 30 Aug 2024 23:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725060388; cv=none; b=XrG0x4khILdV/mOKj8TDDXmDRCr+JxPP2zI0XADEjLQ3aKAhOG9X2V6JcjNwJC2Zn8J+5VOHrw5N6TuHYobHaFJiDjgMAqz9Xn2eN5dlFslGxr9zPSVU8mNTtDjS5QmUPH6+mJfA3FIoX1Sqt50WreDyvQXwrHgmYsHRL/6+qlY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725060388; c=relaxed/simple;
	bh=B1lxX5kx/pRgQTr/nfedq3NCGTk/erq9S7m4Oaz9L2I=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RPv6c7b9Xk3NnhjfKDXXPKi9enI2ZAy8AJ9RfZcfZRY/FRuEv3gP5oB0hAZvGWbCmuR5H+MTVLVwZwy4tOA2KA7elVKH2UtwUh0ygIiQ///R/7vNVSaWOFUUIf3t6h9puFHJRW7uIVJCA9K9TX/xne79IujMM79klAGcbbo7M30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y3LN7mT1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE8F7C4CEC2;
	Fri, 30 Aug 2024 23:26:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725060388;
	bh=B1lxX5kx/pRgQTr/nfedq3NCGTk/erq9S7m4Oaz9L2I=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Y3LN7mT1+zPLUeorhh96n+7HJ3AJYPhIA4gDumZJ+MndteF6tOkIeOC0Gfh0egktp
	 UjWUS8NtseeYvb0Do9hwGTeIGMWAB2e+dZ5/ZkU4UqBJIqmAEDoBzrm7+epzAaOU2P
	 KfdaFTv3pyhBXdCCe/y1+bEg5sGdbsiI79F5R9mnMm3XZCcE7sXVO05i14LoUvKkDO
	 JLttT7BmGcUPXsWUgWKHXP7S7tMLBnTS9vldFa044AoBRqlYp2W07PI2BDSKmS+rSy
	 cD5gHL10jldnvYSOxuS4OIJWCU1Anwq6z+ALP3dm60IOR+zCl2AQBpBLIDWnjtOxFG
	 qmIfxcLj0JbaQ==
Date: Fri, 30 Aug 2024 16:26:27 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Menglong Dong <menglong8.dong@gmail.com>
Cc: idosch@nvidia.com, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, dsahern@kernel.org, dongml2@chinatelecom.cn,
 amcohen@nvidia.com, gnault@redhat.com, bpoirier@nvidia.com,
 b.galvani@gmail.com, razor@blackwall.org, petrm@nvidia.com,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH net-next v2 06/12] net: vxlan: make vxlan_set_mac()
 return drop reasons
Message-ID: <20240830162627.4ba37aa3@kernel.org>
In-Reply-To: <20240830020001.79377-7-dongml2@chinatelecom.cn>
References: <20240830020001.79377-1-dongml2@chinatelecom.cn>
	<20240830020001.79377-7-dongml2@chinatelecom.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 30 Aug 2024 09:59:55 +0800 Menglong Dong wrote:
> -static bool vxlan_set_mac(struct vxlan_dev *vxlan,
> -			  struct vxlan_sock *vs,
> -			  struct sk_buff *skb, __be32 vni)
> +static enum skb_drop_reason vxlan_set_mac(struct vxlan_dev *vxlan,
> +					  struct vxlan_sock *vs,
> +					  struct sk_buff *skb, __be32 vni)
>  {
>  	union vxlan_addr saddr;
>  	u32 ifindex = skb->dev->ifindex;
> @@ -1620,7 +1620,7 @@ static bool vxlan_set_mac(struct vxlan_dev *vxlan,
>  
>  	/* Ignore packet loops (and multicast echo) */
>  	if (ether_addr_equal(eth_hdr(skb)->h_source, vxlan->dev->dev_addr))
> -		return false;
> +		return (u32)VXLAN_DROP_INVALID_SMAC;

It's the MAC address of the local interface, not just invalid...

>  	/* Get address from the outer IP header */
>  	if (vxlan_get_sk_family(vs) == AF_INET) {
> @@ -1635,9 +1635,9 @@ static bool vxlan_set_mac(struct vxlan_dev *vxlan,
>  
>  	if ((vxlan->cfg.flags & VXLAN_F_LEARN) &&
>  	    vxlan_snoop(skb->dev, &saddr, eth_hdr(skb)->h_source, ifindex, vni))
> -		return false;
> +		return (u32)VXLAN_DROP_ENTRY_EXISTS;

... because it's vxlan_snoop() that checks:

        if (!is_valid_ether_addr(src_mac))
-- 
pw-bot: cr

