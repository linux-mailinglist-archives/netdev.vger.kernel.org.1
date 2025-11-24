Return-Path: <netdev+bounces-241326-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id BE9FAC82BAD
	for <lists+netdev@lfdr.de>; Mon, 24 Nov 2025 23:47:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B4A884E5309
	for <lists+netdev@lfdr.de>; Mon, 24 Nov 2025 22:44:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FBAC33FE24;
	Mon, 24 Nov 2025 22:32:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="p8LLFve1"
X-Original-To: netdev@vger.kernel.org
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011012.outbound.protection.outlook.com [52.101.52.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9013C33FE0D
	for <netdev@vger.kernel.org>; Mon, 24 Nov 2025 22:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764023522; cv=fail; b=ehT+AZA09Nfwng5xjYWMKgi8uY7FVqbKT/sDU5CQklz3hcjuEl9egZBlUZKXUD+ApnBqHNl8EvqX1nN3Ly0nSxCbYNDmDuXPQgBbz+xIq1iXW6/Qt0O8ry5nIi74McILH3lix1hxxJaXtsp/8z0iqiqIbgQj4Bq2kV+2XBv2GXU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764023522; c=relaxed/simple;
	bh=TorFA2piL77fyVe+X20RYo3GMOWBkQpM7GY6pJHk2EU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=KWpdfkTV0fe/3xhd4l0vudT/i5VwZpWxEgTWSnKcHJF90BB95tEorCxYBQPredRECnQhiSGZW0WVQSxLU6r6srf1+R4l1Dk9+RZJPlA/jsg1sUPGIjULrD0XdX+4yakWIM0RpRhB4wY9QqZI9fOwRbhpGDk91t3wExdWITA7b6s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=p8LLFve1; arc=fail smtp.client-ip=52.101.52.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eTpfX+WWtkYnZwiR1gnBxUEfRfQ5z2v82ICvskhcuUjiHoMTzfK0qJC5jUbLINL95OI6QHVrZjV8tEPSqfrUJIal0C6U3IK9tBpSXlgpSSDYeq2+S+kn5LPYERA7onuoTVN8eZQbshgz2pDcVM0XMHDvNozX0PDMoiFwtTB+spNlnw0lihwjtFde4nar8o/TtIwM/Ff4OrCCcvmgguYxX8cMuCvRKnpcwjdQeaIl9YBmmh++BJTVHhkVOhdv2zu/c2oVurQGluhQxxJpxXdnNpdDX9wiwagYiAzB5M1dq9T7r6C4uIcC/O4uJKzV9jTNd0MNNrD9eDs/NLgBWGKMSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3zAMo2CF9FC+7VDpwVvoHyym+VlUfrr8+oRouXKSxbk=;
 b=izYHNNnJaEAZVhIO0mwf3X6+eglHPh6YVfzNMtipuLHeDzps3zajA1cebUEYcsTSRVO7sDfKemF0pSWAXi1ic8mU2gNgaQiPlrnlZ5++vDccOiRL6KjfeMBX7eOJFzdfT0yAoQ1560IU7W9RSt4s2dobU9e1xkL3VTQx3qFyNuXLQB6YQjulsypTIupv6LsfbhU1U1I03hlcI3RopqeK/qZC/o1Wums8yWfylfpVaTSuv6E0+q2oLZXXUQUHYMCUGECEYTCYo/iilFUpSNgkZWGWikxHosRvM9s1GDQHWicA/T2QuPJMN2F83ZuzldlERp97N/fR/wCAXvaXcH+NnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3zAMo2CF9FC+7VDpwVvoHyym+VlUfrr8+oRouXKSxbk=;
 b=p8LLFve1ehbZVwsjq9IGeuwPTMxDRP+2p1iBXREuo8ylLJDIYvkTH8W3Pf+wrrlGBl6+jKCwpm3s1eAwtID92FjTMr6LbI6Zko4DZ7koi8AW6/yXl6Zhlhh+SwlNdEHNJ3J2+kndOKMqaBpaZc1eilGK/gQC3yN/BedRwsNzvjnY/8DlrPuIk7OLsvrElIy3eWxo3hZyHoe9XJv4W9NGbDbolzrWQJhhVYTLc7Y6XFXdR2yGNmGL3cp2XIXoqD9XISLe3TX1e+jXfxcXxnHKlroJm3n049fezRdDUkI0OSfsCU60B0PSDbIK3b/+vbjygZvL4yrfjneMvmXHQKP1RQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MW4PR12MB7309.namprd12.prod.outlook.com (2603:10b6:303:22f::17)
 by BY1PR12MB8445.namprd12.prod.outlook.com (2603:10b6:a03:523::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.17; Mon, 24 Nov
 2025 22:31:57 +0000
Received: from MW4PR12MB7309.namprd12.prod.outlook.com
 ([fe80::ea00:2082:ce2d:74c]) by MW4PR12MB7309.namprd12.prod.outlook.com
 ([fe80::ea00:2082:ce2d:74c%5]) with mapi id 15.20.9343.016; Mon, 24 Nov 2025
 22:31:57 +0000
Message-ID: <d793f3da-17f8-489c-b48e-d1917412b87f@nvidia.com>
Date: Mon, 24 Nov 2025 16:31:54 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v12 08/12] virtio_net: Use existing classifier if
 possible
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: netdev@vger.kernel.org, jasowang@redhat.com, pabeni@redhat.com,
 virtualization@lists.linux.dev, parav@nvidia.com, shshitrit@nvidia.com,
 yohadt@nvidia.com, xuanzhuo@linux.alibaba.com, eperezma@redhat.com,
 jgg@ziepe.ca, kevin.tian@intel.com, kuba@kernel.org, andrew+netdev@lunn.ch,
 edumazet@google.com
References: <20251119191524.4572-1-danielj@nvidia.com>
 <20251119191524.4572-9-danielj@nvidia.com>
 <20251124170321-mutt-send-email-mst@kernel.org>
Content-Language: en-US
From: Dan Jurgens <danielj@nvidia.com>
In-Reply-To: <20251124170321-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0057.namprd05.prod.outlook.com
 (2603:10b6:a03:33f::32) To MW4PR12MB7309.namprd12.prod.outlook.com
 (2603:10b6:303:22f::17)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB7309:EE_|BY1PR12MB8445:EE_
X-MS-Office365-Filtering-Correlation-Id: c2a44a66-8e4f-4d94-4d2b-08de2ba946c6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eU9wNkxXY05yM0R5MjJudGVoL2xxZHdyV2doRG5lYjkyMW5yaWUyK29FbHl1?=
 =?utf-8?B?VEw2NmV2Tmg5ZE5wMTRUQU1mYnN0czdJa3c3TXZmeEpseG1hQXNnTnR5Z2Zm?=
 =?utf-8?B?dmxvYnc5a0R0NVJOWTlFRmFxS0tRWXFDRnF4WmVQK3ViNGpXT1JWRHRPT3I3?=
 =?utf-8?B?dUluWHBxVHVuMHlhczFQT2FELzl2VDN6NkFTbnJwdnBvc21PWHJkamgyVWNl?=
 =?utf-8?B?UHlTUkl6UitqNTVtRU9SYWkxeHYxMDBoSUxjaUpPdGlEaC9WdXZrWFVpanpY?=
 =?utf-8?B?bGs3YjVKM2Z2dWhzUGY5S002dkMzcUFXUlIrZ0dxQmdGUW1FcFVZdXZRSjBI?=
 =?utf-8?B?U3Njckd5U2tlbWhaOHROSnBjTDBtWVpqLzEvcmNDLzZ2aEwvQUtKRDNWRWUx?=
 =?utf-8?B?Ulh3ak1yWWRaL2lGR21MY3dxQUQvQmpSbVIzTDRqbk8wSmprNTlOcXBVb1Mw?=
 =?utf-8?B?a0I1TzJGNStqM0paRXVQb1l2YTlkWkwzQnY2TlBUMXNEREdpaE4xejZmNmNi?=
 =?utf-8?B?YnNkbS9QRFptbXpjOTBMd1JvNFBHdzdBSFllMnNXejNSWnJ6M21ubXJ1MG14?=
 =?utf-8?B?M2hoWWRaa0I4K2ZBMVoxcnc1MUdwYmVpN3N1ZnRmZGNRalp0azlSU092a29K?=
 =?utf-8?B?OGVnWW5BNDN4dlJ5OWNMU25iSHVXVFdmVWJoN0o2cHFqeW9VUUtKYk96NVM3?=
 =?utf-8?B?Q0ZyQWtvSjF4b2k0UjBRazdCOEM2bGRnL0Y0TENWNEF6d0RZeC9IVTVVZHhT?=
 =?utf-8?B?M2pLa05ubzJFam9JM09MdnErY1NJeEdRbHNQcjZVYmNJQmtmbk5pcVpaVnBL?=
 =?utf-8?B?WWtNR29VUGdoK283UkZ2cXRqMjlUUEx0WWFWNFZxVS9oMXA4Uk1nbW9EM2d1?=
 =?utf-8?B?eGZ1djZ5Snd2OHdiVTZjQXdjYjRud2FCSzZtbVdOaVhKRVdJQmVUTE9ua0lU?=
 =?utf-8?B?YndLQXE4d3o0Q0t4SVFYQ0htVGQxc0dSdVl1ak1ydUVVcVVMUUJVeGR4ODE2?=
 =?utf-8?B?eEVSczRaK3lqRDZxZVVQSEp6MlBvazBGTGlQUjhZVUNVcDMzRnc3NmwySWxp?=
 =?utf-8?B?K3dXTVlkaHQyaWFnUitvdHUxaHdtS1NBQTF4WnBubGJPVTQ5SDM3d2lvcVZq?=
 =?utf-8?B?elRVR0hjMXJuOUhtdFBkL2Z2UU9GdmJBWDEyTkhsWVRxUWZDdDZDV2xvME5Z?=
 =?utf-8?B?S0FFQ3BSc0IyVWhITkkveU9vK2xrdnVPN1crMFJXZC9iNmhQZnF1YVRuV2ZN?=
 =?utf-8?B?dmkxQ0JRdm83K0lZSVArWW8wTCtJelVIMjNiaDE1Q0x0WU5rcHlOdmd5akVG?=
 =?utf-8?B?Q2ZWN0lDaFcyOG9BWTFLdU8vdGJOWGp2MDNkQWdWWjNta1BnQ0lOM2kraEVv?=
 =?utf-8?B?RnBzSHVyZHdDd1BXQUxueGNUVEk0dE5IcExPQ3FzdFhORnZuWjNiN2tYN3NU?=
 =?utf-8?B?aUxsWm90Qm5zS2Nuemx2bzJ2NnBaME1OVWpaZnlpdjltSzlDYmdrNHN0NnNJ?=
 =?utf-8?B?UnkzbmJPd1UvQzJBanFncXVHTG5OSEM1VFQvSndoSGhvS1RRM2gwMXJVVHJq?=
 =?utf-8?B?bjdnb0lUbTNSUFFqZzFKR0Z6a01iNWt2bDR2UDFGVm9oN1ZMMXlSNTV4NjNa?=
 =?utf-8?B?bkkzY0hUT01RYm8zaXZNM0tOT1d3dUpvbG9NTFJzdmJBcnZyVnhxUk1UUzNu?=
 =?utf-8?B?V1hNSnE2MEdWM0wzQXpBZC9oTFI1MnY3Q0h5REs3bEFoWWpYaXpKMjFJVnpq?=
 =?utf-8?B?TTdFNUFzSFpLYitISlFwbHpjcndyQ2liaTR4ZG1wYXhRRGtYVWNpM1Jlcmxl?=
 =?utf-8?B?L1o1LzVBTUUwMXlXUCtsYzM3R0tNNmpzNzdNQkw3WlFGc1RldmxUM3FiVStE?=
 =?utf-8?B?UWNkdGt2SStaVVhuQXovMlZFWVVzU2kvajBtblloWDlycmlwOHlwc0x0OFQw?=
 =?utf-8?Q?w6ST956OOHbwDi8vbrufl3bc1n9O2x+J?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR12MB7309.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cndtTmZZT1NLbVc1aWFhMi9HWGpQUEVaMjQ3TDN5Mld6Mjhqb0FyMlVyTnJI?=
 =?utf-8?B?QjUzM25xcVhKaEo3aUowUG9hTHRtTGE2K3hNbW9xSVk1NUR6NnI3WnoxYVBr?=
 =?utf-8?B?NDdYSFNSb1dvaENjZDJlRlkxSy9UNlNNMVBSUWF5RDk2MkhlQVk3bDlwUVB3?=
 =?utf-8?B?RHppZXZKVGJ0YThOMHp4a3JKNVFySEtXc3l5RkpjL2ZBclZ3QXdKUmZjMkNT?=
 =?utf-8?B?NFBWTWRZa1FMTkJsMTVGVDE4ZEwvdERLZDA4YmxKL2lNSDJqOUZZT2lqZTVK?=
 =?utf-8?B?bWpIbFl1b1pBOExvelhSdk5adW1GaVlMaVliemx3SklFRjczY0hyVFRyRU80?=
 =?utf-8?B?QWxvbWtlSkF4N21HTHdCTXRXdk5xUUhyd2k5YTcxVllndU9FT01jNG1ubUt3?=
 =?utf-8?B?TGRIckxZVFo1RER6Rm9tMm5iK2cxaWtTaGZ5V2k5OForQTg4QlhXRjVXbTVx?=
 =?utf-8?B?czM0bmlTMlJRdnZwcXloOFVPdEgvdi9FM2FMblErcWkwMlgzNkczTFF2Qldz?=
 =?utf-8?B?MkU4K1JIVktlK1I2SEdGNFIwVG1qVnZENFB3Q0UvZjVoRDhTM3NKUEVnUXVs?=
 =?utf-8?B?YU5pMDZGbVoxVDV6TU1EYzJFUlhYZVZjMGR2Y2FKbEhHeWh5RU5VZ3liY2c5?=
 =?utf-8?B?TVNCam5pL2Rja3NOajVSR2tDdTNkQ3RnSkJaTVRFYXhSb3Q5R2FMZ0tWQStr?=
 =?utf-8?B?ZEJIeWtONHRSNHlGN1drWHZaZEtseXpTbHB4T0VHNk1HUndQMGE2NjRPd0RX?=
 =?utf-8?B?YUptaVRpRHNBa1hjWVl3ODVHVm5kSEJKcTIwdVRHRDREOS94a2w1Z1l4eVM4?=
 =?utf-8?B?QkUzRVk5a0RmeEZiN2YxTUpyUDZZdmwxYURrdm9UaUFXbnVab2x2aWFMN2Nt?=
 =?utf-8?B?U1YrUWJiR0E2YkhLb3MwTXZ1dzY5blBxd1BBbjJacUtxL1hPdmNZaDhNSkxP?=
 =?utf-8?B?cWFweDR1WitNOG1FZzdBc0YzWlRJaEFidG81U3Nxa1ZTM1Rwa3MwdVd0S3lp?=
 =?utf-8?B?QVNnVU1uN0Fsa1RkMDBKRDkzNWJhOW5rR1dnSDBMY3FabWVYN0FZR0c5emp5?=
 =?utf-8?B?c2ZqUzVFemRnVFVyMlo5a1A3bEM3UlFIdExXLzhGaDUwZHF0aEl5dHppOXFR?=
 =?utf-8?B?VnMzRDhGdjlURmM4NStmQUZ3R2wzclhpZUZvL2wvZmFYWmMxZzRHNS92M0tw?=
 =?utf-8?B?TjhrNUlobnIvNDJLV2N1QzUvRmZBNW1aMmx1K0szU0pYaU1HWFIyNVMzZXdI?=
 =?utf-8?B?VWxWUnNpYU1CemM1dTVZdUFIbmJ5cG1HM0hqb0t6bE9LZHhtTFBUUTArempq?=
 =?utf-8?B?ZmRVT1NlaUNFa01QR2VkbVFUSVlkR0ZqNTVwcGg3N2UyVEVFOENFYnU5M2xB?=
 =?utf-8?B?L3FOTkVwU0t4US9XcWM4UGpkWENEZzNtWVRaUFB1T2oweWVoZytDMUVLNWNp?=
 =?utf-8?B?V2JYL2JkWEpYN2JuSktnMy9DRk9vSThDdGVja1dHOUZmUEtyTlBBZ01CRjlz?=
 =?utf-8?B?RTJVTlNURGNmQ2diSUF0bjVpNkZrL0Z3RWZKVHpsb0FvSitmM0hjc0xtdXJ3?=
 =?utf-8?B?K0l2Zm5VeFpROUpjZjlhazlLR3plZFIxSWM3RUI0V1Z0Vng4eGdTZ0pzNlN4?=
 =?utf-8?B?aU96aDRqWjJocmJVV2dCVnYrWVMzVnZOK1ZWcklvdm4yN00wc240aUZYcUg4?=
 =?utf-8?B?MjdoMWxLV3M1Ym8vazliSFhkT28rdUxHU1RjYVg0NVhPaFpicFdQZVpPaWZH?=
 =?utf-8?B?T3ZTcTY3dDQwLzg3b3MzenI3QW1MZ2RGdVFwVVN0enNMZFlKckhKWTg4cXZ0?=
 =?utf-8?B?azFmN2R5YVNlRlU2T2VGWStLQU9XVlJxLzlGc1JVbVRERklaaUgzWkxCTWR0?=
 =?utf-8?B?SXZHekxqMTN2Ry94Z2lOQlpBQzdWaWlnSmQ5UXBvd1lUd1hSRWJEUFNFS3lx?=
 =?utf-8?B?VUtzbHIwa2IwaVdENTVZY3RvdmJrSTBmSCs3VThNQTExdUFmWkF1NXJ3WW93?=
 =?utf-8?B?Vm0zclM3TnpGUVhyK1RZZGliUFRTeWlvTGFwQXJHVkExNC9SSjJyb2VjY3Nn?=
 =?utf-8?B?dGxLMTAwc1AyTVBTa3dDaXFEOTBlK1RrenRLWUF0QVJxUTZHMmUySk9xZEhR?=
 =?utf-8?Q?VVgpME7zsdocEa1hwXOVihVce?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c2a44a66-8e4f-4d94-4d2b-08de2ba946c6
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB7309.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2025 22:31:57.1638
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: L0thHkFv9huTlYX/zZ0m1gEOotnDiMkpv2GD0U55LTk4+4CP3nJN2IpRFddi6NF7yd3m6RFsHiEbE/bz7a/Www==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR12MB8445

On 11/24/25 4:04 PM, Michael S. Tsirkin wrote:
> On Wed, Nov 19, 2025 at 01:15:19PM -0600, Daniel Jurgens wrote:
>> Classifiers can be used by more than one rule. If there is an existing
>> classifier, use it instead of creating a new one. If duplicate
>> classifiers are created it would artifically limit the number of rules
>> to the classifier limit, which is likely less than the rules limit.
>>
>> Signed-off-by: Daniel Jurgens <danielj@nvidia.com>
>> Reviewed-by: Parav Pandit <parav@nvidia.com>
>> Reviewed-by: Shahar Shitrit <shshitrit@nvidia.com>
>> Reviewed-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
>> ---
>> v4:
>>     - Fixed typo in commit message
>>     - for (int -> for (
>>
>> v8:
>>     - Removed unused num_classifiers. Jason Wang
>>
>> v12:
>>     - Clarified comment about destroy_classifier freeing. MST
>>     - Renamed the classifier field of virtnet_classifier to obj. MST
>>     - Explained why in commit message. MST
>> ---
>> ---
>>  drivers/net/virtio_net.c | 51 ++++++++++++++++++++++++++--------------
>>  1 file changed, 34 insertions(+), 17 deletions(-)
>>
>> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
>> index 7600e2383a72..5e49cd78904f 100644
>> --- a/drivers/net/virtio_net.c
>> +++ b/drivers/net/virtio_net.c
>> @@ -32,6 +32,7 @@
>>  #include <uapi/linux/virtio_pci.h>
>>  #include <uapi/linux/virtio_net_ff.h>
>>  #include <linux/xarray.h>
>> +#include <linux/refcount.h>
>>  
>>  static int napi_weight = NAPI_POLL_WEIGHT;
>>  module_param(napi_weight, int, 0444);
>> @@ -302,7 +303,6 @@ struct virtnet_ff {
>>  	struct virtio_net_ff_cap_mask_data *ff_mask;
>>  	struct virtio_net_ff_actions *ff_actions;
>>  	struct xarray classifiers;
>> -	int num_classifiers;
>>  	struct virtnet_ethtool_ff ethtool;
>>  };
>>  
>> @@ -5816,12 +5816,13 @@ struct virtnet_ethtool_rule {
>>  /* The classifier struct must be the last field in this struct */
>>  struct virtnet_classifier {
>>  	size_t size;
>> +	refcount_t refcount;
>>  	u32 id;
>> -	struct virtio_net_resource_obj_ff_classifier classifier;
>> +	struct virtio_net_resource_obj_ff_classifier obj;
>>  };
>>  
>>  static_assert(sizeof(struct virtnet_classifier) ==
>> -	      ALIGN(offsetofend(struct virtnet_classifier, classifier),
>> +	      ALIGN(offsetofend(struct virtnet_classifier, obj),
>>  		    __alignof__(struct virtnet_classifier)),
>>  	      "virtnet_classifier: classifier must be the last member");
>>  
>> @@ -5909,11 +5910,24 @@ static bool validate_mask(const struct virtnet_ff *ff,
>>  	return false;
>>  }
>>  
>> -static int setup_classifier(struct virtnet_ff *ff, struct virtnet_classifier *c)
>> +static int setup_classifier(struct virtnet_ff *ff,
>> +			    struct virtnet_classifier **c)
>>  {
>> +	struct virtnet_classifier *tmp;
>> +	unsigned long i;
>>  	int err;
>>  
>> -	err = xa_alloc(&ff->classifiers, &c->id, c,
>> +	xa_for_each(&ff->classifiers, i, tmp) {
>> +		if ((*c)->size == tmp->size &&
>> +		    !memcmp(&tmp->obj, &(*c)->obj, tmp->size)) {
>> +			refcount_inc(&tmp->refcount);
>> +			kfree(*c);
>> +			*c = tmp;
>> +			goto out;
>> +		}
>> +	}
>> +
>> +	err = xa_alloc(&ff->classifiers, &(*c)->id, *c,
>>  		       XA_LIMIT(0, le32_to_cpu(ff->ff_caps->classifiers_limit) - 1),
>>  		       GFP_KERNEL);
>>  	if (err)
>> @@ -5921,29 +5935,30 @@ static int setup_classifier(struct virtnet_ff *ff, struct virtnet_classifier *c)
>>  
>>  	err = virtio_admin_obj_create(ff->vdev,
>>  				      VIRTIO_NET_RESOURCE_OBJ_FF_CLASSIFIER,
>> -				      c->id,
>> +				      (*c)->id,
>>  				      VIRTIO_ADMIN_GROUP_TYPE_SELF,
>>  				      0,
>> -				      &c->classifier,
>> -				      c->size);
>> +				      &(*c)->obj,
>> +				      (*c)->size);
>>  	if (err)
>>  		goto err_xarray;
>>  
>> +	refcount_set(&(*c)->refcount, 1);
>> +out:
>>  	return 0;
>>  
>>  err_xarray:
>> -	xa_erase(&ff->classifiers, c->id);
>> +	xa_erase(&ff->classifiers, (*c)->id);
>>  
>>  	return err;
>>  }
>>  
>> -static void destroy_classifier(struct virtnet_ff *ff,
>> -			       u32 classifier_id)
>> +static void try_destroy_classifier(struct virtnet_ff *ff, u32 classifier_id)
>>  {
>>  	struct virtnet_classifier *c;
>>  
>>  	c = xa_load(&ff->classifiers, classifier_id);
>> -	if (c) {
>> +	if (c && refcount_dec_and_test(&c->refcount)) {
>>  		virtio_admin_obj_destroy(ff->vdev,
>>  					 VIRTIO_NET_RESOURCE_OBJ_FF_CLASSIFIER,
>>  					 c->id,
>> @@ -5967,7 +5982,7 @@ static void destroy_ethtool_rule(struct virtnet_ff *ff,
>>  				 0);
>>  
>>  	xa_erase(&ff->ethtool.rules, eth_rule->flow_spec.location);
>> -	destroy_classifier(ff, eth_rule->classifier_id);
>> +	try_destroy_classifier(ff, eth_rule->classifier_id);
>>  	kfree(eth_rule);
>>  }
>>  
>> @@ -6139,7 +6154,7 @@ static int build_and_insert(struct virtnet_ff *ff,
>>  	}
>>  
>>  	c->size = classifier_size;
>> -	classifier = &c->classifier;
>> +	classifier = &c->obj;
>>  	classifier->count = num_hdrs;
>>  	selector = (void *)&classifier->selectors[0];
>>  
>> @@ -6149,14 +6164,16 @@ static int build_and_insert(struct virtnet_ff *ff,
>>  	if (err)
>>  		goto err_key;
>>  
>> -	err = setup_classifier(ff, c);
>> +	err = setup_classifier(ff, &c);
>>  	if (err)
>>  		goto err_classifier;
>>  
>>  	err = insert_rule(ff, eth_rule, c->id, key, key_size);
>>  	if (err) {
>> -		/* destroy_classifier will free the classifier */
>> -		destroy_classifier(ff, c->id);
>> +		/* destroy_classifier release the reference on the classifier
> 
> 
> try_destroy_classifier ? and I think you mean *will* release and free.
> 
> and what is "the reference"

I see the comment is munged. But classifiers are reference counted,
try_destroy_classifier will release the reference. And free if the
refcount is now 0.

See setup_classifier above.

> 
>> +		 * and free it if needed.
>> +		 */
>> +		try_destroy_classifier(ff, c->id);
>>  		goto err_key;
>>  	}
>>  
>> -- 
>> 2.50.1
> 


