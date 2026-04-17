Return-Path: <netdev+bounces-279352-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aKE5ITtS4mnx4QAAu9opvQ
	(envelope-from <netdev+bounces-279352-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 17 Apr 2026 17:31:07 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D91E341CA12
	for <lists+netdev@lfdr.de>; Fri, 17 Apr 2026 17:31:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BAEB8302497C
	for <lists+netdev@lfdr.de>; Fri, 17 Apr 2026 15:25:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39FDC2E7179;
	Fri, 17 Apr 2026 15:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SMvjzMlj"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16B1C54654
	for <netdev@vger.kernel.org>; Fri, 17 Apr 2026 15:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776439520; cv=none; b=IJ9AZd3ZHXqaoirPjykn1ojapc7zSrSrixEjUZTBOLh7d2nGeVTCF8dBbutOsxfgmvbtrs/70uwUzOnjOta8Rl1mWUPzvU44QfbJUk5nAwJR9I6o25aw5/p/ZCPypU/vFhI0VY5WmGrzgVsn9BdqNRD9GNvD1kyGvrKcKJUDGjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776439520; c=relaxed/simple;
	bh=MoXDICb71/sK4BHUlXqttpDfMwpW49pJQj3fKijhdDA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=ViIST9V5gS1thdib1RVWJ/u/nTIeiW9jpUTYqyVyPW9PZtJj8ugziv5J+RcKKHSNzgQ2+RONKNhWcJ4mHbeSJRgtc9ZqZ1iPujkKIq/n75NDL4vavDJnUN7S/colIBra7wfEtp/IAIwPxIgUX02naqLt4Sod1ZVHw9T02lEPl5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SMvjzMlj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27025C19425;
	Fri, 17 Apr 2026 15:25:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776439519;
	bh=MoXDICb71/sK4BHUlXqttpDfMwpW49pJQj3fKijhdDA=;
	h=From:Date:Subject:To:Cc:From;
	b=SMvjzMljAZHauG6gD0bNqhWYyjuipEdsveuZypTmI1dB586xX3HPhKbRGExqAPnjg
	 L2eDN+HgK4QL40hNV4HtfgrhHUPxxBTmbBx8DkQuBbvox6JYfVjVEQ2GCHxRSF5Fr2
	 Wb5MGyM48jRrLEBquhS5lPSNTaLdwg9AU0+9dAAfWbByfKfefKQcNy7IGzEOXD7U6M
	 IB41S0mMZFiu4vxHqPTv1uSrc+LNEKgwIIGeNP9IxC94fAdzwbPUOuciqJZ8bu+ALw
	 ZE575ZLkwfNdzg2qYGkrnKapWAsP0pir1swtq4RFLzhQ+v4ntTAeXLlFKQ2eUT1UMM
	 Xa/4lVdPNTegQ==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Fri, 17 Apr 2026 17:24:41 +0200
Subject: [PATCH net] net: airoha: Fix PPE cpu port configuration for GDM2
 loopback path
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260417-airoha-ppe-cpu-port-for-gdm2-loopback-v1-1-c7a9de0f6f57@kernel.org>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x3NwQrCMAyA4VcZORtYi27UVxEPbZdtQW1COkUYe
 3eLx+/y/ztUMqYK124How9XltLgTh3kNZaFkKdm8L0f+rMbMbLJGlGVMOsbVWzDWQyX6eXxKaI
 p5geGIYV08W4M2UFrqdHM3//nBoU2uB/HDzmgfZB8AAAA
X-Change-ID: 20260417-airoha-ppe-cpu-port-for-gdm2-loopback-96b9b52179c1
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Lorenzo Bianconi <lorenzo@kernel.org>
Cc: Simon Horman <horms@kernel.org>, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, netdev@vger.kernel.org
X-Mailer: b4 0.14.3
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-279352-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lorenzo@kernel.org,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D91E341CA12
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

When QoS loopback is enabled for GDM3 or GDM4, incoming packets are
forwarded to GDM2. However, the PPE cpu port for GDM2 is not configured
in this path, causing traffic originating from GDM3/GDM4, which may
be set up as WAN ports backed by QDMA1, to be incorrectly directed
to QDMA0 instead.
Configure the PPE cpu port for GDM2 when QoS loopback is active on
GDM3 or GDM4 to ensure traffic is routed to the correct QDMA instance.

Fixes: 9cd451d414f6 ("net: airoha: Add loopback support for GDM2")
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/ethernet/airoha/airoha_eth.c | 8 ++++++--
 drivers/net/ethernet/airoha/airoha_eth.h | 3 ++-
 drivers/net/ethernet/airoha/airoha_ppe.c | 6 +++---
 3 files changed, 11 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/airoha/airoha_eth.c b/drivers/net/ethernet/airoha/airoha_eth.c
index e1ab15f1ee7d..d2b7c437a782 100644
--- a/drivers/net/ethernet/airoha/airoha_eth.c
+++ b/drivers/net/ethernet/airoha/airoha_eth.c
@@ -1727,7 +1727,7 @@ static int airoha_set_gdm2_loopback(struct airoha_gdm_port *port)
 {
 	struct airoha_eth *eth = port->qdma->eth;
 	u32 val, pse_port, chan;
-	int src_port;
+	int i, src_port;
 
 	/* Forward the traffic to the proper GDM port */
 	pse_port = port->id == AIROHA_GDM3_IDX ? FE_PSE_PORT_GDM3
@@ -1769,6 +1769,9 @@ static int airoha_set_gdm2_loopback(struct airoha_gdm_port *port)
 		      SP_CPORT_MASK(val),
 		      __field_prep(SP_CPORT_MASK(val), FE_PSE_PORT_CDM2));
 
+	for (i = 0; i < eth->soc->num_ppe; i++)
+		airoha_ppe_set_cpu_port(port, i, AIROHA_GDM2_IDX);
+
 	if (port->id == AIROHA_GDM4_IDX && airoha_is_7581(eth)) {
 		u32 mask = FC_ID_OF_SRC_PORT_MASK(port->nbq);
 
@@ -1807,7 +1810,8 @@ static int airoha_dev_init(struct net_device *dev)
 	}
 
 	for (i = 0; i < eth->soc->num_ppe; i++)
-		airoha_ppe_set_cpu_port(port, i);
+		airoha_ppe_set_cpu_port(port, i,
+					airoha_get_fe_port(port));
 
 	return 0;
 }
