Return-Path: <netdev+bounces-250327-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B1ABAD28D18
	for <lists+netdev@lfdr.de>; Thu, 15 Jan 2026 22:46:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 581B1309C38A
	for <lists+netdev@lfdr.de>; Thu, 15 Jan 2026 21:46:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7285C30DD13;
	Thu, 15 Jan 2026 21:46:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="Xu9dwnvE"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB589327C12
	for <netdev@vger.kernel.org>; Thu, 15 Jan 2026 21:46:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768513576; cv=pass; b=NmDEfeesr/8YZanY96IrRHzW+8ElICXV3cSGFrOQv+8r3gkh1oVf2CplFrQHYrp18HjvHyl15yTMb6Qao/Zmajnd+KkfUM4uN2k7CVggt2RXIL5qp+mdnphy184aY2Jxxt1at4YeK5K4tVwPfwy96hLxj0Y4jTrbNo8WofNTj7c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768513576; c=relaxed/simple;
	bh=wCltqn8/Hl8G0vgjRc710cwschMrkh2GOvzpWxuuG24=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=o40Rk/6U2nLUAyUlHHG+y408zV8tjCNQBEZ6Fz3TFmsRBDpQCDaFfugCKtRMzK4dsMkn/tQW7sUFNIaHI8kd6V7eQBsAAgK+trUkRNKp8PKMt2LhLnTM8LdfoSYKuNwlYWzt6wQWUzCKiGCvHGcysRC/rgSR+GQylc7tqTH2sEk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=Xu9dwnvE; arc=pass smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-34cf1e31f85so690280a91.1
        for <netdev@vger.kernel.org>; Thu, 15 Jan 2026 13:46:14 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768513574; cv=none;
        d=google.com; s=arc-20240605;
        b=V0TpSea4Mk4zP68vgSw6vF2bCFhvl0BuneSXIX8HPWW/tL0LldlWHhpfS1wM6srPnj
         Aj4phUKP6hB2qzXZrg1K1Piz0Jig5K4aw5ji80jzyZCoBKbT4KSedWsiJAqXMDU3FI6S
         8C5yMaK28jRdq6jt1OLujV7q3XYa2KposBUycN4F6eT9Q5r/FR5bAO3HespKc26vZxnO
         +5T1xbQtXg8F3Ju8bJ1bkvmsSetaAwSvyVWDgGWu+LK9brCp7SFL5XqJg6LPMv2UBYnj
         ZkIcGhwYh2uBHbiLHRGcpDxkQcPKur1Q4tMyqzcbgkwaUA2B57mwfD5dWMDHIW/cyypJ
         yIIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=jpqW6jUC08Agms46wNEL22NM+f7LJMOeXvVcL3y7MTU=;
        fh=+mJeMhymemQRnA2tGB/L3QqGoBN1DIEBDSo8mJ6GBnU=;
        b=idUAU88eH7cv60of1p4RhH8u4hB6pWqPDFC/y3oMQWGVi+j4jGi7kZfJFVslneC2IP
         c8DJIglD3bUCR+9JjKaYRAHtGPp6+zmZuDEXr1Oam8XisM2JQPucil0ca91ZgNfwT/Qz
         Ypdr3f/gSau1kJO/Nq8atPNADCP1aFZCzcyMtbF3VEHTXyr0WpgrKK0PU45wJHndg9OE
         680eI/XX4Dsv++nbmZ1S9O00dYkpO7KYmT26j5U5l1yZK6WgeH5Zod+BlqiDjsPwhVU7
         UQXotc80F+9jWDGz8r6WINF31S+8hbiBMS6VIkAY2FnKjeOZvPtWy5Nxz6YPPgM47PRy
         4HUQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1768513574; x=1769118374; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jpqW6jUC08Agms46wNEL22NM+f7LJMOeXvVcL3y7MTU=;
        b=Xu9dwnvEArMkb5bE+rpzG8QjcmUEzo53cgb8pekpYWZJY5SZHZ8tTCY+wPohgfo7tp
         PQz0BVixmrmuDpSs6Yt8fQVuXKJeZgVyPRv8kkdtqeTsn4U8OVQCNS23cjqHCVbKrMFU
         PUlE8hIn4qWyIBrAm6pSwnTVW8odL4BeENxB0mptBVFfsfYlzuF4s+b+TUo1wPjhKnXA
         nydwEHq/1dVpD4NmdfkwI9GsJfxg3GZNJE9XqPPLA+pMpUklCJEBF426CLPBFE/lFheo
         L2YE/twEQFlmZESpbGEQMJ8qd/19rsyi3l8bja961RqnwKIa9xpXSIc9uuCxSjIB/lEx
         MBpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768513574; x=1769118374;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=jpqW6jUC08Agms46wNEL22NM+f7LJMOeXvVcL3y7MTU=;
        b=DQ6eFckqGKLs40L4HcKNUnyAIUnumL1ea05G0oEuAj3zCuelz3Hj4l02+TYQYdVnZB
         jzmlsE2z349hmP5X5u0DKxbG13NPwcubxGkTXWF9kVRs54I1PYNND0zB33JHmo1zw9HU
         PNEu7ETFmuEFWImkYxqcMA7aaOjbtz0rwy4jeD3s7tQZqBN/Ki3HDFhTEo556ALIf8a+
         TjOqRK300NkfiBzLvR52ebxnwWTn28ALUWCkJLoouAm0uwNzgclXZwmojsFNqsu5JCn0
         fMDy84yMqLqnoaC0R4JAtem79ewN1HRF4CqrUgeYG+NT/+VM/j3pJ0pjc1jFH3YD3uzp
         NMAQ==
