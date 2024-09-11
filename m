Return-Path: <netdev+bounces-127533-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CA50975AE1
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 21:36:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9F56A1C223E6
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 19:36:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73CB41BA275;
	Wed, 11 Sep 2024 19:36:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CQRD3JR/"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E35D1B9B3E;
	Wed, 11 Sep 2024 19:36:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726083397; cv=none; b=GSNNtop0Al/EqPJ1qKg+J/hn/h6tPXZqiqezu++7e6rwRKN6j+EYaQ7twqkTdVG3rPUJOcal4a56zFJS5SHFjU8crAGzQOBvvV0PG5sZXLWA1nMTUwZsqUsC210IBexSSiP5n0CST6cVpgaHkBSWYqISsQG9kRl6XSiWz5NHVKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726083397; c=relaxed/simple;
	bh=0rTXAnkbeVMZLqqOWPrpVcS7QLv6ho2JIs7Kpx74QEo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pKeifXnC5SKw2vmX2IZuneq1kvMlg/KOmyfB/2pKFQqvnNuzrh96SOhtPcmI97DLmmWZkappzdHfiZ9peCHRtsFsbd4+qYa3+Wg02KZFxJiACF2yAzTfcyEJAx9gXsXEDeIM4HUpvdddDrCZiXvnSGYsE0lUKJjl/jtCzZ4N0Zk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CQRD3JR/; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726083396; x=1757619396;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=0rTXAnkbeVMZLqqOWPrpVcS7QLv6ho2JIs7Kpx74QEo=;
  b=CQRD3JR/6pAJ9jvI+JqJ214IBNsaD5pXQvXmhZG2ht7p+GfViGXAAMzW
   BiKNxictq1QBvV+5EzHArLNUq7qJEoPC+tdG2OnMlzEt6pO0ZGZ6sQGZf
   kKFkLcV4+XXJ+yUc/G8APYzfF1Rj/I+rDBWa0svYSacTODtl4HLeU2AVv
   tZzkeVRGYcvYyRaaNUxnI39PeRiDY30y1Pgi1fILOaszASpTSjW/cauBf
   R4mtgk+q2BOc7vMvyOInH8/FmXstFdB9TXjFweLbNJ9MGCp7IScR1vx+J
   yoGkfWVra/X/Q5hqlZWJwkV/f7XBqL3j1YslKTjtO1sEB7yt+ufBvxzcV
   Q==;
X-CSE-ConnectionGUID: qQUOOMC6SaGSoNz4AzMxiA==
X-CSE-MsgGUID: fHGrsoWiSe25Oev0bTTi6w==
X-IronPort-AV: E=McAfee;i="6700,10204,11192"; a="28792088"
X-IronPort-AV: E=Sophos;i="6.10,220,1719903600"; 
   d="scan'208";a="28792088"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2024 12:36:34 -0700
X-CSE-ConnectionGUID: HsO557M6SXmQrxiSzEE9mw==
X-CSE-MsgGUID: IRXwOdXRR5SFcSMATx0+Rg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,220,1719903600"; 
   d="scan'208";a="67307582"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa010.jf.intel.com with ESMTP; 11 Sep 2024 12:36:32 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 0DA20170; Wed, 11 Sep 2024 22:36:30 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH net-next v1 1/1] net: ks8851: use %*ph to print small buffer
Date: Wed, 11 Sep 2024 22:36:30 +0300
Message-ID: <20240911193630.2884828-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1336.g36b5255a03ac
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use %*ph format to print small buffer as hex string.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/net/ethernet/micrel/ks8851_common.c | 19 +------------------
 1 file changed, 1 insertion(+), 18 deletions(-)

diff --git a/drivers/net/ethernet/micrel/ks8851_common.c b/drivers/net/ethernet/micrel/ks8851_common.c
index 7fa1820db9cc..a07ffc53da64 100644
--- a/drivers/net/ethernet/micrel/ks8851_common.c
+++ b/drivers/net/ethernet/micrel/ks8851_common.c
@@ -215,22 +215,6 @@ static void ks8851_init_mac(struct ks8851_net *ks, struct device_node *np)
 	ks8851_write_mac_addr(dev);
 }
 
-/**
- * ks8851_dbg_dumpkkt - dump initial packet contents to debug
- * @ks: The device state
- * @rxpkt: The data for the received packet
- *
- * Dump the initial data from the packet to dev_dbg().
- */
-static void ks8851_dbg_dumpkkt(struct ks8851_net *ks, u8 *rxpkt)
-{
-	netdev_dbg(ks->netdev,
-		   "pkt %02x%02x%02x%02x %02x%02x%02x%02x %02x%02x%02x%02x\n",
-		   rxpkt[4], rxpkt[5], rxpkt[6], rxpkt[7],
-		   rxpkt[8], rxpkt[9], rxpkt[10], rxpkt[11],
-		   rxpkt[12], rxpkt[13], rxpkt[14], rxpkt[15]);
-}
-
 /**
  * ks8851_rx_pkts - receive packets from the host
  * @ks: The device information.
@@ -296,8 +280,7 @@ static void ks8851_rx_pkts(struct ks8851_net *ks, struct sk_buff_head *rxq)
 
 				ks->rdfifo(ks, rxpkt, rxalign + 8);
 
-				if (netif_msg_pktdata(ks))
-					ks8851_dbg_dumpkkt(ks, rxpkt);
+				netif_dbg(ks, pktdata, ks->netdev, "pkt %12ph\n", &rxpkt[4]);
 
 				skb->protocol = eth_type_trans(skb, ks->netdev);
 				__skb_queue_tail(rxq, skb);
-- 
2.43.0.rc1.1336.g36b5255a03ac


