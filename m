Return-Path: <netdev+bounces-136285-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C9CC89A1323
	for <lists+netdev@lfdr.de>; Wed, 16 Oct 2024 22:04:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 71BC31F22C60
	for <lists+netdev@lfdr.de>; Wed, 16 Oct 2024 20:04:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A544216A17;
	Wed, 16 Oct 2024 20:03:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lnzZfGxY"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4B80216A05;
	Wed, 16 Oct 2024 20:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729109033; cv=none; b=ik8tZCpym5rSMWKJvEpduLp+jMvUUxB/fwXil7SB5Hp+zsaJA6gMFHSUTbxCGIW0yvt7V2uIeTCyhXhsITOkN/tPJ2TFwkl+tv0Gs4BpDK8bgIHKWb6Jqvo8KibZ4k6T3HFXWKbplMgFdWNGcMNo1dJuJol03ZYSFG/fu0mHBac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729109033; c=relaxed/simple;
	bh=CUNpf0RpAGHCLSfPqwWQmkrOcmeJg5FOd6ztGlwkkw8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JWVQxt388PW/nRCColoG5Pb651AuZK8ILndCfihPBvZQlHVA4Q38pxdEv4rKjnEppNSaWPlOMhzlnDRd6U5mlhmgbbPH0L/6Bvf+NtPApeA9OssKt6G/El8RXHbZpfWIWEFTcEzBjZdOcLX8yu9qvXwDgJNKZnwbV4IMhH7BnXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lnzZfGxY; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-7b117fab020so18326785a.1;
        Wed, 16 Oct 2024 13:03:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729109031; x=1729713831; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ksybH0l9PJyMJv7G8Na7PkJpM36rh/jZxYG4yRhyeUo=;
        b=lnzZfGxYCXwjcc7w1GjA82JvDcdFH6w8AQIPRNEoy8XHhuSZBWKJAsumy3D738NdIP
         H7hc/5SlfndyX6yyYyjJXXda+UIw1OSrf2unVabA55iunKGDZFVceTvO5kVTgbhJNfa4
         BJWdEz4dd7bx0hlwCY8WuY6OAOj7Pqi8mjwjtchEGi3yIc0N5dnueKQYVECMwb61nkBi
         9mZ8hwGEBF51vGtTZIeMK0yQwmoT8KkCJqzDFgXNqhxmIuRG/+hlVjRpMBNeRhFWXOOp
         fv7YDB80whgIbZrFz47SnmZMm8s3vxjfW96wdXn5b7wqcRA95iMHTFeq2unudrNi81GV
         nIlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729109031; x=1729713831;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ksybH0l9PJyMJv7G8Na7PkJpM36rh/jZxYG4yRhyeUo=;
        b=LjXq9M1YgF+LRi++qIDW9EKYbXlZ13KBGGh+Ra1mD3W2XICXJCRHIFD4m+k1TARBtP
         sLERqvXihHHFnxyMR/MgoRQNmR2PlEeDBlooPDS1PPZ3xnAFscphscl7H6304ZV8pQo5
         EjqDXXEg198b/U2hxo8Igsy3nK5t7B9cB03EogV4CBTTR/ZYA4thavljBElgWuL9t0UG
         l1uRR1gMp6JvWMqeWaAhpxbZkOg+m8E/W+kysgt7pP+74YKqxETh3MMrBPuoyO2ux35K
         uonqsRSA3jGxhZG6gU3BbTyvB2Oq0HfFN558igl0Uvx01B6xSPtvYADBpLoVzUOovltE
         QLxg==
X-Forwarded-Encrypted: i=1; AJvYcCU0Wg2br4KNdg5PdOT0GqOCuVGoeMkvW3C4ieW5c7MiheBy2a2thQFv7oyuTmpEEiyn26io9dn+XYx1WOc=@vger.kernel.org, AJvYcCU6GyIM5uOeETcISzwzaDyoGKVsYVhcAam1ZlQkxekFcQPTiljVVYbLqZ1WgCBApZKtHx/NNwaAgxJe/HCw8m0=@vger.kernel.org
X-Gm-Message-State: AOJu0YynE4skY/0uaWKFX8o919R3kGzeNj2UUAI5J6xRZXFUzIGKckZL
	U6IOsUCLmUzbfUElJ3S0XWdJI2PLQ+U/dGqcGiZLntVKu0AvtGH7
X-Google-Smtp-Source: AGHT+IHY5oftsiP3O/r6+VQ/Yam9sjeFXHYqHuEeL0Wif0tfDCWFwYNjaNOzsSMrdJ3mLolYfgFf2A==
X-Received: by 2002:a05:620a:27ce:b0:7b1:447f:d6f0 with SMTP id af79cd13be357-7b1447fd8e4mr559029385a.23.1729109030642;
        Wed, 16 Oct 2024 13:03:50 -0700 (PDT)
