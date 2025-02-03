Return-Path: <netdev+bounces-162137-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EDD9A25DD6
	for <lists+netdev@lfdr.de>; Mon,  3 Feb 2025 16:05:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5F3B13B38A2
	for <lists+netdev@lfdr.de>; Mon,  3 Feb 2025 14:53:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A219205E32;
	Mon,  3 Feb 2025 14:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mysnt.onmicrosoft.com header.i=@mysnt.onmicrosoft.com header.b="WDgWQdLk"
X-Original-To: netdev@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11021108.outbound.protection.outlook.com [52.101.70.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BEA91F94D
	for <netdev@vger.kernel.org>; Mon,  3 Feb 2025 14:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.108
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738594067; cv=fail; b=ihvlQBhHYiggEr00hypavagApoBJcZMbtiFD7Hq8Hu2zDG91ZdlNd+y51NthS4JR1/ULAyx7I4mzdzKIg6C7OighD8ILjV9xFedT5AoU8uwjqL3uKKybgB6sN9fHdxra2VOGuvjc40G9JbieUgRKuNEPWjfCgAXyBlA7/hWHEuQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738594067; c=relaxed/simple;
	bh=PAKYcKfDaLhmVBDvmQJpamZLgLei3RUaZkUOIo8dhSU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=cwaLOXclvNfTwjZ+A0AVSH1jJy7U0rMPASqh5GfJK/7BnsMcPJ+iW/a0X/HIJFCJmaquyz15Azmil4ulwkXByPn8HMXY3z4NT6mV9K4x+uMwn6UD0rsvrDYjBJsLiNlk0zorB3zg9PxaYoNiL5la5OG3/TkT8q/sJm2AeXzx+kw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kontron.de; spf=pass smtp.mailfrom=kontron.de; dkim=pass (1024-bit key) header.d=mysnt.onmicrosoft.com header.i=@mysnt.onmicrosoft.com header.b=WDgWQdLk; arc=fail smtp.client-ip=52.101.70.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kontron.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kontron.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V+mbdey5stxv+QoMgdkXsbdLAErFl+wmEDb4RQ20TezEwsM8FzBcMua5fzkpihnZpm4ikG01RT03SKgL34S+ukI6zuVyrez7ZW6/medham/JRmjFDk63eVrekARaells6f4OEu0tvh7MedtWtMe5By6wfvDS4lAVMI0uSeRid8ujotQSFKFxgHhDLo34+He+LooBUc/2VdBvQSlJ61n6SQpvO6W6XmV8qXdCvbwU/6MdwW0pl7raHbMuc6pvzkoD741DLsOt8fy80HSuuDCA9yRjZB+DEC9e7GV4fRl94WofNdgvectKyHCaOXvwBHptGmi83KsjTPaCYgI3b3I82Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VDVRMHCOfjmioZD+VIu1euqFrKEHWvFG7ZA7ziU3YlY=;
 b=r9m6v45i50za+HhTW63/rh+0kyAkST0bd1pcAA89m/rHPq8nQukhxL4KLXEWMQiSscDfgJGIwfz9UX/vZmxy5xTdD6XFfsScmL6r9qlPr2zkn8uR+eQOYoPKYJu+ADV9mzmyHrwe4hNobwBTEavO++ydFfGeaPi9rAFZk0sJiRJfwfVLRHOktpO27UsYVL6BEYnv/l7cAKx4FGmw7dTyI+rOq+xqTQkqHoOuxIP3JvoRc5uzLMgmhtGH0t59R6DRcjdmFY2nDI8CQN5+uPRvHcf9goWABvStdX26DPShKfDd1bj+csV7Wo3vedI0molV7R7nrsI1q4lEMjolM1sWJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kontron.de; dmarc=pass action=none header.from=kontron.de;
 dkim=pass header.d=kontron.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mysnt.onmicrosoft.com;
 s=selector2-mysnt-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VDVRMHCOfjmioZD+VIu1euqFrKEHWvFG7ZA7ziU3YlY=;
 b=WDgWQdLken9+abjaiHydR4ShozXlYNY+ny1rTc3ABZgfIthAI9U7Q8wWqJ4jFodUsBUCszsfWhRnYJHXCnnzv7uG6m7dLzCvAAeKLhNKL2+AXOBo/m/Za6ezy3ltyUvxTwGN43gldno4cVMuqAq0/Iuf0Za81F7yx2qPvv/3t7I=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kontron.de;
Received: from PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:263::10)
 by VI0PR10MB8498.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:800:235::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.8; Mon, 3 Feb
 2025 14:47:38 +0000
