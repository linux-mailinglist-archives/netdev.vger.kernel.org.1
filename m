Return-Path: <netdev+bounces-197258-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D118AD7F92
	for <lists+netdev@lfdr.de>; Fri, 13 Jun 2025 02:20:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1DB4217716F
	for <lists+netdev@lfdr.de>; Fri, 13 Jun 2025 00:20:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B55481B393C;
	Fri, 13 Jun 2025 00:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jOCiI75I"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1AA2219E0
	for <netdev@vger.kernel.org>; Fri, 13 Jun 2025 00:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749774020; cv=none; b=GXYwnobcE6uHNWobbhbADxqBzuYpXmLimcOE6N+c0XmFw9kskg4C/lVPDwJpHTg/QL9LYFXrvUXKptLEBRa5/FLIdoilTBRHowSsTuhnWRR3/qpYWC+yGAyUgbMAYfekWCJpH2fpG+V8DD77Dcrnh+61w3lSFjWuvhmlyuQDZQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749774020; c=relaxed/simple;
	bh=WZlDFmASrocHsgBMFA0A1825qOL/T77/ZQIcSB82Jbo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tyVtht7Bve9M03nIoI9snMiSPLMJKjHjEbIRFgeF03J4qCScngHhwgM66HAXFaZSOMqpNXPwj4xF1gMXHcWpBMX4mDModYi7cYlp3EG5KWvs8mM9CPTzDkiGmuxbtdiq4Zkvspyn3N0bsJIDI6i6Kmk8CPNvZ9E6M3LQjdvS6EE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jOCiI75I; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-551efd86048so1398005e87.3
        for <netdev@vger.kernel.org>; Thu, 12 Jun 2025 17:20:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1749774017; x=1750378817; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WZlDFmASrocHsgBMFA0A1825qOL/T77/ZQIcSB82Jbo=;
        b=jOCiI75I/dVUga9KJoFSPw/Td/LBB/Txr+OHp8wAUWrJt81HiCNn+pasztvpbiT7sP
         rt19klF3ki1JlgXEVFez2G5hF2buukzwRU0XCyjIEoYnML9m2yo51xHTJ3dcHs7gOWdF
         bwJto1co0bWSJ3n3RmMuGzqapDbtBB7MajC3qA/d4B1HJ10g7yTzBq+8Y07rX488TnG5
         adh0PunS9h/V1Amuhu2r1wsCQogFBNbV6KUUfIJENgsKJI/oBnSJ5nBxSo8soPvh3TVh
         pby7lBGnDw4CZADD+eGyW0miy5VdXl54jcchCnOSDATGu1JYJYgawxwoA+k1F22j9shQ
         aNwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749774017; x=1750378817;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WZlDFmASrocHsgBMFA0A1825qOL/T77/ZQIcSB82Jbo=;
        b=DLhSFQmOnSQLtT+pwjgHa00cwqOKCo7pRIO8b5tVa/u4zPhA8pJGVvsx8vMWlBJ4vr
         OyA9Sg6JgIhhXnUjD3LDYI599P0IRuwWEYuPUjnc1kO6ThlYjlmo/LpT9/ulp44fu05t
         2Rib4GB+wYB5IaqpABzhHcoXFyNSgPHkS03c8CEK9AHPBAwdhR1NNX8K5tH2FLGkEuLG
         2j48fZ1e7u8iVGu5q95fONfx0gosG2iatCBk0mwjyQPTH2XaEDcRY1V0bqzO+f0xmh89
         n4pnm50htuANSqzx3cjDtRmcoNT8GsgKRWW77xuf83URA0Rvt0LPAQDmjIIYJv9oeaIE
         rBoQ==
X-Forwarded-Encrypted: i=1; AJvYcCUIjx77SOfl0yHBztzYui+FbpagCPkLdMpjCi04UN26cqEgdIqQQcuP152kT6Z4lrheFKtrNyo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxVx89HmeSgv0MRDirmSUxPBnGE1w0A/it38RaQoVDPnZdPHsXa
	NFjaRwGPTsfgBpEz+QESA6rAWIa7hKbMaApiFHrw7DA4SpHBv15Ab7nR7OVPjNZ4xyZGeb/CBIu
	F25rNmMQyhlcq3GqcPzLk3gY+GMpip7PHZcvqqGg=
X-Gm-Gg: ASbGncvParNnGIKPi+6B7GUAcdTlRAheFSRG5KnMhsFP9M4zV9hz2mGPTkxaZuh8LoL
	u2Weolmk8xvn+D7HGBL7eAgDkU9LWrn2buK5NsOTPOmgQ2bC/eZ0WgQxUJ5ZxfZ0WUOCtK0k05u
	ysWi46RVpN7iMZrtY4by4n4gXM23g2bF1GcH8nONt2kVminfe6vrOrN4iJ8OKKjGTCA1pKKyez
X-Google-Smtp-Source: AGHT+IGpyU+vYa4AHJ5TrF9QSMMKoyCgsBhIqqAajnWFJBSwGiySKKfYWnqphEtQSJ7TRHqRNRR3tmhItuK+4KFoleQ=
X-Received: by 2002:a05:6512:2210:b0:553:30fc:cee4 with SMTP id
 2adb3069b0e04-553b0e1d842mr87385e87.49.1749774016925; Thu, 12 Jun 2025
 17:20:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250519082042.742926976@linutronix.de> <20250519083026.032425931@linutronix.de>
In-Reply-To: <20250519083026.032425931@linutronix.de>
From: John Stultz <jstultz@google.com>
Date: Thu, 12 Jun 2025 17:20:04 -0700
X-Gm-Features: AX0GCFtORLLO_9bWzU_W_-Y94_1YZMrdP7FmQlEgdNla6qXvQHPJsbqo7ZuqNzc
Message-ID: <CANDhNComWT8NC9ZyCd4Rr0EuLj_uCxv0mj=eW-zVpEJ+EGMmxw@mail.gmail.com>
Subject: Re: [patch V2 07/26] ntp: Add timekeeper ID arguments to public functions
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
> In preparation for supporting auxiliary POSIX clocks, add a timekeeper ID
> to the relevant functions.
>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

Acked-by: John Stultz <jstultz@google.com>

thanks
-john

