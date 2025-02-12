Return-Path: <netdev+bounces-165568-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F1E1A32874
	for <lists+netdev@lfdr.de>; Wed, 12 Feb 2025 15:30:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8C217188B543
	for <lists+netdev@lfdr.de>; Wed, 12 Feb 2025 14:30:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96B5720FABB;
	Wed, 12 Feb 2025 14:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="LD7SkfO9"
X-Original-To: netdev@vger.kernel.org
Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD44020FA85;
	Wed, 12 Feb 2025 14:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739370590; cv=none; b=tL5NDqUEZa/PU34TZk2B0c2fLaSPuYxWK/3Q59HMNgvx4+0gJn+cvrKGMmpmW1u6xgx9evRlKFCNM1iDevWzRYcc6499aoK0Ri3sTom5hy3u0lGbC/dChrGbfGAW+t69SrlxLUeQxzLPVQChrT78wOf3dJWHnWyQX4TEpbXAdWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739370590; c=relaxed/simple;
	bh=VUUeUPQh1Fqb/o0nTY5L5XzwSrNwsrjQ/4e6Xs+ii4I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AK7ggHNwFZTjO8GhKzlQgx+2EtiKLAzadltd6Btm/Q6Dy6C6SX7L89hwbcghbWi348du7KnKzh7gL3envU7S4srYOBsfGHgigg6d7dLQiHLj2HJYVO1K9du+cdvk8jKvTxjxxdUIJncNIPIcMaYCqgfmuzdtIFDJu2zH7Q/nEDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=idosch.org; spf=none smtp.mailfrom=idosch.org; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=LD7SkfO9; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=idosch.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=idosch.org
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id A53311140177;
	Wed, 12 Feb 2025 09:29:47 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Wed, 12 Feb 2025 09:29:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1739370587; x=1739456987; bh=se8eRiep1x3pdAKW/NZ5Dm0QEQsx3rvUSYo
	OH4EnVuU=; b=LD7SkfO9CzC9mmEN11AsQZPOTnPAYwBA6iPWuTbFE7ACBBCS8ZC
	62mCTPBZ/eDpONAzGgK0tVRXzOv11ohPjCNqo+TnP/+w1zjf78wvJLLwoDIP5QBO
	x1TE83BYyanpLRj1smHMrt2vNTpTIKwt/clN0BqeFe5v7hAUx+qdJULynttF7qqW
	2qtZtm8qh2NPw2njE3aU5rXoudtnqjszjcEdLqrwiGXNX6t8FwObCZVRnIivuKM8
	jt8NF8o7Pg/IbWDBTelP7nebv9Am/Lby/J33c8dinplcqurWNiLN+1EkvdVGRHxQ
	PES8Vl4l5PFsI5bjLtnhUIs/D0tJt7WXBpQ==
X-ME-Sender: <xms:WrCsZx_kmQrbN9FztoJdc8wq35kfas-3Hm7yeMksO7hTw-ilFYjyXg>
    <xme:WrCsZ1sXBD0R-7pxOT__9AFx7LNRYItDGZGZQ61LTCufy7sX0WsYLFqklII1F8LRP
    AUZb_61cmtTFQg>
X-ME-Received: <xmr:WrCsZ_AL_hDaAaZhauMG-k9FMMc-g25g1FydBKimcveUcv5u6k9Fi01OF5xO>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeggedufecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddv
    necuhfhrohhmpefkughoucfutghhihhmmhgvlhcuoehiughoshgthhesihguohhstghhrd
    horhhgqeenucggtffrrghtthgvrhhnpeehhfdtjedviefffeduuddvffegteeiieeguefg
    udffvdfftdefheeijedthfejkeenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuve
    hluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepihguohhstghh
    sehiughoshgthhdrohhrghdpnhgspghrtghpthhtohepuddvpdhmohguvgepshhmthhpoh
    huthdprhgtphhtthhopehoshgtmhgrvghsledvsehgmhgrihhlrdgtohhmpdhrtghpthht
    ohepnhgvthguvghvsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepuggrvh
    gvmhesuggrvhgvmhhlohhfthdrnhgvthdprhgtphhtthhopegvughumhgriigvthesghho
    ohhglhgvrdgtohhmpdhrtghpthhtohepkhhusggrsehkvghrnhgvlhdrohhrghdprhgtph
    htthhopehprggsvghnihesrhgvughhrghtrdgtohhmpdhrtghpthhtohephhhorhhmshes
    khgvrhhnvghlrdhorhhgpdhrtghpthhtohepvhhirhhoseiivghnihhvrdhlihhnuhigrd
    horhhgrdhukhdprhgtphhtthhopehjihhrihesrhgvshhnuhhllhhirdhush
