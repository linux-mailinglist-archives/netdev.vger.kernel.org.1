Return-Path: <netdev+bounces-154708-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 79BD19FF8AA
	for <lists+netdev@lfdr.de>; Thu,  2 Jan 2025 12:23:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A9AB51882B93
	for <lists+netdev@lfdr.de>; Thu,  2 Jan 2025 11:23:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81F251A38E3;
	Thu,  2 Jan 2025 11:23:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="W+Twyoly"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6C021A8408;
	Thu,  2 Jan 2025 11:23:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735817009; cv=none; b=R93A9KgcQrHzX9Ba48wAhUJ9XmqlgZn38fg29Tix19RD6NW1i7BzcCE/AtkoFU9tDPIVgBA8om831nvlotyJRwz30XcSMuN40uZJvX0QzoB5V9HVwolqc8WcdPs8bBUSNTMrMZgWA1Ym05fm0t2aIgtT+ozL8idR1xbA328v1qY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735817009; c=relaxed/simple;
	bh=MOQMeSIQO7U5yYoK/IjRKrjGxVHpPBy4mc41c5kVDnE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QljL/1qg05jjXOlWI9OJanCrsqaYlDrnq4noogdsGhZnHF+nUow9IuoayQ2/A4mW2VzZE1uudFFes9sahzh8zfEDFAiXNw0rDIlI3GfLf628sqhlZAWKOkk2819z8cut3Ov+39t6lKzEZv//SgPljunIWIgSjnNE3NQOM0e+7dc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=W+Twyoly; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50296eg2032682;
	Thu, 2 Jan 2025 03:23:01 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pfpt0220; bh=F
	mLlLBupTsRITUFy9f5Omy2qiAtzwiJFTFpWlSufOTk=; b=W+TwyolywSir8tOAy
	2x5kCiIu5fiF3htQqYmuXRlGphy10YdfUJGt4zjvhXMvLTPzhmMO85J7N6zMU+WA
	jlKHviE0R0NYJpb/5+zq3XWngkROvpyUNZHgkKt3f3SOX69lxyfgSWcGgP2DSHjs
	U5BSyVguLHJsUOSaH7NHX1b9nATtFqaSSue1ny3kFoYTYN1NqARcM2NBqltJK8Bk
	/vOFf3Z6KIATgWgm+dSy887WV8tWsff0VA+ofzyvkVUP7+LfMNGXaBcRxcV3CUsH
	uysAk2stm9U8oqMy7ykAKqpNA7Yo3xUvVoutcaRnuuHsOlCdUg4yz/bGNbueGh0O
	6vdvA==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 43wqvmr5u8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 02 Jan 2025 03:23:01 -0800 (PST)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Thu, 2 Jan 2025 03:22:59 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Thu, 2 Jan 2025 03:22:59 -0800
Received: from ubuntu-PowerEdge-T110-II.sclab.marvell.com (unknown [10.106.27.86])
	by maili.marvell.com (Postfix) with ESMTP id CEC853F708C;
	Thu,  2 Jan 2025 03:22:58 -0800 (PST)
From: Shinas Rasheed <srasheed@marvell.com>
To: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <hgani@marvell.com>, <sedara@marvell.com>, <vimleshk@marvell.com>,
        <thaller@redhat.com>, <wizhao@redhat.com>, <kheib@redhat.com>,
        <konguyen@redhat.com>, <horms@kernel.org>, <einstein.xue@synaxg.com>,
        "Shinas
 Rasheed" <srasheed@marvell.com>,
        Veerasenareddy Burru <vburru@marvell.com>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        "Paolo
 Abeni" <pabeni@redhat.com>,
        Abhijit Ayarekar <aayarekar@marvell.com>,
        Satananda Burla <sburla@marvell.com>
Subject: [PATCH net v4 1/4] octeon_ep: fix race conditions in ndo_get_stats64
Date: Thu, 2 Jan 2025 03:22:43 -0800
Message-ID: <20250102112246.2494230-2-srasheed@marvell.com>
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
X-Proofpoint-GUID: RCmfcWYVQPNxIgPuSxOlxwI1_WGJXzcC
X-Proofpoint-ORIG-GUID: RCmfcWYVQPNxIgPuSxOlxwI1_WGJXzcC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.687,Hydra:6.0.235,FMLib:17.0.607.475
 definitions=2020-10-13_15,2020-10-13_02,2020-04-07_01

ndo_get_stats64() can race with ndo_stop(), which frees input and
output queue resources. Check if netdev is running before accessing
per queue resources.

Fixes: 6a610a46bad1 ("octeon_ep: add support for ndo ops")
Signed-off-by: Shinas Rasheed <srasheed@marvell.com>
---
V4:
  - Check if netdev is running, as decision for accessing resources
    rather than availing lock implementations, in ndo_get_stats64()

V3: https://lore.kernel.org/all/20241218115111.2407958-2-srasheed@marvell.com/
  - No changes 

V2: https://lore.kernel.org/all/20241216075842.2394606-2-srasheed@marvell.com/
  - Changed sync mechanism to fix race conditions from using an atomic
    set_bit ops to a much simpler synchronize_net()

V1: https://lore.kernel.org/all/20241203072130.2316913-2-srasheed@marvell.com/

 drivers/net/ethernet/marvell/octeon_ep/octep_main.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeon_ep/octep_main.c b/drivers/net/ethernet/marvell/octeon_ep/octep_main.c
index 549436efc204..a452ee3b9a98 100644
--- a/drivers/net/ethernet/marvell/octeon_ep/octep_main.c
+++ b/drivers/net/ethernet/marvell/octeon_ep/octep_main.c
@@ -995,16 +995,14 @@ static void octep_get_stats64(struct net_device *netdev,
 	struct octep_device *oct = netdev_priv(netdev);
 	int q;
 
-	if (netif_running(netdev))
-		octep_ctrl_net_get_if_stats(oct,
-					    OCTEP_CTRL_NET_INVALID_VFID,
-					    &oct->iface_rx_stats,
-					    &oct->iface_tx_stats);
-
 	tx_packets = 0;
 	tx_bytes = 0;
 	rx_packets = 0;
 	rx_bytes = 0;
+
+	if (!netif_running(netdev))
+		return;
+
 	for (q = 0; q < oct->num_oqs; q++) {
 		struct octep_iq *iq = oct->iq[q];
 		struct octep_oq *oq = oct->oq[q];
-- 
2.25.1


