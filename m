Return-Path: <netdev+bounces-157491-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 25832A0A721
	for <lists+netdev@lfdr.de>; Sun, 12 Jan 2025 05:10:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 080361889466
	for <lists+netdev@lfdr.de>; Sun, 12 Jan 2025 04:10:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BBE113C8EA;
	Sun, 12 Jan 2025 04:09:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="JBE1zaBf"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-6001.amazon.com (smtp-fw-6001.amazon.com [52.95.48.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C53C6FB0
	for <netdev@vger.kernel.org>; Sun, 12 Jan 2025 04:09:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.95.48.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736654990; cv=none; b=TZxqo9cTVMsI2GailkTxfCRMTVc/HmX/gkqrZvbqYHFugLz5wM4e9zWOmjPeCrZbD19WJm+cw/w8HfuCRvekS+yjIblA7SEZ422W9Ho277keWUc6dMxIC0MpQBGwAHZI8E+7XP/zbpCKvWGLtd3Ke9W9D9sVHGgo5AoU5rh9+pc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736654990; c=relaxed/simple;
	bh=ka5tddW9vT2AYR1FOk3xX2fQ2qXzdd6fU4YEbrZOTzI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hM5/wevOateZAh0kyFJd5tbon+9LQ/BN3hvphNxd41kuLq3qgtyCSUJgqzuKwPtvMTN4JjI5qTQiXf84O8+g84ciUfovLngzWhR/t8Jwqn+QcIs/C+ByyxjlMsAYEfV9RVEXzkvggDRzaoiXlt9uUZWRzpqzMHV1Vu9xIRXs0l8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=JBE1zaBf; arc=none smtp.client-ip=52.95.48.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1736654989; x=1768190989;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=pvTppOl7MKVCY59BRjIRFn5kMxrLpjCsRsywSXQxCDE=;
  b=JBE1zaBfVCG7765/AUNW/CoaATnhuJk7x1/m8vg+vla4XTX9D07/3ltm
   BsRqZbHrtFyDDAHgKTuo667XrN/ydrZ/5FPJ1pMYy9cZXBCMQnzviGOgO
   Q7mOX43jryKqVUF2wdxnNIj7wF3Hvcs0aOPy1C09zHgp/K0O/m8TfoN5D
   A=;
X-IronPort-AV: E=Sophos;i="6.12,308,1728950400"; 
   d="scan'208";a="453550548"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.2])
  by smtp-border-fw-6001.iad6.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2025 04:09:45 +0000
Received: from EX19MTAUWB001.ant.amazon.com [10.0.21.151:27003]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.42.134:2525] with esmtp (Farcaster)
 id 5208dfa4-e2cf-41f7-87d3-b02a034daf76; Sun, 12 Jan 2025 04:09:44 +0000 (UTC)
X-Farcaster-Flow-ID: 5208dfa4-e2cf-41f7-87d3-b02a034daf76
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Sun, 12 Jan 2025 04:09:44 +0000
Received: from 6c7e67c6786f.amazon.com (10.119.14.156) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Sun, 12 Jan 2025 04:09:40 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Simon Horman <horms@kernel.org>
CC: Donald Hunter <donald.hunter@redhat.com>, Kuniyuki Iwashima
	<kuniyu@amazon.com>, Kuniyuki Iwashima <kuni1840@gmail.com>,
	<netdev@vger.kernel.org>
Subject: [PATCH v2 net-next 03/11] af_unix: Set drop reason in unix_sock_destructor().
Date: Sun, 12 Jan 2025 13:08:02 +0900
Message-ID: <20250112040810.14145-4-kuniyu@amazon.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250112040810.14145-1-kuniyu@amazon.com>
References: <20250112040810.14145-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D032UWB002.ant.amazon.com (10.13.139.190) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

unix_sock_destructor() is called as sk->sk_destruct() just before
the socket is actually freed.

Let's use SKB_DROP_REASON_SOCKET_CLOSE for skb_queue_purge().

Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 net/unix/af_unix.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
index a05d25cc5545..41b99984008a 100644
--- a/net/unix/af_unix.c
+++ b/net/unix/af_unix.c
@@ -640,7 +640,7 @@ static void unix_sock_destructor(struct sock *sk)
 {
 	struct unix_sock *u = unix_sk(sk);
 
-	skb_queue_purge(&sk->sk_receive_queue);
+	skb_queue_purge_reason(&sk->sk_receive_queue, SKB_DROP_REASON_SOCKET_CLOSE);
 
 	DEBUG_NET_WARN_ON_ONCE(refcount_read(&sk->sk_wmem_alloc));
 	DEBUG_NET_WARN_ON_ONCE(!sk_unhashed(sk));
-- 
2.39.5 (Apple Git-154)


