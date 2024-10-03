Return-Path: <netdev+bounces-131635-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 38FC298F15A
	for <lists+netdev@lfdr.de>; Thu,  3 Oct 2024 16:26:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C6BA9282308
	for <lists+netdev@lfdr.de>; Thu,  3 Oct 2024 14:26:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 403F819CC1E;
	Thu,  3 Oct 2024 14:26:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P2BaHPem"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B629D1547DA;
	Thu,  3 Oct 2024 14:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727965602; cv=none; b=tjgFP0A+/wrylHD/DMnQbb/2Njyn7YVdptaLdiT5ILkZ2EGT1vszCflbqj1qQZe66rS+puKb19VUn52wHw6OB25n6hFbA+QeU3mjmHa9bB4V2x8oF9LreEVhTOXNBTS3rOqQNFdxWM7otOhytr33trs4Ddc7OUJxFYSvSS1O2aQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727965602; c=relaxed/simple;
	bh=WsQls8gTG97WzBo2lZzxpd5OCYHixSyTJkPAaW0+fgE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=STG1uKvzozsYDlR/YVd+8f0gfjHRiCUA+n107G/51WxYDXshbxLaompV0DveUeM7hJMAywVGKGdDfGkpto0BL6kVF2Jg80vxFdB6MvdaYU2mjPlhfPYKp6ON8N6V9u0Uaka+z4tlV//AXy0hrkHolCT7WPDZsXHd/3CwigTZZyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P2BaHPem; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-45d8f781d05so9997991cf.2;
        Thu, 03 Oct 2024 07:26:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727965599; x=1728570399; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m5NXMt7ReGG7pFY59h2tsoHZgimwmtp7liYzgOUuIS8=;
        b=P2BaHPempKw0WeXjeI9u1C4wq38ckgtL08ffnmhg+SEDqruLBktqe5KykutmAKZmKx
         f2OST8bVSWnRyB0xkqSit91Ecorstl4nkt1CkaHJhG0imizTmJQz3vfQT3o2jK517ZVz
         TeAuRJe7sYfkmRCyinN8P4l54wI79MvA3JiCwahcMfe+M5sAnpmbUpjIUZg7OYvwrHZh
         sdwIim2gj692xS/nXvWXFEcIbxnw7EnxAnxqiZckjKcoTksks8rVYBr//Ltkoscz1le0
         5a6+gt5s4KTQA6qrT3SdhE8BZnb79++GiZzfKMP+P2uCi5b4P24znw+sOPCjRdvxSQPZ
         k4QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727965599; x=1728570399;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m5NXMt7ReGG7pFY59h2tsoHZgimwmtp7liYzgOUuIS8=;
        b=LaraijVlax853f4rM1lZ2kBjYWcb1G3CvsOkvhaOe6JOLwHlq2pLMEjnTRTr76UcLm
         s3aANhLuh5Dy7ZPjVENhFUjVKdWQNKOqeY7v4nNSH90UOKOnhs5HhVkpKK7vwXJq2cDY
         6Hkz+ekKx6/dJ1jidv9eBhnnrc9gDx5IEVRavjx92MDqfJJACy5dy03kuGaEZOKc7j9N
         /3bKyeTSEUqv9iyglfmgnPT3cf4r+9NkCLFJxL8r+myJ+s2tH/RibZFUaU6e0XY+NUva
         qtdyziLPRbRtnEMhpIivIf3QW6Q96q+QmIniHSgOt1TjLsiF9TR4VyHkZ760xwji9ag3
         TvQA==
X-Forwarded-Encrypted: i=1; AJvYcCUjOkmdvw9wZ9CYxvaW1BWlfZDiB8K316dt2rjvaYjC88J5dPcDGnbTV6b9ftSJT9UPiOQJbBb7Wu95yf1WQws=@vger.kernel.org, AJvYcCVZiAany6Q0FiDFHIocUQCxkQ3ptQEwzC8pFEu6f4TvxueSACBD3K6MPfg0XacF9PjrXydJauA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxHe7WMNNvOV81Q+q0hIB7cJTTEXF/fvPJy9t0Ea9yiYSgF9Xz8
	88iXFWsIjqB3PSzgsqJJ/MK6cB6volY7IW9hqzMEOoYh/dir1C68
