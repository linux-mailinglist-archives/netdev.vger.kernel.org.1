Return-Path: <netdev+bounces-236876-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id B576BC41299
	for <lists+netdev@lfdr.de>; Fri, 07 Nov 2025 18:54:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 78DAC4E6FD1
	for <lists+netdev@lfdr.de>; Fri,  7 Nov 2025 17:54:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7863D3376B9;
	Fri,  7 Nov 2025 17:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="XwBhbLT6"
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f181.google.com (mail-il1-f181.google.com [209.85.166.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A794D2C375A
	for <netdev@vger.kernel.org>; Fri,  7 Nov 2025 17:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762538070; cv=none; b=anwE6EG1ocw4Dzq7ptpvxpEcW5B4EPEUNPaXoA2pvojJqWtRlRUH5ZhYXBTdjCURuyoMwIZl/4sU2pDhEjE+fghe0UjOSqVJ0dOGyWHTSJaY4AvjX9M3VUkcEwyN/lPbzKun5K+ujrd9UfaBXQ4hM/pYPOyalvftWhoZeC2I2ns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762538070; c=relaxed/simple;
	bh=dIlUqtzLyQeoLWra58iVWTQ8+nwBRh5dtagRaNZsUEQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fdjKFiuTcOsHnKr+dZqkOfXkhXcneujaSEse9E/FfldV5itOaotRc54rwO85YiUG9GR61NeweQKcuyJQ2H6LRw+R3yuTPejDYw1MutZ/4OaZ63xQJpBrS48xxPPfgy3Wee4A42IOqxXWZYglqPbEM13LELr0ITZ/P1NdEkdtLu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=XwBhbLT6; arc=none smtp.client-ip=209.85.166.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f181.google.com with SMTP id e9e14a558f8ab-4334f0f9c6cso9770535ab.0
        for <netdev@vger.kernel.org>; Fri, 07 Nov 2025 09:54:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1762538067; x=1763142867; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FU3/MuagL6B3vYQIaeUguOWrDr12VN/IdKPR191w65w=;
        b=XwBhbLT6AynyygfsTjPYppVn5gp8pUM6XzrBWrXoLVMBsMOqrRcFSbUInIg7FuLxk0
         7SBjz/WDN4yeYMpgzSb7WoMl9GkFJATXjYVX74qPGv6aldgkQ54MKFC3Bv8840uH5gxS
         OK29KtE38gaxuUJ2CDvQOqLWIsoLuXsLrTwiw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762538067; x=1763142867;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FU3/MuagL6B3vYQIaeUguOWrDr12VN/IdKPR191w65w=;
        b=jYpoZ6+67rR+EFe+rMvX72ts7MKJWMHhED68kvdxxb+s/c+mz0kJl8C3qj5/NeG8+f
         dXrSo/oCqbjFoySkVLcNz5EV1G9wr9xMgxpbxyR5JDHpIE9/O64ek3hIrLHSberX2krw
         PzWDUE6vZLUL9cp2bLPRnWEaPwD3+bABnjSWAXINWuKw6dEqLQmDPh6Q5191CmuvCEWC
         sNYR3Gxzkd+kHU/EeDUSntJpQWGM6U/XU4qfcJ4dMKMJy5MAnBXU96gs32jWN4e9mTiY
         y0m/TIm4bMGSptCL6lr/xveDx32yg/wkKfUU5MNZyz9lldu35RiDMIW0z5Hc5/RI0co1
         x5Fw==
X-Forwarded-Encrypted: i=1; AJvYcCWVRomLxcEv7i+9v/A6FthxPAd3PW87O/NUGWaOGH1bodifaIxDsUI3xQa8NWtbCeQyf6TQ2Tw=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywpe5859ZxnV03wgamABxGA/KlKjC1dsU7hY5ur7P10POnBPHu+
	L3MdLW5va7zBwqT09KOmVWa+lloietq2Sf7Qat5TLAKYz4I88m0IMdWj5sjd2GzGikI=
X-Gm-Gg: ASbGncvsoA35LECeZV9lLCQtLx7+9070gW74mfCY8CT50IneL54BCIkVKxarEGuZ7+5
	Ik6DuhD9qdFcSwWWw2PZJGcZ8/haPRT+OZW295B+29bqz/s/nSt+DNgXc+s36rSOamLQVf6xk1m
	zn3SSVwX27RIGk/rXyD6zk9UmKO/7eDyPhrONPPFaJSv/DbIMCOQPPhK1E5eh9sS16DqREcG9JU
	mJsUZ718WXYK7c2rjFvXfhbIJDUa8wSsxQwL8H4ChBO3xO6kFaq9UOllbIy0USiIs+BdR1KyPAu
	oAZIAQXAodIKvePC54zvluPPe67gfBQCeKwTR4OAvDylOv12I05uFzuS3LRaXs+om5uA8SXKTmg
	cNAJhkCGqB9j9hBdZRcWatEjXWC8I3WW+GEwOMH8Lit364yhspHzcf2KkYnFa+DMo0wWqqWPjsS
	AtmiblssPvgxI9e6YwG4UeBjw=
X-Google-Smtp-Source: AGHT+IFKp4dE65PiBOFxRJN/woRBeSQ9orDQvbl++M1O5M6uLi0c6Zrpx9SmAbu7RjKzh9d0tCzeOw==
X-Received: by 2002:a05:6e02:1a2c:b0:433:4c96:48b8 with SMTP id e9e14a558f8ab-43367e7a04dmr5317795ab.32.1762538066733;
        Fri, 07 Nov 2025 09:54:26 -0800 (PST)
Received: from [192.168.1.14] ([38.175.187.108])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-4334f4e77b7sm24550145ab.29.2025.11.07.09.54.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Nov 2025 09:54:26 -0800 (PST)
Message-ID: <e45ac35b-8cb3-42c0-b5dc-d4c718ee0d9d@linuxfoundation.org>
Date: Fri, 7 Nov 2025 10:54:24 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: core: Initialize new header to zero in
 pskb_expand_head
To: Jakub Kicinski <kuba@kernel.org>,
 Prithvi Tambewagh <activprithvi@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 horms@kernel.org, alexanderduyck@fb.com, chuck.lever@oracle.com,
 linyunsheng@huawei.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, david.hunter.linux@gmail.com,
 khalid@kernel.org, linux-kernel-mentees@lists.linux.dev,
 syzbot+4b8a1e4690e64b018227@syzkaller.appspotmail.com,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20251106192423.412977-1-activprithvi@gmail.com>
 <20251106165732.6ea6bd87@kernel.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20251106165732.6ea6bd87@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/6/25 17:57, Jakub Kicinski wrote:
> On Fri,  7 Nov 2025 00:54:23 +0530 Prithvi Tambewagh wrote:
>> KMSAN reports uninitialized value in can_receive(). The crash trace shows
>> the uninitialized value was created in pskb_expand_head(). This function
>> expands header of a socket buffer using kmalloc_reserve() which doesn't
>> zero-initialize the memory. When old packet data is copied to the new
>> buffer at an offset of data+nhead, new header area (first nhead bytes of
>> the new buffer) are left uninitialized. This is fixed by using memset()
>> to zero-initialize this header of the new buffer.
> 
> It's caller's responsibility to initialize the skb data, please leave
> the core alone..
> 
>> diff --git a/net/core/skbuff.c b/net/core/skbuff.c
>> index 6841e61a6bd0..3486271260ac 100644
>> --- a/net/core/skbuff.c
>> +++ b/net/core/skbuff.c
>> @@ -2282,6 +2282,8 @@ int pskb_expand_head(struct sk_buff *skb, int nhead, int ntail,
>>   	 */
>>   	memcpy(data + nhead, skb->head, skb_tail_pointer(skb) - skb->head);
>>   
>> +	memset(data, 0, size);
> 
> We just copied the data in there, and now you're zeroing it.

Prithvi,

This type of careless coding introduces serious problems. Don't
make changes to the code without understanding it. memcpy()
is right above where you added memset() which is hard to miss.

thanks,
-- Shuah

