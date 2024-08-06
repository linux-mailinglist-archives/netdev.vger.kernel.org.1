Return-Path: <netdev+bounces-116258-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AC2AA949A8C
	for <lists+netdev@lfdr.de>; Tue,  6 Aug 2024 23:56:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 67608283580
	for <lists+netdev@lfdr.de>; Tue,  6 Aug 2024 21:56:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1E6D170849;
	Tue,  6 Aug 2024 21:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vvk6TA0u"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DEBC170A1F
	for <netdev@vger.kernel.org>; Tue,  6 Aug 2024 21:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722981370; cv=none; b=WFL+v2kzcdV+0/XTijeE8nG+ADBMiNlregac3Fqaso6ABo76Bk+i60fhslZmVNT6/80KPYXVHzBLbrYpDso1o7p0OsHchT1ZqDradqtPtS2YGqbWv4rvj6TKJvQer0ZrH/F1dApcQz+f0kWzvwZ8NtQ4lWHP+1wkDshqG7rjQUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722981370; c=relaxed/simple;
	bh=wmfgdQYdTGpqJb5pxWE0y8AYHfytkLr7bRVUJCeQ1rY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=P/I3b0/xU7kCBzh55UxGnDP4XHgWSW615L2OukBhLn0Zikr8+GDn+BNC7MlTex9hsE5SPkX6rvsdvzAtZSKQfv1Lg9NLXCePjAeWjqCK5JJ3gDzB/mrYRG40hj2GqSLs3qKHSSgvZz1a9hEZuTt8znj6AtaDqpdtMIsVSU6iUDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vvk6TA0u; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5a1b073d7cdso24629a12.0
        for <netdev@vger.kernel.org>; Tue, 06 Aug 2024 14:56:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1722981367; x=1723586167; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+sWPUIMGVUWcmjL98+oi0JS8IjtLhhZ9IWBSne+zhKM=;
        b=vvk6TA0uxSAiqVtQyWO6hFBqwXPMl9LO79FM9m+mNwgub9BJJEppvt2jKNV67OpnF4
         3DHYIDt4DGpvMF/6vk/QH/y7GsNExaCnktY3xFgStQVfoHVoJyw7AjhOSKAT57LRnq44
         u7S3bIdPe1ND1g02GF25tqnJTUpcpWFVdrlOz33uRCcUOLPw+Ezn8dbIysBlXsNqQmEl
         xJYXq/4HZLud1e9hBWimVxTm5HbYvYNAtBJmNgRbxSX2SLo2SuN2K2CXsbLALcRZ1aFV
         cGIPqpLberytpCz8t93E1E/DA1wf0jK9/8CjfpLacapTEw5l1fgytJMg9oDi4BKZPxPJ
         qt0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722981367; x=1723586167;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+sWPUIMGVUWcmjL98+oi0JS8IjtLhhZ9IWBSne+zhKM=;
        b=QbZGVaW/Ybj/mbbGJRFhSJi6kFfS4s7JITTYu/0CwGSFJyd2fbkCmHbz9iuRU72Eva
         7L24krk+V0YnSsV5ZEwD7eDy3F81bQ2Px+EoEc3/bC7/7opskHI6xS1rKE5e5j4WOQ4y
         4qw9SKt+hegZUifjLTFgWSPAOo7LIFvFywNoTvhALGYAA2rOMFv48WYCt52TNU1QwTK9
         6229j2GjtLmwM5YFhP6zPkhPCZzs1VkPaDWwpJmnksgB8teM5nsexbjvykyz2UkDflIl
         iw2Wki1IaHwL8Z0/LMcErfoL6QpUVWDEJbpsn30uORUf6EdZ/p7uyarpu4+6esT+s1/I
         bLQw==
X-Forwarded-Encrypted: i=1; AJvYcCX/dH8YYafNEAcCykwPBhaBMxIYTEKj0+Gj1o96MyD/BJaUmiyaqLi67R3jf4cven/x3OvnDx5A3z39FRdVxeKnf3Amvs/T
X-Gm-Message-State: AOJu0YzAnt+HzvAutt1n4KYwqzfJ/TDjRUUTxBtwEcdnEV/Gs3UdpOhc
	lV2/y0zvc4tkEpuOQw8nY6/05W/3bJh0o9rpTUulPhYb228gW+Dnsu1dTmCPjHgrMTaGdluRO47
	qcBXpEkLeH+aNuZYtJQwVo6sGsrhqiXW5c6J3
