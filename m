Return-Path: <netdev+bounces-151853-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E2C9A9F1552
	for <lists+netdev@lfdr.de>; Fri, 13 Dec 2024 19:57:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 95512284179
	for <lists+netdev@lfdr.de>; Fri, 13 Dec 2024 18:57:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BAFC1E47DA;
	Fri, 13 Dec 2024 18:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KnRPMXOp"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69539186E26
	for <netdev@vger.kernel.org>; Fri, 13 Dec 2024 18:56:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734116219; cv=none; b=gzphGaTTSaG+Ajlv//jVFrTY8VPhYuNwlujprGuaUxk+krJX0IUI3xE1V66+WDuv0PXDfXQHZjZwWD6stkRyJvZsU0w1NtjVHXSU84I86U3iDzpagC/GNe3ZnUldsknTFaAshHrdze9aOOXJLeYXNTMBgM916xer0bwCO2YAYGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734116219; c=relaxed/simple;
	bh=0e8+O4JghJjhOQLcENPhwMKgyqxGrawAEp6trfJkwX8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l+43z0YnZsNfAx3wxaKOmosWuFIejcEFWrzzmIEV1CsM9Bn729JLzCPt7L5C0sOJkHvcdeK8rvWSCpnqNaVJboXvWxHXqyU7XCIZNI/R/CyLTAWWrtWC108EeBWkbH9W2gckonYDBulGtvkJqTNq7D/I91gYx3YDk4AEkhxZcio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KnRPMXOp; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1734116216;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QSWErHRXKNGRotJcX4TX+3LoaFXgTw2aXPJkQdAFSEM=;
	b=KnRPMXOpsKOihYrvkieEIGLTyoGNt/OqBmo8k75MBzsTKZkjAOEEOC5N9eZeU8SmmDIfpU
	Uo6kYvc88p0TmxIaYETISiCR1d4I3RILPqv1Qjb2V7vIlunC2gmI7sRaL/+YhRgPJTzv3X
	1MHeKrCQBViPnu1H9EKrUjrHBaqV1a4=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-520-1ci1gtTNPl6G6U9THXrrDw-1; Fri, 13 Dec 2024 13:56:55 -0500
X-MC-Unique: 1ci1gtTNPl6G6U9THXrrDw-1
X-Mimecast-MFC-AGG-ID: 1ci1gtTNPl6G6U9THXrrDw
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-385dcae001fso938019f8f.1
        for <netdev@vger.kernel.org>; Fri, 13 Dec 2024 10:56:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734116213; x=1734721013;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QSWErHRXKNGRotJcX4TX+3LoaFXgTw2aXPJkQdAFSEM=;
        b=nG93I00jt86B5nXNcY4HJGYqbgXGkTQcO2jTclDrCQvk2sVeSp/IduZHjmWU6aVSI7
         dcZszKOU0EonZVnxWX6QL9oRXts8CNe9EcNgUGkYiYWuY+wEDhlPBfDv4If61BNvu0lu
         9HrTyvieJ6vr6IxC5XLRBCTC8q590xukjLhugGvyTBKdGgBIEPiZJTVwl8YHzhX9iYey
         rkHuqHwt9QhQEad+JneZE2pg1KvdpxXdAiakGXF33296DRIzuH7rFzSuNt0JLrKzlCzy
         RnhuDkUnJmQiLb2czjDyxG5Po465R0kMiCHqyotm/4NVVxOQ6VOYUQmvxJmPNb6mIWO2
         WUtw==
X-Forwarded-Encrypted: i=1; AJvYcCWbdrY+RdZJG2kck4J/tTPAoVvBD2gI85ZDRknRJu9l81hL84JRLrVSWnr18gpi2TjEhGtFrLs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzY0moRvgAEFVSd4RlMOpsgjs9ZixoIQMVR+VgKwa7w8qSt1Fi9
	VvjTk3mxnyxZSAYl8wvq+P6rgLSSy9ctLiDcLc7DdMmASN0YUUHFVqNfsjrjNqYcNSFZrTn+bqp
	P4inREKtygTaRk1kfTkK8lih21CnI4ktEIwa29F+y44Os8wX7mtbKUosOtG9ODA==
X-Gm-Gg: ASbGnctzfv9Hgx3PAcl6okf5nWe+WVAgtvIrRC7TomkqX2b4IBB9dDdkYxHM4BzkNuV
	uUMfksHm75jCcfRayeeU+EWlpMUiCeKTIEahqytUVPfNKJ5zakCZNo1L5J9IHzvbU8FCmT9xtW7
	/XZKzuDoVs6E6/q+p/d5m7vhL9rGxfJc38BNpqPVDkQTmfJXc+imXQu7G+3B+yS/zrRIH74Qhff
	KnQXtJh2U3Cvk6n1XDK+WRZVRG7f+W/mnLt0SgaRlYpVunW0Q==
X-Received: by 2002:a05:6000:794:b0:385:d7a7:ad60 with SMTP id ffacd0b85a97d-38880ac4e7cmr3050395f8f.3.1734116213681;
        Fri, 13 Dec 2024 10:56:53 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFFmEoxZ7oTC7ewoVyzBb6PwbuHE72nB815J+LoRsQZk17+X7REMkpPohPRnME6F2e8xvb8mQ==
X-Received: by 2002:a05:6000:794:b0:385:d7a7:ad60 with SMTP id ffacd0b85a97d-38880ac4e7cmr3050374f8f.3.1734116213342;
        Fri, 13 Dec 2024 10:56:53 -0800 (PST)
