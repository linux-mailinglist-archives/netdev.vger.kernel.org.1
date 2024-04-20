Return-Path: <netdev+bounces-89824-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AEC78ABC03
	for <lists+netdev@lfdr.de>; Sat, 20 Apr 2024 16:39:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5AF0FB20D28
	for <lists+netdev@lfdr.de>; Sat, 20 Apr 2024 14:39:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 125E21EA8D;
	Sat, 20 Apr 2024 14:39:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=david-bauer.net header.i=@david-bauer.net header.b="VxPDBvD+"
X-Original-To: netdev@vger.kernel.org
Received: from perseus.uberspace.de (perseus.uberspace.de [95.143.172.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5F53625
	for <netdev@vger.kernel.org>; Sat, 20 Apr 2024 14:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.143.172.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713623966; cv=none; b=U5lqDl493bl3+E4qdb2jDelyAKUSNYx82WKQsdrp3CbbbKlNHbY9nyrVtKIpfm8RHZw8CvdBDD14F4QK6UjrO9YOUX+xOCZFJbbj0Pg+WmLI0FLCK1tleebrWWZclMJzj3UirEb6Vj0GGI5akaP1zdicJX/tL898AyAluciHavg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713623966; c=relaxed/simple;
	bh=WV89SXiF4uAWjlxilVNQ0sHfACU2rQFh+uBaMbTlC3E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UFZe5CpPxsnGpcSfwQS28+ukgNQs0YCNVS6+CX23lNLQU7bxLblhrlBqYvvKbe8HoAVAYp0LOqW+VpCdlM3Fqt/puR6EvqzjYz8SL5Om3NQHGPcRtx+WGs0G3muBOpg0hddQa/l90oWSa1lfhaQA37+3QvBBOT3oTgEBWp3WHBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=david-bauer.net; spf=pass smtp.mailfrom=david-bauer.net; dkim=pass (4096-bit key) header.d=david-bauer.net header.i=@david-bauer.net header.b=VxPDBvD+; arc=none smtp.client-ip=95.143.172.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=david-bauer.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=david-bauer.net
Received: (qmail 19279 invoked by uid 988); 20 Apr 2024 14:39:20 -0000
Authentication-Results: perseus.uberspace.de;
	auth=pass (plain)
Received: from unknown (HELO unkown) (::1)
	by perseus.uberspace.de (Haraka/3.0.1) with ESMTPSA; Sat, 20 Apr 2024 16:39:19 +0200
Message-ID: <5aaa43fb-cc44-4af8-8c78-201bcc04ea00@david-bauer.net>
Date: Sat, 20 Apr 2024 16:39:19 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] net l2tp: drop flow hash on forward
To: Daniel Golle <daniel@makrotopia.org>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, netdev@vger.kernel.org
References: <20240420133940.5476-1-mail@david-bauer.net>
 <ZiPLEdv97kX39k21@makrotopia.org>
Content-Language: en-US
From: David Bauer <mail@david-bauer.net>
Autocrypt: addr=mail@david-bauer.net; keydata=
 xjMEZgynMBYJKwYBBAHaRw8BAQdA+32xE63/l6uaRAU+fPDToCtlZtYJhzI/dt3I6VxixXnN
 IkRhdmlkIEJhdWVyIDxtYWlsQGRhdmlkLWJhdWVyLm5ldD7CjwQTFggANxYhBLPGu7DmE/84
 Uyu0uW0x5c9UngunBQJmDKcwBQkFo5qAAhsDBAsJCAcFFQgJCgsFFgIDAQAACgkQbTHlz1Se
 C6eKAwEA8B6TGkUMw8X7Kv3JdBIoDqJG9+fZuuwlmFsRrdyDyHkBAPtLydDdancCVWNucImJ
 GSk+M80qzgemqIBjFXW0CZYPzjgEZgynMBIKKwYBBAGXVQEFAQEHQPIm0qo7519c7VUOTAUD
 4OR6mZJXFJDJBprBfnXZUlY4AwEIB8J+BBgWCAAmFiEEs8a7sOYT/zhTK7S5bTHlz1SeC6cF
 AmYMpzAFCQWjmoACGwwACgkQbTHlz1SeC6fP2AD8CduoErEo6JePUdZXwZ1e58+lAeXOLLvC
 2kj1OiLjqK4BANoZuHf/ku8ARYjUdIEgfgOzMX/OdYvn0HiaoEfMg7oB
In-Reply-To: <ZiPLEdv97kX39k21@makrotopia.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Bar: ---
X-Rspamd-Report: BAYES_HAM(-2.999999) XM_UA_NO_VERSION(0.01) MIME_GOOD(-0.1)
X-Rspamd-Score: -3.089999
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=david-bauer.net; s=uberspace;
	h=from:to:cc:subject:date;
	bh=WV89SXiF4uAWjlxilVNQ0sHfACU2rQFh+uBaMbTlC3E=;
	b=VxPDBvD+WCa1NvYLOe4OEBWi5e8LgvLrskKv7Wso1fGsEo8as1oQa1aJv4J8ElHgK4qt83aJpo
	73ij9fvMLM2SK9aaGX2KVTh62gHOCbFj2DIx7xOf0Xk9kJKwJWp9qRELgJPeVnLidsiiub251MQB
	PLn7RA5gv9h2Q2VRU4a6sNKCNsI2E9P3LypUNC3Rkj0ZQGOXyfwNQwU+yk03qE2scEOGvPG0oPmz
	odwSAHYw2ywBfmbjVO60g8RTQGx1BwtEYtd60AH25rpM6f6FYUQmdwKNHOljF5fSOYRqLE6cu7IJ
	vkP0Hw3ovxpSlBrWy+5gvoCWrK/a8W8OJQ/3XUkiBrs0nH5h7OP01Nfi5t5H8zg7W0gVGmGX7gPR
	Wi3ZGedVjWMMpZX5r/zLZYGJweSxT8S0M1hDDIEXb7C0Cj5jAzRTDKiVC0lPum1jJxYjefZlbJzI
	XJiJRhu5tq/6gqhOrCY1pz1OhZ5AI75NuoOP1AFHKPqBQTx+OYqdA1UJAM2/75v3siW+ZZ9cax4w
	9eby4zTpn7MhEA/FbMkcbqqaasdNxSZRRqvYG9xYJHpHWz0ZKE0F/pirCPRRWzGplKqm8hUOlbrX
	BL+nqSePg0C+0yHwgMfRq2H7F+B3PjmDrlHFoWa9UmGa7gYzRew91ua6BavVGkKKRnXK8JhSjzFQ
	U=

Hi Daniel,

On 4/20/24 16:02, Daniel Golle wrote:
> On Sat, Apr 20, 2024 at 03:39:40PM +0200, David Bauer wrote:
>> Drop the flow-hash of the skb when forwarding to the L2TP netdev.
>>
>> This avoids the L2TP qdisc from using the flow-hash from the outer
>> packet, which is identical for every flow within the tunnel.
>>
>> This does not affect every platform but is specific for the ethernet
>> driver. It depends on the platform including L4 information in the
>> flow-hash.
>>
>> One such example is the Mediatek Filogic MT798x family of networking
>> processors.
>>
>> Signed-off-by: David Bauer <mail@david-bauer.net>
> 
> While it's difficult to say which exact commit this fixes, I still
> consider it being a fix, as otherwise flow-offloading on mentioned
> platforms will face difficulties when using L2TP (right?).

I'm unsure whether flow-offloading is affected. What is definitely affected are
network schedulers which rely on flow-information (such as fq_codel or cake)

> Hence maybe it should go via 'net' tree rather than via 'net-next'?

I was unsure where to send, i can resend it on net if it is more appropriate.

Best
David

> 
> The fix itself looks fine to me.
> 
>> ---
>>   net/l2tp/l2tp_eth.c | 3 +++
>>   1 file changed, 3 insertions(+)
>>
>> diff --git a/net/l2tp/l2tp_eth.c b/net/l2tp/l2tp_eth.c
>> index 39e487ccc468..8ba00ad433c2 100644
>> --- a/net/l2tp/l2tp_eth.c
>> +++ b/net/l2tp/l2tp_eth.c
>> @@ -127,6 +127,9 @@ static void l2tp_eth_dev_recv(struct l2tp_session *session, struct sk_buff *skb,
>>   	/* checksums verified by L2TP */
>>   	skb->ip_summed = CHECKSUM_NONE;
>>   
>> +	/* drop outer flow-hash */
>> +	skb_clear_hash(skb);
>> +
>>   	skb_dst_drop(skb);
>>   	nf_reset_ct(skb);
>>   
>> -- 
>> 2.43.0
>>
>>

