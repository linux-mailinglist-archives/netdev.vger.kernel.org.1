Return-Path: <netdev+bounces-298079-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id e9e0KFORKmpIsgMAu9opvQ
	(envelope-from <netdev+bounces-298079-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 12:43:31 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 19083670F43
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 12:43:31 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=E3GhGxmi;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-298079-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-298079-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 277FD305D128
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 10:43:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E06EA3D565D;
	Thu, 11 Jun 2026 10:43:19 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3578F3D47AF
	for <netdev@vger.kernel.org>; Thu, 11 Jun 2026 10:43:17 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781174599; cv=none; b=YTly3v2ZCEzLr2SCLmfKlbQIPKLVYM0IJpCfBpiWY3n5/E7y+Wpg7HvUh0OlVspln2z04Uu6r6i/k/D9DygkG1pfjRUt74HKcK4+6OdEVGNcTmHE+tMy5+W6EddHKXbf6tbsK3jMuDgtjYG3Z1kRryoZkF75imrwihMSzTKdpP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781174599; c=relaxed/simple;
	bh=TBwWLq/ZkB3hWR4/aWdpOa8oJHri3sbEN4ILWpy0V5k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=suVQLMi+z76WISpqwkwm0HikXyk2ZZWKVfDPavhu4d1rrp4MfqP2Y9u0oyr8Wjd9QAK6zYCsp6H+TWCUZliSkZ3ewFl5aVU+Dt2J80zbO16lCePxAfy6EvRjyBUhhdkr9GbBQwQv62ALu6icUOBfhMa+iAYA8iNiPtv2X+Gtojw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E3GhGxmi; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5AA4F1F00898;
	Thu, 11 Jun 2026 10:43:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781174597;
	bh=iynYsqAWPYBt/5P7GC7zl3iJdGh7tClGBLeJktRmcfg=;
	h=From:Date:Subject:To:Cc;
	b=E3GhGxmieirNvQz/1Y0hd4Ys/YaQHNzQJbhks0MsXlEtbASm1Bi8BbhXIBFsf3JjU
	 t+myz68DoT08xPcBaoTjnc/qOS8qNdZ+AHekCXJ+MNCcRHSNOLrl68jndNUeIbSK33
	 rOROwkMRYHysf+DofftQ3EKbUOFQnPv7lf1azTZwURjfr5Af2IPqVJEm/DxoOFJYod
	 K+eKnhilP3mw6RIqY79y363z+dni8JPtAY2lXADlAZrcQbVEFDV7XWHJV+YAg0YSJl
	 CJJ9K9Iphg0giFLLQiH/hF0m58gpnsYFmeiX82f3O5KlieD7scy18pSJSIeD/iojZh
	 CD5cTFfgv7bBQ==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Thu, 11 Jun 2026 12:43:00 +0200
Subject: [PATCH net-next] net: airoha: better handle MIBs for GDM ports
 with multiple devs attached
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260611-airoha-eth-multi-serdes-stats-v1-1-42442ae42064@kernel.org>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x3MMQrDMAwF0KsEzRXEHjz0KqWDsX5qQeIUSy2Bk
 LvXdHzLO8nQFUb36aSOr5rubSDcJio1txdYZZjiHNOcQuCsfa+Z4ZW3z+rKIxAYm2c3liVKCal
 EkUTjeHcsevz/BzU4NxxOz+v6AfidzPR5AAAA
X-Change-ID: 20260611-airoha-eth-multi-serdes-stats-df2dc16c2dd6
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Lorenzo Bianconi <lorenzo@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, netdev@vger.kernel.org, 
 Christian Marangi <ansuelsmth@gmail.com>
X-Mailer: b4 0.14.3
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-298079-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:lorenzo@kernel.org,m:linux-arm-kernel@lists.infradead.org,m:linux-mediatek@lists.infradead.org,m:netdev@vger.kernel.org,m:ansuelsmth@gmail.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	FREEMAIL_CC(0.00)[lists.infradead.org,vger.kernel.org,gmail.com];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[lorenzo@kernel.org,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lorenzo@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 19083670F43

In the context of a GDM port that can have multiple net_devices attached
(GDM3 and GDM4), the HW counters (MIBs) are global for the GDM port.
This cause duplicated stats reported to the kernel for the related
net_device.
The SoC supports a split MIB feature where each counter is tracked based
on the relevant HW channel (NBQ) to account for this scenario and
provide a way to select the related counter on accessing the MIB
registers.
Enable this feature for GDM3 and GDM4 and configure the relevant HW
channel before updating the HW stats to report correct HW counter to the
kernel for the related interface.
Move the stats struct from port to dev since HW counter are now specific
to the network device instead of the GDM port. Refactor
airoha_update_hw_stats() to take airoha_eth and airoha_gdm_port
parameters since the function operates on the entire port.

Co-developed-by: Christian Marangi <ansuelsmth@gmail.com>
Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/ethernet/airoha/airoha_eth.c | 191 +++++++++++++++++--------------
 drivers/net/ethernet/airoha/airoha_eth.h |   7 +-
 2 files changed, 112 insertions(+), 86 deletions(-)

diff --git a/drivers/net/ethernet/airoha/airoha_eth.c b/drivers/net/ethernet/airoha/airoha_eth.c
index 5a8e84fa9918..7676ec9b3129 100644
--- a/drivers/net/ethernet/airoha/airoha_eth.c
+++ b/drivers/net/ethernet/airoha/airoha_eth.c
@@ -556,6 +556,14 @@ static int airoha_fe_init(struct airoha_eth *eth)
 	airoha_fe_set(eth, REG_GDM_FWD_CFG(AIROHA_GDM3_IDX), GDM_PAD_EN_MASK);
 	airoha_fe_set(eth, REG_GDM_FWD_CFG(AIROHA_GDM4_IDX), GDM_PAD_EN_MASK);
 
+	/* Enable split for MIB counters for GDM3 and GDM4 */
+	airoha_fe_set(eth, REG_FE_GDM_MIB_CFG(AIROHA_GDM3_IDX),
+		      FE_GDM_TX_MIB_SPLIT_EN_MASK |
+		      FE_GDM_RX_MIB_SPLIT_EN_MASK);
+	airoha_fe_set(eth, REG_FE_GDM_MIB_CFG(AIROHA_GDM4_IDX),
+		      FE_GDM_TX_MIB_SPLIT_EN_MASK |
+		      FE_GDM_RX_MIB_SPLIT_EN_MASK);
+
 	airoha_fe_crsn_qsel_init(eth);
 
 	airoha_fe_clear(eth, REG_FE_CPORT_CFG, FE_CPORT_QUEUE_XFC_MASK);
@@ -1626,149 +1634,169 @@ static void airoha_qdma_stop_napi(struct airoha_qdma *qdma)
 	}
 }
 
