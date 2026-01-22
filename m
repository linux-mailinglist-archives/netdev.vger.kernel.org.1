Return-Path: <netdev+bounces-252502-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YLWlIYJycmlpkwAAu9opvQ
	(envelope-from <netdev+bounces-252502-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 19:54:58 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EF646CC08
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 19:54:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 327353014672
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 18:53:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5012B3859FE;
	Thu, 22 Jan 2026 18:53:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yu42LSi9"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A10A385EF7
	for <netdev@vger.kernel.org>; Thu, 22 Jan 2026 18:53:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769108005; cv=none; b=fbazMSqUuT7UUkD9YnBZ2zn5N9qiW2EbHbnvRHjCyVEBYIOKwQSIQgbz3KyVlzfZCplwk5aESWzzfiPrvo5lxPEBaLelG0cYQAqPdv7141W91301Wx4OU+JftbSfI9Vr9kIr1HG7unRo13tA5MAHBsep1Cfx5TsJhZMRFn7h6Bs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769108005; c=relaxed/simple;
	bh=9/Rq4doYSiljOqafaQtbsOmVPK8RSk/mEUzBYNOICoo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dnlVbOHccRpViIRclehubDR3q/xciCCHX+W3kYeaHtX6ZBlu6X0xi5GZMXlsNQoNUmGLwGMcKIkmlk9kubs9BHurHYI7HeUCkqwjWDlGN7fXjx2ayU1gMs2RYQikciukZI1xPEilyi5qPf/5/4tMuUrCvTyKBofMsTjY1vvSDM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Yu42LSi9; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-82311f4070cso308850b3a.0
        for <netdev@vger.kernel.org>; Thu, 22 Jan 2026 10:53:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769107995; x=1769712795; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=TWzta/r/B2JAGtHGJUL2js2kTmC/9to7xiyXgiuBd3M=;
        b=Yu42LSi982/zzWzTh01red9QV+igtO9xIZF0N5/YONNKLLAndc8CejM3aCv5pggCkG
         aznsPgh5lj/hHMK02emW0NENWX4ycy+Y/IHaLionlrtIEfpOypplbiyTIs1qPsqWK+2i
         afUG7qStCWaD2FQPJemj43P27Cy5L1kxxj3CmFWiW/RVPVvZChvZZPgu5A918eR/dLZ6
         SFPHTC1BZCyvQ5rVWvPNPK5vATssMZUz9JEqBRkrDWa3WyuOzdM/T6KwC4v5JUc9n7bY
         OVfzJL3v4Ry7wlQc8J8RCmG2wbc8WWIH0gwOM8S+JLCx+ILrcAMdNgU1xy6cb/ZEO4ib
         uXlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769107995; x=1769712795;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TWzta/r/B2JAGtHGJUL2js2kTmC/9to7xiyXgiuBd3M=;
        b=laleGabBpjZTrbYsi24bgyZ0OU2b9fJ4hicXr+TFwUrWPDtgS+G0kDnkRDSMJfEH+Z
         XwokOC1CoSxJVz2u1FzBr4xG+UcdNFE7fwybrhthBilC9vhEWZtOzgm7mWqo9q/QY6ql
         rGNa/0ODgQnfwBPziHNMANvUvcikq0xB8FlbPlhquwQkX3TzrL0wGTq4GYZyHkXX6Ffv
         FAGE+1Wj1vFGHnuVvXvsXNMPotQYTDNbIuIEJ6Gzen2AaBep9xrbQhPYw+F121ZeuC+b
         WKENfcwouVlPcSGILm0JnY3qly9oXh4B5O6CjJ0c254FDdKiqgyYg73dLRCIhUy4wZYs
         HFNw==
X-Gm-Message-State: AOJu0YwjH4o+EMJroOShOJcakem+8eoZyR9nCyLOvaLV3ul+MYneABlw
	zOVzFzsAEJnNOfG5jRUvEtcauvGbjqqtfOJo7MLO13mAWmmwyP7KCpa6COjIJw==
X-Gm-Gg: AZuq6aJ9eVHNIidtXyUZ25dSW3Gfm4tK8tq6Na/GFTwd/hc3qejB3r3nz2XESmqqUC5
	0gOp+6kec4BU+miEwMwsPdGcRQ82n+CxZYstENTYWGED/oXkDf7gYeL6Sa74t45yhZFeno3JinV
	qVz+MlyEHj7nmpiWG4LihqgGRCTKYzCPB9tmH+yMiYk9ciC3lUGy26fVVI4iDn5VYPPEEgrjrQP
	Z5WbSelfYulJeR5JVx3DDAIMjKcVMuCX7YmatmMpDHWWUow9aXZOm8b24RtWmaXwgDzjuiRwqXy
	aGgMQtVc4JcpN/UFTJeSGXxHSoVVjOhYCza3SnvgZJUpAYmkXfrfR4Ov5s8AcOV1Ns00Ev0MDxe
	9brOiPrnGc2HpwScDvqpQhG1Mk9wmfQXbCEZbV8DqPfFq+Qr8u4h7JscYIXKqGuqrCnTInR8T/c
	ecD4F6WIcPMciOGq8V1tXemHdFzPo3sFSvDBVZUPL8CHsjh0ZqBzQ6Up3ziu0wBNdw
X-Received: by 2002:a05:6a00:1c90:b0:81f:832a:174 with SMTP id d2e1a72fcca58-82317b00f17mr301414b3a.16.1769107995037;
        Thu, 22 Jan 2026 10:53:15 -0800 (PST)
Received: from d.home.mmyangfl.tk ([2001:19f0:8001:1644:5400:5ff:fe3e:12b1])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-823186838dfsm90058b3a.30.2026.01.22.10.53.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jan 2026 10:53:14 -0800 (PST)
From: David Yang <mmyangfl@gmail.com>
To: netdev@vger.kernel.org
Cc: David Yang <mmyangfl@gmail.com>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next] net: airoha: Use u64_stats_t with u64_stats_sync properly
Date: Fri, 23 Jan 2026 02:52:51 +0800
Message-ID: <20260122185255.2761568-1-mmyangfl@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org,lunn.ch,davemloft.net,google.com,redhat.com,lists.infradead.org,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-252502-lists,netdev=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mmyangfl@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 0EF646CC08
X-Rspamd-Action: no action

