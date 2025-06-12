Return-Path: <netdev+bounces-197253-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E7C75AD7F39
	for <lists+netdev@lfdr.de>; Fri, 13 Jun 2025 01:50:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9A521163356
	for <lists+netdev@lfdr.de>; Thu, 12 Jun 2025 23:50:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1C052DECCC;
	Thu, 12 Jun 2025 23:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P7BEwALT"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E7B021ABC1;
	Thu, 12 Jun 2025 23:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749772194; cv=none; b=t60DMqzRSflXTIBy3zWvyv3FLvc4CG/yNn8a11BOQRhpCyNcJj1vLxbXFFx743biMC2xM1OHxh1zr8mkwBc/A1caXtBi0jtE/TE/3Q+HMbpkEkPVJXhXKfklIvfmE6/cql3TsZaljv3Tm+h7djqaIVB10slf7hB3CPmp2B1Mm+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749772194; c=relaxed/simple;
	bh=IGlM1aMwuWlN4KUgs+V/8/qfzdLCjm0iM5gKzBkBrKg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qKvCzplF4dVTWqiXrLwL9Dtd6Jj4fj35ZaKbyN+Th7S/v+NfGXZyUYhBAyE4rrbnWDkWAD7ggIjg9XdG1ikKhWJHjMjw56LA9ZISBk7sytNmps0O26VBMzGmnehAan+2y6A4iILKacPxNGe5tJcgwKbMNxHIqUvcz3RpTG3tnCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P7BEwALT; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-74264d1832eso1725115b3a.0;
        Thu, 12 Jun 2025 16:49:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749772192; x=1750376992; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yydAhh80AdKqo80zFIdgFeGLonAt34YNlvMq6VZBR8s=;
        b=P7BEwALThu81hyLunqQniObUZopgz57oIcU2z6AKhx6W75jNDDfh6GClAelHLuNpcm
         F1PwXEMg0GXb2TADm2lRdsZmDnbdIRvwz6INwOSJPfTaZyHfxSXIjO1ws8633LjOt3rk
         UCNaQ7+NawdvXzELzXmHfew7KZV0tGKtuezGRXbAPUIOK2Eybk2WMPCFkb4zUE8kY7lA
         5Zh5sw7sSZAlF7EULQbhcdvera/faDlBMZ4qpGRuRnR+URSsv3YY1WrVA4e1mz/6GT2y
         MRewrPCLAZhITWRvf7m7TcsiepZjY0FwlL19XCqgUKQqK9PAo9pIFABSFJvxNx08lL76
         NJig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749772192; x=1750376992;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yydAhh80AdKqo80zFIdgFeGLonAt34YNlvMq6VZBR8s=;
        b=fmz3TK5r0cejUEQBjw1lcNk1BAr3KJQUKCkWFLZkGto3IahEiBFrn0MPi6UMC2PBh1
         yVktu7fn9XSufLbQ/yZD+by2yelskm3GuYcM9Rao0hNRYIE26sUJSk1hK/muwum2ktsL
         YXdOGgQr69ds9FteT82RF1KtUNvLXu9kJmDMbujxnzas3oC58P5dtx+GpaAevDxUi7hD
         sgOkVTUuMXMAGe24A41y+IF7AOa4GhHLP2k7blIH+gPtiW5lcEqqllnLdFkp+/wPmGLX
         agJGzBvZhwp8sus0+JIsCCeGAXkQ0VOzWBOmtS+b9i34deQ9UCpHcZ6Wfxizrkgja3hU
         gqJg==
X-Forwarded-Encrypted: i=1; AJvYcCUN4fq60KxHeo6eOQkQuNvcYtmqQJ7Co4jZ4P0+RWp8/gYzw7agkFuZvHTuPkcNwl8p5FQLQ5MV1T16XhA=@vger.kernel.org, AJvYcCV50Tb15M8gycUmpF3LtSiNXEP7b79MspcyueCT6uix8uKFYJ7NKktYmLBMK07XmdAFi2NGOBzb@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7O75ch9yDryffnZE7aS1LGsqhtBkdXY6EgfJ59kMcgSyU2WIn
	uxuDI6+2FXFIMPlX6X3UXoPDDDaeCiemJrOayLm3hgD3++kAdwcg0FE=
X-Gm-Gg: ASbGncsveJGYYcijY3ztBAqQTMar3QhOsNjzfdivQOHwT6kfn91bRv6iPk9A4GJxfqx
	5jgXJlb2q43XYvR/HGllmeoDQ0CQMH8r1Q1dSYwb2MlcweEY7xStEGKwYPcvS0EZvagx6+jcxYP
	sYkZur5FMPlTL9MCNcWqoWVxvP5RqWjnpmYl9dz1ol7eOcPmuuaOhV99U4l4ZZgkqwJxNrsj4N3
	iXbz22jn+fG01Jzu2ddlBecpapp9tXiLfGX4m6bbKxJb6y/wDcc3LXEMgiEGyaaKJYcmyxtLrNn
	apSTTTe1RqB6zhZFE1cD7xoYp+lPUcJ8hjNuvGs=
X-Google-Smtp-Source: AGHT+IEK19ZXZEaZ/4s2jK4Oc4ZfOvTW+ytKr0OgAwkaJT19D7NqpmAu5KFzRe9eVhOZEcj2PugcAg==
X-Received: by 2002:a05:6a00:a86:b0:73f:f816:dd78 with SMTP id d2e1a72fcca58-7488f79d15dmr1253898b3a.15.1749772192135;
        Thu, 12 Jun 2025 16:49:52 -0700 (PDT)
