Return-Path: <netdev+bounces-206987-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 00F2DB050E2
	for <lists+netdev@lfdr.de>; Tue, 15 Jul 2025 07:26:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4B4A05605C5
	for <lists+netdev@lfdr.de>; Tue, 15 Jul 2025 05:26:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFB972D374D;
	Tue, 15 Jul 2025 05:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="UtP3Cg2J"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2069D35975
	for <netdev@vger.kernel.org>; Tue, 15 Jul 2025 05:26:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752557204; cv=none; b=GFffc3zOMRWetf4ffJCaYAQKzLCmHUhANlEeQn4ghnYzCLJNM8BeR2QfxJg70MGAPUyV7Qi0o2d4zIvuyGONSRcKosLfAr2AmkBUfQ8Q8JtBe7iaxRk8HNYUHlPAXj0POX45jaHIqCdFqYso+55ufKLOLDqyEGNtc77Bm5MhD2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752557204; c=relaxed/simple;
	bh=Vok3sAiLujP5+hTf7U9u6KkZUMEHc7gwTOuzgIEBsWQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Jo55et50PXtjhSO31UeNBs+QfwQ6zMhuxsnsKcopHvloyss8So/lwrotK22pgZmfqbr03liMuOTOTUShVjx8a1jqillXYVRjYN9UkfTPb3iHB11RtTSaUkuS3rhLVrp2obs2BpDcVcIrxAxsMsdtOiA4VSt2qgbqnNrpfIuUON8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=UtP3Cg2J; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-555024588a8so4485353e87.0
        for <netdev@vger.kernel.org>; Mon, 14 Jul 2025 22:26:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1752557201; x=1753162001; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EriOcw6Ti5BC4myF5JQ02kFXKB9Pwigas67q+yAyzZY=;
        b=UtP3Cg2JB1Gh2e3V/wnmeHpFpvPqHf03QPPoGYlyiv4DE3nTeYn9cIdoM+J4oB0vsi
         PLGdDg7yOAsnFwC6rLkIUTEldxTQyypC94wClnaRR+5ihly/0CW1wU6iWf/OupOtHKRp
         hBArkONR4cuiWfaXs/peRUT7zJ4sIuutOL3jk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752557201; x=1753162001;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EriOcw6Ti5BC4myF5JQ02kFXKB9Pwigas67q+yAyzZY=;
        b=muiV9HYWrjNyYO12uMOxnfYCO+9+tsGcHdPZ0Wrd0ydYwDtSM1Pbusy/6kcdDKq9eB
         d6E+GY/ewk2LvCH8NsAiv1a3fDdGXtpFG0RhPxKvK1mjM/G4UjxBvIcmC+aeMl5Lr7Gb
         E9K7Ov2W7d1cvmBiIvYujcddk0SyDQWDKJLr/yYz0Ok5hH1SlXDI/gZ2ovrCDNk7D7Ga
         whrfJv7ZXcE/jt30+iPdszQNbSkMxJudJj4tU5gYUL2wiNrYcomvLv+erdXOxZcRKwen
         OaUXCzlogm3ksET0ZTCWtRrQIqWMQYtBEZgM6zKeHK8UFdpUPJgwKgCAPs7jk+e0zEXT
         vfzw==
X-Forwarded-Encrypted: i=1; AJvYcCVlG+Z7qY9XN3JlTshAgPEznpLIs2sQGMWNhGh0kqYhSimoXru/B/FWlaL/S3AIAu69/iHvdvI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3/DvBFQBr4j0VhvlAQfcGukDTqiuRVm9spfSLXiv0B2Xh7Bq8
	GFw2KU74UKVLL7lGxwSM/NEwQJqhFJBJB5TSXoyIYgMFJlXqT1ze8yimR+xaHh9+9aKNeVoHl8P
	VFF81xg3SX3SnZI9vCFnqZj7M6vR7Ce1UaXnZRfNR
X-Gm-Gg: ASbGncsCQQ+ZzFJNStbcBLW97K0YEPC/m0hl6aJAiImEtWLJjDGkUJFJ5v3WTrHH+GK
	KY6PCGxnZz50DxxgCZG26NeGPsqD4i9XVHBtBLsrAoNw60P4x78zPLeTKB7i0pmUrl/YPFm2PYb
	RctS+gXGbdCdCsG2Ht6RH801W48SkNNoHkiyp47YXMUzGXJiPpfWOvd/wHA/1yhR3e3a+khJVwX
	h8wp5k9ex6h5786Bdlhy4YwRDv1XC9KbeI=
