Return-Path: <netdev+bounces-257151-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qB5BOUqNhGl43QMAu9opvQ
	(envelope-from <netdev+bounces-257151-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 05 Feb 2026 13:30:02 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 548BCF27FD
	for <lists+netdev@lfdr.de>; Thu, 05 Feb 2026 13:30:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 342543079BB1
	for <lists+netdev@lfdr.de>; Thu,  5 Feb 2026 12:25:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 845B53C1969;
	Thu,  5 Feb 2026 12:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FoFO/6pG";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="GIramPJ0"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20E613A9628
	for <netdev@vger.kernel.org>; Thu,  5 Feb 2026 12:25:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770294303; cv=none; b=TwRp4USMUIITw1w9PEsFCVAQclzqlZMxXHjgnanDkpo3Yq5BhLOoXc/0kPyGS5GehxNvdwdPvFL0vibpuP/KWpPJD5jTK/P8CdENm02ALIsCnc1DG/E+4Pi0ruslNwihbobW0e2/e7+5PLYyLQoCJFDncyJfJ9x8kf4uqOiAl8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770294303; c=relaxed/simple;
	bh=Z/B9vhajHKLHwHnho7KMnGey0L5MW2LOqH3DYCq11v4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ckiJs5gQMtny1WkfxhG6CZ32phIrVQFVbck4NcewhUVQy75rnS9C2A8Z9dwDblivokv4N8IysGOTutYaWJVZSZnWPEooPeQCiHOY7KfaASyJTopeL24uxKgq5Ul2SGTY/8zmB5LDET7/nhSDKL6d+g7jCDKFxfifD9ThSsL0Qwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FoFO/6pG; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=GIramPJ0; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1770294302;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kTs2P/KtHhQBrqRutC9oA5UVOjBir3xmipR3YfrBtSo=;
	b=FoFO/6pG1KQwC2ipXa7McR4fUDOrq1GQ2iT4V6spn8vU4r+R+updhBnJ3gsdXNFXXS8T1m
	6nqhDxydCDRT90gmEDxUnI8sIsZssIl0a+JiZ9BGCiBs3bZ5wrbUZJzNgdUjmnlHthazlu
	6m+dy67GJ3dqOVmikhjt2A+T6Qu11Ow=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-435-DjsURP0xMpK9fRi5pbk9kQ-1; Thu, 05 Feb 2026 07:25:01 -0500
X-MC-Unique: DjsURP0xMpK9fRi5pbk9kQ-1
X-Mimecast-MFC-AGG-ID: DjsURP0xMpK9fRi5pbk9kQ_1770294300
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-b8749dd495dso83722366b.1
        for <netdev@vger.kernel.org>; Thu, 05 Feb 2026 04:25:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1770294300; x=1770899100; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kTs2P/KtHhQBrqRutC9oA5UVOjBir3xmipR3YfrBtSo=;
        b=GIramPJ0qRIWpZkktFyIcc0BIKmXN22gFIsj7m+/BSDetHwwGkhGNmJTLgdalg8Dp3
         WpdOAM9JX+5X9uExQUx0+IqrLgD7Eu3XGcHXH5MKmHx2628T4qrUMOcCt6w2f9/DFhtO
         XcnPGpQWBXa+twUX4LJ6M7+FXXf5/q0xfmRv9qm0OwBWUmATJfBa0dSzTlFJYScP5UWN
         KH/KicQt6eDeuwPsqOEkGtZGGyQBTJt71pRPKwGAwawSnC2gcNjf/4qf0l2SNgwyiJZL
         SFjf9AS3KsymVxVjftYTCh32xnpbXn6rfWZUWXBAJG4VnmFk67uouGeKMp5OlScvE3tw
         E44g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770294300; x=1770899100;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kTs2P/KtHhQBrqRutC9oA5UVOjBir3xmipR3YfrBtSo=;
        b=UXmBnnb8SYa3IVOW1laIL7hu5fG0R1pDC/UmBQqPofdieW957jeiNu7JRrynQtxnxk
         2/0cdP6ILVX09FLiY3aAHdqnew5RmvV1hHH+FKcxyEj4xEj7NEvc5m3izToL7EZzecvZ
         0QNf/p/pgyyhUxJBy58QVzx2FZOm7mQqjGwMbRs1EyYQLSfck/AuaWl+mNJmeWqB7C2D
         nGuwUCb48uAVhrSWTLFLKRZGxydbG9l47jg367CJYPYmWnZ7fhyTlwwbPdfWjvdZUEg5
         UAx/BQCWtzwC1wrqeCX7VAbiNV3jQcoPOCEWx+2+kUfBXodcaCtVR32hbScB6sy0Rkhz
         yUvA==
X-Forwarded-Encrypted: i=1; AJvYcCXjce9kSdNCIn/9RcCe/7J8a0DryivTqZJL70xnHYBuW8LaQxk8LaTysvGY9uRomwIThNfb8Wo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/RGXRghcbrmRsdpDO2tjbWwMwWgquUN9cKL2HJP4BSN2iQ8Mo
	y/g7Jc4qsaPBm2HLfd2ShWcqsRyKAV1sVovVMqk3JpnS32OlU5GIDyPEKMdjqGuGBenolyzk3qz
	6i9BKLUX/J77tNSQwGIF/6YWf6mEfFQxam5dVDVexcJ0mI4AxS8vFIrV32Q==
X-Gm-Gg: AZuq6aIKSA6n6iUfBV8Ez2I1hmZebj4W0KuuXTm5V8K4aGypc73JGD4MHV4bgDRLIce
	47ZmgyfGGjXZ3Nrr+cupxtz7gs4VpvofueItylUlje7uoIlZg7gg5B+K1yip7TuaSqPfqVwGw0k
	sIyPmTICah6RvsIPwjdT2JVfv2MKjvqstSIS1NmX3onCUqHZY1Jj4bNTDUQEuPyfvsmUsXBLm2I
	39vMMJbGNTCBiexHKG1fjLVjzTSyxgRj49HEe8Hff9fX7grB5l9F2d32irvgOXQNzpffyeYdPz2
	2p1cmM9Hi+nbKGBQBJk0nzdTDetgVMGKswkE1eXQi/iWdJx8EVQ9EI3csobv/m98dDNvT+4rXuH
	Lj1rNUDmk
X-Received: by 2002:a17:907:d78b:b0:b8e:8874:8366 with SMTP id a640c23a62f3a-b8e9ef31395mr437994966b.5.1770294299693;
        Thu, 05 Feb 2026 04:24:59 -0800 (PST)
X-Received: by 2002:a17:907:d78b:b0:b8e:8874:8366 with SMTP id a640c23a62f3a-b8e9ef31395mr437990866b.5.1770294299088;
        Thu, 05 Feb 2026 04:24:59 -0800 (PST)
Received: from [192.168.2.83] ([46.175.183.46])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b8ea0045574sm222051166b.59.2026.02.05.04.24.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Feb 2026 04:24:58 -0800 (PST)
Message-ID: <07755837-fb92-40ce-bf99-7d941076ee62@redhat.com>
Date: Thu, 5 Feb 2026 13:24:56 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [PATCH net] iavf: fix deadlock in reset
 handling
To: Jacob Keller <jacob.e.keller@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Jakub Kicinski <kuba@kernel.org>
Cc: ivecera@redhat.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Andrew Lunn <andrew+netdev@lunn.ch>, Eric Dumazet <edumazet@google.com>,
 Stanislav Fomichev <sdf@fomichev.me>,
 Tony Nguyen <anthony.l.nguyen@intel.com>, intel-wired-lan@lists.osuosl.org,
 Paolo Abeni <pabeni@redhat.com>, "David S. Miller" <davem@davemloft.net>
References: <20260202084820.260033-1-poros@redhat.com>
 <20260202155813.3f8fbc27@kernel.org>
 <b064ca33-1d94-4c7e-b0d0-78430d8cd0ac@intel.com>
 <14cb0b22-ec39-43e4-a35b-22ad558b2e34@redhat.com>
 <7907d42e-4805-48bc-aaf6-16cbe46eb1d2@intel.com>
 <db1723e3-294d-46b7-aa4c-11a21b0da82f@redhat.com>
 <79960c2a-26ea-4472-bebb-4657fcca2255@intel.com>
 <0e17cadc-5cab-44f2-8998-67ecde033a06@intel.com>
 <fd06e5b3-c4cb-4725-a04d-dbc4839e88ea@intel.com>
Content-Language: en-US
From: Petr Oros <poros@redhat.com>
In-Reply-To: <fd06e5b3-c4cb-4725-a04d-dbc4839e88ea@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[13];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-257151-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[redhat.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[poros@redhat.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 548BCF27FD
X-Rspamd-Action: no action


On 2/4/26 20:25, Jacob Keller wrote:
>
>
> On 2/3/2026 10:12 PM, Przemek Kitszel wrote:
>>
>> [...]
>>
>>>> If dropping the lock is a no-go, the only viable path forward is to 
>>>> split the
>>>> reset_task so that the waiting portion is decoupled from the 
>>>> netdev_lock
>>>> critical section.
>>>>
>>> We used to do this back before the netdev shaper ops. We didn't 
>>> acquire either netdev lock or RTNL during reset.
>>>
>>> I thought we had some code in the past that would handle netdev 
>>> stuff outside of reset.. but I don't really know and git blame is 
>>> not making it easy to find this information.
>>
>> IIRC it was iavf_config_task that is used to complete stuff requested
>> under RTNL but later
>>
>>>
>>> Perhaps we don't actually need to hold the netdev lock over the 
>>> reset task.. except Przemek's refactor to remove the critical lock 
>>> now makes us fully dependent on the netdev lock in this case for 
>>> reset :(
>>>
>>>> The fact remains that MTU configuration and ring parameter changes are
>>>> currently broken in iavf. Changing the MTU on a Virtual Function is a
>>>> fundamental configuration not an obscure edge case that can remain 
>>>> non- functional.
>>>>
>>>
>>> Agreed. This needs a resolution. It is just very tricky to figure 
>>> out what the solution should be.
>>>
>>> We need to hold the netdev lock during reset, and we need to have 
>>> our handlers wait for reset to complete in order to be certain their 
>>> task is done... but reset is a separate thread so we can't really 
>>> communicate to it that we're holding the lock, and attempts to do 
>>> that would be a huge problem.
>>>
>>> We don't want to go back to the critical lock and all of its 
>>> horrible problems either. The commit that removed it is here: 
>>> 120f28a6f314 ("iavf: get rid of the crit lock")
>>>
>>>> I would appreciate any further guidance on how you would prefer...
>>>>
>>>
>>> I wish I had some better ideas..
>>>
>>> Bad ideas I've thought about so far:
>>>
>>> 1) this patch with its drop lock and wait, which we discussed as 
>>> problematic before. It creates a lot of issues since it means the 
>>> operations are no longer atomic and we could potentially get stuck 
>>> with some other operation in the event of another thread starting 
>>> some core netdev task. No good.
>>>
>>> 2) not holding netdev_lock in reset, which is now a nogo since we 
>>> removed the crit_lock, and apparently we held netdev_lock prior to 
>>> that too anyways...
>>>
>>> 3) we could maybe do some sort of ref counting dance where we take 
>>> some reference in threads that queue a reset, and the reset task 
>>> would know if that reference was non-zero then another driver thread 
>>> is holding netdev_lock so its safe to go into reset without 
>>> locking... but this feels extremely ugly and error prone to me...
>>>
>>> 4) convert reset handling to a separate function that depends on the 
>>> netdev_lock, and call that directly from within the threads that 
>>> currently "wait for reset" while holding the netdev lock. Thus, we 
>>> basically move this entire call chain into the thread already 
>>> holding the lock, and call it from the context of the function like 
>>> the MTU change, etc. 
>>
>> reset_thread() {
>>      while (!stopped) {
>>          netdev_lock();
>>          reset_step();
>>          netdev_unlock();
>>      }
>> }
>>
>> looks cool, IIRC I did something similar with the "after crit lock
>> removal refactor continuation", but I've put it on hold
>> https://github.com/pkitszel/linux/commits/undeadlock/
>> The linked code went even further and merged all of our admin-worker 
>> threads into one and the whole was protected by the netdev_lock :)
>>
>
> That is a lot of patches and doesn't feel like a minimal fix.
>
>> This feels like its also a huge issue, and could
>>> potentially lead to some sort of issue where we need to still block 
>>> the reset thread from going if we reset at the end of the 
>>> netdev_lock thread..
>>
>> that should queue on the "do later stuff queue", which we don't have
>> right now (and keep some of such stuff in the state machine), but would
>> be useful for many other actions too (like virtchnl messages, for which
>> we have queue-of-1 right now
>>
>
> I think we need to lay out what we need and maybe that will help 
> figure out a solution.
>
>
> 1) several NDO operations need to perform tasks that require AVF 
> hardware to reset, and which need to be certain that happens before 
> they return.
>
> 2) reset is handled by a separate workqueue task
>
> 3) reset also requires the netdev lock
>
>
> We can't make the ndo operations avoid the netdev lock
>
> We pretty much can't make reset not require the netdev lock, 
> especially since we are now using it as effectively the main driver 
> lock now.
>
> I am not certain we can move all of the reset code to work from the 
> ndo thread context, as we still also have to wait for hardware 
> notification that reset happened, which seems like a pretty massive 
> refactor to get right.
>
> We can't drop the waiting in the ndo operation because we need to be 
> sure that the operation applied properly, otherwise we get errors 
> elsewhere.
>
> So that leaves me without any solution so far, certainly not one that 
> can be completed quickly... which means we're stuck with a guaranteed 
> deadlock anytime the MTU is changed?

