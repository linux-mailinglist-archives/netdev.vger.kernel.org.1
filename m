Return-Path: <netdev+bounces-218079-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B73CB3B066
	for <lists+netdev@lfdr.de>; Fri, 29 Aug 2025 03:23:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9ED1A1C83E7F
	for <lists+netdev@lfdr.de>; Fri, 29 Aug 2025 01:24:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FF3B21B9FD;
	Fri, 29 Aug 2025 01:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZVhqdDWg"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AA2720D51C
	for <netdev@vger.kernel.org>; Fri, 29 Aug 2025 01:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756430598; cv=none; b=KFYIIyP5khkjS82C3Yn+vQH8JG5wZ+dqU1FUBosw89kXakR2arrBLSxq0Q3k52k3Our1tHcSRWevJzxqxgnh44junIrA7Org3A8Y+dSSiVprwDTn+oA9ljBz9/06r++hSFQMd+El0wJRc98QWm2EIlttCdmeirBc8LwUIYhY+Hc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756430598; c=relaxed/simple;
	bh=AcrozsrXdvZYTPDjpApeLTUDWnwu8aEXqTx3wxbX4M8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=j5c9WEpdPrx01swucv7AycYVzhQih4pGX4NLZSW0hgcgJGwUS33MZ+/GOZSga4hEWPf3Zpzc/hs6wy51Z3HPamv/uVelFVL95tDgMvb/g3rpmPQAFJU0sWFHpyF/ELcQTw97JX1WDHYd6bi1S+WvlrpAOFR4R3Qv1Gta18rfL1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZVhqdDWg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2BD2C4CEF8;
	Fri, 29 Aug 2025 01:23:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756430595;
	bh=AcrozsrXdvZYTPDjpApeLTUDWnwu8aEXqTx3wxbX4M8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZVhqdDWggDKSG/HFrad79uB23xA7DF6bInH2LeimAn/rweFraQQm8sJMkmr3Fc7cM
	 mtjT2ATyTIOWbNXXGs+Sio3M7FSRPbvUuSdUNDcy34TSbLeodA1qpL3rNbHA1SXw+F
	 W/0G8CveYd44JVhGJiUJ742Myzz/AixZM99tvblKDm7l7QrQjpE1tkMnGLzKfttxBE
	 sjZZo2ucDQZKi8TJBaGiqIS1VI/NUko/1w+FXaU2sdIY4werCWT36tlADcf6NIaDgK
	 YYjUhEdX5MU3azj7aPTtbmKMiW2IFYcB2NkamTpEvYh8n8WQMGf2hCsg3pLk5mqM4O
	 z0C/jLlIIRaGQ==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	almasrymina@google.com,
	tariqt@nvidia.com,
	dtatulea@nvidia.com,
	hawk@kernel.org,
	ilias.apalodimas@linaro.org,
	alexanderduyck@fb.com,
	sdf@fomichev.me,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next v2 05/14] eth: fbnic: request ops lock
Date: Thu, 28 Aug 2025 18:22:55 -0700
Message-ID: <20250829012304.4146195-6-kuba@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250829012304.4146195-1-kuba@kernel.org>
References: <20250829012304.4146195-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We'll add queue ops soon so. queue ops will opt the driver into
extra locking. Request this locking explicitly already to make
future patches smaller and easier to review.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 drivers/net/ethernet/meta/fbnic/fbnic_netdev.c |  2 ++
 drivers/net/ethernet/meta/fbnic/fbnic_pci.c    |  9 ++++++++-
 drivers/net/ethernet/meta/fbnic/fbnic_txrx.c   | 15 ++++++++-------
 3 files changed, 18 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_netdev.c b/drivers/net/ethernet/meta/fbnic/fbnic_netdev.c
index 0cf1ea927cc0..1d9d175e8f8c 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_netdev.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_netdev.c
@@ -710,6 +710,8 @@ struct net_device *fbnic_netdev_alloc(struct fbnic_dev *fbd)
 
 	fbnic_set_ethtool_ops(netdev);
 
+	netdev->request_ops_lock = true;
+
 	fbn = netdev_priv(netdev);
 
 	fbn->netdev = netdev;
diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_pci.c b/drivers/net/ethernet/meta/fbnic/fbnic_pci.c
index b3c27c566f52..419a3335978f 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_pci.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_pci.c
@@ -208,8 +208,11 @@ static void fbnic_service_task(struct work_struct *work)
 
 	fbnic_bmc_rpc_check(fbd);
 
