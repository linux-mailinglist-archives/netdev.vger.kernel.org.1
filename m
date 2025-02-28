Return-Path: <netdev+bounces-170704-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BC673A49A04
	for <lists+netdev@lfdr.de>; Fri, 28 Feb 2025 13:55:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 956013B2223
	for <lists+netdev@lfdr.de>; Fri, 28 Feb 2025 12:55:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97DA526B2A9;
	Fri, 28 Feb 2025 12:55:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tu7JV0lP"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ua1-f48.google.com (mail-ua1-f48.google.com [209.85.222.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E12CC26B0BF
	for <netdev@vger.kernel.org>; Fri, 28 Feb 2025 12:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740747352; cv=none; b=cbK9FIQ6bek5JpoC+VpuInqNfvcjKjKTk7NpzPCZIbeho34TASFzAVYVmQtlfr9APvjTe2Vuof/b6ZLGZXgk0DeUbRbJEmp2C4fIUKxb0VY1au0xQRSG/utwiEQ5jGFIhgGM4kwHkpkBygQi6OBQZXMXJ3wbBKS2D/4RmBYxRb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740747352; c=relaxed/simple;
	bh=vMsVrNRBzPLEYe5PxDmCz3OItLDb3WxHzI00WKjjxi4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fqPUeHlXuyGEOAmScxeCl35Lzp2pINEfDSY16zUhXOsGsc+kCOli+AroXq3acEH3gPGWTKIqFC9UQkmPcLAYFe3Y1+bzQnJ9t6wiWtt6myJm3kmzmQHPUWBh26YtskcXXkh1c+TFu2zwaH2dpcMtskWZ3zkOWYSf+d+Yrxycsh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Tu7JV0lP; arc=none smtp.client-ip=209.85.222.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f48.google.com with SMTP id a1e0cc1a2514c-868da0af0fcso891091241.2
        for <netdev@vger.kernel.org>; Fri, 28 Feb 2025 04:55:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740747350; x=1741352150; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hrZMd1bJWa+XP1GyNs3Y9sGcWMTCdySSsxM/ntUpCUQ=;
        b=Tu7JV0lPDBq9Dx0THY4bt7TTy2275a41l8ZQKf4ZYX6GcPCVTE1JeWIbLulvgJ9/0g
         /huJLHfOI6bVmzLalGOUCl4IW6XEpA5KCqw1wJ4+DPFQQyiNJxhBz1Pt86blf1Kkf2Do
         HDmTpHmRhSxl3EG9ZH//6o8+kYqQICQQPzSOQ6S0c6aTqpGNlfPvEOt2QybbChZIr7DW
         VI91yXav+DfZzEtBQIdnEMKHzouCAAQihnXB/CS90ZcOjJFBIV/DXychBQZOm/EqVwdr
         CrDp5LS5HOkj2I6zGgbVDJ3+PkWACoDy8MwxDXrqFJDkGekueNDUFSJGattPjwS+8PLc
         /Q4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740747350; x=1741352150;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hrZMd1bJWa+XP1GyNs3Y9sGcWMTCdySSsxM/ntUpCUQ=;
        b=SO3sY33Y/z117rwuGm32wCpcz6+NDtNxDW+hHWemBs3RWLq+mNEBAWtCXA7FQoWR04
         YWxZT/12VfvxbEaP1vehEHYXk0n72NsErKY3+zJKdwXRFz1VTi9M2SAelCKg6v+P9q+P
         d/k9h4W3j5qjgL+M8BtnLGeFldAitk+ckb3oc6mORi3YmKV7JqXWV/NDcbuKZ9Z0dFzL
         8BkgjvswdMwlhRXLG4GWSBYXKbvDBHfi3MtLi/TcM79NraRGAa/vyUyeTVLhafunTSA6
         C977KYOYaioLXkSLPHmxpbsg+mHC5BFC/xHS6RNcfZrUeKWbmTg6Uc+qpwpDs2YW53QG
         i9WQ==
