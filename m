Return-Path: <netdev+bounces-101504-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 259D18FF16E
	for <lists+netdev@lfdr.de>; Thu,  6 Jun 2024 17:58:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 16E3C1C216BA
	for <lists+netdev@lfdr.de>; Thu,  6 Jun 2024 15:58:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB52B1991C4;
	Thu,  6 Jun 2024 15:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="OF8tG9WN"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-bc08.mail.infomaniak.ch (smtp-bc08.mail.infomaniak.ch [45.157.188.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E071197A6E
	for <netdev@vger.kernel.org>; Thu,  6 Jun 2024 15:56:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.157.188.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717689412; cv=none; b=scBzeCXub4FsD8XgYx99eu62mkAPaPixNAHQ+DLD/NnVSwVVVffYvnZuv9UAhJ7yzGjPjvQJ7qBKGmXcey6nMWUSpNnjKUIP2NYhW9HLI4EgCLLgqdzgEvzcbzMyXa0k32gfgP/G2Ut4C44HgrrWSAEeH3RFMoTNzEK6ULImSBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717689412; c=relaxed/simple;
	bh=nBrlffII8WWVUd92OA/ma2b0r1LvjYpxr84p5L6WKcY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d4U7OkX4XoEePFOHvoMGd2bDAmtqVKBMJeSKsZrhA4NMXDokP57JcG1yghfns4HjE4WXtODhwkO9Vg5ay1HSF2TZFITGw8GxrNx8Ka4ND9A8KHiQQjZYCwD/+JPSgSMGfOdy+ACI17PZTwni6tdkqZVwanSftwgJ0QBUkuSm5Jw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=OF8tG9WN; arc=none smtp.client-ip=45.157.188.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Received: from smtp-3-0000.mail.infomaniak.ch (smtp-3-0000.mail.infomaniak.ch [10.4.36.107])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4Vw88P5QkYzN81;
	Thu,  6 Jun 2024 17:56:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1717689397;
	bh=H+EijvVr1PGGCcR1Vv6NIGJbt8vVNBgXaKi1PYmKZwA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OF8tG9WNdrBnsqoyf/UFL4dYt3k9eiego77u+heLYH/QlpRo50ZZrA3bBC45j85LV
	 E+UlFnC8W9Ao+WDsjgH6F3N4fbt3FRoYRnIPatQiqdNQZcvfN2jmkwsaJUzc3DKZsA
	 O2pl8tlqlk6oJdIdPH4LR87vV14CE3zMClb/6Ukc=
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4Vw88N4qFRzlJX;
	Thu,  6 Jun 2024 17:56:36 +0200 (CEST)
Date: Thu, 6 Jun 2024 17:56:16 +0200
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: Tahera Fahimi <fahimitahera@gmail.com>
Cc: =?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>, 
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org, Paul Moore <paul@paul-moore.com>, 
	James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, 
	=?utf-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>, Jann Horn <jannh@google.com>, 
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, outreachy@lists.linux.dev
Subject: Re: [PATCH v3] landlock: Add abstract unix socket connect restriction
Message-ID: <20240606.En2Oob3fei4Z@digikod.net>
References: <ZmE8u1LV6aOWV9tB@tahera-OptiPlex-5000>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZmE8u1LV6aOWV9tB@tahera-OptiPlex-5000>
X-Infomaniak-Routing: alpha

It looks like this patch only applies on top of the previous one, which should
be squashed here.

When running Landlock's tests, layout1.named_unix_domain_socket_ioctl fail.

The whole changes looks good!

On Wed, Jun 05, 2024 at 10:36:11PM -0600, Tahera Fahimi wrote:
> Abstract unix sockets are used for local inter-process communications
> without on a filesystem. Currently a sandboxed process can connect to a
> socket outside of the sandboxed environment, since landlock has no
> restriction for connecting to a unix socket in the abstract namespace.
> Access to such sockets for a sandboxed process should be scoped the same
> way ptrace is limited.
> 
> Because of compatibility reasons and since landlock should be flexible,
> we extend the user space interface by adding a new "scoped" field. This
> field optionally contains a "LANDLOCK_SCOPED_ABSTRACT_UNIX_SOCKET" to
> specify that the ruleset will deny any connection from within the
> sandbox to its parents(i.e. any parent sandbox or non-sandbox processes)
> 
> Closes: https://github.com/landlock-lsm/linux/issues/7
> 

No need for this new line, tags are grouped together.

> Signed-off-by: Tahera Fahimi <fahimitahera@gmail.com>
> 
> -------
> V3: Added "scoped" field to landlock_ruleset_attr
> V2: Remove wrapper functions
> 
> -------
> ---
>  include/uapi/linux/landlock.h | 22 +++++++++++++++
>  security/landlock/limits.h    |  5 ++++
>  security/landlock/ruleset.c   | 16 +++++++----
>  security/landlock/ruleset.h   | 31 ++++++++++++++++++--
>  security/landlock/syscalls.c  |  9 ++++--
>  security/landlock/task.c      | 53 ++++++++++++++++++-----------------
>  6 files changed, 102 insertions(+), 34 deletions(-)
> 
> diff --git a/include/uapi/linux/landlock.h b/include/uapi/linux/landlock.h
> index 68625e728f43..1641aeb9eeaa 100644
> --- a/include/uapi/linux/landlock.h
> +++ b/include/uapi/linux/landlock.h
> @@ -37,6 +37,12 @@ struct landlock_ruleset_attr {
>  	 * rule explicitly allow them.
>  	 */
>  	__u64 handled_access_net;
> +	/**
> +	 * scoped: Bitmask of actions (cf. `Scope access flags`_)
> +	 * that is handled by this ruleset and should be permitted
> +	 * by default if no rule explicitly deny them.
> +	 */
> +	__u64 scoped;
>  };
>  
>  /*
> @@ -266,4 +272,20 @@ struct landlock_net_port_attr {
>  #define LANDLOCK_ACCESS_NET_BIND_TCP			(1ULL << 0)
>  #define LANDLOCK_ACCESS_NET_CONNECT_TCP			(1ULL << 1)
>  /* clang-format on */
> +
> +/**
> + * DOC: scoped
> + *
> + * Scope access flags
> + * ~~~~~~~~~~~~~~~~~~~~

Missing new line.

> + * These flags enable to restrict a sandboxed process to a set of
> + * inter-process communications actions. 

This needs to explain the concept of "scoped" restrictions, similar to
the ptrace restriction (i.e. isolate the Landlock domain to forbid
connections to resources outside the domain).

> + *
> + * IPCs with scoped actions:
> + * - %LANDLOCK_SCOPED_ABSTRACT_UNIX_SOCKET: Restrict a sandbox process to
> + *   connect to another process through abstract unix sockets. 

"another process" is vague.

> + */
> +/* clang-format off */
> +#define LANDLOCK_SCOPED_ABSTRACT_UNIX_SOCKET		(1ULL << 0)
> +/* clang-format on*/
>  #endif /* _UAPI_LINUX_LANDLOCK_H */
> diff --git a/security/landlock/limits.h b/security/landlock/limits.h
> index 20fdb5ff3514..d6fb82fd1e67 100644
> --- a/security/landlock/limits.h
> +++ b/security/landlock/limits.h
> @@ -28,6 +28,11 @@
>  #define LANDLOCK_NUM_ACCESS_NET		__const_hweight64(LANDLOCK_MASK_ACCESS_NET)
>  #define LANDLOCK_SHIFT_ACCESS_NET	LANDLOCK_NUM_ACCESS_FS
>  
> +#define LANDLOCK_LAST_ACCESS_UNIX       LANDLOCK_SCOPED_ABSTRACT_UNIX_SOCKET
> +#define LANDLOCK_MASK_ACCESS_UNIX	((LANDLOCK_LAST_ACCESS_UNIX << 1) - 1)
> +#define LANDLOCK_NUM_ACCESS_UNIX         __const_hweight64(LANDLOCK_MASK_ACCESS_UNIX)
> +#define LANDLOCK_SHIFT_ACCESS_UNIX      LANDLOCK_SHIFT_ACCESS_NET

This is good but this is not specific to unix sockets.  Because this
"scope" will be useful for non-af-unix restrictions, you can rename
LANDLOCK_*_ACCESS_UNIX to LANDLOCK_*_SCOPE.  This should be fixed for
most new variable names with "unix".


> +
>  /* clang-format on */
>  
>  #endif /* _SECURITY_LANDLOCK_LIMITS_H */
> diff --git a/security/landlock/ruleset.c b/security/landlock/ruleset.c
> index e0a5fbf9201a..0592e53cdc9d 100644
> --- a/security/landlock/ruleset.c
> +++ b/security/landlock/ruleset.c
> @@ -52,12 +52,13 @@ static struct landlock_ruleset *create_ruleset(const u32 num_layers)
>  
>  struct landlock_ruleset *
>  landlock_create_ruleset(const access_mask_t fs_access_mask,
> -			const access_mask_t net_access_mask)
> +			const access_mask_t net_access_mask,
> +			const access_mask_t unix_access_mask)

Because this "scope" will be useful for non-af-unix restrictions, you
can rename unix_access_mask to scope_mask.

>  {
>  	struct landlock_ruleset *new_ruleset;
>  
>  	/* Informs about useless ruleset. */
> -	if (!fs_access_mask && !net_access_mask)
> +	if (!fs_access_mask && !net_access_mask && !unix_access_mask)
>  		return ERR_PTR(-ENOMSG);
>  	new_ruleset = create_ruleset(1);
>  	if (IS_ERR(new_ruleset))
> @@ -66,6 +67,9 @@ landlock_create_ruleset(const access_mask_t fs_access_mask,
>  		landlock_add_fs_access_mask(new_ruleset, fs_access_mask, 0);
>  	if (net_access_mask)
>  		landlock_add_net_access_mask(new_ruleset, net_access_mask, 0);
> +	if (unix_access_mask)
> +		landlock_add_unix_socket_access_mask(new_ruleset,
> +						     unix_access_mask, 0);
>  	return new_ruleset;
>  }
>  
> @@ -173,9 +177,11 @@ static void build_check_ruleset(void)
>  
>  	BUILD_BUG_ON(ruleset.num_rules < LANDLOCK_MAX_NUM_RULES);
>  	BUILD_BUG_ON(ruleset.num_layers < LANDLOCK_MAX_NUM_LAYERS);
> -	BUILD_BUG_ON(access_masks <
> -		     ((LANDLOCK_MASK_ACCESS_FS << LANDLOCK_SHIFT_ACCESS_FS) |
> -		      (LANDLOCK_MASK_ACCESS_NET << LANDLOCK_SHIFT_ACCESS_NET)));
> +	BUILD_BUG_ON(
> +		access_masks <
> +		((LANDLOCK_MASK_ACCESS_FS << LANDLOCK_SHIFT_ACCESS_FS) |
> +		 (LANDLOCK_MASK_ACCESS_NET << LANDLOCK_SHIFT_ACCESS_NET) |
> +		 (LANDLOCK_MASK_ACCESS_UNIX << LANDLOCK_SHIFT_ACCESS_UNIX)));
>  }
>  
>  /**
> diff --git a/security/landlock/ruleset.h b/security/landlock/ruleset.h
> index c7f1526784fd..6e755d924a5e 100644
> --- a/security/landlock/ruleset.h
> +++ b/security/landlock/ruleset.h
> @@ -35,6 +35,8 @@ typedef u16 access_mask_t;
>  static_assert(BITS_PER_TYPE(access_mask_t) >= LANDLOCK_NUM_ACCESS_FS);
>  /* Makes sure all network access rights can be stored. */
>  static_assert(BITS_PER_TYPE(access_mask_t) >= LANDLOCK_NUM_ACCESS_NET);
> +/* Makes sure all abstract Unix Socket access rights can be stored*/

As explained above, it is not about unix nor access rights, but scope.

> +static_assert(BITS_PER_TYPE(access_mask_t) >= LANDLOCK_NUM_ACCESS_UNIX);
>  /* Makes sure for_each_set_bit() and for_each_clear_bit() calls are OK. */
>  static_assert(sizeof(unsigned long) >= sizeof(access_mask_t));
>  
> @@ -42,7 +44,8 @@ static_assert(sizeof(unsigned long) >= sizeof(access_mask_t));
>  typedef u32 access_masks_t;
>  /* Makes sure all ruleset access rights can be stored. */
>  static_assert(BITS_PER_TYPE(access_masks_t) >=
> -	      LANDLOCK_NUM_ACCESS_FS + LANDLOCK_NUM_ACCESS_NET);
> +	      LANDLOCK_NUM_ACCESS_FS + LANDLOCK_NUM_ACCESS_NET +
> +		      LANDLOCK_NUM_ACCESS_UNIX);
>  
>  typedef u16 layer_mask_t;
>  /* Makes sure all layers can be checked. */
> @@ -233,7 +236,8 @@ struct landlock_ruleset {
>  
>  struct landlock_ruleset *
>  landlock_create_ruleset(const access_mask_t access_mask_fs,
> -			const access_mask_t access_mask_net);
> +			const access_mask_t access_mask_net,
> +			const access_mask_t access_mask_unix);
>  
>  void landlock_put_ruleset(struct landlock_ruleset *const ruleset);
>  void landlock_put_ruleset_deferred(struct landlock_ruleset *const ruleset);
> @@ -282,6 +286,18 @@ landlock_add_net_access_mask(struct landlock_ruleset *const ruleset,
>  		(net_mask << LANDLOCK_SHIFT_ACCESS_NET);
>  }
>  
> +static inline void
> +landlock_add_unix_socket_access_mask(struct landlock_ruleset *const ruleset,
> +				     const access_mask_t unix_access_mask,
> +				     const u16 layer_level)
> +{
> +	access_mask_t unix_mask = unix_access_mask & LANDLOCK_MASK_ACCESS_UNIX;
> +
> +	WARN_ON_ONCE(unix_access_mask != unix_mask);
> +	ruleset->access_masks[layer_level] |=
> +		(unix_mask << LANDLOCK_SHIFT_ACCESS_UNIX);
> +}
> +
>  static inline access_mask_t
>  landlock_get_raw_fs_access_mask(const struct landlock_ruleset *const ruleset,
>  				const u16 layer_level)
> @@ -309,6 +325,17 @@ landlock_get_net_access_mask(const struct landlock_ruleset *const ruleset,
>  	       LANDLOCK_MASK_ACCESS_NET;
>  }
>  
> +static inline access_mask_t
> +landlock_get_unix_access_mask(const struct landlock_ruleset *const ruleset,
> +			      const u16 layer_level)
> +{
> +	return landlock_get_raw_fs_access_mask(ruleset, layer_level) |
> +	       LANDLOCK_ACCESS_FS_INITIALLY_DENIED;

This first return should not exist.

> +	return (ruleset->access_masks[layer_level] >>
> +		LANDLOCK_SHIFT_ACCESS_UNIX) &
> +	       LANDLOCK_MASK_ACCESS_UNIX;
> +}
> +
>  bool landlock_unmask_layers(const struct landlock_rule *const rule,
>  			    const access_mask_t access_request,
>  			    layer_mask_t (*const layer_masks)[],
> diff --git a/security/landlock/syscalls.c b/security/landlock/syscalls.c
> index 03b470f5a85a..955d3d028963 100644
> --- a/security/landlock/syscalls.c
> +++ b/security/landlock/syscalls.c
> @@ -97,8 +97,9 @@ static void build_check_abi(void)
>  	 */
>  	ruleset_size = sizeof(ruleset_attr.handled_access_fs);
>  	ruleset_size += sizeof(ruleset_attr.handled_access_net);
> +	ruleset_size += sizeof(ruleset_attr.scoped);
>  	BUILD_BUG_ON(sizeof(ruleset_attr) != ruleset_size);
> -	BUILD_BUG_ON(sizeof(ruleset_attr) != 16);
> +	BUILD_BUG_ON(sizeof(ruleset_attr) != 24);
>  
>  	path_beneath_size = sizeof(path_beneath_attr.allowed_access);
>  	path_beneath_size += sizeof(path_beneath_attr.parent_fd);
> @@ -212,10 +213,14 @@ SYSCALL_DEFINE3(landlock_create_ruleset,

The documentation of this function should be updated to reflect the
scope change:

 * - %EINVAL: unknown @flags, or unknown access, or unknown scope, or too small
 *   @size;

>  	if ((ruleset_attr.handled_access_net | LANDLOCK_MASK_ACCESS_NET) !=
>  	    LANDLOCK_MASK_ACCESS_NET)
>  		return -EINVAL;

A comment should explain what we check here, like for filesystem and
network.  A new line should help to differentiate network and scope
checks.

> +	if ((ruleset_attr.scoped | LANDLOCK_MASK_ACCESS_UNIX) !=
> +	    LANDLOCK_MASK_ACCESS_UNIX)
> +		return -EINVAL;
>  
>  	/* Checks arguments and transforms to kernel struct. */
>  	ruleset = landlock_create_ruleset(ruleset_attr.handled_access_fs,
> -					  ruleset_attr.handled_access_net);
> +					  ruleset_attr.handled_access_net,
> +					  ruleset_attr.scoped);
>  	if (IS_ERR(ruleset))
>  		return PTR_ERR(ruleset);
>  
> diff --git a/security/landlock/task.c b/security/landlock/task.c
> index 67528f87b7de..b42f31cca2ae 100644
> --- a/security/landlock/task.c
> +++ b/security/landlock/task.c
> @@ -14,6 +14,7 @@
>  #include <linux/rcupdate.h>
>  #include <linux/sched.h>
>  #include <net/sock.h>
> +#include <net/af_unix.h>

You can sort all these headers with sort -u.

>  
>  #include "common.h"
>  #include "cred.h"
> @@ -109,32 +110,25 @@ static int hook_ptrace_traceme(struct task_struct *const parent)
>  	return task_ptrace(parent, current);
>  }
>  

