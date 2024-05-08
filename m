Return-Path: <netdev+bounces-94623-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 75CAC8C001E
	for <lists+netdev@lfdr.de>; Wed,  8 May 2024 16:35:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A746C1C23432
	for <lists+netdev@lfdr.de>; Wed,  8 May 2024 14:35:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0C8E127E28;
	Wed,  8 May 2024 14:34:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b="L7f2szut"
X-Original-To: netdev@vger.kernel.org
Received: from mail1.fiberby.net (mail1.fiberby.net [193.104.135.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1E9885642;
	Wed,  8 May 2024 14:34:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.104.135.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715178879; cv=none; b=h6FakU3Qt9+h73g0DBBCp9tywQOV1ua7J62e9evAjrAsFEgubmLP9eZftvoR5xh79b+a4WCSmmp8/n9u1/fVnjTvoKDr6ukxG/IGHXX/ig3ykhS57wHKLiew7gr+uAwrBJaC0T16vtyaMWBifjE8JltX4mdGPhn1b0C0T+fcUN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715178879; c=relaxed/simple;
	bh=JtYb2sSoIpGyGZLEbk84W4BT0EJDsxPXBsQ4i3aaf5I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QvE6SVwE6cYWMP09Gr85hdqSW8KJvtyYiwDN1fO8PAmHIHxs0ayfqypGsdAG5tpk4RPOazRZDWWwvK4ia2PZd0nuNP09Q2vcSfQD91V1LtLB9LMvlaoL453qA5UcAfi3+ijwHisUjvCH4ZSvGsVu4FjtEIf9JxhFWczMRbrUnpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net; spf=pass smtp.mailfrom=fiberby.net; dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b=L7f2szut; arc=none smtp.client-ip=193.104.135.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fiberby.net
Received: from x201s (193-104-135-243.ip4.fiberby.net [193.104.135.243])
	by mail1.fiberby.net (Postfix) with ESMTPSA id 8E58B600B4;
	Wed,  8 May 2024 14:34:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fiberby.net;
	s=202008; t=1715178867;
	bh=JtYb2sSoIpGyGZLEbk84W4BT0EJDsxPXBsQ4i3aaf5I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=L7f2szutXPHy9lMTbLSdaRtSK+L5SjyUtuUGAG/PpbF24vDbsdAbRxEoKLdcY+Ioc
	 hU6ekkWNbbo3GwB4W5hipPADAOAKUUgQvI0OpTn4e5U0F9pt+Ms5hg10ZwbIXOmo90
	 uE+BkCQSQ9SbUn6ieFhbyvtiImyH1AWOts8JqxaxqRFfbvOuwnZ6oU3nGO7tCjcbTA
	 6fJOgjFktW/T4GQZyASGn2vagy89DtF28p+I76HllIBWqDxcskMieNC4zcxdnd3N9g
	 cScB7rl5fSi0/8o3C22YvEF43MLeqfFPU1TuWKkWasH32J1x9AJvN24hSy8a3aVak2
	 JiYH292a38cYA==
Received: by x201s (Postfix, from userid 1000)
	id 30011203798; Wed, 08 May 2024 14:34:05 +0000 (UTC)
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
Subject: [PATCH net-next v2 01/14] net: qede: use extack in qede_flow_parse_ports()
Date: Wed,  8 May 2024 14:33:49 +0000
Message-ID: <20240508143404.95901-2-ast@fiberby.net>
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

Convert qede_flow_parse_ports to use extack,
and drop the edev argument.

Convert DP_NOTICE call to use NL_SET_ERR_MSG_MOD instead.

In calls to qede_flow_parse_ports(), use NULL as extack
for now, until a subsequent patch makes extack available.

Only compile tested.

Signed-off-by: Asbjørn Sloth Tønnesen <ast@fiberby.net>
---
 drivers/net/ethernet/qlogic/qede/qede_filter.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/qlogic/qede/qede_filter.c b/drivers/net/ethernet/qlogic/qede/qede_filter.c
index ded48523c383..600b7dc7ad56 100644
--- a/drivers/net/ethernet/qlogic/qede/qede_filter.c
+++ b/drivers/net/ethernet/qlogic/qede/qede_filter.c
@@ -1700,8 +1700,8 @@ static int qede_parse_actions(struct qede_dev *edev,
 }
 
 static int
-qede_flow_parse_ports(struct qede_dev *edev, struct flow_rule *rule,
-		      struct qede_arfs_tuple *t)
+qede_flow_parse_ports(struct flow_rule *rule, struct qede_arfs_tuple *t,
+		      struct netlink_ext_ack *extack)
 {
 	if (flow_rule_match_key(rule, FLOW_DISSECTOR_KEY_PORTS)) {
 		struct flow_match_ports match;
@@ -1709,7 +1709,8 @@ qede_flow_parse_ports(struct qede_dev *edev, struct flow_rule *rule,
 		flow_rule_match_ports(rule, &match);
 		if ((match.key->src && match.mask->src != htons(U16_MAX)) ||
 		    (match.key->dst && match.mask->dst != htons(U16_MAX))) {
-			DP_NOTICE(edev, "Do not support ports masks\n");
+			NL_SET_ERR_MSG_MOD(extack,
+					   "Do not support ports masks");
 			return -EINVAL;
 		}
 
@@ -1747,7 +1748,7 @@ qede_flow_parse_v6_common(struct qede_dev *edev, struct flow_rule *rule,
 		memcpy(&t->dst_ipv6, &match.key->dst, sizeof(addr));
 	}
 
-	err = qede_flow_parse_ports(edev, rule, t);
+	err = qede_flow_parse_ports(rule, t, NULL);
 	if (err)
 		return err;
 
@@ -1774,7 +1775,7 @@ qede_flow_parse_v4_common(struct qede_dev *edev, struct flow_rule *rule,
 		t->dst_ipv4 = match.key->dst;
 	}
 
-	err = qede_flow_parse_ports(edev, rule, t);
+	err = qede_flow_parse_ports(rule, t, NULL);
 	if (err)
 		return err;
 
-- 
2.43.0


