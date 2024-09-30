Return-Path: <netdev+bounces-130367-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B74B598A3CB
	for <lists+netdev@lfdr.de>; Mon, 30 Sep 2024 14:59:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 75AC6281CFC
	for <lists+netdev@lfdr.de>; Mon, 30 Sep 2024 12:59:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72AFB19049B;
	Mon, 30 Sep 2024 12:57:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yeU53eZV"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9823519004D
	for <netdev@vger.kernel.org>; Mon, 30 Sep 2024 12:57:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727701036; cv=none; b=WSffxovcGk27sv3Oadja2fADIVpQxboi6Kt9awwRw8PIpOUjvmnU2WY7FFu0L2vNCNeou5FZ+hiFk6WmBoxIQikI9eBjBEVKLCZBQL77P8uix9r/As6bgMcFnEKmrutLrDP5MOso2Tq+MJ02IPY0UlT7lQl0XX+uN9OB8kMqrXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727701036; c=relaxed/simple;
	bh=uYDILTZ0OuV9ymbF82FF+lZsQByJBzc+anI+t8B0rxw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YSYcuCQvhWsVjgz3O8tuV+ZM8dbFKlQizKFC7Hh/H39Tz1BsRywp5tCQmW66hzOJJtE+P536JHEz5uVPIkdJYOc2t1HXqtSEJ5PK35MEUTNjQAaSX4w0EzG6PmAXKibfmRlCGKUymrUMgMaRXONNq1fgPOgpGEUnfzaGj+Mh2TA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=yeU53eZV; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5c88b5c375fso2759143a12.3
        for <netdev@vger.kernel.org>; Mon, 30 Sep 2024 05:57:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1727701033; x=1728305833; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+DQgaaXdctNkKbqsrVWkdnT+P9Zhh+LtAshAU9bhmOc=;
        b=yeU53eZV7ixLB4bSvDXP9BtxpWEu5GnRIXoyk2ZV9NDmuU2+i7JcKo5+unj84lfImf
         doY1JcQ9KjcsOqFz4171O30w/+9CKEtiIeOshXzUn5lkRh6ivOaXBwewCyaMkyXX1Ijo
         60V9G6P5yzDbJ6WD6R/ndhxuOyRgRXLWnfBzGhTHQa9prgnuAeBLah0xEh6+u6YPE3El
         2bg72ZipdxiXc5YIeskyspkr7l9Frl01kExPR/YhnJHLVWAhsxF8Q8OWOYfIljpUWaTv
         wFjVH0ltgFWq+1Sy6NR8YO0egVlxnA311sTHyK2Ss53xpOpJWUBo0yEnCDF3Q2GfoUFS
         6A3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727701033; x=1728305833;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+DQgaaXdctNkKbqsrVWkdnT+P9Zhh+LtAshAU9bhmOc=;
        b=egTXKIbD8aS4fEK/LB9HBX6eMiuQRdBOT4gDS/VX9uf5mJpYixQPzq6y4JUQLqpM9L
         ioMgMc4jIxkXMpnshJ7N43NoL2iXAwyzDDInke85iFlwpYmxMQBqN3tYbABqXMctLnMJ
         e7MCYcYCnvW4PDqb2vww/0LwbURqgKOduBiOs1p2IPsRlHB38mU8Lp6QxwB4COve7Pgu
         o+qTKXb4U2oRf8+3H6MxJyJvA+1w6zB+ofWtKHPIbfQmJWJogJIY/4kZ8HehwvwxntgA
         M8GAKBtwYf8ckTancZa+T/JoLsXvYIri3l6qcmjQDzoNasbuNCyHgM51lnyAoZppwQr4
         VpUA==
X-Forwarded-Encrypted: i=1; AJvYcCUm1en9fZcsHqJXwzD10BLUQJNb8MMa4sy7vXS/o0zGYuRtIa7z68GBZXwu0auqZ1TnRUVBEik=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5zi9nTD4ZW3HirlXHxo7uM5sty8KlZ0/1Nm4uz63Smm92/WHN
	dymxw2hxhD0p2qJayKj/60/ob6vOhXQH5OdGfao5OtJQX2AXQVWaqSkjmceYmGE=
