Return-Path: <netdev+bounces-209951-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BA69B11722
	for <lists+netdev@lfdr.de>; Fri, 25 Jul 2025 05:38:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9EA2256709E
	for <lists+netdev@lfdr.de>; Fri, 25 Jul 2025 03:38:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 023C61F1311;
	Fri, 25 Jul 2025 03:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="NuyxOC7K"
X-Original-To: netdev@vger.kernel.org
Received: from out30-97.freemail.mail.aliyun.com (out30-97.freemail.mail.aliyun.com [115.124.30.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09F3D2E3718
	for <netdev@vger.kernel.org>; Fri, 25 Jul 2025 03:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753414734; cv=none; b=kxn1sJtfNrb1W1fzXXXZezhY4oNE0ufwVqmLHcVpul/D1+nHmZKcYJQLytKVf27KVu3BHyPyKmCD+5xIl1zrIKaas1FkeVWxP3BqIuIgJp7EDg1AfjtDgvsnqk31AetqCxOfJrFtatYFutLAO0K+ZCrNpNq4w5A3eAW1HR2Xi0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753414734; c=relaxed/simple;
	bh=7V632FGrN7ZX8tqFT5NsS+TH+39wl5Qtt38JVbA+14g=;
	h=Message-ID:Subject:Date:From:To:Cc:References:In-Reply-To; b=GMnf/kQjXOVI7sB1/mVQMEfh1JKCrR/cWNQUj8WbKDqv0BIbrv6BXp/fVuuNFui7iVR8kzHq4h7uyhfBeAHSH35a541R7eNaH97Wuos3gVELWDAUYXrF8BKekbWRTun5eqFPISGr/W+vpix5WXvZNVl+bC8R5pg0GlRPJ1+uG6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=NuyxOC7K; arc=none smtp.client-ip=115.124.30.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1753414728; h=Message-ID:Subject:Date:From:To;
	bh=CPloVY4TnfQzr726bJepWhqY8pARDBdI1EsnSSeud/Y=;
	b=NuyxOC7KP/I3x4hQxdpMew2SfKdaUNsW+dxoi0LLke59dhaFO+doMEciVAo16aIdD0CMyu5++uzY7c5TW+46aS78+FS4h2Ft7wRZ41/3HQ9ZsJlEVXReX5wXxq/S+fpDrZOG2m4tKNB7/VxDMWdhzVev7JjkZtF/+M48araDQUQ=
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0WjvQFjO_1753414727 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 25 Jul 2025 11:38:47 +0800
Message-ID: <1753414106.2053263-1-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH net-next v1] eea: Add basic driver framework for Alibaba Elastic Ethernet Adaptor
Date: Fri, 25 Jul 2025 11:28:26 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: netdev@vger.kernel.org,
 Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>,
 Wen Gu <guwen@linux.alibaba.com>,
 Philo Lu <lulie@linux.alibaba.com>,
 Lorenzo Bianconi <lorenzo@kernel.org>,
 Lukas Bulwahn <lukas.bulwahn@redhat.com>,
 Parthiban Veerasooran <Parthiban.Veerasooran@microchip.com>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Dust Li <dust.li@linux.alibaba.com>
References: <20250724110645.88734-1-xuanzhuo@linux.alibaba.com>
 <29028773-1996-4905-bf9f-4ed0fa916d58@lunn.ch>
In-Reply-To: <29028773-1996-4905-bf9f-4ed0fa916d58@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

On Thu, 24 Jul 2025 19:42:52 +0200, Andrew Lunn <andrew@lunn.ch> wrote:
> > @@ -202,5 +202,6 @@ source "drivers/net/ethernet/wangxun/Kconfig"
> >  source "drivers/net/ethernet/wiznet/Kconfig"
> >  source "drivers/net/ethernet/xilinx/Kconfig"
> >  source "drivers/net/ethernet/xircom/Kconfig"
> > +source "drivers/net/ethernet/alibaba/Kconfig"
>
> This file is sorted. Please insert in the correct location.
>
> > +struct eea_aq_host_info_cfg {
> > +#ifndef EEA_OS_DISTRO
> > +#define EEA_OS_DISTRO		0
> > +#endif
> > +
> > +#ifndef EEA_DRV_TYPE
> > +#define EEA_DRV_TYPE		0
> > +#endif
>
> Please remove these #ifndef. You know they are not defined, because
> they are not defined.
>
> > +int eea_adminq_config_host_info(struct eea_net *enet)
> > +{
> > +	struct device *dev = enet->edev->dma_dev;
> > +	struct eea_aq_host_info_cfg *cfg;
> > +	struct eea_aq_host_info_rep *rep;
> > +	int rc = -ENOMEM;
> > +
> > +	cfg = kzalloc(sizeof(*cfg), GFP_KERNEL);
> > +	if (!cfg)
> > +		return rc;
> > +
> > +	rep = kzalloc(sizeof(*rep), GFP_KERNEL);
> > +	if (!rep)
> > +		goto free_cfg;
> > +
> > +	cfg->os_type = EEA_OS_LINUX;
> > +	cfg->os_dist = EEA_OS_DISTRO;
> > +	cfg->drv_type = EEA_DRV_TYPE;
> > +
> > +	if (sscanf(utsname()->release, "%hu.%hu.%hu", &cfg->kern_ver_major,
> > +		   &cfg->kern_ver_minor, &cfg->kern_ver_sub_minor) != 3) {
> > +		rc = -EINVAL;
> > +		goto free_rep;
> > +	}
> > +
>
> LINUX_VERSION_MAJOR 6
> LINUX_VERSION_PATCHLEVEL 11
> LINUX_VERSION_SUBLEVEL 0
>
> I still think you should not be doing this.

Please give us a chance to try.


>
> > +static int eea_netdev_stop(struct net_device *netdev)
> > +{
> > +	struct eea_net *enet = netdev_priv(netdev);
> > +
> > +	if (!enet->started) {
> > +		netdev_warn(netdev, "eea netdev stop: but dev is not started.\n");
> > +		return 0;
> > +	}
>
> How does this happen?

This function can be called from other contexts.

When we receive an HA interrupt, it may indicate that there is an error inside
the device, and this function may be called as a result.


>
> > +static int eea_netdev_open(struct net_device *netdev)
> > +{
> > +	struct eea_net *enet = netdev_priv(netdev);
> > +	struct eea_net_tmp tmp = {};
> > +	int err;
> > +
> > +	if (enet->link_err) {
> > +		netdev_err(netdev, "netdev open err, because link error: %d\n",
> > +			   enet->link_err);
>
> What is a link error? You should be able to admin an interface up if
> the cable is not plugged in.


The device may send an interrupt to the driver, and then the driver can query
the device. If there is an error inside the device, the driver will stop
the device. If the user tries to bring up the network device, we will
attempt to prevent that operation.


>
> > +static int eea_netdev_init_features(struct net_device *netdev,
> > +				    struct eea_net *enet,
> > +				    struct eea_device *edev)
> > +{
> > +	eea_update_cfg(enet, edev, cfg);
>
> > +	netdev->min_mtu = ETH_MIN_MTU;
> > +
> > +	mtu = le16_to_cpu(cfg->mtu);
> > +	if (mtu < netdev->min_mtu) {
> > +		dev_err(edev->dma_dev, "device MTU too small. %d < %d", mtu,
> > +			netdev->min_mtu);
>
> This message does not really make it clear the firmware is completely
> broken, and passing invalid values to Linux. I think it is good not to
> trust the firmware, but when the firmware is broken, you probably
> should make that clear to the user.
>
> > +static int __eea_pci_probe(struct pci_dev *pci_dev,
> > +			   struct eea_pci_device *ep_dev);
> > +static void __eea_pci_remove(struct pci_dev *pci_dev, bool flush_ha_work);
>
> No forward declarations. Put the code in the correct order so they are
> not needed.

Here A calls B, B calls C, and C calls A. Please believe me, I don't like this
approach either, but this is the simplest way and allows us to keep the related
code together.


>
> > +static irqreturn_t eea_pci_ha_handle(int irq, void *data)
> > +{
> > +	struct eea_device *edev = data;
> > +
> > +	schedule_work(&edev->ep_dev->ha_handle_work);
> > +
> > +	return IRQ_HANDLED;
> > +}
>
> A threaded interrupt handler might make this simpler.

In our case, the HA interrupt is mainly used to notify some abnormal conditions
or errors from the device side. I think this is a low-probability event. My
understanding is that threaded interrupt hqandler needs to create a thread in
advance, which I consider to be a waste, so I didn't choose to do it this way.

Thanks.

>
> 	Andrew
>

