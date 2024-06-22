Return-Path: <netdev+bounces-105875-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D439913575
	for <lists+netdev@lfdr.de>; Sat, 22 Jun 2024 19:58:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1258C1F20F94
	for <lists+netdev@lfdr.de>; Sat, 22 Jun 2024 17:58:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1865217BD9;
	Sat, 22 Jun 2024 17:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="jC/eivzC"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C02A18651;
	Sat, 22 Jun 2024 17:57:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719079078; cv=none; b=uEUGxFl/rY1qhOPw+LcOZetjKTV/UtlVbW6RlpDEMiS2Fjggex/uT94E3dJEPsvQ59x8P1EG1YPadFC7UmEIT9AlcJIQNT4xIghH/mSsKh0jxb2VYoBV80Ki4Us60PJxP6g8dY1cochoyMuP785Lo4nwma7VO1OG0PxIBrV/jnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719079078; c=relaxed/simple;
	bh=LSL9n44PIihUwfzRMiyoFw3MRq+NQAIMz/KPKcOLalE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gUgIFVaXWmGrBaWXykD8NciX+2LD36gm8rTOuf9MTNvmQYY+83krGbN/oGDxL7/+OVxWjNXtvbvfmX1/OuAbByMzk4UPIlhziXxT4JZys3OblCq8yc5vrZA0fcjymioX/yWWEWMkTIpP0Zpsqei09U1lHhNQREGpg/eG6md61xc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=jC/eivzC; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=sho0YEtylyTdxRMAe/P6DP0zx9R/I3yEuyq+9GO9Z+w=; b=jC/eivzCjUTarhfN4rS1OMJO7C
	DD55tiV9uU05Fd+pR8gHsAHW9dmXNdQ0ZbAgVK77KIf0H+pdEK/Ecpej5Ow4bBL5pIuoOMUvzieDC
	uVcZaO64jdDaHWe0KE8VRhCdjwfVFORWEtTGCdN0bRbFCGQQb/ppqjr9jMIKCMIv6Jns=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sL4zg-000k8W-1M; Sat, 22 Jun 2024 19:57:44 +0200
Date: Sat, 22 Jun 2024 19:57:44 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Sky Huang <SkyLake.Huang@mediatek.com>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Daniel Golle <daniel@makrotopia.org>,
	Qingfang Deng <dqfext@gmail.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	Steven Liu <Steven.Liu@mediatek.com>
Subject: Re: [PATCH net-next v8 11/13] net: phy: add driver for built-in 2.5G
 ethernet PHY on MT7988
Message-ID: <86e5c28a-42dd-432b-8bd7-2ccc4567520f@lunn.ch>
References: <20240621122045.30732-1-SkyLake.Huang@mediatek.com>
 <20240621122045.30732-12-SkyLake.Huang@mediatek.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240621122045.30732-12-SkyLake.Huang@mediatek.com>

