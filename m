Return-Path: <netdev+bounces-223877-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 17923B7F325
	for <lists+netdev@lfdr.de>; Wed, 17 Sep 2025 15:24:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 866463B7E39
	for <lists+netdev@lfdr.de>; Wed, 17 Sep 2025 07:12:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FB122DEA8F;
	Wed, 17 Sep 2025 07:12:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="oFbLN6uL"
X-Original-To: netdev@vger.kernel.org
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10F61200127;
	Wed, 17 Sep 2025 07:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758093136; cv=none; b=sJCEJzhxyxWFwuIsi4ZlV07ziN3UIBpTfAcPmt66oD3P6DQgqZ5hCTBVy+Ym1/FsHVfRZrZ+RLviERcLmJN7oesjwJ+Igz07MGt1k5/rWtFCDnXLYov8vBf3jEE2rXxtfTkfk1L+LUtWPkbwsL5Dpht9KvW/UHaqUvps3mzsG5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758093136; c=relaxed/simple;
	bh=AnUEUznLqClCmdYSXr4NxPzJ7PnwHzaxSWx9a+Ughrs=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=pbmuPZAwWxM8E7CFwm2LZVIzh0Otza6p0ztGW0cYlV58NCuniUmLB1srDsHeGDxz0vqjv5MBvAUnnodWJgTAWtSqzFkUPEEu62M5qU034tJUY3n0SjpeI07nZ1dH+/yhJV3hun58ZpurAphpPs+v8jDZIB2YwhY2OQpCiCcOU5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=oFbLN6uL; arc=none smtp.client-ip=198.47.23.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelvem-sh01.itg.ti.com ([10.180.77.71])
	by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTP id 58H7A95w1551071;
	Wed, 17 Sep 2025 02:10:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1758093009;
	bh=JhpSRRMgVqAgduSNDjKmLQdUXJ0KKY7dsmGJD0xdH98=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=oFbLN6uL9Yp+2AUPSNOKZwf1JWAVNRsp0wg5LTa8IHaUSXtGQKLTzjUXK6ptQpM9D
	 IsVEOwUoDjB1NvyqeuovRGSHWwofGcJD7/XhEHBwJhmLSo+KVY6Qu37WaAE9RKqs/R
	 SXrGoQPR/uutEu3YeZ2vscJ/6JlAqs8ZwRw9Hm3c=
Received: from DFLE102.ent.ti.com (dfle102.ent.ti.com [10.64.6.23])
	by lelvem-sh01.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 58H7A8O0575420
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Wed, 17 Sep 2025 02:10:08 -0500
Received: from DFLE202.ent.ti.com (10.64.6.60) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Wed, 17
 Sep 2025 02:10:08 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE202.ent.ti.com
 (10.64.6.60) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Wed, 17 Sep 2025 02:10:08 -0500
Received: from [172.24.231.152] (danish-tpc.dhcp.ti.com [172.24.231.152])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 58H79xa42605473;
	Wed, 17 Sep 2025 02:10:00 -0500
Message-ID: <f095f31c-b725-4a3f-bc73-7cc57428e5f2@ti.com>
Date: Wed, 17 Sep 2025 12:39:59 +0530
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v12 5/5] net: rnpgbe: Add register_netdev
To: Dong Yibo <dong100@mucse.com>, <andrew+netdev@lunn.ch>,
        <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>, <horms@kernel.org>, <corbet@lwn.net>,
        <gur.stavi@huawei.com>, <maddy@linux.ibm.com>, <mpe@ellerman.id.au>,
        <lee@trager.us>, <gongfan1@huawei.com>, <lorenzo@kernel.org>,
        <geert+renesas@glider.be>, <Parthiban.Veerasooran@microchip.com>,
        <lukas.bulwahn@redhat.com>, <alexanderduyck@fb.com>,
        <richardcochran@gmail.com>, <kees@kernel.org>, <gustavoars@kernel.org>,
        <rdunlap@infradead.org>, <vadim.fedorenko@linux.dev>, <joerg@jo-so.de>
CC: <netdev@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-hardening@vger.kernel.org>
References: <20250916112952.26032-1-dong100@mucse.com>
 <20250916112952.26032-6-dong100@mucse.com>
Content-Language: en-US
From: MD Danish Anwar <danishanwar@ti.com>
In-Reply-To: <20250916112952.26032-6-dong100@mucse.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea



On 16/09/25 4:59 pm, Dong Yibo wrote:
> Complete the network device (netdev) registration flow for Mucse Gbe
> Ethernet chips, including:
> 1. Hardware state initialization:
>    - Send powerup notification to firmware (via echo_fw_status)
>    - Sync with firmware
>    - Reset hardware
> 2. MAC address handling:
>    - Retrieve permanent MAC from firmware (via mucse_mbx_get_macaddr)
>    - Fallback to random valid MAC (eth_random_addr) if not valid mac
>      from Fw
> 
> Signed-off-by: Dong Yibo <dong100@mucse.com>
> ---
>  drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h    |  18 +++
>  .../net/ethernet/mucse/rnpgbe/rnpgbe_chip.c   |  80 ++++++++++++++
>  drivers/net/ethernet/mucse/rnpgbe/rnpgbe_hw.h |   2 +
>  .../net/ethernet/mucse/rnpgbe/rnpgbe_main.c   | 103 ++++++++++++++++++
>  4 files changed, 203 insertions(+)
> 
> diff --git a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h
> index 41b580f2168f..4c4b2f13cb4a 100644
> --- a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h
> +++ b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h
> @@ -6,6 +6,7 @@
>  
>  #include <linux/types.h>
>  #include <linux/mutex.h>
> +#include <linux/netdevice.h>
>  
>  enum rnpgbe_boards {
>  	board_n500,
> @@ -34,12 +35,26 @@ struct mucse_mbx_info {
>  	u32 fwpf_ctrl_base;
>  };
>  
> +enum {
> +	mucse_fw_powerup,
> +};
> +

This enum has only one value. You should either use a #define or add
more values to justify having an enum.

>  struct mucse_hw {
>  	void __iomem *hw_addr;
> +	struct pci_dev *pdev;
> +	const struct mucse_hw_operations *ops;
>  	struct mucse_mbx_info mbx;
> +	int port;
> +	u8 perm_addr[ETH_ALEN];
>  	u8 pfvfnum;
>  };
>  
> +struct mucse_hw_operations {
> +	int (*reset_hw)(struct mucse_hw *hw);
> +	int (*get_perm_mac)(struct mucse_hw *hw);
> +	int (*mbx_send_notify)(struct mucse_hw *hw, bool enable, int mode);
> +};
> +
>  struct mucse {
>  	struct net_device *netdev;
>  	struct pci_dev *pdev;
> @@ -54,4 +69,7 @@ int rnpgbe_init_hw(struct mucse_hw *hw, int board_type);
>  #define PCI_DEVICE_ID_N500_DUAL_PORT 0x8318
>  #define PCI_DEVICE_ID_N210 0x8208
>  #define PCI_DEVICE_ID_N210L 0x820a
> +
> +#define mucse_hw_wr32(hw, reg, val) \
> +	writel((val), (hw)->hw_addr + (reg))
>  #endif /* _RNPGBE_H */
> diff --git a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_chip.c b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_chip.c
> index 86f1c75796b0..667e372387a2 100644
> --- a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_chip.c
> +++ b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_chip.c
> @@ -1,11 +1,88 @@
>  // SPDX-License-Identifier: GPL-2.0
>  /* Copyright(c) 2020 - 2025 Mucse Corporation. */
>  
> +#include <linux/pci.h>
>  #include <linux/errno.h>
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
> + *
> + * rnpgbe_get_permanent_mac tries to get mac from hw
> + *
> + * Return: 0 on success, negative errno on failure
> + **/
> +static int rnpgbe_get_permanent_mac(struct mucse_hw *hw)
> +{
> +	struct device *dev = &hw->pdev->dev;
> +	u8 *mac_addr = hw->perm_addr;
> +	int err;
> +
> +	err = mucse_mbx_get_macaddr(hw, hw->pfvfnum, mac_addr, hw->port);
> +	if (err) {
> +		dev_err(dev, "Failed to get MAC from FW %d\n", err);
> +		return err;
> +	}
> +
> +	if (!is_valid_ether_addr(mac_addr)) {
> +		dev_err(dev, "Failed to get valid MAC from FW\n");
> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +}
> +
> +/**
> + * rnpgbe_reset - Do a hardware reset
> + * @hw: hw information structure
> + *
> + * rnpgbe_reset calls fw to do a hardware
> + * reset, and cleans some regs to default.
> + *
> + * Return: 0 on success, negative errno on failure
> + **/
> +static int rnpgbe_reset(struct mucse_hw *hw)
> +{
> +	mucse_hw_wr32(hw, RNPGBE_DMA_AXI_EN, 0);
> +	return mucse_mbx_reset_hw(hw);
> +}
> +
> +/**
> + * rnpgbe_mbx_send_notify - Echo fw status
> + * @hw: hw information structure
> + * @enable: true or false status
> + * @mode: status mode
> + *
> + * Return: 0 on success, negative errno on failure
> + **/
> +static int rnpgbe_mbx_send_notify(struct mucse_hw *hw,
> +				  bool enable,
> +				  int mode)
> +{
> +	int err;
> +
> +	switch (mode) {
> +	case mucse_fw_powerup:
> +		err = mucse_mbx_powerup(hw, enable);
> +		break;
> +	default:
> +		err = -EINVAL;
> +	}
> +

Since you only have one mode currently, this switch statement seems
unnecessary.

> +	return err;
> +}


-- 
Thanks and Regards,
Danish