On 64bit arches, struct u64_stats_sync is empty and provides no help
against load/store tearing. Convert to u64_stats_t to ensure atomic
operations.

Signed-off-by: David Yang <mmyangfl@gmail.com>
---
 drivers/net/ethernet/airoha/airoha_eth.c | 136 +++++++++++------------
 drivers/net/ethernet/airoha/airoha_eth.h |  34 +++---
 2 files changed, 85 insertions(+), 85 deletions(-)

diff --git a/drivers/net/ethernet/airoha/airoha_eth.c b/drivers/net/ethernet/airoha/airoha_eth.c
index 62bcbbbe2a95..6ed220e5a094 100644
--- a/drivers/net/ethernet/airoha/airoha_eth.c
+++ b/drivers/net/ethernet/airoha/airoha_eth.c
@@ -1472,131 +1472,131 @@ static void airoha_update_hw_stats(struct airoha_gdm_port *port)
 
 	/* TX */
 	val = airoha_fe_rr(eth, REG_FE_GDM_TX_OK_PKT_CNT_H(port->id));
-	port->stats.tx_ok_pkts += ((u64)val << 32);
+	u64_stats_add(&port->stats.tx_ok_pkts, (u64)val << 32);
 	val = airoha_fe_rr(eth, REG_FE_GDM_TX_OK_PKT_CNT_L(port->id));
-	port->stats.tx_ok_pkts += val;
+	u64_stats_add(&port->stats.tx_ok_pkts, val);
 
 	val = airoha_fe_rr(eth, REG_FE_GDM_TX_OK_BYTE_CNT_H(port->id));
-	port->stats.tx_ok_bytes += ((u64)val << 32);
+	u64_stats_add(&port->stats.tx_ok_bytes, (u64)val << 32);
 	val = airoha_fe_rr(eth, REG_FE_GDM_TX_OK_BYTE_CNT_L(port->id));
