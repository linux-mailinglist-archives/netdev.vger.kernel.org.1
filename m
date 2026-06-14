Return-Path: <netdev+bounces-299135-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id zrnZCpknLmrAqAQAu9opvQ
	(envelope-from <netdev+bounces-299135-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 14 Jun 2026 06:01:29 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id C7381680507
	for <lists+netdev@lfdr.de>; Sun, 14 Jun 2026 06:01:28 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=VNDL4TUC;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-299135-lists+netdev=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netdev+bounces-299135-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id CD8A530071E2
	for <lists+netdev@lfdr.de>; Sun, 14 Jun 2026 04:01:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75A63263C8C;
	Sun, 14 Jun 2026 04:01:21 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F08D9261B70
	for <netdev@vger.kernel.org>; Sun, 14 Jun 2026 04:01:17 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781409681; cv=none; b=DfSNUUwQDH7JHvE6w+ZrJfgV1pIfnBCTs9yGfJZ5ut/T1J8TBVtgvFm271ORAtvVaSZQTOO74YsrTOtoK4etscfoGR92FOTFSw5+qb+sdJBOToE6tkVg3jdFB0mQG1Vbp36fCYTRw5mY0XM5dQ7AWm5hnQgFLZ0m2Qq7o8Xyqho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781409681; c=relaxed/simple;
	bh=QDgfAV4VBjShdSESxH1eFBl7V9Lj53vDxoAG9moo0F8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sLnQs61XSClKHzLsjD6vN9V/UJ3Uu+xSA3swz7D7HuLajoewF431n3bPBUoeAMjrrRVMPZRfwJ5XiWSBf0yu2RZLnOOeNiVrVm/4iabgSaWL38tgTdKDSVrPlwah678NRdFDoMCCESmPd3XRFMrx3uSpz/YXYq0aJRNSrWns4NM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VNDL4TUC; arc=none smtp.client-ip=209.85.215.176
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-c858cc9870aso1287235a12.0
        for <netdev@vger.kernel.org>; Sat, 13 Jun 2026 21:01:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781409677; x=1782014477; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sfS15OIw8F67UTIuCjAbHMvDnlrrFLgfmf6W19AaH38=;
        b=VNDL4TUCbFdgysEhDFFC3n9PDNhf7xSZd+5w8c7237fF+n7bRvuYhIzwhlR3qOD3VY
         8tBsnBaTCiTZlj5eqN6xNyUqAiqX2LJU/qcTlt0foH2NCr4wPEHcrwtb3ov5ovCyUR7D
         9vX2ruCii4oaoH5iRWvSEKWdmupQKswQLMwT1MTGV8HiUFQj0t4iz5Wy/dztfdqWAQYv
         PTY/Wb9Yk7XG6qHS3LKVvl73dkIY6iWSILrizUES2yQI/79tBXXCcVjqZXhnZsT0+4eH
         dDraNXWvL+MsAcR9+futA9ZSMxssNUrie72qguHokgyYhkqxvSQvvYFSmtCCqDsUGEUy
         mGdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781409677; x=1782014477;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=sfS15OIw8F67UTIuCjAbHMvDnlrrFLgfmf6W19AaH38=;
        b=dOrWMqzqWpLkDEpoyZI17b1P9U4WzjA+Lni8OZzpRrPl5QwApP62P2XTVoH/a7+fwE
         zErv4NEXTyLB6TKoj1G29Uf5g4kvLN1/NVvq7BfsJkf1t8NCtjUx5NHxZdcOT7k/sYFQ
         K1uof7vpaBjVwc7xvhl5TXbF6oj3adIqjT0/021kqaslmEOXO4kF+meFJ9CyN0R6GrS4
         s+EuMJp1MIBJbyDxVcd5PFI8a9U+CFF/zzSl3LaPq5638BSMtgGllg3sZwBcYF+zz7i3
         laWpaDRcZ70FKdpugObRBy3k0Z8pFpxnI52COKhFbZtRyBW/W+mnYoOHyp1F8wqiNhlf
         Vp8Q==
X-Gm-Message-State: AOJu0YyfpZ/dBSK/3o34LPyr/90hrVvLmBDsjdg/q2dBgnjNUtnjDhKm
	SrX/jjyPEhyIzxaWeR2WmZViXn4SR6gCtAM+NdMbnTpOv8gWu48IMvI+cdP/yEeR
X-Gm-Gg: Acq92OFQjxk6gdeYxaDDmGXr2IrIgflIP3ANKOgtqkLB6jB4DhmuD/Af2Du9AQBoiMy
	EsSyeuwm6gHZLYwK3SlTQiFEatzBDMwgxtmbOdG8m0bza9jXq+XgUhoqngtv8uUcm6i0RCcQ2RG
	DMcxKh89P0nBvw+WijnWGnHy2Tz6dx+sI5UvPYCeaCR84pBXRwKXlQx5QipGqP1MiTNIBvtm/rm
	jDfbvBKVqCs7+kxV82bQJ7ykSdlwINRUSzbnK8+mVnd92+LbJTSCvfP100L8lXE1AIFjVANB1kI
	DVe5d6hYwhpdtMMkwc1YQiFCPWcqDm1W3woJ08fTfutYFoOsvV2ctvnG3FrKRJORHp4L/p2jjSk
	AvO9HlUqnBkopeO0oNivRkCiWVWlnxdTEB3gaztzXBolh2qdOZql6KFmIBEp0/wghF5mxcH8Z3L
	0pi7wUV/pyB4UcNu2Q8Uk=
X-Received: by 2002:a05:6a20:7f99:b0:3b4:701f:a0ee with SMTP id adf61e73a8af0-3b785853bacmr7986958637.19.1781409677262;
        Sat, 13 Jun 2026 21:01:17 -0700 (PDT)
Received: from mincom1 ([115.4.79.42])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c8661a67603sm5676983a12.0.2026.06.13.21.01.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Jun 2026 21:01:16 -0700 (PDT)
From: Jihong Min <hurryman2212@gmail.com>
To: netdev@vger.kernel.org,
	Lorenzo Bianconi <lorenzo@kernel.org>
Cc: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Simon Horman <horms@kernel.org>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Steffen Klassert <steffen.klassert@secunet.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	devicetree@vger.kernel.org,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	Christian Marangi <ansuelsmth@gmail.com>,
	Felix Fietkau <nbd@nbd.name>,
	linux-kernel@vger.kernel.org,
	Jihong Min <hurryman2212@gmail.com>
Subject: [RFC PATCH net-next 4/7] net: airoha: add SOE registers and driver state
Date: Sun, 14 Jun 2026 13:00:29 +0900
Message-ID: <20260614040032.1567994-5-hurryman2212@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260614040032.1567994-1-hurryman2212@gmail.com>
References: <20260614040032.1567994-1-hurryman2212@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-299135-lists,netdev=lfdr.de];
	FORGED_SENDER(0.00)[hurryman2212@gmail.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,redhat.com,lunn.ch,gondor.apana.org.au,secunet.com,vger.kernel.org,gmail.com,collabora.com,lists.infradead.org,nbd.name];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[22];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:lorenzo@kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:andrew+netdev@lunn.ch,m:horms@kernel.org,m:herbert@gondor.apana.org.au,m:steffen.klassert@secunet.com,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:devicetree@vger.kernel.org,m:matthias.bgg@gmail.com,m:angelogioacchino.delregno@collabora.com,m:linux-arm-kernel@lists.infradead.org,m:linux-mediatek@lists.infradead.org,m:ansuelsmth@gmail.com,m:nbd@nbd.name,m:linux-kernel@vger.kernel.org,m:hurryman2212@gmail.com,m:andrew@lunn.ch,m:krzk@kernel.org,m:conor@kernel.org,m:matthiasbgg@gmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hurryman2212@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C7381680507

