Return-Path: <netdev+bounces-161583-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E869A22769
	for <lists+netdev@lfdr.de>; Thu, 30 Jan 2025 02:15:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DF7EF1886280
	for <lists+netdev@lfdr.de>; Thu, 30 Jan 2025 01:15:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2E64BA3F;
	Thu, 30 Jan 2025 01:15:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="On7+cl1n"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 670AF819;
	Thu, 30 Jan 2025 01:15:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738199743; cv=none; b=b5J7YozqF7gN+mT21n9D4PMDierABDXx/lagOZ0u+RKfXylDdgHyaYjl01Dm/s0P6nTg9t06tAWsoNe5LlYanN8JPP0GvIbmIQ9jqOlpJkx9CS9JHgLmLgXEN2b7obDriKTP9JDf3CT0+rv4E9NvEMf+1wOO6QXAf2ZO0EYmw1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738199743; c=relaxed/simple;
	bh=iMXJ4VVzwQBEJVtOzdE6VBxooj9HwN6ZoAbAxUzUS8s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Pr3ETivJ8Wbim/ANVJWwR3PnXTBFKgnFrKt6lvJE8FJ46ClJfr1eI8zo/WqwqigbBL9xBmP0HTztsR7lCcFLMg2h2/A82jwPYbFdKJgQKdhTKbENzFwyZcu5knH02TV37csbfaNzivAqR0M0ykZSzEQWsbCnrI96QN09R0beYwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=On7+cl1n; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-6e2362ea655so2417046d6.3;
        Wed, 29 Jan 2025 17:15:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738199741; x=1738804541; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HKegh2EpTKNUtfTcnTSK1uYtDN9J7j7dQ8HyltMMtSs=;
        b=On7+cl1nim9j1DCqzWx16Fb3hOD0xr07H2kJ0vZL+38V/OOX64G0fK4q931WsYP5UA
         ZX5kMHSzhbx5vtJ5aF4Z8MIqN1nCDXNil8dIXmfsHNXpHA+1E/SE13m50DjroaKCilpI
         8JLrBAjKtRpUGt+IaKE8Vp4jMZkQlf2rp+Yo9RcthBvaCKouwVQ+QxxhQjsYR7DAx3wd
         bV/uBvVgQD7k8n+w3vhDtbVbpCMvzjVSgXkq/u9NxTKPjuYIkFgmlFGluRh8rpnDiX1n
         iVU0OP3m1Scm2WqtFvirs0jMP/R/A5kwQvV+Ujz0hzUX+RTR5/1+B4TwUSJHN1K+JNbb
         hn6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738199741; x=1738804541;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HKegh2EpTKNUtfTcnTSK1uYtDN9J7j7dQ8HyltMMtSs=;
        b=DjflK3/7xvhI3QGZYcu/07jt4bEkOY8s3Et4or5hNMpQXVjeD19I+fGSajrPSSyEWU
         TZvz4KkOoIP/Mjy/HzEnFfNZfofArYn0WYuZ3reUtWQAcqV0Misk1NH+XHFkuvQI0BKO
         mpEMtLn9QH3g/2eQcja36ibSrIU0Fw1HmoI5jEEcDmvHsObzG3siWCqKivJ7C4fZALbk
         77+Mlpny9BJhNwB95KhOMkMUDP6R4vi74GuunJnPwxeb+4CDrAwl0DWLNHsu1sUiSODB
         AphU8nbHMOHfDFESMwqzIj2u96PvCVhS76sRiMxF7Hh6wuUm9jKLLGe5GsE9M63XpHQ2
         Vn8Q==
X-Forwarded-Encrypted: i=1; AJvYcCVDZhNHhjjNnlg0x7k9JsmYrMvEAs8MQM4mYmZ2X/QzRRIQ3AOfRF441uZHA7ic01tSYBumy5lSrD8QsWU=@vger.kernel.org, AJvYcCVUxBiZk7WWTPCwGdOXKWWP1TAMMKAfjfEC9j+taPm3u6lGsWfcdzizeq57Z4Xl44ttgHiMI9sJ4avVHEzsM8Y=@vger.kernel.org, AJvYcCWwsTeZyJ69Pi3x6h7CcIkRiuMKOd5rmm/fu2j3DAYBHweB/PV3aqOoD9S+6hk4GlgWjKy6MwB0@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2dczsq49A89HMttH3FLSDV6VfHA3AILiw31HtxbyuvvjUMGMl
	XbG++DFRsvTA/bwiBIfwPoA1f62yyFfDPQU890Dy5f60MWZtJ07Z
