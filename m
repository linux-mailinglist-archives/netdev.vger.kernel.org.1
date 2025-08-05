Return-Path: <netdev+bounces-211688-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BF3F6B1B32E
	for <lists+netdev@lfdr.de>; Tue,  5 Aug 2025 14:16:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CB4E81809CB
	for <lists+netdev@lfdr.de>; Tue,  5 Aug 2025 12:16:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB8A823D2B4;
	Tue,  5 Aug 2025 12:16:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="R7iLrCA6"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C139B23C50A
	for <netdev@vger.kernel.org>; Tue,  5 Aug 2025 12:16:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754396205; cv=none; b=cuWStl2BB7VVu0mwVVMZWJNwGbmNEeLvkKdASx0KPHcQgqWxosaIDZSpkLAEw+kb9oVDUi2Opf8MwTMvwyRA8YmxMo63NHr36A0EoS7thKRYRTaaDovdgtkBxFbxtBPocNKkMaK2VU9lKMa8XMIvjlXPrveXEe+UAxO8d4T+o7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754396205; c=relaxed/simple;
	bh=CmBCmABcCLnjEROKfmOKByGevm1swRuwvHWiVA31uL0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RWaI+j30RqnOBt0sdLNvXrSyLUgSIifS1MjDSVQM04X+BLdZMh5Bimjki/aFhAD+JzUArvMg3IN95Ova7nqMAZgWcVYzdzRsOGsBKzs8YtOJlUIcO0RP3stp4UOcS2Oxldhy7MLbAGuwtGofH9+Aw71+rQaz4I9PG9C6DGq3Jgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=R7iLrCA6; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754396202;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=k44PWZB+SstYXZf2Wo78t/ngrbX6A8TaWIyHMZPnUhA=;
	b=R7iLrCA6l/UwuqyKucc9JmtVvtKFQt4gjlmkyrkufF5rG87opt77v7Wv6UcZqsNbix9V6n
	pF7LD7rLGF/PUE3aeVUp2DRGOctn3afR4cKwwIVpnSoMQ1ThaLdkzrlTVhvEsYfHFCvyRe
	I8OErBQ/D/FaJj04WIV6OY7zkrSVxhY=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-655-6SSmc80lNe6HPJU4U0leBw-1; Tue,
 05 Aug 2025 08:16:39 -0400
X-MC-Unique: 6SSmc80lNe6HPJU4U0leBw-1
X-Mimecast-MFC-AGG-ID: 6SSmc80lNe6HPJU4U0leBw_1754396198
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 855F21955D90;
	Tue,  5 Aug 2025 12:16:38 +0000 (UTC)
Received: from jramaseu-thinkpadt14gen5.tpbc.com (unknown [10.67.32.24])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id B0B391954B08;
	Tue,  5 Aug 2025 12:16:33 +0000 (UTC)
From: Jakub Ramaseuski <jramaseu@redhat.com>
To: netdev@vger.kernel.org
Cc: kuba@kernel.org,
	horms@kernel.org,
	pabeni@redhat.com,
	Jakub Ramaseuski <jramaseu@redhat.com>,
	Tianhao Zhao <tizhao@redhat.com>,
	Michal Schmidt <mschmidt@redhat.com>
Subject: [PATCH net] net: mask NETIF_F_IPV6_CSUM flag on irregular packet header size
Date: Tue,  5 Aug 2025 14:16:27 +0200
Message-ID: <20250805121627.311053-1-jramaseu@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

Throughput with GRE on IPv6 drops to 0 on NICs that use ice/bnxt_en
or any driver with NETIF_F_IP_CSUM and NETIF_F_IPV6_CSUM set and with
NETIF_F_HW_CSUM unset, see following dmesg output for more info.

