Return-Path: <netdev+bounces-247639-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 33A7ACFCAED
	for <lists+netdev@lfdr.de>; Wed, 07 Jan 2026 09:51:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 7A5B330022F8
	for <lists+netdev@lfdr.de>; Wed,  7 Jan 2026 08:51:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 442C52E0920;
	Wed,  7 Jan 2026 08:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="UzJga3OQ"
X-Original-To: netdev@vger.kernel.org
Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010032.outbound.protection.outlook.com [52.101.201.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B57C02DECCB
	for <netdev@vger.kernel.org>; Wed,  7 Jan 2026 08:51:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767775915; cv=fail; b=kaqyX2CKkWxyQ2KNbu8nMzJgljt1vSr609LnmKO6Ulzifu/YmBfzIiryJXdESrd2vbIjeahsUWGd6JjlBlpeuL3ScZ9Aw2JJdcx1PfpDZj0piqhcK3HzJcd89Dp6ZyNH9cAwINuYrxhUgvuRMdW3s6iDrfnSN3Rqfk04rAzymTs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767775915; c=relaxed/simple;
	bh=/S/cn1Bi92t1HXgqaiwXnw/4pSnIkoa+umovhVV2f4M=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=f3COjTWIQl2iO7DemSr7zR8Q2U6632VP6/0Khbnpmmp1nwCmQBrx1NDmDmlsOFauFnaxJYxi5l8pS5SDdmIM6FDuW7Htjd5REilGsWagpZ19JsFfp0Fc4onejiJoHOuruMVDWsqRdLulo5nL2GYUz+kHJv0z6Y+4eB21wwG8Zj8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=UzJga3OQ; arc=fail smtp.client-ip=52.101.201.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wFbQMyGLYbhIm3DjqknSx+kLV/tY+922RiIBNLo7UzmOYCaWw52ua+QC6HQyOxZLBCIJ7nE00fcyL003v3KwHNCdny1MxV/2iCJWH0nCgItklTGFg764KTLuh6C+06PN31bnTocdDP7PfNM6FzqE5Z05DjgaEF3UBB32zOupch4HmV5gy7gbIm9w+UeU8NArFhd0mgJxfF4dCDYqpyS+wabLyh//YqDx6RE3DenpuM2uyTjs2lIMXGRDZlSWmOF9T1+aH0QLD9yksPxykNAxQOBOGlDHm0THGnBiseFAgqtadE3kiexgwGi2gV450X/a2IszSutlV4vR1NEzKVknkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m86ogoPKBC+Ig+KZ0JW59C3cBq67hGiO5M+HfakaUj0=;
 b=jOJ8/FFwh0/HMhmtDy+6AzAqbpEjnIZ4bhwHa8Xm1e89PuOeLTgpzugXGOINtti2RPn2W2tPNmYfQCbvaDBVzeRpCH9Pjxi7UxOuUuLWIzKmdWRLyjhuOuwk97j6+9I4njpRgHJZjIZIpvR7ek8oWGAhGd69JiY2A9AQL0s5+BSn68oD1NieyqkawFagDYNj085AFz1zCAgahgJka1+Hx6bqNIPdBk1TK4SnHVX3ugoV61GLC04oiLoQqIz8DBwagBYv6BMOu9dfBuHeVC2L55b21ouD9H3ALHBNAnr8qaHOVkSncMSfBKzLdtDJyPdEXxNdqSaGOXdAe6BS52wAvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m86ogoPKBC+Ig+KZ0JW59C3cBq67hGiO5M+HfakaUj0=;
 b=UzJga3OQiOgbc0C+bII9TZfvMKRE0EHksjjzD2jQnEvW8fKFzlRXpMXe006FkGaUDk0G7eG+JHLPqHr6B9TdRc+MNCKolc5zOh75os8gUCJ9PBJfgDzk7XG1OwLv1/Hbw35j5kLfrpfLGD+jn0mxLmwc2NKFeyyxI5XLi7Opi3rVcdfFzwg/xUgtsYJ6J1IEGOkDts5FjmiL5Jx4zdmRMgH6ZzuYrDuI4UdythIFjKRIuq0JHncXxzaGJOxgQIfrIh4CrLGXoic2OHEod/XszP6Twp7v2gt4D0y6wpVuVnDWMMgUD/VEYMH9mU+uRfrUUf8uTLnkNDVUup/V7p5f2A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA0PR12MB7003.namprd12.prod.outlook.com (2603:10b6:806:2c0::10)
 by CY3PR12MB9677.namprd12.prod.outlook.com (2603:10b6:930:101::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9478.4; Wed, 7 Jan
 2026 08:51:51 +0000
Received: from SA0PR12MB7003.namprd12.prod.outlook.com
 ([fe80::4099:396e:1f40:169b]) by SA0PR12MB7003.namprd12.prod.outlook.com
 ([fe80::4099:396e:1f40:169b%4]) with mapi id 15.20.9499.002; Wed, 7 Jan 2026
 08:51:51 +0000
Message-ID: <8d5e3870-1918-4071-8442-1f7328b71a75@nvidia.com>
Date: Wed, 7 Jan 2026 10:51:46 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] ethtool: Clarify len/n_stats fields in/out
 semantics
To: Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 netdev@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>,
 Simon Horman <horms@kernel.org>, Dragos Tatulea <dtatulea@nvidia.com>
References: <20260105163923.49104-1-gal@nvidia.com>
 <20260106174816.0476e043@kernel.org>
From: Gal Pressman <gal@nvidia.com>
Content-Language: en-US
In-Reply-To: <20260106174816.0476e043@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TL0P290CA0003.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:5::18) To SA0PR12MB7003.namprd12.prod.outlook.com
 (2603:10b6:806:2c0::10)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR12MB7003:EE_|CY3PR12MB9677:EE_
