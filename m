Return-Path: <netdev+bounces-94045-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F7788BE014
	for <lists+netdev@lfdr.de>; Tue,  7 May 2024 12:47:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0F32E1F258CA
	for <lists+netdev@lfdr.de>; Tue,  7 May 2024 10:47:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9590F15DBDD;
	Tue,  7 May 2024 10:44:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b="D2sAopUp"
X-Original-To: netdev@vger.kernel.org
Received: from mail1.fiberby.net (mail1.fiberby.net [193.104.135.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D533315664F;
	Tue,  7 May 2024 10:44:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.104.135.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715078691; cv=none; b=nGIENnQ6Uy1eTUlAqLXxSE4QmklKWG9ZGWqJhB2fiQWqIpUENqTCjvIQRC+15adLBkJwnTjroupnIKO68xnPvrk7ScVYf4Rcs3bx7P1MmPVCdbRh0baFE7lIgGng9mukyE2sGMMFPBcEVYHEezrCAJjFuv1OyJUGeLIIcSsbnYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715078691; c=relaxed/simple;
	bh=zY/EjcYVP/zTXYlcoTUN4av1Sp3C6so43ZjWoY3jWsE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CZBH4kNltkkBePGaArgHAqWsfVMmaXFzY1IPf9YBlrz34yLr6ZB6Kio9JJOTe1U47iyYO5prpF2heebYAGSwZJaJVBWMY+278h6xRbd0Yrr4av6Cm03CBRVQW119Jeu41I4ZeKSV0Fz5HN6hxZ3VztsJMA4zle0Nw71easbpi9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net; spf=pass smtp.mailfrom=fiberby.net; dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b=D2sAopUp; arc=none smtp.client-ip=193.104.135.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fiberby.net
Received: from x201s (193-104-135-243.ip4.fiberby.net [193.104.135.243])
	by mail1.fiberby.net (Postfix) with ESMTPSA id AAD3760178;
	Tue,  7 May 2024 10:44:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fiberby.net;
	s=202008; t=1715078675;
	bh=zY/EjcYVP/zTXYlcoTUN4av1Sp3C6so43ZjWoY3jWsE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=D2sAopUpIaXtBeS63XlHyU7Ir1cOr0aBMmZ0Sivg+1KMVpIUP3x49BLUfFFUVvp8r
	 Luzlps9rDdc4Z6t+1ExWK8dH44VMyyjHNEDRyLCGfZEHRxpOYvq151PpPC+Ie2hAkk
	 Hpxndb5ZfvsOcErdviKKxX6vhWUesKwliFZHmrZfUaT9jQ9a7A6g/cVDw3RegNUpZb
	 ENZELJUT6zuRnZCFCfl6zSVA5VZ2cLVNtF0CRxJnJvOCl6j0jz8PKhGCDwieh+boEi
	 uXceSgaf/kwl9k/CGHTTAaVdMcV41cg+8KwxUfaQlYcy6/YWv6Gzdaw9bJf6HE6UFm
	 sbfouEJJqLHRg==
Received: by x201s (Postfix, from userid 1000)
	id 774C020372E; Tue, 07 May 2024 10:44:23 +0000 (UTC)
From: =?UTF-8?q?Asbj=C3=B8rn=20Sloth=20T=C3=B8nnesen?= <ast@fiberby.net>
To: netdev@vger.kernel.org
Cc: =?UTF-8?q?Asbj=C3=B8rn=20Sloth=20T=C3=B8nnesen?= <ast@fiberby.net>,
	linux-kernel@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Manish Chopra <manishc@marvell.com>
Subject: [PATCH net-next 05/14] net: qede: use extack in qede_flow_parse_v4_common()
Date: Tue,  7 May 2024 10:44:06 +0000
Message-ID: <20240507104421.1628139-6-ast@fiberby.net>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240507104421.1628139-1-ast@fiberby.net>
References: <20240507104421.1628139-1-ast@fiberby.net>
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
index d151b64a0436..056384362037 100644
--- a/drivers/net/ethernet/qlogic/qede/qede_filter.c
+++ b/drivers/net/ethernet/qlogic/qede/qede_filter.c
@@ -1757,8 +1757,9 @@ qede_flow_parse_v6_common(struct netlink_ext_ack *extack,
 }
 
 static int
-qede_flow_parse_v4_common(struct qede_dev *edev, struct flow_rule *rule,
-			struct qede_arfs_tuple *t)
+qede_flow_parse_v4_common(struct netlink_ext_ack *extack,
+			  struct flow_rule *rule,
+			  struct qede_arfs_tuple *t)
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
 
-	err = qede_flow_parse_ports(NULL, rule, t);
+	err = qede_flow_parse_ports(extack, rule, t);
 	if (err)
 		return err;
 
-	return qede_set_v4_tuple_to_profile(NULL, t);
+	return qede_set_v4_tuple_to_profile(extack, t);
 }
 
 static int
@@ -1800,7 +1802,7 @@ qede_flow_parse_tcp_v4(struct qede_dev *edev, struct flow_rule *rule,
 	tuple->ip_proto = IPPROTO_TCP;
 	tuple->eth_proto = htons(ETH_P_IP);
 
-	return qede_flow_parse_v4_common(edev, rule, tuple);
+	return qede_flow_parse_v4_common(NULL, rule, tuple);
 }
 
 static int
@@ -1820,7 +1822,7 @@ qede_flow_parse_udp_v4(struct qede_dev *edev, struct flow_rule *rule,
 	tuple->ip_proto = IPPROTO_UDP;
 	tuple->eth_proto = htons(ETH_P_IP);
 
-	return qede_flow_parse_v4_common(edev, rule, tuple);
+	return qede_flow_parse_v4_common(NULL, rule, tuple);
 }
 
 static int
-- 
2.43.0


