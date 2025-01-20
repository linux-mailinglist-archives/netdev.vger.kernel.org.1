Return-Path: <netdev+bounces-159722-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A2E5A16A6C
	for <lists+netdev@lfdr.de>; Mon, 20 Jan 2025 11:08:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3FB9A7A4FDC
	for <lists+netdev@lfdr.de>; Mon, 20 Jan 2025 10:06:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80B271B0435;
	Mon, 20 Jan 2025 10:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="B+cy2cux"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABDFE1AF0B7
	for <netdev@vger.kernel.org>; Mon, 20 Jan 2025 10:05:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737367541; cv=none; b=Te5qcVblpqi1F2zPnyXlny68qQSMaJ3MzjOonYcndgd12HlgibTjMz47UNQoHXboq8zl4AHYPtOVNVpZq7449NGy+WlySv0j7EnLS5oln/A9UQD6AvsBLM8SQUjkSy475Ns5ymf3ug7TIS7ysicAe7LhosX+EnXdFag4HmviKOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737367541; c=relaxed/simple;
	bh=08vxQ3KM/yvrzmbqcimiCJkKEMETtnSW/bLB7iwP5no=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CS1YEGwSxnsChpTORHIHJah0geU2owLA2+M724Tuoj3YVGloZFvm4IK283tT5BUkqKdCZ+coXQX1630v5rBASB028V76bImNpsoIWuLvEh2S5cL4Rm49e6/iq8AlQyEkbC+4ErB5NoZxTV+7jPX1qpcveX8DWBC0RMu3mkpp94A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=B+cy2cux; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1737367538;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=N6xFCWck3Nvay8R9bzPsZM3ftFbwN8dlRuFP3neRYjA=;
	b=B+cy2cuxjOSRl4VffTq0zbiemPc4G2DD30CCowueqoxflzfSYndOIjYEpT2W9pxBwMYSoE
	Lj/2H4eqyGt6azemwx0BGc561dnOaMmLA4i4LqkkU4YpRf4vVa9gA/UQnyPig4R6Tmq/Sy
	97SQguf7JHKXpWZQxS9E04Fj1gyNz6w=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-98-qMHm3oqxNG-UrC4Gln1MNw-1; Mon, 20 Jan 2025 05:05:36 -0500
X-MC-Unique: qMHm3oqxNG-UrC4Gln1MNw-1
X-Mimecast-MFC-AGG-ID: qMHm3oqxNG-UrC4Gln1MNw
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4361efc9dc6so22682235e9.3
        for <netdev@vger.kernel.org>; Mon, 20 Jan 2025 02:05:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737367533; x=1737972333;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N6xFCWck3Nvay8R9bzPsZM3ftFbwN8dlRuFP3neRYjA=;
        b=Drh8B6vnzLqcOMDHpf3V1mvKtWOvJQeMMMZ8t48kqdJ3koMHnRWKzt8+uggk62zV+1
         pbCmT/D+7e6ygsfQKP221BTK9ZnpCQAn6Pd55J1uZl4jnibmwYa1I8TAOoO6Z5hiiW1g
         47H3oTk/BetQQwtBmFQTdHJk/bc6y1mt3FzNwSp6rC2JO/34JyzC9JVxQOh42dlJNZ4K
         oUyEX3PcZjhXbFBgRsOKaHH8/vj/v8jIvZfNyNztTWrFs+h+t4HkXCWBOQMdqvw8eYsa
         5+Ms8Qh1ozdUsAhGBQFglqAHG4944E5GyI0m61b+oV8QSRhwLrCzUBWBg+YhE4AXgXaq
         1Vdw==
X-Forwarded-Encrypted: i=1; AJvYcCXdq/9XiypzIFMgdgHFuG3pmRUPOKMEZN/blMYmwq8F61RcnAecmnipU5PMJknUPzO/zffSwUI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxa19Mu4wCZaomiyerMqg59f/bxZxfUtESbuy9rHnKthMtdZK+c
	9jGjJs0uYmP9t0UU+RdoKKqP6vtBZ23ElMEZQXtCzRC210omvsI/ORM1912QztiZSToXvaaSDQr
	02fisHKLRxnrd9HWaiHT1ql+xrRNHtlGmBc/Rmn3ViUTukAddDUykDw==
X-Gm-Gg: ASbGncvGelay6gwKoV8tmBxb0tsxNbm1wTxLMLl/7QDUhJLtJ+jEZ9p+aiy1lHF/W77
	0xHa+mNGUAiyC3W1IA0Vdn8UC5sNqLD3sk6nmLeukO4o4TaudpW7SNDVnGMK2vC4uebn75FGaXJ
	m4kUM4OsLpiav6/65BbsSKcyINtYxDdJnDezEPdN9L4KgC3tpZBFKkHZwPZOWGLQcRB/pg5Igoz
	HoJZqcRXLIGkNXGHrpzUMEKz33eZwab19H2eb73/kL0yWu2oZxJCj6w75e/yjTzx4M9xNYdbuK0
	gcQzXjR5Iy0j/sgIfJaQuo1EwIHC634wgLHS/wTeJ9MLmg==
X-Received: by 2002:a05:600c:6550:b0:434:f3d8:62d0 with SMTP id 5b1f17b1804b1-438946434dcmr102078625e9.3.1737367532733;
        Mon, 20 Jan 2025 02:05:32 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFQIA1F2NKy+w/ovEqIGxrOqY/+iE3Tk3GoNRZ0K1Txb3kmfSRefJ38QeseAVT4b2h9s7nQpg==
X-Received: by 2002:a05:600c:6550:b0:434:f3d8:62d0 with SMTP id 5b1f17b1804b1-438946434dcmr102078075e9.3.1737367532025;
        Mon, 20 Jan 2025 02:05:32 -0800 (PST)
Received: from sgarzare-redhat (host-82-53-134-100.retail.telecomitalia.it. [82.53.134.100])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43890413801sm130186125e9.15.2025.01.20.02.05.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jan 2025 02:05:31 -0800 (PST)
Date: Mon, 20 Jan 2025 11:05:27 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Michal Luczaj <mhal@rbox.co>
Cc: "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	George Zhang <georgezhang@vmware.com>, Dmitry Torokhov <dtor@vmware.com>, Andy King <acking@vmware.com>, 
	netdev@vger.kernel.org
Subject: Re: [PATCH net 1/5] vsock: Keep the binding until socket destruction
Message-ID: <jy6sadpembyveqov4nyhwrnckp7k32hgxaviy5rw4dqink46lw@lqwfadqmdpbs>
References: <20250117-vsock-transport-vs-autobind-v1-0-c802c803762d@rbox.co>
 <20250117-vsock-transport-vs-autobind-v1-1-c802c803762d@rbox.co>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20250117-vsock-transport-vs-autobind-v1-1-c802c803762d@rbox.co>

On Fri, Jan 17, 2025 at 10:59:41PM +0100, Michal Luczaj wrote:
>Preserve sockets bindings; this includes both resulting from an explicit
>bind() and those implicitly bound through autobind during connect().
>
>Prevents socket unbinding during a transport reassignment, which fixes a
>use-after-free:
>
>    1. vsock_create() (refcnt=1) calls vsock_insert_unbound() (refcnt=2)
>    2. transport->release() calls vsock_remove_bound() without checking if
>       sk was bound and moved to bound list (refcnt=1)
>    3. vsock_bind() assumes sk is in unbound list and before
>       __vsock_insert_bound(vsock_bound_sockets()) calls
>       __vsock_remove_bound() which does:
>           list_del_init(&vsk->bound_table); // nop
>           sock_put(&vsk->sk);               // refcnt=0
>
>BUG: KASAN: slab-use-after-free in __vsock_bind+0x62e/0x730
>Read of size 4 at addr ffff88816b46a74c by task a.out/2057
> dump_stack_lvl+0x68/0x90
> print_report+0x174/0x4f6
> kasan_report+0xb9/0x190
> __vsock_bind+0x62e/0x730
> vsock_bind+0x97/0xe0
> __sys_bind+0x154/0x1f0
> __x64_sys_bind+0x6e/0xb0
> do_syscall_64+0x93/0x1b0
> entry_SYSCALL_64_after_hwframe+0x76/0x7e
>
>Allocated by task 2057:
> kasan_save_stack+0x1e/0x40
> kasan_save_track+0x10/0x30
> __kasan_slab_alloc+0x85/0x90
> kmem_cache_alloc_noprof+0x131/0x450
> sk_prot_alloc+0x5b/0x220
> sk_alloc+0x2c/0x870
> __vsock_create.constprop.0+0x2e/0xb60
> vsock_create+0xe4/0x420
> __sock_create+0x241/0x650
> __sys_socket+0xf2/0x1a0
> __x64_sys_socket+0x6e/0xb0
> do_syscall_64+0x93/0x1b0
> entry_SYSCALL_64_after_hwframe+0x76/0x7e
>
>Freed by task 2057:
> kasan_save_stack+0x1e/0x40
> kasan_save_track+0x10/0x30
> kasan_save_free_info+0x37/0x60
> __kasan_slab_free+0x4b/0x70
> kmem_cache_free+0x1a1/0x590
> __sk_destruct+0x388/0x5a0
> __vsock_bind+0x5e1/0x730
> vsock_bind+0x97/0xe0
> __sys_bind+0x154/0x1f0
> __x64_sys_bind+0x6e/0xb0
> do_syscall_64+0x93/0x1b0
> entry_SYSCALL_64_after_hwframe+0x76/0x7e
>
>refcount_t: addition on 0; use-after-free.
>WARNING: CPU: 7 PID: 2057 at lib/refcount.c:25 refcount_warn_saturate+0xce/0x150
>RIP: 0010:refcount_warn_saturate+0xce/0x150
> __vsock_bind+0x66d/0x730
> vsock_bind+0x97/0xe0
> __sys_bind+0x154/0x1f0
> __x64_sys_bind+0x6e/0xb0
> do_syscall_64+0x93/0x1b0
> entry_SYSCALL_64_after_hwframe+0x76/0x7e
>
>refcount_t: underflow; use-after-free.
>WARNING: CPU: 7 PID: 2057 at lib/refcount.c:28 refcount_warn_saturate+0xee/0x150
>RIP: 0010:refcount_warn_saturate+0xee/0x150
> vsock_remove_bound+0x187/0x1e0
> __vsock_release+0x383/0x4a0
> vsock_release+0x90/0x120
> __sock_release+0xa3/0x250
> sock_close+0x14/0x20
> __fput+0x359/0xa80
> task_work_run+0x107/0x1d0
> do_exit+0x847/0x2560
> do_group_exit+0xb8/0x250
> __x64_sys_exit_group+0x3a/0x50
> x64_sys_call+0xfec/0x14f0
> do_syscall_64+0x93/0x1b0
> entry_SYSCALL_64_after_hwframe+0x76/0x7e
>
>Fixes: c0cfa2d8a788 ("vsock: add multi-transports support")
>Signed-off-by: Michal Luczaj <mhal@rbox.co>
>---
> net/vmw_vsock/af_vsock.c | 8 ++++++--
> 1 file changed, 6 insertions(+), 2 deletions(-)
>
>diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
>index fa9d1b49599bf219bdf9486741582cc8c547a354..cfe18bc8fdbe7ced073c6b3644d635fdbfa02610 100644
>--- a/net/vmw_vsock/af_vsock.c
>+++ b/net/vmw_vsock/af_vsock.c
>@@ -337,7 +337,10 @@ EXPORT_SYMBOL_GPL(vsock_find_connected_socket);
>
> void vsock_remove_sock(struct vsock_sock *vsk)
> {
>-	vsock_remove_bound(vsk);
>+	/* Transport reassignment must not remove the binding. */
>+	if (sock_flag(sk_vsock(vsk), SOCK_DEAD))
>+		vsock_remove_bound(vsk);
>+

yeah, great fix!

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

> 	vsock_remove_connected(vsk);
> }
> EXPORT_SYMBOL_GPL(vsock_remove_sock);
>@@ -821,12 +824,13 @@ static void __vsock_release(struct sock *sk, int level)
> 	 */
> 	lock_sock_nested(sk, level);
>
>+	sock_orphan(sk);
>+
> 	if (vsk->transport)
> 		vsk->transport->release(vsk);
> 	else if (sock_type_connectible(sk->sk_type))
> 		vsock_remove_sock(vsk);
>
>-	sock_orphan(sk);
> 	sk->sk_shutdown = SHUTDOWN_MASK;
>
> 	skb_queue_purge(&sk->sk_receive_queue);
>
>-- 
>2.47.1
>


