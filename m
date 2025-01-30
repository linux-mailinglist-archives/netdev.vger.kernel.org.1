Return-Path: <netdev+bounces-161620-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EBC6A22BB6
	for <lists+netdev@lfdr.de>; Thu, 30 Jan 2025 11:37:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BEAE0168362
	for <lists+netdev@lfdr.de>; Thu, 30 Jan 2025 10:37:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A1031B87ED;
	Thu, 30 Jan 2025 10:37:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mysnt.onmicrosoft.com header.i=@mysnt.onmicrosoft.com header.b="ScDFeCPd"
X-Original-To: netdev@vger.kernel.org
Received: from outbound.mail.protection.outlook.com (mail-vi1eur05on2137.outbound.protection.outlook.com [40.107.21.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EBCF1474DA
	for <netdev@vger.kernel.org>; Thu, 30 Jan 2025 10:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.137
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738233421; cv=fail; b=RERpRSxwBlLCUC/R4YvQcfprVIkEGtilbJ7o5NtB78e+7+wFmvzDUKaZsKAkVWsZQhcpDHgQDuefGIT/ScDBJ8FVWthXdYdmTmHgycEFuxXuGqsRDfjHyz4a2OrY+3RWPW2eVw4stvJXwcliwFvXsOIWil3LA30MSepUjoxDKnI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738233421; c=relaxed/simple;
	bh=2uucSsMa8vNnVppH7++ZE2aG0kTdouCv7chuN++1Axw=;
	h=Message-ID:Date:Subject:From:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=MuaflrFaXxVg4v2sJg9GAQV4tYL5P5YjAUnNLBxMibF/rCWVRL2LvnB11cNtQUEreh0dPY51uPHi5jnl8bXwO/MAmBfBaA96Wr7vfxe/1Q8fL4R73ZCqiKDdrYEE4NwScxo3wUiOlFCibh4fhOonOh1+dAg6T4wh5uUYl2IQlR4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kontron.de; spf=pass smtp.mailfrom=kontron.de; dkim=pass (1024-bit key) header.d=mysnt.onmicrosoft.com header.i=@mysnt.onmicrosoft.com header.b=ScDFeCPd; arc=fail smtp.client-ip=40.107.21.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kontron.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kontron.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=c1hAbMZU5FtA6qJUhQ6J9nr0qw6k0pc9XwsIok3yK367RewbigISsyxh3N7qxFHOMsMboFA4IIdayL2q/Y9hFgG8w+gx/ifpxkbtveWHvuxQcyXQbiYLi9ZfRUhpYQ4CZev64WUHv6qosDzLNdzRS8yHsILb7sewVponaMVI3GKBQ59x9kEj+uvhOMAkOS9V1uA7tRHJrfFfCGzgdWMy5aNet8Z8VJ8LtWG0x1u8InXW7DZCkh73EDrwLLVx1xDDi6t+IgAKVoKUQ9hy6s06rPr0AIFplJk8fIGUJRPD12qSCFb5mj0s8h/WMZKHGwyHk35Yr3rJiSxMRyJUB46cxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HVdFpFdKUBNrpmEuDiAnHf/Ff2Mxqr5q2T4p6aKBGQM=;
 b=RCINSyUOKjk/1cxD3uX488iH6Wl6tNgIFf+OlTyhtNycySTY13gR3rfBKnDGW3EGcsFqddkH44Ho0h++XMvOSRoM6gCIAZ6DQlFm1YoKvljba9/6aaoGyXbb7xuQJSJ3ptN3aXwCocZ9J60T1qNe3er2pjg/+qJ/cuk8KroWP4aaneCV55qIxRWyfWd77y1EsJ2qsRSsQJsJNN1ECr96u6bQFp2O2eKXNYAbXEe2/IqIu7mH8dogpmRZ90j68lv2eaeVgPE88PGawOBKAVyVeYLOPPmWzjpEYho4aL7eroblM8WXXa/lzG2e6IG0V/zqqBpHfopfbkJXYTIN7447eQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kontron.de; dmarc=pass action=none header.from=kontron.de;
 dkim=pass header.d=kontron.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mysnt.onmicrosoft.com;
 s=selector2-mysnt-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HVdFpFdKUBNrpmEuDiAnHf/Ff2Mxqr5q2T4p6aKBGQM=;
 b=ScDFeCPdIh6VhY6xEzVu81K/PyiTzGPp7sqY/kTUGeFM7F2muRgU9+QEcuyuCV3/XmwTplDGr5YrgDwAd/hjgggHgwPwg6vV65mNHHWFPvy9KAQ7j6uoCnNeAJEP+fY3t5QUtrIrrrzpMjWnal5tW8Ypx7/i5YzhpnqPeDbTL1g=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kontron.de;
Received: from PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:263::10)
 by PA1PR10MB8838.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:443::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.5; Thu, 30 Jan
 2025 10:36:54 +0000
Received: from PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::b854:7611:1533:2a19]) by PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::b854:7611:1533:2a19%4]) with mapi id 15.20.8398.017; Thu, 30 Jan 2025
 10:36:53 +0000
