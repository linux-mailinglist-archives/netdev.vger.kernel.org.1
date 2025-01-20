Return-Path: <netdev+bounces-159763-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1ED43A16C4B
	for <lists+netdev@lfdr.de>; Mon, 20 Jan 2025 13:24:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E49667A0763
	for <lists+netdev@lfdr.de>; Mon, 20 Jan 2025 12:24:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BE4B1DF73A;
	Mon, 20 Jan 2025 12:24:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Oy7doxxc"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25D8F1917F9
	for <netdev@vger.kernel.org>; Mon, 20 Jan 2025 12:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737375867; cv=none; b=gfR48eu0zIau5Y4DTSzrf22MRU69u0Am88HiJCMpBLDZx2gz/tR9xRGPDOoELfk7vPGILohvXVA/RUvzwPHfd/+SLom7/o+bN+HLAPh/k7BFWqqSkkFkE+aKohR2B6SNuMOnjn2E1NnVvA6lLBvKoOfdY/QaJxRRbef3/VFd/hI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737375867; c=relaxed/simple;
	bh=KdbwHcah6sTz8olAYqBUSVom7xqeNSTQ690Ht20GJf0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=blN+rvpTi1czJTXfXBz8LuCO3LzcpLLpp1LGC222GHk0CcuPSzk6koTc48XRfXbPMoDj/byBNKBrv9inV9ZMdJNRtsLgGN1uISBMjjj77hKndfAb0xC91JMyLeIkzugyBEGog5W5bBHz1y2H4xyxha+VIU2WSjoCodxVPIxrI5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Oy7doxxc; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5d3bbb0f09dso7669710a12.2
        for <netdev@vger.kernel.org>; Mon, 20 Jan 2025 04:24:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1737375863; x=1737980663; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BbRVW49eRpySYXnJf/prePVX80U2Pvk/lwg/6wWQjDw=;
        b=Oy7doxxcnaYuMXLRRijwRli9ZCtppm8/a2ksdHhSOlBqo+QVN5mZxAIKGsyi4jYcpx
         nTqqD4Azrsm0GRhN1TSSOuunkvvNn5DmY6iP2ggzfGcffyUG2+kuCKRI+8NCIheQKl6B
         2h8sK8MrBkDrpztkGUTQ2Rp59v2jg1t2gNjsi8uPJoDC0z53POeAsJs0EvqkkvH0LG4T
         WPZFPIVuYpJ8rVzjqvmhs8Wk/kNa3JV3JMDFhBgJeELrwv6Yb2uhTIn9UaIaxEJ5TrlZ
         7lj6lzeSuHjYTrC9qVu/5u2irTrF5QlVYRUwTnA4sZdtPTe7j1oOag+K1VM0WNqH0Jnt
         HDYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737375863; x=1737980663;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BbRVW49eRpySYXnJf/prePVX80U2Pvk/lwg/6wWQjDw=;
        b=q5lZCKJf0iYQ1c7geXJ+1r4sSL5/lezzenA6YzpvNhXjo0EeHjUnjzcivLciKnpXfs
         byP8kduIY661IR1q31lrkrsaA0sD1JFb0YKjjZ1uSH153IKyXzSHn7Bwarr4Btq1hlxa
         9ppQ4OGTwJz36vics3QpekFxlldAVHDHxJFtCPlg6YrIbbgRQu6N+iEE6JAwzX77u45K
         jP+BOt3jr3FcIkCYvDFyPzqKhl2eqkR7gnJ8kAg+7EqF3FON4Vxa9YADVzofl7+kTQgS
         X7E9IrohCXD+SK8qtEH0jXoqE/PcdViUz0P9dpZtXWYRnsqmySTH3My0NLYIqQSJ4eiY
         jljg==
X-Forwarded-Encrypted: i=1; AJvYcCVnUibv1S5CLglHgRdS2dcbxkoATZ0GqEGQrci0QMBY/BFO7qDCdQXr2oqf3oAZQhjTC+GUjG4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyC+Ctc1a9SXShp3c5uG0BMl+snrubwgVinNIDU3c8D2ZHhiK4C
	PDYfPjdVGSD128nJ623fTXPXsn54CqVqrN+OHVsOFRRx+u+qnCcL/12DWF4wdcwNR8yHFpzJSoS
	gE8S48Ijuxm0kcNddHKHwA7kLkkQW8ZrZlBQH
X-Gm-Gg: ASbGnctnQJ7LrVX2pS+NJusSg+DNbasQGhIOUkdtMgjZDx7J88TW89QfCmJ9nYF4Pq5
	/0gWPQ+P7/VLL58CO/zRylKjwIsm+288UJzomwDb6DvcG1XW0Og==
X-Google-Smtp-Source: AGHT+IHI1MIdKKX6V2VPkic5lhwPvZWAQ9UsNmrKCOQzDWxtRTQKbVy+6urn/Bh8hSWRHM0sZPlqlGpL/rtxAp211RQ=
X-Received: by 2002:a05:6402:2816:b0:5d0:bf27:ef8a with SMTP id
 4fb4d7f45d1cf-5db7d339412mr11697757a12.26.1737375863061; Mon, 20 Jan 2025
 04:24:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241126144344.4177332-1-edumazet@google.com> <Z4o_UC0HweBHJ_cw@PC-LX-SteWu>
 <CANn89iLSPdPvotnGhPb3Rq2gkmpn3kLGJO8=3PDFrhSjUQSAkg@mail.gmail.com>
 <Z4pmD3l0XUApJhtD@PC-LX-SteWu> <CANn89i+e-V4hkUmUALsJe3ZQYtTkxduN5Sv+OiV+vzEmOdU1+Q@mail.gmail.com>
 <CANn89iJghv1JSwO7AVh97mU1Laj11SooiioZOHJ+UbUVeAcKUQ@mail.gmail.com> <Z4370QW5kLDptEEQ@PC-LX-SteWu>
In-Reply-To: <Z4370QW5kLDptEEQ@PC-LX-SteWu>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 20 Jan 2025 13:24:12 +0100
X-Gm-Features: AbW1kva2KYbCcnKQ50As2WRbwQtGUQQiO-VVhQ1TZfT3Mr1hRF8YrHxgcVx39V8
Message-ID: <CANn89iLMeMRtxBiOa7uZpG-8A0YNH=8NkhXmjfd2Qw4EZSZsNQ@mail.gmail.com>
Subject: Re: [PATCH net] net: hsr: avoid potential out-of-bound access in fill_frame_info()
To: Stephan Wurm <stephan.wurm@a-eberle.de>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	syzbot+671e2853f9851d039551@syzkaller.appspotmail.com, 
	WingMan Kwok <w-kwok2@ti.com>, Murali Karicheri <m-karicheri2@ti.com>, 
	MD Danish Anwar <danishanwar@ti.com>, Jiri Pirko <jiri@nvidia.com>, 
	George McCollister <george.mccollister@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 20, 2025 at 8:32=E2=80=AFAM Stephan Wurm <stephan.wurm@a-eberle=
