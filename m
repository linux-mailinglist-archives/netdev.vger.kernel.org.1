Return-Path: <netdev+bounces-220227-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 08DEDB44CF0
	for <lists+netdev@lfdr.de>; Fri,  5 Sep 2025 07:01:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 37DBC7A89FF
	for <lists+netdev@lfdr.de>; Fri,  5 Sep 2025 05:00:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8AFE21ABB1;
	Fri,  5 Sep 2025 05:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="EqE4M6jg"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E60946FBF
	for <netdev@vger.kernel.org>; Fri,  5 Sep 2025 05:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757048491; cv=none; b=gGeiS5oiN2E0vpg4r6D2ES5xzta5URNi2+4AB/gJVFtmOIXco9mREZoHJsb0PkpbpV/C5mYw8JW4gxKEgRFAGG7r9jUAEOpVcI5r599IofWAotv0dJiJ0g4d2RtqTEcj95LwUM9bVaL+X3CmM/srSQY2NlZ5EcFFibUuQ8N2MBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757048491; c=relaxed/simple;
	bh=njvK5FtQ51xwKW4s0pYsz4x7aMPMIyJMS4OWthiAzGw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nKk51SAnkD7fQZlEaCAVlJ2KdzLrt3mMu69oLMKH2LZhoLK1Qcm3wVA93Hu0pTpmBTvDupKpicitW7bmnAPsbd3epxjZ+Q6qwl911pT3/WbsYBDpuJlKdlQjbVMLR8/T/BfWx+ZJEUZDobOIToYVuE5dOO08ijW2/ijH4flc6b4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=EqE4M6jg; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-55f6186cc17so1657076e87.2
        for <netdev@vger.kernel.org>; Thu, 04 Sep 2025 22:01:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1757048488; x=1757653288; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I3pbQnf8CUqRojAhpUlOIMWVPCuywXIR601pJXOx+Vk=;
        b=EqE4M6jgR5rIe5A3xGBaoGQXZmnZP4E/gqVhNrv/kjCXnKsX9khbaYkyXBKGzPb+Bd
         zrJcN5xf8rSCZemJI0eE0QKlXb5vXzm70IvIBc9x+vP0uP+mbJUF3L4g/vn4kZQaNLl7
         S1hPR0QEyIcqbXYwqikiaRaU28v05PdWrCe6o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757048488; x=1757653288;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I3pbQnf8CUqRojAhpUlOIMWVPCuywXIR601pJXOx+Vk=;
        b=NjSknim+DHPuPQn/WISOlAUTwmwvNMXj61MMmxqvBkkYCW0pw8WPzVfaGXAHVF/i0L
         0b5PzRO/sX1hnAyBAETgOmt3TjexoOHQTHjkDo07vqE4jSsR8BBQ8DiMhcvApuZb8V15
         iExiTWfre8gNRx+9UGWIJnjbenM0e+ypyt6uM5BCaXMbwJRu85EoETjz0Y3kqV+dxMfe
         dxHplmxUF/og5SAecPVC6b4UzC3/HYrN2xisMVGbWHvSZqPiMlGznbVOReSuFTwiY1RD
         Bbs8bd1YbmU46Mm98mmCV5dTlX2wfr+I5kNm6XDSLhLP00iJ1ffYTR17v0VCS+5KcTp9
         D5yw==
X-Forwarded-Encrypted: i=1; AJvYcCWkUvVD7Dg8F4tBQppDbJ1RifH3waWaDI++LSfgJ9cZ2jBDZCU4/pqpUEmj94Z2R0PpzwEFamw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxfLt58kGq+Xtr8/FrDIkC9VAskS+TAosHBPAlrXUlOW5P4fUvl
	7gaMrGR6cGFOukIElr5Or6R3UsCY2nMOkxyFMh79F2Hhf6K3AnNKf61nwCeUxVeMqHNFgSwdYou
	goa/r+0zu9jdzZuX4IYB+i8+5bvSo9IuTfHROA/pL
X-Gm-Gg: ASbGncv0X2GeR2WCYk9JlgJfbqrzChARF7SAYVOoehGNNqxlzk8OkKuOdwPRP3pa54l
	mAt8kfr/b00LSHWV17GgJd8pS+YNJXlwhWrRemyZO/jfFMDkH4EezTqfhZ7J41bulyD3GY2c3IJ
	tXUW2gh4Sn3v7VBNRgtxndiO7OqrwhuhnitXHtkQsVt1e3s/p62fOUkH9dk5yip+h89AzlZrVhD
	L6o2bt8rJZjY2BSadc21nVw0EJdvUP0c9DYJw==
X-Google-Smtp-Source: AGHT+IG10f/KUXsl9teEaeQj7H79dcAZoPGx48y81i6F/mMxgob5Z7ShaCVyVzMRSRmKn/PqDEFL3jvm3MNUmJiY2p8=
X-Received: by 2002:a2e:be1d:0:b0:336:dd88:6a02 with SMTP id
 38308e7fff4ca-336dd886e73mr50101251fa.43.1757048487955; Thu, 04 Sep 2025
 22:01:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250829091913.131528-1-laura.nao@collabora.com> <20250829091913.131528-14-laura.nao@collabora.com>
