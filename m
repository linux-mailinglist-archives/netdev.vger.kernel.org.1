Return-Path: <netdev+bounces-262488-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ZkMsLOsZpWnk3AUAu9opvQ
	(envelope-from <netdev+bounces-262488-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 02 Mar 2026 06:02:35 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 9411E1D3048
	for <lists+netdev@lfdr.de>; Mon, 02 Mar 2026 06:02:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 46B9D3004070
	for <lists+netdev@lfdr.de>; Mon,  2 Mar 2026 05:02:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24FC12798F3;
	Mon,  2 Mar 2026 05:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="nDsbAAS9"
X-Original-To: netdev@vger.kernel.org
Received: from canpmsgout10.his.huawei.com (canpmsgout10.his.huawei.com [113.46.200.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 457C172618;
	Mon,  2 Mar 2026 05:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772427750; cv=none; b=Pk0kMAZxhxnQ6PacN1JA7vmjMXVfo9RfKzm2UJ8+T8bOs2KAdjq02KRefH8nPZfaGdaNHYVMc4zp8u2HXCe8vTa8rcO27PhfTe5dCKxKA7tLzEEcrmOL/H7boArmxUdQfs/BZHDCknzoVGYWrzhPoAS0znWuhVvAJtZevgKle3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772427750; c=relaxed/simple;
	bh=JSLnltizuRPn6CwAgjoGO+dMG3OxBLRggzZpbQ0Yo+s=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=RYNApKa/GvFM3H92/l4snGt6wGaUuJ+i3MKgl2E5FZkhE0tIRm06iYekAFg9Nm2Tbm9HO4WwHeggEX80yt1bhqoN6YJttbD1jYQEIkITjUmCA7e3bSloKldM62UOotI9OMKQhunPX/uwp/CWc1E50bIi/TMg62PODrsKGC9PAFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=nDsbAAS9; arc=none smtp.client-ip=113.46.200.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=SI9FLDsxgn0wLMHqZBnpavtvFfxk9bqG169b2B7HPLg=;
	b=nDsbAAS9abg2NHjngiv/ohaxfqN1V/WnTI06HSjcUqzRbWNRtAp6PiC81yK2XcuOihzJlby/V
	IaqqrgvzdkBNWwxP9UOXATJm6y4BZ99K4h/SwgCtYHWdvVbA6bPyGUZ7pXyk9O1d4Xb9+fN+Z2C
	VgOuaUj1tNjkNrKraUfHSbk=
Received: from mail.maildlp.com (unknown [172.19.163.15])
	by canpmsgout10.his.huawei.com (SkyGuard) with ESMTPS id 4fPRWH0KB8z1K97f;
	Mon,  2 Mar 2026 12:57:31 +0800 (CST)
Received: from kwepemj500018.china.huawei.com (unknown [7.202.194.48])
	by mail.maildlp.com (Postfix) with ESMTPS id 7B8D140565;
	Mon,  2 Mar 2026 13:02:18 +0800 (CST)
Received: from huawei.com (10.50.85.128) by kwepemj500018.china.huawei.com
 (7.202.194.48) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 2 Mar
 2026 13:02:17 +0800
From: Li Xiasong <lixiasong1@huawei.com>
To: <matttbe@kernel.org>, <martineau@kernel.org>, <geliang@kernel.org>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <horms@kernel.org>
CC: <netdev@vger.kernel.org>, <mptcp@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <weiyongjun1@huawei.com>,
	<yuehaibing@huawei.com>, <zhangchangzhong@huawei.com>
Subject: [PATCH net] mptcp: fix soft lockup in mptcp_recvmsg()
Date: Mon, 2 Mar 2026 13:26:51 +0800
Message-ID: <20260302052651.1466983-1-lixiasong1@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems500001.china.huawei.com (7.221.188.70) To
 kwepemj500018.china.huawei.com (7.202.194.48)
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[huawei.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4];
	R_DKIM_ALLOW(-0.20)[huawei.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-262488-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lixiasong1@huawei.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	DKIM_TRACE(0.00)[huawei.com:+];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCPT_COUNT_TWELVE(0.00)[14];
	DBL_BLOCKED_OPENRESOLVER(0.00)[huawei.com:mid,huawei.com:dkim,huawei.com:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 9411E1D3048
X-Rspamd-Action: no action

syzbot reported a soft lockup in mptcp_recvmsg() [0].

When receiving data with MSG_PEEK | MSG_WAITALL flags, the skb is not
removed from the sk_receive_queue. This causes sk_wait_data() to always
find available data and never perform actual waiting, leading to a soft
lockup.

Fix this by adding a 'last' parameter to track the last peeked skb.
This allows sk_wait_data() to make informed waiting decisions and prevent
infinite loops when MSG_PEEK is used.

[0]:
watchdog: BUG: soft lockup - CPU#2 stuck for 156s! [server:1963]
Modules linked in:
CPU: 2 UID: 0 PID: 1963 Comm: server Not tainted 6.19.0-rc8 #61 PREEMPT(none)
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/01/2014
RIP: 0010:sk_wait_data+0x15/0x190
Code: 80 00 00 00 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 f3 0f 1e fa 41 56 41 55 41 54 49 89 f4 55 48 89 d5 53 48 89 fb <48> 83 ec 30 65 48 8b 05 17 a4 6b 01 48 89 44 24 28 31 c0 65 48 8b
RSP: 0018:ffffc90000603ca0 EFLAGS: 00000246
RAX: 0000000000000000 RBX: ffff888102bf0800 RCX: 0000000000000001
RDX: 0000000000000000 RSI: ffffc90000603d18 RDI: ffff888102bf0800
RBP: 0000000000000000 R08: 0000000000000002 R09: 0000000000000101
R10: 0000000000000000 R11: 0000000000000075 R12: ffffc90000603d18
R13: ffff888102bf0800 R14: ffff888102bf0800 R15: 0000000000000000
FS:  00007f6e38b8c4c0(0000) GS:ffff8881b877e000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000055aa7bff1680 CR3: 0000000105cbe000 CR4: 00000000000006f0
Call Trace:
 <TASK>
 mptcp_recvmsg+0x547/0x8c0 net/mptcp/protocol.c:2329
 inet_recvmsg+0x11f/0x130 net/ipv4/af_inet.c:891
 sock_recvmsg+0x94/0xc0 net/socket.c:1100
 __sys_recvfrom+0xb2/0x130 net/socket.c:2256
 __x64_sys_recvfrom+0x1f/0x30 net/socket.c:2267
 do_syscall_64+0x59/0x2d0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x76/0x7e arch/x86/entry/entry_64.S:131
RIP: 0033:0x7f6e386a4a1d
Code: 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 8d 05 f1 de 2c 00 41 89 ca 8b 00 85 c0 75 20 45 31 c9 45 31 c0 b8 2d 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 6b f3 c3 66 0f 1f 84 00 00 00 00 00 41 56 41
RSP: 002b:00007ffc3c4bb078 EFLAGS: 00000246 ORIG_RAX: 000000000000002d
RAX: ffffffffffffffda RBX: 000000000000861e RCX: 00007f6e386a4a1d
RDX: 00000000000003ff RSI: 00007ffc3c4bb150 RDI: 0000000000000004
RBP: 00007ffc3c4bb570 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000103 R11: 0000000000000246 R12: 00005605dbc00be0
R13: 00007ffc3c4bb650 R14: 0000000000000000 R15: 0000000000000000
 </TASK>

Fixes: 612f71d7328c ("mptcp: fix possible stall on recvmsg()")
Signed-off-by: Li Xiasong <lixiasong1@huawei.com>
---
 net/mptcp/protocol.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index cf1852b99963..7a65c2101f63 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -2006,7 +2006,7 @@ static void mptcp_eat_recv_skb(struct sock *sk, struct sk_buff *skb)
 static int __mptcp_recvmsg_mskq(struct sock *sk, struct msghdr *msg,
 				size_t len, int flags, int copied_total,
 				struct scm_timestamping_internal *tss,
-				int *cmsg_flags)
+				int *cmsg_flags, struct sk_buff **last)
 {
 	struct mptcp_sock *msk = mptcp_sk(sk);
 	struct sk_buff *skb, *tmp;
@@ -2058,6 +2058,8 @@ static int __mptcp_recvmsg_mskq(struct sock *sk, struct msghdr *msg,
 			}
 
 			mptcp_eat_recv_skb(sk, skb);
+		} else {
+			*last = skb;
 		}
 
 		if (copied >= len)
@@ -2263,6 +2265,7 @@ static int mptcp_recvmsg(struct sock *sk, struct msghdr *msg, size_t len,
 {
 	struct mptcp_sock *msk = mptcp_sk(sk);
 	struct scm_timestamping_internal tss;
+	struct sk_buff *last = NULL;
 	int copied = 0, cmsg_flags = 0;
 	int target;
 	long timeo;
@@ -2291,7 +2294,8 @@ static int mptcp_recvmsg(struct sock *sk, struct msghdr *msg, size_t len,
 		int err, bytes_read;
 
 		bytes_read = __mptcp_recvmsg_mskq(sk, msg, len - copied, flags,
-						  copied, &tss, &cmsg_flags);
+						  copied, &tss, &cmsg_flags,
+						  &last);
 		if (unlikely(bytes_read < 0)) {
 			if (!copied)
 				copied = bytes_read;
@@ -2343,7 +2347,7 @@ static int mptcp_recvmsg(struct sock *sk, struct msghdr *msg, size_t len,
 
 		pr_debug("block timeout %ld\n", timeo);
 		mptcp_cleanup_rbuf(msk, copied);
-		err = sk_wait_data(sk, &timeo, NULL);
+		err = sk_wait_data(sk, &timeo, last);
 		if (err < 0) {
 			err = copied ? : err;
 			goto out_err;
-- 
2.34.1


