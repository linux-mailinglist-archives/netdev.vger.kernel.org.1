Return-Path: <netdev+bounces-142737-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 02D549C027A
	for <lists+netdev@lfdr.de>; Thu,  7 Nov 2024 11:36:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B7A3B2805F7
	for <lists+netdev@lfdr.de>; Thu,  7 Nov 2024 10:36:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC51B1EC012;
	Thu,  7 Nov 2024 10:36:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vk2Rsa3+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 500D9126C01;
	Thu,  7 Nov 2024 10:36:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730975792; cv=none; b=jo5Vrv+tTsXB6aolOf+XgNoXPmIPbFaGypm2ZJONqHkoF1XJ0qd/GUfmhJNsTdB46pvPJ4uoHbuR9YQAjcNZfUcGuABteVnHjQI8EPSXtzc15eQ82EDQKvYYErU7FA6GqxHDkQhLYnIMxUPjXsmQqm4zIL1DeSgZdUZLvu7niIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730975792; c=relaxed/simple;
	bh=MTMa471WktGrLCwXBDxYin5QOxc44DOzITzpMHuzOIM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YVaVWkjD6vIuYEkyw3UQdrXNQpD4IVF+PD225SKEvUjQYezIWqGvLvkSAsceieldepYyLTTuND3LzMl54QhjQPcwug81Dwt/9hzLjW1gy10n/4Hsulzuk8cb7Pppw+qAqPb7reZ/x7G2QfIinlpvFEA63Uo0h+LNKuu5qljGV8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Vk2Rsa3+; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-71e52582cf8so551987b3a.2;
        Thu, 07 Nov 2024 02:36:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730975790; x=1731580590; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xC4jScz5PMTA20yKpGgSaZvcBSA6x4Yz2EVtRJnnFPg=;
        b=Vk2Rsa3+840/Z2bSP9KlWemH42ZX96nZ1iSZC0MZ5yiKFHwdTJT07z3Bo2aqjXfxMY
         dx2V34783XbS0NcyJzJC8XZyBum7MFu1hXXPy68DSu4QZPiswkIHzIz1JqHV3hG1RiEw
         o7tYPzHIAI1slDiJ9qZPRdF+HJ/hQj2s+oUbteGlsNiOmHX+bcXkUx0HWuSRicB3w0rM
         38e1ZFV24WHLlqGGvrzBXzChhVmUSyZw76IrzZ1rr68v3nUp0qZnNlKyFshCuVnQaqDd
         x8eV4R432XKpXETrYIqW5xQTBpoAVBpWruCVT6uz6Lk3KYfhQFrMAn1NrBEK+3LI49Cb
         /3ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730975790; x=1731580590;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xC4jScz5PMTA20yKpGgSaZvcBSA6x4Yz2EVtRJnnFPg=;
        b=EBxapeN4tFLh8ZQ+OleaDBCXZnAyF1pr/JyJ27nlgCxv7ckr1Y48xKIE8KeiYaBV1Z
         jAkyfE2acPLB80Ao6Wp7FYWaRMKCaHEGSI0a4Gx9mSFWbOh9zap450VfFzGuxMRQofpA
         6Qp8jkay1XM0szNXF9+7fZyk4XsHDIm7Few3EMS5n7escDsG6Sth/EBymEZ6dROm0pj5
         rMceuSSK/F7dr8NgORZiWmcoGD8zC/Fj0jmmkHw6X45HmmsmqhM1v6Th7RyaQ99mu+CZ
         3CDfESi2DIquzmfF3ogdyhjrVcarZY1EwuEhOZtGQn6sf5t/yE39KLULbl+Q9mZIBy8/
         1RdA==
X-Forwarded-Encrypted: i=1; AJvYcCUQ03e59bkob1Xy95YbqDtHLrk6TNGK69m6fjtNr9QdlAEgn9tAa3XJVRqszslyyPDVYaDWgthcxMQwfP+2@vger.kernel.org, AJvYcCVsJbzqtVioy7Jb2FUtjHDlHAQqwGE5RepcSXvB/rUvLWYrodRqJ/tpWBfTZnuV0GC1e09nor1k@vger.kernel.org, AJvYcCXG1/jhkNErABDcCvKxlvn4D6UFuj2/nVs4ljfJhx7sZCYqqV7CUvyFIMHpGGt8UfOqh/xmmbkEVG7c@vger.kernel.org
X-Gm-Message-State: AOJu0Yzeuz+k/zxgW9m5wXt5ypsiMsdkYoeEO+pt7yCyKN1yecYHWTWJ
	HjbRkB4aia6IHJ6Z0o3B2+0lD0/IWOKmx1ER7orZIlKJjy+LTovY
X-Google-Smtp-Source: AGHT+IFEcmPOqn+X7HeywXdO6/sEgP5tjET/8PEbokkUZb1iOlKZDIKxcXvkvkXx3PWm7y2eChH7tQ==
X-Received: by 2002:a05:6a00:2284:b0:71e:4786:98ee with SMTP id d2e1a72fcca58-720c99b7befmr31801669b3a.21.1730975790564;
        Thu, 07 Nov 2024 02:36:30 -0800 (PST)
Received: from [192.168.0.104] (60-250-192-107.hinet-ip.hinet.net. [60.250.192.107])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-724078a7d9esm1209196b3a.66.2024.11.07.02.36.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Nov 2024 02:36:30 -0800 (PST)
Message-ID: <99fa8255-12b5-4a54-acfe-cc0fbbba9c0e@gmail.com>
Date: Thu, 7 Nov 2024 18:36:26 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] net: stmmac: dwmac-nuvoton: Add dwmac glue for
 Nuvoton MA35 family
To: Andrew Lunn <andrew@lunn.ch>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, mcoquelin.stm32@gmail.com, richardcochran@gmail.com,
 alexandre.torgue@foss.st.com, joabreu@synopsys.com, ychuang3@nuvoton.com,
 schung@nuvoton.com, yclu4@nuvoton.com, linux-arm-kernel@lists.infradead.org,
 netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, openbmc@lists.ozlabs.org,
 linux-stm32@st-md-mailman.stormreply.com
References: <20241106111930.218825-1-a0987203069@gmail.com>
 <20241106111930.218825-4-a0987203069@gmail.com>
 <4c018927-b6ac-4414-9dde-487453350cca@lunn.ch>
Content-Language: en-US
From: Joey Lu <a0987203069@gmail.com>
In-Reply-To: <4c018927-b6ac-4414-9dde-487453350cca@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Dear Andrew,

Thank you for your reply.

Andrew Lunn 於 11/7/2024 2:23 AM 寫道:
>> +struct nvt_priv_data {
>> +	struct platform_device *pdev;
>> +	int id;
>> +	struct regmap *regmap;
>> +	phy_interface_t phy_mode;
> phy_mode does not seem to be used outside of nuvoton_gmac_setup(). In
> fact nothing in nvt_priv_data is used outside of
> nuvoton_gmac_setup. So it looks like you can remove it.
I will remove it.
>> +	if (of_property_read_u32(dev->of_node, "tx_delay", &tx_delay)) {
>> +		dev_info(dev, "Set TX delay(0x0).\n");
>> +		tx_delay = 0x0;
>> +	} else {
>> +		dev_info(dev, "Set TX delay(0x%x).\n", tx_delay);
> Please don't spam the logs. dev_dbg(), or no message at all.
>
> 	Andrew
I will fix it.

Thanks!

BR,

Joey


