Return-Path: <netdev+bounces-152921-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1ADFC9F6558
	for <lists+netdev@lfdr.de>; Wed, 18 Dec 2024 12:52:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6FF401894D46
	for <lists+netdev@lfdr.de>; Wed, 18 Dec 2024 11:52:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81E481ACEB4;
	Wed, 18 Dec 2024 11:51:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="MJDTXqjI"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8BC61A3029;
	Wed, 18 Dec 2024 11:51:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734522696; cv=none; b=OCWiA5xfJvG4JN2fP9YtCoFkMqmEsXOWqPoua7OFO042+wbR39JOgYruax/SIaQToJGAb0IejUj1AzRbNa6iJu6vcGj0Y4K6G+XwoNHOTPL+2SUMruvviMj40aau5kSd1uqzHxct0Soj8b8KzQ0Gx/yopTjTHKdF2jd46A7gXRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734522696; c=relaxed/simple;
	bh=PiJEX1bR7cTuzgYfpY/U90WDRAQZvKUHN+RkZtUuppo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=J6f207T0TR/nhDyCZbUOruO39XaK5krEwORk3nGb5pbvAsPcQ2j9TIuhnxZl2nEMI4kirWOOU9XYNQlWCXtd4m81yNDimc4FCiumhyDF3WM6+hyzEjZmRocvcJN/X21bva4dUH6w6sT9yeDch3A3UpENuGeY0lsVLeLj5sjGEJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=MJDTXqjI; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BIB2SFn010379;
	Wed, 18 Dec 2024 03:51:22 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pfpt0220; bh=3
	ZZwW3OWYx+MQZ6OVJXbTXQeMbvyRrGaRYXTXIj3Ia8=; b=MJDTXqjI5mjVSoFiy
	4/nRl3zc1Qd64IwGheHnvdBRyB1v1IhBFKS/MwE56rM0lpk+ppOWPCwAydvpVCW+
	36P7oNwsuoMfCdbt7UscvjBv0ZMws17GxGSyyubGtypdPerXr7ydHYaUH+JKid0b
	aLSRmahI/cfo1ZzFgYY/4wIkx+EMQsrJLI11tMc6P3Oa8adY8yr7KOx4INU1Q5cG
	HZ005ALHU3gOOhxIsoP9KGFDcsHR/ebNCfWBMPEus6js2CneldX2jgO8U57kgg8i
	r5agKIv0tlhWoNdFP1KLUxgFX5sCout8nYmTPrrcKYI5RfFNWrr5VOhWQfFK09WE
	zsYUA==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 43kw5p02ht-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 18 Dec 2024 03:51:22 -0800 (PST)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Wed, 18 Dec 2024 03:51:20 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Wed, 18 Dec 2024 03:51:20 -0800
Received: from ubuntu-PowerEdge-T110-II.sclab.marvell.com (unknown [10.106.27.86])
	by maili.marvell.com (Postfix) with ESMTP id 30CCF5C68EB;
	Wed, 18 Dec 2024 03:51:20 -0800 (PST)
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
Subject: [PATCH net v3 3/4] octeon_ep_vf: fix race conditions in ndo_get_stats64
Date: Wed, 18 Dec 2024 03:51:10 -0800
Message-ID: <20241218115111.2407958-4-srasheed@marvell.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241218115111.2407958-1-srasheed@marvell.com>
References: <20241218115111.2407958-1-srasheed@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: xsLL0AY3ne1njMWbvObywLb1MDPsnBzY
X-Proofpoint-ORIG-GUID: xsLL0AY3ne1njMWbvObywLb1MDPsnBzY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01

ndo_get_stats64() can race with ndo_stop(), which frees input and
output queue resources. Call synchornize_net() in ndo_stop()
to avoid such races.

Fixes: c3fad23cdc06 ("octeon_ep_vf: add support for ndo ops")
Signed-off-by: Shinas Rasheed <srasheed@marvell.com>
---
V3:
  - No changes

V2: https://lore.kernel.org/all/20241216075842.2394606-4-srasheed@marvell.com/
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


