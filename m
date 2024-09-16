Return-Path: <netdev+bounces-128534-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 38DA097A25A
	for <lists+netdev@lfdr.de>; Mon, 16 Sep 2024 14:32:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B25A21F25D4C
	for <lists+netdev@lfdr.de>; Mon, 16 Sep 2024 12:32:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CAFE146A79;
	Mon, 16 Sep 2024 12:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eHZeGzGa"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CDDE19BBC;
	Mon, 16 Sep 2024 12:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726489953; cv=none; b=OVLkmIPq5rTi33/xHoTNdePN//ZBPPSCYiJyfQaJ0Rd9PB6QGpVwa5Yipx7oL7SXXw5ya5qJBx2TSTJJUR1Ff03cbvMYG2pDn+obzfOYBHia8QuM7QcrDR2IgVEhMPbFGAVN1FkL3/Mg/3uKW4ilYI8I35bip+2sFCgBN6XUEN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726489953; c=relaxed/simple;
	bh=BBZ4oW2A9GpeSP/yb9umtm+fkmRQ9Bjb/uUApp3m0fk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XT4WX5AbpRUkEHXbAynSKXzANt2IZfphGIkdRX9UmRZ1jwBZoWlFKYWll4hQurHHEaY17wEc5sf9wZhWAZOccnnIjhxY75i+m/xquFnASSlfSGafdN0gU1TwLXGjNAVmAdGWBCSBnb4P+ODY1RoYlxtV3uxiJ3CAm3g2Dqe3qCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eHZeGzGa; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-20551eeba95so27507705ad.2;
        Mon, 16 Sep 2024 05:32:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726489951; x=1727094751; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=oykc0XNUZ2U9di3dFTc+iIQRMLcm/D4KvDGsPvtFBVA=;
        b=eHZeGzGadcNQAmCkB+x77UC8Ljzdiwlx90MfafshW3s6CQBs9tPMKvXk7NjgOm27JH
         BsZ19oxcGQiDu0U299g0fcWmSSpm12L4kpCashSdHa5xnLYkCGTm2vZelNkZ7TMQVBKI
         nDZRBAarXeZUBDD/CF8aeFswOxSsHF80tYB0xH9RDQUOCUCjqUZHTHeMUcz82FSf5iGD
         8mmF1G2lYDpjJMFjdkWW7AHD153rc7J9dnSjV0N/tePfdKbpW+1jau7PpHSPKmb0N5j3
         k08JR7qEOa36xHi+YobC54HvuSQpGhnHMC+Llmpl9TtU6L82SolO1eBv8eHDQLeYCzxB
         fH/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726489951; x=1727094751;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oykc0XNUZ2U9di3dFTc+iIQRMLcm/D4KvDGsPvtFBVA=;
        b=L1uihKEHk45NVcABMQ2IgdqJGF/vF1q9gLzb4XBQm7F6zkV+V1HtrUqJ1Q1L3fKuLP
         2HswK7Uz/rU2DkB4raZZuIvF3NIBKZF4Tw2bq/e7T6XzMU0FA2P2AZ4jyMDLMVYq7wmL
         KfXuJGvWKRCKLntkl7bPwtjL3G1tBZUXJ2rJyfzkgfH0fXEvT7XQLs/YdWmu1TlI0lXG
         9GsPH7Py4k3tQlT7egBDfl9nPsq4jvDUgHINwy+Gw1rdNuKODSWUZJVLKq23CBxEIMqQ
         ee+5ct3En6Ro1J3gGDHJyiV/uV+bwX0b8bjlnGAk2PWjXOApNOKHyE1814p1JgtvErJy
         3swg==
