Return-Path: <netdev+bounces-124967-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E895D96B734
	for <lists+netdev@lfdr.de>; Wed,  4 Sep 2024 11:45:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 944641F21D68
	for <lists+netdev@lfdr.de>; Wed,  4 Sep 2024 09:45:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8A051CDFDC;
	Wed,  4 Sep 2024 09:43:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UIsXgIZ7"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB2541925B1
	for <netdev@vger.kernel.org>; Wed,  4 Sep 2024 09:43:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725443004; cv=none; b=PuI3pPJTPOz2mvQClk6lUJqUP4GHvsSm5GPfVEKblB9ZTQp6vXiaIhGnzIVlzUlZgl1eelEU+WqeQdUbmnqByS/X+R56AZLoZtzWrKz3gbOHpz2ypMW27GAb/wDh2CFdBvCBSOrtj9P6rpX+OvDbuW1/ADnQc9e21Rgn1vjHJ4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725443004; c=relaxed/simple;
	bh=kl1VpBp0hN2mGM+lhSKLvBfxDKtkWSfiDDLjjHLOzOE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=AnvJcZDLzWcpCyOx2KlM/6oLlSWCGTSzX6xgs/nhpaJnqZKGmGZjmnwmDg7y2Z5Wv+OVza53KuoFTpdEtQkoFEU0cyn8/AiWwXtDe1S+Kttbfu/1wFXYimj2np+dSHtOoKdIjgRkcvVancrM2Q34hmOBCeTefs47y8u3kpUFdVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=UIsXgIZ7; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2f4f5dbd93bso5398381fa.2
        for <netdev@vger.kernel.org>; Wed, 04 Sep 2024 02:43:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1725443001; x=1726047801; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sWZolsXsCTYach8lH36h3ott3yh0cTGFzhMl58gyIUQ=;
        b=UIsXgIZ7iSFUd6eAWnAi5KmH0T4qhLmMPzqqycMyMlD78IbECSNmHi30J8Muzrqkqd
         ATUUO+Vz2V8CyQp9il1jGg32xd20CNj/p8FZL8SLz3ypomleh9uKxaCxAQ8Dh/LCFLgm
         xchfVy15NhMtPjvK+6AnbcymnbZk4d3NWGVCrU6Xb3GRoFj2I1qqf3pciFvvUWrV7oUv
         1Yb2AmUuJq+c7/wyTaKZlfjPoGc5LIo7Il8aK5QeZK55fMUejYcTXwMtL8NjB+mCtiEW
         PkKy4Ls1sIB/fGqVnh32lEe9W4Is497eMDIKIqrItnktrE/Si8WNWkyvjSmGwIL5yMBg
         KdsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725443001; x=1726047801;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sWZolsXsCTYach8lH36h3ott3yh0cTGFzhMl58gyIUQ=;
        b=Bhf5ZzVvJVhiLzn30KJjCbOZVSSquns0JMoVoPm3b/zdQswjqJIjO+s74/JFmYlfYo
         zqjQh3AFGAKn7nxVqdFhHIqifCJnEnu892kCESRpbWaLF2lXsAYKVm2HRZ8/siJrv60z
         3Z23inQSvhFmuRs+zKSFQEGs9VyO4PpcQlQ5gNjyyL/5qX1iRQ5pnjvJefXx8xlyMiYQ
         vIQWiqf5vkZvhhmREFLQm0bwUwbyMXkzMHAM/Lm9pOBxjVs+iZIdDWmXjsaRINpirlBB
         wTYjqXIYa2BLbxVJMcdLVrJ+M02OaanDToE3cJXFk4T5L7xklCVNpxpfQmtiaKXyjHhW
         1uBQ==
X-Forwarded-Encrypted: i=1; AJvYcCXtdlwWLO7whRB3gWMmr4FV6tFHM19DrnzbQqoZGoITcB0VHZebWzV9rkzvkOr0fbEJcswRANw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxti9/eMsbWOhGbxF4wMxKMQQqzOz+3kz6uv5CDiO3KxnDS/7lZ
	bBVJ+RWufyKVn5wRjDglFnQDn5VvOSfqZUd5AQ32VFh4Ah7iKKm+SKUw0x7oKCA=
X-Google-Smtp-Source: AGHT+IHQzzEaWIdg5FQFeuNQ9jdB9UOFp8iR16R1FSzfKc0rt/an2lTY0zgJAfLv9/Z5bc7o2LfPBQ==
X-Received: by 2002:a05:6512:304b:b0:52e:9b4f:dd8c with SMTP id 2adb3069b0e04-53565f22b01mr1327352e87.35.1725443000659;
        Wed, 04 Sep 2024 02:43:20 -0700 (PDT)
Received: from [127.0.1.1] ([84.232.173.69])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8988fefb60sm788159666b.43.2024.09.04.02.43.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Sep 2024 02:43:20 -0700 (PDT)
From: Abel Vesa <abel.vesa@linaro.org>
To: robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org, 
 Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
 Abel Vesa <abelvesa@kernel.org>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, richardcochran@gmail.com, 
 Michel Alex <Alex.Michel@wiedemann-group.com>
Cc: o.rempel@pengutronix.de, lee@kernel.org, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, NXP Linux Team <linux-imx@nxp.com>, 
 linux@armlinux.org.uk, linux-kernel@vger.kernel.org, 
 linux-clk@vger.kernel.org, netdev@vger.kernel.org, 
 Waibel Georg <Georg.Waibel@wiedemann-group.com>, 
 Appelt Andreas <Andreas.Appelt@wiedemann-group.com>
In-Reply-To: <AS1P250MB0608F9CE4009DCE65C61EEDEA9922@AS1P250MB0608.EURP250.PROD.OUTLOOK.COM>
References: <AS1P250MB0608F9CE4009DCE65C61EEDEA9922@AS1P250MB0608.EURP250.PROD.OUTLOOK.COM>
Subject: Re: [PATCH 1/1] clk: imx6ul: fix clock parent for
 IMX6UL_CLK_ENETx_REF_SEL
Message-Id: <172544299910.2790271.1284838688580694607.b4-ty@linaro.org>
Date: Wed, 04 Sep 2024 12:43:19 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0


On Mon, 02 Sep 2024 09:05:53 +0000, Michel Alex wrote:
> Commit 4e197ee880c24ecb63f7fe17449b3653bc64b03c ("clk: imx6ul: add
> ethernet refclock mux support") sets the internal clock as default
> ethernet clock.
> 
> Since IMX6UL_CLK_ENET_REF cannot be parent for IMX6UL_CLK_ENET1_REF_SEL,
> the call to clk_set_parent() fails. IMX6UL_CLK_ENET1_REF_125M is the correct
> parent and shall be used instead.
> Same applies for IMX6UL_CLK_ENET2_REF_SEL, for which IMX6UL_CLK_ENET2_REF_125M
> is the correct parent.
> 
> [...]

Applied, thanks!

[1/1] clk: imx6ul: fix clock parent for IMX6UL_CLK_ENETx_REF_SEL
      commit: 32c055ef563c3a4a73a477839f591b1b170bde8e

Best regards,
-- 
Abel Vesa <abel.vesa@linaro.org>


