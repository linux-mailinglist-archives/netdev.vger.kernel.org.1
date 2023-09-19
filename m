Return-Path: <netdev+bounces-34911-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 641BF7A5E3A
	for <lists+netdev@lfdr.de>; Tue, 19 Sep 2023 11:38:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1C6552824F7
	for <lists+netdev@lfdr.de>; Tue, 19 Sep 2023 09:38:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 209EA341A0;
	Tue, 19 Sep 2023 09:38:32 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4A8D450E9
	for <netdev@vger.kernel.org>; Tue, 19 Sep 2023 09:38:30 +0000 (UTC)
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BF4DE7
	for <netdev@vger.kernel.org>; Tue, 19 Sep 2023 02:38:28 -0700 (PDT)
Received: from pps.filterd (m0250810.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38J6A3Co019017;
	Tue, 19 Sep 2023 02:38:11 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	PPS06212021; bh=FoHeJfDj+4G/JIgb3myzNjXn8OZlclbys96jzM5/WHM=; b=
	neNE5n23XIY4X7gU9YixqoUC2/mpPpqFoRjcvFk0hsRp2gzlc5bXnVgCEbe8CwQN
	xMPbCuSVfJsoTQoN/RXJ/GtoUE5a/M4akSjzYGcQXLXJNNhkj+iucGD07UfgOEDy
	meBZWdHyNa5n64xjSc1yG/iaXbszd2FhqYCnKBQdaqNwXpGSmCa9jmwRmb7epdWf
	N97DQ8vohZvwz2Bpx5ejwKyif/NYUw56MxMvu0Eu/Am9XuxPpucSjMTkexVPIfvn
	xPBD8uIrVD+vMaYllAlq/8zhZHMnE2QfBvACqq1Cy6JK6arf51GHLgkqG8f6Qiih
	0D8M5No9x2t/XOsZlbTfEw==
Received: from ala-exchng01.corp.ad.wrs.com (ala-exchng01.wrs.com [147.11.82.252])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3t57n0t57q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Tue, 19 Sep 2023 02:38:11 -0700 (PDT)
Received: from ala-exchng01.corp.ad.wrs.com (147.11.82.252) by
 ala-exchng01.corp.ad.wrs.com (147.11.82.252) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Tue, 19 Sep 2023 02:38:10 -0700
Received: from pek-lpd-ccm3.wrs.com (147.11.1.11) by
 ala-exchng01.corp.ad.wrs.com (147.11.82.252) with Microsoft SMTP Server id
 15.1.2507.32 via Frontend Transport; Tue, 19 Sep 2023 02:38:08 -0700
From: Heng Guo <heng.guo@windriver.com>
To: <davem@davemloft.net>, <sahern@kernel.org>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>
CC: <netdev@vger.kernel.org>, <filip.pudak@windriver.com>,
        <heng.guo@windriver.com>
Subject: [PATCH v2 0/1] Issue description and debug
Date: Tue, 19 Sep 2023 17:38:02 +0800
Message-ID: <20230919093803.56034-1-heng.guo@windriver.com>
X-Mailer: git-send-email 2.35.2
In-Reply-To: <20230914051623.2180843-2-heng.guo@windriver.com>
References: <20230914051623.2180843-2-heng.guo@windriver.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: 23_CYDpurLKww-5THtZ-rqQ6Tqs8yYeF
X-Proofpoint-ORIG-GUID: 23_CYDpurLKww-5THtZ-rqQ6Tqs8yYeF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.980,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-19_04,2023-09-18_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 phishscore=0
 suspectscore=0 mlxscore=0 lowpriorityscore=0 adultscore=0 bulkscore=0
 clxscore=1015 malwarescore=0 mlxlogscore=460 priorityscore=1501
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2309190081
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
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



v1->v2: fix build warning
Reported-by: kernel test robot <lkp@intel.com>
Closes:
https://lore.kernel.org/oe-kbuild-all/202309141701.7OFxGdE5-lkp@intel.com/

Heng Guo (1):
  net: ipv4,ipv6: fix IPSTATS_MIB_OUTFORWDATAGRAMS increment after
    fragment check

 net/ipv4/ip_forward.c | 4 ++--
 net/ipv6/ip6_output.c | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

-- 
2.25.1


