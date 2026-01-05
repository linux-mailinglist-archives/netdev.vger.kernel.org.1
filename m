Return-Path: <netdev+bounces-247114-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E450CF4C10
	for <lists+netdev@lfdr.de>; Mon, 05 Jan 2026 17:39:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B30883060A6B
	for <lists+netdev@lfdr.de>; Mon,  5 Jan 2026 16:20:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B92D348880;
	Mon,  5 Jan 2026 16:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="itUsbM7N"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EB0A2C0261
	for <netdev@vger.kernel.org>; Mon,  5 Jan 2026 16:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767630039; cv=none; b=cGz3PvFd+0Id3BSaNhNKI+Y5b94Qda1PAgpuT/6BTCL4FCxsYsZyvk2cDftghLQuVSUom2dLf9VlSBVWZuKhigfqMbuVZp33y6/8yXJYwilsjfpF9P4pUShg0bjIJIiI8jpEIMNECgl3JaN5ysZpfvw+XZ7I+x38dwDWYwJJKRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767630039; c=relaxed/simple;
	bh=TC+sIFUON9nVvmZpcFIsoQC9+ToI3rAy/sYlWEUlz8I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HXZRtQfWslm5upV1llvQCQaKTOgfPuEgLg5q6FNsJ80inQA1qI+LJ/3OHYLs5u1g9/CIEa7F3dSwwt2dCya86YvRPopTdXN+YGyPW0HMOoRYR94md/c9RxtSq4/ZbHnvo7Bf07RwVVbWzG8dWBqaPyahl9WbHHoTNod2Tf53yAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=itUsbM7N; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-5957c929a5eso37379e87.1
        for <netdev@vger.kernel.org>; Mon, 05 Jan 2026 08:20:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767630036; x=1768234836; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mJzjkm3pecgLjhv9B/Y7YFvMANhHKFZ3pW7TlSLWEvw=;
        b=itUsbM7NYvAdEY7D+r6b2ZlyoGfBmwEWbsfOVvW78wnNSPtdfo7g5rlrJ9QW6nMUM3
         FdG0xtO/R0uiYdsHNRX4gTdrys6vBaY3U9m+nMzHP/apSh8Td+U66ZtwLBCkGrYARdEk
         yeaFYKXYXGpIwar6hYlzcWEtHpHNq6/6P33LzZCoeuKodcPwBEBrO+lTOeglVhYxwzi/
         FsS5IO5Wgadc7jQdnH85iVYx+aZpUcnHiuW5aH6n628OExLXI/sGWN5zeqteYMsBhhL1
         PQBLhW5ZWBd65lcJmOwx9xBaXscZSJElOdKdtFyDVa1+iGxqdn5RiepKGDwnOxfjtscf
         jt4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767630036; x=1768234836;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=mJzjkm3pecgLjhv9B/Y7YFvMANhHKFZ3pW7TlSLWEvw=;
        b=E5q7mFJ9E1FmUTHfStH+BYLEIn8RktpwfBZME7L43DcVW9jKfQLVBT0mab0uLsLpb1
         b+eot47wawYQVBnY9aK4DOb4cp09G2ht1m4O/clPpbvazbTl6Ra3o7Dp6s7HN0luKMwo
         LXDwMvDsj/E5TkMMBk5NBgiUYTO4U7zwCBBC2MCcx+3kFnKE3FAtKXEOhztmhrB6S2LJ
         SNSaGzj6RacnmtRQnTdkhAAX/EYDj2UmA7Cl6SxMh8kFQWal3DDcFXw8nuVoRzEjUgPW
         dMNuSLyteE4avYkwlZbhSkOoiRGkfjendRH7Vy5wV+5PdoYfKd/7pKpX7k6TkWuCGfu/
         EAYg==
X-Gm-Message-State: AOJu0Yz47LaxPT+nHlQKbdXwHqkO8DYOS2o7sRu5j/0O1QkBx+m4C9HZ
	QHFVAYyF6tQKYTWpbhsjtmSp1WTlyAYHr/aXHMu2UVC2D2Hr1FF2HyPnpKfIF7a1BKBezaRuJUL
	YH8O9kvpwLg0ASx2N2eobRixER0pdL30=
