Return-Path: <netdev+bounces-276600-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CJ+nJIZz1mkWFggAu9opvQ
	(envelope-from <netdev+bounces-276600-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 08 Apr 2026 17:25:58 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 37CCA3BE28E
	for <lists+netdev@lfdr.de>; Wed, 08 Apr 2026 17:25:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 65D303012E4E
	for <lists+netdev@lfdr.de>; Wed,  8 Apr 2026 15:25:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C47A33D6697;
	Wed,  8 Apr 2026 15:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gEvHzjyS"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 346E73D6462
	for <netdev@vger.kernel.org>; Wed,  8 Apr 2026 15:25:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775661946; cv=none; b=YwaVX1N2Lzg3rWUGsgK/98/nxHcFzOI3DBYrUGGpqZswwKJXyhgIktfTTT1H4oC1lIOvZmlxYF2WEwT10rjILQu6fpy4RtDZFM7jVJRTT4vFWGJXQsc5p2fr9F9ChSSOqn6SllkJuxvII8QjmOsYD+AFxvvJIsr4Jky1g5+P7ZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775661946; c=relaxed/simple;
	bh=JBqXUqciZv4b19JLMXiRndX8nORamWMBphZW+vIi07Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pG347eXEEi6xghCMqsbHryHgIDFznRrZTFfC6CsjByPVyuA+31iuAdyllrc8Zm0KBpt//z9PxB0jZKSZk9DJ7nVPEm6ZXP17dQlcfYkeodX1/+vMxblSuErpQJ423np932DkT7j2xy2mSQIY8YRRVVlpy+VxTj9p/EAJhL80nJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gEvHzjyS; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1775661944;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=QeBf626yrJDb9OP4C01ksC3WHSRSg7JlRymU/UTjqeI=;
	b=gEvHzjySzOiedPr4n6kKAHHycn/T7SW8tglqDAcWh0UTybZ0GtrytEOI4N+4+kJ+R/nK7n
	Vey2JRSQeHQ+EMDNRyWpbrmfZP1/VKpbFhl3zWZO85fmQtdZ93BnDD4cFhDvw06y24lEP4
	SakdNLJYDSD5u8QGsnikJWBhrZ6SB1Q=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-617-TsovwX2bMKOrmMlPkljQxw-1; Wed,
 08 Apr 2026 11:25:40 -0400
X-MC-Unique: TsovwX2bMKOrmMlPkljQxw-1
X-Mimecast-MFC-AGG-ID: TsovwX2bMKOrmMlPkljQxw_1775661938
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id DF110180075A;
	Wed,  8 Apr 2026 15:25:37 +0000 (UTC)
Received: from dcaratti.users.ipa.redhat.com (unknown [10.44.32.176])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 5783C1955D84;
	Wed,  8 Apr 2026 15:25:34 +0000 (UTC)
From: Davide Caratti <dcaratti@redhat.com>
To: Jamal Hadi Salim <jhs@mojatatu.com>,
	Jiri Pirko <jiri@resnulli.us>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Xiang Mei <xmei5@asu.edu>,
	netdev@vger.kernel.org
Cc: Victor Nogueira <victor@mojatatu.com>
Subject: [PATCH net v3] net/sched: cls_fw: fix NULL dereference of "old" filters before change()
Date: Wed,  8 Apr 2026 17:24:36 +0200
Message-ID: <e39cbd3103a337f1e515d186fe697b4459d24757.1775661704.git.dcaratti@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-276600-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dcaratti@redhat.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[redhat.com:+];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[bootlin.com:url,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,mojatatu.com:email]
X-Rspamd-Queue-Id: 37CCA3BE28E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Like pointed out by Sashiko [1], since commit ed76f5edccc9 ("net: sched:
protect filter_chain list with filter_chain_lock mutex") TC filters are
added to a shared block and published to datapath before their ->change()
function is called. This is a problem for cls_fw: an invalid filter
created with the "old" method can still classify some packets before it
is destroyed by the validation logic added by Xiang.
Therefore, insisting with repeated runs of the following script:

 # ip link add dev crash0 type dummy
 # ip link set dev crash0 up
 # mausezahn  crash0 -c 100000 -P 10 \
 > -A 4.3.2.1 -B 1.2.3.4 -t udp "dp=1234" -q &
 # sleep 1
 # tc qdisc add dev crash0 egress_block 1 clsact
 # tc filter add block 1 protocol ip prio 1 matchall \
 > action skbedit mark 65536 continue
 # tc filter add block 1 protocol ip prio 2 fw
 # ip link del dev crash0

can still make fw_classify() hit the WARN_ON() in [2]:

 WARNING: ./include/net/pkt_cls.h:88 at fw_classify+0x244/0x250 [cls_fw], CPU#18: mausezahn/1399
 Modules linked in: cls_fw(E) act_skbedit(E)
 CPU: 18 UID: 0 PID: 1399 Comm: mausezahn Tainted: G            E       7.0.0-rc6-virtme #17 PREEMPT(full)
 Tainted: [E]=UNSIGNED_MODULE
 Hardware name: Red Hat KVM, BIOS 1.16.3-2.el9 04/01/2014
 RIP: 0010:fw_classify+0x244/0x250 [cls_fw]
 Code: 5c 49 c7 45 00 00 00 00 00 41 5d 41 5e 41 5f 5d c3 cc cc cc cc 5b b8 ff ff ff ff 41 5c 41 5d 41 5e 41 5f 5d c3 cc cc cc cc 90 <0f> 0b 90 eb a0 0f 1f 80 00 00 00 00 90 90 90 90 90 90 90 90 90 90
 RSP: 0018:ffffd1b7026bf8a8 EFLAGS: 00010202
 RAX: ffff8c5ac9c60800 RBX: ffff8c5ac99322c0 RCX: 0000000000000004
 RDX: 0000000000000001 RSI: ffff8c5b74d7a000 RDI: ffff8c5ac8284f40
 RBP: ffffd1b7026bf8d0 R08: 0000000000000000 R09: ffffd1b7026bf9b0
 R10: 00000000ffffffff R11: 0000000000000000 R12: 0000000000010000
 R13: ffffd1b7026bf930 R14: ffff8c5ac8284f40 R15: 0000000000000000
 FS:  00007fca40c37740(0000) GS:ffff8c5b74d7a000(0000) knlGS:0000000000000000
 CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
 CR2: 00007fca40e822a0 CR3: 0000000005ca0001 CR4: 0000000000172ef0
 Call Trace:
  <TASK>
  tcf_classify+0x17d/0x5c0
  tc_run+0x9d/0x150
  __dev_queue_xmit+0x2ab/0x14d0
  ip_finish_output2+0x340/0x8f0
  ip_output+0xa4/0x250
  raw_sendmsg+0x147d/0x14b0
  __sys_sendto+0x1cc/0x1f0
  __x64_sys_sendto+0x24/0x30
  do_syscall_64+0x126/0xf80
  entry_SYSCALL_64_after_hwframe+0x77/0x7f
 RIP: 0033:0x7fca40e822ba
 Code: d8 64 89 02 48 c7 c0 ff ff ff ff eb b8 0f 1f 00 f3 0f 1e fa 41 89 ca 64 8b 04 25 18 00 00 00 85 c0 75 15 b8 2c 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 7e c3 0f 1f 44 00 00 41 54 48 83 ec 30 44 89
 RSP: 002b:00007ffc248a42c8 EFLAGS: 00000246 ORIG_RAX: 000000000000002c
 RAX: ffffffffffffffda RBX: 000055ef233289d0 RCX: 00007fca40e822ba
 RDX: 000000000000001e RSI: 000055ef23328c30 RDI: 0000000000000003
 RBP: 000055ef233289d0 R08: 00007ffc248a42d0 R09: 0000000000000010
 R10: 0000000000000000 R11: 0000000000000246 R12: 000000000000001e
 R13: 00000000000186a0 R14: 0000000000000000 R15: 00007fca41043000
  </TASK>
 irq event stamp: 1045778
 hardirqs last  enabled at (1045784): [<ffffffff864ec042>] __up_console_sem+0x52/0x60
 hardirqs last disabled at (1045789): [<ffffffff864ec027>] __up_console_sem+0x37/0x60
 softirqs last  enabled at (1045426): [<ffffffff874d48c7>] __alloc_skb+0x207/0x260
 softirqs last disabled at (1045434): [<ffffffff874fe8f8>] __dev_queue_xmit+0x78/0x14d0

Then, because of the value in the packet's mark, dereference on 'q->handle'
with NULL 'q' occurs:

 BUG: kernel NULL  pointer dereference, address: 0000000000000038
 [...]
 RIP: 0010:fw_classify+0x1fe/0x250 [cls_fw]
 [...]

Skip "old-style" classification on shared blocks, so that the NULL
dereference is fixed and WARN_ON() is not hit anymore in the short
lifetime of invalid cls_fw "old-style" filters.

V2: avoid NULL dereference without hitting WARN_ON() anymore (Sashiko)
V3: correct 'Fixes' tag (Jamal)

[1] https://sashiko.dev/#/patchset/20260331050217.504278-1-xmei5%40asu.edu
[2] https://elixir.bootlin.com/linux/v7.0-rc6/source/include/net/pkt_cls.h#L86

Fixes: faeea8bbf6e9 ("net/sched: cls_fw: fix NULL pointer dereference on shared blocks")
Fixes: ed76f5edccc9 ("net: sched: protect filter_chain list with filter_chain_lock mutex")

Acked-by: Jamal Hadi Salim <jhs@mojatatu.com>
Signed-off-by: Davide Caratti <dcaratti@redhat.com>
---
 net/sched/cls_fw.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/net/sched/cls_fw.c b/net/sched/cls_fw.c
index 23884ef8b80c..646a730dca93 100644
--- a/net/sched/cls_fw.c
+++ b/net/sched/cls_fw.c
@@ -74,9 +74,13 @@ TC_INDIRECT_SCOPE int fw_classify(struct sk_buff *skb,
 			}
 		}
 	} else {
-		struct Qdisc *q = tcf_block_q(tp->chain->block);
+		struct Qdisc *q;
 
 		/* Old method: classify the packet using its skb mark. */
+		if (tcf_block_shared(tp->chain->block))
+			return -1;
+
+		q = tcf_block_q(tp->chain->block);
 		if (id && (TC_H_MAJ(id) == 0 ||
 			   !(TC_H_MAJ(id ^ q->handle)))) {
 			res->classid = id;
-- 
2.52.0


