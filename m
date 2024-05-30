Return-Path: <netdev+bounces-99359-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E6748D49B9
	for <lists+netdev@lfdr.de>; Thu, 30 May 2024 12:34:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 596291F23ED7
	for <lists+netdev@lfdr.de>; Thu, 30 May 2024 10:34:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B118176AD8;
	Thu, 30 May 2024 10:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RupBH0Zb"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66D04183965
	for <netdev@vger.kernel.org>; Thu, 30 May 2024 10:34:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717065287; cv=none; b=Hb7LsPTl6W3lzJCUmObKMaRdsIGGdxj5nnthOWUbliC/t8IKSX3vzJ6zyWpKNYN5CEw884BgyWmxEeKKhqfGYof9XOv+m01B1OK5vUF9UC2DzQBGTIEBLNWiXqQgBY9kNbOQ5h34O2UZWJ23Oh3SBuGpDFjyVo5ZGeWMt6LVByA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717065287; c=relaxed/simple;
	bh=ePmgCh8f6VP8cJpAjv3aRynpva2CXsinJUvR63f6q5I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NbjqLctyFCYJULg60Sw4eWPIjXWUP3iSSsear+SyrnzcHbY60GVDipEZRQCV8N2wxWa+h2lW7zbaICsT4XPmLdnxCNIXbPPfLUmbwWo+tNtelvhPakM7ZjYNhcXzjdvT7MG27xCFugo1B3LTWp43x4d2h6Zkuh0B9zwsI9b6m3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RupBH0Zb; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717065283;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mwLCS9VGdrJbwBiT7iSopRHZglWQyG9eLhkRIAFbkGQ=;
	b=RupBH0Zb3Er9jbf6eDVBQrDVqvXtRwAPAn6ZSKiMs68s4DbWSMO6+bqplbMmWodhxeO/h1
	Qnvql52YzrADWjT7U2V8qMbH1IUCBLnQG0dCMeggS2x32YUHgyeWG7/qM5oJXef0giBfhf
	U1uWPP2ve5ZVJnksoU+u3vk3KLQnU6g=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-473-W6nKbe0qN6eU0Ys2Zgfa_Q-1; Thu, 30 May 2024 06:34:42 -0400
X-MC-Unique: W6nKbe0qN6eU0Ys2Zgfa_Q-1
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-2bffbc8ad81so637647a91.2
        for <netdev@vger.kernel.org>; Thu, 30 May 2024 03:34:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717065281; x=1717670081;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mwLCS9VGdrJbwBiT7iSopRHZglWQyG9eLhkRIAFbkGQ=;
        b=Foi6D10moOBWvPk/JkjWOfCu1BWetDDj6AnvaAEql2ly6jWbLgn1TSTxNc8YV0wcqL
         XLIopZ0yVI0WQ7naJLsqKut5fMKnd0GrRr15lJ/Wu4169LXKkF9IqNdXCXrZiKWCMLXe
         6Y9XXtFbDhoShkyAuXuN9e+/T0qhmN/VCd3izOhbJPAV4+Nsy5lhH4/LWtZxrkbSAjpd
         b8c1rbEt/8uG6kJNxfzUeRuZiTKeD84W1FD6WfhiEkmKghbKKIsChCVUIa8ekSxAa92W
         vt8NzlD/Uo5qwKXE5FBc2Xl979YroKJJHgtx4Pfrx10oFuJYYtXO5KmQHvFaPRHNj+4p
         2VzQ==
X-Forwarded-Encrypted: i=1; AJvYcCWy5gJwWgbqUOC5CjIRAEyeNIVY1UxhldlqCrKdmhe8CJ2ykuZ9PJbGDZhsev5rbJHMmu6aSUgRsnTGgLr/XYT2P8Zib20R
X-Gm-Message-State: AOJu0YzQjOdGwNRu4vqqG5gVhV6w/nw+be4lerQR/FrbGSUgVYaWiwYi
	NS56wLbNIf6vkZbwQruKZPnRDFOxmD4aFKWXHW1nQRx43nEdlMNWxE/uiYAJq64T8OGr2UEdZfD
	miJKhjfzcPtzZxcL7TzkxysaEOkls/B1DRnQaCwm8N9NHPf4FS0gJr0oEex1qgpMMS37aWr0oSD
	aIWxNj9A+SzlY1GikPtcBXX7Qq70Qz
X-Received: by 2002:a17:90b:270b:b0:2bd:92d9:65ee with SMTP id 98e67ed59e1d1-2c1abc4d0d4mr1453145a91.45.1717065280947;
        Thu, 30 May 2024 03:34:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHk6+dfMQCKGwc1HtwekDNqHFptPdJqcRTcTRCLYqrYTDLlvOHyke+Y+SyRiGtLAEESjhX8MP2i+utCSG64urM=
