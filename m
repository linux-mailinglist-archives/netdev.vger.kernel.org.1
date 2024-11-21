Return-Path: <netdev+bounces-146597-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C89F39D4846
	for <lists+netdev@lfdr.de>; Thu, 21 Nov 2024 08:44:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 531901F22518
	for <lists+netdev@lfdr.de>; Thu, 21 Nov 2024 07:44:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D21B61A727D;
	Thu, 21 Nov 2024 07:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Li8iUS1H"
X-Original-To: netdev@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2068.outbound.protection.outlook.com [40.107.102.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BB3A4317E;
	Thu, 21 Nov 2024 07:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732175067; cv=fail; b=r5ConR8VzkOGC96Bilmf1qVMrkfOgr17bRcACqkWYceVIUOJzQiSgyp5X3xc0qk8X0zLJEtJ1jU+hDrgU/YRzJmjD0pPzcBkBzJfhcGQp+drjD7EfmV7Q8hYjaZL+2i2acnB4rG7oiqaQujxAlDYYv9c+rR9wkvu7jWzMbxwid0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732175067; c=relaxed/simple;
	bh=nHsvhtwTVOmPjzlzvS/5wkd+LU1nH+Vs8JQwSdgCWyw=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rkhOk7ZPOWhn8ABUWcnQqSP1wO75oKpBMM8PxIkRpR9sDIySEd/oSbHr2HRbitIyZRGdsWPn90pYUJLm1AM9t6MFEUU5b398Bgcr246jMEmVj7V1CML4iCtvdha0zWmAn2i03vBAMg+nIyLeT1pvnS/F9WkXXJLChb95omkl18k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Li8iUS1H; arc=fail smtp.client-ip=40.107.102.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vVOCCmJqRlNouRpYRHUYoV4byt+XTHn+nkUw6mvXQ/1/11dK4kMd/DfzyW9k31nKKdMbI25SFIojyeF97cYtjpaLLcno8Y/kpxhJ97StxRmXKjqMYEypK+2oh5FVl4v4jVCOCqv0Cy4Q+pc2qIxAMvl2yxtoE2ElL3STKqw5xVSPRQdKkCwSyJTI3F4ZdSR5rvNK5dosCnhbe5qBrPN8t5Z/eFrQL7CSmc7Pzma1f883wy/Ez9amOsEgBKRrsc3v/XQRP7JoJAckIimPWcT6LPCM8Hw9U+YpBPIaQMzYq8B/LIaYVRuAahtjz8bBrZQuWXhKuE0flSZ1DTG8h0XSJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nHsvhtwTVOmPjzlzvS/5wkd+LU1nH+Vs8JQwSdgCWyw=;
 b=HGv6lcmj+sYlPIGcwDG8MloJKohEDtW9paE33ahV+amBiMffol9TgDhdg0RrzZ5m7OKv0qpcInc3mh1sim6faVvh/CFE8XVlVXsO0BpHl8ZJCNgDmMlhyBliptVLG6PReS6l8yU0jMrHv+1nIDTCFZQZ9Wu1tvOPgzMYBHuzXfxRKiKUmwuGh7Fw75zRPojqtCWVZ8g+lu1rBDNC8wAuiyVfilDbmmUnxXI8/F7ocL49a2SZfvyVQhEdTbz6OgAU15JS9oeMbc/Xis7UWjakG+5dBwc86cnTj5a6p+5H4BmrtgptwdVc3fLCZt0OqpAYrrGgIy3mVGPf4t0w9uSuBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nHsvhtwTVOmPjzlzvS/5wkd+LU1nH+Vs8JQwSdgCWyw=;
 b=Li8iUS1Hlm8DvgTTSLB2s060Wo2xSTjLG5d6LmkuY2zetJ2/x4VJRmiAfR7Q3EhBsGadxc4AD1tlW8m7OJF6fd/2GUgmLMkEbLIwJVNh2sjrerK1oclXwatfUfGWn9XljO3340boIuDBcWS7cE5gDEMeM8uBAMUa1J0d4a52Av2nrpDqBZTqwCu9VDSXTCKOHbQuoXJnZ/EqyWmFh2TWFtEjwZYUaIm48Wm4yGLaE/EIFR4d2cHn18BheWSDwc0fwPJGUbecHygoHZ5JaPsSePm2wyzFDgs/TjO9rKT4aVcIOIIdTUPeHvQgV5VjNC/XlsyLqpkGkHEXYy2l88eqRA==
Received: from MW4PR03CA0265.namprd03.prod.outlook.com (2603:10b6:303:b4::30)
 by LV2PR12MB5799.namprd12.prod.outlook.com (2603:10b6:408:179::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.22; Thu, 21 Nov
 2024 07:44:15 +0000
Received: from CO1PEPF000044F9.namprd21.prod.outlook.com
 (2603:10b6:303:b4:cafe::3c) by MW4PR03CA0265.outlook.office365.com
 (2603:10b6:303:b4::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8158.24 via Frontend Transport; Thu,
 21 Nov 2024 07:44:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CO1PEPF000044F9.mail.protection.outlook.com (10.167.241.199) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8207.0 via Frontend Transport; Thu, 21 Nov 2024 07:44:14 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 20 Nov
 2024 23:44:00 -0800
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 20 Nov
 2024 23:44:00 -0800
Received: from localhost (10.127.8.9) by mail.nvidia.com (10.129.68.10) with
 Microsoft SMTP Server id 15.2.1544.4 via Frontend Transport; Wed, 20 Nov 2024
 23:43:57 -0800
Date: Thu, 21 Nov 2024 09:43:58 +0200
From: Zhi Wang <zhiw@nvidia.com>
To: Dave Jiang <dave.jiang@intel.com>
CC: Alejandro Lucero Palau <alucerop@amd.com>,
	<alejandro.lucero-palau@amd.com>, <linux-cxl@vger.kernel.org>,
	<netdev@vger.kernel.org>, <dan.j.williams@intel.com>,
	<martin.habets@xilinx.com>, <edward.cree@amd.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>
Subject: Re: [PATCH v5 13/27] cxl: prepare memdev creation for type2
Message-ID: <20241121094358.00002bb7@nvidia.com>
In-Reply-To: <1a788b8b-48b8-4853-906f-97af5952ce21@intel.com>
References: <20241118164434.7551-1-alejandro.lucero-palau@amd.com>
	<20241118164434.7551-14-alejandro.lucero-palau@amd.com>
	<75e8c64e-5d0c-4ebf-843e-e5e4dd0aa5ec@intel.com>
	<20241119220605.00005808@nvidia.com>
	<4fc8fd99-f349-47f9-8f5e-d4c393370ada@intel.com>
	<e2e4136c-87ec-7e4a-d576-8c0002572893@amd.com>
	<1a788b8b-48b8-4853-906f-97af5952ce21@intel.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.38; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F9:EE_|LV2PR12MB5799:EE_
X-MS-Office365-Filtering-Correlation-Id: b663da28-849b-4300-ae68-08dd0a004bc8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|376014|7416014|82310400026|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?REtySHAxNURVSlZFUGpydm0wekRCdFY3UmdPSCtEejBDNjFFdWRqRXE4eTBG?=
 =?utf-8?B?SFFyWnA2SG1LeittZE1wRGgxMHUrT09Ock9uNEFmTExzYXJoWUdzRmRCeHpW?=
 =?utf-8?B?bEpDaVZyNUhWOFNiWlN5UmNWVHBkY1J5ckEzV2dFQWQ5MThBVDA5Umh4SWoz?=
 =?utf-8?B?ajV6QnZ1U0k0TVRRSC9odzdQSVpsOW9ERXRmLzhoRXIvWVVNeHA1N2gvWGg1?=
 =?utf-8?B?WnhERmZKNkpuU3NnTFlJNS9Ib0tYZFFUdG1OM2l0eFpyUGlxSkFzSVE4eXdR?=
 =?utf-8?B?RmJjc1RFVHVhamtNU015Q01rYUVBb2ZOU2xod0wvQTMrTlZ6WXVHNWxpZlpv?=
 =?utf-8?B?d1NNWEphZlNsb1c3bEpQVjFpeVVrZUNZUStmKzlKZ0dSaUwxbStmZVdnaU15?=
 =?utf-8?B?cm9JRXV3Z2xzQWpraVdUZkhBTHA0ZHFWUUJWVmRnUENjUmVvNVp5K0pleW9G?=
 =?utf-8?B?QnpseGpQcUR0Z1VrZkYzVWd0QWxVdjBIUnNXV2hKcW4zRXF0WVErUFJZN1Iy?=
 =?utf-8?B?QmpQdEJvRWpZVVR1NFRsQVg4dDFnb1ZIcUNZRklPL1hWd012WjQxVGVEWHo4?=
 =?utf-8?B?NUxieHh6Q1M4ZEVxZlVkK2RRRVdRZERtRkJYeGZkT0QyZmxuK1U3ZDdXZ0c5?=
 =?utf-8?B?TFFkQVRKSCtsT0s4WVprNkRaQkdDMVMzaVhZZW5uK2VkLzJFSThmRmJXMDlV?=
 =?utf-8?B?RVRuS0xrQld3UnlDOHdOalVOYVpvQnp1Y2VUMnppVS9mbTRaV21WeTdTYUF1?=
 =?utf-8?B?WFpRK0UyczBXdDRiN1Jwck9nWEY0OVl3c1E1enRhQkZaUGhacHp1ZWNvUHMr?=
 =?utf-8?B?dFBNMlM1T2o3OWorSXJ1ZXU3VC9WVFFNd3ZMNlR1Q1l3SDBaVjFJejVtRzgy?=
 =?utf-8?B?UldmYzRrbC96VnJCVWcxZG5zWTU2WEtkL0ROdk1WNjVQazlSOFJaRWQ2SGNQ?=
 =?utf-8?B?RW1PM3RDcnl3NHZoNkFBRElIQ0VRTi9zczhEK0J1U3hmeE9OM0lMMWRnT3h6?=
 =?utf-8?B?cU5ETGF6eUFaMnlIbE4vZEdOMWUzVTloUjlVR1RpUElPajVxY3RFdVorSUh6?=
 =?utf-8?B?ajNqQWJlTGgrZW53YVZQYTlUb0JCVjBoTmFKcFVNN1JoeHRlUktiVGZDbkFk?=
 =?utf-8?B?M3NxQjluNFhWQnd2S2gzZFNydHgxMlc5bjBTc2RnaEhwYXRPOTNreXMzZ3Iz?=
 =?utf-8?B?Q0E5cTRwcmd1SzdsanFkZGtVN2RUZWF5Z2l4Y0xkU0ZQdTdDZFNjQmxzNCtz?=
 =?utf-8?B?NEt3RFN5Mml0eHNUOUIvWU9vaGlaYzRiVWZxajdwaHhTb2ptQ2c1c0d2dzFz?=
 =?utf-8?B?T3M5QkVObURzRUJyWHdWV3VidUpxankySCtYaWVkbmFNaUNkZlUrdU1CN2JP?=
 =?utf-8?B?QjBiSEVtaS9tS2RoS2w0L0gwWWtWTy9NYUw0WWdCcW1FTk8vd1poK01lSFk5?=
 =?utf-8?B?L0VJMDlza1hOVFZWeTNheGZlWk9jNU5Za29tdHFLd0Uwd0hJY3p6RXovTmpm?=
 =?utf-8?B?eU5BdDk0bnRjQ3FXWmNCdzRDUldvVHhYTll0ZENPcEhGb3E0emRDQlI3dHd5?=
 =?utf-8?B?R3MxeHJBRVMraVIrSVN1WjBNRjVMU1hyUFpMbXRieE5tQmgwVTU3Wi91NXVP?=
 =?utf-8?B?b0MrTHpTRHArd3UyeEV2eWE5MG5GWldyVEVZbnR0VDFjTFBEVHBwNjNqWG5Q?=
 =?utf-8?B?cmNoWFdCOU9iRy9Mck9kZkVUZStQSmxoOXVHMHJUMmZqWmFLanQ3c3ZxWndS?=
 =?utf-8?B?MnVmRnNjdG5pTDdDVTJuNnBQRGN0b0dLeGNSUlBmNEtuKzdqOGNITmNBV2FT?=
 =?utf-8?B?YVd2QndFcEJDcVhSM1ZibVFrbzV1cFhXS1pBK0c1ZzdwNjBIVTdVaDFiYU5T?=
 =?utf-8?B?T3R5YVQ5TXl3NWdZR1NCRzRMbytKYXpkZHBXc2ZxeklFS1E9PQ==?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(7416014)(82310400026)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Nov 2024 07:44:14.3261
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b663da28-849b-4300-ae68-08dd0a004bc8
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000044F9.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5799

On Wed, 20 Nov 2024 10:15:59 -0700
Dave Jiang <dave.jiang@intel.com> wrote:

>=20
>=20
> On 11/20/24 6:57 AM, Alejandro Lucero Palau wrote:
> >=20
> > On 11/19/24 21:27, Dave Jiang wrote:
> >>
> >> On 11/19/24 1:06 PM, Zhi Wang wrote:
> >>> On Tue, 19 Nov 2024 11:24:44 -0700
> >>> Dave Jiang <dave.jiang@intel.com> wrote:
> >>>
> >>>>
> >>>> On 11/18/24 9:44 AM, alejandro.lucero-palau@amd.com wrote:
> >>>>> From: Alejandro Lucero <alucerop@amd.com>
> >>>>>
> >>>>> Current cxl core is relying on a CXL_DEVTYPE_CLASSMEM type device
> >>>>> when creating a memdev leading to problems when obtaining
> >>>>> cxl_memdev_state references from a CXL_DEVTYPE_DEVMEM type. This
> >>>>> last device type is managed by a specific vendor driver and does
> >>>>> not need same sysfs files since not userspace intervention is
> >>>>> expected.
> >>>>>
> >>>>> Create a new cxl_mem device type with no attributes for Type2.
> >>>>>
> >>>>> Avoid debugfs files relying on existence of clx_memdev_state.
> >>>>>
> >>>>> Make devm_cxl_add_memdev accesible from a accel driver.
> >>>>>
> >>>>> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
> >>>>> ---
> >>>>> =C2=A0 drivers/cxl/core/cdat.c=C2=A0=C2=A0 |=C2=A0 3 +++
> >>>>> =C2=A0 drivers/cxl/core/memdev.c | 15 +++++++++++++--
> >>>>> =C2=A0 drivers/cxl/core/region.c |=C2=A0 3 ++-
> >>>>> =C2=A0 drivers/cxl/mem.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 | 25 +++++++++++++++++++------
> >>>>> =C2=A0 include/cxl/cxl.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 |=C2=A0 2 ++
> >>>>> =C2=A0 5 files changed, 39 insertions(+), 9 deletions(-)
> >>>>>
> >>>>> diff --git a/drivers/cxl/core/cdat.c b/drivers/cxl/core/cdat.c
> >>>>> index e9cd7939c407..192cff18ea25 100644
> >>>>> --- a/drivers/cxl/core/cdat.c
> >>>>> +++ b/drivers/cxl/core/cdat.c
> >>>>> @@ -577,6 +577,9 @@ static struct cxl_dpa_perf
> >>>>> *cxled_get_dpa_perf(struct cxl_endpoint_decoder *cxle struct
> >>>>> cxl_memdev_state *mds =3D to_cxl_memdev_state(cxlmd->cxlds); struct
> >>>>> cxl_dpa_perf *perf;
> >>>>> +=C2=A0=C2=A0=C2=A0 if (!mds)
> >>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return ERR_PTR(-EINVAL);
> >>>>> +
> >>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 switch (mode) {
> >>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 case CXL_DECODER_RAM:
> >>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 perf =3D &md=
s->ram_perf;
> >>>>> diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
> >>>>> index d746c8a1021c..df31eea0c06b 100644
> >>>>> --- a/drivers/cxl/core/memdev.c
> >>>>> +++ b/drivers/cxl/core/memdev.c
> >>>>> @@ -547,9 +547,17 @@ static const struct device_type
> >>>>> cxl_memdev_type =3D { .groups =3D cxl_memdev_attribute_groups,
> >>>>> =C2=A0 };
> >>>>> =C2=A0 +static const struct device_type cxl_accel_memdev_type =3D {
> >>>>> +=C2=A0=C2=A0=C2=A0 .name =3D "cxl_memdev",
> >>>>> +=C2=A0=C2=A0=C2=A0 .release =3D cxl_memdev_release,
> >>>>> +=C2=A0=C2=A0=C2=A0 .devnode =3D cxl_memdev_devnode,
> >>>>> +};
> >>>>> +
> >>>>> =C2=A0 bool is_cxl_memdev(const struct device *dev)
> >>>>> =C2=A0 {
> >>>>> -=C2=A0=C2=A0=C2=A0 return dev->type =3D=3D &cxl_memdev_type;
> >>>>> +=C2=A0=C2=A0=C2=A0 return (dev->type =3D=3D &cxl_memdev_type ||
> >>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dev->type =3D=3D &cxl_a=
ccel_memdev_type);
> >>>>> +
> >>>>> =C2=A0 }
> >>>>> =C2=A0 EXPORT_SYMBOL_NS_GPL(is_cxl_memdev, CXL);
> >>>> Does type2 device also exports a CDAT?
> >>>>
> >>> Yes. Type2 can also export a CDAT.
> >> Thanks! Probably should have the split out helpers regardless.
> >=20
> >=20
> > Maybe, but should not we wait until that is required? I did not see the=
 need for adding them with this patchset.
>=20
> Sure. I think my concern is with paths that apply only to one type but no=
t the other. If you have not encountered any then we can wait.
>=20

Agree.

I was thinking that for long-term, maybe CDAT routines shouldn't be tied to
device type, for me, it is like a cap that can be probed-and-used. E.g.
when talking with DOE, the core knows if CDAT is available or not, similar
case when the core tries to reach it via mailbox.

Z.
> DJ
>=20
> >=20
> >=20
> >>>> I'm also wondering if we should have distinctive helpers:
> >>>> is_cxl_type3_memdev()
> >>>> is_cxl_type2_memdev()
> >>>>
> >>>> and is_cxl_memdev() is just calling those two helpers above.
> >>>>
> >>>> And if no CDAT is exported, we should change the is_cxl_memdev() to
> >>>> is_cxl_type3_memdev() in read_cdat_data().
> >>>>
> >>>> DJ
> >>>>
> >>>>> =C2=A0 @@ -660,7 +668,10 @@ static struct cxl_memdev
> >>>>> *cxl_memdev_alloc(struct cxl_dev_state *cxlds, dev->parent =3D
> >>>>> cxlds->dev; dev->bus =3D &cxl_bus_type;
> >>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dev->devt =3D MKDEV(cxl_mem_major, c=
xlmd->id);
> >>>>> -=C2=A0=C2=A0=C2=A0 dev->type =3D &cxl_memdev_type;
> >>>>> +=C2=A0=C2=A0=C2=A0 if (cxlds->type =3D=3D CXL_DEVTYPE_DEVMEM)
> >>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dev->type =3D &cxl_acce=
l_memdev_type;
> >>>>> +=C2=A0=C2=A0=C2=A0 else
> >>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dev->type =3D &cxl_memd=
ev_type;
> >>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 device_set_pm_not_required(dev);
> >>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 INIT_WORK(&cxlmd->detach_work, detac=
h_memdev);
> >>>>> =C2=A0 diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/re=
gion.c
> >>>>> index dff618c708dc..622e3bb2e04b 100644
> >>>>> --- a/drivers/cxl/core/region.c
> >>>>> +++ b/drivers/cxl/core/region.c
> >>>>> @@ -1948,7 +1948,8 @@ static int cxl_region_attach(struct
> >>>>> cxl_region *cxlr, return -EINVAL;
> >>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> >>>>> =C2=A0 -=C2=A0=C2=A0=C2=A0 cxl_region_perf_data_calculate(cxlr, cxl=
ed);
> >>>>> +=C2=A0=C2=A0=C2=A0 if (cxlr->type =3D=3D CXL_DECODER_HOSTONLYMEM)
> >>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 cxl_region_perf_data_ca=
lculate(cxlr, cxled);
> >>>>> =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (test_bit(CXL_REGION_F_AUT=
O, &cxlr->flags)) {
> >>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int i;
> >>>>> diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
> >>>>> index a9fd5cd5a0d2..cb771bf196cd 100644
> >>>>> --- a/drivers/cxl/mem.c
> >>>>> +++ b/drivers/cxl/mem.c
> >>>>> @@ -130,12 +130,18 @@ static int cxl_mem_probe(struct device *dev)
> >>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dentry =3D cxl_debugfs_create_dir(de=
v_name(dev));
> >>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 debugfs_create_devm_seqfile(dev, "dp=
amem", dentry,
> >>>>> cxl_mem_dpa_show);
> >>>>> -=C2=A0=C2=A0=C2=A0 if (test_bit(CXL_POISON_ENABLED_INJECT,
> >>>>> mds->poison.enabled_cmds))
> >>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 debugfs_create_file("in=
ject_poison", 0200, dentry,
> >>>>> cxlmd,
> >>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &cxl_poison_inject_fops);
> >>>>> -=C2=A0=C2=A0=C2=A0 if (test_bit(CXL_POISON_ENABLED_CLEAR,
> >>>>> mds->poison.enabled_cmds))
> >>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 debugfs_create_file("cl=
ear_poison", 0200, dentry,
> >>>>> cxlmd,
> >>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &cxl_poison_clear_fops);
> >>>>> +=C2=A0=C2=A0=C2=A0 /*
> >>>>> +=C2=A0=C2=A0=C2=A0=C2=A0 * Avoid poison debugfs files for Type2 de=
vices as they
> >>>>> rely on
> >>>>> +=C2=A0=C2=A0=C2=A0=C2=A0 * cxl_memdev_state.
> >>>>> +=C2=A0=C2=A0=C2=A0=C2=A0 */
> >>>>> +=C2=A0=C2=A0=C2=A0 if (mds) {
> >>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (test_bit(CXL_POISON=
_ENABLED_INJECT,
> >>>>> mds->poison.enabled_cmds))
> >>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 debugfs_create_file("inject_poison", 0200,
> >>>>> dentry, cxlmd,
> >>>>> +
> >>>>> &cxl_poison_inject_fops);
> >>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (test_bit(CXL_POISON=
_ENABLED_CLEAR,
> >>>>> mds->poison.enabled_cmds))
> >>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 debugfs_create_file("clear_poison", 0200,
> >>>>> dentry, cxlmd,
> >>>>> +
> >>>>> &cxl_poison_clear_fops);
> >>>>> +=C2=A0=C2=A0=C2=A0 }
> >>>>> =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 rc =3D devm_add_action_or_res=
et(dev, remove_debugfs, dentry);
> >>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (rc)
> >>>>> @@ -219,6 +225,13 @@ static umode_t cxl_mem_visible(struct kobject
> >>>>> *kobj, struct attribute *a, int n) struct cxl_memdev *cxlmd =3D
> >>>>> to_cxl_memdev(dev); struct cxl_memdev_state *mds =3D
> >>>>> to_cxl_memdev_state(cxlmd->cxlds);
> >>>>> +=C2=A0=C2=A0=C2=A0 /*
> >>>>> +=C2=A0=C2=A0=C2=A0=C2=A0 * Avoid poison sysfs files for Type2 devi=
ces as they rely
> >>>>> on
> >>>>> +=C2=A0=C2=A0=C2=A0=C2=A0 * cxl_memdev_state.
> >>>>> +=C2=A0=C2=A0=C2=A0=C2=A0 */
> >>>>> +=C2=A0=C2=A0=C2=A0 if (!mds)
> >>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return 0;
> >>>>> +
> >>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (a =3D=3D &dev_attr_trigger_poiso=
n_list.attr)
> >>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!test_bi=
t(CXL_POISON_ENABLED_LIST,
> >>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 mds->poison.enabled_cmds))
> >>>>> diff --git a/include/cxl/cxl.h b/include/cxl/cxl.h
> >>>>> index 6033ce84b3d3..5608ed0f5f15 100644
> >>>>> --- a/include/cxl/cxl.h
> >>>>> +++ b/include/cxl/cxl.h
> >>>>> @@ -57,4 +57,6 @@ int cxl_pci_accel_setup_regs(struct pci_dev
> >>>>> *pdev, struct cxl_dev_state *cxlds); int
> >>>>> cxl_request_resource(struct cxl_dev_state *cxlds, enum cxl_resource
> >>>>> type); int cxl_release_resource(struct cxl_dev_state *cxlds, enum
> >>>>> cxl_resource type); void cxl_set_media_ready(struct cxl_dev_state
> >>>>> *cxlds); +struct cxl_memdev *devm_cxl_add_memdev(struct device
> >>>>> *host,
> >>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct c=
xl_dev_state
> >>>>> *cxlds); #endif
> >>>>
>=20
>=20


