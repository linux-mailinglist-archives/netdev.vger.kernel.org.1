Return-Path: <netdev+bounces-249145-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F3BC8D14CD0
	for <lists+netdev@lfdr.de>; Mon, 12 Jan 2026 19:50:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 133133030DAB
	for <lists+netdev@lfdr.de>; Mon, 12 Jan 2026 18:50:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61D6F3876B6;
	Mon, 12 Jan 2026 18:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="aaUA9cZL"
X-Original-To: netdev@vger.kernel.org
Received: from pdx-out-004.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-004.esa.us-west-2.outbound.mail-perimeter.amazon.com [44.246.77.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04D693644A6;
	Mon, 12 Jan 2026 18:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.246.77.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768243815; cv=none; b=GXdu+i2LnSbpdoGp3rBji/iQ08LJMRt2+uyM/hOBr/l6Lez3hkZAC9wPJV/bwC6KZxc6BdEGurX5FoAZnermaH25+Afq+eADABY34irMNAXUmyGLWJmPPOjinSe2pl57y/EcJwPLXOUjHBlxdu9aD3UrPjo6QWBasIuPOLXeuNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768243815; c=relaxed/simple;
	bh=hoeyanFD67Gn9QgVPg3/WKobyyzvUg4XbODyyiJwD+Q=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=goEasCPBnn2JCwOo3TRe8z+3EpObJ2q7f2npMVOVTr8cxJTmyLlcqg4vPr9lTleopShBbbBHrcpDusF0l1SlD045ISqLLgikD7s4YOQmIJ464dkLZMlPHY8ALX0cFpV7+V30E3i9WcajzafFRSGK3bKbxKFDHXNMGyfJ4GAUoCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=aaUA9cZL; arc=none smtp.client-ip=44.246.77.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1768243814; x=1799779814;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=1K5Y+hxBOTbG7ruApMOFPS81Xi1nLyq3WDy/akXn3N0=;
  b=aaUA9cZL2rWK8iPFEr8+XoXltxXJU2zPCIDsrwYdYQBuWIOt12iX+Wn1
   TJV362gu3zLh0xFJ5yETO8RcW8wzg++8F74zz50FYzIbbZZNAJ5DTTckh
   tHenldi+/AhLE678XSc75zbVnuexTxVtPoQOflhlvdeTsdCLlg0iaY1kC
   h2s1CQj2B/vY5NId8eJUWUvtRDgV6TdQFbcftQ8jjcJ1oxrCtbKNMxuNE
   INYyaF99XKe3IpzUYWgJIuUWFOSQaur9wlEqmQ0RJ7TPGTXDKKoB2YNG2
   CypQDnvQDiq8A4nIbrE7h/Itso7HoPiRQiXxkckziPXtSAISvei/ScOSD
   Q==;
X-CSE-ConnectionGUID: vS+H+YtGRC65O+GzQgop1g==
X-CSE-MsgGUID: VpfwQeEpQqqD///6sWK95Q==
X-IronPort-AV: E=Sophos;i="6.21,221,1763424000"; 
   d="scan'208";a="10696486"
Received: from ip-10-5-6-203.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.6.203])
  by internal-pdx-out-004.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2026 18:50:13 +0000
Received: from EX19MTAUWC002.ant.amazon.com [205.251.233.51:28132]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.46.98:2525] with esmtp (Farcaster)
 id d3b36e82-fc93-49be-9840-e66b3afd3f0c; Mon, 12 Jan 2026 18:50:13 +0000 (UTC)
X-Farcaster-Flow-ID: d3b36e82-fc93-49be-9840-e66b3afd3f0c
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.35;
 Mon, 12 Jan 2026 18:50:13 +0000
Received: from dev-dsk-wanjay-2c-d25651b4.us-west-2.amazon.com (172.19.198.4)
 by EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.35;
 Mon, 12 Jan 2026 18:50:12 +0000
From: Jay Wang <wanjay@amazon.com>
To: <davem@davemloft.net>, <dsahern@kernel.org>
CC: <edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<horms@kernel.org>, <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<wanjay@amazon.com>, <syzbot+58b44a770a1585795351@syzkaller.appspotmail.com>
Subject: [PATCH 6.12] arp: do not assume dev_hard_header() does not change skb->head
Date: Mon, 12 Jan 2026 18:50:09 +0000
Message-ID: <20260112185009.28063-1-wanjay@amazon.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D035UWA003.ant.amazon.com (10.13.139.86) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)

From: Eric Dumazet <edumazet@google.com>

arp_create() is the only dev_hard_header() caller
making assumption about skb->head being unchanged.

A recent commit broke this assumption.

Initialize @arp pointer after dev_hard_header() call.

Fixes: db5b4e39c4e6 ("ip6_gre: make ip6gre_header() robust")
Reported-by: syzbot+58b44a770a1585795351@syzkaller.appspotmail.com
Signed-off-by: Eric Dumazet <edumazet@google.com>
Link: https://patch.msgid.link/20260107212250.384552-1-edumazet@google.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Jay Wang <wanjay@amazon.com>
---
 net/ipv4/arp.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/net/ipv4/arp.c b/net/ipv4/arp.c
index 8fb48f42581c..7822b2144514 100644
--- a/net/ipv4/arp.c
+++ b/net/ipv4/arp.c
@@ -564,7 +564,7 @@ struct sk_buff *arp_create(int type, int ptype, __be32 dest_ip,
 
 	skb_reserve(skb, hlen);
 	skb_reset_network_header(skb);
-	arp = skb_put(skb, arp_hdr_len(dev));
+	skb_put(skb, arp_hdr_len(dev));
 	skb->dev = dev;
 	skb->protocol = htons(ETH_P_ARP);
 	if (!src_hw)
@@ -572,12 +572,13 @@ struct sk_buff *arp_create(int type, int ptype, __be32 dest_ip,
 	if (!dest_hw)
 		dest_hw = dev->broadcast;
 
-	/*
-	 *	Fill the device header for the ARP frame
+	/* Fill the device header for the ARP frame.
+	 * Note: skb->head can be changed.
 	 */
 	if (dev_hard_header(skb, dev, ptype, dest_hw, src_hw, skb->len) < 0)
 		goto out;
 
+	arp = arp_hdr(skb);
 	/*
 	 * Fill out the arp protocol part.
 	 *
-- 
2.47.3


