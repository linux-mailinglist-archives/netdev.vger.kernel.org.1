Return-Path: <netdev+bounces-97999-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D5A0D8CE847
	for <lists+netdev@lfdr.de>; Fri, 24 May 2024 17:52:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 46BD61F21641
	for <lists+netdev@lfdr.de>; Fri, 24 May 2024 15:52:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 557FB12C49F;
	Fri, 24 May 2024 15:52:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pITfvZRh"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2865126F04
	for <netdev@vger.kernel.org>; Fri, 24 May 2024 15:52:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716565953; cv=none; b=iUNFqfDtreAe9QKvEYVNpQ5SIOc1+F2DmNpbkxLc5frR/5FJfG08oRiJIuuqzaJCFRN1+Kl/t5HoZ6kK0uOvcfSZAECxXATcIvHrCYdsUOUs8w6/hjRmm2FECrNIGOySCq9Srnzu9P9gOvurOFtV609LB1ahWnk7QVglbQyqkcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716565953; c=relaxed/simple;
	bh=yJ7lJCpbC9fMmD/ag8df8UaOX++uju3u39h1FMPE2hY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WRPNjOsop9vnaybRmqPMLsZB0ikdgXEkS73M3wHprn8qkPk4HSAA3/WL1Eicx4i6uEMDRGjSUp0dLdmF+Mv99q+sP4CDmV9F1Cv6LzmCZelCHt6Cmp8j9iQ9HMi7ieDChgO1/pi/iKTxwobzQ/PmSXSVjnm2YdgtlNzmBmpjokI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pITfvZRh; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5750a8737e5so16819a12.0
        for <netdev@vger.kernel.org>; Fri, 24 May 2024 08:52:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1716565949; x=1717170749; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NzGX0CP/H8BaHhk4z3K59ZI2pjkcBBIz6sF8ILE7vzE=;
        b=pITfvZRhFJSFOqL+m24b84E5Os4NJxIh06tgrmBeg0FsFM5Zzlm8N6WsQ7qRXonaC1
         LPAHJnbxaot5OKph3Ixs4HD/TxfkMpB0rvIunlp9GET56pn8qPdtMiB7ZG+TcO7CyD+1
         DFSO7f27+2UwwRnyPHha/k5nmCXfU9dj2ZN6vOi0OjVybLnyEDxtsRMkSEqLstId4lIl
         tjI4z8dxPmxF3mWc7TiH+Nf6UpuJk8JKcR8wWBDxH41uvQaR+cMTuqHDQT6lablwlTuB
         td7jTvK40TivHmjeyyU29wDyrujFhf4Zc0DRXLVw9pEPc1aMzcpIgsWNZn6vV646vTSV
         oF1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716565949; x=1717170749;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NzGX0CP/H8BaHhk4z3K59ZI2pjkcBBIz6sF8ILE7vzE=;
        b=hhaUbnEhSnhQG9yKhwHDjuHPH2NR2xVe7kpj5IrjNP/MEB8xGdJYEs2IalNbYB8ZRk
         bvkqwv947io1I0LAncyXvDM//haZ9cm143Utykcoi3BknG2SvRmazM04rIdzCiJj6ENe
         LE87WctenQDRGxjFKeIodz9CIL2e+miEsPB4YoKR2GAzdgu3gfY/4UGDpuZNPAqgKdlK
         1sPnABPF67/gYmgq33GzQIDXcwpMDsSW2OAiLu6lym5wVTCdA8Z4kgIZE3o38HOkbzfp
         8fAAT100On4rhaWuIBMiA2jE3mP4sjg2R+qe+GCWU6JWw2uaeN7UiczXKeMPy/eqAEip
         3Y/A==
