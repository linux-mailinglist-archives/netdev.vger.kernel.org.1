Return-Path: <netdev+bounces-132539-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AB9D0992104
	for <lists+netdev@lfdr.de>; Sun,  6 Oct 2024 22:03:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B3ADC1C210A2
	for <lists+netdev@lfdr.de>; Sun,  6 Oct 2024 20:03:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A87F518B478;
	Sun,  6 Oct 2024 20:02:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zDVFWK7z"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9496B29405
	for <netdev@vger.kernel.org>; Sun,  6 Oct 2024 20:02:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728244975; cv=none; b=aDDJHWxsKeTiKvd5BP7RPHnSOmpK7uJSSzkV3XZgKIggJ7fasFueCgeNG0h7q1qEbKF/u/G1Gq1uhPaahW/Ftp7vjeiBXt1ecWxQYrpxn5VDP2qj0RZEc8Tl/3O+y9VUTjkNbmBhlaC5PCuUxYMevKZQNPcH5lRGcGYflhEEo5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728244975; c=relaxed/simple;
	bh=BKrbQwQkowt1+bzR0D5HzgQAruCM+95JJXJ8j/sE8WI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eBY3OZOSO9uNFIWBoMMvv+04b4IQ39Ozwq7/g7PhoMeHZynZqfP2L1HGV3pkBLxn47Zd6al4cbuPWa6jVc+0GzX4ccK6gXr+a/M10bmFawDihM048skuB4rE+SttN9wIh1fOyGVY/hck5RcfSTPyC4KWre7qJaj5D+JrFX21jfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=zDVFWK7z; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2fac47f0b1aso41930291fa.1
        for <netdev@vger.kernel.org>; Sun, 06 Oct 2024 13:02:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1728244971; x=1728849771; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Nwbn0gIl1C5EuYZ4Ax1bS6s5OiSrO+rE1+nDa6TAgks=;
        b=zDVFWK7zgREIbabQ4Z4+8w8yxJAjWLT1T6wXymNnLvGwCM9MN6IHKGmNy/PbqogXv3
         ZqA8xAIVGoDFoub2XDLpfXbBSZlR5eBymwomRt5dldzd1RVwJ4Lom9CvVCS+zPQfepZg
         UhjI4AUgzXOs0syMM7BFim0HRD6QMHtbMT/4Ia62mTBG4jGgf4WRWOXXA4FJQwdTLG35
         pDrMOG5fmmhImKAq+lHmC513axUBCThSHRzeKIpk5P6I51fb9VBAZlFuEhpK+5qmvBIk
         mDGhrxJpCyxGr+m0JA4WMRjmbZTHKSuU0TgVR100zQCyM/BzLeBByFyHZId11pOB8OSk
         V40A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728244971; x=1728849771;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Nwbn0gIl1C5EuYZ4Ax1bS6s5OiSrO+rE1+nDa6TAgks=;
        b=oxM3U9/3smxfzYAwaMn0WvvwP48/wq2cnpixkp9zs2vFTo0DsrVq6e+I68kdBU51Uz
         pbyRknPXFfUPP/tN4q/nHXl5DTneYCkUnPNdFMUOTBkgRiDOiQmriBc2aWKrakjcrBJb
         cGrcjatu6Z46BI2k+4EGfY3avvlYpWSU3y1a7e5YJcKl8V0TxaeUNBQggI2STkVen1ju
         YrQLs3uGhngnAPchwGzAHNNRwUtumEe9C76dqvZk0s00a20XHEHKuQO00mIWmkL7broR
         yFCIjaj+q2r02OtLWZCxwYUIkcju77XhM1OLl1pM6EcdK48CWJkUS5C8QXavIX3eGMfK
         uqcw==
