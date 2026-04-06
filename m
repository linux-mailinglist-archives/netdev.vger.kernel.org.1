Return-Path: <netdev+bounces-275557-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QL5rCX2M02nFiwcAu9opvQ
	(envelope-from <netdev+bounces-275557-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 06 Apr 2026 12:35:41 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D7253A2D96
	for <lists+netdev@lfdr.de>; Mon, 06 Apr 2026 12:35:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 92852301F4BB
	for <lists+netdev@lfdr.de>; Mon,  6 Apr 2026 10:34:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 156E232AAA8;
	Mon,  6 Apr 2026 10:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XVJ9imZf"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5AC23290DB;
	Mon,  6 Apr 2026 10:34:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775471697; cv=none; b=rIB/kjKAyhM/gfx+bUpNKZ1aGCOl0J+jvM4RGLhcdc8hZzx4AdKE4shlSIMfgMAS0lWsDX6TEkbKvGFo92UFPqUoJfde0+1R6Ofv65Ox1dg32NBySCi8NkUKvzHnoAuJ38JQ4ksk6Mhvu+sz03qL8lrYsIlCmw0kGsAGNOc3uac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775471697; c=relaxed/simple;
	bh=24QybONLSULPujbEyYxPmLfX9/i2FaVu9f7Sw/XmRpc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lfAJpRYBMMhyQnRXuX2G6aLxBQt2eAiE/VkLe10LxzujSpBKw2RAy7Vc6kJwe+uH0ICSp1LhT3ZYyd2KKvniLu5ksaFBL1lZVpfOA0A8AqdFZd6plnLdCb2xFhkDwFNTcQqBMg+ZJ8ovO+lfJ96qECwQm0hSW/CaXD0VI/mkvH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XVJ9imZf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30FF2C4CEF7;
	Mon,  6 Apr 2026 10:34:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775471696;
	bh=24QybONLSULPujbEyYxPmLfX9/i2FaVu9f7Sw/XmRpc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=XVJ9imZfjseY5hYJl/k7rGVmDibqUfi7NRNql+RUn4lqzo3zCmoOSMVDvvQxmXZsC
	 vvWmeD00rat6Culpxw9rUzBq3qQvf9rG5bhFOjf7FvNbCO98CQAop4ZydR7HQpeBa3
	 KCZHILWomCO3KIahICd7EH/iE49mzP+Cay0AahLmjOhtjndUv9QMjt1oQSfjC5sQou
	 xrzfL1F2RBnPYltdr3VXh1bhA+MetrkeQ5AmFaQjE6XH5Q+E7+H7XcinAUmRcAGtIG
	 BAhvktmWjMyliks1uXhycejaW3eAe8HI/U5gT3daqmqwYnWtJsfowOcA47p3u9bgai
	 TJUqfE/zjXajQ==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Mon, 06 Apr 2026 12:34:07 +0200
Subject: [PATCH net-next v3 02/12] net: airoha: Set PPE cpu port for GDM2
 if loopback is enabled
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260406-airoha-eth-multi-serdes-v3-2-ab6ea49d59ff@kernel.org>
References: <20260406-airoha-eth-multi-serdes-v3-0-ab6ea49d59ff@kernel.org>
In-Reply-To: <20260406-airoha-eth-multi-serdes-v3-0-ab6ea49d59ff@kernel.org>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Lorenzo Bianconi <lorenzo@kernel.org>
Cc: Christian Marangi <ansuelsmth@gmail.com>, 
 Benjamin Larsson <benjamin.larsson@genexis.eu>, 
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
 netdev@vger.kernel.org, devicetree@vger.kernel.org
X-Mailer: b4 0.14.3
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-275557-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,genexis.eu,lists.infradead.org,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lorenzo@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 7D7253A2D96
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Add missing PPE cpu port configuration for GDM2 if QoS loopback is enabled
for GDM3 or GDM4 ports. Similar to commit 'f44218cd5e6a ("net: airoha:
Reset PPE cpu port configuration in airoha_ppe_hw_init()"), this patch is
fixing an issue not visible to the user (so we do not need to backport it)
since airoha_eth driver currently supports just the internal phy available
via the MT7530 DSA switch and there are no WAN interfaces officially
supported since PCS/external phy is not merged mainline yet (it will be
posted with following patches).

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/ethernet/airoha/airoha_eth.c | 8 ++++++--
 drivers/net/ethernet/airoha/airoha_eth.h | 3 ++-
 drivers/net/ethernet/airoha/airoha_ppe.c | 6 +++---
 3 files changed, 11 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/airoha/airoha_eth.c b/drivers/net/ethernet/airoha/airoha_eth.c
index 8b070dadca11..4b5581596043 100644
--- a/drivers/net/ethernet/airoha/airoha_eth.c
+++ b/drivers/net/ethernet/airoha/airoha_eth.c
@@ -1730,7 +1730,7 @@ static int airoha_set_gdm2_loopback(struct airoha_gdm_port *port)
 {
 	struct airoha_eth *eth = port->qdma->eth;
 	u32 val, pse_port, chan, nbq;
-	int src_port;
+	int i, src_port;
 
 	/* Forward the traffic to the proper GDM port */
 	pse_port = port->id == AIROHA_GDM3_IDX ? FE_PSE_PORT_GDM3
@@ -1774,6 +1774,9 @@ static int airoha_set_gdm2_loopback(struct airoha_gdm_port *port)
 		      SP_CPORT_MASK(val),
 		      __field_prep(SP_CPORT_MASK(val), FE_PSE_PORT_CDM2));
 
+	for (i = 0; i < eth->soc->num_ppe; i++)
+		airoha_ppe_set_cpu_port(port, i, AIROHA_GDM2_IDX);
+
 	if (port->id == AIROHA_GDM4_IDX && airoha_is_7581(eth)) {
 		u32 mask = FC_ID_OF_SRC_PORT_MASK(nbq);
 
@@ -1812,7 +1815,8 @@ static int airoha_dev_init(struct net_device *dev)
 	}
 
 	for (i = 0; i < eth->soc->num_ppe; i++)
-		airoha_ppe_set_cpu_port(port, i);
+		airoha_ppe_set_cpu_port(port, i,
+					airoha_get_fe_port(port));
 
 	return 0;
 }
