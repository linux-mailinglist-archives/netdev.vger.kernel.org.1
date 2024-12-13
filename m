Return-Path: <netdev+bounces-151705-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A8899F0A7D
	for <lists+netdev@lfdr.de>; Fri, 13 Dec 2024 12:11:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 479A8188A9A1
	for <lists+netdev@lfdr.de>; Fri, 13 Dec 2024 11:11:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8386F1CEAD6;
	Fri, 13 Dec 2024 11:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="jDDfaOhn"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-52003.amazon.com (smtp-fw-52003.amazon.com [52.119.213.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17EFE1CEEAB
	for <netdev@vger.kernel.org>; Fri, 13 Dec 2024 11:11:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734088271; cv=none; b=RDeKYq+o7kvYd31xjNDHIX+ZgJJqELK8/nh1+H2LWDGqY5Nx348KiTqCxjrUerGnFq+WJAzdyP1mv9zp8eX76FINMzccqlrH51s1pTc6OrtwVhR6m17bQl19sOlsA28l5RrFlc8nenutpksfNgnm53a6SV/Lf2mwbQqG/hB2w/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734088271; c=relaxed/simple;
	bh=bUwuAx4NQi30MALFApcrenx3ia58ywxqKspPzngOWcI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Uvr1FyOwDGWJ8MvLzMkhH3lh0bSdkrqisfwAIUefPqlw2CpN1siYhYuMB7qBhVINhiaLG3Cw7IVtJXJ967djSy+bG9dDk8/WPTK+14yfwMN8PdbqYt44rci/6vLMaNWqS8ZQMqre0OGN4xHj9s613Jm6jWBpaLZuifYWDieEEBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=jDDfaOhn; arc=none smtp.client-ip=52.119.213.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1734088268; x=1765624268;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=QvHgMevHlV1sZ6QIgqY7Yatwo7KyLbz0Uih9INgouBo=;
  b=jDDfaOhn71yPpEuzhMqrwSKKX6HbiQ5i4ekKZtJWClvlDfafbJW1fJGF
   ALdIVIhjPdn6hoDW97C5Jqy6u1t3qbvbvs+xEKUFqaVOIY82OmxSymkvF
   W/e8msbQYF0Fpreet4LkrM/Mk8lBDI0QmGquNKfV2+AGz7Z6zCnVxrZ6k
   Q=;
X-IronPort-AV: E=Sophos;i="6.12,231,1728950400"; 
   d="scan'208";a="49107574"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-52003.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2024 11:11:05 +0000
Received: from EX19MTAUWB001.ant.amazon.com [10.0.7.35:14557]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.51.231:2525] with esmtp (Farcaster)
 id baaf783d-89e3-4e2b-8ade-185242955cd6; Fri, 13 Dec 2024 11:11:05 +0000 (UTC)
X-Farcaster-Flow-ID: baaf783d-89e3-4e2b-8ade-185242955cd6
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Fri, 13 Dec 2024 11:11:04 +0000
Received: from 6c7e67c6786f.amazon.com (10.119.14.208) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Fri, 13 Dec 2024 11:11:01 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>
CC: Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v2 net-next 06/12] af_unix: Move !sunaddr case in unix_dgram_sendmsg().
Date: Fri, 13 Dec 2024 20:08:44 +0900
Message-ID: <20241213110850.25453-7-kuniyu@amazon.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20241213110850.25453-1-kuniyu@amazon.com>
References: <20241213110850.25453-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D032UWA004.ant.amazon.com (10.13.139.56) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

When other is NULL in unix_dgram_sendmsg(), we check if sunaddr
is NULL before looking up a receiver socket.

There are three paths going through the check, but it's always
false for 2 out of the 3 paths: the first socket lookup and the
second 'goto restart'.

The condition can be true for the first 'goto restart' only when
SOCK_DEAD is flagged for the socket found with msg->msg_name.

Let's move the check to the single appropriate path.

Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 net/unix/af_unix.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
index 07d6fba99a7c..111f95384990 100644
--- a/net/unix/af_unix.c
+++ b/net/unix/af_unix.c
@@ -2046,11 +2046,6 @@ static int unix_dgram_sendmsg(struct socket *sock, struct msghdr *msg,
 
 restart:
 	if (!other) {
-		if (!sunaddr) {
-			err = -ECONNRESET;
-			goto out_free;
-		}
-
 		other = unix_find_other(sock_net(sk), sunaddr, msg->msg_namelen,
 					sk->sk_type);
 		if (IS_ERR(other)) {
@@ -2105,6 +2100,9 @@ static int unix_dgram_sendmsg(struct socket *sock, struct msghdr *msg,
 			err = -ECONNREFUSED;
 		} else {
 			unix_state_unlock(sk);
+
+			if (!sunaddr)
+				err = -ECONNRESET;
 		}
 
 		other = NULL;
-- 
2.39.5 (Apple Git-154)


