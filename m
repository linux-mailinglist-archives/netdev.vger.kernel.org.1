Return-Path: <netdev+bounces-101963-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A41EF900C8C
	for <lists+netdev@lfdr.de>; Fri,  7 Jun 2024 21:41:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2B5D71F2221A
	for <lists+netdev@lfdr.de>; Fri,  7 Jun 2024 19:41:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8833214D704;
	Fri,  7 Jun 2024 19:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NOF3AI62"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB64A4DA08;
	Fri,  7 Jun 2024 19:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717789304; cv=none; b=b9NNDr2220Y3mZfanadLgykKUcSMMGaQAWY1egGLtc6UCmptCQGWGY+oDWgIVHnCmngRMhfS0IwCie7XcBBmvK0e9y1KJDYdCEtnGpyKqwKNz0PWMPBvtEEDNldm6l2tLUHEOkvdoRGz+1ddI980P1nWmY7WoHNEXxtiKS3wh0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717789304; c=relaxed/simple;
	bh=B5wpoJOAS1yCcn6AHTzXdnnzuJTU6sZuXi+k2Dj9i+Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eFOV5DRGsfb7EpQW6e/NAmNVG3xCcxPeZxrHC6T8+iz9uI3xq1OXs1TArCLR5ZE5A1FV92ILG7DpeaaJJzvdHvamIPDIkRwIqEx2ulaU9w/G3JcV/CwkW/LkLRh2DtOzum79a4polaVmjdmwIYM7j/SfriA2kCIts1u/9gat0hI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NOF3AI62; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1f47f07acd3so23650615ad.0;
        Fri, 07 Jun 2024 12:41:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717789302; x=1718394102; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=RJJyaYN0sPbNug3PyyX1s3PiVD+hYAyOGyOGOym/UzI=;
        b=NOF3AI62XrtyTBIES/6hzDoX3p2n36YH3SG2CBvuMUEtDo8CZkXIvsbcqkTwqMQw1W
         iU1eEk90o7tanzVcv3dFgFAQA57j0qh1TyzafPS2gl7G0itBrIWnM7bBSMXkzPxA0Ej/
         DTQj1olYtfbcNH16IO0q3R0lsT6WlB/v6o2Oi/SOBhpCp9Qhkx3clU558dwJ9QE5h4D+
         iBgnVsALFv2PFIihIZGUZVHq7KaajAUOJU/xIiDSudi/OcLXzN2aurDsBhidJ1Ql6oeK
         +onOGKjbd+DH7BL1tnn8MOEOAf++sueZSgNqVwUJy8AtH4A4xTC0cX6KOyZyqn/o2Ys8
         GyXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717789302; x=1718394102;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RJJyaYN0sPbNug3PyyX1s3PiVD+hYAyOGyOGOym/UzI=;
        b=bPjrYQu2Sv7znyXP9kQ1NMaYZNTpmOFs/JNsr8U4fZ4Mi4rEYk1rY+Pwo/cB5svXGj
         GiAc/7DlbBXIkjcVVKoHK9H/fOpTfdcr6FHa9YtfmjJtQt1uTf2n/15C95HC4ilcHz6g
         MN3plOuaGkER/oSz4zmvFr3hZUmGBsf5FKul+Cuj7nRSPar5w7SMw0SBzWyILQB9H3Nh
         Cl7CnxuLYMHspwb4rXOThEA7aqGb2s0hMNcMKYjcsQbt+Mj0lZNB+l/FJQwWsKv747WG
         kksT0jeXiJxSMch9YL+/9MTG4FI8h271Kz3tSbK12HI0M0wRkQQaIdgGOTrbRChIdZnd
         bKmA==
X-Forwarded-Encrypted: i=1; AJvYcCWfwBc6f5SJ7dogp5Jvj0O9V8Dh6n1gv9dRRyxS/YTUuqIpWb+J97jhEjaMvfZDFtn9SpuTEHzL8H+VUp9xUMkHxxEoskV3vrTox5CBF5yrl2kSQJ9Nvn4vLcpPnwINK4tASrieROBQToZGXELx+bgOr+iHf0K7WkNYdg8gYm9xrVVl02bftdLyP/wh
X-Gm-Message-State: AOJu0Yw0FluOPucJcnmDCDXUsSBAYpZA5QFDzlJRSVAdIzr4A+k8xI7B
	FWL3KYOA/jLDXALA2yvX8q01fL+qBUqABmLS1L43OCSJc4bkAtVa
X-Google-Smtp-Source: AGHT+IGscUbgi37qbqXXc5w7y2H8tq5p/gmvxvvmo71C1+DhTMvyNutUQJaTF7RIefH0R+RKzJ5Hlw==
X-Received: by 2002:a17:903:2445:b0:1f6:70fe:76bf with SMTP id d9443c01a7336-1f6d02d1a99mr41772155ad.14.1717789301946;
        Fri, 07 Jun 2024 12:41:41 -0700 (PDT)
