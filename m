Return-Path: <netdev+bounces-250216-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 37848D25251
	for <lists+netdev@lfdr.de>; Thu, 15 Jan 2026 16:04:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 1140C3019840
	for <lists+netdev@lfdr.de>; Thu, 15 Jan 2026 14:57:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B29A34E75D;
	Thu, 15 Jan 2026 14:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FW20dfCo";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="hVila3PT"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1BA83A1E73
	for <netdev@vger.kernel.org>; Thu, 15 Jan 2026 14:57:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768489038; cv=none; b=MqlTtC46LZ0HsI8iSxHwDQN5nswHMi9wuqni7KP4QSypNwf+L+zLQLdSLJl/0fQ25TylVffe14Nqb+FuI/WfisErCHCGCgNsUiR3OFu0iqZnBnLkGsxwg+kTyfej6XxnmH3kJSJL8n2gulyPeZ/mivfEfo20S7iJooP8eFpwKTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768489038; c=relaxed/simple;
	bh=MOXAX6Cj+2/bVL0ESAhAFWUMkXp/mI/2P4uQHJp4w1I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jij4tq4USSiwiD8ieeUAIX1spIezJeZjp7IddxyKlokYg57ne8/TtXWVD+0rznDyPU458mbDUWvNPovOItwHDrgikOHi/yjWVmkd3QhrCMwCpWNs68n6i29ya7sJm/Ft7XWoPXYM763+wNKj+uBE8/vgaGC30ym/CTCWLEkCwGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FW20dfCo; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=hVila3PT; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768489036;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2I4A6pXsGS8qSIswyUS7eSprAnSExVzJ8lG3EVQyBRA=;
	b=FW20dfCofy9bgxNX0wMpunVvMZUnb5ZcfdBefIraK+1mzuJ6EmGDe7hukU6p4fhkGYZ2xI
	FyAS/5Ls+TxcQaCGYLr0/J3GUeMaKEb/nnYna5XcTuEyuMDTYkL0LlvLiS8S3KNb2z1vMd
	Tz9WxVbh4GMnHPrLSOkJaGv1w5rh4A0=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-54-K1_f7swDO2OcLexIowfTAQ-1; Thu, 15 Jan 2026 09:57:14 -0500
X-MC-Unique: K1_f7swDO2OcLexIowfTAQ-1
X-Mimecast-MFC-AGG-ID: K1_f7swDO2OcLexIowfTAQ_1768489033
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-432db1a9589so1027593f8f.0
        for <netdev@vger.kernel.org>; Thu, 15 Jan 2026 06:57:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1768489033; x=1769093833; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2I4A6pXsGS8qSIswyUS7eSprAnSExVzJ8lG3EVQyBRA=;
        b=hVila3PTxNjQLzDM2rq/PIEr+ToytuPDdnmU+NFMMAd/b1xhBdj7W/cqPYfXujBhda
         26uKBtownymm/RRv8AklFulPhAhl3hPhZIlogw/I9hhRSd38w3d4Ru5Vi/x1kQO9AQ8J
         3tmI3wieY1AIa4XX6idL45q/ewHo/eEkIeIY78obJY0Up5OW1icRZxeDesflzBzRv9G1
         VDdjxvcsKXnb1XtDkAgPTbhBNFqICLJqcCoyGkOIeJHM1dj5prHLLiuOOgCsDgM0EAle
         EoXRHlBbRJWYdLdfTxyyS6WMORxYxAwR43PuJiZaCXVf0shj94FA/Wb2i+vhCPRIz9G/
         NDaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768489033; x=1769093833;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2I4A6pXsGS8qSIswyUS7eSprAnSExVzJ8lG3EVQyBRA=;
        b=p2jvzgDytAMQEr49qXKkKw1WZSLusmoDktQU6W7kYcSh2W6TOF87+7nRrEusYDiYTu
         tJmKgnBfI89h7KAVc4LwQwsObqD5Yhb0C/H8WkAIE/zy/cqXUWF/AD8zswPAbYuxTuMN
         F9btgIaL4kA55m6MBX7sbJyoH8IYG2X1DJaKOLrE7DqU+nA7EjEcug3/0KViAO91+zlT
         fKMaKrjYsvt5kZbmYzS5MWOJxfAqGp2R4ewHIqtpq/VNuAYRjZa1uNkRdJRYe8VXeAhu
         6Vd3WGrZZJZ7O8r0V5T1R+hHrLvrRB2PClklTOx2udnO7n4yjUqulelfTaetVHvmHw0L
         kyVQ==
X-Forwarded-Encrypted: i=1; AJvYcCVCw2Un44uihAZ4gmHSqZMK0NNrLTJQxYKGbHjHfxQMPVpr7evHcFYDLNsWWY9Uf+bgghXfozY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/yfl7H6p/PYoAvV8BfugSjt5evT20SvRluEOqEa20XDVQl+yd
	N7X9Rivspla3o6D5EdsV3R9eQGJS3TYjmzGRs3gatT644XaJvYecm8df3BGZu6GUkRcU49PwuIE
	JFAcVSAjofkvza4QW1H4cdG/nkgRdv9A6gAPkEDTVa4dpj93jB6Z9jPfFOg==
