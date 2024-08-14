Return-Path: <netdev+bounces-118415-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C92E2951858
	for <lists+netdev@lfdr.de>; Wed, 14 Aug 2024 12:07:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7FAAD283CA6
	for <lists+netdev@lfdr.de>; Wed, 14 Aug 2024 10:07:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDE421AE854;
	Wed, 14 Aug 2024 10:06:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bzXctX8e"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1309D1AE845
	for <netdev@vger.kernel.org>; Wed, 14 Aug 2024 10:06:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723630016; cv=none; b=hUTnQUo/7d0aA04TuynaU3JXUmsoz+0KFzFDsPY3XJdcQ9eICjTW/wG14XID/N54AD0BR13u2j+x0NYOw83A9iujJYl4D+Du39vAPAyyNUBFNl7R7aae3prgcuu/Z78TrCyfBLTuW28GAvnujepb/YHSliJIc9E7IJjEgBlcCd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723630016; c=relaxed/simple;
	bh=fU2OpyDvLpE+HH9+rELCwyUrT6j7uONJM7mmYQ5/+3k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=e/DpelWFBlMH+ErKwH7loDJTqiirOb2iMF1n/RuYvR7BNxP05FVrSPxpPUBAo10G5CKccx1RxrTarP+ZinCwHFiZ8CMwuY7G8YQaMsqnqkdq/TlVs1c747jx8uaxoiqaRN43oUlHBONUl8poxb8Ur17bK77647hEBsAAjvnM5vQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bzXctX8e; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1723630014;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FYG8QE/F6/H21PSMLxuHmyFmtZdBI0WC0YNLldNkBDw=;
	b=bzXctX8e0bGPe8MRFtu2iT0Vx6zvCZXw5lCutguIf/ghIsaFS5psOgyNBgrPv+2bql75kJ
	93s9/jqeDJYeuOKHLKGsvvQ0lOizUTR1c7a3GLsWUW0fGX2TlwPR6X4Zm37ELYWfhPI3Zx
	/JEVqVCzVAwFiOjwjxtz97reOFrwZ2M=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-60-7-FTwf7-PR-PBOH46sMg_w-1; Wed, 14 Aug 2024 06:06:52 -0400
X-MC-Unique: 7-FTwf7-PR-PBOH46sMg_w-1
Received: by mail-lj1-f197.google.com with SMTP id 38308e7fff4ca-2ef973d9b41so7272401fa.0
        for <netdev@vger.kernel.org>; Wed, 14 Aug 2024 03:06:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723630011; x=1724234811;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FYG8QE/F6/H21PSMLxuHmyFmtZdBI0WC0YNLldNkBDw=;
        b=CwCIua/TjRdyu337xUf9NDyrrDjLfRCNWVDQEv3XCAL8JnGvRIb978IoBWSf2TtP1C
         xeWwJDYY+haM8iOlfG0AdlYHabu0G4fso1LFnLWh/9S8kzgUHJHnsdCpqlEpdQ/G8jhP
         ydjbrogY+LQ37sSKVLbWVdIAGBqXCRJ4RKoEWhTyAPUv8oy1yYG5bkiy8XOMtpeSjVR5
         Nikjvw737fdmjAarkWr18dL8FO7ECZAL5804+Z7lnOmyLgyhORFuIrp37Efg5uyFIFw4
         bkyNXqN9fBwEVes3tDWweavMNHiV3+BZjWutnWbM9vSBB7XPUwxYeKmVdrMTP8yj40Db
         K9gg==
X-Forwarded-Encrypted: i=1; AJvYcCXWmCvZC9vQvW0A3CmuOofl6ZuV7pXQK46XpsX3xOyMk0gIKo45sA4B4S1+UMI7MNwfwxoJ8ks=@vger.kernel.org
X-Gm-Message-State: AOJu0YyffdW7RSVmXiWRaRzOdBFUdfFOlXMOvOzqlEk/hjDyxnCMm9vW
	EHREBeaihpNazrAHfqCc1oxK6a7GuylUhW8DFbogvKaeh4aC6TwJ9LMkCk9RA0aQDNV0qyc6CfT
	3zMm/BOep8LNWCn/NMKiBmieJuJrG9lvyupN/FN6BG63HI1WeXqvl0A==
