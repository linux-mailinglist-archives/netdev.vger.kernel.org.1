Return-Path: <netdev+bounces-107365-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F02F191AADF
	for <lists+netdev@lfdr.de>; Thu, 27 Jun 2024 17:15:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ADA5928A425
	for <lists+netdev@lfdr.de>; Thu, 27 Jun 2024 15:15:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC1081991B5;
	Thu, 27 Jun 2024 15:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PL6/Oc/E"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com [209.85.219.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0703C198A28
	for <netdev@vger.kernel.org>; Thu, 27 Jun 2024 15:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719501301; cv=none; b=ppSpdnOrLRHkPz4kTQVNqVePMT0sA1gCsrbl4Ydtgyh/zVIBNyaaZtJW1vnulPR0Z1J4X69UlpNAlgovQs8PVnLmBJ7CLTyUaYu4F/tvsau3GWceaS6Y+RXgqBVD4Xa2NZTU/fJHYqxnl037RwcA/yiCKtgHHddZG3gyUFij4vk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719501301; c=relaxed/simple;
	bh=8eem//ITjEXYdm72pHz9iK8ciJdXphch4zpUa3zYnNk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HiDqAuRA7+qHnGxM5W5VLXLMne2ccNtAFhGKezuWVIZBDrGd15qb8ZcplUVN90SEROf5CQarwr1tw7X8Zv4xPCZme9E/dMgVf5YTEvwP2GX9eLW4/6LkCSNKeVPsDRP6CeUwHJ9h/S467ERWJIGBM1jUxOYkozagftiCjn90oY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=PL6/Oc/E; arc=none smtp.client-ip=209.85.219.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-e02e4eb5c3dso7114989276.3
        for <netdev@vger.kernel.org>; Thu, 27 Jun 2024 08:14:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1719501299; x=1720106099; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=+hwRyUjzUUY1CTiMvK15nbjIjb4MSnbZcFsEElNFFbM=;
        b=PL6/Oc/EkakHVxHkrw44QdyTe1Ir4u4V2a1mTaekekOgKyGTSn1ru9STNk/D4aVChX
         +z0xcS6PEm6Hoqhug0jK6OsRvbygxnFz3uVgAGiOnnWR2wrxGkt9zyunMOFT8qPlwH9e
         ZxsZAJqOmBkVCL6cwn6pvn/MGMJ9WAw8qyazAyu0T2wfGCvVd5T5gNE2NXEEzGoARGjC
         1S2AhT102+qMRqsqvas++27E4+pyVrgfaU+wIC/4Pl2zqERdnMg8wLpi74i/hnvrPBSs
         VcCveeukCFaCDlMYOovzsVDH9rY7B0/lLSspVQAWR1J2RyhSyrZJdI280YS8gB7Ypzmk
         yEFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719501299; x=1720106099;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+hwRyUjzUUY1CTiMvK15nbjIjb4MSnbZcFsEElNFFbM=;
        b=N547R+I7OfPqAk7vWATD9IUgirgKExe3H0NQX+5tHRnzlI71tSUIw7ashgg2hKnqyi
         YkeNMRscUcMX4SKqNVqqMnfbQb1Wq85lz8561SxH8/+Q0NjxPcdUfyQzXDRE1IfrgBmz
         myiA+5WW1rJ/X7zP8CYSwo+3TFt82nf4zx7+vfo3MoF+oKeSU6wSUVguHWAsLPdLZ3sm
         SsVExjPLfduMnWp4YYwpDY3SqDzLLWBi+vpNEPnELJr1agqe5RJek2oGrNPnjF4kIOnW
         EasoEoovw2tt/6hDLY7fbmWqIb/Yc1IBZa2xfvgBBKWaOTA7IAizEhp5ECKxu1JmItEi
         he/Q==
