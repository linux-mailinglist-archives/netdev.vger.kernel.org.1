Return-Path: <netdev+bounces-207900-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8655CB08F7D
	for <lists+netdev@lfdr.de>; Thu, 17 Jul 2025 16:33:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 00F935A3016
	for <lists+netdev@lfdr.de>; Thu, 17 Jul 2025 14:31:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4736B2F6FB1;
	Thu, 17 Jul 2025 14:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k41vL19H"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A35772F7CF1
	for <netdev@vger.kernel.org>; Thu, 17 Jul 2025 14:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752762664; cv=none; b=rRRU2Ucdb3zcIW0XU3/qAVknvr6lD1J+K3zbZzUHl1gp9f82pQLnqQFUtnCFuJ+JXkL/S5tt39U1o5QZdLeDhTo66pmEyBnDhWqBEedobKJwgUoxIutUjJ0P1l/QTqcLnDkBLJuyYZaw34pKbwRgvMIi1qvhFIFPucHlB0STiEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752762664; c=relaxed/simple;
	bh=fMk82LQti1PYxBHrhOVjCK4I3qTmIjBO5C8ixcr2Pj8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jf116X8/0iI/LfqOARKFw8ZFT4x2V75Vm2choY5iTR3LyQ5ztx25KcARQd51KkxU1q9HgxTrSJj77/zYxtGyLIlHj5MGweHMZAJb5gLnXVswCMXoW42e1q7MYPRSvP0Mc7jDqqp3jGQmKv9JuI6h2dA2X7OpWhn2xptH7C8qDdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k41vL19H; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-31384c8ba66so231882a91.1
        for <netdev@vger.kernel.org>; Thu, 17 Jul 2025 07:31:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752762662; x=1753367462; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mAffKrUvKrwws+WEcUU66A4dwqXdszCaIHB35+ZXulc=;
        b=k41vL19HCxrnGgKCNGhUbOD8BRdVT7E8zgExgpThhO1errv8Rv7lZg3qu1mFGd1/Vf
         W7tm9Cpi2tADK258aNAHtPpPpzlVrB+EioLBq+gakbPm13usmVqwaO5F44hDTeSbmHc5
         XAeNZoCONPLbEDFyFRulI1uYBbU3u4Cen/NuK1W0+K7wq6iJXKE8dvedVcyZDBvUYd4Q
         vnVQbbYKtu3+8ZoeBRELS9rt3tOH8D3hQ5qj61MGnemHCClGsJ3vupI4bRhaKs9NATDD
         6O0AgV1hpkAMVzxBmoAP8xq3SWxkzV/bQCFE2by/C3bSdQIKZJU/KoJKWhpvNheubpZa
         roKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752762662; x=1753367462;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mAffKrUvKrwws+WEcUU66A4dwqXdszCaIHB35+ZXulc=;
        b=b/vQQt49Wh+AjG154spUe1zOWIhlHoxxGb8DS/vZra2RkAMMi+Xgs3+YhLzEnFHB6W
         FTFUwD3k3HdzkLUZvvCCrjyg4FxGpixmepnrwIN1L69jBTNs9CAZx6rSIw7RkUwF/+X3
         RfNKIwMlLZ0ntIPNNFtr/aivcqZiykCL0CC8rM3FFzwPYUcKf/ZpqR2I+ymwNFfbnA/Y
         ra2Yvf/BXNhr3mhDqkCTh8GTQd1dT/oK2DGfsNcaUVPHyEuMCnyVn6Vd+bJwEBbY0C7H
         OtqztqgX1Qnzpo2vPuoniXm7rvvjzYwKQ/tdNKCHRM8ZWley6Vc/VMiNl+W9rwBxBGf7
         Sj5w==
X-Forwarded-Encrypted: i=1; AJvYcCVzweH8hxIGvIEyG7SsrQMSd7JtZDg+9Y4QvCmIylJYw1wZhruaLZk/N9fLunhVTS/n9tjnpZY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwOwvk64zBu3qSdox0Ooz0KdhrXXpGw+oviFuXHHv4ZOCSwpLq3
	l+C5yFqYRylu8c65JpQmRMGOQMQaHdRhWsb1LBncUGX/wiRtJziBqpXJzHPwfWVlvsaMEtFE94n
	Xx+m2x74fzYq9ayZ20MXQJCnY44/7Aw==
