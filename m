Return-Path: <netdev+bounces-116894-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D092B94C01C
	for <lists+netdev@lfdr.de>; Thu,  8 Aug 2024 16:48:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F41821C20CBF
	for <lists+netdev@lfdr.de>; Thu,  8 Aug 2024 14:48:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D53B7194C86;
	Thu,  8 Aug 2024 14:43:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="C2cukYGr"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC18718F2E4
	for <netdev@vger.kernel.org>; Thu,  8 Aug 2024 14:43:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723128189; cv=none; b=E4Psr/Gma9WxvPLhFspGUIPPHi/6v8PjUkYbtvztVlz4sgrt8papZmUzEJOGsG2328kF/vPCCmEDC7BPUOJHy5C81SH6EF36DTJcnhLhctp1L1Putf4uRG9neOoxTFG0ktWtL9FMYKM77Z4rmgMeCj8Z9ihmhzmjwqQ8KsXumz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723128189; c=relaxed/simple;
	bh=CpyPIfmg2EOV5lm10X09DdprNvHp+c04WoWWsktaYwo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KWDciptlQQkwA4mR4U/2azfEbmHGdfhb9dkTYs2eUKQyi7pSVGd8CsFYEFuaXNJXvoP8r4ACGq2/DaBiqCF/B10QozFPd8e981lgQA0/NlVhuTw3bnHeNqMj4D5w7KtwkFrleBGv/k08aFhf9UkE7fvqGnmbsYQp5NRxjYPYp5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=C2cukYGr; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5a28b61b880so13150a12.1
        for <netdev@vger.kernel.org>; Thu, 08 Aug 2024 07:43:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723128186; x=1723732986; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tZyTYu0gD8jaqjYXDRXpABZ3qkjjNiX2tLIzLn8qXHk=;
        b=C2cukYGr7CqLSteuVzZER69dPNgOBgrVWghaE3KyAs4zMq7RnOSbGxOyG/JU5C4cp5
         8fUfy+jYW0vIqYkgm+TCdveSDCvFJVB62xZMZFVATFPV19sLYFwVHqIz/FcopZD+E/bj
         L3G6V1vhey+y5y1i/AGmMbEqmaTpnTGWk7cysdqjB7avK+yJKKkv7s2Pv1IXlyRVnF5X
         k2xBx3YxdAf7q06+SZzSNoQgIpg8e3L/rx2i+eIlmH4XxJGu2D8+wx5kuivCGotbA5UZ
         WUXAQTJHuEtsfkpGt9Jy1mDq2b6477rY8xmRLosrpu1tz/ahy6Q3j3FroEpkQ1q+fj9S
         lfBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723128186; x=1723732986;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tZyTYu0gD8jaqjYXDRXpABZ3qkjjNiX2tLIzLn8qXHk=;
        b=ZtU0s5PH/ZFT1qksVwrZtQQBgPkbHj3y00+E68CP1KNusmsi53hl83cmkXv/cayTf1
         gz6djG5YNgRspnZps3HZMdaYbP3AJulSJBiXSDV1mQRoEZ/UFAfF+qcpaS7OCLOVjTn5
         a54Tjjzy/f4kjuezbg+u//jDtrE6xaxe7pgYAbmTlLUdSF+jtEiHS4ZDBWVESIavg/C+
         gKzF0hbbFqfH0a1NHOlqdR9ZRT9EdrHTcQwOWB5z5ucmSZtKjnh57fYxAWlrrZSpYf+f
         YsGa3QrP5LfuSAqjtop3mNqYp9Hs85blfY01sffxQue1ytVY6XmHks1/f4KMf/Fgugfz
         3BWA==
X-Forwarded-Encrypted: i=1; AJvYcCWswgPASljUkL4+0w0Il/AfCwEZf+c5Xssc1h2MYHFMFDPbjYyxDqbyIv+5A/bBwdLdzu0iC/koo8pn3OOaWVE6xsDEJmSu
X-Gm-Message-State: AOJu0YymsPpb4y2jfLOefKW3G6JcfWqxFLZbqefJtdn7x0rJoJczeRi+
	ag7vDT7CkuAtLAuIp/XDT0NoATD12iL/Ypg7aBeRSTSXquiu4VD/2Sf1KHETXrZmoowKo7/GG+s
	dntgJJugCXRYVGagTNkss8bX6QLQ5+1aubGCL
X-Google-Smtp-Source: AGHT+IHnk868IuOinRAS2955sUgCeTX9VRifC0z6c6Jh5aSQYADnS3sG4UksufT6jlvzkG0HXyniPxqleuiNYLhJHng=
X-Received: by 2002:a05:6402:3587:b0:5aa:19b1:ffc7 with SMTP id
 4fb4d7f45d1cf-5bbaff2fa9fmr215202a12.2.1723128182418; Thu, 08 Aug 2024
 07:43:02 -0700 (PDT)
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
 <CAG48ez1q80onUxoDrFFvGmoWzOhjRaXzYpu+e8kNAHzPADvAAg@mail.gmail.com> <20240808.kaiyaeZoo1ha@digikod.net>
