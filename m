Return-Path: <netdev+bounces-102737-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 29BB09046EB
	for <lists+netdev@lfdr.de>; Wed, 12 Jun 2024 00:30:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BBBC928713C
	for <lists+netdev@lfdr.de>; Tue, 11 Jun 2024 22:30:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6F8115535D;
	Tue, 11 Jun 2024 22:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="ZK+/pOpa"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-80007.amazon.com (smtp-fw-80007.amazon.com [99.78.197.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50BC815531E
	for <netdev@vger.kernel.org>; Tue, 11 Jun 2024 22:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718145011; cv=none; b=mZ1s6fWXlnfkHp90phROXxgBqLj41Sag0GNq46G0bdbRITURvGGzVU1L9OUQccg8STBsTTG85qu+4vMj7HT1ZKIWFD8RgLlXIrtdS2rn7BpC7LHwJvET+jSM7a3GOgD1DfRhYiwYFrVCUa3fOmgwxmQsU8r5+vwKSjgjUiJJJb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718145011; c=relaxed/simple;
	bh=UW/ClRgNTjYptfR62FXrdzD50u2iofzA9XCeoePpgwU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=H0QRLUKfz+HCtMKAu2quOqnEssh1Z9sjyTdB/4PNNFWFY3bhvSMtIeknOdVB4Nsbr6Qc58gWonaoWvGtfg6b+QEqL3U8NQCge+zmZqYBeQFdEuKEPizNTYi9poI6n2xZdTwVxM/8M29i2nd5H8fucmX7rHZb1X3TtUCX0U6uKV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=ZK+/pOpa; arc=none smtp.client-ip=99.78.197.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1718145010; x=1749681010;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=wabtQppYAVHh5iGm+K4aQVHMDzaKPLy7nNLQy3U2v7Q=;
  b=ZK+/pOpawTpeJNCSclBZyILCVDUoVNGsZJqfJQ6aHXYfjB/nsg9Hm/gS
   AhJ4ofxHQTQoE40qlDbfen5sqLWuDJNo9bRp+41wGfw0rJEHOtJVRID7D
   mViH2VS3WFywQ1zWwb1Ef2yEbWGlpeWOkdgSeMftK/ZDtWVDaLpaCk34c
   w=;
X-IronPort-AV: E=Sophos;i="6.08,231,1712620800"; 
   d="scan'208";a="302747887"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-80007.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2024 22:30:08 +0000
Received: from EX19MTAUWA002.ant.amazon.com [10.0.38.20:37943]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.6.196:2525] with esmtp (Farcaster)
 id c6365589-b964-4158-abce-b8fa45ae3567; Tue, 11 Jun 2024 22:30:07 +0000 (UTC)
X-Farcaster-Flow-ID: c6365589-b964-4158-abce-b8fa45ae3567
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34; Tue, 11 Jun 2024 22:30:06 +0000
Received: from 88665a182662.ant.amazon.com.com (10.187.171.17) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34; Tue, 11 Jun 2024 22:30:04 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>
CC: Kent Overstreet <kent.overstreet@linux.dev>, Kuniyuki Iwashima
	<kuniyu@amazon.com>, Kuniyuki Iwashima <kuni1840@gmail.com>,
	<netdev@vger.kernel.org>
Subject: [PATCH v2 net-next 02/11] af_unix: Define locking order for U_LOCK_SECOND in unix_state_double_lock().
Date: Tue, 11 Jun 2024 15:28:56 -0700
Message-ID: <20240611222905.34695-3-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240611222905.34695-1-kuniyu@amazon.com>
References: <20240611222905.34695-1-kuniyu@amazon.com>
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

unix_dgram_connect() and unix_dgram_{send,recv}msg() lock the socket
and peer in ascending order of the socket address.

Let's define the order as unix_state_lock_cmp_fn() instead of using
unix_state_lock_nested().

Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 net/unix/af_unix.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
index 22bb941f174e..c09bf2b03582 100644
--- a/net/unix/af_unix.c
+++ b/net/unix/af_unix.c
@@ -134,6 +134,18 @@ static int unix_table_lock_cmp_fn(const struct lockdep_map *a,
 {
 	return cmp_ptr(a, b);
 }
+
+static int unix_state_lock_cmp_fn(const struct lockdep_map *_a,
+				  const struct lockdep_map *_b)
+{
+	const struct unix_sock *a, *b;
+
+	a = container_of(_a, struct unix_sock, lock.dep_map);
+	b = container_of(_b, struct unix_sock, lock.dep_map);
+
+	/* unix_state_double_lock(): ascending address order. */
+	return cmp_ptr(a, b);
+}
 #endif
 
 static unsigned int unix_unbound_hash(struct sock *sk)
@@ -987,6 +999,7 @@ static struct sock *unix_create1(struct net *net, struct socket *sock, int kern,
 	u->path.dentry = NULL;
 	u->path.mnt = NULL;
 	spin_lock_init(&u->lock);
+	lock_set_cmp_fn(&u->lock, unix_state_lock_cmp_fn, NULL);
 	mutex_init(&u->iolock); /* single task reading lock */
 	mutex_init(&u->bindlock); /* single task binding lock */
 	init_waitqueue_head(&u->peer_wait);
@@ -1335,11 +1348,12 @@ static void unix_state_double_lock(struct sock *sk1, struct sock *sk2)
 		unix_state_lock(sk1);
 		return;
 	}
+
 	if (sk1 > sk2)
 		swap(sk1, sk2);
 
 	unix_state_lock(sk1);
-	unix_state_lock_nested(sk2, U_LOCK_SECOND);
+	unix_state_lock(sk2);
 }
 
 static void unix_state_double_unlock(struct sock *sk1, struct sock *sk2)
-- 
2.30.2


