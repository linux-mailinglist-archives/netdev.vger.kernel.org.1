Return-Path: <netdev+bounces-205682-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3351AAFFB7A
	for <lists+netdev@lfdr.de>; Thu, 10 Jul 2025 09:58:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 119764859DB
	for <lists+netdev@lfdr.de>; Thu, 10 Jul 2025 07:58:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EEB628B4E2;
	Thu, 10 Jul 2025 07:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="UnQJkDTu"
X-Original-To: netdev@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2068.outbound.protection.outlook.com [40.107.102.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 820FF17BA5;
	Thu, 10 Jul 2025 07:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752134311; cv=fail; b=gREgUSlrTzX+lD/kYUA4UBAK8Vh7EvYvIh6sm4KGc46/mrG/0W16ZA2D2/2Kv3cANDUUFZo0GWlq+WXeMXGO3uL4cXNRaUAImmbYlONoi1Yxt5funDieiNilPdaFkpy4sTW3uv6fnchBPtD5aiMYyaY6XoCGHYFMrWpcTUE5yHo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752134311; c=relaxed/simple;
	bh=c+cYZLcAP38y+TkhQwH9gW4ctWyBgM1E0viIKhSm0sk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Fcp8qC4jVMv8HV1oJplFPtG6mrMzVpISu7+aXU+dWqFP4y/REPka0C+tRDuvJTyH71SFIYaQU4No2V14fW13k//4SUL6fsKPylhAfFknEgCPgraw9mS9LgSMireyQ4yodUM2mXjX1YflPRFbcyHHafdAMd1PSVZrgOtox70E6Vs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=UnQJkDTu; arc=fail smtp.client-ip=40.107.102.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=w5xwTxtx3vrJBnMhSsg8XW5u57xQOQbCYsy/C7v1LfeUI3Rssb1O6NHasZpRX5Mtsci46AUCDRlWaE4HV/4o6ZrTbp8NqqpSYO2TvBgwOJWDr+Er/AIQI/ShOXtYvDfI40lAJ5bJRZ0Ujggw4dIaq2acg++pNsbWTcy/2owjFOYeWo8mHUr+9HicRVv/PiJ+NGsPlcElf12WMMGvtLlz1B9ClQe0P6l8x1J8GzidovBHKfIfVXdAJCWyME4i3/n7rSjZo+6nVqum7IPDPULdNGYEmm7G6tT9vYjBGpcvvF/P67QkQnogc+bYHtUlobLE8KaM1YaGlx6ePhTU2/ICDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TeAdhwihKv19jZNTrcMrXfuPaFiykHoM2rqO6W80O5Y=;
 b=PsbYNxpLZJldI+/1+jXA+Ygi23d52vP3fG4dRH8Ts4VXE4LiWrMG3FXHsg6Pwk8PJu317FlZ/iWSE+DJ+IQ+ZowvZV+VIxfrha565fo//cE6YN9U4YMewBXocZAIAgIbZeUew6r994OrIBUjWwcUNYUb066rqX3vEIfZmqClN+8zYjvupH6FvlzSc3RIcFvf7A+2kQNV3V0g5fFxt5lsGWOL32Fw05TRAqeZhFSIWfYrnYONIkUCq0JRBHb0ZLZGbASnwJk2X5ClOO/G1aNDNQ1UdFWx/+Jgwmy7oPYTZun4hnIkMCRgIT58m8OMFqVLr3zCeetxbzIS/WfRtDKxpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TeAdhwihKv19jZNTrcMrXfuPaFiykHoM2rqO6W80O5Y=;
 b=UnQJkDTu9yMMKdQYWcEELDPDL21s3t+Usub8QIcHi54dK4cSMYg/7r0dTZLvWSytIIN6CL+KL98SGiOXBYjMj28JKiKbp3YlBAkIN+k5JGNyfpbI5ccFlQf1SkHSD+sZUjxjcXe6lG8dXa/DmBRHVLi4aqXqVeJmHs3Zxuk2dsJX3gBPUwu3KnV1OpulhxXaliFIBmjtIoHE2kNl4sfYEVobbum8b/y+kEMGr1jvj85D9eJgVW51MEyyXtReYCjEK7xK3gfsmB2MifbC1znmZCJO7a2fmATMXHutFMyJfSosvoDxsjNR3RaDqv7tX+/46ljxjqWu14RrccjL5vRrOQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MW4PR12MB7141.namprd12.prod.outlook.com (2603:10b6:303:213::20)
 by MW6PR12MB8661.namprd12.prod.outlook.com (2603:10b6:303:23f::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.28; Thu, 10 Jul
 2025 07:58:26 +0000
Received: from MW4PR12MB7141.namprd12.prod.outlook.com
 ([fe80::932c:7607:9eaa:b1f2]) by MW4PR12MB7141.namprd12.prod.outlook.com
 ([fe80::932c:7607:9eaa:b1f2%5]) with mapi id 15.20.8901.028; Thu, 10 Jul 2025
 07:58:25 +0000
Message-ID: <40196680-c34f-4b41-a6cb-36e3a6089634@nvidia.com>
Date: Thu, 10 Jul 2025 10:58:17 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] [v2] devlink: move DEVLINK_ATTR_MAX-sized array off stack
To: Jakub Kicinski <kuba@kernel.org>, Arnd Bergmann <arnd@kernel.org>
Cc: Jiri Pirko <jiri@resnulli.us>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 Mark Bloch <mbloch@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>,
 Arnd Bergmann <arnd@arndb.de>, Simon Horman <horms@kernel.org>,
 Cosmin Ratiu <cratiu@nvidia.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250709145908.259213-1-arnd@kernel.org>
 <20250709174547.3604c42b@kernel.org>
Content-Language: en-US
From: Carolina Jubran <cjubran@nvidia.com>
In-Reply-To: <20250709174547.3604c42b@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TL2P290CA0012.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:2::16) To MW4PR12MB7141.namprd12.prod.outlook.com
 (2603:10b6:303:213::20)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB7141:EE_|MW6PR12MB8661:EE_
