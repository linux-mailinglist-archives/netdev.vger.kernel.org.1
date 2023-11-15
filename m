Return-Path: <netdev+bounces-48076-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 948567EC757
	for <lists+netdev@lfdr.de>; Wed, 15 Nov 2023 16:33:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1F97A1F279EB
	for <lists+netdev@lfdr.de>; Wed, 15 Nov 2023 15:33:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4345439FDB;
	Wed, 15 Nov 2023 15:32:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="jXizO+PK"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7257D39FCB
	for <netdev@vger.kernel.org>; Wed, 15 Nov 2023 15:32:53 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2086.outbound.protection.outlook.com [40.107.244.86])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70A5A101
	for <netdev@vger.kernel.org>; Wed, 15 Nov 2023 07:32:52 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EyhGcuwHf+nD7CKR8OXAgSLL3yGaqmWFhswSpNnV2t+nHRKOJ2eLdV4oF8xPkkaacgnek3bTnVNYIYA7vIpcRYFC3OkaIwrWXOkefBBGq4dsolHeJiEu9Hg2HXD9hyPQYqikdOu3JAqYfqKCNzFfG6SdnjEx5s4xgv8aSmdNwN7EpY9OtuiGR8fuFwhlkkMfB54pLx57gMRz0TFqtNMDUcb+YAdU/BTFhfWgUP78ZKvBMelkP6uVHJz4dBgxV88O8qsAdXg0qaRl9MteIxbdz66a7iZYutAf9JitVhTuCPMmfuSIhaLokLp5zW7klgWA1u5C7MvGCODAmfSbEsJSRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UVQTH7ZcsZz7Yw8xYV7AHLzAyaeBQ0wlzDhM6CRuZro=;
 b=Rl3IH+H5BbEtu5VwJMwVJp+yy/yUl50w+sH0hH3Rdyuq9cnepbqA9yBuat67qRQjT1U4H+iu/J5X/bGJpRIuIGdU1Exq1109ubsCHfuGhfULgyzvtNy714KD0b0VV9MkjWy8qgdA/BkplF1B8G30CJEe0X+vJ62frN8YxOkoTILvgchPcu7t7awvBoQPbQkJjOAtnlJu2dz+g9bjzyqOoajkR5Y3fQR5FkLuZoO8j2GHNiYuDqP5Ly00OZs5rCUeLOYYzpZ5jL9643wYyA7Jt5OGzo4T52SxVPolfAxDzIAcFLStc1RcnBoq/IpYIiLe92+ugjiHDgEo3bPUI/AYSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UVQTH7ZcsZz7Yw8xYV7AHLzAyaeBQ0wlzDhM6CRuZro=;
 b=jXizO+PK+Itnv8XojiVgISLXmdOR9HkixlytHL+/4cNShZobgz/FpSiTQKPHJjJPWChXX3aLNygOnDKcH9B7NGLP3jXHeMyx14k2sa4ftrF7OBUIFyqrvG/HMWSNNIFvpA8MtINiJajRedSnUvwBkogILUTOQYhToL4xZnW3p75qCdHbuITX/uzqlozKUL/BJlrvIYLJjYd0N4UHZmviwzYv6cn+UJjHCwOKlSrgGcsUgXbCgK7CVYuBZ3eyFCevB2+RBbcBsQiSX7FjLkSgW6GsdIt3znTjl4Fd0TQ6DvNq5jfLV9iGMFWkmyIHbJTDYM3zY0aZhBrFMfggtPAE0w==
