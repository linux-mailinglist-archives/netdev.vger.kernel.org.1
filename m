Return-Path: <netdev+bounces-104268-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CCD0A90BC77
	for <lists+netdev@lfdr.de>; Mon, 17 Jun 2024 22:55:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7F9E41F2176A
	for <lists+netdev@lfdr.de>; Mon, 17 Jun 2024 20:55:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E510B19AA53;
	Mon, 17 Jun 2024 20:54:26 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.chopps.org (smtp.chopps.org [54.88.81.56])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75867199EBA
	for <netdev@vger.kernel.org>; Mon, 17 Jun 2024 20:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.88.81.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718657666; cv=none; b=ePwRnNY8z39U5eXR9ihT4Cs6mh26E6UWCYs5GQZZm8m7KbGAhmplREOlxC+i5Q0sB+0f2RhuHPP51NcJm8TqI1f4qVbW4hrdCrA2hw8Ahtkujx0c5jfJWXaXyj7EDXOf/kbwDlx61BKOz5Z3da6XuSu9fulDHKJzXvyTtEDODT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718657666; c=relaxed/simple;
	bh=Ar/58e+XsltjsjvXW0I2bii94qjU1sZgQDEHtFGCwEE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rEnzlpnrmQXjBljwpXKz+iYeBBGLW//1dmibCxJsS6h9RPSzOCvbP8qQzKhLcOOdhpxcUTSGr9/8zooAHPHvm6TUyQ7ml8Ub8qgLFqdVOtdrXt8jCBAaTI/0m5ZVpfchrvI7Dq16gYE6hbaE4o50qiVOrNHg8V3QEeRJ8jtTfwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chopps.org; spf=fail smtp.mailfrom=chopps.org; arc=none smtp.client-ip=54.88.81.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chopps.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=chopps.org
Received: from labnh.big (syn-172-222-091-149.res.spectrum.com [172.222.91.149])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by smtp.chopps.org (Postfix) with ESMTPSA id 105AE7D120;
	Mon, 17 Jun 2024 20:54:25 +0000 (UTC)
From: Christian Hopps <chopps@chopps.org>
To: devel@linux-ipsec.org
Cc: Steffen Klassert <steffen.klassert@secunet.com>,
	netdev@vger.kernel.org,
	Christian Hopps <chopps@chopps.org>,
	Christian Hopps <chopps@labn.net>
Subject: [PATCH ipsec-next v4 17/18] xfrm: iptfs: only send the NL attrs that corr. to the SA dir
Date: Mon, 17 Jun 2024 16:53:15 -0400
Message-ID: <20240617205316.939774-18-chopps@chopps.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240617205316.939774-1-chopps@chopps.org>
References: <20240617205316.939774-1-chopps@chopps.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Christian Hopps <chopps@labn.net>

When sending the netlink attributes to the user for a given SA, only
send those NL attributes which correspond to the SA's direction.

Signed-off-by: Christian Hopps <chopps@labn.net>
---
 net/xfrm/xfrm_iptfs.c | 64 ++++++++++++++++++++++++-------------------
 1 file changed, 36 insertions(+), 28 deletions(-)

diff --git a/net/xfrm/xfrm_iptfs.c b/net/xfrm/xfrm_iptfs.c
index 59fd8ee49cd4..049a94a5531b 100644
--- a/net/xfrm/xfrm_iptfs.c
+++ b/net/xfrm/xfrm_iptfs.c
@@ -2498,13 +2498,16 @@ static unsigned int iptfs_sa_len(const struct xfrm_state *x)
 	struct xfrm_iptfs_config *xc = &xtfs->cfg;
 	unsigned int l = 0;
 
-	if (xc->dont_frag)
-		l += nla_total_size(0);
-	l += nla_total_size(sizeof(xc->reorder_win_size));
-	l += nla_total_size(sizeof(xc->pkt_size));
-	l += nla_total_size(sizeof(xc->max_queue_size));
-	l += nla_total_size(sizeof(u32)); /* drop time usec */
-	l += nla_total_size(sizeof(u32)); /* init delay usec */
+	if (x->dir == XFRM_SA_DIR_IN) {
+		l += nla_total_size(sizeof(u32)); /* drop time usec */
+		l += nla_total_size(sizeof(xc->reorder_win_size));
+	} else {
+		if (xc->dont_frag)
+			l += nla_total_size(0);	  /* dont-frag flag */
+		l += nla_total_size(sizeof(u32)); /* init delay usec */
+		l += nla_total_size(sizeof(xc->max_queue_size));
+		l += nla_total_size(sizeof(xc->pkt_size));
+	}
 
 	return l;
 }
@@ -2516,30 +2519,35 @@ static int iptfs_copy_to_user(struct xfrm_state *x, struct sk_buff *skb)
 	int ret;
 	u64 q;
 
-	if (xc->dont_frag) {
-		ret = nla_put_flag(skb, XFRMA_IPTFS_DONT_FRAG);
+	if (x->dir == XFRM_SA_DIR_IN) {
+		q = xtfs->drop_time_ns;
+		(void)do_div(q, NSECS_IN_USEC);
+		ret = nla_put_u32(skb, XFRMA_IPTFS_DROP_TIME, q);
+		if (ret)
+			return ret;
+
+		ret = nla_put_u16(skb, XFRMA_IPTFS_REORDER_WINDOW,
+				  xc->reorder_win_size);
+	} else {
+		if (xc->dont_frag) {
+			ret = nla_put_flag(skb, XFRMA_IPTFS_DONT_FRAG);
+			if (ret)
+				return ret;
+		}
+
+		q = xtfs->init_delay_ns;
+		(void)do_div(q, NSECS_IN_USEC);
+		ret = nla_put_u32(skb, XFRMA_IPTFS_INIT_DELAY, q);
+		if (ret)
+			return ret;
+
+		ret = nla_put_u32(skb, XFRMA_IPTFS_MAX_QSIZE,
+				  xc->max_queue_size);
 		if (ret)
 			return ret;
+
+		ret = nla_put_u32(skb, XFRMA_IPTFS_PKT_SIZE, xc->pkt_size);
 	}
-	ret = nla_put_u16(skb, XFRMA_IPTFS_REORDER_WINDOW, xc->reorder_win_size);
-	if (ret)
-		return ret;
-	ret = nla_put_u32(skb, XFRMA_IPTFS_PKT_SIZE, xc->pkt_size);
-	if (ret)
-		return ret;
-	ret = nla_put_u32(skb, XFRMA_IPTFS_MAX_QSIZE, xc->max_queue_size);
-	if (ret)
-		return ret;
-
-	q = xtfs->drop_time_ns;
-	(void)do_div(q, NSECS_IN_USEC);
-	ret = nla_put_u32(skb, XFRMA_IPTFS_DROP_TIME, q);
-	if (ret)
-		return ret;
-
-	q = xtfs->init_delay_ns;
-	(void)do_div(q, NSECS_IN_USEC);
-	ret = nla_put_u32(skb, XFRMA_IPTFS_INIT_DELAY, q);
 
 	return ret;
 }
-- 
2.45.2


