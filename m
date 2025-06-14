Return-Path: <netdev+bounces-197707-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BC68DAD99B7
	for <lists+netdev@lfdr.de>; Sat, 14 Jun 2025 04:44:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 19E71189F106
	for <lists+netdev@lfdr.de>; Sat, 14 Jun 2025 02:44:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC9D913B5B3;
	Sat, 14 Jun 2025 02:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="E2XxgT1H"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06F59AD2D
	for <netdev@vger.kernel.org>; Sat, 14 Jun 2025 02:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749869057; cv=none; b=Wnkmw529i2XYCNsaT00LoIBlmSsPfQfknGSk/uMGNcPYtpgQIZ+WAtMZE6F9KNVjxfP89+jAzWLEPQS7R6sBT5CTVZc1KK9464KibOgPN0IW+PHV7qFasW+cGxwoyrF0aAWSjoNOWdd5I3PI2MFWuvJfICVKp5ejQGvj5P2wHuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749869057; c=relaxed/simple;
	bh=O4Gjahtz+bxdj0DKMQ4kZN+PrAiDLTI94bb1mdd/Cbo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tgT4LsuEbKrIhLzTUOZU4YtTMjq/yJ7E1gsM9WVEe7+UGlSGkTkE/2HnVMdzytUvApN2/Q/H+DqK46XAV8USU5VM9UlqDWQHJ2Ql0fp83qt0vH6Xfz/+6wZEADbvuzCaniSiyhWcYwEPGYb4oZoHqd4CyF8fxq0cu4MTO+TFbUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=E2XxgT1H; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-553a4f3ae42so2321383e87.3
        for <netdev@vger.kernel.org>; Fri, 13 Jun 2025 19:44:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1749869054; x=1750473854; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X+VVpcsl+muuyX4iIii+C7p1j2iHR4sQbFNMEzoTLU4=;
        b=E2XxgT1HxT7FSUpEn8ysa1zHdHbZi5M9fNCN3RbK7/WGW1e0+PC7/pGxJnls4o0UV1
         sccHriYtwK4E6JvHhXqnZCt926LobA350QLKmu1gqM0PswAKyMQzO4Z33s8LP4/LhjPr
         xEE1ruOc9Hh8Ef6QOVwTl60vzP3ss0ZFd15jb6JBJwUW1E8pCN/aaobHIWUHao9nKP1M
         DLhbqKY+fMrB9WNdImUSszEcCDVsq8pkGWfp6OhvIIKJYlz7jJgV3FCbKtltH4T1cjUk
         9HgfLs9B9Fp5Q05QE1jeqHrR8e9u1sgZDOQua6xn5yPId/wUDcgyMrCZc3BhX4AlM8AP
         yDZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749869054; x=1750473854;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X+VVpcsl+muuyX4iIii+C7p1j2iHR4sQbFNMEzoTLU4=;
        b=TGiLstDWFEM2Cob38dx2nJ+faSBQZ3Fey0lja+GsWOHwc291471RnZgvTlGbkWrqGz
         xGh/t0gIbAxdsOppcEMq3V2r6YFx6T5qi+CPcNcxeQKxhwGZO3da1YL7WnMfgZ3ugUSB
         PazNKSs6VssB9P5x1fzO1yLR40b5A+dzUCRonvMlosU3gXM6n53E+KfGDH18lCFkK0VV
         nddgZAf/lq1xns8q2z3tICHtbf+8xAza+uAMmb2Z2Ly/UJ/FSPdYsgcwroRMEk9kNA74
         eS+b4mUh8solhpZaxLtTzoO3aEYC+WBABPam6LvaS67yBw6aege1vHgs5ruBqq9UocgR
         CDtA==
