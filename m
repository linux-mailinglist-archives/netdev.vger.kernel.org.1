Return-Path: <netdev+bounces-77356-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 43EBB8715F3
	for <lists+netdev@lfdr.de>; Tue,  5 Mar 2024 07:41:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 759E01C21A55
	for <lists+netdev@lfdr.de>; Tue,  5 Mar 2024 06:41:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01F473D0B9;
	Tue,  5 Mar 2024 06:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cmTAEMHn"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com [209.85.219.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 398C627457
	for <netdev@vger.kernel.org>; Tue,  5 Mar 2024 06:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709620893; cv=none; b=AGHKDqeIZ1zkoCJGadyc0HSXrXzL/ak4lSp++K417fpQLJK8bqDAbqVI3wyiBNG0SkIVjSpNxAXmex+clAx5sEj7hst/4HJQCilCypkaeE+QPVXvezqHfjarFR/Ioa0h1W06FENQedlfThpac92+He8hBh23ON630nk9Mwti4pw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709620893; c=relaxed/simple;
	bh=Ps/VJqEyp7guXeJPu2FrOwduSl73CHpkzvjzkVsVtTU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tzW1/3j2gqOBz9yy9tz5Wudl7/cvcHUyGdrS+1fdXt5YvT+YYYwcDcbCUBjKkI60O8AMuoAeOI8U7NcbDRZAbsBNjT0NP/5vLK620KOcPI8sZgnT1zrsYpWRXAPCLUHk3dj1OrVR6dQ/dsQvTcAlj2LyVfN6ndZMzvD37MasttQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=cmTAEMHn; arc=none smtp.client-ip=209.85.219.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f181.google.com with SMTP id 3f1490d57ef6-dcc84ae94c1so5014922276.1
        for <netdev@vger.kernel.org>; Mon, 04 Mar 2024 22:41:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709620891; x=1710225691; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ccg/Lc70kvp90dYd+ZbmISgOfdv3HBJZ65KNlm+3N78=;
        b=cmTAEMHnM+IvXsUZliiWRWExCL3kxOKkN5wLTtToV09GgSRz2VwJnHzzkpVzgNW/h8
         hWJ5qvyeir3KPc9B9jtkbqfjxtvqHk1noXwdg9HV0M+Orld8w3bSE89IsQyot1AHQ1Un
         d9GOHfzoowjdsis8t1L5ROH+xQ5bUAziO93pMUziLnuKTJ6uU5KeVoIDnYVzWykEzYtN
         FFQsrGNLkNtX9VGYdigky1g/5mv/nDBDTP0WGq0HQBdj2NlwlRNCkEwrRFtqQK2cEW8M
         28saLrbaWtv0goWzopKOp/9lN78g/HWU2GJWbJ7VLApQwtotb0+J0X3nTquWatMHewGo
         6sYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709620891; x=1710225691;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ccg/Lc70kvp90dYd+ZbmISgOfdv3HBJZ65KNlm+3N78=;
        b=neftUXIq9BjBjos2bPwIaMZZZCwVqY/TD9ScFaw6+wyyLohXE8FqHeWwilpzD33dYR
         l7an37QwR5lVEwwST2PPTsIU4DSUKD05Q6W/6P3Dj2X3it+UL20ydl8I6yFHAOnH7lQL
         9fOLKrUkG0zT+WamL/rpay/Y6ZUlrr29+gumzpk9xik5OF0dlhXYy8TGtOcfbC/EtKGu
         a4Xar3oj8A6Ezi/SHUv7UpPy5mB9rfwxRk9IthRfgWhzWPiYGpFTiToRBtWpdsbjUK6F
         087J3+yfLPqn8xSC54v379bxFGCE+u81oFPrGP+PEjv78akXlza9bLzDf7eoS6jIoC/A
         RXBQ==
X-Forwarded-Encrypted: i=1; AJvYcCWd8EB0Dgp8hvqmGbzLv4DbPxwIlsITzPxAg69VB5JyWHkh8Ba3eCQNRsJ7bXRwhshg3viC6u+FqkidoZqqP06xoGa2H19X
X-Gm-Message-State: AOJu0YyvJYuCQbFhCsT1RwPzXjV6zglZmmj5MJAF8Nr2/frXHlRLbCSY
	yz16EkukLFKSqM+G6YnxPZB9Xf/oQqmScU/APH+sy2T3uNUES1x6jUzJPiSm4Z6k799R0J3yhad
	xj0s/yTRLp2pSmxCQ3JXgTMoiQkzdz+LkTxtxLw==
