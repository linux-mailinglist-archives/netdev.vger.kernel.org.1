Return-Path: <netdev+bounces-229675-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 507A5BDF997
	for <lists+netdev@lfdr.de>; Wed, 15 Oct 2025 18:14:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8B7A254272E
	for <lists+netdev@lfdr.de>; Wed, 15 Oct 2025 16:12:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4ED463375A1;
	Wed, 15 Oct 2025 16:12:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VFfzR8W8"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23978335BCB;
	Wed, 15 Oct 2025 16:12:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760544752; cv=none; b=l6DjilU8PyyxRAfLI8QktDAh6LVVyaKXelUgBC1v/bqjv5ZpooKadpv18lXkM2+Seaf+kwCqbO22vX7dxl7jkcJtUyGt0CqcrJ59ByX625OSo/p/q6x3UTFNkIrlnEVqNW6JXWhvjz57SJMf9WxABsvDw2Xg30lOnjejFsrIxX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760544752; c=relaxed/simple;
	bh=u6Wkdm2r1xLEd5GhkWdDZmkppsZyOO81BxcM2sb1/a8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DrcNFowe9QQduZtblz2NB08xzW8TmU77+264m4vbtJDLh8DsCFWfhMN/ckxKM6+g7zsX+pwikFo5qAebAfOY0nk7ZLiudziJOWewMBZib6Hl+WHWUIuQiUqYFkH81phNbc69kiSumziMmSRDGU2ZCx5j2+tsrnSTRZxMrdb6J9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VFfzR8W8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA719C4CEF8;
	Wed, 15 Oct 2025 16:12:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760544751;
	bh=u6Wkdm2r1xLEd5GhkWdDZmkppsZyOO81BxcM2sb1/a8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VFfzR8W80gEabOYattjVBWykE/ZZNiKDxm59H7O5UW5MwH45Jd8UxxnNcLG50ADo+
	 SxVhb3ZwJcRRcYCmhBuA68sEIYxZ5kkpE/zWZLrfHEZ33aYYi38Mv/vtcsRFIZAWb9
	 XzM3+676ZmlTDSHAZS/EclV2MgMOg2KcPRYgv75jfwdxs0o78IJwkaO7MDAyU7FPEq
	 eatDEmOLmYvaQM/w5exPl+tza72zUUy//DvrCDvXMFFUKFIXKOSQbxW8ImEZds+z33
	 qOYc6O1aZ4ik/7pANt6GaXz+vK3VeuLPAUBEFVFAEbIEnMQAvNJbUpivo5a623miWV
	 iluUJYaaQSpjw==
Date: Wed, 15 Oct 2025 17:12:27 +0100
From: Simon Horman <horms@kernel.org>
To: Jonas Gorski <jonas.gorski@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	=?utf-8?B?w4FsdmFybyBGZXJuw6FuZGV6?= Rojas <noltari@gmail.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] net: dsa: tag_brcm: legacy: fix untagged rx on
 unbridged ports for bcm63xx
Message-ID: <aO_H6187Oahh24IX@horms.kernel.org>
References: <20251015070854.36281-1-jonas.gorski@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251015070854.36281-1-jonas.gorski@gmail.com>

On Wed, Oct 15, 2025 at 09:08:54AM +0200, Jonas Gorski wrote:
> The internal switch on BCM63XX SoCs will unconditionally add 802.1Q VLAN
> tags on egress to CPU when 802.1Q mode is enabled. We do this
> unconditionally since commit ed409f3bbaa5 ("net: dsa: b53: Configure
> VLANs while not filtering").
> 
> This is fine for VLAN aware bridges, but for standalone ports and vlan
> unaware bridges this means all packets are tagged with the default VID,
> which is 0.
> 
> While the kernel will treat that like untagged, this can break userspace
> applications processing raw packets, expecting untagged traffic, like
> STP daemons.
> 
> This also breaks several bridge tests, where the tcpdump output then
> does not match the expected output anymore.
> 
> Since 0 isn't a valid VID, just strip out the VLAN tag if we encounter
> it, unless the priority field is set, since that would be a valid tag
> again.
> 
> Fixes: 964dbf186eaa ("net: dsa: tag_brcm: add support for legacy tags")
> Signed-off-by: Jonas Gorski <jonas.gorski@gmail.com>

...

> @@ -237,8 +239,14 @@ static struct sk_buff *brcm_leg_tag_rcv(struct sk_buff *skb,
>  	if (!skb->dev)
>  		return NULL;
>  
> -	/* VLAN tag is added by BCM63xx internal switch */
> -	if (netdev_uses_dsa(skb->dev))
> +	/* The internal switch in BCM63XX SoCs will add a 802.1Q VLAN tag on
> +	 * egress to the CPU port for all packets, regardless of the untag bit
> +	 * in the VLAN table.  VID 0 is used for untagged traffic on unbridged
> +	 * ports and vlan unaware bridges. If we encounter a VID 0 tagged
> +	 * packet, we know it is supposed to be untagged, so strip the VLAN
> +	 * tag as well in that case.

Maybe it isn't important, but here it is a TCI 0 that is being checked:
VID 0, PCP 0, and DEI 0.

> +	 */
> +	if (proto[0] == htons(ETH_P_8021Q) && proto[1] == 0)
>  		len += VLAN_HLEN;
>  
>  	/* Remove Broadcom tag and update checksum */
> 
> base-commit: 7f0fddd817ba6daebea1445ae9fab4b6d2294fa8
> -- 
> 2.43.0
> 

