Return-Path: <netdev+bounces-73051-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E8D1085AB6A
	for <lists+netdev@lfdr.de>; Mon, 19 Feb 2024 19:48:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 26ED51C21F6F
	for <lists+netdev@lfdr.de>; Mon, 19 Feb 2024 18:48:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 322AE482F5;
	Mon, 19 Feb 2024 18:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="1VGGa1fm"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ua1-f41.google.com (mail-ua1-f41.google.com [209.85.222.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CCF3482C0
	for <netdev@vger.kernel.org>; Mon, 19 Feb 2024 18:48:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708368515; cv=none; b=gaSmq56Pcc1XRn4dhPsTG8KaG1EXSFZJNiJCEUMbKlSanC2sF2Uxhghc7BcIL2+zZoTgYcCZ587jlYWUvTgh1uL20t/bRf3cVv8sIFcnxcebqQoWU98fnGC8q5L8EY3gs6tVMXumFVxvOCkVV+zdYysujXci68xK9ouO0anpEbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708368515; c=relaxed/simple;
	bh=tWv3BTcXIRuvABZYmrMpTNLM1fVSSvR8wJ9miScNVZI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=W/eiF0fwBU92hxAO3ENQwaJ5ikD2AQEYXGXQyVo0FEQyX86D+KVdh5ve/IXJVQOpX5NN6e3Cpj6at4g5yqdoWKH/j7Gbh11saSvE4JVpVMRTcEbPllyynYmMb9mOzU2e123LkUg5oP4G6PwlSrvxXocDZpLoHUTmtT3h5EiUIDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=1VGGa1fm; arc=none smtp.client-ip=209.85.222.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-ua1-f41.google.com with SMTP id a1e0cc1a2514c-7d5c25267deso2174053241.3
        for <netdev@vger.kernel.org>; Mon, 19 Feb 2024 10:48:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1708368512; x=1708973312; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iw+h6XA2eEk7N3nhL73ACZ3Q8FgRaHJnjAZBDU1Wfkk=;
        b=1VGGa1fmMaxjWD5xtBOgZYKLB62EqAJVXLgaLXI6WHf97nYa9CwwKXdkPuo7Vnzq/3
         R+Gm0JsxkC/2YN6UHYxTktPcQYoFjNdgKmHd00V7WUGoano+PdA8jljF18mKLtOEy4y7
         sXJ1XVpvc0KRXPoKI6DUmwJIrnAEvF+sftONKaI7f2pLDlPrbocdOCI3dpa45Ev6eAmz
         ku2hbAmLSRUX6y5fQ8AgWoCU6tEmjoqmI9fK7lW16qfH/uv2JaXqKf45LDMIwnTWfXiQ
         lDIkpCoNXuz7CDPdn+1wmb6l2Wl1WQddLgSqJKtLS/m4+SIORm2kmh1FEQrmVOJ9/wnA
         TLXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708368512; x=1708973312;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iw+h6XA2eEk7N3nhL73ACZ3Q8FgRaHJnjAZBDU1Wfkk=;
        b=Xg4Fe80NF7imLMFWEzVGGbsdL9GXBgSrAk7wK0mzIzevv/gM+2G3xWIz+ecDuYMeRd
         NZX0HkYbAIWRzvCKolk+vRq5NV6FoNeurmIg5Oq3EYDm682jVsrG3rR2d5G5o0+I8109
         sA5+xIrBYZ/Rw9h8glVEjtJYeF6ly9qgp0kW+FGz4LllqN28tVKtKovs+iuGu794r+8u
         unv6oDja7Zq9+0ymLP4Jgae8I4Akvnz9P9ZUyt5/CZSk0meG7Z62dRiIMi1QYt5PgdMF
         jstq0Jr7KSz9STLCarEjSmtPWp4Cx01FdObH4apzO4pE5Wulayn98mZm5VsNuDx8KgfZ
         7QIg==
X-Forwarded-Encrypted: i=1; AJvYcCWYrkqJ0uJ2cgBBhrbzrLoSvbLbvA7LKvTIYVkRKLP61bn9m8lfdnEfu+xiLp7Ng9u3rtb87Zl1q//8qc719zz6IJ1NY6I/
X-Gm-Message-State: AOJu0YyP9CXapXnRorqm8XGGgFwpA7ufw4pbngO3C6Ybamt+Vrga0SgV
	SxV5U2xAf3CIrasJgaMfnCmjwm0DXyUTZa5//3jmji4ODlg6IcuSu0+GaP5dukTFH8u0sbEkLtI
	cZFstSg7SkkKKvNlYHLEbpZZTrI/FzwRSKDWR8w==
X-Google-Smtp-Source: AGHT+IFew0xpEP8/09qOXqEwkTDNNehQKTGr1SM0trRodxSgKcCNIctA84dQ/9qfd01qZ/b5K7TWSeVoDwJUt5v12E8=
X-Received: by 2002:a1f:e207:0:b0:4ca:f519:c25f with SMTP id
 z7-20020a1fe207000000b004caf519c25fmr2526721vkg.9.1708368512278; Mon, 19 Feb
 2024 10:48:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240216203215.40870-1-brgl@bgdev.pl> <20240216203215.40870-10-brgl@bgdev.pl>
 <48164f18-34d0-4053-a416-2bb63aaae74b@sirena.org.uk>
In-Reply-To: <48164f18-34d0-4053-a416-2bb63aaae74b@sirena.org.uk>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Mon, 19 Feb 2024 19:48:20 +0100
Message-ID: <CAMRc=Md7ymMTmF1OkydewF5C32jDNy0V+su7pcJPHKto6VLjLg@mail.gmail.com>
Subject: Re: [PATCH v5 09/18] arm64: dts: qcom: qrb5165-rb5: model the PMU of
 the QCA6391
To: Mark Brown <broonie@kernel.org>
Cc: Marcel Holtmann <marcel@holtmann.org>, Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Kalle Valo <kvalo@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konrad.dybcio@linaro.org>, Liam Girdwood <lgirdwood@gmail.com>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Saravana Kannan <saravanak@google.com>, 
	Geert Uytterhoeven <geert+renesas@glider.be>, Arnd Bergmann <arnd@arndb.de>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Marek Szyprowski <m.szyprowski@samsung.com>, 
	Alex Elder <elder@linaro.org>, Srini Kandagatla <srinivas.kandagatla@linaro.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Abel Vesa <abel.vesa@linaro.org>, 
	Manivannan Sadhasivam <mani@kernel.org>, Lukas Wunner <lukas@wunner.de>, 
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, linux-bluetooth@vger.kernel.org, 
	netdev@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-pci@vger.kernel.org, linux-pm@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 19, 2024 at 7:03=E2=80=AFPM Mark Brown <broonie@kernel.org> wro=
te:
>
> On Fri, Feb 16, 2024 at 09:32:06PM +0100, Bartosz Golaszewski wrote:
>
> > +                     vreg_pmu_aon_0p59: ldo1 {
> > +                             regulator-name =3D "vreg_pmu_aon_0p59";
> > +                             regulator-min-microvolt =3D <540000>;
> > +                             regulator-max-microvolt =3D <840000>;
> > +                     };
>
> That's a *very* wide voltage range for a supply that's got a name ending
> in _0_p59 which sounds a lot like it should be fixed at 0.59V.
> Similarly for a bunch of the other supplies, and I'm not seeing any
> evidence that the consumers do any voltage changes here?  There doesn't
> appear to be any logic here, I'm not convinced these are validated or
> safe constraints.

No, the users don't request any regulators (or rather: software
representations thereof) because - as per the cover letter - no
regulators are created by the PMU driver. This is what is physically
on the board - as the schematics and the datasheet define it. I took
the values from the docs verbatim. In C, we create a power sequencing
provider which doesn't use the regulator framework at all.

Bartosz