X-Google-Smtp-Source: AGHT+IGRNcWGc+ovIvoeKHsS2bsRGRrdE1GgYvwR+P/OeZcykFPfCL7rKLURH+3X2nQAEd3t1oe4qRWeuBF8ZkkOBug=
X-Received: by 2002:a05:6902:305:b0:dcf:bc57:cd61 with SMTP id
 b5-20020a056902030500b00dcfbc57cd61mr8363686ybs.50.1709620891239; Mon, 04 Mar
 2024 22:41:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240122-ipq5332-nsscc-v4-0-19fa30019770@quicinc.com>
 <20240122-ipq5332-nsscc-v4-2-19fa30019770@quicinc.com> <7a69a68d-44c2-4589-b286-466d2f2a0809@lunn.ch>
 <11fda059-3d8d-4030-922a-8fef16349a65@quicinc.com> <17e2400e-6881-4e9e-90c2-9c4f77a0d41d@lunn.ch>
 <8c9ee34c-a97b-4acf-a093-9ac2afc28d0e@quicinc.com> <CAA8EJppe6aNf2WJ5BvaX8SPTbuaEwzRm74F8QKyFtbmnGQt=1w@mail.gmail.com>
 <74f585c2-d220-4324-96eb-1a945fef9608@quicinc.com> <CAA8EJppuNRB9fhjimg4SUR2PydX7-KLWSb9H-nC-oSMYVOME-Q@mail.gmail.com>
 <d518dbc1-41aa-46f9-b549-c95a33b06ee0@quicinc.com> <CAA8EJppP_bAPRH7Upnq8dO7__xQPOJ6F_Lc-fpRAcutKKzk0eA@mail.gmail.com>
 <3a6d301d-16f6-4a11-8be5-6bbb6eb501f4@quicinc.com>
In-Reply-To: <3a6d301d-16f6-4a11-8be5-6bbb6eb501f4@quicinc.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Tue, 5 Mar 2024 08:41:19 +0200
Message-ID: <CAA8EJpq2x-1mbBApGH5CiGZqCVhdP97pveZupdJyGQGo3MT8-Q@mail.gmail.com>
Subject: Re: [PATCH v4 2/8] clk: qcom: ipq5332: enable few nssnoc clocks in
 driver probe
To: Kathiravan Thirumoorthy <quic_kathirav@quicinc.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konrad.dybcio@linaro.org>, Michael Turquette <mturquette@baylibre.com>, 
	Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Richard Cochran <richardcochran@gmail.com>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org, 
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
	netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 23 Feb 2024 at 12:18, Kathiravan Thirumoorthy
<quic_kathirav@quicinc.com> wrote:
>
>
>
> On 2/19/2024 3:53 PM, Dmitry Baryshkov wrote:
> > On Sun, 18 Feb 2024 at 06:29, Kathiravan Thirumoorthy
> > <quic_kathirav@quicinc.com> wrote:
> >>
> >>
> >>
> >> On 2/17/2024 10:15 PM, Dmitry Baryshkov wrote:
> >>> On Sat, 17 Feb 2024 at 17:45, Kathiravan Thirumoorthy
> >>> <quic_kathirav@quicinc.com> wrote:
> >>>>
> >>>>
> >>>> <snip>
> >>>>
> >>>>>> Reason being, to access the NSSCC clocks, these GCC clocks
> >>>>>> (gcc_snoc_nssnoc_clk, gcc_snoc_nssnoc_1_clk, gcc_nssnoc_nsscc_clk)
> >>>>>> should be turned ON. But CCF disables these clocks as well due to the
> >>>>>> lack of consumer.
> >>>>>
> >>>>> This means that NSSCC is also a consumer of those clocks. Please fix
> >>>>> both DT and nsscc driver to handle NSSNOC clocks.
> >>>>
> >>>>
> >>>> Thanks Dmitry. I shall include these clocks in the NSSCC DT node and
> >>>> enable the same in the NSSCC driver probe.
> >>>
> >>> Or use them through pm_clk. This might be better, as the system
> >>> doesn't need these clocks if NSSCC is suspended.
> >>
> >>
> >> IPQ53XX SoC doesn't support the PM(suspend / resume) functionality, so
> >> that, can I enable these clocks in NSSCC driver probe itself?
> >
> > There is a difference between PM (suspend/resume) and runtime PM.
> >
> >
>
> Thanks Dmitry. IIUC your question correctly, runtime PM for the
> peripherals are not supported (except CPU cores which supports DVFS).
> Since these are router based products, once system is powered on, all
> the peripherals are configured to the required frequency and it will be
> never go into low power modes.
>
> Please let me know if this answers your questions.

It seems there is a misunderstanding somewhere. Runtime PM allows the
Linux kernel to disable temporary unused devices at runtime. E.g. if
the NSS is switched off, the kernel can switch NSSCC off too, cutting
the power. It has nothing to do with the frequency of the device /
clock or with the product being a router or a mobile device.


-- 
With best wishes
Dmitry

