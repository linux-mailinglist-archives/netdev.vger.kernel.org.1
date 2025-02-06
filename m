Return-Path: <netdev+bounces-163355-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 95D15A29FB0
	for <lists+netdev@lfdr.de>; Thu,  6 Feb 2025 05:33:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6E1681888258
	for <lists+netdev@lfdr.de>; Thu,  6 Feb 2025 04:33:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A73D215B99E;
	Thu,  6 Feb 2025 04:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D34i8Tmv"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82B8313AD22
	for <netdev@vger.kernel.org>; Thu,  6 Feb 2025 04:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738816379; cv=none; b=WMKUfrX5aw530B8xkANM5s8uhgPEtBMl+95l+s04IJh1tpglwY0r/gt6uf4pVr57LMJGbitCW+dEH3opyvlh1KRepRi55NQdKI65bqAYbuWXRUCsIWyHbfm5JWC+2zeco3r8xOjrt7hLPZhNq2UEiFUpoQGWvYPCYmZINpGvVpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738816379; c=relaxed/simple;
	bh=tIt43yDrnoX3boD296nWHfgOoMYI93zCpj5fIoKJvTE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lRET//dwWHduNFivjkDekKESr8hvA6sNznyNHOLyQRFu36s302APM3WLw1VS0kC7ft/Xwp5O+xjHvGEDQAk/e1TPaaNoqTnUGBqw7Qq6pJzF7f+mHLyt2jruEP4y5kV3nzWJmsb0kfORqqzhaDylNwbOI4s3Lw37GDZWWSnMEuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D34i8Tmv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5213C4CEDD;
	Thu,  6 Feb 2025 04:32:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738816378;
	bh=tIt43yDrnoX3boD296nWHfgOoMYI93zCpj5fIoKJvTE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=D34i8Tmvh7O7uUMbOStKx3Z7SHYvbhR8gATv5VI39MumdbHdzgBkznGvOixmWQLmL
	 fvAZd8rIZpiJIg76vvOW9sfsTfklD0zEKjqMb7wvsIS78K0NF7NpAXs9WUrXogx5XT
	 X2JwG6hvcMwwOeYo0RpxX8WjjMPbJHczWLzO0TDZhYGCdib2w8YvKh0R5KQWDV9T0D
	 SX8EK9AqmlwPBtZyiY+JIjPOBWY3mlpp3v+aMvwpiJ5Qm49Zy9R/b3r2Y6dPPUEp+C
	 GWhTyQUQfMtT0tKbNifQAu9uk/QkPthOE/iBIM/dzMQFft09REVIAr+VXLgXICcXSh
	 7DP6Rz0yo11cQ==
Date: Wed, 5 Feb 2025 20:32:58 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Jacob Keller <jacob.e.keller@intel.com>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: iAVF circular lock dependency due to netdev_lock
Message-ID: <20250205203258.1767c337@kernel.org>
In-Reply-To: <a376e87b-fbd8-4f07-9ab2-80a479782699@intel.com>
References: <81562543-5ea1-4994-9503-90b5ff19b094@intel.com>
	<20250205172325.5f7c8969@kernel.org>
	<a376e87b-fbd8-4f07-9ab2-80a479782699@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 5 Feb 2025 18:27:40 -0800 Jacob Keller wrote:
> > Not sure either, the locking in this driver is quite odd. Do you know
> > why it's registering the netdev from a workqueue, and what the entry
> > points to the driver are?
> 
> Yes, the locking in iAVF has been problematic for years :(
> 
> We register the netdevice from a work queue because we are waiting on
> messages from the PF over virtchnl. I don't fully understand the
> motivation behind the way the initialization was moved into a work
> queue, but this appears to be the historical reasoning from examining
> commit logs.
> 
> > Normally before the netdev is registered it can't get called, so all 
> > the locking is moot. But IDK if we need to protect from some FW
> > interactions, maybe?  
> 
> We had a lot of issues with locking and pain getting to the state we are
> in today. I think part of the challenge is that the VF is communicating
> asynchronously over virtchnl queue messages to the PF for setup.
> 
> Its a mess :( I could re-order the locks so we go "RTNL -> crit_lock ->
> netdev_lock" but that will only work as long as no flow from the kernel
> does something like "RTNL -> netdev_lock -> <driver callback that takes
> crit lock>" which seems unlikely :(
> 
> Its a mess and I don't quite know how to dig out of it.

Stanislav suggested off list that we could add a _locked() version of
register_netdevice(). I'm worried that it's just digging a deeper hole.
We'd cover with the lock parts of core which weren't covered before.

Maybe the saving grace is that the driver appears to never transition
out of the registered state. And netdev lock only protects the core.
So we could elide taking the netdev lock if device is not registered
yet? We'd still need to convince lockdep that its okay to take the
netdev lock under crit lock once.

Code below is incomplete but hopefully it will illustrate. 
Key unanswered question is how to explain this to lockdep..

diff --git a/drivers/net/ethernet/intel/iavf/iavf_main.c b/drivers/net/ethernet/intel/iavf/iavf_main.c
index 4fe481433842..79904d49792a 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_main.c
+++ b/drivers/net/ethernet/intel/iavf/iavf_main.c
@@ -1974,6 +1974,67 @@ static int iavf_reinit_interrupt_scheme(struct iavf_adapter *adapter, bool runni
 	return err;
 }
 
+enum iavf_lock_level {
+	IAVF_LOCK_REMOVING,
+	IAVF_LOCK_CONTENDED,
+	IAVF_LOCK_CRIT_ONLY,
+	IAVF_LOCK_FULL, /* CRIT + netdev_lock */
+};
+
+static enum iavf_lock_level iavf_lock(struct iavf_adapter *adapter, bool try)
+{
+	struct net_device *netdev = adapter->netdev;
+	enum iavf_lock_level ret;
+
+	if (READ_ONCE(netdev->reg_state) >= NETREG_REGISTERED) {
+		netdev_lock(netdev);
+		ret = IAVF_LOCK_FULL;
+	} else {
+		ret = IAVF_LOCK_CRIT_ONLY;
+	}
+
+	if (!try) {
+		mutex_lock(&adapter->crit_lock);
+	} else if (!mutex_trylock(&adapter->crit_lock)) {
+		if (ret == IAVF_LOCK_FULL)
+			netdev_unlock(netdev);
+
+		return adapter->state == __IAVF_REMOVE ?
+			IAVF_LOCK_REMOVING : IAVF_LOCK_CONTENDED;
+	}
+
+	/* Incredibly unlucky, we saw unregistered device yet didn't contend
+	 * with registration for the crit lock. Act as if we did contend.
+	 */
+	if (ret == IAVF_LOCK_CRIT_ONLY &&
+	    READ_ONCE(netdev->reg_state) >= NETREG_REGISTERED) {
+		mutex_unlock(&adapter->crit_lock);
+		return IAVF_LOCK_CONTENDED;
+	}
+
+	return ret;
+}
+
+static void iavf_unlock(struct iavf_adapter *adapter, enum iavf_lock_level lock)
+{
+	struct net_device *netdev = adapter->netdev;
+
+	switch (lock) {
+	case IAVF_LOCK_REMOVING:
+	case IAVF_LOCK_CONTENDED:
+		WARN_ON_ONCE(1);
+		return;
+
+	case IAVF_LOCK_CRIT_ONLY:
+		mutex_unlock(&adapter->crit_lock);
+		break;
+	case IAVF_LOCK_FULL:
+		mutex_unlock(&adapter->crit_lock);
+		netdev_unlock(netdev);
+		break;
+	}
+}
+
 /**
  * iavf_finish_config - do all netdev work that needs RTNL
  * @work: our work_struct
@@ -1983,7 +2044,7 @@ static int iavf_reinit_interrupt_scheme(struct iavf_adapter *adapter, bool runni
 static void iavf_finish_config(struct work_struct *work)
 {
 	struct iavf_adapter *adapter;
-	bool netdev_released = false;
+	enum iavf_lock_level lock;
 	int pairs, err;
 
 	adapter = container_of(work, struct iavf_adapter, finish_config);
@@ -1992,8 +2053,7 @@ static void iavf_finish_config(struct work_struct *work)
 	 * The dev->lock is needed to update the queue number
 	 */
 	rtnl_lock();
-	netdev_lock(adapter->netdev);
-	mutex_lock(&adapter->crit_lock);
+	lock = iavf_lock(adapter, false);
 
 	if ((adapter->flags & IAVF_FLAG_SETUP_NETDEV_FEATURES) &&
 	    adapter->netdev->reg_state == NETREG_REGISTERED &&
@@ -2012,8 +2072,6 @@ static void iavf_finish_config(struct work_struct *work)
 		netif_set_real_num_tx_queues(adapter->netdev, pairs);
 
 		if (adapter->netdev->reg_state != NETREG_REGISTERED) {
-			netdev_unlock(adapter->netdev);
-			netdev_released = true;
 			err = register_netdevice(adapter->netdev);
 			if (err) {
 				dev_err(&adapter->pdev->dev, "Unable to register netdev (%d)\n",
@@ -2040,9 +2098,7 @@ static void iavf_finish_config(struct work_struct *work)
 	}
 
 out:
-	mutex_unlock(&adapter->crit_lock);
-	if (!netdev_released)
-		netdev_unlock(adapter->netdev);
+	iavf_unlock(adapter, lock);
 	rtnl_unlock();
 }
 
@@ -2737,16 +2793,18 @@ static void iavf_watchdog_task(struct work_struct *work)
 						    watchdog_task.work);
 	struct net_device *netdev = adapter->netdev;
 	struct iavf_hw *hw = &adapter->hw;
+	enum iavf_lock_level lock;
 	u32 reg_val;
 
-	netdev_lock(netdev);
-	if (!mutex_trylock(&adapter->crit_lock)) {
-		if (adapter->state == __IAVF_REMOVE) {
-			netdev_unlock(netdev);
-			return;
-		}
-
+	lock = iavf_lock(adapter, true);
+	switch (lock) {
+	case IAVF_LOCK_REMOVING:
+		return;
+	case IAVF_LOCK_CONTENDED:
 		goto restart_watchdog;
+	case IAVF_LOCK_CRIT_ONLY:
+	case IAVF_LOCK_FULL:
+		break; /* continue */
 	}
 
 	if (adapter->flags & IAVF_FLAG_PF_COMMS_FAILED)
@@ -2755,15 +2813,13 @@ static void iavf_watchdog_task(struct work_struct *work)
 	switch (adapter->state) {
 	case __IAVF_STARTUP:
 		iavf_startup(adapter);
-		mutex_unlock(&adapter->crit_lock);
-		netdev_unlock(netdev);
+		iavf_unlock(adapter, lock);
 		queue_delayed_work(adapter->wq, &adapter->watchdog_task,
 				   msecs_to_jiffies(30));
 		return;
 	case __IAVF_INIT_VERSION_CHECK:
 		iavf_init_version_check(adapter);
-		mutex_unlock(&adapter->crit_lock);
-		netdev_unlock(netdev);
+		iavf_unlock(adapter, lock);
 		queue_delayed_work(adapter->wq, &adapter->watchdog_task,
 				   msecs_to_jiffies(30));
 		return;
@@ -2902,8 +2958,7 @@ static void iavf_watchdog_task(struct work_struct *work)
 		return;
 	}
 
-	mutex_unlock(&adapter->crit_lock);
-	netdev_unlock(netdev);
+	iavf_unlock(adapter, lock);
 restart_watchdog:
 	if (adapter->state >= __IAVF_DOWN)
 		queue_work(adapter->wq, &adapter->adminq_task);
@@ -3022,6 +3077,7 @@ static void iavf_reset_task(struct work_struct *work)
 	struct iavf_hw *hw = &adapter->hw;
 	struct iavf_mac_filter *f, *ftmp;
 	struct iavf_cloud_filter *cf;
+	enum iavf_lock_level lock;
 	enum iavf_status status;
 	u32 reg_val;
 	int i = 0, err;
@@ -3030,13 +3086,16 @@ static void iavf_reset_task(struct work_struct *work)
 	/* When device is being removed it doesn't make sense to run the reset
 	 * task, just return in such a case.
 	 */
-	netdev_lock(netdev);
-	if (!mutex_trylock(&adapter->crit_lock)) {
-		if (adapter->state != __IAVF_REMOVE)
-			queue_work(adapter->wq, &adapter->reset_task);
-
-		netdev_unlock(netdev);
+	lock = iavf_lock(adapter, true);
+	switch (lock) {
+	case IAVF_LOCK_REMOVING:
 		return;
+	case IAVF_LOCK_CONTENDED:
+		queue_work(adapter->wq, &adapter->reset_task);
+		return;
+	case IAVF_LOCK_CRIT_ONLY:
+	case IAVF_LOCK_FULL:
+		break; /* continue */
 	}
 
 	iavf_misc_irq_disable(adapter);
@@ -3082,8 +3141,7 @@ static void iavf_reset_task(struct work_struct *work)
 		dev_err(&adapter->pdev->dev, "Reset never finished (%x)\n",
 			reg_val);
 		iavf_disable_vf(adapter);
-		mutex_unlock(&adapter->crit_lock);
-		netdev_unlock(netdev);
+		iavf_unlock(adapter, lock);
 		return; /* Do not attempt to reinit. It's dead, Jim. */
 	}
 
@@ -3223,8 +3281,7 @@ static void iavf_reset_task(struct work_struct *work)
 	adapter->flags &= ~IAVF_FLAG_REINIT_ITR_NEEDED;
 
 	wake_up(&adapter->reset_waitqueue);
-	mutex_unlock(&adapter->crit_lock);
-	netdev_unlock(netdev);
+	iavf_unlock(adapter, lock);
 
 	return;
 reset_err:
@@ -3234,8 +3291,7 @@ static void iavf_reset_task(struct work_struct *work)
 	}
 	iavf_disable_vf(adapter);
 
-	mutex_unlock(&adapter->crit_lock);
-	netdev_unlock(netdev);
+	iavf_unlock(adapter, lock);
 	dev_err(&adapter->pdev->dev, "failed to allocate resources during reinit\n");
 }
 

