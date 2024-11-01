Return-Path: <netdev+bounces-141086-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A29999B96FD
	for <lists+netdev@lfdr.de>; Fri,  1 Nov 2024 19:00:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C5C4F1C20EFE
	for <lists+netdev@lfdr.de>; Fri,  1 Nov 2024 18:00:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B15631CCED7;
	Fri,  1 Nov 2024 18:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="MP97v8rK"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 677D41C687
	for <netdev@vger.kernel.org>; Fri,  1 Nov 2024 18:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730484048; cv=none; b=T900eprUIVhFiy/CjHzIlcRzKiXgjKzpziQgXNdt3/0BStJTkvPgeXBxHq2kI1HZGDAvxfTUlq24IWqjP3XYuZHXrQTHVdc2CYhYoxZOqpz64Tad4XN+SBg3y6JYGFoxCvuEajcO1b5gJzhX2s96EVGrcQU8gcP9HUzx51jqP54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730484048; c=relaxed/simple;
	bh=0LAuoOHr5an1GDNiRzFl/O0AOfpEZV/kRGGyIuzHvuU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=AbDKc0KfnLZdLaOstBT2AIokqPAsWQVa3rTsAb9Je9V5go19GsM65CfDr0s7AnwGi/ux91lJr3XbpqQt4BxMcgoFIrQQaHRCdHdx34UzSa650vJSLyjaiirau23MX9iAvxsyp6dkn7nb3ye9S5iJRoHTgrP5Tl/PzaqugbvHsVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=MP97v8rK; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-2e2ad9825a7so1707060a91.0
        for <netdev@vger.kernel.org>; Fri, 01 Nov 2024 11:00:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1730484046; x=1731088846; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WnCjo3Pk+KGDDa91giSui6Tdjp/Aet5EBKdYoNfkxxs=;
        b=MP97v8rKMLcAb1TIPa89kd8ipFvamrafuwUNz64/F5Bsk8Jfle5igUtrmdUyyxo/Ql
         /DJh+icf0wuYMyh2J9TpGs6TbK8LRBKiFGqCHvr7GiXYPlC1CQRZIJQNt16+jWaAODeC
         9JG0gXA3AXax66ywkmS9gLE+3QPh8HuYMLq3kzq+B4IEWTnsURCH+jR8d8h74Lvt7Mwl
         Orvj2Dw0ECBHqnfKb6kncjdmzIcyB834j/lDUoxLiHeGjlH/v2vJL0midcATmsSM/9Yy
         2ec/mWxvZd7WRyACZhF6x6F7vqn+gfNcTDoxSSY9BUoR9w7lqTb4CJR0yjJ4RaKXK+US
         odoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730484046; x=1731088846;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WnCjo3Pk+KGDDa91giSui6Tdjp/Aet5EBKdYoNfkxxs=;
        b=QRThrE+6Wct/gws0qjGFME/oHSnT1jve3cadQTDVE2TumvWvf7/trQQwPXd7ReGxMq
         xqolmlkzYZEu9M8gGEKVWJtIM4URn9GrzE1ZmJrY1qZ9aXjE1+0fEEGfyCojS2RFWIys
         B0pUnts0JMep4RI2PhIf2PqI2RG/DWAJH1vJKo4Cau3ptcOIQWhaVz9deoifdIOE1AWh
         a0Taofzn0/biYwDxNpXjfhmI930WvNTZhXksqzwfF9tt5BUSODsITj6qMoNsNiwo2wAH
         /1jtw7/pFp4f8yAvWUgEFCuT42HC0zoQyRLAx7a4vPDpNgZaqFxvmu/xRSIwN6HONKcv
         MMfQ==
X-Forwarded-Encrypted: i=1; AJvYcCWig+PIug2Xr5baL473KGAk/dxyQpWl6UqanmLqaueQAfuilFaP8vepenfVzMpmdVnJ/LOs1ZQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yza8bdv9JBAqR+qy3ywQ4II4a2Y5yDNDU/6rB6PZw6YYUaMcvwz
	qbBBwWPG81CAyi2We37OjdPv3HYITlJMgFewXCwRl7odjOh0+YZeoNLhFTkWsd0=
X-Google-Smtp-Source: AGHT+IG8hUXTCtU3xJuFVYPPTCe5p5BTYDzV9RMwfkcACj/35sbMQwqwbLVMetaIIlhgVTbZwy8W4A==
X-Received: by 2002:a17:90a:604b:b0:2e2:bb17:a322 with SMTP id 98e67ed59e1d1-2e8f11da738mr24775386a91.35.1730484045597;
        Fri, 01 Nov 2024 11:00:45 -0700 (PDT)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e92fa2576dsm5064348a91.16.2024.11.01.11.00.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Nov 2024 11:00:44 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: Christoph Hellwig <hch@lst.de>, Ming Lei <ming.lei@redhat.com>, 
 Eric Dumazet <edumazet@google.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, netdev@vger.kernel.org, 
 "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <eric.dumazet@gmail.com>, 
 syzbot+71abe7ab2b70bca770fd@syzkaller.appspotmail.com
