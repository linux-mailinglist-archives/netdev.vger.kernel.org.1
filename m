Return-Path: <netdev+bounces-139272-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 411599B13CA
	for <lists+netdev@lfdr.de>; Sat, 26 Oct 2024 02:16:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 801131C21667
	for <lists+netdev@lfdr.de>; Sat, 26 Oct 2024 00:16:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 345113C00;
	Sat, 26 Oct 2024 00:16:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bg3LDsEA"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EC43101C8;
	Sat, 26 Oct 2024 00:16:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729901785; cv=none; b=VicN7njwNi0ubvymDzWRhQbg9ntlfLp4k82j8LFNRRftpONqjumdc646CjWfaH7RhJnnvNCkHFAjMbg2EbNoh/bp09Oqr2pwaGiAkUcIsKTWh4dZJGBtf8C7pa6k/iN0pStScUuchJkYPu0oTpUdPgFPuKwOIOecqA2akT0Pm/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729901785; c=relaxed/simple;
	bh=0YYjZlKKZjGTGx3E55nLceGD1IiO11vZqYeLy1CKweg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=awnIC03ouFVtKM3Uh+JgKU+/KqQrGXS4ny9E1qhBo2iTQBDTsb66Ijd+/SGrEf3vb/Hwbh6npaVugS5TgZDHBr1alhCo1H4nVOxS964hrlWZaC7ZQVBAPlJp/kdxzcuOQjzYQ1AN4kcbQSt7aVJeg/6C3NshoYaZ3/POb8hASd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Bg3LDsEA; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-7b14443a71eso220764185a.1;
        Fri, 25 Oct 2024 17:16:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729901782; x=1730506582; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L5jqDWioJcT+CdB0kHptEaZz9lMvMRlEfl3ufrxlt44=;
        b=Bg3LDsEAgQSjKxjYpQwXP+oS3xgUsys1RZhJUFTbvdmhL+DXvnsq/mDg3ylokRMo/N
         uWbES//TdTz+TnottoOWNF4qTNtHxyAaJzMctTrNOigKo23nNL7cytcJ5szUpslXigk8
         4Yl1Bwzbtxsf38MmO413OMI5N+zIz++7KqWmY1Yq4HS9AFcT4nAQkAQFBfQWMWMSbhJT
         cQRU1hfZdFh5i8p8BEd88SGMPqyn+TRQx5gH04tAv6mXQW8R0tW8HD8Yisgqa7Xkp/8n
         6OJS4TdOaVA5gWyo+StZGBLGkO5PlcSakZxZ/Mkz6giBligonLDzgA+niDL4cVGKNlyu
         8DaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729901782; x=1730506582;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=L5jqDWioJcT+CdB0kHptEaZz9lMvMRlEfl3ufrxlt44=;
        b=YzLmoeetboH0yeLdY5DMETscIKsw0TPaFhnNZhDDscT7nhJkCqYA/EMX+2mfdxuNKx
         r/hg6kFPCwf9nrRiuEEwkm//R45xvpS/wt4Q57A4hMJitbXLPCSSm4K5t/E2RStTw2nt
         VDQ30lBIrXYEvCvwiOsRhpXFobwqlOlIB0E1ZLqAx34oh2oA4Gu2kIhKK858xXRSavgF
         Tmh2b9K1HGuqw4F9b5q2KS4cmACid5Z/fLs36kENgTDfDnEXXSsMURAFMvVoHAKWyCOk
         BxEBVBfuagppGJaD1Tg8m+ycpnSy0AYrtIXjG8dnDNKVtYW3I8gt7H9xeTLycE2DJXbc
         jRgQ==
X-Forwarded-Encrypted: i=1; AJvYcCVL/uK7B3Ga5e5VtqMQrglW6lrReia6HqcVjkYse/ve2zvPxn1ILSLndKHeKYCzbfOR+CyEdHPl@vger.kernel.org, AJvYcCW/ikLmB+OLMPB1A6OssPEwENrSBM334a73ax5KVxLeCS9pPr/YZtZ3GLjzIWZyUoGVuvmwDqd4Vp/hGm2awtg=@vger.kernel.org, AJvYcCXfam/KYlYiYXNNlwJUPW3TF8d6MUZteBr5oEf8OXacSHzLDfjk7TAPb1sELcfUYRy7L1z7rQYpifpjJ/k=@vger.kernel.org
X-Gm-Message-State: AOJu0YxGvs7wzLUUw4CFCvDmkkDUXHBvHCEFa6K8OF1serAWbaYdkEee
	oNIQeXsgVQ8Sap6AipANJ1O3R4u2UCgKORbIobuB70xbruAndcyF
X-Google-Smtp-Source: AGHT+IHeFiJYbh8uDr/nqTI5DKY86Djkss7BSBhLVNy6u+0DDiXXbOseFc/cDm79528UbnvSJQMX6A==
X-Received: by 2002:a05:620a:4443:b0:7ae:5c67:e1b8 with SMTP id af79cd13be357-7b193eeaa8emr159896685a.20.1729901782072;
        Fri, 25 Oct 2024 17:16:22 -0700 (PDT)
