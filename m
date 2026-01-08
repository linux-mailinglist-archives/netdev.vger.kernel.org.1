Return-Path: <netdev+bounces-248275-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E9CC5D06531
	for <lists+netdev@lfdr.de>; Thu, 08 Jan 2026 22:30:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 835BA30054A4
	for <lists+netdev@lfdr.de>; Thu,  8 Jan 2026 21:30:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCB0533D4E3;
	Thu,  8 Jan 2026 21:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HFO6cyrt"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2CE5331205
	for <netdev@vger.kernel.org>; Thu,  8 Jan 2026 21:30:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767907845; cv=none; b=reol4+XhFpcOv5mXQ4cUcZWuNUuoSGcFvkWJIvrlWrhVTzqFL3R1UuSV+d6IiiO0MB0N85mkL/ZR0tUXp0p1SnG8wTroqCQ+hTmNFAyxhQ5aNIoUAN9HOvulB/uGKkhcfFMkrBenYLLHGraEVjJRoK1Y+qIHXqKTIE/VVRk/OcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767907845; c=relaxed/simple;
	bh=wQQy/zLheQu3N0Ta1Yse6Ja4W8T5x5T2kMKuHuYjdZc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hz353BCFR8XajmsQR0DVs2V+fkBKZ7HB9IWL6L2zVb2YOFGpbMe467uCBe0hTow6JwFwqat+rLTOV0aX0bR8ciRQFZQEE13Kw/VNwjJLM2lBHbDUwFUUGnVEPRn5kfn5/pxBz2sgtnAnmveNimxu0uwrHexDh24cMFIB0lLeQ0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HFO6cyrt; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-64b791b5584so5865277a12.0
        for <netdev@vger.kernel.org>; Thu, 08 Jan 2026 13:30:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767907842; x=1768512642; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=HMKTJlt9JJh16Ds5PjRbwaKnf8t6uMgK+RBuys6jkLQ=;
        b=HFO6cyrthuoBZfss/q+keOh2gbT1BgUVqrsUacJfWWp0xf6CfcMp5OMymk5u4BoHdo
         mFRV1uLzAlYLIVMp7rYisYqmWxDtMZEM8SjI+YOsIl8Yt+3kWkqm9cWG/nO+JL9yISuM
         O0xVsoiY2TWAkOeYi44bdgPbHjEw2ZRetz0lRcspyN5U/QbCv3TGE/64hDwcuv7IIneZ
         wx27CvMXPAYjsiAKubTRmOl5adYYD6JbYv56UvfMZEpNj4DqGG18qO3kZ6AQIw+P+mYo
         K02cQrWliW4aYxVhagsu/obl2Le3i+F4DrsB1VnF8eJFLzpWsL0G8ldeV05320Y3vzx+
         mgVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767907842; x=1768512642;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HMKTJlt9JJh16Ds5PjRbwaKnf8t6uMgK+RBuys6jkLQ=;
        b=PwLeRxlFwGeaaE7WsHl1IZtSVKDaH8Il4q0dXvgqp1ryFSLC+VsHY98neo1ET+ZAye
         ujXjVKpp3qa6ITxn5JnMooe95H1Y5kg2KLGy5+4lJXk8u/ageyu3pQcxlVzxMrrWz/Vv
         NLMmzR8NEljPFi1pVq1bl0vwulZd/KX23qweSz4b6r9sPmG3ngXwZHq+1Ir9rPBllIAp
         1pDGeOpYn7CmXGO6KXnKbHStlo3srU+GL0pGeHAvCMH1So5OGzHVtge6YFhmAQ6k3NCB
         zpA/MBh0o6Q9a9aHE5NIcxz7IbjowR6ciXCobWjE37f7ZpgeIsQWIryYOJCa1ngx4LDe
         5tOw==
X-Forwarded-Encrypted: i=1; AJvYcCUlK7ziDw04WrOzRBNxvcn/eKqEeEwo/O/QwVCMv4i/IHrvm33C+9SUPsILkPivfdjE/Giiq8A=@vger.kernel.org
X-Gm-Message-State: AOJu0YzskPnSr+spjuLyg8JYPRIJngDOtq4WoA8H82WrDyYNgiJSLkyH
	HICn2dGhpkcrJAKdwEe9KkgejxcCLJRWUxHTLGgzu6FwQ8Udsmmgf17U
