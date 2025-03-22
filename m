Return-Path: <netdev+bounces-176882-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A14BA6CAB6
	for <lists+netdev@lfdr.de>; Sat, 22 Mar 2025 15:43:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 32E711B8055D
	for <lists+netdev@lfdr.de>; Sat, 22 Mar 2025 14:41:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95CBF22D4F4;
	Sat, 22 Mar 2025 14:39:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ya.ru header.i=@ya.ru header.b="jQ/j0nwH"
X-Original-To: netdev@vger.kernel.org
Received: from forward103d.mail.yandex.net (forward103d.mail.yandex.net [178.154.239.214])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C22B022B8BF;
	Sat, 22 Mar 2025 14:39:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.214
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742654393; cv=none; b=KuK2uE0enimD0tCJBiBeNJuMwixv2SxQPCeXFiInHvArMLi3rFUrpPVcELoFDwaNe8CjaTQf3W6yXqJ32RZxQpwESyuaKSrEmHwbNyJhxf508U88q/7cOeOqi0JAxBzIczrLjNtwI30ASw2N7HelThInx0a9X9eqIwN0SPzPs+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742654393; c=relaxed/simple;
	bh=kkbNleaf+8accSJ5/gJOEJaMgaILbTX/Z7YqA9gDHqI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Fd1dvJ12H9llE0/II2PLKWeyodG4sXIwpidgTNS8dhyXRd96EnjN4irnS6gEYqvF9p133/WbejjJc9zQFDpp28rF34rhVUjNPdKhzh+AgQuG7mzkeZmPm1e3zCWyBpNxTJrL2OoUJ0LHTU6oudUz3Puq48pl8oKswVladKI5z5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ya.ru; spf=pass smtp.mailfrom=ya.ru; dkim=pass (1024-bit key) header.d=ya.ru header.i=@ya.ru header.b=jQ/j0nwH; arc=none smtp.client-ip=178.154.239.214
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ya.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ya.ru
Received: from mail-nwsmtp-smtp-production-main-78.klg.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-78.klg.yp-c.yandex.net [IPv6:2a02:6b8:c42:c54a:0:640:3e90:0])
	by forward103d.mail.yandex.net (Yandex) with ESMTPS id 138A660B3C;
	Sat, 22 Mar 2025 17:39:50 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-78.klg.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id ldNdfxULga60-4C8ibM2K;
	Sat, 22 Mar 2025 17:39:49 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ya.ru; s=mail;
	t=1742654389; bh=7x+176iWrwPuMLakR6WCoQ5vYZD24jjJpjWnuC86ORc=;
	h=Cc:Message-ID:References:Date:In-Reply-To:Subject:To:From;
	b=jQ/j0nwHrz4dZ0xuYRzszu0dmV8s8yx0p/CmcJyJK+pxZPKInqBnwh/HHmE8Va/SW
	 ulvq2atd9NZAInwUeng10B2Nt+oMiyC8LgoGhR+P8crcgNjccGnpfH9CCNygCiLSp6
	 ScnnWyqJvTBJK/xOaXRscW57BuvvVabChVo4bmro=
Authentication-Results: mail-nwsmtp-smtp-production-main-78.klg.yp-c.yandex.net; dkim=pass header.i=@ya.ru
From: Kirill Tkhai <tkhai@ya.ru>
To: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: tkhai@ya.ru
Subject: [PATCH NET-PREV 15/51] iavf: Use __register_netdevice()
Date: Sat, 22 Mar 2025 17:39:47 +0300
Message-ID: <174265438746.356712.4413297068942699975.stgit@pro.pro>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <174265415457.356712.10472727127735290090.stgit@pro.pro>
References: <174265415457.356712.10472727127735290090.stgit@pro.pro>
User-Agent: StGit/0.19
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

Attach, detach and take nd_lock in appropriate way:

nd_lock should be outside driver's locks.

Signed-off-by: Kirill Tkhai <tkhai@ya.ru>
---
 drivers/net/ethernet/intel/iavf/iavf_main.c |   59 +++++++++++++++++++--------
 1 file changed, 41 insertions(+), 18 deletions(-)

