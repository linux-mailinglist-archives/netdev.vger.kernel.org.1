Return-Path: <netdev+bounces-102879-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01D9290541E
	for <lists+netdev@lfdr.de>; Wed, 12 Jun 2024 15:48:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AFEA7287090
	for <lists+netdev@lfdr.de>; Wed, 12 Jun 2024 13:48:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF94317E913;
	Wed, 12 Jun 2024 13:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="jDWVnBWP"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52AC017DE21;
	Wed, 12 Jun 2024 13:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718200042; cv=none; b=MWax3ITeAd9fgSpFyLZkCeXym+WbtdAqbijFLl5QfewdqbCbRrtQsVtHrBsR6lyzK6ZHe0LDEF5ww6iH1w9UqnhKxEJ9h9gJzM7YNR1KU/kE3ojwlKWDRRXvqnCVWycM5V2hUjq1wS3qofQvh44jLDpiD602L9W/MnU4jaPtyNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718200042; c=relaxed/simple;
	bh=ssO7AKWWivH47PjBUEnD2sxOQ+qNcu2ycHUxzLGTkG8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qIGhbJOsZPq/5KZgC21nrXDSw1HPsl+wIVHHejFZUMpgKXWIe9XEhBUulk2Y7/aMetQ7ea7ErO0KUfowniK/V21aIj3MNWIKyRiauBwg4ND/fuFz6GaXgdOWWe/q5ak31HwRBhQP/fKGQ4IPgQy/9nVRZhtMJLfJ72C+pG2MV+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=jDWVnBWP; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45CAbXfl016569;
	Wed, 12 Jun 2024 06:47:15 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pfpt0220; bh=z
	oGMLhEyENm8ED2Ued36MhzDnQs894Cs5YQDHOvSeys=; b=jDWVnBWPh4DyKHkXz
	MWi1lYptmIuLHMCUNS1GgORk7OLZjMp500lGxtZW3fh60XEarAflPGzVoqyxNKEl
	ycuQTBOPLqwcXz2A6ai9CaAd3N/BVd299pRrzv2fk/g3JCSU7pKCs4wdTGfU1jMO
	9ODjv3wZXtWAX+D6r7/RfEihNmuUIAIyYcgUnfnr3Ij8d1L9aHAIgsivfZCRh7VP
	LYYded9gd22NX4ub9XZpkecpU3YDPXr90rmmB2YavItUMZwt5SLIiZRjF7RlVCj7
	2ebyJ5MdNlIw3uYVVZjtHPsHHxPRyn0VB0EF7vz1pBgsabRPOFbjiULuqlk9a4Q2
	iWhew==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3yq8qx0u6d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Jun 2024 06:47:15 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Wed, 12 Jun 2024 06:47:13 -0700
Received: from bharat-OptiPlex-3070.marvell.com (10.69.176.80) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server id
 15.2.1544.4 via Frontend Transport; Wed, 12 Jun 2024 06:47:09 -0700
From: Bharat Bhushan <bbhushan2@marvell.com>
To: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <sgoutham@marvell.com>, <gakula@marvell.com>, <sbhatta@marvell.com>,
        <hkelam@marvell.com>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <jerinj@marvell.com>,
        <lcherian@marvell.com>, <richardcochran@gmail.com>
CC: <bbhushan2@marvell.com>
Subject: [net-next,v4 8/8] cn10k-ipsec: Enable outbound inline ipsec offload
Date: Wed, 12 Jun 2024 19:16:22 +0530
Message-ID: <20240612134622.2157086-9-bbhushan2@marvell.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240612134622.2157086-1-bbhushan2@marvell.com>
References: <20240612134622.2157086-1-bbhushan2@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: 3Q-rvt5VIOhAQJC59E0TuUqujtnqJAOl
X-Proofpoint-ORIG-GUID: 3Q-rvt5VIOhAQJC59E0TuUqujtnqJAOl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-12_07,2024-06-12_02,2024-05-17_01

Hardware is initialized and netdev transmit flow is
hooked up for outbound inline ipsec, so finally enable
ipsec offload.

Signed-off-by: Bharat Bhushan <bbhushan2@marvell.com>
---
v2->v3: 
 - Moved "netdev->xfrmdev_ops = &cn10k_ipsec_xfrmdev_ops;" to previous patch
   This fix build error with W=1

 drivers/net/ethernet/marvell/octeontx2/nic/cn10k_ipsec.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/cn10k_ipsec.c b/drivers/net/ethernet/marvell/octeontx2/nic/cn10k_ipsec.c
index 2f63d91db9ad..4a8bbb6b2b91 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/cn10k_ipsec.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/cn10k_ipsec.c
@@ -845,10 +845,10 @@ int cn10k_ipsec_init(struct net_device *netdev)
 	memset(pf->ipsec.outb_sa->base, 0, sa_size * CN10K_IPSEC_OUTB_MAX_SA);
 	bitmap_zero(pf->ipsec.sa_bitmap, CN10K_IPSEC_OUTB_MAX_SA);
 
-	/* Set xfrm device ops
-	 * NETIF_F_HW_ESP is not set as ipsec setup is not yet complete.
-	 */
+	/* Set xfrm device ops */
 	netdev->xfrmdev_ops = &cn10k_ipsec_xfrmdev_ops;
+	netdev->hw_features |= NETIF_F_HW_ESP;
+	netdev->hw_enc_features |= NETIF_F_HW_ESP;
 
 	mutex_init(&pf->ipsec.lock);
 	return 0;
-- 
2.34.1


