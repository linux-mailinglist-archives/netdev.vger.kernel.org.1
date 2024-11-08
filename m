Return-Path: <netdev+bounces-143226-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E8E6D9C173C
	for <lists+netdev@lfdr.de>; Fri,  8 Nov 2024 08:47:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F1CA51C213BE
	for <lists+netdev@lfdr.de>; Fri,  8 Nov 2024 07:47:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72AB91E1023;
	Fri,  8 Nov 2024 07:46:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="Lr9MuHFN"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE81B1D27B9;
	Fri,  8 Nov 2024 07:46:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731051974; cv=none; b=h+xBZsTW0+yb6Ml8sNrUK4dMNlFTkGEo0ho+Qvjq28QarDHnTPe/WGNjA/BkIOe7ANARG44aknCdGDZomkRF/hR9LnOLOwhFQbmrFJYpcoTW1vQLy2yTlVYaXXr8n9fDXt4Rw7l/EWRbeJUbFHvMx8RlOqngPGQzLav7HwuEixI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731051974; c=relaxed/simple;
	bh=nkxULcvJe6TBcUSBEXf9M0DtZuqy+0Qand37ThuOZv0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZeQ/hhtJbriZvEo8Bc8aa7f2cSBWzEkI6UNsHircWvXzXaTHE37mrswPf0ZyIdQm/zJ7vF6dLf19Bj2kXGCxH6YB3O6668SMF9bchsuL7rki4UZ3k1AfVg7Xy945s9prZktByUFGHSM9/B0Pk9kXKKPo6smmxNDs/DELqHZWy68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=Lr9MuHFN; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4A81ghb2019272;
	Thu, 7 Nov 2024 23:45:55 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pfpt0220; bh=Z
	46/52708qnB7GFWEYR2f+Qfh9tmbXsvJQ79iUGzw54=; b=Lr9MuHFNo4KKNffdl
	U5N7TsBqgFyumhrY7FB+N5tvnN9Ri5pCejXI/eikbdfWJ7bTRISNgb2GeqJTGvoJ
	8BKO0acvIfNKAkO4uSBDmgrxapNrB/hlm1hWTYqYx+pYOc2fkx52QnGxArrRpkwG
	ZWBqaZyIsy6xiBiPSVWgdCrVicHC7iGJ1g83tE4u4WFyTmXdu/9qRTujCVcheGJj
	v+ezMV/cCkWMmevhCS3JknCPFJtuTwJRD99NJwER6Rp7CwrHh5UPursHVqj8cvrE
	+H2Lw+v3kNEOr+mUXZVeFrhVy+2cC1Afks9XrIsR63xuClXLX3b6IqqhAojwszJf
	KKbNQ==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 42s97hrkt5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 07 Nov 2024 23:45:55 -0800 (PST)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Thu, 7 Nov 2024 23:45:54 -0800
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Thu, 7 Nov 2024 23:45:54 -0800
Received: from ubuntu-PowerEdge-T110-II.sclab.marvell.com (unknown [10.106.27.86])
	by maili.marvell.com (Postfix) with ESMTP id B892E3F7082;
	Thu,  7 Nov 2024 23:45:53 -0800 (PST)
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
Subject: [PATCH net v3 5/7] octeon_ep_vf: Fix null dereferences to IQ/OQ pointers
Date: Thu, 7 Nov 2024 23:45:41 -0800
Message-ID: <20241108074543.1123036-6-srasheed@marvell.com>
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
X-Proofpoint-ORIG-GUID: ysRrBnL08M9O4BQXBH62S6YY1PrPbWtg
X-Proofpoint-GUID: ysRrBnL08M9O4BQXBH62S6YY1PrPbWtg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.687,Hydra:6.0.235,FMLib:17.0.607.475
 definitions=2020-10-13_15,2020-10-13_02,2020-04-07_01

During unload, sometimes race scenarios are seen wherein
the get stats callback proceeds to retrieve the IQ/OQ stats,
but by then the IQ/OQ might have been already freed.

Protect against such conditions by defensively checking if
the IQ/OQ pointers are null before dereference.

Fixes: cb7dd712189f ("octeon_ep_vf: Add driver framework and device initialization")
Signed-off-by: Shinas Rasheed <srasheed@marvell.com>
---
V3:
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