-	port->stats.tx_ok_bytes += val;
+	u64_stats_add(&port->stats.tx_ok_bytes, val);
 
 	val = airoha_fe_rr(eth, REG_FE_GDM_TX_ETH_DROP_CNT(port->id));
-	port->stats.tx_drops += val;
+	u64_stats_add(&port->stats.tx_drops, val);
 
 	val = airoha_fe_rr(eth, REG_FE_GDM_TX_ETH_BC_CNT(port->id));
-	port->stats.tx_broadcast += val;
+	u64_stats_add(&port->stats.tx_broadcast, val);
 
 	val = airoha_fe_rr(eth, REG_FE_GDM_TX_ETH_MC_CNT(port->id));
-	port->stats.tx_multicast += val;
+	u64_stats_add(&port->stats.tx_multicast, val);
 
 	val = airoha_fe_rr(eth, REG_FE_GDM_TX_ETH_RUNT_CNT(port->id));
-	port->stats.tx_len[i] += val;
+	u64_stats_add(&port->stats.tx_len[i], val);
 
 	val = airoha_fe_rr(eth, REG_FE_GDM_TX_ETH_E64_CNT_H(port->id));
-	port->stats.tx_len[i] += ((u64)val << 32);
+	u64_stats_add(&port->stats.tx_len[i], (u64)val << 32);
 	val = airoha_fe_rr(eth, REG_FE_GDM_TX_ETH_E64_CNT_L(port->id));
-	port->stats.tx_len[i++] += val;
+	u64_stats_add(&port->stats.tx_len[i++], val);
 
 	val = airoha_fe_rr(eth, REG_FE_GDM_TX_ETH_L64_CNT_H(port->id));
-	port->stats.tx_len[i] += ((u64)val << 32);
+	u64_stats_add(&port->stats.tx_len[i], (u64)val << 32);
 	val = airoha_fe_rr(eth, REG_FE_GDM_TX_ETH_L64_CNT_L(port->id));
-	port->stats.tx_len[i++] += val;
+	u64_stats_add(&port->stats.tx_len[i++], val);
 
 	val = airoha_fe_rr(eth, REG_FE_GDM_TX_ETH_L127_CNT_H(port->id));
-	port->stats.tx_len[i] += ((u64)val << 32);
+	u64_stats_add(&port->stats.tx_len[i], (u64)val << 32);
 	val = airoha_fe_rr(eth, REG_FE_GDM_TX_ETH_L127_CNT_L(port->id));
-	port->stats.tx_len[i++] += val;
+	u64_stats_add(&port->stats.tx_len[i++], val);
 
 	val = airoha_fe_rr(eth, REG_FE_GDM_TX_ETH_L255_CNT_H(port->id));
-	port->stats.tx_len[i] += ((u64)val << 32);
+	u64_stats_add(&port->stats.tx_len[i], (u64)val << 32);
 	val = airoha_fe_rr(eth, REG_FE_GDM_TX_ETH_L255_CNT_L(port->id));
-	port->stats.tx_len[i++] += val;
+	u64_stats_add(&port->stats.tx_len[i++], val);
 
 	val = airoha_fe_rr(eth, REG_FE_GDM_TX_ETH_L511_CNT_H(port->id));
-	port->stats.tx_len[i] += ((u64)val << 32);
+	u64_stats_add(&port->stats.tx_len[i], (u64)val << 32);
 	val = airoha_fe_rr(eth, REG_FE_GDM_TX_ETH_L511_CNT_L(port->id));
-	port->stats.tx_len[i++] += val;
+	u64_stats_add(&port->stats.tx_len[i++], val);
 
 	val = airoha_fe_rr(eth, REG_FE_GDM_TX_ETH_L1023_CNT_H(port->id));
-	port->stats.tx_len[i] += ((u64)val << 32);
+	u64_stats_add(&port->stats.tx_len[i], (u64)val << 32);
 	val = airoha_fe_rr(eth, REG_FE_GDM_TX_ETH_L1023_CNT_L(port->id));
-	port->stats.tx_len[i++] += val;
+	u64_stats_add(&port->stats.tx_len[i++], val);
 
 	val = airoha_fe_rr(eth, REG_FE_GDM_TX_ETH_LONG_CNT(port->id));
