Return-Path: <netdev+bounces-200515-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9715FAE5CBF
	for <lists+netdev@lfdr.de>; Tue, 24 Jun 2025 08:27:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 145574A589F
	for <lists+netdev@lfdr.de>; Tue, 24 Jun 2025 06:27:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3CA9227574;
	Tue, 24 Jun 2025 06:27:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amlogic.com header.i=@amlogic.com header.b="G97lPQgF"
X-Original-To: netdev@vger.kernel.org
Received: from TYDPR03CU002.outbound.protection.outlook.com (mail-japaneastazon11023098.outbound.protection.outlook.com [52.101.127.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBC992222B2;
	Tue, 24 Jun 2025 06:26:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.127.98
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750746420; cv=fail; b=eHMydVu+MiH5Yp/vjDbxHP3tP/JDZ+92MA4WPRbyA+5coMj0SHO6iuugcsqceMePbj9hYxoEQKiyzad501GTg6FE/01sAUHgl7r+jIqvvZ1xu6tBYTeQm22RBkMlt9HiUpqU7QufYO3QuMR/+djPNNnuRF9YDK1p70gigxtI6ms=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750746420; c=relaxed/simple;
	bh=xl72oVuBJwUNar8Rc9WXKL7b/TBorIYZR20w3rU44dM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=rbjbiJKgMEUPVQ4Lr7PrO+AlejzC30WHCn/UvInMX1sajGFUpX4QWYpQq89M5QImY13iplQnISnMg2/kn3IVn2FKZl/e3cbUm6IMRrk9KiW97oqwhXF8I6q+7f+GOKZxaLKE7tTaFBc47tdyFrqGX0/yavUy6yEkrroRaKBK9Jg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amlogic.com; spf=pass smtp.mailfrom=amlogic.com; dkim=pass (2048-bit key) header.d=amlogic.com header.i=@amlogic.com header.b=G97lPQgF; arc=fail smtp.client-ip=52.101.127.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amlogic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amlogic.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JNJhFhoU0yMPHmufLN3UYfIF78HfJf+xW+J3VFkQNzrbz2p1DhhdehwCNDTr/Zk3AGiura5c+YOk/R+BlN0ljeZ19ySpDkd5pFPMI45hbUXYGx9mXahT/LMMlNMwSQwaqFzBHq5uOs+saDuLDr5+j7DT9faX1uZOkEeRMXBlMp3yA3mAbuw3aFmZZi/jnlyCMaugnmXua+ZjbyQfjCycgT22DHmek79H3ULPHp0ER+y1+3wH5XQa1vXwavAHOelOlUUIUpFzSmZPim9hqLLFn53KKM23BTJuujPprLlraGEi2ZbV/UaHClGh4l8cO6C8in7KJt60Aq8fH73I8s3qfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a0rCEKrurimgjDZbO/FplKgKtFS6CnHlr3KjoeVxdLc=;
 b=Mt8OUdnlHGH0etz/C3WXksgNUqaODqA38/pL+7ZIIAV8pk1UVmrm9kfWAqRHjmB03LcmR/M14rJsXJIyAWOlXuV+/fFsCMpAi3E5dTiKvrszmv0TKGDM7vwBX0qNkPOzfkH2Z6eEXpCs0YwAVHATPagykCTvpfSQ/blCkRb6BjerqqlejHoBQscjGklTCjkr0ISarlcjaAHtt0DnuBFdGIDxAJrEyimsg08gnjxHE4C62IeuV41kv/vIuYYY4i9uLH6jdazGiomLiCQaIzYftsMcqUBSGKZzGsXOqO215hyJn7C5SOgH86sTfwGhD5lG9ELI41CMA4tcZXLd3rtaog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amlogic.com; dmarc=pass action=none header.from=amlogic.com;
 dkim=pass header.d=amlogic.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amlogic.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a0rCEKrurimgjDZbO/FplKgKtFS6CnHlr3KjoeVxdLc=;
 b=G97lPQgF+2Lh7n+8GFvK2b4mkD+slgLhKhEBuS5/PrexhSo0xbCFqovm7/d9DtO5Mk/SxhgS7MD3xTDyGNxvIS3YUWXjnxSOvWNs+vk9wJeYXNBhHpaIIfinJ0cVn7lMcCiLbu5PVnjlV7tc950UXQWLu1Qc9GpLZXdOG/NnpYQ675JXMPmQjWB4fUYhXt+MiDd7GYnyQKmqO3GLel7xEJVEbXmNAagP0mBl+MxWEBzoYWm1Rd8eBLOxrnALbIE2ITLbICCVKHk0xXQG0uL48/NGCMCQAmaoGDxB0MspByulOCrtB0xGxQfauRpqv3eBRMr3QRVwZa3j5MB7OZ+9NQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amlogic.com;
Received: from JH0PR03MB7468.apcprd03.prod.outlook.com (2603:1096:990:16::12)
 by TY0PR03MB6678.apcprd03.prod.outlook.com (2603:1096:400:213::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.19; Tue, 24 Jun
 2025 06:26:54 +0000
Received: from JH0PR03MB7468.apcprd03.prod.outlook.com
 ([fe80::4128:9446:1a0f:11fd]) by JH0PR03MB7468.apcprd03.prod.outlook.com
 ([fe80::4128:9446:1a0f:11fd%6]) with mapi id 15.20.8835.023; Tue, 24 Jun 2025
 06:26:53 +0000
Message-ID: <d3ca7e7e-720a-42ef-b32e-19cd84d208a7@amlogic.com>
Date: Tue, 24 Jun 2025 14:26:31 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Bluetooth: hci_event: Add support for handling LE BIG
 Sync Lost event
To: Paul Menzel <pmenzel@molgen.mpg.de>
Cc: Marcel Holtmann <marcel@holtmann.org>,
 Johan Hedberg <johan.hedberg@gmail.com>,
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, linux-bluetooth@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250624-handle_big_sync_lost_event-v1-1-c32ce37dd6a5@amlogic.com>
 <4db45281-9943-4ed7-80c6-04b39c3e9a5e@molgen.mpg.de>
Content-Language: en-US
From: Yang Li <yang.li@amlogic.com>
In-Reply-To: <4db45281-9943-4ed7-80c6-04b39c3e9a5e@molgen.mpg.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG3P274CA0017.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:be::29)
 To JH0PR03MB7468.apcprd03.prod.outlook.com (2603:1096:990:16::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: JH0PR03MB7468:EE_|TY0PR03MB6678:EE_
X-MS-Office365-Filtering-Correlation-Id: bfa69808-0e0b-4575-93ee-08ddb2e81c8f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bzF1N3hLa1Rvcm1PemxzYVlndndSa083SUVjNDBpKzd4SUNXeElmZ0NxVFpO?=
 =?utf-8?B?RExFNFZVTGl5Um0wSm9vWit1YmhZMzRmd2dCT3Q0bHY2OXF5MUhzcUJRRkpy?=
 =?utf-8?B?YTVtTDJJUEFrOTZtQ1hZZnNPS1FKRHMvVnVZVXppK3U2ZnhlR0c0RUxqRGdx?=
 =?utf-8?B?dnp1MUswaENpcUQrSStkbjgvUnFPaW9SeDRicks3ZVhPK25EcE1YUmU5NDdH?=
 =?utf-8?B?aTJZTmZkNXQxVTVVRER6K1NvUG9lWTVZcWtwN3NhemFlbEFpeVl2S0FnOGd4?=
 =?utf-8?B?N24vQXFSQWlrVFl2Z2t6ME5JTWIwQllrWTVRNHBSSGh4OWRydnEzQ2IyTTF4?=
 =?utf-8?B?aFBGUngvTFh1RlhvSnZ2dHJBSmFoL1pUREtqamVsS29GQUVLYW9jSmJoejR0?=
 =?utf-8?B?NlZHZXFnWGZUK3NnbHEzMldBcmZoaWpyMDl1clBiM0I2Zkp4NDVIbENSdi9Z?=
 =?utf-8?B?c0RwMHE1UmE0b1V4Y2l0a3VwYlJtTjQ4ZmdFcHB1WUdRWmNFNzk0ZTRDQVFz?=
 =?utf-8?B?WUppSXF5MXZ6dG03RTVubjVvNUFZVktVUFgwWld4NVgrZ0drTUlsYWlDcEpX?=
 =?utf-8?B?UktRWkJHQU5yeWVJbXFTMG8vZ3Z4MGhYeGVNUjhTR1E4RlJhRFJ4US9Ra2tP?=
 =?utf-8?B?b2ZWdjE5azZ3aTdVdXkvQk5VZ1ZqVHo3aDQ4QkxoWEsrM2FLYTAraGtOM3Fo?=
 =?utf-8?B?Qmo3eVJ0TzFsNVE2aW9iaFcxRlYxRWd2TTU3Y2dGY1prd25iczdPbHdEcEZx?=
 =?utf-8?B?T1owSVNaa0FHVk9iajBBT2oxZE1wcnc5RzJwRG1qa1gwR2FFNmE2MUNjTndk?=
 =?utf-8?B?bU52RDh5R3VTdWxiaDdlQWx2T3gyVGFKczBvbG16YitJekwxaUcyWFVFZ1BT?=
 =?utf-8?B?N2txOXNUbFJPRWM0cms3d21wMENDTWptdkovcDhPcU5aNmprWmE2K2lOdVQ1?=
 =?utf-8?B?MEVnNUxWbGQrd2dIOHcrYzMvYmNPSm8vV0MwaUhPZHlyTG1GNTFmcldDOE1w?=
 =?utf-8?B?NmxLL0hwdkpYNHZ3WFB0WG5EOHM3d0k1TEM3YUJQRmd3OEhLdU9GMlNyZ0li?=
 =?utf-8?B?azBpdElpOFNPVnY0bEgwMllXZWlJVDgraVNuVWFzVG45UXI1c3lEYVFaWHQw?=
 =?utf-8?B?VmxlVkJVWkhqY3VLUmxtOUhPL3JnNnhkRjc5V0kwbmlrR2l0RTRKSi8vZHhL?=
 =?utf-8?B?SFlDU2RNNUpsYUJvQ0Uva1ZmcGNSemp5VDRBS0ZuQ0djM2MxL1FlMW1FNm9V?=
 =?utf-8?B?VUM4eXVucHdQSnlGbDhuUDRBc29PdmtSa2h4ZGFBMVVjc0RUVkwwK3UwZUVT?=
 =?utf-8?B?K0xHajN0UVAxaXBWSnd0RnoyclpmVGRiaTZrY1N1NXljVzVFMURUL2tnbDNW?=
 =?utf-8?B?Zm9jTzJ0cVJnb3VTYmhlR0g3dEdzenJwNjVvcGxOdE5lemcxYXNTVkZLTkcy?=
 =?utf-8?B?eEhTbzVFdm15ZlJPZ0hucEhDNjhBSHo2MjZnNmUrRkkwRUFHNXNkYjg3cmVQ?=
 =?utf-8?B?ZTNLOWlVdmlHVGRJbExSMWQ5RE54UjZRdHJHOStZa2xDWFBnZ0F3aktpNnJU?=
 =?utf-8?B?VGZzc01oaFBCZFAwOWo3YndNeEZ4bEU1OVpuYWJWU0x4SEVyc3lkaUk3L2w0?=
 =?utf-8?B?WFFyTFdrM1pwS2lFblMraWlMVjRXbzdwcUF5THo3YWRrL2N5WjZFNTh3d1Vo?=
 =?utf-8?B?a2Y0bnNTSm9HWnVBYWVudVJ2Y1BkQXhGSWROK2FaTEpNYVB4L21GeWlBcVlN?=
 =?utf-8?B?SjNhZ21LZmhCdjRXd1BLcEdza1R3cWluYzJvR0M2UzJsUkZnQkUwZ0dWOElp?=
 =?utf-8?B?WU16YUdTU1A3Y0JUWjRZVTkvdlovUlBaaWVBbTlDSmVKV293QXBEelZXeFl5?=
 =?utf-8?B?cVVQWnVJNzNVTEVuOHR4aGtWSlR3dlF5cGNKWEZZZTc1SjI4enpGMzNTelVS?=
 =?utf-8?Q?sW4TqC4B74I=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:JH0PR03MB7468.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Z24vZk1hRUhIMm1wTzRrYVZxdEQ1ODI1Z2dsZURhaTVnR2Z0RTRvenJYdlZr?=
 =?utf-8?B?b0k4WFNhaFdVK1RpWjRYdmZ3dFRHUGRKV3E0aU5TVjA5M3pzUUZrZFFSR0hK?=
 =?utf-8?B?QUhZRlQ0WVZZbVNyL0RJenFhSXdMK2FkSGtWN0ZSZWE2OGhTbG8rUEZ4OFB2?=
 =?utf-8?B?RGJsN1hSYU1iaFFWNnp0TGRHL1ROY0RkcTJsT2RGZ29tRzlRNmpDTUxnRmZN?=
 =?utf-8?B?bUVjeDhKVUpIcVRYTWwyZHRMT1JzMkh1OFpKTU1XeUZSK3BUWGZoaDFSZzBB?=
 =?utf-8?B?aHlpSzlSSVVwbFRmbERCbSsrMVdhZjlVQUQ1UHFKSW9KaWhXdVJlWm81MFkw?=
 =?utf-8?B?K3hXMFVmUHpEUnJ2dlZtVWM4RUU2b2FTOVU3VWpLZzc4RDJ0VGJ0UnhiNml3?=
 =?utf-8?B?SmZhSGh5bVE0eGpsc0RQV2ZWUjRrWXU0MEJQYlRtTmo5VG5LSmp4RUJMTnkx?=
 =?utf-8?B?TFlqb3k2a0wyNTFEZEdYNGhMVERpTW1kZEhERlpKdGVHWEFvdlhBVGVLeDJH?=
 =?utf-8?B?UldiL2taY3JsempZOXVTbXg2UUZtTy95M29yR05rT2QzT3RtaVBqUGNxMTYy?=
 =?utf-8?B?SE45NEwxcjNtc3RaaEhsN0FLM3lYMUlTdC9rYzRsbVlBam9EUDJCTFZlUW9M?=
 =?utf-8?B?NEsxamJBS0pqT3lpSUQvUU1VdlUweUx4MnJZWXdFT1lmeWNtVlJMNStSZ29a?=
 =?utf-8?B?QXgzd1NqL3dHbFkvcWJPY1VrZXJJVGNCSG1kT0pKcGpqU0cxSjZWRFI1OUhs?=
 =?utf-8?B?cEtSVFN0cUc4MnZwbzZ6eDR6a2c3bHdVQ3JzZmo3UlhYY0dxbktMUnNQNHE4?=
 =?utf-8?B?S2ZzbWVPc3RjdFBnQnhieHRuSXpVdzE1UFlvWlgra1hFZXJNN3BSekJxQWZq?=
 =?utf-8?B?SzAxUUNicW5VVktRdHVBanBIcjNYM0l6RXliUE9jK2RRdCs4VEE4ZTA1bmVj?=
 =?utf-8?B?N1FWT0RwMzVpa2NEL2VkMHZDZVJYMlBCZkp1YUFCSVFlVnk0QUQ5Z3pUOFhC?=
 =?utf-8?B?cFcvT3FqRjZpWEJxYXFOTUgrTlVDVG5jVGJDWDlocXhTSnJwWjlQcSsyZWFG?=
 =?utf-8?B?Tk4zK3VQS0toVTdhYjVCcmNoL2JKcmlYS09hTm1nZTZWNFA5OXhVaFRFYm5w?=
 =?utf-8?B?UnFXU3lFd01WMjg2enNGcHRmVHpNck51MGhFRnR4QnhPSFd0WWM3czdrL2Zw?=
 =?utf-8?B?c29qUDFDbUJyV1E0WTNVbGc5TkwyT0RsYnVFMEh3RjhvcnFjR2gxbk9JSVdt?=
 =?utf-8?B?YWN4QWROUHYwdGYvWUpnRCtxSnJoTGJ5MXZlRGF6S3ltRjc4Q0dBV1d6UldU?=
 =?utf-8?B?WXVEU3p0aHIrTnh5dWJISWNoa0F5WFZjd0ZicFRwRmU4SjY3TjFEM2RPd0Mr?=
 =?utf-8?B?ZW02UXlaMU9ORTNWdGhiOXovTU9Gc09UdG45cTVXNXZwQ2Fra3ZSNjRxK2s5?=
 =?utf-8?B?Y044cnZBQjFpa09Nalc2aGtNTGhPS210RU81YnRkVWFteXRQekV5TDZpcGVX?=
 =?utf-8?B?VnJyQVJyWjFyaXQvTlZZS0hEVDZlZUY3VDJmSHg5ZzVFYXRvdjh4VHZTdlZh?=
 =?utf-8?B?d0tqS2krT2gyV3J6STZXb2xpWTBkL3IyKzMrWU85TE9XeDZxenNqUFU4enpr?=
 =?utf-8?B?d0FvU2FzSVFLejlKcXUyZTFXa3pOTU5ZUm9pVHQ4RG1QUk81dFkwbStkSlE0?=
 =?utf-8?B?bEN2VGtPdTlZc0hoNWFSZzJwVUx1eWw3Qkw0YUlkdXRjVXc3RmVQd0lGaWxG?=
 =?utf-8?B?UGJTZUF5RnN4emdXSlRzU0cyZm5zTm1qMkF1ZE93aURUVXdzNXh1Q0RwejRJ?=
 =?utf-8?B?cnpyTWVIU0txRGx1K3J0aHJOM2FiaUJXMExjdUxmdGhoTElJb212eVJkVFBP?=
 =?utf-8?B?S2hsSXhtcjI1cG1yaTRDVjlQOXVMRks0RGgxRGRJa3pyai8zdXBER1EwQkZo?=
 =?utf-8?B?WEZiemhEZ1Blc21vbU5NSXZtU3pZVEFDcFUvZytZblk4WFN0cGVFVHZDMllw?=
 =?utf-8?B?WGlYTjJldTc2cXhLOEhpN0pkQ0VzY29CMlR1TnFwKzdjdXRWMVhoYjhiRDVa?=
 =?utf-8?B?aG5uUjhtR0FlMDdrUFg3N0ZsNGVhVTFYK3FXZUpYUzFhYkRuQVp4dmp5WG5O?=
 =?utf-8?Q?vbznILelxuqAnqo+kWll1tPzd?=
X-OriginatorOrg: amlogic.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bfa69808-0e0b-4575-93ee-08ddb2e81c8f
X-MS-Exchange-CrossTenant-AuthSource: JH0PR03MB7468.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2025 06:26:53.9156
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0df2add9-25ca-4b3a-acb4-c99ddf0b1114
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RMl6IliSvF0YNIIXrKhssHNSjKffipfm0yD3sXozQ4a8visB9JD2BXLTe3M3Zxl3SDbn2a2/4KzO8uU0pmV/cg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR03MB6678

Hi,
> [ EXTERNAL EMAIL ]
>
> Dear Li,
>
>
> Thank you for your patch.
>
>
> Am 24.06.25 um 07:20 schrieb Yang Li via B4 Relay:
>> From: Yang Li <yang.li@amlogic.com>
>>
>> When the BIS source stops, the controller sends an LE BIG Sync Lost
>> event (subevent 0x1E). Currently, this event is not handled, causing
>> the BIS stream to remain active in BlueZ and preventing recovery.
>
> How can this situation be emulated to test your patch?


My test environment is as follows:

I connect a Pixel phone to the DUT and use the phone as a BIS source for 
audio sharing. The DUT synchronizes with the audio stream from the phone.
After I pause the music on the phone, the DUT's controller reports a BIG 
Sync Lost event.

I believe this scenario can also be reproduced using the isotest tool. 
For example:
  - Use Board A as the BIS source.
  - Use Board B to execute scan on.
  - Once Board B synchronizes with Board A, exit isotest on Board A.
  - Board B should then receive the BIG Sync Lost event as well.

Additionally, the following BlueZ patch is required for proper handling 
of this event:
https://lore.kernel.org/all/20250624-bap_for_big_sync_lost-v1-1-0df90a0f55d0@amlogic.com/


>
>> Signed-off-by: Yang Li <yang.li@amlogic.com>
>> ---
>>   include/net/bluetooth/hci.h |  6 ++++++
>>   net/bluetooth/hci_event.c   | 23 +++++++++++++++++++++++
>>   2 files changed, 29 insertions(+)
>>
>> diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
>> index 82cbd54443ac..48389a64accb 100644
>> --- a/include/net/bluetooth/hci.h
>> +++ b/include/net/bluetooth/hci.h
>> @@ -2849,6 +2849,12 @@ struct hci_evt_le_big_sync_estabilished {
>>       __le16  bis[];
>>   } __packed;
>>
>> +#define HCI_EVT_LE_BIG_SYNC_LOST 0x1e
>> +struct hci_evt_le_big_sync_lost {
>> +     __u8    handle;
>> +     __u8    reason;
>> +} __packed;
>> +
>>   #define HCI_EVT_LE_BIG_INFO_ADV_REPORT      0x22
>>   struct hci_evt_le_big_info_adv_report {
>>       __le16  sync_handle;
>> diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
>> index 66052d6aaa1d..730deaf1851f 100644
>> --- a/net/bluetooth/hci_event.c
>> +++ b/net/bluetooth/hci_event.c
>> @@ -7026,6 +7026,24 @@ static void 
>> hci_le_big_sync_established_evt(struct hci_dev *hdev, void *data,
>>       hci_dev_unlock(hdev);
>>   }
>>
>> +static void hci_le_big_sync_lost_evt(struct hci_dev *hdev, void *data,
>> +                                         struct sk_buff *skb)
>> +{
>> +     struct hci_evt_le_big_sync_lost *ev = data;
>> +     struct hci_conn *conn;
>> +
>> +     bt_dev_dbg(hdev, "BIG Sync Lost: big_handle 0x%2.2x", ev->handle);
>> +
>> +     hci_dev_lock(hdev);
>> +
>> +     list_for_each_entry(conn, &hdev->conn_hash.list, list) {
>> +             if (test_bit(HCI_CONN_BIG_SYNC, &conn->flags))
>> +                     hci_disconn_cfm(conn, HCI_ERROR_REMOTE_USER_TERM);
>> +     }
>> +
>> +     hci_dev_unlock(hdev);
>> +}
>> +
>>   static void hci_le_big_info_adv_report_evt(struct hci_dev *hdev, 
>> void *data,
>>                                          struct sk_buff *skb)
>>   {
>> @@ -7149,6 +7167,11 @@ static const struct hci_le_ev {
>>                    hci_le_big_sync_established_evt,
>>                    sizeof(struct hci_evt_le_big_sync_estabilished),
>>                    HCI_MAX_EVENT_SIZE),
>> +     /* [0x1e = HCI_EVT_LE_BIG_SYNC_LOST] */
>> +     HCI_LE_EV_VL(HCI_EVT_LE_BIG_SYNC_LOST,
>> +                  hci_le_big_sync_lost_evt,
>> +                  sizeof(struct hci_evt_le_big_sync_lost),
>> +                  HCI_MAX_EVENT_SIZE),
>>       /* [0x22 = HCI_EVT_LE_BIG_INFO_ADV_REPORT] */
>>       HCI_LE_EV_VL(HCI_EVT_LE_BIG_INFO_ADV_REPORT,
>>                    hci_le_big_info_adv_report_evt,
>
> Kind regards,
>
> Paul

