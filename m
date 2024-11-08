Return-Path: <netdev+bounces-143225-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E47E9C1739
	for <lists+netdev@lfdr.de>; Fri,  8 Nov 2024 08:47:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A9CFBB20EBF
	for <lists+netdev@lfdr.de>; Fri,  8 Nov 2024 07:47:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 821B11E0B67;
	Fri,  8 Nov 2024 07:46:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="Kwb0tAGs"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFA731DFE16;
	Fri,  8 Nov 2024 07:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731051972; cv=none; b=jR/g6m0BOYjP+QA2V6g5iJ4kM/sUQbcB2ViMcpXEjkqYweNbypffIyaRaCl24zWibq10wDGQ+XN9I6eV8K6O8mdPUl+/bR2foWmZhQWRiQNZJcgevoRrdwIcjnNAbO+KmLqzsn9oW1tgK+hWpyIJTogiTt/5OMKBtH9ARMZBf/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731051972; c=relaxed/simple;
	bh=tyl6DetRIGomzC9jMz9Z7Qx0KQHSlG7fjBngCq7flTs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IG+WgRJmK/ETQJ4R/mne0xByZC9KAu9NU97YjCV52PR0n2RYmWg4/wMtx5r4ceUUgGtgk4N1eOxP2awRk19LrZeZJncy9SLwGrbGqlTEiD1nz1dGEsfAOzieUgW+P8t32yCaZlvtQrAlHKq5OFO1nILQL79PdWJnmIO1m0hv2qQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=Kwb0tAGs; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4A84EBd5027930;
	Thu, 7 Nov 2024 23:45:50 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pfpt0220; bh=M
	+6XUeEE3PTM8KsoMjpV/QxUzjZXDSpsAR5nchr3p7o=; b=Kwb0tAGsPK545Ksyo
	VZLvtcITULoYPLhVnIXUkN3tafimZBmLX/tgAgAVozP9cXl2FgayuVtsyf2jyq52
	MJXTxvxnAokNKA/ZIhzwRKCCDouat7t+/Ae7KiY+mMT+6XJyydbu0tzZCz3OL2aO
	hQrb6In5cHF7JiZAexX8XA6ur5v9uAAF5RRClQPIYPKfhULI6y9sLRlLc6zV10U3
	0jzJKMVdMZWFUg+9RrTqufHL5yO+dhqfoM+p3zdQvCB1heoAqFFsJRqNv8trf2na
	iHXxfcS7tbvtllzn1oDt2zhFkH6bR/1HQ1fWK0QSsVS4xjte5YidFaRSNCdzS/4X
	6QMBw==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 42sbdq0brn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 07 Nov 2024 23:45:50 -0800 (PST)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Thu, 7 Nov 2024 23:45:49 -0800
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Thu, 7 Nov 2024 23:45:49 -0800
Received: from ubuntu-PowerEdge-T110-II.sclab.marvell.com (unknown [10.106.27.86])
	by maili.marvell.com (Postfix) with ESMTP id CE9103F7082;
	Thu,  7 Nov 2024 23:45:48 -0800 (PST)
From: Shinas Rasheed <srasheed@marvell.com>
To: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <hgani@marvell.com>, <sedara@marvell.com>, <vimleshk@marvell.com>,
        <thaller@redhat.com>, <wizhao@redhat.com>, <kheib@redhat.com>,
        <egallen@redhat.com>, <konguyen@redhat.com>, <horms@kernel.org>,
        <frank.feng@synaxg.com>, Shinas Rasheed <srasheed@marvell.com>,
        Veerasenareddy Burru <vburru@marvell.com>,
        Andrew Lunn
	<andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        "Eric
 Dumazet" <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>,
        Satananda Burla <sburla@marvell.com>,
        Abhijit Ayarekar
	<aayarekar@marvell.com>
Subject: [PATCH net v3 2/7] octeon_ep: Fix null dereferences to IQ/OQ pointers
Date: Thu, 7 Nov 2024 23:45:38 -0800
Message-ID: <20241108074543.1123036-3-srasheed@marvell.com>
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
X-Proofpoint-ORIG-GUID: dgadC9g8F6AARZX3rYg9FpzoJwTVf4tz
X-Proofpoint-GUID: dgadC9g8F6AARZX3rYg9FpzoJwTVf4tz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01

During unload, sometimes race scenarios are seen wherein
the get stats callback proceeds to retrieve the IQ/OQ stats,
but by then the IQ/OQ might have been already freed.

Protect against such conditions by defensively checking if
the IQ/OQ pointers are null before dereference.

Fixes: 6a610a46bad1 ("octeon_ep: add support for ndo ops")
Signed-off-by: Shinas Rasheed <srasheed@marvell.com>
---
V3:
  - Added back "Fixes" to the changelist

V2: https://lore.kernel.org/all/20241107132846.1118835-3-srasheed@marvell.com/
  - Split from earlier patch into a separate patch
  - Added more context

V2: https://lore.kernel.org/all/20241101103416.1064930-3-srasheed@marvell.com/

 drivers/net/ethernet/marvell/octeon_ep/octep_main.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/ethernet/marvell/octeon_ep/octep_main.c b/drivers/net/ethernet/marvell/octeon_ep/octep_main.c
index ff72b796bd25..dc783c568e2c 100644
--- a/drivers/net/ethernet/marvell/octeon_ep/octep_main.c
+++ b/drivers/net/ethernet/marvell/octeon_ep/octep_main.c
@@ -1016,6 +1016,9 @@ static void octep_get_stats64(struct net_device *netdev,
 		struct octep_iq *iq = oct->iq[q];
 		struct octep_oq *oq = oct->oq[q];
 
+		if (!iq || !oq)
+			return;
+
 		tx_packets += iq->stats.instr_completed;
 		tx_bytes += iq->stats.bytes_sent;
 		rx_packets += oq->stats.packets;
-- 
2.25.1