In-Reply-To: <20250829091913.131528-14-laura.nao@collabora.com>
From: Chen-Yu Tsai <wenst@chromium.org>
Date: Fri, 5 Sep 2025 13:01:16 +0800
X-Gm-Features: Ac12FXxt8YDULnOSESMbWAKIOZ29Yui3hZN9Zs_7tmp-v_md5T4Hs_0EWckqSKk
Message-ID: <CAGXv+5E-EM6aMR3M=rk2HMT8qCn5J-zuqFtPJP0G1x7+Lj1gEg@mail.gmail.com>
Subject: Re: [PATCH v5 13/27] clk: mediatek: Add MT8196 vlpckgen clock support
To: Laura Nao <laura.nao@collabora.com>
Cc: mturquette@baylibre.com, sboyd@kernel.org, robh@kernel.org, 
	krzk+dt@kernel.org, conor+dt@kernel.org, matthias.bgg@gmail.com, 
	angelogioacchino.delregno@collabora.com, p.zabel@pengutronix.de, 
	richardcochran@gmail.com, guangjie.song@mediatek.com, 
	linux-clk@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-mediatek@lists.infradead.org, netdev@vger.kernel.org, 
	kernel@collabora.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 29, 2025 at 5:21=E2=80=AFPM Laura Nao <laura.nao@collabora.com>=
 wrote:
>
> Add support for the MT8196 vlpckgen clock controller, which provides
> muxes and dividers for clock selection in other IP blocks.
>
> Signed-off-by: Laura Nao <laura.nao@collabora.com>
> ---
>  drivers/clk/mediatek/Makefile              |   2 +-
>  drivers/clk/mediatek/clk-mt8196-vlpckgen.c | 729 +++++++++++++++++++++
>  2 files changed, 730 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/clk/mediatek/clk-mt8196-vlpckgen.c
>
> diff --git a/drivers/clk/mediatek/Makefile b/drivers/clk/mediatek/Makefil=
e
> index c415453e02fd..031e7ac38804 100644
> --- a/drivers/clk/mediatek/Makefile
> +++ b/drivers/clk/mediatek/Makefile
> @@ -151,7 +151,7 @@ obj-$(CONFIG_COMMON_CLK_MT8195_VENCSYS) +=3D clk-mt81=
95-venc.o
>  obj-$(CONFIG_COMMON_CLK_MT8195_VPPSYS) +=3D clk-mt8195-vpp0.o clk-mt8195=
-vpp1.o
>  obj-$(CONFIG_COMMON_CLK_MT8195_WPESYS) +=3D clk-mt8195-wpe.o
>  obj-$(CONFIG_COMMON_CLK_MT8196) +=3D clk-mt8196-apmixedsys.o clk-mt8196-=
topckgen.o \
> -                                  clk-mt8196-topckgen2.o
> +                                  clk-mt8196-topckgen2.o clk-mt8196-vlpc=
kgen.o
>  obj-$(CONFIG_COMMON_CLK_MT8365) +=3D clk-mt8365-apmixedsys.o clk-mt8365.=
o
>  obj-$(CONFIG_COMMON_CLK_MT8365_APU) +=3D clk-mt8365-apu.o
>  obj-$(CONFIG_COMMON_CLK_MT8365_CAM) +=3D clk-mt8365-cam.o
> diff --git a/drivers/clk/mediatek/clk-mt8196-vlpckgen.c b/drivers/clk/med=
iatek/clk-mt8196-vlpckgen.c
> new file mode 100644
> index 000000000000..c38d1e80a5ba
> --- /dev/null
> +++ b/drivers/clk/mediatek/clk-mt8196-vlpckgen.c

[...]

> +static const char * const vlp_audio_h_parents[] =3D {
> +       "clk26m",
> +       "vlp_clk26m",
> +       "vlp_apll1",
> +       "vlp_apll2"
> +};
> +
> +static const char * const vlp_aud_engen1_parents[] =3D {
> +       "clk26m",
> +       "vlp_clk26m",
> +       "apll1_d8",
> +       "apll1_d4"
> +};
> +
> +static const char * const vlp_aud_engen2_parents[] =3D {
> +       "clk26m",
> +       "vlp_clk26m",
> +       "apll2_d8",
> +       "apll2_d4"
> +};
> +
> +static const char * const vlp_aud_intbus_parents[] =3D {
> +       "clk26m",
> +       "vlp_clk26m",
> +       "mainpll_d7_d4",
> +       "mainpll_d4_d4"
> +};

The above parents lists are incorrect. What we want is to exclude the
"clk26m" parent and only have the latter three parents. That is why
we have the parent index table below.

So please remove "clk26m" from the lists that are used together with
vlp_aud_parent_index.

I apologize if my previous explanation wasn't clear. The index table
is meant for "skipping" parent mux values when the values don't start
from 0 and/or the values aren't contiguous. The number of values still
has to match the number of parents given. The index list below is
essentially saying that "parent 0" is actually at "mux value 1".

> +static const u8 vlp_aud_parent_index[] =3D { 1, 2, 3 };

After this is fixed,

Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>

[...]

