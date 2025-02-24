Return-Path: <netdev+bounces-169166-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 293AEA42C51
	for <lists+netdev@lfdr.de>; Mon, 24 Feb 2025 20:07:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F0B5716D6E5
	for <lists+netdev@lfdr.de>; Mon, 24 Feb 2025 19:07:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8398F1FDA79;
	Mon, 24 Feb 2025 19:07:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="brMS6lyF"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CD841FC117
	for <netdev@vger.kernel.org>; Mon, 24 Feb 2025 19:06:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740424020; cv=none; b=AAcUX1iqsstHUGgKF51RAmYuwsFZuSxBVQPYk4Of22wboviTg/Bg+DR/L3aCETHFbfE0SA/ijMNg6F0acxpd0yadJQrszNUfzS97VeHtBMj4ykBQlSWLtS9Dz5QV51DbHqIMC58/4sgdOZPhhNw++WeHJMt9ZJS+uesARVHf7pE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740424020; c=relaxed/simple;
	bh=k1PwlPCKImjHJOAH/Zyy1ccbheJTwqF9GXZwpF0lzVE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=p4qZq+3edRaP72xixMnQ60O34hoY/9ALyYtsL/2gkUEr+2RnoFRDELENntNmsV3LcL8N9s9A8ozON6vaFLAhnQqkR9kkMA0CTkabYxd7GocZYA9+0d527tahEORxbp1NzPtwLAVFy4ZdRQWifzf8esp1MTPgsMVx6g1vHTxKgtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=brMS6lyF; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740424019; x=1771960019;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=k1PwlPCKImjHJOAH/Zyy1ccbheJTwqF9GXZwpF0lzVE=;
  b=brMS6lyF/meTnAn4rEixuEU+qL+EeDK7dQLz/tgEf5KaSiTiS3xw6Ly2
   KtK1nybyAMIDEP8BZkzbKoyu6zRfUHgMMd1RpHo+/uNeO9L+2Grrngvap
   ILodACzPrq8zMOb+Qn8Ifzlj3sXhBajssyuUVvrmSx4Xkfl6ca8+w+OVh
   qLzxijSI3xqpvIV0/7Naqt9P8cPWVL+zxdUbqnIdRErbM3h0sFKXjzfZQ
   n4mbYMzDAIJolHCp0PSEZteQNSZlsrsh8QJS567Q7TsSODYrFKffGFZ8V
   6CmGCPgPF6Fx8hep8ky5ZA11VHPmTNKmr5RRKaWIq7/AhyHZktCrmNofR
   Q==;
X-CSE-ConnectionGUID: 5Ts/BP8BQBGXA6A88s0vpA==
X-CSE-MsgGUID: nhWJIdqjR4mkXxu1os2mog==
X-IronPort-AV: E=McAfee;i="6700,10204,11355"; a="58614207"
X-IronPort-AV: E=Sophos;i="6.13,312,1732608000"; 
   d="scan'208";a="58614207"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2025 11:06:55 -0800
X-CSE-ConnectionGUID: H0pONhDPT7KeqPKrPh8dmA==
X-CSE-MsgGUID: vyux8bQuQPSlgr6n0QkdGQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="153358465"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa001.jf.intel.com with ESMTP; 24 Feb 2025 11:06:54 -0800
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Jacob Keller <jacob.e.keller@intel.com>,
	anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	Rafal Romanowski <rafal.romanowski@intel.com>
Subject: [PATCH net 4/5] iavf: fix circular lock dependency with netdev_lock
Date: Mon, 24 Feb 2025 11:06:44 -0800
Message-ID: <20250224190647.3601930-5-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250224190647.3601930-1-anthony.l.nguyen@intel.com>
References: <20250224190647.3601930-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jacob Keller <jacob.e.keller@intel.com>

We have recently seen reports of lockdep circular lock dependency warnings
when loading the iAVF driver:

