Return-Path: <netdev+bounces-243915-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 35D44CAA970
	for <lists+netdev@lfdr.de>; Sat, 06 Dec 2025 16:52:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DE8C93082366
	for <lists+netdev@lfdr.de>; Sat,  6 Dec 2025 15:52:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A697A29B781;
	Sat,  6 Dec 2025 15:52:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="ZzvAZ0HK"
X-Original-To: netdev@vger.kernel.org
Received: from pdx-out-009.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-009.esa.us-west-2.outbound.mail-perimeter.amazon.com [35.155.198.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EE4E22D4D3
	for <netdev@vger.kernel.org>; Sat,  6 Dec 2025 15:52:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.155.198.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765036327; cv=none; b=pbJLoIz1S4VOblZ6Pts5J9xPjC7z118sQd5CInGDxeXszPYAAFTDYdtokyqtp6qKl77GaHKgZgIxgNNzNyJuW93Wa2/y7U80mbxG93sfM1gA/GKBHKKFlQ+r8GWOXGIxU1cxZ7zEFmGtO/3ciHE4t/PD7X9p7sVf29ehU3LAUxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765036327; c=relaxed/simple;
	bh=iMaIl29TXT7E0qJaroDQ0owRti1/C/zRjihab5F9FTc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=nrGPB2NGS6QDJEQ2rb7CMlbomWsGs/dqUHPnyad3KOdyhxRWj3uSGSAm2tSaDXMg1gQkYaj7xeoD+wAen7Ed3COKwxnudXbjl2Sq319/akEcDj6+Ln9HNC5bo6Y8LtYAH0cOYDyDDb8yiPELBp23/0EBWj1RBQzJXKLci+Yjsjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=ZzvAZ0HK; arc=none smtp.client-ip=35.155.198.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1765036326; x=1796572326;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=OqhJCLL3Pwz/+JDuot93iS7Im0pUDlagFH9IXq0WS5A=;
  b=ZzvAZ0HKTbpo93N691f7VqhMIXk8uMAF748Aa4pCdKgnQd/RIEMSwRRU
   jK92asP2IUaZ9/wLwxTkZZBcI3r41asUD1iyXKi7NCAn+Y3GsYn148STp
   4PUNqvbLRxuQZrt3MJDIs4aSdXyDIjwzcutjtPL3/N3nV6q5j4L8+yWs2
   79GQ1VxgwcV2ESDjq46h0BEbyc9ER1kQmOf/F2GW7lwEU+Zs/D9gFQm0y
   cMlAj6ctimy3jNbZawDHqotUKV1M4sm8bQffsJydGBfz9OB+vVVo6DjdK
   x76dyk+pIAzWAzhiMdAfoydzCLSv28sFkoCHViZOgu1bn3xt2sNhGILih
   w==;
X-CSE-ConnectionGUID: hrx9Wn57TyWis9ZAvPSEzQ==
X-CSE-MsgGUID: Hku5RtYaSh2xWEo4Pcj7hA==
X-IronPort-AV: E=Sophos;i="6.20,255,1758585600"; 
   d="scan'208";a="8458722"
Received: from ip-10-5-6-203.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.6.203])
  by internal-pdx-out-009.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Dec 2025 15:52:03 +0000
Received: from EX19MTAUWB002.ant.amazon.com [205.251.233.111:30654]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.42.136:2525] with esmtp (Farcaster)
 id 3bbfd3c3-423c-4d08-9481-cf73ea8af8cc; Sat, 6 Dec 2025 15:52:03 +0000 (UTC)
X-Farcaster-Flow-ID: 3bbfd3c3-423c-4d08-9481-cf73ea8af8cc
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.29;
 Sat, 6 Dec 2025 15:51:58 +0000
Received: from b0be8375a521.amazon.com (10.37.245.11) by
 EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.29;
 Sat, 6 Dec 2025 15:51:55 +0000
From: Kohei Enju <enjuk@amazon.com>
To: <intel-wired-lan@lists.osuosl.org>, <netdev@vger.kernel.org>
CC: Tony Nguyen <anthony.l.nguyen@intel.com>, Przemek Kitszel
	<przemyslaw.kitszel@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, "Jedrzej
 Jagielski" <jedrzej.jagielski@intel.com>, Mateusz Polchlopek
	<mateusz.polchlopek@intel.com>, Stefan Wegrzyn <stefan.wegrzyn@intel.com>,
	<kohei.enju@gmail.com>, Kohei Enju <enjuk@amazon.com>
Subject: [PATCH iwl-net v1] ixgbe: fix memory leaks in ixgbe_recovery_probe()
Date: Sun, 7 Dec 2025 00:51:27 +0900
Message-ID: <20251206155146.95857-1-enjuk@amazon.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D046UWA004.ant.amazon.com (10.13.139.76) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)

ixgbe_recovery_probe() does not free the following resources in its
error path, unlike ixgbe_probe():
- adapter->io_addr
- adapter->jump_tables[0]
- adapter->mac_table
- adapter->rss_key
- adapter->af_xdp_zc_qps

The leaked MMIO region can be observed in /proc/vmallocinfo, and the
remaining leaks are reported by kmemleak.

Free these allocations and unmap the MMIO region on failure to avoid the
leaks.

Fixes: 29cb3b8d95c7 ("ixgbe: add E610 implementation of FW recovery mode")
Signed-off-by: Kohei Enju <enjuk@amazon.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
index 4af3b3e71ff1..1bfec3fffae0 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
@@ -11508,6 +11508,11 @@ static int ixgbe_recovery_probe(struct ixgbe_adapter *adapter)
 	mutex_destroy(&adapter->hw.aci.lock);
 	ixgbe_release_hw_control(adapter);
 clean_up_probe:
+	iounmap(adapter->io_addr);
+	kfree(adapter->jump_tables[0]);
+	kfree(adapter->mac_table);
+	kfree(adapter->rss_key);
+	bitmap_free(adapter->af_xdp_zc_qps);
 	disable_dev = !test_and_set_bit(__IXGBE_DISABLED, &adapter->state);
 	free_netdev(netdev);
 	devlink_free(adapter->devlink);
-- 
2.52.0


