Return-Path: <netdev+bounces-102345-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D682902936
	for <lists+netdev@lfdr.de>; Mon, 10 Jun 2024 21:25:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0CA93B229D2
	for <lists+netdev@lfdr.de>; Mon, 10 Jun 2024 19:25:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D594147C6E;
	Mon, 10 Jun 2024 19:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="TrvEcasP"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2087.outbound.protection.outlook.com [40.107.223.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0A9D14A4FC
	for <netdev@vger.kernel.org>; Mon, 10 Jun 2024 19:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718047537; cv=fail; b=LA0nOU/LOLnfAM77+mO7ZYDuTmc5j24PtEtCoHSqpHuCh1jb+LoItqlivunInOGoB97sC2kVwvKpQLTo6SUaFlpmt1rj/kWdOP8szVm787V9PHJdVj1kt5rzEiTEjZDVFJ1PQ9zhEvX1A20hLjymuu9Kj6cFjjUlnATtD/CGQLk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718047537; c=relaxed/simple;
	bh=6fne+8UqHsGrGPIMcZNpL18EaHfnYVajgj3G/pcYzE8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=sXZnmykYOMxcqgxfGfIVSCqeO4d3yHR1+/3NOdov+IY4+arWx2G35cgFxn9QtXsAPrOLrCY0l/oEM7botqOyjh8wzFo7widFosmmLbI84GONK3vdrYHmkNsYCxGf3+ZxRRL2/pydqp2wMMAzyqFzoIpz2W1t/gqSbQVCb2fEumo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=TrvEcasP; arc=fail smtp.client-ip=40.107.223.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Eq1vXWwvpKTNeMNzWIoH3OoWs5sZpfdTkAxw2Sxe7CvQERU1OIkEvfw8wF8jHkUDTxLWNYqwfqdRYYedk64RT3V2QycG0l15Gb9qR3ba4iSSeuxfMgcn4+rydKfX+6TpHOsd/0lINKUgOxIqQnNl3SReinH9gVKlMg4mpuH2vmKcQ3pINVzt50BO5B13y+XAKUoiDj3ahzky0SQHpKQYqX1dT6+Bn2PADxhUK/s7GfQLow4tsuWQrMnGcC+ybvL7lzVJASm3/+VdV9CvLj1HQDujtVBNZLonJ+ZMwOHSpF+oF39cTQTq+wEgiq76qouEfXFlTDB5beAGPat+F4TWdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WPbnT9544qLJc1nhGu8Ifw3rBxNJDltsp5eB26YfDzw=;
 b=Qe4M3Cllv+jwPQTl+Z3UfJC6cnME4+9PCB1iH1ApT3xoIx2rlzBdbbqadIWTeh9Tunug0D9lnV8XxDMteOv3qiLXZj35wgIj9sxMQYsAUH670ISjDfmFc7//JMLJYmr21Ry8LDU/Ry6CMzHmNJfonPW7H7McJylVx2aFP7yhgEm0B7EI0lhtRIZHVnhLkmVyzTeIl057RFfj101nxjKztKGuJ55U42Rcul0oQLaI/ggpzXjeVXnsBVAAZwSQM7sql+YZBGpMXB1f7DY+Vpx97MD77F9p+KRUkdwYklOL13j5EhJ03FeYIo2KUTTkReZ/0G9zqlmTPjNU26tYz+EPuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WPbnT9544qLJc1nhGu8Ifw3rBxNJDltsp5eB26YfDzw=;
 b=TrvEcasPekv4ddzQbExHOkqjcO96K3Dw+msEo5A4hgoqNvQoPIxCD0COUljcSzrsdJvzwYUxwBziiPYoYVrhDwLTiNbMnkGRIFx+r4IOFpwMkyW8vEEye5bgoXBtd5Lg4ayRg6+qY+XNy1+TRFK+AoaGm78AhdqnQ8wmeX1UcGq6seWVjYjWGidKudxNLZHzm2sK+dLyuy5D6sUvvQRiJ6XW/63xP889yuIv9d3JUJtnqO2Uq6t5RaAfzv2gw7d5K4bR5PzuR2dovpf1XifJA4+zlXH1vPYiEMbewerwVffir3KqgL/ylRfNIEJu5Jcmv4Yn6PScNnfPhhEE7XNwOg==
Received: from CH5P221CA0013.NAMP221.PROD.OUTLOOK.COM (2603:10b6:610:1f2::10)
 by DM6PR12MB4155.namprd12.prod.outlook.com (2603:10b6:5:221::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.36; Mon, 10 Jun
 2024 19:25:27 +0000
Received: from CH2PEPF00000144.namprd02.prod.outlook.com
 (2603:10b6:610:1f2:cafe::c9) by CH5P221CA0013.outlook.office365.com
 (2603:10b6:610:1f2::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7656.25 via Frontend
 Transport; Mon, 10 Jun 2024 19:25:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CH2PEPF00000144.mail.protection.outlook.com (10.167.244.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7677.15 via Frontend Transport; Mon, 10 Jun 2024 19:25:27 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 10 Jun
 2024 12:25:12 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 10 Jun
 2024 12:25:12 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server id 15.2.1544.4 via Frontend Transport; Mon, 10 Jun
 2024 12:25:10 -0700
From: William Tu <witu@nvidia.com>
To: <netdev@vger.kernel.org>
CC: William Tu <witu@nvidia.com>, <parav@nvidia.com>
Subject: [iproute2-net] devlink: trivial: fix err format on max_io_eqs
Date: Mon, 10 Jun 2024 22:24:51 +0300
Message-ID: <20240610192451.58033-1-witu@nvidia.com>
X-Mailer: git-send-email 2.38.1
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
X-MS-TrafficTypeDiagnostic: CH2PEPF00000144:EE_|DM6PR12MB4155:EE_
X-MS-Office365-Filtering-Correlation-Id: 8db954d3-e731-44bc-b32f-08dc89831561
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|82310400017|1800799015|376005|36860700004;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?uD2pWRNhergrBDCKNDhaK2ICvFQrIdoN2d8qJQNq556GGn3kQMVjPgWH81g2?=
 =?us-ascii?Q?3Ot0TXAx8lpzQboKTdRup03NGEGdMn7J7Jyua1HFGl1SJpi0rkiB6TwWLLmm?=
 =?us-ascii?Q?4DU330o7lXt5WgJ2Rr6HbQWmFeuWo4RViM5f9WF6xVTBYd5Nl6LzMfddu6C0?=
 =?us-ascii?Q?Bb4OS2/P876qD9e3yYELmwDQD1/RBZywpjWv+jN/unyXf8WDtN8YQdNoh9Jm?=
 =?us-ascii?Q?ZDmpNyrrPdzpajIg/FmyIIpwF9e125uaTtk7yakQdBFGr8euetk/MaaaKlVc?=
 =?us-ascii?Q?WNKa7AcJsdSj9mvQUeM2x9EIcbXp5uzfQ8PISXZxtpE5mZstpkljFY2HPmCk?=
 =?us-ascii?Q?rjp3LM8y9dlRqr8ZO0FYD+bFVZpatWG0pkzSorx4avtLK6hpM6iAcgVCmmmj?=
 =?us-ascii?Q?nf+ha8IR8CpLwaMzzuW2Fh/RgzAQccXFtcU8oA7IzgXwp0ARSwH6LtPB+AAH?=
 =?us-ascii?Q?WO3lR6oYtttiPLLb0kd5uLUx1U+v9JXTpnbjBgBcaRWoKz035/hnotURsrhu?=
 =?us-ascii?Q?AbdWnm6Rqfh6aBr/o8yhkWixJGRd1L7ibXLK7xyq+o7v0mNEc7FfGpYJrtHi?=
 =?us-ascii?Q?nlZqvKI2lLioSgCzOEOOIDo9yFqyiVZL/A8hQwddXDCiJ75fjUSSJLh8KKEs?=
 =?us-ascii?Q?BReH0JoJN7wjE7R1GC68eNrx9s8pWNWUoTaczYH2xfcAbDGl1ZYilE0jm88W?=
 =?us-ascii?Q?ljJOpvvlA8vmdanR33pibuyt8mSI0GEpiI2Ms3e9V3K+gsyIngN+tDR3awI4?=
 =?us-ascii?Q?tv1t4bHgcdmdnWLH+qPxbuObRNimo0ykTrDxdHZe4jsL7dz8LDlwQOsnGs7S?=
 =?us-ascii?Q?EuHbSI4QgNfMSmypzPPD6G8tbs97ShSAx5F4AcvLIFoQ7OL/j/0hio8e680c?=
 =?us-ascii?Q?+qxnfUkkIOKtqSD/zK4ZZzyt/8mF39riR6ajIRVymfVKZaHZgydbGmeOuMfc?=
 =?us-ascii?Q?NbiEL6BtInFbkID20A8vvPGMkmNCyC08fpoPhwUMMsIvBBVf9Rc0q3E5Edzn?=
 =?us-ascii?Q?6uhWHuFBK8eZATQE0zai+gsn1CZLas6Ky1ru95AGNt7cZfrjuG0IMyvF/AaS?=
 =?us-ascii?Q?QSPvjyeJc4bCcOrKBTXtHpn1MaaPY22eVi2ygBzkR9xGN+yREjpwk+qqiggd?=
 =?us-ascii?Q?y2fmRmayHRiKhWakdG+Tfioz79LF4PKWMywX1UKWP3lt/egoG4buNa+k+TFE?=
 =?us-ascii?Q?7JHxdoIPp7H+HLzV/Y/r8vRwUhC/O4ASMDBkg+KnPwWMGowmlOuba4nOmhq4?=
 =?us-ascii?Q?BqseA7XY0oS368TK+UTn8orRTEnh0jNdr4dNj5vPrS4t8AsYDxKCxrnPFOTm?=
 =?us-ascii?Q?nq3pqPprUDndBjQeIBXfcU1uVrUefv4b2yrQSqFhFnyDeZEDsSJGKFfXyLjL?=
 =?us-ascii?Q?5GDUXQzh1jGzQlbnT6qq+4t/J8VAtXsRQIaFlDH/Evp3QA0g6A=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(82310400017)(1800799015)(376005)(36860700004);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2024 19:25:27.0495
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8db954d3-e731-44bc-b32f-08dc89831561
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF00000144.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4155

Add missing ']'.

Signed-off-by: William Tu <witu@nvidia.com>
Fixes: e8add23c59b7 ("devlink: Support setting max_io_eqs")
---
 devlink/devlink.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/devlink/devlink.c b/devlink/devlink.c
index 03d2720225a2..4929ab08ac40 100644
--- a/devlink/devlink.c
+++ b/devlink/devlink.c
@@ -4761,7 +4761,7 @@ static void cmd_port_help(void)
 	pr_err("       devlink port function set DEV/PORT_INDEX [ hw_addr ADDR ] [ state { active | inactive } ]\n");
 	pr_err("                      [ roce { enable | disable } ] [ migratable { enable | disable } ]\n");
 	pr_err("                      [ ipsec_crypto { enable | disable } ] [ ipsec_packet { enable | disable } ]\n");
-	pr_err("                      [ max_io_eqs EQS\n");
+	pr_err("                      [ max_io_eqs EQS ]\n");
 	pr_err("       devlink port function rate { help | show | add | del | set }\n");
 	pr_err("       devlink port param set DEV/PORT_INDEX name PARAMETER value VALUE cmode { permanent | driverinit | runtime }\n");
 	pr_err("       devlink port param show [DEV/PORT_INDEX name PARAMETER]\n");
-- 
2.38.1


