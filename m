Return-Path: <netdev+bounces-201740-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D610AEADC0
	for <lists+netdev@lfdr.de>; Fri, 27 Jun 2025 06:18:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 404A91BC7DC7
	for <lists+netdev@lfdr.de>; Fri, 27 Jun 2025 04:19:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DFDD19F464;
	Fri, 27 Jun 2025 04:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Op0uIzoB"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 396D218DB35
	for <netdev@vger.kernel.org>; Fri, 27 Jun 2025 04:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750997927; cv=none; b=LFn8gDnMKglsLS0pr0u+hbMdAy/QeZLQfEnRPnzmHdeqStafZMZYuFBsimYmcUfOZmMbdCcTm91mbLxbcOyeGI4yHklgydI6DwHF0ku1oqpTxryuOzrqbet7/E0wKzxEwDDk4YD1acmMPoMdDBIyRRdBF7/pbAorsUEkMFvasCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750997927; c=relaxed/simple;
	bh=vnE1I4Mx74SeCFjMsbUt4Z8knhyyQuvPiC5Wko6L4nU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sf8jkHiGoV4qDlj6gC9afYRpDyfGUdaktC0rcJd40dA5r390kesKHVm2lnkvvOksEGWapySVZzQSCb5T55CoHqln4h0S9QG/H92M9brE60mGTiPFiNEkJPRQUepKUS3jk5MyVHdUBLDbNJd5z+nPlDR8Kw2OGA9CZdd5fqajjW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Op0uIzoB; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-555024588a8so1664873e87.0
        for <netdev@vger.kernel.org>; Thu, 26 Jun 2025 21:18:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1750997924; x=1751602724; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8t82WOgljbjAJy235x2fO/KB2OhACeVta1dkXnb2jvc=;
        b=Op0uIzoBxkxJRSkHtSaHdvI7QOUeEvHBWAc7147SnjErc46Tcu/yS/obluaqtiEjbd
         n4DlOt09ahSCWJlosio8EK3dzIL8Y+4GXEyOW3WmuH0KsQjhCrcYDVCipn8q9QwJMzQ3
         qlfY0hsL/PjATHLmNPmGLe80+lHtRN4j76CW9Dh5LDBrLS1vMU/HK+69XlnI8M7mJJHj
         ENeo4DHAnKHmyjavWgjImOpSTgLYP+/a8M3Tjgh36AzZHrOGbzEvcsN61VUEjfnnOo38
         sucs+IlT+xVIVUqIe3gc3Hd/AuJjptQuEK7tlUWxinlEdYbbxumlSlyJS/YDoeyklNvm
         vnhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750997924; x=1751602724;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8t82WOgljbjAJy235x2fO/KB2OhACeVta1dkXnb2jvc=;
        b=OjoKv6gBQwZ3F5B9lZu63aKkYm67RkZytRt08S5NI3AB0kZzcuVBwwbnipHOHUfVG2
         tCPCHC8d2kEWb4EjnFsoiHEgWm/SFGsDYobVYETb8OdqGcya4z/8eiTlN3Ox7KMBDqtK
         E8AFpcY5AorpXRZNYTW/VOG7bQD/+zFH5ANr2xuxHMoyDRqlxQwHNDqkXQUs4mKaejvw
         EO9oG/s1zkSQka1BzEQ9iPUf4dYkSzxi7Qinfytbi8HsR0+9ul84KDoGfoNlasdPc60N
         I/3HJf10ZF2KT9R/7vVhy9ywhbfl3o6o/kfQS95ex/qYUi6PHMW/x4zZII+SpeAFjKIq
         67Jg==
X-Forwarded-Encrypted: i=1; AJvYcCVcvcPtTWVqgJgo79SKAA4RtVrqyRglpHW1H1boxjfhJkCEgTgO9eQIIbo68TAvzc+sszZaIu8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZUqMLAAKZCejfRybF58pbKYPrLUWrJ+Wn1W9IhQJw0mjLBcnd
	x+ik+Ez43CKcVimO91+FgijjIo9rXLAtPH4VPwupxresuzMl+RE5Iw6poR+5PXqd1nRlRNn90mh
	4+O3YKDA7+TIOQStVvruEzG0CqbqEB7uMZtulFQg=
X-Gm-Gg: ASbGncunrzhxRMxAtwW+PbnLAgFmi04zNcsKNhcIqbIxWQyQsF4yMBOxS3y4D076nu8
	oufSt0wS7pNMyXog0O+Ce1R/3d4B7QBY4eAoTPyZD0RZoz0KHXM0zAoIFR/ytTIGFAWNGlypw8n
	lyvidWcKajAhH1stOQgQtuLR7mGi7duni1MBIdxCltOH6XAV08DBYTCrGyew1QA05CdooqX1wM
X-Google-Smtp-Source: AGHT+IEbVRw58ilxaIlZe1goTFVY66x9DDIQfysAIxkk3qNfcZyJs188QMsK2gKbw3I74XPTb1bizoehc0UgRlQwQk0=
X-Received: by 2002:a05:6512:6cd:b0:553:2cc1:2bb3 with SMTP id
 2adb3069b0e04-5550b9e5b30mr555590e87.36.1750997924074; Thu, 26 Jun 2025
 21:18:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250625182951.587377878@linutronix.de> <20250625183757.868342628@linutronix.de>
In-Reply-To: <20250625183757.868342628@linutronix.de>
From: John Stultz <jstultz@google.com>
Date: Thu, 26 Jun 2025 21:18:32 -0700
X-Gm-Features: Ac12FXwpF-DZ90vOuLHW0-i4h3baVzthw0f4v39k-ywGAqmwVfr6zg0R2Fdv0cQ
Message-ID: <CANDhNCp+Kw3ZGC6Vuuhq=FXKS+AXba4k5==qP+JV4miiN1cXGw@mail.gmail.com>
Subject: Re: [patch V3 02/11] timekeeping: Provide time getters for auxiliary clocks
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>, netdev@vger.kernel.org, 
	Richard Cochran <richardcochran@gmail.com>, Christopher Hall <christopher.s.hall@intel.com>, 
	Frederic Weisbecker <frederic@kernel.org>, Anna-Maria Behnsen <anna-maria@linutronix.de>, 
	Miroslav Lichvar <mlichvar@redhat.com>, Werner Abt <werner.abt@meinberg-usa.com>, 
	David Woodhouse <dwmw2@infradead.org>, Stephen Boyd <sboyd@kernel.org>, 
	=?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>, 
	Kurt Kanzenbach <kurt@linutronix.de>, Nam Cao <namcao@linutronix.de>, 
	Antoine Tenart <atenart@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 25, 2025 at 11:38=E2=80=AFAM Thomas Gleixner <tglx@linutronix.d=
e> wrote:
>
> Provide interfaces similar to the ktime_get*() family which provide acces=
s
> to the auxiliary clocks.
>
> These interfaces have a boolean return value, which indicates whether the
> accessed clock is valid or not.
>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> ---
> V3: Remove misleading TAI comment and use aux_tkd* for clarity - John
> ---
>  include/linux/posix-timers.h |    5 +++
>  include/linux/timekeeping.h  |   11 +++++++
>  kernel/time/timekeeping.c    |   65 ++++++++++++++++++++++++++++++++++++=
+++++++
>  3 files changed, 81 insertions(+)
> ---

Acked-by: John Stultz <jstultz@google.com>

