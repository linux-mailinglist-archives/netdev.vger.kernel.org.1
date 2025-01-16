Return-Path: <netdev+bounces-158832-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 44BF3A136E2
	for <lists+netdev@lfdr.de>; Thu, 16 Jan 2025 10:45:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B97CD7A23CC
	for <lists+netdev@lfdr.de>; Thu, 16 Jan 2025 09:45:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C2181DD0C7;
	Thu, 16 Jan 2025 09:45:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UUYJkrB1"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80F63145A11
	for <netdev@vger.kernel.org>; Thu, 16 Jan 2025 09:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737020717; cv=none; b=nFM9dYdu6EYdjs/5kquTnbF77Va6AYJvKeACJXC2guuVx77B3CSRkkTYGUEpVdJk1CInuYyuwVwK8ioYo6JMIbzl7GCWmG960dC7f5XlWg+EVSU7Ygk4LzTBX7vNahwi5XDccF1IsWgJ6PtBOVssZLVktLOrOTG0rCZdUxJDm3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737020717; c=relaxed/simple;
	bh=SL6zWPg7b13eNNbqzfJiEUxNOGH87kbqXmMqxrNyzZk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Rgx2PzBVI0DQBEG8OycTc/vRXg0K7YQMsRlMpHVsec1Rg0F+L8MFUSWv8PJ8ipJ5i2vWMtAxcugaptQWWa0dWxYtWi6ND9GXQd/vZT7WMGrl1guY5sUwZVeB01IwQygNh4mbyNkiZyWyK9datU66SsCZVed/01s/WzWZOnF588A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UUYJkrB1; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-38be3bfb045so1095000f8f.0
        for <netdev@vger.kernel.org>; Thu, 16 Jan 2025 01:45:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1737020713; x=1737625513; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G97hjMfDtUXj+Is0oUFrqTtwBK3UMNwO8cqTTqcsyh8=;
        b=UUYJkrB1mawCcaNGcpqxeOBj7pe564ermYi41DCx0dppMlg6yzWv02OQ6GkDf+XdAr
         aYmmSELOPZ0Zjueg7QDnx6SaoP7iNXVxp5JSDZeavwvrWVEhzdG9p20XI3rxXUGx9zRj
         mKvr8GgqvlQX3F1OMV8RAqRWSoAL4kOz3FJEDX61BaXZ4Z/w4sL8p2VTOAZELXfqW8Bo
         xzlYoXjKs9IMA/r0lMhAE+3MPFU1/j17iLrUcdnagIEIVTyiKt26B68NGb0RsVyFy3Ur
         v0UAVFamK56XQefUT61hiEM9KZbbW7eZ4qIfw3r7bXimPGn7NBPQyTK7dJk34qLmPiDd
         l3zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737020713; x=1737625513;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G97hjMfDtUXj+Is0oUFrqTtwBK3UMNwO8cqTTqcsyh8=;
        b=QlFoWS0HPLcHbjvTd7nMFxyaPsmGXR01pDBWHf4aQdulid9z5fJ1Wcw1K40Rw3VHf5
         KoAczjjsofpXF4F+iOvCV4SGebAwKhhDOG9fmQS1thfq+/BlpimseIVApmPMolGv9Sea
         Cf66MuvLtm3N6hr99EFI7CbjOoEntvP+4DEkqwGY4rD++vwFtSfNwwInYvAC5sLgACzr
         NIieeiQpdwcUDsQsFixyRkdPLRwDjMms7nlTXmtrEKdfruU0S+gTmaQNtwkgwYWMmlez
         sj81ezfT/31tetH+4s2DrAQxZRcyh/JeNhVeKCbJk/JJYaCIv+MjMAHoUpF1K3DaM2gz
         p6WQ==
X-Forwarded-Encrypted: i=1; AJvYcCU7ILbGgtGytBOMNbDch43ABByrI3vU5Io+GtHx98IG8xG8ZYgl/NQw07ZHCupm5T/eX+BpaL8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxLgpO3fmLTmvXRtf92/8jEQCqEfCv7capkiKpuIrKcu5+AAcgr
	FN19J/WWH0MWVvmccvIe5g7dlWVoQNjTav+LA/Y3RfH2SkmiwyALkbrg8hUAl9wUQwa3CCvZZBy
	3UedgBzfr3oe4ZzUFNN47TdlPtcLHj4LytO3/