In-Reply-To: <20240808.kaiyaeZoo1ha@digikod.net>
From: Jann Horn <jannh@google.com>
Date: Thu, 8 Aug 2024 16:42:23 +0200
Message-ID: <CAG48ez34C2pv7qugcYHeZgp5P=hOLyk4p5RRgKwhU5OA4Dcnuw@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] Landlock: Add signal control
To: =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>
Cc: Tahera Fahimi <fahimitahera@gmail.com>, outreachy@lists.linux.dev, gnoack@google.com, 
	paul@paul-moore.com, jmorris@namei.org, serge@hallyn.com, 
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org, 
	bjorn3_gh@protonmail.com, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 8, 2024 at 4:09=E2=80=AFPM Micka=C3=ABl Sala=C3=BCn <mic@digiko=
d.net> wrote:
> On Thu, Aug 08, 2024 at 03:10:54AM +0200, Jann Horn wrote:
> > On Thu, Aug 8, 2024 at 1:36=E2=80=AFAM Tahera Fahimi <fahimitahera@gmai=
l.com> wrote:
> > > On Wed, Aug 07, 2024 at 08:16:47PM +0200, Micka=C3=ABl Sala=C3=BCn wr=
ote:
> > > > On Tue, Aug 06, 2024 at 11:55:27PM +0200, Jann Horn wrote:
> > > > > On Tue, Aug 6, 2024 at 8:56=E2=80=AFPM Jann Horn <jannh@google.co=
m> wrote:
> > > > > > On Tue, Aug 6, 2024 at 8:11=E2=80=AFPM Tahera Fahimi <fahimitah=
era@gmail.com> wrote:
> > > > > > > Currently, a sandbox process is not restricted to send a sign=
al
> > > > > > > (e.g. SIGKILL) to a process outside of the sandbox environmen=
t.
> > > > > > > Ability to sending a signal for a sandboxed process should be
> > > > > > > scoped the same way abstract unix sockets are scoped. Therefo=
re,
> > > > > > > we extend "scoped" field in a ruleset with
> > > > > > > "LANDLOCK_SCOPED_SIGNAL" to specify that a ruleset will deny
> > > > > > > sending any signal from within a sandbox process to its
> > > > > > > parent(i.e. any parent sandbox or non-sandboxed procsses).
> > > > > [...]
> > > > > > > +       if (is_scoped)
> > > > > > > +               return 0;
> > > > > > > +
> > > > > > > +       return -EPERM;
> > > > > > > +}
> > > > > > > +
> > > > > > > +static int hook_file_send_sigiotask(struct task_struct *tsk,
> > > > > > > +                                   struct fown_struct *fown,=
 int signum)
