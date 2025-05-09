Return-Path: <netdev+bounces-189199-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CE1A9AB127C
	for <lists+netdev@lfdr.de>; Fri,  9 May 2025 13:50:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 027451BC7562
	for <lists+netdev@lfdr.de>; Fri,  9 May 2025 11:50:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E077328F934;
	Fri,  9 May 2025 11:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rDMP5Xzr"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F091A4B1E5D
	for <netdev@vger.kernel.org>; Fri,  9 May 2025 11:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746791433; cv=none; b=uhdKesm+3ChhKwLCcjBJYhg3e7J+9jeayIsQS1YfOwgPr6R97cLAGfbsRdWpPRoVLm2LVc2mBkUbBZFqdVzkzKZ6u5h+igPpcjnt6TPid0NEEnA9NKfj37p97OgZZs6zU8dPb0UEUkq4JJhN5WvLQt9z/dU7k7Vk/P+BxKGsexw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746791433; c=relaxed/simple;
	bh=6bSX9UNo+ut9uhyeztVWH22aZ+WPLHdTGC7kWwCUCXg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dWhcnopxQ7hUbTCUwYAftTepTwC8kzqLm00FDD/XrIqVRfBE2mvEjK+Vfv3fMBZvYSOcv0a/uDrHDcKigl5MCQUY7Pu96ySGH+vtzBbuzZU9nrTpE9wiaqLAHSffB/G0ZK1fOI/o+bRAjmDHktr/BeXRTT8hDgO9Gwm0eMQpIp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=rDMP5Xzr; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-54c090fc7adso2997078e87.2
        for <netdev@vger.kernel.org>; Fri, 09 May 2025 04:50:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1746791430; x=1747396230; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6bSX9UNo+ut9uhyeztVWH22aZ+WPLHdTGC7kWwCUCXg=;
        b=rDMP5XzrQ88umTP+9l67/zJpEOw9Tf5QRqmG8aid0Jm776jOYiSyw2ws4geCLljooS
         JCnksf09yvbYgNnZrOpyZ4cmJktwmGqdGkqo2vEo5Io5P24KiCjl3aKESEHxnLLWs1NH
         2lUA37eKUFR5c5QlKodJORWKFRN6wN+LCC8S3RKJcsImFCoknUUjmZiIZOSlyaFI/ftQ
         iz02M+0jkawlqKfEL0vbGX54kzdzRkX5lP4Sge71epwG0v5DENaKpj/P1FEBxYwk9PeI
         eRdTUV4XUD5FraSmI5vLEuJ+K5PdCjHH3uAAxFV/2TVnQpF1qz7ZGwUW01bx2ByhIc/c
         LIFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746791430; x=1747396230;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6bSX9UNo+ut9uhyeztVWH22aZ+WPLHdTGC7kWwCUCXg=;
        b=Kn6lx+CWf3OQFHi2RQsjpm+nZds2Wy+JHOE/1k3su+J5fpirUSQPwVdnf20Wg0vrbt
         6o4Y2nCaljXSa77I34wHZCPGS3zwA4q+SbqSabdF8LUB7B5g6f8rLZ07NFX9/q2Zv+6u
         bcsozKwytkLMUd99Mcdf4p2KnoNUUAc0O1GhLa0PSSht7L0z569G0IlaqYVjJvA5hah+
         VS0DRe4LDblnuIIQ8N8nNavI9PfqOeBtK0NSxOK/N7nsYWAyg0EBqIba+g16IjSLB0tp
         zLD/afmMtY/v3h029zhTch2zDrUd2k5GxZ9+G/wRCk2tgtP4C2/rOwyt+e/9ptzClgrh
         vgwg==
X-Forwarded-Encrypted: i=1; AJvYcCVfZJv3GCm8rt3x1MqqMtg+34i44+yvIfQPaggQNzm7SJpvHiRAybD1Dzf6Gzgn20M4sluWc6o=@vger.kernel.org
X-Gm-Message-State: AOJu0YxPGTq+XaaNGgO/ijPtwnfWsxmf0LYTTEHfURHqDMGstrL6435x
	u/Oz6nJL5TJ9NIfJ91+r3U2ejF6VOQsxG+DVAVNsAI7p/mjw5tIGfPMuj2bS4rHTUcRd2eRZJnv
	f60pRWV4o0xKIqIkVa4eor7ffzlyhYgRhPk2/2alIY6eiUoVy