Received: from fedora.. ([2601:647:6700:3390::c8d1])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-748900b2e30sm325453b3a.128.2025.06.12.16.49.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Jun 2025 16:49:51 -0700 (PDT)
From: Kuniyuki Iwashima <kuni1840@gmail.com>
To: syzbot+1d3c235276f62963e93a@syzkaller.appspotmail.com
Cc: 3chas3@gmail.com,
	linux-atm-general@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	syzkaller-bugs@googlegroups.com,
	kuniyu@google.com
Subject: Re: [syzbot] [atm?] KMSAN: uninit-value in atmtcp_c_send
Date: Thu, 12 Jun 2025 16:49:36 -0700
Message-ID: <20250612234950.40595-1-kuni1840@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <684b65a6.050a0220.be214.0295.GAE@google.com>
References: <684b65a6.050a0220.be214.0295.GAE@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: syzbot <syzbot+1d3c235276f62963e93a@syzkaller.appspotmail.com>
Date: Thu, 12 Jun 2025 16:41:26 -0700
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    2c4a1f3fe03e Merge tag 'bpf-fixes' of git://git.kernel.org..
> git tree:       upstream
> console+strace: https://syzkaller.appspot.com/x/log.txt?x=1787d9d4580000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=42d51b7b9f9e61d
> dashboard link: https://syzkaller.appspot.com/bug?extid=1d3c235276f62963e93a
> compiler:       Debian clang version 20.1.6 (++20250514063057+1e4d39e07757-1~exp1~20250514183223.118), Debian LLD 20.1.6
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1195ed70580000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16187682580000
> 
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/1313b3ad2bf4/disk-2c4a1f3f.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/15f719cfdf88/vmlinux-2c4a1f3f.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/e7f531b0bef6/bzImage-2c4a1f3f.xz
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+1d3c235276f62963e93a@syzkaller.appspotmail.com
> 
> =====================================================
> BUG: KMSAN: uninit-value in atmtcp_c_send+0x255/0xed0 drivers/atm/atmtcp.c:294
>  atmtcp_c_send+0x255/0xed0 drivers/atm/atmtcp.c:294
>  vcc_sendmsg+0xd7c/0xff0 net/atm/common.c:644
>  sock_sendmsg_nosec net/socket.c:712 [inline]
>  __sock_sendmsg+0x330/0x3d0 net/socket.c:727
>  ____sys_sendmsg+0x7e0/0xd80 net/socket.c:2566
>  ___sys_sendmsg+0x271/0x3b0 net/socket.c:2620
>  __sys_sendmsg net/socket.c:2652 [inline]
>  __do_sys_sendmsg net/socket.c:2657 [inline]
>  __se_sys_sendmsg net/socket.c:2655 [inline]
>  __x64_sys_sendmsg+0x211/0x3e0 net/socket.c:2655
>  x64_sys_call+0x32fb/0x3db0 arch/x86/include/generated/asm/syscalls_64.h:47
>  do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
>  do_syscall_64+0xd9/0x210 arch/x86/entry/syscall_64.c:94
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> 
> Uninit was created at:
>  slab_post_alloc_hook mm/slub.c:4154 [inline]
>  slab_alloc_node mm/slub.c:4197 [inline]
>  kmem_cache_alloc_node_noprof+0x818/0xf00 mm/slub.c:4249
>  kmalloc_reserve+0x13c/0x4b0 net/core/skbuff.c:579
>  __alloc_skb+0x347/0x7d0 net/core/skbuff.c:670
>  alloc_skb include/linux/skbuff.h:1336 [inline]
>  vcc_sendmsg+0xb40/0xff0 net/atm/common.c:628
>  sock_sendmsg_nosec net/socket.c:712 [inline]
>  __sock_sendmsg+0x330/0x3d0 net/socket.c:727
>  ____sys_sendmsg+0x7e0/0xd80 net/socket.c:2566
>  ___sys_sendmsg+0x271/0x3b0 net/socket.c:2620
>  __sys_sendmsg net/socket.c:2652 [inline]
>  __do_sys_sendmsg net/socket.c:2657 [inline]
>  __se_sys_sendmsg net/socket.c:2655 [inline]
>  __x64_sys_sendmsg+0x211/0x3e0 net/socket.c:2655
>  x64_sys_call+0x32fb/0x3db0 arch/x86/include/generated/asm/syscalls_64.h:47
>  do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
>  do_syscall_64+0xd9/0x210 arch/x86/entry/syscall_64.c:94
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> 
> CPU: 1 UID: 0 PID: 5798 Comm: syz-executor192 Not tainted 6.16.0-rc1-syzkaller-00010-g2c4a1f3fe03e #0 PREEMPT(undef) 
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/07/2025
> =====================================================
> 
> 
> ---
> This report is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
> 
> syzbot will keep track of this issue. See:
> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
> 
> If the report is already addressed, let syzbot know by replying with:
> #syz fix: exact-commit-title
> 
> If you want syzbot to run the reproducer, reply with:
> #syz test: git://repo/address.git branch-or-commit-hash
> If you attach or paste a git patch, syzbot will apply it before testing.

#syz test

diff --git a/drivers/atm/atmtcp.c b/drivers/atm/atmtcp.c
index d4aa0f353b6c..c74dec9a2759 100644
--- a/drivers/atm/atmtcp.c
+++ b/drivers/atm/atmtcp.c
@@ -288,7 +288,11 @@ static int atmtcp_c_send(struct atm_vcc *vcc,struct sk_buff *skb)
 	struct sk_buff *new_skb;
 	int result = 0;
 
-	if (!skb->len) return 0;
+	if (!skb->len)
+		return 0;
+	if (skb->len < sizeof(atmtcp_hdr))
+		return -EINVAL;
+
 	dev = vcc->dev_data;
 	hdr = (struct atmtcp_hdr *) skb->data;
 	if (hdr->length == ATMTCP_HDR_MAGIC) {

