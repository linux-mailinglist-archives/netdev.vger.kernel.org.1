Return-Path: <netdev+bounces-305356-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id B5Q6G2bCTGocpQEAu9opvQ
	(envelope-from <netdev+bounces-305356-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 07 Jul 2026 11:09:58 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C34077198A7
	for <lists+netdev@lfdr.de>; Tue, 07 Jul 2026 11:09:57 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b=MLx8sbjz;
	dkim=pass header.d=redhat.com header.s=google header.b=SyGx83Cm;
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-305356-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-305356-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4B147309E5A7
	for <lists+netdev@lfdr.de>; Tue,  7 Jul 2026 09:02:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FDA0390226;
	Tue,  7 Jul 2026 09:02:36 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5297390205
	for <netdev@vger.kernel.org>; Tue,  7 Jul 2026 09:02:34 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783414956; cv=none; b=BVhmQnnjqIX1T/Ps+Crz7EBSTn7m9OzormCQUrl3FkckDZmJK+PR/zo/9dgs2sMMGxlFQJz2uc+HunQ7fEsyTAKhYuGL8VjJr1+SrncpbEgGUabnT5O0xxw/nfMH99MF3I50drzag3eJJXjZK3K6A+t7F33DVflqFUlwWbhlsq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783414956; c=relaxed/simple;
	bh=QfiiqDPs4hpVeN7dGC1uwStx9g3fgFGCd8ZIjhLqd/8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XM9o2PiebElvDDG/l5DoroyWalnHJDZM20gv/3PdXcbNbyTbF0+Hc2xn46BGt6AZvNL2Ac1VLPcUyAcUQKD4h1Q0FZTzcnGp6gqYySCdqKufv/vBALUAdTUZG6rr8qyIPPnPoJunM//rpEzUkiX/AYmMXgLcRYTjZg5swnko/sg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MLx8sbjz; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=SyGx83Cm; arc=none smtp.client-ip=170.10.133.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1783414953;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XvE/3KwFuCcanwiTTFebUv/R3s4QYWaS+H0gfSa4GvQ=;
	b=MLx8sbjzfBK873GApAl3sDqBmuZ3nGs4zr4WUcBZY29YLhaVPIdgC/sf6jVzsPqurPxVvq
	hFeI7RpbrpZnPyQwP1b1BZ8NSoJKdd3yl7wGDeH78GSvvGNS18ezzG+FJI1jRa4CLaC0nl
	d/klZ3UdGhMz52KTFusYHtvwd70AVf0=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-10-voQ8SqzfO4ibVtz_QCXF0Q-1; Tue, 07 Jul 2026 05:02:30 -0400
X-MC-Unique: voQ8SqzfO4ibVtz_QCXF0Q-1
X-Mimecast-MFC-AGG-ID: voQ8SqzfO4ibVtz_QCXF0Q_1783414949
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-493a6fe9ebdso21222925e9.0
        for <netdev@vger.kernel.org>; Tue, 07 Jul 2026 02:02:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1783414949; x=1784019749; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XvE/3KwFuCcanwiTTFebUv/R3s4QYWaS+H0gfSa4GvQ=;
        b=SyGx83CmI9HBzRW6YXDbqDimU7W8OjXygSViDIeVadGLbZaj4mYCouLSd6Dcxtyxa2
         v+A79leCClzYrRYEc91s1Ab99DMLkTdhrkNXZdXvDZYZ2pJnhJP17vR++0yTATuMPnon
         itu6KKFrCrGpZ5kb5Lq3U3Kq3Qqe7E5wxAdizxkLSa7P7+MWRleV7wsXxWoEu9/E3lmX
         SJ0Rs237ZsegeAOyNkwXw/SxVP12sUrRM0wJykUlxlnwZHldCsLN5Fo+L/vE4t5uXjqn
         twnFS8ligGUqynKmCpeuIQvkz5gzvYrQ1NsdQr36tZq3/FPX/3/C4CB5uHIOF3dpUrdX
         ThRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783414949; x=1784019749;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XvE/3KwFuCcanwiTTFebUv/R3s4QYWaS+H0gfSa4GvQ=;
        b=sG2s5uw4GsrhXcS4szc+AqqSrX+4BDzP7gptkBz5bxJ1n+BhKwmubhg01VmWJ+gOAm
         fdN8rENjMTyNJfHI+lSoKVp0mwdIy7k4pkZJ32ZPreCsge2K5ETUqGEeWXZjgMVze/vm
         /6KuLzzFWTmuQWAYX3ClQCe0pHUvW2Pfjf967HBJbJA0jx8xNws9HTtHqpLAbBsPzZBc
         yWkuzBTUQR+nz6t+zIjGXlu0uSJANXLf1W9nV0JNDOAozSP0nl0+A2iwSkQZcj4XzP5U
         irrDuX3qJ3tw2fdTV6QFm9mOVmZjdXBkj5DpKqgqF59yD/nyEG8GKgOWgvGJHAzvUEKv
         hf5Q==
X-Forwarded-Encrypted: i=1; AHgh+Rp8APcs9hguvCR54kIJzXwXKTHVa/YxL+9B6lwM2wbvgggtf9EkRHhmzMYiJ6jzmyFfq4bFAIk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyO+Pb3m+0q0tlVCn/NShovAUwbI03c1zEBDt62Iszrz9yP/Fbf
	tUzm2oM2TjNCy99gGPG+HmXE0NDUSytWzfY0xrlbN8ADgrcncSC2puoDyek2dHVKXE9a/bQXBma
	bgecNCxjcOpDPlVZrR6mJsZ9iJcBwVrUyIdNJV7zwVTOvOSnxEW9bFiYqkw==
X-Gm-Gg: AfdE7cmkITkNuWDTyzNKEGVTMK9RF5DNNdv69Cos5D/O/B7xRqfybrrYcb/OYLo4A1K
	Mp+XE2XIG30EhirREBJhvQNepLzPo5DAJMaqmsigaLh9DlLDp7Vh3+qF5RKzZ1/hj/+gDpsHyP3
	q+iPGwnCvfiCShWWBGlvxbcCrFT8bt0qUAu3hIF3cRe8BfPnawMgvIkuajdKtCJS+AUULqXtKPz
	WMDvA+zHvlpvbmBPiKuXmVPcNq4uAI1a7OBSx+/PQbErzt8UCfkiyGE+GguvFFV5rMC+5gPWT9x
	ZcTpGpJQn+qekguPPQQaEB8FXKM1O45FPKQ8G+aBNHn63I4gpr9AwuOYETJW/t0qv02IQ85gT0b
	g7IOUML7IpDNraEM+i3Pct00HiW0wVSLPw3bdOJWYJvGZ84EuL9/stbn9M34/EETKV1VE8b+bXt
	mSy+eoRUP5zYCG
X-Received: by 2002:a7b:cc81:0:b0:493:cc01:807b with SMTP id 5b1f17b1804b1-493df0a0861mr33866605e9.38.1783414948970;
        Tue, 07 Jul 2026 02:02:28 -0700 (PDT)
X-Received: by 2002:a7b:cc81:0:b0:493:cc01:807b with SMTP id 5b1f17b1804b1-493df0a0861mr33866145e9.38.1783414948477;
        Tue, 07 Jul 2026 02:02:28 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:5521:6b10:58fd:68f:7756:389d? ([2a0d:3344:5521:6b10:58fd:68f:7756:389d])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493e0fc1348sm40703705e9.14.2026.07.07.02.02.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Jul 2026 02:02:27 -0700 (PDT)
Message-ID: <ef3a91ba-f4c5-4d89-a88b-465b5b7fab12@redhat.com>
Date: Tue, 7 Jul 2026 11:02:26 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2] ipv4: hold a consistent view of rt->dst.dev
 under RCU
