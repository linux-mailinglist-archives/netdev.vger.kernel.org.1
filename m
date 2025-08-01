Return-Path: <netdev+bounces-211334-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C0DCB180A9
	for <lists+netdev@lfdr.de>; Fri,  1 Aug 2025 13:05:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8E23F3A5921
	for <lists+netdev@lfdr.de>; Fri,  1 Aug 2025 11:05:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4483A238C29;
	Fri,  1 Aug 2025 11:05:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jathTBlF"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A9F037160;
	Fri,  1 Aug 2025 11:05:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754046324; cv=none; b=Xe+RgUQcabDGLt+5p7S/ZCAS99aE1ERTmyUJhHIaX04iRRM0lS+o2yr3R5WzGcSLtJPkZlW1KayynEHJPiMsAfP+Fnt5bL6FeV8OArrx1bMdMZDoQqRVH/YcpMXEayJx6IpZLBYb+QNnAyWo0Vi0hskjmQ4F2vLK9UNiAZXTZtw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754046324; c=relaxed/simple;
	bh=difHokwBktTQLgVwGBkJrWHShhZQ9E1oVaauNa7VNeE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hVBB/jqeP+QBjKqUk5bv/zq4BLr690cSJfoeiSYYXo0/SWU6MgFpX5h8IBuVEAoz8u+39EqPZfRfuIkpBv2/ghut1jr4krbBfcSI3H2/dfE83HMxaNZNRLGzqL3ASAcCIoRHLBiCLC97vIXD3DxurQ8MsbYaEs8Yt4i86nV1/CA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jathTBlF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16632C4CEF4;
	Fri,  1 Aug 2025 11:05:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754046323;
	bh=difHokwBktTQLgVwGBkJrWHShhZQ9E1oVaauNa7VNeE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jathTBlF7iNB+Cbbbv7Bp8B6REodF3f8dw7fmOFIiC+dZs0hemDJzvRtNduOKaUle
	 vTB1fiiDyKwLK+zVQk2HdErEi/cMItC5fvDRXoqxgeFVxWd0oW3EIIZe0dkT4elBV5
	 9eXfMv+4Xj5zum0UeONQ0DcgcEHNruLxbtq/TSHdt6TJ5Rxa2d/10JdiYPhazEWpUK
	 REIULTqWqdNdmXZbo7SHopLECBdKFJ5tvp9k3GYSHaykwIFg+C+xdptN6jWK+1FNIM
	 R8+3Jt8spyvo83SbsLV0ds+/+W7NDOsD9Cqk5P2juo5OeUguL2R52jKC2VOl1HDyt6
	 R+bHMMYu10i1Q==
Date: Fri, 1 Aug 2025 12:05:18 +0100
From: Simon Horman <horms@kernel.org>
To: Jijie Shao <shaojijie@huawei.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, andrew+netdev@lunn.ch, shenjian15@huawei.com,
	liuyonglong@huawei.com, chenhao418@huawei.com,
	jonathan.cameron@huawei.com, shameerali.kolothum.thodi@huawei.com,
	salil.mehta@huawei.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net 1/3] net: hibmcge: fix rtnl deadlock issue
Message-ID: <20250801110518.GN8494@horms.kernel.org>
References: <20250731134749.4090041-1-shaojijie@huawei.com>
 <20250731134749.4090041-2-shaojijie@huawei.com>
 <20250801100520.GJ8494@horms.kernel.org>
 <15388e7f-45a8-4356-88c9-45848c3a296f@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <15388e7f-45a8-4356-88c9-45848c3a296f@huawei.com>

