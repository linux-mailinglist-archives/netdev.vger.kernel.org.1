Return-Path: <netdev+bounces-138887-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E256E9AF4D6
	for <lists+netdev@lfdr.de>; Thu, 24 Oct 2024 23:54:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1976A1C218B3
	for <lists+netdev@lfdr.de>; Thu, 24 Oct 2024 21:54:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B2B82170C2;
	Thu, 24 Oct 2024 21:54:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ULUsBNqr"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B1371B3930
	for <netdev@vger.kernel.org>; Thu, 24 Oct 2024 21:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729806845; cv=none; b=W78NtzstvEuoZD04rU4BckOphuGi485r5U5Iq7poZLoT1b6M0sEn85j7SdEQBlWYig2zF+dDM4TE6lyvCNYLcH5eD/l6rpt6GNB7TJw3IpNE2ZhqrkTHwpJTqD/Mfnkj3K3fgsNKBwcTAyzqsKwBiJISwyuM6gVDm52GFm/Wblw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729806845; c=relaxed/simple;
	bh=w2hrqYL0dfFGyNKEC2x3dHp+AUu3NDRYjQVY6MrdJZU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BTAN6brucM8qyygaMfPJyldcZwlsoHhlUgy/bzCZ+u3shFj9mIESKkIRaQbAiKkmOsHRl2YDE9/OjyTQdUGmPea2ZQsBY6qBV9MRTFWGS+0KqVRwJlzZrXVuPUIkBtmwncAFJqRckC70TxAD8XoXizuDtcWdWGUbLfsooeZDzCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ULUsBNqr; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a99ebb390a5so467673266b.1
        for <netdev@vger.kernel.org>; Thu, 24 Oct 2024 14:54:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729806841; x=1730411641; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7Uqj5jZN1Y90JeDsIqONz5XZYAyScvhWiyvgeMsTBY4=;
        b=ULUsBNqrtODmz5vlAkP8E1r6Y42GnAYiM0R28eEC0llfUXiYAFAysLOs0OfmIPdyXY
         zsN255GMhIhTU1MGxvCnpRsUkmD32/m2Pf4EAlRGxdANTWPsEFXWLUHwUSVtAtg/Wvo3
         DC3Z0EQfNkUW9SoK4EIbLlYQBM0nePO92J/LXfjzNEe3ZP78qNQ6xUMdQ0fTXYUKkYDo
         +rRb6nAS+Ycf3CMGjo1+hnqrFQqwR4OXyazL9VjT3eFtmkxLIixiLHFFRFOnFNjtFRUo
         BxaHsp2OOUDzaqpeO8oFerTDcADjANjIkf/mmTK6xGfC+ZvBHUVhwQeZNO1TJfm5CuBZ
         vKaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729806841; x=1730411641;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7Uqj5jZN1Y90JeDsIqONz5XZYAyScvhWiyvgeMsTBY4=;
        b=pBTopu3J2eK9rExKgIsbojyk2eoL4N18U0Bjx5Gzwj6hUy8qArFkrsw0DuI1x+sOFG
         XBZfEPvXRIEiyydeO/N1rrHMQTTQsADsuX0kiYQPmQxoSSmu37vKMn/CPMJgMXjn2qSp
         erDv/cWXPR/7EC6I1NQQ8P5SVz5tr/izu7wCu/UpO55W8ynLnBTbdsZB+tSSlaDrLOjA
         ARpIz3MulBKE4PmlPZJrQ+13xdseLQcvuij5Z2NJQnZwu4WZw5Pm2y6L6n96t4lIh0GL
         rwVqA+Coop/stBDrEkV07VNcM44i3Bdwf5vz4RjGMGq4IoBV+oPOpNkgBj3pTOzU62uf
         PRqw==
X-Forwarded-Encrypted: i=1; AJvYcCV+rzLRdoNQQroEP9mzjPj6fh4CxCZ73X61eOeLDHCHX7jlwcMZAPWTOdJHwbOjs4vUfyH2YBU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQ1m2AISSjhLxv9mafy/H8u5zb/HX6DxNrYmFT1Jr91IVV7sMM
	Z+GUdYvLNZMLSnkwBJ1QY+0kQNtqAW6a1+3bqZA/6OXQMWsf5VxaMlnKfjBfOHP5/CwpSqVBzBb
	e2YTtOzEtDXxanSZLBTG3f7X6zG2rDEEP18o=
X-Google-Smtp-Source: AGHT+IGQAKH+6LruNyHsxR3lLmS1Tz/jDv4PoTdTHhvEx85gf+hu0Oj39rcemdrvL8ZqcaMF+Oh9xcInVEspw7T4oS4=
X-Received: by 2002:a17:907:2cc5:b0:a9a:3c94:23c4 with SMTP id
 a640c23a62f3a-a9ad1a02e6fmr389581566b.22.1729806841245; Thu, 24 Oct 2024
 14:54:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241009-devel-anna-maria-b4-timers-ptp-timekeeping-v2-0-554456a44a15@linutronix.de>
 <20241009-devel-anna-maria-b4-timers-ptp-timekeeping-v2-13-554456a44a15@linutronix.de>
In-Reply-To: <20241009-devel-anna-maria-b4-timers-ptp-timekeeping-v2-13-554456a44a15@linutronix.de>
From: John Stultz <jstultz@google.com>
Date: Thu, 24 Oct 2024 14:53:50 -0700
Message-ID: <CANDhNCrTzUODaXyVdX2t+d+0s3cxWi4KV4MxJNjJrGh+0WxEEA@mail.gmail.com>
Subject: Re: [PATCH v2 13/25] timekeeping: Split out timekeeper update of timekeeping_advanced()
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
> From: Anna-Maria Behnsen <anna-maria@linutronix.de>
>
> timekeeping_advance() is the only optimized function which uses
> shadow_timekeeper for updating the real timekeeper to keep the sequence
> counter protected region as small as possible.
>
> To be able to transform timekeeper updates in other functions to use the
> same logic, split out functionality into a separate function
> timekeeper_update_staged().
>
> While at it, document the reason why the sequence counter must be write
> held over the call to timekeeping_update() and the copying to the real
> timekeeper and why using a pointer based update is suboptimal.
>
> No functional change.
>
> Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
> ---
>  kernel/time/timekeeping.c | 43 +++++++++++++++++++++++++++--------------=
--
>  1 file changed, 27 insertions(+), 16 deletions(-)
>
> diff --git a/kernel/time/timekeeping.c b/kernel/time/timekeeping.c
> index 878f9606946d..fcb2b8b232d2 100644
> --- a/kernel/time/timekeeping.c
> +++ b/kernel/time/timekeeping.c
> @@ -780,7 +780,32 @@ static void timekeeping_update(struct tk_data *tkd, =
struct timekeeper *tk, unsig
>          * timekeeper structure on the next update with stale data
>          */
>         if (action & TK_MIRROR)
> -               memcpy(&tk_core.shadow_timekeeper, &tk_core.timekeeper, s=
izeof(tk_core.timekeeper));
> +               memcpy(&tkd->shadow_timekeeper, tk, sizeof(*tk));
> +}
> +
> +static void timekeeping_update_staged(struct tk_data *tkd, unsigned int =
action)

Minor nit I realized as I saw how this was used later on:
timekeeping_update_staged() isn't super clear right off. Maybe
timekeeping_update_from_shadow() might make it more clear?

thanks
-john

