Return-Path: <netdev+bounces-293729-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ePeUFA16HWrEbAkAu9opvQ
	(envelope-from <netdev+bounces-293729-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 01 Jun 2026 14:24:45 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7336C61F3A2
	for <lists+netdev@lfdr.de>; Mon, 01 Jun 2026 14:24:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 63B20300B62A
	for <lists+netdev@lfdr.de>; Mon,  1 Jun 2026 12:17:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32011363C53;
	Mon,  1 Jun 2026 12:17:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="cea2avz5"
X-Original-To: netdev@vger.kernel.org
Received: from canpmsgout03.his.huawei.com (canpmsgout03.his.huawei.com [113.46.200.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBE062E9730
	for <netdev@vger.kernel.org>; Mon,  1 Jun 2026 12:17:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780316275; cv=none; b=a6rLwDKYjuv2RIlHkjIwcnNL/qzg0bamaKVQMKill6GZiYx84RfxOzE9eZNjqt8K56X1WXlKItZQogvaqa+xaM28b/olkoIGqurBa0c8Md9Adn0aelnfTnqe0+3oK9M4pHLDj4rPxBUv9xxWgM1bWtywbHi8nm4zJZAHhycRxGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780316275; c=relaxed/simple;
	bh=d3uvhYQD9xJChWxXYsqZSil6tkxxfyHQugVS/A+e1bQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=PYLYuxkA2/8PJEW9CgriDejmvC7EPz/EFJCAjWOWiL26aTE8NxhIJ+Rc0O2Suls6KpvNGgPFecUj6gEAWNLQ1UAQhbuO77wb69YpG1JrpK8o/9y/I5+J2gIvFndO5TeyRCr8Q/a3OmWkbmZwvRMHeb8o/hT2EmxLxYukcZSu6HQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=cea2avz5; arc=none smtp.client-ip=113.46.200.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=9+tYBVRgFlwjvVJ4KFk3CAjWNbcLhRu3+Zof6wPm/BM=;
	b=cea2avz5hfTAi3tSE+pUiqZCqFpWXvIoRVm7fr61OjWoBIXtC4bmuWFYjFHHgOzej4SRr8zgP
	KqG/QmjwxypaSTbOrE1H3f57uz4r/xnL1Pus0aZZ9LBhWWH77gfh3OWGaTFX+bWpdtbIqSguXpt
	y8jTS2Q62l6sm9TrjXJHUyI=
Received: from mail.maildlp.com (unknown [172.19.162.197])
	by canpmsgout03.his.huawei.com (SkyGuard) with ESMTPS id 4gTXpZ16JczpStx;
	Mon,  1 Jun 2026 20:10:14 +0800 (CST)
Received: from dggemv706-chm.china.huawei.com (unknown [10.3.19.33])
	by mail.maildlp.com (Postfix) with ESMTPS id 46A4540569;
	Mon,  1 Jun 2026 20:17:49 +0800 (CST)
Received: from kwepemq200002.china.huawei.com (7.202.195.90) by
 dggemv706-chm.china.huawei.com (10.3.19.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 1 Jun 2026 20:17:49 +0800
Received: from [10.174.177.223] (10.174.177.223) by
 kwepemq200002.china.huawei.com (7.202.195.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 1 Jun 2026 20:17:48 +0800
Message-ID: <70a09730-69bc-49cd-aa61-89e63ba766e3@huawei.com>
Date: Mon, 1 Jun 2026 20:17:47 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] xfrm: Fix dev use-after-free in xfrm async resumption
To: Steffen Klassert <steffen.klassert@secunet.com>
CC: <herbert@gondor.apana.org.au>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<horms@kernel.org>, <tpluszz77@gmail.com>, <netdev@vger.kernel.org>,
	<zhangchangzhong@huawei.com>, <xuchunxiao3@huawei.com>
References: <20260529092111.1089315-1-dongchenchen2@huawei.com>
 <ah0nmpeq6TNHtQqd@secunet.com>
From: "dongchenchen (A)" <dongchenchen2@huawei.com>
In-Reply-To: <ah0nmpeq6TNHtQqd@secunet.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems500001.china.huawei.com (7.221.188.70) To
 kwepemq200002.china.huawei.com (7.202.195.90)
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[huawei.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[huawei.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[gondor.apana.org.au,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,vger.kernel.org,huawei.com];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-293729-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[huawei.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[huawei.com:email,huawei.com:mid,huawei.com:dkim,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,linux.dev:url];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dongchenchen2@huawei.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-0.994];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 7336C61F3A2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

> On Fri, May 29, 2026 at 05:21:11PM +0800, Dong Chenchen wrote:
>> xfrm async resumption hold skb->dev refcnt until after transport_finish.
>> However, xfrm_rcv_cb may modify skb->dev to tunnel dev without taking
>> device reference, such as vti_rcv_cb. The subsequent async resumption
>> will decrement the tunnel device's reference count, which lead to uaf
>> of tunnel dev and refcnt leak of orig dev as below:
>>
>> unregister_netdevice: waiting for vti1 to become free. Usage count = -2
>>
>> Release refcnt of the original dev after tunnel rcv modify skb->dev to
>> fix it.
>>
>> Fixes: 1c428b038400 ("xfrm: hold dev ref until after transport_finish NF_HOOK")
>> Reported-by: Xu Chunxiao <xuchunxiao3@huawei.com>
>> Signed-off-by: Dong Chenchen <dongchenchen2@huawei.com>
>> ---
>>   net/xfrm/xfrm_input.c | 5 +++++
>>   1 file changed, 5 insertions(+)
>>
>> diff --git a/net/xfrm/xfrm_input.c b/net/xfrm/xfrm_input.c
>> index f65291eba1f6..c979872b6006 100644
>> --- a/net/xfrm/xfrm_input.c
>> +++ b/net/xfrm/xfrm_input.c
>> @@ -467,6 +467,7 @@ int xfrm_input(struct sk_buff *skb, int nexthdr, __be32 spi, int encap_type)
>>   {
>>   	const struct xfrm_state_afinfo *afinfo;
>>   	struct net *net = dev_net(skb->dev);
>> +	struct net_device *dev = skb->dev;
>>   	int err;
>>   	__be32 seq;
>>   	__be32 seq_hi;
>> @@ -730,6 +731,10 @@ int xfrm_input(struct sk_buff *skb, int nexthdr, __be32 spi, int encap_type)
>>   	if (err)
>>   		goto drop;
>>   
>> +	if (async && skb->dev != dev) {
>> +		dev_put(dev);
>> +		async = 0;
>> +	}
>>   	nf_reset_ct(skb);
>>   
>>   	if (decaps) {
> Sashiko found issues with this patch:
>
> https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260529092111.1089315-1-dongchenchen2%40huawei.com
>
> Please review!
>

Hi, Steffen! Thanks a lot for your review.

This patch indeed cannot fix all the issues in the branches.
Maybe we can stash original skb->dev and move dev_put in
transport_finish to xfrm_input to fix it.
But there is a question, xfrm_rcv_cb modify skb->dev to tunnel or
xfrmi dev without taking device reference. Is it safe to directly
access the new dev from skb in the subsequent async resumption?
Will this trigger the issue again mentioned in 1c428b038400 ("xfrm:
hold dev ref until after transport_finish NF_HOOK")? It seems that
it is difficult to protect new skb->dev within the xfrm_input process.

Best regards
Dong Chenchen


