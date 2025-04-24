Return-Path: <netdev+bounces-185576-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BDC46A9AF85
	for <lists+netdev@lfdr.de>; Thu, 24 Apr 2025 15:43:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 40E9319471C8
	for <lists+netdev@lfdr.de>; Thu, 24 Apr 2025 13:42:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 050341991CA;
	Thu, 24 Apr 2025 13:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="dma4GDPQ"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35D9B1714C0;
	Thu, 24 Apr 2025 13:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745502013; cv=none; b=gqvGUy69TIyMJhDyEQ4LxpveR2ANj2oM1q5HB7d1aH7uYLgyfHrBCKnNS9Q1e+E4dofzIX1B/XGAJjILbPkAYsWHTWhOnrHjp6daq1SLK3S9lCAdl/o0+Pl337dR72Ouh22OaTg6JUf1kuCxuDWjjXAS9tzXL5MJUVuYEkcOtZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745502013; c=relaxed/simple;
	bh=WNVh7tygfoiFgZaCQgWgFAS/qPKxHBo6D2riBfing+s=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=KeD+0hmF63cp6ygFYt4UpPSdBoXtTIikNZ2biWRgzAG3lyjx0VqURY5mqJ8Ps1wWlJJSt5L46tOaYmhPSQohv8b1WwfE7l6fG1dnbMjSn2aXwY4xOpSKohiHlqFJ0Y1AjTa9E3jPVp4ALLUkbhyVgJCtcbZqBhvCSArrXZCoxBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=dma4GDPQ; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53O9tPm3013233;
	Thu, 24 Apr 2025 06:39:50 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pfpt0220; bh=CU0d/r5e/U6sSuIGXRTfQaz
	KLqe5aduPx61hXTT7Ohs=; b=dma4GDPQnvLLgunjRHJvPfycf4pXdk9W8x3odmM
	ubq1Fvy9lLO2ex2HKTHq/QmWvhkJBrM+lWjjDj9HIWrxZkxxHlkpUAElNq5SQFBW
	CRlKjia5GIQetLu8SA2qxrqvSUX6FkSZwgYN0YBPBiWP42GxKZDbs+BxrEiPWayt
	BKzE+ro+Euo+ryPLdKhvHZVc8mgHeg6mNVBTZkB4AgdkxT5fhitpRMLeBMHIvy/1
	bGkz3sYOF66YwDV+JgKP4qGYLDfPwGOLq0YptdatrL8lReUb4djRSO8IhPhh9Ad+
	Id7pguEXBpY+XFT+yZ/sdby5NOGjm22+bUAtrE+N33WLqTQ==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 466jk34p9f-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 24 Apr 2025 06:39:50 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Thu, 24 Apr 2025 06:39:49 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Thu, 24 Apr 2025 06:39:49 -0700
Received: from sburla-PowerEdge-T630.sclab.marvell.com (unknown [10.106.27.217])
	by maili.marvell.com (Postfix) with ESMTP id 3EB3C3F7062;
	Thu, 24 Apr 2025 06:39:49 -0700 (PDT)
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
Subject: [PATCH net v4] octeon_ep_vf: Resolve netdevice usage count issue
Date: Thu, 24 Apr 2025 06:39:44 -0700
Message-ID: <20250424133944.28128-1-sedara@marvell.com>
X-Mailer: git-send-email 2.36.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDI0MDA5MiBTYWx0ZWRfXzk+oDn7YhG+s rpFC4rbhkdC+BrN26/XidEhVof13JYdztNqhAOblWbStET8AW1CeXE1dcv6pthCrbdX1TW4BGgz 71iRlW1FPXQ10vvkQukMr8O7hiB1MP2UqvNubv84cIPterbBdrc7KDVHtVA9eGpbaNqdvvScQHq
 0JMYqs0fwb96FF6t7EiKCCBaSdMwsxgVl+GM6JBK8Cnpn0m2uaTcohCvs5g1FMho+zCeLKgsA/2 Z+e1UyYUjRIVSSDjlNgV3lGJNPOU8mxrOsmPBU8MRjobFWBMALU6hm3JmwG+ZQ6vDJaByyk6C++ D1NQUcu8SHn0+DntcRa4raOJ+O9VS+a3y5VnCmEtR1P/wy1A1XjAKT7RpwExTk9FMngn8poYyyv
 dhJ2NCcoaYX/pguqexFAkmNaH0Gbt6Z/g/kmdHUBTWnO2o0UpE4U8b/vuTd84e0fsnkD5AGD
X-Proofpoint-GUID: RhaOVkOi8xXBppFtaO4kQRGTV8EeHCVa
X-Proofpoint-ORIG-GUID: RhaOVkOi8xXBppFtaO4kQRGTV8EeHCVa
X-Authority-Analysis: v=2.4 cv=M89NKzws c=1 sm=1 tr=0 ts=680a3f26 cx=c_pps a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17 a=XR8D0OoHHMoA:10 a=M5GUcnROAAAA:8 a=KvRRDgbPbzo2wF1RERMA:9 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-04-24_06,2025-04-24_01,2025-02-21_01

The netdevice usage count increases during transmit queue timeouts
because netdev_hold is called in ndo_tx_timeout, scheduling a task
to reinitialize the card. Although netdev_put is called at the end
of the scheduled work, rtnl_unlock checks the reference count during
cleanup. This could cause issues if transmit timeout is called on
multiple queues.

Fixes: cb7dd712189f ("octeon_ep_vf: Add driver framework and device initialization")
Signed-off-by: Sathesh B Edara <sedara@marvell.com>
---
Changes:
V4:
  - use schedule_work() return value to put back netdevice usage count
V3:
  - Added more description to commit message
V2:
  - Removed redundant call

 drivers/net/ethernet/marvell/octeon_ep_vf/octep_vf_main.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/marvell/octeon_ep_vf/octep_vf_main.c b/drivers/net/ethernet/marvell/octeon_ep_vf/octep_vf_main.c
index 18c922dd5fc6..ccb69bc5c952 100644
--- a/drivers/net/ethernet/marvell/octeon_ep_vf/octep_vf_main.c
+++ b/drivers/net/ethernet/marvell/octeon_ep_vf/octep_vf_main.c
@@ -835,7 +835,9 @@ static void octep_vf_tx_timeout(struct net_device *netdev, unsigned int txqueue)
 	struct octep_vf_device *oct = netdev_priv(netdev);
 
 	netdev_hold(netdev, NULL, GFP_ATOMIC);
-	schedule_work(&oct->tx_timeout_task);
+	if (!schedule_work(&oct->tx_timeout_task))
+		netdev_put(netdev, NULL);
+
 }
 
 static int octep_vf_set_mac(struct net_device *netdev, void *p)
-- 
2.36.0


