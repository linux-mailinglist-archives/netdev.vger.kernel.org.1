Return-Path: <netdev+bounces-221672-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4804CB51843
	for <lists+netdev@lfdr.de>; Wed, 10 Sep 2025 15:48:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F421A4850E5
	for <lists+netdev@lfdr.de>; Wed, 10 Sep 2025 13:48:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3F521FE471;
	Wed, 10 Sep 2025 13:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="a3KFutJ2"
X-Original-To: netdev@vger.kernel.org
Received: from pdx-out-010.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-010.esa.us-west-2.outbound.mail-perimeter.amazon.com [52.12.53.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4389F1F4C8E
	for <netdev@vger.kernel.org>; Wed, 10 Sep 2025 13:48:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.12.53.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757512083; cv=none; b=HlNXe7/QdMA7lSbtH3NHykrFcHu+Rjva/kYR6wVBwFXPYYdAINmC1ts9o5yRJYaesyLrUPFq3/zuoLn1DZAooSDgiawhHgMRmTDjt6oeq5dvnDQ6CFliZhM/ST4n+WIsjQdja5F5pq9ixxRhkmN5QONwig1fyFbBUmYu7OTrg2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757512083; c=relaxed/simple;
	bh=nr8M8a6g5CaFAzQQ+lJBCqlHyJLDpC8uDsB/HZin1Sc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Jv2YYMwnBng+xHUdfOTYB8bHejwsIDQLyUY4nwAHg7nkeHb8Re0GoyHTSgao4l7NFUPFho1Ad/1YipAcDGxuvH4jAo368315Z5uP9pQN0v8c4hMj3e4ZHT+DYl8XhAr8tL86N1mLc+gaHPis91Hsid/fSVNdvY/5qXJtxuZtS7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=a3KFutJ2; arc=none smtp.client-ip=52.12.53.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1757512082; x=1789048082;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=b1cDcSCHKidkZ5wZeJxogM3bIZ9krxn7Su27EUt2U3I=;
  b=a3KFutJ294ef0P7F+rmXsZVZXNt8mVju1S9sG2xw/RjiGNzoC7Ng6bji
   5cUwE+Y2NV1WJlZYx8LAh+6B9JRIcQxqWwWdRmuXU0QCk9vR1Rp9UABDq
   lN18To2N/hQVKAarpMh350T/l0fYrGcKHjZs/q0zZ2IlLGczt+R7XBW6a
   ApP9+V51e+sgr4De55hZbjVi7vnY/RBoDModaZFmo99PDqPlX1MDT6/fh
   GVkoSf/khtv7qe67KkqJ96dxH0QMyMRQXOlfd4gKfwd3CuBtCkHp9cSB9
   d4O5bkgFBXjl22OtL+WYYsqkLOjnJ0o7ez2zMC2tthii6PYCcJQ1AQgbm
   w==;
X-CSE-ConnectionGUID: htCyvmWPTNKmDziyvaaSvQ==
X-CSE-MsgGUID: KWLFG62NQ7C3codHrOF9Ew==
X-IronPort-AV: E=Sophos;i="6.18,254,1751241600"; 
   d="scan'208";a="2647375"
Received: from ip-10-5-9-48.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.9.48])
  by internal-pdx-out-010.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Sep 2025 13:48:00 +0000
Received: from EX19MTAUWC001.ant.amazon.com [10.0.38.20:54588]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.34.38:2525] with esmtp (Farcaster)
 id 17dd31af-939e-40d6-a056-1a053d6ea001; Wed, 10 Sep 2025 13:47:59 +0000 (UTC)
X-Farcaster-Flow-ID: 17dd31af-939e-40d6-a056-1a053d6ea001
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.20;
 Wed, 10 Sep 2025 13:47:59 +0000
Received: from b0be8375a521.amazon.com (10.37.244.8) by
 EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.20;
 Wed, 10 Sep 2025 13:47:57 +0000
From: Kohei Enju <enjuk@amazon.com>
To: <intel-wired-lan@lists.osuosl.org>, <netdev@vger.kernel.org>
CC: Tony Nguyen <anthony.l.nguyen@intel.com>, Przemek Kitszel
	<przemyslaw.kitszel@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Kurt Kanzenbach
	<kurt@linutronix.de>, Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Vitaly Lifshits <vitaly.lifshits@intel.com>, <kohei.enju@gmail.com>, "Kohei
 Enju" <enjuk@amazon.com>
