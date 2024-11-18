Return-Path: <netdev+bounces-145986-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 752909D190C
	for <lists+netdev@lfdr.de>; Mon, 18 Nov 2024 20:37:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E1EE7B212D7
	for <lists+netdev@lfdr.de>; Mon, 18 Nov 2024 19:37:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D81D71E501C;
	Mon, 18 Nov 2024 19:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="hI64/J3D"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2070.outbound.protection.outlook.com [40.107.93.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6C8B153BF0
	for <netdev@vger.kernel.org>; Mon, 18 Nov 2024 19:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731958613; cv=fail; b=DJ7WFogQ6c5ieXKA1Ja59bKhIylQhOGr2ytS8XQvM+Z2yffHBwTc1f7LnOsIq0XdQ7tH82ZtoYZSXuOe9X4WcNEAcBJUwNlVoCgv0A1kykwU5Cw/oztu3/A6OzLrnyCKnCwtCIz0alLHM3ZLZOPFJYnCZW8LRrRASux78BSAREU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731958613; c=relaxed/simple;
	bh=5R+OK4mufDSXnWCFsVvW+cAOiFGT1ZWBQrSo4XY6/O8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=dGs6z37SP+rsia9s3YXvLCr4HzCWZtPvK4ew68/ZpAVjTcmRPfSfpMSFJStZdPzCxkATQKcm3+yjZU7eMK6Zgui16dZJuHcm2aYo9GbqcolQR54SAhaB8BrVUgNVXlEMVWgUliBjuNNttQgHZfzmSQXhC4wxBbyQqK80UvekoVA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=hI64/J3D; arc=fail smtp.client-ip=40.107.93.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MIZQk9e79+HwsC4bIjyxhj7/iCtIIQ9SqSBva5ufGRhdQuC8Ew6k9WwZLIr1X2Br7DG17vAlvLo88RBcfpNxCYFYyqKFA9HkEzSqEtaiYLLH0MCmRkraxty9AvoJMp5OKzC28XaxZdmCCAvx9yxTEDFnkXVgxPVAQVlK1WFTcim34DocKuzMt/PcHteHCmtjAgLZuaNCjFktprZJhGNU02inAjBhUT1xq8m71e/1LAYiRK+IEx06/HB9VWTKpRNyMl31OQCSrOYEnOKCMso8Odkkd5tSd63nQnNeT3BTmFDER9Q/C39Jcs47I0XruMaDqsbWRWKKONac1k30KKjxsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KlA64x7IXcsH0HumOUfU0XXQk2vFis/sqylEKt1Mxns=;
 b=C+6rccbtQIfkBlJ1Uz/cupZ8knIi3SAYV6JnVX3l73f1CI0A5pvwrb9ZSE5yntG7aXYvFe+f3U5l1y/7G57gMDuVXF0weS2XjqjDK6ASoURcUpAvLI72gPpUpc/1L3RAxB/LBeMN2wvCiInk+FHzJs6A3UGRZS2wUygC858ND3HNhhsCK4fz4sBpc92U7s09V6WBPRgn67ScuytKDCeuO/zstQapKuC/E6PvP3d+C46E+rqKrKBtJtz9pMgpKhXU6+534gMPWehuGb7KM9l4BhomRfdHTYBKuzWUsx+97qRNtFde17u4JMJncs1V2fRCsd4anL9HgLc/7LiTFdmHEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KlA64x7IXcsH0HumOUfU0XXQk2vFis/sqylEKt1Mxns=;
 b=hI64/J3Dy735ZjIflLhfnSyr1bjHqQVtt9Iz+K3iPyVQPgh/N0qAcOWtPom0Hogd1mzyorDJKwc42OV7jnmwSPyqzdmT1kytndHQFVVFKjzSl9zctcYRQWeLgl0VyWvFpbA/CtJMhJ3VaTlsWuJYlUiTl79rIshUQEMVLdPEH+DqQsfN6WsfD4aBxvjMjvnEgsfNQTmUWerSb1vVOVYm20ZdxOIkmnSm12gFcT3tnMfmvyd0p7QAXYv6B4qtxDJ+lo8QexRJ5nGchjY+S/lcNQYGFLSh6s3qerpEDYprz9yKh1Otz9AzDacffuLulTEkZeKNyhwgZu9xIgdPok/LYg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MW4PR12MB7141.namprd12.prod.outlook.com (2603:10b6:303:213::20)
 by LV8PR12MB9419.namprd12.prod.outlook.com (2603:10b6:408:206::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.22; Mon, 18 Nov
 2024 19:36:45 +0000
Received: from MW4PR12MB7141.namprd12.prod.outlook.com
 ([fe80::932c:7607:9eaa:b1f2]) by MW4PR12MB7141.namprd12.prod.outlook.com
 ([fe80::932c:7607:9eaa:b1f2%3]) with mapi id 15.20.8158.023; Mon, 18 Nov 2024
 19:36:45 +0000
Message-ID: <b4aa8e75-600e-4dc5-8fe1-a6be7bb42017@nvidia.com>
Date: Mon, 18 Nov 2024 21:36:38 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next V3 3/8] devlink: Extend devlink rate API with
 traffic classes bandwidth management
To: Jiri Pirko <jiri@resnulli.us>, Tariq Toukan <tariqt@nvidia.com>
Cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Eric Dumazet <edumazet@google.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 netdev@vger.kernel.org, Saeed Mahameed <saeedm@nvidia.com>,
 Gal Pressman <gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>,
 Cosmin Ratiu <cratiu@nvidia.com>
References: <20241117205046.736499-1-tariqt@nvidia.com>
 <20241117205046.736499-4-tariqt@nvidia.com>
 <Zzr84MDdA5S3TadZ@nanopsycho.orion>
Content-Language: en-US
From: Carolina Jubran <cjubran@nvidia.com>
In-Reply-To: <Zzr84MDdA5S3TadZ@nanopsycho.orion>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0199.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e5::19) To MW4PR12MB7141.namprd12.prod.outlook.com
 (2603:10b6:303:213::20)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB7141:EE_|LV8PR12MB9419:EE_
