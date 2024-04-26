Return-Path: <netdev+bounces-91690-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 433598B3764
	for <lists+netdev@lfdr.de>; Fri, 26 Apr 2024 14:45:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6679B1C21115
	for <lists+netdev@lfdr.de>; Fri, 26 Apr 2024 12:45:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09014146A97;
	Fri, 26 Apr 2024 12:45:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ASfvpkad"
X-Original-To: netdev@vger.kernel.org
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2080.outbound.protection.outlook.com [40.107.95.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D077146A95
	for <netdev@vger.kernel.org>; Fri, 26 Apr 2024 12:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714135515; cv=fail; b=jaqgAyoZaWiMbjacIjJSwSl6MrFesAnLfLc2Go3l0SgHhtnNjcM2Dmc92fbmKBtdZnCZqNn96nURE1stOeEzwr9OTa167y+pWl5yTL+umycWjsrZAg+oZafelR/RA5PI3vKI4/fqTD7nHIwE/xe5m+ptDAbidmTEX9vfEsXrlVw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714135515; c=relaxed/simple;
	bh=cDOQxacCcSlk/1rnqv3Uw3u59mz0QAUVigsJS9i0bJY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IcIDu8T6Db6XtCUMAjFy6ndmGjQPmmGoS9c++rXbpl2O9ZnjQVay0mhS7ihyKrK/3qD06UJIeRPPCn5M8hJBQnY6IlgUAVaSZMeJxJ8HH3kt4oJy/xpYQTiYNyVK4EV4GfnBFOvTSSAQNm33LjxJHsrq+bNikDQJgY/kASKns+0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ASfvpkad; arc=fail smtp.client-ip=40.107.95.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jQqUA0m8l0tWT2uuDq1LnUtW4v/PkcQf4VGyOQ/nOk6h6mutT0g1hLACgsc1c29pwAEfimE2PzdF+F2ZfzpAIpanhc6PVyIyQTEXCHpN975PdgxNaik+exozqLwh0pScZ52gpWN0s2AyqUKjltiHToboBmom9gFxspE1N1MI8y/eNbFug4BhmOJuGgkHqV/e8REwVQBsTGSPuH3sDhCoNXTvlNySMhXYVju0r4rayAvUEcrhUOkwwc44+8ovdgHqwlkDF00HD36MDIcobjAuvBl6nkgLqyaRQVF+Zoz/Th9LqFvUMTD+Kc6gwa2FShSTIgKwIyttENqc13XFGFkpGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BENPOsAkR8tSkvkTUWjharxyEuFaq1d92x63rW+42so=;
 b=kACfV1r+nF0NTdBMn8CCWPBGRq95AW9NGRRioQMGqnTNU/jcdtJrrkT7KPI29jJ0+orRDTgzQxHjERCchSnv9AwM4e4LiU+ZAU7VTsaHkvGHA7fKDK0pInzLtIZSkTkbA36iq5+BB0QyWCrVMamYZmWvefGh0yN+wGOFz80jIdfPZnHcUQ41GjitYhMAa6727C+ypQhZap6n8zktp8DA1aTTCXDxGEQtHife4vJQUbRxy2aJ+3weignTW/FWiHjFtfYHldBr7ttki2TAkpB0qqUKw0xOS0EGQ1Uz2nQXfZOJVMlN0jZ8tEKn6p8ZQVL565BXo2a0O+MAghenjO8qxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BENPOsAkR8tSkvkTUWjharxyEuFaq1d92x63rW+42so=;
 b=ASfvpkade96PwZaT72cPMsNLQtcd5Z4JdgLQsupoGUWQ7i8Z2orWaBNUrr+Ro8vqklOWc3fiZFvFKtUVinqkcLSh5mW7ni85kS9wg0aizOXYTRz7KsyPo8adq2mTKQ8MnJUPLd++w4Xp1VG1qd4VFOxQAdSu3qrgS/3TmxTsYxAWPy6hkxu50DIc/ifhhwTpcad813GcUEmzPDkuFT0GkYgSZ4gSP4LACC5Ah2TC9W4aGqORIJNp4XV3f5lAC+YOO2qh2PkHYfyVpyYl6PcSMTWFp+JKyd5YBT70zIWexyF4CUhGTz/hu0tl0swUwCmonLahiCTOxjcCD5NKNaf4FQ==
Received: from CY5PR18CA0004.namprd18.prod.outlook.com (2603:10b6:930:5::7) by
 MN2PR12MB4239.namprd12.prod.outlook.com (2603:10b6:208:1d2::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.24; Fri, 26 Apr
 2024 12:45:10 +0000
Received: from CY4PEPF0000EE39.namprd03.prod.outlook.com
 (2603:10b6:930:5:cafe::62) by CY5PR18CA0004.outlook.office365.com
 (2603:10b6:930:5::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.29 via Frontend
 Transport; Fri, 26 Apr 2024 12:45:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CY4PEPF0000EE39.mail.protection.outlook.com (10.167.242.13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7519.19 via Frontend Transport; Fri, 26 Apr 2024 12:45:10 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 26 Apr
 2024 05:45:01 -0700
Received: from localhost.localdomain (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 26 Apr
 2024 05:44:57 -0700
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <netdev@vger.kernel.org>
CC: Ido Schimmel <idosch@nvidia.com>, Petr Machata <petrm@nvidia.com>, "Amit
 Cohen" <amcohen@nvidia.com>, <mlxsw@nvidia.com>
Subject: [PATCH net-next 3/5] mlxsw: pci: Initialize dummy net devices for NAPI
Date: Fri, 26 Apr 2024 14:42:24 +0200
Message-ID: <025aeb3d5b1c4f25b39d9a041556e1d703615e8f.1714134205.git.petrm@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <cover.1714134205.git.petrm@nvidia.com>
References: <cover.1714134205.git.petrm@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE39:EE_|MN2PR12MB4239:EE_
X-MS-Office365-Filtering-Correlation-Id: 8e0d7708-3117-45ee-69ba-08dc65eeb584
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|376005|36860700004|1800799015|82310400014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Ef2kcV8MPc2dr8yUQ7EFXS/sYHUF1MVEfiS1lGUmfmgPQNOtpFTfq7Z3Evup?=
 =?us-ascii?Q?sy43bVTwA9S9LMk0sWGdPkvKwgk+53Qbcbs0YLGsUi/3jZJX7yFUX8F+inrz?=
 =?us-ascii?Q?csh73XYnu81kbYfyX8ZmYS7pMzWgSkycRYSbob7Ckt6xaq5fXHWf8TOooa29?=
 =?us-ascii?Q?obu1soNP5Oj1maeE0Ol1C/2wL8FAHmVuP9QYECJYghwtFjB6d8n72zTkjt1/?=
 =?us-ascii?Q?FvRFD6TLNZaRRZj/uuNMkwTpUcia1pokd+qwdv+WtG5Y/HGFw0LholDQrSg7?=
 =?us-ascii?Q?0AZRyzo1At1jxhoFVpXg0o6hJzy16swfN1wfJhAmIZ4SKhpewWswWznhDoKp?=
 =?us-ascii?Q?ToFZDqoUmTkGUbLYcReWDAh5eFYqYLDmNOBh9NHjZieNsOUmWb7PguBtGydW?=
 =?us-ascii?Q?hl5qZ3lG1LuwQOrvIBX/FZUrRiX3jVdvIT+72ewcd7cfGZGuHeCKuAKpXpHa?=
 =?us-ascii?Q?WQ97GA2CLZc7BVhbylUpauuDDOFaPS9mriQZCPVBOBgHHdkiZd4bm2mZvOlK?=
 =?us-ascii?Q?vcnjN5+5T6ILotNZRhQaeh4Mx0imxFVED3tzbT48cTZHG6lfW5Kv+YN3be3z?=
 =?us-ascii?Q?cafPyOmQLBYKr+kiXXk+urePgT/ijPEF6hrHIMLQeah0A0xpqbYtu6JqVVVw?=
 =?us-ascii?Q?WYI5oIvJpW4BbfYzLdYsBtpOsvYMk65Iq/w84xe2WwvtGxkgVuEn4xccOnOk?=
 =?us-ascii?Q?ywf8Ru47i6lNhPkZzc2hIx8HzPI76YE17w0eubOkdxvgrSnTVHs4FpxNvIyC?=
 =?us-ascii?Q?G+ubLOW59hplHMZtlh/YSy81Tv8vkfF+eRWeH+cwbD3weGp2YE9iMv0uwgdy?=
 =?us-ascii?Q?492klIIzcqjpSDwRVSKd2o+lM3C549CyDKMPYpC93al0DeaP//UQ1PavmwHr?=
 =?us-ascii?Q?4SnbdlJHWPU+3ihLqyMaR1Gn9yhY69/mKWZ5V/yMTWnTqQtRh81kkCuyIKzq?=
 =?us-ascii?Q?sfbgHU6Z2BpUuj5CkmWQhrT1InMpW4xNDylDvfaRuCvlO6HDGxmqyFfbt/gT?=
 =?us-ascii?Q?JhKP/YjfUhWFKEshnAT3wMT/WP3OxP7S5a88ayK2BD2VxSDp8J0IR4djJCKl?=
 =?us-ascii?Q?sQh/4+SX4kERCXAbArIUMEWfOOpNl/V8dT88EE++WA74Gz6fBeM3N1nf+bRN?=
 =?us-ascii?Q?oyXLJ1izwnaOmHsCYx9IrDKTjZSvQv9wGrKNBjnJ3euSgIXAhjxcyUxZNn+t?=
 =?us-ascii?Q?ZbxBMGSDCRR34/fFhGrjB4HninJac4VzS2/HPskls8l6+5UQ0f3i8sVqS8/g?=
 =?us-ascii?Q?sA5HlPa9X4VOtmpGsJGtvjC+/rVeke8M+HFEYhDnivZSby5rWnm4SClNvN52?=
 =?us-ascii?Q?PXctvPzmhWd7+YrBP1qqz2zYMXa+PwivG2zNdKfkk2z8nbeJhhh8ktJS/Z0T?=
 =?us-ascii?Q?N9m9opE=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(376005)(36860700004)(1800799015)(82310400014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Apr 2024 12:45:10.0649
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e0d7708-3117-45ee-69ba-08dc65eeb584
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE39.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4239

From: Amit Cohen <amcohen@nvidia.com>

mlxsw will use NAPI for event processing in a next patch. As preparation,
add two dummy net devices and initialize them.

NAPI instance should be attached to net device. Usually each queue is used
by a single net device in network drivers, so the mapping between net
device to NAPI instance is intuitive. In our case, Rx queues are not per
port, they are per trap-group. Tx queues are mapped to net devices, but we
do not have a separate queue for each local port, several ports share the
same queue.

Use init_dummy_netdev() to initialize dummy net devices for NAPI.

To run NAPI poll method in a kernel thread, the net device which NAPI
instance is attached to should be marked as 'threaded'. It is
recommended to handle Tx packets in softIRQ context, as usually this is
a short task - just free the Tx packet which has been transmitted.
Rx packets handling is more complicated task, so drivers can use a
dedicated kernel thread to process them. It allows processing packets from
different Rx queues in parallel. We would like to handle only Rx packets in
kernel threads, which means that we will use two dummy net devices
(one for Rx and one for Tx). Set only one of them with 'threaded' as it
will be used for Rx processing. Do not fail in case that setting 'threaded'
fails, as it is better to use regular softIRQ NAPI rather than preventing
the driver from loading.

Note that the net devices are initialized with init_dummy_netdev(), so
they are not registered, which means that they will not be visible to user.
It will not be possible to change 'threaded' configuration from user
space, but it is reasonable in our case, as there is no another
configuration which makes sense, considering that user has no influence
on the usage of each queue.

Signed-off-by: Amit Cohen <amcohen@nvidia.com>
Reviewed-by: Ido Schimmel <idosch@nvidia.com>
Signed-off-by: Petr Machata <petrm@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlxsw/pci.c | 41 +++++++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/drivers/net/ethernet/mellanox/mlxsw/pci.c b/drivers/net/ethernet/mellanox/mlxsw/pci.c
index 2094b802d8d5..ec54b876dfd9 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/pci.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/pci.c
@@ -127,8 +127,42 @@ struct mlxsw_pci {
 	u8 num_cqs; /* Number of CQs */
 	u8 num_sdqs; /* Number of SDQs */
 	bool skip_reset;
+	struct net_device *napi_dev_tx;
+	struct net_device *napi_dev_rx;
 };
 
+static int mlxsw_pci_napi_devs_init(struct mlxsw_pci *mlxsw_pci)
+{
+	int err;
+
+	mlxsw_pci->napi_dev_tx = alloc_netdev_dummy(0);
+	if (!mlxsw_pci->napi_dev_tx)
+		return -ENOMEM;
+	strscpy(mlxsw_pci->napi_dev_tx->name, "mlxsw_tx",
+		sizeof(mlxsw_pci->napi_dev_tx->name));
+
+	mlxsw_pci->napi_dev_rx = alloc_netdev_dummy(0);
+	if (!mlxsw_pci->napi_dev_rx) {
+		err = -ENOMEM;
+		goto err_alloc_rx;
+	}
+	strscpy(mlxsw_pci->napi_dev_rx->name, "mlxsw_rx",
+		sizeof(mlxsw_pci->napi_dev_rx->name));
+	dev_set_threaded(mlxsw_pci->napi_dev_rx, true);
+
+	return 0;
+
+err_alloc_rx:
+	free_netdev(mlxsw_pci->napi_dev_tx);
+	return err;
+}
+
+static void mlxsw_pci_napi_devs_fini(struct mlxsw_pci *mlxsw_pci)
+{
+	free_netdev(mlxsw_pci->napi_dev_rx);
+	free_netdev(mlxsw_pci->napi_dev_tx);
+}
+
 static void mlxsw_pci_queue_tasklet_schedule(struct mlxsw_pci_queue *q)
 {
 	tasklet_schedule(&q->tasklet);
@@ -1721,6 +1755,10 @@ static int mlxsw_pci_init(void *bus_priv, struct mlxsw_core *mlxsw_core,
 	if (err)
 		goto err_requery_resources;
 
+	err = mlxsw_pci_napi_devs_init(mlxsw_pci);
+	if (err)
+		goto err_napi_devs_init;
+
 	err = mlxsw_pci_aqs_init(mlxsw_pci, mbox);
 	if (err)
 		goto err_aqs_init;
@@ -1738,6 +1776,8 @@ static int mlxsw_pci_init(void *bus_priv, struct mlxsw_core *mlxsw_core,
 err_request_eq_irq:
 	mlxsw_pci_aqs_fini(mlxsw_pci);
 err_aqs_init:
+	mlxsw_pci_napi_devs_fini(mlxsw_pci);
+err_napi_devs_init:
 err_requery_resources:
 err_config_profile:
 err_cqe_v_check:
@@ -1765,6 +1805,7 @@ static void mlxsw_pci_fini(void *bus_priv)
 
 	free_irq(pci_irq_vector(mlxsw_pci->pdev, 0), mlxsw_pci);
 	mlxsw_pci_aqs_fini(mlxsw_pci);
+	mlxsw_pci_napi_devs_fini(mlxsw_pci);
 	mlxsw_pci_fw_area_fini(mlxsw_pci);
 	mlxsw_pci_free_irq_vectors(mlxsw_pci);
 }
-- 
2.43.0


