Return-Path: <netdev+bounces-192643-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 42E08AC0A22
	for <lists+netdev@lfdr.de>; Thu, 22 May 2025 12:56:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AF03B7AFDB0
	for <lists+netdev@lfdr.de>; Thu, 22 May 2025 10:55:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 329512882BF;
	Thu, 22 May 2025 10:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="BWtNsuSw"
X-Original-To: netdev@vger.kernel.org
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2074.outbound.protection.outlook.com [40.107.95.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D6EA33DB;
	Thu, 22 May 2025 10:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747911384; cv=fail; b=OMI7Eh24iQIayiDopfXbJE1LV1BtSL5fbfgBIsXtWM5Vpzkqt3/DpcNAY0iE7MDQyGq5c7pHj2I853y/0M4WqYAFcrbFIqfEraUu+ajw47uSkDY4Wjv0N0Kz6S3EY8Wl8GX7ag65I64xRjrc3IHBcwWEJA5Spf8LwMyBtdcEXvw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747911384; c=relaxed/simple;
	bh=BlegJBb6b0rA1sD2ZMKwV2I2Pv5r2vKypsW05luTrps=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=KB1Y6N4ZsANzQgw2LWi33l0ONFzUlFIJgUe65xdVtAsL1C71dxs7jSYiURw2n9MIK/v93ss1w+HXz/ntSW7C64j+EZ03O4LdBpAqbsQ+prtkovc3SGpBqKbV127c1HaM3As2SmtwSc74Gl/TwNFi1xDsIda7WpeCrPD7EMsZrOc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=BWtNsuSw; arc=fail smtp.client-ip=40.107.95.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NoCwHi0VIu5OtWmy4b/aYarFmnRDOBvKRe5KHfrhc04JrFBMfTyyrWnIl3qgWyx8eOxKdSpBdjUhcheonB2RqTUVo1eNpsBuN5s+lGlZInjRypYIVnVXCt2RyIOSuJz1n/XSF0FyfqkLV5Sk91+UZbo7/YngzLK1RSdkF3FKulV5uTg+PBUVPzlTGDwpnyYv8NNLVtzoCbRCaa71ZE9OTeknXMNCGV2CeSrwBASVUMcVbrEw/MqyElb0OmXcvP14qELaNw6Ew4srjdVP+OfXaKdV+cgahlb1tLe1DeLxZUnQMbay5ZKrwf6egK/9ESEPxXLqoYDbK960k8KAr6f1QA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iI23mYY1s3aMcTemvfP/kIKhHZabemJyeztk84LR6GY=;
 b=Gd+k+b40koj2EVpaJPOM2uv6ze5n4q8gUHkIGEl6jZsp27qE5MtQ2gjdveS8TWYRrXVUCyX2c4FazbsiDWXnyiJPZ55m2DzrBbVCCIwFRdGqAQRjTkrJuSWEUbKrsWydC6FpBHyAlLIQ2KsWsuPCC4CSf23fEKgUDrWgwIsxDRllXRbSsEcYHsRj/NO/ZHnSS0TEiYTh2zcO5GmBbs3y7CykoWSQdjIskBhS0+cW57EvXihbNKkE/xtomGhI6D/bPD1GE0ZENTPviIfh2sfY0UPmeaCIIF7OGVYv6xJAc1X9GnNkgQFXvJpImFDC2xvz1Lu4tu4UlyBYVxngK91srg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iI23mYY1s3aMcTemvfP/kIKhHZabemJyeztk84LR6GY=;
 b=BWtNsuSwaGKXBtbyqj0/rch6BNwNi3wvmktWBMCAQVzuBZs0vx5S3vPx/vB994B3dsQ/FQAQJ/Hc0QztaOcFH+bKcwse5Ze+LevPD20ISauPbumVs+GB6RsdsXDI/EzANwt1PVF4jTru/I1MxkthEOq+zgdxCacyihV0MsfDrHs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4202.namprd12.prod.outlook.com (2603:10b6:5:219::22)
 by MN6PR12MB8516.namprd12.prod.outlook.com (2603:10b6:208:46f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.21; Thu, 22 May
 2025 10:56:17 +0000
Received: from DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79]) by DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79%4]) with mapi id 15.20.8769.019; Thu, 22 May 2025
 10:56:16 +0000
Message-ID: <b30d7195-fb0b-4ba5-a670-342eb5516605@amd.com>
Date: Thu, 22 May 2025 11:56:11 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v16 11/22] cxl: Define a driver interface for HPA free
 space enumeration
