Return-Path: <netdev+bounces-82061-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4181788C393
	for <lists+netdev@lfdr.de>; Tue, 26 Mar 2024 14:37:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4C456B21C6D
	for <lists+netdev@lfdr.de>; Tue, 26 Mar 2024 13:37:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74B3F74437;
	Tue, 26 Mar 2024 13:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GZ6HZRCb"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A0F5125C9
	for <netdev@vger.kernel.org>; Tue, 26 Mar 2024 13:37:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711460245; cv=none; b=iD++zNVeAb2pUa0rPqAqhydfpqgYxfDPGwLFyWEwg+0c5jdy8W2rsHuRPYVrKPk6eHoupGwd/aKEl5rP98tMKtXsz6TePlDCr1pBryj8AbTqKggXjvHoPN/HzB3tKBMaqfzs0juzCqLd1zk9bWq0nJco+OUuxi1/i6+c7manR0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711460245; c=relaxed/simple;
	bh=MMgVDupJfX/bu0a2pfHYYTpYrt17kqQDyaJkoqkpKV0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QNhvJQMA9t8SQpbaH3fKnp/N05guJKN5awYLG+byVGR/jn1jDd1+xnxHu1UcAmDWBBYmH0Pp0eKvKck60z+aLmiILx48TJsxJRYq92ZkGB91+DyI7UZhkIevZoesvvbavdrKf1e3wLbv7UEUxEz9RiHE4ZwkdTVwRxaj4mHP/CI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GZ6HZRCb; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-56bde8ea904so12458a12.0
        for <netdev@vger.kernel.org>; Tue, 26 Mar 2024 06:37:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1711460241; x=1712065041; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eNueMYNBuCciO/kx2UfzR7J8q8vIM6kZz0r3vAEVIVs=;
        b=GZ6HZRCbivlKfmwa3ceHodAsCGdZlxFr+aUS48js1IuotKM/OmrpYFobWRq95387ZK
         7pE5/6xMLuCoKhjZvrnhuuaUgu4gdOWRt/QrOxCCtnfVfx4oFHopoOPmFlemNE7rQQju
         dk8DmhLC7zoHaRU//tHi4WKpH6L3/MF+6YyRgVYk7QH79wcEEgKSCe5Cr1DeiixGL2AT
         I/r8rNt7xZq9Rnm122+YFGWE1JczZEy7JiVFfCfuF1SMgXnPQb8XAieHwtV882VCETX4
         vxI4m4kUsdGdIzTKJQAlvZQJOh3Lop0PLr60WblQbUYwEXqSKwIYwGNpMlcFmZXCOMjL
         yVYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711460241; x=1712065041;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eNueMYNBuCciO/kx2UfzR7J8q8vIM6kZz0r3vAEVIVs=;
        b=q4ylTItA3oOR2/H+x0Lsz9ngj++MlwCF78cydVkMvzafHS7Iq1wv4EetX1MXQxAxt1
         Sb6dGgcxcslFXUfx2jQ570svzlpKF7jeM+oKyTWk0GNw2TabjHa2HnhXPHx/+uryd/sB
         tYxZ6q2aTBVmy7YZnt+4Ib47UmFGWNKvzFKcZqQ2ul3816MXqHbIN1IpEgDOCrQolwPJ
         1vxqzDX1HvGryHXRDyPDLkb9WjXL9uc+uTkfSR1m3YFKTXdv35QLBUeJ5vlLEzPhyoR0
         tmKCQYQ2CbZlzztrYzlur4PTqsVsYDv2FjdihLLM2Ac7pK4OMysubDpFb+byksQ1XWWg
         59JA==
X-Forwarded-Encrypted: i=1; AJvYcCWnjNlwbusKxe+Yqwnjo3WHXjJCkXi7LgPswnZsxGSVKesX2YeBtPUUckmJRbEvP6gdFsNvsZ9AeOOHz204ireoFE+Xv5bF
X-Gm-Message-State: AOJu0YxYHYKm8R/zGexY0i6v1q29qmsqdCP4/8CFOKxUSIsYgqTdh9ia
	RhRcFeC+n32Pjceg7rH4PUHKo3KFCkZgR0FUwJVaN/lD8jpEYRCbnJOc3gPc/1qucNbSLbCNhz5
	wcv5WnwVCqBPRpsaCVpi4CsT5MoF4txX69QX9
