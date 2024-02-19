Return-Path: <netdev+bounces-72996-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CA5F85A97C
	for <lists+netdev@lfdr.de>; Mon, 19 Feb 2024 18:01:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 39B8C2865CB
	for <lists+netdev@lfdr.de>; Mon, 19 Feb 2024 17:01:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B44DD446AD;
	Mon, 19 Feb 2024 17:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qbo0KzS7"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC77B446CF
	for <netdev@vger.kernel.org>; Mon, 19 Feb 2024 17:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708362046; cv=none; b=BSwoI64tJwgBdJoh2pFZe1/MQ8HPSacYC2SHjK5/FaBhXOukMK/9iw4D9v6PSPOfAQULiulwHW58ifYNRHclFC6v+f07jZsSreQGN5iijZVlw3bwvreWd+Gu7NWyrH6ykEWtiw8f3eGodMku9hy9taSps8xN05StLyjvYp0n8ps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708362046; c=relaxed/simple;
	bh=kbpkVZoG5hRtT8j73NBW8Qbl9uRRCUUDUhvgUIqnWrI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZMLssbPCGWUyu06fZwTy33c07VtPptHOXiQPFWGdSeOFsFMOD0XA1KbikR7+Az9D2rFF/+ANUUqEY+QCuk3eRuf1QKqCzryEh0AVg/o6Gq/ufRkWYgWAwub6So4Wx0mk55pWllFxQfPzS3HoRSa8o8wnmNXYNIXkjvXPPeM2Vfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qbo0KzS7; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5645f0b887fso10412a12.1
        for <netdev@vger.kernel.org>; Mon, 19 Feb 2024 09:00:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708362043; x=1708966843; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OoBtJh1w/AZ/vFKy+v+H37e6uES5sEPko1VdAo5E4ac=;
        b=qbo0KzS7iZYLaKvCeemBc2ucBHFV+IiOnb0BlWkm7MuJ/Yd8VR4E7+xgObw9LbwX6W
         lbZsyC0Pq1nRUjNqj9n1yKB1IA0uT0Gk2RQWxwNaKSb8g/Jn9SjbSLcLL2HzLJL9JJzE
         lNzfYGsiCj7tQw8jjKrZ+8CH8AjgtubfGIuTK8YtK6WMf3txQnM77DeKG3hnNO86Cmwq
         92p2wmqgjnoqjpWn5hLpckdoGvUiRtWZDiJ+tG7PQEq2RiFjO3e54Vu6EX2Zw19A3Kun
         McHFnA+Cl2ibmbilUrUeanFQsGBao9Z77gNiN2k2vD/UXJ5ON1qePzdvaOmPkwR2of7V
         0Ibw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708362043; x=1708966843;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OoBtJh1w/AZ/vFKy+v+H37e6uES5sEPko1VdAo5E4ac=;
        b=Q/MJRD6YHQuRO0tKzPnXDnchNihj7pfvPsmW85aWu5JlRRWpfCWq8MGS5c5xHENxX9
         uW6AKPooEV0Ew49K1yK5gvx3+GVMRvCBshvrCL1CJDhYqEWQvo/SoI0F9cX3OZ88VFkC
         wCQwlnk8VRVuM0K4Ug4gbDJAFHBsL8WMyDzZGoF/m+cU3oIBBhPATCA0WQt9AXMcMBBP
         NW68Ua3r7Vl9Nu/DtYOiVC7eo29zCV8hP1xLvz6pGZS0qGkS6YnA0Lm3hYQJfL1VPzVb
         sIOjXMzOmq4Xj8pt83H+9ebGu2lRpY3WriaE4NkeCHPeC7teLNVyVaTnmgsFTKTdRdlg
         mUmQ==
