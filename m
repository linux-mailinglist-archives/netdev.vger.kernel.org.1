Return-Path: <netdev+bounces-138978-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DC559AF950
	for <lists+netdev@lfdr.de>; Fri, 25 Oct 2024 07:51:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 12DE72825D0
	for <lists+netdev@lfdr.de>; Fri, 25 Oct 2024 05:51:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37AEB18FC61;
	Fri, 25 Oct 2024 05:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PuRYNcxb"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A4CF18E058
	for <netdev@vger.kernel.org>; Fri, 25 Oct 2024 05:51:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729835484; cv=none; b=CQEhO/boY/jTRq6DAZ+na9f+UZ27tF8nh5u39gaEwktiVZKXqdT6Loda0aIAFeN22qwF7ieRNLiYfC6mM2Bi6UnzGoQOV8IbVQ6AA34s4i5TcNJwn1mrf5Sjabk9CCECVmtZTYxJ/V8nAmbC4hUFMLKOnvM7ahvpv5OO3Wp0ayQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729835484; c=relaxed/simple;
	bh=mzeWPkYZvbrYZZyygIkwlVdONmZi77eqy+7dxIb1gvw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LA9iSrD4hUU3QGM119ARWJ910VtYuYNevHGsbdCuw1NZJfUGovZ/tlnZJiK51ag1UtazdOEq13xmdzkzQq6YCW6qRbIC1bgNC29wYhbDukzv8GptfgNsJ0ZrwT+yJl2+rRbg62yAR4yhUxoyYU1uywTEjjQ+SZDOL9f3vaPRjFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=PuRYNcxb; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-539f1292a9bso2101029e87.2
        for <netdev@vger.kernel.org>; Thu, 24 Oct 2024 22:51:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1729835480; x=1730440280; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=LENYqwcqgnLHnXVBhDyfSMRgdbqUwUn0CP6hPe43hIE=;
        b=PuRYNcxbH4bEoEve9PwIpB0ChjXofqchmlL2i+VAA56VKwddh1Hk2S6xa3fTmkdKYK
         ekVJDiETHVGF2QXH6wdfbRYjHRJUJapzI3318jbLOjgYYK45epEIwuzBiqJK1DeInJYp
         E16ax5WsFDR5Y6ExDfU/4PL6xN8qG163x7kllZ5UcZb5OhBh2cP7neVBwyMLUqzQyKP8
         ZZYGY/VjesSO774l3FPUxatBF4BOHKqsTJx6HTa8D/9cZZkOULVxSNOoMiFn+am/SU7b
         QgPFNihDN18KintgPgZx8hL5wzV8KUmpU+95JgCC1R889yYRtMgUtsK7gNFdjQw/9NQr
         DEHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729835480; x=1730440280;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LENYqwcqgnLHnXVBhDyfSMRgdbqUwUn0CP6hPe43hIE=;
        b=HFhhD4Onx52GpqecBq1sZlWAZ9yc2WhEKJVnXLBULT5aJsGErD+78+V7Qo6M/9rJax
         21rw7u3EQAS4KeNHa0TaNKNL3xL22cQnlCbDDSw5Mw2qI/gB6iaD4NccALMhs7pE6gsw
         mG7e4EeVbWTA+eybcCXzt6Hl6REAXfySggvr4dCG2NPyjAd1ZSDecwpkshyaOOsboAtV
         TCOtDzVTR0Fav5WOgN7nUTzAv5KhB+BIvEg4KaiouJqtSe1nDh7anFL8V5rCDrxCcere
         cUCnVAyfN7actB2sMdT+73Uh1FKqtooZVxFbnqz4WAwyiaV1SFg9AlVBIZFi/oWe9Mbu
         6jnA==
X-Forwarded-Encrypted: i=1; AJvYcCVBrI9k6TxQD8EfG9/E44i9CL2K8O37VLm3fnXk8GVZEO7Dx4pMDq4PgX4HsmfIjdJ8jXcDapY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyzsQIijq6lJ5QhLb8iI77XF0tc/d/epEnKT2k3mFz5ufsZlJWO
	tHpbEWGFfThsstYX8ciMWvMIWW/2ZvSERsXt0eLSkCNneR5tmWUckQQIr1XM9O4=
X-Google-Smtp-Source: AGHT+IFFazcNX159kK7SKOq3ShS1WRwWJWRp6OZkagarAkcqWS51wR1mfV0IdI+S6h5u6ZnObCUCUQ==
X-Received: by 2002:a05:6512:6ca:b0:52e:f2a6:8e1a with SMTP id 2adb3069b0e04-53b23e1913amr2312323e87.29.1729835479883;
        Thu, 24 Oct 2024 22:51:19 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53b2e1c7aa8sm60541e87.187.2024.10.24.22.51.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Oct 2024 22:51:19 -0700 (PDT)
Date: Fri, 25 Oct 2024 08:51:16 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Manikanta Mylavarapu <quic_mmanikan@quicinc.com>
Cc: andersson@kernel.org, mturquette@baylibre.com, sboyd@kernel.org, 
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, konradybcio@kernel.org, 
	catalin.marinas@arm.com, will@kernel.org, p.zabel@pengutronix.de, 
	richardcochran@gmail.com, geert+renesas@glider.be, angelogioacchino.delregno@collabora.com, 
	neil.armstrong@linaro.org, arnd@arndb.de, nfraprado@collabora.com, quic_anusha@quicinc.com, 
	linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org, 
	quic_srichara@quicinc.com, quic_varada@quicinc.com
Subject: Re: [PATCH v8 5/7] clk: qcom: Add NSS clock Controller driver for
 IPQ9574
Message-ID: <jhykmuvgltvuqf74evvenbagmftam2gaeoknuq5msxop4mkh65@dya6vvqytfcx>
References: <20241025035520.1841792-1-quic_mmanikan@quicinc.com>
 <20241025035520.1841792-6-quic_mmanikan@quicinc.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241025035520.1841792-6-quic_mmanikan@quicinc.com>

On Fri, Oct 25, 2024 at 09:25:18AM +0530, Manikanta Mylavarapu wrote:
> From: Devi Priya <quic_devipriy@quicinc.com>
> 
> Add Networking Sub System Clock Controller(NSSCC) driver for ipq9574 based
> devices.
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202410101431.tjpSRNTY-lkp@intel.com/

These tags are incorrect. Please read the text of the email that you've
got.

> Signed-off-by: Devi Priya <quic_devipriy@quicinc.com>
> Signed-off-by: Manikanta Mylavarapu <quic_mmanikan@quicinc.com>
> ---
> Changes in V8:
> 	- Remove DT_BIAS_PLL_NSS_NOC_CLK and P_BIAS_PLL_NSS_NOC_CLK
> 	  because these are not required

What was changed to overcome the LKP error?

> 
>  drivers/clk/qcom/Kconfig         |    7 +
>  drivers/clk/qcom/Makefile        |    1 +
>  drivers/clk/qcom/nsscc-ipq9574.c | 3080 ++++++++++++++++++++++++++++++
>  3 files changed, 3088 insertions(+)
>  create mode 100644 drivers/clk/qcom/nsscc-ipq9574.c
> 
-- 
With best wishes
Dmitry

