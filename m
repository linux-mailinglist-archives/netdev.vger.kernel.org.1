Return-Path: <netdev+bounces-92623-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 714FC8B824B
	for <lists+netdev@lfdr.de>; Wed,  1 May 2024 00:00:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2749B28129A
	for <lists+netdev@lfdr.de>; Tue, 30 Apr 2024 22:00:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AD881BED89;
	Tue, 30 Apr 2024 22:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=allelesecurity.com header.i=@allelesecurity.com header.b="T57+aChW"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CC021A0AF9
	for <netdev@vger.kernel.org>; Tue, 30 Apr 2024 22:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714514445; cv=none; b=Nkma597SXHOStqRDHIATrZT8KeK+ZbhZbwrmcxYv1mo3l769SA+glVv2JRE51pN1wKe/RmAE+5vhyac9SYJ4Zt+GReJzaLpAHujRmiIQ7YE1659F8gkSl95QrHIYp66Joi5g/q2gJQWBPCeuJsPFrNxQx/HwYNYvqj/5yAXu8k8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714514445; c=relaxed/simple;
	bh=q4qZBDLQO6EvjqfofT0UlK/726NnYf1f0oBkXLHZ/rA=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Content-Type; b=KK1fY39fgwFP55EGvpeUBCj+cgdalWeh65x3hAgGnOYdA078e4RZXdfZrZe9wi25BETjibmegbenD3vXLHXqBceQJJpfJxOQjGV8QR7k6vS2E9b1Oc4mtGtumXq+fWDWQF3+xO8ELDWXrlfF9Gdj95tVSZJzX5agrXnko8dtFl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=allelesecurity.com; spf=pass smtp.mailfrom=allelesecurity.com; dkim=pass (1024-bit key) header.d=allelesecurity.com header.i=@allelesecurity.com header.b=T57+aChW; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=allelesecurity.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=allelesecurity.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-6f0b9f943cbso5114540b3a.0
        for <netdev@vger.kernel.org>; Tue, 30 Apr 2024 15:00:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=allelesecurity.com; s=google; t=1714514442; x=1715119242; darn=vger.kernel.org;
        h=content-transfer-encoding:autocrypt:content-language:to:subject
         :from:user-agent:mime-version:date:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=xb9BWMDusNtG/ro0L41d41H9CNvp9Qux5e9n1WA7kNU=;
        b=T57+aChW5Q7uAhWy2BbOJ3IT1Ub42pI+c2gkZeVijYsZUpdM/mgQsdRdPfyoLym9TO
         +0c9udTrrPuEKXquxtcKZf7blMWgh1KhtGtmwnkxh7ee27njhwh7Pj701CzpqLKX1nsM
         3/gMu7pZbTRycb7Y6ShG5qzoMvHgLFsLOuDGc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714514442; x=1715119242;
        h=content-transfer-encoding:autocrypt:content-language:to:subject
         :from:user-agent:mime-version:date:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xb9BWMDusNtG/ro0L41d41H9CNvp9Qux5e9n1WA7kNU=;
        b=OMrb59NEPxMagAITawPI782iZlGi7ej2vpn9XUSgCO6UiY2EhkfUYJ9gaSOv8e52HE
         VeFk7EzMa6POOwCdm+qBFhYDqsNxhWnF2jACYP8GfYfychDp6d5xPJOa0mdk7teBePjq
         ncmWiVOAQFimUibzM8ZFJ1Bg83kQiAdcyDFbMWsC2AnybO4ZaJbY1AQGAllpOmBRNFZX
         KE0PnH8rMVbygf7B2q513PCSzyEHOs+efQpnYVWKdHyN343ptqWBHh/ytmdCR0oXiQgC
         qfbEuVc53kj0JNXgjl9CjVTkv3dn8TjuzUmXdohU4Jqk+Ad1jRBuMEFd1cNB18/q5NkE
         E5DQ==
X-Gm-Message-State: AOJu0Yw5Ba4LDhJ4qCgpsdz8ovnO2IzSg2FFnkuEuHTCeppz4UWffxHC
	45PQVXoX7erII2OKkeSX8wNpuvkvbjmluHDaMN6bUyrKtkxq9JMgOzJ81gh2VQIvAsRLCww4FZc
	7J4s=
