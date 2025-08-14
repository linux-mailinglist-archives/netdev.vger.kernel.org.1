Return-Path: <netdev+bounces-213694-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F37C9B26531
	for <lists+netdev@lfdr.de>; Thu, 14 Aug 2025 14:16:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DB9687BE35C
	for <lists+netdev@lfdr.de>; Thu, 14 Aug 2025 12:14:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1914D2FDC2A;
	Thu, 14 Aug 2025 12:15:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="dbLo7fO4"
X-Original-To: netdev@vger.kernel.org
Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E82E62E7BBC;
	Thu, 14 Aug 2025 12:15:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755173750; cv=none; b=PbAqpkYvyb5/n5zUlGcU2itNuqvJrW4Z2P3Bz7f2St0YDPsUqP4r7YliH9e0f011TFclhHBBzQ/PYWWvY3lR0YLa/L4zjkuMzUUlZqUoCTW6mle+BlHdWI1NT9wDGabCYXtWpqu6xr6G4ypUfUbtI8x8LKS6dlDtxDCgyJthnFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755173750; c=relaxed/simple;
	bh=zsj/r4+qg+RibQeEvHxn2GkGt2ubYJ+iN86QAKdU1/0=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=kDMjliO0nVgdoTneZuAKnt4S3wHTyVTU7MIFBcZXIuPpeHe3DMKhK7muCmV3gZgM5cpkjs+H+XbVhg9hnpoPsrVYWz4x+5zlZBnEfZg3auYGGxhz/UVrITSAxEZNTy5U5iGaTEuvQ2zyD5gZ9NDfBiOzdwiJ6CvWX4xeiL/YSRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=dbLo7fO4; arc=none smtp.client-ip=198.47.19.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllvem-sh04.itg.ti.com ([10.64.41.54])
	by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTP id 57ECExwS1875851;
	Thu, 14 Aug 2025 07:14:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1755173699;
	bh=3bkB4ImlGUHuqngaDsC8bS0n8FZ4dBNcDo4Y1EMKjpE=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=dbLo7fO40YX7UWvYJmhodrSTTzlEIOLeOw35d4UR+YPJE1fj4ourbiGEy1rYfkDPC
	 UWPGYNHmbEf1ZZzLDEw6H4MdUY3YKILbftMREbHBMams0wqz4AeHDrxD+57kPfR0x1
	 7b56lgQBaD/wXECzbSoPTgKGr8Yy8WhDHq5TzZPQ=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
	by fllvem-sh04.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 57ECEx9L1821238
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Thu, 14 Aug 2025 07:14:59 -0500
Received: from DFLE106.ent.ti.com (10.64.6.27) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Thu, 14
 Aug 2025 07:14:58 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Thu, 14 Aug 2025 07:14:58 -0500
Received: from [172.24.231.152] (danish-tpc.dhcp.ti.com [172.24.231.152])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 57ECEqac3583824;
	Thu, 14 Aug 2025 07:14:52 -0500
Message-ID: <dd6ece66-ae4b-424a-aa09-872ac15e1549@ti.com>
Date: Thu, 14 Aug 2025 17:44:51 +0530
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 5/5] net: rnpgbe: Add register_netdev
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
 <20250814073855.1060601-6-dong100@mucse.com>
Content-Language: en-US
From: MD Danish Anwar <danishanwar@ti.com>
In-Reply-To: <20250814073855.1060601-6-dong100@mucse.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea



