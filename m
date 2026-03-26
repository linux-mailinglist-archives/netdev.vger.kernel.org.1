Return-Path: <netdev+bounces-272108-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gJK1HjZOxWkU8wQAu9opvQ
	(envelope-from <netdev+bounces-272108-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 16:18:14 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 326B733769B
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 16:18:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6DA5630E460C
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 15:08:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 875734014B7;
	Thu, 26 Mar 2026 15:08:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K8JmEa61"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C5343FEB04
	for <netdev@vger.kernel.org>; Thu, 26 Mar 2026 15:08:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774537687; cv=none; b=bBE2YNj97TgDPIW9rSMpAq3Ial3cLhPAppCzFWdJ4WdgWiI9RKXWiE5LxBKZ928gDtpChJaiIHZQbW6CdEEwyM5ZZpA3yf2tJInoXbR31yaTIKkdciCrN9LAVTrTOHEKGcRwPIGbhrk0kfwDtDDMa4eVPGtrZXK7i7cnboNKgpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774537687; c=relaxed/simple;
	bh=SrJ8v2JXUP4BQ/htK1TW22nfXu8yKqHl2EOzmrry8MI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OkmOpawUQ11Jf6t1vutUwP1Uuv66uMDTr81eGtE3eIiVU3fI62EhuPKsq3AVO8AEZkY+MQCpm1V/aZY48kCjEHwLjBZXCdndz7R7X+qXUumk8MqcF4OxDolGOjehSrala7YJbWcNbNF0UE/wMbXwDiiTOVjsQqkUN9FsJOetWh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K8JmEa61; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2ab232cc803so4979455ad.3
        for <netdev@vger.kernel.org>; Thu, 26 Mar 2026 08:08:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774537684; x=1775142484; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=htKXcnTzcKDeqjMpn8hCX3YfwiSQQ8z5MdKwPZHhth8=;
        b=K8JmEa61X/hHCAZKr8D26W7Ag72I8qjEWApS1FeDkX9VBEY06XBpymHYLnAFhyOts3
         feb1Vzo8gPs0WLQ50hutkkV1KbGsDRf2oHLt85BUj0fOu/+kAebZeaCOh5yyrnIAasEA
         tyeAut7Fu/ZHMAHJm/Mk1lNFLECxLy1BCn1/g/dBTVHiE5C23CEgbHvX3o1ZiSUDaSkC
         +8uG4JbzNPu6yCBautg0VRFTLg66jqLFOwXRe9V+btCYxCXgtJe8m9v7FQhhI12IOqC/
         AXrMKLJSqUSNcDSBvCOYpRpXwAnvUZGkamVQEDSdYNFnN0y1t9VVlmTrRD4kDVUYCLmg
         f08A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774537684; x=1775142484;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=htKXcnTzcKDeqjMpn8hCX3YfwiSQQ8z5MdKwPZHhth8=;
        b=PIotdx2TGzfXxMkea9qJNG49c4Bruf+KJS4gSozj0eaH7jSfDVGoDdiVwcq7hMG09w
         lxnqic8a/T4/sFCXXciRP9k3jZai0tmeEAkDNA71nhIPpU4q2GPyLFYeLe9WJkZRKrbs
         A67khzuKkyQjK/kI2z/tkTxvCftxXlA10tF1H9SE5kCiSdi6cG+EJulMa7v59sXglp7m
         XVAI9XhsMojE44U0exW2qTxsS6WiubGtcdJTmSh0DbQAQfvfaJS26VflTWx0XZIQCI/e
         1WJ5FwfPrIjKjCdfK8MNarI94OxMu+SYsOXQwZTQTN/NFMyYq2Nrxif+zqhT9HWzN3bL
         wa8A==
X-Forwarded-Encrypted: i=1; AJvYcCVQ2xCO4uPXpBrTbc/do8I9RPLp30ViDtHp7f8+ODvslrWG/mvboer0ChMYRK2sc4vC4OQgpJU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzT871j2/qreOL7q4xUAkMJJ8DoBkXnbILYNsWYu4p7Q/DHcTMf
	Opj5xv1EXoNN4GpkgI6dcyBxiNeBHftuDc3/ss9ZmWf6YlJD4q/HDjNZ
X-Gm-Gg: ATEYQzzGy2oigr5AJdvT1z3TVxd3JycCV1fgEuvzMDkCUYJ2z2Ffem/vQ/10ZbvxA5T
	UJpEZRYosXY7tSkbPI4y0kVUt/hlrc+1D4pqINtY09/uw9KkDLcQrxdLne+qmjQKm4pn+zgKIXJ
	iiqJZkH6VDJoYsnA717piKMum6jkmhGP8hbuHGERMwQ3LQpGfw15ldT+x6m3iarXgLMObs5JR6N
	LF8yduO4a9+rcuWZ2xlwxMYRA6YSx1QOZWQrYFVP045PPCo/SnT4GDt0XpojbgdvsqUPXgxQKIB
	QapvTdL0FEScb+grg5S+34RcIU0ElbHfiAdYsNWWW0Dcq29SCjjX7ZMFTg645cCogjez+7AcSs9
	YfR+nKbYQBaomFs1HQBTJ+BB75ZqNWD3EQ5c/FQsKmMd8BLqC8IhEE+kW3PfKNSYwHdhtEKrXgl
	05jdU3z6+z37G8R5LMeLET2SyMTqfRY7CPbZwMAfPJ
X-Received: by 2002:a17:903:3884:b0:2ae:5655:b16 with SMTP id d9443c01a7336-2b0b0a140d0mr86962365ad.21.1774537684401;
        Thu, 26 Mar 2026 08:08:04 -0700 (PDT)
Received: from DESKTOP-82PPU4A.localdomain ([202.8.116.170])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b0bc8bb5fasm33146375ad.59.2026.03.26.08.08.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Mar 2026 08:08:03 -0700 (PDT)
From: Ujjal Roy <royujjal@gmail.com>
To: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Ido Schimmel <idosch@nvidia.com>,
	David Ahern <dsahern@kernel.org>
Cc: Ujjal Roy <ujjal@alumnux.com>,
	bridge@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 3/4] ipv4: igmp: encode multicast exponential fields
