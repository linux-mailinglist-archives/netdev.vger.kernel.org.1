Return-Path: <netdev+bounces-213262-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CC8EB2444C
	for <lists+netdev@lfdr.de>; Wed, 13 Aug 2025 10:29:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 792C55827C1
	for <lists+netdev@lfdr.de>; Wed, 13 Aug 2025 08:27:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A38B2ED145;
	Wed, 13 Aug 2025 08:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="E/KL4qn/"
X-Original-To: netdev@vger.kernel.org
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02AEB2ECD3C;
	Wed, 13 Aug 2025 08:27:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755073641; cv=none; b=b1Voi1QTt/hI3xNJEy1Z1LWLD0jniImLhStgCwnLKG5b13XtLCcEoiggfFlOjDnJC2NFHYveKesD44XY+gMGxkEaZu60+K5AB88hOQvIt62byEcJ7Tu4vgGGfI6hAvWvFLewaLAdu7IzYGuFjNZEAdn1Znr7WFRMXwzhn+0UBm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755073641; c=relaxed/simple;
	bh=EETb+mATWoalC/jIg1GxMzaFPbxxVYn4Baz6WzC73Pk=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=BoCvVS02QRM+FyLCFVFCB7KQrKwNHkRxKmkCu4KPUUApCcT2Y/gZe0Ef//MfKCjVHagIZybVEZd/2odG7kw6MK/pOhHNXunIVQoaZ6pVaZ2I7HTTXraauDX1yNdTERrCq/QiZUD5Y0rHyfMHZhWZtu2/lFIBrTgB3DVFhnZC4Hc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=E/KL4qn/; arc=none smtp.client-ip=198.47.23.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllvem-sh03.itg.ti.com ([10.64.41.86])
	by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTP id 57D8QFrq1659217;
	Wed, 13 Aug 2025 03:26:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1755073575;
	bh=LxxC+vWL+dBv0jeH8xTa33bVZ4qWYF8YDuV31GextYQ=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=E/KL4qn/ZvseqzCjyaciE6Wvi42lnHNKpBZuHekmdtnS5MVfb7PcteyB6elY2DZ6Y
	 X2j8RCKYqEPZKYn+lwzuDS/HWSeOgHzKz9eoDP/1ZAQ9U+39k1ttU6KWWDz5IhTF+m
	 h64B6kZ4GqwYH3BEOIAA7XOQtCkFe+v5oiEPHzHM=
Received: from DFLE101.ent.ti.com (dfle101.ent.ti.com [10.64.6.22])
	by fllvem-sh03.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 57D8QFKo257229
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Wed, 13 Aug 2025 03:26:15 -0500
Received: from DFLE101.ent.ti.com (10.64.6.22) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Wed, 13
 Aug 2025 03:26:14 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Wed, 13 Aug 2025 03:26:14 -0500
Received: from [172.24.231.152] (danish-tpc.dhcp.ti.com [172.24.231.152])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 57D8Q8Xc1721088;
	Wed, 13 Aug 2025 03:26:08 -0500
Message-ID: <94eeae65-0e4b-45ef-a9c0-6bc8d37ae789@ti.com>
Date: Wed, 13 Aug 2025 13:56:07 +0530
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 5/5] net: rnpgbe: Add register_netdev
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
References: <20250812093937.882045-1-dong100@mucse.com>
 <20250812093937.882045-6-dong100@mucse.com>
Content-Language: en-US
From: MD Danish Anwar <danishanwar@ti.com>
In-Reply-To: <20250812093937.882045-6-dong100@mucse.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea



On 12/08/25 3:09 pm, Dong Yibo wrote:
> Initialize get mac from hw, register the netdev.
> 
> Signed-off-by: Dong Yibo <dong100@mucse.com>
> ---
>  drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h    | 22 ++++++
>  .../net/ethernet/mucse/rnpgbe/rnpgbe_chip.c   | 73 ++++++++++++++++++
>  drivers/net/ethernet/mucse/rnpgbe/rnpgbe_hw.h |  1 +
>  .../net/ethernet/mucse/rnpgbe/rnpgbe_main.c   | 76 +++++++++++++++++++
>  4 files changed, 172 insertions(+)
> 
> diff --git a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h
> index 6cb14b79cbfe..644b8c85c29d 100644
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
> @@ -86,6 +87,18 @@ struct mucse_mbx_info {
>  	u32 fw2pf_mbox_vec;
>  };
>  
> +struct mucse_hw_operations {
> +	int (*init_hw)(struct mucse_hw *hw);
> +	int (*reset_hw)(struct mucse_hw *hw);
> +	void (*start_hw)(struct mucse_hw *hw);
> +	void (*init_rx_addrs)(struct mucse_hw *hw);
> +	void (*driver_status)(struct mucse_hw *hw, bool enable, int mode);
> +};

You define functions init_hw, start_hw, and init_rx_addrs in this
structure but they aren't implemented in this patch. Either implement
them or remove them if not needed yet.


> +
> +enum {
> +	mucse_driver_insmod,
> +};
> +
>  struct mucse_hw {
>  	void *back;
>  	u8 pfvfnum;
> @@ -96,12 +109,18 @@ struct mucse_hw {
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
> +	u8 addr[ETH_ALEN];
> +	u8 perm_addr[ETH_ALEN];
>  };
>  
>  struct mucse {
> @@ -123,4 +142,7 @@ struct rnpgbe_info {
>  #define PCI_DEVICE_ID_N500_DUAL_PORT 0x8318
>  #define PCI_DEVICE_ID_N210 0x8208
>  #define PCI_DEVICE_ID_N210L 0x820a
> +
> +#define dma_wr32(dma, reg, val) writel((val), (dma)->dma_base_addr + (reg))
> +#define dma_rd32(dma, reg) readl((dma)->dma_base_addr + (reg))
>  #endif /* _RNPGBE_H */
> diff --git a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_chip.c b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_chip.c
> index 16d0a76114b5..3eaa0257f3bb 100644
> --- a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_chip.c
> +++ b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_chip.c
> @@ -2,10 +2,82 @@
>  /* Copyright(c) 2020 - 2025 Mucse Corporation. */
>  
>  #include <linux/string.h>
> +#include <linux/etherdevice.h>
>  
>  #include "rnpgbe.h"
>  #include "rnpgbe_hw.h"
>  #include "rnpgbe_mbx.h"
> +#include "rnpgbe_mbx_fw.h"
> +
> +/**
> + * rnpgbe_get_permanent_mac - Get permanent mac
> + * @hw: hw information structure
> + * @mac_addr: pointer to store mac
> + *
> + * rnpgbe_get_permanent_mac tries to get mac from hw.
> + * It use eth_random_addr if failed.
> + **/
> +static void rnpgbe_get_permanent_mac(struct mucse_hw *hw,
> +				     u8 *mac_addr)
> +{
> +	if (mucse_fw_get_macaddr(hw, hw->pfvfnum, mac_addr, hw->lane)) {
> +		eth_random_addr(mac_addr);
> +	} else {
> +		if (!is_valid_ether_addr(mac_addr))
> +			eth_random_addr(mac_addr);
> +	}
> +

The function should log a warning when falling back to a random MAC
address, especially in the second case where the hardware returned an
invalid MAC.

> +	hw->flags |= M_FLAGS_INIT_MAC_ADDRESS;
> +}
> +

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
> +		return NETDEV_TX_OK;
> +}

Extra indentation on these two lines. Also, the function just drops all
packets without any actual transmission. This should at least increment
the drop counter statistics.

> +
> +static const struct net_device_ops rnpgbe_netdev_ops = {
> +	.ndo_open = rnpgbe_open,
> +	.ndo_stop = rnpgbe_close,
> +	.ndo_start_xmit = rnpgbe_xmit_frame,
> +};


-- 
Thanks and Regards,
Danish


