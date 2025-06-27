Return-Path: <netdev+bounces-201741-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 08A22AEADC2
	for <lists+netdev@lfdr.de>; Fri, 27 Jun 2025 06:20:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 65BB54E0B26
	for <lists+netdev@lfdr.de>; Fri, 27 Jun 2025 04:20:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EE291B4244;
	Fri, 27 Jun 2025 04:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="egiaaqk2"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71C4454652
	for <netdev@vger.kernel.org>; Fri, 27 Jun 2025 04:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750998007; cv=none; b=c7f6TNbtuxfWeBCY6ILFeJb9a3+eOIVAxHMkfwS/yZCfjPHx64Hw9B6JoVonvAF3gqtiGnpGmAOnf2digx57eUVX0jTKUWLzVXQfVIrMgx7NPoKQGOMN+1RW/9o+GvX5pMY0p67+BRWEp0Nc5PTJV6a4X1pRLQlRJfMnT0n5Izc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750998007; c=relaxed/simple;
	bh=Bywu6j0HbIsPAlpNWsToIMMEgl3Z/F3vQHuhinAq66A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JsvXKtGbZog5IYcZbUPl1l59pv68VjkoE+iK1+h9l3eytcn5Fb/CaJP7AbxWXb9HXToBiRT26+BiE4dhstx063y75T+JAgw/NjWnVLgWDaMYkcBclEDdmqTOmwbMDdHCgSaHueFqx250K4eenepk083Ekb4EZ6ADts4TSUgJbmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=egiaaqk2; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-5533303070cso1747568e87.2
        for <netdev@vger.kernel.org>; Thu, 26 Jun 2025 21:20:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1750998004; x=1751602804; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Bywu6j0HbIsPAlpNWsToIMMEgl3Z/F3vQHuhinAq66A=;
        b=egiaaqk2bbXNXUCRxobDGH7YBgWjf3HYdGfhbf3mTgHP4W8blFAUqxn1pbEss6rVyG
         y8fW4rqWmulxmAnuv63zUWB5MWPuZChbW/gpypjgBmNHLhVGxqrScfjVFKV2ei/JPeyz
         HdghjJ20tG2ik69FvZSNlZv8JMK1NwUDzb6BWEhJXUzHjfTEfTG+39OyZaw+h9XvtrBD
         bHrf+7Qi9HtLoJ7aqaknhQwS12Su2ZFC03YU2USr8TlBl5AEzbNF4Y/ho4Mgp2d1jWry
         4CDN+p63cK6NEiyEdTsHcAgIHIuLUYUKG/lJfgJQI26zwLMOVEGuRa0VrdTaj024+wn+
         x5pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750998004; x=1751602804;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Bywu6j0HbIsPAlpNWsToIMMEgl3Z/F3vQHuhinAq66A=;
        b=bKW39I3vYseEY7oE29fOgetZOFiM2bx4jkeAowzu576KPMbxAD/ZMQkvAANyatdWKr
         f8ChWUjwbn6waQdb5zQMDlcpkRUPDTgLX0ndRRcMbGJCdXSZ9tJmRQ2YOFWk0b69viPe
         UuobdgmaF8IEJmESL7wWoRigsixN5uwmND8l7l2bbAXY+v/XU+ZpEvtLq97UAx3JsM32
         V20utpCtcVpHu8ctsQXVmkqJm0nJPLKQx2qN0NUgmP0g2/tkZw3gHtSCKiohdgZdqjVS
         GDshwHImCBFrdjM/SOMMo+hpwyfqb0c/qDF3m3f4KKCsMzt/d26dD4IYnQRlyUMU37Jh
         SaUg==
X-Forwarded-Encrypted: i=1; AJvYcCVw2WrU9j/E2Y3qTkjzxwzXsKWUK+ZFYzI1KeW8NKKFFdXLkn1fJJzSDYhh21NXs3T2V1iK24Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YwLTQ7MItjAGidF3KCvmIY2ukpdwGXA7QuzDkVHn95Pyc6zUq2z
	vaXtqYUpiCx955lt34r8TJYu4o4/c0V4Mdk/UbAcOFwWHQzC/PkiRLGyFO0PoIgLqvtvm+aOhBF
	haDZSOCR0WhTHCeES5Wk8nNKB6OzXC6bdVrXHYBUbmuio/midreiPqVM=
X-Gm-Gg: ASbGncuFjQialA5+mX9rQmV1jAg0Q/uxattUjUejUD0UK3AxCBtXhPUW4mmuQm4yFYd
	XH3fvHJJrzgH9VYvqm4tO4m+4vbxvU54B9GNwAhGVasuHOia6uXTWEo2AcqNVL1s4CEAbd/ZLnL
	iBHMvr/LAWPfCOKxZKwpiTzVuJK+TpK+pnk9biYn/Y7bk+hWoC74YQssgiGF9+mn9lzBOixKa2
X-Google-Smtp-Source: AGHT+IHXuUArN8UoT4j0aLTtB89A28VGlk88zknNyBmOEGdbA2ip40r7uiTk/NJBHZ+YgwQfm26ze2jJmJ5NPxirzYw=
X-Received: by 2002:a05:6512:3b98:b0:553:a60d:68a3 with SMTP id
 2adb3069b0e04-5550b7ec87emr559513e87.2.1750998004390; Thu, 26 Jun 2025
 21:20:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250625182951.587377878@linutronix.de> <20250625183757.932220594@linutronix.de>
In-Reply-To: <20250625183757.932220594@linutronix.de>
From: John Stultz <jstultz@google.com>
Date: Thu, 26 Jun 2025 21:19:52 -0700
X-Gm-Features: Ac12FXyvw4qamfbPiZds3S1Q4Vx8Ew8kUJOZuEjXstXaqbjlX5KatdShOECarMU
Message-ID: <CANDhNCqJPfkJ_wzi+eOuJv3XzqEOKxozY149ohSqUWe+F+_rJw@mail.gmail.com>
Subject: Re: [patch V3 03/11] timekeeping: Add minimal posix-timers support
 for auxiliary clocks
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
> Provide clock_getres(2) and clock_gettime(2) for auxiliary clocks.
>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> ---

Acked-by: John Stultz <jstultz@google.com>

