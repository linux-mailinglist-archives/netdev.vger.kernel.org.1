Return-Path: <netdev+bounces-153317-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E62A69F797A
	for <lists+netdev@lfdr.de>; Thu, 19 Dec 2024 11:23:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3994416B079
	for <lists+netdev@lfdr.de>; Thu, 19 Dec 2024 10:23:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7738E221DB6;
	Thu, 19 Dec 2024 10:23:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Q7vzv+Pm"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFCD554727
	for <netdev@vger.kernel.org>; Thu, 19 Dec 2024 10:23:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734603820; cv=none; b=fka5Xf5KlmxScZLnXQnUwx7kqBJ6xyVLSe9w9sGcI70kfy64Aw6qLlty91+eDLBLVTADwYSuP3eDOvCChhwK0fsoaZxfQgmb5JgvnAfnSEpu8TmLXss66tJHSjrTSSf849cjQHcBrzjvKLcRAZgufrQl5d3feifcawrgHvHsNsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734603820; c=relaxed/simple;
	bh=eqo9Zp9dMHAsWSIMIklkPf9ZRC+SukRNszFP/7/QB+U=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=XTjTNasImxDLOCLkUpfxVJ9k/FIMUUANvHb6oRrHSePWsMuxJcAfbTwb+6rdlLVwFWPoFEukXlRqNmtvhn7fg6360LLaRHhA5TRvVqQ1H3Gid5vi5TBDsu0sV+ggjlHhoE0wUNELDX/o4X1lkG3xXXt9udkkh6wRs6LOIRpXAiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Q7vzv+Pm; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1734603817;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PMcN4vEQnO/DQsgnu4MwWvMfZdt3RE+kXzFJoU4nGOs=;
	b=Q7vzv+Pmx4tMEipXiRL1rLgRvSxsqnHWVdBDnT15TJrkChbBAmAjPPXneusnhS/lQaQklX
	egJvWBT07IaIUoKMGah9K0xjjVV7EYDi4WI2zYFkePshzB+TS7SRTPTXmGoARp1rRhT6zv
	PE7Kmd027/4QWLKQWFk/1UD/1l7aD1I=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-60-dzg4VVKNPTK6XPGJpZp7mA-1; Thu, 19 Dec 2024 05:23:35 -0500
X-MC-Unique: dzg4VVKNPTK6XPGJpZp7mA-1
X-Mimecast-MFC-AGG-ID: dzg4VVKNPTK6XPGJpZp7mA
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-43621907030so5062145e9.1
        for <netdev@vger.kernel.org>; Thu, 19 Dec 2024 02:23:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734603814; x=1735208614;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PMcN4vEQnO/DQsgnu4MwWvMfZdt3RE+kXzFJoU4nGOs=;
        b=vtNdXyBSBqwqkuQ2WXrgSJg+tQ3mImSmolwlw+3D9lqRTu8kzWVhQvsukzeiMQzH4o
         cl7RhiYBYQEyOLry10Ws9SK7h9fuucAdMqQBuOsaU7fWnFLs4Ze13FJEsut7mGeBEBF2
         bzZNfWMYykI5bNk8ZKLzxZohS8/kPxnPOi1S5wvBWpJe3pAgeet/jqm9mR+K13mll9JK
         9M+rQiN+Ruo1l+fVMQr/G+vNUMeOLUXAMDE0OnDbLz/ITJYAovihzNQPBpSI5LOWYT8u
         XGo0J8gzjyRdggnJ56dBffxzGoYAt1HUVogrKFCfePjy4oEvvxA75EX+JPU4CYIAFwye
         Dxcg==
X-Gm-Message-State: AOJu0YzGpYy63+cxpsAcEWZHEl4gzrlrTKW/xhRFyHlo8Pfh12Pw/+t4
	HWOJBEGbhy6SrVSZvGNs+Pf9yp94BcVD7wk0ANC+xDqBwV3CoG22tXBm69FHay8iQYtIASrvzo5
	YqyqUUj807SDgwfUsn2I3+t9DgKPTeDnU5+JVU9x6HXaCWR1WOBVbeN19hWMw2A==