X-Forwarded-Encrypted: i=1; AJvYcCU76KQU590tCsEOSTrN9DYtzO7gpID94Y9LA4SvRfC6tKWbLL1KmUN/SF2kogLjOWXpqBV7pxcwLaeGY4U=@vger.kernel.org, AJvYcCV2cdlEqFDyIQWlYzZZwPbTzij+1KM0bGljx4r0YKfMATHB/BHAoqti2YxRDWaAoclQb75ucfPXPWn+zj1uFayP+FciXmeZ@vger.kernel.org, AJvYcCVjdXN/gkhEiKpFAfYT1wD+p/Uz9Y5oRZcWaxJM1Hfii4/F7psUjcqNfUfzNqd2x0Nia3VxVUYZ@vger.kernel.org
X-Gm-Message-State: AOJu0Yzq8XErB0dOnuRqE6bqIyIs8XQixS9Gai6u3/YIiSamS1A9m64f
	ezRBLqMJJsTG5wtJTFujwB5MvObLdbzJRRlQIE0gk2PV0Nz+1QJw
X-Google-Smtp-Source: AGHT+IFts4nnZqQTc5USJdj9JGXLmyuh67enW6i4PHhte5UX080Zn5yVqDdpBBdawrwHK8xCZGfQRQ==
X-Received: by 2002:a17:90b:278b:b0:2cf:c9ab:e747 with SMTP id 98e67ed59e1d1-2dbb9dbd720mr14614413a91.1.1726489950395;
        Mon, 16 Sep 2024 05:32:30 -0700 (PDT)
Received: from tahera-OptiPlex-5000 ([136.159.49.123])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2dbb9cadb0bsm7164027a91.27.2024.09.16.05.32.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Sep 2024 05:32:29 -0700 (PDT)
Date: Mon, 16 Sep 2024 06:32:27 -0600
From: Tahera Fahimi <fahimitahera@gmail.com>
To: =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>
Cc: outreachy@lists.linux.dev, gnoack@google.com, paul@paul-moore.com,
	jmorris@namei.org, serge@hallyn.com,
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
	bjorn3_gh@protonmail.com, jannh@google.com, netdev@vger.kernel.org
Subject: Re: [PATCH v11 1/8] Landlock: Add abstract UNIX socket restriction
Message-ID: <ZuglWy71qvgEhJQ4@tahera-OptiPlex-5000>
References: <cover.1725494372.git.fahimitahera@gmail.com>
 <5f7ad85243b78427242275b93481cfc7c127764b.1725494372.git.fahimitahera@gmail.com>
 <20240913.AmeeLo0aeheD@digikod.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240913.AmeeLo0aeheD@digikod.net>