[ 1504.790308] ======================================================
[ 1504.790309] WARNING: possible circular locking dependency detected
[ 1504.790310] 6.13.0 #net_next_rt.c2933b2befe2.el9 Not tainted
[ 1504.790311] ------------------------------------------------------
[ 1504.790312] kworker/u128:0/13566 is trying to acquire lock:
[ 1504.790313] ffff97d0e4738f18 (&dev->lock){+.+.}-{4:4}, at: register_netdevice+0x52c/0x710
[ 1504.790320]
[ 1504.790320] but task is already holding lock:
[ 1504.790321] ffff97d0e47392e8 (&adapter->crit_lock){+.+.}-{4:4}, at: iavf_finish_config+0x37/0x240 [iavf]
[ 1504.790330]
[ 1504.790330] which lock already depends on the new lock.
[ 1504.790330]
[ 1504.790330]
[ 1504.790330] the existing dependency chain (in reverse order) is:
[ 1504.790331]
[ 1504.790331] -> #1 (&adapter->crit_lock){+.+.}-{4:4}:
[ 1504.790333]        __lock_acquire+0x52d/0xbb0
[ 1504.790337]        lock_acquire+0xd9/0x330
[ 1504.790338]        mutex_lock_nested+0x4b/0xb0
[ 1504.790341]        iavf_finish_config+0x37/0x240 [iavf]
[ 1504.790347]        process_one_work+0x248/0x6d0
[ 1504.790350]        worker_thread+0x18d/0x330
[ 1504.790352]        kthread+0x10e/0x250
[ 1504.790354]        ret_from_fork+0x30/0x50
[ 1504.790357]        ret_from_fork_asm+0x1a/0x30
[ 1504.790361]
[ 1504.790361] -> #0 (&dev->lock){+.+.}-{4:4}:
[ 1504.790364]        check_prev_add+0xf1/0xce0
[ 1504.790366]        validate_chain+0x46a/0x570
[ 1504.790368]        __lock_acquire+0x52d/0xbb0
[ 1504.790370]        lock_acquire+0xd9/0x330
[ 1504.790371]        mutex_lock_nested+0x4b/0xb0
[ 1504.790372]        register_netdevice+0x52c/0x710
[ 1504.790374]        iavf_finish_config+0xfa/0x240 [iavf]
[ 1504.790379]        process_one_work+0x248/0x6d0
[ 1504.790381]        worker_thread+0x18d/0x330
[ 1504.790383]        kthread+0x10e/0x250
[ 1504.790385]        ret_from_fork+0x30/0x50
[ 1504.790387]        ret_from_fork_asm+0x1a/0x30
[ 1504.790389]
[ 1504.790389] other info that might help us debug this:
[ 1504.790389]
[ 1504.790389]  Possible unsafe locking scenario:
[ 1504.790389]
[ 1504.790390]        CPU0                    CPU1
[ 1504.790391]        ----                    ----
[ 1504.790391]   lock(&adapter->crit_lock);
[ 1504.790393]                                lock(&dev->lock);
[ 1504.790394]                                lock(&adapter->crit_lock);
[ 1504.790395]   lock(&dev->lock);
[ 1504.790397]
[ 1504.790397]  *** DEADLOCK ***

This appears to be caused by the change in commit 5fda3f35349b ("net: make
netdev_lock() protect netdev->reg_state"), which added a netdev_lock() in
register_netdevice.

The iAVF driver calls register_netdevice() from iavf_finish_config(), as a
final stage of its state machine post-probe. It currently takes the RTNL
lock, then the netdev lock, and then the device critical lock. This pattern
is used throughout the driver. Thus there is a strong dependency that the
crit_lock should not be acquired before the net device lock. The change to
register_netdevice creates an ABBA lock order violation because the iAVF
driver is holding the crit_lock while calling register_netdevice, which
then takes the netdev_lock.

It seems likely that future refactors could result in netdev APIs which
hold the netdev_lock while calling into the driver. This means that we
should not re-order the locks so that netdev_lock is acquired after the
device private crit_lock.

Instead, notice that we already release the netdev_lock prior to calling
the register_netdevice. This flow only happens during the early driver
initialization as we transition through the __IAVF_STARTUP,
__IAVF_INIT_VERSION_CHECK, __IAVF_INIT_GET_RESOURCES, etc.

Analyzing the places where we take crit_lock in the driver there are two
sources:

a) several of the work queue tasks including adminq_task, watchdog_task,
reset_task, and the finish_config task.

