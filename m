Return-Path: <netdev+bounces-138873-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FF869AF476
	for <lists+netdev@lfdr.de>; Thu, 24 Oct 2024 23:12:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DF9631F2238C
	for <lists+netdev@lfdr.de>; Thu, 24 Oct 2024 21:12:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C431321790E;
	Thu, 24 Oct 2024 21:11:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pgCQwu2k"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A815F2178EA
	for <netdev@vger.kernel.org>; Thu, 24 Oct 2024 21:11:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729804286; cv=none; b=ezKcjiiFrkRxNDublCsx/JWDKEnMpm/wJOeuPPsx6WfoyrKlJzLqJ99jFDcGKYWKDQ9+IHYCLPXjUCKidIIup0Rq5u2d33REXUFlrhpAh+taJrtbLlUDgBJ3yrfYIeQ8YKk/5qQ/pbjoQNtUtC1A3Me/1uUKLb7TQsU3LnNhT1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729804286; c=relaxed/simple;
	bh=yMbiVa6MxBi8SIH7Jh+s9NpwcvOveX//Z97Dk2oQt94=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NLyCCdDqt/+85JpkZlzEZ9EN7tl6g+XXxax7AmNg8tPSotICUjQ+9TkuExMoc/a71K6Qp/JYlduJtkTJwCtvSfOX0u4YMOTpnNiangaKoCpOOBXNW7aWMiwg/ibMtUxGNEJ1iOiMGHZ9NYeSKOUjDtbAuvCSVRGrmlx3CPB5csY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pgCQwu2k; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a93c1cc74fdso179556966b.3
        for <netdev@vger.kernel.org>; Thu, 24 Oct 2024 14:11:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729804283; x=1730409083; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yMbiVa6MxBi8SIH7Jh+s9NpwcvOveX//Z97Dk2oQt94=;
        b=pgCQwu2kDGw4WFELaWum4uv+I3HzCnJXRAsnEhWvQpDMMWmCLrglv3ieNEpWKQLUTr
         miH6qiFYrQed/npUZ5VG+y5iO7lrvAQ+m2LiA0PFbt+yGGdPo2KB9LlE47KBJ6lJWaA2
         ZHXp0Xazs0kko0E1peauc9LbKWvttnpS2CvmquwMsO1jvT9XbId3j9ZAkwPs1M7AvSsI
         rrW0fQfKISpnCX87nE5ZqhU17j62JyY36Yg9jlGJHDnW3EcQRyn0I+y1lV9CQfPRK4OW
         Mx8k+EwU0bZr1wcpuWUJxM77NtXOWBo+jteosqVXV/Xwrp0A1znfzwIR7T2ZcES/yXKF
         B1BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729804283; x=1730409083;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yMbiVa6MxBi8SIH7Jh+s9NpwcvOveX//Z97Dk2oQt94=;
        b=rJXjtNtBDyQBtzMQdK2Qa6jLnx/4otewII1CrjMVdFBLcNUw10Y1rKzfwfduKrCJmc
         knoXdOIUdG018m4QvbWiC9Ob4ouE6v4gEO9BfVz5Mx2fAo8MWBuu5JSb18Jhwp++JS35
         7h5HsCjpK2hk9Mii85wgkWS75eWVHreWPKHAEbmLIT8/4tCFgthODnoHB/k9ZnlkxWiL
         mUbR2YDppvrEKcmDlHjAfbVZKv/d41GQ7xNWpWy9AXs7yVCsXsIHdDQXwG3RR3zs5LDu
         uZVYfGgtCaCRZXlwChmGA/ye4G0oJqDpURrpUAb1wrXKyLHmAuJH5s8QyZpELKSg0a/t
         uOxQ==
X-Forwarded-Encrypted: i=1; AJvYcCUWK+s12XpWT3kH6WRWkMN2SsytMu901Niu34TaF6Gc8J6QjYAec6nu6C4QGnNTm7JQpvxGx/k=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZIeFzl/aX6miiSXqm/LNaJyD9unWx5vnh88pbYAmAPAHeQOz8
	RNgvrf3z1H4uS2zJ0EwbJeOfDGykVlDfAIXbuq5u14vjlEhJEPtOY7asIG1vUNtidSE/GBR1gs7
	EvxV97Hs7Wzcs+mlWopuyHAaHWZGpmkpiNMs=
X-Google-Smtp-Source: AGHT+IF36IipaF0Apyziua1nDu2qSOpHLIz9jwkRDHpQ2hX3c3T/iEQCcyCPryciyreYm9HN3Sj5EFy2jfOVqmuqi+8=
X-Received: by 2002:a17:907:9805:b0:a9a:673f:4dcc with SMTP id
 a640c23a62f3a-a9abf889e9cmr717378666b.22.1729804282544; Thu, 24 Oct 2024
 14:11:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241009-devel-anna-maria-b4-timers-ptp-timekeeping-v2-0-554456a44a15@linutronix.de>
 <20241009-devel-anna-maria-b4-timers-ptp-timekeeping-v2-7-554456a44a15@linutronix.de>
In-Reply-To: <20241009-devel-anna-maria-b4-timers-ptp-timekeeping-v2-7-554456a44a15@linutronix.de>
From: John Stultz <jstultz@google.com>
Date: Thu, 24 Oct 2024 14:11:11 -0700
Message-ID: <CANDhNCrpOGnNXg0Q5QtWi3EzoyB=nO4BNqSk=oL5P-Qqy+301w@mail.gmail.com>
Subject: Re: [PATCH v2 07/25] timekeeping: Move shadow_timekeeper into tk_core
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
> From: Thomas Gleixner <tglx@linutronix.de>
>
> From: Thomas Gleixner <tglx@linutronix.de>
>
> tk_core requires shadow_timekeeper to allow timekeeping_advance() updatin=
g
> without holding the timekeeper sequence count write locked. This allows t=
he
> readers to make progress up to the actual update where the shadow
> timekeeper is copied over to the real timekeeper.
>
> As long as there is only a single timekeeper, having them separate is
> fine. But when the timekeeper infrastructure will be reused for per ptp
> clock timekeepers, shadow_timekeeper needs to be part of tk_core.
>
> No functional change.
>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>

Acked-by: John Stultz <jstultz@google.com>

