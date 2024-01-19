Return-Path: <netdev+bounces-64302-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 87EC5832310
	for <lists+netdev@lfdr.de>; Fri, 19 Jan 2024 02:42:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DA1F82841AE
	for <lists+netdev@lfdr.de>; Fri, 19 Jan 2024 01:42:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 236DFECE;
	Fri, 19 Jan 2024 01:42:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="Rgd2Q1xP"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-6002.amazon.com (smtp-fw-6002.amazon.com [52.95.49.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D47F10E4
	for <netdev@vger.kernel.org>; Fri, 19 Jan 2024 01:42:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.95.49.90
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705628530; cv=none; b=dN5kSRU0y7eBwL5iFR9N037IfboZ8ervvwViac0qi8op2vI/h6e8o/dqdV+HVk48KFlyWnXSbZTiZgfkQIve5kiwxMmMui1R6KUrLjNGBCjKQKKvWJbS5Kj+faLn25fu+vSnwTUFpclnGdgXlfAb2kgLIJSSIzmuaENK6I0ZpTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705628530; c=relaxed/simple;
	bh=Qn/z7AK9skTK1jUDFD8gXrRREbyaQbpjyeATa5wung4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=m9AxiQTV1uunrVhqYCpLBJlcKA63z77jX2qLhi/WAYtinb9GJoQVW6DeE2ebvztfOR8SD244+pBtfxi2S6AZ64wneTD57RGMG1LkNC1esoIhgvpxHzwhJyhhfSLtwnqseLV8oowihrw9JLzFWieBsEFH1eC9xYdLlLdMnQc0oJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=Rgd2Q1xP; arc=none smtp.client-ip=52.95.49.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1705628528; x=1737164528;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=BSM6VNDOlg2w7JCCVaB3kn8R1Ii3HX4Es0+UWQYBfZA=;
  b=Rgd2Q1xPFxMJQwwcopljMUDCY3Md2RrecD1JhXUxvZT05cyXx6fd2toA
   8rYoHMaEzw9pfZwoezCb9B+CLq4Kaoh9/gr7UI7LXrVwNzjQ5/JiY4SHF
   4rypWEtFCCZ1k9xGqy7CBT9DmmC/N/e/6UkWaOd0TUE0GwPpwKPOn9v7i
   o=;
X-IronPort-AV: E=Sophos;i="6.05,203,1701129600"; 
   d="scan'208";a="380752560"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-iad-1d-m6i4x-f05d30a1.us-east-1.amazon.com) ([10.43.8.6])
  by smtp-border-fw-6002.iad6.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2024 01:42:06 +0000
Received: from smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev (iad7-ws-svc-p70-lb3-vlan3.iad.amazon.com [10.32.235.38])
	by email-inbound-relay-iad-1d-m6i4x-f05d30a1.us-east-1.amazon.com (Postfix) with ESMTPS id EEB5D8072B;
	Fri, 19 Jan 2024 01:42:03 +0000 (UTC)
Received: from EX19MTAUWB001.ant.amazon.com [10.0.7.35:7497]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.23.164:2525] with esmtp (Farcaster)
 id 0d0af359-c3cd-4377-b809-53eeeba2b308; Fri, 19 Jan 2024 01:42:03 +0000 (UTC)
X-Farcaster-Flow-ID: 0d0af359-c3cd-4377-b809-53eeeba2b308
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Fri, 19 Jan 2024 01:42:02 +0000
Received: from 88665a182662.ant.amazon.com (10.88.183.204) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Fri, 19 Jan 2024 01:42:00 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>
CC: Paul Gortmaker <paul.gortmaker@windriver.com>, Kuniyuki Iwashima
	<kuniyu@amazon.com>, Kuniyuki Iwashima <kuni1840@gmail.com>,
	<netdev@vger.kernel.org>,
	<syzbot+b5ad66046b913bc04c6f@syzkaller.appspotmail.com>
Subject: [PATCH v1 net] llc: Initialise addr before __llc_lookup().
Date: Thu, 18 Jan 2024 17:41:49 -0800
Message-ID: <20240119014149.60438-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D043UWA004.ant.amazon.com (10.13.139.41) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)
Precedence: Bulk

syzbot reported an uninit-value bug below. [0]

llc supports ETH_P_802_2 (0x0004) and used to support ETH_P_TR_802_2
(0x0011), and syzbot abused the latter to trigger the bug.

  write$tun(r0, &(0x7f0000000040)={@val={0x0, 0x11}, @val, @mpls={[], @llc={@snap={0xaa, 0x1, ')', "90e5dd"}}}}, 0x16)

llc_conn_handler() initialises local variables {saddr,daddr}.mac
based on skb in llc_pdu_decode_sa()/llc_pdu_decode_da() and passes
them to __llc_lookup().

However, the initialisation is done only when skb->protocol is
htons(ETH_P_802_2), otherwise, __llc_lookup_established() and
__llc_lookup_listener() will read garbage.

