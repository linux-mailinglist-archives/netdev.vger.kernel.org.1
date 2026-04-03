Return-Path: <netdev+bounces-275247-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6FDFH0M80GmP4wYAu9opvQ
	(envelope-from <netdev+bounces-275247-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 04 Apr 2026 00:16:35 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id F2EA9398B33
	for <lists+netdev@lfdr.de>; Sat, 04 Apr 2026 00:16:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 83F363039F4D
	for <lists+netdev@lfdr.de>; Fri,  3 Apr 2026 22:15:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56D4531AF07;
	Fri,  3 Apr 2026 22:15:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UUBK+luH"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f202.google.com (mail-qt1-f202.google.com [209.85.160.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB877303CAB
	for <netdev@vger.kernel.org>; Fri,  3 Apr 2026 22:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775254547; cv=none; b=kNL0D3tXhfa6skajk9OH4PvPJdbFeOtRvvMJlRTLs9SjTbclm8fM23EZZpZMwzZhrR8StLJCp8HYnB6KZH1jUV7QXenq89/ejdR8W3jES4CkdWeVZFTAUmBWSzsBYaoIdX+njPHofyMIBvsik3dlzgqQFkCInCOe/1sHsVIrfEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775254547; c=relaxed/simple;
	bh=TN4epTvDqYIQAHihXpzbqzcu4dw2CEEDKyaKtWur7c8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=mha0YR95pbhQi+v746aCPMJMfeTFzOPLEn664n0fdAFkf2IaQQ8lXu4aujJjhzOK/d7+Ehv/vhFcHnwbfme8YqU/brugf492+Lb/EVroJ3+BfXCY64u6Yy9QbKBtq8vlsSR0WC0jlTXcx5o0saMOGkf1p75CmeZxpmudGyS5DCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UUBK+luH; arc=none smtp.client-ip=209.85.160.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qt1-f202.google.com with SMTP id d75a77b69052e-50d5d1c2289so41197341cf.2
        for <netdev@vger.kernel.org>; Fri, 03 Apr 2026 15:15:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775254545; x=1775859345; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=tKX29QgMhyoB66jcRfcsYDDe4LlFRV2jg7v0FAsbjDc=;
        b=UUBK+luH7FwIHzoRb2a9IuPgsFslUa42q+xwgoBPC0DIuTGQxqqT45emXc7L+Q8ALt
         DTJ0/X1ffr9kdYPJzIRY8d95dnGLdBhE7SvTL9hOjQu+su8+KEJysBUmj2F4Bfmba6m6
         FzozWQerycGlzdEMkUgLzUblBy4pRmO+tYEgEUzO/30FGNMxW+YDQ5x7TGzYkToAEGus
         9IBILy72TjGUXHSHd7xITr6a4wHw+dlUerSWsmv/TISWXo9ZFPzkU12rCPn7VG9jCrqF
         pMq7xQObmqhkdgvXvgwlAkt0HxW3WgC0ABq7A06Ox+a+04GQtfdhrcmoRROLjyoYFRw4
         Qqpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775254545; x=1775859345;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tKX29QgMhyoB66jcRfcsYDDe4LlFRV2jg7v0FAsbjDc=;
        b=DD5PXXziqy18bWZ639HFrnAhFi/89C4PtoBw/iNJbNAUAdSus8muJJnMN6fMAUuk72
         7MRz/TEsVPRDtMiAcotPUjEVOIO7uCXztW0NqT/gR7i2Blt2HvG1WfQbM46VgfDnba7G
         XiK2u85BAPeuOZ8btZmiEvTk1/MLCdH6uKu1JDZmzGV4WnSw035PlYHJnQulytJUrw0p
         JGNdyJy4k3RhYr2OTvjm/ibFKXc9VDRJ7yzDakPhN6cV0E0DZLMbsnyMVtu3d9O+nBCy
         D+bZuc0QnDnybTJ7gCnLv4ExPLYGTVsaXbwypmSG613mFgispMvgKOYRMWrAnztwir2W
         6Ypg==
X-Forwarded-Encrypted: i=1; AJvYcCWdTWLQrDtI9SlTK1v2/tv+fozDGjdsX61/yZYYP7KYTDT1WdHz6H1li4ocLTcNJ7LGZUEEGIU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz99SWt4gRubaqyoeTewOS77boz+XEMyc21U2M5PcDywVcKOEN0
	tQyRXcsTC2tbwYJHwqfkKh95iYpvvkWAJXawJiwKlbBj4EMtZ6pNM+EwENCwPZ1Z8I+z0SSsx5V
	e4oL/pQqwsIQSEA==
X-Received: from qkkf22.prod.google.com ([2002:a05:620a:15b6:b0:8cd:7aed:be78])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:4808:b0:8b1:2853:673f with SMTP id af79cd13be357-8d41c2ba242mr659167885a.15.1775254544330;
 Fri, 03 Apr 2026 15:15:44 -0700 (PDT)
Date: Fri,  3 Apr 2026 22:15:39 +0000
In-Reply-To: <20260403221540.3297753-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260403221540.3297753-1-edumazet@google.com>
X-Mailer: git-send-email 2.53.0.1213.gd9a14994de-goog
Message-ID: <20260403221540.3297753-2-edumazet@google.com>
Subject: [PATCH net-next 1/2] net: qdisc_pkt_len_segs_init() cleanup
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, Joe Damato <joe@dama.to>, 
	netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,lunn.ch,dama.to,vger.kernel.org,gmail.com,google.com];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-275247-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: F2EA9398B33
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Reduce indentation level by returning early if the transport header
was not set.

