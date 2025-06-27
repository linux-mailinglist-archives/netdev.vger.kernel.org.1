Return-Path: <netdev+bounces-201742-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B5A95AEADCB
	for <lists+netdev@lfdr.de>; Fri, 27 Jun 2025 06:24:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2E21417FDC6
	for <lists+netdev@lfdr.de>; Fri, 27 Jun 2025 04:24:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48C211C5F10;
	Fri, 27 Jun 2025 04:24:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SJuc/hGO"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 715951BE871
	for <netdev@vger.kernel.org>; Fri, 27 Jun 2025 04:24:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750998242; cv=none; b=BkzEpfLGIk4nlsVGLAZnvxASODVSIIWKuCi0MapsUfXaWxImrz+XQTeSIXeNCgqCycyJzneEhvOpZsK7Zs1Y7bqWW9aDJ2mau8El3ZiUIvNvSkrt6FnTlsjSowzeqOasFqnrc8onPIgXWHXLbAtHjtb05QJ5v78GrRYnqtyJEhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750998242; c=relaxed/simple;
	bh=AQk8u+AukaF097t6/dIKRIcXHl5qFFYU0nRqmvxCwTg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZYMAi3e7FHPhIqrbi3vKGVGHDKYUFS8pJUswDYVWqnx1q/6n3pWxAY9xncDhRQ6sC+u0g3IqySLGF0yxPeDB7U9ov2OuQ5m1zbE0YVRPyiEoQr/5OJqnTyBPDte7VZjYb/Ce8ksmBSBRBUVeHI9/o9S1QDLVhk/Fqz2GUt6Z/xU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SJuc/hGO; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-55502821bd2so1804329e87.2
        for <netdev@vger.kernel.org>; Thu, 26 Jun 2025 21:24:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1750998238; x=1751603038; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AQk8u+AukaF097t6/dIKRIcXHl5qFFYU0nRqmvxCwTg=;
        b=SJuc/hGOJNhUK27NV1GiW2kjlcMttBuZzKSS1HSPU1NUhdKe95SxyaxZz8rx3WU5+S
         DPHZ9gGs6DoSP8L/n/KTE9MATC/ZlTVX0G7ZJ+/eYGxxVjK97KMETr3Yoqe4S7DfkEXF
         uqMVRaiE6dq3lTehf6V7BUuhm7Io2p2hu2sQsyZsB6axyIj9c4qlMYCBVcgRGq20akQX
         3w5wNSb78Hn+vxtPJ7gW9CMVASfYkKd4Q+bKEMOuGR1S0p11izDeTKhb2tVy79VXFJiC
         8C2IMa0p3edS29zGiPziJDVJUfsmgzdB+yK00S0jADn2RDc7X+a0LAv/vRmIcZ5Mc8O7
         TVYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750998238; x=1751603038;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AQk8u+AukaF097t6/dIKRIcXHl5qFFYU0nRqmvxCwTg=;
        b=kp3GeP777MHNkNMeYTu5hROZ/J1mI7NC0fXRvQ/bzvfo8Fzb3ui8rnVv+Kdrbe/frd
         pUpqO25JO8JCxCIEZ62AvVNQUZuMHxps6kPqdq1so0I/CkZEToZfqZ1mGCi3WJzmfPWw
         qWEuwIYFKzRdDFvy+X8C4WTXFjuMpR+sf+uPMhmJx2mrBQBFMWjcDwJXMkf9QgNtanMf
         +bsupgpOVv8A60nWSFkUnRUMaUlwkxPgiPzKkVNNTJMuDeem46er8hJUrXC8EaYQ2onv
         FZqQ/djzc/Rh6rNuGE/UcLkPFFxPYyOtCc+NCNrhxz3O7pyfXTkt7fncZB4Sg2rKBPQz
         SPJg==
X-Forwarded-Encrypted: i=1; AJvYcCV7u/nLMWYMNzGj0eVEitI2OGzVBEnzKBW6FCPx3DezpP30+d23lnMCAAv2dAQdQBPXCcaV5S8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0Zr1+YwQ1kJQf//8sObVq08VFOE5DWfjtNLDqKg73156SfsDC
	7FJibskk+RKLdjjeFNxJQj1F7NIJ9G/57gARoXYB1fvVftbpldFpQwxAhF9kV1RNV+LeG2pPvdA
	l0DaGHBiFTFvGJDMQ9I8tNZTCsFbPFDsES1jR8K0=
X-Gm-Gg: ASbGncssS6yt+Ad/n1wcuSLnB//riqO3LonuD9vaEI1jnv96yyl01M92rGMDOYEjjoU
	sCYNL6M0x9/OAa3lGUovtc0iq4FToq33uNDXb80i6fk/0kRMpn1b3HVtPPFuP1kn/6TQtddWjsR
	nkfC9X976y9ceXGp/O9Y5aYhnA0sN5XvXPw3noBy7RiWpXV4hPho8MLDgtdCFp2jFpJj+XPr6mr
	9Lesg5QWTk=
X-Google-Smtp-Source: AGHT+IFbw9uwqwYDro8uwfyG3XZHTePS4XI+ezN8utGdLDHt/1r8QpA2Og7uGGqfEAZ6R6+ZtyZzkp10+9C3zYEbPNs=
X-Received: by 2002:a05:6512:10cf:b0:553:25b2:fd28 with SMTP id
 2adb3069b0e04-5550b8bdfd5mr636360e87.42.1750998238298; Thu, 26 Jun 2025
 21:23:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250625182951.587377878@linutronix.de> <20250625183757.995688714@linutronix.de>
In-Reply-To: <20250625183757.995688714@linutronix.de>
From: John Stultz <jstultz@google.com>
Date: Thu, 26 Jun 2025 21:23:46 -0700
X-Gm-Features: Ac12FXzuHfHFWe7nf24S9nkWLlVYSMh-w9sEZOHfKbzqb2or0rs6hY-DP5_ZNg0
Message-ID: <CANDhNCpu5+ZVxFg0XVU4KYEWnNCbSruPob9dOeF3btxqJ1N70g@mail.gmail.com>
Subject: Re: [patch V3 04/11] timekeeping: Provide time setter for auxiliary clocks
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
> Add clock_settime(2) support for auxiliary clocks. The function affects t=
he
> AUX offset which is added to the "monotonic" clock readout of these clock=
s.
>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> ---

Minor fretting: I worry a little that the difference here between the
default timekeeper where set adjusts the REALTIME offset from
MONOTONIC, and here where it directly adjusts "mono" might confuse
later readers?
Would something about that be useful to have in a comment?

Either way,
Acked-by: John Stultz <jstultz@google.com>