The missing initialisation existed prior to commit 211ed865108e
("net: delete all instances of special processing for token ring").

It removed the part to kick out the token ring stuff but forgot to
close the door allowing ETH_P_TR_802_2 packets to sneak into llc_rcv().

Let's remove llc_tr_packet_type and complete the deprecation.

[0]:
BUG: KMSAN: uninit-value in __llc_lookup_established+0xe9d/0xf90
 __llc_lookup_established+0xe9d/0xf90
 __llc_lookup net/llc/llc_conn.c:611 [inline]
 llc_conn_handler+0x4bd/0x1360 net/llc/llc_conn.c:791
 llc_rcv+0xfbb/0x14a0 net/llc/llc_input.c:206
 __netif_receive_skb_one_core net/core/dev.c:5527 [inline]
 __netif_receive_skb+0x1a6/0x5a0 net/core/dev.c:5641
 netif_receive_skb_internal net/core/dev.c:5727 [inline]
 netif_receive_skb+0x58/0x660 net/core/dev.c:5786
 tun_rx_batched+0x3ee/0x980 drivers/net/tun.c:1555
 tun_get_user+0x53af/0x66d0 drivers/net/tun.c:2002
 tun_chr_write_iter+0x3af/0x5d0 drivers/net/tun.c:2048
 call_write_iter include/linux/fs.h:2020 [inline]
 new_sync_write fs/read_write.c:491 [inline]
 vfs_write+0x8ef/0x1490 fs/read_write.c:584
 ksys_write+0x20f/0x4c0 fs/read_write.c:637
 __do_sys_write fs/read_write.c:649 [inline]
 __se_sys_write fs/read_write.c:646 [inline]
 __x64_sys_write+0x93/0xd0 fs/read_write.c:646
 do_syscall_x64 arch/x86/entry/common.c:51 [inline]
 do_syscall_64+0x44/0x110 arch/x86/entry/common.c:82
 entry_SYSCALL_64_after_hwframe+0x63/0x6b

Local variable daddr created at:
 llc_conn_handler+0x53/0x1360 net/llc/llc_conn.c:783
 llc_rcv+0xfbb/0x14a0 net/llc/llc_input.c:206

CPU: 1 PID: 5004 Comm: syz-executor994 Not tainted 6.6.0-syzkaller-14500-g1c41041124bd #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/09/2023

Fixes: 211ed865108e ("net: delete all instances of special processing for token ring")
Reported-by: syzbot+b5ad66046b913bc04c6f@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=b5ad66046b913bc04c6f
Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 include/net/llc_pdu.h | 6 ++----
 net/llc/llc_core.c    | 7 -------
 2 files changed, 2 insertions(+), 11 deletions(-)

diff --git a/include/net/llc_pdu.h b/include/net/llc_pdu.h
index 7e73f8e5e497..1d55ba7c45be 100644
--- a/include/net/llc_pdu.h
+++ b/include/net/llc_pdu.h
@@ -262,8 +262,7 @@ static inline void llc_pdu_header_init(struct sk_buff *skb, u8 type,
  */
 static inline void llc_pdu_decode_sa(struct sk_buff *skb, u8 *sa)
 {
-	if (skb->protocol == htons(ETH_P_802_2))
-		memcpy(sa, eth_hdr(skb)->h_source, ETH_ALEN);
+	memcpy(sa, eth_hdr(skb)->h_source, ETH_ALEN);
 }
 
 /**
@@ -275,8 +274,7 @@ static inline void llc_pdu_decode_sa(struct sk_buff *skb, u8 *sa)
  */
 static inline void llc_pdu_decode_da(struct sk_buff *skb, u8 *da)
 {
-	if (skb->protocol == htons(ETH_P_802_2))
-		memcpy(da, eth_hdr(skb)->h_dest, ETH_ALEN);
+	memcpy(da, eth_hdr(skb)->h_dest, ETH_ALEN);
 }
 
 /**
diff --git a/net/llc/llc_core.c b/net/llc/llc_core.c
index 6e387aadffce..4f16d9c88350 100644
--- a/net/llc/llc_core.c
+++ b/net/llc/llc_core.c
@@ -135,22 +135,15 @@ static struct packet_type llc_packet_type __read_mostly = {
 	.func = llc_rcv,
 };
 
-static struct packet_type llc_tr_packet_type __read_mostly = {
-	.type = cpu_to_be16(ETH_P_TR_802_2),
-	.func = llc_rcv,
-};
-
 static int __init llc_init(void)
 {
 	dev_add_pack(&llc_packet_type);
-	dev_add_pack(&llc_tr_packet_type);
 	return 0;
 }
 
 static void __exit llc_exit(void)
 {
 	dev_remove_pack(&llc_packet_type);
-	dev_remove_pack(&llc_tr_packet_type);
 }
 
 module_init(llc_init);
-- 
2.30.2


