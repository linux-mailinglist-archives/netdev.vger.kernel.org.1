Return-Path: <netdev+bounces-204972-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F2098AFCBA2
	for <lists+netdev@lfdr.de>; Tue,  8 Jul 2025 15:16:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 33135188B104
	for <lists+netdev@lfdr.de>; Tue,  8 Jul 2025 13:15:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2F39266B67;
	Tue,  8 Jul 2025 13:14:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Sxuj+IWq"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19C1D2676CD
	for <netdev@vger.kernel.org>; Tue,  8 Jul 2025 13:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751980495; cv=none; b=RyMpDPW1hyjrR0sLYk7M/Ikj3XnKiPC2irRP02pb+zfFpPVT7C+q6q6niNAaeSUfofKNXg+Xm9q4pfUOJ5i9CdH5q0hOFIMBjX3r39wF8CdosT0iPJnqRRk/qyFlk6nh1XDNn4d+274GHjYh/KV2wZNEj49VoX8I8RuAh9x0aKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751980495; c=relaxed/simple;
	bh=tFHJxPGdW7YLwiTCC+ymu4+wJwk75Gz2e+bYNG+XMZw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eNuofEPCp5aAHyH3yD9+SqBx139UfA8DbrbhAzptMd1ootNu2Rv/Is6Rn3C/fBJeoJslaalQEB4v1h/FRz7eXq9wgCs0kTzfOuhoNemAzI8ukQwRBWLL1DRHbQMO/zsdyAT4XS8Vc6CkawKwDteHF5140P4le2xE46VNYtQtfkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Sxuj+IWq; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-4a9bf46adedso20316411cf.2
        for <netdev@vger.kernel.org>; Tue, 08 Jul 2025 06:14:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1751980493; x=1752585293; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JJpRRm6OVnI3cucGqpSLTc5YS4ZE0AB/0aoKnTVMtNY=;
        b=Sxuj+IWqBMSYXqkqkQZpDJkq+WO4Vl0ZHTB8XO9w3opA2W+r4dhvD5gAy6tpj6vAEW
         clzjrPfR/hs3tItadxUNmoaXxBKeE/hK8KGamXoYk1QWmiw/BBmWC087/dSd21y1Hp+U
         SWzASBxoPs2I3ZzfPowWTSSlVRauw34oSWaWjjUcM8ad1eHRQ+S8sML6STA1/nMRuY2B
         22iP4LquI31hOONRDsQYzb6XFkgO4baNmlXDLG7+yU+ajTpfS37ogKolMudNuvBACrUE
         ik+mYvHFmikkwvvhsa7uldUXb2FWgk3YjTULLNbdhh9tizxLMPhHt3sz2aXeCzdPT8gW
         NRJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751980493; x=1752585293;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JJpRRm6OVnI3cucGqpSLTc5YS4ZE0AB/0aoKnTVMtNY=;
        b=B0upG/Um+gVHsLbdHf8yhriK5ZvZWh9XN/LAsrTeYLkD+f3Lou5DWlbuHhViTcTDTN
         Y+G6t0v0uuJwupezg/Xifq5T+FzagjxeLf7IvFkhASpgh5sgT70lipgTAiqF9CYQvvnS
         B/whoWpiGNAVJoknMheD5mb25Y9ATR0UdqYs0mb814FGJY6Op4X6ndTz2o+tK484k0k7
         9VhTsTFBzJNrEEJeZaphmWOuJVJGwRX0s2XtSMPtOySQkCEnIR0yaORa3mu2zquH6RLr
         lp1cj6gQRnLnLjqXTuhTs+oUImVnTFy5ZdE/mQU0fo3Lkxubcz+Ewcy7S85js6pefDOz
         7ckg==
