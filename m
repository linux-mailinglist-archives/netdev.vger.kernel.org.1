Return-Path: <netdev+bounces-203225-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 91752AF0D43
	for <lists+netdev@lfdr.de>; Wed,  2 Jul 2025 09:55:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CC9C61C23559
	for <lists+netdev@lfdr.de>; Wed,  2 Jul 2025 07:56:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D496F231840;
	Wed,  2 Jul 2025 07:55:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="c7C0pW7o"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E514211F
	for <netdev@vger.kernel.org>; Wed,  2 Jul 2025 07:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751442947; cv=none; b=RQCJ4Wp3F3s2G4g+VAPXfqUpJonUgrJ48vV/soo1qVpV34ig88cjhYh+mgMCVeEmw6yW9dwO82yFvM4K206tBe+B+UyuOPj75YdYjZEwzmsQAok3kAxhDzsNHaIjLETufG9pbUKik1AWg8u8QgIMLXebKH8cEUfzwDnDb3gB2S0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751442947; c=relaxed/simple;
	bh=/bfTAQ8PzsZmt2DNsy/cU3MuVs3Qmjip+JzAsJ/5Ho4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=W6CwsAj7WoFlA39O2YAVGK8jjAhQraX3qmrxtZUabT6NV7qufOtoLlNrsmuNKQ6WEfcSRI/IgnFq4SlTPCkUes0AP1ejBHmYzMTTiXZAjCo+Mo2wPvxkOeHu0yLdFOtC5qxb+txD+VBdDE/RcS5PmrmvuBTQS1VI9r8JfhNQSs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=c7C0pW7o; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-7d20f79a00dso552963885a.0
        for <netdev@vger.kernel.org>; Wed, 02 Jul 2025 00:55:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1751442945; x=1752047745; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hSsKRhJBE8lRElFRL+IhPaHJkxl0mfdl4lEoqNBz1WY=;
        b=c7C0pW7oqd2uWSFBw7EvZmhsR9UXtzRs7ZiYepXDW/BH8Bc9aj65Hy0ABFW66oimT2
         Y0IhDsE9tRDunor7Dzr9IFARFCwuuuGWdifvYHInIIPQ5AhV5jwfm6q2EN4NzOFFXBU/
         KHCSgiOoTMJzzHx9oAPC8aaZZwhrtot8JMmapB0CNqJjkVLioIi3obQ1fXZ61wmyYv8Y
         1PA/LI2ygFGzF8eCaUWrB0RRPuzO6bybT4/ELSoFPJHRaqNlu5rq5UXnuRQbrlh6KT+8
         h+I+USCFUtE1bBq/SEDJnPFHR9GQqp9HcALJsOahd0uGMu7sBndNmIr0s2V6PGR0yScA
         /Avw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751442945; x=1752047745;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hSsKRhJBE8lRElFRL+IhPaHJkxl0mfdl4lEoqNBz1WY=;
        b=esONf0bxm78PzasBamT9Vc+kFrtdU6d60U6ov8L3lm9/f1VGIuFfofnBX49If0+dLQ
         hPZP3z7oDK/GeXd2mMShpRYQsXu369Nh8rq5vbd9Ksi2BeO7y1zWeczrei0LxEG36xtw
         NT/avNtsBIHeF0ZM64vLabsFKhJqHyv37VXfI1j9hcexaqZHod0hZpEojVG1o+oXiIsq
         bO+SE1aoN2uwBzhXsDaoWhmPJpIauEdbz1LX24F0f041Eo65VS25nUDyqCMKz87KdZoQ
         keuErfNWdDgenZC20S7/rpljjIt5fai4w4NKpfQHIk63ZCPb3SjxIpfaf+bW3mFBbmGN
         B+Pg==
X-Forwarded-Encrypted: i=1; AJvYcCUsak71B5cmTFc8JE+QwoRYjM24uvpsLoaJ6wm9+1VskNRXN70g7ilcdn8Ci5Q2sANcRByeVJA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyzeI09kbv4v5sevtdPJtfrIPjEdFtKl9KLFnQkVNQ5dzVlwaBB
	QqmbGZfWWjTAN9K+0SA2uS3ZF3nnmDWE5mehoAwZNeyz/iXUzzp4kQUglBiCbWb+CJ7lkzfabWq
	zwxnYas7mOBM+o87wwwtkdMm6qBr6tUIPhnsPjePS
X-Gm-Gg: ASbGncsK0VGh6aFa7rZn2HBY26TLV/nJpiRFn+i6Wgal7nby5lp6qcpYXDWOweNbBJe
	L8xnuwTwdD1MS0XU5wu7+MW+uqgYb9wK7eSsEbrCbExfWbN1/vta3Mw1jiaOwWRTVUp94KxVDze
	VxK6UkeDJWT5mgMbxiSgYZIu0aPRR1l652z0ZSyvUXXoI=
X-Google-Smtp-Source: AGHT+IHCyXllKRxOEY7OadGO0pjo3HQtu0upzCM1g8cmtNwLNoJJQlkdBq44unTbmV/NdltyxBdXqgv+SeGiljq+rds=
X-Received: by 2002:a05:620a:63c1:b0:7d3:f51e:d775 with SMTP id
 af79cd13be357-7d5c46a30acmr270076985a.24.1751442944691; Wed, 02 Jul 2025
 00:55:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250702033600.254-1-linma@zju.edu.cn>
