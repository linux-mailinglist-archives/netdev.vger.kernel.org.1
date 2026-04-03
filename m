Return-Path: <netdev+bounces-275096-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wOn+MwbZz2mb1AYAu9opvQ
	(envelope-from <netdev+bounces-275096-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 03 Apr 2026 17:13:10 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 49696395A86
	for <lists+netdev@lfdr.de>; Fri, 03 Apr 2026 17:13:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A9AAF305BFD0
	for <lists+netdev@lfdr.de>; Fri,  3 Apr 2026 15:02:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 870193CAE73;
	Fri,  3 Apr 2026 15:01:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R/SkfL3L"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 253AD20D4FF
	for <netdev@vger.kernel.org>; Fri,  3 Apr 2026 15:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775228485; cv=none; b=SadmK7Ro/Z6jCelMco/uhk+Z7v2ul4dTL95/j57kQPzQM33/UeOeNs21O0LNM+2NPY5Uuv6eMHoUmQ3wPtU15uo5DImT+C4VVcXNZN9tPIjZtUBxIr3FW4DsZ+ba3irdHvUgrF1TuVY0VEDm83fQdPMOugHKDD5QvtFk8roNawk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775228485; c=relaxed/simple;
	bh=Iq0tktjsX7ePEwq4lGlKSL1uL+gib4ijw7o7rXmI/94=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=STSn48/XIlRGMCsM2ehvTo6mZAmy6ZKgkelW0WN4T5od/HmkzsUNchQkawD1X+Nbv9S6QJFNZ8hhjXupfOt3DsSs2l7C53LOuRWq/iAoWBa9z5iWDNCleSjRfkpYRJjp/oho3GXheQm60W01NeIi7tdkKbdKDk6ARvamLOdyIyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R/SkfL3L; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-82cf976ecacso842385b3a.1
        for <netdev@vger.kernel.org>; Fri, 03 Apr 2026 08:01:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775228483; x=1775833283; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W4ZMqjHC+tTjU8qo0ldftPqXLWyA0cBMe3rgBvQvxRs=;
        b=R/SkfL3LfPD87zNE2s1P8hPgDrSK6kInPW9wUSZtd1tle2Ev+GirPlMTuZJ2kfM56p
         bqF5wjzJrOJyRXEkmmOY69jzceaXpGmUhbs/UwxhvZLYZR6i6xyolD/x2oCJmVPvq7Fu
         PTKTXIN3ko9d2Uqi3z+osAEnEK9E1d6OZexVJZtlYouGm6pUrCZvOhmukq0hADDFpH7M
         r8DvHK+7PBWs/PpPiTqWlIFuBXg0V0DP7/74m2leMIkDcp14xDq76uC0lIbXE09kZ7gf
         U7NmJXSNX2ApxvKvrPcOdtmvhQIPaeDI+REwSSQY3qo8jYwg5ZsGXYShY8E9fAncRHUY
         pm3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775228483; x=1775833283;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=W4ZMqjHC+tTjU8qo0ldftPqXLWyA0cBMe3rgBvQvxRs=;
        b=suYT/DNlZ3tHJJBGwTGm8BTiPWs9lmxhYrtVL5W98JnG6/THwVCM6bCKiAvjPyo0O5
         k+TOb6fRWM8T1h3/d5ZqdQejihoYdCNL+2FmT8oCWX3GmqjaX3gdpXEdRNose6pIKrDF
         XI5X3QAntCS9tUrfE/zwttvpP9ZWXLYuwqHHMxKh5/jEh+yPgFw/wRHefe9tP4LvOLQ9
         SCjOVGgcLl6gcXs7sHlw889nN+lnn8FhHLKiR5DQ//ssatFyNO5PitrHpKBaF1xUVPGk
         4xsBHQKRaeXz+B0oeocfz0VG10alyj3xr4d3s/fShpj0P73DhhHkvFAqKnLgaj6EEZyt
         7vFg==
X-Forwarded-Encrypted: i=1; AJvYcCWmqnYvvlCs0MVjme5v/B+URVmiIHcux/5mVZ3YwcwdywWVhhNagPN6pcumBwFVRXbNWd/kJ84=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+/IhFPiwoWd4jmL2Fv/nBJfa3JfYZoLvWdVzbS2tP+ufLEBSe
	D9O0brUii+MND4VAmHQmKLSdOqz4zGuAxkYHnZeoCHS6mqHVQP/9Qz9K
X-Gm-Gg: ATEYQzxPDRu3a3ZAOH+riIr5eCyR3uyf/R7lssJP7wIsAoRU8SvgfmUNDwnrqP9q2ex
	mKpsfFc8M4TK+PzD5ys7gITUTmzOcKq1OqRfTEpUenf2mGBFeO/cmAH3U5k54jeoXdlRFBZbIUe
	y171dTdS3tCEQ7WLTq2CmhCkh2wMTAM9hY4Ml3yP6NpN/Z1UV8paY0wWu/pHYTtpUEQ40d4SFTw
	afb+WnfS2IBZVqoNXEtYfhDuJ+afAuEHJMnS55MoDgXRbOSzOccC1oAWjjLtFAZCoMpfl3chDIY
	BXpF0bmp32kZH1xprS2le2UMzF7AGKgP6nJ0OYwfu1ZTOfptNxieEZOc5FmWObHTc75zHH0lLal
	9lN2+Fi7ECM/uzxR/Y2sPbITEXLEZuaoGddMAFff7wtxtwB6Yf1hLylxsbiwSTFuiIWnmN3rDCb
	majxlkpw/ebk9ZphKpX0ajQQ4K5rn0Hc2hGN6/T2i08DhsC32hJT8=
X-Received: by 2002:a05:6a00:4397:b0:829:862d:6b46 with SMTP id d2e1a72fcca58-82d0da2f24bmr3265722b3a.6.1775228482267;
        Fri, 03 Apr 2026 08:01:22 -0700 (PDT)
Received: from DESKTOP-82PPU4A.localdomain ([202.8.116.192])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82cf9ca79basm7789483b3a.58.2026.04.03.08.01.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Apr 2026 08:01:20 -0700 (PDT)
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
Subject: [PATCH net-next v3 3/5] ipv4: igmp: encode multicast exponential fields
Date: Fri,  3 Apr 2026 15:00:48 +0000
Message-ID: <20260403150050.1235-4-royujjal@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260403150050.1235-1-royujjal@gmail.com>
References: <20260403150050.1235-1-royujjal@gmail.com>
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
	RCPT_COUNT_TWELVE(0.00)[17];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-275096-lists,netdev=lfdr.de];
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
X-Rspamd-Queue-Id: 49696395A86
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

