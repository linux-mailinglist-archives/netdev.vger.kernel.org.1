Return-Path: <netdev+bounces-180830-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D45E9A82A09
	for <lists+netdev@lfdr.de>; Wed,  9 Apr 2025 17:22:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A9DD61BC6958
	for <lists+netdev@lfdr.de>; Wed,  9 Apr 2025 15:16:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D04E32676E3;
	Wed,  9 Apr 2025 15:15:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="PdIFwprw"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F06022676DC;
	Wed,  9 Apr 2025 15:15:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744211743; cv=none; b=itlgSQCP3FsDgFbqI5qhX9CG9h6xLbcOgm83V8AvhJ3xYoQqjslbsDGDg/1hbHnu+9XYn8OzvfqPFGAd3IYB2HAToJjKAz6bnGtvPSZiHjfmIlruSSfRFSAnSgIoT8L8U041nxX+VlPkRdRikE8yZLdG0PLfu5IdQdc/RXEpcr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744211743; c=relaxed/simple;
	bh=Opub4nPFKe0dGEqqnAdG56suvfimC2NloMu5LJWvNkg=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=srvzejb1Sa71TQp8+Y7nwYF7PWkeqPtnvAs/Xw5fw2s4nCsQxPS0fF8Q9LUgaiIzV6VBv5TSDPbRBCJHJvdEZrySmBeQNyQq2ShFfaValHW5kRVB0Y20erFI0/oFhMjAn8jeU+yybvr7oqjRKAtkIzzLxWF6lrzn9jLK1GD07zU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=PdIFwprw; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5399wevp001338;
	Wed, 9 Apr 2025 08:15:19 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pfpt0220; bh=eoPBda+7E2pDFQFTGwL019q
	+LmJJfjxwNswlPkwFweM=; b=PdIFwprwyNoe/wKhEWV2EIKOYxk3IjUR059+8K6
	rFSGM7AgNQ3PrshfjEhsH10tNJabyYkoGGV7Y/wwNN4p/8TkxJPPF8ng/bbgloZe
	UKpiF6WDAjhhqfXTGI8QcfIaTSsQMMvFud3GgifTrqDo1rGw+AdqRpr+vuP5qi45
	+NOH5cUBOvKRE/SZ78hDn6mUUOe2npZKt6GnA413zx3UQE5rV6ivY2E2I+GPSutn
	u3/z5BKkn2ppcGgMk3MffjVSnvM1m6qNQ8DoY2ZzhFssiqXZZ61ZbeOJPFE61zay
	NuSnETQ8MRRJKbM1lzOwM/OYXfv8WzCSuQfyFNS6eJYiHoQ==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 45unnb084j-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 09 Apr 2025 08:15:18 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Wed, 9 Apr 2025 08:15:17 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Wed, 9 Apr 2025 08:15:17 -0700
Received: from sburla-PowerEdge-T630.sclab.marvell.com (unknown [10.106.27.217])
	by maili.marvell.com (Postfix) with ESMTP id 7F5753F7069;
	Wed,  9 Apr 2025 08:15:17 -0700 (PDT)
From: Sathesh B Edara <sedara@marvell.com>
To: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <hgani@marvell.com>, <vimleshk@marvell.com>,
        Veerasenareddy Burru
	<vburru@marvell.com>,
        Sathesh Edara <sedara@marvell.com>,
        Shinas Rasheed
	<srasheed@marvell.com>,
        Satananda Burla <sburla@marvell.com>,
        Andrew Lunn
	<andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        "Eric
 Dumazet" <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>
Subject: [PATCH net v1] octeon_ep_vf: Resolve netdevice usage count issue
Date: Wed, 9 Apr 2025 08:15:09 -0700
Message-ID: <20250409151509.31764-1-sedara@marvell.com>
X-Mailer: git-send-email 2.36.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: nh0IFZLiqJXd6Yl3FNMD1RA8PP21G0TU
X-Authority-Analysis: v=2.4 cv=E57Npbdl c=1 sm=1 tr=0 ts=67f68f06 cx=c_pps a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17 a=XR8D0OoHHMoA:10 a=M5GUcnROAAAA:8 a=21s9sNkdZRs4KDQlc5MA:9 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-ORIG-GUID: nh0IFZLiqJXd6Yl3FNMD1RA8PP21G0TU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-09_05,2025-04-08_04,2024-11-22_01

Address the netdevice usage count problem in the following scenarios:
- When the interface is down
- During transmit queue timeouts
Additionally, ensure all queues are stopped when the interface is down.

Signed-off-by: Sathesh B Edara <sedara@marvell.com>
---
 drivers/net/ethernet/marvell/octeon_ep_vf/octep_vf_main.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeon_ep_vf/octep_vf_main.c b/drivers/net/ethernet/marvell/octeon_ep_vf/octep_vf_main.c
index 18c922dd5fc6..f16b5930d414 100644
--- a/drivers/net/ethernet/marvell/octeon_ep_vf/octep_vf_main.c
+++ b/drivers/net/ethernet/marvell/octeon_ep_vf/octep_vf_main.c
@@ -526,6 +526,7 @@ static int octep_vf_stop(struct net_device *netdev)
 	netdev_info(netdev, "Stopping the device ...\n");
 
 	/* Stop Tx from stack */
+	netif_tx_stop_all_queues(netdev);
 	netif_carrier_off(netdev);
 	netif_tx_disable(netdev);
 
@@ -819,7 +820,6 @@ static void octep_vf_tx_timeout_task(struct work_struct *work)
 		octep_vf_open(netdev);
 	}
 	rtnl_unlock();
-	netdev_put(netdev, NULL);
 }
 
 /**
@@ -834,7 +834,6 @@ static void octep_vf_tx_timeout(struct net_device *netdev, unsigned int txqueue)
 {
 	struct octep_vf_device *oct = netdev_priv(netdev);
 
-	netdev_hold(netdev, NULL, GFP_ATOMIC);
 	schedule_work(&oct->tx_timeout_task);
 }
 
-- 
2.36.0


