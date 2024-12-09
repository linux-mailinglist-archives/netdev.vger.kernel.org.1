Return-Path: <netdev+bounces-150103-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 22FF19E8E9B
	for <lists+netdev@lfdr.de>; Mon,  9 Dec 2024 10:22:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1527E162E94
	for <lists+netdev@lfdr.de>; Mon,  9 Dec 2024 09:22:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DDD2215F7D;
	Mon,  9 Dec 2024 09:22:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ITA0iBqO"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2086.outbound.protection.outlook.com [40.107.236.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C07812CD8B;
	Mon,  9 Dec 2024 09:22:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733736144; cv=fail; b=OgQUwbjSG6JCvnmEJ6wpeL7gK1gjBy8ZAPPoPTWbNikBfelahJsU0WC45sevlEGQZsLTYab4tVMJ3lI9OWhJJsRU23yiatdY1xAPqhbICmQoKramZG+tpuSIpdtTYEFaIE5ycyWIUFJ5eOfUCSMXTbwJJDK8JHIIqp4j2fEoc/U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733736144; c=relaxed/simple;
	bh=1NnRaAT5bhIgdBe4xr7BfUx9YGr8+9Y+wAgP3oURjCM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=CBKLapqXhlzuj/v443wX3nIbpTkTewi0PWb7PviLAhKyH2YdVxu01A5RHgilfxpdoO1v7BQMBVVYDuVcLqTWjkXLAOyRMwiuy+8yu4g+/05zFfkReHHxa4M8tyv4cyAaipceqilrWBeYrXBE6EjvT0OR9WmEfx07DxyUKFtQldY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ITA0iBqO; arc=fail smtp.client-ip=40.107.236.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ttj5Fu7o+lzbbQuP821rUa7wBRPAroGyUqbtYAWgPF292kxbe+uDu5GXyj+GVBRfXnU02ybFctX5WXo2A4VSycHTLO5MMAw43ZJgebUgcIbcZPeZ3oIJX+Cf92JwGDtCoMXMNFNdP0vVx1oNvJ7WPdqPrREcvz55NyNhQWkULzJx5q0GLGphuJw4mx8uoMr6vB3oUpUaITiP4sBhZXXXo6+LR+6GDeaqmafhcesTCCXp2un7je/aglUFNP2X34JNn6sQ3Dz0ftvUrCo6VEWqAEhXDO67k8QJ2Ru2XirobQCBeA+MfEgch+fYrt+cc3qxvCFncNLLBWTdU+3cHVua/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YT9rQRyArpEx9Hf4Tfv2g+MQfG6AKsDSYucF/h2R0jI=;
 b=YGaER2JFdeOgF11DFeYnI3kBJbbd+0KAWUSBpevMxzjaSPeC6aJWcpjXAITeLCvjCQRGGSL1VPNUw0vtDD6YHTbcbs45Fz/4Z5wZrrEi4yOquwn4DCKRT6mBaTkpeONStEDTVeIIcbTDGCXQbUAZOX3102OS+Q4OIHVloipj1ii6uxi+Hi+KQYyTlIOZ+cO51ybcC0dNmNLltJA3oDzwNp2Y5ATnKYWE6nQeipftbyy9dKOnusyyUkEzU0UgCWAZ5AoDCPCO6f3TZygHp15ZPaiFPrTSJES874e0xdtAkZEH5cgC7tThFQ1/AoBLuStrWIvL3YgJkncl9ENTi8Zknw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YT9rQRyArpEx9Hf4Tfv2g+MQfG6AKsDSYucF/h2R0jI=;
 b=ITA0iBqOGzrp4e0GbfiQWDG9mk61eh9JvbgmTsiMyLugtU04MTfH27J9u29lML5oS1+sWeewRLjoGX4HnC2unlPoVfd0HkMW0Ikl0DQs1o/VmZiI/5yjD3G25k3FAuf3+bvctxZ1c8fCa5jbZTRlvc93DpiDmfj//NC3QTusZqA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4202.namprd12.prod.outlook.com (2603:10b6:5:219::22)
 by DS0PR12MB9397.namprd12.prod.outlook.com (2603:10b6:8:1bd::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.18; Mon, 9 Dec
 2024 09:22:19 +0000
Received: from DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79]) by DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79%5]) with mapi id 15.20.8230.016; Mon, 9 Dec 2024
 09:22:19 +0000
