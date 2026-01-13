Return-Path: <netdev+bounces-249642-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 58019D1BB74
	for <lists+netdev@lfdr.de>; Wed, 14 Jan 2026 00:27:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 6EDBE3012665
	for <lists+netdev@lfdr.de>; Tue, 13 Jan 2026 23:27:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70E1136B069;
	Tue, 13 Jan 2026 23:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="cz7LpQGf"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FAAA34FF59
	for <netdev@vger.kernel.org>; Tue, 13 Jan 2026 23:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768346849; cv=none; b=DgLp5T5sRWSqFIwOyrq+sCcNaxhnWC9s5SUIWwcQNNDARcXiFZ4bX9BqdmK34g1jCvVy4v6E+9jsqycOk3e2IRxSXHNuU9tKTRfLl8/bX+AqKaOOZMeIeQ9DfByguKknhMhwZHDyJvCdAbkW2UiI/QU8FQaupd7uibQBDoJU/K8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768346849; c=relaxed/simple;
	bh=eSKvxq9YwVBzyMuYewlHzV06JI+v3ubEKxN2UzdrhAk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FIbdfsZsjUPECY/dLWM1GJrpPkXdmWAOwx/y31ynB0CYoQ/JFXleqvGFwDLRoSQN0eYCL6uTy6jBHZvA095VJN3fOpsWtJqXG7Zwn7UWGotLcQ1Yj9ILjqQTGp/hD5scVq3DE72HjoqlzUs2IOOFXTblRQkrw2f7zNMoehgz4fE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=cz7LpQGf; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-34c2f335681so4722414a91.1
        for <netdev@vger.kernel.org>; Tue, 13 Jan 2026 15:27:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1768346847; x=1768951647; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=myIopHE8OLjLfSfgj5xRK52HoztIhbA+miJiAcmBvWQ=;
        b=cz7LpQGfuOmJ1Y66NOVYcrK1WRxvDD9ajc9Fl7lq/dg9TJbjXqOfolAdlT+Qjy4BtE
         dcnHaezi1WNKhrYZCHOhgxPCIQeGk6DBCw1ivOnTBpWVFazDH9kkiBAAQWwnEpdL0Yij
         sHZgg8OQZm4/6HpAez5YqNjhdn8O1S9ZlMvnuB63LEg8IRkGAqTIxAdFnWEXOSsHnlTY
         lgBAKdQuX0YWl/+OghPMnan1WtNwBaUJ4ZrJ2oBqmtH0uGZdhUX6kmG2pntgX97VMBZ5
         CgOLVsJwvkpmq9AvrNxoRBDNMaYEZdNAOsLTTNq9Cwx6LnzTwO7X4+cpyldDVhhsfk3Z
         3GqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768346847; x=1768951647;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=myIopHE8OLjLfSfgj5xRK52HoztIhbA+miJiAcmBvWQ=;
        b=FTyKuZ/Q58igbLSNNsOSOFeod9OD8tqqfSbSPbf+CZvVci01URB0cfSImrHHjAMX3v
         0lrT1p+L+5UJxZxt9BLDEyrx2RtE2l6Z16AODQhI8agZpoj4g52nnpPKiVPTNpZ7xsBG
         cKBtU1xD+Sk2NoZDE2bbFjeYqURjLS1JKyPtalqPYqCSvTQaB09NAyqLbEmNcaz//IuA
         hxtkMQCQkngYEWReoMobf3c9kfgDn5PrlRtcJOI+fSbxyHYpbTOJ916RKkH9Dcfcoey/
         21FDyDjsn/pV1eljt/QpcGrkTZ4ZWniUtUBTeD/BUrLL2TXyTOzpkFszfn2sv7wQyEE+
         7YRQ==
X-Forwarded-Encrypted: i=1; AJvYcCUToaOburliGHpSS/8wVq/EI198rDg4BrJYfoZJxCsRcRfkwAMHhRBuVQsi7n5kSmxnMrBooh8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyzWBBphkSFozxxwrs4W5E8+F6yftow2T8ZRj7uppIfAbZxvjd/
	Y4b1oKpvPqH9zO8cKohsq4aXrMH2HIBAaldXcgRnnnNcq0TA0cT/iqHzrbJ8WCpB8E1kultoc6M
	xJoAC36k4OzQ2dNKy+4sCf3e7mJ1E7Ksj4NhaFbNH
X-Gm-Gg: AY/fxX4MIsF8WYOK5GKWFEHzQiFQsoNWCsKUgXEFzu+pV4yGght6D32ftlH7/VCNTSv
	haS2zY5V1VyxJgkqKJFy2bQFL3miqPRd9QyaIRjOnuZI1EGRAbR5c3vwtG2xGLkkBpcOXtYZ2Jk
	zCT/jdQntAPyNmuFY17qsYy/203eNI4RFWG0tvjlzeiTIEJtwyJNknfrzWnTYm5SdjNF+eRE5UV
	HQBYOxQ/vjPJjTwGOv+cS/PbGcc4BEv4+ssa3yAognBuYXLprZuOcoFWyj3TRI/MH7/7PU=
