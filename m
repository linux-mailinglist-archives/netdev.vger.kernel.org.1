Return-Path: <netdev+bounces-161939-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F306BA24B7C
	for <lists+netdev@lfdr.de>; Sat,  1 Feb 2025 19:55:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CA6313A6611
	for <lists+netdev@lfdr.de>; Sat,  1 Feb 2025 18:55:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C4BD1C7B62;
	Sat,  1 Feb 2025 18:55:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="CsDUTUmU"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F348B17557
	for <netdev@vger.kernel.org>; Sat,  1 Feb 2025 18:55:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738436148; cv=none; b=ewSvWFq39EPf3qC3BM9YSpTjVt59aB1CONy+0P5xypPQLICjwPGc5u1deutv+6CztzSKovW/LUeTHy/+8132Zbs7DPvWXPgcqwYytfadk5UUmXdvl9eKKfPMKrszsyCp9KwThxM3zZmvzXNhDKQcJsmXQ9pWY/6J9DwoxdFsfVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738436148; c=relaxed/simple;
	bh=ur8cvHdGaWvdrEluZRBt0ObKyGFdTdMcpUfQ3cuPYXE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YwaIw0mjvfMwizQpC1qZve2B97RvUfOh+alxqU1sEvJbv/aTh/QJHsbDBNGaqZ8T6h2VA58vO6n1n+l1YViFL3L/ekRGrxP7i7Km1e97GneSxA6QSRDEvzPtCEDQBgrBhBsYLh4WHTGkXJ3mBz4LbQyHHjByQy2PXtFG2f+qtRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=CsDUTUmU; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=hXottbKrzMtxg7raCfDXdUUAenpabP+oslp6hK4XRyA=; b=CsDUTUmUU7xfLO1MF1r4UnhbVS
	/+BYdqqVd7ZpFKVZWsHBYN+JNYhOQBKDIDUlUd6eFHCj+Ik4NaxbulnQ+1qREUvEvgR8o7hg6ZaAz
	bpKX3NN9old/Qq7xEbhlA0MWhq259gJljgSainpnvEhBt4wZ0+h25ewONiAaeVlrP9yE=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1teIeW-00A2aY-Au; Sat, 01 Feb 2025 19:55:36 +0100
Date: Sat, 1 Feb 2025 19:55:36 +0100
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
Subject: Re: [PATCH] net: ethernet: mtk_eth_soc: Use
 of_get_available_child_by_name()
Message-ID: <3e7538bb-6877-4dff-9cab-5a398884d34f@lunn.ch>
References: <20250201172258.56148-1-biju.das.jz@bp.renesas.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250201172258.56148-1-biju.das.jz@bp.renesas.com>

> +	struct device_node *mii_np _free(device_node) =
> +		of_get_available_child_by_name(eth->dev->of_node, "mdio-bus");

    Andrew

---
pw-bot: cr

