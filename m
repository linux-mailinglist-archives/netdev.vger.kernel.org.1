Return-Path: <netdev+bounces-143223-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A28FD9C1736
	for <lists+netdev@lfdr.de>; Fri,  8 Nov 2024 08:47:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D4B611C226C8
	for <lists+netdev@lfdr.de>; Fri,  8 Nov 2024 07:47:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84C7C1D1F6F;
	Fri,  8 Nov 2024 07:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="Er8fY061"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1648B1DFD9B;
	Fri,  8 Nov 2024 07:46:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731051970; cv=none; b=gXkuUUInOcjx9GwLEdFvSG0kPoumwNgAt5CfLE7uQOzz/fVmIGROgNPXUbUx0cbPjzadLhOS2PCANE/f8+iec7Rchpe+0+6vg1XWoBjQ2hTv6/qqh0JzESZqpTP0+C4+2JKHaVechIJU8nYmB91qMW+CVB46zeLFY2zZdueo5dM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731051970; c=relaxed/simple;
	bh=dh8bEnNdsPsw8OXFwNjMc3X9dLpYzfqmHCAmniviRik=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Qa5ngPx8H5Q4ZoUTYYlOdAphS9RQyyZAlyr+z9fshe2w1nYRjwpJR7MuzoozLncByxGdCB1EKuyEmnZ/A2m0fu7vwpn5mCvVGnVc58WzgMsz1KK8oxSlgHMbRgZ17UUGB6DTZmcbKA4drq3m56LjEmhm1EZ5N+7HdabCOadUN3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=Er8fY061; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4A7Mbvgl022794;
	Thu, 7 Nov 2024 23:45:56 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pfpt0220; bh=U
	uDbgKg+IttnOHFMUqrpGYtL8A/0bOttNMW1tBLqDTw=; b=Er8fY061mcc3yCcBL
	vnS7KMqnq0fHL+EUvqRBIpGy6OoLx23/aLZfzpLTZlhr6LWPrMLa2Mv3hd+YEyyk
	REFBVaFpcbml5XnjHsJF4VEB9udRlKa0706U8dws7Z3DdWzQlRuCEWfqepnZO9R+
	0iBOdhWvjCI0destMmk2awE81u/GNyxcUenZVvO2O6V1m5izI95HqSgeBTakgDqM
	dEha4uzEaN75jgYzHTpLFIzqBrnBrAcsmOjrnyBMAEDSRPFOFBPtb4LFjTVhAGQB
	1z2optsm/REopm8QAGsE6ny8IMMWiFvhUpV91enmzK03db2I14Gsfm2F1dkL3Ve0
	dk90w==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 42s6gu90ba-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 07 Nov 2024 23:45:56 -0800 (PST)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Thu, 7 Nov 2024 23:45:55 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Thu, 7 Nov 2024 23:45:55 -0800
Received: from ubuntu-PowerEdge-T110-II.sclab.marvell.com (unknown [10.106.27.86])
	by maili.marvell.com (Postfix) with ESMTP id 4F2693F7082;
	Thu,  7 Nov 2024 23:45:55 -0800 (PST)
From: Shinas Rasheed <srasheed@marvell.com>
To: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <hgani@marvell.com>, <sedara@marvell.com>, <vimleshk@marvell.com>,
        <thaller@redhat.com>, <wizhao@redhat.com>, <kheib@redhat.com>,
        <egallen@redhat.com>, <konguyen@redhat.com>, <horms@kernel.org>,
        <frank.feng@synaxg.com>, Shinas Rasheed <srasheed@marvell.com>,
        Veerasenareddy Burru <vburru@marvell.com>,
        Satananda Burla
	<sburla@marvell.com>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller"
	<davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH net v3 6/7] octeon_ep_vf: add protective null checks in napi callbacks for cn9k cards
Date: Thu, 7 Nov 2024 23:45:42 -0800
Message-ID: <20241108074543.1123036-7-srasheed@marvell.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241108074543.1123036-1-srasheed@marvell.com>
References: <20241108074543.1123036-1-srasheed@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: ZwPHvxoctpAj8F7oB_hUdDYEQSuIEW4m
X-Proofpoint-GUID: ZwPHvxoctpAj8F7oB_hUdDYEQSuIEW4m
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.687,Hydra:6.0.235,FMLib:17.0.607.475
 definitions=2020-10-13_15,2020-10-13_02,2020-04-07_01

During unload, at times the OQ parsed in the napi callbacks
have been observed to be null, causing system crash.
Add protective checks to avoid the same, for cn9k cards.

Fixes: cb7dd712189f ("octeon_ep_vf: Add driver framework and device initialization")
Signed-off-by: Shinas Rasheed <srasheed@marvell.com>
---
V3:
  - Added back "Fixes" to the changelist

V2: https://lore.kernel.org/all/20241107132846.1118835-7-srasheed@marvell.com/
  - Split into a separate patch
  - Added more context

V1: https://lore.kernel.org/all/20241101103416.1064930-4-srasheed@marvell.com/

 drivers/net/ethernet/marvell/octeon_ep_vf/octep_vf_cn9k.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/marvell/octeon_ep_vf/octep_vf_cn9k.c b/drivers/net/ethernet/marvell/octeon_ep_vf/octep_vf_cn9k.c
index 88937fce75f1..f1b7eda3fa42 100644
--- a/drivers/net/ethernet/marvell/octeon_ep_vf/octep_vf_cn9k.c
+++ b/drivers/net/ethernet/marvell/octeon_ep_vf/octep_vf_cn9k.c
@@ -273,8 +273,14 @@ static irqreturn_t octep_vf_ioq_intr_handler_cn93(void *data)
 	struct octep_vf_oq *oq;
 	u64 reg_val;
 
-	oct = vector->octep_vf_dev;
+	if (!vector)
+		return IRQ_HANDLED;
+
 	oq = vector->oq;
+	if (!oq)
+		return IRQ_HANDLED;
+
+	oct = vector->octep_vf_dev;
 	/* Mailbox interrupt arrives along with interrupt of tx/rx ring pair 0 */
 	if (oq->q_no == 0) {
 		reg_val = octep_vf_read_csr64(oct, CN93_VF_SDP_R_MBOX_PF_VF_INT(0));
-- 
2.25.1