Received: from redhat.com ([2a02:14f:1f4:66af:6381:7d28:90f3:9fad])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-388c8016c0bsm294729f8f.42.2024.12.13.10.56.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Dec 2024 10:56:52 -0800 (PST)
Date: Fri, 13 Dec 2024 13:56:49 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, Simon Horman <horms@kernel.org>,
	eric.dumazet@gmail.com,
	syzbot+4f66250f6663c0c1d67e@syzkaller.appspotmail.com,
	stable@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH net] net: tun: fix tun_napi_alloc_frags()
Message-ID: <20241213135635-mutt-send-email-mst@kernel.org>
References: <20241212222247.724674-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241212222247.724674-1-edumazet@google.com>

On Thu, Dec 12, 2024 at 10:22:47PM +0000, Eric Dumazet wrote:
> syzbot reported the following crash [1]
> 
> Issue came with the blamed commit. Instead of going through
> all the iov components, we keep using the first one
> and end up with a malformed skb.
> 
> [1]
> 
> kernel BUG at net/core/skbuff.c:2849 !
> Oops: invalid opcode: 0000 [#1] PREEMPT SMP KASAN PTI
> CPU: 0 UID: 0 PID: 6230 Comm: syz-executor132 Not tainted 6.13.0-rc1-syzkaller-00407-g96b6fcc0ee41 #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 11/25/2024
>  RIP: 0010:__pskb_pull_tail+0x1568/0x1570 net/core/skbuff.c:2848
> Code: 38 c1 0f 8c 32 f1 ff ff 4c 89 f7 e8 92 96 74 f8 e9 25 f1 ff ff e8 e8 ae 09 f8 48 8b 5c 24 08 e9 eb fb ff ff e8 d9 ae 09 f8 90 <0f> 0b 66 0f 1f 44 00 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90
> RSP: 0018:ffffc90004cbef30 EFLAGS: 00010293
> RAX: ffffffff8995c347 RBX: 00000000fffffff2 RCX: ffff88802cf45a00
> RDX: 0000000000000000 RSI: 00000000fffffff2 RDI: 0000000000000000
> RBP: ffff88807df0c06a R08: ffffffff8995b084 R09: 1ffff1100fbe185c
> R10: dffffc0000000000 R11: ffffed100fbe185d R12: ffff888076e85d50
> R13: ffff888076e85c80 R14: ffff888076e85cf4 R15: ffff888076e85c80
> FS:  00007f0dca6ea6c0(0000) GS:ffff8880b8600000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007f0dca6ead58 CR3: 00000000119da000 CR4: 00000000003526f0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>  <TASK>
>   skb_cow_data+0x2da/0xcb0 net/core/skbuff.c:5284
>   tipc_aead_decrypt net/tipc/crypto.c:894 [inline]
>   tipc_crypto_rcv+0x402/0x24e0 net/tipc/crypto.c:1844
>   tipc_rcv+0x57e/0x12a0 net/tipc/node.c:2109
>   tipc_l2_rcv_msg+0x2bd/0x450 net/tipc/bearer.c:668
>   __netif_receive_skb_list_ptype net/core/dev.c:5720 [inline]
>   __netif_receive_skb_list_core+0x8b7/0x980 net/core/dev.c:5762
>   __netif_receive_skb_list net/core/dev.c:5814 [inline]
>   netif_receive_skb_list_internal+0xa51/0xe30 net/core/dev.c:5905
>   gro_normal_list include/net/gro.h:515 [inline]
>   napi_complete_done+0x2b5/0x870 net/core/dev.c:6256
>   napi_complete include/linux/netdevice.h:567 [inline]
>   tun_get_user+0x2ea0/0x4890 drivers/net/tun.c:1982
>   tun_chr_write_iter+0x10d/0x1f0 drivers/net/tun.c:2057
>  do_iter_readv_writev+0x600/0x880
>   vfs_writev+0x376/0xba0 fs/read_write.c:1050
>   do_writev+0x1b6/0x360 fs/read_write.c:1096
>   do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>   do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> 
> Fixes: de4f5fed3f23 ("iov_iter: add iter_iovec() helper")
> Reported-by: syzbot+4f66250f6663c0c1d67e@syzkaller.appspotmail.com
> Closes: https://lore.kernel.org/netdev/675b61aa.050a0220.599f4.00bb.GAE@google.com/T/#u
> Cc: stable@vger.kernel.org
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> Cc: Jens Axboe <axboe@kernel.dk>

Acked-by: Michael S. Tsirkin <mst@redhat.com>

> ---
>  drivers/net/tun.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/tun.c b/drivers/net/tun.c
> index d7a865ef370b6968c095510ae16b5196e30e54b9..e816aaba8e5f2ed06f8832f79553b6c976e75bb8 100644
> --- a/drivers/net/tun.c
> +++ b/drivers/net/tun.c
> @@ -1481,7 +1481,7 @@ static struct sk_buff *tun_napi_alloc_frags(struct tun_file *tfile,
>  	skb->truesize += skb->data_len;
>  
>  	for (i = 1; i < it->nr_segs; i++) {
> -		const struct iovec *iov = iter_iov(it);
> +		const struct iovec *iov = iter_iov(it) + i;
>  		size_t fragsz = iov->iov_len;
>  		struct page *page;
>  		void *frag;
> -- 
> 2.47.1.613.gc27f4b7a9f-goog
> 


