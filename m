Return-Path: <netdev+bounces-46458-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E5127E4439
	for <lists+netdev@lfdr.de>; Tue,  7 Nov 2023 16:51:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 47EE51C20B3D
	for <lists+netdev@lfdr.de>; Tue,  7 Nov 2023 15:51:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4234231A60;
	Tue,  7 Nov 2023 15:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H41/10qp"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25A3F315A4
	for <netdev@vger.kernel.org>; Tue,  7 Nov 2023 15:51:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9F81C433C7;
	Tue,  7 Nov 2023 15:51:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699372274;
	bh=zelHw0MvsgMhJEF3TCNNAeS+IjZM0jqwzwLJAQ/4FE4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=H41/10qpP0BhL+FXevapZspjYjUHdoefCKWi8SiUJUlt317XfQP1jsAPkcZhSzi7O
	 B5iDfOWSyxC86xNlCEECnpB9lDruhve8kjgPNoECGYjBe2bQs+Qrj0j75petzcVe7D
	 G6i1iMUX5F1OUnV8vFUXIEzTLDC2T76euOIlMshqeQ5FEeQ5pFsyReQR3EeadN6t64
	 APYATsNV+OsRHZ/BsjU9kT3nx7gCu/TMlk18cls70eQ6qm1uFFrIIw+mJXGSNC+3SI
	 HUaUhqowesBn3ZQwxRIt6FgWVbPrW5gioF/Ym8KU5YgfcMpHqxpv2nuLzO2e9eJf//
	 d7mKbXqMifvew==
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
Subject: [PATCH AUTOSEL 6.1 20/30] scsi: libfc: Fix potential NULL pointer dereference in fc_lport_ptp_setup()
Date: Tue,  7 Nov 2023 10:49:54 -0500
Message-ID: <20231107155024.3766950-20-sashal@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231107155024.3766950-1-sashal@kernel.org>
References: <20231107155024.3766950-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.61
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
index 9c02c9523c4d4..ab06e9aeb613e 100644
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


