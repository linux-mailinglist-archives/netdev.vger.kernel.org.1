Return-Path: <netdev+bounces-245849-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A70BCD9423
	for <lists+netdev@lfdr.de>; Tue, 23 Dec 2025 13:31:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1A055302C8CF
	for <lists+netdev@lfdr.de>; Tue, 23 Dec 2025 12:29:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 082813346AB;
	Tue, 23 Dec 2025 12:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="QOtj+tOn"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F32E332901
	for <netdev@vger.kernel.org>; Tue, 23 Dec 2025 12:29:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766492989; cv=none; b=XuzvKelM4qYWf6drWbUUFcB/9aFri40xc4me8Cw5y3I5msG6FWzZVI2+46efrdgOK3I4UrZlIa4Kgu8gWPVT2nSqsz4+F6sNHmu+3d4DclaTTISLkAKa+icGdcjgtL1eUfVtQkb7cYoS7kvdtUtfH/Ah5SuZxvUO5SImyz5Kixs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766492989; c=relaxed/simple;
	bh=h6OXWNpcTZmo3fq5/Hn/HjwTOV2GaxRDyFEHGkPfSDM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BI6PzIHYh8mrFJG4BTFT4fExPenfRLwcNix1mqcgHsnoByD6kCzMKB7ELLFlZ3u877KVImnLqRL70FgQiN3tKDl2cL/oU+Q7ayM3i/LOZzHRpWtq6Pi9lpS2CtOugG5A6ScHAInbIUnpCRpUpvcEN0313IYIg1y3HnRckD7Oxug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=QOtj+tOn; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-37a33b06028so43409491fa.2
        for <netdev@vger.kernel.org>; Tue, 23 Dec 2025 04:29:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1766492985; x=1767097785; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h6OXWNpcTZmo3fq5/Hn/HjwTOV2GaxRDyFEHGkPfSDM=;
        b=QOtj+tOnk77e/E8O8/ET07YerSFV0MRT8YSfTVTk7gl9w07eOiuKVn4sm9friFlEIk
         2GH8gACOi3UtbF+jOtSpZfdWlDtejs1sp1UndIjaaNWO87LJUqyRP5wmYr531BXA3Y9y
         F5IQOGkct3gm7B18p66Bvo3RQEEuTeX1LvtU5RQTsCPqGHQLcyxMuDFLepICVnI99h3i
         nReSlsQP+M5UwpU6kZT3keayPL9hEuPTACUIbgJOcVui+ev/lcuQTlzmEkM2gByWn3Xj
         KJJ4l+Zx3vrbLIlpXewyqP8JZHpNCk1CiCDs1vdCv4dwoFlRFT5vu29XUVzZoasviJOu
         PjGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766492985; x=1767097785;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=h6OXWNpcTZmo3fq5/Hn/HjwTOV2GaxRDyFEHGkPfSDM=;
        b=VnZkKGkcGFeKskkca9ikhGGGMqkkxNYaclYgOWgDY9UZ+c88MUjGZv1t+9X9S8Y3kx
         lp9QzIgk+fGWFmHZN+34bm1QY5WVV+o8/7I2lYQ42QRWnq2tiq4DkcIj+G9PL4Hi2a9+
         f/D9HuFOeEkOWWwvgJlqZ0zKgfIKaK/XRgZZ00Ti8Xi7TrAjsK1SP0vF6BrnRtUDl83V
         jfAE1kLd+paitaTbRmh4NkNG/SP0AoSwS036LLeQQf146oDfWg962CHBA12muMCMLvY1
         le2OUSBq5mYsHlaTvLxwCz7/arSnmN7f2EimG63f2xkNbKQeAgeFbRcikJieKqDI8CGL
         O5jQ==
X-Forwarded-Encrypted: i=1; AJvYcCVp0xKvNpd+MFyuvWcpINJK2fLTQLejI+TV1iEJQmBbmKP65I8ywbzm0r/Sjo/WaqMeBF84FMQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxADqliF1Pg0wAwWPZ6SH6cxDZ9hiyrJnOQvZuCQDEmITC47Mg9
	dhYc2SHtn653fE7Gvf1bczLLfdmgXpPMyubQGXV/pSwN0cq2XAC3c/2A16O2mwrW8LJbq/ca8Xs
	s744NJmKDYzGeFNWpNDFtqmCmypaq58j40O9QKxpzSA==