X-Google-Smtp-Source: AGHT+IHFFh7jrGWKJhyvwYYzypZqr8Aw84aKb7x0ewoHnYZoP3VEHU87TkQKx5Xz2Fu5pKE2k2Npdw==
X-Received: by 2002:a05:622a:15d5:b0:44f:f14c:6a63 with SMTP id d75a77b69052e-45d80492e82mr89664461cf.11.1727965599501;
        Thu, 03 Oct 2024 07:26:39 -0700 (PDT)
Received: from fauth-a1-smtp.messagingengine.com (fauth-a1-smtp.messagingengine.com. [103.168.172.200])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-45d92dde261sm5928271cf.20.2024.10.03.07.26.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Oct 2024 07:26:39 -0700 (PDT)
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfauth.phl.internal (Postfix) with ESMTP id 8DD391200069;
	Thu,  3 Oct 2024 10:26:38 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Thu, 03 Oct 2024 10:26:38 -0400
X-ME-Sender: <xms:nqn-Zp8IHsUOeixyhn8mX2edtUR3xN5Gqnf1HnpL7dnHe3BsXTM21g>
    <xme:nqn-ZtuhEgbnLbzp-ZZ2CjzlZtPOide-URATpa491hJJ6eZGEt45uxX8jqx4oJWCK
    zN73xBOwbk_Ae83Ag>
X-ME-Received: <xmr:nqn-ZnAEnmqHU3OODuQwkAIAWwtkMv9m0XxIYJ49MY4KH3UQ6mLupFvBSvk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvddvuddgjeehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomhepuehoqhhunhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrd
    gtohhmqeenucggtffrrghtthgvrhhnpefhtedvgfdtueekvdekieetieetjeeihedvteeh
    uddujedvkedtkeefgedvvdehtdenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuve
    hluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsghoqhhunhdo
    mhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqieelvdeghedtieegqddujeejke
    ehheehvddqsghoqhhunhdrfhgvnhhgpeepghhmrghilhdrtghomhesfhhigihmvgdrnhgr
    mhgvpdhnsggprhgtphhtthhopeduhedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoh
    epfhhujhhithgrrdhtohhmohhnohhrihesghhmrghilhdrtghomhdprhgtphhtthhopegu
    ihhrkhdrsggvhhhmvgesuggvrdgsohhstghhrdgtohhmpdhrtghpthhtoheprghnughrvg
    ifsehluhhnnhdrtghhpdhrtghpthhtoheprghlihgtvghrhihhlhesghhoohhglhgvrdgt
    ohhmpdhrtghpthhtohepnhgvthguvghvsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtg
    hpthhtoheprhhushhtqdhfohhrqdhlihhnuhigsehvghgvrhdrkhgvrhhnvghlrdhorhhg
    pdhrtghpthhtohephhhkrghllhifvghithdusehgmhgrihhlrdgtohhmpdhrtghpthhtoh
    epthhmghhrohhsshesuhhmihgthhdrvgguuhdprhgtphhtthhopehojhgvuggrsehkvghr
    nhgvlhdrohhrgh
X-ME-Proxy: <xmx:nqn-ZtfvZ9nPFAObVU2O-W1rXw28KJNryGYznIs9hew9MO6VVFcdQA>
    <xmx:nqn-ZuMMNLtNrUL6TMCKE3jfibNdBdw-7nPeUYYm1FrWEy1E9nLzSg>
    <xmx:nqn-ZvkK6LQvcIS58Pwv4wAsiESI6qCDki7XG08b-pDwv1QBFcm9SA>
    <xmx:nqn-Zovz0f6UUidio7VPDMq6-uwQ7ck2cJCfc9thvqcpULkY4SYovA>
    <xmx:nqn-ZgthCDf54kzlzsQiHZCbBZBEfE1MHa_qUQopNRH-eCjwnCMmGo3e>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 3 Oct 2024 10:26:37 -0400 (EDT)
