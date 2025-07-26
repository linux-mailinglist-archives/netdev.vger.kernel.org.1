Return-Path: <netdev+bounces-210274-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A7CA1B12894
	for <lists+netdev@lfdr.de>; Sat, 26 Jul 2025 04:31:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CB2591C87C3D
	for <lists+netdev@lfdr.de>; Sat, 26 Jul 2025 02:31:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B44871DE4E5;
	Sat, 26 Jul 2025 02:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="MN6oiadE"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0F861401B
	for <netdev@vger.kernel.org>; Sat, 26 Jul 2025 02:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753497052; cv=none; b=aa/HH+Id3uyPvjtyOC9OPgxeThi4oKC3HqwLmJVCXbex+NgQ880WtjUHcwQ+XENIHtTVr6vRAYRqemfTNRscAwVSwVqPVeM1kBXfmP1+E8yG6oqhJAqU0HFTWJtRWWAEYp2Gf8yat9XUtsnJ5IXNV1kuW0sFFY65QOEWUwlWmjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753497052; c=relaxed/simple;
	bh=PrB+/5kXEKvBjOpKUYDtWccK3RIutOjFaivwM+A4O0E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RkQKeXd042zB+eaI5jreLWbaFaT7dWAXnT4ECME7zt04moA/cKRVyrE+N5ZfkI964iOTYNwLfCSvC6Osgh7wlrECydcuSS21CCaQ1pb18LLJ5i0qMJNmVB5XqBt5j4EaFjapKhR7FjobE9AfRh7O/FEiltIxg8FRyGzuSXrLNww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=MN6oiadE; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-23fc5aedaf0so1479995ad.2
        for <netdev@vger.kernel.org>; Fri, 25 Jul 2025 19:30:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1753497049; x=1754101849; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Y3+KGsMghJpTUkFMQc31Znzw1BhSHIhxJP3A9H3lNJA=;
        b=MN6oiadEtROBEKnVkGH2oYiqnQsJWsqwwAj5pNXIgniJI5wiEHkqjTjPMky1UogXr9
         soMl2e/ZFxbBiw/+SYP0+hTenCNd/PWEBNaefRKhMBO2Z3QAf7idZuN3Jq0LozYEJmcu
         sC3AEHSV6M00PCjYp6f7Ec6IUEGTh4IGQ6uo4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753497049; x=1754101849;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Y3+KGsMghJpTUkFMQc31Znzw1BhSHIhxJP3A9H3lNJA=;
        b=ZFxfc+DPAaPeWNSFBPeAO+5SB6t4Ul7VhwhzlhPnW+J1FDpWCx3cEzV79F09jYKh58
         Tpw7ELmvM+Ylphakcra0XV8gxwmwOBIfETSqskxnfsW/9w3SoXILpLMWh4lkEOVF53nz
         X8aLkUJKMZ1WEWnjCJq4ShkpNsZufuiOBNApnmsl65x+1JiaukxWs8a8KYsdZmH+6mse
         w0w9fYexDxiY/M1rxQQmwkdN4wBa6sg3yKRS+7yRotHukA7TstyxMSMMGnK/cb32NMkr
         +ftFuYhQFZojh7vkCzReaZdPW8ssUsM76VTUtqwMpQVR60rngEFY2p+Wbaysv8qnD7mO
         u+iA==
X-Forwarded-Encrypted: i=1; AJvYcCX7txrjnncJxi7RcFgKswx8VV3fuE8orhIEozzn2glKMWblXTzqSCvlyLNtNB0IP5raRI1PXBs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyGMlJaUjltQk6gtb1DorYXYr+B6F+KBfcAgu1iYgiHg1tOrrY3
	f/Qm60b3zwsqb9xKYwmQ1NBPq8kBQKZeOaN1SCQMk27+A71ajzMjcEV1yiUyaojzlQ==
X-Gm-Gg: ASbGncucbo4KYfOKDwWAnb+9XToxk1mnV5k/lq0+GY/8q4J/nWungg2LjRgCzluqcpa
	KwAYkjDnaZp8Bnpom7aP+czVZxTBm2LEIMXXxYusTkl6MHOnTBDbEgbC/RLuUGTLyhg5Pp3CGtI
	xw+JVkz5QycedITkMjTr6xBLlwH3Os5faCV7eZQCtANmQbKCybDoSN87lmVMc2KVkGoo/DhKg3m
	K+tn0tYbbbg1YVV6ECTszkIqZmbNpbYCsLA+jBa7jFb1QKXXAHuJMsgUanJLaQxToauBcz0SN6j
	IvGa9wfmSZW72eCbIFYTveB7hC3Oaaga4E8hQzJoAcBfwotYrrtVBc0qw+uf17qASOiFUmV8tyL
	7FYNmwBbXCOBCL39b4zFrPGnCIjju60hpakhjvs7Y1YBZ1s+oIF/EI+QNINSdI2hnIOUF4MQFhF
	kB
X-Google-Smtp-Source: AGHT+IEUV7d23IGgMtmQ3cEgGJbMNQ82jTYnOVq/TKDZgn6psUNuW6A5cdFh9rjwTn/TWXARN1DgEw==
X-Received: by 2002:a17:902:e94d:b0:23e:3164:2bf1 with SMTP id d9443c01a7336-23fb3148736mr63550725ad.53.1753497049156;
        Fri, 25 Jul 2025 19:30:49 -0700 (PDT)
