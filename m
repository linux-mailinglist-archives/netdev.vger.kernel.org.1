Return-Path: <netdev+bounces-148827-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 203779E3362
	for <lists+netdev@lfdr.de>; Wed,  4 Dec 2024 06:59:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B4713B270AE
	for <lists+netdev@lfdr.de>; Wed,  4 Dec 2024 05:59:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63690189BA2;
	Wed,  4 Dec 2024 05:57:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="BKUYUl68"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE071191499;
	Wed,  4 Dec 2024 05:57:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733291876; cv=none; b=sfvA6fr+/f+PE/WQus2Ss9h4f/P17h8sVONokvZSOW70rpWtk01JAssiq/felKT6KvMPIapKHkWDPz3XjvQN3hmtXULuYRH2+GQuhjJ/cHMMPVGZ58lpPPi1vYIDh7pKKuT7hmht3HVib5GOnaBnZ7zJ9ZST/Ya+oQm9b2QfJYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733291876; c=relaxed/simple;
	bh=RoVKOTi4vee7XisZhK4JnclTRQrG4lX8Ugnsi5YbdtY=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OHhAl28g6+/7rOTTf+R6kcUM/F7eVlBSIvEadxadp4+GiTowKYUIz1W8uJM9aH/rDDPgIXfCwZHl7x/m8akPNWOpQJNmcHSLTVG7AjCx8Y4Vi8+WgYJDK19tOEHHN/76Thctrv7hRj5j0NmXDUEzFkosLxxXmRT08tQR2lRMvcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=BKUYUl68; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B458qX6008983;
	Tue, 3 Dec 2024 21:57:46 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pfpt0220; bh=K
	fGgzECqEkQesVfm4MAnS/O8BSkAbq8+NigAVvS8kSg=; b=BKUYUl689KSoTJzUo
	xeZGPIHOOvFhnDNy1ZW/sgNkqtcFql4yaf35rpgza/19k9ZuozKdDCh+OIslC6t7
	eDPT5jOM/xa+0LBdJyrZ2H9m9WdgBjjY9DLCav3NaNTIYiiJ4obaAGUBIS8z1826
	FwgW3GF0pu6aAWv9KPCqJotvLLBqsKwFVuZpDoKQi/4OWoI56C8NNuZ9lKGu6eOM
	VRTWvsLmzLEAXPiDwlsMfrE8wQWkz0enFVj13nsfBS2gAjGQeV5PfcpdMga7p3FM
	L5YXF0UxmTqACCgqJVcpWsgjYMmHEgbb3fJmacwT0yMtSu9rYk5d4XLpZvNmMXNc
	qpcuQ==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 43agp682fa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 03 Dec 2024 21:57:46 -0800 (PST)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Tue, 3 Dec 2024 21:57:45 -0800
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Tue, 3 Dec 2024 21:57:45 -0800
Received: from bharat-OptiPlex-Tower-Plus-7020.. (unknown [10.28.34.254])
	by maili.marvell.com (Postfix) with ESMTP id A7C693F7076;
	Tue,  3 Dec 2024 21:57:40 -0800 (PST)
From: Bharat Bhushan <bbhushan2@marvell.com>
To: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <sgoutham@marvell.com>, <gakula@marvell.com>, <sbhatta@marvell.com>,
        <hkelam@marvell.com>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <jerinj@marvell.com>,
        <lcherian@marvell.com>, <ndabilpuram@marvell.com>,
        <andrew+netdev@lunn.ch>, <richardcochran@gmail.com>,
        <bbhushan2@marvell.com>
Subject: [net-next PATCH v10 8/8] cn10k-ipsec: Enable outbound ipsec crypto offload
Date: Wed, 4 Dec 2024 11:26:59 +0530
Message-ID: <20241204055659.1700459-9-bbhushan2@marvell.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241204055659.1700459-1-bbhushan2@marvell.com>
References: <20241204055659.1700459-1-bbhushan2@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: g8HHG0fPgdKtHliwp9H8d10_LpVsmjwa
X-Proofpoint-GUID: g8HHG0fPgdKtHliwp9H8d10_LpVsmjwa
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01

Hardware is initialized and netdev transmit flow is
hooked up for outbound ipsec crypto offload, so finally
enable ipsec offload.

Signed-off-by: Bharat Bhushan <bbhushan2@marvell.com>
---
v2->v3: 
 - Moved "netdev->xfrmdev_ops = &cn10k_ipsec_xfrmdev_ops;" to previous patch
   This fix build error with W=1

 drivers/net/ethernet/marvell/octeontx2/nic/cn10k_ipsec.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/cn10k_ipsec.c b/drivers/net/ethernet/marvell/octeontx2/nic/cn10k_ipsec.c
index e9bf4632695e..c333e04daad3 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/cn10k_ipsec.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/cn10k_ipsec.c
@@ -821,10 +821,10 @@ int cn10k_ipsec_init(struct net_device *netdev)
 		return -ENOMEM;
 	}
 
-	/* Set xfrm device ops
-	 * NETIF_F_HW_ESP is not set as ipsec setup is not yet complete.
-	 */
+	/* Set xfrm device ops */
 	netdev->xfrmdev_ops = &cn10k_ipsec_xfrmdev_ops;
+	netdev->hw_features |= NETIF_F_HW_ESP;
+	netdev->hw_enc_features |= NETIF_F_HW_ESP;
 
 	cn10k_cpt_device_set_unavailable(pf);
 	return 0;
-- 
2.34.1