Received: from MN2PR10CA0033.namprd10.prod.outlook.com (2603:10b6:208:120::46)
 by CH3PR12MB8307.namprd12.prod.outlook.com (2603:10b6:610:12f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.17; Wed, 15 Nov
 2023 15:32:50 +0000
Received: from BL6PEPF0001AB54.namprd02.prod.outlook.com
 (2603:10b6:208:120:cafe::71) by MN2PR10CA0033.outlook.office365.com
 (2603:10b6:208:120::46) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.20 via Frontend
 Transport; Wed, 15 Nov 2023 15:32:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BL6PEPF0001AB54.mail.protection.outlook.com (10.167.241.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7002.20 via Frontend Transport; Wed, 15 Nov 2023 15:32:49 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Wed, 15 Nov
 2023 07:32:28 -0800
Received: from localhost.localdomain (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Wed, 15 Nov
 2023 07:32:26 -0800
From: Petr Machata <petrm@nvidia.com>
To: David Ahern <dsahern@gmail.com>, Stephen Hemminger
	<stephen@networkplumber.org>, <netdev@vger.kernel.org>
CC: Patrisious Haddad <phaddad@nvidia.com>, Petr Machata <petrm@nvidia.com>,
	Matteo Croce <mcroce@redhat.com>
Subject: [PATCH iproute2-next 1/3] lib: utils: Switch matches() to returning int again
Date: Wed, 15 Nov 2023 16:31:57 +0100
Message-ID: <28d043036e69125ea3ab5e2712ed5da49353d8d8.1700061513.git.petrm@nvidia.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1700061513.git.petrm@nvidia.com>
References: <cover.1700061513.git.petrm@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB54:EE_|CH3PR12MB8307:EE_
X-MS-Office365-Filtering-Correlation-Id: 74933420-e58c-4b05-9e9a-08dbe5f02038
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	NiYvTcoLDWAmWfn5rxO7Kl0Kd5veJexQga+iTTmrAiy3WcFmUd8pqfWwmMbfnt2W3wk9dI+kehGCH7Wa0ZmrwmhZPXJTKUJwElk30PthGLUHaKfXnxg35v6pdGVqMt9MBNjNOdvMd2EGkMMOHQPdtLgMo4OuULV0GVdbozZIEndfsaVDOUVdjs8DnOuISbEFYD1ZIQ5ke7wtfQ6iHCNShhCiZ7THkFTEjKPYn09TA10snuVbLE+GII/fHqlhQ/42UQqxCBjUCLjlErwYm8+a9TPzLXjkfsfYWQWowd3lHzZCOeuygCThfXfz/O+zktoZDijjF/IDtB0I+qS7I2vhu4fz05TgW5QH38Jv8nvXR66l8dHszM/vh8oVyfKeFA71au9H0LfYIhSTVLKB/UbeFvxMWUCb9+whZbfaho9wTt+kZqFVfMCrXJcmkdxrdTg5O8OAmfGYvVQvEA6zH8GqguON+2/M+gf4wxuP2KoDYuYzsRmNVwlQIHkDJGvSIOYAo2V/Z+LwIn/+v+SADUFG62KfG7+0ZJ7GRkmmWp1YAfs/8dEsy1XIUtRu17HAdRGgsFrxVA6e0LFsJNL9DxeWtubnhFdxQI2FTDYTGRjGD5rknZY7loAo1pKl2NlDLklaDTZqBs4vdyXQmL7cz1LdRjaeaj8z3TjZFwEbwtC+MgaBML1qVp/I08twTIxhXL24uVRFi5DYo3WkqJ8dltugFQnbU2sZVUntmFFEwC4ruSLObQhcYpSwf+lRqX3FaB0a
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(136003)(396003)(39860400002)(376002)(346002)(230922051799003)(451199024)(1800799009)(186009)(64100799003)(82310400011)(36840700001)(40470700004)(46966006)(26005)(82740400003)(40460700003)(86362001)(336012)(2616005)(426003)(478600001)(8936002)(4326008)(8676002)(36756003)(41300700001)(16526019)(2906002)(54906003)(70586007)(70206006)(316002)(110136005)(5660300002)(40480700001)(6666004)(47076005)(7636003)(356005)(36860700001)(83380400001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2023 15:32:49.5737
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 74933420-e58c-4b05-9e9a-08dbe5f02038
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB54.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8307

Since the commit cited below, the function has pretended to return a
boolean. But every user expects it to return zero on success and a non-zero
value on failure, like strcmp(). The function actually even returns "true"
to mean "no match". This only makes sense if one considers a boolean to be
a one-bit unsigned integer with no inherent meaning, which I do not think
is reasonable.

Switch the prototype back to int, and return 1 instead of true.

Cc: Matteo Croce <mcroce@redhat.com>
Fixes: 1f420318bda3 ("utils: don't match empty strings as prefixes")
Signed-off-by: Petr Machata <petrm@nvidia.com>
---
 include/utils.h | 2 +-
 lib/utils.c     | 8 ++++----
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/include/utils.h b/include/utils.h
index f26ed822..add55bfa 100644
--- a/include/utils.h
+++ b/include/utils.h
@@ -198,7 +198,7 @@ int check_ifname(const char *);
 int check_altifname(const char *name);
 int get_ifname(char *, const char *);
 const char *get_ifname_rta(int ifindex, const struct rtattr *rta);
-bool matches(const char *prefix, const char *string);
+int matches(const char *prefix, const char *string);
 int inet_addr_match(const inet_prefix *a, const inet_prefix *b, int bits);
 int inet_addr_match_rta(const inet_prefix *m, const struct rtattr *rta);
 
diff --git a/lib/utils.c b/lib/utils.c
index 99ba7a23..1fc42a9a 100644
--- a/lib/utils.c
+++ b/lib/utils.c
@@ -873,18 +873,18 @@ const char *get_ifname_rta(int ifindex, const struct rtattr *rta)
 	return name;
 }
 
-/* Returns false if 'prefix' is a not empty prefix of 'string'.
+/* Returns 0 if 'prefix' is a not empty prefix of 'string', != 0 otherwise.
  */
-bool matches(const char *prefix, const char *string)
+int matches(const char *prefix, const char *string)
 {
 	if (!*prefix)
-		return true;
+		return 1;
 	while (*string && *prefix == *string) {
 		prefix++;
 		string++;
 	}
 
-	return !!*prefix;
+	return *prefix;
 }
 
 int inet_addr_match(const inet_prefix *a, const inet_prefix *b, int bits)
-- 
2.41.0


