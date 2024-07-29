Return-Path: <netdev+bounces-113596-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF77493F403
	for <lists+netdev@lfdr.de>; Mon, 29 Jul 2024 13:28:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 005252831BF
	for <lists+netdev@lfdr.de>; Mon, 29 Jul 2024 11:28:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A68C145330;
	Mon, 29 Jul 2024 11:28:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="Yu+S92ns"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6656613DDAA;
	Mon, 29 Jul 2024 11:28:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722252531; cv=none; b=fDMoSa0uw78IskGCOscK6wim0UgaN/MbTEWUpmaFBDPU6xUalXJnaxaaUuaPWKvJfOhxAvt4WyEAJK7SCZ5FJKpNwOgizCcRufM8wlBMcTPL7WceW1OSl9o5CYUKlGhytVja/xDMszGeGQ1ev0Mnf2RtFEjfxo55fsPbw4ZIcME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722252531; c=relaxed/simple;
	bh=iQzz6hBr6rcaCUZ7xkErMmYRcca5NKRJdp4+ze/FMEQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hISM3kmLr6Dz4vuml2gVVfnQaD+KWtd2FoTlmavV+VWtNBXq0ma9cSl5kEAY+HJhEcqn4fnqfMz7qy1+lmH/gAK8bswDd2WHZCWHSSECn6UyV1hzvN09Qag8iuOHKiH5mYr1CvXcXxHoO2UnFRVzBIiORFqPtXR6SyounmiawtA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=Yu+S92ns; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=DNmwto5kp0C+1NJjEB8Kib+Ypx/Zw6110DGbri4A/Wg=; b=Yu+S92nsi+Wpg2nq8cZAfUAc37
	NR810DTPvmTREKPDXgz1BQyVUn9e4etO9LX0L/AT3DJ+bmQU/dKfKlHj0pyw/T5DsXz6lzmbtRlto
	xX/tmCiBWA4uW7vioAMz5gK4drsD6d8z7slfwiA7hhrf6tGbuqaU6laPzD35Yof+dqgcI2LBkU7Xd
	gpBch9cpFg9Pv1PGky3sSsV8MpSs8iLTWG/kLn3L7p1duVHjzoRtbQ/upnjnnT241hRf4kqVv5Ri5
	zXOGJK2dzL6IfXdWcvz+TLI3sO4Z1trqOheN90s3C3tZ5TupuMF/++eXj7ZsR1ik4nweQbsTAaOJq
	HGFSVWGg==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:42180)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1sYOY4-00043K-03;
	Mon, 29 Jul 2024 12:28:16 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1sYOY3-0004HJ-Vp; Mon, 29 Jul 2024 12:28:16 +0100
Date: Mon, 29 Jul 2024 12:28:15 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Daniel Golle <daniel@makrotopia.org>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	John Crispin <john@phrozen.org>, Felix Fietkau <nbd@nbd.name>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Sean Wang <sean.wang@mediatek.com>,
	Mark Lee <Mark-MC.Lee@mediatek.com>,
	Bc-bocun Chen <bc-bocun.chen@mediatek.com>,
	Sam Shih <Sam.Shih@mediatek.com>,
	Weijie Gao <Weijie.Gao@mediatek.com>,
	Steven Liu <steven.liu@mediatek.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH RFC net-next] net: pcs: add helper module for standalone
 drivers
