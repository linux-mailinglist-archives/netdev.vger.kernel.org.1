Return-Path: <netdev+bounces-283414-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WLXUCVj69WkHRAIAu9opvQ
	(envelope-from <netdev+bounces-283414-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 02 May 2026 15:21:28 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 95C234B221B
	for <lists+netdev@lfdr.de>; Sat, 02 May 2026 15:21:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1C4A13031018
	for <lists+netdev@lfdr.de>; Sat,  2 May 2026 13:19:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CA8225742F;
	Sat,  2 May 2026 13:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pz83j5o/"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D3C12147E5
	for <netdev@vger.kernel.org>; Sat,  2 May 2026 13:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777727992; cv=none; b=dgAyWVvcAzYovAGAMYRVq5MZSIKj9dU4JDhtjrmotjjt1qzEfrdcYwzjHYzYOBWjZaa8OJmLg7YsReGGTq0215BI4G9nbIQjgR1Pea4Rly4Too9OVuTqpmeQsXlUPzVLbnGQpEGVOvNybxo35kW/x0Ndwv2XC2u5qGCpTK2bpRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777727992; c=relaxed/simple;
	bh=jJnc0mGZNzy4u3y501gtICX3ws5YMm+lbxgjciB6cvg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=e9M8BcD3YgV3wvh9oIdyQMrFrUe9myiqmVnKaBjUZzXjxx8hzFv3pbEyyxofmoHPgKVoIbQMFrMPon3g17z2kWOOhu02Ruvsb1XnYdpeM6RRSk828ugI3RgGclRgek5x9x3JqYyUl517HK8sKAwAmG2wQ7+iZsuqNcBTfiSSbPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Pz83j5o/; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-82ce2e2880cso1815693b3a.0
        for <netdev@vger.kernel.org>; Sat, 02 May 2026 06:19:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777727989; x=1778332789; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zl++HpBCtAW5kzSiDlCg+WmmabaPSzgG75Hq/zfZ4gA=;
        b=Pz83j5o/Rj23bPD3Mo2VxZr6BPglH8+gBOrNUFH0S0v4H/Z4SnxMRpf9aDR3cW2ivj
         YVa2lzkcQkZuh7dC/G2pOrV44T60amTulNKDH4CqUkIZJD7SqayMMs18ucuz+lazFIEd
         w6yWJVT0CnrpqzmUwFxxc8Jhqb7zdDXyKfRirKpEvUXLrsqwmFr2WwFMhASiBt+0H4F2
         ezi7XDSVxfihHeMObcml0DSUMSZS7D+GPiSD2G1xYw3hAuJzc0I4IAhIc+NJ4RBEqk5/
         teSGmEirsNACAVvtc038PReswyYfCrSOj2KwTK+R/Ry/3mixR0L2bsy/7pb4PoITe6OL
         rKfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777727989; x=1778332789;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zl++HpBCtAW5kzSiDlCg+WmmabaPSzgG75Hq/zfZ4gA=;
        b=CgZtnQydXFueV6ghkHmu7iwb3kdJ0nEAbQ/iTtXzyz7ExcR4muSdWs+LQ7XdS/yxa0
         lU8evL2E1+5uPakdpT2wfClQ2FFcmziEW9IsPjNoVPouQ3lNjC9bRrt3pWoYoMhwEuJ0
         ZY8ZlY1D968QOVsGzd//9DZQR7QJByrv1gKXRXkJKe/4vX1+OXKNWz73I/chcO06W+/A
         VJde9jMAwOfkWy8/MLyuApiAB7byxdf2d64qV1nlMfHD7+INm2AvfJ0BikU6WZoUgv5N
         3rtzb9eldMYlntUpcCV/hjAXyJlh7tnjO8dhZywB9DIzIeczvPuag0FZtHFlEE89OFzq
         ZZEg==
X-Forwarded-Encrypted: i=1; AFNElJ/fUBjVrfE5DIZAiToJhw7eqOYqpg/I7MOls+61odwqUJ6vF855jS0QBDDVv84PxeBtL3IuzUE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxISkYWQpVtLcq57BBeLyr/DiDMxI9rFe2tCQOhLSJxXyMhpVtm
	jf8SDTyDelpWu+V6jAaj9Z62hvDUyX4a+QmeqrE/6AaYuPyKt65ZNlzv
X-Gm-Gg: AeBDieuASgmj8SvhOYg1al6JLagtAVzsGEDIpsNSPvVX1mAHHipB3gUVJZBSZrqV7VN
	0oGI8cGskgqFGUY9UxtbSRwap8OfbYPNHVIybY88RDrjNHfWlgpQnPBY01M1mNm8snr5J4zTBQc
	Q4qRObhyuvbMijOq57M76cJKpuvl90k+ojxPYq5I3w5XROgXbKi5VuDTToMGG5MDtkJLVCxD2Y8
	Ssua8u33/+I4WRNkxBP4dqE59POxlRMmUWHHiWx5fFdSbDqMpcRwyGJlwN8Yxa3J+OaOa26kIhi
	QLWR3SEtopdQaeILWqY1YSZEzd+ZRacg/gIaLieURt39CXOzAScdYzbadtpC+/p6C188XJpVAy6
	sUjivJVMfOggS9tkkmualGMGaPbPnfluHM5TKSv1Xu9ukNW0++DNYsF+LHiI5jqzt4VOoxdnbos
	0yiTHoQAHUIAKaS3rdx8905mESQkmiuY48IdvVqBlL/4hQ7cHELw==
X-Received: by 2002:a05:6a00:13a0:b0:82f:4628:4186 with SMTP id d2e1a72fcca58-8352d2cf7aamr3023049b3a.42.1777727989546;
        Sat, 02 May 2026 06:19:49 -0700 (PDT)
Received: from DESKTOP-82PPU4A.localdomain ([202.8.116.84])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-83515ad0176sm5553791b3a.39.2026.05.02.06.19.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 May 2026 06:19:47 -0700 (PDT)
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
Subject: [PATCH net-next v6 4/5] ipv6: mld: encode multicast exponential fields
Date: Sat,  2 May 2026 13:19:05 +0000
Message-ID: <20260502131907.987-5-royujjal@gmail.com>
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
X-Rspamd-Queue-Id: 95C234B221B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
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
	RCPT_COUNT_TWELVE(0.00)[17];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-283414-lists,netdev=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,blackwall.org:email,nvidia.com:email]

In MLD, MRC and QQIC fields are not correctly encoded when
generating query packets. Since the receiver of the query
interprets these fields using the MLDv2 floating-point
decoding logic, any value that exceeds the linear threshold
is incorrectly parsed as an exponential value, leading to
an incorrect interval calculation.

Encode and assign the corresponding protocol fields during
query generation. Introduce the logic to dynamically
calculate the exponent and mantissa using bit-scan (fls).
This ensures MRC (16-bit) and QQIC (8-bit) fields are
properly encoded when transmitting query packets with
intervals that exceed their respective linear thresholds
(32768 for MRD; 128 for QQI).

RFC3810: If Maximum Response Code >= 32768, the Maximum
Response Code field represents a floating-point value as
follows:
     0 1 2 3 4 5 6 7 8 9 A B C D E F
    +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
    |1| exp |          mant         |
    +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+

RFC3810: If QQIC >= 128, the QQIC field represents a
floating-point value as follows:
     0 1 2 3 4 5 6 7
    +-+-+-+-+-+-+-+-+
    |1| exp | mant  |
    +-+-+-+-+-+-+-+-+

Reviewed-by: Nikolay Aleksandrov <razor@blackwall.org>
Reviewed-by: Ido Schimmel <idosch@nvidia.com>
Signed-off-by: Ujjal Roy <royujjal@gmail.com>
---
 include/net/mld.h         | 119 ++++++++++++++++++++++++++++++++++++++
 net/bridge/br_multicast.c |   4 +-
 2 files changed, 121 insertions(+), 2 deletions(-)

