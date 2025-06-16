Return-Path: <netdev+bounces-198298-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 961C2ADBD04
	for <lists+netdev@lfdr.de>; Tue, 17 Jun 2025 00:37:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DCE281891B2E
	for <lists+netdev@lfdr.de>; Mon, 16 Jun 2025 22:38:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4BD72144A3;
	Mon, 16 Jun 2025 22:37:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b="pnsEk2oB"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D03B4A0C
	for <netdev@vger.kernel.org>; Mon, 16 Jun 2025 22:37:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750113465; cv=none; b=cLf4OS5TKA2b2G+p9O1aVNi6PM5IKwYg5t8XN3bbXBT01E4HLDaSCzXfBnIJeJ4U0++Al3DVxuTZv5+2mNioskOTJeSEkSIhNtfqdozp2Ft8+yspiS3qVMg8SpA/e6J3Kb3TJgIAC9+OV8Lh1OdTBQRpz9qyJKaj9G4SAAGpSAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750113465; c=relaxed/simple;
	bh=qP99WxQ/Cpk+UHENWroxHhVUr6RX/N/HZYoxs4snZl4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=R9OCc2Ip9ZXrHSug6YB3H9C4vMpHV8x3Js1Y01+2L3Vlz4evMvSOmmOzQQAGBc9+cpnmTb3lGrm7wjfiJmbsJIszRCkvM78tDqh14Szyxuw+l3h4msm3CfbBkC5RUNgYEd+KB+aF8yEFJj2WPB2VsBQ7AJPsdUXC4yA3ynPVW8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk; spf=none smtp.mailfrom=davidwei.uk; dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b=pnsEk2oB; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=davidwei.uk
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-234b9dfb842so45992745ad.1
        for <netdev@vger.kernel.org>; Mon, 16 Jun 2025 15:37:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20230601.gappssmtp.com; s=20230601; t=1750113463; x=1750718263; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Rso/Fw2+BsbZcYSiT/vksaxzhrnhG12egAmkhUsdabg=;
        b=pnsEk2oB1fNYIQYcuM2I9blI7BvwklD6unYaqO48Df8Ckei4H/NDjHGuFNMu2BfIOQ
         NIZvE1lEjbw9FyOFNYS+vyNNm0KfGiOKztlT3vI7bcYxi6yI5/lvTZh6zrqx5unY2GES
         gpohLvM/klkka1EpRCo6bgI8az9EhNch4YWt8m3EuRBwPJ0gFxehQmAxlDGUfoz8/fQn
         PopRMhxVoYrIHabtDf+tiFlhQ3FuNMVD2ayvPd0gwiqPI1kBpTb4xPoNOpGYjsg8YZWr
         niO1Utr7zCEhnksOYM3kDP9qtJT53rY4HJ1VyYHaA3Zl/39ZbRIqqsKqBeqef6i0i63f
         +nqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750113463; x=1750718263;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Rso/Fw2+BsbZcYSiT/vksaxzhrnhG12egAmkhUsdabg=;
        b=J+tglu9KoNBgfCoVxviCfQJLbgR1A7vLV4pr389Qwm+CRJEm9JlY1847GvCuYUuRq1
         z42ZDyulDa0cIJDZaWDYp+lBUHsmbobCaVWgEvyK+9/L8QnYJ94YalYX4aJbIwPZ0VX7
         n6XaWRZgpcX7FAGNz78YIxxK2wOMfXrcLQlVHjz1laAdmysGhZ7nyFpD0xxjrjtaeWSG
         DP+2IqzCnOwWtxH84cHaYT/e+5KNHjx9ifkuiYoMF8JJb5xQdHEje2AENu97cI+Npfo0
         jXCqcyDDcpIye3D06dTCSZkrC/2mLGS5bUt04GWnmw4lPQVGEqwVCTBxJruKobvgFVTe
         CI9g==
X-Forwarded-Encrypted: i=1; AJvYcCUHcA7ljVpALSBS3X/iSTVaS61LH2iOFfRC8ccoFUdVTY3aJSD4bnOI7hYfM4auL0aDpay0mQI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyujPAqzA7evHjPEthCkbpShi0ahmQSCP5RNLsz522P6YwABEkD
	aTQgBDx0rcA5o5nEseJXtIhs9o1vhTxKbIhz/JeBvqe/MLhL5zMMHFL/b0olsES941U=
