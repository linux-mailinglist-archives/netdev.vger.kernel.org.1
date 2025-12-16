Return-Path: <netdev+bounces-245020-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E50FCC51CA
	for <lists+netdev@lfdr.de>; Tue, 16 Dec 2025 21:39:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 40D893029D3E
	for <lists+netdev@lfdr.de>; Tue, 16 Dec 2025 20:39:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 176172DEA87;
	Tue, 16 Dec 2025 20:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UeyIyLMV"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00E8D243951
	for <netdev@vger.kernel.org>; Tue, 16 Dec 2025 20:39:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765917585; cv=none; b=E32sUnzSJfUk69sxL7j0zn08IoaKJNjyZ/Vw0+qzCLno+FhiTIyo9aSaEImJGP/uWYNM48wYLFM/5D2fGtfQPtoBdi0a5qK7pK0TYcPzG/JEdENtTHz34Qhy61Y+ytRZDxuFaAt06qKEUnM6AnAsic0+ri0M3IXDmQ1AhPS5ipw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765917585; c=relaxed/simple;
	bh=tv0em6rnzXZKHXeiwFp0GKmFEA3N4Nijb9juCHcmjOg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BdaUV9WlSqEmXao6NbVRd5vGZgo7gso9fr7PX/RGy8J6EiF22aDntYPUtv6LAjeS6i60ITBz2qZPchjcluMPDO73Fj4JxPq6ajgWOGxhabdVwL6nwVucxzfLSUtSZpyKG66jSjC6BM4YfZs1JfX9QD+eN2iI/RSSm7RhMg6193g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UeyIyLMV; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-47798089d30so5055785e9.1
        for <netdev@vger.kernel.org>; Tue, 16 Dec 2025 12:39:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765917581; x=1766522381; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=s73//T/y6AREQsTtlkjpQxBqm/eC/foq+66hNL6Ts/s=;
        b=UeyIyLMVS3dAAgMP3mjMgX7uO5LBNVu5Xc75DpKfVdAzock0kvIicykisbgaFm3sPF
         ypwhSbRAKOq2KWI0+HJS4kkELDVeCeg0EjG0Fpz7M1iraVKKXWe2ZJkKqJ5LGSZrutrV
         YAigIjiN13F0Xl3ZOJ1Q07u8L4Tg8+ujf3LNQ6QjVl8N+7KVjEEgqBjZAM485f/O26Tb
         qT3ChHiQWLzRK1kflD/uns08VDbV0MfjvK3vaIgbv5XMmQdPKc5EVyYndWUPYsrLZf4k
         rYYnHPJgbHs61UyCDzGJGyFuu4Atf41e3dnrNPJc9uYp9apZXHlElO/ovJDvZTNTd6qf
         ewEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765917581; x=1766522381;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s73//T/y6AREQsTtlkjpQxBqm/eC/foq+66hNL6Ts/s=;
        b=OfzPV1bCCAhwaUdDhz13loFfPL1/rosZ8F1ySAON3nFfDvASLRlQ5uuvJfj4vOzxkt
         nM0m+ZIq7hFtBEhLCOd8OEKUBXtUkuxcxIxmNZwKpMg1O86KAcEUaNwbpNqmpWJFhnMv
         haGMho25ePUaKxe1DpKasn7RlT5ARIKUEcZUROsalfRniW62X5BiI6wfZPP3EYtQU6zQ
         LsVrzYkSeoZJDRryRae5lKv/2C5Yu4eZNwZyLpoDbi0OxESAmuaW6Q6uTzlQJeqL95Mp
         CwKxKS4SHlETtUpjJgSdunyk49MDfaHp/K/F2It8OBUufDfywecv1HBmYiyRsBU/xy6F
         Ohiw==
X-Forwarded-Encrypted: i=1; AJvYcCVzp1uXKhKTCoTvVEjga8dvOEYtZWgiiwSIqt2vI1mZ3ljbHyiJ1J/mEomoQKyvj3ggfJtg91o=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxs6ndBgGOplWgpNkIlG4ZRe4OAeN4RScDsEYCJuZAy6j49fIbq
	O2MqKf/RIWej57blaV97Y5Q10t/ZCNEYyGUqsKqO7rqLs0yf0cQqdsuI
