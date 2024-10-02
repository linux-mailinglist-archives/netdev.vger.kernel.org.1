Return-Path: <netdev+bounces-131352-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C4CD98E3E4
	for <lists+netdev@lfdr.de>; Wed,  2 Oct 2024 22:04:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CBAD21F27032
	for <lists+netdev@lfdr.de>; Wed,  2 Oct 2024 20:04:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F61F212F0F;
	Wed,  2 Oct 2024 20:04:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="sV3cC+Ax";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="MacOPU7T"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93BEE2114;
	Wed,  2 Oct 2024 20:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727899445; cv=none; b=RGkWZhtyzq0rzZVc4qhP0IjYQg8JSFH84Pogufph0oixdBerUHwC9xDmOtXv+RGHIbGmZlzmn/e7zH52Ff+uGhrS+NFoxZgZ1njuxG5lI2TCg6DkRTgTSo/xjQTPihJisWkh5AVRM16VkTjahy6mPCsVAg+CP/6ffcap8pLLoWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727899445; c=relaxed/simple;
	bh=gPXDQRsFYmCqVGQlQspyPpXZsyzaFvNanZpaovOryow=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=AvA6+FwRRaxgMQVg0Sb27MgzZVAex9o651pHwGeaG4nl9lbH+LUqy3ObrHXBlm4TPtgTRprprAJGCMrwegVwPI+J3N16Y67cTxQ7/048sCGwmDHAWXCwJnpdx6qOCZsYuoLJSHkFA0XMmvdCzOV0dXHzB1HF1j8spsjAtgaq0Yg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=sV3cC+Ax; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=MacOPU7T; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1727899440;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nkfJtSduQOfmewmI3G2NKeIqKkPDh2egZh+vb/1fPwc=;
	b=sV3cC+AxQawy+r6vxdzQm4+20ZV5HElgOTVSC6LcRgzdAfgeq4q7HvQTZJKppdfxFOLxRY
	+a1ZeRibUF+t9T1ANCaZSFez1cmDwdRnUvSMbmwO0ndG+5trM/UgpkJAu3KCa5zggiwtoz
	FL/EvD5ZRqNtTTSZtENCc1Ve4NBJumpGJpnsfAmfXPVqjP8yKcMBakvRxZk8swunWZXhGZ
	2r56Fpmsm1bqzmqQD9YPeoet3fE4+AWMUpZ9j3PJ4IbFjr9XTNdSYF80VJSC/LE/pjJRw/
	QG2Uo8OICUOdmFg+OEDjg/TT3IYG4Acs5xXTf5BK6BzwBnYHjRR1AbqUiqY2hg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1727899440;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nkfJtSduQOfmewmI3G2NKeIqKkPDh2egZh+vb/1fPwc=;
	b=MacOPU7TuOQUMpRdYU4WMpxipoHxtr8womom1DJN1FRBS74WCIjmbRuYDeGgWN03tsLzn1
	0Gz5Ddil2cd5LQDw==
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>, Andrew Lunn
 <andrew@lunn.ch>
Cc: FUJITA Tomonori <fujita.tomonori@gmail.com>, netdev@vger.kernel.org,
 rust-for-linux@vger.kernel.org, hkallweit1@gmail.com, tmgross@umich.edu,
 ojeda@kernel.org, alex.gaynor@gmail.com, gary@garyguo.net,
 bjorn3_gh@protonmail.com, benno.lossin@proton.me, a.hindborg@samsung.com,
 aliceryhl@google.com, Anna-Maria Behnsen <anna-maria@linutronix.de>
Subject: Re: [PATCH net-next v1 1/2] rust: add delay abstraction
In-Reply-To: <CANiq72nCeGVFY_eZMhp44dqZGY1UXuEZFaJx-3OLCTk-eG=xng@mail.gmail.com>
References: <20241001112512.4861-1-fujita.tomonori@gmail.com>
 <20241001112512.4861-2-fujita.tomonori@gmail.com>
 <b47f8509-97c6-4513-8d22-fb4e43735213@lunn.ch>
 <20241002.113401.1308475311422708175.fujita.tomonori@gmail.com>
 <e048a4cc-b4e9-4780-83b2-a39ede65f978@lunn.ch>
 <CANiq72mX4nJNw2RbZd9U_FdbGmnNHav3wMPMJyLSRN=PULan8g@mail.gmail.com>
 <3fc44d62-586f-4ed0-88ee-a561bef1fdaf@lunn.ch>
 <CANiq72nCeGVFY_eZMhp44dqZGY1UXuEZFaJx-3OLCTk-eG=xng@mail.gmail.com>
Date: Wed, 02 Oct 2024 22:04:00 +0200
Message-ID: <878qv6w9u7.ffs@tglx>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 02 2024 at 15:21, Miguel Ojeda wrote:
> On Wed, Oct 2, 2024 at 2:51=E2=80=AFPM Andrew Lunn <andrew@lunn.ch> wrote:
>> Maybe this is my background as a C programmer, with its sloppy type
>> system, but i prefer to have this very clear, maybe redundantly
>> stating it in words in addition to the signature.
>
> The second part of my message was about the signature point you made,
> i.e. not about the units. So I am not sure if you are asking here to
> re-state the types of parameters in every function's docs -- what do
> you gain from that in common cases?
>
> We also don't repeat every parameter in a bullet list inside the
> documentation to explain each parameter, unless a parameter needs it
> for a particular reason. In general, the stronger/stricter your
> types/signatures are, and the better documented your types are, the
> less "extra notes" in every function you need.
>
> For instance, if you see `int` in a signature, then you very likely
> need documentation to understand how the argument works because `int`
> is way too general (e.g. it is likely it admits cases you are not
> supposed to use). However, if you see `Duration`, then you already
> know the answer to the units question.
>
> Thus, in a way, we are factoring out documentation to a single place,
> thus making them simpler/easier/lighter -- so you can see it as a way
> to scale writing docs! :)
>
> That is also why carrying as much information in the signature also
> helps with docs, and not just with having the compiler catch mistakes
> for us.

I completely agree.

'delay(Duration d)' does not need explanation for @d unless there is a
restriction for the valid range of @d. @d is explained in the
documentation of Duration.

That's not any different in C, when the function argument is a pointer
to a complex struct. Nobody would even think about explaining the struct
members in the documentation of the function which has that struct
pointer argument. No, you need to go to the struct declaration to figure
it out.

Redundant documentation is actually bad, because any changes to the type
will inevitably lead to stale documentation at the usage site. The
kernel is full of this.

I havent's seen the actual patches as they were sent to netdev for
whatever reason. There is a larger rework of delay.h going on:

  https://lore.kernel.org/all/20240911-devel-anna-maria-b4-timers-flseep-v2=
-0-b0d3f33ccfe0@linutronix.de/

V3 will be coming early next week. So please look at V2 if you have any
constraints vs. the rust implementation.

Thanks,

        tglx



