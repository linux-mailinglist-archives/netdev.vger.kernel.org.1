Return-Path: <netdev+bounces-152781-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E6C389F5C43
	for <lists+netdev@lfdr.de>; Wed, 18 Dec 2024 02:32:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B775F189387A
	for <lists+netdev@lfdr.de>; Wed, 18 Dec 2024 01:32:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBB908488;
	Wed, 18 Dec 2024 01:31:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pf-is-s-u-tokyo-ac-jp.20230601.gappssmtp.com header.i=@pf-is-s-u-tokyo-ac-jp.20230601.gappssmtp.com header.b="SAcdoXk7"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4030A43AA1
	for <netdev@vger.kernel.org>; Wed, 18 Dec 2024 01:31:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734485517; cv=none; b=OvgaeZkfZNpNUYi/OaSxj87kusScwYuxje+iFIVCtkv/snhVmwbOtrTZQROoDhZ5GfOnDtkjH4/2zgk+vlLQPGx/ysYopoC4+aXOEnzbynsjRdrEH9tTl/aLPeiwGrdze4lL8qAO4fbqK99XeU+zgfeR9+x5zjbPnPgcj+W6EDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734485517; c=relaxed/simple;
	bh=N6Vvajl+oa0WsuHfUUs1LoOvtyG2tzUMBqe4oNcc6I0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=U/JavgX6+WcjCGRgKTy9GZI3hAnLEBClByuxMqcndzF5hpo4LIHd6rxhRJ9YOmtM081088jqsnOq9bNrrkdsphKgRXZs1tluQRuREIkYOxM0aMhyGPUldq3fNDIjPj1BmThEayVYPCbXyvmOuYNWGf6DguhQpavvQGQiViKOqMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=pf.is.s.u-tokyo.ac.jp; spf=none smtp.mailfrom=pf.is.s.u-tokyo.ac.jp; dkim=pass (2048-bit key) header.d=pf-is-s-u-tokyo-ac-jp.20230601.gappssmtp.com header.i=@pf-is-s-u-tokyo-ac-jp.20230601.gappssmtp.com header.b=SAcdoXk7; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=pf.is.s.u-tokyo.ac.jp
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=pf.is.s.u-tokyo.ac.jp
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-728f1e66418so5206930b3a.2
        for <netdev@vger.kernel.org>; Tue, 17 Dec 2024 17:31:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pf-is-s-u-tokyo-ac-jp.20230601.gappssmtp.com; s=20230601; t=1734485515; x=1735090315; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1oi2Jo+n0V6wRkCe08ndkAFFPVBm957BLpSxaXcLCNY=;
        b=SAcdoXk7pu99pabSncSMSqL84C3otE5WheiKafPN+mqGG+eBRuSj62ZliIiE1tv8dx
         B8vb7TP41WcqFzIqKp2x4agKDkRz3AJk3xkwIvHCCrGNs+sMOpdWL11JciFVlUn/gBC2
         Hh+kQLG3tRxAVhT5A6q3hcvCzhFRafyPd9NI5zC+EgaUsaUsshsYdAf/sjQN9y6dPzqC
         Y12gHAn8mvmPEaLzIj0slf1AhHqKQaE7ilNrLSVFUu/w5PB994mEvLUsufWoW6QBMsbs
         6JaohqbEYK1M8unsEnT/I246eVgXIM65kbWA+/iMYSqzmEhfwV6o8tCWARFbr+3ulE4a
         x5/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734485515; x=1735090315;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1oi2Jo+n0V6wRkCe08ndkAFFPVBm957BLpSxaXcLCNY=;
        b=Zw9rbdz5Qswj+5PAQL8NXF7+/xzUGLa0q3TXmkuu1RKtm+ClUqUmAFhzboLCvpdeC1
         CuJcbFWw71QHIMk59ER0ZbIw6GEMqOaw7eiiCc0JTTzZubLdvqVXx/S/8dHa21pnizNp
         Z1du8b5dsjHhDys5UY9zEF+gtYMwFkYEoSkWcx0sgbYgTT+q2kibHvZdYjQY1jSIqW/c
         M9Gt/klmbyhhHREcnvxl2bMEUv1nfdtghhY5tuMOko65OcTg2LWtqcAJ/sQhyTkea2vf
         VvY5FOfTxhFk+gUWQx81K44vY/A5AT6Ncn2x10FoGeLWjTesDG2ff5udpHcetiPbgIaj
         B6NA==
X-Forwarded-Encrypted: i=1; AJvYcCWpC/NMpMiKPW6OlJk0kiE8Xo6T2wj8MOnJTTHO+bvcYZBklumnO2lf407oKzCZNhLBYuUpaJY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwKbd4k9MvWvXcIs+e/U9/LSiHJrNj4FAmLz09ENYag8fnhlB8q
	YnH/I0jXLKYz1qJMXsjINpmP7O/ZdMtsopZVrSNT+vdneKJbRaPn7yljwE5GJj4=