X-MS-Office365-Filtering-Correlation-Id: 3d171995-c82d-4319-31c3-08de4dc9ffd7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aFppdnMrM3BNbjM3bUFKY3UxSGJwV05XVXE3eTltREtMR0ptWlVZdVg0K3dE?=
 =?utf-8?B?WDVZSFUzUXRxb2xwZUt0MGVPWmZmRVFJUVJQYno5TVR2cGdYSUxoRm9MTlE2?=
 =?utf-8?B?RFRsVWhwWEU4clhXSCt5Vm9wVkY3eUQ4Z3UvdDhPUEZ5Vzl4cGRWbktocTd2?=
 =?utf-8?B?c0tEOTlzelg3MlRJa0UvV2ozSisrWlluaEpqR01kQU5XbHdHS2g2d004QVhP?=
 =?utf-8?B?MDVpOXQ1NHN3ZGNLMjJQRlpvQ2lsU04rQ3BCKzhYRzl3RzJzZlJCOGRhaHYw?=
 =?utf-8?B?WFd6WUgrMzFwMm9mLytiYThnUEFzY20vNlN1ODNIYlZYUVpGOVMxZkpTMFgy?=
 =?utf-8?B?L1ExbmJzcjNXNlgrT3IyUGZhMFViTHJWUW1RN1F5L3hHTnRxWjdkcGRmQm04?=
 =?utf-8?B?b0NlMDY2SU1ZMUExNEdCWnh4N2RaS1U4RXh1MGduamoyZ285K3VRV1MvZ0oz?=
 =?utf-8?B?STlrZ0NrYTFHK2RIQ3FONFdKVE10emVhazJMRnV3VnJabWhjYjJnMDh5cXZq?=
 =?utf-8?B?dlN1MS96YXAzMjZKOVZOU3B2bWJKM3MzMmRNNEVTNWo4WG5ndVdHVEVyaGh3?=
 =?utf-8?B?OHdseWlLbkt4U3IvSFRKREgxL0pZR2hTYVcrczVtNGlNclBjZnQ1Uy9kaUYx?=
 =?utf-8?B?Vk1yR3BlUm16R0ZtVjQ1NUJtd0NoRTlmbnM0aDdvYW5qMXV5cERTR1VST2JS?=
 =?utf-8?B?UjZralZDemI5NXdtVlJyd2F3Zm4xVUpUYkd4b1FKNjhic2ovaTR5NlpZbDk2?=
 =?utf-8?B?R05nMEIyUXJ6a2tua2JzQ21vQXhFd0ZTbUhUL1M0eDl3Q2NpNkhRNTQxdDM2?=
 =?utf-8?B?UWZDZzArUmlpZEUyRUIvdUZXaURObVcrQTAvZ29raS9mV2hLaTN4VEFOTERh?=
 =?utf-8?B?MzAxSWZpRHg3UlhOazRZNlA3bW1mc0tlVWRWOUdmNEkrWGxYMG4wazhZWnd1?=
 =?utf-8?B?R0hPMzQ0cXdPVE1WaENPK2U4aGpDczRJK25rSVgxek5SbVRNVlNyNEIxM0s5?=
 =?utf-8?B?V2YwUnpPbENoNmExbFVERGdBMEl5eVptbjMzU0dJT1FkcktxTHNGTUdYOGla?=
 =?utf-8?B?K3JqaFlSSjFUNGg4YzQyQTFvZUxHcDVXdkZtb0VnRHRxdHRMNmJoUnVPbHhs?=
 =?utf-8?B?ekxvRzAyUVgrZHJPZ1l5Yjhrc3J6RExieC83UzFpWHllano0K2d3dUVJOWgw?=
 =?utf-8?B?NnNiZ2hxZjZ5RlR4OFZzNXFWWHJRYzhEaGNMeUEybzFUMVg4eVlvNlU0QU9C?=
 =?utf-8?B?RnZqeXZrK0ZWdDllbGcrSmhkaWpkRVlIK0dIMnVjZGdKNVFuamhSc3Nxelpr?=
 =?utf-8?B?NFV3MlJhcjZoK215SVFCaWtqNyt0VlpMR1p3VXU1V2hHOXFaVmcwc0VFL2ln?=
 =?utf-8?B?RzYwREN6blBqZmkwWHFOTW12ZFAyRlVBUStQeWZzRUFSRUExczZVVlBGbzJv?=
 =?utf-8?B?aWNKNG1HM0lUS3BHK1J2TCtyT0pWVEpucDhaZVZkNjhvd3hUS3RORjR6Mm8x?=
 =?utf-8?B?YnU0K29BSTQraTFLZHNFVWlTbzAwcE5UWVVaRDJyd3R0VlJWcElhOGV4MWRM?=
 =?utf-8?B?aHZnUnpBeGk2ZEhKMktvczl3OG80ekZQbTQ5WUs0bituQ1RGbUJwRXlFZWJJ?=
 =?utf-8?B?UmFINi8wTGxRS1EyWnB0UlU3Qjd2aXE0dUxnNEl6RnZVS1hPK3pZY1BMTlR6?=
 =?utf-8?B?OEdudmVCQXdoMi9hVUhhdEhkVHMvSzd5KzNpYUpjYUIzZGdFMzBEZDNLSmk5?=
 =?utf-8?B?ekc4UWptRzI2eVJQcGlhUlplY05hUXl4dkl2T1VSa2M2dHhTSVY5TnpYSlN3?=
 =?utf-8?B?UGl5K0tKOS9TUjQ5V1NucnorblhxS1lydDRrVTF4Uld4RUtsaTY2MVpYK2JE?=
 =?utf-8?B?Vlc2dUZlYjUzazYxS0J2c1cxZzZ6dnVCN0pZbFRJWkpxblZIajM4Nkl6NjlD?=
 =?utf-8?Q?aNhew5kyUXID9Mte2gkZTciP07PErXOv?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR12MB7003.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Y1dLME9zaWtOZnNDYWdvelhKTnJmMUNPNWtSYmV6bWJJRjF1NUxvenc4R1lM?=
 =?utf-8?B?eUdvZ1ZFNi9BNDVoV1g1anZkblV2cmtWRHlmTGNXc1ROWDhPSG1qV255ZWJ3?=
 =?utf-8?B?eG9wL3FqVzNuL3pXYnRRZHRoVnIrdVJiS2xoUHhLYVFmWkI4YVp3amtCSTRS?=
 =?utf-8?B?RlEwU1lMVnprTDVlTWZrTTJlVHQ4OGszeGxPdjhJcGI1Y0kxTUhDQWdpYklB?=
 =?utf-8?B?TVdiSEJTb0JPUTQwRkRRblFiLzNBVkZQVllvMjI2U1dRZnFXZW5VZDgyY2oy?=
 =?utf-8?B?Q20ydCttaTQxa25zejZrc0YxVmk2MVUwYVNGZ3BTZWdRbzgwZ2s0MUNYZEFh?=
 =?utf-8?B?K1IxK2xSbE1OOGJVeWVvaWs4OFFzU0dRQ2NCOXRkNFJjajNYL1FLaXFlbWxo?=
 =?utf-8?B?SEpsbjVvaUxnUXN2YTN1ZUdpdGkxeGlnbHdRdWIrcUo1bU1LeFR0eG1aMndo?=
 =?utf-8?B?MjlSL1Foa0ZqUys4VzRRUDJTdFdLQ2VGMDJPRWlIODE5dGNlaG0zbUZZRm9C?=
 =?utf-8?B?N3BWczNsbk1kWDlzYmlDSXovUkFVTjZhcmcrVkpiYVBoSDdNOUNDQUxRcUYw?=
 =?utf-8?B?ZkZOOTVobkNPS3J4NEFWZGE4ejUxeEx4Q1piVDcrbWJSYzlxMkJMenhuVGlv?=
 =?utf-8?B?VkFJa1BGaEJNZUYyYnFrTUx6cXFJU2ZDUm9xMnI1UkJVRGhLOUs5SHF4VXRG?=
 =?utf-8?B?RzZzd0VMOFJ2T3p4NlJvWjZrNklMT2RDVlZaZDVoUDVTMDBxMUVYUGVyM0Ji?=
 =?utf-8?B?NGszeGhEQ011MUxNN0dYKzBpZUpydm9FRE13SlpxcEpkcWRvL2JXbmJMK0Va?=
 =?utf-8?B?bzV4L2RncXU3VkZzOGl3M2k4UzZOWlA2K3ZPUHRneTBoSjdDZnl3bHo0K1lY?=
 =?utf-8?B?U2pWN2IxMXZZS2RWT3UzRE1tanFwVUlRU3h2OGM5Vm5jZHlsYllvZE5kOVU4?=
 =?utf-8?B?L0VubUVSVUorNk02dEVUZDdIQW92Zy8wKy81Tk1iRS9nNFcweGtaTlNiTG5H?=
 =?utf-8?B?SVpYZDB6Q3p3NC9ZWlR3NmhzZXVRU0JGRFR2dGJYQm05b3VWUXJiRGVnQUla?=
 =?utf-8?B?bVN1RVZEdkxyUTNUQTNXQUJlVVBRVXlFem05azRLZjRqYXFqUXNPd1JLNFk4?=
 =?utf-8?B?dXowWHlPY21HSTlyTndzRHY2ODV4Y0o0TThWNk41ejVGUElLamVZOGI3bk8y?=
 =?utf-8?B?WGEzY0o5akVhWUlzYmhHVnU3QUcvQXM3a2ZyR0hrMHBtRmFpamhhbDU2V1hR?=
 =?utf-8?B?a0FibGtXdDZaZEFRY1paZ0dtL0lUNWlUSkNZZUNFUVBmUVNjWVBCdEJsQ01p?=
 =?utf-8?B?QmVnditYQWNaOXRjTkdtNkRUNzgwblVLeUtvcWVOamRVeEVUOXJFRVBZaGdZ?=
 =?utf-8?B?S29ocHRhV1JaZStIcjBJZ3JGTUdQRFF6dkhTc0E0WVp4RVFiRkRBQlpkclRh?=
 =?utf-8?B?UDhmWGJVYzg4REFwVWVpMlFod3RKR1RMcGoxQ3ZyLzVyREliUDgwcVp2cTVp?=
 =?utf-8?B?aWF1WnhPTjIwYnZ6MHVqOG8za3IrRWhCZDU2SDdocmtaRlF3cDRrU1Voblp2?=
 =?utf-8?B?bHFNZThUZFJURmEydlovWHpzK3ZGWnNIVGZWTVR6TWFJWC9sZHdHbkpRZDQ3?=
 =?utf-8?B?ZE1jSnJkMllOZHFFYmNmV0p2KzlOcU1kT2RDWmltNXpHOTFBUE5TM0JuWVlD?=
 =?utf-8?B?eXRXYXlyalFEb3QyZFlaMTltemVnSXlDNWx0czFucG90cjU1Y09iclFNQlpu?=
 =?utf-8?B?UVI3d3BsV0tDbk50NEJSdGhEUzZEVlBZWnd3eEowc0tKbGlDbXRpMlErYnBw?=
 =?utf-8?B?eXJZcjRQSTZWUlNTaFF6QVJIVHV1alRmT1QvYXh6YzBIUHAvNEV3S2Rla1Jz?=
 =?utf-8?B?WFhBVGlEN2s1S2IrWlZzZG53ZHdrR2FlL3FkT1VpYmZxT3ZkZzBhMXM0dnlz?=
 =?utf-8?B?WkNxV0Q3WmdxRXJFa2RWK0ZlNnhpYVNUanl5WStONnJ1dk1URytRQm1ob2NC?=
 =?utf-8?B?K0hsVURVbDUwTk94ODFVVWlzS3prSHFKc2p2M25kSk9jTDROLy8vMEFwcHIr?=
 =?utf-8?B?YnRGcjAzRkJSay9rcUd0cG44SDd5aXlQMDlBVnYxUmZIWk52bXhaelp4dTdW?=
 =?utf-8?B?V3BORE1lL1RUV3UwRnI4SkM5RlZHdVRabGtCSXovd2p1RHQwdHh2TlBKcjVk?=
 =?utf-8?B?bHo5V3ZDQjdIMFlzOUxzRGZwWm9XOXRpU3ErK3NaTXE0OFQ3bHg3bnhtdDIv?=
 =?utf-8?B?RzZFcVdKUkhEN1laNVpzNjdud2RLN2Jmc1lacVFtWDdJOWF0K1dHQUJKQlNU?=
 =?utf-8?Q?FgXKlxUHKAiL81SWmA?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d171995-c82d-4319-31c3-08de4dc9ffd7
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB7003.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jan 2026 08:51:51.1789
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EUzhnw84ZOqujhnswiXseXP1YSptUQsJIygE2gd0EQdhhYPWDxFNJ7ln7Dkc1eoy
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY3PR12MB9677

On 07/01/2026 3:48, Jakub Kicinski wrote:
> On Mon, 5 Jan 2026 18:39:23 +0200 Gal Pressman wrote:
>> - * @n_stats: On return, the number of statistics
>> + * @n_stats: On entry, the number of stats requested.
>> +	On return, the number of stats returned.
>>   * @data: Array of statistics
> 
> Missing a '*'

Ah, missed it, thanks!

> But stepping back we should rephrase the comment to cover both
> directions instead of mechanically adding the corresponding "On entry"

What do you mean?
How would you phrase it?

> 
> FTR my recollection was that we never validated these field on entry and
> if that's the case 7b07be1ff1cb6 is quite questionable, uAPI-breakage
> wise.

Can you describe the breakage please?

The kernel didn't look at this field on entry, but AFAICT, it was passed
from userspace since the beginning of time.

As a precaution, the cited patch only looks at the input values if
they're different than zero, so theoretical apps that didn't fill them
shouldn't be affected.

Maybe if the app deliberately put a wrong length value on the input buffer?

