Return-Path: <netdev+bounces-152799-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C4329F5CF2
	for <lists+netdev@lfdr.de>; Wed, 18 Dec 2024 03:42:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 41A82165C70
	for <lists+netdev@lfdr.de>; Wed, 18 Dec 2024 02:42:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2767F3597B;
	Wed, 18 Dec 2024 02:42:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LNx8VzIP"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 494EC5695
	for <netdev@vger.kernel.org>; Wed, 18 Dec 2024 02:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734489727; cv=none; b=KyQ0l/ZmZXjkEnerw/tDCoaLUfqcL9Hjz9515rkmwGIoC/nUufgrTxW4RGRpKdFJdnCjcfchTMFPQRp+wD4BcSfWNf71xZckkUf+SiSRen0xmsI5nXWwy63zs0qieiIygS8GqiuWn9zJMule3wxzFc/RKFC1Rzpv5ktopqPFRJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734489727; c=relaxed/simple;
	bh=p/qllEYm/O9+QOpl3W0QztfSaLE990gb0E0dYuTsw7Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tBO7w9ZzP41MbdJkP1KOW20ahNzc4RGizMuBallERrHPR2G0rg1ZAsUNWVJjN9+lxOutKia3VMPp6KRYuoBjHLgqplXWhfxi/jixfEJAO1bmcgpKP8+/nutLb78uBxZKjmz6LKBcuQgA+9ekWS+Rz0se4ZkWDnfl/58U9r71noo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LNx8VzIP; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1734489724;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8DqYaz+N5elcOwAwtpvizXidppUyzvLIH/DUCN6/cnc=;
	b=LNx8VzIPxanxTkhmhv7qn6OAb71yglhwzOmFfv51/jJaYXg1ztsZVltrPX8a7nj8p7UD/p
	D1woq6WWZZ6WSS6EIXg25B/W5M75pU/TRefyCZoNVU0RioneDeoSRPj/CVNRrLa4qbgmz3
	U7LEBxW7LDfyL+S5aVNsW9bz6EU3RN8=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-600-a-hWFBDFOCGdRy553mxoNg-1; Tue, 17 Dec 2024 21:42:02 -0500
X-MC-Unique: a-hWFBDFOCGdRy553mxoNg-1
X-Mimecast-MFC-AGG-ID: a-hWFBDFOCGdRy553mxoNg
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-2ef7fbd99a6so5321222a91.1
        for <netdev@vger.kernel.org>; Tue, 17 Dec 2024 18:42:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734489722; x=1735094522;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8DqYaz+N5elcOwAwtpvizXidppUyzvLIH/DUCN6/cnc=;
        b=K2d6OZA+yhql/6YzPKkbIQxhk8P/R5dN5MibhDoAqsGayWn/UzmVQtRo2+zeuC/v+8
         mBPj+pmJcxr/YIWYmUh+8U4U6qtvwJRV+3tEwedmkolxVfyJPTTfAwG/F/LV8vnqrfqS
         XZ+hHmkexHdMyDtnxqqs5qlIyFzUQyRsCs243RH95u/usjmG9vcn6ZQoYvmx1vEW3hSW
         LTW7CLKjcedDnSVKQldZt5h7auFRmjlbJWzua2Fb5dNCPeX5oJOwyP0z8WATai4r0JCG
         53kJhzkxpUXz5ZuzleW9pKfDJVu7Aazco6Dxyc9CiYyE+s7ldJmW85IiR5sxH5EkgSTB
         9EqQ==
X-Forwarded-Encrypted: i=1; AJvYcCVlmA/5/3CrJqmY6rmuX6sIzrBeSn07+yv5xx/dKleMxHCSK7a/v66LNmzsNfbulxj4n3FXOjI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxgm18H3/EZ16UxFG0uqtPBNjCeWLhI5uwA5+kFTqMcQ/ndgn3s
	Jp41NECxAhe4TQPzROh09KeUfz5o1JA8m8vJkYdV3+fWDRWX8J5kiVhtGPHcE1UzeGWzdNSa01h
	+n8Qun00YOw9FJI6NlsCsUhRTIWYAj0vtCpAIfBCMyqCgNRACora5gkjQ/68l+rQeDf/97e8GKF
	b2RbdxePQkbfGIPIGmTtAP3rrl/yXR
X-Gm-Gg: ASbGncu5Xujc5nvN4BG070sl4LR43qoehTcF66h1p8gPy5Bd6eoBIHeda6p9kr3oJJF
	wIWBLI0nIsuMY+DfosZHGx/H8yECcMhSqzkwbtg==
X-Received: by 2002:a17:90b:384f:b0:2ee:d024:e4f7 with SMTP id 98e67ed59e1d1-2f2e8f53927mr1959610a91.0.1734489721858;
        Tue, 17 Dec 2024 18:42:01 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHmsfz+qx+3bzXNatAF6YMYon4Uqw6IkTgAwLrfgD8l/ExEkp0gG57q4OuLtOJ9Ks29mQHR8iYVpoqHtx5gWQw=
X-Received: by 2002:a17:90b:384f:b0:2ee:d024:e4f7 with SMTP id
 98e67ed59e1d1-2f2e8f53927mr1959579a91.0.1734489721450; Tue, 17 Dec 2024
 18:42:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241217135121.326370-1-edumazet@google.com> <20241217094106-mutt-send-email-mst@kernel.org>
