Return-Path: <netdev+bounces-131203-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D695298D367
	for <lists+netdev@lfdr.de>; Wed,  2 Oct 2024 14:36:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 144DB1C21024
	for <lists+netdev@lfdr.de>; Wed,  2 Oct 2024 12:36:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0517E1CF5F8;
	Wed,  2 Oct 2024 12:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GWQC3t/Q"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B4AE1D52B;
	Wed,  2 Oct 2024 12:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727872571; cv=none; b=e02Rg9Kt35DShkJKaNJSvXYgYi2+wsHYBvmtihAoBSAQw/fzbj3E+ulM8f5iiidVpOQdiadHTS0OaJ6DdM1eTA21DxyJjIJPHAMbTQTWelLbuhu71scYSJyw3MhJ6DCXIz47pcAgJjVbZ/QcdLRhezAbtOYl7fkxHVvZDeL9jAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727872571; c=relaxed/simple;
	bh=Z3gOJwpnsfIwTozSH/9DLo2lyBS6+hSw8FwSpr4qe44=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZYRK55OuQU0pXAy2V48YksA1eWyQ6Qh/QKCoZC0aC/bBqjCE+5tQCNhwMpOhuw8XWmDTcb3IVm5Gwm6HB5D9EnJT51BHjHaPW8yhbRkd2qd+9oZroZGWf53Ka1xNJADWltI2dj+9n3XHHNfa1GD+cZQkDIZqXYb1qf8omVfltLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GWQC3t/Q; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-71927b62fa1so365737b3a.2;
        Wed, 02 Oct 2024 05:36:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727872570; x=1728477370; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z3gOJwpnsfIwTozSH/9DLo2lyBS6+hSw8FwSpr4qe44=;
        b=GWQC3t/Qk4hg/o36E8FIhsSIoxwmnTHmEleY4ZtNObDRQACIIQzJHohfKWi3v13rKI
         tn4H85Y8t8MkLUku/DlGRb+wdCHfVzq8zyv811mMbpPqQllQNWhENkWr6sCJd7udhvQk
         hVyapAYbVkXwkOnwEve1bVfSS3OmpXnGvrpKaomzRTblrx/33G9BHW3tfUaWnjZzJueH
         hEVQ6Ldpqeou5sy4tJnh+C5LtUku0M/JpZNwEOaOzVpJCmCacpbqfyZeq2ZUO+wvQjeO
         VTFm8iDUwpSiwInXfmpet6Bz3zSS64debbY1Tysz7WbGtaL2arSPhVnMiSA5dy+KxNk/
         P+Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727872570; x=1728477370;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z3gOJwpnsfIwTozSH/9DLo2lyBS6+hSw8FwSpr4qe44=;
        b=QVBcnGaq/jVDltgZm5OcRRgJcYe/BeifRCVaIk3WecJ3Wnpv8FN/Ex4FbpxCL1/tgX
         iuX9OhfBKNooJvi1AaX+sWeghDqWLy1htKy5HSQWDXRk7pl4/fNGeuMISu+AQtTzrTl0
         SxmciNepQEdBxXDqEWlwAhvQhxOXo73zCU0ASy6e+JUPGvcA0unHNUCG9YzVlNtyRi29
         ozBTp3yxvr/ITmAH8Oe+WHPsrsOj4wOd6gO3llePHJqEQPR9zqzrdfDU3UkWOCWUwCFX
         5a9dkmeutZPkwnC75LcIjAmkb+YzNa1Lq75J7Wnhpgsa8KbjUauLfOR/S5UJUmkXt0yf
         zp/A==
X-Forwarded-Encrypted: i=1; AJvYcCXDxeUU4P8bvBy7IyUg5Xni0ve8tvMDuvFjEzpO9pHWuSFYkP+syWIW1RC/wcuiot+xsFzfJaE=@vger.kernel.org, AJvYcCXnr+gvrl4t6qf2OfubcehhLmCkVapwjycDTeB6x9kpxOV8s4vx8y44J1iY92AowUMF+rtzH2p4vvJPUDoPBiY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyPghWHsRyj1IcxftE7tmkkj50vqtY24itcQImRxcMnihGJTapm
	KFPz8g1oug/igOsqReFRp5XKQ46MUTP2xJEdcfp7U4i5Qr7XctW4vZZXdAloxCebD3tzFCumQJ9
	C+ykAWnVD5KrxZa/Y4GodMP4Qo6w=
X-Google-Smtp-Source: AGHT+IHu0OUUfEI0FrAPyx8JB3sJ59gkEGncnLNbIwZ8y7aPfHG/CND12U1KF/IJ5VLqh7vBRw/OdqNFxqJhQTyqDeE=
X-Received: by 2002:a05:6a00:2daa:b0:718:e49f:443e with SMTP id
 d2e1a72fcca58-71dc5d90cdemr1961136b3a.7.1727872569901; Wed, 02 Oct 2024
 05:36:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241001112512.4861-1-fujita.tomonori@gmail.com>
 <20241001112512.4861-2-fujita.tomonori@gmail.com> <b47f8509-97c6-4513-8d22-fb4e43735213@lunn.ch>
 <20241002.113401.1308475311422708175.fujita.tomonori@gmail.com> <e048a4cc-b4e9-4780-83b2-a39ede65f978@lunn.ch>
In-Reply-To: <e048a4cc-b4e9-4780-83b2-a39ede65f978@lunn.ch>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Wed, 2 Oct 2024 14:35:57 +0200
Message-ID: <CANiq72mX4nJNw2RbZd9U_FdbGmnNHav3wMPMJyLSRN=PULan8g@mail.gmail.com>
Subject: Re: [PATCH net-next v1 1/2] rust: add delay abstraction
To: Andrew Lunn <andrew@lunn.ch>, Thomas Gleixner <tglx@linutronix.de>
Cc: FUJITA Tomonori <fujita.tomonori@gmail.com>, netdev@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, hkallweit1@gmail.com, tmgross@umich.edu, 
	ojeda@kernel.org, alex.gaynor@gmail.com, gary@garyguo.net, 
	bjorn3_gh@protonmail.com, benno.lossin@proton.me, a.hindborg@samsung.com, 
	aliceryhl@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 2, 2024 at 2:19=E2=80=AFPM Andrew Lunn <andrew@lunn.ch> wrote:
>
> How well know is that? And is there a rust-for-linux wide preference
> to use Duration for time? Are we going to get into a situation that
> some abstractions use Duration, others seconds, some milliseconds,
> etc, just like C code?

We have `Ktime` that wraps `ktime_t`.

However, note that something like `Ktime` or `Duration` are types, not
a typedef, i.e. it is not an integer where you may confuse the unit.

So, for instance, the implementation here calls `as_micros()` to get
the actual integer. And whoever constructs e.g. a `Duration` has
several constructors to do so, not just the one that takes seconds and
nanoseconds, e.g. there is also `from_millis()`.

Perhaps we may end up needing different abstractions depending on what
we need (Cc'ing Thomas), but we will almost certainly want to still
use types like this, rather than plain integers or typedefs where
units can be confused.

> Anyway, i would still document the parameter is a Duration, since it
> is different to how C fsleep() works.

That is in the signature itself -- so taking into account what I
mentioned above, does it make sense that seeing the type in the
signature would be enough?

Cheers,
Miguel

