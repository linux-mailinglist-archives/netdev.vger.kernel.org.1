Return-Path: <netdev+bounces-247621-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 64AADCFC68D
	for <lists+netdev@lfdr.de>; Wed, 07 Jan 2026 08:40:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A05333046FBE
	for <lists+netdev@lfdr.de>; Wed,  7 Jan 2026 07:33:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D0B623C503;
	Wed,  7 Jan 2026 07:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nu9mPLFl"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f46.google.com (mail-dl1-f46.google.com [74.125.82.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0861280332
	for <netdev@vger.kernel.org>; Wed,  7 Jan 2026 07:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767771226; cv=none; b=IMn5/D7KV/MbknruN1NpzghGDs8K6thdEE9BxyJb4KGblXyjeAd+OMiAwqJNnlnzE+aUCSwL6du63D+298mQgjH+2+d016nF8AqGA+OmKpigC8Gyy+Y/+gq+OlH8MloZ29n7PNGq2DVZAfxfZzahNasIMWsOVl+iWTUV1acjtAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767771226; c=relaxed/simple;
	bh=DqDSpwcYbNYLl1aM0TIWsuAfF70N/EEM8oLleO/iIYk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ux5xbwtzJE5ycDvm40rZIOrCfV3EWWCGzwEHAQ2FO6C0tAXP4srMIMMScyA3j3U8IuhvsLiUOX9zvVzEhSvYgYLtaZ22bgnFB2a96WvqbL8S2RRvDCOBc8BTKpm8i+4v+PiFtcjA5juYD+HNQjxb0DFMBnX3+Skfv7Iigg3SSoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nu9mPLFl; arc=none smtp.client-ip=74.125.82.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-dl1-f46.google.com with SMTP id a92af1059eb24-11f36012fb2so1505528c88.1
        for <netdev@vger.kernel.org>; Tue, 06 Jan 2026 23:33:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1767771224; x=1768376024; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AYGT8bDi0cltarggyS89UVlr8I1trzzHf57StlSFRxg=;
        b=nu9mPLFlQLFcXvYMdpBsB/O0an09BuHjlbGv4n3ValpajYAd8oryCLw7PzYBMMjMdL
         eTxsfwK2qFou9sKdWRVstuAGMaT7gV1rgdVNqVm/5xVGd4b8sLhlXhWYibDgd0Gk+MCu
         3n25Gn0MuAK3Fo8J27jBTGobTwVj8j5fDYkisgDsTKKlwOKP9R6JgzTVhdfUbJRo4K53
         OeJObygvs5fWQ/2Wf0tdvC4To1GRutNr4aQm8frfU9XAmp9hzpOBRhHS3eoaAEpO3zL8
         MtlJaWX7w3FblM2gnqUKn3jath67T2Y4QbYUkpIvr7M9F1B/8UZK/tVaz36NGLB3kuPB
         tJwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767771224; x=1768376024;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=AYGT8bDi0cltarggyS89UVlr8I1trzzHf57StlSFRxg=;
        b=mOU6YOYcZe7BZZQXA6teea/r5kdEllzhnupmJ3TNqb7XjdjldEZhlaIEelpP5t4Eql
         AvIVgB8zlnEBztf4FBQ5kb7XvfPC1Oz466uPd4aQIE8Hw4Z0fvBOCrbqk1KrLYLgYyQr
         M028eYFjxtijDvqfKGLV8Df2KLADwUBjU5wiCCk8VObwzhv1umb+I/ks5m15tn5YkgkW
         VwnAQ19M95itO/yPsFHny/dsCafloPDnYku6tPuwbJOcDdWKxafTGpr9H/BzYLo3N3A4
         4XR8ejbqZOcacE/LvWLm/bDk6s/jegvd/Lw9NOiVKePWdMOvV+C5UH66VyeEGruw3rel
         VBmA==
X-Forwarded-Encrypted: i=1; AJvYcCULYMnjOGXKvJBKGZJhjlhSHn3G7vgXxLG7PQOkcljerW0T8rlS09iQa0nuFZpRfiOCcKsbBXY=@vger.kernel.org
X-Gm-Message-State: AOJu0YykmUKLxLZfOrPZzxGTIwrJveVaNsvTHPhsw3ijnfW3pwQevbk7
	tIqTXBH2OkwufpcLOxVbJ8YxZeycfflQwHHg19j4u+KJIcc5AEeF9dWbBQVgJfDQLJOHEeAuh/m
	MIkxvHduEo0FBJgC2uFv3aV16p7m8VnwsA5ZXzEUV
