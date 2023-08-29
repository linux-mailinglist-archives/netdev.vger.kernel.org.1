Return-Path: <netdev+bounces-31273-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6396178C636
	for <lists+netdev@lfdr.de>; Tue, 29 Aug 2023 15:37:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 93D8D1C20AAD
	for <lists+netdev@lfdr.de>; Tue, 29 Aug 2023 13:37:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F17F118034;
	Tue, 29 Aug 2023 13:34:12 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C20861802A
	for <netdev@vger.kernel.org>; Tue, 29 Aug 2023 13:34:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BB6EC433C8;
	Tue, 29 Aug 2023 13:34:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1693316051;
	bh=d++qrcyCX3Wo8nR+pvjWdX7UvJMPR9fuWUS5a6dciUI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jRVuL9/BSjYDTXq9GxDLSQSmYixFmhOs1n7ztHQsMMeHb/GbIe2PGbjTJrVugjRHj
	 dHM6TmU7H/NWGjpRItDh8GcSSZk0jaA08MOgfieWKuzkfuwRJECGFw0rO8GRENlZbu
	 RccfHL6NW//WOmTeOljtnhiS8IQDG6cUHGzJTI0YCkG5y/w8Dy7pPLtxxsnuK2dMlB
	 SB6bPU2GtBzl0xQ9N2MlI/6H9aeg6vOi9RYG6zkh717o0tGolu2qvgphW9yO1AYT7C
	 KCwFlBu9KbmZXPcDr8d5+FE+oeIR3A/riwENwNVOMNoKpcgT/qAGQ4Z5fCyvgQbv+Z
	 K90w6F7sEDiSA==
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
Subject: [PATCH AUTOSEL 4.19 2/5] bnx2x: fix page fault following EEH recovery
Date: Tue, 29 Aug 2023 09:34:03 -0400
Message-Id: <20230829133406.520756-2-sashal@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230829133406.520756-1-sashal@kernel.org>
References: <20230829133406.520756-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 4.19.292
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
index 91ddde4d647c6..d21b22ed0b60a 100644
--- a/drivers/net/ethernet/broadcom/bnx2x/bnx2x_main.c
+++ b/drivers/net/ethernet/broadcom/bnx2x/bnx2x_main.c
@@ -14464,11 +14464,16 @@ static void bnx2x_io_resume(struct pci_dev *pdev)
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
2.40.1


