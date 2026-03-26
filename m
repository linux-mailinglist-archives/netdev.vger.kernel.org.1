Return-Path: <netdev+bounces-272109-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UNKnAxxOxWkU8wQAu9opvQ
	(envelope-from <netdev+bounces-272109-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 16:17:48 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 73F08337678
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 16:17:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0ABDF30EF87D
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 15:08:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CD73402BB3;
	Thu, 26 Mar 2026 15:08:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qHNMVPpp"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D08DA3FFACD
	for <netdev@vger.kernel.org>; Thu, 26 Mar 2026 15:08:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774537691; cv=none; b=FcOdDzfyfOaRHsEgiHv/IgVxreRyipAi1vbQ6i8I/YQ0Jtz76VwCxnWZNbWZV8vg8+C7XlQzI3iqxozlHfrxXfoI4YlVWkPKK3UJyFEP/kBQt8pvMjitcGwCukiJIQZk9b8oZPPVlfc2yPxeXmK8UzOOjYR/1ZODQ/mrvRCy8V0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774537691; c=relaxed/simple;
	bh=e55NJdo7/A3hpAJ6kxWohOaV0421uYsdnSxjy1Zm6Lw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BVnKtGQ6/QUVmdWJgei6TsluBOOiGdltLNYpaaQ+ETghzV0FVV+wsGhJtlmjjJqaJIzSneRqY/Qr0pmcJdz7N4hroBDHv7F2Wd/vHXSFbrGogC2W6Sk7MXDjkFIuBijKPCB8j2tDzpk2qXrR0rcx9yuS+b/bBVRTnuRqPktG/70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qHNMVPpp; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2ab46931cf1so16742995ad.0
        for <netdev@vger.kernel.org>; Thu, 26 Mar 2026 08:08:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774537689; x=1775142489; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=49SPRabqR++4MRXv28bpRM0Zk1UkXQGuUNet1+Gr+HM=;
        b=qHNMVPppwIw4iacGM9wz+nuvNkEeCyPFWyMCMRLLvEC30sfUx+we9o+bVtjnk5xwA4
         8zV0W65CevKwWTOP9nK9uiUYnoFzcfLSrKEx2mb5iXqCEdP1eWuAZEYy9itKh5LEZvY7
         s1jnUxomVf+Jinjn4y2fOmWFpnh477rqNk711ugMO4HYYdWmxzpaaLszJi/WGOmLp7Lm
         B4yrhgqYGapGhb3RABoVSUq+us94syegHls927D82Sbnm6N/1a9DKmiDFhnmGKu2Jqv5
         wVWEBZYLkJo2+PXlu8+AqnOBX1+hD1BJvxiIi37Dm1ktduxiIRhH/x4pwfTYEJ2GZNx+
         Q0+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774537689; x=1775142489;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=49SPRabqR++4MRXv28bpRM0Zk1UkXQGuUNet1+Gr+HM=;
        b=JY24Z0sPF6EJakC7NuhWc4/GkGsAxSuvD9wa7/NPt5bJRCuU6g8qFUzipi56vmxmLW
         /7w+gTrRzvHssys5fQS1vbuTFb0+jDFm9AbeZ4CvUGsCNOwGCzOt0W0OaFuFy3jvdIiR
         PHrK+9MUh2Ss58bL+84zZiDNtYWl8qN21XhcdutPx+CbhyvuLLlzbJhTknoBcD7xIWfS
         sJl6pe1gfDoduZ+nSKzdbnTo35YhpcgKb4UOXdmIX4f8kM7gdeuY6DeNe2VLHU5hTjRn
         SXAqzJoNRl14JEpYdHuJnS+kMJpSQM0jqdFAMew0EUsqyuvpQ+nzkK1zj5LNatt/7oek
         Q5EA==
X-Forwarded-Encrypted: i=1; AJvYcCWf+dK1YX4Q8jwoQ0muNb15R8vd4+OAig5TfCbXdk6I/lgeV/wOVXVeMdV2P2rTsuNZktX7B3Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YwW0nXGnDqIrePGa/Do/48Tk6MzzZXBIidJhufm7K/KQ/Manlnb
	TObO9umOaatuQc+SSZ7R4SRHnxZIQFNpAJuNooqFIocXYN0jET5WhCc03pa4r62BSoc=
X-Gm-Gg: ATEYQzygj4q7NqG4GYrQ/msy4H/UZQfZhte7f3TmrnN+RiNEb+ZfUSllvQkH6QGv9bD
	JYPAmQkCDfumUKB92yJ/WFawaaMK75ykiZRHXaiLBrG9EgbhgEE1AOapi8hHrtcjE4Db9cVov0Y
	y082VzUrH8X6DJHpjiGRu6Sf0Bb5sfG/+ZJBC2sg5gNK/+Any2GRl1+hXp2HqgxIEYjmOTe+F0U
	zBVHf5jtpnT9rufp/TBa3zvkcBybY3O02EzqHXfGi+j5QLGstZY8lD00HfWciv9favQ9nnRW0Hy
	3Tv9qv76SmnoWBXAIl4M4X73eusclkhdYO5o0zojMBDlnTh95+3iQEGkTB+cUQTNXZRQDiuf7AJ
	8kIGs7ax3ekVP7jQ0lL9Ctyz5T9JcKYxuJ/8e1zRYPLoqUURcICXRStJwf2HA6BIwZ5BuQT4nnH
	MVfWF9GpqomEURVL1vDEulaFMmyO8YUU7KjDblHUpEvArcxXEL/bw=
X-Received: by 2002:a17:902:f712:b0:2b0:ba48:274 with SMTP id d9443c01a7336-2b0c4818b3cmr20475495ad.1.1774537689063;
        Thu, 26 Mar 2026 08:08:09 -0700 (PDT)
Received: from DESKTOP-82PPU4A.localdomain ([202.8.116.170])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b0bc8bb5fasm33146375ad.59.2026.03.26.08.08.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Mar 2026 08:08:08 -0700 (PDT)
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
Subject: [PATCH 4/4] ipv6: mld: encode multicast exponential fields
Date: Thu, 26 Mar 2026 15:07:42 +0000
Message-ID: <20260326150742.50289-5-royujjal@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-272109-lists,netdev=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 73F08337678
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

In MLD, QQIC and MRC fields are not currently encoded when
generating query packets. Since the receiver of the query
interprets these fields using the MLDv2 floating-point
decoding logic, any raw interval value that exceeds the
linear threshold is currently parsed incorrectly as an
exponential value, leading to an incorrect interval
calculation.

Encode and assign the corresponding protocol fields during
query generation. Introduce the logic to dynamically
calculate the exponent and mantissa using bit-scan (fls).
This ensures QQIC (8-bit) and MRC (16-bit) fields are
properly encoded when transmitting query packets with
intervals that exceed their respective linear thresholds
(128 for QQI; 32768 for MRD).

RFC3810: If QQIC >= 128, the QQIC field represents a
floating-point value as follows:
     0 1 2 3 4 5 6 7
    +-+-+-+-+-+-+-+-+
    |1| exp | mant  |
    +-+-+-+-+-+-+-+-+

RFC3810: If Maximum Response Code >= 32768, the Maximum
Response Code field represents a floating-point value as
follows:
     0 1 2 3 4 5 6 7 8 9 A B C D E F
    +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
    |1| exp |          mant         |
    +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+

Signed-off-by: Ujjal Roy <royujjal@gmail.com>
---
 include/net/mld.h         | 117 ++++++++++++++++++++++++++++++++++++++
 net/bridge/br_multicast.c |   4 +-
 2 files changed, 119 insertions(+), 2 deletions(-)

diff --git a/include/net/mld.h b/include/net/mld.h
index 6373eb76efe5..0962312d29b9 100644
--- a/include/net/mld.h
+++ b/include/net/mld.h
@@ -90,12 +90,129 @@ struct mld2_query {
 #define MLDV2_QQIC_MAN(value)	((value) & 0x0f)
 
 #define MLD_QQIC_MIN_THRESHOLD	128
+/* Max representable (mant = 0xF, exp = 7) -> 31744 */
+#define MLD_QQIC_MAX_THRESHOLD	31744
 #define MLD_MRC_MIN_THRESHOLD	32768UL
+/* Max representable (mant = 0xFFF, exp = 7) -> 8387584 */
+#define MLD_MRC_MAX_THRESHOLD	8387584
 #define MLDV1_MRD_MAX_COMPAT	(MLD_MRC_MIN_THRESHOLD - 1)
 
 #define MLD_MAX_QUEUE		8
 #define MLD_MAX_SKBS		32
 
+/* V2 exponential field encoding */
+
+/*
+ * Calculate Maximum Response Code from Maximum Response Delay
+ *
+ * MLDv2 Maximum Response Code 16-bit encoding (RFC3810).
+ *
+ * RFC3810 defines only the decoding formula:
+ * Maximum Response Delay = (mant | 0x1000) << (exp + 3)
+ *
+ * but does NOT define the encoding procedure. To derive exponent:
+ *
+ * For the 16-bit MRC, the "hidden bit" (0x1000) is left shifted by 12
+ * to sit above the 12-bit mantissa. The RFC then shifts this entire
+ * block left by (exp + 3) to reconstruct the value.
+ * So, 'hidden bit' is the MSB which is shifted by (12 + exp + 3).
+ *
+ * - Total left shift of the hidden bit = 12 + (exp + 3) = exp + 15.
+ * - This is the MSB at the 0-based bit position: (exp + 15).
+ * - Since fls() is 1-based, fls(value) - 1 = exp + 15.
+ *
+ * Therefore:
+ *     exp  = fls(value) - 16
+ *     mant = (value >> (exp + 3)) & 0x0FFF
+ *
+ * Final encoding formula:
+ *     0x8000 | (exp << 12) | mant
+ *
+ * Example (value = 1311744):
+ *  0               1               2               3
+ *  0 1 2 3 4 5 6 7 0 1 2 3 4 5 6 7 0 1 2 3 4 5 6 7 0 1 2 3 4 5 6 7
+ * +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
+ * |0 0 0 0 0 0 0 0 0 0 0 1 0 1 0 0 0 0 0 0 0 1 0 0 0 0 0 0 0 0 0 0| 1311744
+ * |                      ^-^--------mant---------^ ^...(exp+3)...^| exp=5
+ * +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
+ *
+ * Encoded:
+ *   0x8000 | (5 << 12) | 0x404 = 0xD404
+ */
+static inline u16 mldv2_mrc(unsigned long mrd)
+{
+	u16 mc_man, mc_exp;
+
+	/* RFC3810: MRC < 32768 is literal */
+	if (mrd < MLD_MRC_MIN_THRESHOLD)
+		return (u16)mrd;
+
+	/* Saturate at max representable (mant = 0xFFF, exp = 7) -> 8387584 */
+	if (mrd >= MLD_MRC_MAX_THRESHOLD)
+		return 0xFFFF;
+
+	mc_exp = (u16)(fls(mrd) - 16);
+	mc_man = (u16)((mrd >> (mc_exp + 3)) & 0x0FFF);
+
+	return (0x8000 | (mc_exp << 12) | mc_man);
+}
+
+/*
+ * Calculate Querier's Query Interval Code from Query Interval
+ *
+ * MLDv2 QQIC 8-bit floating-point encoding (RFC3810).
+ *
+ * RFC3810 defines only the decoding formula:
+ * QQI = (mant | 0x10) << (exp + 3)
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
+static inline u8 mldv2_qqic(unsigned long value)
+{
+	u8 mc_man, mc_exp;
+
+	/* RFC3810: QQIC < 128 is literal */
+	if (value < MLD_QQIC_MIN_THRESHOLD)
+		return (u8)value;
+
+	/* Saturate at max representable (mant = 0xF, exp = 7) -> 31744 */
+	if (value >= MLD_QQIC_MAX_THRESHOLD)
+		return 0xFF;
+
+	mc_exp  = (u8)(fls(value) - 8);
+	mc_man = (u8)((value >> (mc_exp + 3)) & 0x0F);
+
+	return (0x80 | (mc_exp << 4) | mc_man);
+}
+
 /* V2 exponential field decoding */
 
 /* Calculate Maximum Response Delay from Maximum Response Code
diff --git a/net/bridge/br_multicast.c b/net/bridge/br_multicast.c
index 1de6242413e0..c59dab6fff4e 100644
--- a/net/bridge/br_multicast.c
+++ b/net/bridge/br_multicast.c
@@ -1181,7 +1181,7 @@ static struct sk_buff *br_ip6_multicast_alloc_query(struct net_bridge_mcast *brm
 		break;
 	case 2:
 		mld2q = (struct mld2_query *)icmp6_hdr(skb);
-		mld2q->mld2q_mrc = htons((u16)jiffies_to_msecs(interval));
+		mld2q->mld2q_mrc = htons((u16)jiffies_to_msecs(mldv2_mrc(interval)));
 		mld2q->mld2q_type = ICMPV6_MGM_QUERY;
 		mld2q->mld2q_code = 0;
 		mld2q->mld2q_cksum = 0;
@@ -1190,7 +1190,7 @@ static struct sk_buff *br_ip6_multicast_alloc_query(struct net_bridge_mcast *brm
 		mld2q->mld2q_suppress = sflag;
 		mld2q->mld2q_qrv = 2;
 		mld2q->mld2q_nsrcs = htons(llqt_srcs);
-		mld2q->mld2q_qqic = brmctx->multicast_query_interval / HZ;
+		mld2q->mld2q_qqic = mldv2_qqic(brmctx->multicast_query_interval / HZ);
 		mld2q->mld2q_mca = *group;
 		csum = &mld2q->mld2q_cksum;
 		csum_start = (void *)mld2q;
-- 
2.43.0


