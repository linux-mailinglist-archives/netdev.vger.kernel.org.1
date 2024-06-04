Return-Path: <netdev+bounces-100694-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CFE5F8FB9A0
	for <lists+netdev@lfdr.de>; Tue,  4 Jun 2024 18:55:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0AC031C20E82
	for <lists+netdev@lfdr.de>; Tue,  4 Jun 2024 16:55:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B79CF148FE0;
	Tue,  4 Jun 2024 16:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="GlhegPW0"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-6001.amazon.com (smtp-fw-6001.amazon.com [52.95.48.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12196171BA
	for <netdev@vger.kernel.org>; Tue,  4 Jun 2024 16:55:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.95.48.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717520123; cv=none; b=h5txXQOuyGq3yhBtBojM7LYW5JJKsCj3QgSHcEGDcJnQOcjFAyfWGGCRVaA0uISqZjT/kEDM5mXYxnbHSxtNaonbC86mPazCkNoqHVS3unriny/mRnzKdjRkl8cviAPcBHcuQgfqrN1l5+Mbe0npt0nWvIx1aPztUsjzcrbZG7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717520123; c=relaxed/simple;
	bh=fSTeF+91/cnJJJqGpTrJDjDXvQDTLkPebDeeVk1y3pA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KU3IRZ5bJ1qHQ/ihxgL4WdZYxHHrUduNx2HHy3mln3ucksmy0NwGjJBDGWbllhgp+mc6tW/jESqi2I/d3Cild34L5E8x/JSMJTjfDRxjaHZBWwiWdCG8QDZ+M2mYRI/JoK/gIe+a5vHzZWJf8tD6XwY52iXOwjfmrJ3UvOFhffQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=GlhegPW0; arc=none smtp.client-ip=52.95.48.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1717520122; x=1749056122;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=10oC2ArW1hP8lkgpJDG7VYIYVDpnUVVFTsoen0iUzbU=;
  b=GlhegPW0wn7ejpkPbKb5eFS2/7VYR9qFOIpjvZz8DRoo7ENpxgmYyG6D
   NZlCICaxPwMPgmEoKt2PFj61hl+U7AN7UUWHOjaT6QghJ+AP/2INbz22x
   9hw3fYfwc6rBKmoUq3ATiEDibGqsMzqOHuKLy5RHXUPciRBoHphQCCBN2
   c=;
X-IronPort-AV: E=Sophos;i="6.08,214,1712620800"; 
   d="scan'208";a="400990898"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.2])
  by smtp-border-fw-6001.iad6.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2024 16:55:19 +0000
Received: from EX19MTAUWB002.ant.amazon.com [10.0.38.20:54513]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.4.17:2525] with esmtp (Farcaster)
 id 9e906112-205b-4ccb-be9d-86010b23d5ae; Tue, 4 Jun 2024 16:55:19 +0000 (UTC)
X-Farcaster-Flow-ID: 9e906112-205b-4ccb-be9d-86010b23d5ae
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Tue, 4 Jun 2024 16:55:18 +0000
Received: from 88665a182662.ant.amazon.com (10.187.170.50) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34; Tue, 4 Jun 2024 16:55:16 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>
CC: Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v2 net 06/15] af_unix: Annotate data-race of sk->sk_state in unix_accept().
Date: Tue, 4 Jun 2024 09:52:32 -0700
Message-ID: <20240604165241.44758-7-kuniyu@amazon.com>
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
X-ClientProxiedBy: EX19D044UWA003.ant.amazon.com (10.13.139.43) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

Once sk->sk_state is changed to TCP_LISTEN, it never changes.

unix_accept() takes the advantage and reads sk->sk_state without
holding unix_state_lock().

Let's use READ_ONCE() there.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 net/unix/af_unix.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
index 84552826530d..4763c26ae480 100644
--- a/net/unix/af_unix.c
+++ b/net/unix/af_unix.c
@@ -1710,7 +1710,7 @@ static int unix_accept(struct socket *sock, struct socket *newsock,
 		goto out;
 
 	arg->err = -EINVAL;
-	if (sk->sk_state != TCP_LISTEN)
+	if (READ_ONCE(sk->sk_state) != TCP_LISTEN)
 		goto out;
 
 	/* If socket state is TCP_LISTEN it cannot change (for now...),
-- 
2.30.2


