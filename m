Return-Path: <netdev+bounces-128139-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 32D45978354
	for <lists+netdev@lfdr.de>; Fri, 13 Sep 2024 17:07:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 85028B24C94
	for <lists+netdev@lfdr.de>; Fri, 13 Sep 2024 15:07:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E331A3A1BF;
	Fri, 13 Sep 2024 15:07:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="QldiuMcR"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-190d.mail.infomaniak.ch (smtp-190d.mail.infomaniak.ch [185.125.25.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31EFF3D0AD
	for <netdev@vger.kernel.org>; Fri, 13 Sep 2024 15:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.25.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726240047; cv=none; b=QYFTA8VdiGIKDKclXc6Q6XqdWgFDaw9/5K8Zw9ErMYhRIMYqF83e+khH4LGxzaKf0pXiCkuFAEpK4PDrWVyACAulo9QgGUlocG8J2PBJlFbxlu2iz33c7JxakWR36UIS2xlicxFWiRdGusUlMmLnkFq+vsVWuu3aXYCKmJmMCD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726240047; c=relaxed/simple;
	bh=agAGQaQKR7jPdfLVXlx5YU1jit9N0eVgGXj1g6kX3+M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X8k3907TybJKTxf2wlsI85yj73tlBz3IvhTRwYOLlGs8CkydgGpsa6HDwjSxTog7+l1bd0u2k2s6oHHbzDghge76V4CYleS6stdhRAY8S26lAzSWZGSj5IeWGTrHr1thpgv7dS8vuwOBYCwOhi4liXgqng5ljsjcUS3yqrANXAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=QldiuMcR; arc=none smtp.client-ip=185.125.25.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Received: from smtp-3-0000.mail.infomaniak.ch (smtp-3-0000.mail.infomaniak.ch [10.4.36.107])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4X4yMk5McMzcN1;
	Fri, 13 Sep 2024 17:07:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1726240034;
	bh=/BtaBBtka7t3ajVss1QhVMZIogsSOt5+FKZJzJgMvpw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QldiuMcRDfE6QIHxZmZhri+JpoJvAai36ZfUiXb75iEKYe3J3HiBl514lGhtTm27t
	 JbzYzcyEDltJpFpF3xo3YiLL4zQ20+Ou9TLTxOZG+XypB2dRDSJeEO2MyPZYhuGkre
	 weiLJfmluJRGm6oqDOJ82ffQCCNdG/qXPMguaDuE=
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4X4yMj3WqKz1dQ;
	Fri, 13 Sep 2024 17:07:13 +0200 (CEST)
Date: Fri, 13 Sep 2024 17:07:06 +0200
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: Tahera Fahimi <fahimitahera@gmail.com>
Cc: outreachy@lists.linux.dev, gnoack@google.com, paul@paul-moore.com, 
	jmorris@namei.org, serge@hallyn.com, linux-security-module@vger.kernel.org, 
	linux-kernel@vger.kernel.org, bjorn3_gh@protonmail.com, jannh@google.com, 
	netdev@vger.kernel.org
Subject: Re: [PATCH v4 1/6] landlock: Add signal scoping control
Message-ID: <20240913.aipoh9chooBo@digikod.net>
References: <cover.1725657727.git.fahimitahera@gmail.com>
 <df2b4f880a2ed3042992689a793ea0951f6798a5.1725657727.git.fahimitahera@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <df2b4f880a2ed3042992689a793ea0951f6798a5.1725657727.git.fahimitahera@gmail.com>
X-Infomaniak-Routing: alpha

On Fri, Sep 06, 2024 at 03:30:03PM -0600, Tahera Fahimi wrote:
> Currently, a sandbox process is not restricted to sending a signal (e.g.
> SIGKILL) to a process outside the sandbox environment. The ability to
> send a signal for a sandboxed process should be scoped the same way
> abstract UNIX sockets are scoped. Therefore, we extend the "scoped"
> field in a ruleset with "LANDLOCK_SCOPED_SIGNAL" to specify that a
> ruleset will deny sending any signal from within a sandbox process to
> its parent(i.e. any parent sandbox or non-sandboxed procsses).
> 
> This patch adds two new hooks, "hook_file_set_fowner" and
> "hook_file_free_security", to set and release a pointer to the file
> owner's domain. This pointer, "fown_domain" in "landlock_file_security"
> will be used in "file_send_sigiotask" to check if the process can send a
> signal. Also, it updates the function "ruleset_with_unknown_scope", to
> support the scope mask of signal "LANDLOCK_SCOPED_SIGNAL".
> 
> Signed-off-by: Tahera Fahimi <fahimitahera@gmail.com>
> ---
> Changes in versions:
> V4:
> * Merging file_send_sigiotask and task_kill patches into one.
> * Commit improvement.
> * Applying feedback of V3 on managing fown_domain pointer.
> V3:
> * Moving file_send_sigiotask to another patch.
> * Minor code refactoring.
> V2:
> * Remove signal_is_scoped function
> * Applying reviews of V1
> V1:
> * Introducing LANDLOCK_SCOPE_SIGNAL
> * Adding two hooks, hook_task_kill and hook_file_send_sigiotask for
>   signal scoping.
> ---
>  include/uapi/linux/landlock.h                 |  3 +
>  security/landlock/fs.c                        | 17 ++++++
>  security/landlock/fs.h                        |  6 ++
>  security/landlock/limits.h                    |  2 +-
>  security/landlock/task.c                      | 59 +++++++++++++++++++
>  .../testing/selftests/landlock/scoped_test.c  |  2 +-
>  6 files changed, 87 insertions(+), 2 deletions(-)
> 
> diff --git a/include/uapi/linux/landlock.h b/include/uapi/linux/landlock.h
> index dfd48d722834..197da0c5c264 100644
> --- a/include/uapi/linux/landlock.h
> +++ b/include/uapi/linux/landlock.h
> @@ -297,9 +297,12 @@ struct landlock_net_port_attr {
>   *   from connecting to an abstract unix socket created by a process
>   *   outside the related Landlock domain (e.g. a parent domain or a
>   *   non-sandboxed process).
> + * - %LANDLOCK_SCOPED_SIGNAL: Restrict a sandboxed process from sending
> + *   a signal to another process outside sandbox domain.
>   */
>  /* clang-format off */
>  #define LANDLOCK_SCOPED_ABSTRACT_UNIX_SOCKET		(1ULL << 0)
> +#define LANDLOCK_SCOPED_SIGNAL		                (1ULL << 1)
>  /* clang-format on*/
>  
>  #endif /* _UAPI_LINUX_LANDLOCK_H */
> diff --git a/security/landlock/fs.c b/security/landlock/fs.c
> index 7877a64cc6b8..b1207f0a8cd4 100644
> --- a/security/landlock/fs.c
> +++ b/security/landlock/fs.c
> @@ -1636,6 +1636,20 @@ static int hook_file_ioctl_compat(struct file *file, unsigned int cmd,
>  	return -EACCES;
>  }
>  
> +static void hook_file_set_fowner(struct file *file)
> +{
> +	write_lock_irq(&file->f_owner.lock);

This lock is already held.

> +	landlock_put_ruleset_deferred(landlock_file(file)->fown_domain);
> +	landlock_file(file)->fown_domain = landlock_get_current_domain();
> +	landlock_get_ruleset(landlock_file(file)->fown_domain);
> +	write_unlock_irq(&file->f_owner.lock);

Here is my new proposal:

struct landlock_ruleset *new_dom, *prev_dom;

/*
 * Lock already held by __f_setown(), see commit 26f204380a3c ("fs: Fix
 * file_set_fowner LSM hook inconsistencies").
 */
lockdep_assert_held(&file_f_owner(file)->lock);
new_dom = landlock_get_current_domain();
landlock_get_ruleset(new_dom);
prev_dom = landlock_file(file)->fown_domain;
landlock_file(file)->fown_domain = new_dom;

/* Called in an RCU read-side critical section. */
landlock_put_ruleset_deferred(prev_dom);


> +}
> +
> +static void hook_file_free_security(struct file *file)
> +{
> +	landlock_put_ruleset_deferred(landlock_file(file)->fown_domain);
> +}
> +
>  static struct security_hook_list landlock_hooks[] __ro_after_init = {
>  	LSM_HOOK_INIT(inode_free_security, hook_inode_free_security),
>  
> @@ -1660,6 +1674,9 @@ static struct security_hook_list landlock_hooks[] __ro_after_init = {
>  	LSM_HOOK_INIT(file_truncate, hook_file_truncate),
>  	LSM_HOOK_INIT(file_ioctl, hook_file_ioctl),
>  	LSM_HOOK_INIT(file_ioctl_compat, hook_file_ioctl_compat),
> +
> +	LSM_HOOK_INIT(file_set_fowner, hook_file_set_fowner),
> +	LSM_HOOK_INIT(file_free_security, hook_file_free_security),
>  };
>  
>  __init void landlock_add_fs_hooks(void)
> diff --git a/security/landlock/fs.h b/security/landlock/fs.h
> index 488e4813680a..9a97f9285b90 100644
> --- a/security/landlock/fs.h
> +++ b/security/landlock/fs.h
> @@ -52,6 +52,12 @@ struct landlock_file_security {
>  	 * needed to authorize later operations on the open file.
>  	 */
>  	access_mask_t allowed_access;
> +	/**
> +	 * @fown_domain: A pointer to a &landlock_ruleset of the process owns
> +	 * the file. This ruleset is protected by fowner_struct.lock same as
> +	 * pid, uid, euid fields in fown_struct.
> +	 */

Some rewording:

/**
 * @fown_domain: Domain of the task that set the PID that may receive a
 * signal e.g., SIGURG when writing MSG_OOB to the related socket.
 * This pointer is protected by the related file->f_owner->lock, as for
 * fown_struct's members: pid, uid, and euid.
 */


> +	struct landlock_ruleset *fown_domain;
>  };
>  
>  /**
> diff --git a/security/landlock/limits.h b/security/landlock/limits.h
> index eb01d0fb2165..fa28f9236407 100644
> --- a/security/landlock/limits.h
> +++ b/security/landlock/limits.h
> @@ -26,7 +26,7 @@
>  #define LANDLOCK_MASK_ACCESS_NET	((LANDLOCK_LAST_ACCESS_NET << 1) - 1)
>  #define LANDLOCK_NUM_ACCESS_NET		__const_hweight64(LANDLOCK_MASK_ACCESS_NET)
>  
> -#define LANDLOCK_LAST_SCOPE		LANDLOCK_SCOPED_ABSTRACT_UNIX_SOCKET
> +#define LANDLOCK_LAST_SCOPE		LANDLOCK_SCOPED_SIGNAL
>  #define LANDLOCK_MASK_SCOPE		((LANDLOCK_LAST_SCOPE << 1) - 1)
>  #define LANDLOCK_NUM_SCOPE		__const_hweight64(LANDLOCK_MASK_SCOPE)
>  /* clang-format on */
> diff --git a/security/landlock/task.c b/security/landlock/task.c
> index b9390445d242..a72a61e7e6c3 100644
> --- a/security/landlock/task.c
> +++ b/security/landlock/task.c
> @@ -18,6 +18,7 @@
>  
>  #include "common.h"
>  #include "cred.h"
> +#include "fs.h"
>  #include "ruleset.h"
>  #include "setup.h"
>  #include "task.h"
> @@ -242,11 +243,69 @@ static int hook_unix_may_send(struct socket *const sock,
>  	return 0;
>  }
>  
> +static int hook_task_kill(struct task_struct *const p,
> +			  struct kernel_siginfo *const info, const int sig,
> +			  const struct cred *const cred)
> +{
> +	bool is_scoped;
> +	const struct landlock_ruleset *target_dom, *dom;
> +

> +	dom = landlock_get_current_domain();
> +	rcu_read_lock();
> +	target_dom = landlock_get_task_domain(p);
> +	if (cred)
> +		/* dealing with USB IO */
> +		is_scoped = domain_is_scoped(landlock_cred(cred)->domain,
> +					     target_dom,
> +					     LANDLOCK_SCOPED_SIGNAL);
> +	else
> +		is_scoped = (!dom) ? false :
> +				     domain_is_scoped(dom, target_dom,
> +						      LANDLOCK_SCOPED_SIGNAL);

Some refactoring to simplify code:

if (cred) {
	/* Dealing with USB IO. */
	dom = landlock_cred(cred)->domain;
} else {
	dom = landlock_get_current_domain();
}

/* Quick return for non-landlocked tasks. */
if (!dom)
	return 0;

rcu_read_lock();
is_scoped = domain_is_scoped(dom, landlock_get_task_domain(p),
			     LANDLOCK_SCOPE_SIGNAL);


> +	rcu_read_unlock();
> +	if (is_scoped)
> +		return -EPERM;
> +
> +	return 0;
> +}
> +
> +static int hook_file_send_sigiotask(struct task_struct *tsk,
> +				    struct fown_struct *fown, int signum)
> +{
> +	struct file *file;
> +	bool is_scoped;
> +	struct landlock_ruleset *dom;
> +
> +	/* struct fown_struct is never outside the context of a struct file */
> +	file = container_of(fown, struct file, f_owner);
> +

I rebased on these two commits that are planned for the next merge
window:
- commit 1934b212615d ("file: reclaim 24 bytes from f_owner"): replace
  container_of(fown, struct file, f_owner) with fown->file .
- commit 26f204380a3c ("fs: Fix file_set_fowner LSM hook
  inconsistencies"): lock before calling the hook.

For now, this is based on a custom merge:
https://git.kernel.org/pub/scm/linux/kernel/git/mic/linux.git/commit/?h=next&id=b1fefed2459f7bd3b1a03c2fa577d30a07130ef6

I'll rebase on top of the master branch once it will include the
required commits.  In the meantime, please use this merge commit as the
base commit for both patch series.

> +	read_lock_irq(&file->f_owner.lock);
> +	dom = landlock_file(file)->fown_domain;
> +	landlock_get_ruleset(dom);
> +	read_unlock_irq(&file->f_owner.lock);
> +	if (!dom)
> +		goto out_unlock;
> +
> +	rcu_read_lock();
> +	is_scoped = domain_is_scoped(dom, landlock_get_task_domain(tsk),
> +				     LANDLOCK_SCOPED_SIGNAL);
> +	rcu_read_unlock();
> +	if (is_scoped) {
> +		landlock_put_ruleset(dom);
> +		return -EPERM;
> +	}
> +out_unlock:
> +	landlock_put_ruleset(dom);
> +	return 0;

Here is the refactoring:

bool is_scoped = false;

/* Lock already held by send_sigio() and send_sigurg(). */
lockdep_assert_held(&fown->lock);
dom = landlock_file(fown->file)->fown_domain;

/* Quick return for unowned socket. */
if (!dom)
	return 0;

rcu_read_lock();
is_scoped = domain_is_scoped(dom, landlock_get_task_domain(tsk),
			     LANDLOCK_SCOPE_SIGNAL);
rcu_read_unlock();
if (is_scoped)
	return -EPERM;

return 0;


> +}
> +
>  static struct security_hook_list landlock_hooks[] __ro_after_init = {
>  	LSM_HOOK_INIT(ptrace_access_check, hook_ptrace_access_check),
>  	LSM_HOOK_INIT(ptrace_traceme, hook_ptrace_traceme),
>  	LSM_HOOK_INIT(unix_stream_connect, hook_unix_stream_connect),
>  	LSM_HOOK_INIT(unix_may_send, hook_unix_may_send),
> +	LSM_HOOK_INIT(task_kill, hook_task_kill),
> +	LSM_HOOK_INIT(file_send_sigiotask, hook_file_send_sigiotask),
>  };
>  
>  __init void landlock_add_task_hooks(void)
> diff --git a/tools/testing/selftests/landlock/scoped_test.c b/tools/testing/selftests/landlock/scoped_test.c
> index 36d7266de9dc..237f98369b25 100644
> --- a/tools/testing/selftests/landlock/scoped_test.c
> +++ b/tools/testing/selftests/landlock/scoped_test.c
> @@ -12,7 +12,7 @@
>  
>  #include "common.h"
>  
> -#define ACCESS_LAST LANDLOCK_SCOPED_ABSTRACT_UNIX_SOCKET
> +#define ACCESS_LAST LANDLOCK_SCOPED_SIGNAL
>  
>  TEST(ruleset_with_unknown_scope)
>  {
> -- 
> 2.34.1
> 

