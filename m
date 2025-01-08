Return-Path: <netdev+bounces-156169-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0214EA05374
	for <lists+netdev@lfdr.de>; Wed,  8 Jan 2025 07:56:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EE4BF7A20F3
	for <lists+netdev@lfdr.de>; Wed,  8 Jan 2025 06:56:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 201A31A840E;
	Wed,  8 Jan 2025 06:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="iGukd4la"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2046.outbound.protection.outlook.com [40.107.223.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E31871A83F9;
	Wed,  8 Jan 2025 06:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736319372; cv=fail; b=GzKp8EkR9WmVqlKvlAksd3bP8anvScz03EOv5Mza2vJSkx2u7uR5UW9mFfe9c1PW6KR2f8iunn3Xr5gMSaIUxc2h3Jq08E3uOpOlH3YUqpP7iuskqz6TepfNszzXpUx6TG07RUTP0v3IfYojxx4dvd198sGTCt4z8/33EPBqfHw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736319372; c=relaxed/simple;
	bh=W9k/LIxa7sPevCJvEYeBwen+N4HNXDsrE5YK9QL8zwA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=uBpbGue0FMnXYttA6hOFcofyhjXXeeafjRU8+9pyjU3JTw3cTMPpAtxIfkeZ/q3p5R53Uy82R34NenrV3Q5pafsezY4nOsOELOo2jBuZEQoKWnerFPW8f68umbOUP4WZz0TRg3oUS23O6UhVmP23Irj+9HswcaKDupU/kjZ6Eq8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=iGukd4la; arc=fail smtp.client-ip=40.107.223.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RBod1M0Yiq/aeWjdcF6hTQ9+bKcyceW0ElfxZgUUp41W+U92f8/gx6762kJRKK+j3ALkXlt9EzvhoxRbmNzTXjtKBwzfCiVlHcsCsBxG5lPeydjAZ5za3Pv/x3fRIqFg3HWCTf2KeqKn4mVXwzcFSB0nGcyjV/otEf2FsePRDz1JBU4u4MSr6aoYVPefI6eYgbmkTzf4cFmexx1yS2pD2qmHgECBdqxWj1O/Q214Y9sYm8oXg+ybm7bviDJvSf7eD/iaYTqBt/zBSFH2Ivo/DKDJD2zZTyibuJRDlxgBAq+QE/JXBbspjU9zTHb2fEclMwh8WGFRbKi+TEtVptGoow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SfZTsha3XrFqwUjlRCj45xiantYhgni9YI6C6oEqV1c=;
 b=RHQQZttZ4sspzvmR5RhtSW1tG/GY7k6vStW4nCDqrMXacqKp34DKRxFz0kX4YCz0MSuoJm/Tzojkuy3uDtbQ+A+f+OILIClNRY3uhO1Z5JxVIgsK6UVQK9zWy/gyIMgHRPLgbFNXr53JZhLSa4sEBCLImcesOSOkkT65gIrrE/18y5gC8ljUwTCsTy5uXj6wxfLHZy/oRdeRH+bcatmyEWZJcPolSkg8P9TPZuJmHNYKx0nyUebmeL0q9gTgatXXgl9r/8k812UWnRp/6BvnIyW/Sv7ZwTl8MfG6meuZyPFdO7163mC7SHQ7O0x6NeSXzPT9+rYLOo8/d7Dk13V7pg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SfZTsha3XrFqwUjlRCj45xiantYhgni9YI6C6oEqV1c=;
 b=iGukd4lalRSzAbwTr5KzyDoW3z8qJLyEzLIN2zO9w+OUlKMJYQTlO3C+hYzuR4KA3yk9Ar41IjGrQcTX859kDif3nuxVH49J4PHKB4tFSr9AKwo1dvPVZZZ2bf9ve8jUzDHv7SdUgJGXBtwwSZ5YlJsp4zhsPxCXxCsiIOPUtJ1o4oMs2FuzpP7IMNkVIVaHaaPpOWa6Cb1bInMXH4EsRfiBWlhKod4sgrbn9UScQu8SprOW2HWSRuRweI/TO7RgGzaWKT+sJCT8a8RNIzVTBfiGXNlhvvFKJJURvGShuSf4qiXwDrS75SdrCkUJpFYTdmGrt7xwl3AlINSMe+scEw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB7500.namprd12.prod.outlook.com (2603:10b6:610:148::17)
 by DM4PR12MB8499.namprd12.prod.outlook.com (2603:10b6:8:181::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.11; Wed, 8 Jan
 2025 06:56:07 +0000
Received: from CH3PR12MB7500.namprd12.prod.outlook.com
 ([fe80::7470:5626:d269:2bf2]) by CH3PR12MB7500.namprd12.prod.outlook.com
 ([fe80::7470:5626:d269:2bf2%4]) with mapi id 15.20.8335.010; Wed, 8 Jan 2025
 06:56:06 +0000
Message-ID: <7dae76b8-4b79-40dd-9aa5-050c44e060f0@nvidia.com>
Date: Wed, 8 Jan 2025 08:56:00 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] net: Silence false field-spanning write warning
 in ip_tunnel_info_opts_set() memcpy
To: Kees Cook <kees@kernel.org>, "David S. Miller" <davem@davemloft.net>,
 Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, David Ahern <dsahern@kernel.org>,
 Simon Horman <horms@kernel.org>, linux-hardening@vger.kernel.org,
 Cosmin Ratiu <cratiu@nvidia.com>
References: <20250107165509.3008505-1-gal@nvidia.com>
 <53D1D353-B8F6-4ADC-8F29-8C48A7C9C6F1@kernel.org>
From: Gal Pressman <gal@nvidia.com>
Content-Language: en-US
In-Reply-To: <53D1D353-B8F6-4ADC-8F29-8C48A7C9C6F1@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P265CA0323.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:390::11) To CH3PR12MB7500.namprd12.prod.outlook.com
 (2603:10b6:610:148::17)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB7500:EE_|DM4PR12MB8499:EE_
