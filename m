Return-Path: <netdev+bounces-186179-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C9805A9D604
	for <lists+netdev@lfdr.de>; Sat, 26 Apr 2025 01:08:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 13BAA4E0E1C
	for <lists+netdev@lfdr.de>; Fri, 25 Apr 2025 23:08:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76EFA296D2A;
	Fri, 25 Apr 2025 23:08:34 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 669B8219A81;
	Fri, 25 Apr 2025 23:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745622514; cv=none; b=tLZ/ovqrNdPHPIc8HxPKAnvXnoMj3lq1An+5Hx3rxyI3RIPrm5sBq5Bz33k9rf5J4Bpfz4F30OSTl+dqx2jYZBynEd8XCT5wqcOnDTUIQYQs27Kn3P+MhxpStpCa45n74bs2GoxEvjhi9ASJGtMUxPV/g6SfaySqIgj0Ij6yEMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745622514; c=relaxed/simple;
	bh=QSlpVdCmty8zjinThYVRSUQ7qHMcIae9ToWwHSZ5E44=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bduRahpRC6iUS0ZJ/kWu63pYIjGvCszHklA324gSVIV9DS7DiERaSboRADqxqmdlYwBCTq2tYKI5kzVAEQtzZLpBxQx8svAEAxUz9l7CvwbWE6toV88se7lJJ00J6gdAY6LTmJDTAR1zeEwhwctfs2eIKfnFE/LIXFD9CqKa20c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.98.2)
	(envelope-from <daniel@makrotopia.org>)
	id 1u8S3r-000000006ep-4AcF;
	Fri, 25 Apr 2025 23:08:19 +0000
Date: Sat, 26 Apr 2025 00:08:16 +0100
From: Daniel Golle <daniel@makrotopia.org>
To: Felix Fietkau <nbd@nbd.name>, John Crispin <john@phrozen.org>,
	Eric Woudstra <ericwouds@gmail.com>, Elad Yifee <eladwf@gmail.com>,
	Bo-Cun Chen <bc-bocun.chen@mediatek.com>,
	Sky Huang <skylake.huang@mediatek.com>,
	Sean Wang <sean.wang@mediatek.com>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: Re: [PATCH net-next] net: ethernet: mtk_eth_soc: add support for
 MT7988 internal 2.5G PHY
Message-ID: <aAwV4AOKYs3TljM0@makrotopia.org>
References: <ab77dc679ed7d9669e82d8efeab41df23b524b1f.1745617638.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ab77dc679ed7d9669e82d8efeab41df23b524b1f.1745617638.git.daniel@makrotopia.org>

On Fri, Apr 25, 2025 at 10:51:18PM +0100, Daniel Golle wrote:
> The MediaTek MT7988 SoC comes with an single built-in Ethernet PHY
> supporting 2500Base-T/1000Base-T/100Base-TX/10Base-T link partners in
> addition to the built-in MT7531-like 1GE switch. The built-in PHY only
> supports full duplex.
> 
> Add muxes allowing to select GMAC2->2.5G PHY path and add basic support
> for XGMAC as the built-in 2.5G PHY is internally connected via XGMII.
> The XGMAC features will also be used by 5GBase-R, 10GBase-R and USXGMII
> SerDes modes which are going to be added once support for standalone PCS
> drivers is in place.
> 
> In order to make use of the built-in 2.5G PHY the appropriate PHY driver
> as well as (proprietary) PHY firmware has to be present as well.
> 
> Signed-off-by: Daniel Golle <daniel@makrotopia.org>
> ---
> [...]
> diff --git a/drivers/net/ethernet/mediatek/mtk_eth_soc.h b/drivers/net/ethernet/mediatek/mtk_eth_soc.h
> index 88ef2e9c50fc..e3a8b24dd3d3 100644
> --- a/drivers/net/ethernet/mediatek/mtk_eth_soc.h
> +++ b/drivers/net/ethernet/mediatek/mtk_eth_soc.h
> [...]
> @@ -587,6 +603,10 @@
>  #define GEPHY_MAC_SEL          BIT(1)
>  
>  /* Top misc registers */
> +#define TOP_MISC_NETSYS_PCS_MUX	0x84

This offset still assumes topmisc syscon to start at 0x11d10000.
If the pending series[1] adding that syscon at 0x11d10084 gets merged
first, this offset will have to be changed to
#define TOP_MISC_NETSYS_PCS_MUX	0x0

[1]: https://patchwork.kernel.org/project/linux-mediatek/patch/20250422132438.15735-8-linux@fw-web.de/

