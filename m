Return-Path: <netdev+bounces-264838-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YEbeJYXuqmmOYAEAu9opvQ
	(envelope-from <netdev+bounces-264838-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 06 Mar 2026 16:11:01 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0164A223867
	for <lists+netdev@lfdr.de>; Fri, 06 Mar 2026 16:11:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EE79C3006161
	for <lists+netdev@lfdr.de>; Fri,  6 Mar 2026 15:10:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5575A3AE71E;
	Fri,  6 Mar 2026 15:10:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DhzpAi3C"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A986387582
	for <netdev@vger.kernel.org>; Fri,  6 Mar 2026 15:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772809800; cv=none; b=EB+ojN/qgPe+HAB2qAsIGgkjFmn8W0t1NWNcXZVAyIuEITbKB1OI7cuEfsS0Likv1bc/7vwR77ZNQdO5HJnyijsPIbFG54SaT9jRne6/pndO/91YX/hYFlbUaRyHQ+C8Aozr6PPgHjVPb2jzr4EJc82j2q53Rw/U+IueevcNc/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772809800; c=relaxed/simple;
	bh=GgoUw+SaJyllGA06GAIgRiDqdGje3nKOsdp/CsOdWJ8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=QIKYebfivOnQDJUiie+Et0ybhuYOZ3r3lF8a7ZoDe1MoWo6M24DCnuNskqog0fPRA2q6bKmLfDYbCsE+hH1IZGZ00JbyNkmkzhPUhj5IBHi40x5YCbXk52dAm4jyU86wx0Lm8XlNscMrBru31IIfFVgtLKlEBr8yQ3iV/oklBP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DhzpAi3C; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE34BC4CEF7;
	Fri,  6 Mar 2026 15:09:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772809799;
	bh=GgoUw+SaJyllGA06GAIgRiDqdGje3nKOsdp/CsOdWJ8=;
	h=From:Date:Subject:To:Cc:From;
	b=DhzpAi3CoQh5QBzl/i/d0ZlPOmhmHdma6wDPKGaWVNqfKRIVkL/nQpuZXxFM7DYju
	 B6k33hBk3hwbOZiriTqAyAHNCWdvSyPrFH69MWcRZXxAkYWhaipgPU/1ysgvTlTeST
	 rWBcrdQAWyY4FVuzdWzoPbxqj3Pmr9QnLMbnnPEgNBZFMJ7abAx/1B4AGj/hMYLA3K
	 IxSt4T0GX6guNElx5WFN5Y9i6ojmdOR234wh7H7/LzsqANrd8NUxa+CmOyD27OAVw5
	 holmPDga0xVcX92eMoPbZL4DEh08kbdDbiZSK90a5zcxdSwTkN0cIu3m3wU1JwYFk/
	 4weKS5/UeLGYg==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Fri, 06 Mar 2026 16:09:47 +0100
Subject: [PATCH net-next] net: airoha: Move GDM forward port configuration
 in ndo_open/ndo_stop callbacks
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260306-airoha-gdm-forward-ndo-open-stop-v1-1-7b7a20dd9ef0@kernel.org>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x3NwQqDMAyA4VeRnBdoLbixVxkegomaw5qSDieI7
 27x+F3+/4AqrlLh3R3gsmlVyw3x0cG0Ul4ElZuhD/0QUhiQ1G0lXPiLs/mfnDGzoRXJWH9WMKY
 UJ4r8TPyClikus+734jOe5wVqSMRUcgAAAA==
X-Change-ID: 20260306-airoha-gdm-forward-ndo-open-stop-1331ca1d73d8
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, netdev@vger.kernel.org, 
 Lorenzo Bianconi <lorenzo@kernel.org>
X-Mailer: b4 0.14.2
X-Rspamd-Queue-Id: 0164A223867
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-264838-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.970];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lorenzo@kernel.org,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

This change allows to set GDM forward port configuration to
FE_PSE_PORT_DROP stopping the network device. Hw design requires to stop
packet forwarding putting the interface down.  Moreover, PPE firmware
requires to use PPE1 for GDM3 or GDM4.

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/ethernet/airoha/airoha_eth.c | 20 +++++++++++++++-----
 1 file changed, 15 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/airoha/airoha_eth.c b/drivers/net/ethernet/airoha/airoha_eth.c
