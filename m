Return-Path: <netdev+bounces-56307-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B54AA80E79D
	for <lists+netdev@lfdr.de>; Tue, 12 Dec 2023 10:29:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 556A0B20B9C
	for <lists+netdev@lfdr.de>; Tue, 12 Dec 2023 09:29:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58C92584E3;
	Tue, 12 Dec 2023 09:29:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FTwITWbT"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39EFE219F2;
	Tue, 12 Dec 2023 09:29:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4285AC433CD;
	Tue, 12 Dec 2023 09:29:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702373391;
	bh=Ps5ITAFrTNffoKTbdr5QWix/U8BhTCkdC1mM+gT+YJg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FTwITWbTYw+hFrcKSU3lB/55PJAIeDlBwfdMAWXVb/y6soQ69TLBM42ivf9bSP61/
	 R/2niqeeprQVU6NLmXITbpY9eS/JpgW1zsPoS4SG1fSmsC/0Fx9LMXlymYxJlMXz9y
	 6OhCKlYRORSWgUC4hCAh/aw78kN2m5MKCnsf54M/4lBwDZ8TXb8FVT3CLwkqUiMphP
	 mL5etSzSNlD441R1skIQaiyo6poo9e+C8YEX4NvK2ySPADWZ/cfvMtDvoxKHBoQlwo
	 72FKMoZ4nh8sdbgr7/FsUIsE/i4Pw/mCfwcFlrn9pi5S6ZS9EQAzA62QbShepCunV+
	 WsDZ8mMuVzHaw==
Date: Tue, 12 Dec 2023 09:29:43 +0000
From: Simon Horman <horms@kernel.org>
To: Daniel Golle <daniel@makrotopia.org>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Chunfeng Yun <chunfeng.yun@mediatek.com>,
	Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Felix Fietkau <nbd@nbd.name>, John Crispin <john@phrozen.org>,
	Sean Wang <sean.wang@mediatek.com>,
	Mark Lee <Mark-MC.Lee@mediatek.com>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Alexander Couzens <lynxis@fe80.eu>,
	Qingfang Deng <dqfext@gmail.com>,
	SkyLake Huang <SkyLake.Huang@mediatek.com>,
	Philipp Zabel <p.zabel@pengutronix.de>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, linux-phy@lists.infradead.org
Subject: Re: [RFC PATCH net-next v3 5/8] net: pcs: add driver for MediaTek
 USXGMII PCS
Message-ID: <20231212092943.GS5817@kernel.org>
References: <cover.1702352117.git.daniel@makrotopia.org>
 <07845ec900ba41ff992875dce12c622277592c32.1702352117.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <07845ec900ba41ff992875dce12c622277592c32.1702352117.git.daniel@makrotopia.org>

On Tue, Dec 12, 2023 at 03:47:47AM +0000, Daniel Golle wrote:
> Add driver for USXGMII PCS found in the MediaTek MT7988 SoC and supporting
> USXGMII, 10GBase-R and 5GBase-R interface modes.
> 
> Signed-off-by: Daniel Golle <daniel@makrotopia.org>

Hi Daniel,

some minor feedback from my side.

...

> diff --git a/drivers/net/pcs/pcs-mtk-usxgmii.c b/drivers/net/pcs/pcs-mtk-usxgmii.c

...

> +static int mtk_usxgmii_pcs_config(struct phylink_pcs *pcs, unsigned int neg_mode,
> +				  phy_interface_t interface,
> +				  const unsigned long *advertising,
> +				  bool permit_pause_to_mac)
> +{
> +	struct mtk_usxgmii_pcs *mpcs = pcs_to_mtk_usxgmii_pcs(pcs);
> +	unsigned int an_ctrl = 0, link_timer = 0, xfi_mode = 0, adapt_mode = 0;
> +	bool mode_changed = false;

nit: please consider arranging local variables in networking code
     in reverse xmas tree order - longest line to shortest.

     This may be useful:
     https://github.com/ecree-solarflare/xmastree

...
> diff --git a/include/linux/pcs/pcs-mtk-usxgmii.h b/include/linux/pcs/pcs-mtk-usxgmii.h
> new file mode 100644
> index 0000000000000..ef936d9c5f116
> --- /dev/null
> +++ b/include/linux/pcs/pcs-mtk-usxgmii.h
> @@ -0,0 +1,27 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef __LINUX_PCS_MTK_USXGMII_H
> +#define __LINUX_PCS_MTK_USXGMII_H
> +
> +#include <linux/phylink.h>
> +
> +/**
> + * mtk_usxgmii_select_pcs() - Get MediaTek PCS instance
> + * @np:		Pointer to device node indentifying a MediaTek USXGMII PCS

nit: identifying

     ./scripts/checkpatch.py --codespell is your friend here.

> + * @mode:	Ethernet PHY interface mode
> + *
> + * Return PCS identified by a device node and the PHY interface mode in use
> + *
> + * Return:	Pointer to phylink PCS instance of NULL
> + */
> +#if IS_ENABLED(CONFIG_PCS_MTK_USXGMII)
> +struct phylink_pcs *mtk_usxgmii_pcs_get(struct device *dev, struct device_node *np);

nit: The kernel doc above does not match the signature
     of mtk_usxgmii_pcs_get().

     ./scripts/kernel-doc -none is helpful here.

> +void mtk_usxgmii_pcs_put(struct phylink_pcs *pcs);
> +#else
> +static inline struct phylink_pcs *mtk_usxgmii_pcs_get(struct device *dev, struct device_node *np)
> +{
> +	return NULL;
> +}
> +static inline void mtk_usxgmii_pcs_put(struct phylink_pcs *pcs) { }
> +#endif /* IS_ENABLED(CONFIG_PCS_MTK_USXGMII) */
> +
> +#endif /* __LINUX_PCS_MTK_USXGMII_H */
> -- 
> 2.43.0

