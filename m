Return-Path: <netdev+bounces-177165-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 18EBAA6E224
	for <lists+netdev@lfdr.de>; Mon, 24 Mar 2025 19:19:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 65A533AAD42
	for <lists+netdev@lfdr.de>; Mon, 24 Mar 2025 18:18:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38121263F5E;
	Mon, 24 Mar 2025 18:18:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Iea+g5ZJ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9497036124
	for <netdev@vger.kernel.org>; Mon, 24 Mar 2025 18:18:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742840338; cv=none; b=ZmPXfs4H80GZHrbHjwKF9cWrjtTgLiF7GdODd6dDULz/TATPMhR2heYLM1OHfxGxQynp2WTmKdVZfGaGwBtWah3qU8Arsx8LJhtLR4CGW9vr5hT5TmC/MbFagJQ0EQtlnuPfSW2Rpz6lVRpv9a0FKoYqdeRArpM6uZ8n08X0CT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742840338; c=relaxed/simple;
	bh=Oet08YhqaGIfvKNTw9AhgDelMP5s1Im6Kirwk0e6JOQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ri02eYzOiZGau9wjiwEFFgAHP1styY+XZ2FiDFOv3qKMkxHz+NISgQsZt46kIrqUkb9dm7e8FdAJX6A4lk9quewTunUIu/yUEnCXtdentiucplfACgfk8liaZHhJJFE94iOQypLnmW7uj6NVB5aRArwAiWBm6DFio1cP8OZPlrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Iea+g5ZJ; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-22580c9ee0aso93454975ad.2
        for <netdev@vger.kernel.org>; Mon, 24 Mar 2025 11:18:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742840336; x=1743445136; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ZgC8fwu7mJQlJlpDF7HtghwWhX5YJ2iky7pFEBfUwpM=;
        b=Iea+g5ZJPjZoNRYIoNgI89Q8bGAQ5+KyyRwHmpA9vKRkChZpFNrDI7UpMaoLvKpfad
         52B25+9k5VDWvpoIBvmLXPWms2hywua/Lfqazbc8biSpYCFEyYIMWcjjbl+J5sIOyxVE
         +Zgmc5H7LaUQcK5JPlhBZgvj04Gow8BYYUIDmhXozzi3KtvpeBgMoaZ87Bem7qp3Fk5E
         M8JhfYQnlDm464etponfKFMsZv+1CqH4LPDUgnXkYvo9PCHUsCfhv6gR61gptSSfqo+6
         0y10hbo48HYGuVPityxKN28mTMNDe04I+sktWBUJ2illEKze4CBpfMx6C9V/S9n+k95T
         IR8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742840336; x=1743445136;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZgC8fwu7mJQlJlpDF7HtghwWhX5YJ2iky7pFEBfUwpM=;
        b=lKReG6+vz8ctISdyvlyzhcwZUSnTcbGYFP9amh0YUW5x8yIRYR/rDSDdSCJdmUq3Dv
         choCXs9Zu5XF0aLhEzLSwnXzLZegV8WM/W6MYv2yKIcMqQAn2DQ7dKVay45b0YRRmgmj
         6ciLvQpeU8lncbDn7gTjn4eqMw5hTYdtQCEFA5Hg+d0pfQ8VCot4OOZjXJ4QykXu6S3s
         nc2hb5kE5eUg/my7eKHLu1T8nm8RKV10ou7t9+w0H5CWMm4qgFkhC7JRSgN/7NfkcF7V
         l/OcsK2XWZGV3WTI/Rlq8MVmwqH/xJEjTyNft/kGw/nKS0Rpo5g9XOLLnYUtmj7dJesa
         0Nfw==
X-Forwarded-Encrypted: i=1; AJvYcCVZguFKGtDz/MM4a4LyN3Z4TNJwM4s5ygz+b2hTfkIABwmg8QeSPGNVTnn+aaMHxXQaBR3EmaM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwdwLjju1cJZ5QETF6YTOOvwI1qo4HunU9rlOI6b3k4GCLtZjQU
	mYpMgsueFDdf0kKZeYy8g8N32rYhg+fg62ktXD568xEHTez7iQM=
