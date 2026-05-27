Return-Path: <netdev+bounces-292247-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gJhaLdvFFmrOqgcAu9opvQ
	(envelope-from <netdev+bounces-292247-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 12:22:19 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id C0A085E28EE
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 12:22:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C4B74301156D
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 10:21:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64A443F0A82;
	Wed, 27 May 2026 10:21:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mBs1NFdw"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57B6B35A3B9
	for <netdev@vger.kernel.org>; Wed, 27 May 2026 10:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779877303; cv=none; b=MZbbpR8i6FSyLEJa9OCGmc/ko1ZbMDX2Gn91cCu02sNno3zdFrFjFPZ81V0DRR9QQWcRLfiI6RoWGvhqDejJBID9iCtFEqkNs1EjJrwQwJoxdIupnB47q7eKo1tMmOZET42qNwhh8u5G1MBCuBSQ//AJlsXBSCNaQFLfZ4Ye0oo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779877303; c=relaxed/simple;
	bh=jmXChBm15sIk6lWaDlxy/dlhoczSudP5oau2e//KpKc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lWBy6zjfsoQmgSsXT7O4JAMPoCQRM87wCp7SPiAglFbrdTCITD5CQzQt1+OrzqXrY90SdRbKOSqK0aZln9Oj43iJFFDRGbOSS8ndt3awssBzMyYYMafc0dbolxLSDHlKmgOhWYm4YdA4gNXhEzebHy/zr/QxrUOLtIusk9kM2BA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mBs1NFdw; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0597A1F00A3C;
	Wed, 27 May 2026 10:21:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779877300;
	bh=t/8CwcDZFs8+cMwpIimg7kxPDoaXVY8yIV3pb6+2jmM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=mBs1NFdwhE+HCwep/A8cHnGf6rS3QUCR2xcDgFCTz6w7SAkY2MofiNEXCMeH59qsn
	 ywcgRyKqC0LvlsWPalinv9X/fVXVwUQ1WYQm15zH+zQWzu4M/J7sN2+pxL3Rv+GHjD
	 0/zEHQe5zAHxnZOyr2nV/gcEiPEGajQlD7vXXqXhsMBBQWRQFOndJXLknv+1BUBSxz
	 J0v/MBulUuz7KLXBDyvTdKlgvbMXff6KC68rfYAY6h0b9bINO1id4+zBqYGSpFMZwz
	 /9zanUNKWWHlZTrON1935aFWbJ7bigkuphmZS0X8auke+zSYNLdg8DEWTO8LxSsjMu
	 MP6bGYl5SQ6eQ==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Wed, 27 May 2026 12:21:17 +0200
Subject: [PATCH net-next 3/6] net: airoha: Rely on airoha_gdm_dev pointer
 in airoha_is_lan_gdm_port()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260527-airoha-eth-multi-serdes-preliminary-v1-3-ec6ed73ef7fc@kernel.org>
References: <20260527-airoha-eth-multi-serdes-preliminary-v1-0-ec6ed73ef7fc@kernel.org>
In-Reply-To: <20260527-airoha-eth-multi-serdes-preliminary-v1-0-ec6ed73ef7fc@kernel.org>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, netdev@vger.kernel.org, 
 Xuegang Lu <xuegang.lu@airoha.com>, Lorenzo Bianconi <lorenzo@kernel.org>
X-Mailer: b4 0.14.3
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-292247-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lorenzo@kernel.org,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[airoha.com:email,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Queue-Id: C0A085E28EE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Rename airoha_is_lan_gdm_port in airoha_is_lan_gdm_dev. Moreover, rely
on airoha_gdm_dev pointer in airoha_is_lan_gdm_dev() instead of
airoha_gdm_port one.
This is a preliminary patch to support multiple net_devices connected to
the same GDM{3,4} port via an external hw arbiter.

Tested-by: Xuegang Lu <xuegang.lu@airoha.com>
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/ethernet/airoha/airoha_eth.c | 6 ++----
 drivers/net/ethernet/airoha/airoha_eth.h | 4 +++-
 drivers/net/ethernet/airoha/airoha_ppe.c | 2 +-
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/airoha/airoha_eth.c b/drivers/net/ethernet/airoha/airoha_eth.c
index 0f37d26e4d52..c5d25f7640ac 100644
--- a/drivers/net/ethernet/airoha/airoha_eth.c
+++ b/drivers/net/ethernet/airoha/airoha_eth.c
@@ -73,12 +73,10 @@ static void airoha_qdma_irq_disable(struct airoha_irq_bank *irq_bank,
 
 static void airoha_set_macaddr(struct airoha_gdm_dev *dev, const u8 *addr)
 {
-	struct airoha_gdm_port *port = dev->port;
 	struct airoha_eth *eth = dev->eth;
 	u32 val, reg;
 
-	reg = airoha_is_lan_gdm_port(port) ? REG_FE_LAN_MAC_H
-					   : REG_FE_WAN_MAC_H;
+	reg = airoha_is_lan_gdm_dev(dev) ? REG_FE_LAN_MAC_H : REG_FE_WAN_MAC_H;
 	val = (addr[0] << 16) | (addr[1] << 8) | addr[2];
 	airoha_fe_wr(eth, reg, val);
 
@@ -1868,7 +1866,7 @@ static int airoha_dev_init(struct net_device *netdev)
 	int i;
 
 	/* QDMA0 is used for lan ports while QDMA1 is used for WAN ports */
-	dev->qdma = &eth->qdma[!airoha_is_lan_gdm_port(port)];
+	dev->qdma = &eth->qdma[!airoha_is_lan_gdm_dev(dev)];
 	dev->dev->irq = dev->qdma->irq_banks[0].irq;
 	airoha_set_macaddr(dev, netdev->dev_addr);
 
diff --git a/drivers/net/ethernet/airoha/airoha_eth.h b/drivers/net/ethernet/airoha/airoha_eth.h
index f1eea492217c..f6f59d25abd9 100644
--- a/drivers/net/ethernet/airoha/airoha_eth.h
+++ b/drivers/net/ethernet/airoha/airoha_eth.h
@@ -647,8 +647,10 @@ static inline u16 airoha_qdma_get_txq(struct airoha_qdma *qdma, u16 qid)
 	return qid % ARRAY_SIZE(qdma->q_tx);
 }
 
-static inline bool airoha_is_lan_gdm_port(struct airoha_gdm_port *port)
+static inline bool airoha_is_lan_gdm_dev(struct airoha_gdm_dev *dev)
 {
+	struct airoha_gdm_port *port = dev->port;
+
 	/* GDM1 port on EN7581 SoC is connected to the lan dsa switch.
 	 * GDM{2,3,4} can be used as wan port connected to an external
 	 * phy module.
diff --git a/drivers/net/ethernet/airoha/airoha_ppe.c b/drivers/net/ethernet/airoha/airoha_ppe.c
index 22f5f1bae730..047141b2d6d8 100644
--- a/drivers/net/ethernet/airoha/airoha_ppe.c
+++ b/drivers/net/ethernet/airoha/airoha_ppe.c
@@ -362,7 +362,7 @@ static int airoha_ppe_foe_entry_prepare(struct airoha_eth *eth,
 			/* For downlink traffic consume SRAM memory for hw
 			 * forwarding descriptors queue.
 			 */
-			if (airoha_is_lan_gdm_port(port))
+			if (airoha_is_lan_gdm_dev(dev))
 				val |= AIROHA_FOE_IB2_FAST_PATH;
 			if (dsa_port >= 0)
 				val |= FIELD_PREP(AIROHA_FOE_IB2_NBQ,

-- 
2.54.0