X-Gm-Gg: AY/fxX5o27O2A5k9sXUA9M/+2hVTf0RyU284d8oh15RYs3V4RA58Gf4CsJNJvg0xHBX
	H0benx1nD7MxZ/VgzNNujQLklEXlYMvZAR8vnlW7ATHZ4HgSNREm0ZrJWF/P+UlN8Vvp+SCI1Cg
	XbJAzq6N8eZbhRIuvT2pVLi0/P/FUW64DwXO3H0/wG4Jpr4v+WrioMIUAw/EsprPrxtPwdLOVl/
	fKl+/QnD8uybeMIP4bTiG9RVMYEypLYee1gh//GdzENQX0oPLYnBJEtLu8Rl/glaJakXEiHa02f
	F/1cxO6GXxn3MB3T5Oqx08tuunUs/Br0YdOLaihT8BFlkUQxyExH7a76CY7ctOERCiuknwkhK57
	Uh33coDqDz+6Mqg==
X-Received: by 2002:a05:600c:3ba6:b0:47a:7fd0:9eea with SMTP id 5b1f17b1804b1-4801e2f3013mr146245e9.3.1768489033431;
        Thu, 15 Jan 2026 06:57:13 -0800 (PST)
X-Received: by 2002:a05:600c:3ba6:b0:47a:7fd0:9eea with SMTP id 5b1f17b1804b1-4801e2f3013mr145755e9.3.1768489032850;
        Thu, 15 Jan 2026 06:57:12 -0800 (PST)
Received: from [192.168.88.32] ([212.105.153.128])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47f428acd0csm50981045e9.6.2026.01.15.06.57.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Jan 2026 06:57:12 -0800 (PST)
Message-ID: <7e81c093-c578-46ad-b00b-a45da074939a@redhat.com>
Date: Thu, 15 Jan 2026 15:57:09 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v5 2/4] net: dsa: add tag format for MxL862xx
 switches
To: Daniel Golle <daniel@makrotopia.org>, Andrew Lunn <andrew@lunn.ch>,
 Vladimir Oltean <olteanv@gmail.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Heiner Kallweit <hkallweit1@gmail.com>,
 Russell King <linux@armlinux.org.uk>, Simon Horman <horms@kernel.org>,
 netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: Frank Wunderlich <frankwu@gmx.de>, Chad Monroe <chad@monroe.io>,
 Cezary Wilmanski <cezary.wilmanski@adtran.com>,
 Avinash Jayaraman <ajayaraman@maxlinear.com>, Bing tao Xu
 <bxu@maxlinear.com>, Liang Xu <lxu@maxlinear.com>,
 Juraj Povazanec <jpovazanec@maxlinear.com>,
 "Fanni (Fang-Yi) Chan" <fchan@maxlinear.com>,
 "Benny (Ying-Tsan) Weng" <yweng@maxlinear.com>,
 "Livia M. Rosu" <lrosu@maxlinear.com>, John Crispin <john@phrozen.org>
References: <cover.1768225363.git.daniel@makrotopia.org>
 <3c44b74b9908c134e52ee9b18c04d26cba51d3d7.1768225363.git.daniel@makrotopia.org>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <3c44b74b9908c134e52ee9b18c04d26cba51d3d7.1768225363.git.daniel@makrotopia.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 1/12/26 2:51 PM, Daniel Golle wrote:
