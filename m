Return-Path: <netdev+bounces-251006-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 79DE4D3A1FB
	for <lists+netdev@lfdr.de>; Mon, 19 Jan 2026 09:46:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2652C3006462
	for <lists+netdev@lfdr.de>; Mon, 19 Jan 2026 08:46:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0553D348463;
	Mon, 19 Jan 2026 08:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="YpRee5Ib"
X-Original-To: netdev@vger.kernel.org
Received: from pdx-out-004.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-004.esa.us-west-2.outbound.mail-perimeter.amazon.com [44.246.77.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1807E34C121
	for <netdev@vger.kernel.org>; Mon, 19 Jan 2026 08:46:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.246.77.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768812379; cv=none; b=nMbf5F2WEWYcrOyDiufKPKU+mLSe8VSPdllBaBT2mdo3QVowhh/AchNrRYFjj1rZN613qz7iFsP4ev7+8kPBCVEDoRATgJp9065XjeY01xqgfeR7meps2TWe5kNkSw81RND20JGIrbs0EA+rqhyEolK6sSEu9LKxXQQz+cHwe8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768812379; c=relaxed/simple;
	bh=GuegJJv6x5gSyndzECz3Gpj7hwCX5l2fb61UWeMrYi8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HCAkhQe6fXLTLrz+UQ3+70ClfXzHbSkOAdjLNwSNtApoSmF5PHbf/p6CsACSEVQjOwE/x0e0Yhb5bgrn3uY3UcfVj7OQY8pL1QWAYGoqUsfadEhu9QIdeqW63GJ/lvC2aE7WW0xY5NGkrU3BiKQwQkFU1S35sCjFq8pT+8ABjiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=YpRee5Ib; arc=none smtp.client-ip=44.246.77.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1768812377; x=1800348377;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=R9oS2nKM1IPBYxWxTXCOu7kJf4dDn6+iSczw0BdZD6s=;
  b=YpRee5IbqqpHHlH1jo+rFctk5+ddv6wj8TcXE07MX2hVq20HSuzl9tJX
   4nNTv3NwqFSkKwluamkEuveef39ZGz6sqBUlm9KLdTW5QetNNZcREV002
   Bj88K6raKCFYMW1lsIQydb3ABnhB/HTLIi5z1aOEizi280qbBFomtNOuH
   yEdDHqbYPNNxOHYfN2by3rFut5E7yrNc4saVnyExwF+YOs5EegduIJCnj
   s/eLGJad9MhXsIAqHd8f6iSls38eow5v0TG5AFYrgMSgdFK48PPy6jarW
   gEaWtd0YHg7M4oKoPoBVrU6i2lIu4Fcrg9Fv/qIKkmcxaF1F3lFS41Nny
   g==;
X-CSE-ConnectionGUID: OMGHLEjcSYCWqyhon8vG2Q==
X-CSE-MsgGUID: JV6XATKDQqua4Msy+YZP/A==
X-IronPort-AV: E=Sophos;i="6.21,237,1763424000"; 
   d="scan'208";a="11111678"
Received: from ip-10-5-6-203.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.6.203])
  by internal-pdx-out-004.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2026 08:46:13 +0000
Received: from EX19MTAUWB001.ant.amazon.com [205.251.233.51:1152]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.27.220:2525] with esmtp (Farcaster)
 id dbcecbfb-a02e-458f-9e01-2cbb3669f167; Mon, 19 Jan 2026 08:46:13 +0000 (UTC)
X-Farcaster-Flow-ID: dbcecbfb-a02e-458f-9e01-2cbb3669f167
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.35;
 Mon, 19 Jan 2026 08:46:13 +0000
Received: from 603e5f7bc1fe.amazon.com (10.37.245.10) by
 EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.35;
 Mon, 19 Jan 2026 08:46:11 +0000
From: Takashi Kozu <takkozu@amazon.com>
To: <anthony.l.nguyen@intel.com>
CC: <przemyslaw.kitszel@intel.com>, <andrew+netdev@lunn.ch>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <intel-wired-lan@lists.osuosl.org>,
	<netdev@vger.kernel.org>, <aleksandr.loktionov@intel.com>,
	<pmenzel@molgen.mpg.de>, <piotr.kwapulinski@intel.com>, Takashi Kozu
	<takkozu@amazon.com>
Subject: [PATCH iwl-next v3 1/3] igb: prepare for RSS key get/set support
Date: Mon, 19 Jan 2026 17:45:05 +0900
Message-ID: <20260119084511.95287-6-takkozu@amazon.com>
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
X-ClientProxiedBy: EX19D042UWA003.ant.amazon.com (10.13.139.44) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)

Store the RSS key inside struct igb_adapter and introduce the
igb_write_rss_key() helper function. This allows the driver to program
the E1000 registers using a persistent RSS key, instead of using a
stack-local buffer in igb_setup_mrqc().

