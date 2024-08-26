Return-Path: <netdev+bounces-121875-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 36A8B95F19D
	for <lists+netdev@lfdr.de>; Mon, 26 Aug 2024 14:42:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A89F1B22AC2
	for <lists+netdev@lfdr.de>; Mon, 26 Aug 2024 12:42:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E919183CD3;
	Mon, 26 Aug 2024 12:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="O7v0csVr"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-190d.mail.infomaniak.ch (smtp-190d.mail.infomaniak.ch [185.125.25.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9320916F908
	for <netdev@vger.kernel.org>; Mon, 26 Aug 2024 12:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.25.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724676055; cv=none; b=b1p510zJqv7XhknMBMwu4xS9fyCYni6Zn5IWLQzbeDehWY05S8i+biJga+2Z4Oc5dwgaizMTaOncPGXl0oqwwaXKoV4rPiCF+2eWgBTD/DCyx9I+XbQpJkfo6yX7+tXkECdk3JboiXehKJjhifThY03mZJvsJbupV8dYh85S/I4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724676055; c=relaxed/simple;
	bh=9NISftmWeMItGbM8Fub8+QFf/ZJ+mp9uxvOv2CIvXy0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Qr7/bum2JE+j9+qaerZ0HQhfq/TzTvGi4/M/PhsdtJUH/d0uGrD5fT64YY8HkPy2feagXR1TVzCczJ+3AU+nylYu8WgagmKintpUEdCgNGcQLvAZ6pP+aJDIqoJQ4ZuxPcK7Mw7SkNiAgaNClYnTXD0RpjxQPWLhvdUQzhnegsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=O7v0csVr; arc=none smtp.client-ip=185.125.25.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Received: from smtp-3-0001.mail.infomaniak.ch (smtp-3-0001.mail.infomaniak.ch [10.4.36.108])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4Wsqz06KtYzJMn;
	Mon, 26 Aug 2024 14:40:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1724676044;
	bh=fNWO0n0Q5NpyD7VPZ/0nnCpTnReigNr50S/kQqFMk+Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=O7v0csVrpRJ7EylZaTIJHeRvRFFkj2gNM1KgGC+aj6Tfwjg9edyuePR4uyp/4UHIW
	 4veoFl4o4KFTJ6j2QcvpsO6kGfQP4R2se+YQf/seKhbenmBZk0LLtHFOwm8VpOeLmK
	 ClKT+h5lOgPUMbkLnd7Cmq4OU+aOdIyFq2rVx1AQ=
Received: from unknown by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4Wsqz02h6VzZNb;
	Mon, 26 Aug 2024 14:40:44 +0200 (CEST)
Date: Mon, 26 Aug 2024 14:40:39 +0200
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: Tahera Fahimi <fahimitahera@gmail.com>
Cc: outreachy@lists.linux.dev, gnoack@google.com, paul@paul-moore.com, 
	jmorris@namei.org, serge@hallyn.com, linux-security-module@vger.kernel.org, 
	linux-kernel@vger.kernel.org, bjorn3_gh@protonmail.com, jannh@google.com, 
	netdev@vger.kernel.org
Subject: Re: [PATCH v3 4/6] selftest/Landlock: pthread_kill(3) tests
Message-ID: <20240826.ToP3fahphub1@digikod.net>
References: <cover.1723680305.git.fahimitahera@gmail.com>
 <f9ddc707873b30f440779feb1f284fc2a4aae40b.1723680305.git.fahimitahera@gmail.com>
 <20240820.eesaifai6Goo@digikod.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240820.eesaifai6Goo@digikod.net>
X-Infomaniak-Routing: alpha

On Tue, Aug 20, 2024 at 05:57:08PM +0200, Mickaël Salaün wrote:
> Please make sure all subject's prefixes are correct, there is two errors
> in the prefix and the description can be made more consistent with other
> patches, something like this: "selftests/landlock: Add
> signal_scoping_threads test"
> 
> On Thu, Aug 15, 2024 at 12:29:23PM -0600, Tahera Fahimi wrote:
> > This patch expands the signal scoping tests with pthread_kill(3)
> > It tests if an scoped thread can send signal to a process in
> > the same scoped domain, or a non-sandboxed thread.
> > 
> > Signed-off-by: Tahera Fahimi <fahimitahera@gmail.com>
> > ---
> >  .../selftests/landlock/scoped_signal_test.c   | 29 +++++++++++++++++++
> >  1 file changed, 29 insertions(+)
> > 
> > diff --git a/tools/testing/selftests/landlock/scoped_signal_test.c b/tools/testing/selftests/landlock/scoped_signal_test.c
> > index 92958c6266ca..2edba1e6cd82 100644
> > --- a/tools/testing/selftests/landlock/scoped_signal_test.c
> > +++ b/tools/testing/selftests/landlock/scoped_signal_test.c
> > @@ -10,6 +10,7 @@
> >  #include <errno.h>
> >  #include <fcntl.h>
> >  #include <linux/landlock.h>
> > +#include <pthread.h>
> >  #include <signal.h>
> >  #include <sys/prctl.h>
> >  #include <sys/types.h>
> > @@ -18,6 +19,7 @@
> >  
> >  #include "common.h"
> >  
> > +#define DEFAULT_THREAD_RUNTIME 0.001
> >  static sig_atomic_t signaled;
> >  
> >  static void create_signal_domain(struct __test_metadata *const _metadata)
> > @@ -299,4 +301,31 @@ TEST_F(signal_scoping, test_signal)
> >  		_metadata->exit_code = KSFT_FAIL;
> >  }
> >  
> > +static void *thread_func(void *arg)
> > +{
> > +	sleep(DEFAULT_THREAD_RUNTIME);
> 
> Using sleep() may make this test flaky.  It needs to be removed and the
> test should work the same.
> 
> > +	return NULL;
> > +}
> > +
> > +TEST(signal_scoping_threads)
> > +{
> > +	pthread_t no_sandbox_thread, scoped_thread;
> > +	int err;
> > +
> > +	ASSERT_EQ(0,
> > +		  pthread_create(&no_sandbox_thread, NULL, thread_func, NULL));
> > +	create_signal_domain(_metadata);
> > +	ASSERT_EQ(0, pthread_create(&scoped_thread, NULL, thread_func, NULL));
> > +
> > +	/* Send signal to threads */
> > +	err = pthread_kill(no_sandbox_thread, 0);
> > +	ASSERT_EQ(EPERM, err);

Sometime the test failed because err == 0, I guess it's because I
removed the call to sleep(), but this just highlight a race condition in
the code anyway.  We would need a synchronization primitive to make sure
the thread is still alive, something like the pipe read/write.

> > +
> > +	err = pthread_kill(scoped_thread, 0);
> > +	ASSERT_EQ(0, err);
> > +
> > +	ASSERT_EQ(0, pthread_join(scoped_thread, NULL));
> > +	ASSERT_EQ(0, pthread_join(no_sandbox_thread, NULL));
> > +}
> > +
> >  TEST_HARNESS_MAIN
> > -- 
> > 2.34.1
> > 
> > 

