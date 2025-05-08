Return-Path: <netdev+bounces-188904-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7283DAAF4B3
	for <lists+netdev@lfdr.de>; Thu,  8 May 2025 09:32:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 42C629C0A11
	for <lists+netdev@lfdr.de>; Thu,  8 May 2025 07:32:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 766B3220F22;
	Thu,  8 May 2025 07:32:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Sw6L/ZpE"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFDF621D596
	for <netdev@vger.kernel.org>; Thu,  8 May 2025 07:32:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746689567; cv=none; b=D0+NlsUpcI3vVcROjphFV4AtYTetJsajmpniF/RsArTZRQN38U6a0P6Ee1bkJDmI9cvPUcZD1QXajG4OMhjhKu3L5obfehnRfc/6cxWA5P77GF2fJD1LRRPQvPbZybDSOeEY1P7kDQCWBT6c01Y9cUpnVkr3U8yKYYDgWk+59TQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746689567; c=relaxed/simple;
	bh=eJRhdf3y9fhrnSs+Zl4amR5N1JU/O4meIvkPsi6N5AI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VQHTnLfi/BjUs0Z2SCLPy7hMhCtFlz4bHIFOq3A8SvzOM/pJaS7shjHZfYNh+2pcb1aTOBazbpPuFC3EoQC2HtpStaYeqsY4KvibLW77OSo8Bi0K07ZQA4kGDowdbpgvgLxvO6K4iM4TVF5h9sOkilKXkS3juse9EDMa0DoI4Do=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Sw6L/ZpE; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-43d4ff56136so1002145e9.3
        for <netdev@vger.kernel.org>; Thu, 08 May 2025 00:32:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1746689563; x=1747294363; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=HoRg830eZYrOz+RPuJ0T7jN6cyXedEMpV65ao6N00bc=;
        b=Sw6L/ZpExEGp+BIFtlLmcD5QPT3atIIi+eJ+yKmMHoNsgg2bWoFyguIwZwlxrMCwzr
         FvsDMrVi5Nj2x9ZTh3zCD7njwyDlBQh/WXaYDR5xeBN97cmWPcljp0/gNIuejZwL2bsH
         OMOnjOCydyD68fqCJRKj1tN4nlc1EMUilOz8N1RC6ZV5n8jLGABOygXvb7rA5TWeemsW
         edEnvE/DwIuy0xFK290gTjRaL8qXJbhVSZ4Mawu27OrbeO+SBuBz0yEJCJFbJVTkHSjY
         Q9q4424Tbckg+kgKRhmGRdJvaLUsSs0+bkFedueGABXdAKxM4Y5v+9bsKGHwEVPBOMUt
         Vg0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746689563; x=1747294363;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HoRg830eZYrOz+RPuJ0T7jN6cyXedEMpV65ao6N00bc=;
        b=WhWeugeByxwyuoWup3k0oyuEHO4X3F465reZgw7ZeVjfNNy6HVLDfy4APwO9WO/a1S
         DTEY48putWdgFuQfrO+yLhGq9bha9tl+vYX0sXRjDYSewYaDp4fIGcVnOmoaUt1fszeI
         5QAycs9vJM/N5qGJqxIGfQvWx1rCunfUrxZt2/JE3xtwsNkIApHL/BnjW0AM+nMA5oos
         /LqpH0542F2fLe+Z7JMtFzh3kMHe76iezXpIgC8iHWSejgf1H69SpT6sn21QcQ+6OCdh
         +/ZOfeDxpqidAo/xJV1xBXGZ+F2Rkb1W0VrUF+ArcSVzznT3NIhc1IPNH5rpphrWSAO2
         i+PA==
X-Forwarded-Encrypted: i=1; AJvYcCV++HizH6KJ61HLHU89ERK/YMzVgz7Ity19/dYi1frlCoxS6ythtquPckjlFtY9JSOtv6g4dmE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxnD1NGh8lGPDDANgs+rMyMhh6pPC9EwIQSx6pLeeby7CGnsbkW
	hK+C+EmARI0BOipWib/RI/1a8cYzc547aci6Hdw85t6ERhtIbMLNJcXa4+aiLQE=
X-Gm-Gg: ASbGncucJIn5w5gA1rgVS+Oj+Ro8emzr6f35/saKjNAqLFIlgpEJyAY9eiysT18DWJE
	NkxifLNSdVx3CpyF8mdqFdarWqR3vUqCVlP9drClV7/xUefgoWkCBEIfN9VnKWvVV5K9iESXJfy
	UedTGMWj49psu1fRpq7+ykyIYPFSGbk4QrQlwTJSVlRv5x4ZWoTxoEXP6loWNxnP+NM23MLoMUS
	jNpxgJNkGh8B+OfboUot7U7p2bRgfuTa6jZyfLA1lWsoRLqA8EpIHBFR/CHgPz57wDH1Ky01oIG
	SMzV7DuiCqytjGPk7tHzwvypvj5PdHQaGDitEytyYICay/1LEjYgT5qbUuQ=
X-Google-Smtp-Source: AGHT+IEJFJSCXhWpEZ7xDqiQXhgOgnFF4xcAVyMI6lSXlVe1K3+fU9nEqIAR0SHlCZb6ZtZUjYNdcQ==
X-Received: by 2002:a05:600c:1c97:b0:43d:301b:5508 with SMTP id 5b1f17b1804b1-441d44bc487mr20004935e9.2.1746689562952;
        Thu, 08 May 2025 00:32:42 -0700 (PDT)
Received: from [192.168.1.29] ([178.197.207.88])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-442cd32b0d7sm27282745e9.7.2025.05.08.00.32.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 May 2025 00:32:42 -0700 (PDT)
Message-ID: <84410317-6f83-46a9-aa5c-a84947b89f00@linaro.org>
Date: Thu, 8 May 2025 09:32:40 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v8 1/8] dt-bindings: dpll: Add DPLL device and
 pin
To: Ivan Vecera <ivecera@redhat.com>, netdev@vger.kernel.org
Cc: Vadim Fedorenko <vadim.fedorenko@linux.dev>,
 Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
 Jiri Pirko <jiri@resnulli.us>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Prathosh Satish <Prathosh.Satish@microchip.com>,
 "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Lee Jones <lee@kernel.org>, Andy Shevchenko <andy@kernel.org>,
 Michal Schmidt <mschmidt@redhat.com>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
References: <20250507152504.85341-1-ivecera@redhat.com>
 <20250507152504.85341-2-ivecera@redhat.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Content-Language: en-US
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 2+47PN9NZAOyb771QoVr8A==
In-Reply-To: <20250507152504.85341-2-ivecera@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 07/05/2025 17:24, Ivan Vecera wrote:
> Add a common DT schema for DPLL device and its associated pins.
> The DPLL (device phase-locked loop) is a device used for precise clock
> synchronization in networking and telecom hardware.
> 
> The device includes one or more DPLLs (channels) and one or more
> physical input/output pins.
> 
One patchset per 24h. You already sent it today and immediately send
next version without giving time for any actual review.

Best regards,
Krzysztof

