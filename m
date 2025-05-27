Return-Path: <netdev+bounces-193583-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 949D7AC4A5E
	for <lists+netdev@lfdr.de>; Tue, 27 May 2025 10:38:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0BAE97A5CF3
	for <lists+netdev@lfdr.de>; Tue, 27 May 2025 08:36:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42FAE248F52;
	Tue, 27 May 2025 08:38:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="L/Wu17Ru"
X-Original-To: netdev@vger.kernel.org
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B88B8F50F;
	Tue, 27 May 2025 08:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748335085; cv=none; b=Av4EKeWmmGTcjYZBW813EVVC19S8mXFnIPIJ/Pg1fI7ER+00pLmSKNT4sJH8Hy77TRCj30zQbNKwzzp3DiIwck4I6C4Dx29yqgzY7EQazToGJ1qgyqglPcOOdYQ91g/jWT0AAi2ccDtxnmei3KylNvubek9O5+8ZQPXzxdCLhtg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748335085; c=relaxed/simple;
	bh=fYlFSLt2vWp0kd5ClMXYMsn4v04SxfbL1CjlQ6KQMfQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=O0tMqF8QX5hev8FcLfsaRxR9JyR91Hg1LJj6wiuQu5zhr5psGP0ToA1Vsiw9zRKNVIyUrxjdIPY1l7POylXjoODTCBXKzz5GdRajozSbhe+BioYtens60B7q1xV87uPlldJ/PL9PZ23lylYsyqZx/dyZhmGwtHfJc3GkZi9N6vM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=L/Wu17Ru; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 02F214396A;
	Tue, 27 May 2025 08:37:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1748335075;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OpM/KDvQBRopReoEwTUtRipcq4oHwuOqxwS8jNYE+N4=;
	b=L/Wu17RuqmXs2iCJTa6K4FkUaFxFVCNWTU0ikfQjdsDA5jeQUShmeA+w007rzYIrlWOxer
	B7k/TE5akU9QTTeEFmPF+gSxCb9h4kH7lioU6oZJVYVaWm12xTPyhHFlfxPIlxhEiAO++e
	crltFxBXlCoiOODANBDPV/gcGUZFlpu5U3j92Ku4cg8zq8LmiONFVy256H9HRXRqlhuJKL
	8CEJ8x8XA5dsLBZaf3tzQtk//pYU9pARY8KJsU+bL6KZoQl4GUDbckkpqPpH8rEaT1J6X4
	koyzY6gP6IcGAo41o9xB9uVq65nCx7bqisT4i1BXiH4K1LgsTteJJwCoYW9iRQ==
Date: Tue, 27 May 2025 10:37:49 +0200
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: Horatiu Vultur <horatiu.vultur@microchip.com>
Cc: <UNGLinuxDriver@microchip.com>, <andrew+netdev@lunn.ch>,
 <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
 <pabeni@redhat.com>, <netdev@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net] net: lan966x: Make sure to insert the vlan tags
 also in host mode
Message-ID: <20250527103749.66505756@2a02-8440-d111-2026-8d50-1f4f-0da2-e170.rev.sfr.net>
In-Reply-To: <20250527070850.3504582-1-horatiu.vultur@microchip.com>
References: <20250527070850.3504582-1-horatiu.vultur@microchip.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddtgdduleelvdculddtuddrgeefvddrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkjghfohfogggtgfesthejfedtredtvdenucfhrhhomhepofgrgihimhgvucevhhgvvhgrlhhlihgvrhcuoehmrgigihhmvgdrtghhvghvrghllhhivghrsegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpeehteevfeeivdekjeefkeekffefgfdtudetjeehkeegieelheekgfefgfevveffhfenucfkphepledvrdekkedrudejtddriedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepledvrdekkedrudejtddriedtpdhhvghlohepvdgrtddvqdekgeegtddqugduudduqddvtddviedqkeguhedtqddufhegfhdqtdgurgdvqdgvudejtddrrhgvvhdrshhfrhdrnhgvthdpmhgrihhlfhhrohhmpehmrgigihhmvgdrtghhvghvrghllhhivghrsegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopeelpdhrtghpthhtohephhhorhgrthhiuhdrvhhulhhtuhhrsehmihgtrhhotghhihhprdgtohhmpdhrtghpthhtohepfgfpiffnihhnuhigffhrihhvvghrsehmihgtrhhotghhihhprdgtohhmpdhrtghpthhtoheprghnughrvgifo
 dhnvghtuggvvheslhhunhhnrdgthhdprhgtphhtthhopegurghvvghmsegurghvvghmlhhofhhtrdhnvghtpdhrtghpthhtohepvgguuhhmrgiivghtsehgohhoghhlvgdrtghomhdprhgtphhtthhopehkuhgsrgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphgrsggvnhhisehrvgguhhgrthdrtghomhdprhgtphhtthhopehnvghtuggvvhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-GND-Sasl: maxime.chevallier@bootlin.com

Hello Horatiu,

On Tue, 27 May 2025 09:08:50 +0200
Horatiu Vultur <horatiu.vultur@microchip.com> wrote:

