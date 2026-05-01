Return-Path: <netdev+bounces-283249-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sOJANnfk9Gl1FgIAu9opvQ
	(envelope-from <netdev+bounces-283249-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 01 May 2026 19:35:51 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 881CE4AE912
	for <lists+netdev@lfdr.de>; Fri, 01 May 2026 19:35:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E4B12305DEC2
	for <lists+netdev@lfdr.de>; Fri,  1 May 2026 17:31:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B81A330E82D;
	Fri,  1 May 2026 17:31:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h43qFyYc"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5006B30E0D6
	for <netdev@vger.kernel.org>; Fri,  1 May 2026 17:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777656711; cv=none; b=YsUN+4TAowsGpzzrFP0yPuP4bTkT3eh6P+t2rKdPVWlUGJVKq/YrfX2Pv1Ejar6WD2puD+XzX17SursuAnqVehulac7PCDm20ev4gDtK/vJHimSCxh3zHQ0IgiVVj/1EPDUZqjlXXcfoYyUCUOOI73jTRX3OVsUwoSBAsQqv2ck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777656711; c=relaxed/simple;
	bh=OIVGLHkE0+zv8tPvOlRxlxnAchQfUFIaCtRMGLN9J8Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=r3NZMr7izAoU1YJFdomq1tfL2IwDHCtXaH/sA+0F1tDHoNXzMh4SMwRenshfYpvn4U2MdF/Tc0ApvfOTH8m6XLn4MJgZBKKQUJ4hJsKRUPniDqBB7omBFKN47RW+Xhf4yadVvX2h0WwiKqMZM0RFmJ5hNQ4F9fzvVVmiCZ/5rgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h43qFyYc; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-364ef7a759bso540045a91.1
        for <netdev@vger.kernel.org>; Fri, 01 May 2026 10:31:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777656709; x=1778261509; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YWCZJ9utsVn2aH4mDSbQniFeJPJsfUBS8uLBgw2m2To=;
        b=h43qFyYcKZwo1MSgMOkH/3ISiYG2BTyPOYOgSmNLinPpNpZOOV+Fzc0UMd1bMyA/RW
         jO53Vd7sQADeyi+JI9runBIN38BhU315ljAFiNtrUkW9DBydqFIoapW5ehLahLttJo/7
         cqAr8WioNnP4Nc06CuDzilel7Vpi4ZQVHNV/rXtt7s+d09Bn9JopNwxv+DKECN8KTeZC
         sxw9cSoozlTNQRqCQTAjNllQnFS+tKxMxcaxs3t80Yq1WdBE+pDzJ9Y9k3Cz5TXQiYVx
         xpW+v47dEF8a4XS+cXDcEw7SzUb3qnfejkadFNqT1XzL/7ooyiS5v16nwxUs1usdORdE
         Amag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777656709; x=1778261509;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=YWCZJ9utsVn2aH4mDSbQniFeJPJsfUBS8uLBgw2m2To=;
        b=JeNmiRdP2dxArBc+QuidsZka7UTCmby8EiYsV3pyAJdEnwjJ5f8yciWrG76oPXa0Xh
         YiJKadBWWUqULH3+h+JAzk7CZmCbLGf1Jeu0fQVbkHCeyvbcPNK3XNQAPKN4PbQe7wKA
         p/g8y6VMx/ph/Q0Ls3b1ax5SwSOsYv3hoPyjzbSUyc3/xGqhiqxxryhgaDy1KLdjP3pr
         tN91ORN6OXOmM+VrLhO8KGa7BtU/sFlfF1NOAMUC7fNnC99yRmNfbk/WsvQ/zjTVHlgu
         WcYUzAkJBVW0JzYC7/+aRJAdY3+DViBBItofSyPk+EU6aNaec1qcz0AT2MAXlVlgY+jU
         M6gQ==
X-Forwarded-Encrypted: i=1; AFNElJ/M1hT5QXXcVeuu4KWsakN7Z4YkAQIYeFDmU6ZgXg+hCYdEq4CCLzR1U5hUcUYmJz1hAuO7sSo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyypRuer/i5OTSR8e01FMf0/GH3X9hvn0ej/H9Crf4bXB921kN5
	ffwpZUEt/2IPVpd4qIwwHBvXcuIXNwsFKqXX2mIwKqmd2MnR8AjoW4dz
X-Gm-Gg: AeBDietaOm8wS5wiE4AOw84Gg09i1cmw5vRWeXi1mkm3/ZIJKn3SY7DK1YKBmg2p6rW
	ipXilD3i9Ekc8athee1MeNC76yUo4W0hAr3RpNywM8t897BSqjRAtVHtBufHUY9EguE+8wD6Shr
	jNa43hXxa0aynl/lw9xpFPEEIX0BC3e8Y+yatFNX0mVe2WiXfZ16qAB+auiAnQOLXkYrleSFrWX
	Wkj/006YTKNMGAmevImKz0b5DdSoSX6BTSkj4fobLxsIwULjMBFwLsS8yqSBq1DO9RPvezxRzTn
	k9trWay7ruoN5IPNN/PBxDNZEdTtbj7mEo1U369ThAO5JoQU4z4w32cTVaL+n8uKuqW35ixXrfm
	cHtdrXIGh7aX9tQE1FzFBky5aX3vP5r4tm37FjVT1WdthEvRWnyeDAKVl8G5JDoPqqS27s7GmVB
	a6kI0vLUGtLdYco+6ou4W9/o//mjsYxYSsb6pE5x+jz2GezWYEeg==
X-Received: by 2002:a17:90b:498c:b0:35f:b9f1:fded with SMTP id 98e67ed59e1d1-3650c4f44f4mr293791a91.12.1777656709241;
        Fri, 01 May 2026 10:31:49 -0700 (PDT)
Received: from DESKTOP-82PPU4A.localdomain ([202.8.116.84])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-364ebec73aasm2908906a91.2.2026.05.01.10.31.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 May 2026 10:31:48 -0700 (PDT)
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
Subject: [PATCH net-next v5 1/5] ipv4: igmp: get rid of IGMPV3_{QQIC,MRC} and simplify calculation
Date: Fri,  1 May 2026 17:31:25 +0000
Message-ID: <20260501173130.3486-2-royujjal@gmail.com>
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
X-Rspamd-Queue-Id: 881CE4AE912
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-283249-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[royujjal@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

Get rid of the IGMPV3_MRC macro and use the igmpv3_mrt() API to
calculate the Max Resp Time from the Maximum Response Code.

Similarly, for IGMPV3_QQIC, use the igmpv3_qqi() API to calculate
the Querier's Query Interval from the QQIC field.

Reviewed-by: Ido Schimmel <idosch@nvidia.com>
Signed-off-by: Ujjal Roy <royujjal@gmail.com>
---
 include/linux/igmp.h      | 80 +++++++++++++++++++++++++++++++++++----
 net/bridge/br_multicast.c |  2 +-
 net/ipv4/igmp.c           |  6 +--
 3 files changed, 76 insertions(+), 12 deletions(-)

diff --git a/include/linux/igmp.h b/include/linux/igmp.h
index 073b30a9b850..0e095c9f234e 100644
--- a/include/linux/igmp.h
+++ b/include/linux/igmp.h
@@ -92,15 +92,79 @@ struct ip_mc_list {
 	struct rcu_head		rcu;
 };
 
+/* RFC3376, relevant sections:
+ *  - 4.1.1. Maximum Response Code
+ *  - 4.1.7. QQIC (Querier's Query Interval Code)
+ *
+ * For both MRC and QQIC, values >= 128 use the same floating-point
+ * encoding as follows:
+ *
+ *  0 1 2 3 4 5 6 7
+ * +-+-+-+-+-+-+-+-+
+ * |1| exp | mant  |
+ * +-+-+-+-+-+-+-+-+
+ */
+#define IGMPV3_FP_EXP(value)		(((value) >> 4) & 0x07)
+#define IGMPV3_FP_MAN(value)		((value) & 0x0f)
+
+/* IGMPv3 floating-point exponential field min threshold */
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
+/* IGMPv3 MRC/QQIC 8-bit exponential field decode
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
+	if (code < IGMPV3_EXP_MIN_THRESHOLD) {
+		return code;
+	} else {
+		unsigned long mc_man, mc_exp;
+
+		mc_exp = IGMPV3_FP_EXP(code);
+		mc_man = IGMPV3_FP_MAN(code);
+
+		return (mc_man | 0x10) << (mc_exp + 3);
+	}
+}
+
+/* Calculate Max Resp Time from Maximum Response Code
+ *
+ * RFC3376, relevant sections:
+ *  - 4.1.1. Maximum Response Code
+ *  - 8.3. Query Response Interval
+ *
+ * After decode, MRC represents the Maximum Response Time (MRT) in
+ * units of 0.1 seconds (100 ms).
+ */
+static inline unsigned long igmpv3_mrt(const struct igmpv3_query *ih3)
+{
+	return igmpv3_exp_field_decode(ih3->code);
+}
+
+/* Calculate Querier's Query Interval from Querier's Query Interval Code
+ *
+ * RFC3376, relevant sections:
+ *  - 4.1.7. QQIC (Querier's Query Interval Code)
+ *  - 8.2. Query Interval
+ *  - 8.12. Older Version Querier Present Timeout
+ *    (the [Query Interval] in the last Query received)
+ *
+ * After decode, QQIC represents the Querier's Query Interval in units
+ * of seconds.
+ */
+static inline unsigned long igmpv3_qqi(const struct igmpv3_query *ih3)
+{
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
index a674fb44ec25..d7eff36d98c3 100644
--- a/net/ipv4/igmp.c
+++ b/net/ipv4/igmp.c
@@ -991,7 +991,7 @@ static bool igmp_heard_query(struct in_device *in_dev, struct sk_buff *skb,
 		 * different encoding. We use the v3 encoding as more likely
 		 * to be intended in a v3 query.
 		 */
-		max_delay = IGMPV3_MRC(ih3->code)*(HZ/IGMP_TIMER_SCALE);
+		max_delay = igmpv3_mrt(ih3) * (HZ / IGMP_TIMER_SCALE);
 		if (!max_delay)
 			max_delay = 1;	/* can't mod w/ 0 */
 	} else { /* v3 */
@@ -1006,7 +1006,7 @@ static bool igmp_heard_query(struct in_device *in_dev, struct sk_buff *skb,
 			ih3 = igmpv3_query_hdr(skb);
 		}
 
-		max_delay = IGMPV3_MRC(ih3->code)*(HZ/IGMP_TIMER_SCALE);
+		max_delay = igmpv3_mrt(ih3) * (HZ / IGMP_TIMER_SCALE);
 		if (!max_delay)
 			max_delay = 1;	/* can't mod w/ 0 */
 		WRITE_ONCE(in_dev->mr_maxdelay, max_delay);
@@ -1016,7 +1016,7 @@ static bool igmp_heard_query(struct in_device *in_dev, struct sk_buff *skb,
 		 * configured value.
 		 */
 		in_dev->mr_qrv = ih3->qrv ?: READ_ONCE(net->ipv4.sysctl_igmp_qrv);
-		in_dev->mr_qi = IGMPV3_QQIC(ih3->qqic)*HZ ?: IGMP_QUERY_INTERVAL;
+		in_dev->mr_qi = igmpv3_qqi(ih3) * HZ ? : IGMP_QUERY_INTERVAL;
 
 		/* RFC3376, 8.3. Query Response Interval:
 		 * The number of seconds represented by the [Query Response
-- 
2.43.0


