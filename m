Return-Path: <netdev+bounces-53439-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 50149802FC7
	for <lists+netdev@lfdr.de>; Mon,  4 Dec 2023 11:12:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CDB93B20A0E
	for <lists+netdev@lfdr.de>; Mon,  4 Dec 2023 10:12:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E25C1EB5E;
	Mon,  4 Dec 2023 10:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="D/NhjtgV"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 113B5DF
	for <netdev@vger.kernel.org>; Mon,  4 Dec 2023 02:12:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1701684729;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cdTeCVbBKNIz3exfVUizApI93s0ffcM8icuOOUOmJ3U=;
	b=D/NhjtgVEDMBli+bT3IoWR21gJwq2xTEyutyvICLyI/6RPPH3XQvhZdGxcwjXhanWrFFNY
	ta1vqJqZhlkRW4hQMeoVu6xml57NdjnVUD5YkGl9kBx9Ay+FlxKW/fbwOxzs0FBsnww/+A
	XHtL6LzDLOBEk8qxX4oUns4rlj5nqGs=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-154-rTjYXkOpOLGth2MosXyJcw-1; Mon, 04 Dec 2023 05:12:08 -0500
X-MC-Unique: rTjYXkOpOLGth2MosXyJcw-1
Received: by mail-ed1-f70.google.com with SMTP id 4fb4d7f45d1cf-54c77e011baso1245098a12.2
        for <netdev@vger.kernel.org>; Mon, 04 Dec 2023 02:12:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701684726; x=1702289526;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cdTeCVbBKNIz3exfVUizApI93s0ffcM8icuOOUOmJ3U=;
        b=H5X9ukSm6WaQ9OR8s16ijtZx4hl7ZLk2K8r/ez3NgcvdoO92p4hoPP7Z/vwJ/gMEQ2
         OW56axSceyrqnTd7xg7wRmKm07XfzX87s5J1c0RM81HzFbz4LeryjQe/sSt1sG/x/BDX
         ZwmF0dDjUia32LEmXSxjWRg/lWNwsCo8Wf3Zb0CO2nUG1pUp2AvTObCqu+I9Pf5wVYj0
         dZAZTE8KqbhmY2qGBAcvrDmakGqtJ3ex4PKltStTwE7MFOj4f1+mR6U/kxQ8IMVnHyUa
         L8P+XkD3YEWbWO+aYrde9F27GZOfhQU31JCZxMr/LvMmEiCvcNTi7rNzx3oShpWjJ6TY
         /q1Q==
X-Gm-Message-State: AOJu0Yy5lzZbPXSwnyIWVBhJz0NV6cA+kYpoZqgiOUVayEyKxIoOxHBQ
	s6FEkddehkaHK0R3x88+MgpnR3ujTVEpr7RvU1FA9N9ySLJ3X3jhqdBaEStOwUMGPnTU73NK4V8
	MiTi51ykBNL4YntfkVVC2aQIbseE/O1pgj615TO26SiE=
X-Received: by 2002:aa7:d952:0:b0:54c:7833:c111 with SMTP id l18-20020aa7d952000000b0054c7833c111mr1771259eds.36.1701684726558;
        Mon, 04 Dec 2023 02:12:06 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE6KO+0DEtzpvHP7tJMyeJVf99YpOjaGGQXV6bz2Km4+w5+B60WueRbh3qCS4/3XJ2MkbutBg9ybAgTn+GT5kw=
X-Received: by 2002:aa7:d952:0:b0:54c:7833:c111 with SMTP id
 l18-20020aa7d952000000b0054c7833c111mr1771251eds.36.1701684726322; Mon, 04
 Dec 2023 02:12:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZWnXlcsVJfPO1Qsb@debian> <20231201220743.32491-1-kuniyu@amazon.com>
In-Reply-To: <20231201220743.32491-1-kuniyu@amazon.com>
From: Alexey Tikhonov <atikhono@redhat.com>
Date: Mon, 4 Dec 2023 11:11:55 +0100
Message-ID: <CABPeg3ZZCDkRaVy2towZ-amU9v-rQSXZ_M_KnfY1SfWhhT-AZw@mail.gmail.com>
Subject: Re: UNIX(7)
To: Kuniyuki Iwashima <kuniyu@amazon.com>, alx@kernel.org, linux-man@vger.kernel.org
Cc: libc-alpha@sourceware.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 1, 2023 at 11:08=E2=80=AFPM Kuniyuki Iwashima <kuniyu@amazon.co=
m> wrote:
>
> From: Alejandro Colomar <alx@kernel.org>
> Date: Fri, 1 Dec 2023 13:54:39 +0100
> > Hello Alexey,
> >
> > On Fri, Dec 01, 2023 at 01:16:27PM +0100, Alexey Tikhonov wrote:
> > > Hello.
> > >
> > > There is a discrepancy between the man page description of
> > > 'SO_PEERCRED' and real behavior.
> > >
> > > `man 7 unix` states:
> > > ```
> > >        SO_PEERCRED
> > >               This read-only socket option returns the credentials of
> > >               the peer process connected to this socket.  The returne=
d
> > >               credentials are those that were in effect at the time o=
f
> > >               the call to connect(2) or socketpair(2).
> > > ```
> > >
> > > This doesn't match real behavior in following situation (just an exam=
ple):
> > >  - process starts with uid=3D0, gid=3D0
> > >  - process creates UNIX socket, binds it, listens on it
> > >  - process changes to uid=3Duid1, git=3Dgid1 (using `setresuid()`, `s=
etresgid()`)
> > >  - another process connects to the listening socket and requests
> > > peer's credentials using `getsockopt(... SOL_SOCKET, SO_PEERCRED ...)=
`
> > >
> > > According to the man page: SO_PEERCRED should report (uid1, gid1),
> > > because peer process was running under (uid1, gid1) "at the time of
> > > the call to connect(2)"
> > > In reality SO_PEERCRED reports (0, 0)
> > > Reproducing code is available in
> > > https://bugzilla.redhat.com/show_bug.cgi?id=3D2247682
> > >
> > > I'm not entirely sure if this is a real bug or rather a  poor
> > > description in the man page, but I tend to think that it's the latter=
.
>
> When calling getsockopt(), we cannot know dynamically who the peer's
> owner is.  So, we just initialise the cred when we know the owner,
> and it's the caller of listen(), connect(), and socketpair().
>
> In your case, the listener's cred is initialised with the caller's
> cred during the first liten().
>
>   listener's peer_cred =3D get_cred(rcu_dereference_protected(current->cr=
ed, 1))

Thank you for the explanation.
So this is an omission in the man page.

>
> And connect() will initialise two creds as follows:
>
>   connect()er's peer_cred =3D listener's peer_cred
>   new socket's peer_cred =3D get_cred(rcu_dereference_protected(current->=
cred, 1))
>
> If you call listen() again after setresuid() and before connect(),
> you can update the listener's cred and get the new IDs at the final
> getsockopt().
>