-	port->stats.tx_len[i++] += val;
+	u64_stats_add(&port->stats.tx_len[i++], val);
 
 	/* RX */
 	val = airoha_fe_rr(eth, REG_FE_GDM_RX_OK_PKT_CNT_H(port->id));
-	port->stats.rx_ok_pkts += ((u64)val << 32);
+	u64_stats_add(&port->stats.rx_ok_pkts, (u64)val << 32);
 	val = airoha_fe_rr(eth, REG_FE_GDM_RX_OK_PKT_CNT_L(port->id));
-	port->stats.rx_ok_pkts += val;
+	u64_stats_add(&port->stats.rx_ok_pkts, val);
 
 	val = airoha_fe_rr(eth, REG_FE_GDM_RX_OK_BYTE_CNT_H(port->id));
-	port->stats.rx_ok_bytes += ((u64)val << 32);
+	u64_stats_add(&port->stats.rx_ok_bytes, (u64)val << 32);
 	val = airoha_fe_rr(eth, REG_FE_GDM_RX_OK_BYTE_CNT_L(port->id));
-	port->stats.rx_ok_bytes += val;
+	u64_stats_add(&port->stats.rx_ok_bytes, val);
 
 	val = airoha_fe_rr(eth, REG_FE_GDM_RX_ETH_DROP_CNT(port->id));
-	port->stats.rx_drops += val;
+	u64_stats_add(&port->stats.rx_drops, val);
 
 	val = airoha_fe_rr(eth, REG_FE_GDM_RX_ETH_BC_CNT(port->id));
-	port->stats.rx_broadcast += val;
+	u64_stats_add(&port->stats.rx_broadcast, val);
 
 	val = airoha_fe_rr(eth, REG_FE_GDM_RX_ETH_MC_CNT(port->id));
-	port->stats.rx_multicast += val;
+	u64_stats_add(&port->stats.rx_multicast, val);
 
 	val = airoha_fe_rr(eth, REG_FE_GDM_RX_ERROR_DROP_CNT(port->id));
-	port->stats.rx_errors += val;
+	u64_stats_add(&port->stats.rx_errors, val);
 
 	val = airoha_fe_rr(eth, REG_FE_GDM_RX_ETH_CRC_ERR_CNT(port->id));
-	port->stats.rx_crc_error += val;
+	u64_stats_add(&port->stats.rx_crc_error, val);
 
 	val = airoha_fe_rr(eth, REG_FE_GDM_RX_OVERFLOW_DROP_CNT(port->id));
-	port->stats.rx_over_errors += val;
+	u64_stats_add(&port->stats.rx_over_errors, val);
 
 	val = airoha_fe_rr(eth, REG_FE_GDM_RX_ETH_FRAG_CNT(port->id));
-	port->stats.rx_fragment += val;
+	u64_stats_add(&port->stats.rx_fragment, val);
 
 	val = airoha_fe_rr(eth, REG_FE_GDM_RX_ETH_JABBER_CNT(port->id));
-	port->stats.rx_jabber += val;
+	u64_stats_add(&port->stats.rx_jabber, val);
 
 	i = 0;
 	val = airoha_fe_rr(eth, REG_FE_GDM_RX_ETH_RUNT_CNT(port->id));
-	port->stats.rx_len[i] += val;
+	u64_stats_add(&port->stats.rx_len[i], val);
 
 	val = airoha_fe_rr(eth, REG_FE_GDM_RX_ETH_E64_CNT_H(port->id));
-	port->stats.rx_len[i] += ((u64)val << 32);
+	u64_stats_add(&port->stats.rx_len[i], (u64)val << 32);
 	val = airoha_fe_rr(eth, REG_FE_GDM_RX_ETH_E64_CNT_L(port->id));
-	port->stats.rx_len[i++] += val;
+	u64_stats_add(&port->stats.rx_len[i++], val);
 
 	val = airoha_fe_rr(eth, REG_FE_GDM_RX_ETH_L64_CNT_H(port->id));
-	port->stats.rx_len[i] += ((u64)val << 32);
+	u64_stats_add(&port->stats.rx_len[i], (u64)val << 32);
 	val = airoha_fe_rr(eth, REG_FE_GDM_RX_ETH_L64_CNT_L(port->id));
