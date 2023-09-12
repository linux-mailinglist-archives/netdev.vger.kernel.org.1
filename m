Return-Path: <netdev+bounces-33000-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C563679C2C0
	for <lists+netdev@lfdr.de>; Tue, 12 Sep 2023 04:28:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EA5F21C209CD
	for <lists+netdev@lfdr.de>; Tue, 12 Sep 2023 02:28:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97676154AD;
	Tue, 12 Sep 2023 02:28:16 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88914443D
	for <netdev@vger.kernel.org>; Tue, 12 Sep 2023 02:28:16 +0000 (UTC)
Received: from smtp-fw-6002.amazon.com (smtp-fw-6002.amazon.com [52.95.49.90])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C2887DA0
	for <netdev@vger.kernel.org>; Mon, 11 Sep 2023 19:28:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1694485692; x=1726021692;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=5ZhcbhdfrKFCbg4kzUpV5oSSMwZfGfgNy953iXUg51U=;
  b=DpTdy1gISzgKRNBDC9GJEe0HNu47bCTBPCWiygQ5i/UE8GRq4JbmbwsO
   H5Piegrq2V/wZ6BWj5bXgDa78TIBQ4NUeh1PgRPqAexSKmylsrBq3jJJQ
   NPHqqZSa3HJ+Cbj91xI5F8PI25brn2kqI6TVjeIAqPwMwm9MMGfBXBykG
   U=;
X-IronPort-AV: E=Sophos;i="6.02,244,1688428800"; 
   d="scan'208";a="355735725"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-pdx-2c-m6i4x-fa5fe5fb.us-west-2.amazon.com) ([10.43.8.6])
  by smtp-border-fw-6002.iad6.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2023 02:28:08 +0000
Received: from EX19MTAUWA002.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan2.pdx.amazon.com [10.236.137.194])
	by email-inbound-relay-pdx-2c-m6i4x-fa5fe5fb.us-west-2.amazon.com (Postfix) with ESMTPS id A8D6C40DAF;
	Tue, 12 Sep 2023 02:28:06 +0000 (UTC)
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.37; Tue, 12 Sep 2023 02:28:06 +0000
Received: from 88665a182662.ant.amazon.com (10.187.171.14) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.37; Tue, 12 Sep 2023 02:28:03 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>
CC: Shigeru Yoshida <syoshida@redhat.com>, Tom Herbert <tom@herbertland.com>,
	Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v1 net] kcm: Fix error handling for SOCK_DGRAM in kcm_sendmsg().
Date: Mon, 11 Sep 2023 19:27:53 -0700
Message-ID: <20230912022753.33327-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.187.171.14]
X-ClientProxiedBy: EX19D044UWA001.ant.amazon.com (10.13.139.100) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)
Precedence: Bulk

syzkaller found a memory leak in kcm_sendmsg(), and commit c821a88bd720
("kcm: Fix memory leak in error path of kcm_sendmsg()") suppressed it by
updating kcm_tx_msg(head)->last_skb if partial data is copied so that the
following sendmsg() will resume from the skb.

However, we cannot know how many bytes were copied when we get the error.
Thus, we could mess up the MSG_MORE queue.

When kcm_sendmsg() fails for SOCK_DGRAM, we should purge the queue as we
do so for UDP by udp_flush_pending_frames().

Even without this change, when the error occurred, the following sendmsg()
resumed from a wrong skb and the queue was messed up.  However, we have
yet to get such a report, and only syzkaller stumbled on it.  So, this
can be changed safely.

Note this does not change SOCK_SEQPACKET behaviour.

Fixes: c821a88bd720 ("kcm: Fix memory leak in error path of kcm_sendmsg()")
Fixes: ab7ac4eb9832 ("kcm: Kernel Connection Multiplexor module")
Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
Resending due to delivery failure for netdev mailing list.
---
 net/kcm/kcmsock.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/net/kcm/kcmsock.c b/net/kcm/kcmsock.c
index 740539a218b7..dd1d8ffd5f59 100644
--- a/net/kcm/kcmsock.c
+++ b/net/kcm/kcmsock.c
@@ -930,17 +930,18 @@ static int kcm_sendmsg(struct socket *sock, struct msghdr *msg, size_t len)
 out_error:
 	kcm_push(kcm);
 
-	if (copied && sock->type == SOCK_SEQPACKET) {
+	if (sock->type == SOCK_SEQPACKET) {
 		/* Wrote some bytes before encountering an
 		 * error, return partial success.
 		 */
-		goto partial_message;
-	}
-
-	if (head != kcm->seq_skb)
+		if (copied)
+			goto partial_message;
+		if (head != kcm->seq_skb)
+			kfree_skb(head);
+	} else {
 		kfree_skb(head);
-	else if (copied)
-		kcm_tx_msg(head)->last_skb = skb;
+		kcm->seq_skb = NULL;
+	}
 
 	err = sk_stream_error(sk, msg->msg_flags, err);
 
-- 
2.30.2


