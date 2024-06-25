Return-Path: <netdev+bounces-106606-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 637A3916F58
	for <lists+netdev@lfdr.de>; Tue, 25 Jun 2024 19:35:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0CA6C1F2249F
	for <lists+netdev@lfdr.de>; Tue, 25 Jun 2024 17:35:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69DCA17624B;
	Tue, 25 Jun 2024 17:34:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="OoK0ZjwL"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E26E8176225;
	Tue, 25 Jun 2024 17:34:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719336869; cv=none; b=h+tAMi1V2fBMsQjO9TQJz4VR+BZIdceeiWSckrnD0UA0eBw3JUrqlabJTtr4ps34YD5rc33MeOnzng5y/pMVlwc5HVRRIGjbd6xhe1dpQWD0K1plZiJPM0QHwX7ZHl07TX1Ra9Cvs7Kt8TkvGa8Yyxg+VTZtuXDiOq7vgesiH04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719336869; c=relaxed/simple;
	bh=bkFXXtybeIIeB2Aly3JWUWb9QAZ4GZQdcOk755ZIB9Y=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UZRhjuTxGNcQ142h2WD3zgFU38PkjriPAg+cDVg9HtE/xautLJrOB6/r2VVhLgO0eKXKRbkrl4aOW1ULkqlPzo626Gx4pQFBV079qOFgl4cby9niUk4SobT6FHnZaqEKeUjkIEWB1Ii8YLcRHZESoYp4/YBB2lBCteM3tqToTIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=OoK0ZjwL; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45PBtVs2001297;
	Tue, 25 Jun 2024 10:34:21 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pfpt0220; bh=7
	GAHobpstThpXVRaOFsKpqXzXf99LKM0bNB7ZDQ7cYU=; b=OoK0ZjwLKDMqjduhc
	y9xovMT6z9b9fOF2/Qh9w8HcPEEe0vpRYECWqWJwm8JjrHYjm1dd5E2+7EDgbyAF
	5QvKjIcxROaQ7tw7tzGVdat38+gxTCLMsuaunymEOCZkH/NpMrOYfRdl8Kc8y2JX
	2K4QIEYtacLXPqzBEOHTohLFvsn6e6kmx4yAOaVrQN4IiRb4fb1tgPdIQnilIjNK
	42fY7eSW2B0wXSVm8j819uak2Tgq3rten2wT377+Xt4EAbYwfz51yHju9GroWzTM
	FeJttJ9V6UQ/DlcvFiGqzdkRtzFY1NaFtQZDqcvrG02xdw4s2vvtKqQEL20aIPak
	dJWww==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3yywec9kj1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 25 Jun 2024 10:34:21 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Tue, 25 Jun 2024 10:34:19 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Tue, 25 Jun 2024 10:34:19 -0700
Received: from localhost.localdomain (unknown [10.28.36.166])
	by maili.marvell.com (Postfix) with ESMTP id AB7563F707D;
	Tue, 25 Jun 2024 10:34:15 -0700 (PDT)
From: Suman Ghosh <sumang@marvell.com>
To: <sgoutham@marvell.com>, <gakula@marvell.com>, <sbhatta@marvell.com>,
        <hkelam@marvell.com>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <lcherian@marvell.com>,
        <jerinj@marvell.com>, <markus.elfring@web.de>
CC: Suman Ghosh <sumang@marvell.com>
Subject: [net PATCH v2 3/7] octeontx2-af: Fixes klockwork issues in ptp.c
Date: Tue, 25 Jun 2024 23:03:46 +0530
Message-ID: <20240625173350.1181194-5-sumang@marvell.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240625173350.1181194-1-sumang@marvell.com>
References: <20240625173350.1181194-1-sumang@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: taMw7Hfxg28YSwJM13yhG8jwMffnr_mS
X-Proofpoint-GUID: taMw7Hfxg28YSwJM13yhG8jwMffnr_mS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-25_12,2024-06-25_01,2024-05-17_01

Some variable was getting accessed without NULL checks
which can lead to pointer exception in some erroneous scenarios.
This patch fixes the same by adding the required NULL checks.

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


