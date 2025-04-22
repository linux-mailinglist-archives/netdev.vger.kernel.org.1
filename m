Return-Path: <netdev+bounces-184615-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E7F7CA9666B
	for <lists+netdev@lfdr.de>; Tue, 22 Apr 2025 12:49:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C84E91897180
	for <lists+netdev@lfdr.de>; Tue, 22 Apr 2025 10:49:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B7971EE00F;
	Tue, 22 Apr 2025 10:49:13 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ED1F2AF1E
	for <netdev@vger.kernel.org>; Tue, 22 Apr 2025 10:49:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745318953; cv=none; b=C1Y7JupCJW8A2QGg1Y2hpxvr4KzkQiR7wENFLJ5/0WOrG8T8OaSFbMefQSWmUoilpml017wliTJTQKB97i9fU8cXjtObvpBOETYq4pOr8Dr2mv4RpgzQXRWoaZF7fEqoGUwCPfQaWJNettIJ2ZPLwhQkUSUHt3t3dQOlgNMOHYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745318953; c=relaxed/simple;
	bh=EKJ6heuH+3wRcZhHP7Vo+0JRN1b6xq2ASPCtSPxsxRw=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=nro0H+GZDDp7OF6sRCsz0QKJ9BYjMZRcfzLz9+EcOvCq3Q6ZgETNrfydat7oe8f4rKN9PXjxUxL3z7eUbmCCdzs/1feQsgyYuiOvfr1NhrmobYpDb9Kx0aBdTDfpnNxJzvnluzpTOlFbQcfMdUAsqz0ybRoirEi3GsjsaAyEUGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mails.ucas.ac.cn; spf=pass smtp.mailfrom=mails.ucas.ac.cn; arc=none smtp.client-ip=159.226.251.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mails.ucas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mails.ucas.ac.cn
Received: from [10.31.1.120] (unknown [210.76.195.148])
	by APP-01 (Coremail) with SMTP id qwCowAC3Xv8MdAdokdARCw--.16732S2;
	Tue, 22 Apr 2025 18:48:45 +0800 (CST)
Message-ID: <af01ddc5-82bc-4376-9874-e465bf5424f7@mails.ucas.ac.cn>
Date: Tue, 22 Apr 2025 18:48:44 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Content-Language: en-US
To: Tariq Toukan <tariqt@nvidia.com>, Saeed Mahameed <saeedm@nvidia.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Eric Dumazet <edumazet@google.com>,
 "David S. Miller" <davem@davemloft.net>
Cc: netdev@vger.kernel.org
From: Qiyu Yan <yanqiyu17@mails.ucas.ac.cn>
Subject: DNAT'ed traffic from ConnectX-4 card triggers "hw csum failure" on
 veth interface
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qwCowAC3Xv8MdAdokdARCw--.16732S2
X-Coremail-Antispam: 1UD129KBjvJXoWxZr13Cr4rAw17ZFWrGFWxJFb_yoWrtr4kpr
	18tw1UGrW8Jr18Jr4UJr1UJFW5JrsrA3WUJr4xJF1UAFyUGw1jqrykXFWjg3Z8Gr48Zr12
	qF1UJw1Ivr1DJaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9K14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
	6r4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAac4AC62xK8xCEY4vEwIxC4wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC
	0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr
	1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIF
	xwCY1x0262kKe7AKxVWUtVW8ZwCY1x0264kExVAvwVAq07x20xyl42xK82IYc2Ij64vIr4
	1l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK
	67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI
	8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAv
	wI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14
	v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfU1CJPDUUUU
X-CM-SenderInfo: 51dq1xl1xrlqxpdlz24oxft2wodfhubq/1tbiBg0AB2gHZCU0ZAAAsy

Hi all,

Apologies for the broad CC—I'm unsure which component is related to the 
issue, but I've gathered more details since my last report.

After boot or after resetting the WARN_ONCE flag, I consistently observe 
the following in `dmesg`:

eth0: hw csum failure
skb len=52 headroom=98 headlen=52 tailroom=1578
mac=(64,14) mac_len=14 net=(78,20) trans=98
shinfo(txflags=0 nr_frags=0 gso(size=0 type=0 segs=0))
csum(0x98009d14 start=40212 offset=38912 ip_summed=2 complete_sw=0 
valid=0 level=0)
hash(0x2135374 sw=0 l4=1) proto=0x0800 pkttype=0 iif=2
priority=0x0 mark=0x0 alloc_cpu=20 vlan_all=0x0
encapsulation=0 inner(proto=0x0000, mac=0, net=0, trans=0)
dev name=eth0 feat=0x000061164fdd09e9
skb headroom: 00000000: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
skb headroom: 00000010: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
skb headroom: 00000020: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
skb headroom: 00000030: ba d7 32 44 dd 39 7e b7 bb bd 2e d5 88 e5 2d 00
skb headroom: 00000040: 9e 52 9b 58 46 89 aa 93 51 02 83 7e 08 00 45 00
skb headroom: 00000050: 00 48 d3 6d 00 00 3f 11 93 48 0a 00 00 7a 0a 58
skb headroom: 00000060: 00 1e
skb linear:   00000000: e2 e4 00 35 00 34 92 e9 f4 39 01 00 00 01 00 00
skb linear:   00000010: 00 00 00 00 06 72 65 70 6f 72 74 07 6d 65 65 74
skb linear:   00000020: 69 6e 67 07 74 65 6e 63 65 6e 74 03 63 6f 6d 00
skb linear:   00000030: 00 01 00 01
... large tailroom
CPU: 20 UID: 0 PID: 0 Comm: swapper/20 Tainted: G OE      
6.14.2-300.fc42.x86_64 #1
Tainted: [O]=OOT_MODULE, [E]=UNSIGNED_MODULE
Hardware name: To Be Filled By O.E.M. To Be Filled By O.E.M./EPYCD8, 
BIOS L2.52 11/25/2020
Call Trace:
  <IRQ>
  dump_stack_lvl+0x5d/0x80
  __skb_checksum_complete+0xeb/0x110
  ? __pfx_csum_partial_ext+0x10/0x10
  ? __pfx_csum_block_add_ext+0x10/0x10
  udp4_csum_init+0x1dc/0x2f0
  __udp4_lib_rcv+0xc8/0x750
  ? srso_return_thunk+0x5/0x5f
  ? raw_v4_input+0x14a/0x270
  ip_protocol_deliver_rcu+0xcb/0x1a0
  ip_local_deliver_finish+0x76/0xa0
  ip_local_deliver+0xfa/0x110
  __netif_receive_skb_one_core+0x87/0xa0
  process_backlog+0x87/0x130
  __napi_poll+0x31/0x1b0
  ? srso_return_thunk+0x5/0x5f
  net_rx_action+0x333/0x420
  handle_softirqs+0xf2/0x340
  ? srso_return_thunk+0x5/0x5f
  ? srso_return_thunk+0x5/0x5f
  __irq_exit_rcu+0xcb/0xf0
  common_interrupt+0x85/0xa0
  </IRQ>
  <TASK>
  asm_common_interrupt+0x26/0x40
RIP: 0010:cpuidle_enter_state+0xcc/0x660
Code: 00 00 e8 67 28 fb fe e8 d2 ed ff ff 49 89 c4 0f 1f 44 00 00 31 ff 
e8 73 61 f9 fe 45 84 ff 0f 85 02 02 00 00 fb 0f 1f 44 00 00 <85> ed 0f 
88 d3 01 00 00 4c 63 f5 49 83 fe 0a 0f 83 9f 04 00 00 49
RSP: 0018:ffffa79d003afe50 EFLAGS: 00000246
RAX: ffff96440ca00000 RBX: ffff962542b89800 RCX: 0000000000000000
RDX: 000051a9557f7bf1 RSI: 000000003152c088 RDI: 0000000000000000
RBP: 0000000000000002 R08: ffffffee4d207359 R09: ffff96440ca315e0
R10: 000051bb10ea059b R11: 0000000000000000 R12: 000051a9557f7bf1
R13: ffffffffa7b15160 R14: 0000000000000002 R15: 0000000000000000

 From inspecting the SKB, the packet comes from a host (10.0.0.122) 
connected via a ConnectX-4 Lx NIC to our server. It is DNAT'ed via 
iptables from 10.0.0.1:53 to a container at 10.88.0.30:53.

Traffic path:

     10.0.0.122 --> [CX4 NIC 10.0.0.1/16]
                       |
               iptables DNAT (10.0.0.1:53 -> 10.88.0.30:53)
                       |
                 [linux bridge (podman0 10.88.0.1/16)]
                       |
                   [veth pair]
                       |
                 [eth0 inside container]

The warning is triggered when the packet arrives at eth0 inside the 
container.

What's suspicious is the reported checksum info:

     csum(0x9800a314 start=41748 offset=38912 ip_summed=2 ...)

Here, start and offset are far beyond the size of the skb. This seems 
like an invalid buffer? And I suspect that during DNAT and/or forwarding 
through the bridge and veth, the checksum status is not properly cleared 
or recalculated.

The NIC is:
$ ethtool -i mlx-p1
driver: mlx5_core
version: 6.14.2-300.fc42.x86_64
firmware-version: 14.32.1900 (MT_2420110034)
expansion-rom-version:
bus-info: 0000:c1:00.1
supports-statistics: yes
supports-test: yes
supports-eeprom-access: no
supports-register-dump: no
supports-priv-flags: yes


Best,
Qiyu