In-Reply-To: <20250702033600.254-1-linma@zju.edu.cn>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 2 Jul 2025 00:55:33 -0700
X-Gm-Features: Ac12FXyYuewkGoZYfRbx4pTkZDsGN8U0H1xKQQf2LmCa8nMOtxTffaLw31dtXwM
Message-ID: <CANn89i+OJTG6YT1paZRigUuPB9gggL7p+sPym3_rZywKCaYqzQ@mail.gmail.com>
Subject: Re: [PATCH net] net: atm: Fix incorrect net_device lec check
To: Lin Ma <linma@zju.edu.cn>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, 
	mingo@kernel.org, tglx@linutronix.de, pwn9uin@gmail.com, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 1, 2025 at 8:36=E2=80=AFPM Lin Ma <linma@zju.edu.cn> wrote:
>
> There are two sites in atm mpoa code that believe the fetched object
> net_device is of lec type. However, both of them do just name checking
> to ensure that the device name starts with "lec" pattern string.
>
> That is, malicious user can hijack this by creating another device
> starting with that pattern, thereby causing type confusion. For example,
> create a *team* interface with lecX name, bind that interface and send
> messages will get a crash like below:
>
> [   18.450000] kernel tried to execute NX-protected page - exploit attemp=
t? (uid: 0)
> [   18.452366] BUG: unable to handle page fault for address: ffff88800570=
2a70
> [   18.454253] #PF: supervisor instruction fetch in kernel mode
> [   18.455058] #PF: error_code(0x0011) - permissions violation
> [   18.455366] PGD 3801067 P4D 3801067 PUD 3802067 PMD 80000000056000e3
> [   18.455725] Oops: 0011 [#1] PREEMPT SMP PTI
> [   18.455966] CPU: 0 PID: 130 Comm: trigger Not tainted 6.1.90 #7
> [   18.456921] RIP: 0010:0xffff888005702a70
> [   18.457151] Code: .....
> [   18.458168] RSP: 0018:ffffc90000677bf8 EFLAGS: 00010286
> [   18.458461] RAX: ffff888005702a70 RBX: ffff888005702000 RCX: 000000000=
000001b
> [   18.458850] RDX: ffffc90000677c10 RSI: ffff88800565e0a8 RDI: ffff88800=
5702000
> [   18.459248] RBP: ffffc90000677c68 R08: 0000000000000000 R09: 000000000=
0000000
> [   18.459644] R10: 0000000000000000 R11: ffff888005702a70 R12: ffff88800=
556c000
> [   18.460033] R13: ffff888005964900 R14: ffff8880054b4000 R15: ffff88800=
54b5000
> [   18.460425] FS:  0000785e61b5a740(0000) GS:ffff88807dc00000(0000) knlG=
S:0000000000000000
> [   18.460872] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [   18.461183] CR2: ffff888005702a70 CR3: 00000000054c2000 CR4: 000000000=
00006f0
> [   18.461580] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 000000000=
0000000
> [   18.461974] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 000000000=
0000400
> [   18.462368] Call Trace:
> [   18.462518]  <TASK>
> [   18.462645]  ? __die_body+0x64/0xb0
> [   18.462856]  ? page_fault_oops+0x353/0x3e0
> [   18.463092]  ? exc_page_fault+0xaf/0xd0
> [   18.463322]  ? asm_exc_page_fault+0x22/0x30
> [   18.463589]  ? msg_from_mpoad+0x431/0x9d0
> [   18.463820]  ? vcc_sendmsg+0x165/0x3b0
> [   18.464031]  vcc_sendmsg+0x20a/0x3b0
> [   18.464238]  ? wake_bit_function+0x80/0x80
> [   18.464511]  __sys_sendto+0x38c/0x3a0
> [   18.464729]  ? percpu_counter_add_batch+0x87/0xb0
> [   18.465002]  __x64_sys_sendto+0x22/0x30
> [   18.465219]  do_syscall_64+0x6c/0xa0
> [   18.465465]  ? preempt_count_add+0x54/0xb0
> [   18.465697]  ? up_read+0x37/0x80
> [   18.465883]  ? do_user_addr_fault+0x25e/0x5b0
> [   18.466126]  ? exit_to_user_mode_prepare+0x12/0xb0
> [   18.466435]  entry_SYSCALL_64_after_hwframe+0x6e/0xd8
> [   18.466727] RIP: 0033:0x785e61be4407
> [   18.467948] RSP: 002b:00007ffe61ae2150 EFLAGS: 00000202 ORIG_RAX: 0000=
00000000002c
> [   18.468368] RAX: ffffffffffffffda RBX: 0000785e61b5a740 RCX: 0000785e6=
1be4407
> [   18.468758] RDX: 000000000000019c RSI: 00007ffe61ae21c0 RDI: 000000000=
0000003
> [   18.469149] RBP: 00007ffe61ae2370 R08: 0000000000000000 R09: 000000000=
0000000
> [   18.469542] R10: 0000000000000000 R11: 0000000000000202 R12: 000000000=
0000000
> [   18.469936] R13: 00007ffe61ae2498 R14: 0000785e61d74000 R15: 000057bdd=
cbabd98
>
> Refer to other net_device related subsystem, checking netlink_ops seems
> like the correct way out, e.g., see how xgbe_netdev_event() validates
> the netdev object. Hence, add correct comparison with lec_netdev_ops to
> safeguard the casting.
>
> By the way, this bug dates back to pre-git history (2.3.15), hence use
> the first reference for tracking.
>
> Signed-off-by: Lin Ma <linma@zju.edu.cn>
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> ---
>  net/atm/mpc.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/net/atm/mpc.c b/net/atm/mpc.c
> index f6b447bba329..96ea134e22fe 100644
> --- a/net/atm/mpc.c
> +++ b/net/atm/mpc.c
> @@ -275,6 +275,9 @@ static struct net_device *find_lec_by_itfnum(int itf)
>         sprintf(name, "lec%d", itf);
>         dev =3D dev_get_by_name(&init_net, name);
>
> +       if (dev->netdev_ops !=3D lec_netdev_ops)

This will crash if dev is NULL

