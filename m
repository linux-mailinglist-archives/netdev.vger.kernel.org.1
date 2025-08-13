Return-Path: <netdev+bounces-213414-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 913B8B24E57
	for <lists+netdev@lfdr.de>; Wed, 13 Aug 2025 17:56:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0CD781C24014
	for <lists+netdev@lfdr.de>; Wed, 13 Aug 2025 15:49:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68E502BDC1D;
	Wed, 13 Aug 2025 15:42:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kontron.de header.i=@kontron.de header.b="EpmGY2a/"
X-Original-To: netdev@vger.kernel.org
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11021105.outbound.protection.outlook.com [40.107.130.105])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A07E29BDB1
	for <netdev@vger.kernel.org>; Wed, 13 Aug 2025 15:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.105
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755099748; cv=fail; b=bF3GN+5CgGvsXqtW9oIlUknb3LcLW5UeJSE5hcfdDzv6le4x/KHoVJLn6xLE/xFtYmTRBo6Yrn3M0NBCbqGlRBjhmEi9tHA5zfvCpdmBnu3PdbtUQC3dyg+ZkHrOyH7/K1DJiDob/7JKpEIjJQcZ+e2sFJuZR4+q7TtkA3OLpec=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755099748; c=relaxed/simple;
	bh=pGxL1Pp5z7U6H4hOc8hXyALD2bK3mA1oAsHkTP4noPM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=PXyz2WObgsyLDPnpn+SDS7jIe5wpewuBEnusQFq+Ufsfp7dehM92qsOs+nixYFr7OrtcM2zugI8m4HChwG+qhhtJqhYClOjwAB15v+9HynGyXrg10FPbpv1PitvhMykwOpB+RDzBDwRkFKwFtX5ZwTU+Wer2SSJZTPkgBDhhszk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kontron.de; spf=pass smtp.mailfrom=kontron.de; dkim=pass (2048-bit key) header.d=kontron.de header.i=@kontron.de header.b=EpmGY2a/; arc=fail smtp.client-ip=40.107.130.105
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kontron.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kontron.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Y4qSrkk1aCU99tE3fglsQuQd6bZgI7trbJ7rwxejNPfGv34CMRSLhzVuWmQBOfm8T8IaByy4Fmf+YAbbes9bEchqr+OEXADoqwc/bsJIzeNDtGDFDVgahyUR4BTT/bLreJe3RYyS4eu7WS5LIytc0he28JjS15/q7kBpwCj91aXAtMMA5vPb9X5jrmt6GakB1l5GeXs0RYN0tAHUfh1zRpfXjes5BOphdtvZG9DibBkM1Zvvoiio7sZ8/31pcaVA8FtmB9T4YbDPNdkxiZhIrEemOP201TNhkOttGBVLLT3MEbU0rwIb1SqAkeuCqZQ/1xS7kTpILfXrIXL1AMOPrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PG9B5d4zI4brn3lsTPNsMq6hbG4p26BXPuIRDlQsYHU=;
 b=DRGaJdlONEMHTBWd7LjkUJx9DY8k4MBR0maQxHdvV8hMzMI4uqU25T8xgYxdRJBCF86AzML6dLwyCNg6t7GxIzLvwwOCwcywKMo1iNhfp+2Z706U0p9tcHLS5ODiYfLu9qBWunbhnsOW3TB8hV/YT+TMlF8dSrt/AEG/etKYhi0sP0WiDtVDTBXjCAIYhdCOJADZItlU9VkwRn73oWdtXExq/i5HVaDWzfYGIeACeYHmdNaQfBjs6t5sBHaC0onGYgSqfq906K4IUfwJfLit0g+wWThHjxCl9Ljh8wCmVBt1FEbbzwgn42aE7SArr+RT9gfYo1DIGRGpYIDhKQUBUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kontron.de; dmarc=pass action=none header.from=kontron.de;
 dkim=pass header.d=kontron.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kontron.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PG9B5d4zI4brn3lsTPNsMq6hbG4p26BXPuIRDlQsYHU=;
 b=EpmGY2a/fA1DLVz7PswM3dCaCz3HXOElS2eeOuJg6ndsH4C/RA0D47QIr0zF+tMtH40KzuyfglyayIotixEBu3zXA/Ee9Lhbxt9HmBMLJgFIyWm3zpEsffxVQo16+D3UQcU5ii608apmNExbZkeo76OG8Ady8K8JswxyFFursrYXPXSt878srg4iNwePwR/4+U3pl1QHqrHCv3lQi8ZGNuzQm6uXBWVXTauyNhGzr/qt3zCO10eNtN+Ccx9ER9iXGWl67uNmte8mA6hVYDErCIRuGJAXj+7TMB980u75YH52APJ/0PLK/ODN9iOAMK9dMgNmzVZvS9guCWa7T4+ntg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kontron.de;
