Return-Path: <netdev+bounces-193123-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 70BA4AC292B
	for <lists+netdev@lfdr.de>; Fri, 23 May 2025 19:59:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CEDB9A26F1A
	for <lists+netdev@lfdr.de>; Fri, 23 May 2025 17:59:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EEAC299AB4;
	Fri, 23 May 2025 17:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ieee.org header.i=@ieee.org header.b="N8d27b24"
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f178.google.com (mail-il1-f178.google.com [209.85.166.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A43A0299958
	for <netdev@vger.kernel.org>; Fri, 23 May 2025 17:59:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748023174; cv=none; b=KVlIVqGysGwzb4FcHHmOYEIS+xHeWL3Mahx60ICQZnl9ay7l4iDZnywZX3gVIQdQl4ziZsqRqFb6wI7hGyRDG2TjhjtDe3zYl7xVO6s4UBUE7YHQsMh7C1udOlTOHsZ0eMpMmVw7Bva+XlGrxoZiL//LXcj2NZ/QzmGiuIcEYiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748023174; c=relaxed/simple;
	bh=8wsWQ5YjMTwGPMyYB18B6uzDSiUbxxRChxzdHy4FbyE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bEej6y851GXS4QOG0v+Iu/zatppBtQdBaxMr4frenUQjgW2Vj8DmGwlPxFttlEtm3uG0Skfd+hPXKspDtagfkAMeJNg52xAdxVuxvX30HSVVShXAnpeWwq2ULIWspyhK+sJoYCM1xxGPoeCKHG4s26DnWVJRq69yEBNTY4J8xtg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ieee.org; spf=pass smtp.mailfrom=ieee.org; dkim=pass (1024-bit key) header.d=ieee.org header.i=@ieee.org header.b=N8d27b24; arc=none smtp.client-ip=209.85.166.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ieee.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ieee.org
Received: by mail-il1-f178.google.com with SMTP id e9e14a558f8ab-3dc73b1bd7aso976705ab.1
        for <netdev@vger.kernel.org>; Fri, 23 May 2025 10:59:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ieee.org; s=google; t=1748023172; x=1748627972; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mjndw5gm+i4IsAlDvyxOC/Zv2WGk4Ah4DOr+VHcYMi0=;
        b=N8d27b24VaP4yyOw9S0TwldtZLHF3XtK71oGcMie3cw8R891fcNFmkNUtHzenE1IUp
         1kQ5YE/PJ+BLTsCCMZ8N4oC6smW4dAhEVjp3oZ+D8Gq/dIM9E8Apix7kAsF7AO+9sHnz
         3Ko3go1tMUsIK9TDChCq/QLiZjI8UkAOnasEw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748023172; x=1748627972;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mjndw5gm+i4IsAlDvyxOC/Zv2WGk4Ah4DOr+VHcYMi0=;
        b=tP9A4x1gVQ+GfI/sgNP/w2JRbXOjGryZsw8pQQ61pAe7c/wOAw7nS4ugoLA87z/AQ4
         tObVv0LbaZA48ejbtYo9Ug6pOAQZVyvdWmLOFQnjzHKgcA++8Gd4JEge7vwIpmhKVGCp
         YyeUCnbu7bkqL76ZHRymDaerfbPNiBl79WFeNj23yDcBqMVa+1I89ju/KcIdqJyTDg/O
         f9C9Tm/w4lcKdNfI5FLR5xH9fBk0QHlTHmWfyMNZIhXKQy166tQy+iSgczwbHfkJfXRm
         tFjZwEljqiTLYVqzzMYoofG0bQjK7mPUdZsN3+vqhW9kiyeHGRmCXaQRfrpJtxylUS9C
         VRfA==
X-Forwarded-Encrypted: i=1; AJvYcCVjqren/xG4BxoHMxfdXCstFYsR6yaZlqCHsC9lyJbDQb6jIqj40YTudx9uYQwsN5l917XJn2E=@vger.kernel.org
X-Gm-Message-State: AOJu0YznCA/KMJjlVYXSTOlT+36EQ9Chbl3CMt4lth+94pqBOkhJoN3q
	J63AWPPy/eGVKt1MpVDnwwOEfVFlgxmcggRdBUVPwPBdvOc5ma95kWeW789GJOvamA==
X-Gm-Gg: ASbGncuEVfteJ0wg/039nCk/C/wcYzn7QSdsL0V2L2lFmIrWf2Q0DycBSR/eFJPiedv
	hYut/ZRyg9MPM0sNNzgW9z2aXzqmDBLOL1W9NAeFbxXtwfPx3Y4TfyAFA+Tc4DtshEN99xMnhCD
	jCKQX95YKozxi56V+6sNHnsAHAEh9OKUossOAIjM+CLfB3YdiOkrBOIV3qf+Zw0d4C1oKuG1YB4
	+s1bUt+ju1pK9dBCxRI/lANht1RWkVu3Ntlb31Er8deeU1gTn24JmgvigxeY6k6xOexCC+xlm2f
	FlGQzYXLMF/MYE7/uJ+CsufHTAkBCsYfN1QnIMVzwCj5xzYnEBVpj5JZVlLak5QENdT0bivkDEe
	4Q7pyfqVWoQ==
X-Google-Smtp-Source: AGHT+IFoy1NsNZRyu/5wF07RFlt2gE/j7+7c1FVWoN4ouL4Kx/vkSLuJVz+D0by0S2cFl4gCyaut4w==
X-Received: by 2002:a05:6e02:1488:b0:3dc:8746:962b with SMTP id e9e14a558f8ab-3dc9b6e58d3mr1101925ab.15.1748023171708;
        Fri, 23 May 2025 10:59:31 -0700 (PDT)
Received: from [172.22.22.28] (c-73-228-159-35.hsd1.mn.comcast.net. [73.228.159.35])
        by smtp.googlemail.com with ESMTPSA id e9e14a558f8ab-3dc7f126188sm18218695ab.65.2025.05.23.10.59.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 May 2025 10:59:31 -0700 (PDT)
Message-ID: <c46e9435-e56d-4563-ba84-1d8c7ef0bab6@ieee.org>
Date: Fri, 23 May 2025 12:59:30 -0500
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] dt-bindings: net: qcom,ipa: Add sram property for
 describing IMEM slice
To: Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Alex Elder <elder@kernel.org>
Cc: Marijn Suijten <marijn.suijten@somainline.org>,
 linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
References: <20250523-topic-ipa_imem-v1-0-b5d536291c7f@oss.qualcomm.com>
 <20250523-topic-ipa_imem-v1-2-b5d536291c7f@oss.qualcomm.com>
Content-Language: en-US
From: Alex Elder <elder@ieee.org>
In-Reply-To: <20250523-topic-ipa_imem-v1-2-b5d536291c7f@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/22/25 6:08 PM, Konrad Dybcio wrote:
> From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> 
> The IPA driver currently grabs a slice of IMEM through hardcoded
> addresses. Not only is that ugly and against the principles of DT,
> but it also creates a situation where two distinct platforms
> implementing the same version of IPA would need to be hardcoded
> together and matched at runtime.
> 
> Instead, do the sane thing and accept a handle to said region directly.
> 
> Don't make it required on purpose, as a) it's not there on ancient
> implementations (currently unsupported) and we're not yet done with
> filling the data across al DTs.

We have to support "ancient" DTBs, right?  So unfortunately
the fallback can't go away.

> Signed-off-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Looks good.

Reviewed-by: Alex Elder <elder@riscstar.com>


> ---
>   Documentation/devicetree/bindings/net/qcom,ipa.yaml | 7 +++++++
>   1 file changed, 7 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/net/qcom,ipa.yaml b/Documentation/devicetree/bindings/net/qcom,ipa.yaml
> index b4a79912d4739bec33933cdd7bb5e720eb41c814..1109f4d170af7178b998c6b7d415cc60de1c58c5 100644
> --- a/Documentation/devicetree/bindings/net/qcom,ipa.yaml
> +++ b/Documentation/devicetree/bindings/net/qcom,ipa.yaml
> @@ -166,6 +166,13 @@ properties:
>         initializing IPA hardware.  Optional, and only used when
>         Trust Zone performs early initialization.
>   
> +  sram:
> +    maxItems: 1
> +    description:
> +      A reference to an additional region residing in IMEM (special
> +      on-chip SRAM), which is accessed by the IPA firmware and needs
> +      to be IOMMU-mapped from the OS.
> +
>   required:
>     - compatible
>     - iommus
> 


