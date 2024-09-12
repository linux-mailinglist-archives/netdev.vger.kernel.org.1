Return-Path: <netdev+bounces-127615-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BC9B0975DE1
	for <lists+netdev@lfdr.de>; Thu, 12 Sep 2024 02:15:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 736AF1F23532
	for <lists+netdev@lfdr.de>; Thu, 12 Sep 2024 00:15:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9FDF1877;
	Thu, 12 Sep 2024 00:15:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LZnikTmO"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8266910E6;
	Thu, 12 Sep 2024 00:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726100130; cv=none; b=cK5pE0XPEvikEHj7zcOTKnE7bZAMflveuUyD228rIWr+w0/8MGg565QToCdSFjxmoHywGaUVY+qSFOFp7zEizv13LS6YhwVelGGMQX3loTNM01LMtvWjTPjndyo5NLRkqxEcQFZ8J+kPl1bRt4+6BNiIzOq5uGg3eLCl0Y4P4V4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726100130; c=relaxed/simple;
	bh=S3C7v9YnDNRcBILJMpX+FpkSyOuupZ7xt5mGvvS11Ng=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aSt5girArc3ukpNJI9EzySCEchuEDk/BqUV2qHibf3t67d85XqV32SBvecAzSOg/I0cDUArGavmSZmT97UY8nRXwawtt1walScHpJCuKIDyqP0SNxBpwt3dgokDma7r1N6hAbDrgUsOQbUPhV3eK0IJDsj++m7P0PW36y8oiMxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LZnikTmO; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-20573eb852aso10158115ad.1;
        Wed, 11 Sep 2024 17:15:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726100128; x=1726704928; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=tB3E/T7YAvjvqVbBXzUkuOGhb4WX8ydsVz+TdkUG8B0=;
        b=LZnikTmOgFvX6WiQJzTcQuFKwu9/vPpahlRGMi+bMaq7qVRXS3hWodl67QCBYIxo77
         74iJ1vgk3nDWkoCx+JemA9g4Q+tZPXQfcY3+DLcGfq/srnHLs290slUZE/UtoEUaN7IK
         zdvDKJQDSrNqysyWkwKDSM69ti86Q9SuZBIEa/v5Yr15sLqiH0I00+UqJMLVJASkEm/2
         QT1WPvBE6Uu1xBttFEFNSACC6QfhADyEZAEH7ukX9cBPbdy9zgSxacunV6A+fn2Q7NJu
         YoqM+ELY8ODsb6PXUmQKCC0by+LK1Iaa+13B+s4WOPKvYH36A3e+obO8UKwYZpWZdiIY
         yuZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726100128; x=1726704928;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tB3E/T7YAvjvqVbBXzUkuOGhb4WX8ydsVz+TdkUG8B0=;
        b=QytbS/SfDO7eLSmgt5Ohpb7VePdvYBqrwCLU7jMrN6KslbjGVQmKiZS8spRCmlFBFX
         L/54RmoX90K2W9V+3lbhi6DDGglNKuVUb8Q51MuN46Q1UYr869lth4aaKjCHFJQQSzdk
         LjTmQDvKXHASvHhdy9yiPhVASx2z/q7fbd3UQacKWIa2kAoWVKEFGMoXY2ert5xu+aep
         wRKJSpaJPqEdCjdIGuv6GW5D3i2nCuWMKv+jTvnHtHXU0K8JwRQA5zA+65oHbcb9U+Ka
         okeU2X5AZOJgY9fGdvnwud6mluL0iM9zxI5IJbfdYb0BcaL9V8d8553NHUbckdBpuT5L
         vdYA==
X-Forwarded-Encrypted: i=1; AJvYcCVR/qbpWxz+YJjvHalWV+GBwUu/UKWQugPHAhdSQepEDzyuPTq0YUZ6z7U0lXPuhQTz05AyYwc/1b2j7AnyHvi1gWfxOQ7i@vger.kernel.org, AJvYcCWQwOaK+toLvyZdj4haOHWtX517RSzEbj6GDUyNlzekuTajw5W8iodxrKvwhTq049Onnh1ZvqUfPQhnJrY=@vger.kernel.org, AJvYcCX1L8SZr/XtitSIDE3+hjGyNtk61c2I+Ow1dckAS+JL1XaV+izGqqBPsObzBelvrM4zi57RpNRA@vger.kernel.org
X-Gm-Message-State: AOJu0YzRZgtkBoBuM/DlZA/2KHI88Ixirzvxea9VT27yut2kgGTtakKO
	AOgHKgNHRPc1/3kpuoAsyHOu29tHUqcxzuuIQVzuy9K+qXhQEU9cqv7GMEIH
X-Google-Smtp-Source: AGHT+IEy1ADhaFtrJIE8didZWkzouq2MGonBNdxcWKaj66hgINbNzZc29epaW0S6YvQE0rABqiBItQ==
X-Received: by 2002:a17:902:d4ce:b0:1fd:96c7:24f5 with SMTP id d9443c01a7336-2074c5d2351mr86441445ad.5.1726100127410;
        Wed, 11 Sep 2024 17:15:27 -0700 (PDT)
