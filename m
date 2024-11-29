Return-Path: <netdev+bounces-147826-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EFD3C9DC212
	for <lists+netdev@lfdr.de>; Fri, 29 Nov 2024 11:24:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 43ADFB22AEB
	for <lists+netdev@lfdr.de>; Fri, 29 Nov 2024 10:24:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FFAD18871F;
	Fri, 29 Nov 2024 10:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EleEvsev"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CBD7155753
	for <netdev@vger.kernel.org>; Fri, 29 Nov 2024 10:24:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732875847; cv=none; b=f4k5QP//wJDQhbLmcozLia9VvLuTYfjn3C+kwB32yY8q0eVX4LSAbPbvCptLxhta5hkY3OORQH58mFtgo8tvXoJzqgLNt8kJnWKxib6h1falrRnGnNyRFr9nKZxgU8mtFX5GMD7GdOZb1DNicimKYHa2vtBX25i5uKHsZko2tnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732875847; c=relaxed/simple;
	bh=bp1dpJ7XiglTtRRk1q/l8D9A6XcFLu2Gaf0BL68PsbM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=d6okZ/UuGmNI4EeUKYgh+rD24lJSeuXhDWB5TJbbQ+kfG2+a4dEL6dqWb0wD5SvRAb69h0YKyeTmGkBui6+Du6rUocGN5/WkRcRagjZ0AP5qvvjHmcSVXVxYVVQ1M6tH4EV9cR94qhNB014E7xCnLGN+Hj6HDmziUeZHFkhflxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EleEvsev; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732875844;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=y+JZgHZfU+2Ig5z6/h9roPuo2NFzj8Ai+XvBMEM1eSo=;
	b=EleEvsevWajC16Zca5PILdGpGrVxp4EDoETF5hUGcfl64Tu3/mkPO6UvCcZAlamtvCW6uS
	p3ehS8LyYzfDre7Vkzhrkpve3hCMrKhcylZVzs3RgI837/GH3cKifsjbirI05C9F76iTXC
	MrvdFbdjBRnr5iz30CZRyGkii7+3e08=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-372-andVmOCGP1Om0lVkeG1U5Q-1; Fri,
 29 Nov 2024 05:23:59 -0500
X-MC-Unique: andVmOCGP1Om0lVkeG1U5Q-1
X-Mimecast-MFC-AGG-ID: andVmOCGP1Om0lVkeG1U5Q
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 01CE71944D36;
	Fri, 29 Nov 2024 10:23:58 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.39.193.89])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id BAFD81955F3F;
	Fri, 29 Nov 2024 10:23:55 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Simon Horman <horms@kernel.org>
Subject: [PATCH net] ipmr: tune the ipmr_can_free_table() checks.
Date: Fri, 29 Nov 2024 11:23:48 +0100
Message-ID: <fe340d0aaea857d7401b537f1e43e534b69470a2.1732875656.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

Eric reported a syzkaller-triggered splat caused by recent ipmr changes:

