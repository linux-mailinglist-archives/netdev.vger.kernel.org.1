Return-Path: <netdev+bounces-258005-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SAekNP16imnIKwAAu9opvQ
	(envelope-from <netdev+bounces-258005-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 10 Feb 2026 01:25:33 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 295CF115985
	for <lists+netdev@lfdr.de>; Tue, 10 Feb 2026 01:25:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 438CB301B706
	for <lists+netdev@lfdr.de>; Tue, 10 Feb 2026 00:25:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 962D3210F59;
	Tue, 10 Feb 2026 00:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b="lMJ0MIuY"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com [74.125.82.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 516E27262A
	for <netdev@vger.kernel.org>; Tue, 10 Feb 2026 00:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770683120; cv=none; b=qweaZ+J03snKvh/BPV3adm8tnEvXUuz35ornQE+tYzLhsQluoziyD5UMKGVNeUlj2mEN79nsmIdBWGIK+VjhYDlix2e/RfKfLQ06fPPqzXnyfhUz3E/G6DolOcwXRCfg7bSoiDW5obQ5GmHbwGEZB0pffqckyIWf2CePoTwx/hs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770683120; c=relaxed/simple;
	bh=kxwOOVA45MLT8Eghg31oPsJi3Zsu1h5qtBk5MuJS/IA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fmxfufBHmBm5rqVCx3IGTrXyCSe6BsEgPIYIXsSwHYDzRXdpoXYuqgrVFiv9fI9/pDfwlwH/zgiRJZDaL8nP+jJr6uaoSidvYGxDjRzgPzpYoHF0hYRDSRQsMlOvIbaAWNszVVAj2602eKjJYsLqhygNpCCQkoHJhdnfTS+s598=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk; spf=none smtp.mailfrom=davidwei.uk; dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b=lMJ0MIuY; arc=none smtp.client-ip=74.125.82.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=davidwei.uk
Received: by mail-dy1-f174.google.com with SMTP id 5a478bee46e88-2b86d3c909dso1757522eec.1
        for <netdev@vger.kernel.org>; Mon, 09 Feb 2026 16:25:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20230601.gappssmtp.com; s=20230601; t=1770683118; x=1771287918; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bb1hMpPJncNawpFRC9pcXob4IbGptBN5ybG8YsPZCoE=;
        b=lMJ0MIuYOHgzG2tMDVbUcR76vg/fR58a21RU7l21Hd+O+DbyBFk8WmHieYnScnlQll
         JuxCpmNJeKQFbS2y0HJjRsEgO7CD0aDGop19EVOA2belHOYt6eTuVk6NHLGbouFzTPqY
         kg/zq1d/sfAnz4ZALO8vVS7X5smc4zSrPawc1Xdv/9DPF4pQf/t+IUiNXExUG/o2+F8a
         n8ztJc0AuL2xEBGTc2IJbewa5QxtFaxbWhZZDYUtGKeqJpUaLgbE7Nz6FieJ6FxEGe+N
         90NwTWH0Qv+15JoiQVJijl5stytG8/tzlkRwRilmM2ehT68VDY8pVTMxnnPjhW9LSpku
         3glA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770683118; x=1771287918;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bb1hMpPJncNawpFRC9pcXob4IbGptBN5ybG8YsPZCoE=;
        b=pGr/K4p4uRbyCMa+yxevWcPGCITKpSwknjtdF8DPMKUXVrq/6t5IORvSzbcp38TP4Q
         TBdCUiUIYihoUqaNUQSXRcPxBnV9luvOErmbYrIin5atCti4v0FBe0yhd78IM++9BcRh
         BUZ8nMI4E2FvmG5s9xLaZnzw2FX8N8u8TrzjeLJnBDbJ+e4rZP/IRkzTgyYltUyy5mbr
         R1AOuup/Rn+agCbg/8qYm2adsatF0A61rZnPIbJxPUaqGsy33+Ubbqor75zwV/FmqbZr
         6hlPJLcVdCg7mJxS+AUkHDQFG8AHsfT3uGP2srmKx3JaanyJAnsfBz1QzNSQh/UeZ9ZS
         RdLA==
X-Forwarded-Encrypted: i=1; AJvYcCXt6oM23Rwn9z1mWFr7gdJQ/lVLnf9soWJe5/xI8OJJMK8u/E2K/BimMo9/kNdLeN3Xjmyks9k=@vger.kernel.org
X-Gm-Message-State: AOJu0YyEfVnoiiXDlWh8+sRuZ29tZPbINyVyZBzb3jKvHAzT2yJt0oy1
	UXlPN9vuvw1lO8NAWvj8WLRIQgPUzZLMvfPRQGc5sTL4U71lUAHpIWl48iQbSMCxthI=
X-Gm-Gg: AZuq6aKny7YMn5B2W18rShf/Uk4Q39UK7Y+UT5zuheyLdPVsrFz8CibjuXXUUdK/TMA
	C1aNEGrvO5h+F1QrgNrFIlaEuXSTanSfSYV33Gsb/VCg3PYjp8RMl+5mdsH0IkDzllzdiy4c9v3
	pdzlvIIBGOAkcZmtTBxzUtBhCea8tifNX4ArfuxDPm6WZKV10OXAxVNVliCwox7Kwxw0pMxaKLe
	Ifdm2R+Dt9ba7NU8fH0k2say4q0f4oVwBKgGxX5NGhAYkp/bC5wvPFnWL1uIs3HO/rA9p/F593c
	IORh0LrNYTmtnT5mmV1ZQWkatZeLeaMb6BFWBeVyIsIi0GASzELe1mJ7xHrTPzbpf/xYQyw3kIB
	A/pxFivlxhyw6qsaDTIsPPbAiPW6yPV2eCLXSbq7AaM2LzKDtMYDruAP+lnmLD58qnF2IzLvLka
	rlNzI3dRkOfJteRS2V3sZnnYhIb4JkTneryXo2UVSP1W0WKnWxlAEfHHvIJRV3jlgMtnkgJWqA0
	gql6A/D8OOW+1Pu0apdvQ==
X-Received: by 2002:a05:7300:dc8c:b0:2a4:3593:c7cc with SMTP id 5a478bee46e88-2b856481297mr4502628eec.12.1770683118146;
        Mon, 09 Feb 2026 16:25:18 -0800 (PST)
Received: from ?IPV6:2a03:83e0:1156:1:c8f:b917:4342:fa09? ([2620:10d:c090:500::1588])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b855c3daf7sm8762920eec.20.2026.02.09.16.25.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Feb 2026 16:25:17 -0800 (PST)
Message-ID: <575bb07d-579c-4db5-8624-7446836e77bd@davidwei.uk>
Date: Mon, 9 Feb 2026 16:25:15 -0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v8 15/16] selftests/net: Add env for container
 based tests
To: Jakub Kicinski <kuba@kernel.org>
Cc: Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org,
 bpf@vger.kernel.org, davem@davemloft.net, razor@blackwall.org,
 pabeni@redhat.com, willemb@google.com, sdf@fomichev.me,
 john.fastabend@gmail.com, martin.lau@kernel.org, jordan@jrife.io,
 maciej.fijalkowski@intel.com, magnus.karlsson@intel.com, toke@redhat.com,
 yangzhenze@bytedance.com, wangdongdong.6@bytedance.com
References: <20260129222830.439687-1-daniel@iogearbox.net>
 <20260129222830.439687-16-daniel@iogearbox.net>
 <20260131163834.2c3d160d@kernel.org>
 <9037828b-c7fd-4eb1-9dd8-19ee49063361@davidwei.uk>
 <20260202104136.4a7adbdf@kernel.org>
Content-Language: en-US
From: David Wei <dw@davidwei.uk>
In-Reply-To: <20260202104136.4a7adbdf@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[davidwei-uk.20230601.gappssmtp.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-258005-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[davidwei.uk];
	FREEMAIL_CC(0.00)[iogearbox.net,vger.kernel.org,davemloft.net,blackwall.org,redhat.com,google.com,fomichev.me,gmail.com,kernel.org,jrife.io,intel.com,bytedance.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[davidwei-uk.20230601.gappssmtp.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_TWELVE(0.00)[17];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dw@davidwei.uk,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 295CF115985
X-Rspamd-Action: no action

On 2026-02-02 10:41, Jakub Kicinski wrote:
> On Mon, 2 Feb 2026 07:53:34 +0900 David Wei wrote:
>> On 2026-02-01 09:38, Jakub Kicinski wrote:
>>> I'm not a Python expert but the pre-init of variables that are set
>>> later on in __init__() (on all possible paths) seems like a waste of LoC
>>
>> It's so that exceptions thrown -> __del__() don't complain about
>> undefined vars.
> 
> I see. I guess that's cleaner than hasattr(self, "xyz"), fair.
> 
>>>> +
>>>> +        ip(f"link add type netkit mode l2 forward peer forward numrxqueues {rxqueues}")
>>>
>>> Would we be able to do this with YNL?
>>> no big deal but always nice to avoid the dependency on very latest CLI
>>
>> Hmm, I tried looking into this already. My understanding is that this
>> can be done in C but not currently in YNL, not without adding a spec.
> 
> I thought the only thing C can do that Python can't is deciding nested
> extacks.. Ah, of course.. I missed that patch 10 is not updating the
> YAML spec. That needs to be fixed, we want YAML to stay in sync for the
> families that are already YAML-ized.

Sorry, my mistake. It is possible with rt-link.yaml:

   ynl = RtnlFamily()
   ynl.newlink(...)

> 
>>>> +    def _setup_ns(self):
>>>> +        self.netns = NetNS()
>>>> +        cmd("ip netns attach init 1")
>>>> +        self._init_ns_attached = True
>>>> +        ip("netns set init 0", ns=self.netns)
>>>
>>> Hm, refactor class NetNSEnter or just use its enter method?
>>
>> I did consider this but I didn't feel like it fit the very specific
>> purpose of NetNSEnter. I needed the init ns to have a valid nsid from
>> within the test netns, which I didn't think many other tests would need.
> 
> What about the "ip netns attach init 1" ?
> that's the main thing that gave me pause TBH
> Why is it needed?

The bind-queue lease attribute takes the ifindex/queue/netns-id of the
source phys netdev to lease a queue from. Once a netlink has been moved
into a netns, it doesn't have access to the source phys netdev in the
init ns anymore. This is why initially I did the bind-queue before
moving one of the netkit peers into a netns.

For me to be able to do a bind-queue op inside a netns, I use ip netns
attach to make the init ns available with a nsid inside of a netns.

> 
>>> Don't we need to also add a qdisc if there isn't one already?
>>
>> Sorry, why would qdisc be needed? The bpf prog attaches to tc. I don't
>> know anything about qdisc, though.
> 
> There's a new way of attaching qdisc-less (TCX) but IIUC here you're
> attaching in the old way. So you must have a parent object. The ingress
> / clsact qdisc isn't really for queuing packets, it's just a fake qdisc
> that lets you attach TC filters to an interface. Machines at Meta have
> a clsact qdisc installed by init, but that's far from normal (try to
> run this command in vng, you'll see)

Thanks for the explanation. I'll fix this by adding a qdisc if one
doesn't exist.

> 
>>>> +        match = re.search(r'pref (\d+).*nk_forward\.bpf.*id (\d+)', tc_info)
>>>
>>> I haven't checked but TC doesn't support enough JSON and YNL doesn't
>>> support enough TC to avoid re hacks? :( :(
>>
>> Yeah the old TC tool doesn't give me this info programmatically :(
>>
>> Borkmann mentioned TC is outdated/unmaintained. I did use tcx via a C
>> loader before, but that was removed in an earlier iteration.
> 
> Not sure what you're saying. tc bpf CLI supports JSON output since:
> 
> commit 3175bca7182b0867c6e9a3d5d1551fdecf70118c
> Author: Davide Caratti <dcaratti@redhat.com>
> Date:   Thu Apr 30 20:03:30 2020 +0200
> 
>      tc: full JSON support for 'bpf' filter

Yes this works, I'll use it instead of regex.

