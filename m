Return-Path: <netdev+bounces-121269-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A38DE95C69E
	for <lists+netdev@lfdr.de>; Fri, 23 Aug 2024 09:36:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D69851C21127
	for <lists+netdev@lfdr.de>; Fri, 23 Aug 2024 07:36:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6F0313B5B6;
	Fri, 23 Aug 2024 07:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="heT4rUg6"
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f42.google.com (mail-io1-f42.google.com [209.85.166.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AB5913C9A3;
	Fri, 23 Aug 2024 07:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724398612; cv=none; b=E+YGxfA9hfdnODOxdCzXc5eQ2m892pcsZIPyiTbLI+ztn+fSKpDrEDijoVfdmlmGU5mQPrM2Y62wDdJ9PIiJwy3Ld5F4tVCngL51yGrNA3lFymBJpuE5t30S0MD0X+F1rXbMjrz5BOqhJUupV6899oWQkJnvHvf5nOTEnbXwM1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724398612; c=relaxed/simple;
	bh=L9gE+JUvzOvba8BbLBdWMZn1gyb9RcK9aIGmGZPU7Bs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dE6yRCVttaQ7MMvSm6nys2KckNO+fULzY1Cai7cS0s0+elXru3LXfFEj1gE7jecBc0EF7MhtqwQKopSWCPbiSehBwhcmRwSf/Xp9yMbPJyn/tPeg2I1JpVbxo4nyrOFcRqS3KhS/TxLfbntq+RI82/HrcAWPiP8h7amvBfpJvws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=heT4rUg6; arc=none smtp.client-ip=209.85.166.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f42.google.com with SMTP id ca18e2360f4ac-81f96ea9ff7so82634539f.3;
        Fri, 23 Aug 2024 00:36:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724398610; x=1725003410; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TCZHPcRS/qNkZXlCDgIK23wVIzXZrH14GSHjqvtSFCE=;
        b=heT4rUg64a+prXTeWbjlHS2hfUr+QfFrpjdZaEy4oKmHKcgeBR4IjYEr9DozCBp7j1
         1jMW38z3yl2TaSfA9leue1YRaHf8Cpy6iN4/6DH1pWP6M7aPrER+qp5N9cWkdVtk7GKn
         FF1bZChVnWLrNGBUP2ycZEyuuAyEySjMhl2WaZGn96DYq/iz1mU8TkCzQwAP1fDy8SGq
         p0rcW6SiHzWa0wgrSB9ZlvNMaj1E0om9SzBlbf/JgHAsTLUMivH1m8smpzgHUr7meRy2
         DSgDjHr/BUfDWCeA0AjT4HsQFH1HXzPphEZTVLLJERyuNJipzh1TxwcM1DE+z5rfc1B0
         FTIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724398610; x=1725003410;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TCZHPcRS/qNkZXlCDgIK23wVIzXZrH14GSHjqvtSFCE=;
        b=TV9LLCNYScHurMfJfK7ah47BoCA0CcKlsC/oB0116T3Pktf5vafv85MxobXpNAs2JF
         kySs6Sy6GfnIlTfc+rnTkE80fVSX0KHuzsFzljYvzIu7eWlBS04lQKZ+rtGs263c4vhE
         92wfYsUNO6lOnCUAX+kJIExoKGoKNdV7w+rI9N0ZuV4cpnyXf+6YUtJdtpVgHUiuO/MF
         pM48ALOMVNHAsY7tw6Y2JWDxB0OrSkGO3UkYopKipMm3gm94wx/He/zdU8MB9aLDH90q
         aLti+5nPZ1R8EghnIqXAJM23difd5RT5fll6aA/F6ejKGm9umHDVPvu2HJtsShgMWCcb
         n94Q==
X-Forwarded-Encrypted: i=1; AJvYcCUqzi0Z4ov8lpL9nIY5bxw4Lyi9v9YTiw64pcknV5dLxhlWb0RcHSmQGijQ5XUtRLMp3Q17KUg5@vger.kernel.org, AJvYcCXr0tbPEQ5KPOCKyprqpnX+RL+wCUyR6TEToCoAgtDJIGulOZ65xZnY6zwAdGeHqC6FDHQoYIKJzjVrMHQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxLZbwp9kUZtjv74cMoR3Yn+Pno6dk8Qe0WBVVExFQFEfYaLR3R
	BLimIcZp18qPeq2Ht3AhQaRdU4qQlH+h429NgJvBLCpJwU2lpCLBxhybe9ko+ru7mLArGQv8TI+
	eIk9zowqaeLL7oLNmJd0RVQonDZQ=
X-Google-Smtp-Source: AGHT+IE/h/iN9uN6fFbFNfXQsdhUQYZXi0r8+wohHcQa6XuYjC3UbdsEM94SA/QGVYf5mjofH/egjsNfJp9VFMi19lE=
X-Received: by 2002:a05:6e02:1547:b0:374:a781:64b9 with SMTP id
 e9e14a558f8ab-39e3c989d00mr12413085ab.13.1724398610259; Fri, 23 Aug 2024
 00:36:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240823021333.1252272-1-johunt@akamai.com> <20240823021333.1252272-2-johunt@akamai.com>
 <CANn89i+jT0E_N4k=ciw7XvJXLH15rA=8qexRi=7D3YPo5=ZoqA@mail.gmail.com>
In-Reply-To: <CANn89i+jT0E_N4k=ciw7XvJXLH15rA=8qexRi=7D3YPo5=ZoqA@mail.gmail.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Fri, 23 Aug 2024 15:36:13 +0800
Message-ID: <CAL+tcoB=wdX7-O7x_xOzpBgfxKLvYwjvLo-dve=+bRAfgL4OrA@mail.gmail.com>
Subject: Re: [PATCH net 1/1] tcp: check skb is non-NULL in tcp_rto_delta_us()
To: Eric Dumazet <edumazet@google.com>
Cc: Josh Hunt <johunt@akamai.com>, Neal Cardwell <ncardwell@google.com>, davem@davemloft.net, 
	kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 23, 2024 at 2:44=E2=80=AFPM Eric Dumazet <edumazet@google.com> =
wrote:
>
> On Fri, Aug 23, 2024 at 4:14=E2=80=AFAM Josh Hunt <johunt@akamai.com> wro=
te:
> >
> > There have been multiple occassions where we have crashed in this path
> > because packets_out suggested there were packets on the write or retran=
smit
> > queues, but in fact there weren't leading to a NULL skb being dereferen=
ced.
> > While we should fix that root cause we should also just make sure the s=
kb
> > is not NULL before dereferencing it. Also add a warn once here to captu=
re
> > some information if/when the problem case is hit again.
> >
> > Signed-off-by: Josh Hunt <johunt@akamai.com>
> > ---
> >  include/net/tcp.h | 15 ++++++++++++---
> >  1 file changed, 12 insertions(+), 3 deletions(-)
> >
> > diff --git a/include/net/tcp.h b/include/net/tcp.h
> > index 2aac11e7e1cc..19ea6ed87880 100644
> > --- a/include/net/tcp.h
> > +++ b/include/net/tcp.h
> > @@ -2433,10 +2433,19 @@ void tcp_plb_update_state_upon_rto(struct sock =
*sk, struct tcp_plb_state *plb);
> >  static inline s64 tcp_rto_delta_us(const struct sock *sk)
> >  {
> >         const struct sk_buff *skb =3D tcp_rtx_queue_head(sk);
> > -       u32 rto =3D inet_csk(sk)->icsk_rto;
> > -       u64 rto_time_stamp_us =3D tcp_skb_timestamp_us(skb) + jiffies_t=
o_usecs(rto);
> > +       u32 rto =3D jiffies_to_usecs(inet_csk(sk)->icsk_rto);
> > +
> > +       if (likely(skb)) {
> > +               u64 rto_time_stamp_us =3D tcp_skb_timestamp_us(skb) + r=
to;
> > +
> > +               return rto_time_stamp_us - tcp_sk(sk)->tcp_mstamp;
> > +       } else {
> > +               WARN_ONCE(1,
> > +                       "rtx queue emtpy: inflight %u tlp_high_seq %u s=
tate %u\n",
> > +                       tcp_sk(sk)->packets_out, tcp_sk(sk)->tlp_high_s=
eq, sk->sk_state);
> > +               return rto;
> > +       }
> >
> > -       return rto_time_stamp_us - tcp_sk(sk)->tcp_mstamp;
> >  }
> >
> >  /*
> > --
> > 2.34.1
> >
>
> Are you using a recent linux kernel version ?

I'm afraid that he doesn't. What that link shows to me is the
5.4.0-174-generic ubuntu kernel.

