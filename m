Return-Path: <netdev+bounces-103767-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 196C790965C
	for <lists+netdev@lfdr.de>; Sat, 15 Jun 2024 08:41:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6A6C7B22450
	for <lists+netdev@lfdr.de>; Sat, 15 Jun 2024 06:40:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD7AE17552;
	Sat, 15 Jun 2024 06:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FxjXVN62"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D648A13FEE
	for <netdev@vger.kernel.org>; Sat, 15 Jun 2024 06:40:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718433648; cv=none; b=f45ugeZdkfpbzxclgrmynKaLErxgC2aSr7XjD4mNxqXFp3yKU4xArrsYgVxcX/GgB4+GO6LAhhQwp7CkTn0/Wh/qccAHog1MfPYIQLc/DF/eKB6G0ww9HUu86v87NzbSMElyukrf1sizEWQy7gYfEUxI2IV6iEhMTPIDILm3OOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718433648; c=relaxed/simple;
	bh=sib4YKtv2vrN7WbeiB89o6mszigju6nK0A421ikJigg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=e6KUQQCu4pIMGCtvLP0+h9xsnR3a7fvc9wFrO0iT7t7lAuZceXG+K3LDKlKU3Gw1Fr4Y70j/wdw6cgBKsdGE/Te5LG0HuHZmBQTaHRTJ2oWSIHhtc0G6VhXYIC8RobPoCBz+qKjhEEtUntyDd9iTHuKFLMPpinF9e+hHy1ldIlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FxjXVN62; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4216d9952d2so35395e9.0
        for <netdev@vger.kernel.org>; Fri, 14 Jun 2024 23:40:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1718433644; x=1719038444; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dhCTYBtOyXxcQJdvWxQ/6fDzuoGa5DKKIIfaVtLh4Yc=;
        b=FxjXVN624p182QcNs3l9fvloYbJZSJ7ZxPLbb8opgTl8+KQL9bxisxQ8xcdZrfcslu
         qXHDMKjuAy6Jk1lOEpJBB+psMFJpJZ208hhE2Tmr6kodqBFS80R4aWt0Z+odsJ+lLj9Z
         RT71Pn+ye6WbrX2yfi/VWDJWSpV4ZMejE0lzcUhFsYjRRRfeQ+W1h8+qA/oD/SHsH8Ct
         M5EQtPeMeOxBv5Xser8SAvoJJ6zTl6afdQrib2ySkJtC39KqhClg2bzzlS7i2hHHHoyJ
         HrDW9HeJR97sdfDTMlfnWGwqR7E0cwPYgpDx8amDpLWfz7dTNjTnstwl2vCRInTvBWTi
         XDvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718433644; x=1719038444;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dhCTYBtOyXxcQJdvWxQ/6fDzuoGa5DKKIIfaVtLh4Yc=;
        b=QXxr3KB/jV8EYEoCH4fmr4Y2IHtmS8YE6f3Ypp3DPHWosuV1SgKw2t0KAbFp0PIwsM
         5nyXI0dIjxuEwvRffDwVQ9oCfGpXeta/sKm/BL4+uKZ8n/LeQwac/B8Bn/LRMFOxnM/H
         GIw8p2FKEx/bEDRdbK0jUe+WPlGLnhYxrLHoDi1G+AuizaszkveFbZslhrDQgyby7om/
         JyDX5V7MxFFbgEwDXFv/tmhw7cwws1tcYM2hSPO4LEFqTwXMzeIVbgYtK+Jisq5S1Dj9
         XXsnx6hmOIQWaXXgH+MG8zj38cAO9xs2e+p4hBpzKTTOF+VooSJKPFrhwhI7kWTXTt84
         BOCA==
X-Forwarded-Encrypted: i=1; AJvYcCVfsxrsYeGGz8cRuEf8pEfzxHqb+uRxvDYLHmdSPf+9yIkDi0HPpwijUOSE8MpRJfk9KLJGvHRjDRmErBUGAwyuM4Yx7IJn
X-Gm-Message-State: AOJu0YynU4NcJsn5wth5C5/tUDuVfDuenQClAc3cRLGa4c0X3Fm1BZYN
	etvtPbtZ22Wl65qGhChC+aZODQmNb4gYBDk4Fnb08WY+BIKQ5Hf6x4jbp9c4nsSlDGCsy9XvD6c
	YL6aicDEV3fdGiM9iHO0TIZdq7r/u0iw4Dfjs
