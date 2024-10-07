Return-Path: <netdev+bounces-132669-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B526992BBF
	for <lists+netdev@lfdr.de>; Mon,  7 Oct 2024 14:29:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 295FB280FA0
	for <lists+netdev@lfdr.de>; Mon,  7 Oct 2024 12:29:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3B4E1D26E8;
	Mon,  7 Oct 2024 12:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MZ0poWZ5"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FF8118BC03;
	Mon,  7 Oct 2024 12:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728304190; cv=none; b=HjwKkOjZmYPKTnIm6pqxXMkrVnBUX8fb9mzZlNi1r0C/PzLLgEsVLzA9SMVw263T+mwnWMnV/KErgUjvJoLj8ZGMlFH13/LzN++GMEyhnkFRZJlNDbePv1WJo3qRGxjLeFzao07AEa0AhMQtVIn4xdsH0EDEnX81FVAlFf0/TGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728304190; c=relaxed/simple;
	bh=S0PmYZ88hEZrLiL/PiuJ/v9Q7mo3hEoRYd3HOJjCjwk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GOzHeWLrwDAlzvnQkdVuK1V404xxjfznPRVYyVNs/WClG016EZEnHj7fW0uI4L4mUs6i+H2M62ZVSPpMHw2TIStv6vJvudTV2AhDy2LH+kb8TfiwAYa9clAr7zSKoIsYQewUVmgk6OMxse/tib4AIL/6Rh4wQk4wc7KH2nsHtBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MZ0poWZ5; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-6cb2e5d0104so32241926d6.3;
        Mon, 07 Oct 2024 05:29:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728304188; x=1728908988; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XoM4lIRKq6wt6tvordN282TXwd9yd9Pg0kZvSLGS/L4=;
        b=MZ0poWZ5d5nJ8DnSHDuTfwunvHD/Ot2zNoAxAEdurWdzMyk6xpK+k4/an6fWdPuQYh
         eJMKckL7VNKBOljCCC4G46kD42ltFGoBtCP9Ngw7RrIisN7GfVhFvpjNTDHxPhyvQDSE
         l13z991WtY3HlFr7LPIlRsQOG/EkFGpWnQlVSfx6CKLtUPFW52sNQCUdwEAyT7TLnZBD
         qQKc/eWNLQcZiezlmZQAfue5w8/JvY+pj/0+TZQNvACk1IzHpqWSOYC8j58aAwPrnfA8
         2BK8vCDlMr0Ox1pCRRvLaaglVCUPzrzjgLZaOYItEOuwQDotis8vzZrqOU5KOPaR7hyL
         3yeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728304188; x=1728908988;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XoM4lIRKq6wt6tvordN282TXwd9yd9Pg0kZvSLGS/L4=;
        b=uD5erVJH4AG9AxFioCGZNZBRJwHT6NskCqebl0GKqj+EraWaMNCaqxIRSYSEd8kdie
         P46LKBT2g7qQxpzNt2AARQ0F4n/ixk0MAXdqhCYUtVeec5VuoIR1ZV7M2H41Ujutzyht
         dOCASHzTQlZGYo3aUo8usEgoDc3SRXvlCN6lg9pGXNwC8JbxqzNTR49z097veaQWCdgJ
         XT93Yhy2QB4PgEEPp2lSeqqyUo4dT+fij4YLq6CY880/9ssGsfaYwtZQIT7slYnxJlpD
         5ext59OUfJ4wLIXpdIN1whsWwtHuH085BDUoiFqxfP1m+CF8fZlWHEVSImB0Er+tFpOj
         WDUg==
X-Forwarded-Encrypted: i=1; AJvYcCWXgCHRV8gZN9qlAuHa+kRjbLC5I+SV1rSRtmYghBxX3I0CzpN8MKqsM5YWXTuHViW/hvpJvwuUHwh6wzm0dhM=@vger.kernel.org, AJvYcCWfEuvXd04f9p3mPP7x63rlLfzm3v8AYtFrrzahAQW+X0F4UB0rOdUQSTmjZKpuxUzFpyGAIGWT@vger.kernel.org, AJvYcCXKxeBDKOrZDAW26V7jzf13sdTgKUVq+dGrhCWAdpdBrWy4lZhP+L7pyW/xoBQ3h5Dqtte9QbfOpcetazQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8Qa8YmGkxrhrJ/rrg+BhiFpFX62wqZMpJGxjYJC4gBzFke4Ko
	y9KmAaG3I71paqiAi9MrIx50LUe3M8c2E4/xJD4fmU7IKuZubOkd
