Return-Path: <netdev+bounces-273306-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QN+kCX3Myml3AAYAu9opvQ
	(envelope-from <netdev+bounces-273306-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 30 Mar 2026 21:18:21 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A3673603FA
	for <lists+netdev@lfdr.de>; Mon, 30 Mar 2026 21:18:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 94AB9303C5AA
	for <lists+netdev@lfdr.de>; Mon, 30 Mar 2026 19:16:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B85A39526F;
	Mon, 30 Mar 2026 19:16:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KXK0wAgJ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52FE338A710
	for <netdev@vger.kernel.org>; Mon, 30 Mar 2026 19:16:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774898203; cv=none; b=TG4Uo7ro/+LTIzmU7HYL34wBgjGIy/HjWSFJRgO9Ij1EnS6g81ZM8tS5X7Np2rmtdimM/VrTmRcnVkvni4oDhY8RgaK3f5bck67/weLFJnt73TOfy1GpYZp/R/nndrBP1C4rYjodjRTe9fu+SgUjIVfkVJs/J1wCu40lPMb3hns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774898203; c=relaxed/simple;
	bh=yJDiUN34AyED1s3Mh0BhhgYdT8RuWlDR34wMFTuxleY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IGYy5Q29d12RjQSx8Y35TIYJEqzwYqT5DGsNIuQONayy8vEZ55IuMoYa9vnjPBZqoIKWg4loNxEuoFKPYZuWO19kPwCFSxhxKh5HnDfMNBMIiR1XJgN1XtUS4ZylJlMMn2PYIJXqp8RZbQJIP3SPYD2Zm4eWfkvqFXIbpIst4TE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KXK0wAgJ; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-35d90833cacso1633700a91.2
        for <netdev@vger.kernel.org>; Mon, 30 Mar 2026 12:16:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774898202; x=1775503002; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c1FELrnIn+Cl/sQAWOOdScMKmjJwFkZRPYjIHZTYdfw=;
        b=KXK0wAgJ61ALIOtY3eaCOy+4gmxE0xDeBuy5pFyauw8fqqYCBIJZa1XHxYxIZN2AXx
         +Sy+tVx4kMu7EmQDGPla15+3mudmDYLi/dZzitNpBkrTxK0ih1LiKwZtf+9VBxPNymrF
         +k7gfMJ/17M7eTIIKzeOzOEQBn5PotyCgglu3KmikoSrpOLjCJUQRTAxizKXoRSJNFIt
         Rum/v7naw1yNmkroS/0VOlO/6l05+ZfjRcK0CYt/w3suc/5/GZwYi89h5NQgxPUF0GLB
         NXAklHQ9B2pDIDmo1bP9Wi2iQ1gMAlwvk1CZjyopx2AGs9GzkdDZT4204UJU6PNeotk1
         dJOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774898202; x=1775503002;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=c1FELrnIn+Cl/sQAWOOdScMKmjJwFkZRPYjIHZTYdfw=;
        b=fOU+NAwywYFnPA8XQ5WJVFy8H+GIgLdvubbT/LrLBauuAJfcATorSrBn0qk0Jnrloi
         2g3SVg2e848sAtmIaFOqgnei3mCbgoaZ7lE7Yi2IP0GWF0f3W1OYxsfVGAzXYoc6kyaY
         rp3oQNUeScOdHj9mRnV/ZqB3asWdCBFgKFpyMu2DwGiw4w+H6Ti08HCwE8Yam2W/EuMJ
         7U7+Y2Cy7a+gIMDhNmAjS0FWVzfvSw/M6NtnIe+eoYwzMnzYVZGE+BKhiy9KAxjH97nB
         ukCQXC5M/KtzQzjlV5Roc0mBpfexrt8rLTu4qO2EjqWjniGMOZuekMXV3jw67gesVWnF
         MW1A==
X-Forwarded-Encrypted: i=1; AJvYcCVlEHMFnievCK6KbzaCWYrRdn7lnqCN9HcLkOADAqNAtr7uzOWhmKBwKujVqbXZGim1edVRwbE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx33NRRhqJQVd9btI5YecMXQgDrd+BwTaERBiOIuihfSldQnNXK
	+7b7ss5tn7unOomqCgzcNAgEWEUBCYywAWfS8bt0QOryYUEoK924rnRb
X-Gm-Gg: ATEYQzyKTRB9Qs/hPl1Pp3yJTo0NSpwIupjujSte0jGMMtmrf0gmXyiUWYmUZchveU7
	whqbSq/D+WWrdmfTvOLQ3P7yW6KZMId0MEt/VOod86hlbeaFotQ/6IMfT2lvWKk7H0CVlHEMmH4
	HB44UDnPyvrwxbxEWM4wed1Av/9BVECyJTPQgD80L9VS+T/tmdaDTQjdZpa8Iv4GhpY2dBK0gvR
	heYT2D3SijJ2KYbQt/JXgtpGG7qYdoDfq/BV3MLiWJYZPJNI6LU6dzBRi79rcVm+IBw1IDhensv
	IDJHXB5mAZQ/TP6hb2YmWE8yvkMptHzv5SyZUd7evyN0m8Jd1QTgNgUcEzb73df0eHg2h7bfq1N
	BP0O43FPCRMFpCL8GxApR0x+KX0JHI4noJk7xRqEixy6+8f/XzaICAn7VqDAQDV/1LuXW5gNv9i
	oPkwH0iQzzoRs0U1xQtDOWXBKXRqqF/AgIxN4q/Pe3
X-Received: by 2002:a17:90b:1d11:b0:35c:a8f:5c5f with SMTP id 98e67ed59e1d1-35c2ff6afecmr12284030a91.8.1774898201514;
        Mon, 30 Mar 2026 12:16:41 -0700 (PDT)
Received: from DESKTOP-82PPU4A.localdomain ([202.8.116.192])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35d950d9b12sm9627178a91.17.2026.03.30.12.16.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2026 12:16:41 -0700 (PDT)
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
Subject: [PATCH net-next v2 2/5] ipv6: mld: rename mldv2_mrc() and add mldv2_qqi()
Date: Mon, 30 Mar 2026 19:16:08 +0000
Message-ID: <20260330191611.16929-3-royujjal@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-273306-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[17];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
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
X-Rspamd-Queue-Id: 9A3673603FA
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
index c07359808493..5e093f9c75d9 100644
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


