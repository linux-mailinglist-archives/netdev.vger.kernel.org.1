Return-Path: <netdev+bounces-138892-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 086FA9AF51E
	for <lists+netdev@lfdr.de>; Fri, 25 Oct 2024 00:13:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 41E6F2820D1
	for <lists+netdev@lfdr.de>; Thu, 24 Oct 2024 22:13:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54A6A217320;
	Thu, 24 Oct 2024 22:13:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lt+oIaVd"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C7391C4A32
	for <netdev@vger.kernel.org>; Thu, 24 Oct 2024 22:13:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729807989; cv=none; b=NjCXE9uV/foiIjJJD/IEtbModAhEwNeZTh0j+j42mTUErqyGBPZtwSUBXLYJ0KquseJU9kC8iCMNEnu2m5s3pmliw7CvvzOPu3DlIY5aSf1RLUn4swvlvFnJ1mWyW/4ROM7YnK9U7tewG6rVY3cH8BYaKV/26JBWJpgXzBr75NE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729807989; c=relaxed/simple;
	bh=qcL9+ZlcHChw9I39yL7aZCjBxyhLqJgCTbbwDXxMymc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Rrs4+2E/fB3FONuH3TdNkJ6kuI9w+q12shv3k7RJJ1kZZ+v55h1QhhHfxfLMxcLkP2DLQ1w3njarcjBjaq21ERPvA3O7MItxG5STaya0e9l+BXa6ZEuuiegv3kDMp888hkh5iDFaq93GQjYuRcbjKvOiuLYxoj1scsXSoiRt4J0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lt+oIaVd; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a9a0ec0a94fso187148566b.1
        for <netdev@vger.kernel.org>; Thu, 24 Oct 2024 15:13:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729807985; x=1730412785; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z+KsuGSLk9hwEP/LVz6TAbcNAQPELmdgGLuMvktV8lc=;
        b=lt+oIaVdpGyaawLNeJWy4BT8YVzuGTI57CIcVY4pLBdrJt59WKUna6894IQflJ8PTf
         BJe8zvfBUVzZucIzsW42nk2iz+u+8kQcQBDmHo5Jkkt4eZIzTaBMxPL2zGfKLSyyF+UY
         e2XjjSYKqHT8m1ZMJGOcwGGg2Hs887pNoZIbQpUiEKtpvK0ujF6+XCVzrmf/V+BWajQL
         VHb7nbjQRKqypzCFIsDm2+qG9H3XgyrnjALvef2ogTb0/y4+WiRtQR8t/3TvMQWoQqcA
         rZQTg2cmG8qpwOC6unoZdnagt6lWtsK+0kKSnSqiAyHCaR4s1sRcB3RAqRkTuu5D195t
         ahuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729807985; x=1730412785;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z+KsuGSLk9hwEP/LVz6TAbcNAQPELmdgGLuMvktV8lc=;
        b=whJZavv+iJ8GtJ5qQO3qHNBa11FQeyQYFFfnAC4t+DoZPkDG6aFdGNEpIBMRnbe+dO
         j34H1s6X/gfiTHWCTCl8FStbjCpjz8aGbUQkPUELCZVNLbD5QL3eD4tGc/frm2oYEqjc
         xbJTBFatFv4DWUWFhKhBSOg25D3d18UeSJeP22IaUWsTMZaegq7hZmV2V1WR188Cqa/6
         6vHajnbmz8eAuSAqXs3VE3n646sQmrEO6bPjakDJZV7T1XL+FBond5pPpukP0SV9USOt
         kk1R/KO3LhXz+doOTFE3hjojw4Yo38hH1CcBfW2oUY2YafU5/BktWIz+flAxav13RMfw
         VE+A==
X-Forwarded-Encrypted: i=1; AJvYcCVlUPtwRH+8c2S462bIQltT4cSF3KQ81ZHeD7GP1a2Fr0lyQJRQnmh3LbOAOsqndI6FBbW445w=@vger.kernel.org
X-Gm-Message-State: AOJu0YyMbSkWNdTLjgtzK7p45Tf2IaxgXv20trn9efcweqERjLEMf7P/
	x6fbbpDP1dPT7vmcAUdIjNqktGdmKCb29nvlWCarAcCz7U7tlYx4aqHrDdyOoTiUWpCCd/z/RBc
	IASKPfeh48OezicyQ5Gq8KUzrMT1Brw6zH9I=
X-Google-Smtp-Source: AGHT+IETo2LeFbEr+Q/wtTQYIcWMa+cws2aI5m+kZmFeitc7mhqIswS4t59K+/46Xt485HjQ5AfBa4sAxYqF1bCTtq8=
X-Received: by 2002:a17:907:7d8b:b0:a99:4e07:e6c3 with SMTP id
 a640c23a62f3a-a9ad270f630mr327016266b.8.1729807985183; Thu, 24 Oct 2024
 15:13:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241009-devel-anna-maria-b4-timers-ptp-timekeeping-v2-0-554456a44a15@linutronix.de>
 <20241009-devel-anna-maria-b4-timers-ptp-timekeeping-v2-14-554456a44a15@linutronix.de>
In-Reply-To: <20241009-devel-anna-maria-b4-timers-ptp-timekeeping-v2-14-554456a44a15@linutronix.de>
From: John Stultz <jstultz@google.com>
Date: Thu, 24 Oct 2024 15:12:53 -0700
Message-ID: <CANDhNCpDySwAsx20Wwm3_Np=e2venKx16a0BYVmq9j_XmpEjUg@mail.gmail.com>
Subject: Re: [PATCH v2 14/25] timekeeping: Introduce combined timekeeping
 action flag
To: Anna-Maria Behnsen <anna-maria@linutronix.de>
Cc: Frederic Weisbecker <frederic@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	Miroslav Lichvar <mlichvar@redhat.com>, Richard Cochran <richardcochran@gmail.com>, 
	Christopher S Hall <christopher.s.hall@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 9, 2024 at 1:29=E2=80=AFAM Anna-Maria Behnsen
<anna-maria@linutronix.de> wrote:
>
> Instead of explicitly listing all the separate timekeeping actions flags,
> introduce a new one which covers all actions except TK_MIRROR action.
>
> No functional change.
>
> Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
> ---
>  kernel/time/timekeeping.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
>
> diff --git a/kernel/time/timekeeping.c b/kernel/time/timekeeping.c
> index fcb2b8b232d2..5a747afe64b4 100644
> --- a/kernel/time/timekeeping.c
> +++ b/kernel/time/timekeeping.c
> @@ -33,6 +33,8 @@
>  #define TK_MIRROR              (1 << 1)
>  #define TK_CLOCK_WAS_SET       (1 << 2)
>
> +#define TK_UPDATE_ALL          (TK_CLEAR_NTP | TK_CLOCK_WAS_SET)
> +

Hrm.  I feel a little wary around having a flag mask called _ALL when
it doesn't actually include all the other flags.
I also recognize the "TK_CLEAR_NTP | TK_CLOCK_WAS_SET"  arguments can
feel repetitive, but I find having them explicitly listed makes the
code more readable to me.
Combining these common ones together just means there is a 4th option
one has to keep in their head to translate.

Further, as I look through the logic TK_MIRROR could probably be
improved by adding a direction (it's easy to mix up what is being
mirrored to what). Maybe TK_MIRROR_TO_SHADOW?

But these are mostly just strategies to help my scatterbrained state,
so this isn't a hard objection if you disagree.

thanks
-john

