Return-Path: <netdev+bounces-201754-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E96C0AEAE6C
	for <lists+netdev@lfdr.de>; Fri, 27 Jun 2025 07:23:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F31C71BC78DE
	for <lists+netdev@lfdr.de>; Fri, 27 Jun 2025 05:24:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2210A1D5154;
	Fri, 27 Jun 2025 05:23:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OJbuPpun"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 660D319EED3
	for <netdev@vger.kernel.org>; Fri, 27 Jun 2025 05:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751001829; cv=none; b=FUJQ/KhZSdhcnXbD9yxxIv+I+SktncwUhBrGGU0BP5NPgJ9zXBRTVHMeZNuLmp4GxauhmFXakE2v99/O6kZ2ufYHJZ6hWhhoY1CrE7TD/pugWr4ZEEEb+FxFYK7udsYH1dvA854FYNfjPY9axqCf8yofa6er4m4xCFaJkRbxY9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751001829; c=relaxed/simple;
	bh=SiH7xridhHLVUbjwk1VSxv1+eCF5hmb0du6+goXv3Z8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cDc/19PTrniHqhMwLy2jFtmA8dTgz1L7vRpVcT60/cfJDzdfwwz3O6Qmedc9t1SZBHfcxkLEorm7+0Pkeo6370fPL5Fo6vuhmyo6hrn87G3ECkHkQpXtWdrhUBSOy+/rdUOEKhO1gUE9OUFXiTS7C7q3yV6jxMlcYrIUo9fiUcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OJbuPpun; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-3105ef2a071so23633081fa.1
        for <netdev@vger.kernel.org>; Thu, 26 Jun 2025 22:23:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1751001825; x=1751606625; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SiH7xridhHLVUbjwk1VSxv1+eCF5hmb0du6+goXv3Z8=;
        b=OJbuPpunTKwf9CcIgUHMnwTB0D04/IE5lfzn3aGfwBhG6KOeb8uEKaRNcwS0lxZMAn
         FdshKYPUSRKJbFWHH4Kpo4eOr1q2i2WAa0c+Mx6vmJeJTR/dJqfAOjwnG3nJRXATSq6h
         8jaDQq+dz1XItwHDGxM92u0bgFCu4JKel+xNUmKHTgTXwFA+XA4DfT4ViikgShYL/UAt
         bHEKZStw+ZnLx8pv7Qzoo7f03ogEp1xq4FTeaBD2LJYFRHM10xoo6FHGDz2B9IwYqfDQ
         HewAzVwYvj4HRGWlFRdogUOmfkxKmVNwWSx5u7E0+dbPCRR0qXbXcfNW4KtOIXdwCXBM
         e69w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751001825; x=1751606625;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SiH7xridhHLVUbjwk1VSxv1+eCF5hmb0du6+goXv3Z8=;
        b=h/X3Hl5JqelpRF4OrXbYceGC0tNZY38toqdryk0MVBhE0dp+G2GKFPpkTQzqNxYwwE
         MjTdVZkP17PPSm7+nuuQ4EQmqAsZdbx4dUCUmlRaTpvNDpBpxOqzHfSdr6WjbyM4Mi57
         v7f2ScbuqJuyLRicGsx+7vBGqU+D3tIo7Ep4QIk8KNxIx9amSaBAVlk0HqtlmXe767lR
         lcZ7b5m59RK+r2iFn7e/RvU0FIBMZwPNMRNdTc9MQ/sh7hZZf0SeA1CGmrLkfOrEGvqk
         KOMUpdRygyzxL2jzPf/AJ3spSBkAOKSaj4Xw/JY6BN+QQ6O8P4YPRVWY5owYMdMthjVt
         hMBg==
X-Forwarded-Encrypted: i=1; AJvYcCU1df1BYozl2GukMVbQ8HnUntBVUfCJFbK/LcKCNl9PNn0g4RkKrOPCXBnETjZTQcU/KKX/R6I=@vger.kernel.org
X-Gm-Message-State: AOJu0YzLgpugjGQm8iYvrj6+uFrMgQjTbaBZY0CmiZsY858EI8Q/fmyS
	VO3nIWpkcMHHIaIqVqyl2hFgbBjPZdU34K90yft6OnvyJK1i4EhPC3DoBQ11k1bS0fXpGM0yh89
	rXxtXqDyHvgGWlwCP8AfDmmmWRDTj/WaVvzqJGTw=
X-Gm-Gg: ASbGncvx9ttpeRoK1qf975JaqPkPW3YwrTMW6ObX7kRFIOtYYASWlgoD/266h/hNOhw
	818HHqN+b621M71sf9A26H/zV57dg1BrknVHT84Ka4yrKbn3XWBf7CLHapKtZ+dFZF7Er1qcBqC
	HpqZU2p8ihHi0TQohCgKwm2JaqhBFM+lA2Sz+kjY7cYtr6Qs5WT19hdhusvru0dbBUcjiQKQjv
X-Google-Smtp-Source: AGHT+IE7lh4Q86gUh7l+Je06VBoRyg78BwI5g+/EKXqdZ1rAx6T+4jk0dsMVX/4rkMiqNvzdEzscayOuzGcNrtzMVgA=
X-Received: by 2002:a05:6512:b9f:b0:553:2698:99c0 with SMTP id
 2adb3069b0e04-5550b899c7amr639611e87.36.1751001825184; Thu, 26 Jun 2025
 22:23:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250626124327.667087805@linutronix.de> <20250626131708.482362835@linutronix.de>
In-Reply-To: <20250626131708.482362835@linutronix.de>
From: John Stultz <jstultz@google.com>
Date: Thu, 26 Jun 2025 22:23:33 -0700
X-Gm-Features: Ac12FXzM8-aep28R3IArGsJAukHjUz6095wlNSKyugOJbuE92Ig0D61cQdWf210
Message-ID: <CANDhNCoxEYtcmy9fRXOEgqZAEbanFU5A3aous=vG4aBe36Qh8g@mail.gmail.com>
Subject: Re: [patch 2/3] ptp: Use ktime_get_clock_ts64() for timestamping
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

On Thu, Jun 26, 2025 at 6:27=E2=80=AFAM Thomas Gleixner <tglx@linutronix.de=
> wrote:
>
> The inlined ptp_read_system_[pre|post]ts() switch cases expand to a copio=
us
> amount of text in drivers, e.g. ~500 bytes in e1000e. Adding auxiliary
> clock support to the inlines would increase it further.
>
> Replace the inline switch case with a call to ktime_get_clock_ts64(), whi=
ch
> reduces the code size in drivers and allows to access auxiliary clocks on=
ce
> they are enabled in the IOCTL parameter filter.
>
> No functional change.
>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

Acked-by: John Stultz <jstultz@google.com>

