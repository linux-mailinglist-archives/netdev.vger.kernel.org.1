Return-Path: <netdev+bounces-55920-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A372480CD97
	for <lists+netdev@lfdr.de>; Mon, 11 Dec 2023 15:11:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0295EB213CC
	for <lists+netdev@lfdr.de>; Mon, 11 Dec 2023 14:11:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAE1D495CA;
	Mon, 11 Dec 2023 14:08:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="a2dZcJWl"
X-Original-To: netdev@vger.kernel.org
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2040.outbound.protection.outlook.com [40.107.101.40])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8C932119
	for <netdev@vger.kernel.org>; Mon, 11 Dec 2023 06:08:21 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cVFPrlPyANLI+TCmAFqBye9y9xVOql3YZkF8lvuPEofBQwBSEOrYyFB8zqLIb2/LwY5AO7VXTR5B/PbxfsL1gKK0LDakUX/qY0FVx5DZ52b240/QWoj2nC0VLvE6gasUGxwXcPmXdUTfuTPStl/CYIBNNMBoZAUrjkdO3lCQRdF9+V45b8Spxi8YUnUJN1KW+bPEqibNvVVlcY285NZmNPItvL/HQ/8WBdkzpfy7i8h+RRGeRVKDzBgU2a3MWca1/qt3ynQ0OKq3kT4cXMYpdOw+5eiCPlNZxWsgbcqA3Tol0jQAsKJwFtDZcRoBrySDK/5z0EcvI8qWsKB70BSqCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q6+vWAV9iAlICSncOKp6CFqGrcM+t7zv0Sovk6bsLh8=;
 b=Rm4xE5Y8XKO2+8dAeGXdd8jyzmX8OenIJft5Q14Bu4q6IPh+rAESd4Etz5fK/R4MfSIMiw3MmS48pPWHSqviQEFGEqmfYZBRP0XSKHdbu6/JqX9z+V1RBQYENf0aN5SCX+7RQil0gGE0oL/6LMJbybOFxPW7VuSd0w3OcPOPWBQOlRrn/S6bPVmbDqXuYdpq8SKcppVnwqhvLC6lEByc47Q51SpiPPD/DnmNMVHpEEXuUlVypZBwiJ2nL+R9xhNWUgUspSehKO70odLSygsdVel34/c85XdC01ZWKqetonLZ4/GjmTvg4HGL17U1wTv5buIGd9e6nheVUt0WYJgzLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q6+vWAV9iAlICSncOKp6CFqGrcM+t7zv0Sovk6bsLh8=;
 b=a2dZcJWlG2BbpHL+jSNnxlxVmb61N979DXVfefcFv9WoAfr2okPfohMBBaL6dTy60dNNVeIUReJBf/mwyJE9Xeh4K1PxxASSslOw8NzgWRiVdpRealcp/lOzsngGC1tnBeRzGzHojB8mVjLwHYNV0bWEzhqRks+pe+hCNG1PfsZ7uL+QEpZ3b4FsDccN3i8JmT4lw9VYUNrumQyteTUzOJDZK+aO9WVqut/xoT+Xa9/rcEOtTzCBIsEq1HWkuVhVHpYkBV+ac90utXlq3m9JaXYqwGeS3/aZ5+mN2trYpD8QG9eK0c/WKcYEF9gnNJnAoWI45WgmV2zbEWPkHljW0w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4373.namprd12.prod.outlook.com (2603:10b6:208:261::8)
 by BY5PR12MB4193.namprd12.prod.outlook.com (2603:10b6:a03:20c::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.32; Mon, 11 Dec
 2023 14:07:57 +0000
Received: from MN2PR12MB4373.namprd12.prod.outlook.com
 ([fe80::ff68:f81b:d451:9765]) by MN2PR12MB4373.namprd12.prod.outlook.com
 ([fe80::ff68:f81b:d451:9765%4]) with mapi id 15.20.7068.031; Mon, 11 Dec 2023
 14:07:57 +0000
From: Benjamin Poirier <bpoirier@nvidia.com>
To: netdev@vger.kernel.org
Cc: Petr Machata <petrm@nvidia.com>,
	Roopa Prabhu <roopa@nvidia.com>
Subject: [PATCH iproute2-next 05/20] bridge: vni: Fix vni filter help strings
Date: Mon, 11 Dec 2023 09:07:17 -0500
Message-ID: <20231211140732.11475-6-bpoirier@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231211140732.11475-1-bpoirier@nvidia.com>
References: <20231211140732.11475-1-bpoirier@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YQBPR01CA0160.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:7e::29) To MN2PR12MB4373.namprd12.prod.outlook.com
 (2603:10b6:208:261::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB4373:EE_|BY5PR12MB4193:EE_
X-MS-Office365-Filtering-Correlation-Id: 59d45f57-a660-4223-e059-08dbfa5293d0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	wlIx9OtDeHixvS8klrxOOi/1UhZoMxSZLgKtSXtOSN1do8lQPzVvfbKwbI7eKvgNVwhwBMlsxnY8q8uLUlA48osYBdBkgCIwWdl+/EM4YYz9whsVkPSvTbJzpRLnFahNJlFPOLoWM2uUKEptXDeQ/sN+PiqifHIzKoJ6orKAtDxU6zM2pAC8qwmJTL3hEf2NkFcy2x2qpWN17aco9qGkK+0g+9cE+6EKoYzvkJuBePd9VEmyD7aCoVH3SQlu2i/wCdkuHJtv/Qjb1OsHOb2leIQZFOS3GxLx4Tnrho7/thNJdUxZHSBZQ8INFXqydwSHqdhlRFhc6zVbMfPSCNWvXW8IxCsqlqa+XP7+k4B9BrhXXwYT/RRUebSfIDoxePvHB8idWojdKkvaMamv3esCjKbPweqOf1HDBO2G5XK3RA8omKHQ58AvxPJFkhZiujxw+H46ECL7QVEMUnWsjhoE45QJEen7ATT7LbtZ9TJt6UdNMo+hFSMFNCzmRcAn76qrZiF0A4L8yhRf7vcnyfT9dGZGYp7QUxGNjTKfEECKSJ4eurVw54xPkJgZXUeZEzMF
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4373.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(366004)(396003)(376002)(346002)(39860400002)(230922051799003)(1800799012)(64100799003)(451199024)(186009)(41300700001)(2906002)(316002)(6916009)(66946007)(66476007)(66556008)(54906003)(5660300002)(8676002)(8936002)(4326008)(86362001)(36756003)(6512007)(6666004)(6506007)(83380400001)(107886003)(26005)(2616005)(1076003)(6486002)(478600001)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?j/VlegC075iv37GTibKPhMnWPCNBHJADRbH6l+g1COnRDqCroKkg3WdRXMyl?=
 =?us-ascii?Q?9ZKTkF4sGV0tWgyJ/GygkqlOiqv98sdQSI88NzjukfnEzvh5XRCUEFD8C55Y?=
 =?us-ascii?Q?OrZOlg8fBftuMexB3yWXV52+9hn9ASm0blWmi+7Xsq5wQLVl1gve1+GLnDte?=
 =?us-ascii?Q?danG51RUYPGfsh1BAAZa9UHxOB4vZZ03a+PBk5egN0K653QgLDsla4Mye0qQ?=
 =?us-ascii?Q?7Uyw90Nr9SpaziSXDOa+VbJCnx0IGFLC3y30qKWvKcSTDTnrfSJNyzVHdZK+?=
 =?us-ascii?Q?gAL2TYhsVFX1c55XxPZn0JacV9PfDLB9WAfHaW2oUuE5uasWlXCx4HQbxA26?=
 =?us-ascii?Q?6m1ItAEZ6HHGThPn4UHZ0MdtcfNropVVLC1tVj59B8/tFdprWjF1TBggM5Dq?=
 =?us-ascii?Q?qc52YKKNw50WAqHq/edmm4HwtfiXooGjrrEuno3hKEG4CpJ/SIco9Vlc0Jwz?=
 =?us-ascii?Q?8qT4cqcGkSgBGXr1n8vwXinkB7FE+NtctAEj+kRWiIFXD5DaqViAvieqKkIv?=
 =?us-ascii?Q?+Z/hGuRvwqb3c6teXeSaGi6D+pK2jpRPS2oemgP/F7CiPZCJ6kn5SNlQ3b/z?=
 =?us-ascii?Q?1CvUfJwTvVoXmYOV0MDEf95VAoGpTsxbL1js9A5UfHC1KdVWmu4VUknGpamq?=
 =?us-ascii?Q?wPKy0Lh9YvxPvffqDoImGhu16t32UquZc5OrA/oJ6FdaBBEh5L14wmCxyTza?=
 =?us-ascii?Q?IjymD2FhdhO/hUwCWsK/dkuuNM3aKsMwtfxnyum+tE/tD4TdUGQXVVPHSfti?=
 =?us-ascii?Q?H4IQjjWP3/zg549+sfC07+BpqVTmJCsgN2BVQ/MlWnwN2xjH5YUBrB5E3fNU?=
 =?us-ascii?Q?BAAVJX3CucReq6o2fO4rSpQd8puhGK0yEgiSaJcTJGUWj1raWbIzQbxk6r+g?=
 =?us-ascii?Q?gugn8ekFLHeOrLu/2GqqkWn++j0hhUvHQ3TyA6yiVEcqiDbtsfePFcHFQ28d?=
 =?us-ascii?Q?za5oTDfni/g5iv/I/6x+gOAQ5+iJN+wqosKjQ+Pn1wGXTk01R/PiDq82DcoE?=
 =?us-ascii?Q?7zfCVc4CGSSWqGuUL/SHWss+MyeQeuHBrVUdWswaKKJowP3/YAxntdJ79ydL?=
 =?us-ascii?Q?PzKs7YDSivpDMrflNCGQbjIyN+/ldB/4355G5wpYecre0ksh9WYGTwmt+U7S?=
 =?us-ascii?Q?lPD0wglWmJ5Sikx3alnm+z1JyFEk1mUCRPrB0dDwnELYBaFY2pX7jknO3Nr2?=
 =?us-ascii?Q?GHXHgIQ3/ndBKmmcrG6nFGy3KkkhN1pKvGysNSz9DsZeCqweV8igFQVQ/byD?=
 =?us-ascii?Q?wCiuRXncvYCoEeQgFv4tLjdqBF7WcIgmaUwjRjcZc04wTw8UjtF5a7XTRBur?=
 =?us-ascii?Q?aIIpujrxyedAEkgbno1bWdWGYWF4vuNlHTy5kU99uaELu6/SJaOFdFGis3RV?=
 =?us-ascii?Q?9E22Mj83o3NIV+cTzVBXx8IDODyTHn7/9mIzViaLT+V/RaEappGuU7EhtDAG?=
 =?us-ascii?Q?Qdpr4FpbICAkvk7MgyDWTfSvjBPDG98PwhyV9AZcQySLSCtmUwfGKcB82kAj?=
 =?us-ascii?Q?SKdmb4V7mbdX0+ZlR6D/9mA2EkoCGBaJ1OVtp7GZP5kt7PhKytIPaMQOSNjq?=
 =?us-ascii?Q?aRny6XRMdRkCUOzqcW4kzbWvUVW0BtoFNuBuU3LE?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 59d45f57-a660-4223-e059-08dbfa5293d0
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4373.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2023 14:07:57.8684
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Qj9LSCTxHFx94mKO9oxlTNvtJo5maZhGu4kPGnE78XmdWwgGmOLxOjPvJnVYPfPOqe4H80tyhluN7XpygLKwIQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4193

Add the missing 'vni' subcommand to the top level `bridge help`.
For `bridge vni { add | del } ...`, 'dev' is a mandatory argument.
For `bridge vni show`, 'dev' is an optional argument.

Fixes: 45cd32f9f7d5 ("bridge: vxlan device vnifilter support")
Reviewed-by: Petr Machata <petrm@nvidia.com>
Tested-by: Petr Machata <petrm@nvidia.com>
Signed-off-by: Benjamin Poirier <bpoirier@nvidia.com>
---
 bridge/bridge.c | 2 +-
 bridge/vni.c    | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/bridge/bridge.c b/bridge/bridge.c
index 339101a8..f4805092 100644
--- a/bridge/bridge.c
+++ b/bridge/bridge.c
@@ -36,7 +36,7 @@ static void usage(void)
 	fprintf(stderr,
 "Usage: bridge [ OPTIONS ] OBJECT { COMMAND | help }\n"
 "       bridge [ -force ] -batch filename\n"
-"where  OBJECT := { link | fdb | mdb | vlan | monitor }\n"
+"where  OBJECT := { link | fdb | mdb | vlan | vni | monitor }\n"
 "       OPTIONS := { -V[ersion] | -s[tatistics] | -d[etails] |\n"
 "                    -o[neline] | -t[imestamp] | -n[etns] name |\n"
 "                    -c[ompressvlans] -color -p[retty] -j[son] }\n");
diff --git a/bridge/vni.c b/bridge/vni.c
index ecd4c2b5..74668156 100644
--- a/bridge/vni.c
+++ b/bridge/vni.c
@@ -33,8 +33,8 @@ static void usage(void)
 	fprintf(stderr,
 		"Usage: bridge vni { add | del } vni VNI\n"
 		"		[ { group | remote } IP_ADDRESS ]\n"
-		"		[ dev DEV ]\n"
-		"       bridge vni { show }\n"
+		"		dev DEV\n"
+		"       bridge vni { show } [ dev DEV ]\n"
 		"\n"
 		"Where:	VNI	:= 0-16777215\n"
 	       );
-- 
2.43.0


