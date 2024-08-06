Return-Path: <netdev+bounces-116271-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A4DA6949BA0
	for <lists+netdev@lfdr.de>; Wed,  7 Aug 2024 00:56:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C7DD91C220D1
	for <lists+netdev@lfdr.de>; Tue,  6 Aug 2024 22:56:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3003171E5F;
	Tue,  6 Aug 2024 22:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="S3qtiVBz"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2008C374C4
	for <netdev@vger.kernel.org>; Tue,  6 Aug 2024 22:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722984986; cv=none; b=ScO1TCN1DySEEEAHyEBS8rQ5uYPQeM9kmtLASiHyn5ibsYRJBlKhH2FDV84azTl3QBv6CmBuacD1EFZ0vLFotlAF+tEVroGX8nDAHCEG/F1vrI8VvVY/gGyJ8PpRJ1pTdDUF9HFQ8RxPfGKoEkZlSZEBHCEv0o0qI997b1DOgRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722984986; c=relaxed/simple;
	bh=aNMyv5u4iRth1dAkJiP4aTC7V9ydb+rlkqz1X9ydnK8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QEiSfaXvYRmztco/okyCzpSswPXCDXZMtzPiewiwjbxg5lhta5R8tEeYO6YnPRc8B3stXD9PC9fdurrLtYAUuAGcymXu1Bd8jp5mRETGHcrUSrqETBFVreZCEpQ2Txdb6pX84HeHyq6V1y3BMYh9JcRdqAwIXyd9nmlsqHu4zlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=S3qtiVBz; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5a1b073d7cdso25204a12.0
        for <netdev@vger.kernel.org>; Tue, 06 Aug 2024 15:56:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1722984983; x=1723589783; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m+9ez+DbuNqwjVco5Cgno4xixSp6vmg4G3LS18N1p4E=;
        b=S3qtiVBz3NevpePd8EjFKTdC55ANdENHbW0XA6hIefCNnHE+PoKlb8JxN2XX7kBRSf
         kd/eiYQb0vim3dovCh8YgMBZ6YPL8R+C/O6pEJ8l2M52cCwE9OWw5kg5TVM7wvAJsYLn
         RPdImw1WU5b9nlloKhnSBkQN6ZxLmrQRkbStgZPui/Qi71G4Ln6v5oYghrIwquuBAiTK
         ww74bTH0k21pebOVk4OAIr2JTQFcqBuhq/7ahIF0SD7B6XlcinLJoY/IGfnRZUOTPVQB
         t9JJUHoz8KYhOLzzGpGzV7gNtU6mbEigGnYovLkw4jq5crOtC38kSWrEI5x7mo98VFqg
         i+Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722984983; x=1723589783;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m+9ez+DbuNqwjVco5Cgno4xixSp6vmg4G3LS18N1p4E=;
        b=Ru3zpTx3ZPAH74fT8oPTJiSYYj1p2jeIndyGC2SceZ6KnM1bfvOL/ldHbm1BPg39VJ
         GCigmOlttV7D3x8RFS1BuYJ8jkWK+kH8EyzZRn+6NLPwQgVKaktb7rCOJPnL7mMbft25
         509mmZ37fS3rhYF5GMzmCRBihYEbBdAf1XYhcLndLmdEeopZcf6yjIh2ThHnSt7EtVZS
         eA/FeZR4r2uonxJ6lDnY+t/FvS/afU2MZn9+Soiy9mJnUy1yUe4neUWehoQcoleWawCZ
         50Vg7O7Y+oQnayvYWSxo6ixfhF3ePsK0hcPWix9kHRZpZcfQTNimcSU39j06apcY9fxu
         7SfQ==
X-Forwarded-Encrypted: i=1; AJvYcCWWpwqP6Fydxs/OzWJKlfEIRwrETV02GmzOTpaBjGc4MOCx430ZRm9QG5kmUxu02RUeSvzqSyFt3u+v9obhWDM1iA+mvr01
X-Gm-Message-State: AOJu0YxYPLSgg18dOgzTO3yPQ9XcDVoM6jaOiZqeI6js68XBZtLxiJ6O
	GL9qBzNDqSNg19ZIb27UyA6no+nEZw8VyQKubb+/mVMEEy7E72v8wXwUWUHSw7PsZ0mUVOlgJN0
	9KO/PRzqpcu3p6VBUqMSDj/Q8PowUGwkfUijo
X-Google-Smtp-Source: AGHT+IHdmoaV9xaEO4CcjSrPjVW5K+oaFl6xpiEgDz/ZpLfq51hclYinP1LbziYkKWQvucGfpgIXsD28vskGEw7k1zU=
X-Received: by 2002:a05:6402:51cb:b0:5a0:d4ce:59a6 with SMTP id
 4fb4d7f45d1cf-5bba2837e46mr75708a12.2.1722984982752; Tue, 06 Aug 2024
 15:56:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1722966592.git.fahimitahera@gmail.com> <49557e48c1904d2966b8aa563215d2e1733dad95.1722966592.git.fahimitahera@gmail.com>
 <CAG48ez3o9fmqz5FkFh3YoJs_jMdtDq=Jjj-qMj7v=CxFROq+Ew@mail.gmail.com> <ZrKc4i1PhdMwA77h@tahera-OptiPlex-5000>
In-Reply-To: <ZrKc4i1PhdMwA77h@tahera-OptiPlex-5000>
From: Jann Horn <jannh@google.com>
Date: Wed, 7 Aug 2024 00:55:46 +0200
Message-ID: <CAG48ez2OmOdMo7TCn4M8tSPSdXVwMDty6fMsHc9Q+NFQ-sfBUA@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] Landlock: Add signal control
To: Tahera Fahimi <fahimitahera@gmail.com>
Cc: outreachy@lists.linux.dev, mic@digikod.net, gnoack@google.com, 
	paul@paul-moore.com, jmorris@namei.org, serge@hallyn.com, 
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org, 
	bjorn3_gh@protonmail.com, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi!

