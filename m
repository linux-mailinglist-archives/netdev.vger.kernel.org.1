Return-Path: <netdev+bounces-110616-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F33092D758
	for <lists+netdev@lfdr.de>; Wed, 10 Jul 2024 19:20:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3370E1C20FB0
	for <lists+netdev@lfdr.de>; Wed, 10 Jul 2024 17:20:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8724E34545;
	Wed, 10 Jul 2024 17:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZlCDndiS"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB79618FA02;
	Wed, 10 Jul 2024 17:20:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720632049; cv=none; b=WwleNcZHEw1ky0+MFWH//yw2FMLLsQUPBp/y2q4w/gX0wEEmBhfccW9OkGY59fqQDdaEsdv2YMJjg2ne/JJT1kRdZ11rr30Ap1SIAFfWUQEnPSSeFNUptkaMpEHMmJnY6bKKCu5TogEsDPC2oUWWKUeK0trr6eVj8WCLaST70fs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720632049; c=relaxed/simple;
	bh=qRcTcUopRK2xHoEu39uGsBqYKTPXei/IqbG5uKck4zM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bwDHBAUhZdo784v6VqFRrb7w0fZ9VNV67V4WX7IhlVCXbouA8s/KhAgj0EeeFlyGKa8XCeMimNykhI/Ziz6Nlv8fcu2VgpnbUBjHBqcERKXkjYU4sgsu8no+vffitME64B+SbyhkVGozFYyWOG+HdJr/nckGhdDHulczVPylufk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZlCDndiS; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1fa9ecfb321so41588995ad.0;
        Wed, 10 Jul 2024 10:20:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720632047; x=1721236847; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=pcl1f+AK0P8JCKXXKjbHo0YsgLy2QnOimTj9DcDVJYs=;
        b=ZlCDndiSZTJRnQ06WWWS4Kk7VWBtoY6PRy11eeN4tIxTfO9yMtxHHObN10SdbR8uOp
         fqv6dc8x+QsHkmPLMH+Ic4ifZfUhirLRZp/rcyl5UYJ6k4594fQ2OHZKup3xBHE7kei8
         XOBlgAd2RTm3clKtSjm+iMb69gGtzFS3GMGCa+MwTogFiN/hr+uzXCfqQPUfkei0sXpg
         uceVKEYQ81eqc3rYANS7KpCQMCUcS2yo0OFypWySCRQyydv/YCaGpEdtrJ0IEBei8315
         dycGJIMnaF+7YVvcdnIY/y6GO6eK/W7Ac7nW4mYCK6ynMO2f/kX0ed+H45esfjhxeTH8
         L2rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720632047; x=1721236847;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pcl1f+AK0P8JCKXXKjbHo0YsgLy2QnOimTj9DcDVJYs=;
        b=m6IR7nAR8RePNvWwNKW3Di2AGcd1N2kfrXQnDzT3NP07mL9vdna23fHMc+E7EV9/s7
         ExWJUMEL283tPRnHMj8CjQ0SIWsiTVrMoT+APrpwt1sM2RiSODoQvYRmey8Pj5YRA4wA
         alcUrXSuJ2f0ieUp0VZt3WOPg6i39rtszVy6yj2a1qU4FqFnJNaPT/iYitKoQLTLjJOj
         YspHHVsVM4RSK8mhVgIiu7KjP2doi3wsOq/eRpMd65fLzpNjaZZ8jo2gJmycKGH8vvU9
         4MZ7/LUiCriyEq5DKhgz84QSxe48SFH4vPP5zwqZzMhf1xmBMjW/r2qEeN+BLi1wS4D8
         babQ==
