Return-Path: <netdev+bounces-22587-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E475B76843C
	for <lists+netdev@lfdr.de>; Sun, 30 Jul 2023 09:42:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0BB101C20A33
	for <lists+netdev@lfdr.de>; Sun, 30 Jul 2023 07:42:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEBB6810;
	Sun, 30 Jul 2023 07:42:07 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AA4F1364
	for <netdev@vger.kernel.org>; Sun, 30 Jul 2023 07:42:07 +0000 (UTC)
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4697719B7;
	Sun, 30 Jul 2023 00:42:06 -0700 (PDT)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36U2r879032253;
	Sun, 30 Jul 2023 00:41:51 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=pfpt0220;
 bh=8peA6WwzHL0O8VTemZNDv1A+nje61jhJKdnZn2NLSVI=;
 b=ETLLNB/N0GT7zFfNevYtvfPtdv2vAw3iQZSj/iQvRinSAVOUCCte1wYQbBifS066f+Rw
 0k8MBayu9mzOCSyGaZbvoZ+lsZh3oAI47VNJ9J3K1L8d0FJJoC8sJTfcm6sWqbpCJiQ1
 YidJEhqdtia2OUYiQ0zSl+N7kRPG15d7BUI/oWSUZDQZsVeb02dEMAH2cP8ZpIw6/QG3
 1fS595ogz7JfkpnYyudQPQ7dRqSclg6rA0sQ3gyI9emPlZs1zvnF1f+SmiTxgLDkeAnC
 AXX9zthGE68goDl/2N1y+0OjFOIJNBgI/4Ciq2A/JFsIZWYeb06Io1wfhhNKG4xJ0VL4 mA== 
Received: from dc5-exch01.marvell.com ([199.233.59.181])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3s504nj5wb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
	Sun, 30 Jul 2023 00:41:50 -0700
Received: from DC5-EXCH02.marvell.com (10.69.176.39) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Sun, 30 Jul
 2023 00:41:49 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server id 15.0.1497.48 via Frontend
 Transport; Sun, 30 Jul 2023 00:41:49 -0700
Received: from localhost.localdomain (unknown [10.28.36.166])
	by maili.marvell.com (Postfix) with ESMTP id E0C463F706D;
	Sun, 30 Jul 2023 00:41:44 -0700 (PDT)
From: Suman Ghosh <sumang@marvell.com>
To: <sgoutham@marvell.com>, <gakula@marvell.com>, <sbhatta@marvell.com>,
        <hkelam@marvell.com>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <lcherian@marvell.com>,
        <jerinj@marvell.com>, <simon.horman@corigine.com>
CC: Suman Ghosh <sumang@marvell.com>
Subject: [net-next PATCH 1/2] octeontx2-af: Code restructure to handle TC outer VLAN offload
Date: Sun, 30 Jul 2023 13:11:33 +0530
Message-ID: <20230730074134.2838427-2-sumang@marvell.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230730074134.2838427-1-sumang@marvell.com>
References: <20230730074134.2838427-1-sumang@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: 2o4XJbUfCOQMZEwoLcGqdW8h7cDDrnxr
X-Proofpoint-GUID: 2o4XJbUfCOQMZEwoLcGqdW8h7cDDrnxr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-27_10,2023-07-26_01,2023-05-22_02
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
	SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Moved the TC outer VLAN offload support to a seperate function.
This change is done to handle all VLAN related changes cleanly from
a dedicated function.

Signed-off-by: Suman Ghosh <sumang@marvell.com>
---
 .../ethernet/marvell/octeontx2/nic/otx2_tc.c  | 93 +++++++++++--------
 1 file changed, 53 insertions(+), 40 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_tc.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_tc.c
index 0915a0121316..ba2a1e8a9b9c 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_tc.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_tc.c
@@ -439,6 +439,55 @@ static int otx2_tc_parse_actions(struct otx2_nic *nic,
 	return 0;
 }
 