Received: from PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::b854:7611:1533:2a19]) by PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::b854:7611:1533:2a19%4]) with mapi id 15.20.8422.005; Mon, 3 Feb 2025
 14:47:37 +0000
Message-ID: <1edbe1e4-9491-4344-828d-4c3b73954e8a@kontron.de>
Date: Mon, 3 Feb 2025 15:47:36 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: KSZ9477 HSR Offloading
To: Lukasz Majewski <lukma@denx.de>, Woojung.Huh@microchip.com
Cc: andrew@lunn.ch, netdev@vger.kernel.org, Tristram.Ha@microchip.com
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
Content-Language: en-US, de-DE
From: Frieder Schrempf <frieder.schrempf@kontron.de>
In-Reply-To: <20250203103113.27e3060a@wsk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR0P281CA0206.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ad::15) To PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:263::10)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR10MB5681:EE_|VI0PR10MB8498:EE_
X-MS-Office365-Filtering-Correlation-Id: 715b2450-1220-41b7-9145-08dd4461b3cf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MnV6RC9wUTlaS1lFc3h0KzBUQU9QSmpWdlFiQWFRNmluUGQ2Y1Y2ekVyMzVj?=
 =?utf-8?B?bFpZWlY1UVMwRk54Um1ndFp0WlZ0Zjc2NWFlWUd2SGhHaURoRFdaeE1UejVZ?=
 =?utf-8?B?cEFpbHlIbWNZZ1lqeVhadG9XQVVZajhReUh5SmgvSmh2ckV5ckNTNndRS3R4?=
 =?utf-8?B?cG9Wc1gwazEwY1hsSzFEbktqRHdSQzU1aXpJb2tEU3MwODdZUEd3M0ZTT0Ns?=
 =?utf-8?B?L1hLcGxVVWhJWG5pYlVXUGFnaHBaVjZyVi90dnRYTVF4QzVUbUxQcThZNGdm?=
 =?utf-8?B?MW1NdE5odGxJVDBTTHJVTUl5REtIMmlBWnN5eGxEL0pHbmFOZk52cVlGMU5v?=
 =?utf-8?B?MlcvT21vUGdrekNMYlhPTmVBMW5jNHhSM2xzdGNoK1pjOWF6N043VUo1Y1ZP?=
 =?utf-8?B?Mk5ycFhBSGtoNThjeFJESndjMURieFJYbDFXelBiSjQzUENGZlIwTU8yaFRr?=
 =?utf-8?B?cVloL1V4LytwNDhqL01kQkVGS2VlcXYrdFJJVGpRUzhlRFlJOE5mVndKTVBy?=
 =?utf-8?B?d2tHVDljTFdYK0lhRjhFeGc2TWtER2lFRitxNGIxUno2REJjZ2pxNThRRDh4?=
 =?utf-8?B?MktOUXR4QkR0aFA2VVgxN0pOQmR4R2wzeWFRRzV5aDA1U1JOM3g0S1U0bTFh?=
 =?utf-8?B?TEV6NXNRUjl5cHFoWnBVSHkyM2VRRytTdG85OGQyNENFK3U5aVlmYTk0Wkcr?=
 =?utf-8?B?S25tbG0wYTd0OU4rbXVlaDFnN0lCQnhiZGszWS9pNEJ2TDJ3SDBmZWw1ODZI?=
 =?utf-8?B?TllMYjltZDhKTVQ4aXR4bG0vcUJacTB6WWxSSlI5RHlTTDkzVzdGRnR1OFZ2?=
 =?utf-8?B?ZURUSVA5V25RT3ZndWN0bElmQkdIVEJISnpWMHBBVlZpYSsyRlZObmdxQzU4?=
 =?utf-8?B?eGxwa1U3bTJLVXdNMEc3Y3FURW5hdE8yRHdpcWx3QmVMdnplV1lRN1lpaHo3?=
 =?utf-8?B?OTN3ZlZjTHdEMEpCd1Z1ajZhL1RJQmNoRzZFNUIyVEtRaStaYmxXSENhYUdt?=
 =?utf-8?B?dm5kNHYwWWlaeU04cXdOSDY3RDNlNENZY0xUMWVoMzlQbU15akJMYnk3d2oz?=
 =?utf-8?B?ZnFWYUFGOGI4YTdVb1FnZlYyVmxXSk5HMmpmRGtzVEJrMTEveXF6SEdlY2JS?=
 =?utf-8?B?ZXRtdnpPMkFvb2ZvVlBjQnZkTHRLNVRZTUVRcmQrZHllNEc0QXRGYVdRdVQ4?=
 =?utf-8?B?UW1ORUZ0djZYNktiK3FxVktIclRZM0Mvdi9ndzFxUmxLaVJ2R2NtejhsUDVO?=
 =?utf-8?B?WWJId0E4dTRUWE9zTGpTdHIrNTQxaXFidnVObk1ndUN5a0kzVlZDZHlPRWt1?=
 =?utf-8?B?amhieTlUL0Q3NEFMeXFPR1ozZ0JHWXNrcDB2N3RhVVp6empSa0g2SkJBT1g0?=
 =?utf-8?B?WlNDUWZvdjczSmZDOVU3VDhyVjI2bVJla1ZlVlRqZjcwZ0V4dnlBVEhjUGJp?=
 =?utf-8?B?RE1lSzNKVW0yUzBVcjNWN2xHc09hSHBTZXVRUGRYVTZ0eWRyRVErSXBkTWxW?=
 =?utf-8?B?R3JPVDNqYXFDTGJTTXMxRVB2cE1EQ2lGamVZdjVVcURPdGFpQWJIdjRFalJC?=
 =?utf-8?B?djZmTVVhaWRSZjh1cGxUTTA3SGF6WldRbjB1VExaTFFyVFJqZnBqaGpiWFU5?=
 =?utf-8?B?RWV6STQyQm5LRjRIaG1GeVJWMnhvdEw2d25wOC9JUDlrZ1F2UVVaTHpUcVdP?=
 =?utf-8?B?a1dMazhacUhGbFBvK3NMNTdUU25NTzAvMTQzTTdvTEtBS1hFTmZjOTdDMWRJ?=
 =?utf-8?B?MTBZaEFwY1RKMkh2dUREOTFXSmM2SzhPV1RkSVdBSzlOZFVlWnpvVmxNOEVJ?=
 =?utf-8?B?ZCt3amxVTms3ZDllU1lEZz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dVIzZEJWMFlCb21HT1FWM3NvWkJzcHpFRzQzSTRXYWhaUnVYTERkMjRDZU5N?=
 =?utf-8?B?Snh2RW9lM2JtK29tV0pBcnpIalg0dkUxUUdIY1lqVUxFMWhqNFYwOHVPTHpS?=
 =?utf-8?B?c1hMNmEzN0RZZlVMVGlLZlJ4dVVDYnMzakNpSm5wR1BsSDBEZWZGNDV4a1RY?=
 =?utf-8?B?ZkJBWWRtT1ptc1Qvb05tMzA3Y3g3aTE1ZlR2enh5QzJZVHgwemh6OFRXb1NE?=
 =?utf-8?B?Q1NyNXpkb244WlJ5Y3RmZjA3Uk5xTzZ3NFI2bTNIUlAySHNNOUNHdTBjQm12?=
 =?utf-8?B?VWN3YnhTTnIvWEkzU0sydnZmWDlCcDR5N2tmTUlxU2VDZEYxWUdNU2cvUjRz?=
 =?utf-8?B?ZXpNUXdXUE9QL1M4eDBOYTRhcXBZdTRVeGlSQWFkZlJvYlFWaGdWcDR2SXgw?=
 =?utf-8?B?V0tockN3WEtyelhFM3hXWUFieC81bHJVNE1mRmFCbzdQSnFPM08xb0Mxcmt4?=
 =?utf-8?B?V0d5UGU3MitEYU4zV25GMGRIQ3cyZTVFK1hxeTkyYy9WWmk0bmxTTHQ0V1h3?=
 =?utf-8?B?VHdpK3Y0SUFwTmNrSml5YWVuVDkxYTIvV1VoamkxdzYvNzhuL3htbllJZEE1?=
 =?utf-8?B?YWp0S2xhNFpIa2N5cnhjMmpBTzNhdlVSNzA4L09YRjFTc1IyN1ByNjhLcm96?=
 =?utf-8?B?U3FqSWZoZENXQjVJdStZVUoxK1I0UkFNYXZadzFTeVZIRkhzNE5pdXZQYXgv?=
 =?utf-8?B?K2hkeCt2ajdseUZ1d21nV1dweWZrYnhSL1I5cDJBMHdQMGJsSDI0ZnlZTnpS?=
 =?utf-8?B?WlZOVnZXVnp5d21BOFQzUENEUFFVWUNSWW5mRVNrQWpxdU1yY1NDcVk5VnRt?=
 =?utf-8?B?anZtand6amY1bktDQWJlaTNLeG0xeGZicmp6UTV6eHgyOU5Na04zRVRZQ3hx?=
 =?utf-8?B?dlpydUY2SVV3ZmRuMG5aajZyajBpUWFoTHUwUnQyNjVBUFBPL2dBajJmNmo4?=
 =?utf-8?B?UFhmMm9ZMjJ0RCsxWk83dVgxSklKZEZTUXFacmJvNlc1Si83eDFoaXNMY0Fl?=
 =?utf-8?B?UUduWXJFRWlockRZMnJNcUMrdVdBYmNHL2RBN2ZWcmNoa1A1UHpsZnBtc0Ra?=
 =?utf-8?B?Nk9HS0VPeklXallMUUw4djFDdFdBUFhVTjRPYVh3bmVhT2lReloyamVad0FD?=
 =?utf-8?B?aFZXMGhUb3RzZnJHZ1lROURqRG1TWXY5eTFTVGg0Tk1pZUoxNzJySGNCZjNj?=
 =?utf-8?B?WFVWaVpxUjBtM2ovS0ozR3RLNG9zcGRqSVJiSG9aakJWSStnOHVQWmgvc24w?=
 =?utf-8?B?Um9iU2F5cURBcENuRmtGQjE1WUl6di93dUV1RzJKZUJtTU5PQ0dqRWJ4N3JY?=
 =?utf-8?B?TkxDeTMwZ3hzS3E0bDk0M2ltKy85RDRBUURUUVNaeC8yaUtsU1pIdjg2N2VY?=
 =?utf-8?B?UGdLcnJNQldmTW1MN09OTXV1U2tyUWZDUnQ3SGxXUmtRQXphTlRkV0Fic1N0?=
 =?utf-8?B?SC8vSDIyb0g3Z05MaWF5Ym5TeGxDOXBuWTNQcjVnMGlXaGV0QW9OMzlWUis1?=
 =?utf-8?B?S2xZcGd3RnN4ZTF3YXJnNnUwNkpkV3dqYldCMmxTbDkycnQzVmJOejltU2VK?=
 =?utf-8?B?N0hpeGh3a2c3NzN6U0VsemJoZUlIWEhBU0R3aGNldno4Vk5wdUwrdnN1OUFM?=
 =?utf-8?B?WStmNVNnMWY1N2l0cWNEbEsvb3JuOGJMMGNobVVuK1hxWFNzemFpR0dMN3l0?=
 =?utf-8?B?bi9nOVdyTkpNVUl3T2xrWXAxWS83WHh5cyszMDdYWE9tQUdBek0rRzNhZDVK?=
 =?utf-8?B?ZjNFTzQvcEN3TFNROERjemNDZ3d2b1FQdW1GMS9ZRHIyeTVSbk1HM2g4SFNh?=
 =?utf-8?B?eGFYVWg1MW93cDgzdmw5Y3lHTHhZcFZKaGM3MjlZRzl4ZXI4TVhwT29yaTly?=
 =?utf-8?B?L21NNmkxWGtGbHpaYndjeEY3dmdLa0RXdjg0aVZqbzV2VDE3NzV2TTJzb2Qv?=
 =?utf-8?B?ZGJqZ1JNVitrdVZDdGpCaGlEeHpEUVpoczZKSTVLeG9SclhKYVV0c3pXNkps?=
 =?utf-8?B?QTRDT3RUQytJcG5yaThpT1lIM2RtZ01EM0tOM1QrdlVCOGJQMzRsTEJ6ZjRw?=
 =?utf-8?B?VTB2dlBlK1hOR2hRY1dMbXJCeTlnWThNMUprNFpKRWd2cmtoL0dHWVBXQzFD?=
 =?utf-8?B?MlJ2TDN4VEFRd01kclJjNTlqUzVUamhJMzNXNytoOTg0dWFGY1BncDc0NVI3?=
 =?utf-8?B?Mmc9PQ==?=
