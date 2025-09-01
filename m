Return-Path: <netdev+bounces-218918-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 369EAB3F05B
	for <lists+netdev@lfdr.de>; Mon,  1 Sep 2025 23:12:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 130912C0922
	for <lists+netdev@lfdr.de>; Mon,  1 Sep 2025 21:12:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3E9627702A;
	Mon,  1 Sep 2025 21:12:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hoF6Y0LH"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9007927701E
	for <netdev@vger.kernel.org>; Mon,  1 Sep 2025 21:12:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756761141; cv=none; b=noN5QzORp7d291IbGM6zOFN5S3s0IZwyztqoQUOVS+32gPoYettpSucXtYNb9cONVM2xg/ZSTy9iNNnFLcXZDwXW1eT3Loy2NQaPOgcqehyaLCZ1wQJf3AqsndC9BAZsfAqpsR0qE2cpMRBfeNc5MQA14bxOZ4ZH9seIlBms2R0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756761141; c=relaxed/simple;
	bh=T/e0hXP4Fl0rYJxkXFYXyuYWHVVhOQLQYkJW8Qvba6o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=naCG7WRBwszCPbTa2lbIG+xHDscVNC9iwEcRL+JWI1bNsyN72GW1q029IKwprQobzgnGzx3fYe/crjSKb91dxIbno3t1xLwb2ipLxUyeKyt9pO8leOMZ5Di71BbcO6LoJAaToTlEKPNjIU+jODdY1VO9jqjdJegAtlzwCMFG2G4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hoF6Y0LH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CD08C4CEF0;
	Mon,  1 Sep 2025 21:12:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756761141;
	bh=T/e0hXP4Fl0rYJxkXFYXyuYWHVVhOQLQYkJW8Qvba6o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hoF6Y0LHq0ZE2WDXwGegKn1ExbxUY8EdfB9awLOuFSrQA6K7oSk3xKK55hk7xua7r
	 xFj7DnJqtVIzVO+hFpi2EVn/YSMd6d147GNubVBUP1+ug0maB/kC91NVZaC5b8V7A1
	 Sm/EElTBLTnu0mtClXlR5ullhYSMOyK2UToIfXiX9IpW1A7S2vQJtxpNW1GKpdxAQN
	 yls6fDl7FSCzc+iJ0t2MNqVNTAyUhCIFJZvow9Ost4upsNjgv/sDMfJrrrGMR2BWvB
	 bpFrqFecYQMOFcYoWBaY/9RBMYc5fABB0XF/wzsbTl5hHrH0NlGLVlNbjlZXqj97im
	 2AxHjmXKPmVUg==
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
Subject: [PATCH net-next v3 05/14] eth: fbnic: request ops lock
Date: Mon,  1 Sep 2025 14:12:05 -0700
Message-ID: <20250901211214.1027927-6-kuba@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250901211214.1027927-1-kuba@kernel.org>
References: <20250901211214.1027927-1-kuba@kernel.org>
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
index 6dac42ca28c6..71f9fae99168 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_netdev.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_netdev.c
@@ -714,6 +714,8 @@ struct net_device *fbnic_netdev_alloc(struct fbnic_dev *fbd)
 
 	fbnic_set_ethtool_ops(netdev);
 
+	netdev->request_ops_lock = true;
+
 	fbn = netdev_priv(netdev);
 
 	fbn->netdev = netdev;
diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_pci.c b/drivers/net/ethernet/meta/fbnic/fbnic_pci.c
index a4db97652fb4..9fdc8f4f36cc 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_pci.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_pci.c
@@ -206,8 +206,11 @@ static void fbnic_service_task(struct work_struct *work)
 
 	fbnic_bmc_rpc_check(fbd);
 
-	if (netif_carrier_ok(fbd->netdev))
+	if (netif_carrier_ok(fbd->netdev)) {
+		netdev_lock(fbd->netdev);
 		fbnic_napi_depletion_check(fbd->netdev);
+		netdev_unlock(fbd->netdev);
+	}
 
 	if (netif_running(fbd->netdev))
 		schedule_delayed_work(&fbd->service_task, HZ);
@@ -391,12 +394,14 @@ static int fbnic_pm_suspend(struct device *dev)
 		goto null_uc_addr;
 
 	rtnl_lock();
+	netdev_lock(netdev);
 
 	netif_device_detach(netdev);
 
 	if (netif_running(netdev))
 		netdev->netdev_ops->ndo_stop(netdev);
 
+	netdev_unlock(netdev);
 	rtnl_unlock();
 
 null_uc_addr:
@@ -461,10 +466,12 @@ static int __fbnic_pm_resume(struct device *dev)
 	fbnic_reset_queues(fbn, fbn->num_tx_queues, fbn->num_rx_queues);
 
 	rtnl_lock();
+	netdev_lock(netdev);
 
 	if (netif_running(netdev))
 		err = __fbnic_open(fbn);
 
+	netdev_unlock(netdev);
 	rtnl_unlock();
 	if (err)
 		goto err_free_mbx;
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


