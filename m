Return-Path: <netdev+bounces-98178-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B9568CFF1F
	for <lists+netdev@lfdr.de>; Mon, 27 May 2024 13:37:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7DC751F213E3
	for <lists+netdev@lfdr.de>; Mon, 27 May 2024 11:37:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 233A915D5C2;
	Mon, 27 May 2024 11:37:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b="QGS7X4AG"
X-Original-To: netdev@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2069.outbound.protection.outlook.com [40.107.21.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BD36131E41
	for <netdev@vger.kernel.org>; Mon, 27 May 2024 11:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716809863; cv=fail; b=Rm49Q33kaaT5GBtfr37Pas4fZROpgnTSmyLsx/p5vufaVjNM6euUULFp53tueE5ssaNaWschJXbzNHd2W80wuSmhUBpvhTy0wSKh4BdSQN23ue3ChjrRgsh+TbL9NrJisqHAIlXPV7kKtJAgqK/V76rI8WFsBDW2qhuQpnnTVGQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716809863; c=relaxed/simple;
	bh=h7TCMbKygomKW4uT+fGHVioLuhP2SLPpWFE1iG0BS7Y=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=GJp3ZaK0O8cftm3uwsOBr+roPG1rIheWGQbd+HcprZ/m/6IFHiFdFF+zp8UijtMpkkaHhRlo0lnU3TyxBpWKLUXWF0C0suu2w8rF1Zo3M9itHmXoBbgiEbzL0rLbvZ76WLDQzk40JX/zJ3b15Ty08aF445bReEYsUqH4DvN8H1Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com; spf=pass smtp.mailfrom=2n.com; dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b=QGS7X4AG; arc=fail smtp.client-ip=40.107.21.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=2n.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aE66RgMaltRWpsEI0VjdkDul/MI/NZuZyI1ixtGV+dkpE3YA0NtqLTWfEu+JYJpwmIRbceGCARMY3X6zMhmMIag4sEIcluMaigAYUqj/zMOWy6DXMDBGuUE77FJCtwlx6ALS7V00/MdaSJ4aflw4qwIuuhlhtVOTH1v8+w63RjFIQpPJVnHLY0mDuF7Wy5vY6/eACXnjzLselcDdQtsTWSBqesvTkPslZFQ2erPGIYPDOSvHhWnMhUr9LmQD1NzW11ahn+g1dohShpSUKQci5Nmg4Gejuc7qYkQg34Mx4BU4y0fTR3ZlQCDZvColFCF9BTwQz8qigY4yBVxw8fmFMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pIqlYindzXHrCmaZVf5W9/qek5tydxeEFFHHTZ4eYH0=;
 b=VLBGJl9pWWQp2uPqG7Dz+X/qTXzZG/TBiqRMYo1jHNYuMnaLfLsbgqYpzZYHqZDXwlXPudIyZjMP5HdzCq8IGj8IdRx8OssuBf2cIkx26vL6OE0VpsS0LZ/xZ8+6hUir0YvEKv7HJPik+3E791kh8xAwD7lh50lwaHvAieu46L5a6dJXUmXXoNOpxtkaSjYDp5iVHGRcziniJObNt7wYUt+xyXUpPD0L+rIfd3Y+SN1g7QjcxK5KBA5tx+Mtl5jRO41JQWwp5z7kX301rcYb/b3NKxAABUC4OWEwlGIEVM1xceRslKdBWnmFsBSmRyuS9aCvLGkIB2iujuf0pVHjNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=2n.com; dmarc=pass action=none header.from=axis.com; dkim=pass
 header.d=axis.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pIqlYindzXHrCmaZVf5W9/qek5tydxeEFFHHTZ4eYH0=;
 b=QGS7X4AG1BzW1qC87enN6Y3k16HIQBSGMIzkGHXdNBT1K5Lm0mVVp99/jrAheEe0Ajgo0UKViulnICTZEFvwHLcxOY4MpnCHv2a2P0SSzS459YuEO4RogtAlkWdSSqdYHrw8sGGmUwxDK186Hs1fI2dn00Wtlon6LTHrFsAoIJ0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axis.com;
Received: from DB5PR02MB10093.eurprd02.prod.outlook.com (2603:10a6:10:488::13)
 by PAWPR02MB9904.eurprd02.prod.outlook.com (2603:10a6:102:2ef::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.27; Mon, 27 May
 2024 11:37:36 +0000
Received: from DB5PR02MB10093.eurprd02.prod.outlook.com
 ([fe80::2a25:783c:e73a:a81d]) by DB5PR02MB10093.eurprd02.prod.outlook.com
 ([fe80::2a25:783c:e73a:a81d%4]) with mapi id 15.20.7611.025; Mon, 27 May 2024
 11:37:36 +0000
Message-ID: <b9ce037f-8720-4a6c-8cfe-01bffee230c1@axis.com>
Date: Mon, 27 May 2024 13:37:05 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/3] net: phy: bcm54811: New link mode for BroadR-Reach
To: Andrew Lunn <andrew@lunn.ch>
Cc: netdev <netdev@vger.kernel.org>
References: <20240506144015.2409715-1-kamilh@axis.com>
 <20240506144015.2409715-2-kamilh@axis.com>
 <25798e60-d1cc-40ce-b081-80afdb182dd6@lunn.ch>
 <96a99806-624c-4fa4-aa08-0d5c306cff25@axis.com>
 <b5c6b65b-d4be-4ebc-a529-679d42e56c39@lunn.ch>
 <c39dd894-bd63-430b-a60c-402c04f5dbf7@axis.com>
 <1188b119-1191-4afa-8381-d022d447086c@lunn.ch>
 <ed59ba76-ea86-4007-9b53-ebeb02951b34@axis.com>
 <44c85449-1a9b-4a5e-8962-1d2c37138f97@lunn.ch>
Content-Language: en-US
From: =?UTF-8?Q?Kamil_Hor=C3=A1k=2C_2N?= <kamilh@axis.com>
In-Reply-To: <44c85449-1a9b-4a5e-8962-1d2c37138f97@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: VI1PR04CA0085.eurprd04.prod.outlook.com
 (2603:10a6:803:64::20) To DB5PR02MB10093.eurprd02.prod.outlook.com
 (2603:10a6:10:488::13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB5PR02MB10093:EE_|PAWPR02MB9904:EE_
X-MS-Office365-Filtering-Correlation-Id: ed993cd3-2a8b-47e8-d344-08dc7e416826
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|1800799015|366007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Rlppcm1JREVIUGh3RVArUWVFYjBQMXc4L0hmdzNDNDVJeHpXY0VoQUxwZ25v?=
 =?utf-8?B?L0owK1B3dGVYZXh1TUZCZ01IR1ZQNU1UNk1yeExSUmRNZ3FJdXVLaEtnbnFH?=
 =?utf-8?B?R0xoU2xlRC96M0k3TU1GRG1IR3Q4TlRMTW9xQ0o5NHNXeVV0UEtUU3g2eFhT?=
 =?utf-8?B?YjFsZGkrZHE5RWVONkxVSURxVStRV3I1bVhDclBtVWwyVk84dTNEbnFWKytp?=
 =?utf-8?B?c1FXOHlPbmhhSXNrUGF3SUZNMTRLaTkrSmZ0anJYNUxtdHpOdXRuVU9sdWht?=
 =?utf-8?B?ZXJnZkRqcEZLSm5YamxaODkxcGEyRmJ1VnpPTEFKcWJ6K0FQUnFsNHdPMk5U?=
 =?utf-8?B?TjlZeXg0cWlRejFqTnFQWEVCemVodStiOEs3Z2N5YlFpVytuVXJhZHVTT29w?=
 =?utf-8?B?ZnhzY20wTlQrWmpTVFVFbU1BbGpsUTNiaklkNlIzT0tnZ0tsWkRQbDBzQmtV?=
 =?utf-8?B?NXBQUjl1a0twSkVSck9PSlRycXZoNWtwa1hZRnhjeG41UXZJeHZOdjlSWFRx?=
 =?utf-8?B?ZFNQOHNyanIwKytJN1M4SWQxTGt3R0NvY0xVbFlQYjJHOUEwbEd0SHdkQkpo?=
 =?utf-8?B?dkZWdXI4ejhmZk5IMmIrYmg5OU5FQkRUQkwyT0FleU8rdmlrUTlrVUJQNlY5?=
 =?utf-8?B?YnJYZ2p5SW82ZEx3TjByZkVSbUtuMEdhRkhhWDNmeWROQ1UzWVNrdGxjT291?=
 =?utf-8?B?dUVYYXZMd0c5OG1lcXU2dDBOVWxhaEhackY0aUJ4ZlNZVG95ZUR1cWdWbVpF?=
 =?utf-8?B?c0p6ektmRkdsc2k2S1Awbzh4Q0Vad1R0Qk1tQlBRZnpGR3JLOHlOaEZoVW1M?=
 =?utf-8?B?TURRYzJ0ckV5V0ZWbFpWUjhIakJRRHlFL2Y5Tkk4SCt0K3JTZkxDb3N3dDAy?=
 =?utf-8?B?VytRV1lPbnF5anprS3pvaStjTVFZa1FnUUc5V1FuVnhEOUNWVGVkTk04N3VI?=
 =?utf-8?B?MTJKYmhEZDZkR2VJeVhjeWo4NnZVU3UwbnRoRk40RjI1TDB4WWVlRUJ4dzB3?=
 =?utf-8?B?MUZtZkNNdXdRajk0WTFvN2IvT0l1NHBVcm5sZ2JqbkJQWUU0eVRIMnlrRjN3?=
 =?utf-8?B?bkNyb3ZjaVByTy9CU0lGRDJBSkQ1MFpLVmc1VjVWbDNLQk52Zy9Bejk3SU9H?=
 =?utf-8?B?eDFTaENuNk9WWTMzbUhEVGhydmZFQzFUZmxmSXkzT1JhS2dNRzVjUnFMN1Fq?=
 =?utf-8?B?SkU4UDI5YjVkYlJNOGtWRTh1L2xvVUxOZ0tHMkhzZEZwOE5naExnNFBNdUNu?=
 =?utf-8?B?WENPR0M5TmtvZ1JZODdXTWNXZU5HdnNvQ0ppMjdEYmN1NzRTdWx5Qnd1YmJN?=
 =?utf-8?B?aThBMXNhcFpMZnFsVzEvYVN6OHlKQVA3VXdHeVhNRWgxZW93NDJDbVR3RERT?=
 =?utf-8?B?UWVsZnlFNzVjRmpLaEVQc01sRUc1SmZGVWtXV1NaMnMzektiTEZudzlZdnVK?=
 =?utf-8?B?WlU1U2gxb3NqSFF1dlpXazdUS0c0VTlkWk5NVHZLOUxrS29ORW1vVWI2d0lz?=
 =?utf-8?B?RHdxSkpZRTc3L0c1WXZLTlk1akhjSGhnNkpNL1pkTFdHVnkwTXRQSWtydGU5?=
 =?utf-8?B?cTNRTkNtOXNacWFkcWczN0tGdXhuSXpQUzdkMndFWEs5bEUrTDhLSlVXMm9p?=
 =?utf-8?B?NWdtVWNyU2VvZWNxaWRYWTZyRERPd3lmWW5DcGZVd096VUhBQ2ZQMG1RY1B3?=
 =?utf-8?B?VENYbnpINDdEZ0JVUWQwRitNbXFqV3hXUDlrMGpkOGJOMytJRVAvWHNRPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB5PR02MB10093.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?THl2SG5xcWdjQk5XUU5xakZvYkhReTNHNmVncFQ4ZFQxV0V1ZER0TlhSQVdt?=
 =?utf-8?B?VmQ4NHd1V1dXK2F0b0xnaXhBeEpHZWh2ZTlUMlh0VVBQZ05aWndDRnlZa2ZR?=
 =?utf-8?B?aGZTVGJFVFJHdnNTanVEV0FyZEZoaXkwMFJMWExCaDhsNUNPbG1jeVdkZzRy?=
 =?utf-8?B?K29kaGMxVmVwMDNjMU50bVRxQ3RiMGxINUZGcEE1SjQxMkhILzNxRjlKbElt?=
 =?utf-8?B?WHlwQWFwOHRETEhLVEpVWDk2ZzlxY0JHMGpzeGFVakRNUnlXcmtNK2ZLaWRu?=
 =?utf-8?B?WkNkN0k2aTEzZ3BzbTNmR0NKbytKSzI1OWVnTEtWTW03TzUzSXhoY0pQZU0x?=
 =?utf-8?B?YmdsakRNNGlsN1ZvaFlRZjA4K09qbnFuTUQwcGk4S1FQd2tQOXpIOXkrdVVw?=
 =?utf-8?B?UW9zekNjTURHTk9qN1RWUzNrOS9IMXpPc1Z4b2U2ZzVtbXFRdFBoSVpsT1Ir?=
 =?utf-8?B?ZGlPMzJJbGFUY3lGYlZJMzFkQi80anpPa2Z0V2xPYXM3dU1qam5JZlVJSFRr?=
 =?utf-8?B?YXZucGtvU0g0ZVQ4cWdzQjRDaDA3YnlyR1RFQUZqdk1pMTI3YXJ5clFnUXp0?=
 =?utf-8?B?ZllwejkzT0dQK3JYRUN2SFMzMjdYelkvNFZWT3poZmJGd1RtakkrdnhoTmRa?=
 =?utf-8?B?UjFOK1pKRjNreEJhZFQ0QW9EZWNGM09pdm9KZU14TFZONmlnT1VmbEFnekxu?=
 =?utf-8?B?Zm1ScEZpc2QwdUR2RGdlS3FxTDk4eFZ6aE5ndUhYbHphZzBhK3FJMXVVVmpr?=
 =?utf-8?B?MnZWYThVOUJBUjVVVDZSek02Y1Z1MVZ5czhBdXp2MlJic3pCaERZNW9SS0N3?=
 =?utf-8?B?Qi9jYko1cnpUVVg3clBOSXpwUGNPZFRVdjJTaStOakxpZmJ2eUhObXdEQ3VC?=
 =?utf-8?B?VXZnRk1oVTZZZDNva2lLSSt1TFBoRG94d09ZcjlDUFRONmkxK0dhc1FZNGxl?=
 =?utf-8?B?MFNDK3hyUGQrSCs0SERra3MyNW1hZDVES3RyQW1SaTYwYWZkMUxzUG1CUlVM?=
 =?utf-8?B?UmppTldFWkJIMnFOYnRsZFRVcTU2OUdwZFI4c2lyS2lybFhVWlpJb3pQZ3JU?=
 =?utf-8?B?Y2t3ZU5Bc0xBWDIvbFNZb1NUcE1aSm8rWFpiS0x6ZnNuTUFsdGxtQitDMVpP?=
 =?utf-8?B?aUlkUDhSWlpsQWpRcXk4U2MvWWpiL3RVZkhRZTIxZEZPaUxONUs4WmcwOWY1?=
 =?utf-8?B?YTZUUUUxVUw1Mm1BcWsvdjdzdVhJUUwxZWhiN3ExcGhwa29aL24xOTNSR1pj?=
 =?utf-8?B?UmJBTGxvSDRPWTBhNnk3dXk2WnRxa0JrV0VHREp5T09KZXdxaUhBWHhlNW1r?=
 =?utf-8?B?VjVxT3pxTFBnM3dpMTZ2ZlV2ODNwUStUZTdhODU5TnVBOGFkYU1oOTdyZUtD?=
 =?utf-8?B?dkJHTVZjOE5DUmd6cDVwRVhOaUt3S0VwZ1oxWUdTT3FhdDQyV3h5YmU0NXc3?=
 =?utf-8?B?MCtvRFVSQUxpU1dKcnkyRys3VURMVGE1VXMrSUtQNE82T3Q0MzJBaVJBcHZV?=
 =?utf-8?B?bVpwbE04WUI1cVFtb0JLeFlpbWFhZjJCNFpjRk9FUXBqQWw2R0p3L2hGTWtn?=
 =?utf-8?B?VTl1NVduKzkrUDB5eG9zUldybUROTm03UUFESDQvL2FkY1kwRi94NmN5N0Ry?=
 =?utf-8?B?MWhUKzhIdTdRdWpOZHJsQ1FZN1NRbGxySU9ibVk5ck5BM0Z4NDR5YjJLcUFX?=
 =?utf-8?B?UGRNWXA4WVhWV05FR2xVVitWTG54UnJ1Yi9LM1hhZUVtcVFzY3hkWm83ekNi?=
 =?utf-8?B?NUtHaWJ4NTFwbW9tcmMvZUpXOUhmYnNNWk1qTXJySkhpS3lxQTBTejNQSUVl?=
 =?utf-8?B?cURjM3hqOTM1b1dHcWIvUVJIRzQzSG95NzdPZVhBTnNwckpHWHF3NWlQNDYx?=
 =?utf-8?B?N2NHbm9SRXlpMDFCRGppeDJXeWhpNk56SVpocEswYlhzNTJKTDMzZzRzRjBi?=
 =?utf-8?B?Y3ZBMWR2TzhabElVNVdXRkdhcVcwZkZ2OEtMVUhrallETVVrWFFvMXpEOGxj?=
 =?utf-8?B?dXNERVgwbnc0d3pKbjBxRGJUQisyZFdTd2hrVHV4aHF1K3k5TDBpL0xnQ0FX?=
 =?utf-8?B?eC9OSUUyN2lsdVp3NnI4Q1k2bWVqbTJZaWZRSkxscFYyVnZ4VHVFcCtPOE1t?=
 =?utf-8?Q?t6tyLLbUS4b/xZb9eqU/57K6T?=
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ed993cd3-2a8b-47e8-d344-08dc7e416826
X-MS-Exchange-CrossTenant-AuthSource: DB5PR02MB10093.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2024 11:37:36.6198
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vug/hqWMXN5Y4T+OcihQQInL0Yg4x+WzZBjmm1Kq/cnBk2GyYN3nAuId/eNxXLdp
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR02MB9904


On 5/25/24 19:12, Andrew Lunn wrote:
>> As far I understand it, the chip is not capable of attempting IEEE and
>> BroadR-Reach modes at the same time, not even the BCM54810, which is capable
>> of autoneg in BRR. One has to choose IEEE or BRR first then start the
>> auto-negotiation (or attempt the link with forced master-slave/speed setting
>> for BRR). There are two separate "link is up" bits, one if the IEEE
>> registers, second in the BRR one. Theoretically, it should be possible to
>> have kind of auto-detection of hardware - for example start with IEEE, if
>> there is no link after a timeout, try BRR as well. But as for the circuitry
>> necessary to do that, there would have to be something like hardware
>> plug-in, as I was told by our HW team. In other words, it is not probable to
>> have a device capable of both (IEEE+BRR) modes at once. Thus, having the
>> driver to choose from a set containing IEEE and BRR modes makes little
>> sense.
> So IEEE and BRR autoneg are mutually exclusive. It would be good to
> see if 802.3 actually says or implies that. Generic functions like
> ksetting_set/get should be based on 802.3, so when designing the API
> we should focus on that, not what the particular devices you are
> interested in support.
I am not sure about how to determine whether IEEE 802.3 says anything 
about the IEEE and BRR modes auto-negotiation mutual exclusivity - it is 
purely question of the implementation, in our case in the Broadcom PHYs. 
One of the BRR modes (1BR100) is direct equivalent of 100Base-T1 as 
specified in IEEE 802.3bw. As it requests different hardware to be 
connected, I doubt there is any (even theoretical) possibility to 
negotiate with a set of supported modes including let's say 100Base-T1 
and 100Base-T.
>
> We probably want phydev->supports listing all modes, IEEE and BRR. Is
> there a bit equivalent to BMSR_ANEGCAPABLE indicating the hardware can
> do BRR autoneg? If there is, we probably want to add a
> ETHTOOL_LINK_MODE_Autoneg_BRR_BIT.
There is "LDS Ability" (LRESR_LDSABILITY) bit in the LRE registers set 
of BCM54810, which is equivalent to BMSR_ANEGCAPABLE and it is at same 
position (bit 3 of the status register), so that just this could work.

But just in our case, the LDS Ability bit is "reserved" and "reads as 1" 
(BCM54811, BCM54501). So at least for these two it cannot be used as an 
indication of aneg capability.

LDS is "long-distance signaling" int he Broadcom's terminology, "a 
special new type of auto-negotiation"....

>
> ksetting_set should enforce this mutual exclusion. So
> phydev->advertise should never be set containing invalid combination,
> ksetting_set() should return an error.
>
> I guess we need to initialize phydev->advertise to IEEE link modes in
> order to not cause regressions. However, if the PHY does not support
> any IEEE modes, it can then default to BRR link modes. It would also
> make sense to have a standardized DT property to indicate BRR should
> be used by default.

With device tree property it would be about the same situation as with 
phy tunable, wouldn't? The tunable was already in the first version of 
this patch and it (or DT property) is same type of solution, one knows 
in advance which set of link modes to use. I personally feel the DT as 
better method, because the IEEE/BRR selection is of hardware nature and 
cannot be easily auto-detected - exactly what the DT is for.

There is description of the LDS negotioation in BCM54810 datasheet 
saying that if the PHY detects standard Ethernet link pulses on a wire 
pair, it transitions automatically from BRR-LDS to Clause 28 
auto-negotioation mode. Thus, at least the 54810 can be set so that it 
starts in BRR mode and if there is no BRR PHY at the other end and the 
other end is also set to auto-negotiate (Clause-28), the 
auto-negotiation continues in IEEE mode and potentially results in the 
PHY in IEEE mode. In this case, it would make sense to have both BRR and 
IEEE link modes in same list and just start with BRR, leaving on the PHY 
itself the decision to fall back to IEEE. The process would be 
sub-optimal in most use cases - who would use BRR PHY in hardwired IEEE 
circuit..?

However, I cannot promise to do such a driver because I do not have the 
BCM54810 available nor it is my task here.

>
>> Our use case is fixed master/slave and fixed speed (10/100), and BRR on 1
>> pair only with BCM54811.  I can imagine autoneg master/slave and 10/100 in
>> the same physical media (one pair) but that would require BCM54810.
>   
>
>
>> Not sure about how many other drivers
>> regularly used fit this scheme, it seems that vast majority prefers
>> auto-negotiation... However, it could be even made so that direct linkmode
>> selection would work everywhere, leaving to the phy driver the choice of
>> whether start autoneg with only one option or force that option directly
>> when there is no aneg at all (BCM54811 in BRR mode).
> No, this is not correct. There is a difference between autoneg with a
> single mode, and forced. forced does not attempt to perform autoneg,
> the hardware is just configured to a particular link mode. autoneg
> with a single link mode does perform autoneg, you get to see what the
> link partner is advertising etc. Either you can resolve to a common
> link code and autoneg is successful, or there are no common modes and
> autoneg fails.
>
> A driver does not have a choice here, it need to do what it is told to
> do.

OK so back to the proposed new parameter for ethtool, the "linkmode" 
would mean forced setting of  given link mode - so use the 
link_mode_masks as 1 of N or just pass the link mode number as another 
parameter?

For the BRR, this forced setting includes the duplex option (always 
full) but still requires additional parameter to determine master/slave 
(likely using the command - eg. "master-slave forced-slave")

For IEEE modes (or any other supported modes on other PHYs) this would 
set speed and duplex as requested.

>
> 	Andrew
Kamil

