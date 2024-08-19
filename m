Return-Path: <netdev+bounces-119906-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B8CCB95775C
	for <lists+netdev@lfdr.de>; Tue, 20 Aug 2024 00:20:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DD91B1C22C37
	for <lists+netdev@lfdr.de>; Mon, 19 Aug 2024 22:20:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 398E21D54CA;
	Mon, 19 Aug 2024 22:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MYWI60dN"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6466B1DB449;
	Mon, 19 Aug 2024 22:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724106035; cv=none; b=Io5Ih6HyCGmqzBwDd+1s05zucPte6ERyXgTZsQiWr9HZ2Ib8HEziSyWFpZ6u4Fjg8LK/3kDdDqY8Jc1JCCB+iirEOGQ49g4qPrbMKXjhw8Ckg483jWVTS4QeW4jDuwPpb3EO9W4QHvVFxbHbxHHokMHUm/+Y+RcTEJ1vK1ZJDE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724106035; c=relaxed/simple;
	bh=fSs8phGMXoSX6Xjw3c6n4SsKzv3aAHhYdHBbct5NKGk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WqeCCebyLnz3XyQamL0+lKH7E4H6n+NL9gONqpCIXJuLgpaAOUuqv1vP85i9hWfu5fbmTPxnhN/+e375PtJpdJkGbASMYE4LaKJsbiuFzK45OU3StsdxIkvy62Su0tGtqdCiQdOOZxvoe6hPiArrVgrwwNu7Zta5UtPPfPJFj24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MYWI60dN; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-20227ba378eso16845105ad.0;
        Mon, 19 Aug 2024 15:20:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724106032; x=1724710832; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=SHvzSx6p9c2kUn/XzKdHHU+56jjuQ069smDr21e/FGI=;
        b=MYWI60dN1TjTQ736PYvXz8+tzq5MVz4AAiazBH26LM9Jb1SDn2Vsbh7R/WKUN1CdZI
         AsFCGchEC4CuPMP3FGFsHLGnQD4xp+ZnxaVaHJ9OEwC7MSea/rhacF3/5TTuDGPoYbIE
         nMTBMTSODTr32Q78r8iUrSf7BORwPQSxGlI4Cj7QHYlp2BfLZ4aLO2Was/ikxqBupAsG
         CV4vnNJC92iapp0SQWVDapcatZUZrhXitSHACEVlkiMg1zNb58C1VVUl0cqoU7DGPwZ3
         vxyL942PVzPzTYmmSmq8PjAUFg4HruIlb58vt8ybC0EfJEePOIGTL7yI5L3uV4iwFn3e
         doMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724106032; x=1724710832;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SHvzSx6p9c2kUn/XzKdHHU+56jjuQ069smDr21e/FGI=;
        b=ahY1kwSWRiAOlp8Zk6bQq6aEtYptuTZVZfYHu7jKMJ9paR6HpzYqTgB6Rpxcgs/3ZD
         8fW/KzMkLhRl5BtGHuJHkyRPdK0Nsp0AIB8JOD5akmFuaHFU7GhxDElP1rgROhua3uCS
         nswVu38EgEOl8vb2YbxAQ3kZuJF5lzUmvKbCgQRZH0rMqg+K5PJM4kBF1O4QqIGNddtd
         WD+p4NDnNW+9OXKP08FIKppawZ2+jDCykwnoVpKD/L6HRlSMuacQN4HvXhOaVmNHGTsH
         RM/Wf5E/ulpGwgytgpimBs9OAsszx5GhL3SfmlTSt/7G6prNVvlod3kjqKTbP6YRqeOv
         P23g==
X-Forwarded-Encrypted: i=1; AJvYcCXrvH/vF85Jnm4Azpm17hnv/VAdylZXGIe3ElW+I2nLU1aP0mkpEXG3cN6ZCuSSEWDMJaJ+kxFuv6xK38FW3xx8D2auwp9wMsxdvHT0kVCxFO9w+7ZqeOVmoeNgwQ1JF7yCVkuEldPntKTkaNP0wTFSXKRfm4J0Kbe+vioBt7A8IoDMBrQFsB9j/P1D
X-Gm-Message-State: AOJu0YyoA/vRt8JpAtYxPpeGk/lVDM3cub5oL6Ibe5pKQyQRw70EQtXE
	zxVFwijoJSzrXakjmvOzs7ztf6uHT+JMUYXb7GlLQ6/NmbRdjvI3