Add the FE/PPE/QDMA register definitions and shared driver state needed
by the Secure Offload Engine. Add a small SOE-facing header with stubs so
later Ethernet and PPE changes remain buildable until the provider is
enabled.

Signed-off-by: Jihong Min <hurryman2212@gmail.com>
---
 drivers/net/ethernet/airoha/airoha_eth.h  |  40 +++++++
 drivers/net/ethernet/airoha/airoha_regs.h |  16 +++
 drivers/net/ethernet/airoha/airoha_soe.h  | 126 ++++++++++++++++++++++
 3 files changed, 182 insertions(+)
 create mode 100644 drivers/net/ethernet/airoha/airoha_soe.h

diff --git a/drivers/net/ethernet/airoha/airoha_eth.h b/drivers/net/ethernet/airoha/airoha_eth.h
index 46b1c31939de..c5f09aedd7e7 100644
--- a/drivers/net/ethernet/airoha/airoha_eth.h
+++ b/drivers/net/ethernet/airoha/airoha_eth.h
@@ -16,6 +16,8 @@
 #include <linux/soc/airoha/airoha_offload.h>
 #include <net/dsa.h>
 
+struct airoha_soe;
+
 #define AIROHA_MAX_NUM_GDM_PORTS	4
 #define AIROHA_MAX_NUM_GDM_DEVS		2
 #define AIROHA_MAX_NUM_QDMA		2
