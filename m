Return-Path: <netdev+bounces-55853-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B8A0C80C856
	for <lists+netdev@lfdr.de>; Mon, 11 Dec 2023 12:43:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 62FB71F21A48
	for <lists+netdev@lfdr.de>; Mon, 11 Dec 2023 11:43:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 402A238DC9;
	Mon, 11 Dec 2023 11:43:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="NxL3aWk+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7456BCD
	for <netdev@vger.kernel.org>; Mon, 11 Dec 2023 03:43:16 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id 5b1f17b1804b1-40c2308faedso45793615e9.1
        for <netdev@vger.kernel.org>; Mon, 11 Dec 2023 03:43:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1702294995; x=1702899795; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3y0kq4Y9j9+Gq82mz3zE9oRqUaOm6ne4gpXolSPF6Tc=;
        b=NxL3aWk+2H9Ev4sgjX3tADiCxIkNKFI4BhJ1UCimUpVebkABifQW5U5WJQvNO3c33+
         LJ+LP26UXa5E8+Mo8F325HfPcXzlKwoXFwPqG9hHf3V9DcvOBe4Zea6LQIqK3TSU92UB
         8iD9ldboyICjnuNbJXG7eKOb510CxDjYzr7dTsLvRkrd3a+GqE5Zngr9Z2YWn2ugLI7J
         8FR7n+qaiwRhCdzkBoU3AFBZhO7Rz8/t5vrn9yycjfWtpwv2VyljplMSxCtvCvSnraSv
         J6sMQgzSzITnHc9USC+Q9oVwkbdlCvuoZOp/C/F3WCRLm+w1bG5R8sjKIyPCOmrFhBgf
         k3+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702294995; x=1702899795;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3y0kq4Y9j9+Gq82mz3zE9oRqUaOm6ne4gpXolSPF6Tc=;
        b=mCGmVuKQxi72zi7mqiPVwWelnblWo+BbXUzQQl5486ITpB5XnBRDmwEJ1jDgeirK3o
         ouXWI/cigcLwHvT6wpg+XXeo6zdbO/MG5Jj7iaWwXh2Z6Z7GIYxC1qdvcMisUWTybAXE
         XMsI1PRFN3dZT0LU6szs4VEjbxQr+gF/lk/HlRc/PY+BHvRmn40DfzypcQeZio3aORhV
         wcbHtvwvtbFc7ORe8PEjIyTt/CAQQhYRSowa+hYzRi74OBZjfZWbrjQa0Q9j7uEODjhT
         jWVEvOdTuNI7CdxRhegeNIZH0BJUQnKL2fxuiHZYEiVs93jTaUa3RhdgT85972gYr7iQ
         awUg==
X-Gm-Message-State: AOJu0YynwSzsOzSWc6ZeTKlQ2GM0M8ZdZBR/m3f3UkFxP1XddyVI4/Ah
	K1wEM1/00gof8SSOtxNVEwu7LA==
X-Google-Smtp-Source: AGHT+IEmhJRZ+2KZJzdx5PPpTiqIF7maLKL58Ye16KBsTxCp+BEvFtHhr+NukzH1AGGzWPtKUhFFZg==
X-Received: by 2002:a05:600c:1827:b0:40c:3828:b8cb with SMTP id n39-20020a05600c182700b0040c3828b8cbmr1887693wmp.101.1702294994792;
        Mon, 11 Dec 2023 03:43:14 -0800 (PST)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id i1-20020a05600c354100b0040c411da99csm7258697wmq.48.2023.12.11.03.43.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Dec 2023 03:43:14 -0800 (PST)
Date: Mon, 11 Dec 2023 12:43:13 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>
Cc: netdev@vger.kernel.org, kuba@kernel.org, pabeni@redhat.com,
	davem@davemloft.net, edumazet@google.com,
	arkadiusz.kubalewski@intel.com, gregkh@linuxfoundation.org,
	hdthky0@gmail.com, michal.michalik@intel.com,
	milena.olech@intel.com
Subject: Re: [patch net] dpll: sanitize possible null pointer dereference in
 dpll_pin_parent_pin_set()
Message-ID: <ZXb10Wdef76u2xBy@nanopsycho>
References: <20231211083758.1082853-1-jiri@resnulli.us>
 <ffd827e6-95ed-4d96-b5ad-ec1f5b8d4e24@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ffd827e6-95ed-4d96-b5ad-ec1f5b8d4e24@linux.dev>

Mon, Dec 11, 2023 at 11:46:24AM CET, vadim.fedorenko@linux.dev wrote:
>On 11/12/2023 08:37, Jiri Pirko wrote:
>> From: Jiri Pirko <jiri@nvidia.com>
>> 
>> User may not pass DPLL_A_PIN_STATE attribute in the pin set operation
>> message. Sanitize that by checking if the attr pointer is not null
>> and process the passed state attribute value only in that case.
>> 
>> Reported-by: Xingyuan Mo <hdthky0@gmail.com>
>> Fixes: 9d71b54b65b1 ("dpll: netlink: Add DPLL framework base functions")
>> Signed-off-by: Jiri Pirko <jiri@nvidia.com>
>> ---
>>   drivers/dpll/dpll_netlink.c | 13 ++++++++-----
>>   1 file changed, 8 insertions(+), 5 deletions(-)
>> 
>> diff --git a/drivers/dpll/dpll_netlink.c b/drivers/dpll/dpll_netlink.c
>> index 442a0ebeb953..ce7cf736f020 100644
>> --- a/drivers/dpll/dpll_netlink.c
>> +++ b/drivers/dpll/dpll_netlink.c
>> @@ -925,7 +925,6 @@ dpll_pin_parent_pin_set(struct dpll_pin *pin, struct nlattr *parent_nest,
>>   			struct netlink_ext_ack *extack)
>>   {
>>   	struct nlattr *tb[DPLL_A_PIN_MAX + 1];
>> -	enum dpll_pin_state state;
>>   	u32 ppin_idx;
>>   	int ret;
>> @@ -936,10 +935,14 @@ dpll_pin_parent_pin_set(struct dpll_pin *pin, struct nlattr *parent_nest,
>>   		return -EINVAL;
>>   	}
>>   	ppin_idx = nla_get_u32(tb[DPLL_A_PIN_PARENT_ID]);
>> -	state = nla_get_u32(tb[DPLL_A_PIN_STATE]);
>> -	ret = dpll_pin_on_pin_state_set(pin, ppin_idx, state, extack);
>> -	if (ret)
>> -		return ret;
>> +
>> +	if (tb[DPLL_A_PIN_STATE]) {
>> +		enum dpll_pin_state state = nla_get_u32(tb[DPLL_A_PIN_STATE]);
>> +
>> +		ret = dpll_pin_on_pin_state_set(pin, ppin_idx, state, extack);
>> +		if (ret)
>> +			return ret;
>> +	}
>>   	return 0;
>>   }
>
>I don't believe that "set" command without set value should return 0
>meaning "request was completed successfully". Maybe it's better to add
>another check like for DPLL_A_PIN_PARENT_ID and fill extack with
>description?

Please see dpll_pin_parent_device_set(). State here is treated exactly
the same as there. It makes sense during set operation to process only
the attributes that are passed. In the future, dpll_pin_parent_pin_set()
can process more attributes, lets be prepared for that.

