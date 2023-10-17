Return-Path: <netdev+bounces-41691-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D92B7CBB32
	for <lists+netdev@lfdr.de>; Tue, 17 Oct 2023 08:29:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 235751C20992
	for <lists+netdev@lfdr.de>; Tue, 17 Oct 2023 06:29:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA6E111C88;
	Tue, 17 Oct 2023 06:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b="rtViw2z/"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0F33DDCF
	for <netdev@vger.kernel.org>; Tue, 17 Oct 2023 06:29:07 +0000 (UTC)
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 809868F
	for <netdev@vger.kernel.org>; Mon, 16 Oct 2023 23:29:05 -0700 (PDT)
Received: from pps.filterd (m0250811.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 39H5JkKh002315;
	Tue, 17 Oct 2023 06:28:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=PPS06212021; bh=K94eO
	1ysicUSnbJXa13mWa4T2tpzFumc8G8sBKlCOco=; b=rtViw2z/xH13NGaMLOEaa
	LxvnIeY+J29oU29Am0ZYzw5Gg0M21fC1lW03Y1Y5JT9+ewfLSdGrnPaS/wWDCRfO
	gqUDdVswF1ZuIplzd1cIdHLHZkbnkaPrfYrVykC/z+8Z83MQjdGnsrn/SeKH+zhE
	kgBGy5Ctzux8zte9TTa4r7MGkiXGgqXJs5DnDODjN5FgVg0Nx7w+vpshm1kuMhdn
	jNpfeGkivXMznHf53qQdxMNVRc5dDYV2KSSJkz3gEmy9wVrdogIdsChls+YmnCpG
	2eV8dSa+J7RCHkmN1xPYDOPACVe01uBpfDo/ronMCN6o5BR/a4atEGMOQk8lHgMH
	w==
Received: from ala-exchng01.corp.ad.wrs.com (ala-exchng01.wrs.com [147.11.82.252])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3tqg6xaqg7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Tue, 17 Oct 2023 06:28:49 +0000 (GMT)
Received: from ala-exchng01.corp.ad.wrs.com (147.11.82.252) by
 ala-exchng01.corp.ad.wrs.com (147.11.82.252) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Mon, 16 Oct 2023 23:28:45 -0700
Received: from pek-lpd-ccm3.wrs.com (147.11.1.11) by
 ala-exchng01.corp.ad.wrs.com (147.11.82.252) with Microsoft SMTP Server id
 15.1.2507.32 via Frontend Transport; Mon, 16 Oct 2023 23:28:42 -0700
From: Heng Guo <heng.guo@windriver.com>
To: <davem@davemloft.net>, <dsahern@kernel.org>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>
CC: <netdev@vger.kernel.org>, <filip.pudak@windriver.com>,
        <heng.guo@windriver.com>, <kun.song@windriver.com>
Subject: [PATCH net-next] net: fix IPSTATS_MIB_OUTPKGS increment in OutForwDatagrams.
Date: Tue, 17 Oct 2023 14:28:38 +0800
Message-ID: <20231017062838.4897-1-heng.guo@windriver.com>
X-Mailer: git-send-email 2.35.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: ejxZdsO1NqWxYOg93dTJTrf8Ol2cpjPx
X-Proofpoint-ORIG-GUID: ejxZdsO1NqWxYOg93dTJTrf8Ol2cpjPx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-16_13,2023-10-12_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0
 priorityscore=1501 spamscore=0 mlxscore=0 bulkscore=0 clxscore=1015
 impostorscore=0 adultscore=0 malwarescore=0 lowpriorityscore=0
 suspectscore=0 mlxlogscore=824 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2309180000 definitions=main-2310170052
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Reproduce environment:
network with 3 VM linuxs is connected as below:
VM1<---->VM2(latest kernel 6.5.0-rc7)<---->VM3
VM1: eth0 ip: 192.168.122.207 MTU 1500
VM2: eth0 ip: 192.168.122.208, eth1 ip: 192.168.123.224 MTU 1500
VM3: eth0 ip: 192.168.123.240 MTU 1500

Reproduce:
VM1 send 1400 bytes UDP data to VM3 using tools scapy with flags=0.
scapy command:
send(IP(dst="192.168.123.240",flags=0)/UDP()/str('0'*1400),count=1,
inter=1.000000)

Result:
Before IP data is sent.
----------------------------------------------------------------------
root@qemux86-64:~# cat /proc/net/snmp
Ip: Forwarding DefaultTTL InReceives InHdrErrors InAddrErrors
  ForwDatagrams InUnknownProtos InDiscards InDelivers OutRequests
  OutDiscards OutNoRoutes ReasmTimeout ReasmReqds ReasmOKs ReasmFails
  FragOKs FragFails FragCreates
Ip: 1 64 11 0 3 4 0 0 4 7 0 0 0 0 0 0 0 0 0
......
----------------------------------------------------------------------
After IP data is sent.
----------------------------------------------------------------------
root@qemux86-64:~# cat /proc/net/snmp
Ip: Forwarding DefaultTTL InReceives InHdrErrors InAddrErrors
  ForwDatagrams InUnknownProtos InDiscards InDelivers OutRequests
  OutDiscards OutNoRoutes ReasmTimeout ReasmReqds ReasmOKs ReasmFails
  FragOKs FragFails FragCreates
Ip: 1 64 12 0 3 5 0 0 4 8 0 0 0 0 0 0 0 0 0
......
----------------------------------------------------------------------
"ForwDatagrams" increase from 4 to 5 and "OutRequests" also increase
from 7 to 8.

Issue description and patch:
IPSTATS_MIB_OUTPKTS("OutRequests") is counted with IPSTATS_MIB_OUTOCTETS
("OutOctets") in ip_finish_output2().
According to RFC 4293, it is "OutOctets" counted with "OutTransmits" but
not "OutRequests". "OutRequests" does not include any datagrams counted
in "ForwDatagrams".
ipSystemStatsOutOctets OBJECT-TYPE
    DESCRIPTION
           "The total number of octets in IP datagrams delivered to the
            lower layers for transmission.  Octets from datagrams
            counted in ipIfStatsOutTransmits MUST be counted here.
ipSystemStatsOutRequests OBJECT-TYPE
    DESCRIPTION
           "The total number of IP datagrams that local IP user-
            protocols (including ICMP) supplied to IP in requests for
            transmission.  Note that this counter does not include any
            datagrams counted in ipSystemStatsOutForwDatagrams.
So do patch to define IPSTATS_MIB_OUTPKTS to "OutTransmits" and add
IPSTATS_MIB_OUTREQUESTS for "OutRequests".
Add IPSTATS_MIB_OUTREQUESTS counter in __ip_local_out() for ipv4 and add
IPSTATS_MIB_OUT counter in ip6_finish_output2() for ipv6.

Test result with patch:
Before IP data is sent.
----------------------------------------------------------------------
root@qemux86-64:~# cat /proc/net/snmp
Ip: Forwarding DefaultTTL InReceives InHdrErrors InAddrErrors
  ForwDatagrams InUnknownProtos InDiscards InDelivers OutRequests
  OutDiscards OutNoRoutes ReasmTimeout ReasmReqds ReasmOKs ReasmFails
  FragOKs FragFails FragCreates OutTransmits
Ip: 1 64 9 0 5 1 0 0 3 3 0 0 0 0 0 0 0 0 0 4
......
root@qemux86-64:~# cat /proc/net/netstat
......
IpExt: InNoRoutes InTruncatedPkts InMcastPkts OutMcastPkts InBcastPkts
  OutBcastPkts InOctets OutOctets InMcastOctets OutMcastOctets
  InBcastOctets OutBcastOctets InCsumErrors InNoECTPkts InECT1Pkts
  InECT0Pkts InCEPkts ReasmOverlaps
IpExt: 0 0 0 0 0 0 2976 1896 0 0 0 0 0 9 0 0 0 0
----------------------------------------------------------------------
After IP data is sent.
----------------------------------------------------------------------
root@qemux86-64:~# cat /proc/net/snmp
Ip: Forwarding DefaultTTL InReceives InHdrErrors InAddrErrors
  ForwDatagrams InUnknownProtos InDiscards InDelivers OutRequests
  OutDiscards OutNoRoutes ReasmTimeout ReasmReqds ReasmOKs ReasmFails
  FragOKs FragFails FragCreates OutTransmits
Ip: 1 64 10 0 5 2 0 0 3 3 0 0 0 0 0 0 0 0 0 5
......
root@qemux86-64:~# cat /proc/net/netstat
......
IpExt: InNoRoutes InTruncatedPkts InMcastPkts OutMcastPkts InBcastPkts
  OutBcastPkts InOctets OutOctets InMcastOctets OutMcastOctets
  InBcastOctets OutBcastOctets InCsumErrors InNoECTPkts InECT1Pkts
  InECT0Pkts InCEPkts ReasmOverlaps
IpExt: 0 0 0 0 0 0 4404 3324 0 0 0 0 0 10 0 0 0 0
----------------------------------------------------------------------
"ForwDatagrams" increase from 1 to 2 and "OutRequests" is keeping 3.
"OutTransmits" increase from 4 to 5 and "OutOctets" increase 1428.

Signed-off-by: Heng Guo <heng.guo@windriver.com>
Reviewed-by: Kun Song <Kun.Song@windriver.com>
Reviewed-by: Filip Pudak <filip.pudak@windriver.com>
---
 include/uapi/linux/snmp.h | 3 ++-
 net/ipv4/ip_output.c      | 2 ++
 net/ipv4/proc.c           | 3 ++-
 net/ipv6/ip6_output.c     | 6 ++++--
 net/ipv6/mcast.c          | 5 ++---
 net/ipv6/ndisc.c          | 2 +-
 net/ipv6/proc.c           | 3 ++-
 net/ipv6/raw.c            | 2 +-
 net/mpls/af_mpls.c        | 6 +++---
 9 files changed, 19 insertions(+), 13 deletions(-)

diff --git a/include/uapi/linux/snmp.h b/include/uapi/linux/snmp.h
index 26f33a4c253d..b2b72886cb6d 100644
--- a/include/uapi/linux/snmp.h
+++ b/include/uapi/linux/snmp.h
@@ -24,7 +24,7 @@ enum
 	IPSTATS_MIB_INOCTETS,			/* InOctets */
 	IPSTATS_MIB_INDELIVERS,			/* InDelivers */
 	IPSTATS_MIB_OUTFORWDATAGRAMS,		/* OutForwDatagrams */
-	IPSTATS_MIB_OUTPKTS,			/* OutRequests */
+	IPSTATS_MIB_OUTREQUESTS,		/* OutRequests */
 	IPSTATS_MIB_OUTOCTETS,			/* OutOctets */
 /* other fields */
 	IPSTATS_MIB_INHDRERRORS,		/* InHdrErrors */
@@ -57,6 +57,7 @@ enum
 	IPSTATS_MIB_ECT0PKTS,			/* InECT0Pkts */
 	IPSTATS_MIB_CEPKTS,			/* InCEPkts */
 	IPSTATS_MIB_REASM_OVERLAPS,		/* ReasmOverlaps */
+	IPSTATS_MIB_OUTPKTS,			/* OutTransmits */
 	__IPSTATS_MIB_MAX
 };
 
