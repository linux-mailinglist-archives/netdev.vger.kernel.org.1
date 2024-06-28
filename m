Return-Path: <netdev+bounces-107658-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 217DC91BD29
	for <lists+netdev@lfdr.de>; Fri, 28 Jun 2024 13:11:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9C72F280EB2
	for <lists+netdev@lfdr.de>; Fri, 28 Jun 2024 11:11:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8876B154C0D;
	Fri, 28 Jun 2024 11:10:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="VVfbtUf9"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64F4C152526
	for <netdev@vger.kernel.org>; Fri, 28 Jun 2024 11:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719573059; cv=none; b=K3kyndbcSBANu8nulg6xXEdmtXmSQo5+qDntwbroei3PIMpnSumL2sVCtP7E2sU9mVZXFYZBm5j4zE9feAcyct+wYAADO9L1faUzUP4VzYbT/BG2/EpSm9H0xYrpkKhTGDKKfjxV6dSCEPGF+DucKb2XoolCE28RDZm52vbbWZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719573059; c=relaxed/simple;
	bh=aeuPkt2FmOUR8Wcs8dI6wb5Fa9AWfs3MjFQAKoCkaxY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=My0j0xMJH8889r+9C7It8fPwftO/kqFYX5VxJYaGrDhMd70VCWVCrjz8WyP6UXluU70LTIbIdEgxGbx+DGH1GptsgoeJj29/3J2TueFIRYQrNOTRviXSj0zRY4WNvTvOxzPGPq4jmJFVoTXnd+Q+XYHBGzuZjGlrlkCb1Uuna/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=VVfbtUf9; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-57d1782679fso667200a12.0
        for <netdev@vger.kernel.org>; Fri, 28 Jun 2024 04:10:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1719573055; x=1720177855; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:user-agent
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=iHtL6DATh/NrMzjZxryLTozHCZx/l7WILIyCIjdcof8=;
        b=VVfbtUf9jkLEmeSlXkhAMEtUp2immJakaYjO5HNjT7ZBE3YHvxpfo0K83pBMbl2WWy
         uNpviMec88vJjabbpjtUvWVW2k3Ni4iiuqlxN8arO0S38AzTnCXYO80xD/jvoji8Dkw0
         zX6wxZRAvVLSJqPyjMsRRRvsF7Uw1202WzYntShES9V14U1ygo129CZxqCZKyurce64p
         fywyED1Nq8YBWmb8ez9FbDEQBf8wr9X7eLkaRT+GC+9QUI/ucjmIUwLK4wJ2MVimPX0L
         rbkLo0Br6ZfW/rQKbgQBjxWLLlkED9Sfk0r7nj3CkjYdxyI0ioaQL2AQ1FYJM5R7UEEn
         WXlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719573055; x=1720177855;
        h=content-transfer-encoding:mime-version:message-id:date:user-agent
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iHtL6DATh/NrMzjZxryLTozHCZx/l7WILIyCIjdcof8=;
        b=kTuIH8NnhLoDfkj0guHQpt18b3clgpmKBXpCVEO6Ik58ADR4EfKyMr85cUaGGIP1Uq
         ufXGYLkQfmtnl7Y7hror6l7MEF2hPxZhmlsaEtxWrm6Wszqnt411KyURJGW3qo8GcGh0
         Wz3rZQcdNNFX176CeFdY3r8msBor9E0eMrD646IWw/5gw8K5Y4G2dMUzwE86i1q+xlIL
         6PsNKQ9vYsW4kAnACaVzpq9NFGpNdOCjGSGzksBfLH9GUSv2omF+DP1lwoHVdDrR9dJM
         iqYOVnBhzSUQkMwUtAzdUinPgLG/6dFB61ZTqema4RM6OZyJbl4CnxaD/lxpiX3rn+S0
         PPRA==
X-Gm-Message-State: AOJu0Yws9/hUQAlKsqMzXoLpOhTCCmqCSlNqQAk8gkOZZ4miL8FjZp+f
	WgJQDxBXJY2G91dlrrmSkNlEeHji6QlimidyFuteYN2APvfvDzaLFRJqT8hYbCNbX/dPwLNKWeg
	RQfM=
X-Google-Smtp-Source: AGHT+IFCN+nXRt1qDPVRJedR9A+tox3a+2A1y70uZaLmwnnr8vYA3iz9/7tRopr75LN6CwLp7UIukg==
X-Received: by 2002:a50:c34d:0:b0:57d:4bd:7315 with SMTP id 4fb4d7f45d1cf-57d4bd80e2bmr11462827a12.20.1719573055048;
        Fri, 28 Jun 2024 04:10:55 -0700 (PDT)
Received: from cloudflare.com ([2a09:bac5:5063:2432::39b:48])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-58612c834ecsm882514a12.12.2024.06.28.04.10.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jun 2024 04:10:54 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
To: netdev@vger.kernel.org
Cc: kernel-team@cloudflare.com
Subject: [FYI] Input route ref count underflow since probably 6.6.22
User-Agent: mu4e 1.12.4; emacs 29.1
Date: Fri, 28 Jun 2024 13:10:53 +0200
Message-ID: <87ikxtfhky.fsf@cloudflare.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Hi,

We've observed an unbalanced dst_release() on an input route in v6.6.y.
First noticed in 6.6.22. Or at least that is how far back our logs go.

We have just started looking into it and don't have much context yet,
except that:

1. the issue is architecture agnostic, seen both on x86_64 and arm64;
2. the backtrace, we realize, doesn't point to the source of problem,
   it's just where the ref count underflow manifests itself;
3. while have out-of-tree modules, they are for the crypto subsystem.

We will follow up as we collect more info on this, but we would
appreciate any hints or pointers to potential suspects, if anything
comes to mind.

Decoded warning reports follow.

Thanks,
-jkbs

* arm64

------------[ cut here ]------------
rcuref - imbalanced put()
WARNING: CPU: 20 PID: 180350 at lib/rcuref.c:267 rcuref_put_slowpath (lib/r=
curef.c:267 (discriminator 1))
Modules linked in: overlay mptcp_diag xsk_diag raw_diag unix_diag af_packet=
_diag netlink_diag nft_compat esp4 xt_hashlimit ip_set_hash_netport xt_leng=
th nf_conntrack_netlink nft_fwd_netdev nf_dup_netdev xfrm_interface xfrm6_t=
unnel nft_numgen nft_log nft_limit dummy ip_gre gre cls_bpf xfrm_user xfrm_=
algo fou6 ip6_tunnel tunnel6 ipip mpls_gso mpls_iptunnel mpls_router sit tu=
nnel4 fou ip_tunnel ip6_udp_tunnel udp_tunnel nft_ct nf_tables zstd zram zs=
malloc xgene_edac sch_ingress tcp_diag udp_diag inet_diag veth tun tcp_bbr =
sch_fq dm_thin_pool dm_persistent_data dm_bio_prison dm_bufio ip6t_REJECT n=
f_reject_ipv6 ip6table_filter ip6table_mangle ip6table_raw ip6table_securit=
y ip6table_nat ip6_tables xt_LOG nf_log_syslog ipt_REJECT nf_reject_ipv4 xt=
_tcpmss iptable_filter xt_TCPMSS xt_bpf xt_limit xt_multiport xt_NFLOG nfne=
tlink_log xt_connbytes xt_connlabel xt_statistic xt_mark xt_connmark xt_con=
ntrack iptable_mangle xt_nat iptable_nat nf_nat xt_owner xt_set xt_comment =
xt_tcpudp xt_CT nf_conntrack nf_defrag_ipv6
nf_defrag_ipv4 iptable_raw ip_set_hash_ip ip_set_hash_net ip_set raid0 md_m=
od dm_crypt trusted asn1_encoder tee algif_skcipher af_alg 8021q garp mrp s=
tp llc nvme_fabrics acpi_ipmi mlx5_core crct10dif_ce ghash_ce ipmi_ssif mlx=
fw sha2_ce sha256_arm64 ipmi_devintf nvme sha1_ce xhci_pci tls tiny_power_b=
utton arm_spe_pmu ipmi_msghandler xhci_hcd nvme_core psample button i2c_des=
ignware_platform i2c_designware_core cppc_cpufreq arm_dsu_pmu tpm_tis tpm_t=
is_core fuse dm_mod dax nfnetlink efivarfs ip_tables x_tables bcmcrypt(O) a=
es_neon_bs aes_neon_blk aes_ce_blk aes_ce_cipher [last unloaded: kheaders]
CPU: 20 PID: 180350 Comm: napi/iconduit-g Tainted: G           O       6.6.=
32-cloudflare-2024.5.16 #1
Hardware name: GIGABYTE R152-P30-CD/MP32-AR1-00, BIOS F33e (SCP: 2.10.20230=
517) 02/21/2024
pstate: 60400009 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=3D--)
pc : rcuref_put_slowpath (lib/rcuref.c:267 (discriminator 1))
lr : rcuref_put_slowpath (lib/rcuref.c:267 (discriminator 1))
sp : ffff8000cb6eb760
x29: ffff8000cb6eb760 x28: 00000000f0d32f50 x27: ffff080223064cf0
x26: 0000000000000001 x25: ffffbea2e405703c x24: 00000000ce087c9f
x23: 0000000000000000 x22: ffff080223064cf0 x21: ffff0831525c1e00
x20: ffff07ff8a3eef00 x19: ffff0831525c1e40 x18: 0000000000000004
x17: 0000000000000002 x16: 0000000000000001 x15: 0000000000000000
x14: 0000000000000000 x13: 2928747570206465 x12: ffff087d3edbffa8
x11: ffff087d3eb00000 x10: ffff087d3edc0000 x9 : ffffbea2e35e7c78
x8 : 0000000000000001 x7 : 00000000000bffe8 x6 : c0000000ffff7fff
x5 : ffff087d3f0eee88 x4 : 0000000000000000 x3 : ffff49da5a45f000
x2 : 0000000000000000 x1 : 0000000000000000 x0 : ffff081eaa143f00
Call trace:
rcuref_put_slowpath (lib/rcuref.c:267 (discriminator 1))
dst_release (include/linux/rcuref.h:94 include/linux/rcuref.h:150 net/core/=
dst.c:166)
rt_cache_route (net/ipv4/route.c:1497)
rt_set_nexthop.isra.0 (net/ipv4/route.c:1604 (discriminator 1))
ip_route_input_slow (include/net/lwtunnel.h:140 net/ipv4/route.c:1873 net/i=
pv4/route.c:2152 net/ipv4/route.c:2338)
ip_route_input_noref (net/ipv4/route.c:2485 net/ipv4/route.c:2496)
ip_rcv_finish_core.isra.0 (net/ipv4/ip_input.c:367 (discriminator 1))
ip_sublist_rcv (net/ipv4/ip_input.c:613 (discriminator 1) net/ipv4/ip_input=
.c:639 (discriminator 1))
ip_list_rcv (net/ipv4/ip_input.c:675)
__netif_receive_skb_list_core (net/core/dev.c:5598 net/core/dev.c:5646)
netif_receive_skb_list_internal (net/core/dev.c:5700 net/core/dev.c:5789)
napi_complete_done (include/linux/list.h:37 (discriminator 2) include/net/g=
ro.h:449 (discriminator 2) include/net/gro.h:444 (discriminator 2) net/core=
/dev.c:6129 (discriminator 2))
veth_poll (drivers/net/veth.c:1008 (discriminator 1)) veth
__napi_poll (net/core/dev.c:6559)
bpf_trampoline_6442466812+0xbc/0x1000
__napi_poll (net/core/dev.c:6546)
napi_threaded_poll (include/linux/netpoll.h:89 net/core/dev.c:6703)
kthread (kernel/kthread.c:388)
ret_from_fork (arch/arm64/kernel/entry.S:862)
---[ end trace 0000000000000000 ]---


* x86_64

------------[ cut here ]------------
rcuref - imbalanced put()
WARNING: CPU: 18 PID: 164489 at lib/rcuref.c:267 rcuref_put_slowpath (lib/r=
curef.c:267 (discriminator 1))
Modules linked in: macvlan overlay nft_compat esp4 xt_hashlimit ip_set_hash=
_netport xt_length nf_conntrack_netlink nft_fwd_netdev nf_dup_netdev xfrm_i=
nterface xfrm6_tunnel nft_numgen nft_log nft_limit dummy ip_gre gre cls_bpf=
 xfrm_user xfrm_algo fou6 ip6_tunnel tunnel6 ipip nft_ct nf_tables mpls_gso=
 mpls_iptunnel mpls_router sit tunnel4 fou ip_tunnel ip6_udp_tunnel udp_tun=
nel zstd zram zsmalloc sch_ingress tcp_diag udp_diag inet_diag veth tun tcp=
_bbr sch_fq dm_thin_pool dm_persistent_data dm_bio_prison dm_bufio ip6t_REJ=
ECT nf_reject_ipv6 ip6table_filter ip6table_mangle ip6table_raw ip6table_se=
curity ip6table_nat ip6_tables xt_LOG nf_log_syslog ipt_REJECT nf_reject_ip=
v4 xt_tcpmss iptable_filter xt_TCPMSS xt_bpf xt_limit xt_multiport xt_NFLOG=
 nfnetlink_log xt_connbytes xt_connlabel xt_statistic xt_mark xt_connmark x=
