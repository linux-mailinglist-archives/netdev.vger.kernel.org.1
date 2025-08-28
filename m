Return-Path: <netdev+bounces-217637-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D1D38B39607
	for <lists+netdev@lfdr.de>; Thu, 28 Aug 2025 09:55:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 22E71365751
	for <lists+netdev@lfdr.de>; Thu, 28 Aug 2025 07:55:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54CA62D7394;
	Thu, 28 Aug 2025 07:55:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TYhqFu3Q"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B112279DC9
	for <netdev@vger.kernel.org>; Thu, 28 Aug 2025 07:55:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756367744; cv=none; b=hclXKyeiGUtHb93A2GnYskfLQ5xjT5LtBHVEXXO4OQVXP0dbv4JLkMSLjZtsKH5DOJTH9Qt9nusiJB5+BDMk82oI57YAgVDFfJgcDFzBFRm2B6Yteq/bg3FqdD726JqPPnLgpzO95Zzdlvu5L0KnBHuAaPpUcUHzzInc2uJQri0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756367744; c=relaxed/simple;
	bh=Pzrdy410GYFzoQ88f4luzAXVOOYmLHKQjra0s06wRzo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CfFfvbdi425u+htdYWiPSMmftMxBXNWuytq+RTEVKwinwa6XvJZmqVMzbR1E8F1LbjYhAb1Q1QfHR7rizV1BzQJm0BGG20JY739uIlSZ0VG3Qbq1Jo2wv+4mh/tIC1rAA4U7n+1IT+IVmv65+KvwBsSykj/tETnP8W/kQEQtIkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TYhqFu3Q; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756367741;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1fkcSVdA9XBsCs2P62KbDoUXMcDrW2XFQyZkew4B5Qo=;
	b=TYhqFu3QsBkD0Bd3jRmJJFdBayRZJvxO9HHof54C9L3/HIIYgtg9y2cNDVrq3D0TBdlMjR
	975AKTXsYHM0o5ds6QmWwUaQ/82aThpey5yf15i3o/2lcc5TmxY//vp61ILIAefQ/0WfYH
	ryvRUPJFMZCy0pHkauh2seh+OzL32cA=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-265-LVq47Y8kMYmF9lrzuiieOQ-1; Thu, 28 Aug 2025 03:55:38 -0400
X-MC-Unique: LVq47Y8kMYmF9lrzuiieOQ-1
X-Mimecast-MFC-AGG-ID: LVq47Y8kMYmF9lrzuiieOQ_1756367738
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-70d9a65c170so15182846d6.2
        for <netdev@vger.kernel.org>; Thu, 28 Aug 2025 00:55:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756367738; x=1756972538;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1fkcSVdA9XBsCs2P62KbDoUXMcDrW2XFQyZkew4B5Qo=;
        b=u6OtRFeEWk4GYbO5g7u4YjsYfRU7FQnQqfZoEvpJRQ35CuH8IBF06V4pQkLZhz+VSk
         8J43QsxLDHu1O+0w1mOPe2lkxPxzSf5Jo7joMoF4Olvdfotv/LBHr965e5v4AYXWksrQ
         Yw61ETUzKQgMN0cqWygyOOM/4VQgvgx6bvdDjQnTp1TbuOBddJLsQ2r1PJXCLoKG8AYf
         Rsms9BgEoMfo/2xZE9mqZcvKf9Lao+eOFKOgKPzcWFE9eR3IhthD4Cwy+KrjeB9CHi7H
         QT3VbKuo++hf59QnROQlI7UXpjjSNSTgePxedBN5qsegF1hPxeLz8vqUgNEj8Bpl7Fu0
         PUHw==
X-Gm-Message-State: AOJu0YydS86uHF4r+n7ZrvrghRjrDCz3/upGFCq0d1qN29bd9YGUIwwc
	uSYK7qte8wi0W+f3scPCa2SnJ9YzvsS1lgdbz37Vw+CptBR/M0XQE3/WRB4LO/vkRdGblWMmg5c
	wsHdwsBGvATaYHNs8s7colnbzTp5BZYaMXBWkCJczEiUB+StrqBXEr/XHlg==
X-Gm-Gg: ASbGnctLn32rtGXa+zBGBMyzUEFOTbRxvLQUn0ROifFbpZvIpbN0Y4uSkd9+b0dmTng
	/VU5MfNtGBdofkiGsgLyLy4NgVVQ3xZJG5Rzhcy7aPHIDXvdcXdLUawCMUF22smHvp+cyOtvmq5
	sSnnuVhzE1Eo//kS5c8nIH6hjiS1Twf5u8JfLdYlayeQfe958TI2AwCE06IGtQh6Sw76CvLOKDK
	plUlqH17uRWcxlfvbKLknODLTBec6oFzIAHUWR7mAlp61lYTi6RtXOzH96fCpJM25rXgZMzTCHT
	M9yBqSSKiBT65wyEHZFnw4hsMVZRQpWUGE0ohHbQmWpJsu+87ot7KudLwUmlWIpRzC2fb5PmjXL
	J89icxbywhSA=