X-Forwarded-Encrypted: i=1; AJvYcCXt7dXN6sxgcWCqo9xwhRy2bNIhurWVZ0WGHQ4EmoWwJBLmFkoti3nLWDGPqYL5rUxBxLe28zM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzXf58xt26wRramlG6pElkh/2XmRldM/zjg4Zed1qoRLmoAUbZ9
	NiiHr6V1X6iN7pHbjJvgxXmfZynB24SLq+LNqxkaz05Q0DuDFhqN9Iea4+qkpGM=
X-Google-Smtp-Source: AGHT+IGLvn10+PJmGDxTkP6j1/Ue4KcnwP4Pgs7uruaP4zPw2m0MCR9GIhyL+Zb9EOWDtZn84oPPsw==
X-Received: by 2002:a2e:4e12:0:b0:2fa:d296:6fc6 with SMTP id 38308e7fff4ca-2faf3c146f6mr33027981fa.13.1728244970705;
        Sun, 06 Oct 2024 13:02:50 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00-89ea-67f6-92cd-b49.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:89ea:67f6:92cd:b49])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2faf9ab14f7sm6139741fa.17.2024.10.06.13.02.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Oct 2024 13:02:50 -0700 (PDT)
Date: Sun, 6 Oct 2024 23:02:47 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Manikanta Mylavarapu <quic_mmanikan@quicinc.com>
Cc: andersson@kernel.org, mturquette@baylibre.com, sboyd@kernel.org, 
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, konradybcio@kernel.org, 
	catalin.marinas@arm.com, will@kernel.org, p.zabel@pengutronix.de, 
	richardcochran@gmail.com, geert+renesas@glider.be, neil.armstrong@linaro.org, 
	arnd@arndb.de, nfraprado@collabora.com, quic_anusha@quicinc.com, 
	linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org, 
	quic_srichara@quicinc.com, quic_varada@quicinc.com
Subject: Re: [PATCH v6 5/7] clk: qcom: Add NSS clock Controller driver for
 IPQ9574
Message-ID: <72r4uowjwoxkeqq6bxhdv72wq4rqogirb3yyp2ku66rr2cnzbs@i2lk6sgfvenh>
References: <20241004080332.853503-1-quic_mmanikan@quicinc.com>
 <20241004080332.853503-6-quic_mmanikan@quicinc.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241004080332.853503-6-quic_mmanikan@quicinc.com>

On Fri, Oct 04, 2024 at 01:33:30PM GMT, Manikanta Mylavarapu wrote:
> From: Devi Priya <quic_devipriy@quicinc.com>
> 
> Add Networking Sub System Clock Controller(NSSCC) driver for ipq9574 based
> devices.
> 
> Signed-off-by: Devi Priya <quic_devipriy@quicinc.com>
> Signed-off-by: Manikanta Mylavarapu <quic_mmanikan@quicinc.com>
> ---
> Changes in V6:
> 	- Remove 'nsscc_ipq9574_desc' and use 'nss_cc_ipq9574_desc' in
> 	  probe()
> 	- Drop of_clk_get() and clk_prepare_enable() in probe() because
> 	  ethernet node will subscribe to GCC_NSSCC_CLK and enable it.

Does the cllock supply the clock controller? If not, it should be
dropped from bindings too.

