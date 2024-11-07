Return-Path: <netdev+bounces-142846-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D8C69C0773
	for <lists+netdev@lfdr.de>; Thu,  7 Nov 2024 14:31:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B30771F2190D
	for <lists+netdev@lfdr.de>; Thu,  7 Nov 2024 13:31:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 324092144A5;
	Thu,  7 Nov 2024 13:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="TvDsO0Mk"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93ECB213ECC;
	Thu,  7 Nov 2024 13:29:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730986162; cv=none; b=HmBQJJXRlr/VXnkqUhUMXDiWKE1tILfGx9RPcAqwqq46lEbQvJxfbYKXpsnxsJt0dKICkq6nkOXaWuY32+G41tLPAdxfQe1IyAV/OgStDPbfgtda9MPEIANAwaafw2+CldGHTDn0R0xzwIfC1gKdinoKg/eu0XOFG+JrOYfFFQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730986162; c=relaxed/simple;
	bh=oYMTDUpQKwAiuegxgWjVOkp+luvlh3tBlqqQhPmIv1k=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UYNbTiqmvc4MirGnZoq9OQdwiY1JHSvu/EGE5Sq4l0MSMUOiIS0WqD59t8+aXTL+PdznSrxAspYySTlUPxzBl/2XLe5ML8eJnH7Y5l2EuiZM5gK775JHS5m/YbG4pDOe94hd1HRpxNsgJhxzPFXWdfSd5zOZfmY7cawOAcY6KVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=TvDsO0Mk; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4A7Ca4a2018104;
	Thu, 7 Nov 2024 05:29:05 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pfpt0220; bh=i
	mSw1KER3ojqKjXN9Rv3WdQo2LFZamVC5UDTRcqdJSs=; b=TvDsO0MkIrYR25y4G
	dHrfKpyrb5RZvDF9pULOkpVbi3Chn0HmWieMGHrdUGmGUxrAP3uo0mA6ueEBWxNK
	IeAB47MDOfuN4WWYhb5kdsYpu/zl5f35aHibIQoJbunAFW0Z6y7WF7rmCL+o/c+d
	u9LU0YPJagoRMApbCKHbfj/7N2y9dhoedw2SgckK0zvktQ7T/8+AT2v1yx24BkVC
	p/TDg8suEi+t9P9zzB6eoT4ZZH1vafUou66OlP+Iu/wZRlQpXXnjiZdK1cD4eG2a
	MXNAI6q906GB8p3Vo1+7gOcX4qhYBLtplfMUclJ1KoBFIELIu7xcL0mhvPW/c9vI
	jskdQ==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 42rwpng3hu-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 07 Nov 2024 05:29:04 -0800 (PST)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Thu, 7 Nov 2024 05:29:04 -0800
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Thu, 7 Nov 2024 05:29:04 -0800
Received: from ubuntu-PowerEdge-T110-II.sclab.marvell.com (unknown [10.106.27.86])
	by maili.marvell.com (Postfix) with ESMTP id 6F4263F708C;
	Thu,  7 Nov 2024 05:29:03 -0800 (PST)
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
Subject: [PATCH net v2 5/7] octeon_ep_vf: Fix null dereferences to IQ/OQ pointers
Date: Thu, 7 Nov 2024 05:28:44 -0800
Message-ID: <20241107132846.1118835-6-srasheed@marvell.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241107132846.1118835-1-srasheed@marvell.com>
References: <20241107132846.1118835-1-srasheed@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: EvKLcglebSe3BXe5zh0_bAfKslgJn85u
X-Proofpoint-ORIG-GUID: EvKLcglebSe3BXe5zh0_bAfKslgJn85u
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.687,Hydra:6.0.235,FMLib:17.0.607.475
 definitions=2020-10-13_15,2020-10-13_02,2020-04-07_01

During unload, sometimes race scenarios are seen wherein
the get stats callback proceeds to retrieve the IQ/OQ stats,
but by then the IQ/OQ might have been already freed.

Protect against such conditions by defensively checking if
the IQ/OQ pointers are null before dereference.

Signed-off-by: Shinas Rasheed <srasheed@marvell.com>
---
V2:
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


