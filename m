Return-Path: <netdev+bounces-163275-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E4A3A29C3B
	for <lists+netdev@lfdr.de>; Wed,  5 Feb 2025 22:57:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1B29C162584
	for <lists+netdev@lfdr.de>; Wed,  5 Feb 2025 21:57:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFAC7215177;
	Wed,  5 Feb 2025 21:57:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="hGembKvR"
X-Original-To: netdev@vger.kernel.org
Received: from out-175.mta0.migadu.com (out-175.mta0.migadu.com [91.218.175.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE43A211A16
	for <netdev@vger.kernel.org>; Wed,  5 Feb 2025 21:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738792646; cv=none; b=Itdeo4QhyiD/Z89EyqLqiRSxHLdfTHOYCyYCjLq3QYy2eaBHJ3AK56cK4DnfW2GE/3sl2hI9GkhmrDqF+8TV0GGddWgjBnRZM4GCdm1Lr9jl98QIxHwcn0aPO82Lry3mYUHE21+TbktQMnk3bmsRZvYc5Hs9WuAtgJzsRkAg/MI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738792646; c=relaxed/simple;
	bh=XNxJogf+OuW71OjrwGGbXk604JKtAoIw+/L1gNiKZQs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jgO9qNA0HKxkCaA8RdK3H5BQdC6E0lwtY0WSnoiFP6dVaoGOyGnMhR1rlZ1yuSbxolZ0S/hvl0FHHGYnrW0vSPjcwdRdg53jBqy7E5tEiTAQVbALmynNWi2ImtyaoOyLVVIslSoEAP9CfVKuAcVarC5a7X9EyGzVtEaCvJ0q2D0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=hGembKvR; arc=none smtp.client-ip=91.218.175.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <e894c427-b4b3-4706-b44c-44fc6402c14c@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1738792638;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9QrQeyGQpv/DxzW4SJbezs8+5KVwqv1dRrxu3HhgzLE=;
	b=hGembKvR62QQrtMLbNr9QpZ+r7ZCSpqqnM4ekIr7H5MxZvIgy25n4gMWwRD5lKhjc2XIzx
	ud87HX0OBHzslkDuTb2X5vISeZfOU+b+fkCvESkDF7MK/tW84HiVS8HxFZvJxLu2jDmWFj
	O/4/aY2QGzQejQ2ph0+LsaYtefLYlZk=
Date: Wed, 5 Feb 2025 13:57:11 -0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v8 10/12] bpf: make TCP tx timestamp bpf
 extension work
To: Jakub Kicinski <kuba@kernel.org>, Jason Xing <kerneljasonxing@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 dsahern@kernel.org, willemdebruijn.kernel@gmail.com, willemb@google.com,
 ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, eddyz87@gmail.com,
 song@kernel.org, yonghong.song@linux.dev, john.fastabend@gmail.com,
 kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org,
 horms@kernel.org, bpf@vger.kernel.org, netdev@vger.kernel.org
References: <20250204183024.87508-1-kerneljasonxing@gmail.com>
 <20250204183024.87508-11-kerneljasonxing@gmail.com>
 <20250204175744.3f92c33e@kernel.org>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20250204175744.3f92c33e@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 2/4/25 5:57 PM, Jakub Kicinski wrote:
> On Wed,  5 Feb 2025 02:30:22 +0800 Jason Xing wrote:
>> +	if (cgroup_bpf_enabled(CGROUP_SOCK_OPS) &&
>> +	    SK_BPF_CB_FLAG_TEST(sk, SK_BPF_CB_TX_TIMESTAMPING) && skb) {
>> +		struct skb_shared_info *shinfo = skb_shinfo(skb);
>> +		struct tcp_skb_cb *tcb = TCP_SKB_CB(skb);
>> +
>> +		tcb->txstamp_ack_bpf = 1;
>> +		shinfo->tx_flags |= SKBTX_BPF;
>> +		shinfo->tskey = TCP_SKB_CB(skb)->seq + skb->len - 1;
>> +	}
> 
> If BPF program is attached we'll timestamp all skbs? Am I reading this
> right?

If the attached bpf program explicitly turns on the SK_BPF_CB_TX_TIMESTAMPING 
bit of a sock, then all skbs of this sock will be tx timestamp-ed.

> 
> Wouldn't it be better to let BPF_SOCK_OPS_TS_SND_CB return whether it's
> interested in tracing current packet all the way thru the stack?

I like this idea. It can give the BPF prog a chance to do skb sampling on a 
particular socket.

The return value of BPF_SOCK_OPS_TS_SND_CB (or any cgroup BPF prog return value) 
already has another usage, which its return value is currently enforced by the 
verifier. It is better not to convolute it further.

I don't prefer to add more use cases to skops->reply either, which is an union 
of args[4], such that later progs (in the cgrp prog array) may lose the args value.

Jason, instead of always setting SKBTX_BPF and txstamp_ack_bpf in the kernel, a 
new BPF kfunc can be added so that the BPF prog can call it to selectively set 
SKBTX_BPF and txstamp_ack_bpf in some skb.

