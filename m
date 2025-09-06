Return-Path: <netdev+bounces-220565-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 83983B4695A
	for <lists+netdev@lfdr.de>; Sat,  6 Sep 2025 07:53:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 64E3D1B27C3D
	for <lists+netdev@lfdr.de>; Sat,  6 Sep 2025 05:53:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5503327A455;
	Sat,  6 Sep 2025 05:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="qznqnojg"
X-Original-To: netdev@vger.kernel.org
Received: from pdx-out-015.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-015.esa.us-west-2.outbound.mail-perimeter.amazon.com [50.112.246.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60CD527B33B
	for <netdev@vger.kernel.org>; Sat,  6 Sep 2025 05:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=50.112.246.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757137977; cv=none; b=WDsK7/BJ9djpUdBykIhfS7o9Iz6R+qU9w/Ntklj68U/NIWqnRjqPs/5FnSL52KMEfuufkp2SXLV0Akg1pVPKE7tk6/TugGpt6Np6K1w8WuMkzxFEJ+1HiZ+rC1EOWVmKcKbQSBySe3GW12bHAPHETWrDoaQ3hkpNl6QB2X5qwio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757137977; c=relaxed/simple;
	bh=lLUA1qSoabAKNNYZMXT4CngoOBmpTg5GaPUtd2ta9YA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=S15G3/O/szQarVACqnPx27DJ7tJCCDt1zv/Qs3W2k8QNJWIDrh+t32SJdpxYxy0uIpI1SVixVnVx5MplRjsSnZRePy+ZL3tjL3k/JetgkYEv41VbiqhdJADf4qJO+rfnCWHmrzIo/4M6Pn4OPTIz93s2qnCK1cnEivxuvQJ2n9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=qznqnojg; arc=none smtp.client-ip=50.112.246.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1757137974; x=1788673974;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=TPc0WkfGfsp6qmcwRcgMulnl8xpARdCh9bvgudyMu7I=;
  b=qznqnojgOMhW3126OWzJELpOcQfltQPaGv7FPNigZm/ehu6Ett3kBKVJ
   L5ytOqdBAiZJkjixnq8+xZ1qZvaDAyfBCuQkYzquMbWwUQdAZ07y5rWdR
   hu1fnskjI4nP/FIDzekoYGdKi1lBgoUqYGmacULTov1YjiUgc8VltgKNW
   b9H/R2BFnVrOzDy3EWMlXrvc0QTcszdhnxqcYDum6sFrA4yTDHN5W76PE
   KzDCgSV2+my6Td0LYGmCJ0U78JnfsYLAmWNQNEw1vgaosqd8Oqu7aIb+s
   14FQA6sDvelfcXon4AWJUIv7zjcfOs1VHp46iRjamDD11hUE1GqVBqIDQ
   g==;
X-CSE-ConnectionGUID: 7CPTnwrqRhe41Z9IzYG/jA==
X-CSE-MsgGUID: sWKtFZUuRcCDpJqakPJj5A==
X-IronPort-AV: E=Sophos;i="6.18,243,1751241600"; 
   d="scan'208";a="2404541"
Received: from ip-10-5-0-115.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.0.115])
  by internal-pdx-out-015.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Sep 2025 05:52:52 +0000
Received: from EX19MTAUWB002.ant.amazon.com [10.0.21.151:54514]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.12.13:2525] with esmtp (Farcaster)
 id ca8fba9b-da9d-409b-984f-2323c7e6d4ed; Sat, 6 Sep 2025 05:52:51 +0000 (UTC)
X-Farcaster-Flow-ID: ca8fba9b-da9d-409b-984f-2323c7e6d4ed
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.20;
 Sat, 6 Sep 2025 05:52:50 +0000
Received: from b0be8375a521.amazon.com (10.37.244.7) by
 EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.20;
 Sat, 6 Sep 2025 05:52:48 +0000
From: Kohei Enju <enjuk@amazon.com>
To: <intel-wired-lan@lists.osuosl.org>, <netdev@vger.kernel.org>
CC: Tony Nguyen <anthony.l.nguyen@intel.com>, Przemek Kitszel
	<przemyslaw.kitszel@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Kurt Kanzenbach
	<kurt@linutronix.de>, <kohei.enju@gmail.com>, Kohei Enju <enjuk@amazon.com>
Subject: [PATCH v1 iwl-net] igc: unregister netdev when igc_led_setup() fails in igc_probe()
Date: Sat, 6 Sep 2025 14:51:30 +0900
Message-ID: <20250906055239.29396-1-enjuk@amazon.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D036UWB001.ant.amazon.com (10.13.139.133) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)

Currently igc_probe() doesn't unregister netdev when igc_led_setup()
fails, causing BUG_ON() in free_netdev() and then kernel panics. [1]

This behavior can be tested using fault-injection framework. I used the
failslab feature to test the issue. [2]

Call unregister_netdev() when igc_led_setup() fails to avoid the kernel
panic.

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
 drivers/net/ethernet/intel/igc/igc_main.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethernet/intel/igc/igc_main.c
index e79b14d50b24..95c415d0917d 100644
--- a/drivers/net/ethernet/intel/igc/igc_main.c
+++ b/drivers/net/ethernet/intel/igc/igc_main.c
@@ -7336,11 +7336,13 @@ static int igc_probe(struct pci_dev *pdev,
 	if (IS_ENABLED(CONFIG_IGC_LEDS)) {
 		err = igc_led_setup(adapter);
 		if (err)
-			goto err_register;
+			goto err_led_setup;
 	}
 
 	return 0;
 
+err_led_setup:
+	unregister_netdev(netdev);
 err_register:
 	igc_release_hw_control(adapter);
 	igc_ptp_stop(adapter);
-- 
2.48.1


