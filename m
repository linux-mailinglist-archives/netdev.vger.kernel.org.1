Return-Path: <netdev+bounces-168801-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 297BEA40C3E
	for <lists+netdev@lfdr.de>; Sun, 23 Feb 2025 00:59:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 188937ABC64
	for <lists+netdev@lfdr.de>; Sat, 22 Feb 2025 23:58:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7177F204686;
	Sat, 22 Feb 2025 23:59:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LYOQ/HQl"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06F4078F2F;
	Sat, 22 Feb 2025 23:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740268773; cv=none; b=Hn8T+fhDLLN3ClE+tAUGuiji0Y6WMxFP+whBUpG6ID59ri6Zdmfj/u8VGmB5vOm3gXKp+1KNIYhzw9YfMNLgOx2zKz0J8m3lk2ElkPEMwpeEDtyR7JKXCc8eNYwW6ftPMKglgFpjN9PF1MUXplcTcvyRhkLwl3iS9ttlQupiIWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740268773; c=relaxed/simple;
	bh=VSd7G507W9GhEVUIyS2seEENJt2SPhore+zRSc3WcMY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=J0Jh3xtnz1xFcCds3p5fE394akuxRG85uBWkV6BbKE3SqGpiz+HuS4DnrU6aodLY+lVlrxwn9xp2vzwW1klPYEc+mDxz0SyPBSllFUoAnZNu1ORLknhWq+Qg45Bo4cqOxDQJVmQXhHwAbB87K6f7Q3JB8XYRbpuNJhV7GOsFnH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LYOQ/HQl; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-2fc1843495eso4931199a91.1;
        Sat, 22 Feb 2025 15:59:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740268771; x=1740873571; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=90/s+KzhSHh96JnVwqqX9Ga+sfryIMGed9jtbZZaUow=;
        b=LYOQ/HQlX38xjx6PuPUy7f7BCwSD1lZtB+Ci9MXFbfafxVcF7nvOBhO2OzhJqpzakY
         7TS/oiTq7UuHdqPYPDXJYOqEb8cfSCMs9gQvXuqqcf6iWhmwRPT496Bsobi+SHBDUIqs
         S38MeqBCX0UVceqxxiq/OFabv5AtbuCmhRziLSoYgbyLXSXKZLqAPLSeWgnj08jyWUq+
         RKkI+4IrKAXxEBWrEaWL3gNSjdQ/vOUVFWMgYXM6uvr6UgkVUbo5qY/zHSdKUZppO2kT
         M3jnA4b+4hPWtaoY7s5X8HIUDt/NoHNpJs6zg53QIrUOh/RThVWSL9y4v9Yatw0RbzSS
         eOTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740268771; x=1740873571;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=90/s+KzhSHh96JnVwqqX9Ga+sfryIMGed9jtbZZaUow=;
        b=wnegi37RMIcSGLjMQ7u70fQX1Z5ijogyapFidJpW9aHBWlx5qEA88a9MABUpHuXXnw
         fq7uotNH3HiiOXkwkcNGsX4FIDGJDFZW4fndXwsROZFS0i7KyKa4ItOgBP2i94jy8xLI
         H3747ycfFJMkw2RiAllq+WAEc2ffC9xz58qHAWZKxBg25yWigdly41fWDODKLeICZwWY
         dgehu5t7rZausZzL/e0GZf+h0iGXblhLoHhZKUmXw/03hqnpaxk2GsSoL2S0xQCOXoGX
         7sGg5OGDr5r9FEGmxRpH4flLxXEXmQzdUOg1dIHMW8HKtGqvcoOHVb066+1z1vYNgwJj
         NFPA==
X-Forwarded-Encrypted: i=1; AJvYcCXY2ODjJLJaFOKdbSL2VqBUI464K2Puva4ICWDuU8vrZGxBIgq1FEEnkd2yFjkzKoGLFznJlP4V@vger.kernel.org, AJvYcCXa8B4oKFQTwtz7Du3V+zlRGr+eUFIXjHAPTwB6bX29W1kRBQfNY7a15R6VXNFAmbbKfSjJEF0Z5gGkcF6u@vger.kernel.org, AJvYcCXyvLu7ES4eqBoEzvz5kffaeLatJwBPKIDENOuKKvVTNNTHNnSaJD8GfGZJ+uEeXL7kWAK2Pplir+sP@vger.kernel.org
X-Gm-Message-State: AOJu0Ywck7uez1omj6hIv7IbWF4f4JaWc3o233phWMfLfXtIi+abL+H8
	2WgKqOhc5fx2eRPHNMqN0N/7hj3+OCVsujmvcbTQOE6ZcGimE0vv
X-Gm-Gg: ASbGncsqQnifLzJiRKxvAnv5jzosxbPkW5v1cSBKmlmlf1FlE78TFstd0yGRpHkHNc0
	/wne2P3V724zI9aJomgRnupjU1CuiKpYOsBM6VkGMx7AWh8SurE3cPpbcOxz4fgJifrWk+0uk88
	un/is1x1WpLfqhMCGIQt81AJ21eWgwV9l6TfMnuJ7JZSsVGmvi6oSpzaHTGefAbLc4t7+5oTJLt
	z38e9XIslWVBIzInSt3787kZ1QzD0r4/hPO4/Gm8IbUlkTOqPhc+iMwUOXJjnO/TFHtNs7aWeH2
	B1fqWFyWteNrqS2RMBbhxGgByj/BJezbZ1Y=
X-Google-Smtp-Source: AGHT+IEQriOVvLcOekl7drz6hqdCF9IIUdvCSGDXZVwixhwDmzjDc1YQ+Kmp6rJLM53HbprX+WZUkw==
X-Received: by 2002:a17:90b:3ece:b0:2ee:d371:3227 with SMTP id 98e67ed59e1d1-2fce78b77eemr15938334a91.17.1740268771198;
        Sat, 22 Feb 2025 15:59:31 -0800 (PST)
Received: from [192.168.8.112] ([64.114.250.38])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2fceb02d985sm3722912a91.6.2025.02.22.15.59.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 22 Feb 2025 15:59:30 -0800 (PST)
Message-ID: <61d793e0-f753-4f68-a169-c98336911588@gmail.com>
Date: Sat, 22 Feb 2025 15:59:29 -0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/5] dt-bindings: mfd: brcm: add gphy controller to
 BCM63268 sysctl
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Heiner Kallweit <hkallweit1@gmail.com>, Russell King
 <linux@armlinux.org.uk>, Florian Fainelli <florian.fainelli@broadcom.com>,
 Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>, =?UTF-8?Q?Fern=C3=A1ndez_Rojas?=
 <noltari@gmail.com>, Jonas Gorski <jonas.gorski@gmail.com>,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org
References: <20250218013653.229234-1-kylehendrydev@gmail.com>
 <20250218013653.229234-6-kylehendrydev@gmail.com>
 <20250218-fearless-statuesque-zebra-3e79a8@krzk-bin>
Content-Language: en-US
From: Kyle Hendry <kylehendrydev@gmail.com>
In-Reply-To: <20250218-fearless-statuesque-zebra-3e79a8@krzk-bin>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2025-02-17 23:35, Krzysztof Kozlowski wrote:
>> +    # Child node
>> +    type: object
>> +    $ref: /schemas/mfd/syscon.yaml
> No, not really... how is syscon a child of other syscon? Isn't the other
> device the syscon?
>
> This looks really fake hardware description, like recent bootlin claim that
> "one register in syscon is device".

I will change the driver to access the register through the main syscon.

Best regards,
Kyle

