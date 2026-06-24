Return-Path: <netdev+bounces-301707-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id gPxnBhcAPGqjiAgAu9opvQ
	(envelope-from <netdev+bounces-301707-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 24 Jun 2026 18:04:39 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 788CC6BFE28
	for <lists+netdev@lfdr.de>; Wed, 24 Jun 2026 18:04:38 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=lunn.ch header.s=20171124 header.b="0MWj/FEa";
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-301707-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-301707-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=lunn.ch;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 72F6430B48F9
	for <lists+netdev@lfdr.de>; Wed, 24 Jun 2026 15:56:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C568D3DB33D;
	Wed, 24 Jun 2026 15:56:29 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 465FF3DA7F5;
	Wed, 24 Jun 2026 15:56:27 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782316589; cv=none; b=HeAwLta+dj42IpqxQkglpgnML3M1e2DzTEQYS06l0IuM1Q84QbkDHNdnL6i0j5tN6q190VS6ZfrXxt/otr1lp6aDYSe9to60DDjyldWqpFZ8lYzPxsZIOvHQHREDvzOMl5+zZMszX5a3OR8Uv4GbjGvZ/wARjMuA/oYQ9d2X5NQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782316589; c=relaxed/simple;
	bh=Mlhu70wP3R5L2C0SCOMyyh3fIYNMZaIl5VwCSDriDMI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nSLniE+GO1kmYNnkAkH8ZOV/E6iyeOfaVUsTa9EkZDHuwDJfWW2e5OZOo+Kvs/Uy1Cmvg2HK1q1EAbG42Us5fnR9SM7y3O4S/l0GgAZrVB4XgvGywukxjvtUIb9PdiYvFje9jC37cE2rMjB1FbN++0a74x28L+njQpRzULdjaQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=0MWj/FEa; arc=none smtp.client-ip=156.67.10.101
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=3VABDCrd1jGuDMwSjdhW8OLVFZVtLkEqcz604VeuAs0=; b=0MWj/FEa9zVcYl+adKAuZoukcj
	OX1cfjSnPvdtWQWMpHfLWnNvhzbr3hhVKPUUXhPn8LJAVZl6fcQyDccdTa/xEaaUEgKxQMFOg2WML
	nbhh9+52JyV3uPZ7ssxGy1IeiMkIf8QVkNRnxC3YXrDhfivDvnZn7fYQsfH7QLWXNun8=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wcPxK-00972L-FW; Wed, 24 Jun 2026 17:56:02 +0200
Date: Wed, 24 Jun 2026 17:56:02 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: jackbb_wu@compal.com
Cc: Loic Poulain <loic.poulain@oss.qualcomm.com>,
	Sergey Ryazanov <ryazanov.s.a@gmail.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Wen-Zhi Huang <wen-zhi.huang@mediatek.com>,
	Shi-Wei Yeh <shi-wei.yeh@mediatek.com>,
	Minano Tseng <Minano.tseng@mediatek.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH v3 1/7] net: wwan: t9xx: Add PCIe core
