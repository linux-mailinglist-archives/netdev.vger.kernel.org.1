Return-Path: <netdev+bounces-90255-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 28D938AD528
	for <lists+netdev@lfdr.de>; Mon, 22 Apr 2024 21:50:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5AB3D1C20EA7
	for <lists+netdev@lfdr.de>; Mon, 22 Apr 2024 19:49:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D9ED155345;
	Mon, 22 Apr 2024 19:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="ZlqiSMds"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-52005.amazon.com (smtp-fw-52005.amazon.com [52.119.213.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D39C26A03F
	for <netdev@vger.kernel.org>; Mon, 22 Apr 2024 19:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713815395; cv=none; b=Yoxvd5etZ/mV22oXHgGyXi5vwYmGs+WKOssOVPrLWvEtcKUVzJgCnxS0mDPoIJv7ony0fgr84xnwoWmExuKL0AjjIzZjxQduB6ojbNdy04GtEKYYP/UGsY2PHWuV/KlcvKMqrF4x7av1zF3OTBYY1Z9sbXdW4AkYrTSvgfKjXd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713815395; c=relaxed/simple;
	bh=TaUSGeX4ooF8apZeC63KXkYPPDwPtljgEbAp1vQ0Hkw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kVkhf8g9dOZiUW86q80oYpd3ppXg7eFv5A6u9uweDN9o2eS1NBM3IyFk/2Q4OfEOBFYHyMQWyYZ5frWVAR7lGAXD/XUlOOLB1CGq5sNK313zUZ/BdwvFW6uKELXQC3kpmdE8WM1SNxVmxD9xndcno2BXgLeOxq+I3HKBuX9kzVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=ZlqiSMds; arc=none smtp.client-ip=52.119.213.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1713815394; x=1745351394;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=RaF98YL7yXmFqXvONl7i4hefr/oT7ESfH7oYrt9h4FA=;
  b=ZlqiSMdsF6LGJWZtF5DqFCJXMLrL/LLrtTa/rwTNguJbZEyHouB4DM9v
   jKz+xnurndRAUV2yYfPr3EdufTVH9Vbo7pN5mm1qICXn6Id3dISWzpN+X
   BR/GmvShr1FmY+jutUT+jSVnN97wiCgSDD8IyzJkG4N5UhTzKPvXiz4pL
   s=;
X-IronPort-AV: E=Sophos;i="6.07,221,1708387200"; 
   d="scan'208";a="649559992"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-52005.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2024 19:49:52 +0000
Received: from EX19MTAUWC001.ant.amazon.com [10.0.38.20:60751]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.53.80:2525] with esmtp (Farcaster)
 id f08ce987-264d-47e3-a17d-e9ae06aa23c0; Mon, 22 Apr 2024 19:49:51 +0000 (UTC)
X-Farcaster-Flow-ID: f08ce987-264d-47e3-a17d-e9ae06aa23c0
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Mon, 22 Apr 2024 19:49:51 +0000
Received: from 88665a182662.ant.amazon.com (10.106.101.48) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.28;
 Mon, 22 Apr 2024 19:49:48 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, "Paolo
 Abeni" <pabeni@redhat.com>
CC: Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v1 net-next 4/6] arp: Remove a nest in arp_req_get().
Date: Mon, 22 Apr 2024 12:47:53 -0700
Message-ID: <20240422194755.4221-5-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240422194755.4221-1-kuniyu@amazon.com>
References: <20240422194755.4221-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D037UWC004.ant.amazon.com (10.13.139.254) To
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


