Return-Path: <netdev+bounces-247889-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 02D39D00379
	for <lists+netdev@lfdr.de>; Wed, 07 Jan 2026 22:46:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1D2C3303C812
	for <lists+netdev@lfdr.de>; Wed,  7 Jan 2026 21:43:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0625D2EA173;
	Wed,  7 Jan 2026 21:43:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="PvGxBpIx"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC1482E62C6
	for <netdev@vger.kernel.org>; Wed,  7 Jan 2026 21:43:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767822230; cv=none; b=tC+7JgVIOLpXUcnQNW15qLeSZ3bjX2l5OJiksxGlNmi3xLsodjoN159E8Hrrix6AV/hDsl4uRFRHYx+6fEsyNb/oter2UK9RrYssU/U2wicsSu/Jtq/4XFj9EC7rjZpmL2B2fmgxdu7J9pg3N91OHWitXpyE8W3uZ+Irrgl5FKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767822230; c=relaxed/simple;
	bh=oPX8WC0khXlRSxRk6co6iZtm9CKQ99X3PYw+4T/T8zo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HlYv8tzAX7vyFtkPTUMxSSVXLxUI1TpnSa4s52YNuVcFbENy6S/CCmhvj9klV56bzbvePld+NbQxJ8Os8n1JTmGwRh7ejlsh/3QyxJDmUjMyN+G0m7LYN0PrgnTFbF/S23uCpbF7idQeIiDNlRkD7VLjSp6Id6IMpRvf0y7/sMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=PvGxBpIx; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-34c565c3673so600261a91.0
        for <netdev@vger.kernel.org>; Wed, 07 Jan 2026 13:43:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1767822225; x=1768427025; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e77yQyAw1MVVvjefm5EFz/r+8dtWPsocGN7afrJ3Dyc=;
        b=PvGxBpIxA6h2fvVVXXqqKYhrsH+3ANdtHgERUvozVjOuCx7Rg/qQohluW+++GqpwbP
         jWxKLMpjFvziu1EwbjYh418dk5XUl+duRyrlyyRKoSZUVcRnXwUU62p/e3bt5VFSRcBr
         r5LtVR+8w3qf8SxW1NKOeqMvJbp0bMGQmPiooBlYJHUblFnMVaS+FKD6EaTp0KmfDrqa
         q8Ff6g4LtHKg47XGVY64FCxlAwdt85H0IMxWQ/AY0oS2qfDnqBE7BtQN7St662nhw2GL
         hCaQBsMEs6dJyr4AGpFf98TUGU32B4QdHgk3v8p+qEHaFZokWFLFq5zHFO4vCmWWor0Q
         2SbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767822225; x=1768427025;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=e77yQyAw1MVVvjefm5EFz/r+8dtWPsocGN7afrJ3Dyc=;
        b=UQuRrWRSHWJe9HGslto0PKbCPQ5w647J/Hl2CWx324/MCZ/PPE881jIqXN9i4RsT2I
         9FqL/Q5us9O/nrEZn+pX473DiyXD6DyepxIOP26+QGDZRlVsZC13mDdYe4e6xwxuLbdE
         +3fwjE1xiimaMln7gsZaghHmt7xsvDsuBHuFjRR+e4Uh0ggGmrPh69V/KG++wwLEqqDk
         O7GIz5R1dKqeGYIBnaOXqwPevmPQZDjvRK71vgMgeWIIKWAvYDvvXkQg8DCt+CVupBFj
         jUn8m2u4U2jDMFFWa9ogDwCbHw5eeqCekIDfe5GH6BwL005N8BI99qpOXeFKnwSS1hk8
         kFPw==
X-Forwarded-Encrypted: i=1; AJvYcCXHIh/MJEU5dsD7fqOeIZmx1PBTHOLC5QbiTJIMNWjyIPHbOcpoSakN8olZ0KcZnBzKMnznUoQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8BNajzajnKsvLWw5OnqarMTWd9MhqdFmAoBhRx58LfbDULbb7
	5WEClMLEkn7EBEWqZZai7xP7DyzNuoPL+vOdVUZ3xfYDrRBD/kpqTvvkUt5WMfzGBzCnM3zjPP2
	tL+53IA3n0KStBuOg8x0yEK8APKpWtspt/8/+ey2U
X-Gm-Gg: AY/fxX5hUXSlpesbaT+siYnukSrwYjF4xUvK6GP3AfiKKZAD0OUKdpRIJkG55OC9ED8
	8oCLZDAvD2mQuRuURr0lqMjEimLm3kGQQL+D+Ba0UmEKvDp7tqmdoNURQciTvNdwHvVBzNkpfNJ
	7HXL5rXKyNSCjHRhJi5efWvwqMzSADGKBT5Dery0VPOyrLL3zI3sjEb72p7DoJbLdLquU82vG9R
	j+8lFo6ZsJgqMoxo9ZoBEENGTLEqaxm59Gz0yR+kwis1LTa7LhUNnLUJPY0vGeKEOFZcZw=
