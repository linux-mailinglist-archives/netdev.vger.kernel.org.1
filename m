Return-Path: <netdev+bounces-129401-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B7557983AA0
	for <lists+netdev@lfdr.de>; Tue, 24 Sep 2024 02:38:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E76461C216D2
	for <lists+netdev@lfdr.de>; Tue, 24 Sep 2024 00:38:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FFEB1B85F8;
	Tue, 24 Sep 2024 00:37:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UGuWUvOa"
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f50.google.com (mail-io1-f50.google.com [209.85.166.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6BC11BC20;
	Tue, 24 Sep 2024 00:37:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727138277; cv=none; b=CTVm1e57iT+qPfeIVwVyiUf5gTcbR+vCKVDEG0Sjchngsr+xLmwhNFNCIARniAeU0EtIjse7CItfRq0ZZmVAK7FlcWf6TpdakTzfUl4tuigkSBFfyCwzv/fEIaBlQluQ57x9VfJs4vqHXqH8HItwPJrsvrfp6BkzI+E7QRlH/MA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727138277; c=relaxed/simple;
	bh=lwPWHsjc0EVxstWs9UcwMvi0k777RTvB+ISlYwiYFhw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BMiAyH6cg1ThexR9SEciYs8QGEnFj3BbiMo8D7ZBFcYv3TsD0kF7asIxmuKLVJJ2kERUqGCvLxVGedntwy6gbM85eEtPIb7ppJPl3dLsvapoIF2JrkKkxMRZx3nF+iOACJDXQmBCZWfhWrjPjCHSZpNP7GfHOYC9rmZNIbj003Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UGuWUvOa; arc=none smtp.client-ip=209.85.166.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f50.google.com with SMTP id ca18e2360f4ac-82a109bc459so212761439f.1;
        Mon, 23 Sep 2024 17:37:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727138275; x=1727743075; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WbUcHGQ1UoXWgfE/17dhmDmpoz0qafV9wtyHq8QWeMc=;
        b=UGuWUvOaI1EQVzRdBLFWa1CBEzbVeBLO/qPVi6/SE7giY0yE8jnwWZbo5drCZ5qsZU
         wW4YMBhq6wkuvMOJwRzqQmgrHu81QjYeFvxz0hKlxI//Tw5wczAxwItedb+LaJ0wLg0B
         xgB3+c9rgdQTxwbdQkhePXPGxL8z4UDfjICY5cAcrMbSpMrNNLbcwYrmD3OKpMYB2VGE
         JvRvhZMxF11xBy6QhdF4j2cFcypXrQvM7CsCJ8e73HRd+IPHU6FBJBsR7iqFM/TtXFKI
         ZL6LPnstjSlwXWeBV8kZPbZ8UG+WxbihYsATMpg58wXjfgwgratccj3JoFO6KrLezCcq
         QLpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727138275; x=1727743075;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WbUcHGQ1UoXWgfE/17dhmDmpoz0qafV9wtyHq8QWeMc=;
        b=Tc5ZCtNANL2GVCR4InAT3LKprlMxuloC25abnActrKcCt80j8hzTNhbi8wMLylyvcM
         pHnrFaEtOWpXNE5grnNGWsRoC8/eoL49+BIA14rBQqWwDM1gWR/5P2G0DVQ8vK5uFWj6
         2kjOX7kwi89Y4ySmeSEUPNV6nQayBF/dpn8iKOyt6Az2SN9rhfFzynhRNZiz9CRQYo+a
         l/j5Xdkr1StLupVDWk3/C9v1sKCWo6kghe+muwrjYBgYLzsitSBT7xE1pawTPtHz+X1y
         YBhUP0b2hKbYm0IF5t2TqYl9II55jPeWZaI1819p9A4e6YaN5JpcyWa4+AvNXjGHrfjj
         r3vQ==
X-Forwarded-Encrypted: i=1; AJvYcCULRJcEtq5+m8sX1VMqAJYHNxOahAPJMFGgzdtiCrf0rpUpcOFCYFGriHM+bYJODF7wr50Suqn2/LhnWZ0=@vger.kernel.org, AJvYcCXQEgXMPmW/vjsmAPvAmj/So5+NW/HZFsUd1Fjjf1mHroIHvb+pjKmDXHc5gc2Io8KJkiAjCftb@vger.kernel.org
X-Gm-Message-State: AOJu0YwCDo+wdaVpT0MvxJQgZ/EAI8v1cDQNvMR6qk7nTbknhQDdD/1U
	82SskjwINu7tgaUS6TZ+d0nanx31+yL/l7X+6P4W5LdbE0znBw/ZUHRJY8vOns2Zg1gR4jZjY/7
	nSUqKeJKJa2PPtuBS7H13VEQREr8=
X-Google-Smtp-Source: AGHT+IGrUStRnWPkF8QdOVTEHShSthaD4ticcBLkQrUJgx+tW9PPwzqJV/AlPcjpLLKPRdLFJuUS/mgbIKo5kHgzeE0=
X-Received: by 2002:a05:6e02:2144:b0:3a0:a057:6908 with SMTP id
 e9e14a558f8ab-3a1a302a9a8mr11439775ab.11.1727138274782; Mon, 23 Sep 2024
 17:37:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240910190822.2407606-1-johunt@akamai.com> <5632e043-bdba-4d75-bc7e-bf58014492fd@redhat.com>
 <CADVnQykS-wON1C1f8EMEF=fJ5skzE_vnuus-mVOtLfdswwcvmg@mail.gmail.com>
In-Reply-To: <CADVnQykS-wON1C1f8EMEF=fJ5skzE_vnuus-mVOtLfdswwcvmg@mail.gmail.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Tue, 24 Sep 2024 08:37:18 +0800
Message-ID: <CAL+tcoCMrENefD=55fkGRBAE9ZeuwgB7UG03JggSiguG-QVZiw@mail.gmail.com>
Subject: Re: [PATCH net v3] tcp: check skb is non-NULL in tcp_rto_delta_us()
To: Neal Cardwell <ncardwell@google.com>
Cc: Paolo Abeni <pabeni@redhat.com>, Josh Hunt <johunt@akamai.com>, edumazet@google.com, 
	davem@davemloft.net, kuba@kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 20, 2024 at 1:36=E2=80=AFAM Neal Cardwell <ncardwell@google.com=
> wrote:
>
> On Thu, Sep 19, 2024 at 5:05=E2=80=AFAM Paolo Abeni <pabeni@redhat.com> w=
rote:
> >
> > On 9/10/24 21:08, Josh Hunt wrote:
> > > diff --git a/include/net/tcp.h b/include/net/tcp.h
> > > index 2aac11e7e1cc..196c148fce8a 100644
> > > --- a/include/net/tcp.h
> > > +++ b/include/net/tcp.h
> > > @@ -2434,9 +2434,26 @@ static inline s64 tcp_rto_delta_us(const struc=
t sock *sk)
> > >   {
> > >       const struct sk_buff *skb =3D tcp_rtx_queue_head(sk);
> > >       u32 rto =3D inet_csk(sk)->icsk_rto;
> > > -     u64 rto_time_stamp_us =3D tcp_skb_timestamp_us(skb) + jiffies_t=
o_usecs(rto);
> > >
> > > -     return rto_time_stamp_us - tcp_sk(sk)->tcp_mstamp;
> > > +     if (likely(skb)) {
> > > +             u64 rto_time_stamp_us =3D tcp_skb_timestamp_us(skb) + j=
iffies_to_usecs(rto);
> > > +
> > > +             return rto_time_stamp_us - tcp_sk(sk)->tcp_mstamp;
> > > +     } else {
> > > +             WARN_ONCE(1,
> > > +                     "rtx queue emtpy: "
> > > +                     "out:%u sacked:%u lost:%u retrans:%u "
> > > +                     "tlp_high_seq:%u sk_state:%u ca_state:%u "
> > > +                     "advmss:%u mss_cache:%u pmtu:%u\n",
> > > +                     tcp_sk(sk)->packets_out, tcp_sk(sk)->sacked_out=
,
> > > +                     tcp_sk(sk)->lost_out, tcp_sk(sk)->retrans_out,
> > > +                     tcp_sk(sk)->tlp_high_seq, sk->sk_state,
> > > +                     inet_csk(sk)->icsk_ca_state,
> > > +                     tcp_sk(sk)->advmss, tcp_sk(sk)->mss_cache,
> > > +                     inet_csk(sk)->icsk_pmtu_cookie);
> >
> > As the underlying issue here share the same root cause as the one
> > covered by the WARN_ONCE() in tcp_send_loss_probe(), I'm wondering if i=
t
> > would make sense do move the info dumping in a common helper, so that w=
e
> > get the verbose warning on either cases.
>
> That's a good idea. It would be nice to move the info dumping into a
> common helper and use it from both tcp_rto_delta_us() and
> tcp_send_loss_probe(), if Josh is open to that.

Hello Paolo, Neal,

I noticed that this patch got merged already. Since extracting the
common part into a helper belongs to net-next materials, if no one is
willing to do it after net-next is re-opened, I think I can post it :)

Thanks,
Jason

