Return-Path: <netdev+bounces-80013-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4817787C772
	for <lists+netdev@lfdr.de>; Fri, 15 Mar 2024 03:23:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3ED621C20899
	for <lists+netdev@lfdr.de>; Fri, 15 Mar 2024 02:23:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30ED16FB1;
	Fri, 15 Mar 2024 02:23:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mtimcoJd"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62211612E
	for <netdev@vger.kernel.org>; Fri, 15 Mar 2024 02:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710469413; cv=none; b=gI9iaA4mqQ0rTMuQGkpdkfSeVlwHcqAeYJHgDnz9e7orQ0AECRFIbWnKhpnrRNIG/GXTokqRV0WCqOC/oFQbZlkyjk4WG+kWcf8u7z0TdDFWczz67Lbwi9yMl/qZYNTxY9/LBdmhXr4zNIJ11mbUMh8a7PrLEZ/RhD3+bl7z2mw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710469413; c=relaxed/simple;
	bh=v26r+iWkQ3ZsI3Kdcl6Qqdxz6+Hc5s0Q9UXwUlL0DGI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tNInsw9ja7gg0mAQ/V5LZiwQpFcPHa3YX1CIrD0dByrj8oxIPxRlGOW2ag/oVMfTKyPtlGujm9SXhiYyaaFS881/7101hM7IRF9ogXQ/3NBSEIBqUyO4lha2FtLnMbLjmNClPJV/NtQj++YM3qWmPh1LT+gPwZ4oUr8VEQdpJsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mtimcoJd; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a449c5411e1so204047766b.1
        for <netdev@vger.kernel.org>; Thu, 14 Mar 2024 19:23:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710469409; x=1711074209; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SfnLMHFmgZCHu++QT09RzkmR1d7aMpSwbkxA0B3D3jU=;
        b=mtimcoJdO3RQiZs1atVc53y3PVCwJFVgw3KM5pbEW6tVYGMclujaaUdu4vcA69c3Gx
         GYwQ6nT68QFPUy1+Yhm4hl06UOlgq/A+lnS79a7gH1pDBjsqQ92UWnx2mk3/vf3GlUFu
         NUNKBjF4e0WtpIinF6/mBZFkCzdzeh/LYfjZmI3JXKXTk5PpOqn9Y11kpR59DwdzSJTB
         b+52efDBPkNgwBsVdpE1bPes6wrZNi9ldh66aU2sd8v6Z+/a/hPYG1WZyIDQYngp7ZJI
         5tLqeaW9pBGE3BR7P0YcIoIIKBDMPvGRElUlojB+sD4keETtBIABWGM82+2d0NuiWzbf
         6jkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710469409; x=1711074209;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SfnLMHFmgZCHu++QT09RzkmR1d7aMpSwbkxA0B3D3jU=;
        b=VH3SN4hhxgpbdTh60rL6kKnqlmtCEySBS3e20zkY30flZUE2hoEsHzvz4HHmUGv3Zj
         Hal0EyBtmhGK2uvL6v2OmwNOm+xy4yvjtROJ5VDblwFSmDz928/dHkGXkpLtmdzFd4zT
         YemkRCLA2hy9XVRex7QrjHYg0P56gZlWhZW1AUe6xnS/rHJ7wTJjvR4BWNyP1VlRFx8W
         j+Tp89B/x1gHixekL7VFnfuZHPskDw6ZmksdLDaTIPCa665enGYuW1hWGfVhaxMWMYk5
         rJjp7sd8LbJVLFYh8re5wcXLDyK2sqr1E7m+FIx43YRSDwCX4oIreKr7zfLxVKk/bErH
         85Cw==
X-Forwarded-Encrypted: i=1; AJvYcCXB4wkU2hOUMdG0H15gHVHQZaohaXTu3oAo1mto9cB8yl1hU+Kz9mg6exFmrFWUy0mciISr2Uz0svAwfoEXJPOa+hdUXwoH
X-Gm-Message-State: AOJu0YxqbGGs4u9rfb2nXhv1vHwT7uYppWP/3UKfA20Bwk+Zr0OvrMzU
	kndwd3LJY0fIiSnwJGMi70DM/j2vHm+otMgh+FbLKP10Nct0PM4XGBSRz6+T6lfqx/zPwUhRmfD
	+UtBITtQRSednkHQ7YYF94WZNh6U=
X-Google-Smtp-Source: AGHT+IFU64CZXLY6h9ycVETCBlkgsMJC91lYnZcpq1OVKSLNK0kDw1Q+bANMM4u/ki4e4Gdo7znnsK3Lpqf3sCxoSF8=
X-Received: by 2002:a17:906:f118:b0:a46:5597:596a with SMTP id
 gv24-20020a170906f11800b00a465597596amr2303673ejb.45.1710469408693; Thu, 14
 Mar 2024 19:23:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240314141816.2640229-1-edumazet@google.com>
In-Reply-To: <20240314141816.2640229-1-edumazet@google.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Fri, 15 Mar 2024 10:22:51 +0800
Message-ID: <CAL+tcoCzSc2YONPuwgC7f9ogKVndHzUcX9PMizgHHQ=1wqChKw@mail.gmail.com>
Subject: Re: [PATCH net] packet: annotate data-races around ignore_outgoing
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	syzbot+c669c1136495a2e7c31f@syzkaller.appspotmail.com, 
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 14, 2024 at 10:18=E2=80=AFPM Eric Dumazet <edumazet@google.com>=
 wrote:
>
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
>  batadv_iv_send_outstanding_bat_ogm_packet+0x3f0/0x4b0 net/batman-adv/bat=
_iv_ogm.c:1700
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
> CPU: 1 PID: 27 Comm: kworker/u8:1 Tainted: G        W          6.8.0-syzk=
aller-08073-g480e035fc4c7 #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS G=
oogle 02/29/2024
> Workqueue: bat_events batadv_iv_send_outstanding_bat_ogm_packet
>
> Fixes: fa788d986a3a ("packet: add sockopt to ignore outgoing packets")
> Reported-by: syzbot+c669c1136495a2e7c31f@syzkaller.appspotmail.com
> Closes: https://lore.kernel.org/netdev/CANn89i+Z7MfbkBLOv=3Dp7KZ7=3DK1rKH=
O4P1OL5LYDCtBiyqsa9oQ@mail.gmail.com/T/#t
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>

Reviewed-by: Jason Xing <kerneljasonxing@gmail.com>

Thanks!

