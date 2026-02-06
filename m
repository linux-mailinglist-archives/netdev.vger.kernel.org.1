Return-Path: <netdev+bounces-257513-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YKSqMiC9hWmpFwQAu9opvQ
	(envelope-from <netdev+bounces-257513-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 06 Feb 2026 11:06:24 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 18264FC717
	for <lists+netdev@lfdr.de>; Fri, 06 Feb 2026 11:06:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 93FE2300698C
	for <lists+netdev@lfdr.de>; Fri,  6 Feb 2026 10:05:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1419F364036;
	Fri,  6 Feb 2026 10:05:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YlX4+ShY"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B94143624B1
	for <netdev@vger.kernel.org>; Fri,  6 Feb 2026 10:05:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770372306; cv=none; b=Nnidqt273wW85+l9dTa0UwKb/rMAaNqigJX0uwLRQPQSy60Wd9J0DWgDHMT6OaockoPWEn/a4329fZIrD8rm0GuCL5NxVKKd01oknBB66Bm6pbUIjcUdhSdYQIe/GHs+UQbt+3uIqN5Y3qT55d/51q9PieH/mbdSPl8zGBylNRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770372306; c=relaxed/simple;
	bh=QnpscugZSb3g4OoShXcjg+X4KJLtnWW/pU8ma4DiWsw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Nm2KY5ZUsqPRX08KmA8DCx1tmLUgBHYOGz8ThBfD2UM8KPe6dWq3u2nLwlTMEzX9nN/CDINyhsRjBuGj4DChKX7w0y99xcg1+8HnmWsvvJIDP7HINqODyrhn8FabmAKsc5Xxjm0kii8DISZ2hJpXyKf0rrCDi1mwgX0n3vx+WbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YlX4+ShY; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1770372304;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+zwnAVY0VuBSUhQN+0khN7VSvK1uPz7jWje0+uSmfm0=;
	b=YlX4+ShYTPvuR13KVuP1R+evcrXZ/tH4ig4fmZslrXtPgtkwBzwCoNhZZ2Ftzm75miUnJS
	doZoMsXjCMJ4lamesvvRkp6/0flB/fMywlZRJLvoyD1cPNwBjvk1DOgLmgs5MB/Aw4ecA0
	ubAwhTg0llCAp/FuiZaYi8LTsMmkzLE=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-678-IPvd61NnMtG-PnLbx20gug-1; Fri,
 06 Feb 2026 05:05:01 -0500
X-MC-Unique: IPvd61NnMtG-PnLbx20gug-1
X-Mimecast-MFC-AGG-ID: IPvd61NnMtG-PnLbx20gug_1770372299
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2697919560B0;
	Fri,  6 Feb 2026 10:04:59 +0000 (UTC)
Received: from ShadowPeak.redhat.com (unknown [10.44.34.231])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 5C75119560B9;
	Fri,  6 Feb 2026 10:04:55 +0000 (UTC)
From: Petr Oros <poros@redhat.com>
To: jacob.e.keller@intel.com
Cc: Petr Oros <poros@redhat.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	intel-wired-lan@lists.osuosl.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net] iavf: fix deadlock in reset handling
Date: Fri,  6 Feb 2026 11:04:26 +0100
Message-ID: <20260206100426.106082-1-poros@redhat.com>
In-Reply-To: <d60cc9fd-70af-40ea-9023-78bbbf91766f@intel.com>
References: <d60cc9fd-70af-40ea-9023-78bbbf91766f@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-257513-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[redhat.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[poros@redhat.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 18264FC717
X-Rspamd-Action: no action

description... 

Fixes: 120f28a6f314 ("iavf: get rid of the crit lock")
Signed-off-by: Petr Oros <poros@redhat.com>
---
 drivers/net/ethernet/intel/iavf/iavf.h        |  2 +-
 .../net/ethernet/intel/iavf/iavf_ethtool.c    | 21 +++---
 drivers/net/ethernet/intel/iavf/iavf_main.c   | 72 +++++++------------
 3 files changed, 33 insertions(+), 62 deletions(-)

diff --git a/drivers/net/ethernet/intel/iavf/iavf.h b/drivers/net/ethernet/intel/iavf/iavf.h
index d552f912e8a947..0c3844b3ff1c86 100644
--- a/drivers/net/ethernet/intel/iavf/iavf.h
+++ b/drivers/net/ethernet/intel/iavf/iavf.h
@@ -625,5 +625,5 @@ void iavf_add_adv_rss_cfg(struct iavf_adapter *adapter);
 void iavf_del_adv_rss_cfg(struct iavf_adapter *adapter);
 struct iavf_mac_filter *iavf_add_filter(struct iavf_adapter *adapter,
 					const u8 *macaddr);
-int iavf_wait_for_reset(struct iavf_adapter *adapter);
+void iavf_reset_step(struct iavf_adapter *adapter);
 #endif /* _IAVF_H_ */
diff --git a/drivers/net/ethernet/intel/iavf/iavf_ethtool.c b/drivers/net/ethernet/intel/iavf/iavf_ethtool.c
index 2cc21289a70779..9b0f47f9340942 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_ethtool.c
+++ b/drivers/net/ethernet/intel/iavf/iavf_ethtool.c
@@ -492,7 +492,6 @@ static int iavf_set_ringparam(struct net_device *netdev,
 {
 	struct iavf_adapter *adapter = netdev_priv(netdev);
 	u32 new_rx_count, new_tx_count;
-	int ret = 0;
 
 	if ((ring->rx_mini_pending) || (ring->rx_jumbo_pending))
 		return -EINVAL;
@@ -537,13 +536,11 @@ static int iavf_set_ringparam(struct net_device *netdev,
 	}
 
 	if (netif_running(netdev)) {
-		iavf_schedule_reset(adapter, IAVF_FLAG_RESET_NEEDED);
-		ret = iavf_wait_for_reset(adapter);
-		if (ret)
-			netdev_warn(netdev, "Changing ring parameters timeout or interrupted waiting for reset");
+		adapter->flags |= IAVF_FLAG_RESET_NEEDED;
+		iavf_reset_step(adapter);
 	}
 
-	return ret;
+	return 0;
 }
 
 /**
@@ -1723,7 +1720,6 @@ static int iavf_set_channels(struct net_device *netdev,
 {
 	struct iavf_adapter *adapter = netdev_priv(netdev);
 	u32 num_req = ch->combined_count;
-	int ret = 0;
 
 	if ((adapter->vf_res->vf_cap_flags & VIRTCHNL_VF_OFFLOAD_ADQ) &&
 	    adapter->num_tc) {
@@ -1745,13 +1741,12 @@ static int iavf_set_channels(struct net_device *netdev,
 
 	adapter->num_req_queues = num_req;
 	adapter->flags |= IAVF_FLAG_REINIT_ITR_NEEDED;
-	iavf_schedule_reset(adapter, IAVF_FLAG_RESET_NEEDED);
-
-	ret = iavf_wait_for_reset(adapter);
-	if (ret)
-		netdev_warn(netdev, "Changing channel count timeout or interrupted waiting for reset");
+	if (netif_running(netdev)) {
+		adapter->flags |= IAVF_FLAG_RESET_NEEDED;
+		iavf_reset_step(adapter);
+	}
 
-	return ret;
+	return 0;
 }
 
 /**
diff --git a/drivers/net/ethernet/intel/iavf/iavf_main.c b/drivers/net/ethernet/intel/iavf/iavf_main.c
index 8aa6e92c16431f..9c8d6125106f5a 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_main.c
+++ b/drivers/net/ethernet/intel/iavf/iavf_main.c
@@ -185,31 +185,6 @@ static bool iavf_is_reset_in_progress(struct iavf_adapter *adapter)
 	return false;
 }
 
-/**
- * iavf_wait_for_reset - Wait for reset to finish.
- * @adapter: board private structure
- *
- * Returns 0 if reset finished successfully, negative on timeout or interrupt.
- */
-int iavf_wait_for_reset(struct iavf_adapter *adapter)
-{
-	int ret = wait_event_interruptible_timeout(adapter->reset_waitqueue,
-					!iavf_is_reset_in_progress(adapter),
-					msecs_to_jiffies(5000));
-
-	/* If ret < 0 then it means wait was interrupted.
-	 * If ret == 0 then it means we got a timeout while waiting
-	 * for reset to finish.
-	 * If ret > 0 it means reset has finished.
-	 */
-	if (ret > 0)
-		return 0;
-	else if (ret < 0)
-		return -EINTR;
-	else
-		return -EBUSY;
-}
-
 /**
  * iavf_allocate_dma_mem_d - OS specific memory alloc for shared code
  * @hw:   pointer to the HW structure
@@ -3100,18 +3075,16 @@ static void iavf_reconfig_qs_bw(struct iavf_adapter *adapter)
 }
 
 /**
- * iavf_reset_task - Call-back task to handle hardware reset
- * @work: pointer to work_struct
+ * iavf_reset_step - Perform the VF reset sequence
+ * @adapter: board private structure
  *
- * During reset we need to shut down and reinitialize the admin queue
- * before we can use it to communicate with the PF again. We also clear
- * and reinit the rings because that context is lost as well.
- **/
-static void iavf_reset_task(struct work_struct *work)
+ * Requests a reset from PF, polls for completion, and reconfigures
+ * the driver. Caller must hold the netdev instance lock.
+ *
+ * This can sleep for several seconds while polling HW registers.
+ */
+void iavf_reset_step(struct iavf_adapter *adapter)
 {
-	struct iavf_adapter *adapter = container_of(work,
-						      struct iavf_adapter,
-						      reset_task);
 	struct virtchnl_vf_resource *vfres = adapter->vf_res;
 	struct net_device *netdev = adapter->netdev;
 	struct iavf_hw *hw = &adapter->hw;
@@ -3122,7 +3095,7 @@ static void iavf_reset_task(struct work_struct *work)
 	int i = 0, err;
 	bool running;
 
-	netdev_lock(netdev);
+	netdev_assert_locked(netdev);
 
 	iavf_misc_irq_disable(adapter);
 	if (adapter->flags & IAVF_FLAG_RESET_NEEDED) {
@@ -3167,7 +3140,6 @@ static void iavf_reset_task(struct work_struct *work)
 		dev_err(&adapter->pdev->dev, "Reset never finished (%x)\n",
 			reg_val);
 		iavf_disable_vf(adapter);
-		netdev_unlock(netdev);
 		return; /* Do not attempt to reinit. It's dead, Jim. */
 	}
 
@@ -3179,7 +3151,6 @@ static void iavf_reset_task(struct work_struct *work)
 		iavf_startup(adapter);
 		queue_delayed_work(adapter->wq, &adapter->watchdog_task,
 				   msecs_to_jiffies(30));
-		netdev_unlock(netdev);
 		return;
 	}
 
@@ -3321,7 +3292,6 @@ static void iavf_reset_task(struct work_struct *work)
 	adapter->flags &= ~IAVF_FLAG_REINIT_ITR_NEEDED;
 
 	wake_up(&adapter->reset_waitqueue);
-	netdev_unlock(netdev);
 
 	return;
 reset_err:
@@ -3331,10 +3301,21 @@ static void iavf_reset_task(struct work_struct *work)
 	}
 	iavf_disable_vf(adapter);
 
-	netdev_unlock(netdev);
 	dev_err(&adapter->pdev->dev, "failed to allocate resources during reinit\n");
 }
 
+static void iavf_reset_task(struct work_struct *work)
+{
+	struct iavf_adapter *adapter = container_of(work,
+						      struct iavf_adapter,
+						      reset_task);
+	struct net_device *netdev = adapter->netdev;
+
+	netdev_lock(netdev);
+	iavf_reset_step(adapter);
+	netdev_unlock(netdev);
+}
+
 /**
  * iavf_adminq_task - worker thread to clean the admin queue
  * @work: pointer to work_struct containing our data
@@ -4600,22 +4581,17 @@ static int iavf_close(struct net_device *netdev)
 static int iavf_change_mtu(struct net_device *netdev, int new_mtu)
 {
 	struct iavf_adapter *adapter = netdev_priv(netdev);
-	int ret = 0;
 
 	netdev_dbg(netdev, "changing MTU from %d to %d\n",
 		   netdev->mtu, new_mtu);
 	WRITE_ONCE(netdev->mtu, new_mtu);
 
 	if (netif_running(netdev)) {
-		iavf_schedule_reset(adapter, IAVF_FLAG_RESET_NEEDED);
-		ret = iavf_wait_for_reset(adapter);
-		if (ret < 0)
-			netdev_warn(netdev, "MTU change interrupted waiting for reset");
-		else if (ret)
-			netdev_warn(netdev, "MTU change timed out waiting for reset");
+		adapter->flags |= IAVF_FLAG_RESET_NEEDED;
+		iavf_reset_step(adapter);
 	}
 
-	return ret;
+	return 0;
 }
 
 /**
-- 
2.52.0


