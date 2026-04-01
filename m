Return-Path: <netdev+bounces-274005-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6N65JPnmzGk/XwYAu9opvQ
	(envelope-from <netdev+bounces-274005-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 01 Apr 2026 11:35:53 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id EB3CC377C03
	for <lists+netdev@lfdr.de>; Wed, 01 Apr 2026 11:35:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B9F393103FE0
	for <lists+netdev@lfdr.de>; Wed,  1 Apr 2026 09:23:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7D423CF679;
	Wed,  1 Apr 2026 09:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="iXYM6iFl"
X-Original-To: netdev@vger.kernel.org
Received: from out-173.mta0.migadu.com (out-173.mta0.migadu.com [91.218.175.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 248AC3CEBA9
	for <netdev@vger.kernel.org>; Wed,  1 Apr 2026 09:23:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775035397; cv=none; b=m2VPTREBzhuMQJhAZln1SDU/oDwaCojXxQfHNcrl6HMhKSHF7zxlv9b0KQlOvyqiM4gyHDTsRSjOmals+OkW94dpMTYOxCZ5TB1dT0S9wBdb3+zjJXF44NkpKVKVThSdrmYuIj4iJngtkCVjVy31D/3/Y/jHBrFA7E8YjQ4wfMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775035397; c=relaxed/simple;
	bh=t1Y/gHfQJL/gVsVXfl8JZO/kakKelJ8QyQ5MoB9sXYw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LDvRf8+8sNLNwBnUeSVUyn2CjSP1CGMa/rXB5O7fsnJf/WtdlG1Os3hbxmJV1H351UDzj8DFVh8UejGOBqgupA0WaRydOT/aTE2bwItPWBfAW3R0sf4zusu8rzZ46Bn8oDAQdpoFZ9DzHH5z/TO5HVQvDIeiCupIYGc1abJfUac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=iXYM6iFl; arc=none smtp.client-ip=91.218.175.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1775035394;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=q/+XkSjyDeCzx867EDSJ+ErRP7Kp2hPRuM05EkkxRf0=;
	b=iXYM6iFlaxuRyDFauarjMVAxIfu/zk9RUtzW3gBSh78d01+FU30DXSj1uaqu1YGSfh1vUh
	J8n1P3Pd/QAL+w91aSfW0jgnFHCASiJg9whi2MT7busXMP2GbM92vq/3OF9Wox9s/ioFWP
	8ki6Qt4VDQUzkS4EMmT4jZxZNnPm5pQ=
From: luka.gejak@linux.dev
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: netdev@vger.kernel.org,
	fmaurer@redhat.com,
	horms@kernel.org,
	bigeasy@linutronix.de,
	m-karicheri2@ti.com,
	luka.gejak@linux.dev
Subject: [PATCH net v4 2/2] net: hsr: fix VLAN add unwind on slave errors
Date: Wed,  1 Apr 2026 11:22:43 +0200
Message-ID: <20260401092243.52121-3-luka.gejak@linux.dev>
In-Reply-To: <20260401092243.52121-1-luka.gejak@linux.dev>
References: <20260401092243.52121-1-luka.gejak@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[linux.dev:+];
	TAGGED_FROM(0.00)[bounces-274005-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FROM_NO_DN(0.00)[];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[luka.gejak@linux.dev,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: EB3CC377C03
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Luka Gejak <luka.gejak@linux.dev>

When vlan_vid_add() fails for a secondary slave, the error path calls
vlan_vid_del() on the failing port instead of the peer slave that had
already succeeded. This results in asymmetric VLAN state across the HSR
pair.

Fix this by switching to a centralized unwind path that removes the VID
from any slave device that was already programmed.

Fixes: 1a8a63a5305e ("net: hsr: Add VLAN CTAG filter support")
Signed-off-by: Luka Gejak <luka.gejak@linux.dev>
---
 net/hsr/hsr_device.c | 32 +++++++++++++++++---------------
 1 file changed, 17 insertions(+), 15 deletions(-)

diff --git a/net/hsr/hsr_device.c b/net/hsr/hsr_device.c
index 90236028817d..5555b71ab19b 100644
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


