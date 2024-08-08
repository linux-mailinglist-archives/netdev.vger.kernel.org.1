Return-Path: <netdev+bounces-116640-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF1BA94B47E
	for <lists+netdev@lfdr.de>; Thu,  8 Aug 2024 03:11:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7FE02281F9F
	for <lists+netdev@lfdr.de>; Thu,  8 Aug 2024 01:11:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F32F420E6;
	Thu,  8 Aug 2024 01:11:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bH0nRt2+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E5CA8F6A
	for <netdev@vger.kernel.org>; Thu,  8 Aug 2024 01:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723079494; cv=none; b=uhUX1xN+rub32pJfCMEfk/ST1h/+o0OK/EYccXOPUvqGZ5l17dGe1qi7NZlAKYCNcWwHbFSRnjsLT+MFlNwHnGVoM9g7ExLMPMzQ/aKOJ8LF4AOmIqu4jWsD0Y2DsDJXpV2jZMLrULw/ccWj5NIjb7P+TP14QFBmbEhEGhlx1PY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723079494; c=relaxed/simple;
	bh=iMeBsXr0Kfh01/tBUecXD3Sn6ad+m6SdJ/phGyaDRgs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PjI51pq7gZarurCVBhMMc+WHhQBpNSncZCZXX5ru7Pr7ZastZXIesTY5UeK10cSLAhNczrKkn3Xyv7UAL7PWKzKxnBcouS27//1MYz/jyOaYVSE+ZYWxJ67D1X8UbymoYioHpmrB1r85/wRgh2Vuz/kNaEstER4Y/nyCqt6TJVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bH0nRt2+; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5b9fe5ea355so7626a12.0
        for <netdev@vger.kernel.org>; Wed, 07 Aug 2024 18:11:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723079491; x=1723684291; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xW+hk7BnX0mviU1OSor8umk+3J3UK7ghMIw7kikOTh8=;
        b=bH0nRt2+v/MTuZ3/zevOuZwtQ2vLm07r0/OLsPpIGMfdBOwSNMnUYCO0BZpf9xiuAg
         FJxl3L9UaO4IqdMNIp959K1RH1++ohoAws1vVKv7q1VVtK2j67FgE5di7DHUcm6XbkXb
         OuMFP8eCNqXwR8btt8GlKMW+rg5TRizjo/eMK/SR80l7iM85gwUGbSSlKlW4ja+ne7fJ
         cMnyRtsKtkm+OW8TeQgWmIJZi21dXFjPKUvUiNZMcmzhdVjoD7yZOJF4cBob+VqYJlSQ
         MIfpEBHlHivTHLtnscUW1R6SaAu0OfdGkaKLrwFkClUandLrQgzWJG6zTpag8yWkl2p+
         Os9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723079491; x=1723684291;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xW+hk7BnX0mviU1OSor8umk+3J3UK7ghMIw7kikOTh8=;
        b=pmXw9H/yZCgBRAXwODy0TDNjlQUWG94wEziq2oYHZ63+iTEeZSwN34RwkxPDJVbJaT
         dRZ7PefxMarMrwgEORrnhIydBy7/Pbo86iuUzEnHClQZK2f3uquKnW2rBADjokzDtqUh
         EfJB6ZIcqSDSDn/oCe5KVZFjfyYeJmoKWNmFaX3i3QYWO+xAstDSA1wvkE2PRVjkZhNf
         ghouZSGUNyNUVdX3RbEIVmsrOZtMkvgFcrXK/L2BqMNUlRnnkIW2hLoSBhYS5ProPvyv
         6jU3Jzo4RaL/oI8IVul2SuIBDeBolKQbq01PQOsioPnT43thIcBRkd6yuAwPjOs9CGao
         BT+w==
X-Forwarded-Encrypted: i=1; AJvYcCWL3xzKFgtmiLecQuk46fF7wXbN2TpNQH2rek/klJz+swFRY2UfnLeYy6zaMKt90dmeh4S0+7VVy5BPV+b9fGd32XvwZdeB
X-Gm-Message-State: AOJu0Yzp0An/m32NnHMZum2Opv/MUu3LB5wgH07E8X2MNQLjaq0ZM1lV
	uBpx3bBdaDlTZk7RfLqMdTVB5eIj2ga4mzVLxnUylrvp+UggyuS6F2woRAPAJBHc9M3bzmwlikw
	bssyQMkqULRJlE/W14bxtp71l2DTEDIXJO7Gs
X-Google-Smtp-Source: AGHT+IEJCnzs5/WRwGZRVK9UyW0fQT3xQ8Bs3ROpO7dzhDkETpP4CcGPK/5gf3OtbpGIMWRZlIoHeayZv1sFiACC5gk=
X-Received: by 2002:a05:6402:3587:b0:5aa:19b1:ffc7 with SMTP id
 4fb4d7f45d1cf-5bbaff2fa9fmr108946a12.2.1723079490726; Wed, 07 Aug 2024
 18:11:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1722966592.git.fahimitahera@gmail.com> <49557e48c1904d2966b8aa563215d2e1733dad95.1722966592.git.fahimitahera@gmail.com>
 <CAG48ez3o9fmqz5FkFh3YoJs_jMdtDq=Jjj-qMj7v=CxFROq+Ew@mail.gmail.com>
 <CAG48ez1jufy8iwP=+DDY662veqBdv9VbMxJ69Ohwt8Tns9afOw@mail.gmail.com>
 <20240807.Yee4al2lahCo@digikod.net> <ZrQE+d2b/FWxIPoA@tahera-OptiPlex-5000>