X-Gm-Gg: AY/fxX48mhFW2/vs/TDP64TKT3dkJBzgKx4Km9FiyMg06TJsSZzUZ9ntbe+P1KjSuSY
	m7rKY+4LqIuiTn3YTnxAQjBJzmFBOq4aHWmY2/eMyZjv/20owg9DWkm0oqos4mK/5kLWpVOsmRJ
	0XbkjP+EhuaPtVMoNcZezmxPIfe02Men5ralAIIDkttovt8cyQORnFjoW0pyJgCFyYu2neyvlU4
	KOW18CqBY0rXTK+9GD6CYtDXOqU3YxYF68jlnZlO9gh6IJG7S0z/UdzulwbwBoC4tK7A/b7Uk06
	Mcv8J/HRApJHzfiIsnflf96enky/pUa4iblIYTcZ9BecIy6G3K8efEOHD2HzeXdq2pbh15csDy4
	8p0jqzHXvXZm1d3GVnP6QypdZ+VlrEQeQChU1lRgrZXc2OuzU9fSPnG1wNXL15ugO0vhJsqdoJA
	rH
X-Google-Smtp-Source: AGHT+IFWFbVcT/008WsXnHLoEvlmXoyoS0p30djhl0qQueCdCg1nk8K6Tv48MEYeNKDgA8N3ze5LTA==
X-Received: by 2002:a05:600c:4f84:b0:477:a6f1:499d with SMTP id 5b1f17b1804b1-47a8f9187c7mr108090035e9.3.1765917580897;
        Tue, 16 Dec 2025 12:39:40 -0800 (PST)
Received: from skbuf ([2a02:2f04:d106:d600:c18:aa1:b847:17e5])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47bdc1cb6b3sm6938755e9.3.2025.12.16.12.39.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Dec 2025 12:39:39 -0800 (PST)
Date: Tue, 16 Dec 2025 22:39:35 +0200
From: Vladimir Oltean <olteanv@gmail.com>
To: Daniel Golle <daniel@makrotopia.org>
Cc: Andrew Lunn <andrew@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Frank Wunderlich <frankwu@gmx.de>, Chad Monroe <chad@monroe.io>,
	Cezary Wilmanski <cezary.wilmanski@adtran.com>,
	Avinash Jayaraman <ajayaraman@maxlinear.com>,
	Bing tao Xu <bxu@maxlinear.com>, Liang Xu <lxu@maxlinear.com>,
	Juraj Povazanec <jpovazanec@maxlinear.com>,
	"Fanni (Fang-Yi) Chan" <fchan@maxlinear.com>,
	"Benny (Ying-Tsan) Weng" <yweng@maxlinear.com>,
	"Livia M. Rosu" <lrosu@maxlinear.com>,
	John Crispin <john@phrozen.org>
Subject: Re: [PATCH RFC net-next v3 2/4] net: dsa: add tag formats for
 MxL862xx switches
Message-ID: <20251216203935.z5ss4sxbt6xc2444@skbuf>
References: <cover.1765757027.git.daniel@makrotopia.org>
 <de01f08a3c99921d439bc15eeafd94e759688554.1765757027.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <de01f08a3c99921d439bc15eeafd94e759688554.1765757027.git.daniel@makrotopia.org>

On Mon, Dec 15, 2025 at 12:11:43AM +0000, Daniel Golle wrote:
> Add proprietary special tag format for the MaxLinear MXL862xx family of
> switches. While using the same Ethertype as MaxLinear's GSW1xx swtiches,

s/swtiches/switches/

> the actual tag format differs significantly, hence we need a dedicated
> tag driver for that.

Reusing the same EtherType for two different DSA tagging protocols is
very bad news, possibly with implications also for libpcap. Is the
EtherType configurable in the MXL862xx family?

