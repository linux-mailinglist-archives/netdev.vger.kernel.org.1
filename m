Return-Path: <netdev+bounces-149192-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 22D469E4B96
	for <lists+netdev@lfdr.de>; Thu,  5 Dec 2024 02:07:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 852D01881545
	for <lists+netdev@lfdr.de>; Thu,  5 Dec 2024 01:07:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F0B217579;
	Thu,  5 Dec 2024 01:07:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="244h358l"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8E3E653
	for <netdev@vger.kernel.org>; Thu,  5 Dec 2024 01:07:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733360853; cv=none; b=gmeCji4318yd2iC7GL8ik+8OzS8OnPOR0oDHKE/aXDjbTmEa6wHrSyjz9h+cnOOkkLfTIxcJ3G16c4yq1arjUB+ggOhCrFKuAiT63goAVoQXN0bRb8rhfLYKBSeWzb+QrQv6/u+ed9/8LDwb9Xjr6AL7zD/zValFWHDb5eqT3E8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733360853; c=relaxed/simple;
	bh=44S3wRXNoXAqCzNfZtiTsH2EY2nSCU9kDAs2XUxd3uw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AgD1XeXO6fgsap3cjMe/zlFerYVba0coj3SUL+FJsBHPCSVJL/YVddCkkHAJhG8vO8YW2tbaJZaDrOECPRhKm0yrhotPdoKrFtf4rn0NGd2askHSt0nA3+5cZUtoynzXQbnB9grmB7xEMea6upH/yTcXK95cSijLfpTxVpAI1dg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=244h358l; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-7256a7a3d98so371862b3a.3
        for <netdev@vger.kernel.org>; Wed, 04 Dec 2024 17:07:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1733360850; x=1733965650; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JGcbqtZcsejHv5UDXwCTj4h3gbmO1BF+1YEpaZH/U+g=;
        b=244h358lKPqXLDjILTU7yFiivOZzJTY81/+1Ups2uD1/ec1nchNlDe/xAPzKASMiTI
         3CW/8rJT+5INZZ7r7Jighj3BIy7kIzHmhUTd7q1FJl4ndyNytW0+oD7D2TaKPrPT7CWB
         lYiOSWGCGLhcQYhALaJ7P10R/7uSwsEYTsNp6jYxRcNcqxSQwS/bGcQfQoXarN/aRKLV
         ll2T3tDtneqNKDI4u1yzLf00glrXu2ggj4gyH9muSCpsmgpFP5iittBETLpocGjm7YwL
         JdKgel09UKetyrt2WQSip1YakB+KnZlIPMOR1YdH7c3s94wfRGXv8SZONYNARCWt8rZy
         /QCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733360850; x=1733965650;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JGcbqtZcsejHv5UDXwCTj4h3gbmO1BF+1YEpaZH/U+g=;
        b=VLsqxOiaMmvyFMVqr4Rr9YDW7p97soZBPGCYe4XsUiJFTaYLyMlUXQFrMKHl43cMGh
         5s+0GnSKAlLA4jjO/qf2CBqnivAcecDqjwOjUjQMWyqkFxcOrE4jgNBMlK3IVH00KmjT
         ZOj4pWTjmnCxy+a4WpAYsAjpFkhWPQgzoQDKwDJ2MCz05dI2gHmkK7A3yQR4zP/wZNnj
         j/s48uqfBkcG0K9z0XU0sKxRJbKJuj/Cd9eQMecKLEHiAcIShY22RZxU7DuJ33XLgBRL
         ncYR1fAGVGIq1jKTAsC1Of3MFp4inC3T4Czb/icc/Nm+hKp8UNlIzbmMe3Orf8LLNdto
         JSlg==
X-Forwarded-Encrypted: i=1; AJvYcCX0bckmYnrDdiebVsFJEnda63TQNifyMIKd6SqrQHs7uWXC06mEA8aWrOiwiolL2AeZtwIJ/ks=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQ/6GuN6wF99nq992fTsXNf1SDEplUJnhaMeU39rEPr+icuj46
	vMiMp7MM/3LUb62+kAkH6Zy9XxhCHZVCVVsuhuCj0AeFivCu/HZPdWBbbO/IZA==
X-Gm-Gg: ASbGnct3wGKmYMM2wOmn+ujnkEFk9nE0ZXET2MK6lrhE1zJzGOQXQFSHHttFhdloi2J
	hP6v9DfLpc+SvYFB2Z757I1rn+/YUch75EweobbCOhK2COx7+xK0pM7xRkSr+wTjf9TrWkdrIFz
	DCvc+slPT11T33QgAn400mC9H41T25TIJ8liUT/Y9cXDylh/Vk+04j1YU4StDLREgkXxPa++rne
	kT3jmn4jWLW7Jmo5bAH9vhCtMMgxT85Zjg39Mza5OFe+q1STft2dL8xshYPb6MkewgaeJTRPNI4
	pxWnaZeIki9XFDs=
X-Google-Smtp-Source: AGHT+IFeBN9w6unUClocTye/G/o6YOI5kP56oqymL7g2uLZcTikd5W2bgSAtUJH1aseD6PVQuzPbYA==
X-Received: by 2002:a17:902:e888:b0:215:4a31:47e1 with SMTP id d9443c01a7336-215bd169065mr108212605ad.56.1733360850028;
        Wed, 04 Dec 2024 17:07:30 -0800 (PST)
