Return-Path: <netdev+bounces-232898-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C5BEC09D3A
	for <lists+netdev@lfdr.de>; Sat, 25 Oct 2025 19:04:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 12D4D3A9A67
	for <lists+netdev@lfdr.de>; Sat, 25 Oct 2025 16:59:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 746BF23B627;
	Sat, 25 Oct 2025 16:59:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="VrWA+C23"
X-Original-To: netdev@vger.kernel.org
Received: from pdx-out-014.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-014.esa.us-west-2.outbound.mail-perimeter.amazon.com [35.83.148.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B730F23C50F
	for <netdev@vger.kernel.org>; Sat, 25 Oct 2025 16:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.83.148.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761411557; cv=none; b=klvM6IqN0aNC9bfCsCkSkve5G+gutF2Qt6Phx2jth/3maTgIt+EKsoJ3vqbdF8jGz05vNnoaE+PJBneX2nhOLpDVBViUR3Yt41s2wYSKaAwSDps4uVkS4tFHewEAr7rHXtRvhsPFY27p10EA7NPRcAAO7pKUydK317LRXqeCg0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761411557; c=relaxed/simple;
	bh=dz0OCeQv844eZ+dY+1WJksnfchoCo0UBU5zbH9Cu8P0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=aOlXz6O+INq0TomKWujb44WGYhs5XKLesMHPcF/tQs1P0PMJOpmk/RZvz73NTCSKU6Btt0S/D/qL0ayVTIEf6ZqjNxUtWytwBAsb3fnkONyzhdrEzT64CsjaBIrcH0V2/zaeXHaC67/OYhM7Auu0wl6ET/15YkOVOFLbL9SL9lE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=VrWA+C23; arc=none smtp.client-ip=35.83.148.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1761411555; x=1792947555;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=V5UsvXKw8wVOUzGMnnRnvmj8EMKArLdi449MgunOyZ4=;
  b=VrWA+C23VbRkbK1T9aS2hLYVVSm3BTsfybNrWjWbgIxC32lq79Mb7E30
   BTss2MTAtiluDr6osJKWFkwF3dZikigNc7ypbowNfCD5S6ZsmoXRZCzij
   HozwZQ38TvFZwVUBFzLDBwRFFQcn2F7aKqvC4f2bNgEi8HySGIaNI2vhU
   bezl7ZVBcOmF9HS4YfIH2AytW5c0xO5HZ3FznIoCTwgz7OFkckaXJJrnt
   mz1plMUlFkDXtuOkoNwHZ9FUcczQyhQGMZhIQ1cvIM4ttcUSlJ3917FS/
   s7pri/kis73n1BkByHIrvpryJI9/lVsrcA0ygY7TkjPvI0eTjW6GZ6mH4
   g==;
X-CSE-ConnectionGUID: eZFInZ5zTjyBRyWiJWEZhA==
X-CSE-MsgGUID: jAUVIkh2SL+2hX/TGUgopA==
X-IronPort-AV: E=Sophos;i="6.19,255,1754956800"; 
   d="scan'208";a="5508846"
Received: from ip-10-5-12-219.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.12.219])
  by internal-pdx-out-014.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2025 16:59:14 +0000
Received: from EX19MTAUWB001.ant.amazon.com [205.251.233.51:19462]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.18.50:2525] with esmtp (Farcaster)
 id d9296589-5fdb-4156-af46-1d48d63edab8; Sat, 25 Oct 2025 16:59:14 +0000 (UTC)
X-Farcaster-Flow-ID: d9296589-5fdb-4156-af46-1d48d63edab8
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.20;
 Sat, 25 Oct 2025 16:59:14 +0000
Received: from b0be8375a521.amazon.com (10.37.245.8) by
 EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.29;
 Sat, 25 Oct 2025 16:59:12 +0000
From: Kohei Enju <enjuk@amazon.com>
To: <intel-wired-lan@lists.osuosl.org>, <netdev@vger.kernel.org>
CC: Tony Nguyen <anthony.l.nguyen@intel.com>, Przemek Kitszel
	<przemyslaw.kitszel@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Mitch Williams
	<mitch.a.williams@intel.com>, <kohei.enju@gmail.com>, Kohei Enju
	<enjuk@amazon.com>
Subject: [PATCH iwl-net v1] iavf: fix off-by-one issues in iavf_config_rss_reg()
Date: Sun, 26 Oct 2025 01:58:50 +0900
Message-ID: <20251025165902.80411-1-enjuk@amazon.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D042UWA002.ant.amazon.com (10.13.139.17) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)

There are off-by-one bugs when configuring RSS hash key and lookup
table, causing out-of-bounds reads to memory [1] and out-of-bounds
writes to device registers.