X-MS-Office365-Filtering-Correlation-Id: cda38a05-d14f-4a38-65b7-08dd08085607
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TnVrT25QUW9ianlNSjZmNyt5RUlKeVhXUzhCTEQ5UWU5RHRwOHdKc1UvcDMr?=
 =?utf-8?B?MWFkK0N6UG9LVmltV1d4cnl6Q0xxTzAvK0NlTmczanJRUmZVNmZmSWIxSnNj?=
 =?utf-8?B?RFljTWc5cHcya0NnMS9jbTRkS2hpUzl6RXQxN1NybmpJTFQ1dnBBWklLK0pP?=
 =?utf-8?B?dmMyRWhjMFRtZjRCdlNsdjg5VE82b3dHa0NLZDRhVGI2dmpQL1RRT1dteUpt?=
 =?utf-8?B?c3RPczEvZnc1R0IxZUJ5NDUyKzloeWg4ZkFTaTBpUlJ0NGNXWjQ3NzZGaS9L?=
 =?utf-8?B?QUVoNUttTUUzcG9BQ2dSc3VmRDhmdGtLOG1PdFk0MUUvd2I2bWNpVHNXTkZz?=
 =?utf-8?B?bUthaEwzdHpPUkRhZlNzVWRlWi9zY1Z4TDhiYUFjcjdrUkxKUTVJdlo4SGdK?=
 =?utf-8?B?MTFyMkNYUjZLMTFqbTNaaWtxdkhTQjI3NDV1VVhTK3NKS2JUR1oxVThtVThI?=
 =?utf-8?B?aW9RNFg2Znlkb09lSy9UdG9RNDk0NHlZWU5zc0JqQWlqR050Y2hKZ3R5MFVU?=
 =?utf-8?B?QXViRWFIR0M3aDhFZEVTTlovSmx2eWpGMGNQZU1vOTlILzdxRVFiM3lURUFj?=
 =?utf-8?B?VjY4NVJzUndrOHpTNVdXS0N2OUx0OHJNQjNYbVhKYVhIVDFzSXprYUZHS2sz?=
 =?utf-8?B?cUhaTFIzTDk1d0ZRNUFOdVkxZHN2c3NrYWg2Y2hOZXMzelVKbHM1SHFVd0I3?=
 =?utf-8?B?aHZQMFFOd0NxS2ZpV3dCNDQxamd1eFFKdnBZRmd1c0ZDUExkcTl2K25tbW9m?=
 =?utf-8?B?Y3dwUDliVVlZZDBidTUzOTI0ZWE4NXltMWNBbTlEcTViUlFORkh1U0puam1O?=
 =?utf-8?B?dll1c25VSFJzM1ZsbVNtcjFQRmJPbXdSWXNkbU5NViszR1ExZTZCcW44S3hV?=
 =?utf-8?B?eDRGYWhDRDNlSzMzTC9NM04za2xaaTIrLzFpYkd2ODRLeFoweVA3RUxCNnM1?=
 =?utf-8?B?WFVkaGxXTHd4Z3hFRlZjNjlQUi96MHJuVUFDNWFsZlVuN0VVM0FyNTdOQXZG?=
 =?utf-8?B?N3JCYTl4QlpyZzlwVXNBbkRwYmxPOUJUR1MzeTNXdURYNzVMdUpmdDREbkVI?=
 =?utf-8?B?Qk5YdXArNG1CTTBncDd0Z28rWk9wS09aNSs1ZVAzSWhVcHZDdlVxOGM4TEpZ?=
 =?utf-8?B?V2pUckR6OGlzNXVla1U0NTVBN1pHbDg1WlcvRzdUSERXQ0J1RXBJa09UTXNV?=
 =?utf-8?B?NXArSnlQUGR1clZNcFlxTEo4bHBzVFJkUExlc2NkUWFJVExmVTllY1ZHOVlB?=
 =?utf-8?B?L3VvN1c4Q0xvR2Z1MUt2ekhuaTRHOWhtM0VnK1NPSjRaL1RHeTNqQ2hpS0lO?=
 =?utf-8?B?RFNWMUlvb2lrVmpvUnFQemlCb0UwQlJqQTY5T2pRRHNNYXhDS2RhRFhQS3Q2?=
 =?utf-8?B?STFZQzZXRjZ1MUxLRi9FK2N6UjBIZVg0bE1vdlVJMUxWZGh2aGZKN200MEhx?=
 =?utf-8?B?R2pyUlgrd3FZSVcxOTJGWldMNnB3a284WVNhWHBqWW1TQ0EwcHQ2WkNrdndR?=
 =?utf-8?B?Y0s3QmtGZzV5MmJyY0RXNFVPd2hOVVg0WmQvckR0UFJleGY2SXZSV3dNY2dQ?=
 =?utf-8?B?U09ySTlHSXkxZWRCaVIyOWZrV1c1aDUwa0hQZ3ZEUElNTGVEbFRDYkdSekZ6?=
 =?utf-8?B?VmZQVUxHM3ZsaE1QTTh6NmY1empYODVMekJ2YkRNb2MwYmZzNGJRZHcvZ2pY?=
 =?utf-8?B?MStFcXM3MjZQQWIrQW5xUk9QMGxiUmhtTlZpRTNmRmtKS2lURWdhYVRmV2NF?=
 =?utf-8?Q?dv/Tes11RhqnxGcVC8XiULyYMp6YAt2q/mLJg0P?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR12MB7141.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?amI4WFV5RWwzNWJFdkV6dzgwc0FoSXNVTk5PNlZ5V1pOc0xkNU5wNlJINXRF?=
 =?utf-8?B?Q1RJdTFXbWNBc3N4aXFWRkVzUWVVK1dCZEhlQUJOZnVOeVlQanZzZFhtRVl5?=
 =?utf-8?B?Vk83N3hsQXdHc2V4eVVMVFJJYTIrMzgxVTArcjl2RlNUUG1CNEhSYnJiU250?=
 =?utf-8?B?VVNNQzFXWkFmRUNGNUVpa1BrNnBGd05jRDRCenRaRmkwU0FVd2F5MUhRNVp3?=
 =?utf-8?B?UlNnVWowWTNQVnFxWW1Md010Y1l6VXJJWW1SZ3VuZzdjOHNsK09uS1Ixbmhs?=
 =?utf-8?B?d2FmTHE1SXd6UXUva2RvaWlzaE96aTZjeWhPNHN6ZlBMeWpHYnpUZ1BNQ2F0?=
 =?utf-8?B?ZjFKV1V1T0tPMFhEKzZEOVRzOUNlTytQU3ZncnBkS1cyalNjZFdZRzd0MFdr?=
 =?utf-8?B?MnRCR3RqVjVsdU1OaU5wd0hQU3hocVBZU0h0L0lXTDlKUEN4SUhONTQ4Mmoy?=
 =?utf-8?B?Vkx0VDVkQ3g1UVlRRi9GVmRPeHp4dHdRKzcwLzlYK3F2Y2pweVUxUFpZSkdW?=
 =?utf-8?B?UVlCekZ1OFFwdG1aVmNPN2oxWjdZcURWKytHdWl6ZlZ4ZkppTFUxbS9wWVIy?=
 =?utf-8?B?S3JzRkFtZE5zU2J2NEpRMjFwaEpLL2dLUEwzVmFFVXZBUWp3ZUU1a2k4NW5K?=
 =?utf-8?B?ZG5uMXNXQjhiSFQvb1h0K09wc0lLTmorL2ZTeFpEZkExVHR0L0czdjVxMjRp?=
 =?utf-8?B?K0d4dnhzYjVEZmptdzlpWk1jWXBRTURLZmpwbFRVSmZWMjVJNXFlRE1lZS9q?=
 =?utf-8?B?RTVJSis1aXlJYnlPNEFXN1NoNC9lU3N5VFZoL2V0UkpaQW1yNHlPTUpWTUhi?=
 =?utf-8?B?aUZmMlpWSitwaXBJczZRZkdOL1pPQTByZmN4V3JvUUpGemxMNjdOai9yMndw?=
 =?utf-8?B?NExHT3V2dXhCNUpIOGEydksvemhLc0REdjh5eXBQTGl3K0I3MlRCQVZuYjF6?=
 =?utf-8?B?bm5QaXp6Vk91b1NoWW05UTdLTFF4S2YwMkZrdXU1Sm1wZjVNRXRMQXJ2SVdC?=
 =?utf-8?B?dk0wZ0hscFlXN294S1dBMkNSTVFSRWlxOWpRNVprNnUyNGlnZjZwdFFKK1dE?=
 =?utf-8?B?SWFlTElheWNuYUZKdjg4Z2FjdGh3MWhHd1g3R1A4eHYyblZWVGxpdEwwMTRx?=
 =?utf-8?B?cGVra3liVkZMRHh1clJ2L3c2ZndXb1hqMGZreU0xNHBaUGl4SFJzQUNNT3Nm?=
 =?utf-8?B?a2xFcFZWbjdJVmlYVTVuSklHbXIrVjhsTElRbWZwdVZhUG9CYkU3UTQ3SW1F?=
 =?utf-8?B?S0QwczdIY3RFN0hPVkdQTzFyWmE1ZnNlallkK3R1aVJXU2tHK2ZlWi9vckl4?=
 =?utf-8?B?dnI4QS82eWxCM0h2YjNSTzl6MUxyc1RrdE1taXFsWENtRzE0SEMrcldkSytB?=
 =?utf-8?B?VDVJRTduTCsvWHpLMEovdE9IejRYM1Z3Yy82QWo0NUlPU0NUaS9TZXBJclNL?=
 =?utf-8?B?N3V2SUVBQ0VzNXlGOUhZb1FPeDJGZFg1emIzcCs5QkwzSHFtaVlKK3NHSVlm?=
 =?utf-8?B?REc2L3BWTktUZTFqRWlPbDhMVWIwaGRyNm9KTlU3Mm5UeGRuRis0eHRON2VS?=
 =?utf-8?B?d1htSUR2dW5KWEZRSU5ub0FNcHdlVjRJR1duZFplWVBmY280M1ZJSHpBTmVh?=
 =?utf-8?B?NlB0eEZGdTNKTHlBR2REQ21UMFp2dHZBdzNRekgrcm82QUkvL29oQXJMWmJU?=
 =?utf-8?B?V0YydzkrazNobDd3VyszVVk5QzBCd1BONUJtdFZqV3JHUmFFSmo2MWlsWE1P?=
 =?utf-8?B?dGg3MlAzVlFrVTAzNnRuZVV6T0g2eUJsKzdYZWtjNW9RaVFxbG9KVEJJaXBj?=
 =?utf-8?B?cnJtYVNvbzVkZTJxazJYZUUrYkJJVC9OUU9XZ0NrcE5UNnVMRzI4bStNRmQ0?=
 =?utf-8?B?N3BIK2FMOERJOFZvUG9TRFdqaERUOUUxckk4eEhPejJLNEplUDlWeHByZnJF?=
 =?utf-8?B?azg0VG9YZEZ0Y3VOMzFPMkE0QjVKdEtFTmh4S2l2Z2pnejdoUnB0Z1NaN0x1?=
 =?utf-8?B?OVFhYnBCdWtydlZ0Ulk0cnlIYlI5cno2YXIrUk5IZnVkQVgzVjJub0pwWCtx?=
 =?utf-8?B?bGhmQWt1MURXRDRwZFVLWVFodnh3aU1CR3dTL241RmE1RGQ3UllhNmhrS1JG?=
 =?utf-8?Q?TBMPh+fw6skOddu3cttxDhJ+Q?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cda38a05-d14f-4a38-65b7-08dd08085607
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB7141.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2024 19:36:45.5577
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LPVuiDELxfFec2g26GQtyDS8SC+ooKUdRQBitb/O1f014+sJ0NBeGcZskSaRuVbihyjs0hB6v/xpiUsb3Jk8Uw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9419



