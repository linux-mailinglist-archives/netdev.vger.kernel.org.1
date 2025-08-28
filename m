Return-Path: <netdev+bounces-217801-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 13455B39DC2
	for <lists+netdev@lfdr.de>; Thu, 28 Aug 2025 14:51:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E224C1C806E8
	for <lists+netdev@lfdr.de>; Thu, 28 Aug 2025 12:51:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D45830FF29;
	Thu, 28 Aug 2025 12:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XdDltIxq"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3536310764
	for <netdev@vger.kernel.org>; Thu, 28 Aug 2025 12:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756385425; cv=none; b=shPCdxZWgocue+0IDZaJo7maZIUJ51zZfSi7TgNr0mZnB/kZzk9zLwYWWiHn0Vlv2hY8od90N71mNyosCn10/jqZTDXr1nDHPElOamUHy/lj0IuvVJsEwTZTAlC/REsuELnEWq+S2Qnnudfarc82ZvJ8x22ixZ+kGwDC0AYoT/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756385425; c=relaxed/simple;
	bh=oOLxnqByeHLGynb0qIrv1/y8kp5OBHBetYzwB6zRISo=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=FIFSwAikTqi02okDFaIQQwMI/COCf5ydqdLzbimxAgKEL/NC4FQLNv4WfdZBwE/nlPjq/nPn6Eso+jfRBtxW5D8GSOF+zskWNv8IOw5dkRzZqRd6GiXG1OypncnEZEeUHF+OIGoZKNXPPOIa2XfDekUcPw4qB+mpbLUBAdHDOQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XdDltIxq; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756385422;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/cq+dTEoq0hF3gvtYBJcHUqzoT6fABIHgTMMFlfotEM=;
	b=XdDltIxq8g+8wenfWGqrYy82IcPYW5fIghr9u1CTWsVERXdLN9Nn7w7KmRdRnK9xQQqWcX
	BJJ7+b1QG4epNfbjWkxLfkWTN9yl7W8PUcTC14oue97M8vsrRbdjvDuj6tG5mrCfVQ9tsq
	iZlmSYGGP8Fu9lnUjm6cT+2WYbGFXD4=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-140-70ewkJLSPs2b25XIsEak1w-1; Thu, 28 Aug 2025 08:50:20 -0400
X-MC-Unique: 70ewkJLSPs2b25XIsEak1w-1
X-Mimecast-MFC-AGG-ID: 70ewkJLSPs2b25XIsEak1w_1756385418
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-45a1b05a59cso6139445e9.1
        for <netdev@vger.kernel.org>; Thu, 28 Aug 2025 05:50:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756385418; x=1756990218;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/cq+dTEoq0hF3gvtYBJcHUqzoT6fABIHgTMMFlfotEM=;
        b=Hub/ujXDq4OHfk5y+iO3FF8mjBqJ91bzW2kqcdcdYGXX3NMuC6sKhtbYT39kdPZcpM
         2qOyYXTLFhfCmq6PR4nriZKEEfjWHJumL4TypmpGQojV/jhgS+8uzxeRjvPom2x9JxBM
         YLdhX2HZ0w49PCocw9VCsnbRJys1zYwj2UI6kInPcspVd9sqi/BgtT4x8jxlf2w8Glnk
         CXFP8ExtYblb6INVooJx3Ir2ZjFIYzApmg9M7buaovkehdc6GOlvdSjmxwDbyBGsVrgF
         WETEM/vkhMjfhFSEk0Kl4SaKmb0VSjmFW6Z0EDkSv50yjprS5kAdqpT+MBpBm32cwXgD
         zG5Q==
X-Forwarded-Encrypted: i=1; AJvYcCVwE7hlW9jaqRu7sngfe7I+nDhVgH51hMTMjcCfTwDv0DB5/u/iJAAZvrJzOpWookHRG92x0eA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxN8VLXZNKQwM2samXdAU9gHvbXNHHyVfidmQ/JyYKDBB0L5Vcj
	IiWBD4aZJUSyqIf+GzjaSPRfLdZp14bmgubdSI7MHJQxX3b4NSpAIY8HUFE/H5RkTlIs5TMLK9u
	VTQGYVv0pL906TP8wGYTox6OJJH6Yw1EsvfRJs0vvLeD77L/hPWXifYRt4g==
X-Gm-Gg: ASbGncu3LMFN6gxcei9UBuwNDm6OnU/BX0K2tu7kPTQvNOvSLLhmk77AMiEmQKGd9Ro
	ER2xBtZ/6WMndiCQnLGApE9uzoV+9/CbI49jxpyGfxfLo9v25YQiFGdtBqAhgyqlqHlZaJngOuq
	GuRQM4ugUbgcb21oCUnuzgK7FodIU20O5XB0oDeCM7hiRHK10kMvMyldvGbBHKMYUcg2/Q98b1H
	dGiX3j6KPAVQhwmduUz5tKDbVgJIIeqZVlVgobT2Qo8G38Q59lYsnRQxf80uQ5jggEGxtXeC2jE
	JT6iMiqQhWvOjP/bdVuu/O2nt/NF9Y4j4OhZSdu9rGeDDQgL0dR5xQPT1r3RJbm7BoEJk7K60fp
	KeVCMhEHfyPk=
