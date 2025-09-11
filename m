Return-Path: <netdev+bounces-222188-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FD44B53641
	for <lists+netdev@lfdr.de>; Thu, 11 Sep 2025 16:50:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F0D6AB614D8
	for <lists+netdev@lfdr.de>; Thu, 11 Sep 2025 14:48:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85E8131E11F;
	Thu, 11 Sep 2025 14:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="R6IBTxq6"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E55E031AF1A;
	Thu, 11 Sep 2025 14:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757602204; cv=none; b=eOlJ6ideIL2HMzANoZDuUniGQnfuie5aB4otFqrS9DFUkdD7Rl4fPlLY74vSqLEe1I9cX9ZsSt5aXiKJvgXtnqEaRDq2t15hVnEzCwbHNjLcvGFxQcmixz5XKCQgzoDESZ5ySuuDKF2tVVjO7YFv85BipuFyALtyrOiYHOxeI8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757602204; c=relaxed/simple;
	bh=AsRDY/t3fRH6ShE1xmaBRolK4oMvv56ESj6NH5fWUus=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=HMUjnJnUjdQkXGNEyOBbQD2C0zAIFCx9E5gDwcFxZbDPJCRbTrX84JTFit0rpH7jWeWlcWw89ZwhNGcDBOKf/hzo17YOcucefGlGooo1X3ZqJZ1NB4orLQcZ8L3qD4lecD7IHaOA3iJlJJJa3ph9lIPn2UxTtoSUckAhMjxQq6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=R6IBTxq6; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58ANSTan024882;
	Thu, 11 Sep 2025 07:49:40 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pfpt0220; bh=qwtCgPAXETmPpy/dGxQAV8j
	OAj35HYp7YS9l7wwQ7bM=; b=R6IBTxq6wnsi9rZBvTGQOUZT0madUd5DdvX9wPb
	oeTO9NbVAf1pJV9afTRCYdb1/oruh8tX98i9Vr/kA9EXoPyH2TRueTs65nwr4zTS
	I5dD6UASmhF/dHdbozglYU0AGAU2WEPMqHNHtVlFjip2szebLC4iU65npuPym/fe
	0y0OC+9zp1DvJKn3dlpmD+qY9pchQMetpWCHJvAL1eCTnphR1zyDB0lmTSDlBSSc
	HbpNYhhiAaZYDvfHxbYZHxD3N/b7EMm/FlmJTUGSavn1P+U3yJeoae+gmwVK5tLR
	Qcraj/iMYjmL2xXC+/kxLfB9Ah5nEf9SSX8HMvUmEgcJ9tg==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 493k1nsma1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 11 Sep 2025 07:49:40 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 11 Sep 2025 07:49:46 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Thu, 11 Sep 2025 07:49:46 -0700
Received: from sburla-PowerEdge-T630.sclab.marvell.com (unknown [10.106.27.217])
	by maili.marvell.com (Postfix) with ESMTP id 0C4543F70BE;
	Thu, 11 Sep 2025 07:49:39 -0700 (PDT)
From: Sathesh B Edara <sedara@marvell.com>
To: <linux-kernel@vger.kernel.org>, <sburla@marvell.com>, <vburru@marvell.com>,
        <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>, <netdev@vger.kernel.org>, <hgani@marvell.com>,
        <andrew@lunn.ch>, <srasheed@marvell.com>
CC: <sedara@marvell.com>
Subject: [net PATCH] octeon_ep:fix VF MAC address lifecycle handling
Date: Thu, 11 Sep 2025 07:49:33 -0700
Message-ID: <20250911144933.6703-1-sedara@marvell.com>
X-Mailer: git-send-email 2.36.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: UY4FWdsb2T3aLIYhQ2zdHMKQSWJ8XOqy
X-Authority-Analysis: v=2.4 cv=RpvFLDmK c=1 sm=1 tr=0 ts=68c2e184 cx=c_pps a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17 a=yJojWOMRYYMA:10 a=M5GUcnROAAAA:8 a=RNbTXI68HHUJU8bo58UA:9 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-GUID: UY4FWdsb2T3aLIYhQ2zdHMKQSWJ8XOqy
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTEwMDIxOSBTYWx0ZWRfX9Gq1RnL+RYF0 ofzVnL3cTQSafMxEVzL7W5DYu9SAqb+PB8Fx5379rHSgjal0Lwr60IArJgsDYIU1NE7RGcjUkrR O3yQrqdOhBPMbOrLq0NVlZOMejRGLbqLfvkU2xMZaJxIlPnKG+QHeVUgJSwysmTQWp/Wy9tyoDC
 aeroiaQecIDx9ILIC8xauM2WU7sSutBDLnMoDHiwoCQnNKxZRBmxbbHqmyBOSRkc+XIvFDK1z46 VIQqMdFFChPDc26oYuErEkCvs0UVJ4z1mEbtmZkw5o/AIOHrJE5b1iYOM4JRK9IA3FDocTMZkMR yQZ63/SD2p9QmsgCPZZD1/x6VlVXtpzMWs+bOiFIDMxAiNbZCk6yhrNNPq+HAFned/E3xCaBoVU 1Krc4lsj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-11_01,2025-09-11_02,2025-03-28_01

Currently, VF MAC address info is not updated when the MAC address is
configured from VF, and it is not cleared when the VF is removed. This
leads to stale or missing MAC information in the PF, which may cause
incorrect state tracking or inconsistencies when VFs are hot-plugged
or reassigned.

Fix this by:
 - storing the VF MAC address in the PF when it is set from VF
 - clearing the stored VF MAC address when the VF is removed

This ensures that the PF always has correct VF MAC state.

Fixes: cde29af9e68e ("octeon_ep: add PF-VF mailbox communication")
Signed-off-by: Sathesh B Edara <sedara@marvell.com>
---
 drivers/net/ethernet/marvell/octeon_ep/octep_pfvf_mbox.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/ethernet/marvell/octeon_ep/octep_pfvf_mbox.c b/drivers/net/ethernet/marvell/octeon_ep/octep_pfvf_mbox.c
index ebecdd29f3bd..0867fab61b19 100644
--- a/drivers/net/ethernet/marvell/octeon_ep/octep_pfvf_mbox.c
+++ b/drivers/net/ethernet/marvell/octeon_ep/octep_pfvf_mbox.c
@@ -196,6 +196,7 @@ static void octep_pfvf_get_mac_addr(struct octep_device *oct,  u32 vf_id,
 			vf_id);
 		return;
 	}
+	ether_addr_copy(oct->vf_info[vf_id].mac_addr, rsp->s_set_mac.mac_addr);
 	rsp->s_set_mac.type = OCTEP_PFVF_MBOX_TYPE_RSP_ACK;
 }
 
@@ -205,6 +206,8 @@ static void octep_pfvf_dev_remove(struct octep_device *oct,  u32 vf_id,
 {
 	int err;
 
+	/* Reset VF-specific information maintained by the PF */
+	memset(&oct->vf_info[vf_id], 0, sizeof(struct octep_pfvf_info));
 	err = octep_ctrl_net_dev_remove(oct, vf_id);
 	if (err) {
 		rsp->s.type = OCTEP_PFVF_MBOX_TYPE_RSP_NACK;
-- 
2.36.0


