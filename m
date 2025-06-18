Return-Path: <netdev+bounces-199227-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AA78ADF7D8
	for <lists+netdev@lfdr.de>; Wed, 18 Jun 2025 22:39:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 090E4171468
	for <lists+netdev@lfdr.de>; Wed, 18 Jun 2025 20:39:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99A2B21D3D4;
	Wed, 18 Jun 2025 20:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QLn/nQdl"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75E6A21D3D3
	for <netdev@vger.kernel.org>; Wed, 18 Jun 2025 20:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750279146; cv=none; b=cAVK7qpfl92Zc6XhtaTO+bwah8p8r6/Hax6ScDE13RhL42J9MkozHzrG3bBcvpviS2LFdLCAwRNLnjMerVdSni5+9vR9YM+hvtc/bXUu57XC/objN90geZM0Su7Uy2n5j0mkMg+oPvXNPsZVNd4T0ItKbPwwOpsuOUGJ4YF3WjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750279146; c=relaxed/simple;
	bh=+SugxNLyiFGu8L5TR+9xgKZpp0bga6vfJxj4Xas+lG4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qdz9ByKoFSWOUQA80OlCEExTnH5RcmwlhQvkvXUoB5lyrkjifhK/8olE/Dk1/KjDIL6GgbUpMJ5eT/QWy6YJf/K9mnv7HF5VwbtDxrufe/jzFcBGbkaTkcMU9SCdylmMYoD19O0PiagpYgAbCoSOrHW9b5El/BA9y+A+9xJ1Hrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QLn/nQdl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73F4DC4CEE7;
	Wed, 18 Jun 2025 20:39:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750279146;
	bh=+SugxNLyiFGu8L5TR+9xgKZpp0bga6vfJxj4Xas+lG4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QLn/nQdlsiBbgY1LfRHdO9FFgzwGK1D8JE90TyYk28GwaniXnR54Lfxq+nSF7DRJq
	 MfMiFTbePA0YIgVGc87osSl/bVJjswe9ERbEwg0+b7HV4g075Pr/gujK1cGrJQ4Dj+
	 tlfvqW8SOST6HMht7bJrcxaJGbWKvnCsahRDHpUo3icq/FCwUd8ey6mwQuSp/NM/oi
	 QSkDhPpC6Xn8StJb4aFexZfo1bMF/ct9EjWFPb17DYFLfBljDDp+8xORA3xaV7ZG9U
	 xg8PCJlU1UJ/dUU603etiHLabBv2c+gWz0693pJtB0WRh3O3FYzVWhyOdtAxXoaLRY
	 MRtD9dG6ystCA==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	ajit.khaparde@broadcom.com,
	sriharsha.basavapatna@broadcom.com,
	somnath.kotur@broadcom.com,
	shenjian15@huawei.com,
	salil.mehta@huawei.com,
	shaojijie@huawei.com,
	cai.huoqing@linux.dev,
	saeedm@nvidia.com,
	tariqt@nvidia.com,
	louis.peens@corigine.com,
	mbloch@nvidia.com,
	manishc@marvell.com,
	ecree.xilinx@gmail.com,
	joe@dama.to,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next 05/10] eth: qede: migrate to new RXFH callbacks
Date: Wed, 18 Jun 2025 13:38:18 -0700
Message-ID: <20250618203823.1336156-6-kuba@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250618203823.1336156-1-kuba@kernel.org>
References: <20250618203823.1336156-1-kuba@kernel.org>
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
 .../net/ethernet/qlogic/qede/qede_ethtool.c   | 22 +++++++++++--------
 1 file changed, 13 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ethernet/qlogic/qede/qede_ethtool.c b/drivers/net/ethernet/qlogic/qede/qede_ethtool.c
index e50e1df0a433..23982704273c 100644
--- a/drivers/net/ethernet/qlogic/qede/qede_ethtool.c
+++ b/drivers/net/ethernet/qlogic/qede/qede_ethtool.c
@@ -1168,8 +1168,11 @@ static int qede_set_phys_id(struct net_device *dev,
 	return 0;
 }
 
-static int qede_get_rss_flags(struct qede_dev *edev, struct ethtool_rxnfc *info)
+static int qede_get_rxfh_fields(struct net_device *dev,
+				struct ethtool_rxfh_fields *info)
 {
+	struct qede_dev *edev = netdev_priv(dev);
+
 	info->data = RXH_IP_SRC | RXH_IP_DST;
 
 	switch (info->flow_type) {
@@ -1206,9 +1209,6 @@ static int qede_get_rxnfc(struct net_device *dev, struct ethtool_rxnfc *info,
 	case ETHTOOL_GRXRINGS:
 		info->data = QEDE_RSS_COUNT(edev);
 		break;
-	case ETHTOOL_GRXFH:
-		rc = qede_get_rss_flags(edev, info);
-		break;
 	case ETHTOOL_GRXCLSRLCNT:
 		info->rule_cnt = qede_get_arfs_filter_count(edev);
 		info->data = QEDE_RFS_MAX_FLTR;
@@ -1227,14 +1227,17 @@ static int qede_get_rxnfc(struct net_device *dev, struct ethtool_rxnfc *info,
 	return rc;
 }
 
-static int qede_set_rss_flags(struct qede_dev *edev, struct ethtool_rxnfc *info)
+static int qede_set_rxfh_fields(struct net_device *dev,
+				const struct ethtool_rxfh_fields *info,
+				struct netlink_ext_ack *extack)
 {
 	struct qed_update_vport_params *vport_update_params;
+	struct qede_dev *edev = netdev_priv(dev);
 	u8 set_caps = 0, clr_caps = 0;
 	int rc = 0;
 
 	DP_VERBOSE(edev, QED_MSG_DEBUG,
-		   "Set rss flags command parameters: flow type = %d, data = %llu\n",
+		   "Set rss flags command parameters: flow type = %d, data = %u\n",
 		   info->flow_type, info->data);
 
 	switch (info->flow_type) {
@@ -1337,9 +1340,6 @@ static int qede_set_rxnfc(struct net_device *dev, struct ethtool_rxnfc *info)
 	int rc;
 
 	switch (info->cmd) {
-	case ETHTOOL_SRXFH:
-		rc = qede_set_rss_flags(edev, info);
-		break;
 	case ETHTOOL_SRXCLSRLINS:
 		rc = qede_add_cls_rule(edev, info);
 		break;
@@ -2293,6 +2293,8 @@ static const struct ethtool_ops qede_ethtool_ops = {
 	.get_rxfh_key_size		= qede_get_rxfh_key_size,
 	.get_rxfh			= qede_get_rxfh,
 	.set_rxfh			= qede_set_rxfh,
+	.get_rxfh_fields		= qede_get_rxfh_fields,
+	.set_rxfh_fields		= qede_set_rxfh_fields,
 	.get_ts_info			= qede_get_ts_info,
 	.get_channels			= qede_get_channels,
 	.set_channels			= qede_set_channels,
@@ -2335,6 +2337,8 @@ static const struct ethtool_ops qede_vf_ethtool_ops = {
 	.get_rxfh_key_size		= qede_get_rxfh_key_size,
 	.get_rxfh			= qede_get_rxfh,
 	.set_rxfh			= qede_set_rxfh,
+	.get_rxfh_fields		= qede_get_rxfh_fields,
+	.set_rxfh_fields		= qede_set_rxfh_fields,
 	.get_channels			= qede_get_channels,
 	.set_channels			= qede_set_channels,
 	.get_per_queue_coalesce		= qede_get_per_coalesce,
-- 
2.49.0