X-MS-Office365-Filtering-Correlation-Id: c0060b22-d75a-41fb-bd5a-08dd2fb18605
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UytVOHJoNmhReGVvVFU5VWpyU2hTSi9MdTJlQTQ1UmRXWU1xZzIrS0ZWSGsx?=
 =?utf-8?B?YWRoNVZyeE5oSkZwdDRlVTkvbnRacW1mYXV1RlpFVURpVlpUY1dOSm9ZSGNL?=
 =?utf-8?B?QVdyL01oNXY3Q2R3cmZLSlRSM3UvQzhlRG4vekZqRXM1U3FPamtsRGw3dGpo?=
 =?utf-8?B?cEZjQUFYZU02VGc1S3FDNVJLTUdaN1M0cTg5UDNId1JMc3pjVDVLc3FCYURG?=
 =?utf-8?B?SFlOMDJUeVh0b1ZWSlIwVWlweVhzSUJ3c1Bja0hYcE5wd3ZJRk4wWXZJbGhM?=
 =?utf-8?B?RlhoUVlmMFdZM3BZdHYveTJXRzVwbkhxVFBRbUF5RDg2aVVGUDV0bTluSFFM?=
 =?utf-8?B?dXRadkJHZWN3RkE3QWhsNWh5UkR5Y1lNOWNWQitxKzRwcmFiejZ0QTM0UkIz?=
 =?utf-8?B?Wm5sTFRGUURtY2swd2lrWUlGc215WmdaN1NjaHdYWUhoZGlDVGJONTY2K3BS?=
 =?utf-8?B?OWJyT3BEMjZ0S01DNmVxTWRINXZZVzVwak04UVFxcjJrWjJRTUhQdVF6RmlP?=
 =?utf-8?B?UlpIb0o1eHdacUJoQlhoNm5hZmo0MzVHaVJmSGdQWlNqazFxem02MWs4K2Ru?=
 =?utf-8?B?RkVVcWE4d1MyK1ZzekJsOC8yaWQxRWdTa29IcktzSnNGdFJESjZlTllIM1pY?=
 =?utf-8?B?K2hDb1Z5VWVNYlNVYXRvNndPRzJCVjRyNC9oN091OTlzd2xnSGtzaVdvNXFm?=
 =?utf-8?B?c1lpWU15QVRaY1FnaHJSK1JlY2hFWlZodFRRTDgwRE5abjR4dkpSSjROQ2E3?=
 =?utf-8?B?K0huWG0xOEpkdnZyYk4ycmYzbXlRRDNGV2Ftc0RBR3VoZDlSVG90U1NGYTZw?=
 =?utf-8?B?VzMyZFVIRHplejNKMTE5Y3p2ejJvN3dqSjJTVm5pWDNkYVhrdFFrVG1US1dW?=
 =?utf-8?B?aWttcUJFdW5MeFM1VnhhaHQ4WVJmZGpUUEQ5OUx3dURZQW9RbkZOTzVyY2VD?=
 =?utf-8?B?cnBrb2s5RWF1TEtMNTQ4NDJqamE2MXVkUHk3N25HbkN3d3pCQ0V3V2pGVDEy?=
 =?utf-8?B?eWVob2xTaWVTY3FZZmFPSTk4VzNvb09zb2JjNVFYQ1ZNdHc3STdTRlN6OGpF?=
 =?utf-8?B?R29ZcFlQL2cyRVRjeEFrV0Vscy9vWnp0L2tLTmJwM3poMmJ5b0h6dWx6OGMz?=
 =?utf-8?B?dmtqMW1hdUQyZnZOcVNjemZqMW1KaWc0MzllbmdUVTROTk9JNHQ1R3BKQjNB?=
 =?utf-8?B?cW5tWmJWc0dCSUdRUG5KSFdPTHNjU09yc3NKYkJZWXZEUXB2bEt4VUV2elJZ?=
 =?utf-8?B?MUtwelBYazk4TjZ1bXUvOEsrbW1VM285djJVc2lhRTVKYngxWC9SUURUQVZ4?=
 =?utf-8?B?ZkJuQ29BSnhRbXhtcUQ3b0tFbDNZVTlSZGMxRWFUTm5wQkx0ZmNLUXRJUW1V?=
 =?utf-8?B?SGF0M1g2SzhLb2h3RUphSzlIamkrZ1pka1dvRWNiYVRYYXRDUzExYURvWlEx?=
 =?utf-8?B?TWJGczhVZ0R5S1dUTFpWOVc2MmZJOUZleDZwZDZNak5NbmhsN0Z3Y0prak9r?=
 =?utf-8?B?N1I4TE1YNXA3K09vcGNEZlp0MFZZUlFTM0dTTmRiNXFwcTFKY1RDb2RFbWlM?=
 =?utf-8?B?eEVTZmpPeW54dlVYZ3RueG1iejhMNHBoRlRxZ2t1aE1DVm90Z3B5SWJFNlR1?=
 =?utf-8?B?OU1vcXNESHpMQ1pNNnJOTU4yRGp2bGJiVlQ1c3RiR0FjSmM4TWt2c1N3dThm?=
 =?utf-8?B?MlEyWVpLODhsTTV3SkNxT3dEQXJJbU81M0lIaEo2YXM4RDVMaktZOE5HUWpy?=
 =?utf-8?B?M0RkVEV0YnJvZ2pwT29mU2NOblBaandrUXg1SVM0TXlKTWh4ekQrS0x2ZXRU?=
 =?utf-8?B?YzZrOW96MEtxTmQyS0MwTWZRSDgvYWZwN09ydEorRnU1VFkxOVdZeUVMeG9K?=
 =?utf-8?Q?qF5JCrKowlom6?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB7500.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cklJQTJpbzVsV2tLa1F5WDlYVjFCUVFrcFhST0NVTGcwaUtXU0NaMzV3NlVn?=
 =?utf-8?B?blZVNERGdUpIWmF1QXRNcWVOMllDLy9IckZMUDVVczJPZWhuMzB3M0tjM09o?=
 =?utf-8?B?elpoa3R1dDhYZWh3LzlMcHJUelFka1ZVOFdrQzZ5a2F6QUwrRkkyRjFjVEFx?=
 =?utf-8?B?eFZSRU5tek5kV00remJsYlFrbXd1UnBXSFQ1UlJVeHFuYnp5SkdwRFhNN0NE?=
 =?utf-8?B?ZHRiSGoxOUZxQVRLYTBTbzU5eVp5OVI3MGdPOFBwU0hxMU5BTDRJcmpBSFZI?=
 =?utf-8?B?S3ptN2VhMjlFZXNMWERWb0ZybGNzRTdUSGJrUkJCN2RzNmFhVUN2YmdoWEZX?=
 =?utf-8?B?bTBaVHBIWTRFUmZCSDZsa0xFcWNBcjdad2tYK3owMEhsUE5QYTRBZGswLzJj?=
 =?utf-8?B?V3RjS2xwblJkSjdOSkc5WXMxN3EzYytVZVdzMklxZFNIYWJlSk5YWWplRU1y?=
 =?utf-8?B?YzVUREI3cG1jdkhrWVVFaitsVDdUU05oTlk2alJFbWtkWmYyTDFycFpWR05I?=
 =?utf-8?B?Ym9mTVVHaDc3Q3FZeHVScWwycnk3eFNvaXQwY0FPdWNxanc2ZmR3bVBZWlNX?=
 =?utf-8?B?L0lwMnpiejZnZVZubDJKbzBhc0V1cU1yTmF2dHgwdnFMRUk2ckJ5WEJuNDZ3?=
 =?utf-8?B?YVdkckxyZXlxRWRUVXNhRXhnaE1yUTNEaWhwd1JEYVFZaUF6OVFHQzZIS29H?=
 =?utf-8?B?bGZwai9ObU9kTWFyNEZCNU10NnNmbTJxMnhkY0VHRnBNbjFVSW9kVTEybFpL?=
 =?utf-8?B?Nk0zVWtadVZyMERRaUZWemRyNVNjcXlsUnZNQ1NTS3lLSDhTVVp0U3VmdG55?=
 =?utf-8?B?YXMrRGlKSEs3bHBBQm5RZkdnY0xLbDEwSDRQNVZwbVA2dUNrSFdUWm5lWXJn?=
 =?utf-8?B?K21WUU5USTJZdzhtSk5acTVmZGlEeEN0U2lhbkJWUkttYm1CSmsxYVdrd0U2?=
 =?utf-8?B?NXVxaDQ5S25qc3l3bG9neVlrUThVcG9qeVA3VU1GRWxmWDZYVi9LYjMrekZ2?=
 =?utf-8?B?MkhMTnVXTFFGQUFLYU9pSFJwNnJVeSt2NjhSSW55QjZRaGRaOWlONmc3dEV0?=
 =?utf-8?B?bytQQXR1Z2twSmlWUWh6V0g1d0tmeHRLcWk5R1ppQTRkZnhqNUZoYzA4RjFU?=
 =?utf-8?B?aVdYSCtyY0RUVk1yUUlYVkE3ZlBIQm9SUHZXckVtL0t6SFY1T3BIRUxWaXdU?=
 =?utf-8?B?OFN2VXFaeHQrSkRRMmNPdk9ZR3FodzlmL3RUMXBtRkcrckNtUHhJTm0zNEsz?=
 =?utf-8?B?VStxVjduK201aHk0dlpOUnpuR0pPZXNLdk5acitKZXBTZVVHZHgxOUNXS3o2?=
 =?utf-8?B?Y3NCNHI1WGJTSC9EU0dtZ2dxVVlRbzd3ZWdvdkhSK21qT0tmSDhyNSswSTds?=
 =?utf-8?B?M2ErOUg1OFFRRkZsRTFKRnlQd1VjcmFxNml3T2xxa0U3clRHSW5FaCtMV21Q?=
 =?utf-8?B?VHR1akQ4MVZseERZMVN0VU9TOWNVWDU4WlQ3Qno5QmJLb0M1eWZjNmRjQTEy?=
 =?utf-8?B?RWloc0NOYk54SXg3NExNdS8ramdIT2JTS1d2MHBGUzQ4amxNWXZHM1gxL0dR?=
 =?utf-8?B?aDFMZ1FMSFNISW1OOEdmdzBzZVorelJFZUEyT1lvSTRQeW04NC9DYXhnY3cw?=
 =?utf-8?B?Qkh3cWFzYytScEk1UWlOVXBIbngrWjVyUlpOMHFvQ0hnNHRadFVRc3FIeUtx?=
 =?utf-8?B?V1RwLy9Gemdnc1d0V2REUjlqbkFwc1prb3Y2NzZrNGp6NEtPY05sTU9jRWJN?=
 =?utf-8?B?ZTdBZS9hUVV3Njk0NWhKOWtWSUpYTWtaTEFpK1ZvRjRaZ2Z4dGdKWFpUN2hV?=
 =?utf-8?B?WDVQMHgwTnErbkFoaEJpL3lxSEZ0YnJ4NHRmaU9YNi9WTGgyVUl4V1RBbjRr?=
 =?utf-8?B?Qk5DTmlMQzdtNUJJTjlFY3d0cVZyV0MxNHJwV200T1QzdHNlSTdlL2x0UURs?=
 =?utf-8?B?OXJEa0hjNVEzNGtiR2FvZlZFYS8rd05USGxxeUdVSVVmUEFMQ1dyc3dyYnoz?=
 =?utf-8?B?ZUlLeHI0NUhkSGtsVFUrMllEeUQzOUdSZGdKVTJFS0svTWRySWFXYTRUUm9Z?=
 =?utf-8?B?SWN5aXh3d1k5L0IraHlXWXo5VVBJSXVObm8zM2I0T1NVaVFlQkY4RDl6RXBa?=
 =?utf-8?Q?elAhTqPw0IZ63a+vU8Tmk4z+l?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c0060b22-d75a-41fb-bd5a-08dd2fb18605
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7500.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2025 06:56:06.2757
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bEkqBer971KqqV58TfhLk3vL6YXn0mSMzHwZtda19yEGfrCBlsTPwFAmGuOBNcYT
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB8499

