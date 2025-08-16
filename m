Return-Path: <netdev+bounces-214349-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EA15CB2909F
	for <lists+netdev@lfdr.de>; Sat, 16 Aug 2025 23:09:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 058721B67BBF
	for <lists+netdev@lfdr.de>; Sat, 16 Aug 2025 21:10:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5099B30AAA4;
	Sat, 16 Aug 2025 21:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="tYE3utXF"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C803F30AAA8;
	Sat, 16 Aug 2025 21:09:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755378589; cv=none; b=IJLy0gctlmkVeM599BMJwhtOzek+Uon0mtZ6VZiWXZfRW7UV7WB3ewQdAGaCx7241JE3kzznfmL+0tnQTFX6+YlXfJd1e5LoNjv4k1ykSckBsApU1rQs82S5PUyZiuDlu90KtN0oeuD6a7iB0RG0pKgrOoNtkaOHWtYBC6lTbR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755378589; c=relaxed/simple;
	bh=cWto8LO69Sp5cqBbt/T1U5JWO1G14oPUItTEMuX41vY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qYV6sfcYIpisN/rQbbcoCSfGDgndjQ4RK/OFZf/vrPrXWDlPBblAGy7v3I+CRTCN1bQcR9aCPPwd9PfNqdrEh9FWMS1vaLK/3rhhNGPSsEMGqhL5OaPjlmP2pnWH7oY6d8a0/DtPIbX0oynjgdvZZUmRhFLuEE9ELUp9fZ9nUM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=tYE3utXF; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=HMO/5Z6obTsDx97b1SI87y6o+E+BMCOcGJF6GIZnpMg=; b=tYE3utXFBXKBas4wqT7j8BzCX5
	udKC+gykVTUuw6FHcCS5e/Rj11FI+fP/duGjwWBZLLf4Kuiypr6KFv5n4rfmc/d3yIEOnyZwMsyMC
	1s+hUav93ceLPmtPVRZzXJAw1MRxY5+OTALxAlJYIjCq6VECEcTQtIOnZYKOfN4/HjkU=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1unO9R-004vbq-Ca; Sat, 16 Aug 2025 23:09:21 +0200
Date: Sat, 16 Aug 2025 23:09:21 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Daniel Golle <daniel@makrotopia.org>
Cc: Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Hauke Mehrtens <hauke@hauke-m.de>, Simon Horman <horms@kernel.org>,
	Russell King <linux@armlinux.org.uk>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Arkadi Sharshevsky <arkadis@mellanox.com>,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
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
Subject: Re: [PATCH RFC net-next 21/23] net: dsa: add tagging driver for
 MaxLinear GSW1xx switch family
Message-ID: <94abb6ae-7dac-4cc8-9261-df2bee7080c1@lunn.ch>
References: <aKDihWrDtVpm0TfV@pidgin.makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aKDihWrDtVpm0TfV@pidgin.makrotopia.org>

> @@ -27,6 +27,7 @@ obj-$(CONFIG_NET_DSA_TAG_GSWIP) += tag_gswip.o
>  obj-$(CONFIG_NET_DSA_TAG_HELLCREEK) += tag_hellcreek.o
>  obj-$(CONFIG_NET_DSA_TAG_KSZ) += tag_ksz.o
>  obj-$(CONFIG_NET_DSA_TAG_LAN9303) += tag_lan9303.o
> +obj-$(CONFIG_NET_DSA_TAG_MXL_GSW1XX) += tag_mxl-gsw1xx.o
>  obj-$(CONFIG_NET_DSA_TAG_MTK) += tag_mtk.o
>  obj-$(CONFIG_NET_DSA_TAG_NONE) += tag_none.o
>  obj-$(CONFIG_NET_DSA_TAG_OCELOT) += tag_ocelot.o

DSA is not particularly good at sorting, many lists are not.
But this list is sorted, and MX > MT.

> +static struct sk_buff *gsw1xx_tag_xmit(struct sk_buff *skb,
> +				       struct net_device *dev)
> +{
> +	struct dsa_port *dp = dsa_user_to_port(dev);
> +	u8 *gsw1xx_tag;
> +
> +	if (!skb)
> +		return skb;

Can that happen?

> +	/* provide additional space 'GSW1XX_TX_HEADER_LEN' bytes */
> +	skb_push(skb, GSW1XX_TX_HEADER_LEN);
> +
> +	/* add space between MAC address and Ethertype */
> +	memmove(skb->data, skb->data + GSW1XX_TX_HEADER_LEN, 2 * ETH_ALEN);

dsa_alloc_etype_header() seems appropriate here.

> +
> +	/* special tag ingress */
> +	gsw1xx_tag = skb->data + 2 * ETH_ALEN;

and dsa_etype_header_pos_tx().

> +	gsw1xx_tag[0] = 0x88;
> +	gsw1xx_tag[1] = 0xc3;
> +	gsw1xx_tag[2] = GSW1XX_TX_PORT_MAP_EN | GSW1XX_TX_LRN_DIS;
> +	gsw1xx_tag[3] = BIT(dp->index + GSW1XX_TX_PORT_MAP_LOW_SHIFT) & GSW1XX_TX_PORT_MAP_LOW_MASK;
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
> +	gsw1xx_tag = skb->data - 2;

dsa_etype_header_pos_rx()

> +	if (gsw1xx_tag[0] != 0x88 && gsw1xx_tag[1] != 0xc3) {
> +		dev_warn_ratelimited(&dev->dev, "Dropping packet due to invalid special tag\n");
> +		dev_warn_ratelimited(&dev->dev,
> +				     "Tag: 0x%x, 0x%x, 0x%x, 0x%x, 0x%x, 0x%x, 0x%x, 0x%x\n",
> +				     gsw1xx_tag[0], gsw1xx_tag[1], gsw1xx_tag[2], gsw1xx_tag[3],
> +				     gsw1xx_tag[4], gsw1xx_tag[5], gsw1xx_tag[6], gsw1xx_tag[7]);
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
> +	/* remove the GSW1xx special tag between MAC addresses and the current ethertype field. */
> +	skb_pull_rcsum(skb, GSW1XX_RX_HEADER_LEN);
> +	memmove(skb->data - ETH_HLEN, skb->data - (ETH_HLEN + GSW1XX_RX_HEADER_LEN), 2 * ETH_ALEN);

dsa_strip_etype_header() might also be useful here.

    Andrew

---
pw-bot: cr

