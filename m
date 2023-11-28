Return-Path: <netdev+bounces-51871-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 42D7A7FC92B
	for <lists+netdev@lfdr.de>; Tue, 28 Nov 2023 23:12:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C945EB2115F
	for <lists+netdev@lfdr.de>; Tue, 28 Nov 2023 22:12:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 377AF481BE;
	Tue, 28 Nov 2023 22:12:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=kpnmail.nl header.i=@kpnmail.nl header.b="aw0OQmSR"
X-Original-To: netdev@vger.kernel.org
Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.170])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60343D63
	for <netdev@vger.kernel.org>; Tue, 28 Nov 2023 14:12:09 -0800 (PST)
X-KPN-MessageId: 29c0304d-8e3b-11ee-8345-005056ab378f
Received: from smtp.kpnmail.nl (unknown [10.31.155.40])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id 29c0304d-8e3b-11ee-8345-005056ab378f;
	Tue, 28 Nov 2023 23:12:04 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=kpnmail.nl; s=kpnmail01;
	h=content-type:mime-version:message-id:subject:to:from:date;
	bh=w3Stj1n2oyrP2+KVed0umNE48cTD7wgLqIrg/YQisC0=;
	b=aw0OQmSRIXL7qqrX/Owyq3mqasPMXgB5PXIh5kl6rM8cf6xBDk/NYV9pd7Lp/eux4zeXHFIdQaaBz
	 PELxJvT9R65Q3enjTmktj/0s5q4opc+Zxr+96cwpmaPqlnM/A8+O0BLe37MIuTEsQ/ZT3hvo0i2m5T
	 jvSaxukO+Waphb50=
X-KPN-MID: 33|FEHJqNlPy9tzb6U1J9PWHnTJml/UenE/brrDEh0CPzz9Cz8mts1Kmgbu7NK+Lbq
 IeTnQT2eSdnWJ5dgGbQOAUu9JvisGNV8/nui9JgCRa9I=
X-KPN-VerifiedSender: No
X-CMASSUN: 33|V0KF3oWeDD5V22raoAIQoiIZGnTfvT+xUXhZt0SLdH/tRy20nNPmoqvwv3T6S+y
 CW4d36Uo9ZhKy6zlA5e2xdw==
Received: from Antony2201.local (213-10-186-43.fixed.kpn.net [213.10.186.43])
	by smtp.xs4all.nl (Halon) with ESMTPSA
	id 2a3fe092-8e3b-11ee-9f03-005056ab7584;
	Tue, 28 Nov 2023 23:12:07 +0100 (CET)
Date: Tue, 28 Nov 2023 23:12:05 +0100
From: Antony Antony <antony@phenome.org>
To: Christian Hopps <chopps@chopps.org>
Cc: devel@linux-ipsec.org, netdev@vger.kernel.org,
	Christian Hopps <chopps@labn.net>
Subject: Re: [devel-ipsec] [RFC ipsec-next v2 0/8] Add IP-TFS mode to xfrm
Message-ID: <ZWZltZwdl7y4vDOW@Antony2201.local>
References: <20231113035219.920136-1-chopps@chopps.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231113035219.920136-1-chopps@chopps.org>

Hi Chris,

I got a crash when running inside a  namespace using veth. I got twice. It 
is not 100% reproducable. 

Note: I have KASAN enabled.