diff --git a/net/ipv4/ip_output.c b/net/ipv4/ip_output.c
index 847eeb46be4b..e462de5a081b 100644
--- a/net/ipv4/ip_output.c
+++ b/net/ipv4/ip_output.c
@@ -101,6 +101,8 @@ int __ip_local_out(struct net *net, struct sock *sk, struct sk_buff *skb)
 {
 	struct iphdr *iph = ip_hdr(skb);
 
+	IP_INC_STATS(net, IPSTATS_MIB_OUTREQUESTS);
+
 	iph_set_totlen(iph, skb->len);
 	ip_send_check(iph);
 
diff --git a/net/ipv4/proc.c b/net/ipv4/proc.c
index eaf1d3113b62..a85b0aba3646 100644
--- a/net/ipv4/proc.c
+++ b/net/ipv4/proc.c
@@ -83,7 +83,7 @@ static const struct snmp_mib snmp4_ipstats_list[] = {
 	SNMP_MIB_ITEM("InUnknownProtos", IPSTATS_MIB_INUNKNOWNPROTOS),
 	SNMP_MIB_ITEM("InDiscards", IPSTATS_MIB_INDISCARDS),
 	SNMP_MIB_ITEM("InDelivers", IPSTATS_MIB_INDELIVERS),
-	SNMP_MIB_ITEM("OutRequests", IPSTATS_MIB_OUTPKTS),
+	SNMP_MIB_ITEM("OutRequests", IPSTATS_MIB_OUTREQUESTS),
 	SNMP_MIB_ITEM("OutDiscards", IPSTATS_MIB_OUTDISCARDS),
 	SNMP_MIB_ITEM("OutNoRoutes", IPSTATS_MIB_OUTNOROUTES),
 	SNMP_MIB_ITEM("ReasmTimeout", IPSTATS_MIB_REASMTIMEOUT),
@@ -93,6 +93,7 @@ static const struct snmp_mib snmp4_ipstats_list[] = {
 	SNMP_MIB_ITEM("FragOKs", IPSTATS_MIB_FRAGOKS),
 	SNMP_MIB_ITEM("FragFails", IPSTATS_MIB_FRAGFAILS),
 	SNMP_MIB_ITEM("FragCreates", IPSTATS_MIB_FRAGCREATES),
+	SNMP_MIB_ITEM("OutTransmits", IPSTATS_MIB_OUTPKTS),
 	SNMP_MIB_SENTINEL
 };
 
diff --git a/net/ipv6/ip6_output.c b/net/ipv6/ip6_output.c
index 22c146818e0a..0873c9f216f6 100644
--- a/net/ipv6/ip6_output.c
+++ b/net/ipv6/ip6_output.c
@@ -117,6 +117,8 @@ static int ip6_finish_output2(struct net *net, struct sock *sk, struct sk_buff *
 			return res;
 	}
 
+	IP6_UPD_PO_STATS(net, idev, IPSTATS_MIB_OUT, skb->len);
+
 	rcu_read_lock();
 	nexthop = rt6_nexthop((struct rt6_info *)dst, daddr);
 	neigh = __ipv6_neigh_lookup_noref(dev, nexthop);
@@ -329,7 +331,7 @@ int ip6_xmit(const struct sock *sk, struct sk_buff *skb, struct flowi6 *fl6,
 
 	mtu = dst_mtu(dst);
 	if ((skb->len <= mtu) || skb->ignore_df || skb_is_gso(skb)) {
-		IP6_UPD_PO_STATS(net, idev, IPSTATS_MIB_OUT, skb->len);
+		IP6_INC_STATS(net, idev, IPSTATS_MIB_OUTREQUESTS);
 
 		/* if egress device is enslaved to an L3 master device pass the
 		 * skb to its handler for processing
@@ -1978,7 +1980,7 @@ struct sk_buff *__ip6_make_skb(struct sock *sk,
 	skb->tstamp = cork->base.transmit_time;
 
 	ip6_cork_steal_dst(skb, cork);
-	IP6_UPD_PO_STATS(net, rt->rt6i_idev, IPSTATS_MIB_OUT, skb->len);
+	IP6_INC_STATS(net, rt->rt6i_idev, IPSTATS_MIB_OUTREQUESTS);
 	if (proto == IPPROTO_ICMPV6) {
 		struct inet6_dev *idev = ip6_dst_idev(skb_dst(skb));
 		u8 icmp6_type;
diff --git a/net/ipv6/mcast.c b/net/ipv6/mcast.c
index 714cdc9e2b8e..632e27a8df59 100644
--- a/net/ipv6/mcast.c
+++ b/net/ipv6/mcast.c
@@ -1791,7 +1791,7 @@ static void mld_sendpack(struct sk_buff *skb)
 
 	rcu_read_lock();
 	idev = __in6_dev_get(skb->dev);
-	IP6_UPD_PO_STATS(net, idev, IPSTATS_MIB_OUT, skb->len);
+	IP6_INC_STATS(net, idev, IPSTATS_MIB_OUTREQUESTS);
 
 	payload_len = (skb_tail_pointer(skb) - skb_network_header(skb)) -
 		sizeof(*pip6);
@@ -2149,8 +2149,7 @@ static void igmp6_send(struct in6_addr *addr, struct net_device *dev, int type)
 	full_len = sizeof(struct ipv6hdr) + payload_len;
 
 	rcu_read_lock();
-	IP6_UPD_PO_STATS(net, __in6_dev_get(dev),
-		      IPSTATS_MIB_OUT, full_len);
+	IP6_INC_STATS(net, __in6_dev_get(dev),IPSTATS_MIB_OUTREQUESTS);
 	rcu_read_unlock();
 
 	skb = sock_alloc_send_skb(sk, hlen + tlen + full_len, 1, &err);
diff --git a/net/ipv6/ndisc.c b/net/ipv6/ndisc.c
index a42be96ae209..4190d010d19c 100644
--- a/net/ipv6/ndisc.c
+++ b/net/ipv6/ndisc.c
@@ -504,7 +504,7 @@ void ndisc_send_skb(struct sk_buff *skb, const struct in6_addr *daddr,
 
 	rcu_read_lock();
 	idev = __in6_dev_get(dst->dev);
-	IP6_UPD_PO_STATS(net, idev, IPSTATS_MIB_OUT, skb->len);
+	IP6_INC_STATS(net, idev, IPSTATS_MIB_OUTREQUESTS);
 
 	err = NF_HOOK(NFPROTO_IPV6, NF_INET_LOCAL_OUT,
 		      net, sk, skb, NULL, dst->dev,
diff --git a/net/ipv6/proc.c b/net/ipv6/proc.c
index e20b3705c2d2..6d1d9221649d 100644
--- a/net/ipv6/proc.c
+++ b/net/ipv6/proc.c
@@ -61,7 +61,7 @@ static const struct snmp_mib snmp6_ipstats_list[] = {
 	SNMP_MIB_ITEM("Ip6InDiscards", IPSTATS_MIB_INDISCARDS),
 	SNMP_MIB_ITEM("Ip6InDelivers", IPSTATS_MIB_INDELIVERS),
 	SNMP_MIB_ITEM("Ip6OutForwDatagrams", IPSTATS_MIB_OUTFORWDATAGRAMS),
-	SNMP_MIB_ITEM("Ip6OutRequests", IPSTATS_MIB_OUTPKTS),
+	SNMP_MIB_ITEM("Ip6OutRequests", IPSTATS_MIB_OUTREQUESTS),
 	SNMP_MIB_ITEM("Ip6OutDiscards", IPSTATS_MIB_OUTDISCARDS),
 	SNMP_MIB_ITEM("Ip6OutNoRoutes", IPSTATS_MIB_OUTNOROUTES),
 	SNMP_MIB_ITEM("Ip6ReasmTimeout", IPSTATS_MIB_REASMTIMEOUT),
@@ -84,6 +84,7 @@ static const struct snmp_mib snmp6_ipstats_list[] = {
 	SNMP_MIB_ITEM("Ip6InECT1Pkts", IPSTATS_MIB_ECT1PKTS),
 	SNMP_MIB_ITEM("Ip6InECT0Pkts", IPSTATS_MIB_ECT0PKTS),
 	SNMP_MIB_ITEM("Ip6InCEPkts", IPSTATS_MIB_CEPKTS),
+	SNMP_MIB_ITEM("Ip6OutTransmits", IPSTATS_MIB_OUTPKTS),
 	SNMP_MIB_SENTINEL
 };
 
diff --git a/net/ipv6/raw.c b/net/ipv6/raw.c
index 49381f35b623..723c37a5cd8c 100644
--- a/net/ipv6/raw.c
+++ b/net/ipv6/raw.c
@@ -652,7 +652,7 @@ static int rawv6_send_hdrinc(struct sock *sk, struct msghdr *msg, int length,
 	 * have been queued for deletion.
 	 */
 	rcu_read_lock();
-	IP6_UPD_PO_STATS(net, rt->rt6i_idev, IPSTATS_MIB_OUT, skb->len);
+	IP6_INC_STATS(net, rt->rt6i_idev, IPSTATS_MIB_OUTREQUESTS);
 	err = NF_HOOK(NFPROTO_IPV6, NF_INET_LOCAL_OUT, net, sk, skb,
 		      NULL, rt->dst.dev, dst_output);
 	if (err > 0)
diff --git a/net/mpls/af_mpls.c b/net/mpls/af_mpls.c
index bf6e81d56263..63ad72e403f2 100644
--- a/net/mpls/af_mpls.c
+++ b/net/mpls/af_mpls.c
@@ -141,14 +141,14 @@ void mpls_stats_inc_outucastpkts(struct net_device *dev,
 					   tx_packets,
 					   tx_bytes);
 	} else if (skb->protocol == htons(ETH_P_IP)) {
-		IP_UPD_PO_STATS(dev_net(dev), IPSTATS_MIB_OUT, skb->len);
+		IP_INC_STATS(dev_net(dev), IPSTATS_MIB_OUTREQUESTS);
 #if IS_ENABLED(CONFIG_IPV6)
 	} else if (skb->protocol == htons(ETH_P_IPV6)) {
 		struct inet6_dev *in6dev = __in6_dev_get(dev);
 
 		if (in6dev)
-			IP6_UPD_PO_STATS(dev_net(dev), in6dev,
-					 IPSTATS_MIB_OUT, skb->len);
+			IP6_INC_STATS(dev_net(dev), in6dev,
+				      IPSTATS_MIB_OUTREQUESTS);
 #endif
 	}
 }
-- 
2.25.1


