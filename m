Return-Path: <netdev+bounces-94621-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 981628C0019
	for <lists+netdev@lfdr.de>; Wed,  8 May 2024 16:35:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C98971C23200
	for <lists+netdev@lfdr.de>; Wed,  8 May 2024 14:35:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C9E7127E06;
	Wed,  8 May 2024 14:34:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b="C2G2qSJu"
X-Original-To: netdev@vger.kernel.org
Received: from mail1.fiberby.net (mail1.fiberby.net [193.104.135.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1E5954657;
	Wed,  8 May 2024 14:34:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.104.135.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715178878; cv=none; b=FTsCkD68ACBsbAvuobjlAsfloK5p3+jqQb4zX+7naqIDLHh5N5ttzbTiClU7IC0WWFT1fZUGyVhPJWhMPouvxU1wWjWjZw4bb/lCAy8XemGWMWU0vd/CCDFBAmcAxT6QPHNfFDoFrgebADzX5ttAV/4E7wJno//r8lw95cOgNyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715178878; c=relaxed/simple;
	bh=PZszkrspUV2m4L/nD/hefW+Kugt1rlhIPYkPxHe9k1M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=e8yi+qi40WZIdedACBL7tZlLnK6sHNfIrbwpF3SVaVlejS9BOfr++HEVx0YENsOUunKNHSMJd/BSG9FE1siesuIClQT1c/9poEdTj0uERBpRROU+boq87W/Ci1E0pH9doU3kRIMA2wpOWH+TmRqb/aLNzDIkvwd/Jvoc4Wt8FC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net; spf=pass smtp.mailfrom=fiberby.net; dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b=C2G2qSJu; arc=none smtp.client-ip=193.104.135.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fiberby.net
Received: from x201s (193-104-135-243.ip4.fiberby.net [193.104.135.243])
	by mail1.fiberby.net (Postfix) with ESMTPSA id 89B5B600B7;
	Wed,  8 May 2024 14:34:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fiberby.net;
	s=202008; t=1715178869;
	bh=PZszkrspUV2m4L/nD/hefW+Kugt1rlhIPYkPxHe9k1M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=C2G2qSJuAI1i3O46kcI5fxHmeRD5mqh1QdIXwQeV/tEzx/EpL2RCLtG/7gmadYRnV
	 gj7D8LdGgzI9PkNcjA6ssdthJTUVMrKzyP6NXMQeLEa3ol8dRI4Ue0y3XXoS5R6PAY
	 OJyrXdy1eYxA6Ov0vJG32MVeGLIjyPwv4BZ5nnIo6r60Zj6u8FZ11oFsZzpaHLgAcS
	 eC8qPFEB7uJ/BusOQaMP123ekGoe6st0NSVgUJygz4xjDCNNTPUBKLKretcc+OHZ4r
	 mqlvK0v0jr4mbIZbL2jjZW0HkAGu2O/uiPGwA1J34j2v1Zl5waDCz9QMAeNHfLHJHe
	 eJ3qu1gtjde4A==
Received: by x201s (Postfix, from userid 1000)
	id BC62220800F; Wed, 08 May 2024 14:34:06 +0000 (UTC)
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
Subject: [PATCH net-next v2 09/14] net: qede: use extack in qede_flow_parse_udp_v4()
Date: Wed,  8 May 2024 14:33:57 +0000
Message-ID: <20240508143404.95901-10-ast@fiberby.net>
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

Convert qede_flow_parse_udp_v4() to take extack,
and drop the edev argument.

Pass extack in call to qede_flow_parse_v4_common().

In call to qede_flow_parse_udp_v4(), use NULL as extack
for now, until a subsequent patch makes extack available.

Only compile tested.

Signed-off-by: Asbjørn Sloth Tønnesen <ast@fiberby.net>
---
 drivers/net/ethernet/qlogic/qede/qede_filter.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/qlogic/qede/qede_filter.c b/drivers/net/ethernet/qlogic/qede/qede_filter.c
index abeb873f58f3..69dbd615b653 100644
--- a/drivers/net/ethernet/qlogic/qede/qede_filter.c
+++ b/drivers/net/ethernet/qlogic/qede/qede_filter.c
@@ -1816,13 +1816,13 @@ qede_flow_parse_udp_v6(struct flow_rule *rule, struct qede_arfs_tuple *tuple,
 }
 
 static int
-qede_flow_parse_udp_v4(struct qede_dev *edev, struct flow_rule *rule,
-		     struct qede_arfs_tuple *tuple)
+qede_flow_parse_udp_v4(struct flow_rule *rule, struct qede_arfs_tuple *tuple,
+		       struct netlink_ext_ack *extack)
 {
 	tuple->ip_proto = IPPROTO_UDP;
 	tuple->eth_proto = htons(ETH_P_IP);
 
-	return qede_flow_parse_v4_common(rule, tuple, NULL);
+	return qede_flow_parse_v4_common(rule, tuple, extack);
 }
 
 static int
@@ -1864,7 +1864,7 @@ qede_parse_flow_attr(struct qede_dev *edev, __be16 proto,
 	else if (ip_proto == IPPROTO_TCP && proto == htons(ETH_P_IPV6))
 		rc = qede_flow_parse_tcp_v6(rule, tuple, NULL);
 	else if (ip_proto == IPPROTO_UDP && proto == htons(ETH_P_IP))
-		rc = qede_flow_parse_udp_v4(edev, rule, tuple);
+		rc = qede_flow_parse_udp_v4(rule, tuple, NULL);
 	else if (ip_proto == IPPROTO_UDP && proto == htons(ETH_P_IPV6))
 		rc = qede_flow_parse_udp_v6(rule, tuple, NULL);
 	else
-- 
2.43.0


