Return-Path: <netdev+bounces-161936-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C1B3CA24B71
	for <lists+netdev@lfdr.de>; Sat,  1 Feb 2025 19:47:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 964683A5C8D
	for <lists+netdev@lfdr.de>; Sat,  1 Feb 2025 18:47:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B1E91BD01D;
	Sat,  1 Feb 2025 18:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="eOIr+7wb"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E911C17557
	for <netdev@vger.kernel.org>; Sat,  1 Feb 2025 18:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738435655; cv=none; b=s3SNwlpkSiIUxFmyDsA+X7ezIsyU8y39s2pdwKkIKGURB1dOyUPnCpzWyQooT67kC2kX3ZoxcCmhaz+DGXOt4Ay1w1KI1Mx5x1Z6ZRE+OsrXneMmHDdnukAlbnHS11IAJIX3AemjwUwvXVTg3A5SisE9qsxJt35hMt8L058SKjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738435655; c=relaxed/simple;
	bh=mYXEeunVrjW0T2w6+o3H+EY6MSoNNeFcAJSZzqOpjqQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mB2afGiub9tmizM33YrfHZE3JDKOJ/rVzy50KysLaSZOHzJPDwwg+nLS562/m4tbQJ9oTjbUNF2KDhRnZFXvrEQ4s3H1dIXMd3h4M/d5N4QTWkQDqib56X25p5zLF0Z1s09RAeCHfXidZjT0+BIRCz+xRKfQYzEF4ZQGLqweCkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=eOIr+7wb; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=yS833fRfTqk4hSOqu5d67lTzJvylEPdj7NPQYtvP3fk=; b=eOIr+7wbaaPPWDE+8lnaYcvT1Z
	wrUSkrDpf6jp4cR/7ITm/bLZIyWMiz7Z7q2yZ2ik4niohDmaE3P/g1TS+A35zxXGhvVF2V2+zvrDV
	tlhKsyRocluPkIcLMR9Xc8cEoB/pS5uUtjnbjNE347qnBfuN2W7DujD7JIdbmoBG/fq8=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1teIWW-00A2Sf-9S; Sat, 01 Feb 2025 19:47:20 +0100
Date: Sat, 1 Feb 2025 19:47:20 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Biju Das <biju.das.jz@bp.renesas.com>
Cc: Felix Fietkau <nbd@nbd.name>, Sean Wang <sean.wang@mediatek.com>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Biju Das <biju.das.au@gmail.com>
Subject: Re: [PATCH] net: ethernet: mtk-star-emac: Use
 of_get_available_child_by_name()
Message-ID: <28da459d-a611-48aa-8ad1-da5f6d605442@lunn.ch>
References: <20250201162135.46443-1-biju.das.jz@bp.renesas.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250201162135.46443-1-biju.das.jz@bp.renesas.com>

On Sat, Feb 01, 2025 at 04:21:32PM +0000, Biju Das wrote:
> Use the helper of_get_available_child_by_name() to simplify
> mtk_star_mdio_init().
> 
> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> ---
> This patch is only compile tested and depend upon[1]
> [1] https://lore.kernel.org/all/20250201093126.7322-1-biju.das.jz@bp.renesas.com/
> ---
>  drivers/net/ethernet/mediatek/mtk_star_emac.c | 24 ++++---------------
>  1 file changed, 5 insertions(+), 19 deletions(-)
> 
> diff --git a/drivers/net/ethernet/mediatek/mtk_star_emac.c b/drivers/net/ethernet/mediatek/mtk_star_emac.c
> index 25989c79c92e..beb0500fe9d5 100644
> --- a/drivers/net/ethernet/mediatek/mtk_star_emac.c
> +++ b/drivers/net/ethernet/mediatek/mtk_star_emac.c
> @@ -1422,25 +1422,15 @@ static int mtk_star_mdio_init(struct net_device *ndev)
>  {
>  	struct mtk_star_priv *priv = netdev_priv(ndev);
>  	struct device *dev = mtk_star_get_dev(priv);
> -	struct device_node *of_node, *mdio_node;
> -	int ret;
> -
> -	of_node = dev->of_node;
> +	struct device_node *mdio_node _free(device_node) =
> +		of_get_available_child_by_name(dev->of_node, "mdio");

Same comment as for you other similar patch.

    Andrew

---
pw-bot: cr

