Return-Path: <netdev+bounces-213921-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D7E1B27552
	for <lists+netdev@lfdr.de>; Fri, 15 Aug 2025 04:07:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E5873166609
	for <lists+netdev@lfdr.de>; Fri, 15 Aug 2025 02:03:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F37F32957CD;
	Fri, 15 Aug 2025 01:58:32 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from baidu.com (mx24.baidu.com [111.206.215.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFA352951A0;
	Fri, 15 Aug 2025 01:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=111.206.215.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755223112; cv=none; b=rDo6StjOF9wn7ikfrSgTM79DYwaraDt5UTU4FAu5ySXSIwdp/acB80T4GPa9LTRdUKzIGIIYZoSiuxKrMLNjuk+b65xDsWThPDNvVA32TSNOI0uhWDoMjopuCncpW6pQx74JEGZAx+eXSLfnPrRTWuMEjpOn8RAsI4+5uk5iaag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755223112; c=relaxed/simple;
	bh=Hq7PmO/kPSl7BVcZCHFImQ6aYZBnb/NFt/FZT31ElCA=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=IoZTFkYYFp67U+MNtAToTxRPzeUPbcbEVa5fvjd/uo3kHz9KuDp61MSqsYVgZifsp/cBDMeOBnQzBfzAf6oacpc03+cuHHqB8fcR//b3cDExTvk9LA8sivnNgLTXM95+c3Q/L/XBPxzDG39Xu3gPqUnyNfEqJ6V3Ic1yGANnXbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com; spf=pass smtp.mailfrom=baidu.com; arc=none smtp.client-ip=111.206.215.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baidu.com
From: lirongqing <lirongqing@baidu.com>
To: <kuba@kernel.org>, <horms@kernel.org>, <andrew+netdev@lunn.ch>,
	<davem@davemloft.net>, <edumazet@google.com>, <pabeni@redhat.com>,
	<lirongqing@baidu.com>, <vladimir.oltean@nxp.com>,
	<florian.fainelli@broadcom.com>, <julian@outer-limits.org>,
	<csander@purestorage.com>, <oss-drivers@corigine.com>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH][net-next] eth: nfp: Remove u64_stats_update_begin()/end() for stats fetch
Date: Fri, 15 Aug 2025 09:56:19 +0800
Message-ID: <20250815015619.2713-1-lirongqing@baidu.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: bjkjy-exc4.internal.baidu.com (172.31.50.48) To
 bjkjy-exc3.internal.baidu.com (172.31.50.47)
X-FEAS-Client-IP: 172.31.50.47
X-FE-Policy-ID: 52:10:53:SYSTEM

From: Li RongQing <lirongqing@baidu.com>

This place is fetching the stats, u64_stats_update_begin()/end()
should not be used, and the fetcher of stats is in the same
context as the updater of the stats, so don't need any protection

Signed-off-by: Li RongQing <lirongqing@baidu.com>
---
 drivers/net/ethernet/netronome/nfp/nfd3/dp.c | 16 ++++------------
 drivers/net/ethernet/netronome/nfp/nfdk/dp.c | 16 ++++------------
 2 files changed, 8 insertions(+), 24 deletions(-)

diff --git a/drivers/net/ethernet/netronome/nfp/nfd3/dp.c b/drivers/net/ethernet/netronome/nfp/nfd3/dp.c
index 08086eb..91a2279 100644
--- a/drivers/net/ethernet/netronome/nfp/nfd3/dp.c
+++ b/drivers/net/ethernet/netronome/nfp/nfd3/dp.c
@@ -1169,14 +1169,10 @@ int nfp_nfd3_poll(struct napi_struct *napi, int budget)
 
 	if (r_vec->nfp_net->rx_coalesce_adapt_on && r_vec->rx_ring) {
 		struct dim_sample dim_sample = {};
-		unsigned int start;
 		u64 pkts, bytes;
 
-		do {
-			start = u64_stats_fetch_begin(&r_vec->rx_sync);
-			pkts = r_vec->rx_pkts;
-			bytes = r_vec->rx_bytes;
-		} while (u64_stats_fetch_retry(&r_vec->rx_sync, start));
+		pkts = r_vec->rx_pkts;
+		bytes = r_vec->rx_bytes;
 
 		dim_update_sample(r_vec->event_ctr, pkts, bytes, &dim_sample);
 		net_dim(&r_vec->rx_dim, &dim_sample);
@@ -1184,14 +1180,10 @@ int nfp_nfd3_poll(struct napi_struct *napi, int budget)
 
 	if (r_vec->nfp_net->tx_coalesce_adapt_on && r_vec->tx_ring) {
 		struct dim_sample dim_sample = {};
-		unsigned int start;
 		u64 pkts, bytes;
 
-		do {
-			start = u64_stats_fetch_begin(&r_vec->tx_sync);
-			pkts = r_vec->tx_pkts;
-			bytes = r_vec->tx_bytes;
-		} while (u64_stats_fetch_retry(&r_vec->tx_sync, start));
+		pkts = r_vec->tx_pkts;
+		bytes = r_vec->tx_bytes;
 
 		dim_update_sample(r_vec->event_ctr, pkts, bytes, &dim_sample);
 		net_dim(&r_vec->tx_dim, &dim_sample);
diff --git a/drivers/net/ethernet/netronome/nfp/nfdk/dp.c b/drivers/net/ethernet/netronome/nfp/nfdk/dp.c
index ab3cd06..ee0db3d 100644
--- a/drivers/net/ethernet/netronome/nfp/nfdk/dp.c
+++ b/drivers/net/ethernet/netronome/nfp/nfdk/dp.c
@@ -1279,14 +1279,10 @@ int nfp_nfdk_poll(struct napi_struct *napi, int budget)
 
 	if (r_vec->nfp_net->rx_coalesce_adapt_on && r_vec->rx_ring) {
 		struct dim_sample dim_sample = {};
-		unsigned int start;
 		u64 pkts, bytes;
 
-		do {
-			start = u64_stats_fetch_begin(&r_vec->rx_sync);
-			pkts = r_vec->rx_pkts;
-			bytes = r_vec->rx_bytes;
-		} while (u64_stats_fetch_retry(&r_vec->rx_sync, start));
+		pkts = r_vec->rx_pkts;
+		bytes = r_vec->rx_bytes;
 
 		dim_update_sample(r_vec->event_ctr, pkts, bytes, &dim_sample);
 		net_dim(&r_vec->rx_dim, &dim_sample);
@@ -1294,14 +1290,10 @@ int nfp_nfdk_poll(struct napi_struct *napi, int budget)
 
 	if (r_vec->nfp_net->tx_coalesce_adapt_on && r_vec->tx_ring) {
 		struct dim_sample dim_sample = {};
-		unsigned int start;
 		u64 pkts, bytes;
 
-		do {
-			start = u64_stats_fetch_begin(&r_vec->tx_sync);
-			pkts = r_vec->tx_pkts;
-			bytes = r_vec->tx_bytes;
-		} while (u64_stats_fetch_retry(&r_vec->tx_sync, start));
+		pkts = r_vec->tx_pkts;
+		bytes = r_vec->tx_bytes;
 
 		dim_update_sample(r_vec->event_ctr, pkts, bytes, &dim_sample);
 		net_dim(&r_vec->tx_dim, &dim_sample);
-- 
2.9.4