-	if (netif_carrier_ok(fbd->netdev))
+	if (netif_carrier_ok(fbd->netdev)) {
+		netdev_lock(fbd->netdev);
 		fbnic_napi_depletion_check(fbd->netdev);
+		netdev_unlock(fbd->netdev);
+	}
 
 	if (netif_running(fbd->netdev))
 		schedule_delayed_work(&fbd->service_task, HZ);
@@ -393,12 +396,14 @@ static int fbnic_pm_suspend(struct device *dev)
 		goto null_uc_addr;
 
 	rtnl_lock();
+	netdev_lock(netdev);
 
 	netif_device_detach(netdev);
 
 	if (netif_running(netdev))
 		netdev->netdev_ops->ndo_stop(netdev);
 
+	netdev_unlock(netdev);
 	rtnl_unlock();
 
 null_uc_addr:
@@ -464,6 +469,7 @@ static int __fbnic_pm_resume(struct device *dev)
 	fbnic_reset_queues(fbn, fbn->num_tx_queues, fbn->num_rx_queues);
 
 	rtnl_lock();
+	netdev_lock(netdev);
 
 	if (netif_running(netdev)) {
 		err = __fbnic_open(fbn);
@@ -471,6 +477,7 @@ static int __fbnic_pm_resume(struct device *dev)
 			goto err_free_mbx;
 	}
 
+	netdev_unlock(netdev);
 	rtnl_unlock();
 
 	return 0;
diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_txrx.c b/drivers/net/ethernet/meta/fbnic/fbnic_txrx.c
index 8dbe83bc2be1..dc0735b20739 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_txrx.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_txrx.c
@@ -1501,7 +1501,7 @@ static void fbnic_free_napi_vector(struct fbnic_net *fbn,
 	}
 
 	fbnic_napi_free_irq(fbd, nv);
-	netif_napi_del(&nv->napi);
+	netif_napi_del_locked(&nv->napi);
 	fbn->napi[fbnic_napi_idx(nv)] = NULL;
 	kfree(nv);
 }
@@ -1611,11 +1611,12 @@ static int fbnic_alloc_napi_vector(struct fbnic_dev *fbd, struct fbnic_net *fbn,
 
 	/* Tie napi to netdev */
 	fbn->napi[fbnic_napi_idx(nv)] = nv;
-	netif_napi_add(fbn->netdev, &nv->napi, fbnic_poll);
+	netif_napi_add_locked(fbn->netdev, &nv->napi, fbnic_poll);
 
 	/* Record IRQ to NAPI struct */
-	netif_napi_set_irq(&nv->napi,
-			   pci_irq_vector(to_pci_dev(fbd->dev), nv->v_idx));
+	netif_napi_set_irq_locked(&nv->napi,
+				  pci_irq_vector(to_pci_dev(fbd->dev),
+						 nv->v_idx));
 
 	/* Tie nv back to PCIe dev */
 	nv->dev = fbd->dev;
@@ -1704,7 +1705,7 @@ static int fbnic_alloc_napi_vector(struct fbnic_dev *fbd, struct fbnic_net *fbn,
 	return 0;
 
 napi_del:
-	netif_napi_del(&nv->napi);
+	netif_napi_del_locked(&nv->napi);
 	fbn->napi[fbnic_napi_idx(nv)] = NULL;
 	kfree(nv);
 	return err;
@@ -2173,7 +2174,7 @@ void fbnic_napi_disable(struct fbnic_net *fbn)
 	int i;
 
 	for (i = 0; i < fbn->num_napi; i++) {
-		napi_disable(&fbn->napi[i]->napi);
+		napi_disable_locked(&fbn->napi[i]->napi);
 
 		fbnic_nv_irq_disable(fbn->napi[i]);
 	}
@@ -2621,7 +2622,7 @@ void fbnic_napi_enable(struct fbnic_net *fbn)
 	for (i = 0; i < fbn->num_napi; i++) {
 		struct fbnic_napi_vector *nv = fbn->napi[i];
 
-		napi_enable(&nv->napi);
+		napi_enable_locked(&nv->napi);
 
 		fbnic_nv_irq_enable(nv);
 
-- 
2.51.0


