Return-Path: <netdev+bounces-149605-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EA879E66EA
	for <lists+netdev@lfdr.de>; Fri,  6 Dec 2024 06:31:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1F5A528223D
	for <lists+netdev@lfdr.de>; Fri,  6 Dec 2024 05:31:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12E091957F8;
	Fri,  6 Dec 2024 05:31:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="ncJNSd+X"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-52004.amazon.com (smtp-fw-52004.amazon.com [52.119.213.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68B2C193426
	for <netdev@vger.kernel.org>; Fri,  6 Dec 2024 05:31:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733463093; cv=none; b=kT29rMbNR4X+WOdWzu2H/cZguoUGUyx0yibLZ6fnrwlk2MJ0lZfx4TsJrzZLDjIaolJ3i9K1hGGubq8ZALxUd4EfqurY6oVHqs1hI/2seUR05GcfJ3QHtbV6u6pk7X+YX24WZ2YHIS8X34xs/f/3Fc2cV5qSyoYE8GMrvCMmoHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733463093; c=relaxed/simple;
	bh=ptZFKGbvhDojAx0WjjIYnU464hKds0bNPN6t7v0Q/ho=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Y0bf2IMRb9ZB7TAKo43QwKHbh1SyoWTeL4yWYZXiFzYdLWUT+4q8eGpCR5XuwWUJxBQrvX6hqlze0gWYcC/d1U87YH9vlWjOgHdy4VujEaItkopxGuBhPi2k/fXN/M5qwVj24K2bSYMv0k6GhTIeaqxgqc9o3z/tYAZbkJsIPAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=ncJNSd+X; arc=none smtp.client-ip=52.119.213.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1733463091; x=1764999091;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=W+8ztfP9vvFUrecz7CEeUdf2VOI5uiIGMGkDsH4/+qk=;
  b=ncJNSd+X+qNnJ30YEgAPGgCjcjgxc1v8NJodVNHcIgUI2F4hbpFWIE4i
   FNWBEcJCXdzNV2Hv8zJ8DR0Pc7GvYgByM0f5TpRI75ZLmo3yAZUtqQLVH
   Nd9Fzn0zoYrQMW3oBGy47NKYRu7Ol9RikKHKGIdaEBJNYUIiBaZa+VUti
   A=;
X-IronPort-AV: E=Sophos;i="6.12,212,1728950400"; 
   d="scan'208";a="252777651"
Received: from iad6-co-svc-p1-lb1-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.124.125.2])
  by smtp-border-fw-52004.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Dec 2024 05:31:29 +0000
Received: from EX19MTAUWB002.ant.amazon.com [10.0.21.151:35254]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.22.41:2525] with esmtp (Farcaster)
 id 0be9c51a-1429-442e-9b20-03bf71bcc217; Fri, 6 Dec 2024 05:31:28 +0000 (UTC)
X-Farcaster-Flow-ID: 0be9c51a-1429-442e-9b20-03bf71bcc217
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Fri, 6 Dec 2024 05:31:28 +0000
Received: from 6c7e67c6786f.amazon.com (10.118.244.93) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.35;
 Fri, 6 Dec 2024 05:31:25 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>
CC: Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v1 net-next 15/15] af_unix: Remove unix_our_peer().
Date: Fri, 6 Dec 2024 14:26:07 +0900
Message-ID: <20241206052607.1197-16-kuniyu@amazon.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20241206052607.1197-1-kuniyu@amazon.com>
References: <20241206052607.1197-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D041UWB001.ant.amazon.com (10.13.139.132) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

unix_our_peer() is used only in unix_may_send().

Let's inline it in unix_may_send().

Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 net/unix/af_unix.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
index 594c7428f22d..c59089678207 100644
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


