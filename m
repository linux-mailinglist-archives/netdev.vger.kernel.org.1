Return-Path: <netdev+bounces-154627-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 04E089FEEF9
	for <lists+netdev@lfdr.de>; Tue, 31 Dec 2024 11:56:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 32F0E3A2811
	for <lists+netdev@lfdr.de>; Tue, 31 Dec 2024 10:56:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 399D0193402;
	Tue, 31 Dec 2024 10:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TfzPfeXi"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F62718E377
	for <netdev@vger.kernel.org>; Tue, 31 Dec 2024 10:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735642570; cv=none; b=Swc1u1wgtwDAZso4FbmBXOBbuB/wvZC8FPlsCR4qU9E6GjE0qBYAK5CGDZgDsy06G+TuwHgm3LgcX15HetkPryt+wJETYriQLhyXVQyXOTMHMrOdH6lTHYh0EIxd8Q66aoydoeYBGSat+KGq2L7Xu6nqzg90ztzFcRDuo6yn5qM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735642570; c=relaxed/simple;
	bh=G7H3nSEYhfU88xeBEgpAwFAqVeR1hBBRPXdi4X38epw=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=UcocOyc6cTl7G2RfSOcIKCH5MvzEbdJuCw5ZphjgBhX3nJ9sL0HsJOXAEv08bpia5MGQBd8/3NLxay7GATAybtAA2ylIjOysXMJs+/4XvLncyDRSGPzwG5+lyASO44Y/TI3sedBnSX3VIm3VsLo4qxnYrN6+aubUBH93+eKOpjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TfzPfeXi; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-7b6c3629816so491489585a.1
        for <netdev@vger.kernel.org>; Tue, 31 Dec 2024 02:56:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1735642567; x=1736247367; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=68d+F6fn/HNxbUGdpXBaqtiO0lEsh81W9uHm7RXTDgM=;
        b=TfzPfeXiK4eyAyWqs0lzixkJkQJCIVbpntVYhr5es47GZ8tRe8wVK/OIcleOgHyidV
         w+hBnek4DUEQVmlDx55PDoK9MVugD1vOx6vjeMSlS0FF7OyHFKi+MOqVSFM7b78Dbg65
         FUYA2VTGEvWn4wQXSMWm0l2Hymcyu3uw6lnWQsM0WWrqRreOtHdpsT2q3gKfF/a6DGJO
         6pcTKCLLPA2GJhJF1py/y9c1oBxCptYZVJ1emRzDNvNuUJyFJxVYqUe2rQYJWLrISM42
         RyLQ3x0YNStKGHM0qdU+p9mzRSkvhvgNwrWFHMrAYHdGC6EFoKySoS6njuQUBz6/vSk+
         fP3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735642567; x=1736247367;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=68d+F6fn/HNxbUGdpXBaqtiO0lEsh81W9uHm7RXTDgM=;
        b=oON+Ws+m7qWScwEvhnttmoNugeDYhDRtGF/s1JNDpoRSID7feYkA3Wa24CGghy2DFk
         VpUA0OziFUCUQGgYTJeyncfWi2+jaEpKzoCqCd6mjCICtl/GSFaYsuUKnhZzv9qEM2kC
         1Iujl0aLC0XadOdh8kIvuxtHxK/CcV0JBWKLrjVSIiASNWq/EYb1IB+Q1C1ah2cJNLW2
         1+BgOHXDEW62bvgs1/f9PoOK4jqgzhyOaEVRfHGg4c/0AA8YfxfaAfMvLThrJYUQL8li
         kdGP5wcaAf0kPbNW+LEdziqb20WViAuCwhM/s5VIfQ0kjCi24fUEYrN2u2qrX58SkvBh
         LJyw==
X-Gm-Message-State: AOJu0YyER7m9M36GoQDYmM7b98a4IY4tyrchHfy7pH0D0Xi99GCrbbh6
	GHKYRf9oYwNFWsbDJ/gfff3Kq+l6MMYkYn3wMGmVyAtP/b6y81wr
X-Gm-Gg: ASbGncs7tQDeMRvty+j9VOcFFOmQwCxfwbgm5UObiCJRWXSEFaRXgegvko04gqsEnp4
	NrcvlfhM3KGqprQSaD7XxhgydaL5IAWfXLP2IphX52gzSPww+lJYS6gBDYVCCFgxA7jgxVfo7DF
	NiWh4t0LIA9aUcVfInPulWIXlcPNh5X0SUc6TdIaFD+hXlbZf6UPpVLgLiX45hmAWDLVtXs4Cpv
	wT4H8Jnah67av1n0pgbH8DRz2V2W63S7KlC44RGCKqrz2g3dHLVAP0CkOffcQesWd7CtexyWpi0
	6wO8T8mXjM7f4QmoQilyAAigFo7Qmw3SWA==