-static void airoha_update_hw_stats(struct airoha_gdm_dev *dev)
+static void airoha_dev_get_hw_stats(struct airoha_gdm_dev *dev)
 {
 	struct airoha_gdm_port *port = dev->port;
 	struct airoha_eth *eth = dev->eth;
 	u32 val, i = 0;
 
-	spin_lock(&port->stats.lock);
-	u64_stats_update_begin(&port->stats.syncp);
+	/* Read relevant MIB for GDM with multiple port attached */
+	if (port->id == AIROHA_GDM3_IDX || port->id == AIROHA_GDM4_IDX)
+		airoha_fe_rmw(eth, REG_FE_GDM_MIB_CFG(port->id),
+			      FE_TX_MIB_ID_MASK | FE_RX_MIB_ID_MASK,
+			      FIELD_PREP(FE_TX_MIB_ID_MASK, dev->nbq) |
+			      FIELD_PREP(FE_RX_MIB_ID_MASK, dev->nbq));
+
+	u64_stats_update_begin(&dev->stats.syncp);
 
 	/* TX */
 	val = airoha_fe_rr(eth, REG_FE_GDM_TX_OK_PKT_CNT_H(port->id));
-	port->stats.tx_ok_pkts += ((u64)val << 32);
+	dev->stats.tx_ok_pkts += ((u64)val << 32);
 	val = airoha_fe_rr(eth, REG_FE_GDM_TX_OK_PKT_CNT_L(port->id));
-	port->stats.tx_ok_pkts += val;
+	dev->stats.tx_ok_pkts += val;
 
 	val = airoha_fe_rr(eth, REG_FE_GDM_TX_OK_BYTE_CNT_H(port->id));
-	port->stats.tx_ok_bytes += ((u64)val << 32);
+	dev->stats.tx_ok_bytes += ((u64)val << 32);
 	val = airoha_fe_rr(eth, REG_FE_GDM_TX_OK_BYTE_CNT_L(port->id));
-	port->stats.tx_ok_bytes += val;
+	dev->stats.tx_ok_bytes += val;
 
 	val = airoha_fe_rr(eth, REG_FE_GDM_TX_ETH_DROP_CNT(port->id));
-	port->stats.tx_drops += val;
+	dev->stats.tx_drops += val;
 
 	val = airoha_fe_rr(eth, REG_FE_GDM_TX_ETH_BC_CNT(port->id));
-	port->stats.tx_broadcast += val;
+	dev->stats.tx_broadcast += val;
 
 	val = airoha_fe_rr(eth, REG_FE_GDM_TX_ETH_MC_CNT(port->id));
-	port->stats.tx_multicast += val;
+	dev->stats.tx_multicast += val;
 
 	val = airoha_fe_rr(eth, REG_FE_GDM_TX_ETH_RUNT_CNT(port->id));
-	port->stats.tx_len[i] += val;
+	dev->stats.tx_len[i] += val;
 
 	val = airoha_fe_rr(eth, REG_FE_GDM_TX_ETH_E64_CNT_H(port->id));
-	port->stats.tx_len[i] += ((u64)val << 32);
+	dev->stats.tx_len[i] += ((u64)val << 32);
 	val = airoha_fe_rr(eth, REG_FE_GDM_TX_ETH_E64_CNT_L(port->id));
-	port->stats.tx_len[i++] += val;
+	dev->stats.tx_len[i++] += val;
 
 	val = airoha_fe_rr(eth, REG_FE_GDM_TX_ETH_L64_CNT_H(port->id));
-	port->stats.tx_len[i] += ((u64)val << 32);
+	dev->stats.tx_len[i] += ((u64)val << 32);
 	val = airoha_fe_rr(eth, REG_FE_GDM_TX_ETH_L64_CNT_L(port->id));
-	port->stats.tx_len[i++] += val;
+	dev->stats.tx_len[i++] += val;
 
 	val = airoha_fe_rr(eth, REG_FE_GDM_TX_ETH_L127_CNT_H(port->id));
-	port->stats.tx_len[i] += ((u64)val << 32);
+	dev->stats.tx_len[i] += ((u64)val << 32);
 	val = airoha_fe_rr(eth, REG_FE_GDM_TX_ETH_L127_CNT_L(port->id));
-	port->stats.tx_len[i++] += val;
+	dev->stats.tx_len[i++] += val;
 
 	val = airoha_fe_rr(eth, REG_FE_GDM_TX_ETH_L255_CNT_H(port->id));
-	port->stats.tx_len[i] += ((u64)val << 32);
+	dev->stats.tx_len[i] += ((u64)val << 32);
 	val = airoha_fe_rr(eth, REG_FE_GDM_TX_ETH_L255_CNT_L(port->id));
-	port->stats.tx_len[i++] += val;
+	dev->stats.tx_len[i++] += val;
 
 	val = airoha_fe_rr(eth, REG_FE_GDM_TX_ETH_L511_CNT_H(port->id));
-	port->stats.tx_len[i] += ((u64)val << 32);
+	dev->stats.tx_len[i] += ((u64)val << 32);
 	val = airoha_fe_rr(eth, REG_FE_GDM_TX_ETH_L511_CNT_L(port->id));
-	port->stats.tx_len[i++] += val;
+	dev->stats.tx_len[i++] += val;
 
 	val = airoha_fe_rr(eth, REG_FE_GDM_TX_ETH_L1023_CNT_H(port->id));
-	port->stats.tx_len[i] += ((u64)val << 32);
+	dev->stats.tx_len[i] += ((u64)val << 32);
 	val = airoha_fe_rr(eth, REG_FE_GDM_TX_ETH_L1023_CNT_L(port->id));
-	port->stats.tx_len[i++] += val;
+	dev->stats.tx_len[i++] += val;
 
 	val = airoha_fe_rr(eth, REG_FE_GDM_TX_ETH_LONG_CNT(port->id));
-	port->stats.tx_len[i++] += val;
+	dev->stats.tx_len[i++] += val;
 
 	/* RX */
 	val = airoha_fe_rr(eth, REG_FE_GDM_RX_OK_PKT_CNT_H(port->id));
-	port->stats.rx_ok_pkts += ((u64)val << 32);
+	dev->stats.rx_ok_pkts += ((u64)val << 32);
 	val = airoha_fe_rr(eth, REG_FE_GDM_RX_OK_PKT_CNT_L(port->id));
-	port->stats.rx_ok_pkts += val;
+	dev->stats.rx_ok_pkts += val;
 
 	val = airoha_fe_rr(eth, REG_FE_GDM_RX_OK_BYTE_CNT_H(port->id));
-	port->stats.rx_ok_bytes += ((u64)val << 32);
+	dev->stats.rx_ok_bytes += ((u64)val << 32);
 	val = airoha_fe_rr(eth, REG_FE_GDM_RX_OK_BYTE_CNT_L(port->id));
-	port->stats.rx_ok_bytes += val;
+	dev->stats.rx_ok_bytes += val;
 
 	val = airoha_fe_rr(eth, REG_FE_GDM_RX_ETH_DROP_CNT(port->id));
-	port->stats.rx_drops += val;
+	dev->stats.rx_drops += val;
 
 	val = airoha_fe_rr(eth, REG_FE_GDM_RX_ETH_BC_CNT(port->id));
-	port->stats.rx_broadcast += val;
+	dev->stats.rx_broadcast += val;
 
 	val = airoha_fe_rr(eth, REG_FE_GDM_RX_ETH_MC_CNT(port->id));
-	port->stats.rx_multicast += val;
+	dev->stats.rx_multicast += val;
 
 	val = airoha_fe_rr(eth, REG_FE_GDM_RX_ERROR_DROP_CNT(port->id));
-	port->stats.rx_errors += val;
+	dev->stats.rx_errors += val;
 
 	val = airoha_fe_rr(eth, REG_FE_GDM_RX_ETH_CRC_ERR_CNT(port->id));
-	port->stats.rx_crc_error += val;
+	dev->stats.rx_crc_error += val;
 
 	val = airoha_fe_rr(eth, REG_FE_GDM_RX_OVERFLOW_DROP_CNT(port->id));
-	port->stats.rx_over_errors += val;
+	dev->stats.rx_over_errors += val;
 
 	val = airoha_fe_rr(eth, REG_FE_GDM_RX_ETH_FRAG_CNT(port->id));
-	port->stats.rx_fragment += val;
+	dev->stats.rx_fragment += val;
 
 	val = airoha_fe_rr(eth, REG_FE_GDM_RX_ETH_JABBER_CNT(port->id));
-	port->stats.rx_jabber += val;
+	dev->stats.rx_jabber += val;
 
 	i = 0;
 	val = airoha_fe_rr(eth, REG_FE_GDM_RX_ETH_RUNT_CNT(port->id));
-	port->stats.rx_len[i] += val;
+	dev->stats.rx_len[i] += val;
 
 	val = airoha_fe_rr(eth, REG_FE_GDM_RX_ETH_E64_CNT_H(port->id));
-	port->stats.rx_len[i] += ((u64)val << 32);
+	dev->stats.rx_len[i] += ((u64)val << 32);
 	val = airoha_fe_rr(eth, REG_FE_GDM_RX_ETH_E64_CNT_L(port->id));
-	port->stats.rx_len[i++] += val;
+	dev->stats.rx_len[i++] += val;
 
 	val = airoha_fe_rr(eth, REG_FE_GDM_RX_ETH_L64_CNT_H(port->id));
-	port->stats.rx_len[i] += ((u64)val << 32);
+	dev->stats.rx_len[i] += ((u64)val << 32);
 	val = airoha_fe_rr(eth, REG_FE_GDM_RX_ETH_L64_CNT_L(port->id));
-	port->stats.rx_len[i++] += val;
+	dev->stats.rx_len[i++] += val;
 
 	val = airoha_fe_rr(eth, REG_FE_GDM_RX_ETH_L127_CNT_H(port->id));
-	port->stats.rx_len[i] += ((u64)val << 32);
+	dev->stats.rx_len[i] += ((u64)val << 32);
 	val = airoha_fe_rr(eth, REG_FE_GDM_RX_ETH_L127_CNT_L(port->id));
-	port->stats.rx_len[i++] += val;
+	dev->stats.rx_len[i++] += val;
 
 	val = airoha_fe_rr(eth, REG_FE_GDM_RX_ETH_L255_CNT_H(port->id));
-	port->stats.rx_len[i] += ((u64)val << 32);
+	dev->stats.rx_len[i] += ((u64)val << 32);
 	val = airoha_fe_rr(eth, REG_FE_GDM_RX_ETH_L255_CNT_L(port->id));
-	port->stats.rx_len[i++] += val;
+	dev->stats.rx_len[i++] += val;
 
 	val = airoha_fe_rr(eth, REG_FE_GDM_RX_ETH_L511_CNT_H(port->id));
-	port->stats.rx_len[i] += ((u64)val << 32);
+	dev->stats.rx_len[i] += ((u64)val << 32);
 	val = airoha_fe_rr(eth, REG_FE_GDM_RX_ETH_L511_CNT_L(port->id));
-	port->stats.rx_len[i++] += val;
+	dev->stats.rx_len[i++] += val;
 
 	val = airoha_fe_rr(eth, REG_FE_GDM_RX_ETH_L1023_CNT_H(port->id));
-	port->stats.rx_len[i] += ((u64)val << 32);
+	dev->stats.rx_len[i] += ((u64)val << 32);
 	val = airoha_fe_rr(eth, REG_FE_GDM_RX_ETH_L1023_CNT_L(port->id));
-	port->stats.rx_len[i++] += val;
+	dev->stats.rx_len[i++] += val;
 
 	val = airoha_fe_rr(eth, REG_FE_GDM_RX_ETH_LONG_CNT(port->id));
-	port->stats.rx_len[i++] += val;
+	dev->stats.rx_len[i++] += val;
+
+	u64_stats_update_end(&dev->stats.syncp);
+}
 
