Return-Path: <netdev+bounces-138879-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 00A9C9AF49B
	for <lists+netdev@lfdr.de>; Thu, 24 Oct 2024 23:19:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8C6FD282851
	for <lists+netdev@lfdr.de>; Thu, 24 Oct 2024 21:19:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E6242178E0;
	Thu, 24 Oct 2024 21:19:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bJR3ffAb"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C8801ACDED
	for <netdev@vger.kernel.org>; Thu, 24 Oct 2024 21:19:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729804774; cv=none; b=se05E/Mk11WCMCHwp2tIH9ecg1ZEoN2w2tsoLcHAAhXahVhO1N47cEVb4VUA3c151qQp2dBltzRhNgb//GGuuJUThzTcLZkRagB4jLD3SRQflKIZQo8Dr0/fpJyUCCLA0sVRyXmKRe+rIzU0VDqGZ4+cc/UdIXFJ0ivsJTNtmn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729804774; c=relaxed/simple;
	bh=CjllKaQMNRi5QRmw0m0AUimxSvg5wkpIl8wzT3v+Weg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SO6JxD4kGD45GscuDw2dhxTOO/2RS45Ut5B2WHVeontoYdFBySsXLjIwnNe6IMIoQInBXyE+Cp7vJBXVTPqarAuM+PSlkFG+LJ1uXidbMefx3tphDdhLSvDEaLnkc6qtWwG0q//dMyp7G2uyd1ZmutWQSaYOY1GrMyyibC9ymEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bJR3ffAb; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2fb4af0b6beso21893751fa.3
        for <netdev@vger.kernel.org>; Thu, 24 Oct 2024 14:19:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729804769; x=1730409569; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TcctwDFY4vX2U6NHXOTm25XQBD22CesfqwSVX75dhZw=;
        b=bJR3ffAbUcSkEdGdK9EQJFGcxxbRSnzE6e2AOIlSP+xr3BKYCvA5ZabS1ga8HYhmuc
         /8Z3l4n/ebw7gQGPT/rsfUM0wBY4jG9VcpD4gq+FKgJIRVM7ZZrGo01Bpge8P9XXlJt8
         ZlxLWZzH1AesHBuhoqVGcabIi6wY7/2lugA2RXzj0c+Xr5z2bvtSOcnQs9ebbL8AdyOG
         kIfFiyxaCYKn+Glbdf9k5FpynXMfoFlUNj+F91a0bLB72Te/GxxCuuunNz6/HQ/iHYUD
         uwBE9I8W+c2BKdxNcapKHqf1k+9MsmI09CBsc+sBZN9S9KYAA/1QQmB5ZWj9tEuSiLhN
         +GAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729804769; x=1730409569;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TcctwDFY4vX2U6NHXOTm25XQBD22CesfqwSVX75dhZw=;
        b=Lt/B42SWpISNz2jtDm5avgWMsI5iKofJ83/daqF5BMgHKM/jHwsicDEyjy13koMkF1
         LElXzhQuC8kIgsVq6Oo3SRiM+UOwsYfJnwbZe/U896cxeRtwAbc7x8JiQIINkCmt7fLC
         m6TQ7InQn+jSmksf6CfAWzHiW8Xg06nky/zegAO1NlRIZtBEjK2d6dFMyMYD7IMmnk73
         ExTe2XqZPYZ/ZPbHf5PgYH6eJGeU/i7kE6Fr90Np4vpuF8zTqJHiT0sNslk2KAE/gzEG
         HW7EekQl+I74f+JV6QM+nCrfcdR6tnOr4kAh6YxPP4kBzhdKz36KcBGw3+YQuLk51Z1o
         9BKg==
X-Forwarded-Encrypted: i=1; AJvYcCXPjxHboi4n/Cb5MiaYN9MDDftnyo+m2tyGn8a3WTsxzNIctpUTm5pkFQELi81tMQuWEerpfK8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7XKzo+tu/SN3KxnIRU+UJdhJIIRlgQPJB9kImm9NJFBk/cym6
	qD/6uCKL3Y1J+zqJ9H0aCv7qS6viceK118kbT06hjKTgMFfyhTugN98Ah1B/ulhWIi+rB21A3x6
	5WL4haB2HACI0bobgUMGC3g2mwhQbhGgwCNM=
X-Google-Smtp-Source: AGHT+IFq3aZ3+eZVePX4hpWlTPzqI4kBipts++dHji4FFgk/U4psBOyg8eSfChqEk0gsmuD/UY/FzUR+svu8SJZT0a8=
X-Received: by 2002:a2e:4619:0:b0:2fc:9869:2e0b with SMTP id
 38308e7fff4ca-2fc9d33a195mr51481041fa.20.1729804768890; Thu, 24 Oct 2024
 14:19:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241009-devel-anna-maria-b4-timers-ptp-timekeeping-v2-0-554456a44a15@linutronix.de>
 <20241009-devel-anna-maria-b4-timers-ptp-timekeeping-v2-8-554456a44a15@linutronix.de>
In-Reply-To: <20241009-devel-anna-maria-b4-timers-ptp-timekeeping-v2-8-554456a44a15@linutronix.de>
From: John Stultz <jstultz@google.com>
Date: Thu, 24 Oct 2024 14:19:17 -0700
Message-ID: <CANDhNCrU+WufRrOreDNG4jAJMhxXphqyWLm_hGr_ihN2TDKdRQ@mail.gmail.com>
Subject: Re: [PATCH v2 08/25] timekeeping: Encapsulate locking/unlocking of timekeeper_lock
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
> timekeeper_lock protects updates of timekeeper (tk_core). It is also used
> by vdso_update_begin/end() and not only internally by the timekeeper code=
.
>
> As long as there is only a single timekeeper, this works fine.  But when
> the timekeeper infrastructure will be reused for per ptp clock timekeeper=
s,
> timekeeper_lock needs to be part of tk_core..
>
> Therefore encapuslate locking/unlocking of timekeeper_lock and make the
> lock static.
>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>

Acked-by: John Stultz <jstultz@google.com>

