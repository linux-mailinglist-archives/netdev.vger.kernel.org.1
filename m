Return-Path: <netdev+bounces-65738-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 10ACF83B88C
	for <lists+netdev@lfdr.de>; Thu, 25 Jan 2024 05:01:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8328E2840AC
	for <lists+netdev@lfdr.de>; Thu, 25 Jan 2024 04:01:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2D6E6FD1;
	Thu, 25 Jan 2024 04:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="JzPvh0mb"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2077.outbound.protection.outlook.com [40.107.92.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 229EC6FCA
	for <netdev@vger.kernel.org>; Thu, 25 Jan 2024 04:00:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706155260; cv=fail; b=O4BcFZs4g8tHG0DvQqBPlxvsxTYQdVAuDHakcDIvQTlYDN/sIHaF+4/FLC8JalkYyAEpu2yYaOvtNJ/zE11ZfzNxJP5JXAOKALLYQNHCEV2OiXjAMHyZAoWvWBai2WEsK3UmOzi+iLTSb5qXI/fdARLKFoWsTWKHGDHvb46LOgQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706155260; c=relaxed/simple;
	bh=HxvzL+sd7NkdmDTom3D/nDBowNb3xrHbUJn09J9UhPw=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=SaaUKxYYBLXPfFVS31HDPj7ZU71rUz155Zvr9HlUIlXNkJxxAiFTYR4E9bBfUdoCqmgetexpHyCbwEzKg5C3nrVgjZIuPuX0qxu82ndmBP9Mn+yIaRw4cLQnWNG0QWiC0slW4yK87GAS8mU43Dh1DlXE2r4Mo343BYGRFuW3eXw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=JzPvh0mb; arc=fail smtp.client-ip=40.107.92.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Zth6Gn9k2pN7Xgg+sLJMSUzZGiYHVhdI7nTJYylGMuKoa2vtfOPVl+WCIFGM2oCUSGRCxWT/RziiRvZa9x7KGCAhjmuDjDzB7MJ7z7FOBTWuO/OhbfFHKR8q8eJMAW522iGDGXPDuyeblY8PY3AMwYnW1dybdApPL4j52mS7SvIgNmJ4KzrG1g5RtnzCFTKzt8d98ArtDPe7r4mKx+9Ax3DHGy21UT7rDl13jd3M0ad8953vtzDQaaTiTjnhWomr5P1oiD0zPI4ZNZA+3gUmJMzqn6J1e0fDCDW8CwJpYeGuuUaGQV603Kmm9/xjQwVz8VzwixhQijJvnNnu3AaeAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QPcCzGdjzrz/2274vB4F1ajuRAmMWWbDWh/+huQR7Ks=;
 b=LZJcKRdUsg7TgsLjrertzVOCJ8pcSjBWPUMiB7SVxFKxxTygkmrVDfwGlUSzrlk9neldajFSBN1DqXNOPyqLlun5WqnWC6r7M8MxNtuDdUEwGzLVxI1so0awjWPLLDp8g137uQ9OdofqWIYwfHx2I2GVvZ926e1Y2g6gEwBTyt2tPS0cnipqpb1VkS4fcL5ymnSCtLguGqnMYvdXR4bYhrXdtFY43wsG4G59AH4E6Pt0jA6aXFGiN8OuZscYRD2gUjZQsOKX96hRLOE+hbB0qY1aWk6GjLyp/iBU/IExqIIiGYp4M3O5W2AYbQ60mbjyPZbTbzz/7jFDHzye/XBUPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QPcCzGdjzrz/2274vB4F1ajuRAmMWWbDWh/+huQR7Ks=;
 b=JzPvh0mboeOpe8pCrmN5cM596s6Ip+xryduzylVAxeht43XxZsEO2Vn61RXIWXMiS7Xz9ieACMqFbOfJyrWNrESy4GPdlaCg1z99FpqgUBX+vqPG6zL8h/5fVhhRqFVf9z8663yi4IrOcB3j35GKuj0jBQJjpQxQR6sk2XsLKE1Ee2m/KJ4a/qIQZrR4sxbViS78U/OTiviSd71HB+bPZRQiZdf5jRLcBi0mPJ0mizeOEwtZE2pbrDY+AHgfs/zGCnAOKQtKq6dzobcSjrXMLoc0R2Ulvt1ncqlxWPXdna5dBaRmz84JdbCFAWP8fCcb7g0xrS4HPgRrkbnEWTmC7w==
Received: from BYAPR05CA0043.namprd05.prod.outlook.com (2603:10b6:a03:74::20)
 by CH3PR12MB8076.namprd12.prod.outlook.com (2603:10b6:610:127::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.22; Thu, 25 Jan
 2024 04:00:56 +0000
Received: from SJ1PEPF00001CE1.namprd05.prod.outlook.com
 (2603:10b6:a03:74:cafe::e5) by BYAPR05CA0043.outlook.office365.com
 (2603:10b6:a03:74::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.21 via Frontend
 Transport; Thu, 25 Jan 2024 04:00:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 SJ1PEPF00001CE1.mail.protection.outlook.com (10.167.242.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7202.16 via Frontend Transport; Thu, 25 Jan 2024 04:00:55 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Wed, 24 Jan
 2024 20:00:43 -0800
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Wed, 24 Jan 2024 20:00:42 -0800
Received: from vdi.nvidia.com (10.127.8.12) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.986.41 via Frontend
 Transport; Wed, 24 Jan 2024 20:00:42 -0800
From: William Tu <witu@nvidia.com>
To: <netdev@vger.kernel.org>
Subject: [PATCH net-next] Documentation: mlx5.rst: Add note for eswitch MD
Date: Wed, 24 Jan 2024 20:00:41 -0800
Message-ID: <20240125040041.5589-1-witu@nvidia.com>
X-Mailer: git-send-email 2.34.1
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE1:EE_|CH3PR12MB8076:EE_
X-MS-Office365-Filtering-Correlation-Id: 082dc83e-2370-4690-614b-08dc1d5a3b44
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	06HS8oe8c6Zml05yDI/gyKdHgIb1PhtuyQJJn/0R7+WLgk4oeTzOcg/arEUs/+P2L+qZ6x+EzLfuORzWxLnRrSxvX7NQ3V20fWBxtZ+2WAyAyYB4YkVCbkouzUvBWwRweUYQFCeYOwvJT4TxloOLNQfKNsPH8sjn1swbwd2iJtpUkqeMPy+sfBeQtNBSAg0c4gaQpfDkqWPiXX/5nYdeudHcWv2NgvLZViLr6VTR8WEtow9jgUqu/W0x/HI7MrcuL4qfCyVApnDpzuKe8JAG95x0axsZxSnzLghOrTGo8l/hZjSCcY9XXtxvMrTyjd+NxYTTGymLYVbMG5qlCpP7ZChzk67SjJ6MfTTMJcsd/7JM1evuI79fcM4Qfrq7Ki/oWbO557R24qjtpOo7rbFWU7h7F1xAAQYSomV6H7QOvTWMo5arAWiiFzS6gKStFsZZN5CErgPQYWRU1VwHDdJme518aiYgVxJzHpXwjUjxMpH0x9WaIXRkvx4WwGvY+zruy/KjuJWjh1Os1q2oah1xlZFmbPynIBQmNvZhuVPThOnQcN6aDUtZeIPEinwf2S9HLsLmjIATKjeXts93K38On2KJmEE4B61QBhGL4iVWhKqIYT6TWdwtm71aoFdYGH8lrebme9vtnQIhOpOhaUWt7Hb+uUs1c9P4dbpBKWlBn06k2jIx1v5X7f10HbfdLpO4SH1zmdkyTEdgU7ZU/EmH/e3T0xGlRlNiQ6BDgCIOW2PUoQgPv/kY1pmsJwFEH4Lt
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(136003)(39860400002)(346002)(376002)(396003)(230922051799003)(451199024)(64100799003)(1800799012)(186009)(82310400011)(46966006)(36840700001)(40470700004)(40480700001)(40460700003)(1076003)(70586007)(5660300002)(316002)(6916009)(36860700001)(426003)(8676002)(26005)(8936002)(336012)(2616005)(70206006)(2906002)(83380400001)(47076005)(356005)(7636003)(478600001)(36756003)(41300700001)(86362001)(7696005)(82740400003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jan 2024 04:00:55.8054
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 082dc83e-2370-4690-614b-08dc1d5a3b44
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CE1.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8076

Add a note when using esw_port_metadata. The parameter has runtime
mode but setting it does not take effect immediately. Setting it must
happen in legacy mode, and the port metadata takes effects when the
switchdev mode is enabled.

Disable eswitch port metadata::
  $ devlink dev param set pci/0000:06:00.0 name esw_port_metadata value \
    false cmode runtime
Change eswitch mode to switchdev mode where after choosing the metadata value::
  $ devlink dev eswitch set pci/0000:06:00.0 mode switchdev

Note that other mlx5 devlink runtime parameters, esw_multiport and
flow_steering_mode, do not have this limitation.

Signed-off-by: William Tu <witu@nvidia.com>
Reviewed-by: Jiri Pirko <jiri@nvidia.com>
---
 Documentation/networking/devlink/mlx5.rst | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/networking/devlink/mlx5.rst b/Documentation/networking/devlink/mlx5.rst
index 3f70417cf792..16700c1bc963 100644
--- a/Documentation/networking/devlink/mlx5.rst
+++ b/Documentation/networking/devlink/mlx5.rst
@@ -105,6 +105,10 @@ parameters.
 
        When metadata is disabled, the above use cases will fail to initialize if
        users try to enable them.
+
+       Note: Setting this parameter does not take effect immediately. Setting
+       must happen in legacy mode and eswitch port metadata takes effect after
+       enabling switchdev mode.
    * - ``hairpin_num_queues``
      - u32
      - driverinit
-- 
2.34.1


