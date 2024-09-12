Return-Path: <netdev+bounces-127623-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 79466975E2B
	for <lists+netdev@lfdr.de>; Thu, 12 Sep 2024 02:52:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2F5731F23191
	for <lists+netdev@lfdr.de>; Thu, 12 Sep 2024 00:52:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 386969476;
	Thu, 12 Sep 2024 00:52:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cisco.com header.i=@cisco.com header.b="CNogH/WO"
X-Original-To: netdev@vger.kernel.org
Received: from rcdn-iport-4.cisco.com (rcdn-iport-4.cisco.com [173.37.86.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74ED4163
	for <netdev@vger.kernel.org>; Thu, 12 Sep 2024 00:52:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.37.86.75
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726102354; cv=none; b=TAqkKQTKTgOiTOz3FtXwjMQXZHH5JONOfrsCj/ZM7xJAzhb3YBcitR/Ctmc/bFSzPlZwLC+Nwf0MC+ezUxGHB4neR1UfOUMfb/hDWZi5jw87XgaTVaNGvI6kLfwDIq0VOUgt1FIbzUJqDC/jK1MuGn4n9doRHZxfl88H5gMdlFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726102354; c=relaxed/simple;
	bh=Pyd1BR1a8QZ7iwzFBlWH4lLtIyHW5CkMk+UJusseNvg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KEkOZ2Nv6PM9oYXDBOAwGiwQuTAh3KtxwkKw2yBYrGzwG6SB/foQp2WK6MQ2JSQG9WNIdBK1qby1yIIaokAVroCxueroFrsKQ+NJn8Mk1T+hMfXaizrX2GNbw4rKv+2/oeQR5zceBK8OSZFg0Rl0mnNZFJ7mmjZsqYbqBxyMQ1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com; spf=pass smtp.mailfrom=cisco.com; dkim=pass (1024-bit key) header.d=cisco.com header.i=@cisco.com header.b=CNogH/WO; arc=none smtp.client-ip=173.37.86.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cisco.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=cisco.com; i=@cisco.com; l=3096; q=dns/txt; s=iport;
  t=1726102352; x=1727311952;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=VrujH7lRyddl8v4ugr1NLQbQyNOSxI8yQ+N02f4zri4=;
  b=CNogH/WOWMkUuR5mTd27BCEgL8ajD8H9HcR0KfjYAaCFE2CQpVD91Hup
   RWoYvEu/oph9XO5oG/df+H9M0cFMtWKyhHEaBwpnVXpM7cWzex1QP7qge
   4nxu8Oz04tfIfPhXCawOShVus2A0GA/I2wuAk0a5u2aji3RjTyH5sp0Q9
   Y=;
X-CSE-ConnectionGUID: VfJCdaM3TTOVADcyAFQZEg==
X-CSE-MsgGUID: 4INu0Ga0TNefTMgk8oTWyg==
X-IronPort-AV: E=Sophos;i="6.10,221,1719878400"; 
   d="scan'208";a="259579862"
Received: from rcdn-core-8.cisco.com ([173.37.93.144])
  by rcdn-iport-4.cisco.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2024 00:51:24 +0000
Received: from cisco.com (savbu-usnic-a.cisco.com [10.193.184.48])
	by rcdn-core-8.cisco.com (8.15.2/8.15.2) with ESMTP id 48C0pO0x031970;
	Thu, 12 Sep 2024 00:51:24 GMT
Received: by cisco.com (Postfix, from userid 412739)
	id 497A520F2003; Wed, 11 Sep 2024 17:51:24 -0700 (PDT)
From: Nelson Escobar <neescoba@cisco.com>
To: netdev@vger.kernel.org
Cc: satishkh@cisco.com, johndale@cisco.com,
        Nelson Escobar <neescoba@cisco.com>
Subject: [PATCH net-next v3 1/4] enic: Use macro instead of static const variables for array sizes
Date: Wed, 11 Sep 2024 17:50:36 -0700
Message-Id: <20240912005039.10797-2-neescoba@cisco.com>
X-Mailer: git-send-email 2.35.2
In-Reply-To: <20240912005039.10797-1-neescoba@cisco.com>
References: <20240912005039.10797-1-neescoba@cisco.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Outbound-SMTP-Client: 10.193.184.48, savbu-usnic-a.cisco.com
X-Outbound-Node: rcdn-core-8.cisco.com

In enic_ethtool.c there is no need to use static const variables to store
array sizes when a macro can be used instead.

Signed-off-by: Nelson Escobar <neescoba@cisco.com>
Signed-off-by: John Daley <johndale@cisco.com>
Signed-off-by: Satish Kharat <satishkh@cisco.com>
---
 .../net/ethernet/cisco/enic/enic_ethtool.c    | 23 +++++++++++--------
 1 file changed, 13 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/cisco/enic/enic_ethtool.c b/drivers/net/ethernet/cisco/enic/enic_ethtool.c
index f2f1055880b2..b71146209334 100644
--- a/drivers/net/ethernet/cisco/enic/enic_ethtool.c
+++ b/drivers/net/ethernet/cisco/enic/enic_ethtool.c
@@ -46,6 +46,8 @@ static const struct enic_stat enic_tx_stats[] = {
 	ENIC_TX_STAT(tx_tso),
 };
 
+#define NUM_ENIC_TX_STATS	ARRAY_SIZE(enic_tx_stats)
+
 static const struct enic_stat enic_rx_stats[] = {
 	ENIC_RX_STAT(rx_frames_ok),
 	ENIC_RX_STAT(rx_frames_total),
@@ -70,13 +72,13 @@ static const struct enic_stat enic_rx_stats[] = {
 	ENIC_RX_STAT(rx_frames_to_max),
 };
 
+#define NUM_ENIC_RX_STATS	ARRAY_SIZE(enic_rx_stats)
+
 static const struct enic_stat enic_gen_stats[] = {
 	ENIC_GEN_STAT(dma_map_error),
 };
 
-static const unsigned int enic_n_tx_stats = ARRAY_SIZE(enic_tx_stats);
-static const unsigned int enic_n_rx_stats = ARRAY_SIZE(enic_rx_stats);
-static const unsigned int enic_n_gen_stats = ARRAY_SIZE(enic_gen_stats);
+#define NUM_ENIC_GEN_STATS	ARRAY_SIZE(enic_gen_stats)
 
 static void enic_intr_coal_set_rx(struct enic *enic, u32 timer)
 {
@@ -145,15 +147,15 @@ static void enic_get_strings(struct net_device *netdev, u32 stringset,
 
 	switch (stringset) {
 	case ETH_SS_STATS:
-		for (i = 0; i < enic_n_tx_stats; i++) {
+		for (i = 0; i < NUM_ENIC_TX_STATS; i++) {
 			memcpy(data, enic_tx_stats[i].name, ETH_GSTRING_LEN);
 			data += ETH_GSTRING_LEN;
 		}
-		for (i = 0; i < enic_n_rx_stats; i++) {
+		for (i = 0; i < NUM_ENIC_RX_STATS; i++) {
 			memcpy(data, enic_rx_stats[i].name, ETH_GSTRING_LEN);
 			data += ETH_GSTRING_LEN;
 		}
-		for (i = 0; i < enic_n_gen_stats; i++) {
+		for (i = 0; i < NUM_ENIC_GEN_STATS; i++) {
 			memcpy(data, enic_gen_stats[i].name, ETH_GSTRING_LEN);
 			data += ETH_GSTRING_LEN;
 		}
@@ -244,7 +246,8 @@ static int enic_get_sset_count(struct net_device *netdev, int sset)
 {
 	switch (sset) {
 	case ETH_SS_STATS:
-		return enic_n_tx_stats + enic_n_rx_stats + enic_n_gen_stats;
+		return NUM_ENIC_TX_STATS + NUM_ENIC_RX_STATS +
+			NUM_ENIC_GEN_STATS;
 	default:
 		return -EOPNOTSUPP;
 	}
@@ -266,11 +269,11 @@ static void enic_get_ethtool_stats(struct net_device *netdev,
 	if (err == -ENOMEM)
 		return;
 
-	for (i = 0; i < enic_n_tx_stats; i++)
+	for (i = 0; i < NUM_ENIC_TX_STATS; i++)
 		*(data++) = ((u64 *)&vstats->tx)[enic_tx_stats[i].index];
-	for (i = 0; i < enic_n_rx_stats; i++)
+	for (i = 0; i < NUM_ENIC_RX_STATS; i++)
 		*(data++) = ((u64 *)&vstats->rx)[enic_rx_stats[i].index];
-	for (i = 0; i < enic_n_gen_stats; i++)
+	for (i = 0; i < NUM_ENIC_GEN_STATS; i++)
 		*(data++) = ((u64 *)&enic->gen_stats)[enic_gen_stats[i].index];
 }
 
-- 
2.35.2