X-Gm-Gg: AY/fxX7K9krxpX2Pi4N3dYtKztFPnH6LLgcKISj2VxKeiBzo+o/bPUsAZQJNXNC5QY2
	/p6tkD6RmrvzBZ+wKIJdIzbcKEkEhgEp8qQXsAKXix90SZE/Q5sX5h45jU32brqO9ALcAjg1hp2
	JHqzpYBuQr12n7ssPWdzn0gPbdUJ4s1tnW3wxTW5H2VESCeSKNyx3K8HcUIGaWTAwD9uFjxu9gg
	9++8iQhY2yXiKrqArTs6C1D0juQZAVkexpCmBZzM37UtwIrP4ipDV8Wwo4tbJU1YB/SIP/e0chS
	oO9K9C5rYJXwCQFaD6TU6RFoZrk7RUlQadG0wM0GSThLj1s4UilQH7pVa64Yz4biUDa8aZmW874
	9k28BNsVS+gmeemDIjtXLj2InxhcalzYflZ4j7K1lfcq0uASMmara
X-Google-Smtp-Source: AGHT+IG5Jz/ag5o8sejFjKjJYkf9QzTISrKNSBIzM9XCKM2uAjGv2psf9FJzZqP5f/r0tsPt/8a9C/iuhthKF6gr7DU=
X-Received: by 2002:a05:6512:ad6:b0:594:25a6:9996 with SMTP id
 2adb3069b0e04-59b65279ee6mr84667e87.10.1767630036267; Mon, 05 Jan 2026
 08:20:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260103-cstr-net-v2-0-8688f504b85d@gmail.com>
In-Reply-To: <20260103-cstr-net-v2-0-8688f504b85d@gmail.com>
From: Tamir Duberstein <tamird@gmail.com>
Date: Mon, 5 Jan 2026 11:20:00 -0500
X-Gm-Features: AQt7F2pUk6i6lWvK3YlDNQpXXEoolC-MQ1o1sooEnJ2c1np9nkuj4VmEjnNIWQs
Message-ID: <CAJ-ks9kKmT7AMbqgWjKvy13iQ8Qpiwi3NpGe=B-YbMS4ape8xQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] rust: net: replace `kernel::c_str!` with C-Strings
To: FUJITA Tomonori <fujita.tomonori@gmail.com>, Trevor Gross <tmgross@umich.edu>, 
	Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Danilo Krummrich <dakr@kernel.org>, Andrew Lunn <andrew@lunn.ch>, 
	Heiner Kallweit <hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Daniel Almeida <daniel.almeida@collabora.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jan 3, 2026 at 9:24=E2=80=AFPM Tamir Duberstein <tamird@kernel.org>=
 wrote:
>
> C-String literals were added in Rust 1.77. Replace instances of
> `kernel::c_str!` with C-String literals where possible.
>
> Signed-off-by: Tamir Duberstein <tamird@gmail.com>

@Jakub are you able to take this through net-next?

> ---
> Changes in v2:
> - Pick up Tomo and Daniel's tags.
> - Link to v1: https://patch.msgid.link/20251222-cstr-net-v1-0-cd9e30a5467=
e@gmail.com
>
> ---
> Tamir Duberstein (2):
>       rust: net: replace `kernel::c_str!` with C-Strings
>       drivers: net: replace `kernel::c_str!` with C-Strings
>
>  drivers/net/phy/ax88796b_rust.rs | 7 +++----
>  drivers/net/phy/qt2025.rs        | 5 ++---
>  rust/kernel/net/phy.rs           | 6 ++----
>  3 files changed, 7 insertions(+), 11 deletions(-)
> ---
> base-commit: 8f0b4cce4481fb22653697cced8d0d04027cb1e8
> change-id: 20251222-cstr-net-3bfd7b35acc1
>
> Best regards,
> --
> Tamir Duberstein <tamird@gmail.com>
>

