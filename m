Return-Path: <netdev+bounces-248032-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 977D3D0286A
	for <lists+netdev@lfdr.de>; Thu, 08 Jan 2026 13:05:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id F2B4B313082A
	for <lists+netdev@lfdr.de>; Thu,  8 Jan 2026 11:46:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 174B535580D;
	Thu,  8 Jan 2026 10:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WW/z2JSe"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f54.google.com (mail-dl1-f54.google.com [74.125.82.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8266F39E6C7
	for <netdev@vger.kernel.org>; Thu,  8 Jan 2026 10:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767867449; cv=none; b=B55DJSYMN//uvw8JdCCqw+lSzFpgCn0J4drsyQT2zApSPHTKWJyjxlU2NS3iWiwxPFbUvSd58dY35d7XvuY43+PENWHpKOjktunyk+7ykezlmILScjrwDOAD+Qt8ypbDLy8X57bSSl6AN3F87451+at+pvv/kraskpBKnl43AYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767867449; c=relaxed/simple;
	bh=Ogh8tAOoOjINkJI4yg6EZF9WR+UCZs8B5H9QpYxebYA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pbkT2mhBfqj/dQ1b+s0C7m5donOpJ1WglpoKIBJxQ+Yx8KzdJMDfWAq0188412bFBaNDJcp/C2i3ASB7aNWA6d2mqtwsq23xFScrIU2Nt4pc/EyP40SFRdGhqLO9aEAbqzmse2XmylsTOpva1X+LQlUXlaDDQn0o/Lg2JR/rB7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WW/z2JSe; arc=none smtp.client-ip=74.125.82.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-dl1-f54.google.com with SMTP id a92af1059eb24-121bf277922so3120975c88.0
        for <netdev@vger.kernel.org>; Thu, 08 Jan 2026 02:17:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1767867437; x=1768472237; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yZ1fs3Ohphla2JOGra+RJtxs+PcO1u7EwjOa/BB89TI=;
        b=WW/z2JSejySQzKm0tAXNzhnxRVch7X7N50GYxAXZbi5y5dCU/RvVSYI97dMly4SWS0
         vRHLhdojmEfx2ZSN/TsEbgGMikmjXx9YlYHLohotcQ3P7LVcH83sIiNyf7mXGTXAxTIu
         fy+6JMK5DXstvnlJfgofzMVU2iEJTtRwmcyYpv30hzNtyGZwiemTlUnV19Fwa3p/LYgY
         RzFJoHW9F8Im6ZL5RVn4g+EHaait+6HDVkVA0xiQoMmK/DATD0eaIr/uLJt+3ZL1duTD
         3Hsj9LRPANhjxy3+TmW+uYMgl/xA4v9yAWmGz/SY0KVuC9tdVAIgedTW/HrCocGBipIg
         H5rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767867437; x=1768472237;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=yZ1fs3Ohphla2JOGra+RJtxs+PcO1u7EwjOa/BB89TI=;
        b=TvqrmLWgmk8pO08rSjvIfFYr+/y29G+VJL0qIRrIZLW6W9sBdYJsZHT/JuFB8pPzNL
         2rt3s8yl/994ZOVk8LUb9tBU/ABk4OF/4xIVaIdvIHjjCy8q17o5Y6HAKlGTj3I+NsXO
         6bj1vvxRnL+mFYNfykVVETCI1ALmR1Gy3ShSbWetzNCRKbFAhN4wAQkF2HRku3cab351
         j4+TMv09ZrI27KhEokN961agi1LCADnz4vJzY4R67nS795FcHoJ9jY9a1orb2YzE43uN
         AyZszXbc8byTc+ShFn0SP8yR/oZ8SRdQ/Vv2YotYx3vKIksXHB/2CnL4mDXZEYutaMoh
         AGhA==
X-Forwarded-Encrypted: i=1; AJvYcCU8Hb6d/TM4VpVYtun7G6GTFb7+GCOVRGQZWoqimTbGSPg5sqWnxLpaC6nfX2u0vC0G1q9SyG4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxc8uZdh0Rce9NFHLy3jN/nb9YaIcFjkL/zB///sQQFBUbot3Gh
	itlPcLQu4aGuH1EwiKQLNdkr7xJEqf3ezq8o62PINj56UQlTyb9j4P1IqfeXSQ+lI+11fM1T/Bv
	oNWweK5vByNcmez/CFQHkXOnqdK1VYB1TIVo9oI48