X-Gm-Gg: ASbGncuL5g4jy6EDb90Ro2QV/siu/ycrxUQXsVmZttFnXvvtB51Dlrf94XJ+R3uqR5+
	9+UAPq5IT0et7qMarMpAEDlmxUmuGF3EBdox+lAFjoEIuXmoJsAYXjypY0MBFYniEwbM=
X-Google-Smtp-Source: AGHT+IHyJ8nvs2yvNcmDYbDwEp1qMKTZrUw/yqDAC3Hebhph+3mCuJ7v/Xmj4uOyJRH25eESP+IdpuvrTHkRcNm9laQ=
X-Received: by 2002:a05:6000:184f:b0:38a:a117:3dbe with SMTP id
 ffacd0b85a97d-38bec507323mr1823023f8f.21.1737020712688; Thu, 16 Jan 2025
 01:45:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250116044100.80679-1-fujita.tomonori@gmail.com> <20250116044100.80679-7-fujita.tomonori@gmail.com>
In-Reply-To: <20250116044100.80679-7-fujita.tomonori@gmail.com>
From: Alice Ryhl <aliceryhl@google.com>
Date: Thu, 16 Jan 2025 10:45:00 +0100
X-Gm-Features: AbW1kvYdQi8ZJtKAP6jrR98YMJn2YEu4b49Q0-p39jnMzgaoN3yho_fE7k21c3M
Message-ID: <CAH5fLgjoAzv1Q0w+ifgYZ-YttHMiJ9GV95aEumLw4LeFoHOcyg@mail.gmail.com>
Subject: Re: [PATCH v8 6/7] rust: Add read_poll_timeout functions
To: FUJITA Tomonori <fujita.tomonori@gmail.com>
Cc: linux-kernel@vger.kernel.org, Boqun Feng <boqun.feng@gmail.com>, 
	rust-for-linux@vger.kernel.org, netdev@vger.kernel.org, andrew@lunn.ch, 
	hkallweit1@gmail.com, tmgross@umich.edu, ojeda@kernel.org, 
	alex.gaynor@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com, 
	benno.lossin@proton.me, a.hindborg@samsung.com, anna-maria@linutronix.de, 
	frederic@kernel.org, tglx@linutronix.de, arnd@arndb.de, jstultz@google.com, 
	sboyd@kernel.org, mingo@redhat.com, peterz@infradead.org, 
	juri.lelli@redhat.com, vincent.guittot@linaro.org, dietmar.eggemann@arm.com, 
	rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de, vschneid@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 16, 2025 at 5:43=E2=80=AFAM FUJITA Tomonori
<fujita.tomonori@gmail.com> wrote:
>
> Add read_poll_timeout functions which poll periodically until a
> condition is met or a timeout is reached.
>
> C's read_poll_timeout (include/linux/iopoll.h) is a complicated macro
> and a simple wrapper for Rust doesn't work. So this implements the
> same functionality in Rust.
>
> The C version uses usleep_range() while the Rust version uses
> fsleep(), which uses the best sleep method so it works with spans that
> usleep_range() doesn't work nicely with.
>
> Unlike the C version, __might_sleep() is used instead of might_sleep()
> to show proper debug info; the file name and line
> number. might_resched() could be added to match what the C version
> does but this function works without it.
>
> The sleep_before_read argument isn't supported since there is no user
> for now. It's rarely used in the C version.
>
> core::panic::Location::file() doesn't provide a null-terminated string
> so add __might_sleep_precision() helper function, which takes a
> pointer to a string with its length.
>
> read_poll_timeout() can only be used in a nonatomic context. This
> requirement is not checked by these abstractions, but it is intended
> that klint [1] or a similar tool will be used to check it in the
> future.
>
> Link: https://rust-for-linux.com/klint [1]
> Co-developed-by: Boqun Feng <boqun.feng@gmail.com>
> Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
> Signed-off-by: FUJITA Tomonori <fujita.tomonori@gmail.com>

[...]

> +void __might_sleep(const char *file, int line)
> +{
> +       long len =3D strlen(file);
> +
> +       __might_sleep_precision(file, len, line);
>  }
>  EXPORT_SYMBOL(__might_sleep);

I think these strlen() calls could be pretty expensive. You run them
every time might_sleep() runs even if the check does not fail.

How about changing __might_resched_precision() to accept a length of
-1 for nul-terminated strings, and having it compute the length with
strlen only *if* we know that we actually need the length?

if (len < 0) len =3D strlen(file);
pr_err("BUG: sleeping function called from invalid context at %.*s:%d\n",
       len, file, line);

Another option might be to compile the lengths at compile-time by
having the macros use sizeof on __FILE__, but that sounds more tricky
to get right.

Alice

