Return-Path: <netdev+bounces-233343-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 270DCC122A2
	for <lists+netdev@lfdr.de>; Tue, 28 Oct 2025 01:29:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id A94A4353463
	for <lists+netdev@lfdr.de>; Tue, 28 Oct 2025 00:29:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 742F01DEFE8;
	Tue, 28 Oct 2025 00:28:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nBVvgoTc"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38FD21DF246
	for <netdev@vger.kernel.org>; Tue, 28 Oct 2025 00:28:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761611331; cv=none; b=FIN22W+1LhjMaqKZ4/8L5CcSGgRc5iXIrrGGzupxq5ZQXQRLA78lnvqo0KwQ01hW5Z3K2BuQEnB1jm1qN0vSXca4+H3y+oeT9+BN3Etr+2CCRDO+6ho/iV+mu9D+Os7iJm9D4uFdnRwdmrE+b3jnSaXnhf1NDSD+Ga8SCT9qCOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761611331; c=relaxed/simple;
	bh=cl48k9hLq+gC+j3JOSBp5ua9hSK03EmYRYvWziiIR7w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kTUvxfTpOYWOGzx6C3/1mWAmGZihwPeWdWYrKV3iPSJf2+wBg3SwJ4iZamwQP1352BPE6J865llrVW8bjneDKrejttOPp+iWFk2IL6biVjmSYAlHBwUYbOPISPDrnRypQP2iZjH0OIJdyza9l6C+TKhEg5aBJXoJAzbw2uYxWDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nBVvgoTc; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-63c215dce31so779720a12.3
        for <netdev@vger.kernel.org>; Mon, 27 Oct 2025 17:28:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761611327; x=1762216127; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=39BCJHstyTpVIXEdQO2ElQP/15XDo2uj2wZ3mUBTZHo=;
        b=nBVvgoTcdZVHpO2joN1YuJnIgMZ8HqkLuNCxV/YbOtGwur/CFSvdmWbzko3Cxr3fV5
         T3SkAn/JPMHQ/6usnXu06x5kulAuj5/SMuG5QfDiB5PS4BJ4o94/IWPpC2uIGNxcSnU5
         nGWKxpPyaL0P2ye8dL38JPp6iStqutH5sLNXMXbDra4tkZC9gy7wnF+qk4yKKdgvUeD+
         p+UFErPaTUlWkdxSG5p0zpOgvBbbIvsl2rHpY/I5/cuU2Nm6dfcnAvql6DyMQXLtmJyH
         hxmF/iTqANYC5JbCLTcQszFmfwB7kvxU6VFHVcLLUk9V/N7Pya6XmMcUfkkzEPkXrWK2
         4AYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761611327; x=1762216127;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=39BCJHstyTpVIXEdQO2ElQP/15XDo2uj2wZ3mUBTZHo=;
        b=Gd7K1cdEyMGMNbRJtDyYD8zLFG0Qo/XtDuEbidpYAv6ICiqwoZTHwhRanvxxJrXmG+
         3IoVG7Nav2QgIXeVvGKOy88sIDqjm2YySPA+h3fN1ORqPtVCOa7zlTdYkT41eaEag6yo
         lkV5K9GSPI0F/g+YIL646AGPMHnGvcVON2NWKB+DHHHwrj3Q4PeEoU5tjkAXJeJulAbB
         HPB5WnL5IhzaNBcnraF+BgzILzTRo9lbGD/AvqMfgjT3wAVU2BGRnRRTL6zCQSPxViGl
         MPHUeJnDabkMiaRWjIF0fnUMgvE6wPS4PxQx+qirXZVu960eAPQeeTz8jSMroEOHwEez
         kggg==
X-Forwarded-Encrypted: i=1; AJvYcCVIooRUq1KcJPCVE7ITUDElTCnTc4DFgyQF4jAc2exGLJZUm2zOCmMTT+vmZ3+ADKe4MwEMRpo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwPGmx3jR4hwSmpAObS9EP/pAi50oI2mFsZENYWMvhx1Mvt9FIy
	pM+r6hzW84U0h1o0KZk5s0QKUjmXwVRuYL1Bx2jy5QttRJZZMK2f2oiH
