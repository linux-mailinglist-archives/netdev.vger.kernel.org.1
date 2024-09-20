Return-Path: <netdev+bounces-129099-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AF1DD97D736
	for <lists+netdev@lfdr.de>; Fri, 20 Sep 2024 17:01:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E1E7A1C20C8B
	for <lists+netdev@lfdr.de>; Fri, 20 Sep 2024 15:01:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FBA717BB03;
	Fri, 20 Sep 2024 15:01:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uf+3gqZX"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEB921EA84
	for <netdev@vger.kernel.org>; Fri, 20 Sep 2024 15:01:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726844477; cv=none; b=tMJ0jhvYhy4MG7E4FFmEySe5t83PyZXr6mndbgEe6f/UIxmjoOoGskDBp029JwWID0lYqjLlit2pvt7+zwUT+KeyH5GcG3dk8cWJBk8D1X3j4NS14K5uzLs6XtDXqzBjy3AjS2DNRD+sLYJS8ytb6I2F6XuWFXvBVl4J/FuvCio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726844477; c=relaxed/simple;
	bh=xEGBDba8j1GwCH4HvCavBmHzighR9iS07g1LT5IZreg=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=hoWXB1vwL8UaedRrFvdQs12nrmXOoiqjWeedMAufHft7eAjLcs1hT4LPb5QIQsz0CL3EqxHk5/6wFo0gIXlekHIou8fi8Y+6/5EdgxMPkXdX9ZIp0u9NHCcBHsCTObe2mlrlMoHlQHW1PhpLbKHlZuLtbSxOi5JWRB5vMFjNkas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uf+3gqZX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B093C4CEC3;
	Fri, 20 Sep 2024 15:01:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726844476;
	bh=xEGBDba8j1GwCH4HvCavBmHzighR9iS07g1LT5IZreg=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=uf+3gqZXdDehXsHe55kqVMBKu5DTwvNNUB2YTmigWkW05QYS4hMdRCBS9N8f7QRo7
	 sRNPg9aCZwRqXfh2AlgRHzqp8Ndtaa6koeBbZp+Ld3JvPRGiPyfOmpF0PvwScTC09I
	 O2mK5SGvBJ3RfKMUIxpgrw2Aq/JNhCoq3+WYxXY9MRoP2xAh7+JqfPdClvfofNzV2v
	 +Hbevwe8qsJKWq+K6QpdJVB73Ph8UAJnQMJegHWeawRaBek7wpGp9ESXgB+KJfj5rn
	 HqOspoFr+M66KJPvvpQbvEJju62WDc8demziJFYWIFV5id/GRVecziWGqsbE0zfTHD
	 I0JWkJt2i+b1Q==
Message-ID: <daa7deb0-8412-4aa3-ab76-a2244995c3f3@kernel.org>
Date: Fri, 20 Sep 2024 09:01:15 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] af_packet: Fix softirq mismatch in tpacket_rcv
Content-Language: en-US
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
 Ben Greear <greearb@candelatech.com>, netdev@vger.kernel.org,
 Ido Schimmel <idosch@nvidia.com>
References: <20240918205719.64214-1-greearb@candelatech.com>
 <66ec149daf042_2deb5229470@willemb.c.googlers.com.notmuch>
 <0bbcd0f2-42e1-4fdc-a9bd-49dd3506c7f4@candelatech.com>
 <66ec5500c3b26_2e963829496@willemb.c.googlers.com.notmuch>
 <05371e60-fe62-4499-b640-11c0635a5186@kernel.org>
 <05765015-f727-2f30-58da-2ad6fa7ea99f@candelatech.com>
 <66ed3904738bb_3136a8294eb@willemb.c.googlers.com.notmuch>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <66ed3904738bb_3136a8294eb@willemb.c.googlers.com.notmuch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/20/24 2:57 AM, Willem de Bruijn wrote:
> Ben Greear wrote:
>> On 9/19/24 13:00, David Ahern wrote:
>>> On 9/19/24 10:44 AM, Willem de Bruijn wrote:
>>>> Yes, it seems that VRF calls dev_queue_xmit_nit without the same BH
>>>> protections that it expects.
>>>>
>>>> I suspect that the fix is in VRF, to disable BH the same way that
>>>> __dev_queue_xmit does, before calling dev_queue_xmit_nit.
>>>>
>>>
>>> commit 504fc6f4f7f681d2a03aa5f68aad549d90eab853 removed the bh around
>>> dev_queue_xmit_nit:
>>>
>>> diff --git a/drivers/net/vrf.c b/drivers/net/vrf.c
>>> index 6043e63b42f9..43f374444684 100644
>>> --- a/drivers/net/vrf.c
>>> +++ b/drivers/net/vrf.c
>>> @@ -638,9 +638,7 @@ static void vrf_finish_direct(struct sk_buff *skb)
>>>                  eth_zero_addr(eth->h_dest);
>>>                  eth->h_proto = skb->protocol;
>>>
>>> -               rcu_read_lock_bh();
>>>                  dev_queue_xmit_nit(skb, vrf_dev);
>>> -               rcu_read_unlock_bh();
>>>
>>>                  skb_pull(skb, ETH_HLEN);
>>>          }
>>
>> So I guess we should revert this? 
> 
> Looks like it to me.
> 
> In which case good to not just revert, but explain why, and probably
> copy the comment that is present in __dev_queue_xmit.
> 

Ben: does it resolve the problem you were investigating?

It would be good to add a selftest that sets up a VRF, attaches tcpdump
and then sends a few seconds of iperf3 traffic through it. That should
be similar to the use case here and I expect it to create a similar
crash. That should help prevent a regression in addition to the comment.


