Return-Path: <netdev+bounces-132420-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D4726991995
	for <lists+netdev@lfdr.de>; Sat,  5 Oct 2024 20:37:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7C3181F21A95
	for <lists+netdev@lfdr.de>; Sat,  5 Oct 2024 18:37:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52E4715C15C;
	Sat,  5 Oct 2024 18:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZVI054uq"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E894515854F;
	Sat,  5 Oct 2024 18:36:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728153420; cv=none; b=JOI7jWQXo4h/5UNcz6dLVfSinVxym4zZWWcx3cV/KPrUgSpx6u+aNp5COtF5hMHNlcIDAsSdwAmNIJcXRFN2ZYA0oYMqN5qdyk6HcIW6TxSY6JyM7uO6HG5vzh57wbhxe1TLvRzixj73+DQeSmVEJoMGDIPpPQ1Q6/de1Qf6I7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728153420; c=relaxed/simple;
	bh=DjEkgMsE+q9McXLoeQL5ZBzLN/XUBH8NjpwqeAri/Pg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qrI7q8fwlkdKzgbVD6c9T9mD0RN7evQoIUHLEoTO4xcdqa28VMpjPYBS11S8ao8P0eWDhkAJ/Ry5JFh6s5C6YF5kUQKhxw9FWfUK4vf67Y+LwF4/JPdmOZCSMQLGscWEhFZMuA1xWerqXxrjrh9uG6ToigAkVUoP1N9LgxmiRQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZVI054uq; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-7e9f98d3234so26805a12.2;
        Sat, 05 Oct 2024 11:36:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728153418; x=1728758218; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XgGCb9pstbd7GewNm2jOl0ti9D6Uvz86zDJOdOtYfC4=;
        b=ZVI054uqsc3HNP2dZu+yx2lRhs+kDKGCXlxzEdfRE6nzYFLSoJw2y3livCxUxpc/HE
         jeucGjjnwaBBlZ7MhrAO8CWTMd3Qo+sWLukpHGrwjXWZJBoFwPzsMB0cOYqoSCNaqtul
         gvURurRLybqcMSIb+zf9E/0n52qwU6Hkc02Hq1q+kgC7pc/oWmglQ/I0Xd/61MhJQ00r
         ZPP5wM93by3TjXMcwNM1h3Ca4I7aw8kDg8sWZvoPsLuNPJ6MAFgykVIZlz8VRra9kR/v
         8fbTj1/r+R/JzGDOfh+2vLJ+TpFk4LolbFNkkpw03JZV9hKRSXpkE16BPOWg8quCUdIF
         B2cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728153418; x=1728758218;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XgGCb9pstbd7GewNm2jOl0ti9D6Uvz86zDJOdOtYfC4=;
        b=FUy4pSplTF5lz7MsaigdHIfSF5AGDJh5T3GX3IVqx6ZASw3B8rU628+XShnC+2gEag
         eTxmlp+d/Ao2Tx+Ks8BBhNosDpN6outK/YdtVbFkcrzzN3WNEyAbjYQ1jhdVkAvSbbBJ
         +8SurMdUzMcm5gGK1AY0lpPPkay0ceXLoUyWOjJqQbVLm2rLLpO8h+MqaI3LOCioR4au
         11MckjfprMN2kc4aGNk7FEZwakoOwo8SPbjGVLNxqdFvJ5v+nSn+JLUA2RoX/7rGucfW
         c67NypBf49yO32vlXcc/en1Xxz+xokHw7ciK/t/q7XY6co4co6QPCXZr9lV8Ky0vnzwJ
         QQIA==
X-Forwarded-Encrypted: i=1; AJvYcCUQlvzkbto+Q/dlagwEQTGba9QfClWwUKahX3fMhba15O/dUKAilOp18oz3mdXf5rGqdRXH5wXXHFJdWRs=@vger.kernel.org, AJvYcCW49c/3wS0B92OdEnKXytcJwnYNa2kKKUQ6tbLPbNuISz0Mct4pDCH0+NMVD4Ani4Szo9N0Bi+/Alkv1osh7QA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyScY2MrUI1jZNg3XDvoA7IIVHI/DFWRD8Y2glGpdYm/AIG/gQW
	aGP411WHXbb+0/x9NQieO30A+hS0royPJ4Xl28r1gHQLc4iu7J+XRGJeoncImtUAZiPv6fWb01P
	Ikjmc0CYrBuHOhsDHJ8w+98n6pFc=
X-Google-Smtp-Source: AGHT+IGn67vfCMqsciAWLmMbUIQzxAW5Sx2be3jHpfFc2Rgror/hqRCKtd5k7MCxQetcHaBWaWAEzJyhULbihU9D2fI=
X-Received: by 2002:a05:6a20:72ac:b0:1cf:37d4:c50b with SMTP id
 adf61e73a8af0-1d6dfa3a7c2mr5055200637.4.1728153418098; Sat, 05 Oct 2024
 11:36:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241005122531.20298-1-fujita.tomonori@gmail.com> <20241005122531.20298-4-fujita.tomonori@gmail.com>
In-Reply-To: <20241005122531.20298-4-fujita.tomonori@gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Sat, 5 Oct 2024 20:36:44 +0200
Message-ID: <CANiq72=YAumHrwE4fCSy2TqaSYBHgxFTJmvnp336iQBKmGGTMw@mail.gmail.com>
Subject: Re: [PATCH net-next v2 3/6] rust: time: Implement addition of Ktime
 and Delta
To: FUJITA Tomonori <fujita.tomonori@gmail.com>
Cc: netdev@vger.kernel.org, rust-for-linux@vger.kernel.org, andrew@lunn.ch, 
	hkallweit1@gmail.com, tmgross@umich.edu, ojeda@kernel.org, 
	alex.gaynor@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com, 
	benno.lossin@proton.me, a.hindborg@samsung.com, aliceryhl@google.com, 
	anna-maria@linutronix.de, frederic@kernel.org, tglx@linutronix.de, 
	arnd@arndb.de, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 5, 2024 at 2:26=E2=80=AFPM FUJITA Tomonori
<fujita.tomonori@gmail.com> wrote:
>
> +    fn add(self, delta: Delta) -> Ktime {
> +        // SAFETY: FFI call.
> +        let t =3D unsafe { bindings::ktime_add_ns(self.inner, delta.as_n=
anos() as u64) };
> +        Ktime::from_raw(t)
> +    }

I wonder if we want to use the `ktime` macros/operations for this type
or not (even if we still promise it is the same type underneath). It
means having to define helpers, adding `unsafe` code and `SAFETY`
comments, a call penalty in non-LTO, losing overflow checking (if we
want it for these types), and so on.

(And at least C is `-fno-strict-overflow`, otherwise it would be even subtl=
er).

Cheers,
Miguel

