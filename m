Return-Path: <netdev+bounces-184467-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 66204A95969
	for <lists+netdev@lfdr.de>; Tue, 22 Apr 2025 00:30:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B90BB7A9DA0
	for <lists+netdev@lfdr.de>; Mon, 21 Apr 2025 22:28:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 691C822A80F;
	Mon, 21 Apr 2025 22:28:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AXAiGp7w"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45A03224251
	for <netdev@vger.kernel.org>; Mon, 21 Apr 2025 22:28:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745274526; cv=none; b=knOP4l+2C7mD9ba0aWlhBa/OCmOSv19bagZSRjbT15GtpqqSNk8arhZP2VzIrQMVL0o+tzhcRs7ZuVt78mMhoAFPvcuOM+VK31Pp5pCZh7uudoNtOc0RuSKj4DN3uOdJFG3OjMgKYXNfs+3GKRfVx2oel8pYybA2R4bTfRAxWkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745274526; c=relaxed/simple;
	bh=o4roOPXojA1fLzB3g/veVv978K0MR63bcziRVOEWthg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UModm2KGe6J8LgkhnNvYIXPv74bctd5P3HsEV94Ex+UUJc+OM2qZpRIJqL+snE/ckzqnn7fAmj4IhjgufnXvkgrgRWW/1vUPjAaTOU7KIMHn/BwsbujMhgPuK7UKtpm6mIYLqA88Osk1/mIL43RbpO8/cTLlQ2msMt++E6AEoMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AXAiGp7w; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A93D6C4CEE4;
	Mon, 21 Apr 2025 22:28:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745274526;
	bh=o4roOPXojA1fLzB3g/veVv978K0MR63bcziRVOEWthg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AXAiGp7w40vo8tvYE2ltRiCJ/qUuisRHGrDP2w155dPZ5dw+l3gm/0KRqZ5NMFDnU
	 lCmvsJFovRB6VdkRTeR3+m5P0wk305f2q1WG04rT83/g6Uvh+oLyrHzffy6w7u6SyP
	 waNKa2cPvJ6XdQiuxAwtEajMtmIoQsA71/xeoRtAwwzFfcFImly8W/t2buLuQ4Lsed
	 yJCYHYr9rgbTX0F9fMKLZgji39Bs/IvaWXOoV3k9Ff/EARJalu4zHxgD71YCXeexzB
	 umonasMFKMwAYkaiTKklC5gIHOeMj/7/djNJvyL8LOYNQgc2nOa3o69cbqLs+QkSEc
	 3KB8I4NwZ6DdA==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	donald.hunter@gmail.com,
	sdf@fomichev.me,
	almasrymina@google.com,
	dw@davidwei.uk,
	asml.silence@gmail.com,
	ap420073@gmail.com,
	jdamato@fastly.com,
	dtatulea@nvidia.com,
	michael.chan@broadcom.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [RFC net-next 19/22] eth: bnxt: use queue op config validate
Date: Mon, 21 Apr 2025 15:28:24 -0700
Message-ID: <20250421222827.283737-20-kuba@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250421222827.283737-1-kuba@kernel.org>
References: <20250421222827.283737-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Move the rx-buf-len config validation to the queue ops.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c     | 40 +++++++++++++++++++
 .../net/ethernet/broadcom/bnxt/bnxt_ethtool.c | 12 ------
 2 files changed, 40 insertions(+), 12 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index 43497b335329..a772ffaf3e5b 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -16052,8 +16052,46 @@ static int bnxt_queue_stop(struct net_device *dev, void *qmem, int idx)
 	return 0;
 }
 
+static int
+bnxt_queue_cfg_validate(struct net_device *dev, int idx,
+			struct netdev_queue_config *qcfg,
+			struct netlink_ext_ack *extack)
+{
+	struct bnxt *bp = netdev_priv(dev);
+
+	/* Older chips need MSS calc so rx_buf_len is not supported,
+	 * but we don't set queue ops for them so we should never get here.
+	 */
+	if (qcfg->rx_buf_len != bp->rx_page_size &&
+	    !(bp->flags & BNXT_FLAG_CHIP_P5_PLUS)) {
+		NL_SET_ERR_MSG_MOD(extack, "changing rx-buf-len not supported");
+		return -EINVAL;
+	}
+
+	if (!is_power_of_2(qcfg->rx_buf_len)) {
+		NL_SET_ERR_MSG_MOD(extack, "rx-buf-len is not power of 2");
+		return -ERANGE;
+	}
+	if (qcfg->rx_buf_len < BNXT_RX_PAGE_SIZE ||
+	    qcfg->rx_buf_len > BNXT_MAX_RX_PAGE_SIZE) {
+		NL_SET_ERR_MSG_MOD(extack, "rx-buf-len out of range");
+		return -ERANGE;
+	}
+	return 0;
+}
+
+static void
+bnxt_queue_cfg_defaults(struct net_device *dev, int idx,
+			struct netdev_queue_config *qcfg)
+{
+	qcfg->rx_buf_len	= BNXT_RX_PAGE_SIZE;
+}
+
 static const struct netdev_queue_mgmt_ops bnxt_queue_mgmt_ops = {
 	.ndo_queue_mem_size	= sizeof(struct bnxt_rx_ring_info),
+
+	.ndo_queue_cfg_defaults	= bnxt_queue_cfg_defaults,
+	.ndo_queue_cfg_validate = bnxt_queue_cfg_validate,
 	.ndo_queue_mem_alloc	= bnxt_queue_mem_alloc,
 	.ndo_queue_mem_free	= bnxt_queue_mem_free,
 	.ndo_queue_start	= bnxt_queue_start,
@@ -16061,6 +16099,8 @@ static const struct netdev_queue_mgmt_ops bnxt_queue_mgmt_ops = {
 };
 
 static const struct netdev_queue_mgmt_ops bnxt_queue_mgmt_ops_unsupp = {
+	.ndo_queue_cfg_defaults	= bnxt_queue_cfg_defaults,
+	.ndo_queue_cfg_validate = bnxt_queue_cfg_validate,
 };
 
 static void bnxt_remove_one(struct pci_dev *pdev)
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
index 956f51449709..8842390f687f 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
@@ -867,18 +867,6 @@ static int bnxt_set_ringparam(struct net_device *dev,
 	if (!kernel_ering->rx_buf_len)	/* Zero means restore default */
 		kernel_ering->rx_buf_len = BNXT_RX_PAGE_SIZE;
 
-	if (kernel_ering->rx_buf_len != bp->rx_page_size &&
-	    !(bp->flags & BNXT_FLAG_CHIP_P5_PLUS)) {
-		NL_SET_ERR_MSG_MOD(extack, "changing rx-buf-len not supported");
-		return -EINVAL;
-	}
-	if (!is_power_of_2(kernel_ering->rx_buf_len) ||
-	    kernel_ering->rx_buf_len < BNXT_RX_PAGE_SIZE ||
-	    kernel_ering->rx_buf_len > BNXT_MAX_RX_PAGE_SIZE) {
-		NL_SET_ERR_MSG_MOD(extack, "rx-buf-len out of range, or not power of 2");
-		return -ERANGE;
-	}
-
 	if (netif_running(dev))
 		bnxt_close_nic(bp, false, false);
 
-- 
2.49.0


