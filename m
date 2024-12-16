Return-Path: <netdev+bounces-152258-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 516249F33E3
	for <lists+netdev@lfdr.de>; Mon, 16 Dec 2024 16:00:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 732931885804
	for <lists+netdev@lfdr.de>; Mon, 16 Dec 2024 14:59:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D838B481B1;
	Mon, 16 Dec 2024 14:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cc9VV5ur"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com [209.85.219.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88DD2823D1
	for <netdev@vger.kernel.org>; Mon, 16 Dec 2024 14:59:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734361166; cv=none; b=li2uQS1JxxxSzzplua7oPcn9KRwfVCSbIxraEeW5zx/omH0rEqZW6AZURDHMzX4xy6tpjYzvmyVCgx7hmhWZCV4OW0ecftjW0xd8SmHYEGtQWWLaCEtA4upOE0tuTMMpH3sDmXvIHOgQBI4kGZZ4WRVDO3Xf8MmBA5zGS0FVVvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734361166; c=relaxed/simple;
	bh=wgI5LKWLNCv2f6tU4YHjSli9RcVY8pz1T2pAx1W7cUs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jNiLNRuAbXFMFVBrqdu7t4EANjfjIfX/5sHNDDG/pEOSmhneIVVyHlrp0qoN2r/FgseyNA/nM0H854rVRY+WcPRK3VRVfTC3RGFDkFwDurSH9GtEiY5ws9rDin7V7fAzZCMo14tg6EfI194i93WnFS08evWz8fKHSIZt8JHSmBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Cc9VV5ur; arc=none smtp.client-ip=209.85.219.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f170.google.com with SMTP id 3f1490d57ef6-e479e529ebcso1392281276.3
        for <netdev@vger.kernel.org>; Mon, 16 Dec 2024 06:59:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734361163; x=1734965963; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2U8fXkJcor6Ro2JpHpfyIOr9TbtIbRhIvyrZLIrVc+Y=;
        b=Cc9VV5urCJkBMUfeEooRRVuDK9hhC4MAJFLkLenDMCjbdRzOqXwMhomG3IxmScoj66
         85csziJ1ePtUKWORfaCS1IDPw3KXBMjRFSG4AuQd8VuHWtSE/Bl2vCH9Z8KwOh6MgyuG
         Xyu8IcglsI1w58qtxzjqTknxaHD8ca7Aywnufzc3G9b3APr2RGNEvzuvoquBjfYIzkQ8
         SUq5S+EpACtYX/t3Qp5JILEf7UPo1wPHGmufwVP7QU9Kn+TjVKDYXaeBXxWkNWCUJFVC
         2gWOjWAV94meYRc/16FIp8irL0ra6yxShliOhPjHyWVDJ21VftZy48UCztWnlGrlWZq3
         gDzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734361163; x=1734965963;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2U8fXkJcor6Ro2JpHpfyIOr9TbtIbRhIvyrZLIrVc+Y=;
        b=wOyb3obOxywb/s7qU71KWZCbQAgr1Dui4k1kEBntFLA1YOGtSL6T5lv3/MUxiue+9S
         1uI1q297pp9W4qw2uL6Rq1D80qKRh8uw3P1g864T/pOq6u5JM5PFYnhf3YIDi8G+LHyZ
         bpBrFl783AyXq1ahOMdBFQp+H8PkxkzudGsv61U6lKD20GKE+KfxDkTRNRXjgzS4A8/t
         UG/FfySoAt3GziBjxE5fHL+RZGjP9qUquG9LHIwohAdyzUXaN/30lpmWrQEbdAJPbaKX
         V2M2xh8MUbwK/800p/8e1PrwGp1wuAPudkyG0wyavY+df9nVQwh4G+MpT7Wm/Hy1nCfL
         4fGw==
X-Forwarded-Encrypted: i=1; AJvYcCUJLI4gP4bVZgwdYO26lSq483X1dH00XyOkze/En+EDveTsb3ov6L/n63UzWq87vurc0s7gQHg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzE3DXIf4qDLQbZc/OfX/k73AgyezD3bdwVEPpktGkHwzk7+jBu
	/x94562p70PYnd7qMyarDEpv985t46otEUtlO46xhVWuiz5NgAICP0pscL3U3OQicbqd7LEWAV6
	oKwfRi3DLP2og07Uo5aCeLJfsy6c=
X-Gm-Gg: ASbGncs08jQpT1r7U6Ck+1POnEydb24fBiLn87Em0brPLwneRoemBVWdcRYNCoUOgeF
	BDlJcjxaI3SAnbDfOfK6PMcUSHzqf2myq7zDiSQLXq2HScjeEVaF3rIolOVo5HcJuY9h/n3Kt
