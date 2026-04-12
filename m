Return-Path: <netdev+bounces-277761-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QFseIxN+22mgCgkAu9opvQ
	(envelope-from <netdev+bounces-277761-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 12 Apr 2026 13:12:19 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 08ED93E384C
	for <lists+netdev@lfdr.de>; Sun, 12 Apr 2026 13:12:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 408A93025164
	for <lists+netdev@lfdr.de>; Sun, 12 Apr 2026 11:11:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7C8C375ABD;
	Sun, 12 Apr 2026 11:11:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KD5OYzbU"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 012BD3783B1
	for <netdev@vger.kernel.org>; Sun, 12 Apr 2026 11:11:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775992290; cv=none; b=ctzLyHcvZXnGOfie6ccBzvo7ELqR7LjCZ1N5lV4I7J+mYM3c1y4AVllY+fooRPWMw2vZ4QGaHXte0mcRpPIbJpsap6CdQSXuekvN9uOlnDIWpXCe85ffVtxBLI8Y0eHXurBpv5sXQgCciH0Tp/66x8f6/d1shjg5TaLNe20L8zE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775992290; c=relaxed/simple;
	bh=7brjJEEot96W6bsrpWfLzJyx0E86TzSH+ZUnkfS6rLY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XMsqYYvM+Q8fGjZyg/OcXUyMKcN7+Es/Ruzae3GEZ7Q9iKVGdjxl0dn7u+DjOx69pDwwpH5/BV8RieAwJwowmKengvp/kn7VE4fZvJIhfYObZKkY5M0QxVhPXNg69IkX/BxhcYwVOpm9H78Z+1+/HtMJvK06xO5HEkMGD1YJZzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KD5OYzbU; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-c70ea5e9e9dso1359317a12.1
        for <netdev@vger.kernel.org>; Sun, 12 Apr 2026 04:11:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775992288; x=1776597088; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oORmgD+tSajF1jecnR/BcGHNYT1tf2GF0qIgWz3LTVE=;
        b=KD5OYzbU8DGMWj7hvLk8G2KG8jOVXj+FKpsgA5Wl9S9LXKgtKT0ybhlrufJ0ELtqpc
         OgZBr/XuXJumxW/KHtt+o5F4BD6JWT0Bl/FDAvl+enC/s0B6PlwDOXdgeWCSMXlsfEse
         PnB58joYoUGJ3ccs2yGRI/YXJdA2+Vy1bbyxkGcdqDDXPTxlNrWE/XnacOD+PhR7LhSl
         hHxaRLjcE5J8vINcye+ynE6QCeKtuIZVCoahlXuCMt2LEDwLp9F4wfxWzJvb5cKExttA
         dicNkND9entWJJj+T7AalXYWuopJSFmTBI5UVN6Y8H584pXqNZWH/OdpF3TTeDhI+U3e
         SmfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775992288; x=1776597088;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=oORmgD+tSajF1jecnR/BcGHNYT1tf2GF0qIgWz3LTVE=;
        b=DbgT9wmJVyRNnW+OKMxYxDoXNaPz2dA8fuMMcVexrVuWh3Mhk81lWZmO/GexTSJRb2
         p1dLcVpxm6Wl6h3Jc7OxjUaTroYxnd/G9gzHhzAcJK1fZhLuhy9vLTfUT/S+NBRUqILn
         sXUY+jsilw9TZ58+CJUI/7hqQt+F6IiURC0m8hK+utgxcw7EDtZ002U/T33FSN0yApWk
         Geqr71k62HLG6/TMvZkDTYLUlkEo6h/KFUxHKywUIHrpVOCyBrHeQiw/buTP4mXUxQZR
         Oa26NtXw++90n9VsxZJX4CcFeiKG2UZDoGxBu8H8yWIdHOYAT61OO/IaJvCZbCThXI3v
         zjPw==
X-Forwarded-Encrypted: i=1; AJvYcCXMQk0o6hQZLdZCagHEUfWUQC9faNSbKutus73agjujEXtnTB6zLMo9YgEFSF24yH1n7O6M+YE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzfvEsr5DgoIfMy5YlImZ3QKWRvg6Zy0j9YOPP86cpPkuPlUtH8
	qrdjkmikGZSuC8+pFsQNNlRbQ/AvD6SJ5P3b4iGYMQRNoBKoxmUMZ56p
X-Gm-Gg: AeBDieuRTD7NNvgjM34DwvZwOxrvw3PRA3imMq4yRU5Yjnz33+Fds/brP1OyRqbVjAX
	U3FYV0Scq4yNFOhplOUY3Dr0n+Up4zEpxtYyUYIoByP8wlYwLSDITmFNfxhi+SaRpkh6VaSu5Jx
	VbIdMEYiUp5qreuPacRMXaPHoEkHC8ho8J9XZHuVkgsHbmmAhVEBj1htwh7Sn+nGvxkc1yJvP+k
	gFfpU10l/jY2/NmH3N4YeV3x5mqru5k25KHCCTw1Yu4DTicYuTceTOO4HKgNp/0PpmHkAYTtlnB
	LRw6Jlts77JqVKtFT9HqfN5m5/lFQ52KhIYrAWVuhmlkBbq5DdAtTYZnWXeeTanOyQUU7qLDCNe
	eJ4SvpWpA0ScGpVeYZziGEDKelLnEu+wQp4Y5UufgF+hnigcRxmgbAyaE4gGRzLsYysVO2RdScV
	9RUojfiWRuEeeso7hWsxdLKeARGenHUr1FoCRZ417A
X-Received: by 2002:a05:6a21:7912:20b0:39f:af98:6f92 with SMTP id adf61e73a8af0-39fe3c2d7a0mr7564178637.3.1775992288324;
        Sun, 12 Apr 2026 04:11:28 -0700 (PDT)
Received: from DESKTOP-82PPU4A.localdomain ([202.8.116.169])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c7934c9ef38sm2522981a12.12.2026.04.12.04.11.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Apr 2026 04:11:27 -0700 (PDT)
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
Subject: [PATCH net-next v4 4/5] ipv6: mld: encode multicast exponential fields
Date: Sun, 12 Apr 2026 11:10:46 +0000
Message-ID: <20260412111047.1326-5-royujjal@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260412111047.1326-1-royujjal@gmail.com>
References: <20260412111047.1326-1-royujjal@gmail.com>
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
	TAGGED_FROM(0.00)[bounces-277761-lists,netdev=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email]
X-Rspamd-Queue-Id: 08ED93E384C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

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

Reviewed-by: Ido Schimmel <idosch@nvidia.com>
Signed-off-by: Ujjal Roy <royujjal@gmail.com>
---
 include/net/mld.h         | 119 ++++++++++++++++++++++++++++++++++++++
 net/bridge/br_multicast.c |   4 +-
 2 files changed, 121 insertions(+), 2 deletions(-)

diff --git a/include/net/mld.h b/include/net/mld.h
index 6ed467e23f12..5f79ea2257d5 100644
--- a/include/net/mld.h
+++ b/include/net/mld.h
@@ -90,12 +90,131 @@ struct mld2_query {
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