X-Gm-Gg: ASbGnctJLbUlr8XyYWaVNoThOlF06fp0zrrXfbIIKvWkXIW5ki7K7kor+m+38kj+r0j
	hGeLJa+9/IpVWkQp3y32oZVUbj2oO1yforNoKQaFxBo05Mtq8Af3iFNyJwFdaNwLUJ1gGIP2G/9
	bbpkkNRBMfR/qV917stKrTqyR7F/Lzh0XjLPmkEuU6aB+0tEZGCUh25B6eZLR8Ykvwr+UGYSU9A
	IdpUYdd+1EJCbUatTxo6itXfuU2whVDAdaOvsOkjV4nsoSOIHUVnNxB5D5FNHyJW/vNaDYLROlc
	ZSuEniLiW2yMunVLZnl9L1YNx55DNADI3TBfkHlER1fjrUwKhRvo6ney0mxB1wIcbNE/PaTqr4U
	ZaWD208FmATFHCqnenV8lwGT5FgGyia2hV+M=
X-Google-Smtp-Source: AGHT+IEz++AYHPOcw9kPD3DK2pDLcV8rT2jSipWm0XfxK88wYA9F39k+N8O6cf/Z89kKbo9lr8tk/Q==
X-Received: by 2002:a17:902:cf10:b0:235:7c6:ebdb with SMTP id d9443c01a7336-2366b316d34mr190940825ad.10.1750113463479;
        Mon, 16 Jun 2025 15:37:43 -0700 (PDT)
Received: from ?IPV6:2a03:83e0:1156:1:14f8:5a41:7998:a806? ([2620:10d:c090:500::7:e85f])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2365d88c239sm66776815ad.11.2025.06.16.15.37.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Jun 2025 15:37:43 -0700 (PDT)
Message-ID: <e725afd8-610b-457a-b30e-963cbf8930af@davidwei.uk>
Date: Mon, 16 Jun 2025 15:37:40 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v1 4/4] tcp: fix passive TFO socket having invalid
 NAPI ID
To: Kuniyuki Iwashima <kuni1840@gmail.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, dsahern@kernel.org,
 edumazet@google.com, horms@kernel.org, kuba@kernel.org, kuniyu@google.com,
 ncardwell@google.com, netdev@vger.kernel.org, pabeni@redhat.com,
 shuah@kernel.org
References: <20250616185456.2644238-5-dw@davidwei.uk>
 <20250616194437.1017381-1-kuni1840@gmail.com>
Content-Language: en-US
From: David Wei <dw@davidwei.uk>
In-Reply-To: <20250616194437.1017381-1-kuni1840@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2025-06-16 12:44, Kuniyuki Iwashima wrote:
> From: David Wei <dw@davidwei.uk>
> Date: Mon, 16 Jun 2025 11:54:56 -0700
>> There is a bug with passive TFO sockets returning an invalid NAPI ID 0
>> from SO_INCOMING_NAPI_ID. Normally this is not an issue, but zero copy
>> receive relies on a correct NAPI ID to process sockets on the right
>> queue.
>>
>> Fix by adding a skb_mark_napi_id().
>>
> 
> Please add Fixes: tag.

Not sure which commit to tag as Fixes. 5b7ed089 originally created
tcp_fastopen_create_child() in tcp_fastopen.c by copying from
tcp_v4_conn_req_fastopen(). The bug has been around since either when
TFO was added in 168a8f58 or when SO_INCOMING_NAPI_ID was added in
6d433902. What's your preference?

> 
>> Signed-off-by: David Wei <dw@davidwei.uk>
>> ---
>>   net/ipv4/tcp_fastopen.c | 3 +++
>>   1 file changed, 3 insertions(+)
>>
>> diff --git a/net/ipv4/tcp_fastopen.c b/net/ipv4/tcp_fastopen.c
>> index 9b83d639b5ac..d0ed1779861b 100644
>> --- a/net/ipv4/tcp_fastopen.c
>> +++ b/net/ipv4/tcp_fastopen.c
>> @@ -3,6 +3,7 @@
>>   #include <linux/tcp.h>
>>   #include <linux/rcupdate.h>
>>   #include <net/tcp.h>
>> +#include <net/busy_poll.h>
>>   
>>   void tcp_fastopen_init_key_once(struct net *net)
>>   {
>> @@ -279,6 +280,8 @@ static struct sock *tcp_fastopen_create_child(struct sock *sk,
>>   
>>   	refcount_set(&req->rsk_refcnt, 2);
>>   
>> +	sk_mark_napi_id(child, skb);
> 
> I think sk_mark_napi_id_set() is better here.

Sure, I can switch to sk_mark_napi_id_set().

> 
> 
>> +
>>   	/* Now finish processing the fastopen child socket. */
>>   	tcp_init_transfer(child, BPF_SOCK_OPS_PASSIVE_ESTABLISHED_CB, skb);
>>   
>> -- 
>> 2.47.1
>>

