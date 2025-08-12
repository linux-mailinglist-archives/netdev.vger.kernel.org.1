Return-Path: <netdev+bounces-213025-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AD7EB22DFB
	for <lists+netdev@lfdr.de>; Tue, 12 Aug 2025 18:44:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3815E3A6E99
	for <lists+netdev@lfdr.de>; Tue, 12 Aug 2025 16:37:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB2B52F90CD;
	Tue, 12 Aug 2025 16:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="PDDayXFJ"
X-Original-To: netdev@vger.kernel.org
Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64EE32F5490;
	Tue, 12 Aug 2025 16:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755016652; cv=none; b=Uf0rkRy+PnWBCBHuM9HQ1m/kCUYckTBTiTw+gL7IuiNKHJy6zabImxcjMbZi8xmmQZmRjGT+8KIGhibxhZhr2bfiThIYZAXSqpvFPMjJK9NioA2Y/Ijh0dzpQ5FxtcbY+fgntielSM+0XUZjJy/4MHOQW6ViFa23IzKCG8x4WZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755016652; c=relaxed/simple;
	bh=KCKNEl62rjrtMG8u1hgKULtjfvWRT+ksDKwDjpV2ePE=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=S4ovOM7NCVL67UTOIK/oGAYDRWOacCLVdMkEb57mCSAr7q91NQbvc6Vq1eWEks3xQT/GxtEJeyCbAJzrkpweAP7fh7whQihPeiJs0prPps3wzDubuvoQK/eXp4doPgMpaRRPEbwh5/YRGSXm83Yx35uyiifCDUm5XZRLT/hggQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=PDDayXFJ; arc=none smtp.client-ip=198.47.19.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelvem-sh01.itg.ti.com ([10.180.77.71])
	by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTP id 57CGVEpi1447545;
	Tue, 12 Aug 2025 11:31:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1755016274;
	bh=YFLM9pfLOusy2YVMdLzf9ptsSRr3pdKzRMQf7aNOi3M=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=PDDayXFJeFvugwsuu8W3/SXdqBGeOvAgqbJl/IOnBJcnLKq8bMOp574l4TIH8rRHi
	 TPnzd0FP2DnLEM8AP6y+oaiEzvRVl6AmeFUswvqFmNvqEFaZzKZS5xlwMv0fslKAmz
	 A8MvM9Dy77mB89zmD/claPP7wZP79g9A962sjOzA=
Received: from DLEE104.ent.ti.com (dlee104.ent.ti.com [157.170.170.34])
	by lelvem-sh01.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 57CGVEBg3598831
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Tue, 12 Aug 2025 11:31:14 -0500
Received: from DLEE115.ent.ti.com (157.170.170.26) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Tue, 12
 Aug 2025 11:31:13 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Tue, 12 Aug 2025 11:31:13 -0500
Received: from [10.249.130.61] ([10.249.130.61])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 57CGUw4i639914;
	Tue, 12 Aug 2025 11:30:59 -0500
Message-ID: <4f8d678a-8b72-449e-9809-bed912f26e59@ti.com>
Date: Tue, 12 Aug 2025 22:00:57 +0530
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/5] net: rnpgbe: Add basic mbx ops support
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
 <20250812093937.882045-4-dong100@mucse.com>
Content-Language: en-US
From: "Anwar, Md Danish" <a0501179@ti.com>
In-Reply-To: <20250812093937.882045-4-dong100@mucse.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea



On 8/12/2025 3:09 PM, Dong Yibo wrote:
> Initialize basic mbx function.
> 
> Signed-off-by: Dong Yibo <dong100@mucse.com>
> ---
>  drivers/net/ethernet/mucse/rnpgbe/Makefile    |   3 +-
>  drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h    |  37 ++
>  .../net/ethernet/mucse/rnpgbe/rnpgbe_chip.c   |   5 +
>  drivers/net/ethernet/mucse/rnpgbe/rnpgbe_hw.h |   2 +
>  .../net/ethernet/mucse/rnpgbe/rnpgbe_mbx.c    | 443 ++++++++++++++++++
>  .../net/ethernet/mucse/rnpgbe/rnpgbe_mbx.h    |  31 ++
>  6 files changed, 520 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/net/ethernet/mucse/rnpgbe/rnpgbe_mbx.c
>  create mode 100644 drivers/net/ethernet/mucse/rnpgbe/rnpgbe_mbx.h
> 
> diff --git a/drivers/net/ethernet/mucse/rnpgbe/Makefile b/drivers/net/ethernet/mucse/rnpgbe/Makefile
> index 42c359f459d9..5fc878ada4b1 100644
> --- a/drivers/net/ethernet/mucse/rnpgbe/Makefile
> +++ b/drivers/net/ethernet/mucse/rnpgbe/Makefile
> @@ -6,4 +6,5 @@
>  
>  obj-$(CONFIG_MGBE) += rnpgbe.o
>  rnpgbe-objs := rnpgbe_main.o\
> -	       rnpgbe_chip.o
> +	       rnpgbe_chip.o\
> +	       rnpgbe_mbx.o
> diff --git a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h
> index 0dd3d3cb2a4d..05830bb73d3e 100644
> --- a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h
> +++ b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h
> @@ -5,6 +5,7 @@
>  #define _RNPGBE_H
>  
>  #include <linux/types.h>
> +#include <linux/mutex.h>
>  
>  extern const struct rnpgbe_info rnpgbe_n500_info;
>  extern const struct rnpgbe_info rnpgbe_n210_info;
> @@ -40,7 +41,43 @@ struct mucse_mac_info {
>  	void *back;
>  };
>  
> +struct mucse_hw;
> +
> +struct mucse_mbx_operations {
> +	void (*init_params)(struct mucse_hw *hw);
> +	int (*read)(struct mucse_hw *hw, u32 *msg,
> +		    u16 size);
> +	int (*write)(struct mucse_hw *hw, u32 *msg,
> +		     u16 size);
> +	int (*read_posted)(struct mucse_hw *hw, u32 *msg,
> +			   u16 size);
> +	int (*write_posted)(struct mucse_hw *hw, u32 *msg,
> +			    u16 size);
> +	int (*check_for_msg)(struct mucse_hw *hw);
> +	int (*check_for_ack)(struct mucse_hw *hw);
> +	void (*configure)(struct mucse_hw *hw, int num_vec,
> +			  bool enable);
> +};
> +
> +struct mucse_mbx_stats {
> +	u32 msgs_tx;
> +	u32 msgs_rx;
> +	u32 acks;
> +	u32 reqs;
> +	u32 rsts;
> +};
> +
>  struct mucse_mbx_info {
> +	const struct mucse_mbx_operations *ops;
> +	struct mucse_mbx_stats stats;
> +	u32 timeout;
> +	u32 usec_delay;
> +	u16 size;
> +	u16 fw_req;
> +	u16 fw_ack;
> +	/* lock for only one use mbx */
> +	struct mutex lock;
> +	bool irq_enabled;
>  	/* fw <--> pf mbx */
>  	u32 fw_pf_shm_base;
>  	u32 pf2fw_mbox_ctrl;
> diff --git a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_chip.c b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_chip.c
> index 20ec67c9391e..16d0a76114b5 100644
> --- a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_chip.c
> +++ b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_chip.c
> @@ -1,8 +1,11 @@
>  // SPDX-License-Identifier: GPL-2.0
>  /* Copyright(c) 2020 - 2025 Mucse Corporation. */
>  
> +#include <linux/string.h>
> +
>  #include "rnpgbe.h"
>  #include "rnpgbe_hw.h"
> +#include "rnpgbe_mbx.h"
>  
>  /**
>   * rnpgbe_init_common - Setup common attribute
> @@ -23,6 +26,8 @@ static void rnpgbe_init_common(struct mucse_hw *hw)
>  
>  	mac->mac_addr = hw->hw_addr + RNPGBE_MAC_BASE;
>  	mac->back = hw;
> +
> +	hw->mbx.ops = &mucse_mbx_ops_generic;
>  }
>  
>  /**
> diff --git a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_hw.h b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_hw.h
> index fc57258537cf..aee037e3219d 100644
> --- a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_hw.h
> +++ b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_hw.h
> @@ -7,6 +7,8 @@
>  #define RNPGBE_RING_BASE 0x1000
>  #define RNPGBE_MAC_BASE 0x20000
>  #define RNPGBE_ETH_BASE 0x10000
> +/**************** DMA Registers ****************************/
> +#define RNPGBE_DMA_DUMY 0x000c
>  /**************** CHIP Resource ****************************/
>  #define RNPGBE_MAX_QUEUES 8
>  #endif /* _RNPGBE_HW_H */
> diff --git a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_mbx.c b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_mbx.c
> new file mode 100644
> index 000000000000..1195cf945ad1
> --- /dev/null
> +++ b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_mbx.c
> @@ -0,0 +1,443 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Copyright(c) 2022 - 2025 Mucse Corporation. */
> +
> +#include <linux/pci.h>
> +#include <linux/errno.h>
> +#include <linux/delay.h>
> +#include <linux/iopoll.h>
> +
> +#include "rnpgbe.h"
> +#include "rnpgbe_mbx.h"
> +#include "rnpgbe_hw.h"
> +
> +/**
> + * mucse_read_mbx - Reads a message from the mailbox
> + * @hw: pointer to the HW structure
> + * @msg: the message buffer
> + * @size: length of buffer
> + *
> + * @return: 0 on success, negative on failure
> + **/
> +int mucse_read_mbx(struct mucse_hw *hw, u32 *msg, u16 size)
> +{
> +	struct mucse_mbx_info *mbx = &hw->mbx;
> +
> +	/* limit read size */
> +	min(size, mbx->size);
> +	return mbx->ops->read(hw, msg, size);
> +}

What's the purpose of min() here if you are anyways passing size to read()?

The min() call needs to be assigned to size, e.g.: size = min(size,
mbx->size);

> +
> +/**
> + * mucse_write_mbx - Write a message to the mailbox
> + * @hw: pointer to the HW structure
> + * @msg: the message buffer
> + * @size: length of buffer
> + *
> + * @return: 0 on success, negative on failure
> + **/

> +
> +/**
> + * mucse_mbx_reset - Reset mbx info, sync info from regs
> + * @hw: pointer to the HW structure
> + *
> + * This function reset all mbx variables to default.
> + **/
> +static void mucse_mbx_reset(struct mucse_hw *hw)
> +{
> +	struct mucse_mbx_info *mbx = &hw->mbx;
> +	int v;
> +

Variable 'v' should be declared as u32 to match the register read.

> +	v = mbx_rd32(hw, FW2PF_COUNTER(mbx));
> +	hw->mbx.fw_req = v & GENMASK(15, 0);
> +	hw->mbx.fw_ack = (v >> 16) & GENMASK(15, 0);
> +	mbx_wr32(hw, PF2FW_MBOX_CTRL(mbx), 0);
> +	mbx_wr32(hw, FW_PF_MBOX_MASK(mbx), GENMASK(31, 16));
> +}
> +
> +/**
> + * mucse_mbx_configure_pf - Configure mbx to use nr_vec interrupt
> + * @hw: pointer to the HW structure
> + * @nr_vec: vector number for mbx
> + * @enable: TRUE for enable, FALSE for disable
> + *
> + * This function configure mbx to use interrupt nr_vec.
> + **/
> +static void mucse_mbx_configure_pf(struct mucse_hw *hw, int nr_vec,
> +				   bool enable)
> +{
> +	struct mucse_mbx_info *mbx = &hw->mbx;
> +	u32 v;
> +
> +	if (enable) {
> +		v = mbx_rd32(hw, FW2PF_COUNTER(mbx));
> +		hw->mbx.fw_req = v & GENMASK(15, 0);
> +		hw->mbx.fw_ack = (v >> 16) & GENMASK(15, 0);
> +		mbx_wr32(hw, PF2FW_MBOX_CTRL(mbx), 0);
> +		mbx_wr32(hw, FW2PF_MBOX_VEC(mbx), nr_vec);
> +		mbx_wr32(hw, FW_PF_MBOX_MASK(mbx), GENMASK(31, 16));
> +	} else {
> +		mbx_wr32(hw, FW_PF_MBOX_MASK(mbx), 0xfffffffe);
> +		mbx_wr32(hw, PF2FW_MBOX_CTRL(mbx), 0);
> +		mbx_wr32(hw, RNPGBE_DMA_DUMY, 0);
> +	}
> +}
> +
> +/**
> + * mucse_init_mbx_params_pf - Set initial values for pf mailbox
> + * @hw: pointer to the HW structure
> + *
> + * Initializes the hw->mbx struct to correct values for pf mailbox
> + */
> +static void mucse_init_mbx_params_pf(struct mucse_hw *hw)
> +{
> +	struct mucse_mbx_info *mbx = &hw->mbx;
> +
> +	mbx->usec_delay = 100;
> +	mbx->timeout = (4 * 1000 * 1000) / mbx->usec_delay;

Use appropriate constants like USEC_PER_SEC instead of hardcoded values.

> +	mbx->stats.msgs_tx = 0;
> +	mbx->stats.msgs_rx = 0;


-- 
Thanks and Regards,
Md Danish Anwar


