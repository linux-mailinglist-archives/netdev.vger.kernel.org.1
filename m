Return-Path: <netdev+bounces-87866-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BFD758A4D10
	for <lists+netdev@lfdr.de>; Mon, 15 Apr 2024 12:59:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 02452B21FC3
	for <lists+netdev@lfdr.de>; Mon, 15 Apr 2024 10:59:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A60C95C90F;
	Mon, 15 Apr 2024 10:59:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="vo7D5x2U";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="m9g8733R"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC3B35C902
	for <netdev@vger.kernel.org>; Mon, 15 Apr 2024 10:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713178782; cv=none; b=Zd/6q1jW3JCzjVvo+tPcNUY4t6aD8cS+w9TFjWZPTX2VGs+XVj/fxBvWjEdFXIL3HBHYF2Pln0oiKGlH/fM//DZ9GMmwEVa/8mYoU5LHeXReV8eGl5uwALHtLv47CrMoPqvQTlGOzoOORzQsg/E2/HSnptwEQW5egt22OlXwIrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713178782; c=relaxed/simple;
	bh=xLlRlKF9xsDzwY3KKGHNcn1ycgRbO63/bG8okkEB9G0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=QDSjK2KKbYwKDu1YiV+aNuBMI+qf56E4+Bu2n9C1Wo0q/g9WW0S6ZR36L4UdA8cHsYrTfXHCpczZQFAinePU53GnaMTawD56Lny6PFqEtWxJAlFwPnKNZG0P9mH/vlra6TEtYfV63d1mj+vQ9CY1d9+KHl9iLyHHx2gRt+oBkb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=vo7D5x2U; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=m9g8733R; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Kurt Kanzenbach <kurt@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1713178778;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=V5DuBOBDBCHQaWw9C6glh20ZIW+jv3LdeT0wtYITpAE=;
	b=vo7D5x2Uu0VZJO04+kTXha14NKNb3dYdeBV2WBn1bOSRVg08eUnaPVuBtjXKatlHx5Or44
	PN8bBngXOgKxuByfL3V+xwncvnBi4hyWrqDQZmuXJGKAT4RmE7Yyj6gQNFP2nM4+EUbALF
	wxyPQI2XAWb4hEV0C3H4g+MQYP/8RbqSZv02VyyRj3G+eVM38vhATrEtVk9RhoaOnIrP3I
	qDYLdC8uU7okl7/blJJMJLlEXmXRODSAgHA4S7916dea0rczEXfqklPZwetwHL06ExuaUE
	7uCy4/aGAFFz7TtAfSZ6qxY5UB9QXK+VGQ90TJFotaXM2oTzwfxjknHRKC5XMg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1713178778;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=V5DuBOBDBCHQaWw9C6glh20ZIW+jv3LdeT0wtYITpAE=;
	b=m9g8733RyBy0+jNdeYmM0t6OwWgO7YBLGwpefIt5WZeZncobsWnP2VWpgQudwtTmRBmTzW
	aIVS9HzmL5O8QcCA==
Date: Mon, 15 Apr 2024 12:59:37 +0200
Subject: [PATCH iwl-net v2] igc: Fix deadlock on module removal
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240411-igc_led_deadlock-v2-1-b758c0c88b2b@linutronix.de>
X-B4-Tracking: v=1; b=H4sIAJgIHWYC/3WOwQ6CMBAFf4Xs2RqKVMGT/2EIKe0CG2tr2ooYw
 r9buHucTF7mLRDQEwa4Zgt4nCiQswmKQwZqlHZARjoxFHlR5iXnjAbVGtStRqmNUw92kZ2uRC3
 KXiCkWScDss5Lq8Zt+JQhot/Ey2NP8966A30MsxihSWKkEJ3/7h8mvuv/uYkzznIt60qe1LlS4
 mbIvqN3luajRmjWdf0BFjxqYdYAAAA=
