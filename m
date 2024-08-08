Return-Path: <netdev+bounces-116881-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B533994BF29
	for <lists+netdev@lfdr.de>; Thu,  8 Aug 2024 16:09:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D87FD1C259D9
	for <lists+netdev@lfdr.de>; Thu,  8 Aug 2024 14:09:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC67818E758;
	Thu,  8 Aug 2024 14:09:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="QqhTjXFW"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-42ac.mail.infomaniak.ch (smtp-42ac.mail.infomaniak.ch [84.16.66.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73FB718CBE0
	for <netdev@vger.kernel.org>; Thu,  8 Aug 2024 14:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.16.66.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723126179; cv=none; b=YOZvolYPq4BbsQNFrG7PGYWmuGQhZHo4RShV1vZsHRABd1wlLG+KySUYEQRvjFjlkQZi3BAXuh29ZS2Fx4Nxugvbl5Af+wXzWy0+7DjZ9YR3GnC9uUOCxLCK4JZVMXXu1cqqz06ZgDb5kAkNcsEUF9WK9l3RXRDBk32qHiMR5bg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723126179; c=relaxed/simple;
	bh=zbW+TnT2zxyMB+yxd0fACCt1cAOudRQVOD0lCGX/HEo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XYrpdQvO2+ezvg1fFdtN0b7/qeYchE/rfyKFA08QCmjUwPWQEEXo+RaghClOnnN9uNTwl3y+tgbgGbjv8C/j+W7x50Q2O7L5K+pTSDkor3ENmWfs/Hxt58fLIgG4YHAJcGeuX5kYMeTnQ7q1iS6QeDXN21xo5bZHI9ZPknxL4gw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=QqhTjXFW; arc=none smtp.client-ip=84.16.66.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Received: from smtp-4-0000.mail.infomaniak.ch (smtp-4-0000.mail.infomaniak.ch [10.7.10.107])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4Wfpng0q8YzRVT;
	Thu,  8 Aug 2024 16:09:27 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1723126167;
	bh=MbLKs2A5zMNmmzak6XvmEHCMnOoCd8Xu8lOUJ5M2KQY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QqhTjXFW5BJKsWENy5GGCaj2cL+YpbF2ZFQOTgDmHVVg+Y+IOItc7XD/Xuz8gC1HI
	 evfGSiybrDBagWMU9EKiHSHPNzU73aIMEjLAGVY0gWKCU1I6O6Ww8fZUxS4J9pZ5fI
	 3f0CYWuKs/sULKTbnDSDd4lFOqrOXVT1RApX4ego=
Received: from unknown by smtp-4-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4Wfpnd5BQYzrQF;
	Thu,  8 Aug 2024 16:09:25 +0200 (CEST)
Date: Thu, 8 Aug 2024 16:09:20 +0200
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: Jann Horn <jannh@google.com>
Cc: Tahera Fahimi <fahimitahera@gmail.com>, outreachy@lists.linux.dev, 
	gnoack@google.com, paul@paul-moore.com, jmorris@namei.org, serge@hallyn.com, 
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org, bjorn3_gh@protonmail.com, 
	netdev@vger.kernel.org
Subject: Re: [PATCH v2 1/4] Landlock: Add signal control
Message-ID: <20240808.kaiyaeZoo1ha@digikod.net>
References: <cover.1722966592.git.fahimitahera@gmail.com>
 <49557e48c1904d2966b8aa563215d2e1733dad95.1722966592.git.fahimitahera@gmail.com>
 <CAG48ez3o9fmqz5FkFh3YoJs_jMdtDq=Jjj-qMj7v=CxFROq+Ew@mail.gmail.com>
 <CAG48ez1jufy8iwP=+DDY662veqBdv9VbMxJ69Ohwt8Tns9afOw@mail.gmail.com>
 <20240807.Yee4al2lahCo@digikod.net>
 <ZrQE+d2b/FWxIPoA@tahera-OptiPlex-5000>
 <CAG48ez1q80onUxoDrFFvGmoWzOhjRaXzYpu+e8kNAHzPADvAAg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAG48ez1q80onUxoDrFFvGmoWzOhjRaXzYpu+e8kNAHzPADvAAg@mail.gmail.com>
X-Infomaniak-Routing: alpha

On Thu, Aug 08, 2024 at 03:10:54AM +0200, Jann Horn wrote:
> On Thu, Aug 8, 2024 at 1:36 AM Tahera Fahimi <fahimitahera@gmail.com> wrote:
> > On Wed, Aug 07, 2024 at 08:16:47PM +0200, Mickaël Salaün wrote:
> > > On Tue, Aug 06, 2024 at 11:55:27PM +0200, Jann Horn wrote:
> > > > On Tue, Aug 6, 2024 at 8:56 PM Jann Horn <jannh@google.com> wrote:
> > > > > On Tue, Aug 6, 2024 at 8:11 PM Tahera Fahimi <fahimitahera@gmail.com> wrote:
> > > > > > Currently, a sandbox process is not restricted to send a signal
> > > > > > (e.g. SIGKILL) to a process outside of the sandbox environment.
> > > > > > Ability to sending a signal for a sandboxed process should be
> > > > > > scoped the same way abstract unix sockets are scoped. Therefore,
> > > > > > we extend "scoped" field in a ruleset with
> > > > > > "LANDLOCK_SCOPED_SIGNAL" to specify that a ruleset will deny
> > > > > > sending any signal from within a sandbox process to its
> > > > > > parent(i.e. any parent sandbox or non-sandboxed procsses).
> > > > [...]
> > > > > > +       if (is_scoped)
> > > > > > +               return 0;
> > > > > > +
> > > > > > +       return -EPERM;
> > > > > > +}
> > > > > > +
> > > > > > +static int hook_file_send_sigiotask(struct task_struct *tsk,
> > > > > > +                                   struct fown_struct *fown, int signum)
> > >
> > > I was wondering if we should handle this case, but I guess it makes
> > > sense to have a consistent policy for all kind of user-triggerable
> > > signals.
> > >
> > > > > > +{
> > > > > > +       bool is_scoped;
> > > > > > +       const struct landlock_ruleset *dom, *target_dom;
> > > > > > +       struct task_struct *result = get_pid_task(fown->pid, fown->pid_type);
> > > > >
> > > > > I'm not an expert on how the fowner stuff works, but I think this will
> > > > > probably give you "result = NULL" if the file owner PID has already
> > > > > exited, and then the following landlock_get_task_domain() would
> > > > > probably crash? But I'm not entirely sure about how this works.
> > > > >
> > > > > I think the intended way to use this hook would be to instead use the
> > > > > "file_set_fowner" hook to record the owning domain (though the setup
> > > > > for that is going to be kind of a pain...), see the Smack and SELinux
> > > > > definitions of that hook. Or alternatively maybe it would be even
> > > > > nicer to change the fown_struct to record a cred* instead of a uid and
> > > > > euid and then use the domain from those credentials for this hook...
> > > > > I'm not sure which of those would be easier.
> > > >
> > > > (For what it's worth, I think the first option would probably be
> > > > easier to implement and ship for now, since you can basically copy
> > > > what Smack and SELinux are already doing in their implementations of
> > > > these hooks. I think the second option would theoretically result in
> > > > nicer code, but it might require a bit more work, and you'd have to
> > > > include the maintainers of the file locking code in the review of such
> > > > refactoring and have them approve those changes. So if you want to get
> > > > this patchset into the kernel quickly, the first option might be
> > > > better for now?)
> > > >
> > >
> > > I agree, let's extend landlock_file_security with a new "fown" pointer
> > > to a Landlock domain. We'll need to call landlock_get_ruleset() in
> > > hook_file_send_sigiotask(), and landlock_put_ruleset() in a new
> > > hook_file_free_security().
> > I think we should add a new hook (hook_file_set_owner()) to initialize
> > the "fown" pointer and call landlock_get_ruleset() in that?
> 
> Yeah. Initialize the pointer in the file_set_fowner hook, and read the
> pointer in the file_send_sigiotask hook.
> 
> Note that in the file_set_fowner hook, you'll probably need to use
> both landlock_get_ruleset() (to take a reference on the ruleset you're
> storing in the fown pointer) and landlock_put_ruleset() (to drop the
> reference to the ruleset that the fown pointer was pointing to
> before). And you'll need to use some kind of lock to protect the fown
> pointer - either by adding an appropriate lock next to your fown
> pointer or by using some appropriate existing lock in "struct file".
> Probably it's cleanest to have your own lock for this? (This lock will
> have to be something like a spinlock, not a mutex, since you need to
> be able to acquire it in the file_set_fowner hook, which runs inside
> an RCU read-side critical section, where sleeping is forbidden -
> acquiring a mutex can sleep and therefore is forbidden in this
> context, acquiring a spinlock can't sleep.)

Yes, I think this should work for file_set_fowner:

struct landlock_ruleset *prev_dom, *new_dom;

new_dom = landlock_get_current_domain();
landlock_get_ruleset(new_dom);

/* Cf. f_modown() */
write_lock_irq(&filp->f_owner.lock);
prev_dom = rcu_replace_pointer(&landlock_file(file)->fown_domain,
	new_dom, lockdep_is_held(&filp->f_owner.lock));
write_unlock_irq(&filp->f_owner.lock);

landlock_put_ruleset_rcu(prev_dom);


With landlock_put_ruleset_rcu() define with this:

diff --git a/security/landlock/ruleset.c b/security/landlock/ruleset.c
index a93bdbf52fff..897116205520 100644
--- a/security/landlock/ruleset.c
+++ b/security/landlock/ruleset.c
@@ -524,6 +524,20 @@ void landlock_put_ruleset_deferred(struct landlock_ruleset *const ruleset)
 	}
 }
 