> Add proprietary special tag format for the MaxLinear MXL862xx family of
> switches. While using the same Ethertype as MaxLinear's GSW1xx switches,
> the actual tag format differs significantly, hence we need a dedicated
> tag driver for that.
> 
> Signed-off-by: Daniel Golle <daniel@makrotopia.org>
> ---
> v5:
>  * remove unused macro definitions
> 
> RFC v4:
>  * describe fields and variables with comments
>  * sub-interface is only 5 bits
>  * harmonize Kconfig symbol name
>  * maintain alphabetic order in Kconfig
>  * fix typo s/beginnig/beginning/
>  * fix typo s/swtiches/switches/
>  * arrange local variables in reverse xmas tree order
> 
> RFC v3: no changes
> RFC v2: make sure all tag fields are initialized
> 
>  MAINTAINERS            |   1 +
>  include/net/dsa.h      |   2 +
>  net/dsa/Kconfig        |   7 +++
>  net/dsa/Makefile       |   1 +
>  net/dsa/tag_mxl862xx.c | 116 +++++++++++++++++++++++++++++++++++++++++
>  5 files changed, 127 insertions(+)
>  create mode 100644 net/dsa/tag_mxl862xx.c
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 162859534a77c..686591074b34d 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -15619,6 +15619,7 @@ M:	Daniel Golle <daniel@makrotopia.org>
>  L:	netdev@vger.kernel.org
>  S:	Maintained
>  F:	Documentation/devicetree/bindings/net/dsa/maxlinear,mxl862xx.yaml
> +F:	net/dsa/tag_mxl862xx.c
>  
>  MCAN DEVICE DRIVER
>  M:	Markus Schneider-Pargmann <msp@baylibre.com>
> diff --git a/include/net/dsa.h b/include/net/dsa.h
> index 6b2b5ed64ea4c..1e33242b6d94d 100644
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
> index f86b30742122f..efc95759a10e1 100644
> --- a/net/dsa/Kconfig
> +++ b/net/dsa/Kconfig
> @@ -104,6 +104,13 @@ config NET_DSA_TAG_MTK
>  	  Say Y or M if you want to enable support for tagging frames for
>  	  Mediatek switches.
>  
> +config NET_DSA_TAG_MXL_862XX
> +	tristate "Tag driver for MxL862xx switches"
> +	help
> +	  Say Y or M if you want to enable support for tagging frames for the
> +	  Maxlinear MxL86252 and MxL86282 switches using their native 8-byte
> +	  tagging protocol.
> +
>  config NET_DSA_TAG_MXL_GSW1XX
>  	tristate "Tag driver for MaxLinear GSW1xx switches"
>  	help
> diff --git a/net/dsa/Makefile b/net/dsa/Makefile
> index 42d173f5a7013..bf7247759a64a 100644
> --- a/net/dsa/Makefile
> +++ b/net/dsa/Makefile
> @@ -28,6 +28,7 @@ obj-$(CONFIG_NET_DSA_TAG_HELLCREEK) += tag_hellcreek.o
>  obj-$(CONFIG_NET_DSA_TAG_KSZ) += tag_ksz.o
>  obj-$(CONFIG_NET_DSA_TAG_LAN9303) += tag_lan9303.o
>  obj-$(CONFIG_NET_DSA_TAG_MTK) += tag_mtk.o
> +obj-$(CONFIG_NET_DSA_TAG_MXL_862XX) += tag_mxl862xx.o
>  obj-$(CONFIG_NET_DSA_TAG_MXL_GSW1XX) += tag_mxl-gsw1xx.o
>  obj-$(CONFIG_NET_DSA_TAG_NONE) += tag_none.o
>  obj-$(CONFIG_NET_DSA_TAG_OCELOT) += tag_ocelot.o
> diff --git a/net/dsa/tag_mxl862xx.c b/net/dsa/tag_mxl862xx.c
> new file mode 100644
> index 0000000000000..c4d0ea2eb48f9
> --- /dev/null
> +++ b/net/dsa/tag_mxl862xx.c
> @@ -0,0 +1,116 @@
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
> +#define MXL862_HEADER_LEN	8
> +
> +/* Word 0 -> EtherType */
> +
> +/* Word 2 */
> +#define MXL862_SUBIF_ID		GENMASK(4, 0)
> +
> +/* Word 3 */
> +#define MXL862_IGP_EGP		GENMASK(3, 0)
> +
> +static struct sk_buff *mxl862_tag_xmit(struct sk_buff *skb,
> +				       struct net_device *dev)
> +{
> +	unsigned int cpu_port, usr_port, sub_interface;
> +	struct dsa_port *dp = dsa_user_to_port(dev);
> +	struct dsa_port *cpu_dp = dp->cpu_dp;
> +	__be16 *mxl862_tag;
> +
> +	/* switch firmware expects ports to be counted starting from 1 */
> +	cpu_port = cpu_dp->index + 1;
> +	usr_port = dp->index + 1;
> +
> +	/* target port sub-interface ID relative to the CPU port */
> +	sub_interface = usr_port + 16 - cpu_port;
> +
> +	if (!skb)
> +		return skb;

I think skb can't be NULL here?!? Otherwise it would be better to move
the check at the beginning of the function and return NULL directly.

> +
> +	/* provide additional space 'MXL862_HEADER_LEN' bytes */
> +	skb_push(skb, MXL862_HEADER_LEN);
> +
> +	/* shift MAC address to the beginning of the enlarged buffer,
> +	 * releasing the space required for DSA tag (between MAC address and
> +	 * Ethertype)
> +	 */
> +	dsa_alloc_etype_header(skb, MXL862_HEADER_LEN);
> +
> +	/* special tag ingress */
> +	mxl862_tag = dsa_etype_header_pos_tx(skb);
> +	mxl862_tag[0] = htons(ETH_P_MXLGSW);
> +	mxl862_tag[1] = 0;
> +	mxl862_tag[2] = htons(FIELD_PREP(MXL862_SUBIF_ID, sub_interface));
> +	mxl862_tag[3] = htons(FIELD_PREP(MXL862_IGP_EGP, cpu_port));
> +
> +	return skb;
> +}
> +
> +static struct sk_buff *mxl862_tag_rcv(struct sk_buff *skb,
> +				      struct net_device *dev)
> +{
> +	__be16 *mxl862_tag;
> +	int port;
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

Why breaking the message in 2 strings? a single dev_warn_ratelimited()
would be more readable and will generate smaller code. Similar thing below.

/P


