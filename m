Return-Path: <netdev+bounces-250920-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 81309D399CC
	for <lists+netdev@lfdr.de>; Sun, 18 Jan 2026 21:39:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C2928300A34D
	for <lists+netdev@lfdr.de>; Sun, 18 Jan 2026 20:39:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F4B23033DE;
	Sun, 18 Jan 2026 20:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ofe1M8Gt"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DF6D1A83F9
	for <netdev@vger.kernel.org>; Sun, 18 Jan 2026 20:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768768753; cv=none; b=Qs4SLmgstfMn992Sf/1LXtAyQrg0GR0cV5lktbtonbP9RbGKrTjoZ0jXtZ8l8ofO3q1YmHRSy/gis2rnrrcGGW6Itw/VDfy3awvMYu6Gw9K7J29WfsLhEZo2Tms61EEYOEV8u1zLK7k5IciE0CqLTCi+GWEbc11G5oIgEjOBayI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768768753; c=relaxed/simple;
	bh=2yDvJx0GGuK/Vd37qVVlWlEfyxRbe7wxAptwgArqz14=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OYCJZVTtDrOJFkDR0NjalbsKdSf2Bn1C5jZ6rOB/QLU+9ud2wJnsKsejxfV7bph7QOJV6wQuDzBT9VVdIdNtx8w5G77SVL4EFHUWx3YJJLbxi/Elmfd7v9E5iIPvm20DlgT4VpXHNS2FjOGqRhvySYwd37j3zTfjjwQXhXwQySA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ofe1M8Gt; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-5029aa94f28so27941501cf.1
        for <netdev@vger.kernel.org>; Sun, 18 Jan 2026 12:39:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1768768750; x=1769373550; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dUGG14hZQPHEu4JQpXGQ2rJjf4XwvDc8W7pQcYHbasM=;
        b=ofe1M8GtyU4nvgMM4RvmQ9TdkLuqs9ANYoRPsrj5cvI1ESuS7Je5ETrmN6FaQ1Z161
         dWEox8w56p27h2RpiJIz6vuwRorXdrjxXUxk0uAL08fcMldJxhNW70LoutzampvTtn1V
         zd5fOGPr01SqeiNLKWYHNFyX1t7Tmt9PRM/XgOsqOtfPJpH1vKB7aInSeQ0ngXLEtT8E
         sANecLpEqZQAOL7Pqx3faWoMFMxrk/j/ZYbqQa+IKZNqNbsfuuVtlfm4VnTSEESc9SMb
         N2X3fa9G6WXu0GNY13D7/lO4IXSQSTSH69/LF6fMw1mJAx4rMEqYRgFHeV+7KbSRYtcV
         Ud0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768768750; x=1769373550;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=dUGG14hZQPHEu4JQpXGQ2rJjf4XwvDc8W7pQcYHbasM=;
        b=R+XA/iPVKQFGUm29uyZD6XRbNek1zBstO7a+RMAH6Wm6UBaf7xtrAxoJq+esqW1Orj
         1qwKCBHUFkjVx/WHl0NV+9pAFA05bhbrKKx7XJMLJOLNKy7SNzsI8XhVPMMZxbbzLlZi
         b+JAaFH5vGntbwR1TbLs2ly3rHwjM6eOZm4K6VX1YeFlB5weEcGrfm0lnmplVmUNdA9i
         sMDmCW+GCdN4gXTNcKfOpPeiSJmz3TxwbraddQdvar7wYxISpiWqpjeVDoOJqY4f+8LB
         eXEKj3HHl2/t8mOvui+C59Dy+KtYGDfCIrouJQgq5NguRzz102t6gV3mqFU1W/mHn3gJ
         dOrQ==
X-Forwarded-Encrypted: i=1; AJvYcCVeNt2um53ID5dRu5hjK6q/EbjmWMIybGR+P9i4BYb+o36Awq7NyymKchncZFSX5uOWGNe+ezs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJWmjW4/gJeNE94jkx/NOAX9CifsrnLoFtxVeVwngxomTw0oRT
	YB4W/cnkaxoWUF0U6K2pc/0lrh7JhHGS5a31K7DankOg6oGIFcTdKBTVBvqo8JKBlIY7KujfhUH
	dyjxbHkE39KtY3lUg6jl3MAdCHJ+CC6E9dQJvw0X+