X-Gm-Gg: ASbGncu4BMGHFFybU29/fi7fHC65Tq8X97jfWi1hAgCpQNyNMk1M019D586R/q4U9Qt
	E/ynkqrhlKoOLWsGs8M2W7/PH5CGIz+JsoCCGsIHpuE+btIBtqz7uPrXjiJkzkNu/rVSVidR6in
	K5ZLNIzIhJg+wMLx22ftwtcvp9rv1vVY4M2JEKZ1sc8RUbUOFCBF9fqrNZx1uhiLEOEtfw/9FVV
	PZkPAzmWHMVuf/ZMeshY5wsQFtP/49L1JPEqIQDyWiPv5/tzoI8EDT2r3anS+jZZbYHC25qnAiQ
	wibkkcQU+NbTKvUJVph3oWneTzOKjeZNQzP+cZBP3N8IZB/juVncCuH3JavgQVG3Qu8lC+8+NU8
	Vi1iMI90E3bx+VLLE2Qo6RwdfK3N/RmUl8TmP3+63EQ/KzLZJiLrcBKmuMLrsKK1hAW8ATanD30
	DRoZY=
X-Google-Smtp-Source: AGHT+IHDFVEfUV8Bbx0tMqjktqrTc2zv6dp5P5g4W+bcrA3kjX4INhnWDAo7g1HDIKxwZV4TwWunRw==
X-Received: by 2002:a05:6402:34c8:b0:639:eed9:14ce with SMTP id 4fb4d7f45d1cf-63ed84df870mr859103a12.8.1761611327204;
        Mon, 27 Oct 2025 17:28:47 -0700 (PDT)
Received: from skbuf ([2a02:2f04:d406:ee00:3eb9:f316:6516:8b90])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-63e7efd0c1fsm7533099a12.37.2025.10.27.17.28.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Oct 2025 17:28:45 -0700 (PDT)
Date: Tue, 28 Oct 2025 02:28:41 +0200
From: Vladimir Oltean <olteanv@gmail.com>
To: Daniel Golle <daniel@makrotopia.org>
Cc: Hauke Mehrtens <hauke@hauke-m.de>, Andrew Lunn <andrew@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Simon Horman <horms@kernel.org>,
	Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Andreas Schirm <andreas.schirm@siemens.com>,
	Lukas Stockmann <lukas.stockmann@siemens.com>,
	Alexander Sverdlin <alexander.sverdlin@siemens.com>,
	Peter Christen <peter.christen@siemens.com>,
	Avinash Jayaraman <ajayaraman@maxlinear.com>,
	Bing tao Xu <bxu@maxlinear.com>, Liang Xu <lxu@maxlinear.com>,
	Juraj Povazanec <jpovazanec@maxlinear.com>,
	"Fanni (Fang-Yi) Chan" <fchan@maxlinear.com>,
	"Benny (Ying-Tsan) Weng" <yweng@maxlinear.com>,
	"Livia M. Rosu" <lrosu@maxlinear.com>,
	John Crispin <john@phrozen.org>
Subject: Re: [PATCH net-next v3 11/12] net: dsa: add tagging driver for
 MaxLinear GSW1xx switch family
Message-ID: <20251028002841.zja7km3oesczrlo3@skbuf>
References: <cover.1761521845.git.daniel@makrotopia.org>
 <cover.1761521845.git.daniel@makrotopia.org>
 <81815f0c5616d8b1fe47ec9e292755b38c42e491.1761521845.git.daniel@makrotopia.org>
 <81815f0c5616d8b1fe47ec9e292755b38c42e491.1761521845.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <81815f0c5616d8b1fe47ec9e292755b38c42e491.1761521845.git.daniel@makrotopia.org>
 <81815f0c5616d8b1fe47ec9e292755b38c42e491.1761521845.git.daniel@makrotopia.org>

