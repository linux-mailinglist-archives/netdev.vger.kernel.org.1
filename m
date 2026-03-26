Return-Path: <netdev+bounces-272107-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8HHhNM5NxWkU8wQAu9opvQ
	(envelope-from <netdev+bounces-272107-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 16:16:30 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FBB233762F
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 16:16:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A144A30D7614
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 15:08:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9633402422;
	Thu, 26 Mar 2026 15:08:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OzvD6wdL"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63383401A0D
	for <netdev@vger.kernel.org>; Thu, 26 Mar 2026 15:08:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774537681; cv=none; b=sjGh30Og8g+xX0iumOftrJenoUk46la3HXppjmpqdwvfnRnLRNwbIHNDSKOAz4oftukqG9/4vHMml8GBIP7FDnfU+fX2d7lkxlt43R6FLuUqAkwgzD2RNR6P3f9Nm5s10HLlZdr5xKtzKOXtzXp9rb12sEWZAJkA1efFoOJZyJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774537681; c=relaxed/simple;
	bh=Plea5iBFdrt1H6d4ZGv0XEzQG+OQNdXeC+Jz94Z9T/M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=O9yMWYM8Q9zhMOLNwx4a8Y34y2Rc9ag9EI8FlGwJ4DoTpDeWPNK4aUuP3KzTsZExt15+Sv8NmHsTfRJ1CcR28wY3E3JP4YbpxEadt4iL/NfPgYKQ94SAhmJomRSeJSb99ojDXLxjZ+OAqX1HYFKOzAJGJszJrxOo94Mgm+DDDmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OzvD6wdL; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-35a02f3b8feso562590a91.3
        for <netdev@vger.kernel.org>; Thu, 26 Mar 2026 08:08:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774537680; x=1775142480; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8Vd4SXqk71/8Mc4Vs55kpxlo3429C4j+4N2/E0Qv8FI=;
        b=OzvD6wdL0+Eh+i6LA9p9e/Fc4WUjS5WpLs1ZVDe3hBiGF7y2Ock3Rj1L/BPylPHIez
         rzxW3l2ecWAQ4EHXlh1jZSEHsTXa1wTwC0nlUY9pMqfELV2if07bTviIeP+1n1Dk5q72
         iWLQyrPnMwRgveResDYyyh/LueCf4Qb+uoLdXWLmFNpfJVVDvMGzMMbYO+Q1JH2NDlnk
         awbLydHzl9vHKApPTLjBbgP5HDvsklYX3vVJE90A/pEu1LCaF1NZVAv5396iug6vDu2i
         nrYsoAsL+AliCghu/ZfuhFe6dhShE0S3Rxr/CPmzV4Apamt0V14fnUeGbt2f+R2GaEoV
         rXOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774537680; x=1775142480;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8Vd4SXqk71/8Mc4Vs55kpxlo3429C4j+4N2/E0Qv8FI=;
        b=me0GTcQl6euW+Ln1C1fy13wtd0y3DIdbSB2kTxrTNuyztGTaerxqIzg9ywkUmYAaqx
         f+aDNvlwlaS3Gai1HaPhFIpS1JRiT32ehQIzTOcFl7NH1057u67seMGYYEiAodYHXqcx
         5Fq8bG8W6JFeux5QUePXRwmUcsAwrO3JieMIN9oZFn2zWqWmM73QwAl+TlVpmpBwaIiR
         lWnHNfcUgAYM1iBsDNAMs+tTwS4mXs8GqcPLdG3grjhswGq3GasT9PdtF4N/HTo4Hx/F
         QWXo7vWromLkyFzXq3sNpPTRVgpe6wMqlEkOJSyMzgRFVnn0qbs4kxU/U8pbbQCcaaDM
         zLLg==
X-Forwarded-Encrypted: i=1; AJvYcCXTivoiA0adX8ciTQFnc5+ZGKb58+HM0oCjXI367bu9GW3YJRR2akvt4rOic1e0Nt0TC+Vc2S8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/x8cEhX8lz/l6sqox5/UYC6mIFJscDxTgXkBYDm6ROFKuIxGU
	cYCupQ6/KQF4M9+uo5rWyKUpjsiPOF2Y7dU4qkaYow06YiERW4cYHBCK
X-Gm-Gg: ATEYQzz12GodfFFWFxvDXy4ipfZNEA/5niqw/e2zzZJr67BI1voOsnsy1ChwjdoFwDX
	9TmQQZ0ZzJkG+XSUg3YoHQTdUm6YkkiVEkk7yH6XTpR5vbhMZk9mfPtDkk9z0qDCKKmWCGOueJH
	oytxM/oPeusa7Ds0YOUh52SJzAS5bQBBK+L4zxGLlWvoDvFig0WyRAqJMfdhEkobbSb4UQrQ7sf
	NftOwqnDjSKVb0hYupjEj003vDk2xnvt2fSPzGIdS7Ar7vZHleVgTvik1/+fAWb6fp13mDS3J0B
	oOJBp5l7qbLC8EujYKfPqM0RffpEVhnjTo9pLXa9c3di+Jhzelo+IBUf9UXcixeHJmIR2GSW7lV
	xvMcC7JM6JjFUu7cCWVEGoHCj48uMRrmnRT1XlAe3X8MEoIxLr9ZBtBDnWCmNMsK4DBVh61CI3V
	QepKQjkzMh8XwtKMPOoqWEW05ELd+Zq6Z76djqe2N22upiyGf/glE=
X-Received: by 2002:a17:903:2c04:b0:2ae:aa16:acf7 with SMTP id d9443c01a7336-2b0b0ad656fmr89027405ad.40.1774537679761;
        Thu, 26 Mar 2026 08:07:59 -0700 (PDT)
Received: from DESKTOP-82PPU4A.localdomain ([202.8.116.170])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b0bc8bb5fasm33146375ad.59.2026.03.26.08.07.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Mar 2026 08:07:59 -0700 (PDT)
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
Subject: [PATCH 2/4] ipv6: mld: rename mldv2_mrc() and add mldv2_qqi()
Date: Thu, 26 Mar 2026 15:07:40 +0000
Message-ID: <20260326150742.50289-3-royujjal@gmail.com>
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
	TAGGED_FROM(0.00)[bounces-272107-lists,netdev=lfdr.de];
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
X-Rspamd-Queue-Id: 6FBB233762F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Rename mldv2_mrc() to mldv2_mrd() as it used to calculate
the Maximum Response Delay from the Maximum Response Code.

Introduce a new API mldv2_qqi() to define the existing
calculation logic of QQI from QQIC. This also organizes
the existing mld_update_qi() API.

Added by e3f5b1704 ("net: ipv6: mld: get rid of MLDV2_MRC and simplify calculation").

Signed-off-by: Ujjal Roy <royujjal@gmail.com>
---
 include/net/mld.h         | 64 +++++++++++++++++++++++++++++++++------
 net/bridge/br_multicast.c |  2 +-
 net/ipv6/mcast.c          | 19 ++----------
 3 files changed, 58 insertions(+), 27 deletions(-)

diff --git a/include/net/mld.h b/include/net/mld.h
index c07359808493..6373eb76efe5 100644
--- a/include/net/mld.h
+++ b/include/net/mld.h
@@ -89,29 +89,73 @@ struct mld2_query {
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
+		return ((mc_man | 0x1000) << (mc_exp + 3));
 	}
+}
 
-	return ret;
+/* Calculate Querier's Query Interval from Querier's Query Interval Code
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
+	unsigned long qqic = ntohs(mlh2->mld2q_qqic);
+
+	if (qqic < MLD_QQIC_MIN_THRESHOLD) {
+		return qqic;
+	} else {
+		unsigned long mc_man, mc_exp;
+
+		mc_exp = MLDV2_QQIC_EXP(qqic);
+		mc_man = MLDV2_QQIC_MAN(qqic);
+
+		return ((mc_man | 0x10) << (mc_exp + 3));
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


