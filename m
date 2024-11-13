Return-Path: <netdev+bounces-144275-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 253EC9C66E5
	for <lists+netdev@lfdr.de>; Wed, 13 Nov 2024 02:50:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9DF5E1F254C8
	for <lists+netdev@lfdr.de>; Wed, 13 Nov 2024 01:50:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C936743ABC;
	Wed, 13 Nov 2024 01:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="CFeIdwQP"
X-Original-To: netdev@vger.kernel.org
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB2D2433AB;
	Wed, 13 Nov 2024 01:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731462622; cv=none; b=H1PR2VdBNBqRjKEvTZAmCbPHTB9MKvOuC+DlG21AYmm5MuKI3W1gv+dBbS53usnhTqZDzt8oDgNEPx9InN+yMLw7xGOkSpBFT4sddPXb3wnBAbEnen9lVTwg3iCbkL9dBDFhfnZmSfZOrD27IDiVYOWxi8Rwv0KWnIUS5nihBB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731462622; c=relaxed/simple;
	bh=uG6reBs91moH2PzKECRwJ3Gg7woMry9/s+xOesV5eEI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HHv5ikxb5qfFCiBFpuevyqk/KGyKd/beUfCODLbFRybm+4psNiAAvY/wH8efiq44rKgINY1/+xPafBXPr8GnuzUuBtoi7WCj4DD6vBj8Qa0JmA4+KdIN3xlnAnM3cqFG52MxNYcXLZgIPvXrnOKNlhZwcYoqyE946/ZEggGq6ww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=CFeIdwQP; arc=none smtp.client-ip=115.124.30.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1731462615; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=FOkMQdZjuP23Bbo0k0BJfY/bg4d+4bPwc5ocgxsFDYM=;
	b=CFeIdwQPQNs+cwxVS1SPfc5HhLlqXEB8aPauGEQkM/yoz53eWWmLl/NUtFP/CMpHquWc3UJ0MdfYivHdsT1vjHp5K4Cj41c6V4PNz+ofW1xg2IYdCNhYEyP4KMP80slf2tiGW4Ti8E0QVT/EJxKfXD0DmklmUmpow87FG9u6gLg=
Received: from 30.221.99.195(mailfrom:lulie@linux.alibaba.com fp:SMTPD_---0WJJC5Xr_1731462613 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 13 Nov 2024 09:50:14 +0800
Message-ID: <14a1a4a1-7281-4715-bf6e-73d3dd5417ef@linux.alibaba.com>
Date: Wed, 13 Nov 2024 09:50:13 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 net-next 3/4] ipv4/udp: Add 4-tuple hash for connected
 socket
To: Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org
Cc: willemdebruijn.kernel@gmail.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, dsahern@kernel.org, horms@kernel.org,
 antony.antony@secunet.com, steffen.klassert@secunet.com,
 linux-kernel@vger.kernel.org, dust.li@linux.alibaba.com,
 jakub@cloudflare.com, fred.cc@alibaba-inc.com,
 yubing.qiuyubing@alibaba-inc.com
References: <20241108054836.123484-1-lulie@linux.alibaba.com>
 <20241108054836.123484-4-lulie@linux.alibaba.com>
 <a1db0c11-38ee-4932-86bc-a397a0ecf963@redhat.com>
From: Philo Lu <lulie@linux.alibaba.com>
In-Reply-To: <a1db0c11-38ee-4932-86bc-a397a0ecf963@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2024/11/12 22:58, Paolo Abeni wrote:
> On 11/8/24 06:48, Philo Lu wrote:
> [...]
>> Signed-off-by: Philo Lu <lulie@linux.alibaba.com>
>> Signed-off-by: Cambda Zhu <cambda@linux.alibaba.com>
>> Signed-off-by: Fred Chen <fred.cc@alibaba-inc.com>
>> Signed-off-by: Yubing Qiu <yubing.qiuyubing@alibaba-inc.com>
> 
> [...]
>> @@ -2937,7 +3128,7 @@ struct proto udp_prot = {
>>   	.owner			= THIS_MODULE,
>>   	.close			= udp_lib_close,
>>   	.pre_connect		= udp_pre_connect,
>> -	.connect		= ip4_datagram_connect,
>> +	.connect		= udp_connect,
>>   	.disconnect		= udp_disconnect,
>>   	.ioctl			= udp_ioctl,
>>   	.init			= udp_init_sock,
> 
> 2 minor notes, possibly not needing a repost:
> 
> - The SoB chain looks strange, do you mean co-developed-by actually?

Yes, we're all involved in the development. I think it could be 
indicated by SoBs (and all of us agree with this). Please let me know if 
I'm wrong :)

Or strictly as [1], it should be:

Co-developed-by: Cambda Zhu <cambda@linux.alibaba.com>
Signed-off-by: Cambda Zhu <cambda@linux.alibaba.com>
Co-developed-by: Fred Chen <fred.cc@alibaba-inc.com>
Signed-off-by: Fred Chen <fred.cc@alibaba-inc.com>
Co-developed-by: Yubing Qiu <yubing.qiuyubing@alibaba-inc.com>
Signed-off-by: Yubing Qiu <yubing.qiuyubing@alibaba-inc.com>
Signed-off-by: Philo Lu <lulie@linux.alibaba.com>

[1]
https://www.kernel.org/doc/html/latest/process/submitting-patches.html#when-to-use-acked-by-cc-and-co-developed-by

> - udplite is not touched. AFAICS should not be a problem - just the
> feature will not be available for udplite. 

Agreed. Theoretically, the feature relies on udp4_hash4/udp6_hash4 when 
connecting, and all other functions including lookup/unhash/rehash 
always check "hashed4" firstly, and do nothing if it's false (which is 
the case for udplite).

AFAICT, the effects to udplite include:
- Additional memory consumption in udp_sock and udptable
- Control path: udp_hashed4 checking when unhash/rehash
- Data path: udp_has_hash4 checking when lookup
              (like unconnected sks in udp)

> I'm wondering if syzbot could
> prove me wrong about "not being a problem" (usually it's able to do that;)
> 
> /P
> 

Thanks.
-- 
Philo