X-Received: by 2002:a05:600c:4715:b0:458:aed1:f82c with SMTP id 5b1f17b1804b1-45b517d3b30mr169319545e9.22.1756385418144;
        Thu, 28 Aug 2025 05:50:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEM/JUymBQPAfnXcsRD1lMrhM0TDAxYbWfM1UjIxY39/QQDk5stVfqmn2/vA/wDC3JFBEn8Nw==
X-Received: by 2002:a05:600c:4715:b0:458:aed1:f82c with SMTP id 5b1f17b1804b1-45b517d3b30mr169319245e9.22.1756385417652;
        Thu, 28 Aug 2025 05:50:17 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2712:7e10:4d59:d956:544f:d65c? ([2a0d:3344:2712:7e10:4d59:d956:544f:d65c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b7a940523sm12053635e9.11.2025.08.28.05.50.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Aug 2025 05:50:17 -0700 (PDT)
Message-ID: <2861b6ca-4b65-4500-addf-ca13b415a56f@redhat.com>
Date: Thu, 28 Aug 2025 14:50:15 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [net-next PATCH 0/4] fbnic: Synchronize address handling with BMC
From: Paolo Abeni <pabeni@redhat.com>
To: Alexander Duyck <alexander.duyck@gmail.com>, netdev@vger.kernel.org
Cc: kuba@kernel.org, kernel-team@meta.com, andrew+netdev@lunn.ch,
 davem@davemloft.net
References: <175623715978.2246365.7798520806218461199.stgit@ahduyck-xeon-server.home.arpa>
 <bc846535-a5f5-4e24-9325-22f9d8b887f9@redhat.com>
Content-Language: en-US
In-Reply-To: <bc846535-a5f5-4e24-9325-22f9d8b887f9@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/28/25 12:46 PM, Paolo Abeni wrote:
> On 8/26/25 9:44 PM, Alexander Duyck wrote:
>> The fbnic driver needs to communicate with the BMC if it is operating on
>> the RMII-based transport (RBT) of the same port the host is on. To enable
>> this we need to add rules that will route BMC traffic to the RBT/BMC and
>> the BMC and firmware need to configure rules on the RBT side of the
>> interface to route traffic from the BMC to the host instead of the MAC.
>>
>> To enable that this patch set addresses two issues. First it will cause the
>> TCAM to be reconfigured in the event that the BMC was not previously
>> present when the driver was loaded, but the FW sends a notification that
>> the FW capabilities have changed and a BMC w/ various MAC addresses is now
>> present. Second it adds support for sending a message to the firmware so
>> that if the host adds additional MAC addresses the FW can be made aware and
>> route traffic for those addresses from the RBT to the host instead of the
>> MAC.
> 
> The CI is observing a few possible leaks on top of this series:
> 
> unreferenced object 0xffff888011146040 (size 216):
>   comm "napi/enp1s0-0", pid 4116, jiffies 4295559830
>   hex dump (first 32 bytes):
>     c0 bc a0 08 80 88 ff ff 00 00 00 00 00 00 00 00  ................
>     00 40 02 08 80 88 ff ff 00 00 00 00 00 00 00 00  .@..............
>   backtrace (crc d10d3409):
>     kmem_cache_alloc_bulk_noprof+0x115/0x160
>     napi_skb_cache_get+0x423/0x750
>     napi_build_skb+0x19/0x210
>     xdp_build_skb_from_buff+0xda/0x820
>     fbnic_run_xdp+0x36c/0x550
>     fbnic_clean_rcq+0x540/0x1790
>     fbnic_poll+0x142/0x290
>     __napi_poll.constprop.0+0x9f/0x460
>     napi_threaded_poll_loop+0x44d/0x610
>     napi_threaded_poll+0x17/0x30
>     kthread+0x37b/0x5f0
>     ret_from_fork+0x240/0x320
>     ret_from_fork_asm+0x11/0x20
> unreferenced object 0xffff888008a0bcc0 (size 216):
>   comm "napi/enp1s0-0", pid 4116, jiffies 4295560865
>   hex dump (first 32 bytes):
>     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>     00 40 02 08 80 88 ff ff 00 00 00 00 00 00 00 00  .@..............
>   backtrace (crc d69e2bd9):
>     kmem_cache_alloc_node_noprof+0x289/0x330
>     __alloc_skb+0x20f/0x2e0
>     __tcp_send_ack.part.0+0x68/0x6b0
>     tcp_rcv_established+0x69c/0x2340
>     tcp_v6_do_rcv+0x9b4/0x1370
>     tcp_v6_rcv+0x1bc5/0x2f90
>     ip6_protocol_deliver_rcu+0x112/0x1140
>     ip6_input+0x201/0x5e0
>     ip6_sublist_rcv_finish+0x91/0x260
>     ip6_list_rcv_finish.constprop.0+0x55b/0xa10
>     ipv6_list_rcv+0x318/0x4b0
>     __netif_receive_skb_list_core+0x4c6/0x980
>     netif_receive_skb_list_internal+0x63c/0xe50
>     gro_complete.constprop.0+0x54d/0x750
>     __gro_flush+0x14a/0x490
>     __napi_poll.constprop.0+0x319/0x460
> 
> But AFAICS they don't look related to the changes in this series, 

I went over the series with more attention, I'm reasonably sure the leak
are unrelated. Possibly is kmemleak fouled by some unfortunate timing?

In any case I'm applying this series now.

/P


