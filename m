Return-Path: <netdev+bounces-79909-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 96E5087C065
	for <lists+netdev@lfdr.de>; Thu, 14 Mar 2024 16:36:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BBA601C20C19
	for <lists+netdev@lfdr.de>; Thu, 14 Mar 2024 15:36:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCB5073532;
	Thu, 14 Mar 2024 15:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZjoBcKp2"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2779A7175B
	for <netdev@vger.kernel.org>; Thu, 14 Mar 2024 15:33:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710430430; cv=none; b=ftvK4o8CPm1QNNCp28APC9ks2U0LQGhg3Z/SFjfZbDGg+hyfwlEWkGPfAnjZB8NP4CQ7aUKRyw3zSPPw9JDqJhZQmbgL0P0Y6KGB/pKhbw3glCU/f/kgFYlr3KIS/1aX1AnTVoQWsQ4uu14NZ2+LTMvnnqpBY0jyz4SWzFE7YBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710430430; c=relaxed/simple;
	bh=8CHQLlYKOEH7+re8etQ3ezRPCim6YS834e/EOPacqU8=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=ZCNwkqSQYgCXKL3xrG8eWBBVyvU6xsEngNn9oFKm/D1oCBrcIsoBmjjT475IjQK0cQ3+grU4+FxGZ4dLHHAU1gb4vxSvY8l1OfXqxtaZZCz2xKLQFoWBRqfTiLCWBcvnd/0aBhU4B6r+bB76hzwgw+o+pSo6Q97aOelAcAumWic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZjoBcKp2; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-78848933458so49726885a.1
        for <netdev@vger.kernel.org>; Thu, 14 Mar 2024 08:33:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710430428; x=1711035228; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HUaCeSSILlYZXbBOem507vj1pNd6fa6cZJEJwa4SmpY=;
        b=ZjoBcKp22Ec1q7dXZGoeb7QcLzCHJDL1se6Xb5/nAaL2dti6JoyDhXGavREOxrOWqr
         bQOt+U2bCI7I0VD92JeHOfKKaixCIUS9IZh6w9CNk/gSIE+XvRudqJP5u3FZ1Bbei7ll
         5eFeSnviEFP2quL8YQ/bZcvgUJOyUGzt7Dd8DOlZ61rIF9bdIJbIUl5KAo96RLLjql09
         CcYYQ7fjg73qodJvJeDo6aeuRwpqegr9N8Sv77+DvX3TNvWnfx8lDRGPqZGPcMtKQP0N
         lIXQe+A9QMtiilIbK6g0r+WAP+IpHExL86EvnZI9oKFVETjJ09O1Ri/meSHWWiLyx5GW
         Ujkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710430428; x=1711035228;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=HUaCeSSILlYZXbBOem507vj1pNd6fa6cZJEJwa4SmpY=;
        b=DZJ83vbzcY4zDC56f0rThPt9F0p6aBIWO1LPyCAh3MxcGymrQv0LKOmZOhCKDc+zwt
         uzdvy8zalw/ZTviLgRwOy8nngFsSmvf3VVuYkK2E05TjeTL+tJlzqgOcULuTu72O2hHF
         A3jDW9GQl438zSKdIBYicjA5ZXimY07RW8483dKVxT5TKQbx98ldEJE/Mc1uq941njGc
         KGmUhkkqpu4B5yjB2DlE7k2EFOzBi8p7o53qulId5kk1pAIwOTfrWytoybaIrCRf9+14
         C3mwaRIhUPed35023ZfpYQaOrjS2z/nxDjVuIOQAqZRs96YJbW4AIBDdYBSaHxN0VVZb
         8jcA==
X-Gm-Message-State: AOJu0Ywsvrw396D4NPMTkCwpnV9ZGHv8zK/S06y+p7a2vOcv+ZHaPR+4
	56A9l1ni/EWyXvEaFFqcewDIK1qqg9sBtZnjSflHBUZ7taiOe9UZ
X-Google-Smtp-Source: AGHT+IGBbY2BWNYEkO+GGKQA6+0nKt3p4lMSdhtb6C+RdvVvOdFjInHOSr9g307Ou5fXV7hSPfzFkw==
X-Received: by 2002:ad4:4e14:0:b0:691:5bcd:6326 with SMTP id dl20-20020ad44e14000000b006915bcd6326mr1136388qvb.53.1710430427964;
        Thu, 14 Mar 2024 08:33:47 -0700 (PDT)
Received: from localhost (55.87.194.35.bc.googleusercontent.com. [35.194.87.55])
        by smtp.gmail.com with ESMTPSA id jx5-20020a0562142b0500b0068f4520e42dsm591743qvb.16.2024.03.14.08.33.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Mar 2024 08:33:47 -0700 (PDT)
Date: Thu, 14 Mar 2024 11:33:47 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Eric Dumazet <edumazet@google.com>, 
 "David S . Miller" <davem@davemloft.net>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, 
 eric.dumazet@gmail.com, 
 Eric Dumazet <edumazet@google.com>, 
 syzbot+c669c1136495a2e7c31f@syzkaller.appspotmail.com, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Message-ID: <65f318db70f3f_3f8f5b2945b@willemb.c.googlers.com.notmuch>
