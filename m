Return-Path: <netdev+bounces-199458-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FD21AE0616
	for <lists+netdev@lfdr.de>; Thu, 19 Jun 2025 14:39:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CA4D4177BA3
	for <lists+netdev@lfdr.de>; Thu, 19 Jun 2025 12:39:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1511D23A9AB;
	Thu, 19 Jun 2025 12:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="emSXN9QN"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF34722B598;
	Thu, 19 Jun 2025 12:38:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750336738; cv=none; b=F9uF0rViXg/gRnb7BWD+z4p/kN2T2H1h7NXAYQIX5eWbyrn67xpQTv2P02RtYEItYMDFYJ3ZBix2VYA+DM+2IZdrVrsIkPChrY+yQidvJtjrFraWCZkMQd9v0A1nscTTlXDIc/tbsoR3l3GoQldllsfVTn22K2PYb3VcDiLrju0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750336738; c=relaxed/simple;
	bh=0O8KUs11HYzYDV9dS+Fjh+t+vw87oB0LvVgWoJBSoKI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r4eRbSOaP2va/NwCP9RC1DzB3l6dqKCnzMMpeAqJtj8bzdwreCrHywvCdZH0uF4dhnZ/L6vOe58ZsIlxOzSFQ1eEbfTP0HtYeN9Lu+M1r8qlLUqepN0rYCkn9ElKVvlek9fTFyFAa0N5VD10PsxKgba2B1EDj5SbkGWOToWD5Jg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=emSXN9QN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CD5EC4CEEA;
	Thu, 19 Jun 2025 12:38:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750336737;
	bh=0O8KUs11HYzYDV9dS+Fjh+t+vw87oB0LvVgWoJBSoKI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=emSXN9QNT3nkgNQTuAleo3mJHp4mZ0ARLDH9YcB5KZfxJhext93gFSgvVOAJScqdJ
	 G5fB2V2QcQ9rDIO5Sb3u0vVsPysUlfbhTkEWgCSMcF+/b/98dNvK7u7OIps8FVWID0
	 07I+/dBO6Ij7UUHpr4m9jVILeLIJimvgAmvPtmVq3TfzUfx4e5DvsYLgg0WnAnnObJ
	 AtwLwuwSY3qRoW/yFQeB4sXurSWkn2TlJGzItFPQPUgGPyje5ERerhuu21IujH8SPd
	 t2WzcvqtBzmirpKBx95bxkuNxtB8kpIWHEEI8JROzkPoQ9iMKsnIWYEX6oYkFV/Jai
	 wyVBqjyFb3gfA==
Date: Thu, 19 Jun 2025 13:38:52 +0100
From: Simon Horman <horms@kernel.org>
To: Frank Wunderlich <frank-w@public-files.de>
Cc: Frank Wunderlich <linux@fw-web.de>, Felix Fietkau <nbd@nbd.name>,
	Sean Wang <sean.wang@mediatek.com>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	Daniel Golle <daniel@makrotopia.org>, arinc.unal@arinc9.com
Subject: Re: [net-next v4 1/3] net: ethernet: mtk_eth_soc: support named IRQs
Message-ID: <20250619123852.GM1699@horms.kernel.org>
References: <20250616080738.117993-1-linux@fw-web.de>
 <20250616080738.117993-2-linux@fw-web.de>
 <9FD09C8D-A9DC-4270-AB4A-6EBE25959F12@public-files.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9FD09C8D-A9DC-4270-AB4A-6EBE25959F12@public-files.de>

On Thu, Jun 19, 2025 at 09:44:34AM +0200, Frank Wunderlich wrote:
> Am 16. Juni 2025 10:07:34 MESZ schrieb Frank Wunderlich <linux@fw-web.de>:
> >From: Frank Wunderlich <frank-w@public-files.de>
> >
> >Add named interrupts and keep index based fallback for exiting devicetrees.
> >
> >Currently only rx and tx IRQs are defined to be used with mt7988, but
> >later extended with RSS/LRO support.
> >
> >Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
> >Reviewed-by: Simon Horman <horms@kernel.org>
> >---
> >v2:
> >- move irqs loading part into own helper function
> >- reduce indentation
> >- place mtk_get_irqs helper before the irq_handler (note for simon)
> >---
> > drivers/net/ethernet/mediatek/mtk_eth_soc.c | 39 +++++++++++++++------
> > 1 file changed, 28 insertions(+), 11 deletions(-)
> >
> >diff --git a/drivers/net/ethernet/mediatek/mtk_eth_soc.c b/drivers/net/ethernet/mediatek/mtk_eth_soc.c
> >index b76d35069887..81ae8a6fe838 100644
> >--- a/drivers/net/ethernet/mediatek/mtk_eth_soc.c
> >+++ b/drivers/net/ethernet/mediatek/mtk_eth_soc.c
> >@@ -3337,6 +3337,30 @@ static void mtk_tx_timeout(struct net_device *dev, unsigned int txqueue)
> > 	schedule_work(&eth->pending_work);
> > }
> > 
> >+static int mtk_get_irqs(struct platform_device *pdev, struct mtk_eth *eth)
> >+{
> >+	int i;
> >+
> >+	eth->irq[1] = platform_get_irq_byname(pdev, "tx");
> >+	eth->irq[2] = platform_get_irq_byname(pdev, "rx");
> 
> Hi Simon,
> 
> I got information that reserved frame-engine 
>  irqs are not unusable and have no fixed
>  meaning. So i would add fe0..fe3 in
>  dts+binding and change these names from
> tx/rx to fe1 and fe2.
> 
> Can i keep your RB here?

Since the meaning is changing somewhat maybe best to drop the RB.
I'll look out for the new version to review.

