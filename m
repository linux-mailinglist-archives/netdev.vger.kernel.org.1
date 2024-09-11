Return-Path: <netdev+bounces-127349-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F3549752C0
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 14:45:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BD0531F24250
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 12:45:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F37018C344;
	Wed, 11 Sep 2024 12:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="NLYlI4iv"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD4F4EC4
	for <netdev@vger.kernel.org>; Wed, 11 Sep 2024 12:45:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.153.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726058734; cv=none; b=TtQUD9kdyhx5M1oqnHT8REkbZPTM7OPWvZRKxct/pI8uoyj4Bpa3z21xPzQA+IOQwUI13PhR+7xGJRwYeZw6IyV5nT2n1BECg0maKs0oad2fu3Qx6PyDAO1IQhpM4JCnM6y4IiOo+CBfDFENVhULIzO/WVQ3BRHCZJ8jDxncbQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726058734; c=relaxed/simple;
	bh=BwvC9EoHH3mFrO4yiPg9DNLEOWAaafsMnIhKZqMMFZg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cGeLKRB1WPaEKCpvgn4qrKcPCGGZvnG59VQHKpS5JrhpLpSsV2LAVhSUa+nwQL3jPftVF+ietLkZ0lsMDvmCRlnsLY9offCLE//AyUUuD3SCLsCV15KKBjMYpTzmX/SGZ0yHqiHnjogu9jtOvRfj46NIXG59dTdacrL+cTeSTEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=NLYlI4iv; arc=none smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48BCCF8f009245;
	Wed, 11 Sep 2024 05:45:25 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=from
	:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	s2048-2021-q4; bh=okAbfjXG0G0MLYW2Dvp8O5x8SuwnzyFEjhDrzBZmpgg=; b=
	NLYlI4iviaJ1mApT6xgB/RFeUIfYHhTPa5Bsv9mNjBVW/b95sujcEpGJL3wlEGZa
	WgpHKLoli6B/pBDa17jJOqgb2B5UVvkHLsghClQdUeI61woogmNeiU7oZOCOMVR6
	U8oSKqX8XknZkcX35bCs9wW3gv/Mz3COuV4dbuuAf/Pu/34kpfAk20p0Qf5Sza/X
	NhUtNRbTq6oWh0NyZSA7k3PvVXyDXLxXHpqR1K2mPzjgL0As64CUjNqIJ8Aq7fxC
	6lQj5mTcccYHjf2SW0/fsFaCBjfknBzcn9iI6i4RRfSG3KuhMtL+gZfec+kVQsuY
	M6/IBzU9p7+l+nsb7Ijq9A==
Received: from maileast.thefacebook.com ([163.114.130.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 41jh2eh7vp-4
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Wed, 11 Sep 2024 05:45:25 -0700 (PDT)
Received: from devvm4158.cln0.facebook.com (2620:10d:c0a8:1c::11) by
 mail.thefacebook.com (2620:10d:c0a9:6f::237c) with Microsoft SMTP Server id
 15.2.1544.11; Wed, 11 Sep 2024 12:45:22 +0000
From: Vadim Fedorenko <vadfed@meta.com>
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>,
        Jakub Kicinski
	<kuba@kernel.org>, David Ahern <dsahern@kernel.org>,
        Paolo Abeni
	<pabeni@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        Alexander Duyck
	<alexanderduyck@fb.com>
CC: Vadim Fedorenko <vadfed@meta.com>, <netdev@vger.kernel.org>
Subject: [PATCH net-next 1/5] eth: fbnic: add software TX timestamping support
Date: Wed, 11 Sep 2024 05:45:09 -0700
Message-ID: <20240911124513.2691688-2-vadfed@meta.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20240911124513.2691688-1-vadfed@meta.com>
References: <20240911124513.2691688-1-vadfed@meta.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: -6ISHNd2Eix3-CeSXnAWSEPIGVfDylB9
X-Proofpoint-ORIG-GUID: -6ISHNd2Eix3-CeSXnAWSEPIGVfDylB9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-10_12,2024-09-09_02,2024-09-02_01

Add software TX timestamping support. RX software timestamping is
implemented in the core and there is no need to provide special flag
in the driver anymore.

Signed-off-by: Vadim Fedorenko <vadfed@meta.com>
---
 drivers/net/ethernet/meta/fbnic/fbnic_ethtool.c | 11 +++++++++++
 drivers/net/ethernet/meta/fbnic/fbnic_txrx.c    |  3 +++
 2 files changed, 14 insertions(+)

diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_ethtool.c b/drivers/net/ethernet/meta/fbnic/fbnic_ethtool.c
index 5d980e178941..40d294d3e7a7 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_ethtool.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_ethtool.c
@@ -6,6 +6,16 @@
 #include "fbnic_netdev.h"
 #include "fbnic_tlv.h"
 
+static int
+fbnic_get_ts_info(struct net_device *netdev,
+		  struct kernel_ethtool_ts_info *tsinfo)
+{
+	tsinfo->so_timstamping =
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
index 4d0406af297f..c10339c4e5a0 100644
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