X-Forwarded-Encrypted: i=1; AJvYcCWl8/YKWt0y7l6usXdcWgp7MKBU/FSRLjYOPpXkPNMlVWf+f6jdcy/xXow2aARIS8TZAcchm1cBLfSJdb4ogyfYebGj3q+B
X-Gm-Message-State: AOJu0Yw6IIhN37al7Wuk9q0qtvZwHsD8LhrIH3vt3B2g/pEt4OzY4wMv
	+bn2tOsYDbqljg61OjnnHDR3y7qB1v0NOGkXtuOndmAYsQyzcEopPMUPmkHkupzoQEdaNXodFzP
	mcfu6nqXX3EpbjglJJAbAdeUxyNv6oJ11UaSmyw==
X-Google-Smtp-Source: AGHT+IEIdj5kMgp1wElSphuCogD/aifBCB+hXxrUP1eZ9IZ1k197mI29RMs431bOzaAjpNxukowNArLWDrSnNW0Js8w=
X-Received: by 2002:a81:9e0b:0:b0:62f:945a:7bb1 with SMTP id
 00721157ae682-6429c6dae8cmr154073967b3.42.1719501299067; Thu, 27 Jun 2024
 08:14:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240625070536.3043630-1-quic_devipriy@quicinc.com>
 <20240625070536.3043630-6-quic_devipriy@quicinc.com> <2391a1a1-46d3-4ced-a31f-c80194fdaf29@linaro.org>
 <69126dff-fe23-48d3-99b5-a2830af52e6a@quicinc.com>
In-Reply-To: <69126dff-fe23-48d3-99b5-a2830af52e6a@quicinc.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Thu, 27 Jun 2024 18:14:47 +0300
Message-ID: <CAA8EJpoAKJqDH1z44_93kYLoAeAZ30TQe+=4ty1UgMydLUCxJQ@mail.gmail.com>
Subject: Re: [PATCH V4 5/7] clk: qcom: Add NSS clock Controller driver for IPQ9574
To: Devi Priya <quic_devipriy@quicinc.com>
Cc: Konrad Dybcio <konrad.dybcio@linaro.org>, andersson@kernel.org, mturquette@baylibre.com, 
	sboyd@kernel.org, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	catalin.marinas@arm.com, will@kernel.org, p.zabel@pengutronix.de, 
	richardcochran@gmail.com, geert+renesas@glider.be, neil.armstrong@linaro.org, 
	arnd@arndb.de, m.szyprowski@samsung.com, nfraprado@collabora.com, 
	u-kumar1@ti.com, linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 27 Jun 2024 at 08:37, Devi Priya <quic_devipriy@quicinc.com> wrote:
>
>
>
> On 6/25/2024 10:33 PM, Konrad Dybcio wrote:
> > On 25.06.2024 9:05 AM, Devi Priya wrote:
> >> Add Networking Sub System Clock Controller(NSSCC) driver for ipq9574 based
> >> devices.
> >>
> >> Signed-off-by: Devi Priya <quic_devipriy@quicinc.com>
> >> Tested-by: Alexandru Gagniuc <mr.nuke.me@gmail.com>
> >> ---
> >
> > [...]
> >
> >> +    struct regmap *regmap;
> >> +    struct qcom_cc_desc nsscc_ipq9574_desc = nss_cc_ipq9574_desc;
> >
> > Why?
> Sure, Will drop this in V6.
> >
> >> +    struct clk *nsscc_clk;
> >> +    struct device_node *np = (&pdev->dev)->of_node;
> >> +    int ret;
> >> +
> >> +    nsscc_clk = of_clk_get(np, 11);
> >> +    if (IS_ERR(nsscc_clk))
> >> +            return PTR_ERR(nsscc_clk);
> >> +
> >> +    ret = clk_prepare_enable(nsscc_clk);
> >
> > pm_clk_add()? And definitely drop the 11 literal, nobody could ever guess
> > or maintain magic numbers
> Hi Konrad,
>
> nsscc clk isn't related to power management clocks.
> Also, I believe it might require the usage of clock-names.

No. First of all, you can use pm_clk_add_clk. And even better than
that, you can add pm_clk_add_by_index().

> Do you suggest adding a macro for the literal (11)?

No, add it to DT_something enumeration.

> Please correct me if I'm wrong.

-- 
With best wishes
Dmitry

