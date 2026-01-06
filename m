Return-Path: <netdev+bounces-247478-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AC126CFB196
	for <lists+netdev@lfdr.de>; Tue, 06 Jan 2026 22:37:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1B74330402E1
	for <lists+netdev@lfdr.de>; Tue,  6 Jan 2026 21:33:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 703763019C5;
	Tue,  6 Jan 2026 21:33:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OgwSTlDc"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE3FE2FFF8C
	for <netdev@vger.kernel.org>; Tue,  6 Jan 2026 21:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767735199; cv=none; b=Nx+fzgQ1yy86G/bfiLaxwfDOnR3pdaQZrngZsjYlJpz7Palr1BMQyWonG2OKYET1DcnTpdeV4e5H0BaXepybbeRLDPfJfW+LAWJdDHtcRgsZObvdOBl6401oqY/5FQi9jdkRe2yTIyrqiKKeEWE6Hh9GwAVO5nuOlw1JOxG8M1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767735199; c=relaxed/simple;
	bh=7LLO7u3QjBG9Js7UME2/gC0/IEcEAOaQyBbMSBiKJjc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BT7ya+JipIgqWzCDEbGjrlVNm9SHe1jU3CLv16TmVz3pGG9YAbtgVBh/cxgG1clC80oGJpfSK9aR8xa1QY0cRKhfdjcMFdqwwkrFRot0oQhOuiNXqM9aUc2TIDEXwJaCdjJdQuf/gHsaqnXB5lCytN3bD1roJoUhHXK0fNA18Ts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OgwSTlDc; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-4ed82ee9e57so17120361cf.0
        for <netdev@vger.kernel.org>; Tue, 06 Jan 2026 13:33:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1767735197; x=1768339997; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CKIpeFM/k2sxjcrVvzAGm+2cor55rMuO3jvU5ytT7JA=;
        b=OgwSTlDcUc4xJ88hgJXtq++89hBV9RvhACACg4KPgLkYnMq7YShPn5/WoXKuBzve2H
         t+X9EnNqssZRhF/XryTtyCnNMXXc+afjPDuV67QSPmjAQ8XcYK3hJW8f9h2HeMmBO46/
         yZPyoQqPps5w+/vpAtSrZsJJozyUFE4erjSfb4yrSjybxs3s0yZC6lIDTiW7AwQVWoN4
         QcKcm1uIkgaaoPeQuy4UbaLzlNZ5MeYCxsoa6BojKJePu3DVRboHXrgvWWuVoycuwkla
         Q411vK2agxEfBWlle1vNyT63ATehMRYPye2QNtGnV85u9TEllY8SbgbT0shV9ApF5EVr
         KPcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767735197; x=1768339997;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=CKIpeFM/k2sxjcrVvzAGm+2cor55rMuO3jvU5ytT7JA=;
        b=dyVAxeQdJOIUts/sO3KpFjEgNSVQ7pm/+o8n1WnHdz97sFey/zRQdse4+oubNZrnu3
         jlnoMJLCdgCY2RT8V7AafEQVhZoBQLaFmgESLmbfB6kUDDugvCkF9jEIv5U1k5AoYb+w
         Yt+4UQ9LSm2bfvGIO8WkKV+f6N/6chS4N4jKw5zwpaCSAEEAM5NMfudkH0vG7Klw4isT
         dweleL/jcSLTepKk07Ml0sg+63uyULLt7oEJy5Ft6bWdppx7x/LdrkrLFHJo3n1cq9tl
         i2Qb3Akrbhj/SMpJSNiSEnAtgHkPnLLeo20xtoMrj4gz/GFCddu0qvYBDsTfrojJJmPu
         GWmQ==
X-Forwarded-Encrypted: i=1; AJvYcCUQYOQDq7d6WvmLCmMF/7xMo38X0JLbVbKIP7yDb0Bx4w+mDSQU/t+RbbEv0qzEZ9v6aoJ+ouI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxtfDSKPoxrX72XyU6L4sGebgZI3Fd3BueQAUTDTtURxGhT5F05
	kQ6Qq2TF74Uy8AHeqHimyQLjqRRd0L2a2fwpfAHaUyW2wOGDs4OZvhVut1qPhG83/nsQg3PFrGu
	a1yudvLeJucozprh1g4aA+90wJoooI/P/SFvB5N9C
X-Gm-Gg: AY/fxX5bLU1x/xQ87JVFuIqSnQ/1VoY/Mu/PAj1BoOyST5JNPzd70KO1vVIEkV1ttlC
	vnAlTsx9XZSqea25y2r9SU4AMAmd+6+WuSsSN4QMYX2idOH/PlNhJc9SLKaYb+PF897C8G62K86
	UFaKFBdPaQt6UCa/FPXyC6qWzE0xred5hZL1L9KUz749dOJV2SRxCNn8w7tRj9qBqrba/9z1NA/
	E1CxBTu6ggNf2KALMA/Joo9nRE/rvZVXdaeSfKJcbgAvPKf2LwP6lGylQoDMVXVoA09CS8=
