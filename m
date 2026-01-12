Return-Path: <netdev+bounces-249195-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 51E32D15625
	for <lists+netdev@lfdr.de>; Mon, 12 Jan 2026 22:07:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D1E813005F22
	for <lists+netdev@lfdr.de>; Mon, 12 Jan 2026 21:07:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAA2D3218B2;
	Mon, 12 Jan 2026 21:07:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VcJVpwvL"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f68.google.com (mail-wm1-f68.google.com [209.85.128.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F6C0340A43
	for <netdev@vger.kernel.org>; Mon, 12 Jan 2026 21:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768252044; cv=none; b=nx+x9J5L07TFyPj6Hy6eHz/Pjrw3Kt6r3+ndkUmuR55T3Q/Cp9DK+qG7eiRtNAwVLIY+mkAHuUoCNXZcZUXmiUX68iEKRjh6eyDCnlVSkGa7nGNHN5X83gc1aaD71HvItVlMG3IEWivOpMcqog9rs6Y9KctX2mLNziF9kmQ/zcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768252044; c=relaxed/simple;
	bh=JHm7KYhm6uqdC1zHtP+V6HTCv0NcKOxB/h5vIcqQXe4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P7W+vuiIJ7wpVdwk1uTf/cV5fspihQMUFVgem+GBH6GUpVuWhjLJVQT7gAKsK4LpbpX37vG79bh0JB2KpXPO8bCheJSKJVF92jC7wT3kjqOIi55QsU3xzraQ/Z4xY178SyN8Mub3DektamZBj9+9KYDQ2fbX6vFKvF7b4YcOxz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VcJVpwvL; arc=none smtp.client-ip=209.85.128.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f68.google.com with SMTP id 5b1f17b1804b1-4779b49d724so7372265e9.0
        for <netdev@vger.kernel.org>; Mon, 12 Jan 2026 13:07:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768252040; x=1768856840; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=LTRRd85RBYWRayG0scxIO+L0xVmBDXqrnT6ievTwV7E=;
        b=VcJVpwvLw+wPvvFakYblRCYnZy6DISMFmMfWohRKgkkZPbQ+kVNn8qklxm9QmE/RyH
         SdVyHv8byCVGfBKAoZtKVEjWOPVoKS/s45SJGHIu0c8jssadupKsRAIGH33z0wWSi4JM
         alHiEN8QW4OC98NOEe/FUrURTGUbyChZPbsdbBvP6tfJ8H9GqCuaCFNEW3E/1SEJ26rF
         IiHqjgp7yXd4BS+YYczkzXNQ7HXGlt0OILs0OKQcF+R6hYQlLDT3LqhynwxMNRheRLM5
         +0DXhar4cEWlovFwQABEB285a6zitvIIeWodmdOns0j+vfKyBLx5TkeCsSAEsXPjFnfS
         a6vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768252040; x=1768856840;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LTRRd85RBYWRayG0scxIO+L0xVmBDXqrnT6ievTwV7E=;
        b=eETmdh1w49nDXvWMSzBEjzcNmUR/1cvuW6kLgtzqGc4Vg9XquIiHA25PRW8PAQjssX
         BImzJvj8M/QD+hloxTAfe8KO0EVnrrMIs4+ghyGWjq/magsX7xr2JIL8GUMKqE9VqCHr
         U64fRnk+711StraMvzanCwA+J59WCgC3jG4NaJl3eDWPNAgHGS01ZqNZ9RsPh31Gnkre
         2KWOsqpsBbQ17Ih2nF6K5C/2kP7+U/c1dz18FQd3KWJ+Cn3ESRZCeI/XlP81BGuRKhKw
         w8Nsk3xifUCeEAABNhg21MnsQNDZ7lD6CwGZ73vBxoc1FadehXmv4lOnYItqsKqsxnPW
         6Xug==
