Return-Path: <netdev+bounces-103805-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 238F19098F3
	for <lists+netdev@lfdr.de>; Sat, 15 Jun 2024 17:42:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0870F1C20F43
	for <lists+netdev@lfdr.de>; Sat, 15 Jun 2024 15:42:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5413349640;
	Sat, 15 Jun 2024 15:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nQSjQzvq"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5ADE49639
	for <netdev@vger.kernel.org>; Sat, 15 Jun 2024 15:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718466155; cv=none; b=hNGU1wgpEsEPS46fxUNZfIRTJL/EXPT7F777+FiX533gTbyDCYjlKXjLpO9UqeKtwV5VN3eZfzMOnlIF/MNzaKlTC0Z8mfeZ2BAf6cE98wFja1kIoIu/So4u0qeN3rJQnOSYL5qHlRYxDBdTrhbWiUJmptutFtNPPEB+bYaM/Ig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718466155; c=relaxed/simple;
	bh=lEEY8Jlmt1onLM18KdBKoMrU4cTUdjJcWsk2DYBNaCM=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=NMJW/lWH0DdLjp8xItMHVQGrVHtxLvIRqJf8qiKy45HWsBY8DB0IeaYC6mjH3FTc8wjhJzeuTWsaMnMH5f9LeVulZqHzl12W6vMnhBJjftBW2wqEwlbQH3OiqIBe07xDPVayAn2BKJh+ewNyGZnkN140ZtNgu5lINots3Mxdt2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nQSjQzvq; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-62f43c95de4so61887427b3.3
        for <netdev@vger.kernel.org>; Sat, 15 Jun 2024 08:42:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1718466152; x=1719070952; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=T+8P+4Xokq8b3Cgc8RIYjbNh/L5Vhpye0HRGUvnCqQA=;
        b=nQSjQzvqW+7EaYCuniEAqrwM5CF3u/JLxOJ0k9CkqbCXYcOdqlRTBGy2hmMrI9Cn6C
         wOEKJEvinD4kdZeO2q8+0RU5n6Rj0g7C85/chE3vpHxkQUs84G06XgXA7iyi+K5DXfOh
         XGV5+2+UGgaAm3NX3b1gl0oBErxCnwdS3FnMY6G394vHuEq5i0f5MtG8Y75saWj1LK50
         IrqGQ+aPAEP71kuFiD592+IzH+U30b6mAnB0jnoTxPp0sxLc5Tf8M9gXD5eVYficpysY
         iOjr9MYUcYufrWP+NKv/KmY/R61BtZK5Cy+sCYnCRMQnB0pbByYeUK3X0TSKTX1nXESy
         6CBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718466152; x=1719070952;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=T+8P+4Xokq8b3Cgc8RIYjbNh/L5Vhpye0HRGUvnCqQA=;
        b=UF5ESpTpv7+C2BaYy5lXT0pYZmVR7DmPycFcx9bhfk0rtQWUkZ7Wj4ZdKQr59Ppkew
         QSTljLVSeeauqgdKA7W1bCBuZtFzb5iJiys0ieIJ3VGqoOKeiqGmz8wjEVtTw9+WmPv/
         oof5uCe6SC1uTdJU5wFzmZfHRQ26WkiU0jikXD6mX6w7RbxgGsVyQJUrmxwzRakFK5fl
         6YJ5bqUxBmb+WqOTSvldKaL7u6pOSIZg56rCp7IeUWrzgh+jnI/I58vtxzh2Ga9UPqWr
         b9XQpAYCTHcPdm5p+nw4z2pXCsbbEMaE2VKCYBIPOCTWiwz0m8rhyi1Xzw8gMlr7MmfM
         CRuA==
X-Forwarded-Encrypted: i=1; AJvYcCWNmlkiCSMp7ALAmdq0eGoNxkuQtjYKmIA0uhzKFFP9ds45WLPSvt/LsRkWHB6C4SNHmVBAtKd8GWaiE0fLI3hQQH6Gtz1Y
X-Gm-Message-State: AOJu0YwSKd63CmDNVZYXzMxQlgXqJn2mUiO2B8+kv9FvC5DdU/OzGe/t
	J0/NKI4J//rVCzwRzFKvjodp6PaDrBHJfJ1Nb8JD4U1qYQa4yQaGDzS3CYaYbyPLTwNSd3U96rn
	M9yZBeSQNbg==
X-Google-Smtp-Source: AGHT+IHAm/6SO8IQRzaFpWQp1EPz7uA98CA45Ebz5pn9OSZOYucb9ET7zb2IJaj0IgaI9q/zz8yY6/j6DgO7ag==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a05:6902:1083:b0:dff:338c:fde6 with SMTP
 id 3f1490d57ef6-dff338d037emr112068276.6.1718466152662; Sat, 15 Jun 2024
 08:42:32 -0700 (PDT)
