Return-Path: <netdev+bounces-138897-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 924199AF55A
	for <lists+netdev@lfdr.de>; Fri, 25 Oct 2024 00:26:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 56BC6280E0E
	for <lists+netdev@lfdr.de>; Thu, 24 Oct 2024 22:26:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEB3521833F;
	Thu, 24 Oct 2024 22:26:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="goB157RK"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D3AA14A4CC
	for <netdev@vger.kernel.org>; Thu, 24 Oct 2024 22:26:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729808783; cv=none; b=reyUJlL75KNjQcykAMk7zuQgR3yOR7arviApPUIiqvBKwMzqqV5m9LG2xXyGmZjzim54mOW9RXaEVq3msoo2MwfNVsktgcc0bcZqKI8KUYXDVeXapX+sUC0f4Hqp9hZc+nXboWiQ4H0tQGZ3rYLR8BgItW0/tk6Ene4KzaejnZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729808783; c=relaxed/simple;
	bh=+6Sq0sW9dDp9Y14JeYUKHMNruxlkLErcGslvI8pI0GQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WKsECtLarsnH+zZVcCr1nICedLvBw+EWAO1i1dznD/4O0HDjuMTcrAifPFMhno+5WGxUCYs7MmKoCk0BveeLTn9w0VLuMWGNESDBBHI9rwHKnHMuMOPWbLO0ESCp1G93c3Un5cuLKrr6wfI9XCembxZTHUnEQDCcYGJWUSkaJUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=goB157RK; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-539fb49c64aso2506740e87.0
        for <netdev@vger.kernel.org>; Thu, 24 Oct 2024 15:26:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729808778; x=1730413578; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+6Sq0sW9dDp9Y14JeYUKHMNruxlkLErcGslvI8pI0GQ=;
        b=goB157RKEoY8yEGwmQ1r//qypF8ACOjn9RErQzO8ghoZfaCCsEQkFod+hDoI8t3tXf
         17f0yDYRxwQLdRzWc/c9uWfsQkk0WzP+rtxSFJ88mkEJJjkiH9bAVpOC7mmi0MJCY1Ta
         9s5DMZRrqqKsToZGjHw4BgR3/RBgX8U/KulG0S09HwTgEFpFXt1Yre/B2ddGDbPsQmcF
         d8U2aa5vjxLVGF3s+SGsN2iIhVNJlqxCDzWe4K+JbTN7OdSMssCEOXaGDsrZGqRttRIw
         fPZprWLF51cFvytnxSTCOkdIdv92h14UHjAtnVIGiMiIY1u9iWPfGJvAkMiG/FOlQfNG
         rmDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729808778; x=1730413578;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+6Sq0sW9dDp9Y14JeYUKHMNruxlkLErcGslvI8pI0GQ=;
        b=fJbbstm5fgrYmkjflWsXq3NLcfTIlXLt+SkBnIB88KsmZ6cQoq2FFV6AVKqA2R9Wb3
         TyNEzGtQhXyYY7+IwOMlyeLEajD1zxcsIrviKWLfenP7rsVzPZLS1nKWSqVFZHsWF+OJ
         j81Wh0dFrNj38V6DCLaR6k5f3D0bnuG4uiOGD5lkOv5RfhF6JPy5/CsbcV9aS7V7PKj7
         1gl1sewlLrvKrkc50UTssfhJLdAEtJpTkdlXa2wvoxARzGE4IxeHTvWovAsggWZw0vYB
         cquf2UtZyTx3JwWFlJ8fX8G7KxmfeUyrZgeMDoi4nXOlkqTPDgO/rVEigQYS/3uQYYxY
         6WmQ==
X-Forwarded-Encrypted: i=1; AJvYcCUnRuhkNOZU1PAKR9mEl/rcQRdUgsUK/oECTJw+n1+P/JCxxjFWmhLfIhsCsVAet8+iKcIVnf8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwD3f8zTNcToJs6ZjAKdiNAfBTRTS0bCZT3vorwftC8xFrTj7HE
	GR71IwpvSHznMyfcpe2QE4XS6hL7yRtdhAFwfNKG7oBkKGnp/B8GuI4CtuWh11KeeSUZqrFl0sl
	V8FjZ9QhKv+de5Rgushs2wZ1JwbOOF8WNCbM=
X-Google-Smtp-Source: AGHT+IE7c0yHhbr6KPxSNH/iRqW9yDlWjdy/gZhL7oVXTVXhlgfoRurP7ZxHs3YdH5vdxx8JGlUcxKypMvzAD0+HCgQ=
X-Received: by 2002:a05:6512:158f:b0:53a:64:6818 with SMTP id
 2adb3069b0e04-53b1a3a3577mr7430184e87.47.1729808778190; Thu, 24 Oct 2024
 15:26:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241009-devel-anna-maria-b4-timers-ptp-timekeeping-v2-0-554456a44a15@linutronix.de>
 <20241009-devel-anna-maria-b4-timers-ptp-timekeeping-v2-23-554456a44a15@linutronix.de>
In-Reply-To: <20241009-devel-anna-maria-b4-timers-ptp-timekeeping-v2-23-554456a44a15@linutronix.de>
From: John Stultz <jstultz@google.com>
Date: Thu, 24 Oct 2024 15:26:06 -0700
Message-ID: <CANDhNCoQO_EWXGoxJfk2k1qp1uq+eftEb1wtcg6yQZ9d+CAcDw@mail.gmail.com>
Subject: Re: [PATCH v2 23/25] timekeeping: Rework do_adjtimex() to use shadow_timekeeper
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
> Updates of the timekeeper can be done by operating on the shadow timekeep=
er
> and afterwards copying the result into the real timekeeper. This has the
> advantage, that the sequence count write protected region is kept as smal=
l
> as possible.
>
> Convert do_adjtimex() to use this scheme and take the opportunity to use =
a
> scoped_guard() for locking.
>
> That requires to have a separate function for updating the leap state so
> that the update is protected by the sequence count. This also brings the
> timekeeper and the shadow timekeeper in sync for this state, which was no=
t
> the case so far. That's not a correctness problem as the state is only us=
ed
> at the read sides which use the real timekeeper, but it's inconsistent
> nevertheless.
>
> Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>

Again, the tk_shadow naming nit, but otherwise:
Acked-by: John Stultz <jstultz@google.com>