X-Gm-Gg: AY/fxX5pm1zIEBFyJEn+VPgdFfJ05+i2JkmdnglPL//2FuoviqNc4G/UBU+Pq7020vZ
	5ltQviZivY4Nhjm2eSmI3n6bQQ3YfjPVJ6Dq4Vg4gTMR6Xv9pqRG7JUnIpfOTpFuaM0eUznZ/+1
	79Mo/ddvohQ1BKyBZ7EfoiozH+abwAFxpb1/JGAkVaAzcknGotCtSp4CMzB8vM0ZG+hIY6WwDmR
	aMA4bAbeOj3TEncvxJaG+M5mSL/Owq1Pel5C9hwe7bTr2KCqyWypXLEZBmmeAaaljgnJrvKuPCJ
	r/KrwUeibIRZHcUWPVOfUOM/FD4=
X-Google-Smtp-Source: AGHT+IGVWDaAAufKG6cmY61WIEHpz/DCkMzHNAMA7Qq/9XczEH9ksqtPnuAAKTZpAqiEaew+WJqsmTkoKXiTFbLDgrA=
X-Received: by 2002:a05:7022:41d:b0:11a:342e:8a98 with SMTP id
 a92af1059eb24-121f8a3172fmr1585843c88.0.1767771223553; Tue, 06 Jan 2026
 23:33:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251231213314.2979118-1-utilityemal77@gmail.com>
 <CAAVpQUCF3uES6j22P1TYzgKByw+E4EqpM=+OFyqtRGStGWxH+Q@mail.gmail.com> <aVuaqij9nXhLfAvN@google.com>
In-Reply-To: <aVuaqij9nXhLfAvN@google.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Tue, 6 Jan 2026 23:33:32 -0800
X-Gm-Features: AQt7F2oljSqURSVX-s0tTsTMpeCMLJQxfW23hgyHnAzDH_XdW9vmaQD1ns9eGvg
Message-ID: <CAAVpQUB6gnfovRZAg_BfVKPuS868dFj7HxthbxRL-nZvcsOzCg@mail.gmail.com>
Subject: Re: [RFC PATCH 0/1] lsm: Add hook unix_path_connect
To: =?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack@google.com>
Cc: Justin Suess <utilityemal77@gmail.com>, Paul Moore <paul@paul-moore.com>, 
	James Morris <jmorris@namei.org>, "Serge E . Hallyn" <serge@hallyn.com>, Simon Horman <horms@kernel.org>, 
	=?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>, 
	linux-security-module@vger.kernel.org, Tingmao Wang <m@maowtm.org>, 
	netdev@vger.kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

+VFS maintainers

On Mon, Jan 5, 2026 at 3:04=E2=80=AFAM G=C3=BCnther Noack <gnoack@google.co=
m> wrote:
>
> Hello!
>
> On Sun, Jan 04, 2026 at 11:46:46PM -0800, Kuniyuki Iwashima wrote:
> > On Wed, Dec 31, 2025 at 1:33=E2=80=AFPM Justin Suess <utilityemal77@gma=
il.com> wrote:
> > > Motivation
> > > ---
> > >
> > > For AF_UNIX sockets bound to a filesystem path (aka named sockets), o=
ne
> > > identifying object from a policy perspective is the path passed to
> > > connect(2). However, this operation currently restricts LSMs that rel=
y
> > > on VFS-based mediation, because the pathname resolved during connect(=
)
> > > is not preserved in a form visible to existing hooks before connectio=
n
> > > establishment.
> >
> > Why can't LSM use unix_sk(other)->path in security_unix_stream_connect(=
)
> > and security_unix_may_send() ?
>
> Thanks for bringing it up!
>
> That path is set by the process that acts as the listening side for
> the socket.  The listening and the connecting process might not live
> in the same mount namespace, and in that case, it would not match the
> path which is passed by the client in the struct sockaddr_un.

Thanks for the explanation !

So basically what you need is resolving unix_sk(sk)->addr.name
by kern_path() and comparing its d_backing_inode(path.dentry)
with d_backing_inode (unix_sk(sk)->path.dendtry).

If the new hook is only used by Landlock, I'd prefer doing that on
the existing connect() hooks.


>
> For more details, see
> https://lore.kernel.org/all/20260101134102.25938-1-gnoack3000@gmail.com/
> and
> https://github.com/landlock-lsm/linux/issues/36#issuecomment-2950632277
>
> Justin: Maybe we could add that reasoning to the cover letter in the
> next version of the patch?
>
> =E2=80=93G=C3=BCnther

