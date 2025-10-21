Return-Path: <netdev+bounces-231380-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D65DBF8445
	for <lists+netdev@lfdr.de>; Tue, 21 Oct 2025 21:32:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B76A74E2119
	for <lists+netdev@lfdr.de>; Tue, 21 Oct 2025 19:32:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2BAC14C5B0;
	Tue, 21 Oct 2025 19:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="VrX+H99/"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1999D350A3B
	for <netdev@vger.kernel.org>; Tue, 21 Oct 2025 19:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761075143; cv=none; b=Ae/Y4MOvxIvE/ezpN2bgCbRPKccEsNqlbz5z+1ChaIqrBpQQYS2rOvzpj5NFuIxdkH6nAGxc6uGMlzbYmb5W5gFg8+1TgBfTffq4IlZg2MU6uU4xxEBRr9JJS9X+ycuIRvBRfs3gcfqwEumtQow5iNBdQ3h3KAlEmLp9apz2Egk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761075143; c=relaxed/simple;
	bh=kb1n4e50vwLb2MESluC2opPUNy4EGt9kz42zkcw2xIA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XFQSVeC24IO6AqCElJHHBQ/7NOEiDV1JM0U+CUIe78GEjI7XEdCUHDCJuFfqwU3zuKPZqj6X5zgefQPeA1di5sKvZ1mb5iYNnol0bJA/E/BkD6pAU1oC38+aBwlfrhJyAFn93Eu2wConEZ4oFtDpkWRwGDEg0r/nVWZ1Qg2F/7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=VrX+H99/; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59LIRMmC008699;
	Tue, 21 Oct 2025 19:32:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=corp-2025-04-25; bh=xPmAhom93LupiUCkdmp7KzXxGSnEr
	oJcVaNYIA5/O2w=; b=VrX+H99/gSXenmHO4Zi2ETD6nac/zxtY2BTMVWxN6V+OI
	57USpFq2PBjvoXzydh2COqx9jV3XW8+UokeqzFCYFlkWIC/CI7qWe5YW7KpnC+qS
	nIOKtrUiY313GHrQPNYYczyILW44mqNXO447fbvzTERlICwcpST1uWiHM/R9lAQD
	+qvbDiArZ1RQTe8X60EEJQS9jq3fY7YZevRUfXI20pcm5EN1pQIV549L1+MyHS2X
	xFR96RU2sTUEuYrA33XgXTTszGI4bMpqJz1UKs/NYEZaLV3jKy9bWvT29Wff79Hq
	mx16xjrC1n97haLUn/nWqN9hYTCcC4KGgj7ekhvpg==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 49v2vvxayv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 21 Oct 2025 19:32:07 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 59LHIPGu014029;
	Tue, 21 Oct 2025 19:32:06 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 49v1bc853v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 21 Oct 2025 19:32:06 +0000
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 59LJW5nd017565;
	Tue, 21 Oct 2025 19:32:05 GMT
Received: from ca-dev112.us.oracle.com (ca-dev112.us.oracle.com [10.129.136.47])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 49v1bc8530-1;
	Tue, 21 Oct 2025 19:32:05 +0000
From: Alok Tiwari <alok.a.tiwari@oracle.com>
To: anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
        andrew+netdev@lunn.ch, kuba@kernel.org, davem@davemloft.net,
        edumazet@google.com, pabeni@redhat.com, horms@kernel.org,
        intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org
Cc: alok.a.tiwarilinux@gmail.com, alok.a.tiwari@oracle.com
Subject: [PATCH net-next] igbvf: fix misplaced newline in VLAN add warning message
Date: Tue, 21 Oct 2025 12:32:01 -0700
Message-ID: <20251021193203.2393365-1-alok.a.tiwari@oracle.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-21_03,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 malwarescore=0
 suspectscore=0 spamscore=0 adultscore=0 bulkscore=0 phishscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2510020000 definitions=main-2510210156
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAyMiBTYWx0ZWRfX/IGAbA+V4eXP
 uLvCRNVJVoApg0cnfaOh5xMEwUXYztqdN9o9tPv+Dv4NRYPuOyrAps42mXB3zPOgIGG09eiz0LE
 VzMh7pvO2xJBIiwFRGiWdrzMJqho9wxT17PxFnlYmhyKbvpq2xVioo9MBnRpbXJcn3ieeHwYsYF
 vzoMIFdEFRqV3RJjEflf+y0mpBH/1DBuN19SBTvorXbRcjj+PR3L/Bkmr1oUvcVGwXgkweAGYVE
 UydTYXP9ZhiUbN9SddlxYhghfXSsUgECX0fTSs9DEHXhOGQNm86K71tVW6whgsr9HEKk3/xxQlX
 GFSm8mqwk8kNnj3bKEMtBXaMCaQ0Uo/jR9STHsv7TAm+Dg48prmvypw2wDWV9mvGqwBXRW1GEmI
 cS2Gyc0uhjIPtCUT08blDjxIpsRprQ==
X-Proofpoint-ORIG-GUID: -N4oouHI-rZ9AvZHMsU_QyfZHdwbikiJ
X-Proofpoint-GUID: -N4oouHI-rZ9AvZHMsU_QyfZHdwbikiJ
X-Authority-Analysis: v=2.4 cv=FuwIPmrq c=1 sm=1 tr=0 ts=68f7dfb7 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=yPCof4ZbAAAA:8
 a=TjKbjQt2ObX76LaVSKkA:9

Corrected the dev_warn format string:
- "Vlan id %d\n is not added" -> "Vlan id %d is not added\n"

Signed-off-by: Alok Tiwari <alok.a.tiwari@oracle.com>
---
 drivers/net/ethernet/intel/igbvf/netdev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/igbvf/netdev.c b/drivers/net/ethernet/intel/igbvf/netdev.c
index 61dfcd8cb370..ac57212ab02b 100644
--- a/drivers/net/ethernet/intel/igbvf/netdev.c
+++ b/drivers/net/ethernet/intel/igbvf/netdev.c
@@ -1235,7 +1235,7 @@ static int igbvf_vlan_rx_add_vid(struct net_device *netdev,
 	spin_lock_bh(&hw->mbx_lock);
 
 	if (hw->mac.ops.set_vfta(hw, vid, true)) {
-		dev_warn(&adapter->pdev->dev, "Vlan id %d\n is not added", vid);
+		dev_warn(&adapter->pdev->dev, "Vlan id %d is not added\n", vid);
 		spin_unlock_bh(&hw->mbx_lock);
 		return -EINVAL;
 	}
-- 
2.50.1