Received: from PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:263::10)
 by DU0PR10MB7566.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:402::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.15; Wed, 13 Aug
 2025 15:42:22 +0000
Received: from PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::b854:7611:1533:2a19]) by PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::b854:7611:1533:2a19%4]) with mapi id 15.20.9009.013; Wed, 13 Aug 2025
 15:42:21 +0000
Message-ID: <6fd57ef6-b018-4d08-9914-38d4f089d313@kontron.de>
Date: Wed, 13 Aug 2025 17:42:19 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: KSZ9477 HSR Offloading
To: =?UTF-8?Q?=C5=81ukasz_Majewski?= <lukma@nabladev.com>
Cc: Woojung.Huh@microchip.com, kuba@kernel.org, andrew@lunn.ch,
 netdev@vger.kernel.org, Tristram.Ha@microchip.com
References: <05a6e63e-96c1-4d78-91b9-b00deed044b5@kontron.de>
 <6d0e1f47-874e-42bf-9bc7-34856c1168d1@lunn.ch>
 <1c140c92-3be6-4917-b600-fa5d1ef96404@kontron.de>
 <6400e73a-b165-41a8-9fc9-e2226060a68c@kontron.de>
 <20250129121733.1e99f29c@wsk>
 <0383e3d9-b229-4218-a931-73185d393177@kontron.de>
 <20250129145845.3988cf04@wsk>
 <42a2f96f-34cd-4d95-99d5-3b4c4af226af@kontron.de>
 <BL0PR11MB2913C7E1AE86A3A0EB12D0D7E7EE2@BL0PR11MB2913.namprd11.prod.outlook.com>
 <1400a748-0de7-4093-a549-f07617e6ac51@kontron.de>
 <BL0PR11MB29130BB177996C437F792106E7E92@BL0PR11MB2913.namprd11.prod.outlook.com>
 <20250203103113.27e3060a@wsk>
 <1edbe1e4-9491-4344-828d-4c3b73954e8a@kontron.de>
 <BL0PR11MB2913B949D05B9BB73108A5FFE7F52@BL0PR11MB2913.namprd11.prod.outlook.com>
 <20250203150418.7f244827@kernel.org>
 <BL0PR11MB2913ECAA6F0C97E342F7DE22E7F42@BL0PR11MB2913.namprd11.prod.outlook.com>
 <8e761c31-728c-4ff7-925a-5e16a9ef1310@kontron.de>
 <20250813155452.55c4eb81@wsk>