X-OriginatorOrg: kontron.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 715b2450-1220-41b7-9145-08dd4461b3cf
X-MS-Exchange-CrossTenant-AuthSource: PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2025 14:47:37.7189
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8c9d3c97-3fd9-41c8-a2b1-646f3942daf1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7QTvlmrWUYcWhM8eydAT/xj76cF87jG+gLVx4QSowtqNstqWhn7T189hcGIXDqK/cjgvusZZ2Q8sX0T7jshDN/ctI2G//uNJnKGrzXMtNmw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR10MB8498

On 03.02.25 10:31 AM, Lukasz Majewski wrote:
> Hi Woojung,
> 
>> HI Frieder,
>>
>> Thanks for the link. I reminded the support team this ticket.
>> Please wait response in the ticket. Hope we can get the solution for
>> you.
>>
>> Thanks.
>> Woojung
>>
>>> -----Original Message-----
>>> From: Frieder Schrempf <frieder.schrempf@kontron.de>
>>> Sent: Thursday, January 30, 2025 3:44 AM
>>> To: Woojung Huh - C21699 <Woojung.Huh@microchip.com>
>>> Cc: andrew@lunn.ch; netdev@vger.kernel.org; lukma@denx.de; Tristram
>>> Ha - C24268 <Tristram.Ha@microchip.com>
>>> Subject: Re: KSZ9477 HSR Offloading
>>>
>>> EXTERNAL EMAIL: Do not click links or open attachments unless you
>>> know the content is safe
>>>
>>> Hi Woojung,
>>>
>>> On 29.01.25 7:57 PM, Woojung.Huh@microchip.com wrote:  
>>>> [Sie erhalten nicht häufig E-Mails von woojung.huh@microchip.com.
>>>> Weitere  
>>> Informationen, warum dies wichtig ist, finden Sie unter
>>> https://aka.ms/LearnAboutSenderIdentification ]  
>>>>
>>>> Hi Frieder,
>>>>
>>>> Can you please create a ticket at Microchip's site and share it
>>>> with me?  
>>>
>>> Sure, here is the link:
>>> https://microchip.my.site.com/s/case/500V400000KQi1tIAD/
> 
> Is the link correct?
> 
> When I login into microchip.my.site.com I don't see this "case" created
> for KSZ9477.

The link works for me. Maybe you can't see the ticket as you have no
permissions? I added you as "team member" to the case with your Denx
email address. If you already have an account on a different email, let
me know and I can change the address.


