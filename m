Return-Path: <netdev+bounces-194667-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 14436ACBC7A
	for <lists+netdev@lfdr.de>; Mon,  2 Jun 2025 22:51:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 25260188EF39
	for <lists+netdev@lfdr.de>; Mon,  2 Jun 2025 20:51:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB3F081732;
	Mon,  2 Jun 2025 20:51:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=amperemail.onmicrosoft.com header.i=@amperemail.onmicrosoft.com header.b="E7kpdcg2"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2127.outbound.protection.outlook.com [40.107.243.127])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB1802C859;
	Mon,  2 Jun 2025 20:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.127
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748897499; cv=fail; b=iub6d8q4ivCaYPh8tC3JTVUdavMaO4NFI0HNyCpzQaOkR21PFoLKif2RqHDH9HS/97sh/j3gPir548lz0XG4MwnI+HwYtWXkiOpL3D9nT2Xie2JsaZwzbjPtk63mLYwTejhSXUqFcwHKvStHeGxpXQwMpTV6G+X9JU0Am4LzH/M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748897499; c=relaxed/simple;
	bh=yI76v8rOs52PLFOSa8kdB3oX6c1h+evKV+116ImFgs4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=J+D/oxh1SsDGs7MQycxl/wE8nFVnumEIYrBtB9oeQre7qxC81TEcJFoXZBWVI6LDi/rXije+2vsE7Zgo6/ZRx7u9+J0Q97t7j8ACIZPnYjoDJKaoA/52uyr8IakEHydt0Gw9mJjR5zQrHh9cmopW486FdLxbOuKbQR0Bckpa+aI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amperemail.onmicrosoft.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=fail (0-bit key) header.d=amperemail.onmicrosoft.com header.i=@amperemail.onmicrosoft.com header.b=E7kpdcg2 reason="key not found in DNS"; arc=fail smtp.client-ip=40.107.243.127
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amperemail.onmicrosoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sC0hSOXiPEUQ7WO3QWQt6HVihmKILS0kygHGYdKTwHRYo3np2AezD/dRxtelbjH72tEVFPr+uVA+8tKfuCz9oJLXoG46jUiBczxyCTYi/PPumX+LJ52ng2RjGsTlQqzEEDDh1JjwXRghVc6rNhXnHi1UJIt7neIkn0dGJIYwgm0tZv8dRxzpW14eY13u6PLn+a8jXo72RbgGZIgX6jqzeYTLIGpdrKf0ImlUTVcqGzAcMHvl8dLD6CZZ8A6N39qyPt283Rf7QM9ts8cbLNIjk6lC6Rd5J7lPB25b0ZcG5mdI1MEDHkaNeFssJFVToKlpqfzkwpYQwi9m1oXClXCgVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e5GlScKEW+nCQfxwCrz1v9MqXW3Q3fCTvTFedJdS7i0=;
 b=YRb9VxFMbXXUDGA6HJzEdolrmMPwcCUtNNCECMfEosvaO1gSFPgx1HY9adwfCv9rpZjpE2Cj2U5DZrGA2g5BSX2YdFD1DiO8opTU1IvElpgBNMfWbJ/AnZtpYrvGuSgzbwnl3sDGYq3lPJHAxkYr3pmK/N3hOBmA+8llcUcpAOh4R0Mvj7nuVYhottEUoUW+W6KhNJ/EZTy8LRkuroS8hHf4NpvZG8tO84yV/USlfI6dlae8BUB1IF2fkuPqHRcsb0n6MAPZ4nNCp5O14G6PUEnMrMYbWaFbqP+ebb1MH1LpjP7ZssqWjbh3FWgA0J0pAZL7Hn10yDVRGCVfl9Aspw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=amperemail.onmicrosoft.com; dkim=pass
 header.d=amperemail.onmicrosoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amperemail.onmicrosoft.com; s=selector1-amperemail-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e5GlScKEW+nCQfxwCrz1v9MqXW3Q3fCTvTFedJdS7i0=;
 b=E7kpdcg2RuS5HynqkEaSrIYCLEskZScGQrTYvc3pHRVNImC7E/zu6Qsq4c97jMwViz0iNV/AonXtwwNr4EtYju9hjYS7WVwRc1I6natiL4MiokqwYi99z9UjqyDLu5OcO8mCb3YVBOZrH3HNfIJUW7SSHklUcCyZIw3ASTq9jgk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amperemail.onmicrosoft.com;
