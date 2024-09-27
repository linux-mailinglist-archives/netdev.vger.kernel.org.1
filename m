Return-Path: <netdev+bounces-130132-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2826E9887E2
	for <lists+netdev@lfdr.de>; Fri, 27 Sep 2024 17:05:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D85701F21A5B
	for <lists+netdev@lfdr.de>; Fri, 27 Sep 2024 15:04:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4B341C1720;
	Fri, 27 Sep 2024 15:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Pmt5XjIl"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2F061C0DF2
	for <netdev@vger.kernel.org>; Fri, 27 Sep 2024 15:04:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727449495; cv=none; b=Hh29CMoXbtHqYkgFTTXHoL9dB0Gn3ts0hl5wk5oaMnFa/fKWAHtQMdCU+4rSAoy3YQ0fUGI/vQaz7kXlpo1ucJKxg+A+7fk1XTsdKROvmDJ//vOXZporeOWr8mUZ5qEav/8QdWvsQTD5EukG5ufNUWroL6j7/Jik2Lt0S4Av04Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727449495; c=relaxed/simple;
	bh=b1w/fg2vuUrsIaac1S7x2w4DkH8UK4ZUa736Ygn9CB4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dkA8TnpZNZXUoWUrdAWbViwZJORArkVAicEaDpEHhLycdKtUY3XaRQnZyQowA3zx19Izekr04wLGdBDj28ocIaFRaGBZo+OlIQYz9XxMCM0Nbiun7okjSTmvuKsBlTaTPYSajIFBCnSRquLj4TemhUTJIz4MNp2pUmNVbiHEqeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Pmt5XjIl; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-5365cc68efaso2094101e87.1
        for <netdev@vger.kernel.org>; Fri, 27 Sep 2024 08:04:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1727449492; x=1728054292; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Kdb3sxyY0Y89Q7VoB1pToQxlwi4Aor0XMLQCqxsvDtw=;
        b=Pmt5XjIluKFo3fLqYfN2q656FhROlDaI2nucNQ5X6kHbbpskY/DUrpJLL9B/NV5mls
         kdApB9t9MmezrlKhKxCZNUiwb3M7ajcXQ6DIRVn7SPYJz3eWEsuBgMaOAVmF7xkBQd2U
         9cp4zYn9kQETM/a4+kMiNKJRbz2+q4VaVgdQrBIXI7gTRaasTT5MIEH20yo8TZ/sFx6k
         9QHud8qzv6GJ9RHCnzpF1N83VtSVCfUxU8HLbmtXtHTJPG5/LsqLnq4dtKHXHV1l8bMp
         +2+cxGAJ4kHRIrEmW4i8BrtAn4IyVyba46tqjEkWs26CDqTBKaBEXU+amU+b6pRBSJ8V
         JLrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727449492; x=1728054292;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Kdb3sxyY0Y89Q7VoB1pToQxlwi4Aor0XMLQCqxsvDtw=;
        b=D1zc6x28Bz5+5JaNuvQQEciyZHMYa6q9+pebZ/AtqGD9rSyyqN7VXcQVdnm8BfIhqy
         8JLqiJfYKke1tttL1lf811r+vjv0a1xAXAaFXLGMoHT1aRqMKy2q5DgcF+pW+rSFARXL
         6zipNQ5x+zX8jtlzlVji6sqRRo44lWB2fZDohvcC9aR9VcjpzW1w/xeLL4JMdmxZV+W2
         nSRzjbd/oB8fHP+NYk8WfRFUcEi7De05mdKWnj6twQuIC6QSIw9dM+EAQeyE619Yw6ot
         mOtBI5G+mfmJrxGjxluLjU/pGNNyMY+Gcto2fxOVGQQWQ5O9hupzpfglK9D215Ok3D6i
         BbKg==
X-Forwarded-Encrypted: i=1; AJvYcCXS+miyblxEMwlEyb/7ayAHtkkPEgxx4aT+5gE6nZIa6GuYz+SR4vtLJt744wJu1u8ezfmbU18=@vger.kernel.org
X-Gm-Message-State: AOJu0YyypNvASnVWFSg4eEBbeyXRTNVzPDT3SW5rcRlHoQOObjH9B9yb
	nZ2mTJI/oDY9ZUmhXmTKoeyO32BtfneKjCfXH3nh6onMrYlsDHlOdJJxsKTZabE=
