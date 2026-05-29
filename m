Return-Path: <netdev+bounces-293133-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WPWTGeibGWq7xwgAu9opvQ
	(envelope-from <netdev+bounces-293133-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 16:00:08 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D18A6032FF
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 16:00:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 1E469304DABB
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 13:59:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30E6533F5BD;
	Fri, 29 May 2026 13:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S5CbpKTK"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64EAE3CB2F0
	for <netdev@vger.kernel.org>; Fri, 29 May 2026 13:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780063190; cv=none; b=kXC/687iG+stNCqZHpaJH4yTO9Ga4RHXr6o4oXyRyzCkdJRg/aWosneDDVFgjAYRKbd8DimrDN1MLJa1zR4aQueGVoRDCngO59aVP141QPIOp5alUZg21iuvknxajjYi7VRQ2hRH6pWEs62wvaokCnKC6OFt3xbV8cMCQCgh3cw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780063190; c=relaxed/simple;
	bh=KYVlRd1aquTP3bMRf1yqpg8Q8zkl/MFBUrtYhsbb0b8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uq9jHpMbir1nzbt7YexWNaGgm1JRZkODao1GRWgUbnxf7dMXSUa5bVOv/JB71WGMa42Mi6nzv6/+Ugv5tg3abQ04FzFOLT3c6WTb9pKq/Nk0U86FrO4GnXt2DPLNKRylYdYdBGoOgHkuijJFV6xWyegyrb98Ki8UQf0cq3Sdv8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S5CbpKTK; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4903ff574c5so4842595e9.2
        for <netdev@vger.kernel.org>; Fri, 29 May 2026 06:59:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780063186; x=1780667986; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=n5MBJ+x5az2tq5WcU9vWA3tYOf7P2ieIA9xjXOxXWIs=;
        b=S5CbpKTKucfo8HNm5fURinWau6BF7wBsryw7Hc4eXGO4cDX5ZYYRqvGMo6yM1UdYSN
         yGWv9dZ37cpre8Xo+xvTr3IfLMGCOw4Z8ZvL0fL4S+fj9re8EogSqBjnkKReV6IpCUtM
         G+snvZz8HCpGrfqzL9Q1QYptrJPb+5XBzM9UonTuRnUfn8P9biR/ayP7FWcHZsW0WxIO
         XRQCGVvK1EedoynXe/lK9p7JnUI0Y/dSAra9R4MQhBX+wEMvS3kw/VTWsy+FYQzs7E89
         jeM6SVey1P+8WcYf2kAX2kAjh2J67SXkbVSka35C4aku1qRd94VCzjLinlnS94Ujar35
         78/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780063186; x=1780667986;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=n5MBJ+x5az2tq5WcU9vWA3tYOf7P2ieIA9xjXOxXWIs=;
        b=axP8+Qko8wIFv3HWRjJfyRkXSUb6XTuQzodXWD1a18v614s0DqKsYaf1F0n4oBihUA
         sOmqpSyDcAp3AwdfJfCKrikOSpXOvmD/mHK2oTXC/lF0rpXB6MJG46TyVdNqpl8E2a2d
         N9OHqY97WXdl+KvBK649MD1NS8qDJ1qSAu0YBLmdPsE2oTdKCOBsPhifsblP+xqGQqaL
         MV9QEDAEAi8ULBPkWyeP4/RD6wKeNo9gO+6+mbkQB2fUi+bkcl9aJIXutK/AceDbXiPu
         C6RiM33TlRbAz15g4rzbpaXmz+JET4YZtEgGp+r7IWne1jr9D0GfbxjbH7k0zGc+MP2k
         LDIw==
X-Forwarded-Encrypted: i=1; AFNElJ8/gCIEXZ8tSN6zHWvAFEc6kyOIzA83WyVxJ5ubsqR48t67swy1UMSsAulV50aMHL+/DEj/Alw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJZ6nA0LL3F15pzy9lObYItNr9k31R7K+GTxj8YsLCiJOYj12J
	jUEJ6kuGh5NldIL+L3ff3dJJxHdmTuFMPPm3vt7p28CjxLHjhUF2UZ0T
X-Gm-Gg: Acq92OG2x4m3eYFPTkbDwtOUu0IUuC7SJfdUTOP0aPktp4UQkvhv5L7HsgZ6yLAZiKh
	sjoPTrYCO+jUVyc6OjShOb6QrZXN3qFy9TirOUH3RVoxFOUVWFESl26rKCnBwggG4+MTeMmYGGx
	NmqY0734ZCpTFBKlG9lc8m9KOx3SAKZyI+A5hKH5CzqQGr469Srh9R0dylxFnyykbNXl9XFe9To
	pPiHbswX2a7aNk6HBSfiHgd0PyaTVbYDqYiOLzXk9WkHBssHmhXBrtktzL/Pi0WNiHtW1MVHwP5
	PdPOc7zyDa+v+UOB//VhnBz/vYJk4hKsn3OTKoZjpczl4iAatCscW07Dq2Q8p5vNPqLxSJ5ycGs
	b8/Bx3Z6i3D2mA3vKI9eL4wpuiCxxFnS+/uTo0ExaAKbPRdZ0AJV4Z2QqeCjZip00i9NcXJdYFg
	pQnKQDWSbp5VGy2w9XLFgcxVmyozZFOqwcN8uI/N4yyIVUyr9WI7aZFMhI8/AsO1YcoNvcuvHOp
	oy6r3DgsDXrumMR6aAAuVmEgBijHv1cZg==
X-Received: by 2002:a05:600c:4f53:b0:489:1fa8:b895 with SMTP id 5b1f17b1804b1-4909c0845ccmr21882065e9.2.1780063185440;
        Fri, 29 May 2026 06:59:45 -0700 (PDT)
Received: from ?IPV6:2a02:aa16:1105:8100:157a:cab0:dc27:cd03? ([2a02:aa16:1105:8100:157a:cab0:dc27:cd03])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4909c0c39b0sm25645315e9.2.2026.05.29.06.59.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 May 2026 06:59:45 -0700 (PDT)
Message-ID: <a1cf0b32-1ad1-4297-a371-3807bf49160f@gmail.com>
Date: Fri, 29 May 2026 15:59:44 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] netdevsim: fib: fix use-after-free of FIB data via
 debugfs
