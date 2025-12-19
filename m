Return-Path: <netdev+bounces-245473-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A24C0CCEA38
	for <lists+netdev@lfdr.de>; Fri, 19 Dec 2025 07:23:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 15E6B301A1F7
	for <lists+netdev@lfdr.de>; Fri, 19 Dec 2025 06:23:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACE822C21FC;
	Fri, 19 Dec 2025 06:23:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="kvJDEDbs"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB3C32C1581;
	Fri, 19 Dec 2025 06:23:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766125382; cv=none; b=i3AUVEtmxK9Xn9GcnOqJAsyrdlkyRRCKxqYewZFUEdnxKdOg6aKVtlTuhGgU8Fsq/cEdF9sBg0jkLEi5l8fIGlmt3h8v/NrvvGW5QrElRclO95UipvJ7j/cTDAtzgWbLWEVLcq7yXddE0HsvA5iFxK14XJr9xpckn+rtJgdR3Vc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766125382; c=relaxed/simple;
	bh=ubbCyFC+moXAwdJBRz+3upUvQOr5XxXbTrdKtzQsFic=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=DsozkhKeBjUtXDiHjUGJetmMZgKbl2JBvgPD3tQS1Qu/YVnz5/km2gRV6dMOh1/liTTawJ6AktkFZBmPusQV0E9A3QxIf1hR3dQE21zzzuv41hArF0Nd/LCHwL588Or6RhivCM/bLeR/k9EpiZy3l53gTs9WG6Y+kovgUMNYMhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=kvJDEDbs; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BIJjXsa680014;
	Thu, 18 Dec 2025 22:22:38 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pfpt0220; bh=izJW0mPNhaR99sT+kwlGB+h
	4Yn54FKPFo0NvVBmxhUw=; b=kvJDEDbsjqYRYnSvdR0eagDGhQFA1FWPZRBCTvn
	qgC6TYVVMxauruO/BmTwHbS+CAqYzXm7hkzC/V8gj4w0aibf3fSRJ8VwZA+MpjhP
	lKwvaJGNd5bs6Cxuv33QLnUaOZzKPuHnYNJj65I03w9cZ2296CA13eSmus5+PUVl
	zhHpcYu1OqbFIxPvhEWRbARn7L3KO/HPm1DtMtw3rvGPCSCN9gXcOqGgCNEoRf4I
	SCH2h1j4toHU+hIiERPgS6k1gAUoDfu7KIlMIsl3M20pF+MWBctysW+0dnqAAI3M
	+04ksvO0SkEFnZSSFWHKVXqBowzpyxSJVeoFDArnsNPpx2A==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4b4r2412qw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 18 Dec 2025 22:22:38 -0800 (PST)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 18 Dec 2025 22:22:50 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Thu, 18 Dec 2025 22:22:50 -0800
Received: from hyd1vellox1.032marvell.com032caveonetworks.com (unknown [10.29.37.43])
	by maili.marvell.com (Postfix) with ESMTP id EB3353F7093;
	Thu, 18 Dec 2025 22:22:33 -0800 (PST)
From: Anshumali Gaur <agaur@marvell.com>
To: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: Anshumali Gaur <agaur@marvell.com>, Sunil Goutham <sgoutham@marvell.com>,
        Geetha sowjanya <gakula@marvell.com>,
        Subbaraya Sundeep
	<sbhatta@marvell.com>,
        hariprasad <hkelam@marvell.com>,
        Bharat Bhushan
	<bbhushan2@marvell.com>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S.
 Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
        Christina Jacob
	<cjacob@marvell.com>
Subject: [PATCH] octeontx2-pf: fix "UBSAN: shift-out-of-bounds error"
Date: Fri, 19 Dec 2025 11:52:26 +0530
Message-ID: <20251219062226.524844-1-agaur@marvell.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjE5MDA1MSBTYWx0ZWRfX2B9a6uA1f5Hz
 OntA7nMt4qSIhCPBI6rTaukXfHgQQYS0Nhrp1aGkDqG47L01nNBBWit9AQURocvI5ZRTM1er3wX
 inWnyIWYPG+Pf0j4PPJe1g4V82osm/hNuBaoTxRNLN+FceTNr9YR0ObVf+riglQR5yLFnUhtjAz
 ZZISjHuspXzWsySuk88IuIImiXwXJezQuF+LVQQqt0gJvcxjEPOn59xq3zzQVYJegw1WBrfdXGK
 dk8E2qkdSNGSQ7zeybt0WMtZWaHb5R0vqZqO0CqIvvEnksZsMZ3FBpLsX3ZR1/QLU3Sg6o9gEQ7
 YUEdolFekGb0oR07IPFxBxGQp2if04ORffcBm7yak+XFM/LDyszbIF2MvmHBPPZrxXhJdQIhJTv
 wqrjW1QVTU7jmj4W86X4O2uJ1IDKvBxZg1uBZ837ilygOZ6ewDjQZjhS/KxTzL6bfwmvcNnGDkF
 330ms0Fpzakh8WPwP/Q==
X-Proofpoint-ORIG-GUID: 1BPTf0TwqwpI9_Vw-1sMSN3L9xk7QznS
X-Authority-Analysis: v=2.4 cv=T4uBjvKQ c=1 sm=1 tr=0 ts=6944ef2e cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=M5GUcnROAAAA:8
 a=WZBPPPMKX3YK0b_eNZYA:9 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-GUID: 1BPTf0TwqwpI9_Vw-1sMSN3L9xk7QznS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-19_02,2025-12-17_02,2025-10-01_01

This patch ensures that the RX ring size (rx_pending) is not
set below the permitted length. This avoids UBSAN
shift-out-of-bounds errors when users passes small or zero
ring sizes via ethtool -G.

Fixes: d45d8979840d ("octeontx2-pf: Add basic ethtool support")
Signed-off-by: Anshumali Gaur <agaur@marvell.com>
Change-Id: I6de6770dbc0dd952725ccd71ce521f801bc7b15b
---
 drivers/net/ethernet/marvell/octeontx2/nic/otx2_ethtool.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_ethtool.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_ethtool.c
index b90e23dc49de..b6449f0a9e7d 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_ethtool.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_ethtool.c
@@ -418,6 +418,14 @@ static int otx2_set_ringparam(struct net_device *netdev,
 	 */
 	if (rx_count < pfvf->hw.rq_skid)
 		rx_count =  pfvf->hw.rq_skid;
+
+	if (ring->rx_pending < 16) {
+		netdev_err(netdev,
+			   "rx ring size %u invalid, min is 16\n",
+			   ring->rx_pending);
+		return -EINVAL;
+	}
+
 	rx_count = Q_COUNT(Q_SIZE(rx_count, 3));
 
 	/* Due pipelining impact minimum 2000 unused SQ CQE's
-- 
2.25.1


