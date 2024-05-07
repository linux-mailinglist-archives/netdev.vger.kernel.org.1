Return-Path: <netdev+bounces-94035-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D186A8BDFFF
	for <lists+netdev@lfdr.de>; Tue,  7 May 2024 12:45:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0ECD31C234F1
	for <lists+netdev@lfdr.de>; Tue,  7 May 2024 10:45:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70D87152168;
	Tue,  7 May 2024 10:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b="SnbIGSu2"
X-Original-To: netdev@vger.kernel.org
Received: from mail1.fiberby.net (mail1.fiberby.net [193.104.135.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BDB114F100;
	Tue,  7 May 2024 10:44:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.104.135.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715078687; cv=none; b=BZdE17I4AYwFS2uOIjlVdjaes8ML9nMQu+8XOYjbDu6DRH/zrsBq5VPuV8mgL0Gm2cW4kc+ESlz9nn9aoPQLngkYixy8+rhfmC3Ra6p4BM5eRCODdvGbkGFgkb+AH8hwHir2DPVarJKLFDvjTuVDGCqiCBS7s0ig7WvCOGnUW+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715078687; c=relaxed/simple;
	bh=ZztlPtdm5BgjIFka9qvM8fk/AJlWEYDvLqfkiSCDozU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mPn1/1tgq2vY3HRf1+XhDfO2yvWjYApfJbcCZ9F8KQ8ulFE1xEcyrMSvj1cDcfbk6aBcSHC2UHyBs8vGa/V878xf+kIyWleLzYvC5NKhCvjPH6R0oTVroR7mfLu500S1Ec1bzT8LO3nZoOkEnkgEdLrolL7GD82O0AM0W0unzck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net; spf=pass smtp.mailfrom=fiberby.net; dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b=SnbIGSu2; arc=none smtp.client-ip=193.104.135.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fiberby.net
Received: from x201s (193-104-135-243.ip4.fiberby.net [193.104.135.243])
	by mail1.fiberby.net (Postfix) with ESMTPSA id 1DE05600A9;
	Tue,  7 May 2024 10:44:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fiberby.net;
	s=202008; t=1715078675;
	bh=ZztlPtdm5BgjIFka9qvM8fk/AJlWEYDvLqfkiSCDozU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SnbIGSu2TJvGuW7/HvmGAe3wMVkDnQNVDZ12CbxnDNq1mY3c5oMzT+bWFnenFWLVs
	 cR9qG5LQlnXRtLBnoeU+ZCmdJl9eGVaKdxEHYDwfhmYK3BGUa9VMtbCmrFLx8HGcnJ
	 PYIslkvrl3W7RRuZUQjJwUeBDBNlMJIvPzJiuScl+tVkrGdnRSkn+TggAuwpXoX1l1
	 qYIn6lT73ojljmLhOpOwnqLpgEUj1vZSTVgxdNoZ5dYumKnEo9Q0lFGZcvWsPD6daM
	 lJXITe1JzneXTj2kXaYsVoXZ6FYpL1uE9N38CTJnjeLkwLaryk1SPQvg/kScG7Fp4y
	 NqmuXXFExisFg==
Received: by x201s (Postfix, from userid 1000)
	id 8C122203D02; Tue, 07 May 2024 10:44:24 +0000 (UTC)
From: =?UTF-8?q?Asbj=C3=B8rn=20Sloth=20T=C3=B8nnesen?= <ast@fiberby.net>
To: netdev@vger.kernel.org
Cc: =?UTF-8?q?Asbj=C3=B8rn=20Sloth=20T=C3=B8nnesen?= <ast@fiberby.net>,
	linux-kernel@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Manish Chopra <manishc@marvell.com>
Subject: [PATCH net-next 11/14] net: qede: use extack in qede_parse_flow_attr()
Date: Tue,  7 May 2024 10:44:12 +0000
Message-ID: <20240507104421.1628139-12-ast@fiberby.net>
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
 .../net/ethernet/qlogic/qede/qede_filter.c    | 23 ++++++++++---------
 1 file changed, 12 insertions(+), 11 deletions(-)

diff --git a/drivers/net/ethernet/qlogic/qede/qede_filter.c b/drivers/net/ethernet/qlogic/qede/qede_filter.c
index 5b353a160d15..8734c864f324 100644
--- a/drivers/net/ethernet/qlogic/qede/qede_filter.c
+++ b/drivers/net/ethernet/qlogic/qede/qede_filter.c
@@ -1826,7 +1826,7 @@ qede_flow_parse_udp_v4(struct netlink_ext_ack *extack, struct flow_rule *rule,
 }
 
 static int
-qede_parse_flow_attr(struct qede_dev *edev, __be16 proto,
+qede_parse_flow_attr(struct netlink_ext_ack *extack, __be16 proto,
 		     struct flow_rule *rule, struct qede_arfs_tuple *tuple)
 {
 	struct flow_dissector *dissector = rule->match.dissector;
@@ -1841,14 +1841,15 @@ qede_parse_flow_attr(struct qede_dev *edev, __be16 proto,
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
 
@@ -1860,15 +1861,15 @@ qede_parse_flow_attr(struct qede_dev *edev, __be16 proto,
 	}
 
 	if (ip_proto == IPPROTO_TCP && proto == htons(ETH_P_IP))
-		rc = qede_flow_parse_tcp_v4(NULL, rule, tuple);
+		rc = qede_flow_parse_tcp_v4(extack, rule, tuple);
 	else if (ip_proto == IPPROTO_TCP && proto == htons(ETH_P_IPV6))
-		rc = qede_flow_parse_tcp_v6(NULL, rule, tuple);
+		rc = qede_flow_parse_tcp_v6(extack, rule, tuple);
 	else if (ip_proto == IPPROTO_UDP && proto == htons(ETH_P_IP))
-		rc = qede_flow_parse_udp_v4(NULL, rule, tuple);
+		rc = qede_flow_parse_udp_v4(extack, rule, tuple);
 	else if (ip_proto == IPPROTO_UDP && proto == htons(ETH_P_IPV6))
-		rc = qede_flow_parse_udp_v6(NULL, rule, tuple);
+		rc = qede_flow_parse_udp_v6(extack, rule, tuple);
 	else
-		DP_NOTICE(edev, "Invalid protocol request\n");
+		NL_SET_ERR_MSG_MOD(extack, "Invalid protocol request");
 
 	return rc;
 }
@@ -1889,7 +1890,7 @@ int qede_add_tc_flower_fltr(struct qede_dev *edev, __be16 proto,
 	}
 
 	/* parse flower attribute and prepare filter */
-	rc = qede_parse_flow_attr(edev, proto, f->rule, &t);
+	rc = qede_parse_flow_attr(extack, proto, f->rule, &t);
 	if (rc)
 		goto unlock;
 
@@ -2015,7 +2016,7 @@ static int qede_flow_spec_to_rule(struct qede_dev *edev,
 	if (IS_ERR(flow))
 		return PTR_ERR(flow);
 
-	err = qede_parse_flow_attr(edev, proto, flow->rule, t);
+	err = qede_parse_flow_attr(NULL, proto, flow->rule, t);
 	if (err)
 		goto err_out;
 
-- 
2.43.0