Received: from ?IPV6:2804:7f1:e2c0:ca39:531:412:f6dc:3817? ([2804:7f1:e2c0:ca39:531:412:f6dc:3817])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-725a29c5af9sm121761b3a.19.2024.12.04.17.07.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Dec 2024 17:07:29 -0800 (PST)
Message-ID: <a6e773ba-5f93-4f8f-891a-a1ec606f7a8d@mojatatu.com>
Date: Wed, 4 Dec 2024 22:07:25 -0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 net-next] net_sched: sch_fq: add three drop_reason
To: Eric Dumazet <edumazet@google.com>, "David S . Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>
Cc: Jamal Hadi Salim <jhs@mojatatu.com>, Cong Wang
 <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>,
 netdev@vger.kernel.org, eric.dumazet@gmail.com
References: <20241204171950.89829-1-edumazet@google.com>
Content-Language: en-US
From: Victor Nogueira <victor@mojatatu.com>
In-Reply-To: <20241204171950.89829-1-edumazet@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 04/12/2024 14:19, Eric Dumazet wrote:
> Add three new drop_reason, more precise than generic QDISC_DROP:
> 
> "tc -s qd" show aggregate counters, it might be more useful
> to use drop_reason infrastructure for bug hunting.
> 
> 1) SKB_DROP_REASON_FQ_BAND_LIMIT
>     Whenever a packet is added while its band limit is hit.
>     Corresponding value in "tc -s qd" is bandX_drops XXXX
> 
> 2) SKB_DROP_REASON_FQ_HORIZON_LIMIT
>     Whenever a packet has a timestamp too far in the future.
>     Corresponding value in "tc -s qd" is horizon_drops XXXX
> 
> 3) SKB_DROP_REASON_FQ_FLOW_LIMIT
>     Whenever a flow has reached its limit.
>     Corresponding value in "tc -s qd" is flows_plimit XXXX
> 
> Tested:
> tc qd replace dev eth1 root fq flow_limit 10 limit 100000
> perf record -a -e skb:kfree_skb sleep 1; perf script
> 
>        udp_stream   12329 [004]   216.929492: skb:kfree_skb: skbaddr=0xffff888eabe17e00 rx_sk=(nil) protocol=34525 location=__dev_queue_xmit+0x9d9 reason: FQ_FLOW_LIMIT
>        udp_stream   12385 [006]   216.929593: skb:kfree_skb: skbaddr=0xffff888ef8827f00 rx_sk=(nil) protocol=34525 location=__dev_queue_xmit+0x9d9 reason: FQ_FLOW_LIMIT
>        udp_stream   12389 [005]   216.929871: skb:kfree_skb: skbaddr=0xffff888ecb9ba500 rx_sk=(nil) protocol=34525 location=__dev_queue_xmit+0x9d9 reason: FQ_FLOW_LIMIT
>        udp_stream   12316 [009]   216.930398: skb:kfree_skb: skbaddr=0xffff888eca286b00 rx_sk=(nil) protocol=34525 location=__dev_queue_xmit+0x9d9 reason: FQ_FLOW_LIMIT
>        udp_stream   12400 [008]   216.930490: skb:kfree_skb: skbaddr=0xffff888eabf93d00 rx_sk=(nil) protocol=34525 location=__dev_queue_xmit+0x9d9 reason: FQ_FLOW_LIMIT
> 
> tc qd replace dev eth1 root fq flow_limit 100 limit 10000
> perf record -a -e skb:kfree_skb sleep 1; perf script
> 
>        udp_stream   18074 [001]  1058.318040: skb:kfree_skb: skbaddr=0xffffa23c881fc000 rx_sk=(nil) protocol=34525 location=__dev_queue_xmit+0x9d9 reason: FQ_BAND_LIMIT
>        udp_stream   18126 [005]  1058.320651: skb:kfree_skb: skbaddr=0xffffa23c6aad4000 rx_sk=(nil) protocol=34525 location=__dev_queue_xmit+0x9d9 reason: FQ_BAND_LIMIT
>        udp_stream   18118 [006]  1058.321065: skb:kfree_skb: skbaddr=0xffffa23df0d48a00 rx_sk=(nil) protocol=34525 location=__dev_queue_xmit+0x9d9 reason: FQ_BAND_LIMIT
>        udp_stream   18074 [001]  1058.321126: skb:kfree_skb: skbaddr=0xffffa23c881ffa00 rx_sk=(nil) protocol=34525 location=__dev_queue_xmit+0x9d9 reason: FQ_BAND_LIMIT
>        udp_stream   15815 [003]  1058.321224: skb:kfree_skb: skbaddr=0xffffa23c9835db00 rx_sk=(nil) protocol=34525 location=__dev_queue_xmit+0x9d9 reason: FQ_BAND_LIMIT
> 
> tc -s -d qd sh dev eth1
> qdisc fq 8023: root refcnt 257 limit 10000p flow_limit 100p buckets 1024 orphan_mask 1023
>   bands 3 priomap 1 2 2 2 1 2 0 0 1 1 1 1 1 1 1 1 weights 589824 196608 65536 quantum 18Kb
>   initial_quantum 92120b low_rate_threshold 550Kbit refill_delay 40ms
>   timer_slack 10us horizon 10s horizon_drop
>   Sent 492439603330 bytes 336953991 pkt (dropped 61724094, overlimits 0 requeues 4463)
>   backlog 14611228b 9995p requeues 4463
>    flows 2965 (inactive 1151 throttled 0) band0_pkts 0 band1_pkts 9993 band2_pkts 0
>    gc 6347 highprio 0 fastpath 30 throttled 5 latency 2.32us flows_plimit 7403693
>   band1_drops 54320401
> 
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Reviewed-by: Victor Nogueira <victor@mojatatu.com>