On 14/08/25 1:08 pm, Dong Yibo wrote:
> Initialize get mac from hw, register the netdev.
> 
> Signed-off-by: Dong Yibo <dong100@mucse.com>
> ---
>  drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h    | 18 +++++
>  .../net/ethernet/mucse/rnpgbe/rnpgbe_chip.c   | 73 ++++++++++++++++++
>  drivers/net/ethernet/mucse/rnpgbe/rnpgbe_hw.h |  1 +
>  .../net/ethernet/mucse/rnpgbe/rnpgbe_main.c   | 75 +++++++++++++++++++
>  4 files changed, 167 insertions(+)
> 
> diff --git a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h
> index 7ab1cbb432f6..7e51a8871b71 100644
> --- a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h
> +++ b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h
> @@ -6,6 +6,7 @@
>  
>  #include <linux/types.h>
>  #include <linux/mutex.h>
> +#include <linux/netdevice.h>
>  
>  extern const struct rnpgbe_info rnpgbe_n500_info;
>  extern const struct rnpgbe_info rnpgbe_n210_info;
> @@ -82,6 +83,15 @@ struct mucse_mbx_info {
>  	u32 fw2pf_mbox_vec;
>  };
>  
> +struct mucse_hw_operations {
> +	int (*reset_hw)(struct mucse_hw *hw);
> +	void (*driver_status)(struct mucse_hw *hw, bool enable, int mode);
> +};
> +
> +enum {
> +	mucse_driver_insmod,
> +};
> +
>  struct mucse_hw {
>  	u8 pfvfnum;
>  	void __iomem *hw_addr;
> @@ -91,12 +101,17 @@ struct mucse_hw {
>  	u32 axi_mhz;
>  	u32 bd_uid;
>  	enum rnpgbe_hw_type hw_type;
> +	const struct mucse_hw_operations *ops;
>  	struct mucse_dma_info dma;
>  	struct mucse_eth_info eth;
>  	struct mucse_mac_info mac;
>  	struct mucse_mbx_info mbx;
> +	u32 flags;
> +#define M_FLAGS_INIT_MAC_ADDRESS BIT(0)
>  	u32 driver_version;
>  	u16 usecstocount;
> +	int lane;
> +	u8 perm_addr[ETH_ALEN];
>  };
>  
>  struct mucse {
> @@ -117,4 +132,7 @@ struct rnpgbe_info {
>  #define PCI_DEVICE_ID_N500_DUAL_PORT 0x8318
>  #define PCI_DEVICE_ID_N210 0x8208
>  #define PCI_DEVICE_ID_N210L 0x820a
> +
> +#define dma_wr32(dma, reg, val) writel((val), (dma)->dma_base_addr + (reg))
> +#define dma_rd32(dma, reg) readl((dma)->dma_base_addr + (reg))

These macros could collide with other definitions. Consider prefixing
them with the driver name (rnpgbe_dma_wr32).

I don't see these macros getting used anywhere in this series. They
should be introduced when they are used.

>  #endif /* _RNPGBE_H */
> diff --git a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_chip.c b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_chip.c
> index e0c6f47efd4c..aba44b31eae3 100644
> --- a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_chip.c
> +++ b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_chip.c
> @@ -1,11 +1,83 @@
>  // SPDX-License-Identifier: GPL-2.0
>  /* Copyright(c) 2020 - 2025 Mucse Corporation. */
>  
> +#include <linux/pci.h>
>  #include <linux/string.h>
> +#include <linux/etherdevice.h>
>  
>  #include "rnpgbe.h"
>  #include "rnpgbe_hw.h"
>  #include "rnpgbe_mbx.h"
> +#include "rnpgbe_mbx_fw.h"

> +/**
> + * rnpgbe_xmit_frame - Send a skb to driver
> + * @skb: skb structure to be sent
> + * @netdev: network interface device structure
> + *
> + * @return: NETDEV_TX_OK or NETDEV_TX_BUSY
> + **/
> +static netdev_tx_t rnpgbe_xmit_frame(struct sk_buff *skb,
> +				     struct net_device *netdev)
> +{
> +		dev_kfree_skb_any(skb);
> +		netdev->stats.tx_dropped++;
> +		return NETDEV_TX_OK;
> +}

You didn't fix this extra indentation. This was present in v3 as well

https://lore.kernel.org/all/94eeae65-0e4b-45ef-a9c0-6bc8d37ae789@ti.com/#:~:text=skb)%3B%0A%3E%20%2B%09%09return%20NETDEV_TX_OK%3B%0A%3E%20%2B-,%7D,-Extra%20indentation%20on

> +
> +static const struct net_device_ops rnpgbe_netdev_ops = {
> +	.ndo_open = rnpgbe_open,
> +	.ndo_stop = rnpgbe_close,


-- 
Thanks and Regards,
Danish


