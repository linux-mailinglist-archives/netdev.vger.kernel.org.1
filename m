Return-Path: <netdev+bounces-97781-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 35A5F8CD285
	for <lists+netdev@lfdr.de>; Thu, 23 May 2024 14:46:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EDCB8283D43
	for <lists+netdev@lfdr.de>; Thu, 23 May 2024 12:46:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 952421474BC;
	Thu, 23 May 2024 12:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=oddbit.com header.i=@oddbit.com header.b="KZGqXl3D"
X-Original-To: netdev@vger.kernel.org
Received: from smtp88.iad3a.emailsrvr.com (smtp88.iad3a.emailsrvr.com [173.203.187.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF0C1149E14
	for <netdev@vger.kernel.org>; Thu, 23 May 2024 12:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.203.187.88
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716468410; cv=none; b=d5Z01GpqsuO4RSbCOG6gwcbBHNZR459RL+XD7u10PhMnL2JewEN0vt40vDKl6qiSn4QoZcwhmMDKkBmFSrY5+fwuTZXGJNWKXx+fXT3oijtIiBDy0Ests6p30QaSJCEPp2YruiYWo5yrCcAKiRA/xNuUkcc3IBq/T052cVfBz1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716468410; c=relaxed/simple;
	bh=D+9CyojCG0QsdHiaLTmHpkJ9/iJKbWZ7oDwEFE14eHE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fTnJaeeV96O7NmHqdt5TmDkIoXzkK9XTEVXLWyUcRvhZW4AMoiIctqUJXdf1pekgWdqEa6tbN5PLkyxX+LY0ketID7kAwMK+b4MekdELjw0UZ9NPJODVMHCEc8PURPxCviJ7DdrE7lHRfZEHQQ6NWGyFd20okFhVJWHrHyBNUMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=oddbit.com; spf=pass smtp.mailfrom=oddbit.com; dkim=pass (1024-bit key) header.d=oddbit.com header.i=@oddbit.com header.b=KZGqXl3D; arc=none smtp.client-ip=173.203.187.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=oddbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oddbit.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=oddbit.com;
	s=20180920-g2b7aziw; t=1716467431;
	bh=D+9CyojCG0QsdHiaLTmHpkJ9/iJKbWZ7oDwEFE14eHE=;
	h=Date:From:To:Subject:From;
	b=KZGqXl3DYdYsQiRvMuirfdkI+85PAnGgWDiuOxM2lkZEPchN8opaMhXO9maTzqrsf
	 xd/9+TtwhcUY+0UTFGnjPDtikudW20T7w11S7WFtCiOnUcBQhbcYcGl91Y/qTHUCYz
	 8DybFiqqApc/aTJa9MYvD+hgSDBXf+OHdCKOD/y8=
X-Auth-ID: lars@oddbit.com
Received: by smtp28.relay.iad3a.emailsrvr.com (Authenticated sender: lars-AT-oddbit.com) with ESMTPSA id 5276651D3;
	Thu, 23 May 2024 08:30:31 -0400 (EDT)
Date: Thu, 23 May 2024 08:30:31 -0400
From: Lars Kellogg-Stedman <lars@oddbit.com>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Duoming Zhou <duoming@zju.edu.cn>, linux-hams@vger.kernel.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, pabeni@redhat.com, kuba@kernel.org, 
	edumazet@google.com, davem@davemloft.net, jreuter@yaina.de
Subject: Re: [PATCH net] ax25: Fix refcount leak issues of ax25_dev
Message-ID: <lglyhi7ptj6oeiqkd263dxb6pvvqpjipfu7mvs4tgsexk5fmoc@ekcfnsavpipe>
References: <20240501060218.32898-1-duoming@zju.edu.cn>
 <my4l7ljo35dnwxl33maqhyvw7666dmuwtduwtyhnzdlb6bbf5m@5sbp4tvg246f>
 <78ae8aa0-eac5-4ade-8e85-0479a22e98a3@moroto.mountain>
 <ekgwuycs3hioz6vve57e6z7igovpls6s644rvdxpxqqr7v7is6@u5lqegkuwcex>
 <1e14f4f1-29dd-4fe5-8010-de7df0866e93@moroto.mountain>
 <movur4qy7wwavdyw2ugwfsz6kvshrqlvx32ym3fyx5gg66llge@citxuw5ztgwc>
 <eb5oil2exor2bq5n3pn62575phxjdex6wdjwwjxjd3pd4je55o@4k4iu2xobel5>
 <79dc1067-76dc-43b2-9413-7754f96fe08e@moroto.mountain>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <79dc1067-76dc-43b2-9413-7754f96fe08e@moroto.mountain>
X-Classification-ID: dbc2286a-f004-44d5-96b8-3fbf2be9d2c4-1-1

Dan,

Apologies, I missed the patch when you first posted it. Thanks for the
pointer.

On Tue, May 07, 2024 at 11:08:14AM GMT, Dan Carpenter wrote:
> This patch might not work because of the netdev_hold/put() thing...

I think that's the case. It's the netdev_hold/netdev_put imbalance that
is causing the kernel issues; with your patch applied, we still see a
failure in ax25_release:

    refcount_t: decrement hit 0; leaking memory.

The patch I've posted resolves this issue and runs without any errors.

The complete trace is:

------------[ cut here ]------------
refcount_t: decrement hit 0; leaking memory.
WARNING: CPU: 1 PID: 88 at lib/refcount.c:31 refcount_warn_saturate+0x109/0x120

CPU: 1 PID: 88 Comm: axwrapper Not tainted 6.9.0-ax25-09869-g6d35085a1f38 #140
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.3-2.fc40 04/01/2014
RIP: 0010:refcount_warn_saturate+0x109/0x120
Code: f2 33 82 c6 05 34 62 f2 00 01 e8 22 14 9d ff 0f 0b 5d c3 cc cc cc cc 48 c7 c7 58 f2 33 82 c6 05 17 62 f2 00 01 e8 07 14 9d ff <0f> 0b 5d c3 cc cc cc cc 66 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40
RSP: 0018:ffffc90000447d00 EFLAGS: 00010292
RAX: 000000000000002c RBX: ffff888101142510 RCX: 0000000000000000
RDX: 0000000000000001 RSI: ffffc90000447b88 RDI: 00000000ffffefff
The system is gRBP: ffffc90000447d00 R08: 00000000ffffefff R09: ffffffff824a4b88
R10: ffffffff8244cbe0 R11: ffffc90000447ad8 R12: 0000000000000000
oing down NOW!R13: ffffc90000447d18 R14: ffff888101142000 R15: ffff88810222a0c0

FS:  0000000000000000(0000) GS:ffff88813bd00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
Sent SIGTERM toCR2: 000055d73c5f5040 CR3: 000000000242c000 CR4: 00000000000006b0
Call Trace:
 all processes <TASK>

 ? show_regs.part.0+0x22/0x30
 ? show_regs.cold+0x8/0xd
 ? refcount_warn_saturate+0x109/0x120
 ? __warn.cold+0x97/0xd5
 ? refcount_warn_saturate+0x109/0x120
 ? report_bug+0x114/0x160
 ? console_unlock+0x55/0xd0
 ? handle_bug+0x42/0x80
 ? exc_invalid_op+0x1c/0x70
 ? asm_exc_invalid_op+0x1f/0x30
 ? refcount_warn_saturate+0x109/0x120
 ref_tracker_free+0x163/0x170
 ax25_release+0x129/0x3c0
 sock_close+0x45/0xb0
 __fput+0x94/0x2a0
 ____fput+0x12/0x20
 task_work_run+0x61/0x90
 do_exit+0x2f5/0x9f0
 ? handle_mm_fault+0x197/0x300
 do_group_exit+0x38/0x90
 __x64_sys_exit_group+0x1c/0x20
 x64_sys_call+0x1269/0x1d00
 do_syscall_64+0x55/0x120
 entry_SYSCALL_64_after_hwframe+0x76/0x7e
RIP: 0033:0x7f8e7711abce
Code: Unable to access opcode bytes at 0x7f8e7711aba4.
RSP: 002b:00007ffed9c905d8 EFLAGS: 00000246 ORIG_RAX: 00000000000000e7
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f8e7711abce
RDX: 00007f8e7711ae66 RSI: 0000000000000000 RDI: 0000000000000000
RBP: 00007ffed9c90628 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 000055d73c5f2030
R13: 00007ffed9c90658 R14: 0000000000000000 R15: 00007ffed9c90620
 </TASK>
---[ end trace 0000000000000000 ]---

-- 
Lars Kellogg-Stedman <lars@oddbit.com> | larsks @ {irc,twitter,github}
http://blog.oddbit.com/                | N1LKS