X-Gm-Gg: ASbGncup9nz5hBoYfisFY0WIbLZQDuuYWpLEHgT+qtBqRvvZ6m5+avITqQIdoeif7tv
	5HoSYPzkNZ85gIDuuN8Uw/i94tjal6hiQEBr6YleBo4w6wvfDr14TADo/OfLcvq9g/z6D5vK1cR
	lLobwkdvzrBNfj8q6n3z86oy7DL2TZFy6ihw3EDueMbjNFAWY+fbsR7UYeeKWi/BfWvqhpeO/K9
	fjF/AWNfmggCBxl947jtsoAm+IHovW8lgYcQIQ1TgqODnqJXTgfuPJsSWPyUC8hY+o5CTFTC9fj
	5mBG+63ZF6sh9yQPIgj8PgOx2Es+eWsasksmDiTU80ah
X-Google-Smtp-Source: AGHT+IHqfjUS/iThtV2NNiLDHpvmqULyTYdRDNiqZo5q7GQLCa5TSsMeI8ibjoY2TxquXl8ib/0Jsg==
X-Received: by 2002:a17:903:22c7:b0:223:3630:cd32 with SMTP id d9443c01a7336-22780e44f87mr205761835ad.53.1742840335417;
        Mon, 24 Mar 2025 11:18:55 -0700 (PDT)
Received: from localhost ([2601:646:9e00:f56e:123b:cea3:439a:b3e3])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-22780f45e0fsm74124525ad.74.2025.03.24.11.18.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Mar 2025 11:18:54 -0700 (PDT)
Date: Mon, 24 Mar 2025 11:18:54 -0700
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Cosmin Ratiu <cratiu@nvidia.com>
Cc: "pabeni@redhat.com" <pabeni@redhat.com>,
	"kuba@kernel.org" <kuba@kernel.org>,
	"edumazet@google.com" <edumazet@google.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"saeed@kernel.org" <saeed@kernel.org>,
	"sdf@fomichev.me" <sdf@fomichev.me>,
	"davem@davemloft.net" <davem@davemloft.net>
Subject: Re: [PATCH net-next v10 08/14] net: hold netdev instance lock during
 sysfs operations
Message-ID: <Z-GiDo7wWJ4zFEmt@mini-arch>
References: <20250305163732.2766420-1-sdf@fomichev.me>
 <20250305163732.2766420-9-sdf@fomichev.me>
 <700fa36b94cbd57cfea2622029b087643c80cbc9.camel@nvidia.com>
 <Z-GDBlDsnPyc21RM@mini-arch>
 <8e5bf1dffe7c5ae2191e9082dcd0f72469b4fc0b.camel@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8e5bf1dffe7c5ae2191e9082dcd0f72469b4fc0b.camel@nvidia.com>