X-Google-Smtp-Source: AGHT+IHrdbF6ksKEP/0jX+HSSz9PUgh5mkW7R8u/LJHt8G4iQfLdba2Kwe1pQYLhXbf9Qp8tAYkNpUdj+svO6W0QJQs=
X-Received: by 2002:a05:6402:84c:b0:59f:9f59:9b07 with SMTP id
 4fb4d7f45d1cf-5bba28bb22amr74904a12.4.1722981366891; Tue, 06 Aug 2024
 14:56:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1722966592.git.fahimitahera@gmail.com> <49557e48c1904d2966b8aa563215d2e1733dad95.1722966592.git.fahimitahera@gmail.com>
 <CAG48ez3o9fmqz5FkFh3YoJs_jMdtDq=Jjj-qMj7v=CxFROq+Ew@mail.gmail.com>
In-Reply-To: <CAG48ez3o9fmqz5FkFh3YoJs_jMdtDq=Jjj-qMj7v=CxFROq+Ew@mail.gmail.com>
From: Jann Horn <jannh@google.com>
Date: Tue, 6 Aug 2024 23:55:27 +0200
Message-ID: <CAG48ez1jufy8iwP=+DDY662veqBdv9VbMxJ69Ohwt8Tns9afOw@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] Landlock: Add signal control
To: Tahera Fahimi <fahimitahera@gmail.com>
Cc: outreachy@lists.linux.dev, mic@digikod.net, gnoack@google.com, 
	paul@paul-moore.com, jmorris@namei.org, serge@hallyn.com, 
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org, 
	bjorn3_gh@protonmail.com, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 6, 2024 at 8:56=E2=80=AFPM Jann Horn <jannh@google.com> wrote:
> On Tue, Aug 6, 2024 at 8:11=E2=80=AFPM Tahera Fahimi <fahimitahera@gmail.=
com> wrote:
> > Currently, a sandbox process is not restricted to send a signal
> > (e.g. SIGKILL) to a process outside of the sandbox environment.
> > Ability to sending a signal for a sandboxed process should be
> > scoped the same way abstract unix sockets are scoped. Therefore,
> > we extend "scoped" field in a ruleset with
> > "LANDLOCK_SCOPED_SIGNAL" to specify that a ruleset will deny
> > sending any signal from within a sandbox process to its
> > parent(i.e. any parent sandbox or non-sandboxed procsses).
[...]
> > +       if (is_scoped)
> > +               return 0;
> > +
> > +       return -EPERM;
> > +}
> > +
> > +static int hook_file_send_sigiotask(struct task_struct *tsk,
> > +                                   struct fown_struct *fown, int signu=
m)
> > +{
> > +       bool is_scoped;
> > +       const struct landlock_ruleset *dom, *target_dom;
> > +       struct task_struct *result =3D get_pid_task(fown->pid, fown->pi=
d_type);
>
> I'm not an expert on how the fowner stuff works, but I think this will
> probably give you "result =3D NULL" if the file owner PID has already
> exited, and then the following landlock_get_task_domain() would
> probably crash? But I'm not entirely sure about how this works.
>
> I think the intended way to use this hook would be to instead use the
> "file_set_fowner" hook to record the owning domain (though the setup
> for that is going to be kind of a pain...), see the Smack and SELinux
> definitions of that hook. Or alternatively maybe it would be even
> nicer to change the fown_struct to record a cred* instead of a uid and
> euid and then use the domain from those credentials for this hook...
> I'm not sure which of those would be easier.

(For what it's worth, I think the first option would probably be
easier to implement and ship for now, since you can basically copy
what Smack and SELinux are already doing in their implementations of
these hooks. I think the second option would theoretically result in
nicer code, but it might require a bit more work, and you'd have to
include the maintainers of the file locking code in the review of such
refactoring and have them approve those changes. So if you want to get
this patchset into the kernel quickly, the first option might be
better for now?)

