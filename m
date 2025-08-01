Return-Path: <netdev+bounces-211323-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 88EF0B17FDD
	for <lists+netdev@lfdr.de>; Fri,  1 Aug 2025 12:05:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 09B591C20309
	for <lists+netdev@lfdr.de>; Fri,  1 Aug 2025 10:05:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 732A821D00E;
	Fri,  1 Aug 2025 10:05:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XcUCOqiJ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 499792E36FF;
	Fri,  1 Aug 2025 10:05:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754042726; cv=none; b=MOJVBAPGtLvADIg7aPIf3DsKBDrphJG4Jg9v3Ke/1ijgmFlfwMqEOGDCRHMKChuDHZZdKRepPAxy26SBzhLgv/Hlf0k3zUNL+anYhv2lmNlAtf9eIWaY5+t7dtbqVxRhPejtoxfQyiyMLdhFVaoR20tm5e5K+rkz1U+Q5ThLB/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754042726; c=relaxed/simple;
	bh=w6pDTD1NLo2TxxU9cYo4iXHA37Y0HGWEzLWLKMXP5JQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dJ62btIcXXjLqjaXnDwr6rZ5jEjpqG1e/VnvHDvlpQDTtbany3p/QZSq/pO1AKRqpCtFvFbVzE1k+dl2kk2NTPfTtJsZ69iMRbh7KENDUsI4Gz6UWRxpIZz/BUaCP7ZSPhalzHKMjj3qwlTvS7kcgQeOVt8X1s1V+RDauaoUDm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XcUCOqiJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 336FAC4CEE7;
	Fri,  1 Aug 2025 10:05:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754042725;
	bh=w6pDTD1NLo2TxxU9cYo4iXHA37Y0HGWEzLWLKMXP5JQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XcUCOqiJXtno7wspxwIoeunM3oJuz+wxoThzYMMvha3X3QyANwsjqHRTaLO8ncHj/
	 Ai/BVotdsfYyzVYU/cNUqY+z2SU3+5sRt0BrSWbj8NGOnaCsKxbR7K3vMtGvZNx5+L
	 fihTM4zX+rKtIESGqBd4BZcofuOzf7rBhnq7n4aJbrlajufy9Z/xlh27sk11yLFpRe
	 H7vZJrMviMLC3uGNpnF+OkWcx6p208I6AK4W4D4EwyWIBIrTXso/eR+pwtD/UILe6Y
	 hDrWhwJhkbC6qFbPegwuKg5Kl+VAgosvRtgxOGZCiw3jteQxmLXhiK2/dFa4Kmtd6I
	 9JUZOoWeFSg0w==
Date: Fri, 1 Aug 2025 11:05:20 +0100
From: Simon Horman <horms@kernel.org>
To: Jijie Shao <shaojijie@huawei.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, andrew+netdev@lunn.ch, shenjian15@huawei.com,
	liuyonglong@huawei.com, chenhao418@huawei.com,
	jonathan.cameron@huawei.com, shameerali.kolothum.thodi@huawei.com,
	salil.mehta@huawei.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net 1/3] net: hibmcge: fix rtnl deadlock issue
Message-ID: <20250801100520.GJ8494@horms.kernel.org>
References: <20250731134749.4090041-1-shaojijie@huawei.com>
 <20250731134749.4090041-2-shaojijie@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250731134749.4090041-2-shaojijie@huawei.com>