X-Received: by 2002:a05:6512:b12:b0:52e:fb8b:32d0 with SMTP id 2adb3069b0e04-532eda65aedmr761179e87.1.1723630011048;
        Wed, 14 Aug 2024 03:06:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHjZmfjw/hKq6hs5IjXpyCA0yCcaB5OTZmNB0Wb48xRjKomb22RTjgW/u4nZcDYcUEUeK8AVQ==
X-Received: by 2002:a05:6512:b12:b0:52e:fb8b:32d0 with SMTP id 2adb3069b0e04-532eda65aedmr761159e87.1.1723630010456;
        Wed, 14 Aug 2024 03:06:50 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:1711:4010:5731:dfd4:b2ed:d824? ([2a0d:3344:1711:4010:5731:dfd4:b2ed:d824])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36e4ebd361bsm12343795f8f.101.2024.08.14.03.06.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Aug 2024 03:06:49 -0700 (PDT)
Message-ID: <2e63b0aa-5394-4a4b-ab7f-0550a5faa342@redhat.com>
Date: Wed, 14 Aug 2024 12:06:48 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] net: netconsole: Populate dynamic entry even if
 netpoll fails
To: Breno Leitao <leitao@debian.org>
Cc: kuba@kernel.org, davem@davemloft.net, edumazet@google.com,
 thepacketgeek@gmail.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Aijay Adams <aijay@meta.com>
References: <20240809161935.3129104-1-leitao@debian.org>
 <6185be94-65b9-466d-ad1a-bded0e4f8356@redhat.com>
 <ZruChcqv1kdTdFtE@gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <ZruChcqv1kdTdFtE@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/13/24 17:57, Breno Leitao wrote:
> On Tue, Aug 13, 2024 at 01:55:27PM +0200, Paolo Abeni wrote:
>> On 8/9/24 18:19, Breno Leitao wrote:> @@ -1304,8 +1308,6 @@ static int
>> __init init_netconsole(void)
>>>    		while ((target_config = strsep(&input, ";"))) {
>>>    			nt = alloc_param_target(target_config, count);
>>>    			if (IS_ERR(nt)) {
>>> -				if (IS_ENABLED(CONFIG_NETCONSOLE_DYNAMIC))
>>> -					continue;
>>>    				err = PTR_ERR(nt);
>>>    				goto fail;
>>>    			}
> 
> First of all, thanks for the in-depth review and suggestion.
> 
> 
>> AFAICS the above introduces a behavior change: if CONFIG_NETCONSOLE_DYNAMIC
>> is enabled, and the options parsing fails for any targets in the command
>> line, all the targets will be removed.
>>
>> I think the old behavior is preferable - just skip the targets with wrong
>> options.
> 
> Thinking about it again, and I think I agree with you here. I will
> update.
> 
>> Side note: I think the error paths in __netpoll_setup() assume the struct
>> netpoll will be freed in case of error, e.g. the device refcount is released
>> but np->dev is not cleared, I fear we could hit a reference underflow on
>> <setup error>, <disable>
> 
> That is a good catch, and I was even able to simulate it, by forcing two
> errors:
> 
> Something as:
> 
> --- a/net/core/netpoll.c
> 	+++ b/net/core/netpoll.c
> 	@@ -637,7 +637,8 @@ int __netpoll_setup(struct netpoll *np, struct net_device *ndev)
> 		}
> 
> 		if (!ndev->npinfo) {
> 	-               npinfo = kmalloc(sizeof(*npinfo), GFP_KERNEL);
> 	+               npinfo = NULL;
> 
> 	diff --git a/drivers/net/netconsole.c b/drivers/net/netconsole.c
> 	index 41a61fa88c32..2c6190808e75 100644
> 	--- a/drivers/net/netconsole.c
> 	+++ b/drivers/net/netconsole.c
> 	@@ -1327,12 +1330,17 @@ static int __init init_netconsole(void)
> 		}
> 
> 		err = dynamic_netconsole_init();
> 	+       err = 1;
> 		if (err)
> 			goto undonotifier;
> 
> 	
> This caused the following issue:
> 	
> 	[   19.530831] netconsole: network logging stopped on interface eth0 as it unregistered
> 	[   19.531205] ref_tracker: reference already released.
> 	[   19.531426] ref_tracker: allocated in:
> 	[   19.531505]  netpoll_setup+0xfd/0x7f0
> 	[   19.531505]  init_netconsole+0x300/0x960
> 	....
> 	[   19.534532] ------------[ cut here ]------------
> 	[   19.534784] WARNING: CPU: 5 PID: 1 at lib/ref_tracker.c:255 ref_tracker_free+0x4e5/0x740
> 	[   19.535103] Modules linked in:
> 	....
> 	[   19.542116]  ? ref_tracker_free+0x4e5/0x740
> 	[   19.542286]  ? refcount_inc+0x40/0x40
> 	[   19.542571]  ? do_netpoll_cleanup+0x4e/0xb0
> 	[   19.542752]  ? netconsole_process_cleanups_core+0xcd/0x260
> 	[   19.542961]  ? netconsole_netdev_event+0x3ab/0x3e0
> 	[   19.543199]  ? unregister_netdevice_notifier+0x27c/0x2f0
> 	[   19.543456]  ? init_netconsole+0xe4/0x960
> 	[   19.543615]  ? do_one_initcall+0x1a8/0x5d0
> 	[   19.543764]  ? do_initcall_level+0x133/0x1e0
> 	[   19.543963]  ? do_initcalls+0x43/0x80
> 	....
> 
> That said, now, the list contains enabled and disabled targets. All the
> disable targets have netpoll disabled, thus, we don't handle network
> operations in the disabled targets.
> 
> This is my new proposal, based on your feedback, how does it look like?
> 
> Thanks for the in-depth review,
> --breno
> 
> diff --git a/drivers/net/netconsole.c b/drivers/net/netconsole.c
> index 30b6aac08411..60325383ab6d 100644
> --- a/drivers/net/netconsole.c
> +++ b/drivers/net/netconsole.c
> @@ -1008,6 +1008,8 @@ static int netconsole_netdev_event(struct notifier_block *this,
>   	mutex_lock(&target_cleanup_list_lock);
>   	spin_lock_irqsave(&target_list_lock, flags);
>   	list_for_each_entry_safe(nt, tmp, &target_list, list) {
> +		if (!nt->enabled)
> +			continue;
>   		netconsole_target_get(nt);
>   		if (nt->np.dev == dev) {
>   			switch (event) {
> @@ -1258,11 +1260,15 @@ static struct netconsole_target *alloc_param_target(char *target_config,
>   		goto fail;
>   
>   	err = netpoll_setup(&nt->np);
> -	if (err)
> +	if (!err)
> +		nt->enabled = true;
> +	else if (!IS_ENABLED(CONFIG_NETCONSOLE_DYNAMIC))
> +		/* only fail if dynamic reconfiguration is set,
> +		 * otherwise, keep the target in the list, but disabled.
> +		 */
>   		goto fail;
>   
>   	populate_configfs_item(nt, cmdline_count);
> -	nt->enabled = true;
>   
>   	return nt;
>   
> @@ -1274,7 +1280,8 @@ static struct netconsole_target *alloc_param_target(char *target_config,
>   /* Cleanup netpoll for given target (from boot/module param) and free it */
>   static void free_param_target(struct netconsole_target *nt)
>   {
> -	netpoll_cleanup(&nt->np);
> +	if (nt->enabled)
> +		netpoll_cleanup(&nt->np);
>   	kfree(nt);
>   }

I fear the late cleanup could still be dangerous - what if multiple, 
consecutive, enabled_store() on the same target fails?

I *think* it would be safer always zeroing np->dev in the error path of 
netpoll_setup().

It could be a separate patch for bisectability.

Side note: I additionally think that in the same error path we should 
conditionally clear np->local_ip.ip, if the previous code initialized 
such field, or we could get weird results if e.g.
- a target uses eth0 with local_ip == 0
- enabled_store() of such target fails e.g. due ndo_netpoll_setup() failure
- address on eth0 changes for some reason
- anoter enabled_store() is issued on the same target.

At this point the netpoll target should be wrongly using the old address.

Thanks,

Paolo


