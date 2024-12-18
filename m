Return-Path: <netdev+bounces-152817-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 404229F5D70
	for <lists+netdev@lfdr.de>; Wed, 18 Dec 2024 04:26:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7D36716F271
	for <lists+netdev@lfdr.de>; Wed, 18 Dec 2024 03:26:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9E1614A62A;
	Wed, 18 Dec 2024 03:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pf-is-s-u-tokyo-ac-jp.20230601.gappssmtp.com header.i=@pf-is-s-u-tokyo-ac-jp.20230601.gappssmtp.com header.b="M0InXCOw"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A908146D57
	for <netdev@vger.kernel.org>; Wed, 18 Dec 2024 03:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734492284; cv=none; b=TbzrlGUZaXF1K8rQPf7eHSYxnwc2oSoHP7eiFMmVOjLv4RwdSwXAJobZnCpCt0z4DbPaVVi7vN121I7mMyMSN3YvCWrX8sjM1J9PuJhYF44TU0x4aDUqXNFOeMsgfzpD3sNbPxxXVNPFrPdJP4cj7P0oljTZLT1X/td6uWuzywM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734492284; c=relaxed/simple;
	bh=J+nVJJ5hibHELRJx1oLe+rZxQt8ujdcfk/308lUN0DA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=n0ONbyIBOwL0cIag7bzmuy+JssO+dCcZVvLdATm/9vWC6ZMoP+e8TC9QlGq/kiMLuwVPPD7WtEZrGOW1/y37zHk2oennzzobCv8dNFI8GKbYC9AETXJU3mFfdDMgow7ed1fZEzO3dKKxIojLEZm60YBrmA4AIbV0NLUQ+tLnFjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=pf.is.s.u-tokyo.ac.jp; spf=none smtp.mailfrom=pf.is.s.u-tokyo.ac.jp; dkim=pass (2048-bit key) header.d=pf-is-s-u-tokyo-ac-jp.20230601.gappssmtp.com header.i=@pf-is-s-u-tokyo-ac-jp.20230601.gappssmtp.com header.b=M0InXCOw; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=pf.is.s.u-tokyo.ac.jp
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=pf.is.s.u-tokyo.ac.jp
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-21670dce0a7so66548165ad.1
        for <netdev@vger.kernel.org>; Tue, 17 Dec 2024 19:24:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pf-is-s-u-tokyo-ac-jp.20230601.gappssmtp.com; s=20230601; t=1734492281; x=1735097081; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SgENqryqr6NUGWDh5nVZt/mtyDmD9IKNuTdLRDtDLHo=;
        b=M0InXCOwm2q472w+5JJJR6Vj5SxLaiZYWxPXZE2y227VED6v3kLGoEylYy3+v6bp8X
         EwTaIM7vkNYaFkNzIP++N034+2y1QWBRBOOaWumz9Wz+ZAQ/2Fc4DPu8H31lzM7f60av
         GYiFQTfgwydinu505KhNW0cvZdh/lqoDkRj3xY5NK7NA+1n7mAVezxVpIDRp1cTuvjQB
         0FEtRGvKKL/IgZlPmXy37kBhOvlhAirr8V7Go8uHVLG5DJmW7ESiHnthVhwyCMUj+S4x
         V+2zHNpD/hIQ00Zl0HNetKZoNa753GoEjGRO+4Ml09aQoCSESMgiHRF0rF1V/8RjYy28
         hz3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734492281; x=1735097081;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SgENqryqr6NUGWDh5nVZt/mtyDmD9IKNuTdLRDtDLHo=;
        b=MzNA/N8Lwz6YLfip6wuSzagOlyYsThoOYitNo+YPx3+5d9OxdNbDZBiPCWgwuUQ2wI
         VPFJarpKUh3UBsb6piQVpRc0znXar5SxMn6MsgP32++fS3EyFNtiBUGmYQnvbnDmCMv2
         ck1oaAjU1PSe5FxAGPQZvuE2FTRw6yfE8T8dK58SWhKBMhu6FDG0Pn3ciA937PxWh50q
         shUvM4P/8D2gYTtNJeg/3KvuR2b4G53QfCxR4e9TwGQ7YeiWpRR73N0tsDknnSZWGqwd
         eUrFRrfg3YBGGa5wmBed4IaoxgMQsKrkPokmvxwdTkufneFp6MC8hwQZStd5MEvs54NX
         AftQ==
X-Gm-Message-State: AOJu0YxQTvVX3dUcoxMIijstafqepUCVJU/ZBhbjSgHoacAbXLcnhspU
	m3EiPx0WpeVmeHSJ2I07rktSBPQKyIi2miUNaJyi916/slJtkrIbHbOmvgJ+jUo=
X-Gm-Gg: ASbGncsEXZkRi8BvYJWfoIkuHMeND5M5e6Ov73WYJxoOPazt2g2T/9MRZ8dAooVLuTB
	5EWKx82JKz71GqiXTV01sqRGf7fxb+uD4WEDQ+52yX4b3DtQzjIbX8LH0llalJHea33ggfViDwJ
	mPtV+OzlluUjZXSBP9P5ZyRFLXCbtO+Vud4eCyK6vrX4YZN6jJrvnd3gcYVvxJoh0NodnytFC53
	dK4nG7KUlY67U0ZIdzYH5F7SmLChy0poXsxlGkwWh1MFLFZ8WVl32Lgrh1jXKZGXz23hxXZiJZw
	Ntdiv99WU3mKplWZoM9ieJkVnkjRcNIEOA==
