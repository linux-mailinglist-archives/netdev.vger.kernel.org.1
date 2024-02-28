Return-Path: <netdev+bounces-75566-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 71D5386A912
	for <lists+netdev@lfdr.de>; Wed, 28 Feb 2024 08:39:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A34C11C21438
	for <lists+netdev@lfdr.de>; Wed, 28 Feb 2024 07:39:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3679E24B35;
	Wed, 28 Feb 2024 07:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="FxmlMaKe"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C80C52262B
	for <netdev@vger.kernel.org>; Wed, 28 Feb 2024 07:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709105953; cv=none; b=XxXS/zVtRnWgFfymiHBpzDiiYKUjEf49D/Aldati+n/4hQd74YFh6u7KjnesbyxCyz2PPcpXlRRwR/KN7Qz7WX9VZ5e+PTNveRjWUpGDOHG9SxCgYyHrJ8FnlPZ4GSFgvh3abz/a6acim00vNW+qb5YcqweP51ODhzhJGkxuOvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709105953; c=relaxed/simple;
	bh=UyGHYrMf74qUCiBfJvfFMOlkYy6vUBLnmcAZmNA/jS8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z60+9vb3dDnDDYL87jHhkvsRGM8nU6v64xHsZHG7392CqSi3M7UpUzvJg29OQRYnSBtKciSoevGd3LtX3noD4X6kWbhh5hhfbfQUtDKpkl3aFOJZcVoyO4+Zkg6TbFt/zz4C7zm5VMaOAUpvKXBix9TaCpID8pE1iydAenSTWRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=FxmlMaKe; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-412a9457b2eso3078435e9.1
        for <netdev@vger.kernel.org>; Tue, 27 Feb 2024 23:39:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1709105948; x=1709710748; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=sFsADf7mwY3cDNi1jerXIRz7jnZBOhNsw1I6vPZgIvE=;
        b=FxmlMaKeIvATFOa5kwLbn+fwMkIx+t+Bdpv4PKSUa/VcZNEkNOk/OiQQZlK0l3W1Dh
         PV/6cxwWYeF0AZmzN4qlImcxSPz8IJWo++1rLOf7d2NFk44fqaRn9jmjYZ1IEwgUky7l
         U+JWW/nwhQEt0ufiAS+EYtvCZSLAcjTy2vCaNWYqUEF7rmu3ZU2jm7so0MS0Twfljdld
         3/2YlQf2nQv7i0gV3+cKZLuFhJ8daks/VGNoj6HbwAkoLmLKKYsmK2qrTly1kGOMAcTI
         +gc31CtM8GOuzrzFJkalTLxDq3ZQlNrFsdFR40hYGa1GTUc0XT6mTdCTn/RJPAE6Gnnh
         Q8hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709105948; x=1709710748;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sFsADf7mwY3cDNi1jerXIRz7jnZBOhNsw1I6vPZgIvE=;
        b=Fln1hPeIaI6dkUdyGW2wkXkYEHAI1yzC7Rll2nVgZve9xcGM5oaRDlTzh8yv0DLjwY
         /JtERfyKe/NjReCYTuDl/4eOzj/VcQFRtrASfMLjvFML9Rv3nSk7r7/9OVMWObLXLsB9
         Bdw32Bn+LKeshRDmTxDVSM2MqDr8UZwFmUYqmdKwfVL/H3do4ZRtwVERFYQplsfROSSC
         p/EJmUWiy+QWdlPNnpyddGwHQ1o5DiVZTZefWWBQRvyhgIiqsZ5akWlRrluwMML2Ux+J
         q/3tx7n9nnbeNfSoDiLHDPm6Zw2am7Sb4PnllRpm9QNzA4VUrlApPVVjcvcSg4Om3p9H
         zp9w==
X-Forwarded-Encrypted: i=1; AJvYcCV/KmSCuLeYWLwyq312e+d3q1ITsPdm/FtyvXy+i97C/2ko7dmZHzZ1uqZdzlB5TWXFIg+gkyzVkEUBPLhgLm9YqpaS7h8A
X-Gm-Message-State: AOJu0YzRCbYd5a16jl+v90v7KCrUi/qWbOFELM6COb9MtHYSL+jmcsGd
	C7y9E6JldVqXpCzdotpYC3Av2sIhUs+KzvfYyARj1ITIjABKHDmRbidkPQEpNkI=