X-Google-Smtp-Source: AGHT+IHMT+1TLpJEW38+w5X3GSRhvqKZ6m7vUAvu5/ghZLxGoVBkjEvgDVeHOWc9dE2qV4SHl8rjAYHqkMqBMQ7cRik=
X-Received: by 2002:aa7:c384:0:b0:56c:c20:6b40 with SMTP id
 k4-20020aa7c384000000b0056c0c206b40mr149748edq.0.1711460241191; Tue, 26 Mar
 2024 06:37:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240322122407.1329861-1-edumazet@google.com> <171111663201.19374.16295682760005551863.git-patchwork-notify@kernel.org>
 <CAADnVQJy+0=6ZuAz-7dwOPK3sN2QrPiAcxhtojh8p65j0TRNhg@mail.gmail.com>
 <CANn89iLSOeFGNogYMHbeLRC5kOwwArMz3d5_2hZmBn6fibyUhw@mail.gmail.com>
 <CAADnVQ+OhsBetPT0avuNVsEwru13UtMjX1U_6_u6xROXBBn-Yg@mail.gmail.com>
 <ZgGmQu09Z9xN7eOD@google.com> <d9531955-06ad-ccdd-d3d0-4779400090ba@iogearbox.net>
In-Reply-To: <d9531955-06ad-ccdd-d3d0-4779400090ba@iogearbox.net>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 26 Mar 2024 14:37:10 +0100
Message-ID: <CANn89iJFOR5ucef0bH=BTKrLOAGsUtF8tM=cYNDTg+=gHDntvw@mail.gmail.com>
Subject: Re: [PATCH net] bpf: Don't redirect too small packets
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: Stanislav Fomichev <sdf@google.com>, Alexei Starovoitov <alexei.starovoitov@gmail.com>, 
	Guillaume Nault <gnault@redhat.com>, patchwork-bot+netdevbpf@kernel.org, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Alexei Starovoitov <ast@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Andrii Nakryiko <andrii@kernel.org>, Network Development <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>, 
	Eric Dumazet <eric.dumazet@gmail.com>, 
	syzbot+9e27778c0edc62cb97d8@syzkaller.appspotmail.com, 
	Willem de Bruijn <willemb@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 26, 2024 at 1:46=E2=80=AFPM Daniel Borkmann <daniel@iogearbox.n=