Received: from [192.168.1.3] (ip68-4-215-93.oc.oc.cox.net. [68.4.215.93])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23fbe4fd676sm7014385ad.87.2025.07.25.19.30.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Jul 2025 19:30:48 -0700 (PDT)
Message-ID: <e091f10a-cb94-4a71-a4ec-dd6d07d7dc8f@broadcom.com>
Date: Fri, 25 Jul 2025 19:30:46 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2] net: phy: realtek: Reset after clock enable
To: Sebastian Reichel <sebastian.reichel@collabora.com>,
 "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Detlev Casanova <detlev.casanova@collabora.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, kernel@collabora.com, stable@vger.kernel.org
References: <20250724-phy-realtek-clock-fix-v2-1-ae53e341afb7@kernel.org>
 <aIJkrh9_4o6flHPE@shell.armlinux.org.uk>
 <y3xhsgbcykfjmz6hjtjzfytb66bm2fomr7cesau45xcuxuin7n@jiryheq3qyvs>
Content-Language: en-US
From: Florian Fainelli <florian.fainelli@broadcom.com>
In-Reply-To: <y3xhsgbcykfjmz6hjtjzfytb66bm2fomr7cesau45xcuxuin7n@jiryheq3qyvs>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 7/25/2025 7:21 PM, Sebastian Reichel wrote:
> Hi,
> 
> On Thu, Jul 24, 2025 at 05:51:58PM +0100, Russell King (Oracle) wrote:
>> On Thu, Jul 24, 2025 at 04:39:42PM +0200, Sebastian Reichel wrote:
>>> On Radxa ROCK 4D boards we are seeing some issues with PHY detection and
>>> stability (e.g. link loss or not capable of transceiving packages) after
>>> new board revisions switched from a dedicated crystal to providing the
>>> 25 MHz PHY input clock from the SoC instead.
>>>
>>> This board is using a RTL8211F PHY, which is connected to an always-on
>>> regulator. Unfortunately the datasheet does not explicitly mention the
>>> power-up sequence regarding the clock, but it seems to assume that the
>>> clock is always-on (i.e. dedicated crystal).
>>>
>>> By doing an explicit reset after enabling the clock, the issue on the
>>> boards could no longer be observed.
>>>
>>> Note, that the RK3576 SoC used by the ROCK 4D board does not yet
>>> support system level PM, so the resume path has not been tested.
>>>
>>> Cc: stable@vger.kernel.org
>>> Fixes: 7300c9b574cc ("net: phy: realtek: Add optional external PHY clock")
>>> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
>>> ---
>>> Changes in v2:
>>> - Switch to PHY_RST_AFTER_CLK_EN + phy_reset_after_clk_enable(); the
>>>    API is so far only used by the freescale/NXP MAC driver and does
>>>    not seem to be written for usage from within the PHY driver, but
>>>    I also don't see a good reason not to use it.
>>> - Also reset after re-enabling the clock in rtl821x_resume()
>>> - Link to v1: https://lore.kernel.org/r/20250704-phy-realtek-clock-fix-v1-1-63b33d204537@kernel.org
>>> ---
>>>   drivers/net/phy/realtek/realtek_main.c | 7 +++++--
>>>   1 file changed, 5 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/net/phy/realtek/realtek_main.c b/drivers/net/phy/realtek/realtek_main.c
>>> index c3dcb62574303374666b46a454cd4e10de455d24..cf128af0ec0c778262d70d6dc4524d06cbfccf1f 100644
>>> --- a/drivers/net/phy/realtek/realtek_main.c
>>> +++ b/drivers/net/phy/realtek/realtek_main.c
>>> @@ -230,6 +230,7 @@ static int rtl821x_probe(struct phy_device *phydev)
>>>   	if (IS_ERR(priv->clk))
>>>   		return dev_err_probe(dev, PTR_ERR(priv->clk),
>>>   				     "failed to get phy clock\n");
>>> +	phy_reset_after_clk_enable(phydev);
>>
>> Should this depend on priv->clk existing?
>>
>>>   
>>>   	ret = phy_read_paged(phydev, RTL8211F_PHYCR_PAGE, RTL8211F_PHYCR1);
>>>   	if (ret < 0)
>>> @@ -627,8 +628,10 @@ static int rtl821x_resume(struct phy_device *phydev)
>>>   	struct rtl821x_priv *priv = phydev->priv;
>>>   	int ret;
>>>   
>>> -	if (!phydev->wol_enabled)
>>> +	if (!phydev->wol_enabled) {
>>>   		clk_prepare_enable(priv->clk);
>>> +		phy_reset_after_clk_enable(phydev);
>>
>> Should this depend on priv->clk existing?
>>
>> I'm thinking about platforms such as Jetson Xavier NX, which I
>> believe uses a crystal, and doesn't appear to suffer from any
>> problems.
> 
> Doing the extra reset should not hurt, but I can add it to speed up
> PHY initialization on systems with an always-on clock source. I will
> send a PATCHv3.

Assuming the PHY DT node is tagged with "always-on" then one might 
reasonably expect it to be used for Wake-on-LAN and that it should be 
able to register itself as the wake-up source. If we pulse the reset we 
might lose the details of the wake-up event within the PHY. So yes, 
being able to deal with that and doing the reset conditionally might be 
preferable.
-- 
Florian


