Return-Path: <netdev+bounces-154626-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FEAA9FEEF8
	for <lists+netdev@lfdr.de>; Tue, 31 Dec 2024 11:55:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CF02A161B89
	for <lists+netdev@lfdr.de>; Tue, 31 Dec 2024 10:55:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACD51193084;
	Tue, 31 Dec 2024 10:55:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MlAajVco"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0676D17ADE8
	for <netdev@vger.kernel.org>; Tue, 31 Dec 2024 10:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735642547; cv=none; b=ZlnoSSB5hqAdjxsQXBS/PLcEp+0XXAKWQLoCuxHC5S1Wl7IATAXvJYMZGtHkOcgeNmpXaCMBM6YninlLN0FiDF09hjh0OpdFJgmUkjehU1VfwvtlAgDHirjXX1tsOlkcv7QfXO0kt1QgHZQImDJoHIJ9nkJontjOkwqRfEowGZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735642547; c=relaxed/simple;
	bh=R/tLU5o4Naz1g7DKWoRgKxKfuhZWBfu1hQP4Bapkevc=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=dq7+h3cHbOd/oYUL8lC+pbgzzzbqJr4SURpOam0R4+Tq4AbRSV6RKIlwU80NQJ84a5RuGQ/8R3vKU4Htp1COOrA6LJTFxcF/HSLKO/UDDAXo9hmY8O5SHQE2/frHnM5zWGHwzDyN99kkPiq6OUEQf3nbfciNtoIFIO7SAFWwHfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MlAajVco; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-7b85d5cc39eso1095525485a.3
        for <netdev@vger.kernel.org>; Tue, 31 Dec 2024 02:55:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1735642545; x=1736247345; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zu2YglaJkseU+xlOkGyq4fNhfg5ocIODK0FCvqDnq5A=;
        b=MlAajVcooi6kgWHo13GWdj1kffboJeHkmH6XxSF+sgmc8zPgvVTrFnMUs0dbTFE1ll
         xRNXpYaF2yj6t0BUwZPtIMnUhh9QYv5y5gw0fl4tiHe8Dr1JJL/rUTP3q4e7EdE9fS83
         cmJCGpHakByHdZI+Tj9CIgwHqFfLhaN7DdG8FRqW1TN8V3vAIBqMaFSBxvLkrdl1KZyM
         lbdTdouhE3xjMXUEu4+f/ZIxkMwgkeXNlCCUYTkuXzK7QktnXRk9HXXJnovJdGIkRgP7
         cRxc81WPn6+LKHxVBk1RiV2Oyz01t4kU8ur9ant1hbyoO6DLuZT3Bkg+zqHhQr3d+l2A
         mJ5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735642545; x=1736247345;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=zu2YglaJkseU+xlOkGyq4fNhfg5ocIODK0FCvqDnq5A=;
        b=B0h6Uy9dPRtNOY73f1wXI/tGNPYnlbyvhV+wugRUiQ03vmUVozTJWIVFnlnJF03XBH
         hyrS2ws4zpQxD6T2gHc3BwGLaf9nTZUr0CJ+UG/3iodZrNXFP+OkT8XQvbvpYiJ7InmL
         7t9ybZ/hv4V2WgSZQPNs2jY81NhFYPfzPAUhzqpFRRodCFRwtHdAkZKIEfSz0B1tHcCN
         mRPduJOTcLPXtlpLqm5fcCisBHDxQGVoEBb5rUJXngunIdamlC9k7Y0gc1HDVEdWbKuc
         jYQzH8yj7AsYzzbAeVKSoz/e3guRyeJ+/SAfbVMHZG1rppmv7A+caEr85IM89WkmM/yL
         VvDQ==
X-Gm-Message-State: AOJu0YwEjWxaEnPR7YjnmnOWsU/Kv8hUMBV/0TnN1ymnBA1iyv6R7QJ5
	OjsPzrt3wjh2cqfNEjn86tYFkGxPaR9SwmhXGL8vONDZE5WIwug1
X-Gm-Gg: ASbGncsUCNl9CwTTlOSJe3Lc4bVjE2Is/4NGZhOB2HRvhRxmR6nhUSfcjql/6kLM451
	pwxG+aPimaWoyvRvN6aGe0IT1UjD7jlzLUp5VZqiNdHbSfza4mM1TTxMo66jwinlirtQD2mDlPs
	2ndCx6QjPQXkmvC9nDR00NGqD+ROBNZrfe4a0JbBaIj3lEDji6qf/smSl9nckBQ3Yc1w0RunQwy
	2DorKxVn5PCfQVAhPbyNJATcGrEq1cLefMCrQFiTBF+NbHy19yiXIpQ8hEBZTtNRLuM907JJbSp
	fNKhE5ygFxLpUHeNmjzta8HnIODegjDINw==