X-Google-Smtp-Source: AGHT+IEUyV58cDmvQB8oV5WIO8Tx8Raa2Oebwb1juJUx9zGO4a62wgAOD1mrWree4TL2ATogJOS8cg==
X-Received: by 2002:a17:902:f552:b0:202:4666:f018 with SMTP id d9443c01a7336-2024666f56fmr58629175ad.15.1724106031322;
        Mon, 19 Aug 2024 15:20:31 -0700 (PDT)
Received: from tahera-OptiPlex-5000 ([136.159.49.123])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2021c565c05sm37204695ad.283.2024.08.19.15.20.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Aug 2024 15:20:30 -0700 (PDT)
Date: Mon, 19 Aug 2024 16:20:28 -0600
From: Tahera Fahimi <fahimitahera@gmail.com>
To: =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>
Cc: outreachy@lists.linux.dev, gnoack@google.com, paul@paul-moore.com,
	jmorris@namei.org, serge@hallyn.com,
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
	bjorn3_gh@protonmail.com, jannh@google.com, netdev@vger.kernel.org
Subject: Re: [PATCH v9 1/5] Landlock: Add abstract unix socket connect
 restriction
Message-ID: <ZsPFLJzn4K7BuNag@tahera-OptiPlex-5000>
References: <cover.1723615689.git.fahimitahera@gmail.com>
 <603cf546392f0cd35227f696527fd8f1d644cb31.1723615689.git.fahimitahera@gmail.com>
 <20240819.Oopae3ieKuvi@digikod.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240819.Oopae3ieKuvi@digikod.net>

