Return-Path: <netdev+bounces-287321-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ULuWA+eaA2o78AEAu9opvQ
	(envelope-from <netdev+bounces-287321-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 23:25:59 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5119C52A40E
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 23:25:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3AC20310BE7C
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 21:22:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15FEC3803F7;
	Tue, 12 May 2026 21:22:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="cdhEGQE2"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f226.google.com (mail-qt1-f226.google.com [209.85.160.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32B5B30C366
	for <netdev@vger.kernel.org>; Tue, 12 May 2026 21:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778620924; cv=none; b=l/DD8zzA4RBxByovkumlWlMyS7i8kPYvy7XAFQP/2/QWZJP9G1BXf7Cj9hnUfxvtVXzqaee2HIvr/UsTqYgY7NjIDkMI7TqNOLMqLbpPF8Y76ofxKL1oi8Zmt4F52SVscV203PUPtOSwsFyxpfwmPNZtFjhoIJl3lODRvSsFFyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778620924; c=relaxed/simple;
	bh=KBvQWpAXL/+CROUdIY+5FDMaJGZP8LzQocgtxLDnZFg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LeIsOHL4JkZ/dzWZAK5udn3unhouRrTJXuBgU9GpZIck85OSVXwbub70+si1dAKcUqHAbC5rRZGWWIl/nOINjfOwYexdKqHjHOy0KxxYFpB33BvW8y4TSn/eksEqO2SkRdAIfxtsRlVRN473hp5sH4hW93C9wrwfq0zVR5m8Olg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=cdhEGQE2; arc=none smtp.client-ip=209.85.160.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-qt1-f226.google.com with SMTP id d75a77b69052e-50d87610513so59066271cf.3
        for <netdev@vger.kernel.org>; Tue, 12 May 2026 14:22:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778620921; x=1779225721;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WWjzv0Muu0vJ2xqgJgvAQaWur+BaJjcwFnKjHQI3BNI=;
        b=hEz862Ybs4A0oL28tgCquYYWTK+3nArg+Ro9vsQbTNVSiCX8CWEY8MqIMNnv/bDjV2
         Is98HYvnKCkzl69acQcnXzLFNbAQYhsCkiGgAmIRr/SsQYenQkedHwj0BhK7j91+KbGY
         xEUHzP/WHJ+WpS4vIRsFtBDUl3gF5PWWfg36BZa3POtyllUUU9arGsruIQyu+qAzexKm
         +cjIwUPTq3XK5XL2pNUfJFDmIu6AH+/KEu8H6E9gtfmXmR5VQ9ktxU8Qqs/xxi2ADM+3
         2atseWoXsBWgJy+NGWXDZ4Fdg4+a0WLa/CJ0otC9KBjAnct0OYSNhTiXccL6OdBaFXys
         4mGg==
X-Gm-Message-State: AOJu0YwhEo8MRIIZLaiHNa63a9bDLB+rsM1XE54gTwLtVo6VScKySGnS
	pSPTvwuOfc5mQ1h3Uu8hM4g/xLULGDaoefGlIR4/YVl+rZKnTIyKnbxedLFp95vSywIrmypEckN
	cfCSwi40iJCm814lR5r7Ei9Wh/iTx/Tpk8TgMRQpLTNah+jKjxlKeu7vwJXdU2QFSN7lGG6S6Cg
	Lwx0uGeu651xTBrK7aj8dx1HbshmT3yr6H4RYEHMsnswtLMXpxeQqurTtcfo91uEyS6buFHHKmq
	fngRVphFys=
X-Gm-Gg: Acq92OEuKlzzCR2k7pWbY+UUhu+2Hlf0DBZxIFm5Y39sQCXfbXifErpqJvpImjhraRA
	MW7P6l/NWxXa8uSTqYWiMp6WUdciMyL05loOhVIU5S0ZNcoEs39ZYE7Udmn+qDoujsCg+Vt3Ftk
	2Mc+PEV+MAEeWTRkIqmCEFkC8oLUKOALAGvJ/Yn3Zv4VNTVgGSc7bpo5lyGikK8hNEA+jfsY+wc
	yz/NpksaY8aDyccPasIHI5LHdqYvfkZiCcl3Blig21aApy6vSKcJYdcijeBArFxj0DbZ60TXDyF
	DNu5A/THQPY2Q64FzjjNwV5PeLShLliR7jX/YeKqbrPT/Cm38Ky/ZurNuv/7he4+9WKSPACdzDt
	kpM2Ry5/YPUs6GwAZfWYFR+R6JOYcnl5e6zUcjI7dEqBgWvtW1zv+A2rpo+I8xiwu+eU6eODpo7
	656+76qQs/W6Blit+4GBD9YERoXZ3OdcjjuGMOT941ruCMISlHcIJEdSlK
X-Received: by 2002:a05:622a:178c:b0:509:35d1:ca3c with SMTP id d75a77b69052e-5162fe0908dmr2686401cf.5.1778620920982;
        Tue, 12 May 2026 14:22:00 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-16.dlp.protect.broadcom.com. [144.49.247.16])
        by smtp-relay.gmail.com with ESMTPS id d75a77b69052e-514961d5f34sm7452741cf.5.2026.05.12.14.21.59
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 May 2026 14:22:00 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-dl1-f69.google.com with SMTP id a92af1059eb24-1329791f18fso8193536c88.1
        for <netdev@vger.kernel.org>; Tue, 12 May 2026 14:21:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1778620918; x=1779225718; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WWjzv0Muu0vJ2xqgJgvAQaWur+BaJjcwFnKjHQI3BNI=;
        b=cdhEGQE2D25rSIWljnGftm0FGIdpc1YP6Ht6WXZvFcrgPmB3cLYfLX0zYe+OQxwrVQ
         ENQFSWDqoGZrH9gm299583AsGHNenFLcSr9LJFFJDpSvjf4EmnUbs1fyvmuo5tzgifry
         HP6pnf2mnJW2flqqJADR6NU2lamOOREqKLyYA=
X-Received: by 2002:a05:7022:672a:b0:12d:b396:eaed with SMTP id a92af1059eb24-1349a703b22mr76183c88.9.1778620917913;
        Tue, 12 May 2026 14:21:57 -0700 (PDT)
X-Received: by 2002:a05:7022:672a:b0:12d:b396:eaed with SMTP id a92af1059eb24-1349a703b22mr76141c88.9.1778620916771;
        Tue, 12 May 2026 14:21:56 -0700 (PDT)
Received: from lvnvda3289.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-132787673ffsm26603202c88.15.2026.05.12.14.21.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2026 14:21:55 -0700 (PDT)
From: Michael Chan <michael.chan@broadcom.com>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	pavan.chebbi@broadcom.com,
	andrew.gospodarek@broadcom.com,
	Ajit Khaparde <ajit.khaparde@broadcom.com>
Subject: [PATCH net-next v2 13/15] bnxt_en: Implement kTLS TX normal path
Date: Tue, 12 May 2026 14:21:03 -0700
Message-ID: <20260512212105.3488258-14-michael.chan@broadcom.com>
X-Mailer: git-send-email 2.45.4
In-Reply-To: <20260512212105.3488258-1-michael.chan@broadcom.com>
References: <20260512212105.3488258-1-michael.chan@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
X-Rspamd-Queue-Id: 5119C52A40E
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[broadcom.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[michael.chan@broadcom.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-287321-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[broadcom.com:email,broadcom.com:mid,broadcom.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-0.999];
	DKIM_TRACE(0.00)[broadcom.com:+];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action

Offload TLS encryption of TX packets to the hardware if the TCP sequence
number is the expected one.  Fall back to software encryption otherwise.
Implement all the TLS TX logic to check the TCP sequence number and set
up the BD in the new function bnxt_ktls_xmit().

Basic kTLS statistics reporting for ethtool -S is also added.  The next
patches will add support for the exception path with out-of-order TCP
sequence number.

Reviewed-by: Ajit Khaparde <ajit.khaparde@broadcom.com>
Reviewed-by: Pavan Chebbi <pavan.chebbi@broadcom.com>
Signed-off-by: Michael Chan <michael.chan@broadcom.com>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c     | 10 +++-
 drivers/net/ethernet/broadcom/bnxt/bnxt.h     | 39 +++++++++++++--
 .../net/ethernet/broadcom/bnxt/bnxt_crypto.c  |  1 +
 .../net/ethernet/broadcom/bnxt/bnxt_ethtool.c | 45 +++++++++++++++++
 drivers/net/ethernet/broadcom/bnxt/bnxt_gso.c |  2 +-
 .../net/ethernet/broadcom/bnxt/bnxt_ktls.c    | 49 +++++++++++++++++++
 .../net/ethernet/broadcom/bnxt/bnxt_ktls.h    | 38 ++++++++++++++
 7 files changed, 177 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index e26980814fe7..7cae7e3024ab 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -488,6 +488,7 @@ static netdev_tx_t bnxt_start_xmit(struct sk_buff *skb, struct net_device *dev)
 	struct bnxt_sw_tx_bd *tx_buf;
 	__le32 lflags = 0;
 	skb_frag_t *frag;
+	u32 kid = 0;
 
 	i = skb_get_queue_mapping(skb);
 	if (unlikely(i >= bp->tx_nr_rings)) {
@@ -527,6 +528,10 @@ static netdev_tx_t bnxt_start_xmit(struct sk_buff *skb, struct net_device *dev)
 			return NETDEV_TX_BUSY;
 	}
 
+	skb = bnxt_ktls_xmit(bp, txr, skb, &lflags, &kid);
+	if (unlikely(!skb))
+		return NETDEV_TX_OK;
+
 	length = skb->len;
 	len = skb_headlen(skb);
 	last_frag = skb_shinfo(skb)->nr_frags;
@@ -675,7 +680,7 @@ static netdev_tx_t bnxt_start_xmit(struct sk_buff *skb, struct net_device *dev)
 
 	prod = NEXT_TX(prod);
 	txbd1 = bnxt_init_ext_bd(bp, txr, prod, lflags, vlan_tag_flags,
-				 cfa_action);
+				 cfa_action, kid);
 
 	if (skb_is_gso(skb)) {
 		bool udp_gso = !!(skb_shinfo(skb)->gso_type & SKB_GSO_UDP_L4);
@@ -698,7 +703,8 @@ static netdev_tx_t bnxt_start_xmit(struct sk_buff *skb, struct net_device *dev)
 					TX_BD_FLAGS_T_IPID |
 					(hdr_len << (TX_BD_HSIZE_SHIFT - 1)));
 		length = skb_shinfo(skb)->gso_size;
-		txbd1->tx_bd_mss = cpu_to_le32(length);
+		txbd1->tx_bd_kid_mss = cpu_to_le32(BNXT_TX_KID_HI(kid) |
+						   length);
 		length += hdr_len;
 	} else if (skb->ip_summed == CHECKSUM_PARTIAL) {
 		txbd1->tx_bd_hsize_lflags |=
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.h b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
index a947b9420a7a..ab3a86634a20 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.h
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
@@ -101,10 +101,18 @@ struct tx_bd_ext {
 	#define TX_BD_FLAGS_LSO					(1 << 5)
 	#define TX_BD_FLAGS_IPID_FMT				(1 << 6)
 	#define TX_BD_FLAGS_T_IPID				(1 << 7)
+	#define TX_BD_FLAGS_CRYPTO_EN				(1 << 15)
 	#define TX_BD_HSIZE					(0xff << 16)
 	 #define TX_BD_HSIZE_SHIFT				 16
-
-	__le32 tx_bd_mss;
+	#define TX_BD_KID_LO					(0x7f << 25)
+	 #define TX_BD_KID_LO_MASK				 0x7f
+	 #define TX_BD_KID_LO_SHIFT				 25
+
+	__le32 tx_bd_kid_mss;
+	#define TX_BD_MSS					0x7fff
+	#define TX_BD_KID_HI					(0x1ffff << 15)
+	 #define TX_BD_KID_HI_MASK				 0xffff80
+	 #define TX_BD_KID_HI_SHIFT				 8
 	__le32 tx_bd_cfa_action;
 	#define TX_BD_CFA_ACTION				(0xffff << 16)
 	 #define TX_BD_CFA_ACTION_SHIFT				 16
@@ -122,6 +130,16 @@ struct tx_bd_ext {
 };
 
 #define BNXT_TX_PTP_IS_SET(lflags) ((lflags) & cpu_to_le32(TX_BD_FLAGS_STAMP))
+#define BNXT_TX_KID_LO(kid) (((kid) & TX_BD_KID_LO_MASK) << TX_BD_KID_LO_SHIFT)
+#define BNXT_TX_KID_HI(kid) (((kid) & TX_BD_KID_HI_MASK) << TX_BD_KID_HI_SHIFT)
+
+struct tx_bd_presync {
+	__le32 tx_bd_len_flags_type;
+	 #define TX_BD_TYPE_PRESYNC_TX_BD			 (0x09 << 0)
+	u32 tx_bd_opaque;
+	__le32 tx_bd_kid;
+	u32 tx_bd_unused;
+};
 
 struct rx_bd {
 	__le32 rx_bd_len_flags_type;
@@ -1165,10 +1183,23 @@ struct bnxt_cmn_sw_stats {
 	u64			missed_irqs;
 };
 
+/* Data plane kTLS counters */
+enum bnxt_ktls_data_counters {
+	BNXT_KTLS_TX_PKTS = 0,
+	BNXT_KTLS_TX_BYTES,
+
+	BNXT_KTLS_MAX_DATA_COUNTERS,
+};
+
+struct bnxt_tls_sw_stats {
+	u64	counters[BNXT_KTLS_MAX_DATA_COUNTERS];
+};
+
 struct bnxt_sw_stats {
 	struct bnxt_rx_sw_stats rx;
 	struct bnxt_tx_sw_stats tx;
 	struct bnxt_cmn_sw_stats cmn;
+	struct bnxt_tls_sw_stats tls;
 };
 
 struct bnxt_total_ring_drv_stats {
@@ -2878,14 +2909,14 @@ static inline u32 bnxt_tx_avail(struct bnxt *bp,
 static inline struct tx_bd_ext *
 bnxt_init_ext_bd(struct bnxt *bp, struct bnxt_tx_ring_info *txr,
 		 u16 prod, __le32 lflags, u32 vlan_tag_flags,
-		 u32 cfa_action)
+		 u32 cfa_action, u32 kid)
 {
 	struct tx_bd_ext *txbd1;
 
 	txbd1 = (struct tx_bd_ext *)
 		&txr->tx_desc_ring[TX_RING(bp, prod)][TX_IDX(prod)];
 	txbd1->tx_bd_hsize_lflags = lflags;
-	txbd1->tx_bd_mss = 0;
+	txbd1->tx_bd_kid_mss = cpu_to_le32(BNXT_TX_KID_HI(kid));
 	txbd1->tx_bd_cfa_meta = cpu_to_le32(vlan_tag_flags);
 	txbd1->tx_bd_cfa_action =
 		cpu_to_le32(cfa_action << TX_BD_CFA_ACTION_SHIFT);
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_crypto.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_crypto.c
index 6e424eb80630..7959d8459593 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_crypto.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_crypto.c
@@ -533,6 +533,7 @@ int bnxt_crypto_init(struct bnxt *bp)
 	if (rc)
 		return rc;
 
+	bnxt_ktls_init(bp);
 	return 0;
 }
 
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
index 11cb1b841359..66b323e94140 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
@@ -38,6 +38,7 @@
 #include "bnxt_fw_hdr.h"	/* Firmware hdr constant and structure defs */
 #include "bnxt_coredump.h"
 #include "bnxt_mpc.h"
+#include "bnxt_ktls.h"
 
 #define BNXT_NVM_ERR_MSG(dev, extack, msg)			\
 	do {							\
@@ -354,6 +355,25 @@ static const char *const bnxt_ring_drv_stats_arr[] = {
 	"total_missed_irqs",
 };
 
+/* kTLS data plane counter strings indexed by enum bnxt_ktls_data_counters */
+static const char *const bnxt_ktls_data_stats[] = {
+	[BNXT_KTLS_TX_PKTS]		= "tx_tls_encrypted_packets",
+	[BNXT_KTLS_TX_BYTES]		= "tx_tls_encrypted_bytes",
+};
+
+/* kTLS control plane counter strings indexed by enum bnxt_ktls_ctrl_counters */
+static const char *const bnxt_ktls_ctrl_stats[] = {
+	[BNXT_KTLS_TX_ADD]			= "tx_tls_ctx",
+	[BNXT_KTLS_TX_DEL]			= "tx_tls_del",
+	[BNXT_KTLS_ERR_NO_MEM]			= "tls_err_no_mem",
+	[BNXT_KTLS_ERR_KEY_CTX_ALLOC]		= "tls_err_key_ctx_alloc",
+	[BNXT_KTLS_ERR_CRYPTO_CMD]		= "tls_err_crypto_cmd",
+	[BNXT_KTLS_ERR_DEVICE_BUSY]		= "tls_err_device_busy",
+	[BNXT_KTLS_ERR_INVALID_CIPHER]		= "tls_err_invalid_cipher",
+	[BNXT_KTLS_ERR_STATE_NOT_OPEN]		= "tls_err_state_not_open",
+	[BNXT_KTLS_ERR_RETRY_EXCEEDED]		= "tls_err_retry_exceeded",
+};
+
 #define NUM_RING_RX_SW_STATS		ARRAY_SIZE(bnxt_rx_sw_stats_str)
 #define NUM_RING_CMN_SW_STATS		ARRAY_SIZE(bnxt_cmn_sw_stats_str)
 #define NUM_RING_RX_HW_STATS		ARRAY_SIZE(bnxt_ring_rx_stats_str)
@@ -536,12 +556,21 @@ static int bnxt_get_num_ring_stats(struct bnxt *bp)
 	       cmn * bp->cp_nr_rings;
 }
 
+static int bnxt_get_num_ktls_stats(struct bnxt *bp)
+{
+	if (!bp->ktls_info)
+		return 0;
+	return ARRAY_SIZE(bnxt_ktls_ctrl_stats) +
+	       ARRAY_SIZE(bnxt_ktls_data_stats);
+}
+
 static int bnxt_get_num_stats(struct bnxt *bp)
 {
 	int num_stats = bnxt_get_num_ring_stats(bp);
 	int len;
 
 	num_stats += BNXT_NUM_RING_DRV_STATS;
+	num_stats += bnxt_get_num_ktls_stats(bp);
 
 	if (bp->flags & BNXT_FLAG_PORT_STATS)
 		num_stats += BNXT_NUM_PORT_STATS;
@@ -653,6 +682,16 @@ static void bnxt_get_ethtool_stats(struct net_device *dev,
 	for (i = 0; i < BNXT_NUM_RING_DRV_STATS; i++, j++, curr++, prev++)
 		buf[j] = *curr + *prev;
 
+	if (bp->ktls_info) {
+		struct bnxt_tls_info *ktls = bp->ktls_info;
+		struct bnxt_tls_sw_stats tls_stats = {};
+
+		bnxt_get_ring_tls_stats(bp, &tls_stats);
+		for (i = 0; i < ARRAY_SIZE(bnxt_ktls_data_stats); i++, j++)
+			buf[j] = tls_stats.counters[i];
+		for (i = 0; i < ARRAY_SIZE(bnxt_ktls_ctrl_stats); i++, j++)
+			buf[j] = atomic64_read(&ktls->counters[i]);
+	}
 	if (bp->flags & BNXT_FLAG_PORT_STATS) {
 		u64 *port_stats = bp->port_stats.sw_stats;
 
@@ -763,6 +802,12 @@ static void bnxt_get_strings(struct net_device *dev, u32 stringset, u8 *buf)
 		for (i = 0; i < BNXT_NUM_RING_DRV_STATS; i++)
 			ethtool_puts(&buf, bnxt_ring_drv_stats_arr[i]);
 
+		if (bp->ktls_info) {
+			for (i = 0; i < ARRAY_SIZE(bnxt_ktls_data_stats); i++)
+				ethtool_puts(&buf, bnxt_ktls_data_stats[i]);
+			for (i = 0; i < ARRAY_SIZE(bnxt_ktls_ctrl_stats); i++)
+				ethtool_puts(&buf, bnxt_ktls_ctrl_stats[i]);
+		}
 		if (bp->flags & BNXT_FLAG_PORT_STATS)
 			for (i = 0; i < BNXT_NUM_PORT_STATS; i++) {
 				str = bnxt_port_stats_arr[i].string;
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_gso.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_gso.c
index f317f60414e8..b4c37a6c9f0f 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_gso.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_gso.c
@@ -168,7 +168,7 @@ netdev_tx_t bnxt_sw_udp_gso_xmit(struct bnxt *bp,
 
 		prod = NEXT_TX(prod);
 		bnxt_init_ext_bd(bp, txr, prod, csum,
-				 vlan_tag_flags, cfa_action);
+				 vlan_tag_flags, cfa_action, 0);
 
 		/* set dma_unmap_len on the LAST BD touching each
 		 * region. Since completions are in-order, the last segment
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_ktls.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_ktls.c
index ac5d927ded1c..263b075af621 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_ktls.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_ktls.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /* Copyright (c) 2026 Broadcom Inc. */
 
+#include <linux/tcp.h>
 #include <net/tls.h>
 #include <linux/bnxt/hsi.h>
 
@@ -287,3 +288,51 @@ int bnxt_ktls_init(struct bnxt *bp)
 	dev->features |= NETIF_F_HW_TLS_TX;
 	return 0;
 }
+
+struct sk_buff *bnxt_ktls_xmit(struct bnxt *bp, struct bnxt_tx_ring_info *txr,
+			       struct sk_buff *skb, __le32 *lflags, u32 *kid)
+{
+	struct bnxt_sw_stats *sw_stats = txr->tx_cpr->sw_stats;
+	struct bnxt_tls_info *ktls = bp->ktls_info;
+	struct bnxt_ktls_offload_ctx_tx *kctx_tx;
+	struct tls_context *tls_ctx;
+	u32 seq, payload_len;
+
+	if (!IS_ENABLED(CONFIG_TLS_DEVICE) || !ktls ||
+	    !tls_is_skb_tx_device_offloaded(skb))
+		return skb;
+
+	seq = ntohl(tcp_hdr(skb)->seq);
+	tls_ctx = tls_get_ctx(skb->sk);
+	kctx_tx = __tls_driver_ctx(tls_ctx, TLS_OFFLOAD_CTX_DIR_TX);
+	payload_len = skb->len - skb_tcp_all_headers(skb);
+	if (!payload_len)
+		return skb;
+	if (kctx_tx->tcp_seq_no == seq) {
+		kctx_tx->tcp_seq_no += payload_len;
+		*kid = BNXT_KID_HW(kctx_tx->kid);
+		*lflags |= cpu_to_le32(TX_BD_FLAGS_CRYPTO_EN |
+				       BNXT_TX_KID_LO(*kid));
+		sw_stats->tls.counters[BNXT_KTLS_TX_PKTS]++;
+		sw_stats->tls.counters[BNXT_KTLS_TX_BYTES] += payload_len;
+	} else {
+		skb = tls_encrypt_skb(skb);
+		if (!skb)
+			return NULL;
+	}
+	return skb;
+}
+
+void bnxt_get_ring_tls_stats(struct bnxt *bp, struct bnxt_tls_sw_stats *stats)
+{
+	struct bnxt_tls_sw_stats *ring_stats;
+	int i, j;
+
+	if (!bp->ktls_info)
+		return;
+	for (i = 0; i < bp->cp_nr_rings; i++) {
+		ring_stats = &bp->bnapi[i]->cp_ring.sw_stats->tls;
+		for (j = 0; j < BNXT_KTLS_MAX_DATA_COUNTERS; j++)
+			stats->counters[j] += ring_stats->counters[j];
+	}
+}
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_ktls.h b/drivers/net/ethernet/broadcom/bnxt/bnxt_ktls.h
index 6b8a1b1eeb24..3a02074c4e86 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_ktls.h
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_ktls.h
@@ -63,6 +63,28 @@ struct ce_add_cmd {
 	u8	addl_iv[8];
 };
 
+struct crypto_prefix_cmd {
+	__le32	flags;
+	#define CRYPTO_PREFIX_CMD_FLAGS_UPDATE_IN_ORDER_VAR	0x1UL
+	#define CRYPTO_PREFIX_CMD_FLAGS_FULL_REPLAY_RETRAN	0x2UL
+	__le32	header_tcp_seq_num;
+	__le32	start_tcp_seq_num;
+	__le32	end_tcp_seq_num;
+	u8	explicit_nonce[8];
+	u8	record_seq_num[8];
+};
+
+#define CRYPTO_PREFIX_CMD_FLAGS_UPDATE_IN_ORDER_VAR_LE	\
+	cpu_to_le32(CRYPTO_PREFIX_CMD_FLAGS_UPDATE_IN_ORDER_VAR)
+
+#define CRYPTO_PREFIX_CMD_SIZE	((u32)sizeof(struct crypto_prefix_cmd))
+#define CRYPTO_PREFIX_CMD_BDS	(CRYPTO_PREFIX_CMD_SIZE / sizeof(struct tx_bd))
+#define CRYPTO_PRESYNC_BDS	(CRYPTO_PREFIX_CMD_BDS + 1)
+
+#define CRYPTO_PRESYNC_BD_CMD						\
+	(cpu_to_le32((CRYPTO_PREFIX_CMD_SIZE << TX_BD_LEN_SHIFT) |	\
+		     TX_BD_CNT(CRYPTO_PRESYNC_BDS) | TX_BD_TYPE_PRESYNC_TX_BD))
+
 static inline bool bnxt_ktls_busy(struct bnxt *bp)
 {
 	return bp->ktls_info && atomic_read(&bp->ktls_info->pending) > 0;
@@ -72,6 +94,9 @@ static inline bool bnxt_ktls_busy(struct bnxt *bp)
 int bnxt_alloc_ktls_info(struct bnxt *bp);
 void bnxt_free_ktls_info(struct bnxt *bp);
 int bnxt_ktls_init(struct bnxt *bp);
+struct sk_buff *bnxt_ktls_xmit(struct bnxt *bp, struct bnxt_tx_ring_info *txr,
+			       struct sk_buff *skb, __le32 *lflags, u32 *kid);
+void bnxt_get_ring_tls_stats(struct bnxt *bp, struct bnxt_tls_sw_stats *stats);
 #else
 static inline int bnxt_alloc_ktls_info(struct bnxt *bp)
 {
@@ -86,5 +111,18 @@ static inline int bnxt_ktls_init(struct bnxt *bp)
 {
 	return -EOPNOTSUPP;
 }
+
+static inline struct sk_buff *bnxt_ktls_xmit(struct bnxt *bp,
+					     struct bnxt_tx_ring_info *txr,
+					     struct sk_buff *skb,
+					     __le32 *lflags, u32 *kid)
+{
+	return skb;
+}
+
+static inline void bnxt_get_ring_tls_stats(struct bnxt *bp,
+					   struct bnxt_tls_sw_stats *stats)
+{
+}
 #endif	/* CONFIG_BNXT_TLS */
 #endif	/* BNXT_KTLS_H */
-- 
2.51.0


