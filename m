Return-Path: <netdev+bounces-102371-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B275902BBD
	for <lists+netdev@lfdr.de>; Tue, 11 Jun 2024 00:36:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A4DEA287720
	for <lists+netdev@lfdr.de>; Mon, 10 Jun 2024 22:36:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F9A2150980;
	Mon, 10 Jun 2024 22:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="oSCb/mtd"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-80009.amazon.com (smtp-fw-80009.amazon.com [99.78.197.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEE6A18E2A
	for <netdev@vger.kernel.org>; Mon, 10 Jun 2024 22:36:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718058969; cv=none; b=GXe0sgMEGeYmWh8gKkvNOYPJ9qLoN4t+cIG6NozjdiAa3jSulBe9at2m0GNkvWG/LKH9NbCOkn69OKjpBOnGdzRXPjANFJ80aUTJrIB9Xotcp71aVWvoWQ1pHcj09qvO3ff3r+UK6AoRHxSvAmb8W8KeP0d19ZLg6IprTM+2ojU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718058969; c=relaxed/simple;
	bh=P8DroekXeITx142q9b6QgTL0mCfAN/EG/25uFKpyj9o=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sW9iglxQNEVS0otDBYFRJTrypOmBONqLJ3J2LbRj71roYCRAGsnOZCs9cLW1HN5tKhMzXT4tyY0+U66evCs+wWSN0Gl4knaJWg/PFhk9lWKlEUYgoBpckxMVV/0vBk3FOvYpgyKl1NL2udrZG10dlNgFlJnsQ14CXx69mudHRvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=oSCb/mtd; arc=none smtp.client-ip=99.78.197.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1718058967; x=1749594967;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=PMgBZb9LbxOiDg44PjPO8IU/MSTnJgCBSvDx99KoW74=;
  b=oSCb/mtdWhKeUdHiNTBtqDy76CKflHMcvIq4eX4IKp4LyAJ+ywmfOHJo
   hQIUrVKbc3dYub18qP7uDfkA4qdw4fwyfHgq74ezkZPnrOhTQXW1y2p5o
   PJzuIr4LVtcuioZSpZXF1DcvdIBv47DBWQN8bjPl6ReEPzR3lEWdnW02F
   Y=;
X-IronPort-AV: E=Sophos;i="6.08,228,1712620800"; 
   d="scan'208";a="95792359"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-80009.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2024 22:36:05 +0000
Received: from EX19MTAUWB002.ant.amazon.com [10.0.21.151:63568]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.7.183:2525] with esmtp (Farcaster)
 id 58513438-b065-4df2-9293-df9ba29e891a; Mon, 10 Jun 2024 22:36:05 +0000 (UTC)
X-Farcaster-Flow-ID: 58513438-b065-4df2-9293-df9ba29e891a
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34; Mon, 10 Jun 2024 22:36:05 +0000
Received: from 88665a182662.ant.amazon.com.com (10.187.171.27) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Mon, 10 Jun 2024 22:36:02 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>
CC: Kent Overstreet <kent.overstreet@linux.dev>, Kuniyuki Iwashima
	<kuniyu@amazon.com>, Kuniyuki Iwashima <kuni1840@gmail.com>,
	<netdev@vger.kernel.org>
Subject: [PATCH v1 net-next 02/11] af_unix: Define locking order for U_LOCK_SECOND in unix_state_double_lock().
Date: Mon, 10 Jun 2024 15:34:52 -0700
Message-ID: <20240610223501.73191-3-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240610223501.73191-1-kuniyu@amazon.com>
References: <20240610223501.73191-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D037UWC003.ant.amazon.com (10.13.139.231) To
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
index b0a9891c0384..16878452eaad 100644
--- a/net/unix/af_unix.c
+++ b/net/unix/af_unix.c
@@ -132,6 +132,18 @@ static int unix_table_lock_cmp_fn(const struct lockdep_map *a,
 {
 	return a < b ? -1 : 0;
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
+	return a < b ? -1 : 0;
+}
 #endif
 
 static unsigned int unix_unbound_hash(struct sock *sk)
@@ -985,6 +997,7 @@ static struct sock *unix_create1(struct net *net, struct socket *sock, int kern,
 	u->path.dentry = NULL;
 	u->path.mnt = NULL;
 	spin_lock_init(&u->lock);
+	lock_set_cmp_fn(&u->lock, unix_state_lock_cmp_fn, NULL);
 	mutex_init(&u->iolock); /* single task reading lock */
 	mutex_init(&u->bindlock); /* single task binding lock */
 	init_waitqueue_head(&u->peer_wait);
@@ -1333,11 +1346,12 @@ static void unix_state_double_lock(struct sock *sk1, struct sock *sk2)
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