> 
> Signed-off-by: Daniel Golle <daniel@makrotopia.org>
> ---
> RFC v3: no changes
> RFC v2: make sure all tag fields are initialized
> 
>  MAINTAINERS            |   1 +
>  include/net/dsa.h      |   2 +
>  net/dsa/Kconfig        |   7 +++
>  net/dsa/Makefile       |   1 +
>  net/dsa/tag_mxl862xx.c | 113 +++++++++++++++++++++++++++++++++++++++++
>  5 files changed, 124 insertions(+)
>  create mode 100644 net/dsa/tag_mxl862xx.c
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index c433a15d9797a..a20498cc8320b 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -15609,6 +15609,7 @@ M:	Daniel Golle <daniel@makrotopia.org>
>  L:	netdev@vger.kernel.org
>  S:	Maintained
>  F:	Documentation/devicetree/bindings/net/dsa/maxlinear,mxl862xx.yaml
> +F:	net/dsa/tag_mxl862xx.c
>  
>  MCAN DEVICE DRIVER
>  M:	Markus Schneider-Pargmann <msp@baylibre.com>
> diff --git a/include/net/dsa.h b/include/net/dsa.h
> index e40cdc12f7f39..e4c2b47a2a46e 100644
> --- a/include/net/dsa.h
> +++ b/include/net/dsa.h
> @@ -57,6 +57,7 @@ struct tc_action;
>  #define DSA_TAG_PROTO_BRCM_LEGACY_FCS_VALUE	29
>  #define DSA_TAG_PROTO_YT921X_VALUE		30
>  #define DSA_TAG_PROTO_MXL_GSW1XX_VALUE		31
> +#define DSA_TAG_PROTO_MXL862_VALUE		32
>  
>  enum dsa_tag_protocol {
>  	DSA_TAG_PROTO_NONE		= DSA_TAG_PROTO_NONE_VALUE,
> @@ -91,6 +92,7 @@ enum dsa_tag_protocol {
>  	DSA_TAG_PROTO_VSC73XX_8021Q	= DSA_TAG_PROTO_VSC73XX_8021Q_VALUE,
>  	DSA_TAG_PROTO_YT921X		= DSA_TAG_PROTO_YT921X_VALUE,
>  	DSA_TAG_PROTO_MXL_GSW1XX	= DSA_TAG_PROTO_MXL_GSW1XX_VALUE,
> +	DSA_TAG_PROTO_MXL862		= DSA_TAG_PROTO_MXL862_VALUE,
>  };
>  
>  struct dsa_switch;
> diff --git a/net/dsa/Kconfig b/net/dsa/Kconfig
> index f86b30742122f..c897d62326f5b 100644
> --- a/net/dsa/Kconfig
> +++ b/net/dsa/Kconfig
> @@ -145,6 +145,13 @@ config NET_DSA_TAG_QCA
>  	  Say Y or M if you want to enable support for tagging frames for
>  	  the Qualcomm Atheros QCA8K switches.
>  
> +config NET_DSA_TAG_MXL862
> +	tristate "Tag driver for MxL862xx switches"
> +	help
> +	  Say Y or M if you want to enable support for tagging frames for the
> +	  Maxlinear MxL86252 and MxL86282 switches using their native 8-byte

MaxLinear with capital L

> +	  tagging protocol.
> +
>  config NET_DSA_TAG_RTL4_A
>  	tristate "Tag driver for Realtek 4 byte protocol A tags"
>  	help
> diff --git a/net/dsa/Makefile b/net/dsa/Makefile
> index 42d173f5a7013..dbe2a742e3322 100644
> --- a/net/dsa/Makefile
> +++ b/net/dsa/Makefile
> @@ -28,6 +28,7 @@ obj-$(CONFIG_NET_DSA_TAG_HELLCREEK) += tag_hellcreek.o
>  obj-$(CONFIG_NET_DSA_TAG_KSZ) += tag_ksz.o
>  obj-$(CONFIG_NET_DSA_TAG_LAN9303) += tag_lan9303.o
>  obj-$(CONFIG_NET_DSA_TAG_MTK) += tag_mtk.o
> +obj-$(CONFIG_NET_DSA_TAG_MXL862) += tag_mxl862xx.o
>  obj-$(CONFIG_NET_DSA_TAG_MXL_GSW1XX) += tag_mxl-gsw1xx.o
>  obj-$(CONFIG_NET_DSA_TAG_NONE) += tag_none.o
>  obj-$(CONFIG_NET_DSA_TAG_OCELOT) += tag_ocelot.o
> diff --git a/net/dsa/tag_mxl862xx.c b/net/dsa/tag_mxl862xx.c
> new file mode 100644
> index 0000000000000..9c5e5f90dcb63
> --- /dev/null
> +++ b/net/dsa/tag_mxl862xx.c
> @@ -0,0 +1,113 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * DSA Special Tag for MaxLinear 862xx switch chips
> + *
> + * Copyright (C) 2025 Daniel Golle <daniel@makrotopia.org>
> + * Copyright (C) 2024 MaxLinear Inc.
> + */
> +
> +#include <linux/bitops.h>
> +#include <linux/etherdevice.h>
> +#include <linux/skbuff.h>
> +#include <net/dsa.h>
> +#include "tag.h"
> +
> +#define MXL862_NAME	"mxl862xx"
> +
> +/* To define the outgoing port and to discover the incoming port a special
> + * tag is used by the GSW1xx.
> + *
> + *       Dest MAC       Src MAC    special TAG        EtherType
> + * ...| 1 2 3 4 5 6 | 1 2 3 4 5 6 | 1 2 3 4 5 6 7 8 | 1 2 |...
> + *                                |<--------------->|
> + */
> +
> +#define MXL862_HEADER_LEN 8
> +
> +/* Byte 7 */
> +#define MXL862_IGP_EGP GENMASK(3, 0)
> +
> +static struct sk_buff *mxl862_tag_xmit(struct sk_buff *skb,
> +				       struct net_device *dev)
> +{
> +	struct dsa_port *dp = dsa_user_to_port(dev);
> +	struct dsa_port *cpu_dp = dp->cpu_dp;
> +	unsigned int cpu_port = cpu_dp->index + 1;
> +	unsigned int usr_port = dp->index + 1;
> +	__be16 *mxl862_tag;
> +
> +	if (!skb)
> +		return skb;
> +
> +	/* provide additional space 'MXL862_HEADER_LEN' bytes */
> +	skb_push(skb, MXL862_HEADER_LEN);
> +
> +	/* shift MAC address to the beginnig of the enlarged buffer,
> +	 * releasing the space required for DSA tag (between MAC address and
> +	 * Ethertype)
> +	 */
> +	dsa_alloc_etype_header(skb, MXL862_HEADER_LEN);
> +
> +	/* special tag ingress */
> +	mxl862_tag = dsa_etype_header_pos_tx(skb);
> +	mxl862_tag[0] = htons(ETH_P_MXLGSW);
> +	mxl862_tag[1] = 0;
> +	mxl862_tag[2] = htons(usr_port + 16 - cpu_port);

Can you place a comment on the meaning of these port manipulations
(cpu_dp->index + 1, dp->index + 1, usr_port + 16 - cpu_port,
port = port - 1 in rcv())?

> +	mxl862_tag[3] = htons(FIELD_PREP(MXL862_IGP_EGP, cpu_port));
> +
> +	return skb;
> +}
> +
> +static struct sk_buff *mxl862_tag_rcv(struct sk_buff *skb,
> +				      struct net_device *dev)
> +{
> +	int port;
> +	__be16 *mxl862_tag;
> +
> +	if (unlikely(!pskb_may_pull(skb, MXL862_HEADER_LEN))) {
> +		dev_warn_ratelimited(&dev->dev, "Cannot pull SKB, packet dropped\n");
> +		return NULL;
> +	}
> +
> +	mxl862_tag = dsa_etype_header_pos_rx(skb);
> +
> +	if (unlikely(mxl862_tag[0] != htons(ETH_P_MXLGSW))) {
> +		dev_warn_ratelimited(&dev->dev, "Invalid special tag marker, packet dropped\n");
> +		dev_warn_ratelimited(&dev->dev, "Rx Packet Tag: %8ph\n",
> +				     mxl862_tag);
> +		return NULL;
> +	}
> +
> +	/* Get source port information */
> +	port = FIELD_GET(MXL862_IGP_EGP, ntohs(mxl862_tag[3]));
> +	port = port - 1;
> +	skb->dev = dsa_conduit_find_user(dev, 0, port);
> +	if (!skb->dev) {
> +		dev_warn_ratelimited(&dev->dev, "Invalid source port, packet dropped\n");
> +		dev_warn_ratelimited(&dev->dev, "Rx Packet Tag: %8ph\n",
> +				     mxl862_tag);
> +		return NULL;
> +	}
> +
> +	/* remove the MxL862xx special tag between the MAC addresses and the
> +	 * current ethertype field.
> +	 */
> +	skb_pull_rcsum(skb, MXL862_HEADER_LEN);
> +	dsa_strip_etype_header(skb, MXL862_HEADER_LEN);
> +
> +	return skb;
> +}
> +
> +static const struct dsa_device_ops mxl862_netdev_ops = {
> +	.name = "mxl862",
> +	.proto = DSA_TAG_PROTO_MXL862,
> +	.xmit = mxl862_tag_xmit,
> +	.rcv = mxl862_tag_rcv,
> +	.needed_headroom = MXL862_HEADER_LEN,
> +};
> +
> +MODULE_ALIAS_DSA_TAG_DRIVER(DSA_TAG_PROTO_MXL862, MXL862_NAME);
> +MODULE_DESCRIPTION("DSA tag driver for MaxLinear MxL862xx switches");
> +MODULE_LICENSE("GPL");
> +
> +module_dsa_tag_driver(mxl862_netdev_ops);
> -- 
> 2.52.0