X-Gm-Message-State: AOJu0YzUkQ9md2rXz1ctK/G3BtYOTGDWfnkup/iD4dIQD/F8mUDMt07u
	Yl7K9FUrLahklrqzFKCkXwSv4qjTIsu7IC0QuQbtXNC6OMzgO0SYmpXICr+IPNTe/SRd6o9pqMe
	i/si/8rDFPqM2FJzoby9nqcl1s8I=
X-Gm-Gg: ASbGncsRpkwG0t7PRL9a2m6vqSo+cwHAVCNyrfMLD8wyaFF7phUTNKhe9yyIQxtQonL
	FtLuEVdpDKfrLNQdVuq7nl0eSI4ua6oGlF79VjqodSzfjgXsQZBZ5YgHIVj20BJkLnV+C8i1/RA
	83v1hEHw==
X-Google-Smtp-Source: AGHT+IHEBGEAQpaCEPPYJ+5D9dXpe94rL+rSmZ90bTnejzEef7aJ0X3gxJYvwLzFFCAq4Ql+I/mOcMfr+49o9nT8jk0=
X-Received: by 2002:a05:6102:2b93:b0:4bb:d062:420 with SMTP id
 ada2fe7eead31-4c0448531ccmr1938212137.1.1740747349660; Fri, 28 Feb 2025
 04:55:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250227164129.1201164-1-razor@blackwall.org> <CAA85sZva1SbT_HDbAHgZEDeCgjcbTX_rBzj-RZQmsvST3Ky3LA@mail.gmail.com>
 <8f1cba95-bedb-4f96-958d-c4f28982bdf2@blackwall.org>
In-Reply-To: <8f1cba95-bedb-4f96-958d-c4f28982bdf2@blackwall.org>
From: Ian Kumlien <ian.kumlien@gmail.com>
Date: Fri, 28 Feb 2025 13:55:38 +0100
X-Gm-Features: AQ5f1Jpw6U2qVFxGmZ80AgDHrOtwldNx91lizWVXcgGPUF-PoSIj4Fj5ZMOwhC8
Message-ID: <CAA85sZvfgZinRUbsXWJeS1kHojb3eZK_T-oanQTvtmLCgd98Lg@mail.gmail.com>
Subject: Re: [PATCH net] be2net: fix sleeping while atomic bugs in be_ndo_bridge_getlink
To: Nikolay Aleksandrov <razor@blackwall.org>
Cc: netdev@vger.kernel.org, Ajit Khaparde <ajit.khaparde@broadcom.com>, 
	Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>, 
	Somnath Kotur <somnath.kotur@broadcom.com>, Andrew Lunn <andrew+netdev@lunn.ch>, davem@davemloft.net, 
	edumazet@google.com, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 28, 2025 at 1:49=E2=80=AFPM Nikolay Aleksandrov <razor@blackwal=
l.org> wrote:
>
> On 2/28/25 14:46, Ian Kumlien wrote:
> > Actually, while you might already have realized this, I didn't quite
> > understand how important this fix seems to be....
> >
>
> You mean the be2net would send broken packets to this other machine with =
mlx5 card?
> Or did I misunderstand you?

That is correct, UDP so I assume it's the wireguard tunnel...

