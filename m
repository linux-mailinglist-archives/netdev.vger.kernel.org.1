Return-Path: <netdev+bounces-94625-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CB678C0022
	for <lists+netdev@lfdr.de>; Wed,  8 May 2024 16:36:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C6A2D1F26FA1
	for <lists+netdev@lfdr.de>; Wed,  8 May 2024 14:35:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3B3A12A16C;
	Wed,  8 May 2024 14:34:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b="FQbkDhx3"
X-Original-To: netdev@vger.kernel.org
Received: from mail1.fiberby.net (mail1.fiberby.net [193.104.135.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84DC98625F;
	Wed,  8 May 2024 14:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.104.135.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715178880; cv=none; b=JFq7HalzSs71lnpsbKAZn57He3/uzxN5DKhqrSz16/5iLU7OYqgPFbODCDy0PZiEvFHiGrwX9YHI6K9kHh3jMi0Xo+fCWbTthRpdWLsOPggbl+Lu5qiV+Wo78s6jHBOsdI8vpqPr/qYAOAWNaIwJtiUEM0fNuvps06sIHt2jMDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715178880; c=relaxed/simple;
	bh=3Mx59MjfqLat4qcwGUo/G75JG9Raj6N8SRjjACLfc00=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dqLXmj4LNfRat3vvdhtW76oV5KiqmCxRaTd5hXXi4ob8zKgIPcXOaODsRh1vwm72AKlyXNmDAhk+Eyl1knYOhgM32lqeVwfALm3sfYa+tT4eeoPXuP8Ayw7b10RVA7irYhl2WLvDML+HoUGnqPFNNimPq5TGDkuYY19c881bSFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net; spf=pass smtp.mailfrom=fiberby.net; dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b=FQbkDhx3; arc=none smtp.client-ip=193.104.135.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fiberby.net
Received: from x201s (193-104-135-243.ip4.fiberby.net [193.104.135.243])
	by mail1.fiberby.net (Postfix) with ESMTPSA id 9E3AE600ED;
	Wed,  8 May 2024 14:34:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fiberby.net;
	s=202008; t=1715178869;
	bh=3Mx59MjfqLat4qcwGUo/G75JG9Raj6N8SRjjACLfc00=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FQbkDhx3y/oev0eWrSUECC0qkLlUYqZb5QMDUoyVz22X4HoCBw2rl0UpWWEMiox40
	 t4rTpvMwfUAR7paYQvd6SB4TCeeCkQDKzKVSNhvtdj2OBuSq5grCtagtZzXBoy9cOC
	 6zd4JqkpVuWdkdMuzJSHxJKRh9gqdZkrNDxJDW4wMkNXMXNHx68ZB9nVqC5+QELZ0E
	 94HrWox0XrVolIVHRmPU7ielw4fEa8iUZ/Nl5yLDq58BkWWWghWSedGP7P8jXzW9PG
	 ATXToygNTfCFTtOhRd+74BYjwWvEHjNzD3xeshCMCSrPknTF+dvmaBrvDyrD0qU4vA
	 871f1O9VsFDJw==
Received: by x201s (Postfix, from userid 1000)
	id 317A6204FCD; Wed, 08 May 2024 14:34:06 +0000 (UTC)
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
Subject: [PATCH net-next v2 06/14] net: qede: use extack in qede_flow_parse_tcp_v6()
Date: Wed,  8 May 2024 14:33:54 +0000
Message-ID: <20240508143404.95901-7-ast@fiberby.net>
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

Convert qede_flow_parse_tcp_v6() to take extack,
and drop the edev argument.

Pass extack in call to qede_flow_parse_v6_common().

In call to qede_flow_parse_tcp_v6(), use NULL as extack
for now, until a subsequent patch makes extack available.

Only compile tested.

Signed-off-by: Asbjørn Sloth Tønnesen <ast@fiberby.net>
---
 drivers/net/ethernet/qlogic/qede/qede_filter.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/qlogic/qede/qede_filter.c b/drivers/net/ethernet/qlogic/qede/qede_filter.c
index 28e4d54dbca1..ddf1d6b0fc83 100644
--- a/drivers/net/ethernet/qlogic/qede/qede_filter.c
+++ b/drivers/net/ethernet/qlogic/qede/qede_filter.c
@@ -1786,13 +1786,13 @@ qede_flow_parse_v4_common(struct flow_rule *rule,
 }
 
 static int
-qede_flow_parse_tcp_v6(struct qede_dev *edev, struct flow_rule *rule,
-		     struct qede_arfs_tuple *tuple)
+qede_flow_parse_tcp_v6(struct flow_rule *rule, struct qede_arfs_tuple *tuple,
+		       struct netlink_ext_ack *extack)
 {
 	tuple->ip_proto = IPPROTO_TCP;
 	tuple->eth_proto = htons(ETH_P_IPV6);
 
-	return qede_flow_parse_v6_common(rule, tuple, NULL);
+	return qede_flow_parse_v6_common(rule, tuple, extack);
 }
 
 static int
@@ -1862,7 +1862,7 @@ qede_parse_flow_attr(struct qede_dev *edev, __be16 proto,
 	if (ip_proto == IPPROTO_TCP && proto == htons(ETH_P_IP))
 		rc = qede_flow_parse_tcp_v4(edev, rule, tuple);
 	else if (ip_proto == IPPROTO_TCP && proto == htons(ETH_P_IPV6))
-		rc = qede_flow_parse_tcp_v6(edev, rule, tuple);
+		rc = qede_flow_parse_tcp_v6(rule, tuple, NULL);
 	else if (ip_proto == IPPROTO_UDP && proto == htons(ETH_P_IP))
 		rc = qede_flow_parse_udp_v4(edev, rule, tuple);
 	else if (ip_proto == IPPROTO_UDP && proto == htons(ETH_P_IPV6))
-- 
2.43.0


