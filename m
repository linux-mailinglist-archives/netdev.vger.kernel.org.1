Return-Path: <netdev+bounces-286611-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AFUdH8y0AWo2iwEAu9opvQ
	(envelope-from <netdev+bounces-286611-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 12:51:56 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C0E450C409
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 12:51:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id B7BFF301082D
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 10:50:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25ABE3DA7E5;
	Mon, 11 May 2026 10:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GUYiFhVD"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02EC3344DBD;
	Mon, 11 May 2026 10:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778496610; cv=none; b=NqFkZoJqPZlG5Oz+YWAcv695bdVN73YXKGnfeUHyQY3XcsoHUIh63rZOzyvqWm/KdaYTo6YdhncLJ3Uaw1y5o0L8uJCc8Pj6iJB5eiqHfvqhux9/ewXDXFJtaaxNb6uj8AefnNtt64i33HNg22yOdi7OVRXMIYrp+ynvjzmtyfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778496610; c=relaxed/simple;
	bh=ZGDU8bLS0RFcij++u0hWkUdegThJdVgUR6iLpLo5Q9s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XwgOY2Rc8j68C3YdeMQfbVBIangZmGE0qBAuH9BPgLHSPkf5JgJl0coNvQ321wSVEEURik3rwuEO2R3qHKfzKGKuguwwHODPnzM4Su0gca9g18nk6+IvLgWT/2KK74XhKZ04a8EDY1UR67EAl8oOpgAt8s/wXrF1zGBPz+3s6+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GUYiFhVD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3626FC2BCB0;
	Mon, 11 May 2026 10:50:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778496609;
	bh=ZGDU8bLS0RFcij++u0hWkUdegThJdVgUR6iLpLo5Q9s=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=GUYiFhVDQZ0Wqn7HU26kzvTlEq6jGZ7Mo+vDBK4bHKihG9oIX9Kh9JiYx38+pGjjp
	 8ZONRJ3phY4MWrekmagMZ3ODNF4QzjPPnO8Jw/EmhT1pNAqczQ2+u6jsJm2zvz/fc7
	 zFMdvXEZEHHQpUGvnEy7xbBUo5iFl6FcxCL5vUeFwsgZO/hTek2IA6wXQcYNv9TuNF
	 fGw+WmphZvnpU4SlsOx+MatjiDsFeqjln+h+kBDTYtSbQc0tLXLSfWOtrkM5OA6PV4
	 yteiDjerCp55odmV/iFsXx14youjVlgRcB5faL7d7P/UufGGkjw7O1LEC9AaU6YTw8
	 8xMhAZJyEWRwg==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Mon, 11 May 2026 12:49:33 +0200
Subject: [PATCH net-next v6 07/12] net: airoha: Move {cpu,fwd}_tx_packets
 in airoha_gdm_dev struct
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260511-airoha-eth-multi-serdes-v6-7-c899462c4f75@kernel.org>
References: <20260511-airoha-eth-multi-serdes-v6-0-c899462c4f75@kernel.org>
In-Reply-To: <20260511-airoha-eth-multi-serdes-v6-0-c899462c4f75@kernel.org>
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
X-Rspamd-Queue-Id: 9C0E450C409
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-286611-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Action: no action

Since now multiple net_devices connected to different QDMA blocks can
share the same GDM port, cpu_tx_packets and fwd_tx_packets fields can
be overwritten with the value from a different QDMA block. In order to
fix the issue move cpu_tx_packets and fwd_tx_packets fields from
airoha_gdm_port struct to airoha_gdm_dev one.

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/ethernet/airoha/airoha_eth.c | 16 +++++++---------
 drivers/net/ethernet/airoha/airoha_eth.h |  7 +++----
 2 files changed, 10 insertions(+), 13 deletions(-)

diff --git a/drivers/net/ethernet/airoha/airoha_eth.c b/drivers/net/ethernet/airoha/airoha_eth.c
index 033541df2f83..f0d5f28dd731 100644
--- a/drivers/net/ethernet/airoha/airoha_eth.c
+++ b/drivers/net/ethernet/airoha/airoha_eth.c
@@ -2312,19 +2312,17 @@ static int airoha_qdma_get_tx_ets_stats(struct net_device *netdev, int channel,
 					struct tc_ets_qopt_offload *opt)
 {
 	struct airoha_gdm_dev *dev = netdev_priv(netdev);
-	struct airoha_gdm_port *port = dev->port;
+	struct airoha_qdma *qdma = dev->qdma;
 
-	u64 cpu_tx_packets = airoha_qdma_rr(dev->qdma,
-					    REG_CNTR_VAL(channel << 1));
-	u64 fwd_tx_packets = airoha_qdma_rr(dev->qdma,
+	u64 cpu_tx_packets = airoha_qdma_rr(qdma, REG_CNTR_VAL(channel << 1));
+	u64 fwd_tx_packets = airoha_qdma_rr(qdma,
 					    REG_CNTR_VAL((channel << 1) + 1));
-	u64 tx_packets = (cpu_tx_packets - port->cpu_tx_packets) +
-			 (fwd_tx_packets - port->fwd_tx_packets);
+	u64 tx_packets = (cpu_tx_packets - dev->cpu_tx_packets) +
+			 (fwd_tx_packets - dev->fwd_tx_packets);
 
 	_bstats_update(opt->stats.bstats, 0, tx_packets);
-
-	port->cpu_tx_packets = cpu_tx_packets;
-	port->fwd_tx_packets = fwd_tx_packets;
+	dev->cpu_tx_packets = cpu_tx_packets;
+	dev->fwd_tx_packets = fwd_tx_packets;
 
 	return 0;
 }
diff --git a/drivers/net/ethernet/airoha/airoha_eth.h b/drivers/net/ethernet/airoha/airoha_eth.h
index a308a770116b..fbb50dc73af8 100644
--- a/drivers/net/ethernet/airoha/airoha_eth.h
+++ b/drivers/net/ethernet/airoha/airoha_eth.h
@@ -544,6 +544,9 @@ struct airoha_gdm_dev {
 	struct airoha_eth *eth;
 
 	DECLARE_BITMAP(qos_sq_bmap, AIROHA_NUM_QOS_CHANNELS);
+	/* qos stats counters */
+	u64 cpu_tx_packets;
+	u64 fwd_tx_packets;
 };
 
 struct airoha_gdm_port {
@@ -553,10 +556,6 @@ struct airoha_gdm_port {
 
 	struct airoha_hw_stats stats;
 
-	/* qos stats counters */
-	u64 cpu_tx_packets;
-	u64 fwd_tx_packets;
-
 	struct metadata_dst *dsa_meta[AIROHA_MAX_DSA_PORTS];
 };
 

-- 
2.54.0


