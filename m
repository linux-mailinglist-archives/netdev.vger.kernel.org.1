Return-Path: <netdev+bounces-116635-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E2FA94B3AC
	for <lists+netdev@lfdr.de>; Thu,  8 Aug 2024 01:36:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 11B831F22741
	for <lists+netdev@lfdr.de>; Wed,  7 Aug 2024 23:36:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FB7F154C10;
	Wed,  7 Aug 2024 23:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UM2X/B9A"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 070E82B9A1;
	Wed,  7 Aug 2024 23:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723073790; cv=none; b=nZ9Ah/P06eRJRku+2Wpws4wdDsD0qz1fouSCZeWK3t488VnkCoP83lTnfipBnGwLhtBx1WTbKmrrwqHH8/fh55RFvZNTNQAcAJ8LqbXSvB7idLl+GS7ZtZZxL/koRmEbWjXwQ+7sJgmSft3u0h7AN079PJfJauHzBzJ2I8+ZB4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723073790; c=relaxed/simple;
	bh=qSbCFaZH+G6lzKlJZVve6DFWjFuUgcmFFYwA/SjX21I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O68UGB+Vosq376VXJET/IdpGwBQXBbc9EB/DqlacGnC2Dr1nm2x1qpMm4A75DCIm//GMx1yh/zQ5YCHHMflD++acGPDPxUz9Kp32H5Mh1Jv0UkWiLZfy/DbHRJ3Sp1xXJZKnCsHQsmNSHyelm3rom6Sv5JbC3klWwxWjhOsQdJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UM2X/B9A; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1fc587361b6so4444325ad.2;
        Wed, 07 Aug 2024 16:36:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723073788; x=1723678588; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=3bI2iAB50s/sgrD0as33mPKfx3YGxvdhWBB75P/hORk=;
        b=UM2X/B9AUArun2CGL5B/ESsIFSOoyLs0To6tWh8SYpQYvrrlnbI50iF4CW0EkPtAz6
         /GzYN/nc01O0RP5UBzVjkGu4c7Jzfkrvr9hLYag5E9gHWdGOZ+Z+kduaAdoyLpY/eFLW
         5qkTL1HrPxy0wCOkSOguQr55AdxqToKw/mrcsau9aBAHxMyfCdBR5FGPDi2ubApgNAMY
         sKMTKrsKC3brwbLWTHibplXcfIMJSK8bO6DuyCgoC724umxRae/k/9EH0+P5/ZAoLies
         Mcz61uoTfaHpQU1jVXTE5ILf6l2U5DXiDkPen5LaeXImjwEOPw8WUMmWgSpuzRNLYEa6
         lOcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723073788; x=1723678588;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3bI2iAB50s/sgrD0as33mPKfx3YGxvdhWBB75P/hORk=;
        b=FVpeu0gd3qEmKySFyburBwbV4qYlwzvodoYX8oUIpGuD+JTUv8p2cuA1FfRk8f7Hlv
         rFzwDR4RR02fOELdatpZMSicJIUSSFNJT+VusXLe6OZFHx6etmSKdPVBJB2Cr2JHeAst
         wXNjk/EN/b8z0XAgmXOPuDfq/kLv9YOuzUwpSrWvU1h7cjnPYr3qo5Gh4UrH1bUhqZkK
         6oYwL74EyQtwV3Wd923zRnOzq1KTOV/gVrKO5aNsky2Ws+xHtn9s9bWSwm5HVy1YXMVL
         dg0x8HTC8px2JBxzO0WHyVVrnygNrf0XJ0Igddm9gkJ/5zrY8eYLzJZCKPj+iisObgkt
         Qy0w==
X-Forwarded-Encrypted: i=1; AJvYcCVBlEEeP6SjdesdhuXrBW51/9XruKTHmUi6lwBcVa7FboYNOmE9UflZhCh9O7pxIvNTCGXfqbjq+B0CTWb+Kl6R9lnTRRW8l+C/gZFBn0vU2BrskAZMKygKsdPN47x3lUzN9bv8tFu2D0j7WBhy4KEEAdClN+TYem4kns1CER+EQKk1Epnh0frbvsei
X-Gm-Message-State: AOJu0YyScqRMvQUTzLIWh4rTUjFBrEnaZfZ18Q7LwCgcusiC85caL6q/
	5fpQFeQCCN6cGhkSBTcM+QlAtI8YWZabanIQFi4qoKJEY7FmepD5VuuaaUhi
X-Google-Smtp-Source: AGHT+IHvCp3huaVdNK2AR/421T2J1J8zVwb1EDAWJDXPQ4FGbjP9mkC7qxfimpUomsC/h8MQ6DOH6g==
X-Received: by 2002:a17:902:d2ca:b0:1fb:8a3b:ee9a with SMTP id d9443c01a7336-200952e28admr2942865ad.61.1723073788023;
        Wed, 07 Aug 2024 16:36:28 -0700 (PDT)
