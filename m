Return-Path: <netdev+bounces-70208-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 76A1784E04C
	for <lists+netdev@lfdr.de>; Thu,  8 Feb 2024 13:04:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9B8E11C25294
	for <lists+netdev@lfdr.de>; Thu,  8 Feb 2024 12:04:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17D4774E32;
	Thu,  8 Feb 2024 12:02:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="lM1FqGOB"
X-Original-To: netdev@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB6ED6F539;
	Thu,  8 Feb 2024 12:02:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707393741; cv=none; b=FoyqGuFhKvbqzm5OT/CDjdvGSTAfiLTuapwqt0t1CDFuR+BPXpe/dxS9WyKcbRtF6dNgZbK48qk4KQt7U3ialrQBty27owagx3tTF45w8gQeS0GnbH7ecf/gN2YDlpPh4fPog4O5Rt9zSPoiJqpBv0p5kjoqajglfhIwWWLZr0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707393741; c=relaxed/simple;
	bh=e+ZYYIU7bedHh6ztHXHl5oclVEV2zD3Rf5bpDg5IRp4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZFy1WpIsMtgLa2JQ9k/dP6kR+gkSNOrS0W5YveTSUPr2ixYa0JDPy9NRlIM0QJ6YxEQmmWeA0YwVjYTH1z5N4VXYUdwY39YuFw+XWl8UCxfeYlCJNlhExi2HbJbsIiCDULCJn78N2iFQsUSxcvU3KEUWu0M3MWgwoH1VAdUZQO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=lM1FqGOB; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id C38B640E0196;
	Thu,  8 Feb 2024 12:02:13 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id lV1XahIN3clY; Thu,  8 Feb 2024 12:02:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1707393730; bh=Zk/yQO1YQSF8AvGqaFxyrvZfxFZdDX0y82nrj5ssPQA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lM1FqGOBKhUorhdzG0kgF9nvkLeuA1NAPrcM7LhpxKZ6JpZndoe/fgx2NpjOrNjBM
	 fq3ovNGQlZHATWDlOz+zhCLvlj2EsWut5kStz1Q+CeXOFJplBoVQy/sEVBUvba4z3J
	 K6RFSU5AVGa4sK7Uu4fjOCDjg+tbcRRT72fxUDntRLhIa4ucEQP6Vg94cTquYPC1sT
	 kDs2ULP7Q41PgK7PNhM3O4mtNZm/Up6FEWu4GplJEb9H1jrbpYjuyOZzt3dRFdhxZT
	 960WHhI2bz0FuZETj66yuptlH04d9AEgh4diFvp3upbi0dq5i92Jk3csB6ByXAF8xe
	 EfAv+YzQjf1fcyD9HXGq2HCW0iBmuUylpY/kQpITFXGXOGCzEk2rCvF06L5exjhlva
	 kT39VArsvKkznXW38c9+pQ/c15yGFTfnuTE9T2pEGxRQ/XiJAIoHSxboTxeHVqtuzV
	 3tGrDi2+ib5DAUcHBx7ufdVPD51LhbcaPIcNSIOkwUf3viIsnykf4TAdO2JKnHfO6n
	 3q9msX5YgI9iP7OsEE1O627quRgrYwozStC8ekB6Pi0hqANfzmtG09Lvu9hDxzl7hT
	 Un2dOZGd1VxVrBb+wBi2us+WTWk3Qt1WCeR04zebadNOEyGOfk1+TLjQosxK+K9Uqa
	 STo1Hyk94AKsz7DxjmD9lOa4=
Received: from zn.tnic (pd953021b.dip0.t-ipconnect.de [217.83.2.27])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id BA2DE40E00B2;
	Thu,  8 Feb 2024 12:01:59 +0000 (UTC)
Date: Thu, 8 Feb 2024 13:01:55 +0100
From: Borislav Petkov <bp@alien8.de>
To: Marco Elver <elver@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>, Matthieu Baerts <matttbe@kernel.org>,
	Alexander Potapenko <glider@google.com>,
	Dmitry Vyukov <dvyukov@google.com>, kasan-dev@googlegroups.com,
	Netdev <netdev@vger.kernel.org>, linux-hardening@vger.kernel.org,
	Kees Cook <keescook@chromium.org>,
	the arch/x86 maintainers <x86@kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: KFENCE: included in x86 defconfig?
Message-ID: <20240208120155.GBZcTCs-Jkqtrg42Zd@fat_crate.local>
References: <e2871686-ea25-4cdb-b29d-ddeb33338a21@kernel.org>
 <CANpmjNP==CANQi4_qFV_VVFDMsj1wHROxt3RKzwJBqo8_McCTg@mail.gmail.com>
 <20240207181619.GDZcPI87_Bq0Z3ozUn@fat_crate.local>
 <d301faa8-548e-4e8f-b8a6-c32d6a56f45b@kernel.org>
 <20240207190444.GFZcPUTAnZb_aSlSjV@fat_crate.local>
 <20240207153327.22b5c848@kernel.org>
 <CANpmjNOgimQMV8Os-3qcTcZkDe4i1Mu9SEFfTfsoZxCchqke5A@mail.gmail.com>
 <20240208105517.GAZcSzFTgsIdH574r4@fat_crate.local>
 <CANpmjNPgiRmo1qCz-DczSnC-YaTzpax-xCqbQPUvuSd7G4-GpA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CANpmjNPgiRmo1qCz-DczSnC-YaTzpax-xCqbQPUvuSd7G4-GpA@mail.gmail.com>

On Thu, Feb 08, 2024 at 12:12:19PM +0100, Marco Elver wrote:
> git log --grep 'BUG: KFENCE: '
> 
> There are more I'm aware of - also plenty I know of in downstream
> kernels (https://arxiv.org/pdf/2311.09394.pdf - Section 5.7).

Good.

> This is a problem shared by all other diagnostic and error reports the
> kernel produces.

Yes, and it becomes a problem if you expose it to the wider audience.

And yes, nothing new here - it is the same ol' question of getting good
bug reports.

> It's not a KASAN replacement, since it's sampling based.

I meant this: "Compared to KASAN, KFENCE trades performance for
precision."

And yeah, I did read what you pasted.

> From the Documentation: "KFENCE is designed to be enabled in
> production kernels, and has near zero performance overhead. Compared
> to KASAN, KFENCE trades performance for precision. The main motivation
> behind KFENCE's design, is that with enough total uptime KFENCE will
> detect bugs in code paths not typically exercised by non-production
> test workloads.

What is that double negation supposed to mean?

That it'll detect bugs in code paths that are typically exercised by
production test workloads?

> One way to quickly achieve a large enough total uptime is
> when the tool is deployed across a large fleet of machines."

In any case, I'll enable it on my test machines and see what happens.

> No reports are good. Doesn't mean absence of bugs though. :-)

As long as I don't know about them, I'm good. :-P

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

