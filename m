Return-Path: <netdev+bounces-163392-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D2F10A2A1BA
	for <lists+netdev@lfdr.de>; Thu,  6 Feb 2025 08:04:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 923A41681C2
	for <lists+netdev@lfdr.de>; Thu,  6 Feb 2025 07:04:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B22D1FECBD;
	Thu,  6 Feb 2025 07:04:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b="Z94t4Vw+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AD0C1FDE08
	for <netdev@vger.kernel.org>; Thu,  6 Feb 2025 07:04:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738825460; cv=none; b=mlGVZNk9Yylt2yKYD2W5gw20XR1mTjnbhdshjsKqIx12ufpq/iGUhfLMvEc6Xj4hap1WDTtUZDryYDemfakXjFAAnlLyuWCjze1a7nw1NrOvXIs2WkhcBcyvLe1EHA5NeE3f6J6HOPawYDmdZEhOs2KHUCKKY5sXRhMBBsmvQBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738825460; c=relaxed/simple;
	bh=6Z7n8UWnuTd40YxRqOUHsnsjz1hSaR5JYJ7mFXzEuEU=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=CmK443KmcSF+BosugY6+w/LJr0sGl7UhpGMGMNZ9BIzdtkQs+4VRu6XAchoKi1thfSN4F4tZg/cUuN2Zh5PctRN9fUyNL1DX7LZ9x19AYT1aHkrZFayMabCvzUo1NJ+Qwbkug3oGN3TPwae4KJQtXMkX46xSHrqX6cUdnBWEITc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com; spf=pass smtp.mailfrom=daynix.com; dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b=Z94t4Vw+; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=daynix.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2165448243fso15407205ad.1
        for <netdev@vger.kernel.org>; Wed, 05 Feb 2025 23:04:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1738825458; x=1739430258; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xSMzQMG1ZHF7w5vbC9dgevornaZeizWpfwbsJmx7bQk=;
        b=Z94t4Vw+PQhHm/5AADHOjjd8ZhDcd+V5D6AQ7o7Jp1LWmWsHVcxJlyOvqcNqHIjGl6
         XiWk+CRqG67jELyb0owDOcKj7ld3q3qh3iSiHe7SK2vDLjqXrbSoiW+bXM5ehTPL1JaY
         9AVEKGIlfvuEAYlhz+WYcGKZ17KEAiLVjKav4mPAILViMwGvEJYx+fg0pSbSNrM292sn
         SiXt8MHxPvVYgCGKljfqrjhrFd5FVJ/f5dlWXUCu+aB1wOhvMOn3lCdkZr3lur42Upvy
         3WvUzsWgHU3ts0u5ySa25e6zDILJHcwrk7jsdWWT3jGijvNNSkwM0YHShK4PrGu8SixI
         3jrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738825458; x=1739430258;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xSMzQMG1ZHF7w5vbC9dgevornaZeizWpfwbsJmx7bQk=;
        b=jRthiDi2f8mhLtmCdRD1tW9W1WsksMQkM2qrOFgq6PFWaEwjMdJUUF51AQ2FSLfM6R
         TYV3GNBRaO6HywLxe8xDc5s+vk0N5/WEIwWE2ygwljxMumOC4uEDp+SMyg8EiiWjZGIL
         dHvtC21RW2V73tCoxtdVf3poOBexzcDlv0GnB9SFpsUNYOkAG9rDAN477tL40V5JYyEh
         NLb+/SutCrPVdaSvKKvpR2VYrZgvCRCa2gHXeE3OWQS7jkn96+ofbEXkyxbb63j51U8u
         jyx7jX8zLM1ClOiddIa+7Qp/Pf78k4XtA3GaYdmXo05MMrcQVdo8me0v5ee5WjfDRxCz
         LS6A==
X-Forwarded-Encrypted: i=1; AJvYcCU3rd2BvIQ+OWKacrFvoMyT6l0tmZ8dJAC2anbxfXo7U561nQk1QpqZADlWKjdSIvbKgbhSEpI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwuhMOwqkCmeYB6u+xHdqK2QR1iNAmAx8h/DGWVimg70CK2L+9N
	ZWb+I9Ex62O26AMZ+DG5XqhhTHYO8lZc5QvoHGqESMFckUi7MvaQUgXifFla5TM=
X-Gm-Gg: ASbGncvQrzeCh61/Wh3OVlBjIqrWqfh6RQGbfOPLIXSQzzP30wN4F/LPu/kJ17Chs2F
	L950KpSBTtvv3XmfUYqBjwDOSiqidSyjCLstqsOfwKlR9GXdd0UR3bF8dE2Lh9mOw0dRPQrX/ci
	A1zv0mc737xoRl1Q3M3e/zv4lO8wx0oc7cn2jwW1Z6nTjwc7NmXp16IZP/MHgQ4/92AeG3OajAA
	TzEMCxAmNR7MnHnzjcayoqirz/RHsbccIFDAlPYEuRyIAzHjfdycOkjwV+la4mmGELUWJdiXKMs
	m7id8Uj6+diPNFNDgHaq+vMQmxvk