X-Google-Smtp-Source: AGHT+IHRLnp04vc6YKXoRx+mdTCtI+ZAkC+OOElcWkXvvChgskkGdz5I/O61RVtmKDTCGjeYQargXg==
X-Received: by 2002:a17:902:eccc:b0:215:bf1b:a894 with SMTP id d9443c01a7336-218d70f6be5mr18038445ad.24.1734492281624;
        Tue, 17 Dec 2024 19:24:41 -0800 (PST)
Received: from [192.168.0.78] (133-32-227-190.east.xps.vectant.ne.jp. [133.32.227.190])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-218a1db58b7sm66701245ad.47.2024.12.17.19.24.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Dec 2024 19:24:41 -0800 (PST)
Message-ID: <a9c9ed92-e5fb-4c5a-b8a8-91f5a2e1bea4@pf.is.s.u-tokyo.ac.jp>
Date: Wed, 18 Dec 2024 12:24:37 +0900
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: stmmac: call stmmac_remove_config_dt() in error
 paths in stmmac_probe_config_dt()
To: Krzysztof Kozlowski <krzk@kernel.org>, alexandre.torgue@foss.st.com,
 joabreu@synopsys.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 mcoquelin.stm32@gmail.com
Cc: netdev@vger.kernel.org
References: <20241217033243.3144184-1-joe@pf.is.s.u-tokyo.ac.jp>
 <21d372a2-479a-4ea5-a60a-3693b8f0e8ba@kernel.org>
Content-Language: en-US
From: Joe Hattori <joe@pf.is.s.u-tokyo.ac.jp>
In-Reply-To: <21d372a2-479a-4ea5-a60a-3693b8f0e8ba@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 12/17/24 19:58, Krzysztof Kozlowski wrote:
> On 17/12/2024 04:32, Joe Hattori wrote:
>> Current implementation of stmmac_probe_config_dt() does not release the
>> OF node reference obtained by of_parse_phandle() when stmmac_dt_phy()
>> fails, thus call stmmac_remove_config_dt(). The error_hw_init and
>> error_pclk_get labels can be removed as just calling
>> stmmac_remove_config_dt() suffices. Also, remove the first argument of
>> stmmac_remove_config_dt() as it is not used.
>>
>> This bug was found by an experimental static analysis tool that I am
>> developing.
>>
>> Fixes: 4838a5405028 ("net: stmmac: Fix wrapper drivers not detecting PHY")
>> Signed-off-by: Joe Hattori <joe@pf.is.s.u-tokyo.ac.jp>
>> ---
>>   .../ethernet/stmicro/stmmac/stmmac_platform.c | 37 +++++++------------
>>   1 file changed, 13 insertions(+), 24 deletions(-)
>>
>> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
>> index 3ac32444e492..4f1a9f7aae6e 100644
>> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
>> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
>> @@ -407,13 +407,11 @@ static int stmmac_of_get_mac_mode(struct device_node *np)
>>   
>>   /**
>>    * stmmac_remove_config_dt - undo the effects of stmmac_probe_config_dt()
>> - * @pdev: platform_device structure
>>    * @plat: driver data platform structure
>>    *
>>    * Release resources claimed by stmmac_probe_config_dt().
>>    */
>> -static void stmmac_remove_config_dt(struct platform_device *pdev,
>> -				    struct plat_stmmacenet_data *plat)
>> +static void stmmac_remove_config_dt(struct plat_stmmacenet_data *plat)
>>   {
>>   	clk_disable_unprepare(plat->stmmac_clk);
>>   	clk_disable_unprepare(plat->pclk);
>> @@ -436,7 +434,6 @@ stmmac_probe_config_dt(struct platform_device *pdev, u8 *mac)
>>   	struct plat_stmmacenet_data *plat;
>>   	struct stmmac_dma_cfg *dma_cfg;
>>   	int phy_mode;
>> -	void *ret;
>>   	int rc;
>>   
>>   	plat = devm_kzalloc(&pdev->dev, sizeof(*plat), GFP_KERNEL);
>> @@ -490,8 +487,10 @@ stmmac_probe_config_dt(struct platform_device *pdev, u8 *mac)
>>   		dev_warn(&pdev->dev, "snps,phy-addr property is deprecated\n");
>>   
>>   	rc = stmmac_mdio_setup(plat, np, &pdev->dev);
>> -	if (rc)
>> +	if (rc) {
>> +		stmmac_remove_config_dt(plat);
>>   		return ERR_PTR(rc);
> You now double unprepare the clocks. This is either buggy or just
> confusing (assuming clocks are NULL).

Confusing indeed. Replaced with of_node_put() in the v2 patch.

> 
> Best regards,
> Krzysztof

Best,
Joe