In-Reply-To: <20240314141816.2640229-1-edumazet@google.com>
References: <20240314141816.2640229-1-edumazet@google.com>
Subject: Re: [PATCH net] packet: annotate data-races around ignore_outgoing
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Eric Dumazet wrote:
> ignore_outgoing is read locklessly from dev_queue_xmit_nit()
> and packet_getsockopt()
> 
> Add appropriate READ_ONCE()/WRITE_ONCE() annotations.
> 
> syzbot reported:
> 
> BUG: KCSAN: data-race in dev_queue_xmit_nit / packet_setsockopt
> 
> write to 0xffff888107804542 of 1 bytes by task 22618 on cpu 0:
>  packet_setsockopt+0xd83/0xfd0 net/packet/af_packet.c:4003
>  do_sock_setsockopt net/socket.c:2311 [inline]
>  __sys_setsockopt+0x1d8/0x250 net/socket.c:2334
>  __do_sys_setsockopt net/socket.c:2343 [inline]
>  __se_sys_setsockopt net/socket.c:2340 [inline]
>  __x64_sys_setsockopt+0x66/0x80 net/socket.c:2340
>  do_syscall_64+0xd3/0x1d0
>  entry_SYSCALL_64_after_hwframe+0x6d/0x75
> 
> read to 0xffff888107804542 of 1 bytes by task 27 on cpu 1:
>  dev_queue_xmit_nit+0x82/0x620 net/core/dev.c:2248
>  xmit_one net/core/dev.c:3527 [inline]
>  dev_hard_start_xmit+0xcc/0x3f0 net/core/dev.c:3547
>  __dev_queue_xmit+0xf24/0x1dd0 net/core/dev.c:4335
>  dev_queue_xmit include/linux/netdevice.h:3091 [inline]
>  batadv_send_skb_packet+0x264/0x300 net/batman-adv/send.c:108
>  batadv_send_broadcast_skb+0x24/0x30 net/batman-adv/send.c:127
>  batadv_iv_ogm_send_to_if net/batman-adv/bat_iv_ogm.c:392 [inline]
>  batadv_iv_ogm_emit net/batman-adv/bat_iv_ogm.c:420 [inline]
>  batadv_iv_send_outstanding_bat_ogm_packet+0x3f0/0x4b0 net/batman-adv/bat_iv_ogm.c:1700
>  process_one_work kernel/workqueue.c:3254 [inline]
>  process_scheduled_works+0x465/0x990 kernel/workqueue.c:3335
>  worker_thread+0x526/0x730 kernel/workqueue.c:3416
>  kthread+0x1d1/0x210 kernel/kthread.c:388
>  ret_from_fork+0x4b/0x60 arch/x86/kernel/process.c:147
>  ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:243
> 
> value changed: 0x00 -> 0x01
> 
> Reported by Kernel Concurrency Sanitizer on:
> CPU: 1 PID: 27 Comm: kworker/u8:1 Tainted: G        W          6.8.0-syzkaller-08073-g480e035fc4c7 #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 02/29/2024
> Workqueue: bat_events batadv_iv_send_outstanding_bat_ogm_packet
> 
> Fixes: fa788d986a3a ("packet: add sockopt to ignore outgoing packets")
> Reported-by: syzbot+c669c1136495a2e7c31f@syzkaller.appspotmail.com
> Closes: https://lore.kernel.org/netdev/CANn89i+Z7MfbkBLOv=p7KZ7=K1rKHO4P1OL5LYDCtBiyqsa9oQ@mail.gmail.com/T/#t
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
> ---
>  net/core/dev.c         | 2 +-
>  net/packet/af_packet.c | 4 ++--
>  2 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/net/core/dev.c b/net/core/dev.c
> index 0766a245816bdf70f6609dc7b6d694ae81e7a9e5..722787c3275527f1652ec98623f61500ee753b45 100644
> --- a/net/core/dev.c
> +++ b/net/core/dev.c
> @@ -2245,7 +2245,7 @@ void dev_queue_xmit_nit(struct sk_buff *skb, struct net_device *dev)
>  	rcu_read_lock();
>  again:
>  	list_for_each_entry_rcu(ptype, ptype_list, list) {
> -		if (ptype->ignore_outgoing)
> +		if (READ_ONCE(ptype->ignore_outgoing))
>  			continue;
>  
>  		/* Never send packets back to the socket
> diff --git a/net/packet/af_packet.c b/net/packet/af_packet.c
> index 61270826b9ac73e66f9011c3230d4668f0bf7c77..7cfc7d301508fcead214fbdb4e962b0553a17916 100644
> --- a/net/packet/af_packet.c
> +++ b/net/packet/af_packet.c
> @@ -4000,7 +4000,7 @@ packet_setsockopt(struct socket *sock, int level, int optname, sockptr_t optval,
>  		if (val < 0 || val > 1)
>  			return -EINVAL;
>  
> -		po->prot_hook.ignore_outgoing = !!val;
> +		WRITE_ONCE(po->prot_hook.ignore_outgoing, !!val);

Should we also include a WRITE_ONCE on the fanout prot_hook:

        match->prot_hook.ignore_outgoing = type_flags & PACKET_FANOUT_FLAG_IGNORE_OUTGOING;

>  		return 0;
>  	}
>  	case PACKET_TX_HAS_OFF:
> @@ -4134,7 +4134,7 @@ static int packet_getsockopt(struct socket *sock, int level, int optname,
>  		       0);
>  		break;
>  	case PACKET_IGNORE_OUTGOING:
> -		val = po->prot_hook.ignore_outgoing;
> +		val = READ_ONCE(po->prot_hook.ignore_outgoing);
>  		break;
>  	case PACKET_ROLLOVER_STATS:
>  		if (!po->rollover)
> -- 
> 2.44.0.278.ge034bb2e1d-goog
> 



