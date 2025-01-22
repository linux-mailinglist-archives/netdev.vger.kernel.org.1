Return-Path: <netdev+bounces-160277-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 97E4CA191C9
	for <lists+netdev@lfdr.de>; Wed, 22 Jan 2025 13:52:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1683F188C90E
	for <lists+netdev@lfdr.de>; Wed, 22 Jan 2025 12:52:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A48E213E84;
	Wed, 22 Jan 2025 12:51:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3DfAl4ew"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EC4E212F82
	for <netdev@vger.kernel.org>; Wed, 22 Jan 2025 12:51:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737550296; cv=none; b=p8wUlzZXly7DYxe1DYtXoNIAJRUOgRGNb0evwif8ImOge2b64hWllElXzKe1XrNZpiSB+VRI2E5MdGIMAsJHBmUES21Bp0e3PsgdVmM58xfik+ZhA86k77pdP+QB+Dy0vhJKOuF6vEK5RC0kY9/mkgPUAhddx9QgjYjYFdP6k/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737550296; c=relaxed/simple;
	bh=WuIfgzJLubkFFcG0XZPIrTud+kCmGcgshhlFKA/BFmo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pocxvGOLnRS6TQBXK4we9ll99Cuwn+EzRKzz/2lTCRtR/y1o7SuGia5x8EAtGu/2qUn72tM20W5OxAbbV25k552v8i4Z1G0GR63jwZmFHe6TxVlqFtUYFeRmX5W29h/ubfJaK6zIvLH68brtOQ28nLmkebCmriI6AcRdvA/IM6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=3DfAl4ew; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-3862d161947so3672278f8f.3
        for <netdev@vger.kernel.org>; Wed, 22 Jan 2025 04:51:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1737550293; x=1738155093; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d7ot6B7zzXcstNMqfsx3GOJ1dE3U7QbQeYxc/uuhDCc=;
        b=3DfAl4ewI5jZnX9TT9+ylRIabMMRbIIrYqgVul18BRO4b3u5j7b9AwcyfEqZHhq5in
         R/MIaM0tm/PggC/Tm1bN4oKsBQjDwCN31CfF2Y8gLN42H2i+cedhnhe5RaDIMjFHcl1a
         pvoF9p2PJ/IZRQ4CE43Oh3ab0VogIrM4MAdanwF62k8MEJdyb/SMlxTznHvKt4r67uaj
         IPvECtnol8OpuRVMQDqEJo1xhxdPgCqpjyW7ndR2aBJstlCR4lOh2v4K0DZVpNMA+bVm
         O4+Cp2aBxijd6Lc7lbormg6Rc2f9UpOKvAq6uR2DQWSpvODjSlQGDeaowaLc9YT0qBsB
         h25w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737550293; x=1738155093;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=d7ot6B7zzXcstNMqfsx3GOJ1dE3U7QbQeYxc/uuhDCc=;
        b=J8vcCPTJmlgiXqbJS/GsiBbT4H9HkfgY/KgNhP+5G9zBIlVBvzT6WgsdJjWEtV1crb
         gaLur+6S44lpjU8e6hmA6Wl1yAk5Ih+sW+Wlwuiskv0tZtavJ8WEWBUi5yiLwHgzvIjn
         f/VV+uB8uKCFBVzVVCAv8MGM1h6TF9atMJm6vsuzE6L6LF9vwWQlllJ5oiZTUkhRDETq
         vIVfWoYdkMJEJkWzhA7a22QlYgME/xfEdFIcqT7UJmPLp6aL3vUCz/zbtluf9Tv6BAT+
         aMsKGa2ZKE9jdEOAKZsyBd29UJA6zXmEIlmfvThCChFZ99PJoax5sv7BF4WdRTLGtEyS
         BSBw==
