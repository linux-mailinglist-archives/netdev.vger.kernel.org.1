Return-Path: <netdev+bounces-119136-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C9D1A9544E2
	for <lists+netdev@lfdr.de>; Fri, 16 Aug 2024 10:53:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 66A48B210C1
	for <lists+netdev@lfdr.de>; Fri, 16 Aug 2024 08:53:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9406713B286;
	Fri, 16 Aug 2024 08:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MvLM91NB"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 186D320E3
	for <netdev@vger.kernel.org>; Fri, 16 Aug 2024 08:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723798387; cv=none; b=Er2kOPetE1To/wWTYCW0xaIBTf0KGYuqXEDzjaX7KY7A8dVt3uL+xqUlOmiX/Hjh6fF+C5W/SGTqdPt2lgqCqKhnLMtlaXL9lMIohrM5jLvQ/BN7mIRYwIOxamc3rCd0TVho43laK0dj5lVZZWTkRwYuq+GccIz7K4BQhAbjIuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723798387; c=relaxed/simple;
	bh=C3ob2MWZ3738p2ZEM60khYNON0etiXA/vFERvLF5kZA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=urzxqxySj//h/pB/Fz71vOnvAH/L91JVfIdHwh50DUltAdeO2pZSwvS4QWB11fGSI2UFGgk5pHPPf0599jLwYYGoAiOrNctMceb++AUU0y49W5NT/SBhojZsFN4zP/TJFG0V/KTAfbZQV+yaPAYs3uAka+GsMv6g35YWL4apUIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MvLM91NB; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1723798385;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pV+HA2ofcxI3jpsz2oHleqpP+QHPiwJOmoe0od4xFQY=;
	b=MvLM91NBm6rUehIPZ8MDOs8HW9lrSMXTqlJGoZHUvmibKhFI71T00ubWHL+iLjOdZHMGaJ
	MKuPkvI82SX36W/2khv/v8A9lJa0qvIjwZTZOu1K3rNT6GQUxHdbrrAQM7QB8u1zksE8d2
	oJeqf1wBzIz/ABwW4yWwSIFi/41D/0k=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-416-DvCHMjtsOQecIaXVXeEkBg-1; Fri, 16 Aug 2024 04:53:02 -0400
X-MC-Unique: DvCHMjtsOQecIaXVXeEkBg-1
Received: by mail-lf1-f72.google.com with SMTP id 2adb3069b0e04-52eff9a3109so321950e87.1
        for <netdev@vger.kernel.org>; Fri, 16 Aug 2024 01:53:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723798381; x=1724403181;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pV+HA2ofcxI3jpsz2oHleqpP+QHPiwJOmoe0od4xFQY=;
        b=F18AWLZwBuplObvXK4ugG1DXNp+in0RgsbVM5hNLpK7YNsqdUgovanOVLW++xcu+vq
         TIaBQa3PHwQdl9sWULc3zIlTKli1mVuWO19qwoA1W6R97Ty35hgHc0zHo2ydxWNgCthL
         fvrSFIU1UqVsEZ8ssAm86eh3Zal5Wb5lMvd2dc/+Zsn6zdWwoXgflUL5yBA61fGJhizG
         Jpp7M7UQlSsA8vWAx8PxU5M4jxmLLOpiKj4aEAlAoDED+Te87+BgmPZAJ2K1Y38IBulN
         ypY3wVXRJvhv0a6HZjihIbZ/EaKx0cAEpZQmLjCFpZCtWkZ4eBeuauiPlBO0xuaZkTBW
         qw4g==
X-Gm-Message-State: AOJu0Yw+MhrbrIrLSmi7X0RLUmPNdbP6UFUsaxyQzgSWJ4EZaFePGf3/
	oT0v12ALxmGdua2eDw7ldMqdc/EXeI5Lav0r2a0L+/4kjnynOq49qfasYwdnKtLNcvd5a/L7Np2
	p1EkR3mlV8EXrJoV+/h6WFBybAH//DWsxPzjTsAbhV0gmoQgiQwd8dQ==
X-Received: by 2002:a05:651c:1504:b0:2f1:75f4:a6c1 with SMTP id 38308e7fff4ca-2f3be6f3727mr7600191fa.3.1723798381275;
        Fri, 16 Aug 2024 01:53:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHfKWc5gCqwJR+Egk5e1EC7+Q0IY/RDRYX5FnDjfICzI4B4EKBcIPSrGtaZ1osMwWsCPW7Gng==
X-Received: by 2002:a05:651c:1504:b0:2f1:75f4:a6c1 with SMTP id 38308e7fff4ca-2f3be6f3727mr7600031fa.3.1723798380668;
        Fri, 16 Aug 2024 01:53:00 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:1711:4010::f71? ([2a0d:3344:1711:4010::f71])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-371898497f0sm3156763f8f.39.2024.08.16.01.52.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Aug 2024 01:53:00 -0700 (PDT)
Message-ID: <f320213f-7b1a-4a7b-9e0c-94168ca187db@redhat.com>
Date: Fri, 16 Aug 2024 10:52:58 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 03/12] net-shapers: implement NL get operation
To: Jiri Pirko <jiri@resnulli.us>
Cc: netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>,
 Madhu Chittim <madhu.chittim@intel.com>,
 Sridhar Samudrala <sridhar.samudrala@intel.com>,
 Simon Horman <horms@kernel.org>, John Fastabend <john.fastabend@gmail.com>,
 Sunil Kovvuri Goutham <sgoutham@marvell.com>,
 Jamal Hadi Salim <jhs@mojatatu.com>
References: <cover.1722357745.git.pabeni@redhat.com>
 <7ed5d9b312ccda58c3400c7ba78bca8e5f8ea853.1722357745.git.pabeni@redhat.com>
 <ZquQyd6OTh8Hytql@nanopsycho.orion>
 <b75dfc17-303a-4b91-bd16-5580feefe177@redhat.com>
 <ZrxsvRzijiSv0Ji8@nanopsycho.orion>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <ZrxsvRzijiSv0Ji8@nanopsycho.orion>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/14/24 10:37, Jiri Pirko wrote:
> Tue, Aug 13, 2024 at 05:17:12PM CEST, pabeni@redhat.com wrote:
>> On 8/1/24 15:42, Jiri Pirko wrote:
>> [...]
>>>> int net_shaper_nl_get_doit(struct sk_buff *skb, struct genl_info *info)
>>>> {
>>>> -	return -EOPNOTSUPP;
>>>> +	struct net_shaper_info *shaper;
>>>> +	struct net_device *dev;
>>>> +	struct sk_buff *msg;
>>>> +	u32 handle;
>>>> +	int ret;
>>>> +
>>>> +	ret = fetch_dev(info, &dev);
>>>
>>> This is quite net_device centric. Devlink rate shaper should be
>>> eventually visible throught this api as well, won't they? How do you
>>> imagine that?
>>
>> I'm unsure we are on the same page. Do you foresee this to replace and
>> obsoleted the existing devlink rate API? It was not our so far.
> 
> Driver-api-wise, yes. I believe that was the goal, to have drivers to
> implement one rate api.

I initially underlooked at this point, I'm sorry.

Re-reading this I think we are not on the same page.

The net_shaper_ops are per network device operations: they are aimed 
(also) at consolidating network device shaping related callbacks, but 
they can't operate on non-network device objects (devlink port).

Cheers,

Paolo