X-Google-Smtp-Source: AGHT+IGSQCc8OHk93S7omDUH4nDbLoC97xFtmS/wiD2uBMsi6GBZvhzwKFQKnQUrME04XGDSKvdTadq4Smr8HD3me60=
X-Received: by 2002:a05:6902:2413:b0:e3a:1735:b24e with SMTP id
 3f1490d57ef6-e434856c0aamr9870441276.2.1734361163327; Mon, 16 Dec 2024
 06:59:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241216134207.165422-1-idosch@nvidia.com> <CANn89iLt9uKxzcceP=xWp5gr+VmghsZROwjHtK=878zDQ+7BpA@mail.gmail.com>
 <Z2A8vwvlKMqQf8jQ@shredder>
In-Reply-To: <Z2A8vwvlKMqQf8jQ@shredder>
From: ericnetdev dumazet <erdnetdev@gmail.com>
Date: Mon, 16 Dec 2024 15:59:12 +0100
Message-ID: <CAHTyZGyAO_NtuNiH62m5z8tEWjjWCobsyr-wvSLfeBNaBEYe6Q@mail.gmail.com>
Subject: Re: [PATCH net] vxlan: Avoid accessing uninitialized memory during xmit
To: Ido Schimmel <idosch@nvidia.com>
Cc: Eric Dumazet <edumazet@google.com>, netdev@vger.kernel.org, davem@davemloft.net, 
	kuba@kernel.org, pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org, 
	gnault@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Le lun. 16 d=C3=A9c. 2024 =C3=A0 15:44, Ido Schimmel <idosch@nvidia.com> a =
=C3=A9crit :
>
> On Mon, Dec 16, 2024 at 02:48:04PM +0100, Eric Dumazet wrote:
> > On Mon, Dec 16, 2024 at 2:43=E2=80=AFPM Ido Schimmel <idosch@nvidia.com=
> wrote:
> > >
> > > The VXLAN driver does not verify that transmitted packets have an
> > > Ethernet header in the linear part of the skb, which can result in th=
e
> > > driver accessing uninitialized memory while processing the Ethernet
> > > header [1]. Issue can be reproduced using [2].
> > >
> > > Fix by checking that we can pull the Ethernet header into the linear
> > > part of the skb. Note that the driver can transmit IP packets, but th=
is
> > > is handled earlier in the xmit path.
> > >
> > > [1]
> > > CPU: 6 UID: 0 PID: 404 Comm: bpftool Tainted: G    B              6.1=
2.0-rc7-custom-g10d3437464d3 #232
> > > Tainted: [B]=3DBAD_PAGE
> > > Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.3-2.=
fc40 04/01/2014
> > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
> > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
> > > BUG: KMSAN: uninit-value in __vxlan_find_mac+0x449/0x450
> > >  __vxlan_find_mac+0x449/0x450
> > >  vxlan_xmit+0x1265/0x2f70
> > >  dev_hard_start_xmit+0x239/0x7e0
> > >  __dev_queue_xmit+0x2d65/0x45e0
> > >  __bpf_redirect+0x6d2/0xf60
> > >  bpf_clone_redirect+0x2c7/0x450
> > >  bpf_prog_7423975f9f8be99f_mac_repo+0x20/0x22
> > >  bpf_test_run+0x60f/0xca0
> > >  bpf_prog_test_run_skb+0x115d/0x2300
> > >  bpf_prog_test_run+0x3b3/0x5c0
> > >  __sys_bpf+0x501/0xc60
> > >  __x64_sys_bpf+0xa8/0xf0
> > >  do_syscall_64+0xd9/0x1b0
> > >  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> > >
> > > Uninit was stored to memory at:
> > >  __vxlan_find_mac+0x442/0x450
> > >  vxlan_xmit+0x1265/0x2f70
> > >  dev_hard_start_xmit+0x239/0x7e0
> > >  __dev_queue_xmit+0x2d65/0x45e0
> > >  __bpf_redirect+0x6d2/0xf60
> > >  bpf_clone_redirect+0x2c7/0x450
> > >  bpf_prog_7423975f9f8be99f_mac_repo+0x20/0x22
> > >  bpf_test_run+0x60f/0xca0
> > >  bpf_prog_test_run_skb+0x115d/0x2300
> > >  bpf_prog_test_run+0x3b3/0x5c0
> > >  __sys_bpf+0x501/0xc60
> > >  __x64_sys_bpf+0xa8/0xf0
> > >  do_syscall_64+0xd9/0x1b0
> > >  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> > >
> > > Uninit was created at:
> > >  kmem_cache_alloc_node_noprof+0x4a8/0x9e0
> > >  kmalloc_reserve+0xd1/0x420
> > >  pskb_expand_head+0x1b4/0x15f0
> > >  skb_ensure_writable+0x2ee/0x390
> > >  bpf_clone_redirect+0x16a/0x450
> > >  bpf_prog_7423975f9f8be99f_mac_repo+0x20/0x22
> > >  bpf_test_run+0x60f/0xca0
> > >  bpf_prog_test_run_skb+0x115d/0x2300
> > >  bpf_prog_test_run+0x3b3/0x5c0
> > >  __sys_bpf+0x501/0xc60
> > >  __x64_sys_bpf+0xa8/0xf0
> > >  do_syscall_64+0xd9/0x1b0
> > >
> > > [2]
> > >  $ cat mac_repo.bpf.c
> > >  // SPDX-License-Identifier: GPL-2.0
> > >  #include <linux/bpf.h>
> > >  #include <bpf/bpf_helpers.h>
> > >
> > >  SEC("lwt_xmit")
> > >  int mac_repo(struct __sk_buff *skb)
> > >  {
> > >          return bpf_clone_redirect(skb, 100, 0);
> > >  }
> > >
> > >  $ clang -O2 -target bpf -c mac_repo.bpf.c -o mac_repo.o
> > >
> > >  # ip link add name vx0 up index 100 type vxlan id 10010 dstport 4789=
 local 192.0.2.1
