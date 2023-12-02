Return-Path: <netdev+bounces-53227-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 34221801AB4
	for <lists+netdev@lfdr.de>; Sat,  2 Dec 2023 05:36:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CDDC21F21130
	for <lists+netdev@lfdr.de>; Sat,  2 Dec 2023 04:36:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF7191C05;
	Sat,  2 Dec 2023 04:36:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BnslKoHv"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2ABF619AD
	for <netdev@vger.kernel.org>; Sat,  2 Dec 2023 04:36:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA2DCC433C7;
	Sat,  2 Dec 2023 04:36:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701491764;
	bh=6NhfdgwZTUrPIrSDJEJSv0GOyYpRQevIVy8JgFUc018=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=BnslKoHvup4M6k2YoOB/yqcuqoXgwWX+E2Wp5w+qGLoD2/fcElkyRsJuQJgT29DMt
	 34qAoeosfnr/LxwD0M/y7SSxFEePpb26IIkcEbJOoAIleR3lqeMCJwWvhkyVCafhsH
	 C84VcOEA76m7iNFa2mRnY6OUPr+nFNhfxYYYDSqQy0p+3aeYeAXbMTrJTu72VwlnDc
	 xL+edw5j+W1P2pUjMGdtiq4/QixJSReVzor2ygSPjGaxNs08e5vTvf2GMDmicpN19x
	 wrJ5JNniIXKR1eqkXSZjCxGcmysnjDbMkHKRN+0wtEKIK4MBzJwL7/JicLc2D1vxDN
	 SAtiRU/y8lLRQ==
Date: Fri, 1 Dec 2023 20:36:02 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Justin Lai <justinlai0215@realtek.com>
Cc: <davem@davemloft.net>, <edumazet@google.com>, <pabeni@redhat.com>,
 <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>, <andrew@lunn.ch>,
 <pkshih@realtek.com>, <larry.chiu@realtek.com>
Subject: Re: [PATCH net-next v13 01/13] rtase: Add pci table supported in
 this module
Message-ID: <20231201203602.7e380716@kernel.org>
In-Reply-To: <20231130114327.1530225-2-justinlai0215@realtek.com>
References: <20231130114327.1530225-1-justinlai0215@realtek.com>
	<20231130114327.1530225-2-justinlai0215@realtek.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 30 Nov 2023 19:43:15 +0800 Justin Lai wrote:
> + *  Below is a simplified block diagram of the chip and its relevant interfaces.
> + *
> + *               *************************
> + *               *                       *
> + *               *  CPU network device   *
> + *               *                       *
> + *               *   +-------------+     *
> + *               *   |  PCIE Host  |     *
> + *               ***********++************
> + *                          ||
> + *                         PCIE
> + *                          ||
> + *      ********************++**********************
> + *      *            | PCIE Endpoint |             *
> + *      *            +---------------+             *
> + *      *                | GMAC |                  *
> + *      *                +--++--+  Realtek         *
> + *      *                   ||     RTL90xx Series  *
> + *      *                   ||                     *
> + *      *     +-------------++----------------+    *
> + *      *     |           | MAC |             |    *
> + *      *     |           +-----+             |    *
> + *      *     |                               |    *
> + *      *     |     Ethernet Switch Core      |    *
> + *      *     |                               |    *
> + *      *     |   +-----+           +-----+   |    *
> + *      *     |   | MAC |...........| MAC |   |    *
> + *      *     +---+-----+-----------+-----+---+    *
> + *      *         | PHY |...........| PHY |        *
> + *      *         +--++-+           +--++-+        *
> + *      *************||****************||***********
> + *
> + *  The block of the Realtek RTL90xx series is our entire chip architecture,
> + *  the GMAC is connected to the switch core, and there is no PHY in between.
> + *  In addition, this driver is mainly used to control GMAC, but does not
> + *  control the switch core, so it is not the same as DSA.

Okay, but you seem to only register one netdev.

Which MAC is it for?

> +#include <linux/crc32.h>
> +#include <linux/dma-mapping.h>
> +#include <linux/etherdevice.h>
> +#include <linux/if_vlan.h>
> +#include <linux/in.h>
> +#include <linux/init.h>
> +#include <linux/interrupt.h>
> +#include <linux/io.h>
> +#include <linux/iopoll.h>
> +#include <linux/ip.h>
> +#include <linux/ipv6.h>
> +#include <linux/mdio.h>
> +#include <linux/module.h>
> +#include <linux/moduleparam.h>

