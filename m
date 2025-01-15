Return-Path: <netdev+bounces-158403-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 63049A11B84
	for <lists+netdev@lfdr.de>; Wed, 15 Jan 2025 09:07:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8D86A1625F3
	for <lists+netdev@lfdr.de>; Wed, 15 Jan 2025 08:07:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3447322FDE9;
	Wed, 15 Jan 2025 08:07:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="VQRGvemj"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-33001.amazon.com (smtp-fw-33001.amazon.com [207.171.190.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9C4C22FAE2
	for <netdev@vger.kernel.org>; Wed, 15 Jan 2025 08:07:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.171.190.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736928474; cv=none; b=gLg3ecEuO5v3kKmp/pFcxb+KeJ3OQCPsDBwSCfQ9V6V/W374wL6Y48fKDT39AazFkn371csJczgppW1kK0R942tDmRA3E88apk1VFJzK5KM4zF4DmISw4HZIuu90lT4nvW7tO3iIkb7CO22n5B0qzSjkC2DfmyhvoJbiBjEJ6Mo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736928474; c=relaxed/simple;
	bh=4zglpwGOFXNlQxQ4SW65AFnRGhsFcVKDT7CLU2GS9So=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=l3yyiiNKuc3xrm/o9zDvJU9NY5Rk1amWI+Iy7TYR2CPtHiZVGHMdMUaXjLhLAaLv4yv3djaNtsXA3KXz1nKeuM9CiTv0FZeG2Ku5IPFlWYAn2zAc65ph+c7LUcsVs2OyIhspvIIKUPlX+4qO61dxDts5D/8JpcHUYJkZ9jJEYh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=VQRGvemj; arc=none smtp.client-ip=207.171.190.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1736928473; x=1768464473;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=d+ZrDEkjvWf0BJUc8AFOKP1uBzysKKemrFWx8dCPvn4=;
  b=VQRGvemj5TYF7JzaBYUSNm1DG2wrqryhXgcU9M75bqptCjYp9PzoZ/p6
   RCzeRxuOVH+ePj4NLHcJem4jHMuP8puFAFToY1oxqqwL9+h4XqUBN2WHT
   ecVXixjEeGyhWWNzv1ojCgiCOmp7R6NoR3OlzXywO6aF59i7rvt0eoTom
   4=;
X-IronPort-AV: E=Sophos;i="6.12,316,1728950400"; 
   d="scan'208";a="400957222"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-33001.sea14.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jan 2025 08:07:47 +0000
Received: from EX19MTAUWB001.ant.amazon.com [10.0.21.151:31305]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.29.180:2525] with esmtp (Farcaster)
 id aa60211b-268c-484e-a857-d7e1b0794fdd; Wed, 15 Jan 2025 08:07:46 +0000 (UTC)
X-Farcaster-Flow-ID: aa60211b-268c-484e-a857-d7e1b0794fdd
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Wed, 15 Jan 2025 08:07:45 +0000
Received: from 6c7e67c6786f.amazon.com (10.118.248.178) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Wed, 15 Jan 2025 08:07:41 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, David Ahern <dsahern@kernel.org>
CC: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@amazon.com>,
	Kuniyuki Iwashima <kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v2 net-next 03/11] ipv6: Hold rtnl_net_lock() in addrconf_verify_work().
Date: Wed, 15 Jan 2025 17:06:00 +0900
Message-ID: <20250115080608.28127-4-kuniyu@amazon.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250115080608.28127-1-kuniyu@amazon.com>
References: <20250115080608.28127-1-kuniyu@amazon.com>
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

addrconf_verify_work() is per-netns work to call addrconf_verify_rtnl()
under RTNL.

Let's use rtnl_net_lock().

Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 net/ipv6/addrconf.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/ipv6/addrconf.c b/net/ipv6/addrconf.c
index fb0ef98c79b0..fe85cb2d49c8 100644
--- a/net/ipv6/addrconf.c
+++ b/net/ipv6/addrconf.c
@@ -4751,9 +4751,9 @@ static void addrconf_verify_work(struct work_struct *w)
 	struct net *net = container_of(to_delayed_work(w), struct net,
 				       ipv6.addr_chk_work);
 
-	rtnl_lock();
+	rtnl_net_lock(net);
 	addrconf_verify_rtnl(net);
-	rtnl_unlock();
+	rtnl_net_unlock(net);
 }
 
 static void addrconf_verify(struct net *net)
-- 
2.39.5 (Apple Git-154)


