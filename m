Return-Path: <netdev+bounces-198390-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D720ADBED0
	for <lists+netdev@lfdr.de>; Tue, 17 Jun 2025 03:49:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 31BD43B522E
	for <lists+netdev@lfdr.de>; Tue, 17 Jun 2025 01:48:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BF2F1AA1D2;
	Tue, 17 Jun 2025 01:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J83jmMQh"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 399771A317D
	for <netdev@vger.kernel.org>; Tue, 17 Jun 2025 01:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750124937; cv=none; b=TuNiH+w8Sga/zemalOnIdaZNXAXsQJRSW35r/IFEuOGWnVv8NB07j/tKVtm+ua5pplwtX/cJB862ivITBByst+KnTwubsfwnypjyBHWkLvCFl1xk6cLmB439obzHPGqxBq4VU8hvakC+fFzIyWTlQOfi0LnDlsa7bZjzv2vwjV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750124937; c=relaxed/simple;
	bh=tsTNwbMyXQyNCUsZ/Mr6/Wjq3agKavr46zd2lX4Bpco=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ez8Sa1u/5aRROoD8HfebWWQaP6X9e9EvNXbiV6FbnvyAJrlahz8YJvDRGBVqzEOliXfd7R6qyIhYFYUX0UprSvF544wRz8d3fZsMKkyyecZHbu8032XCttQa86fsGnAgd7xKRH1Wb/Llh36vLdAK2l4ZlXGRjf+I1Kwg1pSoKA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J83jmMQh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B21DCC4CEF6;
	Tue, 17 Jun 2025 01:48:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750124937;
	bh=tsTNwbMyXQyNCUsZ/Mr6/Wjq3agKavr46zd2lX4Bpco=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=J83jmMQh5wchmmKzrjrOwPGLNnElqFRm9LwEAuMufWVgGyUrKkstYZ6Q2lkH5rctm
	 BC7YB5fmZY8bK5Xz/SuYiXjgNW6A4p3rBUR+GXHG7wJ8F+T0FdPmU/X+1470UOdA4d
	 X2RP6g0tyv52CBm4jZRv70W+xP7w3HBzogFzGiygj2EWoFhUO0nY/B7Rtsy8IL2Ybt
	 fcdQqgXS+J96wIKG7zmlVzXvRhrWuyyFBO3UUy6d+6r47uRqyuLJB7Z7b9Our5z0PV
	 EAJjrUEcw3IohXdWRMIQUYlhQrzs3dcuMeEiCN3qEEs4WnB5BGAU1yt4o8cnxYlenS
	 9R5TOCEqtbNPQ==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	madalin.bucur@nxp.com,
	ioana.ciornei@nxp.com,
	marcin.s.wojtas@gmail.com,
	bh74.an@samsung.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next 2/5] eth: mvpp2: migrate to new RXFH callbacks
