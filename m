Return-Path: <netdev+bounces-247719-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A922CFDC1D
	for <lists+netdev@lfdr.de>; Wed, 07 Jan 2026 13:49:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5BBE7300EDC8
	for <lists+netdev@lfdr.de>; Wed,  7 Jan 2026 12:49:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C916131A7FB;
	Wed,  7 Jan 2026 12:49:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vix06SFW"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E016E319855
	for <netdev@vger.kernel.org>; Wed,  7 Jan 2026 12:49:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767790166; cv=none; b=F/T5YH0IIyy64wqufvpWr1Zr/+0OXm4AnLOdCYdOwxfNoRuaiL8f3zBjrik1m8WiWW63k0S3H7+TCj7v2pUn7oOis6jXsUe6TWKZCGBC9m0X6rBhleIEMS3TaMb7vBo9GpfPQ+DTosn+BjS9T4nMFe4/9SMZxPLjPLLCvNdlJzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767790166; c=relaxed/simple;
	bh=a3vmgsAXukmgqSwV0AoGTAjXqd16li7cffqw4Dv9cmo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oZ9oXo88JPN0cYkrmLx5pwopuH2Mb08KbVYmVjwY4f0/fBMgEato1hD2p6l/uVLDqUpKqUOttOwVl3KrOcgghaemENppCNs9fHjOr6IIs2EuQDh0IPObtPFGLMzkwgXAIIGspLYpxjCx0OC8chLTVRE3zA6TBRPKvW7KAdv23fw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vix06SFW; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-47d3ffb0f44so13465935e9.3
        for <netdev@vger.kernel.org>; Wed, 07 Jan 2026 04:49:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1767790163; x=1768394963; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=A7esm0lhpjk8pfTNy3FuLXs4ysbYggutAEfC0J9iA/0=;
        b=vix06SFWGuRzfBZV8Q21lRTRkg55bKFwvcWGaDSTx6bPT/woys3jA/gQ3fhpY1xuBE
         k7JSMqmZTUqiVqWuQB9TmM0Nea+T/bmm2KDSkJASipQ2GthwmNw2lXTBj/ApnFYOyQs+
         kGi0gADLwyxGuu+Xuxyieb3X8hEFVBmbQB0bfn3K29PTW1WQ2OjFUn94+0g+Imu1h+eU
         5Mtaexei5Z7fiISlwAieI2AQFZU2H0GXJWryl+hrzvAUhEVg8bPc6PiNhjXe8MDDoEau
         /YDtAHG3NH8uN3OYtrAqlhu7dxse24SVBLY4it5B/tRzMDy77DLHvCLnyJ6TLF861gCM
         PPrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767790163; x=1768394963;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=A7esm0lhpjk8pfTNy3FuLXs4ysbYggutAEfC0J9iA/0=;
        b=MbhvMg8zbS2AUILekfIPG/zDDvDFxvIENCeW4te1SzR+9OaQ8bfUB3lWx+ZGT8acLd
         6WqCS1sJpHf1a1BXKmUIN/IbI/+S1Krhi8Xvue+S1cxWbL2JfFde8u7Rtj05V0RA3vbH
         qxsND8ObEtVXJQMj56mWwUeX3D3sFLJvll4XD9/KICgn1rgTCkBXE/81dCDEYyEL7XUT
         68XscE5b+rjGFQHLHvkgjQ9IXtrggykKYmk1x27dv1fIRmkAi2Lq+YoDqxJk6qHbRI5T
         StY1KeoXBq03IDlcBmyzjpQQCfuTP5ygtJV+5Rvg9TFCeLsvi8vbk2xEQL1tXI+ulWF2
         MVhQ==
X-Forwarded-Encrypted: i=1; AJvYcCVwZwnYgQYo/xEMzJFDoULSxYciVZpRWDnWafDyHJ2e7QYO3GnJxc50HljwS+EeD0Kz+rawLEM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy553ZaHwv/tXG2j3OydA4YO9iilARKXr/DF4hS6WDIaR9PPUeZ
	e7fiUwoPZylGsmILjMFFsFqeQfWpA+MvxjZVHDam+jeG0Zp1L4gqS2KgpGoNa8l/BA==