X-Gm-Gg: AY/fxX4SAH9atfwlEDAmywlzIjd5dtzOgH62CzRjUtgyxnMALlzC/3vvNH0ZdgaXEFm
	tDeXm/8NT44LymKxrcnan94GVeemr1Ccro2YcBuL0G/jgVAtJ9WPqrpbHqyEe/jWoAu6ZgOtXgS
	4gduxtcRQJaS9dhF6DqQv+qZwpGKq9aWuzu3qRH34V/YP323IwRccfdxqqxsG1gEYBRLKXWT8Vd
	KwWW8bDyut0S1mra89bIvgLFL0G1CnLsLx/skzT32BwP4maDWkrXLhN6rua1cv0pLyzL8n4
X-Received: by 2002:ac8:7f0e:0:b0:4ee:13dc:1040 with SMTP id
 d75a77b69052e-502a153e94fmr145796091cf.3.1768768750351; Sun, 18 Jan 2026
 12:39:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260118152448.2560414-1-edumazet@google.com> <20260118114724.cb7b7081109e88d4fa3c5836@linux-foundation.org>
In-Reply-To: <20260118114724.cb7b7081109e88d4fa3c5836@linux-foundation.org>
From: Eric Dumazet <edumazet@google.com>
Date: Sun, 18 Jan 2026 21:38:59 +0100
X-Gm-Features: AZwV_Qgh0mbFyAnAzrbQkGBPoSEIYVqtxy2UcYDaDSkM5g9GX9ku00d64kFA9WU
Message-ID: <CANn89i+RBRNuftz5HfsEVW39VvnQWiUdins4CTRzGXoeJ3jAMQ@mail.gmail.com>
Subject: Re: [PATCH] compiler_types: Introduce inline_for_performance
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, netdev@vger.kernel.org, 
	Jakub Kicinski <kuba@kernel.org>, Eric Dumazet <eric.dumazet@gmail.com>, 
	Paolo Abeni <pabeni@redhat.com>, Nicolas Pitre <npitre@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jan 18, 2026 at 8:47=E2=80=AFPM Andrew Morton <akpm@linux-foundatio=
n.org> wrote:
>
> On Sun, 18 Jan 2026 15:24:48 +0000 Eric Dumazet <edumazet@google.com> wro=
te:
>
> > inline keyword is often ignored by compilers.
> >
> > We need something slightly stronger in networking fast paths
> > but __always_inline is too strong.
> >
> > Instead, generalize idea Nicolas used in commit d533cb2d2af4
> > ("__arch_xprod64(): make __always_inline when optimizing for performanc=
e")
> >
> > This will help CONFIG_CC_OPTIMIZE_FOR_SIZE=3Dy users keeping
> > their kernels small.
>
> This is good.  __always_inline is ambiguous and the name lacks
> commentary value.
>
> If we take away __always_inline's for-performance role then what
> remains?  __always_inline is for tricky things where the compiler needs
> to be coerced into doing what we want?

Some functions should  not be out-of-line, even if
CONFIG_CC_OPTIMIZE_FOR_SIZE=3Dy

A case-by case study would be needed.

>
> IOW, I wonder if we should take your concept further, create more
> fine-grained controls over this which have self-explanatory names.
>
>
>
> mm/ alone has 74 __always_inlines, none are documented, I don't know
> why they're present, many are probably wrong.
>
> Shit, uninlining only __get_user_pages_locked does this:
>
>    text    data     bss     dec     hex filename
>  115703   14018      64  129785   1faf9 mm/gup.o
>  103866   13058      64  116988   1c8fc mm/gup.o-after

mm/slub.c has __fastpath_inline, depending on CONFIG_SLUB_TINY

This probably could also depend on CONFIG_CC_OPTIMIZE_FOR_PERFORMANCE

->

diff --git a/mm/slub.c b/mm/slub.c
index 861592ac54257b9d148ff921e6d8f62aced607b3..a8ca150a90355dd7a812f390c06=
8ff9a7ccc2562
100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -224,7 +224,7 @@ do {                                        \
 #endif

 #ifndef CONFIG_SLUB_TINY
-#define __fastpath_inline __always_inline
+#define __fastpath_inline inline_for_performance
 #else
 #define __fastpath_inline
 #endif

