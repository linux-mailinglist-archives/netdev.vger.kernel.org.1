Return-Path: <netdev+bounces-245835-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E43D6CD8D57
	for <lists+netdev@lfdr.de>; Tue, 23 Dec 2025 11:37:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1519A301F8D4
	for <lists+netdev@lfdr.de>; Tue, 23 Dec 2025 10:34:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FA8134EF19;
	Tue, 23 Dec 2025 10:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CykowpEr";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="MOtaVYCq"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9276915746F
	for <netdev@vger.kernel.org>; Tue, 23 Dec 2025 10:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766486096; cv=none; b=o2kMzW9enDHcHjfEl50SC6aT2SQDvGq+9redH7+nJdJfqcY+9CNp5AWRfypQmvMIcm9xJX9GrIbmjORAvOVeZE35vyZ31QW5DjHE1d4qXmqxChgUQkAvgfjeAjHGR0bp8xT3v0UWM0zYVYPk65/MZ481Hb9j+hxqc0/ZNJBxhW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766486096; c=relaxed/simple;
	bh=0zm4G+1GdLQfD2IBCPH9R96LHqfSKrACONu8xhMMGi4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qQoA3eTx3s/armsfygbwXd9xhewTt8ze7L5qoMRJqgHwfuUG7j5hOQ7vfBQhCdXLhOLO9DDV17rekTLVfCyooqtdU/7WhszUGazlm4tZSwmXEVNFnQDqZ2Dk0sDpzjofRRPWkVUCoL1fRq1ZXlLbhZKW/NF/GF/QgqX3bpM7AsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CykowpEr; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=MOtaVYCq; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1766486091;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Sgf79+KA5/2HyLhaa050yjAFUTyo5/Zu334BYj4E1Ho=;
	b=CykowpErWPHPpOvHxJ5hS3vPbRJShR4GG/3mHtMk3S80R6yLTxksbuW1xdU4alI9vGNnjL
	M7nDubDFPYaG660jCzAyoDsUKikYccrkr+gx7nbIFN2yb+0LSOniRR/2zAL5agm3+PmXEh
	+rxvA73QIewW5zBbdKyvTADYXdzmdDc=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-571-GK1fPjaBN3eD5pLO7X9Veg-1; Tue, 23 Dec 2025 05:34:50 -0500
X-MC-Unique: GK1fPjaBN3eD5pLO7X9Veg-1
X-Mimecast-MFC-AGG-ID: GK1fPjaBN3eD5pLO7X9Veg_1766486089
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-477b8a667bcso69895475e9.2
        for <netdev@vger.kernel.org>; Tue, 23 Dec 2025 02:34:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1766486089; x=1767090889; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Sgf79+KA5/2HyLhaa050yjAFUTyo5/Zu334BYj4E1Ho=;
        b=MOtaVYCqj6M8FvTyHrCuI0JrlHRfviuRKhlwlPXw9ESAFxzTTw9KKpr8WPQ0NBYbqP
         bh/0k7UxWseISpowIOnAO4bBK6CBbIMKax8OueRx5YL3dSSxrXFwKxASfB3yACii3KQu
         eu6ik5mjNDIRdbyFHXyqK+fLUcB8oD916MBhynKF8qt0eWJCFO4nIKr4zzXz0s0+jCuE
         T8DN4oKl014VFEcbkIDRY7a1+17ZE9qE8znis6wnYkEz7Lmfu/7jfsHHqUomD0iOlpcR
         ldy1kMlzgfWW7sUkUsrA+SFyhK3qeYJOvAj21Ufn4J+NV6MPL/Vml0bXkydPEtrP73Bz
         dw+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766486089; x=1767090889;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Sgf79+KA5/2HyLhaa050yjAFUTyo5/Zu334BYj4E1Ho=;
        b=rMW3DvT6oo3hBmRUmYVZpOquagz0UoKxsBoAvhc1NdT9VDKyAWFZGs/tOqyuAx8NX/
         A9iNRIeWw2JoAB96EyoPRaWImyT6OU06bTpqnag6eOmXeEeQcmO2UkOUvDinenqzSRfX
         i191W9LIhXlUA1psWnCdQeFKztd9x0hCCQBG9C68UpTBEtaNd9H7X6U2qhL1+cz1ICI2
         uMG9y84bYu9mHuiBU4TaV/DM44C2WOc5PLf8xZyUleiKvPifZMXU/25mC2BSGc2bTHXs
         VxAsr6zvI1D9RsjqAeOaNyFo0XA1Gsp5Xm27MbbCyDBg5a++Qb6s541ZtK9T2bvbJv07
         2v4Q==