X-Forwarded-Encrypted: i=1; AJvYcCUn/257oZGQ+p/qA4AfSGFD2NSwgKAgyrqCScZq0Gu04r4dyUM5GMMIq67X1H7/Fq/SHlfMdZOVd+iz49oiLkyE9pOycMd4
X-Gm-Message-State: AOJu0YxfXaKr8XZ85KrmHEgXSylNZmMgiiweOijnou8zXFz72Nyg1kfO
	A3HKvPuHBw3YE7CsPTX76hH466gQiGWGdX87Yuq1Bno9rV4VWJrpV5voaBovPbo5Bu14VsDn//+
	1YGeSB/ZHXRj8pk9CIKIP9moz77J1MFt8YixS
X-Google-Smtp-Source: AGHT+IEZeslY1h9j9CCmD24z8wuv/oWb2BeUpYOjuE4PHIhWMGmbE+aoV8NgRKRVIhwt1p4ufs2U5WjNB9ffi77OVxg=
X-Received: by 2002:a05:6402:706:b0:578:5d8a:8ff6 with SMTP id
 4fb4d7f45d1cf-5785d8a96ebmr127249a12.2.1716565949168; Fri, 24 May 2024
 08:52:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240523134549.160106-1-edumazet@google.com> <20240524153948.57ueybbqeyb33lxj@skbuf>
 <CANn89iKwinmr=XnsA=N0NiGJhMvZKXuehPmViniMFo7PQeePWQ@mail.gmail.com>
In-Reply-To: <CANn89iKwinmr=XnsA=N0NiGJhMvZKXuehPmViniMFo7PQeePWQ@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 24 May 2024 17:52:17 +0200
Message-ID: <CANn89iKtp6S1guEb75nswR=baG4KN11s9m+HQZQ+v_ig3tOUfg@mail.gmail.com>
Subject: Re: [PATCH net] net/sched: taprio: fix duration_to_length()
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Jamal Hadi Salim <jhs@mojatatu.com>, 
	Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, syzbot <syzkaller@googlegroups.com>, 
	Vinicius Costa Gomes <vinicius.gomes@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 24, 2024 at 5:50=E2=80=AFPM Eric Dumazet <edumazet@google.com> =
wrote:
>
> On Fri, May 24, 2024 at 5:39=E2=80=AFPM Vladimir Oltean <vladimir.oltean@=
nxp.com> wrote:
> >
> > On Thu, May 23, 2024 at 01:45:49PM +0000, Eric Dumazet wrote:
> > > duration_to_length() is incorrectly using div_u64()
> > > instead of div64_u64().
> > > ---
> > >  net/sched/sch_taprio.c | 3 ++-
> > >  1 file changed, 2 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/net/sched/sch_taprio.c b/net/sched/sch_taprio.c
> > > index 1ab17e8a72605385280fad9b7f656a6771236acc..827fb81fc63a098304bad=
198fadd4aed55d1fec4 100644
> > > --- a/net/sched/sch_taprio.c
> > > +++ b/net/sched/sch_taprio.c
> > > @@ -256,7 +256,8 @@ static int length_to_duration(struct taprio_sched=
 *q, int len)
> > >
> > >  static int duration_to_length(struct taprio_sched *q, u64 duration)
> > >  {
> > > -     return div_u64(duration * PSEC_PER_NSEC, atomic64_read(&q->pico=
s_per_byte));
> > > +     return div64_u64(duration * PSEC_PER_NSEC,
> > > +                      atomic64_read(&q->picos_per_byte));
> > >  }
> >
> > There's a netdev_dbg() in taprio_set_picos_per_byte(). Could you turn
> > that on? I'm curious what was the q->picos_per_byte value that triggere=
d
> > the 64-bit division fault. There are a few weird things about
> > q->picos_per_byte's representation and use as an atomic64_t (s64) type.
>
>
> No repro yet.
>
> Anything with 32 low order bits cleared would trigger a divide by 0.
>
> (1ULL << 32) picoseconds is only 4.294 ms

BTW, just a reminder, div_u64() is a divide by a 32bit value...

static inline u64 div_u64(u64 dividend, u32 divisor)
...

