Return-Path: <netdev+bounces-152405-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AD3EE9F3CE7
	for <lists+netdev@lfdr.de>; Mon, 16 Dec 2024 22:42:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EED1416A553
	for <lists+netdev@lfdr.de>; Mon, 16 Dec 2024 21:42:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F1B61D516A;
	Mon, 16 Dec 2024 21:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b="D+FVO7hR"
X-Original-To: netdev@vger.kernel.org
Received: from mailtransmit05.runbox.com (mailtransmit05.runbox.com [185.226.149.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 173F41D5160
	for <netdev@vger.kernel.org>; Mon, 16 Dec 2024 21:42:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734385351; cv=none; b=mNR+dpeEgrk9v/im/d2IpCMNjDhIh0neZmZ8Kafno1p4HCf9ntl8Nf7OhF/RhqP7fvF/W5Objj/JIwsKfpcTiwy4LbkeGM1pCUG1elS75LMe73caSKfq4B/pKjtwB7PluuvWJkDJZoHzKRw1c5Vd4eU+Mm9uxuZ4S78e5gdORZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734385351; c=relaxed/simple;
	bh=+MpZJ0I5B5VyhXmdaLF6gto5vEzMLJwPD1JLKdj2sTo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NOZxkLfKScPF0q7RAU1Subk5PCoTQHBLiI0/5057/Mh3zKxsbGEILgTzKB40+XzisnSre/BfD77pjEvJINA6tCI8R+21Ye5xq8Jw9ITXeG+zuW1ccYqCD9BsCYPsGDgRGIVFC4W6UCl8ypJyEiwrCsM64fcT5nzNgA6nYDMnJrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co; spf=pass smtp.mailfrom=rbox.co; dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b=D+FVO7hR; arc=none smtp.client-ip=185.226.149.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rbox.co
Received: from mailtransmit03.runbox ([10.9.9.163] helo=aibo.runbox.com)
	by mailtransmit05.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <mhal@rbox.co>)
	id 1tNIr6-00HIa4-VH; Mon, 16 Dec 2024 22:42:20 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
	s=selector2; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID;
	bh=oPDhluwLNnAHisIoq5Bewnr+QVh50mQONVLfuBkKbss=; b=D+FVO7hR3RBkYmlHJkrM7qTDoH
	3kVRFjw2jR+05AuIKoH6KkAaBoxyh3YCevNeWs3kEXgcxRCcnKg+l5wOduvJW2q22dKjC3WilMMVx
	oCp2SYWG35fcRlIRABLgmTFxQyRcvUDE1NMgkHMhOxtCmm0kH/folI8cM/D4q7KZqSszsnKyqrgED
	Ye0SLpODGmWg1s17hEYatdq7sNncDkw39FAOlWr+OwvImIfolEfWAXY3s4hXQSDJG/0fbi7kvep5/
	vQLd90reg6RRPI1nHSEkRXqgSNj8ttHaCps8zyDRl/b7ekN5jxfmaCemqqFKFKgMxE7wpH/wPdBw6
	brc6VzoQ==;
Received: from [10.9.9.73] (helo=submission02.runbox)
	by mailtransmit03.runbox with esmtp (Exim 4.86_2)
	(envelope-from <mhal@rbox.co>)
	id 1tNIr5-0001HN-9a; Mon, 16 Dec 2024 22:42:19 +0100
Received: by submission02.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1tNIqo-00FeT0-Pm; Mon, 16 Dec 2024 22:42:02 +0100
Message-ID: <2251fed2-418e-417c-ba27-b2a177f26384@rbox.co>
Date: Mon, 16 Dec 2024 22:42:01 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net: Check for oversized requests in sock_kmalloc()
To: Eric Dumazet <edumazet@google.com>
Cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
 herbert@gondor.apana.org.au
References: <20241216-sock-kmalloc-warn-v1-1-9cb7fdee5b32@rbox.co>
 <CANn89i+oL+qoPmbbGvE_RT3_3OWgeck7cCPcTafeehKrQZ8kyw@mail.gmail.com>
From: Michal Luczaj <mhal@rbox.co>
Content-Language: pl-PL, en-GB
In-Reply-To: <CANn89i+oL+qoPmbbGvE_RT3_3OWgeck7cCPcTafeehKrQZ8kyw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

+cc Herbert. Allocator warning due to sock_kmalloc() in
crypto/af_alg.c:alg_setkey(). Please see the cover letter for a repro:
https://lore.kernel.org/netdev/20241216-sock-kmalloc-warn-v1-1-9cb7fdee5b32@rbox.co/

More comments below:

On 12/16/24 13:43, Eric Dumazet wrote:
> On Mon, Dec 16, 2024 at 12:51 PM Michal Luczaj <mhal@rbox.co> wrote:
>>
>> Allocator explicitly rejects requests of order > MAX_PAGE_ORDER, triggering
>> a WARN_ON_ONCE_GFP().
>>
>> Put a size limit in sock_kmalloc().
>>
>> WARNING: CPU: 6 PID: 1676 at mm/page_alloc.c:4727 __alloc_pages_noprof+0x32e/0x3a0
>> Call Trace:
>>  ___kmalloc_large_node+0x71/0xf0
>>  __kmalloc_large_node_noprof+0x1b/0xf0
>>  __kmalloc_noprof+0x436/0x560
>>  sock_kmalloc+0x44/0x60
>>  ____sys_sendmsg+0x208/0x3a0
>>  ___sys_sendmsg+0x84/0xd0
>>  __sys_sendmsg+0x56/0xa0
>>  do_syscall_64+0x93/0x180
>>  entry_SYSCALL_64_after_hwframe+0x76/0x7e
>>
>> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> 
> I would rather change ____sys_sendmsg() to use something different
> than sock_kmalloc().
> 
> This would avoid false sharing (on sk->sk_omem_alloc) for a short-lived buffer,
> and could help UDP senders sharing a socket...
> 
> sock_kmalloc() was really meant for small and long lived allocations
> (corroborated by net.core.optmem_max small default value)
> 
> diff --git a/net/socket.c b/net/socket.c
> index 9a117248f18f13d574d099c80128986c744fa97f..c23d8e20c5c626c54b9a04a416b82f696fa2310c
> 100644
> --- a/net/socket.c
> +++ b/net/socket.c
> @@ -2552,7 +2552,8 @@ static int ____sys_sendmsg(struct socket *sock,
> struct msghdr *msg_sys,
>                 BUILD_BUG_ON(sizeof(struct cmsghdr) !=
>                              CMSG_ALIGN(sizeof(struct cmsghdr)));
>                 if (ctl_len > sizeof(ctl)) {
> -                       ctl_buf = sock_kmalloc(sock->sk, ctl_len, GFP_KERNEL);
> +                       ctl_buf = kvmalloc(ctl_len, GFP_KERNEL_ACCOUNT |
> +                                                   __GFP_NOWARN);
>                         if (ctl_buf == NULL)
>                                 goto out;
>                 }
> @@ -2594,7 +2595,7 @@ static int ____sys_sendmsg(struct socket *sock,
> struct msghdr *msg_sys,
> 
>  out_freectl:
>         if (ctl_buf != ctl)
> -               sock_kfree_s(sock->sk, ctl_buf, ctl_len);
> +               kvfree(ctl_buf);
>  out:
>         return err;
>  }

Got it. I guess the same treatment for cmsghdr_from_user_compat_to_kern()?

Similar problem is with compat_ip_set_mcast_msfilter() and
compat_ipv6_set_mcast_msfilter(), direct kmalloc() this time.


