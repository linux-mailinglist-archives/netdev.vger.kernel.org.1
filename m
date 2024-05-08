Return-Path: <netdev+bounces-94631-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 56DEE8C004C
	for <lists+netdev@lfdr.de>; Wed,  8 May 2024 16:43:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EB89BB269DB
	for <lists+netdev@lfdr.de>; Wed,  8 May 2024 14:43:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65BAF86628;
	Wed,  8 May 2024 14:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b="nbz75mml"
X-Original-To: netdev@vger.kernel.org
Received: from mail1.fiberby.net (mail1.fiberby.net [193.104.135.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EAEF8625D;
	Wed,  8 May 2024 14:43:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.104.135.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715179393; cv=none; b=uiWnnb0ukATEXgZ+VhaJ9nMEnbHUpjzW5bqAeG8drxRZMwOxWqEpaWsDH29An5X4vreJyaagxG2+lUezCQ2tUUBfBaHW/k+V7ikf2STd+ViUyWLnGhEDubkl6eKhtUkZvSg01xelzTXZ4NGqf0bGUSnuFQ5rBaoluQDWH4vr5CI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715179393; c=relaxed/simple;
	bh=kSyTfrfXcWri7MyzitgNTa72sX8B8JLhvaUFNBJ+jQs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=D3XToruNN9eH2oi++vDkIpuw1qqj4509NHhQa+M4hitNR/4pmpOzgMDrH8eqy7Fu0Vys4+ftP7maOONE/a1p0yGnCi9j84rnZPV83/0o+o7ptJxdUsEtIiVIpLURX4LzaDWz/QHFaDEKWnd1WA58UJX9bStVP38rEmkLfVukX28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net; spf=pass smtp.mailfrom=fiberby.net; dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b=nbz75mml; arc=none smtp.client-ip=193.104.135.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fiberby.net
Received: from x201s (193-104-135-243.ip4.fiberby.net [193.104.135.243])
	by mail1.fiberby.net (Postfix) with ESMTPSA id 964F3600B6;
	Wed,  8 May 2024 14:34:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fiberby.net;
	s=202008; t=1715178867;
	bh=kSyTfrfXcWri7MyzitgNTa72sX8B8JLhvaUFNBJ+jQs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nbz75mmlI4cNyt4jH82Dj+4VGBN24aXTr1WBV0cRC7BzbPG2jcFM8wNHFpiLzLWAn
	 RayF/jYBiSR4PkMhrqmfP5Kw+RUN0MkvqXD8/DyEm3aitkVn3PKC4KTTu7bnPA7d2W
	 QfA2ERx2A5qdqUM/xfqOvazqS3zlc+YhO1dfTSDY+BJ8ud9Zw/7FAZVOEKE8JBUkSX
	 8ipRW8goW3orGP0Xppy1Nrcv2BuuSDUXmxf1tka/mRgmXYMpHGnH1C5lYpWol1aNOu
	 x9xqe+3GmbMCRb0CVOek9eu3hNL7SMasPctaRYcDPOzYJpWckiimT+87AItQpaHMMv
	 13VYpHZT3picQ==
Received: by x201s (Postfix, from userid 1000)
	id CD43320472D; Wed, 08 May 2024 14:34:05 +0000 (UTC)
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
Subject: [PATCH net-next v2 04/14] net: qede: use extack in qede_flow_parse_v6_common()
Date: Wed,  8 May 2024 14:33:52 +0000
Message-ID: <20240508143404.95901-5-ast@fiberby.net>
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
 drivers/net/ethernet/qlogic/qede/qede_filter.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/qlogic/qede/qede_filter.c b/drivers/net/ethernet/qlogic/qede/qede_filter.c
index 6f4c4a5d6c77..f5f8bbe8a64c 100644
--- a/drivers/net/ethernet/qlogic/qede/qede_filter.c
+++ b/drivers/net/ethernet/qlogic/qede/qede_filter.c
@@ -1722,8 +1722,9 @@ qede_flow_parse_ports(struct flow_rule *rule, struct qede_arfs_tuple *t,
 }
 
 static int
-qede_flow_parse_v6_common(struct qede_dev *edev, struct flow_rule *rule,
-			  struct qede_arfs_tuple *t)
+qede_flow_parse_v6_common(struct flow_rule *rule,
+			  struct qede_arfs_tuple *t,
+			  struct netlink_ext_ack *extack)
 {
 	struct in6_addr zero_addr, addr;
 	int err;
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
 
-	err = qede_flow_parse_ports(rule, t, NULL);
+	err = qede_flow_parse_ports(rule, t, extack);
 	if (err)
 		return err;
 
-	return qede_set_v6_tuple_to_profile(t, &zero_addr, NULL);
+	return qede_set_v6_tuple_to_profile(t, &zero_addr, extack);
 }
 
 static int
@@ -1789,7 +1790,7 @@ qede_flow_parse_tcp_v6(struct qede_dev *edev, struct flow_rule *rule,
 	tuple->ip_proto = IPPROTO_TCP;
 	tuple->eth_proto = htons(ETH_P_IPV6);
 
-	return qede_flow_parse_v6_common(edev, rule, tuple);
+	return qede_flow_parse_v6_common(rule, tuple, NULL);
 }
 
 static int
@@ -1809,7 +1810,7 @@ qede_flow_parse_udp_v6(struct qede_dev *edev, struct flow_rule *rule,
 	tuple->ip_proto = IPPROTO_UDP;
 	tuple->eth_proto = htons(ETH_P_IPV6);
 
-	return qede_flow_parse_v6_common(edev, rule, tuple);
+	return qede_flow_parse_v6_common(rule, tuple, NULL);
 }
 
 static int
-- 
2.43.0


