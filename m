Return-Path: <netdev+bounces-83794-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A54F4894458
	for <lists+netdev@lfdr.de>; Mon,  1 Apr 2024 19:32:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 603012812EA
	for <lists+netdev@lfdr.de>; Mon,  1 Apr 2024 17:32:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FAF7481C6;
	Mon,  1 Apr 2024 17:32:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="NCLtYrLL"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-9105.amazon.com (smtp-fw-9105.amazon.com [207.171.188.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B30BA3EA68
	for <netdev@vger.kernel.org>; Mon,  1 Apr 2024 17:32:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.171.188.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711992735; cv=none; b=Db3uPNaLZRt1q+oRWxIOjbxmgoDahb7Pn/xOylyiDGiVLo6rljHXtFITY09vGvU/PbXPLJQPa7dWxORTtmzWXOKVTN8fFZgWLNYTi7qjErJhhDLvjuC7VEcKNUXcHpOy7Bnux9ZuR0xjIL2jblLNhqEo9MykHnQs8ya0QftPqXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711992735; c=relaxed/simple;
	bh=1zDacyqkxAHO02Bt/cmzWmviOxPUU5Mz8/NA1SpyQ2k=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ppDOnowCOUnbdo4b9EJE5W8j61sltxkYvNG3y9JDQAhqAldxkBmnYfE7gsU0vlDrtZQU7ckKsAkvPcuEWHhGNm1EcpOomsXxQk3a9CD2fV4De3oRa3mGkUz7HNtAeLkqs+j8LVtIR61i4OYzkL1+AoaSFqo97cc2bP/HtSM/rzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=NCLtYrLL; arc=none smtp.client-ip=207.171.188.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1711992734; x=1743528734;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=GoWsrCKHGECxBP1Yq+xJxvz2TNt0lhDDkOC4AkP4B+g=;
  b=NCLtYrLLJJyxZZdZpYuNI9bg3KuCN5xEKr8fpSjtzBhWqO4mttYjiMgw
   1H9fTsbFSQti/jLH/TDvJCVZaVMZYMwDzi9l1xeAP/OVU4rPTpmPcFYrv
   9RjC2JbCTT7C8eSLrBIsGHb6DuxFe1eP7bn44pketHLG8u9sJA3tIgo6J
   o=;
X-IronPort-AV: E=Sophos;i="6.07,172,1708387200"; 
   d="scan'208";a="715851767"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-9105.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2024 17:32:07 +0000
Received: from EX19MTAUWC001.ant.amazon.com [10.0.21.151:7952]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.7.132:2525] with esmtp (Farcaster)
 id 4a040211-9ac9-4fd7-b6e2-96e839cdc662; Mon, 1 Apr 2024 17:32:06 +0000 (UTC)
X-Farcaster-Flow-ID: 4a040211-9ac9-4fd7-b6e2-96e839cdc662
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Mon, 1 Apr 2024 17:32:06 +0000
Received: from 88665a182662.ant.amazon.com.com (10.106.100.32) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Mon, 1 Apr 2024 17:32:03 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>
CC: Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v1 net-next 1/2] af_unix: Remove scm_fp_dup() in unix_attach_fds().
Date: Mon, 1 Apr 2024 10:31:24 -0700
Message-ID: <20240401173125.92184-2-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240401173125.92184-1-kuniyu@amazon.com>
References: <20240401173125.92184-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D039UWA003.ant.amazon.com (10.13.139.49) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

When we passed fds, we used to bump each file's refcount twice
in scm_fp_copy() and scm_fp_dup() before linking the socket to
gc_inflight_list.

This is because we incremented the inflight count of the socket
and linked it to the list in advance before passing skb to the
destination socket.

Otherwise, the inflight socket could have been garbage-collected
in a small race window between linking the socket to the list and
queuing skb:

  CPU 1 : sendmsg(X) w/ A's fd     CPU 2 : close(A)
  -----                            -----
  /* Here A's refcount is 1, and inflight count is 0 */

  bump A's refcount to 2 in scm_fp_copy()
  bump A's inflight count to 1
  link A to gc_inflight_list
                                   decrement A's refcount to 1

  /* A's refcount == inflight count, thus A could be GC candidate */

                                   start GC
                                   mark A as candidate
                                   purge A's receive queue

  queue skb w/ A's fd to X

  /* A is queued, but all data has been lost */

After commit 4090fa373f0e ("af_unix: Replace garbage collection
algorithm."), we increment the inflight count and link the socket
to the global list only when queuing the skb.

The race no longer exists, so let's not clone the fd nor bump
the count in unix_attach_fds().

Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 net/unix/af_unix.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
index 533fb682c954..78be8b520cef 100644
--- a/net/unix/af_unix.c
+++ b/net/unix/af_unix.c
@@ -1794,13 +1794,8 @@ static int unix_attach_fds(struct scm_cookie *scm, struct sk_buff *skb)
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
 
 	if (unix_prepare_fpl(UNIXCB(skb).fp))
 		return -ENOMEM;
-- 
2.30.2


