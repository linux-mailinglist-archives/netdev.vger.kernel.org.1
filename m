Return-Path: <netdev+bounces-243757-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AEEACA6BEF
	for <lists+netdev@lfdr.de>; Fri, 05 Dec 2025 09:44:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AEED83097BBD
	for <lists+netdev@lfdr.de>; Fri,  5 Dec 2025 08:43:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39BB631B809;
	Fri,  5 Dec 2025 08:23:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="LUILfG+9"
X-Original-To: netdev@vger.kernel.org
Received: from pdx-out-008.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-008.esa.us-west-2.outbound.mail-perimeter.amazon.com [52.42.203.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CCB3207A38
	for <netdev@vger.kernel.org>; Fri,  5 Dec 2025 08:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.42.203.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764923020; cv=none; b=HGiEtoeR8CUZ01T1KO+Qsq1Etcw06LF1IZ7OXKsJwqFqm/DpfSw8ktCxtbZ6Cv0HnyEQKfVxRYMxgYd3ARJzUFbVHELdyV7is8QLia2UBkiVCfE4K7QPu8i8ALQKxe7HQSlSZqi+77neqSNIYBe11kh7hS+2UoaqrJKNQPuDtZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764923020; c=relaxed/simple;
	bh=Ra4X6SEZ/BYkAvUTEl6a45XlB3Ln3qGYYix8iol6Q1I=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jpLODTMd9SlWa6pQddGeEuNnOFubpTVQ/aINVwrSQw/X5xhu0IPT7N3xIbqwiP4AbWzrPGBuanb7NAStMKadxYJMmifjeJO5JqadKIao8AXgSmEo0DjqTNQXh0xQLUpodx85FYOOrVFU/SVydSKW90NuIfhCnTl4rX6q4g6kN9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=LUILfG+9; arc=none smtp.client-ip=52.42.203.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1764923014; x=1796459014;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=2yxTSvuS6r89LET5K5JxIhOhcWNrXuNTxkuDEWyrKTg=;
  b=LUILfG+9KuYurP4npEUBOd8rNzPX6KmY1MK9wl8VCvu3285BNSTSDhaQ
   cJNof+4iLfwn+DsHy8mSHknHmhG4aKWeihUu9xND44nC3+GZiRmWGDwfT
   ibth85LGme2Mc1J5vwTvxIcPow7jpuTAvShMgYHh9Cc8yV2kN8NjLUsG4
   Y/XXuPRKBADmy504FPyP8fpT79BTNenxC3m74AVq2AXwPEb57WoXClWHy
   0GMKknr8NOOLbh5g8e4PN3/bvXGJ2XPS5ZKv1GK0aWf81R+HZ6e0XjoPH
   umEMe1FQoBw2/yLZ1L55NY3+5w80o4s2Dh7YxpCsY7I/cV8iLunj52vSH
   w==;
X-CSE-ConnectionGUID: vR98Ikc5Qe+WgcLO0LbK7A==
X-CSE-MsgGUID: dBno5VIRQV+Q4OlwGGXRIg==
X-IronPort-AV: E=Sophos;i="6.20,251,1758585600"; 
   d="scan'208";a="8477422"
Received: from ip-10-5-6-203.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.6.203])
  by internal-pdx-out-008.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2025 08:22:16 +0000
Received: from EX19MTAUWA002.ant.amazon.com [205.251.233.234:25793]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.51.201:2525] with esmtp (Farcaster)
 id 5db10035-a247-44f8-ae70-f4859b2a997d; Fri, 5 Dec 2025 08:22:16 +0000 (UTC)
X-Farcaster-Flow-ID: 5db10035-a247-44f8-ae70-f4859b2a997d
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.29;
 Fri, 5 Dec 2025 08:22:16 +0000
Received: from 603e5f7bc1fe.amazon.com (10.37.244.13) by
 EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.29;
 Fri, 5 Dec 2025 08:22:14 +0000
From: Takashi Kozu <takkozu@amazon.com>
To: <anthony.l.nguyen@intel.com>
CC: <przemyslaw.kitszel@intel.com>, <andrew+netdev@lunn.ch>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <intel-wired-lan@lists.osuosl.org>,
	<netdev@vger.kernel.org>, Takashi Kozu <takkozu@amazon.com>, Kohei Enju
	<enjuk@amazon.com>
Subject: [PATCH iwl-next v1 1/3] Store the RSS key inside struct igb_adapter and introduce the
Date: Fri, 5 Dec 2025 17:21:05 +0900
Message-ID: <20251205082106.4028-6-takkozu@amazon.com>
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
X-ClientProxiedBy: EX19D033UWA001.ant.amazon.com (10.13.139.103) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)

Store the RSS key inside struct igb_adapter and introduce the
igb_write_rss_key() helper function. This allows the driver to program
the E1000 registers using a persistent RSS key, instead of using a
stack-local buffer in igb_setup_mrqc().

Tested-by: Kohei Enju <enjuk@amazon.com>
Signed-off-by: Takashi Kozu <takkozu@amazon.com>
---
 drivers/net/ethernet/intel/igb/igb.h         |  3 +++
 drivers/net/ethernet/intel/igb/igb_ethtool.c | 12 ++++++++++++
 drivers/net/ethernet/intel/igb/igb_main.c    |  6 ++----
 3 files changed, 17 insertions(+), 4 deletions(-)

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
index 10e2445e0ded..8695ff28a7b8 100644
--- a/drivers/net/ethernet/intel/igb/igb_ethtool.c
+++ b/drivers/net/ethernet/intel/igb/igb_ethtool.c
@@ -3016,6 +3016,18 @@ static int igb_set_rxnfc(struct net_device *dev, struct ethtool_rxnfc *cmd)
 	return ret;
 }
 
+void igb_write_rss_key(struct igb_adapter *adapter)
+{
+	struct e1000_hw *hw = &adapter->hw;
+	u32 val;
+	int i;
+
+	for (i = 0; i < IGB_RSS_KEY_SIZE / 4; i++) {
+		val = get_unaligned_le32(&adapter->rss_key[i * 4]);
+		wr32(E1000_RSSRK(i), val);
+	}
+}
+
 static int igb_get_eee(struct net_device *netdev, struct ethtool_keee *edata)
 {
 	struct igb_adapter *adapter = netdev_priv(netdev);
diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethernet/intel/igb/igb_main.c
index 85f9589cc568..da0f550de605 100644
--- a/drivers/net/ethernet/intel/igb/igb_main.c
+++ b/drivers/net/ethernet/intel/igb/igb_main.c
@@ -4525,11 +4525,9 @@ static void igb_setup_mrqc(struct igb_adapter *adapter)
 	struct e1000_hw *hw = &adapter->hw;
 	u32 mrqc, rxcsum;
 	u32 j, num_rx_queues;
-	u32 rss_key[10];
 
-	netdev_rss_key_fill(rss_key, sizeof(rss_key));
-	for (j = 0; j < 10; j++)
-		wr32(E1000_RSSRK(j), rss_key[j]);
+	netdev_rss_key_fill(adapter->rss_key, sizeof(adapter->rss_key));
+	igb_write_rss_key(adapter);
 
 	num_rx_queues = adapter->rss_queues;
 
-- 
2.51.1


