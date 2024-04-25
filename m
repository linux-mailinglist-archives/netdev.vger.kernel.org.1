Return-Path: <netdev+bounces-91396-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E3B138B2710
	for <lists+netdev@lfdr.de>; Thu, 25 Apr 2024 19:00:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7B5FC1F22FAF
	for <lists+netdev@lfdr.de>; Thu, 25 Apr 2024 17:00:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1827F14A4EC;
	Thu, 25 Apr 2024 17:00:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="LKF8iZt6"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-52002.amazon.com (smtp-fw-52002.amazon.com [52.119.213.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65DB23A1CC
	for <netdev@vger.kernel.org>; Thu, 25 Apr 2024 17:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714064455; cv=none; b=DgJP/fdROnbh8+8G3HSAkEXNs5TigJBsJOKj/MQ41Sih8fSUoCQ0SZO/Xsbq59uT6OKz8bq2OUS/jJ7N/xupOl38wf9MROjqW+6YRa2ryYH64799BtJOhrvWxAvxQpfPt+K0rHaCLAF0XiH/o7K7LT2FRmStJ21kkR8640o3nU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714064455; c=relaxed/simple;
	bh=uCOmAoqMz19Yew1YDU0a3XbyL720lmv8ZVwH2aCnMnY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TYqjxcrv/6UmswKBiZHMwAGs2KTpUw2YvQCeBppj1CRtyBC0nMQxaLLBKO3Q5/J957aCapNTmvBzaN78xXOO+3rHP4gsVqd1WTqhXqtvnzj+fIkhttd6umRsCaEQfB6M0bwlleaYx+3PAGBA2sB0gHtOeolXoQT7QmTVuZFJQFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=LKF8iZt6; arc=none smtp.client-ip=52.119.213.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1714064454; x=1745600454;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=w8/AwnpuGsPRfABxQF//F/qaOZAknYKOjVg/eeaiuYk=;
  b=LKF8iZt6r7llq25fSCRhOgq/LFqSnykWPsk38q1e3o6rtD8l5+jxspaj
   v+mC48kXwL15NsAlru8zYcMuVvzIcpmYN21VZw3yaPKCcwm9f9mqUcf+d
   6wnHc0mhEvEZ/ukKyVnK3qBRkpq0fWSzNvqLNPKqI0I4nbSY8/hJ635Fy
   w=;
X-IronPort-AV: E=Sophos;i="6.07,230,1708387200"; 
   d="scan'208";a="629069404"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-52002.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Apr 2024 17:00:50 +0000
Received: from EX19MTAUWB001.ant.amazon.com [10.0.7.35:46719]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.44.127:2525] with esmtp (Farcaster)
 id 6d56c8c2-0a2d-4d67-a075-fa805a6677f5; Thu, 25 Apr 2024 17:00:48 +0000 (UTC)
X-Farcaster-Flow-ID: 6d56c8c2-0a2d-4d67-a075-fa805a6677f5
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Thu, 25 Apr 2024 17:00:43 +0000
Received: from 88665a182662.ant.amazon.com (10.106.101.18) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Thu, 25 Apr 2024 17:00:40 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, "Paolo
 Abeni" <pabeni@redhat.com>
CC: Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v2 net-next 1/6] arp: Move ATF_COM setting in arp_req_set().
Date: Thu, 25 Apr 2024 09:59:57 -0700
Message-ID: <20240425170002.68160-2-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240425170002.68160-1-kuniyu@amazon.com>
References: <20240425170002.68160-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D039UWA001.ant.amazon.com (10.13.139.110) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

In arp_req_set(), if ATF_PERM is set in arpreq.arp_flags,
ATF_COM is set automatically.

The flag will be used later for neigh_update() only when
a neighbour entry is found.

Let's set ATF_COM just before calling neigh_update().

Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 net/ipv4/arp.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/net/ipv4/arp.c b/net/ipv4/arp.c
index ab82ca104496..3093374165fa 100644
--- a/net/ipv4/arp.c
+++ b/net/ipv4/arp.c
@@ -1054,8 +1054,7 @@ static int arp_req_set(struct net *net, struct arpreq *r,
 		return arp_req_set_public(net, r, dev);
 
 	ip = ((struct sockaddr_in *)&r->arp_pa)->sin_addr.s_addr;
-	if (r->arp_flags & ATF_PERM)
-		r->arp_flags |= ATF_COM;
+
 	if (!dev) {
 		struct rtable *rt = ip_route_output(net, ip, 0, 0, 0,
 						    RT_SCOPE_LINK);
@@ -1092,8 +1091,12 @@ static int arp_req_set(struct net *net, struct arpreq *r,
 	err = PTR_ERR(neigh);
 	if (!IS_ERR(neigh)) {
 		unsigned int state = NUD_STALE;
-		if (r->arp_flags & ATF_PERM)
+
+		if (r->arp_flags & ATF_PERM) {
+			r->arp_flags |= ATF_COM;
 			state = NUD_PERMANENT;
+		}
+
 		err = neigh_update(neigh, (r->arp_flags & ATF_COM) ?
 				   r->arp_ha.sa_data : NULL, state,
 				   NEIGH_UPDATE_F_OVERRIDE |
-- 
2.30.2


