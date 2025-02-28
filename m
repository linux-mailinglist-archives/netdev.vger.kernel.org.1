Return-Path: <netdev+bounces-170872-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3537CA4A5C2
	for <lists+netdev@lfdr.de>; Fri, 28 Feb 2025 23:15:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E52B71893352
	for <lists+netdev@lfdr.de>; Fri, 28 Feb 2025 22:15:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 210D21D61B1;
	Fri, 28 Feb 2025 22:15:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i5bXC5s4"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F12B11C54AF
	for <netdev@vger.kernel.org>; Fri, 28 Feb 2025 22:15:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740780941; cv=none; b=ToM37m/FdTM/iQnHyTKyxP2xd1kUcw+6oaSFdwSiucSRpJOeYQceyXaR4KrtpKavfxKgc4PFpkCWvomHlNH/+YbycE5opEsHGvyp6JTsC8vKZSUKsGkjNZZLTt2q55sneysKT3IO3Ye+KYzWxctD45kwfYNK+5ZblB66SxfI4PU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740780941; c=relaxed/simple;
	bh=6heOxfWxywDuiy3yJUAy/qXWbaQ5qCA4PQSHk5qJY3I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CqRBf6bz4SyPuBZ13MhDts5tQsvTGyBZC2/2ViIwEmtoPD/TQIXxxWWaWBogrqty9c7tPpa2GQIh+rb3ADOU1IafMcMUcbrdWI1petALjJKyycGx+bGwc7EE8DM/2gySyyJMAUs83IhS0ByJAjLhXSplmWSGBLsDz7H9LpLXdqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i5bXC5s4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67B92C4CED6;
	Fri, 28 Feb 2025 22:15:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740780940;
	bh=6heOxfWxywDuiy3yJUAy/qXWbaQ5qCA4PQSHk5qJY3I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=i5bXC5s4gPuv9Hf51x/UfH5pkLJDD79+USOGLTPRCS2didRvBEKYBZ4D6Wh2tZ4P5
	 Ws8ndxsF5tlOIsDrroSbkBtBRfFG9uVuq5Y+IbRjWKZYUwIY+mV7LS2rxWBCG42i0m
	 1LC836FfIZxkU7CTMOIZh2/0HeMKsaWZ8ugckYkAfZLTfYADrQVmkvUxU/00KljohE
	 MyZyv5m2+Pd2gG7wd9ozYifBGkk588IoPn5jqBWkkwDwF/oXRDTMA+1sLCQj9mEuub
	 7B99JjraDBRshcD31m+02NKfjRSEYMQ59jvTahpEXf1GjBZcLofz2mh2Nrj1Lkk6AW
	 GhZQmpUkU5C8g==
Date: Fri, 28 Feb 2025 14:15:39 -0800
From: Saeed Mahameed <saeed@kernel.org>
To: Stanislav Fomichev <sdf@fomichev.me>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com
Subject: Re: [PATCH net-next v9 01/12] net: hold netdev instance lock during
 ndo_open/ndo_stop
Message-ID: <Z8I1iw4Dq8f2ghLW@x130>
References: <20250228045353.1155942-1-sdf@fomichev.me>
 <20250228045353.1155942-2-sdf@fomichev.me>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20250228045353.1155942-2-sdf@fomichev.me>

