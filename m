Return-Path: <netdev+bounces-61314-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B54082356F
	for <lists+netdev@lfdr.de>; Wed,  3 Jan 2024 20:16:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2404A1C23CD5
	for <lists+netdev@lfdr.de>; Wed,  3 Jan 2024 19:16:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74E6F1CA9F;
	Wed,  3 Jan 2024 19:16:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ELhE2SIJ"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2057.outbound.protection.outlook.com [40.107.93.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E29161CA9D
	for <netdev@vger.kernel.org>; Wed,  3 Jan 2024 19:16:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fdSpfzx9CqlbQvH/hJ6HdJdmdKuKxQptWTuxXN1V7Do8lMj/IpvO/DuuBA/qTg0mMK7uq2YDNyPDTDAlUGK6x+abgN4HysMJklEscf0gkHWBHLWl7ltoCQMaea3gV+Tz6yoNBDi6v89qZeDYSkhQVa82IeOuV78H8uMdY3wr7tU8bRIq2QPn5376ozHGDglfdop+wxZCMklUvE1Ai2UnjElUYl6vGejMI4Z4DL1wvQBm1rzMjXtQagiWrZq3Fx8zMPqJMuGICY/QlrZg+74vB5s4N8BrTxImwzH8kVPEuwXbs8TWK5QjC+lKd/59/LOXp8rAsAaWvhl7Bcrz5TRrnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5FFwDm6Hv+5bwFeDmBl8x5bd9WOruXk1gj9HYr38IJc=;
 b=ebY7378K8CqBsbjADL8VywlXFchEkre5hgp3rTubw53u5eQ65PbKshHl80jwEHx38IsIr8N5jmZIBW6S2a0GA+C+6rYb5TNS4SwHJjRX0WLEIy6fuc7LEgjGjhw6rqZ3NVlFA13/nu582p1HgGvclV47MJ5e4pKYQzS5YLljWbeuFsY+QdpEAvgeD2R4rDCK/xU2Hl9CCOSIBkB74DAeEiRXU/ACmYvqtk6E/NhV+gPWFMdo1TxLT2G8zf9RhKMAOBS6mCHmDsmm6uCi/wtZpnvpA/i927B7hmeZ9l/ve4sismKrzg8lycnrj2sOFhyDzj7OCxV5MuS1naJ+3i4+5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5FFwDm6Hv+5bwFeDmBl8x5bd9WOruXk1gj9HYr38IJc=;
 b=ELhE2SIJYbaZh9EZDaKSO/AYOpWDQ0BQNrxoRGf7NtmIfcfWa0XJhtSwbiEbm+AmNyLuCy8oj+DK+9EP7Dtvvc2Z2pO5HFD9YSU7/K/XoCRxoxgiOydOOCZcJUIG4Uap5ymcmGh2i/jZnflA6dAYKxnPv9x6zNsj7QZfjoF0HW/qMPRFIOHAVojR0ZnCzzYGGuyVG9WGBmF1MnUdb0nAxmrw7Oh9uVbEj5yUm4CCrJyiGOdf7ZBRj+pewfZVblE/ukL51skWFBbLUshjIfVF7RAbc1DVi4Z0NxQ3CfitCdraBkA4u9iT23Y1/wYcLCyGGoYOGswc0t0iWqy9slKjhw==
