Return-Path: <netdev+bounces-275095-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qKIbEhHZz2mb1AYAu9opvQ
	(envelope-from <netdev+bounces-275095-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 03 Apr 2026 17:13:21 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 69F13395A8D
	for <lists+netdev@lfdr.de>; Fri, 03 Apr 2026 17:13:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 0F944309AB72
	for <lists+netdev@lfdr.de>; Fri,  3 Apr 2026 15:02:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84C323CCA03;
	Fri,  3 Apr 2026 15:01:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H2X1mRzf"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA6743C944C
	for <netdev@vger.kernel.org>; Fri,  3 Apr 2026 15:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775228477; cv=none; b=BbjZvpczhYRclWgG/sHsIlBr8XZRol4h5sJS+coRa0XK53m+/H6biyd9ztSlWX/9hlTiTf9Din5qjomnvaMF7xoK2etXik7coO7uIzL3uo0syAwRRbevy3Cmhu9DxLzTr9SQDJE4zDSd0/ENdyc+QKqrZ3BKTon8iAlsfreg4c0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775228477; c=relaxed/simple;
	bh=/mvWdn/wGAykwRVbilLUMYweyyaQRxjwPI/Js63ZwqU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ABeeR3KodqSFXOKDCRuBcokEBWCLaqxHkFTH5SlAujSegRZg3nYhLLsdymQmO/Bjz8xZl13yJQAe5AzZA7qrzXPNV2H88PEoNPhdEr9EOsIli0fDZr1xpsoFghSBUwSt2p9nShlF2QyyyBGKGUuhwpLhdEYh582S1cqOXVJ6gSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H2X1mRzf; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-82748257f5fso1895684b3a.1
        for <netdev@vger.kernel.org>; Fri, 03 Apr 2026 08:01:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775228474; x=1775833274; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vOZNpt/bcu1cEQwQ1aXYPtHdfiB4Rn2c0iK1yBAhiAY=;
        b=H2X1mRzf/SBHaPpVtNRcpkYoavd0fk4VUrRxmTHnR08yaiebBsIred7MzVjcJzgNBq
         qK9pSO5U31qqW5wQTcgGp80FEQXluEXx9Mxxlw+20/9JFnpTabgHM3p2jWBgke2DbcZF
         NnnPiOByYQG5BKMp8P4XcfW3qNaxVopYnXvLeEljISkEx+AEYvzNSXhbp9vZAgQCLqWE
         sxt3nN42Ew9gUQ/ih74l915Ua6kP5a9CagOJYIEaWuJzqvqgO/t+9U95k4l93gy5rUeL
         B36HNziprM4+jpoprQvGYYbKIrYHtiljIgdHBUccphgvYV43BNPpax72qvQMbLwQHRgC
         U2gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775228474; x=1775833274;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=vOZNpt/bcu1cEQwQ1aXYPtHdfiB4Rn2c0iK1yBAhiAY=;
        b=jLgZcW6CnP11YCCrJomKyLUnjHyefmxAB4ZWRJu4KfHpjw5dathnhOaw5St+iRxwD4
         ni/uUGkawuPq7jTRAkRU/p29iDUVTISJrN7mpO6vuBqYjvoCU13rbNCyWpXg7H+ze39h
         0CG8WygmKjcAj21Y6ayvAjYciYXApk37KZfk0BzUptopizuEDDdPi/KbATDWanCirNBN
         3TIgFb/ZAqnKmt5g5rjNwubEvXvOWjehPXdePx1qBO5nzDrN39pzZkeG3UwtiNm0G+am
         K7PZatEBAxfhVG82O9YVU0EPu8s9zjjKtMiA2xuAtztmQVftAEQXMAZ3KlpFhcoCa+O1
         WOUw==
X-Forwarded-Encrypted: i=1; AJvYcCWeZbedTODz6IyHtCpp2c+p7JYsmfhyfC2KKCUuuZ0+pt0Ax/oePCrR2sbLDg72QAOAYyDYuo8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzmdtfKOJcIkRPwrpI35q1CN3iYG05aZu3UjusQH0tCn+ynGunN
	QpjRoqTEWpfBgG7ObTH9segJwFFk/MLSp2sYQUY+W1MnkSpAHN42ku1S
X-Gm-Gg: ATEYQzx0gbW13vVAsH/6zSG5UN/+vJYFV8w84KZla6u2yN+MaNN5i/Cgx8UXRUedcJH
	XPXiYnHR9qR/acDgJE/RIvbiieSfdkidoASWEz0SjSLV2duQNlgUAIcWxDRJ3sAbJZrt6caIzTP
	/VIb0LDpPzsYLTr8QtglcelPvTf7vHqWU9WApMUZpEigpPnZdetLbGTTY9i6fqdZ16I6OJygPiY
	LhRSiI/b+e9a8+lqDCx0WWkEG2ZwfgE/4L9NvqlI+jgxKHSsvBmL5R5qSf10M6WD1BAMF88QkQX
	Cjin6k2knu+aKSi36pbd/WGugJURV/UfOH1x2hmP7C8/cVttza+Zaa53Hf9sRCRwDFNhKqacRjE
	jtzz72/4yWHurSz6r1e9AzwG5juYN4lPHtt9TCalv7pV1JTaNY3m4nZc/gNB1i0jOEAc8+iOD6O
	45FG7LeEhXOq/F9q67jjprn8CrExIFGh8J7gMYER1K
X-Received: by 2002:a05:6a20:7d8a:b0:39f:a42:924b with SMTP id adf61e73a8af0-39f2d8a8ea8mr3039990637.11.1775228473764;
        Fri, 03 Apr 2026 08:01:13 -0700 (PDT)
Received: from DESKTOP-82PPU4A.localdomain ([202.8.116.192])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82cf9ca79basm7789483b3a.58.2026.04.03.08.01.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Apr 2026 08:01:12 -0700 (PDT)
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
Subject: [PATCH net-next v3 2/5] ipv6: mld: rename mldv2_mrc() and add mldv2_qqi()
Date: Fri,  3 Apr 2026 15:00:47 +0000
Message-ID: <20260403150050.1235-3-royujjal@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-275095-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[royujjal@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 69F13395A8D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Rename mldv2_mrc() to mldv2_mrd() as it is used to calculate
the Maximum Response Delay from the Maximum Response Code.

Introduce a new API mldv2_qqi() to define the existing
calculation logic of QQI from QQIC. This also organizes
the existing mld_update_qi() API.

Signed-off-by: Ujjal Roy <royujjal@gmail.com>
---
 include/net/mld.h         | 70 +++++++++++++++++++++++++++++++++------
 net/bridge/br_multicast.c |  2 +-
 net/ipv6/mcast.c          | 19 ++---------
 3 files changed, 64 insertions(+), 27 deletions(-)

diff --git a/include/net/mld.h b/include/net/mld.h
index c07359808493..da3299545ebd 100644
--- a/include/net/mld.h
+++ b/include/net/mld.h
@@ -89,29 +89,79 @@ struct mld2_query {
 #define MLDV2_QQIC_EXP(value)	(((value) >> 4) & 0x07)
 #define MLDV2_QQIC_MAN(value)	((value) & 0x0f)
 
-#define MLD_EXP_MIN_LIMIT	32768UL
-#define MLDV1_MRD_MAX_COMPAT	(MLD_EXP_MIN_LIMIT - 1)
+#define MLD_QQIC_MIN_THRESHOLD	128
+#define MLD_MRC_MIN_THRESHOLD	32768UL
+#define MLDV1_MRD_MAX_COMPAT	(MLD_MRC_MIN_THRESHOLD - 1)
 
 #define MLD_MAX_QUEUE		8
 #define MLD_MAX_SKBS		32
 
-static inline unsigned long mldv2_mrc(const struct mld2_query *mlh2)
-{
-	/* RFC3810, 5.1.3. Maximum Response Code */
-	unsigned long ret, mc_mrc = ntohs(mlh2->mld2q_mrc);
+/* V2 exponential field decoding */
 
-	if (mc_mrc < MLD_EXP_MIN_LIMIT) {
-		ret = mc_mrc;
+/* Calculate Maximum Response Delay from Maximum Response Code
+ *
+ * After decode, MRC represents the Maximum Response Delay (MRD) in units
+ * of milliseconds.
+ *
+ * RFC3810, 5.1.3. defines the decoding formula:
+ *      0 1 2 3 4 5 6 7 8 9 A B C D E F
+ *     +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
+ *     |1| exp |          mant         |
+ *     +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
+ * Maximum Response Delay = (mant | 0x1000) << (exp+3)
+ */
+static inline unsigned long mldv2_mrd(const struct mld2_query *mlh2)
+{
+	/* RFC3810, relevant sections:
+	 *  - 5.1.3. Maximum Response Code
+	 *  - 9.3. Query Response Interval
+	 */
+	unsigned long mc_mrc = ntohs(mlh2->mld2q_mrc);
+
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
+ * After decode, QQIC represents the Querier's Query Interval in units
+ * of seconds.
+ *
+ * RFC3810, 5.1.9. defines the decoding formula:
+ *      0 1 2 3 4 5 6 7
+ *     +-+-+-+-+-+-+-+-+
+ *     |1| exp | mant  |
+ *     +-+-+-+-+-+-+-+-+
+ * QQI = (mant | 0x10) << (exp + 3)
+ */
+static inline unsigned long mldv2_qqi(const struct mld2_query *mlh2)
+{
+	/* RFC3810, relevant sections:
+	 *  - 5.1.9. QQIC (Querier's Query Interval Code)
+	 *  - 9.2. Query Interval
+	 *  - 9.12. Older Version Querier Present Timeout
+	 *    (the [Query Interval] in the last Query received)
+	 */
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


