Return-Path: <netdev+bounces-146572-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EBB39D4678
	for <lists+netdev@lfdr.de>; Thu, 21 Nov 2024 05:10:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B97CE283974
	for <lists+netdev@lfdr.de>; Thu, 21 Nov 2024 04:10:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F12674068;
	Thu, 21 Nov 2024 04:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="Z6Xe5RS4"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2071.outbound.protection.outlook.com [40.107.92.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 618B62309B6;
	Thu, 21 Nov 2024 04:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732162205; cv=fail; b=JbN3HcRlP70vA0I4bJfBf3qJYzyHYwDZK6pLrZoTPWutGHx9M6SMU7jWIhRegrEe13wcAFIQar4Mp62Ea5gsbXxkW794FwKM1TDCRgiqk/JkWCiBYvytbr6UepXi6TqmSsLQGvD6R/oQqBy2Ubv0T9fmrVyJVqE9zEGa4iQPWSE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732162205; c=relaxed/simple;
	bh=2Cp9vRsQ/gAj1FcdRlHfgTJ7vv1GCanaDSr8EP0fO00=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Ojop+gnC/YPpUi6mH6li4EIVV8ECgoK6Z5RZdaZSbxpIRgvQYnkP2VPKBudfXD7Knl+PXRwpFe4fx/EvyoJCbNvCpsrTTvQikGN27s9FA9BPjekahuper2uriPHgwp9030t1iw5yIuKlFKqwcanccwxanjsn1NjRNGBrgVCHwSY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=Z6Xe5RS4; arc=fail smtp.client-ip=40.107.92.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eKcHazpRg72KKnc0dR5gl/DyTjoLyRcFsmMJDz1qx3tH1uTacBU50yZWGYqKjKNrdiFmaiAArEyDSUWPEHPBjCe1/TZxQxz53eo1UOpXxvS2LeWislKKy9Ncc/Ir20aRTvOJwtNxkVokcYSClNtUaEg+3UoP/VnHCbJXtdMao2guQXocYgmIJ96+H2xikmHIarBGDacr7fd3QXBBIObLkH2bMby1kwurVRcU46dndpxLbzF96nYEjVM7b0spl6R+FjtFXdWg04Sro8MJZD9fwEPaaVeBDcpONxNQQAuEb1q6H5q9hUtief7yoxWp0Ch9/NhJJcWFCqMrTMEZNkEjyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2Cp9vRsQ/gAj1FcdRlHfgTJ7vv1GCanaDSr8EP0fO00=;
 b=w0YsuG70xJOB4anbSSMA+yhnzdUE2eC/tEAHIESIVmM0Ck1VNEEZGfvx/4h5+cwGj2WRlr/BkEkmxY7nSXqeCo28nDWKGjHszbf2NpbrwU1TpgkbQt1UEWqhmlAgfg/QuzH4UVqIAzr/xUmXD5/wProMGZAIgDW8Is87qtZLHtrHxg6//ZZEy7TdTY4cNuO/PLTbAlymir5VPSQIawJuqIJpz/a1cNGAscYoyJc/DSjAlg3p5L6/aeOcgO0cjo66chdzDlZ0WiIQUBk96DcVDHoLDzZgZ/SJT/OFrtrn2U6i+P/ta646zECLQILZVstFXxWJeCWgtIlINdZ6jvpayw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2Cp9vRsQ/gAj1FcdRlHfgTJ7vv1GCanaDSr8EP0fO00=;
 b=Z6Xe5RS4xGiAIB+ZF/pYScY0Fg5DJZGU0lnfcsI89vyGhO8Dbs3GBaBgSz0M3nDrljXV9CPEdSXvjzgyYq/5Kt/A5EKDl60AxIurdfEk5Ael6qm50gH7/fc6Z1pLaiUgvJRFKaz/nzdsoLIhUjBRwBkAO/Q1YM2Lbxm4PWMqJTw9U6dGKqBlq40kW3rQtP+tBxsjP2KUf26drAyuRuYQjk+e+nt0LW8YZ2OcCIgoOHsQxM51GhLB+HNFTyJreDMabWrm2IO3SQdLWZ+waN/XBA6QYCcnu+0TA6UDPcswCOIEbDGfrNzENUA2DX1n3odRt9ChfudsHaXDsjDofNZqZQ==
Received: from SA1PR11MB8278.namprd11.prod.outlook.com (2603:10b6:806:25b::19)
 by MW5PR11MB5857.namprd11.prod.outlook.com (2603:10b6:303:19d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.23; Thu, 21 Nov
 2024 04:09:59 +0000
Received: from SA1PR11MB8278.namprd11.prod.outlook.com
 ([fe80::84fa:e267:e389:fa9]) by SA1PR11MB8278.namprd11.prod.outlook.com
 ([fe80::84fa:e267:e389:fa9%3]) with mapi id 15.20.8158.019; Thu, 21 Nov 2024
 04:09:59 +0000
From: <Parthiban.Veerasooran@microchip.com>
To: <jacob.e.keller@intel.com>
CC: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>,
	<Parthiban.Veerasooran@microchip.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <UNGLinuxDriver@microchip.com>
Subject: Re: [PATCH net 1/2] net: ethernet: oa_tc6: fix infinite loop error
 when tx credits becomes 0
Thread-Topic: [PATCH net 1/2] net: ethernet: oa_tc6: fix infinite loop error
 when tx credits becomes 0
Thread-Index: AQHbO1Nt4AvSKwTti0Wj3gYyiQdfcbLAlWyAgACKYQA=
Date: Thu, 21 Nov 2024 04:09:59 +0000
Message-ID: <0776911f-f537-4662-b3e1-a5f2f455f8bd@microchip.com>
References: <20241120135142.586845-1-parthiban.veerasooran@microchip.com>
 <20241120135142.586845-2-parthiban.veerasooran@microchip.com>
 <b20ed55e-cb77-4821-9b5f-37cdf3d01df5@intel.com>
In-Reply-To: <b20ed55e-cb77-4821-9b5f-37cdf3d01df5@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR11MB8278:EE_|MW5PR11MB5857:EE_
x-ms-office365-filtering-correlation-id: 57e37173-ade9-40a0-dee0-08dd09e25d8d
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB8278.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?TGpwS1BySVpGVlpWSTcvVUx2N2ttbGhtb3p5bVJVclEzMGlCRTNEdmwranRo?=
 =?utf-8?B?eTgraGUwQm5OODd2dUVxbG9DdE9aajFQcUlxd3I0TkNYNGxMR0JmYzc5UXcw?=
 =?utf-8?B?dkw2aXIvLzlyVXFmZzAzb0tONjJ5QkttWXJZNDAvT0VmQUQ0cC9PbGdybXdI?=
 =?utf-8?B?ZitiVnU2Tk0zamRORzE3TTNVa1YydFlsTGlmV2lacmtVY21BTjlqSEZKckdV?=
 =?utf-8?B?TTZSNEJMdmE2dlJpUXdGS3RuL0d1RGV6cGFLSWxJUWpEdlZDeFBhLytxdUsr?=
 =?utf-8?B?ZytGUFdHT3dCS1E5NXp3dEhzOW91bW1TSVkxbHpKZUdVR0tRY1NnYlcvZDVS?=
 =?utf-8?B?NnRhdU9tY0pSalI3d0pnd0g2TFVzQmNzSnF1ajdEMVkyc21jTkt1dlQ5QXQ1?=
 =?utf-8?B?ekhCYmMyK0xVZEtINktkV0pLR1FHY0ZVR2dQWUtvSkZGRkRWSW56YkNHRlFi?=
 =?utf-8?B?U1RueU9ZVkpzSHFCRTlzYlJaRUs3TldGNXk2b0E5dkJRbUMvSVk2OU1yK0Jy?=
 =?utf-8?B?UG1nLzk2T2x6ekxXeC9kSW9hUkI2Si9aYjNPdzd4cnpWSGx1MkNTK1JkRmw4?=
 =?utf-8?B?RFNHRXhrMi9LTjNvaW4xa3FoTDFIWlBNdEdmRjVLZHU5K2dwOURwUjgzS2x0?=
 =?utf-8?B?cCtDK1V1QnZteWovSHFHaUcwRGZPMEJ4RE5FU3hHU2lIeC92REoyOHFDUEdY?=
 =?utf-8?B?bTVvV0dmZmt2bnliYWFnb3JEc0JSNG9iRGd1bUJEL2I5ZFlIT3I1ZjZ1U1Bi?=
 =?utf-8?B?Vyt0cEtLL1lWdy9FdnFkaWN3bm40bmZSdi9tSzhlbThWMnY4eHpRVitUaER3?=
 =?utf-8?B?TCs4cjBIMWVBYzdCdW9KOWI2SEdPOWJLRTNOYXdvVk8xM2xWVmFRbEFWdllm?=
 =?utf-8?B?U25KS2tWb3dCY3p1VEpQYXJkRCttVVJaU0I1VW1wU1A5bVlGb2dzYzZ6aVlt?=
 =?utf-8?B?M282L1JvSmtZd05lQURiSWc2cURJMTN4a2F0QUxqR2MxSVlIU1RRbnUzdzQ3?=
 =?utf-8?B?Y0UreUFoeWdiTDFLa2l4TCtvVTB4eGJWWE45NUE3Yi9CMG53R3g2OWpaY0hm?=
 =?utf-8?B?RjVFUnJleWpQOWE2elNXNDFvN2JwZFB4SDdnRkh4ZFZpQlFockpXaXhpQWUw?=
 =?utf-8?B?YmxTejB0WnZFL1ZabHZuRWVPYVJGZkpWNnQwejBaalljZ3lFYlVodWhrUm5V?=
 =?utf-8?B?ZWFlaXNNbWNCd0NEZEY5Q1JvQkQwa1BoS2xYUkI3S0E1Y0x5anpBZjNMdERy?=
 =?utf-8?B?bXpYcTh0cWJXWEtOS2pxZElZak11VlNCUlJVZGYrYTFCUGFOWk9NblJldW0v?=
 =?utf-8?B?SVErc2tXNG5BeXh4bEg5ODY2TGZ2OFdkZ243V2t4OHpFdTNKSDFjRzI5RzZ0?=
 =?utf-8?B?anJnemdiQVA5SzBveS9ScDRUbjBKNmpZNnpzZkV6aHVvYVl5VnhBL0U5YXJX?=
 =?utf-8?B?MWE0TTlVNndlckNacEc0U1JvZ0RRdGVDQnV1YUJmUUxLa2t1eG5DR2dxQ21q?=
 =?utf-8?B?Tkt5aGVwVUFPZWwzd3NXYWs0K2RZOEZuRUR4eUhEZWJhcHdpc0M4bnp3QXgr?=
 =?utf-8?B?NGh0RzZHUlZRWVFzQlFzTi9udS96SzRYUk9jUlNqVDRnKzd2ZWl6RmhpRWRT?=
 =?utf-8?B?SW15UjZ5cXNpenhTZGMvMkJHSlJCTUdhZmY2aXdzaXJ2eFk2ZmtIcG1CZ09Z?=
 =?utf-8?B?SC9oNU9KNlpkWFZIMlo1enEvaE1PQWFScWplZGN1TXZHeEhBMWRJNlpsbjRh?=
 =?utf-8?Q?J7VEl37VGWvZ+181UoVNTJSAvzGBRcxbqfbLjnz?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?RkVpMzhISnczd1ZLTFdIcGdFRFFObzhqTkZRRitpQi8rcU1Td3dZWGo2STF2?=
 =?utf-8?B?dmdpVksrdmtZdUF2aFQ1RnVJak5yZWVRWmFYMFpSaUJ3YWl3VTdGS002bzNJ?=
 =?utf-8?B?blpWQ3ZzRUV6aHMwTlB0U0JiUmNDdVF6UmlheU1HRXpWSlpoaXIvTmhGZDVW?=
 =?utf-8?B?UmY5aG1NWXZyN3l2RGZiVWlXK2hIZlh5TXRYZ0t5RVEzVnc1dFRyZ3dRMzRF?=
 =?utf-8?B?RFkxck1waE85enZqRUJYaEsxSTNMMHVvZzdMczVsellRdm5oSmVwa2NvbnA3?=
 =?utf-8?B?WHZDVzU4WVZ0RndxaVZIVmhnYzY0V0RrQlZPcFd5cWxoWVgwQUZ4WWRjc0N0?=
 =?utf-8?B?SGxSby9sdlpaMC94bGFXVVR6NkJEM3JWODlKZ0FEa0FFT0Z4QzBuTXdHblZI?=
 =?utf-8?B?WXhwQ0JGMDVtTDF6UUhpRDdFZlVnVFN5OXUzQmRRendhQzVFN0ZnWmYrQS95?=
 =?utf-8?B?R3RKdHNoL3JEWEdnS2didllzdHk0L1FvMlY2cEJISmIzUjJDZWhndFF4RGQ1?=
 =?utf-8?B?blpWamZpY1l6N3BHOXcya0Jnemh5UkI4NkcrUitzMEg5TGxFVWoxZUZ0Vk9N?=
 =?utf-8?B?MTJXWWtjYmhPMXorZlJ3dFFXODR6ZDAwT1R4MkdMQmNsU0dnYVBuMHZjOGo4?=
 =?utf-8?B?cGgyd1VRUTVSZ2hzMHV2czFSMnhVeEVIbVpIbDBtYXFBOGRZd1JLZG1Rbjc5?=
 =?utf-8?B?bEJnSkw5SkNNWUZnK1BBSmVvWXpoQ1FSdUh4WmJONHM5TVM1ZlBtb2VwelRB?=
 =?utf-8?B?TTU5KzlUbEJmM0p3NEJLV2lIUHNwQTVDY3NDbEN1RjlQY0hUdjdFSmZpQy8w?=
 =?utf-8?B?M2YvT3dKNlRqRDlyWFFVci95UGJSWHp4emttNG5ZWm5pdkljVy9leEx2bWR6?=
 =?utf-8?B?S1dZMWJ0UFk1V0VuZnJhYnNCTzV0aW1seEhCMDVtSTlxQ3lvNy8vYndYYmsr?=
 =?utf-8?B?WDlBMmJqOTFzenU5K2dlK2taK3laek50MVJETUNFV2w3QkNyZVRaZTdoN0d3?=
 =?utf-8?B?QUNHWmVYN2xmSE5pdjNpWTJ6MkI2L1BJWE9qbHlMZG1GSC9pM1hmbWZhV0Iy?=
 =?utf-8?B?N1k2YTVjLy82S0NzcE9HQUJqT21KTjFaSHVkSnBTZXZVRVkybjJMdnVWWitq?=
 =?utf-8?B?TFB6bDN3enlJRE83Z1dQYWx6YkZRbUJTR09jTzNDeHNmSDBEZGQvN216QUtk?=
 =?utf-8?B?dXk2Ym9ZTlJJZlBXelRrK2xOaithcG4xY0JOVlRHK05pK3NBVmNsWFVUcWJP?=
 =?utf-8?B?RkdCZzdWSkZ6QUZQOStEbjdHQkxqSWZ6a1pLTzZQY0hlUXJuOEtzTjk0SFpx?=
 =?utf-8?B?Y0NYVGZYNDgvVnREUFZnb2NUbWdTbm94L2FmY2FRUEI2RFAwSlR0ZkRFaHQy?=
 =?utf-8?B?T09WU2hleE5IL2VHelltR0ZCbm9vekJZZTVmdG0xYVJqajAwK2FrWjFiMDRk?=
 =?utf-8?B?anppcEQzSVAzNE9aVG14ZnA5OGJ5dEFpNVMxSjNDV3pJbnN3bnhiWEJaMVE1?=
 =?utf-8?B?NWp5Q25sbWVLS1AxWEJIdE9CWVpoTnV2bkVsZWszbVlsd1AyV0I2Yk1HRWpm?=
 =?utf-8?B?OGFWU21Md2lqY01pcjhNdEt2SUlCbUxPRWppZThBaGpNVmVjQWw4NExBUTJn?=
 =?utf-8?B?VnVEVzZ1dFAvUTdPUnk1N3BDYWhpeURXaVoydU05UlUvdVRVWW8zd2NZQ3dl?=
 =?utf-8?B?VVBKRmV4a244SHdDUGRiZXZkeWZZTHpUUzZhbWVpV0IrVjFLYnhUODNYQWRu?=
 =?utf-8?B?djhMczU2cUZOckFRTWovUFpkUTZaM2VvVWdKYmw3ZzRKSkw5Q2gyR3U2M2NT?=
 =?utf-8?B?R09qNllnSFNvSzhuZVVOdVlrcHlvQUVMd3FVeUJMV1AyeHJ6dzRvU3FlTTJL?=
 =?utf-8?B?a1BpWUFaNnl2aWJySXVEdWMvalAybXpndXRzbHNHUHRBZmhHUExVMGp6YjBG?=
 =?utf-8?B?VmJ4NGJQekZZVEp4SjI4c3Fwc2F6a0V1emRPV2srZk03ZkdXWmRiM0l0YTFO?=
 =?utf-8?B?bFArT1FlS3RxVTNwVGlVaUNCWnZvODFMRFNrd2w2THZjOGZpZGZydWpyLzVW?=
 =?utf-8?B?cEpCN1BxT0lJZmJML1poY1RnUEc5alVaL0NCY1FjajFBMzNPaHVWWEkrMmsx?=
 =?utf-8?B?bklZdGFpQkdUcGhuSGZCWFFFalJZdHJ4bUtUUktOY2YxZ250Q0V1a0V1Ym93?=
 =?utf-8?B?c0E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <745105834F236348A8699C1A3AE32087@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: microchip.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB8278.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 57e37173-ade9-40a0-dee0-08dd09e25d8d
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Nov 2024 04:09:59.3134
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YN9e55jx8DLI1NGZOmLULwJYh/sHymu1xpegk0ab9qXTi7jXTdW2JsTYv7bnwx2YcgxVHtOaXQDf0dUDCgmRfyW3kacFhVdbZ7rR8Bzi0VwLRr6YG6paQkZ3HQdbZzFH
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR11MB5857

SGkgSmFjb2IgS2VsbGVyLA0KDQpUaGFua3MgZm9yIHRoZSByZXZpZXcuDQoNCk9uIDIxLzExLzI0
IDE6MjQgYW0sIEphY29iIEtlbGxlciB3cm90ZToNCj4gRVhURVJOQUwgRU1BSUw6IERvIG5vdCBj
bGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVubGVzcyB5b3Uga25vdyB0aGUgY29udGVu
dCBpcyBzYWZlDQo+IA0KPiBPbiAxMS8yMC8yMDI0IDU6NTEgQU0sIFBhcnRoaWJhbiBWZWVyYXNv
b3JhbiB3cm90ZToNCj4+IFNQSSB0aHJlYWQgd2FrZXMgdXAgdG8gcGVyZm9ybSBTUEkgdHJhbnNm
ZXIgd2hlbmV2ZXIgdGhlcmUgaXMgYW4gVFggc2tiDQo+PiBmcm9tIG4vdyBzdGFjayBvciBpbnRl
cnJ1cHQgZnJvbSBNQUMtUEhZLiBFdGhlcm5ldCBmcmFtZSBmcm9tIFRYIHNrYiBpcw0KPj4gdHJh
bnNmZXJyZWQgYmFzZWQgb24gdGhlIGF2YWlsYWJpbGl0eSB0eCBjcmVkaXRzIGluIHRoZSBNQUMt
UEhZIHdoaWNoIGlzDQo+PiByZXBvcnRlZCBmcm9tIHRoZSBwcmV2aW91cyBTUEkgdHJhbnNmZXIu
IFNvbWV0aW1lcyB0aGVyZSBpcyBhIHBvc3NpYmlsaXR5DQo+PiB0aGF0IFRYIHNrYiBpcyBhdmFp
bGFibGUgdG8gdHJhbnNtaXQgYnV0IHRoZXJlIGlzIG5vIHR4IGNyZWRpdHMgZnJvbQ0KPj4gTUFD
LVBIWS4gSW4gdGhpcyBjYXNlLCB0aGVyZSB3aWxsIG5vdCBiZSBhbnkgU1BJIHRyYW5zZmVyIGJ1
dCB0aGUgdGhyZWFkDQo+PiB3aWxsIGJlIHJ1bm5pbmcgaW4gYW4gZW5kbGVzcyBsb29wIHVudGls
IHR4IGNyZWRpdHMgYXZhaWxhYmxlIGFnYWluLg0KPj4NCj4+IFNvIGNoZWNraW5nIHRoZSBhdmFp
bGFiaWxpdHkgb2YgdHggY3JlZGl0cyBhbG9uZyB3aXRoIFRYIHNrYiB3aWxsIHByZXZlbnQNCj4+
IHRoZSBhYm92ZSBpbmZpbml0ZSBsb29wLiBXaGVuIHRoZSB0eCBjcmVkaXRzIGF2YWlsYWJsZSBh
Z2FpbiB0aGF0IHdpbGwgYmUNCj4+IG5vdGlmaWVkIHRocm91Z2ggaW50ZXJydXB0IHdoaWNoIHdp
bGwgdHJpZ2dlciB0aGUgU1BJIHRyYW5zZmVyIHRvIGdldCB0aGUNCj4+IGF2YWlsYWJsZSB0eCBj
cmVkaXRzLg0KPj4NCj4+IEZpeGVzOiA1M2ZiZGU4YWIyMWUgKCJuZXQ6IGV0aGVybmV0OiBvYV90
YzY6IGltcGxlbWVudCB0cmFuc21pdCBwYXRoIHRvIHRyYW5zZmVyIHR4IGV0aGVybmV0IGZyYW1l
cyIpDQo+PiBTaWduZWQtb2ZmLWJ5OiBQYXJ0aGliYW4gVmVlcmFzb29yYW4gPHBhcnRoaWJhbi52
ZWVyYXNvb3JhbkBtaWNyb2NoaXAuY29tPg0KPj4gLS0tDQo+PiAgIGRyaXZlcnMvbmV0L2V0aGVy
bmV0L29hX3RjNi5jIHwgNSArKystLQ0KPj4gICAxIGZpbGUgY2hhbmdlZCwgMyBpbnNlcnRpb25z
KCspLCAyIGRlbGV0aW9ucygtKQ0KPj4NCj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL25ldC9ldGhl
cm5ldC9vYV90YzYuYyBiL2RyaXZlcnMvbmV0L2V0aGVybmV0L29hX3RjNi5jDQo+PiBpbmRleCBm
OWMwZGNkOTY1YzIuLjRjOGIwY2E5MjJiNyAxMDA2NDQNCj4+IC0tLSBhL2RyaXZlcnMvbmV0L2V0
aGVybmV0L29hX3RjNi5jDQo+PiArKysgYi9kcml2ZXJzL25ldC9ldGhlcm5ldC9vYV90YzYuYw0K
Pj4gQEAgLTExMTEsOCArMTExMSw5IEBAIHN0YXRpYyBpbnQgb2FfdGM2X3NwaV90aHJlYWRfaGFu
ZGxlcih2b2lkICpkYXRhKQ0KPj4gICAgICAgICAgICAgICAgLyogVGhpcyBrdGhyZWFkIHdpbGwg
YmUgd2FrZW4gdXAgaWYgdGhlcmUgaXMgYSB0eCBza2Igb3IgbWFjLXBoeQ0KPj4gICAgICAgICAg
ICAgICAgICogaW50ZXJydXB0IHRvIHBlcmZvcm0gc3BpIHRyYW5zZmVyIHdpdGggdHggY2h1bmtz
Lg0KPj4gICAgICAgICAgICAgICAgICovDQo+PiAtICAgICAgICAgICAgIHdhaXRfZXZlbnRfaW50
ZXJydXB0aWJsZSh0YzYtPnNwaV93cSwgdGM2LT53YWl0aW5nX3R4X3NrYiB8fA0KPj4gLSAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgdGM2LT5pbnRfZmxhZyB8fA0KPj4gKyAg
ICAgICAgICAgICB3YWl0X2V2ZW50X2ludGVycnVwdGlibGUodGM2LT5zcGlfd3EsIHRjNi0+aW50
X2ZsYWcgfHwNCj4+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICh0YzYt
PndhaXRpbmdfdHhfc2tiICYmDQo+PiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICB0YzYtPnR4X2NyZWRpdHMpIHx8DQo+PiAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAga3RocmVhZF9zaG91bGRfc3RvcCgpKTsNCj4+DQo+IA0KPiBPaywgc28gcHJl
dmlvdXNseSB3ZSBjaGVjazoNCj4gDQo+IHdhaXRpbmdfdHhfc2tiIHx8IGludF9mbGFnDQpQcmV2
aW91c2x5IHdlIGNoZWNrZWQga3RocmVhZF9zaG91bGRfc3RvcCBhbHNvLiBQcmV2aW91c2x5IGl0
IHdhcywNCg0Kd2FpdGluZ190eF9za2IgfHwgaW50X2ZsYWcgfHwga3RocmVhZF9zaG91bGRfc3Rv
cA0KDQpQbGVhc2UgcmVmZXIgdGhlIGJlbG93IGxpbmssDQoNCmh0dHBzOi8vZWxpeGlyLmJvb3Rs
aW4uY29tL2xpbnV4L3Y2LjEyL3NvdXJjZS9kcml2ZXJzL25ldC9ldGhlcm5ldC9vYV90YzYuYyNM
MTExNA0KDQpOb3cgd2Ugb25seSBhZGRlZCB0eF9jcmVkaXRzIHdpdGggd2FpdGluZ190eF9za2Iu
IEhvcGUgdGhpcyBjbGFyaWZpZXM/DQo+IA0KPiBOb3cgd2UgY2hlY2s6DQo+IA0KPiBpbnRfZmxh
ZyB8fCAod2FpdGluZ190eF9za2IgJiYgdHhfY3JlZGl0cykgfHwga3RocmVhZF9zaG91bGRfc3Rv
cC4NCj4gDQo+IFdlIGRpZG4ndCBjaGVjayBrdGhyZWFkX3Nob3VsZF9zdG9wIGJlZm9yZSBhbmQg
dGhpcyBpc24ndCBtZW50aW9uZWQgaW4NCj4gdGhlIGNvbW1pdCBtZXNzYWdlLCAob3IgYXQgbGVh
c3QgaXRzIG5vdCBjbGVhciB0byBtZSkuDQo+IA0KPiBXaGF0cyB0aGUgcHVycG9zZSBiZWhpbmQg
dGhhdD8gSSBndWVzcyB5b3Ugd2FudCB0byB3YWtlIHVwIGltbWVkaWF0ZWx5DQo+IHdoZW4ga3Ro
cmVhZF9zaG91bGRfc3RvcCgpIHNvIHRoYXQgd2UgY2FuIHNodXRkb3duIHRoZSBrdGhyZWFkIEFT
QVA/IElzDQo+IHRoZSBjb25kaXRpb24gIndhaXRpbmdfdHhfc2tiICYmIHR4X2NyZWRpdHMiIHN1
Y2ggdGhhdCB3ZSBtaWdodA0KPiBvdGhlcndpc2Ugbm90IHdha2UgdXAsIGJ1dCB3aXRoIGp1c3Qg
IndhaXRpbmdfdHhfc2tiIiB3ZSBkZWZpbml0ZWx5IHdha2UNCj4gdXAgYW5kIHN0b3AgZWFybGll
cj8NCkkgdGhpbmsgdGhlcmUgaXMgYSBtaXN1bmRlcnN0YW5kaW5nIGhlcmUuIEhvcGUgdGhlIGFi
b3ZlIHJlcGx5IGNsYXJpZmllcyANCnRoaXM/IElmIG5vdCBwbGVhc2UgbGV0IG1lIGtub3cgd2hh
dCBkbyB5b3UgZXhwZWN0Pw0KDQpCZXN0IHJlZ2FyZHMsDQpQYXJ0aGliYW4gVg0KPiANCj4gSSB0
aGluayB0aGF0IGNoYW5nZSBtYWtlcyBzZW5zZSBidXQgSSBkb24ndCBsaWtlIHRoYXQgaXQgd2Fz
IG5vdCBjYWxsZWQNCj4gb3V0IGluIHRoZSBjb21taXQgbWVzc2FnZS4NCj4gDQo+IFRoZSBjb2Rl
IHNlZW1zIGNvcnJlY3QgdG8gbWUgb3RoZXJ3aXNlLg0KPiANCj4+ICAgICAgICAgICAgICAgIGlm
IChrdGhyZWFkX3Nob3VsZF9zdG9wKCkpDQo+IA0KDQo=