Content-Language: en-US, de-DE
From: Frieder Schrempf <frieder.schrempf@kontron.de>
In-Reply-To: <20250813155452.55c4eb81@wsk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0132.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b9::10) To PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:263::10)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR10MB5681:EE_|DU0PR10MB7566:EE_
X-MS-Office365-Filtering-Correlation-Id: 94ef6c75-7a89-497b-15b1-08ddda7ffe0c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?K3BSeUVrcWJla0ZnZnZtMCt0ckw5SEsxUW8zSUJ1c1Jna3gxU0NrZHVtNzMz?=
 =?utf-8?B?dEE3V2FNZW9aWEVENlZoRkxWSllKQjBsSjFIdDNNOGthbUNxa0tsbDVTZ3BH?=
 =?utf-8?B?b2s0SXNheW9ncDZKQTVBcWhJdWgrNjJOakNSM2xkc3Z5RHdQaHBPbDg1Z0FU?=
 =?utf-8?B?dHI1bzQ1dHA0VUFHUnIyUkNlY2lhbC8vSkZxa1poa3FlcWNCdHowc2kySkEw?=
 =?utf-8?B?YTRkZElKdk1yWVFQbWg5VUJETlgzblBwMzF6MDRZRHhidXAyS0liRlJZU2c0?=
 =?utf-8?B?bnJnMjByamswdk11YWxaMGlsN1pGaTdaelB5bGxGTm5ORFc1bkFtcTVLVlVq?=
 =?utf-8?B?cllVNGlySjZLRFU1NEhRUko3bXFObjV4dXZpSVIrU1VBbDBON2dBbUZMU0w3?=
 =?utf-8?B?czhjQWxXNkxQTjd5V28zNW44K2twZnEvNG9JVFZuUG9NdVU4aUl4N05xeTBa?=
 =?utf-8?B?TUtabzFVNVpQMS8ranVQK0dNdFVLYk9LYW9XZ2NtUlByZG5vRTIwYkpHckVC?=
 =?utf-8?B?T3JhNk15UUNXSVhGTXFpa1FueGU5TDhXWHlISWloRVk5RDhwYlpCK0ZOei9t?=
 =?utf-8?B?MmpIVDF5RzA1Wm4xdk1kd0c2TUtEcFNWMkwyTmcvY2pZQWR3cWxUelpsWjBl?=
 =?utf-8?B?R1Z2Mm1ieWxCQURTNUcvMG42NjBBS1p6UnFGcVQrQk12VW9kVmZLai9hRGZF?=
 =?utf-8?B?dVluV3JMWmVzamFZK2UxVHBnc3M1aG1aZ3BKV3YzZE5ja3dyVE55blBleG5a?=
 =?utf-8?B?c0FmN2xLRWJabUdLWk5reXBlR1VlUXNud3JtTWcxeEx0SEsrOHBCdlpTRWJY?=
 =?utf-8?B?c0ltUHFuWU9kKy84b1J1Zk05NW9UbFlGZ0U0dWJDL3ZILzExUWNQU3JjSHpH?=
 =?utf-8?B?TDg2dWZ0R0JrVXBxWVJCSm40ckRTYmtMdldLSnlmSk92WmMrNHYyczRTTVIx?=
 =?utf-8?B?UFQxZjZka3BrbHY2d1d6ZUNrYnpwNFRKRjMvdHVvNGJPdGlpNFBwaFMrMUp4?=
 =?utf-8?B?MFBLOXRHdk9kcHNiYWNYV3UrcDM1NFNLdmFRRGh0S0QvVWlvQldpdXVCUEQv?=
 =?utf-8?B?elpEam9hQkxvUEtaQit4YTg5NWlmbExmc1NSempuTjlqcGRQME1LMWV5SGUz?=
 =?utf-8?B?YkY1bGIwelBjR2xQbEFrcUlZZUQ4UitqejJnOTlLSlJRZ0F3dHhIZHBMMDJ4?=
 =?utf-8?B?MlkwT3I4WTQ4bHd4K1NMTDBUSGwrQ2s3bmZ3RVJDZytEcWsvbUdKdWIveTNt?=
 =?utf-8?B?UlVSYWhFTW03ZmJidlhuWWtDVXZMTW52SWZwL2FhVDZYcUJTV3BOcGVhcFkz?=
 =?utf-8?B?WnFacEIrZk1iTGQ0eFJyQ09KdE9OTVIxYUo3VmhaOU51NVNTNUJyNXJOQW1m?=
 =?utf-8?B?WjdIY05UWUNOb0NxaGMvM20waVA2YWRPTkZneHVsY29aNzEza2ZCbEQ5WVdJ?=
 =?utf-8?B?RDVLTzZIc0RUalJ4SjZZRE9QS2RUK1NybHZvMEVSdFFRVGxwVUVnNytkZUNF?=
 =?utf-8?B?aVhQdFd0ZXBKQVhCbUFVangrWHhnVUtzQUxxUGtyRm5LenVJRmFFUXNmRCtw?=
 =?utf-8?B?WGNnOXpxYWU4MzBudHNscmVRNlBhazJFZzNZbTBBdXFJcEZBWkRiY0laZE5s?=
 =?utf-8?B?NXJsK0kwOXk4U3k0cTd2UHRxOXJ2NWFzNkhmajA2SW83TnU0NWErZS9JaEtQ?=
 =?utf-8?B?cGhMYkxhY2FUUE56M20zSkpUYnErV3VId2U0OTZvdWw4K1g1dFp6T01YSlpN?=
 =?utf-8?B?MnJJV1Zva3JaTTYvZmxkMlorT2ZTdlVlU2xIWUtZT2RTTFdaQ3BNN0pCakU0?=
 =?utf-8?B?S09iMkV0S2hGTkZSUDd6VkJiZHNXY1JwQzZtbUMxNHFNU2tVa1Y5djk1R3BF?=
 =?utf-8?B?elczdU5IYU9NdHFZNTJ3RHlnV3JhaTdDM0h2UW9CWXNEVWd1WTFWd0o5RXMw?=
 =?utf-8?Q?/WzUNXpzlBA=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ODBIRkdCZWc1NW4zUjI0OGwvbWFTUVd6NHlVc3ZlVVhlVmhQYTM5SDFtMmR4?=
 =?utf-8?B?UDRQQU1JWEF4cFBFdVVubFY1dkhuU05TQVZobnlUaGxZSUMxSWtEME1DZXo1?=
 =?utf-8?B?bkF2YklWVmtzNUkwcEI3Y3duK2FBNzdqRjBqWC83THFHRHcveFhzdDdrd2Fh?=
 =?utf-8?B?MkFVY09iVzlzZ0NBNEFreFlyNithaVJEOENmdHJjZjZtcmtkM3NCY1ljcXNI?=
 =?utf-8?B?Mlkwc0x1dVdjT05NRTZHWHViZmdTcC9sL1pLM1cyMjltb2dPZjNmS0EyVEps?=
 =?utf-8?B?L28zMVZVRjVVaitZRVZmQWNnaTdrS3ZpTk92VFE3cnVaWGptS1BTNHkwOG9L?=
 =?utf-8?B?MXQrTWl1aDdEZnN6NCtTZS9NZHQrbXlxb25HQzFPbFBKTXRGdUpGWWxoc3Uv?=
 =?utf-8?B?RHdxWDhBem5oc3BlQ01WV0FRdEE2Slk4RVdweWhKMTlDYUM1MmJXeERPRitm?=
 =?utf-8?B?Q2RDbVFrekZ4MzRpK2ZRNC9JUk1MUzdWdG1QQzNRT3B3eWE5SEFQaWRvb2xa?=
 =?utf-8?B?SzkxVEVXeUxxMS9yNndVYzhlV0JINVVHWVNBdERFOFoxTHVyUkQreXNDMmJ4?=
 =?utf-8?B?Rmg0YjJqcXcxbFVuSzJCaHl3eUpDRjY2Rm5UVGtaUFBRcTA3V0JQTWZLK0Vq?=
 =?utf-8?B?alFBTEllbDlXaHMvdW1tT0JuRS95K1B3bDIyVDFxWUhSajlCMG1oU3B4VVoy?=
 =?utf-8?B?d0EyUTkrSmhkVWtObEdDQXZYUkxzQU1MakdUY09BRC9HK2FydjNaaVZjSEhs?=
 =?utf-8?B?Z29qVWV2c0RFcWF5dGJOYmFVc25mdXVWU0djYnJmZHFPL0c5UXlkTnMyYm5p?=
 =?utf-8?B?aXpiZnU1a1h5OUNHVHNXSDJKNm9zbitjeXZPcVBnU2todGZPcWlNNzdXRS9E?=
 =?utf-8?B?REhTL2VvN09NcWt3SWJWY3RPaVpES1M1TWtwTHB6cFUvdFFpVUYvb1pqL1Y3?=
 =?utf-8?B?NFJPbnVhKy9wdlVkekd1dENGdVV6Z1hEajBrdVg4ZGdpS2M4VDVoVS9pak5N?=
 =?utf-8?B?eDVDQXkycThQa2NOT0FucCsxeFZjaGF0QzFhZ1ZtNG1XSDljYjlPZDB5eU5o?=
 =?utf-8?B?bUVQVjhyb3JtSTh4aWxEdVhucnpJNVVMcWdTVkgyMTdvdFdRVkpUazNjUURF?=
 =?utf-8?B?ejN5U0U4bnN3blk1dytGR3FqUUsya2tJS2tmd2NUcy8vd2RuaTI5SndUYlBQ?=
 =?utf-8?B?STI2eUcvSHNmeDAzOXhUdXF0S0k0RHlwWXk4dWY4aTdBODJMSldkaEJqLytQ?=
 =?utf-8?B?bEJUMHAvREpwanAvczljM2JueThjcGgwbm4xamxyanpqNmlwa2puZHVOOEhr?=
 =?utf-8?B?dFJzZ2dma0U3V29MMVhpYmtZb0dQOWpLNkI0VXpxWEt0WFY5SVRadnJwNVQx?=
 =?utf-8?B?bmlFRzVJYXFDSVordExCa1VvNUxvRUorRmlDaUlaRC83bG9jWDlQTnZoeEdP?=
 =?utf-8?B?aFRxYkpacWtwZXBrc0FJaDBCWXY2RGxZeHg4VVZ2MFhmaFlHOW05azRpZHJQ?=
 =?utf-8?B?cWZhNGdiRUZqcFZDUXZUTEZ1SnVaOXh2RkVpdS9VL1JoR0NzTlZMUHJmWXNL?=
 =?utf-8?B?ak9PNFFtOGNZREZhemNWV1BaTExRemVDaGEwT29ONDhDUnZueENvY1VPV3JN?=
 =?utf-8?B?Ym0wdWlQNUFjOVpxYjVrRjFOMDU3dHdGQ0c4K2VRWldWNnFVZGYyS0F5bXRV?=
 =?utf-8?B?dkNmN3R1MGg4ejJzOVJ0dXl4cW1mWjlrdWxXVDZ4ZWwyZWJjY3NMaDNnWits?=
 =?utf-8?B?dlRUem82WDRpZE9TRTU3ZXlxc3pIczNqNGZEb1NCanhXdXB5ZHJjbTc3ZlBF?=
 =?utf-8?B?RFhhalJ5NXBHTGNBS21nMy9TbkNCUXBtbkNhRFBzZWYzMWVCYU9MTEFjWHo5?=
 =?utf-8?B?MWM2Qm1vSitkOHFWdlNIcXdNY0ZKWjBFRWdkUXpza25UL3U2SlBqZWovYzd6?=
 =?utf-8?B?L2ZZQ3hHRDZUNUp6bnZvQmxSVEFvc1ZSNzQ4N0VRRWEwbVZSS0RzY2V0anRZ?=
 =?utf-8?B?VWVzQzJ0U2Z0dkFnNXloK3hvNlptRXVOWkJIai9ldXlDNmZhZlEramNZelBS?=
 =?utf-8?B?c2Zlams5R05iMVJkTXkrNzNGbGJxS08wdlpqT0FxZnpVTC9PbWVBSmJCZ2xl?=
 =?utf-8?B?amZZSDE0WGllZjE0T0IwWGlTYzBMaWRSU0VKR3Vhano0QUFPaUtkeFQ2NlBY?=
 =?utf-8?B?UXc9PQ==?=
