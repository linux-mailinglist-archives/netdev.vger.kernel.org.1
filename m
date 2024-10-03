Return-Path: <netdev+bounces-131589-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 63F6C98EF5F
	for <lists+netdev@lfdr.de>; Thu,  3 Oct 2024 14:40:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E3B2CB23B03
	for <lists+netdev@lfdr.de>; Thu,  3 Oct 2024 12:40:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19E4E188589;
	Thu,  3 Oct 2024 12:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="DtfPnpLy"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D8DD186E40
	for <netdev@vger.kernel.org>; Thu,  3 Oct 2024 12:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.153.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727959199; cv=none; b=fPick7C+iQQwvQ+1MHMb7piMN5UcK1RbgiZk1bBOjCbSH93+1EIxwHrO7pdrJ5+ISxjQ4gifi8ZAFFzCXJ/ml9pI0epTSdN+TgPgSbwLtrKpMOxohCRI0kL0xGXv+wz6ie2i0f3C+yEoV6BEXgf/LsCPWV4iiommwMTYPtnMKHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727959199; c=relaxed/simple;
	bh=jCYiGVE3akMb6rtRJOBNcSkNp1kaNW9CJ2vjNNzNJgY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZhNPS9/xkLixSC8IVtcRuuiGAmujImfsYeKuRPB0pDPWJsocy1/uNkR6gWc6KTScYapqCexwFpHobPGQvtTXwU8xxzu4fpOnuWekEh21t7ZWPG7csuUwhz4KF54vVL9d4+/shDXDvtdfjfo56w2MHI4bde7eXJX2/B5ogsr1yIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=DtfPnpLy; arc=none smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4935dLZG001492;
	Thu, 3 Oct 2024 05:39:44 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=from
	:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	s2048-2021-q4; bh=/pgMby7YQzjaj9i3i5JVIUY6xOvLfZj8BkJma8ptA2M=; b=
	DtfPnpLyMGLuK6Z9YwSX7/YFYbuUaEVuQRiNd/apzM9LZYlXPMqfFlpPhOc2+Hnq
	kal2PBGOoVcK9zx/8kI7jHVhfEuQU1eL7FeQnDNBrGMpiFouvFYh3ilKcMnrBMbd
	TMzFNNH20eGEtxcGuRQBb0C5okqXwt1kx83LRPo3DcbYxn/GUtnXfP38WQDT4xfl
	KCRv3xem4hyDccv3FCpxByx/Hzk2CBs3F4fKz0jkxnWVOpOT+BhKPfWbFoObOHlm
	jb9lo4je0pwXgeJLscH+FHiYvOMdBhDdiiy7nKc5+3vRGYPuqs5xTo8luG6JTeT2
	chhhIDC2N/cpovM75AZOUQ==
Received: from mail.thefacebook.com ([163.114.134.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 42163x71an-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Thu, 03 Oct 2024 05:39:44 -0700 (PDT)
Received: from devvm4158.cln0.facebook.com (2620:10d:c085:108::150d) by
 mail.thefacebook.com (2620:10d:c08b:78::2ac9) with Microsoft SMTP Server id
 15.2.1544.11; Thu, 3 Oct 2024 12:39:41 +0000
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
Subject: [PATCH net-next v3 1/5] eth: fbnic: add software TX timestamping support
Date: Thu, 3 Oct 2024 05:39:29 -0700
Message-ID: <20241003123933.2589036-2-vadfed@meta.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241003123933.2589036-1-vadfed@meta.com>
References: <20241003123933.2589036-1-vadfed@meta.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: s2kUbn_vs5sByAVJCUeW1G6Ihfym1TWu
X-Proofpoint-ORIG-GUID: s2kUbn_vs5sByAVJCUeW1G6Ihfym1TWu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-03_06,2024-10-03_01,2024-09-30_01

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