X-Gm-Gg: AY/fxX4MSCJ4reuOW61Wo8S0uzOYYLzoZZW+UxAbrxOPpIxgxFQjSkPaKjjeEZlr9aP
	pE82Ox0tRVB7kYbZK9Hh3eGiYTFuEPM56Ry3y3EJtxKoesTXnz9AeD3XfmWC/iA2QiEMG4swkzd
	yVRBGGw/8U3VI6RN9IrzKSTwoWx6vP6BFS3ubhkDJi6WfGVLaRoHqNAyvJpUxMljWFfNHvk0sFy
	I2EJRetem+u6LG7oHbSA1KqoiGe+EfISlY6lgoSVxnGNHnVnhbe07p4UB/yuscJmqIpsP+COUQd
	4JCulrUmcE1nWIk7RmllLnzeb6iCDARJ7iBxr4j83qCZC2RlqEXsHNPp/mdiuhGszdhVVdiCr/q
	kO8X8xs7fuSZSgldF6BE4BNZOAzy3MBN918+X4Q40x/80kT2scrnXGWEAlIS29aEaoxa1XvGmpS
	e15TN/UAPl8o/weNzTIfBDKey/Yls0E+GkL0tjOXK0dA==
X-Google-Smtp-Source: AGHT+IHZt1ItuHFPKlBIvrWTZFKkBkOeTUrNJBb9Zur08PBq/LX2HyuJRNfbhcxbHAzuTncL4RuRtg==
X-Received: by 2002:a05:600c:190e:b0:477:9aeb:6a8f with SMTP id 5b1f17b1804b1-47d84b1faffmr29548675e9.9.1767790162877;
        Wed, 07 Jan 2026 04:49:22 -0800 (PST)
Received: from google.com ([2a00:79e0:288a:8:aaba:e2c1:29df:3e24])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-432bd5feaf8sm10088254f8f.39.2026.01.07.04.49.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jan 2026 04:49:22 -0800 (PST)
Date: Wed, 7 Jan 2026 13:49:16 +0100
From: =?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: Justin Suess <utilityemal77@gmail.com>,
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
	"Serge E . Hallyn" <serge@hallyn.com>,
	Simon Horman <horms@kernel.org>,
	=?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>,
	linux-security-module@vger.kernel.org, Tingmao Wang <m@maowtm.org>,
	netdev@vger.kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>
Subject: Re: [RFC PATCH 0/1] lsm: Add hook unix_path_connect
Message-ID: <aV5WTGvQB0XI8Q_N@google.com>
References: <20251231213314.2979118-1-utilityemal77@gmail.com>
 <CAAVpQUCF3uES6j22P1TYzgKByw+E4EqpM=+OFyqtRGStGWxH+Q@mail.gmail.com>
 <aVuaqij9nXhLfAvN@google.com>
 <CAAVpQUB6gnfovRZAg_BfVKPuS868dFj7HxthbxRL-nZvcsOzCg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAAVpQUB6gnfovRZAg_BfVKPuS868dFj7HxthbxRL-nZvcsOzCg@mail.gmail.com>

On Tue, Jan 06, 2026 at 11:33:32PM -0800, Kuniyuki Iwashima wrote:
> +VFS maintainers
> 
> On Mon, Jan 5, 2026 at 3:04 AM Günther Noack <gnoack@google.com> wrote:
> >
> > Hello!
> >
> > On Sun, Jan 04, 2026 at 11:46:46PM -0800, Kuniyuki Iwashima wrote:
> > > On Wed, Dec 31, 2025 at 1:33 PM Justin Suess <utilityemal77@gmail.com> wrote:
> > > > Motivation
> > > > ---
> > > >
> > > > For AF_UNIX sockets bound to a filesystem path (aka named sockets), one
> > > > identifying object from a policy perspective is the path passed to
> > > > connect(2). However, this operation currently restricts LSMs that rely
> > > > on VFS-based mediation, because the pathname resolved during connect()
> > > > is not preserved in a form visible to existing hooks before connection
> > > > establishment.
> > >
> > > Why can't LSM use unix_sk(other)->path in security_unix_stream_connect()
> > > and security_unix_may_send() ?
> >
> > Thanks for bringing it up!
> >
> > That path is set by the process that acts as the listening side for
> > the socket.  The listening and the connecting process might not live
> > in the same mount namespace, and in that case, it would not match the
> > path which is passed by the client in the struct sockaddr_un.
> 
> Thanks for the explanation !
> 
> So basically what you need is resolving unix_sk(sk)->addr.name
> by kern_path() and comparing its d_backing_inode(path.dentry)
> with d_backing_inode (unix_sk(sk)->path.dendtry).
> 
> If the new hook is only used by Landlock, I'd prefer doing that on
> the existing connect() hooks.