On Fri, Jun 21, 2024 at 08:20:43PM +0800, Sky Huang wrote:
> From: "SkyLake.Huang" <skylake.huang@mediatek.com>
> 
> Add support for internal 2.5Gphy on MT7988. This driver will load
> necessary firmware, add appropriate time delay and figure out LED.
> Also, certain control registers will be set to fix link-up issues.
> 
> Signed-off-by: SkyLake.Huang <skylake.huang@mediatek.com>
> ---
> Changes in v8:
> - Replace tr_modify with mtk_tr_modify and fix alignment.
> - Remove unnecessary outer parens of "supported_triggers" var.
> - Align declarations in mtk_2p5gephy_driver[]. At first, some of them are
> ".foo<tab>= method_foo", and others are ".bar<space>= method_bar".
> Use space instead for all of them here.
> ---
>  MAINTAINERS                          |   1 +
>  drivers/net/phy/mediatek/Kconfig     |  11 +
>  drivers/net/phy/mediatek/Makefile    |   1 +
>  drivers/net/phy/mediatek/mtk-2p5ge.c | 435 +++++++++++++++++++++++++++
>  4 files changed, 448 insertions(+)
>  create mode 100644 drivers/net/phy/mediatek/mtk-2p5ge.c
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index e58e05c..fe380f2 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -13793,6 +13793,7 @@ M:	Qingfang Deng <dqfext@gmail.com>
>  M:	SkyLake Huang <SkyLake.Huang@mediatek.com>
>  L:	netdev@vger.kernel.org
>  S:	Maintained
> +F:	drivers/net/phy/mediatek/mtk-2p5ge.c
>  F:	drivers/net/phy/mediatek/mtk-ge-soc.c
>  F:	drivers/net/phy/mediatek/mtk-phy-lib.c
>  F:	drivers/net/phy/mediatek/mtk-ge.c
> diff --git a/drivers/net/phy/mediatek/Kconfig b/drivers/net/phy/mediatek/Kconfig
> index 448bc20..1490352 100644
> --- a/drivers/net/phy/mediatek/Kconfig
> +++ b/drivers/net/phy/mediatek/Kconfig
> @@ -25,3 +25,14 @@ config MEDIATEK_GE_SOC_PHY
>  	  the MT7981 and MT7988 SoCs. These PHYs need calibration data
>  	  present in the SoCs efuse and will dynamically calibrate VCM
>  	  (common-mode voltage) during startup.
> +
> +config MEDIATEK_2P5GE_PHY
> +	tristate "MediaTek 2.5Gb Ethernet PHYs"
> +	depends on (ARM64 && ARCH_MEDIATEK) || COMPILE_TEST
> +	select MTK_NET_PHYLIB
> +	help
> +	  Supports MediaTek SoC built-in 2.5Gb Ethernet PHYs.
> +
> +	  This will load necessary firmware and add appropriate time delay.
> +	  Accelerate this procedure through internal pbus instead of MDIO
> +	  bus. Certain link-up issues will also be fixed here.
> diff --git a/drivers/net/phy/mediatek/Makefile b/drivers/net/phy/mediatek/Makefile
> index 814879d..c6db8ab 100644
> --- a/drivers/net/phy/mediatek/Makefile
> +++ b/drivers/net/phy/mediatek/Makefile
> @@ -2,3 +2,4 @@
>  obj-$(CONFIG_MTK_NET_PHYLIB)		+= mtk-phy-lib.o
>  obj-$(CONFIG_MEDIATEK_GE_PHY)		+= mtk-ge.o
>  obj-$(CONFIG_MEDIATEK_GE_SOC_PHY)	+= mtk-ge-soc.o
> +obj-$(CONFIG_MEDIATEK_2P5GE_PHY)	+= mtk-2p5ge.o
> diff --git a/drivers/net/phy/mediatek/mtk-2p5ge.c b/drivers/net/phy/mediatek/mtk-2p5ge.c
> new file mode 100644
> index 0000000..f3efcc4
> --- /dev/null
> +++ b/drivers/net/phy/mediatek/mtk-2p5ge.c
> @@ -0,0 +1,435 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +#include <linux/bitfield.h>
> +#include <linux/firmware.h>
> +#include <linux/module.h>
> +#include <linux/nvmem-consumer.h>
> +#include <linux/of_address.h>
> +#include <linux/of_platform.h>
> +#include <linux/pinctrl/consumer.h>
> +#include <linux/phy.h>
> +#include <linux/pm_domain.h>
> +#include <linux/pm_runtime.h>
> +
> +#include "mtk.h"
> +
> +#define MTK_2P5GPHY_ID_MT7988	(0x00339c11)
> +
> +#define MT7988_2P5GE_PMB "mediatek/mt7988/i2p5ge-phy-pmb.bin"

You probably want a MODULE_FIRMWARE() so the firmware gets placed into
the initrd.

> +#define BASE100T_STATUS_EXTEND		(0x10)
> +#define BASE1000T_STATUS_EXTEND		(0x11)
> +#define EXTEND_CTRL_AND_STATUS		(0x16)

These don't appear to be used.

      Andrew