Received: from tahera-OptiPlex-5000 ([136.159.49.123])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f6bd769a2esm38410355ad.66.2024.06.07.12.41.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jun 2024 12:41:41 -0700 (PDT)
Date: Fri, 7 Jun 2024 13:41:39 -0600
From: Tahera Fahimi <fahimitahera@gmail.com>
To: =?iso-8859-1?Q?G=FCnther?= Noack <gnoack@google.com>
Cc: Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Jann Horn <jannh@google.com>, outreachy@lists.linux.dev,
	netdev@vger.kernel.org,
	=?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>
Subject: Re: [PATCH v3] landlock: Add abstract unix socket connect restriction
Message-ID: <ZmNic8S1KtyLcp7i@tahera-OptiPlex-5000>
References: <ZmJJ7lZdQuQop7e5@tahera-OptiPlex-5000>
 <ZmLEoBfHyUR3nKAV@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZmLEoBfHyUR3nKAV@google.com>

On Fri, Jun 07, 2024 at 10:28:35AM +0200, Günther Noack wrote:
> Hello Tahera!
> 
> Thanks for sending another revision of your patch set!
Hello Günther, 
Thanks for your feedback.

> On Thu, Jun 06, 2024 at 05:44:46PM -0600, Tahera Fahimi wrote:
> > Abstract unix sockets are used for local inter-process communications
> > without on a filesystem. Currently a sandboxed process can connect to a
> > socket outside of the sandboxed environment, since landlock has no
> > restriction for connecting to a unix socket in the abstract namespace.
> > Access to such sockets for a sandboxed process should be scoped the same
> > way ptrace is limited.
> > 
> > Because of compatibility reasons and since landlock should be flexible,
> > we extend the user space interface by adding a new "scoped" field. This
> > field optionally contains a "LANDLOCK_SCOPED_ABSTRACT_UNIX_SOCKET" to
> > specify that the ruleset will deny any connection from within the
> > sandbox to its parents(i.e. any parent sandbox or non-sandbox processes)
> > 
> > Closes: https://github.com/landlock-lsm/linux/issues/7
> > Signed-off-by: Tahera Fahimi <fahimitahera@gmail.com>
> > 
> > -------
> > V3: Added "scoped" field to landlock_ruleset_attr
> > V2: Remove wrapper functions
> > 
> > -------
> > ---
> >  include/uapi/linux/landlock.h | 28 +++++++++++++++++++++++
> >  security/landlock/limits.h    |  5 ++++
> >  security/landlock/ruleset.c   | 15 ++++++++----
> >  security/landlock/ruleset.h   | 28 +++++++++++++++++++++--
> >  security/landlock/syscalls.c  | 12 +++++++---
> >  security/landlock/task.c      | 43 +++++++++++++++++++++++++++++++++++
> >  6 files changed, 121 insertions(+), 10 deletions(-)
> > 
> > diff --git a/include/uapi/linux/landlock.h b/include/uapi/linux/landlock.h
> > index 68625e728f43..d887e67dc0ed 100644
> > --- a/include/uapi/linux/landlock.h
> > +++ b/include/uapi/linux/landlock.h
> > @@ -37,6 +37,12 @@ struct landlock_ruleset_attr {
> >  	 * rule explicitly allow them.
> >  	 */
> >  	__u64 handled_access_net;
> > +	/**
> > +	 * scoped: Bitmask of actions (cf. `Scope access flags`_)
> > +	 * that is handled by this ruleset and should be permitted
> > +	 * by default if no rule explicitly deny them.
> > +	 */
> > +	__u64 scoped;
> 
> I have trouble understanding what this docstring means.
> 
> If those are "handled" things, shouldn't the name also start with "handled_", in
> line with the other fields?  Also, I don't see any way to manipulate these
> rights with a Landlock rule in this ?

.scoped attribute is not defined as .handled_scope since there is no
rule to handle/manipulate it, simply because this attribute shows either
action is permitted or denied. 

> How about:
> 
> /**
>  * handled_scoped: Bitmask of IPC actions (cf. `Scoped access flags`_)
>  * which are confined to only affect the current Landlock domain.
>  */

This is a good docstring. I will use it. 

> __u64 handled_scoped;
> 
> >  };
> >  
> >  /*
> > @@ -266,4 +272,26 @@ struct landlock_net_port_attr {
> >  #define LANDLOCK_ACCESS_NET_BIND_TCP			(1ULL << 0)
> >  #define LANDLOCK_ACCESS_NET_CONNECT_TCP			(1ULL << 1)
> >  /* clang-format on */
> > +
> > +/**
> > + * DOC: scoped
> > + *
> > + * Scoped handles a set of restrictions on kernel IPCs.
> > + *
> > + * Scope access flags
> 
> Scoped with a "d"?
Scoped meant to point to .scoped attribute.  
> > + * ~~~~~~~~~~~~~~~~~~~~
> > + * 
> > + * These flags enable to restrict a sandboxed process from a set of
> > + * inter-process communications actions. Setting a flag in a landlock
> > + * domain will isolate the Landlock domain to forbid connections
> > + * to resources outside the domain.
> > + *
> > + * IPCs with scoped actions:
> > + * - %LANDLOCK_SCOPED_ABSTRACT_UNIX_SOCKET: Restrict a sandbox process to
> > + *   connect to a process outside of the sandbox domain through abstract
> > + *   unix sockets.
> > + */
> > +/* clang-format off */
> > +#define LANDLOCK_SCOPED_ABSTRACT_UNIX_SOCKET		(1ULL << 0)
> 
> Should the name of this #define indicate the direction that we are restricting?

