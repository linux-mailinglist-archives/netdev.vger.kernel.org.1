Return-Path: <netdev+bounces-38835-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 13C417BCB54
	for <lists+netdev@lfdr.de>; Sun,  8 Oct 2023 02:59:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A481B281BC6
	for <lists+netdev@lfdr.de>; Sun,  8 Oct 2023 00:59:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAACF10E9;
	Sun,  8 Oct 2023 00:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b="P1TG4mT1"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 418FBA50
	for <netdev@vger.kernel.org>; Sun,  8 Oct 2023 00:59:46 +0000 (UTC)
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 360696EB2
	for <netdev@vger.kernel.org>; Sat,  7 Oct 2023 17:59:45 -0700 (PDT)
Received: from pps.filterd (m0250810.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3980oJ5b000554;
	Sat, 7 Oct 2023 17:59:26 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=PPS06212021; bh=/WTWp
	ZpzzZeVrVhceVgJDrIew9BrLrahWAtm5ITuToM=; b=P1TG4mT1q15/ha/s5C9Qi
	beE7xSAtJEvv4oKOk0smOMJIzvGzodBlnqDSR0Qlz5vqrPiFrRRByGEIWO+5hSOS
	Zisb4c17ZGWuP0+cg08WYZgVrPdqB9IS9/is5EbVaywOw3rhWjbEcDTyjfCL4fBn
	N9W4d5slwhHfVBSdsj+os8zodtIp6SifeuNglY3g60l2e0nuXpnlFUzdxz2Vemhz
	HuzoxJWEUkSAiGd2erShbILJ/OhNFmy9l35r0FlG6Mkeb4pU+okemaZxdGDVuK52
	FRJ+mZHVMDLFlVVkeYxoZVLI1O7uRd9hn5wLw23rH5a8yEA+eQE9rqOGW+vQsi7S
	A==
Received: from ala-exchng02.corp.ad.wrs.com (ala-exchng02.wrs.com [147.11.82.254])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3tk2m0ghvw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Sat, 07 Oct 2023 17:59:26 -0700 (PDT)
Received: from ala-exchng01.corp.ad.wrs.com (147.11.82.252) by
 ALA-EXCHNG02.corp.ad.wrs.com (147.11.82.254) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Sat, 7 Oct 2023 17:59:25 -0700
Received: from pek-lpd-ccm3.wrs.com (147.11.1.11) by
 ala-exchng01.corp.ad.wrs.com (147.11.82.252) with Microsoft SMTP Server id
 15.1.2507.32 via Frontend Transport; Sat, 7 Oct 2023 17:59:23 -0700
From: Heng Guo <heng.guo@windriver.com>
To: <davem@davemloft.net>, <dsahern@kernel.org>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>
CC: <netdev@vger.kernel.org>, <filip.pudak@windriver.com>,
        <heng.guo@windriver.com>
Subject: [PATCH 0/1] Issue description and debug
Date: Sun, 8 Oct 2023 08:59:21 +0800
Message-ID: <20231008005922.24777-1-heng.guo@windriver.com>
X-Mailer: git-send-email 2.35.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: 4ZX5aBUYIxCTkK_m38aiE7viJwJU1x3K
X-Proofpoint-ORIG-GUID: 4ZX5aBUYIxCTkK_m38aiE7viJwJU1x3K
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-07_18,2023-10-06_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 spamscore=0
 adultscore=0 suspectscore=0 phishscore=0 clxscore=1011 lowpriorityscore=0
 bulkscore=0 mlxlogscore=533 impostorscore=0 priorityscore=1501
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2309180000 definitions=main-2310080006
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
	RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

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

This is a new email thread, last one is:
https://lore.kernel.org/all/20230914051623.2180843-2-heng.guo@windriver.com


Heng Guo (1):
  net-next: fix IPSTATS_MIB_OUTFORWDATAGRAMS increment after fragment
    check

 net/ipv4/ip_forward.c | 4 ++--
 net/ipv6/ip6_output.c | 6 ++----
 2 files changed, 4 insertions(+), 6 deletions(-)

-- 
2.25.1


