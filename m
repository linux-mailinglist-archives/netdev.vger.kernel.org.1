Return-Path: <netdev+bounces-102501-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 96D7A9035AD
	for <lists+netdev@lfdr.de>; Tue, 11 Jun 2024 10:20:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AAF0B1C24608
	for <lists+netdev@lfdr.de>; Tue, 11 Jun 2024 08:20:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CAFA172BCE;
	Tue, 11 Jun 2024 08:19:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="p7gWMbH9"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-42aa.mail.infomaniak.ch (smtp-42aa.mail.infomaniak.ch [84.16.66.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91B711420B8
	for <netdev@vger.kernel.org>; Tue, 11 Jun 2024 08:19:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.16.66.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718093972; cv=none; b=F8rWBum4/m8oPMoSY/6Vkq2dvc1ow/labkhXI8d1PvH8p6Q3MRtrFGBrBw6GkehasnJdPEXKkfxiaOHuXTxipOvqV1PKxvJHJFB5ZWnl7w8lPllfaQiAtqkH0eHtFc0Upa7tPX8lZnawTonY+nEP00vibyDpl1Vqw7ulp7R2fVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718093972; c=relaxed/simple;
	bh=ybykIiW5VS3w+BkZyxy+Xnk5v4bDo8zglruVsuDtuxI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A83IcxVugec5FWQ5qaIHhQVKMg5Pd90G/hl5uE0QaXc9ZcOcYikCEU9iSZQbVRmSvDbGMy7GcUIVYl0t0lOKL06sIpxohVupEMezAlau97RwGWIwzcgJ4UhF17pulZtESy/WLX6FFaFbwM3bxT/rBkzwwhk6uOuXkII2lMNLX24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=p7gWMbH9; arc=none smtp.client-ip=84.16.66.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Received: from smtp-4-0001.mail.infomaniak.ch (smtp-4-0001.mail.infomaniak.ch [10.7.10.108])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4Vz1mY3v3Kzmd9;
	Tue, 11 Jun 2024 10:19:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1718093965;
	bh=NW3ocj6F1Nb72KUy4vifp/1WY92XTuWX9CWEPsfwJug=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=p7gWMbH9DGOuQoUYjnndqIVt2uAA3gUGDUyubDLx1JaPzfKf5SYKVV51GfcWqciLM
	 hINyTroRtAcw//sLWZq18//REbzYac0e+KsNpLeubtjEWLLTBgcMIfCoGpB/qvGC/C
	 oTkqrskWLQVC5V4PYi/DiCCsCQdk3VyQ/u6HJt60=
Received: from unknown by smtp-4-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4Vz1mX56RQz9FN;
	Tue, 11 Jun 2024 10:19:24 +0200 (CEST)
Date: Tue, 11 Jun 2024 10:19:20 +0200
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: Jann Horn <jannh@google.com>
Cc: Tahera Fahimi <fahimitahera@gmail.com>, 
	=?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>, linux-security-module@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Paul Moore <paul@paul-moore.com>, 
	James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, outreachy@lists.linux.dev, 
	netdev@vger.kernel.org, =?utf-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>
Subject: Re: [PATCH v3] landlock: Add abstract unix socket connect restriction
Message-ID: <20240611.Pi8Iph7ootae@digikod.net>
References: <ZmJJ7lZdQuQop7e5@tahera-OptiPlex-5000>
 <CAG48ez3NvVnonOqKH4oRwRqbSOLO0p9djBqgvxVwn6gtGQBPcw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAG48ez3NvVnonOqKH4oRwRqbSOLO0p9djBqgvxVwn6gtGQBPcw@mail.gmail.com>
X-Infomaniak-Routing: alpha

On Tue, Jun 11, 2024 at 12:27:58AM +0200, Jann Horn wrote:
> Hi!
> 
> Thanks for helping with making Landlock more comprehensive!
> 
> On Fri, Jun 7, 2024 at 1:44 AM Tahera Fahimi <fahimitahera@gmail.com> wrote:
> > Abstract unix sockets are used for local inter-process communications
> > without on a filesystem. Currently a sandboxed process can connect to a
> > socket outside of the sandboxed environment, since landlock has no
> > restriction for connecting to a unix socket in the abstract namespace.
> > Access to such sockets for a sandboxed process should be scoped the same
> > way ptrace is limited.
> 
> This reminds me - from what I remember, Landlock also doesn't restrict
> access to filesystem-based unix sockets yet... I'm I'm right about
> that, we should probably at some point add code at some point to
> restrict that as part of the path-based filesystem access rules? (But
> to be clear, I'm not saying I expect you to do that as part of your
> patch, just commenting for context.)

Yes, I totally agree.  For now, unix socket binding requires to create
the LANDLOCK_ACCESS_FS_MAKE_SOCK right, but connecting to an existing
socket is not controlled.  The abstract unix socket scoping is
orthogonal and extends Landlock with unix socket LSM hooks, which are
required to extend the "filesystem" access rights to control path-based
unix socket.

> 
> > Because of compatibility reasons and since landlock should be flexible,
> > we extend the user space interface by adding a new "scoped" field. This
> > field optionally contains a "LANDLOCK_SCOPED_ABSTRACT_UNIX_SOCKET" to
> > specify that the ruleset will deny any connection from within the
> > sandbox to its parents(i.e. any parent sandbox or non-sandbox processes)
> 
> You call the feature "LANDLOCK_SCOPED_ABSTRACT_UNIX_SOCKET", but I
> don't see anything in this code that actually restricts it to abstract
> unix sockets (as opposed to path-based ones and unnamed ones, see the
> "Three types of address are distinguished" paragraph of
> https://man7.org/linux/man-pages/man7/unix.7.html). If the feature is
> supposed to be limited to abstract unix sockets, I guess you'd maybe
> have to inspect the unix_sk(other)->addr, check that it's non-NULL,
> and then check that `unix_sk(other)->addr->name->sun_path[0] == 0`,
> similar to what unix_seq_show() does? (unix_seq_show() shows abstract
> sockets with an "@".)

Right, that should be part of the next series.  Tests should check that
too.

> 
> Separately, I wonder if it would be useful to have another mode for
> forbidding access to abstract unix sockets entirely; or alternatively
> to change the semantics of LANDLOCK_SCOPED_ABSTRACT_UNIX_SOCKET so
> that it also forbids access from outside the landlocked domain as was
> discussed elsewhere in the thread. If a landlocked process starts
> listening on something like "@/tmp/.X11-unix/X0", maybe X11 clients
> elsewhere on my system shouldn't be confused into connecting to that
> landlocked socket...

In this case, I think we should have a (light) Landlock domain for a
user session to make sure apps only connect to the legitimate X11 socket
(either in the same domain, or through a path-based socket).

There is also ongoing work to restrict socket creation according to their
type:
https://lore.kernel.org/all/20240524093015.2402952-1-ivanov.mikhail1@huawei-partners.com/
This will make possible to control abstract unix socket creation and
avoid this kind of issue too.

> 
> [...]
> > +static bool sock_is_scoped(struct sock *const other)
> > +{
> > +       bool is_scoped = true;
> > +       const struct landlock_ruleset *dom_other;
> > +       const struct cred *cred_other;
> > +
> > +       const struct landlock_ruleset *const dom =
> > +               landlock_get_current_domain();
> > +       if (!dom)
> > +               return true;
> > +
> > +       lockdep_assert_held(&unix_sk(other)->lock);
> > +       /* the credentials will not change */
> > +       cred_other = get_cred(other->sk_peer_cred);
> > +       dom_other = landlock_cred(cred_other)->domain;
> > +       is_scoped = domain_scope_le(dom, dom_other);
> > +       put_cred(cred_other);
> 
> You don't have to use get_cred()/put_cred() here; as the comment says,
> the credentials will not change, so we don't need to take another
> reference to them.
> 
> > +       return is_scoped;
> > +}
> 

