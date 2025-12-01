Return-Path: <netdev+bounces-242983-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C6ECFC97DBA
	for <lists+netdev@lfdr.de>; Mon, 01 Dec 2025 15:32:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6083B3A23D8
	for <lists+netdev@lfdr.de>; Mon,  1 Dec 2025 14:31:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0677D3164BC;
	Mon,  1 Dec 2025 14:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pFU59lxE"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2766D3126AB
	for <netdev@vger.kernel.org>; Mon,  1 Dec 2025 14:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764599507; cv=none; b=c1aamgZDdxMwy1+YB56Z/mQFlGJqBEyBZbS3VaSbf8gYrgl6stVUqsAXlg8cFvEbBrfItGkn/ZPQr+G/51waKgVqAqxVw8HwIu6DIKZvPPgiN8dCOkD1U4iimbCY8IJeMxVx/s1skL8lPXaW3e7VnGqeMjZR/8mufdX51AQNmJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764599507; c=relaxed/simple;
	bh=iSzXnkL6CZ7clNjmcPJzJQEgcd8lgXcvAiTHRowiIsA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CVBvNVALjAOU1oYMegYOGQl0LQ9Lq6/twZ5r680OBcUQKgqYEwo29vEn0wzJoYuQ5F536A81q2UIT0KO2g1YRT10X/0Gtkyyel3Z2e9ToSAy0evsPeILl4y0M57Lc0SiCpKNvGiR0gpswRqc2OjQh4CK2F9QhoOe14hm+4bB6lI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=pFU59lxE; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-477a219dbcaso38242445e9.3
        for <netdev@vger.kernel.org>; Mon, 01 Dec 2025 06:31:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1764599504; x=1765204304; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=P3Udye7A+1mJEIOEFZOxhVuAe/sJ9GEaxJR6U/sqIe4=;
        b=pFU59lxErcDBwDqOjO49K8/irivP5aAkyCDo0uSmltDPIm/fC0dYk+e2T2tMJafIfB
         nrr87ztMVEftj1yTscjflIAGLtAXGVpI2OcMXlgWgaQz9zSqwJSlguUd3Q//9WrG8tii
         vnD/JGbY+qrRDdsyI0meLaGoUXl+CX3P0/vq3LgM3SWkyJAq7ZPuk60zrxnTVk1Gq7Yf
         Mb7M1rLnLWqRLMp34kZdy7ttohhXAlO9T8AjwocipVGhhJMD7iIT2doDOg6XWqZV6c8A
         sA5RQOmrEurGDTpJxrbcavugG/NRv+vccBsfapNWuo7gTPj+1tdQTMfkvlVoOMvDDPyN
         2WfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764599504; x=1765204304;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P3Udye7A+1mJEIOEFZOxhVuAe/sJ9GEaxJR6U/sqIe4=;
        b=wEMdh4eHMFSuJgBwrE+0YmKEtDCXKS3ae6DOaov7k6FtmHGeM/LwQC94gPwWSQ6RzE
         QUxPo7RCOOkgZQISZfJCAUGnv4ZRZ7mC7GtwEH0o1+V5qE65QtF3FzwlhBaEmLbteesT
         BWRifdxg8/eJ7bpADIUhXxTSdTpSaR+cNLYRodYyUZjGtHEj6NcMoos1x2wry8qJ4jcD
         7rZbvppVnFHIV5pU3AHlnKKuInZJp7TRRrSR19acUZYBa7ofWE0RpJrBeJXAjouGCGnU
         7QAOc4cTbE3Nf2/R4K2hSPJigcmgMkJnpDAHeHAYlohSvPMF+rFjU+Qei37bhKNreNwH
         IuKw==
X-Forwarded-Encrypted: i=1; AJvYcCWMlLZgZgG43buvehl38q5sQLsgen08mXxSAa2XVXL+zyrNnVojn/L6mzuVEcYqXMZa26wPtrk=@vger.kernel.org
X-Gm-Message-State: AOJu0YykRgU5HhFKLQANuGDDjKkrZmv4aAtsWHEHUklxubo4uG2Tnecc
	umnaJ11ikuZyXzejdbtV1ViqH8LoVFAFk/c6hxcNChiqbqeY7mcnM11JftbeeMo/kQU=