et> wrote:
>
> On 3/25/24 5:28 PM, Stanislav Fomichev wrote:
> > On 03/25, Alexei Starovoitov wrote:
> >> On Mon, Mar 25, 2024 at 6:33=E2=80=AFAM Eric Dumazet <edumazet@google.=
com> wrote:
> >>>
> >>> On Sat, Mar 23, 2024 at 4:02=E2=80=AFAM Alexei Starovoitov
> >>> <alexei.starovoitov@gmail.com> wrote:
> >>>>
> >>>> On Fri, Mar 22, 2024 at 7:10=E2=80=AFAM <patchwork-bot+netdevbpf@ker=
nel.org> wrote:
> >>>>>
> >>>>> Hello:
> >>>>>
> >>>>> This patch was applied to bpf/bpf.git (master)
> >>>>> by Daniel Borkmann <daniel@iogearbox.net>:
> >>>>>
> >>>>> On Fri, 22 Mar 2024 12:24:07 +0000 you wrote:
> >>>>>> Some drivers ndo_start_xmit() expect a minimal size, as shown
> >>>>>> by various syzbot reports [1].
> >>>>>>
> >>>>>> Willem added in commit 217e6fa24ce2 ("net: introduce device min_he=
ader_len")
> >>>>>> the missing attribute that can be used by upper layers.
> >>>>>>
> >>>>>> We need to use it in __bpf_redirect_common().
> >>>>
> >>>> This patch broke empty_skb test:
> >>>> $ test_progs -t empty_skb
> >>>>
> >>>> test_empty_skb:FAIL:ret: veth ETH_HLEN+1 packet ingress
> >>>> [redirect_ingress] unexpected ret: veth ETH_HLEN+1 packet ingress
> >>>> [redirect_ingress]: actual -34 !=3D expected 0
> >>>> test_empty_skb:PASS:err: veth ETH_HLEN+1 packet ingress [redirect_eg=
ress] 0 nsec
> >>>> test_empty_skb:FAIL:ret: veth ETH_HLEN+1 packet ingress
> >>>> [redirect_egress] unexpected ret: veth ETH_HLEN+1 packet ingress
> >>>> [redirect_egress]: actual -34 !=3D expected 1
> >>>>
> >>>> And looking at the test I think it's not a test issue.
> >>>> This check
> >>>> if (unlikely(skb->len < dev->min_header_len))
> >>>> is rejecting more than it should.
> >>>>
> >>>> So I reverted this patch for now.
> >>>
> >>> OK, it seems I missed __bpf_rx_skb() vs __bpf_tx_skb(), but even if I
> >>> move my sanity test in __bpf_tx_skb(),
> >>> the bpf test program still fails, I am suspecting the test needs to b=
e adjusted.
> >>>
> >>>
> >>>
> >>> diff --git a/net/core/filter.c b/net/core/filter.c
> >>> index 745697c08acb3a74721d26ee93389efa81e973a0..e9c0e2087a08f1d8afd2c=
3e8e7871ddc9231b76d
> >>> 100644
> >>> --- a/net/core/filter.c
> >>> +++ b/net/core/filter.c
> >>> @@ -2128,6 +2128,12 @@ static inline int __bpf_tx_skb(struct
> >>> net_device *dev, struct sk_buff *skb)
> >>>                  return -ENETDOWN;
> >>>          }
> >>>
> >>> +       if (unlikely(skb->len < dev->min_header_len)) {
> >>> +               pr_err_once("__bpf_tx_skb skb->len=3D%u <
> >>> dev(%s)->min_header_len(%u)\n", skb->len, dev->name,
> >>> dev->min_header_len);
> >>> +               DO_ONCE_LITE(skb_dump, KERN_ERR, skb, false);
> >>> +               kfree_skb(skb);
> >>> +               return -ERANGE;
> >>> +       } // Note: this is before we change skb->dev
> >>>          skb->dev =3D dev;
> >>>          skb_set_redirected_noclear(skb, skb_at_tc_ingress(skb));
> >>>          skb_clear_tstamp(skb);
> >>>
> >>>
> >>> -->
> >>>
> >>>
> >>> test_empty_skb:FAIL:ret: veth ETH_HLEN+1 packet ingress
> >>> [redirect_egress] unexpected ret: veth ETH_HLEN+1 packet ingress
> >>> [redirect_egress]: actual -34 !=3D expected 1
> >>>
> >>> [   58.382051] __bpf_tx_skb skb->len=3D1 < dev(veth0)->min_header_len=
(14)
> >>> [   58.382778] skb len=3D1 headroom=3D78 headlen=3D1 tailroom=3D113
> >>>                 mac=3D(64,14) net=3D(78,-1) trans=3D-1
> >>>                 shinfo(txflags=3D0 nr_frags=3D0 gso(size=3D0 type=3D0=
 segs=3D0))
