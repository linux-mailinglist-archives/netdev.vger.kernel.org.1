Return-Path: <netdev+bounces-103717-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AF18190932F
	for <lists+netdev@lfdr.de>; Fri, 14 Jun 2024 22:08:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2CEE5288BB1
	for <lists+netdev@lfdr.de>; Fri, 14 Jun 2024 20:08:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D7371A01B6;
	Fri, 14 Jun 2024 20:08:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="uYioLMGc"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-52004.amazon.com (smtp-fw-52004.amazon.com [52.119.213.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA36A19D07B
	for <netdev@vger.kernel.org>; Fri, 14 Jun 2024 20:08:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718395706; cv=none; b=tTmmbb5XJ4rd8m2RzdkADBUu+JuOF3M6mkslKrGIJ0QJBfuONoslKeYqtQIHHJ5GaxtP9+OB2B6MnpUyn4fKbR/iweqB/eqzhGftNjg45clzYAb7ptcFPfEpv6apvLCLj6BxFHIsTLCkVnU5CSDD68cpognb/3ng6YUgaczg9I0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718395706; c=relaxed/simple;
	bh=SFOkvdIY1Z2DTg6iywt7b+a1oUXcNiI3PAN1GL04fEI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CltRgwhebSZZcrcF78KZk5d395ZXUjIuCxGAh6z0v3ANMmBiLnOE6ZwBkOF+QzI8oXq3eoJpgHOU8KsxnIpP6GJWkVzagDl3t5O+JNc6qoTSitqU2XelWHIWNC0sIZ2R0/GFh9hF19OnjTZQZi3oJQtXiMegE73q5CcOo5oHFLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=uYioLMGc; arc=none smtp.client-ip=52.119.213.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1718395705; x=1749931705;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Y/pK7a6EOaj6WvJ+tzCT6g4Wr6lQSGCH41aEqPzSf9M=;
  b=uYioLMGchLNLVoEVtYrWOp25yQFCBoUyUb8YWlM4Y/BSRucXirA+EUR/
   DYgRNMpibjr2hHep6AayoV2O/3GeirkP8bMw7vY1VZmYisaSfr918+js9
   EFDXF65/g7xMAS/8t0DK/9QOf7YQ76XJLPEo+rR9yQZoHaC3Vesp/KKN/
   o=;
X-IronPort-AV: E=Sophos;i="6.08,238,1712620800"; 
   d="scan'208";a="211895537"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.2])
  by smtp-border-fw-52004.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2024 20:08:23 +0000
Received: from EX19MTAUWC002.ant.amazon.com [10.0.21.151:39163]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.63.123:2525] with esmtp (Farcaster)
 id e68e382b-97e0-4483-a02d-6d1ea10fdd44; Fri, 14 Jun 2024 20:08:22 +0000 (UTC)
X-Farcaster-Flow-ID: e68e382b-97e0-4483-a02d-6d1ea10fdd44
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Fri, 14 Jun 2024 20:08:22 +0000
Received: from 88665a182662.ant.amazon.com.com (10.106.100.24) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34; Fri, 14 Jun 2024 20:08:20 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>
CC: Kent Overstreet <kent.overstreet@linux.dev>, Kuniyuki Iwashima
	<kuniyu@amazon.com>, Kuniyuki Iwashima <kuni1840@gmail.com>,
	<netdev@vger.kernel.org>
Subject: [PATCH v3 net-next 02/11] af_unix: Define locking order for U_LOCK_SECOND in unix_state_double_lock().
Date: Fri, 14 Jun 2024 13:07:06 -0700
Message-ID: <20240614200715.93150-3-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240614200715.93150-1-kuniyu@amazon.com>
References: <20240614200715.93150-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D031UWC002.ant.amazon.com (10.13.139.212) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

unix_dgram_connect() and unix_dgram_{send,recv}msg() lock the socket
and peer in ascending order of the socket address.

Let's define the order as unix_state_lock_cmp_fn() instead of using
unix_state_lock_nested().

Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
Reviewed-by: Kent Overstreet <kent.overstreet@linux.dev>
---
 net/unix/af_unix.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
index 7889d4723959..0657f599bbef 100644
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