X-MS-Office365-Filtering-Correlation-Id: 0d9124d8-9fb0-4336-d738-08ddbf878c78
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?a3BmcXE2VUdRdGRwcGl0S1pzUDR5N1k0VlZrblg0ZExZdnZjUUZ6aTZIU2pj?=
 =?utf-8?B?M01qeGhHS0x1Y2wyU2tCTjhuYXpnKzU0Y3JEQ3drRWlQWk1xNkd6d0VrT3Ir?=
 =?utf-8?B?bVJDazhjdVBsNHJzU2pTaStRMk9LV1dxRnZvRVBuOSt4ZHBFRHROcmlhOURI?=
 =?utf-8?B?MkFldWlIajAyb3BsaTFoVkRoaTdMSDB1bmt4eWpIV2dWQkNkUnA2Mm16Wlgr?=
 =?utf-8?B?anBtUmJkOGFsK3R6dGxLVC9uQ1I5eHJMUXlVTW9xdTlXSHVUY3FjRlNidk9n?=
 =?utf-8?B?WmZYUXJkM2d4dTJWL1VrMXEybE44TkVRRDh5dm1FKzdwVkorK3FzcjkvRml1?=
 =?utf-8?B?dVBReTJsQ0ZaQWV2dmZlNGRCL2NzNDV2Q2REK1BWNEt5eUh6K2l5a3d0M1J1?=
 =?utf-8?B?dFdVR3VyNW1kS1pSZURpK1RqU2d0VCtRZkU0OEtUWXBhNTJjWjBRUmpMWHgz?=
 =?utf-8?B?OEo0VWhkRVcvQU9xNTM4ZWh1cksweThVTHhGZDVSWmNWUGY1czE1aVlzL3FY?=
 =?utf-8?B?akpEN2t0MGltOGV4b0ZTMUNrR2UrMWF2NzJYOGFoUE50RE9sV1BhL1U0M2V0?=
 =?utf-8?B?ZnJvLyt4UkFGbTJPTlp2L01MTmZicWFJTGNLVWV3S21sajFqbzVQYUNyV1V6?=
 =?utf-8?B?dnE5cW4wZ2t1ekZMNURlRVdJSEFBeXVIWTJpT1Z4Tk96VFR0UnI4eEQ0U3ht?=
 =?utf-8?B?SG4vWGY2eHBRM3Z5aDZxL3JCRVFtWW9TRENNMkp6T3VDQlBNRG5LaFNCd2Iv?=
 =?utf-8?B?UTY0MTBkOHZJWTFOR29YZ1ZjaHp5SDNkVVdOYVM5R3dQdmdJMHc5Y1FpVVlt?=
 =?utf-8?B?Q0MrdXFBNkdNMkFOT2lsT1Nsbkx5d1R6ZXBrVGpJSUw3QVdnNGZiM3hHV2cx?=
 =?utf-8?B?NDJXZWZVVHhRYTRRU0dLOTZleWNKc095cFdPRkdYWlhVaTlWK21FSjhKNlpj?=
 =?utf-8?B?b05kNVNPdG4wNVF4RE4rR3FUSC9uYytIMnJrZ3Z5S1daSkplOE1vaHV1Rzhl?=
 =?utf-8?B?dmpSbWtDdWYydGp1UUF4cHFOT25YS2tMVGlGZDhyYXdpLzVCa09nMzZtS2pQ?=
 =?utf-8?B?ak1kbTRYdkdtNHF2b2lHaUVNc1k4aVJVT3BQKzNZKyt5dTdQdUp5dlhxZ3ht?=
 =?utf-8?B?UTE0eXpaYVh6aTZQMTRQejY4dGpGVVhQSS9UcitnbjE1c3M1bGRPdTQrUXpn?=
 =?utf-8?B?YzlLSUZMaEZlckJ6Sm5LSVJhNlYrNkYwUzZhWWFFMEpxOGpnRnZUc0M5b01D?=
 =?utf-8?B?SHRtSWE4NmxuWG9lZlR3bXduK0xsVXF6Mk0yUzcrbEp6MmpLVTBZT2xacEQ4?=
 =?utf-8?B?Q0lNUFdNaXUvNkRMSFlEZzBwTnpHSUlVL2I3ZlB2WWpISTN2RnhiZm5ZbXFz?=
 =?utf-8?B?VVh1bFY3Y2U4dEJYVk5wR3pHbm9Wa2dTZytTU25pYS9SeDVvMVh6THlnNGdj?=
 =?utf-8?B?cGxRSlFJdisvN21JWWlQNStIMVNHaS80elJVdkR0OEZpdTBaR0RheXI2aXJI?=
 =?utf-8?B?ZDBRdG5tSzdvUjVJOXBhaERXY3BJYTRScm9kUmM3by9SOUk1eGNhMkVCS3d4?=
 =?utf-8?B?M1p0Z201Y0d5RElQYUlMYWgzYkplRm1hQktGR0R1UnlyN2FJU1Y1aGdJcFNz?=
 =?utf-8?B?dUwvenp2bjFQR2QxVWJubjl4bkM0QS9mOU9oUUlrWko2WlZMK29JbE15NDI5?=
 =?utf-8?B?YnF4eDhWWUFMTFNZcTUzcmVPUG9USURUMHpnQk0zU1I4Skc2cVhtL2pIeGkr?=
 =?utf-8?B?Ylo3Mk56SzVPRE1aU3ByMHpaK29JSEpCbUxoRGU0RlJnNG5OV2dmbG5wYmw2?=
 =?utf-8?B?YWJzaGVRWkxXSWZGZlNGNGJxanpTUnpLckpmVU43YTRZRGozZE5hWEt4dHQz?=
 =?utf-8?B?Nnh2amtEUkFuOUZjeVNrNHRiVE9xS0s5aEE1RnBwMGNnbnlTZVowZjVhOTRM?=
 =?utf-8?Q?yeGrYUrhraM=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR12MB7141.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?REZ4R1ZnS2NwSENWL1R1ZFo1OHhRLzFsTEw1Ni9qNTJoVWg2TERrUTRoOHg2?=
 =?utf-8?B?WEp0WU9LL2MzZnVOUWtGWjZLVm5jbndMUGQ4UFhvZ0NGdGFEeFp4M0RJbEk0?=
 =?utf-8?B?dHlNU2lBU1hHT3QydC84aTk1TGV1Y0NwOThnU2srbGlCQ3pPZmZBd1pmSGcr?=
 =?utf-8?B?UEhWcnJtVmZuei94UmJ2STNHRVRrN1FlU0orVW1RWVZjMEdsS2R4U1RSRVBh?=
 =?utf-8?B?bm9uU0lMZHU3T3IwRTYyOFNQOXpDMEVPVk93dUtqWGZOQmJRQ0E0aXM4L3Ft?=
 =?utf-8?B?QXRBNm1RVjhxUnNlSlFOQm9pcVY5RWdTQkw1RTJwZW00VzlOc3R6Y0J0S05F?=
 =?utf-8?B?SW1lZjBqSS9YNHZ3VGpMc0VrTm1UVFoyVzJJODBoNVQ4UDE4Y0VPTUNTMTJt?=
 =?utf-8?B?NnJoNk9EQlUzblVGdndZODRRUDJFcUM3TFpnRXJNVVZCMUxHZ2FWMUlyT3Q3?=
 =?utf-8?B?ZzhXSVJ4YzJsMkxsKzZEZUNSYWhVNnZBOE9KRXB4WHhuV3c4eVpOcjNaSzA4?=
 =?utf-8?B?dG9tQUgvN1A3K3M4NG1PVE03WGQ4ZHZnaVo5bmUzQWFuSU5iTUZqcWJRY0sz?=
 =?utf-8?B?UXBVeHdHSHBDbURQODM0WmR3bGtpR2ZaN21UcWFwU1JiVFNOL3lId0dtdFEw?=
 =?utf-8?B?cXk4ZGN0Ti9IQUM1US9ZTHRTOEgwcXJ0RUg4NmIya09vZzd1WThuN201QW92?=
 =?utf-8?B?RU1iVCtDZEh0QnpWN3JqSWF5Z3QyQUFKTTNMS2hkZFA1OHZjQW9HRTdNZmlC?=
 =?utf-8?B?TkZONHlMeFVhbWZsd2dFMnZsR284dGlXMTc2YUVURVJvb0ZEcmtWSmJ0WWdS?=
 =?utf-8?B?akxiVVZ4MVB1MDNuSENZRis1VThReEFTWERRQUEzODliOHFUa05CaFVyMEVL?=
 =?utf-8?B?WmZzWXkvVnZFK2ZkVDVYK3hXZHREU21EbzRmL1RrempRTVFjWVlWc2RQd215?=
 =?utf-8?B?RDI5N2tvRGlkdWZmREx2a0o1clc4cXVlQW9OSWRBV3pMVGYzbDl2bGVFRFZ6?=
 =?utf-8?B?M0JIRWFBbmgyREU4TURxSDFaOFBtM2VrQjY2NEd1UTRvYmdqRHU1MFEvVlRD?=
 =?utf-8?B?aHdWWUNrT2lodzhoc2ZwUVRjeE56N2ZORnk4TE4vU0Q5SDkxbWQ5QmU0b1pv?=
 =?utf-8?B?WlRlNmhBMHVQaWZZWmRXQ0w0ZmRJMXhWTFN0OWk3YW9FcEM0ZEZqTnVJaTVJ?=
 =?utf-8?B?SkNpVWJmcGdURXpqL3V5SHFVV0tGWGJTNzMxNTJobWpXOWpTWXNvV0Q1bXNk?=
 =?utf-8?B?T2VYNUVzeHdYNXVLdkpTOEZmREtnOS9FOElZREQ5cis2VE1URUV1VURFMWl5?=
 =?utf-8?B?MjJveS8zOXVGT1hKRzdyVUt0a3NxWUZXVEpINUNKbk9Pa05VRkordUlmclpz?=
 =?utf-8?B?N1N3bGtab0F2NDNkbnl5R1BEUmlSK3dGSlpxSUFlRFpTaUw4Sjd3MU12OG5z?=
 =?utf-8?B?YUpUd3AvcDhTUlFpTjVEelZlYy9UOHVQVm5FN0RENnRqeWV4RVJwTXhFc2ps?=
 =?utf-8?B?aU54b0w1VnFvam1OVDhrZWZlR013eFBlamhsdnZ2QlBEVEx4ei80MnRwOEJx?=
 =?utf-8?B?VHg0NjF2WnhrY2pHMElHdXQ5VFY2Zm1IVFd3MTJOZUxtV0hudStqZE9pNW0y?=
 =?utf-8?B?aTJFMjZ2aml0Nm1Ld3Y2Y3NDOENBUVVNNG1naGtzbllTMi9PRFYxbVRNNFJv?=
 =?utf-8?B?OHh1S0cwUCtHOTdxSjloQmN2S21YeGMwZk42ZkZjRVhoT3d1cDRtcXl0YXpN?=
 =?utf-8?B?YTZlenE2OHJMRk4zc08veGRHOXZ6N2tCUEtQeXV3WjI0Z1pDZXpDSm9YcW8r?=
 =?utf-8?B?VHVDWnVIVzNGUXNhQ0hRQWdWUGlzWjlqZ3hqYUFXc1FhMVNUWTQ5Q2R6bVJz?=
 =?utf-8?B?TThQdngvSTlvTkRDaWVVbmF4TDJNVFZKbXl2Z1ovcGVBaXh2Q1hMN0RRSndv?=
 =?utf-8?B?a25NbWNyU1ZIb3V1RUc1Unp1SCsvQnFxS08rdktBdnN6dTVBSXNVVU5INmJK?=
 =?utf-8?B?U2o5MXFnaWw0VHdrem55bkFDKzhpOFFQUytuK0tnYlpKd3QyZ2QwMktScGJl?=
 =?utf-8?B?TTg3VW5rZXZwa01iRjViTE92QTJVZktES09SWlRpNEdPSUR0WmZyZ3l5eEE5?=
 =?utf-8?Q?LW3scKLGnl5Cm8OYGaT55aJ/S?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d9124d8-9fb0-4336-d738-08ddbf878c78
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB7141.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2025 07:58:25.8520
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YcBPwfGwJEJtYXy3EN4ZCleviIP+iFvWa8Z0sxGiOgGMMYUfe/DuB74TqyP3TWt9bWE6yo/xMaLnWbDoTEH6iw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8661



