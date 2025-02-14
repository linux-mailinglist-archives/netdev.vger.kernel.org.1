Return-Path: <netdev+bounces-166518-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 839CBA364F5
	for <lists+netdev@lfdr.de>; Fri, 14 Feb 2025 18:48:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6CF163B086D
	for <lists+netdev@lfdr.de>; Fri, 14 Feb 2025 17:47:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9099C267B80;
	Fri, 14 Feb 2025 17:47:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="pPp9J1Rc"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2058.outbound.protection.outlook.com [40.107.243.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E88B7265CDE
	for <netdev@vger.kernel.org>; Fri, 14 Feb 2025 17:47:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739555257; cv=fail; b=IOfq88sC+WhBSlgmgCyDwYZtrIBxeyHgjb/TmnlQ++ZuX9u2iuD2WY00cNcvu0Nv2du2UFff/WR2EA4WzsUcwoJAkGvqbR0ItcCL+S0IhKtyP0kbRB9ccNZ9HL9psF8QFRThJCxzPQBQQt2oxp222mfv/zf9UiCXoxtlNOf9V98=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739555257; c=relaxed/simple;
	bh=DuWO1+TigRxAwXgvgFt5rLsURPLsRoJsoARhdL5LaH0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=rd4ZydC3t2GImEMRkZGzPXpAjBfQAe58A+Zejv6nFnHUM8j2zie7DH0hXpa1sSABCAlRAd8S74fArfGnbAgS7MP9SQrHl0L9LlTe4SlJPhCm+4oG6IM4EM/8ih6xLmSeSE6g8jY3QZOsODelV9jb+mkfxae62K1QNpOgUP2IrCs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=pPp9J1Rc; arc=fail smtp.client-ip=40.107.243.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gg1ZTqUHhxd6NW7CT2HmGDyFVAeiQ1So6jicVFq62vFS0smZDL2k1pAHuwaLH9i/2h1LZxuQtuUgIigRP6q4vBk/t/tFFjXtHNJQ3L8zWb8T9EnoNSwZxR7uBGRL80gAZUX0Xus6FzbdY4SEnpsA3E2Ivfjy+w8Qibrgg14qxy8iJX4g78Wi55XZ2I2QN53xTW2iVCdVkHv/xam5VaIVf1I1OL0bTtXeEVFccKXGaXWX1F0vMZvS/OLowdn0eJxUo4T5NTC4yefhV0DesSo77G5cNDbc/wJgkExbPNS2uGBOX6Yh4fgGLPKz3M2ieQv9dQYNrUKCoqlzAmy50pH82w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f2tUb82WwZ57WzM4xaidW3RToV17ancJ4NMjTYtXf3M=;
 b=OgkNl841tOTmdsYPHvvqBiXQLa0Ru3znNKupfGbrUXrQQmoul5KkLY2/bSH6M5EsFwW2+LSxhVQaZbt5iaVdcRY6Uyc1vcgzrydmtZeOSzSE2Ffg/go5QdBxNe65yumPwjQqXKdlh0gw7yyBh5tY6jkWN83L4pgDoW7e1hFoqi9sOgLUIJERlwST3MHbkLFvtImjUpG+T7jBUdzhguCvNJZwRYlUngXlHD+t/EXJO6bEugT3OxecKATlROVtBjl2I++R8rXCwR+DWb430LkwYlSuRqahlKdAtyohZ7pI/gcDjbrO878cTYxYlFXayqov+HkWMXZjAYz+roSOMvskvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f2tUb82WwZ57WzM4xaidW3RToV17ancJ4NMjTYtXf3M=;
 b=pPp9J1Rc/08LCIAa8ru6OB9hFkSDg1YpUPeUB7QxbJjrsU60d/CM5YxNJqhnMcdAcHPxaUp4TeIZYAhsNNguJFEXBqW16ocam9nIEMNQTsI73E/VXmk/E5q8XO6Nlzh07D6VBLpSOVAd4XkKT76u/1WhTrsFkTrAwfl7lziWEEU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB6583.namprd12.prod.outlook.com (2603:10b6:8:d1::12) by
 MN6PR12MB8568.namprd12.prod.outlook.com (2603:10b6:208:471::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.16; Fri, 14 Feb
 2025 17:47:32 +0000
Received: from DS0PR12MB6583.namprd12.prod.outlook.com
 ([fe80::c8a9:4b0d:e1c7:aecb]) by DS0PR12MB6583.namprd12.prod.outlook.com
 ([fe80::c8a9:4b0d:e1c7:aecb%5]) with mapi id 15.20.8445.017; Fri, 14 Feb 2025
 17:47:32 +0000
Message-ID: <5dd2cfaa-4f3f-4bc2-ab20-6ec4a1887703@amd.com>
Date: Fri, 14 Feb 2025 09:47:30 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 6/7] sfc: add debugfs entries for filter table
 status
To: Edward Cree <ecree.xilinx@gmail.com>, edward.cree@amd.com,
 linux-net-drivers@amd.com, davem@davemloft.net, kuba@kernel.org,
 pabeni@redhat.com, edumazet@google.com
Cc: netdev@vger.kernel.org, habetsm.xilinx@gmail.com,
 Jonathan Cooper <jonathan.s.cooper@amd.com>
References: <cover.1702314694.git.ecree.xilinx@gmail.com>
 <fc28d967fbffd53f61a1d42332ee7bc64435df7c.1702314695.git.ecree.xilinx@gmail.com>
 <ed7a2ffa-bfc9-4276-8776-89cafa546ef8@amd.com>
 <235217f3-97fc-9925-cf9d-7ebbb77f0487@gmail.com>
Content-Language: en-US
From: "Nelson, Shannon" <shannon.nelson@amd.com>
In-Reply-To: <235217f3-97fc-9925-cf9d-7ebbb77f0487@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR13CA0134.namprd13.prod.outlook.com
 (2603:10b6:a03:2c6::19) To DS0PR12MB6583.namprd12.prod.outlook.com
 (2603:10b6:8:d1::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6583:EE_|MN6PR12MB8568:EE_
X-MS-Office365-Filtering-Correlation-Id: 4874463b-2020-4621-9910-08dd4d1fa848
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SWlmV0p5WldJNTFuallCS2VJeTBKdVpnMEZiaUtDRmFSdVRtMEIxaXdsUm5u?=
 =?utf-8?B?VytDTExHUDZSRTBXak04REs5NkhQdWdNZllUWGk5bXFDNWhTdTdhaVNsRDNF?=
 =?utf-8?B?WTZWdGJWdXRrMXc4bHl6REFsamJQZjUyc1hUTU5mdFBpZmV6OXl0d21PMmdJ?=
 =?utf-8?B?VlU2RG05UFdGcWpzaUd2WS80emlXa3V1aGg0UzlrZlk2VG9OMytodE5oSktX?=
 =?utf-8?B?UTEyeE11aDVTNnVuaSsxVk1WTUpaZjh0V1BNb2w3cG41Z0NoK0dpVVBxSW5Q?=
 =?utf-8?B?d09NVGRWVmJLMmhMSXNRckRKcmtpeXNJWnFKaCtRNHphcTN1dmtVK1NDeUdN?=
 =?utf-8?B?cGFvSVhCKzMvdjVVT2l3ZFhaM24rY0JHUzJqZmNTcEJycUU5Q3dYUVJQVjEy?=
 =?utf-8?B?VTJMY3JMTi9qaDJIT0NqT0JHcjRVaEFMSlJZR2FKOXhXSWUzYTh2TUlvZ2h2?=
 =?utf-8?B?RzFQcWR5T1VraGFBYzdsbU9CaXdwdHNCTm9OcjJjNjdyWC85a05hL052eDZC?=
 =?utf-8?B?WnhrRkp5bXJLdVJkZFpNR082b1JjRm5sckFHQkZFUVR6bmZ6Y2l6Znl0c2R1?=
 =?utf-8?B?WUdIMVpWZ3BNZndZMU1oQmU4UW9TSmpkWGZGOEVVMDVHdHdrRlNuUlAvTDNU?=
 =?utf-8?B?UGpTa29tU2RYUWFqWHo4K2FOaEJySEpZVUJ4aCtnYzJvVDRDZmYrbDM3Qlpn?=
 =?utf-8?B?bU1NcndudDhWbjVESnYzamoxNnR3S0dSTkc1MDFIenJlaCswOWJWS2hrSFZY?=
 =?utf-8?B?ZFpTZlNMeWViamJ4Ynh2NW5HdGFYZVJvcGtMakM4aUMwT3lTdkhMcnRoYTNq?=
 =?utf-8?B?Qml6dUw1YmlybGtMQW5ZUFhhTHBOc0E2VG1CWGRpeFg4UUFQaWNYRlhEL1Mx?=
 =?utf-8?B?Nzhia1l5S21CbHBvY3B6UWNNeU5hNGsvRjVtL25LUVNXdHpKNC9EUmZuUExG?=
 =?utf-8?B?Qlh6bUpEQUZtT3JTTFVpeEMvVWlRNXZoL2s2WmY3c1k3Z294SWhnRnYxSmhk?=
 =?utf-8?B?R0QzbklLYldEdWxCb2swK0p6ZUVxY1Z4RmdqVDByUWkzSkdJTWVoNldRaFFL?=
 =?utf-8?B?dThFWXJEbVNFT1FOT2JkYzhLRWpseGdwaXB5WmJraWVWcit6Qzk4OFVNVDR3?=
 =?utf-8?B?YTZQM1k4OWpBM3RTSWdPdGJCK1J2QVM3aGZsMUNTMUdXWTdSUXNDTG1pcVN6?=
 =?utf-8?B?dkJsRndVZ29VeXZkaWVHVDNza3Y4dElnMXBiSzJONzZBTENVQTNaRWdEb0Vl?=
 =?utf-8?B?Z2xIRFNsMmcvMmNzVzUzWHNwdnlBWHFkQ1A1VlYvMVJEY0xMODc1dFNCT3RF?=
 =?utf-8?B?WUtNQ0xZR0FKL2tXQTByV1N6RXlvRG1ET0E4Q2orci9zK3p0Mks1TGVMYU5L?=
 =?utf-8?B?emN2RXhXL3JiNFRzTWo2bjExWlNOT1ljbGVQdHFLcWgyWnBBTk1yUy9kY24r?=
 =?utf-8?B?QmxrS25sWVdBTlhoQU1wMWorOC9XNUc4SGphRnB6aFpTMENqNnBtZUc5OG9H?=
 =?utf-8?B?czJ0Z0FSMVZWL1c0Z0t3SnlpbE0vOGZmTnBGNEVEZTZhVlAremJrMHJLVHRJ?=
 =?utf-8?B?VGFpd1JNR21ZK1pPNEFhMWp4V2NzOEo3R0MyRU1SVGtpTEV4YTArRDAwVXY3?=
 =?utf-8?B?QjBZcEZVb0VSUkliODlzVnVvZC8vNzNraENMd1l0dHM3ekhBaG1vbnVFeVdW?=
 =?utf-8?B?UjVSZ1BBcFVyQUZIWUNMelRzMmIrTFhiSnlGMk9rdHRXY2htVjN0bjM5YWxZ?=
 =?utf-8?B?WjZYSnNnaXNIRzgrWGhSSmFzNklPQitPOWp2QUV0RmtjWUMrVjI0Rm5qSGZE?=
 =?utf-8?B?RzhEdjQ4ODRIcHFwblJzaG1VT3VoTzc5WmkrT3p4SDZmNVRqbHBtY3k4UUNC?=
 =?utf-8?Q?9sdUYCyqyRRq2?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6583.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZHJMWGNOVk9xWlFzSmNLWDYxbEU3eFROSkQrZWNOeWhXbnpITkRJUUNMMGJr?=
 =?utf-8?B?TWRibXc0QkIxSXR6T1hKS2tkVDl1RE11SmgxU2dKZDRqWjRnRWpXVXNLTzZR?=
 =?utf-8?B?b1RSQUtjN2Z1NTdyNVdJbUo0MDZxUGlTcnpGczZIV1kvS2ljc25MdEVFQUhy?=
 =?utf-8?B?TnpwajZtSmVZNGx3UUZjcXErc1VMNndnZ09CdXBsUGlTSDlqQkpIT1U1NGpx?=
 =?utf-8?B?aGZKYkJjQTJ6dzZvR0ljTUhSYVNVSzRaa2d4VDhzWkFlOHA4RG1rRnJURUhD?=
 =?utf-8?B?L09YUGI4cHQ3c3Y5cGlSMnRpSmEycDRaK3NRWGt1cFJ3cTV4bUZTb05tT3Fh?=
 =?utf-8?B?ZStzODBsQzVHN2lmeGlkNURaYjU3cDRkRXg3aE9LeW1YUWtDVWgxTTJreUlU?=
 =?utf-8?B?UGV5NFZVbTJaaCs4UlZ2eVRPbW1IYWszSzNyY1U5ajlMa01PaUdyWjI2VkxH?=
 =?utf-8?B?d0pqWk4zSyt1dW5tdzZSTEFtQjIzdmpaMGZKNXYwRXFmTytic3JpMEl4ck9S?=
 =?utf-8?B?WWlSb0EzZTFkcVRFVjVDNXpWcEpkUm93eDJjc0VYT2VBVmEvMGRScWVIQmRw?=
 =?utf-8?B?L25ZSGhuWXRlY2FyY0MyNFBwazFLeDBRSFVrUjhUdFY1WVVkUzM3UitwQzZx?=
 =?utf-8?B?Z3MxdzlxYWE4MmZVUEdvUWZYQlpiSHpQZGJOekd1MHROM2kybEdiWWdTL3BW?=
 =?utf-8?B?ckoxa3d1bnl0SHIzczJsWmh5VnFHNmVlOTlKTmdRb3NJVGpvUitzNnUyVXdi?=
 =?utf-8?B?QU16TVoyZlI0eUNMNHQvOW5GL3hwdysvSVN3eTVQNVhqenBncklVWTUxN2lB?=
 =?utf-8?B?Z3FlU2FNek9TdGF4NzI0OVdmOTR5TlM0WGZpUXZEOWhPVzhQWkd0aDBHSSt6?=
 =?utf-8?B?S0pwUWFsMFNEaTdlQnVVZkRiU1hDYnFYb2dHdnl6cFRkenNnclI2QzhkeE83?=
 =?utf-8?B?RGwwZXkzaHdvaHlQbEdqYitwYVZmV3ZheERrNHJHMGh2MkRabFBoTVMzdlVJ?=
 =?utf-8?B?ZlV6TytBOXhxQW5EazZPVDlSZUU2dlBaSENoUDJ6ODFvUHhHekJjS3psakY0?=
 =?utf-8?B?TVNVcXovOUZ6V0NxQjZha3NscGxrZFMwNU5MaHNSaVlBeVF4eEd5YzRjdi9S?=
 =?utf-8?B?MWt0SXUzbkdsc293VXNkMGhxVTg2MkRmT3F4QlR0Z2ZUSFpLb2ZDM1VlU3pH?=
 =?utf-8?B?WG1DV0FNV2hBNW1wd3BFZk11NGh5bk5KK1NaRTNSSFdFR1Mrb1NVOU5EMTNV?=
 =?utf-8?B?UkVRaHJrTUVaODZmL1gwL3p5WGZsQzdNNk1JcG5RS0dtOGlMOURadUlnVVNH?=
 =?utf-8?B?RWt3cHJmYWx4NlYvUWQvTUlveXFLYmNWdnRRSzNVTmt5eHJRQ2Vjd0pVajVB?=
 =?utf-8?B?SHNKMlJhcWJGTFg2OVlldWQvZDBTMTNRcXhSYUlxK3JvKzJsQVhCeXIvd1Ur?=
 =?utf-8?B?cllaQ0YrZjcyeVVaZEExQnowMHZpZEtqZ1hQYkpPYmlta0RReXViWEtPeFRM?=
 =?utf-8?B?a3RRREx4SVUwWW16MkNVbjJWRnM5SEFEa1UvS3JpS0JxTnlhNjZHais3aTdl?=
 =?utf-8?B?dnEydFByRkxkTCt1SWJldXRucXdXTTlXRGswd3IxTXcyWTArdnk5b04zSHRn?=
 =?utf-8?B?VVpTOWY3V05Ub2svSnpSM0xrU0lWZEtpOVR1amxvU0RiQzUrT2w1RUt4RlJS?=
 =?utf-8?B?aXB3emtRbFdnc1dvL2grTmlHdUMvN3JoY3ZIczJGS3pNeG1CVCszYjhnV05Q?=
 =?utf-8?B?WHBNc1Z3OWJDeUljTnI4OElzd0E3a1ArZm1GVFJsOVNla1V5OFdPUkl4UGNp?=
 =?utf-8?B?NEloK2RZQWlSd1JFeEVZVEhwMUw3eHRXR1djSWYrVkxWWnJxUW1DUUp2TDFw?=
 =?utf-8?B?dTU3ci83VzhKbktrVTFpOUlNWi82UW1WVzIvQXZlVjNiMDJ3b09vc3hOanNF?=
 =?utf-8?B?Z0dDRG5DWkd2ZENETTUwREIweHVkRzFaaVBkZXRkZ2tsTzlMYmczQk5kbDkv?=
 =?utf-8?B?Y2Z3UUFOWFNkQ1N3SlkwZEFsWkdaSnM3bjdEOVorQXA5eGlXZkJEem00M0o5?=
 =?utf-8?B?NWtWTEYxTDhpcnh4N29hbFFVcXJESHROUlV6ankzN3JhVFhHVzVVRTdRaGEv?=
 =?utf-8?Q?D2Z3Lt76eaKaP12bFaYERjLtb?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4874463b-2020-4621-9910-08dd4d1fa848
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6583.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2025 17:47:32.0954
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WiSSvES4RejyrMEja3nRzifcwuebo4dyi2SRz82VFu4W1glJqdsv4uJW6ZyvZYD3+QNVw94aP30jpqzVZ9NuKQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR12MB8568

On 2/14/2025 8:23 AM, Edward Cree wrote:
> 
> On 15/12/2023 00:05, Nelson, Shannon wrote:
>> On 12/11/2023 9:18 AM, edward.cree@amd.com wrote:
>>> +#ifdef CONFIG_DEBUG_FS
>>> +       table->debug_dir = debugfs_create_dir("filters", efx->debug_dir);
>>> +       debugfs_create_bool("uc_promisc", 0444, table->debug_dir,
>>> +                           &table->uc_promisc);
>>> +       debugfs_create_bool("mc_promisc", 0444, table->debug_dir,
>>> +                           &table->mc_promisc);
>>> +       debugfs_create_bool("mc_promisc_last", 0444, table->debug_dir,
>>> +                           &table->mc_promisc_last);
>>> +       debugfs_create_bool("mc_overflow", 0444, table->debug_dir,
>>> +                           &table->mc_overflow);
>>> +       debugfs_create_bool("mc_chaining", 0444, table->debug_dir,
>>> +                           &table->mc_chaining);
>>> +#endif
>>
>> It would be good to continue the practice of using the debugfs_* primitives in your debugfs.c and just make a single call here that doesn't need the ifdef
> 
> I'm still in two minds about this.  While it makes sense in isolation
>   to do it that way here, in the following patch we add a more complex
>   dumper, and I think it makes more sense to put that in mcdi_filters.c
>   and have filters code know a bit about debugfs, than put it in
>   debugfs.c and have debug code know *everything* about filters — and
>   every other part of the driver that subsequently gets its own debug
>   nodes.
> I already have some follow-up patches that add EF100 MAE debugfs nodes
>   which also have custom dumpers, but those are in a separate file
>   (tc_debugfs.c) because there are a lot of them and tc/mae code is
>   already split into several pieces, whereas I'm not sure whether
>   adding a separate file for filter-table debugfs code really makes
>   sense, or whether it's sufficient just to refactor this code into
>   a(n unconditionally-called) function that continues to live in
>   mcdi_filters.c and has the ifdef within it.

Thanks, I can live with this.
sln


