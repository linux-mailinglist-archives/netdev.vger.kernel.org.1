Return-Path: <netdev+bounces-133246-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F594995640
	for <lists+netdev@lfdr.de>; Tue,  8 Oct 2024 20:15:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 481A528B5D8
	for <lists+netdev@lfdr.de>; Tue,  8 Oct 2024 18:15:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C17D212D0F;
	Tue,  8 Oct 2024 18:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="gZQX9f42"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAC87212D00
	for <netdev@vger.kernel.org>; Tue,  8 Oct 2024 18:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.153.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728411307; cv=none; b=pbTm7grBBfdvRVmUR1+lIJHdkxmDh3I2/G8wog3IUPewEiGDaNdlUNp+B6KhMDosJPQ7O0wmYp/+6SZJje5RTveLctPXFILJ7M3t9QBaW1Yc6iE3vRWqmprMhpk0LnJ4yuj4ktE4obHpAsmKYxmvMKXG4QT9n2dS2KBl3Yq5aZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728411307; c=relaxed/simple;
	bh=jCYiGVE3akMb6rtRJOBNcSkNp1kaNW9CJ2vjNNzNJgY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BAa8+7jCuFkWhls31Bf3utjs3b5w6GHq/zpMQ4hNrtZjSKyqqUZfeV6RFgZr6/B9Gdy97RNUhaPbyi7sIu7EwNdaeJdUldxSDQ2j8sRxFE0YD2Zg5UMwSLB4narlwj3YLYA13tGxNpNVIhF/uFQ3ZLD607IbPbJXFBIDf6v0EQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=gZQX9f42; arc=none smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 498GcGKF023195;
	Tue, 8 Oct 2024 11:14:48 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2021-q4;
	 bh=/pgMby7YQzjaj9i3i5JVIUY6xOvLfZj8BkJma8ptA2M=; b=gZQX9f42R7X3
	UktlwXLC6JKozUCz+tagq3jvqOl+YiRVzrnDjSHfzI5PE9qezkNgacUKGth6tF3Q
	7D7BCNJgzlfu0LbN+cZqToC1qPXXWkIQWoF5Ayl9+eNyIyW8Ok4Au863pg2/BfHt
	BGuRYcMXBwf/okK7EuMvb7Xl110BtOE9kw8J7Lgp2mTqT8LzZEav/pHdr1TdCT6l
	VSK/kW9voTgQXwO+20nXogorothygXPVOlHsBtNLqBs/bXPXyoTCQKjRz2AwCyvu
	7DNwl94hqVN0Ndu2lOm/Nq6s74pE+HZfl+S2ZJN21II1mOT9YDGBPB4HoZxptG9i
	ZRwDMVfsTg==
Received: from mail.thefacebook.com ([163.114.134.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 42339s2792-3
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Tue, 08 Oct 2024 11:14:48 -0700 (PDT)
Received: from devvm4158.cln0.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c08b:78::c78f) with Microsoft SMTP Server id
 15.2.1544.11; Tue, 8 Oct 2024 18:14:45 +0000
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
Subject: [PATCH net-next v4 1/5] eth: fbnic: add software TX timestamping support
Date: Tue, 8 Oct 2024 11:14:32 -0700
Message-ID: <20241008181436.4120604-2-vadfed@meta.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241008181436.4120604-1-vadfed@meta.com>
References: <20241008181436.4120604-1-vadfed@meta.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: xqi5EsYZKU7sJB66TmgxIlOIuyXFXzwy
X-Proofpoint-ORIG-GUID: xqi5EsYZKU7sJB66TmgxIlOIuyXFXzwy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-05_03,2024-10-04_01,2024-09-30_01

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
index 6a6d7e22f1a7..8337d49bad0b 100644
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


