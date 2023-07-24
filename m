Return-Path: <netdev+bounces-20221-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BE8DA75E61E
	for <lists+netdev@lfdr.de>; Mon, 24 Jul 2023 03:15:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC5EB2814BC
	for <lists+netdev@lfdr.de>; Mon, 24 Jul 2023 01:15:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32A277FA;
	Mon, 24 Jul 2023 01:15:14 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D97097E8
	for <netdev@vger.kernel.org>; Mon, 24 Jul 2023 01:15:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 898D4C433C8;
	Mon, 24 Jul 2023 01:15:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690161312;
	bh=nWokQeMtYUr7Atw3bnVpcMn4iJqjdFJHeSpzyXBlRqY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Zx6rtNkVXlMv7bhs8YY3FKMUbB/pSUND/E4rxCwnz8xtkjVGLqZNvLea/Kl4bVHAo
	 OZ2+FLi106xZ2arh/QJrfPf81E18CwgcY4TRUuhto6OiNS5mc4urVbE9huTWW6zCpP
	 t4pTk7F1hQssw7Rj1lAK8iCluGlfwEzH8m/SFB61U89uGsCs1KxkIcMjFnzs+2DBRX
	 utbuGv2+BDs4rJmbhwx8FetjgOrLwtBByY3J+VbmkM0xs1BUxmZwTxrZe6XBdEcoZj
	 IaTWAuwWw2FZ2oNybka+uvMMEEZhGolhdvS765AnjVIoc0ORFawjuYRWMqoFuHdPJA
	 AlxDyvt9Km1Dg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Long Li <longli@microsoft.com>,
	Jason Gunthorpe <jgg@nvidia.com>,
	Sasha Levin <sashal@kernel.org>,
	sharmaajay@microsoft.com,
	kys@microsoft.com,
	haiyangz@microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	tglx@linutronix.de,
	alardam@gmail.com,
	shradhagupta@linux.microsoft.com,
	linux-rdma@vger.kernel.org,
	linux-hyperv@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 6.4 20/58] RDMA/mana_ib: Use v2 version of cfg_rx_steer_req to enable RX coalescing
Date: Sun, 23 Jul 2023 21:12:48 -0400
Message-Id: <20230724011338.2298062-20-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230724011338.2298062-1-sashal@kernel.org>
References: <20230724011338.2298062-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.4.5
Content-Transfer-Encoding: 8bit

From: Long Li <longli@microsoft.com>

[ Upstream commit 2145328515c8fa9b8a9f7889250bc6c032f2a0e6 ]

With RX coalescing, one CQE entry can be used to indicate multiple packets
on the receive queue. This saves processing time and PCI bandwidth over
the CQ.

The MANA Ethernet driver also uses the v2 version of the protocol. It
doesn't use RX coalescing and its behavior is not changed.

Link: https://lore.kernel.org/r/1684045095-31228-1-git-send-email-longli@linuxonhyperv.com
Signed-off-by: Long Li <longli@microsoft.com>
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/infiniband/hw/mana/qp.c               | 5 ++++-
 drivers/net/ethernet/microsoft/mana/mana_en.c | 5 ++++-
 include/net/mana/mana.h                       | 4 +++-
 3 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/drivers/infiniband/hw/mana/qp.c b/drivers/infiniband/hw/mana/qp.c