[  226.323824] BUG: KASAN: null-ptr-deref in 
iptfs_output_collect+0x1f5/0x61a
[  226.325155] Read of size 8 at addr 0000000000000478 by task ping/5276
[  226.325980]
[  226.326220] CPU: 2 PID: 5276 Comm: ping Not tainted 6.6.0-rc1-00528-gadd9146753b7 #95
[  226.327219] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
[  226.328396] Call Trace:
[  226.328791]  <TASK>
[  226.329099]  dump_stack_lvl+0x33/0x42
[  226.329597]  kasan_report+0xa0/0xc3
[  226.330074]  ? iptfs_output_collect+0x1f5/0x61a
[  226.330678]  iptfs_output_collect+0x1f5/0x61a
[  226.331259]  ip_send_skb+0x25/0x58
[  226.331724]  raw_sendmsg+0xec4/0xfee
[  226.332223]  ? raw_hash_sk+0x224/0x224
[  226.332741]  ? kasan_unpoison+0x44/0x52
[  226.333258]  ? kernel_init_pages+0x42/0x51
[  226.333810]  ? post_alloc_hook+0xba/0xe0
[  226.334339]  ? prep_new_page+0x44/0x51
[  226.334849]  ? ma_data_end+0x6e/0x88
[  226.335338]  ? preempt_count_sub+0x14/0xb5
[  226.335894]  ? zone_watermark_fast.isra.0+0x12b/0x12b
[  226.336577]  ? __might_resched+0x8d/0x248
[  226.337116]  ? __might_sleep+0x27/0xa2
[  226.337626]  ? first_zones_zonelist+0x2c/0x43
[  226.338211]  ? do_raw_spin_lock+0x72/0xbb
[  226.338752]  ? __might_resched+0x8d/0x248
[  226.339291]  ? __might_sleep+0x27/0xa2
[  226.339801]  ? inet_send_prepare+0x59/0x59
[  226.340356]  ? sock_sendmsg_nosec+0x42/0x6c
[  226.340924]  sock_sendmsg_nosec+0x42/0x6c
[  226.341465]  __sys_sendto+0x172/0x1e1
[  226.341964]  ? __x64_sys_getpeername+0x44/0x44
[  226.342558]  ? folio_batch_add_and_move+0x6a/0x7d
[  226.343189]  ? find_vma+0x6b/0x8b
[  226.343646]  ? find_vma_intersection+0x8a/0x8a
[  226.344246]  ? handle_mm_fault+0xfa/0x163
[  226.344788]  ? preempt_latency_start+0x41/0x4c
[  226.345385]  ? preempt_count_sub+0x14/0xb5
[  226.345937]  __x64_sys_sendto+0x76/0x82
[  226.346456]  do_syscall_64+0x58/0x78
[  226.346946]  entry_SYSCALL_64_after_hwframe+0x46/0xb0
[  226.347611] RIP: 0033:0x7f378b00ba73
[  226.348095] Code: 8b 15 a9 83 0c 00 f7 d8 64 89 02 48 c7 c0 ff ff ff ff eb b8 0f 1f 00 80 3d 71 0b 0d 00 00 41 89 ca 74 14 b8 2c 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 75 c3 0f 1f 40 00 55 48 83 ec 30 44 89 4c 24
[  226.350433] RSP: 002b:00007fff58f9c148 EFLAGS: 00000202 ORIG_RAX: 000000000000002c
[  226.351400] RAX: ffffffffffffffda RBX: 00005591b05fa340 RCX: 00007f378b00ba73
[  226.352318] RDX: 0000000000000040 RSI: 00005591b06003c0 RDI: 0000000000000003
[  226.353233] RBP: 00005591b06003c0 R08: 00005591b05fc5c0 R09: 0000000000000010
[  226.354147] R10: 0000000000000000 R11: 0000000000000202 R12: 0000000000000040
[  226.355061] R13: 00007fff58f9d830 R14: 0000001d00000001 R15: 00005591b05fd680
[  226.355978]  </TASK>
[  226.356301] ==================================================================
[  226.357274] Disabling lock debugging due to kernel taint
[  226.357973] BUG: kernel NULL pointer dereference, address: 0000000000000478
[  226.358865] #PF: supervisor read access in kernel mode
[  226.359540] #PF: error_code(0x0000) - not-present page
[  226.360220] PGD 0 P4D 0
[  226.360594] Oops: 0000 [#1] PREEMPT SMP DEBUG_PAGEALLOC KASAN
[  226.361346] CPU: 2 PID: 5276 Comm: ping Tainted: G    B              6.6.0-rc1-00528-gadd9146753b7 #95
[  226.362520] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
[  226.363693] RIP: 0010:iptfs_output_collect+0x1f5/0x61a
[  226.364376] Code: c1 ff ff 65 ff 0d 12 29 35 7e 75 05 e8 c3 f0 31 ff 48 8d 7b 10 e8 4b 16 6b ff 4c 8b 73 10 49 8d be 78 04 00 00 e8 3b 16 6b ff <4d> 8b b6 78 04 00 00 49 8d be c0 01 00 00 e8 28 16 6b ff 49 8b 86
[  226.366704] RSP: 0018:ffffc9000a357998 EFLAGS: 00010296
[  226.367389] RAX: 0000000000000001 RBX: ffff8881123a7a00 RCX: fffffbfff075e9f5
[  226.368308] RDX: fffffbfff075e9f5 RSI: fffffbfff075e9f5 RDI: ffffffff83af4fa0
[  226.369237] RBP: ffff88810f45ac00 R08: 0000000000000008 R09: 0000000000000001
[  226.370154] R10: ffffffff83af4fa7 R11: fffffbfff075e9f4 R12: 0000000000000000
[  226.371070] R13: 0000000000000000 R14: 0000000000000000 R15: ffff888114cbeb01
[  226.371984] FS:  00007f378ad4fc40(0000) GS:ffff88815ad00000(0000) knlGS:0000000000000000
[  226.373029] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  226.373777] CR2: 0000000000000478 CR3: 00000001083e9000 CR4: 0000000000350ee0
[  226.374693] Call Trace:
[  226.375042]  <TASK>
[  226.375352]  ? __die_body+0x1a/0x58
[  226.375828]  ? page_fault_oops+0x459/0x4c7
[  226.376387]  ? irq_work_queue+0x2c/0x41
[  226.376915]  ? dump_pagetable+0x1db/0x1db
[  226.377453]  ? vprintk_emit+0x187/0x195
[  226.377972]  ? iptfs_output_collect+0x1f5/0x61a
[  226.378576]  ? _printk+0xb2/0xe1
[  226.379021]  ? syslog_print+0x340/0x340
[  226.379541]  ? do_user_addr_fault+0x156/0x59f
[  226.380713]  ? exc_page_fault+0xaa/0xc3
[  226.381234]  ? asm_exc_page_fault+0x22/0x30
[  226.381795]  ? iptfs_output_collect+0x1f5/0x61a
[  226.382399]  ? iptfs_output_collect+0x1f5/0x61a
[  226.383002]  ip_send_skb+0x25/0x58
[  226.383469]  raw_sendmsg+0xec4/0xfee
[  226.383958]  ? raw_hash_sk+0x224/0x224
[  226.385083]  ? kasan_unpoison+0x44/0x52
[  226.385866]  ? kernel_init_pages+0x42/0x51
[  226.386687]  ? post_alloc_hook+0xba/0xe0
[  226.387559]  ? prep_new_page+0x44/0x51
[  226.388522]  ? ma_data_end+0x6e/0x88
[  226.389365]  ? preempt_count_sub+0x14/0xb5
[  226.390575]  ? zone_watermark_fast.isra.0+0x12b/0x12b
[  226.391555]  ? __might_resched+0x8d/0x248
[  226.392127]  ? __might_sleep+0x27/0xa2
[  226.392794]  ? first_zones_zonelist+0x2c/0x43
[  226.393684]  ? do_raw_spin_lock+0x72/0xbb
[  226.394501]  ? __might_resched+0x8d/0x248
[  226.395324]  ? __might_sleep+0x27/0xa2
[  226.396204]  ? inet_send_prepare+0x59/0x59
[  226.397042]  ? sock_sendmsg_nosec+0x42/0x6c
[  226.397879]  sock_sendmsg_nosec+0x42/0x6c
[  226.398704]  __sys_sendto+0x172/0x1e1
[  226.399465]  ? __x64_sys_getpeername+0x44/0x44
[  226.400367]  ? folio_batch_add_and_move+0x6a/0x7d
[  226.401327]  ? find_vma+0x6b/0x8b
[  226.401812]  ? find_vma_intersection+0x8a/0x8a
[  226.402442]  ? handle_mm_fault+0xfa/0x163
[  226.403014]  ? preempt_latency_start+0x41/0x4c
[  226.403641]  ? preempt_count_sub+0x14/0xb5
[  226.404224]  __x64_sys_sendto+0x76/0x82
[  226.404790]  do_syscall_64+0x58/0x78
[  226.405306]  entry_SYSCALL_64_after_hwframe+0x46/0xb0
[  226.406010] RIP: 0033:0x7f378b00ba73
[  226.406524] Code: 8b 15 a9 83 0c 00 f7 d8 64 89 02 48 c7 c0 ff ff ff ff eb b8 0f 1f 00 80 3d 71 0b 0d 00 00 41 89 ca 74 14 b8 2c 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 75 c3 0f 1f 40 00 55 48 83 ec 30 44 89 4c 24
[  226.408990] RSP: 002b:00007fff58f9c148 EFLAGS: 00000202 ORIG_RAX: 000000000000002c
[  226.410020] RAX: ffffffffffffffda RBX: 00005591b05fa340 RCX: 00007f378b00ba73
[  226.410992] RDX: 0000000000000040 RSI: 00005591b06003c0 RDI: 0000000000000003
[  226.411968] RBP: 00005591b06003c0 R08: 00005591b05fc5c0 R09: 0000000000000010
[  226.412948] R10: 0000000000000000 R11: 0000000000000202 R12: 0000000000000040
[  226.413923] R13: 00007fff58f9d830 R14: 0000001d00000001 R15: 00005591b05fd680
[  226.414904]  </TASK>
[  226.415243] Modules linked in:
[  226.415697] CR2: 0000000000000478
[  226.416181] ---[ end trace 0000000000000000 ]---
[  226.416848] RIP: 0010:iptfs_output_collect+0x1f5/0x61a
[  226.417569] Code: c1 ff ff 65 ff 0d 12 29 35 7e 75 05 e8 c3 f0 31 ff 48 8d 7b 10 e8 4b 16 6b ff 4c 8b 73 10 49 8d be 78 04 00 00 e8 3b 16 6b ff <4d> 8b b6 78 04 00 00 49 8d be c0 01 00 00 e8 28 16 6b ff 49 8b 86
[  226.420031] RSP: 0018:ffffc9000a357998 EFLAGS: 00010296
[  226.420764] RAX: 0000000000000001 RBX: ffff8881123a7a00 RCX: fffffbfff075e9f5
[  226.421733] RDX: fffffbfff075e9f5 RSI: fffffbfff075e9f5 RDI: ffffffff83af4fa0
[  226.422704] RBP: ffff88810f45ac00 R08: 0000000000000008 R09: 0000000000000001
[  226.423671] R10: ffffffff83af4fa7 R11: fffffbfff075e9f4 R12: 0000000000000000
[  226.424646] R13: 0000000000000000 R14: 0000000000000000 R15: ffff888114cbeb01
[  226.425616] FS:  00007f378ad4fc40(0000) GS:ffff88815ad00000(0000) knlGS:0000000000000000
[  226.426709] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  226.427501] CR2: 0000000000000478 CR3: 00000001083e9000 CR4: 0000000000350ee0
[  226.428492] Kernel panic - not syncing: Fatal exception in interrupt
[  226.429587] Kernel Offset: disabled
[  226.430096] ---[ end Kernel panic - not syncing: Fatal exception in interrupt ]---

