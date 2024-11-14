Return-Path: <netdev+bounces-144767-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D8AF9C8661
	for <lists+netdev@lfdr.de>; Thu, 14 Nov 2024 10:44:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 90C1DB2214E
	for <lists+netdev@lfdr.de>; Thu, 14 Nov 2024 09:43:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA45B1F7074;
	Thu, 14 Nov 2024 09:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dHKPGUux"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BECC1E7C2D;
	Thu, 14 Nov 2024 09:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731577400; cv=none; b=f7Qg5j3Hwg2Omd2hEb5HLhFbXLAxg8Vxx6VSbrSMEXKE1aAajo6vZST5v3prs02oPWdDFIpSsJgsL9GRCpmGQ8Z36MsOJHLGxrnF5GW4e3dAfBb6gzdt9KDfZoptgSKO5l7fjEZXk+pq6qv1kXvxl44kWxek51b5NWVuGeQYt7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731577400; c=relaxed/simple;
	bh=25AUdCDFztM/MxjBrIsJOd7NjN+c7svZzT3gV+41nSQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Snlx5Ldbs4T4mDiKFpt/R5wIqGcGGkKdMlXPTUwEiHVwRJkKXEKloEQn0N8cFF6hDfyYrhJj1wW8bP0X8xsCiQskshyMrWU96qlbUHsO+b64JehPusvydC1PQMLL5QV0f/XB0lVWMKvuazmHSbOC5n78Z/kob6YD/tfAu1MwSVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dHKPGUux; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-71e79f73aaeso270269b3a.3;
        Thu, 14 Nov 2024 01:43:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731577398; x=1732182198; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7E3oRv+rq/XKtcZoaXZsJTQg3amz2zyCTxOxkN0m2BA=;
        b=dHKPGUux1yZSNL13UN2Oug0+aum7KO2Sbq3dUdUlrY0clb57pDomvyQNxpYXTnheXQ
         bG6Ybq9YPEg63YmyvHkyTnZjpBIMR5OJkda4tYYu7Tt7iyQsIrZD4K/u9pLkWTde/roo
         guWDQ6G3xXXsJHPoUa+JbILeVsO8WSrzHMFDLuDikwPFtsk/jbjlnyzc+roChHay/woE
         vKTTmEXGB6ajZ85nWKlWiJEclJ0ySrQzbJVl0oumB8L4wQMyqeCW62RHdwTz8IXHcZGj
         9ST61KlWEK9RI/tpHGaYQm6d/UF7ZAeXU8nMUwa8dyjeggn2Zh+9qw68spp1kZxqoWEx
         2T7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731577398; x=1732182198;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7E3oRv+rq/XKtcZoaXZsJTQg3amz2zyCTxOxkN0m2BA=;
        b=EJGjEWkOWIkKT5QytCZY8aVNLTa1a6/Yfp0uwCw7b1yj3xajNyGNPGUcMJ7EZkR/86
         W99X7XtFUZ8wfNGkcAQ1FfdVFaiXpATyyRrC8TEpRIWrg8jaYp6NTqgwoUTGRUSD7BRb
         zZR7TzVUda+Ff3DCFHrB0ylKKdzegKv1DUCuyRFDyrn0JIPIPsecU4HtOM5wVULL/to3
         r4L8g2y6eNOCLx8pBhse49obDR/rTKFOpap3bKf0oVbnaZIOcMAG6fAkDpie/9Qo7yV3
         YrHNHBNhAe3OKTQ4v67aEkYoMuFzeJjzM4IgFocfk3nnbioSkeiSGBkZ5cWo7GGPWmE3
         /N7w==
X-Forwarded-Encrypted: i=1; AJvYcCUEpQ4qegtsp47+4dLNveavvyTl9XlAUl84I1M3kfttH8Ht1Jt0T0oR4QcN3CFOtDuEHmfZxw7X@vger.kernel.org, AJvYcCUV2x4PjXxI5L+S09fVw963Ot5VarP1JK+f7TA5V6/xYHvr1G3f6btHGcV8yJSkzzhlD0ywGxUST1U8@vger.kernel.org, AJvYcCXNr4vtGw90TCDYL9QQ8Y6ZjXSbJ0lsNpva1350HGIHx3X58nQbNb8563ABeDjMVX5XqrwRLHP0+k0yegtm@vger.kernel.org
X-Gm-Message-State: AOJu0YwdarHLxtQ0zxmJianSyxh+NZ5msS0ZTqCAO5K5YAGcr1f51Gdz
	Q59T1JWLshu/4H6/RiX1AtHQV8RSdCwOukF2MKUJ8vM+iabNMZDE
X-Google-Smtp-Source: AGHT+IE7N5I7GpMECo0it1xEKMgqYnL8RbOemjcjR8CajkVg4l/czbLMGpNGruEWzRMOSH4KompvSQ==
X-Received: by 2002:a17:90b:3ec5:b0:2e9:5f95:54c1 with SMTP id 98e67ed59e1d1-2e9b173c441mr33338891a91.17.1731577398096;
        Thu, 14 Nov 2024 01:43:18 -0800 (PST)
