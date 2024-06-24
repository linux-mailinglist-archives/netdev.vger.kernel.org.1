Return-Path: <netdev+bounces-106153-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 65915914FAC
	for <lists+netdev@lfdr.de>; Mon, 24 Jun 2024 16:13:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1BD8B281FBC
	for <lists+netdev@lfdr.de>; Mon, 24 Jun 2024 14:13:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4A5C142E73;
	Mon, 24 Jun 2024 14:13:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="NrUhzJVH"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2045.outbound.protection.outlook.com [40.107.244.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F733142E70
	for <netdev@vger.kernel.org>; Mon, 24 Jun 2024 14:13:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719238400; cv=fail; b=JqoKaLGt/k8aJFmqXVj06IbIOgtgbGtIZG9egr2Mp618SDDHDpi0szXSg9nzwOZfzr+1MFMbHwkiOri7cg87ZGuE8Bt4KhK24fhXPLnuFzMh6Jgczqxw6hi+PPQDuo3fEm+ygbtuMpg/bVgkMYaUPKyrFFxtj+o6qx8U3u6PEOs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719238400; c=relaxed/simple;
	bh=u/oLBJGYM+SHBWFc/06tAlZVNGvjaAg8iMZdKULq8s0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=up+iMYGzVz3F6k1WRQ1O/+PdMK+kXnDD+Xyjg8jJB7EderF8vxxKjGGw9G3CEvyhmt/JwHgEf9P99/Yq/eoAjjIk32JzuGMBr6HIXP+YeJ4gFntfMIsUNnWI74AE7t9KPZypnQX0/jUBV3ynLFbdFkmrXRNYqwvOn2cXN4iUSVo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=NrUhzJVH; arc=fail smtp.client-ip=40.107.244.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mIXcs464m/LQyiiEc/x+/R8W/uy+e0q7kiGixKcYNQjuKVaSqe8FzIyJvINVweMen6PAp/7W20sTMBNMTOARGiCvdrVmsrAcaDm88NIwTtmNh/ivGjBDNZ3ipKpCWB8Tp7G2CnQZH0NVnKw/Zsrqd0kgOFqy+pcRre0SOO2eEEc727P1scjP8ilWAY2jAqqhujeZJsH2BYw3vg4fUZ67kmKGlLuw0EVFhwZX2Cb1Fr2E7JFq4yBjgo/tiInJRT237D+xTamb3JCpw3n+RSByMgvlQGZkKnWxI444ZbBkuD7Zbqcd2vKRdA7y7ZNfIszJul59iXMp6E8/KiWiow3e3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tabGXzXEJqtUzUYaIu1Ps9NY28QvlRFGwMibDBA8SUw=;
 b=Nndjt1NWFPCvRAhGaLXgsJ5d/PeOTeCGpUFYRQ+HRGvWhg7n1EisNBtXJtMzDZt0vlisv447nU4xJjOyxoAHvkl54G/lZh/Kl85RlHXb2v6Idg3EMynxTpSIkGG/i/r85DOWOxAyGGawXvWcC5eZJsFOZjmW1hMBd7B5mI6vOihDHC6ejW5bXnoACw+W+WY9jIXOeGyEuedRPtPais8QwXZ+jpclzrtWsZRqJmFpCLLynOpV5ayHenD1y3vwuQP+WqR1AWegCB8xl9OeLJq+210u9bIIe60wrgsvD9EpIxOUjLjPmrxKlKaWsg3tQDi41fVww8HElnMR069i7+MdwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tabGXzXEJqtUzUYaIu1Ps9NY28QvlRFGwMibDBA8SUw=;
 b=NrUhzJVHM3cjFq8JRoHmSbROWtVchjRl/H3hDqhjo74IRv/0KSTt/aHHbbbO1t4tqwQtsJETHVqp5nwMgOeTK6ESivACxMfdriseQ5T9Kbc7VUp5ssAwvgP5+yABxUoFrTSx9kewEBTSSgfBl5ifGgaQc7TIYMxOQwqL6iM0zwg=
Received: from BN8PR15CA0051.namprd15.prod.outlook.com (2603:10b6:408:80::28)
 by PH8PR12MB6913.namprd12.prod.outlook.com (2603:10b6:510:1ca::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.26; Mon, 24 Jun
 2024 14:13:13 +0000
Received: from BN3PEPF0000B36F.namprd21.prod.outlook.com
 (2603:10b6:408:80:cafe::bd) by BN8PR15CA0051.outlook.office365.com
 (2603:10b6:408:80::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.30 via Frontend
 Transport; Mon, 24 Jun 2024 14:13:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B36F.mail.protection.outlook.com (10.167.243.166) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7741.0 via Frontend Transport; Mon, 24 Jun 2024 14:13:13 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 24 Jun
 2024 09:13:07 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 24 Jun
 2024 09:13:06 -0500
Received: from xcbecree42x.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39 via Frontend
 Transport; Mon, 24 Jun 2024 09:13:03 -0500
From: <edward.cree@amd.com>
To: <linux-net-drivers@amd.com>, <davem@davemloft.net>, <kuba@kernel.org>,
	<edumazet@google.com>, <pabeni@redhat.com>
CC: Edward Cree <ecree.xilinx@gmail.com>, <netdev@vger.kernel.org>,
	<habetsm.xilinx@gmail.com>, <sudheer.mogilappagari@intel.com>,
	<jdamato@fastly.com>, <mw@semihalf.com>, <linux@armlinux.org.uk>,
	<sgoutham@marvell.com>, <gakula@marvell.com>, <sbhatta@marvell.com>,
	<hkelam@marvell.com>, <saeedm@nvidia.com>, <leon@kernel.org>,
	<jacob.e.keller@intel.com>, <andrew@lunn.ch>, <ahmed.zaki@intel.com>,
	<horms@kernel.org>
Subject: [PATCH v7 net-next 8/9] net: ethtool: use the tracking array for get_rxfh on custom RSS contexts
Date: Mon, 24 Jun 2024 15:11:19 +0100
Message-ID: <eb5338a20e18061b83c04fd2927410ebc6f50f0d.1719237940.git.ecree.xilinx@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <cover.1719237939.git.ecree.xilinx@gmail.com>
References: <cover.1719237939.git.ecree.xilinx@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B36F:EE_|PH8PR12MB6913:EE_
X-MS-Office365-Filtering-Correlation-Id: d37b1eda-861a-4fa9-346b-08dc9457c91e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230037|82310400023|376011|7416011|36860700010|1800799021;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?HBeowUJHlAdy2m1uEWRGj2C/GBYMik83o3qbWgHsL3BXH3HckJosRquTm1wO?=
 =?us-ascii?Q?jF/bvGL8VomQKIKG0fsudWTxm5n6vx2jGhsj+mMHVvkdGOvq19sbqm4/zro+?=
 =?us-ascii?Q?txvqF0Oq2zO7DxlialhjgTFcOxKP3TY+MIL8IPot1WUjIKo/5Et8crPMMO1c?=
 =?us-ascii?Q?mlqcjfjANO2Dib+CnbZRNLQVCyeQMXDvufqXlVywBcgBY1kjfO7BoADAaWwH?=
 =?us-ascii?Q?/M0AmS0EqZ9S4n2u8j/nPTV6vyqZQbRntsn6q5Nc4eMoYt3JY51PnV/HlNiL?=
 =?us-ascii?Q?Yuv9jfgJeyW0XAICA+WL4uc2yHl8luOGF9RvBJnYPGmGWI1JE2cQWIxUGaDp?=
 =?us-ascii?Q?2c9ik38FzmgxsGDi/qXzwZH44XDy6g67bCLTpmQJgWe111m6fHnlmT4kEYBl?=
 =?us-ascii?Q?/dsNyZOhCrIJXYi3tJRBR9lmEDPAxK9chTLNpvS39rz01SstiVWbdkp6bvgg?=
 =?us-ascii?Q?V2+a5ob9r7BqcKu9gPHETatFDQdCGMoaWIlIsOeXMeFbuQLmNdJL+fWGDI88?=
 =?us-ascii?Q?iDMWOa/4k9p1EW+DGsCQPF2SPv4eGxfEoxkH7Al7gKeAQq4WjVRJ0O0qrf6o?=
 =?us-ascii?Q?vS2KmJHY5SHmzk/q2xhQgEZnpxMtdc890XTNFi5Vh3c7FIVHjNnKixofkxLA?=
 =?us-ascii?Q?VkSWSNG21WfYYuhUI42psy4nEVgJ62P5hx8EDA0eKjVBiEZW6CLsTNxabCkj?=
 =?us-ascii?Q?9A0I+n7N/7lKc5UiWqHAfqkq8ycLyna8HDaYT6qdAZLSC29/oVRvP+XHcY7w?=
 =?us-ascii?Q?R/aei4g3ykFSoapojU+YyELqgt26dxLkqczaX7Lhfv0tDk8PaNR0ImzUcKhT?=
 =?us-ascii?Q?/yV2ZXyufnU6eFZh+1xYpiZ+HZLjWtY9YkZe/Y5U/jsG1JsMZQk+uh7w5q9R?=
 =?us-ascii?Q?PDRFvr01ulhWOFlYCOe9s4QGFNDgTOBiv6QCaVcx3f0XiEsWGaehnBcyWxIS?=
 =?us-ascii?Q?zvMpfdw9Whj9pFP5l24dLW9qa5o35yDFm/GMA/tAyMhZ9rTKqasj860EnIik?=
 =?us-ascii?Q?rDDIuFYbuxMISR1uPug4mqEfgyri0XSqxHCg1aJU5apjDpr8RqCglPmrDhjt?=
 =?us-ascii?Q?GzUW7IEGz+T2hIii6Vx0/cUqYwoY++LCMzkE5fSpfGgxkI/3OKxkI2Yzk7nr?=
 =?us-ascii?Q?YGzivD8rfqsURZ7iTMEJBs+lAnPpwPrLJKHRgavmV7RnBuFbDvPBtb2Bhlgm?=
 =?us-ascii?Q?f0A2dQzSgyRVFygtBYxWMKomiYxakbU3ywyfTLg97ncFad8PMXPOItk8jdZg?=
 =?us-ascii?Q?dy/h7Mq/K1WcT0UuzNp6kc2+TP8hPD9xqt8PN9EGJbtSc4gtclL3ErnmNrR5?=
 =?us-ascii?Q?Qs2cNW8AloRgE4SOexer3q8oHwWIBpvgS2a6Mr7FeVm4w7jCJLK3JblX2Zlk?=
 =?us-ascii?Q?2fldI90YY7V27Nyw1r1fifynUczggXmLa/tTeoUtTu8XSNUVSA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230037)(82310400023)(376011)(7416011)(36860700010)(1800799021);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2024 14:13:13.6408
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d37b1eda-861a-4fa9-346b-08dc9457c91e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B36F.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6913

From: Edward Cree <ecree.xilinx@gmail.com>

On 'ethtool -x' with rss_context != 0, instead of calling the driver to
 read the RSS settings for the context, just get the settings from the
 rss_ctx xarray, and return them to the user with no driver involvement.

Signed-off-by: Edward Cree <ecree.xilinx@gmail.com>
---
 net/ethtool/ioctl.c | 26 +++++++++++++++++++++-----
 1 file changed, 21 insertions(+), 5 deletions(-)

diff --git a/net/ethtool/ioctl.c b/net/ethtool/ioctl.c
index 9d2d677770db..ad10ce44a3dd 100644
--- a/net/ethtool/ioctl.c
+++ b/net/ethtool/ioctl.c
@@ -1199,6 +1199,7 @@ static noinline_for_stack int ethtool_get_rxfh(struct net_device *dev,
 	const struct ethtool_ops *ops = dev->ethtool_ops;
 	struct ethtool_rxfh_param rxfh_dev = {};
 	u32 user_indir_size, user_key_size;
+	struct ethtool_rxfh_context *ctx;
 	struct ethtool_rxfh rxfh;
 	u32 indir_bytes;
 	u8 *rss_config;
@@ -1246,11 +1247,26 @@ static noinline_for_stack int ethtool_get_rxfh(struct net_device *dev,
 	if (user_key_size)
 		rxfh_dev.key = rss_config + indir_bytes;
 
-	rxfh_dev.rss_context = rxfh.rss_context;
-
-	ret = dev->ethtool_ops->get_rxfh(dev, &rxfh_dev);
-	if (ret)
-		goto out;
+	if (rxfh.rss_context) {
+		ctx = xa_load(&dev->ethtool->rss_ctx, rxfh.rss_context);
+		if (!ctx) {
+			ret = -ENOENT;
+			goto out;
+		}
+		if (rxfh_dev.indir)
+			memcpy(rxfh_dev.indir, ethtool_rxfh_context_indir(ctx),
+			       indir_bytes);
+		if (rxfh_dev.key)
+			memcpy(rxfh_dev.key, ethtool_rxfh_context_key(ctx),
+			       user_key_size);
+		rxfh_dev.hfunc = ctx->hfunc;
+		rxfh_dev.input_xfrm = ctx->input_xfrm;
+		ret = 0;
+	} else {
+		ret = dev->ethtool_ops->get_rxfh(dev, &rxfh_dev);
+		if (ret)
+			goto out;
+	}
 
 	if (copy_to_user(useraddr + offsetof(struct ethtool_rxfh, hfunc),
 			 &rxfh_dev.hfunc, sizeof(rxfh.hfunc))) {

