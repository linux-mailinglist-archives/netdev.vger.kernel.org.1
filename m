Return-Path: <netdev+bounces-244869-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id A279ECC07AA
	for <lists+netdev@lfdr.de>; Tue, 16 Dec 2025 02:43:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3A757301C894
	for <lists+netdev@lfdr.de>; Tue, 16 Dec 2025 01:43:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F31712857EA;
	Tue, 16 Dec 2025 01:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dDLQX6v8"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43A62281368
	for <netdev@vger.kernel.org>; Tue, 16 Dec 2025 01:42:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765849382; cv=none; b=BrVD+vpz20UIrmb7v+rgLOQizfZJPiW+DoXID1TAy9IjjTmYHbZQtuQU9HLlZxLDUzDwBtgIjkeel3BcJiji+UZ0aiJLbtkoBtGg6hEyq/iFsjl7rlWXvv+nzf3gcrHFH+fckGZnW9kPfhWPuVsQLoAzeBf7VqGW5WFxIx3kOtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765849382; c=relaxed/simple;
	bh=ZyiAfBS1SHi1ogYvB6RKd2TbkiFPHcyLTNoNsrXdb6o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RQ4dwlNBrC+v8jZJOfjG4R/o7KfztDkioZ+YkQBXvLjtuP6oslE2c1tPDSKQPOoo3lOw3xahU1k5XIP35yfzA4x8SJIfJoeObYIwuNgG90fX2Os6o9fOKhveiD+EfwAb4CvPT4L6AIj2yFLkDRBlok2ob9MWLPIQ7FAW914C+6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dDLQX6v8; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4779a4fc95aso14026355e9.1
        for <netdev@vger.kernel.org>; Mon, 15 Dec 2025 17:42:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765849377; x=1766454177; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZyiAfBS1SHi1ogYvB6RKd2TbkiFPHcyLTNoNsrXdb6o=;
        b=dDLQX6v8xVx58d9y4lPH83vCx7nAbXoodPpqTmM0oWNmbVvOdGsENfXSco5Lgs9344
         zLQAE0JiACBwqMJjVVmVWY78HmZAQnVh/NLMg8Ns2X5y1ujQ6Ve2RvpKwEPBZxFzFnAU
         1c/V11w89MYQCHxfAFIL4qCthAqpqwI9KqYaAr2gQMVsWZ6gftv2+LGba7UR7umgDdhE
         v0b2eGdoDYPHd+XQJ774NDDGKSgy+W3GzPli/OiGOmuyKQBwxaIo5PoBFJxK4EWrwCEh
         /OspgPaMaDnRZSyoawBo1e7DZeyfAra6HWP/J3trzCQ3LlSxzlWkqnsQXA7ytn6oNqh2
         Xi+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765849377; x=1766454177;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ZyiAfBS1SHi1ogYvB6RKd2TbkiFPHcyLTNoNsrXdb6o=;
        b=guCYgLtiGUkibLRwFk40o02UE4/XwJpTNvzvebrbWTbkdAkIYzOmqMjcJiTKhRGQfp
         dTKwYFbTTqgJHn25tpt4wi72h4yE7VD8skz3N5oAa6vcILfeZT9k+UJ9rzq3cfB5vKo/
         EuWAhDz5i1Ob55fLA7UzjunEQVej+mFCvgl+kCotAyMvRhi1FD/bQH9obtE9cpWidF+H
         1dhvp1zIROba9Knd+KGpTyUdSZxSrCcTcLra6uHzoeldzIyhQXN34iPZaR4KnH3ZPdLh
         Mzx8UWPU0yK+HtHG3/ZrdPDU4P2XggZB+UV0I6CN0LsQPn5uBz4b5YTnUIeePiEuTq0s
         reKw==