Content-Language: en-US
To: Dan Williams <dan.j.williams@intel.com>, alejandro.lucero-palau@amd.com,
 linux-cxl@vger.kernel.org, netdev@vger.kernel.org, edward.cree@amd.com,
 davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, dave.jiang@intel.com
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>
References: <20250514132743.523469-1-alejandro.lucero-palau@amd.com>
 <20250514132743.523469-12-alejandro.lucero-palau@amd.com>
 <682e2a0b9b15b_1626e10088@dwillia2-xfh.jf.intel.com.notmuch>
From: Alejandro Lucero Palau <alucerop@amd.com>
In-Reply-To: <682e2a0b9b15b_1626e10088@dwillia2-xfh.jf.intel.com.notmuch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0573.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:276::6) To DM6PR12MB4202.namprd12.prod.outlook.com
 (2603:10b6:5:219::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4202:EE_|MN6PR12MB8516:EE_
X-MS-Office365-Filtering-Correlation-Id: 6b17e330-d34f-454e-3ce4-08dd991f463d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?OWlrRm8raTJZSlhMMkVFZjU0dlhucitURUc4V29IQjNXZzhRL0RlTVRtR2M2?=
 =?utf-8?B?Qk5hdDdLT0NYYkZEZ1d3Sncxc2JPN3c2UVliVVFBTVBxTHVkUlh0L2RTQUkz?=
 =?utf-8?B?Z0U1dlBDd09iOVFxSEljWSt0T3owV013WkJ0NWFrWUpJNG8zY3pHRTRYcWsz?=
 =?utf-8?B?dEVvbzJTZzZ1bXFPTE1FdjQvbkFNUjJaRXZzd1p2TFFNTGtNS2hPMXpwamIz?=
 =?utf-8?B?V1RRRE8rR2VOemxleVY1TmQ3RFpaME1HQnV6czZRV3VUWHhKc0ErY1J0eTRm?=
 =?utf-8?B?YVloOTd3TkpJcmtwME84a1kwUlVKenVpUHROdTdsSWQrRXZPQm4wZS9NRWtk?=
 =?utf-8?B?Z0k3MU1UaXVqVEM0WXhYSU8zcEFNWFdZd2NPb2FweE1ldFZHNXJnRHEzN2Vh?=
 =?utf-8?B?cHIwdFNKMC9hMnhjRUthRFhFMEtFVmNZVDY0YnRzQW9rNjBtWVJ5eU1VaHov?=
 =?utf-8?B?L2NUOEhudHp2cUIzbDVndU9VWDRFNTFaOTRpbEhMZ1VSSVdORkxsOHAvRDRY?=
 =?utf-8?B?NVdnTmZySGFZbjhhd0NEUEhHVVdJdEhZKzlETG12MEJPNkp6R295YmZGUFB3?=
 =?utf-8?B?WGk4bmdJNTNZQUNHV2R0VHI2T212OGxudGxVV1dyanVhZ1ZGRUMvRHo2cmlZ?=
 =?utf-8?B?d1VoNndxQ1VTbExQcjg4R09ldHJiRUJrTW5KNnVyS012U29mL2k2NGNWTEdo?=
 =?utf-8?B?MlBSdnBKdHN0N3g4Q1hkV0NFbmZUM0VDbTQ0bUpPdkV4bGU4Q2JUY1RuVzFk?=
 =?utf-8?B?UUVnSk9ubTk0Sk5HTnF4ZStsYmJ5aHNWazd0Q25JNDNLZlJVZU92SEdwME9M?=
 =?utf-8?B?VU94dDdlaEVjenlzK1dZa2lQZ294ZXVnNUZBWUI2Tm51Y1dZaEVtbWJTbnV5?=
 =?utf-8?B?MFd4NEhINnN4MmlyVXdBbG5TMmc2cnBwOGRNK2ZqTHc0NURXMDYrUko5VkpK?=
 =?utf-8?B?SEVVYWZQRXNIcTlqeHJVYzhzd3RGOGx0c255YXZkQllMc1pULzFNSjRyK3ho?=
 =?utf-8?B?Y21HYmtYeHRTMW80K3gydm90MldHUWdPMy9hWXIvTitmeDZqTVplVFJ0RXVK?=
 =?utf-8?B?NjlSVXduRDJKRWxGU1lTM3ZYTTNrOWJmTVZJRVM3a2V5RWlmdzB2a3Q4OTlC?=
 =?utf-8?B?UGF5ZlRYWDdjb0pTSEI5U1ZWbk11SjgrRmpaVjdlWVh0S09mblFTN3ZxZlRr?=
 =?utf-8?B?U3o0eUxnUW5aeUNuV094NWNzSC9jd25qcWR0emJYOVdIN2k1dng3Qkt1dHBM?=
 =?utf-8?B?TEYvcWZlUFdja2FIcStCMkltWE1PdXZreUJEeGx1Tm1UZjFXUDdYUURFUkEw?=
 =?utf-8?B?RnZsaU1UR0crSjRuK2JCK05DaHdOSk5XQWNQeElzZHZITVdUeGVMSW9pOWRj?=
 =?utf-8?B?bW1xd1RqdFVVbldzbS9HOXc5NUNyMzR4ZWhjWFU1Y040SW5qS1BGcGxuanBk?=
 =?utf-8?B?bmdQU25kY2ZnWVJ1VjByZFpFZWd4UU85MUlka0ZwUFNjbjhrcGpuM2NRVm93?=
 =?utf-8?B?cnVNYW15SkVvdWVZMi9laUk2ak9YeDJzUmZMbG5RUElYaTlGdWprRjRjL1hP?=
 =?utf-8?B?QTVET2dEeHh5RmMxQk9aOG5kYzhabVJ0VldwTTVMZTVLa25iNVNJUDI2V0ZR?=
 =?utf-8?B?TXNXZGQvSDh4d0V2SHdwQUw1TktubU8vcWh5dVo3RE9nMVdHZHh4Q2o4N1VT?=
 =?utf-8?B?ajRZZk1NQUVEbVNhQ0YwTWI2N0NNbjJKREJmVUVaQkVud2djblhQR1d3cldE?=
 =?utf-8?B?OTZLS3hOUzVkclRFK0tEeDF5aGFNVHR2QUViRFVSYWI3MXkrSjdKOUZpbmdL?=
 =?utf-8?B?b2dURnBicGZKa3ZDRGVnVWFVQnVmYVNLVWNtN2tHVDh6ZWxTdUU4R2hRZmRu?=
 =?utf-8?B?RnVUKzJwNVNEWUpvKzFadm12aGFCM2NMZnJ4UVc2Zm9LMkE9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4202.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aG5XRUFEa201K3JJMi85Y21XVzlvenE0N3JJanlkK3ZPYlF2bStwWmxXeDRi?=
 =?utf-8?B?UXo3R2tjMExtRTFkM3IreklldEZvZEw4THFwUEdreDA5d3FoYmtwQUlpVkNZ?=
 =?utf-8?B?ZVZtdTBHa2MvcXc5Vkh2c3UvdTRjakhyWVZ3UERTbncyNDJPTWdVekE1U25W?=
 =?utf-8?B?ck05WFpYa2pyblpScGZWczN3UWFncm1tWXhvZGNMSnFuYk91VjZGbkNmcm1G?=
 =?utf-8?B?TWhFaFBjUXhjTzlzWUM5NzM3YkVhQlF1VWNDc09FdHovcmJjczdidHBIb0hU?=
 =?utf-8?B?STdCQmx6M0w3OEx6ZFhTRk9WbnB0UU4zSmFrSmNzOXJDZVhXTitNSVQ4S0FR?=
 =?utf-8?B?ME9ZeEttMWFHN0ptd2U0NzlKK1VTTUlVS0VxTmVrVmE3cTVFSWdmbTBkYjJ4?=
 =?utf-8?B?M0JVNVBDU0ZCaWJ6ZlFIZm9RUWNJWGwxQXU4Qk5QZENuWkl2Q25GcExNdWc4?=
 =?utf-8?B?RzRFcmt4ekpsd1FsWkhRVHRKamhwMUZLMTR0NENzK1JHNElyTzhKRFQ5V1Bo?=
 =?utf-8?B?d1k5ZkhIL0NHdGZYa0tYZHJwZGROSVIwYW1IeUJtUm5nNkpMMVhzSitmVFFO?=
 =?utf-8?B?SFQ1NVozb2tsL29WRWVlcDhZTHZIMUU4TS9Cbzg2Vms1SFhmZVNGb3dXV1BZ?=
 =?utf-8?B?eU5UZWhvSXdQVWJuZldxTlhSaGtobmpKZ0M4YWJZQTdrTGc1OUJlTnBvU3hW?=
 =?utf-8?B?VVdnSHlFZk5kc3V4Ym9acDIxd0RtMk1SUWlvcnZEVWR2YkpocHdyd0JqR3l4?=
 =?utf-8?B?bEJSTFlCOVJJMmlmUk1WVW16VDl6MkhmWUJHbVdjME9ZWUxoMms5VyswdjBS?=
 =?utf-8?B?d0NuVGlFVEJRcGRLd1AwaU5xcjlmS0R3d3pFeWprMmJwejlKVm5oV05sMEVP?=
 =?utf-8?B?V0tjckZYdzAreDN2TndkSHdaa0VpQlJvWGNwL01wbmFmYjNGT1g0dHdPcG5F?=
 =?utf-8?B?UUUxTlZKWmVBLzhWWWdPbHg0TU5HazVTVERPYUJCWVBzWFBxdG4yM0hoUlU0?=
 =?utf-8?B?TWJ4RzRFYmkzbXhLY3p6OHNvYldIMFdDRFE4dThyZE9wZUtNSVNVZDJnWWFE?=
 =?utf-8?B?T0lVck5nd0ZKMHZPaER1WC8vZzYrRG5sZHZvRjhaNjNCM2xtMDc5TkEyUTZj?=
 =?utf-8?B?SUFHUDh5b0pqRE9OZUJETEZibTJqdUdCS3ZLQUozZWVSUE4xZklSNVc4NkpE?=
 =?utf-8?B?UW5HeVRzQmZqaHlURGJUK2RuM2lFa2I4YU9ud2M2cUNqV0dkSmh1TjZNamV6?=
 =?utf-8?B?NjlMSStoVUlYekwxa1FtY1Z6Umk3WUpXcWhNU1lyZWxBdmM4T2NuQzlkampn?=
 =?utf-8?B?UFlNTkpLSXBNOEVyMmNuZ1hEa3RTd0o2bkZ6bDYwVmI2VG1GeUxvZkQydUta?=
 =?utf-8?B?cEY5UkZWY3h1VDNjcHVCVHdOa1Z2ekVvSWI5YXdDRnNrUlhFN2ZTVloyQXR4?=
 =?utf-8?B?L01SMzMxTEVsQmNkaldQMFJnNFQzK2hVT1l3ekljakdCZlJMekc4cUF6bXNY?=
 =?utf-8?B?R0NwRXZ3NmE1ZWxGSG9NWURpSlFHVUdPODR3THo2U2x2enl0MFRRRWRLV2Vs?=
 =?utf-8?B?WUVzbFhITW5NYUFYc0RJb01ZRDRBMkpDSGJuVnJQaUtxUURLRGZGaU15TGZm?=
 =?utf-8?B?U2I1dW56VlM2eGpqOEZHdzhVWElmYnB4UTFGNVdHQU1YTjFVTVVwaVBjZzBq?=
 =?utf-8?B?TXR0S3A3blVoTXpnV2Q2em1vcllRS3RNMzYxaXVWblROeFBKeHhUelFnOWs1?=
 =?utf-8?B?MzVjdUt1UnU3bTh6aVVRdzdrVkZicnFSVGdCN3h2YzJtNzQ4K0F0eGNVY1hI?=
 =?utf-8?B?Sm1vendjV1l3ejc5Q0dWWjRzNWVwKzBRM0g2ZUErenVqSTlIUkZieGM0dElB?=
 =?utf-8?B?RFNDVWE3eElGTE92aC80UEZBY2lFcFp4UEtHcU1Td2pnK1RTbzIvVS93R3lM?=
 =?utf-8?B?dFpmeWNlajJsa01DaHhwN2NMTjVMbVRDOGdZUW1iRkJZaUhWdUpJWHNzT0tD?=
 =?utf-8?B?OFhnYUViYW01UTBoU0NocjZWbUt0VEV2MkVDWG1LMTRhUnhiVC9kdGw5YnFp?=
 =?utf-8?B?TTU5OGFBajZucEJpcS92UzlPQ2IvT1Zmei9keSs0dDFpanQ3ZHhoZGp0aEJn?=
 =?utf-8?Q?Q4zMGD5efkeuIfUFHbxrZQlNh?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b17e330-d34f-454e-3ce4-08dd991f463d
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4202.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2025 10:56:16.2769
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pRyXoDbllDQYvIrBtS34kdj8yxLwPXVriOlC3leeWKW3qCAajtyJ9tAp4UpveV7Fgo8WegpqzQSPIRcMF16RQw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR12MB8516


On 5/21/25 20:31, Dan Williams wrote:
> alejandro.lucero-palau@ wrote:
>> From: Alejandro Lucero <alucerop@amd.com>
>>
>> CXL region creation involves allocating capacity from device DPA
>> (device-physical-address space) and assigning it to decode a given HPA
>> (host-physical-address space). Before determining how much DPA to
>> allocate the amount of available HPA must be determined. Also, not all
>> HPA is created equal, some specifically targets RAM, some target PMEM,
>> some is prepared for device-memory flows like HDM-D and HDM-DB, and some
>> is host-only (HDM-H).
>>
>> In order to support Type2 CXL devices, wrap all of those concerns into
>> an API that retrieves a root decoder (platform CXL window) that fits the
>> specified constraints and the capacity available for a new region.
>>
>> Add a complementary function for releasing the reference to such root
>> decoder.
>>
>> Based on https://lore.kernel.org/linux-cxl/168592159290.1948938.13522227102445462976.stgit@dwillia2-xfh.jf.intel.com/
>>
>> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
>> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>> ---
>>   drivers/cxl/core/region.c | 166 ++++++++++++++++++++++++++++++++++++++
>>   drivers/cxl/cxl.h         |   3 +
>>   include/cxl/cxl.h         |  11 +++
>>   3 files changed, 180 insertions(+)
>>
>> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
>> index c3f4dc244df7..4affa1f22fd1 100644
>> --- a/drivers/cxl/core/region.c
>> +++ b/drivers/cxl/core/region.c
>> @@ -695,6 +695,172 @@ static int free_hpa(struct cxl_region *cxlr)
>>   	return 0;
>>   }
>>   


