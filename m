Return-Path: <netdev+bounces-83519-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A43EF892C56
	for <lists+netdev@lfdr.de>; Sat, 30 Mar 2024 19:13:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1C2C61F21C2C
	for <lists+netdev@lfdr.de>; Sat, 30 Mar 2024 18:13:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 135F23CF6E;
	Sat, 30 Mar 2024 18:13:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="scHa8mxp"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 407AD38389
	for <netdev@vger.kernel.org>; Sat, 30 Mar 2024 18:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711822424; cv=none; b=XuJJ4O1hW53z2wAeXGTm11FCL87LvRNylzSWl76bH3IUaVVlP3SWOlhLdXUBr/oyXl3ibfZyrh4JwAYj9fjI68fS2B+IhZmkgnGVypnCmeWzYt7RMdVuM26W//+UBqPAkyyZBGyjcLoH5ht+TedVbZV7M5mvNsWBAUxbC5kHkNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711822424; c=relaxed/simple;
	bh=ZtB69q7YSK9P0x7DylVKfk+LPfv+xqTle4GzcQa6XxY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Vk+HEmv5z5Op5WW2Z1jVAGuRRU1O0WAt7YKFy6b7JkgbPK5pgixUibtQ/Y9xF43n35RHXwJ7h3R/jQq/WkLHqJvrCyiYIaeuC/6MDhWMB3WOjmxAEdvVSbPaZ3sZeCuxDhor4EpoYAZ8RRLHD0QrPLCGzjxqG0XnbWSF2GMH+Kg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=scHa8mxp; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-3434275ad73so249675f8f.1
        for <netdev@vger.kernel.org>; Sat, 30 Mar 2024 11:13:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711822420; x=1712427220; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=N03dNsY6NCKQbyHG0Slle9WAQGWfIfBLLsHib+HwpmA=;
        b=scHa8mxp7e+oZSH/VtZFRDVKQJFpxIRHWYsZJbbcs5pvthCdeIGs4zKIl6I0H8ZJNE
         X2sUCppfYgh+NiY8glx+QdvFYr+FkSqS2g8hO1IJ0DljIM5xOzv59G7wiOuSN5dO0hGA
         rE6LD/3KK5HGQ2JcetGzrHF+LxEPREIgKSZvb7zEpxVl8GjXT9El0TQNjn0+3R85OAmA
         m5MxNHWsdRhEfTihNsz5Zw1elMtZfiM+KsRft2FK9pPNoXRh44qRqfBK4/Vqog2rZ6oA
         oA0bJRM5um6Ojjh8vYHid3xPKvz7bB473ET/DUuXRGg5Lp1zlE5P6qpjpivdUyGV0AOi
         i2Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711822420; x=1712427220;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N03dNsY6NCKQbyHG0Slle9WAQGWfIfBLLsHib+HwpmA=;
        b=dVoaMJxC6sbVdPKv9XewTr1zzLXQn9sknjfK/kgk+EW5NOiCGkCbn6Xp0dB4u30pqL
         +ihkEUQJxJ9d3Cv/6R2+USJ6uXOSHBe0J1humvjA6gsPUwZrMfMKmXVX3ORQAiqeTS7G
         +fn6c8TE1OAGbcYpXjQRGXMGY3b1g6ZPZjf2XcYHQJ9mimyiiGpTFkvbc36tAvFd/Wjz
         QDYbVPTHAjgZ56dDkKYZRx3mf4yD2Br2IHWvQiNEJFGO24DI8R5tzGCTk/xlZqN58yNn
         HhnrPOdIxG7E4jonF2UQ53OSgwI/+IFEY8dkmVBrfRLyun+GG9NIKOqZwWVGkdu5PO79
         B42w==
X-Forwarded-Encrypted: i=1; AJvYcCV3CGc5oZI2wnehym9HiN2nZrdw7d/qXfvRzmr1gSTUPOmgks6FXfC/vygV78+yQd7CyGtEyMinJ/Xj5fRdlkXsWmrJDObs
X-Gm-Message-State: AOJu0YwLKHQSh1QL6PXhRcVUAKTqugzwmW8aUBYCEFOwiezdeN+R6pAD
	DE9QIeyormHKfN7v4i47W7qdpuog5cwACpqcmn/WfR5R73bwSmEuvfeXFckr0RM=
X-Google-Smtp-Source: AGHT+IGb3m5mmcd/2pv1zK8XntIChat4Wtv/BlVANNR6aAsgB/VPvKvmAF7FpBO/70IfarQxhtuLXQ==
X-Received: by 2002:adf:f687:0:b0:341:a63b:3121 with SMTP id v7-20020adff687000000b00341a63b3121mr3296124wrp.29.1711822420579;
        Sat, 30 Mar 2024 11:13:40 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.16])
        by smtp.gmail.com with ESMTPSA id d14-20020adff84e000000b0033b66c2d61esm6911267wrq.48.2024.03.30.11.13.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 30 Mar 2024 11:13:40 -0700 (PDT)
Message-ID: <a79b17dd-da49-46ad-9d22-16ca2df7543b@linaro.org>
Date: Sat, 30 Mar 2024 19:13:37 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 net-next 1/2] dt-bindings: net: airoha,en8811h: Add
 en8811h
To: Eric Woudstra <ericwouds@gmail.com>, Rob Herring <robh@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
 Heiner Kallweit <hkallweit1@gmail.com>, Russell King
 <linux@armlinux.org.uk>, Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Frank Wunderlich <frank-w@public-files.de>,
 Daniel Golle <daniel@makrotopia.org>, Lucien Jheng
 <lucien.jheng@airoha.com>, Zhi-Jun You <hujy652@protonmail.com>,
 netdev@vger.kernel.org, devicetree@vger.kernel.org
References: <20240326162305.303598-1-ericwouds@gmail.com>
 <20240326162305.303598-2-ericwouds@gmail.com>
 <20240326192939.GA3250777-robh@kernel.org>
 <9ea90a1a-37b2-4baf-94af-2b89276a625d@gmail.com>
Content-Language: en-US
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <9ea90a1a-37b2-4baf-94af-2b89276a625d@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 26/03/2024 21:41, Eric Woudstra wrote:
> Hi Rob,
> 
> On 3/26/24 20:29, Rob Herring wrote:
>> On Tue, Mar 26, 2024 at 05:23:04PM +0100, Eric Woudstra wrote:
>>> Add the Airoha EN8811H 2.5 Gigabit PHY.
>>>
>>> The en8811h phy can be set with serdes polarity reversed on rx and/or tx.
>>>
>>> Signed-off-by: Eric Woudstra <ericwouds@gmail.com>
>>
>> Did you change something or forget to add Krzysztof's Reviewed-by?
> 
> Nothing has changed in this commit. I was wondering if I should do this,
> so I should have added the Reviewed-by Krzysztof.
> 

Please add Acked-by/Reviewed-by/Tested-by tags when posting new
versions, under or above your Signed-off-by tag. Tag is "received", when
provided in a message replied to you on the mailing list. Tools like b4
can help here. However, there's no need to repost patches *only* to add
the tags. The upstream maintainer will do that for tags received on the
version they apply.

https://elixir.bootlin.com/linux/v6.5-rc3/source/Documentation/process/submitting-patches.rst#L577

Please carefully read above guideline. Entire.

Best regards,
Krzysztof


