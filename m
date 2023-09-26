Return-Path: <netdev+bounces-36372-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D5BDB7AF66F
	for <lists+netdev@lfdr.de>; Wed, 27 Sep 2023 00:45:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 86AF32810D9
	for <lists+netdev@lfdr.de>; Tue, 26 Sep 2023 22:45:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD539499AA;
	Tue, 26 Sep 2023 22:45:50 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 101633FB18
	for <netdev@vger.kernel.org>; Tue, 26 Sep 2023 22:45:48 +0000 (UTC)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D44B2D7E
	for <netdev@vger.kernel.org>; Tue, 26 Sep 2023 15:45:47 -0700 (PDT)
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38QLVSkx013971
	for <netdev@vger.kernel.org>; Tue, 26 Sep 2023 21:43:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=wxhXptQjJOrFJRtqV5IW758CNegeu5i64T5b0qElJjE=;
 b=Glz5fufCoDKrrXWWOExPkhCtT7Xr5cG10nUeIk/+QmzGbxl4IKEzbdJaa/sfxl3a4+O9
 BcH7WJFhbCbqyKu7adamvpcBArgOjMHCmsM182Uc1S7lUob6e7Q4asxCOBb23zodmbR5
 d1/aPgaLE3ujl8bvTodNsl0SvozBmAQ62Q4w4qQvGCJ8mM4CRbnNBFzJ97Xhmuiv9bHi
 /xZcMd84btQblu98SVKuveC9qrGMA/vGElT6DfX1XT974gPpvSzEhG22k5yHOi4lTFKH
 /mxihWtBSzlZ3pNp5/9wOfS5ZR8Nw49OxDdEr7cmBi4tZP8p8Hx3tuWyzmHwY7RpC8fx bw== 
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3tc79eg8p4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <netdev@vger.kernel.org>; Tue, 26 Sep 2023 21:42:59 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 38QK5cr0030736
	for <netdev@vger.kernel.org>; Tue, 26 Sep 2023 21:42:59 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3tacjjx70t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <netdev@vger.kernel.org>; Tue, 26 Sep 2023 21:42:59 +0000
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com [10.39.53.228])
	by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 38QLguo13408538
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 26 Sep 2023 21:42:56 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4F77058055;
	Tue, 26 Sep 2023 21:42:56 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D25EC58059;
	Tue, 26 Sep 2023 21:42:55 +0000 (GMT)
Received: from li-8d37cfcc-31b9-11b2-a85c-83226d7135c9.austin.ibm.com (unknown [9.24.4.46])
	by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 26 Sep 2023 21:42:55 +0000 (GMT)
From: Nick Child <nnac123@linux.ibm.com>
To: netdev@vger.kernel.org
Cc: dwilder@us.ibm.com, wilder@us.ibm.com, pradeeps@linux.vnet.ibm.com,
        nick.child@ibm.com, Nick Child <nnac123@linux.ibm.com>
Subject: [PATCH net] ibmveth: Remove condition to recompute TCP header checksum.
Date: Tue, 26 Sep 2023 16:42:51 -0500
Message-Id: <20230926214251.58503-1-nnac123@linux.ibm.com>
X-Mailer: git-send-email 2.39.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: _OTYI6RadF0_25ZUwZ6AAKREon4rHPLt
X-Proofpoint-ORIG-GUID: _OTYI6RadF0_25ZUwZ6AAKREon4rHPLt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-26_15,2023-09-26_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 phishscore=0
 spamscore=0 impostorscore=0 lowpriorityscore=0 bulkscore=0 adultscore=0
 mlxlogscore=615 mlxscore=0 priorityscore=1501 clxscore=1011 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2309180000
 definitions=main-2309260184
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,
	RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: David Wilder <dwilder@us.ibm.com>

In some OVS environments the TCP pseudo header checksum may need to be
recomputed. Currently this is only done when the interface instance is
configured for "Trunk Mode". We found the issue also occurs in some
Kubernetes environments, these environments do not use "Trunk Mode",
therefor the condition is removed.

Performance tests with this change show only a fractional decrease in
throughput (< 0.2%).

Fixes: 7525de2516fb ("ibmveth: Set CHECKSUM_PARTIAL if NULL TCP CSUM.")
Signed-off-by: David Wilder <dwilder@us.ibm.com>
Reviewed-by: Nick Child <nnac123@linux.ibm.com>
---
Hello, I (Nick Child) am submitting on behalf of the
author (David Wilder) since he is having patch submission issues.
Apologies for any inconvenience.


 drivers/net/ethernet/ibm/ibmveth.c | 25 ++++++++++++-------------
 1 file changed, 12 insertions(+), 13 deletions(-)

diff --git a/drivers/net/ethernet/ibm/ibmveth.c b/drivers/net/ethernet/ibm/ibmveth.c
index 113fcb3e353e..748ee25cee8d 100644
--- a/drivers/net/ethernet/ibm/ibmveth.c
+++ b/drivers/net/ethernet/ibm/ibmveth.c
@@ -1303,24 +1303,23 @@ static void ibmveth_rx_csum_helper(struct sk_buff *skb,
 	 * the user space for finding a flow. During this process, OVS computes
 	 * checksum on the first packet when CHECKSUM_PARTIAL flag is set.
 	 *
-	 * So, re-compute TCP pseudo header checksum when configured for
-	 * trunk mode.
+	 * So, re-compute TCP pseudo header checksum.
 	 */
+
 	if (iph_proto == IPPROTO_TCP) {
 		struct tcphdr *tcph = (struct tcphdr *)(skb->data + iphlen);
+
 		if (tcph->check == 0x0000) {
 			/* Recompute TCP pseudo header checksum  */
-			if (adapter->is_active_trunk) {
-				tcphdrlen = skb->len - iphlen;
-				if (skb_proto == ETH_P_IP)
-					tcph->check =
-					 ~csum_tcpudp_magic(iph->saddr,
-					iph->daddr, tcphdrlen, iph_proto, 0);
-				else if (skb_proto == ETH_P_IPV6)
-					tcph->check =
-					 ~csum_ipv6_magic(&iph6->saddr,
-					&iph6->daddr, tcphdrlen, iph_proto, 0);
-			}
+			tcphdrlen = skb->len - iphlen;
+			if (skb_proto == ETH_P_IP)
+				tcph->check =
+				 ~csum_tcpudp_magic(iph->saddr,
+				iph->daddr, tcphdrlen, iph_proto, 0);
+			else if (skb_proto == ETH_P_IPV6)
+				tcph->check =
+				 ~csum_ipv6_magic(&iph6->saddr,
+				&iph6->daddr, tcphdrlen, iph_proto, 0);
 			/* Setup SKB fields for checksum offload */
 			skb_partial_csum_set(skb, iphlen,
 					     offsetof(struct tcphdr, check));
-- 
2.39.3