diff --git a/drivers/net/ethernet/airoha/airoha_eth.h b/drivers/net/ethernet/airoha/airoha_eth.h
index af29fc74165b..3088c24db26a 100644
--- a/drivers/net/ethernet/airoha/airoha_eth.h
+++ b/drivers/net/ethernet/airoha/airoha_eth.h
@@ -651,7 +651,8 @@ int airoha_get_fe_port(struct airoha_gdm_port *port);
 bool airoha_is_valid_gdm_port(struct airoha_eth *eth,
 			      struct airoha_gdm_port *port);
 
-void airoha_ppe_set_cpu_port(struct airoha_gdm_port *port, u8 ppe_id);
+void airoha_ppe_set_cpu_port(struct airoha_gdm_port *port, u8 ppe_id,
+			     u8 fport);
 bool airoha_ppe_is_enabled(struct airoha_eth *eth, int index);
 void airoha_ppe_check_skb(struct airoha_ppe_dev *dev, struct sk_buff *skb,
 			  u16 hash, bool rx_wlan);
diff --git a/drivers/net/ethernet/airoha/airoha_ppe.c b/drivers/net/ethernet/airoha/airoha_ppe.c
index c057bb2d105d..2e6391f9f24b 100644
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
@@ -174,7 +173,8 @@ static void airoha_ppe_hw_init(struct airoha_ppe *ppe)
 			if (!port)
 				continue;
 
-			airoha_ppe_set_cpu_port(port, i);
+			airoha_ppe_set_cpu_port(port, i,
+						airoha_get_fe_port(port));
 		}
 	}
 }

-- 
2.53.0