-	port->stats.rx_len[i++] += val;
+	u64_stats_add(&port->stats.rx_len[i++], val);
 
 	val = airoha_fe_rr(eth, REG_FE_GDM_RX_ETH_L127_CNT_H(port->id));
-	port->stats.rx_len[i] += ((u64)val << 32);
+	u64_stats_add(&port->stats.rx_len[i], (u64)val << 32);
 	val = airoha_fe_rr(eth, REG_FE_GDM_RX_ETH_L127_CNT_L(port->id));
-	port->stats.rx_len[i++] += val;
+	u64_stats_add(&port->stats.rx_len[i++], val);
 
 	val = airoha_fe_rr(eth, REG_FE_GDM_RX_ETH_L255_CNT_H(port->id));
-	port->stats.rx_len[i] += ((u64)val << 32);
+	u64_stats_add(&port->stats.rx_len[i], (u64)val << 32);
 	val = airoha_fe_rr(eth, REG_FE_GDM_RX_ETH_L255_CNT_L(port->id));
-	port->stats.rx_len[i++] += val;
+	u64_stats_add(&port->stats.rx_len[i++], val);
 
 	val = airoha_fe_rr(eth, REG_FE_GDM_RX_ETH_L511_CNT_H(port->id));
-	port->stats.rx_len[i] += ((u64)val << 32);
+	u64_stats_add(&port->stats.rx_len[i], (u64)val << 32);
 	val = airoha_fe_rr(eth, REG_FE_GDM_RX_ETH_L511_CNT_L(port->id));
-	port->stats.rx_len[i++] += val;
+	u64_stats_add(&port->stats.rx_len[i++], val);
 
 	val = airoha_fe_rr(eth, REG_FE_GDM_RX_ETH_L1023_CNT_H(port->id));
-	port->stats.rx_len[i] += ((u64)val << 32);
+	u64_stats_add(&port->stats.rx_len[i], (u64)val << 32);
 	val = airoha_fe_rr(eth, REG_FE_GDM_RX_ETH_L1023_CNT_L(port->id));
-	port->stats.rx_len[i++] += val;
+	u64_stats_add(&port->stats.rx_len[i++], val);
 
 	val = airoha_fe_rr(eth, REG_FE_GDM_RX_ETH_LONG_CNT(port->id));