To: Ido Schimmel <idosch@nvidia.com>
Cc: Jakub Kicinski <kuba@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20260526160910.1614609-1-yzjaurora@gmail.com>
 <20260527083214.GA444725@shredder>
Content-Language: en-US
From: Zijing yin <yzjaurora@gmail.com>
In-Reply-To: <20260527083214.GA444725@shredder>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-293133-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yzjaurora@gmail.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 0D18A6032FF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Thanks so much for the feedback!
I have sent the revised patch accordingly:
https://lore.kernel.org/netdev/20260529135718.1804031-1-yzjaurora@gmail.com/T/#u
Hope you have a nice weekend!

On 27.05.2026 10:32, Ido Schimmel wrote:
> On Tue, May 26, 2026 at 09:09:08AM -0700, Zijing Yin wrote:
>> @@ -1600,6 +1597,16 @@ struct nsim_fib_data *nsim_fib_create(struct devlink *devlink,
>>  		goto err_nexthop_nb_unregister;
>>  	}
>>  
>> +	/* Publish the debugfs interface only after every data structure it
>> +	 * operates on has been initialized. The files reference this
>> +	 * nsim_fib_data (e.g. "nexthop_bucket_activity" looks up
>> +	 * data->nexthop_ht), so a concurrent debugfs access must never be able
>> +	 * to observe a half-constructed instance.
>> +	 */
>> +	err = nsim_fib_debugfs_init(data, nsim_dev);
>> +	if (err)
>> +		goto err_fib_notifier_unregister;
>> +
>>  	devl_resource_occ_get_register(devlink,
>>  				       NSIM_RESOURCE_IPV4_FIB,
>>  				       nsim_fib_ipv4_resource_occ_get,
>> @@ -1622,6 +1629,8 @@ struct nsim_fib_data *nsim_fib_create(struct devlink *devlink,
>>  				       data);
>>  	return data;
>>  
>> +err_fib_notifier_unregister:
>> +	unregister_fib_notifier(devlink_net(devlink), &data->fib_nb);
>>  err_nexthop_nb_unregister:
>>  	unregister_nexthop_notifier(devlink_net(devlink), &data->nexthop_nb);
>>  err_rhashtable_fib_destroy:
>> @@ -1633,16 +1642,23 @@ struct nsim_fib_data *nsim_fib_create(struct devlink *devlink,
>>  	rhashtable_free_and_destroy(&data->nexthop_ht, nsim_nexthop_free,
>>  				    data);
>>  	mutex_destroy(&data->fib_lock);
>> -err_debugfs_exit:
>> +err_nh_lock_destroy:
>>  	mutex_destroy(&data->nh_lock);
>> -	nsim_fib_debugfs_exit(data);
>> -err_data_free:
>>  	kfree(data);
>>  	return ERR_PTR(err);
>>  }
>>  
>>  void nsim_fib_destroy(struct devlink *devlink, struct nsim_fib_data *data)
>>  {
>> +	/* Tear down the debugfs files before freeing the data structures they
>> +	 * operate on. debugfs_remove_recursive() waits for any in-flight file
>> +	 * operation (e.g. a write to "fib/nexthop_bucket_activity", which looks
>> +	 * up data->nexthop_ht) to finish and prevents new ones from starting,
>> +	 * so the rhashtables are not freed while a concurrent accessor still
>> +	 * dereferences them.
>> +	 */
>> +	nsim_fib_debugfs_exit(data);
> 
> Thanks for the patch. Let's try to keep both functions symmetric:
> 
> Call nsim_fib_debugfs_exit() just before unregister_fib_notifier().
> 
> Also, I would drop the comments.
> 
>> +
>>  	devl_resource_occ_get_unregister(devlink,
>>  					 NSIM_RESOURCE_NEXTHOPS);
>>  	devl_resource_occ_get_unregister(devlink,
>> @@ -1665,6 +1681,5 @@ void nsim_fib_destroy(struct devlink *devlink, struct nsim_fib_data *data)
>>  	WARN_ON_ONCE(!list_empty(&data->fib_rt_list));
>>  	mutex_destroy(&data->fib_lock);
>>  	mutex_destroy(&data->nh_lock);
>> -	nsim_fib_debugfs_exit(data);
>>  	kfree(data);
>>  }
>> -- 
>> 2.43.0
>>


