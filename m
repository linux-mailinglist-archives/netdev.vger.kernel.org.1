Return-Path: <netdev+bounces-253341-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id Tc77J+oOd2lDbgEAu9opvQ
	(envelope-from <netdev+bounces-253341-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 26 Jan 2026 07:51:22 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E943D84A01
	for <lists+netdev@lfdr.de>; Mon, 26 Jan 2026 07:51:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 679C33004C4A
	for <lists+netdev@lfdr.de>; Mon, 26 Jan 2026 06:51:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6E812848BE;
	Mon, 26 Jan 2026 06:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Fvj2xbW3"
X-Original-To: netdev@vger.kernel.org
Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011031.outbound.protection.outlook.com [40.93.194.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3311621ABC9
	for <netdev@vger.kernel.org>; Mon, 26 Jan 2026 06:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.31
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769410277; cv=fail; b=J1TkiIfM34BTGodlmIZVxbyUKzO/gTszeelGLcmtzV+uFTBj8oEc2nnxAcwgfzhxLhaFjMa02I0mzzzJxv3cTg1Xoy8eF/jeatSHXjnsF0f5nbb74VZvnTHaxdxfdQLmBCxcSCl5iTlXTbJkQFzsBxBDtJo76ziCNYuWsDNS3BE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769410277; c=relaxed/simple;
	bh=ojmAU/trlregaL+mSE9Rr61kNIrHP1TYpP4uJ4REZY8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=CQxVJrKiqgrnNgoesbbDusNQtYh/Vmmb1r7fg6XGjNW8FEgtlpqcWPIFNrsNZlWIwkWVK4tD72aQ/BUCu8U+Ba+OQnqUVzA4CPa7zA5kc12WWYZPoD44c9kT8StLKJbdaKiLS7De7pXCLcnZxl7m6RQrzkrkLcL5hLNyP/amd6Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Fvj2xbW3; arc=fail smtp.client-ip=40.93.194.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JwQo4KFMQLK4VQ1Mz0u3o0mpW/b7T2mWdmskpAh9y44EqLpQJcXRVyFkHcF0ubHxWD+wXMojrdgndVxqlQT2zPAJCCtQOHFQIbCCIPwqJ7Nvu+B0pgyx2xmU6/C+ZE+oKwqXtshdQ0jNfYOmnrYT8NgQ92KtoZf1uYz5P0H/tzXQNfFkv7/VRM6Ycqbh0lUvqkn5uSVf8wPNX4EMQ02Hi5pgaFpsn/CDrE2R/8wB+6dlTh9VQURhf7iLqK/bZVDcSRRH7ZOBm05BeiNp9mnhfZ7PmBFUyN9qWZB9WaMhOQD2pYBwF1uo2gyeQySY7DUOoqL3i4Dd/a2r5ialfJWWlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yux2LF6tpqcxVq4EATWUEa35LAZaWqPJbR23TLTa53k=;
 b=IkfD0WA++ujQBx3EwxNYzac7s8ifQ3j1u90o+clMXa0Ls1qoMv7um7b649Etf4/Aj0yh/tKR0A6DXBKfLDSQkOtH7zsb9eDXIApfczE7Ph++XLFgeqGazmq+6gYa1/72Mb3LONWCf8Qb3mivsKbIOyGdDAsK1DJrtr8hRBbriqd821Es5FQVu6S3p/3EwHlWOSX9pSWHlvN3BHkqO8JlNtlHKrl416f2qvpkWMup6/rksCfOLXZIwIoI+4kcw1iZgroAXERcd0OCX1mSJGhVZQnUyh/2O/Y7+XPCDKZHnZUXvFj+zRGOEtYsKRYXs02QsZ2E3NdHgRk4hCZxt4yfKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yux2LF6tpqcxVq4EATWUEa35LAZaWqPJbR23TLTa53k=;
 b=Fvj2xbW3MJ0g/16zZzoZHp0sRxpF0owQN+BpYA6MP1GWYGfzxaMjRUwooAnGLX74zaPbTo9Oms6ESe+NpwlsoUUx+e3fs8Iv5IXz0zMI7/Xjm5pJy8rrghuBnnrkDZes4mNEaolEZggTQNCaI/qlWgVdNYbHBuASAGNHL3N9LEC5OgeTJrkap76O+jwiFis6Cp3Q6DwOE+ORrkdlQBn8H+zGFj6UbF4bLv5Nlgv2+ehxJuuZIy4pF56sqkbKB9t5AlWO7ik3qahWQ8NUq3gAiNVWddHB6w8OC3IP78bYU7qLpFoXyOxnW3SpeVfeWwM1f5ZRn75awx3+67BO4H1IbA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA0PR12MB7003.namprd12.prod.outlook.com (2603:10b6:806:2c0::10)
 by DM6PR12MB4419.namprd12.prod.outlook.com (2603:10b6:5:2aa::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.16; Mon, 26 Jan
 2026 06:51:11 +0000
Received: from SA0PR12MB7003.namprd12.prod.outlook.com
 ([fe80::4099:396e:1f40:169b]) by SA0PR12MB7003.namprd12.prod.outlook.com
 ([fe80::4099:396e:1f40:169b%4]) with mapi id 15.20.9542.010; Mon, 26 Jan 2026
 06:51:11 +0000
Message-ID: <1e2d7bb1-517a-401a-9b8c-3201f44b5f43@nvidia.com>
Date: Mon, 26 Jan 2026 08:51:04 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 0/3] net: ethtool: Track TX pause storm
To: Jakub Kicinski <kuba@kernel.org>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>,
 Mohsin Bashir <mohsin.bashr@gmail.com>, netdev@vger.kernel.org,
 alexanderduyck@fb.com, alok.a.tiwari@oracle.com, andrew+netdev@lunn.ch,
 andrew@lunn.ch, chuck.lever@oracle.com, davem@davemloft.net,
 donald.hunter@gmail.com, edumazet@google.com, horms@kernel.org,
 idosch@nvidia.com, jacob.e.keller@intel.com, kernel-team@meta.com,
 kory.maincent@bootlin.com, lee@trager.us, pabeni@redhat.com,
 vadim.fedorenko@linux.dev, kernel@pengutronix.de
References: <20260122192158.428882-1-mohsin.bashr@gmail.com>
 <aXNAjOjkCqOESf5y@pengutronix.de> <aXNbTVF5KNz1yV-1@pengutronix.de>
 <20260123104031.16d914e4@kernel.org>
 <aa5f189a-ac62-4633-97b5-ebf939e9c535@nvidia.com>
 <20260125143025.1bab8769@kernel.org>
From: Gal Pressman <gal@nvidia.com>
Content-Language: en-US
In-Reply-To: <20260125143025.1bab8769@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TLZP290CA0005.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:9::12) To SA0PR12MB7003.namprd12.prod.outlook.com
 (2603:10b6:806:2c0::10)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR12MB7003:EE_|DM6PR12MB4419:EE_
X-MS-Office365-Filtering-Correlation-Id: 8b357c04-1030-4309-e2b9-08de5ca74a84
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VEdrOFU5bjNZN3picnE1L1NLa0ZRVXJMWitOM3VNelpGTHBDeWltVTcveC9R?=
 =?utf-8?B?bUZkbTh0TkphYWxSOEE1dW9Nbk9WTy9NMHZOa2xUUnpYV29VQU9rWDRGZlFo?=
 =?utf-8?B?YmRaMFZLanNZWjJPcTIzV0tra3VJSkVNT0wvWENiclJXdE1uUkpPcnNVc2xp?=
 =?utf-8?B?MHlkTE5pQnU4ZkRYdWxnS3NTbTllOElsVUR6NzF2SGIzVHVtaCswWllodDFP?=
 =?utf-8?B?c2llcGFaSVJMN3NLdWVtbFZrdGd0Mks5bWpHTVlzN0VCSXY3WWxDbWVVeTJI?=
 =?utf-8?B?a2FKaVRMWkp3RzlvcGVKYkhXbW5UaUNGTVNEWjVtSy83L0w2ZXNvcFdNNnZ0?=
 =?utf-8?B?bTY5QnlTSnlpc2FUSTNpNzFlbEx4b0M0czkrMkI3Znl5bHdrMEhMOUVKQUZS?=
 =?utf-8?B?aXFhb0NvQ0FnRU94ZUI3ZXJ3SjFmOGFrdVVTL2xoelFzRWZOdXVIb1Q0WVV6?=
 =?utf-8?B?d05HTkMvT0huVTF5c3BCcGU0QnVKaWYrZWUyZjhFK2JpUlhMbld2OXFTU2ZG?=
 =?utf-8?B?c2VzVmpoeTc1cmhPY2cxOWdTdUxMVUJJNjhQbXFrT2dzUDE0SE8zUzJINXhm?=
 =?utf-8?B?elN4SkJPYks0akZZSWFyOTg3RU5hKzYyWVB5ajRsdGQvK2pRWFZPZU9sdWdO?=
 =?utf-8?B?bEphOXFPeEFOU1lnSjBRMSsxVkQrNW1GZHgyRDRERVNYelprMjM3L3kzMUtD?=
 =?utf-8?B?TTZRcC9HTUs2a0pCN0F4aVNoL0pDNjM4TGlaUVJkcUZqcmxnUGt1czJwZTJr?=
 =?utf-8?B?TFJ3NENQRVU4ZnRacnlDZk9OSlVaTWRGWXJjYXJZNWU3bFkwRzM2UUN5dC9w?=
 =?utf-8?B?RGZ6dTdWaG5xNzYyaER6N1RsZkRwS0dGWE4wOTJHZGZXLzdDZ1NNZG9tc05t?=
 =?utf-8?B?M1VKbzFCNS9lVGxkNUh1U2JXOCtLd1ZBdWlVMWxCR2ZlVXVORDIvVE5hR0Uy?=
 =?utf-8?B?dHBOM09OUVZMcTdmb0YvdHFaMlR2aHJkTDdESncxMWQxSXFsNGpmcXlyUFFR?=
 =?utf-8?B?emdvdkRhUk1LNGExZTRxbXJ1KzNjUnhEelpDY0lZK3dMU1BpdC9PVkRuUVBj?=
 =?utf-8?B?U3RYblk1ZktmU0NQZEorYllrNUtaY3RGdUFLVzFBUW42cXFZOEdJMVNZTjY3?=
 =?utf-8?B?Ly93UENTMlZSRnJ4QXZoVXE2dG42ZEpxZVVqc3AxVEJZTGc3MUpHa0tFQk1w?=
 =?utf-8?B?YnZTTFBjSk56K1N2M0dqMXpKNERlSkQ4RTVOaTEwbWFUQnBYRTlLN0ZhZ1N0?=
 =?utf-8?B?REhyU29iTURvbGRjZnVIeU1FNmdXdnU5UWZseHVBTmlDbVlSUy9SajUrQ3lw?=
 =?utf-8?B?NGpKU1JnY0xQazg5aE5XR1pwZFhjVGIyN012YnVueUFBS3VBRFEyZDBmU0pV?=
 =?utf-8?B?Y3R4b1NYamFqcHBPdTExVHc5T2dhNU1QSW54OGxMOSs5c2d4M0NOVVc1N2tD?=
 =?utf-8?B?YSt4VVFqK1FNanNNZjFDRUR3aWpWQWtlRCtkbkhyOCt3THBqSEhPS01uVE90?=
 =?utf-8?B?V3k2cVpKRitudktzTHNPK3d1OUx0bkQ2WG4rcmZQYjZnRXdaUDNCOE5uK0Fo?=
 =?utf-8?B?QURsNGNHVFhER09tdlEreml6bm03dEZ4anI1WFlBZ0QwNXFMLzJqa0tXOFFa?=
 =?utf-8?B?cXZCN0JXUGlnaVRaamw5L1pRbCsxZG83bUJKQWFzdG1wY2xlQlhJd29CMjlk?=
 =?utf-8?B?eGpOYlhJaE1vNkJMZnQ2VkVwdnZJeHhabEJwYytkcWxRRytxUHlXbDVTQ0ZS?=
 =?utf-8?B?bVJiS1lYVzczdmhZMUwwMlZZTEVYNjFaU2ZpdW04Nkh6STlzUnFJMC9LZk9t?=
 =?utf-8?B?L0dZKzlSU0NaSG5Ba2ptL1JWUWxIeHEwM1NKYmZpQ1FIem5iZFZrRXpNdjNz?=
 =?utf-8?B?NHMvMkk3YVBqa0Z5VzllZEpldzRzdjYyaDRrVXkwSFBGWGFPbkZhSnZCdWh5?=
 =?utf-8?B?UFRuajRKL0dYU1Z5NnVWMXNtSnJhQXdhY1RUZ3FiSldCMk9xcTdSdXBtcjJX?=
 =?utf-8?B?WndDZFJFeWxTbGtIWlR5MlZSdEI4cStvK2dCcFl5QTNBOVBiMDN5TEtib0Z2?=
 =?utf-8?B?RFNVK2ZSYjRiUFcvbjc3Rjd1SzE4Q1hVSTFhcG5uS091ZW5GUFlsRUUxVFlt?=
 =?utf-8?Q?NVUc=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR12MB7003.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RFUxbzJrV0F0eXdSRWZtRDVDY3hVV0dDMFpNTC9nWGh1SlloR1l1clJreXRZ?=
 =?utf-8?B?bjZsQjVCSkVBZ2JqcHRQWFRlbmVralFKcW5zZUFudmwyZDM2ci9LMzlIbFU2?=
 =?utf-8?B?bElkQkFnc1dyRytaVjhsUlZFZCs3NTVMUHdkMmQ5aTR4UkI4N3h3Sm92bDF2?=
 =?utf-8?B?bEZaNGc1K0pIY2ZZT2paSFZySzJBd2JLQ0oyZkszd3k5aWh0aXlpOVVMZjdE?=
 =?utf-8?B?NGtKalQ3cmlEMEZiVlBOdmNhYXFKb1J3S2Y0RnVmWXBrV0tYdDhja0hTMmtC?=
 =?utf-8?B?K1lHSmZyY2QwMHRwQ0ZDV1YzNjVzRnFCMCtCTGw3QmJCWmhTOHBtclhQMHRY?=
 =?utf-8?B?S2pCZEFJZmYrdzlTbXZzVDhYeEZUK2JtQW40UXBYbFdvWTlvbUoralFMV0pF?=
 =?utf-8?B?KzY5d2tIVDNRUS8zcmljUER2azBxOE1qTTUxSUNHcjE0d1dGYkNoeXdpY0hB?=
 =?utf-8?B?REM5eUYyWFNuSk9jVEV0VkJ2M1J2Q1J0Zy9oWkV0V1VkR1Y3eEZaaXVPQjVX?=
 =?utf-8?B?TlFxZ1VYZ1p2eUJoK0F5bjZ0T1E4Qy9sUHQrMmVOSmRYa1NWZ1JoaUo5MjhG?=
 =?utf-8?B?UG13RlRQTVdEQmxHcjR2SzRKODBRVUNSUU8xWHRnTXd2NlNvbm8xcUhZMVpw?=
 =?utf-8?B?aXpld1g2cEUzUWd3TzJmZEtkeS9VTlhrS1hKSHVsSG9Fbmh2ZUhOT3dxMG9L?=
 =?utf-8?B?K216THBjY1Y1dldIUzJPOWkwR1hnbU95QXhqaUE2SGhMeDRoU1paT0puY0E4?=
 =?utf-8?B?d0hkK1BwNzZwZHp3aUlSK3ZSQ0k5YWh6MEtpSXY2anBrQjJMcURwbGhWa3JB?=
 =?utf-8?B?ZnFVc1A3aFpWaTZlZ0pJVEtCb2Q2ZlZQZUtpaVdOWmZUaGRxWU4vRXl4QU5M?=
 =?utf-8?B?d2lYcERTLzlneFB3MS9qb1poaHNrekZSQ09LSkpJeGJqTTVtL2tmdlNrcEt5?=
 =?utf-8?B?VUhLN3J0bzRqVHMvbmthcHh1a3ZEYnJIcks0MmFMS2ZuOERwWDVzSDNxbjZo?=
 =?utf-8?B?UlNaWm1YTmhSOGxBR3RQZ0NzUVVjVkFPSmI0V2NMV00vZG1aVUdTS0p2bURB?=
 =?utf-8?B?b3hkamxyc2ZCN3Y3bTdDQnpQUk85U3ZaVnpJajFRMUNPd3dMTEs5M0dNenMz?=
 =?utf-8?B?cDI4UnpuTWFzZ3g2Q2VDZUh0QU0vaTgxS0tCK2VTaDhQWXp4VDZZV1NTU2Rx?=
 =?utf-8?B?VE1obHhzSXl3UGZRZW9GTlhoYitWM3ZkNEU1akxzUWllblBNMnhBbHd2K21o?=
 =?utf-8?B?WGZjY1RzT2NyeE03Z1B1NDk0MW5rWWFZZUVPdWIvTEt0dFJSSFNlaTNTLy9P?=
 =?utf-8?B?ZjBVcmhITU51QmRqL0tDOUh2Vmh5TDRoWmlsUjNVVFJqUXhIOVd2R2E0NzdD?=
 =?utf-8?B?b1RYMStCdkdyRUZoMFhpaEw1UHNqY2tYckU3aHB3TTBmcUFHdmNOL3ZYOVI4?=
 =?utf-8?B?TUYrUWcwUEhrendITStpbzNzaXhzRXpScWVna1FKWnB6cjVVNmtWMXpTa0NQ?=
 =?utf-8?B?QzRHaldoTkpKcU90bGxyeHI3SThLNmxaeCtpdDFmQUd4cjVsYUJMdjMvY0ZT?=
 =?utf-8?B?bVVrSUwvV3NVdUdkTTY2WUpJQ2R1NDdWMXdpWUpyaGE4a3NXcDNWb3EwZlNn?=
 =?utf-8?B?N1hka2RUNk55NTFJRmJxUlFxOHduSElpbVlNc253VlZiKzRpYTlWc0tPMmIy?=
 =?utf-8?B?K1pOUXZNcXFqdi8zM2Y1cFFQL0REVkNwK09kd1cwQVowbnl3cnBMUmkyZTlL?=
 =?utf-8?B?eUQxZkpXZlV4VFNCdWxxbjFXNFlMR1h2MHNtR3NEd2xrYTRFTDE4K0N1dGQz?=
 =?utf-8?B?aGRVaTBKYTZBUXl1cDQ5SXJCZTRZcHRhb1JXVDBsalRlRXpoRmNBUWRvRDRF?=
 =?utf-8?B?VllPbm1JeElaM2NHc1NQdGZWMGllQzNDcG9BOEs0YzhYM2J0VExNQXQycUFr?=
 =?utf-8?B?eFlNZTZjc0VaQTBsUlMzMGsvNFJKbVQyUFlFbWh2SE5wazVrd0dpKzhhYUpG?=
 =?utf-8?B?VVEvSWJ3bVlwK0NRaEppREE3czZJM1pJKythU2tmdkxXcUZPZXo1a1NHU3Fm?=
 =?utf-8?B?TUk2Yzd0bVBGQmxsMWVaYlU3bWFLR2tDVUs5ZTEvNU5DNGpIam0veTAvamZG?=
 =?utf-8?B?NDZqSSswMzF2bUtaRGZBdHNIYWQ3eVJ2T042N3llRG5wQ0xTV2hXRllCR1Y0?=
 =?utf-8?B?Q0ZsZ0ZnQkppazErYXVIcE0rT0hQbitFRjhwTGo3clZ0L2xGbmZoa2xVQ2tn?=
 =?utf-8?B?SWNqY1ZtdXF0R3hFME5oR0dHeHgwQ212Zk5aWDgrL2J0eHJXVm5hb2wzdjRj?=
 =?utf-8?Q?CDXQqmvmW+OWMjKP7o?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b357c04-1030-4309-e2b9-08de5ca74a84
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB7003.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2026 06:51:11.5409
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GXHAMGHb+X6wPMtp63mFQc11CHNWW5FWBE4hfzusRhl9WBUWaSUk9Qg2xd8cWY3C
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4419
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[21];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-253341-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[pengutronix.de,gmail.com,vger.kernel.org,fb.com,oracle.com,lunn.ch,davemloft.net,google.com,kernel.org,nvidia.com,intel.com,meta.com,bootlin.com,trager.us,redhat.com,linux.dev];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gal@nvidia.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E943D84A01
X-Rspamd-Action: no action

On 26/01/2026 0:30, Jakub Kicinski wrote:
> On Sun, 25 Jan 2026 11:59:07 +0200 Gal Pressman wrote:
>> On 23/01/2026 20:40, Jakub Kicinski wrote:
>>>> - The auto-recovery (service task) enforces a fixed policy. Can we make
>>>>   this configurable? I used devlink health (.recover) to let userspace
>>>>   decide between auto-reset or manual intervention.  
>>>
>>> There is already a tunable for this exact feature but for PFC:
>>> ETHTOOL_PFC_PREVENTION_TOUT. Should be trivial to add the same thing for
>>> non-PFC pause. But we didn't want to open the uAPI can of warms unless
>>> there's a clear ask and consensus. We don't need tuning (or so we
>>> think), and there was some talk about not adding uAPI for fbnic because
>>> it's a "private device".  
>>
>> I had to refresh my memory on this, but I think we've chosen a non-ideal
>> name back then.
>> We use this value for both PFC and global pause, I recommend you do the
>> same (perhaps with better documentation?).
> 
> Excellent, I was wondering if that may indeed be the case. Thanks for
> doing the digging. Let's respin, use that knob and document it better
> as you suggest.

FWIW, I see bnxt also supports this tunable.

> 
>> mlx5 exposes tx_pause_storm_warning_events/tx_pause_storm_error_events
>> through 'ethtool -S', we can probably assign one of them into
>> tx-pause-storm-events.
> 
> Do you prefer to take care of that or should Mohsin do it? According to
> https://enterprise-support.nvidia.com/s/article/understanding-mlx5-ethtool-counters
> sounds like the "error" counter is the one that matches.

Yes, tx_pause_storm_error_events should be used.
I don't have a preference on who adds it.