I don't see module params, please trim the includes.

> +#include <linux/netdevice.h>
> +#include <linux/pci.h>
> +#include <linux/pm_runtime.h>
> +#include <linux/prefetch.h>
> +#include <linux/rtnetlink.h>
> +#include <linux/tcp.h>
> +#include <asm/irq.h>
> +#include <net/ip6_checksum.h>
> +#include <net/page_pool/helpers.h>
> +#include <net/pkt_cls.h>

> +static void rtase_get_mac_address(struct net_device *dev)
> +{
> +	struct rtase_private *tp = netdev_priv(dev);
> +	u8 mac_addr[ETH_ALEN] __aligned(2) = {};
> +	u32 i;
> +
> +	for (i = 0; i < ETH_ALEN; i++)
> +		mac_addr[i] = rtase_r8(tp, RTASE_MAC0 + i);
> +
> +	if (!is_valid_ether_addr(mac_addr)) {
> +		eth_random_addr(mac_addr);
> +		dev->addr_assign_type = NET_ADDR_RANDOM;

eth_hw_addr_random()

> +		netdev_warn(dev, "Random ether addr %pM\n", mac_addr);
> +	}
> +
> +	eth_hw_addr_set(dev, mac_addr);
> +	rtase_rar_set(tp, mac_addr);
> +
> +	ether_addr_copy(dev->perm_addr, dev->dev_addr);

Should it be perm if it's random?

> +}
> +
> +static void rtase_reset_interrupt(struct pci_dev *pdev,
> +				  const struct rtase_private *tp)
> +{
> +	if (tp->sw_flag & SWF_MSIX_ENABLED)
> +		pci_disable_msix(pdev);
> +	else
> +		pci_disable_msi(pdev);
> +}
> +
> +static int rtase_alloc_msix(struct pci_dev *pdev, struct rtase_private *tp)
> +{
> +	int ret;
> +	u16 i;
> +
> +	memset(tp->msix_entry, 0x0, RTASE_NUM_MSIX * sizeof(struct msix_entry));
> +
> +	for (i = 0; i < RTASE_NUM_MSIX; i++)
> +		tp->msix_entry[i].entry = i;
> +
> +	ret = pci_enable_msix_range(pdev, tp->msix_entry, tp->int_nums,
> +				    tp->int_nums);

pci_enable_msix_exact()

> +	if (ret == tp->int_nums) {
> +		for (i = 0; i < tp->int_nums; i++) {
> +			tp->int_vector[i].irq = pci_irq_vector(pdev, i);
> +			tp->int_vector[i].status = 1;
> +		}
> +	}
> +
> +	return ret;
> +}

> +	if (!dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(64)))
> +		dev->features |= NETIF_F_HIGHDMA;
> +	else if (dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(32)))
> +		goto err_out_free_res;
> +	else
> +		dev_info(&pdev->dev, "DMA_BIT_MASK: 32\n");

This dance is unnecessary, see https://lkml.org/lkml/2021/6/7/398

> +	dev->tstats = netdev_alloc_pcpu_stats(struct pcpu_sw_netstats);
> +	if (!dev->tstats)
> +		goto err_out_1;

Please use dev->pcpu_stat_type
Set it before register and core will allocate stats for you.

> +	ret = register_netdev(dev);
> +	if (ret != 0)
> +		goto err_out;
> +
> +	netdev_dbg(dev, "%pM, IRQ %d\n", dev->dev_addr, dev->irq);
> +
> +	netif_carrier_off(dev);

Should be before register_netdev().

> +	goto out;

Just return 0...

> +static void rtase_remove_one(struct pci_dev *pdev)
> +{
> +	struct net_device *dev = pci_get_drvdata(pdev);
> +	struct rtase_private *tp = netdev_priv(dev);
> +	struct rtase_int_vector *ivec;
> +	u32 i;
> +
> +	for (i = 0; i < tp->int_nums; i++) {
> +		ivec = &tp->int_vector[i];
> +		netif_napi_del(&ivec->napi);

NAPI instances should be added on ndo_open()