X-Google-Smtp-Source: AGHT+IEQf0W1yeQYNRbpUyAxFlgjb3kYw5Q0BNqfDsziWw7aP+1TqaYvLMXYRwQa9tomb76nSKuU56uoGnkXehDyLpc=
X-Received: by 2002:a05:6512:3b9c:b0:556:341b:fb0a with SMTP id
 2adb3069b0e04-55a044ca226mr6271614e87.15.1752557201192; Mon, 14 Jul 2025
 22:26:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250624143220.244549-1-laura.nao@collabora.com> <20250624143220.244549-13-laura.nao@collabora.com>
In-Reply-To: <20250624143220.244549-13-laura.nao@collabora.com>
From: Chen-Yu Tsai <wenst@chromium.org>
Date: Tue, 15 Jul 2025 13:26:30 +0800
X-Gm-Features: Ac12FXx0XfJFXA_DIIE4IblGQiwtiWyeXBGiD295gCS64kpCUO8jzl3QeCZ10ZM
Message-ID: <CAGXv+5EWEsLBS86G828ezpnD3x-MaC3F-AtyGFyzKxPvZ0GcAw@mail.gmail.com>
Subject: Re: [PATCH v2 12/29] clk: mediatek: Add MT8196 topckgen clock support
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

Another thing,

On Tue, Jun 24, 2025 at 10:33=E2=80=AFPM Laura Nao <laura.nao@collabora.com=
> wrote:
>
> Add support for the MT8196 topckgen clock controller, which provides
> muxes and dividers for clock selection in other IP blocks.
>
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collab=
ora.com>
> Signed-off-by: Laura Nao <laura.nao@collabora.com>
> ---
>  drivers/clk/mediatek/Makefile              |    2 +-
>  drivers/clk/mediatek/clk-mt8196-topckgen.c | 1257 ++++++++++++++++++++
>  2 files changed, 1258 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/clk/mediatek/clk-mt8196-topckgen.c
>
> diff --git a/drivers/clk/mediatek/Makefile b/drivers/clk/mediatek/Makefil=
e
> index b1773d2bcb3d..bc0e86e20074 100644
> --- a/drivers/clk/mediatek/Makefile
> +++ b/drivers/clk/mediatek/Makefile
> @@ -160,7 +160,7 @@ obj-$(CONFIG_COMMON_CLK_MT8195_VDOSYS) +=3D clk-mt819=
5-vdo0.o clk-mt8195-vdo1.o
>  obj-$(CONFIG_COMMON_CLK_MT8195_VENCSYS) +=3D clk-mt8195-venc.o
>  obj-$(CONFIG_COMMON_CLK_MT8195_VPPSYS) +=3D clk-mt8195-vpp0.o clk-mt8195=
-vpp1.o
>  obj-$(CONFIG_COMMON_CLK_MT8195_WPESYS) +=3D clk-mt8195-wpe.o
> -obj-$(CONFIG_COMMON_CLK_MT8196) +=3D clk-mt8196-apmixedsys.o
> +obj-$(CONFIG_COMMON_CLK_MT8196) +=3D clk-mt8196-apmixedsys.o clk-mt8196-=
topckgen.o
>  obj-$(CONFIG_COMMON_CLK_MT8365) +=3D clk-mt8365-apmixedsys.o clk-mt8365.=
o
>  obj-$(CONFIG_COMMON_CLK_MT8365_APU) +=3D clk-mt8365-apu.o
>  obj-$(CONFIG_COMMON_CLK_MT8365_CAM) +=3D clk-mt8365-cam.o
> diff --git a/drivers/clk/mediatek/clk-mt8196-topckgen.c b/drivers/clk/med=
iatek/clk-mt8196-topckgen.c
> new file mode 100644
> index 000000000000..fc0c1227dd8d
> --- /dev/null
> +++ b/drivers/clk/mediatek/clk-mt8196-topckgen.c

[...]

> +       FACTOR(CLK_TOP_APLL1_D4, "apll1_d4", "vlp_apll1", 1, 4),
> +       FACTOR(CLK_TOP_APLL1_D8, "apll1_d8", "vlp_apll1", 1, 8),
> +       FACTOR(CLK_TOP_APLL2_D4, "apll2_d4", "vlp_apll2", 1, 4),
> +       FACTOR(CLK_TOP_APLL2_D8, "apll2_d8", "vlp_apll2", 1, 8),

These aren't used anywhere in this driver, but they are referenced
directly in the vlpckgen driver. Maybe these should be moved over
to that driver instead? Otherwise we end up with some weird circular
link between the two clock controllers which doesn't seem correct
to me.

[...]

