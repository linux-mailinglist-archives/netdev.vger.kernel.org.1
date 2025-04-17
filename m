Return-Path: <netdev+bounces-183800-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0732FA920D5
	for <lists+netdev@lfdr.de>; Thu, 17 Apr 2025 17:07:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6EC34188C76C
	for <lists+netdev@lfdr.de>; Thu, 17 Apr 2025 15:07:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B9A324E01F;
	Thu, 17 Apr 2025 15:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="H3oBwfDn"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F57E2475C7
	for <netdev@vger.kernel.org>; Thu, 17 Apr 2025 15:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744902446; cv=none; b=ZgB/Slb9m5CLPQGtf9AlYgIoKJOqMGiGFXpx/n9e3Bi6xEOVH4M0gmhuYN/1QTgi74VxUodAdwsfSxoukR06Ws9qvofVADxD6lKQlLTleG0ctb+X7/vwZepNbLL4QhfEWbutGhIKEPMBWq/nLeymNNLLT/4p2ecmLSUqFWHEfcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744902446; c=relaxed/simple;
	bh=B7XexERuaMMMLPg8aDrwbEfwzYiQp47UuvLtUdrvycw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=sOfs+bBunDKAfDlc37ZrFHCQb4ZUT2dkWpOF9slPxaJdLc+CBvkhpwseW6SR053W9aVX34OQQoLBKkoEAIbqmAFlEzvFnzQEs7kRw4hgImp6muoukGeP9Ji4qlPg9Sv1n1p6mMFEGUhEYifpMHrXI0LaZARQd7eawDhaNhWszBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=H3oBwfDn; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744902443;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=H0kdA5rFfxf/6wSGoecn+F+bnq14+8ogjP5bxs/pSuI=;
	b=H3oBwfDnvl5GQG785nShH9I5fi36aiaiJPXnNlx0/oK5L+S5MTBtJurcyp8HB88/Rqop9x
	IwmgqAFd3BEMlror7RNqNzeS5T1r7L9c/RjYU1B7iv7KKIWtGJNicIHMFIN1HDjriYutQL
	kkKyEhaWwwHvmSTaZeowfkdoAtODS54=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-547-fCm0jeN6PkOUjWTAnvMrog-1; Thu,
 17 Apr 2025 11:07:19 -0400
X-MC-Unique: fCm0jeN6PkOUjWTAnvMrog-1
X-Mimecast-MFC-AGG-ID: fCm0jeN6PkOUjWTAnvMrog_1744902436
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 504741800980;
	Thu, 17 Apr 2025 15:07:16 +0000 (UTC)
Received: from RHTRH0061144 (unknown [10.22.64.251])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5C9C319560A3;
	Thu, 17 Apr 2025 15:07:13 +0000 (UTC)
From: Aaron Conole <aconole@redhat.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
  netdev@vger.kernel.org,  linux-rt-devel@lists.linux.dev,  "David S.
 Miller" <davem@davemloft.net>,  Eric Dumazet <edumazet@google.com>,  Jakub
 Kicinski <kuba@kernel.org>,  Simon Horman <horms@kernel.org>,  Thomas
 Gleixner <tglx@linutronix.de>,  Eelco Chaudron <echaudro@redhat.com>,
  Ilya Maximets <i.maximets@ovn.org>,  dev@openvswitch.org
Subject: Re: [PATCH net-next v2 12/18] openvswitch: Move
 ovs_frag_data_storage into the struct ovs_pcpu_storage
In-Reply-To: <867bb4b6-df27-4948-ab51-9dcc11c04064@redhat.com> (Paolo Abeni's
	message of "Thu, 17 Apr 2025 10:01:17 +0200")
References: <20250414160754.503321-1-bigeasy@linutronix.de>
	<20250414160754.503321-13-bigeasy@linutronix.de>
	<f7tbjsxfl22.fsf@redhat.com> <20250416164509.FOo_r2m1@linutronix.de>
	<867bb4b6-df27-4948-ab51-9dcc11c04064@redhat.com>
Date: Thu, 17 Apr 2025 11:07:11 -0400
Message-ID: <f7t4iymg734.fsf@redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

Paolo Abeni <pabeni@redhat.com> writes:

> On 4/16/25 6:45 PM, Sebastian Andrzej Siewior wrote:
>> On 2025-04-15 12:26:13 [-0400], Aaron Conole wrote:
>>> I'm going to reply here, but I need to bisect a bit more (though I
>>> suspect the results below are due to 11/18).  When I tested with this
>>> patch there were lots of "unexplained" latency spikes during processing
>>> (note, I'm not doing PREEMPT_RT in my testing, but I guess it would
>>> smooth the spikes out at the cost of max performance).
>>>
>>> With the series:
>>> [SUM]   0.00-300.00 sec  3.28 TBytes  96.1 Gbits/sec  9417             sender
>>> [SUM]   0.00-300.00 sec  3.28 TBytes  96.1 Gbits/sec                  receiver
>>>
>>> Without the series:
>>> [SUM]   0.00-300.00 sec  3.26 TBytes  95.5 Gbits/sec  149             sender
>>> [SUM]   0.00-300.00 sec  3.26 TBytes  95.5 Gbits/sec                  receiver
>>>
>>> And while the 'final' numbers might look acceptable, one thing I'll note
>>> is I saw multiple stalls as:
>>>
>>> [  5]  57.00-58.00  sec   128 KBytes   903 Kbits/sec    0   4.02 MBytes
>>>
>>> But without the patch, I didn't see such stalls.  My testing:
>>>
>>> 1. Install openvswitch userspace and ipcalc
>>> 2. start userspace.
>>> 3. Setup two netns and connect them (I have a more complicated script to
>>>    set up the flows, and I can send that to you)
>>> 4. Use iperf3 to test (-P5 -t 300)
>>>
>>> As I wrote I suspect the locking in 11 is leading to these stalls, as
>>> the data I'm sending shouldn't be hitting the frag path.
>>>
>>> Do these results seem expected to you?
>> 
>> You have slightly better throughput but way more retries. I wouldn't
>> expect that. And then the stall.
>> 
>> Patch 10 & 12 move per-CPU variables around and makes them "static"
>> rather than allocating them at module init time. I would not expect this
>> to have a negative impact.
>> Patch #11 assigns the current thread to a variable and clears it again.
>> The remaining lockdep code disappears. The whole thing runs with BH
>> disabled so no preemption.
>> 
>> I can't explain what you observe here. Unless it is a random glitch
>> please send the script and I try to take a look.
>
> I also think this series should not have any visible performance impact
> on not RT OVS tests. @Aaron: could you please double check the results
> (both the good on unpatched kernel and the bad with the series applied)
> are reproducible and not due some glitches.

I agree, it doesn't seem like it should.  I guess a v3 is coming, so I
will retry with that.  I planned to ack 10/18 and 12/18 anyway; even
without the lock restructure, it seems 'nicer' to have the pcpu
variables in a single location.

BTW, I am using a slightly modified version of:
https://gist.github.com/apconole/ed78c9a2e76add9942dc3d6cbcfff4ca

It sets things up similarly to an SDN deployment (although not perfectly
since I was testing something very special at the time), and I was just
doing netns->netns testing (so it would go through ct() calls but not
ct(nat) calls).

> @Sebastian: I think the 'owner' assignment could be optimized out at
> compile time for non RT build - will likely not matter for performances,
> but I think it will be 'nicer', could you please update the patches to
> do that?
>
> Thanks!
>
> Paolo


