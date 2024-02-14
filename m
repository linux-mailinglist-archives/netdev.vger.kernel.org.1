Return-Path: <netdev+bounces-71645-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E972854661
	for <lists+netdev@lfdr.de>; Wed, 14 Feb 2024 10:47:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 937011C22074
	for <lists+netdev@lfdr.de>; Wed, 14 Feb 2024 09:47:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57725134A9;
	Wed, 14 Feb 2024 09:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Eejm3O8A"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2059.outbound.protection.outlook.com [40.107.237.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC04517C98;
	Wed, 14 Feb 2024 09:47:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707904041; cv=fail; b=QJYwzc9pHcvhosCZZs9bqYVmBl1znQwtLH7+L1F4oafIa7EbpOy62TOaeBYz/h4uNvYe2P9yVPY7Q5otHef9b1Ax8IxkwyXRdUsRirgelK5Ir4O+4eHgf//4cug7iTrOdcb1j5EXGziYw8pZWBFZVkG9SWoGeFfgWDvT4+fxhDk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707904041; c=relaxed/simple;
	bh=uaB8Io0i3wqi2/bqilX7pUdtwjGDh9Nh0qIKJR0ybik=;
	h=References:From:To:CC:Subject:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=VmfqqWvkGjIS0xrR7Py33hxGyizOZ5ZrIM0k9NgzZXSKgzTkQRpHjlzYxG3TytnriYxmv3VYffj6j6PYevcomqxAfbnaE8pAnZUm6Usl+CIBM5vXwMuDK8/H/VYj2d5nP5rVtv53fDuqo7xkAS2EmdiRigfpXXdl1c2KD4siGRU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Eejm3O8A; arc=fail smtp.client-ip=40.107.237.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l62peGHw6a6KkFVDWs0NqfUUht7TocrNXGTD626PCiSxsjU9VYIoTvjVtt8X2nGKpJY0EdQiqdc5RKxgOYyUsThViYr/ZFS9mwsDq80Kl8QG0tgAti4LUkLZgtmWeuze52ayY1Xrs4elfYBV2WtMAqK/6uYTO03KMplL0KZJoW9o02OCOlXqVuoLArA04X3slH+RU6dgCxTxhhKzm1t7gunoMZ7oWyU0f9lKzfAA2mclQG4xMzS/6uKejFv5t4Q7B7gWbpSAb+ti1upwY35N3LHOfQBs8y7hMIJOAEPA7HS53fB4p3LWjXn8S3SXxEOr9j8dUKcnfccQVa2n6pMTXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y2t5fh+NTkRLssE5LwIhYVs/cxt73OigZgoQEE5ozic=;
 b=SSjlLvN2ydJnATcAw9T5CfvNg+1vBHIn5tcICZRR2I2b3zl8TzZxtieJYZ55T32FluUpw+z5sOAXUuD8CjS63UaKcFmIOhzQAYKjJ0FRreNsumMSqBo4nvtqDVwGk+P6O3Lo64ooqEk+DGlsWFupT1VJ4IQlqzV8eI0JO/rgeVO0EdSFiHvmvbBLTsabyub/n7+ISsw8s8yPRYOYQkTJ1zGIvzXKEvsVQDLilPMA16F+jpQJrRqKjCxLeGy7XyVQvJdq9Y2+fZPUYrStlx6p5BXLSGwwcXNZ5XSwAXTzkJnyo/QoG0lmxcz2j5Kcm9urglDoeBwF7H7JH7MDZEdTJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y2t5fh+NTkRLssE5LwIhYVs/cxt73OigZgoQEE5ozic=;
 b=Eejm3O8ApR7ybnSiqPhwwOQdmBLAxFm+2Oa9eyJkGPOZyjqiX87GbBUrUewI8l9NVeZJcZPplG+WgWAhGFHc+L1cG6QN+/Jc9YIN4XyGL5T3TAZSGPS4I8+KZTWIxgG77kteotA30LtSTNXswgIP6fDv1wtJEuK3K6O8AFw000EePByjBzFdYcnmu3SlIOhAFS5CBVQzHhvZuxnKRQPWP6F0/ntUaDRUH29VbJFj598eYxNbBc5RlkrZQAruuFe+wgdq7Gx5Ac4LUZWN3Yglmq7o7oQ231+/8A/AFgpBbHmVoDO/3sAA/Jz3kU8eMHwa0xzrTDJwLHj+1qQIWFhtSQ==
