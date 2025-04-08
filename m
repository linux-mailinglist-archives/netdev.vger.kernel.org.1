Return-Path: <netdev+bounces-180181-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 02EB7A7FEE0
	for <lists+netdev@lfdr.de>; Tue,  8 Apr 2025 13:17:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D569D44724B
	for <lists+netdev@lfdr.de>; Tue,  8 Apr 2025 11:10:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEFC7267B89;
	Tue,  8 Apr 2025 11:09:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="mRkISGTm"
X-Original-To: netdev@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2059.outbound.protection.outlook.com [40.107.102.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C53762135CD;
	Tue,  8 Apr 2025 11:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744110578; cv=fail; b=QgUwSOfBJapY7ZAyJNGDGULRhb+uu4qGDAqVEFmbjkyiJSfInJwXZjOgqq6tqqeNS4qmvYl/ld8JEUUK//vXiUv+OJj5oXyfQ9juod7sRcEcfdyDUNyIhrIu/Ugj/lX7BlE0QLt1AoMJMcSeKC6c59sVaHBsKhD1SF8IwFc6+U0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744110578; c=relaxed/simple;
	bh=m48J0IRbgWYB9P7l+4xDEMvnDJ1CvRGtYNxOEWQ4OgA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=FQEaT4EoiaGOFsUqZOmvXctGcKzMT0f3gij5AxMUmIxGqw0FknfP4x6WGujOgDWMMhsoI/Lap8KhNn9NRqEVWCW90UfaTSvUBeOmDKP6nbkTCoXFyzdJNrjRkhk1ZWb5lPQbkE/7pxilusC3qGUw1BEYiw8z69is2fdxMUoS230=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=mRkISGTm; arc=fail smtp.client-ip=40.107.102.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Vg+me8TTBD5eJyogS0FhmZ2ZubfiNJ7/KHpHraKQB5bO78z2ePf8iI+KNhZet70xr5EiVK0BgDCLSkei3Kek2q7avD+zhNtdpkqJ4HEop8vgUnK1Zvk2VqL5NZ/wi/CuqZiZ66T73v4y0YohrK3jxEqpsFyyor38ucg/UtznOqvoErd0G0h55gsxW7Qs1nnV2fbBL5OHzdzs1CC1wtxOIoRnEd6E9i3VrXBsDQS/6W75+HLN+9fDnQMOkDgZ6txUkmqaYfSI583QJVnI4ZqNdIaroijGPx2byF8ly45BcbVFXjJAVbsESy8tzLcOMsggKc7XvHqLopgcuufO0EFTzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4b1MV+iYknTNmInAyfM0Vs8epZfqrNPr9htMGJCtmlI=;
 b=wmmYAhf584WUWU3a1btINEeT6u+EfCh2M2U2PNEAOcSu6sKGwwWAMMA9a+EKfz5+z+gB7ssjQgzqlwR8eNx5UI0AhUuj+M/XnrdDw5sHxd0+TiK5PLIu/zcIkz2196eGePqMkqyR0FAnqUMnJd9tlZTXu4bVyp9hyaYPoNwcyxOQRkC3v0x2XQEpqQCefyL6kOSZxNjW8xP34dVE5JBwT+CbM2MWXyuulVF6Z0QIE6qM7V3dM61ZbwNzFgiGeGvaVVOHXEoEKZ5HukC5URWaaz3ztD8Ooj64KiQv8vIUlh3N83PtFrtWcPAtGoDZPq6RWptdqI50V8GTzdfVJUAYig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4b1MV+iYknTNmInAyfM0Vs8epZfqrNPr9htMGJCtmlI=;
 b=mRkISGTmrQtrDPnUorQtMd5A6yX0yz96tXg6U2N5coXuzpXSQnU/MCHvwUbyFhTinfWNSPhIFN5EFsUAXaku2yopDZvbItPMCmkoK7RitWWqdZqHzSSaO5+CWLHvfo/dYo8zGk6Pe85SogELdM98tRFuc3QFrIZJXZewyrXdBGk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB6395.namprd12.prod.outlook.com (2603:10b6:510:1fd::14)
 by PH7PR12MB6720.namprd12.prod.outlook.com (2603:10b6:510:1b3::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8583.45; Tue, 8 Apr
 2025 11:09:33 +0000
Received: from PH7PR12MB6395.namprd12.prod.outlook.com
 ([fe80::5a9e:cee7:496:6421]) by PH7PR12MB6395.namprd12.prod.outlook.com
 ([fe80::5a9e:cee7:496:6421%5]) with mapi id 15.20.8606.029; Tue, 8 Apr 2025
 11:09:33 +0000
Message-ID: <14d67256-13a1-4e51-996e-317bd5edf6bc@amd.com>
Date: Tue, 8 Apr 2025 16:39:24 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] amd-xgbe: Convert to SPDX identifier
To: Simon Horman <horms@kernel.org>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Shyam-sundar.S-k@amd.com
References: <20250407102913.3063691-1-Raju.Rangoju@amd.com>
 <20250407163051.GS395307@horms.kernel.org>
Content-Language: en-US
From: "Rangoju, Raju" <raju.rangoju@amd.com>
In-Reply-To: <20250407163051.GS395307@horms.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0133.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:6::18) To PH7PR12MB6395.namprd12.prod.outlook.com
 (2603:10b6:510:1fd::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB6395:EE_|PH7PR12MB6720:EE_
X-MS-Office365-Filtering-Correlation-Id: 7e980f44-3eac-4a7c-7e1c-08dd768dd722
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YUJ0WmZhcS91NnRVak13ejBxajAyc3VnaUt1QXhJY1ozaXlOLzdIRWx4VE9q?=
 =?utf-8?B?T1FJYUUzOC96d2VFWERUbWZoallqSlAxelU4cjF1bGlkK2ptWWs1SWFSSEtj?=
 =?utf-8?B?TGdYV3MyV3VEMzA1S1YrbTlFZmVQMjBpSGp3L1NRUTE1Y21oQ1ZWeVNybGFJ?=
 =?utf-8?B?dFhlOUJteDBxUG1KMXE3b0YxNCswU1plVC8raFh1YU1kWDVBTjBMTEZVeVhC?=
 =?utf-8?B?RjBKdmtZZk5ZbHRiZ0FySGVJeVBubVdDWnJMK0R3YjNaL3N2aVBaSmdmVEFD?=
 =?utf-8?B?a3ZwUlZUTmJSRXl2Q3ZqbEVVWDBkK0Q2Vlk3N0hRVzA2MlprYm9nZDBZWXNF?=
 =?utf-8?B?dCsxMVlKTUlwN3VMaHBoVVVMM2JsMzJoRDFFc3JjQ3ZEY1JZZzQ3V3F4SXdl?=
 =?utf-8?B?UHYvTEpWQ2I4b3ZVQ1FuM2cyNXlVV2c1aEtnOEZVd1M1Q0pIQnYwTkdFd3VM?=
 =?utf-8?B?T2tuR3BUK3p2M2tGM2JXL1FJbldIR1F3Zi9yUS9VMHNwYm5vT3lDRXVKaXFS?=
 =?utf-8?B?OWJaTkRmdmxBdFphNzc0UEkzbVVQVW11V0paajA0cjArejBHMVdMOEoyaWIx?=
 =?utf-8?B?SHNJMis0aFlmZm1jM0ZZV2tNQ1M2cWx4dm1CSHl2MlhsbUdFMzlBdkNocXZH?=
 =?utf-8?B?cTJoeFdlVjJoZ3lPZmR3V0ZpSWRnSFlJbmpKd29Jek9vZGNzdjFUekE0eXZl?=
 =?utf-8?B?UHlDSUZ0OGkrdFlUdmxiVnVia1ZpN09TaWNiemZHazNTSzhSZjJmYnUyNENL?=
 =?utf-8?B?MDZtL0RFTDJjaFBqVFpRa2JXcXpVK1ZQazd4aGxLNThuQ2M1OFBpWTdRYjUx?=
 =?utf-8?B?eFV5Q3R3SkJTU3ppMEZ0UFJWVW1FVVoxVlM5UHJEb2FDcU52TUtBNDdFbWF0?=
 =?utf-8?B?KzdTTkRqemg3RHB2OXdEaDdGcSs0OXcyZkxEUEtsMTlFck1tbXZEOVBGTUk5?=
 =?utf-8?B?Rlg5b1lYd0JRZEEwWUlIOUFhb08zYVh4OUpBWDdZV2plWWZ4eGlBNGdwdGc4?=
 =?utf-8?B?eXZRY1FzNDJwbnc4ME5sWVdjMVRwV04wZ2U3NXZmSEF6R0pEN3dMZmYwWGNQ?=
 =?utf-8?B?OVlYVEtYU2h4R0s4YkZXNjA1RDFYdnJQSVIxSXpmbUE4Ulk5elB3M2tYRjFU?=
 =?utf-8?B?Ylk5bmE4a20rMzgveStSWWRuRFVZcm03THZEU2JyK0NJbEFWaENxMlpMU3M0?=
 =?utf-8?B?TTJNYWF0cERCaVBuNzRtbHpSTjhHNVVJVmpiU0M2TXJ1b2NJR28xMkQ1RGdC?=
 =?utf-8?B?NlYrZHRiUm8zMDdxTUhNYWUvUVIzUDU1T09FWmdhcUNMUERGNmlmc2E1WGpB?=
 =?utf-8?B?VjRYRlRlczcwR0RUbm1zVkVNTmVoTVRuc3l0L05DbjlmMVdSZm41Tm5iL2dY?=
 =?utf-8?B?NlUrUGMxNVBpaVlqL0YrcXY1SEhzVjRmdjFxb2VrM1pZWlhrY2NhM3JnOWl1?=
 =?utf-8?B?a3BpWWlFcTdkWkxrVzB4bEFwOUJsT0pjdkp3cmlIbkdKdmFQRVZRZVVSeFJ2?=
 =?utf-8?B?TFdpaStCZ2I3ZFpqK1lNSjA1Yms0KzFZdFg2bi9CRzBJV21yQTdES01Ydk95?=
 =?utf-8?B?UWFXejJCakp6VlRBSytzc0twOWhpc25uUGEwRTB6R1BsK2VIVE9zelA5VmJO?=
 =?utf-8?B?OThadTBvdk5md1ZhK3ZFVEZJM3o5OS9vdmQ5NUZNRWRLTWNKM1oyT3k4b3hr?=
 =?utf-8?B?YlFWdTV3WG93dXJhOURLWHlFVzg2amlQWURyczlxM3p6ZnNrSmxieDlWWTQ2?=
 =?utf-8?B?bXFLZ3JEaHJVSnZSdWIrMko5bFUxbDFHaWxySXNremIrL2UzZHl0dEpDeEFL?=
 =?utf-8?B?YUFZUTdxeVNYbUNVUFRteHBPdTk0V2Z0NkdJeW9sZmx4cnd2dy9FNEpselNl?=
 =?utf-8?Q?gkU8BB6y43pem?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB6395.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OGNvRnBMcXFkL1QwWDFDZE1QSjdIYjk1Q3U2OENPblNQWklTeW1Xd0p0OCts?=
 =?utf-8?B?UERjdW9IVXhQZUh6RHBuWkhrRCtQSlpYK1ErMzVEVGFkaUg2QkdTeEc3Y01M?=
 =?utf-8?B?MHV4QUxQZEpIM2xLeCtxQ3NNRCtaRmdtVE1GYk9ZTWxvNlI5OEIxeis1Q2U5?=
 =?utf-8?B?UDVqV214N2xaZGYrb3IrTEFDWVdqNmJtL2w2Um5xQ1B3Qmd3UHUrNFd3ZmZD?=
 =?utf-8?B?T1RGRWN1ZU1zZEZjcXpEcThOODZuWFhNQ1haelBGeUtMUFdsMm1kaVhmSjk4?=
 =?utf-8?B?WWdtaG9zaTIzcG1HOFRwSjM1czdSeXVYNkptZVZabEw5SFhFMlJ4TlZqbWpi?=
 =?utf-8?B?OGlIMHVlUU0wVXEvT3Vhdlh2dm82czJRMXZCdlhrZGhYcTBBRFFXSUQzYS9x?=
 =?utf-8?B?aXQyaWJmVnpZWW1MckoxREZMd2NSZFlGZEZqOUtEUStXcjI1dWk5bnpkaDJE?=
 =?utf-8?B?THdsQytnOFpJS3B5REVSSm9QT2t2MXZUbWVlZXJDR1UxWDVCeFF5NndHSmF3?=
 =?utf-8?B?bC9iLzFoTXUyNUpvSlo0dmNhaml6VG1NZ0lPcFV4d2UwaTBWaERoM1k1d3lr?=
 =?utf-8?B?eWxMZFJheGdjMjlXMlhBVjhpOTZPaUM1TG1wRC9SNTJFVEJSVVJ4V3orUFNY?=
 =?utf-8?B?eGF4ajZjWWxpMWFiVmg5VkxsZUhBR0JVU3VxdmpuelFIVSt4WXQ5WFBlZVRB?=
 =?utf-8?B?T3JZbEl1OXlvbW5oc3J5Tm5oaTFNcWEwRXNiNDRJN25WWXQ5c2hMUVlzTUlS?=
 =?utf-8?B?NTdxV09BWGN5WUxhWGFyR2JoSFZ1dUJXQkdOemRMQUF0b2EyVkNGK1FkSlVG?=
 =?utf-8?B?WFR5VktLaDl3ODB6M3J1Y0RlVG95bk90dGpFUmpuYWpnTWRsMWJKR2VzbE1K?=
 =?utf-8?B?MnJGY3JKRkc2SHk1NzNVdFFpRU9uL1dPYzAwSUhQWCtSTTltMGFLTlJXc0pP?=
 =?utf-8?B?OXJQaElHSm9LMzVjaTFZbTMwSzlGeHp4YjZzQTZWTGMwMEdmeVFFVjRDV0lN?=
 =?utf-8?B?MW1zaHp4WWsrRDVCekVQcWxESHRtK3pPQTZ1bnlWZWFpSHhJZCtVQlZUVjlY?=
 =?utf-8?B?MWRHcytVYkhWU0pyOThYMFk1UVZ0eWNYMnhQemNQOGVScXJnZXpNNGxoT243?=
 =?utf-8?B?dkRWNHBCdURVYnBqdkl2WDhmS0trbFliSkNwWW1FZ2NFU3dROGx4TTUxUEVY?=
 =?utf-8?B?WXNaWGlHZG5IWXRIczNDclF3Nk1kYlhaOGxoQkt5NXZhUnA3L1lGZE1odHEz?=
 =?utf-8?B?bTNVR3VoSVlUSmIvYU02T3YwWnZrUjZ1TVRtR0RJZzFYNWRObUE3K1hYU2hl?=
 =?utf-8?B?aWx4aVg2YldZZE5KNHg0dTNNK2NvdVh1NXVsV3NLTGhkZWVFaWtON3ZUdS9w?=
 =?utf-8?B?ZjNGeTRHc3dxTjVCTWtWWVhQdDBlbGNIcVdDdkc2d00zdEpzcVlRMGJoMVUy?=
 =?utf-8?B?ZWxqR25uNlRLdEcrQlAvQ0UyRlpQZU14VHRvbFQrdEpFcnZBdEdmSnN6dk1m?=
 =?utf-8?B?OStXWTZoa3piV3NmeXJ2MTIyYmRNZy9XRlVpU0E3RS85c1RXcGtXb0FFdk4x?=
 =?utf-8?B?bWlMTjZRbmQ0NmNBd0ZxaCtuUmNHSW1JZ25hVS9XOTZJdFVDd1Nvd1FxbS9M?=
 =?utf-8?B?N01uMGpNbTF2RDhvanZPazArTDQxTEJBOEZIT2Q0SGl4MTYxWEQzQnd0emFE?=
 =?utf-8?B?UWZVdmppeVQ2Wk9UanhJTk9IeDU5SEYrTDhJS3hMZmswekFPV1FpK0EzMnNz?=
 =?utf-8?B?OXFOeTU2L0h4VS94UTFydCt1eVlUU0twVHk5SzFabmpTRlZVMTY1UkdZdms0?=
 =?utf-8?B?cmF1U3RpbHdaNm5jcHdSUng0QmhkbnlySVpDOVlCcmlzK2xEbUR4Tk0wM3ZZ?=
 =?utf-8?B?TDVFQzFBUW04M1hFVlJCNHd6S0g5b0V4V3A0T2pnNHkzTkF6VUtqbmp5cWtn?=
 =?utf-8?B?ZlpzTmFqWVdCckxEakxORGM0cStFS1IxWEtySlZhWEE2K0FvamlVWHNja3Br?=
 =?utf-8?B?WWNUOUZLaml2L1VXMDFZeENKVjBBeThjYTAwOWFMS1Q2a3JwNXczZHdhcmtK?=
 =?utf-8?B?NUZXRFAvenFMM1hBM2FhcTh2emloSUJwMW1Wc2NndUVPdTF0ZTl6Q3FaRkxJ?=
 =?utf-8?Q?N8y+sZUyNTXE7ZFl296y897RX?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e980f44-3eac-4a7c-7e1c-08dd768dd722
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB6395.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2025 11:09:32.9870
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kuTlV2GNANVaEi6R4ztK1Xtq/xt1sQQy0LCOT0aSJP2+0dHWImHE0vSg7TE9+61hnXEZ/FxGOHPsjDrGbykxNQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6720



On 4/7/2025 10:00 PM, Simon Horman wrote:
> On Mon, Apr 07, 2025 at 03:59:13PM +0530, Raju Rangoju wrote:
>> Use SPDX-License-Identifier accross all the files of the xgbe driver to
>> ensure compliance with Linux kernel standards, thus removing the
>> boiler-plate template license text.
>>
>> Signed-off-by: Raju Rangoju <Raju.Rangoju@amd.com>
>> Acked-by: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
> 
> I note that this patch changes both the licences and copyright information,
> and not just the representation of that information, for the files it
> updates. And that the patch is from and reviewed by people at AMD. So I
> assume those changes are intentional.
>

Yes, it was reviewed by people at AMD.

> Reviewed-by: Simon Horman <horms@kernel.org>
> 
>> ---
>>   drivers/net/ethernet/amd/xgbe/xgbe-common.h   | 117 +-----------------
>>   drivers/net/ethernet/amd/xgbe/xgbe-dcb.c      | 117 +-----------------
>>   drivers/net/ethernet/amd/xgbe/xgbe-debugfs.c  | 117 +-----------------
>>   drivers/net/ethernet/amd/xgbe/xgbe-desc.c     | 117 +-----------------
>>   drivers/net/ethernet/amd/xgbe/xgbe-dev.c      | 117 +-----------------
>>   drivers/net/ethernet/amd/xgbe/xgbe-drv.c      | 117 +-----------------
>>   drivers/net/ethernet/amd/xgbe/xgbe-ethtool.c  | 117 +-----------------
>>   drivers/net/ethernet/amd/xgbe/xgbe-i2c.c      | 117 +-----------------
>>   drivers/net/ethernet/amd/xgbe/xgbe-main.c     | 117 +-----------------
>>   drivers/net/ethernet/amd/xgbe/xgbe-mdio.c     | 117 +-----------------
>>   drivers/net/ethernet/amd/xgbe/xgbe-pci.c      | 117 +-----------------
>>   drivers/net/ethernet/amd/xgbe/xgbe-phy-v1.c   | 117 +-----------------
>>   drivers/net/ethernet/amd/xgbe/xgbe-phy-v2.c   | 117 +-----------------
>>   drivers/net/ethernet/amd/xgbe/xgbe-platform.c | 117 +-----------------
>>   drivers/net/ethernet/amd/xgbe/xgbe-ptp.c      | 117 +-----------------
>>   drivers/net/ethernet/amd/xgbe/xgbe.h          | 117 +-----------------
>>   16 files changed, 64 insertions(+), 1808 deletions(-)
> 
> ...