index 54b61930a7fdb..4b3b5b274e849 100644
--- a/drivers/infiniband/hw/mana/qp.c
+++ b/drivers/infiniband/hw/mana/qp.c
@@ -13,7 +13,7 @@ static int mana_ib_cfg_vport_steering(struct mana_ib_dev *dev,
 				      u8 *rx_hash_key)
 {
 	struct mana_port_context *mpc = netdev_priv(ndev);
-	struct mana_cfg_rx_steer_req *req = NULL;
+	struct mana_cfg_rx_steer_req_v2 *req;
 	struct mana_cfg_rx_steer_resp resp = {};
 	mana_handle_t *req_indir_tab;
 	struct gdma_context *gc;
@@ -33,6 +33,8 @@ static int mana_ib_cfg_vport_steering(struct mana_ib_dev *dev,
 	mana_gd_init_req_hdr(&req->hdr, MANA_CONFIG_VPORT_RX, req_buf_size,
 			     sizeof(resp));
 
+	req->hdr.req.msg_version = GDMA_MESSAGE_V2;
+
 	req->vport = mpc->port_handle;
 	req->rx_enable = 1;
 	req->update_default_rxobj = 1;
@@ -46,6 +48,7 @@ static int mana_ib_cfg_vport_steering(struct mana_ib_dev *dev,
 	req->num_indir_entries = MANA_INDIRECT_TABLE_SIZE;
 	req->indir_tab_offset = sizeof(*req);
 	req->update_indir_tab = true;
+	req->cqe_coalescing_enable = 1;
 
 	req_indir_tab = (mana_handle_t *)(req + 1);
 	/* The ind table passed to the hardware must have
diff --git a/drivers/net/ethernet/microsoft/mana/mana_en.c b/drivers/net/ethernet/microsoft/mana/mana_en.c
index d907727c7b7a5..7f4e861e398e6 100644
--- a/drivers/net/ethernet/microsoft/mana/mana_en.c
+++ b/drivers/net/ethernet/microsoft/mana/mana_en.c
@@ -972,7 +972,7 @@ static int mana_cfg_vport_steering(struct mana_port_context *apc,
 				   bool update_tab)
 {
 	u16 num_entries = MANA_INDIRECT_TABLE_SIZE;
-	struct mana_cfg_rx_steer_req *req = NULL;
+	struct mana_cfg_rx_steer_req_v2 *req;
 	struct mana_cfg_rx_steer_resp resp = {};
 	struct net_device *ndev = apc->ndev;
 	mana_handle_t *req_indir_tab;
@@ -987,6 +987,8 @@ static int mana_cfg_vport_steering(struct mana_port_context *apc,
 	mana_gd_init_req_hdr(&req->hdr, MANA_CONFIG_VPORT_RX, req_buf_size,
 			     sizeof(resp));
 
+	req->hdr.req.msg_version = GDMA_MESSAGE_V2;
+
 	req->vport = apc->port_handle;
 	req->num_indir_entries = num_entries;
 	req->indir_tab_offset = sizeof(*req);
@@ -996,6 +998,7 @@ static int mana_cfg_vport_steering(struct mana_port_context *apc,
 	req->update_hashkey = update_key;
 	req->update_indir_tab = update_tab;
 	req->default_rxobj = apc->default_rxobj;
+	req->cqe_coalescing_enable = 0;
 
 	if (update_key)
 		memcpy(&req->hashkey, apc->hashkey, MANA_HASH_KEY_SIZE);
diff --git a/include/net/mana/mana.h b/include/net/mana/mana.h
index 9eef199728454..024ad8ddb27e5 100644
--- a/include/net/mana/mana.h
+++ b/include/net/mana/mana.h
@@ -579,7 +579,7 @@ struct mana_fence_rq_resp {
 }; /* HW DATA */
 
 /* Configure vPort Rx Steering */
-struct mana_cfg_rx_steer_req {
+struct mana_cfg_rx_steer_req_v2 {
 	struct gdma_req_hdr hdr;
 	mana_handle_t vport;
 	u16 num_indir_entries;
@@ -592,6 +592,8 @@ struct mana_cfg_rx_steer_req {
 	u8 reserved;
 	mana_handle_t default_rxobj;
 	u8 hashkey[MANA_HASH_KEY_SIZE];
+	u8 cqe_coalescing_enable;
+	u8 reserved2[7];
 }; /* HW DATA */
 
 struct mana_cfg_rx_steer_resp {
-- 
2.39.2