On Thu, Jul 31, 2025 at 09:47:47PM +0800, Jijie Shao wrote:
> Currently, the hibmcge netdev acquires the rtnl_lock in
> pci_error_handlers.reset_prepare() and releases it in
> pci_error_handlers.reset_done().
> 
> However, in the PCI framework:
> pci_reset_bus - __pci_reset_slot - pci_slot_save_and_disable_locked -
>  pci_dev_save_and_disable - err_handler->reset_prepare(dev);
> 
> In pci_slot_save_and_disable_locked():
> 	list_for_each_entry(dev, &slot->bus->devices, bus_list) {
> 		if (!dev->slot || dev->slot!= slot)
> 			continue;
> 		pci_dev_save_and_disable(dev);
> 		if (dev->subordinate)
> 			pci_bus_save_and_disable_locked(dev->subordinate);
> 	}
> 
> This will iterate through all devices under the current bus and execute
> err_handler->reset_prepare(), causing two devices of the hibmcge driver
> to sequentially request the rtnl_lock, leading to a deadlock.
> 
> Since the driver now executes netif_device_detach()
> before the reset process, it will not concurrently with
> other netdev APIs, so there is no need to hold the rtnl_lock now.
> 
> Therefore, this patch removes the rtnl_lock during the reset process and
> adjusts the position of HBG_NIC_STATE_RESETTING to ensure
> that multiple resets are not executed concurrently.
> 
> Fixes: 3f5a61f6d504f ("net: hibmcge: Add reset supported in this module")
> Signed-off-by: Jijie Shao <shaojijie@huawei.com>
> ---
>  drivers/net/ethernet/hisilicon/hibmcge/hbg_err.c | 13 ++++---------
>  1 file changed, 4 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/net/ethernet/hisilicon/hibmcge/hbg_err.c b/drivers/net/ethernet/hisilicon/hibmcge/hbg_err.c
> index 503cfbfb4a8a..94bc6f0da912 100644
> --- a/drivers/net/ethernet/hisilicon/hibmcge/hbg_err.c
> +++ b/drivers/net/ethernet/hisilicon/hibmcge/hbg_err.c
> @@ -53,9 +53,11 @@ static int hbg_reset_prepare(struct hbg_priv *priv, enum hbg_reset_type type)
>  {
>  	int ret;
>  
> -	ASSERT_RTNL();
> +	if (test_and_set_bit(HBG_NIC_STATE_RESETTING, &priv->state))
> +		return -EBUSY;
>  
>  	if (netif_running(priv->netdev)) {
> +		clear_bit(HBG_NIC_STATE_RESETTING, &priv->state);
>  		dev_warn(&priv->pdev->dev,
>  			 "failed to reset because port is up\n");
>  		return -EBUSY;
> @@ -64,7 +66,6 @@ static int hbg_reset_prepare(struct hbg_priv *priv, enum hbg_reset_type type)
>  	netif_device_detach(priv->netdev);
>  
>  	priv->reset_type = type;
> -	set_bit(HBG_NIC_STATE_RESETTING, &priv->state);
>  	clear_bit(HBG_NIC_STATE_RESET_FAIL, &priv->state);
>  	ret = hbg_hw_event_notify(priv, HBG_HW_EVENT_RESET);
>  	if (ret) {
> @@ -84,10 +85,8 @@ static int hbg_reset_done(struct hbg_priv *priv, enum hbg_reset_type type)
>  	    type != priv->reset_type)
>  		return 0;
>  
> -	ASSERT_RTNL();
> -
> -	clear_bit(HBG_NIC_STATE_RESETTING, &priv->state);
>  	ret = hbg_rebuild(priv);
> +	clear_bit(HBG_NIC_STATE_RESETTING, &priv->state);

Hi Jijie,

If I understand things correctly, then with this patch the
HBG_NIC_STATE_RESETTING bit is used to prevent concurrent execution.

Noting that a reset may be triggered via eththool, where hbg_reset() is
used as a callback, I am concerned about concurrency implications for lines
below this one.

>  	if (ret) {
>  		priv->stats.reset_fail_cnt++;
>  		set_bit(HBG_NIC_STATE_RESET_FAIL, &priv->state);
> @@ -101,12 +100,10 @@ static int hbg_reset_done(struct hbg_priv *priv, enum hbg_reset_type type)
>  	return ret;
>  }
>  
> -/* must be protected by rtnl lock */
>  int hbg_reset(struct hbg_priv *priv)
>  {
>  	int ret;
>  
> -	ASSERT_RTNL();
>  	ret = hbg_reset_prepare(priv, HBG_RESET_TYPE_FUNCTION);
>  	if (ret)
>  		return ret;
> @@ -171,7 +168,6 @@ static void hbg_pci_err_reset_prepare(struct pci_dev *pdev)
>  	struct net_device *netdev = pci_get_drvdata(pdev);
>  	struct hbg_priv *priv = netdev_priv(netdev);
>  
> -	rtnl_lock();
>  	hbg_reset_prepare(priv, HBG_RESET_TYPE_FLR);
>  }
>  
> @@ -181,7 +177,6 @@ static void hbg_pci_err_reset_done(struct pci_dev *pdev)
>  	struct hbg_priv *priv = netdev_priv(netdev);
>  
>  	hbg_reset_done(priv, HBG_RESET_TYPE_FLR);
> -	rtnl_unlock();
>  }
>  
>  static const struct pci_error_handlers hbg_pci_err_handler = {
> -- 
> 2.33.0
> 