Date: Thu, 26 Mar 2026 15:07:41 +0000
Message-ID: <20260326150742.50289-4-royujjal@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260326150742.50289-1-royujjal@gmail.com>
References: <20260326150742.50289-1-royujjal@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-272108-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[royujjal@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 326B733769B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

In IGMP, QQIC and MRC fields are not currently encoded
when generating query packets. Since the receiver of the
query interprets these fields using the IGMPv3 floating-
point decoding logic, any raw interval value that exceeds
the linear threshold is currently parsed incorrectly as
an exponential value, leading to an incorrect interval
calculation.

Encode and assign the corresponding protocol fields during
query generation. Introduce the logic to dynamically
calculate the exponent and mantissa using bit-scan (fls).
This ensures QQIC and MRC fields (8-bit) are properly
encoded when transmitting query packets with intervals
that exceed their respective linear threshold value of
128 (for QQI/MRT).

RFC 3376: if QQIC/MRC >= 128, the QQIC/MRC field represents
a floating-point value as follows:
     0 1 2 3 4 5 6 7
    +-+-+-+-+-+-+-+-+
    |1| exp | mant  |
    +-+-+-+-+-+-+-+-+

Signed-off-by: Ujjal Roy <royujjal@gmail.com>
---
 include/linux/igmp.h      | 80 +++++++++++++++++++++++++++++++++++++++
 net/bridge/br_multicast.c | 14 +++----
 2 files changed, 86 insertions(+), 8 deletions(-)

diff --git a/include/linux/igmp.h b/include/linux/igmp.h
index 3c12c0a63492..99fce6b0625f 100644
--- a/include/linux/igmp.h
+++ b/include/linux/igmp.h
@@ -110,6 +110,86 @@ struct ip_mc_list {
 
 /* IGMPV3 floating-point exponential field threshold */
 #define IGMPV3_EXP_MIN_THRESHOLD	128
+/* Max representable (mant = 0xF, exp = 7) -> 31744 */
+#define IGMPV3_EXP_MAX_THRESHOLD	31744
+
+/* V3 exponential field encoding */
+
+/*
+ * IGMPv3 QQIC/MRC 8-bit exponential field encode.
+ *
+ * RFC3376 defines only the decoding formula:
+ * QQI/MRT = (mant | 0x10) << (exp + 3)
+ *
+ * but does NOT define the encoding procedure. To derive exponent:
+ *
+ * For any value of mantissa and exponent, the decoding formula
+ * indicates that the "hidden bit" (0x10) is shifted 4 bits left
+ * to sit above the 4-bit mantissa. The RFC again shifts this
+ * entire block left by (exp + 3) to reconstruct the value.
+ * So, 'hidden bit' is the MSB which is shifted by (4 + exp + 3).
+ *
+ * Total left shift of the 'hidden bit' = 4 + (exp + 3) = exp + 7.
+ * This is the MSB at the 0-based bit position: (exp + 7).
+ * Since fls() is 1-based, fls(value) - 1 = exp + 7.
+ *
+ * Therefore:
+ *     exp  = fls(value) - 8
+ *     mant = (value >> (exp + 3)) & 0x0F
+ *
+ * Final encoding formula:
+ *     0x80 | (exp << 4) | mant
+ *
+ * Example (value = 3200):
+ *  0               1
+ *  0 1 2 3 4 5 6 7 0 1 2 3 4 5 6 7
+ * +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
+ * |0 0 0 0 1 1 0 0 1 0 0 0 0 0 0 0| (value = 3200)
+ * |        ^-^-mant^ ^..(exp+3)..^| exp = 4, mant = 9
+ * +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
+ *
+ * Encoded:
+ *   0x80 | (4 << 4) | 9 = 0xC9
+ */
+static inline u8 igmpv3_exp_field_encode(unsigned long value)
+{
+	u8 mc_exp, mc_man;
+
+	/* RFC3376: QQIC/MRC < 128 is literal */
+	if (value < IGMPV3_EXP_MIN_THRESHOLD)
+		return (u8)value;
+
+	/* Saturate at max representable (mant = 0xF, exp = 7) -> 31744 */
+	if (value >= IGMPV3_EXP_MAX_THRESHOLD)
+		return 0xFF;
+
+	mc_exp  = (u8)(fls(value) - 8);
+	mc_man = (u8)((value >> (mc_exp + 3)) & 0x0F);
+
+	return 0x80 | (mc_exp << 4) | mc_man;
+}
+
+/* Calculate Maximum Response Code from Max Resp Time */
+static inline u8 igmpv3_mrc(unsigned long mrt)
+{
+	/* RFC3376, relevant sections:
+	 *  - 4.1.1. Maximum Response Code
+	 *  - 8.3. Query Response Interval
+	 */
+	return igmpv3_exp_field_encode(mrt);
+}
+
+/* Calculate Querier's Query Interval Code from Query Interval */
+static inline u8 igmpv3_qqic(unsigned long qi)
+{
+	/* RFC3376, relevant sections:
+	 *  - 4.1.7. QQIC (Querier's Query Interval Code)
+	 *  - 8.2. Query Interval
+	 *  - 8.12. Older Version Querier Present Timeout
+	 *    (the [Query Interval] in the last Query received)
+	 */
+	return igmpv3_exp_field_encode(qi);
+}
 
 /* V3 exponential field decoding */
 
diff --git a/net/bridge/br_multicast.c b/net/bridge/br_multicast.c
index 1438c023db62..1de6242413e0 100644
--- a/net/bridge/br_multicast.c
+++ b/net/bridge/br_multicast.c
@@ -939,7 +939,7 @@ static struct sk_buff *br_ip4_multicast_alloc_query(struct net_bridge_mcast *brm
 	struct sk_buff *skb;
 	struct igmphdr *ih;
 	struct ethhdr *eth;
-	unsigned long lmqt;
+	unsigned long lmqt, mrt;
 	struct iphdr *iph;
 	u16 lmqt_srcs = 0;
 
@@ -1004,15 +1004,15 @@ static struct sk_buff *br_ip4_multicast_alloc_query(struct net_bridge_mcast *brm
 	skb_put(skb, 24);
 
 	skb_set_transport_header(skb, skb->len);
+	mrt = group ? brmctx->multicast_last_member_interval :
+		      brmctx->multicast_query_response_interval;
 	*igmp_type = IGMP_HOST_MEMBERSHIP_QUERY;
 
 	switch (brmctx->multicast_igmp_version) {
 	case 2:
 		ih = igmp_hdr(skb);
 		ih->type = IGMP_HOST_MEMBERSHIP_QUERY;
-		ih->code = (group ? brmctx->multicast_last_member_interval :
-				    brmctx->multicast_query_response_interval) /
-			   (HZ / IGMP_TIMER_SCALE);
+		ih->code = mrt / (HZ / IGMP_TIMER_SCALE);
 		ih->group = group;
 		ih->csum = 0;
 		csum = &ih->csum;
@@ -1021,11 +1021,9 @@ static struct sk_buff *br_ip4_multicast_alloc_query(struct net_bridge_mcast *brm
 	case 3:
 		ihv3 = igmpv3_query_hdr(skb);
 		ihv3->type = IGMP_HOST_MEMBERSHIP_QUERY;
-		ihv3->code = (group ? brmctx->multicast_last_member_interval :
-				      brmctx->multicast_query_response_interval) /
-			     (HZ / IGMP_TIMER_SCALE);
+		ihv3->code = igmpv3_mrc(mrt / (HZ / IGMP_TIMER_SCALE));
 		ihv3->group = group;
-		ihv3->qqic = brmctx->multicast_query_interval / HZ;
+		ihv3->qqic = igmpv3_qqic(brmctx->multicast_query_interval / HZ);
 		ihv3->nsrcs = htons(lmqt_srcs);
 		ihv3->resv = 0;
 		ihv3->suppress = sflag;
-- 
2.43.0