On Mon, Aug 19, 2024 at 05:37:23PM +0200, Mickaël Salaün wrote:
> On Wed, Aug 14, 2024 at 12:22:19AM -0600, Tahera Fahimi wrote:
> > This patch introduces a new "scoped" attribute to the landlock_ruleset_attr
> > that can specify "LANDLOCK_SCOPED_ABSTRACT_UNIX_SOCKET" to scope
> > abstract Unix sockets from connecting to a process outside of
> 
> We should follow the man page style and use "UNIX" everywhere.
> 
> > the same landlock domain. It implements two hooks, unix_stream_connect
> 
> We should always write "Landlock" in doc/comment/commit messages, except
> for subject prefixes because of the file names (e.g. security/landlock).
> 
> 
> > and unix_may_send to enforce this restriction.
> > 
> > Closes: https://github.com/landlock-lsm/linux/issues/7
> > Signed-off-by: Tahera Fahimi <fahimitahera@gmail.com>
> > 
> > ---
> > v9:
> > - Editting inline comments.
> > - Major refactoring in domain_is_scoped() and is_abstract_socket
> > v8:
> > - Code refactoring (improve code readability, renaming variable, etc.) based
> >   on reviews by Mickaël Salaün on version 7.
> > - Adding warn_on_once to check (impossible) inconsistencies.
> > - Adding inline comments.
> > - Adding check_unix_address_format to check if the scoping socket is an abstract
> >   unix sockets.
> > v7:
> >  - Using socket's file credentials for both connected(STREAM) and
> >    non-connected(DGRAM) sockets.
> >  - Adding "domain_sock_scope" instead of the domain scoping mechanism used in
> >    ptrace ensures that if a server's domain is accessible from the client's
> >    domain (where the client is more privileged than the server), the client
> >    can connect to the server in all edge cases.
> >  - Removing debug codes.
> > v6:
> >  - Removing curr_ruleset from landlock_hierarchy, and switching back to use
> >    the same domain scoping as ptrace.
> >  - code clean up.
> > v5:
> >  - Renaming "LANDLOCK_*_ACCESS_SCOPE" to "LANDLOCK_*_SCOPE"
> >  - Adding curr_ruleset to hierarachy_ruleset structure to have access from
> >    landlock_hierarchy to its respective landlock_ruleset.
> >  - Using curr_ruleset to check if a domain is scoped while walking in the
> >    hierarchy of domains.
> >  - Modifying inline comments.
> > V4:
> >  - Rebased on Günther's Patch:
> >    https://lore.kernel.org/all/20240610082115.1693267-1-gnoack@google.com/
> >    so there is no need for "LANDLOCK_SHIFT_ACCESS_SCOPE", then it is removed.
> >  - Adding get_scope_accesses function to check all scoped access masks in a ruleset.
> >  - Using socket's file credentials instead of credentials stored in peer_cred
> >    for datagram sockets. (see discussion in [1])
> >  - Modifying inline comments.
> > V3:
> >  - Improving commit description.
> >  - Introducing "scoped" attribute to landlock_ruleset_attr for IPC scoping
> >    purpose, and adding related functions.
> >  - Changing structure of ruleset based on "scoped".
> >  - Removing rcu lock and using unix_sk lock instead.
> >  - Introducing scoping for datagram sockets in unix_may_send.
> > V2:
> >  - Removing wrapper functions
> > 
> > [1]https://lore.kernel.org/all/20240610.Aifee5ingugh@digikod.net/
> > ----
> > ---
> >  include/uapi/linux/landlock.h |  27 +++++++
> >  security/landlock/limits.h    |   3 +
> >  security/landlock/ruleset.c   |   7 +-
> >  security/landlock/ruleset.h   |  23 +++++-
> >  security/landlock/syscalls.c  |  17 +++--
> >  security/landlock/task.c      | 129 ++++++++++++++++++++++++++++++++++
> >  6 files changed, 198 insertions(+), 8 deletions(-)
> > 
> > diff --git a/include/uapi/linux/landlock.h b/include/uapi/linux/landlock.h
> > index 68625e728f43..057a4811ed06 100644
> > --- a/include/uapi/linux/landlock.h
> > +++ b/include/uapi/linux/landlock.h
> > @@ -37,6 +37,12 @@ struct landlock_ruleset_attr {
> >  	 * rule explicitly allow them.
> >  	 */
> >  	__u64 handled_access_net;
> > +	/**
> > +	 * @scoped: Bitmask of scopes (cf. `Scope flags`_)
> > +	 * restricting a Landlock domain from accessing outside
> > +	 * resources(e.g. IPCs).
> 
> Missing space
> 
> > +	 */
> > +	__u64 scoped;
> >  };
> >  
> >  /*
> > @@ -266,4 +272,25 @@ struct landlock_net_port_attr {
> >  #define LANDLOCK_ACCESS_NET_BIND_TCP			(1ULL << 0)
> >  #define LANDLOCK_ACCESS_NET_CONNECT_TCP			(1ULL << 1)
> >  /* clang-format on */
> > +
> > +/**
> > + * DOC: scope
> > + *
> > + * Scope flags
> > + * ~~~~~~~~~~~
> > + *
> > + * These flags enable to restrict a sandboxed process from a set of IPC
> > + * actions. Setting a flag for a ruleset will isolate the Landlock domain
> > + * to forbid connections to resources outside the domain.
> > + *
> > + * IPCs with scoped actions:
> > + *
> > + * - %LANDLOCK_SCOPED_ABSTRACT_UNIX_SOCKET: Restrict a sandboxed process
> > + *   from connecting to an abstract unix socket created by a process
> > + *   outside the related Landlock domain (e.g. a parent domain or a
> > + *   non-sandboxed process).
> > + */
> > +/* clang-format off */
> > +#define LANDLOCK_SCOPED_ABSTRACT_UNIX_SOCKET		(1ULL << 0)
> > +/* clang-format on*/
> 
> Please add a newline here.
> 
> >  #endif /* _UAPI_LINUX_LANDLOCK_H */
> > diff --git a/security/landlock/limits.h b/security/landlock/limits.h
> > index 4eb643077a2a..eb01d0fb2165 100644
> > --- a/security/landlock/limits.h
> > +++ b/security/landlock/limits.h
> > @@ -26,6 +26,9 @@
> >  #define LANDLOCK_MASK_ACCESS_NET	((LANDLOCK_LAST_ACCESS_NET << 1) - 1)
> >  #define LANDLOCK_NUM_ACCESS_NET		__const_hweight64(LANDLOCK_MASK_ACCESS_NET)
> >  
> > +#define LANDLOCK_LAST_SCOPE		LANDLOCK_SCOPED_ABSTRACT_UNIX_SOCKET
> > +#define LANDLOCK_MASK_SCOPE		((LANDLOCK_LAST_SCOPE << 1) - 1)
> > +#define LANDLOCK_NUM_SCOPE		__const_hweight64(LANDLOCK_MASK_SCOPE)
> >  /* clang-format on */
> >  
> >  #endif /* _SECURITY_LANDLOCK_LIMITS_H */
> > diff --git a/security/landlock/ruleset.c b/security/landlock/ruleset.c
> > index 6ff232f58618..a93bdbf52fff 100644
> > --- a/security/landlock/ruleset.c
> > +++ b/security/landlock/ruleset.c
> > @@ -52,12 +52,13 @@ static struct landlock_ruleset *create_ruleset(const u32 num_layers)
> >  
> >  struct landlock_ruleset *
> >  landlock_create_ruleset(const access_mask_t fs_access_mask,
> > -			const access_mask_t net_access_mask)
> > +			const access_mask_t net_access_mask,
> > +			const access_mask_t scope_mask)
> >  {
> >  	struct landlock_ruleset *new_ruleset;
> >  
> >  	/* Informs about useless ruleset. */
> > -	if (!fs_access_mask && !net_access_mask)
> > +	if (!fs_access_mask && !net_access_mask && !scope_mask)
> >  		return ERR_PTR(-ENOMSG);
> >  	new_ruleset = create_ruleset(1);
> >  	if (IS_ERR(new_ruleset))
> > @@ -66,6 +67,8 @@ landlock_create_ruleset(const access_mask_t fs_access_mask,
> >  		landlock_add_fs_access_mask(new_ruleset, fs_access_mask, 0);
> >  	if (net_access_mask)
> >  		landlock_add_net_access_mask(new_ruleset, net_access_mask, 0);
> > +	if (scope_mask)
> > +		landlock_add_scope_mask(new_ruleset, scope_mask, 0);
> >  	return new_ruleset;
> >  }
> >  
> > diff --git a/security/landlock/ruleset.h b/security/landlock/ruleset.h
> > index 0f1b5b4c8f6b..c749fa0b3ecd 100644
> > --- a/security/landlock/ruleset.h
> > +++ b/security/landlock/ruleset.h
> > @@ -35,6 +35,8 @@ typedef u16 access_mask_t;
> >  static_assert(BITS_PER_TYPE(access_mask_t) >= LANDLOCK_NUM_ACCESS_FS);
> >  /* Makes sure all network access rights can be stored. */
> >  static_assert(BITS_PER_TYPE(access_mask_t) >= LANDLOCK_NUM_ACCESS_NET);
> > +/* Makes sure all scoped rights can be stored*/
> 
> "stored. */"
> 
> > +static_assert(BITS_PER_TYPE(access_mask_t) >= LANDLOCK_NUM_SCOPE);
> >  /* Makes sure for_each_set_bit() and for_each_clear_bit() calls are OK. */
> >  static_assert(sizeof(unsigned long) >= sizeof(access_mask_t));
> >  
> > @@ -42,6 +44,7 @@ static_assert(sizeof(unsigned long) >= sizeof(access_mask_t));
> >  struct access_masks {
> >  	access_mask_t fs : LANDLOCK_NUM_ACCESS_FS;
> >  	access_mask_t net : LANDLOCK_NUM_ACCESS_NET;
> > +	access_mask_t scoped : LANDLOCK_NUM_SCOPE;
> >  };
> >  
> >  typedef u16 layer_mask_t;
> > @@ -233,7 +236,8 @@ struct landlock_ruleset {
> >  
> >  struct landlock_ruleset *
> >  landlock_create_ruleset(const access_mask_t access_mask_fs,
> > -			const access_mask_t access_mask_net);
> > +			const access_mask_t access_mask_net,
> > +			const access_mask_t scope_mask);
> >  
> >  void landlock_put_ruleset(struct landlock_ruleset *const ruleset);
> >  void landlock_put_ruleset_deferred(struct landlock_ruleset *const ruleset);
> > @@ -280,6 +284,16 @@ landlock_add_net_access_mask(struct landlock_ruleset *const ruleset,
> >  	ruleset->access_masks[layer_level].net |= net_mask;
> >  }
> >  
> > +static inline void
> > +landlock_add_scope_mask(struct landlock_ruleset *const ruleset,
> > +			const access_mask_t scope_mask, const u16 layer_level)
> > +{
> > +	access_mask_t scoped_mask = scope_mask & LANDLOCK_MASK_SCOPE;
> > +
> 
> Plesae add the same comment as for similar helpers explaining why this
> should never happen.
> 
> > +	WARN_ON_ONCE(scope_mask != scoped_mask);
> > +	ruleset->access_masks[layer_level].scoped |= scoped_mask;
> > +}
> > +
> >  static inline access_mask_t
> >  landlock_get_raw_fs_access_mask(const struct landlock_ruleset *const ruleset,
> >  				const u16 layer_level)
> > @@ -303,6 +317,13 @@ landlock_get_net_access_mask(const struct landlock_ruleset *const ruleset,
> >  	return ruleset->access_masks[layer_level].net;
> >  }
> >  
> > +static inline access_mask_t
> > +landlock_get_scope_mask(const struct landlock_ruleset *const ruleset,
> > +			const u16 layer_level)
> > +{
> > +	return ruleset->access_masks[layer_level].scoped;
> > +}
> > +
> >  bool landlock_unmask_layers(const struct landlock_rule *const rule,
> >  			    const access_mask_t access_request,
> >  			    layer_mask_t (*const layer_masks)[],
> > diff --git a/security/landlock/syscalls.c b/security/landlock/syscalls.c
> > index 03b470f5a85a..20d2a8b5aa42 100644
> > --- a/security/landlock/syscalls.c
> > +++ b/security/landlock/syscalls.c
> > @@ -97,8 +97,9 @@ static void build_check_abi(void)
> >  	 */
> >  	ruleset_size = sizeof(ruleset_attr.handled_access_fs);
> >  	ruleset_size += sizeof(ruleset_attr.handled_access_net);
> > +	ruleset_size += sizeof(ruleset_attr.scoped);
> >  	BUILD_BUG_ON(sizeof(ruleset_attr) != ruleset_size);
> > -	BUILD_BUG_ON(sizeof(ruleset_attr) != 16);
> > +	BUILD_BUG_ON(sizeof(ruleset_attr) != 24);
> >  
> >  	path_beneath_size = sizeof(path_beneath_attr.allowed_access);
> >  	path_beneath_size += sizeof(path_beneath_attr.parent_fd);
> > @@ -149,7 +150,7 @@ static const struct file_operations ruleset_fops = {
> >  	.write = fop_dummy_write,
> >  };
> >  
> > -#define LANDLOCK_ABI_VERSION 5
> > +#define LANDLOCK_ABI_VERSION 6
> >  
> >  /**
> >   * sys_landlock_create_ruleset - Create a new ruleset
> > @@ -170,8 +171,9 @@ static const struct file_operations ruleset_fops = {
> >   * Possible returned errors are:
> >   *
> >   * - %EOPNOTSUPP: Landlock is supported by the kernel but disabled at boot time;
> > - * - %EINVAL: unknown @flags, or unknown access, or too small @size;
> > - * - %E2BIG or %EFAULT: @attr or @size inconsistencies;
> > + * - %EINVAL: unknown @flags, or unknown access, or unknown scope, or too small @size;
> > + * - %E2BIG: @attr or @size inconsistencies;
> > + * - %EFAULT: @attr or @size inconsistencies;
> >   * - %ENOMSG: empty &landlock_ruleset_attr.handled_access_fs.
> >   */
> >  SYSCALL_DEFINE3(landlock_create_ruleset,
> > @@ -213,9 +215,14 @@ SYSCALL_DEFINE3(landlock_create_ruleset,
> >  	    LANDLOCK_MASK_ACCESS_NET)
> >  		return -EINVAL;
> >  
> > +	/* Checks IPC scoping content (and 32-bits cast). */
> > +	if ((ruleset_attr.scoped | LANDLOCK_MASK_SCOPE) != LANDLOCK_MASK_SCOPE)
> > +		return -EINVAL;
> 
> A test should check that, similarly to
> layout0.ruleset_with_unknown_access, which should be updated for the
> signal patch series too.  You can put this test in a dedicated
> scoped_test.c file because it would be common to all scoped restrictions
> 
> > +
> >  	/* Checks arguments and transforms to kernel struct. */
> >  	ruleset = landlock_create_ruleset(ruleset_attr.handled_access_fs,
> > -					  ruleset_attr.handled_access_net);
> > +					  ruleset_attr.handled_access_net,
> > +					  ruleset_attr.scoped);
> >  	if (IS_ERR(ruleset))
> >  		return PTR_ERR(ruleset);
> >  
> > diff --git a/security/landlock/task.c b/security/landlock/task.c
> > index 849f5123610b..a461923c0571 100644
> > --- a/security/landlock/task.c
> > +++ b/security/landlock/task.c
> > @@ -13,6 +13,8 @@
> >  #include <linux/lsm_hooks.h>
> >  #include <linux/rcupdate.h>
> >  #include <linux/sched.h>
> > +#include <net/af_unix.h>
> > +#include <net/sock.h>
> >  
> >  #include "common.h"
> >  #include "cred.h"
> > @@ -108,9 +110,136 @@ static int hook_ptrace_traceme(struct task_struct *const parent)
> >  	return task_ptrace(parent, current);
> >  }
> >  
> > +/**
> > + * domain_is_scoped - Checks if the client domain is scoped in the same
> > + *			domain as the server.
> > + *
> > + * @client: IPC sender domain.
> > + * @server: IPC receiver domain.
> > + *
> > + * Return true if the @client domain is scoped to access the @server,
> > + * unless the @server is also scoped in the same domain as @client.
> > + */
> > +static bool domain_is_scoped(const struct landlock_ruleset *const client,
> > +			     const struct landlock_ruleset *const server,
> > +			     access_mask_t scope)
> > +{
> > +	int client_layer, server_layer;
> > +	struct landlock_hierarchy *client_walker, *server_walker;
> > +
> > +	/* Quick return if client has no domain */
> > +	if (WARN_ON_ONCE(!client))
> > +		return false;
> > +
> > +	client_layer = client->num_layers - 1;
> > +	client_walker = client->hierarchy;
> > +	/*
> > +	 * client_layer must be a signed integer with greater capacity
> > +	 * than client->num_layers to ensure the following loop stops.
> > +	 */
> > +	BUILD_BUG_ON(sizeof(client_layer) > sizeof(client->num_layers));
> > +
> > +	server_layer = server ? (server->num_layers - 1) : -1;
> > +	server_walker = server ? server->hierarchy : NULL;
> > +
> > +	/*
> > +	 * Walks client's parent domains down to the same hierarchy level
> > +	 * as the server's domain, and checks that none of these client's
> > +	 * parent domains are scoped.
> > +	 */
> > +	for (; client_layer > server_layer; client_layer--) {
> > +		if (landlock_get_scope_mask(client, client_layer) & scope)
> > +			return true;
> > +		client_walker = client_walker->parent;
> > +	}
> > +	/*
> > +	 * Walks server's parent domains down to the same hierarchy level as
> > +	 * the client's domain.
> > +	 */
> > +	for (; server_layer > client_layer; server_layer--)
> > +		server_walker = server_walker->parent;
> > +
> > +	for (; client_layer >= 0; client_layer--) {
> > +		if (landlock_get_scope_mask(client, client_layer) & scope) {
> > +			/*
> > +			 * Client and server are at the same level in the
> > +			 * hierarchy. If the client is scoped, the request is
> > +			 * only allowed if this domain is also a server's
> > +			 * ancestor.
> > +			 */
> > +			return server_walker != client_walker;
> > +		}
> > +		client_walker = client_walker->parent;
> > +		server_walker = server_walker->parent;
> > +	}
> > +	return false;
> > +}
> > +
> > +static bool sock_is_scoped(struct sock *const other,
> > +			   const struct landlock_ruleset *const dom)
> > +{
> > +	const struct landlock_ruleset *dom_other;
> > +
> > +	/* the credentials will not change */
> > +	lockdep_assert_held(&unix_sk(other)->lock);
> > +	dom_other = landlock_cred(other->sk_socket->file->f_cred)->domain;
> > +	return domain_is_scoped(dom, dom_other,
> > +				LANDLOCK_SCOPED_ABSTRACT_UNIX_SOCKET);
> > +}
> > +
> > +static bool is_abstract_socket(struct sock *const sock)
> > +{
> > +	struct unix_address *addr = unix_sk(sock)->addr;
> > +
> > +	if (!addr)
> > +		return false;
> > +
> > +	if (addr->len >= offsetof(struct sockaddr_un, sun_path) + 1 &&
> > +	    addr->name[0].sun_path[0] == '\0')
> > +		return true;
> 
> We don't check for invalid addr values but that's OK because
> unix_validate_addr() was called before the hooks, and we don't need to
> handle -EINVAL.
> 
> However, we should have test that creates a socketpair in a parent
> process, and check that the scoped child process can still connect (with
> a stream one, and send data with a datagram one) to this socket because
> it is not tied to an abstract unix address.  I think the kernel code
I think we have covered this case for stream sockets in
pathname_address_format test (I will add the case for dgram as well).
> should not need any change, but otherwise unix_may_send() should help.
> Anyway, I'd like a comment explaining why we don't need the same checks
> as unix_may_send().
I did not fully understand this part, can you please explain what do you
mean by same checks?

> I'm also worried that a connected socket on which we send data with
> sendto() (with NULL and 0) could be denied, which would not be correct.
> I think this is OK because security_unix_may_send() is only called by
> unix_dgram_sendmsg() and unix_dgram_connect(), and unix_stream_sendmsg()
> doesn't call any hook.  Please add a test to prove this.
Correct. The security_unix_may_send() is only used by the dgram sockets,
and because it is not a connected connection, every time it tries to
send a packet, it will check if it has permission to send a packet
(which is not the case for connected sockets.) I can add a test where
the process is scoped in the middle of the connection, so the stream
connection should still be connected, but the dgram connection should
fail to send a packet. Is this the type of test case you had in mind?
> > +
> > +	return false;
> > +}
> > +
> > +static int hook_unix_stream_connect(struct sock *const sock,
> > +				    struct sock *const other,
> > +				    struct sock *const newsk)
> > +{
> > +	const struct landlock_ruleset *const dom =
> > +		landlock_get_current_domain();
> > +
> > +	/* quick return for non-sandboxed processes */
> > +	if (!dom)
> > +		return 0;
> > +
> > +	if (is_abstract_socket(other))
> > +		if (sock_is_scoped(other, dom))
> > +			return -EPERM;
> > +
> > +	return 0;
> > +}
> > +
> > +static int hook_unix_may_send(struct socket *const sock,
> > +			      struct socket *const other)
> > +{
> > +	const struct landlock_ruleset *const dom =
> > +		landlock_get_current_domain();
> > +
> > +	if (!dom)
> > +		return 0;
> > +
> > +	if (is_abstract_socket(other->sk))
> > +		if (sock_is_scoped(other->sk, dom))
> > +			return -EPERM;
> > +
> > +	return 0;
> > +}
> > +
> >  static struct security_hook_list landlock_hooks[] __ro_after_init = {
> >  	LSM_HOOK_INIT(ptrace_access_check, hook_ptrace_access_check),
> >  	LSM_HOOK_INIT(ptrace_traceme, hook_ptrace_traceme),
> > +	LSM_HOOK_INIT(unix_stream_connect, hook_unix_stream_connect),
> > +	LSM_HOOK_INIT(unix_may_send, hook_unix_may_send),
> >  };
> >  
> >  __init void landlock_add_task_hooks(void)
> > -- 
> > 2.34.1
> > 
> > 

