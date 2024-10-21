Return-Path: <netdev+bounces-137391-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D84A09A5FB7
	for <lists+netdev@lfdr.de>; Mon, 21 Oct 2024 11:08:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 93AC028183A
	for <lists+netdev@lfdr.de>; Mon, 21 Oct 2024 09:08:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2195E195980;
	Mon, 21 Oct 2024 09:08:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="WleBNQD/"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2042.outbound.protection.outlook.com [40.107.93.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 439D7194A54
	for <netdev@vger.kernel.org>; Mon, 21 Oct 2024 09:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729501731; cv=fail; b=kn95J0+46DpnfqoYZLtmGZheakVIInqhlpfC0VJ5MC99DIJeMOvyObeFlzb3yMvm33b3qROJecQQYbSBvGzvrcHS0rhu23FX1J2Lsr7xwuBaCAr/xcHStGpxBdt8PlhE8sWXLEPYatqcTBUSfxFmPGWhFUqDkr2WjBAlP5MiCZg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729501731; c=relaxed/simple;
	bh=DI+JMCEZ0AzmcXa4myica2t38oi/t9LBmy+H4587UWM=;
	h=References:From:To:CC:Subject:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=ux8TIONUTpOg82YBqAE8cCdnLgt6T2fkn6x9Y7Yft7fHnRLfAdt6Q6HHtnh3aub1S7qy//zcxXxCk7m2BrIMLnSGAcqJRng1c7yB2s3w2qH9a3UJiMAK7ywIkxJjh+exCGbydBCENC5KPyZ1Flcn6aBhSK0uG2yER4jBe2+cejw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=WleBNQD/; arc=fail smtp.client-ip=40.107.93.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JnfDqLy8t9y1QuxqAml1VTjVzXLFpKDTp/c8xK7BvKwoUdn9WErVRDbH0lGp/43OUyHqetP21GLMqKQ/M/NOHO8XlowUZ+vfdoVtovOEoV70TX74sSmaeaekcvEtw7s6YXFg8OeE8bSgpS6G6bJ5XcKqcgXgx+wdIgm9Lln2mzYbkwW+JwEO2dYJDP2vrDrP7IKA1jrOsQAHUR19XI1fnhYy0ezx6t016/GRXf35/dlc3qnlTduMYnCRx7kqREFiZBZcf9IpWtsXNPbjbA44MmDRt38CjIye9x47dtHXK98ldAQsoDm0JxqEKbsxxXvtqkRrDQsjWG4thS2fQiFb8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=azlikx9YfuN7jNLJb6B+16K5druISWTcO9+VwVyawa4=;
 b=UBd9vc73xaabfmetXld9KF+uZftL7DQpdFgNJLFyEI9Mrhpgy3MjgOpDeKUKOTPXQ3sTQt4wkuabfW/f4vey05q9hpT4r+ut2Na9OqFHEZobcKjNBeU0kl0dB/rWf48CmkuF2pRGigIljjLikQKlVX43ZJ/9HlsAfbZQDoxpimAyfyX/98lNHJPo4ZeXdcTPBYVcY8qKS6jgLSy53m7OdV9Oi0cPumFNQrebGn41XH9AgsgT/8TrWF5GrAnWDHLCQ2R5CYRHHb+gtaubBZfY5jfjvKHprUTUUQiFzn1Mu6m1hgyp4m9L5DXZSo3E9/UBjxtntvUfzLIVCv7gy7881Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=azlikx9YfuN7jNLJb6B+16K5druISWTcO9+VwVyawa4=;
 b=WleBNQD/m0hSfbYTa8vx00wOkfgGesvHYt/eXcnRCjrS9gSEC3ifpR3jRqDoOfJPQbepFgLwGxxBipDdbeFX/oyQCSdFSz/kWmOrOwWF8wQpum9N1y79qHigY8BE3vIHWkeWwFNhOCIYUFNU7pdS0x09cRyElXfDUr1qv/8Ek0fC4mGBCi4GlnrbAm8NxCyRATguk2vH7I9lFLydD77+jv4kdKkin0mtZV9tPEDgmLyf89qAOIVSkdXGuysXz66DnKqilXpE0NFDdSlusOFugHcoWIY4RwoVG0HNO0buhM+kWDywEqjbEBrmCYgLQKxdJlSbsoLlVpIpKjtklSNiHw==
Received: from BN0PR04CA0027.namprd04.prod.outlook.com (2603:10b6:408:ee::32)
 by MN2PR12MB4374.namprd12.prod.outlook.com (2603:10b6:208:266::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.29; Mon, 21 Oct
 2024 09:08:45 +0000
Received: from BN3PEPF0000B06A.namprd21.prod.outlook.com
 (2603:10b6:408:ee:cafe::7f) by BN0PR04CA0027.outlook.office365.com
 (2603:10b6:408:ee::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.28 via Frontend
 Transport; Mon, 21 Oct 2024 09:08:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN3PEPF0000B06A.mail.protection.outlook.com (10.167.243.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8114.2 via Frontend Transport; Mon, 21 Oct 2024 09:08:45 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 21 Oct
 2024 02:08:39 -0700
Received: from fedora (10.126.231.35) by rnnvmail201.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 21 Oct
 2024 02:08:34 -0700
References: <87y12mk6f0.fsf@nvidia.com>
 <20241020071626.500958-1-gnaaman@drivenets.com>
User-agent: mu4e 1.8.14; emacs 29.4
From: Petr Machata <petrm@nvidia.com>
To: Gilad Naaman <gnaaman@drivenets.com>
CC: <petrm@nvidia.com>, <davem@davemloft.net>, <edumazet@google.com>,
	<idosch@nvidia.com>, <kuba@kernel.org>, <kuniyu@amazon.com>,
	<netdev@vger.kernel.org>, <pabeni@redhat.com>
Subject: Re: [PATCH net-next v5 2/6] Define neigh_for_each
Date: Mon, 21 Oct 2024 11:07:56 +0200
In-Reply-To: <20241020071626.500958-1-gnaaman@drivenets.com>
Message-ID: <87ed49kelv.fsf@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B06A:EE_|MN2PR12MB4374:EE_
X-MS-Office365-Filtering-Correlation-Id: 640f8706-4ec4-4531-9a37-08dcf1aff7bd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?KC7gA5EIWX4VfYz4FQjyDGUTeBLR0U8V/wOfcCbUM6KcliVD5EJofpPESgVU?=
 =?us-ascii?Q?uRrcrur3BJ2EBbJDvMKWb9oaRRHzOnwVAuUpNtdr29zxFZhvWPv2L4eh4EHl?=
 =?us-ascii?Q?ijxtEWNMMmgdoMMiuXyamxtUJWzyxlPq0GC1pfrvN0PI1VxKKsGcf20E48qb?=
 =?us-ascii?Q?xEIPk7qZ1PWTC6gVMoQ/VPdUrhxHV3eqQRHRxCVj7dlbyAqhV6SeftEHe3CA?=
 =?us-ascii?Q?RwePH9pRAoUIBNiyEu/KOx6by0TCe6/rHAWnQI5Edt3ecIhoVIR8iCKuA6bN?=
 =?us-ascii?Q?4JZOal2hzWy33zfsdg/XM9F9xGAXGswLnezelRD9um6ITMMubT+7a318b6JZ?=
 =?us-ascii?Q?OBF2zcDsiEfmcm/KZYpcm4GbRTpejtrCCYrHVw9o0k/AOUVU9PgQlRGZ+mmr?=
 =?us-ascii?Q?FIlhL+dYcuVvZCfZjFWVhPBwRf767HAV0Xae/qIkPzgQcsBGLy+FpF3kwtNY?=
 =?us-ascii?Q?adSWVcTRTYwiTYsX5xoD79wBxjccDKhmuFMOkLr2UAaw2F465ysC8grUHnpl?=
 =?us-ascii?Q?9ejjOm3vktTQfHpqhrCKW7cMdlrFnyU1FvySdZsTCUeZYFD0BJW4U7qP97wr?=
 =?us-ascii?Q?6EGSu3LhDkDdEQh+Q8UcOssY0EmoLMzTT8GnjtzY+TBeGAhnTE52m4qxCuN0?=
 =?us-ascii?Q?lPjqevKRPhKnWxuAY/O+n1No6oE6lQ5H7IgMwnHcGSzwAzQ2p/I8VnV6zDo0?=
 =?us-ascii?Q?uFodeZw3CD4QzHdiCripnLRgxnkRrmBeAiWGyo5w/shibdrMJWB+u72LFcyy?=
 =?us-ascii?Q?IPDTWH6WS+HC2RzndSfwjAIHEGjmUZn7ei6p8d32Hp/hqscMQ10COfFA8qSc?=
 =?us-ascii?Q?cIt2kbJ8GPJqj8kpS70XGCdF3HcWW3lFwJM6+uWx3iFpu4+yPkBAHE5En7Qx?=
 =?us-ascii?Q?umyqH8GXRm18vapKLLzs5VMs+T7o5icwp2meIzdG0U8SDcw2jdkZr8MLcYhA?=
 =?us-ascii?Q?FXjq87U9+s1Odg85cb96P/g5Ls+sY2INR5rvy6NSZcl3/fvtqK96GLqYsoki?=
 =?us-ascii?Q?6qgqKEFpf9F3O+5VMqhDJ3bjCDoI/Ene3tZeQtb6Q6SahisMMUYKrnNAYczR?=
 =?us-ascii?Q?gAAoP7Y6QHDcc8tgp8IBYSuPEqFB86U3ZyrNkVzr6d90WKJfiNrGmgc0f3Na?=
 =?us-ascii?Q?2Ca/0T2nYTKacrXiDBgiW45yPoqvMry4wYnCBZwgZsySXuhvw9sSzATFFMht?=
 =?us-ascii?Q?kDfGwEmE8WAZ6b6Bdf917hkAC4ce2IelnaBagsiIFyVEw3YVmPg+Gp7wiinU?=
 =?us-ascii?Q?ttbrzXB85if/Dtt4wDziAiRjLa7L105MPx26mbZm+9fyGkFn3EMwxApqP85+?=
 =?us-ascii?Q?QsHlAzFI8O9KXIdndkWv89sNTamdv9HP02VBe0Zne+rPqbK+nA06tlEnqa1+?=
 =?us-ascii?Q?IpGUNOaVKRbSk9H/lAFQZjUQnuZIKEbPX6OjYxvL8D71tcWQ0Q=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2024 09:08:45.5705
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 640f8706-4ec4-4531-9a37-08dcf1aff7bd
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B06A.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4374


Gilad Naaman <gnaaman@drivenets.com> writes:

>> Note about subjects: all your patches should have an appropriate subject
>> prefix. It looks like it could just be "net: neighbour:" for every patch.
>
> Or independently, after the prefix, as in:
>
>     [PATCH net-next vX A/B] neighbour: REST OF PATCH

This one.