X-Google-Smtp-Source: AGHT+IHOc7B5Sd4TiX6lGKWl1pO1JiY0feHNZ4dJfN2UaqxRVHlBy/ogmX5pfTne+WRxZExvZMcq1zX1PLDHq3FAtPs=
X-Received: by 2002:a05:622a:155:b0:4f1:bd73:ac6f with SMTP id
 d75a77b69052e-4ffb4a1d354mr5443281cf.74.1767735196415; Tue, 06 Jan 2026
 13:33:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260106144529.1424886-1-edumazet@google.com> <20260106095648.07a870f1@kernel.org>
 <CANn89iJnXg892OU13PeJMGvBKw90fJdqDaAmJ867Rptsm0zgNA@mail.gmail.com>
 <20260106123151.03a984bb@kernel.org> <CANn89iL_Sa_ez340w2eyM_rfCnOH-UV9-zo1sYv65_hdQ-_W6g@mail.gmail.com>
In-Reply-To: <CANn89iL_Sa_ez340w2eyM_rfCnOH-UV9-zo1sYv65_hdQ-_W6g@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 6 Jan 2026 22:33:05 +0100
X-Gm-Features: AQt7F2rCltBFuuzSlrBFxlJJwtt1oYxUI838c0oENf0aJKORLyuZWmah8kZ1gwU
Message-ID: <CANn89iKVaigLaffUqXE+UX+Tr88apSa1Ciavi1rLr+G3sMzkLw@mail.gmail.com>
Subject: Re: [PATCH v2 net] ip6_gre: use skb_vlan_inet_prepare() instead of pskb_inet_may_pull()
To: Jakub Kicinski <kuba@kernel.org>
Cc: "David S . Miller" <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Florian Westphal <fw@strlen.de>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, syzbot+6023ea32e206eef7920a@syzkaller.appspotmail.com, 
	Mazin Al Haddad <mazin@getstate.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 6, 2026 at 10:25=E2=80=AFPM Eric Dumazet <edumazet@google.com> =
wrote:
>
> On Tue, Jan 6, 2026 at 9:31=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> w=
rote:
> >
> > On Tue, 6 Jan 2026 20:33:40 +0100 Eric Dumazet wrote:
> > > For some reason I am unable to run this test from a virtme-ng instanc=
e.
> > >
> > > I guess I wlll not make a new version of this patch, maybe Florian ca=
n
> > > take over.
> >
> > Hm, no complications seen here:
> >
> > $ vng -r --user root
> > ..
> > prompt# cd tools/testing/selftests/net/
> > prompt# ./gre_gso.sh
> >
> >     TEST: GREv6/v4 - copy file w/ TSO                                  =
 [ OK ]
> >     TEST: GREv6/v4 - copy file w/ GSO                                  =
 [ OK ]
> > 2026/01/06 15:30:35 socat[1704] W exiting on signal 15
> >     TEST: GREv6/v6 - copy file w/ TSO                                  =
 [ OK ]
> >     TEST: GREv6/v6 - copy file w/ GSO                                  =
 [ OK ]
> > 2026/01/06 15:30:35 socat[1721] W exiting on signal 15
> >
> > Tests passed:   4
> > Tests failed:   0
> >
> >
> > Happy to give you access to the netdev machine to experiment there
> > if that helps, just send me an SSH key.
>
> My vng launch script had the -v option ( --verbose, -v   Increase
> console output verbosity), and this was causing issues.
>
>
> Anyway, using my v2 patch on top of current net-tree
> (238e03d0466239410) seems fine to me, no error at all,
> not sure why your bot is unhappy.
>
> Could multiple patches have been tested together, one having a side effec=
t ?
>
> [hi on] edumazet@edumazet1:~/git/net-next$ vng  -r --user root --cpus
> 4 --memory 4G
> /usr/lib/tmpfiles.d/legacy.conf:14: Duplicate line for path
> "/run/lock", ignoring.
>           _      _
>    __   _(_)_ __| |_ _ __ ___   ___       _ __   __ _
>    \ \ / / |  __| __|  _   _ \ / _ \_____|  _ \ / _  |
>     \ V /| | |  | |_| | | | | |  __/_____| | | | (_| |
>      \_/ |_|_|   \__|_| |_| |_|\___|     |_| |_|\__  |
>                                                 |___/
>    kernel version: 6.16.12-1rodete2-amd64 x86_64
>    (CTRL+d to exit)
>
> Illegal instruction        shell-history-configtool configure-interactive=
ly
> root@virtme-ng:/usr/local/google/home/edumazet/git/net-next# cd
> tools/testing/selftests/net/
> root@virtme-ng:/usr/local/google/home/edumazet/git/net-next/tools/testing=
/selftests/net#
> ./gre_gso.sh
>     TEST: GREv6/v4 - copy file w/ TSO                                   [=
 OK ]
>     TEST: GREv6/v4 - copy file w/ GSO                                   [=
 OK ]
> 2026/01/06 21:25:27 socat[1214] W exiting on signal 15
>     TEST: GREv6/v6 - copy file w/ TSO                                   [=
 OK ]
>     TEST: GREv6/v6 - copy file w/ GSO                                   [=
 OK ]
> 2026/01/06 21:25:27 socat[1229] W exiting on signal 15
>
> Tests passed:   4
> Tests failed:   0
> root@virtme-ng:/usr/local/google/home/edumazet/git/net-next/tools/testing=
/selftests/net#

Ah of course my script had '-r arch/x86/boot/bzImage'

I will test more tomorrow.

