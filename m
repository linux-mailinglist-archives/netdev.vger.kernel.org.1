Return-Path: <netdev+bounces-204037-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A954AF8852
	for <lists+netdev@lfdr.de>; Fri,  4 Jul 2025 08:54:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 968917A2FA3
	for <lists+netdev@lfdr.de>; Fri,  4 Jul 2025 06:52:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBF2C2641F8;
	Fri,  4 Jul 2025 06:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WiuNgRJV"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49B9B263F59
	for <netdev@vger.kernel.org>; Fri,  4 Jul 2025 06:53:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751612038; cv=none; b=DykT5854tx5c4yYbm1AB5XD3uSfGZe0ENEEkofjvsdJHbjerwUyxs/lwYnELk7smUhQbpKCJY+fKD4ptKFRLMEi2Tls8mmi2SJofBTUPpUOpY/MpPQhekilx2VfZb4oCdxEd/YrJIoe/0rlF64yuBVXA2h1y1XGqlD5jODY+uXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751612038; c=relaxed/simple;
	bh=ZD5Oi6qfqSghs5blXGjF4/A2SjG+R6HZdKn1z5H40pk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=cCrqNaxizgomcdFv+RCEcKA0uuqFotZ65eoyqaG+9frrIbVgJxre6rQALbIu7x3mkkNtp5N5DpdI5hvl7I3BmTmohIz0Ns3BXTr1zu9GNbop3Bh0gVxipWv6CxVeAw5heRZXiVzdBqyerSNY9/ieX+nBYLqJ0mECBB0OKpktWmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WiuNgRJV; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-3139c0001b5so718047a91.2
        for <netdev@vger.kernel.org>; Thu, 03 Jul 2025 23:53:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1751612036; x=1752216836; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=W8NlYxsq0UhxD+/G2U/ObTmc+kAFGm4jak2J5JnfGBg=;
        b=WiuNgRJVaeNaC5gxPadvgVlNdtzE6Yrj9dVsdT8v2QtorzeJ/KWTKsJPr/bjN4WjJS
         apLzmxDjnUTGbCvrjg12wr8j8HBn5VYmIMHfuB5cfHTn2VMmq9U+Mx8MfxHdlTD483/A
         NLf1VrjB0gxPHscEbXMsNKyv7J/qmosCzNPndK/uEL+UapyrTWVDKBeTmQb65mQn93NE
         zaFbRZFmEcw6nwARwEDOVywz/2XH79w1BSMQDm6EV1lAbnjzjeRm7NHjrc6EN6CVaRVZ
         20q4DOH9PHvrVd+/YqEJ7RssETjhYM4ZOgMvwyOeKriZ203lPJXUo7DWyXKdIb069xxT
         z/zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751612036; x=1752216836;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=W8NlYxsq0UhxD+/G2U/ObTmc+kAFGm4jak2J5JnfGBg=;
        b=amKTWsLKvCzGngwrHynNcKHITco/MGuY0V652JtTxsIkKgDhRGEQQmozYMxlFKIoZu
         pWws7zxS0q4M3PC7X8UYxa+Ol4KdRFJkrcJy0j6vFwfzXAKQbUbwY7r/SQyEJxcDSmZv
         NZ+T5STEJ20CAnVPEDIcD37FYpSro6a94rRpiB51/QjmiP2M3pHvVHCpk5Z46rCXGz65
         IRDrbRUMchvTgjwlQR39+e/MezSGDjr3tqvJTvkmJzXm5j1a3ulHRcW0028Y3/K73l4R
         LnqnkEMfsrDvdf27/TNSDSRRIAb5yEdPAyISDP/MMNqXnaCLud8HIpUZyvbXkMUpMkq9
         SRgg==
X-Forwarded-Encrypted: i=1; AJvYcCUgAODesfElsuzVTA2yzaCnp79Xwat+v9ZYxfHD3vrtN6Jbq+C66eXI1+MqxNyF7aKjoXGO7eA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2DO9nsUlSVCB01OHoBh16vm9sZTCFtcmx9u7xnwb9Rj+W2KF7
	UR+s2O+io7Rb2Paterh92F1+8jr/FIZnddhmvxp9xo+G+Xz+YfIWcWihOVAbakd+V0Rs+xyxuvT
	Iii9UEA==
X-Google-Smtp-Source: AGHT+IGuqBbpZrVlluSjRLfeBqi/+KnCRXr3Q0QAtP/brFRAfKpBGbJmlzfPjWo0VyJZBVCaDo6HkSa9e/g=
X-Received: from pjbsw11.prod.google.com ([2002:a17:90b:2c8b:b0:311:ef56:7694])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:3d4c:b0:315:fefe:bebf
 with SMTP id 98e67ed59e1d1-31aac44bb7amr2511921a91.13.1751612036618; Thu, 03
 Jul 2025 23:53:56 -0700 (PDT)
Date: Fri,  4 Jul 2025 06:53:38 +0000
In-Reply-To: <20250704023914.3876975-1-yuehaibing@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250704023914.3876975-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250704065353.1621693-1-kuniyu@google.com>
Subject: Re: [PATCH] atm: clip: Fix NULL pointer dereference in vcc_sendmsg()
From: Kuniyuki Iwashima <kuniyu@google.com>
To: yuehaibing@huawei.com
Cc: davem@davemloft.net, edumazet@google.com, horms@kernel.org, 
	kuba@kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	pabeni@redhat.com, kuniyu@google.com
Content-Type: text/plain; charset="UTF-8"

Please specify 'net' in subject:

  [PATCH net v2] atm: clip: ...

From: Yue Haibing <yuehaibing@huawei.com>
Date: Fri, 4 Jul 2025 10:39:14 +0800
> BUG: kernel NULL pointer dereference, address: 0000000000000000
> PGD 0 P4D 0
> Oops: Oops: 0010 [#1] SMP KASAN NOPTI
> CPU: 0 UID: 0 PID: 5324 Comm: syz.0.0 Not tainted 6.15.0-rc6-syzkaller-00346-g5723cc3450bc #0 PREEMPT(full)
> Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
> RIP: 0010:0x0
> Code: Unable to access opcode bytes at 0xffffffffffffffd6.
> RSP: 0018:ffffc9000d3cf778 EFLAGS: 00010246
> RAX: 1ffffffff1910dd1 RBX: 00000000000000c0 RCX: dffffc0000000000
> RDX: ffffc9000dc82000 RSI: ffff88803e4c4640 RDI: ffff888052cd0000
> RBP: ffffc9000d3cf8d0 R08: ffff888052c9143f R09: 1ffff1100a592287
> R10: dffffc0000000000 R11: 0000000000000000 R12: 1ffff92001a79f00
> R13: ffff888052cd0000 R14: ffff88803e4c4640 R15: ffffffff8c886e88
> FS:  00007fbc762566c0(0000) GS:ffff88808d6c2000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: ffffffffffffffd6 CR3: 0000000041f1b000 CR4: 0000000000352ef0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>  <TASK>
>  vcc_sendmsg+0xa10/0xc50 net/atm/common.c:644
>  sock_sendmsg_nosec net/socket.c:712 [inline]
>  __sock_sendmsg+0x219/0x270 net/socket.c:727
>  ____sys_sendmsg+0x52d/0x830 net/socket.c:2566
>  ___sys_sendmsg+0x21f/0x2a0 net/socket.c:2620
>  __sys_sendmmsg+0x227/0x430 net/socket.c:2709
>  __do_sys_sendmmsg net/socket.c:2736 [inline]
>  __se_sys_sendmmsg net/socket.c:2733 [inline]
>  __x64_sys_sendmmsg+0xa0/0xc0 net/socket.c:2733
>  do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
>  do_syscall_64+0xf6/0x210 arch/x86/entry/syscall_64.c:94
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> 
> atmarpd_dev_ops does not implement the send method, which may cause crash
> as above.

Please move commit message before the splat.


> 
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Reported-by: syzbot+e34e5e6b5eddb0014def@syzkaller.appspotmail.com
> Closes: https://lore.kernel.org/all/682f82d5.a70a0220.1765ec.0143.GAE@google.com/T
> Signed-off-by: Yue Haibing <yuehaibing@huawei.com>
> ---
>  net/atm/clip.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/net/atm/clip.c b/net/atm/clip.c
> index b234dc3bcb0d..c02ba9d64bc3 100644
> --- a/net/atm/clip.c
> +++ b/net/atm/clip.c
> @@ -616,8 +616,15 @@ static void atmarpd_close(struct atm_vcc *vcc)
>  	module_put(THIS_MODULE);
>  }
>  
> +static int atmarpd_send(struct atm_vcc *vcc, struct sk_buff *skb)
> +{
> +	dev_kfree_skb_any(skb);

This is not enough, see:

commit 7851263998d4269125fd6cb3fdbfc7c6db853859
Author: Kuniyuki Iwashima <kuniyu@google.com>
Date:   Mon Jun 16 18:21:15 2025

    atm: Revert atm_account_tx() if copy_from_iter_full() fails.


> +	return 0;
> +}
> +
>  static const struct atmdev_ops atmarpd_dev_ops = {
> -	.close = atmarpd_close
> +	.close = atmarpd_close,
> +	.send = atmarpd_send
>  };
>  
>  
> -- 
> 2.34.1