X-Google-Smtp-Source: AGHT+IEj0aja8uBCaMkHb9SdU1dr+aAGLudzFF3/5JhhWBNiv9T/UWPYHSx0WuXEPnPBXRj17suzTg==
X-Received: by 2002:a05:620a:4054:b0:7b6:d910:5b1a with SMTP id af79cd13be357-7b9ba836deamr5534733985a.42.1735642544708;
        Tue, 31 Dec 2024 02:55:44 -0800 (PST)
Received: from localhost (96.206.236.35.bc.googleusercontent.com. [35.236.206.96])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b9ac2df87fsm994741885a.37.2024.12.31.02.55.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Dec 2024 02:55:43 -0800 (PST)
Date: Tue, 31 Dec 2024 05:55:43 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Eric Dumazet <edumazet@google.com>, 
 "David S . Miller" <davem@davemloft.net>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, 
 Simon Horman <horms@kernel.org>, 
 Willem de Bruijn <willemb@google.com>, 
 eric.dumazet@gmail.com, 
 Eric Dumazet <edumazet@google.com>, 
 syzbot+8400677f3fd43f37d3bc@syzkaller.appspotmail.com, 
 Chengen Du <chengen.du@canonical.com>
Message-ID: <6773cdaf3f67d_534e22943e@willemb.c.googlers.com.notmuch>
In-Reply-To: <20241230161004.2681892-1-edumazet@google.com>
References: <20241230161004.2681892-1-edumazet@google.com>
Subject: Re: [PATCH net] af_packet: fix vlan_get_tci() vs MSG_PEEK
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
> Blamed commit forgot MSG_PEEK case, allowing a crash [1] as found
> by syzbot.
> 
> Rework vlan_get_tci() to not touch skb at all,
> so that it can be used from many cpus on the same skb.
> 
> Add a const qualifier to skb argument.
> 
> [1]
> skbuff: skb_under_panic: text:ffffffff8a8da482 len:32 put:14 head:ffff88807a1d5800 data:ffff88807a1d5810 tail:0x14 end:0x140 dev:<NULL>
> ------------[ cut here ]------------
>  kernel BUG at net/core/skbuff.c:206 !
> Oops: invalid opcode: 0000 [#1] PREEMPT SMP KASAN PTI
> CPU: 0 UID: 0 PID: 5880 Comm: syz-executor172 Not tainted 6.13.0-rc3-syzkaller-00762-g9268abe611b0 #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
>  RIP: 0010:skb_panic net/core/skbuff.c:206 [inline]
>  RIP: 0010:skb_under_panic+0x14b/0x150 net/core/skbuff.c:216
> Code: 0b 8d 48 c7 c6 9e 6c 26 8e 48 8b 54 24 08 8b 0c 24 44 8b 44 24 04 4d 89 e9 50 41 54 41 57 41 56 e8 3a 5a 79 f7 48 83 c4 20 90 <0f> 0b 0f 1f 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 f3
> RSP: 0018:ffffc90003baf5b8 EFLAGS: 00010286
> RAX: 0000000000000087 RBX: dffffc0000000000 RCX: 8565c1eec37aa000
> RDX: 0000000000000000 RSI: 0000000080000000 RDI: 0000000000000000
> RBP: ffff88802616fb50 R08: ffffffff817f0a4c R09: 1ffff92000775e50
> R10: dffffc0000000000 R11: fffff52000775e51 R12: 0000000000000140
> R13: ffff88807a1d5800 R14: ffff88807a1d5810 R15: 0000000000000014
> FS:  00007fa03261f6c0(0000) GS:ffff8880b8600000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007ffd65753000 CR3: 0000000031720000 CR4: 00000000003526f0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>  <TASK>
>   skb_push+0xe5/0x100 net/core/skbuff.c:2636
>   vlan_get_tci+0x272/0x550 net/packet/af_packet.c:565
>   packet_recvmsg+0x13c9/0x1ef0 net/packet/af_packet.c:3616
>   sock_recvmsg_nosec net/socket.c:1044 [inline]
>   sock_recvmsg+0x22f/0x280 net/socket.c:1066
>   ____sys_recvmsg+0x1c6/0x480 net/socket.c:2814
>   ___sys_recvmsg net/socket.c:2856 [inline]
>   do_recvmmsg+0x426/0xab0 net/socket.c:2951
>   __sys_recvmmsg net/socket.c:3025 [inline]
>   __do_sys_recvmmsg net/socket.c:3048 [inline]
>   __se_sys_recvmmsg net/socket.c:3041 [inline]
>   __x64_sys_recvmmsg+0x199/0x250 net/socket.c:3041
>   do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>   do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
> 
> Fixes: 79eecf631c14 ("af_packet: Handle outgoing VLAN packets without hardware offloading")
> Reported-by: syzbot+8400677f3fd43f37d3bc@syzkaller.appspotmail.com
> Closes: https://lore.kernel.org/netdev/6772c485.050a0220.2f3838.04c6.GAE@google.com/T/#u
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> Cc: Chengen Du <chengen.du@canonical.com>
> Cc: Willem de Bruijn <willemb@google.com>

Reviewed-by: Willem de Bruijn <willemb@google.com>

