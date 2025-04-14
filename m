Return-Path: <netdev+bounces-182306-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 44C7CA8873F
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 17:33:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AC137188B441
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 15:20:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A1C0252297;
	Mon, 14 Apr 2025 15:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Bd0DpKjm"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2056.outbound.protection.outlook.com [40.107.236.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DAD21FDD;
	Mon, 14 Apr 2025 15:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744644030; cv=fail; b=iaf5/k7ILS6FI9OmAZkCx9I9Xa0KHYTlJwcxw3bpO14hMZWx8yDhpOdCWU9izNK0XJim1qFalRME7bQ+daiKFul7e5H8DREuOCLveedu64nGQakW5HYsGVvbEmp9trsvntm4baVVnD55BS5Vctzi6gPzbln+YszWhAvK43WKxy4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744644030; c=relaxed/simple;
	bh=t+YswpfkbYsv7RWoVRiu1SKRh83WhWRemY9Y30OQWz8=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=gAoyp7PJ1VEf7+Hny7YSvT8JUELq4B2GCwPHXjdyrovvQhnvk0mqvbynuh3Qbre2OmvcMX4qzHh5/rjgQY+Ire4FJseXfHl8g3/7W+KfanWzkdqE3NFjotIRsBZYT4IPvX0adAub1P9W6xzaXZ3cCAnZ3msWYeNcMKXx/x25vUs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Bd0DpKjm; arc=fail smtp.client-ip=40.107.236.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sZnpz8lWppl1ONwRyUOSCYt26jZy2jJ2omohQyBAusJmceXieglR0gArW7EwAbRZ7Qu2kDbmodPPlL36t5+Iwm/2xUEQEpZWHB7hYV11A73JX1DHSPOVs7MbMVAfB98ON1wbTMUwOw7/3xyo9Tbtm1UWe6P66Op4N8ilJk78jlcgjgGDHaZQn2D75lXAeJEP4NnckqdtkGoxXEGglvnemRUnd9I0bQ/jeCI+blpPotUrWipERIeIFND/pTJuOWA4GNgC8WSrO60x3XxQm+0g8VfIDKR82wOzxPM0+XFuq+l1Oqp2SQNS+Y+mi2EOEwjl7jR90c8VxThBcdfsApA1zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v0kikZULsFeV8Ba8jSmW+zjkmf9sAtw5J4t5WgFFDQU=;
 b=bFnwRX9q2k38s5U+LNEC66KmnjTCFNIgUUucDMAEu4gVH0T8h9zFaEkq5cwfp+AUXdAzqb/c8ujrW/1fjOhGFuvZD85IogRwLDRLzgZNPKhxpamwFFpcvp9ye0JWLUeroLLkPj1Rrc0HFQSOAeu0RGgd+LEG9zSUTsllJ195rVQsgO+GBD2wjqzcBeAUbHiym/wAh6vyjk/Xd0P33/UmGKFMK98ncgxm0R1b7kKR6cIWCBVO7gfRRRSUkZFDpNygtHlZaigKlHIzTprrQ+qRiL4CVuf+7lfeAY4yfvmon0N8lHBYBDAlJcLihIde418/mVHvK2/cXlrucUAhu563Fw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v0kikZULsFeV8Ba8jSmW+zjkmf9sAtw5J4t5WgFFDQU=;
 b=Bd0DpKjmHOClBUh3q9i6P6YmSKvPgWuJZoNPKqKe4yS2/CajLY5wE5+GQDaJrD7Zyl4h7XW9HY8rk94FjaDn7kiCt8YV2CHVk5Dnd2BnxhGZ5woQHpja73F0wxfWT8q7ncZ12QFHjxOMVGVvakiXJUoaDUhaIVGc/NxwbGamUlQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4202.namprd12.prod.outlook.com (2603:10b6:5:219::22)
 by CH2PR12MB4326.namprd12.prod.outlook.com (2603:10b6:610:af::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.34; Mon, 14 Apr
 2025 15:20:24 +0000
Received: from DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79]) by DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79%6]) with mapi id 15.20.8632.025; Mon, 14 Apr 2025
 15:20:24 +0000