Since the domain of a process specifies if a process can connect or not,
the direction of the connection does not matter. This restriction is the
same as ptrace.

> If I understand your documentation correctly, this is about *connecting out* of
> the current Landlock domain, but incoming connections from more privileged
> domains are OK, right?

Yes, Incoming connections are allowed if they are from a higher
privileged domain (or no domain). Consider two process P1 and P2 where
P1 wants to connect to P2. If P1 is not landlocked, it can connect to P2
regardless of whether P2 has a domain. If P1 is landlocked, it must have
an equal or less domain than P2 to connect to P2. We disscussed about
direction in [2]
https://lore.kernel.org/outreachy/20240603.Quaes2eich5f@digikod.net/T/#m6d5c5e65e43eaa1c8c38309f1225d169be3d6f87

> 
> Also:
> 
> Is it intentional that you are both restricting the connection and the sending
> with the same flag (security_unix_may_send)?  If an existing Unix Domain Socket
> gets passed in to a program from the outside (e.g. as stdout), shouldn't it
> still be possible that the program enables a Landlock policy and then still
> writes to it?  (Does that work?  Am I mis-reading the patch?)

security_unix_may_send checks if AF_UNIX socket can send datagrams, so
connecting and sending datagrams happens at the same state. I am not
sure if I understand your example correctly. Can you please explain a
bit more?

> The way that write access is normally checked for other files is at the time
> when you open the file, not during write(), and I believe it would be more in
> line with that normal "check at open" behaviour if we did the same here?

It checks the ability to connect to a unix socket at the point of
connecting, so I think it is aligned with the "check at point"
behaviour. This security check is called right before finalizing the
connection. 

> 
> > diff --git a/security/landlock/limits.h b/security/landlock/limits.h
> > index 20fdb5ff3514..7b794b81ef05 100644
> > --- a/security/landlock/limits.h
> > +++ b/security/landlock/limits.h
> > @@ -28,6 +28,11 @@
> >  #define LANDLOCK_NUM_ACCESS_NET		__const_hweight64(LANDLOCK_MASK_ACCESS_NET)
> >  #define LANDLOCK_SHIFT_ACCESS_NET	LANDLOCK_NUM_ACCESS_FS
> >  
> > +#define LANDLOCK_LAST_ACCESS_SCOPE       LANDLOCK_SCOPED_ABSTRACT_UNIX_SOCKET
> > +#define LANDLOCK_MASK_ACCESS_SCOPE	((LANDLOCK_LAST_ACCESS_SCOPE << 1) - 1)
> > +#define LANDLOCK_NUM_ACCESS_SCOPE         __const_hweight64(LANDLOCK_MASK_ACCESS_SCOPE)
> > +#define LANDLOCK_SHIFT_ACCESS_SCOPE      LANDLOCK_SHIFT_ACCESS_NET
>                                             ^^^^^^^^^^^^^^^^^^^^^^^^^
> 
> I believe this #define has the wrong value, and as a consequence, the code
> suffers from the same problem as we already had on the other patch set from
> Mikhail Ivanov -- see [1] for that discussion.

Thanks for the hint. I will definitly check this. 

> The LANDLOCK_SHIFT_ACCESS_FOO variable is used for determining the position of
> your flag in the access_masks_t type, where all access masks are combined
> together in one big bit vector.  If you are defining this the same for _SCOPE as
> for _NET, I believe that we will start using the same bits in that vector for
> both the _NET flags and the _SCOPE flags, and that will manifest in unwanted
> interactions between the different types of restrictions.  (e.g. you will create
> a policy to restrict _SCOPE, and you will find yourself unable to do some things
> with TCP ports)
> 
> Please also see the other thread for more discussions about how we can avoid
> such problems in the future.  (This code is easy to get wrong,
> apparently... When we don't test what happens across multiple types of
> restrictions, everything looks fine.)
> 
> [1] https://lore.kernel.org/all/ebd680cc-25d6-ee14-4856-310f5e5e28e4@huawei-partners.com/
> 
> —Günther
> 

