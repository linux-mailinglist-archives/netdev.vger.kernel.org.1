Return-Path: <netdev+bounces-30571-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 64EA878814F
	for <lists+netdev@lfdr.de>; Fri, 25 Aug 2023 09:55:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1EC1C281695
	for <lists+netdev@lfdr.de>; Fri, 25 Aug 2023 07:55:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E76263D99;
	Fri, 25 Aug 2023 07:55:28 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D98C73D92
	for <netdev@vger.kernel.org>; Fri, 25 Aug 2023 07:55:28 +0000 (UTC)
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AB371FF2
	for <netdev@vger.kernel.org>; Fri, 25 Aug 2023 00:55:20 -0700 (PDT)
Received: from pps.filterd (m0250809.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 37P7qGIm009273;
	Fri, 25 Aug 2023 00:55:10 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=PPS06212021; bh=qlPjn
	Zcr3Aw4LO9+6R3LbO5VTUbCsMI8eA8/LZS6ftw=; b=cwtSFp6QDeiuSl71oeirF
	v1Qx8Fs1htR85ZIdlyLyzFCw7d7ZFXqNAh/OU49AkJE3lECCzTY/uXtR+A/U87v0
	sv7mgtEYZNUjBAkB7zAu8haa09+gXc93SKx57oLllpkw94VQLBtu5xBqs9xGDpl4
	Yl5rNanIn5Vv8tXjwLddAJWLZL9vd3YLgw2lzw2uQuZgygpwuqX45I76vC7iPDEo
	I2OWT4uxyhs1YzTuUKZ2EeKGARgNGeX8VzO5aO81ObM09sJ0wLfGzOaa41i43pUB
	jsLN7gh2g96s1Tv0fZgsT0V14UXI1oJRVttB6xTB8MAC/ZMQgnbPlb2ZgFFLF0mW
	A==
Received: from ala-exchng01.corp.ad.wrs.com (ala-exchng01.wrs.com [147.11.82.252])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3sn20e2xwb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Fri, 25 Aug 2023 00:55:09 -0700 (PDT)
Received: from ala-exchng01.corp.ad.wrs.com (147.11.82.252) by
 ala-exchng01.corp.ad.wrs.com (147.11.82.252) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Fri, 25 Aug 2023 00:55:08 -0700
Received: from pek-lpd-ccm6.wrs.com (147.11.1.11) by
 ala-exchng01.corp.ad.wrs.com (147.11.82.252) with Microsoft SMTP Server id
 15.1.2507.27 via Frontend Transport; Fri, 25 Aug 2023 00:55:05 -0700
From: Heng Guo <heng.guo@windriver.com>
To: <davem@davemloft.net>, <sahern@kernel.org>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>
CC: <netdev@vger.kernel.org>, <Richard.Danter@windriver.com>,
        <filip.pudak@windriver.com>, <heng.guo@windriver.com>
Subject: [PATCH 0/1] Issue description and debug
Date: Fri, 25 Aug 2023 15:55:04 +0800
Message-ID: <20230825075505.3932972-1-heng.guo@windriver.com>
X-Mailer: git-send-email 2.35.5
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: 05LhLgAO9w9dJj9Eu9tajAM_P2Dat-aM
X-Proofpoint-ORIG-GUID: 05LhLgAO9w9dJj9Eu9tajAM_P2Dat-aM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-25_05,2023-08-24_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 clxscore=1011
 impostorscore=0 spamscore=0 malwarescore=0 mlxscore=0 suspectscore=0
 priorityscore=1501 adultscore=0 lowpriorityscore=0 bulkscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2308250068
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi maintainers,

The IPSTATS_MIB_OUTOCTETS increment is duplicated in SNMP test.

Reproduce environment:
network with 3 VM linuxs is connected as below:
VM1<---->VM2(latest kernel 6.5.0-rc7)<---->VM3
VM1: eth0 ip: 192.168.122.207
VM2: eth0 ip: 192.168.122.208, eth1 ip: 192.168.123.104
VM3: eth0 ip: 192.168.123.240

Reproduce:
VM1 send 1400 bytes UDP data to VM3 using tools scapy.
scapy command:
send(IP(dst="192.168.123.240",flags=0)/UDP()/str('0'*1400),count=1,
inter=1.000000)

Result:
----------------------------------------------------------------------
root@qemux86-64:~# cat /proc/net/netstat
TcpExt: SyncookiesSent SyncookiesRecv SyncookiesFailed ......
TcpExt: 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0  ......
IpExt: InNoRoutes InTruncatedPkts InMcastPkts OutMcastPkts
	InBcastPkts OutBcastPkts InOctets OutOctets    ......
IpExt: 0 0 0 0 0 0 796 140 0 0 0 0 0 4 0 0 0 0
root@qemux86-64:~# 
root@qemux86-64:~# cat /proc/net/netstat
TcpExt: SyncookiesSent SyncookiesRecv SyncookiesFailed ......
TcpExt: 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0  ......
IpExt: InNoRoutes InTruncatedPkts InMcastPkts OutMcastPkts
	InBcastPkts OutBcastPkts InOctets OutOctets    ......
IpExt: 0 0 0 0 0 0 2224 2996 0 0 0 0 0 5 0 0 0 0
----------------------------------------------------------------------
OutOctets increment is duplicated (2996-140=2856)


Issue description and debug:
Add dump_stack() in ip_output(), get below test logs with core stack.
----------------------------------------------------------------------
root@qemux86-64:~# dmesg
[    0.000000] Linux version 6.5.0-rc7-yocto-standard (oe-user@oe-host)
(x86_64-poky-linux-gcc (GCC) 13.2.0, GNU ld (GNU Binutils)
 2.41.0.20230731) #1 SMP PREEMPT_DY3
[    0.000000] Command line: root=/dev/vda rw console=ttyS0 mem=256M
ip=dhcp
[    0.000000] BIOS-provided physical RAM map:
......
[   64.225063] ip_forward_finish: IPSTATS_MIB_OUTOCTETS len:1428
[   64.228672] ip_output: increase IPSTATS_MIB_OUT len:1428
[   64.228695] CPU: 0 PID: 0 Comm: swapper/0 Not tainted
6.5.0-rc7-yocto-standard #1
[   64.228709] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996),
BIOS 1.13.0-1ubuntu1.1 04/01/2014
[   64.228715] Call Trace:
[   64.228721]  <IRQ>
[   64.228728]  dump_stack_lvl+0x3b/0x50
[   64.228744]  dump_stack+0x14/0x20
[   64.228756]  ip_output+0x129/0x140
[   64.228770]  ? dump_stack_lvl+0x47/0x50
[   64.228785]  ip_forward_finish+0xc8/0xe0
[   64.228801]  ip_forward+0x540/0x5a0
[   64.228819]  ip_sublist_rcv_finish+0x72/0x80
[   64.228834]  ip_sublist_rcv+0x160/0x1a0
[   64.228854]  ip_list_rcv+0xff/0x130
[   64.228871]  __netif_receive_skb_list_core+0x21b/0x240
[   64.228891]  netif_receive_skb_list_internal+0x1b9/0x2d0
[   64.228935]  ? detach_buf_split+0x76/0x150
[   64.228966]  napi_complete_done+0x78/0x190
[   64.228979]  virtnet_poll+0x48f/0x5e0
[   64.229001]  __napi_poll+0x31/0x1d0
[   64.229014]  net_rx_action+0x295/0x300
[   64.229030]  __do_softirq+0xff/0x315
[   64.229047]  irq_exit_rcu+0x82/0xd0
[   64.229059]  common_interrupt+0xb5/0xd0
[   64.229072]  </IRQ>
[   64.229077]  <TASK>
[   64.229083]  asm_common_interrupt+0x2b/0x40
[   64.229095] RIP: 0010:default_idle+0x17/0x20
[   64.229107] Code: ff ff ff 90 90 90 90 90 90 90 90 90 90 90 90 90 90
90 90 f3 0f 1e fa 8b 05 0e f9 e7 00 85 c0 7e 07 0f 00 2d 5b 7c 2c 00 fb
f4 <fa> c3 cc cc cc c0
[   64.229118] RSP: 0018:ffffffff8d203e38 EFLAGS: 00000246
[   64.229130] RAX: 0000000000000000 RBX: 0000000000000000 RCX:
0000000000000000
[   64.229135] RDX: 0000000000000001 RSI: ffffffff8cf9b570 RDI:
0000000000006554
[   64.229141] RBP: ffffffff8d203e40 R08: ffff9ea94f81f420 R09:
0000000000000001
[   64.229147] R10: ffff9ea941226e80 R11: 00000000000000b2 R12:
ffffffff8d20a940
[   64.229153] R13: 0000000000000000 R14: 0000000000000000 R15:
ffffffff8d20a940
[   64.229169]  ? arch_cpu_idle+0xd/0x20
[   64.229182]  default_idle_call+0x36/0xf0
[   64.229194]  do_idle+0x1f1/0x230
[   64.229208]  cpu_startup_entry+0x21/0x30
[   64.229220]  rest_init+0xc5/0xd0
[   64.229233]  arch_call_rest_init+0x12/0x50
[   64.229246]  start_kernel+0x426/0x680
[   64.229262]  x86_64_start_reservations+0x1c/0x30
[   64.229276]  x86_64_start_kernel+0xce/0xe0
[   64.229290]  secondary_startup_64_no_verify+0x179/0x17b
[   64.229338]  </TASK>
[   64.232465] net_dev_queue: { len:1428, name:eth1,
network_header_type: IPV4, protocol: icmp,
saddr:[192.168.122.1], daddr:[192.168.123.240] }
--------------------------------------------------------------------
Refer to source codes, IPSTATS_MIB_OUTOCTETS is counted in both
ip_forward_finish() and ip_output().
commit edf391ff1723 ("snmp: add missing counters for RFC 4293") had
already added OutOctets for RFC 4293. In commit 2d8dbb04c63e ("snmp: fix
OutOctets counter to include forwarded datagrams"), OutOctets was
counted again, but not removed from ip_output().
And according to RFC 4293 "3.2.3. IP Statistics Tables",
ipIfStatsOutTransmits is not same to ipIfStatsOutForwDatagrams. So
"IPSTATS_MIB_OUTOCTETS must be incremented when incrementing
IPSTATS_MIB_OUTFORWDATAGRAMS" is not accurate. And IPSTATS_MIB_OUTOCTETS
should aslo be counted after fragment by RFC 4293.

Patch:
So do patch to revert this comment and to move IPSTATS_MIB_OUTOCTETS to
ip_finish_output2 for ipv4. Test result is:
----------------------------------------------------------------------
root@qemux86-64:~# cat /proc/net/netstat
TcpExt: SyncookiesSent SyncookiesRecv SyncookiesFailed          ......
TcpExt: 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 ......
IpExt: InNoRoutes InTruncatedPkts InMcastPkts OutMcastPkts InBcastPkts
OutBcastPkts InOctets OutOctets					......
IpExt: 0 0 0 0 1 0 1500 516 0 0 328 0 0 7 0 0 0 0
root@qemux86-64:~# 
root@qemux86-64:~# 
root@qemux86-64:~# cat /proc/net/netstat
TcpExt: SyncookiesSent SyncookiesRecv SyncookiesFailed          ......
TcpExt: 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 ......
IpExt: InNoRoutes InTruncatedPkts InMcastPkts OutMcastPkts InBcastPkts
OutBcastPkts InOctets OutOctets                                 ......
IpExt: 0 0 0 0 1 0 2928 1944 0 0 328 0 0 8 0 0 0 0
root@qemux86-64:~# dmesg
----------------------------------------------------------------------
OutOctets increment is only 1428(1944-516).


Thanks,
Heng


Heng Guo (1):
  net: ipv4, ipv6: fix IPSTATS_MIB_OUTOCTETS increment duplicated

 net/ipv4/ip_forward.c | 1 -
 net/ipv4/ip_output.c  | 7 +++----
 net/ipv4/ipmr.c       | 1 -
 net/ipv6/ip6_output.c | 1 -
 net/ipv6/ip6mr.c      | 2 --
 5 files changed, 3 insertions(+), 9 deletions(-)

-- 
2.35.5


