Return-Path: <netdev+bounces-94031-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE7108BDFF9
	for <lists+netdev@lfdr.de>; Tue,  7 May 2024 12:44:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 649D32893C2
	for <lists+netdev@lfdr.de>; Tue,  7 May 2024 10:44:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEEBE14F9EA;
	Tue,  7 May 2024 10:44:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b="BEBSedbW"
X-Original-To: netdev@vger.kernel.org
Received: from mail1.fiberby.net (mail1.fiberby.net [193.104.135.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BD6B14EC7E;
	Tue,  7 May 2024 10:44:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.104.135.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715078686; cv=none; b=X7lVgNybmfCrX8MZAs5/8oVTH4FZoYsD9Fec7dAtIw1WL7bjaRd3375kTqWnxvdcbyrYqf7QqV2x+qjdJPgbSwXjLr2l+Ta9EVrqqdrV6X9E6ctIxOSWuRIvYlhiVXLtIsrT5F/BMSSK/RLFK0cZQlQzMjrCakdU4wGz0pmlLg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715078686; c=relaxed/simple;
	bh=q9BQNm/ihZ/CfwkElHCQ6Teb3l9zBwR1XwqAUbRcuDI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eYmOb95iZwY97bIzzdaYX1tZj5MJW6LPO0oxPLATiUNkbSXnoF46K+E+1WaSOLlMNWXOXIdm7zRZo/YAzGudsx7yWH3qmuTANeVgARfJx/xEw2DxUuMgAuQ1DoaeqI8mzb1EraUuthNI/c+ThtZnfuMtyZ9OzhIuo+c5+529fB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net; spf=pass smtp.mailfrom=fiberby.net; dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b=BEBSedbW; arc=none smtp.client-ip=193.104.135.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fiberby.net
Received: from x201s (193-104-135-243.ip4.fiberby.net [193.104.135.243])
	by mail1.fiberby.net (Postfix) with ESMTPSA id D5227600A5;
	Tue,  7 May 2024 10:44:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fiberby.net;
	s=202008; t=1715078674;
	bh=q9BQNm/ihZ/CfwkElHCQ6Teb3l9zBwR1XwqAUbRcuDI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BEBSedbWn84/AfOqMmuy5Ld+h2Ucwiq4QhColSMPzRJq4ZGtktK8IzvA7Qk+WiPaS
	 RrBPVLfa51mWHV1G9LhkK3VMme4+6f+inKOfsaOLXsN5yqu5WdIYfT7p6JgKu8cKx8
	 LCCsCMs2ZsHKdhb4RPrPVZnsN5Y2V2SSE/10gnNKBfhRN6Cx7jhBk7vriK96/r7wga
	 pRX5kqVT/AUbuws91mv1FLy4ngAaGwa7Jbxoa6jg1iQGiDy8Ut4PQ9ZUjkL/V+qs3r
	 ywCbM8h03SqQfsSuxzXuQKJRaElxbC1lfa70OUzogUMwzSto9ywobryF/seI8HbT7U
	 HEe5ZG+jz6i1w==
Received: by x201s (Postfix, from userid 1000)
	id 048B4203ABB; Tue, 07 May 2024 10:44:24 +0000 (UTC)
From: =?UTF-8?q?Asbj=C3=B8rn=20Sloth=20T=C3=B8nnesen?= <ast@fiberby.net>
To: netdev@vger.kernel.org
Cc: =?UTF-8?q?Asbj=C3=B8rn=20Sloth=20T=C3=B8nnesen?= <ast@fiberby.net>,
	linux-kernel@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Manish Chopra <manishc@marvell.com>
Subject: [PATCH net-next 08/14] net: qede: use extack in qede_flow_parse_udp_v6()
Date: Tue,  7 May 2024 10:44:09 +0000
Message-ID: <20240507104421.1628139-9-ast@fiberby.net>
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
index 2c1f860d30e3..e7b9aeef5a6f 100644
--- a/drivers/net/ethernet/qlogic/qede/qede_filter.c
+++ b/drivers/net/ethernet/qlogic/qede/qede_filter.c
@@ -1806,13 +1806,13 @@ qede_flow_parse_tcp_v4(struct netlink_ext_ack *extack, struct flow_rule *rule,
 }
 
 static int
-qede_flow_parse_udp_v6(struct qede_dev *edev, struct flow_rule *rule,
-		     struct qede_arfs_tuple *tuple)
+qede_flow_parse_udp_v6(struct netlink_ext_ack *extack, struct flow_rule *rule,
+		       struct qede_arfs_tuple *tuple)
 {
 	tuple->ip_proto = IPPROTO_UDP;
 	tuple->eth_proto = htons(ETH_P_IPV6);
 
-	return qede_flow_parse_v6_common(NULL, rule, tuple);
+	return qede_flow_parse_v6_common(extack, rule, tuple);
 }
 
 static int
@@ -1866,7 +1866,7 @@ qede_parse_flow_attr(struct qede_dev *edev, __be16 proto,
 	else if (ip_proto == IPPROTO_UDP && proto == htons(ETH_P_IP))
 		rc = qede_flow_parse_udp_v4(edev, rule, tuple);
 	else if (ip_proto == IPPROTO_UDP && proto == htons(ETH_P_IPV6))
-		rc = qede_flow_parse_udp_v6(edev, rule, tuple);
+		rc = qede_flow_parse_udp_v6(NULL, rule, tuple);
 	else
 		DP_NOTICE(edev, "Invalid protocol request\n");
 
-- 
2.43.0


