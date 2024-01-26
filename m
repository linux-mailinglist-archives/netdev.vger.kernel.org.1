Return-Path: <netdev+bounces-66246-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B5CA83E1F8
	for <lists+netdev@lfdr.de>; Fri, 26 Jan 2024 19:54:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6C3AA1C211A5
	for <lists+netdev@lfdr.de>; Fri, 26 Jan 2024 18:54:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE17621370;
	Fri, 26 Jan 2024 18:54:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b="fSKi8x7j"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4847A17572
	for <netdev@vger.kernel.org>; Fri, 26 Jan 2024 18:54:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706295279; cv=none; b=te90y4q7BmPZqH0L+KGo9W3EMtPc5IU1D+sp9eDIH2erSp2AWxsopx/f0VXWBotY1QXIHqDBcnqKwAIt9feaSHfvMOflW5IZ0q55Q29TSXDjCmwczmhBkHC1VblxMswmh3INL9gLzb0JcBxb1shxgz1jxFkyZZTvro0BTI0oG1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706295279; c=relaxed/simple;
	bh=Ye2qG16SDutuRBefbadW3PyV/Y6td303Uc5IRPWtVDA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pzBv9swGW8Tf4QEtnb/Axwb2hH/9bIcA/Nb0ITru09HjRrPx0BVUv+S780BNp4iEGYdRCDf8RgyaRCf6ABH2+2+OglyAl7VYojCOVrqx5S4MlLWTQgHEwPeG0oIXhtiXhwfZG47cu9wGewlofUO/XXbmMMT0F/y0ScFCvxpS+8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk; spf=none smtp.mailfrom=davidwei.uk; dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b=fSKi8x7j; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=davidwei.uk
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1d7881b1843so6818885ad.3
        for <netdev@vger.kernel.org>; Fri, 26 Jan 2024 10:54:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20230601.gappssmtp.com; s=20230601; t=1706295277; x=1706900077; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nTxoQKe3NOHyxj9vWUjNgv2ClSlyspetp0SQ+jwwDrc=;
        b=fSKi8x7jB+2HB0wAjpVvJfwGXFn6yzcLXYAXXwa018jjPX3YEwgk5wtqu9TssRtHOD
         FIwepd6CIdPg3lS5doe6GVm7sx7K5u6lSiMKuc/IO9AijTpygKMk1QPSk/wYatMLk1cQ
         lUDrcth68Z3RshEmyIg1rDKTci0fulLmlP+4r+IXfYEYeZF/PxHD/bm40g7qIUMCT+pf
         OAVz8/lM0QA7j2cT27cEjWkOIJbjLnO4ShjQbkgA2GgB7TlCmgq5xBApMM+p+QlxuId6
         5tDbxRnl7/5sJXCuvGzXapzdgzyRWtma6T27LfC9NqNnTTmJiZk31nYuSGpLK2zbQRHK
         GgYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706295277; x=1706900077;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nTxoQKe3NOHyxj9vWUjNgv2ClSlyspetp0SQ+jwwDrc=;
        b=WXhwFWb7lfRE5UifHpj44FWQlI+ZEBKrMe0UTS5l0ce+AwehT65/WBMDLnw4ILjRHp
         szChevj+3Y1+uu5k5D08i5wvhpLPmJwlpTJFLp0QVSHPm8qnkDIzHpaxy81DfgJoV9WK
         PC2d/C1XkIvLQHc40Jr4P45ECrUwdTkJwIff2tdQCPBjTibaFMDbWKz528Kau0uoBLTu
         xxkIOY1y2FtywnPevHM5+vMP7X9xc8Xa2ZQLqgX2oc9Jzn6P0Q3UCDL5vpl+YKDl4thN
         ezLGydcRj928YXHoeezx7o9R1Xb7y60H+AdE0fquFBz+XUYgDswXfZzMwuxBLX5qwmu3
         dkhw==
X-Gm-Message-State: AOJu0YxUoV0xGkh6UzxfJn4q1wmt8eobaECPHRxwJXLcE0n4hBrWafCV
	ZxCfA/v8VwDDHlfGQrws/p0tvU32yIqmHM656jxiV9rXBuwxIT+G86/puyGaDs3HmrZ3sA7nWHb
	L
X-Google-Smtp-Source: AGHT+IGEKKbIT/Z7Z8P+KzPqXqQN/rpDqc8+CaCCkIvmivkD5O6vSRjcHQU+3b34ylxppl7Lz5fEHw==
X-Received: by 2002:a17:902:ba83:b0:1d8:8aba:4b07 with SMTP id k3-20020a170902ba8300b001d88aba4b07mr209816pls.60.1706295277483;
        Fri, 26 Jan 2024 10:54:37 -0800 (PST)
Received: from ?IPV6:2a03:83e0:1151:15:40a:5eb5:8916:33a4? ([2620:10d:c090:500::5:c749])
        by smtp.gmail.com with ESMTPSA id b8-20020a170902b60800b001d720a7a616sm1241677pls.165.2024.01.26.10.54.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Jan 2024 10:54:37 -0800 (PST)
Message-ID: <d1aae414-6225-4a1f-86dd-c185ebfa978f@davidwei.uk>
Date: Fri, 26 Jan 2024 10:54:35 -0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v6 1/4] netdevsim: allow two netdevsim ports to
 be connected
