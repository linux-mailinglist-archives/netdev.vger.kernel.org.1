Return-Path: <netdev+bounces-144380-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2325F9C6D95
	for <lists+netdev@lfdr.de>; Wed, 13 Nov 2024 12:17:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6FB9E280DA5
	for <lists+netdev@lfdr.de>; Wed, 13 Nov 2024 11:17:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E078820263C;
	Wed, 13 Nov 2024 11:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="PIjkO8xO"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A21B201107;
	Wed, 13 Nov 2024 11:13:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731496432; cv=none; b=l+kqZ+MypGQIzNi6xqLkYGUEfO/nXbwMgPOujNsIcUUfHlt4ZDjnGmBhxiiF6qOkHjzGF+1QOo6bNmzRlDvnjZVNSG1yzYRmhA+/E69mbrFlwTreV6Xra0ByrDahTO0LT9MW1/G17Z5WfxdPQuI3EO2zDzRI8DxIKseTZUELYo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731496432; c=relaxed/simple;
	bh=Kcv9vW/h+pRyUCOwyvm4I27brOJxtSd+K9TD2MRq2WI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=X0JZqLSBNqzSc1j4hUXufKokxV1fVS6lwIEi6u2kaiG2vl6FspLyXLImCDlDrjIj/PTmdPBysYWg/SzGXjtXFuYhgI7QQm6/Mv95tchaOo3hWqMsqiKoPVho6kEPCA9+X3uBGlwY04Sb1rVeFXRHoHGUnmgxR4WI4rI0j+C3buE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=PIjkO8xO; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AD9Avi8004399;
	Wed, 13 Nov 2024 03:13:32 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pfpt0220; bh=K
	F2s5RfoDycLzT2yfVRC3OhmwODgdcdCut7RX5aUXlA=; b=PIjkO8xOsqzNo484R
	rL+HBlWDo7bhbSiWFjJpBark+0lxgL9aTlSMnKHPrU+tN0iiiboAoI/OZ8iLQ8Z8
	UTBMUEBfhT5X+mhiuY85/U8nQX7F2O5Eg2hMOx9pMhFxaXsRV2snEGrmPP3voSVc
	Aqx2N2ZCUYI4eKInxgKguqRJdSQZIomOxcD5dNftg9sgF/qK43ru+kg/eMT2n+5S
	Xzi3PYOEOyPj8P96As31SyEwt3IDdEAl9maFyMCETNZEN8iIMaFIBQZgGyBcyK9a
	4DFhIIo3WFKnu7qySvYkUdqUZuHGfDQ7Fefh+F+JpMcrUhv35g1NKLV+8rnxR5t0
	dKRsg==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 42vs8g06dg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 13 Nov 2024 03:13:32 -0800 (PST)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Wed, 13 Nov 2024 03:13:30 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Wed, 13 Nov 2024 03:13:30 -0800
Received: from ubuntu-PowerEdge-T110-II.sclab.marvell.com (unknown [10.106.27.86])
	by maili.marvell.com (Postfix) with ESMTP id 87A5A3F7040;
	Wed, 13 Nov 2024 03:13:30 -0800 (PST)
From: Shinas Rasheed <srasheed@marvell.com>
To: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <hgani@marvell.com>, <sedara@marvell.com>, <vimleshk@marvell.com>,
        <thaller@redhat.com>, <wizhao@redhat.com>, <kheib@redhat.com>,
        <egallen@redhat.com>, <konguyen@redhat.com>, <horms@kernel.org>,
        "Shinas
 Rasheed" <srasheed@marvell.com>,
        Veerasenareddy Burru <vburru@marvell.com>,
        Satananda Burla <sburla@marvell.com>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH net v4 5/7] octeon_ep_vf: Fix null dereferences to IQ/OQ pointers
Date: Wed, 13 Nov 2024 03:13:17 -0800
Message-ID: <20241113111319.1156507-6-srasheed@marvell.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241113111319.1156507-1-srasheed@marvell.com>
References: <20241113111319.1156507-1-srasheed@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: DA1GuFKul9rV9QWxxtoBZTNY0TASVl0S
X-Proofpoint-ORIG-GUID: DA1GuFKul9rV9QWxxtoBZTNY0TASVl0S
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01

During unload, sometimes race scenarios are seen wherein
the get stats callback proceeds to retrieve the IQ/OQ stats,
but by then the IQ/OQ might have been already freed.

Protect against such conditions by defensively checking if
the IQ/OQ pointers are null before dereference.

Fixes: cb7dd712189f ("octeon_ep_vf: Add driver framework and device initialization")
Signed-off-by: Shinas Rasheed <srasheed@marvell.com>
---
V4:
  - No Changes

V3: https://lore.kernel.org/all/20241108074543.1123036-6-srasheed@marvell.com/
  - Added back "Fixes" to the changelist

V2: https://lore.kernel.org/all/20241107132846.1118835-6-srasheed@marvell.com/
  - Split into a separate patch
  - Added more context

V1: https://lore.kernel.org/all/20241101103416.1064930-4-srasheed@marvell.com/

 drivers/net/ethernet/marvell/octeon_ep_vf/octep_vf_main.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/ethernet/marvell/octeon_ep_vf/octep_vf_main.c b/drivers/net/ethernet/marvell/octeon_ep_vf/octep_vf_main.c
index 7e6771c9cdbb..79d9ffd593eb 100644
--- a/drivers/net/ethernet/marvell/octeon_ep_vf/octep_vf_main.c
+++ b/drivers/net/ethernet/marvell/octeon_ep_vf/octep_vf_main.c
@@ -790,6 +790,9 @@ static void octep_vf_get_stats64(struct net_device *netdev,
 		struct octep_vf_iq *iq = oct->iq[q];
 		struct octep_vf_oq *oq = oct->oq[q];
 
+		if (!iq || !oq)
+			return;
+
 		tx_packets += iq->stats.instr_completed;
 		tx_bytes += iq->stats.bytes_sent;
 		rx_packets += oq->stats.packets;
-- 
2.25.1