Received: from SN7PR04CA0239.namprd04.prod.outlook.com (2603:10b6:806:127::34)
 by CH2PR12MB4149.namprd12.prod.outlook.com (2603:10b6:610:7c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.25; Wed, 14 Feb
 2024 09:47:14 +0000
Received: from SA2PEPF000015CC.namprd03.prod.outlook.com
 (2603:10b6:806:127:cafe::7d) by SN7PR04CA0239.outlook.office365.com
 (2603:10b6:806:127::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.40 via Frontend
 Transport; Wed, 14 Feb 2024 09:47:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SA2PEPF000015CC.mail.protection.outlook.com (10.167.241.202) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7292.25 via Frontend Transport; Wed, 14 Feb 2024 09:47:13 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Wed, 14 Feb
 2024 01:46:52 -0800
Received: from yaviefel (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12; Wed, 14 Feb
 2024 01:46:51 -0800
References: <20240212213736.07d3d651@kernel.org>
 <20240213095711.0e6efa2d@kernel.org>
User-agent: mu4e 1.8.11; emacs 28.3
From: Petr Machata <petrm@nvidia.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: <netdev@vger.kernel.org>, <netdev-driver-reviewers@vger.kernel.org>
Subject: Re: netdev call - Feb 13th
Date: Wed, 14 Feb 2024 10:43:38 +0100
In-Reply-To: <20240213095711.0e6efa2d@kernel.org>
Message-ID: <87o7cjidiv.fsf@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF000015CC:EE_|CH2PR12MB4149:EE_
X-MS-Office365-Filtering-Correlation-Id: af0e55ce-bae6-41c6-3b8c-08dc2d41ec45
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	4T6YXdr0JD+3XrKVG84QOTNPfxBkL84YR7qFY1V8UTHXqCD92Cjy+OqxsZhulW7yXYpPoX0WEWio15NEEqjnKe3A+BBJ2Pt7m7o28ZV51pvWVN9JufNhRG192Ap9VoBQdzb9UoiT5PeqZ7TcmdsFQnLHMUQgkXcKGVYG3ts4pw7vb9PbJttKP4If/0QN9ondO9yzivtdq7oRFVyT6sFT0uJuoDiiLudLqMeD/33pPU5xmfOhVSXPcpGQXdPucihIzeBFurPr2RVAfptWCuauBOhcDARZLs0orQlvzCZmKE18Q+BAhx9cd0TvoZ/k3xGd4JIOsCOHKVtG2/eim4J/x7TAcFXsnw2h6G0YSRl2O3+T7wULH922C9FVYA6VEpOXpYDXSjE0I2cd6pABpav98RAE3nhUJM6CLLcWUG9Bz996xBVJ3p43mzPV7I52OkJ96RmlXJk83JTz20zydTJ53Ul5nEdvvby8vhi7V6o43p2Gh6gzwDLf/sBfnkzh4w7CikHF3hB3zQP8/TKQvY7Dymev5m6YzvRXew47oP2TRS0QxNa+9jFKzq9ZW2f2QXRGG77eYb8iToxGbaRKsOVATJ16SRvtnVcmWbQ/lCMT1go=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(346002)(136003)(39860400002)(396003)(376002)(230922051799003)(451199024)(1800799012)(64100799003)(82310400011)(186009)(36840700001)(46966006)(40470700004)(478600001)(82740400003)(6666004)(86362001)(41300700001)(356005)(7636003)(2906002)(5660300002)(26005)(70206006)(54906003)(6916009)(316002)(70586007)(8676002)(8936002)(4326008)(16526019)(426003)(336012)(2616005)(558084003)(36756003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2024 09:47:13.7508
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: af0e55ce-bae6-41c6-3b8c-08dc2d41ec45
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF000015CC.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4149


Jakub Kicinski <kuba@kernel.org> writes:

>  * HW tests still need to be moved out

Took me a bit longer to get around to this, but I'm on it now.
That plus the forwarding.config.sample, and KSFT_MACHINE_SLOW.

