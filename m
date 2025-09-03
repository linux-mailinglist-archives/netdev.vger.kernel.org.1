Return-Path: <netdev+bounces-219512-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 511C8B41AC5
	for <lists+netdev@lfdr.de>; Wed,  3 Sep 2025 11:56:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 07CD31BA4B2E
	for <lists+netdev@lfdr.de>; Wed,  3 Sep 2025 09:57:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E22512E88B5;
	Wed,  3 Sep 2025 09:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b="RJaQyy+t"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 033EB2E8DFC
	for <netdev@vger.kernel.org>; Wed,  3 Sep 2025 09:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756893238; cv=none; b=AB8yG1z8BD7wN0HIPbTfDIXh19ULT18WHhOKaQd9zWDcG1PYBW7imb7KCoJH4OOwpFkfy3f9SB5Kny6BmnRcsdX4zB4wEipzv2oFtbV6sv0/bFUafWULRK5uK1Tu44bsvD0FUHEjHcPWQ8TnPie8ZMQFYkNr07i41KgXGDbJfkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756893238; c=relaxed/simple;
	bh=UuWs+AQcfzSvQQdbCVIUO6Cvk23u2TuuOA7e50MTg8c=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=TBpmDQUuVLoTcYObE4V/3l5qg85VqPOudl4YwRQJAI38xs3UrTHAXKnVVfh4/y3g5WefS53AixXI+aJcXNSh1IyI9vSFjgYYNrDNnXgrmk0sdBz85kozq15HPl05cM4juvVlDO+pEJ7HZfBfojTf1UrWqjela5Uaet6WjTzmL1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b=RJaQyy+t; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-55f6017004dso5898667e87.0
        for <netdev@vger.kernel.org>; Wed, 03 Sep 2025 02:53:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1756893235; x=1757498035; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=of/TMza8DXLLcw13zP+oJVY9jz+//j+5z/HCt2Y3hqw=;
        b=RJaQyy+td0dFRDZuc22Rn4xSzHSz38KAZPPceV2xS4PnOmtXBVwkpl420IIMpBycAN
         qcxxJlVPR6n+RaemzYd6KPGZw3AhhL3/4NwYMha3s4aR0JyjCW3R6+5ajQ4v34USjLYi
         MUsVnZdMcXRR8CIXPbhARim+vna+qkObdzJ3Vd1+nlu5zIvIkIxg9uQUshW3Y8+X54bt
         gYBaLwSOXUK+9EBJ21okaUaV/OjIGXm7bh5ddnRfDlQjSlELxAyhg0EJg9lpQ0cVmk8X
         /U/z8nKzxu6r/lNNFsVAwT+T9Whxsi6wNeW5w0mbXANTgAgCNNC+AapPe9AVnHrLwHzg
         XR+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756893235; x=1757498035;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=of/TMza8DXLLcw13zP+oJVY9jz+//j+5z/HCt2Y3hqw=;
        b=Mx2rYWwgvzTOWQvfR3oJC1B2mywKeJuyfHaoZh47l7tAs7P/CinhvWRsjJSCYmGvlW
         raUyF8nUz3B/tlZa6LqUJk2/OJCFjjEkhLgtdCK1k5guMpeCVE7BdAMmGRbLCapdFvK+
         So8Oq7nwir8zMgsNxI9qf2TS2AAz9Q92apDk6DUnyckPbMrh4SVXa8XrKXDlZunwQb0W
         ETVVVL1czNZ6AcEDWY/yvGO0w+1h2bLGP1+W4tc4LgOcs34TP82gZ8MENyIdG8e/2rep
         WO4npJBdZ/J3sldSuwj26Al5Y2AljSiBQHDuVsy87f4Ya/pwfS0jyv7eiRX/+x9m4rqk
         CaVg==
X-Gm-Message-State: AOJu0YzfOOQaGzckg8GgTZKiAkapi9ezyv3JeOtnuS4Bk40Ic6Fo0+Is
	HfxQIZCi879grLNPMQtzIWPmvgwjo/BJmqhXHIlmwq02bK7lMm3HHweUOW9i4K3yuSE=
X-Gm-Gg: ASbGncvE8B77FBK6oZHqPjf08O+vu/iI53eFiQnRwMfw92E84AzSvVpPfV4d8dFa1T/
	mgp3GpEPpC7DbDDYc4ZvtaUK9vpfCvj0d9C3EWo0aK8DO+A/BHZlPg+P4FhhirkNx+32RXFrw1o
	k0+VnR0Z/m/sMnS6nl0DrQKeLTKL6mVPgXSaPqovECVec4Vj66IH9DAbh4F0uh/gKCqVE1BI4DG
	uW3fKiC5X1nbmLVF2sLI7oqNS1PTkPh6cqvEw91+xtUP/fZ/4gF2phbKf6LV0ulUnnUQkQ5+scT
	wO0I2VRZBqRG8zyasho1ogweVytrQGvRUdq0PllTsyQI/EReJRjRNjv7mOlnuUIyA0zysXnQ3rk
	kLaRGfD89cCZkMzqp5lXWTgQqHvQX+tF+Zc0+DfiFzF/DqSH/suRifUDB77+O76CHeGE=
X-Google-Smtp-Source: AGHT+IG48x+ooORPlfTQpo60UY/5/CTgUJh9KKBR2i4ALQZzGLl8WyJZYd2JL/ViVeH+1jRNB818Yw==
X-Received: by 2002:a05:6512:4020:b0:55f:5c3f:474 with SMTP id 2adb3069b0e04-55f708b18d2mr4931403e87.16.1756893234703;
        Wed, 03 Sep 2025 02:53:54 -0700 (PDT)
Received: from [100.115.92.205] (176.111.185.210.kyiv.nat.volia.net. [176.111.185.210])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5608acfcd0bsm411249e87.106.2025.09.03.02.53.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Sep 2025 02:53:54 -0700 (PDT)
Message-ID: <8e40b97a-ceeb-4f0a-87cf-801520217916@blackwall.org>
Date: Wed, 3 Sep 2025 12:53:52 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] bonding: Remove support for use_carrier
From: Nikolay Aleksandrov <razor@blackwall.org>
To: Stanislav Fomichev <stfomichev@gmail.com>, Jay Vosburgh <jv@jvosburgh.net>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>, Andrew Lunn <andrew+netdev@lunn.ch>,
 linux-doc@vger.kernel.org
References: <2029487.1756512517@famine> <aLcXNO6ginmuiBOw@mini-arch>
 <810b9e10-9bc5-4fe3-a4a4-f45c6c13b8b4@blackwall.org>
Content-Language: en-US
In-Reply-To: <810b9e10-9bc5-4fe3-a4a4-f45c6c13b8b4@blackwall.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 9/3/25 12:50, Nikolay Aleksandrov wrote:
> On 9/2/25 19:11, Stanislav Fomichev wrote:
>> On 08/29, Jay Vosburgh wrote:
[snip]
>>>       return 0;
>>
>> Acked-by: Stanislav Fomichev <sdf@fomichev.me>
>>
>> nit: any reason not to return -EINVAL here when the new value is not "1"?
>> You do it for the module param, but not for the sysfs file here.
>>
> 
> bond options code already returns EINVAL for values not described in the option's value
> table, after Jay removed "0" from there it should automatically cause -EINVAL to be returned
> 
> 

Still fixing email problems, I see now that this is an old thread.
Please ignore my reply, sorry for the noise!

Cheers,
  Nik