On Fri, Sep 13, 2024 at 03:32:59PM +0200, Mickaël Salaün wrote:
> On Wed, Sep 04, 2024 at 06:13:55PM -0600, Tahera Fahimi wrote:
> > This patch introduces a new "scoped" attribute to the
> > landlock_ruleset_attr that can specify
> > "LANDLOCK_SCOPED_ABSTRACT_UNIX_SOCKET" to scope abstract UNIX sockets
> > from connecting to a process outside of the same Landlock domain. It
> > implements two hooks, unix_stream_connect and unix_may_send to enforce
> > this restriction.
> > 
> > Closes: https://github.com/landlock-lsm/linux/issues/7
> > Signed-off-by: Tahera Fahimi <fahimitahera@gmail.com>
> > 
> > ---
> > v11:
> > - For a connected abstract datagram socket, the hook_unix_may_send
> >   allows the socket to send a data. (it is treated as a connected stream
> >   socket)
> > - Minor comment revision.
> > v10:
> > - Minor code improvement based on reviews on v9.
> > v9:
> > - Editting inline comments.
> > - Major refactoring in domain_is_scoped() and is_abstract_socket
> > v8:
> > - Code refactoring (improve code readability, renaming variable, etc.)
> >   based on reviews by Mickaël Salaün on version 7.
> > - Adding warn_on_once to check (impossible) inconsistencies.
> > - Adding inline comments.
> > - Adding check_unix_address_format to check if the scoping socket is an
> >   abstract UNIX sockets.
> > v7:
> > - Using socket's file credentials for both connected(STREAM) and
> >   non-connected(DGRAM) sockets.
> > - Adding "domain_sock_scope" instead of the domain scoping mechanism
> >   used in ptrace ensures that if a server's domain is accessible from
> >   the client's domain (where the client is more privileged than the
> >   server), the client can connect to the server in all edge cases.
> > - Removing debug codes.
> > v6:
> > - Removing curr_ruleset from landlock_hierarchy, and switching back to
> >   use the same domain scoping as ptrace.
> > - code clean up.
> > v5:
> > - Renaming "LANDLOCK_*_ACCESS_SCOPE" to "LANDLOCK_*_SCOPE"
> > - Adding curr_ruleset to hierarachy_ruleset structure to have access
> >   from landlock_hierarchy to its respective landlock_ruleset.
> > - Using curr_ruleset to check if a domain is scoped while walking in the
> >   hierarchy of domains.
> > - Modifying inline comments.
> > v4:
> > - Rebased on Günther's Patch:
> >   https://lore.kernel.org/all/20240610082115.1693267-1-gnoack@google.com/
> >   so there is no need for "LANDLOCK_SHIFT_ACCESS_SCOPE", then it is
> >   removed.
> > - Adding get_scope_accesses function to check all scoped access masks in
> >   a ruleset.
> > - Using socket's file credentials instead of credentials stored in
> >   peer_cred for datagram sockets. (see discussion in [1])
> > - Modifying inline comments.
> > V3:
> > - Improving commit description.
> > - Introducing "scoped" attribute to landlock_ruleset_attr for IPC
> >   scoping purpose, and adding related functions.
> > - Changing structure of ruleset based on "scoped".
> > - Removing rcu lock and using unix_sk lock instead.
> > - Introducing scoping for datagram sockets in unix_may_send.
> > V2:
> > - Removing wrapper functions
> > 
> > [1]https://lore.kernel.org/all/20240610.Aifee5ingugh@digikod.net/
> > ---
> >  include/uapi/linux/landlock.h                |  28 ++++
> >  security/landlock/limits.h                   |   3 +
> >  security/landlock/ruleset.c                  |   7 +-
> >  security/landlock/ruleset.h                  |  24 +++-
> >  security/landlock/syscalls.c                 |  17 ++-
> >  security/landlock/task.c                     | 136 +++++++++++++++++++
> >  tools/testing/selftests/landlock/base_test.c |   2 +-
> >  7 files changed, 208 insertions(+), 9 deletions(-)
> > 
> > diff --git a/include/uapi/linux/landlock.h b/include/uapi/linux/landlock.h
> > index 2c8dbc74b955..dfd48d722834 100644
> > --- a/include/uapi/linux/landlock.h
> > +++ b/include/uapi/linux/landlock.h
> > @@ -44,6 +44,12 @@ struct landlock_ruleset_attr {
> >  	 * flags`_).
> >  	 */
> >  	__u64 handled_access_net;
> > +	/**
> > +	 * @scoped: Bitmask of scopes (cf. `Scope flags`_)
> > +	 * restricting a Landlock domain from accessing outside
> > +	 * resources(e.g. IPCs).
> > +	 */
> > +	__u64 scoped;
> >  };
> >  
> >  /*
> > @@ -274,4 +280,26 @@ struct landlock_net_port_attr {
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
> 
> Thinking more about it, it makes more sense to rename it to
> LANDLOCK_SCOPED_ABSTRACT_UNIX_SOCKET (s/SCOPED/SCOPE/) because it
> express a scope (not a "scoped") and it allign with the current
> LANDLOCK_ACCESS_* and other internal variables such as
> LANDLOCK_LAST_SCOPE...
> 
> However, it still makes sense to keep the "scoped" ruleset's field,
> which is pretty similar to the "handled_*" semantic: it describes what
> will be *scoped* by the ruleset.
The proposed changes make sense. They are applied in commit
[0b365024c726277eb73e461849709605d1819977]/next branch, and look good
to me.

> > +/* clang-format on*/
> > +
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