Received: from tahera-OptiPlex-5000 ([136.159.49.123])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ff59176eb6sm112030645ad.196.2024.08.07.16.36.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Aug 2024 16:36:27 -0700 (PDT)
Date: Wed, 7 Aug 2024 17:36:25 -0600
From: Tahera Fahimi <fahimitahera@gmail.com>
To: =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>
Cc: Jann Horn <jannh@google.com>, outreachy@lists.linux.dev,
	gnoack@google.com, paul@paul-moore.com, jmorris@namei.org,
	serge@hallyn.com, linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org, bjorn3_gh@protonmail.com,
	netdev@vger.kernel.org
Subject: Re: [PATCH v2 1/4] Landlock: Add signal control
Message-ID: <ZrQE+d2b/FWxIPoA@tahera-OptiPlex-5000>
References: <cover.1722966592.git.fahimitahera@gmail.com>
 <49557e48c1904d2966b8aa563215d2e1733dad95.1722966592.git.fahimitahera@gmail.com>
 <CAG48ez3o9fmqz5FkFh3YoJs_jMdtDq=Jjj-qMj7v=CxFROq+Ew@mail.gmail.com>
 <CAG48ez1jufy8iwP=+DDY662veqBdv9VbMxJ69Ohwt8Tns9afOw@mail.gmail.com>
 <20240807.Yee4al2lahCo@digikod.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240807.Yee4al2lahCo@digikod.net>

On Wed, Aug 07, 2024 at 08:16:47PM +0200, Mickaël Salaün wrote:
> On Tue, Aug 06, 2024 at 11:55:27PM +0200, Jann Horn wrote:
> > On Tue, Aug 6, 2024 at 8:56 PM Jann Horn <jannh@google.com> wrote:
> > > On Tue, Aug 6, 2024 at 8:11 PM Tahera Fahimi <fahimitahera@gmail.com> wrote:
> > > > Currently, a sandbox process is not restricted to send a signal
> > > > (e.g. SIGKILL) to a process outside of the sandbox environment.
> > > > Ability to sending a signal for a sandboxed process should be
> > > > scoped the same way abstract unix sockets are scoped. Therefore,
> > > > we extend "scoped" field in a ruleset with
> > > > "LANDLOCK_SCOPED_SIGNAL" to specify that a ruleset will deny
> > > > sending any signal from within a sandbox process to its
> > > > parent(i.e. any parent sandbox or non-sandboxed procsses).
> > [...]
> > > > +       if (is_scoped)
> > > > +               return 0;
> > > > +
> > > > +       return -EPERM;
> > > > +}
> > > > +
> > > > +static int hook_file_send_sigiotask(struct task_struct *tsk,
> > > > +                                   struct fown_struct *fown, int signum)
> 
> I was wondering if we should handle this case, but I guess it makes
> sense to have a consistent policy for all kind of user-triggerable
> signals.
> 
> > > > +{
> > > > +       bool is_scoped;
> > > > +       const struct landlock_ruleset *dom, *target_dom;
> > > > +       struct task_struct *result = get_pid_task(fown->pid, fown->pid_type);
> > >
> > > I'm not an expert on how the fowner stuff works, but I think this will
> > > probably give you "result = NULL" if the file owner PID has already
> > > exited, and then the following landlock_get_task_domain() would
> > > probably crash? But I'm not entirely sure about how this works.
> > >
> > > I think the intended way to use this hook would be to instead use the
> > > "file_set_fowner" hook to record the owning domain (though the setup
> > > for that is going to be kind of a pain...), see the Smack and SELinux
> > > definitions of that hook. Or alternatively maybe it would be even
> > > nicer to change the fown_struct to record a cred* instead of a uid and
> > > euid and then use the domain from those credentials for this hook...
> > > I'm not sure which of those would be easier.
> > 
> > (For what it's worth, I think the first option would probably be
> > easier to implement and ship for now, since you can basically copy
> > what Smack and SELinux are already doing in their implementations of
> > these hooks. I think the second option would theoretically result in
> > nicer code, but it might require a bit more work, and you'd have to
> > include the maintainers of the file locking code in the review of such
> > refactoring and have them approve those changes. So if you want to get
> > this patchset into the kernel quickly, the first option might be
> > better for now?)
> > 
> 
> I agree, let's extend landlock_file_security with a new "fown" pointer
> to a Landlock domain. We'll need to call landlock_get_ruleset() in
> hook_file_send_sigiotask(), and landlock_put_ruleset() in a new
> hook_file_free_security().
I think we should add a new hook (hook_file_set_owner()) to initialize
the "fown" pointer and call landlock_get_ruleset() in that? If we do not
have hook_file_set_owner to store domain in "fown", can you please give
me a hint on where to do that?
Thanks 
> I would be nice to to replace the redundant informations in fown_struct
> but that can wait.