On 27 Feb 20:53, Stanislav Fomichev wrote:
>For the drivers that use shaper API, switch to the mode where
>core stack holds the netdev lock. This affects two drivers:
>
>* iavf - already grabs netdev lock in ndo_open/ndo_stop, so mostly
>         remove these
>* netdevsim - switch to _locked APIs to avoid deadlock
>
>iavf_close diff is a bit confusing, the existing call looks like this:
>  iavf_close() {
>    netdev_lock()
>    ..
>    netdev_unlock()
>    wait_event_timeout(down_waitqueue)
>  }
>
>I change it to the following:
>  netdev_lock()
>  iavf_close() {
>    ..
>    netdev_unlock()
>    wait_event_timeout(down_waitqueue)
>    netdev_lock() // reusing this lock call
>  }
>  netdev_unlock()
>
>Since I'm reusing existing netdev_lock call, so it looks like I only
>add netdev_unlock.
>
>Cc: Saeed Mahameed <saeed@kernel.org>
>Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>
>---
> drivers/net/ethernet/intel/iavf/iavf_main.c | 14 ++++++-------
> drivers/net/netdevsim/netdev.c              | 14 ++++++++-----
> include/linux/netdevice.h                   | 23 +++++++++++++++++++++
> net/core/dev.c                              | 12 +++++++++++
> net/core/dev.h                              |  6 ++++--
> 5 files changed, 54 insertions(+), 15 deletions(-)
>
>diff --git a/drivers/net/ethernet/intel/iavf/iavf_main.c b/drivers/net/ethernet/intel/iavf/iavf_main.c
>index 71f11f64b13d..9f4d223dffcf 100644
>--- a/drivers/net/ethernet/intel/iavf/iavf_main.c
>+++ b/drivers/net/ethernet/intel/iavf/iavf_main.c
>@@ -4562,22 +4562,21 @@ static int iavf_open(struct net_device *netdev)
> 	struct iavf_adapter *adapter = netdev_priv(netdev);
> 	int err;
>
>+	netdev_assert_locked(netdev);
>+
> 	if (adapter->flags & IAVF_FLAG_PF_COMMS_FAILED) {
> 		dev_err(&adapter->pdev->dev, "Unable to open device due to PF driver failure.\n");
> 		return -EIO;
> 	}
>
>-	netdev_lock(netdev);
> 	while (!mutex_trylock(&adapter->crit_lock)) {
> 		/* If we are in __IAVF_INIT_CONFIG_ADAPTER state the crit_lock
> 		 * is already taken and iavf_open is called from an upper
> 		 * device's notifier reacting on NETDEV_REGISTER event.
> 		 * We have to leave here to avoid dead lock.
> 		 */
>-		if (adapter->state == __IAVF_INIT_CONFIG_ADAPTER) {
>-			netdev_unlock(netdev);
>+		if (adapter->state == __IAVF_INIT_CONFIG_ADAPTER)
> 			return -EBUSY;
>-		}
>
> 		usleep_range(500, 1000);
> 	}
>@@ -4626,7 +4625,6 @@ static int iavf_open(struct net_device *netdev)
> 	iavf_irq_enable(adapter, true);
>
> 	mutex_unlock(&adapter->crit_lock);
>-	netdev_unlock(netdev);
>
> 	return 0;
>
>@@ -4639,7 +4637,6 @@ static int iavf_open(struct net_device *netdev)
> 	iavf_free_all_tx_resources(adapter);
> err_unlock:
> 	mutex_unlock(&adapter->crit_lock);
>-	netdev_unlock(netdev);
>
> 	return err;
> }
>@@ -4661,12 +4658,12 @@ static int iavf_close(struct net_device *netdev)
> 	u64 aq_to_restore;
> 	int status;
>
>-	netdev_lock(netdev);
>+	netdev_assert_locked(netdev);
>+
> 	mutex_lock(&adapter->crit_lock);
>
> 	if (adapter->state <= __IAVF_DOWN_PENDING) {
> 		mutex_unlock(&adapter->crit_lock);
>-		netdev_unlock(netdev);
> 		return 0;
> 	}
>
>@@ -4719,6 +4716,7 @@ static int iavf_close(struct net_device *netdev)
> 	if (!status)
> 		netdev_warn(netdev, "Device resources not yet released\n");
>
>+	netdev_lock(netdev);
> 	mutex_lock(&adapter->crit_lock);
> 	adapter->aq_required |= aq_to_restore;
> 	mutex_unlock(&adapter->crit_lock);
>diff --git a/drivers/net/netdevsim/netdev.c b/drivers/net/netdevsim/netdev.c
>index a41dc79e9c2e..aaa3b58e2e3e 100644
>--- a/drivers/net/netdevsim/netdev.c
>+++ b/drivers/net/netdevsim/netdev.c
>@@ -402,7 +402,7 @@ static int nsim_init_napi(struct netdevsim *ns)
> 	for (i = 0; i < dev->num_rx_queues; i++) {
> 		rq = ns->rq[i];
>
>-		netif_napi_add_config(dev, &rq->napi, nsim_poll, i);
>+		netif_napi_add_config_locked(dev, &rq->napi, nsim_poll, i);
> 	}
>
> 	for (i = 0; i < dev->num_rx_queues; i++) {
>@@ -422,7 +422,7 @@ static int nsim_init_napi(struct netdevsim *ns)
> 	}
>
> 	for (i = 0; i < dev->num_rx_queues; i++)
>-		__netif_napi_del(&ns->rq[i]->napi);
>+		__netif_napi_del_locked(&ns->rq[i]->napi);
>
> 	return err;
> }
>@@ -452,7 +452,7 @@ static void nsim_enable_napi(struct netdevsim *ns)
> 		struct nsim_rq *rq = ns->rq[i];
>
> 		netif_queue_set_napi(dev, i, NETDEV_QUEUE_TYPE_RX, &rq->napi);
>-		napi_enable(&rq->napi);
>+		napi_enable_locked(&rq->napi);
> 	}
> }
>
>@@ -461,6 +461,8 @@ static int nsim_open(struct net_device *dev)
> 	struct netdevsim *ns = netdev_priv(dev);
> 	int err;
>
>+	netdev_assert_locked(dev);
>+
> 	err = nsim_init_napi(ns);
> 	if (err)
> 		return err;
>@@ -478,8 +480,8 @@ static void nsim_del_napi(struct netdevsim *ns)
> 	for (i = 0; i < dev->num_rx_queues; i++) {
> 		struct nsim_rq *rq = ns->rq[i];
>
>-		napi_disable(&rq->napi);
>-		__netif_napi_del(&rq->napi);
>+		napi_disable_locked(&rq->napi);
>+		__netif_napi_del_locked(&rq->napi);
> 	}
> 	synchronize_net();
>
>@@ -494,6 +496,8 @@ static int nsim_stop(struct net_device *dev)
> 	struct netdevsim *ns = netdev_priv(dev);
> 	struct netdevsim *peer;
>
>+	netdev_assert_locked(dev);
>+
> 	netif_carrier_off(dev);
> 	peer = rtnl_dereference(ns->peer);
> 	if (peer)
>diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
>index 26a0c4e4d963..24d54c7e60c2 100644
>--- a/include/linux/netdevice.h
>+++ b/include/linux/netdevice.h
>@@ -2753,6 +2753,29 @@ static inline void netdev_assert_locked_or_invisible(struct net_device *dev)
> 		netdev_assert_locked(dev);
> }
>
>+static inline bool netdev_need_ops_lock(struct net_device *dev)
>+{
>+	bool ret = false;
>+
>+#if IS_ENABLED(CONFIG_NET_SHAPER)
>+	ret |= !!dev->netdev_ops->net_shaper_ops;
>+#endif
>+
>+	return ret;
>+}
>+
>+static inline void netdev_lock_ops(struct net_device *dev)
>+{
>+	if (netdev_need_ops_lock(dev))
>+		netdev_lock(dev);
>+}
>+
>+static inline void netdev_unlock_ops(struct net_device *dev)
>+{
>+	if (netdev_need_ops_lock(dev))
>+		netdev_unlock(dev);
>+}
>+
> void netif_napi_set_irq_locked(struct napi_struct *napi, int irq);
>
> static inline void netif_napi_set_irq(struct napi_struct *napi, int irq)
>diff --git a/net/core/dev.c b/net/core/dev.c
>index d6d68a2d2355..5b1b68cb4a25 100644
>--- a/net/core/dev.c
>+++ b/net/core/dev.c
>@@ -1627,6 +1627,8 @@ static int __dev_open(struct net_device *dev, struct netlink_ext_ack *extack)
> 	if (ret)
> 		return ret;
>
>+	netdev_lock_ops(dev);
>+

Hi Stan,

Just started testing this before review and I hit a deadlock when applying
the patch that implements qmgmt in mlx5.

deadlock:
_dev_open() [netdev_lock_ops(dev)] ==> 1st time lock
   dev_activate() -> 
     attach_default_qdiscs()->
       qdisc_create_dflt()->
         mq_init()-> mq_offload() ->
           dev_setup_tc(dev) [netdev_lock_ops(dev)] ==> 2nd :- double lock 

I am not sure how to solve this right now, since the qdisc API is reached
by callbacks and it's not trivial to select which version of dev_setup_tc()
to call, locked or non locked, the only direction i have right now is that
attached_default_qdiscs is only called by dev_activate() if we can assume
dev_activate() is always netdev_locked, then we can somehow signal that to
mq_offload().


- Saeed.

