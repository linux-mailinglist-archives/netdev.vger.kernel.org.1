Return-Path: <netdev+bounces-218368-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B84A2B3C3B0
	for <lists+netdev@lfdr.de>; Fri, 29 Aug 2025 22:17:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 950034E1878
	for <lists+netdev@lfdr.de>; Fri, 29 Aug 2025 20:17:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11B0830FF36;
	Fri, 29 Aug 2025 20:16:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="cx4fiLzA"
X-Original-To: netdev@vger.kernel.org
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2065.outbound.protection.outlook.com [40.107.96.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BFC6230BDF
	for <netdev@vger.kernel.org>; Fri, 29 Aug 2025 20:16:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756498618; cv=fail; b=jEnCys0Hha9mHXliDZjI9Au7AehD8bg8Va5OdIk2m929t+/1G6EifrZ9lvO7yqi0OheyP+2e4lu5Vk9jNwOkBGptJj8o2Gg5A0zTqKLE4ccLh2XcKKSvlQg+0ZV1ms7kHCB9yGra8af2/zzoJ4YWhgcTrYj2UDyKzU6sg4ow+mU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756498618; c=relaxed/simple;
	bh=0CoCYzqoyykiz5cniFgr+ElWKyKGhqFF7WEFvzzZgSU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Ne774c7hzADqn2UQRqwy32BgAnvpwHpDQHiSmvW3kS+paYw1jY4wIKCvqT0mIgjYOPWbxMhTn3cnCrW2inY7RNYxoIvKGDBqw4ld1Zi7pAcNlq/Id8XIJ+eRLDBimYmXIgEKRCpW5FsNzCQc2IAjeI5uWED149hvBcrQu0StWaw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=cx4fiLzA; arc=fail smtp.client-ip=40.107.96.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Mll8O37WtAjB0qJxmaY837VpNNTHbdoUcwzoPqNJOXp7/ZnFixZek+tD9rZR+FLTJnGBKqWvOXSu3xLpkz7dO2w3uaYp3SDeQ7IGNWdyVlWdOdzOtYJj4A0Iiyo/WjDGdyJAmqSXLsrK/bWjnuJByRRfDMkJnMZSkYMppzWdJq0NPNHWVVzu8A1DGJhLoRFKmrJr+gGEG3kcdQTnUGXG2KvulvJ9o4mg+eJ7P8oghrIgPOzj7QU1m6KdcghjkbPN3y9qnl9Mv0gvg5LeigLnKfJgE2NyjN4eSwRSBrPF4csloVZlWyJbX8QBkgczQpieEP1Xo6V3S4Pln9b37uPAXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eFTndhasj/ZKwlaQKsVcCj4VtR+9b3kkwTLUXAiGjnE=;
 b=mBigr/NvU8vR9ilqhXGv8FbqYYcPC55wf1BCFvSlAijyfl8SobC5j+cZbh/sWoEGAfppQZTcyeGrR045H9/V5uc0Dh7f02fEcpL3e3Url6+AtH6grMm+bcw2Z2+/WmEVge31Ls/I5Gd52B0iyZj6/L+nj9fRVqbKwzpirEi7O5gfmeYI8pt/wngskn2ticrOyFFhLI+kUsh8mTAgjenMQZwKs88WKUJyp/y/oCArlTfT4W0U8iMqXpnvKftGZ38IMWvZ/dQK6cmiusZMBDDCdo1fLgtIbFwvVdWNsbf3UThL9gi/Q5VB8wcKaVcrLwJQDFaoSmUrJLimGWrrv+5+pg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eFTndhasj/ZKwlaQKsVcCj4VtR+9b3kkwTLUXAiGjnE=;
 b=cx4fiLzACOTaNSwlT5SDvywNtYXWpDI9pvxpkoAAqaxGQc5Z66Xw+lorovtGSbxfgzCGL1jwUnU46GluRQAQqEZB7hGyS0IVbNDe9uTNuWSdzEU7llfT9ovkHDVSoivD7eKqGNOIpPRvdSqsbkJ6hzR8Iul53DQ0RDDf2Kk1Yg0ZVuzH4x50MjnrT00R64X3L6jXiaoZoI1z9z7zsg85eXjD0vRN0j18p5QJn5haS8fG0QZ3Jn4EE2Q0jqj3/6fTiB/nHxlktK6m7DALmsbUwUaeZBT8Rqqnv20uUfjZgqGsEHPPcc1ATDG3/jd1YKHHPPvOQ1HvCddQe/r82JjzsQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MW4PR12MB7309.namprd12.prod.outlook.com (2603:10b6:303:22f::17)
 by SJ0PR12MB8138.namprd12.prod.outlook.com (2603:10b6:a03:4e0::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.17; Fri, 29 Aug
 2025 20:16:49 +0000
Received: from MW4PR12MB7309.namprd12.prod.outlook.com
 ([fe80::ea00:2082:ce2d:74c]) by MW4PR12MB7309.namprd12.prod.outlook.com
 ([fe80::ea00:2082:ce2d:74c%6]) with mapi id 15.20.9073.021; Fri, 29 Aug 2025
 20:16:49 +0000
Message-ID: <74dd76fc-59fd-47b2-82cb-e03b0a3aeff1@nvidia.com>
Date: Fri, 29 Aug 2025 15:16:46 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 06/11] virtio_net: Implement layer 2 ethtool flow
 rules
To: ALOK TIWARI <alok.a.tiwari@oracle.com>, netdev@vger.kernel.org,
 mst@redhat.com, jasowang@redhat.com, alex.williamson@redhat.com,
 virtualization@lists.linux.dev, pabeni@redhat.com
Cc: parav@nvidia.com, shshitrit@nvidia.com, yohadt@nvidia.com
References: <20250827183852.2471-1-danielj@nvidia.com>
 <20250827183852.2471-7-danielj@nvidia.com>
 <a4532ca7-fee8-486a-9c5f-6fccb6de7b40@oracle.com>
Content-Language: en-US
From: Dan Jurgens <danielj@nvidia.com>
In-Reply-To: <a4532ca7-fee8-486a-9c5f-6fccb6de7b40@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: DS0PR17CA0001.namprd17.prod.outlook.com
 (2603:10b6:8:191::19) To MW4PR12MB7309.namprd12.prod.outlook.com
 (2603:10b6:303:22f::17)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB7309:EE_|SJ0PR12MB8138:EE_
X-MS-Office365-Filtering-Correlation-Id: ecd8d9d4-f4ac-4c9d-6719-08dde738fbf7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bFlmN0ZoVjhGZkpVVFBoS1prVVF2TXBTNC8zVUhzQXc2WVM0Sk1jNzJtdFNV?=
 =?utf-8?B?ZU84ZG1Nc25RMkQvLzZpQ0dhVGxDNGh2SGk0R2xVaG5nTWNjUGdyem5HZFZF?=
 =?utf-8?B?c2JPOCt3LzRSYUNhbE1hS3Q5cEpuSlZWbnRjZGZGeDIySGxBMWNwWXJRL1Jn?=
 =?utf-8?B?eW5UQUFjY2lONlBsNHRRVGxHTXhpdWthS0JrajJiazRYVjZPZC9QZkN4UUtZ?=
 =?utf-8?B?OEFDUmYyTTdPZDh2VU0vRFJiRmdETEVKalBaTUpTenA3SjFrWjBxcTgvdVVD?=
 =?utf-8?B?RVpDd09NWkdQS21nckkxbzhSY0hETElmcXBTQWx2cUZDWE5Vdkx5ZzRDRzZJ?=
 =?utf-8?B?cEE0UkV5OWZYaXhrRTNCb2tHbmMxVzJvTCswbFRpS0psdGkybGJXTS9iSElP?=
 =?utf-8?B?bmpibFVEekZPcnZ0UTAyMkt1UmVoYnRmZ3o2WE4wUjA0d2tuOENEU1NrWGsz?=
 =?utf-8?B?QjZEaXc2TFdWbFowRHN1b25JblV5YmhZSU42TEUvd1VWS05wYk81QUNxZWNC?=
 =?utf-8?B?QWNhVXB0VXdWc1ZERXlDaVBEVzRIRDVoRnNyNEUxcDJkWUZIVDkyOTQ4S2hY?=
 =?utf-8?B?UTNNM1V4Rng2M05FUEtHSFdHaExiSUZSOThIMXh2YXBsZXNFL0NDNWpyNTdx?=
 =?utf-8?B?Z0I0Z2c5N0JaQ3FpZzIzZjJxdGFSMlRCZkppc2JpOUtEcWgyVmJqZGt2STND?=
 =?utf-8?B?TExJcW5ybVByaUdYN2djRm94WlVTRHRPeEJMWDNqK2psT20yTFl4RDBHWk9w?=
 =?utf-8?B?eXdnRnBFekFGazZxWWtZa3RWRVhyeDBsbW10OW5qSW5zSXJQaVhwU1ZsbUNh?=
 =?utf-8?B?ditjZjF3L1pkM3JnZDhFUytkQTB5L0luQkFEaS9Jc1F3R3RFSzlmVDlqbThy?=
 =?utf-8?B?Slc1Q3ZXSmtzV2xLaVUrRTRXbmY4aXlERVFPVDViVFRaQ2NML2t4SVZWL1Ja?=
 =?utf-8?B?TWl1RUpka1dCTjJtNGpoUm5nUjd0bmIyek54R3huMndXQ1U3YzJxWFV1RS8w?=
 =?utf-8?B?MmNzRngwWTlLVytMMHludkpPN1hFYnAzSDZURnRTcldxOFp5RnVLc2JVL1RZ?=
 =?utf-8?B?WGhDanJyTDFrT0pxRlM0VWZUelVrV0xVMXdZSmlHRldNL0lnNUpiMnh1T0hS?=
 =?utf-8?B?ODJYZFVDVlJ0VkZ6Umw0WjUya3A5aEVIbFdvVkwwYWo4OWVFKzRKUFFkN2tV?=
 =?utf-8?B?Z3Y1bzhaR3A5Z2xmazRkNkJGSmJuVmw0cGJWZWYzVmgvR2U0VFEzeFE2OE0v?=
 =?utf-8?B?TFhIZUI0MklTQzdCKzRyb1lyVURpN2JONEpFaytRYmVnRWRYcHVtNVFkcjdt?=
 =?utf-8?B?VTJpNUtUbTZ0dXc5ZGVyVkZDSXIyU3FMeGZ0eER1c3F6aGdMU1o0NDBnZTNY?=
 =?utf-8?B?K2ZmUDRwMjRZcGo5eWlJMnhxdTEva2t2TTE2bWdmK1lSa0lSa3NVbzVTWVZN?=
 =?utf-8?B?MFowVjRyNHVNNWtTbnlISDdXSDNxWTkvZllVRjRXTjBlVmhWbmViMmJuTjZE?=
 =?utf-8?B?RENSTW5pWDl3SHluazM1bkFvWjlES2c0N2JKVzRhSEN0ek5EZ1owb0Z3U0Js?=
 =?utf-8?B?NDZXWkxML2pMWXQ5enZtcS9CSlgxa3g5dXJxVkw3WFFUaTdPN3N5MjBIS1Nt?=
 =?utf-8?B?U1dOeStHZWZUWDJlQnEwZVRmQkh6QTczNmE1WG93b2VKZ3loSVEyZTJMZG9T?=
 =?utf-8?B?amdYRXV0dHVwMHdNTVYzeXFLeHMzcnVQV1dqMXEvQ2xsN0MwUnlad3E5NWRZ?=
 =?utf-8?B?RkxkakhzN0RLLzZtSlI2V3lseS9vdno5KzRmWjJxZWNUaVg2WHBWUzVKbThE?=
 =?utf-8?B?eks4Z3FrbVQ1NU5Sd25QVjNRT1MwS29mYWJNT1hER0Y4S1ozclZaRE5ReHQw?=
 =?utf-8?B?YytCS3hzdXorNDIwT2tOQmE0Z3lHVllMOXFFV0tDdjRHbjNWckQySkVGV2Rr?=
 =?utf-8?Q?gxpzz8w1sRY=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR12MB7309.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZFFJUVFWS1dDcmpoelpQWStkWE9kUHBaVzZ0bWdSNUZtYU9GVmIrdlNPNllO?=
 =?utf-8?B?dDNJWGVoUHg3cy9ldnF3d3JkeGkvWExza1RRb1o0emhleTk1ZDJZRStSZEI2?=
 =?utf-8?B?bXZqbnBUaUNPQlRmYndRY2FHQys0MDBkd053cEZpS285NGQ3eEFvanJFZ2ln?=
 =?utf-8?B?WDA3WUowWld1VkNzTFI5QzZXaThzeGdqcW8vKzNFRUg5TlNDUXdsc0tuTXJO?=
 =?utf-8?B?djV6d1hMcExNT1JnMjZnQVd5MDVnMm9rUjNkN1RxSGVjejlUbXdNaTkvVkxX?=
 =?utf-8?B?bDRQR1FYNDZ0YzhybnpTa0dkUHppTHBZTHdIaXF4Zi9DOStNT3VXODBRS3hQ?=
 =?utf-8?B?am94MzdrUU1hTVJoTTdWeitKMTdxSGIvcWsyeFgxSENQeVh6NytsMWNDL01D?=
 =?utf-8?B?V0p3aXNTZ3BJaFNxUWI1TFZBS2pLYnQrTVU3YmNsQU1ZNFdIQWg0Z001b0Vq?=
 =?utf-8?B?VkRvK2JlcTcxZ1F5MzZNVmEyd3kzN2s1WE5BNUo3S1FjSHUwVHI4YmpMejR5?=
 =?utf-8?B?aE1KMTdESlJzclpHU3VsM2ZZMkdWc2xUZzV5clhYWHN1d0xjd29EdzdVbWxB?=
 =?utf-8?B?NitsWUlPTUp5bzRtSmlocUN1TC9xcm9tNnczSmV1L3ZqYThsRTVIdlhLVnp1?=
 =?utf-8?B?NXNDTmNPaUJ5R2VqRFpkODRoM2RJZnpreXRoakROdW5iRFZvY0ltaWIyazR2?=
 =?utf-8?B?SEtQaElBRzlKdmdUK3hkd0ZiL010c0JwL0VVcEdwM0lPeEY1QkRaQlNPYjJS?=
 =?utf-8?B?RGp3SDkwRExQVEZvN2p6cGk0Sk9RUlArZU14UWJQY0g3ZGVwZ3dhS0FWWkp5?=
 =?utf-8?B?N3ZDY1c3eVN5azZHejBqUVRvbkxHemk4cmlrQnVEbWo4ODFLNHA3cjJpbzlj?=
 =?utf-8?B?RVpTTnQ4NEZraHpXdXRITTJ4SXRLY0FzZUZQUEJhRTJDWkt4RkhnOXVSNjFQ?=
 =?utf-8?B?bWRPSW1hM1hKUE9ZN0xCWTREWDVScHovOU8xVlgvd2ZNdUJWSzJEcXpMSEFQ?=
 =?utf-8?B?TVFCWmluYVJUQUFHWWV3elZVaFN2c3l4OTBleURUL1VPWWJGcm0wZGVvTFJI?=
 =?utf-8?B?aFNzYUY0allqT0x5NUZaUlZGRVlPcWJDVlJHelJPcU1iN0RwUHFDYnRySSta?=
 =?utf-8?B?djBjM0x2cW54RG1oa1FJMFp1T0VmcTFoeHRBSERWb0l5d0xhZTRQZ0xuazBp?=
 =?utf-8?B?TDR0MlQySTRWM1N1UFc4NEhtc1hDOUppcFluN2dRQlZsSCtGdWRlYUN0WkdP?=
 =?utf-8?B?SGI0VXd0WWpCcm44clNjcGk4d3FmbUNPRXg1d3F4T0xMRjQzVWtEakw2RlpY?=
 =?utf-8?B?QVN6UER1UCsreTZ4THcyaGtDMmVTZUljc3dLbEU4dmxhM3V4ZEErQTFvYmt5?=
 =?utf-8?B?NWhQTWl3MjIwSHFLWFVQREJnbVE1Y2tDVW5tb2lmbGNveTFmZC80cy9jUHd5?=
 =?utf-8?B?UXQvREx2aU13c3pXSE1YTDlMTUNxV0U1SlV1eHJ4ZlcrR2oxQWt0d2pIWVBt?=
 =?utf-8?B?bXNSWkdRMkdCc2FBZXpvOUNJOWVydmZpVnZ6TkxiTEYzeXZ0RmdTR2ZRK29U?=
 =?utf-8?B?c3hUekVBYXhBR25vWW5heVVyZERjWVJIcWdITGVMWVRrV1NVMzhTbGQzQVFS?=
 =?utf-8?B?cW5TU0F4VGh3UmZlVmp2WjZZbFlNTGh1NHhUNS8zaHdYZmJZMHRoQmhsV2U5?=
 =?utf-8?B?SVJ2V3lJQWFOSWNaOE5vTVpPUlUwUHJ0b1Jwd3E5d3dnRVpZakI3TE04VHZF?=
 =?utf-8?B?YjhIN0FaL05scUh6Qzh6M3ByQ3VFMG1yU2xnUmYxdFFwNm8rQVJ1V3hWYjhy?=
 =?utf-8?B?YW1uNmh6dVY1bU9TLzNtV1h2bFlDTW5CVkpPZ09FcnM2MVNmY1ozUDI3UGhx?=
 =?utf-8?B?aVZCTy9PaVhOMERpRGFYU1lNQUJGSlBuaWlmNjBnZjJ0UUZqZ3h5UzVOWkw1?=
 =?utf-8?B?SGNkRjEyVitkbXR6dmxpUzMzZkluQUhGTExuT0FnNHZlOTAvdVcyMWYzOEFK?=
 =?utf-8?B?TGVmcHMwRUIxM05GU0RQQkRETzlzRVNGb1NFYjNqTCtGdElGcWFYeWg2aGtx?=
 =?utf-8?B?cnZ5a1BhdTdDV1ZmUERHdUxZcTE1NjRjd1dlZk15Tm5DSE00VHJBTWJDNkRI?=
 =?utf-8?Q?3BCyqp+W6SHJ4NSlUev13KnsI?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ecd8d9d4-f4ac-4c9d-6719-08dde738fbf7
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB7309.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2025 20:16:48.9777
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Gf0DgLseJ/wslcEo03VbMlLTDVuZrLYo8KaDUpG9cPdjZC+OM7gjkVII3AUZdhOaQbpJMTl/1ZbCzD3gWVbRDQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB8138

On 8/29/25 1:39 PM, ALOK TIWARI wrote:
> 
> 
>> +static void calculate_flow_sizes(struct ethtool_rx_flow_spec *fs,
>> +     * header for each type of header in the match critea, and each
>> header
> 
> typo critea -> criteria
> 
>> +     * providing the mask for matching against.
>> +     */

>> +    calculate_flow_sizes(fs, &key_size, &classifier_size, &num_hdrs);
>> +
>> +    key = kzalloc(key_size, GFP_KERNEL);
>> +    if (!key)
>> +        return -ENOMEM;
>> +
>> +    /*
>> +     * virio_net_ff_obj_ff_classifier is already included in the
> 
> virio_net_ff_obj_ff_classifier -> virtio_net_ff_obj_ff_classifier
> 
>> +     * classifier_size.
>> +     */
>> +    c = kzalloc(classifier_size +
>> +            sizeof(struct virtnet_classifier) -
>> +            sizeof(struct virtio_net_resource_obj_ff_classifier),
>> +            GFP_KERNEL);
>> +    if (!c)
>> +        return -ENOMEM;
> 
> kfree(key) before returning -ENOMEM
> 
> 
> Thanks,
> Alok
> 

Thanks Alok. Applied those changes for v2.