On Fri, Aug 01, 2025 at 06:44:36PM +0800, Jijie Shao wrote:
> 
> on 2025/8/1 18:05, Simon Horman wrote:
> > On Thu, Jul 31, 2025 at 09:47:47PM +0800, Jijie Shao wrote:
> > > Currently, the hibmcge netdev acquires the rtnl_lock in
> > > pci_error_handlers.reset_prepare() and releases it in
> > > pci_error_handlers.reset_done().
> > > 
> > > However, in the PCI framework:
> > > pci_reset_bus - __pci_reset_slot - pci_slot_save_and_disable_locked -
> > >   pci_dev_save_and_disable - err_handler->reset_prepare(dev);
> > > 
> > > In pci_slot_save_and_disable_locked():
> > > 	list_for_each_entry(dev, &slot->bus->devices, bus_list) {
> > > 		if (!dev->slot || dev->slot!= slot)
> > > 			continue;
> > > 		pci_dev_save_and_disable(dev);
> > > 		if (dev->subordinate)
> > > 			pci_bus_save_and_disable_locked(dev->subordinate);
> > > 	}
> > > 
> > > This will iterate through all devices under the current bus and execute
> > > err_handler->reset_prepare(), causing two devices of the hibmcge driver
> > > to sequentially request the rtnl_lock, leading to a deadlock.
> > > 
> > > Since the driver now executes netif_device_detach()
> > > before the reset process, it will not concurrently with
> > > other netdev APIs, so there is no need to hold the rtnl_lock now.
> > > 
> > > Therefore, this patch removes the rtnl_lock during the reset process and
> > > adjusts the position of HBG_NIC_STATE_RESETTING to ensure
> > > that multiple resets are not executed concurrently.
> > > 
> > > Fixes: 3f5a61f6d504f ("net: hibmcge: Add reset supported in this module")
> > > Signed-off-by: Jijie Shao <shaojijie@huawei.com>
> > > ---
> > >   drivers/net/ethernet/hisilicon/hibmcge/hbg_err.c | 13 ++++---------
> > >   1 file changed, 4 insertions(+), 9 deletions(-)
> > > 
> > > diff --git a/drivers/net/ethernet/hisilicon/hibmcge/hbg_err.c b/drivers/net/ethernet/hisilicon/hibmcge/hbg_err.c
> > > index 503cfbfb4a8a..94bc6f0da912 100644
> > > --- a/drivers/net/ethernet/hisilicon/hibmcge/hbg_err.c
> > > +++ b/drivers/net/ethernet/hisilicon/hibmcge/hbg_err.c
> > > @@ -53,9 +53,11 @@ static int hbg_reset_prepare(struct hbg_priv *priv, enum hbg_reset_type type)
> > >   {
> > >   	int ret;
> > > -	ASSERT_RTNL();
> > > +	if (test_and_set_bit(HBG_NIC_STATE_RESETTING, &priv->state))
> > > +		return -EBUSY;
> > >   	if (netif_running(priv->netdev)) {
> > > +		clear_bit(HBG_NIC_STATE_RESETTING, &priv->state);
> > >   		dev_warn(&priv->pdev->dev,
> > >   			 "failed to reset because port is up\n");
> > >   		return -EBUSY;
> > > @@ -64,7 +66,6 @@ static int hbg_reset_prepare(struct hbg_priv *priv, enum hbg_reset_type type)
> > >   	netif_device_detach(priv->netdev);
> > >   	priv->reset_type = type;
> > > -	set_bit(HBG_NIC_STATE_RESETTING, &priv->state);
> > >   	clear_bit(HBG_NIC_STATE_RESET_FAIL, &priv->state);
> > >   	ret = hbg_hw_event_notify(priv, HBG_HW_EVENT_RESET);
> > >   	if (ret) {
> > > @@ -84,10 +85,8 @@ static int hbg_reset_done(struct hbg_priv *priv, enum hbg_reset_type type)
> > >   	    type != priv->reset_type)
> > >   		return 0;
> > > -	ASSERT_RTNL();
> > > -
> > > -	clear_bit(HBG_NIC_STATE_RESETTING, &priv->state);
> > >   	ret = hbg_rebuild(priv);
> > > +	clear_bit(HBG_NIC_STATE_RESETTING, &priv->state);
> > Hi Jijie,
> > 
> > If I understand things correctly, then with this patch the
> > HBG_NIC_STATE_RESETTING bit is used to prevent concurrent execution.
> > 
> > Noting that a reset may be triggered via eththool, where hbg_reset() is
> > used as a callback, I am concerned about concurrency implications for lines
> > below this one.
> 
> Yes, just like the following, it can lead to reset and net open concurrency.
> ===========
> 
>      reset1                                              reset2                               open
> 
> set_bit HBG_NIC_STATE_RESETTING
> 
>      netif_device_detach()
>      resetting...
> 
> clear_bit HBG_NIC_STATE_RESETTING
>                                               set_bit HBG_NIC_STATE_RESETTING
>                                                    netif_device_detach()
> 
>       netif_device_attach()
>                                                          resetting...                     hbg_net_open()
>                                                                                           hbg_txrx_init()
> 
>                                               clear_bit HBG_NIC_STATE_RESETTING
>                                                       netif_device_attach()
> 
> ============
> Thank you for your reminder.
> I will fix it in V2

Likewise, thanks.

-- 
pw-bot: cr


