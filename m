Return-Path: <netdev+bounces-139803-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 32C559B4396
	for <lists+netdev@lfdr.de>; Tue, 29 Oct 2024 08:56:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DBC881F235B2
	for <lists+netdev@lfdr.de>; Tue, 29 Oct 2024 07:55:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F35DE202F65;
	Tue, 29 Oct 2024 07:55:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="MpuUnnZQ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="hQw02PqO"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 169791DE3C5;
	Tue, 29 Oct 2024 07:55:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730188554; cv=none; b=KYy78oBEiVFrNtblqBw4tCUasyE0CUwyA7y4FVj3K2FWUWI++jXG71UEBcWO8EgW22MwrHi3dSrxlkpNlwDeVPx1n/cPjZZFfcVOpysdGau7Sis4S9+X2x8kAd6xb2WbzKWzr/hjci/lQ1Mk827EG2cX1vq/Xf2+Yno3tLuzsFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730188554; c=relaxed/simple;
	bh=cW9s2dHTlaDkI8QhhBu//NGLNVZBurjcsG25s9INS3U=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=tnrjDBI38eWbZwxrlI5zrvMMuuCqlQRucVzDKj6gta2aCjmhI3dKZHNzIWe7NhkeNtTx4sl0TMx2DQis6vDrIrsDRpNDf34S2RQDmPamozT3XoAvUrFyU7tRl82TeVnleczT1o2+Bz733qEVd9eKfmerc1vtwKXN2mrD70tpW74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=MpuUnnZQ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=hQw02PqO; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1730188551;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KyvdhUfZSHeeKnvfzCZQJk5wLqHskMwbV1UXrfOwkQE=;
	b=MpuUnnZQRXxH+ZSgeoFBJg0UjCSANjGPCjS+GYPojwmrQic+6zOTwCN1EYWiJPNalIB16m
	sQFe+NEjyvRuzGNHwf+WlHsje3Y3dbTpCPLiNYiPylbfz242rEAe0dxkssD/SLdxkVlIxS
	5NChoNkpP9z/LtNQWfzpQclXnOhDiVBojlRlafvEjyde+Xw4HYt/QsfTMFOqemkaZPsYFJ
	lfKr5Ohj0GBbZineAhf8gGZE1qOLKI8cAJcj6qeaEdYXvfmmCyR7VyOjRS6Gtyr8x9788I
	5I664Z0T9ILrf/7bL3WxFZw0kjE4fSI6QWth7zm5gD2WWq2yCBwdaVibdM+DRQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1730188551;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KyvdhUfZSHeeKnvfzCZQJk5wLqHskMwbV1UXrfOwkQE=;
	b=hQw02PqOxo1iGJETpQaXoxQFx2pg24ffujGHL3kOxGrPfqs2GFr3EYGlo4iVWKDmH0kKOf
	uIPzC1ikjhHlMlCw==
To: FUJITA Tomonori <fujita.tomonori@gmail.com>, boqun.feng@gmail.com
Cc: fujita.tomonori@gmail.com, anna-maria@linutronix.de,
 frederic@kernel.org, jstultz@google.com, sboyd@kernel.org,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 rust-for-linux@vger.kernel.org, andrew@lunn.ch, hkallweit1@gmail.com,
 tmgross@umich.edu, ojeda@kernel.org, alex.gaynor@gmail.com,
 gary@garyguo.net, bjorn3_gh@protonmail.com, benno.lossin@proton.me,
 a.hindborg@samsung.com, aliceryhl@google.com, arnd@arndb.de
Subject: Re: [PATCH v4 4/7] rust: time: Add wrapper for fsleep function
In-Reply-To: <20241029.083029.72679397436968362.fujita.tomonori@gmail.com>
References: <ZxwVuceNORRAI7FV@Boquns-Mac-mini.local>
 <20241028.095030.2023085589483262207.fujita.tomonori@gmail.com>
 <Zx8VUety0BTpDGAL@Boquns-Mac-mini.local>
 <20241029.083029.72679397436968362.fujita.tomonori@gmail.com>
Date: Tue, 29 Oct 2024 08:55:50 +0100
Message-ID: <87cyjj2vi1.ffs@tglx>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Tue, Oct 29 2024 at 08:30, FUJITA Tomonori wrote:
> On Sun, 27 Oct 2024 21:38:41 -0700
> Boqun Feng <boqun.feng@gmail.com> wrote:
>> That also works for me, but an immediate question is: do we put
>> #[must_use] on `fsleep()` to enforce the use of the return value? If
>> yes, then the normal users would need to explicitly ignore the return
>> value:
>> 
>> 	let _ = fsleep(1sec);
>> 
>> The "let _ =" would be a bit annoying for every user that just uses a
>> constant duration.
>
> Yeah, but I don't think that we have enough of an excuse here to break
> the rule "Do not crash the kernel".
>
> Another possible option is to convert an invalid argument to a safe
> value (e.g., the maximum), possibly with WARN_ON_ONCE().

That makes sense.

