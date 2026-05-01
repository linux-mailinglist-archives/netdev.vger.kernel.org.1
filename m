Return-Path: <netdev+bounces-283250-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GL7ZDrHk9Gl1FgIAu9opvQ
	(envelope-from <netdev+bounces-283250-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 01 May 2026 19:36:49 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E7EC4AE931
	for <lists+netdev@lfdr.de>; Fri, 01 May 2026 19:36:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9103330684FD
	for <lists+netdev@lfdr.de>; Fri,  1 May 2026 17:31:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE6CF311969;
	Fri,  1 May 2026 17:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lSs2Ssgi"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 913DA3033F8
	for <netdev@vger.kernel.org>; Fri,  1 May 2026 17:31:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777656718; cv=none; b=T5xdyVH+4lNKjK9J6hQZ0G/cX4CR1dFmi2bfkXZxkQeu1w+FNKtFdD+eEbqsYMm60RA8uyXF3gfX1+Z03IxX1SDMX2Fnrqs9PSnwvU74x5GWi5kdAzxGcQhFXRReadCvecGqaoBf5e+E/PN91CxyYoZhpV/EM8kWAPQfwnNPiT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777656718; c=relaxed/simple;
	bh=PDn8j0lrnxkTWFi/Ss5XFw7DFZtI8b/CvWn3vrzRAiw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eWaw3dGLD3ghC3DLzztlXl/jO1/t/U4DVoQswBd4YNXpaBgtzt7uzNiQdWx4SyEaI6CptfwJ05hF3cHC8N6iUKxW8Iun/3kkbZ0PGlIkYe+EmL3BqJmT980CiOifIZSok6pERDFVciKv7hqJlseYxFCIXbIoB2mUSzMVUWrsPek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lSs2Ssgi; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-35da2d35eccso1576237a91.0
        for <netdev@vger.kernel.org>; Fri, 01 May 2026 10:31:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777656717; x=1778261517; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LslMTLSTH+cOBfpp7e2vjMYbfCy9riwOyI9tt0Uj2os=;
        b=lSs2SsgiY6CRUk4lGbfl4fvv4ydmkW8XFXq+pkbh0NZVYuU6TblA4n1gZbtZmSdXHt
         TnPJbiLm9vn3TugoMk60MXccE9GbYX3exAxfIQBVnaMazWUSkxkj6GETfjHM95n6PhWA
         9sroLoqcvBeFkutTCbE4QfCpKCUCOg/2Y1565NcKnL1Ev05PiOb3MPCK6w+t73QJrsvc
         uhJw9Akxgsw9etCXCBG5tdSNLKITnHG/asNQudqCNCnri1CMgkAiza7nIyZo7E2Nw0T/
         UaJNuSADswhxeZq7fw0UGXxtqmLOTxjILoupzGLVvSZkr2hO0VpX26YPrmbAmWfd2cUX
         +zZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777656717; x=1778261517;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=LslMTLSTH+cOBfpp7e2vjMYbfCy9riwOyI9tt0Uj2os=;
        b=eGsVihL8AxOOKD8hWoxDItV/gDBdBtYSu6Fa97pNB4UrE8HqkFf++W5QX+WUFC+Qrf
         tzqfPzjvb7vuTN7z77hJIG+dtRuV9DoB6OqEKJTAooEJio9ZhB9f9JMgNrH8G3fWG48H
         tbqWps4eHVTYMem9Mq/yLDWePqadcqFcogWTM+/yDlh17w0BIOX9uv2Y9o9lHNBoHHeA
         3YyjwzuQT2xVXErFJ+W5Le7gpHlD+gvg0kl5rbCIiUENUCkRDE9L3/5yOu1GS61ZvV23
         q47YTJWalG0eAX7Zh2CGvJ5qwZx+n3GGzOn5YQrQJ3GfnZYFzIi7FM6gec6tRTOWyVEq
         0DbQ==
X-Forwarded-Encrypted: i=1; AFNElJ9Of/nVEYUg66uoor55m/XSYHr06yVxUTxW4BCdeFmRzzCQn9/Vdpehc1dUkoL4ezaKFdSoK/U=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8Pg3vU7CYvcgAR33ZIT3QnvgkTfB+cFaPUoxNWrW6y7U58d/P
	QCAuu2BLVWCfxulUIu8z30iHREmzJV2ayr15wFatTvgMnGVuSp5RH0O7
X-Gm-Gg: AeBDietX3BkQzF0XsRzGL+F6otx7ouuEnacmXQP0uLC1FOUtZwz+8Ov92jz5tizLNCk
	yTzrXaRidZmtAEI1tGImQj2urscr5r6xlKkEMqarU9sinqkmOA68n+21EL4OET+fKPjhAgfgEBj
	KA2ApOhYVoTT4eXwsZX2LorwMvmzzo5rNLXZrSVGvUY3vqIiLXOF5SuRd/9NPPfzSFNeVte7dat
	StPgrZELWemGI52qqw7EqRbSqcASJ1eFQeqskZtZP5uqU+epN5WZTWkSjRv2renNqEsCapDnkWJ
	NTPm8GnNlWFlvd8rK5sK36Ued1riW+XY1hLXYQB1ukO9UEKJ669RGvOlIrXbWcOPBInuy1eo4wX
	T8rk0RTw9pBfQmgpL2VzY6NSx0dim1KBpPo9GMYj6p8lyemgNGjW7mtEvmUrTw6FYhqCuHcKbFK
	D5AuyEnvc1mnoB9mcxPzTlofXWBptvfChXAXe8qZ5sw7ItphS8oQ==
X-Received: by 2002:a17:90b:5707:b0:364:a173:2d61 with SMTP id 98e67ed59e1d1-3650cd70c41mr143017a91.11.1777656716795;
        Fri, 01 May 2026 10:31:56 -0700 (PDT)
Received: from DESKTOP-82PPU4A.localdomain ([202.8.116.84])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-364ebec73aasm2908906a91.2.2026.05.01.10.31.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 May 2026 10:31:56 -0700 (PDT)
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
Subject: [PATCH net-next v5 2/5] ipv6: mld: rename mldv2_mrc() and add mldv2_qqi()
Date: Fri,  1 May 2026 17:31:26 +0000
Message-ID: <20260501173130.3486-3-royujjal@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260501173130.3486-1-royujjal@gmail.com>
References: <20260501173130.3486-1-royujjal@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 9E7EC4AE931
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-283250-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[royujjal@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nvidia.com:email]

Rename mldv2_mrc() to mldv2_mrd() as it is used to calculate
the Maximum Response Delay from the Maximum Response Code.

Introduce a new API mldv2_qqi() to define the existing
calculation logic of QQI from QQIC. This also organizes
the existing mld_update_qi() API.

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


