Return-Path: <netdev+bounces-94034-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A0818BDFFC
	for <lists+netdev@lfdr.de>; Tue,  7 May 2024 12:45:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4B6711C22353
	for <lists+netdev@lfdr.de>; Tue,  7 May 2024 10:45:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 370631514E0;
	Tue,  7 May 2024 10:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b="D7eB5DRe"
X-Original-To: netdev@vger.kernel.org
Received: from mail1.fiberby.net (mail1.fiberby.net [193.104.135.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA32BAD5D;
	Tue,  7 May 2024 10:44:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.104.135.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715078687; cv=none; b=GWep9ep/uq30zLWz0Phq13cSVFaQWTlBnHY+j06gqVOZE1HJqM78CibH9S5sKiGnsFhoM4TMqU2kxjSIZHDd78l/8CP3RNIE2l3kFeoLQVwHVoZbLxPcOr6mrlsrvJiyosWO01azCChW66rxPhD+5VjPvP2AGTCJYd6B854c1sk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715078687; c=relaxed/simple;
	bh=EpF0Wn59BtuNgD/0/x/C+iR8eVWPwcN13ZAKr2kNM2M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lAasTuObJTN5FjgD42fDu9HeZyMOZeaBvU1DN+nnHoh1WPcm9mtwPHIb5Ri7ImwCYQbR0OEF1aImESgrImfmOh/3K0sLskWuFZs9+eJg6oRLf9NsRSiQ7QY1d1KoE+PGcEp7ip4ieMvLVk4fE9YQU+FMfRTCD+4nK3jsUJa+eP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net; spf=pass smtp.mailfrom=fiberby.net; dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b=D7eB5DRe; arc=none smtp.client-ip=193.104.135.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fiberby.net
Received: from x201s (193-104-135-243.ip4.fiberby.net [193.104.135.243])
	by mail1.fiberby.net (Postfix) with ESMTPSA id 3D014600DC;
	Tue,  7 May 2024 10:44:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fiberby.net;
	s=202008; t=1715078675;
	bh=EpF0Wn59BtuNgD/0/x/C+iR8eVWPwcN13ZAKr2kNM2M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=D7eB5DReVktLdgRHC9DMQ2aoVgHUk+Xq27OYF/abTr/kApJVxwJQ3MrhzWL7urCPD
	 x5HZWtnS7BCDS5f+YKX7gUu46MHBd/b8mMT8lmkwq7SbwICQOMHgtBUQsjM58aqjaR
	 8k9LZCQjGjwXab+klo0VjOqt5fvi2JTZDQ7VFnX1vls0Dj29XbAlGZXjonAUZevmPX
	 qR1Gvkak9/lMgzNROqgW8QiXY2QzogXtsxijb0ShwzEwYdkegvPFxnh65L2YJ+jAVE
	 gQe37Yl4uAGAoKzB+MFOtGUh2UHWZYTKllZhjPYsWD4rT0e/UB4KUq11uiKqIMslml
	 MGbBirh062OMA==
Received: by x201s (Postfix, from userid 1000)
	id 43598203663; Tue, 07 May 2024 10:44:23 +0000 (UTC)
From: =?UTF-8?q?Asbj=C3=B8rn=20Sloth=20T=C3=B8nnesen?= <ast@fiberby.net>
To: netdev@vger.kernel.org
Cc: =?UTF-8?q?Asbj=C3=B8rn=20Sloth=20T=C3=B8nnesen?= <ast@fiberby.net>,
	linux-kernel@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Manish Chopra <manishc@marvell.com>
Subject: [PATCH net-next 04/14] net: qede: use extack in qede_flow_parse_v6_common()
Date: Tue,  7 May 2024 10:44:05 +0000
Message-ID: <20240507104421.1628139-5-ast@fiberby.net>
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

Convert qede_flow_parse_v6_common() to take extack,
and drop the edev argument.

Convert DP_NOTICE call to use NL_SET_ERR_MSG_MOD instead.

Pass extack in calls to qede_flow_parse_ports() and
qede_set_v6_tuple_to_profile().

In calls to qede_flow_parse_v6_common(), use NULL as extack
for now, until a subsequent patch makes extack available.

Only compile tested.

Signed-off-by: Asbjørn Sloth Tønnesen <ast@fiberby.net>
---
 drivers/net/ethernet/qlogic/qede/qede_filter.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/qlogic/qede/qede_filter.c b/drivers/net/ethernet/qlogic/qede/qede_filter.c
index 0d429f5b9c57..d151b64a0436 100644
--- a/drivers/net/ethernet/qlogic/qede/qede_filter.c
+++ b/drivers/net/ethernet/qlogic/qede/qede_filter.c
@@ -1722,7 +1722,8 @@ qede_flow_parse_ports(struct netlink_ext_ack *extack, struct flow_rule *rule,
 }
 
 static int
-qede_flow_parse_v6_common(struct qede_dev *edev, struct flow_rule *rule,
+qede_flow_parse_v6_common(struct netlink_ext_ack *extack,
+			  struct flow_rule *rule,
 			  struct qede_arfs_tuple *t)
 {
 	struct in6_addr zero_addr, addr;
@@ -1739,8 +1740,8 @@ qede_flow_parse_v6_common(struct qede_dev *edev, struct flow_rule *rule,
 		     memcmp(&match.mask->src, &addr, sizeof(addr))) ||
 		    (memcmp(&match.key->dst, &zero_addr, sizeof(addr)) &&
 		     memcmp(&match.mask->dst, &addr, sizeof(addr)))) {
-			DP_NOTICE(edev,
-				  "Do not support IPv6 address prefix/mask\n");
+			NL_SET_ERR_MSG_MOD(extack,
+					   "Do not support IPv6 address prefix/mask");
 			return -EINVAL;
 		}
 
@@ -1748,11 +1749,11 @@ qede_flow_parse_v6_common(struct qede_dev *edev, struct flow_rule *rule,
 		memcpy(&t->dst_ipv6, &match.key->dst, sizeof(addr));
 	}
 
-	err = qede_flow_parse_ports(NULL, rule, t);
+	err = qede_flow_parse_ports(extack, rule, t);
 	if (err)
 		return err;
 
-	return qede_set_v6_tuple_to_profile(NULL, t, &zero_addr);
+	return qede_set_v6_tuple_to_profile(extack, t, &zero_addr);
 }
 
 static int
@@ -1789,7 +1790,7 @@ qede_flow_parse_tcp_v6(struct qede_dev *edev, struct flow_rule *rule,
 	tuple->ip_proto = IPPROTO_TCP;
 	tuple->eth_proto = htons(ETH_P_IPV6);
 
-	return qede_flow_parse_v6_common(edev, rule, tuple);
+	return qede_flow_parse_v6_common(NULL, rule, tuple);
 }
 
 static int
@@ -1809,7 +1810,7 @@ qede_flow_parse_udp_v6(struct qede_dev *edev, struct flow_rule *rule,
 	tuple->ip_proto = IPPROTO_UDP;
 	tuple->eth_proto = htons(ETH_P_IPV6);
 
-	return qede_flow_parse_v6_common(edev, rule, tuple);
+	return qede_flow_parse_v6_common(NULL, rule, tuple);
 }
 
 static int
-- 
2.43.0


