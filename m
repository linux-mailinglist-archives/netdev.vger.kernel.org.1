Return-Path: <netdev+bounces-152108-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0664C9F2B58
	for <lists+netdev@lfdr.de>; Mon, 16 Dec 2024 09:01:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1EDD7188A055
	for <lists+netdev@lfdr.de>; Mon, 16 Dec 2024 08:01:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 705721FF7D4;
	Mon, 16 Dec 2024 07:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="LQJbQ9uB"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC1451FF7D9;
	Mon, 16 Dec 2024 07:59:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734335954; cv=none; b=j+MPbwAPl6gSun4Z5fQ5L2K0MqtsmPmqVQJ0L3znnlQKI/oGZDf9F7zvdyGlWkRj/wCjCdhH8coIv3XX9ZaGRj2xMtXoclcN4/rudrbItnVL8tt2rvBuW45hj2sSzDwRnd0w85hIeUAcaUoTW3xRc4hUghef9lchgxPQ/a1TcGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734335954; c=relaxed/simple;
	bh=L+Gtdbhy8yJh5XdrYNJ13jqwvCm+XEUIvr8CJlYQyyQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=us+cHkLKlBvy5zzv3dSdB+77MvBsQmoaPCbZXXnRTlk7ptR68AosBV+yTgl4s2qnojaVhEa+y5Vsfn8/Wh1QEboFvcxF05wYjjcbBbatQN9D3E4ToptCgkDlB7SGbfgZOdh+n58kIrbv1pu07s55p7pKbFLNbXoNboSowtAaSWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=LQJbQ9uB; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BG7CEF2012568;
	Sun, 15 Dec 2024 23:58:51 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pfpt0220; bh=O
	M+al3o6cApvisGFEdMKQ3up9fNrnhkiTr2tJcYTiUQ=; b=LQJbQ9uB2NHECN3+x
	qE6BVyKQJOxR53dnEkn0+P9/XWu7x/8N7FXfxPcs22SM6kqRqvJnW3/6S4LwNRbk
	+3bJJntQF8pSX0DN9SPn3r5iymYv2Kcql2j3cYCfkpIFCxRXQtwr3YRklyXIuSYz
	eZB9sZlrEkLzo1wJ+emiy8Q2T0KDp8f4ki4fDrarrSZSLHxWlJTpUt+LbNv/jzea
	dawyPt/ryd7im+77An36D68nOQdngTNv00Lrf5H/wJHeOr7JWWiSL1IxVi5ymMNU
	GvKMHWeq9KbRaswgEYhMfi8fiZJeF+7umhaP8wqYyiSx9HJn1eBbZT/46VDtKay2
	HVuLg==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 43j6am85uv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 15 Dec 2024 23:58:51 -0800 (PST)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Sun, 15 Dec 2024 23:58:50 -0800
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Sun, 15 Dec 2024 23:58:50 -0800
Received: from ubuntu-PowerEdge-T110-II.sclab.marvell.com (unknown [10.106.27.86])
	by maili.marvell.com (Postfix) with ESMTP id ECB513F708E;
	Sun, 15 Dec 2024 23:58:49 -0800 (PST)
From: Shinas Rasheed <srasheed@marvell.com>
To: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <hgani@marvell.com>, <sedara@marvell.com>, <vimleshk@marvell.com>,
        <thaller@redhat.com>, <wizhao@redhat.com>, <kheib@redhat.com>,
        <konguyen@redhat.com>, <horms@kernel.org>, <einstein.xue@synaxg.com>,
        "Shinas
 Rasheed" <srasheed@marvell.com>,
        Veerasenareddy Burru <vburru@marvell.com>,
        Satananda Burla <sburla@marvell.com>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH net v2 3/4] octeon_ep_vf: fix race conditions in ndo_get_stats64
Date: Sun, 15 Dec 2024 23:58:41 -0800
Message-ID: <20241216075842.2394606-4-srasheed@marvell.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241216075842.2394606-1-srasheed@marvell.com>
References: <20241216075842.2394606-1-srasheed@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: JS8Nc-C82QeJjlorOwMUDxobu1Wl74Fe
X-Proofpoint-ORIG-GUID: JS8Nc-C82QeJjlorOwMUDxobu1Wl74Fe
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.687,Hydra:6.0.235,FMLib:17.0.607.475
 definitions=2020-10-13_15,2020-10-13_02,2020-04-07_01

ndo_get_stats64() can race with ndo_stop(), which frees input and
output queue resources. Call synchornize_net() in ndo_stop()
to avoid such races.

Fixes: c3fad23cdc06 ("octeon_ep_vf: add support for ndo ops")
Signed-off-by: Shinas Rasheed <srasheed@marvell.com>
---
V2:
  - Changed sync mechanism to fix race conditions from using an atomic
    set_bit ops to a much simpler synchronize_net()

V1: https://lore.kernel.org/all/20241203072130.2316913-4-srasheed@marvell.com/

 drivers/net/ethernet/marvell/octeon_ep_vf/octep_vf_main.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/marvell/octeon_ep_vf/octep_vf_main.c b/drivers/net/ethernet/marvell/octeon_ep_vf/octep_vf_main.c
index 7e6771c9cdbb..e6253f85b623 100644
--- a/drivers/net/ethernet/marvell/octeon_ep_vf/octep_vf_main.c
+++ b/drivers/net/ethernet/marvell/octeon_ep_vf/octep_vf_main.c
@@ -523,6 +523,7 @@ static int octep_vf_stop(struct net_device *netdev)
 {
 	struct octep_vf_device *oct = netdev_priv(netdev);
 
+	synchronize_rcu();
 	netdev_info(netdev, "Stopping the device ...\n");
 
 	/* Stop Tx from stack */
-- 
2.25.1


