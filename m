Return-Path: <netdev+bounces-286178-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OOOiAGgx/2lb3QAAu9opvQ
	(envelope-from <netdev+bounces-286178-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 09 May 2026 15:06:48 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AD9F24FFBDE
	for <lists+netdev@lfdr.de>; Sat, 09 May 2026 15:06:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9F6843013027
	for <lists+netdev@lfdr.de>; Sat,  9 May 2026 13:06:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 227BD38A700;
	Sat,  9 May 2026 13:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Cik65+W4"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0C4038945C;
	Sat,  9 May 2026 13:06:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778331978; cv=none; b=m5ilfdoBpKOJWs0gPPsEZKqVebfRHwEiArg/jmNi9d12HwW93TGgJwRSFkWGq9qa7FqATrKQIz4sp1g90+mpxw6B+018xjRe0bicq11f/x64YbbxQ9/INYNOZ/dvMcl6/UVhR6BCf0PS6Rv3w6epP9aY7aQqFdI3QufwEr7gN6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778331978; c=relaxed/simple;
	bh=QR9wkCsAW/mXkYGnqrn9hfF99Wa7amc/1CTOa2epVHg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Ff4K8b6Dq0eJIbQez75WHRv9oK7+Jcne0As62Wuc8pwMbiq+HdiURC3++4ALMytMLe5V4hQVZYdphaYzxIbCXkLDWnC+L3mnkOLTNZSeNJ+VBxuGPe+e3sUjOgsEpJskoTkaTiTHz3MR3tbVfPylnmTdbVOMYrk64vjl9PTI1CM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Cik65+W4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6895C2BCF4;
	Sat,  9 May 2026 13:06:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778331977;
	bh=QR9wkCsAW/mXkYGnqrn9hfF99Wa7amc/1CTOa2epVHg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Cik65+W4w5TGzg+WS0WThJiAzS7GPLT63VdFdCK+CImynYW4UrSl1P+PnoHQtkFjK
	 UqnLmTcYOcoPuGNfYFP3D/0BV0kxXw8nMA3RrcLSLVDDs033dhAGNxDGko76j4PsL3
	 4+fjD0GHJ83ECpyHq0SaejVnzOV+TAVYlxjNISGlQgiml3nnGt+Eo15XEOZ4OqB8Pv
	 sWtDGA8mZ9Mr+mWarzwqBblMbhIyqxcLc9CfmV7R9EWXH2i+8CW9egpjUgDgn0txNS
	 R5YEB3+BwKkOHa9w3mmm3cyLws8NSyaL3LXBkCb//jdMdTRFMSJGzwKsGtbGNLXEAu
	 obgjUuG4ysj6w==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Sat, 09 May 2026 15:05:34 +0200
Subject: [PATCH net-next v5 09/12] net: airoha: Do not stop GDM port if it
 is shared
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260509-airoha-eth-multi-serdes-v5-9-805e38edc2aa@kernel.org>
References: <20260509-airoha-eth-multi-serdes-v5-0-805e38edc2aa@kernel.org>
In-Reply-To: <20260509-airoha-eth-multi-serdes-v5-0-805e38edc2aa@kernel.org>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Lorenzo Bianconi <lorenzo@kernel.org>
Cc: Christian Marangi <ansuelsmth@gmail.com>, 
 Benjamin Larsson <benjamin.larsson@genexis.eu>, 
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
 netdev@vger.kernel.org, devicetree@vger.kernel.org, 
 Xuegang Lu <xuegang.lu@airoha.com>
X-Mailer: b4 0.14.3
X-Rspamd-Queue-Id: AD9F24FFBDE
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-286178-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,genexis.eu,lists.infradead.org,vger.kernel.org,airoha.com];
	RCPT_COUNT_TWELVE(0.00)[16];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[airoha.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Action: no action

Theoretically, in the current codebase, two independent net_devices can
be connected to the same GDM port so we need to check the GDM port is not
used by any other running net_device before setting the forward
configuration to FE_PSE_PORT_DROP.

Tested-by: Xuegang Lu <xuegang.lu@airoha.com>
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/ethernet/airoha/airoha_eth.c | 39 +++++++++++++++++++++++---------
 drivers/net/ethernet/airoha/airoha_eth.h |  1 +
 2 files changed, 29 insertions(+), 11 deletions(-)

diff --git a/drivers/net/ethernet/airoha/airoha_eth.c b/drivers/net/ethernet/airoha/airoha_eth.c
index be31f639f4be..ebb24e60f1de 100644
--- a/drivers/net/ethernet/airoha/airoha_eth.c
+++ b/drivers/net/ethernet/airoha/airoha_eth.c
@@ -1718,8 +1718,8 @@ static int airoha_dev_open(struct net_device *netdev)
 	int err, len = ETH_HLEN + netdev->mtu + ETH_FCS_LEN;
 	struct airoha_gdm_dev *dev = netdev_priv(netdev);
 	struct airoha_gdm_port *port = dev->port;
+	u32 cur_len, pse_port = FE_PSE_PORT_PPE1;
 	struct airoha_qdma *qdma = dev->qdma;
-	u32 pse_port = FE_PSE_PORT_PPE1;
 
 	netif_tx_start_all_queues(netdev);
 	err = airoha_set_vip_for_gdm_port(dev, true);
@@ -1733,10 +1733,20 @@ static int airoha_dev_open(struct net_device *netdev)
 		airoha_fe_clear(qdma->eth, REG_GDM_INGRESS_CFG(port->id),
 				GDM_STAG_EN_MASK);
 
-	airoha_fe_rmw(qdma->eth, REG_GDM_LEN_CFG(port->id),
-		      GDM_SHORT_LEN_MASK | GDM_LONG_LEN_MASK,
-		      FIELD_PREP(GDM_SHORT_LEN_MASK, 60) |
-		      FIELD_PREP(GDM_LONG_LEN_MASK, len));
+	cur_len = airoha_fe_get(qdma->eth, REG_GDM_LEN_CFG(port->id),
+				GDM_LONG_LEN_MASK);
+	if (!port->users || len > cur_len) {
+		/* Opening a sibling net_device with a larger MTU updates the
+		 * MTU of already running devices. This is required to allow
+		 * multiple net_devices wht different MTUs to share the same
+		 * QDMA block.
+		 */
+		airoha_fe_rmw(qdma->eth, REG_GDM_LEN_CFG(port->id),
+			      GDM_SHORT_LEN_MASK | GDM_LONG_LEN_MASK,
+			      FIELD_PREP(GDM_SHORT_LEN_MASK, 60) |
+			      FIELD_PREP(GDM_LONG_LEN_MASK, len));
+	}
+	port->users++;
 
 	airoha_qdma_set(qdma, REG_QDMA_GLOBAL_CFG,
 			GLOBAL_CFG_TX_DMA_EN_MASK |
@@ -1766,8 +1776,10 @@ static int airoha_dev_stop(struct net_device *netdev)
 	for (i = 0; i < netdev->num_tx_queues; i++)
 		netdev_tx_reset_subqueue(netdev, i);
 
-	airoha_set_gdm_port_fwd_cfg(qdma->eth, REG_GDM_FWD_CFG(port->id),
-				    FE_PSE_PORT_DROP);
+	if (!--port->users)
+		airoha_set_gdm_port_fwd_cfg(qdma->eth,
+					    REG_GDM_FWD_CFG(port->id),
+					    FE_PSE_PORT_DROP);
 
 	if (atomic_dec_and_test(&qdma->users)) {
 		airoha_qdma_clear(qdma, REG_QDMA_GLOBAL_CFG,
@@ -1919,13 +1931,18 @@ static void airoha_dev_get_stats64(struct net_device *netdev,
 static int airoha_dev_change_mtu(struct net_device *netdev, int mtu)
 {
 	struct airoha_gdm_dev *dev = netdev_priv(netdev);
+	u32 cur_len, len = ETH_HLEN + mtu + ETH_FCS_LEN;
 	struct airoha_gdm_port *port = dev->port;
-	u32 len = ETH_HLEN + mtu + ETH_FCS_LEN;
 	struct airoha_eth *eth = dev->eth;
 
-	airoha_fe_rmw(eth, REG_GDM_LEN_CFG(port->id),
-		      GDM_LONG_LEN_MASK,
-		      FIELD_PREP(GDM_LONG_LEN_MASK, len));
+	cur_len = airoha_fe_get(eth, REG_GDM_LEN_CFG(port->id),
+				GDM_LONG_LEN_MASK);
+	if (len > cur_len || !port->users ||
+	    (port->users == 1 && netif_running(netdev)))
+		airoha_fe_rmw(eth, REG_GDM_LEN_CFG(port->id),
+			      GDM_LONG_LEN_MASK,
+			      FIELD_PREP(GDM_LONG_LEN_MASK, len));
+
 	WRITE_ONCE(netdev->mtu, mtu);
 
 	return 0;
diff --git a/drivers/net/ethernet/airoha/airoha_eth.h b/drivers/net/ethernet/airoha/airoha_eth.h
index 8d6887e33413..809f63a5d211 100644
--- a/drivers/net/ethernet/airoha/airoha_eth.h
+++ b/drivers/net/ethernet/airoha/airoha_eth.h
@@ -554,6 +554,7 @@ struct airoha_gdm_dev {
 struct airoha_gdm_port {
 	struct airoha_gdm_dev *devs[AIROHA_MAX_NUM_GDM_DEVS];
 	int id;
+	int users;
 
 	struct airoha_hw_stats stats;
 

-- 
2.54.0


