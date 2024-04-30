Return-Path: <netdev+bounces-92648-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 613638B8304
	for <lists+netdev@lfdr.de>; Wed,  1 May 2024 01:31:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 011661F2385F
	for <lists+netdev@lfdr.de>; Tue, 30 Apr 2024 23:31:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8AB01C0DC3;
	Tue, 30 Apr 2024 23:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="a6v5uoMK"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E44B29A2
	for <netdev@vger.kernel.org>; Tue, 30 Apr 2024 23:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714519860; cv=none; b=PmGglf11z9aoMTSx3SyUR05kbW3BEADlNyc6IZ8LBRy+h+XfrpK2HTrgTx+6eEuKOKHxaVqy2FCKP0vTRBoKsh4B3D8X8xXoCOk/FAN2Q33ZIAIegrYlyPNzsJpfPs6uq6KXHVjTyKASfHGbhHHupfYLUPmayXtaITiy8KB7a4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714519860; c=relaxed/simple;
	bh=v6l9Dy+zgYtQANqNrAuYoV7RtibvHv1t+iO26o7M3Lw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LdiErh4zpkvoFqW7Vp7YVf5AyVZeicWAqWgEV0pHUhGVDRSbmxHmHasLC9Y0AbF7LAMhhFD2jEGm2L2q5O9M41URZHvsnsMwWUFyd67MC71Vv6OTlKy+mM6oA0kTgcUkPsLCPKYNxATmoM00mAQ6tygPOI75f53oR3P2S8YgCYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=a6v5uoMK; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-61ac183ee82so2653997b3.1
        for <netdev@vger.kernel.org>; Tue, 30 Apr 2024 16:30:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1714519858; x=1715124658; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w5280T2pBS/YbunN5H2zYRs7nL3ElBlSDV8493aHgyE=;
        b=a6v5uoMKRiOMIwe3EjXwS450hqEDI1KglS3r9NJBLB6AsnNxqdKvV2zmI8E3diO057
         wKEzrluT5vGupnszjOM/7pPWmIiCCROu21WlAiarwjttyFsPaF3rTM71Luu+GSVTvb2U
         Gt56iwax6RnsUnd6TWitdO8XoX8Mcl3ZwgPNCtErkcx/S2WB8hCy2S/J6g8L/NAnSpnh
         srrV9szWQiwkbWu6eDtzzDyXAo2OZkPgew/aQTDDohSKM5lC3dOsWqBSeHCwqoTP0nxW
         Yj4sOLAPhf9ep6W3j5GtVzcFiZ4Ggz9X4eSRULTBjere0vogxCLlaW5LnwOzfF2F448M
         bdxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714519858; x=1715124658;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w5280T2pBS/YbunN5H2zYRs7nL3ElBlSDV8493aHgyE=;
        b=fd9LRr8T58aLfhIKaMyLJfLgBvuQSHImvkIBlIWaaFvxdzY4j/pZ/xlP1sdaHkzeJC
         dAVdOnGhHtepBi4B+0rGolkMDSPhdevKikJLXxRqci3X6DWct/jHIS1PixNAkHEdE7MD
         FUupkuAhWSu/386cFsgqXfw7Itz3C8Lj98s2/m69B/r0mqkzaraVA1Y0BNvcSTSBMtk6
         slovcVZcJTcseSgU7YOkjIn9EPo5MxIOlNqml6xvB7RBFSyXL487gxPPRdfuCYPOWu5i
         Hvj0kmwMDF6/PbzH72aKH6TsSHjiihrwc+tOrGD8pPFEcBEVIkyx8BzLlXuvkzXhM/O2
         VHzg==
X-Forwarded-Encrypted: i=1; AJvYcCUJXbK9wdF12eAJSA+bUi4JoFr2Yjhr+j1P/jLs8IfufpXS/cFkIREWiaaNNqw00iAWxpDw7PF4B/WmDz/6KouHVY1TGY79
X-Gm-Message-State: AOJu0YzcIm4XKc1JKq3304rCgN9GAXgN2JP9TvP3afD5tuUjq/db6xTA
	HAgsKn7CHkqWJ8CAkyS5BAvtqyH+wzCAb2cy41MCiZpJRX+IEKzCPbT5eZ5nkD7ytjKt8CISBr9
	S5eyZt+g3fhwNvJ9kpjkKxkJbygUiLIg/KdC1
