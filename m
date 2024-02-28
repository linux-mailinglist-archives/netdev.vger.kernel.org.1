Return-Path: <netdev+bounces-75659-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A59BA86ACED
	for <lists+netdev@lfdr.de>; Wed, 28 Feb 2024 12:24:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D70471C21581
	for <lists+netdev@lfdr.de>; Wed, 28 Feb 2024 11:24:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7ADDB12C53A;
	Wed, 28 Feb 2024 11:24:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="FzoC7wRu"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2055.outbound.protection.outlook.com [40.107.243.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E534E7F47F
	for <netdev@vger.kernel.org>; Wed, 28 Feb 2024 11:24:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709119483; cv=fail; b=tYascwW5ONGRn+g0dndW23iME60bB+Ox/bcJFkpe90GqSUl8D4BweQTdhmxPo8d7dF+HPBIIiOJQrGjOVQwkuHKsbLTopOo5JaOLPipgNs/ZU+w3/5IENl0oWZXfZq41TnXGPhIYWDQcaThCqb6PijidMFyglhImI7BLGNQfmDE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709119483; c=relaxed/simple;
	bh=CUiqafLPDtSzjZ3TKGo9mD4wSnQIAwtSwbIBKzHpAx4=;
	h=References:From:To:CC:Subject:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=JGjtpx3R0sfTRj2jRZLaZCkJv/cKffvuOsZpGySIUYKRfyjdXqwp6DD7Q9ZvDe6x5/0Yu4NGDPhGnlhGM/neGSaX6vCjSECCKvksSCeGYFwqWuLrLpZeLS6qr2c25Lbghl4LciSP1FX0H9m6zlAvV/LpXv33IgjBwxRvoCIEciY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=FzoC7wRu; arc=fail smtp.client-ip=40.107.243.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WwgoBpAvksc1PMgYYPICjwIWwUzeSLHDv52dneVfzfyxpJPn+7lnoOz9HrLONQpswrfHFAmZRr2Ov1/K2axjx3WkDtUz5nIpfPdnDRb+4TLhbdU/QqPNs5JkUK7FWAnHHiHCyFp/bU2MdSwsEMR6EPH41yDSVcFIamIRUbtCsyf+UJt0mZZMCZsndq7Ftp2s6cLLY07tAt+s9uu//ywpX2JIUaRZgaBMG937KToM81QvV1Sio7sSJksf0fD18QgzWInGnxSN8ZDC2shnSa/7HFJA+h21tnvLaMNlQAoLc+Jeo7yQz2PO8cktaLkfctOSGaltYAAREdTgGEFU6ZdIHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/iTlkVw4GUrXfBthgOLL3iTQkrpBb50XT5XVA+pXMT0=;
 b=Mla59yE4y2c/BjODizlt8XUTVTT5sYimfCL55cu1p6y0lPH47Ij7xx5oyoqVsc2XKbef/mcrTo3vRFgoqR80DI7UqR9DDE4RhlzS6SHyMvb2BDaEK8f7JKK+s5I5tPubC6zhldP2+xCCWKQO4N+wyz8EYa0p+/OmfhWu5tHGlEConSssoaaOuW0QN5blDnIGuCzS/vvG9VHn/Ppa9y/A/UUiiubmeW6NKR8zSGib2jHtOZ8GY/tkwJMN3z86pRwJtVxGM6mRjjVHQ1bGLCPXoBt/YIfOy0DB/0Ly6byXAn8jFDN/UAQmTp9SlUlO12VA/A9T9cubn1+EcVsS9BmsFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/iTlkVw4GUrXfBthgOLL3iTQkrpBb50XT5XVA+pXMT0=;
 b=FzoC7wRusHF1qT5fACYaUnTptX5yznH2ZOSpptxW2sjXlgFDIHOyCAsQf6SzCM36fMBumT4TrVsA6Zk9bcqwmf/hrqdrJnnpyCrvtbFY2hCXhXMeDqOhVIQdmLSEYndMEXA6BNnnSUQZGXeMSoBRYEd2cAz9idp1EvhYaxfXYPDpRFg1eZNEKBIPrm5jQ7rG/T79ckq4WuE8inL3RjbYi9NN63mYBgmhAJFPg8Yo17+/9IslqSUbiaiF/8ZdVgsJQJkpg7ZpZTFXVRa7ILLgyTLHV69RLz8lJ2S1epxomB9BWyn/iy8wl6dveEhHLbOSm8UK2OL0ApspnXP3KDRJnA==
Received: from CH2PR18CA0044.namprd18.prod.outlook.com (2603:10b6:610:55::24)
 by CYYPR12MB8938.namprd12.prod.outlook.com (2603:10b6:930:c7::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.36; Wed, 28 Feb
 2024 11:24:39 +0000
Received: from CH2PEPF0000009E.namprd02.prod.outlook.com
 (2603:10b6:610:55:cafe::2e) by CH2PR18CA0044.outlook.office365.com
 (2603:10b6:610:55::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.50 via Frontend
 Transport; Wed, 28 Feb 2024 11:24:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CH2PEPF0000009E.mail.protection.outlook.com (10.167.244.27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7292.25 via Frontend Transport; Wed, 28 Feb 2024 11:24:38 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Wed, 28 Feb
 2024 03:24:21 -0800
Received: from yaviefel (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12; Wed, 28 Feb
 2024 03:24:19 -0800
References: <cover.1709057158.git.petrm@nvidia.com>
 <b194971db40744eb8aa6e1e562564cac7118c42f.1709057158.git.petrm@nvidia.com>
 <20240227193555.39e56436@kernel.org>
User-agent: mu4e 1.8.11; emacs 28.3
From: Petr Machata <petrm@nvidia.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: Petr Machata <petrm@nvidia.com>, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	<netdev@vger.kernel.org>, Ido Schimmel <idosch@nvidia.com>, David Ahern
	<dsahern@kernel.org>, <mlxsw@nvidia.com>
Subject: Re: [PATCH net-next 4/7] net: nexthop: Expose nexthop group stats
 to user space
Date: Wed, 28 Feb 2024 12:24:12 +0100
In-Reply-To: <20240227193555.39e56436@kernel.org>
Message-ID: <8734tcq1b2.fsf@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF0000009E:EE_|CYYPR12MB8938:EE_
X-MS-Office365-Filtering-Correlation-Id: cc26eb09-3a0e-4b34-938c-08dc384fda0f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	mlcudmfO6HSfUcdCxRL2M/7j1V/U3vXpouJ54XC6Squu+GwXEev/tMnYPFMyK2V0m8UjwzGliOr7/ZC3AiYbqqvanf1dgIOlO+NJfafUvx9thdeVFpGMVicSh6wj26C5uNO5AJiq/oJ5WwJ+iJMgC7l3Wgx/afXwjcGUw5UJM50Ii19feVSUUDDPDVLmJTe93yuLWC4BDESJSEHXPjm5k8tj/1ICEibjy+40XuLkRTefGg9VyNJg4OMWvI/g+4PAL07+5+8Wl5IELMeYwzDhc22tP1CNoSR7tHIPxKAxZ4mwnzYo1p/047gdc+YbS+Q9X4ubMR9WEU4k8CGL4vBUkIceRvv4KxdljPJRG4zy6xzdwY3xZICbp8dhEAMbl+7+Uynm0Uqth2SBsjU7zPNQWzU8VSiDgkowcujYR7eNi5h8f95UZ4DR9vxZWz5O697jn+Dmor2a4SWCjMikHMiDI+QX3K6rZy3YudKg/DjynjtY6EPawxvtUxtb9CbIgw/RkDEC3iw1R7zsyGKigEiio4RIN0KXsxXyHYmmktPBTfuBEdVFDz69gjs42voabzERLCVG3ECyYpPUrGU5FgV29M/Hw3++W5bRPvlz8kV4WJ4/IqVLyLmBITjOmYFmtIXSuxJTNpPlQreY0kyG+cb8BULyQaUUdgxfpMMpofbopMvKeCdr32ZgzM+Ea2FWN3hFC8zf2R0oQmducsU+ncwV7rhcOPf4arpDkaTbHYLyUhXYua1QmDQ4RHhrhvkVzbpO
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(82310400014)(36860700004);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2024 11:24:38.9137
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cc26eb09-3a0e-4b34-938c-08dc384fda0f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF0000009E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8938


Jakub Kicinski <kuba@kernel.org> writes:

> On Tue, 27 Feb 2024 19:17:29 +0100 Petr Machata wrote:
>> +	NHA_GROUP_STATS_ENTRY_PAD = NHA_GROUP_STATS_ENTRY_UNSPEC,
>> +
>> +	/* u32; nexthop id of the nexthop group entry */
>> +	NHA_GROUP_STATS_ENTRY_ID,
>> +
>> +	/* u64; number of packets forwarded via the nexthop group entry */
>> +	NHA_GROUP_STATS_ENTRY_PACKETS,
>
> auto-int, please - nla_put_uint() etc.
> No need for the padding or guessing how big the value needs to be.

OK.

