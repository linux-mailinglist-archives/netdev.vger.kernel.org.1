Return-Path: <netdev+bounces-224405-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 810D1B8457E
	for <lists+netdev@lfdr.de>; Thu, 18 Sep 2025 13:27:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8669D584372
	for <lists+netdev@lfdr.de>; Thu, 18 Sep 2025 11:27:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75E9930216D;
	Thu, 18 Sep 2025 11:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="h6R2qF6r"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6EDC30102F;
	Thu, 18 Sep 2025 11:27:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758194848; cv=none; b=juSVXInzBFraFyrw+owU4wyQR6IdBLsLPUKS4aljzwHFOvu+myG1mO10YO3ucYxW99YE61onwepgAVaFXbhCVQFzRb2ncDlBlpxBBLjtel/XaMg1Zj63s5pxaHr0WmUmyGAW0HXhWHEKAPnDb5Ji6k0aRz9oDt62TYqZh6+EJbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758194848; c=relaxed/simple;
	bh=d3nGAMwc0Ca6x+mLjsT3ZNLtBhtVTH6Kz432wyRjh4M=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eFpljzlGwtv7lvIy30MRoKAr5B1qUXx03Eku2xrNBLMfDyCMetoHA/+RRhcSlbv5Y4kHW3TgdQJwMBVWH+qv4pK1NBMVQBLOg5pwbKMnjvSpSseG4BiMBZSf3UCEP0omT2In3w+EAm3Lb2JJEjkBhC6ilgXJLqEvNEMzFSwiwMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=h6R2qF6r; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58HNSn1C022885;
	Thu, 18 Sep 2025 04:27:06 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pfpt0220; bh=K
	Q3rphXddI2Lg4oJm/fyhu6JkwPEiwUj7vyGSm+CrWY=; b=h6R2qF6rKE4ByD/Nf
	VFqUElwFgfKaeQrQvW+lzuokzUARCvCIxzU0VkfBxYvAMFJfoI+L1Jd0X1Re3+oH
	1aLwc8ycK+rc44Zhlwd0d1FbanJgo/4xDXBC6a5ZO7xvQP8CYmlCcx2GgOEMla0c
	ucGRZy9CvZ7NqzumLqCedn168jAKf1kGoj0APgsUV7vbd5nH2XD5Pd2XEsG8ZnId
	vtWX2VeTF3MBp7KWrkol0gt0WrhXP5rwNHm8CrpxV2yzSApWqkXLhEeweAfIrZnC
	0DEXSGP36SgN7E+bmijjCfGxjeN6x2pKpW42Gzm8EXHD7Nx9tMqrwo6Uxl87/fOj
	qPQbg==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4986pn9766-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 18 Sep 2025 04:27:06 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 18 Sep 2025 04:27:05 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Thu, 18 Sep 2025 04:27:05 -0700
Received: from sburla-PowerEdge-T630.sclab.marvell.com (unknown [10.106.27.217])
	by maili.marvell.com (Postfix) with ESMTP id 81FAC3F7061;
	Thu, 18 Sep 2025 04:27:05 -0700 (PDT)
From: Sathesh B Edara <sedara@marvell.com>
To: <linux-kernel@vger.kernel.org>, <sburla@marvell.com>, <vburru@marvell.com>,
        <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>, <netdev@vger.kernel.org>, <hgani@marvell.com>,
        <andrew@lunn.ch>, <srasheed@marvell.com>
CC: <sedara@marvell.com>, Andrew Lunn <andrew+netdev@lunn.ch>
Subject: [net PATCH v1 1/2] octeon_ep: Add support to retrieve hardware channel information
Date: Thu, 18 Sep 2025 04:26:51 -0700
Message-ID: <20250918112653.29253-2-sedara@marvell.com>
X-Mailer: git-send-email 2.36.0
In-Reply-To: <20250918112653.29253-1-sedara@marvell.com>
References: <20250918112653.29253-1-sedara@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: 6C0XyztOZUbqsuy2rHpRx75e1LXpBjL7
X-Proofpoint-ORIG-GUID: 6C0XyztOZUbqsuy2rHpRx75e1LXpBjL7
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE3MDIyNyBTYWx0ZWRfX5fOeV2bN75GW i/iaH3fQjYvJYv4gZsMiSn+YCuqojBgi5hhuPEW/cF0urL0KvclQCrSipPOgOzy333YKF07lsSM /v2LEHF9v0uw4AtrXGHiFUF/+L9Zds37mwssXqWdcl2nEH8eBvmAKuUvTiDdU7omtoa3Sob/urS
 /BwRB/CVcyaefolkQgS4fvzQ8SK5a2MseZOTAtKizZH/mvmBNpHm0s1w8MsqeUAhrOhVt1FBgR8 pe2fkUsvSTx32UP1/uMVfVuUBHvQ6N8MGWUjTKUl0+d69XaGD0U78kRAm2NvJYwZ3fG0rJoK6bN cgTYi2T6Li0FjGZsp57CS1Nv8q8xESrysVVZx7x8epETHcrWZq8sUCtK29bOc43upFqRSzNyhM/ mABZ57kK
X-Authority-Analysis: v=2.4 cv=YqgPR5YX c=1 sm=1 tr=0 ts=68cbec8a cx=c_pps a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17 a=yJojWOMRYYMA:10 a=M5GUcnROAAAA:8 a=TVuIt4C9u-c0JxYYBQ0A:9 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-17_01,2025-09-18_02,2025-03-28_01

This patch introduces support for retrieving hardware channel
configuration through the ethtool interface.

Signed-off-by: Sathesh B Edara <sedara@marvell.com>
---
 .../net/ethernet/marvell/octeon_ep/octep_ethtool.c   | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/net/ethernet/marvell/octeon_ep/octep_ethtool.c b/drivers/net/ethernet/marvell/octeon_ep/octep_ethtool.c
index a88c006ea65b..9d57e2da0b4b 100644
--- a/drivers/net/ethernet/marvell/octeon_ep/octep_ethtool.c
+++ b/drivers/net/ethernet/marvell/octeon_ep/octep_ethtool.c
@@ -437,6 +437,17 @@ static int octep_set_link_ksettings(struct net_device *netdev,
 	return 0;
 }
 
+static void octep_get_channels(struct net_device *dev,
+			       struct ethtool_channels *channel)
+{
+	struct octep_device *oct = netdev_priv(dev);
+
+	channel->max_rx = CFG_GET_PORTS_MAX_IO_RINGS(oct->conf);
+	channel->max_tx = CFG_GET_PORTS_MAX_IO_RINGS(oct->conf);
+	channel->rx_count = CFG_GET_PORTS_ACTIVE_IO_RINGS(oct->conf);
+	channel->tx_count = CFG_GET_PORTS_ACTIVE_IO_RINGS(oct->conf);
+}
+
 static const struct ethtool_ops octep_ethtool_ops = {
 	.get_drvinfo = octep_get_drvinfo,
 	.get_link = ethtool_op_get_link,
@@ -445,6 +456,7 @@ static const struct ethtool_ops octep_ethtool_ops = {
 	.get_ethtool_stats = octep_get_ethtool_stats,
 	.get_link_ksettings = octep_get_link_ksettings,
 	.set_link_ksettings = octep_set_link_ksettings,
+	.get_channels = octep_get_channels,
 };
 
 void octep_set_ethtool_ops(struct net_device *netdev)
-- 
2.36.0


