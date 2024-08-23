Return-Path: <netdev+bounces-121352-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C37E795CD93
	for <lists+netdev@lfdr.de>; Fri, 23 Aug 2024 15:17:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CF3191C2031F
	for <lists+netdev@lfdr.de>; Fri, 23 Aug 2024 13:17:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEEB1186600;
	Fri, 23 Aug 2024 13:17:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="cqgNUvtJ"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2087.outbound.protection.outlook.com [40.107.220.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CC9918628F
	for <netdev@vger.kernel.org>; Fri, 23 Aug 2024 13:16:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724419021; cv=fail; b=IdcE5zU1WG9o3joZ+SaAemk37l14dgWepTjqZLviztU5ocAlJXn8wl/muSau0mDlYeNgWyuwhV7gf25NMON3wmoSjaVEWwRmEa6zj16Wo1V9NVLwlHjQAjdQ0XS2vYm3AqbkwqHDLaT6yKT75XS79jOPlKUt0no6j4ntzklTKg8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724419021; c=relaxed/simple;
	bh=VfejOjeaCMk+UQcjgm1P7GYkCnk10S/eI9+igEzxOTk=;
	h=References:From:To:CC:Subject:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=ZIJqOFMYCv1IbA03H6m8HihvfHEE5ZBAMGECsf8vPkWw90IYVaqa8PgTBV5PFp9f+5MbsLwkRpLqjDZJglUtdAm6DC9Uz2tXjhMLhm6UoLtia6NDodPRbrNKPgpveZ59Tbl4kDQ4JUPE7siyP8dJrxu6dMuQNTSQGg9Yun9V8h0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=cqgNUvtJ; arc=fail smtp.client-ip=40.107.220.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kJxK1MwuQuiV5AJkHt2Yb3ShC8gudO2sV4BReks4RCPCPq0/CMrtpYun7V3vw6fECYf+8/pYx2JnpUIv2DIHrEI9NNlO6BdlcKpxa/iv/R3EPHg9yrD+RgFHyCT1CThZKbLSacw/sx5i5V7XwGAbN3KGecXoAWlG8x7PM9L4wewNCKlu1T/Zjm+pBCltUt7DtqAbOEXneGSRSLDAgAZKHNedM7tS6ZjrNB4rLew1cXS2qmtKH1FQ9vYyr21VRedY5NfKOSh9zeLs93RxCqWm7QZhh0qGfmkcavrlrete5/vsBPopfcdxCah1q8/x1hnxbYOT6b4kYH3zqH0p2cybsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VfejOjeaCMk+UQcjgm1P7GYkCnk10S/eI9+igEzxOTk=;
 b=QMMb2cVTVDe3mmQJvESgXoN2x8J81rqltf3OEYpoSe0vyKDlbs3rR1rPwWFQJQGBa3JsLruQ/q0oihmLDIhFLqmM9zczy5I46MfF1pYylrgIWCfSQ0Kl8oaFDcH5IRjzsRCuada/DFVUt8ZbFQGGmYfigY9Kg6RVyDU3+CuS2sV7fVmy53lQ6OMXXmvbb7DuOJHB+j7TDzrlFlOKJZVHsWpuv9t2NW8pJv0HPKV7gqgNfsEUdUEa3zjvu1FMjyrQw44jok+8SHBmNE+rBTQWKVNiGNrFmzekXpC6uluRGOy+r1be8Cs81XuYs6WEMzwIGykFs4JTSmd06hBeL7ZpCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VfejOjeaCMk+UQcjgm1P7GYkCnk10S/eI9+igEzxOTk=;
 b=cqgNUvtJcr2Yksn6q9OkJFoiljAdyHNQUduu3PPCH/mQ5XUwcGuaYbxQZ75aPpCVBRvJcaYNwoDdUEx1uUMNMZRj21oICn//gznq2QUvtEgaxwU2aCPRRdmK5LaVLBmUvI42PCd2y9kM1LioJoIW2lgbrTEbkZcY++cKH+G4kb+d5H549ob/CRrupvpaskFLhyjzEGr3GEtjuRBPIqj6wrFqzGtouTNqtukp0oLUd19Wydlh2a7u3VFTWjM/Wbuh3hP/K66WCqUkyThxZTJqpOQqRj6dpO9NWowYnq5k+Q5Wy5bKlnev5iKsGwHkXfw5z1tJ81c9dr+daeZiWU+QQQ==
Received: from MN2PR05CA0049.namprd05.prod.outlook.com (2603:10b6:208:236::18)
 by IA1PR12MB8262.namprd12.prod.outlook.com (2603:10b6:208:3f6::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.19; Fri, 23 Aug
 2024 13:16:53 +0000
Received: from BL02EPF0001A108.namprd05.prod.outlook.com
 (2603:10b6:208:236:cafe::5d) by MN2PR05CA0049.outlook.office365.com
 (2603:10b6:208:236::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.19 via Frontend
 Transport; Fri, 23 Aug 2024 13:16:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL02EPF0001A108.mail.protection.outlook.com (10.167.241.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7897.11 via Frontend Transport; Fri, 23 Aug 2024 13:16:53 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 23 Aug
 2024 06:16:42 -0700
Received: from fedora (10.126.230.35) by rnnvmail201.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 23 Aug
 2024 06:16:34 -0700
References: <20240822043252.3488749-1-lizetao1@huawei.com>
 <20240822043252.3488749-11-lizetao1@huawei.com>
User-agent: mu4e 1.8.14; emacs 29.4
From: Petr Machata <petrm@nvidia.com>
To: Li Zetao <lizetao1@huawei.com>
CC: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <dsahern@kernel.org>, <idosch@nvidia.com>,
	<amcohen@nvidia.com>, <petrm@nvidia.com>, <gnault@redhat.com>,
	<b.galvani@gmail.com>, <alce@lafranque.net>, <shaozhengchao@huawei.com>,
	<horms@kernel.org>, <j.granados@samsung.com>, <linux@weissschuh.net>,
	<judyhsiao@chromium.org>, <jiri@resnulli.us>, <netdev@vger.kernel.org>
Subject: Re: [PATCH net-next 10/10] net: mpls: delete redundant judgment
 statements
Date: Fri, 23 Aug 2024 15:16:27 +0200
In-Reply-To: <20240822043252.3488749-11-lizetao1@huawei.com>
Message-ID: <8734mvjs5s.fsf@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF0001A108:EE_|IA1PR12MB8262:EE_
X-MS-Office365-Filtering-Correlation-Id: 2b94c3fe-2d7e-42a1-bfe0-08dcc375db17
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|82310400026|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?/JN3J76B/1MbgP7VkDHDkZsJnLonWMiwjXJJfnxEfoat1sV2v+MFh2UlCLJ2?=
 =?us-ascii?Q?uemiZal1uAG8TRuftHXkYM5PLwmEYHWLq/DrvUk5O3dGMNBDgygpy08qm4BJ?=
 =?us-ascii?Q?kNUQAdVzG8xi0wzHykhvU+GiATFX8kmbFx8CVVrAWWTJEijExN4S+M12YW5e?=
 =?us-ascii?Q?LTUX6RUq0flINdRYdEIwZ4QQInP6D7XSCJg+udaGvrirDj2xmWCfWyZiVS/g?=
 =?us-ascii?Q?V1SQ/eaPpLsRc+FaoUfKvm/FGclFjEHZy/jIHHkQwxBBNGVrJRMU0GQz64fH?=
 =?us-ascii?Q?xxiGjAD5iDMUYAeSUfzuPBk5ZXfPTROfe6RCuLdfOOvlGkRN57SJU/uMX+a/?=
 =?us-ascii?Q?GHSvvNRC2jbOA7AG9Qfukqmbj0AoFK4cLoygOP3gnXRUNA8gyiSDFhMS02Z0?=
 =?us-ascii?Q?De3OhKEvrUvxmI4iDbLbNmKJFBUxapZnz6yyiQAfbUAgWjePA6NxWl/jJFPn?=
 =?us-ascii?Q?zzCDORIfc2+LrW48siz26r5Lmx+xzNHG5L1kkolfGNZ+Y5Sc0viMxO6oU+s2?=
 =?us-ascii?Q?g/Mu740kg6AKNg988WlKpGlAE3SRado/TVRWYLWJTfPOXCXirVQTSW8app+i?=
 =?us-ascii?Q?bco2dIuhGlHqHqry+ajVGamHDds2OkTncz+7I01OkHSRY6P5hP30l/h2/U3b?=
 =?us-ascii?Q?JagxTIoaIDX2TxUNqjbNYSlrCcxPeAnhLuFwvb5qPI0yHMhZmq7yN/Jip+Xs?=
 =?us-ascii?Q?MTlNRX266wYLyotDh0qAEUXi2K7y+frj+NLeOxC3YAMIzw2mIBTG2j7O84qs?=
 =?us-ascii?Q?ivXKVltHK9FUUf7ffRXk10s7tlFlqfDmO9gQC6YmHu4sdPLOBjaw2ykzCHIG?=
 =?us-ascii?Q?OJap3HTkHxOwRPQUSHW02tDBCrBpYhDCkBzhL0fmgiK8hRrevwUNiLSxRKzT?=
 =?us-ascii?Q?s5OAG6+zX627gN1ae/d74RhpugKlhTH6tVYZvq4YaXpjKQgS/ZnkpH++vB5E?=
 =?us-ascii?Q?LsWzH/RSkCOdpWMRhkI+Nawzneu6xcJetiF/cGevS1paC/MEbIHUTxbH5HBt?=
 =?us-ascii?Q?xU0ZOVc3HwZlbxJe1yRSASZXcvKQdnQNxXzM8gfFtQCADemkkRJ0B1eMTCNb?=
 =?us-ascii?Q?cJq38gKUD9zjB5l1azIDTTdoiEOcgn+POv6PwlDRgy7oa+RSDxoNnok/8vdR?=
 =?us-ascii?Q?npjPEXBJkZus34jtH3Ak7hZ6Rb0jyPqMoHsDW9VZRynKqb/A5DuStFiYPiEv?=
 =?us-ascii?Q?4bP/qaUybM8UT+BWdjkkJ2EWD9sVxiUARPBIrb7WhWUi9ceZaB4d7A2hB7rI?=
 =?us-ascii?Q?VTzjn3Ob3qU0L+lnY/ODNtP2DenkQOFyHNcCKBHtlVQjCpH/MnPobBsZUPFv?=
 =?us-ascii?Q?ZTFYPMAv3qLBz6y3jtFtgXL5FbcOdjy/PDBSpah4bGwYneRnE0gWCuZ3ElJ0?=
 =?us-ascii?Q?S6bGd/VG0sjbeY27YflSO71VYvOY0H3ZAGxVglQixacG1RYjK9WA3l994za2?=
 =?us-ascii?Q?niiPTKXYdYD0T7EiG63G589wQQcAMMta?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2024 13:16:53.2093
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b94c3fe-2d7e-42a1-bfe0-08dcc375db17
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A108.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8262


Li Zetao <lizetao1@huawei.com> writes:

> The initial value of err is -ENOBUFS, and err is guaranteed to be
> less than 0 before all goto errout. Therefore, on the error path
> of errout, there is no need to repeatedly judge that err is less than 0,
> and delete redundant judgments to make the code more concise.
>
> Signed-off-by: Li Zetao <lizetao1@huawei.com>

Reviewed-by: Petr Machata <petrm@nvidia.com>