X-Google-Smtp-Source: AGHT+IEN86rssCp7fIMBN1SDaN+Tl6zfv0tCK8l8/Lj7AhRrV2fBoqG/dDXTgEFJVOZFzDKsk4TL/PKSCoDm4WZNCVE=
X-Received: by 2002:a05:690c:d88:b0:61a:c156:76c8 with SMTP id
 da8-20020a05690c0d8800b0061ac15676c8mr979479ywb.9.1714519858172; Tue, 30 Apr
 2024 16:30:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <c1ba274b19f6d1399636d018333d14a032d05454.1713967592.git.dcaratti@redhat.com>
 <b6f94a1fd73d464e1da169e929109c3c@paul-moore.com> <Zi9yE099IYtqhCzN@dcaratti.users.ipa.redhat.com>
In-Reply-To: <Zi9yE099IYtqhCzN@dcaratti.users.ipa.redhat.com>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 30 Apr 2024 19:30:47 -0400
Message-ID: <CAHC9VhT4TOBNgo4tX97GoFgTLZEtYpPMxucfWP405y2UsC5urQ@mail.gmail.com>
Subject: Re: [PATCH v2] netlabel: fix RCU annotation for IPv4 options on
 socket creation
To: Davide Caratti <dcaratti@redhat.com>
Cc: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, "David S. Miller" <davem@davemloft.net>, 
	Casey Schaufler <casey@schaufler-ca.com>, linux-security-module@vger.kernel.org, 
	netdev@vger.kernel.org, Xiumei Mu <xmu@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 29, 2024 at 6:10=E2=80=AFAM Davide Caratti <dcaratti@redhat.com=
> wrote:
> On Thu, Apr 25, 2024 at 05:01:36PM -0400, Paul Moore wrote:
> > On Apr 24, 2024 Davide Caratti <dcaratti@redhat.com> wrote:

...

> > > @@ -1876,18 +1878,15 @@ int cipso_v4_sock_setattr(struct sock *sk,
> > >
> > >     sk_inet =3D inet_sk(sk);
> > >
> > > -   old =3D rcu_dereference_protected(sk_inet->inet_opt,
> > > -                                   lockdep_sock_is_held(sk));
> > > +   old =3D rcu_replace_pointer(sk_inet->inet_opt, opt, slock_held);
> > >     if (inet_test_bit(IS_ICSK, sk)) {
> > >             sk_conn =3D inet_csk(sk);
> > >             if (old)
> > >                     sk_conn->icsk_ext_hdr_len -=3D old->opt.optlen;
> > > -           sk_conn->icsk_ext_hdr_len +=3D opt->opt.optlen;
> > > +           sk_conn->icsk_ext_hdr_len +=3D opt_len;
> > >             sk_conn->icsk_sync_mss(sk, sk_conn->icsk_pmtu_cookie);
> > >     }
> > > -   rcu_assign_pointer(sk_inet->inet_opt, opt);
> > > -   if (old)
> > > -           kfree_rcu(old, rcu);
> > > +   kfree_rcu(old, rcu);
> >
> > Thanks for sticking with this and posting a v2.
> >
> > These changes look okay to me, but considering the 'Fixes:' tag and the
> > RCU splat it is reasonable to expect that this is going to be backporte=
d
> > to the various stable trees.  With that in mind, I think we should try
> > to keep the immediate fix as simple as possible, saving the other
> > changes for a separate patch.  This means sticking with
> > rcu_dereference_protected() and omitting the opt_len optimization; both
> > can be done in a second patch without the 'Fixes:' marking.
> >
> > Unless I missing something and those changes are somehow part of the
> > fix?
>
> just checked, rcu_replace_pointer() can be used also in the oldest LTS
> but I'm not sure if kfree_rcu(NULL, ...) is ok. I agree to keep
> rcu_dereference_protected(), and the useless NULL check - I will
> follow-up with another patch (targeting net-next), after this one is
> merged.

The issue isn't so much about if a particular function is available in
an older kernel, it is more about keeping the patch focused on a
single immediate purpose both to limit any unintended behaviors and
for the simple reason that smaller patches are almost always easier to
port by hand if needed.

--=20
paul-moore.com

