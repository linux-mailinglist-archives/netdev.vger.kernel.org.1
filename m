Return-Path: <netdev+bounces-151904-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D6D129F1950
	for <lists+netdev@lfdr.de>; Fri, 13 Dec 2024 23:46:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 510AA1887F10
	for <lists+netdev@lfdr.de>; Fri, 13 Dec 2024 22:46:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A70D7194A45;
	Fri, 13 Dec 2024 22:46:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="MxeCU9HA"
X-Original-To: netdev@vger.kernel.org
Received: from out-183.mta1.migadu.com (out-183.mta1.migadu.com [95.215.58.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD9D11946AA
	for <netdev@vger.kernel.org>; Fri, 13 Dec 2024 22:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734129992; cv=none; b=W/ehlD/xtPX+3IdlLZU3Rr+aRdceBfJPEhaLf4aAlZeNxlQePWr4oR37bvQhlNmtn3CseIuQslHilzVikxZzjnnkhrlgPtb8IlAvp2dHwZce/KJH4ib+y67Kw1Gmt43f/e9nwx6S3TAYcEl+2BVvd2VMn022MwEZgW89dd68Cqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734129992; c=relaxed/simple;
	bh=pldTG33Z3ZiKjZyS6wsPvmta2kq7xnN/YDpPNoiExao=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dTSKkRM5oIwASQo/1KImprFrqmJPdc3opgrkRw1oGDePw7dQ37bJMjE++eIGpvILeq/wQSFZy+//mXb16eNAw9krKcBpIMFrsd3H5oN2uP9uGcIdsFt4Wgu3JlZMIcCJDJge+5O5iITgKNCwh8Z/cKoUBOIxNujP3EpkP0hkNnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=MxeCU9HA; arc=none smtp.client-ip=95.215.58.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <b6fe9866-99d1-4715-8d95-9fcef4ac8064@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1734129978;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KaODDZWd2snUEdraqNCS4T9Pt9wv1svzoBdSYaBYfnU=;
	b=MxeCU9HAbowWvuMvJvwROOcD05Rn0CO06gafTr7vfKmhYZKLVoOl0pZPepDimv/8joHOlX
	YuBKeCQcgCSDj4SctrR01zgN4bD3xaPwuHTFUIojGWmyMNJfaI3jhdDiDPfjuxxPjtiHDx
	2xQBHGZgaVtm4rg7PjTXbU+uKjcA14w=
Date: Fri, 13 Dec 2024 14:46:09 -0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next v4 06/11] net-timestamp: support SCM_TSTAMP_ACK
 for bpf extension
To: Jason Xing <kerneljasonxing@gmail.com>, willemdebruijn.kernel@gmail.com
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, dsahern@kernel.org, willemb@google.com, ast@kernel.org,
 daniel@iogearbox.net, andrii@kernel.org, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, bpf@vger.kernel.org,
 netdev@vger.kernel.org, Jason Xing <kernelxing@tencent.com>
References: <20241207173803.90744-1-kerneljasonxing@gmail.com>
 <20241207173803.90744-7-kerneljasonxing@gmail.com>
 <6ccdc72c-f21c-4b02-aba3-b70363e58982@linux.dev>
 <CAL+tcoD+hf+o8SFpnxLRQPKiuqopbHMbU5taap=Va+0hMjJP5A@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
Content-Language: en-US
In-Reply-To: <CAL+tcoD+hf+o8SFpnxLRQPKiuqopbHMbU5taap=Va+0hMjJP5A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 12/13/24 6:49 AM, Jason Xing wrote:
>>> diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
>>> index 5bdf13ac26ef..82bb26f5b214 100644
>>> --- a/net/ipv4/tcp_input.c
>>> +++ b/net/ipv4/tcp_input.c
>>> @@ -3321,7 +3321,8 @@ static void tcp_ack_tstamp(struct sock *sk, struct sk_buff *skb,
>>>        const struct skb_shared_info *shinfo;
>>>
>>>        /* Avoid cache line misses to get skb_shinfo() and shinfo->tx_flags */
> Please take a look at the above comment.
> 
>>> -     if (likely(!TCP_SKB_CB(skb)->txstamp_ack))
>>> +     if (likely(!TCP_SKB_CB(skb)->txstamp_ack &&
>>> +                !TCP_SKB_CB(skb)->txstamp_ack_bpf))
>> Change the test here to:
>>          if (likely(!TCP_SKB_CB(skb)->txstamp_ack &&
>>                     !(skb_shinfo(skb)->tx_flags & SKBTX_BPF)))
>>
>> Does it make sense?
> It surely works. Talking about the result only, introducing SKBTX_BPF
> can work for all the cases. However, in the ACK case, the above code
> snippet will access the shinfo->tx_flags, which triggers cache line
> misses. I also mentioned this on purpose in the patch [06/11].

ah. my bad. I somehow totally skipped the comment and message in this patch when 
jumping between patch 6 and 7.

Not an expert. so curious if it matters testing skb_shinfo(skb)->tx_flags or not 
here? e.g. The tcp_v4_fill_cb() in the earlier rx path, 
skb_hwtstamps(skb)->hwtstamp is also read. Willem?