Message-ID: <8ed8151e-0f89-4102-bf49-7e6aab5969d8@amd.com>
Date: Mon, 14 Apr 2025 16:20:19 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v13 00/22] Type2 device basic support
Content-Language: en-US
To: alejandro.lucero-palau@amd.com, linux-cxl@vger.kernel.org,
 netdev@vger.kernel.org, dan.j.williams@intel.com, edward.cree@amd.com,
 davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, dave.jiang@intel.com
References: <20250414151336.3852990-1-alejandro.lucero-palau@amd.com>
From: Alejandro Lucero Palau <alucerop@amd.com>
In-Reply-To: <20250414151336.3852990-1-alejandro.lucero-palau@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO6P123CA0034.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:2fe::16) To DM6PR12MB4202.namprd12.prod.outlook.com
 (2603:10b6:5:219::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4202:EE_|CH2PR12MB4326:EE_
X-MS-Office365-Filtering-Correlation-Id: 728e6833-d2bd-46e8-32b2-08dd7b67e0db
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UUNxeXhhcHdOS2FGODAzUHFNc1N1cTRZWGVXYjJrUW1XeXpsTEhJV2FnbGxl?=
 =?utf-8?B?TGt2QlJHN01sbTl2cU5MSnVmK2hjMnNNb0VMWGc4a0loRXdJU3RTdHpMT21S?=
 =?utf-8?B?UU1ZOW9HL0tleDFtcFVRRGJvelVCa0xCV2dJZG1SMGpDRW1sdXRCRFpoS0lL?=
 =?utf-8?B?RlI3emwyRHBJcDBrWit0WDJRb1oyTHljQm1pS01oWjhGM01IVm0xSFl0aXVo?=
 =?utf-8?B?Qm5BakEyRm1EWTQrWVhhQVA2ZHE4RjVIS0Eyb0VuZTl6MzZqQVpjUGJ1alFj?=
 =?utf-8?B?YzBYcE5UOXlTcWV0UXNXNVdnTnd3WTFKNU9wU1ZVSXR4V20xaHMzNGcvZFV4?=
 =?utf-8?B?MjROZ3FDMHlOUU9JQkxXMElhdll6cTR4TTVOQmRLQnFQNGlxdVFIMGxnUHN0?=
 =?utf-8?B?UC9pY1ZtUE5mUmNWSHU4dm1DWXJzNEMyeWpUVDFRUW5haFZ6Tk1qWlZmMWJL?=
 =?utf-8?B?N0JZZW9rOUs1VDVMRFpTM2VTQ3RIall5dHFFYTZkOHBaRmdFUDJaTmROQ29m?=
 =?utf-8?B?Y0owdDIwNHFPb3RodlVKVVNmR21vWkIxdFZ6K2FVUHc3RlVLM1ZuZTAwdlBP?=
 =?utf-8?B?ZzJZV1o5ZUphb3ZEK3hEUWJMTy92SmEzY0tXWkZNeWh1L0dETEhPZlJBaFQr?=
 =?utf-8?B?S1FnRE5KUGZTSW1zYTNvdVUwMlpWUnFxY2paaHhIbVhLcmhqZ01PL1lPdjc5?=
 =?utf-8?B?YWlac2NWTlZSKzI4MVlGSWZvanloRHpPN0RtQU1lYmEwMFI4c2lBd1c2Qlhw?=
 =?utf-8?B?OW92OXRNUHRFUHpjcGFhVWppNlpwYTNVdlp5bVZxVnBlb2ZadEhmbTRJWnZr?=
 =?utf-8?B?STRZTmp1aDNsaTVQQjNzSFJUUUNnMWxsM2l4Y2lTOTBIaWpaQXowM0VMb0k1?=
 =?utf-8?B?WXRpSXVCcmpTdXZISWlxdDhsVGJsR1piWnVnMGVRQ3g1WU5XZXd2aFhZSlVn?=
 =?utf-8?B?ZVpzQk1DUFNLbjdwdjBlUFl4Z0FQalQ3OWtlYUFnMGFGREQ5YTIraDc2UjZB?=
 =?utf-8?B?SndIVUhka0R6K2VyOEYveDgxQ2NJeTBXUWZDdFRIVDB6Q0ZkRjlodzQxYURI?=
 =?utf-8?B?YnM0QUhWbmVIOVVjZVBtSmQ2cVFTSGZnalJCOElJV1E3TVBjQlZ6bzBIQ2Zt?=
 =?utf-8?B?QWZtR2RBTjJlelZZR2x2eEIzTSt3VE9WQ085Rkw5Mk15amRTT2F1Wk9SNlow?=
 =?utf-8?B?cWVPSkIxdlFkYXIvdGlCSUVjRE52QTlkWEJGbE5TSXpwcmFhblJpS3pzeFcw?=
 =?utf-8?B?RGFybVB2bXZPbks2eCtCYUlDem9XbExoSDlwM3R6Rm5ZdEQrMWcvNXdPNkgx?=
 =?utf-8?B?MmJKSVlMVjJhZjJVYUo1MjZoWjNDY1BaMnM5enpmT1hFbGJMMDJIL3V0elVt?=
 =?utf-8?B?VGZYV1FBbmw3K1REeEF1OStMdjBvdlRlcktaeGVKUFptWXplWmhkeHRyTFlx?=
 =?utf-8?B?Z05BSTNoWVRnOE1XdlFjcUFsNjJ1TC9HNEFXaTk3V05ya2s4dFM2dVlhZXJQ?=
 =?utf-8?B?eVU4V21kSWdJY0lnaHBHcHN6QUdibURLVGRPaGZkOEdOK3dxZlZZQ0F4c0hr?=
 =?utf-8?B?ZjBBbjFLV1N6KzdPRzJ2S0NROVNHRXJtOGxKNVloZUVtSkJDb0xQN2JidTlJ?=
 =?utf-8?B?K2RRVUxucGdzR3JoWHNDcWJxM3pqRzVucG1FeU5VcEY3WkNUNW1YZmtmOWFF?=
 =?utf-8?B?bXJ0aDBpd0YyWlM2OUZGTzM0ZzNEd25tV29ad3d1a0FUbUtGYUwyNlZ3Q2ll?=
 =?utf-8?B?aFZXRy8xUTlhU0wySWpxcmp0VlBHNGxUcDZWbUtDVXB3dTZGdjlWVHZjbFBz?=
 =?utf-8?B?T3FvMGVWdGQvUVNPMnh2YjEzYTJ6TGhTOVFJK1VUa2xTZ09DWVFqaWxOMHlI?=
 =?utf-8?B?SlFQNEtDSEFyQlU0bEdGeUdIMHIyalQ0US9aUncweURIV0EyVlhWdjNVS2Jy?=
 =?utf-8?B?RTRMcEJMeVdxeFM3a3RGd2ZCb3dDK2s1bGJrcGNVc0orcWtDWHhqSDBOOC9y?=
 =?utf-8?B?MzBVNnFCcVpBPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4202.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OFdoZkZlT1pLZSt4TGJ4a3NsVUlPMVNSUGtlRWZPaDE2N21OMis5Q0g3RG5D?=
 =?utf-8?B?alc0NDd3eStDck1nN3VTUjFFTFdMb2k4dUR3endIbGs1ME42UTdWREREdHpX?=
 =?utf-8?B?OG1HWEIxVDIyNHp1L3hoaWh0MHhmUjV1M3FaaUpSMCt3VEFrZTdUY3ZFQkox?=
 =?utf-8?B?T25kTEw0K1RYY0lhcDIvN1lvbmxaL3VzVnlqUS8wN2dUWHVuT3ZUVHMzYndS?=
 =?utf-8?B?NDM3QnQ2amNXZWYyNW5uS3lOcUxTWnRSVlpIWjkydVlreSt2UkdGb0Z6NURw?=
 =?utf-8?B?VjNSNHNDbWVWNFBoL2thVzR4b0h1Nlc1ZzhiZUR2TExUODRuQUhmZGhmTFZi?=
 =?utf-8?B?SFhXQWIyZlVRbjBWVEdJTkdRTEZRZkpNS05BK2VmREZrUjE1eDF6WnoyY21Y?=
 =?utf-8?B?SGpreCtERUJTdDhCWm1RakZzbkpuK1JCR29TVk1tR1BhR3Jlc0IrS0ZhdnhI?=
 =?utf-8?B?VWJ3NWtqdEJFS3RrT21FbFFsTmJoZU44bXBEMENxSVlsYm9Eek1aMzkyaTUx?=
 =?utf-8?B?TUVuMncyUkVyMUw1MXpjMk92OEdKSkY5OTMrWTYzUnFsWWpiK3VuL3lYSlBJ?=
 =?utf-8?B?Z0VjZzh2Z0xQZHRUUmtrMHBDOFFuNHlWZWMwN3NTUk40NWtZY0h2QmZtWVpo?=
 =?utf-8?B?Q1JBUDJBWHYzOG9QUW5LbW9NRGdhVng3WE5pcjcyYmM2ajV4OHhMb0p6SVUv?=
 =?utf-8?B?ajRScWNwQkhiZ3V3VC9XVDdvaVRuaS9CSUwyUHdMTnkvRTZrM3U3UmxpWmJD?=
 =?utf-8?B?N2RuVHNOQUZtZzRteHFBVmdiS1lybUJDK2RjdkNramJUSURpbGw5cENzbCtF?=
 =?utf-8?B?eTlMS0tXdXNkK3YxSEJtMlFqaGQwY0UyU3psOHlXS2pNZnhwTm05NE5rUGpa?=
 =?utf-8?B?dWNWQmRyS3RiNGhQK2o1NmNOWGRUUUtqQllDZUxNVGlnZDRNR3c0TS9aNSs2?=
 =?utf-8?B?VjBGZk51bkJyU1hMSzNnODdmME5kWUlMVCtQdEJHNXp5VjJYM1Q0M2QwM085?=
 =?utf-8?B?bTVyTmhodFpIbjhzZTFvSUp1NW1VNU0yV25lN0lQOEVHTmdLa200R2NXa2Zz?=
 =?utf-8?B?aW1ER0FHQjhaem4ySU9wMUNQTHNTVE9HTS9hZXZWckFBTys3aEhVMUVtbzBK?=
 =?utf-8?B?aXdydkNSeW5xVDV1T09TdGNoVWZnbitXci9wQ2ZJNkM2UHpZOEVBa2FSczBu?=
 =?utf-8?B?OGcweFhKcU9QTUNMelRZWWxBK0xxWFQzNUlzeENzZC83MXd3ZURBenhhVVZa?=
 =?utf-8?B?dGJsNGJNcHd3NWJOSWwzY2QvWlhBYlUzZUR6bDh6NCswL2pMZENHeE53ZkZ3?=
 =?utf-8?B?YVlQbzdzWmVhSno4QUp5SGliK2NRVzlpb2lnajA3N3JRUXd3d3dWZllWenBQ?=
 =?utf-8?B?cjRlblg4dFdHcFZIZFppR2ZhWWUzeGRVbXE4RnRRTjJEVXphcldCc3YzdUdy?=
 =?utf-8?B?dXdNZ29GNVNHME16RE1uMTM1YnhoTWdOZUNkNmhtZm1uYThqUlRidVdOMDNo?=
 =?utf-8?B?OGdFUmVsNjVuNDROWmF4RTdJTGE5ZmhWaTFZK2F6Z3d0RjhDM1hwT3JnV09x?=
 =?utf-8?B?bTZ2OVVtOFpHTG1ZTEJucHBWWEU1T0tteks2SHpabWpxbFQwc3N6dVBhWmRy?=
 =?utf-8?B?dll1ZmdzWHBtTG1WajZpMityVVVQMUdVTWxsNmg3TzlmTTdMT093Y092bWF6?=
 =?utf-8?B?b1V4dUVSaGx1RFhkcC9DSC90NlZlSWZ1OExpcmpOOUpuTjcyaXcvR3hDcXNW?=
 =?utf-8?B?RzA5MGlqYkFsaUJsK2ozdVAzZUJBS2dzQkFZTitVQXZYT0hETU5qbldPSHhY?=
 =?utf-8?B?QXFqK0RsR29rOEhQcDF3RGg2MW1zL3M5bzZtOUdZdVNvdU9pYzFBTUJDYmNZ?=
 =?utf-8?B?b3o0NWRxZzFaODh2bkVMOUhJL3VIbXNMQTFIdHFvMWQwajRmTnY4QU01L3BV?=
 =?utf-8?B?WGpNRmlmNmN3ZTEwQThNMmR5REx6ZUZXUDR6NzZPM3ZJZGpPT3BvOTc4ZXh4?=
 =?utf-8?B?Y2NmelIzdEpQRnE5K1JXMTNHNnFlQnBnQVJkc1loeG9ySFA1WW5sUFJneUJq?=
 =?utf-8?B?MmFTMjhhdmZQL1hOY010elhCcEV5T1E4b0V2TmV1Q09ValdLWFN5QUZaNi8z?=
 =?utf-8?Q?UqfRARqW/PgMlCypq7cAurm9w?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 728e6833-d2bd-46e8-32b2-08dd7b67e0db
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4202.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2025 15:20:24.2657
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yzMVpRuqfK8oSPaXuOJ4n0/Zikc8egj9G20NGOvMQu7tQ9DXhHe6E2JwIGMPfzK0GtVLZwhcANN6RdcHSQ9+jA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4326

I forgot to mention in the v13 changes the dropping of one patch related 
to SFC firmware definitions which has already been updated upstream as 
it was required for other support.


On 4/14/25 16:13, alejandro.lucero-palau@amd.com wrote:
> From: Alejandro Lucero <alucerop@amd.com>
>
> v13 changes:
>   - using names for headers checking more consistent (Jonathan Cameron)
>   - using helper for caps bit setting (Jonathan Cameron)
>   - provide generic function for reporting missing capabilities (Jonathan Cameron)
>   - rename cxl_pci_setup_memdev_regs to cxl_pci_accel_setup_memdev_regs (Jonathan Cameron)
>   - cxl_dpa_info size to be set by the Type2 driver (Jonathan Cameron)
>   - avoiding rc variable when possible (Jonathan Cameron)
>   - fix spelling (Simon Horman)
>   - use scoped_guard (Dave Jiang)
>   - use enum instead of bool (Dave Jiang)
>   
> v12 changes:
>   - use new macro cxl_dev_state_create in pci driver (Ben Cheatham)
>   - add public/private sections in now exported cxl_dev_state struct (Ben
>     Cheatham)
>   - fix cxl/pci.h regarding file name for checking if defined
>   - Clarify capabilities found vs expected in error message. (Ben
>     Cheatham)
>   - Clarify new CXL_DECODER_F flag (Ben Cheatham)
>   - Fix changes about cxl memdev creation support moving code to the
>     proper patch. (Ben Cheatham)
>   - Avoid debug and function duplications (Ben Cheatham)
>   - Fix robot compilation error reported by Simon Horman as well.
>   - Add doc about new param in clx_create_region (Simon Horman).
>
> v11 changes:
>   - Dropping the use of cxl_memdev_state and going back to using
>     cxl_dev_state.
>   - Using a helper for an accel driver to allocate its own cxl-related
>     struct embedding cxl_dev_state.
>   - Exporting the required structs in include/cxl/cxl.h for an accel
>     driver being able to know the cxl_dev_state size required in the
>     previously mentioned helper for allocation.
>   - Avoid using any struct for dpa initialization by the accel driver
>     adding a specific function for creating dpa partitions by accel
>     drivers without a mailbox.
>
> v10 changes:
>   - Using cxl_memdev_state instead of cxl_dev_state for type2 which has a
>     memory after all and facilitates the setup.
>   - Adapt core for using cxl_memdev_state allowing accel drivers to work
>     with them without further awareness of internal cxl structs.
>   - Using last DPA changes for creating DPA partitions with accel driver
>     hardcoding mds values when no mailbox.
>   - capabilities not a new field but built up when current register maps
>     is performed and returned to the caller for checking.
>   - HPA free space supporting interleaving.
>   - DPA free space droping max-min for a simple alloc size.
>
> v9 changes:
>   - adding forward definitions (Jonathan Cameron)
>   - using set_bit instead of bitmap_set (Jonathan Cameron)
>   - fix rebase problem (Jonathan Cameron)
>   - Improve error path (Jonathan Cameron)
>   - fix build problems with cxl region dependency (robot)
>   - fix error path (Simon Horman)
>
> v8 changes:
>   - Change error path labeling inside sfc cxl code (Edward Cree)
>   - Properly handling checks and error in sfc cxl code (Simon Horman)
>   - Fix bug when checking resource_size (Simon Horman)
>   - Avoid bisect problems reordering patches (Edward Cree)
>   - Fix buffer allocation size in sfc (Simon Horman)
>
> v7 changes:
>
>   - fixing kernel test robot complains
>   - fix type with Type3 mandatory capabilities (Zhi Wang)
>   - optimize code in cxl_request_resource (Kalesh Anakkur Purayil)
>   - add sanity check when dealing with resources arithmetics (Fan Ni)
>   - fix typos and blank lines (Fan Ni)
>   - keep previous log errors/warnings in sfc driver (Martin Habets)
>   - add WARN_ON_ONCE if region given is NULL
>
> v6 changes:
>
>   - update sfc mcdi_pcol.h with full hardware changes most not related to
>     this patchset. This is an automatic file created from hardware design
>     changes and not touched by software. It is updated from time to time
>     and it required update for the sfc driver CXL support.
>   - remove CXL capabilities definitions not used by the patchset or
>     previous kernel code. (Dave Jiang, Jonathan Cameron)
>   - Use bitmap_subset instead of reinventing the wheel ... (Ben Cheatham)
>   - Use cxl_accel_memdev for new device_type created (Ben Cheatham)
>   - Fix construct_region use of rwsem (Zhi Wang)
>   - Obtain region range instead of region params (Allison Schofield, Dave
>     Jiang)
>
> v5 changes:
>
>   - Fix SFC configuration based on kernel CXL configuration
>   - Add subset check for capabilities.
>   - fix region creation when HDM decoders programmed by firmware/BIOS (Ben
>     Cheatham)
>   - Add option for creating dax region based on driver decission (Ben
>     Cheatham)
>   - Using sfc probe_data struct for keeping sfc cxl data
>
> v4 changes:
>    
>   - Use bitmap for capabilities new field (Jonathan Cameron)
>
>   - Use cxl_mem attributes for sysfs based on device type (Dave Jian)
>
>   - Add conditional cxl sfc compilation relying on kernel CXL config (kernel test robot)
>
>   - Add sfc changes in different patches for facilitating backport (Jonathan Cameron)
>
>   - Remove patch for dealing with cxl modules dependencies and using sfc kconfig plus
>     MODULE_SOFTDEP instead.
>
> v3 changes:
>
>   - cxl_dev_state not defined as opaque but only manipulated by accel drivers
>     through accessors.
>
>   - accessors names not identified as only for accel drivers.
>
>   - move pci code from pci driver (drivers/cxl/pci.c) to generic pci code
>     (drivers/cxl/core/pci.c).
>
>   - capabilities field from u8 to u32 and initialised by CXL regs discovering
>     code.
>
>   - add capabilities check and removing current check by CXL regs discovering
>     code.
>
>   - Not fail if CXL Device Registers not found. Not mandatory for Type2.
>
>   - add timeout in acquire_endpoint for solving a race with the endpoint port
>     creation.
>
>   - handle EPROBE_DEFER by sfc driver.
>
>   - Limiting interleave ways to 1 for accel driver HPA/DPA requests.
>
>   - factoring out interleave ways and granularity helpers from type2 region
>     creation patch.
>
>   - restricting region_creation for type2 to one endpoint decoder.
>
>   - add accessor for release_resource.
>
>   - handle errors and errors messages properly.
>
>
> v2 changes:
>
> I have removed the introduction about the concerns with BIOS/UEFI after the
> discussion leading to confirm the need of the functionality implemented, at
> least is some scenarios.
>
> There are two main changes from the RFC:
>
> 1) Following concerns about drivers using CXL core without restrictions, the CXL
> struct to work with is opaque to those drivers, therefore functions are
> implemented for modifying or reading those structs indirectly.
>
> 2) The driver for using the added functionality is not a test driver but a real
> one: the SFC ethernet network driver. It uses the CXL region mapped for PIO
> buffers instead of regions inside PCIe BARs.
>
>
>
> RFC:
>
> Current CXL kernel code is focused on supporting Type3 CXL devices, aka memory
> expanders. Type2 CXL devices, aka device accelerators, share some functionalities
> but require some special handling.
>
> First of all, Type2 are by definition specific to drivers doing something and not just
> a memory expander, so it is expected to work with the CXL specifics. This implies the CXL
> setup needs to be done by such a driver instead of by a generic CXL PCI driver
> as for memory expanders. Most of such setup needs to use current CXL core code
> and therefore needs to be accessible to those vendor drivers. This is accomplished
> exporting opaque CXL structs and adding and exporting functions for working with
> those structs indirectly.
>
> Some of the patches are based on a patchset sent by Dan Williams [1] which was just
> partially integrated, most related to making things ready for Type2 but none
> related to specific Type2 support. Those patches based on Dan´s work have Dan´s
> signing as co-developer, and a link to the original patch.
>
> A final note about CXL.cache is needed. This patchset does not cover it at all,
> although the emulated Type2 device advertises it. From the kernel point of view
> supporting CXL.cache will imply to be sure the CXL path supports what the Type2
> device needs. A device accelerator will likely be connected to a Root Switch,
> but other configurations can not be discarded. Therefore the kernel will need to
> check not just HPA, DPA, interleave and granularity, but also the available
> CXL.cache support and resources in each switch in the CXL path to the Type2
> device. I expect to contribute to this support in the following months, and
> it would be good to discuss about it when possible.
>
> [1] https://lore.kernel.org/linux-cxl/98b1f61a-e6c2-71d4-c368-50d958501b0c@intel.com/T/
>
> Alejandro Lucero (22):
>    cxl: add type2 device basic support
>    sfc: add cxl support
>    cxl: move pci generic code
>    cxl: move register/capability check to driver
>    cxl: add function for type2 cxl regs setup
>    sfc: make regs setup with checking and set media ready
>    cxl: support dpa initialization without a mailbox
>    sfc: initialize dpa
>    cxl: prepare memdev creation for type2
>    sfc: create type2 cxl memdev
>    cxl: define a driver interface for HPA free space enumeration
>    sfc: obtain root decoder with enough HPA free space
>    cxl: define a driver interface for DPA allocation
>    sfc: get endpoint decoder
>    cxl: make region type based on endpoint type
>    cxl/region: factor out interleave ways setup
>    cxl/region: factor out interleave granularity setup
>    cxl: allow region creation by type2 drivers
>    cxl: add region flag for precluding a device memory to be used for dax
>    sfc: create cxl region
>    cxl: add function for obtaining region range
>    sfc: support pio mapping based on cxl
>
>   drivers/cxl/core/core.h               |   2 +
>   drivers/cxl/core/hdm.c                |  77 +++++
>   drivers/cxl/core/mbox.c               |  30 +-
>   drivers/cxl/core/memdev.c             |  47 ++-
>   drivers/cxl/core/pci.c                | 146 +++++++++
>   drivers/cxl/core/port.c               |   8 +-
>   drivers/cxl/core/region.c             | 415 +++++++++++++++++++++++---
>   drivers/cxl/core/regs.c               |  37 +--
>   drivers/cxl/cxl.h                     | 111 +------
>   drivers/cxl/cxlmem.h                  | 103 +------
>   drivers/cxl/cxlpci.h                  |  23 +-
>   drivers/cxl/mem.c                     |  25 +-
>   drivers/cxl/pci.c                     | 114 +++----
>   drivers/cxl/port.c                    |   5 +-
>   drivers/net/ethernet/sfc/Kconfig      |  10 +
>   drivers/net/ethernet/sfc/Makefile     |   1 +
>   drivers/net/ethernet/sfc/ef10.c       |  50 +++-
>   drivers/net/ethernet/sfc/efx.c        |  15 +-
>   drivers/net/ethernet/sfc/efx_cxl.c    | 160 ++++++++++
>   drivers/net/ethernet/sfc/efx_cxl.h    |  40 +++
>   drivers/net/ethernet/sfc/net_driver.h |  12 +
>   drivers/net/ethernet/sfc/nic.h        |   3 +
>   include/cxl/cxl.h                     | 276 +++++++++++++++++
>   include/cxl/pci.h                     |  36 +++
>   tools/testing/cxl/Kbuild              |   1 -
>   tools/testing/cxl/test/mem.c          |   2 +-
>   tools/testing/cxl/test/mock.c         |  17 --
>   27 files changed, 1350 insertions(+), 416 deletions(-)
>   create mode 100644 drivers/net/ethernet/sfc/efx_cxl.c
>   create mode 100644 drivers/net/ethernet/sfc/efx_cxl.h
>   create mode 100644 include/cxl/cxl.h
>   create mode 100644 include/cxl/pci.h
>
>
> base-commit: 73c117c17b562213242f432db2ddf1bcc22f39dd

