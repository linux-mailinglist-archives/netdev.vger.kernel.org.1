Return-Path: <netdev+bounces-198187-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 989A8ADB8C0
	for <lists+netdev@lfdr.de>; Mon, 16 Jun 2025 20:22:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B8769175068
	for <lists+netdev@lfdr.de>; Mon, 16 Jun 2025 18:22:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07988289802;
	Mon, 16 Jun 2025 18:21:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DTJFN818"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67BF5204C1A
	for <netdev@vger.kernel.org>; Mon, 16 Jun 2025 18:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750098117; cv=none; b=uIoLMEwzJBnMvNj8inM1n8zEtXWqrBjqS0L2HyWP++ugWtYGKfVqsiOdonND69xbdFPHp6Dv3XafMsJsnfJpVTX4/QzHBG5JML3Sfa2LQN2LUqMaStD1aHlt51+saqidWsq09hMnIE4drJm40S6xw41e7lL5I53dj6IAqvHjFxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750098117; c=relaxed/simple;
	bh=/l+nw8FG/2f3wneXts2csyMc3Lf8/UZpET3QY3AVbJA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XOMdkOh45wIWo6OcugXiuGN8oiR104IgiFZqtL7UO4q4/wZlS5Sixr2EwIfWA1QV23FgJhGMTwO8ieit4F+S+1lgoRyZLSePh4ETPG53Cdey3P275lN6o1L96rvHcdviDaBxoXv1NEPU1sxzZSjhd0Bb8GN5MGMy5lICJX05Yt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DTJFN818; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-b2c2c762a89so3874484a12.0
        for <netdev@vger.kernel.org>; Mon, 16 Jun 2025 11:21:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750098115; x=1750702915; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3dw4wuKcdGJ1et6I8Dffl7g0Dwbg/TVyxAsdcpuIgEk=;
        b=DTJFN818DzKZZby2PflqG8d8naG7SnyBW1rOlAbNZeyssVWziLkjUt6JI4/yT09rjv
         Hv2iLK9X8JKxV8sLvvxGbPeubbtpYTpdvS/iC1BVBXdy2X53V63VzBtLGybozT2T5sqO
         rxhaF1EM2ALZbqlLt6u6e+zNix7w/vM2LwsySM8L+ydGZr7Cp77FkSQAgcHJwgBWBfnr
         TkIjyaGRre9bFhzAhPi30ATaYohGKvcJi2cTUBrYsVORLXGX04H+eBsSfhjQ8IjcsEqM
         e6LlEV0VK2iVnU3GP264UBr33tolBP4ogx3LITbqa2sOevj0SqAhP4eke1z1YpvrN5lA
         cMww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750098115; x=1750702915;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3dw4wuKcdGJ1et6I8Dffl7g0Dwbg/TVyxAsdcpuIgEk=;
        b=MPq9b9c2tlxotRy+Bne9E2hHl45MctNmXC9GRMMQAdarjuJsc/LYie91Qb9omvT7gr
         ZvTBlNYZ0oMRfpodyhHBx71a3T00h5ZZ6Kw5GDniva8agC234SPvnBYPHpLXdwAegtGS
         3G8fbBNN4898USHVWElUEeZa+sV/ONfZ0X0c8sOibbyPuyfVxgIngWNe20Q0ig5D5vaz
         yJhjVB2fuu2LE0R/SmGIP4dq07dTioNmsJ7DgPBe9m5dUlVRxqWGE9GDNC4nhvnoXi5o
         4NM2gJSjg9VbSel3zLzq0cmR1cQCbAeeIT/68ldfr8O8/3fdm1r+Fr4Gh3MyD84UKOD0
         kthw==
X-Forwarded-Encrypted: i=1; AJvYcCUDDf8LKw/e2DkKrL6WNjRud3mtPxFxmmryYFSHn2CBnm4IHmZwj+X7kvdLAn1AL7ff6babE5U=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/ghoB+o9DCPEACN1O78NgLoeusA1HVn35Bu5pKxYU063Le+oL
	rPXksncIp/mS97Ifz9vspKsa3Txnc9ermNYoMgW1h/GGAavunzUISow=
X-Gm-Gg: ASbGncuMl2bB8IZZGzoUPI5QF8tYzcxFTExZAhH9tPDoaz8+eEDssAQls2Dg8E/gaVi
	WttHLiNzrtQM7dE39petSbwyk9oQx1dS9rSVoVRPSHUoUwhG1DBKQoCJCwY/tYyUCCBqxfpZueg
	wXjbBUZ6a2jWc2RBahjxcKM2RX8mNkt4Xnj97EBTC9quDbuJccuWaRrf5PXBhvy2OiYBaUge62z
	Qu05Vt13Gf7hkC3AUZ0TGt/ULyjC5iObPr7IaDCQaNpl4OLuFcU8aWTJOrwaJ1UqOaEqA3GNQwi
	7v+Jr3fsCcEpFxs0hf9nIZBo9xdlBPyN8GO9Cotpsp5HdmkuQw==
X-Google-Smtp-Source: AGHT+IGVsiJr4xzGiVhuOQIv36gmQLzPP9j+TNNKJiqcDEaNBltBNFTbeGUt0iOafHnCLKWW0yLL1g==
X-Received: by 2002:a05:6a20:47df:b0:21f:becf:5f4d with SMTP id adf61e73a8af0-21fbecf5f6dmr11315316637.20.1750098115490;
        Mon, 16 Jun 2025 11:21:55 -0700 (PDT)
