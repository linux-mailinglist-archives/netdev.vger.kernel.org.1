Return-Path: <netdev+bounces-224406-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0452EB84584
	for <lists+netdev@lfdr.de>; Thu, 18 Sep 2025 13:27:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CDC471BC520D
	for <lists+netdev@lfdr.de>; Thu, 18 Sep 2025 11:28:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04F3F304BBC;
	Thu, 18 Sep 2025 11:27:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="VljQJFl9"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 622D030171F;
	Thu, 18 Sep 2025 11:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758194849; cv=none; b=ODPwLUIqwgBPE4y2E6TAleRPYR4mir58v4P/AxRahgGHxcQW91qIjPDBGnqN+STlG3mansifUHUMNuySEA91COwI4SXdWf5l7gtT5Eo3aeZxq+Bag6tnQ2C1QVGMCM5k38NDY0rHMNeAb9125GEr7zvmh7JEr1vstcYk9g3j/dw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758194849; c=relaxed/simple;
	bh=GsnPxTn+x4DSSdnvo6ORja4Dj3Jto43CHQPs5k23NpY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CbBbhHcFWDH+fC4PtpfHb9dWpzjrab4EkldhbhPh4vjUpHk9debc3+ZSC9rjn1colMhvkjASEK4Mfmj0f87pCIKbuRyaXVxzGMnKxBp8PHn66WT9XHVgfRMu5DfeC9TkGet1t4rDib/IUiASyIcfqGKs8cyerwsS8fmHJq86X7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=VljQJFl9; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58HGZJCj002367;
	Thu, 18 Sep 2025 04:27:07 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pfpt0220; bh=A
	pHvNDSxieYbzSY7gu9AdrSQmWvjJrWk+/Uceyuye5Q=; b=VljQJFl9v2qgcJZ6p
	oZ28qVZvtPnf7qhs2nh62tDPgNlifCt9QKGzZYvFza+zzgZv/tZPksIWkiNmjtoE
	bzEg6iCBn0QAzhd5gwQM3sznH0xFP1xEaK6rhikBg/oaA1lmJDpyZm4btNnep5NW
	ejYdUG2X/O5z5akjbC1j13AFZUhuZtJkSX4qH1SmRQYrVcOrP7QKD9htVnxSlQSd
	HOU0fixlbX59vPYkJ6dULFc81MtsMcc/FQsPbWhWj2UiS64l5UHQNVEhxC8zkkGQ
	RP4kUaxz/xzk7gRYxYWmnQepNPkFbkp0LLRu6x8Jx2XGBEzX6E2224z2O46hhFrC
	799zg==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 497fxpvchk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 18 Sep 2025 04:27:07 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 18 Sep 2025 04:27:13 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Thu, 18 Sep 2025 04:27:13 -0700
Received: from sburla-PowerEdge-T630.sclab.marvell.com (unknown [10.106.27.217])
	by maili.marvell.com (Postfix) with ESMTP id 155F33F7074;
	Thu, 18 Sep 2025 04:27:06 -0700 (PDT)
From: Sathesh B Edara <sedara@marvell.com>
To: <linux-kernel@vger.kernel.org>, <sburla@marvell.com>, <vburru@marvell.com>,
        <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>, <netdev@vger.kernel.org>, <hgani@marvell.com>,
        <andrew@lunn.ch>, <srasheed@marvell.com>
CC: <sedara@marvell.com>, Andrew Lunn <andrew+netdev@lunn.ch>
Subject: [net PATCH v1 2/2] octeon_ep_vf: Add support to retrieve hardware channel information
Date: Thu, 18 Sep 2025 04:26:52 -0700
Message-ID: <20250918112653.29253-3-sedara@marvell.com>
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
X-Proofpoint-ORIG-GUID: CAaiVmuuATWgzERGE7zioIGmF4wJ-E9_
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE2MDIwMiBTYWx0ZWRfX51EN4MEy1GWh zxcZRhX6X6AeO66CXeCA5kumCD7SvmJhtk8aC9fayfqyalWcmthrBzBes7hqKTX6Ca6PSjGNm8Z nNdlwKOs2BwyjS9/0G5RUE6bXPu+QxBPiWLPPK5O8hNI4S6d9k9aUe3jR1QBXkrHRI6PDj3d3L7
 /dJK9sqVRKtAP6Ggl5FPiEeISWOdx9fkPt349nhjFKlXYk+KtIpR3/I9pgputwytSGfMgnAP72+ ST6Nl0oHF5p3hpO8IYSNnNJhSYaPOfYLLFDRDo6CcQ12T5c2i4MdNVUfZNaM0c6pfCozgFOQ99x DBrVFT8b6sijfFjcnl8B5Znxv7QQW6Z2Pl16KOcOj6hIO7uhHuTvBl70BS+6ilE2lfZi3st9NnB 5zwU+e/Q
X-Authority-Analysis: v=2.4 cv=EaPIQOmC c=1 sm=1 tr=0 ts=68cbec8b cx=c_pps a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17 a=yJojWOMRYYMA:10 a=M5GUcnROAAAA:8 a=p1zdzuy5FtcdZHaGWb8A:9 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-GUID: CAaiVmuuATWgzERGE7zioIGmF4wJ-E9_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-17_01,2025-09-18_02,2025-03-28_01

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


