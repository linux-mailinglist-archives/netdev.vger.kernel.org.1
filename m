Return-Path: <netdev+bounces-213692-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 50D8BB26503
	for <lists+netdev@lfdr.de>; Thu, 14 Aug 2025 14:08:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 775622A3A57
	for <lists+netdev@lfdr.de>; Thu, 14 Aug 2025 12:08:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F7A72FC899;
	Thu, 14 Aug 2025 12:08:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="rueauJ5R"
X-Original-To: netdev@vger.kernel.org
Received: from lelvem-ot02.ext.ti.com (lelvem-ot02.ext.ti.com [198.47.23.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25C472FC889;
	Thu, 14 Aug 2025 12:08:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755173321; cv=none; b=AUzeC8SgoqstRLO7gPAbOSR1vslp7ViClx2ihUs30Z8Op9yu5QkNH0dndp5Nn72nem9Zhk11mXsQXKl2q9uuxmQf9CNEHDrlTUgfu+oj1dALoqUJii8OE0dB6DVtuFpUi/EIs0ZIAynWvuAy9Zt/7PWCp9Bkr/yaCMOjmWP2DwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755173321; c=relaxed/simple;
	bh=I93VlVOJProf6GUAvlPX+GK4JwdxGhkQUVPWmypw+EY=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=F96GgZwwHaTmh4i/ZdLB/ETJB7nFNTo7tioDYXDrXQL5QFDGyV7FKRMSN1K2KT1KCWNI6kgqyXpAtmoFNnYWUUErNRlCCDCkI9cxg5AMNfUbaRF6QLa+6CnkfUoUpmQ+2PX4RM09c7uPgXfUUsiyg39MQZ7nLN7+KOhV2UAkFc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=rueauJ5R; arc=none smtp.client-ip=198.47.23.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllvem-sh03.itg.ti.com ([10.64.41.86])
	by lelvem-ot02.ext.ti.com (8.15.2/8.15.2) with ESMTP id 57EC7Tgj2376138;
	Thu, 14 Aug 2025 07:07:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1755173249;
	bh=XnS9iucL55LRf3nUvtmDFTQqhw9YTWJHMvHDM/O8QKQ=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=rueauJ5RDCTkk6CGad6l6/CXVYyE7dEItp5e9/gRmn/AulTIhBuAz0d5MclhHuK2l
	 4KIzgq8EfSfNlaTaOw0AOxKubx+iJ2AKfu2ueDYQnS99tUHBc8dBqAC5AHzr24bCxK
	 aLyVxcCWbl0P8fzj+yxbNqILInAXTg9tZknhh7g8=
Received: from DFLE106.ent.ti.com (dfle106.ent.ti.com [10.64.6.27])
	by fllvem-sh03.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 57EC7SvT1134283
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Thu, 14 Aug 2025 07:07:28 -0500
Received: from DFLE107.ent.ti.com (10.64.6.28) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Thu, 14
 Aug 2025 07:07:28 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Thu, 14 Aug 2025 07:07:28 -0500
Received: from [172.24.231.152] (danish-tpc.dhcp.ti.com [172.24.231.152])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 57EC7MJj3884391;
	Thu, 14 Aug 2025 07:07:22 -0500
Message-ID: <8a041e8e-b9a8-4bd9-ab1a-de66f943dea6@ti.com>
Date: Thu, 14 Aug 2025 17:37:21 +0530
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/5] net: rnpgbe: Add n500/n210 chip support
To: Dong Yibo <dong100@mucse.com>, <andrew+netdev@lunn.ch>,
        <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>, <horms@kernel.org>, <corbet@lwn.net>,
        <gur.stavi@huawei.com>, <maddy@linux.ibm.com>, <mpe@ellerman.id.au>,
        <lee@trager.us>, <gongfan1@huawei.com>, <lorenzo@kernel.org>,
        <geert+renesas@glider.be>, <Parthiban.Veerasooran@microchip.com>,
        <lukas.bulwahn@redhat.com>, <alexanderduyck@fb.com>,
        <richardcochran@gmail.com>
CC: <netdev@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20250814073855.1060601-1-dong100@mucse.com>
 <20250814073855.1060601-3-dong100@mucse.com>
Content-Language: en-US
From: MD Danish Anwar <danishanwar@ti.com>
In-Reply-To: <20250814073855.1060601-3-dong100@mucse.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea



On 14/08/25 1:08 pm, Dong Yibo wrote:
> Initialize n500/n210 chip bar resource map and
> dma, eth, mbx ... info for future use.
> 
> Signed-off-by: Dong Yibo <dong100@mucse.com>
> ---
>  drivers/net/ethernet/mucse/rnpgbe/Makefile    |   3 +-
>  drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h    |  55 +++++++++
>  .../net/ethernet/mucse/rnpgbe/rnpgbe_chip.c   |  85 +++++++++++++
>  drivers/net/ethernet/mucse/rnpgbe/rnpgbe_hw.h |  12 ++
>  .../net/ethernet/mucse/rnpgbe/rnpgbe_main.c   | 112 ++++++++++++++++++
>  5 files changed, 266 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/net/ethernet/mucse/rnpgbe/rnpgbe_chip.c
>  create mode 100644 drivers/net/ethernet/mucse/rnpgbe/rnpgbe_hw.h
> 
> diff --git a/drivers/net/ethernet/mucse/rnpgbe/Makefile b/drivers/net/ethernet/mucse/rnpgbe/Makefile
> index 9df536f0d04c..42c359f459d9 100644
> --- a/drivers/net/ethernet/mucse/rnpgbe/Makefile
> +++ b/drivers/net/ethernet/mucse/rnpgbe/Makefile
> @@ -5,4 +5,5 @@
>  #
>  
>  obj-$(CONFIG_MGBE) += rnpgbe.o
> -rnpgbe-objs := rnpgbe_main.o
> +rnpgbe-objs := rnpgbe_main.o\
> +	       rnpgbe_chip.o
> diff --git a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h
> index 64b2c093bc6e..08faac3a67af 100644
> --- a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h
> +++ b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h
> @@ -4,15 +4,70 @@
>  #ifndef _RNPGBE_H
>  #define _RNPGBE_H
>  
> +#include <linux/types.h>
> +
> +extern const struct rnpgbe_info rnpgbe_n500_info;
> +extern const struct rnpgbe_info rnpgbe_n210_info;
> +extern const struct rnpgbe_info rnpgbe_n210L_info;
> +
>  enum rnpgbe_boards {
>  	board_n500,
>  	board_n210,
>  	board_n210L,
>  };
>  
> +enum rnpgbe_hw_type {
> +	rnpgbe_hw_n500 = 0,
> +	rnpgbe_hw_n210,
> +	rnpgbe_hw_n210L,
> +	rnpgbe_hw_unknown
> +};
> +
> +struct mucse_dma_info {
> +	void __iomem *dma_base_addr;
> +	void __iomem *dma_ring_addr;
> +	u32 dma_version;
> +};
> +
> +struct mucse_eth_info {
> +	void __iomem *eth_base_addr;
> +};
> +
> +struct mucse_mac_info {
> +	void __iomem *mac_addr;
> +};
> +
> +struct mucse_mbx_info {
> +	/* fw <--> pf mbx */
> +	u32 fw_pf_shm_base;
> +	u32 pf2fw_mbox_ctrl;
> +	u32 fw_pf_mbox_mask;
> +	u32 fw2pf_mbox_vec;
> +};
> +
> +struct mucse_hw {
> +	void __iomem *hw_addr;
> +	void __iomem *ring_msix_base;
> +	struct pci_dev *pdev;
> +	enum rnpgbe_hw_type hw_type;
> +	struct mucse_dma_info dma;
> +	struct mucse_eth_info eth;
> +	struct mucse_mac_info mac;
> +	struct mucse_mbx_info mbx;
> +	u32 driver_version;
> +	u16 usecstocount;
> +};
> +
>  struct mucse {
>  	struct net_device *netdev;
>  	struct pci_dev *pdev;
> +	struct mucse_hw hw;
> +};
> +
> +struct rnpgbe_info {
> +	int total_queue_pair_cnts;
> +	enum rnpgbe_hw_type hw_type;
> +	void (*init)(struct mucse_hw *hw);
>  };
>  
>  /* Device IDs */
> diff --git a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_chip.c b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_chip.c
> new file mode 100644
> index 000000000000..79aefd7e335d
> --- /dev/null
> +++ b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_chip.c
> @@ -0,0 +1,85 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Copyright(c) 2020 - 2025 Mucse Corporation. */
> +
> +#include "rnpgbe.h"
> +#include "rnpgbe_hw.h"
> +
> +/**
> + * rnpgbe_init_common - Setup common attribute
> + * @hw: hw information structure
> + **/
> +static void rnpgbe_init_common(struct mucse_hw *hw)
> +{
> +	struct mucse_dma_info *dma = &hw->dma;
> +	struct mucse_eth_info *eth = &hw->eth;
> +	struct mucse_mac_info *mac = &hw->mac;
> +
> +	dma->dma_base_addr = hw->hw_addr;
> +	dma->dma_ring_addr = hw->hw_addr + RNPGBE_RING_BASE;
> +
> +	eth->eth_base_addr = hw->hw_addr + RNPGBE_ETH_BASE;
> +
> +	mac->mac_addr = hw->hw_addr + RNPGBE_MAC_BASE;
> +}
> +
> +/**
> + * rnpgbe_init_n500 - Setup n500 hw info
> + * @hw: hw information structure
> + *
> + * rnpgbe_init_n500 initializes all private
> + * structure, such as dma, eth, mac and mbx base on
> + * hw->hw_addr for n500
> + **/
> +static void rnpgbe_init_n500(struct mucse_hw *hw)
> +{
> +	struct mucse_mbx_info *mbx = &hw->mbx;
> +
> +	rnpgbe_init_common(hw);
> +
> +	mbx->fw2pf_mbox_vec = 0x28b00;
> +	mbx->fw_pf_shm_base = 0x2d000;
> +	mbx->pf2fw_mbox_ctrl = 0x2e000;
> +	mbx->fw_pf_mbox_mask = 0x2e200;
> +	hw->ring_msix_base = hw->hw_addr + 0x28700;
> +	hw->usecstocount = 125;
> +}

These hardcoded values should be defined in rnpgbe_hw.h as macros rather
than using magic numbers.

> +
> +/**
> + * rnpgbe_init_n210 - Setup n210 hw info

> +static int rnpgbe_add_adapter(struct pci_dev *pdev,
> +			      const struct rnpgbe_info *info)
> +{
> +	struct net_device *netdev;
> +	void __iomem *hw_addr;
> +	struct mucse *mucse;
> +	struct mucse_hw *hw;
> +	u32 dma_version = 0;
> +	u32 queues;
> +	int err;
> +
> +	queues = info->total_queue_pair_cnts;
> +	netdev = alloc_etherdev_mq(sizeof(struct mucse), queues);
> +	if (!netdev)
> +		return -ENOMEM;
> +
> +	SET_NETDEV_DEV(netdev, &pdev->dev);
> +	mucse = netdev_priv(netdev);
> +	mucse->netdev = netdev;
> +	mucse->pdev = pdev;
> +	pci_set_drvdata(pdev, mucse);
> +
> +	hw = &mucse->hw;
> +	hw->hw_type = info->hw_type;
> +	hw->pdev = pdev;
> +
> +	switch (hw->hw_type) {
> +	case rnpgbe_hw_n500:
> +		hw_addr = devm_ioremap(&pdev->dev,
> +				       pci_resource_start(pdev, 2),
> +				       pci_resource_len(pdev, 2));
> +		if (!hw_addr) {
> +			err = -EIO;
> +			goto err_free_net;
> +		}
> +
> +		dma_version = readl(hw_addr);
> +		break;
> +	case rnpgbe_hw_n210:
> +	case rnpgbe_hw_n210L:
> +		hw_addr = devm_ioremap(&pdev->dev,
> +				       pci_resource_start(pdev, 2),
> +				       pci_resource_len(pdev, 2));
> +		if (!hw_addr) {
> +			err = -EIO;
> +			goto err_free_net;
> +		}
> +
> +		dma_version = readl(hw_addr);
> +		break;

The code in both case branches is identical. Remove the switch statement
and use the common code instead.

> +	default:
> +		err = -EIO;
> +		goto err_free_net;
> +	}
> +	hw->hw_addr = hw_addr;
> +	hw->dma.dma_version = dma_version;
> +	hw->driver_version = 0x0002040f;
> +	info->init(hw);
> +	return 0;
> +
> +err_free_net:
> +	free_netdev(netdev);
> +	return err;
> +}
> +


-- 
Thanks and Regards,
Danish


