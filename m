Return-Path: <netdev+bounces-203411-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AD58AF5D4A
	for <lists+netdev@lfdr.de>; Wed,  2 Jul 2025 17:38:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A4C6F164C10
	for <lists+netdev@lfdr.de>; Wed,  2 Jul 2025 15:38:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D30B43196A1;
	Wed,  2 Jul 2025 15:35:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CWIbQor8"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 309193196A0
	for <netdev@vger.kernel.org>; Wed,  2 Jul 2025 15:34:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751470501; cv=none; b=Yl0Em+1djq648NsFtwuaD1JUXtvZBvzCT+068msAAhKnUIk+cHbU1GptbjRjfgkHrce/oRWBPU6VOJeJ8TM1x67TbQqqq+OeZq/K35VSuJH3/gD11myqtjpB/DRlqY6CVz10FWWsxRpAZCMQAXPC+qBwr7UiEBEW+4WXY2zUwWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751470501; c=relaxed/simple;
	bh=X5Pg+wgXFm16CVeDFpFrkfl+l1I+ELDxLnT2XAFjN+w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mctgPH0JG6rZwTrx/LZ4/C9YFcTcl24ZJGsnQg3L0XsWZ33bHwgCLisQDQC/NVtA8x9U/Oitfkpo7Ph7f2cwUw5u+68SzDLomlObeKt5YYoMeAGvzJgkvlYOnT8bJWJOUfiIw1YquTSXlHJm8emf78xd6mUg+oWo8p8kh7Mq7a0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CWIbQor8; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-4a43d2d5569so56233341cf.0
        for <netdev@vger.kernel.org>; Wed, 02 Jul 2025 08:34:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1751470499; x=1752075299; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6Ua8RzrDoKZ7Kn0p7xIvCw4idk9i+4iHFHwyTPoenIU=;
        b=CWIbQor8G3rPGOfzKBiLCuRddu5c5x274c6nJYcOnMaBqrI2cdVvfJGNc4iwfUDA6j
         /C7EeKq9xtaoQ+9+k9gdK6S6AjPa7JfxXjB2sPRguqbPVs6ddP8U/m85QaALXQ7j/7c7
         f2ANjEG/4T/uWKhg6JLjDVF8a4RqiR4xwoTYSFdLuypJhXBLoKDr+Z39aMv/mFbpUECl
         QQzyKku/vCArVHIVj1LISSyHnylcG0SAbaAnGgtQcE+JJ5bYQ/mVpjCEvmjxlimnF2g0
         B0HZ+J3AqwZ5X62mZ+uR/D67UU64aMPkiHPa/HFals0XZIZyIYYdDQ6HxoRJxWKVOwko
         B3Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751470499; x=1752075299;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6Ua8RzrDoKZ7Kn0p7xIvCw4idk9i+4iHFHwyTPoenIU=;
        b=mSTDI7y1risu1TfiT8a3uVFEW1TQzJMOiyObNgzHlyCIuQ9EESmB9rae8TYQuJv73o
         hSM2ZEzB/AIETEo6zxLNDA/3k/ISqBxQtCuFJ6EhD5B8WY8r7INvYdowaCeHXpsf8YAe
         1L8rauoN7UBqLsq8Fg6jhcfrszOFfS4W2nOTXYCcVO7ATn2SjBpDsNGqvJIv/6qn8RIu
         KhNnvjPLbYSeEU2/cZkrBsV6niBjwo5SpP2jh1Y/Al+B8sZuSM+4S5s3wSpl6IgIb4MX
         0/X0l+s0UzG0n1cwrMgsJlic1OpfXmErq866gV5N5NDAz4/evsssCuaAskJ7XWQJjKmD
         dqZQ==
X-Gm-Message-State: AOJu0YyR17i08YTnf2TFCgs4SMJLwQAtuIHGsIHrnj2dJjXr6hnJjYcF
	0RMiJNbt36RQ5A6FUSMXdIqMpT4JOv6guI7oS6wCQuPJHKZDkNPhwOlxsiWnf3B+uyKiNzNyAgW
	YPchxruepvuu9p7ExmiEnuCFaiAL0d1DrHhbE11/RTioFL1tyUsBlmUw5/fI=
X-Gm-Gg: ASbGncu5VM06h3/VCEk7SUfnuF/wrRCMfSjhyWM0KevTWA83i+LTLvCiXpU3K4P1Ajv
	XrFgeii7fnwAQrEx/mwzvR32hRis5JJ7I7ZFiz5ijFuCvZgLNELswzJiwXnCT1D4B0JzTi1/Y6q
	4/jz90kMrNSKFSHkcWvHjy+9DqigD6B5BCg3nXrizqUg==
X-Google-Smtp-Source: AGHT+IFpOBPmeAdBhhrmEqycOyHbAY2mEA2NG2sQ1+ED7v7Oou4lLiPkXSbxRz5Ry5wbchr7ZDqTH7qW9Jsw+HS7kiE=
X-Received: by 2002:ac8:5854:0:b0:4a4:3963:1e10 with SMTP id
 d75a77b69052e-4a9768b6d60mr68180191cf.13.1751470498608; Wed, 02 Jul 2025
 08:34:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250702110039.15038-1-jiayuan.chen@linux.dev>
 <c9c5d36bc516e70171d1bb1974806e16020fbff1@linux.dev> <CANn89iJdGZq0HW3+uGLCMtekC7G5cPnHChCJFCUhvzuzPuhsrA@mail.gmail.com>
 <CANn89iJD6ZYCBBT_qsgm_HJ5Xrups1evzp9ej=UYGP5sv6oG_A@mail.gmail.com> <c910cfc4b58e9e2e1ceaca9d4dc7d68b679caa48@linux.dev>