Message-ID: <af73e5bb-c73d-4f7a-a118-97345e9512fe@kontron.de>
Date: Thu, 30 Jan 2025 11:36:52 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: KSZ9477 HSR Offloading
From: Frieder Schrempf <frieder.schrempf@kontron.de>
To: Lukasz Majewski <lukma@denx.de>
Cc: Andrew Lunn <andrew@lunn.ch>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>
References: <05a6e63e-96c1-4d78-91b9-b00deed044b5@kontron.de>
 <6d0e1f47-874e-42bf-9bc7-34856c1168d1@lunn.ch>
 <1c140c92-3be6-4917-b600-fa5d1ef96404@kontron.de>
 <6400e73a-b165-41a8-9fc9-e2226060a68c@kontron.de>
 <20250129121733.1e99f29c@wsk>
 <0383e3d9-b229-4218-a931-73185d393177@kontron.de>
 <20250129145845.3988cf04@wsk>
 <42a2f96f-34cd-4d95-99d5-3b4c4af226af@kontron.de>
 <20250129235206.125142f4@wsk>
 <d8603413-d410-4cc9-ab3a-da9c6d868eca@kontron.de>
Content-Language: en-US, de-DE
In-Reply-To: <d8603413-d410-4cc9-ab3a-da9c6d868eca@kontron.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0149.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b8::15) To PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:263::10)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR10MB5681:EE_|PA1PR10MB8838:EE_
X-MS-Office365-Filtering-Correlation-Id: 2343113a-3fbc-4d2d-affa-08dd411a0325
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dURIdmloUGx0Nm9VZnUvMjcxbEVRRVNGQlo3VXpEZkI2d1V2Wlp6SytWVkl2?=
 =?utf-8?B?RW53Rk9yREFZNUlxWWVyZ2NSNU04empUc202Tlc3TXhlWGRUWVA0bGRUZkNJ?=
 =?utf-8?B?SjI4d2hISnR3K1c4Vm1LOVVpc0VpOE5Sd2x0YkZVQXJRaHVuOHIvSm9zeW1H?=
 =?utf-8?B?bkp1Y2ducTN1Q1gwc0pvY0ppd2N5SERKU3VDVTUxc3lvRHg5d1BPVVJ2dEZ3?=
 =?utf-8?B?dmpzQldVOHBqUkRPMEk3SjBWSUFFSENxeXNOVU5WWnZhY3BVOUMwMnd4V0Fr?=
 =?utf-8?B?OW5jeExBRzE4QTgyNkc2emU3TjFNM2FGYzVGWWZ1SG1QNWRRZWhBREptM0hD?=
 =?utf-8?B?STdtN3JTalZ1K2tTU2V0U1hONmZLQXVqcWRYYjV0SmI5L1hudjh5eGhyVUEw?=
 =?utf-8?B?MmVUSHN6K0NxemV0Ymg3RDVMbTBNZGRFZkNGaXBWN3I2VFNaOHFQZk9kV0g3?=
 =?utf-8?B?bXJkejVOSFZiOUlneVhGeFR1Tmg0SmZZYk9Ibnp3bXdiWHcyUmRsR2QwekpO?=
 =?utf-8?B?VVNCL0s1ckxsZExLM2VNUS8xYjZJblhORXZ5OXpJaExOcExkL0VhSUo1QUFm?=
 =?utf-8?B?MFlnV2JnOFBQcGtrY2VTbUl2TlczYVFCTEZPL0pyS1Y3ZUEvVGpnc0tHbThy?=
 =?utf-8?B?d2l5YVlHSFI3VHIxTXZ1ODhlZEZ4TzcvQ2RNSlZmdUIyNHBER2E0d2NWQVFK?=
 =?utf-8?B?WENoaTdTSU5Oa24wWDN1azR6ZXZIWWd2VXd3RXVUU3JYenZYN3pEV3NvK0N1?=
 =?utf-8?B?N0NMSVVqS1BHWFo0VzNOZW1GbXlieTJjK3BjeS9ibndOQlN6dUVHUzJyUkt5?=
 =?utf-8?B?U29keFcrOGRYbDQxd2JHenZDMkY5MWxkbzBwQWsvUHNCd20rK3VCYjc1U01J?=
 =?utf-8?B?VTVqSXVUa0lTSEF0SjZEWE42U0EyYTgyTE5lRzRFc3ZRdDJEOXhDMW5SMWN6?=
 =?utf-8?B?d0pUZ0JxSXpOWXd2bHlUT2ZwV0pveVdGTnZBTThOZy9FZ2wxeEY5azdwZzJq?=
 =?utf-8?B?cXJUNGl1OW1wQ1FGVEd2NHl4QmFvU3VFZ1pwQS9kR3hNaldLZXhJSlFocUc0?=
 =?utf-8?B?TzUyR3FvempmNVpNWjRUSklFQlJTV2ljT0pQS3kwaW1XQnlnUFBobzZmQmxD?=
 =?utf-8?B?d3orak9mUzd5R0VpNkkzdm5kYSsyZnViU2lDQmM1Qm05RnJLT3hVVWtuSXZ1?=
 =?utf-8?B?WG15V091MkN2M1VKRkhOMlBlM2swdWs4eXZQd0J0OThaWFJlRUJnanZsMVpa?=
 =?utf-8?B?SmZjOVhnNFNOVGFtRTR4M0FKMEpLcFVIUWljVTRaV0RHdlFVMGhJdXNXS1RU?=
 =?utf-8?B?eHZHRWZ5d1hZUldCYzduM094OVh5cXprRVRvVXltK0hvYzR4T0orSDB2WVpL?=
 =?utf-8?B?M2FJamdrYWhWU0puaWpSTEVzRFYwTzk1cy9rQXpudVQvVWdxcy9FR2FwUXVn?=
 =?utf-8?B?ODQycjdTK2tiaG1wUmo5N0RMaElSaFdITjhLSDRxU05PbTVvQ3Ixbm5HSm1v?=
 =?utf-8?B?OHVDeUdDa3hSS3FCd3BUR1RaeFkyNE81bHZqc1liSDJ4Qm9Belh2M3gyQVU0?=
 =?utf-8?B?dkphTWZtcUZFVjlkVFJ0OFh0Z1Bxb3QzU1hlaWExaW84TW01SzZIS01JZjVa?=
 =?utf-8?B?WUlraEpxV1gvSHhDUUN6eWdvL0lwb0lMcklFYXRuWkNOTWtTZmtaQVRxa05w?=
 =?utf-8?B?ejZUVGJGeDdSWWZTRXh4S0ttVHI2TEJPcU9KbFRUaVh5Y1JQYXRQTXB6RFFk?=
 =?utf-8?Q?W01CakXoGhSrsO8kOt23+dD3hh04BCcxsBQxDxh?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NjY0aXB5cXp0cTFTN1EzNnByaERObk80b3Bpb05ySWkrWERjalpqM0hXNHVI?=
 =?utf-8?B?VnVwK2VhMzY4YVZjZXVINzY3VjliZkdVbGgxbkFvQ2NwWHJxMkl5bHE0em1p?=
 =?utf-8?B?VUluQSt5bWRhSlRpZzRmVTBrdXptQjdPcVppSXEvbk96NHdhT2xvNmNZVnNy?=
 =?utf-8?B?ak5JRFNzUXBFYUVhUWZpN094K2xqcldsQ3ZQRkdrL3IwS3Y3Rno3ZWpkcC9Q?=
 =?utf-8?B?M21zbUJtVjhMSytwRDU0bGJuNUpGTlNTS1Z3NWJLNVhHQnh5SmtmZk5LbkZv?=
 =?utf-8?B?c3ZlWlg2TDN4YUFuOEtHVzdtWFpESmdWeHc2NDhRSnFoVi91UEZhKzRCRGsv?=
 =?utf-8?B?Q2ltd05Xb0Y1dGYrTk94Y1FjUDZsaFVkanhoWTkwa3lrT1dIS3NYS2lNUko5?=
 =?utf-8?B?bEdjT016bm1obXVKTzVjaXNicTJTM3ZSZ2NxQmluck53YVYwM3FpaEphM3dp?=
 =?utf-8?B?QlpxMFZWMytCdU9FVFl2QXB4cTFCWGUyY0xCSmdwNk1sa3RYbUhVMGJQRVhh?=
 =?utf-8?B?L0x1eW5qazU2QnVCM08vZ0lWNlpUOUxxT2ZaL0tvYUFZbzlRL29QZkI4Zzd4?=
 =?utf-8?B?VmJwQTdsK29oRU4rWG9ja3RMVHkwQ0grRzFRbzFmU3RpSlpHcU5PZUhaRVFw?=
 =?utf-8?B?akZMUXNVUEdxWWh4Q0pQd1M4MFZjOVBSK0x3TFpFdFMwcndOaHFQaHlLMUtU?=
 =?utf-8?B?U2picHh4K1VkSFczVVB0dFlvaFlpN1VpeCtEVTRFQWZmZ0k1Nm9DVjhlbFdh?=
 =?utf-8?B?NWhJKzB4RnhiOVZlbzhHWlRqbFZ6OWNjUVNFbCtidUlWQWMrdzFIRmNRWVNv?=
 =?utf-8?B?SFB2SzV5VExQcjI4Tk5ETVErampFakhheldoVmdXVWpnREU4czZoeEZUUVlG?=
 =?utf-8?B?NGtJUFR0YlRHcW9pcEVQY055K2JjSFZVZmxwOVA1Tm4rUkd0Y3R0WENRQUZi?=
 =?utf-8?B?aHlUVUpuMUJERE9aSmhYemhJZ3JjRGdtRVlHbFFZN21yR0hEMXdVSExOMEV4?=
 =?utf-8?B?Q2haQ3BFaW10TGYzdUVDTnF4dWgvMVZrZ3JWMmxIdEhudjYybVhOZ1FIMk1R?=
 =?utf-8?B?NE9UOUphM2lmUzZrMHpIYk1qMVliMUYwbzZsN2FSRzF3MDhxUjlaVHc5bFQw?=
 =?utf-8?B?WENsMWpYQkVSVy9lOTVhQ2R1NTFiSWxCTnVaalNxcE00Umx2NkJvY1QrVUYr?=
 =?utf-8?B?emNhWGtDWitUdVdVOWV0dkIwR1RVZ042N21OcSs2dVN3RmhOVnFsM0trSm1z?=
 =?utf-8?B?NW1BbHpXVnVSbGt3THFmZEhHam1kQklocGJVNm9uMVM5TytXRGZDaFZrd0ZZ?=
 =?utf-8?B?S0NraVRvcmprWnhsQmc1THo4MVZ1M1BUeEtJVG5DY3cwaGtWamdialR2cElz?=
 =?utf-8?B?MVd6UG1DUCtOQktFY3FyQUd5TTI4aFZiMG5ES3BPazFWcnVxbk9OdU9aQ1Vr?=
 =?utf-8?B?YkVzQUp6bFJwUUhzMWtURmJDQTcxSmFSM3B0cGpxZ3ZNTjdiZHJEY1lBSEtn?=
 =?utf-8?B?U3FRVEdJTkI4TGVtZkVoZThIMG1Pb3E1Nm9TS05MWFFmektKMnNsUWhRYVdH?=
 =?utf-8?B?MXdsZTB3U3NMWXV0TTlIR1c4M1lwWGFzcHBzWnhJMUVNdWdxTldMQzE0VC83?=
 =?utf-8?B?VDNMMFBmbVVLY3BxaFliNmVFbUsxQzJRdnVBa2hVRm4va01PRHJ3TEl2TWdU?=
 =?utf-8?B?OVArd1ZWKzEzUXlUeWZ0ZEVFK05pVDdId2Z2VXZyb3ZlSThDdVUrSlY4dFFl?=
 =?utf-8?B?dkJJVmFtQlRNZ3VLdGI5NFZIbFFMRDR5MnYyTFJMSWxNcVI1MUJlQ1ArQ2VM?=
 =?utf-8?B?dTJnTDVyYmtDUVM4WXpaaXJHTEdnOEt3NFZudW1UaG0vdzBOWEloajJPSGZB?=
 =?utf-8?B?RUV6VFpEMlFDWFJ2bERjQ09LTjRHSXVISWMzS3pHRmZubFp5dGRjK3RJYUJS?=
 =?utf-8?B?VjRlQnlLUHJsZXQvalU0RWF4SDl6SnNIZjVla0U2WXVzUktOTXkycjltS2Mx?=
 =?utf-8?B?SGdhQ05mNzkrdmtkQVJqLzMrR0dzWEE2cFJtMjlYZlE1Nm1iV0xQSmUrT2lF?=
 =?utf-8?B?NVhObVJ1bmxjbjFwUDFubWs4NEFtcVl1THUwcVJNbURkT2xLVFlKaTVxSHZp?=
 =?utf-8?B?U3RHQjMydS9lcFhuK0RvTzBvWXI1WWtnbmxucDl6QlZBQ1k5dUg0Vlk0SEF5?=
 =?utf-8?B?b0E9PQ==?=