To: luoxuanqiang <xuanqiang.luo@linux.dev>, Ido Schimmel <idosch@nvidia.com>
Cc: "David S . Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 David Ahern <dsahern@kernel.org>, Simon Horman <horms@kernel.org>,
 Kuniyuki Iwashima <kuniyu@google.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Xuanqiang Luo <luoxuanqiang@kylinos.cn>
References: <20260701032434.17500-1-xuanqiang.luo@linux.dev>
 <20260705164649.GA295849@shredder>
 <5e2119f1-3c1c-43eb-984e-a8eeab2896e0@linux.dev>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <5e2119f1-3c1c-43eb-984e-a8eeab2896e0@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[redhat.com:+];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-305356-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:xuanqiang.luo@linux.dev,m:idosch@nvidia.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:dsahern@kernel.org,m:horms@kernel.org,m:kuniyu@google.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:luoxuanqiang@kylinos.cn,s:lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,kylinos.cn:email,vger.kernel.org:from_smtp,linux.dev:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C34077198A7

On 7/7/26 3:26 AM, luoxuanqiang wrote:
> 在 2026/7/6 00:46, Ido Schimmel 写道:
>> On Wed, Jul 01, 2026 at 11:24:34AM +0800,xuanqiang.luo@linux.dev wrote:
>>> From: Xuanqiang Luo<luoxuanqiang@kylinos.cn>
>>>
>>> rt_flush_dev() walks the per-CPU uncached route list and rewrites
>>> rt->dst.dev in-place to blackhole_netdev under spin_lock_bh().
>>> This lock does not exclude RCU readers, which may load rt->dst.dev
>>> multiple times within a single rcu_read_lock() region.
>>>
>>> ip_rt_send_redirect() is a typical example: it reads rt->dst.dev
>>> three times to obtain in_dev, the L3 master ifindex, and net.
>>> A concurrent device unregistration can repoint rt->dst.dev to
>>> blackhole_netdev between those reads, making the reader combine
>>> state from two different net_devices — for instance, an in_dev
>>> from the real device but a netns and peer lookup from the blackhole
>>> device.  ip_rt_get_source() has the same problem: it reads
>>> rt->dst.dev four times to obtain the output ifindex, the netns,
>>> and the source address, so a concurrent flush can cause the source
>>> selection to mix state from different devices.
>> Why only change ip_rt_send_redirect() and ip_rt_get_source() when the
>> patch is titled "ipv4: hold a consistent view of rt->dst.dev under RCU"?
>> What is the criterion?
> 
> Thanks! You are right, the subject is too broad. I will make them
> more accurate in the next version.
> 
>>> Take a single dst_dev_rcu() snapshot of rt->dst.dev at the start
>>> of each affected RCU reader and use that snapshot throughout, so
>>> concurrent flushes cannot cause mid-function inconsistency.
>>> Publish the in-place write in rt_flush_dev() with rcu_assign_pointer()
>>> to match the readers.
>> The rt_flush_dev() change should be a separate change. Note that
>> dst_dev_put() was already converted to use rcu_assign_pointer().
>>
> I will split the rt_flush_dev() change into a separate patch.
> 
>>> Fixes: caacf05e5ad1a ("ipv4: Properly purge netdev references on uncached routes.")
>> Please remove the Fixes tag given you are targeting net-next.
> 
> Just to clarify: is the suggestion to drop the Fixes tag here solely
> because this patch is targeted at net-next? Or are there any other
> reasons?

Generally speaking, yes: net-next patches should not include a fixes tag
unless the blamed commit is on net-next only.

More specifically, this patch is really a behavior improvement and not a
vertical fix, as such we want to avoid it propagating on stable trees,
as the fixes tag sometimes does.

/P