On 08/01/2025 1:28, Kees Cook wrote:
> 
> 
> On January 7, 2025 8:55:09 AM PST, Gal Pressman <gal@nvidia.com> wrote:
>> When metadata_dst struct is allocated (using metadata_dst_alloc()), it
>> reserves room for options at the end of the struct.
>>
>> Similar to [1], change the memcpy() to unsafe_memcpy() as it is
>> guaranteed that enough room (md_size bytes) was allocated and the
>> field-spanning write is intentional.
> 
> Why not just add an "options" flex array to struct ip_tunnel_info?
> 
> E.g.:
> 
> struct ip_tunnel_info {
> 	struct ip_tunnel_key	key;
> 	struct ip_tunnel_encap	encap;
> #ifdef CONFIG_DST_CACHE
> 	struct dst_cache	dst_cache;
> #endif
> 	u8			options_len;
> 	u8			mode;
>   u8   options[] __counted_by(options_len);
> };
> 
>>
>> This resolves the following warning:
>>  memcpy: detected field-spanning write (size 8) of single field "_Generic(info, const struct ip_tunnel_info * : ((const void *)((info) + 1)), struct ip_tunnel_info * : ((void *)((info) + 1)) )" at include/net/ip_tunnels.h:662 (size 0)
> 
> Then you can drop this macro and just use: info->options
> 
> Looks like you'd need to do it for all the types in struct metadata_dst, but at least you could stop hiding it from the compiler. :)
> 
> -Kees
> 
> 

Thanks for the review Kees, I'll take a look into that.