bnxt_en: caps=(0x009201c01dd14833, 0x0000000e401d4869)
WARNING: CPU: 1 PID: 5273 at net/core/dev.c:3535 skb_warn_bad_offload+0x81/0x140
Modules linked in: ip6_gre gre ip6_tunnel tunnel6 mlx5_ib mlx5_fwctl macsec fwctl rfkill irdma ib_uverbs ib_core amd_atl intel_rapl_msr intel_rapl_common amd64_edac edac_mce_amd kvm_amd ipmi_ssif mlx5_core kvm mlxfw psample acpi_ipmi ice tls ast irqbypass i40e tg3 bnxt_en rapl wmi_bmof i2c_algo_bit pcspkr acpi_cpufreq pci_hyperv_intf ipmi_si i2c_piix4 gnss k10temp i2c_smbus libie ptdma ipmi_devintf ipmi_msghandler joydev sg loop fuse nfnetlink xfs sd_mod ahci libahci libata ghash_clmulni_intel ccp sp5100_tco wmi dm_mirror dm_region_hash dm_log dm_mod
CPU: 1 UID: 0 PID: 5273 Comm: iperf3 Kdump: loaded Not tainted 6.16.0-0.rc7.60.eln150.x86_64 #1 PREEMPT(lazy)
Hardware name: Abacus electric, s.r.o. - servis@abacus.cz Super Server/H12SSW-iN, BIOS 2.7 10/25/2023
RIP: 0010:skb_warn_bad_offload+0x81/0x140
Code: 8d 88 18 02 00 00 48 85 c0 48 c7 c0 28 43 41 9e 48 0f 44 c8 48 8d 93 b8 00 00 00 4c 89 c6 48 c7 c7 b3 92 a3 9e e8 cf 0e 4e ff <0f> 0b 48 83 c4 08 5b 5d e9 6d b5 2a ff 80 bb 20 01 00 00 00 74 1d
RSP: 0018:ffffcfed417aef70 EFLAGS: 00010246
RAX: 0000000000000000 RBX: ffff8ec94e59c000 RCX: 0000000000000000
RDX: ffff8ed84e66a500 RSI: 0000000000000001 RDI: ffff8ed84e65c200
RBP: ffff8ecb1716e0e8 R08: 0000000000000000 R09: 00000000ffff7fff
R10: ffffffff9f265700 R11: ffffcfed417aee08 R12: ffff8ec94e59c000
R13: ffffcfed417af023 R14: ffff8ec94e59c000 R15: ffffcfed417af023
FS:  00007f7ee69516c0(0000) GS:ffff8ed8ae504000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f7ee6950f78 CR3: 000000011436c006 CR4: 0000000000f70ef0
PKRU: 55555554
Call Trace:
 <TASK>
 skb_checksum_help+0x12a/0x1f0
 ? netif_skb_features+0xc1/0x2e0
 validate_xmit_skb+0x1a3/0x2d0
 validate_xmit_skb_list+0x4f/0x80
 sch_direct_xmit+0x1a2/0x380
 __dev_xmit_skb+0x242/0x670
 __dev_queue_xmit+0x3fc/0x7f0
 ? srso_alias_return_thunk+0x5/0xfbef5
 ? ip6_rt_copy_init+0xf0/0x290
 ? srso_alias_return_thunk+0x5/0xfbef5
 ? selinux_ip_postroute+0x1c5/0x420
 ? srso_alias_return_thunk+0x5/0xfbef5
 ip6_finish_output2+0x25e/0x5d0
 ? srso_alias_return_thunk+0x5/0xfbef5
 ? nf_hook_slow+0x47/0xf0
 ? srso_alias_return_thunk+0x5/0xfbef5
 ip6_finish_output+0x1fc/0x3f0
 ip6_tnl_xmit+0x608/0xc00 [ip6_tunnel]
 ? srso_alias_return_thunk+0x5/0xfbef5
 ip6gre_tunnel_xmit+0x1c0/0x390 [ip6_gre]
 dev_hard_start_xmit+0x63/0x1c0
 __dev_queue_xmit+0x6d0/0x7f0
 ? srso_alias_return_thunk+0x5/0xfbef5
 ? chacha_block_generic+0x72/0xd0
 ? srso_alias_return_thunk+0x5/0xfbef5
 ? selinux_ip_postroute+0x1c5/0x420
 ip6_finish_output2+0x214/0x5d0
 ? srso_alias_return_thunk+0x5/0xfbef5
 ? nf_hook_slow+0x47/0xf0
 ip6_finish_output+0x1fc/0x3f0
 ip6_xmit+0x2ca/0x6f0
 ? __pfx_dst_output+0x10/0x10
 ? srso_alias_return_thunk+0x5/0xfbef5
 ? __sk_dst_check+0x41/0xc0
 ? srso_alias_return_thunk+0x5/0xfbef5
 ? inet6_csk_route_socket+0x12e/0x200
 inet6_csk_xmit+0xeb/0x150
 __tcp_transmit_skb+0x555/0xa80
 tcp_write_xmit+0x32a/0xe90
 ? srso_alias_return_thunk+0x5/0xfbef5
 ? skb_do_copy_data_nocache+0xc9/0x150
 tcp_sendmsg_locked+0x437/0x1110
 ? srso_alias_return_thunk+0x5/0xfbef5
 tcp_sendmsg+0x2f/0x50
 sock_write_iter+0x126/0x1a0
 vfs_write+0x3c8/0x480
 ksys_write+0xbf/0xf0
 do_syscall_64+0x7c/0x970
 ? srso_alias_return_thunk+0x5/0xfbef5
 ? syscall_exit_work+0x143/0x1b0
 ? srso_alias_return_thunk+0x5/0xfbef5
 ? do_syscall_64+0xaf/0x970
 ? srso_alias_return_thunk+0x5/0xfbef5
 ? __rseq_handle_notify_resume+0x39/0x60
 ? srso_alias_return_thunk+0x5/0xfbef5
 ? exit_to_user_mode_loop+0xbf/0x120
 ? srso_alias_return_thunk+0x5/0xfbef5
 ? do_syscall_64+0xaf/0x970
 ? srso_alias_return_thunk+0x5/0xfbef5
 ? drain_stock+0x79/0xa0
 ? srso_alias_return_thunk+0x5/0xfbef5
 ? __mem_cgroup_threshold+0x18/0xf0
 ? srso_alias_return_thunk+0x5/0xfbef5
 ? srso_alias_return_thunk+0x5/0xfbef5
 ? memcg1_check_events+0x60/0x1b0
 ? srso_alias_return_thunk+0x5/0xfbef5
 ? memcg1_commit_charge+0x6f/0x90
 ? srso_alias_return_thunk+0x5/0xfbef5
 ? srso_alias_return_thunk+0x5/0xfbef5
 ? mod_memcg_lruvec_state+0x1a4/0x200
 ? srso_alias_return_thunk+0x5/0xfbef5
 ? __lruvec_stat_mod_folio+0x85/0xd0
 ? srso_alias_return_thunk+0x5/0xfbef5
 ? srso_alias_return_thunk+0x5/0xfbef5
 ? __folio_mod_stat+0x2d/0x90
 ? srso_alias_return_thunk+0x5/0xfbef5
 ? folio_add_new_anon_rmap+0x72/0x1b0
 ? srso_alias_return_thunk+0x5/0xfbef5
 ? do_anonymous_page+0x49c/0x710
 ? srso_alias_return_thunk+0x5/0xfbef5
 ? syscall_exit_work+0x143/0x1b0
 ? srso_alias_return_thunk+0x5/0xfbef5
 ? do_syscall_64+0xaf/0x970
 ? srso_alias_return_thunk+0x5/0xfbef5
 ? count_memcg_events+0x14d/0x1a0
 ? srso_alias_return_thunk+0x5/0xfbef5
 ? handle_mm_fault+0x247/0x360
 ? srso_alias_return_thunk+0x5/0xfbef5
 ? do_user_addr_fault+0x20f/0x6a0
 ? srso_alias_return_thunk+0x5/0xfbef5
 ? srso_alias_return_thunk+0x5/0xfbef5
 ? irqentry_exit_to_user_mode+0x2c/0x180
 entry_SYSCALL_64_after_hwframe+0x76/0x7e
