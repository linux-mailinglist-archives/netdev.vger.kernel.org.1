Return-Path: <netdev+bounces-50178-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 107A37F4C71
	for <lists+netdev@lfdr.de>; Wed, 22 Nov 2023 17:32:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BDAFD281299
	for <lists+netdev@lfdr.de>; Wed, 22 Nov 2023 16:32:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6298B4F1E4;
	Wed, 22 Nov 2023 16:32:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ujriAYPH"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDB2A10DF
	for <netdev@vger.kernel.org>; Wed, 22 Nov 2023 08:32:32 -0800 (PST)
Received: by mail-lf1-x12d.google.com with SMTP id 2adb3069b0e04-507a3b8b113so9797829e87.0
        for <netdev@vger.kernel.org>; Wed, 22 Nov 2023 08:32:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1700670751; x=1701275551; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Q3CpM5/THx6+8DnjFCPVffJyK/2ER98rSKDWGZl4fAA=;
        b=ujriAYPHAWMdIq41fFWFPjbVdohxhz86pE6yoc/Rf2qou/o+M+Rn45lYhjnZ4Zi0dU
         sGPFIltMxXIO3RJeR0kNKpFjZHUCRKlwRgRCzRbCGdCpCFpU78pVukFYNZ9wQKwA8Mp9
         qZBBe8YnmR9zMilQrt8qh3JRPq6AcY3U8yFDqOQS+jBv56WTmp4QveWUXUvp7iKfhHEJ
         wEqWtltKiNbYpVbOC2H1NfoJlzKUu8Ly3OGBQpa0VlY+MIv5E5nDbi/gEchoFAp+OI8z
         DIXKj9iVM+CKgSsiOpVIDicb78xvXYPJgMudmEnBkAb8EWeCL7kUij7z4zPicFtzbgU3
         m42A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700670751; x=1701275551;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Q3CpM5/THx6+8DnjFCPVffJyK/2ER98rSKDWGZl4fAA=;
        b=Lptx9VwNBn/Fq9p7NeafyX39J0YztHOJAsC+ZQjB7avaaOVSyt5p+wXXLNHscdaFoN
         dOIjeZM/vj0vcryOM1A/0CSwS43XGMEg9BDEMkVKgSuHXbZUrfWnSqKzgofAKHVRdXVs
         M6PEB7/oi6LssDrLVJx4aPZM57rG/aGenHjIrqliiUwCsOR3ynNKOeQpnexK8kPfQegD
         pS/0xr5J3sHZIACS7bYacUJ6fW/mCXKGl79t01bmnlJcYGjg3gTV2skCyNg3kVvzHsxo
         9U3Rid0vTl5In0kAC31aUmQBOe6K4UYtxW0ProDwFx8FY1ml/OlU8+e0hoJQUMTQeFZw
         p7+g==
X-Gm-Message-State: AOJu0YwPu7KVbeF3tY/n5fI9/eIRtlu0+/iKWV41RIZvbrnpYVwcYBf3
	TypMN4xbBQ7iJ9NTvMsCAgrRHQ==
X-Google-Smtp-Source: AGHT+IEswAuYBltyPm+uze537OkFpnHIvLyX+dTfkYTTj3/W/ds74UqBcuP0IiPRNjnnsPDDUNv/dA==
X-Received: by 2002:a19:5514:0:b0:50a:a6c3:4b21 with SMTP id n20-20020a195514000000b0050aa6c34b21mr1976243lfe.32.1700670750880;
        Wed, 22 Nov 2023 08:32:30 -0800 (PST)
Received: from [172.30.204.227] (UNUSED.212-182-62-129.lubman.net.pl. [212.182.62.129])
        by smtp.gmail.com with ESMTPSA id k7-20020a05651210c700b0050a6fd7ec34sm1886640lfg.191.2023.11.22.08.32.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Nov 2023 08:32:30 -0800 (PST)
Message-ID: <a27e1190-69c2-4879-9917-b9545bb6a118@linaro.org>
Date: Wed, 22 Nov 2023 17:32:25 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/9] clk: qcom: ipq5332: enable few nssnoc clocks in
 driver probe
Content-Language: en-US
To: Kathiravan Thirumoorthy <quic_kathirav@quicinc.com>,
 Andy Gross <agross@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Richard Cochran <richardcochran@gmail.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20231121-ipq5332-nsscc-v2-0-a7ff61beab72@quicinc.com>
 <20231121-ipq5332-nsscc-v2-2-a7ff61beab72@quicinc.com>
From: Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20231121-ipq5332-nsscc-v2-2-a7ff61beab72@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Level: *



On 11/21/23 15:30, Kathiravan Thirumoorthy wrote:
> gcc_snoc_nssnoc_clk, gcc_snoc_nssnoc_1_clk, gcc_nssnoc_nsscc_clk are
> enabled by default and it's RCG is properly configured by bootloader.
> 
> Some of the NSS clocks needs these clocks to be enabled. To avoid
> these clocks being disabled by clock framework, drop these entries
> from the clock table and enable it in the driver probe itself.
> 
> Signed-off-by: Kathiravan Thirumoorthy <quic_kathirav@quicinc.com>
> ---
Acked-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad

