Return-Path: <netdev+bounces-130925-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5165698C179
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 17:21:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 424401C242EA
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 15:21:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96E631C9EB6;
	Tue,  1 Oct 2024 15:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gbg/Mv9f"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED1041C68AE;
	Tue,  1 Oct 2024 15:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727796077; cv=none; b=aco+YcwahAMfhgdoQe5d+7gkIHDMC/HRDX07grYBrrThUD7TBlLB8/JqcatIsvp/FcIltHQrzbBXZx4Fnn1oQOXARTbJ6pcjeZ/BiWmVZQOYS1CQH+9SrMibftLNRIQsSY964c2fbYvrsQEI4BWhbHLwX9CKnVfK2uSpDKXrR8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727796077; c=relaxed/simple;
	bh=rKpJK045yOUQYrUJUfRLbFAkjNODVSQKbi3X2OSY+aU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qQz2A3ye/0ju2x1F14VgAOmBxvj4ZkWTy8hTziZLbDh7T0Ny6JQcVbfpYQKV/+mS57VHUpUwm7hVcS9pbr7VzwLrDP/TpZP+Uk5xkkixZBY9CrU5sIXr1HeVQKdoeL2XojNEUFzEFZ5AxVTfxOhkSj5fVYI52lCPmC6vrA/uNTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gbg/Mv9f; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-71dc4451fffso272114b3a.2;
        Tue, 01 Oct 2024 08:21:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727796075; x=1728400875; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=03TXtWkO6HP34UqSezEjRrjM1fhv5wLXUvaz96nM3WI=;
        b=gbg/Mv9f+mrYXRbZIiGIAAoFzvYA53eGBxmPuwye/CvAx6VP176AQjbjsmYQ6tpg+j
         sAIhbq5s3AiTQrxsrNaPIkZVB1cidmRnJ5XFbyJz5LMgUvfUfrrCkCXIQTUuzdXfc8pj
         8e1MmDxnwqr+gc/cFVZqB3UbqgffoD70ZcRl7fM+2hVKijo/wW1AB2l1Y+fh2zgBxUTY
         Mt3rw7ihF19t8ZdlL+OoP3c4nJaSzOQSL3x4pdUbXELQL9NA7UcLSOb4Uo6/L5mEG5P2
         PdN8bPtJhwo+8ktZ86SRCpgLKYQteV1SWGuMOtWCWAEFKCw/mWGeBFuWn+TgxzoXVPQQ
         WGaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727796075; x=1728400875;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=03TXtWkO6HP34UqSezEjRrjM1fhv5wLXUvaz96nM3WI=;
        b=vkFrLyqh/il+2b35BR1tZosHven3S2HK8pknrfzXUWKlki1RKp6Ghrft4W5maiBrS8
         ahOdmPOalY2M5gKknRmS6kZ1aum303ZrrkXX+ZY50lm9VQfbcwPXwaUKLdWLi2ae13VU
         b0IMenzj1RVH43UioEF3uhshc7y3b4vrZj7uXPOlENIijwtGEtAVuMs2z495HqXajmw6
         8yWjya1Ob+UpNas82ePbiXeXYtWcQig4n59cM1v+f/fWKPNdsziqS0Y2YUsX+xthGbyQ
         JP6NKxaPg0fL/nLNUJ8MKOkTcgRKUhS8oDpJsOubCIR57hP5afvgIQaE3v8TjYaAIEGu
         +ueA==
X-Forwarded-Encrypted: i=1; AJvYcCWF4OBEUxz4ZPMSVAnUdkiyMhKKEXe2s1gR5u0Jyj+51BYU9Ui/IQdDBkaEbhZjuCFd/hhMgJM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzOLBBy0OhkkeS2H/RihFXgy20peO/YYK8LXxYwTP7Z4P4wyz3L
	H90IaiTrQ4dE7WMPoNDfKgrcst5cpcpe8NMYqR8U/FF4i0F8JAyz