X-Forwarded-Encrypted: i=1; AJvYcCUYsTD3di4M3aQQ6EELQLsb4d51aGmHSNzNVSbt5bVGdVNXrOa2NRZsSG1Z0IPG6Pyc3XnDFvo=@vger.kernel.org
X-Gm-Message-State: AOJu0YweDwpw/usCs7RqeZWEvP/XzLjp33LjEv1c1QfcnSePsdnLUEjR
	NJEDn5oTJM+CnEEvKEfuVvg0TQ6eaGV1WtLqJyIvSKlm0MiqHUW8ssxJbg9p6HZPGC2x1rm4iH/
	T9j6e6Dt9JjAXOLhL0Z0vt5dJkFx4VdoOrxajaLavQ08PaJ1LCPmRJ8ZLPg==
X-Gm-Gg: AY/fxX4ERnvMhY9IPwiIWCEwRK82oGG6RIIjljJLsMbIceyZW7flRpzc1AqS5fsWaO5
	foPlB9+dg1wrGlqddSa+omRDnfEGjFJwgJ1T3mRWl5F0n5MyK1YiZaYFNNwJXT0xVBoe5zRr3wj
	slzJo/OjeYNjLKDq44UV+FbrrCS3YSIDxGmcz3aRfbClTaxWg9JgfCHYFPnqc8h6YLdgkFN/mvN
	yWh/2MmIMtvsBDWQP5Dhrz7tFFQfGjHZlxByisQ/iIK9Sf934q6UA0Ditwj5bwcGHzPjCNyZ6Wn
	sruPObL9yZ6Up7r6JtY74cxUwaLzPrT/JS6YATdC97dNrFj/fjufIk//SV/MPcUKHuJhSirREK1
	XI6sFUqMoihB3
X-Received: by 2002:a05:600c:8183:b0:477:fad:acd9 with SMTP id 5b1f17b1804b1-47d195a9834mr132598335e9.34.1766486089098;
        Tue, 23 Dec 2025 02:34:49 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHQO73a0x9t6KKSfapJWQvRs4ZyOmiT8am/1/TPeJf60pXNmr/0bKvhgo/ckE+RBk8muTVH4A==
X-Received: by 2002:a05:600c:8183:b0:477:fad:acd9 with SMTP id 5b1f17b1804b1-47d195a9834mr132598075e9.34.1766486088653;
        Tue, 23 Dec 2025 02:34:48 -0800 (PST)
Received: from [192.168.88.32] ([216.128.11.164])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47be273e4d5sm293724455e9.6.2025.12.23.02.34.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Dec 2025 02:34:48 -0800 (PST)
Message-ID: <d7ea6222-607f-433e-a70d-b3632a80b4b9@redhat.com>
Date: Tue, 23 Dec 2025 11:34:46 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v4] net: skbuff: add usercopy region to
 skbuff_fclone_cache