In-Reply-To: <20241101174755.1557172-1-edumazet@google.com>
References: <20241101174755.1557172-1-edumazet@google.com>
Subject: Re: [PATCH] iov-iter: do not return more bytes than requested in
 iov_iter_extract_bvec_pages()
Message-Id: <173048404421.574892.685420045440934367.b4-ty@kernel.dk>
Date: Fri, 01 Nov 2024 12:00:44 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2


On Fri, 01 Nov 2024 17:47:55 +0000, Eric Dumazet wrote:
> syzbot found a way to crash UDP sendpage.
> 
> Root cause is that iov_iter_extract_bvec_pages() is returning more bytes than
> requested by ip_append_data().
> 
> Oops: general protection fault, probably for non-canonical address 0xed2e87ee8f0cadc6: 0000 [#1] PREEMPT SMP KASAN PTI
> KASAN: maybe wild-memory-access in range [0x69745f7478656e30-0x69745f7478656e37]
> CPU: 1 UID: 0 PID: 5869 Comm: syz-executor171 Not tainted 6.12.0-rc5-next-20241031-syzkaller #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
>  RIP: 0010:_compound_head include/linux/page-flags.h:242 [inline]
>  RIP: 0010:put_page+0x23/0x260 include/linux/mm.h:1552
> Code: 90 90 90 90 90 90 90 55 41 57 41 56 53 49 89 fe 48 bd 00 00 00 00 00 fc ff df e8 d8 ae 0d f8 49 8d 5e 08 48 89 d8 48 c1 e8 03 <80> 3c 28 00 74 08 48 89 df e8 5f e5 77 f8 48 8b 1b 48 89 de 48 83
> RSP: 0018:ffffc90003f970a8 EFLAGS: 00010207
> RAX: 0d2e8bee8f0cadc6 RBX: 69745f7478656e36 RCX: ffff8880306d3c00
> RDX: 0000000000000000 RSI: 0000000000000000 RDI: 69745f7478656e2e
> RBP: dffffc0000000000 R08: ffffffff898706fd R09: 1ffffffff203a076
> R10: dffffc0000000000 R11: fffffbfff203a077 R12: 0000000000000000
> R13: ffff88807fd7a842 R14: 69745f7478656e2e R15: 69745f7478656e2e
> FS:  0000555590726380(0000) GS:ffff8880b8700000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 000000000045ad50 CR3: 0000000025350000 CR4: 00000000003526f0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>  <TASK>
>   skb_page_unref include/linux/skbuff_ref.h:43 [inline]
>   __skb_frag_unref include/linux/skbuff_ref.h:56 [inline]
>   skb_release_data+0x483/0x8a0 net/core/skbuff.c:1119
>   skb_release_all net/core/skbuff.c:1190 [inline]
>   __kfree_skb net/core/skbuff.c:1204 [inline]
>   sk_skb_reason_drop+0x1c9/0x380 net/core/skbuff.c:1242
>   kfree_skb_reason include/linux/skbuff.h:1262 [inline]
>   kfree_skb include/linux/skbuff.h:1271 [inline]
>   __ip_flush_pending_frames net/ipv4/ip_output.c:1538 [inline]
>   ip_flush_pending_frames+0x12d/0x260 net/ipv4/ip_output.c:1545
>   udp_flush_pending_frames net/ipv4/udp.c:829 [inline]
>   udp_sendmsg+0x5d2/0x2a50 net/ipv4/udp.c:1302
>   sock_sendmsg_nosec net/socket.c:729 [inline]
>   __sock_sendmsg+0x1a6/0x270 net/socket.c:744
>   sock_sendmsg+0x134/0x200 net/socket.c:767
>   splice_to_socket+0xa10/0x10b0 fs/splice.c:889
>   do_splice_from fs/splice.c:941 [inline]
>   direct_splice_actor+0x11b/0x220 fs/splice.c:1164
>   splice_direct_to_actor+0x586/0xc80 fs/splice.c:1108
>   do_splice_direct_actor fs/splice.c:1207 [inline]
>   do_splice_direct+0x289/0x3e0 fs/splice.c:1233
>   do_sendfile+0x561/0xe10 fs/read_write.c:1388
>   __do_sys_sendfile64 fs/read_write.c:1455 [inline]
>   __se_sys_sendfile64+0x17c/0x1e0 fs/read_write.c:1441
>   do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>   do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> RIP: 0033:0x7f17eb533ab9
> Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 c1 17 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
> RSP: 002b:00007ffdeb190c28 EFLAGS: 00000246 ORIG_RAX: 0000000000000028
> RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f17eb533ab9
> RDX: 0000000000000000 RSI: 0000000000000003 RDI: 0000000000000004
> RBP: 00007f17eb5a65f0 R08: 0000000000000006 R09: 0000000000000006
> R10: 0000020000023893 R11: 0000000000000246 R12: 0000000000000001
> R13: 431bde82d7b634db R14: 0000000000000001 R15: 0000000000000001
>  </TASK>
> 
> [...]

Applied, thanks!

[1/1] iov-iter: do not return more bytes than requested in iov_iter_extract_bvec_pages()
      commit: 7bc802acf193010c5b2afb88523a57766b836bc1

Best regards,
-- 
Jens Axboe




