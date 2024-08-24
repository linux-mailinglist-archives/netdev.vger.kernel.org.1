Return-Path: <netdev+bounces-121551-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B1DB95D9F6
	for <lists+netdev@lfdr.de>; Sat, 24 Aug 2024 01:55:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1028F1F22E7B
	for <lists+netdev@lfdr.de>; Fri, 23 Aug 2024 23:55:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23A281C945B;
	Fri, 23 Aug 2024 23:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cisco.com header.i=@cisco.com header.b="g+BF3MOK"
X-Original-To: netdev@vger.kernel.org
Received: from rcdn-iport-3.cisco.com (rcdn-iport-3.cisco.com [173.37.86.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5916119342B
	for <netdev@vger.kernel.org>; Fri, 23 Aug 2024 23:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.37.86.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724457342; cv=none; b=EV4Kih8rOjjfNpDDfE9lTi6j4RnX4n/B1s0V7ubmi+whgzymBgjVxHfEntse7H838weRCgr+xN3JK7zDpS1Rdz/LpT+QA92JjJYx6J8j9pqo7LHIu9Q9A/ba320iCeTT47DaXEzaJwmX0WFXs+Y2nq1ej0N8LpddHqZ0onyGScw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724457342; c=relaxed/simple;
	bh=Pyd1BR1a8QZ7iwzFBlWH4lLtIyHW5CkMk+UJusseNvg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Fw1J0HsFo6P86fprC3Mn2j3yP2Ao7xQsDKkOFFCKxL4eyDiJFCILOxj4qkBqZvlMa+ohI2zhJRsF1cDbbS+Qc6nKuK6pnYhMkY7nizXMiG79hYGew850Q0Fv3fRBTo/nQm7p79FtnWE7RIZlQMDUb9dkuka6utuIc7T2+5aPCqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com; spf=pass smtp.mailfrom=cisco.com; dkim=pass (1024-bit key) header.d=cisco.com header.i=@cisco.com header.b=g+BF3MOK; arc=none smtp.client-ip=173.37.86.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cisco.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=cisco.com; i=@cisco.com; l=3096; q=dns/txt; s=iport;
  t=1724457340; x=1725666940;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=VrujH7lRyddl8v4ugr1NLQbQyNOSxI8yQ+N02f4zri4=;
  b=g+BF3MOKah4lHTr3g+qG4EphTEUjrs8Ey3zyF0mFweYGzfIrLbQk6S/7
   lQX8dtyVJncPI7fmgUBzDRxrAJLtualJv8/9rNT1JR6hy3VH4fQUtryiy
   asxtibJ2tQm8e614tH1+VNYJ/0ZeJaBGZUPPYbh6ybwugmmJ97M1Yu7WI
   w=;
X-CSE-ConnectionGUID: 6zySnez+Ry6A4WlS7U+z2w==
X-CSE-MsgGUID: yTSrs6bIREiYDFSTXxq2vA==
X-IronPort-AV: E=Sophos;i="6.10,171,1719878400"; 
   d="scan'208";a="250301980"
Received: from rcdn-core-6.cisco.com ([173.37.93.157])
  by rcdn-iport-3.cisco.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2024 23:54:33 +0000
Received: from cisco.com (savbu-usnic-a.cisco.com [10.193.184.48])
	by rcdn-core-6.cisco.com (8.15.2/8.15.2) with ESMTP id 47NNsXe7027167;
	Fri, 23 Aug 2024 23:54:33 GMT
Received: by cisco.com (Postfix, from userid 412739)
	id 01C8220F2003; Fri, 23 Aug 2024 16:54:32 -0700 (PDT)
From: Nelson Escobar <neescoba@cisco.com>
To: netdev@vger.kernel.org
Cc: satishkh@cisco.com, johndale@cisco.com,
        Nelson Escobar <neescoba@cisco.com>
Subject: [PATCH net-next 1/2] enic: Use macro instead of static const variables for array sizes
Date: Fri, 23 Aug 2024 16:54:00 -0700
Message-Id: <20240823235401.29996-2-neescoba@cisco.com>
X-Mailer: git-send-email 2.35.2
In-Reply-To: <20240823235401.29996-1-neescoba@cisco.com>
References: <20240823235401.29996-1-neescoba@cisco.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Outbound-SMTP-Client: 10.193.184.48, savbu-usnic-a.cisco.com
X-Outbound-Node: rcdn-core-6.cisco.com

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