In IGMP, QQIC and MRC fields are not correctly encoded
when generating query packets. Since the receiver of the
query interprets these fields using the IGMPv3 floating-
point decoding logic, any value that exceeds the linear
threshold is incorrectly parsed as an exponential value,
leading to an incorrect interval calculation.

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
 include/linux/igmp.h      | 87 +++++++++++++++++++++++++++++++++++++++
 net/bridge/br_multicast.c | 14 +++----
 2 files changed, 93 insertions(+), 8 deletions(-)

diff --git a/include/linux/igmp.h b/include/linux/igmp.h
index 0624410e75c6..4e895829cd0e 100644
--- a/include/linux/igmp.h
+++ b/include/linux/igmp.h
@@ -109,6 +109,93 @@ struct ip_mc_list {
 
 /* IGMPV3 floating-point exponential field threshold */
 #define IGMPV3_EXP_MIN_THRESHOLD	128
+/* Max representable (mant = 0xF, exp = 7) -> 31744 */
+#define IGMPV3_EXP_MAX_THRESHOLD	31744
+
+/* V3 exponential field encoding */
+
+/* IGMPv3 QQIC/MRC 8-bit exponential field encode.
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
+ * MRC represents the encoded form of Max Resp Time (MRT); once
+ * decoded, the resulting value is in units of 0.1 seconds (100 ms).
+ */
+static inline u8 igmpv3_mrc(unsigned long mrt)
+{
+	/* RFC3376, relevant sections:
+	 *  - 4.1.1. Maximum Response Code
+	 *  - 8.3. Query Response Interval
+	 */
+	return igmpv3_exp_field_encode(mrt);
+}
+
+/* Calculate Querier's Query Interval Code from Query Interval
+ *
+ * QQIC represents the encoded form of Query Interval (QI); once
+ * decoded, the resulting value is in units of seconds.
+ */
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