Received: from PH8PR07CA0019.namprd07.prod.outlook.com (2603:10b6:510:2cd::18)
 by IA1PR12MB8334.namprd12.prod.outlook.com (2603:10b6:208:3ff::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.13; Wed, 3 Jan
 2024 19:16:41 +0000
Received: from SN1PEPF000252A0.namprd05.prod.outlook.com
 (2603:10b6:510:2cd:cafe::1a) by PH8PR07CA0019.outlook.office365.com
 (2603:10b6:510:2cd::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.13 via Frontend
 Transport; Wed, 3 Jan 2024 19:16:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SN1PEPF000252A0.mail.protection.outlook.com (10.167.242.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7159.9 via Frontend Transport; Wed, 3 Jan 2024 19:16:40 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Wed, 3 Jan 2024
 11:16:25 -0800
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Wed, 3 Jan 2024
 11:16:25 -0800
Received: from vdi.nvidia.com (10.127.8.12) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server id 15.2.986.41 via Frontend Transport; Wed, 3 Jan
 2024 11:16:23 -0800
From: Gal Pressman <gal@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
CC: <netdev@vger.kernel.org>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
	<pabeni@redhat.com>, Gal Pressman <gal@nvidia.com>, Ahmed Zaki
	<ahmed.zaki@intel.com>
Subject: [PATCH net-next] net: ethtool: Fix set RXNFC call on drivers with no RXFH support
Date: Wed, 3 Jan 2024 21:16:20 +0200
Message-ID: <20240103191620.747837-1-gal@nvidia.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000252A0:EE_|IA1PR12MB8334:EE_
X-MS-Office365-Filtering-Correlation-Id: afea913a-7a98-4119-45d4-08dc0c9083b0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	H4A3HPW5pTkWfLNRn0yMbDx+LoSyICPjNm1FLwBiC+AMqgbYXFMPXpEh33X9mJlg0PXu7lWvrylve+voQ5Azz99VaUnj+eYflZKIYA2D2hrngdgQC4K6mwERp/ci1K5nqGnszKKweparWuC9xHKDV/Og8Fsh3VQpQAZ9iSrQZXU0/8TE20tQYgJ+ZnByU0b/yaxk4unPdFIiNiWBK+LoL8OzQ9v1kphov0xGW2G9eaMSwf2huqwtDTxIreIgJheZZSrKRmVjdCadmxCLtfMkTBscbcplS4TnPlKkFCCqe7BizNskmPunJXjT64lGqa/IJR/Gg92Tpcdc8wIU2QLf0ymxTwnFkJ6OiGe3ZFhInoYwelr3pz3EjpCbL/q4C3kqG0u2zlrrrTcxdYbf9bkC6MQ77v2hHhbAvGgiy/36AE+4MoI0tH6vUwoHDDB4JvPMZYUo7S2A1fKX1SepgT4EkrmAGZdGGwTRlb6q3q+r9TJAO6CLGdVLn8nkyiBbWTgzdo+bGbsdvUc2O3967c+PKKsC26aE635RSwZiq8xRskdnJ4Icof9oarSAGxFP32LFGNOK4wPTAoRmEA1f2WPlFuZOVbWEUnZvPga+09D/cp6temTekc3kbLut0u2pCHQ9dhB8a2hpPi0/mRKLwYMP3dtYZN43c8INNxYrRM/eQoJrcRRRxApXwn2e8jAg9HMIUjRHq6cw3xs1BJz+Nrs6cjLnB/OmrMx0q4VC5Xuzv1mJION5wlQs9PW83ysIB+8L
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(396003)(376002)(346002)(136003)(230922051799003)(64100799003)(82310400011)(451199024)(186009)(1800799012)(36840700001)(46966006)(40470700004)(478600001)(316002)(54906003)(110136005)(8936002)(8676002)(70206006)(70586007)(47076005)(4326008)(36860700001)(83380400001)(7696005)(426003)(1076003)(2616005)(41300700001)(2906002)(5660300002)(336012)(26005)(36756003)(356005)(7636003)(82740400003)(86362001)(40460700003)(40480700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jan 2024 19:16:40.2396
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: afea913a-7a98-4119-45d4-08dc0c9083b0
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000252A0.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8334

Some interfaces support get/set_rxnfc but not get/set_rxfh (mlx5 IPoIB
for example).
Instead of failing the RXNFC command, do the symmetric xor sanity check
for interfaces that support get_rxfh only.

Fixes: dcd8dbf9e734 ("net: ethtool: get rid of get/set_rxfh_context functions")
Cc: Ahmed Zaki <ahmed.zaki@intel.com>
Signed-off-by: Gal Pressman <gal@nvidia.com>
---
 net/ethtool/ioctl.c | 24 +++++++++++++-----------
 1 file changed, 13 insertions(+), 11 deletions(-)

diff --git a/net/ethtool/ioctl.c b/net/ethtool/ioctl.c
index 86d47425038b..42d02cf3a4b3 100644
--- a/net/ethtool/ioctl.c
+++ b/net/ethtool/ioctl.c
@@ -978,27 +978,29 @@ static noinline_for_stack int ethtool_set_rxnfc(struct net_device *dev,
 	size_t info_size = sizeof(info);
 	int rc;
 
-	if (!ops->set_rxnfc || !ops->get_rxfh)
+	if (!ops->set_rxnfc)
 		return -EOPNOTSUPP;
 
 	rc = ethtool_rxnfc_copy_struct(cmd, &info, &info_size, useraddr);
 	if (rc)
 		return rc;
 
-	rc = ops->get_rxfh(dev, &rxfh);
-	if (rc)
-		return rc;
-
 	/* Sanity check: if symmetric-xor is set, then:
 	 * 1 - no other fields besides IP src/dst and/or L4 src/dst
 	 * 2 - If src is set, dst must also be set
 	 */
-	if ((rxfh.input_xfrm & RXH_XFRM_SYM_XOR) &&
-	    ((info.data & ~(RXH_IP_SRC | RXH_IP_DST |
-			    RXH_L4_B_0_1 | RXH_L4_B_2_3)) ||
-	     (!!(info.data & RXH_IP_SRC) ^ !!(info.data & RXH_IP_DST)) ||
-	     (!!(info.data & RXH_L4_B_0_1) ^ !!(info.data & RXH_L4_B_2_3))))
-		return -EINVAL;
+	if (ops->get_rxfh) {
+		rc = ops->get_rxfh(dev, &rxfh);
+		if (rc)
+			return rc;
+
+		if ((rxfh.input_xfrm & RXH_XFRM_SYM_XOR) &&
+		    ((info.data & ~(RXH_IP_SRC | RXH_IP_DST |
+				    RXH_L4_B_0_1 | RXH_L4_B_2_3)) ||
+		     (!!(info.data & RXH_IP_SRC) ^ !!(info.data & RXH_IP_DST)) ||
+		     (!!(info.data & RXH_L4_B_0_1) ^ !!(info.data & RXH_L4_B_2_3))))
+			return -EINVAL;
+	}
 
 	rc = ops->set_rxnfc(dev, &info);
 	if (rc)
-- 
2.40.1


