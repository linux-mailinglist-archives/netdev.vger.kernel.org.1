Return-Path: <netdev+bounces-94706-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 97E8F8C0483
	for <lists+netdev@lfdr.de>; Wed,  8 May 2024 20:40:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4E7E61F224DA
	for <lists+netdev@lfdr.de>; Wed,  8 May 2024 18:40:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 480DD54FAA;
	Wed,  8 May 2024 18:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RY6z9kKQ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78973107B6
	for <netdev@vger.kernel.org>; Wed,  8 May 2024 18:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715193602; cv=none; b=q+NTRJERx3AWUtHRKTyEZL61J+iRsiZ7qN6MlFKhIvYyFGrbbrngxDkxBImvjOTSCKWk6kqSu4kt3bBYEQCBXCE4ZENgNka612rOnX5iy83YIPPgDGY+JvEZZxFHoecYcDd3S7vZiLm37wqMALMl67PsiM+SjNFQSWWVQ6knYnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715193602; c=relaxed/simple;
	bh=hoHi3AjYgp2H4mxjsiI6khkQzm1qsZ0lI7XMou4a9g0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Y29fk7G/XbqBTbdtKyGZ7Wdl864/kO5dasr9B7jncv78ydqYcGEaSrvcJ7wsdfapO3UclrxrFNypaYNpXxkU8kjgu3bWh73oSpQSzX+EC3QKg7GC20ijIbZYrAThaMIyOoaR83O8kWZbC/0NOguPDFUMOQ2ZDl+vK3ov3tr4F4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=RY6z9kKQ; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-51f74fa2a82so29334e87.0
        for <netdev@vger.kernel.org>; Wed, 08 May 2024 11:40:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1715193599; x=1715798399; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PQ9I4ZgOvNPHMd1mVaqCXOzp4qB4tIGn/b7upIZyGwo=;
        b=RY6z9kKQwxLwYRv2NzS1AU+3qPK1yjj++z3Ig2AxRZKj8IaF2DWxaIrKuyGCA4ZkFW
         5NqyEKmHB7PaAyOt9mVIoM45Ok3gInZwzwY0/qWk2CDkonhKE0YqFctAJekOkQVKOODy
         DKTbdXPsmbvQUnOi6ughbbJDhIhCiMi3YsYPnZzT6fQMvcqaiLAzqU7cz2hsx4Y80f27
         AlzXwBfg8cyd+6ys18s/zvC7K5pxOgT24UcifX05OnLGkEf7r0q3uX6qKIYM++I/KQYX
         8algsV9iI0PCUh1dqO5vimWW9/q5qV1/ULKiq8/W5W5Lgq53OwCc8+p0OjXtQx804xey
         6rrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715193599; x=1715798399;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PQ9I4ZgOvNPHMd1mVaqCXOzp4qB4tIGn/b7upIZyGwo=;
        b=sWjKfZuH/hyRXosgQT8ft6vFPELUT1WgwpnImZ4kIveN8OW2GI0MXRvBlJldrzGg7I
         66hIIWRWT41GvCXa0QYb/l+UjMYVNTHhy88Dxl6N5++1Shy84nxVByzo9W4AD246aouU
         qKQaIMmULXvzSZDHfGPPM4x6EeRcvuT/yrmy/yAD2TAoJe9MPcIL9/ifWb//qpwaSLN8
         Uer/SuDNPLAsUeqekEn3p5R2dqzUPRvhvAe67GJLuMfFtxhsJtRdCyeHhuhrFcZG9UQl
         PQDfth9x4RjmcPnmuIuI+vE3W/STt+ydWKKFAU/kZyXf9Ah+gu4LBPvR4TdB0eHNjYY9
         aXLQ==
X-Forwarded-Encrypted: i=1; AJvYcCU9ghnw6bs40e4HOirW8NsoptFInplfzgnoyXiB4UHhdKMPUJKTVLgnemFl8feNS4md1TgouL27loU7kTB0mjceELJ6g807
X-Gm-Message-State: AOJu0YygR9iRkEje/n1lK7fcmjCptuW6kbCzk0qqFBHPlg2ZWmxA3Gtr
	yCmZ0U2wDRkTxZaPOY3S1Q86ZFPyIMUvJrng6yfYTTasMkLg6SeLU7AT+v96+s8=
X-Google-Smtp-Source: AGHT+IFcKJO0kqjUVP3Onb+Gg2SFImiD+z8mGQ3L0TQ4exBwG5dLqQVdwkigSlwdxqTJ8W78ypgZYQ==
X-Received: by 2002:ac2:4e14:0:b0:51e:fb8d:796e with SMTP id 2adb3069b0e04-5217c372db5mr3607513e87.3.1715193598528;
        Wed, 08 May 2024 11:39:58 -0700 (PDT)
Received: from [172.30.204.208] (UNUSED.212-182-62-129.lubman.net.pl. [212.182.62.129])
        by smtp.gmail.com with ESMTPSA id c6-20020a056512324600b0051b0f4e1b0dsm2619915lfr.276.2024.05.08.11.39.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 May 2024 11:39:58 -0700 (PDT)
Message-ID: <0e898bff-6208-44a6-8ad7-1dd5856321c6@linaro.org>
Date: Wed, 8 May 2024 20:39:53 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] arm64: dts: qcom: sa8775p: mark ethernet devices
 as DMA-coherent
To: Sagar Cheluvegowda <quic_scheluve@quicinc.com>,
 Bjorn Andersson <andersson@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
 Andrew Halaney <ahalaney@redhat.com>, Vinod Koul <vkoul@kernel.org>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Bhupesh Sharma <bhupesh.sharma@linaro.org>
Cc: kernel@quicinc.com, linux-arm-msm@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org
References: <20240507-mark_ethernet_devices_dma_coherent-v3-0-dbe70d0fa971@quicinc.com>
 <20240507-mark_ethernet_devices_dma_coherent-v3-1-dbe70d0fa971@quicinc.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20240507-mark_ethernet_devices_dma_coherent-v3-1-dbe70d0fa971@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 5/8/24 03:31, Sagar Cheluvegowda wrote:
> Ethernet devices are cache coherent, mark it as such in the dtsi.
> 
> Fixes: ff499a0fbb23 ("arm64: dts: qcom: sa8775p: add the first 1Gb ethernet interface")
> Fixes: e952348a7cc7 ("arm64: dts: qcom: sa8775p: add a node for EMAC1")
> Signed-off-by: Sagar Cheluvegowda <quic_scheluve@quicinc.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad

