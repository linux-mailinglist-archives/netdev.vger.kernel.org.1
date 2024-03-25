Return-Path: <netdev+bounces-81720-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 18C5488B5C6
	for <lists+netdev@lfdr.de>; Tue, 26 Mar 2024 01:06:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 596FDC2145D
	for <lists+netdev@lfdr.de>; Mon, 25 Mar 2024 18:38:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CE7366B5E;
	Mon, 25 Mar 2024 18:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="GIfT/Xgx"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-52004.amazon.com (smtp-fw-52004.amazon.com [52.119.213.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6685E5FB8D
	for <netdev@vger.kernel.org>; Mon, 25 Mar 2024 18:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711390849; cv=none; b=Otv5bOQNT7f48OhnOL45xkdMi+XS83OiUvePBohfxqXSdnEgfpkqAZwLadSCbyl79bBj3Kwqf4vSsdjo9KNq+vqEk1p3tZVQxfGoK0X/klZTjLelohyF5KKR2d6w3dfTuBVkhypeRm9rqUQLQEoeFns+qz0V4HOBd8S2ecWIl4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711390849; c=relaxed/simple;
	bh=Vo4y6egnfbp/Yifr2DvxVKJq7CSzhOU2VDUUVWZRcQA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ikMvvqThtc9LkYHvHBuhT4sZKROe9SgDzHFRnDw4AzzCRz99MPv3TW8gsyqpdYkurpfVQIL2pn9R3iSvGpNJC2+m6aUxQl2CzK9nBEy3fmqLanAs90B717vlxR5CKx6wToToMoBNTAGGKgoisae8iyxMaqeu49bxg/nZJ5am3JU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=GIfT/Xgx; arc=none smtp.client-ip=52.119.213.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1711390848; x=1742926848;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=eLZ3AWtpJlBPwNrpZBumotgGzQnO8gm+O4agAPlW+6Y=;
  b=GIfT/Xgx+5t7DtS859huCbVvHTKw1s5msfKXuKpa+n5Zziv0onE0ChaW
   P1chPjpl4+Hjg8YuO4+5D5wvXhmhD6FhOGRVOIA097fTDtC3lV2VMa7FK
   ADQ/Eb8AH/4YjACqVO0NXt462Np/bCk2gB6+HLpQCqmmfnD4nEMmPC6TF
   4=;
X-IronPort-AV: E=Sophos;i="6.07,153,1708387200"; 
   d="scan'208";a="194217900"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.2])
  by smtp-border-fw-52004.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2024 18:20:45 +0000
Received: from EX19MTAUWB002.ant.amazon.com [10.0.7.35:16109]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.17.10:2525] with esmtp (Farcaster)
 id ff48fde4-e214-4a06-a65f-855ce8bd5b6b; Mon, 25 Mar 2024 18:20:43 +0000 (UTC)
X-Farcaster-Flow-ID: ff48fde4-e214-4a06-a65f-855ce8bd5b6b
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Mon, 25 Mar 2024 18:20:38 +0000
Received: from 88665a182662.ant.amazon.com (10.187.171.62) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.28;
 Mon, 25 Mar 2024 18:20:35 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, David Ahern <dsahern@kernel.org>
CC: Joanne Koong <joannelkoong@gmail.com>, Jianguo Wu <wujianguo106@163.com>,
	Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v1 net 2/8] tcp: Fix bind() regression for v6-only wildcard and v4(-mapped-v6) non-wildcard addresses.
Date: Mon, 25 Mar 2024 11:19:17 -0700
Message-ID: <20240325181923.48769-3-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240325181923.48769-1-kuniyu@amazon.com>
References: <20240325181923.48769-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D045UWC004.ant.amazon.com (10.13.139.203) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

Jianguo Wu reported another bind() regression introduced by bhash2.

Calling bind() for the following 3 addresses on the same port, the
3rd one should fail but now succeeds.

  1. 0.0.0.0 or ::ffff:0.0.0.0
  2. [::] w/ IPV6_V6ONLY
  3. IPv4 non-wildcard address or v4-mapped-v6 non-wildcard address

The first two bind() create tb2 like this:

  bhash2 -> tb2(:: w/ IPV6_V6ONLY) -> tb2(0.0.0.0)

The 3rd bind() will match with the IPv6 only wildcard address bucket
in inet_bind2_bucket_match_addr_any(), however, no conflicting socket
exists in the bucket.  So, inet_bhash2_conflict() will returns false,
and thus, inet_bhash2_addr_any_conflict() returns false consequently.

As a result, the 3rd bind() bypasses conflict check, which should be
done against the IPv4 wildcard address bucket.

So, in inet_bhash2_addr_any_conflict(), we must iterate over all buckets.

Note that we cannot add ipv6_only flag for inet_bind2_bucket as it
would confuse the following patetrn.

  1. [::] w/ SO_REUSE{ADDR,PORT} and IPV6_V6ONLY
  2. [::] w/ SO_REUSE{ADDR,PORT}
  3. IPv4 non-wildcard address or v4-mapped-v6 non-wildcard address

The first bind() would create a bucket with ipv6_only flag true,
the second bind() would add the [::] socket into the same bucket,
and the third bind() could succeed based on the wrong assumption
that ipv6_only bucket would not conflict with v4(-mapped-v6) address.

Fixes: 28044fc1d495 ("net: Add a bhash2 table hashed by port and address")
Diagnosed-by: Jianguo Wu <wujianguo106@163.com>
Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 net/ipv4/inet_connection_sock.c | 19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

diff --git a/net/ipv4/inet_connection_sock.c b/net/ipv4/inet_connection_sock.c
index 612aa1d2eff7..63e8f2df0681 100644
--- a/net/ipv4/inet_connection_sock.c
+++ b/net/ipv4/inet_connection_sock.c
@@ -288,6 +288,7 @@ static bool inet_bhash2_addr_any_conflict(const struct sock *sk, int port, int l
 	struct sock_reuseport *reuseport_cb;
 	struct inet_bind_hashbucket *head2;
 	struct inet_bind2_bucket *tb2;
+	bool conflict = false;
 	bool reuseport_cb_ok;
 
 	rcu_read_lock();
@@ -300,18 +301,20 @@ static bool inet_bhash2_addr_any_conflict(const struct sock *sk, int port, int l
 
 	spin_lock(&head2->lock);
 
-	inet_bind_bucket_for_each(tb2, &head2->chain)
-		if (inet_bind2_bucket_match_addr_any(tb2, net, port, l3mdev, sk))
-			break;
+	inet_bind_bucket_for_each(tb2, &head2->chain) {
+		if (!inet_bind2_bucket_match_addr_any(tb2, net, port, l3mdev, sk))
+			continue;
 
-	if (tb2 && inet_bhash2_conflict(sk, tb2, uid, relax, reuseport_cb_ok,
-					reuseport_ok)) {
-		spin_unlock(&head2->lock);
-		return true;
+		if (!inet_bhash2_conflict(sk, tb2, uid, relax, reuseport_cb_ok,	reuseport_ok))
+			continue;
+
+		conflict = true;
+		break;
 	}
 
 	spin_unlock(&head2->lock);
-	return false;
+
+	return conflict;
 }
 
 /*
-- 
2.30.2