-	/* reset mib counters */
-	airoha_fe_set(eth, REG_FE_GDM_MIB_CLEAR(port->id),
+static void airoha_update_hw_stats(struct airoha_gdm_dev *dev)
+{
+	struct airoha_gdm_port *port = dev->port;
+	int i;
+
+	spin_lock(&port->stats_lock);
+
+	for (i = 0; i < ARRAY_SIZE(port->devs); i++) {
+		if (port->devs[i])
+			airoha_dev_get_hw_stats(port->devs[i]);
+	}
+
+	/* Reset MIB counters */
+	airoha_fe_set(dev->eth, REG_FE_GDM_MIB_CLEAR(port->id),
 		      FE_GDM_MIB_RX_CLEAR_MASK | FE_GDM_MIB_TX_CLEAR_MASK);
 
-	u64_stats_update_end(&port->stats.syncp);
-	spin_unlock(&port->stats.lock);
+	spin_unlock(&port->stats_lock);
 }
 
 static int airoha_dev_open(struct net_device *netdev)
@@ -2043,23 +2071,22 @@ static void airoha_dev_get_stats64(struct net_device *netdev,
 				   struct rtnl_link_stats64 *storage)
 {
 	struct airoha_gdm_dev *dev = netdev_priv(netdev);
-	struct airoha_gdm_port *port = dev->port;
 	unsigned int start;
 
 	airoha_update_hw_stats(dev);
 	do {
-		start = u64_stats_fetch_begin(&port->stats.syncp);
-		storage->rx_packets = port->stats.rx_ok_pkts;
-		storage->tx_packets = port->stats.tx_ok_pkts;
-		storage->rx_bytes = port->stats.rx_ok_bytes;
-		storage->tx_bytes = port->stats.tx_ok_bytes;
-		storage->multicast = port->stats.rx_multicast;
-		storage->rx_errors = port->stats.rx_errors;
-		storage->rx_dropped = port->stats.rx_drops;
-		storage->tx_dropped = port->stats.tx_drops;
-		storage->rx_crc_errors = port->stats.rx_crc_error;
-		storage->rx_over_errors = port->stats.rx_over_errors;
-	} while (u64_stats_fetch_retry(&port->stats.syncp, start));
+		start = u64_stats_fetch_begin(&dev->stats.syncp);
+		storage->rx_packets = dev->stats.rx_ok_pkts;
+		storage->tx_packets = dev->stats.tx_ok_pkts;
+		storage->rx_bytes = dev->stats.rx_ok_bytes;
+		storage->tx_bytes = dev->stats.tx_ok_bytes;
+		storage->multicast = dev->stats.rx_multicast;
+		storage->rx_errors = dev->stats.rx_errors;
+		storage->rx_dropped = dev->stats.rx_drops;
+		storage->tx_dropped = dev->stats.tx_drops;
+		storage->rx_crc_errors = dev->stats.rx_crc_error;
+		storage->rx_over_errors = dev->stats.rx_over_errors;
+	} while (u64_stats_fetch_retry(&dev->stats.syncp, start));
 }
 
 static int airoha_dev_change_mtu(struct net_device *netdev, int mtu)