X-Gm-Gg: ASbGncsxHlbiLaH7X0govrm8mdwS+iQIP1cGF79cdWYDOLBWD9B3OPMMGB8Kgvly53F
	cA5YN9tmTtGVWt0hYDjFLeSjrEGduAYn4WESnK0ic/ccU+WpSU8LlQXiavGmDI7ojg7RA6SyVIx
	UcxaXEOeXTRdv9pdcbD+GLkddgPGlHlH/uUm9w9v8QN+MIYr2E+vA0wEKtAGrbAJYbfRWVRatPo
	CIQXPs=
X-Google-Smtp-Source: AGHT+IHw5NzP5gmyZwGez7QUII/gtmad6eHqDCJl75wSLnJqsb7k6NiAY2KKD8N03ZBEU68Tiw0gWH5a95G7VPTZkhU=
X-Received: by 2002:a17:90b:580c:b0:310:8d54:3209 with SMTP id
 98e67ed59e1d1-31c9e6e5e4dmr3812095a91.2.1752762661418; Thu, 17 Jul 2025
 07:31:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250713152253.110107-1-guoxin0309@gmail.com> <9c67190f-62c2-4498-937d-5213de1a3fe0@redhat.com>
 <CAMaK5_jfKogtZhdtBn91W44wrsWjE09Vm=76T1fXxemiA6pSVg@mail.gmail.com> <CADVnQym_hhAoM2nvYyz2vR1zJTcAP0FzOZ-st0SfXE=6g68eVA@mail.gmail.com>
In-Reply-To: <CADVnQym_hhAoM2nvYyz2vR1zJTcAP0FzOZ-st0SfXE=6g68eVA@mail.gmail.com>
From: Xin Guo <guoxin0309@gmail.com>
Date: Thu, 17 Jul 2025 22:30:47 +0800
X-Gm-Features: Ac12FXz7QS8cIUbeXp51Ns2PZh9pzK5PpmgnH7_ayDtibP3hjIEYRiiA2D3XoAE
Message-ID: <CAMaK5_jn4CULY_m+3vgNmcb7NArL=1JL3d_mD8v3PXWo89Pi2w@mail.gmail.com>
Subject: Re: [PATCH net-next] tcp: correct the skip logic in tcp_sacktag_skip()
To: Neal Cardwell <ncardwell@google.com>
Cc: Paolo Abeni <pabeni@redhat.com>, Kuniyuki Iwashima <kuniyu@google.com>, netdev@vger.kernel.org, 
	edumazet@google.com, davem@davemloft.net, dsahern@kernel.org, kuba@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

thanks neal,

the input parameter skb for tcp_sacktag_skip() is just a hint to avoid
rtx tree lookup,
if the hint does not take effect, the tcp_sacktag_bsearch() can also
find the right skb,
that is why it is hard to show the wrong behavior by packetdrill.

static struct sk_buff *tcp_sacktag_skip(struct sk_buff *skb, struct sock *s=
k,
u32 skip_to_seq)
{
if (skb && after(TCP_SKB_CB(skb)->seq, skip_to_seq))
return skb;

return tcp_sacktag_bsearch(sk, skip_to_seq);
}

Regards
Guo Xin.

On Thu, Jul 17, 2025 at 10:14=E2=80=AFPM Neal Cardwell <ncardwell@google.co=
m> wrote:
>
> On Thu, Jul 17, 2025 at 9:36=E2=80=AFAM Xin Guo <guoxin0309@gmail.com> wr=
ote:
> >
> > Hi Paolo,
> > Thanks for your review, let me explain in the thread first.
> > 1)let me start from tcp_sacktag_skip, the definition as below:
> > static struct sk_buff *tcp_sacktag_skip(struct sk_buff *skb, struct soc=
k *sk,
> > u32 skip_to_seq)
> > {
> > if (skb && after(TCP_SKB_CB(skb)->seq, skip_to_seq))
> > return skb;
> >
> > return tcp_sacktag_bsearch(sk, skip_to_seq);
> > }
> > the input skb is a hint to avoid search the RTX tree, and the condition=
 is:
> > skb->seq > skip_to_seq(so skip_to_seq cannot be included in skb),
> > as below:
> > 0----------------------------------------------|------------------>+ sk=
b->seq
> > 0--------------------|-------------------------------------------->+ sk=
ip_to_seq
> >
> > 2)let me check the code snippet in tcp_sacktag_write_queue()
> > the code try to speed up the search by using tcp_highest_sack(),
> > the code is from the rtx queue is a list, but now the rtx queue is a tr=
ee.
> > the mean is that if the start_seq >=3Dtcp_highest_sack_seq(), the we us=
e
> > skb=3Dtcp_highest_sack() as a hint to speed up the lookup(avoid to
> > lookup the tree).
> > so we can see that the skb->seq <=3Dstart_seq.
> > then if we use the skb and start_seq to call tcp_sacktag_skip(),
> > the tcp_sacktag_skip will go for rtx tree lookup, so
> > code snippet does not take effect.
> >
> > static int
> > tcp_sacktag_write_queue(struct sock *sk, const struct sk_buff *ack_skb,
> > u32 prior_snd_una, struct tcp_sacktag_state *state)
> > {
> > ...
> > while (i < used_sacks) {
> >
> > if (!before(start_seq, tcp_highest_sack_seq(tp))) {
> > skb =3D tcp_highest_sack(sk);
> > if (!skb)
> > break;
> > }
> > skb =3D tcp_sacktag_skip(skb, sk, start_seq);
> >
> > walk:
> > skb =3D tcp_sacktag_walk(skb, sk, next_dup, state,
> > start_seq, end_seq, dup_sack);
> >
> > advance_sp:
> > i++;
> > }
> >
> > 3) on the other side, let me show the logic in tcp_sacktag_bsearch, the=
 logic is
> >    the skb->seq should be met:
> >    seq=3D<skb->seq and seq<skb->end_seq
> > so the seq should be included in skb, the log is not consist with
> > tcp_sacktag_skip().
> >
> > static struct sk_buff *tcp_sacktag_bsearch(struct sock *sk, u32 seq)
> > {
> > struct rb_node *parent, **p =3D &sk->tcp_rtx_queue.rb_node;
> > struct sk_buff *skb;
> >
> > while (*p) {
> > parent =3D *p;
> > skb =3D rb_to_skb(parent);
> > if (before(seq, TCP_SKB_CB(skb)->seq)) {
> > p =3D &parent->rb_left;
> > continue;
> > }
> > //[Xin Guo] at here seq=3D<skb->seq
> > if (!before(seq, TCP_SKB_CB(skb)->end_seq)) {
> > p =3D &parent->rb_right;
> > continue;
> > }
> > //[Xin Guo]at here seq<skb->end_seq
> > return skb;
> > }
> > return NULL;
> > }
> >
> > i hope that it is more clear now, thanks.
> >
> > Regards
> > Guo Xin.
> >
> > On Thu, Jul 17, 2025 at 4:24=E2=80=AFPM Paolo Abeni <pabeni@redhat.com>=
 wrote:
> > >
> > > On 7/13/25 5:22 PM, Xin Guo wrote:
> > > > tcp_sacktag_skip() directly return the input skb only
> > > > if TCP_SKB_CB(skb)->seq>skip_to_seq,
> > > > this is not right, and  the logic should be
> > > > TCP_SKB_CB(skb)->seq>=3Dskip_to_seq,
> > >
> > > Adding Kuniyuki
> > >
> > > I'm not sure this statement is actually true. A more clear (and sligh=
tly
> > > more descriptive) commit message could help better understanding the
> > > issue. What is the bad behaviour you are observing?
> > >
> > > Ideally a packetdrill test case to demonstrate it would help
> > sorry that a packetdrill script cannot show the wrong behavior.
>
> I agree with Paolo that having a packetdrill test case for this kind
> of issue would be best.
>
> Can you please explain why you are saying that a packetdrill script
> cannot show the incorrect behavior for this issue?
>
> Usually packetdrill is a good fit for these kinds of protocol
> processing issues that do not involve performance or race conditions.
>
> Here are examples of test cases that stress SACK processing behavior,
> if that helps:
>   https://github.com/google/packetdrill/tree/master/gtests/net/tcp/sack
>
> Thanks,
> neal

