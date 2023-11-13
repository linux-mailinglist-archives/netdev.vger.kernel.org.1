Return-Path: <netdev+bounces-47297-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 344DE7E97D9
	for <lists+netdev@lfdr.de>; Mon, 13 Nov 2023 09:36:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B56931F20CBA
	for <lists+netdev@lfdr.de>; Mon, 13 Nov 2023 08:36:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CAB614AAA;
	Mon, 13 Nov 2023 08:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="AX1tJwNI"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84E2A11739
	for <netdev@vger.kernel.org>; Mon, 13 Nov 2023 08:35:56 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2040.outbound.protection.outlook.com [40.107.237.40])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 859AF10F4
	for <netdev@vger.kernel.org>; Mon, 13 Nov 2023 00:35:55 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BYzokCIPxBG45Wx2p5VqQeQ/q2PQ0rxTUhND/IB0C5h7ApNx1BSOY8W3UcrIcem+6vEV96YbLXnM9Ma5t2rA4upahuGIKFRbRC/b+svMvRhWWBY+IIiLLmAXiskZ1GUBXECv8DjOZCI5rjI25tq3wG04l55c+v9hjN4eh+tU6fN6ns/r7n7U+Wl8HVR8Oq9zqPdpFrmETX23AZWlz2Rs5g74d83TaioU3GBWVJN6gxuzltF7nsj0s0AQfnDgr3LC7G1znJtZfF6JqozgzJPq3V0LVoXsZpNsQJePlSrADka6Jyz7N2lYDL+uBEYKNQik9eu7ghlIlN8VFPKfhrdsqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e2ne05d9KTejPCVY4D0yYnRT4O/XteJjbdRMFFHivgg=;
 b=aY1W3afBUDRJuQxMijLnhptH8hZYdfkYawnqk+zn2Fkv3RywbWAny/CJAaani7hHCOVUoqa6WyJf3p2fCgOrLz9bfBum6iKZ4//+h+jbGDD9RtSNlLnGTHNutftLePQpOF8zlIddomKj16CPyJ9s69g6Qi4RQoH6vIsV09s3PaiKKDsjXC12pymarmvdB1k4PRdyzwSn1+cXU1knQMfwVKFQEGv3igQvg3fhX4u9aRcTjA0gVvnfnUM/wvBLlM0XRC/NL7Hdo/W73nVbOk1Zq+WrNBz7SbCmmTjpGFJF7v2idzyNhfKtNoJ8IKuBo8rpz7MmXUOlfKLm8yC9UpACZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e2ne05d9KTejPCVY4D0yYnRT4O/XteJjbdRMFFHivgg=;
 b=AX1tJwNIZQYzPlx1eD6Zvg6d5vcCrqUSVl9NzH7xnVGBL3DVWPlXAanxj7UIE7gr52RPaT9fndzTyR+jbsE803G+ngckNT2SWuY/wBgcN/8zixftx3poJuKeQAUQpRK2r72T0TsOMuRP15+wAN/5aSc5UFLF778C2fFVfm1PNpRy1XP0vAu7gTVbde9kPwE2yiP1/dxr9e3GRgCJiP87AQ6lY7oQvAXXT2cM4qi6W/yipuPsDJKKv1T4E6BIkwzeh5jPL1qBLWnDAwm8NAMr+zfBTyRhdM5yd572TWaX4pf3fYWFAp7Ydr8a855PK75wNXzndD+HdJGGVq8Vlbscdw==
