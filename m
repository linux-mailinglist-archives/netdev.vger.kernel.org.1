Return-Path: <netdev+bounces-94624-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AA0638C0020
	for <lists+netdev@lfdr.de>; Wed,  8 May 2024 16:35:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 52E2CB240E2
	for <lists+netdev@lfdr.de>; Wed,  8 May 2024 14:35:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B44EA127E2B;
	Wed,  8 May 2024 14:34:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b="aeUe3Mj+"
X-Original-To: netdev@vger.kernel.org
Received: from mail1.fiberby.net (mail1.fiberby.net [193.104.135.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9712D86255;
	Wed,  8 May 2024 14:34:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.104.135.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715178879; cv=none; b=ZhRRrfPDgbHwQZdHRceyU+sANsotld1+EbX9MllrzgVhzzOM4n/jsHiWR84Ol6eEN6QZ0v2+U731E78NIj6/EsRA/pE01rWpDqBKFj5mHo9GgM+VbXsfFrNL5tcw6YRwmvn7mejR5hwuieP9232K27NwAS6TQCoqzKZKpyUcD7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715178879; c=relaxed/simple;
	bh=ZVoVECNiymr5am54JK0hcDsvILL7gVMo7nWXFwZf8nQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=N5DUxHcUFUClau3RVArxuz1O2Qgo7UKiASESfVBF6kRp8pjY1dk18o5Y3Y+szulzUg9CYtiHqPIyAN6hZBPOJgLjKJdGXvwaU/WmKJ4wMZbY0leYrnajLlkLE5QsTlAidckIlbDt1oj543y/MP5Jzv2hXefXPlVwsYVtfW1jRZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net; spf=pass smtp.mailfrom=fiberby.net; dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b=aeUe3Mj+; arc=none smtp.client-ip=193.104.135.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fiberby.net
Received: from x201s (193-104-135-243.ip4.fiberby.net [193.104.135.243])
	by mail1.fiberby.net (Postfix) with ESMTPSA id 92477600C8;
	Wed,  8 May 2024 14:34:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fiberby.net;
	s=202008; t=1715178869;
	bh=ZVoVECNiymr5am54JK0hcDsvILL7gVMo7nWXFwZf8nQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=aeUe3Mj+rWMmjgCH3vJx6tGE8cSWbYqvTJi1Bdnw8HBhfWdWS9KWeWWlzTzT9/9UE
	 OU/K0XRgeywbasD7eoxKyYGBPXl8v/gOYXaK9fQFJ5M0dmwQoZx4SmVWRgf3XbfL9n
	 oOUBn4XcrqfR3TYooqqSA+4ktKLX4uGvdjeN0tbdcgW4i4Y6U4jQcGzFx4vGFmChJ6
	 z6ZOizXifnUgYbfXFpV1FqdxEeuu8zyWwwXghiMxwKzyR8NDPiIy7ROgk5uZQCyyFN
	 yo8CoFsiBfuCgrnpv4Rlu/MxFsCmIjSrMbr8vC86uPyxJaJoUpC4XQH9r1ETqa5pkq
	 4RLLxbROQR+sA==
Received: by x201s (Postfix, from userid 1000)
	id 1B8E42081D5; Wed, 08 May 2024 14:34:07 +0000 (UTC)
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
Subject: [PATCH net-next v2 11/14] net: qede: use extack in qede_parse_flow_attr()
Date: Wed,  8 May 2024 14:33:59 +0000
Message-ID: <20240508143404.95901-12-ast@fiberby.net>
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

Convert qede_parse_flow_attr() to take extack,
and drop the edev argument.

Convert DP_NOTICE calls to use NL_SET_ERR_MSG_* instead.

Pass extack in calls to qede_flow_parse_{tcp,udp}_v{4,6}().

In calls to qede_parse_flow_attr(), if extack is
unavailable, then use NULL for now, until a
subsequent patch makes extack available.

Only compile tested.

Signed-off-by: Asbjørn Sloth Tønnesen <ast@fiberby.net>
---
 .../net/ethernet/qlogic/qede/qede_filter.c    | 26 ++++++++++---------
 1 file changed, 14 insertions(+), 12 deletions(-)

diff --git a/drivers/net/ethernet/qlogic/qede/qede_filter.c b/drivers/net/ethernet/qlogic/qede/qede_filter.c
index 09ffcb86924b..8c1c15b73125 100644
--- a/drivers/net/ethernet/qlogic/qede/qede_filter.c
+++ b/drivers/net/ethernet/qlogic/qede/qede_filter.c
@@ -1826,8 +1826,9 @@ qede_flow_parse_udp_v4(struct flow_rule *rule, struct qede_arfs_tuple *tuple,
 }
 
 static int
-qede_parse_flow_attr(struct qede_dev *edev, __be16 proto,
-		     struct flow_rule *rule, struct qede_arfs_tuple *tuple)
+qede_parse_flow_attr(__be16 proto, struct flow_rule *rule,
+		     struct qede_arfs_tuple *tuple,
+		     struct netlink_ext_ack *extack)
 {
 	struct flow_dissector *dissector = rule->match.dissector;
 	int rc = -EINVAL;
@@ -1841,14 +1842,15 @@ qede_parse_flow_attr(struct qede_dev *edev, __be16 proto,
 	      BIT_ULL(FLOW_DISSECTOR_KEY_BASIC) |
 	      BIT_ULL(FLOW_DISSECTOR_KEY_IPV6_ADDRS) |
 	      BIT_ULL(FLOW_DISSECTOR_KEY_PORTS))) {
-		DP_NOTICE(edev, "Unsupported key set:0x%llx\n",
-			  dissector->used_keys);
+		NL_SET_ERR_MSG_FMT_MOD(extack, "Unsupported key used: 0x%llx",
+				       dissector->used_keys);
 		return -EOPNOTSUPP;
 	}
 
 	if (proto != htons(ETH_P_IP) &&
 	    proto != htons(ETH_P_IPV6)) {
-		DP_NOTICE(edev, "Unsupported proto=0x%x\n", proto);
+		NL_SET_ERR_MSG_FMT_MOD(extack, "Unsupported proto=0x%x",
+				       proto);
 		return -EPROTONOSUPPORT;
 	}
 
@@ -1860,15 +1862,15 @@ qede_parse_flow_attr(struct qede_dev *edev, __be16 proto,
 	}
 
 	if (ip_proto == IPPROTO_TCP && proto == htons(ETH_P_IP))
-		rc = qede_flow_parse_tcp_v4(rule, tuple, NULL);
+		rc = qede_flow_parse_tcp_v4(rule, tuple, extack);
 	else if (ip_proto == IPPROTO_TCP && proto == htons(ETH_P_IPV6))
-		rc = qede_flow_parse_tcp_v6(rule, tuple, NULL);
+		rc = qede_flow_parse_tcp_v6(rule, tuple, extack);
 	else if (ip_proto == IPPROTO_UDP && proto == htons(ETH_P_IP))
-		rc = qede_flow_parse_udp_v4(rule, tuple, NULL);
+		rc = qede_flow_parse_udp_v4(rule, tuple, extack);
 	else if (ip_proto == IPPROTO_UDP && proto == htons(ETH_P_IPV6))
-		rc = qede_flow_parse_udp_v6(rule, tuple, NULL);
+		rc = qede_flow_parse_udp_v6(rule, tuple, extack);
 	else
-		DP_NOTICE(edev, "Invalid protocol request\n");
+		NL_SET_ERR_MSG_MOD(extack, "Invalid protocol request");
 
 	return rc;
 }
@@ -1889,7 +1891,7 @@ int qede_add_tc_flower_fltr(struct qede_dev *edev, __be16 proto,
 	}
 
 	/* parse flower attribute and prepare filter */
-	rc = qede_parse_flow_attr(edev, proto, f->rule, &t);
+	rc = qede_parse_flow_attr(proto, f->rule, &t, extack);
 	if (rc)
 		goto unlock;
 
@@ -2015,7 +2017,7 @@ static int qede_flow_spec_to_rule(struct qede_dev *edev,
 	if (IS_ERR(flow))
 		return PTR_ERR(flow);
 
-	err = qede_parse_flow_attr(edev, proto, flow->rule, t);
+	err = qede_parse_flow_attr(proto, flow->rule, t, NULL);
 	if (err)
 		goto err_out;
 
-- 
2.43.0


