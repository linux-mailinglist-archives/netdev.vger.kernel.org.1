Return-Path: <netdev+bounces-197248-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 74E81AD7E75
	for <lists+netdev@lfdr.de>; Fri, 13 Jun 2025 00:36:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 30076171436
	for <lists+netdev@lfdr.de>; Thu, 12 Jun 2025 22:36:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57D7E2DECD9;
	Thu, 12 Jun 2025 22:36:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kXQjo4NK"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 928A2230D1E
	for <netdev@vger.kernel.org>; Thu, 12 Jun 2025 22:36:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749767799; cv=none; b=mVXyrgwg18SaqxmcelHZGxmV8FHUDP0sXmU9HKrqLGZS8OpF8nZzW3/uBYJvXXlrzbmFsaUo5twqZU6a5ZSWbtWr5p+xWwEI0GLUn0WYHL6Y3vrLTEyWbWP1wjw1HaufHU147GBCPBr/A/LX6ap0N5oJqqtbAp6xYeIo4LJHRLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749767799; c=relaxed/simple;
	bh=7xulCPXVhScf77ocienXAQH0tyuuMW7mAWLEdefz5Mk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=f2duKaAvyaeR2ScD8uv7VBl+GmjiGPL30wC4nMsXnQdRnuk9LMEWijysY3B1BvPg2f/tfrYoheQ+ZuN/yikD9727iYOBXTOlnZ40Pqr8zCuTblXkGNUlJUTzH2h9/7I/c4b9IH4JrPCvleE3bIvWQXWb7FvWGkZKXQ4bikQcefE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kXQjo4NK; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-54998f865b8so1363673e87.3
        for <netdev@vger.kernel.org>; Thu, 12 Jun 2025 15:36:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1749767796; x=1750372596; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7xulCPXVhScf77ocienXAQH0tyuuMW7mAWLEdefz5Mk=;
        b=kXQjo4NKk/2s4HDNFgtoAU0abxAkKmOg3V8HxkvECuR292fMSjHetXOXUM2Y1Mo2OT
         B/qwXCsSkPfh+L1aLXWHo4oxNXjGuCOZhM1g7YFEhCNAkqekfUtJcIx6djdr0WGAv0P9
         2D/ZrviXDEti3uz4b12SSC24TgFHRIEnqfwWwZ8ic0/SCsL66Qo/PQPkeW90NhpbZjyx
         OWFmRGVnvqLj4TDzLH3d6DxkJageNQqBnudsXWwqG76Z0xsaUoC/DknO9e1izVnS3Ct5
         6/JZ5LvSi47uE9s/GAK+6wmkFHJQExLCMzkXxwpYe5oA/tnzm8q+CUo6AmSnr2UUkYYt
         dXVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749767796; x=1750372596;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7xulCPXVhScf77ocienXAQH0tyuuMW7mAWLEdefz5Mk=;
        b=WVvuNjKNU5slJTOLY8QYno8y+QA+nPvvfNEbgDuhGURjZB0g4ePsGODeYZwbxy2qh7
         TRw91R2uWuk46trbWZvUtFaApPEuF+BKZ4kcF0+0dMdLPg+spr5wxQvFuJkWRDjPtceF
         U+vEvQ+O+APhGet47lRDb5PEpZZ2dGh6BsYUIqSfjJYEokdUMKtq0l3pLh/77fXJtsrK
         RatSmXQoBIesJ/dih34TLuKpgyYwYSAfWOXouHgykcFT//fVIvvddJEquDl+H38+KvG3
         KtsoHhgEPlO538IFXF6QDgNpIUa2tyDkFLItIamqKnWJNizPYHFoHDvYagZZdpyDIv3x
         smLQ==
X-Forwarded-Encrypted: i=1; AJvYcCX6k6vVTcbKF6Czw8rxulWScrQKThf2NoXv9C/Vf2Ee+M4njcSM+j/SDAe2EpodaQnKrdO6978=@vger.kernel.org
X-Gm-Message-State: AOJu0YzdUwCYmZydTeLe6VMGRZXALyMV0B7I8zd6mPJiZT2BIrBkZGUJ
	F7XOh6QdLL5Y4SXWEyaiCjAdhDe/Vn+AiupzT/qh1z36I5QlLZM1+paf/y8acpejBG6Dyp8JRHm
	J0qfTt+VU50pRPdiwbjs4Ysq2tvrQ2OYkjJI0cdg=
X-Gm-Gg: ASbGncuCGlXr9+ni3SKBJ2z1hF1o0xluhDBFuLx6orjIoLO7CmGJrulhjFJjj+l6Wjs
	M1dJuS1BZcYAneaw9fwtn+CrQB7qGp//DbvWOPPM4o1z3UGxLo2MCQs4worDOpGQtypfGtUr5tK
	vyAbtx0+NuQhP8pC2vJ0guDVkBaP6Ev7684MKk00gWh+2/zHse4fCud40vLH3SCjuBmnTh9ZEM1
	74wBu6rR0w=
X-Google-Smtp-Source: AGHT+IGl0dDXnBGPIef0qxu8tOFUCVgIEThs+j6hmCCV4bdPc347k+COWCMfaNFMLwa+jweiXZQPJhzkBZTLk4DyTgw=
X-Received: by 2002:a05:6512:398b:b0:553:2cc1:2bba with SMTP id
 2adb3069b0e04-553af95ee64mr210885e87.31.1749767795412; Thu, 12 Jun 2025
 15:36:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250519082042.742926976@linutronix.de> <20250519083025.715836017@linutronix.de>
In-Reply-To: <20250519083025.715836017@linutronix.de>
From: John Stultz <jstultz@google.com>
Date: Thu, 12 Jun 2025 15:36:24 -0700
X-Gm-Features: AX0GCFsxJlt95H0gfp-Y9RiXb9uKGp4ez_vZO90EG9M7VXdjEprJQT7MyGstH_A
Message-ID: <CANDhNComTYD4q-M5OjjYBjgDuLYBUKUZu41ghxQpAe7NPtT87A@mail.gmail.com>
Subject: Re: [patch V2 02/26] timekeeping: Cleanup kernel doc of __ktime_get_real_seconds()
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
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

Not a fan of empty commit messages, but:
Acked-by: John Stultz <jstultz@google.com>