X-Forwarded-Encrypted: i=1; AJvYcCUwjMjmXgaXB8wuyHjaZhJNgERug/yfIs8GmbngIhognSMszLL1mC/kOfAUqJV1+xP+slOXYo4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxFGQqMYuIctmXPxWSR9navfyVeMp01NsePzP+vSoJKnzgZ/y7+
	74T3G7ICbVcRSV7QRYoW26Xdo1K76IwYM4vbyFylGgHBgO4e8wLjSFsZWn3yINHD7Uirrg==
X-Gm-Gg: AY/fxX48/5ukh9FjktaKyTZNvsRTXFlhriYhxYxvx3IX7jev6xt7YIuCMLgTc7fpdC4
	/JMmSB7ksTbjxchPlOKxunSioOw6osUU0UQA142R2GEuX5FayzadQAnk/2wvl7cIe0LMZiYriHD
	astCvnjSIyu0g/SheWYx5OwX7W28pkwDJKDPOJ380lnWYdAw1a8YsX51OtBPa2TXvavL7/Mn3zv
	17lJVHH5BYoM8PUpKdXNe4cI1IPi6Vsw9Qnp6vmK+kUalxuXYmk23m0KJ8kIPiHk6T418y6tr5K
	JtpkrcqEnpqSzCCtvwpQQbpNjSQF2+G0N/m9X6mAhEgOpDqprsZy5NSijPux7HwOX2Tn/ojqDgz
	DKJS+QUNfRM5jBzD2G36rvxWZbu8y8AWly5/HM+qATpRqsPDh6AiyC5OkMnFWVgh61vE7qSWH+R
	VaYyO3oqSP/eWl
X-Google-Smtp-Source: AGHT+IHQRMPmOM6xCgmzNY9m15hZq4NLGioFeUynsXXgG9+Gtex8WwWoqV8ZlCmJJYH/3tn82SPnCQ==
X-Received: by 2002:a05:600c:3b28:b0:475:d7b8:8505 with SMTP id 5b1f17b1804b1-47d84b4118fmr120655015e9.7.1768252039902;
        Mon, 12 Jan 2026 13:07:19 -0800 (PST)
