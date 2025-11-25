Return-Path: <netdev+bounces-241523-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E9071C84ED7
	for <lists+netdev@lfdr.de>; Tue, 25 Nov 2025 13:12:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A7E0C4E5C59
	for <lists+netdev@lfdr.de>; Tue, 25 Nov 2025 12:12:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3CD531A565;
	Tue, 25 Nov 2025 12:12:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gi4UB975"
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f175.google.com (mail-il1-f175.google.com [209.85.166.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 150B2318136
	for <netdev@vger.kernel.org>; Tue, 25 Nov 2025 12:12:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764072736; cv=none; b=H7BIuEsfnrhj6htty1rTERhUWo1/Yb0rZpYSdCFLZaPJdD7A/wO0TMfxhDsoDd84UyC/KqU/v2ykM4IaQGKGik4yIqxqwc6qkSdGa7NYh8Qd4gpm5o10OXGXbPAh0MiPO/O6WnIwv277dRsdW708pJ/hdUPLRA77JxzbW47wELY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764072736; c=relaxed/simple;
	bh=pev9ogNPYVU30rfQsJXKVeBgv7VxCsPTlgbqVP+huIY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Sg7gh0oCuqeAAgLDo0HCgJnyollP1CA/OG9f2XwNacpGGHucUxPj2SHQmhAdYJ0YBzX5weoA+TyF0E7DVFVteoAJrRMOh4vh2nUlnCsom5F7YJOB2ERRMiTh5/cGW5r76Wbk5W8g9zyTXdX2es/5zvqtSeG72nsad+o5RMC+sPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Gi4UB975; arc=none smtp.client-ip=209.85.166.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f175.google.com with SMTP id e9e14a558f8ab-43326c74911so29606285ab.2
        for <netdev@vger.kernel.org>; Tue, 25 Nov 2025 04:12:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764072734; x=1764677534; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZFtGiYxAvztdvwpf+MLgwEOytCgQ2niLK9bm/oK5tVo=;
        b=Gi4UB975dVOFqyxhSTAWaSPBIYznJF7joWAs/DYsI4S2UytuN0HLmK4+7Fx0LkN5ja
         HoFfDMeK0X4vLvkO9KQte3aNqA09B5D4C1BmTkR+cf4eYZYbpVPiSN9TD0/CMVIVeJGh
         ClQwMSBCFrqHepE9Tu69LGTeiptAj8qNlEbTOwoZR3h0lE0Our5g8sRjiGiz9FYa5KRt
         GcrIZrYMzULjGfASKtnBqElsH2TBXxFHnLxW6ZjXbIVVNIR0aqxpy5SAByD8kVMyDTZ9
         r+H1WKzgQi2G1ED1qGka3fQKDTAhKqD5KCSOZyhOEr4fZ+qNCfw8/A+/YuwmSsPgXTe1
         sxsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764072734; x=1764677534;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ZFtGiYxAvztdvwpf+MLgwEOytCgQ2niLK9bm/oK5tVo=;
        b=dmxOn1eYgNE2d0XQvn6BWe300EjECp5epALtHp8TSnE0Twjs8iWaliVOOJNnR+ClVO
         mS00dIDDZgvMNJof9LMi0eTCanYwnwxFUzVETgiR4jES7v8n0G6WJJsfAWDUSQeuE+iB
         IQl/PhYDVRhiDn4JktQG5Uq4MrHDAx8QDWyoyVMNpm/7kQGeDYQWcwR29guX0tiWOybT
         qQ2OGUCYb0rht+3g5Y5tOQKT7atzw+e2yLU3ZjI59s4qYS8/MLhDHmF4Mb4oGgi6pZVZ
         /IAfHODCJNEwgG96m3+3nTw/57NPIW7dBtnR4Y0vgDI4tsBXr4LIwwJ1tgvUVD11Le5X
         VdFA==
X-Gm-Message-State: AOJu0Yyjnxdyd4psJlXDzxf0hWBZPgcdAp/Ic8aZiahLef03xvQR37Vx
	1srBx4P/w+HMhCqN1nt1j7S6Aii/y7O3ZybzyqCokp+Mgqf640rwl/nEpD8Y9ERKZjKYgxlanMr
	80fSADA/oLMVprl5s3r8vl/aQy5/c5YU=
X-Gm-Gg: ASbGnctMACW9v47eUlnZnB/kiU0HMPmvtHVYpEYAOJg8Yl5mPIkj64Ta5wVZAh8ZnW6
	rmXaY2PfwtWotXL00N2tRAz0WYAl7EeV7lQ+f0mmxF0KUd85BdFaVuT1hUIvmVM/nMKEukO43DN
	qItDwn3qXuuO2axWOr0Pjl2G1ikgI4E4dh0p7DeI+0HSsWshDu1xEZUkDQtNRyYCBR2TUwVkiwT
	yaZPnEH8s7J1RUfkunsXpKrPQ7ze4MVODjrLroBgZbMSF+7AjaC34dsqBjXCTzdhED/TeI=
X-Google-Smtp-Source: AGHT+IFj50pWIo6x5iCQL08OOz4JENSFrXwvUdhMVT4I2H6EXAl4ZY2y8JgFZGEiS+8jGITLJJzEYSEaFZzZOXGMqI4=
X-Received: by 2002:a05:6e02:2684:b0:433:2660:6856 with SMTP id
 e9e14a558f8ab-435dd10563amr23401685ab.31.1764072733966; Tue, 25 Nov 2025
 04:12:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251124171409.3845-1-fmancera@suse.de> <CAL+tcoBKMfVnTtkwBRk9JBGbJtahyJVt4g8swsYRUk1b97LgHQ@mail.gmail.com>
 <955e2de1-32f6-42e3-8358-b8574188ce62@suse.de>
In-Reply-To: <955e2de1-32f6-42e3-8358-b8574188ce62@suse.de>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Tue, 25 Nov 2025 20:11:37 +0800
X-Gm-Features: AWmQ_bn1HqKxmeMumWdZt2g7hzanQzrhSdI8BQoNsUxohGD9VNYG0HAYg4asP_E
Message-ID: <CAL+tcoD83=UXpDaLZZFU2_EDKJS9ew2njLmoH9xeXcg5+E3UDQ@mail.gmail.com>
Subject: Re: [PATCH net v6] xsk: avoid data corruption on cq descriptor number
To: Fernando Fernandez Mancera <fmancera@suse.de>
Cc: netdev@vger.kernel.org, csmate@nop.hu, maciej.fijalkowski@intel.com, 
	bpf@vger.kernel.org, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, sdf@fomichev.me, 
	hawk@kernel.org, daniel@iogearbox.net, ast@kernel.org, 
	john.fastabend@gmail.com, magnus.karlsson@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 25, 2025 at 7:40=E2=80=AFPM Fernando Fernandez Mancera
<fmancera@suse.de> wrote:
>
> On 11/25/25 12:41 AM, Jason Xing wrote:
> > On Tue, Nov 25, 2025 at 1:14=E2=80=AFAM Fernando Fernandez Mancera
> > <fmancera@suse.de> wrote:
> >>
> >> Since commit 30f241fcf52a ("xsk: Fix immature cq descriptor
> >> production"), the descriptor number is stored in skb control block and
> >> xsk_cq_submit_addr_locked() relies on it to put the umem addrs onto
> >> pool's completion queue.
> >>
> >> skb control block shouldn't be used for this purpose as after transmit
> >> xsk doesn't have control over it and other subsystems could use it. Th=
is
> >> leads to the following kernel panic due to a NULL pointer dereference.
> >>
> >>   BUG: kernel NULL pointer dereference, address: 0000000000000000
> >>   #PF: supervisor read access in kernel mode
> >>   #PF: error_code(0x0000) - not-present page
> >>   PGD 0 P4D 0
> >>   Oops: Oops: 0000 [#1] SMP NOPTI
> >>   CPU: 2 UID: 1 PID: 927 Comm: p4xsk.bin Not tainted 6.16.12+deb14-clo=
ud-amd64 #1 PREEMPT(lazy)  Debian 6.16.12-1
> >>   Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.17.0-d=
ebian-1.17.0-1 04/01/2014
> >>   RIP: 0010:xsk_destruct_skb+0xd0/0x180
> >>   [...]
> >>   Call Trace:
> >>    <IRQ>
> >>    ? napi_complete_done+0x7a/0x1a0
> >>    ip_rcv_core+0x1bb/0x340
> >>    ip_rcv+0x30/0x1f0
> >>    __netif_receive_skb_one_core+0x85/0xa0
> >>    process_backlog+0x87/0x130
> >>    __napi_poll+0x28/0x180
> >>    net_rx_action+0x339/0x420
> >>    handle_softirqs+0xdc/0x320
> >>    ? handle_edge_irq+0x90/0x1e0
> >>    do_softirq.part.0+0x3b/0x60
> >>    </IRQ>
> >>    <TASK>
> >>    __local_bh_enable_ip+0x60/0x70
> >>    __dev_direct_xmit+0x14e/0x1f0
> >>    __xsk_generic_xmit+0x482/0xb70
> >>    ? __remove_hrtimer+0x41/0xa0
> >>    ? __xsk_generic_xmit+0x51/0xb70
> >>    ? _raw_spin_unlock_irqrestore+0xe/0x40
> >>    xsk_sendmsg+0xda/0x1c0
> >>    __sys_sendto+0x1ee/0x200
> >>    __x64_sys_sendto+0x24/0x30
> >>    do_syscall_64+0x84/0x2f0
> >>    ? __pfx_pollwake+0x10/0x10
> >>    ? __rseq_handle_notify_resume+0xad/0x4c0
> >>    ? restore_fpregs_from_fpstate+0x3c/0x90
> >>    ? switch_fpu_return+0x5b/0xe0
> >>    ? do_syscall_64+0x204/0x2f0
> >>    ? do_syscall_64+0x204/0x2f0
> >>    ? do_syscall_64+0x204/0x2f0
> >>    entry_SYSCALL_64_after_hwframe+0x76/0x7e
> >>    </TASK>
> >>   [...]
> >>   Kernel panic - not syncing: Fatal exception in interrupt
> >>   Kernel Offset: 0x1c000000 from 0xffffffff81000000 (relocation range:=
 0xffffffff80000000-0xffffffffbfffffff)
> >>
> >> Instead use the skb destructor_arg pointer along with pointer tagging.
> >> As pointers are always aligned to 8B, use the bottom bit to indicate
> >> whether this a single address or an allocated struct containing severa=
l
> >> addresses.
> >>
> >> Fixes: 30f241fcf52a ("xsk: Fix immature cq descriptor production")
> >> Closes: https://lore.kernel.org/netdev/0435b904-f44f-48f8-afb0-6886847=
4bf1c@nop.hu/
> >> Suggested-by: Jakub Kicinski <kuba@kernel.org>
> >> Signed-off-by: Fernando Fernandez Mancera <fmancera@suse.de>
> >
> > Reviewed-by: Jason Xing <kerneljasonxing@gmail.com>
> >
> > Could you also post a patch on top of net-next as it has diverged from
> > the net tree?
> >
>
> I think that is handled by maintainers when merging the branches. A
> repost would be wrong because linux-next.git and linux.git will have a
> different variant of the same commit..

But this patch cannot be applied cleanly in the net-next tree...

>
> Please, let me know if I am wrong here.

I'm not quite sure either.

Thanks,
Jason

>
> Thanks,
> Fernando.

