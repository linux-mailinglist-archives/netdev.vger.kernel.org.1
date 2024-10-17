Return-Path: <netdev+bounces-136477-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 62EEC9A1E7A
	for <lists+netdev@lfdr.de>; Thu, 17 Oct 2024 11:33:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E2270B207E3
	for <lists+netdev@lfdr.de>; Thu, 17 Oct 2024 09:33:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A05D31D88C2;
	Thu, 17 Oct 2024 09:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="e/m8G4ny"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45E901D8A16
	for <netdev@vger.kernel.org>; Thu, 17 Oct 2024 09:33:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729157606; cv=none; b=cyDlwLOFZAn1qAbhok4p8tbMfbfXEpRfH78HnLobYUroDLpAL1juZPPQzogvbpFvCeZ5tbSvah4bVDwPEQrbEIWptmBTl31VPGM1lM+SQm/Peh+IgngAdPH45Gjeey+CLRe2Cr+igSrCD2veaHXG4ZdQaSzbyBkMnLfHF8RaOjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729157606; c=relaxed/simple;
	bh=eAO4OpzJK+ZqOZ8YhgV52/JYGCtHP8kWPtUgBTS6oeE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=N/qnOthfv7p5y71JDVw3PKRXucq2G38uPdipuWPeRKR/gHaKylfh1KFLdTifY7Enw6jKfs9nyE0jgZWUvDR1dWWfSGAUIEJwFzcm+LdzAxClgXNhepsS9Bbami82uelHJUV77lesC+wlemUhMgsoi4ArB4zmp0nb17IxPVINgl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=e/m8G4ny; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-37d325beee2so352174f8f.2
        for <netdev@vger.kernel.org>; Thu, 17 Oct 2024 02:33:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729157601; x=1729762401; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3aCF8qbJBg1Dps0D/CUhTqVXgsROfsWWZhphpElZXnQ=;
        b=e/m8G4nyU4TsNR1qulWewsFaJGWpMoB7aH5atbHjthLH6OlnpVqp3NmhvMeJXMEJGQ
         plPTfTX70h6xxcla4GqpiVZ4A8vI6xwHyON3ilDPSvDdqs0V8DeV+7v+nkExsJKFkfyc
         e9t91EXQM0ksoEof04C0IVXmAEwLXbO9fVDNP1CTvAxdTrTwbCkM/cSUgLZkyBFcrm8/
         hh6kT9kpeW5VMgi/c1E1bxz32yi4nVhaHfAbGlI2cPHMuq76vPjggBRfxnyjV+pL1z7e
         84kI1NKpxmle4e/m9FmjjcqYqxQsoH+Y040iM7v7SI4sFcvoy1jaOieU0NaK298H9tus
         kN8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729157601; x=1729762401;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3aCF8qbJBg1Dps0D/CUhTqVXgsROfsWWZhphpElZXnQ=;
        b=qopQhjc/HoT/byB4WrCfJv/lcSTGY0C1Rxrrq0kJux+I8+lU9YIdPC3+rYehUYPd/n
         CpUIBW4W/3cYFqRQW+yQHSiXQMhMIAujLhOAJlW0SIDpDZwF/QwUY29UIpPrL/4z6PSA
         Or0YWvhP62CB6vYCaQoKN7fnGhywzyyEV4r5BbyNNDZyOTtRaC+rFecCVDcpJA8Ui15G
         yOkpbK0gQzLhIiM4qFaen2FjqoXCmFjIxGao37FB/dyPHExv/J8eQXNyib1wnJcPWxFE
         ZFBNBNxmhOMwZYyKFsR7s1zk+Ad/RGx2zt7NoMre2CBx6EELAztsj2XtMv/A9XDZjYzf
         Upjw==