X-Google-Smtp-Source: AGHT+IEathxfn7upCeIJMulzVmZ+e1fE6uIUQmRv1edLX1SRNagEQbVFk7h9kV77Y4T/hAnb47hz55ycTT1gohwEaGk=
X-Received: by 2002:a17:90b:2dca:b0:34c:2f01:2262 with SMTP id
 98e67ed59e1d1-34f5f831c80mr6124632a91.3.1767822225568; Wed, 07 Jan 2026
 13:43:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260101.f6d0f71ca9bb@gnoack.org> <20260101194551.4017198-1-utilityemal77@gmail.com>
In-Reply-To: <20260101194551.4017198-1-utilityemal77@gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 7 Jan 2026 16:43:33 -0500
X-Gm-Features: AQt7F2o7xku2xhldp3g03NR8PmdBs1HeZm0dsE0__ArgjxjiqElz5mgVs9Jrc3s
Message-ID: <CAHC9VhQ234xihpndTs4e5ToNJ3tGCsP7AVtXuz8GajG-_jn3Ow@mail.gmail.com>
Subject: Re: [RFC PATCH 0/1] lsm: Add hook unix_path_connect
To: Justin Suess <utilityemal77@gmail.com>
Cc: gnoack3000@gmail.com, gnoack@google.com, horms@kernel.org, 
	jmorris@namei.org, kuniyu@google.com, linux-security-module@vger.kernel.org, 
	m@maowtm.org, mic@digikod.net, netdev@vger.kernel.org, serge@hallyn.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 1, 2026 at 2:45=E2=80=AFPM Justin Suess <utilityemal77@gmail.co=
m> wrote:
> On 1/1/26 07:13, G=C3=BCnther Noack wrote:
> > On Wed, Dec 31, 2025 at 04:33:14PM -0500, Justin Suess wrote:
> >> Adds an LSM hook unix_path_connect.
> >>
> >> This hook is called to check the path of a named unix socket before a
> >> connection is initiated.
> >>
> >> Signed-off-by: Justin Suess <utilityemal77@gmail.com>
> >> Cc: G=C3=BCnther Noack <gnoack3000@gmail.com>
> >> ---
> >>  include/linux/lsm_hook_defs.h |  1 +
> >>  include/linux/security.h      |  6 ++++++
> >>  net/unix/af_unix.c            |  8 ++++++++
> >>  security/security.c           | 16 ++++++++++++++++
> >>  4 files changed, 31 insertions(+)

...

> >> diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
> >> index 55cdebfa0da0..af1a6083a69b 100644
> >> --- a/net/unix/af_unix.c
> >> +++ b/net/unix/af_unix.c
> >> @@ -1226,6 +1226,14 @@ static struct sock *unix_find_bsd(struct sockad=
dr_un *sunaddr, int addr_len,
> >>      if (!S_ISSOCK(inode->i_mode))
> >>              goto path_put;
> >>
> >> +    /*
> >> +     * We call the hook because we know that the inode is a socket
> >> +     * and we hold a valid reference to it via the path.
> >> +     */
> >> +    err =3D security_unix_path_connect(&path);
> >> +    if (err)
> >> +            goto path_put;
> >
> > In this place, the hook call is done also for the coredump socket.
> >
> > The coredump socket is a system-wide setting, and it feels weird to me
> > that unprivileged processes should be able to inhibit that connection?
>
> No I don't think they should be able to. Does this look better?

Expect more comments on this patch, but this is important enough that
I wanted to reply separately.

As a reminder, we do have guidance regarding the addition of new LSM
hooks, there is a pointer to the document in MAINTAINERS, but here is
a direct link to the relevant section:

https://github.com/LinuxSecurityModule/kernel/blob/main/README.md#new-lsm-h=
ooks

The guidance has three bullet points, the first, and perhaps most
important, states:

  "Hooks should be designed to be LSM agnostic. While it is possible
   that only one LSM might implement the hook at the time of submission,
   the hook's behavior should be generic enough that other LSMs could
   provide a meaningful implementation."

This is one of the reasons why we generally don't make the LSM hook
calls conditional on kernel state outside of the LSM, e.g.
SOCK_COREDUMP.  While Landlock may not want to implement any access
controls on a SOCK_COREDUMP socket, it's entirely possible that
another LSM which doesn't have untrusted processes defining security
policy may want to use this as a point of access control or
visibility/auditing.  Further, I think it would be a good idea to also
pass the @type and @flags parameter to the hook; at the very least
Landlock would need the flags parameter to check for SOCK_COREDUMP.

--=20
paul-moore.com

