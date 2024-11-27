Return-Path: <netdev+bounces-147609-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2AB49DAA2A
	for <lists+netdev@lfdr.de>; Wed, 27 Nov 2024 15:51:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9481D166C19
	for <lists+netdev@lfdr.de>; Wed, 27 Nov 2024 14:51:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A1FD1FCFD5;
	Wed, 27 Nov 2024 14:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="LTocnYFa"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 266791DFD1
	for <netdev@vger.kernel.org>; Wed, 27 Nov 2024 14:51:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732719087; cv=none; b=l5qcjXVYYUvXNg1zZidq9X65HSZUriQ2a7fBMTgQk3mXDX5OI/V8wb9Eu+Y4OuAJJdshlguywKrkp9PD8M+hCj85QLCbvCASbQvVmpQHu3dE3eh0l5tDIUUXl0euhvBapzeTDch0PrYMxV6MUxJ1HO2ZPMKU5er320+J8XfXT2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732719087; c=relaxed/simple;
	bh=8IPmXPA9vlrfIWt+Un6Qmb35TWs/KQ1dfAq90W49uMg=;
	h=From:In-Reply-To:References:Mime-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=taL4l5g5eXe8Y+HKKWOkMBNJ7+EC69rk5/tCzFaCTCM/TjjWXWyowywOAYxCNx5WqT6kZeqpGXzHH/Q5FiIGeC5UPZUkBH4rsAooOpP7iiqu8ilGVUz/zcTitff8bcwn5M7MHGWuBTIIs1ldBd9TIvGnHC8yDUO5olVhf9vt0zg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=LTocnYFa; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-oo1-f71.google.com (mail-oo1-f71.google.com [209.85.161.71])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id DA803402F0
	for <netdev@vger.kernel.org>; Wed, 27 Nov 2024 14:51:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1732719082;
	bh=ddTmmaktStUX+KyiWQA7QlRxka08sVdAlnNv34gi4rQ=;
	h=From:In-Reply-To:References:Mime-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type;
	b=LTocnYFa/djZjR58NjKFJdzSpHrLoRBkiX73GV/eB8yyhJuIFtdIdtojBLG+2Dekc
	 9Ne99Lk35L6RNnB/QOOE4MJC5x8yM48h+kXPeuliv9ZYLaHJl7IzuJLdKy9/nvPeeu
	 DgyTzyELe6hWYXyUk71B6WNP7MtoBxYtdk3vUT0pRwnf6ys5jOdaTDH+E7OIRYn4C7
	 ecFw4rVX/sdyAgevQIoVX6zT3H8Nh/uPtn9heZKO6KOossN+l8+A0asyB3r04mDxyH
	 tOF8tyLg0IiA5JaRkRzUJ27+RvjMH3Bb535GAgNWYqyKmp8DMZDs+aGTEUPr+wukWU
	 qDXkgkZDao2hQ==
Received: by mail-oo1-f71.google.com with SMTP id 006d021491bc7-5f1d5f7afd4so650118eaf.0
        for <netdev@vger.kernel.org>; Wed, 27 Nov 2024 06:51:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732719081; x=1733323881;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ddTmmaktStUX+KyiWQA7QlRxka08sVdAlnNv34gi4rQ=;
        b=L0Hv49MbQr+9eMnhWKONPKBOuRSYWCzup2nRYgJSWs++asFjEgL+3/WQQUZqQwds4W
         TjE30LYlFMEenM6ekws8GZOP9JCyKKM/Ci1fwg6wTNsNDHAT8ekbb8cLTW3ighketHAc
         3XjEo9Sp2Lwpue92y4FOKOZthQ53WY2EqVfErqzqsaQCXClaK5qHKPZZeNCG2suiZEgN
         UDMRehLg0jbIIEtSO0VVlGzrcm4sW5p38/vuEIjfIjcwDGvuNINxTTL7qJ3P2MRjalqc
         Rrsb/bTbjHlSnij6BoxdTBdVlI7M0aQcIGV3Wj0AS1qZt7NQrH4s4iUfDfasbJ/3IKc4
         tkfg==
X-Forwarded-Encrypted: i=1; AJvYcCUGpULUKqap2IyA8tFxle0XM6mytp40a46PUyZ0JuDRylKkhdYkwt5V7XsoUEjJp7hOOmabuhE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyKpoPL0PJv3Rx8huLzgEorgUFb/zKmEOctWKFVQNaR9ucE+yGb
	NImVpmUvjyYUxLHZvUkb2W8ynLtBaaTzQPX8/ZOeAJfTAcl+c0Wta8siIT8/oBtbDxSreYcVPQG
	7aXS78KaxlJMB0wvy4hyF3YlHrOSzQOSwc1pn3EfVUOPOkbmKMMLugm8kQC6/lADKyzeJZQTcDc
	+mTMmLEryKkWKx3JcA65ZFHFwm5IAFeeCt4KLpOO5r6lNa