Date: Sat, 15 Jun 2024 15:42:31 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.45.2.627.g7a2c4fd464-goog
Message-ID: <20240615154231.234442-1-edumazet@google.com>
Subject: [PATCH net] xfrm6: check ip6_dst_idev() return value in xfrm6_get_saddr()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: David Ahern <dsahern@kernel.org>, Steffen Klassert <steffen.klassert@secunet.com>, 
	netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>, syzbot <syzkaller@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"

ip6_dst_idev() can return NULL, xfrm6_get_saddr() must act accordingly.

syzbot reported:

Oops: general protection fault, probably for non-canonical address 0xdffffc0000000000: 0000 [#1] PREEMPT SMP KASAN PTI
KASAN: null-ptr-deref in range [0x0000000000000000-0x0000000000000007]
CPU: 1 PID: 12 Comm: kworker/u8:1 Not tainted 6.10.0-rc2-syzkaller-00383-gb8481381d4e2 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 04/02/2024
Workqueue: wg-kex-wg1 wg_packet_handshake_send_worker
 RIP: 0010:xfrm6_get_saddr+0x93/0x130 net/ipv6/xfrm6_policy.c:64
Code: df 48 89 fa 48 c1 ea 03 80 3c 02 00 0f 85 97 00 00 00 4c 8b ab d8 00 00 00 48 b8 00 00 00 00 00 fc ff df 4c 89 ea 48 c1 ea 03 <80> 3c 02 00 0f 85 86 00 00 00 4d 8b 6d 00 e8 ca 13 47 01 48 b8 00
RSP: 0018:ffffc90000117378 EFLAGS: 00010246
RAX: dffffc0000000000 RBX: ffff88807b079dc0 RCX: ffffffff89a0d6d7
RDX: 0000000000000000 RSI: ffffffff89a0d6e9 RDI: ffff88807b079e98
RBP: ffff88807ad73248 R08: 0000000000000007 R09: fffffffffffff000
R10: ffff88807b079dc0 R11: 0000000000000007 R12: ffffc90000117480
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
FS:  0000000000000000(0000) GS:ffff8880b9300000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f4586d00440 CR3: 0000000079042000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
  xfrm_get_saddr net/xfrm/xfrm_policy.c:2452 [inline]
  xfrm_tmpl_resolve_one net/xfrm/xfrm_policy.c:2481 [inline]
  xfrm_tmpl_resolve+0xa26/0xf10 net/xfrm/xfrm_policy.c:2541
  xfrm_resolve_and_create_bundle+0x140/0x2570 net/xfrm/xfrm_policy.c:2835
  xfrm_bundle_lookup net/xfrm/xfrm_policy.c:3070 [inline]
  xfrm_lookup_with_ifid+0x4d1/0x1e60 net/xfrm/xfrm_policy.c:3201
  xfrm_lookup net/xfrm/xfrm_policy.c:3298 [inline]
  xfrm_lookup_route+0x3b/0x200 net/xfrm/xfrm_policy.c:3309
  ip6_dst_lookup_flow+0x15c/0x1d0 net/ipv6/ip6_output.c:1256
  send6+0x611/0xd20 drivers/net/wireguard/socket.c:139
  wg_socket_send_skb_to_peer+0xf9/0x220 drivers/net/wireguard/socket.c:178
  wg_socket_send_buffer_to_peer+0x12b/0x190 drivers/net/wireguard/socket.c:200
  wg_packet_send_handshake_initiation+0x227/0x360 drivers/net/wireguard/send.c:40
  wg_packet_handshake_send_worker+0x1c/0x30 drivers/net/wireguard/send.c:51
  process_one_work+0x9fb/0x1b60 kernel/workqueue.c:3231
  process_scheduled_works kernel/workqueue.c:3312 [inline]
  worker_thread+0x6c8/0xf70 kernel/workqueue.c:3393
  kthread+0x2c1/0x3a0 kernel/kthread.c:389
  ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
  ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Reported-by: syzbot <syzkaller@googlegroups.com>
Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/ipv6/xfrm6_policy.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/net/ipv6/xfrm6_policy.c b/net/ipv6/xfrm6_policy.c
index cc885d3aa9e5947b0f087d599c97a020ba6fe385..2f1ea5f999a259a96693566d3e776a1391b70c57 100644
--- a/net/ipv6/xfrm6_policy.c
+++ b/net/ipv6/xfrm6_policy.c
@@ -56,12 +56,18 @@ static int xfrm6_get_saddr(struct net *net, int oif,
 {
 	struct dst_entry *dst;
 	struct net_device *dev;
+	struct inet6_dev *idev;
 
 	dst = xfrm6_dst_lookup(net, 0, oif, NULL, daddr, mark);
 	if (IS_ERR(dst))
 		return -EHOSTUNREACH;
 
-	dev = ip6_dst_idev(dst)->dev;
+	idev = ip6_dst_idev(dst);
+	if (!idev) {
+		dst_release(dst);
+		return -EHOSTUNREACH;
+	}
+	dev = idev->dev;
 	ipv6_dev_get_saddr(dev_net(dev), dev, &daddr->in6, 0, &saddr->in6);
 	dst_release(dst);
 	return 0;
-- 
2.45.2.627.g7a2c4fd464-goog


