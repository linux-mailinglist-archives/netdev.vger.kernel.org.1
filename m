Return-Path: <netdev+bounces-220688-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B1B0B47D02
	for <lists+netdev@lfdr.de>; Sun,  7 Sep 2025 21:25:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2A92D1897C29
	for <lists+netdev@lfdr.de>; Sun,  7 Sep 2025 19:26:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0B7F27FB21;
	Sun,  7 Sep 2025 19:25:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="OYgosLER"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 515DF10957
	for <netdev@vger.kernel.org>; Sun,  7 Sep 2025 19:25:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757273150; cv=none; b=iilN79ZnlRnpHWbUiGhsQiRKQz7iseADN0QKgANwRlYl/Wob4QguNH/qWagZ+iRY8LyHBu+NuKSfCZEe3i9W6+6zd8TJw+hWMwKdcJPq/EVSL23JutAqry/0vQr/UoZ6pFxTHansLoed3I3pU/cj5KmuCw1gyyX4UXuv9vKXSsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757273150; c=relaxed/simple;
	bh=XxmjcmDShaQswwylBGSA4mQ3R04OTS30/fJ3QB++x54=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=g56j2wezCPvy7MM1TvCshAZufhGqTD8Dq63juWTJoUzypAELAc2STy5+6c1JxOdutIBIlEzKb21UZU/IrlNd9pZ/1ksas6f300bt14LMAFJ+NxPNpw9uJOp0612SNNIud43i5D+GUH5EAhRlmrvom6KtvksRDT5tTbnlTrCD2Yc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=OYgosLER; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 587It2Qi030465;
	Sun, 7 Sep 2025 19:25:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=corp-2025-04-25; bh=4ePV0uQ/vy0jKxrL1ZebyFug04dXk
	b+AnUvA78NLXBs=; b=OYgosLERp0QHxomWC3uXxeRfsiUzb8ISN6pLZRFJRz/6L
	ptiVgaJLeYE4qVXPajEKyHq+6X9Fn6yC56XkYB9nWffq/hlHWoomTC3ja+xroNdS
	ElTPd0bhQljDpl1mND5Q0qEpJcMUQR+/BJ0ecO/VQc/BRRjClkhCGCOjV2AV4IeY
	H0YXs2CiNJ+wqqW0JS4Qko0rdsKnaxO5ajXT1+tPp7xVHG701nNCG7omvhpH8I9x
	jqKiyRHQxha3fuqMrSVsNIffbzCQorzxrLTuszqrXK97kl37Wnt3q1cR67pRJsNq
	M1FkZyQ1eYcVjOKZt+ymdUfELZ9WXMji5qXQr6n8Q==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 491fr5g0gh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 07 Sep 2025 19:25:40 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 587I2mrN038809;
	Sun, 7 Sep 2025 19:25:39 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 490bd7cjj3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 07 Sep 2025 19:25:39 +0000
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 587JPcqE034656;
	Sun, 7 Sep 2025 19:25:39 GMT
Received: from ca-dev112.us.oracle.com (ca-dev112.us.oracle.com [10.129.136.47])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 490bd7cjhv-1;
	Sun, 07 Sep 2025 19:25:38 +0000
From: Alok Tiwari <alok.a.tiwari@oracle.com>
To: dsahern@kernel.org, willemdebruijn.kernel@gmail.com, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        horms@kernel.org, netdev@vger.kernel.org
Cc: alok.a.tiwari@oracle.com
Subject: [PATCH net-next] ipv4: udp: fix typos in comments
Date: Sun,  7 Sep 2025 12:25:32 -0700
Message-ID: <20250907192535.3610686-1-alok.a.tiwari@oracle.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-07_07,2025-09-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 bulkscore=0 suspectscore=0
 mlxlogscore=999 adultscore=0 spamscore=0 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2508110000
 definitions=main-2509070202
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA3MDE5NiBTYWx0ZWRfX5VgZFgtDLxj1
 qV6VPtOwp20gaGtIjYg3Yjz65ZaUw42E2WNvlhGhI+FAEuwAg83ODfXxnjGYC1mSMCEoIphruGA
 yrbF0joHayYcUo4W30Nm9qorSa2MtWPApNikXcvaEhFWerWCaE7EIvHL4xAWvlNNzJ0smj4znLG
 UhysUVowhZaOgJfrw9Ld+RX3+lDnFP4hIcLqIczG82nCdQr1106OAr9o0Dlmlb3PbSu9bWtOrY6
 D8yy0GHq42Bkkzu8koPS2KQH1I45ikuFjLv66hP7nTJ/ejNZXZKKV3wpl+G5jqtMWN0KxZL8U32
 fGDmFByLTp0nzFkb2BjNbyIknYPcjQ6cNOD0E78mCCsR1UC+qmT+vPuYod4/hw+PmuSssD4EVAF
 NdJ4CI9q9n0l9dWTCMQPaoL6Zm4g+Q==
X-Proofpoint-ORIG-GUID: jkzrVzaZP7BsL17gs6Olu1bq6VJepprz
X-Authority-Analysis: v=2.4 cv=P+w6hjAu c=1 sm=1 tr=0 ts=68bddc34 b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=yJojWOMRYYMA:10 a=yPCof4ZbAAAA:8 a=5JN67_ksAAAA:8 a=HxGU0HUXyLekm6aY7JQA:9
 a=yZayB-v2eIzeQbgtiKvK:22 cc=ntf awl=host:12068
X-Proofpoint-GUID: jkzrVzaZP7BsL17gs6Olu1bq6VJepprz

Correct typos in ipv4/udp.c comments for clarity:
"Encapulation" -> "Encapsulation"
"measureable" -> "measurable"
"tacking care" -> "taking care"

No functional changes.

Signed-off-by: Alok Tiwari <alok.a.tiwari@oracle.com>
---
 net/ipv4/udp.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
index 732bdad43626..cca41c569f37 100644
--- a/net/ipv4/udp.c
+++ b/net/ipv4/udp.c
@@ -68,7 +68,7 @@
  *	YOSHIFUJI Hideaki @USAGI and:	Support IPV6_V6ONLY socket option, which
  *	Alexey Kuznetsov:		allow both IPv4 and IPv6 sockets to bind
  *					a single port at the same time.
- *	Derek Atkins <derek@ihtfp.com>: Add Encapulation Support
+ *	Derek Atkins <derek@ihtfp.com>: Add Encapsulation Support
  *	James Chapman		:	Add L2TP encapsulation type.
  */
 
@@ -509,7 +509,7 @@ static struct sock *udp4_lib_lookup2(const struct net *net,
 
 			/* compute_score is too long of a function to be
 			 * inlined, and calling it again here yields
-			 * measureable overhead for some
+			 * measurable overhead for some
 			 * workloads. Work around it by jumping
 			 * backwards to rescore 'result'.
 			 */
@@ -2609,7 +2609,7 @@ static inline int udp4_csum_init(struct sk_buff *skb, struct udphdr *uh,
 	return 0;
 }
 
-/* wrapper for udp_queue_rcv_skb tacking care of csum conversion and
+/* wrapper for udp_queue_rcv_skb taking care of csum conversion and
  * return code conversion for ip layer consumption
  */
 static int udp_unicast_rcv_skb(struct sock *sk, struct sk_buff *skb,
-- 
2.50.1


