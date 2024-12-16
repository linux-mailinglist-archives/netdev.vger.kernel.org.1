Return-Path: <netdev+bounces-152110-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ABE819F2B5B
	for <lists+netdev@lfdr.de>; Mon, 16 Dec 2024 09:02:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 59F70166A21
	for <lists+netdev@lfdr.de>; Mon, 16 Dec 2024 08:02:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB6B6202F90;
	Mon, 16 Dec 2024 07:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="IzafjUYY"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2B091FF7DB;
	Mon, 16 Dec 2024 07:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734335955; cv=none; b=XVejgWBOIgA7t1hA77UtjyvD1u5bUROvxtUVNlprwkieGHee/bkJyE+uI2zlFaQnZRYtxdAR5LflrJdbUB98Z0DFHuhKJREMlO989qUx9tnvw0DoXX0nOey+3xXQ7eoJKQwtGbTgjwbd9dTOm6eBkLi4Jcb7SCOQp6OrtervRlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734335955; c=relaxed/simple;
	bh=ssDqcCgzEoWtlVVfnRDhya+2gXFCsOmvrBa6MVz4QOY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XVeKonpQHJ/vv7Hw9ypm9tAiJHOYWpbOBIEa66vUDx7EAivjAevhM/huPVFLNlr4byM3vVRQkGusCk+6agrozK7zdX2slKpMarzSnSK/lufiM+o8irxTLowkuwk5GgzZQbvZd28ncOdeZoCzs0v7GZ70hPm7FuQ/K5VeVJaXODg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=IzafjUYY; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BG7CEF0012568;
	Sun, 15 Dec 2024 23:58:47 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pfpt0220; bh=q
	DexZD0ryRFyegN1Eft2ZfZa921SAV6HTxGNha+KCZM=; b=IzafjUYYqwepG7vP/
	LUGJAFe9Ozsl8QYZa4uZbXBotEMAr6v7VAGueJ7/hY0nyTLkte4FQAPyI4bI7dIP
	f+sellzxHf9dOV1F7H8BVOxObfYgl3DdYwxQZLi6Z4rJPTYFQD8M5H4X659pNKnT
	1ZpH2evBrj7pfOfvS0DzMdcqfIlHam9MO57T7k9FjZMstX/6W+GjWtKc2JbKP5EX
	6RfuQ6pnYOwIqWnOQiIr8YRNu+J1L3Yl+PC5yvLeIfmLd/ZLIBWA/RCsu1ReyU5A
	jTiGohfQVuNoN8XnoBy0ybhjrmYX9Gkdq/Q6IJl9yzqi1wiFtOm0f1BkZ2md93bP
	lMqzQ==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 43j6am85uq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 15 Dec 2024 23:58:47 -0800 (PST)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Sun, 15 Dec 2024 23:58:46 -0800
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Sun, 15 Dec 2024 23:58:46 -0800
Received: from ubuntu-PowerEdge-T110-II.sclab.marvell.com (unknown [10.106.27.86])
	by maili.marvell.com (Postfix) with ESMTP id C85443F708E;
	Sun, 15 Dec 2024 23:58:45 -0800 (PST)
From: Shinas Rasheed <srasheed@marvell.com>
To: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <hgani@marvell.com>, <sedara@marvell.com>, <vimleshk@marvell.com>,
        <thaller@redhat.com>, <wizhao@redhat.com>, <kheib@redhat.com>,
        <konguyen@redhat.com>, <horms@kernel.org>, <einstein.xue@synaxg.com>,
        "Shinas
 Rasheed" <srasheed@marvell.com>,
        Veerasenareddy Burru <vburru@marvell.com>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        "Paolo
 Abeni" <pabeni@redhat.com>,
        Abhijit Ayarekar <aayarekar@marvell.com>,
        Satananda Burla <sburla@marvell.com>
Subject: [PATCH net v2 1/4] octeon_ep: fix race conditions in ndo_get_stats64
Date: Sun, 15 Dec 2024 23:58:39 -0800
Message-ID: <20241216075842.2394606-2-srasheed@marvell.com>
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
X-Proofpoint-GUID: rQU4JAyjZBOP_xFLS3UVZjRuRNdI6Jnb
X-Proofpoint-ORIG-GUID: rQU4JAyjZBOP_xFLS3UVZjRuRNdI6Jnb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.687,Hydra:6.0.235,FMLib:17.0.607.475
 definitions=2020-10-13_15,2020-10-13_02,2020-04-07_01

ndo_get_stats64() can race with ndo_stop(), which frees input and
output queue resources. Call synchronize_net() to avoid such races.

Fixes: 6a610a46bad1 ("octeon_ep: add support for ndo ops")
Signed-off-by: Shinas Rasheed <srasheed@marvell.com>
---
V2:
  - Changed sync mechanism to fix race conditions from using an atomic
    set_bit ops to a much simpler synchronize_net()

V1: https://lore.kernel.org/all/20241203072130.2316913-2-srasheed@marvell.com/

 drivers/net/ethernet/marvell/octeon_ep/octep_main.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/marvell/octeon_ep/octep_main.c b/drivers/net/ethernet/marvell/octeon_ep/octep_main.c
index 549436efc204..941bbaaa67b5 100644
--- a/drivers/net/ethernet/marvell/octeon_ep/octep_main.c
+++ b/drivers/net/ethernet/marvell/octeon_ep/octep_main.c
@@ -757,6 +757,7 @@ static int octep_stop(struct net_device *netdev)
 {
 	struct octep_device *oct = netdev_priv(netdev);
 
+	synchronize_net();
 	netdev_info(netdev, "Stopping the device ...\n");
 
 	octep_ctrl_net_set_link_status(oct, OCTEP_CTRL_NET_INVALID_VFID, false,
-- 
2.25.1


