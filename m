Return-Path: <netdev+bounces-97373-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FEDB8CB244
	for <lists+netdev@lfdr.de>; Tue, 21 May 2024 18:35:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 73A031F218E6
	for <lists+netdev@lfdr.de>; Tue, 21 May 2024 16:35:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AD171482E7;
	Tue, 21 May 2024 16:35:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Q6i+wCj9"
X-Original-To: netdev@vger.kernel.org
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2069.outbound.protection.outlook.com [40.107.101.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8C96147C73
	for <netdev@vger.kernel.org>; Tue, 21 May 2024 16:35:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716309327; cv=fail; b=XospPu+BgyH6F3rx/RakQpnAuC/20B663asCsssyR0W/zpzu6gr2pdtvzmCLn0KOt/42qS0/NinJ/1w46wyGvhgzM1BTQ9/6hVijj+F83xfgVrUh+aRx+U787zrn3HRIBQDz88DUDu60jQCLvnB3cR64B/8Jo+tkK15CTk+ldk4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716309327; c=relaxed/simple;
	bh=XkfXv6fniOtpmG07gZ/GSEw+CC1gDLhcSY0ev7N9c44=;
	h=References:From:To:CC:Subject:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=PGdg1ulQL96b6+al8pVqdT33XWI/6sEr5dK3tkmAu8ITuDwAyPLPcI8aW0EB9LAArCmznIsMAJPLhKeyeqUlz6HzZhNW5rGG9EwVN1PlONnuBgTgWqBLSTVdCOyy7+xyYpNe7O6QPNp6wH3WIDzpo+8ZceCmGUs/Bma9//beR5I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Q6i+wCj9; arc=fail smtp.client-ip=40.107.101.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GArhu8nh11+g2aE3t5c+6qWiF1+kSeMshvbTM90ZysHXG2MFRSbp9XlahSr5Mu5SC8coC/F+U6g4XNOZ6eXRSNTF/R5XE8DCIXJ60nVBfBue2y8zyjQwDELqvaTP/5rF6Muskpfc8+7NuDMEaTTffaUTCOTmEwhsv70aJXKW/FN03UGTI597AgwiCSTOa670MBcLLPZ/Yls4dS1aB2gQzqV3W08Wlj100D9AKlVMVwsm78TDrD63qZEo52kXX3N6WiA1GtJABNipD7HwTRvbPoZTVRGyEc6dOC5c/UuKEpNwiv4+vaGq2t8jW/8JmH4g8jON3iwOwAiDh8wkbPmAzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vf56E/4nxkrAtP+Y4S7A3IrHl3AsQ+XCWmNdoMi7E5k=;
 b=nzyWZkFdtZF0q9+F20Fq/TA041QQxZ75T5PB64HN8zpnOhywgQVwJwGSAtv3qcFBrTF1pU6sa5zhwtExshXLN1demy9KWCcce4Ra8vztmN4to20vxapTsgHX/stVV/TEToGu5nH0bsFNnd57hDEBbCgQNsgXpyW+Akss1GcWmZt08b/w3DSJThhY9EazB/Vq5BBZLW/hdF7mQY7QsQ+vFjK5+l116YH9e0Gts5kFXnt00MU1TShOdIFiyWntUXYQ+UEL5hd2EK+nYKR7UoOQ0vVkgCwlI7dNab7zO2EHCgRoPz0mFIGqSlKO/+ztz7IKh8tT0NhWMlGS6VHCkvO1aw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vf56E/4nxkrAtP+Y4S7A3IrHl3AsQ+XCWmNdoMi7E5k=;
 b=Q6i+wCj9fcao836AroN+NvYcRPSJ+hncqfnNLHkAvgksQ0M/LG0wL+UfYojSwSuDXPo/pG8W33xyGbvdrRaKq7Hlxvpz/RCI6erW6x92ia/n10UNNR8rp2M/lQEmJSt3i3hD+tLGV5SqIfWejGYL5+NNFzTIr3lhJbjwSw1JsJE2DdZ/bujoDhUq8smev4KLI3DKw+9eMnbd+g1N6H+O03qSkitWvJATBZxkugUrbm1T7vH9GNxl/HwJ1O/sczTOqU4Ng8ljToEtBiyYOWNNE5orORRBtZ/3CXreTi5tKJaaOHpAnhq+GsOMrn60EUZgM0F4ypASwExFd/RB8wkuXw==
Received: from BN9PR03CA0862.namprd03.prod.outlook.com (2603:10b6:408:13d::27)
 by PH7PR12MB5782.namprd12.prod.outlook.com (2603:10b6:510:1d1::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.35; Tue, 21 May
 2024 16:35:22 +0000
Received: from BN2PEPF0000449E.namprd02.prod.outlook.com
 (2603:10b6:408:13d:cafe::10) by BN9PR03CA0862.outlook.office365.com
 (2603:10b6:408:13d::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.36 via Frontend
 Transport; Tue, 21 May 2024 16:35:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN2PEPF0000449E.mail.protection.outlook.com (10.167.243.149) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7611.14 via Frontend Transport; Tue, 21 May 2024 16:35:21 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 21 May
 2024 09:35:02 -0700
Received: from yaviefel (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 21 May
 2024 09:34:57 -0700
References: <20240509160958.2987ef50@kernel.org> <87a5kslqk4.fsf@nvidia.com>
User-agent: mu4e 1.8.11; emacs 29.3
From: Petr Machata <petrm@nvidia.com>
To: Petr Machata <petrm@nvidia.com>
CC: Jakub Kicinski <kuba@kernel.org>, Florian Westphal <fw@strlen.de>, "Simon
 Horman" <horms@kernel.org>, Hangbin Liu <liuhangbin@gmail.com>, Jaehee Park
	<jhpark1013@gmail.com>, Nikolay Aleksandrov <razor@blackwall.org>, "Ido
 Schimmel" <idosch@nvidia.com>, Davide Caratti <dcaratti@redhat.com>,
	"Matthieu Baerts" <matttbe@kernel.org>, <netdev@vger.kernel.org>
Subject: Re: [TEST] Flake report
Date: Tue, 21 May 2024 18:29:08 +0200
In-Reply-To: <87a5kslqk4.fsf@nvidia.com>
Message-ID: <87o78zt97a.fsf@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF0000449E:EE_|PH7PR12MB5782:EE_
X-MS-Office365-Filtering-Correlation-Id: 5c0cf1c6-f70d-48b9-7148-08dc79b401f4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|1800799015|82310400017|376005|36860700004;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?J2jBJExgqADU/fq2Gv2oDGlWZp/Q1XCMFxldL8SyjeNXj2j4/JkTaJXC23RW?=
 =?us-ascii?Q?2KRXsx5JIrgJMsW5H5NVxOxhfb1m7CPF2chWisSZTduTK5ObFIEHTc3hANbr?=
 =?us-ascii?Q?KeQS8j+QYpBzh2ZbC+1iaLdrZjb0xDk7BYhCJwMMgTY2pohiaL+rA2SGqby2?=
 =?us-ascii?Q?hU8cXQdW0OR1aRzmdFE7mecR79Qp9YIwL0a5bQgv09r/RJiy0K3MGt2+NvCa?=
 =?us-ascii?Q?yyxeWEsqp1EWRk8l1SvDtM/CZRPFQic4Bp4Sn55TiY2O1nq4PtDO3Mgf6vQW?=
 =?us-ascii?Q?q7vA+sAgf2PqKWq8l2wH2ugeXVSQw94Y1jp1MY52c659Sutv6Iki03YBB+VG?=
 =?us-ascii?Q?FGJUFk4kQfTdYHc3V19iK04NRNhIK1V0AuM/fnFvs/KqEKlRkrWe/nWGNYSg?=
 =?us-ascii?Q?XFqeZRvC0CjQvGwoFojX0wfz2//yysSd2N9HfKg1MR1TJWNEDszihgD5rvfL?=
 =?us-ascii?Q?wh5549uL4wny4T9i9dZxTLPa9yge+OoL9zWvPRM4kWW1bUSECRgA41wlFUGW?=
 =?us-ascii?Q?8C0eoJ7f939oAJW5saAXY4Iikzyj7DCH79/pqHhBAgVHWbnUcwsCd8Pt1+m1?=
 =?us-ascii?Q?+C/bmlKz+XY5EsxCF6kVhtx+FCsVz3tzpOuUW3s7zvvzfQFMRueIeXCnZ67Q?=
 =?us-ascii?Q?3Q4UvfF2lyULKIAB0Hn9v95qdSzFOYcJs050WZfh9y3qaIzV9rHwNp+Uj1qs?=
 =?us-ascii?Q?UdfS89rW5KgyqfNrDF7+9jS5aCiihaYVyJJOTKfzpzS1Q43FlFvwLrRud9ey?=
 =?us-ascii?Q?AvrluMDFJa3ddc6TLK5efOZuHENkLdf4H9IGOoTSqE7oehQtgzxChieGghzB?=
 =?us-ascii?Q?05SUu5ukdfJt4G3+H6ZyrwGff1BF4IRnTZkec2O7VZGRLYTEoe8jsBLVrdvH?=
 =?us-ascii?Q?uUmNgTUgUaf249dKDT9ith2B9aLIgqT3Vq940/QgjGNdoGwEXbPuY+CKSYbA?=
 =?us-ascii?Q?xtMtg4GORe4LSHyeJrlG76N315ap9ZVKYJuhjuJApksCmR4JsboRVd4Sp/zL?=
 =?us-ascii?Q?3NKXGfx6nPUJ1lTZG5BOIveZQ+/F7u3M1gKunqSrIuQuHBvhxte7DCSzy/G+?=
 =?us-ascii?Q?OZJIEKkKcJsznwGJijcS70zcfYDM9Myd00sqMPjqTpf1hsn7xCCPZ3uGt98R?=
 =?us-ascii?Q?u7CP+LEkJsI5e2DORikNOM7d8K4EEQkSlrRD5/5OFjwV1dicZOxxuzwKrBRZ?=
 =?us-ascii?Q?BpHgjqAmu4hDmAHhkjJYxGUMQv0RBTrWfeMWrTICPGDnkKzNh6uIUDnZNvQo?=
 =?us-ascii?Q?HfnUtKYbCsihhre/npI3dEO6esZXeFzuRqDK4adVjDWJJ2wxxe6dtGFGpwoV?=
 =?us-ascii?Q?C+eAUNYMTj+1enlLX7xmnep0S/rhnx1TGkV1CLE9dWXH5XELdI5hJYVUOXiH?=
 =?us-ascii?Q?9a9fCvc=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(1800799015)(82310400017)(376005)(36860700004);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2024 16:35:21.1607
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c0cf1c6-f70d-48b9-7148-08dc79b401f4
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF0000449E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5782


Petr Machata <petrm@nvidia.com> writes:

> Jakub Kicinski <kuba@kernel.org> writes:
>
>> sch-tbf-ets-sh, sch-tbf-prio-sh
>> ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> To: Petr Machata <petrm@nvidia.com>
>>
>> These fail way too often on non-debug kernels :(
>> Perhaps we can extend the lower bound?
>
> Hm, it sometimes goes even below -10%. It looks like we'd need to go as
> low as -15%.
>
>> vxlan-bridge-1d-sh
>> ~~~~~~~~~~~~~~~~~~
>> To: Ido Schimmel <idosch@nvidia.com>
>> Cc: Petr Machata <petrm@nvidia.com>
>>
>> Flake fails almost always, with some form of "Expected to capture 0
>> packets, got $X"
>>
>> mirror-gre-lag-lacp-sh
>> ~~~~~~~~~~~~~~~~~~~~~~
>> To: Petr Machata <petrm@nvidia.com>
>>
>> Often fails on debug with:
>>
>> # TEST: mirror to gretap: LAG first slave (skip_hw)                   [FAIL]
>> # Expected to capture 10 packets, got 13.
>>
>> mirror-gre-vlan-bridge-1q-sh, mirror-gre-bridge-1d-vlan-sh
>> ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> To: Petr Machata <petrm@nvidia.com>
>>
>> Same kind of failure as above but less often and both on debug and non-debug.
>
> I'll look into these.

I fixed mirror-gre-lag-lacp, but the whole mirroring suite is a glorious
mess. In ancient past it used to use ping. These days it uses MZ, but it
still relies on the fact that ICMP packets are sent, including responses
these elicit, and makes all sorts of assumptions around that. And then a
router advertisement comes along and throws the counting out the window.
I'm moving it all over to UDP, but it'll take a bit.