X-Forwarded-Encrypted: i=1; AJvYcCUJSCfjkAjORoY3OfVx/Kz769byHvacm6YufDKml2+ECyyiZm7b5cyAMw5d/lRJt3F8ndGFCp8sDktHw+NJiD9nbScdSNLJ
X-Gm-Message-State: AOJu0YwNG6XFJ0BsROoB1ixNeMe9j/Zcm4AihoLG7ZaJ/UBMLqtggZKO
	PeA54ZkBcblZAYnR1Ds58qhSeffzx0zCtmVTNKFkr0sBVWYSIQqUNI31IyLOVRPVJn+1WXOSasI
	x62MOfvte2lPf+1zt3zeX6/t1ncE+5VcoFLGebtfJ7ZF4HYkfXVn2
X-Google-Smtp-Source: AGHT+IEh3Dk6/zyUN3eKRDkjI5RviE7VdlCVh394XszgjxHVkLD7sPCHuFn2KUdB2YinzZHt0RA7oHUlEldkpSH5Ugo=
X-Received: by 2002:a50:cd8c:0:b0:563:fc50:37f9 with SMTP id
 p12-20020a50cd8c000000b00563fc5037f9mr286131edi.3.1708362042972; Mon, 19 Feb
 2024 09:00:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240219141220.908047-1-edumazet@google.com> <65d37cdc26e65_1f47ea29474@willemb.c.googlers.com.notmuch>
In-Reply-To: <65d37cdc26e65_1f47ea29474@willemb.c.googlers.com.notmuch>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 19 Feb 2024 18:00:28 +0100
Message-ID: <CANn89iJ2Cv+u+KhEN66RqL=985khA4oAOrnJmrNEje5N2KNupg@mail.gmail.com>
Subject: Re: [PATCH net] net: implement lockless setsockopt(SO_PEEK_OFF)
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Daan De Meyer <daan.j.demeyer@gmail.com>, Kuniyuki Iwashima <kuniyu@amazon.com>, 
	Martin KaFai Lau <martin.lau@kernel.org>, David Ahern <dsahern@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 19, 2024 at 5:07=E2=80=AFPM Willem de Bruijn
<willemdebruijn.kernel@gmail.com> wrote:
>
> Eric Dumazet wrote:
> > syzbot reported a lockdep violation [1] involving af_unix
> > support of SO_PEEK_OFF.
> >
> > Since SO_PEEK_OFF is inherently not thread safe (it uses a per-socket
> > sk_peek_off field), there is really no point to enforce a pointless
> > thread safety in the kernel.
>
> Would it be sufficient to just move the setsockopt, so that the
> socket lock is not taken, but iolock still is?

Probably, if we focus on the lockdep issue rather than the general
SO_PEEK_OFF mechanism.

We could remove unix_set_peek_off() in net-next,
unless someone explains why keeping a locking on iolock is needed.


>
> Agreed with the general principle that this whole interface is not
> thread safe. So agreed on simplifying. Doubly so for the (lockless)
> UDP path.
>
> sk_peek_offset(), sk_peek_offset_fwd() and sk_peek_offset_bwd() calls
> currently all take place inside a single iolock critical section. If
> not taking iolock, perhaps it would be better if sk_peek_off is at
> least only read once in that critical section, rather than reread
> in sk_peek_offset_fwd() and sk_peek_offset_bwd()?

Note that for sk_peek_offset_bwd() operations, there is no prior read
of sk_peek_off,
since the caller does not use MSG_PEEK (only UDP does a read in an
attempt to avoid the lock...)

static inline int sk_peek_offset(const struct sock *sk, int flags)
{
    if (unlikely(flags & MSG_PEEK))
        return READ_ONCE(sk->sk_peek_off);

    return 0;
}




>
> >
> > After this patch :
> >
> > - setsockopt(SO_PEEK_OFF) no longer acquires the socket lock.
> >
> > - skb_consume_udp() no longer has to acquire the socket lock.
> >
> > - af_unix no longer needs a special version of sk_set_peek_off(),
> >   because it does not lock u->iolock anymore.
> >
> > As a followup, we could replace prot->set_peek_off to be a boolean
> > and avoid an indirect call, since we always use sk_set_peek_off().
>