X-Gm-Gg: AY/fxX7+9G+FkwgdDWglVz58zYwq7KU3si0gAhZGqZ2a1EPkWXt7g6MM731HqNWsgba
	9+f97Gb1Bap9Wm/FEylnvl3Rb6OTkq/ldMNb/xe8PIFYt1jqq86mPxVSaN6NXolpeBQn+HV5mM9
	SfmcoCm+qI2jUnfc5YuwByoz58tqTSYo2a6oLO1onRF5XM5V/Mvrj+6FCsRYWREjEQ2gHFnlEeo
	a6WeRp9ah7oSGVIEKUQmkxz/JZUk/h3sR8te5sn0Zr0PCJeQvWOpjHdOfhaS5EQcDJyKbw3Dylj
	yAvZDZkVzYNr1UCNH3LzSIAu0XphKZY2zugRE3fO551q3e0WAwsuCSO8ba8W2vvqSlKOFSSFmAL
	eBpgDOJW6zfLRPyQ5L12CiN4KUOW+PGwB9JDoqXnIYfdBUJAOOX6Aa/ufqKkkJzgUS3UQba44H2
	rShFO2IieUIGnT90M7AtyUCe/k0Dk/xliN2VVQ
X-Google-Smtp-Source: AGHT+IHwTVyYZ9hMhL7SEEI/McSUe6ywY2CUuc/vftDZMD0MCKF6SvufRdjg9lBshGIzXaLIMz+a6w==
X-Received: by 2002:a05:6402:3593:b0:64c:69e6:ad3e with SMTP id 4fb4d7f45d1cf-65097e8e43fmr6916630a12.33.1767907841885;
        Thu, 08 Jan 2026 13:30:41 -0800 (PST)
Received: from localhost (ip87-106-108-193.pbiaas.com. [87.106.108.193])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6507bf6d5d4sm8450117a12.32.2026.01.08.13.30.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jan 2026 13:30:41 -0800 (PST)
Date: Thu, 8 Jan 2026 22:30:36 +0100
From: =?iso-8859-1?Q?G=FCnther?= Noack <gnoack3000@gmail.com>
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: =?iso-8859-1?Q?G=FCnther?= Noack <gnoack@google.com>,
	Justin Suess <utilityemal77@gmail.com>,
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
	"Serge E . Hallyn" <serge@hallyn.com>,
	Simon Horman <horms@kernel.org>,
	=?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>,
	linux-security-module@vger.kernel.org, Tingmao Wang <m@maowtm.org>,
	netdev@vger.kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>
Subject: Re: [RFC PATCH 0/1] lsm: Add hook unix_path_connect
Message-ID: <20260108.64bd7391e1ae@gnoack.org>
References: <20251231213314.2979118-1-utilityemal77@gmail.com>
 <CAAVpQUCF3uES6j22P1TYzgKByw+E4EqpM=+OFyqtRGStGWxH+Q@mail.gmail.com>
 <aVuaqij9nXhLfAvN@google.com>
 <CAAVpQUB6gnfovRZAg_BfVKPuS868dFj7HxthbxRL-nZvcsOzCg@mail.gmail.com>
 <aV5WTGvQB0XI8Q_N@google.com>
 <CAAVpQUAd==+Pw02+E6UC-qwaDNm7aFg+Q9YDbWzyniShAkAhFQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAAVpQUAd==+Pw02+E6UC-qwaDNm7aFg+Q9YDbWzyniShAkAhFQ@mail.gmail.com>

