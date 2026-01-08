Return-Path: <netdev+bounces-247962-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CD92D01104
	for <lists+netdev@lfdr.de>; Thu, 08 Jan 2026 06:23:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 679B730274C6
	for <lists+netdev@lfdr.de>; Thu,  8 Jan 2026 05:23:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B8622DA765;
	Thu,  8 Jan 2026 05:23:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="lGBLUROI"
X-Original-To: netdev@vger.kernel.org
Received: from pdx-out-008.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-008.esa.us-west-2.outbound.mail-perimeter.amazon.com [52.42.203.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC1702D9EC8
	for <netdev@vger.kernel.org>; Thu,  8 Jan 2026 05:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.42.203.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767849805; cv=none; b=EOFwWHpT2OL3CdTFaxaJjEwPyE62KaOfMCie4JpwlLU/ibjlZmrLZo1e8qMX3kFjr19YQvYg8TQQyW81ck29CVAXg7xKwy5ZTcuKpI5P9ycAUoBPfA0s09MjpGM8F8CobjsK0xHcwG9NwOQinWa2QL743JG7CQlrC6ioc92uhCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767849805; c=relaxed/simple;
	bh=uat4hr6k0Gt9NewW1WXd7frpoC6TWnqlUAyQYrMTwZ8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AlPlv+18pRraPNNmkeebsmnw1Lec4eq4F1Ys/HwTpBmeGL3NW3puzpOL3B0QU2MobOcImpxd3nDCy7JKpi7jpJyaPY3MPQXFA7AGDT0yzO3qhy5CDc8wGWIDHw1XiExf7q4NdTMf1mVVmdXu9XFbgWoIxwKlRQ2IpUwNsgXKeQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=lGBLUROI; arc=none smtp.client-ip=52.42.203.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1767849803; x=1799385803;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=DXUMYkpnLSXEHoLG/kd1BdGaN2eajFN/AZsgn3AfCKg=;
  b=lGBLUROI5y+oLNXC+PGQNpmCHvX9HRKu7ho1I7o/LF0UxfpSzd4H/Lye
   QcwfeMGkvGBnL58iP82C4hq1Y8kx9LJw46B7LXVlLfOaCTVEB+T5MqOyD
   mlxljGPUojPSU3f763Z+cej5xmp5daH37qRjNTNZ3RiNPkWHoCvAs8jUq
   1OzuLvkbSqupzkKj4ODx8ZhZ2rKNGsjMchVHrWRmvdVojnAzse6SiKOkX
   fYZou2jU3g5CZcqeRT9hzOeLqQQ2c368rHrFFurZqNqQezrlqKGn1deQ9
   tls7LkIlS2Lf1EFOIwc3Jm9kkXU0IVCEufSQ7KHu8EOizCcCCrH2p7gbY
   Q==;
X-CSE-ConnectionGUID: NsQa2VhPSjWsdzdOc0i/lA==
X-CSE-MsgGUID: 8GWUiTTpQuCufBSl8iv99w==
X-IronPort-AV: E=Sophos;i="6.21,209,1763424000"; 
   d="scan'208";a="10445309"
Received: from ip-10-5-12-219.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.12.219])
  by internal-pdx-out-008.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jan 2026 05:22:14 +0000
Received: from EX19MTAUWC002.ant.amazon.com [205.251.233.51:21190]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.20.50:2525] with esmtp (Farcaster)
 id eb93a358-352f-49cb-b443-191db7ea4146; Thu, 8 Jan 2026 05:22:14 +0000 (UTC)
X-Farcaster-Flow-ID: eb93a358-352f-49cb-b443-191db7ea4146
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.35;
 Thu, 8 Jan 2026 05:22:14 +0000
Received: from 603e5f7bc1fe.amazon.com (10.37.244.10) by
 EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.35;
 Thu, 8 Jan 2026 05:22:12 +0000
From: Takashi Kozu <takkozu@amazon.com>
To: <anthony.l.nguyen@intel.com>
CC: <przemyslaw.kitszel@intel.com>, <andrew+netdev@lunn.ch>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <intel-wired-lan@lists.osuosl.org>,
	<netdev@vger.kernel.org>, Takashi Kozu <takkozu@amazon.com>, Kohei Enju
	<enjuk@amazon.com>
Subject: [PATCH iwl-next v2 2/3] igb: expose RSS key via ethtool get_rxfh
Date: Thu, 8 Jan 2026 14:20:14 +0900
Message-ID: <20260108052020.84218-7-takkozu@amazon.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20260108052020.84218-5-takkozu@amazon.com>
References: <20260108052020.84218-5-takkozu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D044UWB004.ant.amazon.com (10.13.139.134) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)

Implement igb_get_rxfh_key_size() and extend
igb_get_rxfh() to return the RSS key to userspace.

This can be tested using `ethtool -x <dev>`.

Tested-by: Kohei Enju <enjuk@amazon.com>
Signed-off-by: Takashi Kozu <takkozu@amazon.com>
---
 drivers/net/ethernet/intel/igb/igb_ethtool.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/intel/igb/igb_ethtool.c b/drivers/net/ethernet/intel/igb/igb_ethtool.c
index 8695ff28a7b8..2953d079ebae 100644
--- a/drivers/net/ethernet/intel/igb/igb_ethtool.c
+++ b/drivers/net/ethernet/intel/igb/igb_ethtool.c
@@ -3285,11 +3285,13 @@ static int igb_get_rxfh(struct net_device *netdev,
 	int i;
 
 	rxfh->hfunc = ETH_RSS_HASH_TOP;
-	if (!rxfh->indir)
-		return 0;
-	for (i = 0; i < IGB_RETA_SIZE; i++)
-		rxfh->indir[i] = adapter->rss_indir_tbl[i];
 
+	if (rxfh->indir)
+		for (i = 0; i < IGB_RETA_SIZE; i++)
+			rxfh->indir[i] = adapter->rss_indir_tbl[i];
+
+	if (rxfh->key)
+		memcpy(rxfh->key, adapter->rss_key, sizeof(adapter->rss_key));
 	return 0;
 }
 
@@ -3328,6 +3330,11 @@ void igb_write_rss_indir_tbl(struct igb_adapter *adapter)
 	}
 }
 
+static u32 igb_get_rxfh_key_size(struct net_device *netdev)
+{
+	return IGB_RSS_KEY_SIZE;
+}
+
 static int igb_set_rxfh(struct net_device *netdev,
 			struct ethtool_rxfh_param *rxfh,
 			struct netlink_ext_ack *extack)
@@ -3491,6 +3498,7 @@ static const struct ethtool_ops igb_ethtool_ops = {
 	.get_module_eeprom	= igb_get_module_eeprom,
 	.get_rxfh_indir_size	= igb_get_rxfh_indir_size,
 	.get_rxfh		= igb_get_rxfh,
+	.get_rxfh_key_size	= igb_get_rxfh_key_size,
 	.set_rxfh		= igb_set_rxfh,
 	.get_rxfh_fields	= igb_get_rxfh_fields,
 	.set_rxfh_fields	= igb_set_rxfh_fields,
-- 
2.52.0


