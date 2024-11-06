Return-Path: <netdev+bounces-142429-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C1459BF131
	for <lists+netdev@lfdr.de>; Wed,  6 Nov 2024 16:08:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D765C1F213F2
	for <lists+netdev@lfdr.de>; Wed,  6 Nov 2024 15:08:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69D151D2B0E;
	Wed,  6 Nov 2024 15:08:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="OQLhH/xI"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 363C0537FF
	for <netdev@vger.kernel.org>; Wed,  6 Nov 2024 15:07:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730905680; cv=none; b=cJJPABZq30HBrTi1O094gGqZgjcbDGbX8bhgOL0G6ZteiLrk/6iRhkFnD35lQO9BWtkThlMabIq2TmebtEEcviWNcrAvtqq+bmFNc2WE98PeGyunK+hsoRpJrmWNStRVA8Mz9g/jixA+L/lCzpqeEmKGm5859ubuEp4TMyczPUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730905680; c=relaxed/simple;
	bh=0z5tQUuPXjx+7Mm7V0/OSfjz/UUoQR+/SK+mNxAlst4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MybpBgrSwyFR9K+vM637xtIDmbfRQFc2bEGu97EVloIwiDL2Vv/nZKUUEjyAjqwCBIrlEVUwpoJnyVyvLkYSIKeUOai/CYEAx7UEkGX6DAC6qqFkdAEHHOFDisRaLpG0lCbfe99wTk86QkPZyd8BRbplQpinJE2nFQFm8rGQb1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=OQLhH/xI; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-37d4fd00574so614666f8f.0
        for <netdev@vger.kernel.org>; Wed, 06 Nov 2024 07:07:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1730905676; x=1731510476; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=K1JGLn+I0muETck4MPfnGCHwPdxSptnZQHaq9iGkKjo=;
        b=OQLhH/xIPxO+VJgiB4+bRB3yY+sMUAj0hn6J2QltEC17SDLZhVxUPOnyLvahGiaX0o
         duGXjdH02xpvpVQpEkAozseVva8wCdCdnVCVfJfxvOcNtdneab3Ed+davgy04yLtTGub
         Df/g4GoSonoCFhU60+6ITKeIp+NL7+2XZn+Nn4CakCyVc0CQAa7fea57OD4ndLHVvMVh
         Pt67wbhwXRBhdwhCgFUYBVa0osHSU6oKIT8ny4GVOY0g2E8ykAq4HbjaMSNzbcNCs5sX
         bnlMLZbZEn0HHEqoEQcBiT6SEn9CM5imKm8RrRro+G4tJSMxUDQc0t0mufc4Q8lHuTVP
         fZjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730905676; x=1731510476;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K1JGLn+I0muETck4MPfnGCHwPdxSptnZQHaq9iGkKjo=;
        b=rMCz7I1UaZ1SvNHYMyOKNXxBvyIZftkg04Lmke/Z3vyrf6tHRHJhYW46XEcl6akdMm
         aBFoPKLOx5PWqI97f1NMSox0UHYUoPjwFn57oEHeAurLhahi97GFaCCs6UWoyiF3lT2q
         VaOfgTQ7OVwqBfXgm2N48OdtNTmtRZJIzg62YYjq3Vk1YEEyZ4CG8tIqNdQUxnNxvr75
         xiULgtyL5Nrj8Sgu9vknkZKDt7rNsjZ9pSbi6PEdLr+Ndxw12f0hF32SZAXhX2F8eamE
         vrna5nybWloyrBhh4fvXmVvrzloY/IT2Afy3JTIMYuSivX+jJxWyoQQqR2qHvqj+Nocg
         519A==
X-Forwarded-Encrypted: i=1; AJvYcCXrKOLA9dJUBstfzgD3alINsspxc/Vcgml/+yJeLQCSxag6GBfs+Ei0H2LKCEYZ7JZcrAmwbQ4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3Ezlye6UHu3JdwKrspGDK0E9R825oGJXH7CpEm1VvUha+ageQ
	Dc4s02O3SCWIv6coRjoeDqhtXQETJl9EPytAVh6uDHxaERIFf/F/A143i/LF7kA=