snip


>> +struct cxl_root_decoder *cxl_get_hpa_freespace(struct cxl_memdev *cxlmd,
>> +					       int interleave_ways,
>> +					       unsigned long flags,
>> +					       resource_size_t *max_avail_contig)
>> +{
>> +	struct cxl_port *endpoint = cxlmd->endpoint;
>> +	struct cxlrd_max_context ctx = {
>> +		.host_bridges = &endpoint->host_bridge,
>> +		.flags = flags,
>> +	};
>> +	struct cxl_port *root_port;
>> +	struct cxl_root *root __free(put_cxl_root) = find_cxl_root(endpoint);
>> +
>> +	if (!is_cxl_endpoint(endpoint)) {
>> +		dev_dbg(&endpoint->dev, "hpa requestor is not an endpoint\n");
>> +		return ERR_PTR(-EINVAL);
>> +	}
> This seems confused because the @cxlmd argument is always an endpoint.
> The dynamic state is whether that endpoint is currently connected to the
> CXL HDM decode hierarchy, or not.
>
> That state changes relative to whether @cxlmd is bound to the cxl_mem
> driver. So the above check is also racy.
>
> I think this wants to be:
>
> 	guard(device)(&cxlmd->dev);
> 	if (!cxlmd->endpoint)
> 		return -ENXIO;


It makes sense. I'll do so.


>> +	if (!root) {
>> +		dev_dbg(&endpoint->dev, "endpoint can not be related to a root port\n");
>> +		return ERR_PTR(-ENXIO);
>> +	}
>> +
>> +	root_port = &root->port;
>> +	scoped_guard(rwsem_read, &cxl_region_rwsem)
>> +		device_for_each_child(&root_port->dev, &ctx, find_max_hpa);
>> +
>> +	if (!ctx.cxlrd)
>> +		return ERR_PTR(-ENOMEM);
>> +
>> +	*max_avail_contig = ctx.max_hpa;
>> +	return ctx.cxlrd;
>> +}
>> +EXPORT_SYMBOL_NS_GPL(cxl_get_hpa_freespace, "CXL");
>> +
>> +void cxl_put_root_decoder(struct cxl_root_decoder *cxlrd)
>> +{
>> +	put_device(CXLRD_DEV(cxlrd));
>> +}
>> +EXPORT_SYMBOL_NS_GPL(cxl_put_root_decoder, "CXL");
> I think this cxl_put_root_decoder() requirement is manageable for the
> for the initial merge, but it is not something to commit to long term.
> The device's HPA freespace and CXL HDM should be freed at cxl_mem detach
> time, but that will require more infrastructure.
>
> The reference does not stop the root decoder from being unregistered and
> it is clearly broken to allow it to be unregistered while drivers have
> pending allocations.


I agree all this requires to address those problems, hopefully in the 
short-mid term, meaning follow-ups of this patchset.


