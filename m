Return-Path: <netdev+bounces-198389-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2469AADBECF
	for <lists+netdev@lfdr.de>; Tue, 17 Jun 2025 03:49:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 195B13B4122
	for <lists+netdev@lfdr.de>; Tue, 17 Jun 2025 01:48:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1BC8381AF;
	Tue, 17 Jun 2025 01:48:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ghZHwz0f"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADA531662E7
	for <netdev@vger.kernel.org>; Tue, 17 Jun 2025 01:48:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750124936; cv=none; b=Ji94Jtrk5r8gSMrzlK0dqYADepN8ZJ7G63oRYaVIRBE06cxGbbC3hF5uTTkN66HxBIMYx6bMhPuR4pDGjxNjddAknD6rIfgwL1vyz5gTt2cL4P7ebQIrMiVi3gOm4etzmc5fpaXBXLpmk5NgO7QI2mpw3IU/tzLphb1vNUYPgfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750124936; c=relaxed/simple;
	bh=7ECgga5wfIG6E4vn9JUPK6kIfhdsLlcbIil5k4AQXUg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=H+rAskr5LKg0LLT/Il/tnmcBzpyJKlWX5cJgal7IdFEvlNw0pJ2zlC/JVb3d4EaRWPhW6tnoqA0PErkMowSxo/1Sxjp9t/pqaTygb8r5P4b6oZExacYcYzLJyIk5MnAFcU1AmUMqHdwbQdO9uyS/LUEfimNefIkUT6wSIquLBWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ghZHwz0f; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 397F2C4CEF3;
	Tue, 17 Jun 2025 01:48:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750124936;
	bh=7ECgga5wfIG6E4vn9JUPK6kIfhdsLlcbIil5k4AQXUg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ghZHwz0fo2pu5/dEagunDsRMB/PVc5z+e2UHdaMKYL/mIKGX3t3IDLWftjG1CgAWS
	 axnDWVK5WEizthkUE0Dge4F16ezxremkKA11w3PI4QscNlFCLXKFLaxNEJvs1cE+BI
	 1mCYMznKdPJ5v1Ip3Jc4NpsMB78zgggxsmqs2es0p0TjiT0P5YDvAGvPSKVJWv3ZsP
	 njkXm6mMTX47HWYL9XlkESM+nDGkJeqB/0kCU+Fd4iRAzfsQF1A49JW0buPIhgq/Fh
	 LRJ/5bZDWV6Z2COt/41gfvoKcuI/yK9VLWJeFkpsBo2oCoKTKn88CAdiFGHNDpz2yF
	 4V5iAb2dyVowA==
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
Subject: [PATCH net-next 1/5] eth: niu: migrate to new RXFH callbacks
Date: Mon, 16 Jun 2025 18:48:44 -0700
Message-ID: <20250617014848.436741-2-kuba@kernel.org>
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
 drivers/net/ethernet/sun/niu.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/sun/niu.c b/drivers/net/ethernet/sun/niu.c
index ddca8fc7883e..75d7e10944d4 100644
--- a/drivers/net/ethernet/sun/niu.c
+++ b/drivers/net/ethernet/sun/niu.c
@@ -7077,8 +7077,10 @@ static int niu_ethflow_to_flowkey(u64 ethflow, u64 *flow_key)
 
 }
 
-static int niu_get_hash_opts(struct niu *np, struct ethtool_rxnfc *nfc)
+static int niu_get_rxfh_fields(struct net_device *dev,
+			       struct ethtool_rxfh_fields *nfc)
 {
+	struct niu *np = netdev_priv(dev);
 	u64 class;
 
 	nfc->data = 0;
@@ -7290,9 +7292,6 @@ static int niu_get_nfc(struct net_device *dev, struct ethtool_rxnfc *cmd,
 	int ret = 0;
 
 	switch (cmd->cmd) {
-	case ETHTOOL_GRXFH:
-		ret = niu_get_hash_opts(np, cmd);
-		break;
 	case ETHTOOL_GRXRINGS:
 		cmd->data = np->num_rx_rings;
 		break;
@@ -7313,8 +7312,11 @@ static int niu_get_nfc(struct net_device *dev, struct ethtool_rxnfc *cmd,
 	return ret;
 }
 
-static int niu_set_hash_opts(struct niu *np, struct ethtool_rxnfc *nfc)
+static int niu_set_rxfh_fields(struct net_device *dev,
+			       const struct ethtool_rxfh_fields *nfc,
+			       struct netlink_ext_ack *extack)
 {
+	struct niu *np = netdev_priv(dev);
 	u64 class;
 	u64 flow_key = 0;
 	unsigned long flags;
@@ -7656,9 +7658,6 @@ static int niu_set_nfc(struct net_device *dev, struct ethtool_rxnfc *cmd)
 	int ret = 0;
 
 	switch (cmd->cmd) {
-	case ETHTOOL_SRXFH:
-		ret = niu_set_hash_opts(np, cmd);
-		break;
 	case ETHTOOL_SRXCLSRLINS:
 		ret = niu_add_ethtool_tcam_entry(np, cmd);
 		break;
@@ -7912,6 +7911,8 @@ static const struct ethtool_ops niu_ethtool_ops = {
 	.set_phys_id		= niu_set_phys_id,
 	.get_rxnfc		= niu_get_nfc,
 	.set_rxnfc		= niu_set_nfc,
+	.get_rxfh_fields	= niu_get_rxfh_fields,
+	.set_rxfh_fields	= niu_set_rxfh_fields,
 	.get_link_ksettings	= niu_get_link_ksettings,
 	.set_link_ksettings	= niu_set_link_ksettings,
 };
-- 
2.49.0


