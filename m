Return-Path: <netdev+bounces-72931-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B107385A383
	for <lists+netdev@lfdr.de>; Mon, 19 Feb 2024 13:35:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D57671C238A9
	for <lists+netdev@lfdr.de>; Mon, 19 Feb 2024 12:35:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DC452E651;
	Mon, 19 Feb 2024 12:34:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="f7SvxbYa"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com [209.85.219.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 350F42E835
	for <netdev@vger.kernel.org>; Mon, 19 Feb 2024 12:33:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708346040; cv=none; b=Em97m/3J6N84CtxN3WCUamMl6lFpJe84yY4THzzin8gFAI8IwBzFSgKtHuFac3jNtns2Nc5hZctfAvy+PpJ1Lwan1VE9dnmSzhqpxSsJC8uIR51gjSZ9euys7gCCxG9KPYBsigcU/hQSiLb3HbQbmLlW90p+Ig3nD8nTy9rl58k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708346040; c=relaxed/simple;
	bh=EfyswbkjFGsreX6zvvh/xGLIF699ZsioDWGcgzOacl8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=l6ZcBjDCoJPCyZzMtkslN8LTgbkFr5Wvty7pa3ddZ4b9APPQXFgcUDwyvimniUZ7xPhZXa7eBzHdBVXRQXDqE9pazBacWkS92aCE1YmJNqMW/H/hRnmVYlCZPK6qsPBNE9XHKqvhqn3EZWtH/tL2F7ej1rJl0q2lnnvmwVSLwQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=f7SvxbYa; arc=none smtp.client-ip=209.85.219.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-dcdb210cb6aso4734996276.2
        for <netdev@vger.kernel.org>; Mon, 19 Feb 2024 04:33:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708346037; x=1708950837; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EfyswbkjFGsreX6zvvh/xGLIF699ZsioDWGcgzOacl8=;
        b=f7SvxbYapz8Q6xY8ShG4PYzpMxeuML9KOgHMMAP2eVOv40D6nw1X8eNmIB55yscPoR
         mNFvTfUmZDnvRVHmzmFyYQTyi2rJqWmEHXvNO9AvPv6CJ+kwsfRkYW5QpyPmPx14q6GW
         m77054HH2xIa260GuwYUAhLtxpWM8ZKs/Xg0kxMQPpZCjggGwl9Ruo0VN+eSuHCxDAbo
         3ThhqKLAEl81nIq2huqMPtf4tjs37B0b/w+04j+n6oytayQhTKK3kUGoztfMQxk0WHoH
         s7072BCUVk7BntWRB1B3wlzWQ0f8CvSKaUnFYaSmUlFf5ffvRPPS0gPvoNIpJWdOQt3R
         Sqnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708346037; x=1708950837;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EfyswbkjFGsreX6zvvh/xGLIF699ZsioDWGcgzOacl8=;
        b=VtP1JFrlme0YRjajZFbnZpFPKv2BohFRKMY2ltO7yvq5dnRrB7yKuNZr990R23KQ1F
         kBS9IT15qegw8NWuX9C2loZyLdLnsZx7XsDp+UnNiDTob6Rp/+3UzYPYYpvRgvBSDkHS
         tsd0Ysg/pam9wRC1mSizpXyU9pf5/SAMY3YmeDopah5UL+Nz50n+U8q2puAt64OH7yZp
         wbx3utIw0jFVGzUB/mP6XWuc91GL2Fa5hCB7LPa8r2U+mD++D4CYPkGh5T13fVHrrIPT
         XF5F8NOIUU4Kia6Wm00ZAzAPgfeZhuoobjrhp0uAQ7I2mW2SNkcXAhwLy+MgoODlzmwV
         3cpQ==
X-Forwarded-Encrypted: i=1; AJvYcCU1TIb+7YNhsNCTvsK4dauFq3pk5sZ4Fyph4Zyr/pkvFYj4XvAyjCvZ4/LG3uNUJbJROKrOt+cPVbVPe81gzHSybuJfzWfz
X-Gm-Message-State: AOJu0YwT70Q4MvLl6GgguI3m0TszkNKgMdo5LficS7ivI3oRYQPrPHjm
	1AA6XUaIt3sKLu/zkdrYGCoUJTYwylFESBtOQohCfwxXyLId+DC46GkdUC6qfclgN3Tdif0yw6n
	6753WSujrKn+tZQG0Y8+8NSjgRAOroEIyPg7xeA==
X-Google-Smtp-Source: AGHT+IFW8hhd6M3At62V/9wLITSoPMQHLrtCAz5Offi/bXn5seDzbGyDiAZKXHo0tEWEDjfOFoAQhZeOCTlFpOff0gM=
X-Received: by 2002:a25:adc9:0:b0:dcd:63f8:ba32 with SMTP id
 d9-20020a25adc9000000b00dcd63f8ba32mr10169009ybe.65.1708346037293; Mon, 19
 Feb 2024 04:33:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240216203215.40870-1-brgl@bgdev.pl> <CAA8EJppt4-L1RyDeG=1SbbzkTDhLkGcmAbZQeY0S6wGnBbFbvw@mail.gmail.com>
 <e4cddd9f-9d76-43b7-9091-413f923d27f2@linaro.org> <CAA8EJpp6+2w65o2Bfcr44tE_ircMoON6hvGgyWfvFuh3HamoSQ@mail.gmail.com>
 <4d2a6f16-bb48-4d4e-b8fd-7e4b14563ffa@linaro.org> <CAA8EJpq=iyOfYzNATRbpqfBaYSdJV1Ao5t2ewLK+wY+vEaFYAQ@mail.gmail.com>
 <CAMRc=Mfnpusf+mb-CB5S8_p7QwVW6owekC5KcQF0qrR=iOQ=oA@mail.gmail.com>
In-Reply-To: <CAMRc=Mfnpusf+mb-CB5S8_p7QwVW6owekC5KcQF0qrR=iOQ=oA@mail.gmail.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Mon, 19 Feb 2024 14:33:46 +0200
Message-ID: <CAA8EJppY7VTrDz3-FMZh2qHoU+JSGUjCVEi5x=OZgNVxQLm3eQ@mail.gmail.com>
Subject: Re: [PATCH v5 00/18] power: sequencing: implement the subsystem and
 add first users
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: neil.armstrong@linaro.org, Marcel Holtmann <marcel@holtmann.org>, 
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
	Conor Dooley <conor+dt@kernel.org>, Kalle Valo <kvalo@kernel.org>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konrad.dybcio@linaro.org>, 
	Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Saravana Kannan <saravanak@google.com>, 
	Geert Uytterhoeven <geert+renesas@glider.be>, Arnd Bergmann <arnd@arndb.de>, 
	Marek Szyprowski <m.szyprowski@samsung.com>, Alex Elder <elder@linaro.org>, 
	Srini Kandagatla <srinivas.kandagatla@linaro.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Abel Vesa <abel.vesa@linaro.org>, 
	Manivannan Sadhasivam <mani@kernel.org>, Lukas Wunner <lukas@wunner.de>, linux-bluetooth@vger.kernel.org, 
	netdev@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-pci@vger.kernel.org, linux-pm@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 19 Feb 2024 at 14:23, Bartosz Golaszewski <brgl@bgdev.pl> wrote:
>
> On Mon, Feb 19, 2024 at 11:26=E2=80=AFAM Dmitry Baryshkov
> <dmitry.baryshkov@linaro.org> wrote:
> >
>
> [snip]
>
> > > >>>>
> > > >>>> For WCN7850 we hide the existence of the PMU as modeling it is s=
imply not
> > > >>>> necessary. The BT and WLAN devices on the device-tree are repres=
ented as
> > > >>>> consuming the inputs (relevant to the functionality of each) of =
the PMU
> > > >>>> directly.
> > > >>>
> > > >>> We are describing the hardware. From the hardware point of view, =
there
> > > >>> is a PMU. I think at some point we would really like to describe =
all
> > > >>> Qualcomm/Atheros WiFI+BT units using this PMU approach, including=
 the
> > > >>> older ath10k units present on RB3 (WCN3990) and db820c (QCA6174).
> > > >>
> > > >> While I agree with older WiFi+BT units, I don't think it's needed =
for
> > > >> WCN7850 since BT+WiFi are now designed to be fully independent and=
 PMU is
> > > >> transparent.
> > > >
> > > > I don't see any significant difference between WCN6750/WCN6855 and
> > > > WCN7850 from the PMU / power up point of view. Could you please poi=
nt
> > > > me to the difference?
> > > >
> > >
> > > The WCN7850 datasheet clearly states there's not contraint on the WLA=
N_EN
> > > and BT_EN ordering and the only requirement is to have all input regu=
lators
> > > up before pulling up WLAN_EN and/or BT_EN.
> > >
> > > This makes the PMU transparent and BT and WLAN can be described as in=
dependent.
> >
> > From the hardware perspective, there is a PMU. It has several LDOs. So
> > the device tree should have the same style as the previous
> > generations.
> >
>
> My thinking was this: yes, there is a PMU but describing it has no
> benefit (unlike QCA6x90). If we do describe, then we'll end up having
> to use pwrseq here despite it not being needed because now we won't be
> able to just get regulators from WLAN/BT drivers directly.
>
> So I also vote for keeping it this way. Let's go into the package
> detail only if it's required.

The WiFi / BT parts are not powered up by the board regulators. They
are powered up by the PSU. So we are not describing it in the accurate
way.

Moreover, I think we definitely want to move BT driver to use only the
pwrseq power up method. Doing it in the other way results in the code
duplication and possible issues because of the regulator / pwrseq
taking different code paths.


--=20
With best wishes
Dmitry

