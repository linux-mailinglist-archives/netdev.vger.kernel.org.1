Return-Path: <netdev+bounces-237635-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 29242C4E35B
	for <lists+netdev@lfdr.de>; Tue, 11 Nov 2025 14:42:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 458B418987CD
	for <lists+netdev@lfdr.de>; Tue, 11 Nov 2025 13:41:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DA8033ADBF;
	Tue, 11 Nov 2025 13:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="dmSaZr40"
X-Original-To: netdev@vger.kernel.org
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013036.outbound.protection.outlook.com [40.93.196.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7159A33ADB2
	for <netdev@vger.kernel.org>; Tue, 11 Nov 2025 13:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762868471; cv=fail; b=uJ1WeTsGUFinynzmAj7vFYXEIt2ONOwIUH3c3lo9KoYofbPjbxZZFXSULSQh5Zsdril1cDY1uSFVwvIwlSTGlncO2o+65QMsQwYjMDDVFQBd1TqHR4+LmsQdz6MFs+/iQVEtBE9hGDMhAvs8BtdEdQVm2J4LIbDyVeJYBoRqMGA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762868471; c=relaxed/simple;
	bh=TJJumqpFF2rwvTCiXVrHVXL5cHc1f5Xqmv1TPBNu2sw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=KHJ3As+6W5uFOBeogMMHeXs9nqZ7Z4iWaMMwmhWY+Z0PqqqnOvZ43GN/UaIzP4bQdxQWXeo34AnuCXQjcUnaNvQ9kVMxyNmIXByqL2ZrxSPK96bsC+9enu9RIKapXigYPHoIs5NaxiygOsHZL9GeXQ820UOhe+wqDbjt0cziA5U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=dmSaZr40; arc=fail smtp.client-ip=40.93.196.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QR7y7lta5u/PqR/xVxHkMJ3QHayDDqj69cl+3scdYOywvtw2mxGbuHxTAfJH3cCM9NF68q9HS+Yg8kdCRvhnf/qogA3qZ/Oc8VeC484+EknGTwxZ4tOD0K63KQ8XUShOLq1FgcpL8Bt9uCogmZGzRU2RYBcqTeUjCXeFhfom7lXF3KYn1EriyuzIGYu4KSVnjZ4lQp/bpWS7ROJyOWXrstnUbpPer1hUgSKfkJLnwe+hRxPv2CrSWm4z3lC0Gyqk9SwYYC23ngw14XplgDss6+OPIDtAFBqRTVELdbUp7hKTwF+IoqE7o2ffclkaY5ywF74NfAsgCx9OFw8JQUDxTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r4jZVqp+0LP25Sz81jIE6U6DBkfgLUZ8KzXinMDmwJs=;
 b=kP/+NGDux0TOkMsPOZc8NaleveBnEvlFQHIlkv9Zbv4bxkeCUyFIdpPYxtZSgI/Znh09sGNP83rXep5RFUZHf6RMmusZtuxcq+BsGXRmvdnMhkQotc4oMPefBMXHjR9+0EvSkEI+YPf1Z54S/nLUC7lcih95vIoEgV1Pu4JfwbUeev88TQIDhmYYywgIzJHR6gJffMEb6pl8liu5bmKL1DZkXeqTEXGGPcgfeOjKuacEGXNCcQqozysnYp7sftASm+SlsuX8Us9PzaNiKnSSMBApiF/C5duRSMbW4ijdV+Px8wg//jEfgedeja74qD2+f0qJoC6IuwW9+GD3yY7ZPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r4jZVqp+0LP25Sz81jIE6U6DBkfgLUZ8KzXinMDmwJs=;
 b=dmSaZr40JXZHhlz6JHKaLp9a5Y338385npI+eN4d96zXGNGl/LtOO2jQFN6dJsMxlhCxJs/2Gmqf9AHOxe+NvHp4lvUxZL2gMPfpGBkb69m0stzG/Za2TZ4mNLWKZik8NyeoNoWKHFMoh4/Bn9VRW/lVteFGhV66+Fp/IJC45HXqFXqT1F8F0UXGryBaC0mDzSzyKxrE84C6bf9QElzBHG6RBpHIHQe6EHcBE9Ele45g+yKEuL7/EZz+7NzRCS6tR3u3V4Vc9wbpv+Qutx3jJlQZY4qekEQFNVkw/SuH26a1eWhoTVvzAc6HkXMcPrGmHNP05nM++YN0jNbI/IpvHg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MW4PR12MB7309.namprd12.prod.outlook.com (2603:10b6:303:22f::17)
 by MW4PR12MB7382.namprd12.prod.outlook.com (2603:10b6:303:222::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.18; Tue, 11 Nov
 2025 13:41:05 +0000
Received: from MW4PR12MB7309.namprd12.prod.outlook.com
 ([fe80::ea00:2082:ce2d:74c]) by MW4PR12MB7309.namprd12.prod.outlook.com
 ([fe80::ea00:2082:ce2d:74c%5]) with mapi id 15.20.9298.015; Tue, 11 Nov 2025
 13:41:05 +0000
Message-ID: <c0bdabe1-afeb-434a-83f6-707acc941f5e@nvidia.com>
Date: Tue, 11 Nov 2025 07:41:02 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v9 05/12] virtio_net: Query and set flow filter
 caps
To: Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, mst@redhat.com,
 jasowang@redhat.com
Cc: virtualization@lists.linux.dev, parav@nvidia.com, shshitrit@nvidia.com,
 yohadt@nvidia.com, xuanzhuo@linux.alibaba.com, eperezma@redhat.com,
 shameerali.kolothum.thodi@huawei.com, jgg@ziepe.ca, kevin.tian@intel.com,
 kuba@kernel.org, andrew+netdev@lunn.ch, edumazet@google.com
References: <20251107041523.1928-1-danielj@nvidia.com>
 <20251107041523.1928-6-danielj@nvidia.com>
 <ee527a09-6e6e-4184-8a0c-46aacb11302f@redhat.com>
 <e1d7d4c1-263f-4f2e-b1c0-6672ce6d7d58@redhat.com>
Content-Language: en-US
From: Dan Jurgens <danielj@nvidia.com>
In-Reply-To: <e1d7d4c1-263f-4f2e-b1c0-6672ce6d7d58@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN6PR08CA0034.namprd08.prod.outlook.com
 (2603:10b6:805:66::47) To MW4PR12MB7309.namprd12.prod.outlook.com
 (2603:10b6:303:22f::17)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB7309:EE_|MW4PR12MB7382:EE_
X-MS-Office365-Filtering-Correlation-Id: f8ab8dcb-592e-41cc-ce80-08de2127f610
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bzlTbUFPT1UzekxaVEQzZXlaTTA5UlRqZWlqdmRUNW9hOERZcjdWTEN6QUUv?=
 =?utf-8?B?Mlg3eUNubFM1MVFFR2I2UHZrZjRNR0FRVmRaa1lmcFZQcVltTHYzT2dHZnJX?=
 =?utf-8?B?R2R4NUo0UjF2UkRpdm9Ha281VW55ZkRBZGFRc21VNGlydTdCWFNsS3VERzRR?=
 =?utf-8?B?VFowbEprdE9OZjNYNStIR1pHcGNHSEhDUWdYc2E2UWdRZC9HR0oxSEt2YjhF?=
 =?utf-8?B?UHRLZUZJaGtDNEsyZGk2UFpkc3ZlQmM2RVVlVFlhSmF5S1dnMWs1aEJwUEMy?=
 =?utf-8?B?cnFUa2RmeG4zYlYwTVMxcmJES2VxOFVtQnFLNU9pQ0lYSTBTTlFMQWFzSmdU?=
 =?utf-8?B?RTlvd2g3dEpTZTFiY1U3N1V2eTMxb1Q3RlF5MDhRdnM3VkV0UlcrUzU0VmY0?=
 =?utf-8?B?WEFMWWdCRCs0NkZnbGJoVXJ1STQ4aGhlSitXYzh3UDJ3cEJRckZLUy82TnBn?=
 =?utf-8?B?dm85SUlGcFhjSkFkVWo1TFBCMGNobHY0TS9yQU1LV3picUdHWXgrVGJVdk1n?=
 =?utf-8?B?eVd5blhRUG5nQ0xjdUxJa2ZMSHMvNXQvMjAvUTV1ZW1JYlBRQ3MwSjlhV0ZQ?=
 =?utf-8?B?clFtVjEweU1jemljUmtrcExnbHNhQmVWazFFcURrSm9JWnVIZ1pkT2hMMXYy?=
 =?utf-8?B?V2pBWlk2VVZIRWVDRTg3WlBIbkhpZS9CNW5TZ3NaSCtVK2hDV0hpUzNSRi9s?=
 =?utf-8?B?K1JNVkR2QlRXS3pzT2xOaE1ZWUFKQzRva2FTWGI5SDJGM1pxdE5DNXJzZVUw?=
 =?utf-8?B?M0IxREhlWmRnMkhETEFzNzBEZXBKWjZPM2xXNFZTSHhBNklPcGVQOVNhMHpW?=
 =?utf-8?B?KzZ4ZjVnTTB6SlNYb3R5VWRLQmh0Z3JBbGtVaFYzb2x4ZDJJbHRwcGhkTzdT?=
 =?utf-8?B?Y25adGNqREFReHUrVnpPRjZ2WGkwNThUTWFBTHhNWTJ6S25oWk5KaEFTWGJq?=
 =?utf-8?B?NUhURENWeHJ3S3Z5d3pIOFpjdlBhM29KTjRoVWhHcVg4a1FrRFlPaThJWTI2?=
 =?utf-8?B?MDhkcHFBTjU0TXZIcDlyVjNOR2ZXNnJFS1dkZlIyNXU3dFNReFRscVppV1I0?=
 =?utf-8?B?QjIyVnBDVG8vNUVHeC82RUhSR0lOVEgvMlM4dFQ4YlhPYzJUbkJtcVZJello?=
 =?utf-8?B?YU1qQ1BsLy81YmU4U2RGNjFXaE0wQmJ4SGtIM1ZQYm1XUHJad3R4bnVVRWtF?=
 =?utf-8?B?UVA5WnZ1bHFXOW1FTGRSckx5aTJJenBkV0R6cUZWOFJ2cWFHRFJKT2FwckJE?=
 =?utf-8?B?aUVGSDh2aWVWVWpNejFkWXZNVmlTc0dMekxBc3VHSUdSSWpZT1N1UTFhZlh0?=
 =?utf-8?B?eG4xRHFpT0llQ2plQ2lqdGtmeWlobVRtNndnNldjc0NEMW9wL3kyTjdUMjNS?=
 =?utf-8?B?ajVydVhwUjVGdW1ZeGU4TjEvaHhRc1AwSkU4bmJUMzhVWm4wbGozSU1LcW8v?=
 =?utf-8?B?RWl0VU9qRkZ2d1JSVjBKejNKTU45QjRoaHR0RDMwQWpMWkh5MVV6ajQyYm1y?=
 =?utf-8?B?MkhRQ04xQys0NUtWNTlWeUxMQlBNS0lRNjJLV1JwTFo5QitneDlGNGo5eWY0?=
 =?utf-8?B?ZFZ5Mzdjay8vT3BReW9GNDFVekVZY0NHaTFYQm1GNDFxT1VmanYrUDJ1aXZE?=
 =?utf-8?B?WmRYYTkxVmZDelZVbm1WVHljTWR3NFRxczIzWC9KRE85bDlUNkVHdVZjVVla?=
 =?utf-8?B?Y005UDlVU3A5bCtHamNBSTd5dkRKZDZtVGhXTEZhNzN1VUgwNGU4ZGxhWDB5?=
 =?utf-8?B?MVg2ZVd1cjRSSUNiWmxYQWFLcS9RVlkzb2tDK2FDcGtoZ1FabWZNSnY5cWZ2?=
 =?utf-8?B?bDMxa1pOWmJ3WkpIZ0orVGhYS3pzbGt3a1RoOXVIdk14T0RGSEFoNFE1THdQ?=
 =?utf-8?B?cGFoOFNNeXFZNVJuK3BPM09jdVVTRUZmRzhHc0NiSEpNVGxtUCtGcm9pM2xz?=
 =?utf-8?Q?FlddQOu9WJuRmeaVeRA1YokQh/XqqHlj?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR12MB7309.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Yi9uaGtyd3NDdG5CTk0razRxNTkvSlhQeTZvV05oOVJmMUFzRmNDRWNabEZK?=
 =?utf-8?B?WE9ENnllQ29vZWNmMURVWVRYdEhOa3Fkbm5uZkJBbkpMaGF4NCtPeEJNRjRH?=
 =?utf-8?B?dStySERLZUd0d210cmpRR1ZVWUJVS1gyL2pEUmJyRHVuUTVEUWV4ZGZvemFn?=
 =?utf-8?B?bGY3dnNBQk96d3IvbFU2K2g5QVlRNEJ6Y3B1UkVVRzB5OWVEOHVmcG40bVh4?=
 =?utf-8?B?QTU2VGxBK2VlVUJMRTI2Y1ltOTlRWnhWem9sQWY0d20xcVR5RGNzS2pGUXpV?=
 =?utf-8?B?Q1ZsT293amIydk5DQmtVMVpzcVBKbU13ZWg0NksxUitiekxoT3ZPNHV6L3ZM?=
 =?utf-8?B?VW5hd3kwUHkrby9XYVFqMzJpcjRFUVJtdTM0NVZvWm42ZXdqMkFiUU9vOTlZ?=
 =?utf-8?B?SGpweGlyQ0ZyQ25IU0xKUXU1YW1JQVdSOFR1OFlkY0ovYUJIZFlqM09zcU8z?=
 =?utf-8?B?VU9aalloQTZvVXZEdGU5OTlrR3l2NWlONEV0ZWNjN3JQbHU3YTlWTXg4d0ZR?=
 =?utf-8?B?YmNnNm1iZ2hDNDd1ekRCZEpFdVR3bzRER1FHL0FyeS90a2FxR2l3SG9xS0dN?=
 =?utf-8?B?MmEyWVQ4RUpsRWUxWnNCQUt3MDJIQW1QU0RrL3RheHMwaUlHY0JRT3RhczBO?=
 =?utf-8?B?eW9od3VoUlNlV1VNZjkzYkgzUWprQlNjKytpeXdXc3pDQjdrM28yRTQxMURD?=
 =?utf-8?B?L2VNbVQ0VVBleXdoMmdKamtCQjQ3ekJPb3NQS1RoYmtQTklTNUxOdHhZTmFH?=
 =?utf-8?B?WWtQSTdQRS95NmRlMWdJTCtjeXBwbVJjVXZGVFZ1TDhKUzRlYXZhOHRsbHlq?=
 =?utf-8?B?UlFZakdjMllmNE54Z2M5Nkg3YWt3aXBiTEp3b3NsczRqSVI2Z1lhVnhoQUNy?=
 =?utf-8?B?ZGs4L0xSSXdXNzIrbWY3VnVua0UzbHlIWTVXNWJ3blRWa3NTWkRaL0ZCY3hL?=
 =?utf-8?B?TmFRR1NpVFk2QmZ6azJLMzg3RTJqZlFkYUc2Qm9LZ1NsNG90YVl2K3VTaE5U?=
 =?utf-8?B?VloxNGF0WkgrQXBFUnkySTcrTG9rSitRV1BEL3hHMDRUaG9MSUd5bHpSQTJn?=
 =?utf-8?B?SkFINU54Nk9tTlhpUlB4TlYwSW9PTVZzN1RZQ3RDblV1RVRQRVNwRjUwSEcv?=
 =?utf-8?B?ZUk5VnlPSllQMXFDbm5VdFVEcWh3bUJXY05Rdjd4cVRMbHkrV1gwdGd3NmNB?=
 =?utf-8?B?c2ExNjRtR3htRTRkTWgzbFJFRjFpekQvYTFxa2k3aEFPM1BKcDljZDgwb25i?=
 =?utf-8?B?d2FOOE1yV3ZEMEJ5Q281T2pqSndmUE5rZ0hORzN5QUNRSmgrQkFiQkpVS05T?=
 =?utf-8?B?c0ozSEZNZ0NRbGVoVnFZZUNMNzdsQk1UazJzeWUzNUhDZU9yMWtDczR2Tm4w?=
 =?utf-8?B?L0tJckdleENQUTgzSWJ6ZU9RcS9FZGEwanQ0elp1YkJJWHRNZ3dkUC9CUzVr?=
 =?utf-8?B?NUV2UEhEcW9zeTRIMUpCV1kxbmcxOGVISU1Kd3diYjNOS1lkNWowUnloOTlK?=
 =?utf-8?B?d3dDNUwxbTdkVDZjOTljMndHUTNUUURLc0l3YnVnTWhUY1lneXFwVVI4NGNY?=
 =?utf-8?B?b0FTTDdrSENSRWcyQmFnbm5jYWJQNVUyZTJxMEF0N0FhZGZhRkluOG9KRjJG?=
 =?utf-8?B?cTRYR0txSzY2K2cwZXJFN1pRb1l6UWFBd2N3d1lQK0JheVArR0NlejNxZ0to?=
 =?utf-8?B?UWlreVg4YWM5OUpsTVhDTFcrSTFjOGZXaSt1WXdYekUrSjhQR3hJaU5jSEgw?=
 =?utf-8?B?YmE0eDBnZU5RRDNNSkR0d2FrcVlGbkxhY0xIOW5hS1QwSDFaaGJtTkcyOVZ2?=
 =?utf-8?B?RFFNSmNEN1prUmlVWGl1aHpjdS9nM2EvcEJyd3ZHQjlRMERwMk5qeHd6cXNT?=
 =?utf-8?B?cGtnYWU2bnFZQ2R5bTVXWlk2bW1RWjVLYURXcE9JWHBZNjYwYzYyQTBqNlNx?=
 =?utf-8?B?M0RtQ2ROV0xjSmtaWHlGeklxZnpSS1hBOTFWZ1FnU0lTTThxbWhxd0xUL09v?=
 =?utf-8?B?SW8xR3hxOVBUdUpXeHNIL3BsNHFvNUNhSlVsZGlpMThncmdhaWF6cE9ITEp6?=
 =?utf-8?B?TmZqdml5TkdwYzAvMUFheGhOc3JoZWNSSnNFRFpzR2tqdEVMZHJUOUlhYWI2?=
 =?utf-8?Q?Gz7Kljb4WWXjKrct+NI5FkhWP?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f8ab8dcb-592e-41cc-ce80-08de2127f610
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB7309.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2025 13:41:05.0698
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sSzUYNwqEPbIDu4ESRf/3/ywjE94EMdIKs4o5DgPHVU3DnuDhMOo+JUbw7Kp2SIIqteLEcNFS1RrLmw+YDRevA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7382

On 11/11/25 4:48 AM, Paolo Abeni wrote:
> On 11/11/25 11:42 AM, Paolo Abeni wrote:
>> On 11/7/25 5:15 AM, Daniel Jurgens wrote:
>>> @@ -7121,6 +7301,15 @@ static int virtnet_probe(struct virtio_device *vdev)
>>>  	}
>>>  	vi->guest_offloads_capable = vi->guest_offloads;
>>>  
>>> +	/* Initialize flow filters. Not supported is an acceptable and common
>>> +	 * return code
>>> +	 */
>>> +	err = virtnet_ff_init(&vi->ff, vi->vdev);
>>> +	if (err && err != -EOPNOTSUPP) {
>>> +		rtnl_unlock();
>>> +		goto free_unregister_netdev;
>>
>> I'm sorry for not noticing the following earlier, but it looks like that
>> the code could error out on ENOMEM even if the feature is not really
>> supported,  when `cap_id_list` allocation fails, which in turn looks a
>> bit bad, as the allocated chunk is not that small (32K if I read
>> correctly).
> What about considering even ENOMEM not fatal here?
> 
> /P
> 

If we're just excluding the most likely errors I'd rather switch it back
to void.