Signed-off-by: Takashi Kozu <takkozu@amazon.com>
---
 drivers/net/ethernet/intel/igb/igb.h         |  3 +++
 drivers/net/ethernet/intel/igb/igb_ethtool.c | 21 ++++++++++++++++++++
 drivers/net/ethernet/intel/igb/igb_main.c    |  8 ++++----
 3 files changed, 28 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/intel/igb/igb.h b/drivers/net/ethernet/intel/igb/igb.h
index 0fff1df81b7b..8c9b02058cec 100644
--- a/drivers/net/ethernet/intel/igb/igb.h
+++ b/drivers/net/ethernet/intel/igb/igb.h
@@ -495,6 +495,7 @@ struct hwmon_buff {
 #define IGB_N_PEROUT	2
 #define IGB_N_SDP	4
 #define IGB_RETA_SIZE	128
+#define IGB_RSS_KEY_SIZE	40
 
 enum igb_filter_match_flags {
 	IGB_FILTER_FLAG_ETHER_TYPE = 0x1,
@@ -655,6 +656,7 @@ struct igb_adapter {
 	struct i2c_client *i2c_client;
 	u32 rss_indir_tbl_init;
 	u8 rss_indir_tbl[IGB_RETA_SIZE];
+	u8 rss_key[IGB_RSS_KEY_SIZE];
 
 	unsigned long link_check_timeout;
 	int copper_tries;
@@ -735,6 +737,7 @@ void igb_down(struct igb_adapter *);
 void igb_reinit_locked(struct igb_adapter *);
 void igb_reset(struct igb_adapter *);
 int igb_reinit_queues(struct igb_adapter *);
+void igb_write_rss_key(struct igb_adapter *adapter);
 void igb_write_rss_indir_tbl(struct igb_adapter *);
 int igb_set_spd_dplx(struct igb_adapter *, u32, u8);
 int igb_setup_tx_resources(struct igb_ring *);
diff --git a/drivers/net/ethernet/intel/igb/igb_ethtool.c b/drivers/net/ethernet/intel/igb/igb_ethtool.c
index 10e2445e0ded..5107b0de4fa3 100644
--- a/drivers/net/ethernet/intel/igb/igb_ethtool.c
+++ b/drivers/net/ethernet/intel/igb/igb_ethtool.c
@@ -3016,6 +3016,27 @@ static int igb_set_rxnfc(struct net_device *dev, struct ethtool_rxnfc *cmd)
 	return ret;
 }
 
+/**
+ * igb_write_rss_key - Program the RSS key into device registers
+ * @adapter: board private structure
+ *
+ * Write the RSS key stored in adapter->rss_key to the E1000 hardware registers.
+ * Each 32-bit chunk of the key is read using get_unaligned_le32() and written
+ * to the appropriate register.
+ */
+void igb_write_rss_key(struct igb_adapter *adapter)
+{
+	ASSERT_RTNL();
+
+	struct e1000_hw *hw = &adapter->hw;
+
+	for (int i = 0; i < IGB_RSS_KEY_SIZE / 4; i++) {
+		u32 val = get_unaligned_le32(&adapter->rss_key[i * 4]);
+
+		wr32(E1000_RSSRK(i), val);
+	}
+}
+
 static int igb_get_eee(struct net_device *netdev, struct ethtool_keee *edata)
 {
 	struct igb_adapter *adapter = netdev_priv(netdev);
diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethernet/intel/igb/igb_main.c
index 85f9589cc568..568f491053ce 100644
--- a/drivers/net/ethernet/intel/igb/igb_main.c
+++ b/drivers/net/ethernet/intel/igb/igb_main.c
@@ -4050,6 +4050,9 @@ static int igb_sw_init(struct igb_adapter *adapter)
 
 	pci_read_config_word(pdev, PCI_COMMAND, &hw->bus.pci_cmd_word);
 
+	/* init RSS key */
+	netdev_rss_key_fill(adapter->rss_key, sizeof(adapter->rss_key));
+
 	/* set default ring sizes */
 	adapter->tx_ring_count = IGB_DEFAULT_TXD;
 	adapter->rx_ring_count = IGB_DEFAULT_RXD;
@@ -4525,11 +4528,8 @@ static void igb_setup_mrqc(struct igb_adapter *adapter)
 	struct e1000_hw *hw = &adapter->hw;
 	u32 mrqc, rxcsum;
 	u32 j, num_rx_queues;
-	u32 rss_key[10];
 
-	netdev_rss_key_fill(rss_key, sizeof(rss_key));
-	for (j = 0; j < 10; j++)
-		wr32(E1000_RSSRK(j), rss_key[j]);
+	igb_write_rss_key(adapter);
 
 	num_rx_queues = adapter->rss_queues;
 
-- 
2.52.0