Message-ID: <b6ee3440-385f-4567-993d-c10db6f10b97@lunn.ch>
References: <20260624-t9xx_driver_v1-v3-0-73ff03f60c48@compal.com>
 <20260624-t9xx_driver_v1-v3-1-73ff03f60c48@compal.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260624-t9xx_driver_v1-v3-1-73ff03f60c48@compal.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[lunn.ch,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[lunn.ch:s=20171124];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-301707-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[22];
	FORGED_RECIPIENTS(0.00)[m:jackbb_wu@compal.com,m:loic.poulain@oss.qualcomm.com,m:ryazanov.s.a@gmail.com,m:johannes@sipsolutions.net,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:wen-zhi.huang@mediatek.com,m:shi-wei.yeh@mediatek.com,m:Minano.tseng@mediatek.com,m:matthias.bgg@gmail.com,m:angelogioacchino.delregno@collabora.com,m:horms@kernel.org,m:corbet@lwn.net,m:skhan@linuxfoundation.org,m:linux-kernel@vger.kernel.org,m:netdev@vger.kernel.org,m:linux-arm-kernel@lists.infradead.org,m:linux-mediatek@lists.infradead.org,m:linux-doc@vger.kernel.org,m:ryazanovsa@gmail.com,m:andrew@lunn.ch,m:matthiasbgg@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[oss.qualcomm.com,gmail.com,sipsolutions.net,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,mediatek.com,collabora.com,lwn.net,linuxfoundation.org,vger.kernel.org,lists.infradead.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[lunn.ch:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[compal.com:email,lunn.ch:dkim,lunn.ch:mid,lunn.ch:from_mime,vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 788CC6BFE28


> From: Jack Wu <jackbb_wu@compal.com>
> 
> Registers the T900 device driver with the kernel. Set up all
> the fundamental configurations for the device: PCIe layer,
> Modem Host Cross Core Interface (MHCCIF), Reset Generation
> Unit (RGU), modem common control operations and build
> infrastructure.
> 
> * PCIe layer code implements driver probe and removal, MSI-X
>   interrupt initialization and de-initialization, and the way
>   of resetting the device.
> * MHCCIF provides interrupt channels to communicate events
>   such as handshake, PM and port enumeration.
> * RGU provides interrupt channels to generate notifications
>   from the device so that the T900 driver could get the
>   device reset.
> * Modem common control operations provide the basic read/write
>   functions of the device's hardware registers,
>   mask/unmask/get/clear functions of the device's interrupt
>   registers and inquiry functions of the device's status.
> 
> Signed-off-by: Jack Wu <jackbb_wu@compal.com>
> ---
>  drivers/net/wwan/Kconfig                      |   12 +
>  drivers/net/wwan/Makefile                     |    1 +
>  drivers/net/wwan/t9xx/Makefile                |   10 +
>  drivers/net/wwan/t9xx/mtk_dev.h               |  108 +++
>  drivers/net/wwan/t9xx/pcie/mtk_pci.c          | 1049 +++++++++++++++++++++++++
>  drivers/net/wwan/t9xx/pcie/mtk_pci.h          |  234 ++++++
>  drivers/net/wwan/t9xx/pcie/mtk_pci_drv_m9xx.c |   69 ++
>  drivers/net/wwan/t9xx/pcie/mtk_pci_reg.h      |   70 ++
>  8 files changed, 1553 insertions(+)
> 
> diff --git a/drivers/net/wwan/Kconfig b/drivers/net/wwan/Kconfig
> index 88df55d78d90..4cee537c739f 100644
> --- a/drivers/net/wwan/Kconfig
> +++ b/drivers/net/wwan/Kconfig
> @@ -121,6 +121,18 @@ config MTK_T7XX
>  
>  	  If unsure, say N.
>  
> +config MTK_T9XX
> +	tristate "MediaTek PCIe 5G WWAN modem T9xx device"
> +	depends on PCI
> +	select NET_DEVLINK
> +	help
> +	  Enables MediaTek PCIe based 5G WWAN modem (T9xx series) device.
> +
> +	  To compile this driver as a module, choose M here: the module will be
> +	  called mtk_t9xx.
> +
> +	  If unsure, say N.
> +
>  endif # WWAN
>  
>  endmenu
> diff --git a/drivers/net/wwan/Makefile b/drivers/net/wwan/Makefile
> index 3960c0ae2445..7361eef4c472 100644
> --- a/drivers/net/wwan/Makefile
> +++ b/drivers/net/wwan/Makefile
> @@ -14,3 +14,4 @@ obj-$(CONFIG_QCOM_BAM_DMUX) += qcom_bam_dmux.o
>  obj-$(CONFIG_RPMSG_WWAN_CTRL) += rpmsg_wwan_ctrl.o
>  obj-$(CONFIG_IOSM) += iosm/
>  obj-$(CONFIG_MTK_T7XX) += t7xx/
> +obj-$(CONFIG_MTK_T9XX) += t9xx/
> diff --git a/drivers/net/wwan/t9xx/Makefile b/drivers/net/wwan/t9xx/Makefile
> new file mode 100644
> index 000000000000..6f2dd3f91454
> --- /dev/null
> +++ b/drivers/net/wwan/t9xx/Makefile
> @@ -0,0 +1,10 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +
> +ccflags-y += -I$(src)/pcie
> +ccflags-y += -I$(src)
> +
> +obj-$(CONFIG_MTK_T9XX) += mtk_t9xx.o
> +
> +mtk_t9xx-y := \
> +	pcie/mtk_pci.o \
> +	pcie/mtk_pci_drv_m9xx.o
> diff --git a/drivers/net/wwan/t9xx/mtk_dev.h b/drivers/net/wwan/t9xx/mtk_dev.h
> new file mode 100644
> index 000000000000..8278a0e2875e
> --- /dev/null
> +++ b/drivers/net/wwan/t9xx/mtk_dev.h
> @@ -0,0 +1,108 @@
> +/* SPDX-License-Identifier: GPL-2.0-only
> + *
> + * Copyright (c) 2022, MediaTek Inc.
> + */
> +
> +#ifndef __MTK_DEV_H__
> +#define __MTK_DEV_H__
> +
> +#include <linux/dma-mapping.h>
> +#include <linux/dmapool.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/sched.h>
> +#include <linux/slab.h>
> +#include <linux/spinlock.h>
> +
> +#define MTK_DEV_STR_LEN 16
> +
> +enum mtk_user_id {
> +	MTK_USER_MIN,
> +	MTK_USER_CTRL,
> +	MTK_USER_DATA,
> +	MTK_USER_MAX
> +};
> +
> +enum mtk_dev_evt_h2d {
> +	DEV_EVT_H2D_DEVICE_RESET	= BIT(2),
> +	DEV_EVT_H2D_MAX			= BIT(5)
> +};
> +
> +enum mtk_dev_evt_d2h {
> +	DEV_EVT_D2H_BOOT_FLOW_SYNC	= BIT(4),
> +	DEV_EVT_D2H_ASYNC_HS_NOTIFY_SAP = BIT(5),
> +	DEV_EVT_D2H_ASYNC_HS_NOTIFY_MD	= BIT(6),
> +	DEV_EVT_D2H_MAX			= BIT(11)
> +};
> +
> +struct mtk_md_dev;
> +
> +struct mtk_dev_ops {
> +	u32 (*get_dev_state)(struct mtk_md_dev *mdev);
> +	void (*ack_dev_state)(struct mtk_md_dev *mdev, u32 state);
> +	u32 (*get_dev_cfg)(struct mtk_md_dev *mdev);
> +	int (*register_dev_evt)(struct mtk_md_dev *mdev, u32 dev_evt,
> +				int (*evt_cb)(u32 status, void *data), void *data);
> +	void (*unregister_dev_evt)(struct mtk_md_dev *mdev, u32 dev_evt);
> +	void (*mask_dev_evt)(struct mtk_md_dev *mdev, u32 dev_evt);
> +	void (*unmask_dev_evt)(struct mtk_md_dev *mdev, u32 dev_evt);
> +	void (*clear_dev_evt)(struct mtk_md_dev *mdev, u32 dev_evt);
> +	int (*send_dev_evt)(struct mtk_md_dev *mdev, u32 dev_evt);
> +};
> +
> +/* mtk_md_dev defines the structure of MTK modem device */
> +struct mtk_md_dev {
> +	struct device *dev;
> +	const struct mtk_dev_ops *dev_ops;
> +	void *hw_priv;
> +	u32 hw_ver;
> +	char dev_str[MTK_DEV_STR_LEN];
> +};
> +
> +static inline u32 mtk_dev_get_dev_state(struct mtk_md_dev *mdev)
> +{
> +	return mdev->dev_ops->get_dev_state(mdev);
> +}
> +
> +static inline void mtk_dev_ack_dev_state(struct mtk_md_dev *mdev, u32 state)
> +{
> +	return mdev->dev_ops->ack_dev_state(mdev, state);
> +}
> +
> +static inline u32 mtk_dev_get_dev_cfg(struct mtk_md_dev *mdev)
> +{
> +	return mdev->dev_ops->get_dev_cfg(mdev);
> +}
> +
> +static inline int mtk_dev_register_dev_evt(struct mtk_md_dev *mdev, u32 dev_evt,
> +					   int (*evt_cb)(u32 status, void *data), void *data)
> +{
> +	return mdev->dev_ops->register_dev_evt(mdev, dev_evt, evt_cb, data);
> +}
> +
> +static inline void mtk_dev_unregister_dev_evt(struct mtk_md_dev *mdev, u32 dev_evt)
> +{
> +	mdev->dev_ops->unregister_dev_evt(mdev, dev_evt);
> +}
> +
> +static inline void mtk_dev_mask_dev_evt(struct mtk_md_dev *mdev, u32 dev_evt)
> +{
> +	mdev->dev_ops->mask_dev_evt(mdev, dev_evt);
> +}
> +
> +static inline void mtk_dev_unmask_dev_evt(struct mtk_md_dev *mdev, u32 dev_evt)
> +{
> +	mdev->dev_ops->unmask_dev_evt(mdev, dev_evt);
> +}
> +
> +static inline void mtk_dev_clear_dev_evt(struct mtk_md_dev *mdev, u32 dev_evt)
> +{
> +	mdev->dev_ops->clear_dev_evt(mdev, dev_evt);
> +}
> +
> +static inline int mtk_dev_send_dev_evt(struct mtk_md_dev *mdev, u32 dev_evt)
> +{
> +	return mdev->dev_ops->send_dev_evt(mdev, dev_evt);
> +}
> +
> +#endif /* __MTK_DEV_H__ */
> diff --git a/drivers/net/wwan/t9xx/pcie/mtk_pci.c b/drivers/net/wwan/t9xx/pcie/mtk_pci.c
> new file mode 100644
> index 000000000000..c6a7196fcdd6
> --- /dev/null
> +++ b/drivers/net/wwan/t9xx/pcie/mtk_pci.c
> @@ -0,0 +1,1049 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (c) 2022, MediaTek Inc.
> + */
> +
> +#include <linux/acpi.h>
> +#include <linux/aer.h>
> +#include <linux/bitfield.h>
> +#include <linux/debugfs.h>
> +#include <linux/delay.h>
> +#include <linux/device.h>
> +#include <linux/dma-mapping.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +
> +#include "mtk_dev.h"
> +#include "mtk_pci.h"
> +#include "mtk_pci_reg.h"
> +
> +#define MTK_PCI_BAR_NUM		6
> +#define MTK_PCI_TRANSPARENT_ATR_SIZE	(0x3F)
> +#define MTK_PCI_MINIMUM_ATR_SIZE	(0x1000)
> +#define ATR_SIZE_LO32_MASK		GENMASK_ULL(31, 0)
> +#define ATR_SIZE_HI32_MASK		GENMASK_ULL(63, 32)
> +#define ATR_SIZE_BIAS_FROM_LO32		2
> +#define ATR_ADDR_ALIGN_MASK		0xFFFFF000
> +#define ATR_EN				BIT(0)
> +#define ATR_PARAM_OFFSET		16
> +/* Delay between ACPI PXP._OFF and _ON for modem power cycle stabilization */
> +#define MTK_PLDR_POWER_OFF_DELAY_MS	500
> +#define LE32_TO_U32(x) ((__force u32)(__le32)(x))
> +#define SET_HW_BITS(dest, chs, mhccif, dev)		\
> +	({						\
> +		if ((chs) & (dev))					\
> +			(dest) |= FIELD_PREP(mhccif, 1);		\
> +	})
> +
> +struct mtk_mhccif_cb {
> +	struct list_head entry;
> +	int (*evt_cb)(u32 status, void *data);
> +	void *data;
> +	u32 chs;
> +};
> +
> +/**
> + * mtk_pci_setup_atr() - Configure a PCIe address translation rule
> + * @mdev: MTK MD device
> + * @cfg: ATR configuration parameters
> + *
> + * Return: 0 on success, negative error code on failure.
> + */
> +int mtk_pci_setup_atr(struct mtk_md_dev *mdev, struct mtk_atr_cfg *cfg)
> +{
> +	struct mtk_pci_priv *priv = mdev->hw_priv;
> +	u32 addr, val, size_h, size_l;
> +	int atr_size, pos, offset;
> +
> +	if (cfg->transparent) {
> +		/* No address conversion is performed */
> +		atr_size = MTK_PCI_TRANSPARENT_ATR_SIZE;
> +	} else {
> +		if (cfg->size < MTK_PCI_MINIMUM_ATR_SIZE)
> +			cfg->size = MTK_PCI_MINIMUM_ATR_SIZE;
> +
> +		if (cfg->src_addr & (cfg->size - 1)) {
> +			dev_err((mdev)->dev, "Invalid atr src addr is not aligned to size\n");
> +			return -EFAULT;
> +		}
> +
> +		if (cfg->trsl_addr & (cfg->size - 1)) {
> +			dev_err((mdev)->dev,
> +				"Invalid atr trsl addr is not aligned to size, %llx, %llx\n",
> +				cfg->trsl_addr, cfg->size - 1);
> +			return -EFAULT;
> +		}
> +
> +		size_l = FIELD_GET(ATR_SIZE_LO32_MASK, cfg->size);
> +		size_h = FIELD_GET(ATR_SIZE_HI32_MASK, cfg->size);
> +		pos = ffs(size_l);
> +		if (pos) {
> +			atr_size = pos - ATR_SIZE_BIAS_FROM_LO32;
> +		} else {
> +			pos = ffs(size_h);
> +			atr_size = pos + 32 - ATR_SIZE_BIAS_FROM_LO32;
> +		}
> +	}
> +
> +	/* Calculate table offset */
> +	offset = ATR_PORT_OFFSET * cfg->port + ATR_TABLE_OFFSET * cfg->table;
> +	addr = REG_ATR_PCIE_WIN0_T0_SRC_ADDR_MSB + offset;
> +	val = (u32)(cfg->src_addr >> 32);
> +	mtk_pci_mac_write32(priv, addr, val);
> +
> +	addr = REG_ATR_PCIE_WIN0_T0_SRC_ADDR_LSB + offset;
> +	val = (u32)(cfg->src_addr & ATR_ADDR_ALIGN_MASK) | (atr_size << 1) | ATR_EN;
> +	mtk_pci_mac_write32(priv, addr, val);
> +
> +	addr = REG_ATR_PCIE_WIN0_T0_TRSL_ADDR_MSB + offset;
> +	val = (u32)(cfg->trsl_addr >> 32);
> +	mtk_pci_mac_write32(priv, addr, val);
> +
> +	addr = REG_ATR_PCIE_WIN0_T0_TRSL_ADDR_LSB + offset;
> +	val = (u32)(cfg->trsl_addr & ATR_ADDR_ALIGN_MASK);
> +	mtk_pci_mac_write32(priv, addr, val);
> +
> +	/* TRSL_PARAM */
> +	addr = REG_ATR_PCIE_WIN0_T0_TRSL_PARAM + offset;
> +	val = (cfg->trsl_param << ATR_PARAM_OFFSET) | cfg->trsl_id;
> +	mtk_pci_mac_write32(priv, addr, val);
> +
> +	return 0;
> +}
> +
> +/**
> + * mtk_pci_atr_disable() - Disable all PCIe address translation rules
> + * @priv: MTK PCI private data
> + */
> +void mtk_pci_atr_disable(struct mtk_pci_priv *priv)
> +{
> +	int port, tbl, offset;
> +	u32 val;
> +
> +	/* Disable all ATR table for all ports */
> +	for (port = ATR_SRC_PCI_WIN0; port <= ATR_SRC_AXIS_3; port++)
> +		for (tbl = 0; tbl < ATR_TABLE_NUM_PER_ATR; tbl++) {
> +			/* Calculate table offset */
> +			offset = ATR_PORT_OFFSET * port + ATR_TABLE_OFFSET * tbl;
> +			val = mtk_pci_mac_read32(priv, REG_ATR_PCIE_WIN0_T0_SRC_ADDR_LSB + offset);
> +			val = val & (~BIT(0));
> +			/* Disable table by SRC_ADDR_L */
> +			mtk_pci_mac_write32(priv, REG_ATR_PCIE_WIN0_T0_SRC_ADDR_LSB + offset, val);
> +		}
> +}
> +
> +static void mtk_pci_set_msix_merged(struct mtk_pci_priv *priv, int irq_cnt)
> +{
> +	mtk_pci_mac_write32(priv, REG_PCIE_CFG_MSIX, ffs(irq_cnt) * 2 - 1);
> +}
> +
> +/**
> + * mtk_pci_get_dev_state() - Read the device state from the modem
> + * @mdev: MTK MD device
> + *
> + * Return: Device state value.
> + */
> +u32 mtk_pci_get_dev_state(struct mtk_md_dev *mdev)
> +{
> +	return mtk_pci_mac_read32(mdev->hw_priv, REG_PCIE_DEBUG_DUMMY_7);
> +}
> +
> +/**
> + * mtk_pci_ack_dev_state() - Acknowledge the device state to the modem
> + * @mdev: MTK MD device
> + * @state: State value to acknowledge
> + */
> +void mtk_pci_ack_dev_state(struct mtk_md_dev *mdev, u32 state)
> +{
> +	mtk_pci_mac_write32(mdev->hw_priv, REG_PCIE_DEBUG_DUMMY_7, state);
> +}
> +
> +/**
> + * mtk_pci_get_irq_id() - Map an IRQ source to its hardware IRQ ID
> + * @mdev: MTK MD device
> + * @irq_src: IRQ source enum
> + *
> + * Return: IRQ ID on success, -EINVAL on failure.
> + */
> +int mtk_pci_get_irq_id(struct mtk_md_dev *mdev, enum mtk_irq_src irq_src)
> +{
> +	struct mtk_pci_priv *priv = mdev->hw_priv;
> +	const int *irq_tbl = priv->cfg->irq_tbl;
> +	int irq_id = -EINVAL;
> +
> +	if (irq_src > MTK_IRQ_SRC_MIN && irq_src < MTK_IRQ_SRC_MAX) {
> +		irq_id = irq_tbl[irq_src];
> +		if (irq_id < 0 || irq_id >= MTK_IRQ_CNT_MAX)
> +			irq_id = -EINVAL;
> +	}
> +
> +	return irq_id;
> +}
> +
> +/**
> + * mtk_pci_get_virq_id() - Get the Linux virtual IRQ for a hardware IRQ ID
> + * @mdev: MTK MD device
> + * @irq_id: Hardware IRQ ID
> + *
> + * Return: Virtual IRQ number on success, negative error code on failure.
> + */
> +int mtk_pci_get_virq_id(struct mtk_md_dev *mdev, int irq_id)
> +{
> +	struct pci_dev *pdev = to_pci_dev(mdev->dev);
> +	struct mtk_pci_priv *priv = mdev->hw_priv;
> +
> +	if (!priv->irq_cnt || irq_id < 0)
> +		return -EINVAL;
> +
> +	return pci_irq_vector(pdev, irq_id % priv->irq_cnt);
> +}
> +
> +/**
> + * mtk_pci_register_irq() - Register a callback for a hardware IRQ
> + * @mdev: MTK MD device
> + * @irq_id: Hardware IRQ ID
> + * @irq_cb: Callback function
> + * @data: Private data passed to callback
> + *
> + * Return: 0 on success, negative error code on failure.
> + */
> +int mtk_pci_register_irq(struct mtk_md_dev *mdev, int irq_id,
> +			 int (*irq_cb)(int irq_id, void *data), void *data)
> +{
> +	struct mtk_pci_priv *priv = mdev->hw_priv;
> +
> +	if ((irq_id < 0 || irq_id >= MTK_IRQ_CNT_MAX) || !irq_cb)
> +		return -EINVAL;
> +
> +	if (priv->irq_cb_list[irq_id]) {
> +		dev_err((mdev)->dev,
> +			"Unable to register irq, irq_id=%d, it's already been register by %ps.\n",
> +			irq_id, priv->irq_cb_list[irq_id]);
> +		return -EFAULT;
> +	}
> +	priv->irq_cb_list[irq_id] = irq_cb;
> +	priv->irq_cb_data[irq_id] = data;
> +
> +	return 0;
> +}
> +
> +/**
> + * mtk_pci_unregister_irq() - Unregister a hardware IRQ callback
> + * @mdev: MTK MD device
> + * @irq_id: Hardware IRQ ID
> + *
> + * Return: 0 on success, negative error code on failure.
> + */
> +int mtk_pci_unregister_irq(struct mtk_md_dev *mdev, int irq_id)
> +{
> +	struct mtk_pci_priv *priv = mdev->hw_priv;
> +
> +	if (irq_id < 0 || irq_id >= MTK_IRQ_CNT_MAX)
> +		return -EINVAL;
> +
> +	if (!priv->irq_cb_list[irq_id]) {
> +		dev_err((mdev)->dev, "irq_id=%d has not been registered\n", irq_id);
> +		return -EFAULT;
> +	}
> +	priv->irq_cb_list[irq_id] = NULL;
> +	priv->irq_cb_data[irq_id] = NULL;
> +
> +	return 0;
> +}
> +
> +/**
> + * mtk_pci_mask_irq() - Mask (disable) a hardware IRQ
> + * @mdev: MTK MD device
> + * @irq_id: Hardware IRQ ID
> + *
> + * Return: 0 on success, negative error code on failure.
> + */
> +int mtk_pci_mask_irq(struct mtk_md_dev *mdev, int irq_id)
> +{
> +	struct mtk_pci_priv *priv = mdev->hw_priv;
> +
> +	if (irq_id < 0 || irq_id >= MTK_IRQ_CNT_MAX ||
> +	    priv->irq_type != PCI_IRQ_MSIX) {
> +		dev_err(mdev->dev, "Failed to mask irq: input irq_id=%d\n", irq_id);
> +		return -EINVAL;
> +	}
> +
> +	mtk_pci_mac_write32(priv, REG_IMASK_HOST_MSIX_CLR_GRP0_0, BIT(irq_id));
> +
> +	return 0;
> +}
> +
> +/**
> + * mtk_pci_unmask_irq() - Unmask (enable) a hardware IRQ
> + * @mdev: MTK MD device
> + * @irq_id: Hardware IRQ ID
> + *
> + * Return: 0 on success, negative error code on failure.
> + */
> +int mtk_pci_unmask_irq(struct mtk_md_dev *mdev, int irq_id)
> +{
> +	struct mtk_pci_priv *priv = mdev->hw_priv;
> +
> +	if (irq_id < 0 || irq_id >= MTK_IRQ_CNT_MAX ||
> +	    priv->irq_type != PCI_IRQ_MSIX) {
> +		dev_err(mdev->dev, "Failed to unmask irq: input irq_id=%d\n", irq_id);
> +		return -EINVAL;
> +	}
> +
> +	mtk_pci_mac_write32(priv, REG_IMASK_HOST_MSIX_SET_GRP0_0, BIT(irq_id));
> +
> +	return 0;
> +}
> +
> +/**
> + * mtk_pci_clear_irq() - Clear (acknowledge) a hardware IRQ
> + * @mdev: MTK MD device
> + * @irq_id: Hardware IRQ ID
> + *
> + * Return: 0 on success, negative error code on failure.
> + */
> +int mtk_pci_clear_irq(struct mtk_md_dev *mdev, int irq_id)
> +{
> +	struct mtk_pci_priv *priv = mdev->hw_priv;
> +
> +	if (irq_id < 0 || irq_id >= MTK_IRQ_CNT_MAX ||
> +	    priv->irq_type != PCI_IRQ_MSIX) {
> +		dev_err(mdev->dev, "Failed to clear irq: input irq_id=%d\n", irq_id);
> +		return -EINVAL;
> +	}
> +
> +	mtk_pci_mac_write32(priv, REG_MSIX_ISTATUS_HOST_GRP0_0, BIT(irq_id));
> +
> +	return 0;
> +}
> +
> +static u32 mtk_pci_ext_d2h_evt_hw_bits(u32 chs)
> +{
> +	u32 hw_bits = 0;
> +
> +	SET_HW_BITS(hw_bits, chs, MHCCIF_EP2RC_EVT_BOOT_FLOW_SYNC,
> +		    DEV_EVT_D2H_BOOT_FLOW_SYNC);
> +	SET_HW_BITS(hw_bits, chs, MHCCIF_EP2RC_EVT_ASYNC_HS_NOTIFY_SAP,
> +		    DEV_EVT_D2H_ASYNC_HS_NOTIFY_SAP);
> +	SET_HW_BITS(hw_bits, chs, MHCCIF_EP2RC_EVT_ASYNC_HS_NOTIFY_MD,
> +		    DEV_EVT_D2H_ASYNC_HS_NOTIFY_MD);
> +
> +	return LE32_TO_U32(cpu_to_le32(hw_bits));
> +}
> +
> +static u32 mtk_pci_ext_d2h_evt_chs(u32 hw_bits)
> +{
> +	u32 chs = 0;
> +
> +	if (!hw_bits)
> +		return chs;
> +
> +	chs = FIELD_PREP(DEV_EVT_D2H_BOOT_FLOW_SYNC,
> +			 FIELD_GET(MHCCIF_EP2RC_EVT_BOOT_FLOW_SYNC, hw_bits)) |
> +	      FIELD_PREP(DEV_EVT_D2H_ASYNC_HS_NOTIFY_SAP,
> +			 FIELD_GET(MHCCIF_EP2RC_EVT_ASYNC_HS_NOTIFY_SAP, hw_bits)) |
> +	      FIELD_PREP(DEV_EVT_D2H_ASYNC_HS_NOTIFY_MD,
> +			 FIELD_GET(MHCCIF_EP2RC_EVT_ASYNC_HS_NOTIFY_MD, hw_bits));
> +
> +	return chs;
> +}
> +
> +/**
> + * mtk_pci_register_ext_evt() - Register a callback for MHCCIF device events
> + * @mdev: MTK MD device
> + * @chs: Bitmask of event channels to register
> + * @evt_cb: Callback function
> + * @data: Private data passed to callback
> + *
> + * Return: 0 on success, negative error code on failure.
> + */
> +int mtk_pci_register_ext_evt(struct mtk_md_dev *mdev, u32 chs,
> +			     int (*evt_cb)(u32 status, void *data), void *data)
> +{
> +	struct mtk_pci_priv *priv = mdev->hw_priv;
> +	struct mtk_mhccif_cb *cb;
> +	int ret = 0;
> +
> +	if (!chs || !evt_cb)
> +		return -EINVAL;
> +
> +	spin_lock_bh(&priv->mhccif_lock);
> +	list_for_each_entry(cb, &priv->mhccif_cb_list, entry) {
> +		if (cb->chs & chs) {
> +			ret = -EFAULT;
> +			dev_err((mdev)->dev,
> +				"Unable to register evt, intersection: chs=0x%08x&0x%08x cb=%ps\n",
> +				chs, cb->chs, cb->evt_cb);
> +			goto err_spin_unlock;
> +		}
> +	}
> +	cb = devm_kzalloc(mdev->dev, sizeof(*cb), GFP_ATOMIC);
> +	if (!cb) {
> +		ret = -ENOMEM;
> +		goto err_spin_unlock;
> +	}
> +	cb->evt_cb = evt_cb;
> +	cb->data = data;
> +	cb->chs = chs;
> +	list_add_tail(&cb->entry, &priv->mhccif_cb_list);
> +err_spin_unlock:
> +	spin_unlock_bh(&priv->mhccif_lock);
> +
> +	return ret;
> +}
> +
> +/**
> + * mtk_pci_unregister_ext_evt() - Unregister an MHCCIF device event callback
> + * @mdev: MTK MD device
> + * @chs: Bitmask of event channels to unregister
> + */
> +void mtk_pci_unregister_ext_evt(struct mtk_md_dev *mdev, u32 chs)
> +{
> +	struct mtk_pci_priv *priv = mdev->hw_priv;
> +	struct mtk_mhccif_cb *cb, *next;
> +
> +	if (!chs)
> +		return;
> +
> +	spin_lock_bh(&priv->mhccif_lock);
> +	list_for_each_entry_safe(cb, next, &priv->mhccif_cb_list, entry) {
> +		if (cb->chs == chs) {
> +			list_del(&cb->entry);
> +			devm_kfree(mdev->dev, cb);
> +			goto out;
> +		}
> +	}
> +	dev_warn((mdev)->dev,
> +		 "Unable to unregister evt, no chs=0x%08x has been registered.\n", chs);
> +out:
> +	spin_unlock_bh(&priv->mhccif_lock);
> +}
> +
> +/**
> + * mtk_pci_mask_ext_evt() - Mask (disable) MHCCIF device events
> + * @mdev: MTK MD device
> + * @chs: Bitmask of event channels to mask
> + */
> +void mtk_pci_mask_ext_evt(struct mtk_md_dev *mdev, u32 chs)
> +{
> +	struct mtk_pci_priv *priv = mdev->hw_priv;
> +	u32 hw_bits = mtk_pci_ext_d2h_evt_hw_bits(chs);
> +
> +	mtk_pci_write32(mdev, priv->cfg->mhccif_rc_base_addr +
> +			MHCCIF_EP2RC_SW_INT_EAP_MASK_SET, hw_bits);
> +}
> +
> +/**
> + * mtk_pci_unmask_ext_evt() - Unmask (enable) MHCCIF device events
> + * @mdev: MTK MD device
> + * @chs: Bitmask of event channels to unmask
> + */
> +void mtk_pci_unmask_ext_evt(struct mtk_md_dev *mdev, u32 chs)
> +{
> +	struct mtk_pci_priv *priv = mdev->hw_priv;
> +	u32 hw_bits = mtk_pci_ext_d2h_evt_hw_bits(chs);
> +
> +	mtk_pci_write32(mdev, priv->cfg->mhccif_rc_base_addr +
> +			MHCCIF_EP2RC_SW_INT_EAP_MASK_CLR, hw_bits);
> +}
> +
> +/**
> + * mtk_pci_clear_ext_evt() - Clear (acknowledge) MHCCIF device events
> + * @mdev: MTK MD device
> + * @chs: Bitmask of event channels to clear
> + */
> +void mtk_pci_clear_ext_evt(struct mtk_md_dev *mdev, u32 chs)
> +{
> +	struct mtk_pci_priv *priv = mdev->hw_priv;
> +	u32 hw_bits = mtk_pci_ext_d2h_evt_hw_bits(chs);
> +
> +	mtk_pci_write32(mdev, priv->cfg->mhccif_rc_base_addr +
> +			MHCCIF_EP2RC_SW_INT_ACK, hw_bits);
> +}
> +
> +static u32 mtk_pci_ext_h2d_evt_hw_bits(u32 chs)
> +{
> +	u32 hw_bits = 0;
> +
> +	SET_HW_BITS(hw_bits, chs, MHCCIF_RC2EP_EVT_DEVICE_RESET,
> +		    DEV_EVT_H2D_DEVICE_RESET);
> +	return LE32_TO_U32(cpu_to_le32(hw_bits));
> +}
> +
> +/**
> + * mtk_pci_send_ext_evt() - Send an MHCCIF event to the modem
> + * @mdev: MTK MD device
> + * @ch: Event channel to trigger (must be a single bit)
> + *
> + * Return: 0 on success, negative error code on failure.
> + */
> +int mtk_pci_send_ext_evt(struct mtk_md_dev *mdev, u32 ch)
> +{
> +	struct mtk_pci_priv *priv = mdev->hw_priv;
> +	u32 rc_base, hw_bits;
> +
> +	rc_base = priv->cfg->mhccif_rc_base_addr;
> +
> +	/* Only allow one ch to be triggered at a time */
> +	if (!is_power_of_2(ch)) {
> +		dev_err((mdev)->dev, "Unsupported ext evt ch=0x%08x\n", ch);
> +		return -EINVAL;
> +	}
> +
> +	hw_bits = mtk_pci_ext_h2d_evt_hw_bits(ch);
> +	mtk_pci_write32(mdev, rc_base + MHCCIF_RC2EP_SW_BSY, hw_bits);
> +	mtk_pci_write32(mdev, rc_base + MHCCIF_RC2EP_SW_TCHNUM, ffs(hw_bits) - 1);
> +	return 0;
> +}
> +
> +static u32 mtk_pci_get_ext_evt_hw_status(struct mtk_md_dev *mdev)
> +{
> +	struct mtk_pci_priv *priv = mdev->hw_priv;
> +
> +	return mtk_pci_read32(mdev, priv->cfg->mhccif_rc_base_addr +
> +			      MHCCIF_EP2RC_SW_INT_STS);
> +}
> +
> +/**
> + * mtk_pci_fldr() - Perform a Function Level Device Reset via ACPI _RST
> + * @mdev: MTK MD device
> + *
> + * Return: 0 on success, negative error code on failure.
> + */
> +int mtk_pci_fldr(struct mtk_md_dev *mdev)
> +{
> +#ifdef CONFIG_ACPI

...

> +#else /* !CONFIG_ACPI */
> +	dev_err((mdev)->dev, "Unsupported, CONFIG ACPI hasn't been set to 'y'\n");

Why not just have the Kconfig depend on ACPI?

> +	if (ret) {
> +		dev_err((mdev)->dev, "Failed to register mhccif_irq callback\n");

Why the () around mdev?


    Andrew

---
pw-bot: cr

