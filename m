Return-Path: <netdev+bounces-152616-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1413A9F4E14
	for <lists+netdev@lfdr.de>; Tue, 17 Dec 2024 15:42:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C45CA7A4878
	for <lists+netdev@lfdr.de>; Tue, 17 Dec 2024 14:41:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49C741F63CA;
	Tue, 17 Dec 2024 14:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="htGRnLVk"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E9121F543C
	for <netdev@vger.kernel.org>; Tue, 17 Dec 2024 14:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734446493; cv=none; b=W1rXJW8SGjLLYiCZGrOKGWOVfeKgsysvAH7ZlZ1nRNnK/iOySIw9q3jXwilKi4Bg3BmPi82lm5Y528TAieBSdL7RTtu9JlWkhAKsmqOF3srFK/WYosQLvzH2EwK8tbh7+jJJvIkpM0DyB4XCM5Nb93prreuVHaOVa5BFVBaemEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734446493; c=relaxed/simple;
	bh=8AaDbwKFvbcT7zaM0O+vBHHHaxZSkDqoKZJscM4UnIA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W7oZ5jW3heBE7+TtLvKp2Fg+CYIWYUMzjkJio53lEQLZQvw+DhIAShDhTBUBJ2Z3VAfFPwbMBgxY5WrxtWbOp7kfMmgtQQr+ES7p76RYbUoiSmy58NffFj8CZiq9T89hBM+Q4icZHTNlZlbhNYcyzcOMZkqMHLgRhf4eu1hPF8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=htGRnLVk; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1734446490;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wbF0QnqvZQCN2H1ohlWqQ9MDNp8eXpFsMJUFdmfarCM=;
	b=htGRnLVkVr2uUcTqtX9b0tZT4FrbojWSD5/862suyZAmQNXXLju4ahuvxs88HyqrXO1OzA
	sc9z+gwu+nU5Hbnp2Mv7kn9NkqxyXtEPm9uQWw7PqqhNrqHDs0ap85sgFQxyKz0r7ljC+z
	4NQn/tVSv/7XIADgznWdgRCWYfyn3ec=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-219-sSoGQlv_Oay0PLieaRhZmQ-1; Tue, 17 Dec 2024 09:41:26 -0500
X-MC-Unique: sSoGQlv_Oay0PLieaRhZmQ-1
X-Mimecast-MFC-AGG-ID: sSoGQlv_Oay0PLieaRhZmQ
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4359206e1e4so49091925e9.2
        for <netdev@vger.kernel.org>; Tue, 17 Dec 2024 06:41:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734446484; x=1735051284;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wbF0QnqvZQCN2H1ohlWqQ9MDNp8eXpFsMJUFdmfarCM=;
        b=bdgIQGTNVD7zeuK9zuQk1/PygnxMUrEZSMgJxQ9CtpA0eCCeYVg0Apf2q1MxekekZ0
         B/8eY/UT4p8XmzWfq+TDNR3S60y3g7yi+NlEAiYuhpTNNBpl01j5aOdOOmA5xwna+stm
         z54Q+geew8D9TCgbyRvFi4J8ToGGYJTLpo0fkhk0fTBQc5chyoaFc03P5XjK6WUaro4G
         U0oyrOHE3SP0Q4+KWeSYbz9N1DOV/XQkn41/XHCp2tRXY5a6mDIGloBBaIK/RrsiFcTB
         cOUoEr9vhrytYXkN6SYhmlpiBQBG5zfQAI+upfgX8jgB1N9ShLLMoF/t8d5r7IYxY3m/
         yFnA==
X-Forwarded-Encrypted: i=1; AJvYcCUDbhOvr+Pbl9YYRwKEUAHo5FrYUS74xdMigYbsjS3ftbTZNVzGziz6kHnKot0KdQ/GxZeHRvg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzs5kRoD69NbNqL7kmHnHZF1SU10T4kVvsP+GW7g914szPIsOXY
	RYAYFsJgPB7bRTCPvJMk/G+xP9I5Zms5hoHZeXj6UmTPCk7UC8mDpyhK9Dj90Ki27berGqQRz4w
	BYWYKOvbufdfUbZ1urA8wWcSCFZwk+h3k6y8K22eyb+xe8Ia9VMjkIA==
X-Gm-Gg: ASbGnctqhFoo3J/f6kHHgPFqPOWmOHwcMl42/KxbBh1XjIh266+AuuONRxWzmxOcae3
	C7zkGq12VNAwbDrdAb4hJT8wbjThJg0ywQ87QDqGyapSl+fos2Fa1lcudUsHgC6nyANNLvxSNql
	63x5XA2FNUPzX9y2844KCOOVE7yd7AWCKP5egJmFsnZsqBIyfmb7g1yEkKIceq0oxsVssZLDygx
	v40v2Zs9T1cS8Mm15aFhZdKPXDwfmGSajdyL4H4rpvRXckXsIM=
