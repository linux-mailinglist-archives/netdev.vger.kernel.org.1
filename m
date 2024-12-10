Return-Path: <netdev+bounces-150614-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FABF9EAEB5
	for <lists+netdev@lfdr.de>; Tue, 10 Dec 2024 11:54:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4FEE0188A24E
	for <lists+netdev@lfdr.de>; Tue, 10 Dec 2024 10:54:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A00E2210F47;
	Tue, 10 Dec 2024 10:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="CFVtL3Q/"
X-Original-To: netdev@vger.kernel.org
Received: from out30-100.freemail.mail.aliyun.com (out30-100.freemail.mail.aliyun.com [115.124.30.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E70723DEA7
	for <netdev@vger.kernel.org>; Tue, 10 Dec 2024 10:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733827826; cv=none; b=GuNNQWzWXSpfGnS8pXxHUa86wq6v5hpSoxDStxDWmKgVzZ6ZQwbr4OaqdCeNV4xLlwmxMFFjcKMwDbaOYubqsGHTIKZ0ozqfWMLNIo18avQhrtSwJD4C3riyrQbj45O+PBNNcqrHdK1owHZwh3l5kxZbgiddW9ltK07y4DQhl/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733827826; c=relaxed/simple;
	bh=Fi6qNclK3xfzfpKas4xGSFbhPysHiJDJVLkYE9pNg5M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GPC3weN4XRerfSNNApsB+sudq2WTqCgihNdtLWou46Jb/x5IybKUfPrr8W8kDt65NAK6eDlb9sFmMItGQafaaoDuEgcGHQ1DGnkMRJostt5GKS8CotZbKfUoKYK9eyGcLs5kIkBVy6oH1i5fCA5wx2C31UH1Oah+LN7t72YsBVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=CFVtL3Q/; arc=none smtp.client-ip=115.124.30.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1733827821; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=hmBfcKmV2wJeq3Z2Kd7xyuI7/I99uQ4PGBf4zEM1t6w=;
	b=CFVtL3Q/5uzA/8JiQwCwGQ5PhMr1s99WsuwLtNBFeGCZsmE5MwdR8sJ+2bz8XYVK81Fa5HHMHgx6XJMoRhoQa2DoEP1Hk1iuRkvFiCGbAmB2vujNpZxmLae81eczYHE8COLYpZIKT9kXAYul2BmK/bo2jagvkZisjNW+1hWS7bs=
Received: from 30.221.128.124(mailfrom:lulie@linux.alibaba.com fp:SMTPD_---0WLEmF9i_1733827503 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 10 Dec 2024 18:45:04 +0800
Message-ID: <d638ce16-3f3a-44dd-bcb0-983fc1ef2f66@linux.alibaba.com>
Date: Tue, 10 Dec 2024 18:45:03 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] udp: fix l4 hash after reconnect
To: Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
 David Ahern <dsahern@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 Simon Horman <horms@kernel.org>, Fred Chen <fred.cc@alibaba-inc.com>,
 Cambda Zhu <cambda@linux.alibaba.com>, Willem de Bruijn
 <willemb@google.com>, Stefano Brivio <sbrivio@redhat.com>
References: <4761e466ab9f7542c68cdc95f248987d127044d2.1733499715.git.pabeni@redhat.com>
 <CANn89i+aKNhzYKo3H3gx5Uhy4iPQ4p=6WDDF-0brGyR=PzJqjQ@mail.gmail.com>
 <CANn89i+k11E9XeJZwvgZ7VO0yr1nWge8+U-ESw2GLYDq7-sdBw@mail.gmail.com>
 <b46a7757-f311-4656-a114-68381d9856e3@redhat.com>
 <a4085013-daaf-4141-af56-cd438bf8b4c9@linux.alibaba.com>
 <63b0f262-066a-4f7b-b55a-a7f0ed4aa7f4@redhat.com>
From: Philo Lu <lulie@linux.alibaba.com>
In-Reply-To: <63b0f262-066a-4f7b-b55a-a7f0ed4aa7f4@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2024/12/10 16:32, Paolo Abeni wrote:
> On 12/7/24 03:34, Philo Lu wrote:
>> On 2024/12/7 00:23, Paolo Abeni wrote:
>>> On 12/6/24 17:01, Eric Dumazet wrote:
>>>> BTW, it seems that udp_lib_rehash() does the udp_rehash4()
>>>> only if the hash2 has changed.
>>>
>>> Oh, you are right, that requires a separate fix.
>>>
>>> @Philo: could you please have a look at that? basically you need to
>>> check separately for hash2 and hash4 changes.
>>
>> This is a good question. IIUC, the only affected case is when trying to
>> re-connect another remote address with the same local address
> 
> AFAICS, there is also another case: when re-connection using a different
> local addresses with the same l2 hash...
> 

Yes, you're right. I missed this case... Thank you for pointing out it.

>> (i.e.,
>> hash2 unchanged). And this will be handled by udp_lib_hash4(). So in
>> udp_lib_rehash() I put rehash4() inside hash2 checking, which means a
>> passive rehash4 following rehash2.
> 
> ... but even the latter case should be covered from the above.
> 
>> So I think it's more about the convention for rehash. We can choose the
>> better one.
> 
> IIRC a related question raised during code review for the udp L4 hash
> patches. Perhaps refactoring the code slightly to let udp_rehash()
> really doing the re-hashing and udp_hash really doing only the hashing
> could be worth.

Agreed. I'd appreciate it if someone helps to refactor it, or I can do 
this later myself.

-- 
Philo