On Thu, Jan 08, 2026 at 02:17:05AM -0800, Kuniyuki Iwashima wrote:
> On Wed, Jan 7, 2026 at 4:49 AM Günther Noack <gnoack@google.com> wrote:
> > On Tue, Jan 06, 2026 at 11:33:32PM -0800, Kuniyuki Iwashima wrote:
> > > +VFS maintainers
> > >
> > > [...]
> > >
> > > Thanks for the explanation !
> > >
> > > So basically what you need is resolving unix_sk(sk)->addr.name
> > > by kern_path() and comparing its d_backing_inode(path.dentry)
> > > with d_backing_inode (unix_sk(sk)->path.dendtry).
> > >
> > > If the new hook is only used by Landlock, I'd prefer doing that on
> > > the existing connect() hooks.
> >
> > I've talked about that in the "Alternative: Use existing LSM hooks" section in
> > https://lore.kernel.org/all/20260101134102.25938-1-gnoack3000@gmail.com/
> >
> > If we resolve unix_sk(sk)->addr.name ourselves in the Landlock hook
> > again, we would resolve the path twice: Once in unix_find_bsd() in
> > net/unix/af_unix.c (the Time-Of-Use), and once in the Landlock
> > security hook for the connect() operation (the Time-Of-Check).
> >
> > If I understand you correctly, you are suggesting that we check that
> > the inode resolved by af_unix
> > (d_backing_inode(unix_sk(sk)->path.dentry)) is the same as the one
> > that we resolve in Landlock ourselves, and therefore we can detect the
> > TOCTOU race and pretend that this is equivalent to the case where
> > af_unix resolved to the same inode with the path that Landlock
> > observed?
> >
> > If the walked file system hierarchy changes in between these two
> > accesses, Landlock enforces the policy based on path elements that
> > have changed in between.
> >
> > * We start with a Landlock policy where Unix connect() is restricted
> >   by default, but is permitted on "foo/bar2" and everything underneath
> >   it.  The hierarchy is:
> >
> >   foo/
> >       bar/
> >           baz.sock
> >       bar2/        <--- Landlock rule: socket connect() allowed here and below
> >
> > * We connect() to the path "foo/bar/baz.sock"
> > * af_unix.c path lookup resolves "foo/bar/baz.sock" (TOU)
> >   This works because Landlock is not checked at this point yet.
> > * In between the two lookups:
> >   * the directory foo/bar gets renamed to foo/bar.old
> >   * foo/bar2 gets moved to foo/bar
> >   * baz.sock gets moved into the (new) foo/bar directory
> > * Landlock check: path lookup of "foo/bar/baz.sock" (TOC)
> >   and subsequent policy check using the resolved path.
> >
> >   This succeeds because connect() is permitted on foo/bar2 and
> >   beneath.  We also check that the resolved inode is the same as the
> >   one resolved by af_unix.c.
> >
> > And now the reasoning is basically that this is fine because the
> > (inode) result of the two lookups was the same and we pretend that the
> > Landlock path lookup was the one where the actual permission check was
> > done?
> 
> Right.  IIUC, even in your patch, the file could be renamed
> while LSM is checking the path, no ?  I think holding the
> path ref does not lock concurrent rename operations.
> 
> To me, it's not a small race and basically it's the same with
> the ops below,
> 
> sk1.bind('test')
> sk1.listen()
> os.rename('test', 'test2')
> sk2.connect('test2')
> 
> sk1.bind('test')
> sk1.listen()
> sk2.connect('test1')
> os.rename('test', 'test2')
> 
> and the important part is whether the path _was_ the
> allowed one when LSM checked the path.

I think we are in agreement here, yes.  What matters is that the LSM
does its check on the same path as connect() used for the lookup (or
that at least it behaves that way to an outside observer).

> > Some pieces of this which I am still unsure about:
> >
> > * What we are supposed to do when the two resolved inodes are not the
> >   same, because we detected the race?  We can not allow the connection
> >   in that case, but it would be wrong to deny it as well.  I'm not
> >   sure whether returning one of the -ERESTART* variants is feasible in
> >   this place and bubbles up correctly to the system call / io_uring
> >   layer.
> 
> Imagine that the rename ops was done a bit earlier, which is
> before the first lookup in unix_find_bsd().  Then, the socket
> will not be found, and -ECONNREFUSED is returned.
> LSM pcan pretend as such.

No, it can not pretend as such when the inodes differ - the reasoning
is:

The rename(2) operation can be used to put a new socket in the place
of the old one, and both sockets might be OK to use in the Landlock
policy.  If Landlock observes the race and the inodes are different,
that still does not mean that it should refuse the connection.

The trace is:

* /sock1 and /sock2 exist
* initial unix_find_bsd() lookup for /sock1
* rename(2) /sock2 to /sock1, replacing it
* LSM (Landlock) lookup for /sock1

The two lookups return different inodes, but we still should not
refuse the connection because of that.


> > * What if other kinds of permission checks happen on a different
> >   lookup code path?  (If another stacked LSM had a similar
> >   implementation with yet another path lookup based on a different
> >   kind of policy, and if a race happened in between, it could at least
> >   be possible that for one variant of the path, it would be OK for
> >   Landlock but not the other LSM, and for the other variant of the
> >   path it would be OK for the other LSM but not Landlock, and then the
> >   connection could get accepted even if that would not have been
> >   allowed on one of the two paths alone.)  I find this a somewhat
> >   brittle implementation approach.
> 
> Do you mean that the evaluation of the stacked LSMs could
> return 0 if one of them allows it even though other LSMs deny ?

Yes. If there are two LSMs employing that scheme, that would
happen.

## Example scenario 1 (two LSMs)

* LSM1 permits connections to sockets under /dir1 and denies others,
  based on the inode associated with dir1.
* LSM2 permits connections to sockets under /dir2 and denies others.
  based on the inode associated with dir2.
* The sockets /dir1/sock1 and /dir2/sock2 exist.