Date: Thu, 3 Oct 2024 07:25:31 -0700
From: Boqun Feng <boqun.feng@gmail.com>
To: FUJITA Tomonori <fujita.tomonori@gmail.com>
Cc: dirk.behme@de.bosch.com, andrew@lunn.ch, aliceryhl@google.com,
	netdev@vger.kernel.org, rust-for-linux@vger.kernel.org,
	hkallweit1@gmail.com, tmgross@umich.edu, ojeda@kernel.org,
	alex.gaynor@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com,
	benno.lossin@proton.me, a.hindborg@samsung.com
Subject: Re: iopoll abstraction
Message-ID: <Zv6pW3Mn6qxHxTGE@boqun-archlinux>
References: <76d6af29-f401-4031-94d9-f0dd33d44cad@de.bosch.com>
 <20241002.095636.680321517586867502.fujita.tomonori@gmail.com>
 <Zv6FkGIMoh6PTdKY@boqun-archlinux>
 <20241003.134518.2205814402977569500.fujita.tomonori@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241003.134518.2205814402977569500.fujita.tomonori@gmail.com>

On Thu, Oct 03, 2024 at 01:45:18PM +0000, FUJITA Tomonori wrote:
> On Thu, 3 Oct 2024 04:52:48 -0700
> Boqun Feng <boqun.feng@gmail.com> wrote:
> 
> > You could use closure as a parameter to avoid macro interface, something
> > like:
> > 
> > 	fn read_poll_timeout<Op, Cond, T>(
> > 	    op: Op,
> > 	    cond: Cond,
> > 	    sleep: Delta,
> > 	    timeout: Delta,
> > 	) -> Result<T> where
> > 	    Op: Fn() -> T,
> > 	    cond: Fn() -> bool {
> > 
> > 	    let __timeout = kernel::Ktime::ktime_get() + timeout;
> > 
> > 	    let val = loop {
> > 		let val = op();
> > 		if cond() {
> > 		    break Some(val);
> > 		}
> > 		kernel::delay::sleep(sleep);
> > 
> > 		if __timeout.after(kernel::Ktime::ktime_get()) {
> > 		    break None;
> > 		}
> > 	    };
> > 
> > 	    if cond() {
> > 		val
> > 	    } else {
> > 		Err(kernel::error::code::ETIMEDOUT)
> > 	    }
> > 	}
> 
> Great! I changed couple of things.
> 
> 1. Op typically reads a value from a register and could need mut objects. So I use FnMut.
> 2. reading from hardware could fail so Op had better to return an error [1].
> 3. Cond needs val; typically check the value from a register.
> 
> [1] https://lore.kernel.org/netdev/ec7267b5-ae77-4c4a-94f8-aa933c87a9a2@lunn.ch
> 
> Seems that the following works QT2025 driver. How does it look?
> 

Makes sense to me. Of course, more users will probably tell us whether
we cover all the cases, but this is a good starting point. I would put
the function at kernel::io::poll, but that's my personal preference ;-)

Regards,
Boqun

> fn read_poll_timeout<Op, Cond, T: Copy>(
>     mut op: Op,
>     cond: Cond,
>     sleep: Delta,
>     timeout: Delta,
> ) -> Result<T>
> where
>     Op: FnMut() -> Result<T>,
>     Cond: Fn(T) -> bool,
> {
>     let timeout = Ktime::ktime_get() + timeout;
>     let ret = loop {
>         let val = op()?;
>         if cond(val) {
>             break Ok(val);
>         }
>         kernel::delay::sleep(sleep);
> 
>         if Ktime::ktime_get() > timeout {
>             break Err(code::ETIMEDOUT);
>         }
>     };
> 
>     ret
> }