X-Gm-Gg: ASbGncsuKfWJU3ArqJ/xGtN9DJGFqTcaoDTx9MEkS4cOcSkK82oNDIO5gz1CdNoK6XV
	Sl9UiiZeesNcrooky6G73+D60A1YfPFNP4Ebeu2FGQV6WyvUCI/u8fdh/S1lFhs8KevHJsTn2lz
	Gqd1h1o+H+zlCNI+q3uNn9Io8xU+27iaysP7kfkr6UITLrtOhPTYbuHh5X/j6I0awkFC+rPh5MQ
	d3AdySguSZWC1KmJHJ+s6q5p+19PuB1b8c0mW5U1Bghn5pdfEgSKH/Xl307GtmSmqCPbprGHK2Q
	E84O0Pf1bTZTzZMWpLbNheIK7MW//iAvpQ==
X-Google-Smtp-Source: AGHT+IFf6G/aieiUi74w9thKnG7a7vJNVsCdXvVlYZZwX4aZvNqv9KDpEKjj7BBMiIhqwYoWL62HCA==
X-Received: by 2002:a05:6a21:1013:b0:1dc:c19c:b7b0 with SMTP id adf61e73a8af0-1e5b487dfbbmr2034977637.33.1734485515625;
        Tue, 17 Dec 2024 17:31:55 -0800 (PST)
Received: from [192.168.0.78] (133-32-227-190.east.xps.vectant.ne.jp. [133.32.227.190])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-801d5c0f5fdsm6475200a12.54.2024.12.17.17.31.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Dec 2024 17:31:55 -0800 (PST)
Message-ID: <880c2948-2dbc-4e13-a936-01027ebdd5ea@pf.is.s.u-tokyo.ac.jp>
Date: Wed, 18 Dec 2024 10:31:51 +0900
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] net: mv643xx_eth: fix an OF node reference leak
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: sebastian.hesselbarth@gmail.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, netdev@vger.kernel.org
References: <20241216042247.492287-1-joe@pf.is.s.u-tokyo.ac.jp>
 <d507355d-64b9-4aab-9614-de7339118412@stanley.mountain>
Content-Language: en-US
From: Joe Hattori <joe@pf.is.s.u-tokyo.ac.jp>
In-Reply-To: <d507355d-64b9-4aab-9614-de7339118412@stanley.mountain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Thank you for your review.

On 12/17/24 23:05, Dan Carpenter wrote:
> On Mon, Dec 16, 2024 at 01:22:47PM +0900, Joe Hattori wrote:
>> Current implementation of mv643xx_eth_shared_of_add_port() calls
>> of_parse_phandle(), but does not release the refcount on error. Call
>> of_node_put() in the error path and in mv643xx_eth_shared_of_remove().
>>
>> This bug was found by an experimental static analysis tool that I am
>> developing.
>>
>> Fixes: 76723bca2802 ("net: mv643xx_eth: add DT parsing support")
>> Signed-off-by: Joe Hattori <joe@pf.is.s.u-tokyo.ac.jp>
>> ---
>> Changes in v2:
>> - Insert a null check before accessing the platform data.
>> ---
>>   drivers/net/ethernet/marvell/mv643xx_eth.c | 12 ++++++++++--
>>   1 file changed, 10 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/net/ethernet/marvell/mv643xx_eth.c b/drivers/net/ethernet/marvell/mv643xx_eth.c
>> index a06048719e84..917ff7bd43d4 100644
>> --- a/drivers/net/ethernet/marvell/mv643xx_eth.c
>> +++ b/drivers/net/ethernet/marvell/mv643xx_eth.c
>> @@ -2705,8 +2705,12 @@ static struct platform_device *port_platdev[3];
>>   static void mv643xx_eth_shared_of_remove(void)
>>   {
>>   	int n;
>> +	struct mv643xx_eth_platform_data *pd;
>>   
>>   	for (n = 0; n < 3; n++) {
>> +		pd = dev_get_platdata(&port_platdev[n]->dev);
> 
> You need another NULL check here.  port_platdev[n] can be NULL so
> &port_platdev[n]->dev is NULL + 16.  The call to dev_get_platdata()
> will crash.

Yes, should have realized that. Addressed in the v3 patch.

> 
>> +		if (pd)
>> +			of_node_put(pd->phy_node);
>>   		platform_device_del(port_platdev[n]);
>>   		port_platdev[n] = NULL;
>>   	}
> 
> regards,
> dan carpenter
> 

Best,
Joe