Before commit 43a3d9ba34c9 ("i40evf: Allow PF driver to configure RSS"),
the loop upper bounds were:
    i <= I40E_VFQF_{HKEY,HLUT}_MAX_INDEX
which is safe since the value is the last valid index.

That commit changed the bounds to:
    i <= adapter->rss_{key,lut}_size / 4
where `rss_{key,lut}_size / 4` is the number of dwords, so the last
valid index is `(rss_{key,lut}_size / 4) - 1`. Therefore, using `<=`
accesses one element past the end.

Fix the issues by using `<` instead of `<=`, ensuring we do not exceed
the bounds.

[1] KASAN splat about rss_key_size off-by-one
  BUG: KASAN: slab-out-of-bounds in iavf_config_rss+0x619/0x800
  Read of size 4 at addr ffff888102c50134 by task kworker/u8:6/63

  CPU: 0 UID: 0 PID: 63 Comm: kworker/u8:6 Not tainted 6.18.0-rc2-enjuk-tnguy-00378-g3005f5b77652-dirty #156 PREEMPT(voluntary)
  Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
  Workqueue: iavf iavf_watchdog_task
  Call Trace:
   <TASK>
   dump_stack_lvl+0x6f/0xb0
   print_report+0x170/0x4f3
   kasan_report+0xe1/0x1a0
   iavf_config_rss+0x619/0x800
   iavf_watchdog_task+0x2be7/0x3230
   process_one_work+0x7fd/0x1420
   worker_thread+0x4d1/0xd40
   kthread+0x344/0x660
   ret_from_fork+0x249/0x320
   ret_from_fork_asm+0x1a/0x30
   </TASK>

  Allocated by task 63:
   kasan_save_stack+0x30/0x50
   kasan_save_track+0x14/0x30
   __kasan_kmalloc+0x7f/0x90
   __kmalloc_noprof+0x246/0x6f0
   iavf_watchdog_task+0x28fc/0x3230
   process_one_work+0x7fd/0x1420
   worker_thread+0x4d1/0xd40
   kthread+0x344/0x660
   ret_from_fork+0x249/0x320
   ret_from_fork_asm+0x1a/0x30

  The buggy address belongs to the object at ffff888102c50100
   which belongs to the cache kmalloc-64 of size 64
  The buggy address is located 0 bytes to the right of
   allocated 52-byte region [ffff888102c50100, ffff888102c50134)

  The buggy address belongs to the physical page:
  page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x102c50
  flags: 0x200000000000000(node=0|zone=2)
  page_type: f5(slab)
  raw: 0200000000000000 ffff8881000418c0 dead000000000122 0000000000000000
  raw: 0000000000000000 0000000080200020 00000000f5000000 0000000000000000
  page dumped because: kasan: bad access detected

  Memory state around the buggy address:
   ffff888102c50000: 00 00 00 00 00 00 00 fc fc fc fc fc fc fc fc fc
   ffff888102c50080: 00 00 00 00 00 00 00 fc fc fc fc fc fc fc fc fc
  >ffff888102c50100: 00 00 00 00 00 00 04 fc fc fc fc fc fc fc fc fc
                                       ^
   ffff888102c50180: 00 00 00 00 00 00 00 00 fc fc fc fc fc fc fc fc
   ffff888102c50200: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc

Fixes: 43a3d9ba34c9 ("i40evf: Allow PF driver to configure RSS")
Signed-off-by: Kohei Enju <enjuk@amazon.com>
---
 drivers/net/ethernet/intel/iavf/iavf_main.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/iavf/iavf_main.c b/drivers/net/ethernet/intel/iavf/iavf_main.c
index c2fbe443ef85..4b0fc8f354bc 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_main.c
+++ b/drivers/net/ethernet/intel/iavf/iavf_main.c
@@ -1726,11 +1726,11 @@ static int iavf_config_rss_reg(struct iavf_adapter *adapter)
 	u16 i;
 
 	dw = (u32 *)adapter->rss_key;
-	for (i = 0; i <= adapter->rss_key_size / 4; i++)
+	for (i = 0; i < adapter->rss_key_size / 4; i++)
 		wr32(hw, IAVF_VFQF_HKEY(i), dw[i]);
 
 	dw = (u32 *)adapter->rss_lut;
-	for (i = 0; i <= adapter->rss_lut_size / 4; i++)
+	for (i = 0; i < adapter->rss_lut_size / 4; i++)
 		wr32(hw, IAVF_VFQF_HLUT(i), dw[i]);
 
 	iavf_flush(hw);
-- 
2.51.0