X-Gm-Gg: ASbGnct799zODH+K7byGFASRgm7qu/l/L7thYzhAWtCOnCfSIfrqlB7+vWchLvX5pIp
	mK/Hlh4d6uv47HDa65evbmfx/CUOYB3gAg9tEZb25PUn+a2ZtQsobSSkUCfZEkKMd+YvZ5nweIV
	1H1psfac+gb12nDj0Co2raBTaPy2joFQEvnRC6LU1vpFHAS+Jnzu0KjeSUOUVNJOBodlKzQnthX
	ptQ4OfVr8xoQSaz6q2aLjss13XRFo0pezac7jn30DtbWNilDeOyiVBhSTqlM67MOHwaJ+pgRgAo
	wm8HXaygRQ==
X-Received: by 2002:a05:600c:35d4:b0:436:2238:97f6 with SMTP id 5b1f17b1804b1-4365c77dd1fmr21209345e9.1.1734603814380;
        Thu, 19 Dec 2024 02:23:34 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHr8lz9S82Kr/fJC6YC8TUfq2pbcLsPWamwvZ3WhfHMmIths/9KcCBpwWTLNo/ZizGcrhZf0Q==
X-Received: by 2002:a05:600c:35d4:b0:436:2238:97f6 with SMTP id 5b1f17b1804b1-4365c77dd1fmr21209125e9.1.1734603814078;
        Thu, 19 Dec 2024 02:23:34 -0800 (PST)
Received: from [192.168.88.24] (146-241-54-197.dyn.eolo.it. [146.241.54.197])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4366112e780sm14045495e9.0.2024.12.19.02.23.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Dec 2024 02:23:33 -0800 (PST)
Message-ID: <5f878cd5-3166-4ddd-9c26-ed913439408c@redhat.com>
Date: Thu, 19 Dec 2024 11:23:32 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] net: mv643xx_eth: fix an OF node reference leak
From: Paolo Abeni <pabeni@redhat.com>
To: Joe Hattori <joe@pf.is.s.u-tokyo.ac.jp>, sebastian.hesselbarth@gmail.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org
Cc: netdev@vger.kernel.org, dan.carpenter@linaro.org
References: <20241218012849.3214468-1-joe@pf.is.s.u-tokyo.ac.jp>
 <13a68f91-b691-4024-8ae8-5f108b4e4587@redhat.com>
Content-Language: en-US
In-Reply-To: <13a68f91-b691-4024-8ae8-5f108b4e4587@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/19/24 11:21, Paolo Abeni wrote:
> On 12/18/24 02:28, Joe Hattori wrote:
>> Current implementation of mv643xx_eth_shared_of_add_port() calls
>> of_parse_phandle(), but does not release the refcount on error. Call
>> of_node_put() in the error path and in mv643xx_eth_shared_of_remove().
>>
>> This bug was found by an experimental verification tool that I am
>> developing.
>>
>> Fixes: 76723bca2802 ("net: mv643xx_eth: add DT parsing support")
>> Signed-off-by: Joe Hattori <joe@pf.is.s.u-tokyo.ac.jp>
>> ---
>> Changes in v3:
>> - Insert a NULL check for port_platdev[n].
>> Changes in v2:
>> - Insert a NULL check before accessing the platform data.
> 
> I'm sorry for nit-picking, but many little things are adding-up and
> should be noticed.
> 
> The subj prefix must include the correct revision number (v3 in this case).

Oops, I almost forgot... the patch subj prefix must additionally include
the target tree - 'net' in this case - see:

https://elixir.bootlin.com/linux/v6.12.5/source/Documentation/process/maintainer-netdev.rst#L332

Thanks,

Paolo