(gdb) list *iptfs_output_collect+0x1f5
0xffffffff81ce40d6 is in iptfs_output_collect (./include/net/net_namespace.h:385).
380	}
381
382	static inline struct net *read_pnet(const possible_net_t *pnet)
383	{
384	#ifdef CONFIG_NET_NS
385		return pnet->net;
386	#else
387		return &init_net;
388	#endif
389	}


On Sun, Nov 12, 2023 at 10:52:11PM -0500, Christian Hopps via Devel wrote:
> From: Christian Hopps <chopps@labn.net>
> 
> This patchset adds a new xfrm mode implementing on-demand IP-TFS. IP-TFS
> (AggFrag encapsulation) has been standardized in RFC9347.
> 
> Link: https://www.rfc-editor.org/rfc/rfc9347.txt
> 
> This feature supports demand driven (i.e., non-constant send rate) IP-TFS to
> take advantage of the AGGFRAG ESP payload encapsulation. This payload type
> supports aggregation and fragmentation of the inner IP packet stream which in
> turn yields higher small-packet bandwidth as well as reducing MTU/PMTU issues.
> Congestion control is unimplementated as the send rate is demand driven rather
> than constant.
> 
> In order to allow loading this fucntionality as a module a set of callbacks
> xfrm_mode_cbs has been added to xfrm as well.
> -- 
> Devel mailing list
> Devel@linux-ipsec.org
> https://linux-ipsec.org/mailman/listinfo/devel

