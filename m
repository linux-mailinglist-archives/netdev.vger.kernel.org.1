Return-Path: <netdev+bounces-226353-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DC60B9F5BB
	for <lists+netdev@lfdr.de>; Thu, 25 Sep 2025 14:52:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5E88819C2441
	for <lists+netdev@lfdr.de>; Thu, 25 Sep 2025 12:52:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B5501F2B8D;
	Thu, 25 Sep 2025 12:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="QaZC6E0L"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8BD61DF75D;
	Thu, 25 Sep 2025 12:51:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758804716; cv=none; b=T0Kvjq7iDOva0AY+aBUIO7VBj7AnXTflBCZBTUYhFP3O7wFyI18UpWzZwmxr8dsSBglAVrIEIcAoroigR2/KdTCigyITlfSy0ltyWTrOjGgqu20gqWYdRvsS24tvNC/yYLyXrFygxUeEipfE/nEa2q0bpvGO/q/I4mWS08ipXNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758804716; c=relaxed/simple;
	bh=QZ3AAHL2tmksV3Mg9WwJpm0Ta0ZWDJL0whaIfgap4jc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bSJnZzuLjQEpECX7Jb3Tq5PI+bAahrcP+HdQAtXPH77eD9a9GHeNxO2Vlbp5CfzFJ7vpQhsq4r1690Mm+R/J1cCRCB9GmtoD6z9VUQ1mbzBn/Ha648DHPwoJ1ZJRoKZXWLKg8teHnw8MAxr4qIPndzifKR3BHJKd8luFO5RDgxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=QaZC6E0L; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58PBN4C1008257;
	Thu, 25 Sep 2025 05:51:38 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pfpt0220; bh=F
	pBZz1eFcOWNpJR/ICASlzhoJGNFGSmw3GZow6FhLHw=; b=QaZC6E0LOMbaVKugk
	WfMcs/JoLC+qy1wW3Hr6dMLUpAZo32Ctz8oWpg1e2yJ7ds7frH0It2zV6ZbxunG7
	5Vq9HIRY53SXwge49HoGjUi9ps5LlcSnzLZJeSANkHnM2TP5xR/Vs06UMvpyc0WB
	5bceYzRDSLhD/Uyi2D7hxSlfCFAxXCRw4uU1tkjatBF88Dx4i9hhblvgq7hDgiq3
	NBLEgp3s9Jqk/20opYV1Ljh5/EiJNRz86hKqxSyusA0gnbeM3XKV40HKEvvkEbU2
	5Z3Fx6SxdoSA6M/1AH7eWqBy3M4g5+wJ8MaXZqccDzxWz5pevxaRYsmXoChOiHg/
	PFcVg==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 49d4thr5k8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 25 Sep 2025 05:51:38 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 25 Sep 2025 05:51:46 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Thu, 25 Sep 2025 05:51:46 -0700
Received: from sburla-PowerEdge-T630.sclab.marvell.com (unknown [10.106.27.217])
	by maili.marvell.com (Postfix) with ESMTP id C401C3F70C1;
	Thu, 25 Sep 2025 05:51:37 -0700 (PDT)
From: Sathesh B Edara <sedara@marvell.com>
To: <linux-kernel@vger.kernel.org>, <sburla@marvell.com>, <vburru@marvell.com>,
        <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>, <netdev@vger.kernel.org>, <hgani@marvell.com>,
        <andrew@lunn.ch>, <srasheed@marvell.com>
CC: <sedara@marvell.com>, Andrew Lunn <andrew+netdev@lunn.ch>
Subject: [net-next PATCH v2 1/2] octeon_ep: Add support to retrieve hardware channel information
Date: Thu, 25 Sep 2025 05:51:33 -0700
Message-ID: <20250925125134.22421-2-sedara@marvell.com>
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
X-Proofpoint-GUID: ogV6Z1Tch4UdNUwwkwd5GQNswRdWCZMT
X-Authority-Analysis: v=2.4 cv=L+0dQ/T8 c=1 sm=1 tr=0 ts=68d53ada cx=c_pps a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17 a=yJojWOMRYYMA:10 a=VwQbUJbxAAAA:8 a=M5GUcnROAAAA:8 a=TVuIt4C9u-c0JxYYBQ0A:9 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-ORIG-GUID: ogV6Z1Tch4UdNUwwkwd5GQNswRdWCZMT
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI1MDEwNyBTYWx0ZWRfX8ifsad4ESllW 93+f4YYx5FXVYLjOnRhnwiqUH4jU0UZR0yhUzvuYpubWBsgnaTalKUA6d3LD1NdheH7v+MhVA// DbXyS0xyvYQRKVDtak/m2/4Rws0fNygaCxQ8wtLhG11UG8CWL3h5TnDyPnGy9HJw0YnDgqZMEWU
 6ddXsUZtLzyE+fYHbmgQGAvcMIw1GeY83HDEeVIa6y7A0QJJKXN9+iAe3qcK0yXG3v9MzUaF+n0 tHZ7eLykeLh+H3gvxDK1CgCRVu6V+i04AELZly6a54qz8M4QF/pjIsMMa+9BXb2b1HikwGLIv++ GTUgkNKNQIOd4ukQ60hVz2uYV/aLZ2GQwOJMn54igjA2QzsxTqwlCYXNd/nY6hNfbhLtHNrTGno 6heXWOsp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-25_01,2025-09-24_01,2025-03-28_01

This patch introduces support for retrieving hardware channel
configuration through the ethtool interface.

Signed-off-by: Sathesh B Edara <sedara@marvell.com>
---
Find V1 here:
https://lore.kernel.org/netdev/20250923094120.13133-2-sedara@marvell.com/

V2:
- Corrected channel counts to combined.

 drivers/net/ethernet/marvell/octeon_ep/octep_ethtool.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/net/ethernet/marvell/octeon_ep/octep_ethtool.c b/drivers/net/ethernet/marvell/octeon_ep/octep_ethtool.c
index a88c006ea65b..01c6c0a2f283 100644
--- a/drivers/net/ethernet/marvell/octeon_ep/octep_ethtool.c
+++ b/drivers/net/ethernet/marvell/octeon_ep/octep_ethtool.c
@@ -437,6 +437,15 @@ static int octep_set_link_ksettings(struct net_device *netdev,
 	return 0;
 }
 
+static void octep_get_channels(struct net_device *dev,
+			       struct ethtool_channels *channel)
+{
+	struct octep_device *oct = netdev_priv(dev);
+
+	channel->max_combined = CFG_GET_PORTS_MAX_IO_RINGS(oct->conf);
+	channel->combined_count = CFG_GET_PORTS_ACTIVE_IO_RINGS(oct->conf);
+}
+
 static const struct ethtool_ops octep_ethtool_ops = {
 	.get_drvinfo = octep_get_drvinfo,
 	.get_link = ethtool_op_get_link,
@@ -445,6 +454,7 @@ static const struct ethtool_ops octep_ethtool_ops = {
 	.get_ethtool_stats = octep_get_ethtool_stats,
 	.get_link_ksettings = octep_get_link_ksettings,
 	.set_link_ksettings = octep_set_link_ksettings,
+	.get_channels = octep_get_channels,
 };
 
 void octep_set_ethtool_ops(struct net_device *netdev)
-- 
2.36.0


