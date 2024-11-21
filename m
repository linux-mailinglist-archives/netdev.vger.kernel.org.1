Return-Path: <netdev+bounces-146628-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 332249D49FF
	for <lists+netdev@lfdr.de>; Thu, 21 Nov 2024 10:27:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AD72B1F214A6
	for <lists+netdev@lfdr.de>; Thu, 21 Nov 2024 09:27:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3ED061C9DC5;
	Thu, 21 Nov 2024 09:27:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="jFX/Ix1q"
X-Original-To: netdev@vger.kernel.org
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2062.outbound.protection.outlook.com [40.107.101.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0D3D1BD9FC;
	Thu, 21 Nov 2024 09:27:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732181265; cv=fail; b=uOdJ7M2wBjzGi5HbIgzD9YlLIlMqDIQKNvnYzBOj9OaNxcmCNKH6GibZhH3jvftDl1BhozkhDR+5Tt3csgRmNyfD7+AZn/eidrPTtyHs4nhYq4wC5uHyJdZxFxXR3Oucf/1/MepLVBCRaeO/WkLN7qSssoe8ei9g4p1GKFG2I9c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732181265; c=relaxed/simple;
	bh=ZgFyj9RlPKuGqDCIfJel3uMP6W92iQ6Zf51L9bFoMPo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ZlfE/sTLKh9iy71t+cBuEiqSJAZDYTKd3vBbv06uvwdBgGsCSqfvDbbGyRLZHreYpqluNueGbTWF3sOiP9vVXhM4rodCxRLDK0+7Mqgo59yttp7E7YRUEA1hjrUwi5c3KRPvFILg7ut/4QVbeJ5n5h9KMqCTvmKOH2gvZ1WQWp0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=jFX/Ix1q; arc=fail smtp.client-ip=40.107.101.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L4ebYVyRjyVfojZO4hyLZqAoxWAM3OU/kEz45fud2VAn4QwJqoPetfaRtG5m3IZl6eGO+JTCKPV/+qbUpV6ADBXSkCdz6Vss3rxafbGfJycmR15dFSrOstfUuNiAmpQxaCuXVzD8HCWoOy/MouYrGKKtYg2Qeri+YFYB6N8vC+PuSvjRujcinKfT7cQvX+4Hu6BW+GkXhjUrjC6TNWDtpdp1wj8cCyisXVKVHJZU7aClyiW1VOV/e5MMZUVpfOQ/apH3YZ1kggmk/FeM1YDphgkgwOg4Ywz0MThgxk009HKPks798U5yulG9u4mxUJGoz6OfBE/fjiFyux7nh6oCUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fFbeN0dN/9NlTojXya6B7ZGFFLEqUj1Rb0OcdnCxWVs=;
 b=OyCJbVuqqwp5GrAhEHmejqDG882d6/jZMZqrOYRfNh0APzRTKR8n767PTis2+cUTA+8u5CCYi8sS3Va/U3gRQiyjPQfpOv2eMWJnN0DgDFI/nO9D9ZXawuF422NMc7q4KWhVte1WhPEHuhmywQrjabcA23x8gbFK9bjetgDZ0dQtvt17Vf4vBmqKCk5Efa6Qr71j8DSmMusCbWsSBCYEAT5HDnLSh95MII/HShz/UOvnLcetSiPBtzC1d6Zx/OyIaZmtV9JT2Va0k8G4JHoKANH1KUmbOmDdfa3y0QfG8H1VG0lP5WKQOb/F9JPlQQ8gcpKKgo4YiXhIglf8vGKqGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fFbeN0dN/9NlTojXya6B7ZGFFLEqUj1Rb0OcdnCxWVs=;
 b=jFX/Ix1qRvLY09B/d/YkykztjRR27gN+pF3O/Ru40weqRkqbsmI3R1mhvUmf2QDQf87k1egkMZcfmJw0+Fl35Uofjysx81plkA526DZd1/QDp1A7LjoXYb5wPHp1uiXpDN26PXweTTLmsxfE6IQgpu3MmGWSjwztIV62kBOLsd4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4202.namprd12.prod.outlook.com (2603:10b6:5:219::22)
 by MN0PR12MB6269.namprd12.prod.outlook.com (2603:10b6:208:3c3::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.23; Thu, 21 Nov
 2024 09:27:40 +0000
Received: from DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79]) by DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79%5]) with mapi id 15.20.8158.023; Thu, 21 Nov 2024
 09:27:40 +0000
