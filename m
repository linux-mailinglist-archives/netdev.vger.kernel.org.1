Return-Path: <netdev+bounces-97752-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E526F8CD04C
	for <lists+netdev@lfdr.de>; Thu, 23 May 2024 12:24:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 673AD1F23A02
	for <lists+netdev@lfdr.de>; Thu, 23 May 2024 10:24:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DB2E13F011;
	Thu, 23 May 2024 10:24:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b="XtFJJ5OU"
X-Original-To: netdev@vger.kernel.org
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2088.outbound.protection.outlook.com [40.107.7.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6405313D521
	for <netdev@vger.kernel.org>; Thu, 23 May 2024 10:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.7.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716459872; cv=fail; b=O/tu/6Z7iAh0rxcAUce/7gucyHZ1GFBfd/lPlE/pHxvPERxiwgy4O74AF4ZvEktWcqz1OvRp7zfGTPGAQYY3lbn36B6EcyYR0rsm7eo0SO5IZZD1IvnzY1R2xPeUrxAwj4+xWl0hDfeNRZgmFxLmPDFrqE3D1slDNmTiv/5bMzE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716459872; c=relaxed/simple;
	bh=ujkBvsZbVNr7JYwUdybQIp5053JZKIENtlT4bS1DqsI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=DO9y1b/PlbzLSn9jM3l4h2ojFItIKAExZq8e2DHgpLZHDRXTd3HTJ/NhnRA6M4CKDpRDxRAc6s9LiiHd6gKjKnknft299bfkEv02JmxgTF9ruMrxPEbi1xB6dvuqqJojnw653XfZdlWlbQrikgfxhyuUgZgW8dOPBZ8bpGQkGec=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com; spf=pass smtp.mailfrom=2n.com; dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b=XtFJJ5OU; arc=fail smtp.client-ip=40.107.7.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=2n.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WHq1azcFDyAssYyP1u3MFrXV6Uk5uAU8DOs1XM8yWRE3L8UgsQI3qlK9g7NgbqxsmAk4TixrAgt53JYfRtRqV2PhAnP9ZS341/EMs/rJQLOADeX6OlBSxaGEFk/n57k4KuIp1b8eRAQgeEWIw+d6/esT1DxR9n5lTXS0b7pSk0ZngSToc0WznN2r8lkELXKFAZb3kX5IIhe60d0PC/LQSt2TTUfgC3BlMSBThn5BtK0Fl3w9QAaw53UrZAN6/cYioEaplIr8RVFt+rjpUKB18feBrR0fvvbGwltTREZjmYNJsTZaXvN/ShSLqITQeDoaS84nnc+Av0PySeh/LQAeWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I7mlsnRiEGqljVWlwwCnLQBhvyvosxLa1AK3MkUh9vI=;
 b=IW3SCPnJk3wrso9gKo2A+5Tv4FmRbzlHnFX9ETu5jz1w7G15mDrfRe7l22HQEJZrj+6iuEsrExTeFtnj/dWz3v50jlPx34PChz0ygmXKiDJsNzu2t5F7FBGdNyFaEnAo24FjTQmVz8YSdfGFkd8r3jE/k4f6iqLGBo9HK31ocQ3ZnU7bEF+jn2vWVhY+6SLA7iYXmBA5I7JNxZZXg5ZykpaMYC169ZEwu5M3t3iZodmUUyyySVzqjAEzK0QYZ2W0m6gBUsoyBSbn18cs8dwZl6ZIFXawo7Nts6VZAJW/ZUl/IrpYrXQTDO7rMOp+JFcSJu69Ui5vMxVzGNFAx+5nhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=2n.com; dmarc=pass action=none header.from=axis.com; dkim=pass
 header.d=axis.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I7mlsnRiEGqljVWlwwCnLQBhvyvosxLa1AK3MkUh9vI=;
 b=XtFJJ5OUJR4xvu0bPbsux/5FqC5bvuNsKB6UcCHc87AYRyUEVZX2M3DP3GSdiNcwKhNsOSRsTsGUFliKDkxUkOBNQVQPihFz/cxEFlUnx7MOizf2YEYbE84tRDeEJN03Rb4CtTHbyNpTEc5jol5SeGOJFCFMNWEbsxQ6RY3rXZg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axis.com;
Received: from DB5PR02MB10093.eurprd02.prod.outlook.com (2603:10a6:10:488::13)
 by AS4PR02MB8312.eurprd02.prod.outlook.com (2603:10a6:20b:513::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.36; Thu, 23 May
 2024 10:24:25 +0000
Received: from DB5PR02MB10093.eurprd02.prod.outlook.com
 ([fe80::2a25:783c:e73a:a81d]) by DB5PR02MB10093.eurprd02.prod.outlook.com
 ([fe80::2a25:783c:e73a:a81d%4]) with mapi id 15.20.7611.016; Thu, 23 May 2024
 10:24:25 +0000
Message-ID: <c39dd894-bd63-430b-a60c-402c04f5dbf7@axis.com>
Date: Thu, 23 May 2024 12:23:58 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/3] net: phy: bcm54811: New link mode for BroadR-Reach
To: Andrew Lunn <andrew@lunn.ch>
Cc: netdev <netdev@vger.kernel.org>
References: <20240506144015.2409715-1-kamilh@axis.com>
 <20240506144015.2409715-2-kamilh@axis.com>
 <25798e60-d1cc-40ce-b081-80afdb182dd6@lunn.ch>
 <96a99806-624c-4fa4-aa08-0d5c306cff25@axis.com>
 <b5c6b65b-d4be-4ebc-a529-679d42e56c39@lunn.ch>
Content-Language: en-US
From: =?UTF-8?Q?Kamil_Hor=C3=A1k=2C_2N?= <kamilh@axis.com>
In-Reply-To: <b5c6b65b-d4be-4ebc-a529-679d42e56c39@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: VI1PR04CA0129.eurprd04.prod.outlook.com
 (2603:10a6:803:f0::27) To DB5PR02MB10093.eurprd02.prod.outlook.com
 (2603:10a6:10:488::13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB5PR02MB10093:EE_|AS4PR02MB8312:EE_
X-MS-Office365-Filtering-Correlation-Id: a83abaf3-a99c-4452-e0a9-08dc7b1284f2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|1800799015|376005;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?N1VDeWV4Q0RaanFrODRXQ2czQzV1OFlXcUZRRlRpME1LSkpBME43SzFhOStM?=
 =?utf-8?B?VWZWTlZmN0s0N0dCei9QMWRkZTZoZUhhU0lPcVQrWUU3dXhCWlBoeGQ0aDk5?=
 =?utf-8?B?Ry9jbzNJZzYwNTg2QzhHRFM3a0laRG9jS2M2ejBQV0ZnTldtcVlqcVpWQThY?=
 =?utf-8?B?NVpXaldQVVVrci9GYjNHbFZuUzJ2NitOMWZUM0toTHQvZ1dZaDNTNk5jUER0?=
 =?utf-8?B?TDcwVXVjNFVZcDliZVR0cTFCR2xpNnVkVTVqZWxOQ3BvSWdDb2YwTERwYkwz?=
 =?utf-8?B?NXA5RTUvdmFkbDJKUFlPbEg5MEVvOEZGeldxYW8rcDdpT3FMYWprRGM0cE1u?=
 =?utf-8?B?VSsrenJIajRPSzJNWEt1NEYweEhrZ1FDQzQ3Y2dzTzhiMWpUbi8vTmowOVNW?=
 =?utf-8?B?VktNMkVRYWRlK3NvM0VEcllPYUN0NFBWb1BwNTNGRDQzSjQyV2xEamZmTXVL?=
 =?utf-8?B?cUs3Y1ZMVS9iR2tKczZRS0V4QVdRQyt0RUVHd1hvdi9TQVFubmZ2bDRxQ3kw?=
 =?utf-8?B?UXNGYlJEK2cyTkIyR1RTOW1weGw1OXdXMEp3MzN2dlVkOXpUaEsxOVphb1Na?=
 =?utf-8?B?VTNLY3dyUGdLcVhvc2VXZlN1RVp4ZlB1bVQ0eGVzcHBhTC9hWVlHVEJmWVhV?=
 =?utf-8?B?M3Rqd1ZHNjdlTCszZVFXaXhud0JkMUI3QXFUSTRLQlVodW1ybStQTXFJUWdz?=
 =?utf-8?B?c0E3TGczcUxFbUNVNURmZjRNenJ2OUpHL3FuTXRzNU5Pazc3c2VlbXRTb0dp?=
 =?utf-8?B?ekQvSVE3ZGVVZVowTXcrRFhBaXZjSGxmVnU3OUp6OWNwZTZidVRwRGYyb1JR?=
 =?utf-8?B?U3JBZlhZbUp3WXdPNXRxdms2MmtlKytON0FzQUl2YjZSYURWU25LNnFEV2tI?=
 =?utf-8?B?amc3cmtTVTVsd3JhRHFITmVGV0xYNFlwVmlJMEc3a1pPejdqMUxvZHFEdmxy?=
 =?utf-8?B?T0VYM0JubGhMZFFJU3czSEVJUmhBYjZnUlJWTDBJWm9xOVN0NXBodjhvSXc5?=
 =?utf-8?B?SGluYk1wT0Z4K0NwVk9mRW9KS3J6MTJtVzZGZDhsd3lOWExJY0VDZzRCZVZl?=
 =?utf-8?B?OWxDbk9ORjBFQkxLVy9JVWJJditFenl6SCtheTAyNXB2NmF4UXdyV3VqakFh?=
 =?utf-8?B?N1IybDhEam0zZmJVMkpsRDUyMlA0N1JzMkVZMlNEVlF1eFFWa1Vmdmk5cERQ?=
 =?utf-8?B?U2w0TXJkUm8zNWJFWURLNjliUkVYZTRVRkNjZ3BJN1U5cmhJVWEvTm9GYmRM?=
 =?utf-8?B?WFUrQ1N3MXJ5eXIwb28wUGZxNGhjcFJ2b3R3VzlZYVJsRGs0aUVxRGtDUk5H?=
 =?utf-8?B?K3U1OEh6MUU2dWRPeDg0a0xNQjZsK1R1dUNPSUV2aHFxd1hIQUVNTnBPUHFY?=
 =?utf-8?B?NUJIWHVqbkZqYVlaaXRXS1ZZRnFsWTFHT0xzSDd0RCtBbGVxTllxN3pUa0ZZ?=
 =?utf-8?B?WFNYL3lqSmVTTXZNT0RrZ2pwQ0Q3WklxM3M5ejQzclVNU3BPaWtLYnpqQ3BQ?=
 =?utf-8?B?SDhMQVQwVmlIK2w4V21RTm15NGlCOExuUXBJMnRVOVovTmNkVkpveDVWSDlv?=
 =?utf-8?B?cnd3R3cySnMvMFkvOEhuYXg1enhqYWRFa085MWg1akkyUS9VKzhiSzBpYkQx?=
 =?utf-8?B?TVh0RXBsOGR4ZEQ0ZFdmc2NTd1hySktPLzRUQjRJVndrRTFndXpHTE9IWmJF?=
 =?utf-8?B?YmZuTTV6NDBHTllZUjgrN24valRTRTMxQkVMa25hUjEwU0x3WDNTbHhnPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB5PR02MB10093.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dS92SlpNVCtORXRsM2lKS2kwY1ZDdHV0RTdOeml4Ty90aWgzSDFRVUNrd2xD?=
 =?utf-8?B?cjB3REQ1bGdGWWp5YlRQWVl2ckZ4L2FQSGh4OGZQOWo3YlhuTDk5T2dNR0dR?=
 =?utf-8?B?ZHo0K08rT2ZtWklSc0pGTjYzQWJFQ3JVdWJPTG81aDhuMlFDc21nWmdFR2Er?=
 =?utf-8?B?YVJWMm14SmJ1L2hkMG1ZVEFLQzdtZkVkd2tNYTV0TnNJL2FMQ0hyZUJOLzNM?=
 =?utf-8?B?ZnZvYm55bHQ1ZHhTYkhFVWRHWHlwaE9EdHJwSkRhcEhySjZzNmdMMXZoWWEr?=
 =?utf-8?B?U0J0cFhuLzFEcWF4QjZVOU9GZ0ZqT2Y0bHlxb0R1WFEvN3N2ZHV1SUIwWDU0?=
 =?utf-8?B?RUR5ZnU3MkF0ZGhpZEhkWHBDTUswdkpPMS9ad3JmMFlmVmtodUlqVGs2dGh3?=
 =?utf-8?B?QU03cjZJVWZvSkg2Z2lTWnhKZTltTXFmMWNYWkgxak95R0MwVzh3TTZJTWNw?=
 =?utf-8?B?MHNZY250cS83Q3JHTWFzdklmQmhVVFZCS0VzN25WS2x3a2dZNjBpNm5FQ1ZY?=
 =?utf-8?B?b3RacmQrTVFJMGlHcWRJMkZjL29PV3BIRlI3MHU4TUMvQnhYYkplU3VIU2lX?=
 =?utf-8?B?aVlDMFJIM05HMGVRdzdvaXA4bm0yYy9wSWREUmRsSG1zZTlJWGNJODY4eE1M?=
 =?utf-8?B?U0JYOVd2empCZ0pLa2V5Z2JGeW1yRnVKbkx3bXc4QUptT25kSWVieW4rWTFZ?=
 =?utf-8?B?UkEwWnR0MXBjdHJpMXJFaStwcThQVjN0SzROQUs3eFJUQmtMU0p4ZWpMTi95?=
 =?utf-8?B?YnJyV3hDUHhtYk5iMk5iWGhVV0oyTERhYUVvK3FaVjF1M0p2MUw2djhtaXAx?=
 =?utf-8?B?aDN4Ni93VnV3Q1ZmRzN3S09tWDVvZ1BsRkgyeCsvRFc4SThjZUVJTmpvczRv?=
 =?utf-8?B?bjh2Rm9JTmpMYjNBT05pZVNYeVNDR21HVk5MenE2c3h1K2JYeXNCb0pGb1E1?=
 =?utf-8?B?LzFCWHdtN2llbzNTMXlsME03QlU0RDVCYzN1VVVEbWp2TS8yckwvR1ZSQm1p?=
 =?utf-8?B?UHFvcXZoMy8vNEg3VzQ2R0VuZTQ4S2k5dzZSKzErMVNvS2JyWWUxTHl2ZWli?=
 =?utf-8?B?Sm9jSnljeGRNM0NwR1BBVDdxUGFYQ3p0ZmtUd3N6Uzh1emJvQ3dyMlZPVVNF?=
 =?utf-8?B?bTZWVGRxM252UHBKSHMrVVRQWi9vT0tLeFdMNUxvSmQvOThYTVFQVmN5YWJY?=
 =?utf-8?B?bURVa1lVeHZLQ1dQVlBIckRaR0FnVUs4UitzeXcxbk5zZmczczRzNER0dHJI?=
 =?utf-8?B?V01KejluK0J0L0d0c1dqRHJzemVPckpjV1NYRXNTUHNBbjk3eTEwaGk1U3Ft?=
 =?utf-8?B?bTFyL29ycFl3Nk1SRklRSG1acld4QzNIL3FnQnJVb3FPbTBXU3pTTm5HSTha?=
 =?utf-8?B?Ui9mblJLOGZ1bDZqSlRLd1pnSUdHb1p6ZGdOMkMrdXFhY3V2ZGhUUTZHaHBo?=
 =?utf-8?B?OUlHaWxTRmFrN2F1cy9Sd3E4Q1l2N1YwQ1hOMFZzdW5waklGVlZrTDlDcGtD?=
 =?utf-8?B?MlJrVWNUbFZ2RkVOU3ZGZ2dROFhWbWEzYkszZU5XZldEd1hkMjlERXY1L01P?=
 =?utf-8?B?cUEvNHZqcDJOdkRFeTRJUW9DNGtoV0ZlVkY2dk5zTGRxSTdzZEtodXEyOWFZ?=
 =?utf-8?B?UFVNWnVFRytwYTU3S3lCcUd5QnNZano3dGJXaXZWRVdCZG1JUjBaUU5GM3Zo?=
 =?utf-8?B?R0pSN2ZrOFlyQklYOTZ6Q3JCRzYyemJuUGpnR2N3bkYzWnd6TDJLVjBKaUhV?=
 =?utf-8?B?U0R0THZFMDdWTjdYempYdThkYjh6blRxaUYvTDIzaUVyd1VyS1BtaFZZbEQy?=
 =?utf-8?B?N05TQTB6WS9vallHc3ZPSmh1OHZSdnBFY0pEVkcwbVNkNjFtdnZuZWZxY1M4?=
 =?utf-8?B?Y2dwZGlQeGdxQWpWTGx5M21GRUV5cEc4dFFtd1FLTVhyZGQzdjE0R3NUY214?=
 =?utf-8?B?blV1ZlhPdDAwSWJXRlVXcXFIcS9CeTlDVTluK2NIam8rRC9QTU9HK1lHczRH?=
 =?utf-8?B?WDVMSXNXTTlKNVF1VU9yZVVtTWp1QUY3QUlFZEhPbkE0djhXcTM1OXo4Y3U1?=
 =?utf-8?B?WlV4UGsxc0tQbTRzaTJxdXdMZnZKdVJLU2RjV3h2a25Cd2dMS1hxMlFqVytZ?=
 =?utf-8?Q?UkZytEwgrnzKw0cbZwMaI9S1n?=
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a83abaf3-a99c-4452-e0a9-08dc7b1284f2
X-MS-Exchange-CrossTenant-AuthSource: DB5PR02MB10093.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2024 10:24:25.0530
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2QG+8gPhyhraFr4IoBVUJ0NtvDslBeOu/BfrpQGWY/ATor5FAKhzUVIN2CSRh2AY
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR02MB8312

On 5/22/24 16:05, Andrew Lunn wrote:
> On Wed, May 22, 2024 at 09:34:05AM +0200, Kamil Horák, 2N wrote:
>> On 5/6/24 21:14, Andrew Lunn wrote:
>>> On Mon, May 06, 2024 at 04:40:13PM +0200, Kamil Horák - 2N wrote:
>>>> Introduce new link modes necessary for the BroadR-Reach mode on
>>>> bcm5481x PHY by Broadcom and new PHY tunable to choose between
>>>> normal (IEEE) ethernet and BroadR-Reach modes of the PHY.
>>> I would of split this into two patches. The reason being, we need the
>>> new link mode. But do we need the tunable? Why don't i just use the
>>> link mode to select it?
>>>
>>> ethtool -s eth42 advertise 1BR10
>> Tried to find a way to do the link mode selection this way but the
>> advertised modes are only applicable when there is auto-negotiation, 
>> which
>> is only partially the case of BCM54811: it only has auto-negotiation 
>> in IEEE
>> mode.
>> Thus, to avoid choosing between BroadR-Reach and IEEE mode using the PHY
>> Tunable, we would need something else and I am already running out of
>> ideas...
>> Is there any other possibility?
>>
>> In addition, we would have to check for incompatible link modes 
>> selected to
>> advertise (cannot choose one BRR and one IEEE mode to advertise), or 
>> perhaps
>> the BRR modes would take precedence, if there is any BRR mode 
>> selected to
>> advertise, IEEE modes would be ignored.
> So it sounds like multiple problems.
>
> 1) Passing a specific link mode when not using auto-neg. The current
> API is:
>
> ethtool -s eth42 autoneg off speed 10 duplex full
>
> Maybe we want to extend that with
>
> ethtool -s eth42 autoneg off speed 10 duplex full linkmode 1BR10
>
> or just
>
> ethtool -s eth42 autoneg off linkmode 1BR10

This sounds perfect to me. The second (shorter) way is better because, 
at least with BCM54811, given the link mode, the duplex and speed are 
also determined. All BroadR-Reach link modes are full duplex, anyway.

>
> You can probably add a new member to ethtool_link_ksettings to pass it
> to phylib. From there, it probably needs putting into a phy_device
> member, next to speed and duplex. The PHY driver can then use it to
> configure the hardware.
I did not dare to cut this deep so far, but as I see there is a demand, 
let's go for it!
>
> 2) Invalid combinations of link modes when auto-neg is
> enabled. Probably the first question to answer is, is this specific to
> this PHY, or generic across all PHYs which support BR and IEEE
> modes. If it is generic, we can add tests in
> phy_ethtool_ksettings_set() to return EINVAL. If this is specific to
> this PHY, it gets messy. When phylib call phy_start_aneg() to
> configure the hardware, it does not expect it to return an error. We
> might need to add an additional op to phy_driver to allow the PHY
> driver to validate settings when phy_ethtool_ksettings_set() is
> called. This would help solve a similar problem with a new mediatek
> PHY which is broken with forced modes.
Regarding the specificity, it definitely touches the BCM54811 and even 
more BCM54810, because the ...810 supports autoneg  in BroadR-Reach mode 
too.
I unfortunately do not have any device using BCM54810 (not even a 
devkit) available to test it, thus I only can do the BCM54811 driver.

With BCM54811 and considering no explicit BRR / IEEE switching (as it 
was originally intended by adding a tunable), we definitely have to 
check the set of selected link modes for applicability and return (and 
handle)  the error caused by impossible combination. Originally, I 
thought about abusing the autoneg with only one mode to select that mode 
without negotiation but that would apply only to BCM54811.
Thus, for BCM54811 I suggest to ignore BRR modes if there is at least 
one IEEE one in the set and report an error for not applicable set (BRR 
modes only).  For BCM54810 we should accept only sets consisting of link 
modes of same type (IEEE or BRR) and switch between IEEE and BRR as 
needed, but this would be likely a task for someone else. I do not have 
the hardware at hand. I'll do it with anticipation of such possibility, 
right?

>
>      Andrew


Kamil