Received: from BN3PR01MB9212.prod.exchangelabs.com (2603:10b6:408:2cb::8) by
 CY1PR01MB9340.prod.exchangelabs.com (2603:10b6:930:108::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8769.34; Mon, 2 Jun 2025 20:51:34 +0000
Received: from BN3PR01MB9212.prod.exchangelabs.com
 ([fe80::3513:ad6e:208c:5dbd]) by BN3PR01MB9212.prod.exchangelabs.com
 ([fe80::3513:ad6e:208c:5dbd%3]) with mapi id 15.20.8769.037; Mon, 2 Jun 2025
 20:51:34 +0000
Message-ID: <9e3e0739-b859-4a62-954e-2b13f7d5dd85@amperemail.onmicrosoft.com>
Date: Mon, 2 Jun 2025 16:51:29 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v20 1/1] mctp pcc: Implement MCTP over PCC
 Transport
To: "lihuisong (C)" <lihuisong@huawei.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Sudeep Holla <sudeep.holla@arm.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 admiyo@os.amperecomputing.com, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>,
 Jeremy Kerr <jk@codeconstruct.com.au>, Eric Dumazet <edumazet@google.com>,
 Matt Johnston <matt@codeconstruct.com.au>, Paolo Abeni <pabeni@redhat.com>,
 Jakub Kicinski <kuba@kernel.org>
References: <20250423220142.635223-1-admiyo@os.amperecomputing.com>
 <20250423220142.635223-2-admiyo@os.amperecomputing.com>
 <497a60df-c97e-48b7-bf0f-decbee6ed732@huawei.com>
 <a9f67a55-3471-46b3-bd02-757b0796658a@amperemail.onmicrosoft.com>
 <807e5ea9-ed04-4203-b4a6-bf90952e7934@huawei.com>
Content-Language: en-US
From: Adam Young <admiyo@amperemail.onmicrosoft.com>
In-Reply-To: <807e5ea9-ed04-4203-b4a6-bf90952e7934@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CY5PR14CA0004.namprd14.prod.outlook.com
 (2603:10b6:930:2::35) To BN3PR01MB9212.prod.exchangelabs.com
 (2603:10b6:408:2cb::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PR01MB9212:EE_|CY1PR01MB9340:EE_
X-MS-Office365-Filtering-Correlation-Id: 4f32ab80-6b2e-40d6-e146-08dda217427a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RHhFNjlqSlJkSzU1VlM2Q2FlbXBJRXdtR3lkTDZCdXJJd1RpL3ZsNDRNVnVz?=
 =?utf-8?B?UGtsSmFCYlF4cnIrSFk0ai8vWE42OFZQcEJrTHd1dGd0OWdIWGlHZ29DdTY5?=
 =?utf-8?B?cnFXaE1UQlZmZGVJei9GQU96SXRTL011dDA0STlkUk52ZzM2TEpHKzdIVm9R?=
 =?utf-8?B?a3RBMWNVRG4wVWFiKzc3dVVQL25PYmt5ZVRkb0VwRGJhbXFJclVqUm05eDkw?=
 =?utf-8?B?Z0NzQ0d0d2ZheHl1WDRMM0MvSWFmYTJuMjlOelgxTU5mcEsxRlBtSDN0Rnhh?=
 =?utf-8?B?YlJDT25EdmkrbkxibU4xbW1Hc3Uvcld3REJwWjFFUEppUkswVmplU25MTmxj?=
 =?utf-8?B?TmZrNTR4RHpwWTJzUTNTbFRCOXN3Y09zWnp3NVF0T29SME5oQ2pCQUY0Qmxk?=
 =?utf-8?B?b1Rwb3BwT1JXWHJkTGVFNEdUeXFpVVRaWW10bmFpSjRNcDJpckd6c0Q5SHB3?=
 =?utf-8?B?NzB0VUNYQXQ0NldydE9SMTRPWktNTTVZL1RkeFl2cVAxVGU0LzBVRWlxSTQ4?=
 =?utf-8?B?OHQrMVRNY1hrMVRBaVBpblhXRzlkVjQvNzN3QXR5Sk42dEpvcDVjYjl5ZVFJ?=
 =?utf-8?B?NnQ5TkJmK2xWWHI0djNMdlJla3JVUFpNY1JHU1dEMFlOdndlMVBJWjBPa0xi?=
 =?utf-8?B?cnI4ZTBJaDBYWEVDbDBPZm9CazBqMWp4TnFaRkJNYVVCd3dFK0tTVVpVcGZx?=
 =?utf-8?B?U1hMSkZuenhEMEgzRU1MK2g3NVRGc24zT0pxMklVZDdOMzcza3RnUVNmSFhM?=
 =?utf-8?B?dlJFZEQvWnU3RUJZRk5sb3cyTnhZaHBzb3Z4cm82VUN6djZGcG1JKzM0WGt0?=
 =?utf-8?B?S2RpNktTWDFUaVZzN0VscnlUM3lGanhndmxKcUZxOHBKOEZlMjFhUk1PVDdt?=
 =?utf-8?B?b0NiK0c1Rzh1RXY2WUVTdi9IQ3BXTkRxNDlXTDVCeG9aK0sxb0NlL0xSMkJY?=
 =?utf-8?B?OEFxSk9lYUR4ZUhiK2F1YStQbkNLdkxEWDNIWllVMlRqVGYrbURlY3VnQXJH?=
 =?utf-8?B?bEtpOUt0ZjVPWFVyTkZhQ29vN2RzRVN1SXVuczg2OEZwV3NxenN0R1NEaGx4?=
 =?utf-8?B?RzhGQk9BTEkwMThDU2ZtRGd5S0k2UDFHT2FrYWxOcHBhL2hnRjRESW01UHNo?=
 =?utf-8?B?MjcrUlcvTUQ4OHZKM3d3VGhTSHlXZkw5VmRLejRRNTJhdHRydTZVZ29TNkM3?=
 =?utf-8?B?WGNGRExRZUNaRUVkSFpVS0FtUVdFbXJhKzFEWjZyVnd3MlRPUVJKa0lTemVQ?=
 =?utf-8?B?aThIeFk1bWRHZ05TR1pzRWI3ZW40eXI0RFEybmdGMllrMXNFaXQ3OTNjTEM4?=
 =?utf-8?B?WmhBYWpKOG10dFhsS1ErcHUvY1hqRERHZlFiMk9waWZZNkVmSGJBbCtib1Vn?=
 =?utf-8?B?b2N4d1JvS2JyNlpGUitFSjIvdEdma2ZxQ1dpVHV4QkpaZXBxTkVmenAxZ0w2?=
 =?utf-8?B?amorc3pFR0Z5cUdyZ2ZZdHJDQjNIbkxsaGdJL1BSVTlaR0F2eXVicEhKOUkr?=
 =?utf-8?B?Y29laGw3WXdTM1hmb2VneUhWN0NsZW0vTjJYaWZSWWxYYzg5RlhkS1VuL0cy?=
 =?utf-8?B?WWlSNFlTOUIxaHdtdTNvR1NlcmkxNzl5RHdMS3BWTXN1VWxPMGRDb1Blaldh?=
 =?utf-8?B?SXFvUU43WFpTVUxEZGxJdmxVM3JWdFNhcnJNM0lhdzBYckNzUktmMUVyRGpp?=
 =?utf-8?B?SkU5RHgwMFp4dFduWk5EamhnUDJLMVpheVI2dGtZUU5CQTRERU13aFdKaWtr?=
 =?utf-8?B?Vk00eG5tMFhLN0poNUl4a0NUWHJ1SmpNa05Pekw0S1dYRzV2c1padTdjdmpu?=
 =?utf-8?B?c3lCNFQzaEpaTXVnREdaRVZadWtxdmZhdXpSUVJsMytUL00yb2J1Ulpxc3lx?=
 =?utf-8?B?aC80ZEJ1aFdLUXpCL0hnZ2x1UGEzRjBzbDJuRGxrVFRMUFk3NGVZWFcyREJN?=
 =?utf-8?Q?B3w5DXb/Y3Q=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN3PR01MB9212.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WUlDbDBHczhQRjdyR2s0ME4xN1hwK2VyQ2NiQk5mK2lWVUcvdzB6YXBGNHcr?=
 =?utf-8?B?b0gyYVFURjdBTmM5OVNFZ3ZCbkkzN3NpdGUxbXpMYjZ6OVRDRnppcHdTVVdU?=
 =?utf-8?B?eVNUcWpwM1U3bUl0d2Uza0ovZ3NEZ1dyRXBqaUpVYmdBakorMFMyZ2YyclYx?=
 =?utf-8?B?dGtycHVDcllvZ21FSjVtcCtZa25uUFEvOStZTTVjNmJ4UkFLQm9heS9rVHNO?=
 =?utf-8?B?UFF5RDdGNzJmT2xDdWxBR2o2VjdXb3MyOHZiUjV3NXppNUlKaHZ1cnZPb0p3?=
 =?utf-8?B?T0txd0ZOWm9zTGV1RDZjd1gzU2hnUGVJbXpmUEVHcEpQRk5JMHRsVEFIQk9V?=
 =?utf-8?B?NDhoUit4cUwwbGtDbWRFSnhXMWhubnczNDA0N1VGTXZXTzR1ZnZOL3VPYU8w?=
 =?utf-8?B?K1VKWDdhNjRKdEQ3MmdlYWRTSVBMd0I1VXZCVkE1Z3FEM2pYQ1hCdFVjNnZk?=
 =?utf-8?B?MXJJWVhneWJuOTRBM0xjcGMydkVGL00xQXBadGcvbFNrNW5kSmJKUTdxck9P?=
 =?utf-8?B?S3JiWit3R1ZqSERsbGlCQmdpeldyaXFzcUZaL0FMT0xmaTRpdVZlQ3JkM1lP?=
 =?utf-8?B?S3JnVnBjKzg2Q3dSMDI4cis0WStPSS9lTHBpVGcwYSs5N3lKMmZaeHNZaGpJ?=
 =?utf-8?B?amxkY3lUNThaV2dUT3hKS2IxN2VZVStLeTVaOGVQUVZqMVcvVXJlTDNyMncy?=
 =?utf-8?B?cCtqNFpsRU9UY0x6ZVZnc0ZEVkFnUmsvMUk0MHRURkVMNHVhcGsxeUgzb3dE?=
 =?utf-8?B?VExwM2x6OVh3R0tHMit3Y1c1a2lqQ2R0YVlZTGhWSytIU2ZGd3ZUVU9aNHFK?=
 =?utf-8?B?RVhkZXN0V0tMS1NOdjR5WmZ5S2p1UVBmaTV6Y1o0ZnB3OE1KM2F4QXVrVzRP?=
 =?utf-8?B?MnVwRkxrbTM4Q0l2L2dZZi8xSlEweE5WekRPdHBoVW4vRkd3ejNtNUVTT1Zr?=
 =?utf-8?B?ZWduUGFUclBRMkdUdTRidzRRejR4bzlwQ0lPdmxjRVREbHVXemswK3lCY1JL?=
 =?utf-8?B?OFlTbjBvOVpWdG9sYmxmaHN3MTRJdVlSZ3gzN2NWUjJsQVVLOFpZTUU2NUJX?=
 =?utf-8?B?NmFSbTVtVzVaWU55dnY1SWxNUFBGWDRjeGZOQlZyNDZ5QkhQbnB5NjFvRllE?=
 =?utf-8?B?eGpJTHJ4Und6dFgxU3Qwc2xkdHNSV1NRQXI1aXlzOVZEOXFyMVB6dURUN01a?=
 =?utf-8?B?NlhUdUJ0SkhXRG9tV2NyVjQ0NmRJWWNkbDBMSUdwdGU5NmRzOS9NRG9EMzdW?=
 =?utf-8?B?ZVdqbmR2bTc0SFdQazFneEpRTllIbXBEb0lYNTVEbzJnc0J6MmFNL04vM2E0?=
 =?utf-8?B?SW5OckNNZUNQTGFhOGJYd2QxV2ZaYW5kdmdtb3pKZzVzWjZUeEVHaWh0VEV4?=
 =?utf-8?B?UVFiSEozb0MzT2g0amtHd0xzY0ZOMFh2SkV5cExkVUp0WDF6U3p6WEEvaTFy?=
 =?utf-8?B?WlBoMG80VFprOFh6aHNYR2ZvU2xsNlVjVUtpSkZ0V2lKSko3K25tSXJsVG83?=
 =?utf-8?B?aXJtb1NRR09YampUM2hHUVA4MHE2Z2loMVFLb0hTZ1MrZXk3ZjJHYU0vVy9k?=
 =?utf-8?B?UlBQS2VqVVlhYWd1eDNGS2dZVkw5TnQ2dDdEN09ETlJHdTBCQ2o4b3l5dmpN?=
 =?utf-8?B?Z0NvRUpJb0xMT3hhdE9ZTGlhdlpxdDlqL0RiYXk1NVN1YjJnWXVsYXZ3dDFK?=
 =?utf-8?B?eVJPNXRPS2lEQ2VBQlZqUnVZMW55OVc4dnJZT2d4MDRIcEJjQmNxSnBMTUs3?=
 =?utf-8?B?ZGxoTng4M2tibW9LazVKN1hURTZTNWQvUHFpU21QdUxUWDMxMTZTbUxYdVc1?=
 =?utf-8?B?aHViNTNiVWl4ZGhTY29VWGtXZmNmaklzT2pZTCtqT00zRGlTdXB6bWNaWmJQ?=
 =?utf-8?B?THZMMDVDdC9obHNvaGJucms1VjhJZ3JJVkZHZHVjZjRLU0xtNVBGQ1VzRlF0?=
 =?utf-8?B?cGRSaXpyS3pMN2I0dXRDbm1wUXg5SEYrYVlNSndYdnhJRTVSWEpWSmJpQzFH?=
 =?utf-8?B?T1NyYWNYVjNOYTY2YW1Oc2FvNEhLeHVwckhENmpJRXI4bGlzTXJlNE5rSXdQ?=
 =?utf-8?B?ZzJwUmZYYW9Rb3pFcFp6NXhZRVEwQzY1QTBQaXhPZ2xKcjBCUXpmS1NjUkdT?=
 =?utf-8?B?MVJrZUl1KzNpQ252Ty9ZRFo0andjeWtxMm93MDYzczVROW9xeVlZeFVwdEpn?=
 =?utf-8?B?aXJhYkZPR2lDM0NlNWpCa1FzT1VYRVpoSE9OU0FzY29NK1Y2a2huTWhicVh4?=
 =?utf-8?Q?6ggdL8XRzFsifihPIMBq76nbp4gFT35qzz/PIIVrXU=3D?=
X-OriginatorOrg: amperemail.onmicrosoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f32ab80-6b2e-40d6-e146-08dda217427a
X-MS-Exchange-CrossTenant-AuthSource: BN3PR01MB9212.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2025 20:51:34.3149
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3OS1L78VX4KCfYmzPl+XmtP/g2fUms6/VoFnn74KyizZLHqvVCqpehQx/LPuU2JaFDqUZWKbPE7J68OQHZKdyAikyrc3pkNirhsZxLO0Iool4MQpBfm0mKWX16Bm2/nr
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR01MB9340


On 5/30/25 02:19, lihuisong (C) wrote:
>
> 在 2025/4/29 2:48, Adam Young 写道:
>>
>> On 4/24/25 09:03, lihuisong (C) wrote:
>>>> +    rc = mctp_pcc_initialize_mailbox(dev, &mctp_pcc_ndev->inbox,
>>>> +                     context.inbox_index);
>>>> +    if (rc)
>>>> +        goto free_netdev;
>>>> +    mctp_pcc_ndev->inbox.client.rx_callback = 
>>>> mctp_pcc_client_rx_callback;
>>> It is good to move the assignemnt of  rx_callback pointer to 
>>> initialize inbox mailbox.
>>
>>
>> The other changes are fine, but this one I do not agree with.
>>
>> The rx callback only makes sense for one of the two mailboxes, and 
>> thus is not appropriate for a generic function.
>>
>> Either  initialize_mailbox needs more complex logic, or would blindly 
>> assign the callback to both mailboxes, neither of which simplifies or 
>> streamlines the code.  That function emerged as a way to reduce 
>> duplication.  Lets keep it that way.
>>
> It depends on you. But please reply my below comment. I didn't see any 
> change about it in next version.
>
> -->
>
>> +static netdev_tx_t mctp_pcc_tx(struct sk_buff *skb, struct 
>> net_device *ndev)
>> +{
>> +    struct mctp_pcc_ndev *mpnd = netdev_priv(ndev);
>> +    struct mctp_pcc_hdr *mctp_pcc_header;
>> +    void __iomem *buffer;
>> +    unsigned long flags;
>> +    int len = skb->len;
>> +    int rc;
>> +
>> +    rc = skb_cow_head(skb, sizeof(struct mctp_pcc_hdr));
>> +    if (rc)
>> +        goto err_drop;
>> +
>> +    mctp_pcc_header = skb_push(skb, sizeof(struct mctp_pcc_hdr));
>> +    mctp_pcc_header->signature = cpu_to_le32(PCC_MAGIC | 
>> mpnd->outbox.index);
>> +    mctp_pcc_header->flags = cpu_to_le32(PCC_HEADER_FLAGS);
>> +    memcpy(mctp_pcc_header->mctp_signature, MCTP_SIGNATURE,
>> +           MCTP_SIGNATURE_LENGTH);
>> +    mctp_pcc_header->length = cpu_to_le32(len + MCTP_SIGNATURE_LENGTH);
>> +
>> +    spin_lock_irqsave(&mpnd->lock, flags);
>> +    buffer = mpnd->outbox.chan->shmem;
>> +    memcpy_toio(buffer, skb->data, skb->len);
>> + 
>> mpnd->outbox.chan->mchan->mbox->ops->send_data(mpnd->outbox.chan->mchan,
>> +                            NULL);
>> +    spin_unlock_irqrestore(&mpnd->lock, flags);
>> +
> Why does it not need to know if the packet is sent successfully?
> It's possible for the platform not to finish to send the packet after 
> executing this unlock.
> In this moment, the previous packet may be modified by the new packet 
> to be sent.

I think you missed version  21.

Version 21 of this function ends with:
         memcpy_toio(buffer, skb->data, skb->len);
         rc = mpnd->outbox.chan->mchan->mbox->ops->send_data
                 (mpnd->outbox.chan->mchan, NULL);
         spin_unlock_irqrestore(&mpnd->lock, flags);
         if ACPI_FAILURE(rc)
                 goto err_drop;
         dev_dstats_tx_add(ndev, len);
         dev_consume_skb_any(skb);
         return NETDEV_TX_OK;
err_drop:
         dev_dstats_tx_dropped(ndev);
         kfree_skb(skb);
         return NETDEV_TX_OK;


Once the memcpy_toio completes, the driver will not look at the packet 
again.  if the Kernel did change it at this point, it would not affect 
the flow.  The send of the packet is checked vi rc returned from 
send_data, and it tags the packet as dropped.  Is this not sufficient?





