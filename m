Return-Path: <netdev+bounces-215673-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 80B67B2FD93
	for <lists+netdev@lfdr.de>; Thu, 21 Aug 2025 17:00:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 75FA3189777B
	for <lists+netdev@lfdr.de>; Thu, 21 Aug 2025 14:54:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53554279915;
	Thu, 21 Aug 2025 14:53:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YHJwkZF0"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7B44469D
	for <netdev@vger.kernel.org>; Thu, 21 Aug 2025 14:53:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755788032; cv=none; b=gzpMcvo27nQZJSDbv9Yc1ByhjVVNppZccDZ5Ly+U3OI6xh5ar+6XGwnUr2yvtxUyHa44Y8F6gJYUeoJqbPWLNVIWsNbt6VpZy5b3M/VKaAnEg4mZjFCeB52oshhbWmzndMR/rR20VTkkK7E+5XhEQB8fKeGoY1JoID4L+lnvXJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755788032; c=relaxed/simple;
	bh=2+veGePIL+6Hu8VhYNM5Ayb8HV7i1KqWM0Nv0uX69E8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eKhvj6Sazyx2aLkUnkgf1+5taJ0A9brZzB/AntjerIctBHJLtNaRO4MxDHt5f30ZEQWCRSvwH1AUU0RfjuMvyfRmgNonrvweM8zIFaxiGTurQnBrDQS6d6bXX4V5j0qdvMU8VLUacm9SBPwR6BnbSAamZqPDNAfs8ubI1Gu8Ozo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YHJwkZF0; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-61a99d32a84so2105519a12.1
        for <netdev@vger.kernel.org>; Thu, 21 Aug 2025 07:53:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755788029; x=1756392829; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2+veGePIL+6Hu8VhYNM5Ayb8HV7i1KqWM0Nv0uX69E8=;
        b=YHJwkZF0P6kbn0en4X4laNLuF/Q4mrX3x6jhJDodIKDahN/m7CHVtbqTzmDQrkdNH3
         tjD+PqZqZf2MR48T+MSP1zSfP3amK5w4/YbtJVPEr4s+/xDQ06X9SYEN7WPNV+Yk+qtY
         b6b3gElVuhe9zmPtb+h1k4uPangsbyZAfY6IM7VzINjZNpQ27ZV/k50X9RBzEgHwokTN
         BbCuhFmpVaZJvUctIDZ0nkn8/ge9RpvxZvRuwQp0jkVKD608dnPDoqGxncyeFJrfVsyO
         o46xUXyuB3KscUs66mYjEvd1IttJJBtTNMdUjzwKNlYs04bZkIWnG1ZZM3Sznwo/RQEB
         /D6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755788029; x=1756392829;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2+veGePIL+6Hu8VhYNM5Ayb8HV7i1KqWM0Nv0uX69E8=;
        b=u+RsLJrT7yQjpPGii/fxfLqQ3je0pYZZPeEIcbQtcw+zGbU7qGkykU3SpHijxG+lsA
         wdzTA5KhuowjHmSzz3N2ZqYfHGl2VGM3AFNC8lSVnIT4unkZWh+WUHcqem/7bwVu/yEo
         676UKdsgfCBP3UDwlKiV9wgmoq2UvyPs1k4FQKJapKLdberxgw7XKZiyhOW15p0Y/+L1
         KRYY5AQ4oxaJiiCwHUYjNaWG8I0oiTMy0gt+RfOKTlb8d0p5OwyBsgmcstl7+UboxXYI
         jZuZspz/T1An2a2ygCOWcoKZ8pE2msxTptD5LdKq/2FCI1k4TwsM3G9+mLP0i4oMM3wg
         DTHw==
X-Forwarded-Encrypted: i=1; AJvYcCV/kHcY2M0nC+yfLHMVipcxb5jAaryRNQTn+yWiZk7cnOR4aJh8H6tF78OzH7KL2+ElnIfdlvY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxXFvWij+231KtI2s9zGv5m39Iof2tVVYxquYSpiaNB2k57M84n
	VFmI+0uI6mBkVdjLXYUB2OJNQLdm4o4GO5OKJ/QbQj0auB54iEC48EpwDJr7NhUgSWw/vgv1P3n
	/0RNGzOsubnuSP1o1oBo2Kj45197KC1M=
X-Gm-Gg: ASbGnctk9uY0QqppfQyDEwjptCMzLhPQtDtrUepaYkZMSGdjEvnXsiVvS9IbBKeG5Bk
	ilFxzzmIlAom+/AkRpCY+c8aEjRK+9UQLOrnOpcDKXohVTq4dEcW9B8F33xlZr1nZLvr9BXBNZ7
	Cb6Zn6IP8VN+87x3ol4Nd0QXrWwW0cei3q2H9HPSMTPE13/C9+tHQrqbaB0peFuPmSZLGjwGWlU
	8zMAABq
X-Google-Smtp-Source: AGHT+IFLLTthZ2nYLs/uOo2Wh3/cPlKe9N4kOHkrR57iIZ5nANIAQpO6gW9zWr3e1D+BAcya/bNiTMukTpPOGjW/pO8=
X-Received: by 2002:a05:6402:4614:b0:618:65d2:c037 with SMTP id
 4fb4d7f45d1cf-61bf9861129mr2057577a12.2.1755788028731; Thu, 21 Aug 2025
 07:53:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250820025704.166248-1-kuba@kernel.org> <5bba5969-36f4-4a0a-8c03-aea16e2a40de@redhat.com>
 <20250821072832.0758c118@kernel.org>
In-Reply-To: <20250821072832.0758c118@kernel.org>
From: Taehee Yoo <ap420073@gmail.com>
Date: Thu, 21 Aug 2025 23:53:37 +0900
X-Gm-Features: Ac12FXwIDvwADx7pLXAzjUkERTdlr0sPWzm6exo2eLRo1aQsCsNkq3ACr0fAxQI
Message-ID: <CAMArcTW7jTEE1QyCga5mpt+PLb1PDAozNSOwn8D7VwNYBp+xTg@mail.gmail.com>
Subject: Re: [PATCH net-next 00/15] eth: fbnic: support queue API and
 zero-copy Rx
To: Jakub Kicinski <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, edumazet@google.com, 
	andrew+netdev@lunn.ch, horms@kernel.org, almasrymina@google.com, 
	michael.chan@broadcom.com, tariqt@nvidia.com, dtatulea@nvidia.com, 
	hawk@kernel.org, ilias.apalodimas@linaro.org, alexanderduyck@fb.com, 
	sdf@fomichev.me, davem@davemloft.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 21, 2025 at 11:28=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> w=
rote:
>
> On Thu, 21 Aug 2025 09:51:55 +0200 Paolo Abeni wrote:
> > Blindly noting
>

Hi Jakub and Paolo,

> I haven't looked closely either :) but my gut feeling is that this
> is because the devmem test doesn't clean up after itself. It used to
> bail out sooner, with this series is goes further in messing up the
> config, and then all tests that run after have a misconfigured NIC..
>
> Taehee, are you planning to work on addressing that? I'm happy to fix
> it up myself, if you aren't already half way done with the changes
> yourself, or planning to do it soon..

Apologies for the delayed action.
I would appreciate it if you could address this issue.

Thank you so much!
Taehee Yoo