Received: from fauth-a2-smtp.messagingengine.com (fauth-a2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b1363b471dsm221625185a.105.2024.10.16.13.03.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Oct 2024 13:03:50 -0700 (PDT)
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfauth.phl.internal (Postfix) with ESMTP id D291A120006C;
	Wed, 16 Oct 2024 16:03:49 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-10.internal (MEProxy); Wed, 16 Oct 2024 16:03:49 -0400
X-ME-Sender: <xms:JRwQZ5cu_NbI3KFDeUWnUrsUM1HSfC4kNzLgzTNKfNXrJo2MWlC3Ow>
    <xme:JRwQZ3OcZUgYxqjcnUiXEJbC8E4vCob-6_cHVTWeUwfccw-FwRRqa5OJdCD3dJnTA
    7pT5lIgnNpzSX-BFg>
X-ME-Received: <xmr:JRwQZyhHNwklddnOHAYKgyYlY5TAmk6gs_99qaLGE8vfXYkT5vhPhIjRE8E>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdegledgudeghecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddv
    necuhfhrohhmpeeuohhquhhnucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilh
    drtghomheqnecuggftrfgrthhtvghrnhephedugfduffffteeutddvheeuveelvdfhleel
    ieevtdeguefhgeeuveeiudffiedvnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepsghoqhhunhdomhgvshhmthhprghuthhhphgvrhhsohhnrghl
    ihhthidqieelvdeghedtieegqddujeejkeehheehvddqsghoqhhunhdrfhgvnhhgpeepgh
    hmrghilhdrtghomhesfhhigihmvgdrnhgrmhgvpdhnsggprhgtphhtthhopedvuddpmhho
    uggvpehsmhhtphhouhhtpdhrtghpthhtohepfhhujhhithgrrdhtohhmohhnohhrihesgh
    hmrghilhdrtghomhdprhgtphhtthhopehnvghtuggvvhesvhhgvghrrdhkvghrnhgvlhdr
    ohhrghdprhgtphhtthhopehruhhsthdqfhhorhdqlhhinhhugiesvhhgvghrrdhkvghrnh
    gvlhdrohhrghdprhgtphhtthhopegrnhgurhgvfieslhhunhhnrdgthhdprhgtphhtthho
    pehhkhgrlhhlfigvihhtudesghhmrghilhdrtghomhdprhgtphhtthhopehtmhhgrhhosh
    hssehumhhitghhrdgvughupdhrtghpthhtohepohhjvggurgeskhgvrhhnvghlrdhorhhg
    pdhrtghpthhtoheprghlvgigrdhgrgihnhhorhesghhmrghilhdrtghomhdprhgtphhtth
    hopehgrghrhiesghgrrhihghhuohdrnhgvth
X-ME-Proxy: <xmx:JRwQZy-oOiR6aRHDpXGAgqJQV6-0TtCOiEd-XmAZJqOae-fhRs31RA>
    <xmx:JRwQZ1uaqylUn2u6kmtY8wcQg3f7I3b2KvmVJWCBaV8POhSsY21djg>
    <xmx:JRwQZxEXiaEz7gM9G2lHZdZFzyeOSpk31S3B_gzFGh0kqBK5bB800w>
    <xmx:JRwQZ8OpYWb1fr1IXW0Pb-eJ4iQnavPbz60rbruu7_cr7oG_rYCw-A>
    <xmx:JRwQZ-NGj_hgPxQ6896BPphXkMbKvt021BxUutocFrTxYxK6dMFsuP56>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 16 Oct 2024 16:03:49 -0400 (EDT)
Date: Wed, 16 Oct 2024 13:03:48 -0700
From: Boqun Feng <boqun.feng@gmail.com>
To: FUJITA Tomonori <fujita.tomonori@gmail.com>
Cc: netdev@vger.kernel.org, rust-for-linux@vger.kernel.org, andrew@lunn.ch,
	hkallweit1@gmail.com, tmgross@umich.edu, ojeda@kernel.org,
	alex.gaynor@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com,
	benno.lossin@proton.me, a.hindborg@samsung.com,
	aliceryhl@google.com, anna-maria@linutronix.de, frederic@kernel.org,
	tglx@linutronix.de, arnd@arndb.de, jstultz@google.com,
	sboyd@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v3 3/8] rust: time: Change output of Ktime's sub
 operation to Delta
Message-ID: <ZxAcJEDFQ-n64mnd@Boquns-Mac-mini.local>
References: <20241016035214.2229-1-fujita.tomonori@gmail.com>
 <20241016035214.2229-4-fujita.tomonori@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241016035214.2229-4-fujita.tomonori@gmail.com>

On Wed, Oct 16, 2024 at 12:52:08PM +0900, FUJITA Tomonori wrote:
> Change the output type of Ktime's subtraction operation from Ktime to
> Delta. Currently, the output is Ktime:
> 
> Ktime = Ktime - Ktime
> 
> It means that Ktime is used to represent timedelta. Delta is
> introduced so use it. A typical example is calculating the elapsed
> time:
> 
> Delta = current Ktime - past Ktime;
> 
> Signed-off-by: FUJITA Tomonori <fujita.tomonori@gmail.com>
> ---
>  rust/kernel/time.rs | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/rust/kernel/time.rs b/rust/kernel/time.rs
> index 38a70dc98083..8c00854db58c 100644
> --- a/rust/kernel/time.rs
> +++ b/rust/kernel/time.rs
> @@ -74,16 +74,16 @@ pub fn to_ms(self) -> i64 {
>  /// Returns the number of milliseconds between two ktimes.
>  #[inline]
>  pub fn ktime_ms_delta(later: Ktime, earlier: Ktime) -> i64 {
> -    (later - earlier).to_ms()
> +    (later - earlier).as_millis()
>  }
>  
>  impl core::ops::Sub for Ktime {
> -    type Output = Ktime;
> +    type Output = Delta;
>  
>      #[inline]
> -    fn sub(self, other: Ktime) -> Ktime {
> -        Self {
> -            inner: self.inner - other.inner,
> +    fn sub(self, other: Ktime) -> Delta {
> +        Delta {
> +            nanos: self.inner - other.inner,

My understanding is that ktime_t, when used as a timestamp, can only
have a value in range [0, i64::MAX], so this substraction here never
overflows, maybe we want add a comment here?

We should really differ two cases: 1) user inputs may cause overflow vs
2) implementation errors or unexpected hardware errors cause overflow, I
think.

Regards,
Boqun

>          }
>      }
>  }
> -- 
> 2.43.0
> 
> 