> > >
> > >  # bpftool prog load mac_repo.o /sys/fs/bpf/mac_repo
> > >
> > >  # echo -ne "\x41\x41\x41\x41\x41\x41\x41\x41\x41\x41\x41\x41\x41\x41=
\x41" | \
> > >         bpftool prog run pinned /sys/fs/bpf/mac_repo data_in - repeat=
 10
> > >
> > > Fixes: d342894c5d2f ("vxlan: virtual extensible lan")
> > > Reported-by: syzbot+35e7e2811bbe5777b20e@syzkaller.appspotmail.com
> > > Closes: https://lore.kernel.org/netdev/6735d39a.050a0220.1324f8.0096.=
GAE@google.com/
> > > Signed-off-by: Ido Schimmel <idosch@nvidia.com>
> > > ---
> > > If this is accepted, I will change dev_core_stats_tx_dropped_inc() to
> > > dev_dstats_tx_dropped() in net-next.
> > > ---
> > >  drivers/net/vxlan/vxlan_core.c | 10 ++++++++++
> > >  1 file changed, 10 insertions(+)
> > >
> > > diff --git a/drivers/net/vxlan/vxlan_core.c b/drivers/net/vxlan/vxlan=
_core.c
> > > index 9ea63059d52d..4cbde7a88205 100644
> > > --- a/drivers/net/vxlan/vxlan_core.c
> > > +++ b/drivers/net/vxlan/vxlan_core.c
> > > @@ -2722,6 +2722,7 @@ static netdev_tx_t vxlan_xmit(struct sk_buff *s=
kb, struct net_device *dev)
> > >         struct vxlan_dev *vxlan =3D netdev_priv(dev);
> > >         struct vxlan_rdst *rdst, *fdst =3D NULL;
> > >         const struct ip_tunnel_info *info;
> > > +       enum skb_drop_reason reason;
> > >         struct vxlan_fdb *f;
> > >         struct ethhdr *eth;
> > >         __be32 vni =3D 0;
> > > @@ -2746,6 +2747,15 @@ static netdev_tx_t vxlan_xmit(struct sk_buff *=
skb, struct net_device *dev)
> > >                 }
> > >         }
> > >
> > > +       reason =3D pskb_may_pull_reason(skb, ETH_HLEN);
> > > +       if (unlikely(reason !=3D SKB_NOT_DROPPED_YET)) {
> > > +               dev_core_stats_tx_dropped_inc(dev);
> > > +               vxlan_vnifilter_count(vxlan, vni, NULL,
> > > +                                     VXLAN_VNI_STATS_TX_DROPS, 0);
> > > +               kfree_skb_reason(skb, reason);
> > > +               return NETDEV_TX_OK;
> > > +       }
> >
> > I think the plan was to use dev->min_header_len, in the generic part
> > of networking stack,
> > instead of having to copy/paste this code in all drivers.
>
> Are you referring to [1]? Tested it using the reproducer I mentioned and
> it seems to work. Is it still blocked by the empty_skb test?
>
> [1] https://lore.kernel.org/netdev/20240322122407.1329861-1-edumazet@goog=
le.com/

Yes, I am referring to a generic test done in locations where a
malicious skb could be cooked/transformed.

Thanks !

