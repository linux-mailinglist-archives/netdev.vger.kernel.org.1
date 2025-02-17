Return-Path: <netdev+bounces-167077-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 62FADA38B60
	for <lists+netdev@lfdr.de>; Mon, 17 Feb 2025 19:39:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9302B16812E
	for <lists+netdev@lfdr.de>; Mon, 17 Feb 2025 18:39:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EB07235BF9;
	Mon, 17 Feb 2025 18:39:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TputmEFh"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E68262253BA;
	Mon, 17 Feb 2025 18:39:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739817542; cv=none; b=VBmTIPPxCd9AynSeE89GxW1J9Bbb9U8QcblL0u6TExXpqhhuYOW2SWP0Mwd+PCEvD9NC8tHI1fn9tYuJ/sSGspzH90fzr1YqK6YabWAeYVq1gYi8SzlJcYZyTqyRmhKONL4iB530Ka25gscDW6+/gKqu7d0wD6xfOg+mOetSveg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739817542; c=relaxed/simple;
	bh=dZsC/3h/MKO8YfPS5c8QTfQjs6ZTCKMOtcNcVvSS5+8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SU905kRoK7hrGrHJoPjkinPyQ0s2xP4jbZsOe2TnwfS9M7RoJpWD1UV3yl6ctyZ74UHzL5WpkV6A1WUCRX3R9e5RJI9J7XQTN8v+iuL651j+OyijRAiOrAvFGXZDfd6LpSVqJJGTFK1TSlOn6vr+IIImKUarOecOJguAxzLhKAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TputmEFh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 180BFC4CED1;
	Mon, 17 Feb 2025 18:38:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739817541;
	bh=dZsC/3h/MKO8YfPS5c8QTfQjs6ZTCKMOtcNcVvSS5+8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TputmEFhGLuDkSadMvjCrBnrYPBQ981+8f1P+q7EctybtfBgbapK54U1ua6Jwbf8H
	 sQIyuXwklpqkaCj34MiFpl+l1MwvKeZ3Wj79VH6dYgSD/tiH/3GWC1gpF1/E3SPXyr
	 p3jF/uKHfxummcjwZ6VO6WpB6x2XTYJ+eJvuGWkI7ij596Zqo4oSsQDNItcPXeWiF8
	 PoAMj6ibTObC0E79gj0EkVjVCCjDCMAoYHnbbdXJbxjyi31m2D3FderirberBolW4/
	 SRF8Jc3e27ZgbluuIKIsl05nRiuFu8RjTq04Ty0QH0ogXBVMePTPFIY3ZyE/yB+eRD
	 M6uQkH1dDnqKA==
Date: Mon, 17 Feb 2025 18:38:54 +0000
From: Simon Horman <horms@kernel.org>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Felix Fietkau <nbd@nbd.name>, Sean Wang <sean.wang@mediatek.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	"Chester A. Unal" <chester.a.unal@arinc9.com>,
	Daniel Golle <daniel@makrotopia.org>,
	DENG Qingfang <dqfext@gmail.com>, Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>, netdev@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
	upstream@airoha.com
Subject: Re: [PATCH net-next v4 13/16] net: airoha: Introduce Airoha NPU
 support
Message-ID: <20250217183854.GP1615191@kernel.org>
References: <20250213-airoha-en7581-flowtable-offload-v4-0-b69ca16d74db@kernel.org>
 <20250213-airoha-en7581-flowtable-offload-v4-13-b69ca16d74db@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250213-airoha-en7581-flowtable-offload-v4-13-b69ca16d74db@kernel.org>

On Thu, Feb 13, 2025 at 04:34:32PM +0100, Lorenzo Bianconi wrote:
> Packet Processor Engine (PPE) module available on EN7581 SoC populates
> the PPE table with 5-tuples flower rules learned from traffic forwarded
> between the GDM ports connected to the Packet Switch Engine (PSE) module.
> The airoha_eth driver can enable hw acceleration of learned 5-tuples
> rules if the user configure them in netfilter flowtable (netfilter
> flowtable support will be added with subsequent patches).
> airoha_eth driver configures and collects data from the PPE module via a
> Network Processor Unit (NPU) RISC-V module available on the EN7581 SoC.
> Introduce basic support for Airoha NPU moudle.

