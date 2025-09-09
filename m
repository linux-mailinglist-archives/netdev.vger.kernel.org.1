Return-Path: <netdev+bounces-221118-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B5A02B4A592
	for <lists+netdev@lfdr.de>; Tue,  9 Sep 2025 10:39:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5DC391666AA
	for <lists+netdev@lfdr.de>; Tue,  9 Sep 2025 08:39:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDBC12522BA;
	Tue,  9 Sep 2025 08:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YQu4LTBA"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E771A27453
	for <netdev@vger.kernel.org>; Tue,  9 Sep 2025 08:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757407179; cv=none; b=VyC/a79acNxcOWuZc+dMPNB6jVt13hJUoNNeDYtJAG+h82mJcOROGBDQL+3etBRuyXXioUPBr6XE9jstusk0ADnfMWry2f/Xnxc2b+lZR9yIP4qTivdNoNDQeNLJaHZEULpnkmdnVibLmPjHT8sgPqF/bU0DBe1dtZiDmRev2Q8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757407179; c=relaxed/simple;
	bh=vHPLwL5CQU5Z7ksG2yxqsuuGbT1FFTbEvzv+jOPpr/Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=p54mwSDdpjsBodaWKDgDlx2Otu1a4W5ghbdT+gUhHZGQUS3OObaLeVOGTxBHvT2JpsHGMtNQGiCzEl7ZcvKQc3j0txXcxhdJHerbuHX6zazDzF7M/QLzM93zc+mjtVMl3EL29m3kF0qmh3fJUuv3a1l1Hh1Ii3NFIWzprkzBwbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YQu4LTBA; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757407176;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=maLbMap+2LT57yr3xpTTUZY1o3cg9/xDffeybKHOaQ8=;
	b=YQu4LTBAs9I5qBX1fPy6HoLJghufjFgJU8MI4pK+P26u92FHM2EYNxjUXYzgt/I30ZqBP6
	47hxFqtqg/OTd58OJxe44OnOgAJ+NTpwCWKy6ZPH19AtLA1c2//hu2uqHqKpoOOkwjbyg+
	rCrf0gG8ebkwSzwG18q7C5HHPgkDCSM=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-179-GUuC9JnDOki3UqwJV2AYBw-1; Tue, 09 Sep 2025 04:39:35 -0400
X-MC-Unique: GUuC9JnDOki3UqwJV2AYBw-1
X-Mimecast-MFC-AGG-ID: GUuC9JnDOki3UqwJV2AYBw_1757407174
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-45dd9a66cfbso37143355e9.1
        for <netdev@vger.kernel.org>; Tue, 09 Sep 2025 01:39:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757407174; x=1758011974;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=maLbMap+2LT57yr3xpTTUZY1o3cg9/xDffeybKHOaQ8=;
        b=afBw3rnppqvEYv7eu0AV+Qgl0SauNl2U5zUBqT8XNectgFffAaqLaOsT8zhRxF+0S0
         0toyzsNRD9TOevUkos5v3MkGWxsFxZznXkJUN9GSRLtHfhWOTTZ27t1lbdVZUXX4hEYE
         ZyKvXbuhDT5mcXGHhqzIXQMah443r3vm68Py4YkTc6ziWLp8iqWhINclz3/7yrJEyls/
         LEqTr6JZNMCe+xOTydlEsdfNeFRlp6w1fu2PyUig0zS6QOdnqwVGv5HgA8w5SbOr+/aV
         3zR+s7aw2gUWsSCOqOXcnWXNCns5eTDMXOB3bw7JUhV7ZXb7wY0UD0GEr3eyTd7+le7G
         59Cw==
X-Gm-Message-State: AOJu0YxhJjUh5/3MwuE3HUNBxkGX2ikFH/1PhZ4J6tmYQpaCj+SZuN3u
	P/kifG6vMndTEZcDm3QpawFqTrriUfML/F76e6XbX3LMuokhUHeMLZxMLvyZ8hi2i3+stRhYHd1
	PpRvVUstT/oRzMRy0ZrBaveQqds9hkPLqYfD+8PyfQ8JeU7IutcEVAhmPbw==
