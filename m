Return-Path: <netdev+bounces-92298-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D70F48B67C4
	for <lists+netdev@lfdr.de>; Tue, 30 Apr 2024 04:00:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 50A431F231FC
	for <lists+netdev@lfdr.de>; Tue, 30 Apr 2024 02:00:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E556E2CA9;
	Tue, 30 Apr 2024 02:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="Lcc3d+3A"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-80006.amazon.com (smtp-fw-80006.amazon.com [99.78.197.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 896B079F2
	for <netdev@vger.kernel.org>; Tue, 30 Apr 2024 02:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.217
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714442407; cv=none; b=gSGmffT/5BWXdBeYzq5ks5ogoNS/r23/MunALTaLK5rEAgyCiQkq0pEJno2qq+btz8xsB7p/lP3K+FlIPxHOotFWWVg3Ech94ndZJ5bEauPT9spoS51ELwoRPoTQCcfoGhlMpodjHOQ3u96OlCTaA+h+5hm1Esj7f853dwO/2QM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714442407; c=relaxed/simple;
	bh=TaUSGeX4ooF8apZeC63KXkYPPDwPtljgEbAp1vQ0Hkw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XwC+FXH4qZRnTjAkW01HBq4W9VCg5ZBFDzxpxUlxkqWnTS8Ke7Dao7FvJ2MO14NjiUimLDf6ZRZOJz97VPQQQzQAWsAmkXE47Lm68tVgoeSGJf7iC8vAtWB6ugLH9Chyf+RdlWN5XILh4CY2gs9WrGcZs5y1dblxhW2R25sx8wM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=Lcc3d+3A; arc=none smtp.client-ip=99.78.197.217
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1714442407; x=1745978407;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=RaF98YL7yXmFqXvONl7i4hefr/oT7ESfH7oYrt9h4FA=;
  b=Lcc3d+3AvBylZY1/R9jJRReqV+h1c8UvyZXoUGIxylZPt5Lvf16K9Nsc
   ZdZSY+x+ip9xTF/+iWuPwkqEjdJd4LIn9Pc0GzWexNnWY3ocYE52W2HsH
   sQqV/Lpds9n7thTV8iA7KQwXTNuLAeXmIQLESrmzpIrSxH5Q40deXdqY7
   c=;
X-IronPort-AV: E=Sophos;i="6.07,241,1708387200"; 
   d="scan'208";a="291627980"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.214])
  by smtp-border-fw-80006.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2024 02:00:07 +0000
Received: from EX19MTAUWC001.ant.amazon.com [10.0.7.35:53953]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.35.127:2525] with esmtp (Farcaster)
 id 85c01664-32ac-4906-a58f-557d71cc905c; Tue, 30 Apr 2024 02:00:05 +0000 (UTC)
X-Farcaster-Flow-ID: 85c01664-32ac-4906-a58f-557d71cc905c
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Tue, 30 Apr 2024 02:00:04 +0000
Received: from 88665a182662.ant.amazon.com (10.106.101.33) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Tue, 30 Apr 2024 02:00:02 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, "Paolo
 Abeni" <pabeni@redhat.com>
CC: Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v3 net-next 4/7] arp: Remove a nest in arp_req_get().
Date: Mon, 29 Apr 2024 18:58:10 -0700
Message-ID: <20240430015813.71143-5-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240430015813.71143-1-kuniyu@amazon.com>
References: <20240430015813.71143-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D042UWB004.ant.amazon.com (10.13.139.150) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

This is a prep patch to make the following changes tidy.

No functional change intended.

Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 net/ipv4/arp.c | 31 ++++++++++++++++++-------------
 1 file changed, 18 insertions(+), 13 deletions(-)

diff --git a/net/ipv4/arp.c b/net/ipv4/arp.c
index ac3e15799c2f..60f633b24ec8 100644
--- a/net/ipv4/arp.c
+++ b/net/ipv4/arp.c
@@ -1138,23 +1138,28 @@ static int arp_req_get(struct arpreq *r, struct net_device *dev)
 {
 	__be32 ip = ((struct sockaddr_in *) &r->arp_pa)->sin_addr.s_addr;
 	struct neighbour *neigh;
-	int err = -ENXIO;
 
 	neigh = neigh_lookup(&arp_tbl, &ip, dev);
-	if (neigh) {
-		if (!(READ_ONCE(neigh->nud_state) & NUD_NOARP)) {
-			read_lock_bh(&neigh->lock);
-			memcpy(r->arp_ha.sa_data, neigh->ha,
-			       min(dev->addr_len, sizeof(r->arp_ha.sa_data_min)));
-			r->arp_flags = arp_state_to_flags(neigh);
-			read_unlock_bh(&neigh->lock);
-			r->arp_ha.sa_family = dev->type;
-			strscpy(r->arp_dev, dev->name, sizeof(r->arp_dev));
-			err = 0;
-		}
+	if (!neigh)
+		return -ENXIO;
+
+	if (READ_ONCE(neigh->nud_state) & NUD_NOARP) {
 		neigh_release(neigh);
+		return -ENXIO;
 	}
-	return err;
+
+	read_lock_bh(&neigh->lock);
+	memcpy(r->arp_ha.sa_data, neigh->ha,
+	       min(dev->addr_len, sizeof(r->arp_ha.sa_data_min)));
+	r->arp_flags = arp_state_to_flags(neigh);
+	read_unlock_bh(&neigh->lock);
+
+	neigh_release(neigh);
+
+	r->arp_ha.sa_family = dev->type;
+	strscpy(r->arp_dev, dev->name, sizeof(r->arp_dev));
+
+	return 0;
 }
 
 int arp_invalidate(struct net_device *dev, __be32 ip, bool force)
-- 
2.30.2