X-Received: by 2002:a17:90b:270b:b0:2bd:92d9:65ee with SMTP id
 98e67ed59e1d1-2c1abc4d0d4mr1453124a91.45.1717065280528; Thu, 30 May 2024
 03:34:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240528134116.117426-1-hengqi@linux.alibaba.com>
 <20240528134116.117426-3-hengqi@linux.alibaba.com> <20240530051420-mutt-send-email-mst@kernel.org>
In-Reply-To: <20240530051420-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 30 May 2024 18:34:28 +0800
Message-ID: <CACGkMEswextPQ-Cf9uYxAqJg24FkrBRr_nXP+e9YpYCck8sjnA@mail.gmail.com>
Subject: Re: [PATCH net v3 2/2] virtio_net: fix a spurious deadlock issue
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Heng Qi <hengqi@linux.alibaba.com>, netdev@vger.kernel.org, 
	virtualization@lists.linux.dev, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Jiri Pirko <jiri@resnulli.us>, 
	Daniel Jurgens <danielj@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 30, 2024 at 5:17=E2=80=AFPM Michael S. Tsirkin <mst@redhat.com>=
 wrote:
>
> On Tue, May 28, 2024 at 09:41:16PM +0800, Heng Qi wrote:
> > When the following snippet is run, lockdep will report a deadlock[1].
> >
> >   /* Acquire all queues dim_locks */
> >   for (i =3D 0; i < vi->max_queue_pairs; i++)
> >           mutex_lock(&vi->rq[i].dim_lock);
> >
> > There's no deadlock here because the vq locks are always taken
> > in the same order, but lockdep can not figure it out. So refactoring
> > the code to alleviate the problem.
> >
> > [1]
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D
> > WARNING: possible recursive locking detected
> > 6.9.0-rc7+ #319 Not tainted
> > --------------------------------------------
> > ethtool/962 is trying to acquire lock:
> >
> > but task is already holding lock:
> >
> > other info that might help us debug this:
> > Possible unsafe locking scenario:
> >
> >       CPU0
> >       ----
> >  lock(&vi->rq[i].dim_lock);
> >  lock(&vi->rq[i].dim_lock);
> >
> > *** DEADLOCK ***
> >
> >  May be due to missing lock nesting notation
> >
> > 3 locks held by ethtool/962:
> >  #0: ffffffff82dbaab0 (cb_lock){++++}-{3:3}, at: genl_rcv+0x19/0x40
> >  #1: ffffffff82dad0a8 (rtnl_mutex){+.+.}-{3:3}, at:
> >                               ethnl_default_set_doit+0xbe/0x1e0
> >
> > stack backtrace:
> > CPU: 6 PID: 962 Comm: ethtool Not tainted 6.9.0-rc7+ #319
> > Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
> >          rel-1.16.0-0-gd239552ce722-prebuilt.qemu.org 04/01/2014
> > Call Trace:
> >  <TASK>
> >  dump_stack_lvl+0x79/0xb0
> >  check_deadlock+0x130/0x220
> >  __lock_acquire+0x861/0x990
> >  lock_acquire.part.0+0x72/0x1d0
> >  ? lock_acquire+0xf8/0x130
> >  __mutex_lock+0x71/0xd50
> >  virtnet_set_coalesce+0x151/0x190
> >  __ethnl_set_coalesce.isra.0+0x3f8/0x4d0
> >  ethnl_set_coalesce+0x34/0x90
> >  ethnl_default_set_doit+0xdd/0x1e0
> >  genl_family_rcv_msg_doit+0xdc/0x130
> >  genl_family_rcv_msg+0x154/0x230
> >  ? __pfx_ethnl_default_set_doit+0x10/0x10
> >  genl_rcv_msg+0x4b/0xa0
> >  ? __pfx_genl_rcv_msg+0x10/0x10
> >  netlink_rcv_skb+0x5a/0x110
> >  genl_rcv+0x28/0x40
> >  netlink_unicast+0x1af/0x280
> >  netlink_sendmsg+0x20e/0x460
> >  __sys_sendto+0x1fe/0x210
> >  ? find_held_lock+0x2b/0x80
> >  ? do_user_addr_fault+0x3a2/0x8a0
> >  ? __lock_release+0x5e/0x160
> >  ? do_user_addr_fault+0x3a2/0x8a0
> >  ? lock_release+0x72/0x140
> >  ? do_user_addr_fault+0x3a7/0x8a0
> >  __x64_sys_sendto+0x29/0x30
> >  do_syscall_64+0x78/0x180
> >  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> >
> > Fixes: 4d4ac2ececd3 ("virtio_net: Add a lock for per queue RX coalesce"=
)
> > Signed-off-by: Heng Qi <hengqi@linux.alibaba.com>
>
>
> Acked-by: Michael S. Tsirkin <mst@redhat.com>
>

Acked-by: Jason Wang <jasowang@redhat.com>

Btw, adding notation seems to be another way.

Thanks


