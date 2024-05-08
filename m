Return-Path: <netdev+bounces-94634-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 274398C0050
	for <lists+netdev@lfdr.de>; Wed,  8 May 2024 16:43:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8D17C1F234BE
	for <lists+netdev@lfdr.de>; Wed,  8 May 2024 14:43:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C9BF86AE2;
	Wed,  8 May 2024 14:43:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b="Y7VKoefo"
X-Original-To: netdev@vger.kernel.org
Received: from mail1.fiberby.net (mail1.fiberby.net [193.104.135.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EB938626F;
	Wed,  8 May 2024 14:43:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.104.135.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715179394; cv=none; b=W+iTB3svwFGbo6Gz/nEkVF8evCvmNoYFE/P3i2AiUyQdNVib0NCfx4n4llVUcAlEl5LBYgbUPwuHcmxQSEMOfswldvWiMgL0M1F3xeujehHICVxOy3oFBAsCQvter8197tmuPvuQuECZOfVrrIg9bPy8cLCwRaLp2Ux86A+YWwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715179394; c=relaxed/simple;
	bh=iJRr2/PLcmsvTBiKIqdorvzZaAeypcrVtcIGQuFhQtQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AUhtu2SbkFR+S7h9ruK9Y33l02mP9BSmwWQJeeKI5jRGNnzH25YAL6ttTKzmjEduICzbybVejsxyrCo/AvUNfUstGg6nF84sluNVAJZliA4AF8D9Xc/OZm2k+LPMdoI4S7aTNTZl5ne4ofG7ZerHNXG2JqwsONvBm7TnUuhWHmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net; spf=pass smtp.mailfrom=fiberby.net; dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b=Y7VKoefo; arc=none smtp.client-ip=193.104.135.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fiberby.net
Received: from x201s (193-104-135-243.ip4.fiberby.net [193.104.135.243])
	by mail1.fiberby.net (Postfix) with ESMTPSA id 2761B600A5;
	Wed,  8 May 2024 14:34:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fiberby.net;
	s=202008; t=1715178866;
	bh=iJRr2/PLcmsvTBiKIqdorvzZaAeypcrVtcIGQuFhQtQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Y7VKoefonm97HZ+cBF+duyVXXKm/nDbjVq8TIbg0qbjv0T6E57/7dwM1ZLVd1QbTL
	 jp7f2rQUr3sz0Lc8cHkNK/+XW1jCEosdafv/o/8GioidypeXSfmXBavmt36uvXLsiq
	 gn5OTlms4PAredJ+7Ul1hvgf3rKn8lN6Esx6uPR2eglkv8EuUKL2CfvagoSY2FvSuU
	 lZnu1RMuX1dTE9IOgSvmt1JutYDEyTkjFUOjSlNfpIsTov1V+FcvQEnRMn4r6EiwuV
	 WuADLCp+pRMJP0ATLLv4ESsqqJ0f6091NUn3n+AwH6atJUXun/OSaiwI8P0BBtCOaX
	 YoEKl3tid/dqA==
Received: by x201s (Postfix, from userid 1000)
	id 07293204DBA; Wed, 08 May 2024 14:34:06 +0000 (UTC)
From: =?UTF-8?q?Asbj=C3=B8rn=20Sloth=20T=C3=B8nnesen?= <ast@fiberby.net>
To: netdev@vger.kernel.org
Cc: =?UTF-8?q?Asbj=C3=B8rn=20Sloth=20T=C3=B8nnesen?= <ast@fiberby.net>,
	linux-kernel@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Manish Chopra <manishc@marvell.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>
Subject: [PATCH net-next v2 05/14] net: qede: use extack in qede_flow_parse_v4_common()
Date: Wed,  8 May 2024 14:33:53 +0000
Message-ID: <20240508143404.95901-6-ast@fiberby.net>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240508143404.95901-1-ast@fiberby.net>
References: <20240508143404.95901-1-ast@fiberby.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Convert qede_flow_parse_v4_common() to take extack,
and drop the edev argument.

Convert DP_NOTICE call to use NL_SET_ERR_MSG_MOD instead.

Pass extack in calls to qede_flow_parse_ports() and
qede_set_v4_tuple_to_profile().

In calls to qede_flow_parse_v4_common(), use NULL as extack
for now, until a subsequent patch makes extack available.

Only compile tested.

Signed-off-by: Asbjørn Sloth Tønnesen <ast@fiberby.net>
---
 drivers/net/ethernet/qlogic/qede/qede_filter.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/qlogic/qede/qede_filter.c b/drivers/net/ethernet/qlogic/qede/qede_filter.c
index f5f8bbe8a64c..28e4d54dbca1 100644
--- a/drivers/net/ethernet/qlogic/qede/qede_filter.c
+++ b/drivers/net/ethernet/qlogic/qede/qede_filter.c
@@ -1757,8 +1757,9 @@ qede_flow_parse_v6_common(struct flow_rule *rule,
 }
 
 static int
-qede_flow_parse_v4_common(struct qede_dev *edev, struct flow_rule *rule,
-			struct qede_arfs_tuple *t)
+qede_flow_parse_v4_common(struct flow_rule *rule,
+			  struct qede_arfs_tuple *t,
+			  struct netlink_ext_ack *extack)
 {
 	int err;
 
@@ -1768,7 +1769,8 @@ qede_flow_parse_v4_common(struct qede_dev *edev, struct flow_rule *rule,
 		flow_rule_match_ipv4_addrs(rule, &match);
 		if ((match.key->src && match.mask->src != htonl(U32_MAX)) ||
 		    (match.key->dst && match.mask->dst != htonl(U32_MAX))) {
-			DP_NOTICE(edev, "Do not support ipv4 prefix/masks\n");
+			NL_SET_ERR_MSG_MOD(extack,
+					   "Do not support ipv4 prefix/masks");
 			return -EINVAL;
 		}
 
@@ -1776,11 +1778,11 @@ qede_flow_parse_v4_common(struct qede_dev *edev, struct flow_rule *rule,
 		t->dst_ipv4 = match.key->dst;
 	}
 
-	err = qede_flow_parse_ports(rule, t, NULL);
+	err = qede_flow_parse_ports(rule, t, extack);
 	if (err)
 		return err;
 
-	return qede_set_v4_tuple_to_profile(t, NULL);
+	return qede_set_v4_tuple_to_profile(t, extack);
 }
 
 static int
@@ -1800,7 +1802,7 @@ qede_flow_parse_tcp_v4(struct qede_dev *edev, struct flow_rule *rule,
 	tuple->ip_proto = IPPROTO_TCP;
 	tuple->eth_proto = htons(ETH_P_IP);
 
-	return qede_flow_parse_v4_common(edev, rule, tuple);
+	return qede_flow_parse_v4_common(rule, tuple, NULL);
 }
 
 static int
@@ -1820,7 +1822,7 @@ qede_flow_parse_udp_v4(struct qede_dev *edev, struct flow_rule *rule,
 	tuple->ip_proto = IPPROTO_UDP;
 	tuple->eth_proto = htons(ETH_P_IP);
 
-	return qede_flow_parse_v4_common(edev, rule, tuple);
+	return qede_flow_parse_v4_common(rule, tuple, NULL);
 }
 
 static int
-- 
2.43.0


