Return-Path: <netdev+bounces-238359-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 93245C57B42
	for <lists+netdev@lfdr.de>; Thu, 13 Nov 2025 14:37:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 03929342649
	for <lists+netdev@lfdr.de>; Thu, 13 Nov 2025 13:34:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 607A61FF7BC;
	Thu, 13 Nov 2025 13:34:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="vy+ryhuN"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DB6D1C3306
	for <netdev@vger.kernel.org>; Thu, 13 Nov 2025 13:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763040848; cv=none; b=m/7sN9Cwg7xfLymc3EOIx8eXfyYYiOkRkY28R/KLybKbRdfOIKIj6T5y2e20HNKdSxOjyogrspU0z50ib2AoQ/UzroVgfxZF5wU530q6lLkgJuS2R+/ddaGfPsU700zouentbmaEdN+cFRGwTxZtpwSUHHbghnxNN/xCt9daPkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763040848; c=relaxed/simple;
	bh=X3T5b32titXjcOm79yLB9wCfQXafLDscPPDjsVlvEkM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZUnzi4TPF/ZmMvfybkpjD8oYa8mpyO8ZasR9adMSOkP/8ciziJ9m4G5ryI5FdtR2prlkIbPYP7pzlSA6GOsGuB2BBCbhNSeqk3Zz1EuHndJuLSlKd1qMSdJkK/pltH+NtgMRXB37JihSesT5yLH6wpD8BRv6rJzm3tRMcTCWGaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=vy+ryhuN; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-5958187fa55so411391e87.3
        for <netdev@vger.kernel.org>; Thu, 13 Nov 2025 05:34:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1763040842; x=1763645642; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YsN4YM2OD91GPnt+6/gPAgCxZS5BYL1HgW1NfsOpFuY=;
        b=vy+ryhuNq4qcGtCghzOFqgwIM5zZKuYvPYTuwSNxrE7kyBvys+KzBlDkmx3uONX9lT
         j2vYL0bDq+DvY+L1MCML+GUSf1y4T/mxpREsv33GwQBBoFCif2Tm8Wv4Y777ozlr28+J
         AkPkjnTKbUxp9ST+vzsedtyB6VxybB80O0k5vNENUI/rnk1ON4qti4/g8MGpywp1f2SV
         O264bvSwjiILHX+Ec2bDygwiVzNevkSvANEirbClnSGLhmJpjD2YW1Pdqpq03XGGb/U6
         FSz7WbLGOEOoq5piJmbQ/cjQZyXxpg/zkTiWD7xLHU1SOHShmsj7oSIQGm3hI2hWIquz
         1dsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763040842; x=1763645642;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=YsN4YM2OD91GPnt+6/gPAgCxZS5BYL1HgW1NfsOpFuY=;
        b=ZyXCG+11ug+iOKl3Edm2VQNeKpOIsCWzD/e5UJhKa4i9JJvtipgXNJdJ6wBNY/Ec2s
         NZsYINnfJOqwxDJZnWuDMno4z1fawU7PLuNLfnYutpZ+XXaWkz0AVc2q/JwJZtKR5s7D
         lCzfdcWkYltvGQxUMhJrJIpaxnwMIAH/XrF33narlhm8KilLHgYKRKSGoQ7floCMXDFA
         yYxRIc9TEhR12bwaMu8QpAj+6mmNsNjcfnK/kY0iFVT0SWbqZRw841z/1K+dIsT7wxbB
         tL6cOrXp50INAlYtFLUj3lAMTt6Tba+xO+dL2u4OM+cOpsk/KcB6wuZ6PIZtstK+Ibot
         WAfw==
X-Forwarded-Encrypted: i=1; AJvYcCXoptXNXarWEWrBGDEExmSrNB0Y1/a7y92nYDQq+HWunZQraigMTw5IwDlUlnisEqpP81QlZOM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzNDPXi+hSuOb7jvTj25AzHmOEN88vblymyw5ndM1LuYMHNfADU
	XVoSSOs71yHsU4eWm+OqjjEahzq2RXxoG7OyJKM+RgZjXnmmw6qziy72mpglxA2fOoKnnUZUCyk
	iGj6mhEdvuWg/DE3NMYoWnDm/cOS3FtH3Y/s3pMfSfg==
X-Gm-Gg: ASbGncvyoxuOns0BHqKMDhLcZC7CldWTtoyQL9odjh/Opt6pTFyzBLCar5/Jclo0BfE
	z5WjIsCs/EczhWCbt5NN/pevntCmuaD9fRZSTF3GNNSfO23f9mY5ctBYL3J5SQMvxDeoS7biYiP
	woiz/UGtwkLraQjk9Swaw3EKNoBwl1hfpxfGfFud7w3ScjrTt37bUcTiM02zlAxBBCFNu4TVDLU
	1t9Mx2lMPlm65jdSl3L6aUc4zoKEiRGdzwVyEk0opuJEBJhD5Owd/Y6NUenL2oOrfFJAp3NQY4T
	i8g0bVd4keVgeh97