X-Google-Smtp-Source: AGHT+IFBrSKTS6LI7QA565Uk6LSxPcjcQvIGy53O7BM6eu32Xr+uoVdxUX2uFApOrsQJRCYfeR0Awg==
X-Received: by 2002:a05:6402:42c4:b0:5c5:cbfd:b3a8 with SMTP id 4fb4d7f45d1cf-5c8824ccc12mr10308930a12.1.1727701032913;
        Mon, 30 Sep 2024 05:57:12 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c88245ec1bsm4683767a12.44.2024.09.30.05.57.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Sep 2024 05:57:12 -0700 (PDT)
Date: Mon, 30 Sep 2024 15:57:08 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
	amadeuszx.slawinski@linux.intel.com,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	nex.sw.ncis.osdt.itp.upstreaming@intel.com, netdev@vger.kernel.org,
	Andy Shevchenko <andriy.shevchenko@intel.com>
Subject: Re: [RFC PATCH] cleanup: make scoped_guard() to be return-friendly
Message-ID: <bf348b5d-f6d5-4315-b072-cc1175ca4eff@stanley.mountain>
References: <20240926134347.19371-1-przemyslaw.kitszel@intel.com>
 <10515bca-782a-47bf-9bcd-eab7fd2fa49e@stanley.mountain>
 <bb531337-b155-40d2-96e3-8ece7ea2d927@intel.com>
 <faff2ffd-d36b-4655-80dc-35f772748a6c@stanley.mountain>
 <84f41bd3-2e98-4d69-9075-d808faece2ce@intel.com>
 <129309f3-93d6-4926-8af1-b8d5ea995d48@stanley.mountain>
 <e86748a9-6b72-4404-9042-c9b6308a9bc1@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e86748a9-6b72-4404-9042-c9b6308a9bc1@intel.com>

On Mon, Sep 30, 2024 at 01:30:58PM +0200, Przemek Kitszel wrote:
> > but your macro is wrong and will need to be re-written
> 
> could you please elaborate here?

- 		__guard_ptr(_name)(&scope) && !done;
+		__guard_ptr(_name)(&scope), 1;     \

The __guard_ptr(_name)(&scope) check is checking whether lock function
succeeded.  With the new macro we only use scoped_guard() for locks which can't
fail.  We can (basically must) remove the __guard_ptr(_name)(&scope) check since
we're ignoring the result.

There are only four drivers which rely on conditional scoped_guard() locks.

$ git grep scoped_guard | egrep '(try|_intr)'
drivers/input/keyboard/atkbd.c: scoped_guard(mutex_intr, &atkbd->mutex) {
drivers/input/touchscreen/tsc200x-core.c:       scoped_guard(mutex_try, &ts->mutex) {
drivers/input/touchscreen/wacom_w8001.c:        scoped_guard(mutex_intr, &w8001->mutex) {
drivers/platform/x86/ideapad-laptop.c:  scoped_guard(mutex_intr, &dytc->mutex) {

This change breaks the drivers at runtime, but you need to ensure that drivers
using the old API will break at compile time so that people don't introduce new
bugs during the transition.  In other words, you will need to update the
DEFINE_GUARD_COND() stuff as well.

$ git grep DEFINE_GUARD_COND
include/linux/cleanup.h: * DEFINE_GUARD_COND(name, ext, condlock)
include/linux/cleanup.h:#define DEFINE_GUARD_COND(_name, _ext, _condlock) \
include/linux/iio/iio.h:DEFINE_GUARD_COND(iio_claim_direct, _try, ({
include/linux/mutex.h:DEFINE_GUARD_COND(mutex, _try, mutex_trylock(_T))
include/linux/mutex.h:DEFINE_GUARD_COND(mutex, _intr, mutex_lock_interruptible(_T) == 0)
include/linux/rwsem.h:DEFINE_GUARD_COND(rwsem_read, _try, down_read_trylock(_T))
include/linux/rwsem.h:DEFINE_GUARD_COND(rwsem_read, _intr, down_read_interruptible(_T) == 0)
include/linux/rwsem.h:DEFINE_GUARD_COND(rwsem_write, _try, down_write_trylock(_T))

I propose that you use scoped_try_guard() and scoped_guard_interruptible() to
support conditional locking.  Creating different macros for conditional locks is
the only way you can silence your GCC warnings and it makes life easier for me
as a static checker developer as well.  It's probably more complicated than I
have described so I'll leave that up to you, but this first draft doesn't work.

regards,
dan carpenter