> >>>                 csum(0x0 ip_summed=3D0 complete_sw=3D0 valid=3D0 leve=
l=3D0)
> >>>                 hash(0x0 sw=3D0 l4=3D0) proto=3D0x7f00 pkttype=3D0 ii=
f=3D0
> >>
> >> Hmm. Something is off.
> >> That test creates 15 byte skb.
> >> It's not obvious to me how it got reduced to 1.
> >> Something stripped L2 header and the prog is trying to redirect
> >> such skb into veth that expects skb with L2 ?
> >>
> >> Stan,
> >> please take a look.
> >> Since you wrote that test.
> >
> > Sure. Daniel wants to take a look on a separate thread, so we can sync
> > up. Tentatively, seems like the failure is in the lwt path that does
> > indeed drop the l2.
>
> If we'd change the test into the below, the tc and empty_skb tests pass.
> run_lwt_bpf() calls into skb_do_redirect() which has L2 stripped, and thu=
s
> skb->len is 1 in this test. We do use skb_mac_header_len() also in other
> tc BPF helpers, so perhaps s/skb->len/skb_mac_header_len(skb)/ is the bes=
t
> way forward..
>
> static int __bpf_redirect_common(struct sk_buff *skb, struct net_device *=
dev,
>                                   u32 flags)
> {
>          /* Verify that a link layer header is carried */
>          if (unlikely(skb->mac_header >=3D skb->network_header || skb->le=
n =3D=3D 0)) {
>                  kfree_skb(skb);
>                  return -ERANGE;
>          }
>
>          if (unlikely(skb_mac_header_len(skb) < dev->min_header_len)) {

Unfortunately this will not prevent frames with skb->len =3D=3D 1 to reach
an Ethernet driver ndo_start_xmit()

At ndo_start_xmit(), we do not look where the MAC header supposedly
starts in the skb, we only use skb->data

I have a syzbot repro using team driver, so I added the following part in t=
eam :

diff --git a/drivers/net/team/team.c b/drivers/net/team/team.c
index 0a44bbdcfb7b9f30a0c27b700246501c5eba322f..75e5ef585a8f05b35cfddbae0bf=
c377864e6e38c
100644
--- a/drivers/net/team/team.c
+++ b/drivers/net/team/team.c
@@ -1714,6 +1714,11 @@ static netdev_tx_t team_xmit(struct sk_buff
*skb, struct net_device *dev)
        bool tx_success;
        unsigned int len =3D skb->len;

+       if (len < 14) {
+               pr_err_once("team_xmit(len=3D%u)\n", len);
+               DO_ONCE_LITE(skb_dump, KERN_ERR, skb, false);
+               WARN_ON_ONCE(1);
+       }
        tx_success =3D team_queue_override_transmit(team, skb);
        if (!tx_success)
                tx_success =3D team->ops.transmit(team, skb);


And I get (with your suggestion instead of skb->len)

mac=3D(78,0) net=3D(78,-1) trans=3D-1
shinfo(txflags=3D0 nr_frags=3D0 gso(size=3D0 type=3D0 segs=3D0))
csum(0x0 ip_summed=3D0 complete_sw=3D0 valid=3D0 level=3D0)
hash(0x0 sw=3D0 l4=3D0) proto=3D0x88a8 pkttype=3D3 iif=3D0
[   41.126553] dev name=3Dteam0 feat=3D0x0000e0064fddfbe9
[   41.127132] skb linear:   00000000: 55
[   41.128487] ------------[ cut here ]------------
[   41.128551] WARNING: CPU: 2 PID: 1880 at
drivers/net/team/team.c:1720 team_xmit (drivers/net/team/team.c:1720
(discriminator 1))
[   41.129072] Modules linked in: macsec macvtap macvlan hsr wireguard
curve25519_x86_64 libcurve25519_generic libchacha20poly1305
chacha_x86_64 libchacha poly1305_x86_64 batman_adv dummy bridge sr_mod
cdrom evdev pcspkr i2c_piix4 9pnet_virtio 9p netfs 9pnet
[   41.129613] CPU: 2 PID: 1880 Comm: b330650301 Not tainted 6.8.0-virtme #=
238
[   41.129664] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996),
BIOS 1.16.3-debian-1.16.3-2 04/01/2014
[   41.129780] RIP: 0010:team_xmit (drivers/net/team/team.c:1720
(discriminator 1))
[ 41.129847] Code: 41 54 53 44 8b 7f 70 48 89 fb 41 83 ff 0d 77 1c 80
3d a0 24 8d 01 00 0f 84 0d 01 00 00 80 3d 92 24 8d 01 00 0f 84 e3 00
00 00 <0f> 0b 41 80 be 21 0b 00 00 00 0f 84 9d 00 00 00 0f b7 43 7c 66
85
All code
=3D=3D=3D=3D=3D=3D=3D=3D
   0: 41 54                push   %r12
   2: 53                    push   %rbx
   3: 44 8b 7f 70          mov    0x70(%rdi),%r15d
   7: 48 89 fb              mov    %rdi,%rbx
   a: 41 83 ff 0d          cmp    $0xd,%r15d
   e: 77 1c                ja     0x2c
  10: 80 3d a0 24 8d 01 00 cmpb   $0x0,0x18d24a0(%rip)        # 0x18d24b7
  17: 0f 84 0d 01 00 00    je     0x12a
  1d: 80 3d 92 24 8d 01 00 cmpb   $0x0,0x18d2492(%rip)        # 0x18d24b6
  24: 0f 84 e3 00 00 00    je     0x10d
  2a:* 0f 0b                ud2 <-- trapping instruction
  2c: 41 80 be 21 0b 00 00 cmpb   $0x0,0xb21(%r14)
  33: 00
  34: 0f 84 9d 00 00 00    je     0xd7
  3a: 0f b7 43 7c          movzwl 0x7c(%rbx),%eax
  3e: 66                    data16
  3f: 85                    .byte 0x85

Code starting with the faulting instruction
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
   0: 0f 0b                ud2
   2: 41 80 be 21 0b 00 00 cmpb   $0x0,0xb21(%r14)
   9: 00
   a: 0f 84 9d 00 00 00    je     0xad
  10: 0f b7 43 7c          movzwl 0x7c(%rbx),%eax
  14: 66                    data16
  15: 85                    .byte 0x85
[   41.129902] RSP: 0018:ffffa4210433b938 EFLAGS: 00000246
[   41.129945] RAX: 0000000000000000 RBX: ffffa4210858a300 RCX: 00000000000=
00000
[   41.129961] RDX: 0000000000000000 RSI: 00000000ffff7fff RDI: 00000000000=
00001
[   41.129975] RBP: ffffa4210433b960 R08: 0000000000000000 R09: ffffa421043=
3b630
[   41.129989] R10: 0000000000000001 R11: ffffffff8407d340 R12: 00000000000=
00000
[   41.130004] R13: ffffa4210ecee000 R14: ffffa4210ece4000 R15: 00000000000=
00001
[   41.130074] FS:  00007f91d9549740(0000) GS:ffffa42fffa80000(0000)
knlGS:0000000000000000
[   41.130095] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   41.130140] CR2: 00007f8953077fb0 CR3: 0000000104f42000 CR4: 00000000000=
006f0
[   41.130229] Call Trace:
[   41.130331]  <TASK>
[   41.130530] ? show_regs (arch/x86/kernel/dumpstack.c:479)
[   41.130598] ? __warn (kernel/panic.c:694)
[   41.130611] ? team_xmit (drivers/net/team/team.c:1720 (discriminator 1))
[   41.130625] ? report_bug (lib/bug.c:180 lib/bug.c:219)
[   41.130640] ? handle_bug (arch/x86/kernel/traps.c:239)
[   41.130653] ? exc_invalid_op (arch/x86/kernel/traps.c:260 (discriminator=
 1))
