Return-Path: <netdev+bounces-243756-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id B91D5CA70A7
	for <lists+netdev@lfdr.de>; Fri, 05 Dec 2025 11:00:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DEF89331F2B2
	for <lists+netdev@lfdr.de>; Fri,  5 Dec 2025 08:43:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8A6C237180;
	Fri,  5 Dec 2025 08:23:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="Vj7NfVDI"
X-Original-To: netdev@vger.kernel.org
Received: from pdx-out-008.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-008.esa.us-west-2.outbound.mail-perimeter.amazon.com [52.42.203.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 527602F49F6
	for <netdev@vger.kernel.org>; Fri,  5 Dec 2025 08:22:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.42.203.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764922981; cv=none; b=EenfCxRO/hMi87F+/DfbgDJNgGipIdrQy2MHW43SRlsys12NNuUlwfRsA1/qNVkcTZjgoKbuEcLldMqu4rh4V4V+sGmaAWC0A4/jXA9tWjNH/ZASYgTKId9S43f4kq47DOG1SGIVKQGo5+uhpYBq6PE7JTl30UyScseGeWVA5TE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764922981; c=relaxed/simple;
	bh=TDtRkY9xG/r0mME/K4HlPfVA5vCPLvvp2070I4GTOkY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Hv/rNFkqI9SAnfQNwMFRQD4eN1aURHR5QlaILnuaCu8cMfsE5ECPPUM/XIfE9xzpKE7+SN8PW0YTynLRvxtX0/iiw+j7cjYcEhgTSV7iBMXaVfL6EOK8dquvyeChGBaRf6BgcC0VjykPkaIcie4ZmkuBBv8vWJKoxDz5LWBGEKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=Vj7NfVDI; arc=none smtp.client-ip=52.42.203.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1764922974; x=1796458974;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Hj4D7BE1z3GuDZEPlOZUohqNnijEiL29dsefZAeyPuw=;
  b=Vj7NfVDIYUBl7/FefV1gG/txgzJK8mo77/vFTIhls6nNbT9QosuPD+/g
   9veBtBSBEPKN86l3sMynyqtxQS6YX5ZyM0r9OK6oZ6g1dWJpuFNUUHjVH
   iig7vAL5utghAnjbUaViXG7TIAEbqNc3f6dHDkkCSc2stpu6OnXBZdLex
   GnX16gD4xWMMGBrSwguWZCU6K0B0cpCzN6h7CD/F2hL55z70TXvKq7PsP
   i0RTldye1sN8nzmum236MYBz52IUy7pDUoJJMTgUJcM84icNKntCReUhr
   4Gf9327USoxhIUClzJloymdEnCARguTI9PofvNbhqUyDd2Yq4cLT9zXTC
   Q==;
X-CSE-ConnectionGUID: 4uFGoKWlRXCvMNBbH3Tb2g==
X-CSE-MsgGUID: i4vVKa2UTpKdHiFKdsF4tg==
X-IronPort-AV: E=Sophos;i="6.20,251,1758585600"; 
   d="scan'208";a="8477429"
Received: from ip-10-5-12-219.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.12.219])
  by internal-pdx-out-008.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2025 08:22:43 +0000
Received: from EX19MTAUWB001.ant.amazon.com [205.251.233.51:29513]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.1.134:2525] with esmtp (Farcaster)
 id 717cb521-b318-47f0-8552-0bd9a2a35978; Fri, 5 Dec 2025 08:22:42 +0000 (UTC)
X-Farcaster-Flow-ID: 717cb521-b318-47f0-8552-0bd9a2a35978
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.29;
 Fri, 5 Dec 2025 08:22:42 +0000
Received: from 603e5f7bc1fe.amazon.com (10.37.244.13) by
 EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.29;
 Fri, 5 Dec 2025 08:22:41 +0000
From: Takashi Kozu <takkozu@amazon.com>
To: <anthony.l.nguyen@intel.com>
CC: <przemyslaw.kitszel@intel.com>, <andrew+netdev@lunn.ch>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <intel-wired-lan@lists.osuosl.org>,
	<netdev@vger.kernel.org>, Takashi Kozu <takkozu@amazon.com>, Kohei Enju
	<enjuk@amazon.com>
Subject: [PATCH iwl-next v1 2/3] igb: expose RSS key via ethtool get_rxfh
Date: Fri, 5 Dec 2025 17:21:06 +0900
Message-ID: <20251205082106.4028-7-takkozu@amazon.com>
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
X-ClientProxiedBy: EX19D032UWA002.ant.amazon.com (10.13.139.81) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)

Implement igc_get_rxfh_key_size() and extend
igc_get_rxfh() to return the RSS key to userspace.

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
2.51.1