X-Google-Smtp-Source: AGHT+IGOiABdVQg0BDkgRqUsWlgtAJBYodlD248B1Ft4dU843W+c+RJwmdSu6WUXhI7nzjtTxqpcoA==
X-Received: by 2002:a05:600c:1d04:b0:412:b659:1ac9 with SMTP id l4-20020a05600c1d0400b00412b6591ac9mr267940wms.11.1709105947855;
        Tue, 27 Feb 2024 23:39:07 -0800 (PST)
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id k7-20020a05600c0b4700b004128936b9a9sm1168900wmr.33.2024.02.27.23.39.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Feb 2024 23:39:07 -0800 (PST)
Date: Wed, 28 Feb 2024 08:39:03 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, eric.dumazet@gmail.com,
	syzbot <syzkaller@googlegroups.com>, Jiri Pirko <jiri@nvidia.com>
Subject: Re: [PATCH net-next] inet6: expand rcu_read_lock() scope in
 inet6_dump_addr()
Message-ID: <Zd7jF8hfApfqLitR@nanopsycho>
References: <20240227222259.4081489-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240227222259.4081489-1-edumazet@google.com>

Tue, Feb 27, 2024 at 11:22:59PM CET, edumazet@google.com wrote:
>I missed that inet6_dump_addr() is calling in6_dump_addrs()
>from two points.
>
>First one under RTNL protection, and second one under rcu_read_lock().
>
>Since we want to remove RTNL use from inet6_dump_addr() very soon,
>no longer assume in6_dump_addrs() is protected by RTNL (even
>if this is still the case).
>
>Use rcu_read_lock() earlier to fix this lockdep splat:
>
>WARNING: suspicious RCU usage
>6.8.0-rc5-syzkaller-01618-gf8cbf6bde4c8 #0 Not tainted
>
>net/ipv6/addrconf.c:5317 suspicious rcu_dereference_check() usage!
>
>other info that might help us debug this:
>
>rcu_scheduler_active = 2, debug_locks = 1
>3 locks held by syz-executor.2/8834:
>  #0: ffff88802f554678 (nlk_cb_mutex-ROUTE){+.+.}-{3:3}, at: __netlink_dump_start+0x119/0x780 net/netlink/af_netlink.c:2338
>  #1: ffffffff8f377a88 (rtnl_mutex){+.+.}-{3:3}, at: netlink_dump+0x676/0xda0 net/netlink/af_netlink.c:2265
>  #2: ffff88807e5f0580 (&ndev->lock){++--}-{2:2}, at: in6_dump_addrs+0xb8/0x1de0 net/ipv6/addrconf.c:5279
>
>stack backtrace:
>CPU: 1 PID: 8834 Comm: syz-executor.2 Not tainted 6.8.0-rc5-syzkaller-01618-gf8cbf6bde4c8 #0
>Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/25/2024
>Call Trace:
> <TASK>
>  __dump_stack lib/dump_stack.c:88 [inline]
>  dump_stack_lvl+0x1e7/0x2e0 lib/dump_stack.c:106
>  lockdep_rcu_suspicious+0x220/0x340 kernel/locking/lockdep.c:6712
>  in6_dump_addrs+0x1b47/0x1de0 net/ipv6/addrconf.c:5317
>  inet6_dump_addr+0x1597/0x1690 net/ipv6/addrconf.c:5428
>  netlink_dump+0x6a6/0xda0 net/netlink/af_netlink.c:2266
>  __netlink_dump_start+0x59d/0x780 net/netlink/af_netlink.c:2374
>  netlink_dump_start include/linux/netlink.h:340 [inline]
>  rtnetlink_rcv_msg+0xcf7/0x10d0 net/core/rtnetlink.c:6555
>  netlink_rcv_skb+0x1e3/0x430 net/netlink/af_netlink.c:2547
>  netlink_unicast_kernel net/netlink/af_netlink.c:1335 [inline]
>  netlink_unicast+0x7ea/0x980 net/netlink/af_netlink.c:1361
>  netlink_sendmsg+0x8e0/0xcb0 net/netlink/af_netlink.c:1902
>  sock_sendmsg_nosec net/socket.c:730 [inline]
>  __sock_sendmsg+0x221/0x270 net/socket.c:745
>  ____sys_sendmsg+0x525/0x7d0 net/socket.c:2584
>  ___sys_sendmsg net/socket.c:2638 [inline]
>  __sys_sendmsg+0x2b0/0x3a0 net/socket.c:2667
>
>Fixes: c3718936ec47 ("ipv6: anycast: complete RCU handling of struct ifacaddr6")
>Reported-by: syzbot <syzkaller@googlegroups.com>
>Signed-off-by: Eric Dumazet <edumazet@google.com>
>Cc: Jiri Pirko <jiri@nvidia.com>

Reviewed-by: Jiri Pirko <jiri@nvidia.com>

