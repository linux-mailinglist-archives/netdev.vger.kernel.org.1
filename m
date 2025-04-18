Return-Path: <netdev+bounces-183996-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00E0AA92EA4
	for <lists+netdev@lfdr.de>; Fri, 18 Apr 2025 02:08:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1BA044A002E
	for <lists+netdev@lfdr.de>; Fri, 18 Apr 2025 00:08:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57B154A01;
	Fri, 18 Apr 2025 00:08:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="b6ErQaSk"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-80006.amazon.com (smtp-fw-80006.amazon.com [99.78.197.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D31583C30
	for <netdev@vger.kernel.org>; Fri, 18 Apr 2025 00:08:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.217
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744934917; cv=none; b=rOY5aE/Jf3jCIX1nAs+6TP01FvOb7lLspwC2krkZ70U3lrn+OCmkwfKOi/EfyYq8rOq+WOIVwqjqNmjEepUfmVdXwnczwoqSddHTmQnvL76lopeeF24+bNdB5soHEn6Kv9H9wIX8oFL12tXx/1x/Nf77oQdYogJbSegYhCgsGgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744934917; c=relaxed/simple;
	bh=XC4DC1youASP2x8nFAqmoT4PbQsEIh5HauJs/aMf70s=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=U56n6Am/mEjwe9dXdwxu3CHaJm5KTBMk1tEExX5kO8I9DHBUtkC0NXBhX+XUl31BFGqOCTbxPl1yhDdyut1i7UdVcTuuSu0VvxJKOd0zYpaRmXvVLn6Oi91/WbhHA8+IMZsEK3b5QzIhIYYD8rp3wJ5MT2f3b7OuhEpdl8cjV/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=b6ErQaSk; arc=none smtp.client-ip=99.78.197.217
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1744934916; x=1776470916;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=LJZUXxmKaCTUQVVUwy5Cspv1ZWBy26pfo9q0xyLuGN8=;
  b=b6ErQaSkPw2FLecod1DrlD3G74nboPfmYnU0ADtW5TWkisvjlGuoP+vO
   xWmkyeGlqfourBBk15bGKA7SwAqEDRfvfaKaslSkQ0IucDpLdsUni1GLQ
   gZaFdz2tGLfHuxccGc6lIyDVrbEe73X3cZQhtIru71a+cZ69WounZBOQ2
   g=;
X-IronPort-AV: E=Sophos;i="6.15,220,1739836800"; 
   d="scan'208";a="41634107"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.214])
  by smtp-border-fw-80006.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2025 00:08:34 +0000
Received: from EX19MTAUWB001.ant.amazon.com [10.0.21.151:38407]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.13.240:2525] with esmtp (Farcaster)
 id 8de30197-680b-4b71-aca8-66aeba7cfabd; Fri, 18 Apr 2025 00:08:33 +0000 (UTC)
X-Farcaster-Flow-ID: 8de30197-680b-4b71-aca8-66aeba7cfabd
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Fri, 18 Apr 2025 00:08:32 +0000
Received: from 6c7e67bfbae3.amazon.com (10.94.49.59) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Fri, 18 Apr 2025 00:08:29 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, "Paolo
 Abeni" <pabeni@redhat.com>
CC: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@amazon.com>,
	Kuniyuki Iwashima <kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v3 net-next 09/15] ipv6: Don't pass net to ip6_route_info_append().
Date: Thu, 17 Apr 2025 17:03:50 -0700
Message-ID: <20250418000443.43734-10-kuniyu@amazon.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250418000443.43734-1-kuniyu@amazon.com>
References: <20250418000443.43734-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D039UWA004.ant.amazon.com (10.13.139.68) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

net is not used in ip6_route_info_append() after commit 36f19d5b4f99
("net/ipv6: Remove extra call to ip6_convert_metrics for multipath case").

Let's remove the argument.

Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
Acked-by: Paolo Abeni <pabeni@redhat.com>
---
 net/ipv6/route.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/net/ipv6/route.c b/net/ipv6/route.c
index ea755027cf61..af11fcaa5cf3 100644
--- a/net/ipv6/route.c
+++ b/net/ipv6/route.c
@@ -5317,8 +5317,7 @@ struct rt6_nh {
 	struct list_head next;
 };
 
-static int ip6_route_info_append(struct net *net,
-				 struct list_head *rt6_nh_list,
+static int ip6_route_info_append(struct list_head *rt6_nh_list,
 				 struct fib6_info *rt,
 				 struct fib6_config *r_cfg)
 {
@@ -5458,8 +5457,7 @@ static int ip6_route_multipath_add(struct fib6_config *cfg,
 
 		rt->fib6_nh->fib_nh_weight = rtnh->rtnh_hops + 1;
 
-		err = ip6_route_info_append(info->nl_net, &rt6_nh_list,
-					    rt, &r_cfg);
+		err = ip6_route_info_append(&rt6_nh_list, rt, &r_cfg);
 		if (err) {
 			fib6_info_release(rt);
 			goto cleanup;
-- 
2.49.0