Received: from fauth-a2-smtp.messagingengine.com (fauth-a2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b18d32bae9sm102098185a.87.2024.10.25.17.16.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Oct 2024 17:16:21 -0700 (PDT)
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfauth.phl.internal (Postfix) with ESMTP id B75F01200043;
	Fri, 25 Oct 2024 20:16:20 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Fri, 25 Oct 2024 20:16:20 -0400
X-ME-Sender: <xms:1DQcZ5Iupl80qTQh3bQDweuLXoqR-o_dlCmvGOh7iARGFnqHK7NfyQ>
    <xme:1DQcZ1IcJ9p48JbRSiDFFgM667fAnqCm3h42avr0PgpnPnZxfzHtJO_8eQlfXbsEV
    rpxYq4UhMA3SDqQVQ>
X-ME-Received: <xmr:1DQcZxsTETW--ieoDa2buViIstze0kSYUQxdy-VAkuS2GCtLvUqvv1vG6TE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdejfedgfedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomhepuehoqhhunhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrd
    gtohhmqeenucggtffrrghtthgvrhhnpefhtedvgfdtueekvdekieetieetjeeihedvteeh
    uddujedvkedtkeefgedvvdehtdenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuve
    hluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsghoqhhunhdo
    mhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqieelvdeghedtieegqddujeejke
    ehheehvddqsghoqhhunhdrfhgvnhhgpeepghhmrghilhdrtghomhesfhhigihmvgdrnhgr
    mhgvpdhnsggprhgtphhtthhopedvuddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoh
    epfhhujhhithgrrdhtohhmohhnohhrihesghhmrghilhdrtghomhdprhgtphhtthhopegr
    nhhnrgdqmhgrrhhirgeslhhinhhuthhrohhnihigrdguvgdprhgtphhtthhopehfrhgvug
    gvrhhitgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepthhglhigsehlihhnuhhtrhho
    nhhigidruggvpdhrtghpthhtohepjhhsthhulhhtiiesghhoohhglhgvrdgtohhmpdhrtg
    hpthhtohepshgsohihugeskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidq
    khgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepnhgvthguvg
    hvsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprhhushhtqdhfohhrqdhl
    ihhnuhigsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:1DQcZ6bQNjs1hphH1tCCMyuXyb3Ke6YnlYMdggN7xBtvUdaFGgLxMg>
    <xmx:1DQcZwa_F_9WEyGQTEQZ9OqGYVzKUAEcKkJitrIRnpUmVcEY7ItfJw>
    <xmx:1DQcZ-BVKsGWQbPb-fRtw1M0mgrvLv208IQDU1wFUx3qrawVlM0f2Q>
    <xmx:1DQcZ-ZhSyXKWAWDpiuHgmXz5yJfSR8n1o_1LXhdzqYzWzNLi3S3tA>
    <xmx:1DQcZ8ofxlcNZnlqJAlT-6m5rpyVNZ_xgRz3Hnlq8wDNyRy21huxqRf3>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 25 Oct 2024 20:16:20 -0400 (EDT)
Date: Fri, 25 Oct 2024 17:16:19 -0700
From: Boqun Feng <boqun.feng@gmail.com>
To: FUJITA Tomonori <fujita.tomonori@gmail.com>
Cc: anna-maria@linutronix.de, frederic@kernel.org, tglx@linutronix.de,
	jstultz@google.com, sboyd@kernel.org, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, rust-for-linux@vger.kernel.org,
	andrew@lunn.ch, hkallweit1@gmail.com, tmgross@umich.edu,
	ojeda@kernel.org, alex.gaynor@gmail.com, gary@garyguo.net,
	bjorn3_gh@protonmail.com, benno.lossin@proton.me,
	a.hindborg@samsung.com, aliceryhl@google.com, arnd@arndb.de
Subject: Re: [PATCH v4 4/7] rust: time: Add wrapper for fsleep function
Message-ID: <Zxw00wQAj4LpeU_t@Boquns-Mac-mini.local>
References: <20241025033118.44452-1-fujita.tomonori@gmail.com>
 <20241025033118.44452-5-fujita.tomonori@gmail.com>
 <ZxwVuceNORRAI7FV@Boquns-Mac-mini.local>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZxwVuceNORRAI7FV@Boquns-Mac-mini.local>

On Fri, Oct 25, 2024 at 03:03:37PM -0700, Boqun Feng wrote:
[...]
> > +/// Sleeps for a given duration at least.
> > +///
> > +/// Equivalent to the kernel's [`fsleep`], flexible sleep function,
> > +/// which automatically chooses the best sleep method based on a duration.
> > +///
> > +/// The function sleeps infinitely (MAX_JIFFY_OFFSET) if `Delta` is negative
> > +/// or exceedes i32::MAX milliseconds.
> > +///
> 
> I know Miguel has made his suggestion:
> 
> 	https://lore.kernel.org/rust-for-linux/CANiq72kWqSCSkUk1efZyAi+0ScNTtfALn+wiJY_aoQefu2TNvg@mail.gmail.com/
> 

"made his suggestion" is probably a wrong statement from me, looking
back the emails, Miguel was simply talking about we should document this
and his assumption that `fsleep()` should inherit the behavior/semantics
of msecs_to_jiffies().

But yeah, I still suggest doing it differently, i.e. panic on negative
or exceeding i32::MAX milliseconds.

Regards,
Boqun

[...]