Received: from tahera-OptiPlex-5000 ([136.159.49.123])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2076af278aasm4761075ad.28.2024.09.11.17.15.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Sep 2024 17:15:26 -0700 (PDT)
Date: Wed, 11 Sep 2024 18:15:24 -0600
From: Tahera Fahimi <fahimitahera@gmail.com>
To: =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>
Cc: outreachy@lists.linux.dev, gnoack@google.com, paul@paul-moore.com,
	jmorris@namei.org, serge@hallyn.com,
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
	bjorn3_gh@protonmail.com, jannh@google.com, netdev@vger.kernel.org
Subject: Re: [PATCH v4 0/6] landlock: Signal scoping support
Message-ID: <ZuIynFIRt475uBP5@tahera-OptiPlex-5000>
References: <cover.1725657727.git.fahimitahera@gmail.com>
 <20240911.BieLu8DooJiw@digikod.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240911.BieLu8DooJiw@digikod.net>

On Wed, Sep 11, 2024 at 08:17:04PM +0200, Mickaël Salaün wrote:
> We should also have the same tests as for scoped_vs_unscoped variants.
Hi, 

Thanks for the review, I will add them soon.
> I renamed them from the abstract unix socket patch series, please take a
> look:
> https://git.kernel.org/pub/scm/linux/kernel/git/mic/linux.git/log/?h=next
Wonderful! Thank you :)

> I'll send more reviews tomorrow and I'll fix most of them in my -next
> branch (WIP), except for the hook_file_send_sigiotask tests and these
> scoped_vs_unscoped variants that you should resolve.
I will keep an eye on reviews. What parts of hook_file_send_sigiotask
would need changes?

> On Fri, Sep 06, 2024 at 03:30:02PM -0600, Tahera Fahimi wrote:
> > This patch series adds scoping mechanism for signals.
> > Closes: https://github.com/landlock-lsm/linux/issues/8
> > 
> > Problem
> > =======
> > 
> > A sandboxed process is currently not restricted from sending signals
> > (e.g. SIGKILL) to processes outside the sandbox since Landlock has no
> > restriction on signals(see more details in [1]).
> > 
> > A simple way to apply this restriction would be to scope signals the
> > same way abstract unix sockets are restricted.
> > 
> > [1]https://lore.kernel.org/all/20231023.ahphah4Wii4v@digikod.net/
> > 
> > Solution
> > ========
> > 
> > To solve this issue, we extend the "scoped" field in the Landlock
> > ruleset attribute structure by introducing "LANDLOCK_SCOPED_SIGNAL"
> > field to specify that a ruleset will deny sending any signals from
> > within the sandbox domain to its parent(i.e. any parent sandbox or
> > non-sandbox processes).
> > 
> > Example
> > =======
> > 
> > Create a sansboxed shell and pass the character "s" to LL_SCOPED:
> > LL_FD_RO=/ LL_FS_RW=. LL_SCOPED="s" ./sandboxer /bin/bash
> > Try to send a signal(like SIGTRAP) to a process ID <PID> through:
> > kill -SIGTRAP <PID>
> > The sandboxed process should not be able to send the signal.
> > 
> > Previous Versions
> > =================
> > v3:https://lore.kernel.org/all/cover.1723680305.git.fahimitahera@gmail.com/
> > v2:https://lore.kernel.org/all/cover.1722966592.git.fahimitahera@gmail.com/
> > v1:https://lore.kernel.org/all/cover.1720203255.git.fahimitahera@gmail.com/
> > 
> > Tahera Fahimi (6):
> >   landlock: Add signal scoping control
> >   selftest/landlock: Signal restriction tests
> >   selftest/landlock: Add signal_scoping_threads test
> >   selftest/landlock: Test file_send_sigiotask by sending out-of-bound
> >     message
> >   sample/landlock: Support sample for signal scoping restriction
> >   landlock: Document LANDLOCK_SCOPED_SIGNAL
> > 
> >  Documentation/userspace-api/landlock.rst      |  22 +-
> >  include/uapi/linux/landlock.h                 |   3 +
> >  samples/landlock/sandboxer.c                  |  17 +-
> >  security/landlock/fs.c                        |  17 +
> >  security/landlock/fs.h                        |   6 +
> >  security/landlock/limits.h                    |   2 +-
> >  security/landlock/task.c                      |  59 +++
> >  .../selftests/landlock/scoped_signal_test.c   | 371 ++++++++++++++++++
> >  .../testing/selftests/landlock/scoped_test.c  |   2 +-
> >  9 files changed, 486 insertions(+), 13 deletions(-)
> >  create mode 100644 tools/testing/selftests/landlock/scoped_signal_test.c
> > 
> > -- 
> > 2.34.1
> > 


