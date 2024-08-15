Return-Path: <netdev+bounces-118800-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EF09952CF8
	for <lists+netdev@lfdr.de>; Thu, 15 Aug 2024 12:55:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B34CB282029
	for <lists+netdev@lfdr.de>; Thu, 15 Aug 2024 10:55:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D008217C7DD;
	Thu, 15 Aug 2024 10:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gJoqfri6"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC7331BBBD8
	for <netdev@vger.kernel.org>; Thu, 15 Aug 2024 10:47:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723718842; cv=none; b=Y5X6Po4zDO4O3+bOPmAKjbxl2jPE+IMi85fuIo8aJRBAbbzNVRErPHHDZtLeDjN3gWUORvckaEzssEUBv60hkvFKE6wrL7i9kZGIeIYJR9IkggIX/w+9tIsavkHTQiR6LnfjFclgwWld7zUef2orYNBC6BiKV8aAdNQPQJMWtqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723718842; c=relaxed/simple;
	bh=QzHcfi8LOqd97JTE9JHH1NlMetIVnOuXVUSnKCYXOpM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CJbqimWJVy9BFVdqwq4kYqSuLNyakMEOLmK5+hFDOpKAyONR0kwsgv+4NfMVzl7CfsCV8gIilFbMiv2l2NJC+BF9t5VC/ahckqFingZGIFXGf8dfluqtx8t6eDMJ9avTnU4cP0SSfuzWRk2wS24lcg/vbd+qMx7CT6id5tPjcDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gJoqfri6; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1723718839;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qnXQQ1raN+JsFqbpBTImQfUk25XnDiwyLfvpcC7PQkk=;
	b=gJoqfri6BxrabRRomGLRiHu28MfRdcPkN6lr81KMG9HzrVKTtLM8U/1mS1sNRLof8NYIMN
	/asU6I6L+LoiL9d09nKrhbcxUFyB69/b3BtYx5sjAXfFQiMcHc7OvgKOgqqI8NGrvqAId6
	AKbpbcV+OuKg+gfEqqfEikL0TiR+y3I=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-277-Nm_3XAj7NtGC3lJ8D_Ub3A-1; Thu, 15 Aug 2024 06:47:18 -0400
X-MC-Unique: Nm_3XAj7NtGC3lJ8D_Ub3A-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4280b24ec7bso1566045e9.3
        for <netdev@vger.kernel.org>; Thu, 15 Aug 2024 03:47:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723718837; x=1724323637;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qnXQQ1raN+JsFqbpBTImQfUk25XnDiwyLfvpcC7PQkk=;
        b=wdxwc/y6Q5KEoqdexYggODPGXSkQtaoEfVXHVfoQmq1B8hmvnjPZoMS/y8HiFW/BG2
         CznPopBvIxOWmgfqn4XA6UBdOUhgVB+tkUHYRxvf8rfarfXtre46PIH8FjOAp6esDnYl
         kf2dyAO3ojPr9+PsgA9o2FXEIjsykytTWJ4MQiTyBnapcn/LGjbPlNt4i8cIZ8xdZ99N
         HO1aX0AfMJXH4vUQ1MprIw5VkKGueYrbNeIp4aiWlG5/nREoUVNp0hfDAw9+/6e6zjGU
         bOTNGylqdV5VQ9rSpRoq58/QVI8X+i6FvklBd0HxBahf8W8xse5Ca8fial000gEslODG
         KjGg==
X-Forwarded-Encrypted: i=1; AJvYcCX0TNlY2J2gdroSVjLgpGbl5Sr/vTEGrarJ12ElyUGR/HnTql7cabc9Bq68ur1nuUkF+e6BVNE5QaQhiWqpDmD7zZYsH76s
X-Gm-Message-State: AOJu0Yyav3OrHm0px3OL8libW8LxAI/7daWLMXQK+pUt0/weEbfPgD3e
	+tiZcK+h5Jn8Ys1ZZazATDoM8Q1q4bm7Hrod0RsJVzDiKFTiZB3LDVPK8+hee1DsnxAHoL6vuQz
	YyFLNWZTp1E8n7SmAjeCIy+uSNf1ykYFBxKlsnTsc5izvVDi3r8xmVg==
X-Received: by 2002:a05:600c:3553:b0:425:6962:4253 with SMTP id 5b1f17b1804b1-429e6a3cb05mr9199935e9.4.1723718837299;
        Thu, 15 Aug 2024 03:47:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH3H1it69WxzMJIoGRE+5pNr1QkCtfpv8h4gWs3VGAUv0zXRyUsiko3D1q1BnehpGQEiyHplA==
