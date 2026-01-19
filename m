Return-Path: <netdev+bounces-251007-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0680AD3A201
	for <lists+netdev@lfdr.de>; Mon, 19 Jan 2026 09:47:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6ACBD3012278
	for <lists+netdev@lfdr.de>; Mon, 19 Jan 2026 08:46:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95CC534E743;
	Mon, 19 Jan 2026 08:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="LepCeXwt"
X-Original-To: netdev@vger.kernel.org
Received: from pdx-out-011.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-011.esa.us-west-2.outbound.mail-perimeter.amazon.com [52.35.192.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3727234D39B
	for <netdev@vger.kernel.org>; Mon, 19 Jan 2026 08:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.35.192.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768812406; cv=none; b=R/EtJRz/Zu4cvU0nzK4nL7V35B8TXAdl7LBvXmQ/wRovqBD9k5Oeyr3lksrF8n94TTQXRkSkM9aqfVmGMs5mswrsDkJMQ+UzvW073uxuW+7/s/HPcqK6TUvDqPx79Srt1pESHvxoFlLRBU3VJ4ISsDpodvV3aUgaU7/787C9MMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768812406; c=relaxed/simple;
	bh=y+Fdo2JYVw5iF22HTfCdLUmYZtz9s8ugZzycc4wVvIc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MQgB36xJIeYHg1szLONneXgHu8advds6ZdExTdZABUlELoUzQNFEhzukhJmKrtwbyF3tw+yGWYE/0nunRGjob8fePPDOgsi/gV7Un7sjL4fWmJxzHqnS/0uLpno28FEI4OQxZhTC/ylxfOc4q6AOdShbi+MJBApcAzuZ7Vg33Bs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=LepCeXwt; arc=none smtp.client-ip=52.35.192.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1768812404; x=1800348404;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=l4uKN1CmkqiI48Cnr41EhxL422wjqot2MgWtmziFFv8=;
  b=LepCeXwt298WaOAzawVLlyEfGoXGHef79uDM6/8eFCBudDDfaP9mdKlg
   /6Mt41YN6DWwLJnxtHT6S0wLmDpuWP6PJaqCTmhPbIKtum/K4EaiTFW6p
   hd9m+zLCdqgNJ24fvrXcXm1vfXsm9eWQ6xHHYjMSJMqpIGcbHdaBE3TIa
   YYOVUxZpjfo5VrOpYNYcvaLUDougqnb/tC/BYaCtuLtUznXaUUB4I7oWb
   G2bq/PbALg+D2+Mb+BMy2uOBX8IIb6yaZJd5BQ25dqbXyBl3Iaxhi7o60
   cnOIiVukPpbwRJEQ+osf9ptV6mOXX33pzmoyFLb/dj+NA5ANjddyeUg6T
   g==;
X-CSE-ConnectionGUID: UoQ2Rf65TbGpjYA81EIeEQ==
X-CSE-MsgGUID: iNt0CwJSR+G6nkGpJ5eqYw==
X-IronPort-AV: E=Sophos;i="6.21,237,1763424000"; 
   d="scan'208";a="10901829"
Received: from ip-10-5-6-203.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.6.203])
  by internal-pdx-out-011.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2026 08:46:40 +0000
Received: from EX19MTAUWA002.ant.amazon.com [205.251.233.234:6304]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.61.216:2525] with esmtp (Farcaster)
 id b8718bcf-5696-4671-8c3f-88cb2b39ee58; Mon, 19 Jan 2026 08:46:40 +0000 (UTC)
X-Farcaster-Flow-ID: b8718bcf-5696-4671-8c3f-88cb2b39ee58
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.35;
 Mon, 19 Jan 2026 08:46:39 +0000
Received: from 603e5f7bc1fe.amazon.com (10.37.245.10) by
 EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.35;
 Mon, 19 Jan 2026 08:46:37 +0000
From: Takashi Kozu <takkozu@amazon.com>
To: <anthony.l.nguyen@intel.com>
CC: <przemyslaw.kitszel@intel.com>, <andrew+netdev@lunn.ch>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <intel-wired-lan@lists.osuosl.org>,
	<netdev@vger.kernel.org>, <aleksandr.loktionov@intel.com>,
	<pmenzel@molgen.mpg.de>, <piotr.kwapulinski@intel.com>, Takashi Kozu
	<takkozu@amazon.com>
Subject: [PATCH iwl-next v3 2/3] igb: expose RSS key via ethtool get_rxfh
Date: Mon, 19 Jan 2026 17:45:06 +0900
Message-ID: <20260119084511.95287-7-takkozu@amazon.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20260119084511.95287-5-takkozu@amazon.com>
References: <20260119084511.95287-5-takkozu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D042UWB001.ant.amazon.com (10.13.139.160) To
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
index 5107b0de4fa3..2251f30378ab 100644
--- a/drivers/net/ethernet/intel/igb/igb_ethtool.c
+++ b/drivers/net/ethernet/intel/igb/igb_ethtool.c
@@ -3294,10 +3294,12 @@ static int igb_get_rxfh(struct net_device *netdev,
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
@@ -3337,6 +3339,11 @@ void igb_write_rss_indir_tbl(struct igb_adapter *adapter)
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
@@ -3500,6 +3507,7 @@ static const struct ethtool_ops igb_ethtool_ops = {
 	.get_module_eeprom	= igb_get_module_eeprom,
 	.get_rxfh_indir_size	= igb_get_rxfh_indir_size,
 	.get_rxfh		= igb_get_rxfh,
+	.get_rxfh_key_size	= igb_get_rxfh_key_size,
 	.set_rxfh		= igb_set_rxfh,
 	.get_rxfh_fields	= igb_get_rxfh_fields,
 	.set_rxfh_fields	= igb_set_rxfh_fields,
-- 
2.52.0


