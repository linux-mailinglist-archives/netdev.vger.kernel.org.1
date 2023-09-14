Return-Path: <netdev+bounces-33727-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A758D79F9F2
	for <lists+netdev@lfdr.de>; Thu, 14 Sep 2023 07:16:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 33C551F21B9A
	for <lists+netdev@lfdr.de>; Thu, 14 Sep 2023 05:16:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 475B4250EE;
	Thu, 14 Sep 2023 05:16:42 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36EDD62C
	for <netdev@vger.kernel.org>; Thu, 14 Sep 2023 05:16:41 +0000 (UTC)
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 311101BD0
	for <netdev@vger.kernel.org>; Wed, 13 Sep 2023 22:16:41 -0700 (PDT)
Received: from pps.filterd (m0250812.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 38E4dEgK002077;
	Thu, 14 Sep 2023 05:16:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=PPS06212021; bh=aE3CP
	vIjj/aglsG4Fhq9rAkcdAiIMhr3vBt5mSVa0Ok=; b=dn2vr1/QzbL7GTYggOvQ7
	Rvq9Gucub8T4qYIb/yEK8GgMMUvBBy+uv2E9jf5a0bfClIxHmxNzaVNurXTFY5ZS
	4NW1P8X6s8T+LBOVDG3coPElqLltebD4v1tT0/MJPy9c5J3ZOwsL39MqbX5mYu9X
	ix3h4Q2cWpyBvf/TBucDdAEyz7f94pBFaFcGFn3YPrMyLrLlIgs9S/aI5tux+x0F
	HZ32lhTokync+3yTMAt+Aov/tCDtp1T7JwxbFXWHMuEyE7LErla8dxupsTMF3+NI
	3u1Jytj+dvQjuSGMb3EVW1bVm7xGDqBsv6da1eV2ot71Zc0RmVROwXtSdKc3u0I4
	Q==
Received: from ala-exchng01.corp.ad.wrs.com (ala-exchng01.wrs.com [147.11.82.252])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3t2y8m9ef2-8
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Thu, 14 Sep 2023 05:16:27 +0000 (GMT)
Received: from ALA-EXCHNG02.corp.ad.wrs.com (147.11.82.254) by
 ala-exchng01.corp.ad.wrs.com (147.11.82.252) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Wed, 13 Sep 2023 22:16:26 -0700
Received: from pek-lpd-ccm2.wrs.com (147.11.1.11) by
 ALA-EXCHNG02.corp.ad.wrs.com (147.11.82.254) with Microsoft SMTP Server id
 15.1.2507.27 via Frontend Transport; Wed, 13 Sep 2023 22:16:24 -0700
From: Heng Guo <heng.guo@windriver.com>
To: <davem@davemloft.net>, <sahern@kernel.org>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>
CC: <netdev@vger.kernel.org>, <filip.pudak@windriver.com>,
        <heng.guo@windriver.com>
Subject: [PATCH 0/1] Issue description and debug
Date: Thu, 14 Sep 2023 13:16:22 +0800
Message-ID: <20230914051623.2180843-1-heng.guo@windriver.com>
X-Mailer: git-send-email 2.26.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: yZBisT081nhrPCbT3-d7hiV0_70mVpyI
X-Proofpoint-GUID: yZBisT081nhrPCbT3-d7hiV0_70mVpyI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-14_02,2023-09-13_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 priorityscore=1501 mlxlogscore=524 spamscore=0 adultscore=0
 lowpriorityscore=0 malwarescore=0 bulkscore=0 suspectscore=0 clxscore=1011
 mlxscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2309140045

Hi maintainers,

The IPSTATS_MIB_OUTFORWDATAGRAMS is counted after fragment check.

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
(1600 sending by scapy) is over MTU(1500 in VM2) and "DF" is set.
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

Thanks,
Heng


Heng Guo (1):
  net: ipv4,ipv6: fix IPSTATS_MIB_OUTFORWDATAGRAMS increment after
    fragment check

 net/ipv4/ip_forward.c | 4 ++--
 net/ipv6/ip6_output.c | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

-- 
2.25.1


