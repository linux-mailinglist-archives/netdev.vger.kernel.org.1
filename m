Return-Path: <netdev+bounces-121803-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B98695EC32
	for <lists+netdev@lfdr.de>; Mon, 26 Aug 2024 10:41:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BAC03B209AF
	for <lists+netdev@lfdr.de>; Mon, 26 Aug 2024 08:41:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2731A13AD32;
	Mon, 26 Aug 2024 08:41:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QXJ5PEXi"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6166D73478
	for <netdev@vger.kernel.org>; Mon, 26 Aug 2024 08:41:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724661676; cv=none; b=FMYnF4Xp28L0wp6hKvCT9kF3MvOj85XRjZHSdX1cwi1DlCxW52AnskCkdS3Vg+Fq0wtPqqCM4HYyZthhxsg6WQxBXXapa3/Ogyc1iFPrVzzgjVKNUSIBIa5vUBr+D40Z/YwtSKJx+mJaHB1Fs2Ctws/lsMmPoJ9AAGBVzMnvMKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724661676; c=relaxed/simple;
	bh=ZJqPV+M2ayctdGZHxpg+AofznRAfzm17VKe00rGKdUU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oQaYPTUQI6HRBM5swwkjwZPiodT69Gbz1leZYOq1JCe7xgNGI8P+6DPqFEohaLIGpnfOcdKvlXHkrmIEOCzi8slXhQAj2LlC8pj2W3sKVpJLil08Y7p1e+7lgDi5vBmnDBMT0kixVpm3+TpeBxvRIaLpXySFyFUXmL+Of+JmhG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=QXJ5PEXi; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2f3f07ac2dcso45666431fa.2
        for <netdev@vger.kernel.org>; Mon, 26 Aug 2024 01:41:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1724661672; x=1725266472; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZJqPV+M2ayctdGZHxpg+AofznRAfzm17VKe00rGKdUU=;
        b=QXJ5PEXimOZ13K98cB1Y/XAMdYH4RaTmfS5py/vw/c1EpBP3vuWDSuZ/nMvnJIw3mC
         th9iepXjNaYdXhdsoQTIRbFQPeTnWJ9w0gSc8+bypMPrFqIAYgt8xPbHZ/Zx6A4xn/rn
         Qa2oJ6jtE/GyZ/2LG+If+pNK+0yw1B4kGIf27Eu15WBiHnoggZ0s1DG8vbzIAXHzTDCC
         koN3voYr7wc997LIDXTOCa7wNhdEuIDByWc53MdoE7VNja8oCF3mZoieIvmFO/jm+PrC
         +Hu86PSoFs9hxZu1OZPqurQkKDezFdJkn6tfbYzd45OJKUSX7yaea0Vs8ejhvAOqepA7
         WukQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724661672; x=1725266472;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZJqPV+M2ayctdGZHxpg+AofznRAfzm17VKe00rGKdUU=;
        b=qA+JKgzwKc3xsatjAdG9BymGPdG0a23FPBJ1VyqZijKqJmybuQRF/3JmS7244O+LUG
         K5cFZB1Y1PaGB1OdHnFDBIhfa/ANkuzfu1qCdIdPKzN0NE9OxUk9/nSaTyzd2fhrFLHt
         4ty6hxMNPRi32+rK77zklIOHDMjxSiJSWkVU/xOw8g2QJo776DFAAV+DD8OlJ3yc3Tya
         1saiaL5XtpeLKjD1XxDR2ipD6OTAFzZAMOSfJWmLHU5j7xSYP1V/5cY+lj7naPE0v9nN
         g0FdjsxEPEX60LapHv6VmVYfqllWomtL4HV37dp8Uk/K8r2rkznffBVI4UwTs74wFagM
         O6Qw==
X-Forwarded-Encrypted: i=1; AJvYcCVT2X7YVlXO/7+jaxPo8+x0MvIdJOIKag4pX8HczZrTotZaqkOp3qDf29zdk+LCQrLRtrHhTZ4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8ZAt6b586yzHffgY1Pg0bJKFXUZLXCC8fipMHzGxf98AawnIX
	tA8S0jEguaXc0E3gTptYemWCIJSIzVa7S3BCQvtXz2VKbOQ6UWoaSh3UNd+n7TsC2fOjzpa6tDG
	VNKdBdmghv2KdFnzvcxjpPSNk0PjaBCRUe7lajA==
X-Google-Smtp-Source: AGHT+IF1xip2LZYxVRH8VpdWfcRa9uK7A6loLJRPHfWQskmDHQEUYxjPeikly02OaJhz/cUtMMvnXB3y1yNyya30do4=
X-Received: by 2002:a05:6512:3c85:b0:533:966:72cb with SMTP id
 2adb3069b0e04-5343885f659mr6807476e87.48.1724661671918; Mon, 26 Aug 2024
 01:41:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240822084733.1599295-1-frank.li@vivo.com> <20240822084733.1599295-4-frank.li@vivo.com>
In-Reply-To: <20240822084733.1599295-4-frank.li@vivo.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Mon, 26 Aug 2024 10:41:00 +0200
Message-ID: <CACRpkdb-MKYAcWA5KUDZ=oeREs86S68WjqzS9XRTrUbBhLbBtQ@mail.gmail.com>
Subject: Re: [net-next 3/9] net: ethernet: cortina: Convert to devm_clk_get_enabled()
To: Yangtao Li <frank.li@vivo.com>
Cc: clement.leger@bootlin.com, andrew@lunn.ch, f.fainelli@gmail.com, 
	olteanv@gmail.com, davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, ulli.kroll@googlemail.com, marcin.s.wojtas@gmail.com, 
	linux@armlinux.org.uk, alexandre.torgue@foss.st.com, joabreu@synopsys.com, 
	mcoquelin.stm32@gmail.com, hkallweit1@gmail.com, justinstitt@google.com, 
	kees@kernel.org, u.kleine-koenig@pengutronix.de, jacob.e.keller@intel.com, 
	horms@kernel.org, shannon.nelson@amd.com, linux-renesas-soc@vger.kernel.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, 
	linux-stm32@st-md-mailman.stormreply.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 22, 2024 at 10:32=E2=80=AFAM Yangtao Li <frank.li@vivo.com> wro=
te:

> Convert devm_clk_get(), clk_prepare_enable() to a single
> call to devm_clk_get_enabled(), as this is exactly
> what this function does.
>
> Signed-off-by: Yangtao Li <frank.li@vivo.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

