Return-Path: <netdev+bounces-197656-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 57D10AD9864
	for <lists+netdev@lfdr.de>; Sat, 14 Jun 2025 00:58:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B00033BE2B9
	for <lists+netdev@lfdr.de>; Fri, 13 Jun 2025 22:58:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C50A28D8E6;
	Fri, 13 Jun 2025 22:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="w5v2gWlS"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2085.outbound.protection.outlook.com [40.107.244.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F2F02E11D4;
	Fri, 13 Jun 2025 22:58:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749855533; cv=fail; b=CGQIcgtQFk1WlN6Y0F/hF79N2LBaVoK1lrpuRqrod4q0Eom0yO/vJERoig5CENDxnZRATSwrRFkVP6+FhiIz/B+H9ejvEMvzYdJmeBMHjwyejXFlC8EQ5mIMOoCC38XmnfwxOKC/mUklsfNexpJjICOS/XC2qp3A1KoO+cSgzUs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749855533; c=relaxed/simple;
	bh=EgkLc3JJRA9TNz8yEXFR/eaveX3M7bmYSFxKjFhQiw8=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=rltO4OYtdMTbVq9aWSc3Ztzs9V9Jz6eVmY5VFcl0FQQNZNfrsbO0c9o3J07l2GcFGlqogFNW3xORXhddryfy7WjGqXgSBD0OrFbIMVRifxv68ocpRxCfTvkeV8PXxEeUM6/8FIGPIjNkneuTvZvJYYb/kjpf9qP8/6JLwLVw2lM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=w5v2gWlS; arc=fail smtp.client-ip=40.107.244.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GElzcAS4iNaHm/tgxh8mOH5RW+I7WK/mKSx/chUD2CDgXjaFqOtH8of5JoT/GpEmk8g5Nas0u+scn3q6rhye5vilXEaouTCHgQ+XCOTU5V6N3gOW3iiy3uwTE9/gww6AlMxuMUbgaxcrsUm87dHwVP+eP1acxiNgHaz9hAmBDSn/LhPiYNGIOr7gEzfg/DoD3WRWrV/hsmheKy9s152iUwPuwHJaEOLtVEY78RvrOiHSE+9YLmmJCiMOTD7KvmaQQ76ChytZAPXPtMrcig/E1S3HrmGW0tWVYa8Bh4FTrYLv4MTMQSRE75sG8U55hozCjrimDTwZdm0Ld5cGK0P/SA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LGnjEMJKqJ6w6CtV+7n15G+BPlwsZPuLBFNf4R+fmZ0=;
 b=QsKL0bg0Pz8Zav06582vJBXaGC41tadld3UrT271EfmEXMVm9iPFvefTJvUbO8NTuTywH6f1y3NxWKqmInjQ7dC+FiXxXicYMuR+sjvjGNaRl0TiTip9QmtMUUSPVpGPmmKBfBqWV3ebQmHFK82+kAcOeI3/XGPW4kbqtiUNWpHB8kmBGQAv6LtXey3aSM4qD7pFbpkyn2YHslTGvn/jqZuhbdMrPIuIrp26NT7kLWIFbS/eOjl8D8udbEuY4K1I1I8G+cQXu+M8aec3UyM8euYOo6Pp3dGvQ4RpgO8/GQdmNuS6iRVpn8Duw8NMHBS1bEAXH4QOjD4sYangRlJh5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LGnjEMJKqJ6w6CtV+7n15G+BPlwsZPuLBFNf4R+fmZ0=;
 b=w5v2gWlS/CDOdVuslaZh7KU0YkQByl6n6d91NNSpXufwMaWpT6B9QMeSXdDQTKJ7zAlLzoTZIcIzlZVeYd5LCB0aQPuO838st78ysQfhAUgrvgl6T/KlaFShs9zFh15Qh3mkAas2bmsgMEG3MB9JIWdNJtv8lN6jxo26SEuJqzO+kMC4hC76zlFjoPq+/rOn/f+RgKS/oOSFIyN5+iQhKDGvTn/L+93DxupmBTAj//5o2UfjDgvtHp0osoYP6AKJQI/dYXKtbOdnKZ0+cBe+6uYAzkMt6jYKdNfC3zZWmvQ2yoIIiCQCqUWCGYAg8+5nq6b6bR+UGDbUXhPWmq6dYw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from BYAPR03MB3461.namprd03.prod.outlook.com (2603:10b6:a02:b4::23)
 by DM4PR03MB6976.namprd03.prod.outlook.com (2603:10b6:8:43::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8835.26; Fri, 13 Jun 2025 22:58:48 +0000
Received: from BYAPR03MB3461.namprd03.prod.outlook.com
 ([fe80::706b:dd15:bc81:313c]) by BYAPR03MB3461.namprd03.prod.outlook.com
 ([fe80::706b:dd15:bc81:313c%5]) with mapi id 15.20.8835.018; Fri, 13 Jun 2025
 22:58:47 +0000
From: Matthew Gerlach <matthew.gerlach@altera.com>
To: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	maxime.chevallier@bootlin.com,
	mcoquelin.stm32@gmail.com,
	alexandre.torgue@foss.st.com,
	richardcochran@gmail.com,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org
Cc: Matthew Gerlach <matthew.gerlach@altera.com>,
	Mun Yew Tham <mun.yew.tham@altera.com>
Subject: [PATCH v6] dt-bindings: net: Convert socfpga-dwmac bindings to yaml
Date: Fri, 13 Jun 2025 15:58:44 -0700
Message-Id: <20250613225844.43148-1-matthew.gerlach@altera.com>
X-Mailer: git-send-email 2.35.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY1P220CA0004.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:59d::15) To BYAPR03MB3461.namprd03.prod.outlook.com
 (2603:10b6:a02:b4::23)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR03MB3461:EE_|DM4PR03MB6976:EE_
X-MS-Office365-Filtering-Correlation-Id: 3511af49-cd25-4428-7f4d-08ddaacdda84
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|921020|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?3N34t0jzDk//PiYGCo9pccqvyQKXvonnoX4qt8ERfda64OTBAtTnhKNKdHWX?=
 =?us-ascii?Q?KO8Mcvu9pAhCZGhHzO4vHbOfbP77xROz5J9SSRysuXZ111pTPBPIxGNXlmM7?=
 =?us-ascii?Q?gFPjHwewLkF8YGsXnFtfYTJAN3NYNCnmgzje5Bx9FTtWJjxD1RaJ8nRzSU9o?=
 =?us-ascii?Q?zOd8fixBRSEyctzwftpOc0e4CFmT9Lf/VLqZGJbtalD/FOkp6hYzg4c7Oa9s?=
 =?us-ascii?Q?9aKVr2N4mjRQklhrAcBcwL2ANCcCRlZKFkhTzbg3ez3NteGBkE8EFBfaPYcF?=
 =?us-ascii?Q?XuVweb2D3cDKP5z4N6a173Aaw7/RKRVeWxwcpkGn2r0crrdYagNyCpSqZbTF?=
 =?us-ascii?Q?+zWdKVqD2dF4n1+FJLl0vG57++5DgjTUZevaKwgvBmeVLiIHTrEMfZz2s/Fv?=
 =?us-ascii?Q?ytakPdJeYEUDP/DyQ0Aiy8CaWC3W8Bc0qtp2tSxW7nrfmQIZC7NoBOrnvk9P?=
 =?us-ascii?Q?2rmoADJW140lqejzMNoU6NCJqXDIZqyACz0NnUxMgFxiOCPpSIHRwvk+8acz?=
 =?us-ascii?Q?bCKq/VoW5gFQtJ0z9qH/BFA/DEpP59hhnhRdWmTxtGgpgZ5OIEiroH2lKHum?=
 =?us-ascii?Q?3ZJ18xMlSnQKOM3yn2k+rJ2D4pm7CSPCobNOzyxAvlG6ILYqMVm79BanD7dN?=
 =?us-ascii?Q?XLkRFVxg2t0yjbhjpr67/aH229FDcvYcQ0HG0kN/IVDx9EaJbVeG5CfQ9/6S?=
 =?us-ascii?Q?89gAIvHvrilMcfSQNB794BYuzQHH2V5KlPijSRy+rI9sMQMCFeM5bRejPaY3?=
 =?us-ascii?Q?2Nngh+fQ/Hh9kEqMJrs+RqycRYVBfRI41bkwbIgZi3/8X6ijJUahBjpuPOXx?=
 =?us-ascii?Q?SmwD4g1F0roZUP+f5XwLOs/pmtNmLLeUhLPg4lBcmNbJoP0PCMe3R8VLQYBZ?=
 =?us-ascii?Q?8wuN/PZwO4PoOUuLvM9cqsvehMta+YVKgPh6g4sJ3FOmc1+n/ZL1YgnxNKtG?=
 =?us-ascii?Q?yz9gD3vxknH5WG3zyOjQpJjy5D2JOZUXVqjyzFhYg92Vt56gHoVku692HjMO?=
 =?us-ascii?Q?Z6QK64Z/ifLubowo2/qSWnO5GGqVQ6NMmrCakX+vtI//iOKHA3Z2Kn7EuM1A?=
 =?us-ascii?Q?ZhALO7d7WFQ/XVH5+K5CMjZ+lSyO+YksERLOZzfXtl6kEZXeS2gEBggpI55q?=
 =?us-ascii?Q?Q2heu6u4q4jtq0K+EmVIHWKCFrVj1nj/Q2CAnztDG5HeMORO+OgWZMPYeVp5?=
 =?us-ascii?Q?5JGjQA6VrBwdgQ3XExnsYBvq7IqbyJgIcyD6bmuOD66x7qFF6NAf4rH5BXQO?=
 =?us-ascii?Q?AJ7o+h13YEatgdaPyCSxU0afF1UZHG4/Pm+G7GPziDS8Fu03qQCYgHwzU7sC?=
 =?us-ascii?Q?vxXNgb5+gIhZ5Qhhj11n/Q25Xe3mcT7iWG0wiRlsAcdD0JJpJr78Acf1sWzS?=
 =?us-ascii?Q?KlVkBmwL8YxS8c6qyJrd90+ztEEyLXFlbEUioqOGPkkbzvmsDw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR03MB3461.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(921020)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?+awCzfuH68NEYj5Ad+EteLpR+gkhRooLHCn4Vz9mY1EMB5PfsncBjLHPMsTP?=
 =?us-ascii?Q?9YoKoWwA1y6S5QG2CXfWa6etb5aOysKhRsL7rgJ8Tdn/C10jxNy6E3ZphPHo?=
 =?us-ascii?Q?84fYs4JHqvWBtl+dX7Vh6AA6yv8Fx69KinFz1d1z49evlwBVBXP6g25S6Zor?=
 =?us-ascii?Q?4wM07Awmg3GOiBaYPsCUt+vTSfoa9aq0xhNOH9mq7XrNYhMGXv3Jqa+Cbjmm?=
 =?us-ascii?Q?FEvPUQpOfM4qx4PnbJsVg4nJyinxvC+ufRtBrwxk71seQYWtNqAOdwwEvkxY?=
 =?us-ascii?Q?aLN3bH/z2Bw+P5YDm3L0L0F5a7/8uPiAFSq+ABFMbWxe+62S9HJzR95L1K3Y?=
 =?us-ascii?Q?2Z1SAZzK5+uL8pvdHuVut4u0V3Gc64JJWKThAVyZfRtqLHt0+hiXcTfck5KY?=
 =?us-ascii?Q?hNEwPZsSsKixWP2zsd9cBqRtbne2hKx7wh3wzgyJtC0XVUeFz7WcSLWz3/j7?=
 =?us-ascii?Q?u+k5X06ZTGV9esCDM6ctsLhilueC1qk90QZRJmIHyjDYkWtsjLPb33OqyRDT?=
 =?us-ascii?Q?LzQ+AsAMOm2N0UMU8bp+kgkLbWjDtloG8sHl6PCbbX3EmOagKo/vjC2GqwZe?=
 =?us-ascii?Q?i16YogSC9LRRVAbVP1IWF7xsXdo/qnww41OjxL0o2kCbUWvJwaB5knXYzYpY?=
 =?us-ascii?Q?Pe6q3d1t/JchnSo+7556WaMqJQv047ugSGk9bzGkxj/rJOBTzPs5+dUhpO/P?=
 =?us-ascii?Q?HsORqoqRsdMxxv/7iJPZ1vf89tST5h7yCFGC6fQHO6li/MPgYLMr92m+rLJG?=
 =?us-ascii?Q?4QSWCaxGsOoud0GAvSto+X2UESKVy+RgGMP7kZhjU1j/xN+KAVU175vt1Ngq?=
 =?us-ascii?Q?c9CPUemSpxIma6Wycln7s6r/hNX2LemUntqaYKyG2X+Pv38dK+Su9Fsd5qkM?=
 =?us-ascii?Q?X4t1XV6SpgNC7f/T32mcObIAWTzTDGS5zTPByvoLTcCQIJU8NsvAlmp2uUz0?=
 =?us-ascii?Q?xZUi6Giy+G2rJeyK4aIfUVwIMN+15xFtHa2sQL5QTvPnxj5t0LonwXKzTDni?=
 =?us-ascii?Q?vThNFVyCq7ypdkZwdGc8jANtXthWxQ5lP0I9zG4uk638xQJjBlLi4/xD0Y1y?=
 =?us-ascii?Q?MNM7Y5acVYG1fzudzRc2M8Dn+O9SQ6Y+5OYYWfoPNLjNiIwlIc8xZdxmrv7S?=
 =?us-ascii?Q?a0nYHi1z9iYN7eOAoCc+GblVkJy6ygL/gd1Lv+j/hxI3ZQWw9aq2u3K0kSsw?=
 =?us-ascii?Q?AYQG80KZQVbxNMERZJMY2TQny9EPS3CJP8PGH+lKX5TzBbGAszKdfy7dIdXd?=
 =?us-ascii?Q?TRUaJ4I0BT/RBMshUetpLSpqfkwAVjkWBFuw2x04EyM2bOtv0BcqX8nPfNNK?=
 =?us-ascii?Q?uNRuv+UXuCLI4wa+Z0lNPqIHNizkPOIhrSnr/0JbZE6l7l8Wp2rDPieRTJIb?=
 =?us-ascii?Q?72Nm92wIV0aW1qN7PGQpHxuBtHB4XAQW9aqhunstPboJl3iFy1v6ISjMO+CL?=
 =?us-ascii?Q?ZsCTxw/iiFRKlS4hClxlCR2scWLVZwLJv+1cmUjpJXctHFXOXd+ZifioWV0k?=
 =?us-ascii?Q?DTnhrPiY5BFI6J6A3F5e83iRo8UT0IW0FWHy2slRkKT3M+ZcgCvESLx3ubll?=
 =?us-ascii?Q?z24dSmYOWJltEXHT9OsO81Ye3y9oGqvrGww2g7bk04GlTRLu+fRX2Ww57mDZ?=
 =?us-ascii?Q?Pw=3D=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3511af49-cd25-4428-7f4d-08ddaacdda84
X-MS-Exchange-CrossTenant-AuthSource: BYAPR03MB3461.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2025 22:58:47.1473
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AfcejGI0Firr1NsXKoMooeuqe5jrb17QjXuDE3uHnDsV53vslOLkGDEHe/URNtWBJUS7n3f0A4dUdNYht0pj0icOLuvzQQHTUM5WL21Csak=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR03MB6976

Convert the bindings for socfpga-dwmac to yaml. Since the original
text contained descriptions for two separate nodes, two separate
yaml files were created.

Signed-off-by: Mun Yew Tham <mun.yew.tham@altera.com>
Signed-off-by: Matthew Gerlach <matthew.gerlach@altera.com>
Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
---
v6:
 - Fix reference to altr,gmii-to-sgmii-2.0.yaml in MAINTAINERS.
 - Add Reviewed-by:

v5:
 - Fix dt_binding_check error: comptabile.
 - Rename altr,gmii-to-sgmii.yaml to altr,gmii-to-sgmii-2.0.yaml

v4:
 - Change filename from socfpga,dwmac.yaml to altr,socfpga-stmmac.yaml.
 - Updated compatible in select properties and main properties.
 - Fixed clocks so stmmaceth clock is required.
 - Added binding for altr,gmii-to-sgmii.
 - Update MAINTAINERS.

v3:
 - Add missing supported phy-modes.

v2:
 - Add compatible to required.
 - Add descriptions for clocks.
 - Add clock-names.
 - Clean up items: in altr,sysmgr-syscon.
 - Change "additionalProperties: true" to "unevaluatedProperties: false".
 - Add properties needed for "unevaluatedProperties: false".
 - Fix indentation in examples.
 - Drop gmac0: label in examples.
 - Exclude support for Arria10 that is not validating.
---
 .../bindings/net/altr,gmii-to-sgmii-2.0.yaml  |  49 ++++++
 .../bindings/net/altr,socfpga-stmmac.yaml     | 162 ++++++++++++++++++
 .../devicetree/bindings/net/socfpga-dwmac.txt |  57 ------
 MAINTAINERS                                   |   7 +-
 4 files changed, 217 insertions(+), 58 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/net/altr,gmii-to-sgmii-2.0.yaml
 create mode 100644 Documentation/devicetree/bindings/net/altr,socfpga-stmmac.yaml
 delete mode 100644 Documentation/devicetree/bindings/net/socfpga-dwmac.txt

diff --git a/Documentation/devicetree/bindings/net/altr,gmii-to-sgmii-2.0.yaml b/Documentation/devicetree/bindings/net/altr,gmii-to-sgmii-2.0.yaml
new file mode 100644
index 000000000000..aafb6447b6c2
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/altr,gmii-to-sgmii-2.0.yaml
@@ -0,0 +1,49 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+# Copyright (C) 2025 Altera Corporation
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/net/altr,gmii-to-sgmii-2.0.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Altera GMII to SGMII Converter
+
+maintainers:
+  - Matthew Gerlach <matthew.gerlach@altera.com>
+
+description:
+  This binding describes the Altera GMII to SGMII converter.
+
+properties:
+  compatible:
+    const: altr,gmii-to-sgmii-2.0
+
+  reg:
+    items:
+      - description: Registers for the emac splitter IP
+      - description: Registers for the GMII to SGMII converter.
+      - description: Registers for TSE control.
+
+  reg-names:
+    items:
+      - const: hps_emac_interface_splitter_avalon_slave
+      - const: gmii_to_sgmii_adapter_avalon_slave
+      - const: eth_tse_control_port
+
+required:
+  - compatible
+  - reg
+  - reg-names
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    phy@ff000240 {
+        compatible = "altr,gmii-to-sgmii-2.0";
+        reg = <0xff000240 0x00000008>,
+              <0xff000200 0x00000040>,
+              <0xff000250 0x00000008>;
+        reg-names = "hps_emac_interface_splitter_avalon_slave",
+                    "gmii_to_sgmii_adapter_avalon_slave",
+                    "eth_tse_control_port";
+    };
diff --git a/Documentation/devicetree/bindings/net/altr,socfpga-stmmac.yaml b/Documentation/devicetree/bindings/net/altr,socfpga-stmmac.yaml
new file mode 100644
index 000000000000..ccbbdb870755
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/altr,socfpga-stmmac.yaml
@@ -0,0 +1,162 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/net/altr,socfpga-stmmac.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Altera SOCFPGA SoC DWMAC controller
+
+maintainers:
+  - Matthew Gerlach <matthew.gerlach@altera.com>
+
+description:
+  This binding describes the Altera SOCFPGA SoC implementation of the
+  Synopsys DWMAC for the Cyclone5, Arria5, Stratix10, and Agilex7 families
+  of chips.
+  # TODO: Determine how to handle the Arria10 reset-name, stmmaceth-ocp, that
+  # does not validate against net/snps,dwmac.yaml.
+
+select:
+  properties:
+    compatible:
+      contains:
+        enum:
+          - altr,socfpga-stmmac
+          - altr,socfpga-stmmac-a10-s10
+
+  required:
+    - compatible
+
+properties:
+  compatible:
+    oneOf:
+      - items:
+          - const: altr,socfpga-stmmac
+          - const: snps,dwmac-3.70a
+          - const: snps,dwmac
+      - items:
+          - const: altr,socfpga-stmmac-a10-s10
+          - const: snps,dwmac-3.74a
+          - const: snps,dwmac
+
+  clocks:
+    minItems: 1
+    items:
+      - description: GMAC main clock
+      - description:
+          PTP reference clock. This clock is used for programming the
+          Timestamp Addend Register. If not passed then the system
+          clock will be used and this is fine on some platforms.
+
+  clock-names:
+    minItems: 1
+    items:
+      - const: stmmaceth
+      - const: ptp_ref
+
+  iommus:
+    maxItems: 1
+
+  phy-mode:
+    enum:
+      - gmii
+      - mii
+      - rgmii
+      - rgmii-id
+      - rgmii-rxid
+      - rgmii-txid
+      - sgmii
+      - 1000base-x
+
+  rxc-skew-ps:
+    description: Skew control of RXC pad
+
+  rxd0-skew-ps:
+    description: Skew control of RX data 0 pad
+
+  rxd1-skew-ps:
+    description: Skew control of RX data 1 pad
+
+  rxd2-skew-ps:
+    description: Skew control of RX data 2 pad
+
+  rxd3-skew-ps:
+    description: Skew control of RX data 3 pad
+
+  rxdv-skew-ps:
+    description: Skew control of RX CTL pad
+
+  txc-skew-ps:
+    description: Skew control of TXC pad
+
+  txen-skew-ps:
+    description: Skew control of TXC pad
+
+  altr,emac-splitter:
+    $ref: /schemas/types.yaml#/definitions/phandle
+    description:
+      Should be the phandle to the emac splitter soft IP node if DWMAC
+      controller is connected an emac splitter.
+
+  altr,f2h_ptp_ref_clk:
+    $ref: /schemas/types.yaml#/definitions/phandle
+    description:
+      Phandle to Precision Time Protocol reference clock. This clock is
+      common to gmac instances and defaults to osc1.
+
+  altr,gmii-to-sgmii-converter:
+    $ref: /schemas/types.yaml#/definitions/phandle
+    description:
+      Should be the phandle to the gmii to sgmii converter soft IP.
+
+  altr,sysmgr-syscon:
+    $ref: /schemas/types.yaml#/definitions/phandle-array
+    description:
+      Should be the phandle to the system manager node that encompass
+      the glue register, the register offset, and the register shift.
+      On Cyclone5/Arria5, the register shift represents the PHY mode
+      bits, while on the Arria10/Stratix10/Agilex platforms, the
+      register shift represents bit for each emac to enable/disable
+      signals from the FPGA fabric to the EMAC modules.
+    items:
+      - items:
+          - description: phandle to the system manager node
+          - description: offset of the control register
+          - description: shift within the control register
+
+patternProperties:
+  "^mdio[0-9]$":
+    type: object
+
+required:
+  - compatible
+  - clocks
+  - clock-names
+  - altr,sysmgr-syscon
+
+allOf:
+  - $ref: snps,dwmac.yaml#
+
+unevaluatedProperties: false
+
+examples:
+
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/interrupt-controller/irq.h>
+    soc {
+        #address-cells = <1>;
+        #size-cells = <1>;
+        ethernet@ff700000 {
+            compatible = "altr,socfpga-stmmac", "snps,dwmac-3.70a",
+            "snps,dwmac";
+            altr,sysmgr-syscon = <&sysmgr 0x60 0>;
+            reg = <0xff700000 0x2000>;
+            interrupts = <GIC_SPI 116 IRQ_TYPE_LEVEL_HIGH>;
+            interrupt-names = "macirq";
+            mac-address = [00 00 00 00 00 00]; /* Filled in by U-Boot */
+            clocks = <&emac_0_clk>;
+            clock-names = "stmmaceth";
+            phy-mode = "sgmii";
+        };
+    };
diff --git a/Documentation/devicetree/bindings/net/socfpga-dwmac.txt b/Documentation/devicetree/bindings/net/socfpga-dwmac.txt
deleted file mode 100644
index 612a8e8abc88..000000000000
--- a/Documentation/devicetree/bindings/net/socfpga-dwmac.txt
+++ /dev/null
@@ -1,57 +0,0 @@
-Altera SOCFPGA SoC DWMAC controller
-
-This is a variant of the dwmac/stmmac driver an inherits all descriptions
-present in Documentation/devicetree/bindings/net/stmmac.txt.
-
-The device node has additional properties:
-
-Required properties:
- - compatible	: For Cyclone5/Arria5 SoCs it should contain
-		  "altr,socfpga-stmmac". For Arria10/Agilex/Stratix10 SoCs
-		  "altr,socfpga-stmmac-a10-s10".
-		  Along with "snps,dwmac" and any applicable more detailed
-		  designware version numbers documented in stmmac.txt
- - altr,sysmgr-syscon : Should be the phandle to the system manager node that
-   encompasses the glue register, the register offset, and the register shift.
-   On Cyclone5/Arria5, the register shift represents the PHY mode bits, while
-   on the Arria10/Stratix10/Agilex platforms, the register shift represents
-   bit for each emac to enable/disable signals from the FPGA fabric to the
-   EMAC modules.
- - altr,f2h_ptp_ref_clk use f2h_ptp_ref_clk instead of default eosc1 clock
-   for ptp ref clk. This affects all emacs as the clock is common.
-
-Optional properties:
-altr,emac-splitter: Should be the phandle to the emac splitter soft IP node if
-		DWMAC controller is connected emac splitter.
-phy-mode: The phy mode the ethernet operates in
-altr,sgmii-to-sgmii-converter: phandle to the TSE SGMII converter
-
-This device node has additional phandle dependency, the sgmii converter:
-
-Required properties:
- - compatible	: Should be altr,gmii-to-sgmii-2.0
- - reg-names	: Should be "eth_tse_control_port"
-
-Example:
-
-gmii_to_sgmii_converter: phy@100000240 {
-	compatible = "altr,gmii-to-sgmii-2.0";
-	reg = <0x00000001 0x00000240 0x00000008>,
-		<0x00000001 0x00000200 0x00000040>;
-	reg-names = "eth_tse_control_port";
-	clocks = <&sgmii_1_clk_0 &emac1 1 &sgmii_clk_125 &sgmii_clk_125>;
-	clock-names = "tse_pcs_ref_clk_clock_connection", "tse_rx_cdr_refclk";
-};
-
-gmac0: ethernet@ff700000 {
-	compatible = "altr,socfpga-stmmac", "snps,dwmac-3.70a", "snps,dwmac";
-	altr,sysmgr-syscon = <&sysmgr 0x60 0>;
-	reg = <0xff700000 0x2000>;
-	interrupts = <0 115 4>;
-	interrupt-names = "macirq";
-	mac-address = [00 00 00 00 00 00];/* Filled in by U-Boot */
-	clocks = <&emac_0_clk>;
-	clock-names = "stmmaceth";
-	phy-mode = "sgmii";
-	altr,gmii-to-sgmii-converter = <&gmii_to_sgmii_converter>;
-};
diff --git a/MAINTAINERS b/MAINTAINERS
index c2b570ed5f2f..d308789d9877 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3262,10 +3262,15 @@ M:	Dinh Nguyen <dinguyen@kernel.org>
 S:	Maintained
 F:	drivers/clk/socfpga/
 
+ARM/SOCFPGA DWMAC GLUE LAYER BINDINGS
+M:	Matthew Gerlach <matthew.gerlach@altera.com>
+S:	Maintained
+F:	Documentation/devicetree/bindings/net/altr,gmii-to-sgmii-2.0.yaml
+F:	Documentation/devicetree/bindings/net/altr,socfpga-stmmac.yaml
+
 ARM/SOCFPGA DWMAC GLUE LAYER
 M:	Maxime Chevallier <maxime.chevallier@bootlin.com>
 S:	Maintained
-F:	Documentation/devicetree/bindings/net/socfpga-dwmac.txt
 F:	drivers/net/ethernet/stmicro/stmmac/dwmac-socfpga.c
 
 ARM/SOCFPGA EDAC BINDINGS
-- 
2.35.3


