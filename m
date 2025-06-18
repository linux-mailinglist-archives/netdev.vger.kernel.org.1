Return-Path: <netdev+bounces-199229-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92E7FADF7DA
	for <lists+netdev@lfdr.de>; Wed, 18 Jun 2025 22:39:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6CAB517CC6B
	for <lists+netdev@lfdr.de>; Wed, 18 Jun 2025 20:39:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A37121D5B6;
	Wed, 18 Jun 2025 20:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dCET8tAV"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9EA921D5B4
	for <netdev@vger.kernel.org>; Wed, 18 Jun 2025 20:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750279148; cv=none; b=f3q56u35d/yxhsn0V/NFAWHBkEp+3lR11XZpdDh9fDhTYjPXvOaW/7MBe0Khq9ybn4h30krk3cziMaxq2uwxdwmeX45xWQEhpmQR0VfLvgW1dE6pCcMx/qQSLXc+GtJK2iibuxucjy/htjxhTf37BD0cfPvRxwPeCLFXpfHFbEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750279148; c=relaxed/simple;
	bh=UHMOfBBYHuFW9ZcEprgLRjjW7g6oLsNmPHik87K5LJ4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZyiO2iOIxPu+74Iz/8dNxHKTeXF1g5oeutzMgPVELAyKV4HOXCCS6i7awtPnkuD0pFqlAz2djzzI48NOkNndoCoOIKTmjUOoZtHRqCeXNXzL9g+ZdYmeMBGdz2q2IcOv9YUKrHreE8035wejUWt3OnNE+L37St6OUUn/v+tI+vo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dCET8tAV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6E31C4CEED;
	Wed, 18 Jun 2025 20:39:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750279147;
	bh=UHMOfBBYHuFW9ZcEprgLRjjW7g6oLsNmPHik87K5LJ4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dCET8tAV2nPu6cyvV4tB7ANdP4mTBK1kYl/rZtSyT4QxqKQfmViGl/QYIPNBGILr5
	 Lql7BFmjvLBf1QhPlI6OMn1sKfRbvsGyRUbhGLgrDnREhOVdC1xRRsZp1KkZa818zN
	 Od09mFRcQHALuvaTKbUIumMVKtP8yDqpcOFafutK/ujHkVCq++DKNWiwxQfan+o9d/
	 wT4ZC7glECQU5ACpIgUHiwAEyUEGGFmyJtKXmd+PjEgVZM8FJhNkADeBMoGnMzqh0k
	 dODnOlB6H+DqRW2vLSJ575evwKNWEmgyQCsclAcduPX/A5Olhvip93wkc86XRkPHry
	 HWcDNAdUu6vBA==
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
Subject: [PATCH net-next 07/10] eth: nfp: migrate to new RXFH callbacks
Date: Wed, 18 Jun 2025 13:38:20 -0700
Message-ID: <20250618203823.1336156-8-kuba@kernel.org>
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
 .../ethernet/netronome/nfp/nfp_net_ethtool.c    | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/netronome/nfp/nfp_net_ethtool.c b/drivers/net/ethernet/netronome/nfp/nfp_net_ethtool.c
index fbca8d0efd85..a36215195923 100644
--- a/drivers/net/ethernet/netronome/nfp/nfp_net_ethtool.c
+++ b/drivers/net/ethernet/netronome/nfp/nfp_net_ethtool.c
@@ -1303,9 +1303,10 @@ static u32 ethtool_flow_to_nfp_flag(u32 flow_type)
 	return xlate_ethtool_to_nfp[flow_type];
 }
 
-static int nfp_net_get_rss_hash_opts(struct nfp_net *nn,
-				     struct ethtool_rxnfc *cmd)
+static int nfp_net_get_rxfh_fields(struct net_device *netdev,
+				   struct ethtool_rxfh_fields *cmd)
 {
+	struct nfp_net *nn = netdev_priv(netdev);
 	u32 nfp_rss_flag;
 
 	cmd->data = 0;
@@ -1451,16 +1452,16 @@ static int nfp_net_get_rxnfc(struct net_device *netdev,
 	case ETHTOOL_GRXCLSRLALL:
 		cmd->data = NFP_FS_MAX_ENTRY;
 		return nfp_net_get_fs_loc(nn, rule_locs);
-	case ETHTOOL_GRXFH:
-		return nfp_net_get_rss_hash_opts(nn, cmd);
 	default:
 		return -EOPNOTSUPP;
 	}
 }
 
-static int nfp_net_set_rss_hash_opt(struct nfp_net *nn,
-				    struct ethtool_rxnfc *nfc)
+static int nfp_net_set_rxfh_fields(struct net_device *netdev,
+				   const struct ethtool_rxfh_fields *nfc,
+				   struct netlink_ext_ack *extack)
 {
+	struct nfp_net *nn = netdev_priv(netdev);
 	u32 new_rss_cfg = nn->rss_cfg;
 	u32 nfp_rss_flag;
 	int err;
@@ -1763,8 +1764,6 @@ static int nfp_net_set_rxnfc(struct net_device *netdev,
 	struct nfp_net *nn = netdev_priv(netdev);
 
 	switch (cmd->cmd) {
-	case ETHTOOL_SRXFH:
-		return nfp_net_set_rss_hash_opt(nn, cmd);
 	case ETHTOOL_SRXCLSRLINS:
 		return nfp_net_fs_add(nn, cmd);
 	case ETHTOOL_SRXCLSRLDEL:
@@ -2506,6 +2505,8 @@ static const struct ethtool_ops nfp_net_ethtool_ops = {
 	.get_rxfh_key_size	= nfp_net_get_rxfh_key_size,
 	.get_rxfh		= nfp_net_get_rxfh,
 	.set_rxfh		= nfp_net_set_rxfh,
+	.get_rxfh_fields	= nfp_net_get_rxfh_fields,
+	.set_rxfh_fields	= nfp_net_set_rxfh_fields,
 	.get_regs_len		= nfp_net_get_regs_len,
 	.get_regs		= nfp_net_get_regs,
 	.set_dump		= nfp_app_set_dump,
-- 
2.49.0


