Return-Path: <netdev+bounces-101722-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E09F78FFDFE
	for <lists+netdev@lfdr.de>; Fri,  7 Jun 2024 10:28:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E3C931C235E5
	for <lists+netdev@lfdr.de>; Fri,  7 Jun 2024 08:28:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54E6515B0FE;
	Fri,  7 Jun 2024 08:28:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="w28Wk+HE"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f73.google.com (mail-ed1-f73.google.com [209.85.208.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 743CB15B0FB
	for <netdev@vger.kernel.org>; Fri,  7 Jun 2024 08:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717748921; cv=none; b=SIAkM/rFD7r5Q4Nu+pZPTL1mE8+e7uYZO8xeaFI8K4PYTpJhc9sHgGymvU5iTx3Ot/4iK5cPLyZ7B2BrXc8gqIUitNfQBIAKwHW1KdArXW59t1HaTja2Maxff/UOXbGoQ36UDfp5U5iRCrObz47bAuyXC+ZBxiodb/arGuEUQ/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717748921; c=relaxed/simple;
	bh=V+84QYm/Gzzg3mgR6rUaepJo0r1Cyl/7Xb7TVgNcpkE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=EmincVcypEJQiAXjjaGLyFg4GpRhXxzbeNPWkFLEAR64pMNoxxrLeqCiFriRfc48JArgShjIOPhhRjdt90RrOmpk19ayHvdK+uwzmTJJrTrFJ/uQPFOAGGLh643d3C+GguEMBz3bRDaQTtkbvA/AOK0b0v22YinHDClxkD8Aoi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--gnoack.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=w28Wk+HE; arc=none smtp.client-ip=209.85.208.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--gnoack.bounces.google.com
Received: by mail-ed1-f73.google.com with SMTP id 4fb4d7f45d1cf-57a1c680aa8so709171a12.0
        for <netdev@vger.kernel.org>; Fri, 07 Jun 2024 01:28:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1717748918; x=1718353718; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6OYdxhgFVrSCAJh5nTESxNjl0nid+o3EXmChjmTXO6g=;
        b=w28Wk+HEgzyF8u9viVfhnWmoYUPrkAgwk6ebJAs5iNh5M/ENf/Vwl/knmWgQlYfm61
         CUrpFvdMssiphHjJC1D4Gxoxt5lZ/qNNzhN6R7kMkYIB6CAAGWAvTD35yoE+1pU1/zd/
         D/Cz7fEVdRBNAQv6ITODOtq0sJzCsoVJszzY/dbHT6Ngwbpoxb+/eFkqfcykiuMXHe5I
         9qHKc+5rvc6hpV+xRu/Oq+0DGQGQEBPl6pBqENkQxDWl9DI/vdcktjOTQj4hzSkyK5xc
         5NZLUoLvbA+nAES7366ZC7UO2Hovh/rkS5LFjlG/nDOAX3a3U3jwjnD3aGzE2zaJRWUY
         VOdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717748918; x=1718353718;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=6OYdxhgFVrSCAJh5nTESxNjl0nid+o3EXmChjmTXO6g=;
        b=g3xuxu1UOaPpZzJXzb3ui+Mb3wX7nx4piqtPgR9YxmuQ1Uo7MroLckadLoZ/4DcTn3
         7DAiOpmZi/OzwWe+KaWxbtgC0Bo1/cjoYjryND3+nkr78HxpZ/lHILpbYI5sbXaOb5W7
         UJVd6gR6tjPW0WSsMstooB/1Ho1n9LkLYCFvGXt9HcLclBn1Amp3PHNiNeu/AbesxGAb
         tq8q71AYFGCGSqXQBsdXu/fkZgJK9ZbfvqGf9Ai67gTJ/nNPpRgJ2UxzbJSe9E83Pp1E
         Ypw+uash1jddj+j7iZ1Xec3W/AixuyNBSgh9ovYiCwBdVALoTqXmN7Mr8UurXRHr5Gpm
         zgtA==
X-Forwarded-Encrypted: i=1; AJvYcCX2huXUdLxSPvsGVknjGzvAWh+NEQv28iH265mLdjBzysyKslwIyrFFe281A9F+XQ1eKNXhmpCJgtv+ikDM4Ekl8uQbTowu
X-Gm-Message-State: AOJu0YxZqb7mE2MrAvCgnHn1VRRPsZCVmG29fJnE0jQ3LD4ZB1IfX4Yg
	kOl3+UuPulot3fFLiCnsZZQG+MTjQXsRhK1kdjXZ0REu++lgSCy2PW0/Xal5fEWze/IzildrHat
	cUA==
X-Google-Smtp-Source: AGHT+IFm6zHQPhNfj9qNWj7inN20qPj6gTlPDrvKVF9RSk0XwJJlfwcUlhrHgql0SwWnOy27kt3jFrT5jRg=
X-Received: from swim.c.googlers.com ([fda3:e722:ac3:cc00:31:98fb:c0a8:1605])
 (user=gnoack job=sendgmr) by 2002:a05:6402:5515:b0:57a:5277:554b with SMTP id
 4fb4d7f45d1cf-57c509a3be6mr1882a12.7.1717748917756; Fri, 07 Jun 2024 01:28:37
 -0700 (PDT)
Date: Fri, 7 Jun 2024 10:28:35 +0200
In-Reply-To: <ZmJJ7lZdQuQop7e5@tahera-OptiPlex-5000>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <ZmJJ7lZdQuQop7e5@tahera-OptiPlex-5000>
Message-ID: <ZmLEoBfHyUR3nKAV@google.com>
Subject: Re: [PATCH v3] landlock: Add abstract unix socket connect restriction
From: "=?utf-8?Q?G=C3=BCnther?= Noack" <gnoack@google.com>
To: Tahera Fahimi <fahimitahera@gmail.com>
Cc: "=?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?=" <mic@digikod.net>, linux-security-module@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Paul Moore <paul@paul-moore.com>, 
	James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, outreachy@lists.linux.dev, 
	Jann Horn <jannh@google.com>, netdev@vger.kernel.org, 
	"=?utf-8?B?QmrDtnJu?= Roy Baron" <bjorn3_gh@protonmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hello Tahera!

Thanks for sending another revision of your patch set!

On Thu, Jun 06, 2024 at 05:44:46PM -0600, Tahera Fahimi wrote:
> Abstract unix sockets are used for local inter-process communications
> without on a filesystem. Currently a sandboxed process can connect to a
> socket outside of the sandboxed environment, since landlock has no
> restriction for connecting to a unix socket in the abstract namespace.
> Access to such sockets for a sandboxed process should be scoped the same
> way ptrace is limited.
>=20
> Because of compatibility reasons and since landlock should be flexible,
> we extend the user space interface by adding a new "scoped" field. This
> field optionally contains a "LANDLOCK_SCOPED_ABSTRACT_UNIX_SOCKET" to
> specify that the ruleset will deny any connection from within the
> sandbox to its parents(i.e. any parent sandbox or non-sandbox processes)
>=20
> Closes: https://github.com/landlock-lsm/linux/issues/7
> Signed-off-by: Tahera Fahimi <fahimitahera@gmail.com>
>=20
> -------
> V3: Added "scoped" field to landlock_ruleset_attr
> V2: Remove wrapper functions
>=20
> -------
> ---
>  include/uapi/linux/landlock.h | 28 +++++++++++++++++++++++
>  security/landlock/limits.h    |  5 ++++
>  security/landlock/ruleset.c   | 15 ++++++++----
>  security/landlock/ruleset.h   | 28 +++++++++++++++++++++--
>  security/landlock/syscalls.c  | 12 +++++++---
>  security/landlock/task.c      | 43 +++++++++++++++++++++++++++++++++++
>  6 files changed, 121 insertions(+), 10 deletions(-)
>=20
> diff --git a/include/uapi/linux/landlock.h b/include/uapi/linux/landlock.=
h
> index 68625e728f43..d887e67dc0ed 100644
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

I have trouble understanding what this docstring means.

If those are "handled" things, shouldn't the name also start with "handled_=
", in
line with the other fields?  Also, I don't see any way to manipulate these
rights with a Landlock rule in this ?

How about:

/**
 * handled_scoped: Bitmask of IPC actions (cf. `Scoped access flags`_)
 * which are confined to only affect the current Landlock domain.
 */
__u64 handled_scoped;

>  };
> =20
>  /*
> @@ -266,4 +272,26 @@ struct landlock_net_port_attr {
>  #define LANDLOCK_ACCESS_NET_BIND_TCP			(1ULL << 0)
>  #define LANDLOCK_ACCESS_NET_CONNECT_TCP			(1ULL << 1)
>  /* clang-format on */
> +
> +/**
> + * DOC: scoped
> + *
> + * Scoped handles a set of restrictions on kernel IPCs.
> + *
> + * Scope access flags

Scoped with a "d"?

> + * ~~~~~~~~~~~~~~~~~~~~
> + *=20
> + * These flags enable to restrict a sandboxed process from a set of
> + * inter-process communications actions. Setting a flag in a landlock
> + * domain will isolate the Landlock domain to forbid connections
> + * to resources outside the domain.
> + *
> + * IPCs with scoped actions:
> + * - %LANDLOCK_SCOPED_ABSTRACT_UNIX_SOCKET: Restrict a sandbox process t=
o
> + *   connect to a process outside of the sandbox domain through abstract
> + *   unix sockets.
> + */
> +/* clang-format off */
> +#define LANDLOCK_SCOPED_ABSTRACT_UNIX_SOCKET		(1ULL << 0)

Should the name of this #define indicate the direction that we are restrict=
ing?
If I understand your documentation correctly, this is about *connecting out=
* of
the current Landlock domain, but incoming connections from more privileged
domains are OK, right?


Also:

Is it intentional that you are both restricting the connection and the send=
ing
with the same flag (security_unix_may_send)?  If an existing Unix Domain So=
cket
gets passed in to a program from the outside (e.g. as stdout), shouldn't it
still be possible that the program enables a Landlock policy and then still
writes to it?  (Does that work?  Am I mis-reading the patch?)

The way that write access is normally checked for other files is at the tim=
e
when you open the file, not during write(), and I believe it would be more =
in
line with that normal "check at open" behaviour if we did the same here?


> diff --git a/security/landlock/limits.h b/security/landlock/limits.h
> index 20fdb5ff3514..7b794b81ef05 100644
> --- a/security/landlock/limits.h
> +++ b/security/landlock/limits.h
> @@ -28,6 +28,11 @@
>  #define LANDLOCK_NUM_ACCESS_NET		__const_hweight64(LANDLOCK_MASK_ACCESS_=
NET)
>  #define LANDLOCK_SHIFT_ACCESS_NET	LANDLOCK_NUM_ACCESS_FS
> =20
> +#define LANDLOCK_LAST_ACCESS_SCOPE       LANDLOCK_SCOPED_ABSTRACT_UNIX_S=
OCKET
> +#define LANDLOCK_MASK_ACCESS_SCOPE	((LANDLOCK_LAST_ACCESS_SCOPE << 1) - =
1)
> +#define LANDLOCK_NUM_ACCESS_SCOPE         __const_hweight64(LANDLOCK_MAS=
K_ACCESS_SCOPE)
> +#define LANDLOCK_SHIFT_ACCESS_SCOPE      LANDLOCK_SHIFT_ACCESS_NET
                                            ^^^^^^^^^^^^^^^^^^^^^^^^^

I believe this #define has the wrong value, and as a consequence, the code
suffers from the same problem as we already had on the other patch set from
Mikhail Ivanov -- see [1] for that discussion.

The LANDLOCK_SHIFT_ACCESS_FOO variable is used for determining the position=
 of
your flag in the access_masks_t type, where all access masks are combined
together in one big bit vector.  If you are defining this the same for _SCO=
PE as
for _NET, I believe that we will start using the same bits in that vector f=
or
both the _NET flags and the _SCOPE flags, and that will manifest in unwante=
d
interactions between the different types of restrictions.  (e.g. you will c=
reate
a policy to restrict _SCOPE, and you will find yourself unable to do some t=
hings
with TCP ports)

Please also see the other thread for more discussions about how we can avoi=
d
such problems in the future.  (This code is easy to get wrong,
apparently... When we don't test what happens across multiple types of
restrictions, everything looks fine.)

[1] https://lore.kernel.org/all/ebd680cc-25d6-ee14-4856-310f5e5e28e4@huawei=
-partners.com/

=E2=80=94G=C3=BCnther


