Return-Path: <netdev+bounces-110511-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3024392CC43
	for <lists+netdev@lfdr.de>; Wed, 10 Jul 2024 09:53:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DA64F1F2299B
	for <lists+netdev@lfdr.de>; Wed, 10 Jul 2024 07:53:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03EAD84DFE;
	Wed, 10 Jul 2024 07:52:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="DjUCqcId"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CC2B84A32;
	Wed, 10 Jul 2024 07:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720597974; cv=none; b=nrQh+gNkMcZVsEvK6fyGgDXyJ+ajAtcRikabNT56x/miVGUKEbmar8ibqi2IQFqLyf+QW/1X1Wn0dbw3k3iKpkRQUy0r9KIfCITFIrx4tjUtEdhTjcAp3kX5Mv/yBDf9Joh5Lu9HEernoEFiV/n9z+zir5djDixVRYrNSHFkwmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720597974; c=relaxed/simple;
	bh=23OqGtViRO+FNeourWoZ9oF1aPoZU5Rk4prGQEEejxQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hUr1zUN7ILfVYvPqKbqQ6CXaItpH+Ur/f+znPs7TPnOeUAmQUwNpY27alxUKblPYKTPHTYKzedDcoZOXTlizjMpjyCziQidDtDn07WnnJ0O/MxKzUa4r4WQaBxmH0Y2h6jKiOZfvn+bMR95Rz1E1v9uEM5YqF3Bh08kjPrhWNb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=DjUCqcId; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 469MQ88H022710;
	Wed, 10 Jul 2024 00:52:42 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pfpt0220; bh=L
	fV0iUwMPlR6+YJA4wPhDpZHuZdSVdwXPJvsXWH8CPA=; b=DjUCqcIdGhXSSh0J0
	gSgX/+Cr7dJVfl2XstrcsHrMm2vQUVLdVZElcNiVI1gw1dz91J6vf1w+0QQv6u9g
	fxTHIq99iOu10kpuu3Th8EYR0nfIYZRMb/BqCvl4LkHYJYS9NfRvcasvKD9zc5sA
	A513a96sro6Iwx8rk+1DZ+VEEL8Peo2eSp/o5N9uqDOyh6eQbUr6N3snyCEBzBqf
	8B1qHqWbAryXDT60rGbw5E/MGhDUdjUiJPUsTW/Y+Rqdk2NaM9BLVtj0JU3irSdA
	/21j25Xx1CiAPAIxf5Pwi3mWqerHYZdaWcwVB66Pqx/zhCZLyo3Pduu/s0RpEwkr
	ioe6w==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 409e061p0j-16
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Jul 2024 00:52:41 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Wed, 10 Jul 2024 00:51:47 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Wed, 10 Jul 2024 00:51:47 -0700
Received: from localhost.localdomain (unknown [10.28.36.175])
	by maili.marvell.com (Postfix) with ESMTP id 7D4C23F7053;
	Wed, 10 Jul 2024 00:51:41 -0700 (PDT)
From: Srujana Challa <schalla@marvell.com>
To: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <kuba@kernel.org>, <davem@davemloft.net>, <pabeni@redhat.com>,
        <edumazet@google.com>, <sgoutham@marvell.com>, <lcherian@marvell.com>,
        <gakula@marvell.com>, <jerinj@marvell.com>, <hkelam@marvell.com>,
        <sbhatta@marvell.com>, <ndabilpuram@marvell.com>,
        <schalla@marvell.com>, Michal Mazur <mmazur2@marvell.com>
Subject: [PATCH net,v2,3/5] octeontx2-af: fix detection of IP layer
Date: Wed, 10 Jul 2024 13:21:25 +0530
Message-ID: <20240710075127.2274582-4-schalla@marvell.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240710075127.2274582-1-schalla@marvell.com>
References: <20240710075127.2274582-1-schalla@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: 8U4rMYCh-zJe3Ex_xQZBHT1lWmjzP3A0
X-Proofpoint-GUID: 8U4rMYCh-zJe3Ex_xQZBHT1lWmjzP3A0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-10_04,2024-07-09_01,2024-05-17_01

From: Michal Mazur <mmazur2@marvell.com>

Checksum and length checks are not enabled for IPv4 header with
options and IPv6 with extension headers.
To fix this a change in enum npc_kpu_lc_ltype is required which will
allow adjustment of LTYPE_MASK to detect all types of IP headers.

Fixes: 21e6699e5cd6 ("octeontx2-af: Add NPC KPU profile")
Signed-off-by: Michal Mazur <mmazur2@marvell.com>
---
 drivers/net/ethernet/marvell/octeontx2/af/npc.h | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/af/npc.h b/drivers/net/ethernet/marvell/octeontx2/af/npc.h
index d883157393ea..6c3aca6f278d 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/npc.h
+++ b/drivers/net/ethernet/marvell/octeontx2/af/npc.h
@@ -63,8 +63,13 @@ enum npc_kpu_lb_ltype {
 	NPC_LT_LB_CUSTOM1 = 0xF,
 };
 
+/* Don't modify ltypes up to IP6_EXT, otherwise length and checksum of IP
+ * headers may not be checked correctly. IPv4 ltypes and IPv6 ltypes must
+ * differ only at bit 0 so mask 0xE can be used to detect extended headers.
+ */
 enum npc_kpu_lc_ltype {
-	NPC_LT_LC_IP = 1,
+	NPC_LT_LC_PTP = 1,
+	NPC_LT_LC_IP,
 	NPC_LT_LC_IP_OPT,
 	NPC_LT_LC_IP6,
 	NPC_LT_LC_IP6_EXT,
@@ -72,7 +77,6 @@ enum npc_kpu_lc_ltype {
 	NPC_LT_LC_RARP,
 	NPC_LT_LC_MPLS,
 	NPC_LT_LC_NSH,
-	NPC_LT_LC_PTP,
 	NPC_LT_LC_FCOE,
 	NPC_LT_LC_NGIO,
 	NPC_LT_LC_CUSTOM0 = 0xE,
-- 
2.25.1


