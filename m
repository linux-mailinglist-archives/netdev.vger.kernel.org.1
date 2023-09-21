Return-Path: <netdev+bounces-35423-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B9A37A9736
	for <lists+netdev@lfdr.de>; Thu, 21 Sep 2023 19:18:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AC8011F20FD9
	for <lists+netdev@lfdr.de>; Thu, 21 Sep 2023 17:18:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 175F3168B0;
	Thu, 21 Sep 2023 17:05:27 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C769B1642A
	for <netdev@vger.kernel.org>; Thu, 21 Sep 2023 17:05:24 +0000 (UTC)
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8363E6193
	for <netdev@vger.kernel.org>; Thu, 21 Sep 2023 10:05:15 -0700 (PDT)
Received: from pps.filterd (m0250810.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38L6JUWK012978;
	Thu, 21 Sep 2023 02:23:57 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	PPS06212021; bh=acNM2dS1Wt/i/w065dOhvkYJAE6tA/asNtceXL5Ur+s=; b=
	FrPg1uZlS0e2VGauuVu6WIK+CD1hcXDKbISkpo+wJKqKYpDzFvS0RwwywwzGRjjx
	u+OymNUk4MAIRA/ioRvS3BKTiqomQ8AIDK2V33/uM+o+YVhY80v0aqTQYlxMEB3u
	QySSZPQRMzuxtiWt/1ciVh5li7UWocbn6OPnBTrhIcaWzuw5qp8J/RUngNoo0Q/E
	FpELiT+F69SpQwGRdpFZZHWfCRGEtFZiq9ian1uiBrfEXr+0f7OjZ/vsbUyZvgX5
	TWUH7NT+xXia8BNrMiQoGgoTIigDU3mGy0I5qmg9L0Y3Ce+62SnYyosfM0IKrIMT
	X4zJI7dYP/Bx7XDOtEcSbg==
Received: from ala-exchng01.corp.ad.wrs.com (ala-exchng01.wrs.com [147.11.82.252])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3t57n0v8yd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Thu, 21 Sep 2023 02:23:56 -0700 (PDT)
Received: from ala-exchng01.corp.ad.wrs.com (147.11.82.252) by
 ala-exchng01.corp.ad.wrs.com (147.11.82.252) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Thu, 21 Sep 2023 02:23:56 -0700
Received: from pek-lpd-ccm3.wrs.com (147.11.1.11) by
 ala-exchng01.corp.ad.wrs.com (147.11.82.252) with Microsoft SMTP Server id
 15.1.2507.32 via Frontend Transport; Thu, 21 Sep 2023 02:23:54 -0700
From: Heng Guo <heng.guo@windriver.com>
To: <davem@davemloft.net>, <sahern@kernel.org>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>
CC: <netdev@vger.kernel.org>, <filip.pudak@windriver.com>,
        <heng.guo@windriver.com>
Subject: [PATCH v3 1/1] net-next: fix IPSTATS_MIB_OUTFORWDATAGRAMS increment after fragment check
Date: Thu, 21 Sep 2023 17:23:45 +0800
Message-ID: <20230921092345.19898-2-heng.guo@windriver.com>
X-Mailer: git-send-email 2.35.2
In-Reply-To: <20230921092345.19898-1-heng.guo@windriver.com>
References: <20230914051623.2180843-2-heng.guo@windriver.com>
 <20230921092345.19898-1-heng.guo@windriver.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: SlnSjIawbxW2adQ_tdYIMbVgepw6MgGt
X-Proofpoint-ORIG-GUID: SlnSjIawbxW2adQ_tdYIMbVgepw6MgGt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.980,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-21_06,2023-09-20_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 phishscore=0
 suspectscore=0 mlxscore=0 lowpriorityscore=0 adultscore=0 bulkscore=0
 clxscore=1015 malwarescore=0 mlxlogscore=891 priorityscore=1501
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2309210081

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
 net/ipv6/ip6_output.c | 6 ++----
 2 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/net/ipv4/ip_forward.c b/net/ipv4/ip_forward.c
index 66fac1216d46..8b65f12583eb 100644
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
 
+	__IP_INC_STATS(net, IPSTATS_MIB_OUTFORWDATAGRAMS);
+
 	IPCB(skb)->flags |= IPSKB_FORWARDED;
 	mtu = ip_dst_mtu_maybe_forward(&rt->dst, true);
 	if (ip_exceeds_mtu(skb, mtu)) {
diff --git a/net/ipv6/ip6_output.c b/net/ipv6/ip6_output.c
index 54fc4c711f2c..8a9199ab97ef 100644
--- a/net/ipv6/ip6_output.c
+++ b/net/ipv6/ip6_output.c
@@ -448,10 +448,6 @@ static int ip6_forward_proxy_check(struct sk_buff *skb)
 static inline int ip6_forward_finish(struct net *net, struct sock *sk,
 				     struct sk_buff *skb)
 {
-	struct dst_entry *dst = skb_dst(skb);
-
-	__IP6_INC_STATS(net, ip6_dst_idev(dst), IPSTATS_MIB_OUTFORWDATAGRAMS);
-
 #ifdef CONFIG_NET_SWITCHDEV
 	if (skb->offload_l3_fwd_mark) {
 		consume_skb(skb);
@@ -619,6 +615,8 @@ int ip6_forward(struct sk_buff *skb)
 		}
 	}
 
+	__IP6_INC_STATS(net, ip6_dst_idev(dst), IPSTATS_MIB_OUTFORWDATAGRAMS);
+
 	mtu = ip6_dst_mtu_maybe_forward(dst, true);
 	if (mtu < IPV6_MIN_MTU)
 		mtu = IPV6_MIN_MTU;
-- 
2.35.2


