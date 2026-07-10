Return-Path: <netdev+bounces-306435-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id XkuiCjt1UGpxzQIAu9opvQ
	(envelope-from <netdev+bounces-306435-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 10 Jul 2026 06:29:47 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7308B737235
	for <lists+netdev@lfdr.de>; Fri, 10 Jul 2026 06:29:46 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=broadcom.com header.s=google header.b=H+xstgyD;
	dmarc=pass (policy=reject) header.from=broadcom.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-306435-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-306435-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9CE41305531F
	for <lists+netdev@lfdr.de>; Fri, 10 Jul 2026 04:25:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BDFC36C9F0;
	Fri, 10 Jul 2026 04:25:10 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f226.google.com (mail-qk1-f226.google.com [209.85.222.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AA5136CDFD
	for <netdev@vger.kernel.org>; Fri, 10 Jul 2026 04:25:06 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783657510; cv=none; b=WXg6GAXJzaYLwJfLfZtfegw4nth2eGjGuqEsyRJindZOfEuuwZ3yesBnddjWLx3EjtZn74kfGMbUvLape6U5W3vmbk0Qtl9ijjLENLIJfSiZPvj/+hkd9GG95iVVv5gNY0LrWAmheSlI64LAAlPK74CzwO5gWaCYFfHd8ei5+eE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783657510; c=relaxed/simple;
	bh=gKZ/vSxd4ijEC3StCiQ7rh5PX71AoaSB/R9m6MjFOVo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gT31EUMhhxfn1sInJOmZr0tCKIukXruriuDSIyW7/1EANwZ//vD+kbYLQ7VMSgxhlL/Rwm/VimE1PfjRf44gE+/uxLfojS4v4/MeYJQ43uRUNBhkTP+E95mO3i8ic1krxK0wJLbQbFac2LzA99IdQ+VjrgeA4whDzJ+Rn5pzouw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=H+xstgyD; arc=none smtp.client-ip=209.85.222.226
Received: by mail-qk1-f226.google.com with SMTP id af79cd13be357-92e54f8c051so21173885a.3
        for <netdev@vger.kernel.org>; Thu, 09 Jul 2026 21:25:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783657505; x=1784262305;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=UXJEGCCDOh+3Ja0ryyeQcnELHV5QtgMm+LYbwUkyjuE=;
        b=noqxwxeDN2F/3occVKadWvIeKyfjNNq2yHKB1Xv9QO6gkaT01t8rPmhF+Ji63n3GOi
         s99klpUiR0nk0OkbJypu3livvBR4/PdqNfw3q8niBlMbN+rwneNfTAqSPPZ+ynuX8QJ6
         GhB6bXVhq/RyUwVZFuweMkiUyjYGkab3jU6wr757Tik3lI/TXHFnUo2/98E4tpmUOnS1
         fDj8L5W+VW7xuoYjRrsU5tvl0p2rbtPWSbqPAL0aMeSOlNcYKMRfbER7P3vAf8dGaS0F
         6eYUW5gIX5xf3oKPNmzySmW8l4GHGx0ceLhwPabhSssOcR/5S4826/ODmhhP4veZsRFp
         eXnQ==
X-Gm-Message-State: AOJu0YxqMpYtGbln9EclfQSVXf8wOZUAiX+iub0qoqeTSTvWk5Qosb9H
	ajQ49LeXTUDurckI0I7ZbJ6lLZxv87KlI6mHCrK8Jj41tjcHwaRcsy5jiRnvVCb+QCU+rrN0PyW
	p+5A59ITMoT1Lzn8x+tNoCJurYTCmpBwCb5+/9TqT2NOEFYWneBZ/4EHNtvvANPsktpoqIlttou
	Hds9vX3zFZwqxdleRHGJhoTva0tgnqpMCud1r78f3AiwiDG32wKKhcr6SwGMHCLyLXY8fc9lcpI
	s+YXdMrF4Y=
X-Gm-Gg: AfdE7clwoL707tYi0RLAlWoX5XX9oJLDdJRD2yuLoOdU60P6KeLE5mOAHVODdpanPMC
	iWA8RDuQOezjZZuG7UGc9o7hyBqQRGvAmeUrqyR2mx9dVoBEpZMU+3bY5gzyyjM1AwiAsFB7hJA
	PGO0u5Pzk6zkcTDF3I5LHvC1qA4gMqF3WQOpe/8JBGUGWf/DVv34IcCVNrZvs8tIeCmE3A+TN7s
	F6lavvlq0obR09OTlX7h0i1IdZM0ett95F/fLS8O7Xn++fIuyVVyie5U6aKWc7tgbz3VBNW7dHw
	jM39FSDIpabzmb42DfFu3DMbebd/7QH6QbgynWWMTMz/IQpHjj/nOgPQqc+DJ4ZcbfXXuczCexV
	qxGZtie8bN21UhZC70CtJEoYpWnDM5EwzH0ITUGLK+rZkQg7g3Vz1jkXKp3qBHpFBY2OO7NNWEz
	VpAZP7VauFwT4QkMdrdRu315WBo5/WZdOmMsasnIHSOZUBTA==
X-Received: by 2002:a05:620a:800a:b0:92e:8210:fff9 with SMTP id af79cd13be357-92ecf5dd5aemr1129307885a.56.1783657505206;
        Thu, 09 Jul 2026 21:25:05 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-12.dlp.protect.broadcom.com. [144.49.247.12])
        by smtp-relay.gmail.com with ESMTPS id 6a1803df08f44-8ffd9179ebasm2254626d6.22.2026.07.09.21.25.04
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 09 Jul 2026 21:25:05 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-38ce7fabf76so923739a91.2
        for <netdev@vger.kernel.org>; Thu, 09 Jul 2026 21:25:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1783657504; x=1784262304; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=UXJEGCCDOh+3Ja0ryyeQcnELHV5QtgMm+LYbwUkyjuE=;
        b=H+xstgyDCwhWmahDe3YhC4CdNwx2JZC0gDK9rkgyaCqJaRzWvLGayRIRB5wFMwG/XV
         fo6jQwdJHuLIeMcsZ/ZHAIFZ+IVQExKviJnVDP1p694rO1O+2yX0z9xqz6ogh5iS13El
         r4nZwHyhE0uoASFeUqgpRIwOMw1xMo97R0/qQ=
X-Received: by 2002:a17:90b:5845:b0:388:cf45:d72c with SMTP id 98e67ed59e1d1-3893ff6309emr10161873a91.15.1783657503765;
        Thu, 09 Jul 2026 21:25:03 -0700 (PDT)
X-Received: by 2002:a17:90b:5845:b0:388:cf45:d72c with SMTP id 98e67ed59e1d1-3893ff6309emr10161830a91.15.1783657503107;
        Thu, 09 Jul 2026 21:25:03 -0700 (PDT)
Received: from lvnvda3289.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-313b4cbafa1sm276627eec.6.2026.07.09.21.25.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2026 21:25:02 -0700 (PDT)
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
Subject: [PATCH net-next v5 13/15] bnxt_en: Implement kTLS TX normal path
Date: Thu,  9 Jul 2026 21:23:58 -0700
Message-ID: <20260710042400.3996847-14-michael.chan@broadcom.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260710042400.3996847-1-michael.chan@broadcom.com>
References: <20260710042400.3996847-1-michael.chan@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-6.16 / 15.00];
	WHITELIST_DMARC(-7.00)[broadcom.com:D:+];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[broadcom.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-306435-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:davem@davemloft.net,m:netdev@vger.kernel.org,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:andrew+netdev@lunn.ch,m:pavan.chebbi@broadcom.com,m:andrew.gospodarek@broadcom.com,m:ajit.khaparde@broadcom.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[michael.chan@broadcom.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[michael.chan@broadcom.com,netdev@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[broadcom.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	ALIAS_RESOLVED(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,broadcom.com:from_mime,broadcom.com:email,broadcom.com:mid,broadcom.com:dkim];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 7308B737235

Offload TLS encryption of TX packets to the hardware if the TCP sequence
number is the expected one.  Fall back to software encryption otherwise.
Implement all the TLS TX logic to check the TCP sequence number and set
up the BD in the new function bnxt_ktls_xmit().  The stored TCP sequence
number is only updated when BD is in the ring and guaranteed to be
transmitted.

Basic kTLS statistics reporting for ethtool -S is also added.  Because
there can be multiple TX rings (if there are MQPRIO TCs) sharing the
same bnxt_cp_ring_info containing the bnxt_sw_stats, we need to store
the kTLS software TX stats in bnxt_tx_ring_info instead.

The next patches will add support for the exception path with
out-of-order TCP sequence number.

Reviewed-by: Ajit Khaparde <ajit.khaparde@broadcom.com>
Reviewed-by: Pavan Chebbi <pavan.chebbi@broadcom.com>
Signed-off-by: Michael Chan <michael.chan@broadcom.com>
---
v5:
Use BNXT_NO_FW_ACCESS() to fix possible massive AER timeout.

v3:
https://lore.kernel.org/netdev/20260614072407.2761092-14-michael.chan@broadcom.com/

Use per TX ring TLS stats structures.

Defer tcp sequence and stats update until the BD is on the ring.

Increment the drop counter if kTLS drops the packet.

v2:
https://lore.kernel.org/netdev/20260512212105.3488258-14-michael.chan@broadcom.com/
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c     | 23 ++++-
 drivers/net/ethernet/broadcom/bnxt/bnxt.h     | 41 +++++++-
 .../net/ethernet/broadcom/bnxt/bnxt_crypto.c  |  1 +
 .../net/ethernet/broadcom/bnxt/bnxt_ethtool.c | 46 +++++++++
 drivers/net/ethernet/broadcom/bnxt/bnxt_gso.c |  2 +-
 .../net/ethernet/broadcom/bnxt/bnxt_ktls.c    | 93 +++++++++++++++++++
 .../net/ethernet/broadcom/bnxt/bnxt_ktls.h    | 60 ++++++++++++
 7 files changed, 258 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index ef73e992756b..af11f0744d0a 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -481,6 +481,7 @@ static netdev_tx_t bnxt_start_xmit(struct sk_buff *skb, struct net_device *dev)
 	dma_addr_t mapping;
 	unsigned int length, pad = 0;
 	u32 len, free_size, vlan_tag_flags, cfa_action, flags;
+	struct bnxt_ktls_offload_ctx_tx *kctx_tx = NULL;
 	struct bnxt_ptp_cfg *ptp = bp->ptp_cfg;
 	struct pci_dev *pdev = bp->pdev;
 	u16 prod, last_frag, txts_prod;
@@ -488,6 +489,7 @@ static netdev_tx_t bnxt_start_xmit(struct sk_buff *skb, struct net_device *dev)
 	struct bnxt_sw_tx_bd *tx_buf;
 	__le32 lflags = 0;
 	skb_frag_t *frag;
+	u32 kid = 0;
 
 	i = skb_get_queue_mapping(skb);
 	if (unlikely(i >= bp->tx_nr_rings)) {
@@ -527,6 +529,12 @@ static netdev_tx_t bnxt_start_xmit(struct sk_buff *skb, struct net_device *dev)
 			return NETDEV_TX_BUSY;
 	}
 
+	skb = bnxt_ktls_xmit(bp, txr, skb, &lflags, &kid, &kctx_tx);
+	if (unlikely(!skb)) {
+		dev_core_stats_tx_dropped_inc(dev);
+		return NETDEV_TX_OK;
+	}
+
 	length = skb->len;
 	len = skb_headlen(skb);
 	last_frag = skb_shinfo(skb)->nr_frags;
@@ -675,7 +683,7 @@ static netdev_tx_t bnxt_start_xmit(struct sk_buff *skb, struct net_device *dev)
 
 	prod = NEXT_TX(prod);
 	txbd1 = bnxt_init_ext_bd(bp, txr, prod, lflags, vlan_tag_flags,
-				 cfa_action);
+				 cfa_action, kid);
 
 	if (skb_is_gso(skb)) {
 		bool udp_gso = !!(skb_shinfo(skb)->gso_type & SKB_GSO_UDP_L4);
@@ -696,9 +704,10 @@ static netdev_tx_t bnxt_start_xmit(struct sk_buff *skb, struct net_device *dev)
 
 		txbd1->tx_bd_hsize_lflags |= cpu_to_le32(TX_BD_FLAGS_LSO |
 					TX_BD_FLAGS_T_IPID |
-					(hdr_len << (TX_BD_HSIZE_SHIFT - 1)));
+					((hdr_len >> 1) << TX_BD_HSIZE_SHIFT));
 		length = skb_shinfo(skb)->gso_size;
-		txbd1->tx_bd_mss = cpu_to_le32(length);
+		txbd1->tx_bd_kid_mss = cpu_to_le32(BNXT_TX_KID_HI(kid) |
+						   (length & TX_BD_MSS));
 		length += hdr_len;
 	} else if (skb->ip_summed == CHECKSUM_PARTIAL) {
 		txbd1->tx_bd_hsize_lflags |=
@@ -751,6 +760,9 @@ static netdev_tx_t bnxt_start_xmit(struct sk_buff *skb, struct net_device *dev)
 	prod = NEXT_TX(prod);
 	WRITE_ONCE(txr->tx_prod, prod);
 
+	/* Commit the kTLS state now that the BD is in the ring. */
+	bnxt_ktls_xmit_commit(txr, kctx_tx);
+
 	if (!netdev_xmit_more() || netif_xmit_stopped(txq)) {
 		bnxt_txr_db_kick(bp, txr, prod);
 	} else {
@@ -4085,6 +4097,8 @@ static void bnxt_free_tx_rings(struct bnxt *bp)
 
 		bnxt_free_tx_inline_buf(txr, pdev);
 
+		bnxt_ktls_free_tx_ring_stats(txr);
+
 		ring = &txr->tx_ring_struct;
 
 		bnxt_free_ring(bp, &ring->ring_mem);
@@ -4160,6 +4174,9 @@ static int bnxt_alloc_tx_rings(struct bnxt *bp)
 		qidx = bp->tc_to_qidx[j];
 		ring->queue_id = bp->q_info[qidx].queue_id;
 		spin_lock_init(&txr->tx_lock);
+		rc = bnxt_ktls_alloc_tx_ring_stats(bp, txr);
+		if (rc)
+			return rc;
 		if (i < bp->tx_nr_rings_xdp)
 			continue;
 		if (BNXT_RING_TO_TC_OFF(bp, i) == (bp->tx_nr_rings_per_tc - 1))
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.h b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
index b7ad665b47ae..5b6f629d7bcf 100644
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
@@ -1025,6 +1043,9 @@ struct bnxt_tx_ring_info {
 	struct bnxt_ring_struct	tx_ring_struct;
 	/* Synchronize simultaneous xdp_xmit on same ring or for MPC ring */
 	spinlock_t		tx_lock;
+
+	/* Per-TX-ring kTLS counters; allocated only when kTLS is enabled. */
+	struct bnxt_tls_sw_stats *tls_stats;
 };
 
 #define BNXT_LEGACY_COAL_CMPL_PARAMS					\
@@ -1166,6 +1187,18 @@ struct bnxt_cmn_sw_stats {
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
@@ -2885,14 +2918,14 @@ static inline u32 bnxt_tx_avail(struct bnxt *bp,
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
index 6376a85d4b83..27a978bd18e2 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_crypto.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_crypto.c
@@ -573,6 +573,7 @@ int bnxt_crypto_init(struct bnxt *bp)
 	if (rc)
 		return rc;
 
+	bnxt_ktls_init(bp);
 	return 0;
 }
 
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
index 4bc3cac57b13..66a35876c00b 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
@@ -38,6 +38,7 @@
 #include "bnxt_fw_hdr.h"	/* Firmware hdr constant and structure defs */
 #include "bnxt_coredump.h"
 #include "bnxt_mpc.h"
+#include "bnxt_ktls.h"
 
 #define BNXT_NVM_ERR_MSG(dev, extack, msg)			\
 	do {							\
@@ -354,6 +355,26 @@ static const char *const bnxt_ring_drv_stats_arr[] = {
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
+	[BNXT_KTLS_TX_ADD]			= "tx_tls_add",
+	[BNXT_KTLS_TX_DEL]			= "tx_tls_del",
+	[BNXT_KTLS_ERR_NO_MEM]			= "tls_err_no_mem",
+	[BNXT_KTLS_ERR_NO_CAP]			= "tls_err_no_cap",
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
@@ -536,12 +557,21 @@ static int bnxt_get_num_ring_stats(struct bnxt *bp)
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
@@ -654,6 +684,16 @@ static void bnxt_get_ethtool_stats(struct net_device *dev,
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
 
@@ -764,6 +804,12 @@ static void bnxt_get_strings(struct net_device *dev, u32 stringset, u8 *buf)
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
index cec877075b16..cf71356cdfcf 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_ktls.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_ktls.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /* Copyright (c) 2026 Broadcom Inc. */
 
+#include <linux/tcp.h>
 #include <net/tls.h>
 #include <linux/bnxt/hsi.h>
 
@@ -343,3 +344,95 @@ int bnxt_ktls_init(struct bnxt *bp)
 	dev->features |= NETIF_F_HW_TLS_TX;
 	return 0;
 }
+
+static void bnxt_ktls_inc_tx_stats(struct bnxt_tx_ring_info *txr, u32 bytes)
+{
+	struct bnxt_tls_sw_stats *ring_stats = txr->tls_stats;
+
+	if (!ring_stats)
+		return;
+	ring_stats->counters[BNXT_KTLS_TX_PKTS]++;
+	ring_stats->counters[BNXT_KTLS_TX_BYTES] += bytes;
+}
+
+struct sk_buff *bnxt_ktls_xmit(struct bnxt *bp, struct bnxt_tx_ring_info *txr,
+			       struct sk_buff *skb, __le32 *lflags, u32 *kid,
+			       struct bnxt_ktls_offload_ctx_tx **kctx_tx_p)
+{
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
+	kctx_tx = bnxt_get_ktls_ctx_tx(tls_ctx);
+	payload_len = skb->len - skb_tcp_all_headers(skb);
+	if (!payload_len)
+		return skb;
+	if (kctx_tx->tcp_seq_no == seq) {
+		/* Stage the advance only.  tcp_seq_no and the counters are
+		 * committed by bnxt_ktls_xmit_commit() once the BD reaches the
+		 * ring.
+		 */
+		kctx_tx->next_tcp_seq_no = seq + payload_len;
+		kctx_tx->pending_bytes = payload_len;
+		*kid = BNXT_KID_HW(kctx_tx->kid);
+		*kctx_tx_p = kctx_tx;
+		*lflags |= cpu_to_le32(TX_BD_FLAGS_CRYPTO_EN |
+				       BNXT_TX_KID_LO(*kid));
+	} else {
+		skb = tls_encrypt_skb(skb);
+		if (!skb)
+			return NULL;
+	}
+	return skb;
+}
+
+void bnxt_ktls_xmit_commit(struct bnxt_tx_ring_info *txr,
+			   struct bnxt_ktls_offload_ctx_tx *kctx_tx)
+{
+	if (!kctx_tx)
+		return;
+	kctx_tx->tcp_seq_no = kctx_tx->next_tcp_seq_no;
+	bnxt_ktls_inc_tx_stats(txr, kctx_tx->pending_bytes);
+}
+
+int bnxt_ktls_alloc_tx_ring_stats(struct bnxt *bp, struct bnxt_tx_ring_info *txr)
+{
+	struct bnxt_tls_sw_stats *ring_stats;
+
+	if (!bp->ktls_info)
+		return 0;
+	ring_stats = kzalloc_obj(*ring_stats);
+	if (!ring_stats)
+		return -ENOMEM;
+	txr->tls_stats = ring_stats;
+	return 0;
+}
+
+void bnxt_ktls_free_tx_ring_stats(struct bnxt_tx_ring_info *txr)
+{
+	kfree(txr->tls_stats);
+	txr->tls_stats = NULL;
+}
+
+void bnxt_get_ring_tls_stats(struct bnxt *bp, struct bnxt_tls_sw_stats *stats)
+{
+	struct bnxt_tls_sw_stats *ring_stats;
+	int i, j;
+
+	if (!bp->ktls_info || !bp->tx_ring)
+		return;
+	for (i = 0; i < bp->tx_nr_rings; i++) {
+		ring_stats = bp->tx_ring[i].tls_stats;
+		if (!ring_stats)
+			continue;
+		for (j = 0; j < BNXT_KTLS_MAX_DATA_COUNTERS; j++)
+			stats->counters[j] += ring_stats->counters[j];
+	}
+}
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_ktls.h b/drivers/net/ethernet/broadcom/bnxt/bnxt_ktls.h
index 5a4f39f15e80..fd17d2ddb8b8 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_ktls.h
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_ktls.h
@@ -78,6 +78,28 @@ struct ce_add_cmd {
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
@@ -94,6 +116,15 @@ static inline void bnxt_ktls_wake(struct bnxt *bp)
 int bnxt_alloc_ktls_info(struct bnxt *bp);
 void bnxt_free_ktls_info(struct bnxt *bp);
 int bnxt_ktls_init(struct bnxt *bp);
+struct sk_buff *bnxt_ktls_xmit(struct bnxt *bp, struct bnxt_tx_ring_info *txr,
+			       struct sk_buff *skb, __le32 *lflags, u32 *kid,
+			       struct bnxt_ktls_offload_ctx_tx **kctx_tx_p);
+void bnxt_ktls_xmit_commit(struct bnxt_tx_ring_info *txr,
+			   struct bnxt_ktls_offload_ctx_tx *kctx_tx);
+int bnxt_ktls_alloc_tx_ring_stats(struct bnxt *bp,
+				  struct bnxt_tx_ring_info *txr);
+void bnxt_ktls_free_tx_ring_stats(struct bnxt_tx_ring_info *txr);
+void bnxt_get_ring_tls_stats(struct bnxt *bp, struct bnxt_tls_sw_stats *stats);
 #else
 static inline int bnxt_alloc_ktls_info(struct bnxt *bp)
 {
@@ -108,5 +139,34 @@ static inline int bnxt_ktls_init(struct bnxt *bp)
 {
 	return -EOPNOTSUPP;
 }
+
+static inline struct sk_buff *
+bnxt_ktls_xmit(struct bnxt *bp, struct bnxt_tx_ring_info *txr,
+	       struct sk_buff *skb, __le32 *lflags, u32 *kid,
+	       struct bnxt_ktls_offload_ctx_tx **kctx_tx_p)
+{
+	return skb;
+}
+
+static inline void
+bnxt_ktls_xmit_commit(struct bnxt_tx_ring_info *txr,
+		      struct bnxt_ktls_offload_ctx_tx *kctx_tx)
+{
+}
+
+static inline int bnxt_ktls_alloc_tx_ring_stats(struct bnxt *bp,
+						struct bnxt_tx_ring_info *txr)
+{
+	return 0;
+}
+
+static inline void bnxt_ktls_free_tx_ring_stats(struct bnxt_tx_ring_info *txr)
+{
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