X-Forwarded-Encrypted: i=1; AJvYcCX663Cra7aTy4LVuIwvI3sjyvAbXMpGVhCYTUJk43w4P1bH0wbqvwXkEaQ8+e9HY26fFtcWzhctl2n8DwIt+Bz1gZjRlqFPBq1JsYRRNUQhrz6TQvG4aLSfs/BWTpgWMzsiYx6tH52FodV2vTsenDkKnef1XrVW5UJ0+V8ZhgRLoPglnfJLKL//R2wh
X-Gm-Message-State: AOJu0YzHB2r1PvQWGNb14h24P/dhwLw6thMol8XEu+EAwcXJhZS/bOns
	jv4B0RVWE3t1Aj6Qq76if56yEANTH1wbV6hDbhdSAIlD8jLA0Z7G
X-Google-Smtp-Source: AGHT+IGTzt5K2rzfweaEtxiqsl4HgDFZ/lCPOIrLsQV0ScOaq5I5BseMmXfl86hdYqwHj3mGlMJLBg==
X-Received: by 2002:a17:90b:4f8b:b0:2c9:cf1d:1bcc with SMTP id 98e67ed59e1d1-2ca35d386c5mr5149648a91.36.1720632046879;
        Wed, 10 Jul 2024 10:20:46 -0700 (PDT)
Received: from tahera-OptiPlex-5000 ([136.159.49.123])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2ca34e6a7dcsm4101196a91.16.2024.07.10.10.20.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jul 2024 10:20:46 -0700 (PDT)
Date: Wed, 10 Jul 2024 11:20:44 -0600
From: Tahera Fahimi <fahimitahera@gmail.com>
To: =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>
Cc: =?iso-8859-1?Q?G=FCnther?= Noack <gnoack@google.com>,
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Jann Horn <jannh@google.com>, outreachy@lists.linux.dev,
	netdev@vger.kernel.org
Subject: Re: [PATCH v6] landlock: Add abstract unix socket connect restriction
Message-ID: <Zo7C7MUfnPApp0Np@tahera-OptiPlex-5000>
References: <Zn32CYZiu7pY+rdI@tahera-OptiPlex-5000>
 <20240704.uab4aveeYad0@digikod.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240704.uab4aveeYad0@digikod.net>

On Mon, Jul 08, 2024 at 05:35:48PM +0200, Mickaël Salaün wrote:
> Please add a user documentation with the next version.  You can take
> some inspiration in commits that changed
> Documentation/userspace-api/landlock.rst
> 
> You also need to extend samples/landlock/sandboxer.c with this new
> feature.  You might want to use a new environment variable (LL_SCOPED)
> with "a" (for abstract unix socket) as the only valid content.  New kind
> of sopping could add new characters.  I'm not sure this is the most
> ergonomic, but let's go this way unless you have something else in mind.
Thanks for the feedback. 
This will be added in the next patch. 

> All the related patches (kernel change, tests, sample, documentation)
> should be in the same patch series, with a cover letter introducing the
> feature and pointing to the previous versions with links to
> https://lore.kernel.org/r/...
Noted.
> 
> On Thu, Jun 27, 2024 at 05:30:17PM -0600, Tahera Fahimi wrote:
> > Abstract unix sockets are used for local inter-process communications
> > without a filesystem. Currently a sandboxed process can connect to a
> 
> "local inter-process communications independant of the filesystem."
> 
> > socket outside of the sandboxed environment, since Landlock has no
> > restriction for connecting to an abstract socket address. Access to
> > such sockets for a sandboxed process should be scoped the same way
> > ptrace is limited.
> > 
> > Because of compatibility reasons and since landlock should be flexible,
> 
> Landlock

