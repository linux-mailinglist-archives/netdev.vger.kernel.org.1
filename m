Return-Path: <netdev+bounces-53760-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B057804891
	for <lists+netdev@lfdr.de>; Tue,  5 Dec 2023 05:32:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4D93B1C20DAB
	for <lists+netdev@lfdr.de>; Tue,  5 Dec 2023 04:32:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82F8E20EC;
	Tue,  5 Dec 2023 04:32:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="HqHHErI+"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2071.outbound.protection.outlook.com [40.107.244.71])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64D94CA
	for <netdev@vger.kernel.org>; Mon,  4 Dec 2023 20:32:44 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kZVoQceYEn1ALZUQUw5Ykh/Q/pOIrC52OKnIHnHySv7bgRfbocPkeGRT6C/fm4vYLWcskfx/WDyKkP6cpvMzwxe4TExQ0AkNVFTKXCf8wHuPOd/ljKH2t/D+1nE1KXT+ZA3hN2pOiSRU5/VcijT7XGXwzwXEgEuTQOht/xM4vy/bOcy7SXKWCXwSzIlNcTIiZuqriqSTewy46wNkmdv82XuJXP/LpnNDJgl1G2QEVbhHXoJMT3fP4/xbx/wQtuH9MHeq9ZKzFMayfHySW/vGP1uxTxVcHJQpWa14EF45rduRR96/b3mVZoWt61hdGNqAGc/aO9OXAIsK+80cYQL4pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uwiXGNlvmVtAQovwweopbZSZtmte+MeyK08S0ZcqpwQ=;
 b=Z4vpk76Zjsl6pWDDZfZYfJUo+W+2ANzU7gK3XjOAgL5weeSQ4r76WFmPA3tXHSHIGbi7kgGnDSLCvTF8FhdHYdhoiSr2JYOJFpS4H2Ait+eUixuZ+sroIak3l/bAlOK+63kRp06Qb1vjOsoqkQ18JB5WZ7blHWAyuS0jh3Y8ystg8Qt6d+z7DZDMmYFq1MEfJwecFi9BMOtpimF6jNmrEbUWyb3+fyjsJ388WxC25PgslTZH9/PkGT0OSshUplqEiNkW4KUBdPkvZnS9a1aQeB3U98JcIx+pjVAdmxC52sgIfANc5F4pF1QcqnUUzyxyFIRvp5QgAGSkcKznsMDMDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uwiXGNlvmVtAQovwweopbZSZtmte+MeyK08S0ZcqpwQ=;
 b=HqHHErI+D2+4Zzq/KkMcnaExXr8z/FkgdfX+CzFJUZ3Jc9pRbVcO3a2Uyuh64r+7vawzO5U4fYs+3s2vMgb159Tq4T3JYpNDbAPbdKKZImZtVGTpzWwFHrBrDRIAm0mvooaCIRMH3NE2heo9UoXmf0+e6sEnywjHpgkYo1F/8nc/4oLHGe+SDsRZSn8IRuO9kuPORQ59XKkrqVG/Y7E2zVuf5Z+1+J9/2hDBL/4qJQWBEHIAKCXDkHjZPzdvYJAii4iliYj24GYNu00gn6S4MIGL34fKo1hY9Uaj0iVUlUWj6hTbk4qRkj2F5MTfKc/LQTwPgNtluErqY/8xSK+sJw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BYAPR12MB2743.namprd12.prod.outlook.com (2603:10b6:a03:61::28)
 by DM4PR12MB5795.namprd12.prod.outlook.com (2603:10b6:8:62::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7046.33; Tue, 5 Dec 2023 04:32:41 +0000
Received: from BYAPR12MB2743.namprd12.prod.outlook.com
 ([fe80::ab86:edf7:348:d117]) by BYAPR12MB2743.namprd12.prod.outlook.com
 ([fe80::ab86:edf7:348:d117%3]) with mapi id 15.20.7046.033; Tue, 5 Dec 2023
 04:32:40 +0000
From: Rahul Rameshbabu <rrameshbabu@nvidia.com>
To: Shannon Nelson <shannon.nelson@amd.com>
Cc: <netdev@vger.kernel.org>,  <davem@davemloft.net>,  <kuba@kernel.org>,
  <edumazet@google.com>,  <pabeni@redhat.com>,  <f.fainelli@gmail.com>,
  <brett.creeley@amd.com>,  <drivers@pensando.io>
Subject: Re: [PATCH net-next 0/5] ionic: more driver fixes
References: <20231204210936.16587-1-shannon.nelson@amd.com>
Date: Mon, 04 Dec 2023 20:32:26 -0800
In-Reply-To: <20231204210936.16587-1-shannon.nelson@amd.com> (Shannon Nelson's
	message of "Mon, 4 Dec 2023 13:09:31 -0800")
Message-ID: <87ttoxuv51.fsf@nvidia.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Content-Type: text/plain
X-ClientProxiedBy: BYAPR07CA0072.namprd07.prod.outlook.com
 (2603:10b6:a03:60::49) To BYAPR12MB2743.namprd12.prod.outlook.com
 (2603:10b6:a03:61::28)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB2743:EE_|DM4PR12MB5795:EE_
X-MS-Office365-Filtering-Correlation-Id: 6b5c7036-8c99-4dd1-25d8-08dbf54b36f9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	llgUuxqH9v+24hiVvqHZf+++TrTc8aMu/5zr5v6EUke+yNipB3LTXhycwvUAXzMMQXERrmVEUBC2u4NarNXdk1GgHhymzpVtIATmsyC+iyWRD0RgDbLOX2rkZr51Etm3WIPpr10HPT8zWBP7GkujqV0OUhkuY2g9NZL3hc55SCeqZVAEDcmFvhBoSxe49AKD6jNafOg+EXZkuUECSltbDLghGgTBZUkqJq5VmLralI/BRIBu1e4//Zrv9AMkeCIpcnrrkn+V3u31pBfxPvXsFCUZXfcmsbDLgcxwyK82enej4PxbelU8iFPxSDpIM0eMSxnHF2994WbnKMCZyIL4jZtRmfiqRdkPHJOQ8+CAxx8s8hqXZ24JBpA1qJhfj6ngl9+N+ma8pKaeH4ZrW16jaoxPQKXsvagIFoMnWCta9qTP0PRlHyu4OD9bQLE7g9/80qEaJlbgfK4nZS18GH5rg+WrvdiB71UMwZskLL9uFgIC8SiOK1fLdp751uZNpRNJB6vQ7ixxSgyuEctuFrAMJ2dVfYotDDGXCkQ7Om0HZ111KzGx6k4XAE84G8NUGRx57JGXuxL5/LgWZzO/ekxo9Y/DubfMfSuY0Om3O+CTKEM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB2743.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(39860400002)(346002)(376002)(136003)(230922051799003)(451199024)(1800799012)(64100799003)(186009)(6486002)(6506007)(6512007)(36756003)(26005)(2616005)(41300700001)(38100700002)(86362001)(83380400001)(6666004)(966005)(2906002)(478600001)(316002)(66946007)(54906003)(6916009)(66476007)(66556008)(8676002)(4326008)(8936002)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?EcsuEItJ9CogYSGDumacHnr5/HlvWm2vaZO7a0k5sQ2xVLFrGkEpMHhVmZTC?=
 =?us-ascii?Q?PXd8WeOSEhqmy/EmqsU4bMo3RSxXdspkrdST3NzwJIkSAZ+IUmzUMMrDNWpP?=
 =?us-ascii?Q?aSULhbbOs9xbl824M27NF8QxMZAsmNZcDmKuxzV/Jb8inzAI2Lx6vSJgLZ5l?=
 =?us-ascii?Q?/DxL4gbL7iWKGbZZJUhXCOQ4XWJ2WCArTO9XdGsqKdBxbZVDpGp0FI5kqMTn?=
 =?us-ascii?Q?l6pyjcb1v+3EeWTIojgXPUo0ryVT7Q7YmIZCPVMN9bzQ/Zi915ErtgTLAw0c?=
 =?us-ascii?Q?QYfPXWR4lqI3EmKXxEEp2WLp+TMHhwUceJvcMyhIb9N9mWb7KiYvVjZ5/JmF?=
 =?us-ascii?Q?LEiSftlaBOChNV28gq2Vmg8HJS8WkXk5R7Jr8+vfR5mY9Ytz+6hi7IpEq5Hc?=
 =?us-ascii?Q?jXfdqziST6SyWjIEc/IP281facFTvFUHNX69d8xxEMMDyPv+ksMnHIwlsTj6?=
 =?us-ascii?Q?mTC9DQv5sNQmINbMHE2xf/oZ6eBBAcpVfGNoH8n1umut7FdQPqtj4U7Y2jHw?=
 =?us-ascii?Q?Mzk8W9o7GKLRTDSRpPHjvXfouGtxQa8Yx9FM2HUIQGaO4hy7d/TsMRzm5Ssr?=
 =?us-ascii?Q?lWuokMVp1dO2zPRwGgX/I7t1iXDQULgVPIb/2D92ce64D8xI0kY1TEc+I1gl?=
 =?us-ascii?Q?QFNVN8AynXdEU4vnQWj2le7ESdx3Ww0zfn20kUlefnnMWVhvXyUqSk7nMHjQ?=
 =?us-ascii?Q?hg2y0/0o1ZcMLRWAKDqmhq1bGWEXar3vmE8/krZqJjcHl9FaYPuvzVRiY16A?=
 =?us-ascii?Q?j38JkHgWUE7Uj5BvqkCuQi+PWox4MDTPtm/XTnsthOakMeMJ9Bi4O5i56WzN?=
 =?us-ascii?Q?VswAaHH/ftjQC9rjRGdwJ3koi9q7ZECvMjeaFw4Btp8sRnHGHzSEJrL6JPJu?=
 =?us-ascii?Q?jZQts90AY1nhKqmyQ3d7HQQV6BpeNTziyzDZVhcdK2mfL31u34JLe6xGrxmb?=
 =?us-ascii?Q?/Mm30dIJ1xiWOmMOaGoRHc/ucwzUA+IUbGBEnYw3BxnTenaF2wzjc2iojLKq?=
 =?us-ascii?Q?Vxk+AhesZyVMkBSmAi/NkfBdd37SIIMC0DO8SqqbHhbqxrLHioQATrKeBw+3?=
 =?us-ascii?Q?jRDIbAn73EfVSxEYpj0FUBJZKfQkYLyLbU1uMswcCmzcSxJ+fFBSaip50JzP?=
 =?us-ascii?Q?qsURMWOG5luV0z8FUUxhnDl1MdlAyRCoWIZHvpMEnyC47vYBdPCMsZMZSyBo?=
 =?us-ascii?Q?dg4LIAMIzLrGdW2gLniu0GNPqa9F6AQGcvKbjMEF1H7mCS5u2oXHz/HqfksU?=
 =?us-ascii?Q?ajEbUiFebQW0gnh0QWEQ5Dsm3gVAJBJc4NS56Szs6MCGsCv6Ohlhm9UcVsWL?=
 =?us-ascii?Q?1e4JQavlEgfhA4PfqUmxtjeMHw7I5k9AUeCkzz6Yg5bvEvm6Gz7ceOCL9AR/?=
 =?us-ascii?Q?IRb3Oj+rrhcBsUe6p6lNoJDw3kc1qbDLiX4nTHeJs8ovwtWixSsiX7wve3vx?=
 =?us-ascii?Q?X4DCdvJkikCId/dS0JR+bB4j740qVkCWBR7dlAQ+jSvoxzetniKal/UMpYjb?=
 =?us-ascii?Q?JZvE0Tzmr2/+07DQzYfiNdnYeX6lDBvppDvL8argLmJyLsnZwGcoaUY+eLej?=
 =?us-ascii?Q?uxJya2olVCIjHk8MV/I8xl2rbRYrNctZ4aNSweWsPYePvx+RgNelgxjMUuxe?=
 =?us-ascii?Q?sg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b5c7036-8c99-4dd1-25d8-08dbf54b36f9
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB2743.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2023 04:32:39.8600
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DtHGsBYDYOve/kxN/fUl/6i4XUVQxSgb+vTd731PA0VQopaLyRmXGHts3UrKWyeq4MVRyScQu49iao/WlbbbhA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5795

On Mon, 04 Dec, 2023 13:09:31 -0800 Shannon Nelson <shannon.nelson@amd.com> wrote:
> These are a few code cleanup items that appeared first in a
> separate net patchset,
>     https://lore.kernel.org/netdev/20231201000519.13363-1-shannon.nelson@amd.com/
> but are now aimed for net-next.
>
> Brett Creeley (4):
>   ionic: Use cached VF attributes

Was on the fence about whether this patch should be considered a "fix"
or not. I think it makes sense that it is a performance enhancement.

>   ionic: Don't check null when calling vfree()
>   ionic: Make the check for Tx HW timestamping more obvious
>   ionic: Re-arrange ionic_intr_info struct for cache perf
>
> Shannon Nelson (1):
>   ionic: set ionic ptr before setting up ethtool ops
>
>  drivers/net/ethernet/pensando/ionic/ionic.h   |   2 -
>  .../net/ethernet/pensando/ionic/ionic_dev.c   |  40 -------
>  .../net/ethernet/pensando/ionic/ionic_dev.h   |   7 +-
>  .../net/ethernet/pensando/ionic/ionic_lif.c   | 107 +++---------------
>  .../net/ethernet/pensando/ionic/ionic_lif.h   |   5 +
>  .../net/ethernet/pensando/ionic/ionic_main.c  |  22 ----
>  .../net/ethernet/pensando/ionic/ionic_txrx.c  |  10 +-
>  7 files changed, 28 insertions(+), 165 deletions(-)

Reviewed-by: Rahul Rameshbabu <rrameshbabu@nvidia.com>

