Return-Path: <netdev+bounces-154711-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F3779FF8B1
	for <lists+netdev@lfdr.de>; Thu,  2 Jan 2025 12:24:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BFBA73A2561
	for <lists+netdev@lfdr.de>; Thu,  2 Jan 2025 11:23:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D0BE1B0F09;
	Thu,  2 Jan 2025 11:23:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="LIWg4ucM"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECF581ABEDC;
	Thu,  2 Jan 2025 11:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735817012; cv=none; b=HirqvIPVWo/I9Y48bNTQ/gtbIXZCby2OamJjYEqa9y/Ws0LR4dsLfNhUZ2gvDzdLptzoTrGtfCcR3Ys8ljKf5dVVJwu1g/XO4CSmc3dnd7R5nfKHgnvak8o+ZhDid8OwC2TfNZxaB09+9bnXw9BqriO1visihA7Ww+8+8kssWmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735817012; c=relaxed/simple;
	bh=n3qEMwcdS+0cQXbsStvgUvvF4aiGwmQeakoNy0X43ls=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jCDpsV9iYSAvZ26XqhO25VC400c3V85qqTZJpiFxsEfnjMJo+HPhX1Tk7MyKwBOHnqmWdIu7x6rYZiSVNsuNZA2rmZrcR51lmMtN0uj9Q8RF8Z89uBN+yvP6SxwjfN0rCy89ny6cxQI7tJx8++e8Zb4DWGYhZstd0yErnPYDpfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=LIWg4ucM; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 502Aa4Y6001654;
	Thu, 2 Jan 2025 03:23:06 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pfpt0220; bh=M
	ERyu8pxUUjvnW4He8SRoYXf+hsBGFeesxufKdoCXng=; b=LIWg4ucM8698Ha532
	yFYPe7wtB7dmz1xTWwTrmVeVNuktfNPGKBPMFThWNU5Q8SFRiZt30reWnilh36Hu
	OM1isvst4bGckvTDi5v/q2qNQfqfFJy0ejzDHnn50xpjbSbT6BqSqymU0sbFCdsu
	q8fSX6OGypGPIGzkAxbyLO+tqobMlYrIJfH1wwWcd/JLFIQafzkTfghiLuE4yDHg
	3x1rRl2MBVu5A8bimyq+hz68keeHQe6qhsT/FuRddvXwm2dhz496Ib68ZWwYVJ6a
	NS2C1WTxN282sdoX9xRswYfoLRH3/qJzANjU5+BQN98/cQDAN9q73euuIrYrV6eO
	COn4A==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 43ws6e01sh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 02 Jan 2025 03:23:06 -0800 (PST)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Thu, 2 Jan 2025 03:23:05 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Thu, 2 Jan 2025 03:23:05 -0800
Received: from ubuntu-PowerEdge-T110-II.sclab.marvell.com (unknown [10.106.27.86])
	by maili.marvell.com (Postfix) with ESMTP id AE31A3F708C;
	Thu,  2 Jan 2025 03:23:04 -0800 (PST)
From: Shinas Rasheed <srasheed@marvell.com>
To: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <hgani@marvell.com>, <sedara@marvell.com>, <vimleshk@marvell.com>,
        <thaller@redhat.com>, <wizhao@redhat.com>, <kheib@redhat.com>,
        <konguyen@redhat.com>, <horms@kernel.org>, <einstein.xue@synaxg.com>,
        "Shinas
 Rasheed" <srasheed@marvell.com>,
        Veerasenareddy Burru <vburru@marvell.com>,
        Satananda Burla <sburla@marvell.com>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH net v4 3/4] octeon_ep_vf: fix race conditions in ndo_get_stats64
Date: Thu, 2 Jan 2025 03:22:45 -0800
Message-ID: <20250102112246.2494230-4-srasheed@marvell.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250102112246.2494230-1-srasheed@marvell.com>
References: <20250102112246.2494230-1-srasheed@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: U3gKPhqT1DOBFSHGboRh2zq1TfF5BcJn
X-Proofpoint-ORIG-GUID: U3gKPhqT1DOBFSHGboRh2zq1TfF5BcJn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01

ndo_get_stats64() can race with ndo_stop(), which frees input and
output queue resources. Check if netdev is running before accessing
per queue resources.

Fixes: c3fad23cdc06 ("octeon_ep_vf: add support for ndo ops")
Signed-off-by: Shinas Rasheed <srasheed@marvell.com>
---
V4:
  - Check if netdev is running, as decision for accessing resources
    rather than availing lock implementations, in ndo_get_stats64()

V3: https://lore.kernel.org/all/20241218115111.2407958-4-srasheed@marvell.com/
  - No changes

V2: https://lore.kernel.org/all/20241216075842.2394606-4-srasheed@marvell.com/
  - Changed sync mechanism to fix race conditions from using an atomic
    set_bit ops to a much simpler synchronize_net()

V1: https://lore.kernel.org/all/20241203072130.2316913-4-srasheed@marvell.com/

 drivers/net/ethernet/marvell/octeon_ep_vf/octep_vf_main.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/ethernet/marvell/octeon_ep_vf/octep_vf_main.c b/drivers/net/ethernet/marvell/octeon_ep_vf/octep_vf_main.c
index 7e6771c9cdbb..9b29cd698361 100644
--- a/drivers/net/ethernet/marvell/octeon_ep_vf/octep_vf_main.c
+++ b/drivers/net/ethernet/marvell/octeon_ep_vf/octep_vf_main.c
@@ -786,6 +786,10 @@ static void octep_vf_get_stats64(struct net_device *netdev,
 	tx_bytes = 0;
 	rx_packets = 0;
 	rx_bytes = 0;
+
+	if (!netif_running(netdev))
+		return;
+
 	for (q = 0; q < oct->num_oqs; q++) {
 		struct octep_vf_iq *iq = oct->iq[q];
 		struct octep_vf_oq *oq = oct->oq[q];
-- 
2.25.1