nit: module

> 
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>

...

> diff --git a/drivers/net/ethernet/airoha/airoha_npu.c b/drivers/net/ethernet/airoha/airoha_npu.c

...

> +static int airoha_npu_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct reserved_mem *rmem;
> +	struct airoha_npu *npu;
> +	struct device_node *np;
> +	void __iomem *base;
> +	int i, irq, err;
> +
> +	base = devm_platform_ioremap_resource(pdev, 0);
> +	if (IS_ERR(base))
> +		return PTR_ERR(base);
> +
> +	npu = devm_kzalloc(dev, sizeof(*npu), GFP_KERNEL);
> +	if (!npu)
> +		return -ENOMEM;
> +
> +	npu->dev = dev;
> +	npu->regmap = devm_regmap_init_mmio(dev, base, &regmap_config);
> +	if (IS_ERR(npu->regmap))
> +		return PTR_ERR(npu->regmap);
> +
> +	np = of_parse_phandle(dev->of_node, "memory-region", 0);
> +	if (!np)
> +		return -ENODEV;
> +
> +	rmem = of_reserved_mem_lookup(np);
> +	of_node_put(np);
> +
> +	if (!rmem)
> +		return -ENODEV;
> +
> +	irq = platform_get_irq(pdev, 0);
> +	if (irq < 0)
> +		return irq;
> +
> +	err = devm_request_irq(dev, irq, airoha_npu_mbox_handler,
> +			       IRQF_SHARED, "airoha-npu-mbox", npu);
> +	if (err)
> +		return err;
> +
> +	for (i = 0; i < ARRAY_SIZE(npu->cores); i++) {
> +		struct airoha_npu_core *core = &npu->cores[i];
> +
> +		spin_lock_init(&core->lock);
> +		core->npu = npu;
> +
> +		irq = platform_get_irq(pdev, i + 1);
> +		if (irq < 0)
> +			return err;

> new file mode 100644
> index 0000000000000000000000000000000000000000..3620f4e771e659de4c91b40575e18d689199fb4c
> --- /dev/null
> +++ b/drivers/net/ethernet/airoha/airoha_npu.c
> @@ -0,0 +1,521 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (c) 2025 AIROHA Inc
> + * Author: Lorenzo Bianconi <lorenzo@kernel.org>
> + */
> +
> +#include <linux/devcoredump.h>
> +#include <linux/firmware.h>
> +#include <linux/platform_device.h>
> +#include <linux/of_net.h>
> +#include <linux/of_platform.h>
> +#include <linux/of_reserved_mem.h>
> +#include <linux/regmap.h>
> +
> +#include "airoha_npu.h"
> +
> +#define NPU_EN7581_FIRMWARE_DATA		"airoha/en7581_npu_data.bin"
> +#define NPU_EN7581_FIRMWARE_RV32		"airoha/en7581_npu_rv32.bin"
> +#define NPU_EN7581_FIRMWARE_RV32_MAX_SIZE	0x200000
> +#define NPU_EN7581_FIRMWARE_DATA_MAX_SIZE	0x10000
> +#define NPU_DUMP_SIZE				512
> +
> +#define REG_NPU_LOCAL_SRAM		0x0
> +
> +#define NPU_PC_BASE_ADDR		0x305000
> +#define REG_PC_DBG(_n)			(0x305000 + ((_n) * 0x100))
> +
> +#define NPU_CLUSTER_BASE_ADDR		0x306000
> +
> +#define REG_CR_BOOT_TRIGGER		(NPU_CLUSTER_BASE_ADDR + 0x000)
> +#define REG_CR_BOOT_CONFIG		(NPU_CLUSTER_BASE_ADDR + 0x004)
> +#define REG_CR_BOOT_BASE(_n)		(NPU_CLUSTER_BASE_ADDR + 0x020 + ((_n) << 2))
> +
> +#define NPU_MBOX_BASE_ADDR		0x30c000
> +
> +#define REG_CR_MBOX_INT_STATUS		(NPU_MBOX_BASE_ADDR + 0x000)
> +#define MBOX_INT_STATUS_MASK		BIT(8)
> +
> +#define REG_CR_MBOX_INT_MASK(_n)	(NPU_MBOX_BASE_ADDR + 0x004 + ((_n) << 2))
> +#define REG_CR_MBQ0_CTRL(_n)		(NPU_MBOX_BASE_ADDR + 0x030 + ((_n) << 2))
> +#define REG_CR_MBQ8_CTRL(_n)		(NPU_MBOX_BASE_ADDR + 0x0b0 + ((_n) << 2))
> +#define REG_CR_NPU_MIB(_n)		(NPU_MBOX_BASE_ADDR + 0x140 + ((_n) << 2))
> +
> +#define NPU_TIMER_BASE_ADDR		0x310100
> +#define REG_WDT_TIMER_CTRL(_n)		(NPU_TIMER_BASE_ADDR + ((_n) * 0x100))
> +#define WDT_EN_MASK			BIT(25)
> +#define WDT_INTR_MASK			BIT(21)
> +
> +enum {
> +	NPU_OP_SET = 1,
> +	NPU_OP_SET_NO_WAIT,
> +	NPU_OP_GET,
> +	NPU_OP_GET_NO_WAIT,
> +};
> +
> +enum {
> +	NPU_FUNC_WIFI,
> +	NPU_FUNC_TUNNEL,
> +	NPU_FUNC_NOTIFY,
> +	NPU_FUNC_DBA,
> +	NPU_FUNC_TR471,
> +	NPU_FUNC_PPE,
> +};
> +
> +enum {
> +	NPU_MBOX_ERROR,
> +	NPU_MBOX_SUCCESS,
> +};
> +
> +enum {
> +	PPE_FUNC_SET_WAIT,
> +	PPE_FUNC_SET_WAIT_HWNAT_INIT,
> +	PPE_FUNC_SET_WAIT_HWNAT_DEINIT,
> +	PPE_FUNC_SET_WAIT_API,
> +};
> +
> +enum {
> +	PPE2_SRAM_SET_ENTRY,
> +	PPE_SRAM_SET_ENTRY,
> +	PPE_SRAM_SET_VAL,
> +	PPE_SRAM_RESET_VAL,
> +};
> +
> +enum {
> +	QDMA_WAN_ETHER = 1,
> +	QDMA_WAN_PON_XDSL,
> +};
> +
> +#define MBOX_MSG_FUNC_ID	GENMASK(14, 11)
> +#define MBOX_MSG_STATIC_BUF	BIT(5)
> +#define MBOX_MSG_STATUS		GENMASK(4, 2)
> +#define MBOX_MSG_DONE		BIT(1)
> +#define MBOX_MSG_WAIT_RSP	BIT(0)
> +
> +#define PPE_TYPE_L2B_IPV4	2
> +#define PPE_TYPE_L2B_IPV4_IPV6	3
> +
> +struct ppe_mbox_data {
> +	u32 func_type;
> +	u32 func_id;
> +	union {
> +		struct {
> +			u8 cds;
> +			u8 xpon_hal_api;
> +			u8 wan_xsi;
> +			u8 ct_joyme4;
> +			int ppe_type;
> +			int wan_mode;
> +			int wan_sel;
> +		} init_info;
> +		struct {
> +			int func_id;
> +			u32 size;
> +			u32 data;
> +		} set_info;
> +	};
> +};
> +
> +static int airoha_npu_send_msg(struct airoha_npu *npu, int func_id,
> +			       void *p, int size)
> +{
> +	u16 core = 0; /* FIXME */
> +	u32 val, offset = core << 4;
> +	dma_addr_t dma_addr;
> +	void *addr;
> +	int ret;
> +
> +	addr = kzalloc(size, GFP_ATOMIC | GFP_DMA);
> +	if (!addr)
> +		return -ENOMEM;
> +
> +	memcpy(addr, p, size);
> +	dma_addr = dma_map_single(npu->dev, addr, size, DMA_TO_DEVICE);
> +	ret = dma_mapping_error(npu->dev, dma_addr);
> +	if (ret)
> +		goto out;
> +
> +	spin_lock_bh(&npu->cores[core].lock);
> +
> +	regmap_write(npu->regmap, REG_CR_MBQ0_CTRL(0) + offset, dma_addr);
> +	regmap_write(npu->regmap, REG_CR_MBQ0_CTRL(1) + offset, size);
> +	regmap_read(npu->regmap, REG_CR_MBQ0_CTRL(2) + offset, &val);
> +	regmap_write(npu->regmap, REG_CR_MBQ0_CTRL(2) + offset, val + 1);
> +	val = FIELD_PREP(MBOX_MSG_FUNC_ID, func_id) | MBOX_MSG_WAIT_RSP;
> +	regmap_write(npu->regmap, REG_CR_MBQ0_CTRL(3) + offset, val);
> +
> +	ret = regmap_read_poll_timeout_atomic(npu->regmap,
> +					      REG_CR_MBQ0_CTRL(3) + offset,
> +					      val, (val & MBOX_MSG_DONE),
> +					      100, 100 * MSEC_PER_SEC);
> +	if (!ret && FIELD_GET(MBOX_MSG_STATUS, val) != NPU_MBOX_SUCCESS)
> +		ret = -EINVAL;
> +
> +	spin_unlock_bh(&npu->cores[core].lock);
> +
> +	dma_unmap_single(npu->dev, dma_addr, size, DMA_TO_DEVICE);
> +out:
> +	kfree(addr);
> +
> +	return ret;
> +}
> +
> +static int airoha_npu_run_firmware(struct device *dev, void __iomem *base,
> +				   struct reserved_mem *rmem)
> +{
> +	const struct firmware *fw;
> +	void __iomem *addr;
> +	int ret;
> +
> +	ret = request_firmware(&fw, NPU_EN7581_FIRMWARE_RV32, dev);
> +	if (ret)
> +		return ret;
> +
> +	if (fw->size > NPU_EN7581_FIRMWARE_RV32_MAX_SIZE) {
> +		dev_err(dev, "%s: fw size too overlimit (%zu)\n",
> +			NPU_EN7581_FIRMWARE_RV32, fw->size);
> +		ret = -E2BIG;
> +		goto out;
> +	}
> +
> +	addr = devm_ioremap(dev, rmem->base, rmem->size);
> +	if (!addr) {
> +		ret = -ENOMEM;
> +		goto out;
> +	}
> +
> +	memcpy_toio(addr, fw->data, fw->size);
> +	release_firmware(fw);
> +
> +	ret = request_firmware(&fw, NPU_EN7581_FIRMWARE_DATA, dev);
> +	if (ret)
> +		return ret;
> +
> +	if (fw->size > NPU_EN7581_FIRMWARE_DATA_MAX_SIZE) {
> +		dev_err(dev, "%s: fw size too overlimit (%zu)\n",
> +			NPU_EN7581_FIRMWARE_DATA, fw->size);
> +		ret = -E2BIG;
> +		goto out;
> +	}
> +
> +	memcpy_toio(base + REG_NPU_LOCAL_SRAM, fw->data, fw->size);
> +out:
> +	release_firmware(fw);
> +
> +	return ret;
> +}
> +
> +static irqreturn_t airoha_npu_mbox_handler(int irq, void *npu_instance)
> +{
> +	struct airoha_npu *npu = npu_instance;
> +
> +	/* clear mbox interrupt status */
> +	regmap_write(npu->regmap, REG_CR_MBOX_INT_STATUS,
> +		     MBOX_INT_STATUS_MASK);
> +
> +	/* acknowledge npu */
> +	regmap_update_bits(npu->regmap, REG_CR_MBQ8_CTRL(3),
> +			   MBOX_MSG_STATUS | MBOX_MSG_DONE, MBOX_MSG_DONE);
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static void airoha_npu_wdt_work(struct work_struct *work)
> +{
> +	struct airoha_npu_core *core;
> +	struct airoha_npu *npu;
> +	void *dump;
> +	u32 val[3];
> +	int c;
> +
> +	core = container_of(work, struct airoha_npu_core, wdt_work);
> +	npu = core->npu;
> +
> +	dump = vzalloc(NPU_DUMP_SIZE);
> +	if (!dump)
> +		return;
> +
> +	c = core - &npu->cores[0];
> +	regmap_bulk_read(npu->regmap, REG_PC_DBG(c), val, ARRAY_SIZE(val));
> +	snprintf(dump, NPU_DUMP_SIZE, "PC: %08x SP: %08x LR: %08x\n",
> +		 val[0], val[1], val[2]);
> +
> +	dev_coredumpv(npu->dev, dump, NPU_DUMP_SIZE, GFP_KERNEL);
> +}
> +
> +static irqreturn_t airoha_npu_wdt_handler(int irq, void *core_instance)
> +{
> +	struct airoha_npu_core *core = core_instance;
> +	struct airoha_npu *npu = core->npu;
> +	int c = core - &npu->cores[0];
> +	u32 val;
> +
> +	regmap_set_bits(npu->regmap, REG_WDT_TIMER_CTRL(c), WDT_INTR_MASK);
> +	if (!regmap_read(npu->regmap, REG_WDT_TIMER_CTRL(c), &val) &&
> +	    FIELD_GET(WDT_EN_MASK, val))
> +		schedule_work(&core->wdt_work);
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static int airoha_npu_ppe_init(struct airoha_npu *npu)
> +{
> +	struct ppe_mbox_data ppe_data = {
> +		.func_type = NPU_OP_SET,
> +		.func_id = PPE_FUNC_SET_WAIT_HWNAT_INIT,
> +		.init_info = {
> +			.ppe_type = PPE_TYPE_L2B_IPV4_IPV6,
> +			.wan_mode = QDMA_WAN_ETHER,
> +		},
> +	};
> +
> +	return airoha_npu_send_msg(npu, NPU_FUNC_PPE, &ppe_data,
> +				   sizeof(struct ppe_mbox_data));
> +}
> +
> +int airoha_npu_ppe_deinit(struct airoha_npu *npu)
> +{
> +	struct ppe_mbox_data ppe_data = {
> +		.func_type = NPU_OP_SET,
> +		.func_id = PPE_FUNC_SET_WAIT_HWNAT_DEINIT,
> +	};
> +
> +	return airoha_npu_send_msg(npu, NPU_FUNC_PPE, &ppe_data,
> +				   sizeof(struct ppe_mbox_data));
> +}
> +EXPORT_SYMBOL_GPL(airoha_npu_ppe_deinit);
> +
> +int airoha_npu_ppe_flush_sram_entries(struct airoha_npu *npu,
> +				      dma_addr_t foe_addr,
> +				      int sram_num_entries)
> +{
> +	struct ppe_mbox_data ppe_data = {
> +		.func_type = NPU_OP_SET,
> +		.func_id = PPE_FUNC_SET_WAIT_API,
> +		.set_info = {
> +			.func_id = PPE_SRAM_RESET_VAL,
> +			.data = foe_addr,
> +			.size = sram_num_entries,
> +		},
> +	};
> +
> +	return airoha_npu_send_msg(npu, NPU_FUNC_PPE, &ppe_data,
> +				   sizeof(struct ppe_mbox_data));
> +}
> +EXPORT_SYMBOL_GPL(airoha_npu_ppe_flush_sram_entries);
> +
> +int airoha_npu_foe_commit_entry(struct airoha_npu *npu, dma_addr_t foe_addr,
> +				u32 entry_size, u32 hash, bool ppe2)
> +{
> +	struct ppe_mbox_data ppe_data = {
> +		.func_type = NPU_OP_SET,
> +		.func_id = PPE_FUNC_SET_WAIT_API,
> +		.set_info = {
> +			.data = foe_addr,
> +			.size = entry_size,
> +		},
> +	};
> +	int err;
> +
> +	ppe_data.set_info.func_id = ppe2 ? PPE2_SRAM_SET_ENTRY
> +					 : PPE_SRAM_SET_ENTRY;
> +
> +	err = airoha_npu_send_msg(npu, NPU_FUNC_PPE, &ppe_data,
> +				  sizeof(struct ppe_mbox_data));
> +	if (err)
> +		return err;
> +
> +	ppe_data.set_info.func_id = PPE_SRAM_SET_VAL;
> +	ppe_data.set_info.data = hash;
> +	ppe_data.set_info.size = sizeof(u32);
> +
> +	return airoha_npu_send_msg(npu, NPU_FUNC_PPE, &ppe_data,
> +				   sizeof(struct ppe_mbox_data));
> +}
> +EXPORT_SYMBOL_GPL(airoha_npu_foe_commit_entry);
> +
> +struct airoha_npu *airoha_npu_get(struct device *dev)
> +{
> +	struct platform_device *pdev;
> +	struct device_node *np;
> +	struct airoha_npu *npu;
> +
> +	np = of_parse_phandle(dev->of_node, "airoha,npu", 0);
> +	if (!np)
> +		return ERR_PTR(-ENODEV);
> +
> +	pdev = of_find_device_by_node(np);
> +	of_node_put(np);
> +
> +	if (!pdev) {
> +		dev_err(dev, "cannot find device node %s\n", np->name);
> +		return ERR_PTR(-ENODEV);
> +	}
> +
> +	if (!try_module_get(THIS_MODULE)) {
> +		dev_err(dev, "failed to get the device driver module\n");
> +		npu = ERR_PTR(-ENODEV);
> +		goto error_pdev_put;
> +	}
> +
> +	npu = platform_get_drvdata(pdev);
> +	if (!npu) {
> +		npu = ERR_PTR(-ENODEV);
> +		goto error_module_put;
> +	}
> +
> +	if (!device_link_add(dev, &pdev->dev, DL_FLAG_AUTOREMOVE_SUPPLIER)) {
> +		dev_err(&pdev->dev,
> +			"failed to create device link to consumer %s\n",
> +			dev_name(dev));
> +		npu = ERR_PTR(-EINVAL);
> +		goto error_module_put;
> +	}
> +
> +	return npu;
> +
> +error_module_put:
> +	module_put(THIS_MODULE);
> +error_pdev_put:
> +	platform_device_put(pdev);
> +
> +	return npu;
> +}
> +EXPORT_SYMBOL_GPL(airoha_npu_get);
> +
> +void airoha_npu_put(struct airoha_npu *npu)
> +{
> +	module_put(THIS_MODULE);
> +	put_device(npu->dev);
> +}
> +EXPORT_SYMBOL_GPL(airoha_npu_put);
> +
> +static const struct of_device_id of_airoha_npu_match[] = {
> +	{ .compatible = "airoha,en7581-npu" },
> +	{ /* sentinel */ }
> +};
> +MODULE_DEVICE_TABLE(of, of_airoha_npu_match);
> +
> +static const struct regmap_config regmap_config = {
> +	.name			= "npu",
> +	.reg_bits		= 32,
> +	.val_bits		= 32,
> +	.reg_stride		= 4,
> +	.disable_locking	= true,
> +};

Should this return irq rather than err?

Flagged by Smatch.

> +
> +		err = devm_request_irq(dev, irq, airoha_npu_wdt_handler,
> +				       IRQF_SHARED, "airoha-npu-wdt", core);
> +		if (err)
> +			return err;
> +
> +		INIT_WORK(&core->wdt_work, airoha_npu_wdt_work);
> +	}
> +
> +	if (dma_set_coherent_mask(dev, 0xbfffffff))
> +		dev_warn(dev, "failed coherent DMA configuration\n");
> +
> +	err = airoha_npu_run_firmware(dev, base, rmem);
> +	if (err)
> +		return err;
> +
> +	regmap_write(npu->regmap, REG_CR_NPU_MIB(10),
> +		     rmem->base + NPU_EN7581_FIRMWARE_RV32_MAX_SIZE);
> +	regmap_write(npu->regmap, REG_CR_NPU_MIB(11), 0x40000); /* SRAM 256K */
> +	regmap_write(npu->regmap, REG_CR_NPU_MIB(12), 0);
> +	regmap_write(npu->regmap, REG_CR_NPU_MIB(21), 1);
> +	msleep(100);
> +
> +	/* setting booting address */
> +	for (i = 0; i < NPU_NUM_CORES; i++)
> +		regmap_write(npu->regmap, REG_CR_BOOT_BASE(i), rmem->base);
> +	usleep_range(1000, 2000);
> +
> +	/* enable NPU cores */
> +	/* do not start core3 since it is used for WiFi offloading */
> +	regmap_write(npu->regmap, REG_CR_BOOT_CONFIG, 0xf7);
> +	regmap_write(npu->regmap, REG_CR_BOOT_TRIGGER, 0x1);
> +	msleep(100);
> +
> +	err = airoha_npu_ppe_init(npu);
> +	if (err)
> +		return err;
> +
> +	platform_set_drvdata(pdev, npu);
> +
> +	return 0;
> +}

...

