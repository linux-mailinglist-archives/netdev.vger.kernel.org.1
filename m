Return-Path: <netdev+bounces-79029-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD3C88777A3
	for <lists+netdev@lfdr.de>; Sun, 10 Mar 2024 17:46:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4D3C62814DB
	for <lists+netdev@lfdr.de>; Sun, 10 Mar 2024 16:46:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E235724219;
	Sun, 10 Mar 2024 16:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="l/EDyekm"
X-Original-To: netdev@vger.kernel.org
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2079.outbound.protection.outlook.com [40.107.95.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0D8921115
	for <netdev@vger.kernel.org>; Sun, 10 Mar 2024 16:46:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710089194; cv=fail; b=gsfDlGe7/zyr5F1G9YgTEtY11lm/m97R9LdsP0u33WnhWPDYb1ijK6snnRN7DVlX1KLdkop0r/AcN5+jH4wL9MMQQNGbRXxNYHgQzvUy//oScvSVh7ntCFyv4zGCNxxVxQs8KXp3M3Rk2L/oMFqzXP3r/wDbESEChrZd62+3aIc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710089194; c=relaxed/simple;
	bh=eKEcOpv0aK6MsGHnSbokSTQzo31QX87d00RPIsq1FP8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=GgdWYUBd927qFYSAMZE/CaknUFbVUo2Z8LcAh9pSZ7r9jT/uXFLRQOTEEZ55qn0cghgV7p91Bmgbx+9xPqI/KF6YzDFYYZKSccFtzUSivyQmWzPrmdKOWaii83CPaaMWnHP7G7d3qCtlxkHlMSN/zmBNkumQnanmZJ87ZqmeT5w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=l/EDyekm; arc=fail smtp.client-ip=40.107.95.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SGuC02j/4JAF9hAdk4rz2IBDh8JJBKCyjdaXjKPsyrkjOnVt5Y4z63qjMdrnDm3CM+sMoirW+EI30hDonmoV+06OkRjqFI7X/U2J/F6tEWUO5qBYgx66oA3iBtP4xwWo4eF84YBLMHAlOR+GuldhlWburRq9duuzhuJQGmM+r5b9Ztpz19iuJSqHDr+ieeIVDiz1LFh3ya20L+8w469vHVugUQTOD7EXlCNEnNMnsgePn7KA+sn5PgHsVAh2N1y0HUxGnhfG9xnFezd07TysUdd+g7K2SkjD6EwrV15khumuZiSHccJ/ciE3uhBNqakVklzh75a84YNS47xFc424ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jxmdiqLjZDJEVxiejDGwQWYShzexOe+fPk4VEer9FQE=;
 b=n8w1PJsSvWAbiz4Xop/os/1CEPWiyMJXfjPcXG9RZuS3vV2MDSIljpi/tHQKyk8ao46isMt8yKdGD4DVTlIj0a4Xje+nSupyoSFjNRCD6WNqA/+fYoO/YZdwYQnFBUBekBEUdmxV3ArlcH552l1E5KCyR16snrYQQTVbj/ZMYXcemCKSVDVEuYwYHZLahbSe6uykdcmCHINzea/3uouVeRmBcw4d/1fNzFi4ENxhfxwGeUumo0oPYAjQosjCQGkTLBpgkz4mSTNTU3Sllkl9MpFTP3Lej4Q+AtEbcw5IxUPzO3xYJBO9/gm0txvrHsrjJ7wwqnaGqQsCBCCcxOywkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jxmdiqLjZDJEVxiejDGwQWYShzexOe+fPk4VEer9FQE=;
 b=l/EDyekmM5rsU4qwBlCJMlYsTN5UP6xS+SFeamLcbcOoMDrZx5ZM5PbGUjspeTZXip08qflwBWHnwx/PRwZ26PbTQeihUAkADk5qQAQVBBaScVyiTxJTEhDX9abVb0AcmCih4AEcfB4k4w2wNLxYQ9rFdR8CBSzmplBLiHoztEad91f9TJ0MT9vlu2IlkstaaGJneicz3VmEwjFz70Pbf5A16Zx/8ye9JIwmutL46k6ks/qrMYKu9C4jeHCs7t1aJrD4j7P8lNFXVTIm8qdISsWx8N28JCHbI23w+ACjgKm4eRcTcepXnggFmzT62INJTxkDciHCY1PBIiB1y2/zWw==
Received: from CY5PR17CA0041.namprd17.prod.outlook.com (2603:10b6:930:12::25)
 by LV2PR12MB5965.namprd12.prod.outlook.com (2603:10b6:408:172::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.33; Sun, 10 Mar
 2024 16:46:30 +0000
Received: from CY4PEPF0000E9D5.namprd05.prod.outlook.com
 (2603:10b6:930:12:cafe::f8) by CY5PR17CA0041.outlook.office365.com
 (2603:10b6:930:12::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.34 via Frontend
 Transport; Sun, 10 Mar 2024 16:46:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CY4PEPF0000E9D5.mail.protection.outlook.com (10.167.241.76) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7386.12 via Frontend Transport; Sun, 10 Mar 2024 16:46:30 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Sun, 10 Mar
 2024 09:46:19 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12; Sun, 10 Mar
 2024 09:46:19 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.6)
 with Microsoft SMTP Server id 15.2.1258.12 via Frontend Transport; Sun, 10
 Mar 2024 09:46:18 -0700
From: William Tu <witu@nvidia.com>
To: <netdev@vger.kernel.org>
CC: <jiri@nvidia.com>, <bodong@nvidia.com>, William Tu <witu@nvidia.com>
Subject: [PATCH net] devlink: Fix length of eswitch inline-mode
Date: Sun, 10 Mar 2024 18:45:47 +0200
Message-ID: <20240310164547.35219-1-witu@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D5:EE_|LV2PR12MB5965:EE_
X-MS-Office365-Filtering-Correlation-Id: 002d71e2-2230-4edc-a7e0-08dc4121a2de
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	HrU3IrBpITequCMPRcIlBECJZqhDsnfCGREyJZQOs/0LXTI/HVb0O6ajeZp6vFjXsPDUwnRgLEcDFdp1PvuapRjz7+v+bwGU4qJJZAaBwYpbkUT+8rs1IPcl4UK7ArErpnskTxzde05dmSRZp5grG6zXy3T0+1WcktVaow2nzB/3Cpm4GnWfArZyb/K1MQXAbGl22Wg9zjbbLFXEeklPXBP+cSZdBRmneto71r40pQKoC8y1o6p1hp2vejIF7TMNSlmc8xTbshPTkLdPQ0SKdCv5eKJFyS/jtVtSs86l7LOFo6MTPVNMWDCSPkyCb5o0JYfT3LaPX7a5nkpZKQfDsQAVGkP4muMWmkaUI2SYv+BRHel9Te4Zov0QsgkpGb0AsaSXKuzwJ6Lu5v97ALyngcAZsm6sIehq7pll0BhGAmiO1oLRLOmqlzi74XTdLpuDhBOlmBl5vTQBHS+F8Fj0IZIe565G9yRiuPMRZ+grPAi96a8Gd/sIb0GJGbkvw/5UwxiwaAfZEIVsqdfrJOjMGiPo8LdOmKe1RpKpOifEeOMECnSpPdOdUmMm27msKSHw1Us4nh6Y1tZaswJcKmZfmfCrD9NEtQoTml7hcyscD21bMpSlrUSbstI4aYotSrVM4gqaNUa+pCKilwrKxhB97yvBcpnS33a48DFANP4ggJBzza0hrsE5kP+uvsroE9b4lCvCZBolbeFvNVpJGzMzRwnV3Kr/qpdaZzJFa3UnBE/MBdBcZSKDTyxEqxP81gV7
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(82310400014)(1800799015)(376005)(36860700004);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2024 16:46:30.0276
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 002d71e2-2230-4edc-a7e0-08dc4121a2de
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9D5.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5965

Set eswitch inline-mode to be u8, not u16. Otherwise, errors below

$ devlink dev eswitch set pci/0000:08:00.0 mode switchdev \
  inline-mode network
    Error: Attribute failed policy validation.
    kernel answers: Numerical result out of rang
    netlink: 'devlink': attribute type 26 has an invalid length.

Fixes: f2f9dd164db0 ("netlink: specs: devlink: add the remaining command to generate complete split_ops")
Signed-off-by: William Tu <witu@nvidia.com>
---
Or we can fix the iproute2 to use u16?
---
 Documentation/netlink/specs/devlink.yaml | 2 +-
 net/devlink/netlink_gen.c                | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/netlink/specs/devlink.yaml b/Documentation/netlink/specs/devlink.yaml
index cf6eaa0da821..09fbb4c03fc8 100644
--- a/Documentation/netlink/specs/devlink.yaml
+++ b/Documentation/netlink/specs/devlink.yaml
@@ -290,7 +290,7 @@ attribute-sets:
         enum: eswitch-mode
       -
         name: eswitch-inline-mode
-        type: u16
+        type: u8
         enum: eswitch-inline-mode
       -
         name: dpipe-tables
diff --git a/net/devlink/netlink_gen.c b/net/devlink/netlink_gen.c
index c81cf2dd154f..f9786d51f68f 100644
--- a/net/devlink/netlink_gen.c
+++ b/net/devlink/netlink_gen.c
@@ -198,7 +198,7 @@ static const struct nla_policy devlink_eswitch_set_nl_policy[DEVLINK_ATTR_ESWITC
 	[DEVLINK_ATTR_BUS_NAME] = { .type = NLA_NUL_STRING, },
 	[DEVLINK_ATTR_DEV_NAME] = { .type = NLA_NUL_STRING, },
 	[DEVLINK_ATTR_ESWITCH_MODE] = NLA_POLICY_MAX(NLA_U16, 1),
-	[DEVLINK_ATTR_ESWITCH_INLINE_MODE] = NLA_POLICY_MAX(NLA_U16, 3),
+	[DEVLINK_ATTR_ESWITCH_INLINE_MODE] = NLA_POLICY_MAX(NLA_U8, 3),
 	[DEVLINK_ATTR_ESWITCH_ENCAP_MODE] = NLA_POLICY_MAX(NLA_U8, 1),
 };
 
-- 
2.38.1


