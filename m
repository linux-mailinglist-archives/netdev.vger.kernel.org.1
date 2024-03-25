Return-Path: <netdev+bounces-81686-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B838D88ABBB
	for <lists+netdev@lfdr.de>; Mon, 25 Mar 2024 18:31:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 65F132E74E3
	for <lists+netdev@lfdr.de>; Mon, 25 Mar 2024 17:31:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9011137938;
	Mon, 25 Mar 2024 16:28:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mNmMtxgi"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5985C5476B
	for <netdev@vger.kernel.org>; Mon, 25 Mar 2024 16:28:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711384133; cv=none; b=O/UV0RpWFqqmE5P+OH5MVgFSTgjbxddw0aS1lKlzkD9rbkzTuz2qHT6CrNmS1usNmML6edONhbTwgg7v+mCqIhYdVOP3Zmf3YYCkDs+zlpN3s6YQA4v+WpyadSM6i6SpGEVCUUhViu3jjopokzglR84HUvzBlHd1shF/ol/3Ym4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711384133; c=relaxed/simple;
	bh=KF1j25ioMLHyKZRBEL/474gQJTD2B9v/+jRU4bcIevk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=hU7yBdO0+nFnflLK6IRJp2xUWmVxk5pBs3neVcESq+mZ+FDBbJH8Ywlf57jWT1WrIB25NnHtpSBFjMleqNguTReTb5nkdDRoJy4rc6GKQYhNzuQxGXlqJaFZGvIyXYU4cz6y5Y70rs8v3NDfpx2XtrWLIReKbsBul1G0phfnpVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--sdf.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mNmMtxgi; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--sdf.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-6e6a1625e4bso4485270b3a.1
        for <netdev@vger.kernel.org>; Mon, 25 Mar 2024 09:28:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1711384132; x=1711988932; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kk6jtaO7k8+1jovzSJjFpmA1KrquxsoWedaWKbOsB+M=;
        b=mNmMtxgiEUEGRQ8fB6Neg34O5+RcLd/+jDTEssS8iEkMawecIppKCKhEjdFFuH+o67
         kvSewLY+6Mzixa94vTZu/Apvr7ivKV8NdiqardYJXTgzDMrw0fe8pKgWn5QAtKZCteqR
         yLDFLxvp1vZQfi9jklOsW4IwcoRnPvRS2VS05t8+UDC9dOrwIOzOUiCF1Ytfdj3YQPN1
         raNmBx6/l6Yo5eD7qvt/Ogiwrk6YhCHCBMKA4Qa/AJwPjVeLOvhkfduETEk9p1LQ3VdV
         4HSrl6Bxx0dmUt12JifivFLpTeyD37M+vr/GMzNgL6d0VCqJlQNfhKXHKz78ojz4b65l
         fz8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711384132; x=1711988932;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=kk6jtaO7k8+1jovzSJjFpmA1KrquxsoWedaWKbOsB+M=;
        b=wrUOnvgQuG+Y7v2hgF8CAoxWmTl6vViUT6PG2uMdzJo/iXqv2y3ZAsfkxGrFhDUWFb
         lekonecyrgLzJs2UXEYumHGoKWZB6uZJ3BBVV99iNLjQVyjKhXYcQt103IDC1ER12FMo
         0TFoKh8cNTuknm2WVsWMP2ex1JOiDJykf259AeGhv0vokXs3FOBX3yGRLPbtuNf5Uf8G
         mxXVWkpllV/y0spML0G0kSpym1ehbGfS0pO9DeHeKsnOWHbI4H8UoEm/3uTysQA+K2cH
         HQBfWX+61gG9co5JHIUfHJP1OePKO6qldZ4mv2GOJ61bE3Q+wMrbCv5u86fIaoPhhFYL
         COfA==
X-Forwarded-Encrypted: i=1; AJvYcCXq9cAKS35yemjTaaOrHSoJGqJ3jvjfNIunUmll1CUBGwuI4p3YNuU24/RULbPcPOaV2IIEXfksK3np9XZcolsz+4veZCfT
X-Gm-Message-State: AOJu0YzwGIDuMeGB0jUXp2LxuRUc0kRvnmN4vHIALWaRPjWXDwmJg1k9
	CiGDTZrUS8Yg37GLNm+jdtqTB3mC2PiEb2G5kqG01T1dR0cJjOMAxUDCRYI0Mv3S1A==
X-Google-Smtp-Source: AGHT+IE6ge11YCQlTD2Q8avHTPIrOkyfXTpYDRYgCaaQaNx8sYxsgDqRoOKW2xuulmmtf4p2Ck+79ck=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a05:6a00:148a:b0:6ea:7468:1f47 with SMTP id
 v10-20020a056a00148a00b006ea74681f47mr489525pfu.0.1711384131592; Mon, 25 Mar
 2024 09:28:51 -0700 (PDT)
Date: Mon, 25 Mar 2024 09:28:50 -0700
In-Reply-To: <CAADnVQ+OhsBetPT0avuNVsEwru13UtMjX1U_6_u6xROXBBn-Yg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240322122407.1329861-1-edumazet@google.com> <171111663201.19374.16295682760005551863.git-patchwork-notify@kernel.org>
 <CAADnVQJy+0=6ZuAz-7dwOPK3sN2QrPiAcxhtojh8p65j0TRNhg@mail.gmail.com>
 <CANn89iLSOeFGNogYMHbeLRC5kOwwArMz3d5_2hZmBn6fibyUhw@mail.gmail.com> <CAADnVQ+OhsBetPT0avuNVsEwru13UtMjX1U_6_u6xROXBBn-Yg@mail.gmail.com>