> When running these commands on DUT (and similar at the other end)
> ip link set dev eth0 up
> ip link add link eth0 name eth0.10 type vlan id 10
> ip addr add 10.0.0.1/24 dev eth0.10
> ip link set dev eth0.10 up
> ping 10.0.0.2/24
> 
> The ping will fail.
> 
> The reason why is failing is because, the network interfaces for lan966x
> have a flag saying that the HW can insert the vlan tags into the
> frames(NETIF_F_HW_VLAN_CTAG_TX). Meaning that the frames that are
> transmitted don't have the vlan tag inside the skb data, but they have
> it inside the skb. We already get that vlan tag and put it in the IFH
> but the problem is that we don't configure the HW to rewrite the frame
> when the interface is in host mode.
> The fix consists in actually configuring the HW to insert the vlan tag
> if it is different than 0.
> 
> Fixes: 6d2c186afa5d ("net: lan966x: Add vlan support.")
> Signed-off-by: Horatiu Vultur <horatiu.vultur@microchip.com>
> ---
>  .../ethernet/microchip/lan966x/lan966x_main.c |  1 +
>  .../ethernet/microchip/lan966x/lan966x_main.h |  1 +
>  .../microchip/lan966x/lan966x_switchdev.c     |  1 +
>  .../ethernet/microchip/lan966x/lan966x_vlan.c | 21 +++++++++++++++++++
>  4 files changed, 24 insertions(+)
> 
> diff --git a/drivers/net/ethernet/microchip/lan966x/lan966x_main.c b/drivers/net/ethernet/microchip/lan966x/lan966x_main.c
> index 427bdc0e4908c..7001584f1b7a6 100644
> --- a/drivers/net/ethernet/microchip/lan966x/lan966x_main.c
> +++ b/drivers/net/ethernet/microchip/lan966x/lan966x_main.c
> @@ -879,6 +879,7 @@ static int lan966x_probe_port(struct lan966x *lan966x, u32 p,
>  	lan966x_vlan_port_set_vlan_aware(port, 0);
>  	lan966x_vlan_port_set_vid(port, HOST_PVID, false, false);
>  	lan966x_vlan_port_apply(port);
> +	lan966x_vlan_port_rew_host(port);
>  
>  	return 0;
>  }
> diff --git a/drivers/net/ethernet/microchip/lan966x/lan966x_main.h b/drivers/net/ethernet/microchip/lan966x/lan966x_main.h
> index 1f9df67f05044..4f75f06883693 100644
> --- a/drivers/net/ethernet/microchip/lan966x/lan966x_main.h
> +++ b/drivers/net/ethernet/microchip/lan966x/lan966x_main.h
> @@ -497,6 +497,7 @@ void lan966x_vlan_port_apply(struct lan966x_port *port);
>  bool lan966x_vlan_cpu_member_cpu_vlan_mask(struct lan966x *lan966x, u16 vid);
>  void lan966x_vlan_port_set_vlan_aware(struct lan966x_port *port,
>  				      bool vlan_aware);
> +void lan966x_vlan_port_rew_host(struct lan966x_port *port);
>  int lan966x_vlan_port_set_vid(struct lan966x_port *port,
>  			      u16 vid,
>  			      bool pvid,
> diff --git a/drivers/net/ethernet/microchip/lan966x/lan966x_switchdev.c b/drivers/net/ethernet/microchip/lan966x/lan966x_switchdev.c
> index 1c88120eb291a..bcb4db76b75cd 100644
> --- a/drivers/net/ethernet/microchip/lan966x/lan966x_switchdev.c
> +++ b/drivers/net/ethernet/microchip/lan966x/lan966x_switchdev.c
> @@ -297,6 +297,7 @@ static void lan966x_port_bridge_leave(struct lan966x_port *port,
>  	lan966x_vlan_port_set_vlan_aware(port, false);
>  	lan966x_vlan_port_set_vid(port, HOST_PVID, false, false);
>  	lan966x_vlan_port_apply(port);
> +	lan966x_vlan_port_rew_host(port);
>  }
>  
>  int lan966x_port_changeupper(struct net_device *dev,
> diff --git a/drivers/net/ethernet/microchip/lan966x/lan966x_vlan.c b/drivers/net/ethernet/microchip/lan966x/lan966x_vlan.c
> index fa34a739c748e..f158ec6ab10cc 100644
> --- a/drivers/net/ethernet/microchip/lan966x/lan966x_vlan.c
> +++ b/drivers/net/ethernet/microchip/lan966x/lan966x_vlan.c
> @@ -149,6 +149,27 @@ void lan966x_vlan_port_set_vlan_aware(struct lan966x_port *port,
>  	port->vlan_aware = vlan_aware;
>  }
>  
> +/* When the interface is in host mode, the interface should not be vlan aware
> + * but it should insert all the tags that it gets from the network stack.
> + * The tags are no in the data of the frame but actually in the skb and the ifh
                   not
> + * is confiured already to get this tag. So what we need to do is to update the
         configured
> + * rewriter to insert the vlan tag for all frames which have a vlan tag
> + * different than 0.

Just to be extra clear, the doc seems to say that

	REW_TAG_CFG_TAG_CFG_SET(1);

means "Tag all frames, except when VID=PORT_VLAN_CFG.PORT_VID or
VID=0."

Another setting for these bits are "Tag all frames except when VID=0",
which is what you document in the above comment.

In this case, is there any chance that it would make a difference ?

> + */
> +void lan966x_vlan_port_rew_host(struct lan966x_port *port)
> +{
> +	struct lan966x *lan966x = port->lan966x;
> +	u32 val;
> +
> +	/* Tag all frames except when VID == DEFAULT_VLAN */
> +	val = REW_TAG_CFG_TAG_CFG_SET(1);
> +
> +	/* Update only some bits in the register */
> +	lan_rmw(val,
> +		REW_TAG_CFG_TAG_CFG,
> +		lan966x, REW_TAG_CFG(port->chip_port));
> +}
> +
>  void lan966x_vlan_port_apply(struct lan966x_port *port)
>  {
>  	struct lan966x *lan966x = port->lan966x;

Sorry for the typo nitpicking, but with that :

Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>

Maxime

