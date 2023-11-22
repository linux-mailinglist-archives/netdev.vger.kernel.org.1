Return-Path: <netdev+bounces-50256-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 905917F516E
	for <lists+netdev@lfdr.de>; Wed, 22 Nov 2023 21:21:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B8EF71C20ACF
	for <lists+netdev@lfdr.de>; Wed, 22 Nov 2023 20:21:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 264D95D917;
	Wed, 22 Nov 2023 20:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="k+h9GJUD"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9582F1B1
	for <netdev@vger.kernel.org>; Wed, 22 Nov 2023 12:21:01 -0800 (PST)
Received: by mail-lf1-x135.google.com with SMTP id 2adb3069b0e04-507e85ebf50so151610e87.1
        for <netdev@vger.kernel.org>; Wed, 22 Nov 2023 12:21:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1700684460; x=1701289260; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ga6DHD8tx1x1pLsmxg1KBcXT7AH9Qf7vXNZRtF9xmNs=;
        b=k+h9GJUDo8wLC+t4ob8PzV8k5NasaEANs6rdKao8S1staFBWuKbjBlNwx5p+Mxqr2e
         +auwayeVXsIVe6Kwmu3jC4J9GC80L8pBUxN5b/XmrWvmjfUsRRVFerm/Y9J1jTaOawl2
         K/zLS2SUbYPc6xSvPPzYQAygCJKkEdf7q58UB3GNhzU/6ata3m8BtugKTn4tgsqilasI
         8NgeETL5LSIbzvKMoHZt9YaOLTTvG44bGZjS1qXwV8aeQ70Xdi4KaapLtPC+x6E5h47W
         53JJcyGMfWjocDieA0u+BG2CTJvnHAD4/6LEAkdPI/gQKo7Tg3CxTO8T8z8eMaXN3LUH
         xn8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700684460; x=1701289260;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ga6DHD8tx1x1pLsmxg1KBcXT7AH9Qf7vXNZRtF9xmNs=;
        b=bb8SODRRGgiiCf2ThsFn2tFoEHKWD0mcHXSMyz+Q7flBE9zO6X1PSSLU45lKYlQZPQ
         pMQCN3MAoQwjcP4jwYxm9fIzxLvuJYLsn5BkapXcewAKmPLt3Tf2aGW2fByqedbAsXR9
         UZPgyy0RQq29dnH+sfWtlEwH0tj+6ZIu0quAPbaWIbVd0N9qXXWFCgOkeJsmfhRTseB3
         Nv6bjMRKkYz4KVWYDWNQc1nECx6SMVguSF8j6s1IHQwL4CS4250ZeONZN33WudK3vgUG
         HDrPc0z1doQIWR906j1CXFU/EPxRThc5UR40I16fyVgZzGQ0KCoZnZdc8dDCvN+lweO/
         3jDg==
X-Gm-Message-State: AOJu0YxB3x7DD1PIztY+jFhVQttf7OHxZZknULBL3L2ia9rmxBLcFKiX
	NktsJ9X9PMIR75VQY1Z/8UKbYQ==
X-Google-Smtp-Source: AGHT+IEc9mJl9mTCVwaSAeiMnvagrqFfsVeSKHne7giqPH5q83K+s9vNjJPuseV4FAYZtneshFP7Mw==
X-Received: by 2002:a05:6512:1256:b0:507:96c7:eb1a with SMTP id fb22-20020a056512125600b0050796c7eb1amr3411303lfb.54.1700684459628;
        Wed, 22 Nov 2023 12:20:59 -0800 (PST)
Received: from [172.30.204.74] (UNUSED.212-182-62-129.lubman.net.pl. [212.182.62.129])
        by smtp.gmail.com with ESMTPSA id d24-20020a056512369800b005091314185asm1952576lfs.285.2023.11.22.12.20.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Nov 2023 12:20:59 -0800 (PST)
Message-ID: <1f643ec4-2f55-4fe3-8d66-a47241c25619@linaro.org>
Date: Wed, 22 Nov 2023 21:20:56 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 7/9] clk: qcom: add NSS clock Controller driver for
 Qualcomm IPQ5332
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
 <20231121-ipq5332-nsscc-v2-7-a7ff61beab72@quicinc.com>
From: Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20231121-ipq5332-nsscc-v2-7-a7ff61beab72@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Level: *



On 11/21/23 15:30, Kathiravan Thirumoorthy wrote:
> Add Networking Sub System Clock Controller(NSSCC) driver for Qualcomm
> IPQ5332 based devices.
> 
> Signed-off-by: Kathiravan Thirumoorthy <quic_kathirav@quicinc.com>
> ---
LGTM except a single nit

> +MODULE_DESCRIPTION("QTI NSS_CC MIAMI Driver");

Konrad