In-Reply-To: <20241217094106-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 18 Dec 2024 10:41:50 +0800
Message-ID: <CACGkMEvuseZoHcLrLH6d0UeK12nrA-n=Prg0wt=57BP0UbmpqQ@mail.gmail.com>
Subject: Re: [PATCH net-next] ptr_ring: do not block hard interrupts in ptr_ring_resize_multiple()
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Eric Dumazet <edumazet@google.com>, "David S . Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, 
	Simon Horman <horms@kernel.org>, eric.dumazet@gmail.com, 
	syzbot+f56a5c5eac2b28439810@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 17, 2024 at 10:41=E2=80=AFPM Michael S. Tsirkin <mst@redhat.com=
> wrote:
>
> On Tue, Dec 17, 2024 at 01:51:21PM +0000, Eric Dumazet wrote:
> > Jakub added a lockdep_assert_no_hardirq() check in __page_pool_put_page=
()
> > to increase test coverage.
> >
> > syzbot found a splat caused by hard irq blocking in
> > ptr_ring_resize_multiple() [1]
> >
> > As current users of ptr_ring_resize_multiple() do not require
> > hard irqs being masked, replace it to only block BH.
> >
> > Rename helpers to better reflect they are safe against BH only.
> >
> > - ptr_ring_resize_multiple() to ptr_ring_resize_multiple_bh()
> > - skb_array_resize_multiple() to skb_array_resize_multiple_bh()
> >
> > [1]
> >
> > WARNING: CPU: 1 PID: 9150 at net/core/page_pool.c:709 __page_pool_put_p=
age net/core/page_pool.c:709 [inline]
> > WARNING: CPU: 1 PID: 9150 at net/core/page_pool.c:709 page_pool_put_unr=
efed_netmem+0x157/0xa40 net/core/page_pool.c:780
> > Modules linked in:
> > CPU: 1 UID: 0 PID: 9150 Comm: syz.1.1052 Not tainted 6.11.0-rc3-syzkall=
er-00202-gf8669d7b5f5d #0
> > Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS=
 Google 08/06/2024
> > RIP: 0010:__page_pool_put_page net/core/page_pool.c:709 [inline]
> > RIP: 0010:page_pool_put_unrefed_netmem+0x157/0xa40 net/core/page_pool.c=
:780
> > Code: 74 0e e8 7c aa fb f7 eb 43 e8 75 aa fb f7 eb 3c 65 8b 1d 38 a8 6a=
 76 31 ff 89 de e8 a3 ae fb f7 85 db 74 0b e8 5a aa fb f7 90 <0f> 0b 90 eb =
1d 65 8b 1d 15 a8 6a 76 31 ff 89 de e8 84 ae fb f7 85
> > RSP: 0018:ffffc9000bda6b58 EFLAGS: 00010083
> > RAX: ffffffff8997e523 RBX: 0000000000000000 RCX: 0000000000040000
> > RDX: ffffc9000fbd0000 RSI: 0000000000001842 RDI: 0000000000001843
> > RBP: 0000000000000000 R08: ffffffff8997df2c R09: 1ffffd40003a000d
> > R10: dffffc0000000000 R11: fffff940003a000e R12: ffffea0001d00040
> > R13: ffff88802e8a4000 R14: dffffc0000000000 R15: 00000000ffffffff
> > FS:  00007fb7aaf716c0(0000) GS:ffff8880b9300000(0000) knlGS:00000000000=
00000
> > CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > CR2: 00007fa15a0d4b72 CR3: 00000000561b0000 CR4: 00000000003506f0
> > DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> > DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> > Call Trace:
> >  <TASK>
> >  tun_ptr_free drivers/net/tun.c:617 [inline]
> >  __ptr_ring_swap_queue include/linux/ptr_ring.h:571 [inline]
> >  ptr_ring_resize_multiple_noprof include/linux/ptr_ring.h:643 [inline]
> >  tun_queue_resize drivers/net/tun.c:3694 [inline]
> >  tun_device_event+0xaaf/0x1080 drivers/net/tun.c:3714
> >  notifier_call_chain+0x19f/0x3e0 kernel/notifier.c:93
> >  call_netdevice_notifiers_extack net/core/dev.c:2032 [inline]
> >  call_netdevice_notifiers net/core/dev.c:2046 [inline]
> >  dev_change_tx_queue_len+0x158/0x2a0 net/core/dev.c:9024
> >  do_setlink+0xff6/0x41f0 net/core/rtnetlink.c:2923
> >  rtnl_setlink+0x40d/0x5a0 net/core/rtnetlink.c:3201
> >  rtnetlink_rcv_msg+0x73f/0xcf0 net/core/rtnetlink.c:6647
> >  netlink_rcv_skb+0x1e3/0x430 net/netlink/af_netlink.c:2550
> >
> > Fixes: ff4e538c8c3e ("page_pool: add a lockdep check for recycling in h=
ardirq")
> > Reported-by: syzbot+f56a5c5eac2b28439810@syzkaller.appspotmail.com
> > Closes: https://lore.kernel.org/netdev/671e10df.050a0220.2b8c0f.01cf.GA=
E@google.com/T/
> > Signed-off-by: Eric Dumazet <edumazet@google.com>
> > Cc: Jason Wang <jasowang@redhat.com>
> > Cc: Michael S. Tsirkin <mst@redhat.com>
>
>
> Acked-by: Michael S. Tsirkin <mst@redhat.com>
>

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks


