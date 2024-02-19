Return-Path: <netdev+bounces-72832-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6197D859DBD
	for <lists+netdev@lfdr.de>; Mon, 19 Feb 2024 09:02:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 028B3B2106D
	for <lists+netdev@lfdr.de>; Mon, 19 Feb 2024 08:02:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23BF82421E;
	Mon, 19 Feb 2024 07:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="VVl8JQpi"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ua1-f52.google.com (mail-ua1-f52.google.com [209.85.222.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CC2824B24
	for <netdev@vger.kernel.org>; Mon, 19 Feb 2024 07:57:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708329431; cv=none; b=a84pUQoRO+XGLAinMIWE22nXK9vpZpNSVv7cKiTxzFnjgOwZm6iIcyQbxV3KDV5Sjh4jV7ZVh9dm5iNR6WLEjQuei5ZdnR6k9z5y45Rn4y/q6VH/obE3Eh2KjA9NdLDSGJyNCpK0jsQjUB72tX73M/pFr74ynR2tPSa64xu8bcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708329431; c=relaxed/simple;
	bh=Oey3ZN4EIWUJzNAo3Boteeg+KwnzJ3oRelbiZ+NcSGs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Fj3wAcZOPwGktE0u98fmDjZtntCgze0OiDJ7i+CFdxVek2mLXRpLvWGsxpiL0DgsdQiemFPrbIE5IrTU2iOL1DWJ0XF1VAb3TIj7CcXanRBDsnyOEHfKK5LdjWiX2xnL8PUwVFFoAiIYrUrf8Ec8c9Eepp0yCLSzNo038yyPCkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=VVl8JQpi; arc=none smtp.client-ip=209.85.222.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-ua1-f52.google.com with SMTP id a1e0cc1a2514c-7d5fce59261so2632456241.3
        for <netdev@vger.kernel.org>; Sun, 18 Feb 2024 23:57:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1708329428; x=1708934228; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Oey3ZN4EIWUJzNAo3Boteeg+KwnzJ3oRelbiZ+NcSGs=;
        b=VVl8JQpietD6ymCw8P666kr9JYEJOP/6jeXxWYk9wcv7MiDlOZHDq7j78X8ip5RtIL
         oGOg9zYfQV0Sd4wVp+AvOhyd1zR/usG2RKVc8dc9MV8tXFrH2CeZQ0YWWa9evUyQJQ/s
         drcPWv7qhkki+1T1yyXOIwpaLakGZoChRSfvzccCuQY3XjVtz7jCXViDDBb1vrPa2K8Y
         +EcJXvaxSF6pM2Uk9/oetGyr/zPuk4PGPok/1+mdFuioVNYGLnilS9zjbbOY1YFcZHCB
         B15hP2Ev/V3gsUF7j4dhNYeKiiKrTNge27kTORfRqqI7x30iJgnGqpsogtpL9MH66rbC
         tBxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708329428; x=1708934228;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Oey3ZN4EIWUJzNAo3Boteeg+KwnzJ3oRelbiZ+NcSGs=;
        b=ObpV4x1RebxXiShuvn9UMiDsYsloGSUIRFJhH1w3Jswxx6RfxLpnAfTp7rBGOJtglG
         +K9MsIgE2SE8yLjdkFBUWMfaaR2JECnBhLRkt0xdHSOQkYGlDvDlVpq/e/dAEqRKyXuH
         RDrCdaR+NWuSP6XoCChyenRHREFo8miaHYaBNN2IXA5kmZcWffJUux8g3fEqJ+sraYsN
         0jy84xbxz7KtZM73uJUXXCWAz+qlzCT5SlEnxYyZBv1K3idSaRpKmu1oxAR3VYA9z/X2
         zJtIs8g04rOEQtGFu71s4ok6phhvi0uZcx3qr2QNC5qpM7BZwXiDr6t70o7hQrLH3jJ6
         lH2A==
X-Forwarded-Encrypted: i=1; AJvYcCX5kVeNuqV3wQMQnaAgQohZDtiqpmMmv4JJG4XZo0hKgimUDIpl8zzhmCKfZVyZsjK1E1dX5XSDdi0flHF/gfsDsrzT1eVB
X-Gm-Message-State: AOJu0Yw9AoUbuB4exEGrsqVHu421/GpoYHmIuxZD2rWzQa4VFttMWN0a
	wp26zGfihbZ3lyv1QTfmJpTaNkvLZlx8Vii/3egbipfhepY/c4f4n9jC8R3Iky4NcLufbF5CVT7
	wpuON4YvWUkT/QVj5rE71BLOob9J5nHRUG5gxJA==
X-Google-Smtp-Source: AGHT+IGkQijUvXHSNfPb2HxhHlZq4HKDdG92W7zvsTAzBpVd1PSmvpJBFeiTOYN7sqVAKs/Q5f+Y2wj1Qp78qPvhlpQ=
X-Received: by 2002:a05:6102:409:b0:470:4cfa:c814 with SMTP id
 d9-20020a056102040900b004704cfac814mr2022895vsq.24.1708329428140; Sun, 18 Feb
 2024 23:57:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240216203215.40870-1-brgl@bgdev.pl> <20240216203215.40870-3-brgl@bgdev.pl>
 <71e9a57e-8be3-4213-9822-45dfc5eb7ceb@linaro.org>
In-Reply-To: <71e9a57e-8be3-4213-9822-45dfc5eb7ceb@linaro.org>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Mon, 19 Feb 2024 08:56:57 +0100
Message-ID: <CAMRc=Md1PzoZFDWHWRufktmMiBE0Dp7eYhecpwuaS3AW-Y_g=w@mail.gmail.com>
Subject: Re: [PATCH v5 02/18] arm64: defconfig: enable ath12k as a module
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Marcel Holtmann <marcel@holtmann.org>, Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Kalle Valo <kvalo@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konrad.dybcio@linaro.org>, Liam Girdwood <lgirdwood@gmail.com>, 
	Mark Brown <broonie@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Saravana Kannan <saravanak@google.com>, Geert Uytterhoeven <geert+renesas@glider.be>, 
	Arnd Bergmann <arnd@arndb.de>, Neil Armstrong <neil.armstrong@linaro.org>, 
	Marek Szyprowski <m.szyprowski@samsung.com>, Alex Elder <elder@linaro.org>, 
	Srini Kandagatla <srinivas.kandagatla@linaro.org>, 
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

On Mon, Feb 19, 2024 at 8:31=E2=80=AFAM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 16/02/2024 21:31, Bartosz Golaszewski wrote:
> > From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> >
> > Build the ath12k driver as a module for arm64 default config.
>
> This we see from the diff. Please tell us "why", e.g. "Board foo with
> Qualcomm baz uses it."
>
> Also this should not be in these series. It only makes the
> power-sequencing patchset bigger, without any real reason.
>
>
> Best regards,
> Krzysztof
>

Got it, I will resend it separately.

Bart

