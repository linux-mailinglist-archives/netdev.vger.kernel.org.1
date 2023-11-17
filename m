Return-Path: <netdev+bounces-48553-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EA6F7EEC7C
	for <lists+netdev@lfdr.de>; Fri, 17 Nov 2023 08:11:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AD8462810DE
	for <lists+netdev@lfdr.de>; Fri, 17 Nov 2023 07:11:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D087BDDA0;
	Fri, 17 Nov 2023 07:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=corigine.onmicrosoft.com header.i=@corigine.onmicrosoft.com header.b="NqiIaPAG"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2107.outbound.protection.outlook.com [40.107.244.107])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C93BF194
	for <netdev@vger.kernel.org>; Thu, 16 Nov 2023 23:11:42 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XPGrtvUDmDbP5BmVsOD1ceZZT04lLXaw21T2azp0X+hk5Z2iH8o3MuGBZ7r+P5NHnXUVL8IGmkq0Sltl2rwqKCJaFzhw4kUsMVQApKZerKjEzJg3YT24wOrFXjRucvWF6adjTogOjISCNQvNKqFNwPhnwuR85euDpYErg2LcxVG8K2UJcSMP/qd0kC5jIEdZnZ35pFtVV+YijeV780mvw2duDTW4hqQOLraNUC4JBzH27zDBL8dzA/psIEQ9y8VKKL+KgEb1tc70PHUU0jh127oJcUNCXavgEz0qwfUY2VJ1QYBBYmGfCtBzQ1/Si+99aTIeIoPWMmVPbaaq3WXkpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oW7FpLMEcBrRhTEU2hlwF1pY0EQhyhgrsVjq5aTdHto=;
 b=S3Uxime1ZPG0S4R4PDpyBdP8QltINZHBRC74n/7smUMNXBKAGrc9qKhhhdff/rDzmfzejPACdOH2VdYYUnepaVojw5PK0CabFq+RUKLvYrdtLWDqE6IMA+beN3dEQJno1vHAoaFUTYjX5yMWy06AWIAAfC2uIqrTOuTkvGTu9/WI5xea6+WeHgRYSodfbIq4AvaFJKQiApZrmIW4A035ipOkbyLRlKxc7GsWYGKIirnHu9GYNSjVRQrxvzxX0ZdOL6U1xhH8pINm7V0eTXzGmCPfL3LpqJvp7urhsFiblp00JlwcXLs2l1n6U72gEI5r/rnsUJdnxPXjql0jU3diuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=corigine.com; dmarc=pass action=none header.from=corigine.com;
 dkim=pass header.d=corigine.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=corigine.onmicrosoft.com; s=selector2-corigine-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oW7FpLMEcBrRhTEU2hlwF1pY0EQhyhgrsVjq5aTdHto=;
 b=NqiIaPAGbaVxHtVnG9yC7YamSiukabQR4iZMzPnBeGm7yYVZNVxth6YSBxFDHzFKUqNMum9ehYj6cT3Q5U/x12Mj3V9hz0D6b/rBIKLqLP3+pcUBbMfN6kI0BeVzRXIdqMssPYHhBTcJeyhPmxjiYdlKbyD901VDqQbLKcWGSf0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=corigine.com;
