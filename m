Return-Path: <netdev+bounces-137982-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F15729AB5B6
	for <lists+netdev@lfdr.de>; Tue, 22 Oct 2024 20:06:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2C0931C231A6
	for <lists+netdev@lfdr.de>; Tue, 22 Oct 2024 18:06:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 554341C9B6D;
	Tue, 22 Oct 2024 18:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="XWUDTHoD"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E4741C2441
	for <netdev@vger.kernel.org>; Tue, 22 Oct 2024 18:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729620368; cv=none; b=rw66um8qV+FyXm0MIJYzVaV44JopiIv/RslfWtkfKyOgsVcMuIQpZ+kNt6AFUBKhZ4cxg8zScbH0hHflBeR4mSN9WOfbFoWhD5bA426E+7iN/GYAvjj9EWy3VT3PnwevMXjaML5Q7kmNFks6N8k7bF4jRnnhZQ8mmw23xdRyEFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729620368; c=relaxed/simple;
	bh=YF9SAvtg72qz5VeDGp1dSDVf83WUSfxDx46MjbAP9vg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ha395k3RarQTDhWROWVoBOPzHVIXoXWi6ouPJ13SAZnPrzsPgij1quRrEn1/VhtABzlHrFlH8h5WRBpF/5oyKHjnDRIBmCDLWjPIMxHh+rhZfVlce2M4XsaqST1Fm3Ab8M3AOaSbWfCxERGnskJ0a3e3+H5x6JcDO8ttDlEhmVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=XWUDTHoD; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2fb587d0436so58279161fa.2
        for <netdev@vger.kernel.org>; Tue, 22 Oct 2024 11:06:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1729620365; x=1730225165; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YF9SAvtg72qz5VeDGp1dSDVf83WUSfxDx46MjbAP9vg=;
        b=XWUDTHoDFdoyUKU5i418X40Moc+15WIlsctof0GW2un5JuCbQNh8HG4ULMaHajsOWK
         ca2m0tckqGnP6ZXK/5qtQCEZyUdl/HG4rGYjWVPO9id6hpSg9ew9oaB1WuvUAvTJU9kv
         nlhFv4TM/9HVf/mQTegW2LRmaWMNC47/Eoxpg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729620365; x=1730225165;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YF9SAvtg72qz5VeDGp1dSDVf83WUSfxDx46MjbAP9vg=;
        b=DUXSW46uQB/C5JPpLcD+6mjMMjmvj2O182+TC2J0wSLgUGGqnO9emrTyOBEhOaMLI4
         jnTIBTIrdKvk6MVKsoTwYTG4N4Gy/3nX9bhkGRneOjG7GG6oAmJkdrvSQ3wL1aZTk9uZ
         LBcdbVsJapWDjwsoIfhViJeFS1Rae9+JqVLi74qWGPiuuVDj3YL5us7sUonYThMzduAB
         snOJVTzqV1wNDbDzQFsxBxtcoTJhdl3pOrsOEOnmNtpcMNS4tflqjpvz25ViKKlO2ib0
         /y0yqdpE3P+EDLE/supE2p+RPxHa+ZjtZ/GktEuqiAm8moXYnwZlgKdG+05diQrrWhnU
         ZT7g==
X-Forwarded-Encrypted: i=1; AJvYcCXpb+5tQZeASjHrgm/R+7Kw1M8IE9G0CJnL8aNm2fYmRvnj53/Rk4ETbdY55yaqFtAJB1Wt2As=@vger.kernel.org
X-Gm-Message-State: AOJu0YxIozF9eli/YJGBtMCp+GzIJGChKHwGiMqdy7QQTvlL1sE2O/bG
	atLtFSBelRhG1b2dXKy54VEFQJSfFNNUKf1suMt+OBQ0doU/HkPrtLWOjil1ufLT9XQJf3Fgrqj
	rkwt3291w5md96K+tKelzUt/fucTPO3Z2LXMI
X-Google-Smtp-Source: AGHT+IGD767gQQeV0tE11uRaEsrIc2mwmO00WhEo/Zz1UezZblPCSEvXaOlL6Ubx/nHPqBiL9e86v5ATJdjlx5EznPw=
X-Received: by 2002:a05:651c:2211:b0:2fa:d534:3ee7 with SMTP id
 38308e7fff4ca-2fc9bc35e2fmr2513681fa.35.1729620364754; Tue, 22 Oct 2024
 11:06:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241021191233.1334897-1-dualli@chromium.org> <20241021191233.1334897-2-dualli@chromium.org>
 <ZxcFxFfQM8gc5EEz@archie.me>
In-Reply-To: <ZxcFxFfQM8gc5EEz@archie.me>
From: Li Li <dualli@chromium.org>
Date: Tue, 22 Oct 2024 11:05:53 -0700
Message-ID: <CANBPYPgz4z-0gteo9YmQ+5g6tE3m3d3qc_siCvQqFo-ty5KvZQ@mail.gmail.com>
Subject: Re: [PATCH v4 1/1] binder: report txn errors via generic netlink (genl)
To: Bagas Sanjaya <bagasdotme@gmail.com>
Cc: dualli@google.com, corbet@lwn.net, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	donald.hunter@gmail.com, gregkh@linuxfoundation.org, arve@android.com, 
	tkjos@android.com, maco@android.com, joel@joelfernandes.org, 
	brauner@kernel.org, cmllamas@google.com, surenb@google.com, arnd@arndb.de, 
	masahiroy@kernel.org, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	netdev@vger.kernel.org, hridya@google.com, smoreland@google.com, 
	kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 21, 2024 at 6:54=E2=80=AFPM Bagas Sanjaya <bagasdotme@gmail.com=
> wrote:
>
> On Mon, Oct 21, 2024 at 12:12:33PM -0700, Li Li wrote:

> > +NOTE: if the user applications that talks to the Binder Genl driver ex=
its,
> "Note that if ..." or .. note:: block? I lean towards the latter, though.
> > +the kernel driver will automatically reset the configuration to the de=
fault
> > +and stop sending more reports to prevent leaking memory.

Thank you for reviewing it! I'll incorporate your fix in the next revision.

