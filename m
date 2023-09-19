Return-Path: <netdev+bounces-34912-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9102D7A5E3B
	for <lists+netdev@lfdr.de>; Tue, 19 Sep 2023 11:38:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 49B382824A1
	for <lists+netdev@lfdr.de>; Tue, 19 Sep 2023 09:38:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A10493FB19;
	Tue, 19 Sep 2023 09:38:33 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E5E538F96
	for <netdev@vger.kernel.org>; Tue, 19 Sep 2023 09:38:32 +0000 (UTC)
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E11BADA
	for <netdev@vger.kernel.org>; Tue, 19 Sep 2023 02:38:30 -0700 (PDT)
Received: from pps.filterd (m0250809.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 38J6DjQS025805;
	Tue, 19 Sep 2023 02:38:14 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	PPS06212021; bh=ZUJnicSdg8YY5RDH0GBaEBxNsiaWMdX5bmFhPcebdIo=; b=
	rtf+hxBYgzUzic0WQfTQo8srhUwDHS1I76xa1TDDBfHiqnT2vo/5yc+vkVGDgh5I
	0lT3XmPQ0gvOxos2EHepEqjp7d5ud6jjF6ZfqCkfKEarrVmHyON7DxBID/YcNaLT
	Uwb6DcD+nRKeK5s3ShjDxx6ZGdJpeIVM/zUw/O7CZhftNg5TexkhL32jKhYFCXkd
	koUE0ghPSPWEIgEbmioRlwMsCGbCFdBR0wK4YR4e9aQUCM+n8NsgcSSauJ1GE+4P
	XB2EZfNSPtDa8RZ3dVy6CTvuhxWTBWV+7BRifNQQFOChEFv6PMfjSl293XxGVogl
	bNYvBF8UPqsY8r0f4rVdfQ==
Received: from ala-exchng01.corp.ad.wrs.com (ala-exchng01.wrs.com [147.11.82.252])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3t5bvft1qw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Tue, 19 Sep 2023 02:38:13 -0700 (PDT)
Received: from ala-exchng01.corp.ad.wrs.com (147.11.82.252) by
 ala-exchng01.corp.ad.wrs.com (147.11.82.252) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Tue, 19 Sep 2023 02:38:12 -0700
Received: from pek-lpd-ccm3.wrs.com (147.11.1.11) by
 ala-exchng01.corp.ad.wrs.com (147.11.82.252) with Microsoft SMTP Server id
 15.1.2507.32 via Frontend Transport; Tue, 19 Sep 2023 02:38:10 -0700
From: Heng Guo <heng.guo@windriver.com>
To: <davem@davemloft.net>, <sahern@kernel.org>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>
CC: <netdev@vger.kernel.org>, <filip.pudak@windriver.com>,
        <heng.guo@windriver.com>
Subject: [PATCH v2] net: ipv4,ipv6: fix IPSTATS_MIB_OUTFORWDATAGRAMS increment after fragment check
Date: Tue, 19 Sep 2023 17:38:03 +0800
Message-ID: <20230919093803.56034-2-heng.guo@windriver.com>
X-Mailer: git-send-email 2.35.2
In-Reply-To: <20230919093803.56034-1-heng.guo@windriver.com>
References: <20230914051623.2180843-2-heng.guo@windriver.com>
 <20230919093803.56034-1-heng.guo@windriver.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: WbNZA0igjqiNf2U4FyBEvS9sDeVLzRrd
X-Proofpoint-ORIG-GUID: WbNZA0igjqiNf2U4FyBEvS9sDeVLzRrd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.980,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-19_04,2023-09-18_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0
 lowpriorityscore=0 priorityscore=1501 clxscore=1015 impostorscore=0
 malwarescore=0 bulkscore=0 mlxlogscore=870 phishscore=0 spamscore=0
 suspectscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2309190081
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

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