To: bestswngs@gmail.com, security@kernel.org
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 horms@kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 xmei5@asu.edu
References: <20251216084449.973244-5-bestswngs@gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20251216084449.973244-5-bestswngs@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/16/25 9:44 AM, bestswngs@gmail.com wrote:
> From: Weiming Shi <bestswngs@gmail.com>
> 
> skbuff_fclone_cache was created without defining a usercopy region, [1]
> unlike skbuff_head_cache which properly whitelists the cb[] field.  [2]
> This causes a usercopy BUG() when CONFIG_HARDENED_USERCOPY is enabled
> and the kernel attempts to copy sk_buff.cb data to userspace via
> sock_recv_errqueue() -> put_cmsg().
> 
> The crash occurs when:
> 1. TCP allocates an skb using alloc_skb_fclone()
>    (from skbuff_fclone_cache) [1]
> 2. The skb is cloned via skb_clone() using the pre-allocated fclone [3]
> 3. The cloned skb is queued to sk_error_queue for timestamp reporting
> 4. Userspace reads the error queue via recvmsg(MSG_ERRQUEUE)
> 5. sock_recv_errqueue() calls put_cmsg() to copy serr->ee from skb->cb [4]
> 6. __check_heap_object() fails because skbuff_fclone_cache has no
>    usercopy whitelist [5]
> 
> When cloned skbs allocated from skbuff_fclone_cache are used in the
> socket error queue, accessing the sock_exterr_skb structure in skb->cb
> via put_cmsg() triggers a usercopy hardening violation:
> 
> [    5.379589] usercopy: Kernel memory exposure attempt detected from SLUB object 'skbuff_fclone_cache' (offset 296, size 16)!
> [    5.382796] kernel BUG at mm/usercopy.c:102!
> [    5.383923] Oops: invalid opcode: 0000 [#1] SMP KASAN NOPTI
> [    5.384903] CPU: 1 UID: 0 PID: 138 Comm: poc_put_cmsg Not tainted 6.12.57 #7
> [    5.384903] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.16.3-0-ga6ed6b701f0a-prebuilt.qemu.org 04/01/2014
> [    5.384903] RIP: 0010:usercopy_abort+0x6c/0x80
> [    5.384903] Code: 1a 86 51 48 c7 c2 40 15 1a 86 41 52 48 c7 c7 c0 15 1a 86 48 0f 45 d6 48 c7 c6 80 15 1a 86 48 89 c1 49 0f 45 f3 e8 84 27 88 ff <0f> 0b 490
> [    5.384903] RSP: 0018:ffffc900006f77a8 EFLAGS: 00010246
> [    5.384903] RAX: 000000000000006f RBX: ffff88800f0ad2a8 RCX: 1ffffffff0f72e74
> [    5.384903] RDX: 0000000000000000 RSI: 0000000000000004 RDI: ffffffff87b973a0
> [    5.384903] RBP: 0000000000000010 R08: 0000000000000000 R09: fffffbfff0f72e74
> [    5.384903] R10: 0000000000000003 R11: 79706f6372657375 R12: 0000000000000001
> [    5.384903] R13: ffff88800f0ad2b8 R14: ffffea00003c2b40 R15: ffffea00003c2b00
> [    5.384903] FS:  0000000011bc4380(0000) GS:ffff8880bf100000(0000) knlGS:0000000000000000
> [    5.384903] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [    5.384903] CR2: 000056aa3b8e5fe4 CR3: 000000000ea26004 CR4: 0000000000770ef0
> [    5.384903] PKRU: 55555554
> [    5.384903] Call Trace:
> [    5.384903]  <TASK>
> [    5.384903]  __check_heap_object+0x9a/0xd0
> [    5.384903]  __check_object_size+0x46c/0x690
> [    5.384903]  put_cmsg+0x129/0x5e0
> [    5.384903]  sock_recv_errqueue+0x22f/0x380
> [    5.384903]  tls_sw_recvmsg+0x7ed/0x1960
> [    5.384903]  ? srso_alias_return_thunk+0x5/0xfbef5
> [    5.384903]  ? schedule+0x6d/0x270
> [    5.384903]  ? srso_alias_return_thunk+0x5/0xfbef5
> [    5.384903]  ? mutex_unlock+0x81/0xd0
> [    5.384903]  ? __pfx_mutex_unlock+0x10/0x10
> [    5.384903]  ? __pfx_tls_sw_recvmsg+0x10/0x10
> [    5.384903]  ? _raw_spin_lock_irqsave+0x8f/0xf0
> [    5.384903]  ? _raw_read_unlock_irqrestore+0x20/0x40
> [    5.384903]  ? srso_alias_return_thunk+0x5/0xfbef5
> 
> The crash offset 296 corresponds to skb2->cb within skbuff_fclones:
>   - sizeof(struct sk_buff) = 232
>   - offsetof(struct sk_buff, cb) = 40
>   - offset of skb2.cb in fclones = 232 + 40 = 272
>   - crash offset 296 = 272 + 24 (inside sock_exterr_skb.ee)
> 
> Fix this by using kmem_cache_create_usercopy() for skbuff_fclone_cache
> and whitelisting the cb regions.
> In our patch, we referenced
>     net: Whitelist the `skb_head_cache` "cb" field. [6]
> 
> Fix by using kmem_cache_create_usercopy() with the same cb[] region
> whitelist as skbuff_head_cache.
> 
> [1] https://elixir.bootlin.com/linux/v6.12.62/source/net/ipv4/tcp.c#L885
> [2] https://elixir.bootlin.com/linux/v6.12.62/source/net/core/skbuff.c#L5104
> [3] https://elixir.bootlin.com/linux/v6.12.62/source/net/core/skbuff.c#L5566
> [4] https://elixir.bootlin.com/linux/v6.12.62/source/net/core/skbuff.c#L5491
> [5] https://elixir.bootlin.com/linux/v6.12.62/source/mm/slub.c#L5719
> [6] https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit/?id=79a8a642bf05c
> 
> Fixes: 6d07d1cd300f ("usercopy: Restrict non-usercopy caches to size 0")
> Reported-by: Xiang Mei <xmei5@asu.edu>
> Signed-off-by: Weiming Shi <bestswngs@gmail.com>

Rephrasing Eric's comment (and hoping to have not misread it), you
should fix the issue differently, catching and fclones before adding
them to the error queue and try to unclone them.

Thanks,

Paolo


