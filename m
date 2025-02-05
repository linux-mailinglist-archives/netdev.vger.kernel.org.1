Return-Path: <netdev+bounces-162945-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 617B5A28980
	for <lists+netdev@lfdr.de>; Wed,  5 Feb 2025 12:41:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 311A13A4657
	for <lists+netdev@lfdr.de>; Wed,  5 Feb 2025 11:40:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A21F8151988;
	Wed,  5 Feb 2025 11:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="roqeOWOg"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2077.outbound.protection.outlook.com [40.107.244.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F4D022B8A0
	for <netdev@vger.kernel.org>; Wed,  5 Feb 2025 11:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738755528; cv=fail; b=VQ19MmCOaHAFWEDcaiETqgkK+SNuKJs8xlIAqVTHuHLg48Wy0YrvmxUIf79nACh/dypJAxzSr6tzzHMUmqOcQ+4uYGHtSS2fTLDzB4LT+scTFbl+LidN1AYeVNNPUxbLRsdX38qjLUO/WBxtbjFOkBi1aAXDUgHFWRy1P8vwTZU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738755528; c=relaxed/simple;
	bh=ZuPhV9OKbTTuPB6DP8bWx/gudpQE/fNah0kbhhFbnYg=;
	h=References:From:To:CC:Subject:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=X6NGUHzAlzpVu0VqYbjEL0DdF60m93p9NcjgRrRf3/ECypEsVjE4MXlYuSiBuA0420Ro0gJacOf3OWLoAuzRP0dTZMpIDI9usAUMoskvucm7WHyEU6DaUGLJNOrfv54MKYgNLGu5IS2q/Q7Q0urdXyCf95k81j2gJoUut8U6efA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=roqeOWOg; arc=fail smtp.client-ip=40.107.244.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=liWtP9043GnpDIX5GB6mZ9CTiAKNNzy+9ztutwoTX0YM1XHxFA1hClTgcZL8HUa/nDFVSyY8bkkfv9Ay5LT8MR21svmJgnE3k1kMPoUX/BzQF7clwr5F1Z24K2KpCtsGsyvvjJeAbzAv5T+aMYjYrYw4WZRT6lpkoN3XI9KuLHR7gMfAnTnUXicSuJR7Fjdwrff/Zbh9Gi1Q+rF4CZUzIvp7Cdestfon30Aj2ywj5OITTn0UgumnzOY/CUIaxZvJ1Fyk/4Y2jj/QMKb140Nhp/tpYSVGjHVgJINsxe8DW3kWoufevIBiXLt67b2khRvTazP+ithl9ddr9nnLWN1Fng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rwOQ2dtl9X7eJCw3wwOTBceBIwLD0XOL/io9hD01Oak=;
 b=kNxnmilr6pd0jQS5X6HTzZLkQC/AKd1VsdtJdoO5Y5yL15ow/jv11EekC5WCzHRBjslVqVTcaynAIl2DpM5OBqwg3K6zdIkJxdDI8vptkKinh60cTCnOpQ8rDkMxdxeHSGE8gE3HZU8Ni/utcmQCMt84Pg1pEMmgjEDTwzMvp2Fm7GzLB29wc8GKpk1S7NEsQPvnm2uaxMA25A77guHaE/s6oocPUa49lwdkg/ii+PwGjqqj8fs54i2E32hThU14FK0k0TC4yA+sy8nh+MEwPKJwBWzBUQFWG+FhbKuQGXieyv9jD+Fh6k+bBd0lNulexXGoc1H7jUTxxtNpE7OT2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rwOQ2dtl9X7eJCw3wwOTBceBIwLD0XOL/io9hD01Oak=;
 b=roqeOWOgta7ZWem5W//x555W8Y0U0hh2gUbQWFkSuUVSbcqRLVN1/5jm8EJOmOtudSHRDUAIm4ERzpcupLxfse62mT7KLP2EfbwjijPxoLR3kaurH0nIIaw9MplbpRhnKRo5phm6g7RDJNRH0wcPz5NJmf27QtJl466hSGKD9z7kpTsKRx+jXFq81kej90L35RotFujLvtNsQ4DtfE+hJ1Uta78xjC6hw7+4FqVm0YbQuWZNEVqueZmQ+pL6Z0m2Aw+7GW3jwB7DEtHI7NZklz4/VFium9humSdscxkNOAWv3qolc++mG/1EJcECcCAqyJ6UEND4J56xLoJiB0+W+g==
Received: from SJ0PR13CA0202.namprd13.prod.outlook.com (2603:10b6:a03:2c3::27)
 by BL3PR12MB6594.namprd12.prod.outlook.com (2603:10b6:208:38d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.11; Wed, 5 Feb
 2025 11:38:43 +0000
Received: from CO1PEPF000044F5.namprd05.prod.outlook.com
 (2603:10b6:a03:2c3:cafe::4c) by SJ0PR13CA0202.outlook.office365.com
 (2603:10b6:a03:2c3::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.24 via Frontend Transport; Wed,
 5 Feb 2025 11:38:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CO1PEPF000044F5.mail.protection.outlook.com (10.167.241.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8398.14 via Frontend Transport; Wed, 5 Feb 2025 11:38:43 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 5 Feb 2025
 03:38:28 -0800
Received: from fedora (10.126.230.35) by rnnvmail201.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Wed, 5 Feb
 2025 03:38:25 -0800
References: <20250204133957.1140677-1-danieller@nvidia.com>
 <20250204133957.1140677-11-danieller@nvidia.com>
 <20250204183713.5cf64e08@kernel.org>
User-agent: mu4e 1.8.14; emacs 29.4
From: Petr Machata <petrm@nvidia.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: Danielle Ratson <danieller@nvidia.com>, <netdev@vger.kernel.org>,
	<mkubecek@suse.cz>, <matt@traverse.com.au>, <daniel.zahka@gmail.com>,
	<amcohen@nvidia.com>, <nbu-mlxsw@exchange.nvidia.com>
Subject: Re: [PATCH ethtool-next v3 10/16] qsfp: Add JSON output handling to
 --module-info in SFF8636 modules
Date: Wed, 5 Feb 2025 12:32:49 +0100
In-Reply-To: <20250204183713.5cf64e08@kernel.org>
Message-ID: <871pwcoc43.fsf@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F5:EE_|BL3PR12MB6594:EE_
X-MS-Office365-Filtering-Correlation-Id: a9b07bd9-b39d-49e0-5915-08dd45d9a4d7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|36860700013|1800799024|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?OmBDUJLRxzX3d5um+5htNHESJxU8An12zsH8ksuLbIMjcJ6IRh4ySvFnoIxf?=
 =?us-ascii?Q?O77sTdbNd7oxXbvYyFcRch69wZn6nAE3FMcdEjYJO96hgHsgISQTvE6OwakJ?=
 =?us-ascii?Q?jkR7r5KC+NJO07Mg3acjcr1N71hO5VpwAbkZjCK5IL4fShz7cnvYHJK0PEyU?=
 =?us-ascii?Q?ugYPpadl0u6fcXHLSvMJjnE1Z03DVImS6c0cZgqTGmXwyUKebvac0pdHzTIV?=
 =?us-ascii?Q?oX4GBrsWTgxUaC7E6gDJW8HNeri8EfGPre0q/ka+vJ0gv5Wd0zMxHW9QHy+t?=
 =?us-ascii?Q?4k4jmmKnXTNPEkaiLmVKU226cSKb/pE5lHzbQIhnwRFYBCdcEJtIa3KqR9ND?=
 =?us-ascii?Q?qZ1E2VdYUhIEd1lR36pAAH90CWTMpzD+X2GkA6etgPfosejaNZY6e6sZ66Mf?=
 =?us-ascii?Q?TiGAYvfGgILU5eSxXVzrb7uL4ZT9DVLN6M6gkCksUa1kmtPuRUaSQBbUZCqG?=
 =?us-ascii?Q?TfRVFzGsyjjjHYnQmYSkKkvBS9AhHkLC+q8MvBmpRejy2r+7R4yQEuCYwTbp?=
 =?us-ascii?Q?LdOKJ50eBn8jXEgp4HejpazKCV2JCcrh//OqHm34xakmn8glrsDA1Qo2tEmU?=
 =?us-ascii?Q?pZWg2kCrqqAgYy5/J/SiNWbQH83H9v3BG95sncfrb7Squ0vPZxcObBX4S3iB?=
 =?us-ascii?Q?5qgfMJ7SjuGvsH8MLHrfrwiDy6GBNQetrASXxWcFva3uvgP9Xu+YTWqE/w6P?=
 =?us-ascii?Q?cT5sFcRo7AhfeWE44kzG9D3QsEX3IOUdQ1eVBRsI0pq2pE2reT0m56a7pbv6?=
 =?us-ascii?Q?BrnwBBWK03MPOvIDq45agsnKgr2vgUb9iRwwemBHEgvKQ3HPZlAtDFM47dlJ?=
 =?us-ascii?Q?EnMLrfZRNgWhowWBCQqCLJibsiffjmAoPBpB/RotAlt6c8Bp9qOF6CW6Kp4y?=
 =?us-ascii?Q?Tmk6LKWVwQb2X2DNpHBIzYuepcBz8nZU2oSue8iJT/gA+e0PCI44OSgS7X6g?=
 =?us-ascii?Q?qM56JUxWOgmEfdoiCzVbqOkdOh/8yPAkphBy6VTT4QxLBaws75jL2C4YIOaU?=
 =?us-ascii?Q?ErJD4m19eZGH6TTuxWt3T+yU98sD6M8qtE9OgNXkcWNuQ94pn/CPsxATriSu?=
 =?us-ascii?Q?/fTYtdrbNuH19wdP2Mw6shMdCir+759gnpbJ6xpAr0YdyR7yyYg4Auov3tl+?=
 =?us-ascii?Q?Di4IjU4lD+9UUDz+We9MXvgu1wyljncU8GZe/RBiZEqFTnw/gMvbOVDk9sAW?=
 =?us-ascii?Q?T9QYSeyMqeXJ/14oZL7zpqHMN/H/Volw5TfWTtzxvOAsXurJwRP85zGlJH3H?=
 =?us-ascii?Q?43P9btKpFxt9ApQSVLVFMnAdkyKmlJuiePFOL6je+uLlYMOjW78VR+zyB/5E?=
 =?us-ascii?Q?3DHU72mWSIh4U7EEBzSHNoRS+AtvkmI5WAZV/w9Nh1H43933L29kLwuWAXnt?=
 =?us-ascii?Q?bARGR4858BN+dJwGz0/GdA/BYpIRmXQf2Khh28rqg8N3oIYgMSv0ClPyFO1n?=
 =?us-ascii?Q?gXY8n1vCbxg3FYzsM9DictHuA6bjV50uUpSJSfP/56YsFGrJkJX3+JBlJe+U?=
 =?us-ascii?Q?IYDYvKfRxZiCxVU=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2025 11:38:43.0712
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a9b07bd9-b39d-49e0-5915-08dd45d9a4d7
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000044F5.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6594


Jakub Kicinski <kuba@kernel.org> writes:

> I think the description fields need to either be concatenated, or an
> array.

Yep.

https://www.rfc-editor.org/rfc/rfc8259#section-4 :

   The names within an object SHOULD be unique.

   An object whose names are all unique is interoperable in the sense
   that all software implementations receiving that object will agree on
   the name-value mappings.  When the names within an object are not
   unique, the behavior of software that receives such an object is
   unpredictable.  Many implementations report the last name/value pair
   only.  Other implementations report an error or fail to parse the
   object, and some implementations report all of the name/value pairs,
   including duplicates.

