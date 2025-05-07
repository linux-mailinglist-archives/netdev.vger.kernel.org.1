Return-Path: <netdev+bounces-188757-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E928BAAE7F0
	for <lists+netdev@lfdr.de>; Wed,  7 May 2025 19:36:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5967A50822D
	for <lists+netdev@lfdr.de>; Wed,  7 May 2025 17:36:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05BCA28CF4D;
	Wed,  7 May 2025 17:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="M2NGSgF6"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDA9B28CF44
	for <netdev@vger.kernel.org>; Wed,  7 May 2025 17:36:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746639370; cv=none; b=HipLNsFlUY5ptfK5eV6FEgftn9GJkTsbWXON04i4TRdnKr+5DowuRq7XjD7Cq39ufaWRfXt8Bgwq/9POMrvQh2gMgi55W6crd7DnZHUYrURbU0tXupotOYlqw2tF0NoR+ZcYsuGFL1jJ+5R7kqW0b+gNPIrSd14IOQDopkwGNQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746639370; c=relaxed/simple;
	bh=yjNQFfYHnsSlu9oV5t/urGkzPEPJMJ/DfUcr1X8fC/8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=i+tCjyM3ujcMGXNh4pZgKIAl34gO7BYsCubpYb4EjxanIo6DaYgw0pD5lUku7UrHHlpJD2yt5Num9GGtxgyygbiivO/GRZDo1EVYPG/qd31ovJuv3Aj6zpNy11SmzMGMJxePWVus4QPWEYE5ti52xxX0/KeAGCk7HHeYQ3g/rSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=M2NGSgF6; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5476ZMQM002041;
	Wed, 7 May 2025 10:14:30 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-type:date:from:message-id:mime-version:subject:to; s=
	pfpt0220; bh=F9j3Kj+m+B8wtA0h2FFEtQd4GNSz0p0I3dTxH3VjXLk=; b=M2N
	GSgF6XIN8APYHghshCenGShl8gXJlmnjkpM5Z39s7J+F8P2TREOk3VAUQrduPB8s
	kxovr91pu1ZHjsTGHItmoVeEom9cgCEL6OxQRFTrKOLfcyzX0XS2qMQzIpseMDou
	/RDscEiI4oyfQrmPrSITc9KRAiq1yW7uhewjeagKVyR98wUeR6RIPXvFbExBoY8W
	tKeb1XXKoUt/IFBpxAEAPWxcLW5SDfk/LB208ISpMYlP8YT12RyyzJrowE04DAMI
	F8eH7O01Xx/0qb9uEmmpZq09orsDGhg2/lbFKbMG7m+46uGXjWbSDfOE68EkxG1m
	B9hhH5DM32gcefbMwvA==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 46g2c89d56-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 07 May 2025 10:14:30 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Wed, 7 May 2025 10:14:29 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Wed, 7 May 2025 10:14:29 -0700
Received: from hyd1358.marvell.com (unknown [10.29.37.11])
	by maili.marvell.com (Postfix) with ESMTP id 4ABF83F708A;
	Wed,  7 May 2025 10:14:25 -0700 (PDT)
From: Subbaraya Sundeep <sbhatta@marvell.com>
To: <sd@queasysnail.net>, <andrew+netdev@lunn.ch>, <davem@davemloft.net>,
        <edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
        <horms@kernel.org>, <gakula@marvell.com>, <hkelam@marvell.com>,
        <sgoutham@marvell.com>
CC: <netdev@vger.kernel.org>, Subbaraya Sundeep <sbhatta@marvell.com>
Subject: [PATCH] octeontx2-pf: macsec: Fix incorrect MTU size in TX secy policy
Date: Wed, 7 May 2025 22:44:20 +0530
Message-ID: <1746638060-10419-1-git-send-email-sbhatta@marvell.com>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: ztLOo_1Fe5Uh6wNE5eJFJb4I9Y1p2y2C
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTA3MDE1OSBTYWx0ZWRfX4lzYPmVhsE2T rfVzW1rUddnmYLIkQNgt6y6FEmpFASJ+ICmee8bGrt0pz8vhjJaZSzX7IkoS+aKmZM/DR0z7GJu QrGZ1bDyiUD7Sx5MkhLG4G7OBxeVWaOvvI78BU7Vg7GuGIIor8im0d1/pT9iw/h2qxzuLdOd5+F
 4+yCd2ROn27hc6u7afd7DfzInoi1c8wC4sd3CSh5n4vdn2MXEKGHGzEM6m7KfqyWpUb2QxYvwdq StIWMsEJ8ukVrsAgs51aXPX1uJ2mtlJRrtu+dblWQGIAn6yE8/nMrAgLCf1knzJRfohMuUSn/48 9FY29TfSA3CkmJzmlvdDGrlNI+0gnBKnhEvFgWOhKKrsulfBXX4+4XZ22o1MhTDXVBTueBlacJZ
 hSg3tlyoS12awltZGvkt4pNUMw8oljH8ZLq+yHqI6LGNWRD+uqJfZiVh0uPNOgHwYRtd0iZb
X-Proofpoint-GUID: ztLOo_1Fe5Uh6wNE5eJFJb4I9Y1p2y2C
X-Authority-Analysis: v=2.4 cv=Tc2WtQQh c=1 sm=1 tr=0 ts=681b94f6 cx=c_pps a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17 a=dt9VzEwgFbYA:10 a=M5GUcnROAAAA:8 a=Qv9XQcIsZFxj3cm0Ll4A:9 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-07_05,2025-05-06_01,2025-02-21_01

Underlying real device MTU plus the L2 header length has to
be configured in TX secy policy because hardware expects the
mtu to be programmed is outgoing maximum transmission unit from
MCS block i.e, including L2 header, SecTag and ICV.

Fixes: c54ffc73601c ("octeontx2-pf: mcs: Introduce MACSEC hardware offloading")
Signed-off-by: Subbaraya Sundeep <sbhatta@marvell.com>
---
 drivers/net/ethernet/marvell/octeontx2/nic/cn10k_macsec.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/cn10k_macsec.c b/drivers/net/ethernet/marvell/octeontx2/nic/cn10k_macsec.c
index f3b9daf..4c7e0f3 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/cn10k_macsec.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/cn10k_macsec.c
@@ -531,7 +531,8 @@ static int cn10k_mcs_write_tx_secy(struct otx2_nic *pfvf,
 	if (sw_tx_sc->encrypt)
 		sectag_tci |= (MCS_TCI_E | MCS_TCI_C);
 
-	policy = FIELD_PREP(MCS_TX_SECY_PLCY_MTU, secy->netdev->mtu);
+	policy = FIELD_PREP(MCS_TX_SECY_PLCY_MTU,
+			    pfvf->netdev->mtu + OTX2_ETH_HLEN);
 	/* Write SecTag excluding AN bits(1..0) */
 	policy |= FIELD_PREP(MCS_TX_SECY_PLCY_ST_TCI, sectag_tci >> 2);
 	policy |= FIELD_PREP(MCS_TX_SECY_PLCY_ST_OFFSET, tag_offset);
-- 
2.7.4


