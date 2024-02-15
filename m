Return-Path: <netdev+bounces-72210-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 90703857123
	for <lists+netdev@lfdr.de>; Fri, 16 Feb 2024 00:05:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3C1DE28398F
	for <lists+netdev@lfdr.de>; Thu, 15 Feb 2024 23:05:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76EBB13B2BF;
	Thu, 15 Feb 2024 23:05:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="rrWoIOXM"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-33001.amazon.com (smtp-fw-33001.amazon.com [207.171.190.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A27211E4AE
	for <netdev@vger.kernel.org>; Thu, 15 Feb 2024 23:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.171.190.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708038337; cv=none; b=qR9YLkwtZa2vHkyUaUNVES08Ya7jwoDBYe7pbgrcHF+QCdOp4ZiPWRG6cIzq5/WInwzuwsDTqDXwExM/Jsp0jrKSn3nuNQD4CcUaNGyrqSu1ayRpzWjD8WMQ2KBmJfR44+k2Hs2y1NO7JG6WwEpEfYIhadWM8DLBJ7qv0C7iz50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708038337; c=relaxed/simple;
	bh=vKUu7hivMDbu3KyIuKtcTQYyUEeb1g9mn5XSbpRXVo0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=XQ2t+o73SDUbnBkXs9rBEIpyuCMbu7AhHtfCvnd8zlv/6MROWY9Ne0xuGBZLy26luOS/roQqO50X4ao/00+gUK+EB+7czia77AgZuIjm+iaXBOANJNU44RJluvfk726R8ZPeLbQyfGhBdu1IAhFM2zD9LnCR9JBq5KgIl3rDQF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=rrWoIOXM; arc=none smtp.client-ip=207.171.190.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1708038336; x=1739574336;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=OkcLFtL1qPyMk+sN1FAiMSexfh2noeDmPDsn1Criuk4=;
  b=rrWoIOXMMZD31JSz28YmvI+4P8QknipahdboTBkEruhbv5wIuh7T27aG
   fhzGPsujDWBoLHF+J+GHvjtjoAiatueyP/XzQtgFKCBrSyFUxJJ4yUvhP
   8TsUdUc2VEAk5YHpywIrbKlFQ5gqgAcMDn5myGdIh9C7HDEORzEgq/ovD
   M=;
X-IronPort-AV: E=Sophos;i="6.06,162,1705363200"; 
   d="scan'208";a="327307682"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-33001.sea14.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2024 23:05:29 +0000
Received: from EX19MTAUWB001.ant.amazon.com [10.0.21.151:54048]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.34.156:2525] with esmtp (Farcaster)
 id c0ac24ed-9db4-4b42-9b9a-80d0de5e49bf; Thu, 15 Feb 2024 23:05:28 +0000 (UTC)
X-Farcaster-Flow-ID: c0ac24ed-9db4-4b42-9b9a-80d0de5e49bf
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Thu, 15 Feb 2024 23:05:27 +0000
Received: from 88665a182662.ant.amazon.com (10.187.170.20) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Thu, 15 Feb 2024 23:05:25 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>
CC: Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <netdev@vger.kernel.org>, syzkaller
	<syzkaller@googlegroups.com>, Bjoern Doebel <doebel@amazon.de>
Subject: [PATCH v1 net] arp: Prevent overflow in arp_req_get().
Date: Thu, 15 Feb 2024 15:05:16 -0800
Message-ID: <20240215230516.31330-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D039UWB004.ant.amazon.com (10.13.138.57) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

syzkaller reported an overflown write in arp_req_get(). [0]

When ioctl(SIOCGARP) is issued, arp_req_get() looks up an neighbour
entry and copies neigh->ha to struct arpreq.arp_ha.sa_data.

The arp_ha here is struct sockaddr, not struct sockaddr_storage, so
the sa_data buffer is just 14 bytes.

In the splat below, 2 bytes are overflown to the next int field,
arp_flags.  We initialise the field just after the memcpy(), so it's
not a problem.

However, when dev->addr_len is greater than 22 (e.g. MAX_ADDR_LEN),
arp_netmask is overwritten, which could be set as htonl(0xFFFFFFFFUL)
in arp_ioctl() before calling arp_req_get().

To avoid the overflow, let's limit the max length of memcpy().

Note that commit b5f0de6df6dc ("net: dev: Convert sa_data to flexible
array in struct sockaddr") just silenced syzkaller.

[0]:
memcpy: detected field-spanning write (size 16) of single field "r->arp_ha.sa_data" at net/ipv4/arp.c:1128 (size 14)
WARNING: CPU: 0 PID: 144638 at net/ipv4/arp.c:1128 arp_req_get+0x411/0x4a0 net/ipv4/arp.c:1128
Modules linked in:
CPU: 0 PID: 144638 Comm: syz-executor.4 Not tainted 6.1.74 #31
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.0-debian-1.16.0-5 04/01/2014
RIP: 0010:arp_req_get+0x411/0x4a0 net/ipv4/arp.c:1128
Code: fd ff ff e8 41 42 de fb b9 0e 00 00 00 4c 89 fe 48 c7 c2 20 6d ab 87 48 c7 c7 80 6d ab 87 c6 05 25 af 72 04 01 e8 5f 8d ad fb <0f> 0b e9 6c fd ff ff e8 13 42 de fb be 03 00 00 00 4c 89 e7 e8 a6
RSP: 0018:ffffc900050b7998 EFLAGS: 00010286
RAX: 0000000000000000 RBX: ffff88803a815000 RCX: 0000000000000000
RDX: 0000000000000000 RSI: ffffffff8641a44a RDI: 0000000000000001
RBP: ffffc900050b7a98 R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000000 R11: 203a7970636d656d R12: ffff888039c54000
R13: 1ffff92000a16f37 R14: ffff88803a815084 R15: 0000000000000010
FS:  00007f172bf306c0(0000) GS:ffff88805aa00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f172b3569f0 CR3: 0000000057f12005 CR4: 0000000000770ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
PKRU: 55555554
Call Trace:
 <TASK>
 arp_ioctl+0x33f/0x4b0 net/ipv4/arp.c:1261
 inet_ioctl+0x314/0x3a0 net/ipv4/af_inet.c:981
 sock_do_ioctl+0xdf/0x260 net/socket.c:1204
 sock_ioctl+0x3ef/0x650 net/socket.c:1321
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:870 [inline]
 __se_sys_ioctl fs/ioctl.c:856 [inline]
 __x64_sys_ioctl+0x18e/0x220 fs/ioctl.c:856
 do_syscall_x64 arch/x86/entry/common.c:51 [inline]
 do_syscall_64+0x37/0x90 arch/x86/entry/common.c:81
 entry_SYSCALL_64_after_hwframe+0x64/0xce
RIP: 0033:0x7f172b262b8d
Code: 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 00 f3 0f 1e fa 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f172bf300b8 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007f172b3abf80 RCX: 00007f172b262b8d
RDX: 0000000020000000 RSI: 0000000000008954 RDI: 0000000000000003
RBP: 00007f172b2d3493 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 000000000000000b R14: 00007f172b3abf80 R15: 00007f172bf10000
 </TASK>

Reported-by: syzkaller <syzkaller@googlegroups.com>
Reported-by: Bjoern Doebel <doebel@amazon.de>
Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 net/ipv4/arp.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/ipv4/arp.c b/net/ipv4/arp.c
index 9456f5bb35e5..0d0d725b46ad 100644
--- a/net/ipv4/arp.c
+++ b/net/ipv4/arp.c
@@ -1125,7 +1125,8 @@ static int arp_req_get(struct arpreq *r, struct net_device *dev)
 	if (neigh) {
 		if (!(READ_ONCE(neigh->nud_state) & NUD_NOARP)) {
 			read_lock_bh(&neigh->lock);
-			memcpy(r->arp_ha.sa_data, neigh->ha, dev->addr_len);
+			memcpy(r->arp_ha.sa_data, neigh->ha,
+			       min(dev->addr_len, sizeof(r->arp_ha.sa_data_min)));
 			r->arp_flags = arp_state_to_flags(neigh);
 			read_unlock_bh(&neigh->lock);
 			r->arp_ha.sa_family = dev->type;
-- 
2.30.2


