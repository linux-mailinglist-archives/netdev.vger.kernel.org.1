Return-Path: <netdev+bounces-170442-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B290A48C04
	for <lists+netdev@lfdr.de>; Thu, 27 Feb 2025 23:50:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 306923B5601
	for <lists+netdev@lfdr.de>; Thu, 27 Feb 2025 22:50:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 692644438B;
	Thu, 27 Feb 2025 22:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="J9oXNkzV"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AA031AA1E4
	for <netdev@vger.kernel.org>; Thu, 27 Feb 2025 22:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740696619; cv=none; b=GjxcqfJudTndPq84LGA4/CTpfuvRIfiWDj6QSk57vaVF6NehPrY4upQdwSZZmn51DHrrdQSnvIllBin2qqpQFmAUGez86avQteaiLsKE4PHQ9hcI2SUfuolBz4qn85Dt8FWc4NyjdB1mHmptqsM14doEWlTtyYLTju9slrfdfgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740696619; c=relaxed/simple;
	bh=aZFWTG7VtFf3WD8yAt7fkM6zwzPU2g+tIuFZ9YrXYKg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mjOGFBDgkD6xtjga9exJ885dGkR9KhGXrEchaPzCrGD3XC9tDEn1qWWvnKXot88iX43QCyVbSmWcppk02r4ICGiCd4PTk28RfuZWP9oW0wELlyLbylqSYDZVd/dPX4jBISAAjkAoNCxjDLYL90nkGN9Bf4c8FwHmXy+81hdco1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=J9oXNkzV; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-30615661f98so14952541fa.2
        for <netdev@vger.kernel.org>; Thu, 27 Feb 2025 14:50:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740696613; x=1741301413; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RVmnmMz3k+cSRNarmhUlid1kyf/hUqoGSHHkmE8JTKY=;
        b=J9oXNkzVGptuVEncNIhOUBLehuNNkGeTDL+7cPChf2m4M8qD0fjQufsg8Y2fWs3ZTW
         gUouFyHKLrR5qT1+jo/1KokeiVUs5R70EejQfV11VPw8027enoaeKP4063h1bcM1OsE3
         1UHSgHUrxcawRAPpcdj1eS5gl92XhLcnlAcNyVc+1kA4gO9NkWu6WUbR3/ST0PnfIOhf
         viA71WK0ExU5IPS6VJ9OpJY5vXrgX5lwwByy9QSq+WKhEM7otqj3pDr7uYkTCooxjDpQ
         t4iLr0qBm2sozep7uWb4qZLOHDxkKtI/p83PLVxDxi2iC22nupSP1EDpPswg9d42a6CW
         r1ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740696613; x=1741301413;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RVmnmMz3k+cSRNarmhUlid1kyf/hUqoGSHHkmE8JTKY=;
        b=hOxUpd63oyd7fuafMgBSZZ5+7nKfwcABsC570DQLsCysMh400wJMTJ6ifWk0+bl09A
         Bunj+J+M0v7OhRU8EBGSGEvJ7oXeLxdh9ReoI0p+v12Z0UjV0ocj+cqoKiO2PmgyaIwB
         UlcqLXBkBJPUmiFRIOHRzQJrSNJ6dOJC5ityqTE7Lqe9XW3Yo7ykOXqyOTDLAGXvnuoz
         d07zFPAnsGGJwTkPOmQ3X9uX3fLx0AiY1orMCxNd60O4/fkYY23J4fZzlozThsaGVz7X
         xWJBfGSEG32JQ+bBnXr5K1phZUAk/eSFpiZ10owtvImERaM5H2FNWGswX98Knus+vVFg
         euRA==
X-Forwarded-Encrypted: i=1; AJvYcCXJXtX1i341L46NCA3ZIC6k81Rpm4UZxJMAVN5YF1+lMeyEPvX3mcsAEVl6WW8mkWszZWTVwg8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzRT5UqHkExXs6C1Okhw4d0M1M2hncK1JbotM5xBK0bSEy/ZovY
	qIaENf5NoiuCiSi4s5QhMnajZY6ynKQ9/8ppOWl5ZfXGa9lFAmkqwIe0MvESiwmggyNASHYRpUZ
	hdauDHv5Zh5tBglHCvEBnYW4vN9xx5938YK/DXw==
X-Gm-Gg: ASbGnctvL1ba36fp2bDPr+pxcxzAphwDRd7wb480dpG4P+2WkPDU3tkYNJQt3qia7C9
	derdXCHeyxF+39q55o+apSnRHTfiPv12luwAxSzm0PxFCxwnncc1mncucnkh3hkotAEnUsfTgr9
	7V8zrOEOE=
X-Google-Smtp-Source: AGHT+IFaGDCgZweCWq59FTimwVMWfklYJv4GRxdRUVc64bY/DI4b04q7zH7Uyt+7g+T9PXJUAoQ/pka3lTVU5esWdrg=
X-Received: by 2002:a2e:9181:0:b0:309:2283:bea8 with SMTP id
 38308e7fff4ca-30b934132f4mr2227491fa.34.1740696613518; Thu, 27 Feb 2025
 14:50:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250220-rtl8366rb-leds-compile-issue-v3-1-ecce664f1a27@linaro.org>
 <20250227083445.7613e2b9@kernel.org>
In-Reply-To: <20250227083445.7613e2b9@kernel.org>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 27 Feb 2025 23:50:02 +0100
X-Gm-Features: AQ5f1JodjXfeu0petcPPb0XF27xT2ehiK_DWi19zfaXJNpbyB3-gU9kXe20ILo0
Message-ID: <CACRpkdahvGRx-ZS-dqYouiBzaCR2bNvc_tPOtz_cepRc4Opuyw@mail.gmail.com>
Subject: Re: [PATCH v3] net: dsa: rtl8366rb: Fix compilation problem
To: Jakub Kicinski <kuba@kernel.org>
Cc: =?UTF-8?Q?Alvin_=C5=A0ipraga?= <alsi@bang-olufsen.dk>, 
	Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Luiz Angelo Daros de Luca <luizluca@gmail.com>, netdev@vger.kernel.org, 
	kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 27, 2025 at 5:34=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
> On Thu, 20 Feb 2025 19:48:15 +0100 Linus Walleij wrote:
> > +config NET_DSA_REALTEK_RTL8366RB_LEDS
> > +     bool "Support RTL8366RB LED control"
> > +     depends on (LEDS_CLASS=3Dy || LEDS_CLASS=3DNET_DSA_REALTEK_RTL836=
6RB)
> > +     depends on NET_DSA_REALTEK_RTL8366RB
> > +     default NET_DSA_REALTEK_RTL8366RB
>
> Is there a reason to prompt the user for this choice?
> IOW is it okay if I do:

Yeah that's OK, go ahead.

Yours,
Linus Walleij

