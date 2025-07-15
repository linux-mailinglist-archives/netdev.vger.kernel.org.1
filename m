Return-Path: <netdev+bounces-206978-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE9FCB05051
	for <lists+netdev@lfdr.de>; Tue, 15 Jul 2025 06:37:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0D2D53AEA53
	for <lists+netdev@lfdr.de>; Tue, 15 Jul 2025 04:36:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 271972D12E1;
	Tue, 15 Jul 2025 04:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="A43henmj"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93F0B25D55D
	for <netdev@vger.kernel.org>; Tue, 15 Jul 2025 04:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752554228; cv=none; b=fTg+tSqahLVVQDQ+UrD3VTZnFlsNS1w6A4VjMgRArB93TM/weZIIXrlGcerf5BlQ9aDZJStL061pAqt+/yWFbgdyofV9IY79Am/K2hY3kblIe8bK4/xyr38wKUssBiD9Xb9TZOFl54YxmAMx5YZe8AlzgiE590mHgfjwDu0abOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752554228; c=relaxed/simple;
	bh=HEym2MfRYDRe1WStyHMOT8vdThlsV2VAJ0myxALEAgk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kI0fB/3kMGgdE/XEMQfDtbb9Gv+hjl4uFd9TEzKgAs95h8mdzad7QbZj1QrB8jyzvAi9jJA2riiAgYsv/gBybfoiyYhOXjdchXtVhh5w1euCf0vBIYTMznQcU5dn/g9ADf4bYhBhLb8U4a1BK7exUAu+XK1FOVAqqID73nrFHLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=A43henmj; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-b31d578e774so5061140a12.1
        for <netdev@vger.kernel.org>; Mon, 14 Jul 2025 21:37:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1752554226; x=1753159026; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Gqg4UcH4HOCD8WdGE4+ik0rgx/yjtc/u1ELlwLDaNkk=;
        b=A43henmj4KmroWVbHwKFQPtrnX1jzu3bqWZrGcEcn43gimxYAkUn3PRoJ30w9fVUBQ
         0HYPp4Ti/KOmPGMhBaqOsQ5R7qRKn3IxWkeMxxoAp9qwQb3xwAMy9nJYouryCge+thrA
         5GkzURi4DmrwjmLYQ3JDfXVRm36S1Fs7MGY3Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752554226; x=1753159026;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Gqg4UcH4HOCD8WdGE4+ik0rgx/yjtc/u1ELlwLDaNkk=;
        b=MRRhDNzggJqJJkYP7n3jjPMZGxze0xxJbEOFkmu+2S5nZ4WVas5rufrb5N9zqqpEJJ
         HkrzbPuGQSGQc6gGSfi0z0eMwLsyoBI5XCt60WwA6RTI8dX1Onvz2viDDqA5v/UbmsKu
         YteFS6zNHeJg54SO0DIaW3SOFd1ai2u0VZZdlo5L1r6HvKOq4EykUN6dopobywt/L9gM
         xdqIlijXnwT7Vw5AXPN2zxI+Mg1oxB5CH3uSLtTSfy4l2paei/ITIexwTP0X0e2iqeXT
         pHCQ7SPuukmDaOtzekX00PgOsqgCBagKU0rmvBfOJJZdSI6dOjnKcxHq2FQbayJM2GTO
         Y5ww==
X-Forwarded-Encrypted: i=1; AJvYcCXVnetSQUgDCi/g9U8oBVTzJo8AjsmLS5qm51xGvcmdEL/9wcQOT2+vEBHEeNAaLQeWYAKXNkA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yypw31XC/IXATcD7DfcrRPX4r4c98bjbF1nPC3zzZGlFZnBU4zU
	iXUrXyW8Xbo3sYQkXXiJZ0ZopNGdILQs6ug5dvF26obib3FGnK0bngiuWMZFM91d2D7k9nZFWcd
	3WrgXjKGFdfeSiKL3pEDtQ8LByLPv4nUVK1nd3DzO