X-Google-Smtp-Source: AGHT+IFw+IsS10sj2POTcUpsf5Pha9Qu4cpnVDAoeecamULk56WsoE2qjkJRpB+gxa1vlSf4hyZeUg==
X-Received: by 2002:a05:6a20:a11a:b0:1af:6164:7c35 with SMTP id q26-20020a056a20a11a00b001af61647c35mr1485309pzk.17.1714514441060;
        Tue, 30 Apr 2024 15:00:41 -0700 (PDT)
Received: from [192.168.1.2] ([191.178.115.215])
        by smtp.gmail.com with ESMTPSA id ta5-20020a17090b4ec500b002b2cada0c6fsm80450pjb.26.2024.04.30.15.00.39
        for <netdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Apr 2024 15:00:40 -0700 (PDT)
Message-ID: <37a477a6-d39e-486b-9577-3463f655a6b7@allelesecurity.com>
Date: Tue, 30 Apr 2024 19:00:34 -0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Anderson Nascimento <anderson@allelesecurity.com>
Subject: use-after-free warnings in tcp_v4_connect() due to
 inet_twsk_hashdance() inserting the object into ehash table without
 initializing its reference counter
To: netdev@vger.kernel.org
Content-Language: en-US
Autocrypt: addr=anderson@allelesecurity.com; keydata=
 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
 KglE9pfKPqrm
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hello,

There is a bug in inet_twsk_hashdance(). This function inserts a 
time-wait socket in the established hash table without initializing the 
object's reference counter, as seen below. The reference counter 
initialization is done after the object is added to the established hash 
table and the lock is released. Because of this, a sock_hold() in 
tcp_twsk_unique() and other operations on the object trigger warnings 
from the reference counter saturation mechanism. The warnings can also 
be seen below. They were triggered on Fedora 39 Linux kernel v6.8.

The bug is triggered via a connect() system call on a TCP socket, 
reaching __inet_check_established() and then passing the time-wait 
socket to tcp_twsk_unique(). Other operations are also performed on the 
time-wait socket in __inet_check_established() before its reference 
counter is initialized correctly by inet_twsk_hashdance(). The fix seems 
to be to move the reference counter initialization inside the lock, but 
as I didn't test it, I can't confirm it.