X-Forwarded-Encrypted: i=1; AJvYcCVrmdu+78+0Lqitr3YD/LYmy5glRw7x7EWBeqK4miJ8sc1pFUus1EhS1tI32yr4R7Iven+g1DI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzSZ8iYk/ltTJNrxr0VM/83P8Q1dEOAI4g0LBcT80RD5WTdYFGN
	bEnNE/iO2ORtfqTBwLWNQ23z+/hMgjL7GTmuQ1Dw7tMrHlgVEkhFw1eCNUATQuAqTTJ0uq99z4N
	ikDICC+ngK/HfaJ96L+/jbBec9i3JoICiB6oEka5C
X-Gm-Gg: ASbGnctbwLvar+GuRKadLrXzC3r0Kvv0d/cnC/gHoV8wyQSqeNJWUil2amz7fTDmGTE
	EA2Ebcp2tJ6E5yIdYL847oHit8bGZVjGHxvLV1DTBpdjlvFHMnzDhOVaWYP0RDK4ZvHpqXqov9A
	g0lzSLkQbSdV/lCflvJPnYHf///IV7UiwIZFFbeDs/bxg=
X-Google-Smtp-Source: AGHT+IEANuXYI52IC+nTksgTnfEgr3/rVdCC9iVyAqqPQiP47XkztuAwmnTQXLFgp9fAuIoedVvzyodNH+Gl1BM+j5g=
X-Received: by 2002:a05:622a:a915:b0:4a9:a90a:7233 with SMTP id
 d75a77b69052e-4a9a90a85c0mr162163371cf.12.1751980492520; Tue, 08 Jul 2025
 06:14:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250707054112.101081-1-jiayuan.chen@linux.dev> <2554853.1751980274@warthog.procyon.org.uk>
In-Reply-To: <2554853.1751980274@warthog.procyon.org.uk>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 8 Jul 2025 06:14:41 -0700
X-Gm-Features: Ac12FXw1ODtOKJzzrY5ZGBbhogHnaEHF0oXr4Be5dtc0nZ0sr65yPqJTcxkS6ww
Message-ID: <CANn89iJm718SNK5kyEZYKioJmNnn4yFxg+t7=ph_GYXfd98C0w@mail.gmail.com>
Subject: Re: [PATCH net-next v4] tcp: Correct signedness in skb remaining
 space calculation
To: David Howells <dhowells@redhat.com>
Cc: Jiayuan Chen <jiayuan.chen@linux.dev>, netdev@vger.kernel.org, mrpre@163.com, 
	syzbot+de6565462ab540f50e47@syzkaller.appspotmail.com, 
	Neal Cardwell <ncardwell@google.com>, Kuniyuki Iwashima <kuniyu@google.com>, 
	"David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 8, 2025 at 6:11=E2=80=AFAM David Howells <dhowells@redhat.com> =
wrote:
>
> Jiayuan Chen <jiayuan.chen@linux.dev> wrote:
>
> > The types of the variables involved are:
> > '''
> > copy: ssize_t (s64 on 64-bit systems)
> > size_goal: int
> > skb->len: unsigned int
> > '''
> >
> > Due to C's type promotion rules, the signed size_goal is converted to a=
n
> > unsigned int to match skb->len before the subtraction. The result is an
> > unsigned int.
> >
> > When this unsigned int result is then assigned to the s64 copy variable=
,
> > it is zero-extended, preserving its non-negative value. Consequently, c=
opy
> > is always >=3D 0.
>
> Ewww.
>
> Would it be better to explicitly force the subtraction to be signed, e.g.=
:
>
>                 skb =3D tcp_write_queue_tail(sk);
>                 if (skb)
>                         copy =3D size_goal - (ssize_t)skb->len;
>
> rather than relying on getting it right with an implicit conversion to a
> signed int of the same size?
>
> If not, is it worth sticking in a comment to note the potential issue?

I prefer the old construct, without a cast. TCP has a lot of 32bit
operations, stcking casts or comments is not helping.

Note how throwing a 'bigger type just in case' was broken...

