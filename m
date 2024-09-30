Return-Path: <netdev+bounces-130371-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C66A98A3FA
	for <lists+netdev@lfdr.de>; Mon, 30 Sep 2024 15:08:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 507561C203E1
	for <lists+netdev@lfdr.de>; Mon, 30 Sep 2024 13:08:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DAAB18E74D;
	Mon, 30 Sep 2024 13:08:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S+9ctvT8"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EB4617A924;
	Mon, 30 Sep 2024 13:07:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727701680; cv=none; b=IcuuYS4cn3huOQx1JOqBFPrNtHcztI60XrTR70/UMjneZRD0hI8pxMNsb+QKrXW/BIiZxNsVNvKf7JEqaEC1Bjr7kjxhmBdMKblwBdaabZByRRCSxtvmXeoFgGqigUc7pDW+JHfuEYzbVhShjvjSfsW0R7iuu3UUEzh4AYb9U7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727701680; c=relaxed/simple;
	bh=slBJildSLS8lvUx0hquew3Id4g/8MV7J25bixsZpogc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i/vKfXH+A9hEUlRL8GcuHIGerPsq9a1U3J+yqsuNxKPslSBnjvlvvHb1RLxTDYdhQd6zwDzmunwiXiQmiLdr5FfBXNcEsdjKiHovRY7hyMK4ztP16DIvYpSBR6qWatg2Z1kGQ1rpOdLvIBb9PYdXKNE+bcjf619OKw4JisNH0RM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S+9ctvT8; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-2e06f5d4bc7so3733829a91.2;
        Mon, 30 Sep 2024 06:07:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727701678; x=1728306478; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xtWyt8Wc5r3RiOGFMVOEwNeg5crfeCiOe+iG3jYozms=;
        b=S+9ctvT8GY6f+Jnzm2lqTPUIvN1Wzu9yBYKV4KB5lztP0i7XM0y7b7SLyfJVaDENbl
         jlZMFNUc1leVQpf8Sd+mEmNl6bHw0uaXb6YCLHhb4u7mdOzYJMyUIe1xrSw28eZ2bvHi
         cIjfvCgq49xD5qjKcLDJVPx/7t1+FjYezhkv7xqMLOSdHNTscpEXD4rF7LuFiZbjANMS
         VlcpAIKLUCm5pmGxM9fR/TXRexJck+bknp8hGQBr0Ck4Qio3sst31vMPfOx6UM4deLqC
         +6bGhS4dynWIHN/KlGQNgBf4qRrIx06XjCPcs3zzRLeoknGBCiU52lzFGPcO0Dm6UMvf
         2dLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727701678; x=1728306478;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xtWyt8Wc5r3RiOGFMVOEwNeg5crfeCiOe+iG3jYozms=;
        b=gsnUOf/EZ4hroqVRRmi+MXLaiOcC3L10jNQ4QpMw8EGRthomuPe3agpTjsI7N0cObE
         1fTOmh+UYu6kojg2H5hp1QCDfjzqZ0VYHlvMKpNm4zkizcdB9nVK0sZOlZNQlXL9Ab8b
         A4pCwUiwg/imZuWlzuzyYaQNvPKsSBKB+VkuPrXzp3nw6etUXWOwC0JNsneo9bQfvU70
         2gKfur1M1jC92tz35uukp0hGqkn+n2X77zJ8RkbDAdrWRXgG9/nQii24aCj+GaPbFR9M
         vJatE4loUJzrwEyNYgqq8eTW33WEQIHaD06vUQK6y8OAQEnxonuYcEdICiJ2KqHHv/NT
         SyNw==
X-Forwarded-Encrypted: i=1; AJvYcCU/pKetmIONZpUNFVZBwI4Ti2WpICf7PAgptnDnR6KBD5VJyTgyMLKeuA9/d6h/1GPpq7TMkTwP2XGScWo=@vger.kernel.org, AJvYcCUwH3SNbs0tI3yvVS1/wOEroIHl6YoJ5O5elLBFrqqtXgzJoj8WZJ0AH6oBScMAf8mOuDlDRyfL@vger.kernel.org
X-Gm-Message-State: AOJu0Yyb00dW2fI+UXjpa3Vhggy0ylM89Xb2QELeaq/+rPyH9PzE3Scn
	E49ondpabqj2mGEU2d13mCHQaLE044sjcyOJD+HdckIXVSa9fX4uGnZyl0Dhg54=
X-Google-Smtp-Source: AGHT+IGFNLMf9Iv3d8clzn2xPx0gj/ssQNa7jGMzoLycBLhjBOQZLwQAoSeXnLBfNSAY6BywqlIkuQ==
X-Received: by 2002:a17:90a:a009:b0:2d8:7561:db71 with SMTP id 98e67ed59e1d1-2e0b8ea16f8mr13833976a91.25.1727701678223;
        Mon, 30 Sep 2024 06:07:58 -0700 (PDT)