X-Google-Smtp-Source: AGHT+IGbk7EKeTNsNxEBH5I9gU0KP7DFoTOQ0KZ1rqq8QfnOf06KK/0zwgmGPB54vhErcQD0MD3GXM8/DDcCgOFKTlQ=
X-Received: by 2002:a05:6512:12c4:b0:595:76d6:26ea with SMTP id
 2adb3069b0e04-59576df8d25mr2057027e87.23.1763040842304; Thu, 13 Nov 2025
 05:34:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251107-qcom-sa8255p-emac-v5-0-01d3e3aaf388@linaro.org>
 <20251107-qcom-sa8255p-emac-v5-4-01d3e3aaf388@linaro.org> <86df9697-af58-4486-93de-b01df5ba13a6@oss.qualcomm.com>
In-Reply-To: <86df9697-af58-4486-93de-b01df5ba13a6@oss.qualcomm.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Thu, 13 Nov 2025 14:33:48 +0100
X-Gm-Features: AWmQ_bmy5PXcBPeRnFHjyddkz8qETTfAAx4qoRDDnDLUNs7204p7vqOqHs_5gtY
Message-ID: <CAMRc=MfMQ3P-BK239953S9sTAe1_qSc_miWEFDNu83frE3aSqA@mail.gmail.com>
Subject: Re: [PATCH v5 4/8] net: stmmac: qcom-ethqos: wrap emac driver data in
 additional structure
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Cc: Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Richard Cochran <richardcochran@gmail.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@foss.st.com>, 
	Vinod Koul <vkoul@kernel.org>, Giuseppe Cavallaro <peppe.cavallaro@st.com>, 
	Jose Abreu <joabreu@synopsys.com>, Chen-Yu Tsai <wens@kernel.org>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, Samuel Holland <samuel@sholland.org>, 
	Matthew Gerlach <matthew.gerlach@altera.com>, Neil Armstrong <neil.armstrong@linaro.org>, 
	Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>, 
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>, 
	Keguang Zhang <keguang.zhang@gmail.com>, Shawn Guo <shawnguo@kernel.org>, 
	Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>, 
	Fabio Estevam <festevam@gmail.com>, Jan Petrous <jan.petrous@oss.nxp.com>, s32@nxp.com, 
	Romain Gantois <romain.gantois@bootlin.com>, 
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>, Heiko Stuebner <heiko@sntech.de>, 
	Chen Wang <unicorn_wang@outlook.com>, Inochi Amaoto <inochiama@gmail.com>, 
	Emil Renner Berthing <kernel@esmil.dk>, Minda Chen <minda.chen@starfivetech.com>, 
	Drew Fustini <fustini@kernel.org>, Guo Ren <guoren@kernel.org>, Fu Wei <wefu@redhat.com>, 
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>, 
	Geert Uytterhoeven <geert+renesas@glider.be>, Magnus Damm <magnus.damm@gmail.com>, 
	Maxime Ripard <mripard@kernel.org>, Shuang Liang <liangshuang@eswincomputing.com>, 
	Zhi Li <lizhi2@eswincomputing.com>, Shangjuan Wei <weishangjuan@eswincomputing.com>, 
	"G. Jaya Kumaran" <vineetha.g.jaya.kumaran@intel.com>, Clark Wang <xiaoning.wang@nxp.com>, 
	Linux Team <linux-imx@nxp.com>, Frank Li <Frank.Li@nxp.com>, David Wu <david.wu@rock-chips.com>, 
	Samin Guo <samin.guo@starfivetech.com>, 
	Christophe Roullier <christophe.roullier@foss.st.com>, Swathi K S <swathi.ks@samsung.com>, 
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	linux-stm32@st-md-mailman.stormreply.com, 
	linux-arm-kernel@lists.infradead.org, Drew Fustini <dfustini@tenstorrent.com>, 
	linux-sunxi@lists.linux.dev, linux-amlogic@lists.infradead.org, 
	linux-mips@vger.kernel.org, imx@lists.linux.dev, 
	linux-renesas-soc@vger.kernel.org, linux-rockchip@lists.infradead.org, 
	sophgo@lists.linux.dev, linux-riscv@lists.infradead.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 7, 2025 at 11:54=E2=80=AFAM Konrad Dybcio
<konrad.dybcio@oss.qualcomm.com> wrote:
>
> On 11/7/25 11:29 AM, Bartosz Golaszewski wrote:
> > From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> >
> > As the first step in enabling power domain support in the driver, we'll
> > split the device match data and runtime data structures into their
> > general and power-management-specific parts. To allow that: first wrap
> > the emac driver data in another layer which will later be expanded.
> >
> > Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> > ---
>
> [...]
>
> >  static int qcom_ethqos_probe(struct platform_device *pdev)
> >  {
> > -     const struct ethqos_emac_driver_data *data;
> > +     const struct ethqos_emac_driver_data *drv_data;
> > +     const struct ethqos_emac_match_data *data;>     struct plat_stmma=
cenet_data *plat_dat;
> >       struct stmmac_resources stmmac_res;
> >       struct device *dev =3D &pdev->dev;
> > @@ -801,13 +822,15 @@ static int qcom_ethqos_probe(struct platform_devi=
ce *pdev)
> >       ethqos->mac_base =3D stmmac_res.addr;
> >
> >       data =3D device_get_match_data(dev);
>
> This change could be made much smaller if you kept a drv_data
> pointer named 'data' and called the new one match_data
>

I prefer to make a clear distinction between the two.

Bart

> but I don't really care either way
>
> Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
>
> Konrad

