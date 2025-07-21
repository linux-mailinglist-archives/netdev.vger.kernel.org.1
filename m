Return-Path: <netdev+bounces-208627-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 79004B0C69F
	for <lists+netdev@lfdr.de>; Mon, 21 Jul 2025 16:41:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 213D21890328
	for <lists+netdev@lfdr.de>; Mon, 21 Jul 2025 14:41:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8683D1E7C08;
	Mon, 21 Jul 2025 14:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="X7472c1K"
X-Original-To: netdev@vger.kernel.org
Received: from out-182.mta1.migadu.com (out-182.mta1.migadu.com [95.215.58.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12D9C1DA10B
	for <netdev@vger.kernel.org>; Mon, 21 Jul 2025 14:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753108859; cv=none; b=o5oJQ4W8e2hPBaFL9wH2ZaIrIqYVUIyBw097ShqAn5GFgziJcL8BzJ36TF5YpDIvHWSCANyRXBEnggtYA3gjn2ABWnUGYLmQDEUvvwSS7bkjTMULsm9ZChk7yvEbIrq3hIX/ZQkT++H6HOHS2foB6JGjBx6fxBecUNvik6oWLyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753108859; c=relaxed/simple;
	bh=1RtQBzOEC4Zl0bIPrchjsS6gz98G25dZlBbimhRn9mg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KFLQ2tgrUhEuZV3K3QpOFwfu8Nc+MVd63Kz6tsMyUiLz8QD9aXymNvBH39D3i6uv0R5HEu99xm+J2v65kS/zkV0mWFjZtCsiwLfUzZ3xKzhMXlJNfkkWZDyVAx7eyWQPRwf49m7PZDqxcMf3Mh3BjAjqJqZcoEj+Ts8nRo9/P20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=X7472c1K; arc=none smtp.client-ip=95.215.58.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <165897af-fa84-428d-9e93-52be1f2d09e5@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1753108854;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bDQ+R+MAd9ERvWMuuaknZR5JiVowZsZ4r7mCULkiSX0=;
	b=X7472c1K55Kef8FN/3V41ZpFASwDxZ8NEelc6muTh7Lu1Nm6YpbFJHDyDkDCVqN3IMYd/c
	zbqnCPhoaO5c5TGY1nmUO0Yw4W+zcrB4y1cgVz1aAAwv7As8hSkEm0MZVEb4/ZpoC0JUFB
	asN2qpTveEFrXeu6TtAmRfIdC4yWNBE=
Date: Mon, 21 Jul 2025 15:40:51 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v2 03/15] net: rnpgbe: Add basic mbx ops support
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
 <20250721113238.18615-4-dong100@mucse.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20250721113238.18615-4-dong100@mucse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 21/07/2025 12:32, Dong Yibo wrote:
> Initialize basic mbx function.
> 
> Signed-off-by: Dong Yibo <dong100@mucse.com>
> ---
>   drivers/net/ethernet/mucse/rnpgbe/Makefile    |   5 +-
>   drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h    |  46 ++
>   .../net/ethernet/mucse/rnpgbe/rnpgbe_chip.c   |   5 +-
>   drivers/net/ethernet/mucse/rnpgbe/rnpgbe_hw.h |   2 +
>   .../net/ethernet/mucse/rnpgbe/rnpgbe_main.c   |   1 +
>   .../net/ethernet/mucse/rnpgbe/rnpgbe_mbx.c    | 623 ++++++++++++++++++
>   .../net/ethernet/mucse/rnpgbe/rnpgbe_mbx.h    |  48 ++
>   7 files changed, 727 insertions(+), 3 deletions(-)
>   create mode 100644 drivers/net/ethernet/mucse/rnpgbe/rnpgbe_mbx.c
>   create mode 100644 drivers/net/ethernet/mucse/rnpgbe/rnpgbe_mbx.h
> 
> diff --git a/drivers/net/ethernet/mucse/rnpgbe/Makefile b/drivers/net/ethernet/mucse/rnpgbe/Makefile
> index 42c359f459d9..41177103b50c 100644
> --- a/drivers/net/ethernet/mucse/rnpgbe/Makefile
> +++ b/drivers/net/ethernet/mucse/rnpgbe/Makefile
> @@ -5,5 +5,6 @@
>   #
>   
>   obj-$(CONFIG_MGBE) += rnpgbe.o
> -rnpgbe-objs := rnpgbe_main.o\
> -	       rnpgbe_chip.o
> +rnpgbe-objs := rnpgbe_main.o \
> +	       rnpgbe_chip.o \
> +	       rnpgbe_mbx.o
> diff --git a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h
> index 2ae836fc8951..46e2bb2fe71e 100644
> --- a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h
> +++ b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h
> @@ -63,9 +63,51 @@ struct mucse_mac_info {
>   	int clk_csr;
>   };
>   
> +struct mucse_hw;
> +
> +enum MBX_ID {
> +	MBX_VF0 = 0,
> +	MBX_VF1,
> +	MBX_VF2,
> +	MBX_VF3,
> +	MBX_VF4,
> +	MBX_VF5,
> +	MBX_VF6,
> +	MBX_VF7,
> +	MBX_CM3CPU,
> +	MBX_FW = MBX_CM3CPU,
> +	MBX_VFCNT
> +};
> +
> +struct mucse_mbx_operations {
> +	void (*init_params)(struct mucse_hw *hw);
> +	int (*read)(struct mucse_hw *hw, u32 *msg,
> +		    u16 size, enum MBX_ID id);
> +	int (*write)(struct mucse_hw *hw, u32 *msg,
> +		     u16 size, enum MBX_ID id);
> +	int (*read_posted)(struct mucse_hw *hw, u32 *msg,
> +			   u16 size, enum MBX_ID id);
> +	int (*write_posted)(struct mucse_hw *hw, u32 *msg,
> +			    u16 size, enum MBX_ID id);
> +	int (*check_for_msg)(struct mucse_hw *hw, enum MBX_ID id);
> +	int (*check_for_ack)(struct mucse_hw *hw, enum MBX_ID id);
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
>   #define MAX_VF_NUM (8)
>   
>   struct mucse_mbx_info {
> +	struct mucse_mbx_operations ops;
> +	struct mucse_mbx_stats stats;
>   	u32 timeout;
>   	u32 usec_delay;
>   	u32 v2p_mailbox;
> @@ -99,6 +141,8 @@ struct mucse_mbx_info {
>   	int share_size;
>   };
>   
> +#include "rnpgbe_mbx.h"
> +
>   struct mucse_hw {
>   	void *back;
>   	u8 pfvfnum;
> @@ -110,6 +154,8 @@ struct mucse_hw {
>   	u16 vendor_id;
>   	u16 subsystem_device_id;
>   	u16 subsystem_vendor_id;
> +	int max_vfs;
> +	int max_vfs_noari;
>   	enum rnpgbe_hw_type hw_type;
>   	struct mucse_dma_info dma;
>   	struct mucse_eth_info eth;
> diff --git a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_chip.c b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_chip.c
> index 38c094965db9..b0e5fda632f3 100644
> --- a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_chip.c
> +++ b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_chip.c
> @@ -6,6 +6,7 @@
>   
>   #include "rnpgbe.h"
>   #include "rnpgbe_hw.h"
> +#include "rnpgbe_mbx.h"
>   
>   /**
>    * rnpgbe_get_invariants_n500 - setup for hw info
> @@ -67,7 +68,7 @@ static void rnpgbe_get_invariants_n500(struct mucse_hw *hw)
>   	mbx->fw_pf_mbox_mask = 0x2e200;
>   	mbx->fw_vf_share_ram = 0x2b000;
>   	mbx->share_size = 512;
> -
> +	memcpy(&hw->mbx.ops, &mucse_mbx_ops_generic, sizeof(hw->mbx.ops));

that's bad pattern. it's better to have a constant set of callbacks per
device type and assign const pointer to it. It will make further debugs
much easier.

>   	/* setup net feature here */
>   	hw->feature_flags |= M_NET_FEATURE_SG |
>   			     M_NET_FEATURE_TX_CHECKSUM |
> @@ -83,6 +84,7 @@ static void rnpgbe_get_invariants_n500(struct mucse_hw *hw)
>   			     M_NET_FEATURE_STAG_OFFLOAD;
>   	/* start the default ahz, update later */
>   	hw->usecstocount = 125;
> +	hw->max_vfs = 7;
>   }
>   
>   /**
> @@ -117,6 +119,7 @@ static void rnpgbe_get_invariants_n210(struct mucse_hw *hw)
>   	/* update hw feature */
>   	hw->feature_flags |= M_HW_FEATURE_EEE;
>   	hw->usecstocount = 62;
> +	hw->max_vfs_noari = 7;
>   }
>   
>   const struct rnpgbe_info rnpgbe_n500_info = {
> diff --git a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_hw.h b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_hw.h
> index 2c7372a5e88d..ff7bd9b21550 100644
> --- a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_hw.h
> +++ b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_hw.h
> @@ -14,6 +14,8 @@
>   #define RNPGBE_RING_BASE (0x1000)
>   #define RNPGBE_MAC_BASE (0x20000)
>   #define RNPGBE_ETH_BASE (0x10000)
> +
> +#define RNPGBE_DMA_DUMY (0x000c)
>   /* chip resourse */
>   #define RNPGBE_MAX_QUEUES (8)
>   /* multicast control table */
> diff --git a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_main.c b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_main.c
> index 08f773199e9b..1e8360cae560 100644
> --- a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_main.c
> +++ b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_main.c
> @@ -114,6 +114,7 @@ static int rnpgbe_add_adapter(struct pci_dev *pdev,
>   	hw->hw_addr = hw_addr;
>   	hw->dma.dma_version = dma_version;
>   	ii->get_invariants(hw);
> +	hw->mbx.ops.init_params(hw);
>   
>   	return 0;
>   
> diff --git a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_mbx.c b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_mbx.c
> new file mode 100644
> index 000000000000..56ace3057fea
> --- /dev/null
> +++ b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_mbx.c
> @@ -0,0 +1,623 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Copyright(c) 2022 - 2025 Mucse Corporation. */
> +
> +#include <linux/pci.h>
> +#include <linux/errno.h>
> +#include <linux/delay.h>
> +#include <linux/iopoll.h>
> +#include "rnpgbe.h"
> +#include "rnpgbe_mbx.h"
> +#include "rnpgbe_hw.h"
> +
> +/**
> + * mucse_read_mbx - Reads a message from the mailbox
> + * @hw: Pointer to the HW structure
> + * @msg: The message buffer
> + * @size: Length of buffer
> + * @mbx_id: Id of vf/fw to read
> + *
> + * @return: 0 on success, negative on failure
> + **/
> +int mucse_read_mbx(struct mucse_hw *hw, u32 *msg, u16 size,
> +		   enum MBX_ID mbx_id)
> +{
> +	struct mucse_mbx_info *mbx = &hw->mbx;
> +
> +	/* limit read to size of mailbox */
> +	if (size > mbx->size)
> +		size = mbx->size;
> +
> +	if (!mbx->ops.read)
> +		return -EIO;

is it even possible? you control the set of callbacks, and these
operations must be setup to have HW working. avoid defensive programming
here and in other places you use callbacks.

> +
> +	return mbx->ops.read(hw, msg, size, mbx_id);
> +}
> +

[...]

