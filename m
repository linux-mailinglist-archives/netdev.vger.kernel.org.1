Return-Path: <netdev+bounces-127543-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 99975975B65
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 22:12:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4FEB31F22CE4
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 20:12:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01B1A1BB688;
	Wed, 11 Sep 2024 20:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lzTdpMTX"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AE8C1BAEF9
	for <netdev@vger.kernel.org>; Wed, 11 Sep 2024 20:12:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726085541; cv=none; b=oBs5c9+Deg2HeonU36OyhVmOlb43G6RA1rRXhATErI2NR9TiwSIZOiXlluBwsHTJI8xoLrgeGWqGYJ6U3dwi1bca4FY0EWs2/ldQBhedAhFAVXfAQhcudYrR3J/dRK7WMxgxWEfeELD24Q4juSEWYfrNAOK5ptEWV2tAHEHGWWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726085541; c=relaxed/simple;
	bh=uTVy0H/9nrR2sptTBciRNjASgqccjEA9yYDlS8MCbeM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=L3FQerjqZB5DMMQfPjYBZM5Y5dh/XJR6PIatJCV1tLSBNQef9DfDCFTYgz4co5Sm1z8+zWV9i5+cvOBhHjJBw5nYfITw0aYNjrH3dFMcvAJOZ6VKvJ22KLXQp1mBQAOjNCRTalQVnhjnt8VUn1dUoqV3gadKGFXxm7pF24qwh2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lzTdpMTX; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-5365cc68efaso206623e87.1
        for <netdev@vger.kernel.org>; Wed, 11 Sep 2024 13:12:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1726085538; x=1726690338; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uTVy0H/9nrR2sptTBciRNjASgqccjEA9yYDlS8MCbeM=;
        b=lzTdpMTX/0vx16Yjt76H0MxuZUNuw6J+UCzWDUJvM3cysCe7O1/EB5/SM1H5gysthR
         l9/lNkDNmfYr1A6O+GHSD5m/u8CoJ1akW7U7KfeIvC87lLtBY4jiIm9KDWEsvL6LHJYC
         patFd2XwSzSw+gLnROy2hXWjW71axmBKrnbe41tLdKoUFfDQg4JMbetAApwAN+pk/NQg
         nfPO4mLiP8QduYH8w6XUhBtsR4O+Q/aVoBFx8WPS2brF7Xdz0pA/9ROzNeS4fW+jsYko
         D7CaPJCrWM5fYhL5b6k97PpCYGe0yhUoHymk7p1QFcG86gecbbShOX6Q1SMrHRbW9FgR
         Jf4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726085538; x=1726690338;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uTVy0H/9nrR2sptTBciRNjASgqccjEA9yYDlS8MCbeM=;
        b=wA7guXk3Xrb42FSGaEOCp19DdT8ZZV6CYe6yK4joXGbajGOcPALatRjbm0S9B8Xclh
         pR255ax/cwlW5MnIszFgvrvo0OgCLWwBSiNWKjNt1wuivHNrB/tpaCeBzYKR+Y3LAeD1
         bIT7HHWsO/z2HZVIyYUn9UpHPyjCwpac3rKTIiFOFSxj8CWQk+FOkvqEin11ZfS9JBxT
         1MpT/abK1105VJzdNShZlZSGbJ90hBuHQ+wGwDIe0zh+gKyYpdCAUJKTsqsEmvV9lJff
         2M8hO1xXKLBeCoekjVJYOt1nGNvCx9nPzFcOOcCHX+AGtw0L/x1EbN0ivvIDHXpoiMHS
         Zmvg==
X-Forwarded-Encrypted: i=1; AJvYcCV0G/wGizAnmMnvqaUM6+nmS5WM0kmLp0LBu6BTrKmnCE1+qOgwXBzP1KacVaQzH4TAF5QK0Kg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzCnHHIAxOUVtfCKqkMMcYuUSy/Ghd0hKQolMtP5eq3Y8NqQzdy
	x8kmkjK+Ml9HjMN7f60tpfOsRA1K8NjoZ+MXptkLYCfxfOO5VdckXZe6080q6HJ+1Sx2DwcgIfs
	227eWhSppyjquWKiRhIAqaMP/jqr/yiR4rtc=
X-Google-Smtp-Source: AGHT+IEdnmRQdJnZf50tlj7/hoA7Gw8t8SJc1icGuYV7aI91C5kPb50//JTyOTMS9OtmqW8cf4sljGOvSoiSNkTugvQ=
X-Received: by 2002:a05:6512:4020:b0:533:40dc:8248 with SMTP id
 2adb3069b0e04-53678fab5c1mr315676e87.11.1726085537318; Wed, 11 Sep 2024
 13:12:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240911-devel-anna-maria-b4-timers-ptp-ntp-v1-0-2d52f4e13476@linutronix.de>
 <20240911-devel-anna-maria-b4-timers-ptp-ntp-v1-5-2d52f4e13476@linutronix.de>
In-Reply-To: <20240911-devel-anna-maria-b4-timers-ptp-ntp-v1-5-2d52f4e13476@linutronix.de>
From: John Stultz <jstultz@google.com>
Date: Wed, 11 Sep 2024 13:12:05 -0700
Message-ID: <CANDhNCpnBMZkp9TUca8OEYKS=ECE516Y9DMy28SrcAstYB0iqg@mail.gmail.com>
Subject: Re: [PATCH 05/21] ntp: Convert functions with only two states to bool
To: Anna-Maria Behnsen <anna-maria@linutronix.de>
Cc: Frederic Weisbecker <frederic@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	Miroslav Lichvar <mlichvar@redhat.com>, Richard Cochran <richardcochran@gmail.com>, 
	Christopher S Hall <christopher.s.hall@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 11, 2024 at 6:18=E2=80=AFAM Anna-Maria Behnsen
<anna-maria@linutronix.de> wrote:
>
> From: Thomas Gleixner <tglx@linutronix.de>
>
> is_error_status() and ntp_synced() return whether a state is set or
> not. Both functions use unsigned int for it even if it would be a perfect
> job for a bool.
>
> Use bool instead of unsigned int. And while at it, move ntp_synced()
> function to the place where it is used.
>
> No functional change.
>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>

Acked-by: John Stultz <jstultz@google.com>

thanks
-john