.de> wrote:
>
> Am 17. Jan 19:18 hat Eric Dumazet geschrieben:
> > On Fri, Jan 17, 2025 at 7:14=E2=80=AFPM Eric Dumazet <edumazet@google.c=
om> wrote:
> > >
> > > On Fri, Jan 17, 2025 at 3:16=E2=80=AFPM Stephan Wurm <stephan.wurm@a-=
eberle.de> wrote:
> > > >
> > > > Am 17. Jan 14:22 hat Eric Dumazet geschrieben:
> > > > >
> > > > > Thanks for the report !
> > > > >
> > > > > You could add instrumentation there so that we see packet content=
.
> > > > >
> > > > > I suspect mac_len was not properly set somewhere.
> > > > >
> > > > > diff --git a/net/hsr/hsr_forward.c b/net/hsr/hsr_forward.c
> > > > > index 87bb3a91598ee96b825f7aaff53aafb32ffe4f95..b0068e23083416ba1=
3794e3b152517afbe5125b7
> > > > > 100644
> > > > > --- a/net/hsr/hsr_forward.c
> > > > > +++ b/net/hsr/hsr_forward.c
> > > > > @@ -700,8 +700,10 @@ static int fill_frame_info(struct hsr_frame_=
info *frame,
> > > > >                 frame->is_vlan =3D true;
> > > > >
> > > > >         if (frame->is_vlan) {
> > > > > -               if (skb->mac_len < offsetofend(struct hsr_vlan_et=
hhdr, vlanhdr))
> > > > > +               if (skb->mac_len < offsetofend(struct hsr_vlan_et=
hhdr,
> > > > > vlanhdr)) {
> > > > > +                       DO_ONCE_LITE(skb_dump, KERN_ERR, skb, tru=
e);
> > > > >                         return -EINVAL;
> > > > > +               }
> > > > >                 vlan_hdr =3D (struct hsr_vlan_ethhdr *)ethhdr;
> > > > >                 proto =3D vlan_hdr->vlanhdr.h_vlan_encapsulated_p=
roto;
> > > > >         }
> > > >
> > > > Thanks for your instrumentation patch.
> > > >
> > > > I got the following output in kernel log when sending an icmp echo =
with
> > > > VLAN header:
> > > >
> > > > kernel: prp0: entered promiscuous mode
> > > > kernel: skb len=3D46 headroom=3D2 headlen=3D46 tailroom=3D144
> > > >         mac=3D(2,14) net=3D(16,-1) trans=3D-1
> > > >         shinfo(txflags=3D0 nr_frags=3D0 gso(size=3D0 type=3D0 segs=
=3D0))
> > > >         csum(0x0 ip_summed=3D0 complete_sw=3D0 valid=3D0 level=3D0)
> > > >         hash(0x0 sw=3D0 l4=3D0) proto=3D0x0000 pkttype=3D0 iif=3D0
> > > > kernel: dev name=3Dprp0 feat=3D0x0000000000007000
> > > > kernel: sk family=3D17 type=3D3 proto=3D0
> > > > kernel: skb headroom: 00000000: 0d 12
> > > > kernel: skb linear:   00000000: 00 d0 93 4a 2d 91 00 d0 93 53 9c cb=
 81 00 00 00
> > > > kernel: skb linear:   00000010: 08 00 45 00 00 1c 00 01 00 00 40 01=
 d4 a1 ac 10
> > > > kernel: skb linear:   00000020: 27 14 ac 10 27 0a 08 00 f7 ff 00 00=
 00 00
> > > > kernel: skb tailroom: 00000000: 00 01 00 06 20 03 00 25 3c 20 00 00=
 00 00 00 00
> > > > kernel: skb tailroom: 00000010: 00 00 00 00 00 00 00 00 00 00 00 00=
 00 01 00 3d
> > > > kernel: skb tailroom: 00000020: 00 00 00 00 67 8a 61 45 15 63 56 39=
 00 25 00 7f
> > > > kernel: skb tailroom: 00000030: f8 fe ff ff 7f 00 d0 93 ff fe 64 e8=
 8e 00 53 00
> > > > kernel: skb tailroom: 00000040: 14 0e 14 31 00 00 53 00 14 0e 14 29=
 00 00 00 00
> > > > kernel: skb tailroom: 00000050: 00 00 00 00 00 00 00 00 00 00 08 00=
 45 00 00 34
> > > > kernel: skb tailroom: 00000060: 24 fa 40 00 40 06 17 c8 7f 00 00 01=
 7f 00 00 01
> > > > kernel: skb tailroom: 00000070: aa 04 13 8c 94 1d a0 b2 77 d6 5f 8a=
 80 10 02 00
> > > > kernel: skb tailroom: 00000080: fe 28 00 00 01 01 08 0a 89 e9 8a f7=
 89 e9 8a f7
> > > > kernel: prp0: left promiscuous mode
> > > >
> > >
> > > Yup, mac_len is incorrect, and the network header is also wrong.
> > >
> > > Please give us a stack trace, because at least one caller of
> > > hsr_forward() needs to be VLAN ready.
> > >
> > > diff --git a/net/hsr/hsr_forward.c b/net/hsr/hsr_forward.c
> > > index 87bb3a91598ee96b825f7aaff53aafb32ffe4f95..6f65a535c7fcd740cef81=
e718323e86fd1eef832
> > > 100644
> > > --- a/net/hsr/hsr_forward.c
> > > +++ b/net/hsr/hsr_forward.c
> > > @@ -700,8 +700,11 @@ static int fill_frame_info(struct hsr_frame_info=
 *frame,
> > >                 frame->is_vlan =3D true;
> > >
> > >         if (frame->is_vlan) {
> > > -               if (skb->mac_len < offsetofend(struct hsr_vlan_ethhdr=
, vlanhdr))
> > > +               if (skb->mac_len < offsetofend(struct hsr_vlan_ethhdr=
,
> > > vlanhdr)) {
> > > +                       DO_ONCE_LITE(skb_dump, KERN_ERR, skb, true);
> > > +                       WARN_ON_ONCE(1);
> > >                         return -EINVAL;
> > > +               }
> > >                 vlan_hdr =3D (struct hsr_vlan_ethhdr *)ethhdr;
> > >                 proto =3D vlan_hdr->vlanhdr.h_vlan_encapsulated_proto=
;
> > >         }
> >
> > BTW, also please cherry-pick this commit from linux-6.10
> >
> > commit 4308811ba90118ae1b71a95fee79ab7dada6400c
> > Author: Eric Dumazet <edumazet@google.com>
> > Date:   Sun Apr 7 08:06:06 2024 +0000
> >
> >     net: display more skb fields in skb_dump()
>
> Applying the new instrumentation gives me the following stack trace:
>
> kernel: skb len=3D170 headroom=3D2 headlen=3D170 tailroom=3D20
>         mac=3D(2,14) mac_len=3D14 net=3D(16,-1) trans=3D-1
>         shinfo(txflags=3D0 nr_frags=3D0 gso(size=3D0 type=3D0 segs=3D0))
>         csum(0x0 start=3D0 offset=3D0 ip_summed=3D0 complete_sw=3D0 valid=
=3D0 level=3D0)
>         hash(0x0 sw=3D0 l4=3D0) proto=3D0x0000 pkttype=3D0 iif=3D0
>         priority=3D0x0 mark=3D0x0 alloc_cpu=3D0 vlan_all=3D0x0
>         encapsulation=3D0 inner(proto=3D0x0000, mac=3D0, net=3D0, trans=
=3D0)
> kernel: dev name=3Dprp0 feat=3D0x0000000000007000
> kernel: sk family=3D17 type=3D3 proto=3D0
> kernel: skb headroom: 00000000: 74 00
> kernel: skb linear:   00000000: 01 0c cd 01 00 01 00 d0 93 53 9c cb 81 00=
 80 00
> kernel: skb linear:   00000010: 88 b8 00 01 00 98 00 00 00 00 61 81 8d 80=
 16 52
> kernel: skb linear:   00000020: 45 47 44 4e 43 54 52 4c 2f 4c 4c 4e 30 24=
 47 4f
> kernel: skb linear:   00000030: 24 47 6f 43 62 81 01 14 82 16 52 45 47 44=
 4e 43
> kernel: skb linear:   00000040: 54 52 4c 2f 4c 4c 4e 30 24 44 73 47 6f 6f=
 73 65
> kernel: skb linear:   00000050: 83 07 47 6f 49 64 65 6e 74 84 08 67 8d f5=
 93 7e
> kernel: skb linear:   00000060: 76 c8 00 85 01 01 86 01 00 87 01 00 88 01=
 01 89
> kernel: skb linear:   00000070: 01 00 8a 01 02 ab 33 a2 15 83 01 00 84 03=
 03 00
> kernel: skb linear:   00000080: 00 91 08 67 8d f5 92 77 4b c6 1f 83 01 00=
 a2 1a
> kernel: skb linear:   00000090: a2 06 85 01 00 83 01 00 84 03 03 00 00 91=
 08 67
> kernel: skb linear:   000000a0: 8d f5 92 77 4b c6 1f 83 01 00
> kernel: skb tailroom: 00000000: 80 18 02 00 fe 4e 00 00 01 01 08 0a 4f fd=
 5e d1
> kernel: skb tailroom: 00000010: 4f fd 5e cd
> kernel: ------------[ cut here ]------------
> kernel: WARNING: CPU: 0 PID: 751 at /net/hsr/hsr_forward.c:605 fill_frame=
_info+0x180/0x19c
> kernel: Modules linked in:
> kernel: CPU: 0 PID: 751 Comm: reg61850 Not tainted 6.6.69-ga7a5cc0c39f0 #=
1
> kernel: Hardware name: Freescale LS1021A
> kernel:  unwind_backtrace from show_stack+0x10/0x14
> kernel:  show_stack from dump_stack_lvl+0x40/0x4c
> kernel:  dump_stack_lvl from __warn+0x94/0xc0
> kernel:  __warn from warn_slowpath_fmt+0x1b4/0x1bc
> kernel:  warn_slowpath_fmt from fill_frame_info+0x180/0x19c
> kernel:  fill_frame_info from hsr_forward_skb+0x54/0x118
> kernel:  hsr_forward_skb from hsr_dev_xmit+0x60/0xc4
> kernel:  hsr_dev_xmit from dev_hard_start_xmit+0xa0/0xe4
> kernel:  dev_hard_start_xmit from __dev_queue_xmit+0x144/0x5e8
> kernel:  __dev_queue_xmit from packet_snd+0x5c0/0x784
> kernel:  packet_snd from sock_write_iter+0xa0/0x10c
> kernel:  sock_write_iter from vfs_write+0x3ac/0x41c
> kernel:  vfs_write from ksys_write+0xbc/0xf0
> kernel:  ksys_write from ret_fast_syscall+0x0/0x4c
> kernel: Exception stack(0xc0d8dfa8 to 0xc0d8dff0)
> kernel: dfa0:                   000000aa 73058e53 00000012 73058e53 00000=
0aa 00000000
> kernel: dfc0: 000000aa 73058e53 00000012 00000004 6ebf9940 0000000a 00000=
000 00000000
> kernel: dfe0: 00000004 6ebf90f8 766a17ad 7661e5e6
> kernel: ---[ end trace 0000000000000000 ]---

Thanks.

So hsr_forward() can be used in tx path, not forwarding as its name
would imply... what a mess.

It looks like it might be an af_packet issue, or an application bug.

packet_parse_headers() should really for this vlan packet set the
network header correctly.

Otherwise, I do not see how hsr could use mac_len at all.

I am afraid commit 48b491a5cc74333c ("net: hsr: fix mac_len checks")
was not good enough.

