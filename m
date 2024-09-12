Return-Path: <netdev+bounces-127868-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CB452976EB9
	for <lists+netdev@lfdr.de>; Thu, 12 Sep 2024 18:32:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 83BF61F2133C
	for <lists+netdev@lfdr.de>; Thu, 12 Sep 2024 16:32:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 847CF1865E2;
	Thu, 12 Sep 2024 16:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="bVmQ/kuI"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E5BC7DA61
	for <netdev@vger.kernel.org>; Thu, 12 Sep 2024 16:31:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.145.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726158719; cv=none; b=jJeQ4yn5yyDc+IQWLYTSKg09Et6k6aInlZZm0KCAYlLHN6Yocfr+UXzmRM9nUw9lsc8R0H9cDRPoEDhSrWLggxT7fEDwNuVyH2abbYSSAj2Y0DB13cnRnAha5SaLc1MyQxnJAdf4HOII1OzMhAhYyM4T9bgMX17NYltzBxCT0Uc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726158719; c=relaxed/simple;
	bh=iMIlmzi1vsHuZKeX+RQKgGmm9mWBtw8NLzo8fYKKv34=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lQdc/L/W12w9xum5ym4jFSWYZ13SS94OFIuIadY0afrjh+dgOhD5pZjFJtS9O1W+MxTYWEIBjCpzW3TaDSd/X6opZXqIw2Fzmiew8zrPC/vET1oZTDIWw61VQp0nWwqymCImDNXqadQ0xxnRe4weucUPABKJ3/QcMcO2xNBPOec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=bVmQ/kuI; arc=none smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48CFJPKx003510;
	Thu, 12 Sep 2024 09:31:42 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=from
	:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	s2048-2021-q4; bh=iR/aH2OLAIi6b9/7iOP4DOqbEZkKBWq9MlSKZ9ey5gY=; b=
	bVmQ/kuIFwswkQlwOjdoibsZod88LF3fBcvpBY5jMzc9K3JQGmYEDicPU+oMVb87
	UeETh00Xm1AZJ+Cq61QV7zeRzO8xwS+QSVvUHoIUj4Qy5ol+OgUUYVsdxQ8oJEkF
	Ap7vpJsKvOpBNm8xF0MIv158mc2JdFQEj7aKxqEtCWd+4AM7BkCCbGpCuv7x0Ndi
	+6522teTnswveYhN1Of3mQvmG3NE68/Cj8r9PYwALjJrGE+AL1roxfGtxkUCY0Lu
	5fbklYthI7TZ43QNCwGnxsy3knhQD5586HF2COMGUeKMuxnGj7ptcqMXl//LpwlP
	QZjK8tXAIhCV80DUnrVl0A==
Received: from maileast.thefacebook.com ([163.114.130.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 41kr50w16h-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Thu, 12 Sep 2024 09:31:41 -0700 (PDT)
Received: from devvm4158.cln0.facebook.com (2620:10d:c0a8:1b::30) by
 mail.thefacebook.com (2620:10d:c0a9:6f::237c) with Microsoft SMTP Server id
 15.2.1544.11; Thu, 12 Sep 2024 16:31:40 +0000
From: Vadim Fedorenko <vadfed@meta.com>
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>,
        Jakub Kicinski
	<kuba@kernel.org>, David Ahern <dsahern@kernel.org>,
        Paolo Abeni
	<pabeni@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        Alexander Duyck
	<alexanderduyck@fb.com>
CC: Vadim Fedorenko <vadfed@meta.com>, <netdev@vger.kernel.org>,
        "Richard
 Cochran" <richardcochran@gmail.com>
Subject: [PATCH net-next v2 1/5] eth: fbnic: add software TX timestamping support
Date: Thu, 12 Sep 2024 09:31:19 -0700
Message-ID: <20240912163123.551882-2-vadfed@meta.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20240912163123.551882-1-vadfed@meta.com>
References: <20240912163123.551882-1-vadfed@meta.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: hAioSBP25Nfv_NvKWVg8TKO1pRyuSOQo
X-Proofpoint-ORIG-GUID: hAioSBP25Nfv_NvKWVg8TKO1pRyuSOQo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-12_05,2024-09-12_01,2024-09-02_01

Add software TX timestamping support. RX software timestamping is
implemented in the core and there is no need to provide special flag
in the driver anymore.

Signed-off-by: Vadim Fedorenko <vadfed@meta.com>
---
 drivers/net/ethernet/meta/fbnic/fbnic_ethtool.c | 11 +++++++++++
 drivers/net/ethernet/meta/fbnic/fbnic_txrx.c    |  3 +++
 2 files changed, 14 insertions(+)

diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_ethtool.c b/drivers/net/ethernet/meta/fbnic/fbnic_ethtool.c
index 5d980e178941..ffc773014e0f 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_ethtool.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_ethtool.c
@@ -6,6 +6,16 @@
 #include "fbnic_netdev.h"
 #include "fbnic_tlv.h"
 
+static int
+fbnic_get_ts_info(struct net_device *netdev,
+		  struct kernel_ethtool_ts_info *tsinfo)
+{
+	tsinfo->so_timestamping =
+		SOF_TIMESTAMPING_TX_SOFTWARE;
+
+	return 0;
+}
+
 static void
 fbnic_get_drvinfo(struct net_device *netdev, struct ethtool_drvinfo *drvinfo)
 {
@@ -66,6 +76,7 @@ fbnic_get_eth_mac_stats(struct net_device *netdev,
 
 static const struct ethtool_ops fbnic_ethtool_ops = {
 	.get_drvinfo		= fbnic_get_drvinfo,
+	.get_ts_info		= fbnic_get_ts_info,
 	.get_eth_mac_stats	= fbnic_get_eth_mac_stats,
 };
 
diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_txrx.c b/drivers/net/ethernet/meta/fbnic/fbnic_txrx.c
index 4d0406af297f..ff40879c3654 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_txrx.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_txrx.c
@@ -205,6 +205,9 @@ fbnic_tx_map(struct fbnic_ring *ring, struct sk_buff *skb, __le64 *meta)
 
 	ring->tail = tail;
 
+	/* Record SW timestamp */
+	skb_tx_timestamp(skb);
+
 	/* Verify there is room for another packet */
 	fbnic_maybe_stop_tx(skb->dev, ring, FBNIC_MAX_SKB_DESC);
 
-- 
2.43.5


