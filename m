Return-Path: <netdev+bounces-255679-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wPK0HSPPf2mqxwIAu9opvQ
	(envelope-from <netdev+bounces-255679-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 01 Feb 2026 23:09:39 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B8B95C7581
	for <lists+netdev@lfdr.de>; Sun, 01 Feb 2026 23:09:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5A5D73005794
	for <lists+netdev@lfdr.de>; Sun,  1 Feb 2026 22:09:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F36E2E975E;
	Sun,  1 Feb 2026 22:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b="due/wvn7"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C6A31DF751
	for <netdev@vger.kernel.org>; Sun,  1 Feb 2026 22:09:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769983774; cv=none; b=ivgE/hqfuNJrDABhwAuWSKoqf7zNphuOpVypZg8W32CuSrjC7Uzjlj5ZNIsq6x2L0SznJGRT1+Ix1WzFgICB6YXWb04w73VYF5ciyE6T7KtCoZflWnkZzru4lKURq9fpa5h5hbab164Y4B/bsWXzSmFH1aMfufrYBRiaD6zMZvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769983774; c=relaxed/simple;
	bh=JM15UKXeJzdijzrGgJ2NdmQsbx2yOp3QX/8hr3ooJnc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BOhiKCm2UA8M9l+ZJ6l391RPb+JX7XEqeRk8Ed6Qlyf+MV3jCs0l3QpNEtNPeOl19IHJrB/dbXxXG3LzepZZ82c4/kY6x+nGOL58TQ0B5HK/s+hkq2QC6QOqjnH/N31rscQ4sAraigHFJXg4axRL4dsAwu3hkksf1BexCYFt/Pg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk; spf=none smtp.mailfrom=davidwei.uk; dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b=due/wvn7; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=davidwei.uk
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-350fe1f8ea3so1772397a91.2
        for <netdev@vger.kernel.org>; Sun, 01 Feb 2026 14:09:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20230601.gappssmtp.com; s=20230601; t=1769983772; x=1770588572; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HSollAbkysYIn6q3WBkPyjvDyYQliySWNckXJuEYpIs=;
        b=due/wvn7jkrcJYb4gMKEuXtMPclw+Z3ntYt+N/sRQUPdo/fc4iX67IeCOc/Sl/AHlF
         Igpkx4ulYYmd2DsP7Y0sTQbk7lVye0o/lQonANspNBtmEjg2Ui41FBWJt28xa9pzoRxx
         6Gc0GL1XwuXvU1VBAfUYXdvEKeG9j8jFokMEImxds1uXsXKXk3DDq0ewR36otJc1QpCz
         YMX2BeE0l8XEeW6l8KVr0n+250zsNZmLPia3+yUrwwvRGD+2VpcWvA9Pkdki/mZf5+OR
         0lonD+S4tlYW3s1MbqYB2rqzNqeNnIYwR7AyQS5L4ubNNPZLTntc3FzLPmA3oE4RzeLQ
         BJHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769983772; x=1770588572;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HSollAbkysYIn6q3WBkPyjvDyYQliySWNckXJuEYpIs=;
        b=uW5YyOwbZ6bgwU1ZBrRWLAxNynQaV2UDQvBBUQt84v7NBvVzkVU+q//7wo1V5xpTuW
         A1zVDY+c3bqYFyEbM8ksVJbFAdSpFcKDKbkxzZbPfIzV+vLXaqP0VBUj1fOhQXCLTcO3
         jSRifmDOXtZhcdMxs2zebKri2OnK5ilB5JGq8BCy8v5CJJ0L2ItfDSU0yCsqN067fh67
         wpqLVEHZl8gZLYZX1BKEUwnA6CLcqCP5/CxWZXGdR+UHq7hh2NcO9j+Axm0MonCRpO7G
         8pmxSMwo+iGruMSC+EnaAMlmaTcBVkiClRg2w1gYsMf+ji7jb0nYcDTRATegFSk45lIO
         KijQ==
X-Gm-Message-State: AOJu0YwBE6dWoYwIvkyCef3r3/wb7HUerLYnkDkIjSovrxp8Usgzog0N
	OpALTrFZdJH+YuVvnldTy1jK9GYb6ZtCnXobDdFbgnJzV8FMcYDVi31RZYTiPFZkeQVzUfQE1q1
	OA6k57Ng=
X-Gm-Gg: AZuq6aKm4k4m6pEFDQJVw6trlOY1UGaTfZYva7PvZ75zRKqbLoTQhpAByIcLRDE56mm
	iyCAm/xXn90WlmVzKTjGBISTJjVBClbuzxxRW01QKQF/t6b6pByAY0Sczt+gp9kULLttB9gj6N/
	Xl7oN/Ic+CVjzOCr7h7dr45zVjRQ9HmPWkuDIoslfzdqWoTK2mvbSZqt33uoMEr4nl5X4QdPWSA
	MyAPqkiNuSazogSbCdqsBkJcLgoSW5ofz9m1G8JWVSvkMk+LYVZ/YsRAz7HlZ1SVx7JVIjEUUft
	yOVN40j0UoB25TK4tLE9rEp9CENACFm7ptjQtXAH6x84U8Q0JYfkeX+OQ9l2CQYcS70aUP3kgEJ
	Dpgr5kJwet2IMYDQLjLPrUjSwj4m8gCHcGCNZQZMZkIAoAx6cnttVpAZnqeuOHbJ1QpjPh64sjN
	2dPad9bS8rZy64BUa5PK6xbi7YNF49dNdX18hI0Gu/pE0z2WFY8LtyRVbo18hE0VYdHhZJVrQbW
	deXP8bS4+GzUMgfqQ==
X-Received: by 2002:a17:90b:3949:b0:353:2e1:95f6 with SMTP id 98e67ed59e1d1-3543b4021admr9000467a91.32.1769983772225;
        Sun, 01 Feb 2026 14:09:32 -0800 (PST)
Received: from [192.168.100.174] (p94025-ipoefx.ipoe.ocn.ne.jp. [153.246.129.24])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3540f2f02aasm13536653a91.7.2026.02.01.14.09.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 01 Feb 2026 14:09:31 -0800 (PST)
Message-ID: <5f8a0b59-0ca8-43bd-8d28-99d306ff5bbf@davidwei.uk>
Date: Mon, 2 Feb 2026 07:09:25 +0900
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v8 06/16] net: Proxy net_mp_{open,close}_rxq for
 leased queues