@@ -2310,20 +2337,19 @@ static void airoha_ethtool_get_mac_stats(struct net_device *netdev,
 					 struct ethtool_eth_mac_stats *stats)
 {
 	struct airoha_gdm_dev *dev = netdev_priv(netdev);
-	struct airoha_gdm_port *port = dev->port;
 	unsigned int start;
 
 	airoha_update_hw_stats(dev);
 	do {
-		start = u64_stats_fetch_begin(&port->stats.syncp);
-		stats->FramesTransmittedOK = port->stats.tx_ok_pkts;
-		stats->OctetsTransmittedOK = port->stats.tx_ok_bytes;
-		stats->MulticastFramesXmittedOK = port->stats.tx_multicast;
-		stats->BroadcastFramesXmittedOK = port->stats.tx_broadcast;
-		stats->FramesReceivedOK = port->stats.rx_ok_pkts;
-		stats->OctetsReceivedOK = port->stats.rx_ok_bytes;
-		stats->BroadcastFramesReceivedOK = port->stats.rx_broadcast;
-	} while (u64_stats_fetch_retry(&port->stats.syncp, start));
+		start = u64_stats_fetch_begin(&dev->stats.syncp);
+		stats->FramesTransmittedOK = dev->stats.tx_ok_pkts;
+		stats->OctetsTransmittedOK = dev->stats.tx_ok_bytes;
+		stats->MulticastFramesXmittedOK = dev->stats.tx_multicast;
+		stats->BroadcastFramesXmittedOK = dev->stats.tx_broadcast;
+		stats->FramesReceivedOK = dev->stats.rx_ok_pkts;
+		stats->OctetsReceivedOK = dev->stats.rx_ok_bytes;
+		stats->BroadcastFramesReceivedOK = dev->stats.rx_broadcast;
+	} while (u64_stats_fetch_retry(&dev->stats.syncp, start));
 }
 
 static const struct ethtool_rmon_hist_range airoha_ethtool_rmon_ranges[] = {
@@ -2343,8 +2369,7 @@ airoha_ethtool_get_rmon_stats(struct net_device *netdev,
 			      const struct ethtool_rmon_hist_range **ranges)
 {
 	struct airoha_gdm_dev *dev = netdev_priv(netdev);
-	struct airoha_gdm_port *port = dev->port;
-	struct airoha_hw_stats *hw_stats = &port->stats;
+	struct airoha_hw_stats *hw_stats = &dev->stats;
 	unsigned int start;
 
 	BUILD_BUG_ON(ARRAY_SIZE(airoha_ethtool_rmon_ranges) !=
@@ -2357,7 +2382,7 @@ airoha_ethtool_get_rmon_stats(struct net_device *netdev,
 	do {
 		int i;
 
-		start = u64_stats_fetch_begin(&port->stats.syncp);
+		start = u64_stats_fetch_begin(&dev->stats.syncp);
 		stats->fragments = hw_stats->rx_fragment;
 		stats->jabbers = hw_stats->rx_jabber;
 		for (i = 0; i < ARRAY_SIZE(airoha_ethtool_rmon_ranges) - 1;
@@ -2365,7 +2390,7 @@ airoha_ethtool_get_rmon_stats(struct net_device *netdev,
 			stats->hist[i] = hw_stats->rx_len[i];
 			stats->hist_tx[i] = hw_stats->tx_len[i];
 		}
-	} while (u64_stats_fetch_retry(&port->stats.syncp, start));
+	} while (u64_stats_fetch_retry(&dev->stats.syncp, start));
 }
 
 static int airoha_qdma_set_chan_tx_sched(struct net_device *netdev,
@@ -3205,6 +3230,7 @@ static int airoha_alloc_gdm_device(struct airoha_eth *eth,
 
 	netdev->dev.of_node = of_node_get(np);
 	dev = netdev_priv(netdev);
+	u64_stats_init(&dev->stats.syncp);
 	dev->port = port;
 	dev->eth = eth;
 	dev->nbq = nbq;
@@ -3244,9 +3270,8 @@ static int airoha_alloc_gdm_port(struct airoha_eth *eth,
 	if (!port)
 		return -ENOMEM;
 
-	u64_stats_init(&port->stats.syncp);
-	spin_lock_init(&port->stats.lock);
 	port->id = id;
+	spin_lock_init(&port->stats_lock);
 	eth->ports[p] = port;
 
 	err = airoha_metadata_dst_alloc(port);
diff --git a/drivers/net/ethernet/airoha/airoha_eth.h b/drivers/net/ethernet/airoha/airoha_eth.h
index 8f42973f9cf5..46b1c31939de 100644
--- a/drivers/net/ethernet/airoha/airoha_eth.h
+++ b/drivers/net/ethernet/airoha/airoha_eth.h
@@ -215,8 +215,6 @@ struct airoha_tx_irq_queue {
 };
 
 struct airoha_hw_stats {
-	/* protect concurrent hw_stats accesses */
-	spinlock_t lock;
 	struct u64_stats_sync syncp;
 
 	/* get_stats64 */
@@ -554,6 +552,8 @@ struct airoha_gdm_dev {
 
 	u32 flags;
 	int nbq;
+
+	struct airoha_hw_stats stats;
 };
 
 struct airoha_gdm_port {
@@ -561,7 +561,8 @@ struct airoha_gdm_port {
 	int id;
 	int users;
 
-	struct airoha_hw_stats stats;
+	/* protect concurrent hw_stats accesses */
+	spinlock_t stats_lock;
 
 	struct metadata_dst *dsa_meta[AIROHA_MAX_DSA_PORTS];
 };

---
base-commit: c8459ee2fef502d6ef6c063751c33d9ac7943eab
change-id: 20260611-airoha-eth-multi-serdes-stats-df2dc16c2dd6

Best regards,
-- 
Lorenzo Bianconi <lorenzo@kernel.org>