In-Reply-To: <c910cfc4b58e9e2e1ceaca9d4dc7d68b679caa48@linux.dev>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 2 Jul 2025 08:34:47 -0700
X-Gm-Features: Ac12FXx6jtg32Uv0ROfXCLrCxBt-tQEIP4ICXS08gQYhuKIX3AmgxQnC49weVtw
Message-ID: <CANn89iL=GR5iHXUQ6Jor_rjkn91vuL5w8DCrxwJRQGSO7zmQ-w@mail.gmail.com>
Subject: Re: [PATCH net-next v1] tcp: Correct signedness in skb remaining
 space calculation
To: Jiayuan Chen <jiayuan.chen@linux.dev>
Cc: netdev@vger.kernel.org, mrpre@163.com, 
	Neal Cardwell <ncardwell@google.com>, Kuniyuki Iwashima <kuniyu@google.com>, 
	"David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	David Howells <dhowells@redhat.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 2, 2025 at 8:28=E2=80=AFAM Jiayuan Chen <jiayuan.chen@linux.dev=
> wrote:
>
> July 2, 2025 at 22:02, "Eric Dumazet" <edumazet@google.com> wrote:
>
>
>
> >
> > On Wed, Jul 2, 2025 at 6:59 AM Eric Dumazet <edumazet@google.com> wrote=
:
> >
> > >
> > > On Wed, Jul 2, 2025 at 6:42 AM Jiayuan Chen <jiayuan.chen@linux.dev> =
wrote:
> > >
> > >  July 2, 2025 at 19:00, "Jiayuan Chen" <jiayuan.chen@linux.dev> wrote=
:
> > >
> > >  >
> > >
> > >  > The calculation for the remaining space, 'copy =3D size_goal - skb=
->len',
> > >
> > >  >
> > >
> > >  > was prone to an integer promotion bug that prevented copy from eve=
r being
> > >
> > >  >
> > >
> > >  > negative.
> > >
> > >  >
> > >
> > >  > The variable types involved are:
> > >
> > >  >
> > >
> > >  > copy: ssize_t (long)
> > >
> > >  >
> > >
> > >  > size_goal: int
> > >
> > >  >
> > >
> > >  > skb->len: unsigned int
> > >
> > >  >
> > >
> > >  > Due to C's type promotion rules, the signed size_goal is converted=
 to an
> > >
> > >  >
> > >
> > >  > unsigned int to match skb->len before the subtraction. The result =
is an
> > >
> > >  >
> > >
> > >  > unsigned int.
> > >
> > >  >
> > >
> > >  > When this unsigned int result is then assigned to the s64 copy var=
iable,
> > >
> > >  >
> > >
> > >  > it is zero-extended, preserving its non-negative value. Consequent=
ly,
> > >
> > >  >
> > >
> > >  > copy is always >=3D 0.
> > >
> > >  >
> > >
> > >  To better explain this problem, consider the following example:
> > >
> > >  '''
> > >
> > >  #include <sys/types.h>
> > >
> > >  #include <stdio.h>
> > >
> > >  int size_goal =3D 536;
> > >
> > >  unsigned int skblen =3D 1131;
> > >
> > >  void main() {
> > >
> > >  ssize_t copy =3D 0;
> > >
> > >  copy =3D size_goal - skblen;
> > >
> > >  printf("wrong: %zd\n", copy);
> > >
> > >  copy =3D size_goal - (ssize_t)skblen;
> > >
> > >  printf("correct: %zd\n", copy);
> > >
> > >  return;
> > >
> > >  }
> > >
> > >  '''
> > >
> > >  Output:
> > >
> > >  '''
> > >
> > >  wrong: 4294966701
> > >
> > >  correct: -595
> > >
> > >  '''
> > >
> > >  Can you explain how one skb could have more bytes (skb->len) than si=
ze_goal ?
> > >
> > >  If we are under this condition, we already have a prior bug ?
> > >
> > >  Please describe how you caught this issue.
> > >
> >
> > Also, not sure why copy variable had to be changed from "int" to "ssize=
_t"
> >
> > A nicer patch (without a cast) would be to make it an "int" again/
> >
>
> I encountered this issue because I had tcp_repair enabled, which uses
> tcp_init_tso_segs to reset the MSS.
> However, it seems that tcp_bound_to_half_wnd also dynamically adjusts
> the value to be smaller than the current size_goal.
>

Okay, and what was the end result ?

An skb has a limited amount of bytes that can be put into it
(MAX_SKB_FRAGS * 32K) , and I can't see what are the effects of having
an
"not optimally sized skb in socket write queue".

BTW if you have a tcp_repair test, I would love having it in the
tools/testing/selftests/net :)

Thanks.

> Looking at the commit history, it's indeed unnecessary to define the
> copy variable as type ssize_t.

