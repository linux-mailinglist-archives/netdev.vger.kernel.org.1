Return-Path: <netdev+bounces-133839-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 40CF09972E2
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 19:19:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C0098B23663
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 17:19:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 427B61E0B9A;
	Wed,  9 Oct 2024 17:19:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NGXJ1c1D"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE07E1E04A8
	for <netdev@vger.kernel.org>; Wed,  9 Oct 2024 17:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728494346; cv=none; b=q/kSx1koJD0T6kV3FuznQuCSUK07ujgrlB8wMwnh8aI2A7JrQJAWE9yH1Nu0oluYoNP8hj60iCf/TW+VV9hXhyt95fhyKrJfFyYJtZqDYdpS5l7m9nRWRFEJPYHMhsRGCZOPfco/fcNg19k/rCByeqkYBZuzIuHR7JKgtBw3Pdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728494346; c=relaxed/simple;
	bh=SLHIL7hjWfhj5fPlbzrw/10O4q1bydyIeItZrQezCG0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GS/dvEPIgxEHNRsEcBintBhGXFUR4u+9pSeE43a4Ks1+lvn5HYkpXhuVDh/MDhEUzG2zZK5eUfxgqWVp3tGBvWLq0fCvJJ8dCa3JInDNyWnDlW639BulbEOiJMsP7RZOYvJ/Lmua5vA30Umt+yNoxFcuKhmSaZhLeToznP5QBnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NGXJ1c1D; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a99415adecaso207102666b.0
        for <netdev@vger.kernel.org>; Wed, 09 Oct 2024 10:19:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728494343; x=1729099143; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SLHIL7hjWfhj5fPlbzrw/10O4q1bydyIeItZrQezCG0=;
        b=NGXJ1c1DJ4F4dqkfPKHLuV942HYJpLmn45GDPzJShIZgH+ovUwikhzfYDlQml9ahjB
         6WJFRWwt2FuYAULAsbMj3DvNbDPnErxGUmRTDxYNeXvrDtDHDIoO9Gb27/2GDibmxX1w
         IZpknwtBkNs7VlpDk2rwLdA3IdLPWdrT1S0j/AT93opw4WJ0ZfokN+g8e+KqYv67fDQ6
         Hv5MhNa3XLrC1qSxva8OXGFst/LWTaKrnP24J/webnRyr2IEoFEJrfTTFViaQOuw7Mpg
         l+nit1VZEVQPBG7vzuO/W5TSJRF3/lcl4lgoDQ5VxTtfFwAgbU8fkkaKeNeLJjyNs33a
         Y64g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728494343; x=1729099143;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SLHIL7hjWfhj5fPlbzrw/10O4q1bydyIeItZrQezCG0=;
        b=mvKphMIvrxY/MagtrgIm2qkrgxnGoOwyAo3j5+1p8P5TZNkdzp4Y9sJXPf2SPMZr2I
         U+qVnLpRSMJiwf0d5cjA+9//BGvlvn0tk4aj4S0QycaF7ASNEcNTPR0OfadzNxVjY8j/
         GsRQyN1X1XosGX2rvP9caIrHLSYbVwpWMsKnlRwt6GDWASKx+he04iu5b3IvTT0MGtpt
         9r6Ugk+VpADxNOmu61x5rXELbWc0tIbDk2ifhFfHHe3TBQSmtTTCX/mRHcgbo+klsJeq
         CRIDwRpq8pLis4qhDCOURnyqs3J1+nmUrr8WFd9HoXBhRU50Krtz21r1D38pcrPDhv8v
         aJnQ==
X-Forwarded-Encrypted: i=1; AJvYcCXqo9NY75HM5YxcaQ8W+EQjceWam4ZApn1tVokQku1s+KO3ndV9VseT3XkyRXAT+QOWhPzsQVk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6j5RkGcTXzoXAzeMcSbhUuzOG74dtH6nznkpC1gB6xEx3fDoM
	D8wFQo9R6//Gp5/l8e+1rCnD4PZeFIsyekDPxrIUz73O+3mODRU0a1mRBM/m8nhbmHVwiTq4jMy
	5b5uKqUxdaScsfFggnVt3CwIIauW4qNaSeZY=
X-Google-Smtp-Source: AGHT+IEE6ixpFHueAQsBsLpEhlL8EhwtQ6xXfYZh0WKjnweVwc5q1Tj1plcGvIrhXHKPY+fugNyLoLw7p/l4Wj9CR1A=
X-Received: by 2002:a17:907:e86:b0:a99:6109:893c with SMTP id
 a640c23a62f3a-a99a1119635mr37613166b.27.1728494342862; Wed, 09 Oct 2024
 10:19:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241009-devel-anna-maria-b4-timers-ptp-timekeeping-v2-0-554456a44a15@linutronix.de>
 <20241009-devel-anna-maria-b4-timers-ptp-timekeeping-v2-1-554456a44a15@linutronix.de>
In-Reply-To: <20241009-devel-anna-maria-b4-timers-ptp-timekeeping-v2-1-554456a44a15@linutronix.de>
From: John Stultz <jstultz@google.com>
Date: Wed, 9 Oct 2024 10:18:50 -0700
Message-ID: <CANDhNCqdUgazFwkqa+Kyzw3+pXfcfEd+R_t6C0BfmuubQyjvoA@mail.gmail.com>
Subject: Re: [PATCH v2 01/25] timekeeping: Read NTP tick length only once
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
> No point in reading it a second time when the comparison fails.
>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>

Acked-by: John Stultz <jstultz@google.com>

