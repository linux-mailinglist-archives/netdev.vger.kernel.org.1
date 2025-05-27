Return-Path: <netdev+bounces-193598-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BBC51AC4BCB
	for <lists+netdev@lfdr.de>; Tue, 27 May 2025 11:52:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 628503B3E80
	for <lists+netdev@lfdr.de>; Tue, 27 May 2025 09:52:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD91324DD0E;
	Tue, 27 May 2025 09:52:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="PG14+0f5"
X-Original-To: netdev@vger.kernel.org
Received: from out-183.mta1.migadu.com (out-183.mta1.migadu.com [95.215.58.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A0F91FECDF
	for <netdev@vger.kernel.org>; Tue, 27 May 2025 09:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748339558; cv=none; b=LaeSfMo0q3dEy93sORxd6eCoe+sldCzUtNsOF4NCis3FggphRt7xA4npEZ8N4Ufko+hnbm3jMQ940YyYIcS0k8XjiJ7L32K0SM0qpbd/011v602+w5WVTEHik/5vi6aCpdYuvhxaqSKJzgwm7FYKgp5epoxHq+6So/SpICejn04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748339558; c=relaxed/simple;
	bh=ySN5SL2V08gK0RzuM9krJbs2V0mmKi5sIxxDx4Ebdeo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fnfKFfsiqI5VS7IiVa7ill8SdlEJ5y2tYKFm0ofMIGhZQxild9jSgbNrJekDjfgQRplgqUvopmlSRYemfgy1YPZ7zZfMsm14+61FkgwrUkbbSlAd8twxXdBbV0XZFylm7YBW63JM4DUH1AKoLAmD72NItVAxn56/2yABtoniJqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=PG14+0f5; arc=none smtp.client-ip=95.215.58.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <6147503e-1e73-42dc-a2b9-1b0cf26ca147@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1748339554;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zNzPqOcrIMLkbW6pqRkowgAwEnkW9pgS1P80rwoJM3g=;
	b=PG14+0f5KR1BMnGZAy6/w+as+/MDDALfjtqd2pISAmd/GyJsxozPgbxkP36Ulhp0xRYSQV
	HWL9XZg1J5r+JF4BVayfI9XukkXMpYtBoeYASJgpNuhHawLQJSIQ6WOHZbpRvChvCLljeh
	hy28I9XIT+OxVgBZb66LRh7ViM+zpyw=
Date: Tue, 27 May 2025 17:52:26 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] net: stmmac: add explicit check and error on invalid PTP
 clock rate
To: =?UTF-8?Q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Jose Abreu <joabreu@synopsys.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Richard Cochran <richardcochran@gmail.com>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Maxime Chevallier <maxime.chevallier@bootlin.com>, netdev@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20250523-stmmac_tstamp_div-v1-1-bca8a5a3a477@bootlin.com>
 <8f1928e5-472e-4140-875c-6b5743be8fd3@linux.dev>
 <DA666WVCP2OB.300LVHEGH5V4Y@bootlin.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yanteng Si <si.yanteng@linux.dev>
In-Reply-To: <DA666WVCP2OB.300LVHEGH5V4Y@bootlin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


在 5/26/25 10:42 PM, Alexis Lothoré 写道:
> On Mon May 26, 2025 at 4:22 AM CEST, Yanteng Si wrote:
>> 在 5/23/25 7:46 PM, Alexis LothorÃ© 写道:
>>> While some platforms implementing dwmac open-code the clk_ptp_rate
>>> value, some others dynamically retrieve the value at runtime. If the
>>> retrieved value happens to be 0 for any reason, it will eventually
>>> propagate up to PTP initialization when bringing up the interface,
>>> leading to a divide by 0:
> [...]
>
>>   From your description, I cannot determine the scope
>> of "some platforms". My point is: if there are only
>> a few platforms, can we find a way to handle this in
>> the directory of the corresponding platform?
>  From what I can see, it can affect any platform using the stmmac driver as
> the platform driver (except maybe dwmac-qcom-ethqos.c, which enforces an
> open-coded clk_ptp_rate after the stmmac_probe_config_dt call that sets
> the clk_ptp_rate), if the platform declares a dedicated clk_ptp_ref clock.
> So I would rather say that it can affect most of the platforms.
>
> In my case, I have observed the issue with the dwmac-stm32.c driver, on an
> STM32MP157a-dk1 platform.
Okay!
>
>> And there need a Fixes tag.
> Ok, I'll add a relevant Fixes tag.

On this premise,


Reviewed-by: Yanteng Si <si.yanteng@linux.dev>


Thanks,

Yanteng

>
> Alexis
>
>>> Signed-off-by: Alexis Lothoré <alexis.lothore@bootlin.com>
>>> ---
>>>    drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 5 +++++
>>>    1 file changed, 5 insertions(+)
>>>
>>> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
>>> index 918d7f2e8ba992208d7d6521a1e9dba01086058f..f68e3ece919cc88d0bf199a394bc7e44b5dee095 100644
>>> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
>>> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
>>> @@ -835,6 +835,11 @@ int stmmac_init_tstamp_counter(struct stmmac_priv *priv, u32 systime_flags)
>>>    	if (!(priv->dma_cap.time_stamp || priv->dma_cap.atime_stamp))
>>>    		return -EOPNOTSUPP;
>>>    
>>> +	if (!priv->plat->clk_ptp_rate) {
>>> +		netdev_err(priv->dev, "Invalid PTP clock rate");
>>> +		return -EINVAL;
>>> +	}
>>> +
>>>    	stmmac_config_hw_tstamping(priv, priv->ptpaddr, systime_flags);
>>>    	priv->systime_flags = systime_flags;
>>>    
>>>
>>> ---
>>> base-commit: e0e2f78243385e7188a57fcfceb6a19f723f1dff
>>> change-id: 20250522-stmmac_tstamp_div-f55112f06029
>>>
>>> Best regards,
>
>
>

