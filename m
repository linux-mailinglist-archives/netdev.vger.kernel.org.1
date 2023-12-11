Return-Path: <netdev+bounces-55916-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E71EC80CD93
	for <lists+netdev@lfdr.de>; Mon, 11 Dec 2023 15:11:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9B4CD281733
	for <lists+netdev@lfdr.de>; Mon, 11 Dec 2023 14:11:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 564C9487BC;
	Mon, 11 Dec 2023 14:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Pb+i7Uva"
X-Original-To: netdev@vger.kernel.org
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2067.outbound.protection.outlook.com [40.107.101.67])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D83B51FE7
	for <netdev@vger.kernel.org>; Mon, 11 Dec 2023 06:08:02 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gULcy0nnajBodBVq3aedpcWFce6SAXbO6wYV56ET68Y16znRpGouLI7uvySU3wE1iCc72EuLl3CW6LTt8EsAH0E1aFxdhTi5iiKQemlbVif2AqelWn8Bl3UwXHkTuZYMwCAt96ignFJGjPx2tyQsortyFEizasvNfEj3T3XDKvbzBIxEDDwQ0Tt35C5I1EzWLz9duusKcZKg79HKCJvrx6/nbVFkdxMzjQ1cIhK68oxGgGKzgoKsrPVffp5msUfROKLCyV+/FS3RFrAs+ScUOUb2CZutmQvEcoKWL1n1FmYrpqO9Ab5zC5ArfNZDyQ6D27SLmNdnEzDgM8yNdwYobw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9YkmK2skxvSunadKnqDMwdQqx+jkTJF00s5q4EPTmmk=;
 b=K8f/Z/3ctHpgBlgR38/gAaMZmIC/cEvz7rR8a+facohgeopV4QhQYVuUyDMjAogY51QgoZp8YQ/3fc5YlgI/AlrDvRIL0KWRwEWSw00qSlXatmS2hV6DQO/QT8QUeeoxgJbhLuz1o7rzrpMAJprHEW7wLtwjTunwf5NzIH9qoEsF/Dg+g8gHEwHzlHlC3HYvOmF5B6p0AxkyPmCY0pLIG6OPdv8bhaPLkBp3E9hAttGBL58pJLcXZFug4iihz+feR/scF7T++5OGdbpACFTOlAeGyC0aBVRjv42Nzhj9mSLvDWYSmD7M/zz3Rm5vVsxb1OfyabUcy+47UQWhqHYYsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9YkmK2skxvSunadKnqDMwdQqx+jkTJF00s5q4EPTmmk=;
 b=Pb+i7UvauxjLdqEu5+mfyZGLRKBggdzCrzu7D2mnVKV1IWh7T6nL6Lv84zZkYnN+9UTSjhj7sqFbPQ29dpkzzAO08NDcDBIyIhYwKRHuo4Vc2ZLv5Fyjnp4xzNupyG4GmZFxaoQjDVaP8YocXvxXgmk3hJToX9iWkjkinE1ziIRcYxBRYUWbEZeihuoMIjWKmn0oKohlF3mxv8s8TlVYNHM0vKddz5VOMWFBL/UopaORgmDCUbxfx0yxqR9wuNw1K4/RvimSdGDAwz7spRY22g+nI0mer+Kk5Lncmbeoy1Lo4/v/LP4XtJhXNqX+d+KgLbq7eICChYGkpLou0trvUw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4373.namprd12.prod.outlook.com (2603:10b6:208:261::8)
 by BY5PR12MB4193.namprd12.prod.outlook.com (2603:10b6:a03:20c::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.32; Mon, 11 Dec
 2023 14:07:52 +0000
Received: from MN2PR12MB4373.namprd12.prod.outlook.com
 ([fe80::ff68:f81b:d451:9765]) by MN2PR12MB4373.namprd12.prod.outlook.com
 ([fe80::ff68:f81b:d451:9765%4]) with mapi id 15.20.7068.031; Mon, 11 Dec 2023
 14:07:52 +0000
From: Benjamin Poirier <bpoirier@nvidia.com>
To: netdev@vger.kernel.org
Cc: Petr Machata <petrm@nvidia.com>,
	Roopa Prabhu <roopa@nvidia.com>
Subject: [PATCH iproute2-next 02/20] bridge: vni: Remove dead code in group argument parsing
Date: Mon, 11 Dec 2023 09:07:14 -0500
Message-ID: <20231211140732.11475-3-bpoirier@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231211140732.11475-1-bpoirier@nvidia.com>
References: <20231211140732.11475-1-bpoirier@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YQBPR01CA0051.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:2::23) To MN2PR12MB4373.namprd12.prod.outlook.com
 (2603:10b6:208:261::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB4373:EE_|BY5PR12MB4193:EE_
X-MS-Office365-Filtering-Correlation-Id: 478f50a7-a4a1-4f00-e0ad-08dbfa5290d5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	+jdgrRHvG8qa7LbMXFKiQvXyq5rg3i3har9L/b60PHa5foJ8AXbt+varolxcOSl1pF0hkvoJpOiFCtUWaajkC7W00HPp1g4ksA0px5/G7/WdyE3Cg276f+h7UDymWuSkmG1NTRvf2pQo7+qwIUrMZSd7Ak9a+toh8Q+HLKuCtkX+GOaJhQUVRtuwNmTELzcTLHWHXzkxDztm6V6W5oD9o76hMEMBdKTlRPHRG9D0BbnxrLiU1ANR43GBSnSnj41Z5Cb0CdnLRKs43tFrTjQ01+Jzly0IHMfKsgnKywiCphrFabUlU11rxM+XLO1dKxH/YlBElh5DULPN/2OUszHHxBSDTCLZ82TMuuReDdFOXRgSgKXSPKwjrBUeLpeKWu6kZCmBuy51u3tHqFk3vRDII12jgHhetlBVnnsGZPODZTHgwUaqP6QwS/lICzkkGK9M0ZLQgZ/Ha+UO8eAkZHZ90GIDsJoC5J4A8SSrVLShDIoGLXyxUOaEkq54hG7NhzEZrzHDjwxznD0upPb8W5E4tuzpMtZF9IHXCiAmIDaHQDSn8OdOcK0OSpwXCrTYTEip
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4373.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(366004)(396003)(376002)(346002)(39860400002)(230922051799003)(1800799012)(64100799003)(451199024)(186009)(41300700001)(2906002)(316002)(6916009)(66946007)(66476007)(66556008)(54906003)(5660300002)(8676002)(8936002)(4326008)(86362001)(36756003)(6512007)(6666004)(6506007)(83380400001)(107886003)(26005)(2616005)(1076003)(6486002)(478600001)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?tgiE+iSBlIsxgCebb3bhdgNEXzlqgg9QBT5aTCjp/sm0ug17nO+La9jPBJQJ?=
 =?us-ascii?Q?fZaXGL40wmwXxX5e1WE4OuQIe0NjwYEzD/THDMJGGGcNIaXz6EdkcMwsPrN9?=
 =?us-ascii?Q?wR5xCXXpqubMJHRxoyM6GL6zd3AAaPZWzlTvk1X3DEnIvBddrEjvRMckCkuM?=
 =?us-ascii?Q?TX0pUi7Zizy8Mqo1uJU6+tJ8DOt39Cz6MF7se4y24pGOV32gSeKJc/Kpfa00?=
 =?us-ascii?Q?gMhcszskL3L8h2lFwUsM4S7z0uaNDmJSz51ot5Fmwj4SkvN1Aia8nDBfJyj3?=
 =?us-ascii?Q?JErV66l3zOkSwOs92WE6yDJvjBV4+M7NidWZDin9j7HtwqpHQW/dbBPlIENH?=
 =?us-ascii?Q?5bHRYBO64TS5vTMQAYr4bLPUKtsd8d/78z7zo1Eqppi+9/c+5eNMTfAhBNoS?=
 =?us-ascii?Q?MrLXTbBLXA0rH0SWhqWDf/gC/nsHjPfIu+BTFIwKuXAwXgEQ0eYAKB3xCHB0?=
 =?us-ascii?Q?LUi8XySE9qi2vCTQnGx4IHO8cv1rK0MXaaS+TYXWOcdundI2Qtp8dewphCor?=
 =?us-ascii?Q?p6mzyCUwWb415mI/QovxsTVILyqlcUJdUYVktJ6rRli1e9ed9M2Ohc1y7D/2?=
 =?us-ascii?Q?AUN8SYFGWkHEE/QZYGxza0DM+zGoPuWyfVVxdqX7/dWpNpDxOjvwXl70BRdU?=
 =?us-ascii?Q?cjXxFLwntyyr4lHBeCdCVMyn0etFaRBkZ4+tONsiTYSrulvIvtEEScLOKVDc?=
 =?us-ascii?Q?SdJ3OfEOabO2yit2aI+SyZNrIl/iQhnwSWBhfKzyHveqIuM7jcu3eAKi1FQD?=
 =?us-ascii?Q?M1HChWiY5sB74SZ9Z+DxC5P2eFlm88D+uRQH0wX6bhw4i0JW/IwAO2MIJOAF?=
 =?us-ascii?Q?mSMios5ugguM7w40x/1ZbYcths+H+tw1v6HQ8sJje5a3+hQyyOnz9RnSGbLW?=
 =?us-ascii?Q?O+9y4XaigOZjgYDB18z2JV7hWVSEBIjPSrT3wtpg/JqPeO7ULuGUWsAd0RWK?=
 =?us-ascii?Q?vATuJbr7TG3pbCrf0qSzmtmZ6B8d4IuAnkSJo0WI8Fmo9F80kq2YGQ7hqrQE?=
 =?us-ascii?Q?zv68mPRD9Mu9JZoO16MqZiBw8HZXDas8Ve85y4byiAihrDDZjexAqfqH0GZc?=
 =?us-ascii?Q?SKXHJbDAJmTq7II9vZnQsbg79aOiRYai04P1h9Fv3ARYZ5Cqz3UrvKSaMfrP?=
 =?us-ascii?Q?pXLR0obLZa6GI9e2JRO34cWUeo2SaJjNTIvvy+rFMGfVhpgztMzN0ICCGYe2?=
 =?us-ascii?Q?0vJj80l6GZc5oEwKbQvMbx77wgrUI7z3d2nUknKRmLb01NVWsF35Bhr1et6v?=
 =?us-ascii?Q?z9kaESehAbwr2zNdis4/xLk4QOrkAvS99BChqV7LSBOOzZBKeyPGOn/qofPA?=
 =?us-ascii?Q?vwcdwhc2QDrzORrQrA4MIIK3tIFD/LZuBe9xDk/D+mMZPAYsO+Sf7dJixQQv?=
 =?us-ascii?Q?C/QkECzqx28LzmJm0tpG55ti7OsfchlW3TZ1F1sYzAfNYoJmGHNzVV8II+2M?=
 =?us-ascii?Q?CjLUtUBYzVVKv5WD0ldnOZd/JmP9dA+JbJa/aQMfhYJfrroZore2GAH/TesK?=
 =?us-ascii?Q?WENvXwrn4NyCl/NXEjfeYWkOCgUiQOcowFRxQ2i1oao25v9AH47sPuz7k/xu?=
 =?us-ascii?Q?9XOdk5XwYWUvaSaTnD4ayRJ6LQTHRZpbIn2CuPiQ?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 478f50a7-a4a1-4f00-e0ad-08dbfa5290d5
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4373.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2023 14:07:52.8552
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0MN1dsqN163zNQyH7kI0eKE8ajBDa78fG7N0Z6vDdXQnmfkp4JoUiGYqtNdLpU7U6x3jNQ9Db5YiZyZrTEH6QQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4193

is_addrtype_inet_not_multi(&daddr) may read an uninitialized "daddr". Even
if that is fixed, the error message that follows cannot be reached because
the situation would be caught by the previous test (group_present).
Therefore, remove this test on daddr.

Fixes: 45cd32f9f7d5 ("bridge: vxlan device vnifilter support")
Reviewed-by: Petr Machata <petrm@nvidia.com>
Tested-by: Petr Machata <petrm@nvidia.com>
Signed-off-by: Benjamin Poirier <bpoirier@nvidia.com>
---
 bridge/vni.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/bridge/vni.c b/bridge/vni.c
index 6c0e35cd..33e50d18 100644
--- a/bridge/vni.c
+++ b/bridge/vni.c
@@ -109,11 +109,6 @@ static int vni_modify(int cmd, int argc, char **argv)
 		} else if (strcmp(*argv, "group") == 0) {
 			if (group_present)
 				invarg("duplicate group", *argv);
-			if (is_addrtype_inet_not_multi(&daddr)) {
-				fprintf(stderr, "vxlan: both group and remote");
-				fprintf(stderr, " cannot be specified\n");
-				return -1;
-			}
 			NEXT_ARG();
 			get_addr(&daddr, *argv, AF_UNSPEC);
 			if (!is_addrtype_inet_multi(&daddr))
-- 
2.43.0