X-Received: by 2002:a05:6214:ac5:b0:70d:e9af:95ae with SMTP id 6a1803df08f44-70de9af9974mr50182396d6.31.1756367738328;
        Thu, 28 Aug 2025 00:55:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEfKy5hXx/jY25tTPr/gyo7+HDQNAY7R5HQK9VLODuVgUt09GXhGiw1DqeyVmS8ZmvuipbSnQ==
X-Received: by 2002:a05:6214:ac5:b0:70d:e9af:95ae with SMTP id 6a1803df08f44-70de9af9974mr50182196d6.31.1756367737922;
        Thu, 28 Aug 2025 00:55:37 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2712:7e10:4d59:d956:544f:d65c? ([2a0d:3344:2712:7e10:4d59:d956:544f:d65c])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-70da6f96ca7sm100941916d6.0.2025.08.28.00.55.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Aug 2025 00:55:37 -0700 (PDT)
Message-ID: <1d3ba6ba-5c1e-4d3f-980a-8ad75101f04d@redhat.com>
Date: Thu, 28 Aug 2025 09:55:34 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] net/cls_cgroup: Fix task_get_classid() during qdisc
 run
To: Yafang Shao <laoar.shao@gmail.com>, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, horms@kernel.org,
 daniel@iogearbox.net, bigeasy@linutronix.de, tgraf@suug.ch,
 paulmck@kernel.org
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org
References: <20250822064200.38149-1-laoar.shao@gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250822064200.38149-1-laoar.shao@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/22/25 8:42 AM, Yafang Shao wrote:
> During recent testing with the netem qdisc to inject delays into TCP
> traffic, we observed that our CLS BPF program failed to function correctly
> due to incorrect classid retrieval from task_get_classid(). The issue
> manifests in the following call stack:
> 
>         bpf_get_cgroup_classid+5
>         cls_bpf_classify+507
>         __tcf_classify+90
>         tcf_classify+217
>         __dev_queue_xmit+798
>         bond_dev_queue_xmit+43
>         __bond_start_xmit+211
>         bond_start_xmit+70
>         dev_hard_start_xmit+142
>         sch_direct_xmit+161
>         __qdisc_run+102             <<<<< Issue location
>         __dev_xmit_skb+1015
>         __dev_queue_xmit+637
>         neigh_hh_output+159
>         ip_finish_output2+461
>         __ip_finish_output+183
>         ip_finish_output+41
>         ip_output+120
>         ip_local_out+94
>         __ip_queue_xmit+394
>         ip_queue_xmit+21
>         __tcp_transmit_skb+2169
>         tcp_write_xmit+959
>         __tcp_push_pending_frames+55
>         tcp_push+264
>         tcp_sendmsg_locked+661
>         tcp_sendmsg+45
>         inet_sendmsg+67
>         sock_sendmsg+98
>         sock_write_iter+147
>         vfs_write+786
>         ksys_write+181
>         __x64_sys_write+25
>         do_syscall_64+56
>         entry_SYSCALL_64_after_hwframe+100
> 
> The problem occurs when multiple tasks share a single qdisc. In such cases,
> __qdisc_run() may transmit skbs created by different tasks. Consequently,
> task_get_classid() retrieves an incorrect classid since it references the
> current task's context rather than the skb's originating task.
> 
> Given that dev_queue_xmit() always executes with bh disabled, we can safely
> use in_softirq() instead of in_serving_softirq() to properly identify the
> softirq context and obtain the correct classid.
> 
> The simple steps to reproduce this issue:
> 1. Add network delay to the network interface:
>   such as: tc qdisc add dev bond0 root netem delay 1.5ms
> 2. Create two distinct net_cls cgroups, each running a network-intensive task
> 3. Initiate parallel TCP streams from both tasks to external servers.
> 
> Under this specific condition, the issue reliably occurs. The kernel
> eventually dequeues an SKB that originated from Task-A while executing in
> the context of Task-B.
> 
> Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> Cc: Daniel Borkmann <daniel@iogearbox.net>
> Cc: Thomas Graf <tgraf@suug.ch>
> Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> 
> ---
> 
> v1->v2: use softirq_count() instead of in_softirq()
> ---
>  include/net/cls_cgroup.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/net/cls_cgroup.h b/include/net/cls_cgroup.h
> index 7e78e7d6f015..668aeee9b3f6 100644
> --- a/include/net/cls_cgroup.h
> +++ b/include/net/cls_cgroup.h
> @@ -63,7 +63,7 @@ static inline u32 task_get_classid(const struct sk_buff *skb)
>  	 * calls by looking at the number of nested bh disable calls because
>  	 * softirqs always disables bh.
>  	 */
> -	if (in_serving_softirq()) {
> +	if (softirq_count()) {
>  		struct sock *sk = skb_to_full_sk(skb);
>  
>  		/* If there is an sock_cgroup_classid we'll use that. */

AFAICS the above changes the established behavior for a slightly
different scenario:

<sock S is created by task A>
<class ID for task A is changed>
<skb is created by sock S xmit and classified>

prior to this patch the skb will be classified with the 'new' task A
classid, now with the old/original one.

I'm unsure if such behavior change is acceptable; I think at very least
it should be mentioned in the changelog and likely this change should
target net-next.

Thanks,

Paolo


