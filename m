Return-Path: <netdev+bounces-222477-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 75E1AB546A8
	for <lists+netdev@lfdr.de>; Fri, 12 Sep 2025 11:16:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 13A2916B36D
	for <lists+netdev@lfdr.de>; Fri, 12 Sep 2025 09:16:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DB62279DDB;
	Fri, 12 Sep 2025 09:16:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oVskzjEn"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B855257845
	for <netdev@vger.kernel.org>; Fri, 12 Sep 2025 09:16:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757668580; cv=none; b=eVrwH6C65NAmfgKHBXp/fFZOg6nLKzFGkW+hyAzgKGcRqx6/uqWtwsmYr5VMKuGnRfqjp0zNiaNy63tJOvpeAfRC4xQ1vBAG7THVnvSPt8+BtDG7M147cuDQI3gjKSuuVln7HgGhq/qnJL+ndODEpqsRkR76SrPMdZf0uG7M/2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757668580; c=relaxed/simple;
	bh=rbS/1vMnW+r9vE3ko/WdtF1tXfqWrp2841CIMEd3PnU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=I2HhzmW3maEBhd1VY2TRbVnkOSaeXwaHipOTJpdogZi30RBtCGy5Y8za9WtSgVNuX5iQ8OCex94GmRAZwAh6FVmEECWCtr1769PrQJTvCfRSAVRPjvtxKtVp/OMQggDYHB7IIuRmMai0cDGfF3ms3UVy6PJODS4xV9/poMIlIWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=oVskzjEn; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-45ddfe0b66dso2844075e9.3
        for <netdev@vger.kernel.org>; Fri, 12 Sep 2025 02:16:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1757668577; x=1758273377; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=AakhypBYQL8o+d6jwji8uy7YTM/iJpZSs4ckPqgcd2U=;
        b=oVskzjEnmsosig/ptmmcu3mMnDjn7WXx7li3pEd6eaMOpGkbdtNZD2G/ktJBxGZmsf
         4Fus5jFpU+/91FlWuFI0feWQCqDldtXx5vjE5szfKKi8U1jHwPccN/hQ6FYhoG61escW
         wHhAgX7dbNxfkA1hjpCI0+Cwxabt6lPTf37+jVZExfMA8H4q91AgIxRM7dZ5daWWl5ta
         3XZs0/wUDkVrWWy7zxuBBplZxebWG5yjAx5wgJ947WLYEH3/UQ4WmdlD7L20qgJjsOk6
         YMtdbq0Cdcyn68HZi3l454Tc6G34zMzgOfzZm+COHc6R2QKApoXple5tYMwiQwY1Mt3n
         mrpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757668577; x=1758273377;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AakhypBYQL8o+d6jwji8uy7YTM/iJpZSs4ckPqgcd2U=;
        b=lijY1CXxCynhmPgNntXyyuefYfq6U9NBeaAkNWLp+BFHJlj/TKBleCH3/2gPeDQGYp
         FVSjH1QDGFaYg3jxLJ2V4xBrCLpjyEKzV/OMPyfv+vNPBmj2Dbi/mHdor6pSohR4Fmu7
         OyzwzpIIVmh8gtJTch/LAnquQTIYTCLPoKN4prTXtMnXYjj3dSyAJzGSBeOO1HX4RBSr
         pbeKsvVgBlrRmVpFQ9et/Dv6oYVwXD21t6enTyoKwyorxeHJiZq5t6yQ01En+7olxBE5
         rGLPOc+2RC2wiIRx+YJ20+PCwBr8wOq/dtG2DIGWkqNfZ5T0Tg0H58O2xfLMhucvtv/n
         HiLg==
X-Forwarded-Encrypted: i=1; AJvYcCXD8SDn2H6OXCQyb0lSTZAo1VYdayegGurjVs25jexg0eYZU8u8k2YGE9vUC35Ypf7IVvBgaJ8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzXI8sV7EvJsIZQO1X85b+/q2BY6w0KNUwTYmAlGEZRpcKTFK7O
	GYeNWpG9w0HRCp87ttXmD1LEJbHfHLYK0cG9NoUmsx9+1yH3JeYfqcO4XKsy/asUfvE=
