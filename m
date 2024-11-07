Return-Path: <netdev+bounces-142696-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 830C19C00A0
	for <lists+netdev@lfdr.de>; Thu,  7 Nov 2024 09:57:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B54E51C21C6C
	for <lists+netdev@lfdr.de>; Thu,  7 Nov 2024 08:57:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30CDE1DF728;
	Thu,  7 Nov 2024 08:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="DOWGEyii"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 259BA1DC720
	for <netdev@vger.kernel.org>; Thu,  7 Nov 2024 08:56:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730969785; cv=none; b=El8vVzK1FM/6GsCi0RrJUIuqeZE2FVI9UhqT+/i/7zXSolm6OmzSdKcYhxE0RkPyTl5kQRppqer1VouV5ipxrqI33OO0pQw0eLkNvI0BQwud+FAR7JuVUhBqsjlTChu++ML3gYXTmlWSDB+kbK1Wbzu1NKmfKSWxSyS0fKM6CK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730969785; c=relaxed/simple;
	bh=CQNAGnUoGDZggfHjbjLDDTG4ahs/y5NdKS86iF+tVc8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ijdkokGc/algM1u2Q50wMooWX7a+lH/x5kXL2J7EEbjPEV7RV2nx12CiFoVmXjp/zCmNDTmeXP340IbcJsh5B9Hk3kfD3KodEABcj/rbjh0iz0nnrKACbhEDqZRLFxGAn+7iuTywZHZAm+W7D7wMse5BaKfiNffcAANp9LDQdWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=DOWGEyii; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-43158625112so6355375e9.3
        for <netdev@vger.kernel.org>; Thu, 07 Nov 2024 00:56:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1730969781; x=1731574581; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=NgQ+roLUSesIOXxkTR1/vCOejYMqb2hchyHM3frNze0=;
        b=DOWGEyiioKf63jsRA47ytgGZm5GjDARsMjZqT0cSdmFwlKW/B/lquzOxQz+ndnowmt
         q4auX5OE9Ock28shSoT7Ah+BkODCKE+VxxcdGO9SBa25dIT331EqNBPPjsCRYdlroSD1
         /vfCXmjZCtmGB+6h4cfCmO2Q4fH4mPQS/GVed4Mh2k15O7EVSgsqS8C6yccUJEqSKl/6
         ZzBa8zxTwnTvBSNlxyDn8jguY+nQVtyGd5qoZpXSsGHzR/Jj7qfUqWqOad+DvihIBXMK
         z4cwary2KqOSUkgOyy356tC9eofy7LGd9UtRgiY5K9vCXL5vvDbRJZ05mSEpOuqTobHw
         TVZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730969781; x=1731574581;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NgQ+roLUSesIOXxkTR1/vCOejYMqb2hchyHM3frNze0=;
        b=qZhhAqdLEbk3rzWD9VkVuKcd/z5Tur7Obq1HAp2YPmYdRc48x1XIz1I1wsTBsqXZyG
         SalKnGwNCZ1/P9vrY+1AVtkM8RXWbDcXFlxcK9gjkiimRnNSakBCDnpEkk0UDbbaiKpd
         cjQtTpuQlsJBNEsaNgInJSP2a4nM37/RoakPF1u0CMuCVnKJkS6NX4+uqGv0T5tPXVdW
         bPenP6558QGtelI3+7ZJrz3ou9uQ0q//gJQY3CWjhdM5rvPjdZxgt5DplXws2oXHOJy1
         CukOaRUq/0FRYntCYdnfnh7YEiPh8ncRT7VgopzkB8kieTj/T2AMo7NMhHy7QWKOF2Ki
         sXbw==
X-Forwarded-Encrypted: i=1; AJvYcCWbOKjAqt4q6gHQ3QwAZGHi9odjt1vxKFjv7QI9+qHs52602og9OLNqeFMGEWocfcnifvihfp0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwHgNsFbOjgo4Pm1EaRjYT9q5myDhHOToYcBDw6Nv1MLuAvmi1W
	Z50MwA7q9tcHNhFVmt/8e9J79D+8G6qIHrLnLvC31tGAVPwxWYKsFoxuU5eGa3Q=