On 18/11/2024 10:37, Jiri Pirko wrote:
> Sun, Nov 17, 2024 at 09:50:40PM CET, tariqt@nvidia.com wrote:
>> From: Carolina Jubran <cjubran@nvidia.com>
>>
>> Introduce support for specifying bandwidth proportions between traffic
>> classes (TC) in the devlink-rate API. This new option allows users to
>> allocate bandwidth across multiple traffic classes in a single command.
>>
>> This feature provides a more granular control over traffic management,
>> especially for scenarios requiring Enhanced Transmission Selection.
>>
>> Users can now define a specific bandwidth share for each traffic class,
>> such as allocating 20% for TC0 (TCP/UDP) and 80% for TC5 (RoCE).
>>
>> Example:
>> DEV=pci/0000:08:00.0
>>
>> $ devlink port function rate add $DEV/vfs_group tx_share 10Gbit \
>>   tx_max 50Gbit tc-bw 0:20 1:0 2:0 3:0 4:0 5:80 6:0 7:0
>>
>> $ devlink port function rate set $DEV/vfs_group \
>>   tc-bw 0:20 1:0 2:0 3:0 4:0 5:20 6:60 7:0
>>
>> Signed-off-by: Carolina Jubran <cjubran@nvidia.com>
>> Reviewed-by: Cosmin Ratiu <cratiu@nvidia.com>
>> Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
>> ---
>> Documentation/netlink/specs/devlink.yaml | 22 ++++++++
>> include/net/devlink.h                    |  7 +++
>> include/uapi/linux/devlink.h             |  3 +
>> net/devlink/netlink_gen.c                | 14 +++--
>> net/devlink/netlink_gen.h                |  1 +
>> net/devlink/rate.c                       | 71 +++++++++++++++++++++++-
>> 6 files changed, 113 insertions(+), 5 deletions(-)
>>
>> diff --git a/Documentation/netlink/specs/devlink.yaml b/Documentation/netlink/specs/devlink.yaml
>> index 09fbb4c03fc8..fece78ed60fe 100644
>> --- a/Documentation/netlink/specs/devlink.yaml
>> +++ b/Documentation/netlink/specs/devlink.yaml
>> @@ -820,6 +820,19 @@ attribute-sets:
>>        -
>>          name: region-direct
>>          type: flag
>> +      -
>> +        name: rate-tc-bw
>> +        type: u32
>> +        doc: |
>> +             Specifies the bandwidth allocation for the Traffic Class as a
>> +             percentage.
>> +        checks:
>> +          min: 0
>> +          max: 100
>> +      -
>> +        name: rate-tc-bw-values
>> +        type: nest
>> +        nested-attributes: dl-rate-tc-bw-values
> 
> Hmm, it's not a simple nest. It's an array. You probably need something
> like type: indexed-array here. Please make sure you make this working
> with ynl. Could you also please add examples of get and set commands
> using ynl to the patch description?
> 
> 

