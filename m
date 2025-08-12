Return-Path: <netdev+bounces-213019-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 85A64B22DBF
	for <lists+netdev@lfdr.de>; Tue, 12 Aug 2025 18:35:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5078A684949
	for <lists+netdev@lfdr.de>; Tue, 12 Aug 2025 16:26:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 369BB2F8BE0;
	Tue, 12 Aug 2025 16:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="XK5e7/n/"
X-Original-To: netdev@vger.kernel.org
Received: from lelvem-ot02.ext.ti.com (lelvem-ot02.ext.ti.com [198.47.23.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDA1A2F8BFE;
	Tue, 12 Aug 2025 16:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755015977; cv=none; b=bwWZcpDvbtvqlxf2P8R1sy7a6YvpLAgz3FyTbH01DrohFLEvY9vIxHMut2A+3t1nMARRnSo2lzu3JWKK/ecKrZKU+kBGByCHOh2R4bb4DMBD0xE957rWSg+icj1Rkz/GFSys8G/phoUv6vU9CmxykHU6Kiaq4na1+Lzio4DMY/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755015977; c=relaxed/simple;
	bh=mERfh/S4RUDhW5Z1CFSz/aH4PfqzLX4p+kfBZfUrQrg=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=JzSvtRZoK3TqhJ+MSRTlLBYKb9cphmWmyv4S/sAAfhZ3sI02rncL9zq6Fy02ru58xpe7keHtUxULG4SM8hU07URHWYmL49SqbYoJRyEF+1EsosMNuk0T2S2jELd+iASv7qX8T3gzvRa6TJTqKh0tf1xBJ71vCJPqssuXuhyE1TY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=XK5e7/n/; arc=none smtp.client-ip=198.47.23.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllvem-sh03.itg.ti.com ([10.64.41.86])
	by lelvem-ot02.ext.ti.com (8.15.2/8.15.2) with ESMTP id 57CGPNAj1947279;
	Tue, 12 Aug 2025 11:25:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1755015923;
	bh=0svE4w2w2DMu3Hngj9bv0Qop7RXmrRjLkTtIJIaYnvQ=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=XK5e7/n/Sl6c6Y0Jy8DL+HixLNzbUwJ1hXPvzRo6xQ+8olG/dqg25LkKflPBVfN9T
	 9lzlGxBoX0WI5lbjJJTq/g0RrvAQx6ghhJnsVkBsHnlpTWyPfssCK6F6L2zTe4o1pV
	 Wfa4ocY4q4f5qlXUrxK48G24bILqV7oauRTFTOwA=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
	by fllvem-sh03.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 57CGPMXw3939979
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Tue, 12 Aug 2025 11:25:22 -0500
Received: from DFLE104.ent.ti.com (10.64.6.25) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Tue, 12
 Aug 2025 11:25:22 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Tue, 12 Aug 2025 11:25:22 -0500
Received: from [10.249.130.61] ([10.249.130.61])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 57CGPBC3631375;
	Tue, 12 Aug 2025 11:25:12 -0500
Message-ID: <d77189ec-b1ee-4718-9212-c7208da40814@ti.com>
Date: Tue, 12 Aug 2025 21:55:11 +0530
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/5] net: rnpgbe: Add n500/n210 chip support
To: Dong Yibo <dong100@mucse.com>, <andrew+netdev@lunn.ch>,
        <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>, <horms@kernel.org>, <corbet@lwn.net>,
        <gur.stavi@huawei.com>, <maddy@linux.ibm.com>, <mpe@ellerman.id.au>,
        <danishanwar@ti.com>, <lee@trager.us>, <gongfan1@huawei.com>,
        <lorenzo@kernel.org>, <geert+renesas@glider.be>,
        <Parthiban.Veerasooran@microchip.com>, <lukas.bulwahn@redhat.com>,
        <alexanderduyck@fb.com>, <richardcochran@gmail.com>
CC: <netdev@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20250812093937.882045-1-dong100@mucse.com>
 <20250812093937.882045-3-dong100@mucse.com>
Content-Language: en-US
From: "Anwar, Md Danish" <a0501179@ti.com>
In-Reply-To: <20250812093937.882045-3-dong100@mucse.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea



On 8/12/2025 3:09 PM, Dong Yibo wrote:
> Initialize n500/n210 chip bar resource map and
> dma, eth, mbx ... info for future use.
> 
> Signed-off-by: Dong Yibo <dong100@mucse.com>
> ---
>  drivers/net/ethernet/mucse/rnpgbe/Makefile    |   3 +-
>  drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h    |  60 +++++++++
>  .../net/ethernet/mucse/rnpgbe/rnpgbe_chip.c   |  88 ++++++++++++++
>  drivers/net/ethernet/mucse/rnpgbe/rnpgbe_hw.h |  12 ++
>  .../net/ethernet/mucse/rnpgbe/rnpgbe_main.c   | 115 ++++++++++++++++++
>  5 files changed, 277 insertions(+), 1 deletion(-)
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
> index 23c84454e7c7..0dd3d3cb2a4d 100644
> --- a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h
> +++ b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h
> @@ -4,18 +4,78 @@
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
> +	rnpgbe_hw_unknow
> +};


