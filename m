Return-Path: <netdev+bounces-81669-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1022688AB27
	for <lists+netdev@lfdr.de>; Mon, 25 Mar 2024 18:16:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 348761C3B857
	for <lists+netdev@lfdr.de>; Mon, 25 Mar 2024 17:16:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC3E21272C4;
	Mon, 25 Mar 2024 15:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Igix77CI"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A38410A39;
	Mon, 25 Mar 2024 15:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711382213; cv=none; b=TmZBUMtC7jBZ0EdW8S7qzK1Z6j2otz2KMF15C/2+IpRg+uagzOY0cd83322Z8HdMtDXXibBCjz3f8ntWdETbhdlhfU4/rT+vkG6r3KCrA65ldyUZb7awyvzoZLJ4LsmjXtsT3vrh2d8D5S3SM/WdnGVtaWm/pE+hMZUnRmEezss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711382213; c=relaxed/simple;
	bh=9dpLxe8xFJYjvF0jtNreXvJ0wWBEIbcp0RMNxceQQ1M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dn2qDo5n6BjKTXpJAeaUiJ+ycb8DcItHwOuNmoAfFPTbsUbBDH8R39wtdXUBZk7IwyckT6dD82ac9eNj3DmmLkbYEBnQtvmJUI6zZfFw8xxrxbU4BeX+/W49DRHMgqdQHH/UESeREzN+D9Dh3g8FLchxn/BuN7KAV+XgJe5JDoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Igix77CI; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4147e135f4dso19639405e9.2;
        Mon, 25 Mar 2024 08:56:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711382210; x=1711987010; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9EIPPoE4XE3IVkGslmKnrmiWWAv7/89VqpklJd+6R1k=;
        b=Igix77CIg/MYZpYW7SS0LsbQJVTDYWj4cl+P/lJMstaw6pY55hh5n04Assf6IeZ1tA
         sa9eGL/IoG3R1pIq/0wuBNSixokd17pD7yXEYECJbmOCxN4aB0A0nMt8NOR0pilrEDy8
         xkU2aq1pP+ihS0pb1n/XEnsJBgmiJwK74gMgqCqxJPaYwD9AsrfukgyKd1lF+oI7JFdq
         0aJE7NDQ46Iw/2ANtjQLNsU9hsIUdzBaGq/G+XiMlqqWtKBOG80YpQPf/JbvYPwv/mV9
         9ye7JcIdVsN3rg/q8k4CeF4WJp1Qr1fUE3D0CmB8c59Vl7UuAEKFSvZcJ4LawRWnz6ob
         8Nzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711382210; x=1711987010;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9EIPPoE4XE3IVkGslmKnrmiWWAv7/89VqpklJd+6R1k=;
        b=SjcAy7d0Hnp6ew+v716xdAYvNVHHduOrez4eXvLa4Z+WyRLxASQV1jT5tXG0TSCch1
         TuFp7GcFEL0ZxK9ueEkGLieNsSLm7xz5zWjwHyiHeO+mIIXNI7znd9ohrIeDInUfv2tC
         p0IH6EMG/euYrEv/rkcmgRQnWEnq0ARx9roG9qKY9/LU/tQJM2mtiQLhOd1bNuB3BLJw
         3Wd82Q/F9FfgZUQA68eOTx0ZE4Q00PdXsXVh+a3ybuYhIWKf663vwmFXSdFHXv6mlX0O
         vYupadYNmn6JAyv6YQoT4MoP1M4GNVXWm3SG4oje2skbhz8Kem5dRvn42Baskx/hc18T
         yrsQ==
X-Forwarded-Encrypted: i=1; AJvYcCUqcxGTCMK9xWX2ZmI4dYHG23+O0s4PzJxiKRZXCotr7aPRLuQGOFVFRpRv+8JkpLO7U5+R/UwyoUyU3Q4gtPFDZZfYXKwaDr1x24zRJr0BvT9EHEdA0wHmGvPM
X-Gm-Message-State: AOJu0Yxq4rCXgCX+7QIpGS9NwsarO0frjQLPhczI8DfSzGaubVC+SXNP
	s1BJkAw8pFoqwSvANb+4OSH1GOgNid4Ml4FYj5szwsRcZC++soP1OU7Ifp5dKarM2Ed1zx9W8oT
	r8D/jsavhmT1TT1AJCjeu1pg/MPs=
X-Google-Smtp-Source: AGHT+IHxfR6k24jFecqQDXHG63S+elULgngDfANzh0qG8uBiCjlocubzCFIIU4l1kFVyS8zvFJOiJtcFyl+oXdXKU24=
X-Received: by 2002:a05:6000:cb:b0:33e:d15c:3575 with SMTP id
 q11-20020a05600000cb00b0033ed15c3575mr4957677wrx.33.1711382210126; Mon, 25
 Mar 2024 08:56:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240322122407.1329861-1-edumazet@google.com> <171111663201.19374.16295682760005551863.git-patchwork-notify@kernel.org>
 <CAADnVQJy+0=6ZuAz-7dwOPK3sN2QrPiAcxhtojh8p65j0TRNhg@mail.gmail.com> <CANn89iLSOeFGNogYMHbeLRC5kOwwArMz3d5_2hZmBn6fibyUhw@mail.gmail.com>