It seems that type: indexed-array with sub-type: u32 would be the 
correct approach. However, I noticed that this support appears to be 
missing in the ynl-gen-c.py script in this series: 
https://lore.kernel.org/all/20240404063114.1221532-3-liuhangbin@gmail.com/. 
If this is indeed the case, how should I specify the min and max values 
for the u32 entries in the indexed-array?

>>
>>    -
>>      name: dl-dev-stats
>> @@ -1225,6 +1238,13 @@ attribute-sets:
>>        -
>>          name: flash
>>          type: flag
>> +  -
>> +    name: dl-rate-tc-bw-values
>> +    subset-of: devlink
>> +    attributes:
>> +      -
>> +        name: rate-tc-bw
>> +        type: u32
>>
>> operations:
>>    enum-model: directional
>> @@ -2149,6 +2169,7 @@ operations:
>>              - rate-tx-priority
>>              - rate-tx-weight
>>              - rate-parent-node-name
>> +            - rate-tc-bw-values
>>
>>      -
>>        name: rate-new
>> @@ -2169,6 +2190,7 @@ operations:
>>              - rate-tx-priority
>>              - rate-tx-weight
>>              - rate-parent-node-name
>> +            - rate-tc-bw-values
>>
>>      -
>>        name: rate-del
>> diff --git a/include/net/devlink.h b/include/net/devlink.h
>> index fbb9a2668e24..277b826cdd60 100644
>> --- a/include/net/devlink.h
>> +++ b/include/net/devlink.h
>> @@ -20,6 +20,7 @@
>> #include <uapi/linux/devlink.h>
>> #include <linux/xarray.h>
>> #include <linux/firmware.h>
>> +#include <linux/dcbnl.h>
>>
>> struct devlink;
>> struct devlink_linecard;
>> @@ -117,6 +118,8 @@ struct devlink_rate {
>>
>> 	u32 tx_priority;
>> 	u32 tx_weight;
>> +
>> +	u32 tc_bw[IEEE_8021QAZ_MAX_TCS];
>> };
>>
>> struct devlink_port {
>> @@ -1469,6 +1472,8 @@ struct devlink_ops {
>> 					 u32 tx_priority, struct netlink_ext_ack *extack);
>> 	int (*rate_leaf_tx_weight_set)(struct devlink_rate *devlink_rate, void *priv,
>> 				       u32 tx_weight, struct netlink_ext_ack *extack);
>> +	int (*rate_leaf_tc_bw_set)(struct devlink_rate *devlink_rate, void *priv,
>> +				   u32 *tc_bw, struct netlink_ext_ack *extack);
>> 	int (*rate_node_tx_share_set)(struct devlink_rate *devlink_rate, void *priv,
>> 				      u64 tx_share, struct netlink_ext_ack *extack);
>> 	int (*rate_node_tx_max_set)(struct devlink_rate *devlink_rate, void *priv,
>> @@ -1477,6 +1482,8 @@ struct devlink_ops {
>> 					 u32 tx_priority, struct netlink_ext_ack *extack);
>> 	int (*rate_node_tx_weight_set)(struct devlink_rate *devlink_rate, void *priv,
>> 				       u32 tx_weight, struct netlink_ext_ack *extack);
>> +	int (*rate_node_tc_bw_set)(struct devlink_rate *devlink_rate, void *priv,
>> +				   u32 *tc_bw, struct netlink_ext_ack *extack);
>> 	int (*rate_node_new)(struct devlink_rate *rate_node, void **priv,
>> 			     struct netlink_ext_ack *extack);
>> 	int (*rate_node_del)(struct devlink_rate *rate_node, void *priv,
>> diff --git a/include/uapi/linux/devlink.h b/include/uapi/linux/devlink.h
>> index 9401aa343673..0940f8770319 100644
>> --- a/include/uapi/linux/devlink.h
>> +++ b/include/uapi/linux/devlink.h
>> @@ -614,6 +614,9 @@ enum devlink_attr {
>>
>> 	DEVLINK_ATTR_REGION_DIRECT,		/* flag */
>>
>> +	DEVLINK_ATTR_RATE_TC_BW,		/* u32 */
>> +	DEVLINK_ATTR_RATE_TC_BW_VALUES,		/* nested */
> 
> "values" sounds odd. When I look at the rest of the similar nested
> attrs, we use either "S" or "_LIST" as suffix. Also, Please have the
> nested attr first and the u32 as second (again, the rest of the attrs
> have it like that). So something like:
> 
> 	DEVLINK_ATTR_RATE_TC_BWS,		/* nested */
> 	DEVLINK_ATTR_RATE_TC_BW,		/* u32 */
>

Thanks for pointing this out. I'll go with DEVLINK_ATTR_RATE_TC_BWS.
  >> +
>> 	/* Add new attributes above here, update the spec in
>> 	 * Documentation/netlink/specs/devlink.yaml and re-generate
>> 	 * net/devlink/netlink_gen.c.
>> diff --git a/net/devlink/netlink_gen.c b/net/devlink/netlink_gen.c
>> index f9786d51f68f..231c2752538f 100644
>> --- a/net/devlink/netlink_gen.c
>> +++ b/net/devlink/netlink_gen.c
>> @@ -18,6 +18,10 @@ const struct nla_policy devlink_dl_port_function_nl_policy[DEVLINK_PORT_FN_ATTR_
>> 	[DEVLINK_PORT_FN_ATTR_CAPS] = NLA_POLICY_BITFIELD32(15),
>> };
>>
>> +const struct nla_policy devlink_dl_rate_tc_bw_values_nl_policy[DEVLINK_ATTR_RATE_TC_BW + 1] = {
>> +	[DEVLINK_ATTR_RATE_TC_BW] = NLA_POLICY_RANGE(NLA_U32, 0, 100),
>> +};
>> +
>> const struct nla_policy devlink_dl_selftest_id_nl_policy[DEVLINK_ATTR_SELFTEST_ID_FLASH + 1] = {
>> 	[DEVLINK_ATTR_SELFTEST_ID_FLASH] = { .type = NLA_FLAG, },
>> };
>> @@ -496,7 +500,7 @@ static const struct nla_policy devlink_rate_get_dump_nl_policy[DEVLINK_ATTR_DEV_
>> };
>>
>> /* DEVLINK_CMD_RATE_SET - do */
>> -static const struct nla_policy devlink_rate_set_nl_policy[DEVLINK_ATTR_RATE_TX_WEIGHT + 1] = {
>> +static const struct nla_policy devlink_rate_set_nl_policy[DEVLINK_ATTR_RATE_TC_BW_VALUES + 1] = {
>> 	[DEVLINK_ATTR_BUS_NAME] = { .type = NLA_NUL_STRING, },
>> 	[DEVLINK_ATTR_DEV_NAME] = { .type = NLA_NUL_STRING, },
>> 	[DEVLINK_ATTR_RATE_NODE_NAME] = { .type = NLA_NUL_STRING, },
>> @@ -505,10 +509,11 @@ static const struct nla_policy devlink_rate_set_nl_policy[DEVLINK_ATTR_RATE_TX_W
>> 	[DEVLINK_ATTR_RATE_TX_PRIORITY] = { .type = NLA_U32, },
>> 	[DEVLINK_ATTR_RATE_TX_WEIGHT] = { .type = NLA_U32, },
>> 	[DEVLINK_ATTR_RATE_PARENT_NODE_NAME] = { .type = NLA_NUL_STRING, },
>> +	[DEVLINK_ATTR_RATE_TC_BW_VALUES] = NLA_POLICY_NESTED(devlink_dl_rate_tc_bw_values_nl_policy),
>> };
>>
>> /* DEVLINK_CMD_RATE_NEW - do */
>> -static const struct nla_policy devlink_rate_new_nl_policy[DEVLINK_ATTR_RATE_TX_WEIGHT + 1] = {
>> +static const struct nla_policy devlink_rate_new_nl_policy[DEVLINK_ATTR_RATE_TC_BW_VALUES + 1] = {
>> 	[DEVLINK_ATTR_BUS_NAME] = { .type = NLA_NUL_STRING, },
>> 	[DEVLINK_ATTR_DEV_NAME] = { .type = NLA_NUL_STRING, },
>> 	[DEVLINK_ATTR_RATE_NODE_NAME] = { .type = NLA_NUL_STRING, },
>> @@ -517,6 +522,7 @@ static const struct nla_policy devlink_rate_new_nl_policy[DEVLINK_ATTR_RATE_TX_W
>> 	[DEVLINK_ATTR_RATE_TX_PRIORITY] = { .type = NLA_U32, },
>> 	[DEVLINK_ATTR_RATE_TX_WEIGHT] = { .type = NLA_U32, },
>> 	[DEVLINK_ATTR_RATE_PARENT_NODE_NAME] = { .type = NLA_NUL_STRING, },
>> +	[DEVLINK_ATTR_RATE_TC_BW_VALUES] = NLA_POLICY_NESTED(devlink_dl_rate_tc_bw_values_nl_policy),
>> };
>>
>> /* DEVLINK_CMD_RATE_DEL - do */
>> @@ -1164,7 +1170,7 @@ const struct genl_split_ops devlink_nl_ops[74] = {
>> 		.doit		= devlink_nl_rate_set_doit,
>> 		.post_doit	= devlink_nl_post_doit,
>> 		.policy		= devlink_rate_set_nl_policy,
>> -		.maxattr	= DEVLINK_ATTR_RATE_TX_WEIGHT,
>> +		.maxattr	= DEVLINK_ATTR_RATE_TC_BW_VALUES,
>> 		.flags		= GENL_ADMIN_PERM | GENL_CMD_CAP_DO,
>> 	},
>> 	{
>> @@ -1174,7 +1180,7 @@ const struct genl_split_ops devlink_nl_ops[74] = {
>> 		.doit		= devlink_nl_rate_new_doit,
>> 		.post_doit	= devlink_nl_post_doit,
>> 		.policy		= devlink_rate_new_nl_policy,
>> -		.maxattr	= DEVLINK_ATTR_RATE_TX_WEIGHT,
>> +		.maxattr	= DEVLINK_ATTR_RATE_TC_BW_VALUES,
>> 		.flags		= GENL_ADMIN_PERM | GENL_CMD_CAP_DO,
>> 	},
>> 	{
>> diff --git a/net/devlink/netlink_gen.h b/net/devlink/netlink_gen.h
>> index 8f2bd50ddf5e..a8f0f20f6f0b 100644
>> --- a/net/devlink/netlink_gen.h
>> +++ b/net/devlink/netlink_gen.h
>> @@ -13,6 +13,7 @@
>>
>> /* Common nested types */
>> extern const struct nla_policy devlink_dl_port_function_nl_policy[DEVLINK_PORT_FN_ATTR_CAPS + 1];
>> +extern const struct nla_policy devlink_dl_rate_tc_bw_values_nl_policy[DEVLINK_ATTR_RATE_TC_BW + 1];
>> extern const struct nla_policy devlink_dl_selftest_id_nl_policy[DEVLINK_ATTR_SELFTEST_ID_FLASH + 1];
>>
>> /* Ops table for devlink */
>> diff --git a/net/devlink/rate.c b/net/devlink/rate.c
>> index 8828ffaf6cbc..4eb0598d40f9 100644
>> --- a/net/devlink/rate.c
>> +++ b/net/devlink/rate.c
>> @@ -86,7 +86,9 @@ static int devlink_nl_rate_fill(struct sk_buff *msg,
>> 				int flags, struct netlink_ext_ack *extack)
>> {
>> 	struct devlink *devlink = devlink_rate->devlink;
>> +	struct nlattr *nla_tc_bw;
>> 	void *hdr;
>> +	int i;
>>
>> 	hdr = genlmsg_put(msg, portid, seq, &devlink_nl_family, flags, cmd);
>> 	if (!hdr)
>> @@ -129,6 +131,19 @@ static int devlink_nl_rate_fill(struct sk_buff *msg,
>> 				   devlink_rate->parent->name))
>> 			goto nla_put_failure;
>>
>> +	nla_tc_bw = nla_nest_start(msg, DEVLINK_ATTR_RATE_TC_BW_VALUES);
>> +	if (!nla_tc_bw)
>> +		goto nla_put_failure;
>> +
>> +	for (i = 0; i < IEEE_8021QAZ_MAX_TCS; i++) {
>> +		if (nla_put_u32(msg, DEVLINK_ATTR_RATE_TC_BW, devlink_rate->tc_bw[i])) {
>> +			nla_nest_cancel(msg, nla_tc_bw);
>> +			goto nla_put_failure;
>> +		}
>> +	}
>> +
>> +	nla_nest_end(msg, nla_tc_bw);
>> +
>> 	genlmsg_end(msg, hdr);
>> 	return 0;
>>
>> @@ -316,11 +331,46 @@ devlink_nl_rate_parent_node_set(struct devlink_rate *devlink_rate,
>> 	return 0;
>> }
>>
>> +static int devlink_nl_rate_tc_bw_set(struct devlink_rate *devlink_rate,
>> +				     struct genl_info *info,
>> +				     struct nlattr *nla_tc_bw)
>> +{
>> +	struct devlink *devlink = devlink_rate->devlink;
>> +	const struct devlink_ops *ops = devlink->ops;
>> +	u32 tc_bw[IEEE_8021QAZ_MAX_TCS] = {0};
> 
> You don't need 0 between brackets.
>

I will drop this, thanks.

> 
>> +	struct nlattr *nla_tc_entry;
>> +	int rem, err = 0, i = 0;
>> +
>> +	nla_for_each_nested(nla_tc_entry, nla_tc_bw, rem) {
>> +		if (i >= IEEE_8021QAZ_MAX_TCS || nla_type(nla_tc_entry) != DEVLINK_ATTR_RATE_TC_BW)
> 
> Fill up an extack message with proper reasoning.
> 
> 
>> +			return -EINVAL;
>> +
>> +		tc_bw[i++] = nla_get_u32(nla_tc_entry);
>> +	}
>> +
>> +	if (i != IEEE_8021QAZ_MAX_TCS)
>> +		return -EINVAL;
>> +
>> +	if (devlink_rate_is_leaf(devlink_rate))
>> +		err = ops->rate_leaf_tc_bw_set(devlink_rate, devlink_rate->priv, tc_bw,
>> +					       info->extack);
>> +	else if (devlink_rate_is_node(devlink_rate))
>> +		err = ops->rate_node_tc_bw_set(devlink_rate, devlink_rate->priv, tc_bw,
>> +					       info->extack);
>> +
>> +	if (err)
>> +		return err;
>> +
>> +	memcpy(devlink_rate->tc_bw, tc_bw, sizeof(tc_bw));
>> +
>> +	return 0;
>> +}
>> +
>> static int devlink_nl_rate_set(struct devlink_rate *devlink_rate,
>> 			       const struct devlink_ops *ops,
>> 			       struct genl_info *info)
>> {
>> -	struct nlattr *nla_parent, **attrs = info->attrs;
>> +	struct nlattr *nla_parent, *nla_tc_bw, **attrs = info->attrs;
>> 	int err = -EOPNOTSUPP;
>> 	u32 priority;
>> 	u32 weight;
>> @@ -380,6 +430,13 @@ static int devlink_nl_rate_set(struct devlink_rate *devlink_rate,
>> 		devlink_rate->tx_weight = weight;
>> 	}
>>
>> +	nla_tc_bw = attrs[DEVLINK_ATTR_RATE_TC_BW_VALUES];
>> +	if (nla_tc_bw) {
>> +		err = devlink_nl_rate_tc_bw_set(devlink_rate, info, nla_tc_bw);
>> +		if (err)
>> +			return err;
>> +	}
>> +
>> 	nla_parent = attrs[DEVLINK_ATTR_RATE_PARENT_NODE_NAME];
>> 	if (nla_parent) {
>> 		err = devlink_nl_rate_parent_node_set(devlink_rate, info,
>> @@ -423,6 +480,12 @@ static bool devlink_rate_set_ops_supported(const struct devlink_ops *ops,
>> 					    "TX weight set isn't supported for the leafs");
>> 			return false;
>> 		}
>> +		if (attrs[DEVLINK_ATTR_RATE_TC_BW_VALUES] && !ops->rate_leaf_tc_bw_set) {
>> +			NL_SET_ERR_MSG_ATTR(info->extack,
>> +					    attrs[DEVLINK_ATTR_RATE_TC_BW_VALUES],
>> +					    "TC bandwidth set isn't supported for the leafs");
>> +			return false;
>> +		}
>> 	} else if (type == DEVLINK_RATE_TYPE_NODE) {
>> 		if (attrs[DEVLINK_ATTR_RATE_TX_SHARE] && !ops->rate_node_tx_share_set) {
>> 			NL_SET_ERR_MSG(info->extack, "TX share set isn't supported for the nodes");
>> @@ -449,6 +512,12 @@ static bool devlink_rate_set_ops_supported(const struct devlink_ops *ops,
>> 					    "TX weight set isn't supported for the nodes");
>> 			return false;
>> 		}
>> +		if (attrs[DEVLINK_ATTR_RATE_TC_BW_VALUES] && !ops->rate_node_tc_bw_set) {
>> +			NL_SET_ERR_MSG_ATTR(info->extack,
>> +					    attrs[DEVLINK_ATTR_RATE_TC_BW_VALUES],
>> +					    "TC bandwidth set isn't supported for the nodes");
>> +			return false;
>> +		}
>> 	} else {
>> 		WARN(1, "Unknown type of rate object");
>> 		return false;
>> -- 
>> 2.44.0
>>