Received: from skbuf ([2a02:2f04:d804:300:5991:1d11:eff7:807a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47d7f620ac8sm362358265e9.0.2026.01.12.13.07.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jan 2026 13:07:18 -0800 (PST)
Date: Mon, 12 Jan 2026 23:07:16 +0200
From: Vladimir Oltean <olteanv@gmail.com>
To: Linus Walleij <linusw@kernel.org>
Cc: Andrew Lunn <andrew@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org
Subject: Re: [PATCH net-next 1/2] net: dsa: tag_ks8995: Add the KS8995 tag
 handling
Message-ID: <20260112210716.vhznted6ojxca6bz@skbuf>
References: <20260107-ks8995-dsa-tagging-v1-0-1a92832c1540@kernel.org>
 <20260107-ks8995-dsa-tagging-v1-0-1a92832c1540@kernel.org>
 <20260107-ks8995-dsa-tagging-v1-1-1a92832c1540@kernel.org>
 <20260107-ks8995-dsa-tagging-v1-1-1a92832c1540@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260107-ks8995-dsa-tagging-v1-1-1a92832c1540@kernel.org>
 <20260107-ks8995-dsa-tagging-v1-1-1a92832c1540@kernel.org>

Hi Linus,

It's nice to see old hardware being consolidated into the DSA framework.
Thanks for that effort.

On Wed, Jan 07, 2026 at 01:57:14PM +0100, Linus Walleij wrote:
> The KS8995 100Mbit switch can do proper DSA per-port tagging
> with the proper set-up. This adds the code to handle ingress
> and egress KS8995 tags.
> 
> The tag is a modified 0x8100 ethertype tag where a bit in the
> last byte is set for each target port.
> 
> Signed-off-by: Linus Walleij <linusw@kernel.org>
> ---
>  include/net/dsa.h    |   2 +
>  net/dsa/Kconfig      |   6 +++
>  net/dsa/Makefile     |   1 +
>  net/dsa/tag_ks8995.c | 114 +++++++++++++++++++++++++++++++++++++++++++++++++++
>  4 files changed, 123 insertions(+)
> 
> diff --git a/include/net/dsa.h b/include/net/dsa.h
> index cced1a866757..b4c1ac14d051 100644
> --- a/include/net/dsa.h
> +++ b/include/net/dsa.h
> @@ -57,6 +57,7 @@ struct tc_action;
>  #define DSA_TAG_PROTO_BRCM_LEGACY_FCS_VALUE	29
>  #define DSA_TAG_PROTO_YT921X_VALUE		30
>  #define DSA_TAG_PROTO_MXL_GSW1XX_VALUE		31
> +#define DSA_TAG_PROTO_KS8995_VALUE		32
>  
>  enum dsa_tag_protocol {
>  	DSA_TAG_PROTO_NONE		= DSA_TAG_PROTO_NONE_VALUE,
> @@ -91,6 +92,7 @@ enum dsa_tag_protocol {
>  	DSA_TAG_PROTO_VSC73XX_8021Q	= DSA_TAG_PROTO_VSC73XX_8021Q_VALUE,
>  	DSA_TAG_PROTO_YT921X		= DSA_TAG_PROTO_YT921X_VALUE,
>  	DSA_TAG_PROTO_MXL_GSW1XX	= DSA_TAG_PROTO_MXL_GSW1XX_VALUE,
> +	DSA_TAG_PROTO_KS8995		= DSA_TAG_PROTO_KS8995_VALUE,
>  };
>  
>  struct dsa_switch;
> diff --git a/net/dsa/Kconfig b/net/dsa/Kconfig
> index f86b30742122..c5272dc7af88 100644
> --- a/net/dsa/Kconfig
> +++ b/net/dsa/Kconfig
> @@ -112,6 +112,12 @@ config NET_DSA_TAG_MXL_GSW1XX
>  	  Say Y or M if you want to enable support for tagging frames for
>  	  MaxLinear GSW1xx switches.
>  
> +config NET_DSA_TAG_KS8995
> +	tristate "Tag driver for Micrel KS8995 switch"
> +	help
> +	  Say Y if you want to enable support for tagging frames for the
> +	  Micrel KS8995 switch.
> +
>  config NET_DSA_TAG_KSZ
>  	tristate "Tag driver for Microchip 8795/937x/9477/9893 families of switches"
>  	help
> diff --git a/net/dsa/Makefile b/net/dsa/Makefile
> index 42d173f5a701..03eed7653a34 100644
> --- a/net/dsa/Makefile
> +++ b/net/dsa/Makefile
> @@ -25,6 +25,7 @@ obj-$(CONFIG_NET_DSA_TAG_BRCM_COMMON) += tag_brcm.o
>  obj-$(CONFIG_NET_DSA_TAG_DSA_COMMON) += tag_dsa.o
>  obj-$(CONFIG_NET_DSA_TAG_GSWIP) += tag_gswip.o
>  obj-$(CONFIG_NET_DSA_TAG_HELLCREEK) += tag_hellcreek.o
> +obj-$(CONFIG_NET_DSA_TAG_KS8995) += tag_ks8995.o
>  obj-$(CONFIG_NET_DSA_TAG_KSZ) += tag_ksz.o
>  obj-$(CONFIG_NET_DSA_TAG_LAN9303) += tag_lan9303.o
>  obj-$(CONFIG_NET_DSA_TAG_MTK) += tag_mtk.o
> diff --git a/net/dsa/tag_ks8995.c b/net/dsa/tag_ks8995.c
> new file mode 100644
> index 000000000000..a5adda4767a3
> --- /dev/null
> +++ b/net/dsa/tag_ks8995.c
> @@ -0,0 +1,114 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) 2025 Linus Walleij <linusw@kernel.org>

You can update to 2026.

> + */
> +#include <linux/etherdevice.h>
> +#include <linux/log2.h>
> +#include <linux/list.h>
> +#include <linux/slab.h>
> +
> +#include "tag.h"
> +
> +/* The KS8995 Special Tag Packet ID (STPID)
> + * pushes its tag in a way similar to a VLAN tag
> + * -----------------------------------------------------------
> + * | MAC DA | MAC SA | 2 bytes tag | 2 bytes TCI | EtherType |
> + * -----------------------------------------------------------
> + * The tag is: 0x8100 |= BIT(port), ports 0,1,2,3
> + */
> +
> +#define KS8995_NAME "ks8995"
> +
> +#define KS8995_TAG_LEN 4
> +
> +static struct sk_buff *ks8995_xmit(struct sk_buff *skb, struct net_device *dev)
> +{
> +	struct dsa_port *dp = dsa_user_to_port(dev);
> +	u16 ks8995_tag;
> +	__be16 *p;
> +	u16 port;
> +	u16 tci;
> +
> +	/* Prepare the special KS8995 tags */
> +	port = dsa_xmit_port_mask(skb, dev);
> +	/* The manual says to set this to the CPU port if no port is indicated */
> +	if (!port)
> +		port = BIT(5);
> +
> +	ks8995_tag = ETH_P_8021Q | port;
> +	tci = port & VLAN_VID_MASK;

I think this is incorrect on multiple counts.

The first red flag is that the port mask is packed twice into the tag,
once into the TPID and second into the TCI. I opened the reference
manual and my reading is that the TCI portion is unnecessary/incorrect;
it remains processed by the switch as a TCI (aka VLAN ID + PCP), with no
port semantics overlaid on top.

Regarding the sentence "The manual says to set this to the CPU port if
no port is indicated" - I did not find that. I just found these
sentences instead:
- No change to TCI if not null VID
- Replace VID with ingress (port 5) port VID if null VID

which say a different story.

If VID==0, the packet will be processed in the CPU port's PVID,
otherwise the VID is preserved during the forwarding process. In both
cases, the VID may be stripped on egress, depending on VLAN table
settings, or not.

Practically, this means you have a combined DSA+VLAN tag.
On xmit, you'd need logic like this (not compiled, sorry):

#define KS8995M_STPID_STD	GENMASK(15, 4)
#define KS8995M_STPID_PORTMASK	GENMASK(3, 0)
#define KS8995M_STPID(portmask)	htons(ETH_P_8021Q | FIELD_PREP(KS8995M_STPID_PORTMASK, portmask))

	struct vlan_ethhdr *hdr = vlan_eth_hdr(skb);
	bool have_hwaccel_tag = false;
	int tci = 0, portmask;

	portmask = dsa_xmit_port_mask(skb, dev);

	if (skb_vlan_tag_present(skb) && skb->vlan_proto == htons(ETH_P_8021Q)) {
		tci = skb_vlan_tag_get(skb);
		__vlan_hwaccel_clear_tag(skb);
		have_hwaccel_tag = true;
	}

	if (have_hwaccel_tag || hdr->h_vlan_proto != htons(ETH_P_8021Q)) {
		skb = vlan_insert_tag(skb, KS8995M_STPID(portmask), tci);
		if (!skb)
			return NULL;
	} else {
		/* VLAN tag already exists in skb head, modify it in place */
		hdr->h_vlan_proto = KS8995M_STPID(portmask);
		hdr->h_vlan_TCI = htons(tci);
	}

and on rcv, something like this:

	/* We are expecting all received packets to have a mangled VLAN
	 * TPID, so drop anything else. Because of the non-standard TPID,
	 * don't even bother looking for a tag in the hwaccel area
	 */
	if (FIELD_GET(KS8995M_STPID_STD, ntohs(skb->protocol)) != ETH_P_8021Q)
		return NULL;

	/* Move the custom DSA+VLAN tag into the hwaccel area and strip
	 * it from the skb head
	 */
	skb = skb_vlan_untag(skb);
	if (!skb)
		return NULL;

	portmask = FIELD_GET(KS8995M_STPID_PORTMASK, ntohs(skb->vlan_proto));
	skb->dev = dsa_conduit_find_user(dev, 0, ilog2(portmask));
	if (!skb->dev)
		return NULL;

	/* Preserve the VLAN tag if it contains a non-zero VID or PCP,
	 * and restore its TPID to the standard value
	 */
	skb->vlan_proto = htons(ETH_P_8021Q);
	if (!skb->vlan_tci)
		__vlan_hwaccel_clear_tag(skb);

	dsa_default_offload_fwd_mark(skb);

Lastly, dsa_xmit_port_mask() never returns 0, so the extra code is dead.

The reason why you didn't notice anything out of place when transmitting
packets with VID=BIT(port) is, I believe, because you're configuring the
user ports as egress-untagged for all VLANs. Contrary to more advanced
switches where the untagged port mask is per VLAN, here it is per port
(the same "Tag insertion" and "Tag removal" bits from the Port Control 0
registers that you're also enabling on the CPU port). So any blunder in
the tagging protocol is being wiped by the switch.

> +
> +	/* Push in a tag between MAC and ethertype */
> +	netdev_dbg(dev, "egress packet tag: add tag %04x %04x to port %d\n",
> +		   ks8995_tag, tci, dp->index);
> +
> +	skb_push(skb, KS8995_TAG_LEN);
> +	dsa_alloc_etype_header(skb, KS8995_TAG_LEN);
> +
> +	p = dsa_etype_header_pos_tx(skb);
> +	p[0] = htons(ks8995_tag);
> +	p[1] = htons(tci);
> +
> +	return skb;
> +}
> +
> +static struct sk_buff *ks8995_rcv(struct sk_buff *skb, struct net_device *dev)
> +{
> +	unsigned int port;
> +	__be16 *p;
> +	u16 etype;
> +	u16 tci;
> +
> +	if (unlikely(!pskb_may_pull(skb, KS8995_TAG_LEN))) {
> +		netdev_err(dev, "dropping packet, cannot pull\n");
> +		return NULL;
> +	}
> +
> +	p = dsa_etype_header_pos_rx(skb);
> +	etype = ntohs(p[0]);
> +
> +	if (etype == ETH_P_8021Q) {
> +		/* That's just an ordinary VLAN tag, pass through */

I hope you don't have a use case for such packets passing through.

> +		return skb;
> +	}
> +
> +	if ((etype & 0xFFF0U) != ETH_P_8021Q) {
> +		/* Not custom, just pass through */
> +		netdev_dbg(dev, "non-KS8995 ethertype 0x%04x\n", etype);
> +		return skb;
> +	}
> +
> +	port = ilog2(etype & 0xF);
> +	tci = ntohs(p[1]);
> +	netdev_dbg(dev, "ingress packet tag: %04x %04x, port %d\n",
> +		   etype, tci, port);
> +
> +	skb->dev = dsa_conduit_find_user(dev, 0, port);
> +	if (!skb->dev) {
> +		netdev_err(dev, "could not find user for port %d\n", port);
> +		return NULL;
> +	}
> +
> +	/* Remove KS8995 tag and recalculate checksum */
> +	skb_pull_rcsum(skb, KS8995_TAG_LEN);
> +
> +	dsa_strip_etype_header(skb, KS8995_TAG_LEN);
> +
> +	dsa_default_offload_fwd_mark(skb);
> +
> +	return skb;
> +}
> +
> +static const struct dsa_device_ops ks8995_netdev_ops = {
> +	.name = KS8995_NAME,
> +	.proto	= DSA_TAG_PROTO_KS8995,
> +	.xmit = ks8995_xmit,
> +	.rcv = ks8995_rcv,
> +	.needed_headroom = KS8995_TAG_LEN,

VLAN_HLEN

> +};
> +
> +MODULE_DESCRIPTION("DSA tag driver for Micrel KS8995 family of switches");
> +MODULE_LICENSE("GPL");
> +MODULE_ALIAS_DSA_TAG_DRIVER(DSA_TAG_PROTO_KS8995, KS8995_NAME);
> +
> +module_dsa_tag_driver(ks8995_netdev_ops);
> 
> -- 
> 2.52.0
> 


