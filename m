Return-Path: <netdev+bounces-136111-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 337C69A05D6
	for <lists+netdev@lfdr.de>; Wed, 16 Oct 2024 11:42:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5BF801C21A96
	for <lists+netdev@lfdr.de>; Wed, 16 Oct 2024 09:42:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78C46205E33;
	Wed, 16 Oct 2024 09:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C5ZIfUVy"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AD24205E20;
	Wed, 16 Oct 2024 09:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729071742; cv=none; b=NU8hqXGTdxYUuwy76XDyLE4rhRIZ1FHL7MX6B7u1PiIFCiPWBWqLGmTeWc5+2+BYK79W+VVKP+cHYA0fRQhIqgBeKGk+MQ25iF7fJso6MZ/8pQdeM4CZmXvWbF4IUIJUwisGm4fGSd3quDY0hMmCG6m/mcvA1MYzBk2f/p6evi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729071742; c=relaxed/simple;
	bh=0ROIun9+2bA4UZLe9ILmjg9JaR1lCe7+bRu/u/vnsPw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cM6Rw/qzgswpUdvdFcT8SNw40i76hxi/rZpj7gBXlWn0UC4DWmz1zPcWYURkwd5itZYEcBI7cJ2HxW+/mZqAa70GOncQ28++KiLFwRAWmt9CVc4lK5H8ywhRUfDQk9nrAg4pQvbaTSEtSHrykv3t9T92DboiKGGcRD69igTaEIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C5ZIfUVy; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-7ea64af4bbbso414831a12.1;
        Wed, 16 Oct 2024 02:42:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729071740; x=1729676540; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0ROIun9+2bA4UZLe9ILmjg9JaR1lCe7+bRu/u/vnsPw=;
        b=C5ZIfUVynL2ub+WCGXjhpHT9Enb5jBw/5DpuFOszL09mEf108Dhxv/ki6Y7M0O5sAz
         Pg8qY79VegIMuzleH7NGADqbPH5zHYMc8QQoHMZiCuAZFkgYcHjUHq5Pa7rEzHZvy314
         K8oQswOn+IOcunvmi55QvVO+MPZQHlATtBcTC+S9Nzoq2zR9r9Qa516XTTL+UjvORkBZ
         L5MHmMiNrtSbzH6DTLyklQ0Hu7H55aQNwTvw6W+OYFVQjO1Jm/0XHsGX+Ed9uW20kRuI
         a3WetXZH0Hwbprwyu6NZtqDhf5ym/pw9CGkIDbtyspX9iW/sFklZTX2K/h0w4oLg/Ji2
         3AIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729071740; x=1729676540;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0ROIun9+2bA4UZLe9ILmjg9JaR1lCe7+bRu/u/vnsPw=;
        b=vpIkEiFuiFeNUON7nQEaHWaxB8+heeYQI0pL5aNekbwCjVulj0tjs9aoRRe2BDDgsi
         L8K5ofulr6pb2GXctz2jhfIWv7JtCAEE4qWhmA2pEZyHasIueWYn8Axo1yFmx9vWsVO2
         otkNVlShk4tMQaTws1fdg8rKdQRPOVxMqtcznWxuukoZANWCZbKQScRiNlmFSOuv9bbe
         cCfsJ1NC3iNaVX13+6S1ByADRHw+3CldkVzxAgYl0KHrNKZMp255koPjoHMyPgwwXVLS
         okR0pEBv8IBmwawkOr4SN/mdIHvGWPqie29XdSgYamU7zazWXlRsk08yRiOzRAolZCi9
         34Kg==
X-Forwarded-Encrypted: i=1; AJvYcCU4JRWrv++k7ZN3AhDPOvW+stge+kS+5VG1dL9amjT7kwj6Ppwa5lML3j5WObMv4EioE314hCvkY9nUJTTGWyw=@vger.kernel.org, AJvYcCVOnUhZ5T+2PH9q1dgX6qeI/VbGQZOp2cedEU7LUx5SBwVPHp/xt+jMyOUmWmLOAbtoFSptMJYv@vger.kernel.org, AJvYcCWru1AcE7j9CZGG0rd2FsoXrdg0XVZWyEHYyXLX5afOZKAcrPv5XeV5D1MpI44aEQL9LNzIf2IxhyJZS4I=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3SZ6YhNtc1RajsRdFjABgfTxgXHCnsulxrhQPjtib8gA6eqH3
	1buGgTIHULCdloZhacfdxtHm1dWuOxA5RtwequYYblMtmUnRz2YJhOzvH0W0Nx+ep6w59v4Q4Rd
	mz2gJBhnU2yJqSaLLG45aETrzips=
X-Google-Smtp-Source: AGHT+IHi0A8/PV6E9lyeXG/3wVsU9tT7kuHybNSxajW9mmWYQ7zdVM067KZbEGHzCY1n7J1Vvlg+DTAGazeQKOvFmUY=
X-Received: by 2002:a17:902:da84:b0:20b:642c:222b with SMTP id
 d9443c01a7336-20d2fe58acdmr9802325ad.15.1729071740219; Wed, 16 Oct 2024
 02:42:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241016035214.2229-1-fujita.tomonori@gmail.com>
 <20241016035214.2229-6-fujita.tomonori@gmail.com> <CAH5fLgjTGmD0=9wJRP+aNtHC2ab7e9tuRwnPZZt8RN3wpmZHBg@mail.gmail.com>
In-Reply-To: <CAH5fLgjTGmD0=9wJRP+aNtHC2ab7e9tuRwnPZZt8RN3wpmZHBg@mail.gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Wed, 16 Oct 2024 11:42:07 +0200
Message-ID: <CANiq72mKJuCdB2kCwBj5M04bw2O+7L9=yPiGJQeyMjWEsCxAMA@mail.gmail.com>
Subject: Re: [PATCH net-next v3 5/8] rust: time: Add wrapper for fsleep function
To: Alice Ryhl <aliceryhl@google.com>
Cc: FUJITA Tomonori <fujita.tomonori@gmail.com>, netdev@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, andrew@lunn.ch, hkallweit1@gmail.com, 
	tmgross@umich.edu, ojeda@kernel.org, alex.gaynor@gmail.com, gary@garyguo.net, 
	bjorn3_gh@protonmail.com, benno.lossin@proton.me, a.hindborg@samsung.com, 
	anna-maria@linutronix.de, frederic@kernel.org, tglx@linutronix.de, 
	arnd@arndb.de, jstultz@google.com, sboyd@kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 16, 2024 at 10:29=E2=80=AFAM Alice Ryhl <aliceryhl@google.com> =
wrote:
>
> You probably want this:
>
> delta.as_nanos().saturating_add(time::NSEC_PER_USEC - 1) / time::NSEC_PER=
_USEC
>
> This would avoid a crash if someone passes i64::MAX nanoseconds and
> CONFIG_RUST_OVERFLOW_CHECKS is enabled.

I think we should document whether `fsleep` is expected to be usable
for "forever" values.

It sounds like that, given "too large" values in `msecs_to_jiffies`
mean "infinite timeout".

Cheers,
Miguel

