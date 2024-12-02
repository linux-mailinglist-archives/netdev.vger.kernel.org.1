Return-Path: <netdev+bounces-148226-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A5D5A9E0DFD
	for <lists+netdev@lfdr.de>; Mon,  2 Dec 2024 22:38:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6A822281986
	for <lists+netdev@lfdr.de>; Mon,  2 Dec 2024 21:38:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AE551DED6B;
	Mon,  2 Dec 2024 21:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="n6g7sZ4H"
X-Original-To: netdev@vger.kernel.org
Received: from out-170.mta1.migadu.com (out-170.mta1.migadu.com [95.215.58.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4016170800
	for <netdev@vger.kernel.org>; Mon,  2 Dec 2024 21:38:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733175516; cv=none; b=oAEdcPVHAv+roOvoYucK/owtOgdwEVBYItL6Gpy1mauXU4Q8loY5xfuBUznqoLPV4KXKgvFvFaDbLduSD+vSbAwcv3RypnTsqEt0ZnJwxDF28Ld0G4UIJtNAXw/+29XBXSICiZz8kPNJaTEP4G3Ez/N3FIWtnXnonqGx0VLq5Fk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733175516; c=relaxed/simple;
	bh=7xGM2Zv6VPSBGOYslwq6dEwS0xy0nR+0XcW8sM2oLII=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZFpqyXrXNn5onj1+bVgMew+5v8TnmC+dxS60k7wl1ezxTNaK4nK+/pp70UV75FISJQbn7wccLQuBKEsKqZ6Pk5+GlutcqQFllpwyyNTpRLB6XH6Vt90RUP9hfxKnlW/Hqv4sM+YiOmBR5do1XyauG4tO3TNAr9KDereTL6Vi0jc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=n6g7sZ4H; arc=none smtp.client-ip=95.215.58.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <80d8c4cf-2897-4385-b849-2dbac863ee39@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1733175511;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NmXr80EokHOIDy9EV+L8W5kREfs/44BiSNhckzGGbdQ=;
	b=n6g7sZ4HAoxcYG1osI6uKNyWpD1HeG1S633MfEzmIhCjorSSHmOxnp/v+wfHtH3JfSReEh
	Gn9y3qm8M/2O1oS+huWYiDdzdS9i6SQP5CZeaeTSaW+F3mtuM8QPoixx2FaYnPZCoAyZUq
	4in5gIQcmdRm0zpkTdW7/sRAUhy7AfA=
Date: Mon, 2 Dec 2024 13:38:17 -0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf] bpf, test_run: Fix use-after-free issue in
 eth_skb_pkt_type()
To: Stanislav Fomichev <stfomichev@gmail.com>,
 Shigeru Yoshida <syoshida@redhat.com>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 eddyz87@gmail.com, song@kernel.org, yonghong.song@linux.dev,
 john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me,
 haoluo@google.com, jolsa@kernel.org, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 hawk@kernel.org, lorenzo@kernel.org, toke@redhat.com, bpf@vger.kernel.org,
 netdev@vger.kernel.org, syzkaller <syzkaller@googlegroups.com>
References: <20241201152735.106681-1-syoshida@redhat.com>
 <Z03dL0zxEnmzZUN7@mini-arch>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <Z03dL0zxEnmzZUN7@mini-arch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 12/2/24 8:15 AM, Stanislav Fomichev wrote:
> On 12/02, Shigeru Yoshida wrote:
>> KMSAN reported a use-after-free issue in eth_skb_pkt_type()[1]. The
>> cause of the issue was that eth_skb_pkt_type() accessed skb's data
>> that didn't contain an Ethernet header. This occurs when
>> bpf_prog_test_run_xdp() passes an invalid value as the user_data
>> argument to bpf_test_init().
>>
>> Fix this by returning an error when user_data is less than ETH_HLEN in
>> bpf_test_init().
>>
>> [1]
>> BUG: KMSAN: use-after-free in eth_skb_pkt_type include/linux/etherdevice.h:627 [inline]
>> BUG: KMSAN: use-after-free in eth_type_trans+0x4ee/0x980 net/ethernet/eth.c:165
>>   eth_skb_pkt_type include/linux/etherdevice.h:627 [inline]
>>   eth_type_trans+0x4ee/0x980 net/ethernet/eth.c:165
>>   __xdp_build_skb_from_frame+0x5a8/0xa50 net/core/xdp.c:635
>>   xdp_recv_frames net/bpf/test_run.c:272 [inline]
>>   xdp_test_run_batch net/bpf/test_run.c:361 [inline]
>>   bpf_test_run_xdp_live+0x2954/0x3330 net/bpf/test_run.c:390
>>   bpf_prog_test_run_xdp+0x148e/0x1b10 net/bpf/test_run.c:1318
>>   bpf_prog_test_run+0x5b7/0xa30 kernel/bpf/syscall.c:4371
>>   __sys_bpf+0x6a6/0xe20 kernel/bpf/syscall.c:5777
>>   __do_sys_bpf kernel/bpf/syscall.c:5866 [inline]
>>   __se_sys_bpf kernel/bpf/syscall.c:5864 [inline]
>>   __x64_sys_bpf+0xa4/0xf0 kernel/bpf/syscall.c:5864
>>   x64_sys_call+0x2ea0/0x3d90 arch/x86/include/generated/asm/syscalls_64.h:322
>>   do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>>   do_syscall_64+0xd9/0x1d0 arch/x86/entry/common.c:83
>>   entry_SYSCALL_64_after_hwframe+0x77/0x7f
>>
>> Uninit was created at:
>>   free_pages_prepare mm/page_alloc.c:1056 [inline]
>>   free_unref_page+0x156/0x1320 mm/page_alloc.c:2657
>>   __free_pages+0xa3/0x1b0 mm/page_alloc.c:4838
>>   bpf_ringbuf_free kernel/bpf/ringbuf.c:226 [inline]
>>   ringbuf_map_free+0xff/0x1e0 kernel/bpf/ringbuf.c:235
>>   bpf_map_free kernel/bpf/syscall.c:838 [inline]
>>   bpf_map_free_deferred+0x17c/0x310 kernel/bpf/syscall.c:862
>>   process_one_work kernel/workqueue.c:3229 [inline]
>>   process_scheduled_works+0xa2b/0x1b60 kernel/workqueue.c:3310
>>   worker_thread+0xedf/0x1550 kernel/workqueue.c:3391
>>   kthread+0x535/0x6b0 kernel/kthread.c:389
>>   ret_from_fork+0x6e/0x90 arch/x86/kernel/process.c:147
>>   ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
>>
>> CPU: 1 UID: 0 PID: 17276 Comm: syz.1.16450 Not tainted 6.12.0-05490-g9bb88c659673 #8
>> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.3-3.fc41 04/01/2014
>>
>> Fixes: be3d72a2896c ("bpf: move user_size out of bpf_test_init")
>> Reported-by: syzkaller <syzkaller@googlegroups.com>
>> Signed-off-by: Shigeru Yoshida <syoshida@redhat.com>
>> ---
>>   net/bpf/test_run.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/net/bpf/test_run.c b/net/bpf/test_run.c
>> index 501ec4249fed..756250aa890f 100644
>> --- a/net/bpf/test_run.c
>> +++ b/net/bpf/test_run.c
>> @@ -663,7 +663,7 @@ static void *bpf_test_init(const union bpf_attr *kattr, u32 user_size,
>>   	if (size < ETH_HLEN || size > PAGE_SIZE - headroom - tailroom)
>>   		return ERR_PTR(-EINVAL);
>>   
>> -	if (user_size > size)
>> +	if (user_size < ETH_HLEN || user_size > size)
>>   		return ERR_PTR(-EMSGSIZE);
>>   
>>   	size = SKB_DATA_ALIGN(size);
>> -- 
>> 2.47.0
>>
> 
> I wonder whether 'size < ETH_HLEN' above is needed after your patch.
> Feels like 'user_size < ETH_HLEN' supersedes it.

May be fixing it by replacing the existing "size" check with "user_size" check? 
Seems more intuitive that checking is needed on the "user_"size instead of the 
"size". The "if (user_size > size)" check looks useless also. Something like this?

-	if (size < ETH_HLEN || size > PAGE_SIZE - headroom - tailroom)
+	if (user_size < ETH_HLEN || user_size > PAGE_SIZE - headroom - tailroom)
		return ERR_PTR(-EINVAL);

-	if (user_size > size)
-		return ERR_PTR(-EMSGSIZE);
-


