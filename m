Return-Path: <netdev+bounces-147194-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B3F219D824E
	for <lists+netdev@lfdr.de>; Mon, 25 Nov 2024 10:33:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7AB49281CB4
	for <lists+netdev@lfdr.de>; Mon, 25 Nov 2024 09:33:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25A1D190079;
	Mon, 25 Nov 2024 09:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="xpPWtEfN"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 921FD186E26
	for <netdev@vger.kernel.org>; Mon, 25 Nov 2024 09:33:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732527184; cv=none; b=BZtb8xG4ld+JUVeM8KbopsgZtW1lrumpO7LxF68TnCqF54dcg6FY+Ijst8M3SR6RawVQzF+/YGPpjj1C1WiK85K0fZDJ/y9vcdvBB/xKd/uLVaIiRtq9WXk0Tr+ALr0zEmUiFqGZQnQm4DVivRH53v+H4mx5QgvBPAS8SciXgLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732527184; c=relaxed/simple;
	bh=iJhCiDk4FV6a8jhD1x9FdWaVImExu0N+arblA6KpRYw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HJ8DKy/ITnPed46+7lJ8LQ044W5gxBRtn8swKCcBCpSBiBxk3mQPBa+8sy9jVZJmOWlHW9DDfulQKG0/d8CUwYExy/W3VWg/CqqWYHS827x0W7r8yAriw0iwESoRs4yGvI84V138lUPcu1SSRX8cx5dB0jBT4P7yD7HJUZjcGL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=xpPWtEfN; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-38248b810ffso3188120f8f.0
        for <netdev@vger.kernel.org>; Mon, 25 Nov 2024 01:33:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1732527181; x=1733131981; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iJhCiDk4FV6a8jhD1x9FdWaVImExu0N+arblA6KpRYw=;
        b=xpPWtEfNNIMIc/BxU2o/JUCYznhRLaFtwbHSuXHN15ZjDjF5YmwazW6QrzFJ+qNNWm
         LNm0wpPGZdWkaf2Qm49D6sJppByb2ErHouhJDGn/RDsN0VJZ+Wtfz8a0EL5EXr+4W9cI
         dfjsvTGTN+o/9KGfIE4pB1I+hAFA76HFDQB/tNcQUb14EN3sZGzyuxL2fiEEmmiNsQ8/
         RNZuYCMcU+jNYmWPiWHZJHxOWTWLMf8bSP/AqcpsMWdW8Zo1I8ooU5TGPjdoRuJfAdz6
         NbdmQa+2ywHl6hMXS8IgckChGjljc2GMO+Ln6w5F4BUgKA7h+bmr5oatBt4VwLA8Z+mZ
         pEkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732527181; x=1733131981;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iJhCiDk4FV6a8jhD1x9FdWaVImExu0N+arblA6KpRYw=;
        b=h/22rNxQFmenxucBOzaMEDugraslQJZ3G8DYo3JniO8XP5PS/CcMjDktiAKE+JCnYa
         6dlSuCROPtZeTEJpB+OY1wOZXKDgpWQLxzVtJd7NVeT/Mwa0XgMwgGFYGvqL08CshvXV
         A6ZE5CTAWkI3jP3dVwrMVMzn3mpowF/HHfwpveRFIcRpnoL69G86+cpdcdcbsBtFh865
         myGVquTp2EDWVXHGxr7IMriFc+Cc6zyUjcQwOW9jDKBNfFF5IYEtR/Y7cmiYlsWkCpqs
         KsppgHTGZFrarVqhSTQGGLgprmwi4l9+4CmtAIvrGpXE1qe+6oqtuMZWcJ+TrrTefkmE
         beuA==
X-Forwarded-Encrypted: i=1; AJvYcCWyvH33mrryp8N4liU3eBSGK5Xr5pZBA6jqJB1Of1Q9hKjgKQUDmz0W6v3U5mL3kWTIYwUNd5w=@vger.kernel.org
X-Gm-Message-State: AOJu0YyfZcNNvBrSGPiHURQjAD1ojFLoMQ3Q8cxschT0kj4v+1at2KK7
	tx2ufiKLRFIAzbKgDNWreKrmSXrRDVNbnyP4//aI3eXUgoLX4jtN8VmD4dbsYVjP4+//gzdhBxT
	6XWiajlrHHPJHIkCyYNBRwVW2QBXBBLJbOZhW
X-Gm-Gg: ASbGncvoDkJYg7U3kZyALDS2fgUi630w4itHZqf3zzWNmAjxU//dvoTW2og/36yJghH
	6OIggkkY6yerKv1R1wtI6rf73WINZVm2N45A88jdVq/QdQcxoCcv8b76CVuWoNQ==
X-Google-Smtp-Source: AGHT+IHk2ePzXk7rFVIBNN5xp9LHxdFZTmA+UEnsClr0r4H+EBABd5CJ17K9erfSX4yaztpTHbj05WlX4/9ds8MqiC4=
X-Received: by 2002:a5d:6484:0:b0:382:4ab4:b428 with SMTP id
 ffacd0b85a97d-38260b452famr8130184f8f.8.1732527179739; Mon, 25 Nov 2024
 01:32:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241123222849.350287-1-ojeda@kernel.org> <20241123222849.350287-2-ojeda@kernel.org>
 <CAH5fLggK_uL0izyDogqdxqp+UEiDbMW555zgS6jk=gw3n07f6A@mail.gmail.com> <CANiq72nKgj0n84Q76FSsPSeaupwgEKBT0GQbO8m-KHKZb103gg@mail.gmail.com>
In-Reply-To: <CANiq72nKgj0n84Q76FSsPSeaupwgEKBT0GQbO8m-KHKZb103gg@mail.gmail.com>
From: Alice Ryhl <aliceryhl@google.com>
Date: Mon, 25 Nov 2024 10:32:47 +0100
Message-ID: <CAH5fLgiUwnNE9fP8SFOBY1OeKDhb8NGPSRjSxQaL5fAYb7nAWQ@mail.gmail.com>
Subject: Re: [PATCH 2/3] rust: kernel: move `build_error` hidden function to
 prevent mistakes
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	FUJITA Tomonori <fujita.tomonori@gmail.com>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Trevor Gross <tmgross@umich.edu>, 
	rust-for-linux@vger.kernel.org, netdev@vger.kernel.org, 
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	patches@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 25, 2024 at 10:23=E2=80=AFAM Miguel Ojeda
<miguel.ojeda.sandonis@gmail.com> wrote:
>
> On Mon, Nov 25, 2024 at 10:14=E2=80=AFAM Alice Ryhl <aliceryhl@google.com=
> wrote:
> >
> > You could also put #![doc(hidden)] at the top of build_assert.rs to
> > simplify the lib.rs list. Not sure what is best.
>
> Yeah, not sure. We used outer attributes for the rest of
> `doc(hidden)`s, including in the same file, so it is probably best to
> keep it consistent, unless we decide to move all to inner ones.

It might actually make sense to move all of them, I think. I find that
they make the list difficult to edit.

But feel free to pick whichever one you prefer for this change. My RB
applies with or without it :)

Alice

