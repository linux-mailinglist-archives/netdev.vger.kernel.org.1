Return-Path: <netdev+bounces-205617-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DA93AAFF6BB
	for <lists+netdev@lfdr.de>; Thu, 10 Jul 2025 04:21:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 37C0616E649
	for <lists+netdev@lfdr.de>; Thu, 10 Jul 2025 02:21:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7223227F16A;
	Thu, 10 Jul 2025 02:21:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="gLjSDVh1"
X-Original-To: netdev@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B552A19D065;
	Thu, 10 Jul 2025 02:21:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752114070; cv=none; b=RJHkcUh8mUEAgF/2riNgN1Dnz+R1DJEWSQ6tLofUKUWSwrMKbsSLsFCkAR5iNSDrruz05iNg3uVcv8lhq1/dH4BoMs1hL1hLDPBtzKttmWzTxsNefy93wJCSMLoQaMVc+78Vp1EI/jFzJrzoGG52HLVTlzcgKy6sEnqaY/ta3Bs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752114070; c=relaxed/simple;
	bh=Vw+H+l2VvCbkV5x6YVAlKZGJQW+cJGkX/aq5oij9AsY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FXo1DZLVvRxDaslNn09aDEj1kkX74oNGrLoDEoShQgQDb23h7Zm0Q0jaOaMeuynrSt7QYmjIshFAf6AUO+8cOy9wArKnjbR58nly16EGzfr1uw+QaNFsUUV553LKwFLHnFw9Uvmw3RbmYxJEwIWGoXXrvk8NuKsBnfxGC8CDI48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=gLjSDVh1; arc=none smtp.client-ip=117.135.210.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:To:From:
	Content-Type; bh=0Ab0HC1lqiYJ7NrxbvY+EhcNWXngvgHGMfzBJl73UO8=;
	b=gLjSDVh1CEBbTUJjwZcpiYlObvy0DRUe1TN6PUELf5piedDFkdrhPQzQB0B840
	WalDINP0ZCkwB24OBawZQ3IklPS4M0bxhGAIbO4rN+/tau2YlDp5i0bpVAVHfxIs
	0x8hPLSlAuKc1M5YDBgxCGRnQWoLh8ZlIfCcKHWR9DhUA=
Received: from [172.21.20.151] (unknown [])
	by gzga-smtp-mtada-g1-3 (Coremail) with SMTP id _____wAn0Z93I29o3XTLDg--.384S2;
	Thu, 10 Jul 2025 10:20:39 +0800 (CST)
Message-ID: <9853d3f1-569f-4fde-846e-5c8d7f798725@163.com>
Date: Thu, 10 Jul 2025 10:20:39 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] af_packet: fix soft lockup issue caused by
 tpacket_snd()
To: Simon Horman <horms@kernel.org>
Cc: willemdebruijn.kernel@gmail.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250709095653.62469-1-luyun_611@163.com>
 <20250709095653.62469-3-luyun_611@163.com>
 <20250709181434.GH721198@horms.kernel.org>
Content-Language: en-US
From: luyun <luyun_611@163.com>
In-Reply-To: <20250709181434.GH721198@horms.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wAn0Z93I29o3XTLDg--.384S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrZF45WFWDtw4ftFWfZry7Wrg_yoW3tFbEgr
	45u397Kry5Ar1jg3Z7Cw48ArsIgrZruFWqqry3ta4Uta90qrZrtr4Dur93J3WfZ3Zxtrsr
	K3ZrCrySyr1UujkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUjS1vDUUUUU==
X-CM-SenderInfo: pox130jbwriqqrwthudrp/1tbiOgGGzmhvITdkvgAAs4


在 2025/7/10 02:14, Simon Horman 写道:
> On Wed, Jul 09, 2025 at 05:56:53PM +0800, Yun Lu wrote:
>
> ...
>
>> @@ -2943,14 +2953,7 @@ static int tpacket_snd(struct packet_sock *po, struct msghdr *msg)
>>   		}
>>   		packet_increment_head(&po->tx_ring);
>>   		len_sum += tp_len;
>> -	} while (likely((ph != NULL) ||
>> -		/* Note: packet_read_pending() might be slow if we have
>> -		 * to call it as it's per_cpu variable, but in fast-path
>> -		 * we already short-circuit the loop with the first
>> -		 * condition, and luckily don't have to go that path
>> -		 * anyway.
>> -		 */
>> -		 (need_wait && packet_read_pending(&po->tx_ring))));
>> +	} while (likely(ph != NULL))
> A semicolon is needed at the end of the line above.

Sorry, this was my mistake. I will fix it in the next version.

Thank you for pointing it out.

>
>>   
>>   	err = len_sum;
>>   	goto out_put;