t_conntrack iptable_mangle xt_nat iptable_nat nf_nat xt_owner xt_set xt_com=
ment xt_tcpudp xt_CT nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 iptable_raw=
 ip_set_hash_ip ip_set_hash_net ip_set raid0
md_mod essiv dm_crypt trusted asn1_encoder tee 8021q garp mrp stp llc nvme_=
fabrics amd64_edac ipmi_ssif kvm_amd kvm irqbypass crc32_pclmul crc32c_inte=
l sha512_ssse3 sha256_ssse3 sha1_ssse3 aesni_intel xhci_pci acpi_ipmi mlx5_=
core rapl mlxfw nvme ipmi_si tls ipmi_devintf tiny_power_button xhci_hcd nv=
me_core ccp psample i2c_piix4 ipmi_msghandler button fuse dm_mod dax nfnetl=
ink efivarfs ip_tables x_tables bcmcrypt(O) crypto_simd cryptd [last unload=
ed: kheaders]
CPU: 18 PID: 164489 Comm: napi/iconduit-g Kdump: loaded Tainted: G         =
  O       6.6.32-cloudflare-2024.5.16 #1
Hardware name: GIGABYTE R162-Z12-CD1/MZ12-HD4-CD, BIOS M06-sig 12/28/2022
RIP: 0010:rcuref_put_slowpath (lib/rcuref.c:267 (discriminator 1))
Code: 31 c0 eb da 80 3d 23 a5 38 02 00 74 0a c7 03 00 00 00 e0 31 c0 eb c7 =
48 c7 c7 ef cd 0a 90 c6 05 09 a5 38 02 01 e8 69 cc 9c ff <0f> 0b eb df cc c=
c cc cc cc 90 90 90 90 90 90 90 90 90 90 90 90 90
All code
=3D=3D=3D=3D=3D=3D=3D=3D
   0:   31 c0                   xor    %eax,%eax
   2:   eb da                   jmp    0xffffffffffffffde
   4:   80 3d 23 a5 38 02 00    cmpb   $0x0,0x238a523(%rip)        # 0x238a=
52e
   b:   74 0a                   je     0x17
   d:   c7 03 00 00 00 e0       movl   $0xe0000000,(%rbx)
  13:   31 c0                   xor    %eax,%eax
  15:   eb c7                   jmp    0xffffffffffffffde
  17:   48 c7 c7 ef cd 0a 90    mov    $0xffffffff900acdef,%rdi
  1e:   c6 05 09 a5 38 02 01    movb   $0x1,0x238a509(%rip)        # 0x238a=
52e
  25:   e8 69 cc 9c ff          call   0xffffffffff9ccc93
  2a:*  0f 0b                   ud2             <-- trapping instruction
  2c:   eb df                   jmp    0xd
  2e:   cc                      int3
  2f:   cc                      int3
  30:   cc                      int3
  31:   cc                      int3
  32:   cc                      int3
  33:   90                      nop
  34:   90                      nop
  35:   90                      nop
  36:   90                      nop
  37:   90                      nop
  38:   90                      nop
  39:   90                      nop
  3a:   90                      nop
  3b:   90                      nop
  3c:   90                      nop
  3d:   90                      nop
  3e:   90                      nop
  3f:   90                      nop

Code starting with the faulting instruction
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
   0:   0f 0b                   ud2
   2:   eb df                   jmp    0xffffffffffffffe3
   4:   cc                      int3
   5:   cc                      int3
   6:   cc                      int3
   7:   cc                      int3
   8:   cc                      int3
   9:   90                      nop
   a:   90                      nop
   b:   90                      nop
   c:   90                      nop
   d:   90                      nop
   e:   90                      nop
   f:   90                      nop
  10:   90                      nop
  11:   90                      nop
  12:   90                      nop
  13:   90                      nop
  14:   90                      nop
  15:   90                      nop
