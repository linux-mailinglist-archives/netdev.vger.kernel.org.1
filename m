Return-Path: <netdev+bounces-90270-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C0E638AD60A
	for <lists+netdev@lfdr.de>; Mon, 22 Apr 2024 22:45:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B18AE1C210EF
	for <lists+netdev@lfdr.de>; Mon, 22 Apr 2024 20:45:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86A6D1B947;
	Mon, 22 Apr 2024 20:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BarqAeu+"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE6DB2F5E
	for <netdev@vger.kernel.org>; Mon, 22 Apr 2024 20:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713818723; cv=none; b=EzY58UwWCdFihsfcWcUci/VmSS0/TOP8QMeJava4s3r21gOsndGn25REoQousoqoukP5AI1NOWxBc1asyiPyuYdAXS7lp3lJ7wix9UlCUibkytkQMW+Yqf6gtJtUMsallfdNRX+jeIY/BFy9/ldrpcfXBqmEKcv7Pq9bk1y5UdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713818723; c=relaxed/simple;
	bh=svVL/3ZUnMbGmr6u8L+abgEwIawxpZEhAyPmLaw7fcQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=BbizwDqs+MqOZmbzzhKU4hczNAaGbrfZLkTI2KLC74Hoq25DcYbP9+AQZuYfSjkxGYF3v7WTpp77oHG3OcIbaP5j7Vi0vs0NPyt4LlExbOfKU72Cbw+p5gOXVEk5llOpnag0ndH/DQpsryPIUviUbdNWOWV93Gstmvsjnq9Gi4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BarqAeu+; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713818722; x=1745354722;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=svVL/3ZUnMbGmr6u8L+abgEwIawxpZEhAyPmLaw7fcQ=;
  b=BarqAeu+jvDSmFK37d70plnNy2S+oaAG05SqvFdKs1IIx/2+uoXAWIUT
   gQMsXTqmt3YzOF+ZYyeDmS945yWXPidEeFOyTbVY06hFs290G3hGonBaC
   0YyyTysI3lmb+yhpx65OQ1yG8sVUpfUV8O+HN4fH8NLPW/O/22Wvv0kzy
   dj2K/dl8wWcirUMCkGt4hwxfZB3tsle3LX4+gpIcHWp8dPPUmyAq86lcs
   BOCvJCSOz7wvuAPt9h6gTlxTNqHPDv5s+tl9/0pTfK6w4XivGuRd4Qo6R
   KSXrBYc4YOoIKYJ6V06k5VpGkJjkYiHnj4HjAey/lVG4bZSauupAxE+0S
   w==;
X-CSE-ConnectionGUID: cDXkefOeRJuPrM8ZZVAsAw==
X-CSE-MsgGUID: lAaq2j4kQDe+8jUoSSRBkA==
X-IronPort-AV: E=McAfee;i="6600,9927,11052"; a="9919846"
X-IronPort-AV: E=Sophos;i="6.07,221,1708416000"; 
   d="scan'208";a="9919846"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2024 13:45:21 -0700
X-CSE-ConnectionGUID: V3d5mWorRxWjOi7ax9dIXQ==
X-CSE-MsgGUID: oa8IoIeUQ5q73gKjLN3FVA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,221,1708416000"; 
   d="scan'208";a="47414896"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa002.fm.intel.com with ESMTP; 22 Apr 2024 13:45:20 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	netdev@vger.kernel.org
Cc: Lukas Wunner <lukas@wunner.de>,
	anthony.l.nguyen@intel.com,
	sasha.neftin@intel.com,
	Roman Lozko <lozko.roma@gmail.com>,
	=?UTF-8?q?Marek=20Marczykowski-G=C3=B3recki?= <marmarek@invisiblethingslab.com>,
	Kurt Kanzenbach <kurt@linutronix.de>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Simon Horman <horms@kernel.org>,
	Naama Meir <naamax.meir@linux.intel.com>
Subject: [PATCH net] igc: Fix LED-related deadlock on driver unbind
Date: Mon, 22 Apr 2024 13:45:02 -0700
Message-ID: <20240422204503.225448-1-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Lukas Wunner <lukas@wunner.de>

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
Reported-by: "Marek Marczykowski-Górecki" <marmarek@invisiblethingslab.com>
Closes: https://lore.kernel.org/r/ZhRD3cOtz5i-61PB@mail-itl/
Signed-off-by: Kurt Kanzenbach <kurt@linutronix.de>
Signed-off-by: Lukas Wunner <lukas@wunner.de>
Cc: Heiner Kallweit <hkallweit1@gmail.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Reviewed-by: Kurt Kanzenbach <kurt@linutronix.de>
Tested-by: Kurt Kanzenbach <kurt@linutronix.de> # Intel i225
Tested-by: Naama Meir <naamax.meir@linux.intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/igc/igc.h      |  2 ++
 drivers/net/ethernet/intel/igc/igc_leds.c | 38 ++++++++++++++++++-----
 drivers/net/ethernet/intel/igc/igc_main.c |  3 ++
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
-- 
2.41.0


