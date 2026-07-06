Return-Path: <netdev+bounces-305065-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id aiXcNhqzS2r0YgEAu9opvQ
	(envelope-from <netdev+bounces-305065-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 06 Jul 2026 15:52:26 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 75602711846
	for <lists+netdev@lfdr.de>; Mon, 06 Jul 2026 15:52:26 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b="gL6qOa3/";
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-305065-lists+netdev=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netdev+bounces-305065-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B313F30927CE
	for <lists+netdev@lfdr.de>; Mon,  6 Jul 2026 13:42:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 579E2396B9A;
	Mon,  6 Jul 2026 13:41:38 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FBAC3749E2
	for <netdev@vger.kernel.org>; Mon,  6 Jul 2026 13:41:36 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783345298; cv=none; b=ick9DSxENf/jrwm7yhKUo2CgT1fKQ6naC34VOiT5iAl1TFtBT37rx2Ucu6wu4tZnqxIQBV7gIFXqmnNsu7izhHv6MDNRjqM7IMe9jfgb+9CWvmngcbJnSjk+ef4tUFKAbiq7HdQNvYTHhAjj7UCg7wNSUooSQD4bgnnJ6gAbc8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783345298; c=relaxed/simple;
	bh=Ufe0EveQE+AdUZ9oZOvP+Lr73QuZkm2itpxET1Vfg2Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YvSc/tvBw1AMYQETfrS7qov8hWq7b4Lk0zuH6A+iOkR2jeEtUvUPhUYPTNTvoLjzP/iiFjJRRy+9VrhXPaFagAr5BZRqvNjuuDCNY6zREM7CPoJxo7C39uVJc1gvbJ5z1q1VPBZ1p1gNcaz5Qkf5oi87KYBbLpZTeC66r5pvsgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gL6qOa3/; arc=none smtp.client-ip=209.85.128.42
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-493bb0e2894so4515265e9.2
        for <netdev@vger.kernel.org>; Mon, 06 Jul 2026 06:41:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783345295; x=1783950095; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Morm3TxvU/7zWzMzzZHyNL09lXqWMSx5qJfV7XBDDrM=;
        b=gL6qOa3/DPJqe77U399RstJlk6BpK1M4XyAQCA4J+oLytsXDAtPEeAXOv6X+G/OU7J
         CKzB9vs+dwq714r1Y77JWhGG5F7Jfcq8TG/gREr0nk/8/uW7oW2I8FOxjKlJyKsExRbI
         B1hvsyIE9V3L2FRJHcnZm7gL2jMZ9isndEU1eOzWCdg2CS6uZUZ4ASQFxXGzxDeRyVmW
         egNWaFv1n/tERJzxoCYTYBgCY8tyhk6wrwJRbr8++ijfMuooKM+zrAjaf08FwbEqBYAG
         x6kXpN4D0/4xM3A/EEa+5ECRsEH7wQ8uzSuHLJRL7y4Xq8XYT3DALHprf2sGWY/JxHi2
         2v9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783345295; x=1783950095;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Morm3TxvU/7zWzMzzZHyNL09lXqWMSx5qJfV7XBDDrM=;
        b=MpWo+svbYFaVdDqORgl1J3E4TiW07VBPBfJy+GHsrMLcTR5BZ6lukaZLF9VcDYNTKq
         4MicHxM8/5ajGNZ9vPfZHLRWBaljRjGBcivvHBMb0ghHYYf30gKAJi5JoeScYc26CzUP
         kgkTNT304p5t7TBc2ufSmWhXWNL6buJhhmRrPcnN9F+7ZI+MSoh0zj+4tsXXtdQanW1C
         TsdeXWoiyINiKhKzYZ4npbSONsiMZlii3pN0X+64HTR1J6UttVgfpznEjifi967xQAcv
         m2LGTN75gf5pEUJt9ak3cULSSnKXsGGn0oi2QR0g9JD3d/4chQxIEIiKYp65bczCmQrg
         Ijsg==
X-Gm-Message-State: AOJu0YzTSvdoWriIsiIobE9nACMDumV8NA91wD+wzi78ahMDv8FFcGbS
	YR4QkdHsG81nz2neYNtr2B3tzrTP8GRDv/pMRSnVDZHuXJL2vVsQWLRmJ2M8Jwe7GGk=
X-Gm-Gg: AfdE7ck53AT4NfPCCfSTT8T9Wau4krM0+s3SKzwZVxlGRT/WB++2jeVby10KbeDcb0F
	IqGtudxdBBItKhykHslocipQCI74DhxkHgETI+6ND85qmsy+I5HgSwS1ElaaPtPT/XXg5wOqn/w
	tmyrnTfrNkG6qeSpR28T7sC3qq19q8urL2IN35elSLRb36CNGcInwWYs942aNh2o1v31EpxhoG6
	87Dgcw49OjcREDYMkEv9VTk44KNO2u5j2Yo9QwDHfSBi8oOyWsYdqV1ZLKKOGVfL0h/liHA83Fi
	TVP1Jr0+PI4cqakUuS55LpEvEVOAatRg+gbIClTIp0kgt/BU7cF9SK/b9kTdLq817q+J++feD2f
	kGy9g8f4hU2dQSEatHFIhbj7Hs240F1xFy+GCpanJ+k60KR5Q1pcZlmwXcZvWplVXXCrAlbW9Cs
	Pq/Pjpc8EHcwI5WibV0g12oV0oDjoWAVQfykWUUxlOpNG/S2CUuByU+PDI20j/Y6PZygBbLQ9Hh
	rLDYIcNyvi2aMBgTyLMKIjkJ75riG0RC5/22JiaduV0a/ji0N6nmRpupZfTtA==
X-Received: by 2002:a05:600c:c4aa:b0:493:c326:9038 with SMTP id 5b1f17b1804b1-493d0f39645mr68081825e9.3.1783345294778;
        Mon, 06 Jul 2026 06:41:34 -0700 (PDT)
Received: from hpubt (dynamic-2a02-3100-5b6d-48fc-6651-06ff-fed8-72a4.310.pool.telefonica.de. [2a02:3100:5b6d:48fc:6651:6ff:fed8:72a4])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47aa039ae44sm23960881f8f.23.2026.07.06.06.41.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2026 06:41:34 -0700 (PDT)
From: Xin Xie <xiexinet@gmail.com>
To: netdev@vger.kernel.org
Cc: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Felix Maurer <fmaurer@redhat.com>,
	Luka Gejak <luka.gejak@linux.dev>,
	Fernando Fernandez Mancera <fmancera@suse.de>,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Xin Xie <xiexinet@gmail.com>
Subject: [PATCH net-next v2 2/4] net: hsr: emit RedBox-MAC TLV in PRP RedBox supervision frames
Date: Mon,  6 Jul 2026 13:41:29 +0000
Message-ID: <20260706134131.61659-3-xiexinet@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260706134131.61659-1-xiexinet@gmail.com>
References: <20260704234704.4297-1-xiexinet@gmail.com>
 <20260706134131.61659-1-xiexinet@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,redhat.com,linutronix.de,linux.dev,suse.de,vger.kernel.org,gmail.com];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-305065-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:shuah@kernel.org,m:bigeasy@linutronix.de,m:fmaurer@redhat.com,m:luka.gejak@linux.dev,m:fmancera@suse.de,m:linux-kselftest@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:xiexinet@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[xiexinet@gmail.com,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[14];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[xiexinet@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 75602711846

A PRP RedBox must announce the SANs it proxies so peers populate their
proxy node tables. The proxy-announce machinery (hsr_proxy_announce(),
armed via hsr->redbox) already iterates proxy_node_db under RCU and calls
send_sv_frame() once per SAN, but the PRP sender emitted neither the
announced SAN MAC nor the RedBox-MAC TLV that IEC 62439-3 requires.

Extend send_prp_supervision_frame() so that, for a proxy-announce
(identified by the interlink port, an O(1) test), the frame carries the
proxied SAN MAC as MacAddressA followed by the RedBox-MAC TLV (Type 30)
and an explicit End-of-TLV marker before padding.

hsr_get_node() must also accept the reinjected proxy-announce: a PRP
supervision frame is an untagged ETH_P_PRP frame (mac_len == ETH_HLEN, the
RCT is appended only on egress) sourced from macaddress_redbox, which is
never learned from data. Exempt only PRP supervision frames from the
hsr_ethhdr length guard; HSR (ETH_P_HSR) supervision is front-tagged and
keeps the original guard, so HSR malformed-frame filtering is unchanged.

Also align macaddress_redbox so that ether_addr_copy() and
ether_addr_equal() on it are safe on architectures without efficient
unaligned access.

Signed-off-by: Xin Xie <xiexinet@gmail.com>
---
 net/hsr/hsr_device.c   | 33 ++++++++++++++++++++++++++++++---
 net/hsr/hsr_framereg.c | 13 +++++++++++--
 net/hsr/hsr_main.h     |  2 +-
 3 files changed, 42 insertions(+), 6 deletions(-)

diff --git a/net/hsr/hsr_device.c b/net/hsr/hsr_device.c
index 5af491ed2..0973f9a94 100644
--- a/net/hsr/hsr_device.c
+++ b/net/hsr/hsr_device.c
@@ -372,10 +372,21 @@ static void send_prp_supervision_frame(struct hsr_port *master,
 {
 	struct hsr_priv *hsr = master->hsr;
 	struct hsr_sup_payload *hsr_sp;
+	struct hsr_sup_tlv *hsr_stlv;
 	struct hsr_sup_tag *hsr_stag;
 	struct sk_buff *skb;
+	bool redbox_proxy;
+	int extra = 0;
+
+	redbox_proxy = hsr->redbox && master->type == HSR_PT_INTERLINK;
+
+	/* A proxy-announce carries a RedBox-MAC TLV and an EOT marker. */
+	if (redbox_proxy)
+		extra = sizeof(struct hsr_sup_tlv) +
+			sizeof(struct hsr_sup_payload) +
+			sizeof(struct hsr_sup_tlv);
 
-	skb = hsr_init_skb(master, 0);
+	skb = hsr_init_skb(master, extra);
 	if (!skb) {
 		netdev_warn_once(master->dev, "PRP: Could not send supervision frame\n");
 		return;
@@ -393,9 +404,25 @@ static void send_prp_supervision_frame(struct hsr_port *master,
 	hsr_stag->tlv.HSR_TLV_type = PRP_TLV_LIFE_CHECK_DD;
 	hsr_stag->tlv.HSR_TLV_length = sizeof(struct hsr_sup_payload);
 
-	/* Payload: MacAddressA */
+	/* Payload: MacAddressA, the announced node. */
 	hsr_sp = skb_put(skb, sizeof(struct hsr_sup_payload));
-	ether_addr_copy(hsr_sp->macaddress_A, master->dev->dev_addr);
+	ether_addr_copy(hsr_sp->macaddress_A, addr);
+
+	/* Proxy-announce: append the RedBox-MAC TLV (Type 30) and an explicit
+	 * EOT to terminate the TLV chain before zero padding.
+	 */
+	if (redbox_proxy) {
+		hsr_stlv = skb_put(skb, sizeof(struct hsr_sup_tlv));
+		hsr_stlv->HSR_TLV_type = PRP_TLV_REDBOX_MAC;
+		hsr_stlv->HSR_TLV_length = sizeof(struct hsr_sup_payload);
+
+		hsr_sp = skb_put(skb, sizeof(struct hsr_sup_payload));
+		ether_addr_copy(hsr_sp->macaddress_A, hsr->macaddress_redbox);
+
+		hsr_stlv = skb_put(skb, sizeof(struct hsr_sup_tlv));
+		hsr_stlv->HSR_TLV_type = HSR_TLV_EOT;
+		hsr_stlv->HSR_TLV_length = 0;
+	}
 
 	if (skb_put_padto(skb, ETH_ZLEN)) {
 		spin_unlock_bh(&hsr->seqnr_lock);
diff --git a/net/hsr/hsr_framereg.c b/net/hsr/hsr_framereg.c
index 8f708b6e6..b3b106be6 100644
--- a/net/hsr/hsr_framereg.c
+++ b/net/hsr/hsr_framereg.c
@@ -293,8 +293,17 @@ struct hsr_node *hsr_get_node(struct hsr_port *port, struct list_head *node_db,
 	 */
 	if (ethhdr->h_proto == htons(ETH_P_PRP) ||
 	    ethhdr->h_proto == htons(ETH_P_HSR)) {
-		/* Check if skb contains hsr_ethhdr */
-		if (skb->mac_len < sizeof(struct hsr_ethhdr))
+		bool prp_sup;
+
+		/* A PRP supervision frame is an untagged ETH_P_PRP frame
+		 * (mac_len == ETH_HLEN); its RCT is appended only on egress.
+		 * HSR (ETH_P_HSR) supervision is front-tagged and still must
+		 * contain a struct hsr_ethhdr.
+		 */
+		prp_sup = hsr->prot_version == PRP_V1 &&
+			  ethhdr->h_proto == htons(ETH_P_PRP) && is_sup;
+
+		if (!prp_sup && skb->mac_len < sizeof(struct hsr_ethhdr))
 			return NULL;
 	} else {
 		rct = skb_get_PRP_rct(skb);
diff --git a/net/hsr/hsr_main.h b/net/hsr/hsr_main.h
index 134e4f3ff..c27cfdd9c 100644
--- a/net/hsr/hsr_main.h
+++ b/net/hsr/hsr_main.h
@@ -211,7 +211,7 @@ struct hsr_priv {
 				 */
 	bool fwd_offloaded;	/* Forwarding offloaded to HW */
 	bool redbox;            /* Device supports HSR RedBox */
-	unsigned char		macaddress_redbox[ETH_ALEN];
+	unsigned char	macaddress_redbox[ETH_ALEN] __aligned(sizeof(u16));
 	unsigned char		sup_multicast_addr[ETH_ALEN] __aligned(sizeof(u16));
 				/* Align to u16 boundary to avoid unaligned access
 				 * in ether_addr_equal
-- 
2.53.0


