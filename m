Return-Path: <netdev+bounces-219492-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 81BB3B4197E
	for <lists+netdev@lfdr.de>; Wed,  3 Sep 2025 11:01:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5383C1886607
	for <lists+netdev@lfdr.de>; Wed,  3 Sep 2025 09:00:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21FD92F1FC0;
	Wed,  3 Sep 2025 08:59:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Rn0wM13n"
X-Original-To: netdev@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013007.outbound.protection.outlook.com [40.107.159.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D695E2ECD3A;
	Wed,  3 Sep 2025 08:59:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756889958; cv=fail; b=rnA3H58hLZ6/10RMvRi6fVQ6RP6BbYmtSgsyRiJ6mgVzRQUvQdlf+7KDtCj6/HYeWtT+DwHa9/c8wc/ct0O7AFfjWMZT+dcO5qQiefJPFw0lTmFjmSG0KLHnJQDAdY07WTsy+6mmhkM24Ik1z4YEQwlKw1jrTW8UUYnaNL5UsFE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756889958; c=relaxed/simple;
	bh=+O9WQLYehbxXJ97l8TP9Zhn233pjISVWuBa+42dVjTA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Nu+9rQ1nA8mMxAjoeJdDfSiIwZWiiTS/AvYEiKfYaJ0aZQDGv8fDMKa3WpMJPk3U/RyuY5DfKLj5xe+vOA0BLmdDJBqupRWEGqO3n63BaH3c57c5PPk+YW4UHE4flm3evBSwB+v3O7jsnD4ZDKGaXzhkJ+yJGWs/gJ7MO9uy8ig=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Rn0wM13n; arc=fail smtp.client-ip=40.107.159.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=odzluUHi8kzTYNAzCYKdIQtWukhbIa/GRy0MS39ZTU+T6mGY51NZfLZSfXszgwoTFC2ISNE4aQaQnyzfuxnZ8v6h1XGclx7Bhy17lvMj1yBwv6sUD1Ps/T6CKvEm9zZC30ueyv6anDeEmG4NvsHCVNiyFrrq4kpsCCyA02dp01zF5XeUBo3QTpaVFOgw0wEMmhzvLiQpWNex0oh+te6KiEjbIjrZI/Sqw/MKfgM9Fm63QbRxh80FVkwXCfDrvPfsQvhyZ+XJWmdmO4MoqDbjh5sVsdn6/TD+5Aj6bTxHe8gG+bt09m6nbfP+w2FD/r0SMnLePTBgti/mhozN9L35zQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m6ZvxpU83LMDJLFsn9uSw166QVWUQCV4FXUPKcX6lgw=;
 b=hMigo9lgy5eb/tSU0iuWxA8J15gvOnMNMlEJLBFsgUvuMuKGZzrOYtij6LyvTS8Gau8M4hwfH97mhK3FcoGIU7C8lEbuMBQQxo/1kWLZS98foZ0I7WpNzNkuNuscsqkFiQPP33n5U0BrHQOTx+Aw5LTSxzkXV+pcvkjJTbJlzxbgVBGK0I3Cu4MMliHPNBrICoShol2i5C100mMJucm+9sRJmAcnN3bkRXQh7vEyCIkyPEELBtFe5Ie+SIcNqi0zkGAK8LsHpuqbcJ6JvlxtFPVDr0rcgr914Do6eNIG+94HNlICrpV9xNeCoUeBX7lgzRsaSc0gQkVdLlarUAQJnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m6ZvxpU83LMDJLFsn9uSw166QVWUQCV4FXUPKcX6lgw=;
 b=Rn0wM13n4piZaOVzOp87n2ycOdn6jmy6xE6qaCa66VSPRDPb7Lz9/1ww7KNDeeYKJLCbd3VpK5ZJGj8YFeFjWsqAZH1uOtxO4loIOaD1xsbqmhgr8uKUM/WrpIJEExqe0iff7Afq6saYZ6b87WlFosm0m8Y+0byZR0gZXBHgmoYbzQuk67v76KJxEZdEnOJ2KI3UQnOOnO+vuqWVEZ6nYjFn1H4qUEcnx8EZLMrO2SOzJkwty9J7UJ/AsIJKFA4rxhQcUkaXWBiyfAb1H0FdlR8W1sor0l97LaAx5WvojPLfcW1bjK2vbJ97Vwd4ajycGQeikAkmQGaH9qEVXuljjA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by GV2PR04MB11190.eurprd04.prod.outlook.com (2603:10a6:150:278::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.15; Wed, 3 Sep
 2025 08:59:08 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%5]) with mapi id 15.20.9094.015; Wed, 3 Sep 2025
 08:59:08 +0000
