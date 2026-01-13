Return-Path: <netdev+bounces-249618-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 983F1D1BA23
	for <lists+netdev@lfdr.de>; Tue, 13 Jan 2026 23:52:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B2DB2301A4A6
	for <lists+netdev@lfdr.de>; Tue, 13 Jan 2026 22:52:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC1B32E7F3A;
	Tue, 13 Jan 2026 22:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="ZjxH4c28"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F345277818
	for <netdev@vger.kernel.org>; Tue, 13 Jan 2026 22:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768344728; cv=none; b=lmT/s5kS8ZQfMdXT1nNKjuGwxAO4FcZm5LovXqAfZhCO+iZx/rxWnpufB4J2y55pKg1WYP9ryc3I8voQRk4+UZZkD1KQyt+OsuY+bqfsVcjNt6GYOV3mAT5i7fnTQG1c/gW49sT+v99AHzpiivIBFRmOGBrEy9/ZX19lxY9yvt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768344728; c=relaxed/simple;
	bh=0oJxC/qT0DQHn+n3hPR9BO6hGs7sI3XptidTSGbO+Og=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lRBLjkQQEaTxtZ+gsn8k2hJIohqPE8BLA/BQfK09kSNJAiD0QeYb8RS30Ohu0i50YcVgEjamlTDFBY+D8hql8YlAP7ygu+xihETOCyMlaAM3PJ9vi2bSs4imVWGWaNElv+vdmyTtGJvP6jnnTG0JTTNm2OnVj6exsSluJi1m1xM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=ZjxH4c28; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-34c3cb504efso6216578a91.2
        for <netdev@vger.kernel.org>; Tue, 13 Jan 2026 14:52:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1768344726; x=1768949526; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zTgs4iA1UcoUUq4Qf1mdqvfKTPWVAq+aYheUpXWDRX8=;
        b=ZjxH4c28CX/mTnBaKxMZyI45tETV7tIRK5El5PsVJ+SvA6StkTCpao7Sw02+0dcv1k
         tLpqvbdMK27TDerCT9E+cbo/Ym4+f7kdAAJEtdGn1NaSl1DEW//8XMFKZbQm54KGKC0R
         iJWvVhm5Md14gkZXY0qdPxrw1EKAuo1pX2/d7dcFUmOGJLCSWcYH2CicEXKoGIviQGfo
         Ey+NAVkg/AXVmXaXkhvZPMwj5Ze6Ihv3Hkm17B8WbGUbrGJ4b2ZK+6qqRqd0bnG8uGDQ
         rNiz55P4UOPU6JZhSj8LDE8XaBboYiY+dlUieaCZAogSw30kjsnTTR0eUa/UAth8084O
         VBsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768344726; x=1768949526;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zTgs4iA1UcoUUq4Qf1mdqvfKTPWVAq+aYheUpXWDRX8=;
        b=Z2JFCq87ggeu+yywD7sXura2N78fhm5lHeFzG9YZi6IQxcIK8wKiCMardpo7KDLwUl
         mtmLNrZZ9qGoqBm/TPlEa7fPy1sHFy1C2dYgZBQ18VdtBCfAPg//OyLU9IAEgh24iIg+
         VfXYQ2tOILUwjhB07AJfmA2t47CLoWSUILLbIfXYus+nWyY32qWCWFHg1VPrgcPjoGlf
         ICmEw3B8PqLH7UlGDe9T3XGTaJvf8HTy/AaxeiFt6pjC6Q5UQs2v42KIOE6wVAlWI/tx
         twfcZ1u4tHmENzm9ftpIGqlQ5TZv8CnId9DTHqCMaj0wTZe2kq+HoWueOHZjA35e7oRA
         4yqA==
X-Forwarded-Encrypted: i=1; AJvYcCVBT/LRQwyTVRjJbMcQB3SkRr1PQySXHRVr/Z7pnlJcKqjlBPIIJQPAzjqw2z5kIYMW57oaC3c=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz//UhPD/EVHmNffoIWGKeWVcKL+yYmNMY2uevSHER73KdvfafM
	6RCXJuPYsQY1aCsldymRfNKr1o41GP2APvMM2a70SvdRDsXBwtdgW4oRz8ZUhds66HCIRSgq57v
	o/QjoDZutngV/dQYgpGPJLyOoi8aOf4q/dUUV/UmW
