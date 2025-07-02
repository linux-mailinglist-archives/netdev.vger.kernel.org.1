Return-Path: <netdev+bounces-203368-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C7CFAF59D9
	for <lists+netdev@lfdr.de>; Wed,  2 Jul 2025 15:45:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7C93316C6DB
	for <lists+netdev@lfdr.de>; Wed,  2 Jul 2025 13:45:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3893D27A469;
	Wed,  2 Jul 2025 13:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b="s3a3O6hS"
X-Original-To: netdev@vger.kernel.org
Received: from mailtransmit05.runbox.com (mailtransmit05.runbox.com [185.226.149.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9224A27934E;
	Wed,  2 Jul 2025 13:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751463905; cv=none; b=nn84h0S9z/+Ikrq2d1aEHvbwo7FXXBw/uF1z9w5+zIBUonTFKs2racypwt0+fh3/vXj7uxgfLWUVUMrrtwAKWm+EoUEXuRwOtS9I6FF4RJFzhnnKKvJzeLOyTRgXrakfpS6sRouJzjEd+7h9kEwVL71kCbA9HOUg8N7mgssCwGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751463905; c=relaxed/simple;
	bh=Y2grkxg0N8B51aUeuSlq2/V9Dl2hLIXtfZubj3Zlf4Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lRgcg3ljqr7lqouzvidE4LYZvMqAHmonmUdyKc/vM4H6hkvqHZm8+xY+IuyQ6TOHt2xyCuqPrcxLIr1Qghg/0QGCUp2eEZxHYwI50OhV+zAXFaB9j3WE7d/9amUySfnNU04hNIT5pNb/I83VEgJc+QdRDRQ00WrOqtHxhgxrfYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co; spf=pass smtp.mailfrom=rbox.co; dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b=s3a3O6hS; arc=none smtp.client-ip=185.226.149.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rbox.co
Received: from mailtransmit02.runbox ([10.9.9.162] helo=aibo.runbox.com)
	by mailtransmit05.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <mhal@rbox.co>)
	id 1uWxlc-00Gy6D-Sd; Wed, 02 Jul 2025 15:44:52 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
	s=selector2; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID;
	bh=qX/jOdSzRz/+vwxosLen+K6A+xjU8JPDn+hNaCdZIQk=; b=s3a3O6hSQAJbiB735qsO4CRorZ
	vD5Co14o2E5n5MQdGkSJJyywD+NDZiQNiDiZ/26L6IrnCKO17/+LgPRBQoPHE/SJZIxtlAdC5yDFw
	Z52q7Zp6aTgN/STzCVn1P1XrDOhAV5AJgeZPiewPTknRMNSR7usk0a26CqnqMElhthGzqV0GANPuW
	KB3P7GEYgJW5e5vu6WnpTqhW8o+6VOQJll0Qk0G5D9Wk+RrpFuTaexdJgrJ8/V9nJNlMkAw7qJTwa
	smQwvVpMvFiJWTTjfjOBmo8tUXbYhRqTuNyDDksixhCQXYHNPbOGLSez3nOtl9rEQvuSxY5lQSGlB
	dG4yotNg==;
Received: from [10.9.9.73] (helo=submission02.runbox)
	by mailtransmit02.runbox with esmtp (Exim 4.86_2)
	(envelope-from <mhal@rbox.co>)
	id 1uWxlb-0006jw-S2; Wed, 02 Jul 2025 15:44:52 +0200
Received: by submission02.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1uWxlS-009MyS-TB; Wed, 02 Jul 2025 15:44:43 +0200
Message-ID: <12e004b6-3f26-478b-953b-3b63a197479a@rbox.co>
Date: Wed, 2 Jul 2025 15:44:41 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 0/9] net: Remove unused function parameters in
 skbuff.c
To: Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Simon Horman <horms@kernel.org>,
 Neal Cardwell <ncardwell@google.com>, Kuniyuki Iwashima <kuniyu@google.com>,
 David Ahern <dsahern@kernel.org>, Boris Pismenny <borisp@nvidia.com>,
 John Fastabend <john.fastabend@gmail.com>,
 Ayush Sawal <ayush.sawal@chelsio.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 Wenjia Zhang <wenjia@linux.ibm.com>, Jan Karcher <jaka@linux.ibm.com>,
 "D. Wythe" <alibuda@linux.alibaba.com>, Tony Lu <tonylu@linux.alibaba.com>,
 Wen Gu <guwen@linux.alibaba.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
 linux-s390@vger.kernel.org
References: <20250626-splice-drop-unused-v2-0-3268fac1af89@rbox.co>
 <20250630181847.525a0ad6@kernel.org>
 <beea4b9f-657f-4f98-a853-e40a503e2274@rbox.co>
 <c405f957-0f88-4c88-98d7-3a27e5230fc8@redhat.com>
 <20250701165208.2e3443a0@kernel.org>
Content-Language: pl-PL, en-GB
From: Michal Luczaj <mhal@rbox.co>
In-Reply-To: <20250701165208.2e3443a0@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/2/25 01:52, Jakub Kicinski wrote:
> On Tue, 1 Jul 2025 11:02:50 +0200 Paolo Abeni wrote:
>>>> I feel a little ambivalent about the removal of the flags arguments.
>>>> I understand that they are unused now, but theoretically the operation
>>>> as a whole has flags so it's not crazy to pass them along.. Dunno.  
>>>
>>> I suspect you can say the same about @gfp. Even though they've both became
>>> irrelevant for the functions that define them. But I understand your
>>> hesitation. Should I post v3 without this/these changes?  
>>
>> Yes please, I think it would make the series less controversial.
>>
>> Also I feel like the gfp flag removal is less controversial, as is IMHO
>> reasonable that skb_splice_from_iter() would not allocate any memory.
> 
> +1, FWIW, gfp flags are more as need be the callee.

OK, here's v3 with @flags untouched:
https://lore.kernel.org/netdev/20250702-splice-drop-unused-v3-0-55f68b60d2b7@rbox.co/

>>> What's netdev's stance on using __always_unused in such cases?
> 
> Subjectively, I find the unused argument warnings in the kernel
> to usually be counter-productive. If a maintainer of a piece of code
> wants to clean them up -- perfectly fine. But taking cleanup patches
> and annotating with __always_unused doesn't see very productive.

Go it, thanks.

Michal


