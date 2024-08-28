Return-Path: <netdev+bounces-122777-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C3A99962841
	for <lists+netdev@lfdr.de>; Wed, 28 Aug 2024 15:08:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 48C0D1F21F79
	for <lists+netdev@lfdr.de>; Wed, 28 Aug 2024 13:08:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7727417C223;
	Wed, 28 Aug 2024 13:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="cRMB/7Va"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2055.outbound.protection.outlook.com [40.107.94.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEE531862B3;
	Wed, 28 Aug 2024 13:08:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724850510; cv=fail; b=R6c/t/K4vAqxMM7pdttPQjmH+RS9bFgBWgl9tFWPzIqJTWSLgex0lwDU7MR2rX2EeiVbzmLDWPaRAOdadqoMuVzpuZDuT4GVIvC7n+TmfP5My83+XYRIXWrI5n0YxeHoJph6kijwiAvD4MIfMZ/9aA6oPvEzsReME5aI1FN5WN0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724850510; c=relaxed/simple;
	bh=Z4YJ2IluvK3A53Myn1BCmUIP5HVKifPeE9ZkCEGk+FA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=L1HgK8hDUNoySNmdEGyhmcDPjDBB/Gs8NOCBPc1Oc6drGEU9SeWo2FTWcfLkwOwc0vMezVq0fp5hxr/TNZCbMPjVQI0SjoBmk+TVwGBO1N7S816yI/gcAoOJv7mlit+XiBIqnpXjrAYe83vOirDEKO/UiQngn4SnrZQTFYzFY7s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=cRMB/7Va; arc=fail smtp.client-ip=40.107.94.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=u2gCPLmHQNGAUnM/ln20HS0b5jtGrdTDgfslIMOdHjnGhpcGXxA1LHEsgqMF4YikKapfDMY7Jy+HgvcqNWfFi++ib1Okw6lfx9uPIEylCJY5pR0l9r3I/jHgsl3YOY0nxjmYtRYZUoMowxs5lkNzLWnhE5KxMXycpRK7GIyqNHWL8Y9P1Q5q9JoZln6MCOsnVPGR5Sll1KhIRZtn2+6REq7crgeXdTJbQ2o7drtG1Ndi7FKRcv13loZEemyjjlvrbws1ehoGwp7pBQSchbULfGAEGGL7xDo9CEretEwajh3UaJQGYe6JcEsdFhxaQS9O5ITlvCXH/ZLT61M6UjRJcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gWhwurftU8MgZgvYjMhKTFTtZFnrMWCueHDxarAz1zU=;
 b=ca5ZTQIDHF3aBnt/5vf+vx+QX5gL9/HmbZvzWdfThurr+uhwxUbuBA62hr518a2t5KERG+kk9+v2445j/Ma3dBV+LvzWAXMTTcbFu5/WsjWnynRjS5EvRtFEzJlT+Z8CZVwdL4Lm0hX4qZ9UJT/GKIX4lQOoLnEBaLF/jba0lrogI/EbC9EQ/Ck+CIB38U+0WowTktvxUAdbppi9VblTyLNMXBAMtNooN8awU2pLU1YfHdfkKuSKcKElAXU/lA+rhXxtdNuoo6L26ti6PkqI2R+Ia09Vk+8F2LKY61XRY8R8n17oMrwWyaP4lJOBxhFOh9kDcsay8/c1P6w/3fHkqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gWhwurftU8MgZgvYjMhKTFTtZFnrMWCueHDxarAz1zU=;
 b=cRMB/7VaXvw7+1WEH/SzdmLfkAzTxrsD2F2BW0RieXIvvelrgIrw9/9I3Ff9Jt8c92ug2s4zbd3n55bF6e7s1u0j5IpywefbjosqcPFlK4EVDW04K2yLjvjQPUZ0g49PwQidz/XwcsUN5ApAyqhln4APCGHNLpCaq0q+x9KdJVA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4202.namprd12.prod.outlook.com (2603:10b6:5:219::22)
 by SA1PR12MB7344.namprd12.prod.outlook.com (2603:10b6:806:2b7::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.25; Wed, 28 Aug
 2024 13:08:26 +0000
Received: from DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79]) by DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79%4]) with mapi id 15.20.7897.027; Wed, 28 Aug 2024
 13:08:26 +0000
Message-ID: <1bdc02f0-c97b-c5d6-af04-c560ab3dc578@amd.com>
Date: Wed, 28 Aug 2024 14:08:18 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2 09/15] cxl: define a driver interface for HPA free
 space enumaration
Content-Language: en-US
To: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Cc: alejandro.lucero-palau@amd.com, linux-cxl@vger.kernel.org,
 netdev@vger.kernel.org, dan.j.williams@intel.com, martin.habets@xilinx.com,
 edward.cree@amd.com, davem@davemloft.net, kuba@kernel.org,
 pabeni@redhat.com, edumazet@google.com, richard.hughes@amd.com