diff --git a/include/net/mld.h b/include/net/mld.h
index 10e402e0fe08..23255cc47ced 100644
--- a/include/net/mld.h
+++ b/include/net/mld.h
@@ -91,13 +91,132 @@ struct mld2_query {
 
 /* MLDv2 QQIC floating-point exponential field min threshold */
 #define MLD_QQIC_MIN_THRESHOLD	128
+/* MLDv2 QQIC FP max threshold (mant = 0xF, exp = 7) -> 31744 */
+#define MLD_QQIC_MAX_THRESHOLD	31744
 /* MLDv2 MRC floating-point exponential field min threshold */
 #define MLD_MRC_MIN_THRESHOLD	32768UL
+/* MLDv2 MRC FP max threshold (mant = 0xFFF, exp = 7) -> 8387584 */
+#define MLD_MRC_MAX_THRESHOLD	8387584
 #define MLDV1_MRD_MAX_COMPAT	(MLD_MRC_MIN_THRESHOLD - 1)
 
 #define MLD_MAX_QUEUE		8
 #define MLD_MAX_SKBS		32
 
+/* V2 exponential field encoding */
+
+/*
+ * Calculate Maximum Response Code from Maximum Response Delay
+ *
+ * MRC represents the 16-bit encoded form of Maximum Response Delay (MRD);
+ * once decoded, the resulting value is in milliseconds.
+ *
+ * RFC3810, 5.1.3. defines only the decoding formula:
+ *     Maximum Response Delay = (mant | 0x1000) << (exp + 3)
+ *
+ * but does NOT define the encoding procedure. To derive exponent:
+ *
+ * For the 16-bit MRC, the "hidden bit" (0x1000) is left shifted by 12 to
+ * sit above the 12-bit mantissa. The RFC then shifts this entire block
+ * left by (exp + 3) to reconstruct the value. So, 'hidden bit' is the
+ * MSB which is shifted by (12 + exp + 3).
+ *
+ * Total left shift of the hidden bit = 12 + (exp + 3) = exp + 15.
+ * This is the MSB at the 0-based bit position: (exp + 15).
+ * Since fls() is 1-based, fls(value) - 1 = exp + 15.
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
+	/* MRC < 32768 is literal */
+	if (mrd < MLD_MRC_MIN_THRESHOLD)
+		return mrd;
+
+	/* Saturate at max representable (mant = 0xFFF, exp = 7) -> 8387584 */
+	if (mrd >= MLD_MRC_MAX_THRESHOLD)
+		return 0xFFFF;
+
+	mc_exp = fls(mrd) - 16;
+	mc_man = (mrd >> (mc_exp + 3)) & 0x0FFF;
+
+	return 0x8000 | (mc_exp << 12) | mc_man;
+}
+
+/*
+ * Calculate Querier's Query Interval Code from Querier's Query Interval
+ *
+ * QQIC represents the 8-bit encoded form of Querier's Query Interval (QQI);
+ * once decoded, the resulting value is in seconds.
+ *
+ * RFC3810, 5.1.9. defines only the decoding formula:
+ *     QQI = (mant | 0x10) << (exp + 3)
+ *
+ * but does NOT define the encoding procedure. To derive exponent:
+ *
+ * For any value of mantissa and exponent, the decoding formula indicates
+ * that the "hidden bit" (0x10) is shifted 4 bits left to sit above the
+ * 4-bit mantissa. The RFC again shifts this entire block left by (exp + 3)
+ * to reconstruct the value. So, 'hidden bit' is the MSB which is shifted
+ * by (4 + exp + 3).
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
+	/* QQIC < 128 is literal */
+	if (value < MLD_QQIC_MIN_THRESHOLD)
+		return value;
+
+	/* Saturate at max representable (mant = 0xF, exp = 7) -> 31744 */
+	if (value >= MLD_QQIC_MAX_THRESHOLD)
+		return 0xFF;
+
+	mc_exp  = fls(value) - 8;
+	mc_man = (value >> (mc_exp + 3)) & 0x0F;
+
+	return 0x80 | (mc_exp << 4) | mc_man;
+}
+
 /* V2 exponential field decoding */
 
 /* Calculate Maximum Response Delay from Maximum Response Code
diff --git a/net/bridge/br_multicast.c b/net/bridge/br_multicast.c
index 27010744d7ae..49ceea3ff974 100644
--- a/net/bridge/br_multicast.c
+++ b/net/bridge/br_multicast.c
@@ -1181,7 +1181,7 @@ static struct sk_buff *br_ip6_multicast_alloc_query(struct net_bridge_mcast *brm
 		break;
 	case 2:
 		mld2q = (struct mld2_query *)icmp6_hdr(skb);
-		mld2q->mld2q_mrc = htons((u16)jiffies_to_msecs(interval));
+		mld2q->mld2q_mrc = htons(mldv2_mrc(jiffies_to_msecs(interval)));
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