X-ME-Proxy: <xmx:WrCsZ1chCOFpyCNrg-rSnorAQQV_5mGq3_LAh_QX7mGGJ_vJ-CqZAw>
    <xmx:WrCsZ2Mg4oi3kvRpzSK7QK4sITJSCVwWdfjVFHFofrUjrQGh5infPA>
    <xmx:WrCsZ3lYi6ddP_9jiLdruk4zTQ3cL79wqnADIa25cNSu8ZORP_Rzdw>
    <xmx:WrCsZwvz-ncVjWJsmhXpAKcT4PM7Tnp10Seb5MDPSy-YNCKhOrar2Q>
    <xmx:W7CsZ3l7fFbOTq3wNZSOOjYxnhtMFbVaLiMH1uSrDxPnrUX-ps9xyV2Z>
Feedback-ID: i494840e7:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 12 Feb 2025 09:29:45 -0500 (EST)
Date: Wed, 12 Feb 2025 16:29:43 +0200
From: Ido Schimmel <idosch@idosch.org>
To: Oscar Maes <oscmaes92@gmail.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
	viro@zeniv.linux.org.uk, jiri@resnulli.us,
	linux-kernel@vger.kernel.org, security@kernel.org,
	syzbot <syzbot+91161fe81857b396c8a0@syzkaller.appspotmail.com>
Subject: Re: [PATCH net] net: 802: enforce underlying device type for GARP
 and MRP
Message-ID: <Z6ywV4OkFu52AB8P@shredder>
References: <20250212113218.9859-1-oscmaes92@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250212113218.9859-1-oscmaes92@gmail.com>

On Wed, Feb 12, 2025 at 12:32:18PM +0100, Oscar Maes wrote:
> When creating a VLAN device, we initialize GARP (garp_init_applicant)
> and MRP (mrp_init_applicant) for the underlying device.
> 
> As part of the initialization process, we add the multicast address of
> each applicant to the underlying device, by calling dev_mc_add.
> 
> __dev_mc_add uses dev->addr_len to determine the length of the new
> multicast address.
> 
> This causes an out-of-bounds read if dev->addr_len is greater than 6,
> since the multicast addresses provided by GARP and MRP are only 6 bytes
> long.
> 
> This behaviour can be reproduced using the following commands:
> 
> ip tunnel add gretest mode ip6gre local ::1 remote ::2 dev lo
> ip l set up dev gretest
> ip link add link gretest name vlantest type vlan id 100
> 
> Then, the following command will display the address of garp_pdu_rcv:
> 
> ip maddr show | grep 01:80:c2:00:00:21
> 
> Fix this by enforcing the type and address length of
> the underlying device during GARP and MRP initialization.
> 
> Fixes: 22bedad3ce11 ("net: convert multicast list to list_head")
> Reported-by: syzbot <syzbot+91161fe81857b396c8a0@syzkaller.appspotmail.com>
> Closes: https://lore.kernel.org/netdev/000000000000ca9a81061a01ec20@google.com/
> Signed-off-by: Oscar Maes <oscmaes92@gmail.com>
> ---
>  net/802/garp.c | 5 +++++
>  net/802/mrp.c  | 5 +++++
>  2 files changed, 10 insertions(+)
> 
> diff --git a/net/802/garp.c b/net/802/garp.c
> index 27f0ab146..2f383ee73 100644
> --- a/net/802/garp.c
> +++ b/net/802/garp.c
> @@ -9,6 +9,7 @@
>  #include <linux/skbuff.h>
>  #include <linux/netdevice.h>
>  #include <linux/etherdevice.h>
> +#include <linux/if_arp.h>
>  #include <linux/rtnetlink.h>
>  #include <linux/llc.h>
>  #include <linux/slab.h>
> @@ -574,6 +575,10 @@ int garp_init_applicant(struct net_device *dev, struct garp_application *appl)
>  
>  	ASSERT_RTNL();
>  
> +	err = -EINVAL;
> +	if (dev->type != ARPHRD_ETHER || dev->addr_len != ETH_ALEN)

Checking for 'ARPHRD_ETHER' is not enough? Other virtual devices such as
macsec, macvlan and ipvlan only look at 'dev->type' AFAICT.

Also, how about moving this to vlan_check_real_dev()? It's common to
both the IOCTL and netlink paths.

> +		goto err1;
> +
>  	if (!rtnl_dereference(dev->garp_port)) {
>  		err = garp_init_port(dev);
>  		if (err < 0)
> diff --git a/net/802/mrp.c b/net/802/mrp.c
> index e0c96d0da..1efee0b39 100644
> --- a/net/802/mrp.c
> +++ b/net/802/mrp.c
> @@ -12,6 +12,7 @@
>  #include <linux/skbuff.h>
>  #include <linux/netdevice.h>
>  #include <linux/etherdevice.h>
> +#include <linux/if_arp.h>
>  #include <linux/rtnetlink.h>
>  #include <linux/slab.h>
>  #include <linux/module.h>
> @@ -859,6 +860,10 @@ int mrp_init_applicant(struct net_device *dev, struct mrp_application *appl)
>  
>  	ASSERT_RTNL();
>  
> +	err = -EINVAL;
> +	if (dev->type != ARPHRD_ETHER || dev->addr_len != ETH_ALEN)
> +		goto err1;
> +
>  	if (!rtnl_dereference(dev->mrp_port)) {
>  		err = mrp_init_port(dev);
>  		if (err < 0)
> -- 
> 2.39.5
> 
> 

