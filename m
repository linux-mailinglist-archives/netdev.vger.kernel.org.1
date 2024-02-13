Return-Path: <netdev+bounces-71507-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 21FDD853A4F
	for <lists+netdev@lfdr.de>; Tue, 13 Feb 2024 19:55:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C939A1F230DD
	for <lists+netdev@lfdr.de>; Tue, 13 Feb 2024 18:55:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE6C210A29;
	Tue, 13 Feb 2024 18:55:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="P+V0Ex2r"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5C781F92C
	for <netdev@vger.kernel.org>; Tue, 13 Feb 2024 18:55:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707850530; cv=none; b=X3NzLP/dB55SuOk5V57LVXRKulL3RaW+9A2IqZsu2OeQ/AYCxmOTP8CAc7SCmXvUV7q5h/08GASY/DPiMlRYSLxmHWqfLW7YS79bSAErO2uK8tzEu9yg7uG1ylwKT1yhTHcq2VOLmZfZf1bfSfC0/dq2d7Nph7vV+HtWXribQTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707850530; c=relaxed/simple;
	bh=81ioBMQoFUAXfD3calqbogWeHqxzR5ypL2hOiBSpVRI=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=EcSi+Q0X0CvsVswagOjPwQ0NReTvCv1lt5Q4naJte1pTq/oPGhPSqRiePIp22oUPhdA8QN2Anv2ruMq+9U/bptUn28AnCIqmbXYHqfXm7D40oqMI7zz1blZ+hbnsLuOv5QF1Pd0s+cH2p+Tl45v5Nxi349H9Q0Gt6XpUz0b5iGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=P+V0Ex2r; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-339289fead2so3051231f8f.3
        for <netdev@vger.kernel.org>; Tue, 13 Feb 2024 10:55:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1707850527; x=1708455327; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pMhzu1S70tXsjq/n2IaXdigXH/qhRAWmzHR2uq8cwRE=;
        b=P+V0Ex2r63IyKVy83Q1cz5G+SPepQWJ1IBN3Iyk5aKvkm9vKkCo/YkzGewVKOu8AB5
         7Y2v0GOiFTRAWDOHbp0fzgiVTYPhAE37KkuO3pnQDsj+gcp7Km05nkbEAZ1WPk4Dwiyk
         eXQ1yTHfuD3Y5GnwRayJTmCU9HxmbZWf/R672gScGpIdFgIyyrfccEVVG59vp/e5W1df
         ky3qzpc7pze57l/lmuatJAOpTyw0CWkPEd+RyOIHfJfT0rifftLlh0btSJ50LCW+d4JA
         Ade5FUh9AL/Og2N8zzI7/7CmKSCreHE9TwDA4PnUBQu5B0DzPkZMpANphUBnfylU+8tp
         YAsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707850527; x=1708455327;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pMhzu1S70tXsjq/n2IaXdigXH/qhRAWmzHR2uq8cwRE=;
        b=pbq4y4dMF1se1wSM71LToGRn3qcVQDnNodr/n4hFY9O8ykRHoM8wpzmchu/R9H+EZ6
         FtpYkDutuIOoQq3L6OFQU3ZPVUCYTCeWHincwO0pqghdRocDKJ1Xh2NXDFBA62G7yPYY
         pBkUatNXk2f3p9Z0OqCNwWIO53YcUb2NlQAXgWqg2zgBD0XlLGR/vVE7L4bCFqH+5YPL
         9fJLmLU6X91Z20zZbTVbr11hdnQ6dEtEeriRVTYvd8J0KJeIFBeAXCW+iFXJoUNG4Ng6
         S7nDIeeel3ygSNuBanM9PSf8PLPGnDNb6Q6FRH8RnOFcfFGoeTSNVOYsPgzFpDpO0V/H
         fRdg==
X-Gm-Message-State: AOJu0YyEY74GfUhvLqKfG10JuW+zLORV/y02nPI0y1a2P1pRjyZvulbC
	oLuNOeOG4WoUezFQOIJZmQmzP2WCPjRQLe/xuu4hkakA4fqt2OorCE4kESwD/jo=