Received: from BL0PR13MB4403.namprd13.prod.outlook.com (2603:10b6:208:1c4::8)
 by CH2PR13MB4553.namprd13.prod.outlook.com (2603:10b6:610:6c::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.21; Fri, 17 Nov
 2023 07:11:39 +0000
Received: from BL0PR13MB4403.namprd13.prod.outlook.com
 ([fe80::d3c0:fa39:cb9e:a536]) by BL0PR13MB4403.namprd13.prod.outlook.com
 ([fe80::d3c0:fa39:cb9e:a536%7]) with mapi id 15.20.7002.022; Fri, 17 Nov 2023
 07:11:39 +0000
From: Louis Peens <louis.peens@corigine.com>
To: David Miller <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Yinjun Zhang <yinjun.zhang@corigine.com>,
	netdev@vger.kernel.org,
	oss-drivers@corigine.com
Subject: [PATCH net-next 0/2] nfp: add flow-steering support
Date: Fri, 17 Nov 2023 09:11:12 +0200
Message-Id: <20231117071114.10667-1-louis.peens@corigine.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: JNAP275CA0058.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4f::6)
 To BL0PR13MB4403.namprd13.prod.outlook.com (2603:10b6:208:1c4::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR13MB4403:EE_|CH2PR13MB4553:EE_
X-MS-Office365-Filtering-Correlation-Id: 5e6ab267-2681-4fee-377f-08dbe73c7124
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	20N/RDKR8p8Ze/BTtSTebfNaSsKaBDx3/V2KpwtnnoaWWRDUswjj2Vp6Nv7BkzVsOF/nvVgM+GB+SK5wP37Mobi+OrsbrOYKg6IGtg/sIOC4SlV8BpjBMS65KgmtddqmKaB5t4mbfZurnAPas16thEWJXRHdGvlVbhZGDBycxA7jO8loEUsjxSgVX8Bbd6edjSKE4BMiyRlcwl/Ie7YlZCu0Ol7/KCN5/UmsbPUfvsvo3P77x37B3rfohzurbltu6SHSzdvtrEzOoXba6x2Of201FsVi//umy83oooQLh80Roz8H1nVPGN7lOTITMbQkMQ3dBh/MCsjXaO2eLib8GIpn8xnFOifMXyH0EJnDiYSaMX6QtxVilX+RTMiQpdNFCbu4quiD1emKMCVIOzpwJQM5MGH+c97U79cacHGHYEqg1fVJ+6dTt08Mr/1LGDV+m9w7dpKn/qffhIQiJkwGnqVZukuJ9hQ8Lu8U37SVk4aPukdPeZq06AN7EDmzJrWzvjoMyO4iMmrQ+n80jD10koTlOEztmHK5JwM2jbhJ4RR5J3W65imesIfvT8EJ2v+RGr1FR7Xe79L61pgzwm9toWOBogs/x8zUuiAO/nz21RMUS10vQ0nGer5JAonEfDAOSnoDrGBCLyOlbyWmLZDFWjHeVHCaoDyU/J1MQtJlre8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR13MB4403.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39830400003)(366004)(396003)(346002)(136003)(376002)(230922051799003)(451199024)(186009)(1800799009)(64100799003)(66946007)(66476007)(66556008)(110136005)(316002)(2616005)(26005)(107886003)(1076003)(478600001)(38350700005)(6666004)(6506007)(6512007)(6486002)(36756003)(52116002)(38100700002)(5660300002)(44832011)(2906002)(4744005)(41300700001)(8676002)(86362001)(4326008)(8936002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?D64wRUi5Sx6adZNTpIG9q/ZTxP8F1Eeo+/x/ByoIw5dDoxIjsI4dLT+Kq9l3?=
 =?us-ascii?Q?amYHQmNnzcvxcwHy0eYY/lTsLu89K7SOyXd+hqQW85IZXIugbySGc0ci6Syv?=
 =?us-ascii?Q?IDJeHSaDZl6uAeGCDLIzH3dbAbTM3+jM8vmmGD9faRZOPHDnk0Ug8MwWwm/8?=
 =?us-ascii?Q?kkxYPGRhLdQM6vsD6MLQLwRFrrBF85H5409yp+7e2oN1XlAhtcMwh+N5rvBy?=
 =?us-ascii?Q?cfl5uVQGqdq4hGQ9R+9CRdWFT8Vc5l9+SVwvzeQSkjgWt9r71WVi7LEw5+IL?=
 =?us-ascii?Q?LziO+PeKkOVcws/q+dWrhSN93RUZaNhaXUFSVXWsCDBlKl+Gk3na6jVaEOR+?=
 =?us-ascii?Q?xMBLmX9JZnn6XXlbe3SO3jks/NZJ8qayGlIIMJ152c11Bj/Uqz9CIOciC/NK?=
 =?us-ascii?Q?g2IgkEiFncCE202xDvJ7qv/CmhQOoFKl8ESnk5LPv52uW9WoDKQZvOxSB26r?=
 =?us-ascii?Q?m+InOiN8PTRf6KS8gLU/kG0ojpK5b2dyb34OSOFVXLvHRgunCYOSmhBgvgv4?=
 =?us-ascii?Q?BGrkpIv83mrhkfvtPxC/tOzXHWPexhnjEr7EGJVzk7GbmPtvM6ewE3FIg7Xl?=
 =?us-ascii?Q?PpOXiASYIfU3csI7iQs7k250RpHG/5N3uGvN2FZdKfUEP1M1cHGaUP6536q5?=
 =?us-ascii?Q?xvqtvkwKWByC7yCHl8K4t17iIvSsZD0/hlAMk4Q+K+bdfHCbsHUdWDuaOd0M?=
 =?us-ascii?Q?I+y3+WNoAntD91fDlW8NLRsGis0x8w1mRflNa8QyD1pIZ2N+1u979wKsAO98?=
 =?us-ascii?Q?IqPN9P9e31V3FgGgtwwr72vZJMSsOB+KE5/RmibA51bsAYL7RXeRAfKZXQfe?=
 =?us-ascii?Q?8Rike3ofYHIiVVnhxVTbEcpTrnyBV+GUVyXNmmoxLMXkkCDvPaoYanpYXlzq?=
 =?us-ascii?Q?Gjl5qUuGNLPm/vE4P7OOjIFUZuQWjFNTSTDy5+ix+usJbZevNGKTWVGcKBcr?=
 =?us-ascii?Q?5yOWd2PNIs8o8sJ9XInsZ/nSKCl1bW5Db76n0OJioIev2hIg+Ia8dRfHIVOn?=
 =?us-ascii?Q?CaTcuHoAXelgAD7tVcCWLmvdMDDnzgqLIAf87lwo0otmiEFTN3nECy5fzbT1?=
 =?us-ascii?Q?+RNKdAgsyCDR9yneSEMQ7nkM9D9XjfuW1FxV+d8k2KQh4BMOmZr2dWG5p7Br?=
 =?us-ascii?Q?RuVVjJhSO78hkqD3r1+bKlqp8TDbLKFisa2h/fAWjaT9x6WfL/XApBcYokvN?=
 =?us-ascii?Q?PfstpGRFOmn/78ShjMdonyVypWCklJw4pf4z5kKyu4uXMZusOiBs1gXpWOOt?=
 =?us-ascii?Q?olnt3nQlpHOq7gHlAm4JfNciB3hwmGjeGuqcd3pIHMr40b87iiJCWcjJMBBm?=
 =?us-ascii?Q?TjDY1OHcXJWzyiwpDwg9mIyM2XhoF0hcE/T7gC5F28T29MZNNS3CH2nTjdqG?=
 =?us-ascii?Q?sqPpMZ1XBekpIICNYqKX+xsLZuFPhXuEtsY83dxB87JgUMPN0yxqL9TcgfNo?=
 =?us-ascii?Q?7oQ/lAlrP4zhaWxwrZlGJsAWBhWLCN+2fzQc90d4rIbBSvlqw8wFRjbj3vxQ?=
 =?us-ascii?Q?cMid0oXr2wSUmKv1c9SbcfyS20O778W/Q3XvwxNQmFVpykd66UyiVim/e3i6?=
 =?us-ascii?Q?bKPUBSKtKgt0d25+PMx73MpJ5a5OkUbg5oy5ej0cEs803ET2LkCSwBJNqCf7?=
 =?us-ascii?Q?JA=3D=3D?=
X-OriginatorOrg: corigine.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e6ab267-2681-4fee-377f-08dbe73c7124
X-MS-Exchange-CrossTenant-AuthSource: BL0PR13MB4403.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2023 07:11:38.9265
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fe128f2c-073b-4c20-818e-7246a585940c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rpT54WhJo7SNXD3TiFY8h+W/uaJoLLsI0x+6pHlUc1vZ10MlYtulI0eLhS0pd5S8qB64IKT8zFUGSrOOiE/c/HmuqGd3G1m2i8Nx1XPkKCI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR13MB4553

This short series adds flow steering support for the nfp driver.
The first patch adds the part to communicate with ethtool but
stubs out the HW offload parts. The second patch implements the
HW communication and offloads flow steering.

After this series the user can now use 'ethtool -N/-n' to configure
and display rx classification rules.

Yinjun Zhang (2):
  nfp: add ethtool flow steering callbacks
  nfp: offload flow steering to the nfp

 drivers/net/ethernet/netronome/nfp/nfp_net.h  |  36 ++
 .../ethernet/netronome/nfp/nfp_net_common.c   | 183 +++++++++
 .../net/ethernet/netronome/nfp/nfp_net_ctrl.h |  15 +
 .../ethernet/netronome/nfp/nfp_net_ethtool.c  | 369 ++++++++++++++++++
 4 files changed, 603 insertions(+)

-- 
2.34.1