To: Jesse Brandeburg <jesse.brandeburg@intel.com>, 
 Tony Nguyen <anthony.l.nguyen@intel.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Andrew Lunn <andrew@lunn.ch>
Cc: Lukas Wunner <lukas@wunner.de>, Sasha Neftin <sasha.neftin@intel.com>, 
 Roman Lozko <lozko.roma@gmail.com>, 
 =?utf-8?q?Marek_Marczykowski-G=C3=B3recki?= <marmarek@invisiblethingslab.com>, 
 intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org, 
 Kurt Kanzenbach <kurt@linutronix.de>
X-Developer-Signature: v=1; a=openpgp-sha256; l=6093; i=kurt@linutronix.de;
 h=from:subject:message-id; bh=4aazeCbSQxcdcATZ72Dv/MmL+45/aglVGKPPdw6BXjo=;
 b=owEBbQKS/ZANAwAKAcGT0fKqRnOCAcsmYgBmHQiaGLPhBrgk7+BgZxj5jBLS9nzckBEFieus6
 ZmiwiLJn9qJAjMEAAEKAB0WIQS8ub+yyMN909/bWZLBk9HyqkZzggUCZh0ImgAKCRDBk9HyqkZz
 ghweD/9YPr/zkxq2hf2kcsiCQFbqzray3eRWybFEyhYpvLPSbIUgHNU6BWyjcgWR4I8DH0dMbJl
 spnYXkj2tNzuyzGg/NDbnqqHCyZU3+3+oWXn6nzxL7dQ+XdfDx/RuSqRT78rXLaYtt41Xn+2Pq0
 KpIrEmHyIrOI52MBE0CcbVlDGqFSApnQ2aJ7B6+C2lg3jUR9TTXcpz+mAvoVerr4ybA2lp4CRJ2
 l5dbt/qWx6IyM5kNDJViwEmU+Go8uu/Kz5MPC1iiXSPebM1CGfKFPBMpokmH2oKA/glLrOWXAKA
 mUVxez/YWb95aE7nC/5DHpLV/XitSKXczByiMcQFiI3b007PZw8j/sVLyIEAD7xKG4OvrsqdywT
 G4Ywshu9e6/clTOA+IMCde2LSyJe6B+IpKVerddM6jITJenNDXf8xhfgxU2yA/drqmbOV9caHok
 vtTPo+5/wJ3uGYFYZf02Q9jswpt7hHDsKU8DDAv+cTEMqsjnkMnL4hmELjwX6MguHfJKwa73Bcb
 IjpAgyxFYZa8fRvxyfwVpNbOUZohHBfXl487DiOtFcaxVZlJ3WTgmIFOJvIxLmm837DqhawOoNJ
 m/zxLSFDHRME9I9XbE2JC6pd6tkxyTPIaQeM/6zx9rD148rb8zWdhT36X1uPn23hQWcPhVszEkM
 xWQf0V5Dr5EnjQw==
X-Developer-Key: i=kurt@linutronix.de; a=openpgp;
 fpr=BCB9BFB2C8C37DD3DFDB5992C193D1F2AA467382

From: Lukas Wunner <lukas@wunner.de>

The removal of the igc module leads to a deadlock:

|[Mon Apr  8 17:38:55 2024]  __mutex_lock.constprop.0+0x3e5/0x7a0
|[Mon Apr  8 17:38:55 2024]  ? preempt_count_add+0x85/0xd0
|[Mon Apr  8 17:38:55 2024]  __mutex_lock_slowpath+0x13/0x20
|[Mon Apr  8 17:38:55 2024]  mutex_lock+0x3b/0x50
|[Mon Apr  8 17:38:55 2024]  rtnl_lock+0x19/0x20
|[Mon Apr  8 17:38:55 2024]  unregister_netdevice_notifier+0x2a/0xc0
|[Mon Apr  8 17:38:55 2024]  netdev_trig_deactivate+0x25/0x70
|[Mon Apr  8 17:38:55 2024]  led_trigger_set+0xe2/0x2d0
|[Mon Apr  8 17:38:55 2024]  led_classdev_unregister+0x4f/0x100
|[Mon Apr  8 17:38:55 2024]  devm_led_classdev_release+0x15/0x20
|[Mon Apr  8 17:38:55 2024]  release_nodes+0x47/0xc0
|[Mon Apr  8 17:38:55 2024]  devres_release_all+0x9f/0xe0
|[Mon Apr  8 17:38:55 2024]  device_del+0x272/0x3c0
|[Mon Apr  8 17:38:55 2024]  netdev_unregister_kobject+0x8c/0xa0
|[Mon Apr  8 17:38:55 2024]  unregister_netdevice_many_notify+0x530/0x7c0
|[Mon Apr  8 17:38:55 2024]  unregister_netdevice_queue+0xad/0xf0
|[Mon Apr  8 17:38:55 2024]  unregister_netdev+0x21/0x30
|[Mon Apr  8 17:38:55 2024]  igc_remove+0xfb/0x1f0 [igc]
|[Mon Apr  8 17:38:55 2024]  pci_device_remove+0x42/0xb0
|[Mon Apr  8 17:38:55 2024]  device_remove+0x43/0x70

unregister_netdev() acquires the RNTL lock and releases the LEDs bound
to that netdevice. However, netdev_trig_deactivate() and later
unregister_netdevice_notifier() try to acquire the RTNL lock again.

Avoid this situation by not using the device-managed LED class
functions.

Link: https://lore.kernel.org/r/CAEhC_B=ksywxCG_+aQqXUrGEgKq+4mqnSV8EBHOKbC3-Obj9+Q@mail.gmail.com/
Link: https://lore.kernel.org/r/ZhRD3cOtz5i-61PB@mail-itl/
Reported-by: Roman Lozko <lozko.roma@gmail.com>
Reported-by: "Marek Marczykowski-Górecki" <marmarek@invisiblethingslab.com>
Fixes: ea578703b03d ("igc: Add support for LEDs on i225/i226")
Signed-off-by: Lukas Wunner <lukas@wunner.de>
[Kurt: Wrote commit message and tested on i225]
Signed-off-by: Kurt Kanzenbach <kurt@linutronix.de>
---
Changes in v2:
- Add Lukas' SoB (Lukas)
- Add Reported-by (Lukas)
- Add links to discussions
- Take care of error path (Lukas)
- Remove forward declaration (Lukas)
- Link to v1: https://lore.kernel.org/r/20240411-igc_led_deadlock-v1-1-0da98a3c68c5@linutronix.de
---
 drivers/net/ethernet/intel/igc/igc.h      |  2 ++
 drivers/net/ethernet/intel/igc/igc_leds.c | 38 ++++++++++++++++++++++++-------
 drivers/net/ethernet/intel/igc/igc_main.c |  3 +++
 3 files changed, 35 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/intel/igc/igc.h b/drivers/net/ethernet/intel/igc/igc.h
index 90316dc58630..6bc56c7c181e 100644
--- a/drivers/net/ethernet/intel/igc/igc.h
+++ b/drivers/net/ethernet/intel/igc/igc.h
@@ -298,6 +298,7 @@ struct igc_adapter {
 
 	/* LEDs */
 	struct mutex led_mutex;
+	struct igc_led_classdev *leds;
 };
 
 void igc_up(struct igc_adapter *adapter);
@@ -723,6 +724,7 @@ void igc_ptp_read(struct igc_adapter *adapter, struct timespec64 *ts);
 void igc_ptp_tx_tstamp_event(struct igc_adapter *adapter);
 
 int igc_led_setup(struct igc_adapter *adapter);
