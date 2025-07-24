Return-Path: <netdev+bounces-209828-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8767FB11077
	for <lists+netdev@lfdr.de>; Thu, 24 Jul 2025 19:43:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6BC52AA58D0
	for <lists+netdev@lfdr.de>; Thu, 24 Jul 2025 17:42:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C593B2EBB9E;
	Thu, 24 Jul 2025 17:43:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="fheyyBHQ"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB4332EBB98
	for <netdev@vger.kernel.org>; Thu, 24 Jul 2025 17:42:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753378980; cv=none; b=heNudSCiFo4eqk7PU/QEaTXyTCkBPG5hhoWcylLClLvErFpq34RxYJF0LT7sCBeJqLQb7ev/D154B6IDwv6B90peOzvunwVTzu0uuoUxctj0It3oNLVj0g/D/Mk2f9/CsSlfIsVy+hFVWDLgQ0K1PDeZsNPd/VioQsyeyHDDnT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753378980; c=relaxed/simple;
	bh=y1bT+ogCl0r2fMKK1jU70zHWH3I3+2oyfGOCekh8uDg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R0B/KfTvgNfcdCdlHSHjV+/3rPKK98ClsuJy0W4bGtc9e52SNmADzX4+c9fWmI+6Ei1RhruuM3rjxy7C8V4aMUVuMquJD3gpADvYFBcKcUeRqIOoSVLjSyNwPE2deMupgZF2hGR0ZpEmYPLFhKZtPLOVt9DkKhOZ+FDMchtnlCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=fheyyBHQ; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=se7SnczgXMIKhLgsraS3TeOBMRA/XnwHwyfCRp+YA7Q=; b=fheyyBHQj2WW/EG19lZz0gayhF
	Pnl05SHsxX2zy9t20kyt3yfrzn1vZziaOPPoppYL8a+ljwSUjWo3F4Fy2kf7xvUHPG7XR7vOn+6Z9
	BqLIQNzTZqVBQjzJ5/MQutCkgl1cbfMR0UOGqZmei3sejunYpJNrwOuNHkXZ3cTiMsBw=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uezy0-002mpP-Nn; Thu, 24 Jul 2025 19:42:52 +0200
Date: Thu, 24 Jul 2025 19:42:52 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Wen Gu <guwen@linux.alibaba.com>,
	Philo Lu <lulie@linux.alibaba.com>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Lukas Bulwahn <lukas.bulwahn@redhat.com>,
	Parthiban Veerasooran <Parthiban.Veerasooran@microchip.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Dust Li <dust.li@linux.alibaba.com>
Subject: Re: [PATCH net-next v1] eea: Add basic driver framework for Alibaba
 Elastic Ethernet Adaptor
Message-ID: <29028773-1996-4905-bf9f-4ed0fa916d58@lunn.ch>
References: <20250724110645.88734-1-xuanzhuo@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250724110645.88734-1-xuanzhuo@linux.alibaba.com>

> @@ -202,5 +202,6 @@ source "drivers/net/ethernet/wangxun/Kconfig"
>  source "drivers/net/ethernet/wiznet/Kconfig"
>  source "drivers/net/ethernet/xilinx/Kconfig"
>  source "drivers/net/ethernet/xircom/Kconfig"
> +source "drivers/net/ethernet/alibaba/Kconfig"

This file is sorted. Please insert in the correct location.

> +struct eea_aq_host_info_cfg {
> +#ifndef EEA_OS_DISTRO
> +#define EEA_OS_DISTRO		0
> +#endif
> +
> +#ifndef EEA_DRV_TYPE
> +#define EEA_DRV_TYPE		0
> +#endif

Please remove these #ifndef. You know they are not defined, because
they are not defined.

> +int eea_adminq_config_host_info(struct eea_net *enet)
> +{
> +	struct device *dev = enet->edev->dma_dev;
> +	struct eea_aq_host_info_cfg *cfg;
> +	struct eea_aq_host_info_rep *rep;
> +	int rc = -ENOMEM;
> +
> +	cfg = kzalloc(sizeof(*cfg), GFP_KERNEL);
> +	if (!cfg)
> +		return rc;
> +
> +	rep = kzalloc(sizeof(*rep), GFP_KERNEL);
> +	if (!rep)
> +		goto free_cfg;
> +
> +	cfg->os_type = EEA_OS_LINUX;
> +	cfg->os_dist = EEA_OS_DISTRO;
> +	cfg->drv_type = EEA_DRV_TYPE;
> +
> +	if (sscanf(utsname()->release, "%hu.%hu.%hu", &cfg->kern_ver_major,
> +		   &cfg->kern_ver_minor, &cfg->kern_ver_sub_minor) != 3) {
> +		rc = -EINVAL;
> +		goto free_rep;
> +	}
> +

LINUX_VERSION_MAJOR 6
LINUX_VERSION_PATCHLEVEL 11
LINUX_VERSION_SUBLEVEL 0

I still think you should not be doing this.

> +static int eea_netdev_stop(struct net_device *netdev)
> +{
> +	struct eea_net *enet = netdev_priv(netdev);
> +
> +	if (!enet->started) {
> +		netdev_warn(netdev, "eea netdev stop: but dev is not started.\n");
> +		return 0;
> +	}

How does this happen?

> +static int eea_netdev_open(struct net_device *netdev)
> +{
> +	struct eea_net *enet = netdev_priv(netdev);
> +	struct eea_net_tmp tmp = {};
> +	int err;
> +
> +	if (enet->link_err) {
> +		netdev_err(netdev, "netdev open err, because link error: %d\n",
> +			   enet->link_err);

What is a link error? You should be able to admin an interface up if
the cable is not plugged in.

> +static int eea_netdev_init_features(struct net_device *netdev,
> +				    struct eea_net *enet,
> +				    struct eea_device *edev)
> +{
> +	eea_update_cfg(enet, edev, cfg);

> +	netdev->min_mtu = ETH_MIN_MTU;
> +
> +	mtu = le16_to_cpu(cfg->mtu);
> +	if (mtu < netdev->min_mtu) {
> +		dev_err(edev->dma_dev, "device MTU too small. %d < %d", mtu,
> +			netdev->min_mtu);

This message does not really make it clear the firmware is completely
broken, and passing invalid values to Linux. I think it is good not to
trust the firmware, but when the firmware is broken, you probably
should make that clear to the user.

> +static int __eea_pci_probe(struct pci_dev *pci_dev,
> +			   struct eea_pci_device *ep_dev);
> +static void __eea_pci_remove(struct pci_dev *pci_dev, bool flush_ha_work);

No forward declarations. Put the code in the correct order so they are
not needed.

> +static irqreturn_t eea_pci_ha_handle(int irq, void *data)
> +{
> +	struct eea_device *edev = data;
> +
> +	schedule_work(&edev->ep_dev->ha_handle_work);
> +
> +	return IRQ_HANDLED;
> +}

A threaded interrupt handler might make this simpler.

	Andrew