Received: from fedora.. ([2601:647:6700:3390::c8d1])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b2fe169205dsm7243188a12.74.2025.06.16.11.21.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Jun 2025 11:21:55 -0700 (PDT)
From: Kuniyuki Iwashima <kuni1840@gmail.com>
To: Chas Williams <3chas3@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Kuniyuki Iwashima <kuni1840@gmail.com>,
	netdev@vger.kernel.org,
	linux-atm-general@lists.sourceforge.net,
	syzbot+1d3c235276f62963e93a@syzkaller.appspotmail.com
Subject: [PATCH v2 net 1/2] atm: atmtcp: Free invalid length skb in atmtcp_c_send().
Date: Mon, 16 Jun 2025 11:21:14 -0700
Message-ID: <20250616182147.963333-2-kuni1840@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250616182147.963333-1-kuni1840@gmail.com>
References: <20250616182147.963333-1-kuni1840@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kuniyuki Iwashima <kuniyu@google.com>

syzbot reported the splat below. [0]

vcc_sendmsg() copies data passed from userspace to skb and passes
it to vcc->dev->ops->send().

atmtcp_c_send() accesses skb->data as struct atmtcp_hdr after
checking if skb->len is 0, but it's not enough.

Also, when skb->len == 0, skb and sk (vcc) were leaked because
dev_kfree_skb() is not called and sk_wmem_alloc adjustment is missing
to revert atm_account_tx() in vcc_sendmsg(), which is expected
to be done in atm_pop_raw().

Let's properly free skb with an invalid length in atmtcp_c_send().

[0]:
BUG: KMSAN: uninit-value in atmtcp_c_send+0x255/0xed0 drivers/atm/atmtcp.c:294
 atmtcp_c_send+0x255/0xed0 drivers/atm/atmtcp.c:294
 vcc_sendmsg+0xd7c/0xff0 net/atm/common.c:644
 sock_sendmsg_nosec net/socket.c:712 [inline]
 __sock_sendmsg+0x330/0x3d0 net/socket.c:727
 ____sys_sendmsg+0x7e0/0xd80 net/socket.c:2566
 ___sys_sendmsg+0x271/0x3b0 net/socket.c:2620
 __sys_sendmsg net/socket.c:2652 [inline]
 __do_sys_sendmsg net/socket.c:2657 [inline]
 __se_sys_sendmsg net/socket.c:2655 [inline]
 __x64_sys_sendmsg+0x211/0x3e0 net/socket.c:2655
 x64_sys_call+0x32fb/0x3db0 arch/x86/include/generated/asm/syscalls_64.h:47
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xd9/0x210 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Uninit was created at:
 slab_post_alloc_hook mm/slub.c:4154 [inline]
 slab_alloc_node mm/slub.c:4197 [inline]
 kmem_cache_alloc_node_noprof+0x818/0xf00 mm/slub.c:4249
 kmalloc_reserve+0x13c/0x4b0 net/core/skbuff.c:579
 __alloc_skb+0x347/0x7d0 net/core/skbuff.c:670
 alloc_skb include/linux/skbuff.h:1336 [inline]
 vcc_sendmsg+0xb40/0xff0 net/atm/common.c:628
 sock_sendmsg_nosec net/socket.c:712 [inline]
 __sock_sendmsg+0x330/0x3d0 net/socket.c:727
 ____sys_sendmsg+0x7e0/0xd80 net/socket.c:2566
 ___sys_sendmsg+0x271/0x3b0 net/socket.c:2620
 __sys_sendmsg net/socket.c:2652 [inline]
 __do_sys_sendmsg net/socket.c:2657 [inline]
 __se_sys_sendmsg net/socket.c:2655 [inline]
 __x64_sys_sendmsg+0x211/0x3e0 net/socket.c:2655
 x64_sys_call+0x32fb/0x3db0 arch/x86/include/generated/asm/syscalls_64.h:47
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xd9/0x210 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

CPU: 1 UID: 0 PID: 5798 Comm: syz-executor192 Not tainted 6.16.0-rc1-syzkaller-00010-g2c4a1f3fe03e #0 PREEMPT(undef)
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/07/2025

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Reported-by: syzbot+1d3c235276f62963e93a@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=1d3c235276f62963e93a
Tested-by: syzbot+1d3c235276f62963e93a@syzkaller.appspotmail.com
Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
v2: Reuse done: label
---
 drivers/atm/atmtcp.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/atm/atmtcp.c b/drivers/atm/atmtcp.c
index d4aa0f353b6c..eeae160c898d 100644
--- a/drivers/atm/atmtcp.c
+++ b/drivers/atm/atmtcp.c
@@ -288,7 +288,9 @@ static int atmtcp_c_send(struct atm_vcc *vcc,struct sk_buff *skb)
 	struct sk_buff *new_skb;
 	int result = 0;
 
-	if (!skb->len) return 0;
+	if (skb->len < sizeof(struct atmtcp_hdr))
+		goto done;
+
 	dev = vcc->dev_data;
 	hdr = (struct atmtcp_hdr *) skb->data;
 	if (hdr->length == ATMTCP_HDR_MAGIC) {
-- 
2.49.0