diff --git a/drivers/net/ethernet/airoha/airoha_eth.h b/drivers/net/ethernet/airoha/airoha_eth.h
index 95e557638617..715aa26cbac8 100644
--- a/drivers/net/ethernet/airoha/airoha_eth.h
+++ b/drivers/net/ethernet/airoha/airoha_eth.h
@@ -653,7 +653,8 @@ int airoha_get_fe_port(struct airoha_gdm_port *port);
 bool airoha_is_valid_gdm_port(struct airoha_eth *eth,
 			      struct airoha_gdm_port *port);
 
-void airoha_ppe_set_cpu_port(struct airoha_gdm_port *port, u8 ppe_id);
+void airoha_ppe_set_cpu_port(struct airoha_gdm_port *port, u8 ppe_id,
+			     u8 fport);
 bool airoha_ppe_is_enabled(struct airoha_eth *eth, int index);
 void airoha_ppe_check_skb(struct airoha_ppe_dev *dev, struct sk_buff *skb,
 			  u16 hash, bool rx_wlan);
diff --git a/drivers/net/ethernet/airoha/airoha_ppe.c b/drivers/net/ethernet/airoha/airoha_ppe.c
index 859818676b69..5c9dff6bccd1 100644
--- a/drivers/net/ethernet/airoha/airoha_ppe.c
+++ b/drivers/net/ethernet/airoha/airoha_ppe.c
@@ -85,10 +85,9 @@ static u32 airoha_ppe_get_timestamp(struct airoha_ppe *ppe)
 	return FIELD_GET(AIROHA_FOE_IB1_BIND_TIMESTAMP, timestamp);
 }
 
-void airoha_ppe_set_cpu_port(struct airoha_gdm_port *port, u8 ppe_id)
+void airoha_ppe_set_cpu_port(struct airoha_gdm_port *port, u8 ppe_id, u8 fport)
 {
 	struct airoha_qdma *qdma = port->qdma;
-	u8 fport = airoha_get_fe_port(port);
 	struct airoha_eth *eth = qdma->eth;
 	u8 qdma_id = qdma - &eth->qdma[0];
 	u32 fe_cpu_port;
@@ -182,7 +181,8 @@ static void airoha_ppe_hw_init(struct airoha_ppe *ppe)
 			if (!port)
 				continue;
 
-			airoha_ppe_set_cpu_port(port, i);
+			airoha_ppe_set_cpu_port(port, i,
+						airoha_get_fe_port(port));
 		}
 	}
 }

---
base-commit: 82c21069028c5db3463f851ae8ac9cc2e38a3827
change-id: 20260417-airoha-ppe-cpu-port-for-gdm2-loopback-96b9b52179c1

Best regards,
-- 
Lorenzo Bianconi <lorenzo@kernel.org>


