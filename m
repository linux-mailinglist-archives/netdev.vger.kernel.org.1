Return-Path: <netdev+bounces-14099-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 99C1073ED8A
	for <lists+netdev@lfdr.de>; Mon, 26 Jun 2023 23:54:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8208C1C20A15
	for <lists+netdev@lfdr.de>; Mon, 26 Jun 2023 21:54:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 274C4171C6;
	Mon, 26 Jun 2023 21:51:11 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD2F6171B6
	for <netdev@vger.kernel.org>; Mon, 26 Jun 2023 21:51:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80204C433C9;
	Mon, 26 Jun 2023 21:51:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1687816269;
	bh=CSRTy4PQ0cNId7uwcoUAXwDp+NE0nD+oQXLnLuvV1CI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kLs2z7tsbhzGs2zsOxaJWHjD4I1jzB9pEuB0G+SstT9t89S4jdxpANowidwyzix4s
	 e/uWRRUa1MZCzinEwdPHlBNRNbHtq9xyhuA8XNNOL7q3N0GlFQVfgenadUs4ZTMkAY
	 ELwzR5orvGZQ/mPebN7phesbE1LaBplY55IGyCQAVqE48caPWk4rCitTN/ESqoh5xC
	 PjxTBE71BarNJp8JQT8DMhDusZkLmTCL9SI0OE3G9x5VLXubIWG9RjVkKqQTVNjjqE
	 snsIY+0H2ASFd3B2YBg6hb6QdqpFo38HmIuKJCGE+SzBM6qy2aoMdbpwzq71e8jmH1
	 ExRWh058Zt39A==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: David Christensen <drc@linux.vnet.ibm.com>,
	Sridhar Samudrala <sridhar.samudrala@intel.com>,
	"David S . Miller" <davem@davemloft.net>,
	Sasha Levin <sashal@kernel.org>,
	aelior@marvell.com,
	skalluru@marvell.com,
	manishc@marvell.com,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 5.10 2/7] bnx2x: fix page fault following EEH recovery
Date: Mon, 26 Jun 2023 17:51:02 -0400
Message-Id: <20230626215108.179483-2-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230626215108.179483-1-sashal@kernel.org>
References: <20230626215108.179483-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.185
Content-Transfer-Encoding: 8bit

From: David Christensen <drc@linux.vnet.ibm.com>

[ Upstream commit 7ebe4eda4265642859507d1b3ca330d8c196cfe5 ]

In the last step of the EEH recovery process, the EEH driver calls into
bnx2x_io_resume() to re-initialize the NIC hardware via the function
bnx2x_nic_load().  If an error occurs during bnx2x_nic_load(), OS and
hardware resources are released and an error code is returned to the
caller.  When called from bnx2x_io_resume(), the return code is ignored
and the network interface is brought up unconditionally.  Later attempts
to send a packet via this interface result in a page fault due to a null
pointer reference.

This patch checks the return code of bnx2x_nic_load(), prints an error
message if necessary, and does not enable the interface.

Signed-off-by: David Christensen <drc@linux.vnet.ibm.com>
Reviewed-by: Sridhar Samudrala <sridhar.samudrala@intel.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/broadcom/bnx2x/bnx2x_main.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnx2x/bnx2x_main.c b/drivers/net/ethernet/broadcom/bnx2x/bnx2x_main.c
index afb6d3ee1f564..c8cbf3ed128de 100644
--- a/drivers/net/ethernet/broadcom/bnx2x/bnx2x_main.c
+++ b/drivers/net/ethernet/broadcom/bnx2x/bnx2x_main.c
@@ -14372,11 +14372,16 @@ static void bnx2x_io_resume(struct pci_dev *pdev)
 	bp->fw_seq = SHMEM_RD(bp, func_mb[BP_FW_MB_IDX(bp)].drv_mb_header) &
 							DRV_MSG_SEQ_NUMBER_MASK;
 
-	if (netif_running(dev))
-		bnx2x_nic_load(bp, LOAD_NORMAL);
+	if (netif_running(dev)) {
+		if (bnx2x_nic_load(bp, LOAD_NORMAL)) {
+			netdev_err(bp->dev, "Error during driver initialization, try unloading/reloading the driver\n");
+			goto done;
+		}
+	}
 
 	netif_device_attach(dev);
 
+done:
 	rtnl_unlock();
 }
 
-- 
2.39.2