On Wed, Aug 7, 2024 at 12:00=E2=80=AFAM Tahera Fahimi <fahimitahera@gmail.c=
om> wrote:
> On Tue, Aug 06, 2024 at 08:56:15PM +0200, Jann Horn wrote:
> > On Tue, Aug 6, 2024 at 8:11=E2=80=AFPM Tahera Fahimi <fahimitahera@gmai=
l.com> wrote:
> > > +       if (is_scoped)
> > > +               return 0;
> > > +
> > > +       return -EPERM;
> > > +}
> > > +
> > > +static int hook_file_send_sigiotask(struct task_struct *tsk,
> > > +                                   struct fown_struct *fown, int sig=
num)
> > > +{
> > > +       bool is_scoped;
> > > +       const struct landlock_ruleset *dom, *target_dom;
> > > +       struct task_struct *result =3D get_pid_task(fown->pid, fown->=
pid_type);
> >
> > I'm not an expert on how the fowner stuff works, but I think this will
> > probably give you "result =3D NULL" if the file owner PID has already
> > exited, and then the following landlock_get_task_domain() would
> > probably crash? But I'm not entirely sure about how this works.
> I considered since the file structure can always be obtained, then the
> file owner PID always exist.

I think the file owner "struct pid" always exists here; but I think
the PID does not necessarily point to a task_struct.

I think you can have a scenario where userspace does something like this:

int fd =3D <open some file descriptor somehow>;
fcntl(fd, F_SETOWN, <PID of some other process>);
pid_t child_pid =3D fork();
if (child_pid =3D=3D 0) {
  /* this executes in the child process */
  sleep(5);
  <do something on the fd that triggers send_sigio() or send_sigurg()>
  sleep(5);
  exit(0);
}
/* this continues executing in the parent process */
exit(0);

At the fcntl(fd, F_SETOWN, ...) call, a reference-counted reference to
the "struct pid" of the parent process will be stored in the file
(this happens in "f_modown", which increments the reference count of
the "struct pid" using "get_pid(...)"). But when the parent process
exits, the pointer from the parent's "struct pid" to the parent's
"task_struct" is removed, and the "task_struct" will eventually be
deleted from memory.

So when, at a later time, something triggers send_sigio() or
send_sigurg() and enters this LSM hook, I think
"get_pid_task(fown->pid, fown->pid_type)" can return NULL.

> I can check if we can use the credentials
> stored in struct file instead.

(sort of relevant: The manpage
https://man7.org/linux/man-pages/man2/fcntl.2.html says "Note: The
F_SETOWN operation records the caller's credentials at the time of the
fcntl() call, and it is these saved credentials that are used for the
permission checks.")

You mean the credentials in the "f_cred" member of "struct file", right? If=
 so:

I don't think Landlock can use the existing credentials stored in
file->f_cred for this. Consider the following scenario:

1. A process (with no landlock restrictions so far) opens a file. At
this point, the caller's credentials (which indicate no landlock
restrictions) are recorded in file->f_cred.
2. The process installs a landlock filter that restricts the ability
to send signals. (This changes the credentials pointer of the process
to a new set of credentials that points to the new landlock domain.)
3. Malicious code starts executing in the sandboxed process.
4. The malicious code uses F_SETOWN on the already-open file.
5. Something causes sending of a signal via send_sigio() or
send_sigurg() on this file.

In this scenario, if the LSM hook used the landlock restrictions
attached to file->f_cred, it would think the operation is not filtered
by any landlock domain.

> > I think the intended way to use this hook would be to instead use the
> > "file_set_fowner" hook to record the owning domain (though the setup
> > for that is going to be kind of a pain...), see the Smack and SELinux
> > definitions of that hook. Or alternatively maybe it would be even
> > nicer to change the fown_struct to record a cred* instead of a uid and
> > euid and then use the domain from those credentials for this hook...
> > I'm not sure which of those would be easier.
> Because Landlock does not use any security blob for this purpose, I am
> not sure how to record the owner's doamin.

I think landlock already has a landlock_file_security blob attached to
"struct file" that you could use to store an extra landlock domain
pointer for this, kinda like the "fown_sid" in SELinux? But doing this
for landlock would be a little more annoying because you'd have to
store a reference-counted pointer to the landlock domain in the
landlock_file_security blob, so you'd have to make sure to also
decrement the reference count when the file is freed (with the
file_free_security hook), and you'd have to use locking (or atomic
operations) to make sure that two concurrent file_set_fowner calls
don't race in a dangerous way...

So I think it's fairly straightforward, but it would be kinda ugly.

> The alternative way looks nice.

Yeah, I agree that it looks nicer. (If you decide to implement it by
refactoring the fown_struct, it would be a good idea to make that a
separate patch in your patch series - partly because that way, the
maintainers of that fs/fcntl.c code can review just the refactoring,
and partly just because splitting logical changes into separate
patches makes it easier to review the individual patches.)

> > > +       /* rcu is already locked! */
> > > +       dom =3D landlock_get_task_domain(result);
> > > +       target_dom =3D landlock_get_task_domain(tsk);
> > > +       is_scoped =3D domain_IPC_scope(dom, target_dom, LANDLOCK_SCOP=
ED_SIGNAL);
> > > +       put_task_struct(result);
> > > +       if (is_scoped)
> > > +               return 0;
> > > +       return -EPERM;
> > > +}