X-Forwarded-Encrypted: i=1; AJvYcCWETyrEKQsehcdIrDb2I1AmiO0XNVnqHQ5IfTK3dBi8jg1xUnnlEHn0PUVKyoNpIgp0pSrBGTY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwIgmFfb+3AXejGD46oVF16dqjS+SaPAOToA3fMC7Wv9gNwqJuF
	3LeBuDMbYLwclCGuwaNRh9gI/hFuI3uouK3OUKVoeeaTsQu7AAOkLE64GW3ZGvX/S+eJ9KZuqJF
	Pa1WStHhdwM8kr2ZVtLn6j3o8CMTEmPerJoX5
X-Gm-Gg: ASbGncsUY84e+6fd64rnInMvGpsDy+Hnyp9HdUSbAmst+TmqC+XRwujZES2BClPgy0/
	Ki3SSx7No9tytCHOEhf0qH7C+yCPPPmzkPpYufzSyP0dT/dx/dG6F4dFl/7lLkw8SvphrcQXNJ8
	6I4nMv
X-Google-Smtp-Source: AGHT+IETuMz4ANZc014GGAv4GmkQ55tzGkCBkcKt+IXPxqtOKWlugb/rne3qxtIdLgpuiOw2zY+grZZOTQfM6ds5iTM=
X-Received: by 2002:adf:e607:0:b0:38b:d765:7046 with SMTP id
 ffacd0b85a97d-38bf56855dbmr17570038f8f.33.1737550292782; Wed, 22 Jan 2025
 04:51:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250116044100.80679-4-fujita.tomonori@gmail.com>
 <CAH5fLggz0t3wTxSNUw9oVBDbR_PSWpQysaSSt6drd7vw8AXQfw@mail.gmail.com>
 <20250116.210644.2053799984954195907.fujita.tomonori@gmail.com> <20250122.214920.2057812400114439393.fujita.tomonori@gmail.com>
In-Reply-To: <20250122.214920.2057812400114439393.fujita.tomonori@gmail.com>
From: Alice Ryhl <aliceryhl@google.com>
Date: Wed, 22 Jan 2025 13:51:21 +0100
X-Gm-Features: AbW1kvYM1MR1sad47pV-isTiZaehuSe_lylJGWPshjV2Brpy--0aog_d8SfVvmY
Message-ID: <CAH5fLgipKcAk55r-KCYTh4JTooGhAv42kUU_L46=g-tUSo5n+A@mail.gmail.com>
Subject: Re: [PATCH v8 3/7] rust: time: Introduce Instant type
To: FUJITA Tomonori <fujita.tomonori@gmail.com>
Cc: linux-kernel@vger.kernel.org, boqun.feng@gmail.com, 
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

On Wed, Jan 22, 2025 at 1:49=E2=80=AFPM FUJITA Tomonori
<fujita.tomonori@gmail.com> wrote:
>
> On Thu, 16 Jan 2025 21:06:44 +0900 (JST)
> FUJITA Tomonori <fujita.tomonori@gmail.com> wrote:
>
> > On Thu, 16 Jan 2025 10:32:45 +0100
> > Alice Ryhl <aliceryhl@google.com> wrote:
> >
> >>> -impl Ktime {
> >>> -    /// Create a `Ktime` from a raw `ktime_t`.
> >>> +impl Instant {
> >>> +    /// Create a `Instant` from a raw `ktime_t`.
> >>>      #[inline]
> >>> -    pub fn from_raw(inner: bindings::ktime_t) -> Self {
> >>> +    fn from_raw(inner: bindings::ktime_t) -> Self {
> >>>          Self { inner }
> >>>      }
> >>
> >> Please keep this function public.
> >
> > Surely, your driver uses from_raw()?
>
> I checked out the C version of Binder driver and it doesn't seem like
> the driver needs from_raw function. The Rust version [1] also doesn't
> seem to need the function. Do you have a different use case?

Not for this particular function, but I've changed functions called
from_raw and similar from private to public so many times at this
point that I think it should be the default.


Alice