X-Gm-Gg: AY/fxX6XmFT/t0r1IAKKRsz5ctdnNW+VGud+AXdbLdxHMEZBqf38tnFYecv+48UqJsf
	xqIdJZZQV6N7V8fjMfZe3xx9Ve8a9qOSgEfgTlwpyb1HrIgOgI4357fysPaSU4hZV8j9wiccRO4
	uZ2MYlcbrxfNhHB+v19ou2FTGnUkUko3095UGW8Ind0DCbieI3zw/EMU76rGojmVyofYH6yc9SO
	aXYvz90t5QwJ6b62E/LXwXkOAURuId5xENRTcWJmjDcK6f8pvO6CjedJtxkG5fjb3qyIgcc1jTt
	jwob+LcldapZ09ieo5c9O8hlj4lFXw==
X-Google-Smtp-Source: AGHT+IEMMbaQfZ7lBCEbNvFvi7mbfGcSl9hnMwuZ0q+ABdPgHEIYL9VhTGNA99HN668kF16xmTxfRs7XrSrMkqOwvT8=
X-Received: by 2002:a05:7022:23a5:b0:11a:c8f4:3216 with SMTP id
 a92af1059eb24-121f8b14c84mr4064588c88.15.1767867436254; Thu, 08 Jan 2026
 02:17:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251231213314.2979118-1-utilityemal77@gmail.com>
 <CAAVpQUCF3uES6j22P1TYzgKByw+E4EqpM=+OFyqtRGStGWxH+Q@mail.gmail.com>
 <aVuaqij9nXhLfAvN@google.com> <CAAVpQUB6gnfovRZAg_BfVKPuS868dFj7HxthbxRL-nZvcsOzCg@mail.gmail.com>
 <aV5WTGvQB0XI8Q_N@google.com>
In-Reply-To: <aV5WTGvQB0XI8Q_N@google.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Thu, 8 Jan 2026 02:17:05 -0800
X-Gm-Features: AQt7F2rdIe6CkrQHtb0o9QvKbxRtFU-yNoPsYBohXhvgwop6uzgiOI8WxkEiNf4
Message-ID: <CAAVpQUAd==+Pw02+E6UC-qwaDNm7aFg+Q9YDbWzyniShAkAhFQ@mail.gmail.com>
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

On Wed, Jan 7, 2026 at 4:49=E2=80=AFAM G=C3=BCnther Noack <gnoack@google.co=
m> wrote:
>
> On Tue, Jan 06, 2026 at 11:33:32PM -0800, Kuniyuki Iwashima wrote:
> > +VFS maintainers
> >
> > On Mon, Jan 5, 2026 at 3:04=E2=80=AFAM G=C3=BCnther Noack <gnoack@googl=
e.com> wrote:
> > >
> > > Hello!
> > >
> > > On Sun, Jan 04, 2026 at 11:46:46PM -0800, Kuniyuki Iwashima wrote:
> > > > On Wed, Dec 31, 2025 at 1:33=E2=80=AFPM Justin Suess <utilityemal77=
@gmail.com> wrote:
> > > > > Motivation
> > > > > ---
> > > > >
> > > > > For AF_UNIX sockets bound to a filesystem path (aka named sockets=
), one
> > > > > identifying object from a policy perspective is the path passed t=
o
> > > > > connect(2). However, this operation currently restricts LSMs that=
 rely
> > > > > on VFS-based mediation, because the pathname resolved during conn=
ect()
> > > > > is not preserved in a form visible to existing hooks before conne=
ction
> > > > > establishment.
> > > >
> > > > Why can't LSM use unix_sk(other)->path in security_unix_stream_conn=
ect()
> > > > and security_unix_may_send() ?
> > >
> > > Thanks for bringing it up!
> > >
> > > That path is set by the process that acts as the listening side for
> > > the socket.  The listening and the connecting process might not live
> > > in the same mount namespace, and in that case, it would not match the
> > > path which is passed by the client in the struct sockaddr_un.
> >
> > Thanks for the explanation !
> >
> > So basically what you need is resolving unix_sk(sk)->addr.name
> > by kern_path() and comparing its d_backing_inode(path.dentry)
> > with d_backing_inode (unix_sk(sk)->path.dendtry).
> >
> > If the new hook is only used by Landlock, I'd prefer doing that on
> > the existing connect() hooks.
>
> I've talked about that in the "Alternative: Use existing LSM hooks" secti=
on in
> https://lore.kernel.org/all/20260101134102.25938-1-gnoack3000@gmail.com/
>
> If we resolve unix_sk(sk)->addr.name ourselves in the Landlock hook
> again, we would resolve the path twice: Once in unix_find_bsd() in
> net/unix/af_unix.c (the Time-Of-Use), and once in the Landlock
> security hook for the connect() operation (the Time-Of-Check).
>
> If I understand you correctly, you are suggesting that we check that
> the inode resolved by af_unix
> (d_backing_inode(unix_sk(sk)->path.dentry)) is the same as the one
> that we resolve in Landlock ourselves, and therefore we can detect the
> TOCTOU race and pretend that this is equivalent to the case where
> af_unix resolved to the same inode with the path that Landlock
> observed?
>
> If the walked file system hierarchy changes in between these two
> accesses, Landlock enforces the policy based on path elements that
> have changed in between.
>
> * We start with a Landlock policy where Unix connect() is restricted
>   by default, but is permitted on "foo/bar2" and everything underneath
>   it.  The hierarchy is:
>
>   foo/
>       bar/
>           baz.sock
>       bar2/        <--- Landlock rule: socket connect() allowed here and =
below
>
> * We connect() to the path "foo/bar/baz.sock"
> * af_unix.c path lookup resolves "foo/bar/baz.sock" (TOU)
>   This works because Landlock is not checked at this point yet.
> * In between the two lookups:
>   * the directory foo/bar gets renamed to foo/bar.old
>   * foo/bar2 gets moved to foo/bar
>   * baz.sock gets moved into the (new) foo/bar directory
> * Landlock check: path lookup of "foo/bar/baz.sock" (TOC)
>   and subsequent policy check using the resolved path.
>
>   This succeeds because connect() is permitted on foo/bar2 and
>   beneath.  We also check that the resolved inode is the same as the
>   one resolved by af_unix.c.
>
> And now the reasoning is basically that this is fine because the
> (inode) result of the two lookups was the same and we pretend that the
> Landlock path lookup was the one where the actual permission check was
> done?

