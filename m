Return-Path: <netdev+bounces-105770-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D6A4F912B73
	for <lists+netdev@lfdr.de>; Fri, 21 Jun 2024 18:35:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 541471F26D88
	for <lists+netdev@lfdr.de>; Fri, 21 Jun 2024 16:35:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB676156227;
	Fri, 21 Jun 2024 16:35:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="WaFdfRFb"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-190c.mail.infomaniak.ch (smtp-190c.mail.infomaniak.ch [185.125.25.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59A15DDC4
	for <netdev@vger.kernel.org>; Fri, 21 Jun 2024 16:35:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.25.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718987751; cv=none; b=kIhGIue3jhNWYAN5g3FuG8kSA573ksfu5K92O3bmuAYenWOgI8aZeI9SEHIu7zZJIGVmviLlCVKLFvl8dXFaO6Ud1IaKnpPg7Db63EUzaLNBSViKPq9WlmNMEHR/isyfH3N985DY6DfDyVUPTkzx/StofU3c7zj6eua8KbJ/mSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718987751; c=relaxed/simple;
	bh=HLIGsFoFXfkW5grq1kBsr2MpcKrxX3SI7FnwCeRJfmQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s1UdfdvE24D8URe/L7NHOB4z1I7BYi5+9POs/y69XyfwuZYutFRrp2COOoprwFyb94FHI4olnJz5j3jw2bRfFSv9G0a6V4rLenVYYR4IOn3O1ADNaY6x0Wiazibxo925FCNz4B/idEciWqTltYmq0aoVVdTMCKiask6ktlpd7wQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=WaFdfRFb; arc=none smtp.client-ip=185.125.25.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Received: from smtp-4-0001.mail.infomaniak.ch (smtp-4-0001.mail.infomaniak.ch [10.7.10.108])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4W5MWR4WWmzhc9;
	Fri, 21 Jun 2024 18:00:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1718985603;
	bh=jjsdmC2rugRobeZ0tOl0fxS/md4FLeZ48MksR7AnbBo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WaFdfRFbrYof0i6GJ3s03UP2zYVpTvHZEofmVI+QFEKiogYokX1VszDK9uzjkk+lK
	 j4OrAs8Q4kmgye1LO+uLrT8MfCppYj6fsGOKwQEs7RQYeLXKIjmwBpqEJaRuUzHKEt
	 6v+2gQi7FUW0V6JK0vIhKrt1Ww7CUp1ISzdxpPlE=
Received: from unknown by smtp-4-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4W5MWQ29Yrz353;
	Fri, 21 Jun 2024 18:00:02 +0200 (CEST)
Date: Fri, 21 Jun 2024 18:00:01 +0200
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: Tahera Fahimi <fahimitahera@gmail.com>
Cc: =?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>, 
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, 
	"Serge E. Hallyn" <serge@hallyn.com>, linux-security-module@vger.kernel.org, 
	linux-kernel@vger.kernel.org, =?utf-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>, 
	Jann Horn <jannh@google.com>, outreachy@lists.linux.dev, netdev@vger.kernel.org
Subject: Re: [PATCH v5] landlock: Add abstract unix socket connect restriction
Message-ID: <20240621.OhK4Aht4oa7i@digikod.net>
References: <ZnSZnhGBiprI6FRk@tahera-OptiPlex-5000>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZnSZnhGBiprI6FRk@tahera-OptiPlex-5000>
X-Infomaniak-Routing: alpha

On Thu, Jun 20, 2024 at 03:05:34PM GMT, Tahera Fahimi wrote:
> Abstract unix sockets are used for local inter-process communications
> without on a filesystem. Currently a sandboxed process can connect to a

"without a"

> socket outside of the sandboxed environment, since landlock has no

s/landlock/Landlock/

> restriction for connecting to a unix socket in the abstract namespace.

"namespace" usually refers to the namespaces(7) man page.  What about
using the same vocabulary is in unix(7):
"for connecting to an abstract socket address."

> Access to such sockets for a sandboxed process should be scoped the same
> way ptrace is limited.
> 
> Because of compatibility reasons and since landlock should be flexible,
> we extend the user space interface by adding a new "scoped" field

...to the ruleset attribute structure.

> . This
> field optionally contains a "LANDLOCK_SCOPED_ABSTRACT_UNIX_SOCKET" to
> specify that the ruleset will deny any connection from within the
> sandbox to its parents(i.e. any parent sandbox or non-sandbox processes)
> 
> Closes: https://github.com/landlock-lsm/linux/issues/7
> Signed-off-by: Tahera Fahimi <fahimitahera@gmail.com>
> 
> -------

For the next version, please list all changes since last version. With
this v5 I see some renaming, a new curr_ruleset field with optional
domain scopping, and code formatting.


> V4: Added abstract unix socket scoping tests
> V3: Added "scoped" field to landlock_ruleset_attr
> V2: Remove wrapper functions
> 
> -------
> 
> Signed-off-by: Tahera Fahimi <fahimitahera@gmail.com>
> ---
>  include/uapi/linux/landlock.h                 |  27 ++
>  security/landlock/limits.h                    |   3 +
>  security/landlock/ruleset.c                   |  12 +-
>  security/landlock/ruleset.h                   |  27 +-
>  security/landlock/syscalls.c                  |  13 +-
>  security/landlock/task.c                      |  95 +++++++
>  .../testing/selftests/landlock/ptrace_test.c  | 261 ++++++++++++++++++
>  7 files changed, 430 insertions(+), 8 deletions(-)
> 
> diff --git a/include/uapi/linux/landlock.h b/include/uapi/linux/landlock.h
> index 68625e728f43..1eb459afcb3b 100644
> --- a/include/uapi/linux/landlock.h
> +++ b/include/uapi/linux/landlock.h
> @@ -37,6 +37,11 @@ struct landlock_ruleset_attr {
>  	 * rule explicitly allow them.
>  	 */
>  	__u64 handled_access_net;
> +	/**
> +	 * scoped: Bitmask of actions (cf. `Scope access flags`_)

Please take a look at the generated documentation and fix the build
warnings related to this patch: check-linux.sh doc (or make htmldocs)


> +	 * which are confined to only affect the current Landlock domain.

What about this?
"Bitmask of scopes () restricting a Landlock domain from accessing
outside resources (e.g. IPCs)."

> +	 */
> +	__u64 scoped;
>  };
>  
>  /*
> @@ -266,4 +271,26 @@ struct landlock_net_port_attr {
>  #define LANDLOCK_ACCESS_NET_BIND_TCP			(1ULL << 0)
>  #define LANDLOCK_ACCESS_NET_CONNECT_TCP			(1ULL << 1)
>  /* clang-format on */
> +
> +/**
> + * DOC: scope
> + *
> + * .scoped attribute handles a set of restrictions on kernel IPCs through
> + * the following flags.

Shouldn't this be after the section title?

> + *
> + * Scope access flags

You can remove "access"

> + * ~~~~~~~~~~~~~~~~~~~~
> + * 
> + * These flags enable to restrict a sandboxed process from a set of IPC 

There are several spaces at the end of lines, they should be removed.

> + * actions. Setting a flag in a landlock domain will isolate the Landlock

A flag is not set "in a Landlock domain" but for a ruleset.

> + *  domain to forbid connections to resources outside the domain.

Please remove unneeded spaces.

> + *
> + * IPCs with scoped actions:
> + * - %LANDLOCK_SCOPED_ABSTRACT_UNIX_SOCKET: Restrict a sandbox process to
> + *   connect to a process outside of the sandbox domain through abstract
> + *   unix sockets. 

Restrict a sandboxed process from connecting to an abstract unix socket
created by a process outside the related Landlock domain (e.g. a parent
domain or a process which is not sandboxed).

> + */
> +/* clang-format off */
> +#define LANDLOCK_SCOPED_ABSTRACT_UNIX_SOCKET		(1ULL << 0)
> +/* clang-format on*/
>  #endif /* _UAPI_LINUX_LANDLOCK_H */
> diff --git a/security/landlock/limits.h b/security/landlock/limits.h
> index 4eb643077a2a..eb01d0fb2165 100644
> --- a/security/landlock/limits.h
> +++ b/security/landlock/limits.h
> @@ -26,6 +26,9 @@
>  #define LANDLOCK_MASK_ACCESS_NET	((LANDLOCK_LAST_ACCESS_NET << 1) - 1)
>  #define LANDLOCK_NUM_ACCESS_NET		__const_hweight64(LANDLOCK_MASK_ACCESS_NET)
>  
> +#define LANDLOCK_LAST_SCOPE		LANDLOCK_SCOPED_ABSTRACT_UNIX_SOCKET
> +#define LANDLOCK_MASK_SCOPE		((LANDLOCK_LAST_SCOPE << 1) - 1)
> +#define LANDLOCK_NUM_SCOPE		__const_hweight64(LANDLOCK_MASK_SCOPE)
>  /* clang-format on */
>  
>  #endif /* _SECURITY_LANDLOCK_LIMITS_H */
> diff --git a/security/landlock/ruleset.c b/security/landlock/ruleset.c
> index 6ff232f58618..3b3844574326 100644
> --- a/security/landlock/ruleset.c
> +++ b/security/landlock/ruleset.c
> @@ -52,12 +52,13 @@ static struct landlock_ruleset *create_ruleset(const u32 num_layers)
>  
>  struct landlock_ruleset *
>  landlock_create_ruleset(const access_mask_t fs_access_mask,
> -			const access_mask_t net_access_mask)
> +			const access_mask_t net_access_mask,
> +			const access_mask_t scope_mask)
>  {
>  	struct landlock_ruleset *new_ruleset;
>  
>  	/* Informs about useless ruleset. */
> -	if (!fs_access_mask && !net_access_mask)
> +	if (!fs_access_mask && !net_access_mask && !scope_mask)
>  		return ERR_PTR(-ENOMSG);
>  	new_ruleset = create_ruleset(1);
>  	if (IS_ERR(new_ruleset))
> @@ -66,6 +67,8 @@ landlock_create_ruleset(const access_mask_t fs_access_mask,
>  		landlock_add_fs_access_mask(new_ruleset, fs_access_mask, 0);
>  	if (net_access_mask)
>  		landlock_add_net_access_mask(new_ruleset, net_access_mask, 0);
> +	if (scope_mask)
> +		landlock_add_scope_mask(new_ruleset, scope_mask, 0);
>  	return new_ruleset;
>  }
>  
> @@ -311,7 +314,7 @@ static void put_hierarchy(struct landlock_hierarchy *hierarchy)
>  {
>  	while (hierarchy && refcount_dec_and_test(&hierarchy->usage)) {
>  		const struct landlock_hierarchy *const freeme = hierarchy;
> -
> +		
>  		hierarchy = hierarchy->parent;
>  		kfree(freeme);
>  	}
> @@ -472,6 +475,7 @@ static int inherit_ruleset(struct landlock_ruleset *const parent,
>  	}
>  	get_hierarchy(parent->hierarchy);
>  	child->hierarchy->parent = parent->hierarchy;
> +	child->hierarchy->curr_ruleset = child;
>  
>  out_unlock:
>  	mutex_unlock(&parent->lock);
> @@ -571,7 +575,7 @@ landlock_merge_ruleset(struct landlock_ruleset *const parent,
>  	err = merge_ruleset(new_dom, ruleset);
>  	if (err)
>  		goto out_put_dom;
> -
> +	new_dom->hierarchy->curr_ruleset = new_dom;
>  	return new_dom;
>  
>  out_put_dom:
> diff --git a/security/landlock/ruleset.h b/security/landlock/ruleset.h
> index 0f1b5b4c8f6b..39cb313812dc 100644
> --- a/security/landlock/ruleset.h
> +++ b/security/landlock/ruleset.h
> @@ -35,6 +35,8 @@ typedef u16 access_mask_t;
>  static_assert(BITS_PER_TYPE(access_mask_t) >= LANDLOCK_NUM_ACCESS_FS);
>  /* Makes sure all network access rights can be stored. */
>  static_assert(BITS_PER_TYPE(access_mask_t) >= LANDLOCK_NUM_ACCESS_NET);
> +/* Makes sure all scoped rights can be stored*/
> +static_assert(BITS_PER_TYPE(access_mask_t) >= LANDLOCK_NUM_SCOPE);
>  /* Makes sure for_each_set_bit() and for_each_clear_bit() calls are OK. */
>  static_assert(sizeof(unsigned long) >= sizeof(access_mask_t));
>  
> @@ -42,6 +44,7 @@ static_assert(sizeof(unsigned long) >= sizeof(access_mask_t));
>  struct access_masks {
>  	access_mask_t fs : LANDLOCK_NUM_ACCESS_FS;
>  	access_mask_t net : LANDLOCK_NUM_ACCESS_NET;
> +	access_mask_t scoped : LANDLOCK_NUM_SCOPE;
>  };
>  
>  typedef u16 layer_mask_t;
> @@ -150,6 +153,10 @@ struct landlock_hierarchy {
>  	 * domain.
>  	 */
>  	refcount_t usage;
> +	/**
> +	 * @curr_ruleset: a pointer back to the current ruleset
> +	 */
> +	struct landlock_ruleset *curr_ruleset;

This curr_ruleset pointer can become a dangling pointer and then lead to
a user after free bug because a domain (i.e. ruleset tie to a set of
processes) is free when no processes use it.

Instead, we could just use a bitmask (or a boolean for now) to identify
if the related layer scopes abstract unix sockets.  Because struct
landlock_hierarchy identifies only one layer of a domain, another and
simpler approach would be to only rely on the "client" and "server"
domains' layers.