diff --git a/drivers/net/ethernet/intel/iavf/iavf_main.c b/drivers/net/ethernet/intel/iavf/iavf_main.c
index f782402cd789..77fbe80c04a4 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_main.c
+++ b/drivers/net/ethernet/intel/iavf/iavf_main.c
@@ -1968,14 +1968,36 @@ static int iavf_reinit_interrupt_scheme(struct iavf_adapter *adapter, bool runni
 static void iavf_finish_config(struct work_struct *work)
 {
 	struct iavf_adapter *adapter;
-	int pairs, err;
+	struct nd_lock *nd_lock;
+	int pairs, err = 0;
 
 	adapter = container_of(work, struct iavf_adapter, finish_config);
 
 	/* Always take RTNL first to prevent circular lock dependency */
 	rtnl_lock();
+	lock_netdev(adapter->netdev, &nd_lock);
 	mutex_lock(&adapter->crit_lock);
 
+	if (adapter->netdev->reg_state != NETREG_REGISTERED &&
+	    adapter->state == __IAVF_DOWN) {
+		err = __register_netdevice(adapter->netdev);
+	}
+
+	unlock_netdev(nd_lock);
+
+	if (err) {
+		dev_err(&adapter->pdev->dev, "Unable to register netdev (%d)\n",
+			err);
+
+		/* go back and try again.*/
+		iavf_free_rss(adapter);
+		iavf_free_misc_irq(adapter);
+		iavf_reset_interrupt_capability(adapter);
+		iavf_change_state(adapter,
+				  __IAVF_INIT_CONFIG_ADAPTER);
+		goto out;
+	}
+
 	if ((adapter->flags & IAVF_FLAG_SETUP_NETDEV_FEATURES) &&
 	    adapter->netdev->reg_state == NETREG_REGISTERED &&
 	    !test_bit(__IAVF_IN_REMOVE_TASK, &adapter->crit_section)) {
@@ -1985,22 +2007,6 @@ static void iavf_finish_config(struct work_struct *work)
 
 	switch (adapter->state) {
 	case __IAVF_DOWN:
-		if (adapter->netdev->reg_state != NETREG_REGISTERED) {
-			err = register_netdevice(adapter->netdev);
-			if (err) {
-				dev_err(&adapter->pdev->dev, "Unable to register netdev (%d)\n",
-					err);
-
-				/* go back and try again.*/
-				iavf_free_rss(adapter);
-				iavf_free_misc_irq(adapter);
-				iavf_reset_interrupt_capability(adapter);
-				iavf_change_state(adapter,
-						  __IAVF_INIT_CONFIG_ADAPTER);
-				goto out;
-			}
-		}
-
 		/* Set the real number of queues when reset occurs while
 		 * state == __IAVF_DOWN
 		 */
@@ -5054,6 +5060,7 @@ static int iavf_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	struct net_device *netdev;
 	struct iavf_adapter *adapter = NULL;
 	struct iavf_hw *hw = NULL;
+	struct nd_lock *nd_lock;
 	int err;
 
 	err = pci_enable_device(pdev);
@@ -5085,6 +5092,12 @@ static int iavf_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 
 	SET_NETDEV_DEV(netdev, &pdev->dev);
 
+	nd_lock = attach_new_nd_lock(netdev);
+	if (!nd_lock) {
+		err = -ENOMEM;
+		goto err_alloc_lock;
+	}
+
 	pci_set_drvdata(pdev, netdev);
 	adapter = netdev_priv(netdev);
 
@@ -5163,6 +5176,10 @@ static int iavf_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 err_ioremap:
 	destroy_workqueue(adapter->wq);
 err_alloc_wq:
+	mutex_lock(&nd_lock->mutex);
+	detach_nd_lock(netdev);
+	mutex_unlock(&nd_lock->mutex);
+err_alloc_lock:
 	free_netdev(netdev);
 err_alloc_etherdev:
 	pci_release_regions(pdev);
@@ -5255,6 +5272,7 @@ static void iavf_remove(struct pci_dev *pdev)
 	struct iavf_mac_filter *f, *ftmp;
 	struct iavf_adapter *adapter;
 	struct net_device *netdev;
+	struct nd_lock *nd_lock;
 	struct iavf_hw *hw;
 
 	/* Don't proceed with remove if netdev is already freed */
@@ -5291,8 +5309,13 @@ static void iavf_remove(struct pci_dev *pdev)
 	cancel_delayed_work_sync(&adapter->watchdog_task);
 	cancel_work_sync(&adapter->finish_config);
 
-	if (netdev->reg_state == NETREG_REGISTERED)
+	if (netdev->reg_state == NETREG_REGISTERED) {
 		unregister_netdev(netdev);
+	} else {
+		lock_netdev(netdev, &nd_lock);
+		detach_nd_lock(netdev);
+		unlock_netdev(nd_lock);
+	}
 
 	mutex_lock(&adapter->crit_lock);
 	dev_info(&adapter->pdev->dev, "Removing device\n");


