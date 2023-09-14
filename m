Return-Path: <netdev+bounces-33728-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B083C79F9F4
	for <lists+netdev@lfdr.de>; Thu, 14 Sep 2023 07:17:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E3DC22815E5
	for <lists+netdev@lfdr.de>; Thu, 14 Sep 2023 05:17:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55CB262C;
	Thu, 14 Sep 2023 05:16:43 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AA6D1C2F
	for <netdev@vger.kernel.org>; Thu, 14 Sep 2023 05:16:43 +0000 (UTC)
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6537F1BD0
	for <netdev@vger.kernel.org>; Wed, 13 Sep 2023 22:16:42 -0700 (PDT)
Received: from pps.filterd (m0250812.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 38E4dEgO002077;
	Thu, 14 Sep 2023 05:16:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	PPS06212021; bh=T6xZDB1AibCy5PhNeiliYjRakPLSu6Fxcsj+tRppYYY=; b=
	U9FnKzWAattowduGbL3iiAZs6/7Rvrim9YN5xjxTNw0FGeOyz0rMZoQI571psbNd
	3NzSeWajrJLmLgtxZdq8mHYwTILQDsAd1g/qPcnfTGyi+jx5N7wvNvywLxVlCwjc
	/fAP5qAyxP07ncJR2HlQ31zKFI4Ty8JFBGLjluRHHlcpdgdtjuFkrKoXi+CcB5Lf
	p2iwtp1m5p2fZ3oZRsQBCrxJ9VSmQmU8OgleoqL1tE2xcsYxlr+zHP7Brfje19et
	XnHxqeSyBuHAtd9EzhaiUdzjIrCcS0h1oMiY9o2Jc3g7J/K4w4tBq5kjpJRtMAEz
	knuQVkcBeQAiHvW2zsxTSA==
Received: from ala-exchng01.corp.ad.wrs.com (ala-exchng01.wrs.com [147.11.82.252])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3t2y8m9ef2-12
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Thu, 14 Sep 2023 05:16:29 +0000 (GMT)
Received: from ALA-EXCHNG02.corp.ad.wrs.com (147.11.82.254) by
 ala-exchng01.corp.ad.wrs.com (147.11.82.252) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Wed, 13 Sep 2023 22:16:29 -0700
Received: from pek-lpd-ccm2.wrs.com (147.11.1.11) by
 ALA-EXCHNG02.corp.ad.wrs.com (147.11.82.254) with Microsoft SMTP Server id
 15.1.2507.27 via Frontend Transport; Wed, 13 Sep 2023 22:16:27 -0700
From: Heng Guo <heng.guo@windriver.com>
To: <davem@davemloft.net>, <sahern@kernel.org>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>
CC: <netdev@vger.kernel.org>, <filip.pudak@windriver.com>,
        <heng.guo@windriver.com>
Subject: [PATCH 1/1] net: ipv4,ipv6: fix IPSTATS_MIB_OUTFORWDATAGRAMS increment after fragment check
Date: Thu, 14 Sep 2023 13:16:23 +0800
Message-ID: <20230914051623.2180843-2-heng.guo@windriver.com>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20230914051623.2180843-1-heng.guo@windriver.com>
References: <20230914051623.2180843-1-heng.guo@windriver.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: HCil_9juy__sREhrXpA5LzKXsOh0sh6H
X-Proofpoint-GUID: HCil_9juy__sREhrXpA5LzKXsOh0sh6H
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-14_02,2023-09-13_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 priorityscore=1501 mlxlogscore=883 spamscore=0 adultscore=0
 lowpriorityscore=0 malwarescore=0 bulkscore=0 suspectscore=0 clxscore=1015
 mlxscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2309140045

According to RFC 4293 "3.2.3. IP Statistics Tables",
  +-------+------>------+----->-----+----->-----+
  | InForwDatagrams (6) | OutForwDatagrams (6)  |
  |                     V                       +->-+ OutFragReqds
  |                 InNoRoutes                  |   | (packets)
  / (local packet (3)                           |   |
  |  IF is that of the address                  |   +--> OutFragFails
  |  and may not be the receiving IF)           |   |    (packets)
the IPSTATS_MIB_OUTFORWDATAGRAMS should be counted before fragment
check.

The existing implementation, instead, would incease the counter after
fragment check: ip_exceeds_mtu() in ipv4 and ip6_pkt_too_big() in ipv6.

So move IPSTATS_MIB_OUTFORWDATAGRAMS counter to ip_forward() for ipv4 and
ip6_forward() for ipv6.

Reviewed-by: Filip Pudak <filip.pudak@windriver.com>
Signed-off-by: Heng Guo <heng.guo@windriver.com>
---
 net/ipv4/ip_forward.c | 4 ++--
 net/ipv6/ip6_output.c | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/net/ipv4/ip_forward.c b/net/ipv4/ip_forward.c
index 66fac1216d46..acba24fc000f 100644
--- a/net/ipv4/ip_forward.c
+++ b/net/ipv4/ip_forward.c
@@ -66,8 +66,6 @@ static int ip_forward_finish(struct net *net, struct sock *sk, struct sk_buff *s
 {
 	struct ip_options *opt	= &(IPCB(skb)->opt);
 
-	__IP_INC_STATS(net, IPSTATS_MIB_OUTFORWDATAGRAMS);
-
 #ifdef CONFIG_NET_SWITCHDEV
 	if (skb->offload_l3_fwd_mark) {
 		consume_skb(skb);
@@ -130,6 +128,8 @@ int ip_forward(struct sk_buff *skb)
 	if (opt->is_strictroute && rt->rt_uses_gateway)
 		goto sr_failed;
 
+        __IP_INC_STATS(net, IPSTATS_MIB_OUTFORWDATAGRAMS);
+
 	IPCB(skb)->flags |= IPSKB_FORWARDED;
 	mtu = ip_dst_mtu_maybe_forward(&rt->dst, true);
 	if (ip_exceeds_mtu(skb, mtu)) {
diff --git a/net/ipv6/ip6_output.c b/net/ipv6/ip6_output.c
index 275b24c89ac3..8943c85d75b4 100644
--- a/net/ipv6/ip6_output.c
+++ b/net/ipv6/ip6_output.c
@@ -450,8 +450,6 @@ static inline int ip6_forward_finish(struct net *net, struct sock *sk,
 {
 	struct dst_entry *dst = skb_dst(skb);
 
-	__IP6_INC_STATS(net, ip6_dst_idev(dst), IPSTATS_MIB_OUTFORWDATAGRAMS);
-
 #ifdef CONFIG_NET_SWITCHDEV
 	if (skb->offload_l3_fwd_mark) {
 		consume_skb(skb);
@@ -619,6 +617,8 @@ int ip6_forward(struct sk_buff *skb)
 		}
 	}
 
+	__IP6_INC_STATS(net, ip6_dst_idev(dst), IPSTATS_MIB_OUTFORWDATAGRAMS);
+
 	mtu = ip6_dst_mtu_maybe_forward(dst, true);
 	if (mtu < IPV6_MIN_MTU)
 		mtu = IPV6_MIN_MTU;
-- 
2.25.1


