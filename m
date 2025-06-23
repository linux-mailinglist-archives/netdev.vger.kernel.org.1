Return-Path: <netdev+bounces-200291-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E806AE46EA
	for <lists+netdev@lfdr.de>; Mon, 23 Jun 2025 16:36:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7B392447A9B
	for <lists+netdev@lfdr.de>; Mon, 23 Jun 2025 14:22:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B206513D24D;
	Mon, 23 Jun 2025 14:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kxRMOb2c"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 256DC6EB79
	for <netdev@vger.kernel.org>; Mon, 23 Jun 2025 14:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750688597; cv=none; b=jbbe0/XvrXSzQQEC1Lo2RayKXx6Kx2TIk4m05N6QbZGGjbYTJzdP2qxseuGRn6+r/Nfmrqm8NoYYeaIPldH9Dcd212zJsCVk6ZoEUqZSsrg9hrPoZGJu7zUiHKg8VheWLF2w+3xf7SUziYY+ArZM/WUSkgqjOinvck5xNGO1eek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750688597; c=relaxed/simple;
	bh=lH4I8M0Ac7RtOw4MFWW0314w86IrUeRBtOXFClNFeBU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tLnQ0jEGI6VuVk9Xu6etfl61T6zhsmK7x9NeXUOeyXE+rcbnVdLHpNUaiQWTDw7n8G6RlNdcgug07KpwEtYkj2itXPu+A7P04HQK+W+fqVqun0WEkdvT0hhXYqeKzOmbFs53xKIqbBHjwdkv9P085BufrFyqQzrvf3OzQXAY56o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kxRMOb2c; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-7494999de5cso440876b3a.3
        for <netdev@vger.kernel.org>; Mon, 23 Jun 2025 07:23:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750688595; x=1751293395; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=RqCQ89b143dMEGwYOPwREBh+BtV1I1qFQk6i/4TN6Ag=;
        b=kxRMOb2cpMmMe2HEnHQEXGNXZxlqGqEeS/xNN3vKNeAe7ZM9ZTMSpq2YWx3+aEXCJ9
         8n+5y3tAX4TLQvOxrjQUKa0gqMUhTCY3pAVaO74SJfOKZsrkPtKT9VNwFDdEKwKoiyTa
         kktEZARomaaTRmX36TYG6YEFYmN+aZbplfRgFDz2XjdPP62DHPRmoCbk4FviqUqO9oU4
         xu5PcvFSl5efDtAUZ5y2F+q6vttg4tzb20GPDtfoiDgI+7z2xljsjUChTaKjQq/A+xoK
         3lhGShwKuj6panQCol2cgqURd/qdFK/6+2KD0pYHYj7WfAqFZEe3iYbarT6ZNNLGPPwW
         0pLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750688595; x=1751293395;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RqCQ89b143dMEGwYOPwREBh+BtV1I1qFQk6i/4TN6Ag=;
        b=xNRw7w2ezSWa6j5hkQVKBIdoM2mSqWA5JJSLborNTyGKuIgtOm20pvAa2jrapLYFIT
         gDRHh9l3ZQIX+zzMxPgPlAlCxZjUZVZnjvGqD2xnZOQqNKRxZNfbPqIWMYfDOQkvjziC
         0I73OBrNb3bN3FCNmjx5ILcMCG+Vwfr+AifsspKsCmEAR9y+2Q98SmobZ0H3E85ojnJw
         GKRO8mYWfNMN85Zxu23a2x/VMfaRBmSq73KKY55Q4DX4SAxfAA8v5OREAz2Pb+NlMj32
         09VM6fYBfpU7/+Lz9UT5/wOAPV6dpYhkrctNah6EClFUDLV3X8kQnTFchWb62E7xueop
         R1Uw==
X-Gm-Message-State: AOJu0YyQc4qu52amqmfjsqYLZnGdv5d2dzkC6swRtnEb21JcYyiLKgSW
	Ch8l5/D/IMi9AG20s0teZBKmRoKnkuogS+wugoFenhrIioRbMyNukRw=
X-Gm-Gg: ASbGncuX+GYVu7FsWLnBH4y5KonmdRQT4CDi1H3G4Tq23IejpA466T9KBG5g+puPBrO
	Ft358H6XaVmgbv+3bEAfEtfYG3pquRWepDnyR5AzrG3vf09CgS6qMaIjFTLDttKthxKIRCGXWJl
	ku2kL1GSClfYGDtUvnNSAaFIsnd1GS+Sbu6AwpsUOyz2pzOF69ZRb/OKhDPlD7d3nsoEiFDZ/J4
	Ck1tHpt8GXeMkhugmVuwstaej6iHBtU0YxWRSIUnVEtpV4ImZ8ddia8se1FFuywb9drflYCIuUW
	UsiHw0d+eN3eSjSyJGKxqb3P0a1xfj/5nCaSTULmRGuBfceLSkq8YMvKOEep+xZRtOM7UjHvYtZ
	qragEoAhbGEFT9Q7LPhyoK5c=
X-Google-Smtp-Source: AGHT+IFgod2kkc/NQBL5FyOdABM80PwwXQKTD9RUGCf628HczifIvAaS4SSslZz3gBrr5AYC15/6yA==
X-Received: by 2002:a05:6a21:6b16:b0:1f5:83bd:6cc1 with SMTP id adf61e73a8af0-22025e41e71mr20822675637.0.1750688595247;
        Mon, 23 Jun 2025 07:23:15 -0700 (PDT)
