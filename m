Return-Path: <netdev+bounces-106056-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D432E91479A
	for <lists+netdev@lfdr.de>; Mon, 24 Jun 2024 12:37:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 11AA71C232CA
	for <lists+netdev@lfdr.de>; Mon, 24 Jun 2024 10:37:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEFCE13957B;
	Mon, 24 Jun 2024 10:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="YhPnSIi/"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C960136E35;
	Mon, 24 Jun 2024 10:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719225435; cv=none; b=fXy5Kn5Oz+7AHNoonw0bhEmUJUTPAqFyJQtNxLnwnxH4xlssEB2h+HTFDerXSothvnEVAJrW0aFWhaEvaPefMV0mUDMl6WybTATsUjidTG1E7w4OEbnBvRrt7MPbTF3qNTfE//SG5pBZJRXgQSoA0ddQxVfd4JJMdNDUKkZnMDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719225435; c=relaxed/simple;
	bh=VseqJN/+YdX7EdXXy1Ak04b+vfdfThAK+wj/JCzqAxo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=R/aPB9xh2xONjVDQF7RmRkPeK7KWmDFxOU+zf4XljmBlh55mk+QXMeATifhhI3qc+2Ohl5/QZcfOFYi5u5S32kZ3szLySv9Gm9twIB0zWpC+MQkfW/1VsnjwaX5h2MErbwyFqrKkMkNpXVm/H2CQzpYTU0MznBtXQAy6jJuSaLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=YhPnSIi/; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45OARDOL022070;
	Mon, 24 Jun 2024 03:37:06 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pfpt0220; bh=O
	fKMT+Bn5yvlbkiCLAGLB6E7YPRyUwiInDbp8hNGoxE=; b=YhPnSIi/2CvVixBrH
	EdOHds1AVUXo2k3pBDB1SMDvs12M9hJbEeC7GiQZT92u/Pp2okVwC+6N7LAg3M7a
	tHT83BSD9iNbWK5/FipSZ3eN7/z0ZLLmHzJLihk62zzgQkD3qepgifTE8e8Q2NXI
	QxBNVD6L3IVr1OLtXxta/Q1behPib7Ek6ONy49DwOZblNQl9tIvl5t+gVUGor06X
	7LbRHO8AP2QARZO9ko2CNLQN61O2uyKJMzK8lLQA3+I8vhurpPkWVXKIMWDyEd7f
	M4kx1CI+dPhVzGrn/qWG//lelhfc3EdGA0qR7f8Z39LWbcgl/J8EiihSESngizOT
	3TdTQ==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3yy72f00t9-4
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 24 Jun 2024 03:37:06 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Mon, 24 Jun 2024 03:37:01 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Mon, 24 Jun 2024 03:37:01 -0700
Received: from localhost.localdomain (unknown [10.28.36.166])
	by maili.marvell.com (Postfix) with ESMTP id 6CF403F7079;
	Mon, 24 Jun 2024 03:36:57 -0700 (PDT)
From: Suman Ghosh <sumang@marvell.com>
To: <sgoutham@marvell.com>, <gakula@marvell.com>, <sbhatta@marvell.com>,
        <hkelam@marvell.com>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <lcherian@marvell.com>,
        <jerinj@marvell.com>, <markus.elfring@web.de>
CC: Suman Ghosh <sumang@marvell.com>
Subject: [net PATCH 3/7] octeontx2-af: Fixes klockwork issues in ptp.c
Date: Mon, 24 Jun 2024 16:06:34 +0530
Message-ID: <20240624103638.2087821-4-sumang@marvell.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240624103638.2087821-1-sumang@marvell.com>
References: <20240624103638.2087821-1-sumang@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: mCVELWh2cEvpjboF5NmMt2J5bVloUA95
X-Proofpoint-GUID: mCVELWh2cEvpjboF5NmMt2J5bVloUA95
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-24_09,2024-06-24_01,2024-05-17_01

These are not real issues but sanity checks.

Fixes: 4086f2a06a35 ("octeontx2-af: Add support for Marvell PTP coprocessor")
Signed-off-by: Suman Ghosh <sumang@marvell.com>
---
 drivers/net/ethernet/marvell/octeontx2/af/ptp.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/af/ptp.c b/drivers/net/ethernet/marvell/octeontx2/af/ptp.c
index bcc96eed2481..0be5d22d213b 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/ptp.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/ptp.c
@@ -517,6 +517,7 @@ static int ptp_pps_on(struct ptp *ptp, int on, u64 period)
 static int ptp_probe(struct pci_dev *pdev,
 		     const struct pci_device_id *ent)
 {
+	void __iomem * const *base;
 	struct ptp *ptp;
 	int err;
 
@@ -536,7 +537,15 @@ static int ptp_probe(struct pci_dev *pdev,
 	if (err)
 		goto error_free;
 
-	ptp->reg_base = pcim_iomap_table(pdev)[PCI_PTP_BAR_NO];
+	base = pcim_iomap_table(pdev);
+	if (!base)
+		goto error_free;
+
+	ptp->reg_base = base[PCI_PTP_BAR_NO];
+	if (!ptp->reg_base) {
+		err = -ENODEV;
+		goto error_free;
+	}
 
 	pci_set_drvdata(pdev, ptp);
 	if (!first_ptp_block)
-- 
2.25.1