+void igc_led_free(struct igc_adapter *adapter);
 
 #define igc_rx_pg_size(_ring) (PAGE_SIZE << igc_rx_pg_order(_ring))
 
diff --git a/drivers/net/ethernet/intel/igc/igc_leds.c b/drivers/net/ethernet/intel/igc/igc_leds.c
index bf240c5daf86..3929b25b6ae6 100644
--- a/drivers/net/ethernet/intel/igc/igc_leds.c
+++ b/drivers/net/ethernet/intel/igc/igc_leds.c
@@ -236,8 +236,8 @@ static void igc_led_get_name(struct igc_adapter *adapter, int index, char *buf,
 		 pci_dev_id(adapter->pdev), index);
 }
 
-static void igc_setup_ldev(struct igc_led_classdev *ldev,
-			   struct net_device *netdev, int index)
+static int igc_setup_ldev(struct igc_led_classdev *ldev,
+			  struct net_device *netdev, int index)
 {
 	struct igc_adapter *adapter = netdev_priv(netdev);
 	struct led_classdev *led_cdev = &ldev->led;
@@ -257,24 +257,46 @@ static void igc_setup_ldev(struct igc_led_classdev *ldev,
 	led_cdev->hw_control_get = igc_led_hw_control_get;
 	led_cdev->hw_control_get_device = igc_led_hw_control_get_device;
 
-	devm_led_classdev_register(&netdev->dev, led_cdev);
+	return led_classdev_register(&netdev->dev, led_cdev);
 }
 
 int igc_led_setup(struct igc_adapter *adapter)
 {
 	struct net_device *netdev = adapter->netdev;
-	struct device *dev = &netdev->dev;
 	struct igc_led_classdev *leds;
-	int i;
+	int i, err;
 
 	mutex_init(&adapter->led_mutex);
 
-	leds = devm_kcalloc(dev, IGC_NUM_LEDS, sizeof(*leds), GFP_KERNEL);
+	leds = kcalloc(IGC_NUM_LEDS, sizeof(*leds), GFP_KERNEL);
 	if (!leds)
 		return -ENOMEM;
 
-	for (i = 0; i < IGC_NUM_LEDS; i++)
-		igc_setup_ldev(leds + i, netdev, i);
+	for (i = 0; i < IGC_NUM_LEDS; i++) {
+		err = igc_setup_ldev(leds + i, netdev, i);
+		if (err)
+			goto err;
+	}
+
+	adapter->leds = leds;
 
 	return 0;
+
+err:
+	for (i--; i >= 0; i--)
+		led_classdev_unregister(&((leds + i)->led));
+
+	kfree(leds);
+	return err;
+}
+
+void igc_led_free(struct igc_adapter *adapter)
+{
+	struct igc_led_classdev *leds = adapter->leds;
+	int i;
+
+	for (i = 0; i < IGC_NUM_LEDS; i++)
+		led_classdev_unregister(&((leds + i)->led));
+
+	kfree(leds);
 }
diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethernet/intel/igc/igc_main.c
index 35ad40a803cb..4d975d620a8e 100644
--- a/drivers/net/ethernet/intel/igc/igc_main.c
+++ b/drivers/net/ethernet/intel/igc/igc_main.c
@@ -7021,6 +7021,9 @@ static void igc_remove(struct pci_dev *pdev)
 	cancel_work_sync(&adapter->watchdog_task);
 	hrtimer_cancel(&adapter->hrtimer);
 
+	if (IS_ENABLED(CONFIG_IGC_LEDS))
+		igc_led_free(adapter);
+
 	/* Release control of h/w to f/w.  If f/w is AMT enabled, this
 	 * would have already happened in close and is redundant.
 	 */

---
base-commit: 7efd0a74039fb6b584be2cb91c1d0ef0bd796ee1
change-id: 20240411-igc_led_deadlock-7abd85954f5e

Best regards,
-- 
Kurt Kanzenbach <kurt@linutronix.de>


