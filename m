Return-Path: <netdev+bounces-283412-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4LXkNAv69WkHRAIAu9opvQ
	(envelope-from <netdev+bounces-283412-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 02 May 2026 15:20:11 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 975564B21E5
	for <lists+netdev@lfdr.de>; Sat, 02 May 2026 15:20:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 11CAA300D712
	for <lists+netdev@lfdr.de>; Sat,  2 May 2026 13:19:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42110247DE1;
	Sat,  2 May 2026 13:19:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O0gs6ZE6"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB66422126D
	for <netdev@vger.kernel.org>; Sat,  2 May 2026 13:19:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777727975; cv=none; b=TyKF2a3FB9R7PqyzSSEZ6GKKkuG/x0kMYAkCjUB5bNGOSo9Jy3GbBZpL8eYgr0IKLm6FG8tZAPvytvl4SAxowExiAsCUL/T6aLs3XXCEjaQbBBli8k/3iIQHDMAlX+aj9VFQnCh4IBwTxb8QMZ1PaH6Xyo0xFiyvTxpqpMqvRhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777727975; c=relaxed/simple;
	bh=UCaDphay8R5jghlpOgQZQGSq8SNelf7mPTIxi7JVkS8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Hon6nA5IKq2Ngq4VpWup/whrVnuspQ4mTehOVudvZRzTZJQXAkA5cpctdU5uCFQQoCRrL1HH3rdLzo8xeyxC+Ws4ZHxk+NwljqdsFwWFTz1/B35kHPspfc63/YjqXF+R6cC6IXg58jvgbYXiu9fxxnFP0JIcc4XST/qMKP/BPyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O0gs6ZE6; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-82fbdd60b64so1977093b3a.3
        for <netdev@vger.kernel.org>; Sat, 02 May 2026 06:19:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777727973; x=1778332773; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CfXFwhGtvtECoZmhLyPyGGfKAV5tvDJY8uqDk21sk4s=;
        b=O0gs6ZE6ojtpRGIyfbEb8+3OXu2PzdgP4+HyoONlj6BWcE/JBfAkZ/uxwPP5cJR1s6
         21pEGfy6J/uXHcJDfnfIDESC+/cE71r416/a4PMhxFo9n9JwBcbhPzk2+T1qsHdbJVtW
         D3iw9QCKg++NwMwzdx1GoJqky4vKeLGXkjttKnQBNp8Ab4W5ZsNo48G1o7R8nZLdYSoW
         ffvX3hI7Zw7S2v4QsTzc+bDKZfa3EoG647Dm96Tr0c/vepzsDzWMNFdRE0f0vBibNi5d
         B3NLF2t0PAka0LTczGNX7lxiiA4GSOLnQEOq/IU16Ok/5j39ubtrWYag+kj3QCt28ULs
         5Nnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777727973; x=1778332773;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=CfXFwhGtvtECoZmhLyPyGGfKAV5tvDJY8uqDk21sk4s=;
        b=OQGvlfLm85eOPzr2UUxPsJjlFRsvMargBKBD/PBdd6Lp50A6dwHLlZGM3iiW0PRP0P
         0KC8hfGLJwrRHjX4Ef/9SiTENQoQD2tHVwf8wpM7lzvM++ZjdH3GrfiRnu5dfd1aOHvT
         kowL4M8sc/UQJmIJnFeWYz+OHM2enV+ZM9s5YH2MT07JrVA6V9ofSmLDwHJA6UACK6nz
         HE5m1W2r6Ki+/RK32ZV7hOiFUkJO3nrAR9lK3BFVaBmi9WOPzRpZRn+H90ubNkuEWyYq
         sCsOJN/LvEVQ4TtDMHkQC/eo7w1nL+beo3cMseH7w911jaQX980nRFNUsVBbhaF1IbLw
         t0Ow==
X-Forwarded-Encrypted: i=1; AFNElJ8ZILxMecvaiypWwgwgxe0/7pxvS/grRqlyLC7g2T/+s/QYJGJS3RuN0aMSGn2VGWs1Cd6sK4I=@vger.kernel.org
X-Gm-Message-State: AOJu0YzIBNQOKfXvsw8Y/SLGzgrxygY0rN+C4Wl8qYxkSObdg+A39s6r
	eiaZvdp14TxFzYLBTHvbE8jwHxsMV5g0Ivk+hhm0gguOfBKjqdlj4Aeb
X-Gm-Gg: AeBDievyplXJBHQmXid5z9IJY0hyweVriTJ2/wJr1+eWsZ2okCba5O2xd/kVodjF48z
	nVGMbhuIfyKVeicmjKi0HZ9YPMaz8xZb92wcZRCwJp24bWWcpNDebb9ptMjw+ZZ5ik2Q77QVE9C
	oKg2CRwtfLOnvOVqKEzxi05iY+flkjbMil1T2HJ2vl5noLk30W7tvnuaI6N+wsb1Dm98Pk3c04U
	XeCrwgU2h2Ro2NQRVObOnchLgSrkiEGCTfANrr2xjDotPQSzhq3OZ53lTjuwdqXoPVHmYQx+DHA
	ZnotSCW4yx6HGDRbAVKUDzTQ3x798XJrDfZY3bS+lkTkagLHuhNAeLhAD2+SlmryUToUQqir779
	W1fVrStvxEWw3x5qKaHbaFwyjq7CWDS2bz7L7xuk6m+Yxwe4ssbWc3gbjWCNc8YSdui41Ws0TeT
	Ku1KHiwTg4XIYxjUAbaThal+S//ZAaP/5FvgTbHI+Hmp6rXaSX5g==
X-Received: by 2002:a05:6a00:369b:b0:834:df57:9d6b with SMTP id d2e1a72fcca58-8352d28bc1fmr3081700b3a.24.1777727972918;
        Sat, 02 May 2026 06:19:32 -0700 (PDT)
Received: from DESKTOP-82PPU4A.localdomain ([202.8.116.84])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-83515ad0176sm5553791b3a.39.2026.05.02.06.19.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 May 2026 06:19:32 -0700 (PDT)
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
Subject: [PATCH net-next v6 2/5] ipv6: mld: rename mldv2_mrc() and add mldv2_qqi()
Date: Sat,  2 May 2026 13:19:03 +0000
Message-ID: <20260502131907.987-3-royujjal@gmail.com>
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
X-Rspamd-Queue-Id: 975564B21E5
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
	TAGGED_FROM(0.00)[bounces-283412-lists,netdev=lfdr.de];
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

Rename mldv2_mrc() to mldv2_mrd() as it is used to calculate
the Maximum Response Delay from the Maximum Response Code.

Introduce a new API mldv2_qqi() to define the existing
calculation logic of QQI from QQIC. This also organizes
the existing mld_update_qi() API.

Reviewed-by: Nikolay Aleksandrov <razor@blackwall.org>
Reviewed-by: Ido Schimmel <idosch@nvidia.com>
Signed-off-by: Ujjal Roy <royujjal@gmail.com>
---
 include/net/mld.h         | 66 +++++++++++++++++++++++++++++++++------
 net/bridge/br_multicast.c |  2 +-
 net/ipv6/mcast.c          | 19 ++---------
 3 files changed, 61 insertions(+), 26 deletions(-)

diff --git a/include/net/mld.h b/include/net/mld.h
index c07359808493..10e402e0fe08 100644
--- a/include/net/mld.h
+++ b/include/net/mld.h
@@ -89,29 +89,77 @@ struct mld2_query {
 #define MLDV2_QQIC_EXP(value)	(((value) >> 4) & 0x07)
 #define MLDV2_QQIC_MAN(value)	((value) & 0x0f)
 
-#define MLD_EXP_MIN_LIMIT	32768UL
-#define MLDV1_MRD_MAX_COMPAT	(MLD_EXP_MIN_LIMIT - 1)
+/* MLDv2 QQIC floating-point exponential field min threshold */
+#define MLD_QQIC_MIN_THRESHOLD	128
+/* MLDv2 MRC floating-point exponential field min threshold */
+#define MLD_MRC_MIN_THRESHOLD	32768UL
+#define MLDV1_MRD_MAX_COMPAT	(MLD_MRC_MIN_THRESHOLD - 1)
 
 #define MLD_MAX_QUEUE		8
 #define MLD_MAX_SKBS		32
 
-static inline unsigned long mldv2_mrc(const struct mld2_query *mlh2)
+/* V2 exponential field decoding */
+
+/* Calculate Maximum Response Delay from Maximum Response Code
+ *
+ * RFC3810, relevant sections:
+ *  - 5.1.3. Maximum Response Code defines the decoding formula:
+ *      0 1 2 3 4 5 6 7 8 9 A B C D E F
+ *     +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
+ *     |1| exp |          mant         |
+ *     +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
+ *    Maximum Response Delay = (mant | 0x1000) << (exp+3)
+ *  - 9.3. Query Response Interval
+ *
+ * After decode, MRC represents the Maximum Response Delay (MRD) in
+ * units of milliseconds.
+ */
+static inline unsigned long mldv2_mrd(const struct mld2_query *mlh2)
 {
-	/* RFC3810, 5.1.3. Maximum Response Code */
-	unsigned long ret, mc_mrc = ntohs(mlh2->mld2q_mrc);
+	unsigned long mc_mrc = ntohs(mlh2->mld2q_mrc);
 
-	if (mc_mrc < MLD_EXP_MIN_LIMIT) {
-		ret = mc_mrc;
+	if (mc_mrc < MLD_MRC_MIN_THRESHOLD) {
+		return mc_mrc;
 	} else {
 		unsigned long mc_man, mc_exp;
 
 		mc_exp = MLDV2_MRC_EXP(mc_mrc);
 		mc_man = MLDV2_MRC_MAN(mc_mrc);
 
-		ret = (mc_man | 0x1000) << (mc_exp + 3);
+		return (mc_man | 0x1000) << (mc_exp + 3);
 	}
+}
 
-	return ret;
+/* Calculate Querier's Query Interval from Querier's Query Interval Code
+ *
+ * RFC3810, relevant sections:
+ *  - 5.1.9. QQIC (Querier's Query Interval Code) defines the decoding formula:
+ *      0 1 2 3 4 5 6 7
+ *     +-+-+-+-+-+-+-+-+
+ *     |1| exp | mant  |
+ *     +-+-+-+-+-+-+-+-+
+ *    QQI = (mant | 0x10) << (exp + 3)
+ *  - 9.2. Query Interval
+ *  - 9.12. Older Version Querier Present Timeout
+ *    (the [Query Interval] in the last Query received)
+ *
+ * After decode, QQIC represents the Querier's Query Interval in units
+ * of seconds.
+ */
+static inline unsigned long mldv2_qqi(const struct mld2_query *mlh2)
+{
+	unsigned long qqic = mlh2->mld2q_qqic;
+
+	if (qqic < MLD_QQIC_MIN_THRESHOLD) {
+		return qqic;
+	} else {
+		unsigned long mc_man, mc_exp;
+
+		mc_exp = MLDV2_QQIC_EXP(qqic);
+		mc_man = MLDV2_QQIC_MAN(qqic);
+
+		return (mc_man | 0x10) << (mc_exp + 3);
+	}
 }
 
 #endif
diff --git a/net/bridge/br_multicast.c b/net/bridge/br_multicast.c
index 9fec76e887bc..1438c023db62 100644
--- a/net/bridge/br_multicast.c
+++ b/net/bridge/br_multicast.c
@@ -3606,7 +3606,7 @@ static int br_ip6_multicast_query(struct net_bridge_mcast *brmctx,
 		    mld2q->mld2q_suppress)
 			goto out;
 
-		max_delay = max(msecs_to_jiffies(mldv2_mrc(mld2q)), 1UL);
+		max_delay = max(msecs_to_jiffies(mldv2_mrd(mld2q)), 1UL);
 	}
 
 	is_general_query = group && ipv6_addr_any(group);
diff --git a/net/ipv6/mcast.c b/net/ipv6/mcast.c
index 3330adcf26db..6ddc18ac59b9 100644
--- a/net/ipv6/mcast.c
+++ b/net/ipv6/mcast.c
@@ -1315,20 +1315,7 @@ static void mld_update_qi(struct inet6_dev *idev,
 	 *  - 9.12. Older Version Querier Present Timeout
 	 *    (the [Query Interval] in the last Query received)
 	 */
-	unsigned long mc_qqi;
-
-	if (mlh2->mld2q_qqic < 128) {
-		mc_qqi = mlh2->mld2q_qqic;
-	} else {
-		unsigned long mc_man, mc_exp;
-
-		mc_exp = MLDV2_QQIC_EXP(mlh2->mld2q_qqic);
-		mc_man = MLDV2_QQIC_MAN(mlh2->mld2q_qqic);
-
-		mc_qqi = (mc_man | 0x10) << (mc_exp + 3);
-	}
-
-	idev->mc_qi = mc_qqi * HZ;
+	idev->mc_qi = mldv2_qqi(mlh2) * HZ;
 }
 
 static void mld_update_qri(struct inet6_dev *idev,
@@ -1338,7 +1325,7 @@ static void mld_update_qri(struct inet6_dev *idev,
 	 *  - 5.1.3. Maximum Response Code
 	 *  - 9.3. Query Response Interval
 	 */
-	idev->mc_qri = msecs_to_jiffies(mldv2_mrc(mlh2));
+	idev->mc_qri = msecs_to_jiffies(mldv2_mrd(mlh2));
 }
 
 static int mld_process_v1(struct inet6_dev *idev, struct mld_msg *mld,
@@ -1390,7 +1377,7 @@ static int mld_process_v1(struct inet6_dev *idev, struct mld_msg *mld,
 static void mld_process_v2(struct inet6_dev *idev, struct mld2_query *mld,
 			   unsigned long *max_delay)
 {
-	*max_delay = max(msecs_to_jiffies(mldv2_mrc(mld)), 1UL);
+	*max_delay = max(msecs_to_jiffies(mldv2_mrd(mld)), 1UL);
 
 	mld_update_qrv(idev, mld);
 	mld_update_qi(idev, mld);
-- 
2.43.0


