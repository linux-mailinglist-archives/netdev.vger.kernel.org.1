Return-Path: <netdev+bounces-222033-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC8D3B52D12
	for <lists+netdev@lfdr.de>; Thu, 11 Sep 2025 11:22:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 75B3D3B7934
	for <lists+netdev@lfdr.de>; Thu, 11 Sep 2025 09:22:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC6D92E8E06;
	Thu, 11 Sep 2025 09:22:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="RprQKS9S"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0C852D2489
	for <netdev@vger.kernel.org>; Thu, 11 Sep 2025 09:22:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757582573; cv=none; b=E56dfJdKv5+efZGh+zkrRxvbgaWZFNgwWSobzaPsQsplbhmblpybhY4P/WIZSWNCB+IEtIAZZJhHrJtvvmaiB7dBCz+O0VqLHvZ7EvxREKYevxLSnjVwCipKYqeUoywLjnF0I90Ssb3Uanje5tlOT/falqC1zuH4G0xn8TZP+MQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757582573; c=relaxed/simple;
	bh=91x2IFdC5zaQq2SHZjMI+Nt0EODRaAqqDPguE5q5Oqc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OEQGZvtqwM3cRdOZk+hEAgGhtICmDBkHnT9BI55dGeeNvvlSdree/c4NZEQlpIbxcTaWKXUISss3WgPiAS9yiRmYEDzoYbHpnYhE6T0/aqasxje3snZdEgAAItJaNs3OmzCrKZ5pUUS8ntQIvAUQZ5MIo0B2xn+6Xp9T5V4K+DA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=RprQKS9S; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-55f68d7a98aso485407e87.3
        for <netdev@vger.kernel.org>; Thu, 11 Sep 2025 02:22:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1757582570; x=1758187370; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xClIjfrvAbF1xtvQXj+QQGe/hhZ9PeRp4erbvUtEvwI=;
        b=RprQKS9SldtTTCEsP85MNs0KXeUs27BEuVZv8j1xyEjbRYIpcyA7ogn5HnU4FZ5Hbf
         ELhOuvdT3vED5cjxMlyT4QwoK7gVdhtTJfpinsDeTJEifmBhwaLiljPUBVacwdP5r3D7
         C3/69LcaiiT1r8x5tlmB/xgtX7xve81EYhamQj1iCO52CCmcJCrTffyNOWwzH5i2a1ao
         XrcVjiDCXk0T+KPZA3FZJZUF7fEulAhkjzHPqd81h+TNI6BaEDq4Iu864G5pUiKXDzul
         dD4DUJWPQWMLgWxgduOtYTapfxsJ9lF6iDvZ84B+WeesovPlG4891C4YoSz3suIfaC48
         4Flw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757582570; x=1758187370;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xClIjfrvAbF1xtvQXj+QQGe/hhZ9PeRp4erbvUtEvwI=;
        b=fPrjQeQGkx94fkpycQ4Zh/jtleYfcWzkH4rbxAswwBeL6pM5jaXOC18MZHMxu48pV2
         zSIDKXmKUTXFX4chUeH6h+l0ydf0gM1tMeZW6mvG2eh9zsIlSrEqowQ3OR9w+SNrSLST
         4ho8KIbuTDQ4Of7ZxOtyo051EHUoNelpXkVhDLCKgJGbcYplefQfCopW8hQRGVOaMXnU
         J9zQ0PbB9oVBgIWUmOm2sgCNAsJkWTFpiZw6BbiQU9mn+fEKn2sHzx/9V+TMrFbDRULr
         tbjeXMg6FAQoxkvaeDjKh6FvH2Opj3LMV0QU/ZKb/7zl/kXCNfdvt7uYs9blHeCjcU5I
         A++g==
X-Forwarded-Encrypted: i=1; AJvYcCWWUxDbi63HbmkV7/Ic31v2cvQ9aRadm6zoEzLJxAG7bamRuKhLOfeH2mXjJcwqhBdE5/sCkHU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxwMxYR1cv9poLSm8daIV9lr92ZgbVRTB1jtC4PymQeNDjJDnbq
	Nmx/IQxVRh5QtkF36B6XR163CQDNA4KuHcSLZcUMibojpTCeNUlcD6trkw+3x0hGjqpQ3YK8Kg+
	TWtSGT2TG+2GwvvynFt9ouwK4PXHPde0UGBXHHL4TFQ==
X-Gm-Gg: ASbGncupuuH28hDKHQEbPtzNtekPFCT2sXLRv/Al071CiX18Vm8pvF4iSibUMsR2bX9
	2fAU0f2GwXnXZLhhwtOIgbRa9UEWsqMLaP0aDRjbXu0R+DD52P2qFBAanhGIzIwdM6Zd72cRpCl
	NHC4TWoP3KHkWsil2XVVXWPUamUkthB6Ms8IO29xTJ5DdiCq1kwxfaorslVOP0ogrGSOvqGkTXt
	0msqC8Pnl+pKU2TEQkv2zZO5+eFiM6mUyWvzpA=
