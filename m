Return-Path: <netdev+bounces-228566-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 79B7EBCE80E
	for <lists+netdev@lfdr.de>; Fri, 10 Oct 2025 22:43:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 16FE0544C30
	for <lists+netdev@lfdr.de>; Fri, 10 Oct 2025 20:43:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A66032750E1;
	Fri, 10 Oct 2025 20:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="UNcupHq9"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D53FD1DDC33;
	Fri, 10 Oct 2025 20:43:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760128982; cv=none; b=ZQYAfhefrJyjp+P0QEwbqdeDXztDF2uqiykfMSXtEYnaGv0kWIJBjkDCnqkyDi6KMDNR6AgwQ9pfSVfKL8rLlYPLwZjzg1GlpGopt2cOIur11MSjCZHxTWgjLQt8WA4vj45+ND+FB6RkV+KwbGVONNRfGOaQ6jA4bBckEY9QCF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760128982; c=relaxed/simple;
	bh=SWmyU8vAfJAl7JM7RoIxG/43ALVz3UYnrZXUQvZIby4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ivzi92cbt3wu0mSpm1Bo+2Mtus6T+pEaGJSDRmidYtG0mbY7X5BQrG4p7evMzP8ohFDqNQowTmUNQ2JztvvTDnZ6QYeDc/z7KYEjGF+JUTNsUQbJkdjAQMfTyu53IMxoLU+Ua0CIKcnbs0UZWHpXs6ffC6HpDxxUpbllEpRQwRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=UNcupHq9; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59AFtvgB029883;
	Fri, 10 Oct 2025 20:42:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=corp-2025-04-25; bh=FpmfnMx50Z89hypFinEnXSu9g7XfG
	ZrN+jAIv/id1rA=; b=UNcupHq9aPF/yPFzxkM1VMnFwxSZEMS0+OrQ0OBidkvMK
	d633Lj9K2S13lz/okyjVooFc0RFnE1V3CMwWKuMldI+1pVWShjhQzKJHPKOLOiFU
	uhn87pWtppzGwk7rUu3emLptHMYk90konnU0SSuo0IjNZ6OLF6qVgar2lSnq4WoR
	rNsF2bT9UaGkShR08F4mV5JFnV4WVbp6PL/jSv1LdGo8BkampkWKwThHEB7DJJ2e
	QeRA4zU05aBEKj+zhPgihWoa38xKOaZVgW0lpJQ87II8FEpnJlT3nuoMHisbbI51
	PKLZXLhaNM14brA7MRXkE02caEW4Sa6wc2P4kWm5g==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 49nv69ve5c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 10 Oct 2025 20:42:46 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 59AIkL7M036952;
	Fri, 10 Oct 2025 20:42:45 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 49nv65q2fe-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 10 Oct 2025 20:42:45 +0000
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 59AKgink008014;
	Fri, 10 Oct 2025 20:42:44 GMT
Received: from ca-dev112.us.oracle.com (ca-dev112.us.oracle.com [10.129.136.47])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 49nv65q2eu-1;
	Fri, 10 Oct 2025 20:42:44 +0000
From: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
To: Sunil Goutham <sgoutham@marvell.com>, Linu Cherian <lcherian@marvell.com>,
        Geetha sowjanya <gakula@marvell.com>, Jerin Jacob <jerinj@marvell.com>,
        hariprasad <hkelam@marvell.com>,
        Subbaraya Sundeep <sbhatta@marvell.com>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc: dan.carpenter@linaro.org, kernel-janitors@vger.kernel.org,
        error27@gmail.com, harshit.m.mogalapalli@oracle.com
Subject: [PATCH] Octeontx2-af: Fix missing error code in cgx_probe()
Date: Fri, 10 Oct 2025 13:42:39 -0700
Message-ID: <20251010204239.94237-1-harshit.m.mogalapalli@oracle.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-10_05,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 bulkscore=0 mlxlogscore=999
 phishscore=0 spamscore=0 adultscore=0 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510020000
 definitions=main-2510100119
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA4MDEyMSBTYWx0ZWRfX8qpiAakia7C1
 GKaPqawfZyo/SM1nhpguFTX6zgl9y45RHf0FJdB9fMZdd2PLNuiX5OhogiiijldRzv+O+5PgS7f
 2//ND0DWE5aGTeLHRJJMdM9uGQ0H39IWQC1XCcrJU6ME6BtTCPqyE7SX7D9vy2eYcuT/XEiDkSX
 JT5PFtjmiNZpBaJrxq8kC1YJJ44J2tdVgkcnGRgikFTOgvOCNYsh/dY6RilDC2iCWmdxlMMrmzG
 n2/zRd9Vecd2Tgaz8lTYXWedKA9thgXXXgFD8YryKtf3BSsBynGREBsSPlIxEgbCsXQRSY/Vu99
 5GwMWy1HDjaX++RhPVu5HEIV0urelEyhj9wzcAOHhdJMuS7Oh9aswTwE1fpWqB+JfUBq6tX8Bxr
 oiLDrRKOsKTQF+aXbLvg5WG3GEU/XaVa9TiSaFJNMHYMX5QCn9M=
X-Authority-Analysis: v=2.4 cv=dtrWylg4 c=1 sm=1 tr=0 ts=68e96fc6 b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=x6icFKpwvdMA:10 a=VwQbUJbxAAAA:8 a=KKAkSRfTAAAA:8 a=yPCof4ZbAAAA:8
 a=Yqazk3itAgfi9cqaz0UA:9 a=cvBusfyB2V15izCimMoJ:22 cc=ntf awl=host:13624
X-Proofpoint-GUID: _hdJsDoazvxcdO1wPW9vHgV-x98ip4Mf
X-Proofpoint-ORIG-GUID: _hdJsDoazvxcdO1wPW9vHgV-x98ip4Mf

When CGX fails mapping to NIX, set the error code to -ENODEV, currently
err is zero and that is treated as success path.

Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Closes: https://lore.kernel.org/all/aLAdlCg2_Yv7Y-3h@stanley.mountain/
Fixes: d280233fc866 ("Octeontx2-af: Fix NIX X2P calibration failures")
Signed-off-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
---
This is based on static analysis with smatch and only compile tested.
---
 drivers/net/ethernet/marvell/octeontx2/af/cgx.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/marvell/octeontx2/af/cgx.c b/drivers/net/ethernet/marvell/octeontx2/af/cgx.c
index d374a4454836..ec0e11c77cbf 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/cgx.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/cgx.c
@@ -1981,6 +1981,7 @@ static int cgx_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	    !is_cgx_mapped_to_nix(pdev->subsystem_device, cgx->cgx_id)) {
 		dev_notice(dev, "CGX %d not mapped to NIX, skipping probe\n",
 			   cgx->cgx_id);
+		err = -ENODEV;
 		goto err_release_regions;
 	}
 
-- 
2.39.3


