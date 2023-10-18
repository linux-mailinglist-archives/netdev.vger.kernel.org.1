Return-Path: <netdev+bounces-42127-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AF3A7CD452
	for <lists+netdev@lfdr.de>; Wed, 18 Oct 2023 08:20:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B4D491C209EE
	for <lists+netdev@lfdr.de>; Wed, 18 Oct 2023 06:20:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FE748F69;
	Wed, 18 Oct 2023 06:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="vbewnWhG"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C36E1FC5
	for <netdev@vger.kernel.org>; Wed, 18 Oct 2023 06:20:18 +0000 (UTC)
Received: from out-194.mta1.migadu.com (out-194.mta1.migadu.com [IPv6:2001:41d0:203:375::c2])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A49C73A91
	for <netdev@vger.kernel.org>; Tue, 17 Oct 2023 23:19:54 -0700 (PDT)
Message-ID: <469fd0e9-686f-f1dc-cb45-6c50ff126ccf@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1697609989;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FeoZ+SPgNtEZ7Zc/oQhe4BTt9pThFnfiMnxpD7RMk/o=;
	b=vbewnWhGzAenlh7ZF/qonDgffHfRxGVx7yCyUMgkKHKLDDgtC+Ewz+4MQ9BPHKVSHgLVHi
	16TAaAmDxYbgoJYsbMTLKyX8H3b4NWzFcwXcZnO7d0tTs1DeSV6Xy8Y9HbwfbcV3NlQDUn
	ZfGrZF52cwokRkKaBYtgDQ1n9AE/H6s=
Date: Tue, 17 Oct 2023 23:19:39 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v1 bpf-next 00/11] bpf: tcp: Add SYN Cookie
 generation/validation SOCK_OPS hooks.
Content-Language: en-US
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org,
 daniel@iogearbox.net, davem@davemloft.net, dsahern@kernel.org,
 edumazet@google.com, haoluo@google.com, john.fastabend@gmail.com,
 jolsa@kernel.org, kpsingh@kernel.org, kuba@kernel.org, kuni1840@gmail.com,
 mykolal@fb.com, netdev@vger.kernel.org, pabeni@redhat.com, sdf@google.com,
 song@kernel.org, yonghong.song@linux.dev
References: <9666242b-d899-c428-55bd-14f724cc4ffd@linux.dev>
 <20231017164807.19824-1-kuniyu@amazon.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20231017164807.19824-1-kuniyu@amazon.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 10/17/23 9:48 AM, Kuniyuki Iwashima wrote:
> From: Martin KaFai Lau <martin.lau@linux.dev>
> Date: Mon, 16 Oct 2023 22:53:15 -0700
>> On 10/13/23 3:04 PM, Kuniyuki Iwashima wrote:
>>> Under SYN Flood, the TCP stack generates SYN Cookie to remain stateless
>>> After 3WHS, the proxy restores SYN and forwards it and ACK to the backend
>>> server.  Our kernel module works at Netfilter input/output hooks and first
>>> feeds SYN to the TCP stack to initiate 3WHS.  When the module is triggered
>>> for SYN+ACK, it looks up the corresponding request socket and overwrites
>>> tcp_rsk(req)->snt_isn with the proxy's cookie.  Then, the module can
>>> complete 3WHS with the original ACK as is.
>>
>> Does the current kernel module also use the timestamp bits differently?
>> (something like patch 8 and patch 10 trying to do)
> 
> Our SYN Proxy uses TS as is.  The proxy nodes generate a random number
> if TS is in SYN.
> 
> But I thought someone would suggest making TS available so that we can
> mock the default behaviour at least, and it would be more acceptable.
> 
> The selftest uses TS just to strengthen security by validating 32-bits
> hash.  Dropping a part of hash makes collision easier to happen, but
> 24-bits were sufficient for us to reduce SYN flood to the managable
> level at the backend.

While enabling bpf to customize the syncookie (and timestamp), I want to explore 
where can this also be done other than at the tcp layer.

Have you thought about directly sending the SYNACK back at a lower layer like 
tc/xdp after receiving the SYN? There are already bpf_tcp_{gen,check}_syncookie 
helper that allows to do this for the performance reason to absorb synflood. It 
will be natural to extend it to handle the customized syncookie also.

I think it should already be doable to send a SYNACK back with customized 
syncookie (and timestamp) at tc/xdp today.

When ack is received, the prog@tc/xdp can verify the cookie. It will probably 
need some new kfuncs to create the ireq and queue the child socket. The bpf prog 
can change the ireq->{snd_wscale, sack_ok...} if needed. The details of the 
kfuncs need some more thoughts. I think most of the bpf-side infra is ready, 
e.g. acquire/release/ref-tracking...etc.