> > From another machine i found this:
> > [l=C3=B6r feb 22 23:46:32 2025] mlx5_core 0000:02:00.1 enp2s0f1np1: hw =
csum failure
> > [l=C3=B6r feb 22 23:46:32 2025] skb len=3D2488 headroom=3D78 headlen=3D=
1480 tailroom=3D0
> >                             mac=3D(64,14) mac_len=3D14 net=3D(78,20) tr=
ans=3D98
> >                             shinfo(txflags=3D0 nr_frags=3D0 gso(size=3D=
1452
> > type=3D393216 segs=3D2))
> >                             csum(0x2baef95d start=3D63837 offset=3D1118=
2
> > ip_summed=3D2 complete_sw=3D0 valid=3D0 level=3D0)
> >                             hash(0xb9a84019 sw=3D0 l4=3D1) proto=3D0x08=
00
> > pkttype=3D0 iif=3D8
> >                             priority=3D0x0 mark=3D0x0 alloc_cpu=3D1 vla=
n_all=3D0x0
> >                             encapsulation=3D0 inner(proto=3D0x0000, mac=
=3D0,
> > net=3D0, trans=3D0)
> > [l=C3=B6r feb 22 23:46:32 2025] dev name=3Denp2s0f1np1 feat=3D0x0e12a1c=
21cd14ba9
> >
> > And:
> > [l=C3=B6r feb 22 23:46:33 2025] skb fraglist:
> > [l=C3=B6r feb 22 23:46:33 2025] skb len=3D1008 headroom=3D106 headlen=
=3D1008 tailroom=3D38
> >                             mac=3D(64,14) mac_len=3D14 net=3D(78,20) tr=
ans=3D98
> >                             shinfo(txflags=3D0 nr_frags=3D0 gso(size=3D=
0
> > type=3D0 segs=3D0))
> >                             csum(0x86f9 start=3D34553 offset=3D0
> > ip_summed=3D2 complete_sw=3D0 valid=3D0 level=3D0)
> >                             hash(0xb9a84019 sw=3D0 l4=3D1) proto=3D0x08=
00
> > pkttype=3D0 iif=3D0
> >                             priority=3D0x0 mark=3D0x0 alloc_cpu=3D1 vla=
n_all=3D0x0
> >                             encapsulation=3D0 inner(proto=3D0x0000, mac=
=3D0,
> > net=3D0, trans=3D0)
> > [l=C3=B6r feb 22 23:46:33 2025] dev name=3Denp2s0f1np1 feat=3D0x0e12a1c=
21cd14ba9
> >
> > Including:
> > [l=C3=B6r feb 22 23:46:34 2025] CPU: 1 UID: 0 PID: 0 Comm: swapper/1 No=
t
> > tainted 6.13.4 #449
> > [l=C3=B6r feb 22 23:46:34 2025] Hardware name: Supermicro Super
> > Server/A2SDi-12C-HLN4F, BIOS 1.9a 12/25/2023
> > [l=C3=B6r feb 22 23:46:34 2025] Call Trace:
> > [l=C3=B6r feb 22 23:46:34 2025]  <IRQ>
> > [l=C3=B6r feb 22 23:46:34 2025]  dump_stack_lvl+0x47/0x70
> > [l=C3=B6r feb 22 23:46:34 2025]  __skb_checksum_complete+0xda/0xf0
> > [l=C3=B6r feb 22 23:46:34 2025]  ? __pfx_csum_partial_ext+0x10/0x10
> > [l=C3=B6r feb 22 23:46:34 2025]  ? __pfx_csum_block_add_ext+0x10/0x10
> > [l=C3=B6r feb 22 23:46:34 2025]  nf_conntrack_udp_packet+0x171/0x260
> > [l=C3=B6r feb 22 23:46:34 2025]  nf_conntrack_in+0x391/0x590
> > [l=C3=B6r feb 22 23:46:34 2025]  nf_hook_slow+0x3c/0xf0
> > [l=C3=B6r feb 22 23:46:34 2025]  nf_hook_slow_list+0x70/0xf0
> > [l=C3=B6r feb 22 23:46:34 2025]  ip_sublist_rcv+0x1ee/0x200
> > [l=C3=B6r feb 22 23:46:34 2025]  ? __pfx_ip_rcv_finish+0x10/0x10
> > [l=C3=B6r feb 22 23:46:34 2025]  ip_list_rcv+0xf8/0x130
> > [l=C3=B6r feb 22 23:46:34 2025]  __netif_receive_skb_list_core+0x24c/0x=
270
> > [l=C3=B6r feb 22 23:46:34 2025]  netif_receive_skb_list_internal+0x18f/=
0x2b0
> > [l=C3=B6r feb 22 23:46:34 2025]  ? mlx5e_handle_rx_cqe_mpwrq+0x116/0x21=
0
> > [l=C3=B6r feb 22 23:46:34 2025]  napi_complete_done+0x65/0x260
> > [l=C3=B6r feb 22 23:46:34 2025]  mlx5e_napi_poll+0x172/0x760
> > [l=C3=B6r feb 22 23:46:34 2025]  __napi_poll+0x26/0x160
> > [l=C3=B6r feb 22 23:46:34 2025]  net_rx_action+0x173/0x300
> > [l=C3=B6r feb 22 23:46:34 2025]  ? notifier_call_chain+0x54/0xc0
> > [l=C3=B6r feb 22 23:46:34 2025]  ? atomic_notifier_call_chain+0x30/0x40
> > [l=C3=B6r feb 22 23:46:34 2025]  handle_softirqs+0xcd/0x270
> > [l=C3=B6r feb 22 23:46:34 2025]  irq_exit_rcu+0x85/0xa0
> > [l=C3=B6r feb 22 23:46:34 2025]  common_interrupt+0x81/0xa0
> > [l=C3=B6r feb 22 23:46:34 2025]  </IRQ>
> > [l=C3=B6r feb 22 23:46:34 2025]  <TASK>
> > [l=C3=B6r feb 22 23:46:34 2025]  asm_common_interrupt+0x22/0x40
> > [l=C3=B6r feb 22 23:46:34 2025] RIP: 0010:cpuidle_enter_state+0xbc/0x43=
0
> > [l=C3=B6r feb 22 23:46:34 2025] Code: 77 02 00 00 e8 65 31 ec fe e8 60 =
f8
> > ff ff 49 89 c5 0f 1f 44 00 00 31 ff e8 a1 68 eb fe 45 84 ff 0f 85 49
> > 02 00 00 fb 45 85 f6 <0f> 88 8d 01 00 00 49 63 ce 4c 8b 14 24 48 8d 04
> > 49 48 8d 14 81 48
> > [l=C3=B6r feb 22 23:46:34 2025] RSP: 0018:ffffb504000b7e88 EFLAGS: 0000=
0202
> > [l=C3=B6r feb 22 23:46:34 2025] RAX: ffff9c0a2fa40000 RBX: ffff9c0a2fa7=
6e60
> > RCX: 0000000000000000
> > [l=C3=B6r feb 22 23:46:34 2025] RDX: 0000252e1dcfee30 RSI: fffffff3c1a6=
5ecc
> > RDI: 0000000000000000
> > [l=C3=B6r feb 22 23:46:34 2025] RBP: 0000000000000002 R08: 000000000000=
0000
> > R09: 00000000000001f6
> > [l=C3=B6r feb 22 23:46:34 2025] R10: 0000000000000018 R11: ffff9c0a2fa6=
c3ac
> > R12: ffffffffaac2de60
> > [l=C3=B6r feb 22 23:46:34 2025] R13: 0000252e1dcfee30 R14: 000000000000=
0002
> > R15: 0000000000000000
> > [l=C3=B6r feb 22 23:46:34 2025]  ? cpuidle_enter_state+0xaf/0x430
> > [l=C3=B6r feb 22 23:46:34 2025]  cpuidle_enter+0x24/0x40
> > [l=C3=B6r feb 22 23:46:34 2025]  do_idle+0x16e/0x1b0
> > [l=C3=B6r feb 22 23:46:34 2025]  cpu_startup_entry+0x20/0x30
> > [l=C3=B6r feb 22 23:46:34 2025]  start_secondary+0xf3/0x100
> > [l=C3=B6r feb 22 23:46:34 2025]  common_startup_64+0x13e/0x148
> > [l=C3=B6r feb 22 23:46:34 2025]  </TASK>
> > ---
> >
> > Asking gemini for help identified the machine in the basement as the
> > culprit - so it seems like it could send corrupt data - i haven't had
> > a closer look though
> >
>
> Interesting. :)

Yeah... While i don't trust AI as such, if i take this at face value
it's quite interesting:
---
What we can tell:

* The packet is an IPv4 UDP packet.
* The hardware checksum failure indicates a potential data corruption
issue. This could be caused by:
** A faulty network cable.
** A problem with the network card itself.
** Issues with network switches or routers along the path.
** Software bugs.
* The packet was large and was handled using GSO.
* The hex dump allows for a very deep packet inspection, in order to
diagnose the problem.
* The IP source and destination addresses can be obtained from the hex
dump, and then the traffic can be analysed.
---

> > On Thu, Feb 27, 2025 at 5:41=E2=80=AFPM Nikolay Aleksandrov <razor@blac=
kwall.org> wrote:
> >>

