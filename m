Return-Path: <netdev+bounces-55931-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E4A180CDA3
	for <lists+netdev@lfdr.de>; Mon, 11 Dec 2023 15:12:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CD48A28165B
	for <lists+netdev@lfdr.de>; Mon, 11 Dec 2023 14:12:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 522484D5B3;
	Mon, 11 Dec 2023 14:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="QlurTTJP"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2085.outbound.protection.outlook.com [40.107.223.85])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 609092D74
	for <netdev@vger.kernel.org>; Mon, 11 Dec 2023 06:08:48 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RMtODDubOtBaX1PNASmayxWS6XZppgM/Rx33K6yA6BhYNYt1tJhhUyV8R2UBxR8hzzY24vfs/DDz1ICDcqBFteDv/gHwbHRts6pXsmUx9G9SWk7cCyYjogEW7ow+N595yq7Ske2Y0N0IpnTcfOM8/mETtcJPyD5YHz1jQhLSiFN7B5Hhj4I5lwSu7DvjxrpCxdc4Y2arXsfs/8wolFJDWdGDGEteEUZaHL4N2+Z6Xp3aPm5sY+I4O8TiP5sPUm8r4ssdiZz8gLGzetFziY6C+6dZXcgfZu+mchLEIHMdwh8e/+B78nuwPf2I/ZkV96M7f7ZRNkb/coNFgdhHedpcBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UFZcDCISxDuKevso1cwd+gN77zuBGGC9Tq7Ui0S6cBw=;
 b=endN7YB9SbJKYgwFmO8dNdyKmAIIbSdYyULl9MiE02aCgaj72DSS0lkXXR5dxEr2wnmUnjrQ5fbkxnV8aYv4+ofARJmsAsCnD2EDDYD2xbmJ+lXmUU3TpnA01XOCNMn8d6I2MqZbV6Xxgmme4OXlW0fxomOLD46ytqzLxJXHBLs3gpjHSqki2jGYFeaAvyrwQFebgCX7bWL0B3nHyWQpv7w3+Y+iBPzN0U8z4pYXfd1cPdiDWWZu6hsKQ3kHeoKA+PnfycvitrW9a2S6eT2kcGNE3xghLbAK9w21DiczwnSFP4ypDiJSUSxYPBP//P5EoIEAQq0zJlO/c4wp1orRxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UFZcDCISxDuKevso1cwd+gN77zuBGGC9Tq7Ui0S6cBw=;
 b=QlurTTJPiPwHxL6fXO6iP75PCB3E+Wwpyx2msRVK+6Om5dWbqJVcRCFk6zM4fFub76N490N1gVvwVq7WBCkb8M9RrKz8Qty2ePt0CMyQMNO9PRwd+dN2CXaZVh5OoeyLbwW1oszpiF3NE/XuZqsLzmJJhfhuE0kGDi8P6mxHH2DqyQTUsI3jvvA4dvoMrce6d2GlkJgTNa5nB3hyqdAK7l2o+qYxyNljGmxZdlsuOI5gWIMKnb4BNClfBCuUa2SJxZlY6zC3DjkKqLVEwG1xHUFlCo3iYdy7deYLQnnJZkDY3upOyVzNE1hpY6dpAj5iZOP3FGqdbr+32SgRhwzuYg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4373.namprd12.prod.outlook.com (2603:10b6:208:261::8)
 by BY5PR12MB4193.namprd12.prod.outlook.com (2603:10b6:a03:20c::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.32; Mon, 11 Dec
 2023 14:08:12 +0000
Received: from MN2PR12MB4373.namprd12.prod.outlook.com
 ([fe80::ff68:f81b:d451:9765]) by MN2PR12MB4373.namprd12.prod.outlook.com
 ([fe80::ff68:f81b:d451:9765%4]) with mapi id 15.20.7068.031; Mon, 11 Dec 2023
 14:08:12 +0000
From: Benjamin Poirier <bpoirier@nvidia.com>
To: netdev@vger.kernel.org
Cc: Petr Machata <petrm@nvidia.com>,
	Roopa Prabhu <roopa@nvidia.com>
Subject: [PATCH iproute2-next 12/20] bridge: vni: Remove stray newlines after each interface
Date: Mon, 11 Dec 2023 09:07:24 -0500
Message-ID: <20231211140732.11475-13-bpoirier@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231211140732.11475-1-bpoirier@nvidia.com>
References: <20231211140732.11475-1-bpoirier@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YQBPR01CA0108.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:3::44) To MN2PR12MB4373.namprd12.prod.outlook.com
 (2603:10b6:208:261::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB4373:EE_|BY5PR12MB4193:EE_
X-MS-Office365-Filtering-Correlation-Id: 740550d5-d47f-4dd8-557c-08dbfa529cb8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	yLc1VhcjIbR+j8ph8eJWutYFz3KdnjNHqi7/YHmw2yJLq1iMQsAfE8aF7fJ1WAYVF7BPkX3T+F/M/EbH2aC/mA9rgitdpyJ0IY9qpcPNdPpghyNdzBu8FXNZv/wnAS6tDt78BbsOuALHyR9ZOcy3jvFmG39dRE7ZEhl1ZqHBBjl3z4rIM2VmOLWBbl9qKMx2F6sgFVYWk7KftK1FVUyUL6p1yGHzDJipnb4vYEUmyAV/NFeTi1aATWm8Pty5aLqLw2Rx3GykaeetXPLKigBJ61MlohN7uACmZA4b3lP32EJS78w9ly3F+P0IUriWRRrEUCYl65xaPhe5DoZ99rOA6rEzQ9+3Fei0nlW3hg0VFycHS0Xl4o37gt1xqn4hsvMv1moH5VqPKUPU8jf5ODsqKug2VvLhRGml/ZKnlSIk519Ld3WCRf6TWoEasPHZPTy22cfV6K+1eKHYRQK6/wZw4PJqTU0Tje9Njyt+Hm3EaamI8C016UkUq5npksfW21++3rIkITTE/b3ochICSaogYSWHd0Ped29IaGaJomCLx6ckFSMhpncNqJiNFUTUU+fZ
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4373.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(366004)(396003)(376002)(346002)(39860400002)(230922051799003)(1800799012)(64100799003)(451199024)(186009)(41300700001)(2906002)(316002)(6916009)(66946007)(66476007)(66556008)(54906003)(5660300002)(8676002)(8936002)(4326008)(86362001)(36756003)(6512007)(6666004)(6506007)(83380400001)(107886003)(26005)(2616005)(1076003)(6486002)(478600001)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?r0tFz25BhtpThPhr/uzVsrISTMbIGyN8qPHzVIEbvqmd9J6eDR0PprvEdQgL?=
 =?us-ascii?Q?Vva0mIn77vPJtyJTV9UoD6Db/p93GZlZCtg6xtTYVdJ/R3iRy7HDMKZZOcPz?=
 =?us-ascii?Q?uq4pkX881aNPnDxImewd1fnbCYvtyFwvXDzafpIVpqHrj7l9jYfYFUtTFast?=
 =?us-ascii?Q?IBhl1tDSrMgadZdKYJy3PY0HO51aFnT+hDItrDr/gPTW+x6UYLApG6AlsQ/z?=
 =?us-ascii?Q?Hrf5RBoQcrsI1X8C+i/R3SGrsmx8HBzEfCMYVlhDSD2TE6+GReIV/bgoP4CS?=
 =?us-ascii?Q?gs+5F0LRvAMzhxVHBFHd2wmmrGpKFHuk1/5GnIsm7q6JxCXBHtSnNFiWT9rA?=
 =?us-ascii?Q?7saifFpxMPuU0SqGI4vJx1v1eYPQS1xo+AB0hzOrZdCrTR0lSmigoPQzKXtV?=
 =?us-ascii?Q?AOq0pG6hI0eqGzMsn8uZcgGClL2FQCqhujnMV+ZbW1mnPx3+Hej0W0KePUZT?=
 =?us-ascii?Q?xr6u1PFfBSooSXBr670XOq/5SwExWjJ6x3qiP2gBvR0utfpLT3SBKBzg1mAE?=
 =?us-ascii?Q?5j9nucw8Dk8swExY+ykEXDfM7AnOzzfHuHhpGeSqpwUIPCLTJiAB5aLeVScM?=
 =?us-ascii?Q?UjIHpr0YqtmTZcWvnWU4M+tiHvVqNW3kal81HoMiPYpLXl1f0+IWidSTpJdg?=
 =?us-ascii?Q?HjIT6Z+kcj3KOr/iu3T97bCV9+S/1HP9+jiAE+hM8AmZhexeSWnCZvz3X/E+?=
 =?us-ascii?Q?O6PpM0IO5zhL7Dn4De1X2WoKdpEE4IWzUMdPWvfLldZfgNl29Dk16tq5lKGg?=
 =?us-ascii?Q?VNNSX6nAs0g5jAueTWnGT/rcqvveoJWbRWmKC9VA/UNlWtgHjh7+WeyzvCpj?=
 =?us-ascii?Q?p1dsAYFO/WqHd+6Ph89M5M+NZyrqeI/1t1zA2tZ1NXbStEg8ZHTzBGzzvTqc?=
 =?us-ascii?Q?MFqzBqCpUH9UBznZh3jp7HdyCqQpFVGdP2PUMsMMQBvrABZPIBMXt/uTn/9W?=
 =?us-ascii?Q?LqrbaoCmocgER2GWB4K1mxioXCGszFNCHGP5CVUAIRYejcGzCl3v6dPyYrZW?=
 =?us-ascii?Q?VGW/Nn2Tf9ZZNF6XPodAojjWXPkX7JZv4OcXxIXalJLp7ARytxdU0bc9Crt9?=
 =?us-ascii?Q?fTe9cyEH2wBQQgKrIo2lNDQBSVWMey9mmoImzRDbgl8TRBpUQTR/w39rOOlc?=
 =?us-ascii?Q?lxbCCZCLw+M0nYd/a/DkoY4OYjtu3hgQS028yQ8VGO7tfOLEU2mYdqV6ZLXD?=
 =?us-ascii?Q?mK/UvOgQSfTr6YWZRJoRuE+47Up6wJFjtcMfQ626wNXa2bI2Lx6U9UUrdfrP?=
 =?us-ascii?Q?MXCCle1AXtDnEqOrfp125BgHW7XLPh+NKaOcbO82CH6EiDf35m/0xheGwFY4?=
 =?us-ascii?Q?rbtORDaaPqKotVmbISDg6j5TCD6tJzVkl5CXmE9UQI75nrp6Ct/MPLNwenZm?=
 =?us-ascii?Q?MS+XaUyC57u/EgCZoaFOehaxxqI23FdOyl62nFGKhaFt7jmGl3fb6Lsml9F6?=
 =?us-ascii?Q?3rt19Rp4VrY7EFtf32N2U99XzKhXL0JGWU8x3X95XzjqPSvRuAcC7Dzy6Zsg?=
 =?us-ascii?Q?Bj2ZtnawZXDHMa7W2PhbgTTFgI3ucCoWG/JWS5OZvqhqe+V41Ci1f6YjU/mH?=
 =?us-ascii?Q?TqpIdKnjlgOjnhVjEsgY+nogHyVW3cif7XEyV40q?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 740550d5-d47f-4dd8-557c-08dbfa529cb8
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4373.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2023 14:08:12.7942
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0KzW5ZlqqlRT9oJCgLGdLY4ONijAtoi1Iy0NrWW5zBQ07ROrmib46+urPfNdw5mieVnMiww5UabsGuTC9HHqLw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4193

Currently, `bridge vni` outputs an empty line after each interface. This is
not consistent with the output style of other iproute2 commands, in
particular `bridge vlan`. Therefore, remove the empty lines.

If there are scripts that parse the normal text output of `bridge vni`,
those scripts might be broken by the removal of the empty lines. This is a
secondary concern because those scripts should consume the JSON output
instead.

Before:
$ bridge vni
dev               vni              group/remote
vxlan1             4001
                   5000-5010

vxlan2             100

$

After:
$ ./bridge/bridge vni
dev               vni              group/remote
vxlan1             4001
                   5000-5010
vxlan2             100
$

Reviewed-by: Petr Machata <petrm@nvidia.com>
Tested-by: Petr Machata <petrm@nvidia.com>
Signed-off-by: Benjamin Poirier <bpoirier@nvidia.com>
---
 bridge/vni.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/bridge/vni.c b/bridge/vni.c
index b597a916..8f88a706 100644
--- a/bridge/vni.c
+++ b/bridge/vni.c
@@ -346,8 +346,6 @@ int print_vnifilter_rtm(struct nlmsghdr *n, void *arg)
 	if (opened)
 		close_vni_port();
 
-	print_string(PRINT_FP, NULL, "%s", _SL_);
-
 	fflush(stdout);
 	return 0;
 }
-- 
2.43.0


