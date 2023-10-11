Return-Path: <netdev+bounces-39781-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 60D2C7C478D
	for <lists+netdev@lfdr.de>; Wed, 11 Oct 2023 03:56:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D543B28179D
	for <lists+netdev@lfdr.de>; Wed, 11 Oct 2023 01:56:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8934A5D;
	Wed, 11 Oct 2023 01:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b="B5j3bJTr"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B407180D
	for <netdev@vger.kernel.org>; Wed, 11 Oct 2023 01:56:27 +0000 (UTC)
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A794093
	for <netdev@vger.kernel.org>; Tue, 10 Oct 2023 18:56:25 -0700 (PDT)
Received: from pps.filterd (m0250810.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39B1UOCG027468;
	Tue, 10 Oct 2023 18:51:50 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	PPS06212021; bh=TVAhG2U6rjCQCLzX2eMEH9gaHeHSV3JMMjyrD9yseh0=; b=
	B5j3bJTrjgfouOgoZwj6QSZtsuIcPOro3RI8b/YlBDWuTfc/5e3b4u3nwz7kPK0e
	71jxAdejmVjkNM6do8Ygu3/TCiNjrYXS0CSFGAdAmCvNVlIFogQDNFblGSXVYyTF
	FYKKL55Ti4C04ymlS4cky2prlUu3+48NYuPJpMoCg9EMMQEyzyGqu478/ODgI/0T
	tY7yQss8p4HUsfK7Kt/a7UwxL/DqbnY6N9F2EChGRnXnRCknQFdoKyejNhlv/3Rl
	7IpYTSTazRprWapHRZ5StdI9D4dMfb/ju9vuuGG6wWzKft4n86mvf/9uqGSAmanm
	M4IxVBuFb0dLtf8boDEcbA==
Received: from ala-exchng02.corp.ad.wrs.com (ala-exchng02.wrs.com [147.11.82.254])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3tnhq480u6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Tue, 10 Oct 2023 18:51:50 -0700 (PDT)
Received: from ala-exchng01.corp.ad.wrs.com (147.11.82.252) by
 ALA-EXCHNG02.corp.ad.wrs.com (147.11.82.254) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Tue, 10 Oct 2023 18:51:48 -0700
Received: from pek-lpd-ccm3.wrs.com (147.11.1.11) by
 ala-exchng01.corp.ad.wrs.com (147.11.82.252) with Microsoft SMTP Server id
 15.1.2507.32 via Frontend Transport; Tue, 10 Oct 2023 18:51:46 -0700
From: Heng Guo <heng.guo@windriver.com>
To: <davem@davemloft.net>, <dsahern@kernel.org>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>
CC: <netdev@vger.kernel.org>, <filip.pudak@windriver.com>,
        <heng.guo@windriver.com>
Subject: [PATCH] net-next: fix IPSTATS_MIB_OUTFORWDATAGRAMS increment after fragment check
Date: Wed, 11 Oct 2023 09:51:37 +0800
Message-ID: <20231011015137.27262-1-heng.guo@windriver.com>
X-Mailer: git-send-email 2.35.2
In-Reply-To: <20231008005922.24777-2-heng.guo@windriver.com>
References: <20231008005922.24777-2-heng.guo@windriver.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: sfW-2D_j9qfh302IYmtJ7XAhly8Weh22
X-Proofpoint-GUID: sfW-2D_j9qfh302IYmtJ7XAhly8Weh22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-10_19,2023-10-10_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0
 lowpriorityscore=0 suspectscore=0 malwarescore=0 priorityscore=1501
 adultscore=0 clxscore=1015 mlxlogscore=999 phishscore=0 mlxscore=0
 spamscore=0 impostorscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2309180000 definitions=main-2310110015
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Reproduce environment:
network with 3 VM linuxs is connected as below:
VM1<---->VM2(latest kernel 6.5.0-rc7)<---->VM3
VM1: eth0 ip: 192.168.122.207 MTU 1800
VM2: eth0 ip: 192.168.122.208, eth1 ip: 192.168.123.224 MTU 1500
VM3: eth0 ip: 192.168.123.240 MTU 1800

Reproduce:
VM1 send 1600 bytes UDP data to VM3 using tools scapy with flags='DF'.
scapy command:
send(IP(dst="192.168.123.240",flags='DF')/UDP()/str('0'*1600),count=1,
inter=1.000000)

Result:
Before IP data is sent.
----------------------------------------------------------------------
root@qemux86-64:~# cat /proc/net/snmp
Ip: Forwarding DefaultTTL InReceives InHdrErrors InAddrErrors
    ForwDatagrams InUnknownProtos InDiscards InDelivers OutRequests
    OutDiscards OutNoRoutes ReasmTimeout ReasmReqdss
Ip: 1 64 6 0 2 2 0 0 2 4 0 0 0 0 0 0 0 0 0
......
root@qemux86-64:~#
----------------------------------------------------------------------
After IP data is sent.
----------------------------------------------------------------------
root@qemux86-64:~# cat /proc/net/snmp
Ip: Forwarding DefaultTTL InReceives InHdrErrors InAddrErrors
    ForwDatagrams InUnknownProtos InDiscards InDelivers OutRequests
    OutDiscards OutNoRoutes ReasmTimeout ReasmReqdss
Ip: 1 64 7 0 2 2 0 0 2 5 0 0 0 0 0 0 0 1 0
......
root@qemux86-64:~#
----------------------------------------------------------------------
ForwDatagrams is always keeping 2 without increment.

Issue description and patch:
ip_exceeds_mtu() in ip_forward() drops this IP datagram because skb len
(1600 sending by scapy) is over MTU(1500 in VM2) if "DF" is set.
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
So do patch to move IPSTATS_MIB_OUTFORWDATAGRAMS counter to ip_forward()
for ipv4 and ip6_forward() for ipv6.

Test result with patch:
Before IP data is sent.
----------------------------------------------------------------------
root@qemux86-64:~# cat /proc/net/snmp
Ip: Forwarding DefaultTTL InReceives InHdrErrors InAddrErrors
    ForwDatagrams InUnknownProtos InDiscards InDelivers OutRequests
    OutDiscards OutNoRoutes ReasmTimeout ReasmReqdss
Ip: 1 64 6 0 2 2 0 0 2 4 0 0 0 0 0 0 0 0 0
......
root@qemux86-64:~#
----------------------------------------------------------------------
After IP data is sent.
----------------------------------------------------------------------
root@qemux86-64:~# cat /proc/net/snmp
Ip: Forwarding DefaultTTL InReceives InHdrErrors InAddrErrors
    ForwDatagrams InUnknownProtos InDiscards InDelivers OutRequests
    OutDiscards OutNoRoutes ReasmTimeout ReasmReqdss
Ip: 1 64 7 0 2 3 0 0 2 5 0 0 0 0 0 0 0 1 0
......
root@qemux86-64:~#
----------------------------------------------------------------------
ForwDatagrams is updated from 2 to 3.

Reviewed-by: Filip Pudak <filip.pudak@windriver.com>
Signed-off-by: Heng Guo <heng.guo@windriver.com>
Reviewed-by: David Ahern <dsahern@kernel.org>
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