X-Google-Smtp-Source: AGHT+IHFG/RqIE1RwioshOK/wI0T4+BUE1u2eq0hHtaw4GiuFnXb6C8GBu6DM2PWTQssET9fWT4VrQ==
X-Received: by 2002:a5d:4eca:0:b0:33c:e30e:cdbf with SMTP id s10-20020a5d4eca000000b0033ce30ecdbfmr156391wrv.32.1707850526649;
        Tue, 13 Feb 2024 10:55:26 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVbZFjo6U0l4qHSR2B3l08IWRcDmD7J0fP1JWVlRiF7e4jEIcgogqfuF8OLdiYCme/QnUASSv/ScThqp8Bwxe4eY8uWu1931lUCgvMXPTAqHESBRBS3kLnWsV6B/fmdzPBmH0TdsgnLs3e/WvENTd8U06dUB1xdI2CYDyCTO3GjDUmdJ+8RkRehQCORmuPZ0LHX0E6xq7rwkyVk1qaO19z5P7RQfnqQkF7UFp7aKT7JCDXGQCrkp8A7ayRy4ceSxhjsygicQ7iH4euN7cLleXpi6wOluKgG1CUoLhNR5gc+bgLdJnDwZm4DIn6Pdc6cDsXWwI800FYFSHHl4MZTaUK9ejBq2k601Enu0fP+
Received: from [192.168.50.4] ([82.78.167.20])
        by smtp.gmail.com with ESMTPSA id p31-20020a05600c1d9f00b00411a595d56bsm4292075wms.14.2024.02.13.10.55.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Feb 2024 10:55:26 -0800 (PST)
Message-ID: <81ca7397-3f00-431d-aea4-c30c363a90e6@tuxon.dev>
Date: Tue, 13 Feb 2024 20:55:24 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 5/6] net: ravb: Do not apply features to
 hardware if the interface is down
Content-Language: en-US
From: claudiu beznea <claudiu.beznea@tuxon.dev>
To: Biju Das <biju.das.jz@bp.renesas.com>,
 "s.shtylyov@omp.ru" <s.shtylyov@omp.ru>,
 "davem@davemloft.net" <davem@davemloft.net>,
 "edumazet@google.com" <edumazet@google.com>,
 "kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
References: <20240213094110.853155-1-claudiu.beznea.uj@bp.renesas.com>
 <20240213094110.853155-6-claudiu.beznea.uj@bp.renesas.com>
 <TYCPR01MB112698DE07AAA9C535776805D864F2@TYCPR01MB11269.jpnprd01.prod.outlook.com>
 <368ca0a8-a005-4371-a959-297fd4f58cb1@tuxon.dev>
In-Reply-To: <368ca0a8-a005-4371-a959-297fd4f58cb1@tuxon.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 13.02.2024 13:07, claudiu beznea wrote:
>>> @@ -2566,15 +2566,23 @@ static int ravb_set_features(struct net_device
>>> *ndev,  {
>>>  	struct ravb_private *priv = netdev_priv(ndev);
>>>  	const struct ravb_hw_info *info = priv->info;
>>> -	int ret;
>>> +	struct device *dev = &priv->pdev->dev;
>>> +	int ret = 0;
>>> +
>>> +	pm_runtime_get_noresume(dev);
>>> +
>>> +	if (!pm_runtime_active(dev))
>>> +		goto out_set_features;
>> This can be simplified, which avoids 1 goto statement and
>> Unnecessary ret initialization. I am leaving to you and Sergey.
>>
>> 	if (!pm_runtime_active(dev))
>> 		ret = 0;
>> 	else
>> 		ret = info->set_feature(ndev, features);
>>
>> 	pm_runtime_put_noidle(dev);
>> 	if (ret)
>> 		goto err;
>>
>> 	ndev->features = features;
>>
>> err:
>> 	return ret;
>>
> I find it a bit difficult to follow this way.

Looking again at it, your version seems better.