RIP: 0033:0x7f7ee713098f
Code: 89 54 24 18 48 89 74 24 10 89 7c 24 08 e8 39 7a f9 ff 48 8b 54 24 18 48 8b 74 24 10 41 89 c0 8b 7c 24 08 b8 01 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 31 44 89 c7 48 89 44 24 08 e8 8c 7a f9 ff 48
RSP: 002b:00007f7ee6950e00 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 0000000000020000 RCX: 00007f7ee713098f
RDX: 0000000000020000 RSI: 00007f7ee6f11000 RDI: 0000000000000005
RBP: 00007f7ee6f11000 R08: 0000000000000002 R09: 00007f7ee69516c0
R10: 0000000000000008 R11: 0000000000000246 R12: 0000000000000005
R13: 0000000000020000 R14: 00007ffea6ee3400 R15: 00007ffea6ee3507
 </TASK>
---[ end trace 0000000000000000 ]---
skb len=7018 headroom=182 headlen=138 tailroom=0
mac=(182,14) mac_len=0 net=(196,48) trans=244
shinfo(txflags=0 nr_frags=1 gso(size=1376 type=80 segs=5))
csum(0x100120 start=288 offset=16 ip_summed=3 complete_sw=0 valid=0 level=0)
hash(0x7ec90a00 sw=0 l4=1) proto=0x86dd pkttype=0 iif=0
priority=0x0 mark=0x0 alloc_cpu=1 vlan_all=0x0
encapsulation=1 inner(proto=0xdd86, mac=248, net=248, trans=288)
dev name=enp1s0f0np0 feat=0x009201c01dd14833
sk family=10 type=1 proto=6
skb linear:   00000000: e4 3d 1a 7d ec 30 e4 3d 1a 7e 5d 90 86 dd 60 0e
skb linear:   00000010: 00 0a 1b 34 3c 40 20 11 00 00 00 00 00 00 00 00
skb linear:   00000020: 00 00 00 00 00 12 20 11 00 00 00 00 00 00 00 00
skb linear:   00000030: 00 00 00 00 00 11 2f 00 04 01 04 01 01 00 00 00
skb linear:   00000040: 86 dd 60 0e 00 0a 1b 00 06 40 20 23 00 00 00 00
skb linear:   00000050: 00 00 00 00 00 00 00 00 00 12 20 23 00 00 00 00
skb linear:   00000060: 00 00 00 00 00 00 00 00 00 11 bf 96 14 51 13 f9
skb linear:   00000070: ae 27 a0 a8 2b e3 80 18 00 40 5b 6f 00 00 01 01
skb linear:   00000080: 08 0a 42 d4 50 d5 4b 70 f8 1a
skb frag:     00000000: 80 de bb bd 51 f8 32 e7 5d f5 65 65 a1 22 76 05
skb frag:     00000010: 02 f8 60 25 e6 37 0b b3 90 05 8e 7f f4 c2 5d 9c
skb frag:     00000020: e3 24 84 ac 0e 03 9d 14 ac 1e e2 18 4c 45 ef 5f
skb frag:     00000030: db 95 db ab 1f c9 7f 6d 19 70 1f 0c e7 6e fd 6e
skb frag:     00000040: f4 ff 73 1e 06 8d a8 06 53 ba bf 58 12 cb b9 59
skb frag:     00000050: f0 71 7e c3 69 0a f5 19 8b b3 eb b1 fa e5 9c 59
skb frag:     00000060: 40 bb 1d 11 88 f4 c1 cc 77 91 41 2c bb 7e 9d b7
skb frag:     00000070: ac 50 1a e3 d1 ce f7 f9 58 e4 d5 5c 62 f4 eb 39
skb frag:     00000080: 0d 13 2a 31 2c ec
------------[ cut here ]------------