@@ -189,18 +191,31 @@ struct airoha_queue {
 	spinlock_t lock;
 	struct airoha_queue_entry *entry;
 	struct airoha_qdma_desc *desc;
+	/* Preserved for RX ring reprogramming; dmam_alloc_coherent() owns it. */
+	dma_addr_t desc_dma;
 	u16 head;
 	u16 tail;
 
 	int queued;
 	int ndesc;
+	/* SOE RX rings may use coherent slots instead of page_pool fragments. */
+	int rx_alloc_ndesc;
 	int free_thr;
 	int buf_size;
 	bool txq_stopped;
+	bool rx_coherent;
+	bool rx_drop_chain;
+	void *rx_coherent_buf;
+	dma_addr_t rx_coherent_dma;
+	size_t rx_coherent_buf_size;
 
 	struct napi_struct napi;
 	struct page_pool *page_pool;
 	struct sk_buff *skb;
+	/* First SOE descriptor metadata is kept while a scattered frame is built. */
+	int rx_frame_descs;
+	u32 soe_rx_msg0;
+	u32 soe_rx_msg2;
 
 	struct list_head tx_list;
 };
@@ -434,6 +449,16 @@ struct airoha_foe_stats64 {
 	u64 packets;
 };
 
+struct airoha_ppe_soe_meta {
+	unsigned long expires;
+	u32 key_hash;
+	u16 foe_hash;
+	u8 valid;
+	u8 sa_index;
+	u8 hop;
+	u8 seen;
+};
+
 struct airoha_flow_data {
 	struct ethhdr eth;
 
@@ -552,6 +577,11 @@ struct airoha_gdm_dev {
 
 	u32 flags;
 	int nbq;
+	/* Prevent toggling NETIF_F_HW_ESP while programmed SAs still exist. */
+	atomic_t soe_xfrm_state_count;
+	/* Private SOE submit path into this GDM's active QDMA instance. */
+	int (*soe_xmit_skb)(struct airoha_gdm_dev *dev, struct sk_buff *skb,
+			    u32 msg0, u32 msg1, u32 msg2);
 
 	struct airoha_hw_stats stats;
 };
@@ -581,6 +611,7 @@ struct airoha_ppe {
 
 	struct hlist_head *foe_flow;
 	u16 *foe_check_time;
+	struct airoha_ppe_soe_meta *soe_meta;
 
 	struct airoha_foe_stats *foe_stats;
 	dma_addr_t foe_stats_dma;
@@ -621,6 +652,7 @@ struct airoha_eth {
 
 	struct airoha_qdma qdma[AIROHA_MAX_NUM_QDMA];
 	struct airoha_gdm_port *ports[AIROHA_MAX_NUM_GDM_PORTS];
+	struct airoha_soe *soe;
 };
 
 u32 airoha_rr(void __iomem *base, u32 offset);
@@ -676,6 +708,14 @@ static inline bool airoha_is_7583(struct airoha_eth *eth)
 int airoha_get_fe_port(struct airoha_gdm_dev *dev);
 bool airoha_is_valid_gdm_dev(struct airoha_eth *eth,
 			     struct airoha_gdm_dev *dev);
+int airoha_qdma_xmit_skb(struct airoha_gdm_dev *dev, struct sk_buff *skb,
+			 u32 msg0, u32 msg1, u32 msg2);
+void airoha_ppe_soe_mark_skb(struct airoha_ppe_dev *dev, struct sk_buff *skb,
+			     u16 hash, u8 sa_index, u8 hop);
+bool airoha_ppe_soe_skb_marked(struct sk_buff *skb);
+void airoha_ppe_soe_xmit_skb(struct airoha_ppe_dev *dev, struct sk_buff *skb,
+			     struct net_device *netdev);
+void airoha_ppe_soe_flush_sa(struct airoha_ppe *ppe, u8 sa_index);
 
 void airoha_ppe_set_cpu_port(struct airoha_gdm_dev *dev, u8 ppe_id, u8 fport);
 bool airoha_ppe_is_enabled(struct airoha_eth *eth, int index);
diff --git a/drivers/net/ethernet/airoha/airoha_regs.h b/drivers/net/ethernet/airoha/airoha_regs.h
index 436f3c8779c1..27e158d0fa4b 100644
--- a/drivers/net/ethernet/airoha/airoha_regs.h
+++ b/drivers/net/ethernet/airoha/airoha_regs.h
@@ -82,6 +82,10 @@
 #define PSE_SHARE_USED_MTHD_MASK	GENMASK(31, 16)
 #define PSE_SHARE_USED_HTHD_MASK	GENMASK(15, 0)
 
+/* TDMA/SOE port 7 needs shared-buffer flow control enabled in the PSE. */
+#define REG_PSE_FC_CFG			0x0098
+#define PSE_TDMA_SHARE_BUF_DIS_MASK	BIT(23)
+
 #define REG_GDM_MISC_CFG		0x0148
 #define GDM2_RDM_ACK_WAIT_PREF_MASK	BIT(9)
 #define GDM2_CHN_VLD_MODE_MASK		BIT(5)
@@ -252,6 +256,8 @@
 #define PPE_GLO_CFG_EN_MASK			BIT(0)
 
 #define REG_PPE_PPE_FLOW_CFG(_n)		(((_n) ? PPE2_BASE : PPE1_BASE) + 0x204)
+#define PPE_FLOW_CFG_IP6_IPSEC_MASK		BIT(28)
+#define PPE_FLOW_CFG_IP4_IPSEC_MASK		BIT(27)
 #define PPE_FLOW_CFG_IP6_HASH_GRE_KEY_MASK	BIT(20)
 #define PPE_FLOW_CFG_IP4_HASH_GRE_KEY_MASK	BIT(19)
 #define PPE_FLOW_CFG_IP4_HASH_FLOW_LABEL_MASK	BIT(18)
@@ -851,6 +857,8 @@
 #define QDMA_DESC_NEXT_ID_MASK		GENMASK(15, 0)
 /* TX MSG0 */
 #define QDMA_ETH_TXMSG_MIC_IDX_MASK	BIT(30)
+/* SOE submit metadata: msg0 carries SA index, msg1 selects port 7 OQ8/OQ9. */
+#define QDMA_ETH_TXMSG_SOE_SA_MASK	GENMASK(29, 24)
 #define QDMA_ETH_TXMSG_SP_TAG_MASK	GENMASK(29, 14)
 #define QDMA_ETH_TXMSG_ICO_MASK		BIT(13)
 #define QDMA_ETH_TXMSG_UCO_MASK		BIT(12)
@@ -873,6 +881,11 @@
 
 /* RX MSG0 */
 #define QDMA_ETH_RXMSG_SPTAG		GENMASK(21, 14)
+/* SOE completion metadata can use the full 16-bit SP tag word. */
+#define QDMA_ETH_RXMSG_SPTAG_FULL	GENMASK(29, 14)
+/* SOE completion metadata returned by the QDMA RX descriptor. */
+#define QDMA_ETH_RXMSG_SOE_MASK		BIT(10)
+#define QDMA_ETH_RXMSG_HOP_FLAGS_MASK	GENMASK(2, 0)
 /* RX MSG1 */
 #define QDMA_ETH_RXMSG_DEI_MASK		BIT(31)
 #define QDMA_ETH_RXMSG_IP6_MASK		BIT(30)
@@ -883,6 +896,9 @@
 #define QDMA_ETH_RXMSG_SPORT_MASK	GENMASK(25, 21)
 #define QDMA_ETH_RXMSG_CRSN_MASK	GENMASK(20, 16)
 #define QDMA_ETH_RXMSG_PPE_ENTRY_MASK	GENMASK(15, 0)
+/* RX MSG2 */
+/* SW_UDF carries the SA index for SOE completion frames. */
+#define QDMA_ETH_RXMSG_SW_UDF_MASK	GENMASK(31, 24)
 
 struct airoha_qdma_desc {
 	__le32 rsv;
diff --git a/drivers/net/ethernet/airoha/airoha_soe.h b/drivers/net/ethernet/airoha/airoha_soe.h
new file mode 100644
index 000000000000..0bde2e9c6b5b
--- /dev/null
+++ b/drivers/net/ethernet/airoha/airoha_soe.h
@@ -0,0 +1,126 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/* Ethernet-facing declarations for the Airoha Secure Offload Engine (SOE)
+ * packet offload provider.
+ *
+ * airoha_eth owns SOE lifetime and calls these helpers to expose xfrm
+ * ESP/NAT-T offload on its netdevs. When CONFIG_NET_AIROHA_SOE is disabled,
+ * the stubs keep the Ethernet driver buildable without SOE support.
+ */
+
+#ifndef AIROHA_SOE_H
+#define AIROHA_SOE_H
+
+#include <linux/bitops.h>
+#include <linux/errno.h>
+#include <linux/kconfig.h>
+#include <linux/netdev_features.h>
+#include <linux/types.h>
+
+struct airoha_soe;
+struct airoha_soe_sa;
+struct airoha_eth;
+struct airoha_gdm_dev;
+struct device;
+struct dst_entry;
+struct net_device;
+struct netlink_ext_ack;
+struct sk_buff;
+struct xfrm_state;
+
+#define AIROHA_SOE_FEATURE_ESP		BIT(0)
+
+typedef int (*airoha_soe_xmit_skb_t)(struct airoha_gdm_dev *dev,
+				     struct sk_buff *skb, u32 msg0, u32 msg1,
+				     u32 msg2);
+
+#if IS_ENABLED(CONFIG_NET_AIROHA_SOE)
+int airoha_soe_init(struct airoha_eth *eth);
+void airoha_soe_deinit(struct airoha_eth *eth);
+bool airoha_soe_available(struct airoha_soe *soe);
+u32 airoha_soe_features(struct airoha_soe *soe);
+void airoha_soe_build_netdev(struct net_device *dev,
+			     airoha_soe_xmit_skb_t xmit_skb);
+void airoha_soe_teardown_netdev(struct net_device *dev);
+int airoha_soe_set_features(struct net_device *dev,
+			    netdev_features_t features);
+bool airoha_soe_rx_skb(struct airoha_soe *soe, struct sk_buff *skb,
+		       unsigned int sa_index, u32 hop_flags);
+bool airoha_soe_rx_plain_skb(struct airoha_gdm_dev *dev,
+			     struct sk_buff *skb, struct net_device *rx_dev,
+			     u16 foe_hash, u32 foe_reason, bool foe_valid);
+bool airoha_soe_has_pending_rx(struct airoha_soe *soe);
+int airoha_soe_xfrm_ppe_info(const struct dst_entry *dst, u8 *sa_index,
+			     u8 *hop);
+int airoha_soe_xmit(struct airoha_soe_sa *sa, struct airoha_gdm_dev *dev,
+		    struct sk_buff *skb, struct xfrm_state *x);
+#else
+static inline int airoha_soe_init(struct airoha_eth *eth)
+{
+	return 0;
+}
+
+static inline void airoha_soe_deinit(struct airoha_eth *eth)
+{
+}
+
+static inline bool airoha_soe_available(struct airoha_soe *soe)
+{
+	return false;
+}
+
+static inline u32 airoha_soe_features(struct airoha_soe *soe)
+{
+	return 0;
+}
+
+static inline void airoha_soe_build_netdev(struct net_device *dev,
+					   airoha_soe_xmit_skb_t xmit_skb)
+{
+}
+
+static inline void airoha_soe_teardown_netdev(struct net_device *dev)
+{
+}
+
+static inline int airoha_soe_set_features(struct net_device *dev,
+					  netdev_features_t features)
+{
+	return 0;
+}
+
+static inline bool airoha_soe_rx_skb(struct airoha_soe *soe,
+				     struct sk_buff *skb,
+				     unsigned int sa_index, u32 hop_flags)
+{
+	return false;
+}
+
+static inline bool airoha_soe_rx_plain_skb(struct airoha_gdm_dev *dev,
+					   struct sk_buff *skb,
+					   struct net_device *rx_dev,
+					   u16 foe_hash, u32 foe_reason,
+					   bool foe_valid)
+{
+	return false;
+}
+
+static inline bool airoha_soe_has_pending_rx(struct airoha_soe *soe)
+{
+	return false;
+}
+
+static inline int airoha_soe_xfrm_ppe_info(const struct dst_entry *dst,
+					   u8 *sa_index, u8 *hop)
+{
+	return -EOPNOTSUPP;
+}
+
+static inline int airoha_soe_xmit(struct airoha_soe_sa *sa,
+				  struct airoha_gdm_dev *dev,
+				  struct sk_buff *skb, struct xfrm_state *x)
+{
+	return -EOPNOTSUPP;
+}
+#endif
+
+#endif /* AIROHA_SOE_H */
-- 
2.53.0