Message-ID: <Zqd8z+/TL22OJ1iu@shell.armlinux.org.uk>
References: <ba4e359584a6b3bc4b3470822c42186d5b0856f9.1721910728.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ba4e359584a6b3bc4b3470822c42186d5b0856f9.1721910728.git.daniel@makrotopia.org>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Thu, Jul 25, 2024 at 01:44:49PM +0100, Daniel Golle wrote:
> Implement helper module for standalone PCS drivers which allows
> standaline PCS drivers to register and users to get instances of
> 'struct phylink_pcs' using device tree nodes.
> 
> At this point only a single instance for each device tree node is
> supported, once we got devices providing more than one PCS we can
> extend it and introduce an xlate function as well as '#pcs-cells',
> similar to how this is done by the PHY framework.
> 
> Signed-off-by: Daniel Golle <daniel@makrotopia.org>
> ---
> This is meant to provide the infrastructure suggested by
> Russell King in an earlier review. It just took me a long while to
> find the time to implement this.
> Users are going to be the standalone PCS drivers for 8/10 LynxI as
> well as 64/66 USXGMII PCS found on MediaTek MT7988 SoC.
> See also https://patchwork.kernel.org/comment/25636726/
> 
> The full tree where this is being used can be found at
> 
> https://github.com/dangowrt/linux/commits/mt7988-for-next/
> 
>  drivers/net/pcs/Kconfig            |  4 ++
>  drivers/net/pcs/Makefile           |  1 +
>  drivers/net/pcs/pcs-standalone.c   | 95 +++++++++++++++++++++++++++++
>  include/linux/pcs/pcs-standalone.h | 25 ++++++++
>  4 files changed, 129 insertions(+)
>  create mode 100644 drivers/net/pcs/pcs-standalone.c
>  create mode 100644 include/linux/pcs/pcs-standalone.h
> 
> diff --git a/drivers/net/pcs/Kconfig b/drivers/net/pcs/Kconfig
> index f6aa437473de..2b02b9351fa4 100644
> --- a/drivers/net/pcs/Kconfig
> +++ b/drivers/net/pcs/Kconfig
> @@ -5,6 +5,10 @@
>  
>  menu "PCS device drivers"
>  
> +config PCS_STANDALONE
> +	tristate
> +	select PHYLINK
> +
>  config PCS_XPCS
>  	tristate "Synopsys DesignWare Ethernet XPCS"
>  	select PHYLINK
> diff --git a/drivers/net/pcs/Makefile b/drivers/net/pcs/Makefile
> index 4f7920618b90..0cb0057f2b8e 100644
> --- a/drivers/net/pcs/Makefile
> +++ b/drivers/net/pcs/Makefile
> @@ -4,6 +4,7 @@
>  pcs_xpcs-$(CONFIG_PCS_XPCS)	:= pcs-xpcs.o pcs-xpcs-plat.o \
>  				   pcs-xpcs-nxp.o pcs-xpcs-wx.o
>  
> +obj-$(CONFIG_PCS_STANDALONE)	+= pcs-standalone.o
>  obj-$(CONFIG_PCS_XPCS)		+= pcs_xpcs.o
>  obj-$(CONFIG_PCS_LYNX)		+= pcs-lynx.o
>  obj-$(CONFIG_PCS_MTK_LYNXI)	+= pcs-mtk-lynxi.o
> diff --git a/drivers/net/pcs/pcs-standalone.c b/drivers/net/pcs/pcs-standalone.c
> new file mode 100644
> index 000000000000..1569793328a1
> --- /dev/null
> +++ b/drivers/net/pcs/pcs-standalone.c
> @@ -0,0 +1,95 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Helpers for standalone PCS drivers
> + *
> + * Copyright (C) 2024 Daniel Golle <daniel@makrotopia.org>
> + */
> +
> +#include <linux/pcs/pcs-standalone.h>
> +#include <linux/phylink.h>
> +
> +static LIST_HEAD(pcs_list);
> +static DEFINE_MUTEX(pcs_mutex);
> +
> +struct pcs_standalone {
> +	struct device *dev;
> +	struct phylink_pcs *pcs;
> +	struct list_head list;
> +};
> +
> +static void devm_pcs_provider_release(struct device *dev, void *res)
> +{
> +	struct pcs_standalone *pcssa = (struct pcs_standalone *)res;
> +
> +	mutex_lock(&pcs_mutex);
> +	list_del(&pcssa->list);
> +	mutex_unlock(&pcs_mutex);

This needs to do notify phylink if the PCS has gone away, but the
locking for this would be somewhat difficult (because pcs->phylink
could change if the PCS changes.) That would need to be solved
somehow.

> +}
> +
> +int devm_pcs_register(struct device *dev, struct phylink_pcs *pcs)
> +{
> +	struct pcs_standalone *pcssa;
> +
> +	pcssa = devres_alloc(devm_pcs_provider_release, sizeof(*pcssa),
> +			     GFP_KERNEL);
> +	if (!pcssa)
> +		return -ENOMEM;
> +
> +	devres_add(dev, pcssa);
> +	pcssa->pcs = pcs;
> +	pcssa->dev = dev;
> +
> +	mutex_lock(&pcs_mutex);
> +	list_add_tail(&pcssa->list, &pcs_list);
> +	mutex_unlock(&pcs_mutex);
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(devm_pcs_register);
> +
> +static struct pcs_standalone *of_pcs_locate(const struct device_node *_np, u32 index)
> +{
> +	struct device_node *np;
> +	struct pcs_standalone *iter, *pcssa = NULL;
> +
> +	if (!_np)
> +		return NULL;
> +
> +	np = of_parse_phandle(_np, "pcs-handle", index);
> +	if (!np)
> +		return NULL;
> +
> +	mutex_lock(&pcs_mutex);
> +	list_for_each_entry(iter, &pcs_list, list) {
> +		if (iter->dev->of_node != np)
> +			continue;
> +
> +		pcssa = iter;
> +		break;
> +	}
> +	mutex_unlock(&pcs_mutex);
> +
> +	of_node_put(np);
> +
> +	return pcssa ?: ERR_PTR(-ENODEV);
> +}
> +
> +struct phylink_pcs *devm_of_pcs_get(struct device *dev,
> +				    const struct device_node *np,
> +				    unsigned int index)
> +{
> +	struct pcs_standalone *pcssa;
> +
> +	pcssa = of_pcs_locate(np ?: dev->of_node, index);
> +	if (IS_ERR_OR_NULL(pcssa))
> +		return ERR_PTR(PTR_ERR(pcssa));
> +
> +	device_link_add(dev, pcssa->dev, DL_FLAG_AUTOREMOVE_CONSUMER);

This is really not a nice solution when one has a network device that
has multiple interfaces. This will cause all interfaces on that device
to be purged from the system when a PCS for one of the interfaces
goes away. If the system is using NFS-root, that could result in the
rootfs being lost. We should handle this more gracefully.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