Right.  IIUC, even in your patch, the file could be renamed
while LSM is checking the path, no ?  I think holding the
path ref does not lock concurrent rename operations.

To me, it's not a small race and basically it's the same with
the ops below,

sk1.bind('test')
sk1.listen()
os.rename('test', 'test2')
sk2.connect('test2')

sk1.bind('test')
sk1.listen()
sk2.connect('test1')
os.rename('test', 'test2')

and the important part is whether the path _was_ the
allowed one when LSM checked the path.

>
> Some pieces of this which I am still unsure about:
>
> * What we are supposed to do when the two resolved inodes are not the
>   same, because we detected the race?  We can not allow the connection
>   in that case, but it would be wrong to deny it as well.  I'm not
>   sure whether returning one of the -ERESTART* variants is feasible in
>   this place and bubbles up correctly to the system call / io_uring
>   layer.

Imagine that the rename ops was done a bit earlier, which is
before the first lookup in unix_find_bsd().  Then, the socket
will not be found, and -ECONNREFUSED is returned.
LSM pcan pretend as such.


>
> * What if other kinds of permission checks happen on a different
>   lookup code path?  (If another stacked LSM had a similar
>   implementation with yet another path lookup based on a different
>   kind of policy, and if a race happened in between, it could at least
>   be possible that for one variant of the path, it would be OK for
>   Landlock but not the other LSM, and for the other variant of the
>   path it would be OK for the other LSM but not Landlock, and then the
>   connection could get accepted even if that would not have been
>   allowed on one of the two paths alone.)  I find this a somewhat
>   brittle implementation approach.

Do you mean that the evaluation of the stacked LSMs could
return 0 if one of them allows it even though other LSMs deny ?


>
> * Would have to double check the unix_dgram_connect code paths in
>   af_unix to see whether this is feasible for DGRAM sockets:
>
>   There is a way to connect() a connectionless DGRAM socket, and in
>   that case, the path lookup in af_unix happens normally only during
>   connect(),

Note that connected DGRAM socket can send() data to other sockets
by specifying the peer name in each send(), and even they can
disconnect by connect(AF_UNSPEC).


> very far apart from the initial security_unix_may_send()
>   LSM hook which is used for DGRAM sockets - It would be weird if we
>   were able to connect() a DGRAM socket, thinking that now all path
>   lookups are done, but then when you try to send a message through
>   it, Landlock surprisingly does the path lookup again based on a very
>   old and possibly outdated path.  If Landlock's path lookup fails
>   (e.g. because the path has disappeared, or because the inode now
>   differs), retries won't be able to recover this any more.  Normally,
>   the path does not need to get resolved any more once the DGRAM
>   socket is connected.
>
>   Noteworthy: When Unix servers restart, they commonly unlink the old
>   socket inode in the same place and create a new one with bind().  So
>   as the time window for the race increases, it is actually a common
>   scenario that a different inode with appear under the same path.
>
> I have to digest this idea a bit.  I find it less intuitive than using
> the exact same struct path with a newly introduced hook, but it does
> admittedly mitigate the problem somewhat.  I'm just not feeling very
> comfortable with security policy code that requires difficult
> reasoning. =F0=9F=A4=94 Or maybe I interpreted too much into your suggest=
ion. :)
> I'd be interested to hear what you think.
>
> =E2=80=94G=C3=BCnther