X-Google-Smtp-Source: AGHT+IE1WNkSe98ta6YBltHzfP9R6dwtd1rS9a5Kq2H1F53dWfEyfE3S9uScQ8pnHLudhvBjeBKfQA==
X-Received: by 2002:a5d:5f8d:0:b0:37d:47ef:17d0 with SMTP id ffacd0b85a97d-381e81cfb52mr2304289f8f.13.1730905676020;
        Wed, 06 Nov 2024 07:07:56 -0800 (PST)
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-381c10b7f80sm19435982f8f.20.2024.11.06.07.07.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Nov 2024 07:07:55 -0800 (PST)
Date: Wed, 6 Nov 2024 16:07:51 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, eric.dumazet@gmail.com,
	syzbot <syzkaller@googlegroups.com>,
	Kuniyuki Iwashima <kuniyu@amazon.com>,
	Remi Denis-Courmont <courmisch@gmail.com>
Subject: Re: [PATCH v3 net-next] phonet: do not call synchronize_rcu() from
 phonet_route_del()
Message-ID: <ZyuGR3Nfs8v84eKe@nanopsycho.orion>
References: <20241106131818.1240710-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241106131818.1240710-1-edumazet@google.com>

Wed, Nov 06, 2024 at 02:18:17PM CET, edumazet@google.com wrote:
>Calling synchronize_rcu() while holding rcu_read_lock() is not
>permitted [1]
>
>Move the synchronize_rcu() + dev_put() to route_doit().
>
>Alternative would be to not use rcu_read_lock() in route_doit().
>
>[1]
>WARNING: suspicious RCU usage
>6.12.0-rc5-syzkaller-01056-gf07a6e6ceb05 #0 Not tainted
>-----------------------------
>kernel/rcu/tree.c:4092 Illegal synchronize_rcu() in RCU read-side critical section!
>
>other info that might help us debug this:
>
>rcu_scheduler_active = 2, debug_locks = 1
>1 lock held by syz-executor427/5840:
>  #0: ffffffff8e937da0 (rcu_read_lock){....}-{1:2}, at: rcu_lock_acquire include/linux/rcupdate.h:337 [inline]
>  #0: ffffffff8e937da0 (rcu_read_lock){....}-{1:2}, at: rcu_read_lock include/linux/rcupdate.h:849 [inline]
>  #0: ffffffff8e937da0 (rcu_read_lock){....}-{1:2}, at: route_doit+0x3d6/0x640 net/phonet/pn_netlink.c:264
>
>stack backtrace:
>CPU: 1 UID: 0 PID: 5840 Comm: syz-executor427 Not tainted 6.12.0-rc5-syzkaller-01056-gf07a6e6ceb05 #0
>Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
>Call Trace:
> <TASK>
>  __dump_stack lib/dump_stack.c:94 [inline]
>  dump_stack_lvl+0x241/0x360 lib/dump_stack.c:120
>  lockdep_rcu_suspicious+0x226/0x340 kernel/locking/lockdep.c:6821
>  synchronize_rcu+0xea/0x360 kernel/rcu/tree.c:4089
>  phonet_route_del+0xc6/0x140 net/phonet/pn_dev.c:409
>  route_doit+0x514/0x640 net/phonet/pn_netlink.c:275
>  rtnetlink_rcv_msg+0x791/0xcf0 net/core/rtnetlink.c:6790
>  netlink_rcv_skb+0x1e3/0x430 net/netlink/af_netlink.c:2551
>  netlink_unicast_kernel net/netlink/af_netlink.c:1331 [inline]
>  netlink_unicast+0x7f6/0x990 net/netlink/af_netlink.c:1357
>  netlink_sendmsg+0x8e4/0xcb0 net/netlink/af_netlink.c:1901
>  sock_sendmsg_nosec net/socket.c:729 [inline]
>  __sock_sendmsg+0x221/0x270 net/socket.c:744
>  sock_write_iter+0x2d7/0x3f0 net/socket.c:1165
>  new_sync_write fs/read_write.c:590 [inline]
>  vfs_write+0xaeb/0xd30 fs/read_write.c:683
>  ksys_write+0x183/0x2b0 fs/read_write.c:736
>  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>  do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
> entry_SYSCALL_64_after_hwframe+0x77/0x7f
>
>Fixes: 17a1ac0018ae ("phonet: Don't hold RTNL for route_doit().")
>Reported-by: syzbot <syzkaller@googlegroups.com>
>Signed-off-by: Eric Dumazet <edumazet@google.com>
>Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>

Reviewed-by: Jiri Pirko <jiri@nvidia.com>