Message-ID: <96493972-2f1d-cb11-a578-e56b3f067ea2@amd.com>
Date: Mon, 9 Dec 2024 09:22:13 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v6 15/28] cxl: define a driver interface for HPA free
 space enumeration
Content-Language: en-US
To: Fan Ni <nifan.cxl@gmail.com>, alejandro.lucero-palau@amd.com
Cc: linux-cxl@vger.kernel.org, netdev@vger.kernel.org,
 dan.j.williams@intel.com, martin.habets@xilinx.com, edward.cree@amd.com,
 davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, dave.jiang@intel.com
References: <20241202171222.62595-1-alejandro.lucero-palau@amd.com>
 <20241202171222.62595-16-alejandro.lucero-palau@amd.com>
 <Z1NVInTC-fB9A7T8@mini>
From: Alejandro Lucero Palau <alucerop@amd.com>
In-Reply-To: <Z1NVInTC-fB9A7T8@mini>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PR3P191CA0039.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:102:55::14) To DM6PR12MB4202.namprd12.prod.outlook.com
 (2603:10b6:5:219::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4202:EE_|DS0PR12MB9397:EE_
X-MS-Office365-Filtering-Correlation-Id: 379c243a-e264-448b-21ae-08dd1832fa9f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Vy9QVzhWVjlMbElxdW9YNkFrSytVLzBtQm9VUGkrMzM1dnR4eFAvclFCNElX?=
 =?utf-8?B?ekdRbDNBclEyTGlJV0hJdlJzSGptWG9CS1IzWjgxeHU1THByVm8vTzRFdzgw?=
 =?utf-8?B?SlhIMGRxMm01V1FjSVcrNElQdWtNQkI0b0tpOHRpYjZETFo3c2swMjNwVW8y?=
 =?utf-8?B?c21zclY2enBqa2xsRnhad0RTSWFQNUQ2TWtLcnVwdG9NSFVQdW5oSE5aUXBO?=
 =?utf-8?B?MFIxZXQ2Skt0U0JpanVlYk5OVnpOeVdQZ2k0NU5oQjg2RDFFK1lUR29XOFhy?=
 =?utf-8?B?azlvUi8zbjY1ZFYvV1BJZzVremgwL0xYNkJGMTgySjZZRVJsOGo3L2h2UXJC?=
 =?utf-8?B?bTFqQlo5UG9PK2lqZE5TSW5IREhSSGQ1QVhOSFNIVkI1SDRSWWpNQWpkMVFN?=
 =?utf-8?B?dHhZRTlhaHkyZlVaQ2hpRVI1eXcvRk4xRXMvRC8yQjVBM2crdTVRL3Jwcm1s?=
 =?utf-8?B?QjFoeGVkRENJUnNXc0F1Wlg3b1YzcmJraUIwdTM1ZWxVa2dBalJHbnNDMHpy?=
 =?utf-8?B?R3Q5TTZ6aTFUTWx5UzNEMmtFUlk5OWhQU3dlNTdQSERUUWpKTVJzSnU0SFVL?=
 =?utf-8?B?ZVgwRVZQQUd3eWNmc3oyMmtjTUpKYk4wSnVPcjJjZEFCTGI2UEh5K01NaFdz?=
 =?utf-8?B?TnBhR0dsTy81NHhuUTRRTVR2RE5qenJnUDRlcE03U1l4SSs1dGVycWdjZjg5?=
 =?utf-8?B?QlV0MnRGaklTbGxpOWlYbFM0a2JMQ2RmdWk1QXZVd1JYNUtDL0ErdkFUaG1S?=
 =?utf-8?B?S0hxSDBHZ1FBSmpZTFhLY3dsazRKWC9Nd1dNdGVvMTM5SnBuRWNoTDF5OXVP?=
 =?utf-8?B?eGlTcWpuWTNLZzFyYlhHTy9iM3JyS2k3bGl5SWxSUHNZbzVuZ3d4RVBRWUhX?=
 =?utf-8?B?eGJ4UFdxSWRsUGFVZmhPa3hYYXJTZVQ5OUd0WStwa3d1K2hjazc4NFdwSk4r?=
 =?utf-8?B?bDFEV1NubHlWY21LN3NRbG83S3VFRzlrOFFzVEpGVXlJb0hScE1KLzNxVkpS?=
 =?utf-8?B?ckxVa0RlUmpOTHFabjQ0dWRlVHFjbURGUnNFVi8vdjhST0Y3UzYxSkkxT3FO?=
 =?utf-8?B?WldsNHRKSnJjeTB4MkgrYUZjeE14R0VSZDQ1aE56K0xKMGJIbXExNVZ5OVA2?=
 =?utf-8?B?YlN2N1IzWUlOQkZlekhlbWNtWTFkY0x5UTFzSnpOYlhiU0M3YVh3ZTRJNkF6?=
 =?utf-8?B?MGhTU29qQVIycS85WkNsU3lLQkVjU1N1bVNIN3lrZFZqMHoveE16NTdvUFpV?=
 =?utf-8?B?RitJTGhoc0QvNHhYK2tIbjVhT3k3YVpYZjk0N1B3MVdHTEpldzhPUU10T3R6?=
 =?utf-8?B?dWZRYks2L25CbVdNUmNVNCs3amxsRENQSkJQUEdsV2NjdUV1djhNNlpldkNm?=
 =?utf-8?B?SjRFM1hLWWkyWHlCdHFOSmNqbTZLbTJyUU1mWmRiMUdqRnh6Zm51emprOVpY?=
 =?utf-8?B?bll6Z1NhdWFzcHhwNFZpYllyOWZid0swWVRoY0Fscmd3WTRlSSsyeDl4QTdM?=
 =?utf-8?B?enAvZG4zZU9XcXM3UHNqQXJHcWE2ZTQxNVl5YWw5VXlWU3pGektuYjVaVUli?=
 =?utf-8?B?dUE4TUYzUnlkYXB5Q2ppa2FDbUsyeXZmRWIzSG03VWtzeTJVSzFTTnVkOTN2?=
 =?utf-8?B?ZW14aG1lMXUybkZSVEtPZW0rRkZ0YStaODRsTjI3K1dvendQOC9WL0d6MFdj?=
 =?utf-8?B?UGRlVUltYVcvdWNEd2w0M1h4aGdKWjQ2N3l6OXkrQU0rVklsNTd4R1JXZlFp?=
 =?utf-8?B?dlVuaEpBR04zMWVsZ1ZQVzNQMkFwWmtxSjJia2xiU1cvMlZGSFFQV0wzNG5N?=
 =?utf-8?Q?z8xgbP7RF7sBB9njdzlKBBH3cg0usFreq0bIM=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4202.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WWtVbEUvNVM3dElCN1g0djljRXhyWlo0bExlVmhEZGFIdzJMcDdsZ3Jqd0cv?=
 =?utf-8?B?eXBRWmV6RjZ2M2Zjc1NMYzZVSGdZZ2U2Rm4wa29WekVhRXhMN1NWOThKei9N?=
 =?utf-8?B?SGpWWHA5VXJwUXhwNVR1SEtlaVNoTUtQZVhSbnhUd3A2RFZJS3BVWHp5MFY3?=
 =?utf-8?B?bXFQV3VPT1lTbWQ3aFdYTm5zQ0Jmb0ZZQ3FqZ3pUSy9sbkQxVWRKTm5XUitq?=
 =?utf-8?B?ZnJ6UWRiSEsvVzRtY1YydlJWSHg1bWcrVXBmb3BsM1RTcnFlS0xwMVU5NDZk?=
 =?utf-8?B?VUlaUEozY1JCc2NjNlM2bXRZeTQ0STFrdThnRVk5Q0hMbndwTnlYWXVDN0FF?=
 =?utf-8?B?NHp3Z1JCT3NYdlVEQTN3eTVoRHpaNFl6b0d0dnI5TGE1bXFmVDhGUW9TRzM4?=
 =?utf-8?B?alZOeDNyZXYvUlZUTE9uVFQ3SmhYZ0srVnVKV1U3SUdPVkZqeVFhZHd0dk0y?=
 =?utf-8?B?OVJLdHdPNUVGVUg5akNLTTZydk5Gb29mTFZTa0dIM2ZLR0dycEZGT2lYY2ZW?=
 =?utf-8?B?Rzc5b1BvNDQ2YVY4UnFpZ1J1d0JsdUlTUUoySXExMlM4SDNpc3dBT04reHdI?=
 =?utf-8?B?RjV3Q1JZS2FrbC81QUxmY3l1cFVJMjNJbnpFTVFWdjBpT2FleTU4cXJINHd1?=
 =?utf-8?B?d3p1UU8rMkZwOFFtemJqMUk1QmVXR3BKQW1YN0dGZTIzeXhtU1Awc0lPeGgz?=
 =?utf-8?B?TEFzRDN4VEo4cHBIY3VRREpxcGFWYVEza2N1dmRUdmFqYk4za01vd1Y0QUJu?=
 =?utf-8?B?ZFptc1N2aVQzaldFRGpxRDlOeWZnTVBYM3NFQ051dkFBam9aSzMwSjV6RHoy?=
 =?utf-8?B?QkpaeU03NCt5T01CclAzTlRTREdvM2ljSldrVWdWS0g5YThYbVNzOEl5L3o0?=
 =?utf-8?B?SnozTWRtZWlRSURZbTBNUzFVaU4velA0bU1pRHlybytTOHl3R2dCNzlVb3ll?=
 =?utf-8?B?eVcrWlMzdUo4T3RwMDBnVENnWjJHZ294d2hEOEJZNkF6bEdrNkFOc1ZrUFlK?=
 =?utf-8?B?aVRoaDZ5Vi96SGpVTmlDWnF0Q2h6aEVFdytnVTgwS2JiN2thV0MxalV4dkVx?=
 =?utf-8?B?Ni9tTDVHU2wzN0ltbHRnRExSMkhVWk9ENWlMdmh4eUkvYjY5T2pmOGVhcjhD?=
 =?utf-8?B?YWhPQmhJNmxobFZUSDNCc2xGTFZuYldvNXRhaG5LRURpT01TakxMT0djK1ZH?=
 =?utf-8?B?bGZJeWxvOHlqR0k4Y3VqSER0MjlFM1BCZUYxWlVpMTRGdDlhdHV6TWd4VHYy?=
 =?utf-8?B?QjhjQ0NXS0N5RGhFUEZFenFmMDRnaGNLRGwxaU12cy9HNSt5UU5uMEw0RzMv?=
 =?utf-8?B?Szh5OHBaZEhqbUcvU0V1ajBEdFVmbkVLSW16SWhPaisyRlZmUFg4YjV3ZEtn?=
 =?utf-8?B?UEdrUzBVekZHL3lpU2YrNXZ1c05pS05LTkw4b0x4c1ZsZVNLOU9mdnIrbUJD?=
 =?utf-8?B?SDJ1Qm83cm5hNmJGbTkxbk9aMjdHaHlJQ21VbVR4ZHRUeTZRUlBSanRhWjE3?=
 =?utf-8?B?cU93MHNiZ3h6K3FJa2I5UEhkWTNsR0cxRmcxRmc4emRpRURqb0pZb0Y5eEw4?=
 =?utf-8?B?cDFIR1NaODQ1VkVIYlplRkU0ZCtPSzdPR2NoaFhOSnkrWFlQWXNEd3p1M2Qr?=
 =?utf-8?B?VjdVNTFuUHc4VGJ3V3dGTVE3QXR5VFREOFIxUmd6RlZhK2FzdUJWcE1lT2t0?=
 =?utf-8?B?L2IrSmoyWStvL2pwLzBDeThmcUtlTVdwSDBKR2tlYVNHMW96TlhpUnNKRmsv?=
 =?utf-8?B?dUhrcVdSNW9zcGl4MWpXcHNyMmllSitxdzFlbXNrV21rTEZtL0FscVI4OGdR?=
 =?utf-8?B?QVFzQ2dEQ2FhUWF1dWs1QWJWK0tuR3RYaDR3NFJJaFBrZlV5aTdNRkFOR1B4?=
 =?utf-8?B?UjBsV0VUQmFNZUIvSkRjQUJKT00vbDBGbWhYcUloV1p1SXljM2NXMnI0WW5t?=
 =?utf-8?B?dVVpOHBuTWkwa0UvbFRZL0dsVy9TNUZPV3hPVUI3UFhiRUlLZUtJRjlVbEhZ?=
 =?utf-8?B?ZG8vM0xPSHZYQUlFa2tIU0UranRqdUhMMmlmUEJkVWNYdjdNUFJJL3NKT0dt?=
 =?utf-8?B?ZjBxdXRjRUxrdkJwajA1RXhneEh1THRBMlV1UGEwQTJkOFN6d21jZ05ETFJI?=
 =?utf-8?Q?Fp13wugFbntTD1/ksEq1q9kxK?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 379c243a-e264-448b-21ae-08dd1832fa9f
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4202.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2024 09:22:19.0826
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WjEa+LjT6ff8lwbOJhSjfhiOYI2vlSh1BBnrKLYViwafLjP/jZUpDQE6E+SYOUyoa+/gnOHksvgNor3ykIV2eg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9397


On 12/6/24 19:48, Fan Ni wrote:
> On Mon, Dec 02, 2024 at 05:12:09PM +0000, alejandro.lucero-palau@amd.com wrote:
>> From: Alejandro Lucero <alucerop@amd.com>
>>
>> CXL region creation involves allocating capacity from device DPA
>> (device-physical-address space) and assigning it to decode a given HPA
>> (host-physical-address space). Before determining how much DPA to
>> allocate the amount of available HPA must be determined. Also, not all
>> HPA is create equal, some specifically targets RAM, some target PMEM,
>> some is prepared for device-memory flows like HDM-D and HDM-DB, and some
>> is host-only (HDM-H).
>>
>> Wrap all of those concerns into an API that retrieves a root decoder
>> (platform CXL window) that fits the specified constraints and the
>> capacity available for a new region.
>>
>> Based on https://lore.kernel.org/linux-cxl/168592159290.1948938.13522227102445462976.stgit@dwillia2-xfh.jf.intel.com/
>>
>> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
>> Co-developed-by: Dan Williams <dan.j.williams@intel.com>
>> ---
>>   drivers/cxl/core/region.c | 145 ++++++++++++++++++++++++++++++++++++++
>>   drivers/cxl/cxl.h         |   3 +
>>   include/cxl/cxl.h         |   8 +++
>>   3 files changed, 156 insertions(+)
>>
> ...
>> +	/*
>> +	 * Walk the root decoder resource range relying on cxl_region_rwsem to
>> +	 * preclude sibling arrival/departure and find the largest free space
>> +	 * gap.
>> +	 */
>> +	lockdep_assert_held_read(&cxl_region_rwsem);
>> +	max = 0;
>> +	res = cxlrd->res->child;
>> +	if (!res)
>> +		max = resource_size(cxlrd->res);
>> +	else
>> +		max = 0;
>> +
>> +	for (prev = NULL; res; prev = res, res = res->sibling) {
>> +		struct resource *next = res->sibling;
>> +		resource_size_t free = 0;
>> +
>> +		if (!prev && res->start > cxlrd->res->start) {
>> +			free = res->start - cxlrd->res->start;
>> +			max = max(free, max);
>> +		}
>> +		if (prev && res->start > prev->end + 1) {
>> +			free = res->start - prev->end + 1;
> Should it be
>      free = res->start - (prev->end + 1);
> ?
>> +			max = max(free, max);
>> +		}
>> +		if (next && res->end + 1 < next->start) {
>> +			free = next->start - res->end + 1;
> free = next->start - (res->end + 1);
>
> Fan


I do not think it is necessary except for legibility.

The only case would be res->end or prev->end above being from a resource 
defined with zero size, implying being all 1s as it would be initialized 
with 0 - 1 for an unsigned variable.

But I think we can be sure no resource with size 0 will be in the list 
walked ... But maybe we could make a sanity check here.

I'll add that.

Thanks!


>> +			max = max(free, max);
>> +		}
>> +		if (!next && res->end + 1 < cxlrd->res->end + 1) {
>> +			free = cxlrd->res->end + 1 - res->end + 1;
>> +			max = max(free, max);
>> +		}
>> +	}
>> +
>> +	dev_dbg(CXLRD_DEV(cxlrd), "%s, found %pa bytes of free space\n",
>> +		__func__, &max);
>> +	if (max > ctx->max_hpa) {
>> +		if (ctx->cxlrd)
>> +			put_device(CXLRD_DEV(ctx->cxlrd));
>> +		get_device(CXLRD_DEV(cxlrd));
>> +		ctx->cxlrd = cxlrd;
>> +		ctx->max_hpa = max;
>> +		dev_dbg(CXLRD_DEV(cxlrd), "%s, found %pa bytes of free space\n",
>> +			__func__, &max);
>> +	}
>> +	return 0;
>> +}
>> +
>> +/**
>> + * cxl_get_hpa_freespace - find a root decoder with free capacity per constraints
>> + * @endpoint: an endpoint that is mapped by the returned decoder
>> + * @flags: CXL_DECODER_F flags for selecting RAM vs PMEM, and HDM-H vs HDM-D[B]
>> + * @max_avail_contig: output parameter of max contiguous bytes available in the
>> + *		      returned decoder
>> + *
>> + * The return tuple of a 'struct cxl_root_decoder' and 'bytes available given
>> + * in (@max_avail_contig))' is a point in time snapshot. If by the time the
>> + * caller goes to use this root decoder's capacity the capacity is reduced then
>> + * caller needs to loop and retry.
>> + *
>> + * The returned root decoder has an elevated reference count that needs to be
>> + * put with put_device(cxlrd_dev(cxlrd)). Locking context is with
>> + * cxl_{acquire,release}_endpoint(), that ensures removal of the root decoder
>> + * does not race.
>> + */
>> +struct cxl_root_decoder *cxl_get_hpa_freespace(struct cxl_memdev *cxlmd,
>> +					       unsigned long flags,
>> +					       resource_size_t *max_avail_contig)
>> +{
>> +	struct cxl_port *endpoint = cxlmd->endpoint;
>> +	struct cxlrd_max_context ctx = {
>> +		.host_bridge = endpoint->host_bridge,
>> +		.flags = flags,
>> +	};
>> +	struct cxl_port *root_port;
>> +	struct cxl_root *root __free(put_cxl_root) = find_cxl_root(endpoint);
>> +
>> +	if (!is_cxl_endpoint(endpoint)) {
>> +		dev_dbg(&endpoint->dev, "hpa requestor is not an endpoint\n");
>> +		return ERR_PTR(-EINVAL);
>> +	}
>> +
>> +	if (!root) {
>> +		dev_dbg(&endpoint->dev, "endpoint can not be related to a root port\n");
>> +		return ERR_PTR(-ENXIO);
>> +	}
>> +
>> +	root_port = &root->port;
>> +	down_read(&cxl_region_rwsem);
>> +	device_for_each_child(&root_port->dev, &ctx, find_max_hpa);
>> +	up_read(&cxl_region_rwsem);
>> +
>> +	if (!ctx.cxlrd)
>> +		return ERR_PTR(-ENOMEM);
>> +
>> +	*max_avail_contig = ctx.max_hpa;
>> +	return ctx.cxlrd;
>> +}
>> +EXPORT_SYMBOL_NS_GPL(cxl_get_hpa_freespace, CXL);
>> +
>>   static ssize_t size_store(struct device *dev, struct device_attribute *attr,
>>   			  const char *buf, size_t len)
>>   {
>> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
>> index 22e787748d79..57d6dda3fb4a 100644
>> --- a/drivers/cxl/cxl.h
>> +++ b/drivers/cxl/cxl.h
>> @@ -785,6 +785,9 @@ static inline void cxl_dport_init_ras_reporting(struct cxl_dport *dport,
>>   struct cxl_decoder *to_cxl_decoder(struct device *dev);
>>   struct cxl_root_decoder *to_cxl_root_decoder(struct device *dev);
>>   struct cxl_switch_decoder *to_cxl_switch_decoder(struct device *dev);
>> +
>> +#define CXLRD_DEV(cxlrd) (&(cxlrd)->cxlsd.cxld.dev)
>> +
>>   struct cxl_endpoint_decoder *to_cxl_endpoint_decoder(struct device *dev);
>>   bool is_root_decoder(struct device *dev);
>>   bool is_switch_decoder(struct device *dev);
>> diff --git a/include/cxl/cxl.h b/include/cxl/cxl.h
>> index 26d7735b5f31..eacd5e5e6fe8 100644
>> --- a/include/cxl/cxl.h
>> +++ b/include/cxl/cxl.h
>> @@ -7,6 +7,10 @@
>>   #include <linux/ioport.h>
>>   #include <linux/pci.h>
>>   
>> +#define CXL_DECODER_F_RAM   BIT(0)
>> +#define CXL_DECODER_F_PMEM  BIT(1)
>> +#define CXL_DECODER_F_TYPE2 BIT(2)
>> +
>>   enum cxl_resource {
>>   	CXL_RES_DPA,
>>   	CXL_RES_RAM,
>> @@ -47,4 +51,8 @@ int cxl_release_resource(struct cxl_dev_state *cxlds, enum cxl_resource type);
>>   void cxl_set_media_ready(struct cxl_dev_state *cxlds);
>>   struct cxl_memdev *devm_cxl_add_memdev(struct device *host,
>>   				       struct cxl_dev_state *cxlds);
>> +struct cxl_port;
>> +struct cxl_root_decoder *cxl_get_hpa_freespace(struct cxl_memdev *cxlmd,
>> +					       unsigned long flags,
>> +					       resource_size_t *max);
>>   #endif
>> -- 
>> 2.17.1
>>