Message-ID: <cbaefe66-a5de-47bb-a0ca-ff96fb4a5077@amd.com>
Date: Thu, 21 Nov 2024 09:27:34 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v5 00/27] cxl: add type2 device basic support
Content-Language: en-US
To: Alison Schofield <alison.schofield@intel.com>,
 alejandro.lucero-palau@amd.com
Cc: linux-cxl@vger.kernel.org, netdev@vger.kernel.org,
 dan.j.williams@intel.com, martin.habets@xilinx.com, edward.cree@amd.com,
 davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, edumazet@google.com
References: <20241118164434.7551-1-alejandro.lucero-palau@amd.com>
 <Zz6qFaLNs0XmdhMw@aschofie-mobl2.lan>
From: Alejandro Lucero Palau <alucerop@amd.com>
In-Reply-To: <Zz6qFaLNs0XmdhMw@aschofie-mobl2.lan>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0536.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:2c5::16) To DM6PR12MB4202.namprd12.prod.outlook.com
 (2603:10b6:5:219::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4202:EE_|MN0PR12MB6269:EE_
X-MS-Office365-Filtering-Correlation-Id: 7c19d1a9-092d-46d4-1133-08dd0a0ebedc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?L0g5SXY4dlR1MnVaWXU1b1BlRm44R0l5Mks2UldpSUtKTU8xU3ZUR3Bsd2tr?=
 =?utf-8?B?UEg0YW5xOGJKdEJSclpXOHl6anhwS3g2S3NubWtESE5HT1NVaEdiam5rYyty?=
 =?utf-8?B?NDdTbWNnRTdCOW1YcmhrRFJsUXdkejNtdVdIb2FsNWFYK0JQOFRDMmRxbG9B?=
 =?utf-8?B?dlJXNXg4aVpLM1pvMTVCMHpCUGZYY2hDbitjZ2FVMHpPbEt5UkM5NFVIZTJF?=
 =?utf-8?B?aFZwTFQxdXhQMlo3M2l3NkxEcis5N0lSdEQ5MkVRNU9ucGNORjdqYm1MUHZT?=
 =?utf-8?B?ZE5DRmFRSXJCY1g5YVFsNWd2V01BQStTVWxEaXNPdURlaFFzeVIvWloxQ2xh?=
 =?utf-8?B?QzJKTFRYcklHUnN4ZEdZVEhieFUrc0E0NEwvMmN3ZHBHRW4yLzdNczlEYjNw?=
 =?utf-8?B?MStWWWxpWjJiSk1xYXFUU3YweDNUYkRsNk00THRvbGtxSzdTdWh5TVd4Qjdr?=
 =?utf-8?B?LytteFMwSzV5Q3lGeHBsZm9LekE1bVdpOEt3cGR2NnZuV2xMTlJtOUFkWWNH?=
 =?utf-8?B?eXFrWThhYjg2c05ab3NZR3owTmxVZ3FaNmFGZ1RLbGlXd2Nlbzcyeld3aEZR?=
 =?utf-8?B?a2o3UGFCVC9rTG9TbnpSU2xkcTBFRHNLb1RiY3l1Ykw3OEVRcm85NzFsMUta?=
 =?utf-8?B?dFFxY0Z0KzR2NG1TcllUNzNzR3NuWHJ1OWxCaVN5OWZPdnR5S1hJSVhVNFNs?=
 =?utf-8?B?WmFVeHM4RndjQnNtYW5GNDhQRDNxSldXRGlzcHpzU21FZEZOcEZ2bVNXanRt?=
 =?utf-8?B?UnBpZmpNTzdsaTRib3kwMzVLUGF1MXE4THk4SklpMWtoK0o5TWpxTzliTitq?=
 =?utf-8?B?QnpreVk5NkJCMitkNUlFa3NNTFo4c2F5d25KWGlpZktmbEFzcDMrRmZORVd0?=
 =?utf-8?B?ZnA4YjZUc05yUjJhNDBadVRudEhPRDhCdlNEaWo1V0VMSWNVL2lZUmhTa1l2?=
 =?utf-8?B?TXNwTkNra0x6bThzbDB1Qm1NbWxYYWhmdGhiOTY3dlNSeHNLVHJKZnVFWFRD?=
 =?utf-8?B?bGNqcGVNbnU4LzZsT29TclFuQ0VHYUdreFJ1NnFNZ1lubE9xTVpqRkFZR1pr?=
 =?utf-8?B?bjZ3Qm1MV2pnT3R1Q2UvTVlwZzI2bDlzNXlHQlhyZzFvVmFKK2UwRVd6cFI4?=
 =?utf-8?B?V3VmUXRpSXVkYjRjZndLVU1YUU1UbkhTTVg5blhBOHMvVDRoaC9ocWZPSEZw?=
 =?utf-8?B?aGoxdGdtbnF4U1RESnVGKzJhajNyM1VNVmFmS01Jb2RUWkUvTlVQbXp1ZVhI?=
 =?utf-8?B?VTJRc20zNU8rOXNQRE5CMTdxTDFQai9wdFBOTHVSVUNBYkg5ZXFPa2NiSTAv?=
 =?utf-8?B?YUdkRVhlRFVSYmxTRnJOSnMrRTFWOXdHYnZRWFpDZDh5WXNGRjNTQjI5OXBS?=
 =?utf-8?B?SHloZmx5OFV5RmlGTml1TFJnVFgwcmo5K1pUUldTdHFLSlRqNHdmSEllVGtH?=
 =?utf-8?B?aG1zYVpZejk2ZU4xZ1BHbC8rd2F5dUVUV2xMU1NGZTJLRVBocC8yMEdFOU5F?=
 =?utf-8?B?NlBaeGhZMTlqdXBDbnFDWEZjcFFLWUpmdjd6UE9VeTdjS09ObndVcWRxV25I?=
 =?utf-8?B?VFJIakNHMEhxcndncVd6OGQ2YVlvSXhXU29WV3F5NWtnT3NpNG5zSFh6TmhZ?=
 =?utf-8?B?ZWF1K0Q1ZFQxQTNzUDZNemZGZnJDUWIrUHo2K1M1ZHB2ZmM2Y0w5cGhhRTNF?=
 =?utf-8?B?ajZDUUMrRkM3dVFnaEF2TWsyTEVKak41b0wxMVlWR2lxWTFuUHZHMEo1ZjBp?=
 =?utf-8?Q?+AQnLPbNlGNN4aF0bJSbtP6TU0wqYPh1hXoTMXH?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4202.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bitydmliS1kxRGxjOGJpMTlqZDdMcGVNMHY3UzU5QS90YlIyOGNucEY5YVZC?=
 =?utf-8?B?K1Q3VDlBQVg1bEhRU000UWtIUjZJWGtSNmRrMCs0NlY4bFo0U2ZJMWlNSEF5?=
 =?utf-8?B?RUk5TldPR2Z1OWhNdVdsc2VBbXh4bTdwRE1pMG5XaEhJVjNTaE40S1FzTGFV?=
 =?utf-8?B?emVKTWVUemlueUh5b3ZRVTlxbGNmYkI2WWhsVWhTY1kvVGNNdE9yM1RCWW0x?=
 =?utf-8?B?QmFWZlRLRWowc2FlZzh4SnIxS0xtK3p2Nko5L2w0T0ZIQjdTYWVLZ0dibjB2?=
 =?utf-8?B?RGNNVk5pUG02c1BuN1BGZ05XOWFHRWtMOWVoYmZNUTk2ZWpiQStZaWRYZENt?=
 =?utf-8?B?UXR2c3lMQkk4VmVTYWgxMEJjbjlIVlkvTlRqY21oR1hWSW5lbnBJZUFINjZN?=
 =?utf-8?B?djlxd3krZ3JhQjZjYnI0aGZqZlhGVTN3NzBkWGtibEVTamZHcmhsVHZaTG9G?=
 =?utf-8?B?dWhJMkduUEUrcStJSXhueXFHV2lJYWRYZHZMcjR6ZjJuTHB4SisrbGlIbEIx?=
 =?utf-8?B?L3craGxlQ0xaRm5pQ0p6aDZmTTM2WERLQldMWUVjYW5rR0JZSy9wUFBxcEtM?=
 =?utf-8?B?SlFneHhBV1lmQ3ZTbVp0TkJJL1Z5VkFYL3A0dkFjSkZZVnZFcUNRQWtvajJC?=
 =?utf-8?B?OC9lRWVyekpOTld4Mm0zaTQ2S3VxV1Fnek5Sd1Jjb0dsd0pwaENNcCt2bGIv?=
 =?utf-8?B?TXFrcHp6UVprWTRBd3lVd2lDS1FPSDQ0QWhZaUFwaXlTUlliYkJyTUw5VFpy?=
 =?utf-8?B?Z0VLVkVEMEluMVZGcFc3dkRITWFZN0x4WmZCZ2lvdTczOU1zSC9DTW5zcmJ3?=
 =?utf-8?B?cnNQMExrb1FPazZObFBaaWZIdGlyQ0xWcFpVZGNoMFdmYlY1aC9BdjBSZlRn?=
 =?utf-8?B?OFYvaVRoWWJHSDNtVHlvcnMzQzJFd0dCSzVzblZYek90SjBxMGxmLy9HVjJF?=
 =?utf-8?B?NlZObVJlRmUyWFZWLy9hazJMMFVLdDBKM0VFbUozRE1ZcG4vRGFyYWlqZ1Nz?=
 =?utf-8?B?TU50YmE1Vlp4elE0cnhvZkhjMkdSKzI5VmVqMmhVWHcvRE1rOWFwR2N2N0ov?=
 =?utf-8?B?eS9wdzYwSkp4Ynh6MWJ3YVJrWDFaSThyQVlVbjZvb1V0VzVyY2RIZ3NDOThT?=
 =?utf-8?B?M21qM2NhSGpHRnRtVlVpN2dOWCtYa1FCQmdVa3VkUGVCby8rRjkwWlloN2lV?=
 =?utf-8?B?ajBGT2Noa2RSRjlxT1l2RzE2b1crczArK2V6QmU0d0VVTXFYcjl6OVhmLzVS?=
 =?utf-8?B?WEZlQWgrVDc0OTJHOUZoV0diSUdINk1aNlM5MUowNTRvZWtoSmE3UUt3RGky?=
 =?utf-8?B?R29QeEpQS3QwZ3hOL2prUGx4VGsyd0Z2R2NGMFNoYW83VmxtQ3lkZHR0anFj?=
 =?utf-8?B?amVvUUlLUXpTTkNUQ1FVcDFOOHREMHpENjhMeXlrZnFtV1d2d0hBZWJtVnIz?=
 =?utf-8?B?SlFNc1JVUmpzVy9QdjhIeEhadEhodWptTDc5cm9OMExUczdmdyt4ajNkRzdW?=
 =?utf-8?B?eUlnanJja1BtUHcrMVk1Nkh5SW95S3BXcTNsYThzRGdwMWNjWkFVbkFtSGls?=
 =?utf-8?B?MFoza3RMd1BkeE91OFdsMzhNOFA4NWdhMDJSWEJCU1d3cmw3WlZEVzBuZTBW?=
 =?utf-8?B?dVdrS0F2bEY3TTJMSldBbmF2ZDZjMjRDYkpsZGFUSlVtYytIMkkyQW9QUTEw?=
 =?utf-8?B?anZ0RXFJZ2dFbUNjQ05ybFNnUE5KQjN0N3R5U0J3V3VSdHFEMjFYeDlEN3NS?=
 =?utf-8?B?SVV3Q2Q0Ti9ldG1vekk2cFVTSDBJckhxdlVwWnBuSmYxWm1FSVYvam1aZXdl?=
 =?utf-8?B?NHFjazFsT3dSQmhvSEZmcjQrcCtLVmpOV0djVlZacEVxNlJtQW1lVDc5QXcy?=
 =?utf-8?B?aUFvY045TEpJNGxWa2t2Tm1wcXpuOFZHcWxTZzRxRk9tSXRLaXU2SHRnZWcz?=
 =?utf-8?B?TzJsdXp4eldkbCt0a3IwZXd2b3dUSFd1MUdJZzEzOE55aDhvTjVxQ21JS2dH?=
 =?utf-8?B?aXJBcE9saCtBUDU3Q201ZmRubTVyM1ZjQXR0RGI0bCtqVFQ3RWNiZE0wcnl1?=
 =?utf-8?B?VlM2eThuc3dDQXZNRmhpMjU2UmtxQkdpbkpJekdlMVFKZmtjVlBscHFEb3FH?=
 =?utf-8?Q?7Dqu7a/sF+BKimA8DX33Z3hWl?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c19d1a9-092d-46d4-1133-08dd0a0ebedc
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4202.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Nov 2024 09:27:40.6380
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nAYZwwaY4ibUazA5e9tKEWteSM1C4OFtjfuI60elqTtZhW6GitbU0mPmI8wvY0U/W7M5YaRoeNnRQoJYvIdwMg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6269


On 11/21/24 03:33, Alison Schofield wrote:
> On Mon, Nov 18, 2024 at 04:44:07PM +0000, alejandro.lucero-palau@amd.com wrote:
>> From: Alejandro Lucero <alejandro.lucero-palau@amd.com>
>>
>> v5 changes:
> Hi Alejandro -


Hi Allison,


> What is the base commit for this set?  (I'm trying to apply it)


I'm not using the CXL tree but Linus one, and using 6.12-rc7


> In future revs please include the base commit. I typically get it
> by setting the upstream branch and then doing --base="auto" when
> formatting the patches.


Apologies for the inconveniences. I'll do so for v6, which will use 6.13

Thanks


>
> Thanks!
> Alison
>
> ..snip
>
>>

