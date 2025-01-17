Return-Path: <netdev+bounces-159450-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E55F6A15858
	for <lists+netdev@lfdr.de>; Fri, 17 Jan 2025 20:48:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D38F83A9E65
	for <lists+netdev@lfdr.de>; Fri, 17 Jan 2025 19:48:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8107B1A83EC;
	Fri, 17 Jan 2025 19:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e5cdYNKL"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D7401ABEA5
	for <netdev@vger.kernel.org>; Fri, 17 Jan 2025 19:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737143301; cv=none; b=pGYhW/13Aupv8Ps+TAmXcjYoTDzkOLlEoJthCmORQ2Y4uBHIyv27rs85oguVF13/oFHbSXvQfcsQDng/nPJdhLHsIMqV/HT3s/YTlCUu4cIZEVJl9Z/BK9QY9UuSND/q9iHwZaLvIdDA4wj19sJAz+88V5/MxRQ80dGDiNdhhfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737143301; c=relaxed/simple;
	bh=NlIev300popf804jEDnyYpvGEa84DthL/5QWm4+964o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=q6tEAPV6WRh2jdrEPfrTLg3PyToarxKCEWF05B2ifi47SIiztx/gJherKxiisNs+q5ytSkE/uSeWsVNBibzpXeD8KS38mps4RQM3n4NPKmA8EIAETPhPljwXlLPj6hRQBNYiYjmUedMnsGAe2metcadto/antFmCj438HkLir4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e5cdYNKL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9B7DC4CEE4;
	Fri, 17 Jan 2025 19:48:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737143301;
	bh=NlIev300popf804jEDnyYpvGEa84DthL/5QWm4+964o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=e5cdYNKLwxwXFJGwNPWgNLURwDabEOwiDs1aCYrCDPo8B7w5YUMOA+hd5yCgaELYn
	 854cIQrTXhPJvx4nuC/kwVm21zK3t7LQxvJvPPVTBzZmLN/dPOopolFm8eUggksKN9
	 l9/ioFGWzCa944WWJIUv+2+S8C9ziEMkikBch1HdYksq6zxw4hLbnn6e27gR8jKbPB
	 aT0YMuTbSMKqpH2DTUI4+dIdEn7z3c5L8FUA03LIrcAJxNfgi4Vn6mWkMRdWhnsnJE
	 7Y/O+2ordFSjik9dnY2eEls6DMN+GqTByzRHAxCOMdAuWtabjxqrygkvBeu4fBYYHw
	 s4/O+BpIJbGwg==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	michael.chan@broadcom.com,
	pavan.chebbi@broadcom.com,
	ap420073@gmail.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next 4/6] net: ethtool: populate the default HDS params in the core
Date: Fri, 17 Jan 2025 11:48:13 -0800
Message-ID: <20250117194815.1514410-5-kuba@kernel.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250117194815.1514410-1-kuba@kernel.org>
References: <20250117194815.1514410-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The core has the current HDS config, it can pre-populate the values
for the drivers. While at it, remove the zero-setting in netdevsim.
Zero are the default values since the config is zalloc'ed.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c | 1 -
 drivers/net/netdevsim/ethtool.c                   | 5 -----
 net/ethtool/rings.c                               | 4 ++++
 3 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
index 0a6d47d4d66b..9c5820839514 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
@@ -835,7 +835,6 @@ static void bnxt_get_ringparam(struct net_device *dev,
 	ering->rx_jumbo_pending = bp->rx_agg_ring_size;
 	ering->tx_pending = bp->tx_ring_size;
 
-	kernel_ering->hds_thresh = dev->cfg->hds_thresh;
 	kernel_ering->hds_thresh_max = BNXT_HDS_THRESHOLD_MAX;
 }
 
diff --git a/drivers/net/netdevsim/ethtool.c b/drivers/net/netdevsim/ethtool.c
index 189793debdb7..3b23f3d3ca2b 100644
--- a/drivers/net/netdevsim/ethtool.c
+++ b/drivers/net/netdevsim/ethtool.c
@@ -72,8 +72,6 @@ static void nsim_get_ringparam(struct net_device *dev,
 	struct netdevsim *ns = netdev_priv(dev);
 
 	memcpy(ring, &ns->ethtool.ring, sizeof(ns->ethtool.ring));
-	kernel_ring->tcp_data_split = dev->cfg->hds_config;
-	kernel_ring->hds_thresh = dev->cfg->hds_thresh;
 	kernel_ring->hds_thresh_max = NSIM_HDS_THRESHOLD_MAX;
 
 	if (kernel_ring->tcp_data_split == ETHTOOL_TCP_DATA_SPLIT_UNKNOWN)
@@ -190,9 +188,6 @@ static void nsim_ethtool_ring_init(struct netdevsim *ns)
 	ns->ethtool.ring.rx_jumbo_max_pending = 4096;
 	ns->ethtool.ring.rx_mini_max_pending = 4096;
 	ns->ethtool.ring.tx_max_pending = 4096;
-
-	ns->netdev->cfg->hds_config = ETHTOOL_TCP_DATA_SPLIT_UNKNOWN;
-	ns->netdev->cfg->hds_thresh = 0;
 }
 
 void nsim_ethtool_init(struct netdevsim *ns)
diff --git a/net/ethtool/rings.c b/net/ethtool/rings.c
index 5e8ba81fbb3e..7839bfd1ac6a 100644
--- a/net/ethtool/rings.c
+++ b/net/ethtool/rings.c
@@ -39,6 +39,10 @@ static int rings_prepare_data(const struct ethnl_req_info *req_base,
 	ret = ethnl_ops_begin(dev);
 	if (ret < 0)
 		return ret;
+
+	data->kernel_ringparam.tcp_data_split = dev->cfg->hds_config;
+	data->kernel_ringparam.hds_thresh = dev->cfg->hds_thresh;
+
 	dev->ethtool_ops->get_ringparam(dev, &data->ringparam,
 					&data->kernel_ringparam, info->extack);
 	ethnl_ops_complete(dev);
-- 
2.48.1


