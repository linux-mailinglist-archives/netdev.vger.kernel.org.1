Return-Path: <netdev+bounces-243759-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 14E9ACA6C01
	for <lists+netdev@lfdr.de>; Fri, 05 Dec 2025 09:45:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2F6D63083102
	for <lists+netdev@lfdr.de>; Fri,  5 Dec 2025 08:44:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 682723314C3;
	Fri,  5 Dec 2025 08:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="URv0W3HX"
X-Original-To: netdev@vger.kernel.org
Received: from pdx-out-006.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-006.esa.us-west-2.outbound.mail-perimeter.amazon.com [52.26.1.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2563248F78
	for <netdev@vger.kernel.org>; Fri,  5 Dec 2025 08:24:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.26.1.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764923073; cv=none; b=pVV2tQXPeFaBltkXFrRPUlYrdYskeWfg6W8KRkQlC1Oqgozojl6r71vu2+HQ4Y9C1ykC2f3nCGoE88ctSLetUPTJjUA2qws3Fr/edl4sHdadHxPExiBcab0GfUJO9PGGxm6yxq6OZmAT36ukb2EuVOrtv8h1KT0G/PBMoSuhVFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764923073; c=relaxed/simple;
	bh=cPePluyBulPkU+0yg5Aa4HMFQcVJeFgvMKt9FRgg/a4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sAlHvWUAe4HpFYooL7Z4OffA56hrO73+zOqawNgXF1sacvMY2xYypwog25GFJIotpYZ4UtX7AjSNvoqP2GL5zFXJlFW1yiVPDd8uXl2GNj09SneQhcnp7iC6woBboKXVrB6cLUw0PU4PhYCoxr/GYhrlkRMnwV1dltkcE/F2RUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=URv0W3HX; arc=none smtp.client-ip=52.26.1.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1764923066; x=1796459066;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ESjb8opnrbPtZsN4yBdjQUuGOItJtcMAVPnjLNmrvDI=;
  b=URv0W3HXPUeXZvZ0SnGvKUrzFK3yqPgYPk7wilIuOrPCWNn3U6Ef54w5
   bHWZaCt7e9knqShJU4hilBpW2eXrLj0z0GM1z0nC3hCIof938XayWCaUy
   W3PMPF5L74JaTJfdYZhqxM+9hSs13RwRD6F0j58ceqM76eZogeSJjIQSW
   d5eTswpJUg43Zpa/rtNjeJ7waM1jGWkshpJkrEv7EdtfF6ARfMrZQ5Yhf
   7Sk9uBpOxckNBZ9dX+v0BCwvcDtPq28FvSHJkIZK9O9QcFOTJmxHTxYFh
   onmkyvRC+IBBXZppchUbH3YVpYDE3h58OKwA8vTOAz5dYnQYwSYIerjCW
   Q==;
X-CSE-ConnectionGUID: Dax6Wjy0QWea8ZprF4KL5Q==
X-CSE-MsgGUID: qFxtSb5cTSWxAa1OCfwIZQ==
X-IronPort-AV: E=Sophos;i="6.20,251,1758585600"; 
   d="scan'208";a="8494767"
Received: from ip-10-5-6-203.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.6.203])
  by internal-pdx-out-006.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2025 08:23:12 +0000
Received: from EX19MTAUWC002.ant.amazon.com [205.251.233.51:23161]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.51.201:2525] with esmtp (Farcaster)
 id 309e1d2c-04bd-4cf0-8326-a64407a40886; Fri, 5 Dec 2025 08:23:12 +0000 (UTC)
X-Farcaster-Flow-ID: 309e1d2c-04bd-4cf0-8326-a64407a40886
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.29;
 Fri, 5 Dec 2025 08:23:12 +0000
Received: from 603e5f7bc1fe.amazon.com (10.37.244.13) by
 EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.29;
 Fri, 5 Dec 2025 08:23:10 +0000
From: Takashi Kozu <takkozu@amazon.com>
To: <anthony.l.nguyen@intel.com>
CC: <przemyslaw.kitszel@intel.com>, <andrew+netdev@lunn.ch>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <intel-wired-lan@lists.osuosl.org>,
	<netdev@vger.kernel.org>, Takashi Kozu <takkozu@amazon.com>, Kohei Enju
	<enjuk@amazon.com>
Subject: [PATCH iwl-next v1 3/3] igb: allow configuring RSS key via ethtool set_rxfh
Date: Fri, 5 Dec 2025 17:21:07 +0900
Message-ID: <20251205082106.4028-8-takkozu@amazon.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20251205082106.4028-5-takkozu@amazon.com>
References: <20251205082106.4028-5-takkozu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D040UWA003.ant.amazon.com (10.13.139.6) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)

Change igc_set_rxfh() to accept and save a userspace-provided
RSS key. When a key is provided, store it in the adapter and write the
E1000 registers accordingly.