X-Forwarded-Encrypted: i=1; AJvYcCW3T/ccz3R5qSG5NICVI1ApG6mVmmG7dA0NXOJfk8Icoi7/6XeiE3wxwMNBb6FoTI+gGW3DR/M=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywg546Ppp0tMYg9Rrpv/HYm0ysX1cvnp2LPaWlbjEDPGwY/EJtW
	hEbD9L7/3veHDiUP7rHqKus9ksI4KKcD8/yFYbIrBEeUpGE2xJUzz4i9g4Y3yB7YtVWxH+I57Ir
	paOW/lKEWlojV/jCjVq8SBxsJ6nXNJic69ZL7+Os=
X-Gm-Gg: ASbGnctUG/tyJ5SJVnivtR/gQHmYvwGlFsBniQraZrpMx+7WnfnL064J2UOozI3/gnE
	/tSZ+oOpf08tB2QsiDc838p0evj7jyADj8JDssLrWEOomWZb8GADfN8bR7QqVuxsVYbTTdw5K5q
	MOdAT8xpOfFrc2zkl3pVRaeabFYSH6fEMWk1gy+tI9J1FzxH8a+Lioc8u85njlQXBr8laAcj0=
X-Google-Smtp-Source: AGHT+IGbFFoZybtkp0Y/GQQp8/WX/yBotzfDB3op3RjVDqzFnitxh+FqmA8M91LPnefNN4doUzykzHdc6tkb9Ck/vSY=
X-Received: by 2002:a05:6512:1110:b0:54b:117b:b54b with SMTP id
 2adb3069b0e04-553b6f48f9amr321300e87.54.1749869054018; Fri, 13 Jun 2025
 19:44:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250519082042.742926976@linutronix.de> <20250519083026.533486349@linutronix.de>
In-Reply-To: <20250519083026.533486349@linutronix.de>
From: John Stultz <jstultz@google.com>
Date: Fri, 13 Jun 2025 19:44:02 -0700
X-Gm-Features: AX0GCFvPx10G5uykSJcgREAWzXpCFlb93ccf244qqpPfz4iEKngJswaZ55LDR8k
Message-ID: <CANDhNCrMBaHhyrr3=kq=nyAp2iGhkJgKMqwO8+KeeYaZdbSa3A@mail.gmail.com>
Subject: Re: [patch V2 15/26] timekeeping: Add AUX offset to struct timekeeper
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

On Mon, May 19, 2025 at 1:33=E2=80=AFAM Thomas Gleixner <tglx@linutronix.de=
> wrote:
>
> This offset will be used in the time getters of auxiliary clocks. It is
> added to the "monotonic" clock readout.
>
> As auxiliary clocks do not utilize the offset fields of the core time
> keeper, this is just an alias for offs_tai, so that the cache line layout
> stays the same.
>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> ---
>  include/linux/timekeeper_internal.h |    6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> ---
> --- a/include/linux/timekeeper_internal.h
> +++ b/include/linux/timekeeper_internal.h
> @@ -67,6 +67,7 @@ struct tk_read_base {
>   * @offs_real:                 Offset clock monotonic -> clock realtime
>   * @offs_boot:                 Offset clock monotonic -> clock boottime
>   * @offs_tai:                  Offset clock monotonic -> clock tai
> + * @offs_aux:                  Offset clock monotonic -> clock AUX
>   * @coarse_nsec:               The nanoseconds part for coarse time gett=
ers
>   * @id:                                The timekeeper ID
>   * @tkr_raw:                   The readout base structure for CLOCK_MONO=
TONIC_RAW
> @@ -139,7 +140,10 @@ struct timekeeper {
>         struct timespec64       wall_to_monotonic;
>         ktime_t                 offs_real;
>         ktime_t                 offs_boot;
> -       ktime_t                 offs_tai;
> +       union {
> +               ktime_t         offs_tai;
> +               ktime_t         offs_aux;
> +       };

Probably could use a clarifying comment similar to what you have in
the commit message "auxiliary clocks do not utilize the offset fields
of the core time keeper"

Otherwise,
 Acked-by: John Stultz <jstultz@google.com>

thanks
-john