X-Gm-Gg: ASbGncvi0U+iH5Qh8B7ovv38Y2LsO+r2I4EBd2h20/RFIMNLOtZs9l8sPsBoA1+Y/VX
	596Hj8JamcXILOyf4qLwgLy37FORpOQjFTc4eLF81Z5pqJRL5XBtthhI4sMME2LAZX1UKkf0pwv
	VYnBSDlXx8VqG8RQEeNCkvYBuAe628f4TN
X-Google-Smtp-Source: AGHT+IE9OA/TgX88UK8wnm39DMsSy6I7xruaMSROXFg88YbOwzBbcaNlmJPRpQ8Ckx3l33XEBcNwePAgT7TtPdM2+0E=
X-Received: by 2002:a2e:a991:0:b0:300:26bc:4311 with SMTP id
 38308e7fff4ca-326c4575642mr10757241fa.18.1746791429976; Fri, 09 May 2025
 04:50:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250424-01-sun55i-emac0-v2-0-833f04d23e1d@gentoo.org>
 <20250424-01-sun55i-emac0-v2-3-833f04d23e1d@gentoo.org> <CAGb2v66a4ERAf_YhPkMWJjm26SsfjO3ze_Zp=QqkXNDLaLnBRg@mail.gmail.com>
 <20250425104128.14f953f3@donnerap.manchester.arm.com> <CAGb2v65QUrCjgHXWAb72Sdppqg1AUxXyD_ZcXShtkRSHCQBbOg@mail.gmail.com>
 <20250425160535.5a18adbb@donnerap.manchester.arm.com>
In-Reply-To: <20250425160535.5a18adbb@donnerap.manchester.arm.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Fri, 9 May 2025 13:50:18 +0200
X-Gm-Features: ATxdqUG6U2bPxTcfQiBy-oW1Lju29rGeV9-TYLkpQrHjbRn14HSqGi03f0yvO10
Message-ID: <CACRpkdZH+NnP0-GkLe+nHK-Oi_Z=FzPaM=k1U-gZddp+P2+DTw@mail.gmail.com>
Subject: Re: [PATCH v2 3/5] arm64: dts: allwinner: a523: Add EMAC0 ethernet MAC
To: Andre Przywara <andre.przywara@arm.com>
Cc: Chen-Yu Tsai <wens@csie.org>, Yixun Lan <dlan@gentoo.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, Samuel Holland <samuel@sholland.org>, 
	Maxime Ripard <mripard@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Corentin Labbe <clabbe.montjoie@gmail.com>, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 25, 2025 at 5:05=E2=80=AFPM Andre Przywara <andre.przywara@arm.=
com> wrote:
> On Fri, 25 Apr 2025 22:35:59 +0800
> Chen-Yu Tsai <wens@csie.org> wrote:
>
> adding LinusW for a more generic pinctrl question ...

OK!

> > There isn't any assumption, as in we were fine with either the reset
> > default or whatever the bootloader left it in. However in projects at
> > work I learned that it's better to have explicit settings despite
> > working defaults.
>
> I totally agree, but my point was that this applies basically to every
> pinctrl user. I usually think of the bias settings as "do we need
> pull-ups or pull-downs", and if nothing is specified, I somewhat assume
> bias-disable.
>
> So I am fine with this being added here, but was wondering if we should
> look at a more generic solution.
>
> Linus: is bias-disable assumed to be the default, that pinctrl drivers
> should set in absence of explicit properties? Or is this "whatever is in
> the registers at boot" the default we have to live with?

We have never hammered down the semantics of that, so it's a bit
up to the specific driver how they implement it (yeah a grey area...)

There are many drivers that are carful to not touch register boot
values but others who set them to some default, and people
have different opinions on that.

Yours,
Linus Walleij

