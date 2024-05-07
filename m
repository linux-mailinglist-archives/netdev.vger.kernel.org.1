Return-Path: <netdev+bounces-94037-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D7EC38BE004
	for <lists+netdev@lfdr.de>; Tue,  7 May 2024 12:46:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 797201F257D6
	for <lists+netdev@lfdr.de>; Tue,  7 May 2024 10:46:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1846D156F48;
	Tue,  7 May 2024 10:44:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b="Mw87Jy9m"
X-Original-To: netdev@vger.kernel.org
Received: from mail1.fiberby.net (mail1.fiberby.net [193.104.135.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E72D152E1A;
	Tue,  7 May 2024 10:44:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.104.135.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715078690; cv=none; b=ISAxOx9h1FC2uAneT11mb/HODta2QDUSXWBGesVry1KfduL4Q4JB1oRa0agNSpP0CYoWuS5f8oIfzFBlgZcweZW306uLSRXD5NIwy8PlTVdow1iOLeIXp/Ebe12aCtrjAH+X63M43BTBVadq8h6+olcn0tINCyw/DKiAIN96Cy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715078690; c=relaxed/simple;
	bh=KwE2z5gtpz0YKaaeaNiJAhoZo0dGwsPTDh4T0pF6+aI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=k1eSflnDbIO9e0+WyZNi0/hGRJqJN+owbrMvNM9hjv9ReiGPMpbvjbWfU/eJVw5nl1lLpxn3MfPjGr/cQ+u3CAJc2HAZDsTv7/e+WMOBmeC4qNfaLeQZlqllEMFvKsMdSe6oIcEauhoRwicWIVLRaySxFK723noy/roABgR7Bvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net; spf=pass smtp.mailfrom=fiberby.net; dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b=Mw87Jy9m; arc=none smtp.client-ip=193.104.135.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fiberby.net
Received: from x201s (193-104-135-243.ip4.fiberby.net [193.104.135.243])
	by mail1.fiberby.net (Postfix) with ESMTPSA id 1FAD5600AF;
	Tue,  7 May 2024 10:44:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fiberby.net;
	s=202008; t=1715078675;
	bh=KwE2z5gtpz0YKaaeaNiJAhoZo0dGwsPTDh4T0pF6+aI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Mw87Jy9mq2zzgPnTycjIq/ewKs59JKKgof2ozFQJl4Gs2Xd2VH8/rNZ3qPXOb9pWt
	 47rFATEe3DDjmSlBQd02GUbYwlSVd1CjyYbZcJw9uZunfgG6bcfpyMVekmiekJsMw5
	 zqyP77vyWw1yI7So4PaCS5PEvCj7iqA+ClSv4qp+NW5OA/5BdHtY4mEeGX26TRnR/E
	 0ELT9XrwnrSs5z+KNq01ZB1SdTi8aqOBHK8/dcyDcTolH/v7dmAcAMw3b+XaI29+jQ
	 koiJsO5jPDl65XnLtjtBM8nPCMBpEJhlNaRpI1RPbhqy2GbdS0Xnsl3fY3LiOqUhpP
	 WiJckEpT9Au/g==
Received: by x201s (Postfix, from userid 1000)
	id D05FB203931; Tue, 07 May 2024 10:44:23 +0000 (UTC)
From: =?UTF-8?q?Asbj=C3=B8rn=20Sloth=20T=C3=B8nnesen?= <ast@fiberby.net>
To: netdev@vger.kernel.org
Cc: =?UTF-8?q?Asbj=C3=B8rn=20Sloth=20T=C3=B8nnesen?= <ast@fiberby.net>,
	linux-kernel@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Manish Chopra <manishc@marvell.com>
Subject: [PATCH net-next 07/14] net: qede: use extack in qede_flow_parse_tcp_v4()
Date: Tue,  7 May 2024 10:44:08 +0000
Message-ID: <20240507104421.1628139-8-ast@fiberby.net>
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

Convert qede_flow_parse_tcp_v4() to take extack,
and drop the edev argument.

Pass extack in call to qede_flow_parse_v4_common().

In call to qede_flow_parse_tcp_v4(), use NULL as extack
for now, until a subsequent patch makes extack available.

Only compile tested.

Signed-off-by: Asbjørn Sloth Tønnesen <ast@fiberby.net>
---
 drivers/net/ethernet/qlogic/qede/qede_filter.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/qlogic/qede/qede_filter.c b/drivers/net/ethernet/qlogic/qede/qede_filter.c
index bc0e95ba1880..2c1f860d30e3 100644
--- a/drivers/net/ethernet/qlogic/qede/qede_filter.c
+++ b/drivers/net/ethernet/qlogic/qede/qede_filter.c
@@ -1796,13 +1796,13 @@ qede_flow_parse_tcp_v6(struct netlink_ext_ack *extack, struct flow_rule *rule,
 }
 
 static int
-qede_flow_parse_tcp_v4(struct qede_dev *edev, struct flow_rule *rule,
-		     struct qede_arfs_tuple *tuple)
+qede_flow_parse_tcp_v4(struct netlink_ext_ack *extack, struct flow_rule *rule,
+		       struct qede_arfs_tuple *tuple)
 {
 	tuple->ip_proto = IPPROTO_TCP;
 	tuple->eth_proto = htons(ETH_P_IP);
 
-	return qede_flow_parse_v4_common(NULL, rule, tuple);
+	return qede_flow_parse_v4_common(extack, rule, tuple);
 }
 
 static int
@@ -1860,7 +1860,7 @@ qede_parse_flow_attr(struct qede_dev *edev, __be16 proto,
 	}
 
 	if (ip_proto == IPPROTO_TCP && proto == htons(ETH_P_IP))
-		rc = qede_flow_parse_tcp_v4(edev, rule, tuple);
+		rc = qede_flow_parse_tcp_v4(NULL, rule, tuple);
 	else if (ip_proto == IPPROTO_TCP && proto == htons(ETH_P_IPV6))
 		rc = qede_flow_parse_tcp_v6(NULL, rule, tuple);
 	else if (ip_proto == IPPROTO_UDP && proto == htons(ETH_P_IP))
-- 
2.43.0


