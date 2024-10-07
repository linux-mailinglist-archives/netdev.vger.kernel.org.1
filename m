Return-Path: <netdev+bounces-132618-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 35566992750
	for <lists+netdev@lfdr.de>; Mon,  7 Oct 2024 10:42:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4C0F41C221FD
	for <lists+netdev@lfdr.de>; Mon,  7 Oct 2024 08:42:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C798D18BC32;
	Mon,  7 Oct 2024 08:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3hM/k9lL"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CC7418BBA1
	for <netdev@vger.kernel.org>; Mon,  7 Oct 2024 08:41:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728290499; cv=none; b=R2caINODraEoWj3sEiQMYrn6Zczv5nWkqTNgwfUBw76PoIgKxBTbCoYzHfv42fb2HtBl7BA7gy/RvJQl8KSzj4gpP/DlavIG0pQ5TjZHXc5wPIjyBw56XaJQxADDmGk/uY8kWbuR5KazTN8o8EQDgU6K7ePZHLlOqzNNKTRfEms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728290499; c=relaxed/simple;
	bh=lZq9penah7gAuMo7VonFN6z7LH5CuCz+KTWzrVG0Kkg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rQmO/l5r5Cg7KaFsqkkvRLBec139GH1uoF/18w3bgy39mtLx8LgyFR5oz/c/ALrro9h67eZ2LRGKYrqOXP+UkfeQLjIYRLbCrx96D48Mm0gvPIde/WqFGBBOYUXWjddNAwQFUkqXP1vR4L2nkrKzzm44n6Fm9Fw197fkhzJUyyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=3hM/k9lL; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-42cb2191107so35925175e9.1
        for <netdev@vger.kernel.org>; Mon, 07 Oct 2024 01:41:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728290496; x=1728895296; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lZq9penah7gAuMo7VonFN6z7LH5CuCz+KTWzrVG0Kkg=;
        b=3hM/k9lLi4Lrhjpkdhvk7bALNKUdSPjDlAyaNHCY+7KAAW1qvf5B0sKPhZVU+qlHzY
         /TgWNSeETECbzwLv/CqLDctjwyjpub6v90FzdFa/8+pHCH8mP46bLsuqelOYdAbBEgUE
         zLVt9wXC/k/80SRkGiOiEGca2M8w4/pmhss9JCkd2RNEPSJjaD3HmzW33yWQ1KISeiBJ
         /y4Kw5KcH/p9MUny7MAzjm8RswvrJrmliOiUF/415+fBDE2qtXSJryXm1uxUsCTqflll
         9kpM+x6THpwe0t7En1MWDG4qGVhpxwRFmrxRoxD8pdj1RNBr9UzYM9dIsRiNGCc1G9oA
         PwRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728290496; x=1728895296;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lZq9penah7gAuMo7VonFN6z7LH5CuCz+KTWzrVG0Kkg=;
        b=l+mHjIRDpw94ufDDehpkFvHEq+MbhYpA/m6DvyuIL654MMarFzyr0WN6i6zjmZyK/g
         eW6EMbnuZfAtYXoq/3aDih73Dk9g0sgG+ya54p3rCI0cxMIK+oVDK1wKALTQvenppwdh
         laix4eMljngGUIo+iLoELxo5O+zqJRq7MlABAzSPlXGso7kz0bJTlTGZ6VGZoFz7oPcX
         S+BZKX5NtRrVYZusyBhjqgMQJgSLCoP2dSSQV07o6tjJTPXeg0VZYkDHCLRQLhVr7QP9
         7yh5auazWcQTj5wSBGQJLYACs3LWYM+VsiEjcgjmgwO8rVi8zJyBOUM/auh1D8ttlpgf
         57gQ==
X-Forwarded-Encrypted: i=1; AJvYcCXDEhVpVmvEr+jlVC0XHCn5vr1OfTflh5mhtIxv7Gx6VspKa83OabJfvxgNAitVahCjQ4gj1ZM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yweei1808WEY4S7WLLRszcgHw65xfTktP9bbS1H/P6qu9LF0ty/
	SaE9Lg0y0c9J4E795VClSIzbMZk23JpDyek+TGdYWQYqxOPZHqwr9VXF+qRHwF20s5A90Dc3q6X
	odPyG/ws0FaGDX8rAwQO2by/eKQLh0hut5q0KT1v2m29IObgZDQ==
X-Google-Smtp-Source: AGHT+IGTRgHCCYQ9wvmh2HAydK1cwGiHD4ib1IG2CJRk6JiPA1BuIRNRo/7C2CaH7YWebj5QH1G8ucz5efiqpGwNw7o=
X-Received: by 2002:a5d:6149:0:b0:37c:cd71:2ba2 with SMTP id
 ffacd0b85a97d-37d0e7bcdf8mr5314481f8f.38.1728290496403; Mon, 07 Oct 2024
 01:41:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241005122531.20298-1-fujita.tomonori@gmail.com>
 <20241005122531.20298-2-fujita.tomonori@gmail.com> <3D24A2BA-E6CC-4B82-95EF-DE341C7C665B@kloenk.dev>
 <20241007.143707.787219256158321665.fujita.tomonori@gmail.com>
In-Reply-To: <20241007.143707.787219256158321665.fujita.tomonori@gmail.com>
From: Alice Ryhl <aliceryhl@google.com>
Date: Mon, 7 Oct 2024 10:41:23 +0200
Message-ID: <CAH5fLgirPLNMXnqJBuGhpuoj+s32FAS=e3MGgpoeSbkfxxjjLQ@mail.gmail.com>
Subject: Re: [PATCH net-next v2 1/6] rust: time: Implement PartialEq and
 PartialOrd for Ktime
To: FUJITA Tomonori <fujita.tomonori@gmail.com>
Cc: finn@kloenk.dev, netdev@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	andrew@lunn.ch, hkallweit1@gmail.com, tmgross@umich.edu, ojeda@kernel.org, 
	alex.gaynor@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com, 
	benno.lossin@proton.me, a.hindborg@samsung.com, anna-maria@linutronix.de, 
	frederic@kernel.org, tglx@linutronix.de, arnd@arndb.de, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 7, 2024 at 7:37=E2=80=AFAM FUJITA Tomonori
<fujita.tomonori@gmail.com> wrote:
>
> On Sun, 06 Oct 2024 12:28:59 +0200
> Fiona Behrens <finn@kloenk.dev> wrote:
>
> >> Implement PartialEq and PartialOrd trait for Ktime by using C's
> >> ktime_compare function so two Ktime instances can be compared to
> >> determine whether a timeout is met or not.
> >
> > Why is this only PartialEq/PartialOrd? Could we either document why or =
implement Eq/Ord as well?
>
> Because what we need to do is comparing two Ktime instances so we
> don't need them?

When you implement PartialEq without Eq, you are telling the reader
that this is a weird type such as floats where there exists values
that are not equal to themselves. That's not the case here, so don't
confuse the reader by leaving out `Eq`.

Alice