I’ve been looking at the code on GitHub, and in my opinion, the fastest 
and most straightforward solution is to use a slightly modified approach 
based on patch 8c90ca2 ("iavf: split out body of reset task").

Since that patch refactors iavf_reset_task into iavf_reset_step and 
removes all netdev_lock acquisitions from its internal logic, we can 
resolve the deadlock by calling it directly.

In places where we currently wait (MTU, channels, ringparam), we should 
replace the asynchronous scheduling and waiting with a synchronous call. 
This avoids the deadlock by executing the reset in the thread that 
already holds the netdev_lock:

         if (netif_running(netdev)) {
-               iavf_schedule_reset(adapter, IAVF_FLAG_RESET_NEEDED);
-               ret = iavf_wait_for_reset(adapter);
-               if (ret < 0)
-                       netdev_warn(netdev, "MTU change interrupted 
waiting for reset");
-               else if (ret)
-                       netdev_warn(netdev, "MTU change timed out 
waiting for reset");
+               adapter->flags |= IAVF_FLAG_RESET_NEEDED;
+               iavf_reset_step(adapter);
         }
What do you think about this?


>
>>>
>>> I don't really like any of these solutions, even if (3) and (4) 
>>> aren't fully ruled out as completely broken... they probably have 
>>> all kinds of issues...
>