In-Reply-To: <CANn89iLSOeFGNogYMHbeLRC5kOwwArMz3d5_2hZmBn6fibyUhw@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 25 Mar 2024 08:56:38 -0700
Message-ID: <CAADnVQ+OhsBetPT0avuNVsEwru13UtMjX1U_6_u6xROXBBn-Yg@mail.gmail.com>
Subject: Re: [PATCH net] bpf: Don't redirect too small packets
To: Eric Dumazet <edumazet@google.com>, Stanislav Fomichev <sdf@google.com>
Cc: Guillaume Nault <gnault@redhat.com>, patchwork-bot+netdevbpf@kernel.org, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Daniel Borkmann <daniel@iogearbox.net>, Alexei Starovoitov <ast@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Andrii Nakryiko <andrii@kernel.org>, 
	Network Development <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>, 
	Eric Dumazet <eric.dumazet@gmail.com>, 
	syzbot+9e27778c0edc62cb97d8@syzkaller.appspotmail.com, 
	Willem de Bruijn <willemb@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 25, 2024 at 6:33=E2=80=AFAM Eric Dumazet <edumazet@google.com> =
wrote:
>
> On Sat, Mar 23, 2024 at 4:02=E2=80=AFAM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> >
> > On Fri, Mar 22, 2024 at 7:10=E2=80=AFAM <patchwork-bot+netdevbpf@kernel=
.org> wrote:
> > >
> > > Hello:
> > >
> > > This patch was applied to bpf/bpf.git (master)
> > > by Daniel Borkmann <daniel@iogearbox.net>:
> > >
> > > On Fri, 22 Mar 2024 12:24:07 +0000 you wrote:
> > > > Some drivers ndo_start_xmit() expect a minimal size, as shown
> > > > by various syzbot reports [1].
> > > >
> > > > Willem added in commit 217e6fa24ce2 ("net: introduce device min_hea=
der_len")
> > > > the missing attribute that can be used by upper layers.
> > > >
> > > > We need to use it in __bpf_redirect_common().
> >
> > This patch broke empty_skb test:
> > $ test_progs -t empty_skb
> >
> > test_empty_skb:FAIL:ret: veth ETH_HLEN+1 packet ingress
> > [redirect_ingress] unexpected ret: veth ETH_HLEN+1 packet ingress
> > [redirect_ingress]: actual -34 !=3D expected 0
> > test_empty_skb:PASS:err: veth ETH_HLEN+1 packet ingress [redirect_egres=
s] 0 nsec
> > test_empty_skb:FAIL:ret: veth ETH_HLEN+1 packet ingress
> > [redirect_egress] unexpected ret: veth ETH_HLEN+1 packet ingress
> > [redirect_egress]: actual -34 !=3D expected 1
> >
> > And looking at the test I think it's not a test issue.
> > This check
> > if (unlikely(skb->len < dev->min_header_len))
> > is rejecting more than it should.
> >
> > So I reverted this patch for now.
>
> OK, it seems I missed __bpf_rx_skb() vs __bpf_tx_skb(), but even if I
> move my sanity test in __bpf_tx_skb(),
> the bpf test program still fails, I am suspecting the test needs to be ad=
justed.
>
>
>
> diff --git a/net/core/filter.c b/net/core/filter.c
> index 745697c08acb3a74721d26ee93389efa81e973a0..e9c0e2087a08f1d8afd2c3e8e=
7871ddc9231b76d
> 100644
> --- a/net/core/filter.c
> +++ b/net/core/filter.c
> @@ -2128,6 +2128,12 @@ static inline int __bpf_tx_skb(struct
> net_device *dev, struct sk_buff *skb)
>                 return -ENETDOWN;
>         }
>
> +       if (unlikely(skb->len < dev->min_header_len)) {
> +               pr_err_once("__bpf_tx_skb skb->len=3D%u <
> dev(%s)->min_header_len(%u)\n", skb->len, dev->name,
> dev->min_header_len);
> +               DO_ONCE_LITE(skb_dump, KERN_ERR, skb, false);
> +               kfree_skb(skb);
> +               return -ERANGE;
> +       } // Note: this is before we change skb->dev
>         skb->dev =3D dev;
>         skb_set_redirected_noclear(skb, skb_at_tc_ingress(skb));
>         skb_clear_tstamp(skb);
>
>
> -->
>
>
> test_empty_skb:FAIL:ret: veth ETH_HLEN+1 packet ingress
> [redirect_egress] unexpected ret: veth ETH_HLEN+1 packet ingress
> [redirect_egress]: actual -34 !=3D expected 1
>
> [   58.382051] __bpf_tx_skb skb->len=3D1 < dev(veth0)->min_header_len(14)
> [   58.382778] skb len=3D1 headroom=3D78 headlen=3D1 tailroom=3D113
>                mac=3D(64,14) net=3D(78,-1) trans=3D-1
>                shinfo(txflags=3D0 nr_frags=3D0 gso(size=3D0 type=3D0 segs=
=3D0))
>                csum(0x0 ip_summed=3D0 complete_sw=3D0 valid=3D0 level=3D0=
)
>                hash(0x0 sw=3D0 l4=3D0) proto=3D0x7f00 pkttype=3D0 iif=3D0

Hmm. Something is off.
That test creates 15 byte skb.
It's not obvious to me how it got reduced to 1.
Something stripped L2 header and the prog is trying to redirect
such skb into veth that expects skb with L2 ?

Stan,
please take a look.
Since you wrote that test.

