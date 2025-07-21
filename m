Return-Path: <netdev+bounces-208620-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 42729B0C61B
	for <lists+netdev@lfdr.de>; Mon, 21 Jul 2025 16:21:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8AE693AFBEA
	for <lists+netdev@lfdr.de>; Mon, 21 Jul 2025 14:21:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 322B92D94A9;
	Mon, 21 Jul 2025 14:21:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="NibAJOcY"
X-Original-To: netdev@vger.kernel.org
Received: from out-177.mta1.migadu.com (out-177.mta1.migadu.com [95.215.58.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E64AA2D77FA
	for <netdev@vger.kernel.org>; Mon, 21 Jul 2025 14:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753107694; cv=none; b=ikGhnDsjJiAwElKivYa71u1ZXjEcemQErz0BN0ma+2oOXh1J2joRvGOHuqWUHFZxS36b+Y7c7QS2WVrBAfJskwT9Runfqrvb0jFVZHSr88A4vm++cwWIixejKCakO0Z8XrTzHYeTaPBbnRj5wIbf4lcGpQzijNe2Vuhi1HHeSEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753107694; c=relaxed/simple;
	bh=PTWSl+wAEhXohoDtp9bVp5FIerEdPinZroN3Hbl7BSY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ekxO17xOjVtnAd5L5aFQRAIxNLXUCsqYXRNxq1twv92WOMixXI1NYpIAfJ2d/bC594JHb5oc4TG1tbebJxQsKjBjOOqU7eP88PM56zGlSBQKiozws+ygcNKpq5z6o7PUoRztA9ZVs/AvAD+OA5ChXyxSqmrji3bIFu7nPAC948Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=NibAJOcY; arc=none smtp.client-ip=95.215.58.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <b4233af1-7143-402b-a45c-379c39edf274@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1753107688;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KF58D9MGsLNUYJPC/+9oNbaKPqecsAp57941TID+TE8=;
	b=NibAJOcY8cWSKRZykmD3aK5y5oaFU4cqzAJz45wCEdzhwG/5d3V2bS8tGeI4aIeX33juUz
	ybPHzbl0VEknxZkO+V0PLynaWpV6BlGg6U4LuP4s62qmYrzpMmoD/Wve2g26CnbRmCbw9U
	70zHIGitc8KnkGchjTFBW3p5JWcHX48=
Date: Mon, 21 Jul 2025 15:21:23 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v2 02/15] net: rnpgbe: Add n500/n210 chip support
To: Dong Yibo <dong100@mucse.com>, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, corbet@lwn.net, gur.stavi@huawei.com,
 maddy@linux.ibm.com, mpe@ellerman.id.au, danishanwar@ti.com, lee@trager.us,
 gongfan1@huawei.com, lorenzo@kernel.org, geert+renesas@glider.be,
 Parthiban.Veerasooran@microchip.com, lukas.bulwahn@redhat.com,
 alexanderduyck@fb.com, richardcochran@gmail.com
Cc: netdev@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250721113238.18615-1-dong100@mucse.com>
 <20250721113238.18615-3-dong100@mucse.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20250721113238.18615-3-dong100@mucse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 21/07/2025 12:32, Dong Yibo wrote:
> Initialize n500/n210 chip bar resource map and
> dma, eth, mbx ... info for future use.
> 
> Signed-off-by: Dong Yibo <dong100@mucse.com>
> ---
>   drivers/net/ethernet/mucse/rnpgbe/Makefile    |   4 +-
>   drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h    | 138 ++++++++++++++++++
>   .../net/ethernet/mucse/rnpgbe/rnpgbe_chip.c   | 138 ++++++++++++++++++
>   drivers/net/ethernet/mucse/rnpgbe/rnpgbe_hw.h |  27 ++++
>   .../net/ethernet/mucse/rnpgbe/rnpgbe_main.c   |  68 ++++++++-
>   5 files changed, 370 insertions(+), 5 deletions(-)
>   create mode 100644 drivers/net/ethernet/mucse/rnpgbe/rnpgbe_chip.c
>   create mode 100644 drivers/net/ethernet/mucse/rnpgbe/rnpgbe_hw.h
> 
> diff --git a/drivers/net/ethernet/mucse/rnpgbe/Makefile b/drivers/net/ethernet/mucse/rnpgbe/Makefile
> index 0942e27f5913..42c359f459d9 100644
> --- a/drivers/net/ethernet/mucse/rnpgbe/Makefile
> +++ b/drivers/net/ethernet/mucse/rnpgbe/Makefile
> @@ -5,5 +5,5 @@
>   #
>   
>   obj-$(CONFIG_MGBE) += rnpgbe.o
> -
> -rnpgbe-objs := rnpgbe_main.o
> +rnpgbe-objs := rnpgbe_main.o\
> +	       rnpgbe_chip.o
> diff --git a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h
> index 224e395d6be3..2ae836fc8951 100644
> --- a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h
> +++ b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h
> @@ -4,21 +4,156 @@
>   #ifndef _RNPGBE_H
>   #define _RNPGBE_H
>   
> +#include <linux/types.h>
> +#include <linux/netdevice.h>
> +
> +extern const struct rnpgbe_info rnpgbe_n500_info;
> +extern const struct rnpgbe_info rnpgbe_n210_info;
> +extern const struct rnpgbe_info rnpgbe_n210L_info;
> +
>   enum rnpgbe_boards {
>   	board_n500,
>   	board_n210,
>   	board_n210L,
>   };
>   
> +enum rnpgbe_hw_type {
> +	rnpgbe_hw_n500 = 0,
> +	rnpgbe_hw_n210,
> +	rnpgbe_hw_n210L,
> +	rnpgbe_hw_unknow
> +};
> +
> +struct mucse_dma_info {
> +	u8 __iomem *dma_base_addr;
> +	u8 __iomem *dma_ring_addr;
> +	void *back;
> +	u32 max_tx_queues;
> +	u32 max_rx_queues;
> +	u32 dma_version;
> +};
> +
> +#define RNPGBE_MAX_MTA 128
> +struct mucse_eth_info {
> +	u8 __iomem *eth_base_addr;
> +	void *back;
> +	u32 mta_shadow[RNPGBE_MAX_MTA];
> +	int mc_filter_type;
> +	u32 mcft_size;
> +	u32 vft_size;
> +	u32 num_rar_entries;
> +};
> +
> +struct mii_regs {
> +	unsigned int addr; /* MII Address */
> +	unsigned int data; /* MII Data */
> +	unsigned int addr_shift; /* MII address shift */
> +	unsigned int reg_shift; /* MII reg shift */
> +	unsigned int addr_mask; /* MII address mask */
> +	unsigned int reg_mask; /* MII reg mask */
> +	unsigned int clk_csr_shift;
> +	unsigned int clk_csr_mask;
> +};
> +
> +struct mucse_mac_info {
> +	u8 __iomem *mac_addr;
> +	void *back;
> +	struct mii_regs mii;
> +	int phy_addr;
> +	int clk_csr;
> +};
> +
> +#define MAX_VF_NUM (8)
> +
> +struct mucse_mbx_info {
> +	u32 timeout;
> +	u32 usec_delay;
> +	u32 v2p_mailbox;
> +	u16 size;
> +	u16 vf_req[MAX_VF_NUM];
> +	u16 vf_ack[MAX_VF_NUM];
> +	u16 fw_req;
> +	u16 fw_ack;
> +	/* lock for only one use mbx */
> +	struct mutex lock;
> +	bool irq_enabled;
> +	int mbx_size;
> +	int mbx_mem_size;
> +#define MBX_FEATURE_NO_ZERO BIT(0)
> +#define MBX_FEATURE_WRITE_DELAY BIT(1)
> +	u32 mbx_feature;
> +	/* fw <--> pf mbx */
> +	u32 fw_pf_shm_base;
> +	u32 pf2fw_mbox_ctrl;
> +	u32 pf2fw_mbox_mask;
> +	u32 fw_pf_mbox_mask;
> +	u32 fw2pf_mbox_vec;
> +	/* pf <--> vf mbx */
> +	u32 pf_vf_shm_base;
> +	u32 pf2vf_mbox_ctrl_base;
> +	u32 pf_vf_mbox_mask_lo;
> +	u32 pf_vf_mbox_mask_hi;
> +	u32 pf2vf_mbox_vec_base;
> +	u32 vf2pf_mbox_vec_base;
> +	u32 fw_vf_share_ram;
> +	int share_size;
> +};
> +
> +struct mucse_hw {
> +	void *back;
> +	u8 pfvfnum;
> +	u8 pfvfnum_system;
> +	u8 __iomem *hw_addr;
> +	u8 __iomem *ring_msix_base;
> +	struct pci_dev *pdev;
> +	u16 device_id;
> +	u16 vendor_id;
> +	u16 subsystem_device_id;
> +	u16 subsystem_vendor_id;
> +	enum rnpgbe_hw_type hw_type;
> +	struct mucse_dma_info dma;
> +	struct mucse_eth_info eth;
> +	struct mucse_mac_info mac;
> +	struct mucse_mbx_info mbx;
> +#define M_NET_FEATURE_SG BIT(0)
> +#define M_NET_FEATURE_TX_CHECKSUM BIT(1)
> +#define M_NET_FEATURE_RX_CHECKSUM BIT(2)
> +#define M_NET_FEATURE_TSO BIT(3)
> +#define M_NET_FEATURE_TX_UDP_TUNNEL BIT(4)
> +#define M_NET_FEATURE_VLAN_FILTER BIT(5)
> +#define M_NET_FEATURE_VLAN_OFFLOAD BIT(6)
> +#define M_NET_FEATURE_RX_NTUPLE_FILTER BIT(7)
> +#define M_NET_FEATURE_TCAM BIT(8)
> +#define M_NET_FEATURE_RX_HASH BIT(9)
> +#define M_NET_FEATURE_RX_FCS BIT(10)
> +#define M_NET_FEATURE_HW_TC BIT(11)
> +#define M_NET_FEATURE_USO BIT(12)
> +#define M_NET_FEATURE_STAG_FILTER BIT(13)
> +#define M_NET_FEATURE_STAG_OFFLOAD BIT(14)
> +#define M_NET_FEATURE_VF_FIXED BIT(15)
> +#define M_VEB_VLAN_MASK_EN BIT(16)
> +#define M_HW_FEATURE_EEE BIT(17)
> +#define M_HW_SOFT_MASK_OTHER_IRQ BIT(18)
> +	u32 feature_flags;
> +	u16 usecstocount;
> +};
> +
>   struct mucse {
>   	struct net_device *netdev;
>   	struct pci_dev *pdev;
> +	struct mucse_hw hw;
>   	/* board number */
>   	u16 bd_number;
>   
>   	char name[60];
>   };
>   
> +struct rnpgbe_info {
> +	int total_queue_pair_cnts;
> +	enum rnpgbe_hw_type hw_type;
> +	void (*get_invariants)(struct mucse_hw *hw);
> +};
> +
>   /* Device IDs */
>   #ifndef PCI_VENDOR_ID_MUCSE
>   #define PCI_VENDOR_ID_MUCSE 0x8848
> @@ -30,4 +165,7 @@ struct mucse {
>   #define PCI_DEVICE_ID_N210 0x8208
>   #define PCI_DEVICE_ID_N210L 0x820a
>   
> +#define m_rd_reg(reg) readl(reg)
> +#define m_wr_reg(reg, val) writel((val), reg)
> +
>   #endif /* _RNPGBE_H */
> diff --git a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_chip.c b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_chip.c
> new file mode 100644
> index 000000000000..38c094965db9
> --- /dev/null
> +++ b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_chip.c
> @@ -0,0 +1,138 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Copyright(c) 2020 - 2025 Mucse Corporation. */
> +
> +#include <linux/types.h>
> +#include <linux/string.h>
> +
> +#include "rnpgbe.h"
> +#include "rnpgbe_hw.h"
> +
> +/**
> + * rnpgbe_get_invariants_n500 - setup for hw info
> + * @hw: hw information structure
> + *
> + * rnpgbe_get_invariants_n500 initializes all private
> + * structure, such as dma, eth, mac and mbx base on
> + * hw->addr for n500
> + **/
> +static void rnpgbe_get_invariants_n500(struct mucse_hw *hw)
> +{
> +	struct mucse_dma_info *dma = &hw->dma;
> +	struct mucse_eth_info *eth = &hw->eth;
> +	struct mucse_mac_info *mac = &hw->mac;
> +	struct mucse_mbx_info *mbx = &hw->mbx;
> +
> +	/* setup msix base */
> +	hw->ring_msix_base = hw->hw_addr + 0x28700;
> +	/* setup dma info */
> +	dma->dma_base_addr = hw->hw_addr;
> +	dma->dma_ring_addr = hw->hw_addr + RNPGBE_RING_BASE;
> +	dma->max_tx_queues = RNPGBE_MAX_QUEUES;
> +	dma->max_rx_queues = RNPGBE_MAX_QUEUES;
> +	dma->back = hw;
> +	/* setup eth info */
> +	eth->eth_base_addr = hw->hw_addr + RNPGBE_ETH_BASE;
> +	eth->back = hw;
> +	eth->mc_filter_type = 0;
> +	eth->mcft_size = RNPGBE_MC_TBL_SIZE;
> +	eth->vft_size = RNPGBE_VFT_TBL_SIZE;
> +	eth->num_rar_entries = RNPGBE_RAR_ENTRIES;
> +	/* setup mac info */
> +	mac->mac_addr = hw->hw_addr + RNPGBE_MAC_BASE;
> +	mac->back = hw;
> +	/* set mac->mii */
> +	mac->mii.addr = RNPGBE_MII_ADDR;
> +	mac->mii.data = RNPGBE_MII_DATA;
> +	mac->mii.addr_shift = 11;
> +	mac->mii.addr_mask = 0x0000F800;
> +	mac->mii.reg_shift = 6;
> +	mac->mii.reg_mask = 0x000007C0;
> +	mac->mii.clk_csr_shift = 2;
> +	mac->mii.clk_csr_mask = GENMASK(5, 2);
> +	mac->clk_csr = 0x02; /* csr 25M */
> +	/* hw fixed phy_addr */
> +	mac->phy_addr = 0x11;
> +
> +	mbx->mbx_feature |= MBX_FEATURE_NO_ZERO;
> +	/* mbx offset */
> +	mbx->vf2pf_mbox_vec_base = 0x28900;
> +	mbx->fw2pf_mbox_vec = 0x28b00;
> +	mbx->pf_vf_shm_base = 0x29000;
> +	mbx->mbx_mem_size = 64;
> +	mbx->pf2vf_mbox_ctrl_base = 0x2a100;
> +	mbx->pf_vf_mbox_mask_lo = 0x2a200;
> +	mbx->pf_vf_mbox_mask_hi = 0;
> +	mbx->fw_pf_shm_base = 0x2d000;
> +	mbx->pf2fw_mbox_ctrl = 0x2e000;
> +	mbx->fw_pf_mbox_mask = 0x2e200;
> +	mbx->fw_vf_share_ram = 0x2b000;
> +	mbx->share_size = 512;
> +
> +	/* setup net feature here */
> +	hw->feature_flags |= M_NET_FEATURE_SG |
> +			     M_NET_FEATURE_TX_CHECKSUM |
> +			     M_NET_FEATURE_RX_CHECKSUM |
> +			     M_NET_FEATURE_TSO |
> +			     M_NET_FEATURE_VLAN_FILTER |
> +			     M_NET_FEATURE_VLAN_OFFLOAD |
> +			     M_NET_FEATURE_RX_NTUPLE_FILTER |
> +			     M_NET_FEATURE_RX_HASH |
> +			     M_NET_FEATURE_USO |
> +			     M_NET_FEATURE_RX_FCS |
> +			     M_NET_FEATURE_STAG_FILTER |
> +			     M_NET_FEATURE_STAG_OFFLOAD;
> +	/* start the default ahz, update later */
> +	hw->usecstocount = 125;
> +}
> +
> +/**
> + * rnpgbe_get_invariants_n210 - setup for hw info
> + * @hw: hw information structure
> + *
> + * rnpgbe_get_invariants_n210 initializes all private
> + * structure, such as dma, eth, mac and mbx base on
> + * hw->addr for n210
> + **/
> +static void rnpgbe_get_invariants_n210(struct mucse_hw *hw)
> +{
> +	struct mucse_mbx_info *mbx = &hw->mbx;
> +	/* get invariants based from n500 */
> +	rnpgbe_get_invariants_n500(hw);

it's not a good pattern. if you have some configuration that is
shared amoung devices, it's better to create *base() or *common()
helper and call it from each specific initializer. BTW, why do you
name these functions get_invariants*()? They don't get anything, but
rather init/setup configuration values. It's better to rename it
according to the function.

> +
> +	/* update msix base */
> +	hw->ring_msix_base = hw->hw_addr + 0x29000;
> +	/* update mbx offset */
> +	mbx->vf2pf_mbox_vec_base = 0x29200;
> +	mbx->fw2pf_mbox_vec = 0x29400;
> +	mbx->pf_vf_shm_base = 0x29900;
> +	mbx->mbx_mem_size = 64;
> +	mbx->pf2vf_mbox_ctrl_base = 0x2aa00;
> +	mbx->pf_vf_mbox_mask_lo = 0x2ab00;
> +	mbx->pf_vf_mbox_mask_hi = 0;
> +	mbx->fw_pf_shm_base = 0x2d900;
> +	mbx->pf2fw_mbox_ctrl = 0x2e900;
> +	mbx->fw_pf_mbox_mask = 0x2eb00;
> +	mbx->fw_vf_share_ram = 0x2b900;
> +	mbx->share_size = 512;
> +	/* update hw feature */
> +	hw->feature_flags |= M_HW_FEATURE_EEE;
> +	hw->usecstocount = 62;
> +}
> +
> +const struct rnpgbe_info rnpgbe_n500_info = {
> +	.total_queue_pair_cnts = RNPGBE_MAX_QUEUES,
> +	.hw_type = rnpgbe_hw_n500,
> +	.get_invariants = &rnpgbe_get_invariants_n500,
> +};
> +
> +const struct rnpgbe_info rnpgbe_n210_info = {
> +	.total_queue_pair_cnts = RNPGBE_MAX_QUEUES,
> +	.hw_type = rnpgbe_hw_n210,
> +	.get_invariants = &rnpgbe_get_invariants_n210,
> +};
> +
> +const struct rnpgbe_info rnpgbe_n210L_info = {
> +	.total_queue_pair_cnts = RNPGBE_MAX_QUEUES,
> +	.hw_type = rnpgbe_hw_n210L,
> +	.get_invariants = &rnpgbe_get_invariants_n210,
> +};
> diff --git a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_hw.h b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_hw.h
> new file mode 100644
> index 000000000000..2c7372a5e88d
> --- /dev/null
> +++ b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_hw.h
> @@ -0,0 +1,27 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/* Copyright(c) 2020 - 2025 Mucse Corporation. */
> +
> +#ifndef _RNPGBE_HW_H
> +#define _RNPGBE_HW_H
> +/*                     BAR                   */
> +/* ----------------------------------------- */
> +/*      module  | size  |  start   |    end  */
> +/*      DMA     | 32KB  | 0_0000H  | 0_7FFFH */
> +/*      ETH     | 64KB  | 1_0000H  | 1_FFFFH */
> +/*      MAC     | 32KB  | 2_0000H  | 2_7FFFH */
> +/*      MSIX    | 32KB  | 2_8000H  | 2_FFFFH */
> +
> +#define RNPGBE_RING_BASE (0x1000)
> +#define RNPGBE_MAC_BASE (0x20000)
> +#define RNPGBE_ETH_BASE (0x10000)
> +/* chip resourse */
> +#define RNPGBE_MAX_QUEUES (8)
> +/* multicast control table */
> +#define RNPGBE_MC_TBL_SIZE (128)
> +/* vlan filter table */
> +#define RNPGBE_VFT_TBL_SIZE (128)
> +#define RNPGBE_RAR_ENTRIES (32)

no need for extra parentheses

> +
> +#define RNPGBE_MII_ADDR 0x00000010 /* MII Address */
> +#define RNPGBE_MII_DATA 0x00000014 /* MII Data */
> +#endif /* _RNPGBE_HW_H */
> diff --git a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_main.c b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_main.c
> index 13b49875006b..08f773199e9b 100644
> --- a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_main.c
> +++ b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_main.c
> @@ -11,6 +11,11 @@
>   #include "rnpgbe.h"
>   
>   char rnpgbe_driver_name[] = "rnpgbe";
> +static const struct rnpgbe_info *rnpgbe_info_tbl[] = {
> +	[board_n500] = &rnpgbe_n500_info,
> +	[board_n210] = &rnpgbe_n210_info,
> +	[board_n210L] = &rnpgbe_n210L_info,
> +};
>   
>   /* rnpgbe_pci_tbl - PCI Device ID Table
>    *
> @@ -33,6 +38,7 @@ static struct pci_device_id rnpgbe_pci_tbl[] = {
>   /**
>    * rnpgbe_add_adapter - add netdev for this pci_dev
>    * @pdev: PCI device information structure
> + * @ii: chip info structure
>    *
>    * rnpgbe_add_adapter initializes a netdev for this pci_dev
>    * structure. Initializes Bar map, private structure, and a
> @@ -40,16 +46,24 @@ static struct pci_device_id rnpgbe_pci_tbl[] = {
>    *
>    * @return: 0 on success, negative on failure
>    **/
> -static int rnpgbe_add_adapter(struct pci_dev *pdev)
> +static int rnpgbe_add_adapter(struct pci_dev *pdev,
> +			      const struct rnpgbe_info *ii)
>   {
>   	struct mucse *mucse = NULL;
> +	struct mucse_hw *hw = NULL;
> +	u8 __iomem *hw_addr = NULL;
>   	struct net_device *netdev;
>   	static int bd_number;
> +	u32 dma_version = 0;
> +	int err = 0;
> +	u32 queues;
>   
> -	netdev = alloc_etherdev_mq(sizeof(struct mucse), 1);
> +	queues = ii->total_queue_pair_cnts;
> +	netdev = alloc_etherdev_mq(sizeof(struct mucse), queues);
>   	if (!netdev)
>   		return -ENOMEM;
>   
> +	SET_NETDEV_DEV(netdev, &pdev->dev);
>   	mucse = netdev_priv(netdev);
>   	mucse->netdev = netdev;
>   	mucse->pdev = pdev;
> @@ -58,7 +72,54 @@ static int rnpgbe_add_adapter(struct pci_dev *pdev)
>   		 rnpgbe_driver_name, mucse->bd_number);
>   	pci_set_drvdata(pdev, mucse);
>   
> +	hw = &mucse->hw;
> +	hw->back = mucse;
> +	hw->hw_type = ii->hw_type;
> +
> +	switch (hw->hw_type) {
> +	case rnpgbe_hw_n500:
> +		/* n500 use bar2 */
> +		hw_addr = devm_ioremap(&pdev->dev,
> +				       pci_resource_start(pdev, 2),
> +				       pci_resource_len(pdev, 2));
> +		if (!hw_addr) {
> +			dev_err(&pdev->dev, "map bar2 failed!\n");
> +			return -EIO;
> +		}
> +
> +		/* get dma version */
> +		dma_version = m_rd_reg(hw_addr);
> +		break;
> +	case rnpgbe_hw_n210:
> +	case rnpgbe_hw_n210L:
> +		/* check bar0 to load firmware */
> +		if (pci_resource_len(pdev, 0) == 0x100000)
> +			return -EIO;
> +		/* n210 use bar2 */
> +		hw_addr = devm_ioremap(&pdev->dev,
> +				       pci_resource_start(pdev, 2),
> +				       pci_resource_len(pdev, 2));
> +		if (!hw_addr) {
> +			dev_err(&pdev->dev, "map bar2 failed!\n");
> +			return -EIO;
> +		}
> +
> +		/* get dma version */
> +		dma_version = m_rd_reg(hw_addr);
> +		break;
> +	default:
> +		err = -EIO;
> +		goto err_free_net;
> +	}
> +	hw->hw_addr = hw_addr;
> +	hw->dma.dma_version = dma_version;
> +	ii->get_invariants(hw);
> +
>   	return 0;
> +
> +err_free_net:
> +	free_netdev(netdev);
> +	return err;
>   }

You have err_free_net label, which is used only in really impossible
case of unknown device, while other cases can return directly and
memleak netdev...


>   
>   /**
> @@ -74,6 +135,7 @@ static int rnpgbe_add_adapter(struct pci_dev *pdev)
>    **/
>   static int rnpgbe_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>   {
> +	const struct rnpgbe_info *ii = rnpgbe_info_tbl[id->driver_data];
>   	int err;
>   
>   	err = pci_enable_device_mem(pdev);
> @@ -97,7 +159,7 @@ static int rnpgbe_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>   
>   	pci_set_master(pdev);
>   	pci_save_state(pdev);
> -	err = rnpgbe_add_adapter(pdev);
> +	err = rnpgbe_add_adapter(pdev, ii);
>   	if (err)
>   		goto err_regions;
>   


