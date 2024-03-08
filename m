Return-Path: <netdev+bounces-78558-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A497875B73
	for <lists+netdev@lfdr.de>; Fri,  8 Mar 2024 01:16:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E58BBB20EE3
	for <lists+netdev@lfdr.de>; Fri,  8 Mar 2024 00:16:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE8C9163;
	Fri,  8 Mar 2024 00:16:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="UgVda4S1"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2058.outbound.protection.outlook.com [40.107.243.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CF53363
	for <netdev@vger.kernel.org>; Fri,  8 Mar 2024 00:16:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709856983; cv=fail; b=haOqgZ/FF0J+Y5qnu3hg18WOuw+N/nHkf+piwQAlGY1VyLJvVTXSRfmBa/12Wi7TYmFN5z6v98SAul7YKj4z9SrIfwfrAJX+1TxI8nPPUDErSu0Yz2l1wnS50yzSax9jk4tMBvk4saPIQlLXLW4c6hVBqy/C5nixS/IVf8vRpOM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709856983; c=relaxed/simple;
	bh=tYlZYlVhjoY6Ku+LYYqnBBI3dRQMlVJDB6RnXJ2lXqs=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=mMkk2A3xccSMqVlu9eAzRYwbVuO6p0L3qARhzacUIPYuBrBzmZh1xQzHevC6Mndm5GpkFi48iD5+EuD8ZPbiExHfXF8VSk/PDGnQCiy0Rj2m9fpSgo+U+OJ92c+lfyfhlp909ob64X6NwaSU4QsGH7A6t6DT7N4AB6QSURyGAts=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=UgVda4S1; arc=fail smtp.client-ip=40.107.243.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SkbwQdgAXZSir4aXVqd3fTgLV/hR7CXSm/2jyF8sASfO8CdqqthgZMz4Na288X4h08CnK4t1ZjVWyi25KEeJ7nj0cF33M5O+JRV+kRBMmSPjrCYw0wNHTt4IUPNIlXD9+pBIycRXHkGPUe/EVf61LHDqGPpCXz2hcx3cgQ5zU8edyjB7ee1t/HgK0pyOFbhXmWfl9+HITjRZXMgwBfd+5xLU14/7iAtRwIpUtOETLXnV1gbyar+OBl2h2CyLZ34ghoeVaPjulqjrXHatN4/YNStH4hf33N237gOuZfIDYrz5aAXRn3nUTEFdnwLiedKk/xedx2OENQKiGvMDK9Encw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Azyj4qhKCfRqAtCY/lNhRe1lgi3N9z6ZDNrkU+BoPr0=;
 b=CgovNyEDV3keB6Lu6qbzJZlvoMXxGkSJFuassdBmAdk6eARMp8AVRxhpQXbw7339lSR6zL8xtzlPoVdfYw8sp9sIKbm+amd93pj+J0ssBsPV214q6mz8M1cKSGEL7VOYUlICSKeR7IWHqzK9lVyhWHWZKGjVjnKW2n5iRVhjT3SURmGSmQjEncXoIYTTZ3X9ywWlWkD27IsAWRtFkboBtpjX2vA8gwfCZ+8wmTM7Zr8uHJbAwC3tHdgA3g/PhYm9o56Ury1m9nwQffmlgpfqGW+Vx/poz/FivVWjScP2dFM8TS9RcfQoOANP3lNxtHyjq8ltw/OR/+41ano9ALqAgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Azyj4qhKCfRqAtCY/lNhRe1lgi3N9z6ZDNrkU+BoPr0=;
 b=UgVda4S1+dLNUZSK/nR0MfM59Q+SOz8RzVJ5OIn5HIJx0mz8lTJo9BFKUtIsWGqmYYC36M36N8pZZtp5W68UgVCPjwOzlsQO6A5ovv37qbXWEsfkgMA5ftA1FwGkf+fVcawNRJjhkWwE+o2D6BEQWzyOM+d/MoSEDivEVTs12EFG3fzy+gmCBrZ3UzAI0wklU39lk2feqZn5QriSfeigOWrEkEF4akh13xUXkmZ6MRQCpex84gc3NNzXluWsR0eBPXlES3ETj1QlkK0+Mr7AANORFLDsXPi8PPXc48qodsTcIAMCu6H2+mj8bRBWKjB6BTblh9rvgovvYg3PAejSlA==
Received: from MW4PR03CA0303.namprd03.prod.outlook.com (2603:10b6:303:dd::8)
 by DS0PR12MB8527.namprd12.prod.outlook.com (2603:10b6:8:161::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.26; Fri, 8 Mar
 2024 00:16:18 +0000
Received: from CO1PEPF000044F4.namprd05.prod.outlook.com
 (2603:10b6:303:dd:cafe::46) by MW4PR03CA0303.outlook.office365.com
 (2603:10b6:303:dd::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.26 via Frontend
 Transport; Fri, 8 Mar 2024 00:16:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CO1PEPF000044F4.mail.protection.outlook.com (10.167.241.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7362.11 via Frontend Transport; Fri, 8 Mar 2024 00:16:17 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Thu, 7 Mar 2024
 16:15:58 -0800
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12; Thu, 7 Mar
 2024 16:15:58 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.7)
 with Microsoft SMTP Server id 15.2.1258.12 via Frontend Transport; Thu, 7 Mar
 2024 16:15:56 -0800
From: William Tu <witu@nvidia.com>
To: <netdev@vger.kernel.org>
CC: <jiri@nvidia.com>, <bodong@nvidia.com>, <kuba@kernel.org>,
	<witu@nvidia.com>
Subject: [PATCH net-next] devlink: Add comments to use netlink gen tool
Date: Fri, 8 Mar 2024 02:15:46 +0200
Message-ID: <20240308001546.19010-1-witu@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F4:EE_|DS0PR12MB8527:EE_
X-MS-Office365-Filtering-Correlation-Id: 5b0b4b74-b747-4650-391f-08dc3f04f997
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	68gSvXR7+LqqMrtOV2kG/h+7Q3yiIxA9/A+txF1/HfTNpmjTWgCNyzCklYYGBO+VSuVsYtjeegikhLvt/IEYcdwReqekExzozBD+eieWLI9d/HUqVB0RlK7Gg5lWLLLmxJGKtMtmSlmX/i5SdJhOonrjpHZfrzP5/nyi77bhyo8LT0KZKKbvVOqW3/H6ix2R41LpvYPpiyYbUdNJXGN6uYetbGLw+mfwVPDSWHQJRDKDLQkL4t0zlPmGElUDep0YpN/ojQ7mbKIgV70kZIFeH2gDo2iWRtJnnd2Yqcab03aytTCSh1BJQLmseh44QWuxMF1fCgiwydR6uvIhK8MEbuPegUhOsOo0f5imVAoVTKhrmdgWTw+OrMXmuciy07jWTdH8F6kxa+s7y3JpzjxQsoi1sXbyKBesGRDyXLcmuxU9/W9RY3Dh+uR8lfjr+/0RjWqCOfrovosyqjcMsFvURL5V8qSfzK3pOgTZwRw8J/HVL7jtuHXVmVE54m1R4uqu6947XgO1WWpRu9ailJyUt3c1q41H6qPiSuh2I0UFL/n+GUEBuKToADJHNcUNlyt7UWZxxY8pcak+RlM8Vr3o+g0rtHLwiGo9qFM25qkUNvWhqb1YAy9UnBHQAYV//sFKRL5wLque3Vk0Js+ivCGT575mUqvWCK7YlvFiArZukjzlJj7jlxF+BXMVtAITa6RToo6v0fbk2grT5+S+42aF43IAoTrxSt5Qyl3weaC1pOhV/PIIsGgu4+VkT6o4Jy13
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(82310400014)(36860700004)(1800799014)(376005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2024 00:16:17.8842
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b0b4b74-b747-4650-391f-08dc3f04f997
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000044F4.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8527

Add the comment to remind people not to manually modify
the net/devlink/netlink_gen.c, but to use tools/net/ynl/ynl-regen.sh
to generate it.

Signed-off-by: William Tu <witu@nvidia.com>
Suggested-by: Jiri Pirko <jiri@nvidia.com>
---
 include/uapi/linux/devlink.h | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/include/uapi/linux/devlink.h b/include/uapi/linux/devlink.h
index 130cae0d3e20..852ceb21ee69 100644
--- a/include/uapi/linux/devlink.h
+++ b/include/uapi/linux/devlink.h
@@ -614,7 +614,9 @@ enum devlink_attr {
 
 	DEVLINK_ATTR_REGION_DIRECT,		/* flag */
 
-	/* add new attributes above here, update the policy in devlink.c */
+	/* Add new attributes above here, update the spec in
+	 * Documentation/netlink/specs/devlink.yaml and re-generate
+	 * net/devlink/netlink_gen.c. */
 
 	__DEVLINK_ATTR_MAX,
 	DEVLINK_ATTR_MAX = __DEVLINK_ATTR_MAX - 1
-- 
2.38.1