X-Forwarded-Encrypted: i=1; AJvYcCWt0sFJyoyEuNler8lM6szWfZmKVOCHOtQjBnCtLTcyBdWYi8bH/1HAyqSqujU+SjwaLBwW4sk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzGNY0eW5w3LpdDRuCpQZOgqOJpg9ZYjWYMH94qHOH6nBJtiYDL
	ZowqHu9+IGj8b6TioGFlQV5JEZPafckDh1m+HMi606ubsczzX9NeT2nIU2ShfvWhNs/Sq9tcyk2
	g6eogmcR2vNw6mArgzIgDSXos2FYb6xsxUxgg
X-Google-Smtp-Source: AGHT+IGrjgb4tg9+baFKcG84sjc0/H/bT6AHZ0SjBlystoLYnCAsWx0ASGEVpLgSEq/buwud93hxrF4rLN4G3ObBMe4=
X-Received: by 2002:adf:f9c8:0:b0:37d:415c:f27c with SMTP id
 ffacd0b85a97d-37d5ffb9969mr11235445f8f.38.1729157601306; Thu, 17 Oct 2024
 02:33:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241016035214.2229-1-fujita.tomonori@gmail.com>
 <20241016035214.2229-5-fujita.tomonori@gmail.com> <ZxAZ36EUKapnp-Fk@Boquns-Mac-mini.local>
 <20241017.183141.1257175603297746364.fujita.tomonori@gmail.com>
In-Reply-To: <20241017.183141.1257175603297746364.fujita.tomonori@gmail.com>
From: Alice Ryhl <aliceryhl@google.com>
Date: Thu, 17 Oct 2024 11:33:09 +0200
Message-ID: <CAH5fLgjHf3Z5HHOLnzZkk-Q5MOwz_57LQc6scr9yDy1j89HSCw@mail.gmail.com>
Subject: Re: [PATCH net-next v3 4/8] rust: time: Implement addition of Ktime
 and Delta
To: FUJITA Tomonori <fujita.tomonori@gmail.com>
Cc: boqun.feng@gmail.com, netdev@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, andrew@lunn.ch, hkallweit1@gmail.com, 
	tmgross@umich.edu, ojeda@kernel.org, alex.gaynor@gmail.com, gary@garyguo.net, 
	bjorn3_gh@protonmail.com, benno.lossin@proton.me, a.hindborg@samsung.com, 
	anna-maria@linutronix.de, frederic@kernel.org, tglx@linutronix.de, 
	arnd@arndb.de, jstultz@google.com, sboyd@kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 17, 2024 at 11:31=E2=80=AFAM FUJITA Tomonori
<fujita.tomonori@gmail.com> wrote:
>
> On Wed, 16 Oct 2024 12:54:07 -0700
> Boqun Feng <boqun.feng@gmail.com> wrote:
>
> >> diff --git a/rust/kernel/time.rs b/rust/kernel/time.rs
> >> index 8c00854db58c..9b0537b63cf7 100644
> >> --- a/rust/kernel/time.rs
> >> +++ b/rust/kernel/time.rs
> >> @@ -155,3 +155,14 @@ pub fn as_secs(self) -> i64 {
> >>          self.nanos / NSEC_PER_SEC
> >>      }
> >>  }
> >> +
> >> +impl core::ops::Add<Delta> for Ktime {
> >> +    type Output =3D Ktime;
> >> +
> >> +    #[inline]
> >> +    fn add(self, delta: Delta) -> Ktime {
> >> +        Ktime {
> >> +            inner: self.inner + delta.as_nanos(),
> >
> > What if overflow happens in this addition? Is the expectation that user
> > should avoid overflows?
>
> Yes, I'll add a comment.
>
> > I asked because we have ktime_add_safe() which saturate at
> > KTIME_SEC_MAX.
>
> We could add the Rust version of add_safe method. But looks like
> ktime_add_safe() is used by only some core systems so we don't need to
> add it now?

I think it makes sense to follow the standard Rust addition
conventions here. Rust normally treats + as addition that BUGs on
overflow (with the appropriate configs set), and then there's a
saturating_add function for when you want it to saturate.

Alice