X-Google-Smtp-Source: AGHT+IFsnkGxYpIZ2no6WEiKw7trlyFszU8hXSZ7C1IoobeXgikTcX6nfxEwSn+eF6XIvxGU/64B9GjviqVf+lb37jo=
X-Received: by 2002:a05:6512:145b:10b0:562:d04d:fa0f with SMTP id
 2adb3069b0e04-562d04dfb5emr4915461e87.57.1757582570041; Thu, 11 Sep 2025
 02:22:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250910-qcom-sa8255p-emac-v1-0-32a79cf1e668@linaro.org>
 <20250910-qcom-sa8255p-emac-v1-2-32a79cf1e668@linaro.org> <175751081352.3667912.274641295097354228.robh@kernel.org>
 <CAMRc=Mfom=QpqTrTSc_NEbKScOi1bLdVDO7kJ0+UQW9ydvdKjQ@mail.gmail.com>
 <20250910143618.GA4072335-robh@kernel.org> <CAMRc=McKF1O4KmB=LVX=gTvAmKjBC3oAM3BhTkk77U_MXuMJAA@mail.gmail.com>
 <b83a59f9-16ae-4835-b185-d5209d70a0f6@oss.qualcomm.com>
In-Reply-To: <b83a59f9-16ae-4835-b185-d5209d70a0f6@oss.qualcomm.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Thu, 11 Sep 2025 11:22:38 +0200
X-Gm-Features: Ac12FXx_Hui0lKjh3pL6K30JyaITyJ2wgwj7xLN_jTKFVW2DjCpTudv5l9sTHKE
Message-ID: <CAMRc=Md83STGFYya5eu4j33=SQ+D6upcP-7fnBwKo2dPdTtX+g@mail.gmail.com>
Subject: Re: [PATCH 2/9] dt-bindings: net: qcom: document the ethqos device
 for SCMI-based systems
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Cc: Rob Herring <robh@kernel.org>, Giuseppe Cavallaro <peppe.cavallaro@st.com>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, linux-arm-kernel@lists.infradead.org, 
	Eric Dumazet <edumazet@google.com>, linux-kernel@vger.kernel.org, 
	Andrew Lunn <andrew+netdev@lunn.ch>, Vinod Koul <vkoul@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, devicetree@vger.kernel.org, 
	Jose Abreu <joabreu@synopsys.com>, netdev@vger.kernel.org, 
	"David S. Miller" <davem@davemloft.net>, Conor Dooley <conor+dt@kernel.org>, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	Bjorn Andersson <andersson@kernel.org>, Richard Cochran <richardcochran@gmail.com>, 
	Jakub Kicinski <kuba@kernel.org>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
	Alexandre Torgue <alexandre.torgue@foss.st.com>, linux-stm32@st-md-mailman.stormreply.com, 
	linux-arm-msm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 11, 2025 at 10:53=E2=80=AFAM Konrad Dybcio
<konrad.dybcio@oss.qualcomm.com> wrote:
>
> On 9/10/25 4:42 PM, Bartosz Golaszewski wrote:
> > On Wed, Sep 10, 2025 at 4:36=E2=80=AFPM Rob Herring <robh@kernel.org> w=
rote:
> >>
> >> On Wed, Sep 10, 2025 at 03:43:38PM +0200, Bartosz Golaszewski wrote:
> >>> On Wed, Sep 10, 2025 at 3:38=E2=80=AFPM Rob Herring (Arm) <robh@kerne=
l.org> wrote:
> >>>>
> >>>>
> >>>> On Wed, 10 Sep 2025 10:07:39 +0200, Bartosz Golaszewski wrote:
> >>>>> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> >>>>>
> >>>>> Describe the firmware-managed variant of the QCom DesignWare MAC. A=
s the
> >>>>> properties here differ a lot from the HLOS-managed variant, lets pu=
t it
> >>>>> in a separate file.
> >>>>>
> >>>>> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> >>>>> ---
>
> [...]
>
> >>> These seem to be a false-positives triggered by modifying the
> >>> high-level snps.dwmac.yaml file?
> >>
> >> No. You just made 3 power-domains required for everyone.
> >>
> >
> > With a maxItems: 3?
>
> In the common definition:
>
> minItems: n
> maxItems: 3
>

Just to make it clear: if I have a maxItems but no minItems, does this
make maxItems effectively work as a strict-number-of-items?

Bartosz

> In your new file that includes the main one:
>
> properties:
>         power-domains:
>                 minItems: 3
>
> Konrad