The enum value name should be "rnpgbe_hw_unknown" not "rnpgbe_hw_unknow"
(missing 'n').

> +
> +struct mucse_dma_info {
> +	void __iomem *dma_base_addr;
> +	void __iomem *dma_ring_addr;
> +	void *back;
> +	u32 dma_version;
> +};
> +
> +struct mucse_eth_info {
> +	void __iomem *eth_base_addr;
> +	void *back;
> +};
> +
> +struct mucse_mac_info {
> +	void __iomem *mac_addr;
> +	void *back;
> +};
> +
> +struct mucse_mbx_info {
> +	/* fw <--> pf mbx */
> +	u32 fw_pf_shm_base;
> +	u32 pf2fw_mbox_ctrl;
> +	u32 pf2fw_mbox_mask;
> +	u32 fw_pf_mbox_mask;
> +	u32 fw2pf_mbox_vec;
> +};
> +
> +struct mucse_hw {
> +	void *back;
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
>  	u16 bd_number;
>  };
>  
> +struct rnpgbe_info {
> +	int total_queue_pair_cnts;
> +	enum rnpgbe_hw_type hw_type;
> +	void (*init)(struct mucse_hw *hw);
> +};
> +
>  /* Device IDs */
>  #define PCI_VENDOR_ID_MUCSE 0x8848
>  #define PCI_DEVICE_ID_N500_QUAD_PORT 0x8308
> diff --git a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_chip.c b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_chip.c
> new file mode 100644
> index 000000000000..20ec67c9391e
> --- /dev/null
> +++ b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_chip.c
> @@ -0,0 +1,88 @@
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
> +	dma->back = hw;
> +
> +	eth->eth_base_addr = hw->hw_addr + RNPGBE_ETH_BASE;
> +	eth->back = hw;
> +
> +	mac->mac_addr = hw->hw_addr + RNPGBE_MAC_BASE;
> +	mac->back = hw;
> +}
> +
> +/**
> + * rnpgbe_init_n500 - Setup n500 hw info
> + * @hw: hw information structure
> + *
> + * rnpgbe_init_n500 initializes all private
> + * structure, such as dma, eth, mac and mbx base on
> + * hw->addr for n500
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
> +
> +/**
> + * rnpgbe_init_n210 - Setup n210 hw info
> + * @hw: hw information structure
> + *
> + * rnpgbe_init_n210 initializes all private
> + * structure, such as dma, eth, mac and mbx base on
> + * hw->addr for n210
> + **/
> +static void rnpgbe_init_n210(struct mucse_hw *hw)
> +{
> +	struct mucse_mbx_info *mbx = &hw->mbx;
> +
> +	rnpgbe_init_common(hw);
> +
> +	mbx->fw2pf_mbox_vec = 0x29400;
> +	mbx->fw_pf_shm_base = 0x2d900;
> +	mbx->pf2fw_mbox_ctrl = 0x2e900;
> +	mbx->fw_pf_mbox_mask = 0x2eb00;
> +	hw->ring_msix_base = hw->hw_addr + 0x29000;
> +	hw->usecstocount = 62;
> +}

I don't see pf2fw_mbox_mask getting initialized anywhere. Is that not
needed?

> +
> +const struct rnpgbe_info rnpgbe_n500_info = {


-- 
Thanks and Regards,
Md Danish Anwar


