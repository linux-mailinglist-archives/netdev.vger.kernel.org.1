Return-Path: <netdev+bounces-225542-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92626B954AE
	for <lists+netdev@lfdr.de>; Tue, 23 Sep 2025 11:41:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 572557A94F2
	for <lists+netdev@lfdr.de>; Tue, 23 Sep 2025 09:40:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31BE5320A3B;
	Tue, 23 Sep 2025 09:41:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="YzBBqdUj"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A02DB3203AF;
	Tue, 23 Sep 2025 09:41:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758620508; cv=none; b=XtH83UDGbR2TKk5IdBMO8t8cwRs3JB1BucazcQU9UHGygOhFxjdjgCnZ/K+Pkvs4T++OISno2RsvCZ7Ns3ZT7W+FkaESBLolAiKtJ1N/lSgKNtvTv+jzZ3Sh99dHubRmvJvcw+IEGdUJeHeG1tTpqT+DpoIHwqnlWIj/wr+rEtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758620508; c=relaxed/simple;
	bh=d3nGAMwc0Ca6x+mLjsT3ZNLtBhtVTH6Kz432wyRjh4M=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=R0CWou3uafY0o32jrgUo2Rhxu1SKExPsZoZVGmD+JnEu9lcKMziKupjpWhkYzn47P9xAkuhAF1Z7zUCpxy6OT7vtPR04nsuuayXkixkEicvGArbjepSaXj8sVbv1rPp9X5yaUS9N6l66BE+0DDahY88aEKS9BKxk34dd1+t+1fs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=YzBBqdUj; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58MNSZKT006329;
	Tue, 23 Sep 2025 02:41:26 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pfpt0220; bh=K
	Q3rphXddI2Lg4oJm/fyhu6JkwPEiwUj7vyGSm+CrWY=; b=YzBBqdUjMpnawacnF
	wPrzs+5lHdS233Uiujq54VS50PUawJNHdfuGG7IB12VAODBWQvJ/qqZalIkVR1U3
	LiZb/V8QfcWGPTzH1s+bb7H8klA1dxpZt97O22gg+ykFfHpcSydqng2nfkRn76bY
	Yyn31P4zbohkR6J/WoCCY3BrL3LV/SHkATtHeovkjddIt+Jo8Mr6h8n5BbOOxwyl
	esoWfehZ0d5Obw63YK1rSsWHbsO4nU++tS5bFJhVmbNO+CkyF8Qrzb/ax8CVNXyv
	6U2S8qfGdNnLXXypB2RlPhKGtH1NeHzm0x0JlaM0e8aWd8+0IEKf6/DXLw85tT1K
	Uozyg==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 49bg5r91c5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 23 Sep 2025 02:41:25 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 23 Sep 2025 02:41:33 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Tue, 23 Sep 2025 02:41:33 -0700
Received: from sburla-PowerEdge-T630.sclab.marvell.com (unknown [10.106.27.217])
	by maili.marvell.com (Postfix) with ESMTP id B69583F70E9;
	Tue, 23 Sep 2025 02:41:24 -0700 (PDT)
From: Sathesh B Edara <sedara@marvell.com>
To: <linux-kernel@vger.kernel.org>, <sburla@marvell.com>, <vburru@marvell.com>,
        <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>, <netdev@vger.kernel.org>, <hgani@marvell.com>,
        <andrew@lunn.ch>, <srasheed@marvell.com>
CC: <sedara@marvell.com>, Andrew Lunn <andrew+netdev@lunn.ch>
Subject: [net-next PATCH v1 1/2 RESEND] octeon_ep: Add support to retrieve hardware channel information
Date: Tue, 23 Sep 2025 02:41:18 -0700
Message-ID: <20250923094120.13133-2-sedara@marvell.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIyMDIyNyBTYWx0ZWRfX+T9KRGibC8hQ SvAQp6t6lVpuq0DscJLom9KUm/ccRUNqc45JSALpxlsQSM0DnZmtiomPHeAW8BAT0gWia4M7X8p 2yWsCmLFkP4n8n/FIsYSpB7Qx5JhZEkviW93kAAZKZ7jqnLAtjmelJNweSzRCUnJ7aWj3AOcR5T
 KQ15VylP9SduRrCCxG+EjhpIci7HVsO0OxtEGxkUWA1q+0r5GbBkgWY2PoCkDFuAAa3ifunpDVe iJFGAyWkzNcxzarmDErpQxvlCKspn0kyfHG6vG7Sd/RpaSaG07z0f/uj15ji4jCVbqJQBrTpZ7f 08LxlbUrvAcnckEtM7Kq1LRrS6lz/GJyzQuzSUs9F2opjyMK9HuO8gRbuFWQNcs/jq1+b80oqJK LnmBEvBB
X-Proofpoint-GUID: 482cU-iYXSZy1Ptu22XSABxa9MaoiOvo
X-Authority-Analysis: v=2.4 cv=D8hHKuRj c=1 sm=1 tr=0 ts=68d26b45 cx=c_pps a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17 a=yJojWOMRYYMA:10 a=M5GUcnROAAAA:8 a=TVuIt4C9u-c0JxYYBQ0A:9 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-ORIG-GUID: 482cU-iYXSZy1Ptu22XSABxa9MaoiOvo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-23_02,2025-09-22_05,2025-03-28_01

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