X-Gm-Gg: ASbGnct/NfgCO/HUvdOPDIRiZ2yVsk9fcc4m1ufI/8JdBY8u6HiXoe/lGuXcQj1DzSD
	+SUv7YoabvSHkEy0LsiJAuKhztQzEObsFVfWdYoVdHq2QlRAfoCooFf8LB+WunzBywe50URPaG7
	2CxUayhBMGCScCkFtbWxV4KaXC3CJpcGgF7yXLwc2vzbr54ANfYCHxCjLw4aaJ6M3WPdCK6yjkS
	UT1ybS0JsEv6uicVM08xWtDA/4pLXnVBzMwavFz4YWowmWpbEDd1eGicqJV1TZxd1ElIHevMjiK
	lvNIBvJj3fh21Vx50ebPwhSY1RXbdJ0hwJ8OA7wkW5g7Qs4Ux5Dpa+6Vh2Ab9Z+EuxNWgSq5DTr
	4f2IJpg==
X-Google-Smtp-Source: AGHT+IFRVe8KbgAHHR3mO7reIimkVt4TlkjskaYMqr+SD06SBZVkEITSeORXZAmNoyf3IBgcAEuXcA==
X-Received: by 2002:a05:6214:5985:b0:6dd:84b7:dd86 with SMTP id 6a1803df08f44-6e243c80546mr106859026d6.36.1738199741194;
        Wed, 29 Jan 2025 17:15:41 -0800 (PST)
Received: from fauth-a1-smtp.messagingengine.com (fauth-a1-smtp.messagingengine.com. [103.168.172.200])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e2547f0e00sm1027056d6.24.2025.01.29.17.15.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jan 2025 17:15:40 -0800 (PST)
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfauth.phl.internal (Postfix) with ESMTP id 458C61200043;
	Wed, 29 Jan 2025 20:15:39 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Wed, 29 Jan 2025 20:15:39 -0500
X-ME-Sender: <xms:u9KaZx9y0t60We4j14DCVffM84lIdzFxOJsBnf2aSDuRwSqefH9MaQ>
    <xme:u9KaZ1uNrFC9t2yerab7ETzyOIoYx53NV4CSQFpquBXjLhRMVbJ8By4m7K2oWLkmV
    gcq2z81Q3hXtKo7dQ>
X-ME-Received: <xmr:u9KaZ_BJvJG3beLntRNTsrhQAFxMjlkVR8BoHe478V4ir5_9BRSYYkZcE9o>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeggeehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomhepuehoqhhunhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrd
    gtohhmqeenucggtffrrghtthgvrhhnpeehudfgudffffetuedtvdehueevledvhfelleei
    vedtgeeuhfegueevieduffeivdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpegsohhquhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhi
    thihqdeiledvgeehtdeigedqudejjeekheehhedvqdgsohhquhhnrdhfvghngheppehgmh
    grihhlrdgtohhmsehfihigmhgvrdhnrghmvgdpnhgspghrtghpthhtohepfedupdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopehfuhhjihhtrgdrthhomhhonhhorhhisehgmh
    grihhlrdgtohhmpdhrtghpthhtohepphgvthgvrhiisehinhhfrhgruggvrggurdhorhhg
    pdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorh
    hgpdhrtghpthhtoheprhhushhtqdhfohhrqdhlihhnuhigsehvghgvrhdrkhgvrhhnvghl
    rdhorhhgpdhrtghpthhtohepnhgvthguvghvsehvghgvrhdrkhgvrhhnvghlrdhorhhgpd
    hrtghpthhtoheprghnughrvgifsehluhhnnhdrtghhpdhrtghpthhtohephhhkrghllhif
    vghithdusehgmhgrihhlrdgtohhmpdhrtghpthhtohepthhmghhrohhsshesuhhmihgthh
    drvgguuhdprhgtphhtthhopehojhgvuggrsehkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:u9KaZ1eHvMU7fOSUnfgTgAQtRAWhxE4GZN1qGnx2c4dykktPD9JO5A>
    <xmx:u9KaZ2OOVQXEWcC-aNnkzoLOUyjeHqdQEdviGMV0suuwGjlFDeIwJQ>
    <xmx:u9KaZ3kuhcFaJIgTkPbvSQiZ3zT5DoOKXwQutZwrefWLmjyXEjy0jQ>
    <xmx:u9KaZwsRn0VsgwtfTSPrWFuJXcov5isDGPJXhm65vL5Oxekb0y8qWw>
    <xmx:u9KaZ4vw3tbmOLBxioIrwBFWhKQT3JTS1WeqoSIvvtwkrTYAxYjiUouI>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 29 Jan 2025 20:15:38 -0500 (EST)
