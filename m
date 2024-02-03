Return-Path: <netdev+bounces-68770-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 65163847FD3
	for <lists+netdev@lfdr.de>; Sat,  3 Feb 2024 04:07:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 959411C226F1
	for <lists+netdev@lfdr.de>; Sat,  3 Feb 2024 03:07:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEC107469;
	Sat,  3 Feb 2024 03:07:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="JfkYVoqq"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-80006.amazon.com (smtp-fw-80006.amazon.com [99.78.197.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4474C79C3
	for <netdev@vger.kernel.org>; Sat,  3 Feb 2024 03:07:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.217
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706929622; cv=none; b=ZiNjeTZmS3ghaAGQCrPgL0r6Rp6nbYcYYNPtin87cVw/P2XKrjYU2IpZVmn7SCyeyMTHPhV2rmc+UO1weHpoJCoeorquZCZpHAlepYnuAaYW5lVGWQ4jIKt6qVY1tEfjQBqgRvDOEsSwye+/OzGLCqvfiRaD1N59sZ8WZnJrYAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706929622; c=relaxed/simple;
	bh=N3w+/gJFeXyn5LiPjnu0kjk1hQtYcAE7kC69Uy/A174=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LU1y63a1YOfAXGeGw64X5Po9TJDoh95+MdQ8eaxNKLdTisxxUX52WMT8gaB7ksYjKxp0qIHKAR6Ifxxkk1gyJWCNMRSLwgyCl8Kukbzv/euNhMdqFDOiZqBwmylJlLMRK/GhCBx9OAUMNi67gmcRkGWEoZKOk2aXi4gTBvVAd/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=JfkYVoqq; arc=none smtp.client-ip=99.78.197.217
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1706929621; x=1738465621;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=h9WGRZUCkyllJeaEC+ClIRuraigRCplHVYHIwfEiMi4=;
  b=JfkYVoqqRO7WfG0p+o6kHjeVMIGKBr0wc94hfUj8AvGn1vWWV3x9zul/
   yjOtGbC9eQZDjVyXDl2WNYBUb4TKbeHMFjRPxxDaT1Ctlde9KaJFCCvBs
   /cMdOFz2SxiNMP7drlj9XTIuu4tYXQl8bLyXYNREzrKzxycvsCbYdF77n
   Y=;
X-IronPort-AV: E=Sophos;i="6.05,238,1701129600"; 
   d="scan'208";a="270772109"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.214])
  by smtp-border-fw-80006.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2024 03:07:01 +0000
Received: from EX19MTAUWB001.ant.amazon.com [10.0.21.151:6257]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.28.242:2525] with esmtp (Farcaster)
 id f0297a35-2475-4e1c-957f-7d3e9b844870; Sat, 3 Feb 2024 03:07:00 +0000 (UTC)
X-Farcaster-Flow-ID: f0297a35-2475-4e1c-957f-7d3e9b844870
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Sat, 3 Feb 2024 03:07:00 +0000
Received: from 88665a182662.ant.amazon.com.com (10.106.101.14) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1118.40;
 Sat, 3 Feb 2024 03:06:57 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>
CC: Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v1 net-next 14/16] af_unix: Remove scm_fp_dup() in unix_attach_fds().
Date: Fri, 2 Feb 2024 19:00:56 -0800
Message-ID: <20240203030058.60750-15-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240203030058.60750-1-kuniyu@amazon.com>
References: <20240203030058.60750-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D036UWC003.ant.amazon.com (10.13.139.214) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

When we passed fds, we used to bump each file's recount twice before
linking the socket to a global list, gc_inflight_list.  Otherwise, the
inflight socket could have been garbage-collected before queuing skb.

Previously, we linked the inflight socket to the list in advance and
later queued the skb holding the socket.  So, there was a small race
window like this:

  CPU 1              CPU 2             CPU 3
  -----              -----             -----

  /* Here A's refcount is 1, and inflight count is 0 */

  bump A's refcount to 2
  bump A's inflight count to 1
  link A to list
                                       close(A) decreases
                                        A's refcount to 1
                     GC starts and
                      mark A as candidate
                      as refcount == inflight count

However, we no longer publish an inflight socket to GC before queueing
skb, so we can just move scm->fp to skb without cloning.

Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 net/unix/af_unix.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
index 0b70f7b5b5a8..9022a3a5dccc 100644
--- a/net/unix/af_unix.c
+++ b/net/unix/af_unix.c
@@ -1807,13 +1807,8 @@ static int unix_attach_fds(struct scm_cookie *scm, struct sk_buff *skb)
 	if (too_many_unix_fds(current))
 		return -ETOOMANYREFS;
 
-	/* Need to duplicate file references for the sake of garbage
-	 * collection.  Otherwise a socket in the fps might become a
-	 * candidate for GC while the skb is not yet queued.
-	 */
-	UNIXCB(skb).fp = scm_fp_dup(scm->fp);
-	if (!UNIXCB(skb).fp)
-		return -ENOMEM;
+	UNIXCB(skb).fp = scm->fp;
+	scm->fp = NULL;
 
 	if (unix_alloc_edges(UNIXCB(skb).fp))
 		return -ENOMEM;
-- 
2.30.2