To: Jakub Kicinski <kuba@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, davem@davemloft.net,
 razor@blackwall.org, pabeni@redhat.com, willemb@google.com, sdf@fomichev.me,
 john.fastabend@gmail.com, martin.lau@kernel.org, jordan@jrife.io,
 maciej.fijalkowski@intel.com, magnus.karlsson@intel.com, toke@redhat.com,
 yangzhenze@bytedance.com, wangdongdong.6@bytedance.com
References: <20260129222830.439687-1-daniel@iogearbox.net>
 <20260129222830.439687-7-daniel@iogearbox.net>
 <20260131160237.07789674@kernel.org>
Content-Language: en-US
From: David Wei <dw@davidwei.uk>
In-Reply-To: <20260131160237.07789674@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	R_DKIM_ALLOW(-0.20)[davidwei-uk.20230601.gappssmtp.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-255679-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[davidwei.uk];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,davemloft.net,blackwall.org,redhat.com,google.com,fomichev.me,gmail.com,kernel.org,jrife.io,intel.com,bytedance.com];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[davidwei-uk.20230601.gappssmtp.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dw@davidwei.uk,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,davidwei.uk:mid]
X-Rspamd-Queue-Id: B8B95C7581
X-Rspamd-Action: no action

On 2026-02-01 09:02, Jakub Kicinski wrote:
> On Thu, 29 Jan 2026 23:28:20 +0100 Daniel Borkmann wrote:
>> @@ -191,24 +214,15 @@ int netdev_rx_queue_restart(struct net_device *dev, unsigned int rxq_idx)
>>   }
>>   EXPORT_SYMBOL_NS_GPL(netdev_rx_queue_restart, "NETDEV_INTERNAL");
>>   
>> -int net_mp_open_rxq(struct net_device *dev, unsigned int rxq_idx,
>> -		    const struct pp_memory_provider_params *p,
>> -		    struct netlink_ext_ack *extack)
>> +static int __net_mp_open_rxq(struct net_device *dev, unsigned int rxq_idx,
>> +			     const struct pp_memory_provider_params *p,
>> +			     struct netlink_ext_ack *extack)
>>   {
>>   	const struct netdev_queue_mgmt_ops *qops = dev->queue_mgmt_ops;
>>   	struct netdev_queue_config qcfg[2];
>>   	struct netdev_rx_queue *rxq;
>>   	int ret;
>>   
>> -	if (!netdev_need_ops_lock(dev))
>> -		return -EOPNOTSUPP;
>> -
>> -	if (rxq_idx >= dev->real_num_rx_queues) {
>> -		NL_SET_ERR_MSG(extack, "rx queue index out of range");
>> -		return -ERANGE;
>> -	}
>> -	rxq_idx = array_index_nospec(rxq_idx, dev->real_num_rx_queues);
>> -
> 
>> +int net_mp_open_rxq(struct net_device *dev, unsigned int rxq_idx,
>> +		    const struct pp_memory_provider_params *p,
>> +		    struct netlink_ext_ack *extack)
>> +{
>> +	struct net_device *orig_dev = dev;
>> +	int ret;
>> +
>> +	if (!netdev_need_ops_lock(dev))
>> +		return -EOPNOTSUPP;
>> +
>> +	if (rxq_idx >= dev->real_num_rx_queues) {
>> +		NL_SET_ERR_MSG(extack, "rx queue index out of range");
>> +		return -ERANGE;
>> +	}
>> +
> 
> nit: delete this empty line please, like it was in the original code.

Yes.

> 
>> +	rxq_idx = array_index_nospec(rxq_idx, dev->real_num_rx_queues);
>> +
>> +	if (!netif_get_rx_queue_lease_locked(&dev, &rxq_idx)) {
>> +		NL_SET_ERR_MSG(extack, "rx queue leased to a virtual netdev");
>> +		return -EBUSY;
>> +	}
>> +	if (!dev->dev.parent) {
>> +		NL_SET_ERR_MSG(extack, "rx queue belongs to a virtual netdev");
>> +		ret = -EOPNOTSUPP;
>> +		goto out;
>> +	}
>> +
>> +	ret = __net_mp_open_rxq(dev, rxq_idx, p, extack);
>> +out:
>> +	netif_put_rx_queue_lease_locked(orig_dev, dev);
>> +	return ret;
> 
> Please:
> 
> 	if (!netif_queue_is_a_lease())
> 		return __net_mp_open_rxq(dev, rxq_idx, p, extack);
> 
> 	..explicit code that deals with the lease, no conditional locking
> 	...
> 	ret = __net_mp_open_rxq($dev, $rxq_idx, p, extack);
> 	...

Understood.

> 
> 
>> -	rxq = __netif_get_rx_queue(dev, ifq_idx);
>> +	rxq = __netif_get_rx_queue(dev, rxq_idx);
> 
> Indeed good to cleanup the ifq_idx naming that sneaked in, but IDK if
> this belongs in this commit :S

It really annoyed me haha. I'll remove this from this series and send it
as a follow up.

