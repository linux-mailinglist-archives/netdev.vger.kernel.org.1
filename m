Return-Path: <netdev+bounces-102330-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C03AB902741
	for <lists+netdev@lfdr.de>; Mon, 10 Jun 2024 18:55:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9D4291C21A42
	for <lists+netdev@lfdr.de>; Mon, 10 Jun 2024 16:55:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F149F7C6C1;
	Mon, 10 Jun 2024 16:45:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="VDlBHnfe"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-bc09.mail.infomaniak.ch (smtp-bc09.mail.infomaniak.ch [45.157.188.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED7D61EEFC
	for <netdev@vger.kernel.org>; Mon, 10 Jun 2024 16:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.157.188.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718037948; cv=none; b=XfMnLo1gg/QKPAKK7n9HZgy03LcRdBxYIs3/5znkALukXiEc17W5RlLHEs3lYsOLMhPnTyvL7qK00Dj7/nwUy7zeTT+PvV8FJzAr8pLzm2JLNAnk/HyybWyMvKOiUk2ZjH60Bha3RJJg6D9d64xQHz9hlo2oes9rhOgeCnnv4D0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718037948; c=relaxed/simple;
	bh=xAxkkHMbE6EFj7Vn4VrY8iVDYj3woWE7f3bw7uwgP5U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AY4prVGYGJaXHaJi3Z0TyygEK3g0DoEPXHkVYiDAZuH/ov4JcWV2uI9PWRNS5B8/uPS4OvoYQV3nDjjuYEIynZukyLEf1vx4qrgwrP8GKmteg0nVsnLXCO7es8fB3NsDCQ9QtdmaK/j4rAUbFdW/Fb8/xwPtIcUTa0rviQeHgjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=VDlBHnfe; arc=none smtp.client-ip=45.157.188.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Received: from smtp-3-0000.mail.infomaniak.ch (smtp-3-0000.mail.infomaniak.ch [10.4.36.107])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4VycrF3N4tzQpH;
	Mon, 10 Jun 2024 18:36:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1718037373;
	bh=3JgBwHpKRWvfgFVnmu0Q8DgoOgyaOkMHD9BGniMMe6Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VDlBHnfe/vrBazYgmFfZcfC209tpPzUBRDYlBkUD4J7gUfiS/02knHJ9h9jY/poBI
	 p8GGzmrvJSrtwUT6RvEr0+nyzxK4GkkAtAy7MjepuqC1PKVpdkLbEa8fe1I02/2caJ
	 3R8jVLbqIMuXlud1xBjcfuny8j1549CM7cs7ILb4=
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4VycrD2ppyzT7Q;
	Mon, 10 Jun 2024 18:36:12 +0200 (CEST)
Date: Mon, 10 Jun 2024 18:36:08 +0200
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: Tahera Fahimi <fahimitahera@gmail.com>
Cc: =?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>, 
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, 
	"Serge E. Hallyn" <serge@hallyn.com>, linux-security-module@vger.kernel.org, 
	linux-kernel@vger.kernel.org, =?utf-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>, 
	Jann Horn <jannh@google.com>, outreachy@lists.linux.dev, netdev@vger.kernel.org
Subject: Re: [PATCH v3] landlock: Add abstract unix socket connect restriction
Message-ID: <20240610.Aifee5ingugh@digikod.net>
References: <ZmJJ7lZdQuQop7e5@tahera-OptiPlex-5000>
 <ZmLEoBfHyUR3nKAV@google.com>
 <ZmNic8S1KtyLcp7i@tahera-OptiPlex-5000>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZmNic8S1KtyLcp7i@tahera-OptiPlex-5000>
X-Infomaniak-Routing: alpha

On Fri, Jun 07, 2024 at 01:41:39PM -0600, Tahera Fahimi wrote:
> On Fri, Jun 07, 2024 at 10:28:35AM +0200, Günther Noack wrote:
> > Hello Tahera!
> > 
> > Thanks for sending another revision of your patch set!
> Hello Günther, 
> Thanks for your feedback.
> 
> > On Thu, Jun 06, 2024 at 05:44:46PM -0600, Tahera Fahimi wrote:
> > > Abstract unix sockets are used for local inter-process communications
> > > without on a filesystem. Currently a sandboxed process can connect to a
> > > socket outside of the sandboxed environment, since landlock has no
> > > restriction for connecting to a unix socket in the abstract namespace.
> > > Access to such sockets for a sandboxed process should be scoped the same
> > > way ptrace is limited.
> > > 
> > > Because of compatibility reasons and since landlock should be flexible,
> > > we extend the user space interface by adding a new "scoped" field. This
> > > field optionally contains a "LANDLOCK_SCOPED_ABSTRACT_UNIX_SOCKET" to
> > > specify that the ruleset will deny any connection from within the
> > > sandbox to its parents(i.e. any parent sandbox or non-sandbox processes)
> > > 
> > > Closes: https://github.com/landlock-lsm/linux/issues/7
> > > Signed-off-by: Tahera Fahimi <fahimitahera@gmail.com>
> > > 
> > > -------
> > > V3: Added "scoped" field to landlock_ruleset_attr
> > > V2: Remove wrapper functions
> > > 
> > > -------
> > > ---
> > >  include/uapi/linux/landlock.h | 28 +++++++++++++++++++++++
> > >  security/landlock/limits.h    |  5 ++++
> > >  security/landlock/ruleset.c   | 15 ++++++++----
> > >  security/landlock/ruleset.h   | 28 +++++++++++++++++++++--
> > >  security/landlock/syscalls.c  | 12 +++++++---
> > >  security/landlock/task.c      | 43 +++++++++++++++++++++++++++++++++++
> > >  6 files changed, 121 insertions(+), 10 deletions(-)
> > > 
> > > diff --git a/include/uapi/linux/landlock.h b/include/uapi/linux/landlock.h
> > > index 68625e728f43..d887e67dc0ed 100644
> > > --- a/include/uapi/linux/landlock.h
> > > +++ b/include/uapi/linux/landlock.h
> > > @@ -37,6 +37,12 @@ struct landlock_ruleset_attr {
> > >  	 * rule explicitly allow them.
> > >  	 */
> > >  	__u64 handled_access_net;
> > > +	/**
> > > +	 * scoped: Bitmask of actions (cf. `Scope access flags`_)
> > > +	 * that is handled by this ruleset and should be permitted
> > > +	 * by default if no rule explicitly deny them.
> > > +	 */
> > > +	__u64 scoped;
> > 
> > I have trouble understanding what this docstring means.
> > 
> > If those are "handled" things, shouldn't the name also start with "handled_", in
> > line with the other fields?  Also, I don't see any way to manipulate these
> > rights with a Landlock rule in this ?
> 
> .scoped attribute is not defined as .handled_scope since there is no
> rule to handle/manipulate it, simply because this attribute shows either
> action is permitted or denied. 

Correct.  Günther, what do you think about the naming?

> 
> > How about:
> > 
> > /**
> >  * handled_scoped: Bitmask of IPC actions (cf. `Scoped access flags`_)
> >  * which are confined to only affect the current Landlock domain.
> >  */
> 
> This is a good docstring. I will use it. 
> 
> > __u64 handled_scoped;
> > 
> > >  };
> > >  
> > >  /*
> > > @@ -266,4 +272,26 @@ struct landlock_net_port_attr {
> > >  #define LANDLOCK_ACCESS_NET_BIND_TCP			(1ULL << 0)
> > >  #define LANDLOCK_ACCESS_NET_CONNECT_TCP			(1ULL << 1)
> > >  /* clang-format on */
> > > +
> > > +/**
> > > + * DOC: scoped
> > > + *
> > > + * Scoped handles a set of restrictions on kernel IPCs.
> > > + *
> > > + * Scope access flags
> > 
> > Scoped with a "d"?
> Scoped meant to point to .scoped attribute.  

Right, but a "d" was missing.

> > > + * ~~~~~~~~~~~~~~~~~~~~
> > > + * 
> > > + * These flags enable to restrict a sandboxed process from a set of
> > > + * inter-process communications actions. Setting a flag in a landlock
> > > + * domain will isolate the Landlock domain to forbid connections
> > > + * to resources outside the domain.
> > > + *
> > > + * IPCs with scoped actions:
> > > + * - %LANDLOCK_SCOPED_ABSTRACT_UNIX_SOCKET: Restrict a sandbox process to
> > > + *   connect to a process outside of the sandbox domain through abstract
> > > + *   unix sockets.
> > > + */
> > > +/* clang-format off */
> > > +#define LANDLOCK_SCOPED_ABSTRACT_UNIX_SOCKET		(1ULL << 0)
> > 
> > Should the name of this #define indicate the direction that we are restricting?
> 
> Since the domain of a process specifies if a process can connect or not,
> the direction of the connection does not matter. This restriction is the
> same as ptrace.
> 
> > If I understand your documentation correctly, this is about *connecting out* of
> > the current Landlock domain, but incoming connections from more privileged
> > domains are OK, right?
> 
> Yes, Incoming connections are allowed if they are from a higher
> privileged domain (or no domain). Consider two process P1 and P2 where
> P1 wants to connect to P2. If P1 is not landlocked, it can connect to P2
> regardless of whether P2 has a domain. If P1 is landlocked, it must have
> an equal or less domain than P2 to connect to P2. We disscussed about
> direction in [2]
> https://lore.kernel.org/outreachy/20240603.Quaes2eich5f@digikod.net/T/#m6d5c5e65e43eaa1c8c38309f1225d169be3d6f87

Correct, this is what Günther highlighted: restriction on direction.

About the name "LANDLOCK_SCOPED_ABSTRACT_UNIX_SOCKET", I think it should
be OK if the "scoped" docstring section clearly explains this direction.

> 
> > 
> > Also:
> > 
> > Is it intentional that you are both restricting the connection and the sending
> > with the same flag (security_unix_may_send)?  If an existing Unix Domain Socket
> > gets passed in to a program from the outside (e.g. as stdout), shouldn't it
> > still be possible that the program enables a Landlock policy and then still
> > writes to it?  (Does that work?  Am I mis-reading the patch?)

If a passed socket is already connected, then a write/send should work.

> 
> security_unix_may_send checks if AF_UNIX socket can send datagrams, so
> connecting and sending datagrams happens at the same state. I am not
> sure if I understand your example correctly. Can you please explain a
> bit more?

The concern is about using the current's or the socket's credential.

> 
> > The way that write access is normally checked for other files is at the time
> > when you open the file, not during write(), and I believe it would be more in
> > line with that normal "check at open" behaviour if we did the same here?
> 
> It checks the ability to connect to a unix socket at the point of
> connecting, so I think it is aligned with the "check at point"
> behaviour. This security check is called right before finalizing the
> connection. 

From my point of view, the main difference between a file's FD and a
socket's FD is that a file's FD allows actions on only the referenced
file, whereas the socket's FD may not only reference a connection
because it can be disconnected (see net_test.c:protocol.connect_unspec)
and reconnected.  Well, as we can see in the test, this doesn't work
with AF_UNIX but I'm wondering if there is no other way to do it.
Anyway, this seems closer to the use of a directory's FD to open another
file: the access check is done when accessing a "new" resource.  To say
it another way, a socket may be seen as a builder object to exchange
data with a peer, and this object can be reconfigured/recycled to
exchange data with another peer.  This rationale also applies to TCP
connect and bind control.

> 
> > 
> > > diff --git a/security/landlock/limits.h b/security/landlock/limits.h
> > > index 20fdb5ff3514..7b794b81ef05 100644
> > > --- a/security/landlock/limits.h
> > > +++ b/security/landlock/limits.h
> > > @@ -28,6 +28,11 @@
> > >  #define LANDLOCK_NUM_ACCESS_NET		__const_hweight64(LANDLOCK_MASK_ACCESS_NET)
> > >  #define LANDLOCK_SHIFT_ACCESS_NET	LANDLOCK_NUM_ACCESS_FS
> > >  
> > > +#define LANDLOCK_LAST_ACCESS_SCOPE       LANDLOCK_SCOPED_ABSTRACT_UNIX_SOCKET
> > > +#define LANDLOCK_MASK_ACCESS_SCOPE	((LANDLOCK_LAST_ACCESS_SCOPE << 1) - 1)
> > > +#define LANDLOCK_NUM_ACCESS_SCOPE         __const_hweight64(LANDLOCK_MASK_ACCESS_SCOPE)
> > > +#define LANDLOCK_SHIFT_ACCESS_SCOPE      LANDLOCK_SHIFT_ACCESS_NET
> >                                             ^^^^^^^^^^^^^^^^^^^^^^^^^
> > 
> > I believe this #define has the wrong value, and as a consequence, the code
> > suffers from the same problem as we already had on the other patch set from
> > Mikhail Ivanov -- see [1] for that discussion.
> 
> Thanks for the hint. I will definitly check this. 
> 
> > The LANDLOCK_SHIFT_ACCESS_FOO variable is used for determining the position of
> > your flag in the access_masks_t type, where all access masks are combined
> > together in one big bit vector.  If you are defining this the same for _SCOPE as
> > for _NET, I believe that we will start using the same bits in that vector for
> > both the _NET flags and the _SCOPE flags, and that will manifest in unwanted
> > interactions between the different types of restrictions.  (e.g. you will create
> > a policy to restrict _SCOPE, and you will find yourself unable to do some things
> > with TCP ports)
> > 
> > Please also see the other thread for more discussions about how we can avoid
> > such problems in the future.  (This code is easy to get wrong,
> > apparently... When we don't test what happens across multiple types of
> > restrictions, everything looks fine.)
> > 
> > [1] https://lore.kernel.org/all/ebd680cc-25d6-ee14-4856-310f5e5e28e4@huawei-partners.com/

Yep, good catch.

A test should be able to catch this issue.

> > 
> > —Günther
> > 
> 