Received: from localhost (c-73-158-218-242.hsd1.ca.comcast.net. [73.158.218.242])
        by smtp.gmail.com with UTF8SMTPSA id 41be03b00d2f7-b31f1241efbsm8049856a12.36.2025.06.23.07.23.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Jun 2025 07:23:14 -0700 (PDT)
Date: Mon, 23 Jun 2025 07:23:13 -0700
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>
Subject: Re: [PATCH net-next] udp_tunnel: fix deadlock in
 udp_tunnel_nic_set_port_priv()
Message-ID: <aFljUZx1bgn5D9D7@mini-arch>
References: <95a827621ec78c12d1564ec3209e549774f9657d.1750675978.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <95a827621ec78c12d1564ec3209e549774f9657d.1750675978.git.pabeni@redhat.com>

On 06/23, Paolo Abeni wrote:
> While configuring a vxlan tunnel in a system with a i40e NIC driver, I
> observe the following deadlock:
> 
>  WARNING: possible recursive locking detected
>  6.16.0-rc2.net-next-6.16_92d87230d899+ #13 Tainted: G            E
>  --------------------------------------------
>  kworker/u256:4/1125 is trying to acquire lock:
>  ffff88921ab9c8c8 (&utn->lock){+.+.}-{4:4}, at: i40e_udp_tunnel_set_port (/home/pabeni/net-next/include/net/udp_tunnel.h:343 /home/pabeni/net-next/drivers/net/ethernet/intel/i40e/i40e_main.c:13013) i40e
> 
>  but task is already holding lock:
>  ffff88921ab9c8c8 (&utn->lock){+.+.}-{4:4}, at: udp_tunnel_nic_device_sync_work (/home/pabeni/net-next/net/ipv4/udp_tunnel_nic.c:739) udp_tunnel
> 
>  other info that might help us debug this:
>   Possible unsafe locking scenario:
> 
>         CPU0
>         ----
>    lock(&utn->lock);
>    lock(&utn->lock);
> 
>   *** DEADLOCK ***
> 
>   May be due to missing lock nesting notation
> 
>  4 locks held by kworker/u256:4/1125:
>  #0: ffff8892910ca158 ((wq_completion)udp_tunnel_nic){+.+.}-{0:0}, at: process_one_work (/home/pabeni/net-next/kernel/workqueue.c:3213)
>  #1: ffffc900244efd30 ((work_completion)(&utn->work)){+.+.}-{0:0}, at: process_one_work (/home/pabeni/net-next/kernel/workqueue.c:3214)
>  #2: ffffffff9a14e290 (rtnl_mutex){+.+.}-{4:4}, at: udp_tunnel_nic_device_sync_work (/home/pabeni/net-next/net/ipv4/udp_tunnel_nic.c:737) udp_tunnel
>  #3: ffff88921ab9c8c8 (&utn->lock){+.+.}-{4:4}, at: udp_tunnel_nic_device_sync_work (/home/pabeni/net-next/net/ipv4/udp_tunnel_nic.c:739) udp_tunnel
> 
>  stack backtrace:
>  Hardware name: Dell Inc. PowerEdge R7525/0YHMCJ, BIOS 2.2.5 04/08/2021
> i
>  Call Trace:
>   <TASK>
>  dump_stack_lvl (/home/pabeni/net-next/lib/dump_stack.c:123)
>  print_deadlock_bug (/home/pabeni/net-next/kernel/locking/lockdep.c:3047)
>  validate_chain (/home/pabeni/net-next/kernel/locking/lockdep.c:3901)
>  __lock_acquire (/home/pabeni/net-next/kernel/locking/lockdep.c:5240)
>  lock_acquire.part.0 (/home/pabeni/net-next/kernel/locking/lockdep.c:473 /home/pabeni/net-next/kernel/locking/lockdep.c:5873)
>  __mutex_lock (/home/pabeni/net-next/kernel/locking/mutex.c:604 /home/pabeni/net-next/kernel/locking/mutex.c:747)
>  i40e_udp_tunnel_set_port (/home/pabeni/net-next/include/net/udp_tunnel.h:343 /home/pabeni/net-next/drivers/net/ethernet/intel/i40e/i40e_main.c:13013) i40e
>  udp_tunnel_nic_device_sync_by_port (/home/pabeni/net-next/net/ipv4/udp_tunnel_nic.c:230 /home/pabeni/net-next/net/ipv4/udp_tunnel_nic.c:249) udp_tunnel
>  __udp_tunnel_nic_device_sync.part.0 (/home/pabeni/net-next/net/ipv4/udp_tunnel_nic.c:292) udp_tunnel
>  udp_tunnel_nic_device_sync_work (/home/pabeni/net-next/net/ipv4/udp_tunnel_nic.c:742) udp_tunnel
>  process_one_work (/home/pabeni/net-next/kernel/workqueue.c:3243)
>  worker_thread (/home/pabeni/net-next/kernel/workqueue.c:3315 /home/pabeni/net-next/kernel/workqueue.c:3402)
>  kthread (/home/pabeni/net-next/kernel/kthread.c:464)
> 
> AFAICS all the existing callsites of udp_tunnel_nic_set_port_priv() are
> already under the utn lock scope, avoid (re-)acquiring it in such a
> function.
> 
> Fixes: 1ead7501094c ("udp_tunnel: remove rtnl_lock dependency")
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>

Ouch, how did I miss that it's running from .set_port :-( Thanks!

Acked-by: Stanislav Fomichev <sdf@fomichev.me>