[   41.130665] ? asm_exc_invalid_op (./arch/x86/include/asm/idtentry.h:621)
[   41.130700] ? team_xmit (drivers/net/team/team.c:1720 (discriminator 1))
[   41.130714] ? team_xmit (drivers/net/team/team.c:1719 (discriminator 6))
[   41.130734] dev_hard_start_xmit (./include/linux/netdevice.h:4903
./include/linux/netdevice.h:4917 net/core/dev.c:3531
net/core/dev.c:3547)
[   41.130768] __dev_queue_xmit (./include/linux/netdevice.h:3287
(discriminator 25) net/core/dev.c:4336 (discriminator 25))
[   41.130780] ? kmalloc_reserve (net/core/skbuff.c:580 (discriminator 4))
[   41.130796] ? pskb_expand_head (net/core/skbuff.c:2292)
[   41.130815] __bpf_redirect (./include/linux/netdevice.h:3287
(discriminator 25) net/core/filter.c:2143 (discriminator 25)
net/core/filter.c:2172 (discriminator 25) net/core/filter.c:2196
(discriminator 25))
[   41.130825] bpf_clone_redirect (net/core/filter.c:2467
(discriminator 1) net/core/filter.c:2439 (discriminator 1))
[   41.130841] bpf_prog_9845f5eee09e82c6+0x61/0x66
[   41.130948] ? bpf_ksym_find (./include/linux/rbtree_latch.h:113
./include/linux/rbtree_latch.h:208 kernel/bpf/core.c:734)
[   41.130963] ? is_bpf_text_address
(./arch/x86/include/asm/preempt.h:84 (discriminator 13)
./include/linux/rcupdate.h:97 (discriminator 13)
./include/linux/rcupdate.h:813 (discriminator 13)
kernel/bpf/core.c:769 (discriminator 13))
[   41.130976] ? kernel_text_address (kernel/extable.c:125
(discriminator 1) kernel/extable.c:94 (discriminator 1))
[   41.130989] ? __kernel_text_address (kernel/extable.c:79 (discriminator =
1))
[   41.131002] ? unwind_get_return_address
(arch/x86/kernel/unwind_frame.c:19 (discriminator 1))
[   41.131014] ? __pfx_stack_trace_consume_entry (kernel/stacktrace.c:83)
[   41.131028] ? arch_stack_walk (arch/x86/kernel/stacktrace.c:26)
[   41.131044] ? stack_depot_save_flags (lib/stackdepot.c:675)
[   41.131062] ? ktime_get (kernel/time/timekeeping.c:292
kernel/time/timekeeping.c:388 kernel/time/timekeeping.c:848)
[   41.131076] bpf_test_run (./include/linux/bpf.h:1234
./include/linux/filter.h:657 ./include/linux/filter.h:664
net/bpf/test_run.c:425)
[   41.131087] ? security_sk_alloc (security/security.c:4662 (discriminator=
 13))

