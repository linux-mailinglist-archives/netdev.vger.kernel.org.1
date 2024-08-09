Return-Path: <netdev+bounces-117206-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EC8894D168
	for <lists+netdev@lfdr.de>; Fri,  9 Aug 2024 15:37:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1C4EE1F21F7A
	for <lists+netdev@lfdr.de>; Fri,  9 Aug 2024 13:37:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F13B194C83;
	Fri,  9 Aug 2024 13:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="OpYdACcN"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-190f.mail.infomaniak.ch (smtp-190f.mail.infomaniak.ch [185.125.25.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AA06194C75
	for <netdev@vger.kernel.org>; Fri,  9 Aug 2024 13:37:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.25.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723210652; cv=none; b=mvlMDoIchASb+WUsbt+XRD9R8rE6Flvv7PwN7ZuRRs9g7hyGwr6LfgOnR/JP5nZ88lq5IASaLGwWk4qvQlbgt9qddAhW3STwYYlHGMrwlNrNESjLCcHLI0l3fAVFtMiv3uUGdg6lKF6Zq+rnfvJGfL3AwSbT1FION0pPsjBEOAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723210652; c=relaxed/simple;
	bh=CV2KsuTzZFM3tb3jpFAEOVmdFeFl9DGCIr23w73TUBc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XJoDCs6pcY0eAswiYZcXiuHraHejalIe54CIFhXKzB1vaDuu2QacgDfZindYS3Tadpe0PbAgPlaYMHuVB7xWYG3Y9ipjhbc5CRsElPUr6OoVrqo5ICM8R8/bDTd298xM1EjQojPtZTqSCkxXPPSpvT/X+1yo6YNCwqnklnK4MDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=OpYdACcN; arc=none smtp.client-ip=185.125.25.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Received: from smtp-3-0000.mail.infomaniak.ch (smtp-3-0000.mail.infomaniak.ch [10.4.36.107])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4WgQ2G15hFzsbq;
	Fri,  9 Aug 2024 15:37:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1723210646;
	bh=8yuEdFJ5d9KshgHjOdDGSrL9W7g0PXB4OxTMQzj+pOw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OpYdACcNA4gLC3N3pH0KoWMirAjjPj2EBVJfEGi4dfMGog77vLpqZuSTrW72bVb3M
	 +EQ3x26RAlAsnbvc1YpYxMtM/93AA3EBwXiEFROh8BxkZ5/30nqycipm6+yqoJkswN
	 Bts5A/dMbwc93yssOu8etR1rmfOSZV1LvaBfXbOU=
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4WgQ2F4g09z7Hk;
	Fri,  9 Aug 2024 15:37:25 +0200 (CEST)
Date: Fri, 9 Aug 2024 15:37:20 +0200
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: Jann Horn <jannh@google.com>
Cc: Tahera Fahimi <fahimitahera@gmail.com>, outreachy@lists.linux.dev, 
	gnoack@google.com, paul@paul-moore.com, jmorris@namei.org, serge@hallyn.com, 
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org, bjorn3_gh@protonmail.com, 
	netdev@vger.kernel.org
Subject: Re: [PATCH v2 1/4] Landlock: Add signal control
Message-ID: <20240809.fee1eiPohphu@digikod.net>
References: <49557e48c1904d2966b8aa563215d2e1733dad95.1722966592.git.fahimitahera@gmail.com>
 <CAG48ez3o9fmqz5FkFh3YoJs_jMdtDq=Jjj-qMj7v=CxFROq+Ew@mail.gmail.com>
 <CAG48ez1jufy8iwP=+DDY662veqBdv9VbMxJ69Ohwt8Tns9afOw@mail.gmail.com>
 <20240807.Yee4al2lahCo@digikod.net>
 <ZrQE+d2b/FWxIPoA@tahera-OptiPlex-5000>
 <CAG48ez1q80onUxoDrFFvGmoWzOhjRaXzYpu+e8kNAHzPADvAAg@mail.gmail.com>
 <20240808.kaiyaeZoo1ha@digikod.net>
 <CAG48ez34C2pv7qugcYHeZgp5P=hOLyk4p5RRgKwhU5OA4Dcnuw@mail.gmail.com>
 <20240809.eejeekoo4Quo@digikod.net>
 <CAG48ez2Cd3sjzv5rKT1YcMi1AzBxwN8r-jTbWy0Lv89iik-Y4Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAG48ez2Cd3sjzv5rKT1YcMi1AzBxwN8r-jTbWy0Lv89iik-Y4Q@mail.gmail.com>
X-Infomaniak-Routing: alpha

On Fri, Aug 09, 2024 at 02:44:06PM +0200, Jann Horn wrote:
> On Fri, Aug 9, 2024 at 12:59 PM Mickaël Salaün <mic@digikod.net> wrote:
> > On Thu, Aug 08, 2024 at 04:42:23PM +0200, Jann Horn wrote:
> > > On Thu, Aug 8, 2024 at 4:09 PM Mickaël Salaün <mic@digikod.net> wrote:
> > > > On Thu, Aug 08, 2024 at 03:10:54AM +0200, Jann Horn wrote:
> > > > > On Thu, Aug 8, 2024 at 1:36 AM Tahera Fahimi <fahimitahera@gmail.com> wrote:
> > > > > > On Wed, Aug 07, 2024 at 08:16:47PM +0200, Mickaël Salaün wrote:
> > > > > > > On Tue, Aug 06, 2024 at 11:55:27PM +0200, Jann Horn wrote:
> > > > > > > > On Tue, Aug 6, 2024 at 8:56 PM Jann Horn <jannh@google.com> wrote:
> > > > > > > > > On Tue, Aug 6, 2024 at 8:11 PM Tahera Fahimi <fahimitahera@gmail.com> wrote:
> > > > > > > > > > Currently, a sandbox process is not restricted to send a signal
> > > > > > > > > > (e.g. SIGKILL) to a process outside of the sandbox environment.
> > > > > > > > > > Ability to sending a signal for a sandboxed process should be
> > > > > > > > > > scoped the same way abstract unix sockets are scoped. Therefore,
> > > > > > > > > > we extend "scoped" field in a ruleset with
> > > > > > > > > > "LANDLOCK_SCOPED_SIGNAL" to specify that a ruleset will deny
> > > > > > > > > > sending any signal from within a sandbox process to its
> > > > > > > > > > parent(i.e. any parent sandbox or non-sandboxed procsses).
> > > > > > > > [...]
> > > > > > > > > > +       if (is_scoped)
> > > > > > > > > > +               return 0;
> > > > > > > > > > +
> > > > > > > > > > +       return -EPERM;
> > > > > > > > > > +}
> > > > > > > > > > +
> > > > > > > > > > +static int hook_file_send_sigiotask(struct task_struct *tsk,
> > > > > > > > > > +                                   struct fown_struct *fown, int signum)
> > > > > > >
> > > > > > > I was wondering if we should handle this case, but I guess it makes
> > > > > > > sense to have a consistent policy for all kind of user-triggerable
> > > > > > > signals.
> > > > > > >
> > > > > > > > > > +{
> > > > > > > > > > +       bool is_scoped;
> > > > > > > > > > +       const struct landlock_ruleset *dom, *target_dom;
> > > > > > > > > > +       struct task_struct *result = get_pid_task(fown->pid, fown->pid_type);
> > > > > > > > >
> > > > > > > > > I'm not an expert on how the fowner stuff works, but I think this will
> > > > > > > > > probably give you "result = NULL" if the file owner PID has already
> > > > > > > > > exited, and then the following landlock_get_task_domain() would
> > > > > > > > > probably crash? But I'm not entirely sure about how this works.
> > > > > > > > >
> > > > > > > > > I think the intended way to use this hook would be to instead use the
> > > > > > > > > "file_set_fowner" hook to record the owning domain (though the setup
> > > > > > > > > for that is going to be kind of a pain...), see the Smack and SELinux
> > > > > > > > > definitions of that hook. Or alternatively maybe it would be even
> > > > > > > > > nicer to change the fown_struct to record a cred* instead of a uid and
> > > > > > > > > euid and then use the domain from those credentials for this hook...
> > > > > > > > > I'm not sure which of those would be easier.
> > > > > > > >
> > > > > > > > (For what it's worth, I think the first option would probably be
> > > > > > > > easier to implement and ship for now, since you can basically copy
> > > > > > > > what Smack and SELinux are already doing in their implementations of
> > > > > > > > these hooks. I think the second option would theoretically result in
> > > > > > > > nicer code, but it might require a bit more work, and you'd have to
> > > > > > > > include the maintainers of the file locking code in the review of such
> > > > > > > > refactoring and have them approve those changes. So if you want to get
> > > > > > > > this patchset into the kernel quickly, the first option might be
> > > > > > > > better for now?)
> > > > > > > >
> > > > > > >
> > > > > > > I agree, let's extend landlock_file_security with a new "fown" pointer
> > > > > > > to a Landlock domain. We'll need to call landlock_get_ruleset() in
> > > > > > > hook_file_send_sigiotask(), and landlock_put_ruleset() in a new
> > > > > > > hook_file_free_security().
> > > > > > I think we should add a new hook (hook_file_set_owner()) to initialize
> > > > > > the "fown" pointer and call landlock_get_ruleset() in that?
> > > > >
> > > > > Yeah. Initialize the pointer in the file_set_fowner hook, and read the
> > > > > pointer in the file_send_sigiotask hook.
> > > > >
> > > > > Note that in the file_set_fowner hook, you'll probably need to use
> > > > > both landlock_get_ruleset() (to take a reference on the ruleset you're
> > > > > storing in the fown pointer) and landlock_put_ruleset() (to drop the
> > > > > reference to the ruleset that the fown pointer was pointing to
> > > > > before). And you'll need to use some kind of lock to protect the fown
> > > > > pointer - either by adding an appropriate lock next to your fown
> > > > > pointer or by using some appropriate existing lock in "struct file".
> > > > > Probably it's cleanest to have your own lock for this? (This lock will
> > > > > have to be something like a spinlock, not a mutex, since you need to
> > > > > be able to acquire it in the file_set_fowner hook, which runs inside
> > > > > an RCU read-side critical section, where sleeping is forbidden -
> > > > > acquiring a mutex can sleep and therefore is forbidden in this
> > > > > context, acquiring a spinlock can't sleep.)
> > > >
> > > > Yes, I think this should work for file_set_fowner:
> > > >
> > > > struct landlock_ruleset *prev_dom, *new_dom;
> > > >
> > > > new_dom = landlock_get_current_domain();
> > > > landlock_get_ruleset(new_dom);
> > > >
> > > > /* Cf. f_modown() */
> > > > write_lock_irq(&filp->f_owner.lock);
> > > > prev_dom = rcu_replace_pointer(&landlock_file(file)->fown_domain,
> > > >         new_dom, lockdep_is_held(&filp->f_owner.lock));
> > > > write_unlock_irq(&filp->f_owner.lock);
> > > >
> > > > landlock_put_ruleset_rcu(prev_dom);
> > > >
> > > >
> > > > With landlock_put_ruleset_rcu() define with this:
> > > >
> > > > diff --git a/security/landlock/ruleset.c b/security/landlock/ruleset.c
> > > > index a93bdbf52fff..897116205520 100644
> > > > --- a/security/landlock/ruleset.c
> > > > +++ b/security/landlock/ruleset.c
> > > > @@ -524,6 +524,20 @@ void landlock_put_ruleset_deferred(struct landlock_ruleset *const ruleset)
> > > >         }
> > > >  }
> > > >
> > > > +static void free_ruleset_rcu(struct rcu_head *const head)
> > > > +{
> > > > +       struct landlock_ruleset *ruleset;
> > > > +
> > > > +       ruleset = container_of(head, struct landlock_ruleset, rcu);
> > > > +       free_ruleset(ruleset);
> > > > +}
> > >
> > > free_ruleset() can block but RCU callbacks aren't allowed to block,
> > > that's why landlock_put_ruleset_deferred() exists.
> >
> > Yes, but landlock_put_ruleset_deferred() doesn't wait for RCU read-side
> > critical sections.
> 
> Ah, I phrased that badly - I didn't mean to suggest that you should
> use landlock_put_ruleset_deferred() as a replacement for call_rcu().
> 
> [...]
> > > So if you want to use RCU lifetime for this, I think you'll have to
> > > turn landlock_put_ruleset() and landlock_put_ruleset_deferred() into
> > > one common function that always, when reaching refcount 0, schedules
> > > an RCU callback which then schedules a work_struct which then does
> > > free_ruleset().
> > >
> > > I think that would be a little ugly, and it would look nicer to just
> > > use normal locking in the file_send_sigiotask hook?
> >
> > I don't see how we can do that without delaying the free_ruleset() call
> > to after the RCU read-side critical section in f_setown().
> 
> It should work if you used landlock_put_ruleset_deferred() instead of
> landlock_put_ruleset().

Calling landlock_put_ruleset_deferred() in hook_file_set_fowner() or
replacing all landlock_put_ruleset() calls?

The deferred work queue is not guarantee to run after all concurrent RCU
read-side critical sections right?  Calling synchronize_rcu() in
free_ruleset_work() should give this guarantee, but it's not nice.  We
could add a boolean in landlock_ruleset to only call synchronize_rcu()
when required (i.e. called from file_set_fowner).

> 
> > What about calling refcount_dec_and_test() in free_ruleset_rcu()?  That
> > would almost always queue this call but it looks safe.
> 
> Every queued RCU invocation needs to have its own rcu_head - I think
> the approach you're suggesting could end up queuing the same rcu_head
> multiple times?

Right

> 
> > An alternative might be to call synchronize_rcu() in free_ruleset(), but
> > it's a big ugly too.

