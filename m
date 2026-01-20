Return-Path: <netdev+bounces-251414-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 37B25D3C4A1
	for <lists+netdev@lfdr.de>; Tue, 20 Jan 2026 11:09:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DD3456C942E
	for <lists+netdev@lfdr.de>; Tue, 20 Jan 2026 09:41:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EA593C00B2;
	Tue, 20 Jan 2026 09:35:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="IWUnB7FZ"
X-Original-To: netdev@vger.kernel.org
Received: from pdx-out-015.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-015.esa.us-west-2.outbound.mail-perimeter.amazon.com [50.112.246.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 660463E9F9C
	for <netdev@vger.kernel.org>; Tue, 20 Jan 2026 09:35:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=50.112.246.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768901725; cv=none; b=iNQhd5cnZiJmQGwWHRTXW6n/UoOcRutWkf75MLm/golbj9maY5IjMYq+1oQ0Uw1VA34YpdGKqMzcpoT6HuyTJgbM64tGBKAb3l6gVM5dhsdhnbq++e1O+osZv4Y/IwSP3VFLFChV6dMGN3F8VT3qb3LJwPH/jS/TE+kOLr0Lpwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768901725; c=relaxed/simple;
	bh=bcyLl26NRH+EZa0GmSJTmTVhi4qbiWK52JguLulwyfA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LbVDsW+0umB2Eqj8JS6FB5bqE7tw88+560pzPmth7YKkf0V7J2onpsReazQvgBZC0iiwEJ0/77ipPmBP9lty/SYwLBQyV5oh+hHiqgpKgfqHvq3BjVw/fNSF287hVLCVpFbyggIXxBlrQ7tn9BQy7YfKB1FJNoXYtnheGbzOwkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=IWUnB7FZ; arc=none smtp.client-ip=50.112.246.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1768901723; x=1800437723;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=VmhykyNRHVvT8VCbu3agueRt2DS6S6sxyxmRozyEyqY=;
  b=IWUnB7FZe1jlQ/3L8BRNrsLwvLy3ToBS+YGkl01NptFAuuDcy+neyB4A
   Jy/Ozx7V50TAZNScuHAVu7m8B0SlvePDWrcKnUCSgnZOvxvnaA93ZIHun
   v1x7sPyFnvoEJ9/+YYeKCx2oT20c+dH/xYsiwMappm0LkAT5VDLg7RhXK
   MoAUsL2wfL5qShcqBgZSJNiUT81nIOyVlmZ6RYZGU4aDHohz18qcxAs4f
   cUfwrPIlWf4T7MULE8bdcBcWk7z94waiXy0dN7FdTc8Zr5URm7RvtUSM6
   nEbeCAOjLobPSWAIpf870EWVt0tWjvDT/jaXbtcCrYoyrYujBTkuFZ52l
   A==;
X-CSE-ConnectionGUID: jgrdmkgTTf+IcL7hN0SFlw==
X-CSE-MsgGUID: pwDgyUUPSfKVekVkKsnR4Q==
X-IronPort-AV: E=Sophos;i="6.21,240,1763424000"; 
   d="scan'208";a="11009976"
Received: from ip-10-5-9-48.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.9.48])
  by internal-pdx-out-015.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jan 2026 09:35:20 +0000
Received: from EX19MTAUWA001.ant.amazon.com [205.251.233.236:16273]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.60.191:2525] with esmtp (Farcaster)
 id a79a62fe-dca1-4651-be5a-e5f6b63b42b4; Tue, 20 Jan 2026 09:35:20 +0000 (UTC)
X-Farcaster-Flow-ID: a79a62fe-dca1-4651-be5a-e5f6b63b42b4
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWA001.ant.amazon.com (10.250.64.217) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.35;
 Tue, 20 Jan 2026 09:35:20 +0000
Received: from 603e5f7bc1fe.amazon.com (10.37.244.13) by
 EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.35;
 Tue, 20 Jan 2026 09:35:18 +0000
From: Takashi Kozu <takkozu@amazon.com>
To: <anthony.l.nguyen@intel.com>
CC: <przemyslaw.kitszel@intel.com>, <andrew+netdev@lunn.ch>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <intel-wired-lan@lists.osuosl.org>,
	<netdev@vger.kernel.org>, <aleksandr.loktionov@intel.com>,
	<pmenzel@molgen.mpg.de>, <piotr.kwapulinski@intel.com>, <enjuk@amazon.com>,
	Takashi Kozu <takkozu@amazon.com>
Subject: [PATCH iwl-next v4 1/3] igb: prepare for RSS key get/set support
Date: Tue, 20 Jan 2026 18:34:38 +0900
Message-ID: <20260120093441.70075-6-takkozu@amazon.com>
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
X-ClientProxiedBy: EX19D036UWB004.ant.amazon.com (10.13.139.170) To
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
index b507576b28b2..a93069b761a6 100644
--- a/drivers/net/ethernet/intel/igb/igb_ethtool.c
+++ b/drivers/net/ethernet/intel/igb/igb_ethtool.c
@@ -3019,6 +3019,27 @@ static int igb_set_rxnfc(struct net_device *dev, struct ethtool_rxnfc *cmd)
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
+	struct e1000_hw *hw = &adapter->hw;
+
+	ASSERT_RTNL();
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
index dbea37269d2c..c703011b19ec 100644
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


