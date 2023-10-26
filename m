Return-Path: <netdev+bounces-44515-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DAA697D8615
	for <lists+netdev@lfdr.de>; Thu, 26 Oct 2023 17:37:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8968C1F21CC8
	for <lists+netdev@lfdr.de>; Thu, 26 Oct 2023 15:37:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11F3136B1D;
	Thu, 26 Oct 2023 15:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QonQcWcF"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51B4A2DF6E
	for <netdev@vger.kernel.org>; Thu, 26 Oct 2023 15:37:00 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7F951A6
	for <netdev@vger.kernel.org>; Thu, 26 Oct 2023 08:36:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1698334618;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=IJjvEoYvWtrDPaB3w2lAYudhKDjSds18qR33A85xWaw=;
	b=QonQcWcFAsvtqH2Q6xMDTwTWZw7AQCoCba6EVEdwCbTD/y4fplm/KKeI5L+uzC5jTXYFuY
	uMOXxv8dIUi3lZXEpSLojSiQORgi8scKhVd2f0aH9IH+GDkGbvor+RyzqRtPALxKGqu1T3
	ewCNvjqgZMA1B5HILEEs72V6jiO0gJM=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-373-HjSetu3QPV6ANBHTZEYigw-1; Thu,
 26 Oct 2023 11:36:56 -0400
X-MC-Unique: HjSetu3QPV6ANBHTZEYigw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E0C523C025C2;
	Thu, 26 Oct 2023 15:36:55 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.45.226.53])
	by smtp.corp.redhat.com (Postfix) with ESMTP id CEB6C2166B26;
	Thu, 26 Oct 2023 15:36:53 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: netdev@vger.kernel.org
Cc: Jamal Hadi Salim <jhs@mojatatu.com>,
	Cong Wang <xiyou.wangcong@gmail.com>,
	Jiri Pirko <jiri@resnulli.us>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>,
	Maxim Mikityanskiy <maxtram95@gmail.com>
Subject: [PATCH net] net: sched: fix warn on htb offloaded class creation
Date: Thu, 26 Oct 2023 17:36:48 +0200
Message-ID: <ff51f20f596b01c6d12633e984881be555660ede.1698334391.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6

The following commands:

tc qdisc add dev eth1 handle 2: root htb offload
tc class add dev eth1 parent 2: classid 2:1 htb rate 5mbit burst 15k

yeld to a WARN in the HTB qdisc:

 WARNING: CPU: 2 PID: 1583 at net/sched/sch_htb.c:1959
 CPU: 2 PID: 1583 Comm: tc Kdump: loaded 6.6.0-rc2.mptcp_7895773e5235+ #59
 Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-1.fc37 04/01/2014
 RIP: 0010:htb_change_class+0x25c4/0x2e30 [sch_htb]
 Code: 24 58 48 b8 00 00 00 00 00 fc ff df 48 89 ca 48 c1 ea 03 80 3c 02 00 0f 85 92 01 00 00 49 89 8c 24 b0 01 00 00 e9 77 fc ff ff <0f> 0b e9 15 ec ff ff 80 3d f8 35 00 00 00 0f 85 d4 f9 ff ff ba 32
 RSP: 0018:ffffc900015df240 EFLAGS: 00010246
 RAX: 0000000000000000 RBX: ffff88811b4ca000 RCX: ffff88811db42800
 RDX: 1ffff11023b68502 RSI: ffffffffaf2e6a00 RDI: ffff88811db42810
 RBP: ffff88811db45000 R08: 0000000000000001 R09: fffffbfff664bbc9
 R10: ffffffffb325de4f R11: ffffffffb2d33748 R12: 0000000000000000
 R13: ffff88811db43000 R14: ffff88811b4caaac R15: ffff8881252c0030
 FS:  00007f6c1f126740(0000) GS:ffff88815aa00000(0000) knlGS:0000000000000000
 CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
 CR2: 000055dca8e5b4a8 CR3: 000000011bc7a006 CR4: 0000000000370ee0
 DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
 DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
 Call Trace:
 <TASK>
  tc_ctl_tclass+0x394/0xeb0
  rtnetlink_rcv_msg+0x2f5/0xaa0
  netlink_rcv_skb+0x12e/0x3a0
  netlink_unicast+0x421/0x730
  netlink_sendmsg+0x79e/0xc60
  ____sys_sendmsg+0x95a/0xc20
  ___sys_sendmsg+0xee/0x170
  __sys_sendmsg+0xc6/0x170
 do_syscall_64+0x58/0x80
 entry_SYSCALL_64_after_hwframe+0x6e/0xd8

The first command creates per TX queue pfifo qdiscs in
tc_modify_qdisc() -> htb_init() and grafts the pfifo to each dev_queue
via tc_modify_qdisc() ->  qdisc_graft() -> htb_attach().

When the command completes, the qdisc_sleeping for each dev_queue is a
pfifo one. The next class creation will trigger the reported splat.

Address the issue taking care of old non-builtin qdisc in
htb_change_class().

Fixes: d03b195b5aa0 ("sch_htb: Hierarchical QoS hardware offload")
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
 net/sched/sch_htb.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/net/sched/sch_htb.c b/net/sched/sch_htb.c
index 0d947414e616..dc682bd542b4 100644
--- a/net/sched/sch_htb.c
+++ b/net/sched/sch_htb.c
@@ -1955,8 +1955,7 @@ static int htb_change_class(struct Qdisc *sch, u32 classid,
 				qdisc_refcount_inc(new_q);
 			}
 			old_q = htb_graft_helper(dev_queue, new_q);
-			/* No qdisc_put needed. */
-			WARN_ON(!(old_q->flags & TCQ_F_BUILTIN));
+			qdisc_put(old_q);
 		}
 		sch_tree_lock(sch);
 		if (parent && !parent->level) {
-- 
2.41.0