X-Forwarded-Encrypted: i=1; AJvYcCU/o1RenI6V1oCeXiaUIAykFuIN69N0BoXFmUYbMdc/TYgPC4UjIqFO92YCjVHg4m9a1PGi62k=@vger.kernel.org
X-Gm-Message-State: AOJu0YzrvfV+0sNsY1/TGq2sm38hJufW7RjqS3OH7/Z7kIfPpb2GbrxJ
	kvR7dSXBYwgAShXX9WufhjLeMRYr6YdtQulklZ9FhPDnNhywNnW2ayAJmIqxBvI8+mL/yHpWjNg
	oeVbxKzu8cskKR1oiDn8LBHMhe7EPoCE=
X-Gm-Gg: AY/fxX4ET8RgxDTSj6HphpacQDDVbKHRK7gXvcZurHUo3fRQwwoUj4uL2NYDCpxrHVm
	NCAODvh7SY9W/gwxWC0INWWlmi8Ix2g8tvipWWLtQBzmNV49PKBPFOqb2XGJbu3CpDqDS+RM3bu
	pJEfpB4HrjCmDGj5cu9ZdHoTFGq9vfiJEQz4EUB2w0n2rWPWN6eKcPXbxbbl7Oy9zcR4+P5fSf7
	HVyn6fFh+Lgqg/5ifOWwaMRvzobKjj5F+Q7N37lismsuwd0jxAIYOamLaOv6hYhxR4PEcOWzxAU
	Ee7JrZFLY0xh4rga6f7aVtmnG4eR
X-Google-Smtp-Source: AGHT+IHXZEfg1p3HRgI0++xedDQyyt6TVJAX8tLf80JYu34CJbWOG8x06pVXb0fDbpBBSUhZfKL0ivJQkRM5N2F1zdU=
X-Received: by 2002:a05:6000:381:b0:430:f3bd:720a with SMTP id
 ffacd0b85a97d-430f3bd763amr10307348f8f.27.1765849377540; Mon, 15 Dec 2025
 17:42:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <176584314280.2550.10885082269394184097@77bfb67944a2>
 <20251216122514.7ee70d5f@canb.auug.org.au> <3cd2c37e-458f-409c-86e9-cd3c636fb071@linux.dev>
 <CAADnVQKB1Ubr8ntTAb0Q6D1ek+2tLk1yJucLOXouaF_vMqP3GA@mail.gmail.com>
In-Reply-To: <CAADnVQKB1Ubr8ntTAb0Q6D1ek+2tLk1yJucLOXouaF_vMqP3GA@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 15 Dec 2025 17:42:45 -0800
X-Gm-Features: AQt7F2qZ64Mmn0-BWatGXdXbAgAM-TAJMN_WlLu09kQhu9Y_Np5ib-yXqYgCTp8
Message-ID: <CAADnVQLE1R=DDjj88u+xuws8+JLKo6J2HiLj=jpO8MLpbp98SA@mail.gmail.com>
Subject: Re: [REGRESSION] next/pending-fixes: (build) error: unknown warning
 option '-Wno-suggest-attribute=format'; did...
To: Ihor Solodrai <ihor.solodrai@linux.dev>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, Daniel Borkmann <daniel@iogearbox.net>, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, KernelCI bot <bot@kernelci.org>, 
	kernelci@lists.linux.dev, kernelci-results@groups.io, 
	Linux Regressions <regressions@lists.linux.dev>, gus@collabora.com, 
	Linux-Next Mailing List <linux-next@vger.kernel.org>, bpf <bpf@vger.kernel.org>, 
	Networking <netdev@vger.kernel.org>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 15, 2025 at 5:37=E2=80=AFPM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
>
> I removed the offending patch from bpf tree.

All,

heads up. gmail doesn't like me :(
I see Steven's and Ihor's replies in lore, but nothing in my mailbox.

And Steven's reply was a couple hours ago.
Nothing in my spam either, and I was cc-ed directly!
So it's not mailing list delivery throttling.
Ouch.

If it looks like I'm ignoring your emails, it's not me. It's gmail fault.