X-Google-Smtp-Source: AGHT+IEcuKbFKVmKkF3m9w9e5PAeoMWjBFFLKpycp3R+ptm/imbQft5dogLCu31+UzZPzeGXnofGOQ==
X-Received: by 2002:ac8:7fc2:0:b0:467:6505:e3c with SMTP id d75a77b69052e-46a4a8ea571mr680759901cf.24.1735642567474;
        Tue, 31 Dec 2024 02:56:07 -0800 (PST)
Received: from localhost (96.206.236.35.bc.googleusercontent.com. [35.236.206.96])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-46a3eb336a9sm114534231cf.80.2024.12.31.02.56.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Dec 2024 02:56:06 -0800 (PST)
Date: Tue, 31 Dec 2024 05:56:06 -0500
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
 syzbot+74f70bb1cb968bf09e4f@syzkaller.appspotmail.com, 
 Chengen Du <chengen.du@canonical.com>
Message-ID: <6773cdc68ea38_534e22949a@willemb.c.googlers.com.notmuch>
In-Reply-To: <20241230161004.2681892-2-edumazet@google.com>
References: <20241230161004.2681892-1-edumazet@google.com>
 <20241230161004.2681892-2-edumazet@google.com>
Subject: Re: [PATCH net] af_packet: fix vlan_get_protocol_dgram() vs MSG_PEEK
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
> Rework vlan_get_protocol_dgram() to not touch skb at all,
> so that it can be used from many cpus on the same skb.
> 
> Add a const qualifier to skb argument.
> 
> [1]
> skbuff: skb_under_panic: text:ffffffff8a8ccd05 len:29 put:14 head:ffff88807fc8e400 data:ffff88807fc8e3f4 tail:0x11 end:0x140 dev:<NULL>
> ------------[ cut here ]------------
>  kernel BUG at net/core/skbuff.c:206 !
> Oops: invalid opcode: 0000 [#1] PREEMPT SMP KASAN PTI
> CPU: 1 UID: 0 PID: 5892 Comm: syz-executor883 Not tainted 6.13.0-rc4-syzkaller-00054-gd6ef8b40d075 #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
>  RIP: 0010:skb_panic net/core/skbuff.c:206 [inline]
>  RIP: 0010:skb_under_panic+0x14b/0x150 net/core/skbuff.c:216
> Code: 0b 8d 48 c7 c6 86 d5 25 8e 48 8b 54 24 08 8b 0c 24 44 8b 44 24 04 4d 89 e9 50 41 54 41 57 41 56 e8 5a 69 79 f7 48 83 c4 20 90 <0f> 0b 0f 1f 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 f3
> RSP: 0018:ffffc900038d7638 EFLAGS: 00010282
> RAX: 0000000000000087 RBX: dffffc0000000000 RCX: 609ffd18ea660600
> RDX: 0000000000000000 RSI: 0000000080000000 RDI: 0000000000000000
> RBP: ffff88802483c8d0 R08: ffffffff817f0a8c R09: 1ffff9200071ae60
> R10: dffffc0000000000 R11: fffff5200071ae61 R12: 0000000000000140
> R13: ffff88807fc8e400 R14: ffff88807fc8e3f4 R15: 0000000000000011
> FS:  00007fbac5e006c0(0000) GS:ffff8880b8700000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007fbac5e00d58 CR3: 000000001238e000 CR4: 00000000003526f0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>  <TASK>
>   skb_push+0xe5/0x100 net/core/skbuff.c:2636
>   vlan_get_protocol_dgram+0x165/0x290 net/packet/af_packet.c:585
>   packet_recvmsg+0x948/0x1ef0 net/packet/af_packet.c:3552
>   sock_recvmsg_nosec net/socket.c:1033 [inline]
>   sock_recvmsg+0x22f/0x280 net/socket.c:1055
>   ____sys_recvmsg+0x1c6/0x480 net/socket.c:2803
>   ___sys_recvmsg net/socket.c:2845 [inline]
>   do_recvmmsg+0x426/0xab0 net/socket.c:2940
>   __sys_recvmmsg net/socket.c:3014 [inline]
>   __do_sys_recvmmsg net/socket.c:3037 [inline]
>   __se_sys_recvmmsg net/socket.c:3030 [inline]
>   __x64_sys_recvmmsg+0x199/0x250 net/socket.c:3030
>   do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>   do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> 
> Fixes: 79eecf631c14 ("af_packet: Handle outgoing VLAN packets without hardware offloading")
> Reported-by: syzbot+74f70bb1cb968bf09e4f@syzkaller.appspotmail.com
> Closes: https://lore.kernel.org/netdev/6772c485.050a0220.2f3838.04c5.GAE@google.com/T/#u
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> Cc: Chengen Du <chengen.du@canonical.com>
> Cc: Willem de Bruijn <willemb@google.com>

Reviewed-by: Willem de Bruijn <willemb@google.com>

