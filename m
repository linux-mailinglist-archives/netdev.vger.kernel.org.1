Return-Path: <netdev+bounces-249177-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EA8AD15549
	for <lists+netdev@lfdr.de>; Mon, 12 Jan 2026 21:53:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 0351330049EA
	for <lists+netdev@lfdr.de>; Mon, 12 Jan 2026 20:53:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E61433986F;
	Mon, 12 Jan 2026 20:53:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZmqqOUJV"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D097033BBD2
	for <netdev@vger.kernel.org>; Mon, 12 Jan 2026 20:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768251196; cv=none; b=Nh8O0wcx8aoSZjdQ+E7/0Je08xbmJOsJeWji+sWWs8JTFlgxtlKRGA6xXVTq+m3xBgl4dsO63q1Ro646MIPdsn9vsu/fcm40A3V+X+gyGLVuRdkH0GSwdpRbGGgol+MWDuOP8xrAKRZJcCZndZsCHEBYwUItOdw93dTcn6brBWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768251196; c=relaxed/simple;
	bh=2f2JZeVGWCW6MseXjXSM2VcjS00tFAddsU9KnOxeaeg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=frBmUgbvFnF+0GUx6X+wp+CnP3eqqnL/Z7fYlSXI/2v9irmJfgjoJYhhqJz/UowGnev50WWATQdr34A8K5NdxIhJnPrzGFc8JL2kM6qXdeMY7+xycDPtrdZ95DTi4NrgvphxoBfxlXRYkT+bpKm1jX+KSwcBlmm2IXTY+bhgqIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZmqqOUJV; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-b86f212c3b0so351818766b.0
        for <netdev@vger.kernel.org>; Mon, 12 Jan 2026 12:53:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768251193; x=1768855993; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=6OT3Y3o4F52r4hCTWjlx3c+S7vYLsCoyZBNF3ULoc70=;
        b=ZmqqOUJV3X4LwHQxNm8JyRT7XheHOLOiUMapGQm5tXtgKc6nTwL/WpYMIbItzhDfU5
         /PYgYwSCSS4HqX9AvO4rPpGUQG7i4mfjhLxF76XAQVjRFArkHy71TfKalx92+vmjizd+
         A14VTTVd/ZlpZQ7/VQHOlxWAY5JKT4d0t5vqXOJsD2FOqvfsUsP7s4/n8mKQjTliAP2j
         7tzNE9ORpaRh4bJksOFKWO1Jx/GOmqBYd4DCLEwJ7rod+la7BFVGABLTZ7+7p4EX1n+/
         KW+LnP/Uy5M1Ovz5Ytb7jcPSslxAlC1yNiS84dInO2hgiBSzhZYCO9G6ATEYq/FIaaZZ
         kA3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768251193; x=1768855993;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6OT3Y3o4F52r4hCTWjlx3c+S7vYLsCoyZBNF3ULoc70=;
        b=wTln61pnJpJ/L5tGTJLi2GvveNdqY5ehkrtoFcuYEZ5zQ4CyWhDV2xJZnJdl5WtmPT
         v6jEbNoPVHPkpHmP5thbMoBNganISV9O/01M4utTHlfPvsFuZhDfaYmvv4TMjFcCiXAv
         BDkREHq27pb6J6ZFSqzTl6Nw3c+ZcWiLa2sBkhVzRksjxnT4nYNLKmC86cDSKx9kCG+u
         eRM2Fck9fDjrdq33eUKfBeDdgfMGaB7iPv3pE3vrUKI8xQZtBnleeze3YLzFL7K7/jnX
         0pilGkXPbiqlumPcKN5YpdBSNx7Ltz673BRMODTOeIKSyz7NNpo0xeAGl4+NTZ1jkpFY
         Bz8Q==
X-Forwarded-Encrypted: i=1; AJvYcCWkk42wL2CgdtXasNFKpZ95So8j7D6i/05SoeLYtHleIcrZRzB5nc1MPwmWCvWJrDNK3v8l/NM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyqk6hJRlTAf3D6oKsrQ8w/+Ytl3oIS+E2InlkXv5uwNPGFFk+w
	/lFK7jVivpd8lQE3bHq5cT3JkcbK+Ii5dyGLcbH9VNCEPPSsjVINEjFT
X-Gm-Gg: AY/fxX5R7Ik4Uk6ncYwwYX+0pl5zSFaCxk6GfwmZ2HPGAIBsascq18SbBsTTacoTXC2
	htszk+JZQKkiAgt7gGCYvLXIz+DoVo+W/2GC2LBW/QUfsQx7MBHFuFoH6cQqc71dsW8J40H03F1
	LemzVVCHV/gxXTmNCFJ398bH97dlgGkTNaVFaCtyj5RVDaHY2X5y+Yim0pe3RnXecJi7KMO+lua
	drVGF9jZ4aPU7EYS/Xcg7PVCYmnisd9LqBafQEmwWHNUbseZ895Dr4FVrP/CbzevpmG0ff75rRM
	UevG4ntE7Op8GfzvuvCAIE0cZqGXLpyzU6KmGJjKll11+cmfu2r5FhwfFSET+POboqyQo6q0Kdl
	3PcwI7/E0MsBcbFs9y37bK6VfK20Wo6j//tbN4++fUDQtPkaxTnYDTRHprO1JQEuciYKeLa31jh
	UqFSTF3Lb/2AcJiutKjbQzcTOI5JQccjTnQvL+
