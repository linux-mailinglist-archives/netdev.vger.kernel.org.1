Return-Path: <netdev+bounces-87991-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D73B8A5223
	for <lists+netdev@lfdr.de>; Mon, 15 Apr 2024 15:49:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8EDA91C22129
	for <lists+netdev@lfdr.de>; Mon, 15 Apr 2024 13:49:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAA8371B44;
	Mon, 15 Apr 2024 13:48:58 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from bmailout2.hostsharing.net (bmailout2.hostsharing.net [83.223.78.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFF8871B3A
	for <netdev@vger.kernel.org>; Mon, 15 Apr 2024 13:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.78.240
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713188938; cv=none; b=good0OeQhd2SRkXSUTEnkMeKijsUIzttJcjYAYLtptZS26poJ+rHE8uhG17qY59PQ0lT3QlFhpLnMZyOYvUmN2Ieohynn4vkIGbgodvZ8xaNU+NtauLVQ9L+SfPoyEW6Hll5jZ9uCw8NVoKYX2ETpinpZShzTmLdRXVwlX85d/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713188938; c=relaxed/simple;
	bh=l5uZD7vmbA3xbQafpTW7t1P1/cDvjuVWwvr4KGLd8zA=;
	h=Message-Id:From:Date:Subject:To:Cc; b=HpedSxCfcApB3CAZc/az4AhQ5x33Vs2/iv2PMjWORjHrcHe4XvdF8yB5FY6mPuaQxvrf/YW1PIcODtG82T8rPKjzr9eRrKYiFrp2joHVhs7BueID8yu+TQzOppUZ1oOYQvtSGEB5CAuoaB3xn15mX1tYG9SYihsxOWDitffpowA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=pass smtp.mailfrom=wunner.de; arc=none smtp.client-ip=83.223.78.240
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wunner.de
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout2.hostsharing.net (Postfix) with ESMTPS id ED4DC2800C7F2;
	Mon, 15 Apr 2024 15:48:46 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id BFB0F17E52; Mon, 15 Apr 2024 15:48:46 +0200 (CEST)
Message-Id: <2f1be6b1cf2b3346929b0049f2ac7d7d79acb5c9.1713188539.git.lukas@wunner.de>
From: Lukas Wunner <lukas@wunner.de>
Date: Mon, 15 Apr 2024 15:48:48 +0200
Subject: [PATCH net] igc: Fix LED-related deadlock on driver unbind
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Jesse Brandeburg <jesse.brandeburg@intel.com>, Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org, Roman Lozko <lozko.roma@gmail.com>, Kurt Kanzenbach <kurt@linutronix.de>, Heiner Kallweit <hkallweit1@gmail.com>, Andrew Lunn <andrew@lunn.ch>, Sasha Neftin <sasha.neftin@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

Roman reports a deadlock on unplug of a Thunderbolt docking station
containing an Intel I225 Ethernet adapter.

The root cause is that led_classdev's for LEDs on the adapter are
registered such that they're device-managed by the netdev.  That
results in recursive acquisition of the rtnl_lock() mutex on unplug:

When the driver calls unregister_netdev(), it acquires rtnl_lock(),
then frees the device-managed resources.  Upon unregistering the LEDs,
netdev_trig_deactivate() invokes unregister_netdevice_notifier(),
which tries to acquire rtnl_lock() again.

Avoid by using non-device-managed LED registration.

Stack trace for posterity:

  schedule+0x6e/0xf0
  schedule_preempt_disabled+0x15/0x20
  __mutex_lock+0x2a0/0x750
  unregister_netdevice_notifier+0x40/0x150
  netdev_trig_deactivate+0x1f/0x60 [ledtrig_netdev]
  led_trigger_set+0x102/0x330
  led_classdev_unregister+0x4b/0x110
  release_nodes+0x3d/0xb0
  devres_release_all+0x8b/0xc0
  device_del+0x34f/0x3c0
  unregister_netdevice_many_notify+0x80b/0xaf0
  unregister_netdev+0x7c/0xd0
  igc_remove+0xd8/0x1e0 [igc]
  pci_device_remove+0x3f/0xb0

Fixes: ea578703b03d ("igc: Add support for LEDs on i225/i226")
Reported-by: Roman Lozko <lozko.roma@gmail.com>
Closes: https://lore.kernel.org/r/CAEhC_B=ksywxCG_+aQqXUrGEgKq+4mqnSV8EBHOKbC3-Obj9+Q@mail.gmail.com/
Signed-off-by: Kurt Kanzenbach <kurt@linutronix.de>
Signed-off-by: Lukas Wunner <lukas@wunner.de>
Cc: Heiner Kallweit <hkallweit1@gmail.com>
---
 drivers/net/ethernet/intel/igc/igc.h      |  2 ++
 drivers/net/ethernet/intel/igc/igc_leds.c | 38 ++++++++++++++++++++++++-------
 drivers/net/ethernet/intel/igc/igc_main.c |  3 +++
 3 files changed, 35 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/intel/igc/igc.h b/drivers/net/ethernet/intel/igc/igc.h
index 90316dc..6bc56c7 100644
--- a/drivers/net/ethernet/intel/igc/igc.h
+++ b/drivers/net/ethernet/intel/igc/igc.h
@@ -298,6 +298,7 @@ struct igc_adapter {
 
 	/* LEDs */
 	struct mutex led_mutex;
+	struct igc_led_classdev *leds;
 };
 
 void igc_up(struct igc_adapter *adapter);
@@ -723,6 +724,7 @@ struct igc_nfc_rule *igc_get_nfc_rule(struct igc_adapter *adapter,
 void igc_ptp_tx_tstamp_event(struct igc_adapter *adapter);
 
 int igc_led_setup(struct igc_adapter *adapter);
+void igc_led_free(struct igc_adapter *adapter);
 
 #define igc_rx_pg_size(_ring) (PAGE_SIZE << igc_rx_pg_order(_ring))
 
diff --git a/drivers/net/ethernet/intel/igc/igc_leds.c b/drivers/net/ethernet/intel/igc/igc_leds.c
index bf240c5..3929b25 100644
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
index 35ad40a..4d975d6 100644
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
-- 
2.43.0


