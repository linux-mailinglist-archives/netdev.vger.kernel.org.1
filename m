Return-Path: <netdev+bounces-226354-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0767EB9F5BE
	for <lists+netdev@lfdr.de>; Thu, 25 Sep 2025 14:52:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9F7047A67E4
	for <lists+netdev@lfdr.de>; Thu, 25 Sep 2025 12:50:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35BDF1F4198;
	Thu, 25 Sep 2025 12:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="Zq4aiuHa"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEC191E1C02;
	Thu, 25 Sep 2025 12:51:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758804716; cv=none; b=njHm1HibVzD1/09SuXttI3r8MuxOfu/VqCBkA0w9h8ZlSnunj9f1511BUDOZe0CWp/T5KQoMMdQgDyudlX4Fno1jMecZ9TUP5rvWNDjeUsMGWo4WgHJ/soIg2B4OvmMdY/f+g3tmTWv4mNaOnqu4/1s8BC4kqBEy5UDgbgoJsOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758804716; c=relaxed/simple;
	bh=SrWBA+fG0FATeWTgMS90uZ+rxrWCIl5OPnIzxi9p4Vw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IAcAL1LTwfhL2Eo8Lt2dJ0/Hu3n5C7uEBaL3M6DieSOu1M2XKSYmnFHeWpfiviO8c9yt8buPUB8BAajIoMUebDJ0DtafNlhr9FvGgGwvJQyd5TychhXfXHZdGqLV8b5cjQd6cbCXfWT456eIUIVF7z0swEBaCYo2YXlia40yqaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=Zq4aiuHa; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58PBN407008262;
	Thu, 25 Sep 2025 05:51:40 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pfpt0220; bh=d
	PigCg841OhkiFo7jxpHcgnZDvHisFBeV9xk+zKSkOs=; b=Zq4aiuHa5Xss9Ai3z
	zklFbDI/cCqLvFc8d07uNimDRgeG9LcL5lCRcVj9PTpXH+6941aOLZTg1JMFDHvl
	QihKmXMCeYTQpjKmcSAI/hlacVncc5PKVwxW3AjagsKecJkoi7PFpFUc9WnjPF7s
	Ds+BIqYkwOfguQzCAX8weAK7Tw6Gr2tJzEJqe8pa65USt3ViYSgtWxMIhS+yE8/I
	L5sHQywogxXpmQABBU8hMnnFu7nO8vmTdTv1PG1QgvLRH3/dCY9LLXzula3sjMu/
	1EmIBo7YxOv/vMg7rzQYugZ9+V7Yf/rRZuxpI0V0T4OpZ/GfcFYzfsCy7a7Ie4uD
	7exaw==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 49d4thr5k7-3
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 25 Sep 2025 05:51:40 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 25 Sep 2025 05:51:38 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Thu, 25 Sep 2025 05:51:38 -0700
Received: from sburla-PowerEdge-T630.sclab.marvell.com (unknown [10.106.27.217])
	by maili.marvell.com (Postfix) with ESMTP id 5AB453F7043;
	Thu, 25 Sep 2025 05:51:38 -0700 (PDT)
From: Sathesh B Edara <sedara@marvell.com>
To: <linux-kernel@vger.kernel.org>, <sburla@marvell.com>, <vburru@marvell.com>,
        <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>, <netdev@vger.kernel.org>, <hgani@marvell.com>,
        <andrew@lunn.ch>, <srasheed@marvell.com>
CC: <sedara@marvell.com>, Andrew Lunn <andrew+netdev@lunn.ch>
Subject: [net-next PATCH v2 2/2] octeon_ep_vf: Add support to retrieve hardware channel information
Date: Thu, 25 Sep 2025 05:51:34 -0700
Message-ID: <20250925125134.22421-3-sedara@marvell.com>
X-Mailer: git-send-email 2.36.0
In-Reply-To: <20250925125134.22421-1-sedara@marvell.com>
References: <20250925125134.22421-1-sedara@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: P8wB8cu6BFWuSjyggoUHxwWbB4qocS1c
X-Authority-Analysis: v=2.4 cv=L+0dQ/T8 c=1 sm=1 tr=0 ts=68d53adc cx=c_pps a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17 a=yJojWOMRYYMA:10 a=VwQbUJbxAAAA:8 a=M5GUcnROAAAA:8 a=p1zdzuy5FtcdZHaGWb8A:9 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-ORIG-GUID: P8wB8cu6BFWuSjyggoUHxwWbB4qocS1c
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI1MDEwNyBTYWx0ZWRfXzwTLe+R5sO4x 7R/Jmw5pGiVZL61E57u+WCv7+TPUKCcOA+s29igRtt1/ptOfGK6pGja91eIVIVjLkGOmxwWW8Bu t1blWIB7Swuk82czM01vgsdBnSEtweSEoAsDofatGedRAJAIodwHoWHCFsyon9JkaaTNpg2OhGL
 UHrmkdbjgKyaSF8L7Nzmrg0Q/y0gjfr4nIcBLYdUG4G03+r2HzE/gAS2r4XJH1RktgqHpX1HiSb iv+o+DkeaWeyauoCa0ck7MVOp238tbyHub+ocBXkeZWGwN7RZTsza4EtNdzvgtT1uKLk1RDSfVY +loNLYPmq6ISguMt1p1jtiLspF2XKMuhjyoTNtO/J9OXz/vyVAHuJwQ+0Q0fY319L7ilAPrv0I8 fMKNZIAu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-25_01,2025-09-24_01,2025-03-28_01

This patch introduces support for retrieving hardware channel
configuration through the ethtool interface.

Signed-off-by: Sathesh B Edara <sedara@marvell.com>
---
Find V1 here:
https://lore.kernel.org/netdev/20250923094120.13133-3-sedara@marvell.com/

V2:
- Corrected channel counts to combined.

 .../ethernet/marvell/octeon_ep_vf/octep_vf_ethtool.c   | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/net/ethernet/marvell/octeon_ep_vf/octep_vf_ethtool.c b/drivers/net/ethernet/marvell/octeon_ep_vf/octep_vf_ethtool.c
index d60441928ba9..241a7e7c7ad2 100644
--- a/drivers/net/ethernet/marvell/octeon_ep_vf/octep_vf_ethtool.c
+++ b/drivers/net/ethernet/marvell/octeon_ep_vf/octep_vf_ethtool.c
@@ -244,6 +244,15 @@ static int octep_vf_get_link_ksettings(struct net_device *netdev,
 	return 0;
 }
 
+static void octep_vf_get_channels(struct net_device *dev,
+				  struct ethtool_channels *channel)
+{
+	struct octep_vf_device *oct = netdev_priv(dev);
+
+	channel->max_combined = CFG_GET_PORTS_MAX_IO_RINGS(oct->conf);
+	channel->combined_count = CFG_GET_PORTS_ACTIVE_IO_RINGS(oct->conf);
+}
+
 static const struct ethtool_ops octep_vf_ethtool_ops = {
 	.get_drvinfo = octep_vf_get_drvinfo,
 	.get_link = ethtool_op_get_link,
@@ -251,6 +260,7 @@ static const struct ethtool_ops octep_vf_ethtool_ops = {
 	.get_sset_count = octep_vf_get_sset_count,
 	.get_ethtool_stats = octep_vf_get_ethtool_stats,
 	.get_link_ksettings = octep_vf_get_link_ksettings,
+	.get_channels = octep_vf_get_channels,
 };
 
 void octep_vf_set_ethtool_ops(struct net_device *netdev)
-- 
2.36.0