[...]
> > diff --git a/include/uapi/linux/landlock.h b/include/uapi/linux/landlock.h
> > index 68625e728f43..010aaca5b05a 100644
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
> A space is missing.
> 
> > +	 */
> > +	__u64 scoped;
> >  };
> >  
> >  /*
> > @@ -266,4 +272,27 @@ struct landlock_net_port_attr {
> >  #define LANDLOCK_ACCESS_NET_BIND_TCP			(1ULL << 0)
> >  #define LANDLOCK_ACCESS_NET_CONNECT_TCP			(1ULL << 1)
> >  /* clang-format on */
> > +
> > +/**
> > + * DOC: scope
> > + *
> > + * .scoped attribute handles a set of restrictions on kernel IPCs through
> > + * the following flags.
> 
> I think you can remove this sentence.
> 
[...] 
> > diff --git a/security/landlock/task.c b/security/landlock/task.c
> > index 849f5123610b..acc6e0fbc111 100644
> > --- a/security/landlock/task.c
> > +++ b/security/landlock/task.c
> > @@ -13,6 +13,8 @@
> >  #include <linux/lsm_hooks.h>
> >  #include <linux/rcupdate.h>
> >  #include <linux/sched.h>
> > +#include <net/sock.h>
> > +#include <net/af_unix.h>
> >  
> >  #include "common.h"
> >  #include "cred.h"
> > @@ -108,9 +110,69 @@ static int hook_ptrace_traceme(struct task_struct *const parent)
> >  	return task_ptrace(parent, current);
> >  }
> >  
> > +static access_mask_t
> > +get_scoped_accesses(const struct landlock_ruleset *const domain)
> > +{
> > +	access_mask_t access_dom = 0;
> > +	size_t layer_level;
> > +
> > +	for (layer_level = 0; layer_level < domain->num_layers; layer_level++)
> > +		access_dom |= landlock_get_scope_mask(domain, layer_level);
> > +	return access_dom;
> > +}
> > +
> > +static bool sock_is_scoped(struct sock *const other)
> > +{
> > +	const struct landlock_ruleset *dom_other;
> > +	const struct landlock_ruleset *const dom =
> > +		landlock_get_current_domain();
> > +
> > +	/* quick return if there is no domain or .scoped is not set */
> > +	if (!dom || !get_scoped_accesses(dom))
> > +		return true;
> > +
> > +	/* the credentials will not change */
> > +	lockdep_assert_held(&unix_sk(other)->lock);
> > +	if (other->sk_type != SOCK_DGRAM) {
> > +		dom_other = landlock_cred(other->sk_peer_cred)->domain;
> 
> Why using different credentials for connected or not connected sockets?
> We should use the same consistent logic for both:
> other->sk_socket->file->f_cred (the process that created the socket, not
> the one listening).
The aim was to use the process's credential that utilized the socket for
connected sockets, and the process's credential created the socket for
non-connected sockets. However, I will change it and use the same
credential to keep it consistent for both cases. 

> > +	} else {
> > +		dom_other =
> > +			landlock_cred(other->sk_socket->file->f_cred)->domain;
> > +	}
> > +
> > +	if (!dom_other || !get_scoped_accesses(dom_other))
> 
> What if only one layer in dom_other is scoped?
The function `get_scoped_accesses()` cover this. 

> > +		return false;
> > +
> > +	/* other is scoped, they connect if they are in the same domain */
> 
> This doesn't fit with each domain's scoping. It only considers no
> scopping for all domains, or all domains as scopped if any of them is.
> domain_scope_le() needs to be changed to follow each domain's contract.
Noted.

> > +	return domain_scope_le(dom, dom_other);
> > +}
> > +
> > +static int hook_unix_stream_connect(struct sock *const sock,
> > +				    struct sock *const other,
> > +				    struct sock *const newsk)
> > +{
> > +	if (sock_is_scoped(other))
> > +		return 0;
> > +
> > +	return -EPERM;
> > +}
> > +
> > +static int hook_unix_may_send(struct socket *const sock,
> > +			      struct socket *const other)
> > +{
> > +	pr_warn("XXX %s:%d sock->file:%p other->file:%p\n", __func__, __LINE__,
> > +		sock->file, other->file);
> 
> Please remove debug code.
> 
> > +	if (sock_is_scoped(other->sk))
> > +		return 0;
> > +
> > +	return -EPERM;
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

