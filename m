Return-Path: <netdev+bounces-94708-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A6048C0490
	for <lists+netdev@lfdr.de>; Wed,  8 May 2024 20:45:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CA96F287B95
	for <lists+netdev@lfdr.de>; Wed,  8 May 2024 18:45:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5946D85626;
	Wed,  8 May 2024 18:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hLaVFox/"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76D297C6CE
	for <netdev@vger.kernel.org>; Wed,  8 May 2024 18:45:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715193918; cv=none; b=VgX8MEV/YyBgBwM0UMycw3QmATjiVZvcW3RWBAIFtGkQHZp0+I2R3+dD39XamXCz5Q12NsKirIz5UWkAAycRSdgt6yDiGbRL37i8pHAwGtfjd1f23LvGDLJLQMHaQuAhZMT8bwOJQbyyz5qLTlNJThl3FRbR6DJ4Us7iph7RhCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715193918; c=relaxed/simple;
	bh=ajK8fwDEWGgksD0g4NneQiANiInlFvagm8QWZ2BtHyk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qoTi8t/Q0UsB4+ycyInxswlBgBziuB3ZaRxHKCAz0XWwHupWbloGlKTp6eUVybEDE84gvV76Awli+kdPtc6IiHTPNM67YsE9iISHsSKhIvHgDFR/TBJ8Qc0xsg+cAJwgph5SUCqk+bJqAwlg2Wdinv4c9gNjyMQOx+ckvG2gJ14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=hLaVFox/; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-51f300b318cso5509071e87.3
        for <netdev@vger.kernel.org>; Wed, 08 May 2024 11:45:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1715193915; x=1715798715; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=L/sl7CVm2REW89uZuY8Yv8EOqxKrMx/lL2HpHKt7Na8=;
        b=hLaVFox/jR4GeVAhXE3hXCEknwd7vXPgbILZNhgd2H0Fi3rly7ujaidbSG40JCBh+5
         gVduJffL7hNkCVr0n0Ihc7ZrFvy4yzI/PpjmNA7XkjiKvzZ4nJTMM0Xwz9jcqMAjaB2f
         NWUTqHiFIsH9t+OQ/z0WnWBcTIqZLoA5LexAO1NB1/rsJIIykjWF5kPZHOym626mRu4H
         9Fh2VquSJIbNKp12Uu7ckHKV996dgpMv/iP/THIvkBSANUrSSw30T3+LZYtYgd2fK9VQ
         rI+fTSl4tiA38vEkjsJkpztXx+eGt63NCM9mMRyJY7NxPCjtuyEJTMAEKvwGi1KFKnO/
         FdJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715193915; x=1715798715;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=L/sl7CVm2REW89uZuY8Yv8EOqxKrMx/lL2HpHKt7Na8=;
        b=sMqQjI7eabHJ4ZVyguv6iO6eLsBjDcIcgq1t8aj1iVObLLhYNsy9T5As5uhcB1wnhm
         X5Sk292AWNb5yP0LPlYW7to367xHrX36jgf3RiHIBQT26UTY+0GTMH49SVQqi28JCjAw
         yGXFP115lHj/seWvja5MhmEDmk6yGr/ObTMc2oOk5VP6lCzoMVcy5efFrXLpM0aHLZ56
         JOr66PBcekOchQmE41JNUPUZbH4a93sBdidDIwIy1EpUfLHhKYMRCDV8GTl1/Dju1nNA
         crY2y0Sm7wa+1hvJWmOeHttxYqPvirDVICD3KMPS/DxxZ7LwltvRxgax0zwMn2/SjZ/0
         ozPQ==
X-Forwarded-Encrypted: i=1; AJvYcCWUA8SvGJVQB7dOc8ClGLbNe008We0A2EKKk3D++/awyUlPRsz9NiraM87JWQIcQWz5slwiPZZWLjBRdGczJkHWo9yjoeSt
X-Gm-Message-State: AOJu0YyPDAm4GRMR2Z/jqj8QohxVjJnVvN+ok1L0MX5Hq4aypx1gQgYR
	s4C6ktfXNqR+akchbnkyRTn6Xy0/xXvbFrmrWB51qynMsjsAF8zdH1/BApyEayg=
X-Google-Smtp-Source: AGHT+IE10Er1A/mCrosxAFnAYPReP2NcUb3AzPgcOh2RiJkJ3CG8BZvnwb4a8smEsiNSsK0a2O5UYQ==
X-Received: by 2002:ac2:522e:0:b0:51b:de39:3826 with SMTP id 2adb3069b0e04-5217ce46c24mr1930208e87.65.1715193903577;
        Wed, 08 May 2024 11:45:03 -0700 (PDT)
Received: from [172.30.204.208] (UNUSED.212-182-62-129.lubman.net.pl. [212.182.62.129])
        by smtp.gmail.com with ESMTPSA id g4-20020a056512118400b00516dc765e00sm2605299lfr.7.2024.05.08.11.45.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 May 2024 11:45:03 -0700 (PDT)
Message-ID: <1a28f062-89d6-48bc-b74f-2ad480f58ff9@linaro.org>
Date: Wed, 8 May 2024 20:45:01 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/2] Mark Ethernet devices on sa8775p as DMA-coherent
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
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20240507-mark_ethernet_devices_dma_coherent-v3-0-dbe70d0fa971@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 5/8/24 03:30, Sagar Cheluvegowda wrote:
> To: Bjorn Andersson <andersson@kernel.org>
> To: Konrad Dybcio <konrad.dybcio@linaro.org>
> To: Rob Herring <robh@kernel.org>
> To: Krzysztof Kozlowski <krzk+dt@kernel.org>
> To: Conor Dooley <conor+dt@kernel.org>
> To: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> To: Andrew Halaney <ahalaney@redhat.com>
> To: Vinod Koul <vkoul@kernel.org>
> To: David S. Miller <davem@davemloft.net>
> To: Eric Dumazet <edumazet@google.com>
> To: Jakub Kicinski <kuba@kernel.org>
> To: Paolo Abeni <pabeni@redhat.com>
> To: Bhupesh Sharma <bhupesh.sharma@linaro.org>
> Cc: kernel@quicinc.com
> Cc: linux-arm-msm@vger.kernel.org
> Cc: devicetree@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Cc: netdev@vger.kernel.org
> 
> Patch 1 :- This patch marks Ethernet devices on Sa8775p as DMA-coherent
> as both the devices are cache coherent.
> 
> Patch 2 :- Update the schema of qcom,ethqos to allow specifying Ethernet
> devices as "dma-coherent".
Per-patch descriptions like this are usually redundant, unless you're
reworking something complex and non-obvious. These things above, we
can infer from the commit titles alone.

Generally, when there's not much to say in the cover letter, you can just
give a very brief summary like "This series fixes X on Y".

Not a huge deal though.

Konrad