X-Received: by 2002:a17:907:9404:b0:b87:17f6:6f12 with SMTP id a640c23a62f3a-b87355c8cf1mr65261766b.1.1768251193006;
        Mon, 12 Jan 2026 12:53:13 -0800 (PST)
Received: from localhost (ip87-106-108-193.pbiaas.com. [87.106.108.193])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b842a4d1c6csm1959967466b.39.2026.01.12.12.53.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jan 2026 12:53:12 -0800 (PST)
Date: Mon, 12 Jan 2026 21:53:08 +0100
From: =?iso-8859-1?Q?G=FCnther?= Noack <gnoack3000@gmail.com>
To: =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>,
	Justin Suess <utilityemal77@gmail.com>
Cc: Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
	"Serge E . Hallyn" <serge@hallyn.com>,
	linux-security-module@vger.kernel.org, Tingmao Wang <m@maowtm.org>,
	Samasth Norway Ananda <samasth.norway.ananda@oracle.com>,
	Matthieu Buffet <matthieu@buffet.re>,
	Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>,
	konstantin.meskhidze@huawei.com,
	Demi Marie Obenour <demiobenour@gmail.com>,
	Alyssa Ross <hi@alyssa.is>, Jann Horn <jannh@google.com>,
	Tahera Fahimi <fahimitahera@gmail.com>,
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>
Subject: Re: [PATCH v2 0/5] landlock: Pathname-based UNIX connect() control
Message-ID: <20260112.a7f8e16a6573@gnoack.org>
References: <20260110143300.71048-2-gnoack3000@gmail.com>
 <20260112.Wufar9coosoo@digikod.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260112.Wufar9coosoo@digikod.net>

Thanks for the review!

On Mon, Jan 12, 2026 at 05:08:02PM +0100, Mickaël Salaün wrote:
> On Sat, Jan 10, 2026 at 03:32:55PM +0100, Günther Noack wrote:
> > ## Alternatives and Related Work
> > 
> 
> > ### Alternative: Use existing LSM hooks
> > 
> > The existing hooks security_unix_stream_connect(),
> > security_unix_may_send() and security_socket_connect() do not give
> > access to the resolved file system path.
> > 
> > Resolving the file system path again within Landlock would in my
> > understanding produce a TOCTOU race, so making the decision based on
> > the struct sockaddr_un contents is not an option.
> > 
> > It is tempting to use the struct path that the listening socket is
> > bound to, which can be acquired through the existing hooks.
> > Unfortunately, the listening socket may have been bound from within a
> > different namespace, and it is therefore a path that can not actually
> > be referenced by the sandboxed program at the time of constructing the
> > Landlock policy.  (More details are on the Github issue at [6] and on
> > the LKML at [9]).
> 
> Please move (or duplicate) this rationale in the patch dedicated to the
> new hook.  It helps patch review (and to understand commits when already
> merged).

Justin, would you like to look into this?
Please feel free to copy the wording.


> > ### Related work: Scope Control for Pathname Unix Sockets
> > 
> > The motivation for this patch is the same as in Tingmao Wang's patch
> > set for "scoped" control for pathname Unix sockets [2], originally
> > proposed in the Github feature request [5].
> > 
> > In my reply to this patch set [3], I have discussed the differences
> > between these two approaches.  On the related discussions on Github
> > [4] and [5], there was consensus that the scope-based control is
> > complimentary to the file system based control, but does not replace
> > it.  Mickael's opening remark on [5] says:
> > 
> > > This scoping would be complementary to #36 which would mainly be
> > > about allowing a sandboxed process to connect to a more privileged
> > > service (identified with a path).
> > 
> > ## Open questions in V2
> > 
> > Seeking feedback on:
> > 
> > - Feedback on the LSM hook name would be appreciated. We realize that
> >   not all invocations of the LSM hook are related to connect(2) as the
> >   name suggests, but some also happen during sendmsg(2).
> 
> Renaming security_unix_path_connect() to security_unix_find() would look
> appropriate to me wrt the caller.

Justin, this is also on your commit.  (I find security_unix_find() and
security_unix_resolve() equally acceptable options.)


> > - Feedback on the structuring of the Landlock access rights, splitting
> >   them up by socket type.  (Also naming; they are now consistently
> >   called "RESOLVE", but could be named "CONNECT" in the stream and
> >   seqpacket cases?)
> 
> I don't see use cases where differenciating the type of unix socket
> would be useful.  LANDLOCK_ACCESS_FS_RESOLVE_UNIX would look good to me.

I did it mostly because it seemed consistent with the TCP and (soon)
UDP controls, which are also controls specific to the socket type and
not just the address family.  But I agree that the granularity is
likely not needed here.  I can change it back for v3 and rename it to
LANDLOCK_ACCESS_FS_RESOLVE_UNIX.


> What would be the inverse of "resolve" (i.e. to restrict the server
> side)?  Would LANDLOCK_ACCESS_FS_MAKE_SOCK be enough?

Yes, that would be enough. My reasoning is as follows:

The server-side operation that is related to associating the service
with a given file system name is bind(2), and that is restrictable in
that case using LANDLOCK_ACCESS_FS_MAKE_SOCK.

Also, to my delight (and other than in TCP), listening on an unbound
socket does not work (see unix_listen() in af_unix.c):

  if (!READ_ONCE(u->addr))
  	goto out;	/* No listens on an unbound socket */

(You can get it to "autobind" during an explicit bind() or a connect()
call, but that creates an abstract UNIX address. (Documented in
socket(7) and implemented in unix_autobind() in af_unix.c))


–Günther