On Sun, Oct 26, 2025 at 11:48:23PM +0000, Daniel Golle wrote:
> Add support for a new DSA tagging protocol driver for the MaxLinear
> GSW1xx switch family. The GSW1xx switches use a proprietary 8-byte
> special tag inserted between the source MAC address and the EtherType
> field to indicate the source and destination ports for frames
> traversing the CPU port.
> 
> Implement the tag handling logic to insert the special tag on transmit
> and parse it on receive.
> 
> Signed-off-by: Daniel Golle <daniel@makrotopia.org>
> ---
> since RFC:
>  * use dsa etype header macros instead of open coding them
>  * maintain alphabetic order in Kconfig and Makefile
> 
>  MAINTAINERS              |   3 +-
>  include/net/dsa.h        |   2 +
>  net/dsa/Kconfig          |   8 +++
>  net/dsa/Makefile         |   1 +
>  net/dsa/tag_mxl-gsw1xx.c | 141 +++++++++++++++++++++++++++++++++++++++
>  5 files changed, 154 insertions(+), 1 deletion(-)
>  create mode 100644 net/dsa/tag_mxl-gsw1xx.c
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index d652f4f27756..4ddff0b0a547 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -14038,7 +14038,7 @@ F:	tools/testing/selftests/landlock/
>  K:	landlock
>  K:	LANDLOCK
>  
> -LANTIQ / INTEL Ethernet drivers
> +LANTIQ / MAXLINEAR / INTEL Ethernet DSA drivers
>  M:	Hauke Mehrtens <hauke@hauke-m.de>
>  L:	netdev@vger.kernel.org
>  S:	Maintained
> @@ -14046,6 +14046,7 @@ F:	Documentation/devicetree/bindings/net/dsa/lantiq,gswip.yaml
>  F:	drivers/net/dsa/lantiq/*
>  F:	drivers/net/ethernet/lantiq_xrx200.c
>  F:	net/dsa/tag_gswip.c
> +F:	net/dsa/tag_mxl-gsw1xx.c
>  
>  LANTIQ MIPS ARCHITECTURE
>  M:	John Crispin <john@phrozen.org>
> diff --git a/include/net/dsa.h b/include/net/dsa.h
> index 67762fdaf3c7..2df2e2ead9a8 100644
> --- a/include/net/dsa.h
> +++ b/include/net/dsa.h
> @@ -56,6 +56,7 @@ struct tc_action;
>  #define DSA_TAG_PROTO_VSC73XX_8021Q_VALUE	28
>  #define DSA_TAG_PROTO_BRCM_LEGACY_FCS_VALUE	29
>  #define DSA_TAG_PROTO_YT921X_VALUE		30
> +#define DSA_TAG_PROTO_MXL_GSW1XX_VALUE		31
>  
>  enum dsa_tag_protocol {
>  	DSA_TAG_PROTO_NONE		= DSA_TAG_PROTO_NONE_VALUE,
> @@ -89,6 +90,7 @@ enum dsa_tag_protocol {
>  	DSA_TAG_PROTO_LAN937X		= DSA_TAG_PROTO_LAN937X_VALUE,
>  	DSA_TAG_PROTO_VSC73XX_8021Q	= DSA_TAG_PROTO_VSC73XX_8021Q_VALUE,
>  	DSA_TAG_PROTO_YT921X		= DSA_TAG_PROTO_YT921X_VALUE,
> +	DSA_TAG_PROTO_MXL_GSW1XX	= DSA_TAG_PROTO_MXL_GSW1XX_VALUE,
>  };
>  
>  struct dsa_switch;
> diff --git a/net/dsa/Kconfig b/net/dsa/Kconfig
> index 6b94028b1fcc..f86b30742122 100644
> --- a/net/dsa/Kconfig
> +++ b/net/dsa/Kconfig
> @@ -104,6 +104,14 @@ config NET_DSA_TAG_MTK
>  	  Say Y or M if you want to enable support for tagging frames for
>  	  Mediatek switches.
>  
> +config NET_DSA_TAG_MXL_GSW1XX
> +	tristate "Tag driver for MaxLinear GSW1xx switches"
> +	help
> +	  The GSW1xx family of switches supports an 8-byte special tag which
> +	  can be used on the CPU port of the switch.
> +	  Say Y or M if you want to enable support for tagging frames for
> +	  MaxLinear GSW1xx switches.
> +
>  config NET_DSA_TAG_KSZ
>  	tristate "Tag driver for Microchip 8795/937x/9477/9893 families of switches"
>  	help
> diff --git a/net/dsa/Makefile b/net/dsa/Makefile
> index 4b011a1d5c87..42d173f5a701 100644
> --- a/net/dsa/Makefile
> +++ b/net/dsa/Makefile
> @@ -28,6 +28,7 @@ obj-$(CONFIG_NET_DSA_TAG_HELLCREEK) += tag_hellcreek.o
>  obj-$(CONFIG_NET_DSA_TAG_KSZ) += tag_ksz.o
>  obj-$(CONFIG_NET_DSA_TAG_LAN9303) += tag_lan9303.o
>  obj-$(CONFIG_NET_DSA_TAG_MTK) += tag_mtk.o
> +obj-$(CONFIG_NET_DSA_TAG_MXL_GSW1XX) += tag_mxl-gsw1xx.o
>  obj-$(CONFIG_NET_DSA_TAG_NONE) += tag_none.o
>  obj-$(CONFIG_NET_DSA_TAG_OCELOT) += tag_ocelot.o
>  obj-$(CONFIG_NET_DSA_TAG_OCELOT_8021Q) += tag_ocelot_8021q.o
> diff --git a/net/dsa/tag_mxl-gsw1xx.c b/net/dsa/tag_mxl-gsw1xx.c
> new file mode 100644
> index 000000000000..9efec6deb494
> --- /dev/null
> +++ b/net/dsa/tag_mxl-gsw1xx.c
> @@ -0,0 +1,141 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * DSA driver Special Tag support for MaxLinear GSW1xx switch chips
> + *
> + * Copyright (C) 2025 Daniel Golle <daniel@makrotopia.org>
> + * Copyright (C) 2023 - 2024 MaxLinear Inc.
> + */
> +
> +#include <linux/bitops.h>
> +#include <linux/etherdevice.h>
> +#include <linux/skbuff.h>
> +#include <net/dsa.h>
> +
> +#include "tag.h"
> +
> +/* To define the outgoing port and to discover the incoming port a special
> + * tag is used by the GSW1xx.
> + *
> + *       Dest MAC       Src MAC    special TAG        EtherType
> + * ...| 1 2 3 4 5 6 | 1 2 3 4 5 6 | 1 2 3 4 5 6 7 8 | 1 2 |...
> + *                                |<--------------->|
> + */
> +
> +#define GSW1XX_TAG_NAME		"gsw1xx"
> +
> +/* special tag in TX path header */
> +#define GSW1XX_TX_HEADER_LEN	8
> +
> +/* Byte 0 = Ethertype byte 1 -> 0x88 */
> +/* Byte 1 = Ethertype byte 2 -> 0xC3*/
> +
> +/* Byte 2 */
> +#define GSW1XX_TX_PORT_MAP_EN		BIT(7)
> +#define GSW1XX_TX_CLASS_EN		BIT(6)
> +#define GSW1XX_TX_TIME_STAMP_EN		BIT(5)
> +#define GSW1XX_TX_LRN_DIS		BIT(4)
> +#define GSW1XX_TX_CLASS_SHIFT		0
> +#define GSW1XX_TX_CLASS_MASK		GENMASK(3, 0)