X-Received: by 2002:a05:600c:3553:b0:425:6962:4253 with SMTP id 5b1f17b1804b1-429e6a3cb05mr9199775e9.4.1723718836734;
        Thu, 15 Aug 2024 03:47:16 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:1711:4010:5731:dfd4:b2ed:d824? ([2a0d:3344:1711:4010:5731:dfd4:b2ed:d824])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-429ded299a9sm43786145e9.18.2024.08.15.03.47.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Aug 2024 03:47:16 -0700 (PDT)
Message-ID: <170606da-5d5d-40f5-a67c-9c8624a5e913@redhat.com>
Date: Thu, 15 Aug 2024 12:47:14 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] tcp: prevent concurrent execution of
 tcp_sk_exit_batch
To: Florian Westphal <fw@strlen.de>, netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Kuniyuki Iwashima <kuniyu@amazon.com>, Jason Xing
 <kerneljasonxing@gmail.com>,
 syzbot+8ea26396ff85d23a8929@syzkaller.appspotmail.com
References: <20240812200039.69366-1-kuniyu@amazon.com>
 <20240812222857.29837-1-fw@strlen.de>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20240812222857.29837-1-fw@strlen.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/13/24 00:28, Florian Westphal wrote:
> Its possible that two threads call tcp_sk_exit_batch() concurrently,
> once from the cleanup_net workqueue, once from a task that failed to clone
> a new netns.  In the latter case, error unwinding calls the exit handlers
> in reverse order for the 'failed' netns.
> 
> tcp_sk_exit_batch() calls tcp_twsk_purge().
> Problem is that since commit b099ce2602d8 ("net: Batch inet_twsk_purge"),
> this function picks up twsk in any dying netns, not just the one passed
> in via exit_batch list.
> 
> This means that the error unwind of setup_net() can "steal" and destroy
> timewait sockets belonging to the exiting netns.
> 
> This allows the netns exit worker to proceed to call
> 
> WARN_ON_ONCE(!refcount_dec_and_test(&net->ipv4.tcp_death_row.tw_refcount));
> 
> without the expected 1 -> 0 transition, which then splats.
> 
> At same time, error unwind path that is also running inet_twsk_purge()
> will splat as well:
> 
> WARNING: .. at lib/refcount.c:31 refcount_warn_saturate+0x1ed/0x210
> ...
>   refcount_dec include/linux/refcount.h:351 [inline]
>   inet_twsk_kill+0x758/0x9c0 net/ipv4/inet_timewait_sock.c:70
>   inet_twsk_deschedule_put net/ipv4/inet_timewait_sock.c:221
>   inet_twsk_purge+0x725/0x890 net/ipv4/inet_timewait_sock.c:304
>   tcp_sk_exit_batch+0x1c/0x170 net/ipv4/tcp_ipv4.c:3522
>   ops_exit_list+0x128/0x180 net/core/net_namespace.c:178
>   setup_net+0x714/0xb40 net/core/net_namespace.c:375
>   copy_net_ns+0x2f0/0x670 net/core/net_namespace.c:508
>   create_new_namespaces+0x3ea/0xb10 kernel/nsproxy.c:110
> 
> ... because refcount_dec() of tw_refcount unexpectedly dropped to 0.
> 
> This doesn't seem like an actual bug (no tw sockets got lost and I don't
> see a use-after-free) but as erroneous trigger of debug check.
> 
> Add a mutex to force strict ordering: the task that calls tcp_twsk_purge()
> blocks other task from doing final _dec_and_test before mutex-owner has
> removed all tw sockets of dying netns.
> 
> Fixes: e9bd0cca09d1 ("tcp: Don't allocate tcp_death_row outside of struct netns_ipv4.")
> Cc: Kuniyuki Iwashima <kuniyu@amazon.com>
> Cc: Jason Xing <kerneljasonxing@gmail.com>
> Reported-by: syzbot+8ea26396ff85d23a8929@syzkaller.appspotmail.com
> Closes: https://lore.kernel.org/netdev/0000000000003a5292061f5e4e19@google.com/
> Link: https://lore.kernel.org/netdev/20240812140104.GA21559@breakpoint.cc/
> Signed-off-by: Florian Westphal <fw@strlen.de>

The fixes LGTM, but I prefer to keep the patch in PW a little longer to 
allow Eric having a look here.

Cheers,

Paolo


