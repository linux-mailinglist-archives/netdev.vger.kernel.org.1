Return-Path: <netdev+bounces-157728-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 589C2A0B63F
	for <lists+netdev@lfdr.de>; Mon, 13 Jan 2025 13:02:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 628F016506A
	for <lists+netdev@lfdr.de>; Mon, 13 Jan 2025 12:02:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E9A41E885;
	Mon, 13 Jan 2025 12:02:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="SMyNYKeI"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BF821CAA7F
	for <netdev@vger.kernel.org>; Mon, 13 Jan 2025 12:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736769752; cv=none; b=mAR19q+yTbrj6ySLFNXLZbGwLQZvsv2tqXUuu6o/HsT+pvnGL6hC64M7ov+2PICvkf/mz36rRMsNBzX2Vqa7iwIkKbM0MH0KbS8iH/IfakD105KEt8pbth7LkQnIh70Nx6udosiNb33NeX0Pi1GQf19lNJNo8t30E6CJqUyHOEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736769752; c=relaxed/simple;
	bh=Flj316Y2BLhgAxSoK7vaEiUOhj2mvW8zAMlLMKh7rHo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=EXCSsPKaydy3xu/CVZrely/wfYjxTXK9XrGl5spPTqw0eqMHtHGk4DN78psxj5eRyQbOj6EMUZskV7Xv0EQxrsQ/NXqbLbyF3U3+M2tm235/O772yunNn85QyUUc0v1zcdnJEH2HuBM+Ww9nWwcsUOBJ/onG6M1VS49wmhH5lck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=SMyNYKeI; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5d414b8af7bso7556630a12.0
        for <netdev@vger.kernel.org>; Mon, 13 Jan 2025 04:02:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1736769748; x=1737374548; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MRwZPAZd4LYxbTR3OwKxibsFVdTPwEFp2BhtPfmLOWQ=;
        b=SMyNYKeI1UGaTUQ7yHXOWlBJibtbxbEAjTIVNDCWS9LGi5BTRJnkXvzytOKli1l0av
         Je5vItuFcF3gIhhPwor9HzmJyPOlIri1zViola55RkY/NDoG2YG3LYuDx8OW9JXzAmvK
         bno/aev20VcVJ+fAva9q+R0YmuA/ce1oT/GnwtVAjMTB2xZbEaHtUBGGpYaT0HUWkt2j
         TO0zwt1trNMmLzHDPcFVbeBPLDqqZfZHAYIbh0EjyChv01EoB8+89Lddqun7Ltjkw7DT
         aLYtF5pj9vOe7w2AJD0sJtxdQ7USXoSVaqaCHwCsOajl/bZUO++5BswaKqfOlGfyBYVr
         GaCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736769748; x=1737374548;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MRwZPAZd4LYxbTR3OwKxibsFVdTPwEFp2BhtPfmLOWQ=;
        b=Oqdi0lclDw9WGhqa69WE8bywfi1k89emFK3DNbix8e0TWK8UdAksHiXMGF/TaZFvwr
         ntANsQ4Kdd2zzRl3pA1ZzQimMuiimZjvPUgTIW3wZEE2GzH3yc1xHlzzdgSRXnpF2Iq3
         NtQZ/8dBf90GfcrlIolYfrU922/NBcuwEC3dUeCpMjK0WoiVoXnoSmafGpkqeutWPWJq
         lAgAJKI2uYgdAA8om+sDrinIMEY8jSkuvStmy5TSBHnROQFIQPItn5K5xk6LjS/EBfUp
         238GtpXiUIpzmmLuR+QuvfeHM8Vd9dtBdIFUy5pxIoxBCYxtCzjcTcBWs/ELz1PbimdW
         1T/w==
X-Gm-Message-State: AOJu0YyDfDTS2F/skxhKmwoXdboYYXTGNYkLsOTmTn4OJcUl0s3hhpgP
	1/padKYSDftdpO+0ffV8AK1mk90i9sxVBjO4Dsyt5iM9R+wq23XezLuLsYDBhfkzLLNAtM/VrQj
	6
