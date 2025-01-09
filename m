Return-Path: <netdev+bounces-156513-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 78832A06BC3
	for <lists+netdev@lfdr.de>; Thu,  9 Jan 2025 04:01:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8B7137A1554
	for <lists+netdev@lfdr.de>; Thu,  9 Jan 2025 03:01:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25F00127E18;
	Thu,  9 Jan 2025 03:01:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ieee.org header.i=@ieee.org header.b="eycMJDfP"
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f50.google.com (mail-io1-f50.google.com [209.85.166.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ADC91F94C
	for <netdev@vger.kernel.org>; Thu,  9 Jan 2025 03:01:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736391679; cv=none; b=Xf9eiz6K38lTKU4cj8XoCggrzGo4dkf4EPQvyZ4BuuvgtxGyTHqUM164ejc1VZ6YYc40ML+4q8UimVj4qw+Yo/fxCgOXcsUprEw2YTM5XGP2eJ9CsgqYo7KIausAbxQGgVUWu+xAlcFu0m9RNzrEngQNHH0OhKIr7YU+Ehso4R8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736391679; c=relaxed/simple;
	bh=styal6a10fBSjAdXfS/03k5/+K6pkiyNCbLjLqDpKJI=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=KCDDH4qmoe9PANn4X0/2HLyh9ohWphaOFtJpdAXid+picHeFRithKdtjhT/TW1i3S4AZyZhhErS+QZr6Of1Ve4wPS3TkhxQ1NwTjStRgv0bOI1wbG5acxEjdHJnre+jrzRITV3YuDhMkAYG+A4sawkjMj308KUGeLelMoTyRBBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ieee.org; spf=pass smtp.mailfrom=ieee.org; dkim=pass (1024-bit key) header.d=ieee.org header.i=@ieee.org header.b=eycMJDfP; arc=none smtp.client-ip=209.85.166.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ieee.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ieee.org
Received: by mail-io1-f50.google.com with SMTP id ca18e2360f4ac-84a012f7232so51373539f.0
        for <netdev@vger.kernel.org>; Wed, 08 Jan 2025 19:01:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ieee.org; s=google; t=1736391676; x=1736996476; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=chLFunAF/6a+8neQ/O4A300WGPV8Q4UnrjtHUfVgGHY=;
        b=eycMJDfP6/cPe5uB6nhiFej8YK+SSUMNnoqiGbGMWBqnP4MjvMLqe/eDN9U1ouJeDh
         dMZXCvyAoOrmEk13KXmjLxNxqrxAhTxcAihykCE3YdMRqPoS8JHJI/6MdMpcgXJyKZig
         cT/IJOduplB9DOqEjqlyid/Kgm6nJ3ZKMbJZY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736391676; x=1736996476;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=chLFunAF/6a+8neQ/O4A300WGPV8Q4UnrjtHUfVgGHY=;
        b=Jbg5EruBMKhClcAmwj1PYQodbbC15zqdlv2irhAM6b5LWjj6cy/Q7WSEa8rifao2oP
         6eN0ZmSXddAX4OMpzoi47Wp8a1p4I7M3CkUtq1gVc8o2d+j/X0d2H7kF3vjFrNGzmgoG
         b9V7Fwas6DncAzQQvnLyrFHshLq91mTJAT66fr0jkgtWycFLV1/IW3CuYdhefb6QdRxN
         mnLwmkc/RKBQd0iq3yx3HFFyQObiG6BI9jWdczTFDnf8yFIFKuYZmyvNGa+ofFOqjVxU
         GzndULNZJK/2bGB5nn7rAptFvnZ74lGBVxbcb1INzY0uiT6DHTWRWcN7iSTFs6tuha37
         BN2w==
X-Forwarded-Encrypted: i=1; AJvYcCWAO0tVjuoMYz8ER0BtWtEfGXQsloDhh/SBQvUgcXUnHUZjqndCkAyPww1519kPqTpIsEmRQaE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8NXBOtY+yB+dT2MUeKuKjmaBhD6kAVFlc/6kMD6WUqTSxmVTg
	X1BbS4JJfPhwkzVYECeBsHy1yFYWlcxVMmQ6saQ9lhIBlF/a0HM1HRReYiew+Jms4qH76OeXZ6O
	0Yw==
X-Gm-Gg: ASbGncutfZpGyX6DsKwL4Frn0aNPBcLivjP6C27C3MR1D+iP8xlRAlkN2+l7/wpnSTV
	YT1XRA0uUdyebcoATZy+PNlLAiGC1QBJKRmHPqIlulEXH11TUmRgBANncAxui0JHRY7RsRm4JIg
	b5NowH+TmMff4s+goPT4m8mi9Svnt46VyhK5w3m/qRzeJzRQkKDvFQ10cAznxBbO9PWZE/fr+Oa
	fF9EGnUP6C5xf4hyumlZkUmkbvRq4SKc94bjTeIE5Ife171/LfcM3zuZCywU12yzbDz0CnqBEb+
	9xzMCLQviq33MwGZpDVUnj8n
X-Google-Smtp-Source: AGHT+IEmu7TPSTXMcXWqBPqzgGP992fYz6d0NlpSB4pe0TArY/5e/MlCpviUh6kU6qxRmMV/w50qsQ==
X-Received: by 2002:a05:6e02:1a8a:b0:3cd:d14c:be69 with SMTP id e9e14a558f8ab-3ce4b212f1dmr5019645ab.11.1736391676216;
        Wed, 08 Jan 2025 19:01:16 -0800 (PST)
Received: from [10.211.55.5] (c-73-228-159-35.hsd1.mn.comcast.net. [73.228.159.35])
        by smtp.googlemail.com with ESMTPSA id e9e14a558f8ab-3ce4adbc838sm1149235ab.30.2025.01.08.19.01.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Jan 2025 19:01:14 -0800 (PST)
Message-ID: <9b7a7b9a-7f70-4ba2-b948-ffa1a7ae8f53@ieee.org>
Date: Wed, 8 Jan 2025 21:01:12 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] dt-bindings: net: qcom,ipa: Use recommended MBN
 firmware format in DTS example
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Alex Elder <elder@kernel.org>,
 linux-arm-msm@vger.kernel.org, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250108120242.156201-1-krzysztof.kozlowski@linaro.org>
Content-Language: en-US
From: Alex Elder <elder@ieee.org>
In-Reply-To: <20250108120242.156201-1-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/8/25 6:02 AM, Krzysztof Kozlowski wrote:
> All Qualcomm firmwares uploaded to linux-firmware are in MBN format,
> instead of split MDT.  No functional changes, just correct the DTS
> example so people will not rely on unaccepted files.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Looks good.  I don't see SC7180 modem firmware there right
now but this seems like a good change.  Thanks Krzysztof.

Reviewed-by: Alex Elder <elder@kernel.org>

> ---
>   Documentation/devicetree/bindings/net/qcom,ipa.yaml | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/net/qcom,ipa.yaml b/Documentation/devicetree/bindings/net/qcom,ipa.yaml
> index 53cae71d9957..1a46d80a66e8 100644
> --- a/Documentation/devicetree/bindings/net/qcom,ipa.yaml
> +++ b/Documentation/devicetree/bindings/net/qcom,ipa.yaml
> @@ -239,7 +239,7 @@ examples:
>   
>                   qcom,gsi-loader = "self";
>                   memory-region = <&ipa_fw_mem>;
> -                firmware-name = "qcom/sc7180-trogdor/modem/modem.mdt";
> +                firmware-name = "qcom/sc7180-trogdor/modem/modem.mbn";
>   
>                   iommus = <&apps_smmu 0x440 0x0>,
>                            <&apps_smmu 0x442 0x0>;


