Return-Path: <netdev+bounces-78870-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E4EAC876D25
	for <lists+netdev@lfdr.de>; Fri,  8 Mar 2024 23:32:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 99680282E3F
	for <lists+netdev@lfdr.de>; Fri,  8 Mar 2024 22:32:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B7D31BC3E;
	Fri,  8 Mar 2024 22:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="W06bhtfR"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2069.outbound.protection.outlook.com [40.107.92.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E1D93D68
	for <netdev@vger.kernel.org>; Fri,  8 Mar 2024 22:32:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709937124; cv=fail; b=oRY/ETw9KGmck2lUUycxojZ2gte8lzP0U5UDoDpEBGGQzuqcHjQgUjXP5vvwW61BABHrXLEX5fTUi/w88BXex+nsh2wpEQ8Iao0aFa7tFL7BV3kJfhTtmMYD43KBk12asj0tWbr/10XzA4Wl5+WAe2rhRpZ5g9C2bLE4v+OVM/0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709937124; c=relaxed/simple;
	bh=vLk73zB5+EHu2ZrT5ztLeZIeGngXHicK5m0ccYPfUIM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=O3M7UoMOp+L8DElcsGkdfYQJOZjhK0r8rb6J3fkwlUsTxCp6m9D9498fT6hNm6RzhNAeTifyKvYxrXYh4KB14fF/DTeuMqyuLsg88jDGDvYfmiFG1uIuD+o7TbKu/uM1uv5vyDPkYwRDjD0eesc51DxTIFFHF4ep3B8M53BpW98=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=W06bhtfR; arc=fail smtp.client-ip=40.107.92.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Wj35fd12cOToSBL8TD3MwR9Xi+FqM5tELXJrPnJ/0SrrwyYv/F8r2H9y5t7yMyChRrOaOtwv15GfvVBDoOmyelTetCezH7ybUtrJTGC5PpFBen5/SUC4M/1v/30U0jp/H9c8k2pE0afMlMdaaqb6+9hD7z5vo83UOg163+sr/cxtVSduEEVLUQhwRKpWqnv3AXGw6n/aDYTFSf03o8hALi8jW7oSg3GIyXjRMGk5hCScGk2l+WNHfEK2lE6Luk2YpQqRaLXjkkMTNLEK5LUlWzKQqfrwPuSK2bbiSkduBFWDVw9P/wMZBjiIViQM3sUA0JhC0GQHQkLnZMMG/h4duQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f15yH0p3kTwsijqV+gBHTcxTr38OGz4050w/r0vCpkk=;
 b=Uq330KEO6/f+bHrdpn7mSz4JoK4UadNcer7z9gmju4Hv3UZqC15RtCOrClEennibttvLtsTB3i83+m41nuZhQHQ8QB25gjb0OQ99X62BLXHMUk3/g1/gPOueMy61lIdHU9clB/6LCg4GdzwwnEUQwgzOcO14p8TU9TDfX+znG4AGsFCffgJhpQHPy3cX4/lzOkH2+xqFemk5GspDUDy9EB7siuh+aauYYi7t9qbhZzjuigzo5aip7Mhh80Nv7R2tKkndMSDnV7AlMN0udKX4IMIaUs9jdcYzO7guJ+dvfZqEJJ5Ogrh7NjnPV16njpBAK3PaXe22AJTrWMOldvn1IQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f15yH0p3kTwsijqV+gBHTcxTr38OGz4050w/r0vCpkk=;
 b=W06bhtfRTBq0Eruu9SO+We27JlfiHf9ll0/zp8ZtLlLGwqdUFuKwY/iZrgDaWPWrnRMf0cFlWGWg8VospOHET4pUDMeYW9xxqIWce8EfneRIzUWdeY/j2AH6wuKcgkRqiThzT6qS4Tt/PQAGSDL+EZLJWrZd5Q2MHQvXep0j2IIM8s1UwABrnRbCzNWJA/MqCxaxxctUb+WWUYZrOqmQQrp5AOtVdydPr9BKRp0mB1udKSxzoL/YjEAaSeRriDzRuiu9COxCMQwngoe2FllgbevBBRCPIbH3147EiJ1FLqDuSZFVky0ewMWoL4oMEqn1+gQzC0c+t1VwlzfW88d0ww==
Received: from SJ0PR13CA0136.namprd13.prod.outlook.com (2603:10b6:a03:2c6::21)
 by DS0PR12MB8816.namprd12.prod.outlook.com (2603:10b6:8:14f::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.26; Fri, 8 Mar
 2024 22:31:58 +0000
Received: from SJ5PEPF000001CD.namprd05.prod.outlook.com
 (2603:10b6:a03:2c6:cafe::72) by SJ0PR13CA0136.outlook.office365.com
 (2603:10b6:a03:2c6::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.10 via Frontend
 Transport; Fri, 8 Mar 2024 22:31:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ5PEPF000001CD.mail.protection.outlook.com (10.167.242.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7362.11 via Frontend Transport; Fri, 8 Mar 2024 22:31:58 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Fri, 8 Mar 2024
 14:31:44 -0800
Received: from yaviefel.mtl.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12; Fri, 8 Mar
 2024 14:31:41 -0800
From: Petr Machata <petrm@nvidia.com>
To: David Ahern <dsahern@kernel.org>, Stephen Hemminger
	<stephen@networkplumber.org>, <netdev@vger.kernel.org>
CC: Ido Schimmel <idosch@nvidia.com>, Petr Machata <petrm@nvidia.com>,
	<mlxsw@nvidia.com>
Subject: [PATCH iproute2-next 1/4] libnetlink: Add rta_getattr_uint()
Date: Fri, 8 Mar 2024 23:29:06 +0100
Message-ID: <501f27b908eed65e94b569e88ee8a6396db71932.1709934897.git.petrm@nvidia.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <cover.1709934897.git.petrm@nvidia.com>
References: <cover.1709934897.git.petrm@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001CD:EE_|DS0PR12MB8816:EE_
X-MS-Office365-Filtering-Correlation-Id: b16b7a93-789d-4ece-cd6a-08dc3fbf910b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	6PhPqXIhIHA182j7f4EKYwQeQHUdbvv2govisD3R7yXql206XgGOMNyz1zAMpp9rE/bsJ/JLbgWjfHhzhaux6+BYPFF+5S9k/ApdIZaOzzbphY9sHJkrfnAKWNXRD/fjUXDeUaJLbpwBSWbjMecqUb1mh+oTl9/sMlKVHwLFb43vYBdUp+hcIR7ROGrwC1iDBSxPcQwEXCv98JZVbwzOV6IqvACmwJ6PhxBQgsp8G0bCXnx5pTb3HI5F0bPKXupOCOEZlxeVcYidgObUMVoXUjLAEeJ3jmzm5KyRJ1rqkh8qZwvlMXCrIN2owKCU+q4Os9dz8yiQTWUhGxvlVLrY9itX64M4f8P36JwFzwRuAbC3RM4dGCBLZ7XmhIsXxjb5mhONg8H9ZjwIw3hIU5kJmCkIsvVCoZS1URq/VGC2FuWFNdVNZoxu7BX3q9qFhIVZz9rpC9kjnrs3Svol/W5BDygn+ubiFD3488TgfloVuM14wHVo14qe60In58va12JU9lI/LEeOXYVNJB3LwxRi7d7CKk0XrSCWXZHsXQMVLmIQBHXS50SDE0Oyqsz0jb/esBKqzH2leDXhhmGp3uuuAPDMshahMREzkN+sY2mQ5mf9fjbJHINl+xX16Lt12+D27F53GxodRTbT0B44HyW9DuPKGzc5sRphxhnXUU+g1rxhzhR1X/hOJ4itwIkudzal+pWbglnm2QBcklx6YMbRYqzA5bsee9JT+/p7kuHQPkUN+g8WaR5nSbnraGjRZFV+
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(82310400014)(376005)(36860700004)(1800799015);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2024 22:31:58.4228
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b16b7a93-789d-4ece-cd6a-08dc3fbf910b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001CD.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8816

NLA_UINT attributes have a 4- or 8-byte payload. Add a function to extract
these.

Signed-off-by: Petr Machata <petrm@nvidia.com>
---
 include/libnetlink.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/include/libnetlink.h b/include/libnetlink.h
index ad7e7127..a1233659 100644
--- a/include/libnetlink.h
+++ b/include/libnetlink.h
@@ -260,6 +260,12 @@ static inline __u64 rta_getattr_u64(const struct rtattr *rta)
 	memcpy(&tmp, RTA_DATA(rta), sizeof(__u64));
 	return tmp;
 }
+static inline __u64 rta_getattr_uint(const struct rtattr *rta)
+{
+	if (RTA_PAYLOAD(rta) == sizeof(__u32))
+		return rta_getattr_u32(rta);
+	return rta_getattr_u64(rta);
+}
 static inline __s32 rta_getattr_s32(const struct rtattr *rta)
 {
 	return *(__s32 *)RTA_DATA(rta);
-- 
2.43.0