X-Gm-Gg: ASbGncuzwrxpgoBSeCO0DzROII6mvJT0xxegJqpG0JyXmcZBl1S/Ni45VBrlsX3Sbo1
	b/LvSBgRwlW8t50NoTMZGzLIKhfd78XpWZVAvHzVDpXVq9VokzTAoNMfoyxN0
X-Received: by 2002:a05:6820:4981:b0:5f1:fbef:c868 with SMTP id 006d021491bc7-5f1fc43a130mr3684976eaf.0.1732719081288;
        Wed, 27 Nov 2024 06:51:21 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEfFJGOrjEK1lKzXEW/QXPfJgWZfDO/+kYkPBQ8RDpwNJVjReUG8X0KbLCz17ehyjwvJu+WybHbfVyct/J5soQ=
X-Received: by 2002:a05:6820:4981:b0:5f1:fbef:c868 with SMTP id
 006d021491bc7-5f1fc43a130mr3684952eaf.0.1732719080947; Wed, 27 Nov 2024
 06:51:20 -0800 (PST)
Received: from 348282803490 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 27 Nov 2024 06:51:20 -0800
From: Emil Renner Berthing <emil.renner.berthing@canonical.com>
In-Reply-To: <20241124-upstream_s32cc_gmac-v6-9-dc5718ccf001@oss.nxp.com>
References: <20241124-upstream_s32cc_gmac-v6-0-dc5718ccf001@oss.nxp.com> <20241124-upstream_s32cc_gmac-v6-9-dc5718ccf001@oss.nxp.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Date: Wed, 27 Nov 2024 06:51:20 -0800
Message-ID: <CAJM55Z9PZH3797=gvRWquHFSE7YOsO0-bcOBFjBETCiQW-YURw@mail.gmail.com>
Subject: Re: [PATCH RFC net-next v6 09/15] net: dwmac-starfive: Use helper rgmii_clock
To: Jan Petrous via B4 Relay <devnull+jan.petrous.oss.nxp.com@kernel.org>, 
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@foss.st.com>, 
	Jose Abreu <joabreu@synopsys.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Vinod Koul <vkoul@kernel.org>, Richard Cochran <richardcochran@gmail.com>, 
	Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, 
	Russell King <linux@armlinux.org.uk>, Shawn Guo <shawnguo@kernel.org>, 
	Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>, 
	Fabio Estevam <festevam@gmail.com>, Emil Renner Berthing <kernel@esmil.dk>, 
	Minda Chen <minda.chen@starfivetech.com>, Nicolas Ferre <nicolas.ferre@microchip.com>, 
	Claudiu Beznea <claudiu.beznea@tuxon.dev>, 
	Iyappan Subramanian <iyappan@os.amperecomputing.com>, 
	Keyur Chudgar <keyur@os.amperecomputing.com>, Quan Nguyen <quan@os.amperecomputing.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Giuseppe Cavallaro <peppe.cavallaro@st.com>, Andrew Lunn <andrew+netdev@lunn.ch>
Cc: linux-stm32@st-md-mailman.stormreply.com, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, linux-arm-msm@vger.kernel.org, imx@lists.linux.dev, 
	devicetree@vger.kernel.org, NXP S32 Linux Team <s32@nxp.com>, 
	"Jan Petrous (OSS)" <jan.petrous@oss.nxp.com>, 
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
Content-Type: text/plain; charset="UTF-8"

Jan Petrous via B4 Relay wrote:
> From: "Jan Petrous (OSS)" <jan.petrous@oss.nxp.com>
>
> Utilize a new helper function rgmii_clock().
>

Thanks!
Reviewed-by: Emil Renner Berthing <emil.renner.berthing@canonical.com>

> Reviewed-by: Andrew Lunn <andrew@lunn.ch>
> Reviewed-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> Signed-off-by: Jan Petrous (OSS) <jan.petrous@oss.nxp.com>
> ---
>  drivers/net/ethernet/stmicro/stmmac/dwmac-starfive.c | 19 ++++---------------
>  1 file changed, 4 insertions(+), 15 deletions(-)
>
> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-starfive.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-starfive.c
> index 421666279dd3..0a0a363d3730 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac-starfive.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-starfive.c
> @@ -34,24 +34,13 @@ struct starfive_dwmac {
>  static void starfive_dwmac_fix_mac_speed(void *priv, unsigned int speed, unsigned int mode)
>  {
>  	struct starfive_dwmac *dwmac = priv;
> -	unsigned long rate;
> +	long rate;
>  	int err;
>
> -	rate = clk_get_rate(dwmac->clk_tx);
> -
> -	switch (speed) {
> -	case SPEED_1000:
> -		rate = 125000000;
> -		break;
> -	case SPEED_100:
> -		rate = 25000000;
> -		break;
> -	case SPEED_10:
> -		rate = 2500000;
> -		break;
> -	default:
> +	rate = rgmii_clock(speed);
> +	if (rate < 0) {
>  		dev_err(dwmac->dev, "invalid speed %u\n", speed);
> -		break;
> +		return;
>  	}
>
>  	err = clk_set_rate(dwmac->clk_tx, rate);
>
> --
> 2.47.0
>
>

