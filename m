Return-Path: <netdev+bounces-130832-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 57C2C98BB3B
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 13:34:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1FB67B22BE0
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 11:34:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BAF11C1746;
	Tue,  1 Oct 2024 11:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZxKBEitm"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53B8B1BFE0F
	for <netdev@vger.kernel.org>; Tue,  1 Oct 2024 11:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727782424; cv=none; b=bHFbhIToBwnU7okZUjCJJ1ZhPwpWyNgqzkozG/9ngJ7lh8IQktpSXicLg4LwIHbdrFINIqYuQZbVPuO0yrIeUhnugU7t4D3X3StrnUPLJ7YKvDB3VJ/58fy43EGXV4lB6j+dsVdtaHR+6LP7AE25D2TSqu7X8UP9FIe1pJkekqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727782424; c=relaxed/simple;
	bh=SftQM+mK4zuXe6IENLMxS5lt9HmW6PTkhl0QXT78BAY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ri5R3pmrtugduCDB4VgQ1/FwD6HYCIfNieZK8OEZyp2DSGll2CZKWcvhhbOZK1IkbAV9Gpwag12xQS0e/aTA5zF8M5GvdGCmxf6PIGeppmUPEfo8WdT3z+qRhknw5Smrx0reOcCaAhorutbsvC7r4/GSY6nnVV9yzMTqMDXYdAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZxKBEitm; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-42cacabd2e0so42010495e9.3
        for <netdev@vger.kernel.org>; Tue, 01 Oct 2024 04:33:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727782420; x=1728387220; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UTHP63C34xg2aogNp65We2l8RnKgujyigD9EBfzjmh0=;
        b=ZxKBEitmLv/P7BPFfc9PiCcqnU/ffSmXEVeoHtU5vnzenNT+WUY23GqbcTRwAYnINC
         y8uvz2BXx8DsU/WLUVi3glPVUxzfAu6Rf3Vyt0HNINXzrr4U3QRBEX8cpaOBddKlIuAg
         AsNEplTbs0w9Qc/q50TqOhDZCHZ/QnpdoxQUrGfHgkHMxeP0tewniI+KtPy2x82NWSd/
         72mGnxEZy2wk0x3QeSSJpqntV43QJv+m31cIhwEcrCvEuoWdRAIgO8+xqJMFpMndGwud
         uzPYgo4eaJPuMK5jRpbG3ioD8aRsAHhdpricLDe13G7+xMg071ztNTa8ysl9q0oMltOB
         Rclw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727782420; x=1728387220;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UTHP63C34xg2aogNp65We2l8RnKgujyigD9EBfzjmh0=;
        b=SNe/QMuiVYHR2dcCqQsG6MDMV4PXy6ISMnnIkqE0H3q8Ov1GAYgdWNoKZw3X430Xy8
         g1ZrJkwutiLHcVbTDLGM1FvAkrYtkTa8c6x4G6D1JU4W8ltK5NsjCtVJIt3mP2oYD4ON
         66NA9Wb99KcKXSRXVY+pLMwc4eipsxtyW74lTpoC/DArf/Y7vu7NSdfBnHW33gtbmFio
         l3OFcX1Lv87zNQliGPPNghgGulSwDorWxgzdfyucRg3/XKdjgBmwtf2m1u3vuCoeoYie
         7/oggrEJ+HE3JNEPqocAafEPr1BF58HzZU6CkeEXkVG1VJHtDAQUzMSExFk1WUemj7xp
         28mA==
X-Gm-Message-State: AOJu0Yx8TN6NJl8eU6ilGFukUqsMLjo01CWr4FGzNHAuy9NJUUI9vcjJ
	YprbtlRwJBe89cxUjKuhrDENtrZiCLsLko/7J44CgUJrIQMMufszt/ww8ZqBVppnaEBwskF1VtG
	4UJGCJqfTSUdNRq0MU3qIf82thM8JIBzbAkPBUr4mBvjzWwZRjRRd
X-Google-Smtp-Source: AGHT+IHNgnmCHGWWcbcgOVaommAUTOUhVjoXuxNO5su0aRZagrDrAUwckbYNlwm8xmVl2alDc9izICJYXQUbRut+D40=
X-Received: by 2002:a5d:690f:0:b0:37c:d4ba:1127 with SMTP id
 ffacd0b85a97d-37cd5a8791dmr9238221f8f.16.1727782420382; Tue, 01 Oct 2024
 04:33:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241001112512.4861-1-fujita.tomonori@gmail.com> <20241001112512.4861-2-fujita.tomonori@gmail.com>
In-Reply-To: <20241001112512.4861-2-fujita.tomonori@gmail.com>
From: Alice Ryhl <aliceryhl@google.com>
Date: Tue, 1 Oct 2024 13:33:27 +0200
Message-ID: <CAH5fLggkZjUbGxDep1852AbL61ofhf_p2xoZOh87u0boVFUbPw@mail.gmail.com>
Subject: Re: [PATCH net-next v1 1/2] rust: add delay abstraction
To: FUJITA Tomonori <fujita.tomonori@gmail.com>
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
> dealing with hardware delays.
>
> The kernel supports several `sleep` functions for handles various
> lengths of delay. This adds fsleep helper function, internally calls
> an appropriate sleep function.
>
> This is used by QT2025 PHY driver to wait until a PHY becomes ready.
>
> Signed-off-by: FUJITA Tomonori <fujita.tomonori@gmail.com>
> ---
>  rust/bindings/bindings_helper.h |  1 +
>  rust/helpers/delay.c            |  8 ++++++++
>  rust/helpers/helpers.c          |  1 +
>  rust/kernel/delay.rs            | 18 ++++++++++++++++++
>  rust/kernel/lib.rs              |  1 +

There is already a rust/kernel/time.rs file that this can go in.

> +/// Sleeps for a given duration.
> +///
> +/// Equivalent to the kernel's [`fsleep`] function, internally calls `ud=
elay`,
> +/// `usleep_range`, or `msleep`.
> +///
> +/// This function can only be used in a nonatomic context.
> +pub fn sleep(duration: Duration) {
> +    // SAFETY: FFI call.
> +    unsafe { bindings::fsleep(duration.as_micros() as c_ulong) }
> +}

We should probably call this `fsleep` to match the C side.

Alice

