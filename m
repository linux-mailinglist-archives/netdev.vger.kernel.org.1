Return-Path: <netdev+bounces-225383-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DC05BB9355E
	for <lists+netdev@lfdr.de>; Mon, 22 Sep 2025 23:09:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D156219C013D
	for <lists+netdev@lfdr.de>; Mon, 22 Sep 2025 21:09:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10DD0261B78;
	Mon, 22 Sep 2025 21:09:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="WoSiWlgX"
X-Original-To: netdev@vger.kernel.org
Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011023.outbound.protection.outlook.com [52.101.57.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7963434BA39;
	Mon, 22 Sep 2025 21:09:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.57.23
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758575354; cv=fail; b=FMDzugNNQwRHS4mOiW2LRLeXCcC+piyPo/XnnXhZVApLZnRnCZ6NV9liYFS6TljSBEzA2l+XiyzKfBx8KZJJWp4nE9k9TyMxVpnazJ8dvzXRBvjIErYO77FLa21h0tcC9cJ/dQ88g5mQIn2pkPCBqYf5sSZm/7CaTNozD47fl2k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758575354; c=relaxed/simple;
	bh=Pb2JWKO67EYEgsRvaF0iZrKqpBVzSLzp6nMxEVfGGj0=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:CC:References:
	 In-Reply-To:Content-Type; b=X5272DWuY4XUdmdodmFn8ug+FAqT8vQA11pvGoIRsMZH4zL8GWlBB6tWb90NCuMH6ATqcB6mDTarEY4XVx1K10R8ENc71RfTQcnqVqkmu4qxZVXunjYUwu+XcnP+KYDmn3pF+gO6zK8lAFitXvrXY5mENgTtaGOA3HGuRfAWVU0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=WoSiWlgX; arc=fail smtp.client-ip=52.101.57.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OCr4qyk3d/AGILjbNncHue+8eKzfHWgqaseS3e7p3TbPvEcDXaWzwweXwCwG9SPgyPygeCxRnasAYIcX7qZxeEaSh/ggpM6hITy/Hny4y1h+y5tAVP3ehXdCyGDTZJn6Yiub05MOwA8KUVtkfS2IJ34v1bb/LcMgigdXZiwr+HEVnxUixeeFi8MOE8gIWAPLdCFY1fBB1AeR2fgVZN5Ebhy5stn/eARisjjO6/+W04eA4iH1GFVak7Owc7m2lJ923JJyD51gibnQ2KqZNr4bHVzhUh0ZdUKqTFclr++oYr4SIYuKMJQvDc0EGOp2Z/m2K0Jkeac8Zcp4Y2+8dd+svA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=odx87c6nE47CZZ85MEP8+hxP5pFHcMmVaQWjoaYXqsA=;
 b=uEVzUaa5te30c2fQCSDVN5gah7lvfi7aKIyeNGFhl2VHq7r/pw3vxjcZNpLRxqAP34UK7rK6aL/HCgUtvLGiBgDwWxUFViWp2cwDLbsDUBtZc7ybGERjM83s+DuW0IKY/FjeFtUVEWRxpolTJ1o0muBCkb2GjMI3xnaYU0Um9vrfU/fQBbDEr0ol553h3d71KbVWwzVVGDZTuneWuCwR4tDJ242pNFEpd7PaEvVFu5JE927O8vYh51TU9s9zZPcM4KiZTljx8tUN0wB8k27NbFbipv9w5x0t16FzYOWeBpv9LYN48R+tWEE0al+qd3DxhcBXoiZQc8lOad628Uc55A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=odx87c6nE47CZZ85MEP8+hxP5pFHcMmVaQWjoaYXqsA=;
 b=WoSiWlgX73MVRLmF5SHYqtV/xi9oHk+ibPjNSFwe/QKYIKCLojR1tTzwBe/KMXMds4OhhOBxeXJnztvMaANrpHPqCRz8Tb9N3o8R2gUl1dC8xcnyPrUZSkgjkauw7sD5T0F9wGtobJ6637C2HiRlnnmxf7LgOYNfpUH2oFcd55I=
Received: from DM6PR08CA0019.namprd08.prod.outlook.com (2603:10b6:5:80::32) by
 SN7PR12MB7227.namprd12.prod.outlook.com (2603:10b6:806:2aa::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.19; Mon, 22 Sep
 2025 21:09:06 +0000
Received: from DS1PEPF0001709B.namprd05.prod.outlook.com
 (2603:10b6:5:80:cafe::17) by DM6PR08CA0019.outlook.office365.com
 (2603:10b6:5:80::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.20 via Frontend Transport; Mon,
 22 Sep 2025 21:09:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS1PEPF0001709B.mail.protection.outlook.com (10.167.18.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9137.12 via Frontend Transport; Mon, 22 Sep 2025 21:09:06 +0000
Received: from [172.31.131.67] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 22 Sep
 2025 14:09:02 -0700
Message-ID: <4e302fce-c4ad-457d-a94a-384b124d76fd@amd.com>
Date: Mon, 22 Sep 2025 16:09:01 -0500
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: "Cheatham, Benjamin" <benjamin.cheatham@amd.com>
Subject: Re: [PATCH v18 05/20] cxl: Support dpa initialization without a
 mailbox
To: <alejandro.lucero-palau@amd.com>
CC: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <edward.cree@amd.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>,
	<dave.jiang@intel.com>
References: <20250918091746.2034285-1-alejandro.lucero-palau@amd.com>
 <20250918091746.2034285-6-alejandro.lucero-palau@amd.com>
Content-Language: en-US
In-Reply-To: <20250918091746.2034285-6-alejandro.lucero-palau@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0001709B:EE_|SN7PR12MB7227:EE_
X-MS-Office365-Filtering-Correlation-Id: ea959538-be88-4ff2-4705-08ddfa1c442c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MkdMK1p5dUdlTWpJNEg5SUxrRTZIYTExTDVNNFpqZ2hzZXZleExPTElSa2pm?=
 =?utf-8?B?QnJBd3RWbkg0akc0NytKTmhUby8yWU1pc1luQmhLTnJacklzNy80SEp0T0hE?=
 =?utf-8?B?S1NTNTRWYnI1TmpzblRGOThCZFBBbXJvSUZFK1ZwUXdObnpXVko3aWJXZ2lV?=
 =?utf-8?B?RVlSa3dtSEp1djBPU0F2SFJlMUZYTmIwRjdCQkc2RW1mN2p5a1ZDWi9mYjRE?=
 =?utf-8?B?a3pXbE43dkZTaXpjMCsxOUxzMFZyc0tUT1k1YllaWGVXeDZCbGU5bStjS1VR?=
 =?utf-8?B?MC92WVB4UnV4TkZrenROZTJyYWl0LzV5VGN3dEJjc1l1bTBva3V4ZmQzNGRx?=
 =?utf-8?B?Q1hRVTNGTC9qUEErbDZWb2dGZjVKcWZKSXpxOWhKd2IwK2Y0N0RVOGs1MUpK?=
 =?utf-8?B?WjBLclZ0SWZ4RitHWU9UbDE2Z2tpMjdZRnJ2Z0l4YVNRNXlQK2duSHVSOGxa?=
 =?utf-8?B?UldFaU9yb2lKbDYwVytQOEJvd05pM0QzREMwSVYybnpkUWRJalZxdlRJc0hj?=
 =?utf-8?B?b3RXd0xPTFozTmRXWEFQNFgxclVjODFYOFJqeTRjRUdsY2VPNmJJZnJ2RWs5?=
 =?utf-8?B?bnlGeGZ2c1RMcmR1MTJPT0VsSmRiYzUybzU2YU1QTzcwN3NWZ0kvT2dJUll2?=
 =?utf-8?B?WXJTdFpIVmd4NFVxa1RmR1VLaGhuSnFvcmhGZzJXV0ZUWkg3SlhNV1YxZHdU?=
 =?utf-8?B?anhkdDh6ZEZ3c3dsUzdtZ0pLTHEvNlVrRzhib3VDZmxQYWFtN3pEV0xJNG96?=
 =?utf-8?B?VU1uS2lFL0lSQnZ5dWQxbi9LRzNEZW1RYlh5M2JKYldDS3JFeEFFN01VNnRn?=
 =?utf-8?B?cjI2bDE1RnY4TWdpaHUwSlZRM2p6MDFCZkNSaXpvbzgrUEtwMW5jaHdFUGJJ?=
 =?utf-8?B?a3FRVWZzY0V0YTUreEFDQXhQYnV0blZqUDcxbHZJd3VyOUMwV2FlTktMRmJ3?=
 =?utf-8?B?WXRLWTFDWmtQZ3lBT3F5RmpjRDJlZGJMZkRzSWE5NlVLcjdHV2xvVk9OTGFC?=
 =?utf-8?B?a0JNeTk5YWl2TEZWM3NIbzl5MG1DUkx6MWR4eXF3YnFIYWJLaWk1WlNmY1BB?=
 =?utf-8?B?RGUwaTVEb1VQUGFDc1p4OUd1ZjdxOXRtci9VVUJQbFJ5NUNjQ1FZSGR0cDVT?=
 =?utf-8?B?T3gzSmlVVU1jSGFPMVIvOHVNU3kwbGRZWkZEVisvSitxYUk5MFBiNnhPSGVs?=
 =?utf-8?B?ZXdCSWs2ait5RDRFT2FtRWZGcFlleTRaMU5MbFVzUVVTekFxV1NRS2lNQnRY?=
 =?utf-8?B?dTVXTC9ZSDJwa1ZIaDhCazVYZjFuWThoT3A4VUNWczNhUHRlZWZGbjYyTHMx?=
 =?utf-8?B?MzB2Sml6ZHd0b2JjaW5kd3lKSjAwMTk5Vms0bzgxeUJUZnF3b0VlU3dPU0t0?=
 =?utf-8?B?K294OHIzWWdybHlIbVFNbC9iT3JnNDBMQ0pHZWZKN3U4M1RQb3VxbDhFZXdZ?=
 =?utf-8?B?ZURJL05jTE9xT3JFSFBjSGY3MXB4VW1sS3pWN1dGa3NoYjZCS0kzWUs2TUp1?=
 =?utf-8?B?YlpHYjhrdnN5VEJiWHRjczBmaHFYb2hOZ3hPZVJzeHZlT0pBakhpdWg2RCtR?=
 =?utf-8?B?Mkcrd0NUY3A3VVRnNXR5U243dWVoZ0lXKzZHQktFUDluTVZ3YW9ENGgwUEZk?=
 =?utf-8?B?R0JqVSt2SmNsc0VXb1B1NVQ4WG1xSEc4eHI3MTVCekRSWDlqajFkNHZiKzZP?=
 =?utf-8?B?V1ZDT053Q0Exd09Pdyt5cFRRSnlhVERuY3VaY0xVMmIzeGtsK0I0Mk1uK21R?=
 =?utf-8?B?eDNvREcxUStXdmVxT1ZEQU44YlF4Y081UWN3ME41NUkzNUVhMnlkK2lST1dD?=
 =?utf-8?B?Y25pVi9rRGY5bUNROTl4eThUMFYwMUlSRit0Undocmh1WHRQdStOWk8wVG5R?=
 =?utf-8?B?Wm13UHNDbDV5eWV3dXQ1RzFXVnhLSlFrbzVkMWFJZE0wYjhvOXFHV2xEcE11?=
 =?utf-8?B?Z0E3bDdQMDhyK3pqMk1QRjNtUXJwRWFhcnd3czQ4eTRNY3c2MlJOVnJsUkRw?=
 =?utf-8?B?MkJlSm8yaXZMeTlNNnRmbXE2c0RUMjJ3U3dWTk5Hb0pabHBpcGFDTDloSUdK?=
 =?utf-8?Q?89GDk+?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2025 21:09:06.5388
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ea959538-be88-4ff2-4705-08ddfa1c442c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF0001709B.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7227

On 9/18/2025 4:17 AM, alejandro.lucero-palau@amd.com wrote:
> From: Alejandro Lucero <alucerop@amd.com>
> 
> Type3 relies on mailbox CXL_MBOX_OP_IDENTIFY command for initializing
> memdev state params which end up being used for DPA initialization.
> 
> Allow a Type2 driver to initialize DPA simply by giving the size of its
> volatile hardware partition.
> 
> Move related functions to memdev.
> 
> Add sfc driver as the client.
> 
> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
> Reviewed-by: Dan Williams <dan.j.williams@intel.com>
> ---

Reviewed-by: Ben Cheatham <benjamin.cheatham@amd.com>