Message-ID: <ZgGmQu09Z9xN7eOD@google.com>
Subject: Re: [PATCH net] bpf: Don't redirect too small packets
From: Stanislav Fomichev <sdf@google.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Eric Dumazet <edumazet@google.com>, Guillaume Nault <gnault@redhat.com>, 
	patchwork-bot+netdevbpf@kernel.org, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Daniel Borkmann <daniel@iogearbox.net>, Alexei Starovoitov <ast@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Andrii Nakryiko <andrii@kernel.org>, 
	Network Development <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>, 
	Eric Dumazet <eric.dumazet@gmail.com>, 
	syzbot+9e27778c0edc62cb97d8@syzkaller.appspotmail.com, 
	Willem de Bruijn <willemb@google.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On 03/25, Alexei Starovoitov wrote:
> On Mon, Mar 25, 2024 at 6:33=E2=80=AFAM Eric Dumazet <edumazet@google.com=
> wrote:
> >
> > On Sat, Mar 23, 2024 at 4:02=E2=80=AFAM Alexei Starovoitov
> > <alexei.starovoitov@gmail.com> wrote:
> > >
> > > On Fri, Mar 22, 2024 at 7:10=E2=80=AFAM <patchwork-bot+netdevbpf@kern=
el.org> wrote:
> > > >
> > > > Hello:
> > > >
> > > > This patch was applied to bpf/bpf.git (master)
> > > > by Daniel Borkmann <daniel@iogearbox.net>:
> > > >
> > > > On Fri, 22 Mar 2024 12:24:07 +0000 you wrote:
> > > > > Some drivers ndo_start_xmit() expect a minimal size, as shown
> > > > > by various syzbot reports [1].
> > > > >
> > > > > Willem added in commit 217e6fa24ce2 ("net: introduce device min_h=
eader_len")
> > > > > the missing attribute that can be used by upper layers.
> > > > >
> > > > > We need to use it in __bpf_redirect_common().
> > >
> > > This patch broke empty_skb test:
> > > $ test_progs -t empty_skb
> > >
> > > test_empty_skb:FAIL:ret: veth ETH_HLEN+1 packet ingress
> > > [redirect_ingress] unexpected ret: veth ETH_HLEN+1 packet ingress
> > > [redirect_ingress]: actual -34 !=3D expected 0
> > > test_empty_skb:PASS:err: veth ETH_HLEN+1 packet ingress [redirect_egr=
ess] 0 nsec
> > > test_empty_skb:FAIL:ret: veth ETH_HLEN+1 packet ingress
> > > [redirect_egress] unexpected ret: veth ETH_HLEN+1 packet ingress
> > > [redirect_egress]: actual -34 !=3D expected 1
> > >
> > > And looking at the test I think it's not a test issue.
> > > This check
> > > if (unlikely(skb->len < dev->min_header_len))
> > > is rejecting more than it should.
> > >
> > > So I reverted this patch for now.
> >
> > OK, it seems I missed __bpf_rx_skb() vs __bpf_tx_skb(), but even if I
> > move my sanity test in __bpf_tx_skb(),
> > the bpf test program still fails, I am suspecting the test needs to be =
adjusted.
> >
> >
> >
> > diff --git a/net/core/filter.c b/net/core/filter.c
> > index 745697c08acb3a74721d26ee93389efa81e973a0..e9c0e2087a08f1d8afd2c3e=
8e7871ddc9231b76d
> > 100644
> > --- a/net/core/filter.c
> > +++ b/net/core/filter.c
> > @@ -2128,6 +2128,12 @@ static inline int __bpf_tx_skb(struct
> > net_device *dev, struct sk_buff *skb)
> >                 return -ENETDOWN;
> >         }
> >
> > +       if (unlikely(skb->len < dev->min_header_len)) {
> > +               pr_err_once("__bpf_tx_skb skb->len=3D%u <
> > dev(%s)->min_header_len(%u)\n", skb->len, dev->name,
> > dev->min_header_len);
> > +               DO_ONCE_LITE(skb_dump, KERN_ERR, skb, false);
> > +               kfree_skb(skb);
> > +               return -ERANGE;
> > +       } // Note: this is before we change skb->dev
> >         skb->dev =3D dev;
> >         skb_set_redirected_noclear(skb, skb_at_tc_ingress(skb));
> >         skb_clear_tstamp(skb);
> >
> >
> > -->
> >
> >
> > test_empty_skb:FAIL:ret: veth ETH_HLEN+1 packet ingress
> > [redirect_egress] unexpected ret: veth ETH_HLEN+1 packet ingress
> > [redirect_egress]: actual -34 !=3D expected 1
> >
> > [   58.382051] __bpf_tx_skb skb->len=3D1 < dev(veth0)->min_header_len(1=
4)
> > [   58.382778] skb len=3D1 headroom=3D78 headlen=3D1 tailroom=3D113
> >                mac=3D(64,14) net=3D(78,-1) trans=3D-1
> >                shinfo(txflags=3D0 nr_frags=3D0 gso(size=3D0 type=3D0 se=
gs=3D0))
> >                csum(0x0 ip_summed=3D0 complete_sw=3D0 valid=3D0 level=
=3D0)
> >                hash(0x0 sw=3D0 l4=3D0) proto=3D0x7f00 pkttype=3D0 iif=
=3D0
>=20
> Hmm. Something is off.
> That test creates 15 byte skb.
> It's not obvious to me how it got reduced to 1.
> Something stripped L2 header and the prog is trying to redirect
> such skb into veth that expects skb with L2 ?
>=20
> Stan,
> please take a look.
> Since you wrote that test.

Sure. Daniel wants to take a look on a separate thread, so we can sync
up. Tentatively, seems like the failure is in the lwt path that does
indeed drop the l2.