+static int otx2_tc_process_vlan(struct otx2_nic *nic, struct flow_msg *flow_spec,
+				struct flow_msg *flow_mask, struct flow_rule *rule,
+				struct npc_install_flow_req *req, bool is_inner)
+{
+	struct flow_match_vlan match;
+	u16 vlan_tci, vlan_tci_mask;
+
+	if (is_inner)
+		return -EOPNOTSUPP;
+
+	flow_rule_match_vlan(rule, &match);
+	if ((ntohs(match.key->vlan_tpid) != ETH_P_8021Q)) {
+		netdev_err(nic->netdev, "vlan tpid 0x%x not supported\n",
+			   ntohs(match.key->vlan_tpid));
+		return -EOPNOTSUPP;
+	}
+
+	if (!match.mask->vlan_id) {
+		struct flow_action_entry *act;
+		int i;
+
+		flow_action_for_each(i, act, &rule->action) {
+			if (act->id == FLOW_ACTION_DROP) {
+				netdev_err(nic->netdev,
+					   "vlan tpid 0x%x with vlan_id %d is not supported for DROP rule.\n",
+					   ntohs(match.key->vlan_tpid), match.key->vlan_id);
+				return -EOPNOTSUPP;
+			}
+		}
+	}
+
+	if (match.mask->vlan_id ||
+	    match.mask->vlan_dei ||
+	    match.mask->vlan_priority) {
+		vlan_tci = match.key->vlan_id |
+			   match.key->vlan_dei << 12 |
+			   match.key->vlan_priority << 13;
+
+		vlan_tci_mask = match.mask->vlan_id |
+				match.mask->vlan_dei << 12 |
+				match.mask->vlan_priority << 13;
+		flow_spec->vlan_tci = htons(vlan_tci);
+		flow_mask->vlan_tci = htons(vlan_tci_mask);
+		req->features |= BIT_ULL(NPC_OUTER_VID);
+	}
+
+	return 0;
+}
+
 static int otx2_tc_prepare_flow(struct otx2_nic *nic, struct otx2_tc_flow *node,
 				struct flow_cls_offload *f,
 				struct npc_install_flow_req *req)
@@ -564,47 +613,11 @@ static int otx2_tc_prepare_flow(struct otx2_nic *nic, struct otx2_tc_flow *node,
 	}
 
 	if (flow_rule_match_key(rule, FLOW_DISSECTOR_KEY_VLAN)) {
-		struct flow_match_vlan match;
-		u16 vlan_tci, vlan_tci_mask;
-
-		flow_rule_match_vlan(rule, &match);
-
-		if (ntohs(match.key->vlan_tpid) != ETH_P_8021Q) {
-			netdev_err(nic->netdev, "vlan tpid 0x%x not supported\n",
-				   ntohs(match.key->vlan_tpid));
-			return -EOPNOTSUPP;
-		}
-
-		if (!match.mask->vlan_id) {
-			struct flow_action_entry *act;
-			int i;
-
-			flow_action_for_each(i, act, &rule->action) {
-				if (act->id == FLOW_ACTION_DROP) {
-					netdev_err(nic->netdev,
-						   "vlan tpid 0x%x with vlan_id %d is not supported for DROP rule.\n",
-						   ntohs(match.key->vlan_tpid),
-						   match.key->vlan_id);
-					return -EOPNOTSUPP;
-				}
-			}
-		}
+		int ret;
 
-		if (match.mask->vlan_id ||
-		    match.mask->vlan_dei ||
-		    match.mask->vlan_priority) {
-			vlan_tci = match.key->vlan_id |
-				   match.key->vlan_dei << 12 |
-				   match.key->vlan_priority << 13;
-
-			vlan_tci_mask = match.mask->vlan_id |
-					match.mask->vlan_dei << 12 |
-					match.mask->vlan_priority << 13;
-
-			flow_spec->vlan_tci = htons(vlan_tci);
-			flow_mask->vlan_tci = htons(vlan_tci_mask);
-			req->features |= BIT_ULL(NPC_OUTER_VID);
-		}
+		ret = otx2_tc_process_vlan(nic, flow_spec, flow_mask, rule, req, false);
+		if (ret)
+			return ret;
 	}
 
 	if (flow_rule_match_key(rule, FLOW_DISSECTOR_KEY_IPV4_ADDRS)) {
-- 
2.25.1