> 	- Drop Tested-by tag
> 
>  drivers/clk/qcom/Kconfig         |    7 +
>  drivers/clk/qcom/Makefile        |    1 +
>  drivers/clk/qcom/nsscc-ipq9574.c | 3084 ++++++++++++++++++++++++++++++
>  3 files changed, 3092 insertions(+)
>  create mode 100644 drivers/clk/qcom/nsscc-ipq9574.c
> 
> diff --git a/drivers/clk/qcom/Kconfig b/drivers/clk/qcom/Kconfig
> index a3e2a09e2105..b9a5cc9fd8c8 100644
> --- a/drivers/clk/qcom/Kconfig
> +++ b/drivers/clk/qcom/Kconfig
> @@ -255,6 +255,13 @@ config IPQ_GCC_9574
>  	  i2c, USB, SD/eMMC, etc. Select this for the root clock
>  	  of ipq9574.
>  
> +config IPQ_NSSCC_9574
> +        tristate "IPQ9574 NSS Clock Controller"
> +        depends on ARM64 || COMPILE_TEST
> +        depends on IPQ_GCC_9574
> +        help
> +          Support for NSS clock controller on ipq9574 devices.
> +
>  config IPQ_NSSCC_QCA8K
>  	tristate "QCA8K(QCA8386 or QCA8084) NSS Clock Controller"
>  	depends on MDIO_BUS
> diff --git a/drivers/clk/qcom/Makefile b/drivers/clk/qcom/Makefile
> index 2b378667a63f..65b825a54c45 100644
> --- a/drivers/clk/qcom/Makefile
> +++ b/drivers/clk/qcom/Makefile
> @@ -36,6 +36,7 @@ obj-$(CONFIG_IPQ_GCC_6018) += gcc-ipq6018.o
>  obj-$(CONFIG_IPQ_GCC_806X) += gcc-ipq806x.o
>  obj-$(CONFIG_IPQ_GCC_8074) += gcc-ipq8074.o
>  obj-$(CONFIG_IPQ_GCC_9574) += gcc-ipq9574.o
> +obj-$(CONFIG_IPQ_NSSCC_9574)	+= nsscc-ipq9574.o
>  obj-$(CONFIG_IPQ_LCC_806X) += lcc-ipq806x.o
>  obj-$(CONFIG_IPQ_NSSCC_QCA8K) += nsscc-qca8k.o
>  obj-$(CONFIG_MDM_GCC_9607) += gcc-mdm9607.o
> diff --git a/drivers/clk/qcom/nsscc-ipq9574.c b/drivers/clk/qcom/nsscc-ipq9574.c
> new file mode 100644
> index 000000000000..acbd1c3855d2
> --- /dev/null
> +++ b/drivers/clk/qcom/nsscc-ipq9574.c
> @@ -0,0 +1,3084 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (c) 2021, The Linux Foundation. All rights reserved.
> + * Copyright (c) 2023 Qualcomm Innovation Center, Inc. All rights reserved.
> + */
> +
> +#include <linux/clk.h>
> +#include <linux/clk-provider.h>
> +#include <linux/err.h>
> +#include <linux/interconnect-provider.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/of_device.h>
> +#include <linux/regmap.h>
> +#include <linux/platform_device.h>
> +
> +#include <dt-bindings/clock/qcom,ipq9574-nsscc.h>
> +#include <dt-bindings/interconnect/qcom,ipq9574.h>
> +#include <dt-bindings/reset/qcom,ipq9574-nsscc.h>
> +
> +#include "clk-alpha-pll.h"
> +#include "clk-branch.h"
> +#include "clk-pll.h"
> +#include "clk-rcg.h"
> +#include "clk-regmap.h"
> +#include "clk-regmap-divider.h"
> +#include "clk-regmap-mux.h"
> +#include "common.h"
> +#include "reset.h"
> +
> +/* Need to match the order of clocks in DT binding */
> +enum {
> +	DT_XO,
> +	DT_BIAS_PLL_CC_CLK,
> +	DT_BIAS_PLL_NSS_NOC_CLK,
> +	DT_BIAS_PLL_UBI_NC_CLK,
> +	DT_GCC_GPLL0_OUT_AUX,
> +	DT_UNIPHY0_NSS_RX_CLK,
> +	DT_UNIPHY0_NSS_TX_CLK,
> +	DT_UNIPHY1_NSS_RX_CLK,
> +	DT_UNIPHY1_NSS_TX_CLK,
> +	DT_UNIPHY2_NSS_RX_CLK,
> +	DT_UNIPHY2_NSS_TX_CLK,
> +};
> +

I didn't check the driver, but LGTM.

-- 
With best wishes
Dmitry