On 10/07/2025 3:45, Jakub Kicinski wrote:
> On Wed,  9 Jul 2025 16:59:00 +0200 Arnd Bergmann wrote:
>> -	struct nlattr *tb[DEVLINK_ATTR_MAX + 1];
>> +	struct nlattr **tb __free(kfree) = NULL;
> 
> Ugh, now you triggered me.
> 
>>   	u8 tc_index;
>>   	int err;
>>   
>> +	tb = kcalloc(DEVLINK_ATTR_MAX + 1, sizeof(struct nlattr *), GFP_KERNEL);
>> +	if (!tb)
>> +		return -ENOMEM;
> 
> Cramming all the attributes in a single space is silly, it's better for
> devlink to grow up :/ Carolina could you test this?
> 

Sure, testing it. Will update.
Thanks!

> diff --git a/Documentation/netlink/specs/devlink.yaml b/Documentation/netlink/specs/devlink.yaml
> index 1c4bb0cbe5f0..3d75bc530b30 100644
> --- a/Documentation/netlink/specs/devlink.yaml
> +++ b/Documentation/netlink/specs/devlink.yaml
> @@ -853,18 +853,6 @@ doc: Partial family for Devlink.
>           type: nest
>           multi-attr: true
>           nested-attributes: dl-rate-tc-bws
> -      -
> -        name: rate-tc-index
> -        type: u8
> -        checks:
> -          max: rate-tc-index-max
> -      -
> -        name: rate-tc-bw
> -        type: u32
> -        doc: |
> -             Specifies the bandwidth share assigned to the Traffic Class.
> -             The bandwidth for the traffic class is determined
> -             in proportion to the sum of the shares of all configured classes.
>     -
>       name: dl-dev-stats
>       subset-of: devlink
> @@ -1271,12 +1259,20 @@ doc: Partial family for Devlink.
>           type: flag
>     -
>       name: dl-rate-tc-bws
> -    subset-of: devlink
> +    name-prefix: devlink-attr-
>       attributes:
>         -
>           name: rate-tc-index
> +        type: u8
> +        checks:
> +          max: rate-tc-index-max
>         -
>           name: rate-tc-bw
> +        type: u32
> +        doc: |
> +             Specifies the bandwidth share assigned to the Traffic Class.
> +             The bandwidth for the traffic class is determined
> +             in proportion to the sum of the shares of all configured classes.
>   
>   operations:
>     enum-model: directional
> diff --git a/include/uapi/linux/devlink.h b/include/uapi/linux/devlink.h
> index e72bcc239afd..169a07499556 100644
> --- a/include/uapi/linux/devlink.h
> +++ b/include/uapi/linux/devlink.h
> @@ -635,8 +635,6 @@ enum devlink_attr {
>   	DEVLINK_ATTR_REGION_DIRECT,		/* flag */
>   
>   	DEVLINK_ATTR_RATE_TC_BWS,		/* nested */
> -	DEVLINK_ATTR_RATE_TC_INDEX,		/* u8 */
> -	DEVLINK_ATTR_RATE_TC_BW,		/* u32 */
>   
>   	/* Add new attributes above here, update the spec in
>   	 * Documentation/netlink/specs/devlink.yaml and re-generate
> @@ -647,6 +645,14 @@ enum devlink_attr {
>   	DEVLINK_ATTR_MAX = __DEVLINK_ATTR_MAX - 1
>   };
>   
> +enum {
> +	DEVLINK_ATTR_RATE_TC_INDEX = 1,		/* u8 */
> +	DEVLINK_ATTR_RATE_TC_BW,		/* u32 */
> +
> +	__DEVLINK_ATTR_RATE_TC_MAX,
> +	DEVLINK_ATTR_RATE_TC_MAX = __DEVLINK_ATTR_RATE_TC_MAX - 1
> +};
> +
>   /* Mapping between internal resource described by the field and system
>    * structure
>    */
> diff --git a/net/devlink/rate.c b/net/devlink/rate.c
> index d39300a9b3d4..83ca62ce6c63 100644
> --- a/net/devlink/rate.c
> +++ b/net/devlink/rate.c
> @@ -346,11 +346,11 @@ static int devlink_nl_rate_tc_bw_parse(struct nlattr *parent_nest, u32 *tc_bw,
>   				       unsigned long *bitmap,
>   				       struct netlink_ext_ack *extack)
>   {
> -	struct nlattr *tb[DEVLINK_ATTR_MAX + 1];
> +	struct nlattr *tb[DEVLINK_ATTR_RATE_TC_MAX + 1];
>   	u8 tc_index;
>   	int err;
>   
> -	err = nla_parse_nested(tb, DEVLINK_ATTR_MAX, parent_nest,
> +	err = nla_parse_nested(tb, DEVLINK_ATTR_RATE_TC_MAX, parent_nest,
>   			       devlink_dl_rate_tc_bws_nl_policy, extack);
>   	if (err)
>   		return err;