References: <20240715172835.24757-1-alejandro.lucero-palau@amd.com>
 <20240715172835.24757-10-alejandro.lucero-palau@amd.com>
 <20240804185756.000046c5@Huawei.com>
 <446d8183-d334-bf5c-8ba8-de957b7e8edb@amd.com>
 <20240828122613.000032e9@Huawei.com>
From: Alejandro Lucero Palau <alucerop@amd.com>
In-Reply-To: <20240828122613.000032e9@Huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P265CA0127.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2c6::18) To DM6PR12MB4202.namprd12.prod.outlook.com
 (2603:10b6:5:219::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4202:EE_|SA1PR12MB7344:EE_
X-MS-Office365-Filtering-Correlation-Id: 18b13e4b-ff4c-4358-4866-08dcc76280ad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UCsyZ2FXQ1N2MUtkR09NM3ZrRkR4Rzc5UWg3aVpDQUJsWERDRWY3NUVFOEJ0?=
 =?utf-8?B?ODJHZllmRDJQVFhJM2k3U013cTl2N3NqYlNKb0lBUW91bUhVdzB1Qjl5ZmU3?=
 =?utf-8?B?c2FQbnNqYTN5azM5eVQ4dkJ6MzJ5ZnJJZDNHdFdmZG1BaElGK0ZXL0JyT2NT?=
 =?utf-8?B?UjlyTUNpbFYxeWpBckNOV0UyNFpVVXExL2kzZmNGTmdwckRhSk92Q3pOTmJR?=
 =?utf-8?B?cktZYUxJbWo4SjdYUXQrL2U0NW1reDFndElMUVZDcHF4QmxhVTFId2JvZ0Rl?=
 =?utf-8?B?Z3hUUW1kQ00zM3pwMWh4bXlTRWlIWExXRjl4cGVianlPcGJvWkdZNHk2c3o3?=
 =?utf-8?B?NnhPcVRDUmorZlhpeit1NXpxZ3FkM2lNSEx0RlZqZlhSN2ZvVGU3T0EvbGJX?=
 =?utf-8?B?ZmZNLzRYQnpCOFNsSnA3K25JOSs2cWxxREpJbmdFNHZqVEphcFV6Z2VONzVt?=
 =?utf-8?B?elk3STBZSytCeUpoWmJCVHpsT2NJTmNQTzVpbTV6SDloSmtnL1VQbkh6Tmhu?=
 =?utf-8?B?a0Z6WDhRWUlvRy9pYWRCRjJyLzhjbDlCa01JSFFyT2FTWkdTcFdFK2FpTXZh?=
 =?utf-8?B?eHVRR0FXb2FyUWljeGx1Q1lYTzVLTlhpVmh0SUtZZ3lSZlF4Q0N0TGFDZUFW?=
 =?utf-8?B?VXZGMkVKSFh1UVcwblp5N0VCR0trbGJOMUhaOUs0U3BmVHJ5UVMvRmFvSmNM?=
 =?utf-8?B?MGFnUENoMy83WUd4SzlXdVlxV2k2anN1SGRWMC9xYUlCcDcrSzNjWUE1YWdT?=
 =?utf-8?B?SDYydEptTlpVUnNmT1o1WW14SWJvekRTTm9DN3FLcjU3MWw2Uy9RQVFiRkt0?=
 =?utf-8?B?ZW1zb2svaVl5MTFnOHRUTnhnS0tjL05pVStFVVhSUWpIbUtLYUQ5aGtEOUJD?=
 =?utf-8?B?eXdvVmJDeGtLS3ROdzVrbnM3UEhlUDdkQjVOektOSG44SlIxcStVU3Y5T3J0?=
 =?utf-8?B?NUlYZy8xTDh4VzY1dlZ6YkNtb1Z6S2gybDkzbzBLVWFlS0gvR1BSL1VSbytm?=
 =?utf-8?B?Y3p3NlgxM05ubU5MVlBoUzdGNUJteDl0eSsxdytTaHExWXJOQnZNZ0RZNXFz?=
 =?utf-8?B?OHFpR2h1UjR1QTg5ZXNuejFJeUhwMXl5WFRxWFJ2Q0xUOUxHRkxsMFh0TXhO?=
 =?utf-8?B?aVFDUFpYb25XVE9UU2pzUUREZS9rbWJyb0tReHVvTDFoZms2cGVmYU5UZWJI?=
 =?utf-8?B?R1VmVUtPSHU2ZWJlL0dCMDYzcXo1OG53bEtGaGZQc1J2VjdJb3JLeXRQbHJ4?=
 =?utf-8?B?b2dhS2xyUXhyL0VZVkhrZlhLSWFjVDdOSG9ZdjhRQUU0NlRjYSsxNU1wQ21Q?=
 =?utf-8?B?dHllTjBDY1hKdGlKS3IrbVg3a2NHMkVqNzZVS3hNQUlXM3VtSXVKOExBVDE0?=
 =?utf-8?B?bnc2Z3FWajA2eHdmbDZMVHI1ZkFSS1doWUJOcUNDR2k1Y1VabGVSeEg4dXpJ?=
 =?utf-8?B?cmI3amFHb0Fsam5ZNkYxVG44SGU3N20rM1dxUnlkRmpzd0tPWFlRZUxZa1l1?=
 =?utf-8?B?WDhTUVlTaEdGRXJlbHlzcC92TGdJcWRoRDVjRkZUeTlNRzFUZTZ6OGl5TER2?=
 =?utf-8?B?Y0plVHZpRVlEeDNNeU9qRUx1d2tGaGpXQ2ZDVzRXanMvdDdFcFpsRit4aDVD?=
 =?utf-8?B?K2xtaENlY29VVzl2OG5TSDMwNENYOWQ3c2dUcXN4SDIwdG5yalRiOHNrNnBZ?=
 =?utf-8?B?b08xTC9ZVUU0T0dmM1hhNjZWQmVVM2piaFFycUo2Q21DYStta051Z2Z5ZEVS?=
 =?utf-8?B?Z3o1SllhVmJ2a0E4cnJJYjVNcHRrdnl2ZlBjZWYzcFk1VkNYQUN3SklnbzJQ?=
 =?utf-8?B?K05ZUi9sTUM4SXhpOUMxQT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4202.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RHErQldnM2hCUStjRzFEQUFFVVM5NnNZT1BHZ2hxclQzazhIbThpM1ZTQ1U2?=
 =?utf-8?B?b3dqS2JnbTl2VVlMWGxsRFlNUU53NndpQUVvaHgrb1NkbzljZmNqNlVkY05j?=
 =?utf-8?B?ZnI0V2RHZXdwbmRiSE1ZMFo4dlA1WlA5RWVsczNyOTIxY1NHbXhScFZUTHgx?=
 =?utf-8?B?RVIzaTBZNi82bDVpV0RGZzZrRit5T1QxcTQyT2Q0ZjJyM0NQMFkvSkZkZE9T?=
 =?utf-8?B?bE1xSnBHZUJoOXNIL1RjY2lnUHR6eWNjR29MdG45TjdRMmhBV21MV3JlNyty?=
 =?utf-8?B?cHVmZ0Q4N3dDTVBhbGZpWVQ5bnMzRGJmbkwrYStwQ3BkYkZESmZGa2x3cG55?=
 =?utf-8?B?TEg5dVQ2OC93Z3JvTHdueVBIaWhKS1pqNFpyc0ljQWxNQWdLS01GZjc5MlE2?=
 =?utf-8?B?Um13c0Fmb2RRZGVkUXhsTVRaMS9mNERqVFZ3c0dHOGpWSitxeElxemt3Tlhz?=
 =?utf-8?B?Y3MwNERzVzdxWkMyK3pXcmpnL3dYZ1FERHZzVy92b0VMb0l6QkpKaUNpU1ZX?=
 =?utf-8?B?UDgzQStacDRWMjRDSDFRbzJoa3VMSUJHNmkxci96TEFneWFXWWtNaTRJY2Jk?=
 =?utf-8?B?Y09pL2c4NXg2eEM4WTVseVBua2FoMnNYSjBjYnF3MVdpUHBidk1iQUswSE43?=
 =?utf-8?B?UVZRMkErSFJxeHR5TUVYL0JjRjZGNU9OYWVaazRQQTlEa3cxYnRDLyt6cGxp?=
 =?utf-8?B?dTJKU21SWXllQ0hKcTI0clFsOTJQWHc0aDA0bmFTZEgwVWh6a3ZRMkVidkdJ?=
 =?utf-8?B?N3lzT3VWSVJ5N0RrK0txNURYaC9SYmUxY3VWN3N5cURiZ0tGUkJNTUVaZlRE?=
 =?utf-8?B?R3VCak5ack54b2JheE5kNHhmYWdVS0NKRVVkOVBEekpjUlJObi8wclcyZFNE?=
 =?utf-8?B?OTUrYmJqdUZmZUVkNXhPMnhmRm9HOTBOeFJYREd2SXdQQWlTakQrR0d3S2FP?=
 =?utf-8?B?U3VCVGoyQjdtU0hQRFhKN1h3WU9XWTJsZkc1bk8yQnlUOWNmY202MzhiTjVO?=
 =?utf-8?B?YzhWUkFTUDJwWmxUY1ExYWRXSml2NDY4YXRtaUZOb01EdldqTHNHNzlpN1pO?=
 =?utf-8?B?RVVGZWxxdVdpVlVqcjYvV2V1SXVlTTAya1Y4WWd0NmFudTZERm9aUDJ4M2pX?=
 =?utf-8?B?Z0ZOdGVvbWd5WE0yaEpFRGRDVnZkblovaFdkYkpiczNCd1BkdUEwazEwZkZV?=
 =?utf-8?B?bXdNQ1ZXb3l1Zy83amRpeGRlNUlaWEJUdmNRY3lBSEdwaFhRZE1adHIvanlG?=
 =?utf-8?B?TG51bnRWdlJVZkUwaWlhQitMZ0ZEK0JKWjc0Q2lQdXZpaUlPZjlZZWVTM3pK?=
 =?utf-8?B?bW56SjVacTE1VmIwQ0t5VGJpUk0zUm9rMm5DN1dMZ3lYd09IeXdMaSt5VlM1?=
 =?utf-8?B?c0JDYi83SzQ5cU1ETTVqM1VueW5VUGZMSEgva2NyY1MzRmtVRWs0MWVHVHJ5?=
 =?utf-8?B?NnoxbisySDBMb3piVTY4TnErU05CS2drOEYxOC90U2FzaWFrR2txdzRHcVg1?=
 =?utf-8?B?NDFTQTJudzRRWFdNdXE0S2JtS2JGa0FXYzlRZk1JQmNYM3FJTzNsSzhlQWtL?=
 =?utf-8?B?RDlMTUd0aTlTL1hQbm92VTFFNTY2WmsrZWhNMUdTdENKTzZoRUYwOGkwUVpY?=
 =?utf-8?B?Q255ODJzaEd6UC8vTDMrbThPQm9YYXhkUGVBS0tObzc1SnhKMS85bkptSkQ3?=
 =?utf-8?B?Vm43RllHbWlaTTk4V21iL2ZWVVBvWWhnYW5sZFlWYy9aYTVzWDFHOGZXbGYy?=
 =?utf-8?B?aGdnVXo0T1E5cE9xMmVoeFBpTGNldXk5amNZR1JoNUFOK01qYm5Pb1hEbUxk?=
 =?utf-8?B?YTdiN0Rsb3lJdXYwQUxOaEJxakYyK0dnL3B1UURiRys4QW1OZ3A3T0E4bHZF?=
 =?utf-8?B?TXp6UTJ1b2w0ckV1di9IZ09XTTJ4VmkzK3pwZXRnbEp5S21lVUFoQWFvOXJX?=
 =?utf-8?B?UUlkTHJteUwyKzVsbmhwanJlUnRYbndhR3NIWnRDbXRjNnlXdXVMMnlHbWZ2?=
 =?utf-8?B?MzB4Q1FNYmNDc0pjNkhrZEluS3g4bUlhbkN1cE9jaTNmYlpXZXNNNFQzZVh2?=
 =?utf-8?B?dnZoTytnNmpHNFVzRmdoYmVOdFIxRWZqa3NVT0MwdXMwVDgxWi9SNjRhY3Zs?=
 =?utf-8?Q?5A3qwQLcjWEZUGoHxvxO+p7N8?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 18b13e4b-ff4c-4358-4866-08dcc76280ad
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4202.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2024 13:08:26.1430
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0or+ks2HVhVPk8qm93EQBUS2TtgPmkKMMejg3HZo4XFTV8VjUl2HQ5BSdubFdlreeieWqe9MrdNsgPZkQ8Bn5Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7344


On 8/28/24 12:26, Jonathan Cameron wrote:
> On Wed, 28 Aug 2024 11:41:11 +0100
> Alejandro Lucero Palau <alucerop@amd.com> wrote:
>
>> On 8/4/24 18:57, Jonathan Cameron wrote:
>>> + }
>>>> +	return 0;
>>>> +}
>>>> +
>>>> +/**
>>>> + * cxl_get_hpa_freespace - find a root decoder with free capacity per constraints
>>>> + * @endpoint: an endpoint that is mapped by the returned decoder
>>>> + * @interleave_ways: number of entries in @host_bridges
>>>> + * @flags: CXL_DECODER_F flags for selecting RAM vs PMEM, and HDM-H vs HDM-D[B]
>>>> + * @max: output parameter of bytes available in the returned decoder
>>> @available_size
>>> or something along those lines. I'd expect max to be the end address of the available
>>> region
>>
>> No really. The code looks for the biggest free hole in the HPA.
>> Returning available size does not help except from informing about the
>> "internal fragmentation".
> I worded that badly.  Intent was that to me 'max' ==  maximum address, not maximum available
> contiguous range.  max_hole or max_avail_contig maybe?
>

Let's go with max_avail_contig.

Thanks!