Mask NETIF_F_IPV6_CSUM in gso_features_check if the IPv6 header contains
extension headers. This flag indicates that the network interface
is capable of computing the checksum only for plain IPv6 headers
without any extension headers.

The exception is a BIG TCP extension, which, as stated in 68e068cabd2c6c53:
"The feature is only enabled on devices that support BIG TCP TSO.
The header is only present for PF_PACKET taps like tcpdump,
and not transmitted by physical devices."

Fixes: 04c20a9356f283da ("net: skip offload for NETIF_F_IPV6_CSUM if ipv6 header contains extension")
Reported-by: Tianhao Zhao <tizhao@redhat.com>
Suggested-by: Michal Schmidt <mschmidt@redhat.com>
Signed-off-by: Jakub Ramaseuski <jramaseu@redhat.com>
---
---
 net/core/dev.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/net/core/dev.c b/net/core/dev.c
index b28ce68830b2b..118c433c2cb9b 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -3778,6 +3778,10 @@ static netdev_features_t gso_features_check(const struct sk_buff *skb,
 		if (!(iph->frag_off & htons(IP_DF)))
 			features &= ~NETIF_F_TSO_MANGLEID;
 	}
+	if (vlan_get_protocol(skb) == htons(ETH_P_IPV6) &&
+		skb_network_header_len(skb) != sizeof(struct ipv6hdr) &&
+		!ipv6_has_hopopt_jumbo(skb))
+		features &= ~NETIF_F_IPV6_CSUM;
 
 	return features;
 }
-- 
2.50.1


