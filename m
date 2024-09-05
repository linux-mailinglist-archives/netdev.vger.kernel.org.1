Return-Path: <netdev+bounces-125665-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B13C96E345
	for <lists+netdev@lfdr.de>; Thu,  5 Sep 2024 21:34:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 774D51C23DA4
	for <lists+netdev@lfdr.de>; Thu,  5 Sep 2024 19:34:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9010188934;
	Thu,  5 Sep 2024 19:34:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="VqEGhER/"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-52002.amazon.com (smtp-fw-52002.amazon.com [52.119.213.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32E7C4400
	for <netdev@vger.kernel.org>; Thu,  5 Sep 2024 19:34:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725564859; cv=none; b=kAgghttwqGl/xL0XKVpz3qTZJTg/yOMe4FHoWeCGxuwc0fI34mhOptqG1i2Xov4Rtk8ZFoDMbQ28AUjG4qup/YM5ARJAimqsKnVN71H+qb4l+Z+2RPsS5v7y4t837SHp9A+PiRyKlUKytO1Y+cKbZTksqBBQ8jh/BmIgd+lUb6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725564859; c=relaxed/simple;
	bh=ep50VOoQwRPEfqQs7YjeY6Qb/UN/OIDTmdx5lVNqzQI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iHe/VnFEHCbAab2udd8117NSiRfOkIy3rI7uaGB900dNMmKzRoVoReqjUgGEE2q3V99DFy2ltU5fa0Yz00XfMqwFApCrdAkMk4R9+dWT4suE/ycmCBpPVhbYXD/LEeyRVQCVDFrmcbeHMCvl4XIhCi3lWyYXSJM1RZXYV8eJ6zc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=VqEGhER/; arc=none smtp.client-ip=52.119.213.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1725564858; x=1757100858;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=BR0ZYatHwLzVarDvwgM6K8YdrP5PkWLbG8R8s+iDzIY=;
  b=VqEGhER/UYUzsxPXMf5fUmVDxnshS3WGrefmJdQ2/pSmXk8NFAtcsTH2
   +TYLXqJ9XiwMwqNFGp3qTTMWj0vDZnM3b74bNjCCq764O2lEUNW0MYaVX
   xuO8KuOswEJuwNlZbTnf240vdWsf1DW+/nOqqxtfJgXEdgSlveZWy0TkN
   Q=;
X-IronPort-AV: E=Sophos;i="6.10,205,1719878400"; 
   d="scan'208";a="657079320"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-52002.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Sep 2024 19:34:15 +0000
Received: from EX19MTAUWB001.ant.amazon.com [10.0.7.35:32337]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.55.175:2525] with esmtp (Farcaster)
 id 4a3f7e7b-b9a1-4634-bdfb-08bd217de512; Thu, 5 Sep 2024 19:34:14 +0000 (UTC)
X-Farcaster-Flow-ID: 4a3f7e7b-b9a1-4634-bdfb-08bd217de512
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Thu, 5 Sep 2024 19:34:10 +0000
Received: from 88665a182662.ant.amazon.com (10.106.100.51) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.35;
 Thu, 5 Sep 2024 19:34:08 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>
CC: Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v1 net-next 3/4] af_unix: Move spin_lock() in manage_oob().
Date: Thu, 5 Sep 2024 12:32:39 -0700
Message-ID: <20240905193240.17565-4-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240905193240.17565-1-kuniyu@amazon.com>
References: <20240905193240.17565-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D033UWA004.ant.amazon.com (10.13.139.85) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

When OOB skb has been already consumed, manage_oob() returns the next
skb if exists.  In such a case, we need to fall back to the else branch
below.

Then, we want to keep holding spin_lock(&sk->sk_receive_queue.lock).

Let's move it out of if-else branch and add lightweight check before
spin_lock() for major use cases without OOB skb.

Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 net/unix/af_unix.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
index 91d7877a1079..159d78fc3d14 100644
--- a/net/unix/af_unix.c
+++ b/net/unix/af_unix.c
@@ -2657,9 +2657,12 @@ static struct sk_buff *manage_oob(struct sk_buff *skb, struct sock *sk,
 	struct sk_buff *read_skb = NULL, *unread_skb = NULL;
 	struct unix_sock *u = unix_sk(sk);
 
-	if (!unix_skb_len(skb)) {
-		spin_lock(&sk->sk_receive_queue.lock);
+	if (likely(unix_skb_len(skb) && skb != READ_ONCE(u->oob_skb)))
+		return skb;
 
+	spin_lock(&sk->sk_receive_queue.lock);
+
+	if (!unix_skb_len(skb)) {
 		if (copied && (!u->oob_skb || skb == u->oob_skb)) {
 			skb = NULL;
 		} else if (flags & MSG_PEEK) {
@@ -2670,14 +2673,9 @@ static struct sk_buff *manage_oob(struct sk_buff *skb, struct sock *sk,
 			__skb_unlink(read_skb, &sk->sk_receive_queue);
 		}
 
-		spin_unlock(&sk->sk_receive_queue.lock);
-
-		consume_skb(read_skb);
-		return skb;
+		goto unlock;
 	}
 
-	spin_lock(&sk->sk_receive_queue.lock);
-
 	if (skb != u->oob_skb)
 		goto unlock;
 
@@ -2698,6 +2696,7 @@ static struct sk_buff *manage_oob(struct sk_buff *skb, struct sock *sk,
 unlock:
 	spin_unlock(&sk->sk_receive_queue.lock);
 
+	consume_skb(read_skb);
 	kfree_skb(unread_skb);
 
 	return skb;
-- 
2.30.2


