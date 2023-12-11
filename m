Return-Path: <netdev+bounces-55925-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9804280CD9D
	for <lists+netdev@lfdr.de>; Mon, 11 Dec 2023 15:12:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 531A8281B87
	for <lists+netdev@lfdr.de>; Mon, 11 Dec 2023 14:12:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F1194A9A4;
	Mon, 11 Dec 2023 14:08:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="M9em5cf2"
X-Original-To: netdev@vger.kernel.org
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2040.outbound.protection.outlook.com [40.107.101.40])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16070199C
	for <netdev@vger.kernel.org>; Mon, 11 Dec 2023 06:08:40 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GUYBg9SDGkD97Mwb0Qi4mPDxpCkNS7+zXZjYfybPCBErH5uMrVf4CnfLIgBAagi7VJTxJ7vSPaQhCGiBXSOoUAkZBcwqTCoQkBxRt+ARKdUpNbHzLlA2II5r4tEFfARkvT9g7/kOiifFe6ygrr8UnRI8U14wUl7n1ddJR6ZJYjHMGz8zW4uSEwnknaEBj4f5ZkcDvo107/O6hfxklWF+MGANAxjTnHkYcmfDwZgz4qMLKzmPSR68E6Ldm1ZNX/A9NoFmO38EvZIAAUYb3+C4Ay6u/56Vimhptwzy0monKY+4cdDxS+VEQjYZhm7t+jykgCMsMtBpkocPQ77FISvt5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uGj4Tm+TghgMzcCI9yP2U2AHmaQAjRsWfHGWgUjAr44=;
 b=RQhXEbKkXuVW9IKwvn7WddgcnsuyTA/JQHRk7ZnUkHfSDxVO+xuO0ub6zUMt579Tpxebs0/xufV8We78tQULnqdFaifuC0BHp/ZKSZGebBk6uwyHll/RMpJ8rceh4g5SRCGfEDhoDKelumeO+1DPNTA/BqkEp3JDf6RdtEG78rI61lWJVkiMIgwM6wYZ0ms9mSSZFJw98nzdNh/KXtYRlvOGIrgj+lOyMJXerPw0e3uNrq+YE8tBAehiGdL1NzzVPFDDR6y0ESMDGp8MD8+2/qKCx4Jy5U/X9rHzXZ9K3P1v3iItguKzQ7yVqPBEFWmEWsMzSpvwn6kf1VNSclObng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uGj4Tm+TghgMzcCI9yP2U2AHmaQAjRsWfHGWgUjAr44=;
 b=M9em5cf2k7dDAth7PpwBj6NlzgV8KPU5v1LDO0gREO1tBEjH9NNJB3IO+rsSGkoWwHjxuO8wlLS4gWvaefKrNZE1eG35qcmZdjF9GWSvJp5TyzgyRiTGeQiAaMFKzoQcIvZLGSXP+uhNmKdBV58pJpvwzfaaWVYDJjgcQG2Pn70l/SNeF96A6Z6tzZYqfxWTxmjJtOFdWr2od9acwSX9iAW7KGJcdspciDCHn9+tJXtWbk6O0ttdOEohwWwcF1hTfWwBYITRYHzWcHN2KdF3Nbdilapd+Yef7uv06jbZysGypm+f5QaEjOslcvFaIcGmqGtEp5qJLkPOPfuH5N5IQw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4373.namprd12.prod.outlook.com (2603:10b6:208:261::8)
 by BY5PR12MB4193.namprd12.prod.outlook.com (2603:10b6:a03:20c::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.32; Mon, 11 Dec
 2023 14:08:02 +0000
Received: from MN2PR12MB4373.namprd12.prod.outlook.com
 ([fe80::ff68:f81b:d451:9765]) by MN2PR12MB4373.namprd12.prod.outlook.com
 ([fe80::ff68:f81b:d451:9765%4]) with mapi id 15.20.7068.031; Mon, 11 Dec 2023
 14:08:02 +0000
From: Benjamin Poirier <bpoirier@nvidia.com>
To: netdev@vger.kernel.org
Cc: Petr Machata <petrm@nvidia.com>,
	Roopa Prabhu <roopa@nvidia.com>
Subject: [PATCH iproute2-next 08/20] bridge: vni: Remove print_vnifilter_rtm_filter()
Date: Mon, 11 Dec 2023 09:07:20 -0500
Message-ID: <20231211140732.11475-9-bpoirier@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231211140732.11475-1-bpoirier@nvidia.com>
References: <20231211140732.11475-1-bpoirier@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YQXP288CA0011.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:c00:41::24) To MN2PR12MB4373.namprd12.prod.outlook.com
 (2603:10b6:208:261::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB4373:EE_|BY5PR12MB4193:EE_
X-MS-Office365-Filtering-Correlation-Id: ab693a7c-a7f5-4f41-1c24-08dbfa5296a8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	/xkBx8UvNBT850LHxpaILYSjObUt0Sk6lrL3jMXvBXWBZXXAsV8PlvS1jX2mbHuG2yEpjJYAJ8YhDfttr7QVuGbDAnpSWv2Zc9lj7fpC6Nt3kTuv+W1pSVwv7VrWev3m/5MIkGaIT90F/1n1WBP+XAcfRh1Kn8WaDTURYq914/PuyLf+hD9rymi+hGIXSv0MRfuWZDnWWdDdMqWaIeKzPJu6toJEQyaQ3OaWJxTMCP3QTWBN0YSu/kwNu7K83ipo4Rx3meJ6JwhUFv+N3SZXk5ofJNJIkeGN8ezgxcWLZNT8J46UMVRrelfWFarccQBRpm54yC7z3GLeIEP3itKhz9k30TmzLjFEytAEujkK+zUYrKPX7PW3O+RTuq+Z3laD4sqjm4ZHMIo8z1sSTbRHfTsm7jHcMh41BtXNQgssFgmEJSJCbutNwWEE1vH0hcQCpe24JHTtsCzqBiqbGvjH8Q8GDUahcQC3GXcFzSpt4i0NxjyxZXHQD7jzsaqaOdPW2VBKm0gUaATYhROgDaItyN+BijdfYnSarpxst8WJCsoA5pzIHQ1XbHjcSMGLbr+9
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4373.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(366004)(396003)(376002)(346002)(39860400002)(230922051799003)(1800799012)(64100799003)(451199024)(186009)(41300700001)(4744005)(2906002)(316002)(6916009)(66946007)(66476007)(66556008)(54906003)(5660300002)(8676002)(8936002)(4326008)(86362001)(36756003)(6512007)(6666004)(6506007)(83380400001)(107886003)(26005)(2616005)(1076003)(6486002)(478600001)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?LjwEhCTg0Gpj8e0GFB3wQ872OXtKoXXSzZxD7rdRDMKXw9E6dbYPN+YuPzM6?=
 =?us-ascii?Q?LwYlnpPxQNYxf7wAPdN6afJyLZxQ4U77gsnlFi9pQI0ZVE2i1/Isq5r51le/?=
 =?us-ascii?Q?22a8MEvCSyYcO29206bnCCUhVu8IdM6p/Mbm+NYVn3WuMyRjdv//G6ZrHgCr?=
 =?us-ascii?Q?5iFiUnNhaZCyw+ZDFb/wDYT4U2m/tx/Pi+Yhz7KEPd7P7Z/DWvU6+AlS2zsM?=
 =?us-ascii?Q?dvih3vju5FIwFX6YfGF1rvNw9X/rMX9+gFht3bEyDJ/XUgi3VbB9lCqIMH3r?=
 =?us-ascii?Q?pl9AHtReRMOrPSCh6YnPQwAyGAbWqI8WgYLl1eY8N7fLsgXqCnJ7LoJxZc45?=
 =?us-ascii?Q?6xS03MMQRAt05H2hktdnnBLf/s+V4Ztquf7Y50r9towW1UZIDsEeraP6plTb?=
 =?us-ascii?Q?twtnMNJwZKWzcw4OjZXR7Vc+87tyZt17LilSvipw16iuZHnPtxr3crYU5gUL?=
 =?us-ascii?Q?v7InIEmDoT3sFjwMs1t0x2E4n90LcheOFxFgv+ljcoLBJL7lM/1LqxOI/sm5?=
 =?us-ascii?Q?W5TCt8haEtp5/N4TnW5d8CRzvI+iSAtJ6shDhgieXkan9X6jNWnukNXH1yI0?=
 =?us-ascii?Q?Q0a887iV1kuNkRthTVVUKkRRkagmQgUT9hmg5jL18zqsKe4DVCXpRt1UfHGo?=
 =?us-ascii?Q?2P2jnTHupAeViUMLmM1btkuTKlMVTOXIIfyGxQjmN/V82C1g/EOo64I5UCVE?=
 =?us-ascii?Q?HKQOVrXnFOVmxMmTqlPF8gh4OyGuwGLV+LH+NrPVfSdNSPQCmcJGc82oyiB8?=
 =?us-ascii?Q?uhxypqxWafK/6uiUerLQNREpBVf16KKkw82Tt2GNdz8ERO+4AvpJocoSCms/?=
 =?us-ascii?Q?/m0c7RTN+HQ/dax7cdz0o8BElPPQMMsb8v3EjpRUWhlla5wYgIOWmjeF4pmG?=
 =?us-ascii?Q?TIiGaIjEFsznqCSKrD/YiVLNvNKTeoAA0CulSoaxSeFSPIbkGHA5aIPvcWrE?=
 =?us-ascii?Q?P9+cBMfcHMyV4FwlZdR1XlYwiMv0FhyMZOATBVcvVM/CtdvUB/lpA8odixwV?=
 =?us-ascii?Q?+yY+qsnodrh8+PmR6zRIZAHjp/y9iKogpDAq7KOv9F7ti64MZoTVBwBhTGaq?=
 =?us-ascii?Q?A3+J217Cp2XN8C3wZ7pWLpx06kjx+qXCLpHcTKPq2fsDzK5hlEDybdTfIfwk?=
 =?us-ascii?Q?fENmA7Y4mFPhOje81gnpP0wvnTmmM88yKGe8C3rgilWJK6zvLrIHwfAep15K?=
 =?us-ascii?Q?apjISFCtwu9T8OB91yufy9MAM9/Ggf8jdPogSo3u6Xsirzs1C79Glfm6s723?=
 =?us-ascii?Q?spoipKSRFxD51pGhYEWjIpu2dK/bkP2Quw29tarif5giRWNFLPZsyNaJ4DRb?=
 =?us-ascii?Q?7aRcHlHqtcIPGxS8xq26Tl3LLp5cauSoXWqmrTAB49gFBdFTvvDpj8QQCzfa?=
 =?us-ascii?Q?321aseBImPXogxUKTcBjasopeokLWC+EiPSwl6dfiyJZVnqPrapIBYxtsglM?=
 =?us-ascii?Q?1PXYNgSWHoFumI0ewqPg+2X66CTSG7u9zeBltaQswCnZD9jmDF+t/7GP8vfW?=
 =?us-ascii?Q?R2/hTO6obYl3LBqejSsK3hNf4EGUG4M6pMRhjC/qQAAepOE6Qfhgfdkpi0Jv?=
 =?us-ascii?Q?4VdzFdLHDyk2MVLb5FWG0DGNIEV0klwXiLSkx8GR?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ab693a7c-a7f5-4f41-1c24-08dbfa5296a8
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4373.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2023 14:08:02.6101
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RX8WWqxJxleIdNjde6WKqGj9R4BxlvCK4+xd+kgLrPgjjJXaTF4fPao7BLFipqyOH5DvISEHU5qRhdF5RfF+IA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4193

print_vnifilter_rtm_filter() adds an unnecessary level of indirection so
remove it to simplify the code.

Reviewed-by: Petr Machata <petrm@nvidia.com>
Tested-by: Petr Machata <petrm@nvidia.com>
Signed-off-by: Benjamin Poirier <bpoirier@nvidia.com>
---
 bridge/vni.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/bridge/vni.c b/bridge/vni.c
index 74668156..51e65b89 100644
--- a/bridge/vni.c
+++ b/bridge/vni.c
@@ -350,11 +350,6 @@ int print_vnifilter_rtm(struct nlmsghdr *n, void *arg)
 	return 0;
 }
 
-static int print_vnifilter_rtm_filter(struct nlmsghdr *n, void *arg)
-{
-	return print_vnifilter_rtm(n, arg);
-}
-
 static int vni_show(int argc, char **argv)
 {
 	char *filter_dev = NULL;
@@ -395,7 +390,7 @@ static int vni_show(int argc, char **argv)
 		printf("\n");
 	}
 
-	ret = rtnl_dump_filter(&rth, print_vnifilter_rtm_filter, NULL);
+	ret = rtnl_dump_filter(&rth, print_vnifilter_rtm, NULL);
 	if (ret < 0) {
 		fprintf(stderr, "Dump ternminated\n");
 		exit(1);
-- 
2.43.0