X-Received: by 2002:a05:600c:1c07:b0:434:f131:1e71 with SMTP id 5b1f17b1804b1-4362aa36366mr146939705e9.8.1734446484243;
        Tue, 17 Dec 2024 06:41:24 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF7jHu3hMKo7ci38i3N/LDa4GbAjUSHIYuHUYCV2SAptPvL6tGlGEDWezUuc/ZQFOL5fTk9Cw==
X-Received: by 2002:a05:600c:1c07:b0:434:f131:1e71 with SMTP id 5b1f17b1804b1-4362aa36366mr146939385e9.8.1734446483772;
        Tue, 17 Dec 2024 06:41:23 -0800 (PST)
Received: from redhat.com ([2a02:14f:1ed:dd96:e5cc:8b38:146f:2e38])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43625717c9fsm174748175e9.44.2024.12.17.06.41.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Dec 2024 06:41:23 -0800 (PST)
Date: Tue, 17 Dec 2024 09:41:19 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, Simon Horman <horms@kernel.org>,
	eric.dumazet@gmail.com,
	syzbot+f56a5c5eac2b28439810@syzkaller.appspotmail.com,
	Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH net-next] ptr_ring: do not block hard interrupts in
 ptr_ring_resize_multiple()
Message-ID: <20241217094106-mutt-send-email-mst@kernel.org>
References: <20241217135121.326370-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241217135121.326370-1-edumazet@google.com>

On Tue, Dec 17, 2024 at 01:51:21PM +0000, Eric Dumazet wrote:
> Jakub added a lockdep_assert_no_hardirq() check in __page_pool_put_page()
> to increase test coverage.
> 
> syzbot found a splat caused by hard irq blocking in
> ptr_ring_resize_multiple() [1]
> 
> As current users of ptr_ring_resize_multiple() do not require
> hard irqs being masked, replace it to only block BH.
> 
> Rename helpers to better reflect they are safe against BH only.
> 
> - ptr_ring_resize_multiple() to ptr_ring_resize_multiple_bh()
> - skb_array_resize_multiple() to skb_array_resize_multiple_bh()
> 
> [1]
> 
> WARNING: CPU: 1 PID: 9150 at net/core/page_pool.c:709 __page_pool_put_page net/core/page_pool.c:709 [inline]
> WARNING: CPU: 1 PID: 9150 at net/core/page_pool.c:709 page_pool_put_unrefed_netmem+0x157/0xa40 net/core/page_pool.c:780
> Modules linked in:
> CPU: 1 UID: 0 PID: 9150 Comm: syz.1.1052 Not tainted 6.11.0-rc3-syzkaller-00202-gf8669d7b5f5d #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/06/2024
> RIP: 0010:__page_pool_put_page net/core/page_pool.c:709 [inline]
> RIP: 0010:page_pool_put_unrefed_netmem+0x157/0xa40 net/core/page_pool.c:780
> Code: 74 0e e8 7c aa fb f7 eb 43 e8 75 aa fb f7 eb 3c 65 8b 1d 38 a8 6a 76 31 ff 89 de e8 a3 ae fb f7 85 db 74 0b e8 5a aa fb f7 90 <0f> 0b 90 eb 1d 65 8b 1d 15 a8 6a 76 31 ff 89 de e8 84 ae fb f7 85
> RSP: 0018:ffffc9000bda6b58 EFLAGS: 00010083
> RAX: ffffffff8997e523 RBX: 0000000000000000 RCX: 0000000000040000
> RDX: ffffc9000fbd0000 RSI: 0000000000001842 RDI: 0000000000001843
> RBP: 0000000000000000 R08: ffffffff8997df2c R09: 1ffffd40003a000d
> R10: dffffc0000000000 R11: fffff940003a000e R12: ffffea0001d00040
> R13: ffff88802e8a4000 R14: dffffc0000000000 R15: 00000000ffffffff
> FS:  00007fb7aaf716c0(0000) GS:ffff8880b9300000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007fa15a0d4b72 CR3: 00000000561b0000 CR4: 00000000003506f0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>  <TASK>
>  tun_ptr_free drivers/net/tun.c:617 [inline]
>  __ptr_ring_swap_queue include/linux/ptr_ring.h:571 [inline]
>  ptr_ring_resize_multiple_noprof include/linux/ptr_ring.h:643 [inline]
>  tun_queue_resize drivers/net/tun.c:3694 [inline]
>  tun_device_event+0xaaf/0x1080 drivers/net/tun.c:3714
>  notifier_call_chain+0x19f/0x3e0 kernel/notifier.c:93
>  call_netdevice_notifiers_extack net/core/dev.c:2032 [inline]
>  call_netdevice_notifiers net/core/dev.c:2046 [inline]
>  dev_change_tx_queue_len+0x158/0x2a0 net/core/dev.c:9024
>  do_setlink+0xff6/0x41f0 net/core/rtnetlink.c:2923
>  rtnl_setlink+0x40d/0x5a0 net/core/rtnetlink.c:3201
>  rtnetlink_rcv_msg+0x73f/0xcf0 net/core/rtnetlink.c:6647
>  netlink_rcv_skb+0x1e3/0x430 net/netlink/af_netlink.c:2550
> 
> Fixes: ff4e538c8c3e ("page_pool: add a lockdep check for recycling in hardirq")
> Reported-by: syzbot+f56a5c5eac2b28439810@syzkaller.appspotmail.com
> Closes: https://lore.kernel.org/netdev/671e10df.050a0220.2b8c0f.01cf.GAE@google.com/T/
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> Cc: Jason Wang <jasowang@redhat.com>
> Cc: Michael S. Tsirkin <mst@redhat.com>


