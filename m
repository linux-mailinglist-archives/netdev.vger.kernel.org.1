Return-Path: <netdev+bounces-260677-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6Pc7IJQ7nmkZUQQAu9opvQ
	(envelope-from <netdev+bounces-260677-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 01:00:20 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D238818E389
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 01:00:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 81F2D304DE85
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 00:00:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C34953101A7;
	Wed, 25 Feb 2026 00:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="pgrZCtI5"
X-Original-To: netdev@vger.kernel.org
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011011.outbound.protection.outlook.com [52.101.52.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6490C17A2F6;
	Wed, 25 Feb 2026 00:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771977617; cv=fail; b=fJqdC03HN2MOBxG2ekEGc5OWLgu0cDifZBoP6/qlvXZ6IastLPZ49GrmEzwVy1Cka49aJcXRkzREssVDxi3iafzwfoMl0nAqVY0X2Ixq+Y54NBZO5gOUuh5IiG03oO0eU8AWEGjU70pRYESwydEFNSE7PbdrbMaH0wPOzZ/+SXs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771977617; c=relaxed/simple;
	bh=4386tLM90omsQx4xrVZUTmgRDiJ/xpZr7qLAuOMLGvU=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=XNRZraGaSpou1d/amzkgzTyLd3wL70BvBS/0czH5SIVC8HEJQSz3X0VxeeQyVPmn2wRNFG98rpEzPfu5I/zH4KcTu9eEqj5MgRdwozZ+y1ZM8t5XsCrzsTDZFBeS5rTBP2VwV1M4Uj1cZP3TExujW/21rH0StIYo03jHHTuA64I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=pgrZCtI5; arc=fail smtp.client-ip=52.101.52.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wqMUpT7WgpKGf5VOrDCZu+Hakw2dSRQeowzPdFoc9izs7QlfQUvokZ9rfOfRAEC8hAe2iZl2tn1ttUZx8eoGDu20GP7iEyWyRHmVwkaNXDTDmXwQefbkdYi4beexwxLv1jmUXOWAVmRGS9vu5/JzdgcRbnKGQZ/5TOj0S2eI8/bKjkKgdxECRiKwkVKW9cfOtjXJB+ZGkWy0EBjNpFIQIUCOXb8xi5cnHW5pJcXvPFNzTGa6Z0qRO+XuFUpsChfdFba8NsmxqPw4fOMIVrz+jpw22bYs79nI2eIWIfGKGN8iO6tC5VxZu97d943K5DmlqquJvcYwrTQJ4rtqlZEk5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kyTgKwPldyHm5fiM5JER3vbLmNnvun6ATNhkrKrEgbY=;
 b=e235Z/j5FpvGmj1KImaUUBepZktJJl2CPS8LC+y7lI61606hutMzADmKX40Tn89eUHvrHdhOe9Gxu4bPaOkJVrEH1xFByVUtskcN7B4jRTKrf+EkF5NH/J10kAub1zwNmBOdkmhxwI1fG4+hCuJs4x5bLUOE3jsKjzBUTxmSE3BltPA6BlPunENAhBSizDOFSO6Mea+mL+RsGg4SfTPCmrQMQqO1YwQPwn8XwYjtUdCkhoNmdjsuEJ3YXJ308ijSLhhaCMn03ZCeK9TB0JXLiNuYDZ4UZ+os2OGQjErThNgDLCqSuTMPZtuhjRIhbRNQOhHTLGnzU+RIlbXEA1pGTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kyTgKwPldyHm5fiM5JER3vbLmNnvun6ATNhkrKrEgbY=;
 b=pgrZCtI5DwKOUWM+z65hubHE67+1wWBr6Bua7mND59zaC3JUJcjivNViq0X4yjyPvF7wQ81ERsEc96IS+naJc/S7k6qSi3mcwTR+bFtB13LqqLiedNhqRRv50hhuSj0BaPZK/ywSTrb/em7uLD37FDe0AV288SY51j75Vkq0uVqqyXGvRJZkNbhyCGvAimfPoOI+cCDtnB2/zUXR0NWz5m3oe7uKEEpelkRMw0sT4454ZqkOnH1pz1duee8uj8OaQqaTqo6sh5P2waocxgJ7GyfFvu7jOavADiaGKoAhUxncEbKu6lD/+uCf+nfuiN2aXfQKPxedVbHxWB7Bu6y3tQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH0PR12MB8800.namprd12.prod.outlook.com (2603:10b6:510:26f::12)
 by DM3PR12MB9351.namprd12.prod.outlook.com (2603:10b6:8:1ac::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.17; Wed, 25 Feb
 2026 00:00:10 +0000
Received: from PH0PR12MB8800.namprd12.prod.outlook.com
 ([fe80::f79d:ddc5:2ad7:762d]) by PH0PR12MB8800.namprd12.prod.outlook.com
 ([fe80::f79d:ddc5:2ad7:762d%4]) with mapi id 15.20.9632.017; Wed, 25 Feb 2026
 00:00:09 +0000
From: Yury Norov <ynorov@nvidia.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Yury Norov <yury.norov@gmail.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Andrew Morton <akpm@linux-foundation.org>,
	intel-wired-lan@lists.osuosl.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Yury Norov <ynorov@nvidia.com>,
	David Laight <david.laight.linux@gmail.com>
Subject: [PATCH RESEND 0/3] ice: use better bitmap API
Date: Tue, 24 Feb 2026 19:00:02 -0500
Message-ID: <20260225000007.255837-1-ynorov@nvidia.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BN9PR03CA0172.namprd03.prod.outlook.com
 (2603:10b6:408:f4::27) To PH0PR12MB8800.namprd12.prod.outlook.com
 (2603:10b6:510:26f::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR12MB8800:EE_|DM3PR12MB9351:EE_
X-MS-Office365-Filtering-Correlation-Id: e3a6a6ee-0500-450a-541f-08de7400d743
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|366016|10070799003|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?qOG7p0EpEMMr0jkwYO2m9hT7H3WwwCpjHUJPGWHDfxjcd6B3WtJlOoO1pds0?=
 =?us-ascii?Q?tTu8IBRYWIILrOaUd59qQYAEohI6YA8nllyDrb5s5AHb/bQ1ouZciQCRvBnn?=
 =?us-ascii?Q?ZoQEhs21/zvMJchGKTv/0v/tGy0c7+v2t6hMAp4Gbr2DIryaMH7R7IXyUrNE?=
 =?us-ascii?Q?OwwK/fx/AuN1QJY5RbNekUkQCFsrRVYebHxS0nCATAYkw2lJsFlA/3CPBUrr?=
 =?us-ascii?Q?mkGDuMVYKq7Y6PRg8d/QPVf5MReC/uZ/WHpmYy5nKeJ2r6HTgXrCXWwvFkMJ?=
 =?us-ascii?Q?UIm3VjtaADHm0AX4BLNkNWUaSkCmjh7fgwshK5NSFmik+HHwYXI3A0LEoLXN?=
 =?us-ascii?Q?FC8FDyycbXem9bX1GiOmxFNGERJe5xgpaz4+VWNhPI9/gHD3evvOkWF/SNu2?=
 =?us-ascii?Q?E0JmoqJfxOb/hy4HqHOT5z4fk6FCNPymljnonEMN6Eid4hCg8A346D3DQDiX?=
 =?us-ascii?Q?mb1236zOoYc1Ya9rFSmqv1oLj69FBzmMvwRl/o6v/vmkchk+wir66Dkz1aUJ?=
 =?us-ascii?Q?dlcrxOYN5vmHjdqt+7fkesju8B3EYnNxlZA2ZGMsZ/sHvD0L3CY2F+MMOS0H?=
 =?us-ascii?Q?Acpo7YVOOaw3W2PxU3HD7xL6lnJX3YlMgWaxvSypzqqkXaQllVeMM9Pk5Cnf?=
 =?us-ascii?Q?QLzy9SB/Kyv58PuYARp6gu7SkhhM+I8Q7aT+LXbmapvdeyjCk1uR229soYUm?=
 =?us-ascii?Q?RzddkWE7QCNi67r0ygQdqmloYnR2nEA1WhNdTgEw/bnTim2UyqOgF/uYQbGY?=
 =?us-ascii?Q?NB6ip6LYTegf0YdxXang+M4HsaITPAubYS4X9ESjkSnVQyWo4YGsWJUmX9oT?=
 =?us-ascii?Q?lb3x6t/kX9CqyIqhz0amh0H/wExr7fmqVmF+0hFQDZ1XLBdXXNNAr1FcKadO?=
 =?us-ascii?Q?Us45jP3qAubATByjzM0nR8Hl+P3GyKoJI/3NGUjfMhJzYMeJMRCNA/chsn/W?=
 =?us-ascii?Q?Ek489TcYH+6gak/6WIwn9out14LMXL2LxmZZlPwVO5fruVFTpSU0S1zC1l1l?=
 =?us-ascii?Q?3rXH/mtv9tmkWqYpwKhffCSTjSMlTAjDEAO/ohYIkQcnxGyLhDBqsWsb2Zwp?=
 =?us-ascii?Q?Ihjuyw+MKPQAgG3hYk2YmHDVsf8EETc2E426eBVF/XBRz0FBJdIMwI7inDVs?=
 =?us-ascii?Q?6OfHHHrKyjRWvL+4dWkm+2TERbpMN+WPXURJ6y2X5JDi/xewvqkw86xqffZt?=
 =?us-ascii?Q?6wltLsd0NV8VA49URI2mVX6JHQ0YUHWOi2NDoRILz6OPeSngDKhPO3O0/g9a?=
 =?us-ascii?Q?Zz8prccenG56s1JTxoTy0lwY9yNsipgKcHI6KiyJO5vNQX2vqY30tXWZWwNm?=
 =?us-ascii?Q?+YTyZlTy6c7TyFMZNQilHo52ZJYv9gJplxlpKnDujQskmnAAPwP7AXX3tawo?=
 =?us-ascii?Q?xCwBtbcLHF6CkxuHe6HKdf0h91M43ejL0PAf8aaExW/YT90UXwE0SfS+HG2N?=
 =?us-ascii?Q?HdkPKl0YqnK4jOdS7Rv/4BoZd5WCDafP+OJRrm3PseLehR5/rfJQFOZotr+J?=
 =?us-ascii?Q?mOtQe7EOm78bc6a2fjhlMhOoMxwK1AGZ/8hctG/xkiwx9Li3Wts2ONK16x3N?=
 =?us-ascii?Q?l65B8NEFN5qKLu04gV48JoLzuFpeQ1AI639W1gWXxlFgqbofmtbh6kptzBrA?=
 =?us-ascii?Q?2WS6yRucrO/jCG3E0XFAEFY=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB8800.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(10070799003)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?HPXVLB/QDHW5tL9/mspRWBQtxLt1850wSvW9RKBz/74pb+CengOMg8BeHkxF?=
 =?us-ascii?Q?F/4sQvf5yXfjZCBHq3dGAPiwSzQxJEECV5g68pwNMcNyx09OrxDBaBrvp44K?=
 =?us-ascii?Q?NYtXbVIzZlgyBCg9xCUsYtevoyTi5z3hQybCTCVANRyOWRKQibfpxTvdCmQh?=
 =?us-ascii?Q?GtACPSG3BYIDDY8deTt3dA631S+koDJnSSG7Nb4Ni+3AV3l9tFyTduLR3TeT?=
 =?us-ascii?Q?gWZTPkZgTqnnsKcJkal4jKSPMG+wSunlYriB7mtnsYiI51oQeK0sH/ZUK1p5?=
 =?us-ascii?Q?QHcF4doeEXFtmBDMFdHPkXV8V7SlM/rGbOQetJKGIrcFq6HhhMuziSerDgBs?=
 =?us-ascii?Q?SHdid1BgnnzqEAC2YunNaVMh4IHCEDAFwM6iZErWMV5LiZmn1ZwEvu52mQxI?=
 =?us-ascii?Q?z6wy+hXsKwWmc2s3gN7XKQkzhjaohKbC3SZuiJej2pEAY9X5FOszps9iCrz4?=
 =?us-ascii?Q?S3G9f7HiGcKS6X7nmSzvD9qlSkrgwKaoa7azvXUWPGKDeznXQH6EA4Gtx878?=
 =?us-ascii?Q?pT5FHG1DJ5/1UC+4AXm72x2AnCTqZu4GaqZsi/M7AlSqSHFdJ+QspJERA6Ja?=
 =?us-ascii?Q?Z6E1GDhPC/CLEIHvEbeY87GMsitsz7cl5MEaFGYOxwq0kATGSa2qSYx+SNKL?=
 =?us-ascii?Q?A8JqlfhkE4CpCkn6SaOVCekgZ/aA4w2MFR4w1io5GKeGQq53UqArfXanvAnL?=
 =?us-ascii?Q?PgFjuIuDBt5ygS7MqxkZwv1JqCSvZ6URsVf8dlTzSsZm6OKjoMcDcZ45FgVJ?=
 =?us-ascii?Q?mvbmPDUYycEgsLYRrH2L84DEl+cuSkiCSzBzNxr8xNAyMtCOv9rcP+/+LHRZ?=
 =?us-ascii?Q?xmzUSwz+YIkytWa8bWwfJz/BIQD2UyAc6IW7908SAlAnf7xyE54FdKtHDFZ2?=
 =?us-ascii?Q?nieInyY3huBrg6eN+4lghTt4rk3XUPsOcFrJaN5vXcQIQhLf5vKoqpB6eN3l?=
 =?us-ascii?Q?qfJAqiOt2lgf5ErtY5QUCktIIs+z3dankrBlADcu7gglOqOLZOeJAIAtTpSi?=
 =?us-ascii?Q?H+whpaWY2lZGi+rT61kWtCdFv9nap4ksCogzex1BXHH2T5i86NOBTp9gtJav?=
 =?us-ascii?Q?vuMn5jVQe4QBVQXVA+nHLxHK6PSidfUzAUSxhQk+wScR6xr96ouK7KRJrBPA?=
 =?us-ascii?Q?o66qFPv46D1kFmn1vx/n/BHFbW7hCRpvBPfTNpKFvdGOC88a0Hd5Xkrsh4hu?=
 =?us-ascii?Q?jJJxHiBODPKEApF5RKYZrZVE0PaEXt/QkljENqEsSOqIFdTcoseaUFrE6Q98?=
 =?us-ascii?Q?2VFuTWLhBxO2qTiEed26o92yi91BHNnSJOgy4OSSo3us1WvNfsTDcBcflHB7?=
 =?us-ascii?Q?6d5uwlfBX4+NfkpCWB72RlDsJcoIFYo8f274q11roo7+lQFNseX81pcctdQc?=
 =?us-ascii?Q?IAZAyvSK9aykW+Wb53rxhWQUC5yb6XTtUFqrcRRAln8BI2dRSfxPL9NGrt2Q?=
 =?us-ascii?Q?Cj6ZhwgNeX0lHZoVDBE0eG5qXzg7BIZeMkbZDlzj2qYJRSzDo9UPlyysA5B4?=
 =?us-ascii?Q?3ohVxfknDXtEtm91ImiXmOT2AgYh/Y5+rLJmXvMrsaipnydJTZkaLzEBFkk0?=
 =?us-ascii?Q?IBZvLBI3g6DOXFxuHwBG4750n4V8tXjhgR1e1BRsp+d2hGt3OCf/68ah0TR2?=
 =?us-ascii?Q?Cbfl0Zt4Sdo3w5J2muXuCtyO8MoFJY/N4jk4fyXJWloWIWAwUTsE5g2WgHcN?=
 =?us-ascii?Q?UaPJS3x0ya1zfg3CmkLtMXXqEiWiiGJWK4wjgQvVbuDXvGbp68ELUHojJ43h?=
 =?us-ascii?Q?b9APriyBkjusu4D8CrswUWqWlWSd2BeSZiay7Bz/1sAqpSvRK8xf?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e3a6a6ee-0500-450a-541f-08de7400d743
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB8800.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2026 00:00:09.6108
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: e11/wn8Qbr2jOpod/uoUJyPnQo/z1/j9JlzhvUuQq9xRHb1VndYgh/X+HXJYBCSszgCj/Tb4WbblhSuz9H961w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR12MB9351
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[15];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-260677-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[intel.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,rasmusvillemoes.dk,linux-foundation.org,lists.osuosl.org,vger.kernel.org];
	FREEMAIL_CC(0.00)[nvidia.com,gmail.com];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ynorov@nvidia.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.983];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D238818E389
X-Rspamd-Action: no action

Use better bitmap API where appropriate.

Original series:

https://lore.kernel.org/all/20251223162303.434659-1-yury.norov@gmail.com/

RESEND: rebase on top of v7.0-rc1

Yury Norov (3):
  bitmap: introduce bitmap_weighted_xor()
  ice: use bitmap_weighted_xor() in ice_find_free_recp_res_idx()
  ice: use bitmap_empty() in ice_vf_has_no_qs_ena

 drivers/net/ethernet/intel/ice/ice_switch.c |  4 +---
 drivers/net/ethernet/intel/ice/ice_vf_lib.c |  4 ++--
 include/linux/bitmap.h                      | 14 ++++++++++++++
 lib/bitmap.c                                |  7 +++++++
 4 files changed, 24 insertions(+), 5 deletions(-)

-- 
2.43.0