X-Google-Smtp-Source: AGHT+IGoZwnPm5Q/zENRpNMz3JFgJ3SPGAzrKBRPJCVyQiLbaTKWcaTfOonVAbaet21LB0GoZ9s/Mw==
X-Received: by 2002:a05:6a20:d818:b0:1d5:14ff:a153 with SMTP id adf61e73a8af0-1d5db20a5a9mr158291637.12.1727796075045;
        Tue, 01 Oct 2024 08:21:15 -0700 (PDT)
Received: from google.com ([2620:15c:9d:2:70a4:8eee:1d3f:e71d])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71b264c2560sm8115317b3a.87.2024.10.01.08.21.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Oct 2024 08:21:14 -0700 (PDT)
Date: Tue, 1 Oct 2024 08:21:11 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Cc: linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
	amadeuszx.slawinski@linux.intel.com,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	nex.sw.ncis.osdt.itp.upstreaming@intel.com, netdev@vger.kernel.org,
	Markus Elfring <Markus.Elfring@web.de>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Andy Shevchenko <andriy.shevchenko@intel.com>
Subject: Re: [RFC PATCH v2] Simply enable one to write code like:
Message-ID: <ZvwTZxN1F6X6Wd2i@google.com>
References: <20241001145718.8962-1-przemyslaw.kitszel@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241001145718.8962-1-przemyslaw.kitszel@intel.com>

Hi Przemek,

On Tue, Oct 01, 2024 at 04:57:18PM +0200, Przemek Kitszel wrote:
> int foo(struct my_drv *adapter)
> {
> 	scoped_guard(spinlock, &adapter->some_spinlock)
> 		return adapter->spinlock_protected_var;
> }

Could you change the subject to say something like:

"Adjust cond_guard() implementation to avoid potential warnings"

And then give detailed explanation in the body?

> 
> Current scoped_guard() implementation does not support that,
> due to compiler complaining:
> error: control reaches end of non-void function [-Werror=return-type]
> 
> One could argue that for such use case it would be better to use
> guard(spinlock)(&adapter->some_spinlock), I disagree. I could also say
> that coding with my proposed locking style is also very pleasant, as I'm
> doing so for a few weeks already.

I'd drop this paragraph from the patch description (and moved past "---"
if you prefer to keep it for additional context.

> 
> Technical stuff about the change:
> scoped_guard() macro uses common idiom of using "for" statement to declare
> a scoped variable. Unfortunately, current logic is too hard for compiler
> diagnostics to be sure that there is exactly one loop step; fix that.
> 
> To make any loop so trivial that there is no above warning, it must not
> depend on any variable to tell if there are more steps. There is no
> obvious solution for that in C, but one could use the compound statement
> expression with "goto" jumping past the "loop", effectively leaving only
> the subscope part of the loop semantics.
> 
> More impl details:
> one more level of macro indirection is now needed to avoid duplicating
> label names;
> I didn't spot any other place that is using
> 	if (0) past_the_loop:; else for (...; 1; ({goto past_the_loop}))
> idiom, so it's not packed for reuse what makes actual macros code cleaner.
> 
> There was also a need to introduce const 0/1 variable per lock class, it
> is used to aid compiler diagnostics reasoning about "exactly 1 step" loops
> (note that converting that to function would undo the whole benefit).
> 
> NAKed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
> Signed-off-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> ---
> Andy believes that this change is completely wrong C, the reasons
> (that I disagree with of course, are in v1, below the commit message).
> 
> v2:
>  remove ", 1" condition, as scoped_guard() could be used also for
>  conditional locks (try-lock, irq-lock, etc) - this was pointed out by
>  Dmitry Torokhov and Dan Carpenter;
>  reorder macros to have them defined prior to use - Markus Elfring.
> 
> v1:
> https://lore.kernel.org/netdev/20240926134347.19371-1-przemyslaw.kitszel@intel.com
> ---
>  include/linux/cleanup.h | 23 ++++++++++++++++++++---
>  1 file changed, 20 insertions(+), 3 deletions(-)
> 
> diff --git a/include/linux/cleanup.h b/include/linux/cleanup.h
> index a3d3e888cf1f..72dcfeb3ec13 100644
> --- a/include/linux/cleanup.h
> +++ b/include/linux/cleanup.h
> @@ -151,12 +151,18 @@ static inline class_##_name##_t class_##_name##ext##_constructor(_init_args) \
>   *
>   */
>  
> +
> +#define DEFINE_CLASS_IS_CONDITIONAL(_name, _is_cond)	\

