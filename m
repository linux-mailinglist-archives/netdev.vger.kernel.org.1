Return-Path: <netdev+bounces-100885-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB1A98FC763
	for <lists+netdev@lfdr.de>; Wed,  5 Jun 2024 11:13:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C7A941C23450
	for <lists+netdev@lfdr.de>; Wed,  5 Jun 2024 09:13:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A287B18FC76;
	Wed,  5 Jun 2024 09:13:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="2SVO9602"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D46E918FC66
	for <netdev@vger.kernel.org>; Wed,  5 Jun 2024 09:13:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717578799; cv=none; b=aoYNPsmlx5sTu4ry9sx37SEpnr4D8B8Zv8apXD4+unPvpgWUIjalPw8i8Znb6AXvuUYmjPovD+8VtB5DSl4wWi2Ro0rsNETWyBkV8mqSn8ih4+gy8MMYwr1wcWV0qP17d2yVK/AQwnFK9Ey/Lm5L3EcxnDF/bsyp0ZnuS4vbrio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717578799; c=relaxed/simple;
	bh=AFakv71kM06p0q3oYAQzeRow8V15P35z1h8kfitwLYA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RaZaL0pvyxx1tbxcj2LYKTC5m339digYtK4f+CDLLh9yk+VcS/MvmLZ+YlFW/eipUfypes8TxfZBR4aNFJV83t0vV2hqfDW6GgljQRWw+eZfic2gM+2hk2X/z9hBhgqop2eqPOn0AqLjXgGteoKM9g6sCqGiWjbvies++KqfOR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=2SVO9602; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2eaa80cb573so53322891fa.1
        for <netdev@vger.kernel.org>; Wed, 05 Jun 2024 02:13:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1717578796; x=1718183596; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3c4YFpd8Fm+Esjyb3eXLbvb26s9zAJBJ0sBTmfOcoOQ=;
        b=2SVO96020zsJW3oJBymyp4e6hfylB/HZFX48nO1GS+XKJVBKQq0wdZsIUdelO4ZyKe
         SQu0FXL/8HyyEj+CJk3nsUpE6PycFoeR8rrHr465kRj5JHqfgScdEXHzZC34rBbigV+b
         EH3kFuP2zyWGGjd91iSqrfikkXRu2M5Z5boa+1iEVT032LUU768k/3GpyJ9CFBmKJJsC
         5I0lAlaoagW20dzf/3vzsjRMNR5bgeLPWssU/99Yhyxv/4rA63N1jc84nG1XrLSBiCh5
         9KDm4lokoOLPbb1HfUztacDkq7cVE4iDKGqYzK7RRUKk23O4DD3GOq6iJawg7HEulqdJ
         /RqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717578796; x=1718183596;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3c4YFpd8Fm+Esjyb3eXLbvb26s9zAJBJ0sBTmfOcoOQ=;
        b=mBqLqX6wF/ezJUIcJJ+/Ke9KrL42Nx5KUnwPL9O03s6JOjGgGOWlNaeAFb35aun9xD
         ORcsT0E6Vc9nBDtYhrREsbatJsX725BVeqzSjI/rjMwD4Fabcq956li1ENrle47zYreU
         tqWIVxFMwX05bVVorMIU0xH+cS6nmXJM4KR6nWjkRfatLBUMBfFEFwqeG0wc61s7ASvv
         OPdPvMGWfiOZ0GqG9CC6Y5PPTfIKX8jZGqq/PYohj6+/SadljUB1hvXBehvI6V0z/a68
         S6s4oJWLdjR7vT+YKkehzxJQ1g+PCsV/OwmTUbfV7c+Vgr+cbrsJzA55MHwfJPCZu/Jf
         qnAA==
X-Forwarded-Encrypted: i=1; AJvYcCUF7XKKpU2XN7FBavmU8LRhyV8FBwM41C8T+yGpdQAZ8kxX1uVVoku3jNVXGXAddDIVF+8qJGnKxMdTybAAQbLI1z03NxNq
X-Gm-Message-State: AOJu0Yw9xdTuJiiwUrizlXxQXf1tJs7KMzAFUhHrXerCVKKGGJ7vXotc
	D2QaP4IR8qbY6XzOHVGoPC6iBYeVSXybx0VG9fFbYK5nhrGPvRvrjIE8Fsn7TlHsD4yTLRED4i+
	KANOuHvdT6de/cLCu3sSX1hQnOaKGoVgx5gFbGA==
X-Google-Smtp-Source: AGHT+IE63vGTd6+j21cBJUHSJYSLK2xCKb5rCCgsCKhs4EXyLEAsob0AZ/LylbrE5cvmoYjm+qi2nvoKP8Y3gZgS3f0=
X-Received: by 2002:a05:651c:30f:b0:2ea:7e50:6c94 with SMTP id
 38308e7fff4ca-2eac79c1bbdmr8705551fa.16.1717578795960; Wed, 05 Jun 2024
 02:13:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240528-pwrseq-v8-1-d354d52b763c@linaro.org> <20240604173021.GA732838@bhelgaas>
In-Reply-To: <20240604173021.GA732838@bhelgaas>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Wed, 5 Jun 2024 11:13:04 +0200
Message-ID: <CAMRc=MeNPvZUyu6rtsWtdvXFmOOpmjKCEpkoc5zBfJy6qBpxrg@mail.gmail.com>
Subject: Re: [PATCH v8 01/17] regulator: dt-bindings: describe the PMU module
 of the QCA6390 package
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Marcel Holtmann <marcel@holtmann.org>, Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Balakrishna Godavarthi <quic_bgodavar@quicinc.com>, Rocky Liao <quic_rjliao@quicinc.com>, 
	Kalle Valo <kvalo@kernel.org>, Jeff Johnson <jjohnson@kernel.org>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konrad.dybcio@linaro.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Srini Kandagatla <srinivas.kandagatla@linaro.org>, 
	Elliot Berman <quic_eberman@quicinc.com>, Caleb Connolly <caleb.connolly@linaro.org>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, 
	Alex Elder <elder@kernel.org>, linux-arm-msm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org, 
	linux-wireless@vger.kernel.org, ath11k@lists.infradead.org, 
	Jeff Johnson <quic_jjohnson@quicinc.com>, ath12k@lists.infradead.org, 
	linux-pm@vger.kernel.org, linux-pci@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, kernel@quicinc.com, 
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 4, 2024 at 7:30=E2=80=AFPM Bjorn Helgaas <helgaas@kernel.org> w=
rote:
>
> On Tue, May 28, 2024 at 09:03:09PM +0200, Bartosz Golaszewski wrote:
> > From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> >
> > The QCA6390 package contains discreet modules for WLAN and Bluetooth. T=
hey
>
> s/discreet/discrete/
>
> > are powered by the Power Management Unit (PMU) that takes inputs from t=
he
> > host and provides LDO outputs. This document describes this module.
>
> LDO?  Again below, but maybe this is obvious to everybody.
>

Yes, this is an acceptable abbreviation to use, it's all over the
bindings and regulator drivers.

> "This document describes this module" seems possibly unnecessary.
>
> > +description:
> > +  The QCA6390 package contains discreet modules for WLAN and Bluetooth=
. They
>
> s/discreet/discrete/
>
> > +  are powered by the Power Management Unit (PMU) that takes inputs fro=
m the
> > +  host and provides LDO outputs. This document describes this module.
>
> > +  vddpcie1p3-supply:
> > +    description: VDD_PCIE_1P3 supply regulator handle<S-Del>
>
> s/<S-Del>// ?

Eek, bad copy-paste.

Bart

