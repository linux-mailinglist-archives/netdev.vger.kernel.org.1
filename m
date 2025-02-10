Return-Path: <netdev+bounces-164583-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A1082A2E5AF
	for <lists+netdev@lfdr.de>; Mon, 10 Feb 2025 08:45:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C3B0C18822C8
	for <lists+netdev@lfdr.de>; Mon, 10 Feb 2025 07:45:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C49F1AF0BB;
	Mon, 10 Feb 2025 07:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aCn3rOFW"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23B522F2A;
	Mon, 10 Feb 2025 07:45:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739173518; cv=none; b=ZwSBK2ZxF7Z3ef+IXH+VJD7gprYNu1JAvjdZGaDQl4QrcxFHW+LgxnU5h7TPx8G1e4HiE1OunUvpgyW5bFE3bDhyB3QfeSXJtokNo8ctg3kqCGeTIVniDPTnU25VY5V9IgRjwDbXSu62owUdjQDI+CVV7Gl4B8Vmzl6tN55zqwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739173518; c=relaxed/simple;
	bh=eOWONN5ZBbRv8aYl9s+6MqZgaY5tkVdbjSku/C+aepU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ILm2SBH+OPcVrItr/33JfjIkXBaNRIzNGiUVgecHC5v0uWQsLZV9YsJgbL3bKuL1qGS9N5V/jyXvQHoFWqM0FipYmBAMmIu8xQ0IArKKCSzCMPw7XFKyadcEJsiy+wCRATuSmqeJDrcUP5WfVCjpvSk7cxhdteKifzhGuHngAfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aCn3rOFW; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-21f464b9a27so63021255ad.1;
        Sun, 09 Feb 2025 23:45:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739173516; x=1739778316; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vgDFMMK78aNqKvQlYUZbaLj/duHE/jz0+XIQsm2yUik=;
        b=aCn3rOFWlTpo+KqTkQRkjerzvIXhji6CmQT4wqPSCyLSenTw/oJNpcTI11GT87l0YT
         F9Tp8FpjAVBa23kAI3mUzpVR5gbi4EBqYx4nS8mTblX7/RSkT/pVZPz6T9jx+8GcRPeK
         xwhcJFvAGCCvcnnzLLdzsQ8SuLFH79XMAk4fGJlXK3xnPpmd2OiYtM5vrC20guzrn1GM
         9XOqmgr18Fx4UbwKATzMtbvngHjr13tkspUHqXClWMqS5g/0yT05kYQ4VIs825joy2L/
         5tWmABJyClkeRL5CfmnAGFDelWkANion2SQbiwiFEbhr7ZR4546iRxPj4DZPB53WU4SZ
         q6cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739173516; x=1739778316;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vgDFMMK78aNqKvQlYUZbaLj/duHE/jz0+XIQsm2yUik=;
        b=sdDEcpOzTSpMMSQrTBh7HTI8o8Ji/DtKdc6pspqus8GNG+D6OoqoTB4qohk//scqw9
         sXSPKbx9qTzbChfFR6T16irq3kXps0uum0Hu3eQx3gnIDUBwId0EPFZ2BBDhJjpNy2o1
         7wCeZVGvA8D/qV2WaQChGeufI1qJuACQo1vY9ZZpqLn+/v+pmz/Z0Kvm4NPcU8+waRGY
         OMkeOlyJUwL3x/1UKrS6ms7AN2svixV10fr7A5fuSSNymPUyMVv+BpRKUh4jF8Ic3qSt
         CD1zWOQse6WnUKZarj/beutS1W21Mz+nevxbeOKKxM0cJwhLHdArpOCUv5Hyb4fGKWKJ
         BJ5w==
X-Forwarded-Encrypted: i=1; AJvYcCUA5TjKIKqYE3tJabtOxaylb6Xg0YdBwDbXb1GAbER67Zn+3OwsmN+MRCHClk/RuL9Xr3uUfAqjgL4bL+8=@vger.kernel.org, AJvYcCUkiDOwcGQ1eS5dBNwVcUFxq2htObw0hRl03AFHNpzfRxSXRubjmC3K9clhlDtJKuwaWnRlgnpC@vger.kernel.org
X-Gm-Message-State: AOJu0YzlXEGGOoiYNS+PBPzSVBpFIjgqjgPQlRmUhmOpacpew1CvOA2G
	MNijDIP+CBrz5vUbN6B8+BTpL4ySaARv5Q4PnxzaRBLxJ1xnEbfe6EUc/EZZ
X-Gm-Gg: ASbGncvKJ/Ihzi0sOqGB62D9W3MUhAFcYMvzDwkGY3AUjk5cPysY/MyRckW2A9AkRq4
	TGsgEEhgLqRJlwKIXPTXeKViE5lPWruXVBfIZAUMeglCyPjEf9BRKcn1d5CUC+dwdrRyRLGgRr8
	wyPX7XR2MrBoXzrYiTy7Y8g7updvsBB5UwJn2v5vvXRPCugSBh2L6hAbph7f3qeRb0xP1ZaiMke
	VujDz7c2bEnoSTTR0AZvGP7XZPnoOgF4nvWVmH5GRCMbwTWVNZLXbHiSSFlENh96sClff3NFB3i
	OXKBdUcjYnTUSimcJNlznJdaVNsuvmZDk5heCNF13D8CHiG+M2DL0qTPdkOc2ThKSOeyRg==
X-Google-Smtp-Source: AGHT+IGManpeAPu/DIgD3ta4N4Isd+1vrKJTnUpGzpbzCRvKzOHTytyM4P1+3VcsiTd9IxYQoPkvvA==
X-Received: by 2002:a17:903:1a24:b0:215:bc30:c952 with SMTP id d9443c01a7336-21f4e1cbb20mr150675985ad.6.1739173516105;
        Sun, 09 Feb 2025 23:45:16 -0800 (PST)
Received: from ?IPV6:2409:40c0:101c:99b7:34e3:b424:c392:121c? ([2409:40c0:101c:99b7:34e3:b424:c392:121c])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21f3687e68bsm71606245ad.169.2025.02.09.23.45.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 09 Feb 2025 23:45:15 -0800 (PST)
Message-ID: <089974d9-e9cd-4a46-889b-94dd595d8c13@gmail.com>
Date: Mon, 10 Feb 2025 13:15:08 +0530
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: unix: Fix undefined 'other' error
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: davem@davemloft.net, edumazet@google.com, horms@kernel.org,
 kuba@kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 pabeni@redhat.com, skhan@linuxfoundation.org
References: <20250209184355.16257-1-purvayeshi550@gmail.com>
 <20250210002632.48499-1-kuniyu@amazon.com>
Content-Language: en-US
From: Purva Yeshi <purvayeshi550@gmail.com>
In-Reply-To: <20250210002632.48499-1-kuniyu@amazon.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/02/25 05:56, Kuniyuki Iwashima wrote:
> 
>> [PATCH] net: unix: Fix undefined 'other' error
> 
> Please add net-next after PATCH and start with af_unix: as with
> other commits when you post v2.
> 
> [PATCH net-next v2]: af_unix: ...
> 
> 
> From: Purva Yeshi <purvayeshi550@gmail.com>
> Date: Mon, 10 Feb 2025 00:13:55 +0530
>> Fix issue detected by smatch tool:
>> An "undefined 'other'" error occur in __releases() annotation.
>>
>> The issue occurs because __releases(&unix_sk(other)->lock) is placed
>> at the function signature level, where other is not yet in scope.
>>
>> Fix this by replacing it with __releases(&u->lock), using u, a local
>> variable, which is properly defined inside the function.
> 
> Tweaking an annotation with a comment for a static analyzer to fix
> a warning for yet another static analyzer is too much.
> 
> Please remove sparse annotation instead.
> 
> Here's the only place where sparse is used in AF_UNIX code, and we
> don't use sparse even for /proc/net/unix.

Thank you for the feedback. As per your suggestion, I have removed the 
Sparse annotation instead of modifying it. I have updated the patch 
accordingly and will send v2 with the corrected subject line and commit 
message.

Best regards,
Purva Yeshi

> 
> 
>>
>> Signed-off-by: Purva Yeshi <purvayeshi550@gmail.com>
>> ---
>>   net/unix/af_unix.c | 5 ++++-
>>   1 file changed, 4 insertions(+), 1 deletion(-)
>>
>> diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
>> index 34945de1f..37b01605a 100644
>> --- a/net/unix/af_unix.c
>> +++ b/net/unix/af_unix.c
>> @@ -1508,7 +1508,10 @@ static int unix_dgram_connect(struct socket *sock, struct sockaddr *addr,
>>   }
>>   
>>   static long unix_wait_for_peer(struct sock *other, long timeo)
>> -	__releases(&unix_sk(other)->lock)
>> +	/*
>> +	 * Use local variable instead of function parameter
>> +	 */
>> +	__releases(&u->lock)
>>   {
>>   	struct unix_sock *u = unix_sk(other);
>>   	int sched;
>> -- 
>> 2.34.1


