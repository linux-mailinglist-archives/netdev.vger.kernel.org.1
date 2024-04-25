Return-Path: <netdev+bounces-91399-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E95C8B2714
	for <lists+netdev@lfdr.de>; Thu, 25 Apr 2024 19:02:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 09F372826D2
	for <lists+netdev@lfdr.de>; Thu, 25 Apr 2024 17:02:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5B7414A4F3;
	Thu, 25 Apr 2024 17:02:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="njwtYdRH"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-52003.amazon.com (smtp-fw-52003.amazon.com [52.119.213.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 158B8131736
	for <netdev@vger.kernel.org>; Thu, 25 Apr 2024 17:02:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714064530; cv=none; b=d9PurkPPXWsqqDXV68Tdk5P+b297n+1QddasTx9lTraI6uWH0giNunnqjnDsMEWavdYP7Zw9zjbQRUvBR5yQMT2sY/Oyy4Tso2V6Ov/byEwiWAKs9W094yeB+Iy3JeKwSGTTNNrdFmUTlIcBEkGQIAzPmPw4wIci6yNiQPbtjZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714064530; c=relaxed/simple;
	bh=TaUSGeX4ooF8apZeC63KXkYPPDwPtljgEbAp1vQ0Hkw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ewbb1u92VfN9Gg20Kn9ibXWixRuNOlbz3vmDNPV/8e4YSUiQ+3FgvN0Ag1Z3owOX+a4iPWQliY6rTKu7eS0NI7Qf3fQgdxnI9VEaWeupduwq226Shxx6kzHjxP8M0uVpHr6oqic5MUf95W9/ff5xKHE8wvBzYF3McDRnoFoWdu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=njwtYdRH; arc=none smtp.client-ip=52.119.213.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1714064530; x=1745600530;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=RaF98YL7yXmFqXvONl7i4hefr/oT7ESfH7oYrt9h4FA=;
  b=njwtYdRHQCoTmls8A0mR9fDKe1ptNrGzAPuHj8bOztqme83RYBup1N/K
   klrvysKzrc8vxbEL3TYZ6g/PfbLuiuC1+hJrMHlzcXwb/g6GQwmuGWNxm
   hxd2/sjRPo4WcSCO2hOx1FmVipKmo/UsPBglzHBPckmmM75tEUc5oRHCe
   o=;
X-IronPort-AV: E=Sophos;i="6.07,230,1708387200"; 
   d="scan'208";a="654696645"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-52003.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Apr 2024 17:01:59 +0000
Received: from EX19MTAUWB002.ant.amazon.com [10.0.21.151:31310]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.63.59:2525] with esmtp (Farcaster)
 id 42cfbab3-71ac-49a1-a4a4-c9310c587544; Thu, 25 Apr 2024 17:01:58 +0000 (UTC)
X-Farcaster-Flow-ID: 42cfbab3-71ac-49a1-a4a4-c9310c587544
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Thu, 25 Apr 2024 17:01:58 +0000
Received: from 88665a182662.ant.amazon.com (10.106.101.18) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.28;
 Thu, 25 Apr 2024 17:01:55 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, "Paolo
 Abeni" <pabeni@redhat.com>
CC: Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v2 net-next 4/6] arp: Remove a nest in arp_req_get().
Date: Thu, 25 Apr 2024 10:00:00 -0700
Message-ID: <20240425170002.68160-5-kuniyu@amazon.com>
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
X-ClientProxiedBy: EX19D036UWC004.ant.amazon.com (10.13.139.205) To
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