To: Jakub Kicinski <kuba@kernel.org>
Cc: Jiri Pirko <jiri@resnulli.us>, Sabrina Dubroca <sd@queasysnail.net>,
 netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>
References: <20240126012357.535494-1-dw@davidwei.uk>
 <20240126012357.535494-2-dw@davidwei.uk> <20240125182403.13c4475b@kernel.org>
Content-Language: en-GB
From: David Wei <dw@davidwei.uk>
In-Reply-To: <20240125182403.13c4475b@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2024-01-25 18:24, Jakub Kicinski wrote:
> On Thu, 25 Jan 2024 17:23:54 -0800 David Wei wrote:
>> diff --git a/drivers/net/netdevsim/bus.c b/drivers/net/netdevsim/bus.c
>> index bcbc1e19edde..be8ac2e60c69 100644
>> --- a/drivers/net/netdevsim/bus.c
>> +++ b/drivers/net/netdevsim/bus.c
>> @@ -232,9 +232,81 @@ del_device_store(const struct bus_type *bus, const char *buf, size_t count)
>>  }
>>  static BUS_ATTR_WO(del_device);
>>  
>> +static ssize_t link_device_store(const struct bus_type *bus, const char *buf, size_t count)
>> +{
>> +	unsigned int netnsid_a, netnsid_b, ifidx_a, ifidx_b;
>> +	struct netdevsim *nsim_a, *nsim_b;
>> +	struct net_device *dev_a, *dev_b;
>> +	struct net *ns_a, *ns_b;
>> +	int err;
>> +
>> +	err = sscanf(buf, "%u %u %u %u", &netnsid_a, &ifidx_a, &netnsid_b, &ifidx_b);
> 
> I'd go for "%u:%u %u:%u" to make the 'grouping' of netns and ifindex
> more obvious. But no strong feelings.

Also no strong feelings so I will go with your feelings.

> 
>> +	if (err != 4) {
>> +		pr_err("Format for linking two devices is \"netnsid_a ifidx_a netnsid_b ifidx_b\" (uint uint unit uint).\n");
>> +		return -EINVAL;
>> +	}
>> +
>> +	err = -EINVAL;
>> +	rtnl_lock();
>> +	ns_a = get_net_ns_by_id(current->nsproxy->net_ns, netnsid_a);
>> +	if (!ns_a) {
>> +		pr_err("Could not find netns with id: %d\n", netnsid_a);
>> +		goto out_unlock_rtnl;
>> +	}
>> +
>> +	dev_a = dev_get_by_index(ns_a, ifidx_a);
> 
> since you're under rtnl_lock you can use __get_device_by_index(),
> it doesn't increase the refcount so you won't have to worry about
> releasing it.

Ah, I will change this. Is this true in general i.e. if I hold some big
lock then I can use versions of functions that do not modify refcounts?

> 
>> +	if (!dev_a) {
>> +		pr_err("Could not find device with ifindex %d in netnsid %d\n", ifidx_a, netnsid_a);
>> +		goto out_put_netns_a;
>> +	}
>> +
>> +	if (!netdev_is_nsim(dev_a)) {
>> +		pr_err("Device with ifindex %d in netnsid %d is not a netdevsim\n", ifidx_a, netnsid_a);
>> +		goto out_put_dev_a;
>> +	}
>> +
>> +	ns_b = get_net_ns_by_id(current->nsproxy->net_ns, netnsid_b);
>> +	if (!ns_b) {
>> +		pr_err("Could not find netns with id: %d\n", netnsid_b);
>> +		goto out_put_dev_a;
>> +	}
>> +
>> +	dev_b = dev_get_by_index(ns_b, ifidx_b);
>> +	if (!dev_b) {
>> +		pr_err("Could not find device with ifindex %d in netnsid %d\n", ifidx_b, netnsid_b);
>> +		goto out_put_netns_b;
>> +	}
>> +
>> +	if (!netdev_is_nsim(dev_b)) {
>> +		pr_err("Device with ifindex %d in netnsid %d is not a netdevsim\n", ifidx_b, netnsid_b);
>> +		goto out_put_dev_b;
>> +	}
>> +
>> +	err = 0;
>> +	nsim_a = netdev_priv(dev_a);
>> +	nsim_b = netdev_priv(dev_b);
>> +	rcu_assign_pointer(nsim_a->peer, nsim_b);
>> +	rcu_assign_pointer(nsim_b->peer, nsim_a);
> 
> Shouldn't we check if peer is NULL? Otherwise we can get into weird
> situations where we link A<>B then B<>C and then the pointers look like
> this A->B<>C. When B gets freed A's pointer won't get cleared.

Yep, that's an oversight from me. Will address.

> 
>> +out_put_dev_b:
>> +	dev_put(dev_b);
>> +out_put_netns_b:
>> +	put_net(ns_b);
>> +out_put_dev_a:
>> +	dev_put(dev_a);
>> +out_put_netns_a:
>> +	put_net(ns_a);
>> +out_unlock_rtnl:
>> +	rtnl_unlock();
>> +
>> +	return !err ? count : err;
>> +}
>> +static BUS_ATTR_WO(link_device);