RSP: 0018:ffffc90047a23908 EFLAGS: 00010282
RAX: 0000000000000000 RBX: ffff888cedda4e80 RCX: 0000000000000027
RDX: ffff88a43f720748 RSI: 0000000000000001 RDI: ffff88a43f720740
RBP: ffffc90047a23988 R08: 0000000000000000 R09: ffffc90047a23798
R10: ffff88e06f2cc1a8 R11: 0000000000000003 R12: ffff888cedda4e40
R13: ffffc90047a23a98 R14: 0000000000000000 R15: 000000000a8cf4d5
FS:  0000000000000000(0000) GS:ffff88a43f700000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f6e59776000 CR3: 000000417ef0c005 CR4: 0000000000770ee0
PKRU: 55555554
Call Trace:
<TASK>
? rcuref_put_slowpath (lib/rcuref.c:267 (discriminator 1))
? __warn (kernel/panic.c:681)
? rcuref_put_slowpath (lib/rcuref.c:267 (discriminator 1))
? report_bug (lib/bug.c:180 lib/bug.c:219)
? srso_alias_return_thunk (arch/x86/lib/retpoline.S:175)
? prb_read_valid (kernel/printk/printk_ringbuffer.c:1941)
? handle_bug (arch/x86/kernel/traps.c:237)
? exc_invalid_op (arch/x86/kernel/traps.c:258 (discriminator 1))
? asm_exc_invalid_op (arch/x86/include/asm/idtentry.h:568)
? rcuref_put_slowpath (lib/rcuref.c:267 (discriminator 1))
? rcuref_put_slowpath (lib/rcuref.c:267 (discriminator 1))
dst_release (arch/x86/include/asm/preempt.h:95 include/linux/rcuref.h:151 n=
et/core/dst.c:166)
rt_cache_route (net/ipv4/route.c:1497)
rt_set_nexthop.isra.0 (net/ipv4/route.c:1604 (discriminator 1))
ip_route_input_slow (include/net/lwtunnel.h:140 net/ipv4/route.c:1873 net/i=
pv4/route.c:2152 net/ipv4/route.c:2338)
? srso_alias_return_thunk (arch/x86/lib/retpoline.S:175)
ip_route_input_noref (net/ipv4/route.c:2485 net/ipv4/route.c:2496)
ip_rcv_finish_core.isra.0 (net/ipv4/ip_input.c:367 (discriminator 1))
ip_sublist_rcv (net/ipv4/ip_input.c:613 (discriminator 1) net/ipv4/ip_input=
.c:639 (discriminator 1))
? __pfx_ip_rcv_finish (net/ipv4/ip_input.c:436)
ip_list_rcv (net/ipv4/ip_input.c:675)
__netif_receive_skb_list_core (net/core/dev.c:5598 (discriminator 3) net/co=
re/dev.c:5646 (discriminator 3))
? srso_alias_return_thunk (arch/x86/lib/retpoline.S:175)
netif_receive_skb_list_internal (net/core/dev.c:5700 net/core/dev.c:5789)
napi_complete_done (include/linux/list.h:37 (discriminator 2) include/net/g=
ro.h:449 (discriminator 2) include/net/gro.h:444 (discriminator 2) net/core=
/dev.c:6129 (discriminator 2))
veth_poll (drivers/net/veth.c:1008 (discriminator 1)) veth
? srso_alias_return_thunk (arch/x86/lib/retpoline.S:175)
? psi_group_change (kernel/sched/psi.c:873)
? srso_alias_return_thunk (arch/x86/lib/retpoline.S:175)
? __perf_event_task_sched_in (arch/x86/include/asm/atomic.h:23 include/linu=
x/atomic/atomic-arch-fallback.h:444 include/linux/atomic/atomic-instrumente=
d.h:33 kernel/events/core.c:4014)
? srso_alias_return_thunk (arch/x86/lib/retpoline.S:175)
? finish_task_switch.isra.0 (arch/x86/include/asm/irqflags.h:42 arch/x86/in=
clude/asm/irqflags.h:77 kernel/sched/sched.h:1386 kernel/sched/core.c:5138 =
kernel/sched/core.c:5256)
__napi_poll (net/core/dev.c:6559)
bpf_trampoline_6442482065+0x79/0x1000
? schedule (arch/x86/include/asm/preempt.h:85 (discriminator 13) kernel/sch=
ed/core.c:6773 (discriminator 13))
__napi_poll (net/core/dev.c:6546)
napi_threaded_poll (include/linux/netpoll.h:89 net/core/dev.c:6703)
? __pfx_napi_threaded_poll (net/core/dev.c:6686)
kthread (kernel/kthread.c:388)
? __pfx_kthread (kernel/kthread.c:341)
ret_from_fork (arch/x86/kernel/process.c:153)
? __pfx_kthread (kernel/kthread.c:341)
ret_from_fork_asm (arch/x86/entry/entry_64.S:314)
</TASK>
---[ end trace 0000000000000000 ]---