Received: from [192.168.0.101] (60-250-192-107.hinet-ip.hinet.net. [60.250.192.107])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2ea06f9c51esm783484a91.39.2024.11.14.01.43.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Nov 2024 01:43:17 -0800 (PST)
Message-ID: <bbc212a7-ae42-461a-b0a9-509838053ab2@gmail.com>
Date: Thu, 14 Nov 2024 17:43:14 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] dt-bindings: net: nuvoton: Add schema for MA35
 family GMAC
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: krzk+dt@kernel.org, mcoquelin.stm32@gmail.com, davem@davemloft.net,
 conor+dt@kernel.org, pabeni@redhat.com, richardcochran@gmail.com,
 devicetree@vger.kernel.org, joabreu@synopsys.com, edumazet@google.com,
 linux-kernel@vger.kernel.org, kuba@kernel.org, schung@nuvoton.com,
 yclu4@nuvoton.com, ychuang3@nuvoton.com,
 linux-stm32@st-md-mailman.stormreply.com, openbmc@lists.ozlabs.org,
 linux-arm-kernel@lists.infradead.org, alexandre.torgue@foss.st.com,
 netdev@vger.kernel.org, andrew+netdev@lunn.ch
References: <20241113051857.12732-1-a0987203069@gmail.com>
 <20241113051857.12732-2-a0987203069@gmail.com>
 <173147854152.3007386.10475661912425454611.robh@kernel.org>
Content-Language: en-US
From: Joey Lu <a0987203069@gmail.com>
In-Reply-To: <173147854152.3007386.10475661912425454611.robh@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Dear Rob,

Thank you for your reply.

On 11/13/24 14:15, Rob Herring (Arm) wrote:
> On Wed, 13 Nov 2024 13:18:55 +0800, Joey Lu wrote:
>> Create initial schema for Nuvoton MA35 family Gigabit MAC.
>>
>> Signed-off-by: Joey Lu <a0987203069@gmail.com>
>> ---
>>   .../bindings/net/nuvoton,ma35d1-dwmac.yaml    | 170 ++++++++++++++++++
>>   1 file changed, 170 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/net/nuvoton,ma35d1-dwmac.yaml
>>
> My bot found errors running 'make dt_binding_check' on your patch:
>
> yamllint warnings/errors:
>
> dtschema/dtc warnings/errors:
> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/net/nuvoton,ma35d1-dwmac.yaml: ignoring, error in schema: properties: compatible
> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/net/nuvoton,ma35d1-dwmac.yaml: properties:compatible: [{'items': [{'enum': ['nuvoton,ma35d1-dwmac']}, {'const': 'snps,dwmac-3.70a'}]}] is not of type 'object', 'boolean'
> 	from schema $id: http://json-schema.org/draft-07/schema#
> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/net/nuvoton,ma35d1-dwmac.yaml: properties:compatible: [{'items': [{'enum': ['nuvoton,ma35d1-dwmac']}, {'const': 'snps,dwmac-3.70a'}]}] is not of type 'object', 'boolean'
> 	from schema $id: http://devicetree.org/meta-schemas/keywords.yaml#
> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/net/nuvoton,ma35d1-dwmac.yaml: properties:clock-names: 'oneOf' conditional failed, one must be fixed:
> 	[{'const': 'stmmaceth'}, {'const': 'ptp_ref'}] is too long
> 	[{'const': 'stmmaceth'}, {'const': 'ptp_ref'}] is too short
> 	False schema does not allow 2
> 	1 was expected
> 	hint: "minItems" is only needed if less than the "items" list length
> 	from schema $id: http://devicetree.org/meta-schemas/items.yaml#
> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/net/nuvoton,ma35d1-dwmac.yaml: properties:clocks: 'oneOf' conditional failed, one must be fixed:
> 	[{'description': 'MAC clock'}, {'description': 'PTP clock'}] is too long
> 	[{'description': 'MAC clock'}, {'description': 'PTP clock'}] is too short
> 	False schema does not allow 2
> 	1 was expected
> 	hint: "minItems" is only needed if less than the "items" list length
> 	from schema $id: http://devicetree.org/meta-schemas/items.yaml#
> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/net/nuvoton,ma35d1-dwmac.yaml: 'oneOf' conditional failed, one must be fixed:
> 	'unevaluatedProperties' is a required property
> 	'additionalProperties' is a required property
> 	hint: Either unevaluatedProperties or additionalProperties must be present
> 	from schema $id: http://devicetree.org/meta-schemas/core.yaml#
> Documentation/devicetree/bindings/net/nuvoton,ma35d1-dwmac.example.dtb: /example-0/ethernet@40120000: failed to match any schema with compatible: ['nuvoton,ma35d1-dwmac']
> Documentation/devicetree/bindings/net/nuvoton,ma35d1-dwmac.example.dtb: /example-1/ethernet@40130000: failed to match any schema with compatible: ['nuvoton,ma35d1-dwmac']
>
> doc reference errors (make refcheckdocs):
>
> See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20241113051857.12732-2-a0987203069@gmail.com
>
> The base for the series is generally the latest rc1. A different dependency
> should be noted in *this* patch.
>
> If you already ran 'make dt_binding_check' and didn't see the above
> error(s), then make sure 'yamllint' is installed and dt-schema is up to
> date:
>
> pip3 install dtschema --upgrade
>
> Please check and re-submit after running the above command yourself. Note
> that DT_SCHEMA_FILES can be set to your schema file to speed up checking
> your schema. However, it must be unset to test all examples with your schema.
>
These warnings/errors will be fixed in next patch.

Thanks!

BR,

Joey