index 09acbe6695368132ddd92c3501f8711476db73f6..dc36b5b669108cc32c4fd5a5479d9024978ceeba 100644
--- a/drivers/net/ethernet/airoha/airoha_eth.c
+++ b/drivers/net/ethernet/airoha/airoha_eth.c
@@ -1611,6 +1611,7 @@ static int airoha_dev_open(struct net_device *dev)
 	int err, len = ETH_HLEN + dev->mtu + ETH_FCS_LEN;
 	struct airoha_gdm_port *port = netdev_priv(dev);
 	struct airoha_qdma *qdma = port->qdma;
+	u32 pse_port = FE_PSE_PORT_PPE1;
 
 	netif_tx_start_all_queues(dev);
 	err = airoha_set_vip_for_gdm_port(port, true);
@@ -1634,6 +1635,14 @@ static int airoha_dev_open(struct net_device *dev)
 			GLOBAL_CFG_RX_DMA_EN_MASK);
 	atomic_inc(&qdma->users);
 
+	if (port->id == AIROHA_GDM2_IDX &&
+	    airoha_ppe_is_enabled(qdma->eth, 1)) {
+		/* For PPE2 always use secondary cpu port. */
+		pse_port = FE_PSE_PORT_PPE2;
+	}
+	airoha_set_gdm_port_fwd_cfg(qdma->eth, REG_GDM_FWD_CFG(port->id),
+				    pse_port);
+
 	return 0;
 }
 
@@ -1651,6 +1660,9 @@ static int airoha_dev_stop(struct net_device *dev)
 	for (i = 0; i < ARRAY_SIZE(qdma->q_tx); i++)
 		netdev_tx_reset_subqueue(dev, i);
 
+	airoha_set_gdm_port_fwd_cfg(qdma->eth, REG_GDM_FWD_CFG(port->id),
+				    FE_PSE_PORT_DROP);
+
 	if (atomic_dec_and_test(&qdma->users)) {
 		airoha_qdma_clear(qdma, REG_QDMA_GLOBAL_CFG,
 				  GLOBAL_CFG_TX_DMA_EN_MASK |
@@ -1742,7 +1754,7 @@ static int airoha_dev_init(struct net_device *dev)
 	struct airoha_gdm_port *port = netdev_priv(dev);
 	struct airoha_qdma *qdma = port->qdma;
 	struct airoha_eth *eth = qdma->eth;
-	u32 pse_port, fe_cpu_port;
+	u32 fe_cpu_port;
 	u8 ppe_id;
 
 	airoha_set_macaddr(port, dev->dev_addr);
@@ -1763,7 +1775,7 @@ static int airoha_dev_init(struct net_device *dev)
 		if (airoha_ppe_is_enabled(eth, 1)) {
 			/* For PPE2 always use secondary cpu port. */
 			fe_cpu_port = FE_PSE_PORT_CDM2;
-			pse_port = FE_PSE_PORT_PPE2;
+			ppe_id = 1;
 			break;
 		}
 		fallthrough;
@@ -1772,13 +1784,11 @@ static int airoha_dev_init(struct net_device *dev)
 
 		/* For PPE1 select cpu port according to the running QDMA. */
 		fe_cpu_port = qdma_id ? FE_PSE_PORT_CDM2 : FE_PSE_PORT_CDM1;
-		pse_port = FE_PSE_PORT_PPE1;
+		ppe_id = 0;
 		break;
 	}
 	}
 
-	airoha_set_gdm_port_fwd_cfg(eth, REG_GDM_FWD_CFG(port->id), pse_port);
-	ppe_id = pse_port == FE_PSE_PORT_PPE2 ? 1 : 0;
 	airoha_fe_rmw(eth, REG_PPE_DFT_CPORT0(ppe_id),
 		      DFT_CPORT_MASK(port->id),
 		      __field_prep(DFT_CPORT_MASK(port->id), fe_cpu_port));

---
base-commit: e5e09233e8a9179b260460fdb28df5c24bcfbed6
change-id: 20260306-airoha-gdm-forward-ndo-open-stop-1331ca1d73d8

Best regards,
-- 
Lorenzo Bianconi <lorenzo@kernel.org>