This is not supposed to be used outside of cleanup.h so probably
__DEFINE_CLASS_IS_CONDITIONAL()?
> +static __maybe_unused const bool class_##_name##_is_conditional = _is_cond
> +
>  #define DEFINE_GUARD(_name, _type, _lock, _unlock) \
> +	DEFINE_CLASS_IS_CONDITIONAL(_name, 0); \
>  	DEFINE_CLASS(_name, _type, if (_T) { _unlock; }, ({ _lock; _T; }), _type _T); \
>  	static inline void * class_##_name##_lock_ptr(class_##_name##_t *_T) \
>  	{ return *_T; }
>  
>  #define DEFINE_GUARD_COND(_name, _ext, _condlock) \
> +	DEFINE_CLASS_IS_CONDITIONAL(_name##_ext, 1); \
>  	EXTEND_CLASS(_name, _ext, \
>  		     ({ void *_t = _T; if (_T && !(_condlock)) _t = NULL; _t; }), \
>  		     class_##_name##_t _T) \
> @@ -167,10 +173,18 @@ static inline class_##_name##_t class_##_name##ext##_constructor(_init_args) \
>  	CLASS(_name, __UNIQUE_ID(guard))
>  
>  #define __guard_ptr(_name) class_##_name##_lock_ptr
> +#define __is_cond_ptr(_name) class_##_name##_is_conditional
> +
> +#define scoped_guard(_name, args...)	\
> +	__scoped_guard_labeled(__UNIQUE_ID(label), _name, args)
>  
> -#define scoped_guard(_name, args...)					\
> -	for (CLASS(_name, scope)(args),					\
> -	     *done = NULL; __guard_ptr(_name)(&scope) && !done; done = (void *)1)
> +#define __scoped_guard_labeled(_label, _name, args...)	\
> +	if (0)						\
> +		_label: ;				\
> +	else						\
> +		for (CLASS(_name, scope)(args);		\
> +		     __guard_ptr(_name)(&scope) || !__is_cond_ptr(_name); \
> +		     ({goto _label;}))

The "jump back" throws me a little, do you think if can be rewritten as:

	if (true)
		for (...)
	else
		_label: /* dummy */ ;

>  
>  #define scoped_cond_guard(_name, _fail, args...) \
>  	for (CLASS(_name, scope)(args), \

With your __is_cond_ptr() can this be made to warn or error if
scoped_cond_guard() is used with a non-conditional lock/class? As that
would make no sense.

> @@ -233,14 +247,17 @@ static inline class_##_name##_t class_##_name##_constructor(void)	\
>  }
>  
>  #define DEFINE_LOCK_GUARD_1(_name, _type, _lock, _unlock, ...)		\
> +DEFINE_CLASS_IS_CONDITIONAL(_name, 0);					\
>  __DEFINE_UNLOCK_GUARD(_name, _type, _unlock, __VA_ARGS__)		\
>  __DEFINE_LOCK_GUARD_1(_name, _type, _lock)
>  
>  #define DEFINE_LOCK_GUARD_0(_name, _lock, _unlock, ...)			\
> +DEFINE_CLASS_IS_CONDITIONAL(_name, 0);					\
>  __DEFINE_UNLOCK_GUARD(_name, void, _unlock, __VA_ARGS__)		\
>  __DEFINE_LOCK_GUARD_0(_name, _lock)
>  
>  #define DEFINE_LOCK_GUARD_1_COND(_name, _ext, _condlock)		\
> +	DEFINE_CLASS_IS_CONDITIONAL(_name##_ext, 1);			\
>  	EXTEND_CLASS(_name, _ext,					\
>  		     ({ class_##_name##_t _t = { .lock = l }, *_T = &_t;\
>  		        if (_T->lock && !(_condlock)) _T->lock = NULL;	\
> 
> base-commit: c824deb1a89755f70156b5cdaf569fca80698719
> -- 
> 2.39.3
> 

Thanks.

-- 
Dmitry

