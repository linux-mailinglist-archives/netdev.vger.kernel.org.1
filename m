Return-Path: <netdev+bounces-249643-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CFFFDD1BBA1
	for <lists+netdev@lfdr.de>; Wed, 14 Jan 2026 00:30:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3FA64302BA4E
	for <lists+netdev@lfdr.de>; Tue, 13 Jan 2026 23:30:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4225F355041;
	Tue, 13 Jan 2026 23:30:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="TI437L/1"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A649A299AAB
	for <netdev@vger.kernel.org>; Tue, 13 Jan 2026 23:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768347051; cv=none; b=qojGZDFgwlJYnU5NrO2hMCLIp1tv0TgE1+MEYKkXf9hpv0UmCuCtD2NEFjN/epTgpPZF1sVveRsofgImH2bE9U/8r6ym93Clg7Mw8iO64PU88f1KQaCXiBpvyWhgSxPLdlrItnPn4pIobKlKapamxP9n1fEV1yX37AkiGZUoDIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768347051; c=relaxed/simple;
	bh=BHwaBCojEYfdnAlzVl1i0VtWUD6FLGQEtjgnj6+Z+88=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gthjSr3bXZpEUq577KLClXd9TKcRKxlWDSesqSKUO51Zw/NOjXoTnK0wz3Xfoe6h680WJCBE5Ql64Ua0qC37Uq83ZJzM2z0py1qD76S4WLX/AD9nUWh2sLv8qL7mM75FsEU5wlA1h+Al7Okgd+hCC71C3tpjrNq9qyzkYk9XDwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=TI437L/1; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-bc09b3d3afeso3104856a12.0
        for <netdev@vger.kernel.org>; Tue, 13 Jan 2026 15:30:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1768347049; x=1768951849; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mE36OQDmj7iz0rHXcX1wmkxP5g2+GArMDzVzwK6zc4g=;
        b=TI437L/1GwmODfxMlDR8Xcj9Vzli4ppCMBk7ZZ955t2p5KypVxgeiE4zEmZX54rnQ9
         WQqoXcfVYuzs35M5hee9Ypniwm/1Y3FU13ivaDRSvSsHFeKUBr/2prZfXQbYMG96okXr
         D86gu5Yw+IQ88K4noAIf8fwuLc6Tl5LAxZaPw+UpyqJIH3ZbEzfhF//njRgquPgJmRn+
         glN9x+QJcPlqosdLIsxNcMpXatg4Uo1mOfkmx1W5RUWHyqjg/KJ+U+/+ChMCddnC48p1
         oMUn3R56BOzsvI2AdrxMG566YuWz+RdxT7qqA6stm1fNR6Lr/k47N4tZrWgM+PsXmBu9
         wWlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768347049; x=1768951849;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=mE36OQDmj7iz0rHXcX1wmkxP5g2+GArMDzVzwK6zc4g=;
        b=mFdOtEqImsLJhbCFEU4QC/ubftP8O+lTnTTUWopcCDvLV1BUkbY/ap2J8aeHSLaVDp
         i0LdP5i5IvMnH0p2I9+m4y4784u804TD65WVw4iijk5jLmIGTcosW1C3YUxZYen5lLCB
         9apPxwMFM5dAo0wCIQadcfBvAYKyFaibGEsgPG4SNJhfil4BHthqWNKP7UxgUntQgUeb
         4ppZtqU3ZQsUjVu6NBTulktskZPNEngjjQZuhr9nI+R+0n657lQl1S6JI17FntFuVHFU
         v+jxzzqcGfGTEoSGWsZYvxBzNF5aJ0ks/c06QqYYKoRB4tt+IzcPnI4XZ1WbGAr7jjRy
         VF9A==
X-Forwarded-Encrypted: i=1; AJvYcCW9w2K1ZvU6RDJGg7cVw1Ox+gekpOTqzmAAMPNXfZpLlu+ewlKi4fjOjIMRrETvNqGvKqmFqw0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0aeZJm4kKSuOCLnddi2RarHIypwyiVigDurPD5SPirpLSGj8W
	k81vMxOCiNY+Wh9t4+dq1NNAh6nW0fndEXQFxqrmJPpJRSk0DobphQddOMNkYuW6oxFPYZymhyi
	klYFfs/0S8dFWIDZMRjP/22K2MM98CRnc9DKO+stc
X-Gm-Gg: AY/fxX5kZmMzZpkLU188IaRuRjQ5iz2fKhziSWmGUmW60BGG9nt82L+dcVxqcJPlckQ
	a2zlHKEHoPQ8wol9LECCU9HV0wSe0usX8OaljJlM1V9spBfGFkmhkxMd3ck0X41xFjxraFBC+aq
	A/ErWXKhc5BkdhzN5uDcIz806RJQ7m1YTsa/cAB8vbdQdOLw2AaZAsO17zJT2QTtt2BEfIWQv2X
	kFOLCA9Q+ShNMn5qlR0BrmXXwXCgt614CGX0JF/6ZwFkWLIY5EL3jv1yhUuvQ5LTPeYzcU=