I've talked about that in the "Alternative: Use existing LSM hooks" section in
https://lore.kernel.org/all/20260101134102.25938-1-gnoack3000@gmail.com/

If we resolve unix_sk(sk)->addr.name ourselves in the Landlock hook
again, we would resolve the path twice: Once in unix_find_bsd() in
net/unix/af_unix.c (the Time-Of-Use), and once in the Landlock
security hook for the connect() operation (the Time-Of-Check).

If I understand you correctly, you are suggesting that we check that
the inode resolved by af_unix
(d_backing_inode(unix_sk(sk)->path.dentry)) is the same as the one
that we resolve in Landlock ourselves, and therefore we can detect the
TOCTOU race and pretend that this is equivalent to the case where
af_unix resolved to the same inode with the path that Landlock
observed?

If the walked file system hierarchy changes in between these two
accesses, Landlock enforces the policy based on path elements that
have changed in between.

* We start with a Landlock policy where Unix connect() is restricted
  by default, but is permitted on "foo/bar2" and everything underneath
  it.  The hierarchy is:

  foo/
      bar/
          baz.sock
      bar2/        <--- Landlock rule: socket connect() allowed here and below

* We connect() to the path "foo/bar/baz.sock"
* af_unix.c path lookup resolves "foo/bar/baz.sock" (TOU)
  This works because Landlock is not checked at this point yet.
* In between the two lookups:
  * the directory foo/bar gets renamed to foo/bar.old
  * foo/bar2 gets moved to foo/bar
  * baz.sock gets moved into the (new) foo/bar directory
* Landlock check: path lookup of "foo/bar/baz.sock" (TOC)
  and subsequent policy check using the resolved path.

  This succeeds because connect() is permitted on foo/bar2 and
  beneath.  We also check that the resolved inode is the same as the
  one resolved by af_unix.c.

And now the reasoning is basically that this is fine because the
(inode) result of the two lookups was the same and we pretend that the
Landlock path lookup was the one where the actual permission check was
done?

Some pieces of this which I am still unsure about:

* What we are supposed to do when the two resolved inodes are not the
  same, because we detected the race?  We can not allow the connection
  in that case, but it would be wrong to deny it as well.  I'm not
  sure whether returning one of the -ERESTART* variants is feasible in
  this place and bubbles up correctly to the system call / io_uring
  layer.

* What if other kinds of permission checks happen on a different
  lookup code path?  (If another stacked LSM had a similar
  implementation with yet another path lookup based on a different
  kind of policy, and if a race happened in between, it could at least
  be possible that for one variant of the path, it would be OK for
  Landlock but not the other LSM, and for the other variant of the
  path it would be OK for the other LSM but not Landlock, and then the
  connection could get accepted even if that would not have been
  allowed on one of the two paths alone.)  I find this a somewhat
  brittle implementation approach.

* Would have to double check the unix_dgram_connect code paths in
  af_unix to see whether this is feasible for DGRAM sockets:

  There is a way to connect() a connectionless DGRAM socket, and in
  that case, the path lookup in af_unix happens normally only during
  connect(), very far apart from the initial security_unix_may_send()
  LSM hook which is used for DGRAM sockets - It would be weird if we
  were able to connect() a DGRAM socket, thinking that now all path
  lookups are done, but then when you try to send a message through
  it, Landlock surprisingly does the path lookup again based on a very
  old and possibly outdated path.  If Landlock's path lookup fails
  (e.g. because the path has disappeared, or because the inode now
  differs), retries won't be able to recover this any more.  Normally,
  the path does not need to get resolved any more once the DGRAM
  socket is connected.

  Noteworthy: When Unix servers restart, they commonly unlink the old
  socket inode in the same place and create a new one with bind().  So
  as the time window for the race increases, it is actually a common
  scenario that a different inode with appear under the same path.

I have to digest this idea a bit.  I find it less intuitive than using
the exact same struct path with a newly introduced hook, but it does
admittedly mitigate the problem somewhat.  I'm just not feeling very
comfortable with security policy code that requires difficult
reasoning. 🤔 Or maybe I interpreted too much into your suggestion. :)
I'd be interested to hear what you think.

—Günther

