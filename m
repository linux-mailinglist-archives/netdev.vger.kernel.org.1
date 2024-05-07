Return-Path: <netdev+bounces-94042-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8012E8BE010
	for <lists+netdev@lfdr.de>; Tue,  7 May 2024 12:47:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 21AF91F2568E
	for <lists+netdev@lfdr.de>; Tue,  7 May 2024 10:47:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70F9E15D5D7;
	Tue,  7 May 2024 10:44:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b="RR1oKyL3"
X-Original-To: netdev@vger.kernel.org
Received: from mail1.fiberby.net (mail1.fiberby.net [193.104.135.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E875015665E;
	Tue,  7 May 2024 10:44:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.104.135.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715078690; cv=none; b=TGkT+OWYsul7BG5QTEoLO0ftgcWH8cjfMFXWBe3vKBFCeljeLl3yG4X4DaJxq/053ikH+sepkF+rjvorg3UF0xdMiqfNSyeoox5cGbb19auaCzoCUgWxBtVbLvndlgHK+TSdyoe8xGrak6/osKpCgZkWgilYEg1wtJ+JSNsoeNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715078690; c=relaxed/simple;
	bh=2aeTb4kDibVlX9ag4RZ1UVYwxrN6jOBKO27gkQzCgRM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TeivseoLiUU2uLNF6h2g3oQS2JiZoLoHxvx0fzxlPmHBMP1RsE2ttKujnINarEnT7QfuNM606A8AMv9oreXh5F3g1az4fSNy2Z30Us4K8l9a3TZcILI6CZraNxu/UECYd4CEYhe9pA0jPj2+LThjRcQMuQldPzKZxURnG0J/44Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net; spf=pass smtp.mailfrom=fiberby.net; dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b=RR1oKyL3; arc=none smtp.client-ip=193.104.135.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fiberby.net
Received: from x201s (193-104-135-243.ip4.fiberby.net [193.104.135.243])
	by mail1.fiberby.net (Postfix) with ESMTPSA id ADA516017A;
	Tue,  7 May 2024 10:44:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fiberby.net;
	s=202008; t=1715078675;
	bh=2aeTb4kDibVlX9ag4RZ1UVYwxrN6jOBKO27gkQzCgRM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RR1oKyL3cL4XmEDIZ5FcfmN0u9rFwMZjXCAjurpU713yZo0KHWwN/9GAmKyXd0kt0
	 kpWqj5vvSdc+idm7KAmfBVr3ECel0Jq6ejcNmR6cSSw2wEeguKxcuejxfWf98tc9Z2
	 4EqaXFO1jkysJT9ixnC8gw77QoN4M8FQ8w2MV8JEU8mmRZgU9saoWWhL8l8rS5a0eR
	 TlhoRKkiEZMxp+Bja+tHtJCVpTBujMhN1PMeQK7wy6SvCakjPcPsRJBfO1evuEVWEa
	 vXs/Nrzsm9G3BWr71SFBcadp3YHJouQy0IdnqkaW02l81qbdZu4GHXbJ7RX5Rh0ZDk
	 X1ZmFWxJRCpzA==
Received: by x201s (Postfix, from userid 1000)
	id 7018F2032CC; Tue, 07 May 2024 10:44:22 +0000 (UTC)
From: =?UTF-8?q?Asbj=C3=B8rn=20Sloth=20T=C3=B8nnesen?= <ast@fiberby.net>
To: netdev@vger.kernel.org
Cc: =?UTF-8?q?Asbj=C3=B8rn=20Sloth=20T=C3=B8nnesen?= <ast@fiberby.net>,
	linux-kernel@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Manish Chopra <manishc@marvell.com>
Subject: [PATCH net-next 01/14] net: qede: use extack in qede_flow_parse_ports()
Date: Tue,  7 May 2024 10:44:02 +0000
Message-ID: <20240507104421.1628139-2-ast@fiberby.net>
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

Convert qede_flow_parse_ports to use extack,
and drop the edev argument.

Convert DP_NOTICE call to use NL_SET_ERR_MSG_MOD instead.

In calls to qede_flow_parse_ports(), use NULL as extack
for now, until a subsequent patch makes extack available.

Only compile tested.

Signed-off-by: Asbjørn Sloth Tønnesen <ast@fiberby.net>
---
 drivers/net/ethernet/qlogic/qede/qede_filter.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/qlogic/qede/qede_filter.c b/drivers/net/ethernet/qlogic/qede/qede_filter.c
index ded48523c383..3995baa2daa6 100644
--- a/drivers/net/ethernet/qlogic/qede/qede_filter.c
+++ b/drivers/net/ethernet/qlogic/qede/qede_filter.c
@@ -1700,7 +1700,7 @@ static int qede_parse_actions(struct qede_dev *edev,
 }
 
 static int
-qede_flow_parse_ports(struct qede_dev *edev, struct flow_rule *rule,
+qede_flow_parse_ports(struct netlink_ext_ack *extack, struct flow_rule *rule,
 		      struct qede_arfs_tuple *t)
 {
 	if (flow_rule_match_key(rule, FLOW_DISSECTOR_KEY_PORTS)) {
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
+	err = qede_flow_parse_ports(NULL, rule, t);
 	if (err)
 		return err;
 
@@ -1774,7 +1775,7 @@ qede_flow_parse_v4_common(struct qede_dev *edev, struct flow_rule *rule,
 		t->dst_ipv4 = match.key->dst;
 	}
 
-	err = qede_flow_parse_ports(edev, rule, t);
+	err = qede_flow_parse_ports(NULL, rule, t);
 	if (err)
 		return err;
 
-- 
2.43.0


