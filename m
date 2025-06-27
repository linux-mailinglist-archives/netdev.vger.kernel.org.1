Return-Path: <netdev+bounces-201749-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E9141AEAE48
	for <lists+netdev@lfdr.de>; Fri, 27 Jun 2025 07:02:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D6D5D1BC665B
	for <lists+netdev@lfdr.de>; Fri, 27 Jun 2025 05:02:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D8C21D63FC;
	Fri, 27 Jun 2025 05:02:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ycItnuI8"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18C5C13AA2F
	for <netdev@vger.kernel.org>; Fri, 27 Jun 2025 05:01:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751000520; cv=none; b=F5dWSzS2if71XznJcpIhO5D+1SWFDz4d/LwSLBTOoyEu0HP55JbTlJq+ClEU5SMNf12vUB09yXi2JV8FoySbLErILK+RSpAjsrNwM7ospVp4a023aQKwJURMAV44WOXnnbsiEaAn/TbZrPW9mgPwmsLyJypj5dbPgxZD6YPiZ7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751000520; c=relaxed/simple;
	bh=Z3FbewX8QlK07rvYN/BaaHNV4fDQCo+Jqv86OpCEw0A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cwL+Bkmpw7HL/NsX8jkz3sy7+bTyjqBShcSjDlMEfQG2kWYwOWVmub5x1xlcszdlQy7exIvxoBHYJjKrD2x6mBul9NdtZPDgHwnTtB0v/+XcUeCPgDfERGK3/6jDhai2AkoDS66nDQY2tmseyBdDg7B43B/L41sa7veezHBxB6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ycItnuI8; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-553bcf41440so1809607e87.3
        for <netdev@vger.kernel.org>; Thu, 26 Jun 2025 22:01:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1751000517; x=1751605317; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UKjKjCy0SRZNvK1D86lVvJiAl2KlWhOCZZnxJO+0yho=;
        b=ycItnuI8URYG91Se8BXra7inKvQwORHBopONHzSvQhjQvShydgUXO7yz9HNR49ktNy
         p5PR/c+rqxVPNtrt2kYLyqXyhAfvvFUUKvPJRULSR14P1oAzE4NJUTRBsnJAZCFrVO7s
         moRbCvV6U04rTTyDGSJ8H2RoctY3Bkrs40FLs3r3KTS0afnav4YQMRpvW/yDJd8/5+Mu
         9G8WRYXy4oAqVq9QWCcefxSUYB2+PQu2/AqnL6+804ovy/b1TNQ58MjPa0GRBdIucYjy
         QBHOgTU5KAtTTHNDYain7WRACfZ5lo6/Rxd2IBKzva/l2EEkL+yf9CTIh94rs50SsQyb
         tIKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751000517; x=1751605317;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UKjKjCy0SRZNvK1D86lVvJiAl2KlWhOCZZnxJO+0yho=;
        b=tvvwAzwtl1Q2wRjGyORO5yn0grylWoFCbFlsxu2xzhiNJyaYSfXYr7wlEVg9RIXhRj
         gKnOqVe+ySy7QNzW0USJHi/zg7jAkUqwdberuYzf/x8jVVKlOtvbsPBBnheyiDdVoEqk
         7SnVZtXRY6fYvnbNyO1QmsIRxOmAhYW1kIVSoSMcMJD+c4hi5JaGeFQz3oBdJm1CyMgW
         Eg0FrYEWZgbGA13EiuPIk8Usjz3MEV5dTknUGar/f94I+Zwk0jResdgAf97afegg7vA3
         kEmF4PZLk/s95X2A8oVVPKCXZj6xyni8vFgJd6aJUTne0S+ejYkMUVPS+AsPX7QVU1NS
         G49g==
X-Forwarded-Encrypted: i=1; AJvYcCW92ugylVNYh5yyIfvpBJrJq4SPHfPsJca9tQhDOsxfIo1YLN1MpADKP28BaOSSyRzTh+6y9w8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxnxr3jJ3moD9HsrmxM5h2Fep7w3Kvkbar9c56aTRSul7X8jAwm
	hBsdjCtYYBZgEWqthnHKbDn2mS1OcolQ9ICmltzlEk1sbnli0f3z58YU2ZQwMYMfNwHY4yP1kD/
	v02WABqhxhtJ5ECakuhWCVDRkjGHJIrJ6NwIvlBg=
X-Gm-Gg: ASbGnctJEqFcfaW38xAnqBW5xrFuK65mA2fuUa3bsp1h1faKkVX5psJ3m+owcJCPpFb
	OlIC3lxA+Hg0stWPWHv2w6lM8+sfoBMgTxtZTOa8wXTUMcANCsqtXyBbyHSQKiX/oI1/r6gkit5
	NxCd+2/f706LxeQKxB8lV6tA/ix3ET7ErkKqzl07NdB3bt/ahPEmTCtHUEjwy6PU/k4yPXQNee
X-Google-Smtp-Source: AGHT+IEHs6nVqj1swP5DaPQYt5yJHxac9/Yjg4QyXlE/hTdB/XiNJ3W195Tx8y86sMh3C+YAwIxMBcQtnjr556e4AJE=
X-Received: by 2002:a05:6512:220d:b0:553:65bc:4232 with SMTP id
 2adb3069b0e04-5550b9edf7fmr701066e87.31.1751000516969; Thu, 26 Jun 2025
 22:01:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250625182951.587377878@linutronix.de> <20250625183758.317946543@linutronix.de>
In-Reply-To: <20250625183758.317946543@linutronix.de>
From: John Stultz <jstultz@google.com>
Date: Thu, 26 Jun 2025 22:01:45 -0700
X-Gm-Features: Ac12FXzsDWO6JYo14Vvw0pilvx6WlxJJ95tYAxaKnJ44M0hc4eUPKeoJOV22TSU
Message-ID: <CANDhNCoNCdJoC6X1yz+EHC5dp4+nJ11vnDj_s2Vp5=oHfxXnhw@mail.gmail.com>
Subject: Re: [patch V3 09/11] timekeeping: Provide adjtimex() for auxiliary clocks
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
> The behaviour is close to clock_adtime(CLOCK_REALTIME) with the
> following differences:
>
>   1) ADJ_SETOFFSET adjusts the auxiliary clock offset
>
>   2) ADJ_TAI is not supported
>
>   3) Leap seconds are not supported
>
>   4) PPS is not supported
>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

Acked-by: John Stultz <jstultz@google.com>

