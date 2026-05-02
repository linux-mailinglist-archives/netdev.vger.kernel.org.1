Return-Path: <netdev+bounces-283413-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aNxzLi/69WkHRAIAu9opvQ
	(envelope-from <netdev+bounces-283413-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 02 May 2026 15:20:47 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E2D04B2205
	for <lists+netdev@lfdr.de>; Sat, 02 May 2026 15:20:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 650D5300F7B6
	for <lists+netdev@lfdr.de>; Sat,  2 May 2026 13:19:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B5D724887E;
	Sat,  2 May 2026 13:19:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cjNoVqab"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A08D22417DE
	for <netdev@vger.kernel.org>; Sat,  2 May 2026 13:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777727983; cv=none; b=kYPixuHbStz2zsYtVuvj932y6hE2PlRgE/pMJfYFprB9bPprZU3NdDEUhrhFOyB3NDkPgUftvjdYGCQkpo0LHBeP9LI52GbAhG/d5w4hw/4BzECmsXjmvjnSY5k36xy9Ed1pmJxdsRFxwEAjt8v9f1qjqFvzRIWWUMshOV06MEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777727983; c=relaxed/simple;
	bh=Gt27CTUkBy3/9y5hHiuXgkkQRu0kM5q36flW22f2Fr0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=t48TbaZqeKBqfj9B9hX9inn7bzpmhQ1Vnxekbq6eV/4PaOPQZcJLURg6F2h39uUqee6ZWV6Roh1fcEIkhKHxwXZq7yGBVsPuZzIO1cgxUa0jjDbnn9epM1T5WjWSCZoAIsCu3VigVK7MvtAhLbyj++AI0L8g828F/ARXN4Us/7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cjNoVqab; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-c80167f5716so107630a12.2
        for <netdev@vger.kernel.org>; Sat, 02 May 2026 06:19:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777727981; x=1778332781; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jmZ9G/rM0nAD31XWpPt5TscDsPxaAtvREA8xoPmeb2k=;
        b=cjNoVqabfn3bq+koMiK4tYNoIVuwhBq61yFZml56kjHJVDoVuX8OWAGcCw4UIPdDpe
         VrQbUktJhajssRcbRc95PIIzC2jbsV7jKGF5PmIk9M8auJlvGRwg50TpadRM56Lxcc7t
         74gZ7Pijjxn+u0e4a/zEdy3b92TlyPJdmFaiu8JlnQ3XVgVKm2ilUbYw4aWFzp8Pfjvg
         p9XYupJD7aXCQnh4GjEaveGlab9ren2D/rLYg3qG6kcPSMlVMtDZl89o7NOOd1vZSJEV
         IwlGmA71XU4yzjv9HuiututHCpccV9fenHjUjLkR562CL0pusOjdxXBQ/OhxVQFUdAf+
         IOVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777727981; x=1778332781;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=jmZ9G/rM0nAD31XWpPt5TscDsPxaAtvREA8xoPmeb2k=;
        b=OCFWmFez4N59KFDKBdfA+Kl8f9tr6X2NMAHAE19HZPuujiDxEViFfznZvuaZbFyj4M
         npUl9qvM6E0AFi3jD73M0AlGJPOTgyLPugZNaRPFO/EjYFGKJVZSfXyI3wQmJ4pc0ypC
         5ZmXX9tF4nv0FOTLZ675zSRq08+/rN1uqzErD8vOF7gt7h9SwywS1HT2dRFDMO3qvuZy
         6To75kK5ZOcbND1hQxyDAj3GysJeYjc+ixdROUkDo1LSlFLO8qy/HHxVRlvUxQWSh8rr
         9JGTwxcNYRwkYV8Qg8MSKKA5glYoHhWDm+RzbBrPZytArZ0A7gGZjJb05R5704qVVr7w
         xCRg==
X-Forwarded-Encrypted: i=1; AFNElJ8vRhoCnVHP6x3NAwthGK44X1SRPK+YdDpxdqJ9acTD86fYDnu+ClIq8dJ6khQ3TDQonyh8Dwk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxImIaM1ALl4L7iSvyTxhQLB0E7O+G+r2aDdOko/sGtKlYZ3Pon
	WdDQHzOCjtkHh3A0/KCIofS9WYHRpUsL+69qIsGMsPdJs9A0qIh3YxqF
X-Gm-Gg: AeBDiesEIRVMS+bVTEDeSk8uapsKyPEPmyQlHmMVfHz9UC2w+OJbaQUUuW9omcCnrxB
	L1AtvMM1cQP65GZGUfhqo0q6kiHipsbZp2NySO/ryND4pn9mWxp7puqz7idzjZlFEgaHAdmWRzT
	yB18opPtSkRBkI0r+c6uzOna7vZslEnkYNv6QqdRjd4xZ76XTfN1VpJW1RoQBZ5mKWRxCaBB8Eu
	05BxvwTxTcXLM1Sx9UD4WlM4GikVhhD2A9QBmVRHMuZfVINUacyQPqX+ZRK1ykPxXIKQ3xP/qu4
	kSvsS7gDNg5z+rQNxPXccXvs3cRHIQnNKa/jKqrl0IKYYxDN/7VFAprDPgjcDPmpXdkg9rXC8Cb
	U8xEJqdp3Jqy5aW7ZRdAvaeYHFJwiX57F4yhXn/f1halk6eqYSrsRI85yC3elgxeU1xhInLoB5s
	usSkKSR08UsOfJqo4YTcEjkavquqyVAExnkz21vEjqZjiGQO/E1g==
X-Received: by 2002:a05:6a20:12ca:b0:39c:c07:1450 with SMTP id adf61e73a8af0-3a7f1c748f6mr2909119637.42.1777727980852;
        Sat, 02 May 2026 06:19:40 -0700 (PDT)
Received: from DESKTOP-82PPU4A.localdomain ([202.8.116.84])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-83515ad0176sm5553791b3a.39.2026.05.02.06.19.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 May 2026 06:19:39 -0700 (PDT)
From: Ujjal Roy <royujjal@gmail.com>
To: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Ido Schimmel <idosch@nvidia.com>,
	David Ahern <dsahern@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	Andy Roulin <aroulin@nvidia.com>,
	Yong Wang <yongwang@nvidia.com>,
	Petr Machata <petrm@nvidia.com>
Cc: Ujjal Roy <ujjal@alumnux.com>,
	bridge@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH net-next v6 3/5] ipv4: igmp: encode multicast exponential fields