Subject: [PATCH v2 iwl-net] igc: don't fail igc_probe() on LED setup error
Date: Wed, 10 Sep 2025 22:47:21 +0900
Message-ID: <20250910134745.17124-1-enjuk@amazon.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D033UWA002.ant.amazon.com (10.13.139.10) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)

When igc_led_setup() fails, igc_probe() fails and triggers kernel panic
in free_netdev() since unregister_netdev() is not called. [1]
This behavior can be tested using fault-injection framework, especially
the failslab feature. [2]

Since LED support is not mandatory, treat LED setup failures as
non-fatal and continue probe with a warning message, consequently
avoiding the kernel panic.

[1]
 kernel BUG at net/core/dev.c:12047!
 Oops: invalid opcode: 0000 [#1] SMP NOPTI
 CPU: 0 UID: 0 PID: 937 Comm: repro-igc-led-e Not tainted 6.17.0-rc4-enjuk-tnguy-00865-gc4940196ab02 #64 PREEMPT(voluntary)
 Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
 RIP: 0010:free_netdev+0x278/0x2b0
 [...]
 Call Trace:
  <TASK>
  igc_probe+0x370/0x910
  local_pci_probe+0x3a/0x80
  pci_device_probe+0xd1/0x200
 [...]

[2]
 #!/bin/bash -ex

 FAILSLAB_PATH=/sys/kernel/debug/failslab/
 DEVICE=0000:00:05.0
 START_ADDR=$(grep " igc_led_setup" /proc/kallsyms \
         | awk '{printf("0x%s", $1)}')
 END_ADDR=$(printf "0x%x" $((START_ADDR + 0x100)))

 echo $START_ADDR > $FAILSLAB_PATH/require-start
 echo $END_ADDR > $FAILSLAB_PATH/require-end
 echo 1 > $FAILSLAB_PATH/times
 echo 100 > $FAILSLAB_PATH/probability
 echo N > $FAILSLAB_PATH/ignore-gfp-wait

 echo $DEVICE > /sys/bus/pci/drivers/igc/bind

Fixes: ea578703b03d ("igc: Add support for LEDs on i225/i226")
Signed-off-by: Kohei Enju <enjuk@amazon.com>
---
Changes:
  v1->v2:
    - don't fail probe when led setup fails
    - rephrase subject and commit message
  v1: https://lore.kernel.org/intel-wired-lan/20250906055239.29396-1-enjuk@amazon.com/
---
 drivers/net/ethernet/intel/igc/igc.h      |  1 +
 drivers/net/ethernet/intel/igc/igc_main.c | 12 +++++++++---
 2 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/igc/igc.h b/drivers/net/ethernet/intel/igc/igc.h
index 266bfcf2a28f..a427f05814c1 100644
--- a/drivers/net/ethernet/intel/igc/igc.h
+++ b/drivers/net/ethernet/intel/igc/igc.h
@@ -345,6 +345,7 @@ struct igc_adapter {
 	/* LEDs */
 	struct mutex led_mutex;
 	struct igc_led_classdev *leds;
+	bool leds_available;
 };
 
 void igc_up(struct igc_adapter *adapter);
diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethernet/intel/igc/igc_main.c
index e79b14d50b24..728d7ca5338b 100644
--- a/drivers/net/ethernet/intel/igc/igc_main.c
+++ b/drivers/net/ethernet/intel/igc/igc_main.c
@@ -7335,8 +7335,14 @@ static int igc_probe(struct pci_dev *pdev,
 
 	if (IS_ENABLED(CONFIG_IGC_LEDS)) {
 		err = igc_led_setup(adapter);
-		if (err)
-			goto err_register;
+		if (err) {
+			netdev_warn_once(netdev,
+					 "LED init failed (%d); continuing without LED support\n",
+					 err);
+			adapter->leds_available = false;
+		} else {
+			adapter->leds_available = true;
+		}
 	}
 
 	return 0;
@@ -7392,7 +7398,7 @@ static void igc_remove(struct pci_dev *pdev)
 	cancel_work_sync(&adapter->watchdog_task);
 	hrtimer_cancel(&adapter->hrtimer);
 
-	if (IS_ENABLED(CONFIG_IGC_LEDS))
+	if (IS_ENABLED(CONFIG_IGC_LEDS) && adapter->leds_available)
 		igc_led_free(adapter);
 
 	/* Release control of h/w to f/w.  If f/w is AMT enabled, this
-- 
2.48.1