Date: Wed, 29 Jan 2025 17:14:54 -0800
From: Boqun Feng <boqun.feng@gmail.com>
To: FUJITA Tomonori <fujita.tomonori@gmail.com>
Cc: peterz@infradead.org, linux-kernel@vger.kernel.org,
	rust-for-linux@vger.kernel.org, netdev@vger.kernel.org,
	andrew@lunn.ch, hkallweit1@gmail.com, tmgross@umich.edu,
	ojeda@kernel.org, alex.gaynor@gmail.com, gary@garyguo.net,
	bjorn3_gh@protonmail.com, benno.lossin@proton.me,
	a.hindborg@samsung.com, aliceryhl@google.com,
	anna-maria@linutronix.de, frederic@kernel.org, tglx@linutronix.de,
	arnd@arndb.de, jstultz@google.com, sboyd@kernel.org,
	mingo@redhat.com, juri.lelli@redhat.com, vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
	mgorman@suse.de, vschneid@redhat.com, tgunders@redhat.com
Subject: Re: [PATCH v9 1/8] sched/core: Add __might_sleep_precision()
Message-ID: <Z5rSjsdwG2aonZrB@boqun-archlinux>
References: <20250125101854.112261-1-fujita.tomonori@gmail.com>
 <20250125101854.112261-2-fujita.tomonori@gmail.com>
 <20250128113738.GC7145@noisy.programming.kicks-ass.net>
 <20250130.085644.2298700991414831587.fujita.tomonori@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250130.085644.2298700991414831587.fujita.tomonori@gmail.com>

On Thu, Jan 30, 2025 at 08:56:44AM +0900, FUJITA Tomonori wrote:
> On Tue, 28 Jan 2025 12:37:38 +0100
> Peter Zijlstra <peterz@infradead.org> wrote:
> 
> > On Sat, Jan 25, 2025 at 07:18:46PM +0900, FUJITA Tomonori wrote:
> >> Add __might_sleep_precision(), Rust friendly version of
> >> __might_sleep(), which takes a pointer to a string with the length
> >> instead of a null-terminated string.
> >> 
> >> Rust's core::panic::Location::file(), which gives the file name of a
> >> caller, doesn't provide a null-terminated
> >> string. __might_sleep_precision() uses a precision specifier in the
> >> printk format, which specifies the length of a string; a string
> >> doesn't need to be a null-terminated.
> >> 
> >> Modify __might_sleep() to call __might_sleep_precision() but the
> >> impact should be negligible. strlen() isn't called in a normal case;
> >> it's called only when printing the error (sleeping function called
> >> from invalid context).
> >> 
> >> Note that Location::file() providing a null-terminated string for
> >> better C interoperability is under discussion [1].
> > 
> > Urgh :/
> 
> Yeah... so not acceptable?
> 

I would like to see some concrete and technical reasons for why it's not
acceptable ;-) I'm not sure whether Peter was against this patch or just
not happy about Location::file() providing a null-terminated string is a
WIP.

To me, null-terminated string literals don't provide much benefits
other than you can pass it via only one pointer value, the cost is that
you will always need to calculate the length of the string when needed,
so hard to say it's a straightforward win.

Regards,
Boqun

> Then I switch to the implementation with Rust macros, which gives a
> null terminated string.