X-Gm-Gg: AY/fxX5CxztyUxjTifgAyniwlim6X7qnt5bYk83NQvxbx5GTQaRmRxawNaNX5Q1m817
	i3C9ZP6XS+5DvJlhqCamRmeFFEOOIL089AcA3ReJQWXNW6/ydg4hfyUYwU85a95ztjcsxHsgZRY
	oslq9XgdqAMQWKdRLxtF5ZcusIafGFkzjNg6Hz3nr5froLgC47d+EfWUeYdhdAriIRLOfHLU04C
	ErGQvBHE3Z4e66M+DMVUQEgTInKtB0QBTNfK1/6IgvvXYkMDbSdj+DDc0/aQ4EgyAyWbKQ=
X-Received: by 2002:a17:90b:5590:b0:341:194:5e7a with SMTP id
 98e67ed59e1d1-3510913d098mr600260a91.29.1768344725818; Tue, 13 Jan 2026
 14:52:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260110143300.71048-2-gnoack3000@gmail.com> <20260110143300.71048-4-gnoack3000@gmail.com>
 <4bc22faa-2927-4ef9-b5dc-67a7575177e9@gmail.com>
In-Reply-To: <4bc22faa-2927-4ef9-b5dc-67a7575177e9@gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 13 Jan 2026 17:51:54 -0500
X-Gm-Features: AZwV_QiZ1R95QOsU8k112gBC64BRrl7V4eE_Icbpk4n3D4DsVaZz0a3e543gHx0
Message-ID: <CAHC9VhSRiHwLEWfFkQdPEwgB4AXKbXzw_+3u=9hPpvUTnu02Bg@mail.gmail.com>
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

On Sat, Jan 10, 2026 at 11:45=E2=80=AFAM Justin Suess <utilityemal77@gmail.=
com> wrote:
> On 1/10/26 09:32, G=C3=BCnther Noack wrote:
> > From: Justin Suess <utilityemal77@gmail.com>
> >
> > Adds an LSM hook unix_path_connect.
> >
> > This hook is called to check the path of a named unix socket before a
> > connection is initiated.
> >
> > Cc: G=C3=BCnther Noack <gnoack3000@gmail.com>
> > Signed-off-by: Justin Suess <utilityemal77@gmail.com>
> > ---
> >  include/linux/lsm_hook_defs.h |  4 ++++
> >  include/linux/security.h      | 11 +++++++++++
> >  net/unix/af_unix.c            |  9 +++++++++
> >  security/security.c           | 20 ++++++++++++++++++++
> >  4 files changed, 44 insertions(+)

...

> > +#if defined(CONFIG_SECURITY_NETWORK) && defined(CONFIG_SECURITY_PATH)
> > +/*
> > + * security_unix_path_connect() - Check if a named AF_UNIX socket can =
connect
> > + * @path: path of the socket being connected to
> > + * @type: type of the socket
> > + * @flags: flags associated with the socket
> > + *
> > + * This hook is called to check permissions before connecting to a nam=
ed
> > + * AF_UNIX socket.
> > + *
> > + * Return: Returns 0 if permission is granted.
> > + */
> > +int security_unix_path_connect(const struct path *path, int type, int =
flags)
> > +{
> > +     return call_int_hook(unix_path_connect, path, type, flags);
> > +}
> > +EXPORT_SYMBOL(security_unix_path_connect);

...

> I'm considering renaming this hook to unix_socket_path_lookup, since as G=
=C3=BCnther
> pointed out this hook is not just hit on connect, but also on sendmsg.

I'm not bothered too much by this, either _path_connect() or
_path_lookup() is okay; please don't use
security_unix_socket_path_lookup(), that's longer than it needs to be,
if you've got "_unix_" in there we know you're talking about a socket
:)

While I don't want us to do it often, we can always change established
hook names if the names end up being really awful or misleading.
We've done it in the past.

It would be nice if somehow the hook name reflected the fact that it
is called on the "client" side of the connection, and not the "server"
side, but I wouldn't use either of those terms (client or server), and
to be honest I can't think of anything better than _path_lookup() at
the moment.

--=20
paul-moore.com

