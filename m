Return-Path: <netdev+bounces-70174-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B7DC184DF7D
	for <lists+netdev@lfdr.de>; Thu,  8 Feb 2024 12:13:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1ED841F2BC44
	for <lists+netdev@lfdr.de>; Thu,  8 Feb 2024 11:13:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFBAC6D1B8;
	Thu,  8 Feb 2024 11:12:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jICS/dOy"
X-Original-To: netdev@vger.kernel.org
Received: from mail-vk1-f177.google.com (mail-vk1-f177.google.com [209.85.221.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3733C67E73
	for <netdev@vger.kernel.org>; Thu,  8 Feb 2024 11:12:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707390779; cv=none; b=kMjr1bJghduJGiFdLJ20kQCtLeqRHUzdh9bLEV7F7Q+o17xok57xTd8oGhqE5FKXgTNo4MviEf089KUBiTnihTpjqx8Z6Y6mapilVR1tnIGZeiKoQQAD9ViQYyNJlE4hp70BWMqkpbn2O6TRlQZ0VsXqlzv4NDzPf9MS8+2Dhy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707390779; c=relaxed/simple;
	bh=8gi5MnJGuewU1bGs1k9IlTYa9gB6AFXwYQKFo1KbAhY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cmBu/LHRQZ6o3gLrhxFnsj8rjZxUUBv/2tjVpc/wwyi+20YC0aLfhio+KzmsJs6gV5xzC5jt6BScbGTh87uTN2e4t30mVx04JhMl4tsk266TktVx0kO1Pgy6YRlJE9Ss0bG18xFkV62bm/jir0SOtc6Q+eXM0npWaDWrLhUP5qI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jICS/dOy; arc=none smtp.client-ip=209.85.221.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-vk1-f177.google.com with SMTP id 71dfb90a1353d-4c02a647ed9so593532e0c.1
        for <netdev@vger.kernel.org>; Thu, 08 Feb 2024 03:12:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707390777; x=1707995577; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=VJsSscqQ4m0MN/FGyPVyx9oMz+6/oNg/GzMN0pvUUbw=;
        b=jICS/dOyLnoWcYDeY/oKuQ7L6H0nQZsFGC31DwzsEVTTdxKqn/eLk4aILgKq4eX0rO
         YXR+ykz4Lv/9pMFY1pXVgFZF5pNRAYLUIZI9kLpyab6OudTSqjNrUrnBS/+eA7Zs+/0S
         Vug0clXseqXgQ1kq14aN7in0Gt7qO4SoSHNlR3j8mK3vfT63EzkgkzkysmkhKe+TfX01
         0i8YyZM69lQcRZ/xn6z1z/lKSgBnaXRgQC40EOJ56prLAQwAOeT+T++CmP7AHtbpdsqI
         1VMPl2GujmLpJjO0RH6Cp/NFx+MDsJ1a1eLfMDdBMWi2dE+OHg2k3JMfG0dYu8pcr4x4
         9anA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707390777; x=1707995577;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VJsSscqQ4m0MN/FGyPVyx9oMz+6/oNg/GzMN0pvUUbw=;
        b=lJhefa2sTO7eCSd74tVyUv/QloJtD0POpLZbd1K/d2MsU8qo92gNEmGiMkmC7NQlyC
         hk3qEdmw/JBIffAbLxnjGyru3IJ2DJpuiZaixhfPCQ7q4o+MC338cjkBszz8iRz7loT3
         isyWBQw5cL2BP96K6VeEFOxvoczrWX7Kur00OaHck04VfHqQjaV83LOEWFUOiS1rA0NW
         +kILfLCGzbs5Y3i26U5EdXq32UvUuuTXQmMCA1eT4sQybWCm5UJIgtNAzodEPVLKKGoy
         7Kbdv+DyB3wa5sPWmKUEqKfBtfFXSuQrH2GUsD0fQcOM1s4N3jTjccYdLGne1oY6B1Lv
         lZ5w==
X-Gm-Message-State: AOJu0YyFerIbC6w8vY/+dUCz/wfTB3i/VXwMH+rd/cPCbGOnVvKsCaVC
	mb1yFNTBGR2uyW7AkK4DV4S5fm0n1hxp4Hkh1OckxJHpeK4JOSwvSrCcr9fTFmnCWhXOZgz5q9e
	3O2CTXhysDFxzfPJrAuc+tZbYMNm8e7lMn7R7
X-Google-Smtp-Source: AGHT+IGK9Sflctbxb9jUDvnRHW4QaZ1op+CyDFwMT4jg3EWzCupn+gEyn7KRTra/c5FmSWw/UDmsfw9TV5Dl6t6plkc=
X-Received: by 2002:a05:6122:1807:b0:4c0:292d:193c with SMTP id
 ay7-20020a056122180700b004c0292d193cmr5712620vkb.12.1707390776764; Thu, 08
 Feb 2024 03:12:56 -0800 (PST)
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
From: Marco Elver <elver@google.com>
Date: Thu, 8 Feb 2024 12:12:19 +0100
Message-ID: <CANpmjNPgiRmo1qCz-DczSnC-YaTzpax-xCqbQPUvuSd7G4-GpA@mail.gmail.com>
Subject: Re: KFENCE: included in x86 defconfig?
To: Borislav Petkov <bp@alien8.de>
Cc: Jakub Kicinski <kuba@kernel.org>, Matthieu Baerts <matttbe@kernel.org>, 
	Alexander Potapenko <glider@google.com>, Dmitry Vyukov <dvyukov@google.com>, kasan-dev@googlegroups.com, 
	Netdev <netdev@vger.kernel.org>, linux-hardening@vger.kernel.org, 
	Kees Cook <keescook@chromium.org>, "the arch/x86 maintainers" <x86@kernel.org>, 
	Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"

On Thu, 8 Feb 2024 at 11:55, Borislav Petkov <bp@alien8.de> wrote:
>
> On Thu, Feb 08, 2024 at 08:47:37AM +0100, Marco Elver wrote:
> > That's a good question, and I don't have the answer to that - maybe we
> > need to ask Linus then.
>
> Right, before that, lemme put my user hat on.
>
> > We could argue that to improve memory safety of the Linux kernel more
> > rapidly, enablement of KFENCE by default (on the "big" architectures
> > like x86) might actually be a net benefit at ~zero performance
> > overhead and the cost of 2 MiB of RAM (default config).
>
> What about its benefit?
>
> I haven't seen a bug fix saying "found by KFENCE" or so but that doesn't
> mean a whole lot.

git log --grep 'BUG: KFENCE: '

There are more I'm aware of - also plenty I know of in downstream
kernels (https://arxiv.org/pdf/2311.09394.pdf - Section 5.7).

> The more important question is would I, as a user, have a way of
> reporting such issues, would those issues be taken seriously and so on.

This is a problem shared by all other diagnostic and error reports the
kernel produces.

> We have a whole manual about it:
>
> Documentation/admin-guide/reporting-issues.rst
>
> maybe the kfence splat would have a pointer to that? Perhaps...
>
> Personally, I don't mind running it if it really is a ~zero overhead
> KASAN replacement. Maybe as a preliminary step we should enable it on
> devs machines who know how to report such things.

It's not a KASAN replacement, since it's sampling based. From the
Documentation: "KFENCE is designed to be enabled in production
kernels, and has near zero performance overhead. Compared to KASAN,
KFENCE trades performance for precision. The main motivation behind
KFENCE's design, is that with enough total uptime KFENCE will detect
bugs in code paths not typically exercised by non-production test
workloads. One way to quickly achieve a large enough total uptime is
when the tool is deployed across a large fleet of machines."

Enabling it in as many kernels as possible will help towards the
"deployed across a large fleet of machines".  That being said, KFENCE
is already deployed across O(millions) of devices where the reporting
story is also taken care of. Enabling it in even more systems where
the reporting story is not as clear may or may not be helpful - it'd
be an experiment.

> /me goes and enables it in a guest...
>
> [    0.074294] kfence: initialized - using 2097152 bytes for 255 objects at 0xffff88807d600000-0xffff88807d800000
>
> Guest looks ok to me, no reports.
>
> What now? :-)

No reports are good. Doesn't mean absence of bugs though. :-)

Thanks,
-- Marco

