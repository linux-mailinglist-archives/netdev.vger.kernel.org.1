Return-Path: <netdev+bounces-144769-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 872A19C866F
	for <lists+netdev@lfdr.de>; Thu, 14 Nov 2024 10:49:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4BA35283375
	for <lists+netdev@lfdr.de>; Thu, 14 Nov 2024 09:49:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67D071DEFFE;
	Thu, 14 Nov 2024 09:49:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E/HleNfG"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oo1-f44.google.com (mail-oo1-f44.google.com [209.85.161.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E19F11632F2;
	Thu, 14 Nov 2024 09:49:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731577765; cv=none; b=uVYZL5nTrU6iu4zdJOP+Zub2xa48Rg/tqOz9fy9vAhTnuQDs2miYVaJ4O+O1jERiIX7E6JDbVUTgGP8Mu410YTlADFZEAURYMtcTGPLc666Ac35G19plI1pp4Gw+P0dwIZv1vI/FgmQy1GGLOnxvyfO/RzmP2iomhxuXF0d3xGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731577765; c=relaxed/simple;
	bh=LBDgTy1qkvDaPSlehfadhtmiLxFZBW+A5WLrGZyTGyI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=D0heyECeWl3md9COOys+wDps04fQTtd3plaC09DZjfMU1D+xy6QlcPzcEgXcY4A2kc6NYiUr0lu6JZWRb+xozFRJwzUmlJTdAaRkDA7FqPI1UMgh/QXJTN/01DaaycxTr7UfpUgkvBeZRk7URoM640XdgpwrynPQgNp/6fdpyPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E/HleNfG; arc=none smtp.client-ip=209.85.161.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f44.google.com with SMTP id 006d021491bc7-5ebc05007daso158043eaf.1;
        Thu, 14 Nov 2024 01:49:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731577763; x=1732182563; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BJ007AyfFSmUh1mOpRxq8pHzHMlQHIiPTiwXlN1yM+4=;
        b=E/HleNfGtOGBTIMt2dYnwDwh1LsV2jSksnaICYm3xRoh03Nve7gsCThm3pRgQRwXde
         51ucAcy+4YmFIasZKyn8VvNvjYlSW1AmLRJCNLlEa0T1J/EJjhuBt63qWR+9zhF0NQqf
         c0CpNyFqANK19H78B5mCb8K5FBt+QbKVGTHGPiy3J6gdzWtNP1036l+WWrYBcYXpcxND
         45u7hNhCu57qt5YOANBBI5JPBbVKiaYjTetE7+X6XPv+ZZMKxsP6NPafcG/7ljYBBGie
         7yjQe6Rzcfzof+xEw5QUy9NjR5s/KBj/K3MX8FfHeOBsZ08fQ4PWGJtvVR+i707D4cl1
         sgtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731577763; x=1732182563;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BJ007AyfFSmUh1mOpRxq8pHzHMlQHIiPTiwXlN1yM+4=;
        b=KHy6BPj/gbY109uEaGgeGfo/7kBDXQ62IYjtzHsMHxY4OcQl5oUW0gpluM+QrRqC9a
         VTBC0zUWms7cAc+GF1RBQreywGpe82daj1fvkLJx1WKEyRjeGVoVxKMKduL7W6d/kM/K
         h5/YMsh1FBO4i9fvWjyjeptro/NaAbFPLn066ZF0E6BF0u6VpW1V1CInONP/ICnJzcG7
         wsvGIA6s/MHX1NDSCdELyzvQsa751HoJyAPOq0TaH4HvZOnB5sp3WQrtkRLDk2Z6SXct
         QfSx/zZLNkBLy4mjQlN58XOI6rsmgo6ztR3HAc0ngSf807R73RvnNz1xRTJ2sqtZmavD
         Vn1g==
X-Forwarded-Encrypted: i=1; AJvYcCUP+ghGhnPIVC0ApWD//IaPsr02IWYtw/paqsE86rxXhi5HUMa/vfcN+DyT7vhiK9+Q0/8yOMmgu96LsnT7@vger.kernel.org, AJvYcCW6/7aUC3GW7Afg+hKi4FzcyXR+hQQmzUB8CRrt/omVG7EAueBuw5XeOq9Qfe0bepqhjreHOMVRNwz+@vger.kernel.org, AJvYcCXoUFpSfqoghxm6b9MIx+b5tPwpxqjBIhNpenR/6mNT0EnRTX2fCobYNpndR/yz6TDpzKjqopdT@vger.kernel.org
X-Gm-Message-State: AOJu0YwwKiqSDIrinqr5JptDkGF7//CkLuPUmFHwYXT0ZFtDUKNv/JMF
	i4EGvT1a3O8b5yyW8nxjdvwN3APRYjo790h6A+7ebOrl4OOflr0i
X-Google-Smtp-Source: AGHT+IElpYeRFs0SFCU7YxvfDnm+J9VKwBd+r6YY8KKPQksjpdgonuoZU+lvxZoNdrIbZVA3+RzO9w==
X-Received: by 2002:a05:6830:631c:b0:718:c2e:a193 with SMTP id 46e09a7af769-71a6010a842mr6854545a34.10.1731577762840;
        Thu, 14 Nov 2024 01:49:22 -0800 (PST)
Received: from [192.168.0.101] (60-250-192-107.hinet-ip.hinet.net. [60.250.192.107])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7f8b37e01easm713510a12.24.2024.11.14.01.49.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Nov 2024 01:49:22 -0800 (PST)
Message-ID: <8e55e276-f2ee-4679-8e0f-ca5afb3653fc@gmail.com>
Date: Thu, 14 Nov 2024 17:49:18 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] net: stmmac: dwmac-nuvoton: Add dwmac support for
 MA35 family
To: Andrew Lunn <andrew@lunn.ch>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, mcoquelin.stm32@gmail.com, richardcochran@gmail.com,
 alexandre.torgue@foss.st.com, joabreu@synopsys.com, ychuang3@nuvoton.com,
 schung@nuvoton.com, yclu4@nuvoton.com, linux-arm-kernel@lists.infradead.org,
 netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, openbmc@lists.ozlabs.org,
 linux-stm32@st-md-mailman.stormreply.com
References: <20241113051857.12732-1-a0987203069@gmail.com>
 <20241113051857.12732-4-a0987203069@gmail.com>
 <b7fb59a9-989e-42b9-ac72-71f353854812@lunn.ch>
Content-Language: en-US
From: Joey Lu <a0987203069@gmail.com>
In-Reply-To: <b7fb59a9-989e-42b9-ac72-71f353854812@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Dear Andrew,

Thank you for your reply.

On 11/14/24 10:56, Andrew Lunn wrote:
>> +	if (of_property_read_u32(dev->of_node, "tx-internal-delay-ps", &arg)) {
>> +		tx_delay = 0; /* Default value is 0 */
>> +	} else {
>> +		if (arg > 0 && arg <= 2000) {
>> +			tx_delay = (arg == 2000) ? 0xF : (arg / PATHDLY_DEC);
>> +			dev_dbg(dev, "Set Tx path delay to 0x%x\n", tx_delay);
>> +		} else {
>> +			tx_delay = 0;
>> +			dev_err(dev, "Invalid Tx path delay argument. Setting to default.\n");
>> +		}
>> +	}
> The device tree binding says that only [0, 2000] are valid. You should
> enforce this here, return -EINVAL of any other value.
>
> 	Andrew

This will be fixed in the next version. And I will correct error messages.

Thanks!

BR,

Joey