WARNING: CPU: 2 PID: 6041 at net/ipv6/ip6mr.c:419
ip6mr_free_table+0xbd/0x120 net/ipv6/ip6mr.c:419
Modules linked in:
CPU: 2 UID: 0 PID: 6041 Comm: syz-executor183 Not tainted
6.12.0-syzkaller-10681-g65ae975e97d5 #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS
1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
RIP: 0010:ip6mr_free_table+0xbd/0x120 net/ipv6/ip6mr.c:419
Code: 00 00 48 b8 00 00 00 00 00 fc ff df 48 89 fa 48 c1 ea 03 80 3c
02 00 75 58 49 83 bc 24 c0 0e 00 00 00 74 09 e8 44 ef a9 f7 90 <0f> 0b
90 e8 3b ef a9 f7 48 8d 7b 38 e8 12 a3 96 f7 48 89 df be 0f
RSP: 0018:ffffc90004267bd8 EFLAGS: 00010293
RAX: 0000000000000000 RBX: ffff88803c710000 RCX: ffffffff89e4d844
RDX: ffff88803c52c880 RSI: ffffffff89e4d87c RDI: ffff88803c578ec0
RBP: 0000000000000001 R08: 0000000000000005 R09: 0000000000000000
R10: 0000000000000001 R11: 0000000000000001 R12: ffff88803c578000
R13: ffff88803c710000 R14: ffff88803c710008 R15: dead000000000100
FS: 00007f7a855ee6c0(0000) GS:ffff88806a800000(0000) knlGS:0000000000000000
CS: 0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f7a85689938 CR3: 000000003c492000 CR4: 0000000000352ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
<TASK>
ip6mr_rules_exit+0x176/0x2d0 net/ipv6/ip6mr.c:283
ip6mr_net_exit_batch+0x53/0xa0 net/ipv6/ip6mr.c:1388
ops_exit_list+0x128/0x180 net/core/net_namespace.c:177
setup_net+0x4fe/0x860 net/core/net_namespace.c:394
copy_net_ns+0x2b4/0x6b0 net/core/net_namespace.c:500
create_new_namespaces+0x3ea/0xad0 kernel/nsproxy.c:110
unshare_nsproxy_namespaces+0xc0/0x1f0 kernel/nsproxy.c:228
ksys_unshare+0x45d/0xa40 kernel/fork.c:3334
__do_sys_unshare kernel/fork.c:3405 [inline]
__se_sys_unshare kernel/fork.c:3403 [inline]
__x64_sys_unshare+0x31/0x40 kernel/fork.c:3403
do_syscall_x64 arch/x86/entry/common.c:52 [inline]
do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f7a856332d9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 51 18 00 00 90 48 89 f8 48
89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d
01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f7a855ee238 EFLAGS: 00000246 ORIG_RAX: 0000000000000110
RAX: ffffffffffffffda RBX: 00007f7a856bd308 RCX: 00007f7a856332d9
RDX: 00007f7a8560f8c6 RSI: 0000000000000000 RDI: 0000000062040200
RBP: 00007f7a856bd300 R08: 00007fff932160a7 R09: 00007f7a855ee6c0
R10: 0000000000000000 R11: 0000000000000246 R12: 00007f7a856bd30c
R13: 0000000000000000 R14: 00007fff93215fc0 R15: 00007fff932160a8
</TASK>

The root cause is a network namespace creation failing after successful
initialization of the ipmr subsystem. Such a case is not currently
matched by the ipmr_can_free_table() helper.

New namespaces are zeroed on allocation and inserted into net ns list
only after successful creation; when deleting an ipmr table, the list
next pointer can be NULL only on netns initialization failure.

Update the ipmr_can_free_table() checks leveraging such condition.

Reported-by: Eric Dumazet <edumazet@google.com>
Fixes: 11b6e701bce9 ("ipmr: add debug check for mr table cleanup")
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
 net/ipv4/ipmr.c  | 2 +-
 net/ipv6/ip6mr.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/ipv4/ipmr.c b/net/ipv4/ipmr.c
index c5b8ec5c0a8c..d814a352cc05 100644
--- a/net/ipv4/ipmr.c
+++ b/net/ipv4/ipmr.c
@@ -122,7 +122,7 @@ static void ipmr_expire_process(struct timer_list *t);
 
 static bool ipmr_can_free_table(struct net *net)
 {
-	return !check_net(net) || !net->ipv4.mr_rules_ops;
+	return !check_net(net) || !net->list.next;
 }
 
 static struct mr_table *ipmr_mr_table_iter(struct net *net,
diff --git a/net/ipv6/ip6mr.c b/net/ipv6/ip6mr.c
index 7f1902ac3586..37224a5f1bbe 100644
--- a/net/ipv6/ip6mr.c
+++ b/net/ipv6/ip6mr.c
@@ -110,7 +110,7 @@ static void ipmr_expire_process(struct timer_list *t);
 
 static bool ip6mr_can_free_table(struct net *net)
 {
-	return !check_net(net) || !net->ipv6.mr6_rules_ops;
+	return !check_net(net) || !net->list.next;
 }
 
 static struct mr_table *ip6mr_mr_table_iter(struct net *net,
-- 
2.45.2


