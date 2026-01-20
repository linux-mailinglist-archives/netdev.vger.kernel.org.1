Return-Path: <netdev+bounces-251415-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 50D41D3C43B
	for <lists+netdev@lfdr.de>; Tue, 20 Jan 2026 10:55:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A02DE6493E8
	for <lists+netdev@lfdr.de>; Tue, 20 Jan 2026 09:41:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 256D03ECBCF;
	Tue, 20 Jan 2026 09:35:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="QWLjSNQt"
X-Original-To: netdev@vger.kernel.org
Received: from pdx-out-007.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-007.esa.us-west-2.outbound.mail-perimeter.amazon.com [52.34.181.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F1993DA7D9
	for <netdev@vger.kernel.org>; Tue, 20 Jan 2026 09:35:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.34.181.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768901756; cv=none; b=iX5TV8SerHZE7jxT9cW8+HcIcBLJrHn/maDmAuEkE38dmyHfXmUJep7pvSxpiWvFl2SEvR4iZU2x443XLCxNAZrUAZuO/AA25MOc/umfd19sBMF7nfKN9gxKAyDyC8ggVN8NX/AHcIhlItEyFXSz8eWrzc7pViJJnGm8KiSmPUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768901756; c=relaxed/simple;
	bh=6XjfhndlIBIF6L5ui3L7esruHiywj58LmcxdagkDtOk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ccFcS6jnJvqkRMwxXqbS6dPXooODuTRaA1b3SkFd1IQOH7xEkTQ7nfNfQOnyVHddrdh89nOHTHOMBjS1mEuPtkyiiarUysKRFXd5tGbIurX24M2Xl/MUPKIQC1ajZEJfg1Zga9dCtwY5a5u2QNou4Jj5CkprsfRwIOKr7rlbvSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=QWLjSNQt; arc=none smtp.client-ip=52.34.181.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1768901754; x=1800437754;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Hpm3tzHmLebq8eIS8qDAzoE8I3X/7qHvO8PMgK5y+KM=;
  b=QWLjSNQtWGaTYE1q+o70WaXffkiO4kcnqAeCMcHV31VUvFQv2DKKldTq
   ZgTkun/PMD//87OWRU4QKfsn4F5ODdLdb2qast1nRHKp/TBYXN+pL8W/l
   Br0+cuBMt/tru/2jvCohFJD5SuKauO1+9WBaKOEmMoJscZaZgfQliKIM2
   Wrer8qYdgEUfsWg3qZOBQxyyFpZF/uAgxbuJf8YFv8KWdhyktrbHq1fOy
   oiXoPOJ8c+EtAJ1fJEAnE5pfXb6n8eEWKHdW+DDXd+VdnBd5ogg62YOfr
   oA1boqR+He2w6UqRGT2GEbOEY4Hq00PoqDtFg8cc9MGJU87NoWIsl9mgm
   A==;
X-CSE-ConnectionGUID: bmR5EjacRjCOLEYehtn1ZQ==
X-CSE-MsgGUID: YZBrm2wHSdOKz13Sk5dxCg==
X-IronPort-AV: E=Sophos;i="6.21,240,1763424000"; 
   d="scan'208";a="11193028"
Received: from ip-10-5-0-115.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.0.115])
  by internal-pdx-out-007.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jan 2026 09:35:50 +0000
Received: from EX19MTAUWC001.ant.amazon.com [205.251.233.105:22299]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.14.244:2525] with esmtp (Farcaster)
 id 3384d617-c6fb-4c1b-9d4a-e7c3eb29c53f; Tue, 20 Jan 2026 09:35:50 +0000 (UTC)
X-Farcaster-Flow-ID: 3384d617-c6fb-4c1b-9d4a-e7c3eb29c53f
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.35;
 Tue, 20 Jan 2026 09:35:50 +0000
Received: from 603e5f7bc1fe.amazon.com (10.37.244.13) by
 EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.35;
 Tue, 20 Jan 2026 09:35:47 +0000
From: Takashi Kozu <takkozu@amazon.com>
To: <anthony.l.nguyen@intel.com>
CC: <przemyslaw.kitszel@intel.com>, <andrew+netdev@lunn.ch>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <intel-wired-lan@lists.osuosl.org>,
	<netdev@vger.kernel.org>, <aleksandr.loktionov@intel.com>,
	<pmenzel@molgen.mpg.de>, <piotr.kwapulinski@intel.com>, <enjuk@amazon.com>,
	Takashi Kozu <takkozu@amazon.com>
Subject: [PATCH iwl-next v4 2/3] igb: expose RSS key via ethtool get_rxfh
Date: Tue, 20 Jan 2026 18:34:39 +0900
Message-ID: <20260120093441.70075-7-takkozu@amazon.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20260120093441.70075-5-takkozu@amazon.com>
References: <20260120093441.70075-5-takkozu@amazon.com>
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

Implement igb_get_rxfh_key_size() and extend
igb_get_rxfh() to return the RSS key to userspace.

This can be tested using `ethtool -x <dev>`.

Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Signed-off-by: Takashi Kozu <takkozu@amazon.com>
---
 drivers/net/ethernet/intel/igb/igb_ethtool.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/intel/igb/igb_ethtool.c b/drivers/net/ethernet/intel/igb/igb_ethtool.c
index a93069b761a6..b387121f0ea7 100644
--- a/drivers/net/ethernet/intel/igb/igb_ethtool.c
+++ b/drivers/net/ethernet/intel/igb/igb_ethtool.c
@@ -3297,10 +3297,12 @@ static int igb_get_rxfh(struct net_device *netdev,
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
@@ -3340,6 +3342,11 @@ void igb_write_rss_indir_tbl(struct igb_adapter *adapter)
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
@@ -3504,6 +3511,7 @@ static const struct ethtool_ops igb_ethtool_ops = {
 	.get_module_eeprom	= igb_get_module_eeprom,
 	.get_rxfh_indir_size	= igb_get_rxfh_indir_size,
 	.get_rxfh		= igb_get_rxfh,
+	.get_rxfh_key_size	= igb_get_rxfh_key_size,
 	.set_rxfh		= igb_set_rxfh,
 	.get_rxfh_fields	= igb_get_rxfh_fields,
 	.set_rxfh_fields	= igb_set_rxfh_fields,
-- 
2.52.0