* initial unix_find_bsd() lookup for /dir1/sock1
* LSM1 lookup for /dir1/sock1 ==> returns 0 (accepted because /dir1 is OK in LSM1)
* Race:
  * /dir1 gets moved to /dir1.old,
  * /dir2 gets moved to /dir1 (keeping the original /dir2 inode),
  * /dir1.old/sock1 gets moved to /dir2/sock1.
* LSM2 lookup for /dir1/sock1 ==> returns 0
  (accepted because /dir1 is the old /dir2 on whose inode LSM2 accepts the permission)

The race is not detected because the inode of the resolved socket is
the same for all three lookups.

At all points during the file renaming logic, sock1 stayed under the
inode of the original /dir1 or the inode of the original /dir2.  The
connection is supposed to be denied because for both of these
directories, one of the two LSMs should deny connections to sockets
that are stored therein.


## Example scenario 2 (only one LSM)

I just realize that a similar scenario also already applies to the
simpler case where there is *only* the Landlock LSM and the af_unix.c
lookup.  Bear with me, this is a bit of a wild scenario, but it shows
that the scheme of comparing the looked-up inode does not work:

* The directories /dir1 and /dir2 exist.
  * On /dir1, the unprivileged user has Unix permissions but the LSM
    denies access to sockets underneath based on the directories'
    inode.
  * On /dir2, the unprivileged user has *no* Unix permissions, but the
    LSM accepts access to sockets underneath, based on the dir inode.
* The socket /dir1/sock is a hardlink to /dir2/sock
* Assume there is a highly privileged service that constantly invokes
  renameat2() with RENAME_EXCHANGE, exchaning the two directories back
  and forth.

Now the following operations happen:

* initial unix_find_bsd() lookup for /dir1/sock
  * We get lucky and catch the inode where we get through Unix
    permission checks
* Race:
  * /dir1 and /dir2 get exchanged atomically
* LSM lookup for /dir1/sock
  * Now /dir1 is the inode where the LSM passes the LSM check

So we end up passing both checks because a rename() happened in between.

At any given point in time, the directory through which we accessed
the socket was either /dir1 or /dir2, and we lacked either the Unix
permissions or the LSM policy should deny it. Yet, because of this
rename race, we manage to sneak through both checks.

The inode comparison for the looked up inode does not catch it,
because that is only the "sock" inode, and does not cover the other
inodes along the path.

The example is a bit artificial to make it clear, but it nevertheless
shows that in race scenarios, the behaviour can still be different
(and permit more access) than in the sceneario there is only a single
path lookup.


> > * Would have to double check the unix_dgram_connect code paths in
> >   af_unix to see whether this is feasible for DGRAM sockets:
> >
> >   There is a way to connect() a connectionless DGRAM socket, and in
> >   that case, the path lookup in af_unix happens normally only during
> >   connect(),
> 
> Note that connected DGRAM socket can send() data to other sockets
> by specifying the peer name in each send(), and even they can
> disconnect by connect(AF_UNSPEC).

Yup.  (That case would have been easier, I think, because the two
lookups would have been closer to each other.)


> > very far apart from the initial security_unix_may_send()
> >   LSM hook which is used for DGRAM sockets - It would be weird if we
> >   were able to connect() a DGRAM socket, thinking that now all path
> >   lookups are done, but then when you try to send a message through
> >   it, Landlock surprisingly does the path lookup again based on a very
> >   old and possibly outdated path.  If Landlock's path lookup fails
> >   (e.g. because the path has disappeared, or because the inode now
> >   differs), retries won't be able to recover this any more.  Normally,
> >   the path does not need to get resolved any more once the DGRAM
> >   socket is connected.
> >
> >   Noteworthy: When Unix servers restart, they commonly unlink the old
> >   socket inode in the same place and create a new one with bind().  So
> >   as the time window for the race increases, it is actually a common
> >   scenario that a different inode with appear under the same path.
> >
> > I have to digest this idea a bit.  I find it less intuitive than using
> > the exact same struct path with a newly introduced hook, but it does
> > admittedly mitigate the problem somewhat.  I'm just not feeling very
> > comfortable with security policy code that requires difficult
> > reasoning. 🤔 Or maybe I interpreted too much into your suggestion. :)
> > I'd be interested to hear what you think.
> >
> > —Günther

As the above second example showed, when we do two path lookups, one
in af_unix and one in Landlock, even if we compare the resulting
socket inode to catch the TOCTOU, there are scenarios where the
resulting observable behaviour is different (and sometimes more lax)
than if there was only a single path lookup.

Given that, I'd be leaning towards the original proposal of adding new
LSM hook, provided that Paul and the respective network maintainers
are OK with it.

Thanks for bringing it up though.  It was an interesting exploration
to think through these scenarios.

Thanks,
–Günther

