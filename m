Return-Path: <netdev+bounces-176342-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F3C2DA69C90
	for <lists+netdev@lfdr.de>; Thu, 20 Mar 2025 00:10:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A2FF97B04A3
	for <lists+netdev@lfdr.de>; Wed, 19 Mar 2025 23:09:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59C12222592;
	Wed, 19 Mar 2025 23:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="jL/fwy7d"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-52003.amazon.com (smtp-fw-52003.amazon.com [52.119.213.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92CC71C3C11
	for <netdev@vger.kernel.org>; Wed, 19 Mar 2025 23:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742425813; cv=none; b=dXlGeQa4Wud8WVKwYxOWKlEv+9DW24f5yI3ghtgHGJtJJThfqvDon5W2rLzei66M+wlFaAhjK4p+j2zjMUOCawpJqU1anN2rPW/IVBKvDy3XewpYPDbnANv2in3GSne7iXcjf6DDVZ8a1W3/2mnhPRgi9jswMdeP/4qHl194QfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742425813; c=relaxed/simple;
	bh=cgjCCCV1WhRMS9ssH6ViSX7G6MulIT9YN90OMb5mi90=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AIpr/v2cGPFYH13NZH+4fZVwMq6W09tEOAQEozUk8WTHdff330cixfPo4P41qi0ZalkWts4v6lhPjdlQOtBbV5fbp1nEz+zhVGbSrIHcV/kyZEXfEQWZIRbN0gIf+mcSbKl6vLYtN1o6z+PR7GxG6HiJ4rNCCCS9QJLkAXjH4mk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=jL/fwy7d; arc=none smtp.client-ip=52.119.213.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1742425811; x=1773961811;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=0+nscCY0DUZa8OudsLTSJX+MYM2hnUZrTFpsmKJPd6E=;
  b=jL/fwy7dhFTt08nkXsf/QelbCyoEA7y8AGnVZ0pedMsLi6ASwN40Xd8+
   QYzmH69GI0LztiI8xQGNc2kJa1asxYX0weBzItkCf4IY/FQRFD4Wixw+r
   zDuMgm4uNOKcuF9y1xyuSxtJ+PxbguOK+tYlSdxF5xq/CYSllJdJLqXaB
   k=;
X-IronPort-AV: E=Sophos;i="6.14,260,1736812800"; 
   d="scan'208";a="75909798"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-52003.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2025 23:10:10 +0000
Received: from EX19MTAUWA001.ant.amazon.com [10.0.21.151:7940]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.62.245:2525] with esmtp (Farcaster)
 id 467df05c-d04c-4188-b06c-85af04647411; Wed, 19 Mar 2025 23:10:09 +0000 (UTC)
X-Farcaster-Flow-ID: 467df05c-d04c-4188-b06c-85af04647411
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA001.ant.amazon.com (10.250.64.204) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Wed, 19 Mar 2025 23:10:08 +0000
Received: from 6c7e67bfbae3.amazon.com (10.106.100.42) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Wed, 19 Mar 2025 23:10:06 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: David Ahern <dsahern@kernel.org>, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, "Paolo
 Abeni" <pabeni@redhat.com>
CC: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@amazon.com>,
	Kuniyuki Iwashima <kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v2 net-next 5/7] nexthop: Remove redundant group len check in nexthop_create_group().
Date: Wed, 19 Mar 2025 16:06:50 -0700
Message-ID: <20250319230743.65267-6-kuniyu@amazon.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250319230743.65267-1-kuniyu@amazon.com>
References: <20250319230743.65267-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D031UWC004.ant.amazon.com (10.13.139.246) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

The number of NHA_GROUP entries is guaranteed to be non-zero in
nh_check_attr_group().

Let's remove the redundant check in nexthop_create_group().

Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 net/ipv4/nexthop.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/net/ipv4/nexthop.c b/net/ipv4/nexthop.c
index fb129c830040..c552bb46aa23 100644
--- a/net/ipv4/nexthop.c
+++ b/net/ipv4/nexthop.c
@@ -2692,9 +2692,6 @@ static struct nexthop *nexthop_create_group(struct net *net,
 	int err;
 	int i;
 
-	if (WARN_ON(!num_nh))
-		return ERR_PTR(-EINVAL);
-
 	nh = nexthop_alloc();
 	if (!nh)
 		return ERR_PTR(-ENOMEM);
-- 
2.48.1


