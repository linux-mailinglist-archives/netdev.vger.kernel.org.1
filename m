Return-Path: <netdev+bounces-151712-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DA6659F0A8F
	for <lists+netdev@lfdr.de>; Fri, 13 Dec 2024 12:13:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9BD51282707
	for <lists+netdev@lfdr.de>; Fri, 13 Dec 2024 11:13:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48B431D5AC0;
	Fri, 13 Dec 2024 11:13:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="dA66qloP"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-9102.amazon.com (smtp-fw-9102.amazon.com [207.171.184.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B34D61CEAD6
	for <netdev@vger.kernel.org>; Fri, 13 Dec 2024 11:13:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.171.184.29
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734088397; cv=none; b=Q3adrzBxFca3Za/sIrR3sp8jtExEtYwtfLandsSwc/+gKujIkke5MCeGgdLkt4lvStp7wdpTMIKvRbUxJg3aq9yZlX9xhCLGZM1h4VxwkPpWbvIxBwi5SR0VCFEUFqANc7wDFf4i5xku70HBCvrhqduSP6fmQObD1JIJ2ovnCbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734088397; c=relaxed/simple;
	bh=Q34nCa4XyV8Y7hhU2PAB1o5gdtIBDcTlktVJu9mHZNI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jEGnzE+Rhx1DvU4LMz9IvGc+9Ev/WBklD/dSozdOH9YuKSLvrr8NPC5fnxWy/8pEpbFv1o3tbBhFAc7AVF4hdtR1MxJYtH7i30qK4EZmARcr4eO3a0awcWARScOyz6LP6GynjnV44pN/6OV5taG7XRpkKW+PBGLev8dsWj7uMnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=dA66qloP; arc=none smtp.client-ip=207.171.184.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1734088396; x=1765624396;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Sa+1AHJRHNPZKT9mUFqQHIetiScdDa30cgWILWq8gUs=;
  b=dA66qloPCPoe1OkfwUPC44eErHMcvzWkJjUvuUv33O83QPYMNwIYwskF
   T4epPOgzK2fk3fqD5sKNaYJfSqUW16jcLWsV55/4cWR8Yw62CoCkaCjmY
   svm6vqm+UlvJWSrsfB55hRAVsIvnfavouaUCbaTBFU2mV+O/dsCOjFYJH
   A=;
X-IronPort-AV: E=Sophos;i="6.12,231,1728950400"; 
   d="scan'208";a="477826217"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.214])
  by smtp-border-fw-9102.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2024 11:13:15 +0000
Received: from EX19MTAUWB002.ant.amazon.com [10.0.21.151:5389]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.51.231:2525] with esmtp (Farcaster)
 id d3bcb8ab-ee54-46a3-aac7-b1f2345ce686; Fri, 13 Dec 2024 11:13:14 +0000 (UTC)
X-Farcaster-Flow-ID: d3bcb8ab-ee54-46a3-aac7-b1f2345ce686
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Fri, 13 Dec 2024 11:13:12 +0000
Received: from 6c7e67c6786f.amazon.com (10.119.14.208) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Fri, 13 Dec 2024 11:13:09 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>
CC: Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v2 net-next 12/12] af_unix: Remove unix_our_peer().
Date: Fri, 13 Dec 2024 20:08:50 +0900
Message-ID: <20241213110850.25453-13-kuniyu@amazon.com>
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
X-ClientProxiedBy: EX19D037UWB001.ant.amazon.com (10.13.138.123) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

unix_our_peer() is used only in unix_may_send().

Let's inline it in unix_may_send().

Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 net/unix/af_unix.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
index 239ce2f77d55..8f2b605ce5b3 100644
--- a/net/unix/af_unix.c
+++ b/net/unix/af_unix.c
@@ -286,14 +286,9 @@ static inline bool unix_secdata_eq(struct scm_cookie *scm, struct sk_buff *skb)
 }
 #endif /* CONFIG_SECURITY_NETWORK */
 
-static inline int unix_our_peer(struct sock *sk, struct sock *osk)
-{
-	return unix_peer(osk) == sk;
-}
-
 static inline int unix_may_send(struct sock *sk, struct sock *osk)
 {
-	return unix_peer(osk) == NULL || unix_our_peer(sk, osk);
+	return !unix_peer(osk) || unix_peer(osk) == sk;
 }
 
 static inline int unix_recvq_full_lockless(const struct sock *sk)
-- 
2.39.5 (Apple Git-154)


