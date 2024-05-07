Return-Path: <netdev+bounces-94041-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BEC2A8BE00F
	for <lists+netdev@lfdr.de>; Tue,  7 May 2024 12:47:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7AA9328BAD3
	for <lists+netdev@lfdr.de>; Tue,  7 May 2024 10:47:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 703E615D5D5;
	Tue,  7 May 2024 10:44:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b="RtHm+Yyc"
X-Original-To: netdev@vger.kernel.org
Received: from mail1.fiberby.net (mail1.fiberby.net [193.104.135.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2905156645;
	Tue,  7 May 2024 10:44:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.104.135.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715078690; cv=none; b=tJJdw7PtSgEL8kY7vxNn82E5TaxHnvZLPBiskAXvN/4gxYU+hwNhUP0XP3ltk3HFBgi2p02bMjWtLuN3XEG6JhUArAj9ioauj8idiDsSCwIeyLBjZfznCu/2vWQr3+6n0HA60nnUHjfsFBg2Z+ZLlvg6S2l1PxIsiFTeRH6r9uQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715078690; c=relaxed/simple;
	bh=fexZUMKg94UcObypKKVFWeyZLvhx3OcEH+Pt6uNVRzc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RPsby/nPKafQ5T7PUZiA5eC7STd1F7Ly9kZxIt8bIo8FvzhvURkBSmf1oyuOX5jDY+9/9PoMChMynaAfXYfdL2a9jfV681EbWhYpd0tjS/mopizUX/gPxGnPd84Rm9l1zgtyUDzf80Bui25Gd7G2G7gtCEdpZ1Sktvm2fbcHVYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net; spf=pass smtp.mailfrom=fiberby.net; dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b=RtHm+Yyc; arc=none smtp.client-ip=193.104.135.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fiberby.net
Received: from x201s (193-104-135-243.ip4.fiberby.net [193.104.135.243])
	by mail1.fiberby.net (Postfix) with ESMTPSA id 6648760173;
	Tue,  7 May 2024 10:44:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fiberby.net;
	s=202008; t=1715078675;
	bh=fexZUMKg94UcObypKKVFWeyZLvhx3OcEH+Pt6uNVRzc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RtHm+YycOgIr3Y9uSch0Bdi4zbbt74gxiKWPpwlL9P/UIP+iBtj9LC1FzjeOs+1mR
	 sv7YiblWMTZ3H7zoGQFfpWsmHLSVEaQXB9IDOE7bz3IZl2+5qiw2gGR6RzlDFfypP0
	 8MO+W85DuGaLa248WQNZodFG7lLSu15laztfODsgp1An550aB5dVL3T2dlqdDV0A6E
	 c2FfGyAW4ETmCUJgQt9g5VCbCrIdwnnK3all/eWx8WfcrFaBl4udQVWrAwWjPcyCP9
	 HTxTxLEb2S8NFSLheAPR5/3SaKKcffIjH9JlYY99ncX1gDK6q9G3v3NvNFYYsmYmsJ
	 s/mVDGkNQDsbw==
Received: by x201s (Postfix, from userid 1000)
	id A50772037AE; Tue, 07 May 2024 10:44:23 +0000 (UTC)
From: =?UTF-8?q?Asbj=C3=B8rn=20Sloth=20T=C3=B8nnesen?= <ast@fiberby.net>
To: netdev@vger.kernel.org
Cc: =?UTF-8?q?Asbj=C3=B8rn=20Sloth=20T=C3=B8nnesen?= <ast@fiberby.net>,
	linux-kernel@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Manish Chopra <manishc@marvell.com>
Subject: [PATCH net-next 06/14] net: qede: use extack in qede_flow_parse_tcp_v6()
Date: Tue,  7 May 2024 10:44:07 +0000
Message-ID: <20240507104421.1628139-7-ast@fiberby.net>
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
index 056384362037..bc0e95ba1880 100644
--- a/drivers/net/ethernet/qlogic/qede/qede_filter.c
+++ b/drivers/net/ethernet/qlogic/qede/qede_filter.c
@@ -1786,13 +1786,13 @@ qede_flow_parse_v4_common(struct netlink_ext_ack *extack,
 }
 
 static int
-qede_flow_parse_tcp_v6(struct qede_dev *edev, struct flow_rule *rule,
-		     struct qede_arfs_tuple *tuple)
+qede_flow_parse_tcp_v6(struct netlink_ext_ack *extack, struct flow_rule *rule,
+		       struct qede_arfs_tuple *tuple)
 {
 	tuple->ip_proto = IPPROTO_TCP;
 	tuple->eth_proto = htons(ETH_P_IPV6);
 
-	return qede_flow_parse_v6_common(NULL, rule, tuple);
+	return qede_flow_parse_v6_common(extack, rule, tuple);
 }
 
 static int
@@ -1862,7 +1862,7 @@ qede_parse_flow_attr(struct qede_dev *edev, __be16 proto,
 	if (ip_proto == IPPROTO_TCP && proto == htons(ETH_P_IP))
 		rc = qede_flow_parse_tcp_v4(edev, rule, tuple);
 	else if (ip_proto == IPPROTO_TCP && proto == htons(ETH_P_IPV6))
-		rc = qede_flow_parse_tcp_v6(edev, rule, tuple);
+		rc = qede_flow_parse_tcp_v6(NULL, rule, tuple);
 	else if (ip_proto == IPPROTO_UDP && proto == htons(ETH_P_IP))
 		rc = qede_flow_parse_udp_v4(edev, rule, tuple);
 	else if (ip_proto == IPPROTO_UDP && proto == htons(ETH_P_IPV6))
-- 
2.43.0


