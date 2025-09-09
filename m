Return-Path: <netdev+bounces-221199-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D001AB4FAC4
	for <lists+netdev@lfdr.de>; Tue,  9 Sep 2025 14:26:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D4E4B1C277B3
	for <lists+netdev@lfdr.de>; Tue,  9 Sep 2025 12:26:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9862D31C59C;
	Tue,  9 Sep 2025 12:26:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="oNd9L6C+"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDBC8322DA3
	for <netdev@vger.kernel.org>; Tue,  9 Sep 2025 12:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757420787; cv=none; b=gNlnJsSS/gxFV8uJNBwi5xbq9VGJC+XvkG3Hh/A9ZYBXwxTl7ehpKMzr2xjAuw8Y9aVYcp45aS0j+xepvNAZ24RvTNT7JzjQ+TuN3wzYeGJn7lSRMsz4sAEZLM1NRPCG+Udb/Z/99Vdfa7ewhDUXHUWR8rD8zYMIlSrFb/5HvbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757420787; c=relaxed/simple;
	bh=J8r+DifcKbasz88++yZwhMKu2nHnUkvsp9YprLXDXvA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qtmBPzXh+9NUtMYXsNT1Vlz3rrzWjQmsIy0e3E3KQj1bvjNXcuZ4ciAAQKaAtGqbvt3kth451NKrSL5Bx9mzm5o5ZSudaxjJL7ZbaQd+UDbbaM6RTM63ZVYFJkBlMX2boVQa5NO1Z0ppwFbL2C7J5Di/Rl/+x0QttIWr5zAmqp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=oNd9L6C+; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 589CPFQx009081;
	Tue, 9 Sep 2025 12:26:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=corp-2025-04-25; bh=W/AFkffkW0StsLm2byOUBRulJXWTM
	ldS4NhFJEn9qCw=; b=oNd9L6C+0WGndlsvdw7MVrNRVe30C1PIMfqo8Ac0NiRTX
	VlrI6mXLYWMMna6JciNbOsnuOHAob3jErp63+/DNjY0MZaT5J7CopArSM963f0Qy
	Kbz4n5tNv2RBLiXkP9Gd8DruVNl73UdtCqs9s/P5p2zqtZQN36FhsQqk/1LYYQb5
	v8Olu7+4MgCCek+mijhD4XwCTBuFjatx/FyhsZdV18dwIl4o3g4Ox/Bn6OHwMfnu
	fpXQTX9ZiCGoBP2VnPVnaob93KqSRdDnpUQDJRzfeWhWfrKoLUgiFeQYUV4xqUrk
	IxFaAbVWXvPoXb4KthduU/Xq8h6p1lmNvXvQblI2A==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4921m2svkd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 09 Sep 2025 12:26:18 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 589CLgp9012812;
	Tue, 9 Sep 2025 12:26:17 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 490bd9rp10-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 09 Sep 2025 12:26:17 +0000
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 589CQGPH035869;
	Tue, 9 Sep 2025 12:26:16 GMT
Received: from ca-dev112.us.oracle.com (ca-dev112.us.oracle.com [10.129.136.47])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 490bd9rp0k-1;
	Tue, 09 Sep 2025 12:26:16 +0000
From: Alok Tiwari <alok.a.tiwari@oracle.com>
To: dsahern@kernel.org, willemdebruijn.kernel@gmail.com, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        horms@kernel.org, netdev@vger.kernel.org
Cc: alok.a.tiwari@oracle.com
Subject: [PATCH v2 net-next] ipv6: udp: fix typos in comments
Date: Tue,  9 Sep 2025 05:26:07 -0700
Message-ID: <20250909122611.3711859-1-alok.a.tiwari@oracle.com>
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
 definitions=2025-09-09_01,2025-09-08_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 spamscore=0 mlxscore=0
 mlxlogscore=999 adultscore=0 phishscore=0 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2508110000
 definitions=main-2509090123
X-Proofpoint-GUID: v1zzbkBQ0JBkJAS22N4jh9bTm1Eg11_4
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA4MDE1MSBTYWx0ZWRfXxzNzynlU09Ld
 X/48oGb0iTclpR7AkLqlgOeFp/3QdskM3UZRlznRP1seJxhlYJxR4GuJcENwdfYd6uUNXtb0LMI
 5e++Xt7EgtC6uwdqCRmNgRVzeL17Zw3JEkkRou7kDTnpnkK8PPPJrg3hAjcxkVRiLbbqEfwjtp+
 Rr59W02vwnzZFfJYvfyegZANO1CLRT3KPFdDoip4WY2ztpT3+ZyjhsVn2fGcr/M4SM4kBlt2FCY
 qYY0qs3fxcOoOJhmKCHLafu5s4gFoWXn5sqCmv4S2SIvcDPF7ryK34E3res/ZWy9a0Fd+SE9QKh
 kLAk5J5/i1I5I+TwUi8K59hKQPLr2zkyUTegxEDiJ9QBJBQxvwCorWlEYJzNbXHAzYJ0xMKp54R
 eeTH4nc0
X-Authority-Analysis: v=2.4 cv=Dp5W+H/+ c=1 sm=1 tr=0 ts=68c01cea b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=yJojWOMRYYMA:10 a=yPCof4ZbAAAA:8 a=1S7usWkXNqeztYIjQa0A:9
X-Proofpoint-ORIG-GUID: v1zzbkBQ0JBkJAS22N4jh9bTm1Eg11_4

Correct typos in ipv6/udp.c comments:
"execeeds" -> "exceeds"
"tacking care" -> "taking care"
"measureable" -> "measurable"

No functional changes.

Signed-off-by: Alok Tiwari <alok.a.tiwari@oracle.com>
---
v1 -> v2 
added "measureable" -> "measurable"
---
 net/ipv6/udp.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/net/ipv6/udp.c b/net/ipv6/udp.c
index a35ee6d693a8..b70369f3cd32 100644
--- a/net/ipv6/udp.c
+++ b/net/ipv6/udp.c
@@ -260,7 +260,7 @@ static struct sock *udp6_lib_lookup2(const struct net *net,
 
 			/* compute_score is too long of a function to be
 			 * inlined, and calling it again here yields
-			 * measureable overhead for some
+			 * measurable overhead for some
 			 * workloads. Work around it by jumping
 			 * backwards to rescore 'result'.
 			 */
@@ -449,7 +449,7 @@ struct sock *udp6_lib_lookup(const struct net *net, const struct in6_addr *saddr
 EXPORT_SYMBOL_GPL(udp6_lib_lookup);
 #endif
 
-/* do not use the scratch area len for jumbogram: their length execeeds the
+/* do not use the scratch area len for jumbogram: their length exceeds the
  * scratch area space; note that the IP6CB flags is still in the first
  * cacheline, so checking for jumbograms is cheap
  */
@@ -1048,7 +1048,7 @@ static void udp6_sk_rx_dst_set(struct sock *sk, struct dst_entry *dst)
 		sk->sk_rx_dst_cookie = rt6_get_cookie(dst_rt6_info(dst));
 }
 
-/* wrapper for udp_queue_rcv_skb tacking care of csum conversion and
+/* wrapper for udp_queue_rcv_skb taking care of csum conversion and
  * return code conversion for ip layer consumption
  */
 static int udp6_unicast_rcv_skb(struct sock *sk, struct sk_buff *skb,
-- 
2.50.1


