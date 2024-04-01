Return-Path: <netdev+bounces-83719-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B9F0189381F
	for <lists+netdev@lfdr.de>; Mon,  1 Apr 2024 07:46:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 552791F211E6
	for <lists+netdev@lfdr.de>; Mon,  1 Apr 2024 05:46:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD5638C1D;
	Mon,  1 Apr 2024 05:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=david-bauer.net header.i=@david-bauer.net header.b="zHJwuD5F"
X-Original-To: netdev@vger.kernel.org
Received: from perseus.uberspace.de (perseus.uberspace.de [95.143.172.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 476782595
	for <netdev@vger.kernel.org>; Mon,  1 Apr 2024 05:45:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.143.172.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711950356; cv=none; b=InTkLnVnPkNTO1aL1sqx1yenv1pAxR6uVGw6Gf/9aSc0cV7mq8zdYPnO/ArGsDtoFFzfrtUROIv7kzMgZuwBC8lMIhE8wf1bRgdQFHkcL4AyBEXyBQIqDSS7Dj/JhYEo/LS2e/wsPTlB+oR9HDXO+psyNDZXT+XZt406ddMuhV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711950356; c=relaxed/simple;
	bh=qLMJZ2SI70DLe6+gQvsCQlVLb5KCc6uLkn67cl62yrc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OUcvvXHHp5tRLn0pAZkn8jpWPXzrN4qAeWuwiYGokLObp8lB7ycFEKy+nfyRx3aRkNG7SbKs5rqY2RepYkJKF7bqG2YEXfHsb5Xcq0oUAg7D+MkhpYpb+ohF2DJfos+uWksbMQ2h9ETlrA/qjmcGPAtvMVHBh32y9KQdbFQFVvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=david-bauer.net; spf=pass smtp.mailfrom=david-bauer.net; dkim=pass (4096-bit key) header.d=david-bauer.net header.i=@david-bauer.net header.b=zHJwuD5F; arc=none smtp.client-ip=95.143.172.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=david-bauer.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=david-bauer.net
Received: (qmail 11617 invoked by uid 988); 1 Apr 2024 05:45:49 -0000
Authentication-Results: perseus.uberspace.de;
	auth=pass (plain)
Received: from unknown (HELO unkown) (::1)
	by perseus.uberspace.de (Haraka/3.0.1) with ESMTPSA; Mon, 01 Apr 2024 07:45:49 +0200
Message-ID: <8ab8b3b5-a582-4002-90d9-56beefc7c682@david-bauer.net>
Date: Mon, 1 Apr 2024 07:45:48 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] vxlan: drop packets from invalid src-address
To: Ratheesh Kannoth <rkannoth@marvell.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, amcohen@nvidia.com, netdev@vger.kernel.org,
 Ido Schimmel <idosch@nvidia.com>
References: <20240331211434.61100-1-mail@david-bauer.net>
 <20240401030408.GA1638983@maili.marvell.com>
Content-Language: en-US
From: David Bauer <mail@david-bauer.net>
In-Reply-To: <20240401030408.GA1638983@maili.marvell.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Bar: ---
X-Rspamd-Report: BAYES_HAM(-2.999999) XM_UA_NO_VERSION(0.01) MIME_GOOD(-0.1)
X-Rspamd-Score: -3.089999
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=david-bauer.net; s=uberspace;
	h=from:to:cc:subject:date;
	bh=qLMJZ2SI70DLe6+gQvsCQlVLb5KCc6uLkn67cl62yrc=;
	b=zHJwuD5FGW+B5LqkySv09LQFSDGYYktsOVcciXe/L23ocNJmfetH5rxLLbvg2Ji2hSbtUnC3o/
	tUE7sB6388D+78KcMwFZ+fnwo1W4ilyP0kE2EXJdu7mMwE/H2VxrKIYB5rrD88YNWIesIzUIyXoP
	HvvOveolDmvpHjz69ydzgTGAuw0DGkE6PEcemGe9RBoUqA5q9oYHauL7onHbJn/ABeya/Sj+a0rl
	/UU+sCFkTU4KFafVZzFnkcHCmg8AWix8AiuSpTBcOGM4epRRK0WVs4EJxKW/y/mS3FRGAAS1fdOh
	eF35ZxWfXDTAglsaXxUaZ5d4J+/P+wnfaTMd2wlruCPo794gqmg+g4KNAXUYGEinisnHsk0Cs5Gu
	+ZynlNj6kHQ+tS7yq4oR0NK8wlzKhSZ2gXD/FPZQz2eLWiFCUI/gcU1cXohUlB0lcnKjVfq5oal9
	gJG/VafFdJZuKMXLTQBd02M4Y8nB3YQ2hwG22OqeC/NPNUE3scQMl5/q7zO5jUsBOyDhevLM/Fkd
	7g4I8NmN0+m1kIRfS3taC8ng1JPEFj0DJgQtfTn9ZKcnN1oivLKFfB8GhYqAVKOn/7UYaqP4b7qp
	Hw7geevdMnpDAOmfC2/LjCFS+RRWwmlK1h319UGiun7OqKFU1AVpfIvtSDINZwj5SNjTtARWWqUj
	A=

Hello Ratheesh,

On 4/1/24 05:04, Ratheesh Kannoth wrote:
> On 2024-04-01 at 02:44:34, David Bauer (mail@david-bauer.net) wrote:
>> The VXLAN driver currently does not check if the inner layer2
>> source-address is valid.
>>
>> In case source-address snooping/learning is enabled, a entry in the FDB
>> for the invalid address is created with the layer3 address of the tunnel
>> endpoint.
> what is root cause of creation of invalid MAC from an L3 address ? could you
> add that as well to commit message.

I sadly can not elaborate on this further as the state happens sporadically
after weeks of operation. For more details, see

https://lore.kernel.org/all/15ee0cc7-9252-466b-8ce7-5225d605dde8@david-bauer.net/T/

Best
David

> 
>>
>> If the frame happens to have a non-unicast address set, all this
>> non-unicast traffic is subsequently not flooded to the tunnel network
>> but sent to the learnt host in the FDB. To make matters worse, this FDB
>> entry does not expire.
>>
>> Apply the same filtering for packets as it is done for bridges. This not
>> only drops these invalid packets but avoids them from being learnt into
>> the FDB.
>>
>> Suggested-by: Ido Schimmel <idosch@nvidia.com>
>> Signed-off-by: David Bauer <mail@david-bauer.net>
>> ---
>>   drivers/net/vxlan/vxlan_core.c | 4 ++++
>>   1 file changed, 4 insertions(+)
>>
>> diff --git a/drivers/net/vxlan/vxlan_core.c b/drivers/net/vxlan/vxlan_core.c
>> index 3495591a5c29..ba319fc21957 100644
>> --- a/drivers/net/vxlan/vxlan_core.c
>> +++ b/drivers/net/vxlan/vxlan_core.c
>> @@ -1615,6 +1615,10 @@ static bool vxlan_set_mac(struct vxlan_dev *vxlan,
>>   	if (ether_addr_equal(eth_hdr(skb)->h_source, vxlan->dev->dev_addr))
>>   		return false;
>>
>> +	/* Ignore packets from invalid src-address */
>> +	if (!is_valid_ether_addr(eth_hdr(skb)->h_source))
>> +		return false;
>> +
>>   	/* Get address from the outer IP header */
>>   	if (vxlan_get_sk_family(vs) == AF_INET) {
>>   		saddr.sin.sin_addr.s_addr = ip_hdr(skb)->saddr;
>> --
>> 2.43.0
>>

