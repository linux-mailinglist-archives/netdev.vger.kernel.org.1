Return-Path: <netdev+bounces-215116-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D492B2D22D
	for <lists+netdev@lfdr.de>; Wed, 20 Aug 2025 05:00:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 33BBC3B628C
	for <lists+netdev@lfdr.de>; Wed, 20 Aug 2025 02:57:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8890F27A446;
	Wed, 20 Aug 2025 02:57:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="knE80wjs"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6348B2517B9
	for <netdev@vger.kernel.org>; Wed, 20 Aug 2025 02:57:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755658635; cv=none; b=hVb38BYTxqmRbWeJyc1RtjypBbsXDbWztjQwGZaPG41reAHgfe0UPJ2ZEES7CboTVYGi0w3qX+NG8jr8zQQO3EQEzE2zh3E15+lpWemPodHEOA9zle5q42KAEa8zNAvwtDM7n7Zm9tuAHTx4K0N5yVuSUBbNLvk5OngZ7RqY7Hg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755658635; c=relaxed/simple;
	bh=fDlxNXlDsJsIbmUoUH4ERo35yFQwAu2jun175K2lv4c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=d5gxDJH+IQxFrfymraRZuK19MDVC1CnH4T0QOySacXLemMrY7QxpSxi6O0K/U4qJDXREO3KRFpad8ZBgy9kK2VOmj8JXvvRUjbNmVJujOmO5Urpi3xX5s6C6SrGLkI1ybjQwnYM6XuGPp/tSGjcDDb5BngjzqXfd/0PsCWBEfVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=knE80wjs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FDE0C4CEF1;
	Wed, 20 Aug 2025 02:57:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755658635;
	bh=fDlxNXlDsJsIbmUoUH4ERo35yFQwAu2jun175K2lv4c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=knE80wjs1JIgs08ww+YaobTlgVqsjn4mcauKMoeyGhn1YFDjZFR6Io4qeTCBct9l9
	 pYIiQrZwV2e0gJSrMfG50Lz6zshx1C58pnxBfH7iWfDeddZhGNWo0leZl+n11atMWL
	 veYRT126EXGU+U37PdjWvQ0jDCllBpeKe1J7DbpkA0gmL/eRAcY2FI4x/PEQJmuPIC
	 XKThB1iuT+aB4ZR6tavhGoP+qx9WihkzuSz3oVUGsG6X18BGrtS1nCcg6W82PYb7EB
	 zxnVXvMQcG42j1aLkbEse0obDd+UPBnkRkrw7loERCo0nd9EANwiyCQB7bB9KbmgfA
	 4d0rx8+/zdVyQ==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	almasrymina@google.com,
	michael.chan@broadcom.com,
	tariqt@nvidia.com,
	dtatulea@nvidia.com,
	hawk@kernel.org,
	ilias.apalodimas@linaro.org,
	alexanderduyck@fb.com,
	sdf@fomichev.me,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next 06/15] eth: fbnic: request ops lock
Date: Tue, 19 Aug 2025 19:56:55 -0700
Message-ID: <20250820025704.166248-7-kuba@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250820025704.166248-1-kuba@kernel.org>
References: <20250820025704.166248-1-kuba@kernel.org>
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
index b8b684ad376b..37c900ce8257 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_netdev.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_netdev.c
@@ -750,6 +750,8 @@ struct net_device *fbnic_netdev_alloc(struct fbnic_dev *fbd)
 
 	fbnic_set_ethtool_ops(netdev);
 
+	netdev->request_ops_lock = true;
+
 	fbn = netdev_priv(netdev);
 
 	fbn->netdev = netdev;
diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_pci.c b/drivers/net/ethernet/meta/fbnic/fbnic_pci.c
index b70e4cadb37b..bc51e1e4846e 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_pci.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_pci.c
@@ -206,8 +206,11 @@ static void fbnic_service_task(struct work_struct *work)
 
 	fbnic_health_check(fbd);
 
-	if (netif_carrier_ok(fbd->netdev))
+	if (netif_carrier_ok(fbd->netdev)) {
+		netdev_lock(fbd->netdev);
 		fbnic_napi_depletion_check(fbd->netdev);
+		netdev_unlock(fbd->netdev);
+	}
 
 	if (netif_running(fbd->netdev))
 		schedule_delayed_work(&fbd->service_task, HZ);
@@ -392,12 +395,14 @@ static int fbnic_pm_suspend(struct device *dev)
 		goto null_uc_addr;
 
 	rtnl_lock();
+	netdev_lock(netdev);
 
 	netif_device_detach(netdev);
 
 	if (netif_running(netdev))
 		netdev->netdev_ops->ndo_stop(netdev);
 
+	netdev_unlock(netdev);
 	rtnl_unlock();
 
 null_uc_addr:
@@ -463,6 +468,7 @@ static int __fbnic_pm_resume(struct device *dev)
 	fbnic_reset_queues(fbn, fbn->num_tx_queues, fbn->num_rx_queues);
 
 	rtnl_lock();
+	netdev_lock(netdev);
 
 	if (netif_running(netdev)) {
 		err = __fbnic_open(fbn);
@@ -470,6 +476,7 @@ static int __fbnic_pm_resume(struct device *dev)
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
2.50.1


