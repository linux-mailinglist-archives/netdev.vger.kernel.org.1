Return-Path: <netdev+bounces-130836-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B09198BB67
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 13:40:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4D3811C23631
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 11:39:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACC341C175B;
	Tue,  1 Oct 2024 11:39:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="xRIuoiqS"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0F7C19DF53
	for <netdev@vger.kernel.org>; Tue,  1 Oct 2024 11:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727782789; cv=none; b=UWDQS9QbLDeDA/ULJf2D+8zY0YjN3iLKsMKD4ur4VIBkEWdMWFCssiq4Yc60Yuz7WWUYmmamKhZmginQwdQAacewbTmMO2m5lbR8nJ7KyJeKYFLXEyOsu+4TG5l9Ga/Cq0Uf2aDwSg77v7EOPAOvu7x0b+nwEh/NPkG6kC/hC1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727782789; c=relaxed/simple;
	bh=iv/JyJ2uWFb2Z7Z7uMY0jvzmnyHI2iVYs5qeNY90hlo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=p3lymEu9s6NOSq6b7b3qmlLEt2YLwmzbTWiccKlWBc93s5sUyCK0weqVhzVjFU17MVrADfnIT1RUiza/2OYI1WqlExS/lkfZoN2XRZzOp+1QklCjtRSMRWgyfepoqMLg17zMWj7XJ+l0ptdIiTuyZy84MDyGUxCtvqzB4byC8gk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=xRIuoiqS; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-37cd831ab06so2067486f8f.0
        for <netdev@vger.kernel.org>; Tue, 01 Oct 2024 04:39:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727782786; x=1728387586; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iv/JyJ2uWFb2Z7Z7uMY0jvzmnyHI2iVYs5qeNY90hlo=;
        b=xRIuoiqSVzrA5I0LCJluFJSQqTcu6Gony1Ig9bVkDiWg2qRR/FSn9kU4ZOat5zuLa6
         3gCNEJQd9ZQAKyxkoH4t1QrmVGPDYfeKbyhaaxkGzz1aycNWeV9BQioRYyuvUM1fxVQq
         zajVf1sVQ2QC3oSL8++F/0pkueZyf4mC7lEeGpCXzLG2euzGq2WGk6IqZMOq0MhPXWqy
         y3XXOADhMAh7xRANhAgAzaNGKUQ5/ZQiTy3qNOeldVmjur98nUkehMv4nKgbOisYE9xx
         Q7ZBX+IwoBLc1djjGTfQe990fxIUAXINvjUV3isBEaWtq4t1vm3vgvF4nP95icl6vIZY
         /ayA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727782786; x=1728387586;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iv/JyJ2uWFb2Z7Z7uMY0jvzmnyHI2iVYs5qeNY90hlo=;
        b=eMpHaBSrw/2BzjLGPyH1Ex1u4XJtfs8jGjM2pXRFMummjalqz6IWAqRXq3Cp/eQ/S3
         I07eH53Vvs9fTez4QmNjHptjHTJ4zsH5D6/3304TF36EEeX1xMxiERIMFoY2Uo54fFy2
         6lTdH796Mdkug6qnDI2QFJ/QEDrgsMjW80bNodOfFV9yG59N61a49zFluy4aSbTaCUpi
         n9b8FynV2Vt3ypwr7TmbOvgiUoLkJiZKf7aTWXRWKcVwKugTIulUful8nCz2Bc71rrPX
         qOhW6ItzMQ3LRKU6xhBZ0Z14zK76DbOYN2JgLWx11egT7o9ghT/hCT719zqzU1MEUP24
         /mSw==
X-Gm-Message-State: AOJu0YwTnLWD3BCvV6dIif8SZKA0etJNBiY5qN+xxYg29sWKtxTRCKcz
	DFjb9KAwOVZSFylggJ1AIeIElWxnHkbtcvwbdH3tXUr0TnuJk86ou6RzpDscjEn8/mAW2irZ1Db
	v00t3SesoxOW0g4PFXpLDDjsQa2zKiGrVEP0z
X-Google-Smtp-Source: AGHT+IFUqvB+F9sWInLD7ZIcsIQSS4pcTgsJ8WhMnLcH1tiSzLtlulYAsCmWiw34B1gcTM9nNGxCcRlVnnwgX1xoXVE=
X-Received: by 2002:a5d:6846:0:b0:37c:cc8f:9620 with SMTP id
 ffacd0b85a97d-37cd5b282a5mr9432548f8f.55.1727782786047; Tue, 01 Oct 2024
 04:39:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241001112512.4861-1-fujita.tomonori@gmail.com>
In-Reply-To: <20241001112512.4861-1-fujita.tomonori@gmail.com>
From: Alice Ryhl <aliceryhl@google.com>
Date: Tue, 1 Oct 2024 13:39:34 +0200
Message-ID: <CAH5fLgiCaAdHOd-7oqdg1e+Pk1M8Bk9o182x0gkjR-_msY3jVA@mail.gmail.com>
Subject: Re: [PATCH net-next v1 0/2] add delay abstraction (sleep functions)
To: FUJITA Tomonori <fujita.tomonori@gmail.com>, 
	Anna-Maria Behnsen <anna-maria@linutronix.de>, Frederic Weisbecker <frederic@kernel.org>, 
	Thomas Gleixner <tglx@linutronix.de>
Cc: netdev@vger.kernel.org, rust-for-linux@vger.kernel.org, andrew@lunn.ch, 
	hkallweit1@gmail.com, tmgross@umich.edu, ojeda@kernel.org, 
	alex.gaynor@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com, 
	benno.lossin@proton.me, a.hindborg@samsung.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 1, 2024 at 1:27=E2=80=AFPM FUJITA Tomonori
<fujita.tomonori@gmail.com> wrote:
>
> Add an abstraction for sleep functions in `include/linux/delay.h` for
> dealing with hardware delays. `delay.h` supports sleep and delay (busy
> wait). This adds support for sleep functions used by QT2025 PHY driver
> to sleep until a PHY becomes ready.
>
> The old rust branch has the delay abstraction which supports msleep()
> with a helper function which rounds a `Duration` up to the nearest
> milliseconds.
>
> This adds fsleep() support instead of msleep(). fsleep() can handle
> various lengths of delay by internally calling an appropriate sleep
> function including msleep().

Add time keeping maintainers to CC.