X-Gm-Gg: ASbGncspWiyqnN/88divXvqCi/8iKB7GN5pcbUtqMvgqfGCKApsiKl3n+B3gOkTFH21
	VxpdguX3AwCEoKqc6dK8YSoLqvSEvwxEk3HEqBAua2otYCukb5lgOKeW6HjJi7PObK/kl+PvA7j
	MgnmmqsxgObPH/IzgXEXOQrzLjmoWO6173lOPxrCaxRhaeUdLt2WhGw3beP8sGfCj6VnUttWTTF
	V/9fapPFdrgtq3+u2p3XD1sKoJe52jgt3DMiQTxG9TwXun8b9RN9HV2qOeHaWtnnaem7DuOW6/v
	KdNHgdB4jniBP0zvevV7UH6VRMqcBXTOB2QOg/GrRtOuSwcqrXOX5H4IFGIiSqMZuRiYr34EWzM
	0LS/9/ZM+OXw=
X-Received: by 2002:a05:600c:3b1a:b0:45b:9291:320d with SMTP id 5b1f17b1804b1-45ddded3454mr106956615e9.31.1757407174297;
        Tue, 09 Sep 2025 01:39:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGKYLjLr4ZoJ0jfoejUOqrxruD9FHV3EcrxDGxf12RFoTaR7PxwRKlFp81591joPR5nP+nJtQ==
X-Received: by 2002:a05:600c:3b1a:b0:45b:9291:320d with SMTP id 5b1f17b1804b1-45ddded3454mr106956235e9.31.1757407173858;
        Tue, 09 Sep 2025 01:39:33 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2712:7e10:4d59:d956:544f:d65c? ([2a0d:3344:2712:7e10:4d59:d956:544f:d65c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45cb61377a7sm274262995e9.13.2025.09.09.01.39.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Sep 2025 01:39:33 -0700 (PDT)
Message-ID: <6516a49f-5d4f-4c3a-8ddc-7d8623aeb816@redhat.com>
Date: Tue, 9 Sep 2025 10:39:32 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 next-next] net/cls_cgroup: Fix task_get_classid()
 during qdisc run
To: Yafang Shao <laoar.shao@gmail.com>, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, horms@kernel.org,
 daniel@iogearbox.net, bigeasy@linutronix.de, tgraf@suug.ch,
 paulmck@kernel.org, razor@blackwall.org
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org
References: <20250902062933.30087-1-laoar.shao@gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250902062933.30087-1-laoar.shao@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/2/25 8:29 AM, Yafang Shao wrote:
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
> Given that dev_queue_xmit() always executes with bh disabled, we can use
> softirq_count() instead to obtain the correct classid.
> 
> The simple steps to reproduce this issue:
> 1. Add network delay to the network interface:
>   such as: tc qdisc add dev bond0 root netem delay 1.5ms
> 2. Build two distinct net_cls cgroups, each with a network-intensive task
> 3. Initiate parallel TCP streams from both tasks to external servers.
> 
> Under this specific condition, the issue reliably occurs. The kernel
> eventually dequeues an SKB that originated from Task-A while executing in
> the context of Task-B.
> 
> It is worth noting that it will change the established behavior for a
> slightly different scenario:
> 
>   <sock S is created by task A>
>   <class ID for task A is changed>
>   <skb is created by sock S xmit and classified>
> 
> prior to this patch the skb will be classified with the 'new' task A
> classid, now with the old/original one. The bpf_get_cgroup_classid_curr()
> function is a more appropriate choice for this case.
> 
> Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> Cc: Daniel Borkmann <daniel@iogearbox.net>
> Cc: Thomas Graf <tgraf@suug.ch>
> Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> Cc: Nikolay Aleksandrov <razor@blackwall.org>

@Daniel: I'm wondering if you have some specific use-case explicit
leveraging the affected helper. If so, could you please test this change
does not break it?

Thanks,

Paolo


