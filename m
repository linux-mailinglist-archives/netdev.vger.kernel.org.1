Return-Path: <netdev+bounces-46461-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C1CE67E4459
	for <lists+netdev@lfdr.de>; Tue,  7 Nov 2023 16:52:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AA9DD1C20D5C
	for <lists+netdev@lfdr.de>; Tue,  7 Nov 2023 15:52:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A72C31A74;
	Tue,  7 Nov 2023 15:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O3T73U15"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FC1E31A73
	for <netdev@vger.kernel.org>; Tue,  7 Nov 2023 15:52:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BDA8C433C8;
	Tue,  7 Nov 2023 15:52:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699372344;
	bh=Y+8mRrkWRM7PClGF+WGyXe3kK3zrXr/PDvE40lBrRKQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=O3T73U15aXv3FRmr/wtVAgyINEVMM+JgaHGSNOySW7xNQ4mNYnX+LPDXZPZAaG3KW
	 olyrsrQp28ZOSMaROqw/8nbqGbx5qsfecO4msbf7o3FgN5htW8rVk7P17f2mDZjOiJ
	 w0+cuQcS5wbSboVJVqfx3zHRsZ6idIvuD02nsWqEjeFClHWRLbpM+zlQ1bceJn+6IS
	 oglKJwnvoN2hcYvcqIr3bcexXWzO0NmNou18g948ykDrKzp5l5wP0SIGWd4lwHyxaa
	 GyBdDIcTtGvis2XExiMtxaXwryGIBfkeE+pThZsMr6WfDyQVADbN1oufTPpeHbRPxr
	 Ynae0sATdjqCQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Wenchao Hao <haowenchao2@huawei.com>,
	Simon Horman <horms@kernel.org>,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	Sasha Levin <sashal@kernel.org>,
	hare@suse.de,
	jejb@linux.ibm.com,
	richardcochran@gmail.com,
	linux-scsi@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 5.15 15/22] scsi: libfc: Fix potential NULL pointer dereference in fc_lport_ptp_setup()
Date: Tue,  7 Nov 2023 10:51:24 -0500
Message-ID: <20231107155146.3767610-15-sashal@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231107155146.3767610-1-sashal@kernel.org>
References: <20231107155146.3767610-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.137
Content-Transfer-Encoding: 8bit

From: Wenchao Hao <haowenchao2@huawei.com>

[ Upstream commit 4df105f0ce9f6f30cda4e99f577150d23f0c9c5f ]

fc_lport_ptp_setup() did not check the return value of fc_rport_create()
which can return NULL and would cause a NULL pointer dereference. Address
this issue by checking return value of fc_rport_create() and log error
message on fc_rport_create() failed.

Signed-off-by: Wenchao Hao <haowenchao2@huawei.com>
Link: https://lore.kernel.org/r/20231011130350.819571-1-haowenchao2@huawei.com
Reviewed-by: Simon Horman <horms@kernel.org>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/scsi/libfc/fc_lport.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/scsi/libfc/fc_lport.c b/drivers/scsi/libfc/fc_lport.c
index 19cd4a95d354d..d158c5eff059b 100644
--- a/drivers/scsi/libfc/fc_lport.c
+++ b/drivers/scsi/libfc/fc_lport.c
@@ -241,6 +241,12 @@ static void fc_lport_ptp_setup(struct fc_lport *lport,
 	}
 	mutex_lock(&lport->disc.disc_mutex);
 	lport->ptp_rdata = fc_rport_create(lport, remote_fid);
+	if (!lport->ptp_rdata) {
+		printk(KERN_WARNING "libfc: Failed to setup lport 0x%x\n",
+			lport->port_id);
+		mutex_unlock(&lport->disc.disc_mutex);
+		return;
+	}
 	kref_get(&lport->ptp_rdata->kref);
 	lport->ptp_rdata->ids.port_name = remote_wwpn;
 	lport->ptp_rdata->ids.node_name = remote_wwnn;
-- 
2.42.0


