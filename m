Return-Path: <netdev+bounces-225544-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 37C05B954B1
	for <lists+netdev@lfdr.de>; Tue, 23 Sep 2025 11:42:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DD9101906ABB
	for <lists+netdev@lfdr.de>; Tue, 23 Sep 2025 09:42:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C48A320CB6;
	Tue, 23 Sep 2025 09:41:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="KiylzkH9"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC135320A1F;
	Tue, 23 Sep 2025 09:41:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758620508; cv=none; b=AKOHMRZq80X9AEFyiVFf/t3RZEWT6G+IoPezD2z401zQ7nJ61xw+ZGIpCkHztytEqF96yOZllKAJSmcMx+RedM94TtMcGvyxANSTfPItP/zWSSCUnsFStUqHWHmEibjMLDABYHb4MLiD1bOuquRl7ymg5Fy5yHdPfllko1zE/DY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758620508; c=relaxed/simple;
	bh=GsnPxTn+x4DSSdnvo6ORja4Dj3Jto43CHQPs5k23NpY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=K02EDqXZhFA66ltBs8P70GM2wEgOTLRLlfvtm0fdcxMdNmM6SNx40r0QfkXP5eB6YsH/yaK2H3d96Ii/Dp4NVVYqgw+fIO20lorycYbdxu4F5O3llg9uVWqhhXdJl7MBGU4//l992ZbEzasAGCSunLhMBXY9tHyDSRIrbbiGjEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=KiylzkH9; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58ML2wPG012939;
	Tue, 23 Sep 2025 02:41:26 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pfpt0220; bh=A
	pHvNDSxieYbzSY7gu9AdrSQmWvjJrWk+/Uceyuye5Q=; b=KiylzkH9bXxDL07XJ
	kpJNJf31BQKb1qy91Bjfk9WfWsoLvEoner9+Ab0OUS1U9+HmPtfAmCQlszNpdUP6
	/fTo5rE6716zYVFOycS9ukaNl0k1OIo42dJOzyvVS4y5nTerofdFjQKq9PNegm5n
	mLyDSx5idr77N9V2B3MH6DN8AEEXVtMzN1BRKLVQHqeoKHJQoetQ2twVeRJkK7e3
	wLCbYjkBebKkysfmT6gVR0LOME5h6tPt8PQGlfIdRoxEl63jrOHi2ntJxycAKnyE
	kSTu/BjO0YRENo8nGvwEaRNPA3G0NTk/0bquJlCSQrk25MOeA6D4R5N0uyFolge5
	0hHkA==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 499ushwmfs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 23 Sep 2025 02:41:26 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 23 Sep 2025 02:41:24 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Tue, 23 Sep 2025 02:41:24 -0700
Received: from sburla-PowerEdge-T630.sclab.marvell.com (unknown [10.106.27.217])
	by maili.marvell.com (Postfix) with ESMTP id 6A2393F70E3;
	Tue, 23 Sep 2025 02:41:25 -0700 (PDT)
From: Sathesh B Edara <sedara@marvell.com>
To: <linux-kernel@vger.kernel.org>, <sburla@marvell.com>, <vburru@marvell.com>,
        <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>, <netdev@vger.kernel.org>, <hgani@marvell.com>,
        <andrew@lunn.ch>, <srasheed@marvell.com>
CC: <sedara@marvell.com>, Andrew Lunn <andrew+netdev@lunn.ch>
Subject: [net-next PATCH v1 2/2 RESEND] octeon_ep_vf: Add support to retrieve hardware channel information
Date: Tue, 23 Sep 2025 02:41:19 -0700
Message-ID: <20250923094120.13133-3-sedara@marvell.com>
X-Mailer: git-send-email 2.36.0
In-Reply-To: <20250923094120.13133-1-sedara@marvell.com>
References: <20250923094120.13133-1-sedara@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: QZxOY-11mGItjt7MAg0k9eTQ5eVMOadL
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIwMDExNCBTYWx0ZWRfXyxEsoSMuNpH+ rXr8BDWGyzu5/8mf/DX5iPCshBAPYclabbo2s++8IDZBgEQkilsGRABaFkcmBpZfRF5m/PNeROy 8h4NAoeHgDlbMg0IskTpGYkHc2ZRmsXLrgDt6v1xpW2PEKV4Ec9od8/Lk2g/8A1u8u14K31r07U
 LgzDHiW4lIqysiDTiQwTfLYPNuJ4iOr3QucTB7FxnnUZbK0EgleNJQLp7KGIZ2X/ksF+n65Ocsv UCByX1G0RpCWcAn4u6IjoRsFEQbhnEDPyRyA6KmqLqF0bJ2USwcOuOokb/z01Fk0I8kZMkh7I1j UkjYgPN85AZtCsEOUlr4OXR8pl069wQS8NE+LRZWuiAyQVVQmAqXWeCAeh/x6/ae+H0WQWIYP4f 0RRcqCz9
X-Authority-Analysis: v=2.4 cv=auayCTZV c=1 sm=1 tr=0 ts=68d26b46 cx=c_pps a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17 a=yJojWOMRYYMA:10 a=M5GUcnROAAAA:8 a=p1zdzuy5FtcdZHaGWb8A:9 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-ORIG-GUID: QZxOY-11mGItjt7MAg0k9eTQ5eVMOadL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-23_02,2025-09-22_05,2025-03-28_01

This patch introduces support for retrieving hardware channel
configuration through the ethtool interface.

Signed-off-by: Sathesh B Edara <sedara@marvell.com>
---
 .../ethernet/marvell/octeon_ep_vf/octep_vf_ethtool.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/net/ethernet/marvell/octeon_ep_vf/octep_vf_ethtool.c b/drivers/net/ethernet/marvell/octeon_ep_vf/octep_vf_ethtool.c
index d60441928ba9..2b6a8530cbaa 100644
--- a/drivers/net/ethernet/marvell/octeon_ep_vf/octep_vf_ethtool.c
+++ b/drivers/net/ethernet/marvell/octeon_ep_vf/octep_vf_ethtool.c
@@ -244,6 +244,17 @@ static int octep_vf_get_link_ksettings(struct net_device *netdev,
 	return 0;
 }
 
+static void octep_vf_get_channels(struct net_device *dev,
+				  struct ethtool_channels *channel)
+{
+	struct octep_vf_device *oct = netdev_priv(dev);
+
+	channel->max_rx = CFG_GET_PORTS_MAX_IO_RINGS(oct->conf);
+	channel->max_tx = CFG_GET_PORTS_MAX_IO_RINGS(oct->conf);
+	channel->rx_count = CFG_GET_PORTS_ACTIVE_IO_RINGS(oct->conf);
+	channel->tx_count = CFG_GET_PORTS_ACTIVE_IO_RINGS(oct->conf);
+}
+
 static const struct ethtool_ops octep_vf_ethtool_ops = {
 	.get_drvinfo = octep_vf_get_drvinfo,
 	.get_link = ethtool_op_get_link,
@@ -251,6 +262,7 @@ static const struct ethtool_ops octep_vf_ethtool_ops = {
 	.get_sset_count = octep_vf_get_sset_count,
 	.get_ethtool_stats = octep_vf_get_ethtool_stats,
 	.get_link_ksettings = octep_vf_get_link_ksettings,
+	.get_channels = octep_vf_get_channels,
 };
 
 void octep_vf_set_ethtool_ops(struct net_device *netdev)
-- 
2.36.0


