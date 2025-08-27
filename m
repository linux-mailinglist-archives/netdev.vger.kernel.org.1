Return-Path: <netdev+bounces-217515-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3278DB38F47
	for <lists+netdev@lfdr.de>; Thu, 28 Aug 2025 01:31:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ECEEE17418B
	for <lists+netdev@lfdr.de>; Wed, 27 Aug 2025 23:31:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FF43252900;
	Wed, 27 Aug 2025 23:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Z8nAv8ai"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7768B1C5F1B
	for <netdev@vger.kernel.org>; Wed, 27 Aug 2025 23:31:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756337474; cv=none; b=RTsLKrTDff8LncEbvma4YdKiR6OjJSaoO+MLrCiAhTu4y8a41VwZKt3H2p8IOBhpEff0mSNfn5Zy45ukVpA4cnYs2q7I3WF4DyD/7n3CY/Om4+seewroNkDnepdtaaJGJTvwBtQEVH6O7wum/7fd4fLgHkvHNgzgLuIC7h1QjzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756337474; c=relaxed/simple;
	bh=Byw9Dnp30jSEyJNdFDlLzahQ++KBrK2kDvEy1gGi5rA=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=sd7zexBIudxV58sqiyhRs7P2RqgYGA0w41fX1Od4v2FBupIbAiDhSUml97J8MykRQz+Ov9ltf25qbofjkHXNOLq5Cwh8U5C7+u7JPstsKD4aLgqyHwSen05A9Pc/Us8BW5qOI1xmwGpTdhbPG/S/wXl5qvWTt+UqWbyPRFHW4Xo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Z8nAv8ai; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-24457ef983fso7272875ad.0
        for <netdev@vger.kernel.org>; Wed, 27 Aug 2025 16:31:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756337472; x=1756942272; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=q9sIkDhgq9p9pCTpid4QFeocCB0duJomdSWUT63zQx8=;
        b=Z8nAv8aifQAX8Y7/Epfmwm1DMi9e42m6eoQ3PCwKfqytAGYW5hg8I1aM7AoLjrr4/V
         8TFHbE4OI/AbJ1Bc7ZnsX9ywAj6oFwX2bnpoKFhp02ZWl4lJZZY2l5AoxMrLqFbVk3F7
         Ckb0QgEVN5dN8XOh2y4zixbZ1tPRv9HW/goHQide/mzYPE4uCiz0wC7GTJNf82xsIQKN
         7WGFkVSJIc7t/msfKzY50LJECnhxiSs/Lz+2bBVmK+ZMEqxAXSgTx6YVwfYQibkEGtNZ
         TBb44Y8mWLgpnV22Qv/iAmCBfw2YUxqJWn4BuCXYhH/hC9pkgz7kN4G+0Cn031NqMh6a
         UVlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756337472; x=1756942272;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=q9sIkDhgq9p9pCTpid4QFeocCB0duJomdSWUT63zQx8=;
        b=rZeDO8hUQmwp4NeJ6BMcm00255UVlAzI4tVA3h4gPdk0xo4eJdSrToBVQaJAo4WpD8
         l/f28sxwn9CqXO41+7xKYUq5Kgzdp3yQK+eB1sLiPwwRHL7anH2ovFRAbO0URNYRIBcS
         t0afXsiOPA+FBBr+JPAb3Z+GrbcguzT6hTYuxmW9v1wPOspy1z7o1gZs/KpgtyUfCn2R
         HbODtB/XqVYRe1w5YhynvePlgqe+s80Xc+qOSojf5i2IpnJDJmWKcCra48jSSLGtKn64
         +MM9Ar8aUEpFoo6iIECzf8moTOcAEaWMcUyQQWt67HYMuviEcLjA+VLk3rUTYdlTM+CY
         Rzfg==
X-Forwarded-Encrypted: i=1; AJvYcCVX+nhRAZjv/1d1ba8KioC6wP/8TSttgrchRQOSgiaE1wpXxY2GO8UcZtqQLuyteu73HbNWRvc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyUMb97ymVWuDwrIZoNcJQfmLnlnI6lFciQmD6994Fr2+cMrmGa
	cYqtyomU8yHvi1MoKgwzG16QsxCcva0ny+sSk9xIZuTeK+TEPKc9cHELi73/SIv7O/LsDYH7h8I
	Y09hnnQ==
X-Google-Smtp-Source: AGHT+IHzqj1pkC4T6V8SanqfJBwogADnr64SibdgTF27Uzg3ELtWkUN0yPnLosvQEqRX4CxeMeC6TXyxxP4=
X-Received: from plpe13.prod.google.com ([2002:a17:903:3c2d:b0:248:7db1:3800])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:320e:b0:248:9669:a405
 with SMTP id d9443c01a7336-2489669a618mr61077255ad.3.1756337471851; Wed, 27
 Aug 2025 16:31:11 -0700 (PDT)
Date: Wed, 27 Aug 2025 23:31:02 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.0.268.g9569e192d0-goog
Message-ID: <20250827233108.3768855-1-kuniyu@google.com>
Subject: [PATCH v1 net] net: usb: rtl8150: Fix uninit-value access in set_carrier().
From: Kuniyuki Iwashima <kuniyu@google.com>
To: Petko Manolov <petkan@nucleusys.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Kuniyuki Iwashima <kuniyu@google.com>, Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org, 
	linux-usb@vger.kernel.org, 
	syzbot+b4d5d8faea6996fd55e3@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"

syzbot reported set_carrier() accesses an uninitialised local var. [0]

get_registers() is a wrapper of usb_control_msg_recv(), which copies
data to the passed buffer only when it returns 0.

Let's check the retval before accessing tmp in set_carrier().

[0]:
BUG: KMSAN: uninit-value in set_carrier drivers/net/usb/rtl8150.c:721 [inline]
BUG: KMSAN: uninit-value in rtl8150_open+0x1131/0x1360 drivers/net/usb/rtl8150.c:758
 set_carrier drivers/net/usb/rtl8150.c:721 [inline]
 rtl8150_open+0x1131/0x1360 drivers/net/usb/rtl8150.c:758
 __dev_open+0x7e9/0xc60 net/core/dev.c:1682
 __dev_change_flags+0x3a8/0x9f0 net/core/dev.c:9549
 netif_change_flags+0x8d/0x1e0 net/core/dev.c:9612
 dev_change_flags+0x18c/0x320 net/core/dev_api.c:68
 devinet_ioctl+0x1186/0x2500 net/ipv4/devinet.c:1200
 inet_ioctl+0x4c0/0x6f0 net/ipv4/af_inet.c:1001
 sock_do_ioctl+0x9c/0x480 net/socket.c:1238
 sock_ioctl+0x70b/0xd60 net/socket.c:1359
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:598 [inline]
 __se_sys_ioctl+0x23c/0x400 fs/ioctl.c:584
 __x64_sys_ioctl+0x97/0xe0 fs/ioctl.c:584
 x64_sys_call+0x1cbc/0x3e20 arch/x86/include/generated/asm/syscalls_64.h:17
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xd9/0x210 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Local variable tmp created at:
 number+0x8a/0x2200 lib/vsprintf.c:469
 vsnprintf+0xd21/0x1bd0 lib/vsprintf.c:2890

CPU: 1 UID: 0 PID: 5461 Comm: dhcpcd Not tainted syzkaller #0 PREEMPT(none)
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/12/2025

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Reported-by: syzbot+b4d5d8faea6996fd55e3@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/all/68af933a.a00a0220.2929dc.0007.GAE@google.com/
Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 drivers/net/usb/rtl8150.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/usb/rtl8150.c b/drivers/net/usb/rtl8150.c
index ddff6f19ff98..0f45627f6a00 100644
--- a/drivers/net/usb/rtl8150.c
+++ b/drivers/net/usb/rtl8150.c
@@ -717,8 +717,8 @@ static void set_carrier(struct net_device *netdev)
 	rtl8150_t *dev = netdev_priv(netdev);
 	short tmp;
 
-	get_registers(dev, CSCR, 2, &tmp);
-	if (tmp & CSCR_LINK_STATUS)
+	if (!get_registers(dev, CSCR, 2, &tmp) &&
+	    (tmp & CSCR_LINK_STATUS))
 		netif_carrier_on(netdev);
 	else
 		netif_carrier_off(netdev);
-- 
2.51.0.268.g9569e192d0-goog