It's difficult to review such patch modifying another patch, but here are a
review of the whole change:

> -static bool unix_sock_is_scoped(struct sock *const sock,
> -				struct sock *const other)
> +static bool sock_is_scoped(struct sock *const sock, struct sock *const other)

If the "sock" argument is not used, it should either not exist or be used to
identify the creds instead of using the "current" creds.  This is not the same
thing because a newly created socket could be passed or inherited.  I'm not
sure what should be the best approach yet, but let's keep using the current
creds for now and remove the "sock" argument for now.

BTW, tests should check with sockets created before sandboxing.

>  {
>  	bool is_scoped = true;
> -
> -	/* get the ruleset of connecting sock*/
> -	const struct landlock_ruleset *const dom_sock =
> -		landlock_get_current_domain();
> -
> -	if (!dom_sock)
> -		return true;
> -
> -	/* get credential of listening sock*/
> -	const struct cred *cred_other = get_cred(other->sk_peer_cred);
> -
> -	if (!cred_other)
> -		return true;
> -
> -	/* retrieve the landlock_rulesets */
> -	const struct landlock_ruleset *dom_parent;
> -
> -	rcu_read_lock();
> -	dom_parent = landlock_cred(cred_other)->domain;
> -	is_scoped = domain_scope_le(dom_parent, dom_sock);
> -	rcu_read_unlock();
> -
> +	const struct landlock_ruleset *dom_other;
> +	const struct cred *cred_other;
> +
> +	const struct landlock_ruleset *const dom = landlock_get_current_domain();
> +	if (!dom)
> +		goto out_put_cred;

This case calls put_cred() on an uninitialized pointer.  It should just return.

> +
> +	
> +	lockdep_assert_held(&unix_sk(other)->lock);
> +	/* the credentials will not change */
> +	cred_other = get_cred(other->sk_peer_cred);
> +	dom_other = landlock_cred(cred_other)->domain;
> +	is_scoped = domain_scope_le(dom, dom_other);
> +
> +out_put_cred:
> +	put_cred(cred_other);
>  	return is_scoped;
>  }
>  
> @@ -142,7 +136,15 @@ static int hook_unix_stream_connect(struct sock *const sock,
>  				    struct sock *const other,
>  				    struct sock *const newsk)
>  {
> -	if (unix_sock_is_scoped(sock, other))
> +	if (sock_is_scoped(sock, other))
> +		return 0;

You can add a new line after a return like this.

> +	return -EPERM;
> +}
> +
> +static int hook_unix_may_send(struct socket *const sock,
> +			      struct socket *const other)
> +{
> +	if (sock_is_scoped(sock->sk, other->sk))
>  		return 0;
>  	return -EPERM;
>  }
> @@ -151,6 +153,7 @@ static struct security_hook_list landlock_hooks[] __ro_after_init = {
>  	LSM_HOOK_INIT(ptrace_access_check, hook_ptrace_access_check),
>  	LSM_HOOK_INIT(ptrace_traceme, hook_ptrace_traceme),
>  	LSM_HOOK_INIT(unix_stream_connect, hook_unix_stream_connect),
> +	LSM_HOOK_INIT(unix_may_send, hook_unix_may_send),
>  };
>  
>  __init void landlock_add_task_hooks(void)
> -- 
> 2.34.1
> 
> 