Received: from DS7PR06CA0001.namprd06.prod.outlook.com (2603:10b6:8:2a::12) by
 IA0PR12MB7773.namprd12.prod.outlook.com (2603:10b6:208:431::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.29; Mon, 13 Nov
 2023 08:35:53 +0000
Received: from DS3PEPF000099D4.namprd04.prod.outlook.com
 (2603:10b6:8:2a:cafe::e3) by DS7PR06CA0001.outlook.office365.com
 (2603:10b6:8:2a::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.29 via Frontend
 Transport; Mon, 13 Nov 2023 08:35:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 DS3PEPF000099D4.mail.protection.outlook.com (10.167.17.5) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7002.14 via Frontend Transport; Mon, 13 Nov 2023 08:35:52 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Mon, 13 Nov
 2023 00:35:38 -0800
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Mon, 13 Nov 2023 00:35:38 -0800
Received: from vdi.nvidia.com (10.127.8.12) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.986.41 via Frontend
 Transport; Mon, 13 Nov 2023 00:35:36 -0800
From: Gal Pressman <gal@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
CC: <netdev@vger.kernel.org>, Gal Pressman <gal@nvidia.com>, Vlad Buslov
	<vladbu@nvidia.com>
Subject: [PATCH net] net: Fix undefined behavior in netdev name allocation
Date: Mon, 13 Nov 2023 10:35:44 +0200
Message-ID: <20231113083544.1685919-1-gal@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DS3PEPF000099D4:EE_|IA0PR12MB7773:EE_
X-MS-Office365-Filtering-Correlation-Id: 8a2d55b8-42c7-4670-fe9b-08dbe4238c0e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	9sClbWFpnI/P8bapP5+4HLjLe7YEo8/vQjtuxnlVPIPsyk/uotV0p3xHR0FTh9tGLkpMETxEagrTbLuTJN/qHPIXqmNrnHVBWOrxUscOOPUWANOE5zfOi7ABYliQZulsUwfo3tZtQCvy6++G9RNo97iyEdXu4xx8IFMrey5nZE9CZSID2+76qO+BjJRPva0oDOsHhD+Y8otduFCAtubpxeO6REXcOZ7giL6lSIdHbAI+iXqeJ0aWp9NshweyD1knlKIZfp9Wd6JfEM9hT5KLnigVSpIjQxU88VlDqnH0nAgcR4ICFEzyrDy370z0cJ+7JJB/aiKr78iDcwo2bc+vwEkmtLEEszFAJuVd2rndUPujxH3auBfT7mkNrukiPK5/EANEYpJfZSRnrSRUBCb04SY//a7XxodQNCaaK023I2EXdnZcuQqZ9uvexQIRrZ1jj7Pbjr/d6PtR01j81oPv3ZOPRxfiA6/R0yZMGo8o/AW7gOrsWKMXIkoSg7XPHyxvAyaGeG/zVh/3abGHbXuCKf93iaie4lvUWfz6TufIbJplOr/578MgmklD3SH7+u9HwWooc+du14U3VTXhAcZ83DwOPFhNZHhDhSQQidqetulU4S4P9954vrYdWIJ+rBs5jdRMGWL+Vt1go1TTG77tKtU5SJhbAAT6nEYRhZ7gQSo1I/s4z8n+JQxIngC+mcwGNbiRCfIGZHnzXL0xNeaWnHfal0qI/FcCBOQydc5wg4kSICNwRpboMPWXL+oDiLyt
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(136003)(396003)(346002)(376002)(230922051799003)(451199024)(186009)(1800799009)(64100799003)(82310400011)(36840700001)(40470700004)(46966006)(107886003)(36860700001)(2906002)(1076003)(40460700003)(2616005)(5660300002)(86362001)(41300700001)(47076005)(426003)(336012)(26005)(82740400003)(110136005)(54906003)(70206006)(70586007)(316002)(83380400001)(478600001)(36756003)(7636003)(7696005)(356005)(6666004)(8676002)(4326008)(40480700001)(8936002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2023 08:35:52.6432
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a2d55b8-42c7-4670-fe9b-08dbe4238c0e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099D4.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7773

Cited commit removed the strscpy() call and kept the snprintf() only.

When allocating a netdev, 'res' and 'name' pointers are equal, but
according to POSIX, if copying takes place between objects that overlap
as a result of a call to sprintf() or snprintf(), the results are
undefined.

Add back the strscpy() and use 'buf' as an intermediate buffer.

Fixes: 9a810468126c ("net: reduce indentation of __dev_alloc_name()")
Cc: Jakub Kicinski <kuba@kernel.org>
Reviewed-by: Vlad Buslov <vladbu@nvidia.com>
Signed-off-by: Gal Pressman <gal@nvidia.com>
---
 net/core/dev.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/core/dev.c b/net/core/dev.c
index 0d548431f3fa..af53f6d838ce 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -1119,7 +1119,9 @@ static int __dev_alloc_name(struct net *net, const char *name, char *res)
 	if (i == max_netdevices)
 		return -ENFILE;
 
-	snprintf(res, IFNAMSIZ, name, i);
+	/* 'res' and 'name' could overlap, use 'buf' as an intermediate buffer */
+	strscpy(buf, name, IFNAMSIZ);
+	snprintf(res, IFNAMSIZ, buf, i);
 	return i;
 }
 
-- 
2.40.1