X-Gm-Gg: ASbGncu4uWlhELoUf30MZ0dUBRvBUGNsj+N2Pa9N+wQIEXpJqTaFSgDNKP39IPJNEQI
	NOAqdLjpRsQkz/gLsDZ/pchAqI4ng/HcZx01dJjxVbdJ0JNQnW5wHGSrvsIVKP1364L9kC4Hgub
	uP5normFBA5th0ZOjA1UtigHfqLHGisoOPnCJYPIfk5dOo61+oogWBQlAy5VT56rBM5WLLzRTjf
	1G+IaiA+jCdGvyfe88MzM641sQ24hR2AEAZRC5wCsxMbQ==
X-Google-Smtp-Source: AGHT+IHf1xc3dLDnNYF/fDC0d2YbPGxvPK9FwAjwgXDKEU1kkJL2K+WT5K+79jl9PQ6eV0yj7I0MMHxdLoUbmyObj2Y=
X-Received: by 2002:a17:90b:57ef:b0:30e:6a9d:d78b with SMTP id
 98e67ed59e1d1-31c8f88d387mr3132859a91.12.1752554225889; Mon, 14 Jul 2025
 21:37:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250624143220.244549-1-laura.nao@collabora.com> <20250624143220.244549-19-laura.nao@collabora.com>
In-Reply-To: <20250624143220.244549-19-laura.nao@collabora.com>
From: Chen-Yu Tsai <wenst@chromium.org>
Date: Tue, 15 Jul 2025 12:36:52 +0800
X-Gm-Features: Ac12FXyo_hm6-LevP76Ht3AHw10mSGdmwELcsNXs6PZZNLb0jYOFlkoLp35KGco
Message-ID: <CAGXv+5ERCTTJVfgfY=LLTKasz7RpTdpPfHJDKtKiUfcYyrS8uQ@mail.gmail.com>
Subject: Re: [PATCH v2 18/29] clk: mediatek: Add MT8196 adsp clock support
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

Hi,

On Tue, Jun 24, 2025 at 10:33=E2=80=AFPM Laura Nao <laura.nao@collabora.com=
> wrote:
>
> Add support for the MT8196 adsp clock controller, which provides clock
> gate control for Audio DSP.
>
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collab=
ora.com>
> Signed-off-by: Laura Nao <laura.nao@collabora.com>
> ---
>  drivers/clk/mediatek/Kconfig           |   7 +
>  drivers/clk/mediatek/Makefile          |   1 +
>  drivers/clk/mediatek/clk-mt8196-adsp.c | 193 +++++++++++++++++++++++++
>  3 files changed, 201 insertions(+)
>  create mode 100644 drivers/clk/mediatek/clk-mt8196-adsp.c
>
> diff --git a/drivers/clk/mediatek/Kconfig b/drivers/clk/mediatek/Kconfig
> index cd12e7ff3e12..d4c97f64b42a 100644
> --- a/drivers/clk/mediatek/Kconfig
> +++ b/drivers/clk/mediatek/Kconfig
> @@ -1068,6 +1068,13 @@ config COMMON_CLK_MT8196
>         help
>           This driver supports MediaTek MT8196 basic clocks.
>
> +config COMMON_CLK_MT8196_ADSP
> +       tristate "Clock driver for MediaTek MT8196 adsp"
> +       depends on COMMON_CLK_MT8196
> +       default m
> +       help
> +         This driver supports MediaTek MT8196 adsp clocks
> +

This is part of the AFE block, and really should not be a separate
device node nor driver. The AFE driver should internalize all these
controls and ideally model some of them as ASoC widgets so that DAPM
can handle sequencing altogether.

So please drop this patch, and also drop the entry from the binding.

I've mentioned this to MediaTek's audio and clock owners, though I
assume this request was somehow lost in the process.

ChenYu

