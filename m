Return-Path: <netdev+bounces-100702-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A55118FB9B2
	for <lists+netdev@lfdr.de>; Tue,  4 Jun 2024 18:58:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D69D31C20B1C
	for <lists+netdev@lfdr.de>; Tue,  4 Jun 2024 16:58:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7586414900B;
	Tue,  4 Jun 2024 16:58:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="mqIRCV+4"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-6002.amazon.com (smtp-fw-6002.amazon.com [52.95.49.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F7712AF16
	for <netdev@vger.kernel.org>; Tue,  4 Jun 2024 16:58:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.95.49.90
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717520319; cv=none; b=mt6a3t1geaFCIkHalXut+gnXYXhpv6C9dIShqAjYHValfb4xv7dJb6lJv7ITFlrUoEkafd2LhavbbDcSTlIEhI8Loa20vpWatODw4GmXaZLdOMgtSvvnjWc5eX/179Gi6YshlSZ4cFJ4usP9C3nkU3CuaF1UM/kIFVOVntI6Npk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717520319; c=relaxed/simple;
	bh=Cw4e4BnKX7L9YEl3TkBfINBmvjOGwhz0SK74j0vQPS0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eY3M2rqPoJJb1hg2N5gTu6SYpu6qZrs62ZyocsDLG9eCWsi8iaThjep6vrzR+KQTnBTDAX33xC7/5eeiBByqiHL3t24pHHD27jjLvGz0Ix1oUQzVw1wH/ysYFsg2Fk6cnHgKiJM2+wI8yHdK2y9KKD40eMpiPHXcpnrmru/fFQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=mqIRCV+4; arc=none smtp.client-ip=52.95.49.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1717520318; x=1749056318;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=PWqYgkHnRGWvpHLeE+UUJyKSFZQLIlRz17nBIKZqxyY=;
  b=mqIRCV+4OyFcjQ4WjTeya9jOKuD0EeWhYkfCMmFrfktTZqizNeO6AHb0
   azot82nmLA4UBpuJQibhqST35lyhzn4MghMnhKJxX2Mu3g7V/JMVj3v4Q
   SWnGmBb+8+BOlKS6y9cMqf4L87kyO281mfQLedDPBrMa+o0fwMcvhagnY
   A=;
X-IronPort-AV: E=Sophos;i="6.08,214,1712620800"; 
   d="scan'208";a="411176377"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-6002.iad6.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2024 16:58:36 +0000
Received: from EX19MTAUWA002.ant.amazon.com [10.0.21.151:62927]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.4.17:2525] with esmtp (Farcaster)
 id c1f6b556-91f5-4e3e-bb4b-2c7796b5103e; Tue, 4 Jun 2024 16:58:35 +0000 (UTC)
X-Farcaster-Flow-ID: c1f6b556-91f5-4e3e-bb4b-2c7796b5103e
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Tue, 4 Jun 2024 16:58:31 +0000
Received: from 88665a182662.ant.amazon.com (10.187.170.50) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34; Tue, 4 Jun 2024 16:58:29 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>
CC: Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v2 net 14/15] af_unix: Use skb_queue_len_lockless() in sk_diag_show_rqlen().
Date: Tue, 4 Jun 2024 09:52:40 -0700
Message-ID: <20240604165241.44758-15-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240604165241.44758-1-kuniyu@amazon.com>
References: <20240604165241.44758-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D046UWB004.ant.amazon.com (10.13.139.164) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

We can dump the socket queue length via UNIX_DIAG by specifying
UDIAG_SHOW_RQLEN.

If sk->sk_state is TCP_LISTEN, we return the recv queue length,
but here we do not hold recvq lock.

Let's use skb_queue_len_lockless() in sk_diag_show_rqlen().

Fixes: c9da99e6475f ("unix_diag: Fixup RQLEN extension report")
Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 net/unix/diag.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/unix/diag.c b/net/unix/diag.c
index 116cf508aea4..321336f91a0a 100644
--- a/net/unix/diag.c
+++ b/net/unix/diag.c
@@ -104,7 +104,7 @@ static int sk_diag_show_rqlen(struct sock *sk, struct sk_buff *nlskb)
 	struct unix_diag_rqlen rql;
 
 	if (READ_ONCE(sk->sk_state) == TCP_LISTEN) {
-		rql.udiag_rqueue = sk->sk_receive_queue.qlen;
+		rql.udiag_rqueue = skb_queue_len_lockless(&sk->sk_receive_queue);
 		rql.udiag_wqueue = sk->sk_max_ack_backlog;
 	} else {
 		rql.udiag_rqueue = (u32) unix_inq_len(sk);
-- 
2.30.2