X-OriginatorOrg: kontron.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 2343113a-3fbc-4d2d-affa-08dd411a0325
X-MS-Exchange-CrossTenant-AuthSource: PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2025 10:36:53.5686
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8c9d3c97-3fd9-41c8-a2b1-646f3942daf1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: StB/CjZsgMynMuod2W1SekZDH5hEBIQpGuM1ngk1JJz3nH/2j2D4ipvDc6Wfyyleokyg+Y5LrhD1eJM2CcfVensGRLx6fddoImIhkgf4JNw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR10MB8838

On 30.01.25 11:19 AM, Frieder Schrempf wrote:
> Hi Lukasz,
> 
> On 29.01.25 11:52 PM, Lukasz Majewski wrote:
>> Hi Frieder,
>>
>>> On 29.01.25 2:58 PM, Lukasz Majewski wrote:
>>>> Hi Frieder,
>>>>   
>>>>> Hi Lukasz,
>>>>>
>>>>> On 29.01.25 12:17 PM, Lukasz Majewski wrote:  
>>>>>> Hi Frieder,
>>>>>>     
>>>>>>> On 29.01.25 8:24 AM, Frieder Schrempf wrote:    
>>>>>>>> Hi Andrew,
>>>>>>>>
>>>>>>>> On 28.01.25 6:51 PM, Andrew Lunn wrote:      
>>>>>>>>> On Tue, Jan 28, 2025 at 05:14:46PM +0100, Frieder Schrempf
>>>>>>>>> wrote:      
>>>>>>>>>> Hi,
>>>>>>>>>>
>>>>>>>>>> I'm trying out HSR support on KSZ9477 with v6.12. My setup
>>>>>>>>>> looks like this:
>>>>>>>>>>
>>>>>>>>>> +-------------+         +-------------+
>>>>>>>>>> |             |         |             |
>>>>>>>>>> |   Node A    |         |   Node D    |
>>>>>>>>>> |             |         |             |
>>>>>>>>>> |             |         |             |
>>>>>>>>>> | LAN1   LAN2 |         | LAN1   LAN2 |
>>>>>>>>>> +--+-------+--+         +--+------+---+
>>>>>>>>>>    |       |               |      |
>>>>>>>>>>    |       +---------------+      |
>>>>>>>>>>    |                              |
>>>>>>>>>>    |       +---------------+      |
>>>>>>>>>>    |       |               |      |
>>>>>>>>>> +--+-------+--+         +--+------+---+
>>>>>>>>>> | LAN1   LAN2 |         | LAN1   LAN2 |
>>>>>>>>>> |             |         |             |
>>>>>>>>>> |             |         |             |
>>>>>>>>>> |   Node B    |         |   Node C    |
>>>>>>>>>> |             |         |             |
>>>>>>>>>> +-------------+         +-------------+
>>>>>>>>>>
>>>>>>>>>> On each device the LAN1 and LAN2 are added as HSR slaves.
>>>>>>>>>> Then I try to do ping tests between each of the HSR
>>>>>>>>>> interfaces.
>>>>>>>>>>
>>>>>>>>>> The result is that I can reach the neighboring nodes just
>>>>>>>>>> fine, but I can't reach the remote node that needs packages
>>>>>>>>>> to be forwarded through the other nodes. For example I can't
>>>>>>>>>> ping from node A to C.
>>>>>>>>>>
>>>>>>>>>> I've tried to disable HW offloading in the driver and then
>>>>>>>>>> everything starts working.
>>>>>>>>>>
>>>>>>>>>> Is this a problem with HW offloading in the KSZ driver, or am
>>>>>>>>>> I missing something essential?      
>>>>>>
>>>>>> Thanks for looking and testing such large scale setup.
>>>>>>     
>>>>>>>>>
>>>>>>>>> How are IP addresses configured? I assume you have a bridge,
>>>>>>>>> LAN1 and LAN2 are members of the bridge, and the IP address is
>>>>>>>>> on the bridge interface?      
>>>>>>>>
>>>>>>>> I have a HSR interface on each node that covers LAN1 and LAN2 as
>>>>>>>> slaves and the IP addresses are on those HSR interfaces. For
>>>>>>>> node A:
>>>>>>>>
>>>>>>>> ip link add name hsr type hsr slave1 lan1 slave2 lan2
>>>>>>>> supervision 45 version 1
>>>>>>>> ip addr add 172.20.1.1/24 dev hsr
>>>>>>>>
>>>>>>>> The other nodes have the addresses 172.20.1.2/24, 172.20.1.3/24
>>>>>>>> and 172.20.1.4/24 respectively.
>>>>>>>>
>>>>>>>> Then on node A, I'm doing:
>>>>>>>>
>>>>>>>> ping 172.20.1.2 # neighboring node B works
>>>>>>>> ping 172.20.1.4 # neighboring node D works
>>>>>>>> ping 172.20.1.3 # remote node C works only if I disable
>>>>>>>> offloading      
>>>>>>>
>>>>>>> BTW, it's enough to disable the offloading of the forwarding for
>>>>>>> HSR frames to make it work.
>>>>>>>
>>>>>>> --- a/drivers/net/dsa/microchip/ksz9477.c
>>>>>>> +++ b/drivers/net/dsa/microchip/ksz9477.c
>>>>>>> @@ -1267,7 +1267,7 @@ int ksz9477_tc_cbs_set_cinc(struct
>>>>>>> ksz_device *dev, int port, u32 val)
>>>>>>>   * Moreover, the NETIF_F_HW_HSR_FWD feature is also enabled, as
>>>>>>> HSR frames
>>>>>>>   * can be forwarded in the switch fabric between HSR ports.
>>>>>>>   */
>>>>>>> -#define KSZ9477_SUPPORTED_HSR_FEATURES (NETIF_F_HW_HSR_DUP |
>>>>>>> NETIF_F_HW_HSR_FWD)
>>>>>>> +#define KSZ9477_SUPPORTED_HSR_FEATURES (NETIF_F_HW_HSR_DUP)
>>>>>>>
>>>>>>>  void ksz9477_hsr_join(struct dsa_switch *ds, int port, struct
>>>>>>> net_device *hsr)
>>>>>>>  {
>>>>>>> @@ -1279,16 +1279,6 @@ void ksz9477_hsr_join(struct dsa_switch
>>>>>>> *ds, int port, struct net_device *hsr)
>>>>>>>         /* Program which port(s) shall support HSR */
>>>>>>>         ksz_rmw32(dev, REG_HSR_PORT_MAP__4, BIT(port),
>>>>>>> BIT(port));
>>>>>>>
>>>>>>> -       /* Forward frames between HSR ports (i.e. bridge together
>>>>>>> HSR ports) */
>>>>>>> -       if (dev->hsr_ports) {
>>>>>>> -               dsa_hsr_foreach_port(hsr_dp, ds, hsr)
>>>>>>> -                       hsr_ports |= BIT(hsr_dp->index);
>>>>>>> -
>>>>>>> -               hsr_ports |= BIT(dsa_upstream_port(ds, port));
>>>>>>> -               dsa_hsr_foreach_port(hsr_dp, ds, hsr)
>>>>>>> -                       ksz9477_cfg_port_member(dev,
>>>>>>> hsr_dp->index, hsr_ports);
>>>>>>> -       }
>>>>>>> -
>>>>>>>         if (!dev->hsr_ports) {
>>>>>>>                 /* Enable discarding of received HSR frames */
>>>>>>>                 ksz_read8(dev, REG_HSR_ALU_CTRL_0__1, &data);    
>>>>>>
>>>>>> This means that KSZ9477 forwarding is dropping frames when HW
>>>>>> acceleration is used (for non "neighbour" nodes).
>>>>>>
>>>>>> On my setup I only had 2 KSZ9477 devel boards.
>>>>>>
>>>>>> And as you wrote - the SW based one works, so extending
>>>>>> https://elixir.bootlin.com/linux/v6.12-rc2/source/tools/testing/selftests/net/hsr
>>>>>>
>>>>>> would not help in this case.    
>>>>>
>>>>> I see. With two boards you can't test the accelerated forwarding.
>>>>> So how did you test the forwarding at all? Or are you telling me,
>>>>> that this was added to the driver without prior testing (which
>>>>> seems a bit bold and unusual)?  
>>>>
>>>> The packet forwarding is for generating two frames copies on two HSR
>>>> coupled ports on a single KSZ9477:  
>>>
>>> Isn't that what duplication aka NETIF_F_HW_HSR_DUP is for?
>>
>> As I mentioned - the NETIF_F_HW_HSR_DUP is to remove duplicated frames.
>>
>> NETIF_F_HW_HSR_FWD is to in-hw generate frame copy for HSR port to be
>> sent:
>> https://elixir.bootlin.com/linux/v6.13/source/drivers/net/dsa/microchip/ksz9477.c#L1252
> 
> Ok, so you are using a different definition for the "forwarding". What
> puzzles me is the explanation for the HSR feature flags here [1]. They
> seem to suggest the following, which differs from your explanation:
> 
> Forwarding (aka NETIF_F_HW_HSR_FWD):
> 
> "Forwarding involves automatically forwarding between redundant ports in
> an HSR."
> 
> This sounds more like the "forwarding" of a HSR frame within the Ring,
> between two HSR ports, that I was thinking of.
> 
> Duplication (aka NETIF_F_HW_HSR_DUP):
> 
> "Duplication involves the switch automatically sending a single frame
> from the CPU port to both redundant ports."
> 
> This is contradictory to what you wrote above and sounds more
> reasonable. This is what you instead call forwarding above.
> 
> Are you mixing things up, here? Am I completely on the wrong track? I'm
> just trying to understand the basics here.
> 
>>>
>>>>
>>>> https://ww1.microchip.com/downloads/aemDocuments/documents/UNG/ApplicationNotes/ApplicationNotes/AN3474-KSZ9477-High-Availability-Seamless-Redundancy-Application-Note-00003474A.pdf
>>>>
>>>> The KSZ9477 chip also supports RX packet duplication removal, but
>>>> cannot guarantee 100% success (so as a fallback it is done in SW).
>>>>
>>>> The infrastructure from:
>>>> https://elixir.bootlin.com/linux/v6.13/source/tools/testing/selftests/net/hsr/hsr_redbox.sh#L50
>>>>
>>>> is enough to test HW accelerated forwarding (of KSZ9477) from NS1
>>>> and NS2.  
>>>
>>> I'm not really sure if I get it. In this setup NS1 and NS2 are
>>> connected via HSR link (two physical links). On one side packets are
>>> sent duplicated on both physical ports. On the receiving side the
>>> duplication is removed and one packet is forwarded to the CPU.
>>>
>>> Where is forwarding involved here? 
>>
>> In-HW forwarding is when KSZ9477 duplicates frame to be send on second
>> HSR aware port.
>>
>> (only 2 of them can be coupled to have in-hw support for duplication
>> and forwarding. Creating more hsr "interfaces" would just use SW).
>>
>>> Isn't forwarding only for cases
>>> with one intermediate node between the sending and receiving node?
>>
>> This kind of "forwarding" is done in software in the hsr driver.
> 
> But according to the official explanation of the flags [1] this kind of
> forwarding is exactly what NETIF_F_HW_HSR_FWD seems to be about.
> 
>>
>>>
>>>>   
>>>>>
>>>>> Anyway, do you have any suggestions for debugging this?
>>>>> Unfortunately I know almost nothing about this topic. But I can
>>>>> offer to test on my setup, at least for now. I don't know how long
>>>>> I will still have access to the hardware.  
>>>>
>>>> For some reason only frames to neighbours are delivered.
>>>>
>>>> So those are removed at some point (either in KSZ9477 HW or in HSR
>>>> driver itself).
>>>>
>>>> Do you have some dumps from tshark/wireshark to share?
>>>>   
>>>>>
>>>>> If we can't find a proper solution in the long run, I will probably
>>>>> send a patch to disable the accelerated forwarding to at least make
>>>>> HSR work by default.  
>>>>
>>>> As I've noted above - the HW accelerated forwarding is in the
>>>> KSZ9477 chip.  
>>>
>>> Yeah, but if the HW accelerated forwarding doesn't work
>>
>> The "forwarding" in KSZ9477 IC works OK, as frames are duplicated (i.e.
>> forwarded) to both HSR coupled ports.
> 
> No, I don't think duplication and forwarding refer to the same thing
> here. At least it doesn't make sense for me.
> 
>> The problem is with dropping frames travelling in connected KSZ9477
>> devices.
> 
> I'm not really sure.
> 
>>
>>> it would be
>>> better to use no acceleration and have it work in SW at least by
>>> default, right?
>>
>> IMHO, it would be best to fix the code.
> 
> Agreed.
> 
>>>
>>>>
>>>> The code which you uncomment, is following what I've understood from
>>>> the standard (and maybe the bug is somewhere there).  
>>>
>>> Ok, thanks for explaining. I will see if I can find some time to
>>> gather some more information on the problem.
>>
>> That would be very helpful. Thanks in advance for it.
> One more information I just found out: I can leave ksz9477_hsr_join()
> untouched and only remove the feature flags from
> KSZ9477_SUPPORTED_HSR_FEATURES to make things work.
> 
> Broken:
> 
> #define KSZ9477_SUPPORTED_HSR_FEATURES (NETIF_F_HW_HSR_DUP |
> NETIF_F_HW_HSR_FWD)
> 
> Works:
> 
> #define KSZ9477_SUPPORTED_HSR_FEATURES (NETIF_F_HW_HSR_DUP)
> 
> Works:
> 
> #define KSZ9477_SUPPORTED_HSR_FEATURES (NETIF_F_HW_HSR_FWD)
> 
> Works:
> 
> #define KSZ9477_SUPPORTED_HSR_FEATURES (0)

Please take this with a grain of salt. I've just seen, that the behavior
is not 100% consistent.

I'm pretty sure that things work reliably with the diff I posted before
as I have tested this case more thoroughly.