In-Reply-To: <ZrQE+d2b/FWxIPoA@tahera-OptiPlex-5000>
From: Jann Horn <jannh@google.com>
Date: Thu, 8 Aug 2024 03:10:54 +0200
Message-ID: <CAG48ez1q80onUxoDrFFvGmoWzOhjRaXzYpu+e8kNAHzPADvAAg@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] Landlock: Add signal control
To: Tahera Fahimi <fahimitahera@gmail.com>
Cc: =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>, 
	outreachy@lists.linux.dev, gnoack@google.com, paul@paul-moore.com, 
	jmorris@namei.org, serge@hallyn.com, linux-security-module@vger.kernel.org, 
	linux-kernel@vger.kernel.org, bjorn3_gh@protonmail.com, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 8, 2024 at 1:36=E2=80=AFAM Tahera Fahimi <fahimitahera@gmail.co=
m> wrote:
> On Wed, Aug 07, 2024 at 08:16:47PM +0200, Micka=C3=ABl Sala=C3=BCn wrote:
> > On Tue, Aug 06, 2024 at 11:55:27PM +0200, Jann Horn wrote:
> > > On Tue, Aug 6, 2024 at 8:56=E2=80=AFPM Jann Horn <jannh@google.com> w=
rote:
> > > > On Tue, Aug 6, 2024 at 8:11=E2=80=AFPM Tahera Fahimi <fahimitahera@=
gmail.com> wrote:
> > > > > Currently, a sandbox process is not restricted to send a signal
> > > > > (e.g. SIGKILL) to a process outside of the sandbox environment.
> > > > > Ability to sending a signal for a sandboxed process should be
> > > > > scoped the same way abstract unix sockets are scoped. Therefore,
> > > > > we extend "scoped" field in a ruleset with
> > > > > "LANDLOCK_SCOPED_SIGNAL" to specify that a ruleset will deny
> > > > > sending any signal from within a sandbox process to its
> > > > > parent(i.e. any parent sandbox or non-sandboxed procsses).
> > > [...]
> > > > > +       if (is_scoped)
> > > > > +               return 0;
> > > > > +
> > > > > +       return -EPERM;
> > > > > +}
> > > > > +
> > > > > +static int hook_file_send_sigiotask(struct task_struct *tsk,
> > > > > +                                   struct fown_struct *fown, int=
 signum)
> >
> > I was wondering if we should handle this case, but I guess it makes
> > sense to have a consistent policy for all kind of user-triggerable
> > signals.
> >
> > > > > +{
> > > > > +       bool is_scoped;
> > > > > +       const struct landlock_ruleset *dom, *target_dom;
> > > > > +       struct task_struct *result =3D get_pid_task(fown->pid, fo=
wn->pid_type);
> > > >
> > > > I'm not an expert on how the fowner stuff works, but I think this w=
ill
> > > > probably give you "result =3D NULL" if the file owner PID has alrea=
dy
> > > > exited, and then the following landlock_get_task_domain() would
> > > > probably crash? But I'm not entirely sure about how this works.
> > > >
> > > > I think the intended way to use this hook would be to instead use t=
he
> > > > "file_set_fowner" hook to record the owning domain (though the setu=
p
> > > > for that is going to be kind of a pain...), see the Smack and SELin=
ux
> > > > definitions of that hook. Or alternatively maybe it would be even
> > > > nicer to change the fown_struct to record a cred* instead of a uid =
and
> > > > euid and then use the domain from those credentials for this hook..=
.
> > > > I'm not sure which of those would be easier.
> > >
> > > (For what it's worth, I think the first option would probably be
> > > easier to implement and ship for now, since you can basically copy
> > > what Smack and SELinux are already doing in their implementations of
> > > these hooks. I think the second option would theoretically result in
> > > nicer code, but it might require a bit more work, and you'd have to
> > > include the maintainers of the file locking code in the review of suc=
h
> > > refactoring and have them approve those changes. So if you want to ge=
t
> > > this patchset into the kernel quickly, the first option might be
> > > better for now?)
> > >
> >
> > I agree, let's extend landlock_file_security with a new "fown" pointer
> > to a Landlock domain. We'll need to call landlock_get_ruleset() in
> > hook_file_send_sigiotask(), and landlock_put_ruleset() in a new
> > hook_file_free_security().
> I think we should add a new hook (hook_file_set_owner()) to initialize
> the "fown" pointer and call landlock_get_ruleset() in that?

Yeah. Initialize the pointer in the file_set_fowner hook, and read the
pointer in the file_send_sigiotask hook.

Note that in the file_set_fowner hook, you'll probably need to use
both landlock_get_ruleset() (to take a reference on the ruleset you're
storing in the fown pointer) and landlock_put_ruleset() (to drop the
reference to the ruleset that the fown pointer was pointing to
before). And you'll need to use some kind of lock to protect the fown
pointer - either by adding an appropriate lock next to your fown
pointer or by using some appropriate existing lock in "struct file".
Probably it's cleanest to have your own lock for this? (This lock will
have to be something like a spinlock, not a mutex, since you need to
be able to acquire it in the file_set_fowner hook, which runs inside
an RCU read-side critical section, where sleeping is forbidden -
acquiring a mutex can sleep and therefore is forbidden in this
context, acquiring a spinlock can't sleep.)

> If we do not
> have hook_file_set_owner to store domain in "fown", can you please give
> me a hint on where to do that?
> Thanks
> > I would be nice to to replace the redundant informations in fown_struct
> > but that can wait.