b) various callbacks which ultimately stem back to .ndo operations or
ethtool operations.

The latter cannot be triggered until after the netdevice registration is
completed successfully.

The iAVF driver uses alloc_ordered_workqueue, which is an unbound workqueue
that has a max limit of 1, and thus guarantees that only a single work item
on the queue is executing at any given time, so none of the other work
threads could be executing due to the ordered workqueue guarantees.

The iavf_finish_config() function also does not do anything else after
register_netdevice, unless it fails. It seems unlikely that the driver
private crit_lock is protecting anything that register_netdevice() itself
touches.

Thus, to fix this ABBA lock violation, lets simply release the
adapter->crit_lock as well as netdev_lock prior to calling
register_netdevice(). We do still keep holding the RTNL lock as required by
the function. If we do fail to register the netdevice, then we re-acquire
the adapter critical lock to finish the transition back to
__IAVF_INIT_CONFIG_ADAPTER.

This ensures every call where both netdev_lock and the adapter->crit_lock
are acquired under the same ordering.

Fixes: afc664987ab3 ("eth: iavf: extend the netdev_lock usage")
Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
Tested-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Reviewed-by: Jakub Kicinski <kuba@kernel.org>
Tested-by: Rafal Romanowski <rafal.romanowski@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/iavf/iavf_main.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/intel/iavf/iavf_main.c b/drivers/net/ethernet/intel/iavf/iavf_main.c
index 852e5b62f0a5..6faa62bced3a 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_main.c
+++ b/drivers/net/ethernet/intel/iavf/iavf_main.c
@@ -1983,7 +1983,7 @@ static int iavf_reinit_interrupt_scheme(struct iavf_adapter *adapter, bool runni
 static void iavf_finish_config(struct work_struct *work)
 {
 	struct iavf_adapter *adapter;
-	bool netdev_released = false;
+	bool locks_released = false;
 	int pairs, err;
 
 	adapter = container_of(work, struct iavf_adapter, finish_config);
@@ -2012,19 +2012,22 @@ static void iavf_finish_config(struct work_struct *work)
 		netif_set_real_num_tx_queues(adapter->netdev, pairs);
 
 		if (adapter->netdev->reg_state != NETREG_REGISTERED) {
+			mutex_unlock(&adapter->crit_lock);
 			netdev_unlock(adapter->netdev);
-			netdev_released = true;
+			locks_released = true;
 			err = register_netdevice(adapter->netdev);
 			if (err) {
 				dev_err(&adapter->pdev->dev, "Unable to register netdev (%d)\n",
 					err);
 
 				/* go back and try again.*/
+				mutex_lock(&adapter->crit_lock);
 				iavf_free_rss(adapter);
 				iavf_free_misc_irq(adapter);
 				iavf_reset_interrupt_capability(adapter);
 				iavf_change_state(adapter,
 						  __IAVF_INIT_CONFIG_ADAPTER);
+				mutex_unlock(&adapter->crit_lock);
 				goto out;
 			}
 		}
@@ -2040,9 +2043,10 @@ static void iavf_finish_config(struct work_struct *work)
 	}
 
 out:
-	mutex_unlock(&adapter->crit_lock);
-	if (!netdev_released)
+	if (!locks_released) {
+		mutex_unlock(&adapter->crit_lock);
 		netdev_unlock(adapter->netdev);
+	}
 	rtnl_unlock();
 }
 
-- 
2.47.1


