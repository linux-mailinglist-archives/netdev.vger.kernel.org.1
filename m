Return-Path: <netdev+bounces-138893-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D45A39AF529
	for <lists+netdev@lfdr.de>; Fri, 25 Oct 2024 00:16:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 807AE1F22A08
	for <lists+netdev@lfdr.de>; Thu, 24 Oct 2024 22:16:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADDE81FAF13;
	Thu, 24 Oct 2024 22:16:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="puzt1NCF"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99ECB1C4A11
	for <netdev@vger.kernel.org>; Thu, 24 Oct 2024 22:16:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729808178; cv=none; b=dCEOBMvXyC8AaS4+FlB/A2j7kIj2/F86Jfot0wL3Bu7bzbVwsb5jWdvUHokVmYdAodbNYig0iRoxU071BCdvPfQhYBU7sHmrPZizsnMfdJEfVFVXmrJhn96TEMgjy39O0b2RkK8OgNGcYRkLo0SUhPEeiPBxF9UuXLYTCBg07Cs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729808178; c=relaxed/simple;
	bh=Qk4fOV5dJ/Za8lYsM3ENTXwHw6sWnjlFtQNYNPQmcqc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rAGjuCL+pY3XkJO0tXGGcDUyUWNRmYQEubIBn2zBU9iGF2a7IpdeY3OnFXvoYq7eWrnUpYgTU43Xz+8pb+qVKyJhrkEeZLABYpch0e9PHo6V74DzfYNE9o2oTmxteQbu7N4li0WSSH2pYGeURklOgvrG2zU1z71i/k9jJurmRdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=puzt1NCF; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a99f646ff1bso179394666b.2
        for <netdev@vger.kernel.org>; Thu, 24 Oct 2024 15:16:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729808175; x=1730412975; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aanE2TqJaugufsMYdVo7dhs7leISWi845GKqhPBK8o4=;
        b=puzt1NCFdN7y6SZGduZox93/Xvq2QxcHh0ggLOABbhjtcUF4pRvGuJmFAEpdUEU1WN
         OL7S0xIkk7PxF1r6vKovRJw5zG/bREN84MIX/2ZNkOkqalkOdpRtPMNskBIQJDdibTVl
         qQR5Q9xGTks4cJ9marVVR5Jn9UZ5+vUNosNOREjEfCAhitizyiBrjwHShRZncZZOOapq
         G4saqfpJDAAFwXOaqtjRfuQv7gn3hAoam89vWGgYUPYLg+SAny48LvPZU+HibprU/5o8
         3cZx3eFiTdWZt85Tl7MrLshh2r5XRkuJKKxUgbrEUHOJemGhanq4nckpmfKcEkDYXrV4
         Zq6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729808175; x=1730412975;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aanE2TqJaugufsMYdVo7dhs7leISWi845GKqhPBK8o4=;
        b=CyUwmj5mIvhhpQ3lWHNXiummx8C9sU+vSZx1D57NIy8AIkrZufkXYLQNSm3Fx7ZBEE
         MxTJuMimps+MuusI6lv1WBzI9pGCiTeF8WpvezC72jO6QLJ5reFoTkT56AkU3eKtBqqK
         QLr99aFo6zJHB/g9srsnJgpPliwO+WFjlV8f33CXlTrNQnqCJKYQgdOHpF3O2IFZjpSS
         oBi7TDJos/c7O+4zOPhlW5WK7H4YVJKuOvPtBjUzMisBxEynrVBuiMo9uK28UzBup1gd
         vetSlQO5a3u+VmN/avqV/5Miqxc0u8M3mBwf22EThG1bX6pkF78RwWC6b11Ghmvyonkx
         oVLw==
X-Forwarded-Encrypted: i=1; AJvYcCUbOS4UnBi4j+Z2TNS3fgWRNTWLZNfb3b3+3R9WynCJ5Xk0xnVJ+2XIzjtZE9bY8EkecKferC8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5L+y7hMzNik45RQlMGvthoXoMpov1u1LhJRcV+th52fUBwlTm
	69Q1zSQLuUA1L9DSCLvByHli1nLCCazDsqZ4t5EeeIBtqiKzFHcScMwy0FAel6H4Z1JAAxmpjLN
	oY6IdRzEDe2MamdgTNxN5aNExwYSiZtZwAZaQIJiQvSFDv+rG
X-Google-Smtp-Source: AGHT+IFjmT7UzKwsmIW/o87yHLGAckkmwRkVp9fVXpelmncgZ3R8xd5zXFCtnl0sLsanS1V8WCa92Alm0aKj07++Pu4=
X-Received: by 2002:a17:906:dc91:b0:a9a:3cc6:f14c with SMTP id
 a640c23a62f3a-a9abf92d244mr732909566b.48.1729808173437; Thu, 24 Oct 2024
 15:16:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241009-devel-anna-maria-b4-timers-ptp-timekeeping-v2-0-554456a44a15@linutronix.de>
 <20241009-devel-anna-maria-b4-timers-ptp-timekeeping-v2-19-554456a44a15@linutronix.de>
In-Reply-To: <20241009-devel-anna-maria-b4-timers-ptp-timekeeping-v2-19-554456a44a15@linutronix.de>
From: John Stultz <jstultz@google.com>
Date: Thu, 24 Oct 2024 15:16:02 -0700
Message-ID: <CANDhNCpy_A2VtFoXFp2EzVQA92fTQgksxE8Y=nF0FVLeeaTJ9Q@mail.gmail.com>
Subject: Re: [PATCH v2 19/25] timekeeping: Rework timekeeping_init() to use shadow_timekeeper
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
> For timekeeping_init() the sequence count write held time is not relevant
> and it could keep working on the real timekeeper, but there is no reason =
to
> make it different from other timekeeper updates.
>
> Convert it to operate on the shadow timekeeper.
>
> Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
> ---
>  kernel/time/timekeeping.c | 8 +++-----
>  1 file changed, 3 insertions(+), 5 deletions(-)
>
> diff --git a/kernel/time/timekeeping.c b/kernel/time/timekeeping.c
> index 6d21e9bf5c35..bb225534fee1 100644
> --- a/kernel/time/timekeeping.c
> +++ b/kernel/time/timekeeping.c
> @@ -1778,7 +1778,7 @@ static bool persistent_clock_exists;
>  void __init timekeeping_init(void)
>  {
>         struct timespec64 wall_time, boot_offset, wall_to_mono;
> -       struct timekeeper *tk =3D &tk_core.timekeeper;
> +       struct timekeeper *tk =3D &tk_core.shadow_timekeeper;

Same nit as earlier, otherwise
Acked-by: John Stultz <jstultz@google.com>