From: Wei Fang <wei.fang@nxp.com>
To: richardcochran@gmail.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	vladimir.oltean@nxp.com,
	xiaoning.wang@nxp.com,
	Frank.Li@nxp.com,
	yangbo.lu@nxp.com,
	christophe.leroy@csgroup.eu
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-arm-kernel@lists.infradead.org,
	imx@lists.linux.dev
Subject: [PATCH net-next 3/3] ptp: qoriq: covert to use generic interfaces to set loopback mode
Date: Wed,  3 Sep 2025 16:37:49 +0800
Message-Id: <20250903083749.1388583-4-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250903083749.1388583-1-wei.fang@nxp.com>
References: <20250903083749.1388583-1-wei.fang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2P153CA0026.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:190::18) To PAXPR04MB8510.eurprd04.prod.outlook.com
 (2603:10a6:102:211::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8510:EE_|GV2PR04MB11190:EE_
X-MS-Office365-Filtering-Correlation-Id: 9f066b11-37d1-4c59-1b79-08ddeac8246b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|19092799006|1800799024|366016|52116014|376014|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?KUNwMVUXKsIkA4t1AwGEDmiSGDeOAhDizahkl1odntTmcpEv2P2puRqmx2lj?=
 =?us-ascii?Q?8EaEBdD0zg2kd3ATeQjmPA4YP9IxsHb9F9fva0klKGqgXdpJow8hr/Ax4qqO?=
 =?us-ascii?Q?GlDj2XZgKR/odPYEmY91gi8J5+7HKzuCcJogmYzalth2sg+snscPIlhiAE9H?=
 =?us-ascii?Q?R1LVMD7ZtSNNzIEeiFQ1xtRbU6fCczWJggTxi/rvP4u2Xztq4j0qBiKT18B4?=
 =?us-ascii?Q?BHJZhrw2LZ0LQkkb/yrLs+WUubJ0KC6qXvBEFyJzv3gukssu6SfK+GRhbZ6H?=
 =?us-ascii?Q?qn5IO2VDr3NWBR5hna6D+U1Na079vR3ysRg5SZhHacr1+NNpDl0a+FCc8Im/?=
 =?us-ascii?Q?TddMeBWkr8pEPYYxO/inua8zoYyKeIOVzy+0Xy1Qj+T7GVoXoSKp086cHRZj?=
 =?us-ascii?Q?KAanzV3bs6ll3FLYODrrLTLibvhPJ3O/2pQanfK3U+OuTv7wfu1v67vl0ZZG?=
 =?us-ascii?Q?p1qje3zpxNFSL2tQdsPB4mOoQEAoLEeWYrvvi20UCbwB7o4cNX53DM12c7z4?=
 =?us-ascii?Q?XunF99QIBDM8ddZc/UoxlhksyDi149arh+FCkTER77gGEqvkdj6oYS8AO6dT?=
 =?us-ascii?Q?fMCEEdLJqXfgIHTaFi4zEsY1AItNbjMXLn1k3AH7ug+NNwRJ6d544laTDG4P?=
 =?us-ascii?Q?/7rPsPbpDMSywdp9D84yihUEcpY+rbAOzsgdTKnewv4fDSJn1COn8LmkAMVJ?=
 =?us-ascii?Q?jX7vZL9iy4sbfJR/+ham6BIN4xlYJ59rTbWFFO542jK6+cO/QrCPbRNJVBBz?=
 =?us-ascii?Q?otRqTXdO4yQ0ZB9NQkdSPNzTHBMMznBAAzfiHpHUzorXExwpa9crHavyklLh?=
 =?us-ascii?Q?nHRwdNMfiADEQT9Kp95ssN/NcRr9qrFcQPO0y7PTjRISrUg4Aco2nqfjJT0D?=
 =?us-ascii?Q?zjvpNB/owCOOLOo5agRsk0ImRfeC8QY/xac9xlh7bO6fqQtcoR+UlRpG7/5T?=
 =?us-ascii?Q?5ZfJRPR0wbZxzgShWQjjEp0/JD1dZTWmPvK62Nm9Y8568C7j7/LYSdJ4dKsJ?=
 =?us-ascii?Q?unOHLrwQAw6iwvgvKadJKp1WaP/5fdHWt5/vujIPMv7XQynQuNcKvzePaGOp?=
 =?us-ascii?Q?SepZnfnNEVgqUU5RU5rrG+5yjFVfeknNLZaWN2ygIG9r9BWgLvZJjMvZrD9o?=
 =?us-ascii?Q?DQOq5k+nVFMNn+LHu6i0dQPrkyZM2VW4VuvEeTj7Nx6dLeoR4rKgW2V4THGb?=
 =?us-ascii?Q?VMikavx/YECsygXXCP00WVih8mZyCGKQEVA4pCpn5/0BZ3q5C1+k9eXzMbYT?=
 =?us-ascii?Q?lr6IJJFiYznVOz9n3DbPCqmFY11iCfBXs9TyklPC1fuA5os3djgpVtrzokFu?=
 =?us-ascii?Q?0ZczNgvRuIHL3yYcZTGSodQADxIVa9aThVk16dnJQBLApHOdUut9qKqo2P8b?=
 =?us-ascii?Q?zyuCctBtbMkFWOVqs2oNrO+QlS2tOuj1QfgxlasJ1Uq9y/5t2qj+qW88VkVz?=
 =?us-ascii?Q?Se0mJziBA8KGIWbvL2cQsfmbn0SG+YF/SZugA++Pg1gd+N7ew4+ks6ehr+bC?=
 =?us-ascii?Q?G0EOC0TEpfau9F4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(19092799006)(1800799024)(366016)(52116014)(376014)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?iJfscb955B2hyG9BRKpnD+vIPeI+u2EOF2ns7TYg/i6sfNm4V6GzokqrpF7F?=
 =?us-ascii?Q?HOdVZYoojVkZkI2km/EKGJnlZ+rQI7jmdDjhGfMjIcQzjlj3PWwDHlNy5KhX?=
 =?us-ascii?Q?3H/vbWmpvb48slR9mOy8auMsNluSrWM3wZ8CTQ6ehKavaurYL1NqMkw1pMzf?=
 =?us-ascii?Q?8wGCgIg0QRtvMYglTbe+ivtJ+FIfkMXlKhe25K13AMCuGrrylmcMUOxgwKI7?=
 =?us-ascii?Q?iRHgyDqDRD/qrMY1hrBQ6rBS6Wzb7fO3U/cMn6m9mKOaewc1B0w99I8IaF06?=
 =?us-ascii?Q?VwbK1cU7s7/FactFR0YOnEYScDrCJggww7mylJtJU5mh/Lfgnnu45ZDTFk4D?=
 =?us-ascii?Q?vaKPPYwQ6PrasNunUzLG58rxQkkhxFmRYop+aGZIylpPHqMDNxqLNNzlGCFm?=
 =?us-ascii?Q?IVYNobWu5kAPn7Se+10iVv8ut41qatAUPTo+rPSdFkwL9EQHxxgSE/3PlRT/?=
 =?us-ascii?Q?WtmQlQBWYbH+Fb97D2Ff7b9/64nTPaKoW4w8p9LcnA9WJE1jIjFbv1kIOfD7?=
 =?us-ascii?Q?UAAdyNwlyK/uU7oj5c7GHbpqUtOvP30eVG1/Ih4dIvplQYQTld7wCyq83y0G?=
 =?us-ascii?Q?U17trndCxP4jZXb7/nrN8FR7rf+tH8PDLYSCKDoNslanHO1ai3nXM+oNWz+R?=
 =?us-ascii?Q?/uyaasTQdR0Pv40/9uvDOxsSJK+74cps9zJsIhzni4d5Q34fMwb0/jkwzZmU?=
 =?us-ascii?Q?Wx6PPlet+mDr5j3NJUrqJXPRLKYc0TqvOQPBXsRge4WuLgnHiN6FUzQRCDdA?=
 =?us-ascii?Q?FkT9wlMblq9l+3pejtrIs1QdybEJ+D8iuSjooRYcNWgV1rDtv1hlMKT39tCQ?=
 =?us-ascii?Q?/3ZiM9KTbxtuiXbV5n+qzPUoFQFvTPU740DZXLTpCeRLc8x0fRluokJJ8XVo?=
 =?us-ascii?Q?qy9ZjODJagwBi7lBzcdTuPh6LJvotahOuUIRvgOUjr6Cy9vk/VbWAv4TMMFd?=
 =?us-ascii?Q?dYEvOgpfjdD2s5N6r2lS+aiQ/d1DOhT3ks17UGD5CVZhE4yq2scH8Nya2/vo?=
 =?us-ascii?Q?5Zq+JH1CQsPLnB8ZUquRGPEHKB4iHQA19wS60t8RpjwtangMir4uyXtMJ8x8?=
 =?us-ascii?Q?sDxO4s8x5rEzSaTwwz3ztsaJTY/7+hfUYgcS3iZnF5uyvWeeQUY98+TwWpru?=
 =?us-ascii?Q?ipP9RRVbqMlk2rEKN0HQ8PM2nDTFOLSAkM7iSlmpDZSV5Cu94C8gxpD5t3zA?=
 =?us-ascii?Q?x8q8Suh90ZSg3T0Axl9oHZCDfaTTtaac3UuGLuvirpM4XWXQXGrX6jTWGb7E?=
 =?us-ascii?Q?yi1QluCfjT8WwrQ5Krd9Q0jILizwjaHcSW+728f6Vcai+E+0VtNVVmPxLVBm?=
 =?us-ascii?Q?nAe02HPC6O+uDgFGt0ezKNifgEwuMusIRQAUdpvgfHOjyEGCr9s/LPEY8fYF?=
 =?us-ascii?Q?Yn4sjBPbYAQ62ZA4XEJImSzdV72hyReVuuBZyjCwq6DQdfVTWJ5vJR1irHGe?=
 =?us-ascii?Q?2uN/Q/32KwoqGzQR88EPCOWHdvdD722Xt7QFUsSGDd9dBtjVgRi1rQcxbo/g?=
 =?us-ascii?Q?Z8KaDaXljoystAQfhEPNUeTBxhmBPPOUUuNXy3scB4j9WmbEcOufBh8ZHhGd?=
 =?us-ascii?Q?t3Mpo2LSlmXIE1SXfd2LoS4TJpxkqSi75uR91QMB?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f066b11-37d1-4c59-1b79-08ddeac8246b
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2025 08:59:08.3969
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: l9iLxcqyEaIBKcGkKRaYhD+6sYP9EE9ITk4c1b6w08MOb0pe51hqIofdwQtjI69khn7IaN6s6eNrPZNY7UfoOw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR04MB11190

Since the generic debugfs interfaces for setting the periodic pulse
signal loopback have been added to the ptp_clock driver, so covert the
vendor-defined debugfs interfaces to the generic interfaces.

Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
 MAINTAINERS                     |   1 -
 drivers/ptp/Kconfig             |   2 +-
 drivers/ptp/Makefile            |   4 +-
 drivers/ptp/ptp_qoriq.c         |  24 +++++++-
 drivers/ptp/ptp_qoriq_debugfs.c | 101 --------------------------------
 include/linux/fsl/ptp_qoriq.h   |  10 ----
 6 files changed, 24 insertions(+), 118 deletions(-)
 delete mode 100644 drivers/ptp/ptp_qoriq_debugfs.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 6cad6225381a..4140fdd6ccf3 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9816,7 +9816,6 @@ F:	drivers/net/ethernet/freescale/dpaa2/dpaa2-ptp*
 F:	drivers/net/ethernet/freescale/dpaa2/dprtc*
 F:	drivers/net/ethernet/freescale/enetc/enetc_ptp.c
 F:	drivers/ptp/ptp_qoriq.c
-F:	drivers/ptp/ptp_qoriq_debugfs.c
 F:	include/linux/fsl/ptp_qoriq.h
 
 FREESCALE QUAD SPI DRIVER
diff --git a/drivers/ptp/Kconfig b/drivers/ptp/Kconfig
index 9256bf2e8ad4..5f8ea34d11d6 100644
--- a/drivers/ptp/Kconfig
+++ b/drivers/ptp/Kconfig
@@ -67,7 +67,7 @@ config PTP_1588_CLOCK_QORIQ
 	  packets using the SO_TIMESTAMPING API.
 
 	  To compile this driver as a module, choose M here: the module
-	  will be called ptp-qoriq.
+	  will be called ptp_qoriq.
 
 comment "Enable PHYLIB and NETWORK_PHY_TIMESTAMPING to see the additional clocks."
 	depends on PHYLIB=n || NETWORK_PHY_TIMESTAMPING=n
diff --git a/drivers/ptp/Makefile b/drivers/ptp/Makefile
index 8985d723d29c..bdc47e284f14 100644
--- a/drivers/ptp/Makefile
+++ b/drivers/ptp/Makefile
@@ -12,9 +12,7 @@ obj-$(CONFIG_PTP_1588_CLOCK_INES)	+= ptp_ines.o
 obj-$(CONFIG_PTP_1588_CLOCK_PCH)	+= ptp_pch.o
 obj-$(CONFIG_PTP_1588_CLOCK_KVM)	+= ptp_kvm.o
 obj-$(CONFIG_PTP_1588_CLOCK_VMCLOCK)	+= ptp_vmclock.o
-obj-$(CONFIG_PTP_1588_CLOCK_QORIQ)	+= ptp-qoriq.o
-ptp-qoriq-y				+= ptp_qoriq.o
-ptp-qoriq-$(CONFIG_DEBUG_FS)		+= ptp_qoriq_debugfs.o
+obj-$(CONFIG_PTP_1588_CLOCK_QORIQ)	+= ptp_qoriq.o
 obj-$(CONFIG_PTP_1588_CLOCK_IDTCM)	+= ptp_clockmatrix.o
 obj-$(CONFIG_PTP_1588_CLOCK_FC3W)	+= ptp_fc3.o
 obj-$(CONFIG_PTP_1588_CLOCK_IDT82P33)	+= ptp_idt82p33.o
diff --git a/drivers/ptp/ptp_qoriq.c b/drivers/ptp/ptp_qoriq.c
index 4d488c1f1941..8da995e36aeb 100644
--- a/drivers/ptp/ptp_qoriq.c
+++ b/drivers/ptp/ptp_qoriq.c
@@ -465,6 +465,25 @@ static int ptp_qoriq_auto_config(struct ptp_qoriq *ptp_qoriq,
 	return 0;
 }
 
+static int ptp_qoriq_perout_loopback(struct ptp_clock_info *ptp,
+				     unsigned int index, int on)
+{
+	struct ptp_qoriq *ptp_qoriq = container_of(ptp, struct ptp_qoriq, caps);
+	struct ptp_qoriq_registers *regs = &ptp_qoriq->regs;
+	u32 loopback_bit = index ? PP2L : PP1L;
+	u32 tmr_ctrl;
+
+	tmr_ctrl = ptp_qoriq->read(&regs->ctrl_regs->tmr_ctrl);
+	if (on)
+		tmr_ctrl |= loopback_bit;
+	else
+		tmr_ctrl &= ~loopback_bit;
+
+	ptp_qoriq->write(&regs->ctrl_regs->tmr_ctrl, tmr_ctrl);
+
+	return 0;
+}
+
 int ptp_qoriq_init(struct ptp_qoriq *ptp_qoriq, void __iomem *base,
 		   const struct ptp_clock_info *caps)
 {
@@ -479,6 +498,8 @@ int ptp_qoriq_init(struct ptp_qoriq *ptp_qoriq, void __iomem *base,
 
 	ptp_qoriq->base = base;
 	ptp_qoriq->caps = *caps;
+	ptp_qoriq->caps.n_per_lp = 2;
+	ptp_qoriq->caps.perout_loopback = ptp_qoriq_perout_loopback;
 
 	if (of_property_read_u32(node, "fsl,cksel", &ptp_qoriq->cksel))
 		ptp_qoriq->cksel = DEFAULT_CKSEL;
@@ -568,7 +589,7 @@ int ptp_qoriq_init(struct ptp_qoriq *ptp_qoriq, void __iomem *base,
 		return PTR_ERR(ptp_qoriq->clock);
 
 	ptp_qoriq->phc_index = ptp_clock_index(ptp_qoriq->clock);
-	ptp_qoriq_create_debugfs(ptp_qoriq);
+
 	return 0;
 }
 EXPORT_SYMBOL_GPL(ptp_qoriq_init);
@@ -580,7 +601,6 @@ void ptp_qoriq_free(struct ptp_qoriq *ptp_qoriq)
 	ptp_qoriq->write(&regs->ctrl_regs->tmr_temask, 0);
 	ptp_qoriq->write(&regs->ctrl_regs->tmr_ctrl,   0);
 
-	ptp_qoriq_remove_debugfs(ptp_qoriq);
 	ptp_clock_unregister(ptp_qoriq->clock);
 	iounmap(ptp_qoriq->base);
 	free_irq(ptp_qoriq->irq, ptp_qoriq);
diff --git a/drivers/ptp/ptp_qoriq_debugfs.c b/drivers/ptp/ptp_qoriq_debugfs.c
deleted file mode 100644
index e8dddcedf288..000000000000
--- a/drivers/ptp/ptp_qoriq_debugfs.c
+++ /dev/null
@@ -1,101 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0+
-/* Copyright 2019 NXP
- */
-#include <linux/device.h>
-#include <linux/debugfs.h>
-#include <linux/fsl/ptp_qoriq.h>
-
-static int ptp_qoriq_fiper1_lpbk_get(void *data, u64 *val)
-{
-	struct ptp_qoriq *ptp_qoriq = data;
-	struct ptp_qoriq_registers *regs = &ptp_qoriq->regs;
-	u32 ctrl;
-
-	ctrl = ptp_qoriq->read(&regs->ctrl_regs->tmr_ctrl);
-	*val = ctrl & PP1L ? 1 : 0;
-
-	return 0;
-}
-
-static int ptp_qoriq_fiper1_lpbk_set(void *data, u64 val)
-{
-	struct ptp_qoriq *ptp_qoriq = data;
-	struct ptp_qoriq_registers *regs = &ptp_qoriq->regs;
-	u32 ctrl;
-
-	ctrl = ptp_qoriq->read(&regs->ctrl_regs->tmr_ctrl);
-	if (val == 0)
-		ctrl &= ~PP1L;
-	else
-		ctrl |= PP1L;
-
-	ptp_qoriq->write(&regs->ctrl_regs->tmr_ctrl, ctrl);
-	return 0;
-}
-
-DEFINE_DEBUGFS_ATTRIBUTE(ptp_qoriq_fiper1_fops, ptp_qoriq_fiper1_lpbk_get,
-			 ptp_qoriq_fiper1_lpbk_set, "%llu\n");
-
-static int ptp_qoriq_fiper2_lpbk_get(void *data, u64 *val)
-{
-	struct ptp_qoriq *ptp_qoriq = data;
-	struct ptp_qoriq_registers *regs = &ptp_qoriq->regs;
-	u32 ctrl;
-
-	ctrl = ptp_qoriq->read(&regs->ctrl_regs->tmr_ctrl);
-	*val = ctrl & PP2L ? 1 : 0;
-
-	return 0;
-}
-
-static int ptp_qoriq_fiper2_lpbk_set(void *data, u64 val)
-{
-	struct ptp_qoriq *ptp_qoriq = data;
-	struct ptp_qoriq_registers *regs = &ptp_qoriq->regs;
-	u32 ctrl;
-
-	ctrl = ptp_qoriq->read(&regs->ctrl_regs->tmr_ctrl);
-	if (val == 0)
-		ctrl &= ~PP2L;
-	else
-		ctrl |= PP2L;
-
-	ptp_qoriq->write(&regs->ctrl_regs->tmr_ctrl, ctrl);
-	return 0;
-}
-
-DEFINE_DEBUGFS_ATTRIBUTE(ptp_qoriq_fiper2_fops, ptp_qoriq_fiper2_lpbk_get,
-			 ptp_qoriq_fiper2_lpbk_set, "%llu\n");
-
-void ptp_qoriq_create_debugfs(struct ptp_qoriq *ptp_qoriq)
-{
-	struct dentry *root;
-
-	root = debugfs_create_dir(dev_name(ptp_qoriq->dev), NULL);
-	if (IS_ERR(root))
-		return;
-	if (!root)
-		goto err_root;
-
-	ptp_qoriq->debugfs_root = root;
-
-	if (!debugfs_create_file_unsafe("fiper1-loopback", 0600, root,
-					ptp_qoriq, &ptp_qoriq_fiper1_fops))
-		goto err_node;
-	if (!debugfs_create_file_unsafe("fiper2-loopback", 0600, root,
-					ptp_qoriq, &ptp_qoriq_fiper2_fops))
-		goto err_node;
-	return;
-
-err_node:
-	debugfs_remove_recursive(root);
-	ptp_qoriq->debugfs_root = NULL;
-err_root:
-	dev_err(ptp_qoriq->dev, "failed to initialize debugfs\n");
-}
-
-void ptp_qoriq_remove_debugfs(struct ptp_qoriq *ptp_qoriq)
-{
-	debugfs_remove_recursive(ptp_qoriq->debugfs_root);
-	ptp_qoriq->debugfs_root = NULL;
-}
diff --git a/include/linux/fsl/ptp_qoriq.h b/include/linux/fsl/ptp_qoriq.h
index b301bf7199d3..3601e25779ba 100644
--- a/include/linux/fsl/ptp_qoriq.h
+++ b/include/linux/fsl/ptp_qoriq.h
@@ -145,7 +145,6 @@ struct ptp_qoriq {
 	struct ptp_clock *clock;
 	struct ptp_clock_info caps;
 	struct resource *rsrc;
-	struct dentry *debugfs_root;
 	struct device *dev;
 	bool extts_fifo_support;
 	bool fiper3_support;
@@ -195,14 +194,5 @@ int ptp_qoriq_settime(struct ptp_clock_info *ptp,
 int ptp_qoriq_enable(struct ptp_clock_info *ptp,
 		     struct ptp_clock_request *rq, int on);
 int extts_clean_up(struct ptp_qoriq *ptp_qoriq, int index, bool update_event);
-#ifdef CONFIG_DEBUG_FS
-void ptp_qoriq_create_debugfs(struct ptp_qoriq *ptp_qoriq);
-void ptp_qoriq_remove_debugfs(struct ptp_qoriq *ptp_qoriq);
-#else
-static inline void ptp_qoriq_create_debugfs(struct ptp_qoriq *ptp_qoriq)
-{ }
-static inline void ptp_qoriq_remove_debugfs(struct ptp_qoriq *ptp_qoriq)
-{ }
-#endif
 
 #endif
-- 
2.34.1


