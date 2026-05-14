Return-Path: <netdev+bounces-287872-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6OK+KnWTBWoxYwIAu9opvQ
	(envelope-from <netdev+bounces-287872-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 14 May 2026 11:18:45 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F4A753FB22
	for <lists+netdev@lfdr.de>; Thu, 14 May 2026 11:18:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0F4633049E16
	for <lists+netdev@lfdr.de>; Thu, 14 May 2026 09:17:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C93C03955E0;
	Thu, 14 May 2026 09:17:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="WogtRmYk"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11B3C3955EE;
	Thu, 14 May 2026 09:17:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778750236; cv=none; b=CZtvSMnpqamzRj8bXwmZg+vt+Rx5Z1O0YBkn9r73/mmYdpFmeUB0t8CM2G9w4A7QuoyxjhufnsVo0xfIE9DaXn+Y8Pga25OWqDBPXe/GFQogfLrU3IcJrMGm8epKl/RB5dcFOkFZgFGcdIwi4QtPlZjb4a2NVIHsrj9Mvbg8O74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778750236; c=relaxed/simple;
	bh=Xs6qUETmMfjLH8Sb+T1qVwDbg2sHn9dtoxPVroexa8s=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=gYu2LNcnYcb2mlg/jIlmVQxjU6UCTO9mUNzEUAO/Ysd03N2j3qxseHl3zMyDYQK07vYhTykZIwgvg9ZWM+5WxsHYlAAGba+GYepvGJ/zpQaYRAXrQfNQB7phxtadkDbfLs/2VYYaLkUKeIZnUMh569DMq3ESulyu+tKyiq6jIAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=WogtRmYk; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64E6nPgr1649727;
	Thu, 14 May 2026 02:17:04 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pfpt0220; bh=F881zwSnwpy4hl5JyUz25dW
	nBXFhSEBX3G6SAxsFeuA=; b=WogtRmYkS+G48PIGB0k2dJHfZmkQHcu0CZVGKk+
	MPO6HBQsOzKVFSQNV3qeolQhTGNc4cMRclGn3QEgbjDITvi8td5e80UodtQ5fhkt
	JDjxppM/TNOSYD0Dg1FJp1f/PR/PPUDZul33k67TAoZgdjPs/bz3bQqww9QSIUTa
	jO1ooTeeLqosN7V28rAF5wypXpF9Mdg6ksxXIogxsoG8j8yeDHR4bL2Lv782eqr2
	esLouxi8s4Q2P4rcPa0qbAyAP413C7lZGapshSPLqetkaOuZULUVILkPWwHD2Av1
	ATUqYURvvwIkWofXmN0IHxygmdsv2PtY1j9E9QchoIaAeRg==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4e4xg121ct-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 14 May 2026 02:17:04 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 14 May 2026 02:17:03 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Thu, 14 May 2026 02:17:03 -0700
Received: from hyd1vellox1.032marvell.com032caveonetworks.com (unknown [10.29.37.43])
	by maili.marvell.com (Postfix) with ESMTP id 9E9815B6938;
	Thu, 14 May 2026 02:16:59 -0700 (PDT)
From: Anshumali Gaur <agaur@marvell.com>
To: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <gakula@marvell.com>,
        <hkelam@marvell.com>, <sbhatta@marvell.com>, <sgoutham@marvell.com>,
        <bbhushan2@marvell.com>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: Anshumali Gaur <agaur@marvell.com>
Subject: [PATCH net-next v4] octeontx2-pf: Retain ethtool stats across interface down/up.
Date: Thu, 14 May 2026 14:46:34 +0530
Message-ID: <20260514091634.1611537-1-agaur@marvell.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=B92JFutM c=1 sm=1 tr=0 ts=6a059310 cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=QXcCYyLzdtTjyudCfB6f:22 a=M5GUcnROAAAA:8 a=M6VrSeGAqLfUd1eRDhoA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-ORIG-GUID: UU5HRWFUFH3B8dbAijIv6PiDF1CGLMgO
X-Proofpoint-GUID: UU5HRWFUFH3B8dbAijIv6PiDF1CGLMgO
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE0MDA5MSBTYWx0ZWRfX8TnGul69gQDg
 oyI2/zlYP3AT/jAEAEjUd2WQcdvkrvYycEOmUGLXzhB34R9zcxvKMwCRdVylFRTIS38VjL9eSQ2
 ROrbmKcLNeYulDjVaYJeogp+Y1KWOK20Y5NtxgPYizDFNrK+h1+EVWIbj/bo0L3Y5LJdnw6NVk3
 mFX7mwrqaI6IgXG9dlfy7SQT1hI2xx7BWbKNXYCKHF8SXi/wm6XAdweuVXX6/B6tlqaMrCfKa7G
 u5qRsp7wua5pAkrROzmuC/qC7FlxHq3Gb7FsZV5oLp3xueIaOZhx6imv1mexaUeZKBSOd4rwhvT
 0z/h4ens2+3/JsmghoRftIVF8oI7gLiC8ykerhHHbmwipAZETSOrHNjQDMF0E9XtcYg6Ysorb/6
 72Ra5ZtGZQGPY0cG+FCIzNc+4WL38axlkjKz3MXET+kyFMZxWSw5pUuIExEgrxj8i8hcHoE7eYO
 sVX1A7fMqbPiXjZN5nw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-14_02,2026-05-13_01,2025-10-01_01
X-Rspamd-Queue-Id: 3F4A753FB22
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[marvell.com,none];
	R_DKIM_ALLOW(-0.20)[marvell.com:s=pfpt0220];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	TAGGED_FROM(0.00)[bounces-287872-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[agaur@marvell.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[marvell.com:+];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.998];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Action: no action

Currently the hardware counters reset when the interface is
brought down, causing stats visible to userspace to drop to zero.
Save the accumulated stats before bringing the interface down
so they persist across routine down/up cycles.

Signed-off-by: Anshumali Gaur <agaur@marvell.com>
---
v4:
  - Move stats accumulation after disabling tx/rx (Dragos)
  - Fetch latest HW counters before accumulating in otx2_stop()
v3:
  - Code format according to kernel coding style
  - Reword commit message
v2:
  - Fix subject prefix to target net-next
 .../marvell/octeontx2/nic/otx2_common.c       | 20 +++++++-------
 .../marvell/octeontx2/nic/otx2_common.h       |  1 +
 .../ethernet/marvell/octeontx2/nic/otx2_pf.c  | 26 ++++++++++++++++---
 3 files changed, 35 insertions(+), 12 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c
index 971fcab1c248..0ffcc613a4b2 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c
@@ -139,19 +139,21 @@ void otx2_get_stats64(struct net_device *netdev,
 		      struct rtnl_link_stats64 *stats)
 {
 	struct otx2_nic *pfvf = netdev_priv(netdev);
-	struct otx2_dev_stats *dev_stats;
+	struct otx2_dev_stats *dev_stats, *old_stats;
 
 	otx2_get_dev_stats(pfvf);
 
 	dev_stats = &pfvf->hw.dev_stats;
-	stats->rx_bytes = dev_stats->rx_bytes;
-	stats->rx_packets = dev_stats->rx_frames;
-	stats->rx_dropped = dev_stats->rx_drops;
-	stats->multicast = dev_stats->rx_mcast_frames;
-
-	stats->tx_bytes = dev_stats->tx_bytes;
-	stats->tx_packets = dev_stats->tx_frames;
-	stats->tx_dropped = dev_stats->tx_drops;
+	old_stats = &pfvf->hw.old_stats;
+
+	stats->rx_bytes = old_stats->rx_bytes + dev_stats->rx_bytes;
+	stats->rx_packets = old_stats->rx_frames + dev_stats->rx_frames;
+	stats->rx_dropped = old_stats->rx_drops + dev_stats->rx_drops;
+	stats->multicast = old_stats->rx_mcast_frames + dev_stats->rx_mcast_frames;
+
+	stats->tx_bytes = old_stats->tx_bytes + dev_stats->tx_bytes;
+	stats->tx_packets = old_stats->tx_frames + dev_stats->tx_frames;
+	stats->tx_dropped = old_stats->tx_drops + dev_stats->tx_drops;
 }
 EXPORT_SYMBOL(otx2_get_stats64);
 
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h
index eecee612b7b2..ad65aa19b80d 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h
@@ -255,6 +255,7 @@ struct otx2_hw {
 
 	/* Stats */
 	struct otx2_dev_stats	dev_stats;
+	struct otx2_dev_stats	old_stats;
 	struct otx2_drv_stats	drv_stats;
 	u64			cgx_rx_stats[CGX_RX_STATS_COUNT];
 	u64			cgx_tx_stats[CGX_TX_STATS_COUNT];
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
index ee623476e5ff..21fd1dd4d755 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
@@ -2154,6 +2154,8 @@ EXPORT_SYMBOL(otx2_open);
 int otx2_stop(struct net_device *netdev)
 {
 	struct otx2_nic *pf = netdev_priv(netdev);
+	struct otx2_dev_stats *old_stats = &pf->hw.old_stats;
+	struct otx2_dev_stats *dev = &pf->hw.dev_stats;
 	struct otx2_cq_poll *cq_poll = NULL;
 	struct otx2_qset *qset = &pf->qset;
 	int qidx, vec, wrk;
@@ -2162,6 +2164,27 @@ int otx2_stop(struct net_device *netdev)
 	if (pf->flags & OTX2_FLAG_INTF_DOWN)
 		return 0;
 
+	/* First stop packet Rx/Tx */
+	otx2_rxtx_enable(pf, false);
+
+	/* Read final HW counters and accumulate */
+	otx2_get_dev_stats(pf);
+
+	/* Accumulate old stats */
+	old_stats->rx_bytes     += dev->rx_bytes;
+	old_stats->rx_drops     += dev->rx_drops;
+	old_stats->rx_bcast_frames      += dev->rx_bcast_frames;
+	old_stats->rx_mcast_frames      += dev->rx_mcast_frames;
+	old_stats->rx_ucast_frames      += dev->rx_ucast_frames;
+	old_stats->rx_frames            += dev->rx_frames;
+
+	old_stats->tx_bytes             += dev->tx_bytes;
+	old_stats->tx_drops             += dev->tx_drops;
+	old_stats->tx_bcast_frames      += dev->tx_bcast_frames;
+	old_stats->tx_mcast_frames      += dev->tx_mcast_frames;
+	old_stats->tx_ucast_frames      += dev->tx_ucast_frames;
+	old_stats->tx_frames            += dev->tx_frames;
+
 	netif_carrier_off(netdev);
 	netif_tx_stop_all_queues(netdev);
 
@@ -2169,9 +2192,6 @@ int otx2_stop(struct net_device *netdev)
 	/* 'intf_down' may be checked on any cpu */
 	smp_wmb();
 
-	/* First stop packet Rx/Tx */
-	otx2_rxtx_enable(pf, false);
-
 	/* Clear RSS enable flag */
 	pf->hw.rss_info.enable = false;
 
-- 
2.25.1