X-Google-Smtp-Source: AGHT+IEkbC0hBETSpV1VyA/P+YGnw93lL3tjCkmjS5LBWjhQYp23MMcdoZThn7jnTSVH5K0wztGpbw==
X-Received: by 2002:a05:6512:3e0c:b0:533:901:e455 with SMTP id 2adb3069b0e04-5389fc33054mr2616556e87.2.1727449491372;
        Fri, 27 Sep 2024 08:04:51 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37cd564d33dsm2792233f8f.19.2024.09.27.08.04.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Sep 2024 08:04:50 -0700 (PDT)
Date: Fri, 27 Sep 2024 18:04:45 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Cc: linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
	amadeuszx.slawinski@linux.intel.com,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	nex.sw.ncis.osdt.itp.upstreaming@intel.com, netdev@vger.kernel.org,
	Andy Shevchenko <andriy.shevchenko@intel.com>
Subject: Re: [RFC PATCH] cleanup: make scoped_guard() to be return-friendly
Message-ID: <faff2ffd-d36b-4655-80dc-35f772748a6c@stanley.mountain>
References: <20240926134347.19371-1-przemyslaw.kitszel@intel.com>
 <10515bca-782a-47bf-9bcd-eab7fd2fa49e@stanley.mountain>
 <bb531337-b155-40d2-96e3-8ece7ea2d927@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bb531337-b155-40d2-96e3-8ece7ea2d927@intel.com>

On Fri, Sep 27, 2024 at 04:08:30PM +0200, Przemek Kitszel wrote:
> On 9/27/24 09:31, Dan Carpenter wrote:
> > On Thu, Sep 26, 2024 at 03:41:38PM +0200, Przemek Kitszel wrote:
> > > diff --git a/include/linux/cleanup.h b/include/linux/cleanup.h
> > > index d9e613803df1..6b568a8a7f9c 100644
> > > --- a/include/linux/cleanup.h
> > > +++ b/include/linux/cleanup.h
> > > @@ -168,9 +168,16 @@ static inline class_##_name##_t class_##_name##ext##_constructor(_init_args) \
> > >   #define __guard_ptr(_name) class_##_name##_lock_ptr
> > > -#define scoped_guard(_name, args...)					\
> > > -	for (CLASS(_name, scope)(args),					\
> > > -	     *done = NULL; __guard_ptr(_name)(&scope) && !done; done = (void *)1)
> > > +#define scoped_guard(_name, args...)	\
> > > +	__scoped_guard_labeled(__UNIQUE_ID(label), _name, args)
> > > +
> > > +#define __scoped_guard_labeled(_label, _name, args...)	\
> > > +	if (0)						\
> > > +		_label: ;				\
> > > +	else						\
> > > +		for (CLASS(_name, scope)(args);		\
> > > +		     __guard_ptr(_name)(&scope), 1;	\
> >                                                 ^^^
> > > +		     ({ goto _label; }))
> > 
> > Remove the ", 1".  The point of the __guard_ptr() condition is for try_locks
> > but the ", 1" means they always succeed.  The only try lock I can find in
> 
> You are right that the __guard_ptr() is conditional for the benefit of
> try_locks. But here we have unconditional lock. And removing ", 1" part
> makes compiler complaining with the very same message:
> error: control reaches end of non-void function [-Werror=return-type]
> 
> so ", 1" part is on purpose and must stay there to aid compiler.
> 
> > the current tree is tsc200x_esd_work().

Obviously, we can't break stuff and also checking __guard_ptr(_name)(&scope) is
pointless if we're going to ignore the return value.

But, sure, I get that we want to the compiler to know that regular spin_lock()
is going to succeed and spin_trylock() might not.  As a static checker
developer, I want that as well.  Currently, whenever someone creates a new class
of locks, I have to add a couple lines to Smatch to add this information.  It's
not a huge deal, but it would be nice to avoid this.

I did a `git grep scoped_guard | grep try` and I think tsc200x_esd_work() is the
only place which actually uses try locks with scoped_guard().  If it's just the
one, then why don't we create a scoped_guard_trylock() macro?

regards,
dan carpenter