The bug seems to be introduced by commit ec94c269 ("
tcp/dccp: avoid one atomic operation for timewait hashdance").

100 void inet_twsk_hashdance(struct inet_timewait_sock *tw, struct sock *sk,
101                            struct inet_hashinfo *hashinfo)
102 {
103         const struct inet_sock *inet = inet_sk(sk);
104         const struct inet_connection_sock *icsk = inet_csk(sk);
105         struct inet_ehash_bucket *ehead = 
inet_ehash_bucket(hashinfo, sk->sk_hash);
106         spinlock_t *lock = inet_ehash_lockp(hashinfo, sk->sk_hash);
107         struct inet_bind_hashbucket *bhead, *bhead2;
...
129
130         spin_lock(lock);
131
132         inet_twsk_add_node_rcu(tw, &ehead->chain);
133
134         /* Step 3: Remove SK from hash chain */
135         if (__sk_nulls_del_node_init_rcu(sk))
136                 sock_prot_inuse_add(sock_net(sk), sk->sk_prot, -1);
137
138         spin_unlock(lock);
...
149         refcount_set(&tw->tw_refcnt, 3);
150 }

538 static int __inet_check_established(struct inet_timewait_death_row 
*death_row,
539                                     struct sock *sk, __u16 lport,
540                                     struct inet_timewait_sock **twp)
541 {
542         struct inet_hashinfo *hinfo = death_row->hashinfo;
543         struct inet_sock *inet = inet_sk(sk);
544         __be32 daddr = inet->inet_rcv_saddr;
545         __be32 saddr = inet->inet_daddr;
546         int dif = sk->sk_bound_dev_if;
547         struct net *net = sock_net(sk);
548         int sdif = l3mdev_master_ifindex_by_index(net, dif);
549         INET_ADDR_COOKIE(acookie, saddr, daddr);
550         const __portpair ports = 
INET_COMBINED_PORTS(inet->inet_dport, lport);
551         unsigned int hash = inet_ehashfn(net, daddr, lport,
552                                          saddr, inet->inet_dport);
553         struct inet_ehash_bucket *head = inet_ehash_bucket(hinfo, hash);
554         spinlock_t *lock = inet_ehash_lockp(hinfo, hash);
555         struct sock *sk2;
556         const struct hlist_nulls_node *node;
557         struct inet_timewait_sock *tw = NULL;
558
559         spin_lock(lock);
560
561         sk_nulls_for_each(sk2, node, &head->chain) {
562                 if (sk2->sk_hash != hash)
563                         continue;
564
565                 if (likely(inet_match(net, sk2, acookie, ports, dif, 
sdif))) {
566                         if (sk2->sk_state == TCP_TIME_WAIT) {
567                                 tw = inet_twsk(sk2);
568                                 if (twsk_unique(sk, sk2, twp))
569                                         break;
570                         }
571                         goto not_unique;
572                 }
573         }
...

23 static inline int twsk_unique(struct sock *sk, struct sock *sktw, 
void *twp)
24 {
25         if (sk->sk_prot->twsk_prot->twsk_unique != NULL)
26                 return sk->sk_prot->twsk_prot->twsk_unique(sk, sktw, 
twp);
27         return 0;
28 }

110 int tcp_twsk_unique(struct sock *sk, struct sock *sktw, void *twp)
111 {
112         int reuse = READ_ONCE(sock_net(sk)->ipv4.sysctl_tcp_tw_reuse);
113         const struct inet_timewait_sock *tw = inet_twsk(sktw);
114         const struct tcp_timewait_sock *tcptw = tcp_twsk(sktw);
115         struct tcp_sock *tp = tcp_sk(sk);
116
...
154         if (tcptw->tw_ts_recent_stamp &&
155             (!twp || (reuse && time_after32(ktime_get_seconds(),
156 tcptw->tw_ts_recent_stamp)))) {
...
168                 if (likely(!tp->repair)) {
...
176                 }
177                 sock_hold(sktw);
178                 return 1;
179         }
180
181         return 0;
182 }

[433522.338983] ------------[ cut here ]------------
[433522.339033] refcount_t: addition on 0; use-after-free.
[433522.339706] WARNING: CPU: 0 PID: 1039313 at lib/refcount.c:25 
refcount_warn_saturate+0xe5/0x110
[433522.340028] Modules linked in: binfmt_misc nft_fib_inet nft_fib_ipv4 
nft_fib_ipv6 nft_fib nft_reject_inet nf_reject_ipv4 nf_reject_ipv6 
nft_reject nft_ct nft_chain_nat nf_nat nf_conntrack nf_defrag_ipv6 
nf_defrag_ipv4 rfkill nf_tables nfnetlink qrtr vsock_loopback 
vmw_vsock_virtio_transport_common vmw_vsock_vmci_transport vsock 
intel_rapl_msr intel_rapl_common intel_uncore_frequency_common 
intel_pmc_core snd_ens1371 intel_vsec pmt_telemetry snd_ac97_codec 
pmt_class rapl gameport vmw_balloon snd_rawmidi snd_seq_device sunrpc 
ac97_bus snd_pcm snd_timer snd soundcore vfat fat vmw_vmci i2c_piix4 
joydev loop zram xfs crct10dif_pclmul crc32_pclmul crc32c_intel nvme 
polyval_clmulni polyval_generic nvme_core ghash_clmulni_intel vmwgfx 
sha512_ssse3 sha256_ssse3 sha1_ssse3 vmxnet3 nvme_auth drm_ttm_helper 
ttm ata_generic pata_acpi serio_raw scsi_dh_rdac scsi_dh_emc 
scsi_dh_alua fuse dm_multipath
[433522.340141] CPU: 0 PID: 1039313 Comm: trigger Not tainted 
6.8.6-200.fc39.x86_64 #1
[433522.340170] Hardware name: VMware, Inc. VMware20,1/440BX Desktop 
Reference Platform, BIOS VMW201.00V.21805430.B64.2305221830 05/22/2023
[433522.340172] RIP: 0010:refcount_warn_saturate+0xe5/0x110
[433522.340179] Code: 42 8e ff 0f 0b c3 cc cc cc cc 80 3d aa 13 ea 01 00 
0f 85 5e ff ff ff 48 c7 c7 f8 8e b7 82 c6 05 96 13 ea 01 01 e8 7b 42 8e 
ff <0f> 0b c3 cc cc cc cc 48 c7 c7 50 8f b7 82 c6 05 7a 13 ea 01 01 e8
[433522.340182] RSP: 0018:ffffc90006b43b60 EFLAGS: 00010282
[433522.340185] RAX: 0000000000000000 RBX: ffff888009bb3ef0 RCX: 
0000000000000027
[433522.340213] RDX: ffff88807be218c8 RSI: 0000000000000001 RDI: 
ffff88807be218c0
[433522.340215] RBP: 0000000000069d70 R08: 0000000000000000 R09: 
ffffc90006b439f0
[433522.340217] R10: ffffc90006b439e8 R11: 0000000000000003 R12: 
ffff8880029ede84
[433522.340219] R13: 0000000000004e20 R14: ffffffff84356dc0 R15: 
ffff888009bb3ef0
[433522.340221] FS:  00007f62c10926c0(0000) GS:ffff88807be00000(0000) 
knlGS:0000000000000000
[433522.340224] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[433522.340226] CR2: 0000000020ccb000 CR3: 000000004628c005 CR4: 
0000000000f70ef0
[433522.340276] PKRU: 55555554
[433522.340278] Call Trace:
[433522.340282]  <TASK>
[433522.340307]  ? refcount_warn_saturate+0xe5/0x110
[433522.340313]  ? __warn+0x81/0x130
[433522.340462]  ? refcount_warn_saturate+0xe5/0x110
[433522.340492]  ? report_bug+0x171/0x1a0
[433522.340723]  ? refcount_warn_saturate+0xe5/0x110
[433522.340731]  ? handle_bug+0x3c/0x80
[433522.340781]  ? exc_invalid_op+0x17/0x70
[433522.340785]  ? asm_exc_invalid_op+0x1a/0x20
[433522.340838]  ? refcount_warn_saturate+0xe5/0x110
[433522.340843]  tcp_twsk_unique+0x186/0x190
[433522.340945]  __inet_check_established+0x176/0x2d0
[433522.340974]  __inet_hash_connect+0x74/0x7d0
[433522.340980]  ? __pfx___inet_check_established+0x10/0x10
[433522.340983]  tcp_v4_connect+0x278/0x530
[433522.340989]  __inet_stream_connect+0x10f/0x3d0
[433522.341019]  inet_stream_connect+0x3a/0x60
[433522.341024]  __sys_connect+0xa8/0xd0
[433522.341186]  __x64_sys_connect+0x18/0x20
[433522.341190]  do_syscall_64+0x83/0x170
[433522.341195]  ? __count_memcg_events+0x4d/0xc0
[433522.341334]  ? count_memcg_events.constprop.0+0x1a/0x30
[433522.341385]  ? handle_mm_fault+0xa2/0x360
[433522.341412]  ? do_user_addr_fault+0x304/0x670
[433522.341442]  ? clear_bhb_loop+0x55/0xb0
[433522.341446]  ? clear_bhb_loop+0x55/0xb0
[433522.341449]  ? clear_bhb_loop+0x55/0xb0
[433522.341453]  entry_SYSCALL_64_after_hwframe+0x78/0x80
[433522.341458] RIP: 0033:0x7f62c11a885d
[433522.341685] Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 
48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 
05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d a3 45 0c 00 f7 d8 64 89 01 48
[433522.341688] RSP: 002b:00007f62c1091e58 EFLAGS: 00000296 ORIG_RAX: 
000000000000002a
[433522.341691] RAX: ffffffffffffffda RBX: 0000000020ccb004 RCX: 
00007f62c11a885d
[433522.341693] RDX: 0000000000000010 RSI: 0000000020ccb000 RDI: 
0000000000000003
[433522.341695] RBP: 00007f62c1091e90 R08: 0000000000000000 R09: 
0000000000000000
[433522.341696] R10: 0000000000000000 R11: 0000000000000296 R12: 
00007f62c10926c0
[433522.341698] R13: ffffffffffffff88 R14: 0000000000000000 R15: 
00007ffe237885b0
[433522.341702]  </TASK>
[433522.341703] ---[ end trace 0000000000000000 ]---
[433522.341709] ------------[ cut here ]------------
[433522.341710] refcount_t: underflow; use-after-free.
[433522.341720] WARNING: CPU: 0 PID: 1039313 at lib/refcount.c:28 
refcount_warn_saturate+0xbe/0x110
[433522.341727] Modules linked in: binfmt_misc nft_fib_inet nft_fib_ipv4 
nft_fib_ipv6 nft_fib nft_reject_inet nf_reject_ipv4 nf_reject_ipv6 
nft_reject nft_ct nft_chain_nat nf_nat nf_conntrack nf_defrag_ipv6 
nf_defrag_ipv4 rfkill nf_tables nfnetlink qrtr vsock_loopback 
vmw_vsock_virtio_transport_common vmw_vsock_vmci_transport vsock 
intel_rapl_msr intel_rapl_common intel_uncore_frequency_common 
intel_pmc_core snd_ens1371 intel_vsec pmt_telemetry snd_ac97_codec 
pmt_class rapl gameport vmw_balloon snd_rawmidi snd_seq_device sunrpc 
ac97_bus snd_pcm snd_timer snd soundcore vfat fat vmw_vmci i2c_piix4 
joydev loop zram xfs crct10dif_pclmul crc32_pclmul crc32c_intel nvme 
polyval_clmulni polyval_generic nvme_core ghash_clmulni_intel vmwgfx 
sha512_ssse3 sha256_ssse3 sha1_ssse3 vmxnet3 nvme_auth drm_ttm_helper 
ttm ata_generic pata_acpi serio_raw scsi_dh_rdac scsi_dh_emc 
scsi_dh_alua fuse dm_multipath
[433522.341820] CPU: 0 PID: 1039313 Comm: trigger Tainted: G        W 
     6.8.6-200.fc39.x86_64 #1
[433522.341823] Hardware name: VMware, Inc. VMware20,1/440BX Desktop 
Reference Platform, BIOS VMW201.00V.21805430.B64.2305221830 05/22/2023
[433522.341825] RIP: 0010:refcount_warn_saturate+0xbe/0x110
[433522.341829] Code: 01 01 e8 c5 42 8e ff 0f 0b c3 cc cc cc cc 80 3d cc 
13 ea 01 00 75 85 48 c7 c7 28 8f b7 82 c6 05 bc 13 ea 01 01 e8 a2 42 8e 
ff <0f> 0b c3 cc cc cc cc 80 3d aa 13 ea 01 00 0f 85 5e ff ff ff 48 c7
[433522.341831] RSP: 0018:ffffc90006b43b80 EFLAGS: 00010282
[433522.341834] RAX: 0000000000000000 RBX: 0000000000004e20 RCX: 
0000000000000027
[433522.341836] RDX: ffff88807be218c8 RSI: 0000000000000001 RDI: 
ffff88807be218c0
[433522.341837] RBP: ffff888009a640c0 R08: 0000000000000000 R09: 
ffffc90006b43a10
[433522.341839] R10: ffffc90006b43a08 R11: 0000000000000003 R12: 
ffff8880029ede84
[433522.341840] R13: 000000000000204e R14: ffffffff84356dc0 R15: 
ffff888009bb3ef0
[433522.341842] FS:  00007f62c10926c0(0000) GS:ffff88807be00000(0000) 
knlGS:0000000000000000
[433522.341844] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[433522.341846] CR2: 0000000020ccb000 CR3: 000000004628c005 CR4: 
0000000000f70ef0
[433522.341886] PKRU: 55555554
[433522.341887] Call Trace:
[433522.341889]  <TASK>
[433522.341890]  ? refcount_warn_saturate+0xbe/0x110
[433522.341894]  ? __warn+0x81/0x130
[433522.341899]  ? refcount_warn_saturate+0xbe/0x110
[433522.341903]  ? report_bug+0x171/0x1a0
[433522.341907]  ? console_unlock+0x78/0x120
[433522.341977]  ? handle_bug+0x3c/0x80
[433522.341981]  ? exc_invalid_op+0x17/0x70
[433522.342007]  ? asm_exc_invalid_op+0x1a/0x20
[433522.342011]  ? refcount_warn_saturate+0xbe/0x110
[433522.342015]  __inet_check_established+0x24d/0x2d0
[433522.342019]  __inet_hash_connect+0x74/0x7d0
[433522.342023]  ? __pfx___inet_check_established+0x10/0x10
[433522.342026]  tcp_v4_connect+0x278/0x530
[433522.342031]  __inet_stream_connect+0x10f/0x3d0
[433522.342035]  inet_stream_connect+0x3a/0x60
[433522.342039]  __sys_connect+0xa8/0xd0
[433522.342044]  __x64_sys_connect+0x18/0x20
[433522.342048]  do_syscall_64+0x83/0x170
[433522.342051]  ? __count_memcg_events+0x4d/0xc0
[433522.342054]  ? count_memcg_events.constprop.0+0x1a/0x30
[433522.342058]  ? handle_mm_fault+0xa2/0x360
[433522.342060]  ? do_user_addr_fault+0x304/0x670
[433522.342065]  ? clear_bhb_loop+0x55/0xb0
[433522.342068]  ? clear_bhb_loop+0x55/0xb0
[433522.342071]  ? clear_bhb_loop+0x55/0xb0
[433522.342074]  entry_SYSCALL_64_after_hwframe+0x78/0x80
[433522.342077] RIP: 0033:0x7f62c11a885d
[433522.342083] Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 
48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 
05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d a3 45 0c 00 f7 d8 64 89 01 48
[433522.342085] RSP: 002b:00007f62c1091e58 EFLAGS: 00000296 ORIG_RAX: 
000000000000002a
[433522.342087] RAX: ffffffffffffffda RBX: 0000000020ccb004 RCX: 
00007f62c11a885d
[433522.342089] RDX: 0000000000000010 RSI: 0000000020ccb000 RDI: 
0000000000000003
[433522.342091] RBP: 00007f62c1091e90 R08: 0000000000000000 R09: 
0000000000000000
[433522.342092] R10: 0000000000000000 R11: 0000000000000296 R12: 
00007f62c10926c0
[433522.342093] R13: ffffffffffffff88 R14: 0000000000000000 R15: 
00007ffe237885b0
[433522.342096]  </TASK>
[433522.342097] ---[ end trace 0000000000000000 ]---
[435060.554199] ------------[ cut here ]------------
[435060.554243] refcount_t: decrement hit 0; leaking memory.
[435060.554261] WARNING: CPU: 2 PID: 879478 at lib/refcount.c:31 
refcount_warn_saturate+0xff/0x110
[435060.554278] Modules linked in: binfmt_misc nft_fib_inet nft_fib_ipv4 
nft_fib_ipv6 nft_fib nft_reject_inet nf_reject_ipv4 nf_reject_ipv6 
nft_reject nft_ct nft_chain_nat nf_nat nf_conntrack nf_defrag_ipv6 
nf_defrag_ipv4 rfkill nf_tables nfnetlink qrtr vsock_loopback 
vmw_vsock_virtio_transport_common vmw_vsock_vmci_transport vsock 
intel_rapl_msr intel_rapl_common intel_uncore_frequency_common 
intel_pmc_core snd_ens1371 intel_vsec pmt_telemetry snd_ac97_codec 
pmt_class rapl gameport vmw_balloon snd_rawmidi snd_seq_device sunrpc 
ac97_bus snd_pcm snd_timer snd soundcore vfat fat vmw_vmci i2c_piix4 
joydev loop zram xfs crct10dif_pclmul crc32_pclmul crc32c_intel nvme 
polyval_clmulni polyval_generic nvme_core ghash_clmulni_intel vmwgfx 
sha512_ssse3 sha256_ssse3 sha1_ssse3 vmxnet3 nvme_auth drm_ttm_helper 
ttm ata_generic pata_acpi serio_raw scsi_dh_rdac scsi_dh_emc 
scsi_dh_alua fuse dm_multipath
[435060.554426] CPU: 2 PID: 879478 Comm: trigger Tainted: G        W 
   6.8.6-200.fc39.x86_64 #1
[435060.554431] Hardware name: VMware, Inc. VMware20,1/440BX Desktop 
Reference Platform, BIOS VMW201.00V.21805430.B64.2305221830 05/22/2023
[435060.554433] RIP: 0010:refcount_warn_saturate+0xff/0x110
[435060.554439] Code: f8 8e b7 82 c6 05 96 13 ea 01 01 e8 7b 42 8e ff 0f 
0b c3 cc cc cc cc 48 c7 c7 50 8f b7 82 c6 05 7a 13 ea 01 01 e8 61 42 8e 
ff <0f> 0b c3 cc cc cc cc 66 2e 0f 1f 84 00 00 00 00 00 90 90 90 90 90
[435060.554442] RSP: 0018:ffffc90005e2bb50 EFLAGS: 00010286
[435060.554445] RAX: 0000000000000000 RBX: 0000000000004e20 RCX: 
0000000000000027
[435060.554448] RDX: ffff88807bea18c8 RSI: 0000000000000001 RDI: 
ffff88807bea18c0
[435060.554450] RBP: ffff8880274d9bc0 R08: 0000000000000000 R09: 
ffffc90005e2b9e0
[435060.554451] R10: ffffc90005e2b9d8 R11: 0000000000000003 R12: 
ffff8880029ede84
[435060.554453] R13: 000000000000204e R14: ffffffff84356dc0 R15: 
ffff888009bb2738
[435060.554456] FS:  00007f102ab566c0(0000) GS:ffff88807be80000(0000) 
knlGS:0000000000000000
[435060.554458] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[435060.554460] CR2: 0000000020ccb000 CR3: 000000004e184003 CR4: 
0000000000f70ef0
[435060.554601] PKRU: 55555554
[435060.554603] Call Trace:
[435060.554607]  <TASK>
[435060.554608]  ? refcount_warn_saturate+0xff/0x110
[435060.554614]  ? __warn+0x81/0x130
[435060.554625]  ? refcount_warn_saturate+0xff/0x110
[435060.554630]  ? report_bug+0x171/0x1a0
[435060.554638]  ? console_unlock+0x78/0x120
[435060.554670]  ? handle_bug+0x3c/0x80
[435060.554676]  ? exc_invalid_op+0x17/0x70
[435060.554682]  ? asm_exc_invalid_op+0x1a/0x20
[435060.554694]  ? refcount_warn_saturate+0xff/0x110
[435060.554699]  __inet_check_established+0x29b/0x2d0
[435060.554707]  __inet_hash_connect+0x74/0x7d0
[435060.554712]  ? __pfx___inet_check_established+0x10/0x10
[435060.554716]  tcp_v4_connect+0x278/0x530
[435060.554723]  __inet_stream_connect+0x10f/0x3d0
[435060.554729]  inet_stream_connect+0x3a/0x60
[435060.554734]  __sys_connect+0xa8/0xd0
[435060.554744]  __x64_sys_connect+0x18/0x20
[435060.554748]  do_syscall_64+0x83/0x170
[435060.554752]  ? __switch_to_asm+0x3e/0x70
[435060.554826]  ? finish_task_switch.isra.0+0x94/0x2f0
[435060.554835]  ? __schedule+0x3f4/0x1530
[435060.554865]  ? __count_memcg_events+0x4d/0xc0
[435060.554871]  ? __rseq_handle_notify_resume+0xa9/0x4f0
[435060.554946]  ? count_memcg_events.constprop.0+0x1a/0x30
[435060.554953]  ? switch_fpu_return+0x50/0xe0
[435060.555065]  ? clear_bhb_loop+0x55/0xb0
[435060.555070]  ? clear_bhb_loop+0x55/0xb0
[435060.555073]  ? clear_bhb_loop+0x55/0xb0
[435060.555077]  entry_SYSCALL_64_after_hwframe+0x78/0x80
[435060.555082] RIP: 0033:0x7f102ac6c85d
[435060.555141] Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 
48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 
05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d a3 45 0c 00 f7 d8 64 89 01 48
[435060.555143] RSP: 002b:00007f102ab55e58 EFLAGS: 00000296 ORIG_RAX: 
000000000000002a
[435060.555147] RAX: ffffffffffffffda RBX: 0000000020ccb004 RCX: 
00007f102ac6c85d
[435060.555149] RDX: 0000000000000010 RSI: 0000000020ccb000 RDI: 
0000000000000003
[435060.555151] RBP: 00007f102ab55e90 R08: 0000000000000000 R09: 
0000000000000000
[435060.555153] R10: 0000000000000000 R11: 0000000000000296 R12: 
00007f102ab566c0
[435060.555154] R13: ffffffffffffff88 R14: 0000000000000000 R15: 
00007ffc83d0fa70
[435060.555158]  </TASK>
[435060.555160] ---[ end trace 0000000000000000 ]---

-- 
Anderson Nascimento