X-Gm-Gg: AY/fxX6Hgs7yM4KdtzbLGifJFQ8b25ZOh3GNvxRaE7oyueLVXvOQFRtMTnBQ9jZJ+/3
	raFDVBL9Pq6WHFtNNH25yMOCww0CnGWlTKfT9Y09T+/E+1GQ4VxHq6alG1wtXqESFQH7WQHILx+
	HklznkklliKBMe+3JJonQSGzsYMqUmQ8nKXP3ThgsHiCMVWYlFmdRqLhFUaNDTM/VJ4ICMvvnRk
	4mp5IYPh5eRFcUVdzrHf9bkZhQqTvvD+myV4SfNyKVpWAJVHjSFsIdacyHx995sK3jmLsNZ/vJy
	vV1FGL+JAqC1EL1Vb80mbfJLIyYX5tca4womwA==
X-Google-Smtp-Source: AGHT+IEBOhkGPqyyAQ1vT8Z9LQwcalYcPegEonjbT0vsHKYCaYN4/Y7HunNV2ZOFRdC/NVauUA6SJStJulcaNDLUuvw=
X-Received: by 2002:a2e:a7cf:0:b0:37a:45b0:467a with SMTP id
 38308e7fff4ca-3812158ffe9mr48663611fa.5.1766492985167; Tue, 23 Dec 2025
 04:29:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251219-qcom-sa8255p-emac-v6-0-487f1082461e@oss.qualcomm.com> <51c7048a-52dc-47e1-97c3-2aa0d6555643@redhat.com>
In-Reply-To: <51c7048a-52dc-47e1-97c3-2aa0d6555643@redhat.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Tue, 23 Dec 2025 13:29:32 +0100
X-Gm-Features: AQt7F2oUd4L6z6INXPzdFurDETLUQbJOAVCbMRjbjb79EkFyrJjgdrXB0o2w2nA
Message-ID: <CAMRc=Me7++jcT8SpA309F-0XoZvHPQF2Hfr17+Kt=Jmdy635pg@mail.gmail.com>
Subject: Re: [PATCH v6 0/7] net: stmmac: qcom-ethqos: add support for SCMI
 power domains
To: Paolo Abeni <pabeni@redhat.com>
Cc: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Richard Cochran <richardcochran@gmail.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
	Alexandre Torgue <alexandre.torgue@foss.st.com>, Vinod Koul <vkoul@kernel.org>, 
	Giuseppe Cavallaro <peppe.cavallaro@st.com>, Jose Abreu <joabreu@synopsys.com>, 
	Chen-Yu Tsai <wens@kernel.org>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
	Samuel Holland <samuel@sholland.org>, Matthew Gerlach <matthew.gerlach@altera.com>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Kevin Hilman <khilman@baylibre.com>, 
	Jerome Brunet <jbrunet@baylibre.com>, 
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

On Tue, Dec 23, 2025 at 12:42=E2=80=AFPM Paolo Abeni <pabeni@redhat.com> wr=
ote:
>
> On 12/19/25 12:42 PM, Bartosz Golaszewski wrote:
> > Add support for the firmware-managed variant of the DesignWare MAC on
> > the sa8255p platform. This series contains new DT bindings and driver
> > changes required to support the MAC in the STMMAC driver.
> >
> > It also reorganizes the ethqos code quite a bit to make the introductio=
n
> > of power domains into the driver a bit easier on the eye.
> >
> > The DTS changes will go in separately.
> >
> > Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> > Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.co=
m>
>
> Quite unusual SoB chain... I think it would be better if you could stick
> to one or the other; also the subj prefix should include the target tree
> (net-next in this case); finally...
>

That's totally normal. I did most of the work on this series while
still on Linaro payroll and credit is due. However I'm respinning them
now as a Qualcomm employee and it's no different than taking someone
else's patches and resending them - you have to add your SoB.

> ## Form letter - net-next-closed
>
> The net-next tree is closed for new drivers, features, code refactoring
> and optimizations due to the merge window and the winter break. We are
> currently accepting bug fixes only.
>
> Please repost when net-next reopens after Jan 2nd.

Sure, thanks.

Bart