X-Forwarded-Encrypted: i=1; AJvYcCUBswoIWJlcPApoZYVh1FcGoUxWGAn0qXOz9MBCfEd0WA485SBwr/BKjgvd5aAJHzPXGd8OUzQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzxa+b3cbqnhJDj7begHqp0gH02jus6vPuSQ5wiwVhh2P183szc
	ERoRJZNsBH6leDzx5ez0vJ5k4bNNmhj6DftLw6ChRTlEY75nczUGjVal1K/uVd7yZv/mbzzDD97
	c8w4T5uJ5pcnGtkybm78ukJsQds8CqdujzLP4uE1v
X-Gm-Gg: AY/fxX5bqkV9lZ4SnAeI2G007eCEbjO6JfM0ErnTJv2jeg/CPQoracmbbA2NvCOJej3
	A9YzyawgtV7jqd+P+h/DzvtnrOLzVn0h0E9Skv4CcaZRgYf7MmBc/y9Qj+wqMys5U+Gi5Yov8ta
	nPFpV9T+seHG8It2hVAnVslsZ3PR05Sjx4/rnOr3mGnelJ6hklVCzLSJ2w5TsqsbUcfgcNArHWN
	+gEmJ6bSYrd88t/I+djfp+j0pNQqNDSMMguDJtnQ8XtxQLAXdPKxRprKQD3fz45I8vYxvA=
X-Received: by 2002:a17:90b:2e8b:b0:34a:a1dd:1f2a with SMTP id
 98e67ed59e1d1-35272f6cea7mr694689a91.20.1768513574119; Thu, 15 Jan 2026
 13:46:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260110143300.71048-2-gnoack3000@gmail.com> <20260110143300.71048-4-gnoack3000@gmail.com>
 <20260113-kerngesund-etage-86de4a21da24@brauner> <CAHC9VhQOQ096WEZPLo4-57cYkM8c38qzE-F8L3f_cSSB4WadGg@mail.gmail.com>
 <20260115.b5977d57d52d@gnoack.org>
In-Reply-To: <20260115.b5977d57d52d@gnoack.org>
From: Paul Moore <paul@paul-moore.com>
Date: Thu, 15 Jan 2026 16:46:00 -0500
X-Gm-Features: AZwV_QjPNfkUPuGxlKsWJ924hm4lRMsf1wN-yV85wF6ZyiOd4KttUE4QM1-_fwk
Message-ID: <CAHC9VhQHZCe0LMx4xzSo-h1SWY489U4frKYnxu4YVrcJN3x7nA@mail.gmail.com>
Subject: Re: [PATCH v2 1/5] lsm: Add hook unix_path_connect
To: =?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack3000@gmail.com>
Cc: Christian Brauner <brauner@kernel.org>, Justin Suess <utilityemal77@gmail.com>, 
	=?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>, 
	James Morris <jmorris@namei.org>, "Serge E . Hallyn" <serge@hallyn.com>, 
	linux-security-module@vger.kernel.org, Tingmao Wang <m@maowtm.org>, 
	Samasth Norway Ananda <samasth.norway.ananda@oracle.com>, Matthieu Buffet <matthieu@buffet.re>, 
	Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>, konstantin.meskhidze@huawei.com, 
	Demi Marie Obenour <demiobenour@gmail.com>, Alyssa Ross <hi@alyssa.is>, Jann Horn <jannh@google.com>, 
	Tahera Fahimi <fahimitahera@gmail.com>, Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, 
	Alexander Viro <viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 15, 2026 at 5:10=E2=80=AFAM G=C3=BCnther Noack <gnoack3000@gmai=
l.com> wrote:
> On Tue, Jan 13, 2026 at 06:27:15PM -0500, Paul Moore wrote:
> > On Tue, Jan 13, 2026 at 4:34=E2=80=AFAM Christian Brauner <brauner@kern=
el.org> wrote:
> > > On Sat, Jan 10, 2026 at 03:32:57PM +0100, G=C3=BCnther Noack wrote:
> > > > From: Justin Suess <utilityemal77@gmail.com>
> > > >
> > > > Adds an LSM hook unix_path_connect.
> > > >
> > > > This hook is called to check the path of a named unix socket before=
 a
> > > > connection is initiated.
> > > >
> > > > Cc: G=C3=BCnther Noack <gnoack3000@gmail.com>
> > > > Signed-off-by: Justin Suess <utilityemal77@gmail.com>
> > > > ---
> > > >  include/linux/lsm_hook_defs.h |  4 ++++
> > > >  include/linux/security.h      | 11 +++++++++++
> > > >  net/unix/af_unix.c            |  9 +++++++++
> > > >  security/security.c           | 20 ++++++++++++++++++++
> > > >  4 files changed, 44 insertions(+)

...

> On the other side, I see the following drawbacks:
>
> * The more serious surgery in af_unix, which Paul also discussed:

Not to take away from what G=C3=BCnther already mentioned, but my concern
about extending the path beyond the unix_find_bsd() function for the
sake of the LSM is that history has shown that the easiest (this is
very much a relative statement) approach towards acceptance of a new
LSM hook is to keep the addition/patch as small as possible while
still being useful.  Making the addition of a new LSM hook dependent
on significant changes outside of the security/ directory often
results in failure.

> Overall, I am not convinced that using pre-existing hooks is the right
> way and I would prefer the approach where we have a more dedicated LSM
> hook for the path lookup.
>
> Does that seem reasonable?  Let me know what you think.

I believe it's definitely the "path" (sorry) of least resistance.

--=20
paul-moore.com

