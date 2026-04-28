Return-Path: <netdev+bounces-281741-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mLogBQF+8Gl8UAEAu9opvQ
	(envelope-from <netdev+bounces-281741-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 11:29:37 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 35E884816DA
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 11:29:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 34DDB313B722
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 09:14:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D03E33ADB9;
	Tue, 28 Apr 2026 09:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HMOrnfeR";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="JGnA+kXX"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DC55374198
	for <netdev@vger.kernel.org>; Tue, 28 Apr 2026 09:14:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777367663; cv=none; b=J1+Sfi7Tb8HqvdyomhvgGtCcLuiNRswxmyZgLkMAADDcApXURzpbt8oIP6JDu2M3z5tOE2ncK3HUBvJosHCtCW1lISqnEPiZ7P4Hfg+m7pQoAFdHf/eXOS9CNz3CoCCivw9WEB7o+9KqSDrnoC4pA2ztoHNXzv6rFnelK+WpUSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777367663; c=relaxed/simple;
	bh=4GkDVVEv08AkmrNXJY3nxp8e2TsLCNnF8yTHag+O6bg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EOA3Aad5qkZJincqIfE7MIXBYkb9wn9WV4EdeNRiPEJmdxDg8mG1gNbWQUqF+ayf9CE4SQoe+yA7f9k6RhUvm1InOxQhc6zYshPNfyGrWi67GKsjezFP6groiHLUEaqhthpaFHi+5GG+gnwLwKWDD6SFH4IXR5Ctrc+tYx8UvyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HMOrnfeR; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=JGnA+kXX; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1777367661;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/jdccpIy7hv3+DluffTpSfC70lKLfgOcLkHxN6neGN8=;
	b=HMOrnfeRG71sV8y5jDg7KVt1unMmcKc9ITRD6VP5u6Y1TleWve0uj2D/EXa4i4vxEClN7o
	dWy4FLIk8H2Ip698rheu4fjRla3MVANu3YAk6M/S+tsu0nWWmPDjYrTfyt1KhZnY4f7xXR
	V6v3MLdk2tFLxQytFoWVfJIO+G26WYM=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-292-agzs9CtANiKHj5yCyxVLjw-1; Tue, 28 Apr 2026 05:14:20 -0400
X-MC-Unique: agzs9CtANiKHj5yCyxVLjw-1
X-Mimecast-MFC-AGG-ID: agzs9CtANiKHj5yCyxVLjw_1777367659
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-44696b11265so455217f8f.0
        for <netdev@vger.kernel.org>; Tue, 28 Apr 2026 02:14:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1777367659; x=1777972459; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/jdccpIy7hv3+DluffTpSfC70lKLfgOcLkHxN6neGN8=;
        b=JGnA+kXXFTQCh1znoikaAsEly669RudeuB8YNBsLio4363kypED6u0iGkbTW7ludzY
         VpiNSGMzKiKWhEcgx5tQ5nYNvGl79rjnY90gyuBRh9w1ambS2bk+q4DaHggPExp0vr3k
         FnFWfzbKswgIwK+XYBtMTlfT0kLj6HWkQQyGNsveg4w8f7Kw+vLv+wQmED/bQZfUSIDR
         m5poowyKmFnQq2zy5QHuVdKz1Lqc85+BvuHdY2FRBOyCTtNS2mPYt1LqXYoEcGGRshCX
         Kmf6JyEomS/WS1JPvARMbSyvKSeSNZMk4B+WFlPkigY/PmQXmufc6+Ot8fI+3LV2I7W7
         UGDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777367659; x=1777972459;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/jdccpIy7hv3+DluffTpSfC70lKLfgOcLkHxN6neGN8=;
        b=euSqg2PHUEYkellxLnfbOjjVYZIQm7RADqOlVqsvduDL8Rde6wmeU0dXtfBN4nCQNG
         47W6EjWkRbs74nXAbSNt7SI3LY6wAWzaap9IOxbVOi9rZzjebZUfv9RNUUnUUe5IBt4y
         EeW99/og7FRZ67/i34U6TccisxfVeV3x5hhnVlxNSUDyO6YDNVhDl1o/ghu9W3IJThCi
         mn6gy5bsECqoq/rirNxElYqu/SJv3ecCqJEVg7gabjltDKUN6/HgT/at6ACiQ67SeICM
         al46AVUAQlYx4b/8BX2tSMXHcialX3YEdLOpx5Srv1H/mITgTZYiSyKx1HEDYzWnlaVN
         uAlA==
X-Forwarded-Encrypted: i=1; AFNElJ89zB3EMt/gcuW0sgfptkdj5fvkBFYq5NBC18Zl68wxHJ37ICSd8V8wnI58NWYSpiD/rleUzUA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7hxIsOHtV/X7cQX8FTHuCXc7n+xTOdKihSq14VcM5FETijQPK
	GaH6d7RGpT7jXfncNk2LrigqBdROb91BeYiHJH7yaMf4oxSYmDzEiSxZuT17BrnU9JCu9/xSUvS
	OXEYgnVs5iag5HSfWzJto0tdgWJ0YPKGZE+MVItNn1jKJ93LfBH12jqFD/w==
X-Gm-Gg: AeBDieu7q3yNd228TuY9/3mlhr9ALyC0Z8IpnuOt5cy8cgmPAWXQsMld5bQLvr66C/8
	PWcx2dmB3d5a7Z/Z4Bl1PcKFrXCcCI6IX6CWdzgtVdqugyl0q9AfHHh1ytcv8VTMbQR6yRGSxvg
	hBLjtui1bmzh7Lib5uFEF/ALdzxJ+9dePXjC99tMAy1FJPD6u9zCNXjroSb8KVPsi4fOgIIbeK9
	vQjAGUpp2JKzI49tPNxuL5qCoXsL5CRZuZvdg8Lsgkf22dmsAkZJtkY1tJO8o/Vkidsngq/51/U
	nrffARtVzrCsSduIa6aQyKzjOJDwk7GMUEAA0pESTHT0xZq5SctMF0MznF+cYJZ9tP3Gte9ronV
	aIyouoberNDBGxK/ZICtfAcMsAlfwbgJq6qPFWsUDrXuDwJ5EgCX6kZmEudiQZCrj0A==
X-Received: by 2002:a5d:5f51:0:b0:441:1df5:480c with SMTP id ffacd0b85a97d-4464a070032mr4183703f8f.42.1777367658520;
        Tue, 28 Apr 2026 02:14:18 -0700 (PDT)
X-Received: by 2002:a5d:5f51:0:b0:441:1df5:480c with SMTP id ffacd0b85a97d-4464a070032mr4183660f8f.42.1777367658030;
        Tue, 28 Apr 2026 02:14:18 -0700 (PDT)
Received: from [192.168.88.32] ([216.128.9.114])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4463fa89140sm4764422f8f.27.2026.04.28.02.14.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Apr 2026 02:14:17 -0700 (PDT)
Message-ID: <efe42959-81c4-4d35-a3d0-fd084c9cda25@redhat.com>
Date: Tue, 28 Apr 2026 11:14:15 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net: ipv6: fix NOREF dst use in seg6 and rpl
 lwtunnels
To: Andrea Mayer <andrea.mayer@uniroma2.it>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: davem@davemloft.net, dsahern@kernel.org, edumazet@google.com,
 kuba@kernel.org, horms@kernel.org, clrkwllms@kernel.org,
 rostedt@goodmis.org, david.lebrun@uclouvain.be, alex.aring@gmail.com,
 Justin Iurman <justin.iurman@gmail.com>, stefano.salsano@uniroma2.it,
 netdev@vger.kernel.org, linux-rt-devel@lists.linux.dev,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20260421094735.20997-1-andrea.mayer@uniroma2.it>
 <20260423080056.KgHlh9Oa@linutronix.de>
 <20260425160856.8cebade5eae1dcaec7af8bfe@uniroma2.it>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20260425160856.8cebade5eae1dcaec7af8bfe@uniroma2.it>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 35E884816DA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,google.com,goodmis.org,uclouvain.be,gmail.com,uniroma2.it,vger.kernel.org,lists.linux.dev];
	TAGGED_FROM(0.00)[bounces-281741-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[redhat.com:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linutronix.de:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]

On 4/25/26 4:08 PM, Andrea Mayer wrote:
> On Thu, 23 Apr 2026 10:00:56 +0200
> Sebastian Andrzej Siewior <bigeasy@linutronix.de> wrote:
> 
> Hi Sebastian,
> 
> thanks for the review, and to Simon and Justin as well.
> 
> 
>> On 2026-04-21 11:47:35 [+0200], Andrea Mayer wrote:
>>>
>>> [snip]
>>
>> So the dst passed to skb_dst_set_noref() has no reference count. The fix
>> is to use skb_dst_force() to increment the refcount on it. But this
>> requires that we are in the same RCU section. And I guess we are since
>> none of the warnings are visible.
>  
> Yes. lwtunnel_input() holds rcu_read_lock() around ops->input(), which is
> where seg6_input_core()/rpl_input() execute. The skb_dst_force() is called
> within that RCU section.
>  
> 
>> Doesn't this make ip6_route_input() on RT fragile in general due to the
>> RT6_LOOKUP_F_DST_NOREF usage or here something special about the two
>> files that are patched?
>> Based on your explanation it all makes sense, I am just not sure if this
>> race is limited to those two are if there is more to it.
> 
> seg6_input_core() and rpl_input() cache the dst via dst_cache_set_ip6(), which
> invokes dst_hold(). The dst_hold() calls rcuref_get(), failing on a zero
> refcount and triggering a WARN, but the pointer is still stored in the cache.
> After the RCU grace period completes the dst is freed, and a subsequent
> dst_cache_get() returns a dangling pointer.
>  
> The other callers of ip6_route_input() (e.g., ipv6_srh_rcv, ipv6_rpl_srh_rcv,
> ip6_rcv_finish_core) consume the NOREF dst without caching it. Even if the
> pcpu_rt's refcount is concurrently dropped to zero, the dst memory remains
> valid because dst_release() defers the actual free via call_rcu_hurry() and the
> caller is still inside the RCU read-side critical section.
> 
> 
>>> [snip]
>>>
>>> Fixes: af4a2209b134 ("ipv6: sr: use dst_cache in seg6_input")
>>> Fixes: a7a29f9c361f ("net: ipv6: add rpl sr tunnel")
>>
>> If having PREEMPT_RT_NEEDS_BH_LOCK unset is the requirement then the
>> right fixes: would be
>> Fixes: 3253cb49cbad4 ("softirq: Allow to drop the softirq-BKL lock on PREEMPT_RT")
>>
>> as prior this commit the race is not possible, right?
> 
> I built and tested kernels at 3253cb49cbad and its parent fd4e876f59b7 (both
> CONFIG_PREEMPT_RT=y, without the fix): no issues at fd4e876f59b7.
> At 3253cb49cbad, a pcpu_rt cmpxchg contention in rt6_make_pcpu_route() shows
> up, which was addressed in 1adaea51c61b. I also tested at 1adaea51c61b, and at
> that point the dst_hold() race described in this patch appears.
>  
> The seg6/rpl code obtains a NOREF dst from ip6_route_input(), does not promote
> it via skb_dst_force(), and passes it to dst_cache_set_ip6() which calls
> dst_hold(). This pattern has been present since af4a2209b134 and a7a29f9c361f,
> and the current Fixes: tags point to the commits where it was introduced.
> Does that seem reasonable?

I think the above is correct, but also pointing to 3253cb49cbad4 would
be correct, since the latter is required to exploit the problem. I also
think cases like this one it's better to avoid the repost (since the
constant ML flood) and to err on the conservative side (older hash). So
I'm applying the patch as-is.

Thanks,

Paolo


