Return-Path: <netdev+bounces-49732-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 970A67F3459
	for <lists+netdev@lfdr.de>; Tue, 21 Nov 2023 17:57:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C8ED41C21AB9
	for <lists+netdev@lfdr.de>; Tue, 21 Nov 2023 16:57:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1760A524D1;
	Tue, 21 Nov 2023 16:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="BPBZdqwo"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69F69191;
	Tue, 21 Nov 2023 08:56:57 -0800 (PST)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3ALG4vrG014135;
	Tue, 21 Nov 2023 08:56:48 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=pfpt0220; bh=8etlXbF3LquEpSBVzWF1QWiK8n94DXI6bzbKmMyzZO8=;
 b=BPBZdqwo51wIGkTYYLrEQxMN4lJT4TkCLrOjMVuGABHve/9J0MOKb+ayjOHAGMpktHFT
 rLUy2TFF/ZpAJuzqUgjiTkBtCwRWf2wWDpcvQaSIqJXxtTdNS0uKndy1zV9RKo41lukt
 M9rynanRWZ4JT3JoAXRgl/1uyHF26XYM4hOF7ey0Z1bLGw4YWz3mMUycGz+T0R55iZIk
 3Du3yTsBOafx6d/p3Rl02dkVgkKE5Ol/kppyAsGMPeRIYJuh3Ceo77h9JI0uUU3kcdxS
 ptetRLe1JkDRLViIa7jvOhBChDsoSX8/de55s5kON7XYdXAP0xcl9jjP7KYIcLd5qxXT XA== 
Received: from dc5-exch01.marvell.com ([199.233.59.181])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3uewnw1qe7-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
	Tue, 21 Nov 2023 08:56:48 -0800
Received: from DC5-EXCH01.marvell.com (10.69.176.38) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Tue, 21 Nov
 2023 08:56:31 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server id 15.0.1497.48 via Frontend
 Transport; Tue, 21 Nov 2023 08:56:31 -0800
Received: from localhost.localdomain (unknown [10.28.36.166])
	by maili.marvell.com (Postfix) with ESMTP id 655F93F7082;
	Tue, 21 Nov 2023 08:56:27 -0800 (PST)
From: Suman Ghosh <sumang@marvell.com>
To: <sgoutham@marvell.com>, <gakula@marvell.com>, <sbhatta@marvell.com>,
        <hkelam@marvell.com>, <lcherian@marvell.com>, <jerinj@marvell.com>,
        <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <horms@kernel.org>,
        <wojciech.drewek@intel.com>
CC: Suman Ghosh <sumang@marvell.com>
Subject: [net PATCH v2] octeontx2-pf: Fix ntuple rule creation to direct packet to VF with higher Rx queue than its PF
Date: Tue, 21 Nov 2023 22:26:24 +0530
Message-ID: <20231121165624.3664182-1-sumang@marvell.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: bbFYwpA2hPiJ8KtBot0En0xNdVGK_eKx
X-Proofpoint-ORIG-GUID: bbFYwpA2hPiJ8KtBot0En0xNdVGK_eKx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-21_10,2023-11-21_01,2023-05-22_02

It is possible to add a ntuple rule which would like to direct packet to
a VF whose number of queues are greater/less than its PF's queue numbers.
For example a PF can have 2 Rx queues but a VF created on that PF can have
8 Rx queues. As of today, ntuple rule will reject rule because it is
checking the requested queue number against PF's number of Rx queues.
As a part of this fix if the action of a ntuple rule is to move a packet
to a VF's queue then the check is removed. Also, a debug information is
printed to aware user that it is user's responsibility to cross check if
the requested queue number on that VF is a valid one.

Fixes: f0a1913f8a6f ("octeontx2-pf: Add support for ethtool ntuple filters")
Signed-off-by: Suman Ghosh <sumang@marvell.com>
---
v2 changes:
- Removed 'goto' and added the new condition to existing if check.

 .../marvell/octeontx2/nic/otx2_flows.c        | 20 ++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_flows.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_flows.c
index 4762dbea64a1..97a71e9b8563 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_flows.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_flows.c
@@ -1088,6 +1088,7 @@ int otx2_add_flow(struct otx2_nic *pfvf, struct ethtool_rxnfc *nfc)
 	struct ethhdr *eth_hdr;
 	bool new = false;
 	int err = 0;
+	u64 vf_num;
 	u32 ring;
 
 	if (!flow_cfg->max_flows) {
@@ -1100,7 +1101,21 @@ int otx2_add_flow(struct otx2_nic *pfvf, struct ethtool_rxnfc *nfc)
 	if (!(pfvf->flags & OTX2_FLAG_NTUPLE_SUPPORT))
 		return -ENOMEM;
 
-	if (ring >= pfvf->hw.rx_queues && fsp->ring_cookie != RX_CLS_FLOW_DISC)
+	/* Number of queues on a VF can be greater or less than
+	 * the PF's queue. Hence no need to check for the
+	 * queue count. Hence no need to check queue count if PF
+	 * is installing for its VF. Below is the expected vf_num value
+	 * based on the ethtool commands.
+	 *
+	 * e.g.
+	 * 1. ethtool -U <netdev> ... action -1  ==> vf_num:255
+	 * 2. ethtool -U <netdev> ... action <queue_num>  ==> vf_num:0
+	 * 3. ethtool -U <netdev> ... vf <vf_idx> queue <queue_num>  ==>
+	 *    vf_num:vf_idx+1
+	 */
+	vf_num = ethtool_get_flow_spec_ring_vf(fsp->ring_cookie);
+	if (!is_otx2_vf(pfvf->pcifunc) && !vf_num &&
+	    ring >= pfvf->hw.rx_queues && fsp->ring_cookie != RX_CLS_FLOW_DISC)
 		return -EINVAL;
 
 	if (fsp->location >= otx2_get_maxflows(flow_cfg))
@@ -1182,6 +1197,9 @@ int otx2_add_flow(struct otx2_nic *pfvf, struct ethtool_rxnfc *nfc)
 		flow_cfg->nr_flows++;
 	}
 
+	if (flow->is_vf)
+		netdev_info(pfvf->netdev,
+			    "Make sure that VF's queue number is within its queue limit\n");
 	return 0;
 }
 
-- 
2.25.1


