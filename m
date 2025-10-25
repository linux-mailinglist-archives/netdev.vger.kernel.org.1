Return-Path: <netdev+bounces-232837-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id EEBE2C09268
	for <lists+netdev@lfdr.de>; Sat, 25 Oct 2025 17:03:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D69CD4E17D4
	for <lists+netdev@lfdr.de>; Sat, 25 Oct 2025 15:03:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C27F42FFDFB;
	Sat, 25 Oct 2025 15:03:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="fb+IGUpU"
X-Original-To: netdev@vger.kernel.org
Received: from pdx-out-015.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-015.esa.us-west-2.outbound.mail-perimeter.amazon.com [50.112.246.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 292E22C15B4
	for <netdev@vger.kernel.org>; Sat, 25 Oct 2025 15:03:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=50.112.246.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761404592; cv=none; b=dV95RfjWwzslVycwZKMtzh/EtyU1C+5ZTpJX73VaHj2r/OT1NOM9fUYqLtNKUDQDP4GVNml0vcY3Qo28+Scwvw8LxhrT84KXHmwPtIJZwgBKQwdcdR0WErImgj8vFk3i+VAjuKueXP3WDg2mGzy3uKKZQzNYAg5soOKUIyWaHX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761404592; c=relaxed/simple;
	bh=4hEZpo2hKqbp89YY8Nap1pGV04+dnR768N22kbgWfrw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CjMna4rTWr/RXhxLxLBl7gzFGIYfZsLyXceB7+1PGcTkA5AIl8FesteSyDKtfMiZI7iq0yeJ69GeDeYcOjASymyz0QNAX5gM2mgyEe68DCh3/lh88KrmT2cswjRDEsfQCmZ4+7n8u0Iu3nPNbWOpva40e/ytnMjaBXdpHT7bcYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=fb+IGUpU; arc=none smtp.client-ip=50.112.246.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1761404591; x=1792940591;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Tsq9w8JRKEL450WkTNkNXkuHrLaLkKptl+VicofTqXY=;
  b=fb+IGUpUZj3uvIGiwmJqlMKd4+onXYNN3q8R8pXAsLMqdq71Dn2Lfp+Y
   z6vpaejferX20PMAz8pqDdvkg82r7y9fqufRNQuXlwlXe9FqhzURqbyOv
   OXF6xLbRRleqBH0HY6XOJ/nAsyalu+V0+1lrwbBftZIgfmcD8jk5J7w2N
   fcyydacOVucKXUGnB2gTNeqIxRBFKyN+uWjsfdmlIn0YiKTi8G1QAujuB
   +UqJeeOySdYRS3+xRhmTCdPMvQx/Dx910ONGOZBsLsvAisWYZAE1Nzoi8
   VOITAmrFmi7NvXubo8wO2+C80cFfRd9aOy4KnYtNDTGzjDs2l1eOQQ5uX
   A==;
X-CSE-ConnectionGUID: XmkJ5SMmSmyLaeUyMUEudA==
X-CSE-MsgGUID: xW9kgsUVTLq2eZ2O2lIOGg==
X-IronPort-AV: E=Sophos;i="6.19,255,1754956800"; 
   d="scan'208";a="5508493"
Received: from ip-10-5-0-115.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.0.115])
  by internal-pdx-out-015.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2025 15:03:07 +0000
Received: from EX19MTAUWB001.ant.amazon.com [205.251.233.104:17402]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.8.44:2525] with esmtp (Farcaster)
 id f0b63301-7608-493c-a890-145cbbb0f4f6; Sat, 25 Oct 2025 15:03:07 +0000 (UTC)
X-Farcaster-Flow-ID: f0b63301-7608-493c-a890-145cbbb0f4f6
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.20;
 Sat, 25 Oct 2025 15:03:07 +0000
Received: from b0be8375a521.amazon.com (10.37.244.8) by
 EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.29;
 Sat, 25 Oct 2025 15:03:04 +0000
From: Kohei Enju <enjuk@amazon.com>
To: <intel-wired-lan@lists.osuosl.org>, <netdev@vger.kernel.org>
CC: Tony Nguyen <anthony.l.nguyen@intel.com>, Przemek Kitszel
	<przemyslaw.kitszel@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	<kohei.enju@gmail.com>, Kohei Enju <enjuk@amazon.com>
