Return-Path: <netdev+bounces-232495-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E44C9C06061
	for <lists+netdev@lfdr.de>; Fri, 24 Oct 2025 13:39:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2FFC13BF62F
	for <lists+netdev@lfdr.de>; Fri, 24 Oct 2025 11:31:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55E59325499;
	Fri, 24 Oct 2025 11:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gTZUT3tl"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4C1E31281B
	for <netdev@vger.kernel.org>; Fri, 24 Oct 2025 11:19:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761304762; cv=none; b=FMw+AFA2LNJSg/S8rDPsQuqvtK2ce0XsI4+M7AAHW0607PX6bffQdGkHdbocnxZSpNhRS/RbhYuhF9L5tFC6590P/BxG7dq7LcehDzCmIivRz+VRMDJ2dSV4l4udoJnUthA6IUSYj4mDkydC8jpH/CDE//9k638bGwJNTZs69l4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761304762; c=relaxed/simple;
	bh=Sfdhjd26tHIqn6DDeWzJAEuOU33gdnLzwbwpp9QYd+A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pS65F8MaNOm8nvpC4jVjxH64/RdZLJJk7cmwRt9TE/zlP0IjuewouebtZSDghL+8faxSALZQWXRm7LEnJS0vwd6shn+c+TW43Oc9hmlgO3o5juNEUxjZcREpS8va7J9Q+1DJwtZedFbglWUD9guKS1Q5kNM6DV5Njb4ygGi/8Jc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gTZUT3tl; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-88f239686f2so178373285a.0
        for <netdev@vger.kernel.org>; Fri, 24 Oct 2025 04:19:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761304759; x=1761909559; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NR7r7A7Ngj2AtH8w3czO0pbxI+2n3qBa+PkWodViy2o=;
        b=gTZUT3tlUidpMMlPH6MiAV6UuqfflBBSd/oX8/jp8pqE87mGPGofOwxKmew7dS86yN
         uEdCCZ6orwkMAJ3IFlIETf/90eGtPt5aHUW39Arca1yR9Z1r5wm4Owg75GNnQNjZK6mU
         TNwskZysZrXYX+KXJg1OFO59+kbm7Sq2aOrvUSUMm0pR7buQklXJ/OKfTI61ZzDEnWqM
         X7p4AKuz1FFbixpAlFU49i0yuKaQ+Kn7GzbCkKxxCFv+4hw67f9uRxKKc0rNhezM03hk
         fqBv29m0Qb4bBrGNdiMFR6sU9jjipCKtEQNEvw21cWUImBdt9auf4xTeiA6hO/yzeYxy
         qeaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761304759; x=1761909559;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NR7r7A7Ngj2AtH8w3czO0pbxI+2n3qBa+PkWodViy2o=;
        b=N0XXlJAkhm04t33lg9PSbfYKzoi4uMoQHFLwMKg+ECYExvcppWoN7imMjDD0CjuO/k
         /s3Nk7+gsrCNoE1AEDv9VEGRgROpaah4lMX/2yat5sFtz5U0paIxmg8jXhly1owBNKds
         nWLZiwMzrMjzvBK0o/a8dxP0agykQyL8xU0NDuIQEURzLO3+LHS4x+dD7LBHAke2TAf2
         MtTNjAOv1L9QnDvcsNqjsVWut70AcrrrDjKbKC/0Q4Ysa5upvp9dHUXiygOia9nHaQlG
         piCpnZ/68nYKGwiejHNBCDdUBhIBpYJko0ntq6O9/slw8L+fEUrRmRPyeQ7xhJj7z9gy
         0S1Q==
X-Forwarded-Encrypted: i=1; AJvYcCW6pKARdUfgTHlb8KQ1256jUhLs/ZPpxKCytUSEGI5qOBmiBqdL/lvdvOmvSsO3WGi8fh436z0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxUOFUksipjEEmoiuPjUhMcHzd7WcQTh/OpUR7Bz/wFVA6ZJqyZ
	wsvzdJ2UtOtYUrXPsBuKd2Jzhl6wE86RtD9rStA3dw5b/RSzYwAsLN50j0Y5aJ1NNrRmT5JsjN1
	iz2aFVsdUrdOUo9cesYTlm55j0m7QLroYLnWfkxZW
