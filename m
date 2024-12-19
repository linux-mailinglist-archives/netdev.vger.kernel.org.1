Return-Path: <netdev+bounces-153209-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E13E9F72EC
	for <lists+netdev@lfdr.de>; Thu, 19 Dec 2024 03:48:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C42A718919D0
	for <lists+netdev@lfdr.de>; Thu, 19 Dec 2024 02:48:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 103AB19CCFC;
	Thu, 19 Dec 2024 02:45:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pf-is-s-u-tokyo-ac-jp.20230601.gappssmtp.com header.i=@pf-is-s-u-tokyo-ac-jp.20230601.gappssmtp.com header.b="Vs+z9euw"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44D8B1A08AB
	for <netdev@vger.kernel.org>; Thu, 19 Dec 2024 02:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734576316; cv=none; b=onP2p5iVb7OtRAMfb3CtphaZXe3Rj5rehJBdvK1Ss646+KlM+qMLGqTYQNFM8/WxcxX5xesk8wD/CZ0nq6Gt3jYtxESs0kTto0Pd3Z4qDGJdkqV4CfvUx8jIWq2lZgZmx9e87SlLwTR6PrmjM2n1KiXT3ZWWapx5VjuAxIVALHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734576316; c=relaxed/simple;
	bh=7nE/DZd+VvX5ql005KnLMmiVJsrJVGRc/IsExM2yK+Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BZlPO+iI/iYz6vCklns/th7lJKuFNQ85Qeo3UDzEbwJ/Nz9GUwM4hQB0KlJipej6hnYnzTO7E3tCbA4dgZCwUM4+gZNjdbC/VGfBHDZXuMW478J1Q1YL+Cvsg4DdbYNJ5U2wrTmEvBI1WFIWV85bDnS10VhhG6DTsxINmnrI2HE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=pf.is.s.u-tokyo.ac.jp; spf=none smtp.mailfrom=pf.is.s.u-tokyo.ac.jp; dkim=pass (2048-bit key) header.d=pf-is-s-u-tokyo-ac-jp.20230601.gappssmtp.com header.i=@pf-is-s-u-tokyo-ac-jp.20230601.gappssmtp.com header.b=Vs+z9euw; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=pf.is.s.u-tokyo.ac.jp
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=pf.is.s.u-tokyo.ac.jp
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2162c0f6a39so13403665ad.0
        for <netdev@vger.kernel.org>; Wed, 18 Dec 2024 18:45:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pf-is-s-u-tokyo-ac-jp.20230601.gappssmtp.com; s=20230601; t=1734576313; x=1735181113; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Xxy2sCOd6xbwwSm2GfIGcxkKT6K343P7sAr1rln3IhM=;
        b=Vs+z9euwxIRSos7RIFpwd9Q854dGJqrzavPo22YDCO5uskt2nq6FSsRdcPWEDMIQo5
         pbtO/cE2SMIW5MYCN/fk3WbxBiiUiQ02BDfpHYzopIUswuaqSz2JqyEGPtSH3mGXhN84
         5Y6vogxupqD8IRiI0VqZkMNcIH7n2sv8y+NkWG+txVsWBull32/FDjs7rOYIF7kTY7Kc
         3q5YE8loipTdCR+cgJMRe0HlHW6HnjClCZGBf7/n+ebFQt5j1k16j6qcQlyJwrmqS4Tf
         lbOmXmVz6oZUDZDZxgLA45Jrr8oBvY4Ja7+YfviQPD7tFwmp7Z34nQGgAtqc8WlKQfF3
         FHpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734576313; x=1735181113;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Xxy2sCOd6xbwwSm2GfIGcxkKT6K343P7sAr1rln3IhM=;
        b=rlw9VqBcheKc0pteZaB9p8WUlwfTvhdLw0pPa6jpAj+e0m3k+UFLare2RQRW8TuIaf
         I+VVOkDDcyGc/xl3azO1HzxoTPK1FY7xD8NpqDEEJIO7Fq4MceBVT5Y8Od9mgELLwYAO
         wUhynLsw7Q6mBf0p0AvwuisEjwdIyOxi7Fo/DXZscHlQF5QYauFUIvsy2HddEdlUveYS
         R+VGDZczfk9Yb1qEtDPFvL+tqFmpIfcb2SlqCKUrQlCYdD393kblSh7B0+5nW07j+ghz
         aIDQtNxMC+hFdSlaQLKXXLxfcxYmiV0HNXHOlMPO/1nvZNXS+sAvBXgtr3smMGNYz4hE
         1P5w==
X-Forwarded-Encrypted: i=1; AJvYcCWvo6YDGpHR+uQdeTS6p9DB9jZbcUQCYU/gslAjp6qUSPu7WE21tDvXbjsh6TVqIDHGBXomfs4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxKyhO/e7c79lQqhz7z/aG9SQiTzpjRrIHBoc5rxaRJ9dgWVM04
	00UgQue4r0iygVS8ZxGlSTBKGjDqj6YcAERe+flMXyYXAtFp8tYq0Bzn24gJ+pk=