Date: Mon, 16 Jun 2025 18:48:45 -0700
Message-ID: <20250617014848.436741-3-kuba@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250617014848.436741-1-kuba@kernel.org>
References: <20250617014848.436741-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Migrate to new callbacks added by commit 9bb00786fc61 ("net: ethtool:
add dedicated callbacks for getting and setting rxfh fields").

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 .../net/ethernet/marvell/mvpp2/mvpp2_cls.h    |  6 ++--
 .../net/ethernet/marvell/mvpp2/mvpp2_cls.c    |  6 ++--
 .../net/ethernet/marvell/mvpp2/mvpp2_main.c   | 31 +++++++++++++++----
 3 files changed, 33 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/marvell/mvpp2/mvpp2_cls.h b/drivers/net/ethernet/marvell/mvpp2/mvpp2_cls.h
index 85c9c6e80678..caadf3aea95d 100644
--- a/drivers/net/ethernet/marvell/mvpp2/mvpp2_cls.h
+++ b/drivers/net/ethernet/marvell/mvpp2/mvpp2_cls.h
@@ -272,8 +272,10 @@ int mvpp22_port_rss_ctx_indir_set(struct mvpp2_port *port, u32 rss_ctx,
 int mvpp22_port_rss_ctx_indir_get(struct mvpp2_port *port, u32 rss_ctx,
 				  u32 *indir);
 
-int mvpp2_ethtool_rxfh_get(struct mvpp2_port *port, struct ethtool_rxnfc *info);
-int mvpp2_ethtool_rxfh_set(struct mvpp2_port *port, struct ethtool_rxnfc *info);
+int mvpp2_ethtool_rxfh_get(struct mvpp2_port *port,
+			   struct ethtool_rxfh_fields *info);
+int mvpp2_ethtool_rxfh_set(struct mvpp2_port *port,
+			   const struct ethtool_rxfh_fields *info);
 
 void mvpp2_cls_init(struct mvpp2 *priv);
 
diff --git a/drivers/net/ethernet/marvell/mvpp2/mvpp2_cls.c b/drivers/net/ethernet/marvell/mvpp2/mvpp2_cls.c
index 8ed83fb98862..44b201817d94 100644
--- a/drivers/net/ethernet/marvell/mvpp2/mvpp2_cls.c
+++ b/drivers/net/ethernet/marvell/mvpp2/mvpp2_cls.c
@@ -1618,7 +1618,8 @@ int mvpp22_port_rss_ctx_indir_get(struct mvpp2_port *port, u32 port_ctx,
 	return 0;
 }
 
-int mvpp2_ethtool_rxfh_set(struct mvpp2_port *port, struct ethtool_rxnfc *info)
+int mvpp2_ethtool_rxfh_set(struct mvpp2_port *port,
+			   const struct ethtool_rxfh_fields *info)
 {
 	u16 hash_opts = 0;
 	u32 flow_type;
@@ -1656,7 +1657,8 @@ int mvpp2_ethtool_rxfh_set(struct mvpp2_port *port, struct ethtool_rxnfc *info)
 	return mvpp2_port_rss_hash_opts_set(port, flow_type, hash_opts);
 }
 
-int mvpp2_ethtool_rxfh_get(struct mvpp2_port *port, struct ethtool_rxnfc *info)
+int mvpp2_ethtool_rxfh_get(struct mvpp2_port *port,
+			   struct ethtool_rxfh_fields *info)
 {
 	unsigned long hash_opts;
 	u32 flow_type;
diff --git a/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c b/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
index a7872d14a49d..8ebb985d2573 100644
--- a/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
+++ b/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
@@ -5588,9 +5588,6 @@ static int mvpp2_ethtool_get_rxnfc(struct net_device *dev,
 		return -EOPNOTSUPP;
 
 	switch (info->cmd) {
-	case ETHTOOL_GRXFH:
-		ret = mvpp2_ethtool_rxfh_get(port, info);
-		break;
 	case ETHTOOL_GRXRINGS:
 		info->data = port->nrxqs;
 		break;
@@ -5628,9 +5625,6 @@ static int mvpp2_ethtool_set_rxnfc(struct net_device *dev,
 		return -EOPNOTSUPP;
 
 	switch (info->cmd) {
-	case ETHTOOL_SRXFH:
-		ret = mvpp2_ethtool_rxfh_set(port, info);
-		break;
 	case ETHTOOL_SRXCLSRLINS:
 		ret = mvpp2_ethtool_cls_rule_ins(port, info);
 		break;
@@ -5747,6 +5741,29 @@ static int mvpp2_ethtool_set_rxfh(struct net_device *dev,
 	return mvpp2_modify_rxfh_context(dev, NULL, rxfh, extack);
 }
 
+static int mvpp2_ethtool_get_rxfh_fields(struct net_device *dev,
+					 struct ethtool_rxfh_fields *info)
+{
+	struct mvpp2_port *port = netdev_priv(dev);
+
+	if (!mvpp22_rss_is_supported(port))
+		return -EOPNOTSUPP;
+
+	return mvpp2_ethtool_rxfh_get(port, info);
+}
+
+static int mvpp2_ethtool_set_rxfh_fields(struct net_device *dev,
+					 const struct ethtool_rxfh_fields *info,
+					 struct netlink_ext_ack *extack)
+{
+	struct mvpp2_port *port = netdev_priv(dev);
+
+	if (!mvpp22_rss_is_supported(port))
+		return -EOPNOTSUPP;
+
+	return mvpp2_ethtool_rxfh_set(port, info);
+}
+
 static int mvpp2_ethtool_get_eee(struct net_device *dev,
 				 struct ethtool_keee *eee)
 {
@@ -5813,6 +5830,8 @@ static const struct ethtool_ops mvpp2_eth_tool_ops = {
 	.get_rxfh_indir_size	= mvpp2_ethtool_get_rxfh_indir_size,
 	.get_rxfh		= mvpp2_ethtool_get_rxfh,
 	.set_rxfh		= mvpp2_ethtool_set_rxfh,
+	.get_rxfh_fields	= mvpp2_ethtool_get_rxfh_fields,
+	.set_rxfh_fields	= mvpp2_ethtool_set_rxfh_fields,
 	.create_rxfh_context	= mvpp2_create_rxfh_context,
 	.modify_rxfh_context	= mvpp2_modify_rxfh_context,
 	.remove_rxfh_context	= mvpp2_remove_rxfh_context,
-- 
2.49.0