Using FIELD_PREP() would eliminate these _SHIFT definitions and _MASK
would also go away from the macro names.

> +
> +/* Byte 3 */
> +#define GSW1XX_TX_PORT_MAP_LOW_SHIFT	0
> +#define GSW1XX_TX_PORT_MAP_LOW_MASK	GENMASK(7, 0)
> +
> +/* Byte 4 */
> +#define GSW1XX_TX_PORT_MAP_HIGH_SHIFT	0
> +#define GSW1XX_TX_PORT_MAP_HIGH_MASK	GENMASK(7, 0)
> +
> +#define GSW1XX_RX_HEADER_LEN		8

Usually you use two separate macros when the lengths are not equal, and
you set .needed_headroom to the largest value.

> +
> +/* special tag in RX path header */
> +/* Byte 4 */
> +#define GSW1XX_RX_PORT_MAP_LOW_SHIFT	0
> +#define GSW1XX_RX_PORT_MAP_LOW_MASK	GENMASK(7, 0)
> +
> +/* Byte 5 */
> +#define GSW1XX_RX_PORT_MAP_HIGH_SHIFT	0
> +#define GSW1XX_RX_PORT_MAP_HIGH_MASK	GENMASK(7, 0)
> +
> +static struct sk_buff *gsw1xx_tag_xmit(struct sk_buff *skb,
> +				       struct net_device *dev)
> +{
> +	struct dsa_port *dp = dsa_user_to_port(dev);
> +	u8 *gsw1xx_tag;
> +
> +	/* provide additional space 'GSW1XX_TX_HEADER_LEN' bytes */
> +	skb_push(skb, GSW1XX_TX_HEADER_LEN);
> +
> +	/* add space between MAC address and Ethertype */
> +	dsa_alloc_etype_header(skb, GSW1XX_TX_HEADER_LEN);
> +
> +	/* special tag ingress */
> +	gsw1xx_tag = dsa_etype_header_pos_tx(skb);
> +	gsw1xx_tag[0] = 0x88;
> +	gsw1xx_tag[1] = 0xc3;

Could you write this as a u16 pointer, to make it obvious to everyone
it's an EtherType, and define the EtherType constant in
include/uapi/linux/if_ether.h, to make it a bit more visible that it's
in use?

> +	gsw1xx_tag[2] = GSW1XX_TX_PORT_MAP_EN | GSW1XX_TX_LRN_DIS;
> +	gsw1xx_tag[3] = BIT(dp->index + GSW1XX_TX_PORT_MAP_LOW_SHIFT) &
> +			GSW1XX_TX_PORT_MAP_LOW_MASK;
> +	gsw1xx_tag[4] = 0;
> +	gsw1xx_tag[5] = 0;
> +	gsw1xx_tag[6] = 0;
> +	gsw1xx_tag[7] = 0;
> +
> +	return skb;
> +}
> +
> +static struct sk_buff *gsw1xx_tag_rcv(struct sk_buff *skb,
> +				      struct net_device *dev)
> +{
> +	int port;
> +	u8 *gsw1xx_tag;
> +
> +	if (unlikely(!pskb_may_pull(skb, GSW1XX_RX_HEADER_LEN))) {
> +		dev_warn_ratelimited(&dev->dev, "Dropping packet, cannot pull SKB\n");
> +		return NULL;
> +	}
> +
> +	gsw1xx_tag = dsa_etype_header_pos_rx(skb);
> +
> +	if (gsw1xx_tag[0] != 0x88 && gsw1xx_tag[1] != 0xc3) {
> +		dev_warn_ratelimited(&dev->dev, "Dropping packet due to invalid special tag\n");
> +		dev_warn_ratelimited(&dev->dev,
> +				     "Tag: 0x%x, 0x%x, 0x%x, 0x%x, 0x%x, 0x%x, 0x%x, 0x%x\n",
> +				     gsw1xx_tag[0], gsw1xx_tag[1], gsw1xx_tag[2], gsw1xx_tag[3],
> +				     gsw1xx_tag[4], gsw1xx_tag[5], gsw1xx_tag[6], gsw1xx_tag[7]);

I think you could print the tag with %*ph, according to
https://elixir.bootlin.com/linux/v6.17.5/source/lib/vsprintf.c#L2453
(needs testing)

> +		return NULL;
> +	}
> +
> +	/* Get source port information */
> +	port = (gsw1xx_tag[2] & GSW1XX_RX_PORT_MAP_LOW_MASK) >> GSW1XX_RX_PORT_MAP_LOW_SHIFT;
> +	skb->dev = dsa_conduit_find_user(dev, 0, port);
> +	if (!skb->dev) {
> +		dev_warn_ratelimited(&dev->dev, "Dropping packet due to invalid source port\n");
> +		dev_warn_ratelimited(&dev->dev,
> +				     "Tag: 0x%x, 0x%x, 0x%x, 0x%x, 0x%x, 0x%x, 0x%x, 0x%x\n",
> +				     gsw1xx_tag[0], gsw1xx_tag[1], gsw1xx_tag[2], gsw1xx_tag[3],
> +				     gsw1xx_tag[4], gsw1xx_tag[5], gsw1xx_tag[6], gsw1xx_tag[7]);
> +		return NULL;
> +	}
> +
> +	/* remove the GSW1xx special tag between MAC addresses and the current
> +	 * ethertype field.
> +	 */
> +	skb_pull_rcsum(skb, GSW1XX_RX_HEADER_LEN);
> +	dsa_strip_etype_header(skb, GSW1XX_RX_HEADER_LEN);

You're not setting skb->offload_fwd_mark but you implement
port_bridge_join() so you offload L2 switching. If a packet gets flooded
from port A to the CPU and also to port B, don't you see that the
software bridge also creates a packet copy that it sends to port B a
second time?

> +
> +	return skb;
> +}
> +
> +static const struct dsa_device_ops gsw1xx_netdev_ops = {
> +	.name = GSW1XX_TAG_NAME,
> +	.proto	= DSA_TAG_PROTO_MXL_GSW1XX,
> +	.xmit = gsw1xx_tag_xmit,
> +	.rcv = gsw1xx_tag_rcv,
> +	.needed_headroom = GSW1XX_RX_HEADER_LEN,
> +};
> +
> +MODULE_DESCRIPTION("DSA tag driver for MaxLinear GSW1xx 8 byte protocol");
> +MODULE_LICENSE("GPL");
> +MODULE_ALIAS_DSA_TAG_DRIVER(DSA_TAG_PROTO_MXL_GSW1XX, GSW1XX_TAG_NAME);
> +
> +module_dsa_tag_driver(gsw1xx_netdev_ops);
> -- 
> 2.51.1