Date: Sat,  2 May 2026 13:19:04 +0000
Message-ID: <20260502131907.987-4-royujjal@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260502131907.987-1-royujjal@gmail.com>
References: <20260502131907.987-1-royujjal@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4E2D04B2205
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-283413-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[royujjal@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,blackwall.org:email,nvidia.com:email]

In IGMP, MRC and QQIC fields are not correctly encoded
when generating query packets. Since the receiver of the
query interprets these fields using the IGMPv3 floating-
point decoding logic, any value that exceeds the linear
threshold is incorrectly parsed as an exponential value,
leading to an incorrect interval calculation.

Encode and assign the corresponding protocol fields during
query generation. Introduce the logic to dynamically
calculate the exponent and mantissa using bit-scan (fls).
This ensures MRC and QQIC fields (8-bit) are properly
encoded when transmitting query packets with intervals
that exceed their respective linear threshold value of
128 (for MRT/QQI).

RFC3376: for both MRC and QQIC, values >= 128 represent
the same floating-point encoding as follows:
     0 1 2 3 4 5 6 7
    +-+-+-+-+-+-+-+-+
    |1| exp | mant  |
    +-+-+-+-+-+-+-+-+

Reviewed-by: Nikolay Aleksandrov <razor@blackwall.org>
Reviewed-by: Ido Schimmel <idosch@nvidia.com>
Signed-off-by: Ujjal Roy <royujjal@gmail.com>
---
 include/linux/igmp.h      | 87 +++++++++++++++++++++++++++++++++++++++
 net/bridge/br_multicast.c | 14 +++----
 2 files changed, 93 insertions(+), 8 deletions(-)

diff --git a/include/linux/igmp.h b/include/linux/igmp.h
index 0e095c9f234e..3a2d35a9f307 100644
--- a/include/linux/igmp.h
+++ b/include/linux/igmp.h
@@ -109,6 +109,93 @@ struct ip_mc_list {
 
 /* IGMPv3 floating-point exponential field min threshold */
 #define IGMPV3_EXP_MIN_THRESHOLD	128
+/* IGMPv3 FP max threshold (mant = 0xF, exp = 7) -> 31744 */
+#define IGMPV3_EXP_MAX_THRESHOLD	31744
+
+/* V3 exponential field encoding */
+
+/* IGMPv3 MRC/QQIC 8-bit exponential field encode
+ *
+ * RFC3376, 4.1.1 & 4.1.7. defines only the decoding formula:
+ *     MRT/QQI = (mant | 0x10) << (exp + 3)
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
+	/* MRC/QQIC < 128 is literal */
+	if (value < IGMPV3_EXP_MIN_THRESHOLD)
+		return value;
+
+	/* Saturate at max representable (mant = 0xF, exp = 7) -> 31744 */
+	if (value >= IGMPV3_EXP_MAX_THRESHOLD)
+		return 0xFF;
+
+	mc_exp  = fls(value) - 8;
+	mc_man = (value >> (mc_exp + 3)) & 0x0F;
+
+	return 0x80 | (mc_exp << 4) | mc_man;
+}
+
+/* Calculate Maximum Response Code from Max Resp Time
+ *
+ * RFC3376, relevant sections:
+ *  - 4.1.1. Maximum Response Code
+ *  - 8.3. Query Response Interval
+ *
+ * MRC represents the encoded form of Max Resp Time (MRT); once
+ * decoded, the resulting value is in units of 0.1 seconds (100 ms).
+ */
+static inline u8 igmpv3_mrc(unsigned long mrt)
+{
+	return igmpv3_exp_field_encode(mrt);
+}
+
+/* Calculate Querier's Query Interval Code from Querier's Query Interval
+ *
+ * RFC3376, relevant sections:
+ *  - 4.1.7. QQIC (Querier's Query Interval Code)
+ *  - 8.2. Query Interval
+ *  - 8.12. Older Version Querier Present Timeout
+ *    (the [Query Interval] in the last Query received)
+ *
+ * QQIC represents the encoded form of Querier's Query Interval (QQI);
+ * once decoded, the resulting value is in units of seconds.
+ */
+static inline u8 igmpv3_qqic(unsigned long qi)
+{
+	return igmpv3_exp_field_encode(qi);
+}
 
 /* V3 exponential field decoding */
 
diff --git a/net/bridge/br_multicast.c b/net/bridge/br_multicast.c
index 1438c023db62..27010744d7ae 100644
--- a/net/bridge/br_multicast.c
+++ b/net/bridge/br_multicast.c
@@ -934,12 +934,12 @@ static struct sk_buff *br_ip4_multicast_alloc_query(struct net_bridge_mcast *brm
 	size_t pkt_size, igmp_hdr_size;
 	unsigned long now = jiffies;
 	struct igmpv3_query *ihv3;
+	unsigned long lmqt, mrt;
 	void *csum_start = NULL;
 	__sum16 *csum = NULL;
 	struct sk_buff *skb;
 	struct igmphdr *ih;
 	struct ethhdr *eth;
-	unsigned long lmqt;
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


