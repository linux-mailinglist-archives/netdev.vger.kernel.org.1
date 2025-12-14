Return-Path: <netdev+bounces-244637-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 2690CCBBDBD
	for <lists+netdev@lfdr.de>; Sun, 14 Dec 2025 17:50:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9DAA43007C94
	for <lists+netdev@lfdr.de>; Sun, 14 Dec 2025 16:50:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7066727EFEE;
	Sun, 14 Dec 2025 16:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="K6AYswP9"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C03021A83F9;
	Sun, 14 Dec 2025 16:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765731000; cv=none; b=mKz+bTufcgprD4TWyG018UxK5CbdNR8PeRonG8Y1Rte1riBPSnWO3d2M8PDN7JjCAbRiBlE9CLOYGB8zGffoskiiINWwAqGgzxmbBQOYcHSm1XOHEFvQ2UsP8/lR4uBllY6Vb8vLwjCroC8mWj+2buWXiBou8R3lTQy8++twzKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765731000; c=relaxed/simple;
	bh=pF2zLSY0KxjArw8QEe6eLu0bH5ACR76aug0YGRULhm8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g8gNk08q1ycSlvZFej6no3uovm9/UhZbqNg64kB1ZlJptR1bkFL73F7EWuCU24hahOixfQxumyS4Ebgc+6RwzxhSp6+lVbmFjPBlZoECtY2u4CIFYssrb8ICBrNmC7N1UbhKSHiuDMUa7sVzGAY1tNvZzMday82zwhfadjks/uM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=K6AYswP9; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=QwWNAca6IA5vmr33BT6LB87k+Vr0WcFKaaVLLN0k/Nc=; b=K6AYswP9380Ujw+zJp4aPgckjG
	v7RaMAYynrjPlMGXf97mGism4HRCRMAeq2v8ERlKUevs9EmXSlARn1PT/e9yZlIjZdzX77gfHfdyE
	bxvWHLdKkTe6aDBzrRoLrUrOlt8gV1JtV5ZlsfvQ5+Ps4+N4nEttU37YS3Lx3ZzWEbUo=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vUpHz-00Gvmp-Mz; Sun, 14 Dec 2025 17:49:43 +0100
Date: Sun, 14 Dec 2025 17:49:43 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Frank Wunderlich <linux@fw-web.de>
Cc: Felix Fietkau <nbd@nbd.name>, Sean Wang <sean.wang@mediatek.com>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Russell King <linux@armlinux.org.uk>,
	Frank Wunderlich <frank-w@public-files.de>,
	Daniel Golle <daniel@makrotopia.org>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	Mason Chang <mason-cw.chang@mediatek.com>
Subject: Re: [RFC net-next v3 3/3] net: ethernet: mtk_eth_soc: Add LRO support
Message-ID: <2e00738e-6d17-4ba6-8af4-7e02783b17da@lunn.ch>
References: <20251214110310.7009-1-linux@fw-web.de>
 <20251214110310.7009-4-linux@fw-web.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251214110310.7009-4-linux@fw-web.de>

>  static int mtk_hwlro_rx_init(struct mtk_eth *eth)
>  {
>  	const struct mtk_reg_map *reg_map = eth->soc->reg_map;
> -	int i;
> +	const struct mtk_soc_data *soc = eth->soc;
> +	int i, val;
>  	u32 ring_ctrl_dw1 = 0, ring_ctrl_dw2 = 0, ring_ctrl_dw3 = 0;
>  	u32 lro_ctrl_dw0 = 0, lro_ctrl_dw3 = 0;

Reverse Christmas tree. It looks like it was already broken, but you
should not make it worse, and i think you can even fix it here.

> +static int mtk_hwlro_add_ipaddr_idx(struct net_device *dev, u32 ip4dst)
> +{
> +	struct mtk_mac *mac = netdev_priv(dev);
> +	struct mtk_eth *eth = mac->hw;
> +	const struct mtk_reg_map *reg_map = eth->soc->reg_map;
> +	u32 reg_val;
> +	int i;

More Reverse Christmas tree probes. You will need to move the
assignment to reg_map into the body of the function.

> +#define MTK_PDMA_LRO_CTRL_DW0	(reg_map->pdma.lro_ctrl_dw0)
> +#define MTK_PDMA_LRO_CTRL_DW1	(reg_map->pdma.lro_ctrl_dw0 + 0x04)
> +#define MTK_PDMA_LRO_CTRL_DW2	(reg_map->pdma.lro_ctrl_dw0 + 0x08)
> +#define MTK_PDMA_LRO_CTRL_DW3	(reg_map->pdma.lro_ctrl_dw0 + 0x0c)

Same comment as the previous patch.

	Andrew

