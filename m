Return-Path: <netdev+bounces-95864-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 258348C3B14
	for <lists+netdev@lfdr.de>; Mon, 13 May 2024 07:48:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D449628166E
	for <lists+netdev@lfdr.de>; Mon, 13 May 2024 05:48:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA8C1146A64;
	Mon, 13 May 2024 05:47:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="CY1e+wNP"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BFFF1465B5;
	Mon, 13 May 2024 05:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715579232; cv=none; b=QiuyPxbg+KVty33+XJSRgAo8sNeXI4AfmVpI1GES4Zxoi10dwMrnd/QzfmOubMt/qO93HXIFIzXsVXT7CV9pYkUtT4aHITKAFhivXNe9BBULJnPkpUO1Ev4QdgzblNE3znawtl3bmJYUfkRTE+dEXPOyUe74qU0s7QOG3VCkz7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715579232; c=relaxed/simple;
	bh=ZQb2+jnuLXwJoGH1fK4C6Xh429KIdyV1ARItZI6ro50=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cLg4n1HSdM+nhy3X+tqcfasE4naaCNJsHtsrt1i4CqlVbDvNL0H2JJ3ZyhVeZwOjWNILWTGmL6RZOgMdqYj7Tf/H7Xtr1FB6T67LxtDy4624Orcho359RTnvGtWmZSjNwFbnK1aIyHyWegmcUiorKQ93kcf7Ct362DHzv33U89w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=CY1e+wNP; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44CLjKqH018797;
	Sun, 12 May 2024 22:47:03 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	pfpt0220; bh=OZvmT2boOq9u2LiX64FnJgQxbVh/mRv404o2yXm+es8=; b=CY1
	e+wNPHELeunGA50eMJYEfzztw0vciWmpPU7xXmOa363HKXrz+NuOUc5eU98KJzLA
	jJvqfHb9Ul/ZxfaUlqvxaDya7tnGdocVwZrPBW0v6PNI1Ns2e4+RzpDT2TrcCpve
	jCkAP/AVMCJPVtYXbWdG4zkajq7kbdXHI6oUCVPk+eCuAJ8gT8sOwckUrzXTFt2n
	3VDl1JpjcxzQQE6xvVBtPU/o6ZlD9YVW7/jpISlfQhC3Rvbl4B83vyVASOUc/miF
	he2uyVpnXhlHa/4z2YgjGf24/SocG+0sKfCGQKk1ZQXhwhsDawnSU2MkZ7JYox1n
	qX6DlFhYVgmBV7B4PdQ==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3y286jb8p7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 12 May 2024 22:47:03 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Sun, 12 May 2024 22:47:01 -0700
Received: from bharat-OptiPlex-3070.marvell.com (10.69.176.80) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server id
 15.2.1544.4 via Frontend Transport; Sun, 12 May 2024 22:46:58 -0700
From: Bharat Bhushan <bbhushan2@marvell.com>
To: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <sgoutham@marvell.com>, <gakula@marvell.com>, <sbhatta@marvell.com>,
        <hkelam@marvell.com>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>
CC: Bharat Bhushan <bbhushan2@marvell.com>
Subject: [PATCH 8/8] cn10k-ipsec: Enable outbound inline ipsec offload
Date: Mon, 13 May 2024 11:16:23 +0530
Message-ID: <20240513054623.270366-9-bbhushan2@marvell.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240513054623.270366-1-bbhushan2@marvell.com>
References: <20240513054623.270366-1-bbhushan2@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: SZjpRS813UyoNJY7Q_fmAacuwnNUMSl5
X-Proofpoint-ORIG-GUID: SZjpRS813UyoNJY7Q_fmAacuwnNUMSl5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-13_04,2024-05-10_02,2023-05-22_02

Hardware is initialized and netdev transmit flow is
hooked up for outbound inline ipsec, so finally enable
ipsec offload.

Signed-off-by: Bharat Bhushan <bbhushan2@marvell.com>
---
 drivers/net/ethernet/marvell/octeontx2/nic/cn10k_ipsec.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/cn10k_ipsec.c b/drivers/net/ethernet/marvell/octeontx2/nic/cn10k_ipsec.c
index 8fbe39458e22..71208582cac0 100644
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


