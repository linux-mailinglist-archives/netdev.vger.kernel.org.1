Return-Path: <netdev+bounces-193122-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A5B1AC2927
	for <lists+netdev@lfdr.de>; Fri, 23 May 2025 19:59:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 790631C04273
	for <lists+netdev@lfdr.de>; Fri, 23 May 2025 17:59:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF4B6298C30;
	Fri, 23 May 2025 17:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ieee.org header.i=@ieee.org header.b="C8N9LT75"
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f181.google.com (mail-il1-f181.google.com [209.85.166.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A64F023956A
	for <netdev@vger.kernel.org>; Fri, 23 May 2025 17:59:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748023169; cv=none; b=EzvV3+/N+5kCNJxQJ1WrEzdMhGe1vbqt+ST3hWR3KyvyrdGCR5f7lywgrD5LeHZQSLLZ4doeySETn6FZlWJkpsz1NMo4n8xTidfcIs6UDgr2yCkglY5HteKkrxo5Xd/BbUZbIJTztE06oAPHL+PU8nxVNOHmV74OIb7sACxApwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748023169; c=relaxed/simple;
	bh=xLtmQ0TWKB+NkLXhdkRYKl8da1Hyt1mfZQezqD35yEs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Cq7YLCmJoodg0dWtrqcuCHUv48OHcc1OfgYnKNCo6PjO+WISnlufglbOYbDQDbhzDpYJeJ0xaq3IrocEbFKWnL+Wl5HirYeZI2AZTJBQHZkaxojw4JCrZnCZ2jCo4yt39A5ZmJCg/y0cNvLd/eqPwfteyabsyinVs37TnXUWn/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ieee.org; spf=pass smtp.mailfrom=ieee.org; dkim=pass (1024-bit key) header.d=ieee.org header.i=@ieee.org header.b=C8N9LT75; arc=none smtp.client-ip=209.85.166.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ieee.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ieee.org
Received: by mail-il1-f181.google.com with SMTP id e9e14a558f8ab-3dc978b0493so1446375ab.0
        for <netdev@vger.kernel.org>; Fri, 23 May 2025 10:59:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ieee.org; s=google; t=1748023167; x=1748627967; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SGtEFmZ2rVp0Bhcu1O5oY42icjo5BCFEnZcJ+QVCi5k=;
        b=C8N9LT75+cLuq9p0NKlfwoqcK2L0qV4LlVGpw4e+WxnSPyUezwE8GlWCZgm9bqcXTM
         ckisH+OgjZMQcmh1GS3A3piIuoyHnt5QWCQNRQwnh/BPWTReT8wDzXK0rXaHqX5u8hhN
         2N3x/NvQKLYWfQxd/km41ADGnFffl8teWi0l8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748023167; x=1748627967;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SGtEFmZ2rVp0Bhcu1O5oY42icjo5BCFEnZcJ+QVCi5k=;
        b=kJOZzaR7HA8Y1ESLsPtOLcq3h+BYixvAsBz2ybpf7LBciixHIqU6RiZxfd4ZYxG7d2
         GUEvlraSDKYRqfoBaZVjb1pWSGOshwz+NvxYDd/A14HbV3pSfUW9Yt30Svkuw7L3lfiv
         TLobNJDQI0p5PhMyQAKTczoUKPFLnSf5Jog9nWXe4/JmPjgXMmlvP0nvfg98pCAo0p+H
         AkrAsWXEpXy2AGK0nY8hvyz1pK9i6tFUpsAameqWqjmQHT/jQVYNN3HXpCFJHkG5yMzZ
         UqnGXM85QtJXgvqnv6bSws4B7+OeF3SaV+RwpEmpwwGbk53RCJTmylupTGIlbJ9KaXrV
         fh0Q==
X-Forwarded-Encrypted: i=1; AJvYcCUhbyLSKQ33YdmNxa4hvLIAd8K7FZiIE/VSxLPojQcfbOfGepf64XjVTVeRs3jIoHsVwCQarxM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxBQYz1XQI5EAkuoZeSqZd6ElwXkl7ljZKPCbscv1hVqPwduKYZ
	A4wQVYyb948/EuBaGxHzI1rlhjECfPAG92lsMZ511ZeVKX5p/6sTxx6wWgNauVQ3cw==
X-Gm-Gg: ASbGnctdlFxQPhTw06I+UALxuLOQHg4WfNxE0qbO6c5nKS3W+HbZOfZGvZ3tGY+l1Lk
	/d66Amw3kmgx+fwSoHFfy0g5SPpysjswAtoQ9RLQFQvp+rGi81yesAkUV3bOfev4/JRv37YvXc8
	R+1e0Pcs6tEbYXoVa5hl/0pz1H7A6w5pCAlgftLn1mlWCwaBEO445VUuLDMASbNaxieZDJXHVxd
	vlD9HzL5gXPFy2D/BtbSLd2mhY6t4seK3dlrIVuWj/PxRw+bzEPI2h7I/86UMd2YFoh7M4rVKk7
	UT3kwq8TI5H5gfQXEfmqQ38EF17aAGWfSSE2MAV0HmaOyTZnIQ0io76ZpHoyadolW5CrfYBV6N+
	OY2mwMH2RljtKuiIM0z6q
X-Google-Smtp-Source: AGHT+IEpb1IcvOHrK/fzMraPZSR5ZnUsdHuhgqtnR1Igx7QRkPEVOT3iAbQKQTTUDJaVKlOxTZqGag==
X-Received: by 2002:a05:6e02:3308:b0:3d8:2023:d057 with SMTP id e9e14a558f8ab-3dc9b6cc069mr1052295ab.11.1748023166709;
        Fri, 23 May 2025 10:59:26 -0700 (PDT)
Received: from [172.22.22.28] (c-73-228-159-35.hsd1.mn.comcast.net. [73.228.159.35])
        by smtp.googlemail.com with ESMTPSA id e9e14a558f8ab-3dc7f126188sm18218695ab.65.2025.05.23.10.59.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 May 2025 10:59:26 -0700 (PDT)
Message-ID: <7707b574-6fcf-487d-909a-d24874f9d686@ieee.org>
Date: Fri, 23 May 2025 12:59:24 -0500
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] dt-bindings: sram: qcom,imem: Allow modem-tables
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
 <20250523-topic-ipa_imem-v1-1-b5d536291c7f@oss.qualcomm.com>
Content-Language: en-US
From: Alex Elder <elder@ieee.org>
In-Reply-To: <20250523-topic-ipa_imem-v1-1-b5d536291c7f@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/22/25 6:08 PM, Konrad Dybcio wrote:
> From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> 
> The IP Accelerator hardware/firmware owns a sizeable region within the
> IMEM, ominously named 'modem-tables', presumably having to do with some
> internal IPA-modem specifics.
> 
> It's not actually accessed by the OS, although we have to IOMMU-map it
> with the IPA device, so that presumably the firmware can act upon it.
> 
> Allow it as a subnode of IMEM.
> 
> Signed-off-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

So this will just show up as a subnode of an sram@... node,
the way "qcom,pil-reloc-info" does.  This is great.

Is it called "modem-tables" in internal documentation?  Or
did you choose this ominous name?

Reviewed-by: Alex Elder <elder@riscstar.com>

> ---
>   Documentation/devicetree/bindings/sram/qcom,imem.yaml | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/sram/qcom,imem.yaml b/Documentation/devicetree/bindings/sram/qcom,imem.yaml
> index 2711f90d9664b70fcd1e2f7e2dfd3386ed5c1952..7c882819222dc04190db357ac6f9a3a35137cc9e 100644
> --- a/Documentation/devicetree/bindings/sram/qcom,imem.yaml
> +++ b/Documentation/devicetree/bindings/sram/qcom,imem.yaml
> @@ -51,6 +51,9 @@ properties:
>       $ref: /schemas/power/reset/syscon-reboot-mode.yaml#
>   
>   patternProperties:
> +  "^modem-tables@[0-9a-f]+$":
> +    description: Region reserved for the IP Accelerator
> +
>     "^pil-reloc@[0-9a-f]+$":
>       $ref: /schemas/remoteproc/qcom,pil-info.yaml#
>       description: Peripheral image loader relocation region
> 


