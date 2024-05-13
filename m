Return-Path: <netdev+bounces-96002-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0087A8C3F66
	for <lists+netdev@lfdr.de>; Mon, 13 May 2024 12:57:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AA1F91F21A03
	for <lists+netdev@lfdr.de>; Mon, 13 May 2024 10:57:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D178614C581;
	Mon, 13 May 2024 10:55:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="e1dz+aRr"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77EC514AD1C;
	Mon, 13 May 2024 10:55:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715597752; cv=none; b=Cs+X64XZszerEAsjroFtc+sRhWAoier0tofVoSkARRQaXySct8u9m6ngcddJob3HuWG1wQ4c+VlEYUsyB00aJFEUB8Hj+It20B8TjDEC6qQDE6Wk2b/jPwx25PZV1fBc/YDzbFOp+uei99a1Kro0avWSioQkBjrlP7y+msWYl2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715597752; c=relaxed/simple;
	bh=T24MM4FTYzjlR7AqvBt8nL8doXCXzCbcRr8aceftZ6I=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=co7Fkt6KJNQ7iKeTaVKGFPP6ndhnPC1MY00C56+f9caKJ1MHHj43CiAQ9sY9j9WcN1P3FadrJEunKH07uTaVBivv7+STxTYAGE6kDQA6y3v7JA69msCM43u17No56jWa4P42Wmyulv9hJwCaPhpZMm47IYWB1eTv8e12nFIGGBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=e1dz+aRr; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44D9fi2L014208;
	Mon, 13 May 2024 03:55:40 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	pfpt0220; bh=/IKQPQtPqub7ui+Etnnt9AHQ6GA4voprL9sZu9yb3zk=; b=e1d
	z+aRr9/TobjsL/K4fILzkp3/N4ODn0e8enyNpY7hwCTZ2D1xHPBo9qJ6XdTpJ0Br
	EHOiQ6AOqRV0jgWz5kGLKSPq3a2mh/yQLiScuDGnUxQj8f9SAcRCgyNkoVvRAooN
	9kWloHRXkmyAP0V/xNVL41hj2xJOw4cwMSDaGsBppYTqVfSkB8ctrBi+81HGEpHh
	KA5KjCVS21j7bGvD0Vp5aaN5VoL2RAqWyFaGEc1v5XRH9Oq1GQ+KMe9XhQsd7hhx
	wRR/63DHzwb9b91Bih81zIet648H2T/TdAuzIfKfvUQcZP2latBx8hdEfDAFTQou
	TB1GFtNT2Ct0oReEkAg==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3y3gf4g5k1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 13 May 2024 03:55:40 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Mon, 13 May 2024 03:55:39 -0700
Received: from bharat-OptiPlex-3070.marvell.com (10.69.176.80) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server id
 15.2.1544.4 via Frontend Transport; Mon, 13 May 2024 03:55:34 -0700
From: Bharat Bhushan <bbhushan2@marvell.com>
To: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <sgoutham@marvell.com>, <gakula@marvell.com>, <sbhatta@marvell.com>,
        <hkelam@marvell.com>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <jerinj@marvell.com>,
        <lcherian@marvell.com>, <richardcochran@gmail.com>
CC: Bharat Bhushan <bbhushan2@marvell.com>
Subject: [net-next,v2 8/8] cn10k-ipsec: Enable outbound inline ipsec offload
Date: Mon, 13 May 2024 16:24:46 +0530
Message-ID: <20240513105446.297451-9-bbhushan2@marvell.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240513105446.297451-1-bbhushan2@marvell.com>
References: <20240513105446.297451-1-bbhushan2@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: -F4mAbDP0HBLuP3rXdrF8-YBcbzPNbyy
X-Proofpoint-GUID: -F4mAbDP0HBLuP3rXdrF8-YBcbzPNbyy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-13_07,2024-05-10_02,2023-05-22_02

Hardware is initialized and netdev transmit flow is
hooked up for outbound inline ipsec, so finally enable
ipsec offload.

Signed-off-by: Bharat Bhushan <bbhushan2@marvell.com>
---
 drivers/net/ethernet/marvell/octeontx2/nic/cn10k_ipsec.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/cn10k_ipsec.c b/drivers/net/ethernet/marvell/octeontx2/nic/cn10k_ipsec.c
index 5375bffe8a90..d57bd56299c1 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/cn10k_ipsec.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/cn10k_ipsec.c
@@ -825,6 +825,11 @@ int cn10k_ipsec_init(struct net_device *netdev)
 	memset(pf->ipsec.outb_sa->base, 0, sa_size * CN10K_IPSEC_OUTB_MAX_SA);
 	bitmap_zero(pf->ipsec.sa_bitmap, CN10K_IPSEC_OUTB_MAX_SA);
 
+	/* Set xfrm device ops */
+	netdev->xfrmdev_ops = &cn10k_ipsec_xfrmdev_ops;
+	netdev->hw_features |= NETIF_F_HW_ESP;
+	netdev->hw_enc_features |= NETIF_F_HW_ESP;
+
 	mutex_init(&pf->ipsec.lock);
 	return 0;
 }
-- 
2.34.1