X-Gm-Gg: ASbGnctARTLaOFK4a6h+PZNWUkKEDmfUpKzv9j2DbFDlfu23zRvy/JcAtfQ6DA8qqR1
	AcmOdu5mlfzDEym1tYfgjikuHjeRQHyfM6xSyQKU15/entmjOi0xzna3DqJXMN+6FFWwqgKlYYx
	YBlWDqkwLnUleP6+8+E2IMkuloNVHlH6n4vB0Dek9kLJ/4PRg1njE9Y2m4ab6dQM/mIqrguBcrv
	TeOXhN62yFb2Sy53VI8RdfsO9rY8F/ml3kXLbLyiR+AKR6tzXZXA4V4FkqCT6XsWG9v8Q==
X-Google-Smtp-Source: AGHT+IHyvI+Mmgy3RXRlZdoCgp07uXS7VVdrKaUvb7vLQ5HWPx881FINwJusgXGHFEhc/7QR3UPWKsWoHezYFYPeZDQ=
X-Received: by 2002:a05:620a:1a8b:b0:892:18d3:9bb9 with SMTP id
 af79cd13be357-89218d39cb7mr2846491785a.71.1761304758930; Fri, 24 Oct 2025
 04:19:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251024075027.3178786-1-edumazet@google.com> <20251024075027.3178786-3-edumazet@google.com>
 <67abed58-2014-4df6-847e-3e82bc0957fe@redhat.com>
In-Reply-To: <67abed58-2014-4df6-847e-3e82bc0957fe@redhat.com>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 24 Oct 2025 04:19:07 -0700
X-Gm-Features: AS18NWDfuvj3t8yyqxVQXpWE8NbiyvZC-TKVU5IAa-xj7m26KJfgN1Hh38yPmxo
Message-ID: <CANn89iLjPLbzBprZp3KFcbzsBYWefLgB3witokh5fvk3P2SFsA@mail.gmail.com>
Subject: Re: [PATCH net-next 2/3] tcp: add newval parameter to tcp_rcvbuf_grow()
To: Paolo Abeni <pabeni@redhat.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Simon Horman <horms@kernel.org>, Neal Cardwell <ncardwell@google.com>, 
	Willem de Bruijn <willemb@google.com>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Matthieu Baerts <matttbe@kernel.org>, Mat Martineau <martineau@kernel.org>, 
	Geliang Tang <geliang@kernel.org>, netdev@vger.kernel.org, eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 24, 2025 at 3:09=E2=80=AFAM Paolo Abeni <pabeni@redhat.com> wro=
te:
>
> Hi Eric,
>
> Many thanks for tracking this down!
>
> Recently we are observing mptcp selftests instabilities in
> simult_flows.sh, Geliang bisected them to e118cdc34dd1 ("mptcp: rcvbuf
> auto-tuning improvement") and the rcvbuf growing less. I *think* mptcp
> selftests provide some value even for plain tcp :)
>
> On 10/24/25 9:50 AM, Eric Dumazet wrote:
> > diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> > index 94a5f6dcc5775e1265bb9f3c925fa80ae8c42924..2795acc96341765a3ec6565=
7ec179cfd52ede483 100644
> > --- a/net/mptcp/protocol.c
> > +++ b/net/mptcp/protocol.c
> > @@ -194,17 +194,19 @@ static bool mptcp_ooo_try_coalesce(struct mptcp_s=
ock *msk, struct sk_buff *to,
> >   * - mptcp does not maintain a msk-level window clamp
> >   * - returns true when  the receive buffer is actually updated
> >   */
> > -static bool mptcp_rcvbuf_grow(struct sock *sk)
> > +static bool mptcp_rcvbuf_grow(struct sock *sk, u32 newval)
> >  {
> >       struct mptcp_sock *msk =3D mptcp_sk(sk);
> >       const struct net *net =3D sock_net(sk);
> > -     int rcvwin, rcvbuf, cap;
> > +     u32 rcvwin, rcvbuf, cap, oldval;
> >
> > +     oldval =3D msk->rcvq_space.copied;
> > +     msk->rcvq_space.copied =3D newval;
>
> I *think* the above should be:
>
>         oldval =3D msk->rcvq_space.space;
>         msk->rcvq_space.space =3D newval;
>

You are right, thanks for catching this.

I developed / tested this series on a kernel where MPTCP changes were
not there yet.

Only when rebasing to net-next I realized MPTCP had to be changed.

> mptcp tracks the copied bytes incrementally - msk->rcvq_space.copied is
> updated at each rcvmesg() iteration - and such difference IMHO makes
> porting this kind of changes to mptcp a little more difficult.
>
> If you prefer, I can take care of the mptcp bits afterwards - I'll also
> try to remove the mentioned difference and possibly move the algebra in
> a common helper.

Do you want me to split this patch in two parts or is it okay if I
send a V2 with
the a/msk->rcvq_space.copied/msk->rcvq_space.space/ ?

