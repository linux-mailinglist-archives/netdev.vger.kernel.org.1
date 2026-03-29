Return-Path: <netdev+bounces-272878-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SItZKBUMyWkHtwUAu9opvQ
	(envelope-from <netdev+bounces-272878-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 29 Mar 2026 13:25:09 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 06541351CB2
	for <lists+netdev@lfdr.de>; Sun, 29 Mar 2026 13:25:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 65E42303E496
	for <lists+netdev@lfdr.de>; Sun, 29 Mar 2026 11:23:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 022D935F17A;
	Sun, 29 Mar 2026 11:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="AL42Lqzh"
X-Original-To: netdev@vger.kernel.org
Received: from out-185.mta0.migadu.com (out-185.mta0.migadu.com [91.218.175.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AD3E35C1AA
	for <netdev@vger.kernel.org>; Sun, 29 Mar 2026 11:23:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774783420; cv=none; b=jNIPvdlIB+e9bFXYTQdqDyc0oS5dqOIs5rlgqUTqF2Ev3ZB06t/FEsIYvw2meoNVjuDG1v1Sn+/Elptq9OU5TBVHLjy61KGteOGZwlIjZJJzb+6iLhrbtHU8d/2koddzXYvyR/VwtXj25yw3EULDNIXh//gFL38pwFzxhVNmLMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774783420; c=relaxed/simple;
	bh=PIuYIprfouppkQZ7QeNiFpoaRkQAOKuyzHEJqlLVsCQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uoRODl25n5au9GfAIZgIlz41vuMGloFP88fJ1QKmDIZx05suUKQjJeJWW65tgwGmqzf4TkNCdRUit6QCuJ9/kgu7wkvmBExHdq5mdb8gH+Qz7it7EESrsSwmlEhjnl5CpBbZAPy/qhJK4wmJQMHhS6OBZaN9Nx7/D5L3dJKJ5go=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=AL42Lqzh; arc=none smtp.client-ip=91.218.175.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1774783418;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KSHMJQQ8DMWFQEe3KshqgTve/RGG6/L+xVBKnqvidjI=;
	b=AL42LqzhKfMk6JkvEzGhY87/anTYEb48GDnPCxaRJD9M5BDLd82C/UbqYnsQ58sFhZR7dJ
	36v1JdeG5D1rwWHyhHPQISWjjI1x7XfowABoZGMsF95GVMLIkbXXfpPen6hMvQoGZVBvS5
	7fGQAaHdcZVmkgarNXAv7xRoT+iIR9U=
From: luka.gejak@linux.dev
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org
Cc: horms@kernel.org,
	fmaurer@redhat.com,
	liuhangbin@gmail.com,
	linux-kernel@vger.kernel.org,
	luka.gejak@linux.dev
Subject: [PATCH net-next v3 2/4] net: hsr: fix VLAN add unwind on slave errors
Date: Sun, 29 Mar 2026 13:23:11 +0200
Message-ID: <20260329112313.17164-3-luka.gejak@linux.dev>
In-Reply-To: <20260329112313.17164-1-luka.gejak@linux.dev>
References: <20260329112313.17164-1-luka.gejak@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,redhat.com,gmail.com,vger.kernel.org,linux.dev];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[linux.dev:+];
	TAGGED_FROM(0.00)[bounces-272878-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NO_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[luka.gejak@linux.dev,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux.dev:dkim,linux.dev:email,linux.dev:mid]
X-Rspamd-Queue-Id: 06541351CB2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Luka Gejak <luka.gejak@linux.dev>

When vlan_vid_add() fails for a secondary slave, the error path calls
vlan_vid_del() on the failing port instead of the peer slave that had
already succeeded. This results in asymmetric VLAN state across the HSR
pair.

Fix this by switching to a centralized unwind path that removes the VID
from any slave device that was already programmed.

Signed-off-by: Luka Gejak <luka.gejak@linux.dev>
---
 net/hsr/hsr_device.c | 32 +++++++++++++++++---------------
 1 file changed, 17 insertions(+), 15 deletions(-)

diff --git a/net/hsr/hsr_device.c b/net/hsr/hsr_device.c
index 5c3eca2235ce..8ee30fc32612 100644
--- a/net/hsr/hsr_device.c
+++ b/net/hsr/hsr_device.c
@@ -532,8 +532,8 @@ static void hsr_change_rx_flags(struct net_device *dev, int change)
 static int hsr_ndo_vlan_rx_add_vid(struct net_device *dev,
 				   __be16 proto, u16 vid)
 {
-	bool is_slave_a_added = false;
-	bool is_slave_b_added = false;
+	struct net_device *slave_a_dev = NULL;
+	struct net_device *slave_b_dev = NULL;
 	struct hsr_port *port;
 	struct hsr_priv *hsr;
 	int ret = 0;
@@ -549,33 +549,35 @@ static int hsr_ndo_vlan_rx_add_vid(struct net_device *dev,
 		switch (port->type) {
 		case HSR_PT_SLAVE_A:
 			if (ret) {
-				/* clean up Slave-B */
 				netdev_err(dev, "add vid failed for Slave-A\n");
-				if (is_slave_b_added)
-					vlan_vid_del(port->dev, proto, vid);
-				return ret;
+				goto unwind;
 			}
-
-			is_slave_a_added = true;
+			slave_a_dev = port->dev;
 			break;
-
 		case HSR_PT_SLAVE_B:
 			if (ret) {
-				/* clean up Slave-A */
 				netdev_err(dev, "add vid failed for Slave-B\n");
-				if (is_slave_a_added)
-					vlan_vid_del(port->dev, proto, vid);
-				return ret;
+				goto unwind;
 			}
-
-			is_slave_b_added = true;
+			slave_b_dev = port->dev;
 			break;
 		default:
+			if (ret)
+				goto unwind;
 			break;
 		}
 	}
 
 	return 0;
+
+unwind:
+	if (slave_a_dev)
+		vlan_vid_del(slave_a_dev, proto, vid);
+
+	if (slave_b_dev)
+		vlan_vid_del(slave_b_dev, proto, vid);
+
+	return ret;
 }
 
 static int hsr_ndo_vlan_rx_kill_vid(struct net_device *dev,
-- 
2.53.0