Acked-by: Michael S. Tsirkin <mst@redhat.com>

> ---
>  drivers/net/tap.c         |  6 +++---
>  drivers/net/tun.c         |  6 +++---
>  include/linux/ptr_ring.h  | 21 ++++++++++-----------
>  include/linux/skb_array.h | 17 +++++++++--------
>  net/sched/sch_generic.c   |  4 ++--
>  5 files changed, 27 insertions(+), 27 deletions(-)
> 
> diff --git a/drivers/net/tap.c b/drivers/net/tap.c
> index 5aa41d5f7765a6dcf185bccd3cba2299bad89398..5ca6ecf0ce5fbce6777b47d9906586b07f1b690a 100644
> --- a/drivers/net/tap.c
> +++ b/drivers/net/tap.c
> @@ -1329,9 +1329,9 @@ int tap_queue_resize(struct tap_dev *tap)
>  	list_for_each_entry(q, &tap->queue_list, next)
>  		rings[i++] = &q->ring;
>  
> -	ret = ptr_ring_resize_multiple(rings, n,
> -				       dev->tx_queue_len, GFP_KERNEL,
> -				       __skb_array_destroy_skb);
> +	ret = ptr_ring_resize_multiple_bh(rings, n,
> +					  dev->tx_queue_len, GFP_KERNEL,
> +					  __skb_array_destroy_skb);
>  
>  	kfree(rings);
>  	return ret;
> diff --git a/drivers/net/tun.c b/drivers/net/tun.c
> index 8e94df88392c68c0585c26dd7d4fc6928062ec2b..41e3eeac06fdc7d4b7cd029a60dc2acc7e447c4a 100644
> --- a/drivers/net/tun.c
> +++ b/drivers/net/tun.c
> @@ -3701,9 +3701,9 @@ static int tun_queue_resize(struct tun_struct *tun)
>  	list_for_each_entry(tfile, &tun->disabled, next)
>  		rings[i++] = &tfile->tx_ring;
>  
> -	ret = ptr_ring_resize_multiple(rings, n,
> -				       dev->tx_queue_len, GFP_KERNEL,
> -				       tun_ptr_free);
> +	ret = ptr_ring_resize_multiple_bh(rings, n,
> +					  dev->tx_queue_len, GFP_KERNEL,
> +					  tun_ptr_free);
>  
>  	kfree(rings);
>  	return ret;
> diff --git a/include/linux/ptr_ring.h b/include/linux/ptr_ring.h
> index fd037c127bb0713bdccbb0698738e42ef8017641..551329220e4f34c9cc1def216ed91eff8b041a7b 100644
> --- a/include/linux/ptr_ring.h
> +++ b/include/linux/ptr_ring.h
> @@ -615,15 +615,14 @@ static inline int ptr_ring_resize_noprof(struct ptr_ring *r, int size, gfp_t gfp
>  /*
>   * Note: producer lock is nested within consumer lock, so if you
>   * resize you must make sure all uses nest correctly.
> - * In particular if you consume ring in interrupt or BH context, you must
> - * disable interrupts/BH when doing so.
> + * In particular if you consume ring in BH context, you must
> + * disable BH when doing so.
>   */
> -static inline int ptr_ring_resize_multiple_noprof(struct ptr_ring **rings,
> -						  unsigned int nrings,
> -						  int size,
> -						  gfp_t gfp, void (*destroy)(void *))
> +static inline int ptr_ring_resize_multiple_bh_noprof(struct ptr_ring **rings,
> +						     unsigned int nrings,
> +						     int size, gfp_t gfp,
> +						     void (*destroy)(void *))
>  {
> -	unsigned long flags;
>  	void ***queues;
>  	int i;
>  
> @@ -638,12 +637,12 @@ static inline int ptr_ring_resize_multiple_noprof(struct ptr_ring **rings,
>  	}
>  
>  	for (i = 0; i < nrings; ++i) {
> -		spin_lock_irqsave(&(rings[i])->consumer_lock, flags);
> +		spin_lock_bh(&(rings[i])->consumer_lock);
>  		spin_lock(&(rings[i])->producer_lock);
>  		queues[i] = __ptr_ring_swap_queue(rings[i], queues[i],
>  						  size, gfp, destroy);
>  		spin_unlock(&(rings[i])->producer_lock);
> -		spin_unlock_irqrestore(&(rings[i])->consumer_lock, flags);
> +		spin_unlock_bh(&(rings[i])->consumer_lock);
>  	}
>  
>  	for (i = 0; i < nrings; ++i)
> @@ -662,8 +661,8 @@ static inline int ptr_ring_resize_multiple_noprof(struct ptr_ring **rings,
>  noqueues:
>  	return -ENOMEM;
>  }
> -#define ptr_ring_resize_multiple(...) \
> -		alloc_hooks(ptr_ring_resize_multiple_noprof(__VA_ARGS__))
> +#define ptr_ring_resize_multiple_bh(...) \
> +		alloc_hooks(ptr_ring_resize_multiple_bh_noprof(__VA_ARGS__))
>  
>  static inline void ptr_ring_cleanup(struct ptr_ring *r, void (*destroy)(void *))
>  {
> diff --git a/include/linux/skb_array.h b/include/linux/skb_array.h
> index 926496c9cc9c3b64c6b2d942524d91192e423da2..bf178238a3083d4f56b7386d12e06bc2f0b929fa 100644
> --- a/include/linux/skb_array.h
> +++ b/include/linux/skb_array.h
> @@ -199,17 +199,18 @@ static inline int skb_array_resize(struct skb_array *a, int size, gfp_t gfp)
>  	return ptr_ring_resize(&a->ring, size, gfp, __skb_array_destroy_skb);
>  }
>  
> -static inline int skb_array_resize_multiple_noprof(struct skb_array **rings,
> -						   int nrings, unsigned int size,
> -						   gfp_t gfp)
> +static inline int skb_array_resize_multiple_bh_noprof(struct skb_array **rings,
> +						      int nrings,
> +						      unsigned int size,
> +						      gfp_t gfp)
>  {
>  	BUILD_BUG_ON(offsetof(struct skb_array, ring));
> -	return ptr_ring_resize_multiple_noprof((struct ptr_ring **)rings,
> -					       nrings, size, gfp,
> -					       __skb_array_destroy_skb);
> +	return ptr_ring_resize_multiple_bh_noprof((struct ptr_ring **)rings,
> +					          nrings, size, gfp,
> +					          __skb_array_destroy_skb);
>  }
> -#define skb_array_resize_multiple(...)	\
> -		alloc_hooks(skb_array_resize_multiple_noprof(__VA_ARGS__))
> +#define skb_array_resize_multiple_bh(...)	\
> +		alloc_hooks(skb_array_resize_multiple_bh_noprof(__VA_ARGS__))
>  
>  static inline void skb_array_cleanup(struct skb_array *a)
>  {
> diff --git a/net/sched/sch_generic.c b/net/sched/sch_generic.c
> index 38ec18f73de43aed565c653fffb838f54e7c824b..8874ae6680952a0531cc5175e1de8510e55914ea 100644
> --- a/net/sched/sch_generic.c
> +++ b/net/sched/sch_generic.c
> @@ -911,8 +911,8 @@ static int pfifo_fast_change_tx_queue_len(struct Qdisc *sch,
>  		bands[prio] = q;
>  	}
>  
> -	return skb_array_resize_multiple(bands, PFIFO_FAST_BANDS, new_len,
> -					 GFP_KERNEL);
> +	return skb_array_resize_multiple_bh(bands, PFIFO_FAST_BANDS, new_len,
> +					    GFP_KERNEL);
>  }
>  
>  struct Qdisc_ops pfifo_fast_ops __read_mostly = {
> -- 
> 2.47.1.613.gc27f4b7a9f-goog


