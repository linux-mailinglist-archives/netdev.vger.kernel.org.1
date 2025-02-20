Return-Path: <netdev+bounces-168310-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 94F93A3E77E
	for <lists+netdev@lfdr.de>; Thu, 20 Feb 2025 23:25:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D22D219C4100
	for <lists+netdev@lfdr.de>; Thu, 20 Feb 2025 22:25:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD6E21F1506;
	Thu, 20 Feb 2025 22:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mt3Te2Ft"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 849A41EA7EA;
	Thu, 20 Feb 2025 22:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740090337; cv=none; b=bpkbmqqMOFN9UMFuaAMiXKEe8cDLZQjJFj1pXqHtqDIQdxnInjmOG4tvT3vVUIfuy19eq8/xAlZCLa964V3fQTXcKHwSw363rUU98hgubj/j3tQNmp2+COE33qsZM/9z1uaXDLX+Riyjg6N82irh7IBhOi7VosY1P7OO262CkIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740090337; c=relaxed/simple;
	bh=RJiaUdl2RvW6e22DMN7RYxWmy6sBbotkEMjdbKNhlxo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gfWi32ylnMxBswRaJfUI8N4sDqH2Mj5ld4Q1n68H/MOgv8lbzcCDCwZ3O69C9AUxZMAH1D03sb+OVfyi9AX2qnjTktKcrvNiG0LEhgG7kXkwdhNb4XoZm4/JJgipog9qYLNxd40zj6S5ddA4NcngLp8iYLMDjudNkh5w2TByi9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Mt3Te2Ft; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC3B2C4CED1;
	Thu, 20 Feb 2025 22:25:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740090336;
	bh=RJiaUdl2RvW6e22DMN7RYxWmy6sBbotkEMjdbKNhlxo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Mt3Te2FtyuZ+yp9KJmQeaNyj3kpDuuTeR+PBQW/1mCbe7JTKrTjx8EGBVUxmw1kh+
	 o7r9iBQwNO5Cm1v3zGj9O0hBG9MCaAcp4bz/hLnbXCrt9I4AFo/m2niXpaOW4ybJPP
	 l/mfC53NKy6Kgjq2SgeFv1sjbhtKpeAtxUwsr/XoyAhREgfPOzuBVhalr2FHwereKU
	 x4h0DbVXYV/sE6NE2lO4efiXAkEAsbPg69xW9l3adGU56I8apAjAMJGGRRxt0iD1rk
	 Efpye7hidjorq4dfja4hFPFvSFSINokwNxIKbJuLkkwhucnnJFFh9ekJ+lgxISlN6q
	 VHraLlyodNQQw==
Date: Thu, 20 Feb 2025 14:25:35 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Felix Fietkau <nbd@nbd.name>, Sean Wang
 <sean.wang@mediatek.com>, Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Philipp Zabel <p.zabel@pengutronix.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, "Chester A. Unal" <chester.a.unal@arinc9.com>,
 Daniel Golle <daniel@makrotopia.org>, DENG Qingfang <dqfext@gmail.com>,
 Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>,
 netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
 upstream@airoha.com
Subject: Re: [PATCH net-next v5 05/15] net: airoha: Move DSA tag in DMA
 descriptor
Message-ID: <20250220142535.584b0423@kernel.org>
In-Reply-To: <20250217-airoha-en7581-flowtable-offload-v5-5-28be901cb735@kernel.org>
References: <20250217-airoha-en7581-flowtable-offload-v5-0-28be901cb735@kernel.org>
	<20250217-airoha-en7581-flowtable-offload-v5-5-28be901cb735@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 17 Feb 2025 14:01:09 +0100 Lorenzo Bianconi wrote:
> +static u32 airoha_get_dsa_tag(struct sk_buff *skb, struct net_device *dev)
> +{
> +#if IS_ENABLED(CONFIG_NET_DSA)
> +	struct ethhdr *ehdr;
> +	struct dsa_port *dp;
> +	u8 xmit_tpid;
> +	u16 tag;
> +
> +	if (!netdev_uses_dsa(dev))
> +		return 0;
> +
> +	dp = dev->dsa_ptr;
> +	if (IS_ERR(dp))
> +		return 0;
> +
> +	if (dp->tag_ops->proto != DSA_TAG_PROTO_MTK)
> +		return 0;
> +
> +	if (skb_ensure_writable(skb, ETH_HLEN))
> +		return 0;

skb_cow_head() is a lot cheaper (for TCP)

> +	ehdr = (struct ethhdr *)skb->data;
> +	tag = be16_to_cpu(ehdr->h_proto);
> +	xmit_tpid = tag >> 8;

> @@ -2390,8 +2498,10 @@ static int airoha_probe(struct platform_device *pdev)
>  	for (i = 0; i < ARRAY_SIZE(eth->ports); i++) {
>  		struct airoha_gdm_port *port = eth->ports[i];
>  
> -		if (port && port->dev->reg_state == NETREG_REGISTERED)
> +		if (port && port->dev->reg_state == NETREG_REGISTERED) {
> +			airoha_metadata_dst_free(port);
>  			unregister_netdev(port->dev);

Looks a tiny bit reversed, isn't it?
First unregister the netdev, then free its metadata.

> +		}
>  	}
>  	free_netdev(eth->napi_dev);
>  	platform_set_drvdata(pdev, NULL);
> @@ -2416,6 +2526,7 @@ static void airoha_remove(struct platform_device *pdev)
>  			continue;
>  
>  		airoha_dev_stop(port->dev);
> +		airoha_metadata_dst_free(port);
>  		unregister_netdev(port->dev);

same here

>  	}
>  	free_netdev(eth->napi_dev);

