Return-Path: <netdev+bounces-32552-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3884C798573
	for <lists+netdev@lfdr.de>; Fri,  8 Sep 2023 12:07:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 490F91C20C0D
	for <lists+netdev@lfdr.de>; Fri,  8 Sep 2023 10:07:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 451924428;
	Fri,  8 Sep 2023 10:07:04 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A8792108
	for <netdev@vger.kernel.org>; Fri,  8 Sep 2023 10:07:03 +0000 (UTC)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BEF62100
	for <netdev@vger.kernel.org>; Fri,  8 Sep 2023 03:06:30 -0700 (PDT)
Received: from canpemm100003.china.huawei.com (unknown [172.30.72.55])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4RhsBq2zYZzrSdw;
	Fri,  8 Sep 2023 18:03:47 +0800 (CST)
Received: from canpemm500004.china.huawei.com (7.192.104.92) by
 canpemm100003.china.huawei.com (7.192.104.85) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Fri, 8 Sep 2023 18:05:38 +0800
Received: from dggpeml500021.china.huawei.com (7.185.36.21) by
 canpemm500004.china.huawei.com (7.192.104.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Fri, 8 Sep 2023 18:05:37 +0800
Received: from dggpeml500021.china.huawei.com ([7.185.36.21]) by
 dggpeml500021.china.huawei.com ([7.185.36.21]) with mapi id 15.01.2507.031;
 Fri, 8 Sep 2023 18:05:37 +0800
From: hanhuihui <hanhuihui5@huawei.com>
To: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "davem@davemloft.net"
	<davem@davemloft.net>, "dsahern@kernel.org" <dsahern@kernel.org>,
	"pablo@netfilter.org" <pablo@netfilter.org>
CC: "Yanan (Euler)" <yanan@huawei.com>, Caowangbao <caowangbao@huawei.com>,
	"Fengtao (fengtao, Euler)" <fengtao40@huawei.com>, liaichun
	<liaichun@huawei.com>
Subject: The call trace occurs during the VRF fault injection test
Thread-Topic: The call trace occurs during the VRF fault injection test
Thread-Index: AdniPABCa2t1jvkaQw2cmCxCquZMyg==
Date: Fri, 8 Sep 2023 10:05:37 +0000
Message-ID: <1c353f53578e48faa9b254394b42b391@huawei.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-originating-ip: [10.136.114.92]
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
	RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hello, I found a problem in the VRF fault injection test scenario. When the=
 size of the sent data packet exceeds the MTU, the call trace is triggered.=
 The test script and detailed error information are as follows:
"ip link add name vrf-blue type vrf table 10
ip link set dev vrf-blue up
ip route add table 10 unreachable default
ip link set dev enp4s0 master vrf-blue
ip address add 192.168.255.250/16 dev enp4s0
tc qdisc add dev enp4s0 root netem delay 1000ms 500ms
tc qdisc add dev vrf-blue root netem delay 1000ms 500ms
ip vrf exec vrf-blue ping "192.168.162.184" -s 6000 -I "enp4s0" -c 3
tc qdisc del dev "enp4s0" root
tc qdisc del dev vrf-blue root
ip address del 192.168.255.250/16 dev enp4s0
ip link set dev enp4s0 nomaster"


"[=A0 284.613866] refcount_t: underflow; use-after-free.
[=A0 284.613906] WARNING: CPU: 0 PID: 0 at lib/refcount.c:28 refcount_warn_=
saturate+0xd1/0x120
[=A0 284.613920] Modules linked in: sch_netem vrf nft_fib_inet nft_fib_ipv4=
 nft_fib_ipv6 nft_fib nft_reject_inet nf_reject_ipv4 nf_reject_ipv6 nft_rej=
ect nft_ct nft_chain_nat nf_tables ebtable_nat ebtable_broute ip6table_nat =
ip6table_mangle ip6table_raw ip6table_security iptable_nat nf_nat nf_conntr=
ack nf_defrag_ipv6 nf_defrag_ipv4 libcrc32c iptable_mangle iptable_raw ipta=
ble_security rfkill ip_set nfnetlink ebtable_filter ebtables ip6table_filte=
r ip6_tables iptable_filter ip_tables sunrpc intel_rapl_msr intel_rapl_comm=
on isst_if_mbox_msr isst_if_common nfit libnvdimm rapl ipmi_ssif cirrus sg =
drm_shmem_helper acpi_ipmi joydev ipmi_si ipmi_devintf drm_kms_helper i2c_p=
iix4 virtio_balloon pcspkr ipmi_msghandler drm fuse ext4 mbcache jbd2 sd_mo=
d crct10dif_pclmul t10_pi crc32_pclmul crc64_rocksoft_generic crc32c_intel =
ata_generic crc64_rocksoft crc64 virtio_net ata_piix ghash_clmulni_intel ne=
t_failover virtio_console failover sha512_ssse3 libata serio_raw virtio_scs=
i dm_mirror dm_region_hash dm_log dm_mod
[=A0 284.614124] CPU: 0 PID: 0 Comm: swapper/0 Kdump: loaded Not tainted 6.=
5.0+ #2
[=A0 284.614130] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIO=
S rel-1.12.1-0-ga5cab58-20220525_182517-szxrtosci10000 04/01/2014
[=A0 284.614134] RIP: 0010:refcount_warn_saturate+0xd1/0x120
[=A0 284.614140] Code: 79 e5 07 02 01 e8 8f 86 7c ff 0f 0b eb 95 80 3d 66 e=
5 07 02 00 75 8c 48 c7 c7 80 a0 a7 97 c6 05 56 e5 07 02 01 e8 6f 86 7c ff <=
0f> 0b e9 72 ff ff ff 80 3d 41 e5 07 02 00 0f 85 65 ff ff ff 48 c7
[=A0 284.614145] RSP: 0018:ffff888117609320 EFLAGS: 00010286
[=A0 284.614155] RAX: 0000000000000000 RBX: 0000000000000003 RCX: 000000000=
000083f
[=A0 284.614159] RDX: 0000000000000000 RSI: 00000000000000f6 RDI: 000000000=
000003f
[=A0 284.614162] RBP: ffff88811004d6d4 R08: 0000000000000001 R09: ffffed102=
2ec1229
[=A0 284.614165] R10: ffff88811760914f R11: 0000000000000001 R12: 000000000=
0000900
[=A0 284.614168] R13: ffff88811004d6d4 R14: ffff88811004d5e0 R15: ffff88811=
004d830
[=A0 284.614174] FS:=A0 0000000000000000(0000) GS:ffff888117600000(0000) kn=
lGS:0000000000000000
[=A0 284.614178] CS:=A0 0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[=A0 284.614182] CR2: 000055def0aa7460 CR3: 0000000102536001 CR4: 000000000=
0370ef0
[=A0 284.614186] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 000000000=
0000000
[=A0 284.614189] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 000000000=
0000400
[=A0 284.614192] Call Trace:
[=A0 284.614195]=A0 <IRQ>
[=A0 284.614198]=A0 ? __warn+0xa5/0x1b0
[=A0 284.614207]=A0 ? refcount_warn_saturate+0xd1/0x120
[=A0 284.614216]=A0 ? __report_bug+0x123/0x130
[=A0 284.614225]=A0 ? refcount_warn_saturate+0xd1/0x120
[=A0 284.614229]=A0 ? report_bug+0x43/0xa0
[=A0 284.614234]=A0 ? handle_bug+0x3c/0x70
[=A0 284.614241]=A0 ? exc_invalid_op+0x18/0x50
[=A0 284.614246]=A0 ? asm_exc_invalid_op+0x1a/0x20
[=A0 284.614257]=A0 ? refcount_warn_saturate+0xd1/0x120
[=A0 284.614262]=A0 sock_wfree+0x303/0x310
[=A0 284.614269]=A0 ? __pfx_sock_wfree+0x10/0x10
[=A0 284.614273]=A0 skb_orphan_partial+0x1f3/0x250
[=A0 284.614282]=A0 ? __pfx_skb_orphan_partial+0x10/0x10
[=A0 284.614288]=A0 ? dequeue_skb+0xe0/0x700
[=A0 284.614299]=A0 netem_enqueue+0xda/0x1160 [sch_netem]
[=A0 284.614310]=A0 ? __pfx___qdisc_run+0x10/0x10
[=A0 284.614315]=A0 ? _raw_spin_lock+0x85/0xe0
[=A0 284.614325]=A0 dev_qdisc_enqueue+0x30/0xe0
[=A0 284.614333]=A0 __dev_xmit_skb+0x410/0x8a0
[=A0 284.614338]=A0 ? __pfx___dev_xmit_skb+0x10/0x10
[=A0 284.614343]=A0 ? arp_process+0x4e9/0xd50
[=A0 284.614352]=A0 __dev_queue_xmit+0x620/0xde0
[=A0 284.614359]=A0 ? enqueue_timer+0xab/0x190
[=A0 284.614368]=A0 ? __pfx___dev_queue_xmit+0x10/0x10
[=A0 284.614373]=A0 ? _raw_spin_unlock_irqrestore+0xe/0x30
[=A0 284.614379]=A0 ? __mod_timer+0x42b/0x630
[=A0 284.614384]=A0 ? _raw_write_lock_bh+0x89/0xe0
[=A0 284.614389]=A0 ? __rcu_read_unlock+0x33/0x70
[=A0 284.614397]=A0 ? skb_push+0x4d/0x90
[=A0 284.614404]=A0 ? eth_header+0x81/0xf0
[=A0 284.614409]=A0 ? __pfx_eth_header+0x10/0x10
[=A0 284.614413]=A0 ? neigh_resolve_output.part.0+0x1b9/0x2a0
[=A0 284.614421]=A0 __neigh_update+0x2ef/0xf10
[=A0 284.614429]=A0 arp_process+0x4af/0xd50
[=A0 284.614435]=A0 ? __pfx_arp_process+0x10/0x10
[=A0 284.614440]=A0 ? __netif_receive_skb_core+0x3ef/0x1990
[=A0 284.614446]=A0 ? __pfx___alloc_pages+0x10/0x10
[=A0 284.614455]=A0 arp_rcv.part.0+0x1e6/0x2d0
[=A0 284.614460]=A0 ? __pfx_arp_rcv.part.0+0x10/0x10
[=A0 284.614466]=A0 ? __build_skb_around+0x129/0x190
[=A0 284.614472]=A0 ? __napi_build_skb+0x3a/0x50
[=A0 284.614477]=A0 ? __napi_alloc_skb+0xe3/0x390
[=A0 284.614482]=A0 ? __pfx___napi_alloc_skb+0x10/0x10
[=A0 284.614488]=A0 ? __pfx_arp_rcv+0x10/0x10
[=A0 284.614493]=A0 __netif_receive_skb_list_core+0x489/0x500
[=A0 284.614499]=A0 ? __pfx___netif_receive_skb_list_core+0x10/0x10
[=A0 284.614506]=A0 ? receive_mergeable+0x482/0x920 [virtio_net]
[=A0 284.614522]=A0 __netif_receive_skb_list+0x1cc/0x2d0
[=A0 284.614528]=A0 ? virtio_net_hdr_to_skb.constprop.0+0x2ec/0x720 [virtio=
_net]
[=A0 284.614541]=A0 ? __pfx___netif_receive_skb_list+0x10/0x10
[=A0 284.614547]=A0 ? __rcu_read_unlock+0x4c/0x70
[=A0 284.614552]=A0 ? dev_gro_receive+0xe1/0x780
[=A0 284.614557]=A0 ? kvm_clock_get_cycles+0x18/0x30
[=A0 284.614564]=A0 netif_receive_skb_list_internal+0x234/0x380
[=A0 284.614570]=A0 ? napi_gro_receive+0x159/0x3a0
[=A0 284.614574]=A0 ? __pfx_netif_receive_skb_list_internal+0x10/0x10
[=A0 284.614580]=A0 ? virtqueue_get_vring_size+0x1f/0x30
[=A0 284.614588]=A0 ? virtnet_receive+0x218/0x3d0 [virtio_net]
[=A0 284.614602]=A0 ? __pfx_virtnet_receive+0x10/0x10 [virtio_net]
[=A0 284.614616]=A0 napi_complete_done+0x128/0x390
[=A0 284.614621]=A0 ? __pfx_napi_complete_done+0x10/0x10
[=A0 284.614627]=A0 ? virtqueue_enable_cb_delayed+0x252/0x340
[=A0 284.614633]=A0 ? netif_tx_wake_queue+0x1e/0x50
[=A0 284.614640]=A0 virtnet_poll+0x1e3/0x340 [virtio_net]
[=A0 284.614653]=A0 ? scheduler_tick+0x1ac/0x3c0
[=A0 284.614662]=A0 ? __pfx_virtnet_poll+0x10/0x10 [virtio_net]
[=A0 284.614676]=A0 ? timerqueue_add+0x128/0x150
[=A0 284.614683]=A0 __napi_poll+0x59/0x2c0
[=A0 284.614689]=A0 net_rx_action+0x55a/0x6a0
[=A0 284.614694]=A0 ? __pfx_net_rx_action+0x10/0x10
[=A0 284.614698]=A0 ? _raw_write_lock_irq+0xe0/0xe0
[=A0 284.614704]=A0 ? kvm_sched_clock_read+0x11/0x20
[=A0 284.614712]=A0 __do_softirq+0xf5/0x38d
[=A0 284.614718]=A0 __irq_exit_rcu+0xdd/0x100
[=A0 284.614725]=A0 common_interrupt+0x81/0xa0
[=A0 284.614738]=A0 </IRQ>
[=A0 284.614742]=A0 <TASK>
[=A0 284.614745]=A0 asm_common_interrupt+0x26/0x40
[=A0 284.614751] RIP: 0010:default_idle+0xf/0x20
[=A0 284.614757] Code: 4c 01 c7 4c 29 c2 e9 72 ff ff ff 90 90 90 90 90 90 9=
0 90 90 90 90 90 90 90 90 90 f3 0f 1e fa 66 90 0f 00 2d c3 73 2c 00 fb f4 <=
fa> c3 cc cc cc cc 66 66 2e 0f 1f 84 00 00 00 00 00 90 90 90 90 90
[=A0 284.614761] RSP: 0018:ffffffff98207e38 EFLAGS: 00000256
[=A0 284.614766] RAX: 0000000000000000 RBX: 1ffffffff3040fc9 RCX: ffffffff9=
7554543
[=A0 284.614770] RDX: ffffed1022ec7cb6 RSI: 0000000000000004 RDI: 000000000=
016e17c
[=A0 284.614773] RBP: 0000000000000000 R08: 0000000000000001 R09: ffffed102=
2ec7cb5
[=A0 284.614776] R10: ffff88811763e5ab R11: 0000000000000000 R12: 000000000=
0000000
[=A0 284.614782] R13: ffffffff982129c0 R14: 0000000000000000 R15: 000000000=
0093ff0
[=A0 284.614787]=A0 ? ct_kernel_exit.constprop.0+0x93/0xd0
[=A0 284.614792]=A0 default_idle_call+0x34/0x50
[=A0 284.614797]=A0 cpuidle_idle_call+0x199/0x1e0
[=A0 284.614805]=A0 ? __pfx_cpuidle_idle_call+0x10/0x10
[=A0 284.614810]=A0 ? kvm_sched_clock_read+0x11/0x20
[=A0 284.614815]=A0 ? sched_clock+0x10/0x30
[=A0 284.614823]=A0 ? sched_clock_cpu+0x15/0x130
[=A0 284.614831]=A0 ? tsc_verify_tsc_adjust+0x7a/0x160
[=A0 284.614837]=A0 ? rcu_nocb_flush_deferred_wakeup+0x2c/0xc0
[=A0 284.614842]=A0 do_idle+0xa7/0x120
[=A0 284.614848]=A0 cpu_startup_entry+0x1d/0x20
[=A0 284.614853]=A0 rest_init+0xf0/0xf0
[=A0 284.614858]=A0 arch_call_rest_init+0x13/0x40
[=A0 284.614866]=A0 start_kernel+0x311/0x3d0
[=A0 284.614871]=A0 x86_64_start_reservations+0x18/0x30
[=A0 284.614877]=A0 x86_64_start_kernel+0x97/0xa0
[=A0 284.614881]=A0 secondary_startup_64_no_verify+0x17d/0x18b
[=A0 284.614891]=A0 </TASK>
[=A0 284.614894] ---[ end trace 0000000000000000 ]---
[=A0 285.594335] ------------[ cut here ]------------
[=A0 285.594345] refcount_t: saturated; leaking memory.
[=A0 285.594396] WARNING: CPU: 3 PID: 8254 at lib/refcount.c:22 refcount_wa=
rn_saturate+0x71/0x120
[ =A0285.594414] Modules linked in: sch_netem vrf nft_fib_inet nft_fib_ipv4=
 nft_fib_ipv6 nft_fib nft_reject_inet nf_reject_ipv4 nf_reject_ipv6 nft_rej=
ect nft_ct nft_chain_nat nf_tables ebtable_nat ebtable_broute ip6table_nat =
ip6table_mangle ip6table_raw ip6table_security iptable_nat nf_nat nf_conntr=
ack nf_defrag_ipv6 nf_defrag_ipv4 libcrc32c iptable_mangle iptable_raw ipta=
ble_security rfkill ip_set nfnetlink ebtable_filter ebtables ip6table_filte=
r ip6_tables iptable_filter ip_tables sunrpc intel_rapl_msr intel_rapl_comm=
on isst_if_mbox_msr isst_if_common nfit libnvdimm rapl ipmi_ssif cirrus sg =
drm_shmem_helper acpi_ipmi joydev ipmi_si ipmi_devintf drm_kms_helper i2c_p=
iix4 virtio_balloon pcspkr ipmi_msghandler drm fuse ext4 mbcache jbd2 sd_mo=
d crct10dif_pclmul t10_pi crc32_pclmul crc64_rocksoft_generic crc32c_intel =
ata_generic crc64_rocksoft crc64 virtio_net ata_piix ghash_clmulni_intel ne=
t_failover virtio_console failover sha512_ssse3 libata serio_raw virtio_scs=
i dm_mirror dm_region_hash dm_log dm_mod
[=A0 285.594655] CPU: 3 PID: 8254 Comm: ping Kdump: loaded Tainted: G=A0=A0=
=A0=A0=A0=A0=A0 W=A0=A0=A0=A0=A0=A0=A0=A0=A0 6.5.0+ #2
[=A0 285.594663] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIO=
S rel-1.12.1-0-ga5cab58-20220525_182517-szxrtosci10000 04/01/2014
[=A0 285.594668] RIP: 0010:refcount_warn_saturate+0x71/0x120
[=A0 285.594677] Code: 00 00 00 5b 5d c3 cc cc cc cc 85 db 74 40 80 3d c8 e=
5 07 02 00 75 ec 48 c7 c7 80 9f a7 97 c6 05 b8 e5 07 02 01 e8 cf 86 7c ff <=
0f> 0b eb d5 80 3d a7 e5 07 02 00 75 cc 48 c7 c7 20 a0 a7 97 c6 05
[=A0 285.594684] RSP: 0018:ffff88810b27f890 EFLAGS: 00010286
[=A0 285.594692] RAX: 0000000000000000 RBX: 0000000000000001 RCX: 000000000=
0000027
[=A0 285.594697] RDX: 0000000000000027 RSI: 0000000000000004 RDI: ffff88811=
77b0648
[=A0 285.594701] RBP: ffff88811004d6d4 R08: ffffffff965d071e R09: ffffed102=
2ef60c9
[=A0 285.594706] R10: ffff8881177b064b R11: 0000000000000001 R12: 000000000=
000060b
[=A0 285.594711] R13: ffff888109e3b000 R14: 0000000000000000 R15: 000000000=
0001778
[=A0 285.594719] FS:=A0 00007fbdee966b80(0000) GS:ffff888117780000(0000) kn=
lGS:0000000000000000
[=A0 285.594724] CS:=A0 0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[=A0 285.594729] CR2: 0000560c2756aca0 CR3: 0000000102768002 CR4: 000000000=
0370ee0
[=A0 285.594743] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 000000000=
0000000
[=A0 285.594747] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 000000000=
0000400
[=A0 285.594751] Call Trace:
[=A0 285.594755]=A0 <TASK>
[=A0 285.594760]=A0 ? __warn+0xa5/0x1b0
[=A0 285.594773]=A0 ? refcount_warn_saturate+0x71/0x120
[=A0 285.594780]=A0 ? __report_bug+0x123/0x130
[=A0 285.594793]=A0 ? refcount_warn_saturate+0x71/0x120
[=A0 285.594800]=A0 ? report_bug+0x43/0xa0
[=A0 285.594809]=A0 ? handle_bug+0x3c/0x70
[=A0 285.594818]=A0 ? exc_invalid_op+0x18/0x50
[=A0 285.594825]=A0 ? asm_exc_invalid_op+0x1a/0x20
[=A0 285.594839]=A0 ? irq_work_claim+0x1e/0x40
[=A0 285.594849]=A0 ? refcount_warn_saturate+0x71/0x120
[=A0 285.594856]=A0 __ip_append_data+0x138c/0x1bc0
[=A0 285.594871]=A0 ? __pfx_raw_getfrag+0x10/0x10
[=A0 285.594881]=A0 ? find_exception+0x20/0x190
[=A0 285.594900]=A0 ? __pfx___ip_append_data+0x10/0x10
[=A0 285.594909]=A0 ? __rcu_read_unlock+0x4c/0x70
[=A0 285.594921]=A0 ? ipv4_mtu+0xf8/0x170
[=A0 285.594928]=A0 ? __pfx_raw_getfrag+0x10/0x10
[=A0 285.594937]=A0 ip_append_data+0x9b/0xf0
[=A0 285.594948]=A0 raw_sendmsg+0x5ff/0xb90
[=A0 285.594959]=A0 ? __pfx_raw_sendmsg+0x10/0x10
[=A0 285.594968]=A0 ? __pfx_avc_has_perm+0x10/0x10
[=A0 285.594978]=A0 ? ____sys_recvmsg+0x138/0x330
[=A0 285.594990]=A0 ? __pfx_selinux_socket_sendmsg+0x10/0x10
[=A0 285.595002]=A0 ? ____sys_sendmsg+0x28/0x530
[=A0 285.595010]=A0 ? __pfx_copy_msghdr_from_user+0x10/0x10
[=A0 285.595019]=A0 ? __mod_lruvec_page_state+0x107/0x1f0
[=A0 285.595031]=A0 ? inet_send_prepare+0x1f/0x110
[=A0 285.595042]=A0 ? __pfx_inet_sendmsg+0x10/0x10
[=A0 285.595117]=A0 sock_sendmsg+0xfe/0x140
[=A0 285.595126]=A0 __sys_sendto+0x194/0x240
[=A0 285.595136]=A0 ? __pfx___sys_sendto+0x10/0x10
[=A0 285.595145]=A0 ? __handle_mm_fault+0x4cc/0x8c0
[=A0 285.595210]=A0 ? __sys_recvmsg+0xc9/0x150
[=A0 285.595217]=A0 ? __pfx___sys_recvmsg+0x10/0x10
[=A0 285.595224]=A0 ? __rcu_read_unlock+0x4c/0x70
[=A0 285.595232]=A0 ? mm_account_fault+0xcc/0x120
[=A0 285.595242]=A0 ? __pfx_restore_fpregs_from_fpstate+0x10/0x10
[=A0 285.595319]=A0 ? __audit_syscall_entry+0x17c/0x200
[=A0 285.595333]=A0 __x64_sys_sendto+0x78/0x90
[=A0 285.595344]=A0 do_syscall_64+0x3c/0x90
[=A0 285.595351]=A0 entry_SYSCALL_64_after_hwframe+0x6e/0xd8
[=A0 285.595360] RIP: 0033:0x7fbdee70f16a
[=A0 285.595367] Code: d8 64 89 02 48 c7 c0 ff ff ff ff eb b8 0f 1f 00 f3 0=
f 1e fa 41 89 ca 64 8b 04 25 18 00 00 00 85 c0 75 15 b8 2c 00 00 00 0f 05 <=
48> 3d 00 f0 ff ff 77 7e c3 0f 1f 44 00 00 41 54 48 83 ec 30 44 89
[=A0 285.595374] RSP: 002b:00007ffde0514458 EFLAGS: 00000246 ORIG_RAX: 0000=
00000000002c
[=A0 285.595381] RAX: ffffffffffffffda RBX: 000055aafaadf060 RCX: 00007fbde=
e70f16a
[=A0 285.595387] RDX: 0000000000001778 RSI: 000055aafbe2a4d0 RDI: 000000000=
0000003
[=A0 285.595391] RBP: 000055aafbe2a4d0 R08: 000055aafaae12e0 R09: 000000000=
0000010
[=A0 285.595396] R10: 0000000000000000 R11: 0000000000000246 R12: 000000000=
0001778
[=A0 285.595400] R13: 00007ffde0515b50 R14: 00007ffde0514460 R15: 0000001d0=
0000001
[=A0 285.595409]=A0 </TASK>
[=A0 285.595413] ---[ end trace 0000000000000000 ]---"