+static void free_ruleset_rcu(struct rcu_head *const head)
+{
+	struct landlock_ruleset *ruleset;
+
+	ruleset = container_of(head, struct landlock_ruleset, rcu);
+	free_ruleset(ruleset);
+}
+
+void landlock_put_ruleset_rcu(struct landlock_ruleset *const ruleset)
+{
+	if (ruleset && refcount_dec_and_test(&ruleset->usage))
+		call_rcu(&ruleset->rcu, free_ruleset_rcu);
+}
+
 /**
  * landlock_merge_ruleset - Merge a ruleset with a domain
  *
diff --git a/security/landlock/ruleset.h b/security/landlock/ruleset.h
index c749fa0b3ecd..c930b39174b0 100644
--- a/security/landlock/ruleset.h
+++ b/security/landlock/ruleset.h
@@ -190,19 +190,35 @@ struct landlock_ruleset {
 		 * @work_free: Enables to free a ruleset within a lockless
 		 * section.  This is only used by
 		 * landlock_put_ruleset_deferred() when @usage reaches zero.
-		 * The fields @lock, @usage, @num_rules, @num_layers and
+		 * The fields @rcu, @lock, @usage, @num_rules, @num_layers and
 		 * @access_masks are then unused.
 		 */
 		struct work_struct work_free;
 		struct {
-			/**
-			 * @lock: Protects against concurrent modifications of
-			 * @root, if @usage is greater than zero.
-			 */
-			struct mutex lock;
+			union {
+				/**
+				 * @rcu: Protects RCU read-side critical
+				 * sections.  This is only used by
+				 * landlock_put_ruleset_rcu() when @usage
+				 * reaches zero.
+				 *
+				 * Only used for domains.
+				 */
+				struct rcu_head rcu;
+				/**
+				 * @lock: Protects against concurrent
+				 * modifications of @root_inode and
+				 * @root_net_port, if @usage is greater than
+				 * zero.
+				 *
+				 * Only used for rulesets.
+				 */
+				struct mutex lock;
+			};
 			/**
 			 * @usage: Number of processes (i.e. domains) or file
-			 * descriptors referencing this ruleset.
+			 * descriptors referencing this ruleset.  It can be
+			 * zero in RCU read-side critical sections.
 			 */
 			refcount_t usage;
 			/**
@@ -241,6 +257,7 @@ landlock_create_ruleset(const access_mask_t access_mask_fs,
 
 void landlock_put_ruleset(struct landlock_ruleset *const ruleset);
 void landlock_put_ruleset_deferred(struct landlock_ruleset *const ruleset);
+void landlock_put_ruleset_rcu(struct landlock_ruleset *const ruleset);
 
 int landlock_insert_rule(struct landlock_ruleset *const ruleset,
 			 const struct landlock_id id,

