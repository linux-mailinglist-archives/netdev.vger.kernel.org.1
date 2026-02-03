Return-Path: <netdev+bounces-256258-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SH34AFPegWmDLQMAu9opvQ
	(envelope-from <netdev+bounces-256258-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 03 Feb 2026 12:38:59 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 76DB6D87C8
	for <lists+netdev@lfdr.de>; Tue, 03 Feb 2026 12:38:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B36E9308C253
	for <lists+netdev@lfdr.de>; Tue,  3 Feb 2026 11:32:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6062318B8F;
	Tue,  3 Feb 2026 11:32:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="F6B0+8qW";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="tynBgFKy"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44B802DEA95
	for <netdev@vger.kernel.org>; Tue,  3 Feb 2026 11:32:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770118375; cv=none; b=NdBJg7Pb2H9D3yyeY2vRUVAnNbyQpzGusyVre2kud0i58zbYJB9YF3m7hZkmKcCcWAxfm0ZPD2bCnwLDA1atACOaJOy/TvRyCmTBYfQPWmQlKi8ykRCJ75USvVuLAo3oAN8wXS50Qfv3El62/BbrH2mwC4cpXtdquDKmEBCgpCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770118375; c=relaxed/simple;
	bh=fvyV02ZW3kLZ2e5V7ZC1CiXFpmVv76IxX1uzkp0TxLo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iJ4JaMFnSaitcdgW1wfqgGaGFyRAyQDQH73KTuPUUwWwpt9abgzei5vyhp7+TArcur7DFVKy49/O1MiVNlv5LNJRwzmmqUcsuaEl0VkNu/cNNp6fNoSyrwzWdmusQMcEonIbnFWOuvQZg0C3PeDzprD4hH2pd8s9zCMyGh2wjVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=F6B0+8qW; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=tynBgFKy; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1770118373;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WCFzyXHFlPrMBFKkr2XvCqwF53SaNdsFKd3C1yICKWI=;
	b=F6B0+8qW9t5XaGMLWv62g/c9CWO3ds5hTK+T/uXuMtmcwFoBYdfO651dFIAhFDodgmiRgl
	vRBptYhUslzm5nX59PWOn8I20by0exhGUofN+BnafJSNeAN6rF8KoM8LMrDAa6U3KVd+IP
	0ouXlCVqbuVr9wR/zlTZBVxu9weUV5s=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-572-nOzy3ZVTN8C5yQIbuKSfhw-1; Tue, 03 Feb 2026 06:32:52 -0500
X-MC-Unique: nOzy3ZVTN8C5yQIbuKSfhw-1
X-Mimecast-MFC-AGG-ID: nOzy3ZVTN8C5yQIbuKSfhw_1770118371
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-47ee1fe7b24so54256135e9.1
        for <netdev@vger.kernel.org>; Tue, 03 Feb 2026 03:32:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1770118371; x=1770723171; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WCFzyXHFlPrMBFKkr2XvCqwF53SaNdsFKd3C1yICKWI=;
        b=tynBgFKy0qAyy7GwXSMkQk0Pv2earhvBOmalSCGZxSY5K1OObbRWoj4VKewai5NYHM
         gN/6VnDZM9M062r+l8uwmNOBOvcNJFu57agARIWf4fzZbQ4BZLfLWhD/qNS/Bz/bq7rU
         Q4tNgU7iuIzw/kFtERsKWcoPe6MygtoAwR7Rb6yQYsxWytcZGj200fz2nSKsr+6F2dBr
         0H48yWHlIMP182Na8VwEK1r00bn22aJCiCJLumTLOAijZOPlzWGuJpcQBNIPOsYFWDWi
         Mn7Pa1Wy3Q68/DDG62t45WzbpTMTpt8uUD1GawiB40+3WPy7jwzSkT7Sxy0DG2+R48XB
         ZxIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770118371; x=1770723171;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WCFzyXHFlPrMBFKkr2XvCqwF53SaNdsFKd3C1yICKWI=;
        b=TaKmU3m5Oces/pBNjkmfu1n5r0z27HN2UNeV7QVBeL7lqxORdoVWjSY/g3fVq9rwY9
         S7sakjjXylU+oLp0Eu2WkqlQBMQdo7CANHu02S9/y6M8ig6KkXu4ef2cAKAKWMIFIROi
         3CHUT08BAknHC4DTk8BlPcXYfj7vsz0wx58mg+Lzgduz7AYIt7W5UdEW/3MjymHuJrMO
         s0j/7mMD6doOlEiVk1gjBz5WlEidJxQoks2WPsauIHmU4aCUpbADx4cdR6u9txu4dxrV
         p4AntzjXp1nh8+BpuyMEZt3RZrF28UFFZ5p3dIKcoePwaV8RjnzjE9nLajahS6qbHKKN
         wjKw==
X-Forwarded-Encrypted: i=1; AJvYcCVITKJc9xqW8ZY5zReTRPsznWW8OKooGXORMGT159CziX9RgNHAGlchmTNNutokXt/TYsE6phc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8Qhs0jjrRsN/km/LwWfsIXZAn4FBm6k4hitde7ME31siPp4rq
	ehs5ctGjC0+f6YEr5qsQpC9O54cD0L2K/Lllql8gc+LGjo4NSu94ffZXLjAEHyRaIHiooGLIga7
	E0FdrSwj/+6bBQeILwoDZmeeYYjt84kfRR+T3gleindD6fKhm5RVMNaCS/A==
X-Gm-Gg: AZuq6aK0o/CTibz++eXlMmhRhMMrA9wXb9gNmxuy1FMwWCo68E1zIAwluauXnEG4SCG
	wQy3BmyTjezBqpu2f0xJZeO7dw7nTMmyNbKDW0U7o7NUsNPwXvJGZivIreYqO75Gn2l8hwMFFIK
	PYPvxKYkNVOlnO9D4eCYGwvhagUeSi6t/OMR5am85SpsGfj6Ih8kfCgnh8MBYeoXmw4KtKW1SLf
	k1JWr8MoEOtHPPYGnpGLDkeM70iSpAF6pcpugQFBQM1Rdws50ZabpJt3Fu5Of1gY3fvXqsPMpBs
	Um++eIZdlbMGygUpBrYvLv4OLgLE+qMh4Sd3wZTnWxDh6UNe7MCM60Xhpn0HabuC2Q+MRS5DKV2
	/TxUv102S
X-Received: by 2002:a05:600c:474d:b0:46f:c55a:5a8d with SMTP id 5b1f17b1804b1-482db44d141mr233861685e9.4.1770118370849;
        Tue, 03 Feb 2026 03:32:50 -0800 (PST)
X-Received: by 2002:a05:600c:474d:b0:46f:c55a:5a8d with SMTP id 5b1f17b1804b1-482db44d141mr233861205e9.4.1770118370338;
        Tue, 03 Feb 2026 03:32:50 -0800 (PST)
Received: from [192.168.2.83] ([46.175.183.46])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4360ef9e804sm9385010f8f.41.2026.02.03.03.32.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Feb 2026 03:32:49 -0800 (PST)
Message-ID: <db1723e3-294d-46b7-aa4c-11a21b0da82f@redhat.com>
Date: Tue, 3 Feb 2026 12:32:47 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [PATCH net] iavf: fix deadlock in reset
 handling
To: Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Jacob Keller <jacob.e.keller@intel.com>, Jakub Kicinski <kuba@kernel.org>
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
Content-Language: en-US
From: Petr Oros <poros@redhat.com>
In-Reply-To: <7907d42e-4805-48bc-aaf6-16cbe46eb1d2@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[13];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-256258-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[redhat.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[poros@redhat.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 76DB6D87C8
X-Rspamd-Action: no action


On 2/3/26 11:19, Przemek Kitszel wrote:
> On 2/3/26 09:44, Petr Oros wrote:
>>
>> On 2/3/26 02:00, Jacob Keller wrote:
>>>
>>>
>>> On 2/2/2026 3:58 PM, Jakub Kicinski wrote:
>>>> On Mon,  2 Feb 2026 09:48:20 +0100 Petr Oros wrote:
>>>>> +    netdev_unlock(netdev);
>>>>> +    ret = wait_event_interruptible_timeout(adapter->reset_waitqueue,
>>>>> + !iavf_is_reset_in_progress(adapter),
>>>>> +                           msecs_to_jiffies(5000));
>>>>> +    netdev_lock(netdev);
>>>>
>>>> Dropping locks taken by the core around the driver callback
>>>> is obviously unacceptable. SMH.
>>>
>>> Right. It seems like the correct fix is to either a) have reset take 
>>> and hold the netdev lock (now that its distinct from the global RTNL 
>>> lock) or b) refactor reset so that it can defer any of the netdev 
>>> related stuff somehow.
>>>
>> I modeled this after the existing pattern in iavf_close() (ndo_stop), 
>> which also temporarily releases the netdev instance lock taken by the 
>> core to wait for an async operation to complete:
>
> First of all, thank you for working on that, I was hit by the very same
> problem (no series yet), but my local fix is the same as of now.
>
> I don't see an easy fix (w/o substantial driver refactor).
>
>>
>> static int iavf_close(struct net_device *netdev)
>> {
>>          netdev_assert_locked(netdev);
>>          ...
>>          iavf_down(adapter);
>>          iavf_change_state(adapter, __IAVF_DOWN_PENDING);
>>          iavf_free_traffic_irqs(adapter);
>>
>>          netdev_unlock(netdev);
>>
>>          status = wait_event_timeout(adapter->down_waitqueue,
>>                                      adapter->state == __IAVF_DOWN,
>>                                      msecs_to_jiffies(500));
>>          if (!status)
>>                  netdev_warn(netdev, "Device resources not yet 
>> released\n");
>>          netdev_lock(netdev);
>>          ...
>> }
>>
>> This was introduced by commit 120f28a6f314fe ("iavf: get rid of the 
>> crit lock"), and ndo_stop is called with netdev instance lock held by 
>> the core just like ndo_change_mtu is. 
>
> technically it was introduced by commmit afc664987ab3 ("eth: iavf:
> extend the netdev_lock usage")
>
>> Could you clarify why the unlock-wait- lock pattern is acceptable in 
>> ndo_stop but not here?
>>
>
> perhaps just closing netdev is a special kind of operation
>
> Other thing is that the lock was added to allow further NAPI
> development, and one silly driver should not stop that effort.
> Sadly, we have not managed to re-design the driver yet. I would like to
> do so personally, but have much work accumulated/pending to free my time
>
I agree, the unlock-wait-lock pattern is fundamentally flawed (I now 
understand
why it is unacceptable) and should be avoided.

What can we do now?

* Eliminating the wait is not an option: As noted in the description of 
commit
c2ed2403f12c, this wait was originally added to fix a race condition where
adding an interface to bonding failed because the device remained in
__RESETTING state after the callback returned.
* Passing the lock into reset is impractical: The reset path is 
triggered from
numerous contexts, many of which are not under the netdev_lock, making this
even more complex than a full refactor.

If dropping the lock is a no-go, the only viable path forward is to 
split the
reset_task so that the waiting portion is decoupled from the netdev_lock
critical section.

The fact remains that MTU configuration and ring parameter changes are
currently broken in iavf. Changing the MTU on a Virtual Function is a
fundamental configuration not an obscure edge case that can remain 
non-functional.

I would appreciate any further guidance on how you would prefer...



