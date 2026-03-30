Return-Path: <netdev+bounces-273305-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AMXDHFbMyml3AAYAu9opvQ
	(envelope-from <netdev+bounces-273305-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 30 Mar 2026 21:17:42 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D40353603E3
	for <lists+netdev@lfdr.de>; Mon, 30 Mar 2026 21:17:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 79F4B301C5B6
	for <lists+netdev@lfdr.de>; Mon, 30 Mar 2026 19:16:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97E3739526F;
	Mon, 30 Mar 2026 19:16:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j5FsFZrY"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D9DB1465B4
	for <netdev@vger.kernel.org>; Mon, 30 Mar 2026 19:16:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774898196; cv=none; b=McrigtxLyhrCw+h2ioJppABh2oz5zF/K4d7NPIPBDuHJBjD4BimGZ2f5xWFaKjxKNxodsSG3Zg325idmmlg4wx7IUzoUA1efYs1W/lHXgqqEtCzVZ3ZKdle7ndl5/3P9vSpbzsmavKmXzg2JfFl5RpUYtKC28GjO6ojFpHL1mB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774898196; c=relaxed/simple;
	bh=WW0vISqU8GwrmrIC4NHoR+TFPQ7BlX0/FvDVbKYURp4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KpDURiZl9fj22ikTyh3ECsHKqHmlsUI18aBrBBPkkc8Jtt1J8rjK1OXdOF1vDMdP0P6TPbtStYEgqaxdrLW2g9aaHjDTvwJUTyEmhmqNL+tVFDKGqmQuToe8ubu0lINS9IBrBbmc6ITCIGhNu8u8INs4rAjJhrG44j0ljrgw3do=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j5FsFZrY; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-35d971fb6f1so1854869a91.0
        for <netdev@vger.kernel.org>; Mon, 30 Mar 2026 12:16:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774898195; x=1775502995; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O2s2FZ+Hg0ngcpnnbi9FLabs6QrxAbJsZ+G4M5k6jv8=;
        b=j5FsFZrYBxRHFaLt0P/E8YV8ZMrWOhkJEI0Q90IrBhcd/x5gm8jCQZCHsIsYSko6f7
         mCD01Wh0oEQdAKBsxwT4BhmNorRCIXw5fZmwrd6HvKIK+hvcFw50eivOqHjWPdXgnZ9v
         eKtdiEx70xferoH3H/+lGHswG6NZjRR07ZN+iyvO7XnYidwJBgaqB1hZ1xxmJLrFGPa4
         vJNs2A/Kteg38JjuRsskjET5uokcYtmM9/BB5E9yPz5NIQxr8b45MbigEI8/nFZS6T08
         OBQEAIDUJ+JZlspmU1D8jcEJUP3tpUYwLkBEL7PoA9TnBvrHCk7sv71t1SjO8WSUfBgy
         V6Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774898195; x=1775502995;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=O2s2FZ+Hg0ngcpnnbi9FLabs6QrxAbJsZ+G4M5k6jv8=;
        b=HWoXUdLw2D/I8/qYAyAQpT80HH307fAeoxFPaUbtFsBUysX9rlYSGsfdgbghLOPCJZ
         a4CBsZ4nfiY/DGQpEtC9/ww2ByXnBGjMBLs41+HBv+ZPbStjDg1/vwZndC+9bF89ptY6
         eNHjK+BmYiNHkTB1UFi8WCCGg5nZ09wGcjXsveoBhuQdVO57DcCuQRFhLVTZ3sT+6VT2
         zCpZ1P1rdUoE4GaZi3UxWUm3lbt/Nm/cO4EooC4IVyJyu6kmLDoJkzduvhLKdh//GE3p
         LO3JgoXXaHNUrDinqS5NWTLS81LD33qLF7ZhBR0BSo90e6/o32xLck7NopaTlJfbUvET
         wHcA==
X-Forwarded-Encrypted: i=1; AJvYcCUUznV+v6B4Y152RlJHp08s8NxFiWt78SN0GURJDQuNSGpDTUgtQkpJEr5kUYYvZ65vr1WCUsk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/xcVm4T3bJ4sMrKlnC174OoWEmVgvTPE8bgOqELRM9g2MfWCO
	8FCuchcFngETIYYmYBKTK6siA2CYgZBH8P5Sb/768D8Lem3tqYSru6nR
X-Gm-Gg: ATEYQzxJiU6EnB5+F0HX3/P3xK+99tk9K90HQROFgv1zBPW1PkWpYeG2hRkqoGoDoFx
	q8MmALhsq1Ii0u6xlQfEIAGhRdiZ+viNghYYAzpgminOEZNK2eqwo15berhBojqhrgOCm9sPfvv
	Ceul7FuQgzM2Uc7iFI8FqbMyYNrUXY/QLaxW0MUK7N9209wqSS0mJR2/3s2TgsHJYfKdiSy1aNb
	wxeySh7w4XNZUA76lJuxPZMNZvpKRvrO2pDWD7iajpZujWp91WKppQVyPaXNh+hXP2N9ZZ6UyMz
	gZxvzoQe08zq9CLqwa+jkM+FwhIafj3/AT+sOqcyB7Y14QR2kRtVeG1RoJs+7pBG9icTkumKj8/
	XPEYnKIIqXr7Z1/U9Rjb+VTaIwwfZqzq07lOmAuaiPAxizrj2PVmeSd+zuDcloyKIObLd2OxYDm
	2BdSVQ6LBo2Mt1x/jSuEjyrusS+GXuCzwL6N/JGzR6
X-Received: by 2002:a17:90b:3c8b:b0:35b:a1b6:5bf5 with SMTP id 98e67ed59e1d1-35c30146fe2mr12855192a91.31.1774898194656;
        Mon, 30 Mar 2026 12:16:34 -0700 (PDT)
Received: from DESKTOP-82PPU4A.localdomain ([202.8.116.192])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35d950d9b12sm9627178a91.17.2026.03.30.12.16.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2026 12:16:34 -0700 (PDT)
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
Subject: [PATCH net-next v2 1/5] ipv4: igmp: get rid of IGMPV3_{QQIC,MRC} and simplify calculation
Date: Mon, 30 Mar 2026 19:16:07 +0000
Message-ID: <20260330191611.16929-2-royujjal@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260330191611.16929-1-royujjal@gmail.com>
References: <f23ed1b3-6321-4e6d-9cda-ec5d34304f3b@blackwall.org>
 <20260330191611.16929-1-royujjal@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-273305-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[17];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[royujjal@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: D40353603E3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Get rid of the IGMPV3_MRC macro and use the igmpv3_mrt() API to
calculate the Max Resp Time from the Maximum Response Code.

Similarly, for IGMPV3_QQIC, use the igmpv3_qqi() API to calculate
the Querier's Query Interval from the QQIC field.

Signed-off-by: Ujjal Roy <royujjal@gmail.com>
---
 include/linux/igmp.h      | 78 +++++++++++++++++++++++++++++++++++----
 net/bridge/br_multicast.c |  2 +-
 net/ipv4/igmp.c           |  6 +--
 3 files changed, 74 insertions(+), 12 deletions(-)

diff --git a/include/linux/igmp.h b/include/linux/igmp.h
index 073b30a9b850..3c12c0a63492 100644
--- a/include/linux/igmp.h
+++ b/include/linux/igmp.h
@@ -92,15 +92,77 @@ struct ip_mc_list {
 	struct rcu_head		rcu;
 };
 
+/* RFC3376, relevant sections:
+ *  - 4.1.1. Maximum Response Code
+ *  - 4.1.7. QQIC (Querier's Query Interval Code)
+ *
+ * If Max Resp Code >= 128, Max Resp Code represents a floating-point
+ * value as follows:
+ * If QQIC >= 128, QQIC represents a floating-point value as follows:
+ *
+ *  0 1 2 3 4 5 6 7
+ * +-+-+-+-+-+-+-+-+
+ * |1| exp | mant  |
+ * +-+-+-+-+-+-+-+-+
+ */
+#define IGMPV3_FP_EXP(value)		(((value) >> 4) & 0x07)
+#define IGMPV3_FP_MAN(value)		((value) & 0x0f)
+
+/* IGMPV3 floating-point exponential field threshold */
+#define IGMPV3_EXP_MIN_THRESHOLD	128
+
 /* V3 exponential field decoding */
-#define IGMPV3_MASK(value, nb) ((nb)>=32 ? (value) : ((1<<(nb))-1) & (value))
-#define IGMPV3_EXP(thresh, nbmant, nbexp, value) \
-	((value) < (thresh) ? (value) : \
-        ((IGMPV3_MASK(value, nbmant) | (1<<(nbmant))) << \
-         (IGMPV3_MASK((value) >> (nbmant), nbexp) + (nbexp))))
-
-#define IGMPV3_QQIC(value) IGMPV3_EXP(0x80, 4, 3, value)
-#define IGMPV3_MRC(value) IGMPV3_EXP(0x80, 4, 3, value)
+
+/*
+ * IGMPv3 QQI/MRT 8-bit exponential field decode.
+ *
+ * RFC3376, 4.1.1 & 4.1.7. defines the decoding formula:
+ *      0 1 2 3 4 5 6 7
+ *     +-+-+-+-+-+-+-+-+
+ *     |1| exp | mant  |
+ *     +-+-+-+-+-+-+-+-+
+ * Max Resp Time = (mant | 0x10) << (exp + 3)
+ * QQI = (mant | 0x10) << (exp + 3)
+ */
+static inline unsigned long igmpv3_exp_field_decode(const u8 code)
+{
+	/* RFC3376, relevant sections:
+	 *  - 4.1.1. Maximum Response Code
+	 *  - 4.1.7. QQIC (Querier's Query Interval Code)
+	 */
+	if (code < IGMPV3_EXP_MIN_THRESHOLD) {
+		return (unsigned long)code;
+	} else {
+		unsigned long mc_man, mc_exp;
+
+		mc_exp = IGMPV3_FP_EXP(code);
+		mc_man = IGMPV3_FP_MAN(code);
+
+		return ((mc_man | 0x10) << (mc_exp + 3));
+	}
+}
+
+/* Calculate Max Resp Time from Maximum Response Code */
+static inline unsigned long igmpv3_mrt(const struct igmpv3_query *ih3)
+{
+	/* RFC3376, relevant sections:
+	 *  - 4.1.1. Maximum Response Code
+	 *  - 8.3. Query Response Interval
+	 */
+	return igmpv3_exp_field_decode(ih3->code);
+}
+
+/* Calculate Querier's Query Interval from Querier's Query Interval Code */
+static inline unsigned long igmpv3_qqi(const struct igmpv3_query *ih3)
+{
+	/* RFC3376, relevant sections:
+	 *  - 4.1.7. QQIC (Querier's Query Interval Code)
+	 *  - 8.2. Query Interval
+	 *  - 8.12. Older Version Querier Present Timeout
+	 *    (the [Query Interval] in the last Query received)
+	 */
+	return igmpv3_exp_field_decode(ih3->qqic);
+}
 
 static inline int ip_mc_may_pull(struct sk_buff *skb, unsigned int len)
 {
diff --git a/net/bridge/br_multicast.c b/net/bridge/br_multicast.c
index 881d866d687a..9fec76e887bc 100644
--- a/net/bridge/br_multicast.c
+++ b/net/bridge/br_multicast.c
@@ -3518,7 +3518,7 @@ static void br_ip4_multicast_query(struct net_bridge_mcast *brmctx,
 			goto out;
 
 		max_delay = ih3->code ?
-			    IGMPV3_MRC(ih3->code) * (HZ / IGMP_TIMER_SCALE) : 1;
+			    igmpv3_mrt(ih3) * (HZ / IGMP_TIMER_SCALE) : 1;
 	} else {
 		goto out;
 	}
diff --git a/net/ipv4/igmp.c b/net/ipv4/igmp.c
index a674fb44ec25..8c6102737096 100644
--- a/net/ipv4/igmp.c
+++ b/net/ipv4/igmp.c
@@ -991,7 +991,7 @@ static bool igmp_heard_query(struct in_device *in_dev, struct sk_buff *skb,
 		 * different encoding. We use the v3 encoding as more likely
 		 * to be intended in a v3 query.
 		 */
-		max_delay = IGMPV3_MRC(ih3->code)*(HZ/IGMP_TIMER_SCALE);
+		max_delay = igmpv3_mrt(ih3)*(HZ/IGMP_TIMER_SCALE);
 		if (!max_delay)
 			max_delay = 1;	/* can't mod w/ 0 */
 	} else { /* v3 */
@@ -1006,7 +1006,7 @@ static bool igmp_heard_query(struct in_device *in_dev, struct sk_buff *skb,
 			ih3 = igmpv3_query_hdr(skb);
 		}
 
-		max_delay = IGMPV3_MRC(ih3->code)*(HZ/IGMP_TIMER_SCALE);
+		max_delay = igmpv3_mrt(ih3)*(HZ/IGMP_TIMER_SCALE);
 		if (!max_delay)
 			max_delay = 1;	/* can't mod w/ 0 */
 		WRITE_ONCE(in_dev->mr_maxdelay, max_delay);
@@ -1016,7 +1016,7 @@ static bool igmp_heard_query(struct in_device *in_dev, struct sk_buff *skb,
 		 * configured value.
 		 */
 		in_dev->mr_qrv = ih3->qrv ?: READ_ONCE(net->ipv4.sysctl_igmp_qrv);
-		in_dev->mr_qi = IGMPV3_QQIC(ih3->qqic)*HZ ?: IGMP_QUERY_INTERVAL;
+		in_dev->mr_qi = igmpv3_qqi(ih3)*HZ ?: IGMP_QUERY_INTERVAL;
 
 		/* RFC3376, 8.3. Query Response Interval:
 		 * The number of seconds represented by the [Query Response
-- 
2.43.0


