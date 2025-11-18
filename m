Return-Path: <netdev+bounces-239748-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 510A7C6C0FD
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 00:58:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sto.lore.kernel.org (Postfix) with ESMTPS id A245F28D26
	for <lists+netdev@lfdr.de>; Tue, 18 Nov 2025 23:58:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB31530DEB5;
	Tue, 18 Nov 2025 23:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ftUxuC6o"
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f169.google.com (mail-il1-f169.google.com [209.85.166.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 479522F5A06
	for <netdev@vger.kernel.org>; Tue, 18 Nov 2025 23:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763510299; cv=none; b=t3tIdiVmeLZapFf6q7crPrfzCbZDiDvngfltCiz9YKwvC/h2d5oKtWaHzCQksYOxMVREAJYzM+oPjenxTg2G8igzdCkLrtbNrGcgkv9tXk6RfKMFLaDwdIalXK5te2HM279Ry3Xes4hkQeEaF6voc3yBsEC5tPP3Rme2O32gsiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763510299; c=relaxed/simple;
	bh=5tAJ47zFX9gz4T5fxNzGCe+6WWdu2i3qxuI/jP/4N1I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=m6U/R5HLN2tGaYvinUWbKxmAisZ9x6ZWfc6bIsDZ+Ai0MCW69MMiElPL/MzBaFgL12GnsPQq3dSzxwvWyJg+d9EVif1irS6z8r32RpY0aI19Jx1bNNUxFLqUqJLykzqoptB+bOa1vMx43+DakxNr73aZlMoU6cKwzr0ZB2knJRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ftUxuC6o; arc=none smtp.client-ip=209.85.166.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f169.google.com with SMTP id e9e14a558f8ab-4332ae0635fso35359075ab.2
        for <netdev@vger.kernel.org>; Tue, 18 Nov 2025 15:58:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763510297; x=1764115097; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TkiZ64UoXtSYnpib+9rP2k6ThWKW/fjaVzr954J/GZM=;
        b=ftUxuC6ooqOZRjh+ay8U1YbxtYkYHBIjBiCdtj/0TDm+aSYgly9uOkN252Yl4vckA9
         R2ASMiDmvsbss0oZyogopmkeuxUvuW08Bu7P316vKQ+WR+8ob9TwKKpi+MisNQ1IWmrY
         1DR4VGuoMjjMLtosXHT/Tsr2Ym2RMcUHVpvNLJWY7otRvixk5CIVsMgETFzM0qJ/rA7J
         EPdaOLzBbUC07lZASkEY6jc9d50AZ0nMQXaI+GQjUCIdfGQI8ubp86AyLQYVGTxwqsoT
         JTIRqCqVzxBt+d57G+Hh926m7O6eIevDuUERc4dX9mfM/XKTC+lGFko94L+5Rpkcth0h
         O7kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763510297; x=1764115097;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=TkiZ64UoXtSYnpib+9rP2k6ThWKW/fjaVzr954J/GZM=;
        b=t7/GgYt+hwNM985WsIw46f14PhBxUVGD9bmY/V9dhv5rjdyz198ryL99AxwnqzPaA9
         y2JCsfzN+LD6mW5xy9QGbcONyZYAapsrG6g0nKMZYATMwFceI8c9xhRcopnqrHpSav4K
         moI+v75p34DG1aMRHo4Ez/c++ZVEmTXcu8eirLUrscTi/AyU2f4541aVJWq1qbDFlZyv
         KqjbrxLZyDf6RYLY/9meTxVaYIWV0h1frWTy7v4fCI+kOYIxsUua4hxuk8wgu+WeSbp6
         vxoZ8M7JHKBaXmK9xcCUBXal+FrM7Vb7/0x+VgBkM3oJeKRfQh5k1jjcgtccCkbCofO2
         Ix8g==
X-Gm-Message-State: AOJu0Ywy+aYnYJ45/M8JlYAsBmDvtgxaK7MHur3qH53yRAHSCIgsV46D
	t/NOzVBYU4CZP+VJd8R+KRXYMG06SfrkCQ83xS4bZsAvcVb99Wc2JPLqYovqWA/5HAkixka+lsg
	DaJJRV6j5mYO/C6K4H3panpfpzysWhws=
X-Gm-Gg: ASbGncv/jw80Coks+S/8mv7hP/P4hhH4ECgyly/PklDA2nCyrC8Sj2txyiSIF/xyiss
	fOel6cm7px85LjW+vnu5IXUcdAqUGcl3yNaOGI9KSVxfkgEkxgjzIu6pR5VTVgq5wtl8L1/liav
	d1jrQoeZxwZ/tCasFCSL1/iObdsTK5ht6qxw/nnehbeBQdsKGKo/SJxJ1HKML7IX35UqbTjNVR8
	o1ibhn6zU5yM0/NTZYMramQ5lasJraCYSCB31tKfEXIt0jEhYUPRI+PG+Pz7/8T/+7YzSMPH+M7
	1GTmrc4p
X-Google-Smtp-Source: AGHT+IFmS29CWrYRvyTbb+W6jFmSNhlfiJEhPBeIs7q7jfCV8ZsklmhdIHu9x+VAEuR+6bDrfr76UBgawkuziMV5gRo=
X-Received: by 2002:a05:6e02:148e:b0:433:5b75:64d6 with SMTP id
 e9e14a558f8ab-4348c93733fmr246677525ab.28.1763510297319; Tue, 18 Nov 2025
 15:58:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251118124807.3229-1-fmancera@suse.de>
In-Reply-To: <20251118124807.3229-1-fmancera@suse.de>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Wed, 19 Nov 2025 07:57:41 +0800
X-Gm-Features: AWmQ_bm-Gjj0eMYFUANQsCSI1iXAT4Hke8358FyYhOIi2eiNrUtc1r9YMzcq6NQ
Message-ID: <CAL+tcoCGP8crix=NWca9PBMF4z9NAXKJu8kyTdKanb3n7JEpWQ@mail.gmail.com>
Subject: Re: [PATCH net v4] xsk: avoid data corruption on cq descriptor number
To: Fernando Fernandez Mancera <fmancera@suse.de>
Cc: netdev@vger.kernel.org, csmate@nop.hu, maciej.fijalkowski@intel.com, 
	bpf@vger.kernel.org, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 18, 2025 at 8:48=E2=80=AFPM Fernando Fernandez Mancera
<fmancera@suse.de> wrote:
>
> Since commit 30f241fcf52a ("xsk: Fix immature cq descriptor
> production"), the descriptor number is stored in skb control block and
> xsk_cq_submit_addr_locked() relies on it to put the umem addrs onto
> pool's completion queue.
>
> skb control block shouldn't be used for this purpose as after transmit
> xsk doesn't have control over it and other subsystems could use it. This
> leads to the following kernel panic due to a NULL pointer dereference.
>
>  BUG: kernel NULL pointer dereference, address: 0000000000000000
>  #PF: supervisor read access in kernel mode
>  #PF: error_code(0x0000) - not-present page
>  PGD 0 P4D 0
>  Oops: Oops: 0000 [#1] SMP NOPTI
>  CPU: 2 UID: 1 PID: 927 Comm: p4xsk.bin Not tainted 6.16.12+deb14-cloud-a=
md64 #1 PREEMPT(lazy)  Debian 6.16.12-1
>  Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.17.0-debia=
n-1.17.0-1 04/01/2014
>  RIP: 0010:xsk_destruct_skb+0xd0/0x180
>  [...]
>  Call Trace:
>   <IRQ>
>   ? napi_complete_done+0x7a/0x1a0
>   ip_rcv_core+0x1bb/0x340
>   ip_rcv+0x30/0x1f0
>   __netif_receive_skb_one_core+0x85/0xa0
>   process_backlog+0x87/0x130
>   __napi_poll+0x28/0x180
>   net_rx_action+0x339/0x420
>   handle_softirqs+0xdc/0x320
>   ? handle_edge_irq+0x90/0x1e0
>   do_softirq.part.0+0x3b/0x60
>   </IRQ>
>   <TASK>
>   __local_bh_enable_ip+0x60/0x70
>   __dev_direct_xmit+0x14e/0x1f0
>   __xsk_generic_xmit+0x482/0xb70
>   ? __remove_hrtimer+0x41/0xa0
>   ? __xsk_generic_xmit+0x51/0xb70
>   ? _raw_spin_unlock_irqrestore+0xe/0x40
>   xsk_sendmsg+0xda/0x1c0
>   __sys_sendto+0x1ee/0x200
>   __x64_sys_sendto+0x24/0x30
>   do_syscall_64+0x84/0x2f0
>   ? __pfx_pollwake+0x10/0x10
>   ? __rseq_handle_notify_resume+0xad/0x4c0
>   ? restore_fpregs_from_fpstate+0x3c/0x90
>   ? switch_fpu_return+0x5b/0xe0
>   ? do_syscall_64+0x204/0x2f0
>   ? do_syscall_64+0x204/0x2f0
>   ? do_syscall_64+0x204/0x2f0
>   entry_SYSCALL_64_after_hwframe+0x76/0x7e
>   </TASK>
>  [...]
>  Kernel panic - not syncing: Fatal exception in interrupt
>  Kernel Offset: 0x1c000000 from 0xffffffff81000000 (relocation range: 0xf=
fffffff80000000-0xffffffffbfffffff)
>
> Instead use the skb destructor_arg pointer along with pointer tagging.
> As pointers are always aligned to 8B, use the bottom bit to indicate
> whether this a single address or an allocated struct containing several
> addresses.
>
> Fixes: 30f241fcf52a ("xsk: Fix immature cq descriptor production")
> Closes: https://lore.kernel.org/netdev/0435b904-f44f-48f8-afb0-68868474bf=
1c@nop.hu/
> Suggested-by: Jakub Kicinski <kuba@kernel.org>
> Signed-off-by: Fernando Fernandez Mancera <fmancera@suse.de>

Reviewed-by: Jason Xing <kerneljasonxing@gmail.com>

Thanks for your effort and the fix!