X-Google-Smtp-Source: AGHT+IG2fMCqI6iKs1hVBi52SKUXZCXi2GieXXtLK+FqM+P97xGx7W4NYhFjItO1co2wFv6S1Dx6t2BcJZ/L1MdAlis=
X-Received: by 2002:a05:600c:1f15:b0:423:798:38e3 with SMTP id
 5b1f17b1804b1-423b6691387mr602385e9.5.1718433643863; Fri, 14 Jun 2024
 23:40:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <7075bb26-ede9-0dc7-fe93-e18703e5ddaa@kylinos.cn> <20240614222433.19580-1-kuniyu@amazon.com>
In-Reply-To: <20240614222433.19580-1-kuniyu@amazon.com>
From: Eric Dumazet <edumazet@google.com>
Date: Sat, 15 Jun 2024 08:40:32 +0200
Message-ID: <CANn89i+RP1K+mOd5V7LOKMFtMhy0rZrpFDCDQ-RbQ31GkYbc9g@mail.gmail.com>
Subject: Re: [PATCH net v2] Fix race for duplicate reqsk on identical SYN
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: luoxuanqiang@kylinos.cn, davem@davemloft.net, dccp@vger.kernel.org, 
	dsahern@kernel.org, fw@strlen.de, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jun 15, 2024 at 12:24=E2=80=AFAM Kuniyuki Iwashima <kuniyu@amazon.c=
om> wrote:
>
> From: luoxuanqiang <luoxuanqiang@kylinos.cn>
> Date: Fri, 14 Jun 2024 20:42:07 +0800
> > =E5=9C=A8 2024/6/14 18:54, Florian Westphal =E5=86=99=E9=81=93:
> > > luoxuanqiang <luoxuanqiang@kylinos.cn> wrote:
> > >>   include/net/inet_connection_sock.h |  2 +-
> > >>   net/dccp/ipv4.c                    |  2 +-
> > >>   net/dccp/ipv6.c                    |  2 +-
> > >>   net/ipv4/inet_connection_sock.c    | 15 +++++++++++----
> > >>   net/ipv4/tcp_input.c               | 11 ++++++++++-
> > >>   5 files changed, 24 insertions(+), 8 deletions(-)
> > >>
> > >> diff --git a/include/net/inet_connection_sock.h b/include/net/inet_c=
onnection_sock.h
> > >> index 7d6b1254c92d..8773d161d184 100644
> > >> --- a/include/net/inet_connection_sock.h
> > >> +++ b/include/net/inet_connection_sock.h
> > >> @@ -264,7 +264,7 @@ struct sock *inet_csk_reqsk_queue_add(struct soc=
k *sk,
> > >>                                  struct request_sock *req,
> > >>                                  struct sock *child);
> > >>   void inet_csk_reqsk_queue_hash_add(struct sock *sk, struct request=
_sock *req,
> > >> -                             unsigned long timeout);
> > >> +                             unsigned long timeout, bool *found_dup=
_sk);
> > > Nit:
> > >
> > > I think it would be preferrable to change retval to bool rather than
> > > bool *found_dup_sk extra arg, so one can do
>
> +1
>
>
> > >
> > > bool inet_csk_reqsk_queue_hash_add(struct sock *sk, struct request_so=
ck *req,
> > >                                unsigned long timeout)
> > > {
> > >     if (!reqsk_queue_hash_req(req, timeout))
> > >             return false;
> > >
> > > i.e. let retval indicate wheter reqsk was inserted or not.
> > >
> > > Patch looks good to me otherwise.
> >
> > Thank you for your confirmation!
> >
> > Regarding your suggestion, I had considered it before,
> > but besides tcp_conn_request() calling inet_csk_reqsk_queue_hash_add(),
> > dccp_v4(v6)_conn_request() also calls it. However, there is no
> > consideration for a failed insertion within that function, so it's
> > reasonable to let the caller decide whether to check for duplicate
> > reqsk.
>
> I guess you followed 01770a1661657 where found_dup_sk was introduced,
> but note that the commit is specific to TCP SYN Cookie and TCP Fast Open
> and DCCP is not related.
>
> Then, own_req is common to TCP and DCCP, so found_dup_sk was added as an
> additional argument.
>
> However, another similar commit 5e0724d027f05 actually added own_req chec=
k
> in DCCP path.
>
> I personally would'nt care if DCCP was not changed to handle such a
> failure because DCCP will be removed next year, but I still prefer
> Florian's suggestion.
>

Other things to consider :

- I presume this patch targets net tree, and luoxuanqiang needs the
fix to reach stable trees.

- This means a Fixes: tag is needed

- This also means that we should favor a patch with no or trivial
conflicts for stable backports.

Should the patch target the net-next tree, then the requirements can
be different.