X-Gm-Gg: ASbGncsHLtRP+YCTbwSl7i8wjXVDqWp3ciVXxSG2N5Q8yLUn8Ra4HnRAX0Xsodet6Q+
	18cbTIEluaIaQBMyj8IfSupntmz6U+oZd/cwJEJgHCX4bvhRQ4WjNbp65RKmD1MlHguuLfNqWYt
	cEhXt29aPQEduwQi5Kn9B/kjasTOtHl0kQgvI6pYbty5vC5GIIs9DqnGlulMQBIU9f3BjwXMUfy
	yIJMz/H9SLvBo3W6a/WYX8cxRu5jnL14GB6cx1qYSJ2/7XJ6lE5FZX0TqUgaOq19u/WzzLoAFwo
	lNLGzwzWJMsrzPl+9kyJdKPH91tjOH3Lcg==
X-Google-Smtp-Source: AGHT+IH5ZHT8neOngLSpjI6Q1a25ZkHtYJm5O0g0EkNps3AQXYO2jCOLm2GYcoMxZxkzJXTOUR9D1w==
X-Received: by 2002:a17:902:e88d:b0:215:b18d:ca with SMTP id d9443c01a7336-219da7ef978mr22971525ad.18.1734576313564;
        Wed, 18 Dec 2024 18:45:13 -0800 (PST)
Received: from [192.168.0.78] (133-32-227-190.east.xps.vectant.ne.jp. [133.32.227.190])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-842dc604e58sm145616a12.60.2024.12.18.18.45.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Dec 2024 18:45:13 -0800 (PST)
Message-ID: <184e2953-c5db-4d53-9d64-e81bd433a02a@pf.is.s.u-tokyo.ac.jp>
Date: Thu, 19 Dec 2024 11:45:09 +0900
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] net: stmmac: call of_node_put() and
 stmmac_remove_config_dt() in error paths in stmmac_probe_config_dt()
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: alexandre.torgue@foss.st.com, joabreu@synopsys.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, mcoquelin.stm32@gmail.com,
 krzk@kernel.org, netdev@vger.kernel.org
References: <20241218032230.117453-1-joe@pf.is.s.u-tokyo.ac.jp>
 <20241218032230.117453-2-joe@pf.is.s.u-tokyo.ac.jp>
 <50d126f4-e87a-4502-8a9b-7291d0143ed6@stanley.mountain>
Content-Language: en-US
From: Joe Hattori <joe@pf.is.s.u-tokyo.ac.jp>
In-Reply-To: <50d126f4-e87a-4502-8a9b-7291d0143ed6@stanley.mountain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Thank you for your review.

On 12/18/24 17:43, Dan Carpenter wrote:
> The subject is too long.
> 
> On Wed, Dec 18, 2024 at 12:22:29PM +0900, Joe Hattori wrote:
>>   	plat->stmmac_ahb_rst = devm_reset_control_get_optional_shared(
>>   							&pdev->dev, "ahb");
>>   	if (IS_ERR(plat->stmmac_ahb_rst)) {
>> -		ret = plat->stmmac_ahb_rst;
>> -		goto error_hw_init;
>> +		stmmac_remove_config_dt(pdev, plat);
>> +		return ERR_CAST(plat->stmmac_ahb_rst);
>>   	}
>>   
>>   	return plat;
>> -
>> -error_hw_init:
>> -	clk_disable_unprepare(plat->pclk);
>> -error_pclk_get:
>> -	clk_disable_unprepare(plat->stmmac_clk);
>> -
>> -	return ret;
> 
> Ah...  This is a bug fix, but it's not fixed in the right way.
> 
> These labels at the end of the function are called an unwind ladder.
> This is where people mostly expect the error handling to be done.  Don't
> get rid of the unwind ladder, but instead add the calls to:
> 
> error_put_phy:
> 	of_node_put(plat->phy_node);
> error_put_mdio:
> 	of_node_put(plat->mdio_node);
> 
> The original code had some code paths which called
> stmmac_remove_config_dt().  Get rid of that.  Everything should use the
> unwind ladder.  This business of mixing error handling styles is what led
> to this bug.
> 
> Calling a function to cleanup "everything" doesn't work because we keep
> adding more stuff so it starts out as "everything" today but tomorrow
> it's a leak.

Yes, it really makes sense. Switched to the unwind ladder in v3 patch.

> 
> This can all be sent as one patch if you describe it in the right way.
> 
>      The error handling in stmmac_probe_config_dt() has some
>      error paths which don't call of_node_put().  The problem is
>      that some error paths call stmmac_remove_config_dt() to
>      clean up but others use and unwind ladder.  These two types
>      of error handling have not kept in sync and have been a
>      recurring source of bugs.  Re-write the error handling in
>      stmmac_probe_config_dt() to use an unwind ladder.

Thank you for the suggestion. Now the v3 is a single patch, and your 
commit message has been applied to it.

> 
> regards,
> dan carpenter
> 

Best,
Joe