X-Google-Smtp-Source: AGHT+IGEyeCqIjlSUSKGI4oWYd+KNlZgB0SFN8Z4gxmCPqUzAoWZwMhyG/fWX8kWZY3LWknsznciFQ==
X-Received: by 2002:a05:6214:5684:b0:6cb:3b9b:1673 with SMTP id 6a1803df08f44-6cb9a4fbdd5mr176978746d6.49.1728304188014;
        Mon, 07 Oct 2024 05:29:48 -0700 (PDT)
Received: from fauth-a1-smtp.messagingengine.com (fauth-a1-smtp.messagingengine.com. [103.168.172.200])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6cba46efeddsm25227246d6.71.2024.10.07.05.29.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Oct 2024 05:29:47 -0700 (PDT)
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfauth.phl.internal (Postfix) with ESMTP id CBF3E120006B;
	Mon,  7 Oct 2024 08:29:46 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Mon, 07 Oct 2024 08:29:46 -0400
X-ME-Sender: <xms:OtQDZyCv97xoN1FWH6QL8w2dK5iLh5iuZS8I8EVp8ViJx6PZ8Tov-g>
    <xme:OtQDZ8hsQnanpkzGQcdV9to7iarQBkrGzTWXszY7oqP-J2cKx87_qAtWWwaKn0p1e
    7raZFAGRARza2laUw>
X-ME-Received: <xmr:OtQDZ1lZxLcebLFYxul1fFCnIxWareSXd3moacpuzTMH9ZkhdbsnhdtoqD92Ig>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvddvledghedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomhepuehoqhhunhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrd
    gtohhmqeenucggtffrrghtthgvrhhnpeeigeethfejvdfhudegtdevtefhleelffegteev
    tdelgfeugefhhffhteegiefhheenucffohhmrghinheplhifnhdrnhgvthenucevlhhush
    htvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsohhquhhnodhmvghs
    mhhtphgruhhthhhpvghrshhonhgrlhhithihqdeiledvgeehtdeigedqudejjeekheehhe
    dvqdgsohhquhhnrdhfvghngheppehgmhgrihhlrdgtohhmsehfihigmhgvrdhnrghmvgdp
    nhgspghrtghpthhtohepudelpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegrnh
    gurhgvfieslhhunhhnrdgthhdprhgtphhtthhopehfuhhjihhtrgdrthhomhhonhhorhhi
    sehgmhgrihhlrdgtohhmpdhrtghpthhtohepnhgvthguvghvsehvghgvrhdrkhgvrhhnvg
    hlrdhorhhgpdhrtghpthhtoheprhhushhtqdhfohhrqdhlihhnuhigsehvghgvrhdrkhgv
    rhhnvghlrdhorhhgpdhrtghpthhtohephhhkrghllhifvghithdusehgmhgrihhlrdgtoh
    hmpdhrtghpthhtohepthhmghhrohhsshesuhhmihgthhdrvgguuhdprhgtphhtthhopeho
    jhgvuggrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegrlhgvgidrghgrhihnohhrse
    hgmhgrihhlrdgtohhmpdhrtghpthhtohepghgrrhihsehgrghrhihguhhordhnvght
X-ME-Proxy: <xmx:OtQDZwxtz3fxqqg9zam0wKbkTd52nmytCjdrRCXtIHG_aFQDmoAQ7g>
    <xmx:OtQDZ3T6nYowzw0MAuXho6wIjZY1C8GacVyWYyZ8xXzkIPcLZsDndg>
    <xmx:OtQDZ7Z3HvDpMPnE47YoCfmx3UGzaA7RsU8AANTb47l_jkskvhRpiQ>
    <xmx:OtQDZwQO7D6aAYnO1IxRPH62lNc73hiDuBNxZ9xpwHQf1M0gxmDGIQ>
    <xmx:OtQDZ5Bcekv_zvj5qcQ2luZ4a8Q5kNVioYZYrr83jZNS7EJzAWzPbKpV>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 7 Oct 2024 08:29:46 -0400 (EDT)