X-Gm-Gg: ASbGncuZtt7wKLKUxPc5VWp28FmNgXX5lkOcOGqnc6sAWbC4BSGsW3KmZkWwIamBSbY
	fmLHgBSqcski/hKb4nq3FN8tQJU+s5Xhr5XZaDiJkCy7040pWJt34CNjYAjt6GEsf7UMe1HPj6W
	guQ+lgarf6bof7LIrr6R52lkOMqqWfaLIa+PIkbllMN/KWxn18FoOHybzhGY+rp+hdGABSdwBmX
	JjMMghcdKQSyE57Mgn66mBY8t7ei84e2pMpImTm/XptSyITf5ztmLH9fqEMQlUdTIT6K2s19XyQ
	/2RE+c9LzDouVS+PysLOGuL90Lu8bqqxj3Fom4OjIQau1dLYHMg6kf5nPp3jTpjpNV7egXn+67f
	56Orft2aE9Bf8f1MNM9SVgqyp3I7GHUn3E+dqbIHf66NUaCDIi3QsRg==
X-Google-Smtp-Source: AGHT+IF8vJt3OJv2R8HpQH2zes8jRU5cdpMi8Ohs9bCmtG+T7zKSQBaHZYMDfUi9FSV/gYpCZFu5Ww==
X-Received: by 2002:a05:600c:1c87:b0:45d:d33b:4697 with SMTP id 5b1f17b1804b1-45f2313d499mr6962295e9.3.1757668576008;
        Fri, 12 Sep 2025 02:16:16 -0700 (PDT)
Received: from [192.168.1.29] ([178.197.219.123])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45e037c9d91sm53878945e9.20.2025.09.12.02.16.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Sep 2025 02:16:15 -0700 (PDT)
Message-ID: <0aa8bf54-50e4-456d-9f07-a297a34b86c5@linaro.org>
Date: Fri, 12 Sep 2025 11:16:12 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 02/10] dt-bindings: clock: Add required
 "interconnect-cells" property
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
 Luo Jie <quic_luoj@quicinc.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, Varadarajan Narayanan <quic_varada@quicinc.com>,
 Georgi Djakov <djakov@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Anusha Rao <quic_anusha@quicinc.com>,
 Manikanta Mylavarapu <quic_mmanikan@quicinc.com>,
 Devi Priya <quic_devipriy@quicinc.com>,
 Philipp Zabel <p.zabel@pengutronix.de>,
 Richard Cochran <richardcochran@gmail.com>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
 devicetree@vger.kernel.org, netdev@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, quic_kkumarcs@quicinc.com,
 quic_linchen@quicinc.com, quic_leiwei@quicinc.com, quic_pavir@quicinc.com,
 quic_suruchia@quicinc.com
References: <20250909-qcom_ipq5424_nsscc-v5-0-332c49a8512b@quicinc.com>
 <20250909-qcom_ipq5424_nsscc-v5-2-332c49a8512b@quicinc.com>
 <20250912-nocturnal-horse-of-acumen-5b2cbd@kuoka>
 <b7487ab1-1abd-40ca-8392-fdf63fddaafc@oss.qualcomm.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Content-Language: en-US
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 2+47PN9NZAOyb771QoVr8A==
In-Reply-To: <b7487ab1-1abd-40ca-8392-fdf63fddaafc@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/09/2025 11:13, Konrad Dybcio wrote:
> On 9/12/25 9:04 AM, Krzysztof Kozlowski wrote:
>> On Tue, Sep 09, 2025 at 09:39:11PM +0800, Luo Jie wrote:
>>> The Networking Subsystem (NSS) clock controller acts as both a clock
>>> provider and an interconnect provider. The #interconnect-cells property
>>> is mandatory in the Device Tree Source (DTS) to ensure that client
>>> drivers, such as the PPE driver, can correctly acquire ICC clocks from
>>> the NSS ICC provider.
>>>
>>> Although this property is already present in the NSS CC node of the DTS
>>> for CMN PLL for IPQ9574 SoC which is currently supported, it was previously
>>> omitted from the list of required properties in the bindings documentation.
>>> Adding this as a required property is not expected to break the ABI for
>>> currently supported SoC.
>>>
>>> Marking #interconnect-cells as required to comply with Device Tree (DT)
>>> binding requirements for interconnect providers.
>>
>> DT bindings do not require interconnect-cells, so that's not a correct
>> reason. Drop them from required properties.
> 
> "Mark #interconnect-cells as required to allow consuming the provided
> interconnect endpoints"?


The point is they do not have to be required.

Best regards,
Krzysztof