Add an unlikely() clause as this is not the common case.

No functional change.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/core/dev.c | 62 +++++++++++++++++++++++++-------------------------
 1 file changed, 31 insertions(+), 31 deletions(-)

diff --git a/net/core/dev.c b/net/core/dev.c
index 4519f0e59beb695fffb69a0a9cf89a7b75fe209f..3eb2f50f516564c6a6465c19a6d802c136e0ddde 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -4104,6 +4104,7 @@ EXPORT_SYMBOL_GPL(validate_xmit_skb_list);
 static void qdisc_pkt_len_segs_init(struct sk_buff *skb)
 {
 	struct skb_shared_info *shinfo = skb_shinfo(skb);
+	unsigned int hdr_len;
 	u16 gso_segs;
 
 	qdisc_skb_cb(skb)->pkt_len = skb->len;
@@ -4117,44 +4118,43 @@ static void qdisc_pkt_len_segs_init(struct sk_buff *skb)
 	/* To get more precise estimation of bytes sent on wire,
 	 * we add to pkt_len the headers size of all segments
 	 */
-	if (skb_transport_header_was_set(skb)) {
-		unsigned int hdr_len;
+	if (unlikely(!skb_transport_header_was_set(skb)))
+		return;
 
-		/* mac layer + network layer */
-		if (!skb->encapsulation)
-			hdr_len = skb_transport_offset(skb);
-		else
-			hdr_len = skb_inner_transport_offset(skb);
+	/* mac layer + network layer */
+	if (!skb->encapsulation)
+		hdr_len = skb_transport_offset(skb);
+	else
+		hdr_len = skb_inner_transport_offset(skb);
 
-		/* + transport layer */
-		if (likely(shinfo->gso_type & (SKB_GSO_TCPV4 | SKB_GSO_TCPV6))) {
-			const struct tcphdr *th;
-			struct tcphdr _tcphdr;
+	/* + transport layer */
+	if (likely(shinfo->gso_type & (SKB_GSO_TCPV4 | SKB_GSO_TCPV6))) {
+		const struct tcphdr *th;
+		struct tcphdr _tcphdr;
 
-			th = skb_header_pointer(skb, hdr_len,
-						sizeof(_tcphdr), &_tcphdr);
-			if (likely(th))
-				hdr_len += __tcp_hdrlen(th);
-		} else if (shinfo->gso_type & SKB_GSO_UDP_L4) {
-			struct udphdr _udphdr;
+		th = skb_header_pointer(skb, hdr_len,
+					sizeof(_tcphdr), &_tcphdr);
+		if (likely(th))
+			hdr_len += __tcp_hdrlen(th);
+	} else if (shinfo->gso_type & SKB_GSO_UDP_L4) {
+		struct udphdr _udphdr;
 
-			if (skb_header_pointer(skb, hdr_len,
-					       sizeof(_udphdr), &_udphdr))
-				hdr_len += sizeof(struct udphdr);
-		}
+		if (skb_header_pointer(skb, hdr_len,
+				       sizeof(_udphdr), &_udphdr))
+			hdr_len += sizeof(struct udphdr);
+	}
 
-		if (unlikely(shinfo->gso_type & SKB_GSO_DODGY)) {
-			int payload = skb->len - hdr_len;
+	if (unlikely(shinfo->gso_type & SKB_GSO_DODGY)) {
+		int payload = skb->len - hdr_len;
 
-			/* Malicious packet. */
-			if (payload <= 0)
-				return;
-			gso_segs = DIV_ROUND_UP(payload, shinfo->gso_size);
-			shinfo->gso_segs = gso_segs;
-			qdisc_skb_cb(skb)->pkt_segs = gso_segs;
-		}
-		qdisc_skb_cb(skb)->pkt_len += (gso_segs - 1) * hdr_len;
+		/* Malicious packet. */
+		if (payload <= 0)
+			return;
+		gso_segs = DIV_ROUND_UP(payload, shinfo->gso_size);
+		shinfo->gso_segs = gso_segs;
+		qdisc_skb_cb(skb)->pkt_segs = gso_segs;
 	}
+	qdisc_skb_cb(skb)->pkt_len += (gso_segs - 1) * hdr_len;
 }
 
 static int dev_qdisc_enqueue(struct sk_buff *skb, struct Qdisc *q,
-- 
2.53.0.1213.gd9a14994de-goog