X-Gm-Gg: ASbGncsWg/5w7y4DI2gh3rpE2G3XuBtOVIxxB+bMVl++QBAH+RJgp88t1HVSD/WfuiA
	N8tDl9Nwg2x4a1NE2DN35fNv0A5rQxHSPIoBcl3OHx7Arft6U+j7yQMoFccIPu9YHuHdzHK5R9i
	ud32soC6V4y0QcuPZFOzQdeCqfJT7OLKAYxa0jwO5k1tP1Avn2UhgwqMDarML2XsAd5UEoIyfLv
	xPZs9OcRTFa6lQoI6QHBriPGlriPITpIL9z9Xtm5AxTHMIkMA==
X-Google-Smtp-Source: AGHT+IHkgOP21xVdcu9lOBerDYC+2RXxG/UBbz9TWfUF1XL5+9mwXc5FP7dJAN02g2UO4HeessoroQ==
X-Received: by 2002:a05:6402:2711:b0:5d0:d1e0:8fb2 with SMTP id 4fb4d7f45d1cf-5d972e08710mr4198998a12.11.1736769748352;
        Mon, 13 Jan 2025 04:02:28 -0800 (PST)
Received: from cloudflare.com ([2a09:bac5:506a:2387::38a:4d])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d99046d7d5sm4682390a12.66.2025.01.13.04.02.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jan 2025 04:02:27 -0800 (PST)
From: Jakub Sitnicki <jakub@cloudflare.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org,  kernel-team@cloudflare.com
Subject: Re: [FYI] Input route ref count underflow since probably 6.6.22
In-Reply-To: <87wmm3euwr.fsf@cloudflare.com> (Jakub Sitnicki's message of
	"Tue, 02 Jul 2024 16:21:56 +0200")
References: <87ikxtfhky.fsf@cloudflare.com>
	<20240701163826.76558147@kernel.org> <87wmm3euwr.fsf@cloudflare.com>
Date: Mon, 13 Jan 2025 13:02:24 +0100
Message-ID: <87v7uiexbj.fsf@cloudflare.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 02, 2024 at 04:21 PM +02, Jakub Sitnicki wrote:
> On Mon, Jul 01, 2024 at 04:38 PM -07, Jakub Kicinski wrote:
>> On Fri, 28 Jun 2024 13:10:53 +0200 Jakub Sitnicki wrote:
>>> We've observed an unbalanced dst_release() on an input route in v6.6.y.
>>> First noticed in 6.6.22. Or at least that is how far back our logs go.
>>>=20
>>> We have just started looking into it and don't have much context yet,
>>> except that:
>>>=20
>>> 1. the issue is architecture agnostic, seen both on x86_64 and arm64;
>>> 2. the backtrace, we realize, doesn't point to the source of problem,
>>>    it's just where the ref count underflow manifests itself;
>>> 3. while have out-of-tree modules, they are for the crypto subsystem.
>>>=20
>>> We will follow up as we collect more info on this, but we would
>>> appreciate any hints or pointers to potential suspects, if anything
>>> comes to mind.
>>
>> Hi! Luck would have it the same crash landed on my desk.
>> Did you manage to narrow it down?
>
> Nothing yet. Will keep you posted.

Finally circling back to this to hunt it down...

We've tweaked "imbalanced put()" warning to log the ref count, that is
the result atomic_read(&ref->refcnt) load in rcuref_put_slowpath():

---8<---
diff --git a/lib/rcuref.c b/lib/rcuref.c
index 5ec00a4a64d1..53006542e785 100644
--- a/lib/rcuref.c
+++ b/lib/rcuref.c
@@ -264,7 +264,8 @@ bool rcuref_put_slowpath(rcuref_t *ref)
         * put() operation is imbalanced. Warn, put the reference count bac=
k to
         * DEAD and tell the caller to not deconstruct the object.
         */