X-Gm-Gg: ASbGnctWcuxbetB4V/XLYi1Bb5EHLWZxvFVmRCYNIws341ItC+mY1RSinilwypTUnUB
	5rlrJxTE9zyYFGhFMrPEn44YNb9ErNfSunhBwt+vRTbMuKeBN6f7mdKiRrEAWc7xetRSIdQsLmu
	c73prRV3IDSpI/Sq1GDkthmgcwUI6YlRvHywHDUNKEJc5xYKhUCgYS9DJhbJttf2R9Kl70zJJpp
	p0Z3Ac9U8/bzP/r89q+ApR/XutDRCUUExi7p0wVro7pdlNEbpdwUx2wtCq97k/ut/pAqjNWR9C9
	6KKjtLCpKDmPCcQAt2xZT1qxXB1lngAec8iQnRBtXp3mur2DqF3Wk2w4ti42HZ0OS7aiCMu1gxg
	Drt2xBe1u5Lf+pGxm9pPWprmunxVfbIYQfHIXEwNhl6KjKGOb/x6EXdTN0FHFmMH3J7Ol9ifL05
	OieX2U5/M4HdI+7den
X-Google-Smtp-Source: AGHT+IH6A6FJXGfT8Zsjwa2/f7hPiOGak401pIC2WoSIqlHjuQJJxsh60eESxFQX7d8Tr6L3Wxf8Ig==
X-Received: by 2002:a05:600c:1f8f:b0:46e:1fb7:a1b3 with SMTP id 5b1f17b1804b1-477c01ee3camr380965655e9.23.1764599504416;
        Mon, 01 Dec 2025 06:31:44 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-479052cf8d9sm154964375e9.9.2025.12.01.06.31.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Dec 2025 06:31:43 -0800 (PST)
Date: Mon, 1 Dec 2025 17:31:38 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Chester Lin <chester62515@gmail.com>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Conor Dooley <conor+dt@kernel.org>,
	"David S. Miller" <davem@davemloft.net>, devicetree@vger.kernel.org,
	Eric Dumazet <edumazet@google.com>,
	Fabio Estevam <festevam@gmail.com>,
	Ghennadi Procopciuc <ghennadi.procopciuc@oss.nxp.com>,
	imx@lists.linux.dev, Jakub Kicinski <kuba@kernel.org>,
	Jan Petrous <jan.petrous@oss.nxp.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Lee Jones <lee@kernel.org>, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	Matthias Brugger <mbrugger@suse.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, netdev@vger.kernel.org,
	NXP S32 Linux Team <s32@nxp.com>, Paolo Abeni <pabeni@redhat.com>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Rob Herring <robh@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Shawn Guo <shawnguo@kernel.org>, linaro-s32@linaro.org
Subject: Re: [PATCH 0/4] s32g: Use a syscon for GPR
Message-ID: <aS2myhp8asABFyLt@stanley.mountain>
References: <cover.1764592300.git.dan.carpenter@linaro.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1764592300.git.dan.carpenter@linaro.org>

On Mon, Dec 01, 2025 at 04:08:14PM +0300, Dan Carpenter wrote:
> *** BLURB HERE ***
> 

Sorry, I obviously meant to write a message here.

The s32g devices have a GPR register region which could be accessed
via a syscon.  Currently only the stmmac/dwmac-s32.c uses anything
from there and we just add a line to the device tree to access
that GMAC_0_CTRL_STS register:

			reg = <0x4033c000 0x2000>, /* gmac IP */
			      <0x4007c004 0x4>;    /* GMAC_0_CTRL_STS */

But it would be better to have a syscon instead of adding each
register to the device tree like this.

We still have to maintain backwards compatibility to this format,
of course.

regards,
dan carpenter