X-Google-Smtp-Source: AGHT+IEGoYiB8pxUq02irm/CU5MvTVOQlUDfWzGd8n7ZsLH5KxtqKlPFWXhqlXZi0kPwplHWCVM1fg==
X-Received: by 2002:a17:902:f64f:b0:216:3e87:c9fc with SMTP id d9443c01a7336-21f17ddf80bmr102170675ad.5.1738825457907;
        Wed, 05 Feb 2025 23:04:17 -0800 (PST)
Received: from [157.82.207.107] ([157.82.207.107])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-ad51aecce52sm481627a12.18.2025.02.05.23.04.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Feb 2025 23:04:17 -0800 (PST)
Message-ID: <8b389981-c04a-4d4f-8a5a-043b4cd6e8db@daynix.com>
Date: Thu, 6 Feb 2025 16:04:11 +0900
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v5 6/7] tap: Keep hdr_len in tap_get_user()
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
 Jonathan Corbet <corbet@lwn.net>, Jason Wang <jasowang@redhat.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Xuan Zhuo
 <xuanzhuo@linux.alibaba.com>, Shuah Khan <shuah@kernel.org>,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, kvm@vger.kernel.org,
 virtualization@lists.linux-foundation.org, linux-kselftest@vger.kernel.org,
 Yuri Benditovich <yuri.benditovich@daynix.com>,
 Andrew Melnychenko <andrew@daynix.com>,
 Stephen Hemminger <stephen@networkplumber.org>, gur.stavi@huawei.com,
 devel@daynix.com
References: <20250205-tun-v5-0-15d0b32e87fa@daynix.com>
 <20250205-tun-v5-6-15d0b32e87fa@daynix.com>
 <67a3d6706c01a_170d3929436@willemb.c.googlers.com.notmuch>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <67a3d6706c01a_170d3929436@willemb.c.googlers.com.notmuch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2025/02/06 6:21, Willem de Bruijn wrote:
> Akihiko Odaki wrote:
>> hdr_len is repeatedly used so keep it in a local variable.
>>
>> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> 
>> @@ -682,11 +683,8 @@ static ssize_t tap_get_user(struct tap_queue *q, void *msg_control,
>>   	if (msg_control && sock_flag(&q->sk, SOCK_ZEROCOPY)) {
>>   		struct iov_iter i;
>>   
>> -		copylen = vnet_hdr.hdr_len ?
>> -			tap16_to_cpu(q, vnet_hdr.hdr_len) : GOODCOPY_LEN;
>> -		if (copylen > good_linear)
>> -			copylen = good_linear;
>> -		else if (copylen < ETH_HLEN)
>> +		copylen = min(hdr_len ? hdr_len : GOODCOPY_LEN, good_linear);
>> +		if (copylen < ETH_HLEN)
>>   			copylen = ETH_HLEN;
> 
> I forgot earlier: this can also use single line statement
> 
>      copylen = max(copylen, ETH_HLEN);
> 
> And perhaps easiest to follow is
> 
>      copylen = hdr_len ?: GOODCOPY_LEN;
>      copylen = min(copylen, good_linear);
>      copylen = max(copylen, ETH_HLEN);

I introduced the min() usage as it now neatly fits in a line, but I 
found even clamp() fits so I'll use it in the next version:
copylen = clamp(hdr_len ?: GOODCOPY_LEN, ETH_HLEN, good_linear);

Please tell me if you prefer hdr_len ?: GOODCOPY_LEN in a separate line:
copylen = hdr_len ?: GOODCOPY_LEN;
copylen = clamp(copylen, ETH_HLEN, good_linear);

> 
>>   		linear = copylen;
>>   		i = *from;
>> @@ -697,11 +695,9 @@ static ssize_t tap_get_user(struct tap_queue *q, void *msg_control,
>>   
>>   	if (!zerocopy) {
>>   		copylen = len;
>> -		linear = tap16_to_cpu(q, vnet_hdr.hdr_len);
>> -		if (linear > good_linear)
>> -			linear = good_linear;
>> -		else if (linear < ETH_HLEN)
>> -			linear = ETH_HLEN;
>> +		linear = min(hdr_len, good_linear);
>> +		if (copylen < ETH_HLEN)
>> +			copylen = ETH_HLEN;> > Same


I realized I mistakenly replaced linear with copylen here. Using clamp() 
will remove redundant variable references and fix the bug.