-       if (WARN_ONCE(cnt >=3D RCUREF_RELEASED, "rcuref - imbalanced put()"=
)) {
+       if (WARN_ONCE(cnt >=3D RCUREF_RELEASED,
+                     "rcuref - imbalanced put(): refcnt=3D%#x", cnt)) {
                atomic_set(&ref->refcnt, RCUREF_DEAD);
                return false;
        }
--->8---

So far we're only seeing reports with cnt =3D=3D RCUREF_DEAD, for example:

------------[ cut here ]------------
rcuref - imbalanced put(): refcnt=3D0xe0000000
WARNING: CPU: 105 PID: 173613 at lib/rcuref.c:267 rcuref_put_slowpath+0x6d/=
0x80
Modules linked in: overlay mptcp_diag xsk_diag raw_diag unix_diag af_packet=
_diag netlink_diag esp4 xt_hashlimit ip_set_hash_netport nft_compat nf_conn=
track_netlink xfrm_interface xfrm6_tunnel sit nft_numgen nft_log nft_limit =
dummy ip_gre gre xfrm_user xfrm_algo mpls_gso mpls_iptunnel mpls_router fou=
6 ip6_tunnel tunnel6 ipip tunnel4 fou ip_tunnel ip6_udp_tunnel udp_tunnel c=
ls_bpf nft_fwd_netdev nf_dup_netdev nft_ct nf_tables zstd zram zsmalloc sch=
_ingress tcp_diag udp_diag inet_diag veth tun tcp_bbr sch_fq dm_thin_pool d=
m_persistent_data dm_bio_prison dm_bufio ip6t_REJECT nf_reject_ipv6 ip6tabl=
e_filter ip6table_mangle ip6table_raw ip6table_security ip6table_nat ip6_ta=
bles xt_limit xt_LOG nf_log_syslog ipt_REJECT nf_reject_ipv4 xt_multiport x=
t_tcpmss iptable_filter xt_length xt_TCPMSS xt_DSCP xt_bpf xt_NFLOG nfnetli=
nk_log xt_connbytes xt_connlabel xt_statistic xt_connmark xt_conntrack ipta=
ble_mangle xt_mark xt_nat iptable_nat nf_nat xt_owner xt_set xt_comment xt_=
tcpudp xt_CT nf_conntrack nf_defrag_ipv6
 nf_defrag_ipv4 iptable_raw ip_set_hash_ip ip_set_hash_net ip_set raid0 md_=
mod essiv dm_crypt trusted asn1_encoder tee dm_mod dax nvme_fabrics 8021q g=
arp mrp stp llc ipmi_ssif amd64_edac kvm_amd kvm irqbypass crc32_pclmul crc=
32c_intel sha512_ssse3 sha256_ssse3 sha1_ssse3 aesni_intel mlx5_core rapl a=
cpi_ipmi xhci_pci mlxfw nvme ipmi_si ipmi_devintf tls tiny_power_button xhc=
i_hcd ccp i2c_piix4 nvme_core psample ipmi_msghandler button fuse nfnetlink=
 efivarfs ip_tables x_tables bcmcrypt(O) crypto_simd cryptd [last unloaded:=
 kheaders]
CPU: 105 PID: 173613 Comm: napi/iconduit-g Kdump: loaded Tainted: G        =
   O       6.6.69-cloudflare-2025.1.1 #1
Hardware name: HYVE EDGE-METAL-GEN11/HS1811D_Lite, BIOS V0.11-sig 12/23/2022
RIP: 0010:rcuref_put_slowpath+0x6d/0x80
Code: eb da 80 3d 85 0c 37 02 00 74 0a c7 03 00 00 00 e0 31 c0 eb c7 89 c6 =
48 c7 c7 80 41 af b9 c6 05 69 0c 37 02 01 e8 83 46 9b ff <0f> 0b eb dd 66 2=
e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 90 90 90
RSP: 0018:ffffc90042bb7908 EFLAGS: 00010282
RAX: 0000000000000000 RBX: ffff88c88d886f40 RCX: 0000000000000027
RDX: ffff88c81faa0788 RSI: 0000000000000001 RDI: ffff88c81faa0780
RBP: ffffc90042bb7988 R08: 0000000000000000 R09: ffffc90042bb7798
R10: ffff88e04f2cc1a8 R11: 0000000000000003 R12: ffff88c88d886f00
R13: ffffc90042bb7a98 R14: 0000000000000000 R15: 0000000039277c9f
FS:  0000000000000000(0000) GS:ffff88c81fa80000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fc4a9f48000 CR3: 000000306fd7a004 CR4: 0000000000770ee0
PKRU: 55555554
Call Trace:
 <TASK>
 ? rcuref_put_slowpath+0x6d/0x80
 ? __warn+0x81/0x130
 ? rcuref_put_slowpath+0x6d/0x80
 ? report_bug+0x16f/0x1a0
 ? srso_alias_return_thunk+0x5/0xfbef5
 ? prb_read_valid+0x1b/0x30
 ? handle_bug+0x53/0x90
 ? exc_invalid_op+0x17/0x70
 ? asm_exc_invalid_op+0x1a/0x20
 ? rcuref_put_slowpath+0x6d/0x80
 ? rcuref_put_slowpath+0x6d/0x80
 dst_release+0x3d/0xa0
 rt_cache_route+0x6b/0xa0
 rt_set_nexthop.isra.0+0x16c/0x400
 ip_route_input_slow+0x886/0xbe0
 ? srso_alias_return_thunk+0x5/0xfbef5
 ip_route_input_noref+0x95/0xa0
 ip_rcv_finish_core.isra.0+0xc6/0x450
 ip_sublist_rcv+0xe5/0x380
 ? __pfx_ip_rcv_finish+0x10/0x10
 ip_list_rcv+0x165/0x190
 __netif_receive_skb_list_core+0x30f/0x340
 ? srso_alias_return_thunk+0x5/0xfbef5
 netif_receive_skb_list_internal+0x1bd/0x330
 napi_complete_done+0x72/0x200
 veth_poll+0xe4/0x1d0 [veth]
 ? srso_alias_return_thunk+0x5/0xfbef5
 ? psi_group_change+0x177/0x3c0
 ? srso_alias_return_thunk+0x5/0xfbef5
 ? __perf_event_task_sched_in+0x86/0x210
 ? srso_alias_return_thunk+0x5/0xfbef5
 ? finish_task_switch.isra.0+0x85/0x280
 __napi_poll+0x2b/0x1b0
 bpf_trampoline_6442534135+0x7d/0x1000
 ? schedule+0x5e/0xd0
 __napi_poll+0x5/0x1b0
 napi_threaded_poll+0x22c/0x270
 ? __pfx_napi_threaded_poll+0x10/0x10
 kthread+0xe8/0x120
 ? __pfx_kthread+0x10/0x10
 ret_from_fork+0x34/0x50
 ? __pfx_kthread+0x10/0x10
 ret_from_fork_asm+0x1b/0x30
 </TASK>
---[ end trace 0000000000000000 ]---

... which would suggest that we're dealing with a race to release the
last reference! At least I don't see any other explantion for this
state. On paper it could look like (wide text ahead):

refcnt                              CPU 0                                  =
                                 CPU 1
0x00000000 (RCUREF_ONEREF)          dst_release(dst) {                     =
                                 dst_release(dst) {
"                                     rcuref_put(&dst->__rcuref) {         =
                                   rcuref_put(&dst->__rcuref) {
"                                       rcuref_put {                       =
                                     rcuref_put {
"                                         preempt_disable                  =
                                       preempt_disable
"                                         __rcuref_put {                   =
                                       __rcuref_put {
"                                           atomic_add_negative_release(-1,=
 &ref->refcnt)                           ...
0xFFFFFFFF (RCUREF_NOREF)                   rcuref_put_slowpath {          =
                                         ...
"                                             cnt =3D atomic_read(&ref->ref=
cnt)                                       ...
"                                             ...                          =
                                         atomic_add_negative_release(-1, &r=
ef->refcnt)
0xFFFFFFFE (RCUREF_NOREF-1)                   atomic_try_cmpxchg_release(&r=
ef->refcnt, &cnt, RCUREF_DEAD)           ...
0xE0000000 (RCUREF_DEAD)                    } =E2=86=92 false              =
                                                 rcuref_put_slowpath {
"                                         } =E2=86=92 false                =
                                                   cnt =3D atomic_read(&ref=
->refcnt)
"                                         preempt_enable                   =
                                           WARN_ONCE(cnt >=3D RCUREF_RELEAS=
ED, "rcuref - imbalanced put()")
"                                       } =E2=86=92 false                  =
                                                   atomic_set(&ref->refcnt,=
 RCUREF_DEAD)
"                                     } =E2=86=92 false                    =
                                                 } =E2=86=92 false
"                                   }                                      =
                                       } =E2=86=92 false
"                                                                          =
                                       preempt_enable
"                                                                          =
                                     } =E2=86=92 false
"                                                                          =
                                   } =E2=86=92 false
"                                                                          =
                                 }

That's the only new clue so far.

Plan is to add more logging to dump the skb that triggers it or at least
dig out the dst dev name. We need more hints.

Side note - annoyingly, rcuref_put_slowpath is notrace, same as every
*.o under lib/ by default. That makes tracing the "imbalanced put()"
branch impossible when running w/o CONFIG_KPROBE_EVENTS_ON_NOTRACE.
I will see if I can lift that restriction.