X-OriginatorOrg: kontron.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 94ef6c75-7a89-497b-15b1-08ddda7ffe0c
X-MS-Exchange-CrossTenant-AuthSource: PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2025 15:42:21.5494
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8c9d3c97-3fd9-41c8-a2b1-646f3942daf1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2x8aTI1E1mAl1Vi5q4H8IOh5oFh+H7r7flDPUNjdmHyEmHlF++Y3UZ4dsaPgWdqsJeUY77DL0aERgn/eK9UGr71garpEVtLQYOc8JyNjcs4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB7566

Hi Lukasz,

Am 13.08.25 um 15:54 schrieb Łukasz Majewski:
> [Sie erhalten nicht h?ufig E-Mails von lukma@nabladev.com. Weitere Informationen, warum dies wichtig ist, finden Sie unter https://aka.ms/LearnAboutSenderIdentification ]
> 
> Hi Frieder,
> 
>> Am 04.02.25 um 15:55 schrieb Woojung.Huh@microchip.com:
>>> Hi Jakub,
>>>
>>>> -----Original Message-----
>>>> From: Jakub Kicinski <kuba@kernel.org>
>>>> Sent: Monday, February 3, 2025 6:04 PM
>>>> To: Woojung Huh - C21699 <Woojung.Huh@microchip.com>
>>>> Cc: frieder.schrempf@kontron.de; lukma@denx.de; andrew@lunn.ch;
>>>> netdev@vger.kernel.org; Tristram Ha - C24268
>>>> <Tristram.Ha@microchip.com> Subject: Re: KSZ9477 HSR Offloading
>>>>
>>>> EXTERNAL EMAIL: Do not click links or open attachments unless you
>>>> know the content is safe
>>>>
>>>> On Mon, 3 Feb 2025 14:58:12 +0000 Woojung.Huh@microchip.com wrote:
>>>>
>>>>> Hi Lukasz & Frieder,
>>>>>
>>>>> Oops! My bad. I confused that Lukasz was filed a case originally.
>>>>> Monday
>>>> brain-freeze. :(
>>>>>
>>>>> Yes, it is not a public link and per-user case. So, only Frieder
>>>>> can see
>>>> it.
>>>>> It may be able for you when Frieder adds you as a team. (Not
>>>>> tested
>>>> personally though)
>>>>
>>>> Woojung Huh, please make sure the mailing list is informed about
>>>> the outcomes. Taking discussion off list to a closed ticketing
>>>> system is against community rules. See below, thanks.
>>>>
>>>> Quoting documentation:
>>>>
>>>>   Open development
>>>>   ----------------
>>>>
>>>>   Discussions about user reported issues, and development of new
>>>> code should be conducted in a manner typical for the larger
>>>> subsystem. It is common for development within a single company to
>>>> be conducted behind closed doors. However, development and
>>>> discussions initiated by community members must not be redirected
>>>> from public to closed forums or to private email conversations.
>>>> Reasonable exceptions to this guidance include discussions about
>>>> security related issues.
>>>>
>>>> See:
>>>> https://www.kernel.org/doc/html/next/maintainer/feature-and-driver-maintainers.html#open-development
>>>>
>>>
>>> Learn new thing today. Didn't know this. Definitely I will share it
>>> when this work is done. My intention was for easier work for
>>> request than having me as an middleman for the issue.
>>
>> Here is a follow-up for this thread. I was busy elsewhere, didn't have
>> access to the hardware and failed to respond to the comments from
>> Microchip support team provided in their internal ticket system.
>>
>> As a summary, the Microchip support couldn't reproduce my issue on
>> their side and asked for further information.
>>
>> With the hardware now back on my table I was able to do some further
>> investigations and found out that this is caused by a misconfiguration
>> on my side, that doesn't get handled/prevented by the kernel.
> 
> If I remember correctly from the ticket - there was also an issue with
> the size of MTU for HSR packets.
> 
> Am I correct?

The Microchip support mentioned the following:

###
Note the default MTU of hsr0 is (1500 - 6) = 1494. When other HSR node
is used the MTU needs to match. The HSR driver code checks the MTU of
the underneath device to see if it should be lowered. Even that device
can send more than 1506 bytes the value still is fixed at 1500 and then
decreased by 6. In my opinion that should be changed to start 1506 and
then lower to 1500 if the lower device cannot send that. The RedBox
operation also will be impacted if the MTU 1494 is used as the devices
behind the Redbox all uses MTU 1500
###

So far I didn't run into any issues related to MTU, but I might stumble
upon this in the future.

> 
>>
>> The HW forwarding between HSR ports is configured in
>> ksz9477_hsr_join() at the time of creating the HSR interface by
>> calling ksz9477_cfg_port_member().
>>
>> In my case I enabled the ports **after** that which caused the
>> forwarding to be disabled again as ksz9477_cfg_port_member() gets
>> called with the default configuration.
>>
>> If I reorder my commands everything seems to work fine even with
>> NETIF_F_HW_HSR_FWD enabled.
>>
>> I wonder if the kernel should handle this case and prevent the
>> forwarding configuration to be disabled if HSR is configured? I'll
>> have a look if I can come up with a patch for this.
>>
> 
> Thanks  for looking for this issue. I'm looking forward for your
> patches.

I came up with [1] which fixes the issue that I was seeing. I hope that
this goes into the right direction.

Thanks
Frieder

[1]
https://patchwork.kernel.org/project/netdevbpf/patch/20250813152615.856532-1-frieder@fris.de/