X-Received: by 2002:a17:90b:5808:b0:34f:454f:69a9 with SMTP id
 98e67ed59e1d1-35109176388mr565981a91.28.1768346847514; Tue, 13 Jan 2026
 15:27:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260110143300.71048-2-gnoack3000@gmail.com> <20260110143300.71048-4-gnoack3000@gmail.com>
 <20260113-kerngesund-etage-86de4a21da24@brauner>
In-Reply-To: <20260113-kerngesund-etage-86de4a21da24@brauner>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 13 Jan 2026 18:27:15 -0500
X-Gm-Features: AZwV_Qh90nIBcXw1OpIJ0y4At6w-yMoPWBag3gRCXMZrMzEXPFso5KKQHG1ZKIY
Message-ID: <CAHC9VhQOQ096WEZPLo4-57cYkM8c38qzE-F8L3f_cSSB4WadGg@mail.gmail.com>
Subject: Re: [PATCH v2 1/5] lsm: Add hook unix_path_connect
To: Christian Brauner <brauner@kernel.org>
Cc: =?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack3000@gmail.com>, 
	=?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>, 
	James Morris <jmorris@namei.org>, "Serge E . Hallyn" <serge@hallyn.com>, 
	Justin Suess <utilityemal77@gmail.com>, linux-security-module@vger.kernel.org, 
	Tingmao Wang <m@maowtm.org>, Samasth Norway Ananda <samasth.norway.ananda@oracle.com>, 
	Matthieu Buffet <matthieu@buffet.re>, Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>, 
	konstantin.meskhidze@huawei.com, Demi Marie Obenour <demiobenour@gmail.com>, 
	Alyssa Ross <hi@alyssa.is>, Jann Horn <jannh@google.com>, Tahera Fahimi <fahimitahera@gmail.com>, 
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, 
	Alexander Viro <viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 13, 2026 at 4:34=E2=80=AFAM Christian Brauner <brauner@kernel.o=
rg> wrote:
> On Sat, Jan 10, 2026 at 03:32:57PM +0100, G=C3=BCnther Noack wrote:
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

> > diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
> > index 55cdebfa0da0..3aabe2d489ae 100644
> > --- a/net/unix/af_unix.c
> > +++ b/net/unix/af_unix.c
> > @@ -1226,6 +1226,15 @@ static struct sock *unix_find_bsd(struct sockadd=
r_un *sunaddr, int addr_len,
> >       if (!S_ISSOCK(inode->i_mode))
> >               goto path_put;
> >
> > +     /*
> > +      * We call the hook because we know that the inode is a socket
> > +      * and we hold a valid reference to it via the path.
> > +      */
> > +     err =3D security_unix_path_connect(&path, type, flags);
> > +     if (err)
> > +             goto path_put;
>
> Couldn't we try reflowing the code here so the path is passed ...

It would be good if you could be a bit more specific about your
desires here.  Are you talking about changing the
unix_find_other()/unix_find_bsd() code path such that the path is
available to unix_find_other() callers and not limited to the
unix_find_bsd() scope?

> ... to
> security_unix_stream_connect() and security_unix_may_send() so that all
> LSMs get the same data and we don't have to have different LSMs hooks
> into different callpaths that effectively do the same thing.
>
> I mean the objects are even in two completely different states between
> those hooks. Even what type of sockets get a call to the LSM is
> different between those two hooks.

I'm working on the assumption that you are talking about changing the
UNIX socket code so that the path info is available to the existing
_may_send() and _stream_connect() hooks.  If that isn't the case, and
you're thinking of something different, disregard my comments below.

In both the unix_dgram_{connect(),sendmsg()}, aka
security_unix_may_send(), cases and the unix_stream_connect(), aka
security_unix_stream_connect(), case the call to unix_find_other() is
done to lookup the other end of the communication channel, which does
seem reasonably consistent to me.  Yes, of course, once you start
getting into the specifics of the UNIX socket handling the unix_dgram_
and unix_stream_ cases are very different, including their
corresponding existing LSM hooks, but that doesn't mean in the context
of unix_find_bsd() that security_unix_path_connect() doesn't have
value.

The alternative would be some rather serious surgery in af_unix.c to
persist the path struct from unix_find_bsd() until the later LSM hooks
are executed.  It's certainly not impossible, but I'm not sure it is
necessary or desirable at this point in time.  LSMs that wish to
connect the information from _unix_path_connect() to either
_unix_stream_connect() or _unix_may_send() can do so today without
needing to substantially change af_unix.c.

--=20
paul-moore.com

