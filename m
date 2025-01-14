Return-Path: <netdev+bounces-157948-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8601AA0FED2
	for <lists+netdev@lfdr.de>; Tue, 14 Jan 2025 03:33:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 907BD164B07
	for <lists+netdev@lfdr.de>; Tue, 14 Jan 2025 02:33:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EC0D22FE19;
	Tue, 14 Jan 2025 02:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xhz/myaP"
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f54.google.com (mail-io1-f54.google.com [209.85.166.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE4A41FC0EB
	for <netdev@vger.kernel.org>; Tue, 14 Jan 2025 02:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736821986; cv=none; b=qxUOBDf6uKCwNbjbbSnIktjDUyrK7q3qO+Nftv6XcJuyuU7tr9IaAfdVX9CfiRAdSbsrIlnMh98DyXSAzDlFjDlFNQEMjQo2MBqiTw9Ey+eM1FVAKAtcWZFfp8KqBKTVO5rIknWT2A1xzsWCBPcM8xjjNIVXVOoBB0wPsvKVgJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736821986; c=relaxed/simple;
	bh=8A9Ek7/CsE4wAUBHvh1FhM/xzMSEkdF9qkH3JOEeSUI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=J0KJpjtbc/FkcNL6B6L+iQ1H21bdp0tpNRHl6ScD1suz0JCfrvg+Y73KW39ObEwsSIPhYWpsTAIEEi+M6jHclD4qgGEj3wnVpah9O7t6wKT18UJZOjlPFLkLv23SRJPxElrAYgUOvjJrN3CZYXj5O+n9sNPbtinR7osSgmAoEDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xhz/myaP; arc=none smtp.client-ip=209.85.166.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f54.google.com with SMTP id ca18e2360f4ac-844e10ef3cfso384371239f.2
        for <netdev@vger.kernel.org>; Mon, 13 Jan 2025 18:33:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736821984; x=1737426784; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=As+RiFzHkmcgTrR5YFBKCEwC7EaYyEaJNiSSsfkrMJk=;
        b=Xhz/myaPf0nTz216zzvOPUiOfrl0sJj7Opa6rhXZEqi3pN4VG3QNLlKk48e15pm74d
         FIoZuS8oRynTB9y4TRy5GKNFWlVGUdqoC56emXJsiWoY0w/9FTHc45LetMFL0k4IyXS6
         JvzBa1vqDkRAzP6362lnyBOATzJcowxIVy6BbcC+2+H1E+RgiR/dnW/1E4wkOkWFCJ3H
         /drkF91zMTJkOiYz53Bb0A68Gr5YQxgegXcvjz8S0ZZAUSWVPKkori/x82IC5RcIxlP/
         wvbh8OgRWmDSWCZa9+PeUkUocUE0oraBZ0eVYxlvqWS/KlZQWYsOqQGTsAoFrPS1duxi
         EmVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736821984; x=1737426784;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=As+RiFzHkmcgTrR5YFBKCEwC7EaYyEaJNiSSsfkrMJk=;
        b=jqnT03qWVtGCwbYyFtpBFI/C2KcYV630pFQpr1j7HdZ82vSfFh2PTT8lOqO8xvznLa
         9zoRduEzNnRqM3cOEbJiAiQt5wwBpzQ19XP9qMfhMaGED0fTtd/QOIWkQawTfSbjPa8U
         cjgzSTNJ3GQt9FXbWctgvJgHd2TkdhvxdQGxDxj/6t+U5IZiEk3hFx2MasvMOL5thKPS
         GaDBqa2jnd1835taK5BeDPZuE6AuM0AXLe/3Vpeyre6Z1a7sLLsf6xYAZUaLkMhV+vGQ
         uokXVXM4QZMmFh+WKig38SeLBCgl6q2Z4zrwdV8xgEt4mkEBrLw4PW+2Xdp+ON5iYI8M
         mMlw==
X-Gm-Message-State: AOJu0YzuY+vj24s6JtcQ00LUSWAf0itV9HlmAHaF66w/LPGHA/6KA9Wy
	2S0uEmXZi5J9awUi0UqjFwoeuVdjEDxMNNZtXcM/m+qdWgSRdi40SL/D9hpkHSSsy3/mlwdWSqX
	oXHvXC7bEjle3qJc6AhrISjupedY=
X-Gm-Gg: ASbGncsP9GC1AgI/98UVKSgB6n4TXiEIJ0P46PH83OSc3LaXfGrJQkomC1XBcdOVvka
	UvKGWrtMMdMLgr5zSujfAyx6mr7Q7Rr/gC+UNQzMC
X-Google-Smtp-Source: AGHT+IH9K/vpDUpJeClqagetkKP/eQgM3Faj/ZmZal7KA4J8z3aojPxUBwsqTZkX/sGMND2jrZUam48Ufs7qZ0x5WjQ=
X-Received: by 2002:a05:6e02:1fe1:b0:3a7:70a4:6872 with SMTP id
 e9e14a558f8ab-3ce3a9c1f00mr187095705ab.9.1736821984000; Mon, 13 Jan 2025
 18:33:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <17d459487b61c5d0276a01a3bc1254c6432b5d12.1736793775.git.lucien.xin@gmail.com>
 <20250113142600.6712511f@kernel.org>
In-Reply-To: <20250113142600.6712511f@kernel.org>
From: Xin Long <lucien.xin@gmail.com>
Date: Mon, 13 Jan 2025 21:32:53 -0500
X-Gm-Features: AbW1kvZ9J7915HU85-HahsuyrMQYnolM8sBF4diQoKqqWM4RGEHq0OGdtdLw_jQ
Message-ID: <CADvbK_d50y-9f_n6XtLYt=5mi3QA+TNYydux+O7Y=PJGgJhOAA@mail.gmail.com>
Subject: Re: [PATCHv2 net] net: sched: refine software bypass handling in tc_run
To: Jakub Kicinski <kuba@kernel.org>
Cc: network dev <netdev@vger.kernel.org>, davem@davemloft.net, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, 
	Jamal Hadi Salim <jhs@mojatatu.com>, Cong Wang <xiyou.wangcong@gmail.com>, 
	Jiri Pirko <jiri@resnulli.us>, Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>, ast@fiberby.net, 
	Shuang Li <shuali@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 13, 2025 at 5:26=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Mon, 13 Jan 2025 13:42:55 -0500 Xin Long wrote:
> > This patch addresses issues with filter counting in block (tcf_block),
> > particularly for software bypass scenarios, by introducing a more
> > accurate mechanism using useswcnt.
>
> I think this is causing:
>
> [   35.565404][  T350] BUG: sleeping function called from invalid context=
 at ./include/linux/percpu-rwsem.h:49
> [   35.565956][  T350] in_atomic(): 1, irqs_disabled(): 0, non_block: 0, =
pid: 350, name: tc
> [   35.566288][  T350] preempt_count: 1, expected: 0
> [   35.566529][  T350] RCU nest depth: 0, expected: 0
> [   35.566753][  T350] 2 locks held by tc/350:
> [   35.566922][  T350]  #0: ffffffff9d1e7e88 (rtnl_mutex){+.+.}-{4:4}, at=
: tc_new_tfilter+0x902/0x1c90
> [   35.567325][  T350]  #1: ffff88800a377b90 (&tp->lock){+.+.}-{3:3}, at:=
 tc_new_tfilter+0x9d1/0x1c90
> [   35.567707][  T350] CPU: 2 UID: 0 PID: 350 Comm: tc Not tainted 6.13.0=
-rc7-virtme #1
> [   35.568006][  T350] Hardware name: Bochs Bochs, BIOS Bochs 01/01/2011
> [   35.568259][  T350] Call Trace:
> [   35.568414][  T350]  <TASK>
> [   35.568520][  T350]  dump_stack_lvl+0xb0/0xd0
> [   35.568745][  T350]  __might_resched+0x2f8/0x530
> [   35.568945][  T350]  ? tc_new_tfilter+0x9d1/0x1c90
> [   35.569151][  T350]  cpus_read_lock+0x1b/0xe0
> [   35.569349][  T350]  static_key_slow_inc+0x13/0x30
> [   35.569547][  T350]  tc_new_tfilter+0x1523/0x1c90
> [   35.569757][  T350]  ? mark_lock+0x38/0x3e0
> [   35.569918][  T350]  ? __pfx_tc_new_tfilter+0x10/0x10
> [   35.570142][  T350]  ? __pfx_lock_acquire.part.0+0x10/0x10
> [   35.570555][  T350]  ? rtnetlink_rcv_msg+0x6ef/0xc10
> [   35.570767][  T350]  ? __pfx_tc_new_tfilter+0x10/0x10
> [   35.570968][  T350]  rtnetlink_rcv_msg+0x712/0xc10
> [   35.571174][  T350]  ? __pfx_rtnetlink_rcv_msg+0x10/0x10
> [   35.571393][  T350]  ? hlock_class+0x4e/0x130
> [   35.571591][  T350]  ? mark_lock+0x38/0x3e0
> [   35.571749][  T350]  ? __lock_acquire+0xb9a/0x1680
> [   35.571951][  T350]  netlink_rcv_skb+0x130/0x360
> [   35.572153][  T350]  ? __pfx_rtnetlink_rcv_msg+0x10/0x10
> [   35.572353][  T350]  ? __pfx_netlink_rcv_skb+0x10/0x10
> [   35.572571][  T350]  ? netlink_deliver_tap+0x13e/0x340
> [   35.572772][  T350]  ? netlink_deliver_tap+0xc3/0x340
> [   35.572982][  T350]  netlink_unicast+0x44b/0x710
> [   35.573188][  T350]  ? __pfx_netlink_unicast+0x10/0x10
> [   35.573387][  T350]  ? find_held_lock+0x2c/0x110
> [   35.573591][  T350]  netlink_sendmsg+0x723/0xbe0
> [   35.573796][  T350]  ? __pfx_netlink_sendmsg+0x10/0x10
> [   35.574006][  T350]  ____sys_sendmsg+0x7ac/0xa10
> [   35.574207][  T350]  ? __pfx_____sys_sendmsg+0x10/0x10
> [   35.574407][  T350]  ? __pfx_copy_msghdr_from_user+0x10/0x10
> [   35.574668][  T350]  ___sys_sendmsg+0xee/0x170
> [   35.574866][  T350]  ? __debug_check_no_obj_freed+0x253/0x520
> [   35.575114][  T350]  ? __pfx____sys_sendmsg+0x10/0x10
> [   35.575318][  T350]  ? __pfx___debug_check_no_obj_freed+0x10/0x10
> [   35.575565][  T350]  ? __pfx_free_object_rcu+0x10/0x10
> [   35.575766][  T350]  ? trace_rcu_segcb_stats+0x36/0x1e0
> [   35.575973][  T350]  ? lockdep_hardirqs_on_prepare+0x275/0x410
> [   35.576225][  T350]  ? kmem_cache_free+0xf8/0x330
> [   35.576423][  T350]  ? do_sys_openat2+0x141/0x160
> [   35.576620][  T350]  ? do_sys_openat2+0x10a/0x160
> [   35.576821][  T350]  ? do_sys_openat2+0x10a/0x160
> [   35.577027][  T350]  __sys_sendmsg+0x109/0x1a0
> [   35.577226][  T350]  ? __pfx___sys_sendmsg+0x10/0x10
> [   35.577448][  T350]  do_syscall_64+0xc1/0x1d0
> [   35.577648][  T350]  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> [   35.577892][  T350] RIP: 0033:0x7f539e60b9a7
> [   35.578106][  T350] Code: Unable to access opcode bytes at 0x7f539e60b=
97d.
> [   35.578359][  T350] RSP: 002b:00007ffd917a3fc8 EFLAGS: 00000246 ORIG_R=
AX: 000000000000002e
> [   35.578670][  T350] RAX: ffffffffffffffda RBX: 000000000047dbc0 RCX: 0=
0007f539e60b9a7
> [   35.578979][  T350] RDX: 0000000000000000 RSI: 00007ffd917a4030 RDI: 0=
000000000000005
> [   35.579271][  T350] RBP: 000000000000dd86 R08: 0000000000000000 R09: 0=
000000000000000
> [   35.579567][  T350] R10: 00007f539e4c4708 R11: 0000000000000246 R12: 0=
0007ffd917a9973
> [   35.579862][  T350] R13: 00000000678583dc R14: 0000000000483b60 R15: 0=
0007ffd917a9977
> [   35.580179][  T350]  </TASK>
> --
Thanks for catching this.

I will try moving the call to static_branch_inc() out of
spin_lock(&tp->lock), like:

                spin_lock(&tp->lock);
                if (tp->usesw && !tp->counted) {
                        tp->counted =3D true;
                        tp_counted =3D 1;
                }
                spin_unlock(&tp->lock);
                if (tp_counted && atomic_inc_return(&block->useswcnt) =3D=
=3D 1)
                        static_branch_inc(&tcf_sw_enabled_key);

