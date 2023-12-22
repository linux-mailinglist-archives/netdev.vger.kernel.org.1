Return-Path: <netdev+bounces-59922-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C08AF81CB09
	for <lists+netdev@lfdr.de>; Fri, 22 Dec 2023 15:00:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 36CCFB24997
	for <lists+netdev@lfdr.de>; Fri, 22 Dec 2023 14:00:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9DB51A70A;
	Fri, 22 Dec 2023 14:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="AWgycO+p"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2046.outbound.protection.outlook.com [40.107.94.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 853E5199D1
	for <netdev@vger.kernel.org>; Fri, 22 Dec 2023 14:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ih5OJ0foCerVJSCfzPsUhgaJHeS5z4Npp91U/teWZYOYfnWXnNwpGnnegXI7PoOB5RgjhTMN1aV4b4yn5UHOpNWeWxzmGbLDFmL8MDhSS/r7gxEH6ay7Qapf08OnthnbGt3VjlGm+SDZioFZQQEBeD/7lOfb19dIzJJVL8hWJfpZF9+2D1a+qfShVvNo2dsY1k1XCH/Gymy+Kh2EFPlTA1ybATioYBPWoxE7W5PFSukmmEgF4yadb65QxBYHz3NdPIxjaPINzDSQEFBejgyFXAmt/M5D0XuiKSv5Afzy7zJ/Hn8zdZCKgw99AsIpIAXa2/3aQyc6iEgOjR95zWJvIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9Qd75Vv1J2KCA0oAMAPgaUYjKOK41K9fgRRCJKyNQ1I=;
 b=QseRcVRNiXoRRDiF7jwWyI6hsfgrFt2FJhjPpAqoLIRkYJKPRDDyTAqa2YNYbFj5wkUdwaen7Y4UN/BB2DwrjdpNs4lNJwBTDdw6v2Yw54nGYr8fjn+19nOsaYU/+zphGMrxhTcQdZRuOY5Kjlto5izbm8QI2a5oYKQW9dAHkVAE6TJqBciX9JmBasEnHp0P5dl9Ao3P0vCoisaZD9r0XSdapoLL374/8wBOPp69K2XSpas5yAfprZ8dN2fVRXNPtd4SOpuN77aV/BgHiaHHdtbOrWNqle6zR+A/26yu1LvHyzFjKCainDz3NO/L09dM7b0Js+Tfsu3WAQetJ2st5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9Qd75Vv1J2KCA0oAMAPgaUYjKOK41K9fgRRCJKyNQ1I=;
 b=AWgycO+pAaw/dIXvV2Jb6tAdX/ts+eC60eWSXw1i3uP9W+BYfAE55xHof2EmjrRne90+fedUuNpvspkDZvpYbaJpSyjI4Gb/PiWMpzS4c5pClCfGzxdrhQB1ZXmIlld10+NK4zkrArHF/p1wZMyr+NBlx1XifqwBlFzlVvAi1nAYdX1zaSNb9FoJETLIZ2WrrA0p+Y9g1yV7oGXV8mIMUFZ89goif/88AE02DcAZohmZiepc8Zt94D3K6TmY63k8j0seWBR3Ltl2GFk/RRWwUhBZmRBOzw4h+LC+N/7d39zHAMdpdxygWOpIUx+xMf80E0+VVuSkkhcTBS4bVMTAQw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4373.namprd12.prod.outlook.com (2603:10b6:208:261::8)
 by SJ2PR12MB8955.namprd12.prod.outlook.com (2603:10b6:a03:542::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.21; Fri, 22 Dec
 2023 14:00:00 +0000
Received: from MN2PR12MB4373.namprd12.prod.outlook.com
 ([fe80::ff68:f81b:d451:9765]) by MN2PR12MB4373.namprd12.prod.outlook.com
 ([fe80::ff68:f81b:d451:9765%4]) with mapi id 15.20.7113.019; Fri, 22 Dec 2023
 14:00:00 +0000
From: Benjamin Poirier <bpoirier@nvidia.com>
To: netdev@vger.kernel.org
Cc: Shuah Khan <shuah@kernel.org>,
	Petr Machata <petrm@nvidia.com>,
	Hangbin Liu <liuhangbin@gmail.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>
Subject: [RFC PATCH net-next 01/10] selftests: bonding: Change script interpreter
Date: Fri, 22 Dec 2023 08:58:27 -0500
Message-ID: <20231222135836.992841-2-bpoirier@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231222135836.992841-1-bpoirier@nvidia.com>
References: <20231222135836.992841-1-bpoirier@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YQBP288CA0020.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:c01:6a::24) To MN2PR12MB4373.namprd12.prod.outlook.com
 (2603:10b6:208:261::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB4373:EE_|SJ2PR12MB8955:EE_
X-MS-Office365-Filtering-Correlation-Id: b7bc7b2d-a461-47b5-98d0-08dc02f649c4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	FPNn64U6rkkhSPlgyl2S1mAGbhU6fkB4ghlX58Xu24lTd4+4o/sruPY8sJxPOfWeQ26pcikvC+U6hEn8BrwZxnwCoGaiHRbHt9QrGBYCZb+NVHfD+QPeg1c3jT3HJ2yoOfykMvA2fmQvPgiNXHlHox4eIpvLMgKI444mevcw5z6kdnHK5Ra28tkNDa783yijHMZNXcSQeWZ42YbfTmoDx/oZJJ9EbGeNyEeVhDxl/EV5kMACgjJ+/Flf9EvVDgukthXI+D202sshLQKdXcp7TqOtUbmdvVSPdghcA9iLKI4RxNtCA5FoFH9U7bP/WLDMnmNKHZTpg4KgEjtP2R3RfGtyjFly/3BFDp4Pllzr3iYI4Aj5hr6FhbP2UdE0RDJmVDLETLi4Suwb/05K7nDnKsCJRhdISWSTzwo6wKSG5diYTnkUInq9HW6pXKYi1ijZcKuE13+Fz70r+EVpLTpD3Q5RXcRXB4oeSZWiHCFe0KHCqnWZdzkl90T79W/aaWNO5480gycQXtgmKYPVXV7OD4Fw1TszL8Lyp3P3XNi84SGq3kOO/CbxwC+pM1LvSq3q
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4373.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(396003)(39860400002)(366004)(136003)(230922051799003)(451199024)(186009)(1800799012)(64100799003)(478600001)(6486002)(38100700002)(4326008)(5660300002)(6916009)(54906003)(8676002)(316002)(66476007)(66556008)(66946007)(8936002)(1076003)(26005)(83380400001)(2616005)(6666004)(6506007)(6512007)(36756003)(41300700001)(86362001)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?dsEjMZMMmIJISoAYLtt9s9H1ODtfzK33wbnqnrIw6i7k4MzNfkj9Tvyd1qGr?=
 =?us-ascii?Q?iiUbnlo6ozvLdVX0XYK9Hhkae0vbc0t/nO9d1KnEWF32yb4hQWQqDMwzvtgg?=
 =?us-ascii?Q?2QfKTTCDV0KytV21DMK6QFX8Z4mDYnI7XrD0YWxx0zwZRF9uGC9lWIiNzZT2?=
 =?us-ascii?Q?LW0vPIUJ79UujD3w+LkTR6sAM9RAiEmazV1d1Mtdm3qlof1QYxA/R/iGCrdJ?=
 =?us-ascii?Q?OIVU7xG8jjKwTsVLyBd3Fbjk22Aq/zY0QG2yuxHgZOvEYAhFb+c5SInopkDN?=
 =?us-ascii?Q?phog+pGB4loiO2WvixPX3DLhJpCKdNqxb0So4QwgEKudw4ceT2kfq3UNv3am?=
 =?us-ascii?Q?cvL1ua7tVG2h2+4xkxlJywr21J2aMvLThPKuAUFZDNPgam41Fh0j45VTanih?=
 =?us-ascii?Q?Kl4VTVlqu08ZbslY2GLBX8/uVo2lMFbDQ8iFd/59R40y5EUJr5M/UPrljtaj?=
 =?us-ascii?Q?gB/AK096arQtu6rwF08chpkURPHHMaX/vXzw0RWSXGCUyrX+Yj9GYs5VbaXB?=
 =?us-ascii?Q?IEbUzPJuMv2N8EysaJbIBoxBJsp+X3VqVJ08HMYIt7Yr8QN80GxlMLnhw8DM?=
 =?us-ascii?Q?Voqb0DTuLvxgX5y69gbZnfCTYaVe5itPADykZXC2RteY6jenR3eb4zEmXyt6?=
 =?us-ascii?Q?JVvUP2DdWCshIJtqUtGGpt6hx5nZchaxmkdnZkBvpwinwi7EBBjjZhYZ5FEu?=
 =?us-ascii?Q?ytXKXsjawJY6pKMTelFWNWnSntUVnnyWDqr2AV1vNEGGBzj1XdzxMOw7QBf2?=
 =?us-ascii?Q?L5AUy9gYhq/dL0pwYkCOTl8dceKXtji4Y3o3Uzc1oW6BFsT+rQ0qSWcNlV4Q?=
 =?us-ascii?Q?4obOBs8stvL/PB41IaKL6zX1Cy6PA4KKdhCDMTAZbxLkyOQj/m7pLeDxt7wy?=
 =?us-ascii?Q?01PDVN1xqXTfROyKBm41i+FiUHohxDiTaSQPE5wIHIiC32gx6Ecnu0xv3AVI?=
 =?us-ascii?Q?qROxiJpMpAKPq80oDoJiY8OhnFjBz2cG25MVubRjCtKffjJbx5i+s3Z9vRAx?=
 =?us-ascii?Q?lNn34DoekLHlfEx59jQpHw977wVQWBLAZ79eOmNY1L+ROVDQfXn+Z+MHSpBr?=
 =?us-ascii?Q?lNGa8UU7iz7flEkeNHzIHeJrkkqgj5B5SpdRi0E/VDr9JZKIvaHHOt5bkt8p?=
 =?us-ascii?Q?wyR4cD4IUTPpF8TxJugYqqvESe/fOjEZ65n9EcZ2wL2nNxAtS9SE0zssThtB?=
 =?us-ascii?Q?p2S7oRLQv12R1x50XL2VuieeK7LMf3n+ayK3q7Z/XrT9/Ma04/5F4AIy1PzN?=
 =?us-ascii?Q?yLnAtaUlq/V0zcPg6xbjzFC//XKTAHlJRkbJaUbd3A9STzB7W5kv4SYttzD6?=
 =?us-ascii?Q?9YS/6VHE2L/ZKunJeSw3mkZL20KkOq+SEN5rD9jzpyrORgtgs/77XifeKPl0?=
 =?us-ascii?Q?2Rs9rki4ZMBbfzQeJh06nyib/vOv1CSw0OT+ZtYO3sBusJpAVlRqYiedG0Kz?=
 =?us-ascii?Q?5qKk0LA2Yk/TSAjnaahDE46iQR5j1K7YLJCO3OiJqmTdbslEMFQCRsMGmgsd?=
 =?us-ascii?Q?ojGo+A/Ff/+PiB4BKD0S04dmqZpaHeKc3pOdaa/OMlTUqcwmuO+s0d94/B5x?=
 =?us-ascii?Q?WvuAlNtv4Tue8pR5T7+UuehsuOaaxZyCDCWlNHvc?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b7bc7b2d-a461-47b5-98d0-08dc02f649c4
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4373.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Dec 2023 14:00:00.4557
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: x8iXHnhcgtYRaGIHxX7fGStiHNPYX2CDx3KrCAnxXYE3RaZ56ViJHxQcrx2q+IPPM5OnG/0xPQJpSPPi0dOjyQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8955

The tests changed by this patch, as well as the scripts they source, use
features which are not part of POSIX sh (ex. 'source' and 'local'). As a
result, these tests fail when /bin/sh is dash such as on Debian. Change the
interpreter to bash so that these tests can run successfully.

Fixes: d43eff0b85ae ("selftests: bonding: up/down delay w/ slave link flapping")
Signed-off-by: Benjamin Poirier <bpoirier@nvidia.com>
---
 .../selftests/drivers/net/bonding/mode-1-recovery-updelay.sh    | 2 +-
 .../selftests/drivers/net/bonding/mode-2-recovery-updelay.sh    | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/drivers/net/bonding/mode-1-recovery-updelay.sh b/tools/testing/selftests/drivers/net/bonding/mode-1-recovery-updelay.sh
index ad4c845a4ac7..b76bf5030952 100755
--- a/tools/testing/selftests/drivers/net/bonding/mode-1-recovery-updelay.sh
+++ b/tools/testing/selftests/drivers/net/bonding/mode-1-recovery-updelay.sh
@@ -1,4 +1,4 @@
-#!/bin/sh
+#!/bin/bash
 # SPDX-License-Identifier: GPL-2.0
 
 # Regression Test:
diff --git a/tools/testing/selftests/drivers/net/bonding/mode-2-recovery-updelay.sh b/tools/testing/selftests/drivers/net/bonding/mode-2-recovery-updelay.sh
index 2330d37453f9..8c2619002147 100755
--- a/tools/testing/selftests/drivers/net/bonding/mode-2-recovery-updelay.sh
+++ b/tools/testing/selftests/drivers/net/bonding/mode-2-recovery-updelay.sh
@@ -1,4 +1,4 @@
-#!/bin/sh
+#!/bin/bash
 # SPDX-License-Identifier: GPL-2.0
 
 # Regression Test:
-- 
2.43.0