-	port->stats.rx_len[i++] += val;
+	u64_stats_add(&port->stats.rx_len[i++], val);
 
 	/* reset mib counters */
 	airoha_fe_set(eth, REG_FE_GDM_MIB_CLEAR(port->id),
@@ -1795,16 +1795,16 @@ static void airoha_dev_get_stats64(struct net_device *dev,
 	airoha_update_hw_stats(port);
 	do {
 		start = u64_stats_fetch_begin(&port->stats.syncp);
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
+		storage->rx_packets = u64_stats_read(&port->stats.rx_ok_pkts);
+		storage->tx_packets = u64_stats_read(&port->stats.tx_ok_pkts);
+		storage->rx_bytes = u64_stats_read(&port->stats.rx_ok_bytes);
+		storage->tx_bytes = u64_stats_read(&port->stats.tx_ok_bytes);
+		storage->multicast = u64_stats_read(&port->stats.rx_multicast);
+		storage->rx_errors = u64_stats_read(&port->stats.rx_errors);
+		storage->rx_dropped = u64_stats_read(&port->stats.rx_drops);
+		storage->tx_dropped = u64_stats_read(&port->stats.tx_drops);
+		storage->rx_crc_errors = u64_stats_read(&port->stats.rx_crc_error);
+		storage->rx_over_errors = u64_stats_read(&port->stats.rx_over_errors);
 	} while (u64_stats_fetch_retry(&port->stats.syncp, start));
 }
 
@@ -2057,13 +2057,13 @@ static void airoha_ethtool_get_mac_stats(struct net_device *dev,
 	airoha_update_hw_stats(port);
 	do {
 		start = u64_stats_fetch_begin(&port->stats.syncp);
-		stats->FramesTransmittedOK = port->stats.tx_ok_pkts;
-		stats->OctetsTransmittedOK = port->stats.tx_ok_bytes;
-		stats->MulticastFramesXmittedOK = port->stats.tx_multicast;
-		stats->BroadcastFramesXmittedOK = port->stats.tx_broadcast;
-		stats->FramesReceivedOK = port->stats.rx_ok_pkts;
-		stats->OctetsReceivedOK = port->stats.rx_ok_bytes;
-		stats->BroadcastFramesReceivedOK = port->stats.rx_broadcast;
+		stats->FramesTransmittedOK = u64_stats_read(&port->stats.tx_ok_pkts);
+		stats->OctetsTransmittedOK = u64_stats_read(&port->stats.tx_ok_bytes);
+		stats->MulticastFramesXmittedOK = u64_stats_read(&port->stats.tx_multicast);
+		stats->BroadcastFramesXmittedOK = u64_stats_read(&port->stats.tx_broadcast);
+		stats->FramesReceivedOK = u64_stats_read(&port->stats.rx_ok_pkts);
+		stats->OctetsReceivedOK = u64_stats_read(&port->stats.rx_ok_bytes);
+		stats->BroadcastFramesReceivedOK = u64_stats_read(&port->stats.rx_broadcast);
 	} while (u64_stats_fetch_retry(&port->stats.syncp, start));
 }
 
@@ -2098,12 +2098,12 @@ airoha_ethtool_get_rmon_stats(struct net_device *dev,
 		int i;
 
 		start = u64_stats_fetch_begin(&port->stats.syncp);
-		stats->fragments = hw_stats->rx_fragment;
-		stats->jabbers = hw_stats->rx_jabber;
+		stats->fragments = u64_stats_read(&hw_stats->rx_fragment);
+		stats->jabbers = u64_stats_read(&hw_stats->rx_jabber);
 		for (i = 0; i < ARRAY_SIZE(airoha_ethtool_rmon_ranges) - 1;
 		     i++) {
-			stats->hist[i] = hw_stats->rx_len[i];
-			stats->hist_tx[i] = hw_stats->tx_len[i];
+			stats->hist[i] = u64_stats_read(&hw_stats->rx_len[i]);
+			stats->hist_tx[i] = u64_stats_read(&hw_stats->tx_len[i]);
 		}
 	} while (u64_stats_fetch_retry(&port->stats.syncp, start));
 }
diff --git a/drivers/net/ethernet/airoha/airoha_eth.h b/drivers/net/ethernet/airoha/airoha_eth.h
index 20e602d61e61..b2e9bd849f8b 100644
--- a/drivers/net/ethernet/airoha/airoha_eth.h
+++ b/drivers/net/ethernet/airoha/airoha_eth.h
@@ -215,24 +215,24 @@ struct airoha_hw_stats {
 	struct u64_stats_sync syncp;
 
 	/* get_stats64 */
-	u64 rx_ok_pkts;
-	u64 tx_ok_pkts;
-	u64 rx_ok_bytes;
-	u64 tx_ok_bytes;
-	u64 rx_multicast;
-	u64 rx_errors;
-	u64 rx_drops;
-	u64 tx_drops;
-	u64 rx_crc_error;
-	u64 rx_over_errors;
+	u64_stats_t rx_ok_pkts;
+	u64_stats_t tx_ok_pkts;
+	u64_stats_t rx_ok_bytes;
+	u64_stats_t tx_ok_bytes;
+	u64_stats_t rx_multicast;
+	u64_stats_t rx_errors;
+	u64_stats_t rx_drops;
+	u64_stats_t tx_drops;
+	u64_stats_t rx_crc_error;
+	u64_stats_t rx_over_errors;
 	/* ethtool stats */
-	u64 tx_broadcast;
-	u64 tx_multicast;
-	u64 tx_len[7];
-	u64 rx_broadcast;
-	u64 rx_fragment;
-	u64 rx_jabber;
-	u64 rx_len[7];
+	u64_stats_t tx_broadcast;
+	u64_stats_t tx_multicast;
+	u64_stats_t tx_len[7];
+	u64_stats_t rx_broadcast;
+	u64_stats_t rx_fragment;
+	u64_stats_t rx_jabber;
+	u64_stats_t rx_len[7];
 };
 
 enum {
-- 
2.51.0