Date: Mon, 7 Oct 2024 05:28:28 -0700
From: Boqun Feng <boqun.feng@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: FUJITA Tomonori <fujita.tomonori@gmail.com>, netdev@vger.kernel.org,
	rust-for-linux@vger.kernel.org, hkallweit1@gmail.com,
	tmgross@umich.edu, ojeda@kernel.org, alex.gaynor@gmail.com,
	gary@garyguo.net, bjorn3_gh@protonmail.com, benno.lossin@proton.me,
	a.hindborg@samsung.com, aliceryhl@google.com,
	anna-maria@linutronix.de, frederic@kernel.org, tglx@linutronix.de,
	arnd@arndb.de, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2 5/6] rust: Add read_poll_timeout function
Message-ID: <ZwPT7HZvG1aYONkQ@boqun-archlinux>
References: <20241005122531.20298-1-fujita.tomonori@gmail.com>
 <20241005122531.20298-6-fujita.tomonori@gmail.com>
 <06cbea6a-d03e-4c89-9c05-4dc51b38738e@lunn.ch>
 <ZwG8H7u3ddYH6gRx@boqun-archlinux>
 <e17c0b80-7518-4487-8278-f0d96fce9d8c@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e17c0b80-7518-4487-8278-f0d96fce9d8c@lunn.ch>

On Sun, Oct 06, 2024 at 04:45:21PM +0200, Andrew Lunn wrote:
[...]
> > > > +    if sleep {
> > > > +        // SAFETY: FFI call.
> > > > +        unsafe { bindings::might_sleep() }
> > > > +    }
> > > 
> > > What is actually unsafe about might_sleep()? It is a void foo(void)
> > 
> > Every extern "C" function is by default unsafe, because C doesn't have
> > the concept of safe/unsafe. If you want to avoid unsafe, you could
> > introduce a Rust's might_sleep() which calls into
> > `bindings::might_sleep()`:
> > 
> > 	pub fn might_sleep() {
> > 	    // SAFETY: ??
> > 	    unsafe { bindings::might_sleep() }
> > 	}
> > 
> > however, if you call a might_sleep() in a preemption disabled context
> > when CONFIG_DEBUG_ATOMIC_SLEEP=n and PREEMPT=VOLUNTERY, it could means
> > an unexpected RCU quiescent state, which results an early RCU grace
> > period, and that may mean a use-after-free. So it's not that safe as you
> > may expected.
> 
> If you call might_sleep() in a preemption disabled context you code is
> already unsafe, since that is the whole point of it, to find bugs

Well, in Rust, the rule is: any type-checked (compiled successfully)
code that only calls safe Rust functions cannot be unsafe. So the fact
that calling might_sleep() in a preemption disabled context is unsafe
means that something has to be unsafe.

This eventually can turn into a "blaming game" in the design space: we
can either design the preemption disable function as unsafe or the
might_sleep() function as unsafe. But one of them has to be unsafe
function, otherwise we are breaking the safe code guarantee.

However, this is actually a special case: currently we want to use klint
[1] to detect all context mis-matches at compile time. So the above rule
extends for kernel: any type-checked *and klint-checked* code that only
calls safe Rust functions cannot be unsafe. I.e. we add additional
compile time checking for unsafe code. So if might_sleep() has the
proper klint annotation, and we actually enable klint for kernel code,
then we can make it safe (along with preemption disable functions being
safe).

> where you use a sleeping function in atomic context. Depending on why
> you are in atomic context, it might appear to work, until it does not
> actually work, and bad things happen. So it is not might_sleep() which
> is unsafe, it is the Rust code calling it.

The whole point of unsafe functions is that calling it may result into
unsafe code, so that's why all extern "C" functions are unsafe, so are
might_sleep() (without klint in the picture).


[1]: https://lwn.net/Articles/951550/

Regards,
Boqun

> 
> 	Andrew
> 
> 
> 
> 