Subject: [PATCH iwl-next v1 3/3] igc: allow configuring RSS key via ethtool set_rxfh
Date: Sun, 26 Oct 2025 00:01:32 +0900
Message-ID: <20251025150136.47618-4-enjuk@amazon.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20251025150136.47618-1-enjuk@amazon.com>
References: <20251025150136.47618-1-enjuk@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D043UWC002.ant.amazon.com (10.13.139.222) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)

Change igc_ethtool_set_rxfh() to accept and save a userspace-provided
RSS key. When a key is provided, store it in the adapter and write the
RSSRK registers accordingly.

This can be tested using `ethtool -X <dev> hkey <key>`.

Signed-off-by: Kohei Enju <enjuk@amazon.com>
---
 drivers/net/ethernet/intel/igc/igc.h         |  1 +
 drivers/net/ethernet/intel/igc/igc_ethtool.c | 31 ++++++++++++--------
 drivers/net/ethernet/intel/igc/igc_main.c    |  3 +-
 3 files changed, 21 insertions(+), 14 deletions(-)

diff --git a/drivers/net/ethernet/intel/igc/igc.h b/drivers/net/ethernet/intel/igc/igc.h
index dd159397d191..c894a5a99fc0 100644
--- a/drivers/net/ethernet/intel/igc/igc.h
+++ b/drivers/net/ethernet/intel/igc/igc.h
@@ -304,6 +304,7 @@ struct igc_adapter {
 
 	u8 rss_indir_tbl[IGC_RETA_SIZE];
 	u8 rss_key[IGC_RSS_KEY_SIZE];
+	bool has_user_rss_key;
 
 	unsigned long link_check_timeout;
 	struct igc_info ei;
diff --git a/drivers/net/ethernet/intel/igc/igc_ethtool.c b/drivers/net/ethernet/intel/igc/igc_ethtool.c
index 0482e590bc5a..64eac1ccb3ff 100644
--- a/drivers/net/ethernet/intel/igc/igc_ethtool.c
+++ b/drivers/net/ethernet/intel/igc/igc_ethtool.c
@@ -1527,24 +1527,29 @@ static int igc_ethtool_set_rxfh(struct net_device *netdev,
 	int i;
 
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
 
-	/* Verify user input. */
-	for (i = 0; i < IGC_RETA_SIZE; i++)
-		if (rxfh->indir[i] >= num_queues)
-			return -EINVAL;
+		/* Verify user input. */
+		for (i = 0; i < IGC_RETA_SIZE; i++)
+			if (rxfh->indir[i] >= num_queues)
+				return -EINVAL;
 
-	for (i = 0; i < IGC_RETA_SIZE; i++)
-		adapter->rss_indir_tbl[i] = rxfh->indir[i];
+		for (i = 0; i < IGC_RETA_SIZE; i++)
+			adapter->rss_indir_tbl[i] = rxfh->indir[i];
 
-	igc_write_rss_indir_tbl(adapter);
+		igc_write_rss_indir_tbl(adapter);
+	}
+
+	if (rxfh->key) {
+		adapter->has_user_rss_key = true;
+		memcpy(adapter->rss_key, rxfh->key, sizeof(adapter->rss_key));
+		igc_write_rss_key(adapter);
+	}
 
 	return 0;
 }
diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethernet/intel/igc/igc_main.c
index 1f0a601cbcef..e977661bed2f 100644
--- a/drivers/net/ethernet/intel/igc/igc_main.c
+++ b/drivers/net/ethernet/intel/igc/igc_main.c
@@ -779,7 +779,8 @@ static void igc_setup_mrqc(struct igc_adapter *adapter)
 	u32 j, num_rx_queues;
 	u32 mrqc, rxcsum;
 
-	netdev_rss_key_fill(adapter->rss_key, sizeof(adapter->rss_key));
+	if (!adapter->has_user_rss_key)
+		netdev_rss_key_fill(adapter->rss_key, sizeof(adapter->rss_key));
 	igc_write_rss_key(adapter);
 
 	num_rx_queues = adapter->rss_queues;
-- 
2.51.0