Received: from google.com ([2620:15c:9d:2:671d:78af:f80f:975b])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e0b6c6cbc8sm7888043a91.13.2024.09.30.06.07.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Sep 2024 06:07:57 -0700 (PDT)
Date: Mon, 30 Sep 2024 06:07:54 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
	amadeuszx.slawinski@linux.intel.com,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	nex.sw.ncis.osdt.itp.upstreaming@intel.com, netdev@vger.kernel.org,
	Andy Shevchenko <andriy.shevchenko@intel.com>
Subject: Re: [RFC PATCH] cleanup: make scoped_guard() to be return-friendly
Message-ID: <ZvqiqiAhn7EG_l_V@google.com>
References: <20240926134347.19371-1-przemyslaw.kitszel@intel.com>
 <10515bca-782a-47bf-9bcd-eab7fd2fa49e@stanley.mountain>
 <bb531337-b155-40d2-96e3-8ece7ea2d927@intel.com>
 <faff2ffd-d36b-4655-80dc-35f772748a6c@stanley.mountain>
 <84f41bd3-2e98-4d69-9075-d808faece2ce@intel.com>
 <129309f3-93d6-4926-8af1-b8d5ea995d48@stanley.mountain>
 <e86748a9-6b72-4404-9042-c9b6308a9bc1@intel.com>
 <bf348b5d-f6d5-4315-b072-cc1175ca4eff@stanley.mountain>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bf348b5d-f6d5-4315-b072-cc1175ca4eff@stanley.mountain>

On Mon, Sep 30, 2024 at 03:57:08PM +0300, Dan Carpenter wrote:
> On Mon, Sep 30, 2024 at 01:30:58PM +0200, Przemek Kitszel wrote:
> > > but your macro is wrong and will need to be re-written
> > 
> > could you please elaborate here?
> 
> - 		__guard_ptr(_name)(&scope) && !done;
> +		__guard_ptr(_name)(&scope), 1;     \
> 
> The __guard_ptr(_name)(&scope) check is checking whether lock function
> succeeded.  With the new macro we only use scoped_guard() for locks which can't
> fail.  We can (basically must) remove the __guard_ptr(_name)(&scope) check since
> we're ignoring the result.
> 
> There are only four drivers which rely on conditional scoped_guard() locks.
> 
> $ git grep scoped_guard | egrep '(try|_intr)'
> drivers/input/keyboard/atkbd.c: scoped_guard(mutex_intr, &atkbd->mutex) {
> drivers/input/touchscreen/tsc200x-core.c:       scoped_guard(mutex_try, &ts->mutex) {
> drivers/input/touchscreen/wacom_w8001.c:        scoped_guard(mutex_intr, &w8001->mutex) {
> drivers/platform/x86/ideapad-laptop.c:  scoped_guard(mutex_intr, &dytc->mutex) {

FTR I have many more pending changes using scoped_guard() this way.

> 
> This change breaks the drivers at runtime, but you need to ensure that drivers
> using the old API will break at compile time so that people don't introduce new
> bugs during the transition.  In other words, you will need to update the
> DEFINE_GUARD_COND() stuff as well.
> 
> $ git grep DEFINE_GUARD_COND
> include/linux/cleanup.h: * DEFINE_GUARD_COND(name, ext, condlock)
> include/linux/cleanup.h:#define DEFINE_GUARD_COND(_name, _ext, _condlock) \
> include/linux/iio/iio.h:DEFINE_GUARD_COND(iio_claim_direct, _try, ({
> include/linux/mutex.h:DEFINE_GUARD_COND(mutex, _try, mutex_trylock(_T))
> include/linux/mutex.h:DEFINE_GUARD_COND(mutex, _intr, mutex_lock_interruptible(_T) == 0)
> include/linux/rwsem.h:DEFINE_GUARD_COND(rwsem_read, _try, down_read_trylock(_T))
> include/linux/rwsem.h:DEFINE_GUARD_COND(rwsem_read, _intr, down_read_interruptible(_T) == 0)
> include/linux/rwsem.h:DEFINE_GUARD_COND(rwsem_write, _try, down_write_trylock(_T))
> 
> I propose that you use scoped_try_guard() and scoped_guard_interruptible() to
> support conditional locking.  Creating different macros for conditional locks is
> the only way you can silence your GCC warnings and it makes life easier for me
> as a static checker developer as well.  It's probably more complicated than I
> have described so I'll leave that up to you, but this first draft doesn't work.

No, please do not. Right now the whether resource acquisition can fail
or not is decided by a particular class (which in turn can be used in
various guard macros). You are proposing to bubble this knowledge up and
make specialized "try" and "interruptible" and "killable" and "fallible"
version of the previously generic macros.

Now, the whole issue is because GCC is unable to figure out the flow
control of a complex macro. Please either fix GCC or rework that one
call site to shut GCC up. Do not wreck nice generic guard
implementation, that is flexible and supports several styles of use.

Again, the fact that scoped_guard() body can be skipped if the
constructor fails is explicitly documented as a desirable property.

Thanks.

-- 
Dmitry

