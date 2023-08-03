Return-Path: <netdev+bounces-24102-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B705F76EC50
	for <lists+netdev@lfdr.de>; Thu,  3 Aug 2023 16:21:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DCDF61C2158B
	for <lists+netdev@lfdr.de>; Thu,  3 Aug 2023 14:21:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E48321D54;
	Thu,  3 Aug 2023 14:21:26 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8388221D4F
	for <netdev@vger.kernel.org>; Thu,  3 Aug 2023 14:21:26 +0000 (UTC)
Received: from pandora.armlinux.org.uk (unknown [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69E322D42
	for <netdev@vger.kernel.org>; Thu,  3 Aug 2023 07:21:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=eFzPVtf9sNMYHpdawahhRpgrMEJ5xpp5eSnUaUgU15E=; b=tyJaCEOIc+Cr6kqgV54/imHjCI
	T2wC0RykQck0LS2kKsDRpOc4D5zZNdVk96H0ND8DH55aDXIuvMT2ZOGTY40nZjTY6uKiELRoFtEPn
	qpmgThvKofF6pQmzmnsLj1yaHpVRqV4X/9QZ+bwzykLGacvR1mT3LocDZ6xM4NBAhUu1Vsqt7tdza
	prGqYziVkS2YwcDTbW2lGskQ9ixCH8qe/jaUuTPbQWJTChfwFuPBXpRfqZxpOL9fv7Mcgox0Bi1cb
	IY91J643NdsInx7tp67gdkPjWzzhac9d7uVruQJtAk8EgWf1NLtFUFVv6Mh5RnqlTjp8Yz5ClixCx
	vG2lC6nA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:47956)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1qRZC9-000711-0f;
	Thu, 03 Aug 2023 15:20:53 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1qRZC5-0002za-CX; Thu, 03 Aug 2023 15:20:49 +0100
Date: Thu, 3 Aug 2023 15:20:49 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Feiyang Chen <chenfeiyang@loongson.cn>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, peppe.cavallaro@st.com,
	alexandre.torgue@foss.st.com, joabreu@synopsys.com,
	chenhuacai@loongson.cn, dongbiao@loongson.cn,
	loongson-kernel@lists.loongnix.cn, netdev@vger.kernel.org,
	loongarch@lists.linux.dev, chris.chenfeiyang@gmail.com
Subject: Re: [PATCH v3 13/16] net: stmmac: dwmac-loongson: Add 64-bit DMA and
 multi-vector support
Message-ID: <ZMu3wTCzffo1EgNY@shell.armlinux.org.uk>
References: <cover.1691047285.git.chenfeiyang@loongson.cn>
 <48ceed6b5d7b32c2e46b79fa597466b9212f745e.1691047285.git.chenfeiyang@loongson.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <48ceed6b5d7b32c2e46b79fa597466b9212f745e.1691047285.git.chenfeiyang@loongson.cn>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RDNS_NONE,
	SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Aug 03, 2023 at 07:30:34PM +0800, Feiyang Chen wrote:
> Set 64-Bit DMA for specific versions. Request allocation for multi-
> vector interrupts for DWLGMAC_CORE_1_00. If it fails, fallback to
> request allocation for single interrupts.
> 
> Signed-off-by: Feiyang Chen <chenfeiyang@loongson.cn>
> ---
>  .../ethernet/stmicro/stmmac/dwmac-loongson.c  | 83 ++++++++++++++++++-
>  1 file changed, 81 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
> index c7790f73fe18..18bca996e1cb 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
> @@ -6,11 +6,15 @@
>  #include <linux/pci.h>
>  #include <linux/dmi.h>
>  #include <linux/device.h>
> +#include <linux/interrupt.h>
>  #include <linux/of_irq.h>
> +#include "dwmac1000.h"
>  #include "stmmac.h"
>  
>  struct stmmac_pci_info {
>  	int (*setup)(struct pci_dev *pdev, struct plat_stmmacenet_data *plat);
> +	int (*config)(struct pci_dev *pdev, struct plat_stmmacenet_data *plat,
> +		      struct stmmac_resources *res);
>  };
>  
>  static void loongson_default_data(struct pci_dev *pdev,
> @@ -66,14 +70,54 @@ static int loongson_gmac_data(struct pci_dev *pdev,
>  	return 0;
>  }
>  
> +static int loongson_gmac_config(struct pci_dev *pdev,
> +				struct plat_stmmacenet_data *plat,
> +				struct stmmac_resources *res)
> +{
> +	u32 version = readl(res->addr + GMAC_VERSION);
> +
> +	switch (version & 0xff) {
> +	case DWLGMAC_CORE_1_00:
> +		plat->multi_msi_en = 1;
> +		plat->rx_queues_to_use = 8;
> +		plat->tx_queues_to_use = 8;
> +		plat->fix_channel_num = true;
> +		break;
> +	case DWMAC_CORE_3_50:
> +	case DWMAC_CORE_3_70:
> +		if (version & 0x00008000) {
> +			plat->host_dma_width = 64;
> +			plat->dma_cfg->dma64 = true;
> +		}
> +		break;
> +	default:
> +		break;
> +	}
> +
> +	plat->dma_reset_times = 5;
> +
> +	return 0;
> +}
> +
>  static struct stmmac_pci_info loongson_gmac_pci_info = {
>  	.setup = loongson_gmac_data,
> +	.config = loongson_gmac_config,
>  };
>  
> +static u32 get_irq_type(struct device_node *np)
> +{
> +	struct of_phandle_args oirq;
> +
> +	if (np && of_irq_parse_one(np, 0, &oirq) == 0 && oirq.args_count == 2)
> +		return oirq.args[1];
> +
> +	return IRQF_TRIGGER_RISING;
> +}
> +

I do wish that there was some IRQ maintainer I could bounce this over to
for them to comment on, because I don't believe that this should be
necessary in any driver - the irq subsystem should configure the IRQ
accordingly before the driver is probed.

But since I don't know that code, and can't be bothered at this point
to read through it and DT yet again, I don't feel qualified to comment
on this...

Maybe someone else can be bothered to comment on it...

If not, then I suppose it will have to do as-is, and maybe someone at
a later date can fix it if it needs fixing.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