This can be tested using `ethtool -X <dev> hkey <key>`.

Tested-by: Kohei Enju <enjuk@amazon.com>
Signed-off-by: Takashi Kozu <takkozu@amazon.com>
---
 drivers/net/ethernet/intel/igb/igb.h         |  1 +
 drivers/net/ethernet/intel/igb/igb_ethtool.c | 49 +++++++++++---------
 drivers/net/ethernet/intel/igb/igb_main.c    |  3 +-
 3 files changed, 30 insertions(+), 23 deletions(-)

diff --git a/drivers/net/ethernet/intel/igb/igb.h b/drivers/net/ethernet/intel/igb/igb.h
index 8c9b02058cec..2509ec30acf3 100644
--- a/drivers/net/ethernet/intel/igb/igb.h
+++ b/drivers/net/ethernet/intel/igb/igb.h
@@ -657,6 +657,7 @@ struct igb_adapter {
 	u32 rss_indir_tbl_init;
 	u8 rss_indir_tbl[IGB_RETA_SIZE];
 	u8 rss_key[IGB_RSS_KEY_SIZE];
+	bool has_user_rss_key;
 
 	unsigned long link_check_timeout;
 	int copper_tries;
diff --git a/drivers/net/ethernet/intel/igb/igb_ethtool.c b/drivers/net/ethernet/intel/igb/igb_ethtool.c
index 2953d079ebae..ac045fbebade 100644
--- a/drivers/net/ethernet/intel/igb/igb_ethtool.c
+++ b/drivers/net/ethernet/intel/igb/igb_ethtool.c
@@ -3345,35 +3345,40 @@ static int igb_set_rxfh(struct net_device *netdev,
 	u32 num_queues;
 
 	/* We do not allow change in unsupported parameters */
-	if (rxfh->key ||
-	    (rxfh->hfunc != ETH_RSS_HASH_NO_CHANGE &&
-	     rxfh->hfunc != ETH_RSS_HASH_TOP))
+	if (rxfh->hfunc != ETH_RSS_HASH_NO_CHANGE &&
+	    rxfh->hfunc != ETH_RSS_HASH_TOP)
 		return -EOPNOTSUPP;
-	if (!rxfh->indir)
-		return 0;
 
-	num_queues = adapter->rss_queues;
+	if (rxfh->indir) {
+		num_queues = adapter->rss_queues;
 
-	switch (hw->mac.type) {
-	case e1000_82576:
-		/* 82576 supports 2 RSS queues for SR-IOV */
-		if (adapter->vfs_allocated_count)
-			num_queues = 2;
-		break;
-	default:
-		break;
-	}
+		switch (hw->mac.type) {
+		case e1000_82576:
+			/* 82576 supports 2 RSS queues for SR-IOV */
+			if (adapter->vfs_allocated_count)
+				num_queues = 2;
+			break;
+		default:
+			break;
+		}
 
-	/* Verify user input. */
-	for (i = 0; i < IGB_RETA_SIZE; i++)
-		if (rxfh->indir[i] >= num_queues)
-			return -EINVAL;
+		/* Verify user input. */
+		for (i = 0; i < IGB_RETA_SIZE; i++)
+			if (rxfh->indir[i] >= num_queues)
+				return -EINVAL;
 
 
-	for (i = 0; i < IGB_RETA_SIZE; i++)
-		adapter->rss_indir_tbl[i] = rxfh->indir[i];
+		for (i = 0; i < IGB_RETA_SIZE; i++)
+			adapter->rss_indir_tbl[i] = rxfh->indir[i];
+
+		igb_write_rss_indir_tbl(adapter);
+	}
 
-	igb_write_rss_indir_tbl(adapter);
+	if (rxfh->key) {
+		adapter->has_user_rss_key = true;
+		memcpy(adapter->rss_key, rxfh->key, sizeof(adapter->rss_key));
+		igb_write_rss_key(adapter);
+	}
 
 	return 0;
 }
diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethernet/intel/igb/igb_main.c
index da0f550de605..d42b3750f0b1 100644
--- a/drivers/net/ethernet/intel/igb/igb_main.c
+++ b/drivers/net/ethernet/intel/igb/igb_main.c
@@ -4526,7 +4526,8 @@ static void igb_setup_mrqc(struct igb_adapter *adapter)
 	u32 mrqc, rxcsum;
 	u32 j, num_rx_queues;
 
-	netdev_rss_key_fill(adapter->rss_key, sizeof(adapter->rss_key));
+	if (!adapter->has_user_rss_key)
+		netdev_rss_key_fill(adapter->rss_key, sizeof(adapter->rss_key));
 	igb_write_rss_key(adapter);
 
 	num_rx_queues = adapter->rss_queues;
-- 
2.51.1


