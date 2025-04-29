Return-Path: <netdev+bounces-186728-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DC5EFAA0ABA
	for <lists+netdev@lfdr.de>; Tue, 29 Apr 2025 13:52:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A033B1A857FA
	for <lists+netdev@lfdr.de>; Tue, 29 Apr 2025 11:51:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6105D2C2593;
	Tue, 29 Apr 2025 11:46:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="IN0QNytk"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C0B02BEC49;
	Tue, 29 Apr 2025 11:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745927211; cv=none; b=ckmUL4IYaaB6OGABO0PwfZIpRk/MDzOXhlDw14h2hn8hyXGfQa5oxWHeQW1cKsDgCcyiSSJMD3q4gcIhJNLaXD/AI0fClUnSt4540IS/KzKZZPBKCVlY4DOQpsWPW5GVl7sYAQiJSpRdKaEuPs+P4vxyj0U3hQvAB1pkI6cMy2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745927211; c=relaxed/simple;
	bh=3dh4cSlwqNafxDi1eoskuMMskOU14nSu2voZZz+IISI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Reyi0Qb5suO/NS7kOVdeQP2wifbPea53GBRjZQgho+h8k7GvcNt4nBXxlga+Mea30GlmQLW9H5COJKY0/CCoIm7LtQ0boZ9Na9LdNEBnzJgyBfMHBk5nDWUYg87whLL8nE2qGsZ9ExCZfW5bl9hJiZtt1zZP+Y1WJLQnAyLrtAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=IN0QNytk; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53T6nggI024868;
	Tue, 29 Apr 2025 04:46:32 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pfpt0220; bh=lMYcX+6NRtn1bfaz92OoF0m
	EjFbSPiTLQI7sXGqkxkE=; b=IN0QNytkIeursvsjY1jMvW2fmWYQETH/EFMcHuD
	1NPCS4y/c3rPYaUcSGFSTlixcL0mb3ByYzmz92ihgQsZF2DbQW1RroGVmjL1Ivlv
	jQ3muIKe+3HxEkBd6E+QgeCN5SZAHIMqAqpN283L2zCY4SerD6/ZycQsb0nj0GRQ
	VjCLCufpZNiNKx97f4qZLtu4AF41OcLxl16hxEI1N9ZA/WJ1ESlXyftL62ggFZJe
	5v4b+3UEpASYSLFiSLXU7kPgm3wKEGm5skeLTFnJwH+jCVyCSzExBNvsRHxJq5hJ
	focFQetyE8P+gUebZ8UrJRQdSOMhHM5TI/vfV0P+crQbifQ==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 469krcccsb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 29 Apr 2025 04:46:29 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Tue, 29 Apr 2025 04:46:29 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Tue, 29 Apr 2025 04:46:28 -0700
Received: from sburla-PowerEdge-T630.sclab.marvell.com (unknown [10.106.27.217])
	by maili.marvell.com (Postfix) with ESMTP id 58B2D3F70D9;
	Tue, 29 Apr 2025 04:46:28 -0700 (PDT)
From: Sathesh B Edara <sedara@marvell.com>
To: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <hgani@marvell.com>, <vimleshk@marvell.com>,
        Veerasenareddy Burru
	<vburru@marvell.com>,
        Sathesh Edara <sedara@marvell.com>,
        Andrew Lunn
	<andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        "Eric
 Dumazet" <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>,
        Abhijit Ayarekar <aayarekar@marvell.com>
Subject: [PATCH net] octeon_ep: Fix host hang issue during device reboot
Date: Tue, 29 Apr 2025 04:46:24 -0700
Message-ID: <20250429114624.19104-1-sedara@marvell.com>
X-Mailer: git-send-email 2.36.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: Gdk_q4JLrARwBEnrBMpTqzczb2E_F_0o
X-Authority-Analysis: v=2.4 cv=f61IBPyM c=1 sm=1 tr=0 ts=6810bc18 cx=c_pps a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17 a=XR8D0OoHHMoA:10 a=M5GUcnROAAAA:8 a=Bsf_nmtMMKoVPQtrbQ8A:9 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDI5MDA4NyBTYWx0ZWRfXyJ5Z+YjPySVu csjnui5hfng4OityfJxwmo32k3qeyMj2l7HWYXqVvm75qOJ8t7E+oO0JLoGl9z6tyWHVsda9MZ8 ugviDjePM2si4BSidHRFkFFgaipV4FiuQSG9ghUEqaUSQMdI0yrq1QWrL54iLopiYzTwuAUNOd/
 abzSUuKM0Ej/hKdHoklYEoWs/mJjy7nQi5AEddWHL13JWUDX/+z1awtRZme1kcsfTo/+HTQGdfD uhe4PrReOfBYtPsGBt/Fb5WcPN8huhF1lIWo+NzkoG5eyJ06vGvrnOJ+8sMo6Mfe199aEyTIouq ACOcTdwkQ/RznQVnGxPDrAQpwDQdobnK8QvMUuFO0rXufqf7F0X7BlkhM/LRVdjx3yY9iBMAkdw
 Z4aTbmXPjbx+UUck8l3kJM/uE+KBefWNpgiJljrEgBLsXs/LWnW6Tf6UAlpL5E9RNGl3Rs2J
X-Proofpoint-ORIG-GUID: Gdk_q4JLrARwBEnrBMpTqzczb2E_F_0o
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-04-29_04,2025-04-24_02,2025-02-21_01

When the host loses heartbeat messages from the device,
the driver calls the device-specific ndo_stop function,
which frees the resources. If the driver is unloaded in
this scenario, it calls ndo_stop again, attempting to free
resources that have already been freed, leading to a host
hang issue. To resolve this, dev_close should be called
instead of the device-specific stop function.dev_close
internally calls ndo_stop to stop the network interface
and performs additional cleanup tasks. During the driver
unload process, if the device is already down, ndo_stop
is not called.

Fixes: 5cb96c29aa0e ("octeon_ep: add heartbeat monitor")
Signed-off-by: Sathesh B Edara <sedara@marvell.com>
---
 drivers/net/ethernet/marvell/octeon_ep/octep_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/marvell/octeon_ep/octep_main.c b/drivers/net/ethernet/marvell/octeon_ep/octep_main.c
index 0a679e95196f..24499bb36c00 100644
--- a/drivers/net/ethernet/marvell/octeon_ep/octep_main.c
+++ b/drivers/net/ethernet/marvell/octeon_ep/octep_main.c
@@ -1223,7 +1223,7 @@ static void octep_hb_timeout_task(struct work_struct *work)
 		miss_cnt);
 	rtnl_lock();
 	if (netif_running(oct->netdev))
-		octep_stop(oct->netdev);
+		dev_close(oct->netdev);
 	rtnl_unlock();
 }
 
-- 
2.36.0


