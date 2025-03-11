Return-Path: <netdev+bounces-174017-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 804B6A5D06A
	for <lists+netdev@lfdr.de>; Tue, 11 Mar 2025 21:07:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 20765189F80F
	for <lists+netdev@lfdr.de>; Tue, 11 Mar 2025 20:07:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C844264A66;
	Tue, 11 Mar 2025 20:06:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="taxktK2y"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2069.outbound.protection.outlook.com [40.107.220.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA046264A6B;
	Tue, 11 Mar 2025 20:06:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741723614; cv=fail; b=f+hwFhKuKLWPDRAmGwm2+po6sPNtJI9hN2QKFpTu9S4cdBDW9dkXzgIU2tSOM3cUoRW9BW11zdWmM4tbqTIPDFVESuTegIaB/Wwd7Mp/IMn4cUndS0FgWW4JtOb85CR8Fi9pD9E0VOrrx+WNx35DheCQ2mbiDOCCjvSoWSzyMGE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741723614; c=relaxed/simple;
	bh=4S+FPjCeSP0k/SgCAaXYiJXnzs07lN8deD70ya/M+to=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:CC:References:
	 In-Reply-To:Content-Type; b=SEvBWJPWgvNRM+51IhiYsKPEessC5KX7Fu8b8LeaZzU3raov7kxMhLI99Yk1N+jHPVgfLh1bvdWzR3AVhoRDN+OPYu6rHyQHyIKdZMFmejeTarKuBSDtWvYJh9bBjNprHuww31TLbnKkQdcZe8HM3CtG4Zqc78EwtLQ5pGHQ/Ks=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=taxktK2y; arc=fail smtp.client-ip=40.107.220.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HfOtVRzgA1R5szq3q8l6CJtvjwRpsspTjFQBYq2iJyfddmhN/1sX3dm2E/VfRR8iQJwZLiyT4ibajHSEWVE/SDPrh2PrAcPWTyh+2o4cgc8b0Eq48uML186VYIz1TLGtZVMBRmnJa0h2NBMX5UocBn551r3taf9m5gI83oz4PmWzIiAlauQ8xem/uzlyvHdX84lbQ33hCaMK7wwRb1STkPsaEKJu1g6p5BRELevM4T/Ew0JeyqhXMwPLlF86Npuqv7dIjZxCNLm5Sd6oYWx2MxecQjT8mln2X2JIJ2PsHZMgf3/LLqkdPe4Xq4wBlbVpK+W3oWwMOCcVT3jOAX2Dvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C8AEbVBHCu/ci1ENxh1B0sQlAvD/VqqFaBoKqhW75ic=;
 b=gTu8oXk79dLW7oh3YCCanbFZgAO3g1zwzJqS51SZzyAfvJzSe/pAr7zEH7lsQU1cY/QmQpFhv7jjp8hgyEEFI4nkgvnQy7vly0xQTikiQyMQP61HP489HEciTmdDpv18H9xjohdgCCTtzZX0755XY73OHcQn3V4uI/b7bJ7MJkHmA44x8ChZSht59S1ZltD1BnPeCQyglcrGLn2W4Wnd+8qp3YuZ4Bs4bql2Thfr75bxPbPlt4lHJcPXgH8nWWKgWPc4B6BAHoIKaGKGkckw5oRz+zIKfnI0bOJuuRRSecVZepOKdXbkHGXTje6krQDNMFygmT3qLZCHgDxcgfRDZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nvidia.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C8AEbVBHCu/ci1ENxh1B0sQlAvD/VqqFaBoKqhW75ic=;
 b=taxktK2yhM2A3UqwMEk3McVLu+P7jStU8cIJupsC6Let0AJQu5OIlnHEqQdlADjUciHevzRc/rszuAxHUrOiCvZhT9c+kxnkh5t2vUGKX1Vrgaw8DNY6xCGQHzUx3dwTG6IHVb+bc7dRurjdM6kd/x4pEnK7YkuquyxLxPW0Big=
Received: from MN0P223CA0005.NAMP223.PROD.OUTLOOK.COM (2603:10b6:208:52b::22)
 by DM4PR12MB6397.namprd12.prod.outlook.com (2603:10b6:8:b4::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Tue, 11 Mar
 2025 20:06:42 +0000
Received: from BL02EPF0001A103.namprd05.prod.outlook.com
 (2603:10b6:208:52b:cafe::80) by MN0P223CA0005.outlook.office365.com
 (2603:10b6:208:52b::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.21 via Frontend Transport; Tue,
 11 Mar 2025 20:06:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0001A103.mail.protection.outlook.com (10.167.241.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8534.20 via Frontend Transport; Tue, 11 Mar 2025 20:06:41 +0000
Received: from [10.236.184.9] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 11 Mar
 2025 15:06:39 -0500
Message-ID: <1cf1354c-a0ec-4096-a693-22168acbf51f@amd.com>
Date: Tue, 11 Mar 2025 15:06:39 -0500
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Ben Cheatham <benjamin.cheatham@amd.com>
Subject: Re: [PATCH v11 19/23] cxl: add region flag for precluding a device
 memory to be used for dax
To: <alejandro.lucero-palau@amd.com>
CC: Zhi Wang <zhiw@nvidia.com>, Jonathan Cameron
	<Jonathan.Cameron@huawei.com>, <linux-cxl@vger.kernel.org>,
	<netdev@vger.kernel.org>, <dan.j.williams@intel.com>, <edward.cree@amd.com>,
	<davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@google.com>, <dave.jiang@intel.com>, <benjamin.cheatham@amd.com>
References: <20250310210340.3234884-1-alejandro.lucero-palau@amd.com>
 <20250310210340.3234884-20-alejandro.lucero-palau@amd.com>
Content-Language: en-US
In-Reply-To: <20250310210340.3234884-20-alejandro.lucero-palau@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A103:EE_|DM4PR12MB6397:EE_
X-MS-Office365-Filtering-Correlation-Id: eef98e49-1e0b-4333-3a81-08dd60d83d1b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|82310400026|376014|7416014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WXJJN0hzOWhpWGtJbE1pVTBiQ090QXEwVTUxbHdKbGZtbjJ5WUVKb3hHaWNJ?=
 =?utf-8?B?ZHdGRnJLdjJqTlVDWHFubkgvWDJKeFdSdHdDTEFDZWRpQWFYdFJnTDlHREk1?=
 =?utf-8?B?RytWaHBjcGlackZ2NUk2YXlFTE9sSSs2dUtoOFZ6akJLSENJSG9JY2V5a01u?=
 =?utf-8?B?RnNnUXMybzdDNnhCNWtUTDlZd2lvZTRZMUZNN3dtdm9CTDdLUUJqRHcxaUd3?=
 =?utf-8?B?aDdIbGNuT3gyUElWc3FwMUIxbmU4VVYwell3bUpTRlR2QUxWenQxNU5qU2dy?=
 =?utf-8?B?dVFLem5SM3lEd29qaGdNY0dBMlRBcjJMQTJlUmh1dFE0Rk1Xdit6cFkxOExH?=
 =?utf-8?B?RU1LdTlwQ041azgzLzhWNUdxSVhoSjFUY3U1T2tzQkJLbXhwQkFWMzFDNjdQ?=
 =?utf-8?B?cWRmc2libWxod1hGKzJVOTlKSk9PL21MekJJYmZBNmhnemkyamhNYnE1UVBG?=
 =?utf-8?B?dTdDaVpMZFd0TkNQakdIZVArdEtsc2NSZ1pBaksyS29zeHM5Ty8xWVdLL2xF?=
 =?utf-8?B?VEdCUmRPeElQekNoMFlHbHJ3OHpjZnQrdW00dXR1MlhIakxiMm9hTDgvSi9a?=
 =?utf-8?B?MWJ2aFlZamx1b0hhRDR5UmNQYUpvbmZMQlQrS2F1L0IrVVFiUURKTjB6YVBz?=
 =?utf-8?B?dVk2bDJSUlZhM1MrWHlJWGNoeENEckYzTGJRS2duNEVab1JZWXRsamRlYWxm?=
 =?utf-8?B?WXZDRnVpNXBMMWwveDBnc1FnWXRIVHRxS3F4eGZjYXNCNE5VVGRkV1B1aG1o?=
 =?utf-8?B?bDdmeitjc0JaUW8wekhWUEFsdTkwbGFtSTRPaTExQnVqWkhpZjJ1R2RRdjZ2?=
 =?utf-8?B?eS9HOVhaK3c5MDUxaFF0aFkyVE5UcG9XYUF0TzRMbGdTVzVRU0FicENJMTVV?=
 =?utf-8?B?VkhZcnhhWGtkajg1b3R4bTBzZzNJa2FOOUgwbXMwZjFydVZ4SUNmOEloYkJu?=
 =?utf-8?B?THhIOU5kRll1dFJvd1N4a1dqVXFSUkJpcGVYbWdVdFRwMXFCU0IxWjJ4dmNi?=
 =?utf-8?B?RlpGN3dhRlpkNlRtajgxT29vOFRpNDVuTC9BK3J6Z2tOdHFvb0JSM3hzSWkx?=
 =?utf-8?B?N2FVZkpwV0IxKzVsa29pYUVjcDhwd3JIc0J2VC9JVCtJUlJ3Y0p6eUpaNyt2?=
 =?utf-8?B?VVAwL1FTV3djKytjMFlXU2RiK1ZCdlR4V3RzVGFFNkxkMDhJRHVFUkJEZjhy?=
 =?utf-8?B?RWJFS0JrU1hpVFREaEo1MTUvakp6QjBSZ2J3dFhySEZyMjhQQ0xtVE51Skcv?=
 =?utf-8?B?UkFWQWt4Y1V1dG5GQWtzTjVDZ2RBSXZlVVh3aDRxSlhpb0swUzU4bi91WUVo?=
 =?utf-8?B?WW0wV21reVRaaEVOSTcwU2VsYm1qQlltUlRERHpWTTZ0VUhNSW1IL0E3WUhF?=
 =?utf-8?B?dWFLcjdTTmdFQVduZTNBSmxLc1JIM2syWHRMNktta0htbVFOWldnbGcvU08v?=
 =?utf-8?B?RFNuVXA0OFFoSWFDQ1c2SURQQi9oemtvZjZiR0dNTFArL3VhT0dSY1lLd1Nw?=
 =?utf-8?B?WnF2UGVyQk1qS1BVcm9uVGZxWHg0a1VHZWJUd21XTVBhQVI1b015NFdZbTkr?=
 =?utf-8?B?aHZ5THBGcDI2ZUs2RzZab0dwRFBYUkRlVGlTdU9EcU92ZnUrMU9vVFNhY2FT?=
 =?utf-8?B?TzRJc3lhVWdiMFEvSWlJMWtUQ3BVWTdwNWZ5aGFrajlFMFVYVlRFS0xnVjJw?=
 =?utf-8?B?QW9CZVJUdnhFNlI0YlJ2UEdnbGtZVUlTVGJDYTUvZ2RMWkZ0ZWpKdTJyVW9n?=
 =?utf-8?B?WndpS1B1NGJBOE5qQWxJRWU5TlVqRzhjNVJvTW93Wm9MaDFBZHNiV2hBSFpz?=
 =?utf-8?B?UXBpZytSU3FZd2YxUkg2aGV2THFuKzNSeXQzY2VYLzRocHlJc3R0bGcrZExj?=
 =?utf-8?B?S0hMUUtHUW53QnJwZjhSTHFkWG1RUFZmVFExdHFCOGd1enBLSmc3bmZUZjBJ?=
 =?utf-8?B?QUw4NEprSTVrd2NxWFdSTGxWdGwvc0lXbVA0S3ZNYzZ0TzNDdEpxMUNYcnF6?=
 =?utf-8?Q?8Xl9S9IIfe3LZvaCbj4aMx2Jkb/778=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2025 20:06:41.0406
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: eef98e49-1e0b-4333-3a81-08dd60d83d1b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A103.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6397

On 3/10/25 4:03 PM, alejandro.lucero-palau@amd.com wrote:
> From: Alejandro Lucero <alucerop@amd.com>
> 
> By definition a type2 cxl device will use the host managed memory for
> specific functionality, therefore it should not be available to other
> uses. However, a dax interface could be just good enough in some cases.
> 
> Add a flag to a cxl region for specifically state to not create a dax
> device. Allow a Type2 driver to set that flag at region creation time.
> 
> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
> Reviewed-by: Zhi Wang <zhiw@nvidia.com>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---

Reviewed-by: Ben Cheatham <benjamin.cheatham@amd.com>