X-Received: by 2002:a17:90a:da8e:b0:34c:6e10:fe71 with SMTP id
 98e67ed59e1d1-35109176174mr506253a91.25.1768347048940; Tue, 13 Jan 2026
 15:30:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260110143300.71048-2-gnoack3000@gmail.com> <20260110143300.71048-4-gnoack3000@gmail.com>
 <4bc22faa-2927-4ef9-b5dc-67a7575177e9@gmail.com> <CAHC9VhSRiHwLEWfFkQdPEwgB4AXKbXzw_+3u=9hPpvUTnu02Bg@mail.gmail.com>
In-Reply-To: <CAHC9VhSRiHwLEWfFkQdPEwgB4AXKbXzw_+3u=9hPpvUTnu02Bg@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 13 Jan 2026 18:30:37 -0500
X-Gm-Features: AZwV_QhP0I9ZSDQfELGL8XHkZW703RPw9mqQch67Y-MSoOakV6P9XEQuH19GPW4
Message-ID: <CAHC9VhQZ_J9316Us0squV_f-MjYXPcex34BnJ14vEBxS9Jyjbg@mail.gmail.com>
Subject: Re: [PATCH v2 1/5] lsm: Add hook unix_path_connect
To: Justin Suess <utilityemal77@gmail.com>
Cc: =?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack3000@gmail.com>, 
	=?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>, 
	James Morris <jmorris@namei.org>, "Serge E . Hallyn" <serge@hallyn.com>, 
	linux-security-module@vger.kernel.org, Tingmao Wang <m@maowtm.org>, 
	Samasth Norway Ananda <samasth.norway.ananda@oracle.com>, Matthieu Buffet <matthieu@buffet.re>, 
	Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>, konstantin.meskhidze@huawei.com, 
	Demi Marie Obenour <demiobenour@gmail.com>, Alyssa Ross <hi@alyssa.is>, Jann Horn <jannh@google.com>, 
	Tahera Fahimi <fahimitahera@gmail.com>, Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 13, 2026 at 5:51=E2=80=AFPM Paul Moore <paul@paul-moore.com> wr=
ote:
> On Sat, Jan 10, 2026 at 11:45=E2=80=AFAM Justin Suess <utilityemal77@gmai=
l.com> wrote:
> > On 1/10/26 09:32, G=C3=BCnther Noack wrote:
> > > From: Justin Suess <utilityemal77@gmail.com>
> > >
> > > Adds an LSM hook unix_path_connect.
> > >
> > > This hook is called to check the path of a named unix socket before a
> > > connection is initiated.
> > >
> > > Cc: G=C3=BCnther Noack <gnoack3000@gmail.com>
> > > Signed-off-by: Justin Suess <utilityemal77@gmail.com>
> > > ---
> > >  include/linux/lsm_hook_defs.h |  4 ++++
> > >  include/linux/security.h      | 11 +++++++++++
> > >  net/unix/af_unix.c            |  9 +++++++++
> > >  security/security.c           | 20 ++++++++++++++++++++
> > >  4 files changed, 44 insertions(+)
>
> ...
>
> > > +#if defined(CONFIG_SECURITY_NETWORK) && defined(CONFIG_SECURITY_PATH=
)
> > > +/*
> > > + * security_unix_path_connect() - Check if a named AF_UNIX socket ca=
n connect
> > > + * @path: path of the socket being connected to
> > > + * @type: type of the socket
> > > + * @flags: flags associated with the socket
> > > + *
> > > + * This hook is called to check permissions before connecting to a n=
amed
> > > + * AF_UNIX socket.
> > > + *
> > > + * Return: Returns 0 if permission is granted.
> > > + */
> > > +int security_unix_path_connect(const struct path *path, int type, in=
t flags)
> > > +{
> > > +     return call_int_hook(unix_path_connect, path, type, flags);
> > > +}
> > > +EXPORT_SYMBOL(security_unix_path_connect);
>
> ...
>
> > I'm considering renaming this hook to unix_socket_path_lookup, since as=
 G=C3=BCnther
> > pointed out this hook is not just hit on connect, but also on sendmsg.
>
> I'm not bothered too much ...

I forgot to add that I know you're likely going to do another revision
to this patchset to rename the hook, but I would suggest waiting until
the AppArmor folks have had a chance to look at the hook.  I want to
make sure the new hook is reasonable and suitably generic for a
path-based LSM, and while I suspect it is, having another set of
path-based LSM eyes review the hook would be a very good thing.

--=20
paul-moore.com