> > > >
> > > > I was wondering if we should handle this case, but I guess it makes
> > > > sense to have a consistent policy for all kind of user-triggerable
> > > > signals.
> > > >
> > > > > > > +{
> > > > > > > +       bool is_scoped;
> > > > > > > +       const struct landlock_ruleset *dom, *target_dom;
> > > > > > > +       struct task_struct *result =3D get_pid_task(fown->pid=
, fown->pid_type);
> > > > > >
> > > > > > I'm not an expert on how the fowner stuff works, but I think th=
is will
> > > > > > probably give you "result =3D NULL" if the file owner PID has a=
lready
> > > > > > exited, and then the following landlock_get_task_domain() would
> > > > > > probably crash? But I'm not entirely sure about how this works.
> > > > > >
> > > > > > I think the intended way to use this hook would be to instead u=
se the
> > > > > > "file_set_fowner" hook to record the owning domain (though the =
setup
> > > > > > for that is going to be kind of a pain...), see the Smack and S=
ELinux
> > > > > > definitions of that hook. Or alternatively maybe it would be ev=
en
> > > > > > nicer to change the fown_struct to record a cred* instead of a =
uid and
> > > > > > euid and then use the domain from those credentials for this ho=
ok...
> > > > > > I'm not sure which of those would be easier.
> > > > >
> > > > > (For what it's worth, I think the first option would probably be
> > > > > easier to implement and ship for now, since you can basically cop=
y
> > > > > what Smack and SELinux are already doing in their implementations=
 of
> > > > > these hooks. I think the second option would theoretically result=
 in
> > > > > nicer code, but it might require a bit more work, and you'd have =
to
> > > > > include the maintainers of the file locking code in the review of=
 such
> > > > > refactoring and have them approve those changes. So if you want t=
o get
> > > > > this patchset into the kernel quickly, the first option might be
> > > > > better for now?)
> > > > >
> > > >
> > > > I agree, let's extend landlock_file_security with a new "fown" poin=
ter
> > > > to a Landlock domain. We'll need to call landlock_get_ruleset() in
> > > > hook_file_send_sigiotask(), and landlock_put_ruleset() in a new
> > > > hook_file_free_security().
> > > I think we should add a new hook (hook_file_set_owner()) to initializ=
e
> > > the "fown" pointer and call landlock_get_ruleset() in that?
> >
> > Yeah. Initialize the pointer in the file_set_fowner hook, and read the
> > pointer in the file_send_sigiotask hook.
> >
> > Note that in the file_set_fowner hook, you'll probably need to use
> > both landlock_get_ruleset() (to take a reference on the ruleset you're
> > storing in the fown pointer) and landlock_put_ruleset() (to drop the
> > reference to the ruleset that the fown pointer was pointing to
> > before). And you'll need to use some kind of lock to protect the fown
> > pointer - either by adding an appropriate lock next to your fown
> > pointer or by using some appropriate existing lock in "struct file".
> > Probably it's cleanest to have your own lock for this? (This lock will
> > have to be something like a spinlock, not a mutex, since you need to
> > be able to acquire it in the file_set_fowner hook, which runs inside
> > an RCU read-side critical section, where sleeping is forbidden -
> > acquiring a mutex can sleep and therefore is forbidden in this
> > context, acquiring a spinlock can't sleep.)
>
> Yes, I think this should work for file_set_fowner:
>
> struct landlock_ruleset *prev_dom, *new_dom;
>
> new_dom =3D landlock_get_current_domain();
> landlock_get_ruleset(new_dom);
>
> /* Cf. f_modown() */
> write_lock_irq(&filp->f_owner.lock);
> prev_dom =3D rcu_replace_pointer(&landlock_file(file)->fown_domain,
>         new_dom, lockdep_is_held(&filp->f_owner.lock));
> write_unlock_irq(&filp->f_owner.lock);
>
> landlock_put_ruleset_rcu(prev_dom);
>
>
> With landlock_put_ruleset_rcu() define with this:
>
> diff --git a/security/landlock/ruleset.c b/security/landlock/ruleset.c
> index a93bdbf52fff..897116205520 100644
> --- a/security/landlock/ruleset.c
> +++ b/security/landlock/ruleset.c
> @@ -524,6 +524,20 @@ void landlock_put_ruleset_deferred(struct landlock_r=
uleset *const ruleset)
>         }
>  }
>
> +static void free_ruleset_rcu(struct rcu_head *const head)
> +{
> +       struct landlock_ruleset *ruleset;
> +
> +       ruleset =3D container_of(head, struct landlock_ruleset, rcu);
> +       free_ruleset(ruleset);
> +}

free_ruleset() can block but RCU callbacks aren't allowed to block,
that's why landlock_put_ruleset_deferred() exists.

> +
> +void landlock_put_ruleset_rcu(struct landlock_ruleset *const ruleset)
> +{
> +       if (ruleset && refcount_dec_and_test(&ruleset->usage))
> +               call_rcu(&ruleset->rcu, free_ruleset_rcu);
> +}

No, this pattern of combining refcounting and RCU doesn't work.

One legal pattern is:
*The entire object* is subject to RCU; any refcount decrement that
drops the refcount to 0 does call_rcu().
(This is the usual RCU refcounting pattern in the kernel.)

Another legal pattern is:
One particular *reference* is subject to RCU; when dropping this
reference, *the refcount decrement is delayed with call_rcu()*.
(This is basically the RCU pattern used for stuff like the reference
from "struct pid" to "struct task_struct".)

But you can't use call_rcu() depending on whether the last dropped
reference happened to be a reference that required RCU; what if the
refcount is 2, then you first call landlock_put_ruleset_rcu() which
decrements the refcount to 1, and immediately afterwards you call
landlock_put_ruleset() which drops the refcount to 0 and frees the
object without waiting for an RCU grace period? Like so:

thread A         thread B
=3D=3D=3D=3D=3D=3D=3D=3D         =3D=3D=3D=3D=3D=3D=3D=3D
rcu_read_lock()
ruleset =3D rcu_dereference(...->fown_domain)
                 ruleset =3D rcu_replace_pointer(...->fown_domain, new_dom,=
 ...)
                 landlock_put_ruleset_rcu(ruleset)
                 landlock_put_ruleset(ruleset)
                   free_ruleset(ruleset)
                     kfree(ruleset)
access ruleset [UAF]
rcu_read_unlock()

So if you want to use RCU lifetime for this, I think you'll have to
turn landlock_put_ruleset() and landlock_put_ruleset_deferred() into
one common function that always, when reaching refcount 0, schedules
an RCU callback which then schedules a work_struct which then does
free_ruleset().

I think that would be a little ugly, and it would look nicer to just
use normal locking in the file_send_sigiotask hook?