X-Google-Smtp-Source: AGHT+IFXLdmKW/NhLS7COiH0rxP4pldjP5IIgC/oTWxhlDbhZ9wQ9LD2MxcsYmvJtsQzv8dU50mXfQ==
X-Received: by 2002:a5d:6d8a:0:b0:37c:d244:bdb1 with SMTP id ffacd0b85a97d-381c7a5e8c9mr16982507f8f.26.1730969781547;
        Thu, 07 Nov 2024 00:56:21 -0800 (PST)
Received: from pathway.suse.cz ([176.114.240.50])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-381ed9ea653sm1096170f8f.65.2024.11.07.00.56.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Nov 2024 00:56:21 -0800 (PST)
Date: Thu, 7 Nov 2024 09:56:18 +0100
From: Petr Mladek <pmladek@suse.com>
To: Boqun Feng <boqun.feng@gmail.com>
Cc: FUJITA Tomonori <fujita.tomonori@gmail.com>, anna-maria@linutronix.de,
	frederic@kernel.org, tglx@linutronix.de, jstultz@google.com,
	sboyd@kernel.org, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, rust-for-linux@vger.kernel.org,
	andrew@lunn.ch, hkallweit1@gmail.com, tmgross@umich.edu,
	ojeda@kernel.org, alex.gaynor@gmail.com, gary@garyguo.net,
	bjorn3_gh@protonmail.com, benno.lossin@proton.me,
	a.hindborg@samsung.com, aliceryhl@google.com, arnd@arndb.de,
	Steven Rostedt <rostedt@goodmis.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: Re: [PATCH v5 6/7] rust: Add read_poll_timeout functions
Message-ID: <ZyyAsjsz05AlkOBd@pathway.suse.cz>
References: <20241101010121.69221-1-fujita.tomonori@gmail.com>
 <20241101010121.69221-7-fujita.tomonori@gmail.com>
 <ZyvhDbNAhPTqIoVi@boqun-archlinux>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZyvhDbNAhPTqIoVi@boqun-archlinux>

On Wed 2024-11-06 13:35:09, Boqun Feng wrote:
> On Fri, Nov 01, 2024 at 10:01:20AM +0900, FUJITA Tomonori wrote:
> > Add read_poll_timeout functions which poll periodically until a
> > condition is met or a timeout is reached.
> > 
> > C's read_poll_timeout (include/linux/iopoll.h) is a complicated macro
> > and a simple wrapper for Rust doesn't work. So this implements the
> > same functionality in Rust.
> > 
> > The C version uses usleep_range() while the Rust version uses
> > fsleep(), which uses the best sleep method so it works with spans that
> > usleep_range() doesn't work nicely with.
> > 
> > Unlike the C version, __might_sleep() is used instead of might_sleep()
> > to show proper debug info; the file name and line
> > number. might_resched() could be added to match what the C version
> > does but this function works without it.
> > 
> > The sleep_before_read argument isn't supported since there is no user
> > for now. It's rarely used in the C version.
> > 
> > For the proper debug info, readx_poll_timeout() and __might_sleep()
> > are implemented as a macro. We could implement them as a normal
> > function if there is a clean way to get a null-terminated string
> > without allocation from core::panic::Location::file().
> > 
> 
> So printk() actually support printing a string with a precison value,
> that is: a format string "%.*s" would take two inputs, one for the length
> and the other for the pointer to the string, for example you can do:
> 
> 	char *msg = "hello";
> 
> 	printk("%.*s\n", 5, msg);
> 
> This is similar to printf() in glibc [1].
> 
> If we add another __might_sleep_precision() which accepts a file name
> length:
> 
> 	void __might_sleep_precision(const char *file, int len, int line)
> 
> then we don't need to use macro here, I've attached a diff based
> on your whole patchset, and it seems working.
> 
> Cc printk folks to if they know any limitation on using precision.

I am not aware of any printk() limitation here. The "%.*s" format
should work the same way as in printf() in the userspace.

Best Regards,
Petr


