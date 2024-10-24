Return-Path: <netdev+bounces-138885-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E793E9AF4C4
	for <lists+netdev@lfdr.de>; Thu, 24 Oct 2024 23:43:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A354E282543
	for <lists+netdev@lfdr.de>; Thu, 24 Oct 2024 21:43:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66C421C4A11;
	Thu, 24 Oct 2024 21:43:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mihKTFKJ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F35122B655
	for <netdev@vger.kernel.org>; Thu, 24 Oct 2024 21:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729806213; cv=none; b=Bpsc6fx3s8ACTg+MpJM7yPXPlA3oZ6+wCSXVgMwQlAYHIDhgnR55ja/Jp8AlvDquaebec8eQBMtBtrb9wnfdh/3UtfP8v8azx7NtzoRIxuE64K0HGnQp4BtkHoeL+XAzK4Fpej5ikwWlvOeRBWWWg4/wsD8uH03pxm1ZzhB0X9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729806213; c=relaxed/simple;
	bh=Ou3/GaiFLYKzPMyV+4cPIznIN0mWR2rrjRvzqDHBrSs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=q+vRcEaZaLpiHdW1iFFvqIOs6/E6Zfq5ytu57nQcalxpZMk23lE0uaQx3E8P5Z6HsgzrRF4Jcd08n05eVeZxLuFpKqKHOgTvwKpAwTEuSuNsNatkAyCPHBG+IpGFfSy9qSMoVDFDXLf8ixJc+HBfg+LvfcTHFXwjK/qwh8AZZVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mihKTFKJ; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2fb4af0b6beso22140651fa.3
        for <netdev@vger.kernel.org>; Thu, 24 Oct 2024 14:43:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729806209; x=1730411009; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ou3/GaiFLYKzPMyV+4cPIznIN0mWR2rrjRvzqDHBrSs=;
        b=mihKTFKJvOlwKgrYE7VG2Syc1qycmaoHSu61cSIcV6EkP+tlAc6brWkqT7uc7cve3F
         ti9VVTVf5HfEs6udW3pFfXK2IZkX4gvpQzeu5jhkdmHUoqsjTYQ78tXHp/faKs3gswf9
         kubPNYnXmudD7pSl/YbQ8EnclpGy9f6arpBUPxjnxdCHo38GaEJDRmwvZOGOGMdhmxsG
         XFYrDT5SkLKhjfdwu9y9sZQQExS7YNOL2JX1ImZ+9QQUkmJ0Y2gi6dPLsSeb0G2D6jIF
         tyFbohENC27o0Uuc7f5KQcxxUii3BGraP6QnW8bUU3KYZUS81HIoZnLA/wP5mIOE6aVL
         bF4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729806209; x=1730411009;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ou3/GaiFLYKzPMyV+4cPIznIN0mWR2rrjRvzqDHBrSs=;
        b=p1EbiiBg+lv966yEgm//Pq/YB2LUaRnTAZKUNrVyfntHOP3xDoGw7q+OLUvDgc47eU
         FmwLNKb+KCT+Vp8TOx0g+yNRa14i1pYKA10t5DLKwHWPlu8qTURcY20qHJAOekO1w/rv
         SPbAeq3/Xu6pVHtpRgiQ+l7yHDI88XqYClblDOaCnynpwysLhLh9tvedfLpY4yLHSpLY
         XxYMj1kTdnYhXaAXL5pFp7e4B8U0kGTJAJAH0fBmoCorqozLr/J3gMnsWIiu+Ul9xpY6
         KO80IVnkGPMHS8mJMplpi44jakbbj7OWhZAy+bgrI6GnuAqaqVYE67lt2waVOr4theCm
         95nQ==
X-Forwarded-Encrypted: i=1; AJvYcCUz68N16ML1cNHZi+sI/y7mzSYIyYYrZ93L6iUCgL7kIhWlI5ZVMh+EQzVwsAVLS9lCKhLm2ww=@vger.kernel.org
X-Gm-Message-State: AOJu0YyOWYMyZJi3SOAEXiZ3RteiA1/CTMGbi5azgMlcTYikYT2rDngB
	M0zPmrfufz/oVKjRaUny0O+EF8X5IWkys/u/ssOdddotBhzLHmwmH97v09+PAY8vK1ZXJ//81sn
	iJg9fLrrRF6YaHVQjyuF/91LJm0LM4oPbeU0=
X-Google-Smtp-Source: AGHT+IFWeLtqmN8ZcgGfN2kk1uX0Kj8LQtzKpabyI4FcL0WKt8e/QOcReI2SWyr5yVvPpJFDkkegoXJvDdTXZSLcPyE=
X-Received: by 2002:a2e:a547:0:b0:2fb:5014:aad4 with SMTP id
 38308e7fff4ca-2fc9d2e54d5mr71283791fa.9.1729806208888; Thu, 24 Oct 2024
 14:43:28 -0700 (PDT)
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
Date: Thu, 24 Oct 2024 14:43:17 -0700
Message-ID: <CANDhNCrSE+i_06jAMFa56d8avW84F7n_Kms6LrxGjOAVjZqS=Q@mail.gmail.com>
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

Acked-by: John Stultz <jstultz@google.com>