On 03/24, Cosmin Ratiu wrote:
> On Mon, 2025-03-24 at 09:06 -0700, Stanislav Fomichev wrote:
> > On 03/24, Cosmin Ratiu wrote:
> > > Call Trace:
> > > dump_stack_lvl+0x62/0x90
> > > print_deadlock_bug+0x274/0x3b0
> > > __lock_acquire+0x1229/0x2470
> > > lock_acquire+0xb7/0x2b0
> > > __mutex_lock+0xa6/0xd20
> > > dev_disable_lro+0x20/0x80
> > > inetdev_init+0x12f/0x1f0
> > > inetdev_event+0x48b/0x870
> > > notifier_call_chain+0x38/0xf0
> > > netif_change_net_namespace+0x72e/0x9f0
> > > do_setlink.isra.0+0xd5/0x1220
> > > rtnl_newlink+0x7ea/0xb50
> > > rtnetlink_rcv_msg+0x459/0x5e0
> > > netlink_rcv_skb+0x54/0x100
> > > netlink_unicast+0x193/0x270
> > > netlink_sendmsg+0x204/0x450
> > 
> > I think something like the patch below should fix it? inetdev_init is
> > called for blackhole (sw device, we don't care about ops lock) and
> > from
> > REGISTER/UNREGISTER notifiers. We hold the lock during REGISTER,
> > and will soon hold the lock during UNREGISTER:
> > https://lore.kernel.org/netdev/20250312223507.805719-9-kuba@kernel.org/
> > 
> > (might also need to EXPORT_SYM netif_disable_lro)
> > 
> > diff --git a/net/ipv4/devinet.c b/net/ipv4/devinet.c
> > index 754f60fb6e25..77e5705ac799 100644
> > --- a/net/ipv4/devinet.c
> > +++ b/net/ipv4/devinet.c
> > @@ -281,7 +281,7 @@ static struct in_device *inetdev_init(struct
> > net_device *dev)
> >  	if (!in_dev->arp_parms)
> >  		goto out_kfree;
> >  	if (IPV4_DEVCONF(in_dev->cnf, FORWARDING))
> > -		dev_disable_lro(dev);
> > +		netif_disable_lro(dev);
> >  	/* Reference in_dev->dev */
> >  	netdev_hold(dev, &in_dev->dev_tracker, GFP_KERNEL);
> >  	/* Account for reference dev->ip_ptr (below) */
> 
> Unfortunately, this seems to result, on another code path, in:
> WARNING: CPU: 10 PID: 1479 at ./include/net/netdev_lock.h:54
> __netdev_update_features+0x65f/0xca0
> __warn+0x81/0x180
> __netdev_update_features+0x65f/0xca0
> report_bug+0x156/0x180
> handle_bug+0x4f/0x90
> exc_invalid_op+0x13/0x60
> asm_exc_invalid_op+0x16/0x20
> __netdev_update_features+0x65f/0xca0
> netif_disable_lro+0x30/0x1d0
> inetdev_init+0x12f/0x1f0
> inetdev_event+0x48b/0x870
> notifier_call_chain+0x38/0xf0
> register_netdevice+0x741/0x8b0
> register_netdev+0x1f/0x40
> mlx5e_probe+0x4e3/0x8e0 [mlx5_core]
> auxiliary_bus_probe+0x3f/0x90
> really_probe+0xc3/0x3a0
> __driver_probe_device+0x80/0x150
> driver_probe_device+0x1f/0x90
> __device_attach_driver+0x7d/0x100
> bus_for_each_drv+0x80/0xd0
> __device_attach+0xb4/0x1c0
> bus_probe_device+0x91/0xa0
> device_add+0x657/0x870
> 
> I see register_netdevice briefly acquires the netdev lock in two
> separate blocks and has a __netdev_update_features call in one of the
> blocks, but the lock is not held for
> call_netdevice_notifiers(NETDEV_REGISTER, dev).

Ok, so we might need to also try to run NETDEV_REGISTER hooks
consistently under the instance lock. This might bring more surprises,
but I don't see any other easy option. Will test it out locally...

diff --git a/net/core/dev.c b/net/core/dev.c
index f29c1368c304..d672d521b92a 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -1815,7 +1815,9 @@ static int call_netdevice_register_notifiers(struct notifier_block *nb,
 {
 	int err;
 
+	netdev_lock_ops(dev);
 	err = call_netdevice_notifier(nb, NETDEV_REGISTER, dev);
+	netdev_unlock_ops(dev);
 	err = notifier_to_errno(err);
 	if (err)
 		return err;
@@ -11014,7 +11016,9 @@ int register_netdevice(struct net_device *dev)
 		memcpy(dev->perm_addr, dev->dev_addr, dev->addr_len);
 
 	/* Notify protocols, that a new device appeared. */
+	netdev_lock_ops(dev);
 	ret = call_netdevice_notifiers(NETDEV_REGISTER, dev);
+	netdev_unlock_ops(dev);
 	ret = notifier_to_errno(ret);
 	if (ret) {
 		/* Expect explicit free_netdev() on failure */
@@ -12036,6 +12040,7 @@ int netif_change_net_namespace(struct net_device *dev, struct net *net,
 	int err, new_nsid;
 
 	ASSERT_RTNL();
+	netdev_ops_assert_locked(dev);
 
 	/* Don't allow namespace local devices to be moved. */
 	err = -EINVAL;

