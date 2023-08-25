Return-Path: <netdev+bounces-30572-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8BAD788150
	for <lists+netdev@lfdr.de>; Fri, 25 Aug 2023 09:55:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 84906281706
	for <lists+netdev@lfdr.de>; Fri, 25 Aug 2023 07:55:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 737E7567D;
	Fri, 25 Aug 2023 07:55:29 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FC71525A
	for <netdev@vger.kernel.org>; Fri, 25 Aug 2023 07:55:29 +0000 (UTC)
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 820801FE3
	for <netdev@vger.kernel.org>; Fri, 25 Aug 2023 00:55:26 -0700 (PDT)
Received: from pps.filterd (m0250811.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 37P573Kb004507;
	Fri, 25 Aug 2023 07:55:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	PPS06212021; bh=RsjXRSYA2SxVg95Nm0NSWuYO6OFj0a1JPVYVq9t5Tt0=; b=
	Ifm8Mk68qxADPHxHw8O7BspBVnXuaLKFVJ725yHWvn3LRxcC6XDpXVhvNiYLjZHX
	WZewQ85GddHuA/yUmHBhfXoI1+FJgLl1obBLKBUumzZY6hTEUCAZqhOgvFEhVTQg
	0Rvdxag0+FJd+9B1SRnISSjzjsFSmGoasri3FriIhEu6y3JjTzuAsHNeoh1XoEJE
	KZTg7Jo3mLIpho6GlKs4emrBMjCqloSjlIIlofOIYum5KRqoFKRBNgtPqw/C/r9s
	cGi5E+qxQfVthy7HWo4tzLWyV6YJoilabAqU20Zi4IXV5IFLkWWcLboKV15DnQO1
	da8FYmscGwlS5GnNlSHUBQ==
Received: from ala-exchng02.corp.ad.wrs.com (ala-exchng02.wrs.com [147.11.82.254])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3sn21mjxqm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Fri, 25 Aug 2023 07:55:13 +0000 (GMT)
Received: from ala-exchng01.corp.ad.wrs.com (147.11.82.252) by
 ALA-EXCHNG02.corp.ad.wrs.com (147.11.82.254) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Fri, 25 Aug 2023 00:55:11 -0700
Received: from pek-lpd-ccm6.wrs.com (147.11.1.11) by
 ala-exchng01.corp.ad.wrs.com (147.11.82.252) with Microsoft SMTP Server id
 15.1.2507.27 via Frontend Transport; Fri, 25 Aug 2023 00:55:08 -0700
From: Heng Guo <heng.guo@windriver.com>
To: <davem@davemloft.net>, <sahern@kernel.org>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>
CC: <netdev@vger.kernel.org>, <Richard.Danter@windriver.com>,
        <filip.pudak@windriver.com>, <heng.guo@windriver.com>
Subject: [PATCH 1/1] net: ipv4, ipv6: fix IPSTATS_MIB_OUTOCTETS increment duplicated
Date: Fri, 25 Aug 2023 15:55:05 +0800
Message-ID: <20230825075505.3932972-2-heng.guo@windriver.com>
X-Mailer: git-send-email 2.35.5
In-Reply-To: <20230825075505.3932972-1-heng.guo@windriver.com>
References: <20230825075505.3932972-1-heng.guo@windriver.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: ESUB1SeZdvgkL4x-Kpz2ffPAWHWoXFaM
X-Proofpoint-GUID: ESUB1SeZdvgkL4x-Kpz2ffPAWHWoXFaM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-25_05,2023-08-24_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 mlxlogscore=999
 spamscore=0 mlxscore=0 bulkscore=0 adultscore=0 malwarescore=0
 suspectscore=0 lowpriorityscore=0 priorityscore=1501 phishscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2308250068
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

commit edf391ff1723 ("snmp: add missing counters for RFC 4293") had
already added OutOctets for RFC 4293. In commit 2d8dbb04c63e ("snmp: fix
OutOctets counter to include forwarded datagrams"), OutOctets was
counted again, but not removed from ip_output().

According to RFC 4293 "3.2.3. IP Statistics Tables",
ipipIfStatsOutTransmits is not equal to ipIfStatsOutForwDatagrams. So
"IPSTATS_MIB_OUTOCTETS must be incremented when incrementing" is not
accurate. And IPSTATS_MIB_OUTOCTETS should be counted after fragment.

This patch reverts commit 2d8dbb04c63e ("snmp: fix OutOctets counter to
include forwarded datagrams") and move IPSTATS_MIB_OUTOCTETS to
ip_finish_output2 for ipv4.

Reviewed-by: Filip Pudak <filip.pudak@windriver.com>
Signed-off-by: Heng Guo <heng.guo@windriver.com>
---
 net/ipv4/ip_forward.c | 1 -
 net/ipv4/ip_output.c  | 7 +++----
 net/ipv4/ipmr.c       | 1 -
 net/ipv6/ip6_output.c | 1 -
 net/ipv6/ip6mr.c      | 2 --
 5 files changed, 3 insertions(+), 9 deletions(-)

diff --git a/net/ipv4/ip_forward.c b/net/ipv4/ip_forward.c
index e18931a6d153..66fac1216d46 100644
--- a/net/ipv4/ip_forward.c
+++ b/net/ipv4/ip_forward.c
@@ -67,7 +67,6 @@ static int ip_forward_finish(struct net *net, struct sock *sk, struct sk_buff *s
 	struct ip_options *opt	= &(IPCB(skb)->opt);
 
 	__IP_INC_STATS(net, IPSTATS_MIB_OUTFORWDATAGRAMS);
-	__IP_ADD_STATS(net, IPSTATS_MIB_OUTOCTETS, skb->len);
 
 #ifdef CONFIG_NET_SWITCHDEV
 	if (skb->offload_l3_fwd_mark) {
diff --git a/net/ipv4/ip_output.c b/net/ipv4/ip_output.c
index 6ba1a0fafbaa..847eeb46be4b 100644
--- a/net/ipv4/ip_output.c
+++ b/net/ipv4/ip_output.c
@@ -207,6 +207,9 @@ static int ip_finish_output2(struct net *net, struct sock *sk, struct sk_buff *s
 	} else if (rt->rt_type == RTN_BROADCAST)
 		IP_UPD_PO_STATS(net, IPSTATS_MIB_OUTBCAST, skb->len);
 
+	/* OUTOCTETS should be counted after fragment */
+	IP_UPD_PO_STATS(net, IPSTATS_MIB_OUT, skb->len);
+
 	if (unlikely(skb_headroom(skb) < hh_len && dev->header_ops)) {
 		skb = skb_expand_head(skb, hh_len);
 		if (!skb)
@@ -366,8 +369,6 @@ int ip_mc_output(struct net *net, struct sock *sk, struct sk_buff *skb)
 	/*
 	 *	If the indicated interface is up and running, send the packet.
 	 */
-	IP_UPD_PO_STATS(net, IPSTATS_MIB_OUT, skb->len);
-
 	skb->dev = dev;
 	skb->protocol = htons(ETH_P_IP);
 
@@ -424,8 +425,6 @@ int ip_output(struct net *net, struct sock *sk, struct sk_buff *skb)
 {
 	struct net_device *dev = skb_dst(skb)->dev, *indev = skb->dev;
 
-	IP_UPD_PO_STATS(net, IPSTATS_MIB_OUT, skb->len);
-
 	skb->dev = dev;
 	skb->protocol = htons(ETH_P_IP);
 
diff --git a/net/ipv4/ipmr.c b/net/ipv4/ipmr.c
index 3f0c6d602fb7..9e222a57bc2b 100644
--- a/net/ipv4/ipmr.c
+++ b/net/ipv4/ipmr.c
@@ -1804,7 +1804,6 @@ static inline int ipmr_forward_finish(struct net *net, struct sock *sk,
 	struct ip_options *opt = &(IPCB(skb)->opt);
 
 	IP_INC_STATS(net, IPSTATS_MIB_OUTFORWDATAGRAMS);
-	IP_ADD_STATS(net, IPSTATS_MIB_OUTOCTETS, skb->len);
 
 	if (unlikely(opt->optlen))
 		ip_forward_options(skb);
diff --git a/net/ipv6/ip6_output.c b/net/ipv6/ip6_output.c
index 1e8c90e97608..275b24c89ac3 100644
--- a/net/ipv6/ip6_output.c
+++ b/net/ipv6/ip6_output.c
@@ -451,7 +451,6 @@ static inline int ip6_forward_finish(struct net *net, struct sock *sk,
 	struct dst_entry *dst = skb_dst(skb);
 
 	__IP6_INC_STATS(net, ip6_dst_idev(dst), IPSTATS_MIB_OUTFORWDATAGRAMS);
-	__IP6_ADD_STATS(net, ip6_dst_idev(dst), IPSTATS_MIB_OUTOCTETS, skb->len);
 
 #ifdef CONFIG_NET_SWITCHDEV
 	if (skb->offload_l3_fwd_mark) {
diff --git a/net/ipv6/ip6mr.c b/net/ipv6/ip6mr.c
index 67a3b8f6e72b..30ca064b76ef 100644
--- a/net/ipv6/ip6mr.c
+++ b/net/ipv6/ip6mr.c
@@ -2010,8 +2010,6 @@ static inline int ip6mr_forward2_finish(struct net *net, struct sock *sk, struct
 {
 	IP6_INC_STATS(net, ip6_dst_idev(skb_dst(skb)),
 		      IPSTATS_MIB_OUTFORWDATAGRAMS);
-	IP6_ADD_STATS(net, ip6_dst_idev(skb_dst(skb)),
-		      IPSTATS_MIB_OUTOCTETS, skb->len);
 	return dst_output(net, sk, skb);
 }
 
-- 
2.35.5


