Return-Path: <netdev+bounces-70173-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5636A84DF7B
	for <lists+netdev@lfdr.de>; Thu,  8 Feb 2024 12:12:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 895D71C20A1D
	for <lists+netdev@lfdr.de>; Thu,  8 Feb 2024 11:12:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B28226A347;
	Thu,  8 Feb 2024 11:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="BXsutYeB"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A850B1DFCE
	for <netdev@vger.kernel.org>; Thu,  8 Feb 2024 11:12:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707390730; cv=none; b=ht97X5pwiFNfAWRKiecISZmCGI0wCrLxxnGKgzfUKf3GU9y+UCbJ8U+gToo3CrTzwwZkE9DH/1rnoBulbJZQlbsyUcvrVmtTmOzuHIRdaPHP8H/9fBpM3dkRKedbwKaW2LW2I196N3e3pboMiLtYi6Yh4A5kZrcu4ZD3z7K4GNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707390730; c=relaxed/simple;
	bh=eM4HqBQZDXDrdOu8I6M2Psw3Wem+dQhghmyTtakzWxc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=s8Gn14XNv649hTVfskWWdD11IERUyeG+KkdC09GMte6XdZTIsNCvJXi6vq58G6LZK31W2spd1qADwHC+QbY6/pNToYhMl9xlSPhVfr7Tx1P9itl5I17599SEAByLYPAaX7XUZ22NnTPmWOL1ozuTTLUVGns/C9XdLQAp80hgruI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=BXsutYeB; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-55c2cf644f3so2095784a12.1
        for <netdev@vger.kernel.org>; Thu, 08 Feb 2024 03:12:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1707390726; x=1707995526; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=LaTp4U1LWb5pJxk+3p4oypsyvdSNZ1j6KLCLyUB+gDY=;
        b=BXsutYeB7FFVuVi1SHU4npYCsqs1jZ0nGWsynQd7umAp5ew6vfl1YNi/JRB7aTGY1I
         U5bdMW/W0D+dVIOtPH0esTSU2fPuPsXINYZAusqBkmdxg/Rzl/QVZOwLxdDRfKu2uNF3
         BPpkqqlfMr6mMnxXMkuNiTD7527SkogtrIT58=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707390726; x=1707995526;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LaTp4U1LWb5pJxk+3p4oypsyvdSNZ1j6KLCLyUB+gDY=;
        b=wyMX2YO9sKvSdNsALrAtmPT2D2JP2NRfcQFO+aQuus0REm3uMpFLJvQmQvv/c0R8xy
         9Fj9mSQ4VBnM0TSzA3oXJhjKEpCrRPgYxGSNU7KmtA2nfqN2GML3qXfGxvyWykPjOdyd
         lvRVKgtaZGFvAMj3OtVG+TdN7hcNv9a7FUL+sX/IQS2mmI7rOjRkuyn5PdbLKD3NwLvT
         DB8TJSVdJuGlS9DWB6DI7z6qROMXXvsdTD+KSXYUaTPm+0z9qiCmxmCr5LpvusgTZ3n1
         zm2Rq9BD0eVWo+84Tf4h6MlEJPZAortHLTpU2/3TCO8I2VX/hoZEjwVH0Z+FGNQgmGmL
         caZg==
X-Gm-Message-State: AOJu0YxRMt6nV5oRsFYdjGsSCL8Llq7VHosLysUohAcaRtVcevihAeSy
	OEi2TY1MfGRT1/kvSZ2Ve0wfbajFA3Nwltz3EWwW6h/j4zhF5vF+mjbb6OEih8ileDouPWyrm55
	EZlA=
X-Google-Smtp-Source: AGHT+IE9jQjAOi3CzIoJQxbqPddzqhqJX2UPqWnWgdWcXyq4IEIOUcpAjnjdXc299ofxNjaYE0Ic5g==
X-Received: by 2002:a05:6402:391:b0:55f:31f7:4279 with SMTP id o17-20020a056402039100b0055f31f74279mr6061263edv.12.1707390726539;
        Thu, 08 Feb 2024 03:12:06 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXi9AfLPHs5E/yqAc8YJ4Sbsls2MNjeakuruPvSw0w1SLu8hYTzlOTIMukf2ASkk65OTarPBKgrBHiqPv6di7ZNc8C1+Z39
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com. [209.85.208.44])
        by smtp.gmail.com with ESMTPSA id p23-20020a056402075700b00558a1937dddsm691023edy.63.2024.02.08.03.12.05
        for <netdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Feb 2024 03:12:05 -0800 (PST)
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-557dcb0f870so1961331a12.2
        for <netdev@vger.kernel.org>; Thu, 08 Feb 2024 03:12:05 -0800 (PST)
X-Received: by 2002:aa7:de11:0:b0:560:5f1e:f416 with SMTP id
 h17-20020aa7de11000000b005605f1ef416mr5940766edv.32.1707390725562; Thu, 08
 Feb 2024 03:12:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <e2871686-ea25-4cdb-b29d-ddeb33338a21@kernel.org>
 <CANpmjNP==CANQi4_qFV_VVFDMsj1wHROxt3RKzwJBqo8_McCTg@mail.gmail.com>
 <20240207181619.GDZcPI87_Bq0Z3ozUn@fat_crate.local> <d301faa8-548e-4e8f-b8a6-c32d6a56f45b@kernel.org>
 <20240207190444.GFZcPUTAnZb_aSlSjV@fat_crate.local> <20240207153327.22b5c848@kernel.org>
 <CANpmjNOgimQMV8Os-3qcTcZkDe4i1Mu9SEFfTfsoZxCchqke5A@mail.gmail.com> <20240208105517.GAZcSzFTgsIdH574r4@fat_crate.local>
In-Reply-To: <20240208105517.GAZcSzFTgsIdH574r4@fat_crate.local>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 8 Feb 2024 11:11:48 +0000
X-Gmail-Original-Message-ID: <CAHk-=wiJj0AuV930QSxdBPz1RFSdLPdcxbY5KjqevKMAkJdBrg@mail.gmail.com>
Message-ID: <CAHk-=wiJj0AuV930QSxdBPz1RFSdLPdcxbY5KjqevKMAkJdBrg@mail.gmail.com>
Subject: Re: KFENCE: included in x86 defconfig?
To: Borislav Petkov <bp@alien8.de>
Cc: Marco Elver <elver@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Matthieu Baerts <matttbe@kernel.org>, Alexander Potapenko <glider@google.com>, 
	Dmitry Vyukov <dvyukov@google.com>, kasan-dev@googlegroups.com, 
	Netdev <netdev@vger.kernel.org>, linux-hardening@vger.kernel.org, 
	Kees Cook <keescook@chromium.org>, "the arch/x86 maintainers" <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Thu, 8 Feb 2024 at 10:55, Borislav Petkov <bp@alien8.de> wrote:
>
> What about its benefit?
>
> I haven't seen a bug fix saying "found by KFENCE" or so but that doesn't
> mean a whole lot.

It does find some things. You can search for "BUG: KFENCE" on lore,
and there are real bug reports.

That said, there are real downsides too. Yes, you potentially find
bugs, but the act of finding the bugs might also cause issues. And
that means that anybody who enables KFENCE then needs to be willing to
deal with said issues and have the infrastructure to debug and report
them upstream.

I think that's the *real* cost there - KFENCE is likely a good idea,
but I'm not convinced it should be a defconfig thing, it should be a
conscious decision.

           Linus

