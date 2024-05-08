Return-Path: <netdev+bounces-94616-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 54A2E8C000B
	for <lists+netdev@lfdr.de>; Wed,  8 May 2024 16:34:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 86D2D1C231FB
	for <lists+netdev@lfdr.de>; Wed,  8 May 2024 14:34:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2091D86626;
	Wed,  8 May 2024 14:34:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b="UsdR0ld2"
X-Original-To: netdev@vger.kernel.org
Received: from mail1.fiberby.net (mail1.fiberby.net [193.104.135.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 060B486251;
	Wed,  8 May 2024 14:34:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.104.135.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715178878; cv=none; b=ombPfrjlYfsr3YyjIUAVyIGSZnJ4F1VF65KN9il0jNeB9iWBJD6AT+qT2ds2ahXhtx7DidTFUmNXHgJwZ6l+bXP9NKufTyyXgZqkkTAyc06iO4xl3C/S+U6gLZ3X7eTp7yyM6qtMUvzBTRbQP5Ww/HuHh9qEI0FHPNhaVwx4H+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715178878; c=relaxed/simple;
	bh=dIyCGWv88HPEo9u3w+G92ib5XEC84EWs54UjZI5zQEU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Rc8OgJud68odxiWiNBVg/OkrJ7Rmuf2o7DtvpBWYvfkamTuyR+OH9U2f/JwV2fvIqbH0MzKXaCYGhTembJWIDPxyj+q7E61lRqQtFjC/gQIxId9VnzRXwiAv17878uudohCmHXM99dhyWAVALFWTTlS2VcLhLcCytrPLg+yPVDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net; spf=pass smtp.mailfrom=fiberby.net; dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b=UsdR0ld2; arc=none smtp.client-ip=193.104.135.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fiberby.net
Received: from x201s (193-104-135-243.ip4.fiberby.net [193.104.135.243])
	by mail1.fiberby.net (Postfix) with ESMTPSA id 80DCC600A9;
	Wed,  8 May 2024 14:34:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fiberby.net;
	s=202008; t=1715178869;
	bh=dIyCGWv88HPEo9u3w+G92ib5XEC84EWs54UjZI5zQEU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UsdR0ld2vq4o8ezPDGSaVgb5RULLAnn5Kb/YXjbMix8Jx7A7I35Yw43VHT8UDdTsU
	 aCc6xHOfUIXgd1V39Ucz8xuIphYbGG8UmaW6SuctR5LOu5eVsQ7xycGofvLWvnkPd7
	 g4xj2aivn5fQC6wuaSnWP3pBdgrZL3drEx4zDy2CUg6Zn6CSqlv6eFnHbVOvIBLCNj
	 ZYIU7Sgdm6fr6g1Z8PhQLoc0ZF2L8yW9nE05E5Z13N+5moy2yXs2SOQmfkezYBKbLv
	 BVUxdwsqmgxElVYkb7jPtT2bTk8oez1zH87bVBVsWs+ySMwTWyQObiIgMV81QN/iIA
	 y0Q2FhqGnhjEg==
Received: by x201s (Postfix, from userid 1000)
	id 8ECC5207647; Wed, 08 May 2024 14:34:06 +0000 (UTC)
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
Subject: [PATCH net-next v2 08/14] net: qede: use extack in qede_flow_parse_udp_v6()
Date: Wed,  8 May 2024 14:33:56 +0000
Message-ID: <20240508143404.95901-9-ast@fiberby.net>
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

Convert qede_flow_parse_udp_v6() to take extack,
and drop the edev argument.

Pass extack in call to qede_flow_parse_v6_common().

In call to qede_flow_parse_udp_v6(), use NULL as extack
for now, until a subsequent patch makes extack available.

Only compile tested.

Signed-off-by: Asbjørn Sloth Tønnesen <ast@fiberby.net>
---
 drivers/net/ethernet/qlogic/qede/qede_filter.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/qlogic/qede/qede_filter.c b/drivers/net/ethernet/qlogic/qede/qede_filter.c
index 9fd08ee252ae..abeb873f58f3 100644
--- a/drivers/net/ethernet/qlogic/qede/qede_filter.c
+++ b/drivers/net/ethernet/qlogic/qede/qede_filter.c
@@ -1806,13 +1806,13 @@ qede_flow_parse_tcp_v4(struct flow_rule *rule, struct qede_arfs_tuple *tuple,
 }
 
 static int
-qede_flow_parse_udp_v6(struct qede_dev *edev, struct flow_rule *rule,
-		     struct qede_arfs_tuple *tuple)
+qede_flow_parse_udp_v6(struct flow_rule *rule, struct qede_arfs_tuple *tuple,
+		       struct netlink_ext_ack *extack)
 {
 	tuple->ip_proto = IPPROTO_UDP;
 	tuple->eth_proto = htons(ETH_P_IPV6);
 
-	return qede_flow_parse_v6_common(rule, tuple, NULL);
+	return qede_flow_parse_v6_common(rule, tuple, extack);
 }
 
 static int
@@ -1866,7 +1866,7 @@ qede_parse_flow_attr(struct qede_dev *edev, __be16 proto,
 	else if (ip_proto == IPPROTO_UDP && proto == htons(ETH_P_IP))
 		rc = qede_flow_parse_udp_v4(edev, rule, tuple);
 	else if (ip_proto == IPPROTO_UDP && proto == htons(ETH_P_IPV6))
-		rc = qede_flow_parse_udp_v6(edev, rule, tuple);
+		rc = qede_flow_parse_udp_v6(rule, tuple, NULL);
 	else
 		DP_NOTICE(edev, "Invalid protocol request\n");
 
-- 
2.43.0


