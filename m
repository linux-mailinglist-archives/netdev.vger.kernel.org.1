Return-Path: <netdev+bounces-244636-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 31335CBBDB4
	for <lists+netdev@lfdr.de>; Sun, 14 Dec 2025 17:43:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E56443006F51
	for <lists+netdev@lfdr.de>; Sun, 14 Dec 2025 16:43:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4826D281503;
	Sun, 14 Dec 2025 16:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="OH22I2af"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F6B4156237;
	Sun, 14 Dec 2025 16:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765730615; cv=none; b=CplNcZlVlqHTdrKrQ+QJHVMVKc2/1iVRAUqTyZxmBD/qvFsaqtz4I6EdAp8jYSeVg8MItq8V8NHBz0n2v8La6Ew0H2G+MUL3VZPlQmF1Sum/nnZ3wL3JU6XIDMMb9pNNG7lN5l7kXkce0oQrDNoVTe/Q2EUco4g/3TBTALgyoio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765730615; c=relaxed/simple;
	bh=Ldlxd+SWE/5owwcc7rNKslzyFVc6IwiKZXHASzrvQoQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VTHesWCGAN3O2l18oAzybsEacVm6UxzdjC6dZEsKMPbY7vmqv3VuDOb2S+wfpnEp+lZxexuWbRTxhvzjSC91/cjxT3L42wW3gGZ9Bn+MfEe/7JFtIVYBX6s2QbzauRuerImKQIqu2r/EQp/fQvjqn6zxI+A7/iAOYv6ts73dqWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=OH22I2af; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=Pg87C69KDoANHttxY5/rYmwSNvXQD1N6oOe5W7TAlAI=; b=OH22I2afa/RvDGRyP4pUNGZexE
	s3zZ09oxoSnT2SMGDFZwpgX7vgx+7Osdl4DtoZqAYXTwpaZTLBXFLRgMBJpVp5GqhZAciNWMJLptG
	OmtC9f9y8GFogObl0EPK/8EdOtttGgE5HO18j2oUE8pgEVWo4gUMDMVgr230kxbfKwKE=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vUpBg-00Gvjt-F5; Sun, 14 Dec 2025 17:43:12 +0100
Date: Sun, 14 Dec 2025 17:43:12 +0100
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
Subject: Re: [RFC net-next v3 2/3] net: ethernet: mtk_eth_soc: Add RSS support
Message-ID: <cbe399db-11b9-4176-b842-a50956df7d26@lunn.ch>
References: <20251214110310.7009-1-linux@fw-web.de>
 <20251214110310.7009-3-linux@fw-web.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251214110310.7009-3-linux@fw-web.de>

>  bpi-r4.its                                  |  16 +-

I don't think this file belongs in this patch?

> +#define MTK_RX_RSS_NUM			(eth->soc->rss_num)
> +#define MTK_RSS_HASH_KEY_DW(x)		(reg_map->pdma.rss_glo_cfg + 0x20 +	\
> +					 ((x) * 0x4))
> +#define MTK_RSS_INDR_TABLE_DW(x)	(reg_map->pdma.rss_glo_cfg + 0x50 +	\
> +					 ((x) * 0x4))

It is bad practice for a macro to access things not passed to it. At
minimum, pass eth & reg_map to the macro.

    Andrew

---
pw-bot: cr

