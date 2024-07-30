Return-Path: <netdev+bounces-114118-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A803940FF9
	for <lists+netdev@lfdr.de>; Tue, 30 Jul 2024 12:52:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 926C21F230AA
	for <lists+netdev@lfdr.de>; Tue, 30 Jul 2024 10:52:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBE18194139;
	Tue, 30 Jul 2024 10:52:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="dC/GsReY"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2075.outbound.protection.outlook.com [40.107.243.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C17E53E3A
	for <netdev@vger.kernel.org>; Tue, 30 Jul 2024 10:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722336753; cv=fail; b=BCuQYyoMdfKNTIcHn75lAyMkmIg2FgRI/McSrCHaQRVOXr21hLy54Z3RYwAInADWwx6JSLKxJO/1m0aZ9RzJ/ZFpDJ6M4hgAf1Sl+qx4Ud2bYGoLWwElyj9zchErNx4/qUVQ5RIrkeQrhHfvX8C2x41RotN3pkKuriZ/jnir+d0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722336753; c=relaxed/simple;
	bh=flxUTfOonyMUw1pFsSok9YEp6gNS+Bgz8xVVh7K6il8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=BImGiLNeYYbYORATvbR7trGIqJoPRb5eKeNW2lqg9vdT9kOfY0DFtQjeeYVkxerKHCnueMK6/ZWtkni547jAnf/5Wez+omG5bBPOns6OClZtDFOFGgneL9U9dq9CxTTSWxheWq//lBFxcUQ08i4VjTfSJe2tN1yJTX9QOaN9LE4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=dC/GsReY; arc=fail smtp.client-ip=40.107.243.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PTqIP07ZvVu6d/LUOfk394wiunBCWZXA3kfvimjx+qnaAPoUGRQxqRsRlo9Elg9ShSVNQI9BCAV2dPgx5DEAIbCYC0ZbLfUVvZnhtK88zPYFIrzbp0mX7xz1GX+kmOPxW3oH0iXBxGVK5ZKJmmUyZpDvdDbhgEd6NI2CFAJjitYn1aiD+xwSKesechzg8c6SvriLcDhaHMN+aaSzavZ2EI1pCFyv5SeKhwUNUN1wC1HrAgQjPF3UMpDvno37E3WtiZRPK4VwM7WmZOYpsEHkK9j6AoJfSvqWJfz8x5J8CkM/IJt/wCHXZx9Xg13fw8eMFUEzq5/8G4HpyrZDXEHETQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=flxUTfOonyMUw1pFsSok9YEp6gNS+Bgz8xVVh7K6il8=;
 b=WD3EM6C1xB6bZcDJLEKNqLuzSlikntpZQQq0yNrIXuEvFH9RxEzPUZKYGSWzUOMR30I0293D0rCEVTTSDH8CHpf8fwV3okm6221+s1Z1gc23Pa4h6lzdTvjyYrT/r83TO9tY2TqkNeEmXMGv6mmB1BsjawOeJjqpp2zNrIR30lLNYq+GzGtApgGeK0TuRjB6Wx0F06A9a1LcQK0qiNQRVwtsFoZCdz6TRy1DHxp3h0JYPg8TODzyq99UG2QYV5EXZjJSBaH0Vyw//G1utp02cv2O7VX4n7iVjfvehy+i0QMOCBL6d7J+vd+wZPwUVqr7XVjEvdmtfsEK3+lN5WKIEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=flxUTfOonyMUw1pFsSok9YEp6gNS+Bgz8xVVh7K6il8=;
 b=dC/GsReYTzTTwYIw/tmaQ5zUBNZVDE5XDVXlageoGErpISZ0RUYFtAUHad8fA7mOogSwuk0lCRfr/DD1eX+NJycSHG6DBdry3xm+r3+xbWmUJMG8Vzwcfmp77kHhKkZZx6ZSIAy4A8zk1JjuYX/StuVFS35OWUW9Xt3t7oKcuoE4Rg0xW8C0Fc0Bs5Z+Cv0ef4fI0Nv/4kXYo9KoEKCSVFqxLMy5Y1cu5rpGqY2Um2kdBk4AYARFzudulXkcSmz7v8vG71GPXnogzo1SF/LnEsrUSMDOX+hb0k4k/OjaxdzFEF9VrduHwAjnP05t2RmAiW5rxax9Kl39NqjSepV4lg==
Received: from DM6PR12MB4516.namprd12.prod.outlook.com (2603:10b6:5:2ac::20)
 by SA0PR12MB4479.namprd12.prod.outlook.com (2603:10b6:806:95::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.28; Tue, 30 Jul
 2024 10:52:28 +0000
Received: from DM6PR12MB4516.namprd12.prod.outlook.com
 ([fe80::43e9:7b19:9e11:d6bd]) by DM6PR12MB4516.namprd12.prod.outlook.com
 ([fe80::43e9:7b19:9e11:d6bd%3]) with mapi id 15.20.7807.026; Tue, 30 Jul 2024
 10:52:27 +0000
From: Danielle Ratson <danieller@nvidia.com>
To: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "mkubecek@suse.cz"
	<mkubecek@suse.cz>
CC: mlxsw <mlxsw@nvidia.com>
Subject: RE: [PATCH ethtool-next 0/4] Add ability to flash modules' firmware
Thread-Topic: [PATCH ethtool-next 0/4] Add ability to flash modules' firmware
Thread-Index: AQHa14G1FB+igyUZzk2DVN9+CsaMkLIPLZnA
Date: Tue, 30 Jul 2024 10:52:27 +0000
Message-ID:
 <DM6PR12MB451628EE1A7810C8C8AC1323D8B02@DM6PR12MB4516.namprd12.prod.outlook.com>
References: <20240716131112.2634572-1-danieller@nvidia.com>
In-Reply-To: <20240716131112.2634572-1-danieller@nvidia.com>
Accept-Language: he-IL, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR12MB4516:EE_|SA0PR12MB4479:EE_
x-ms-office365-filtering-correlation-id: a2f9b981-e5ad-4180-651b-08dcb085b3e1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?QXBBdzAwamRuS25CbVhydUhNWCs1akQ4OWsrK2YzQjhiQjdibVdqU2hNL2J3?=
 =?utf-8?B?MW1nWWtVdld3OE93NkNiUmF1dGIvSTA5ejdDVCtqZ21rOUVmcWNaZFkxaWJn?=
 =?utf-8?B?bUozeHBZQy9aODgyc1N2eGcrc1d0WEdsSDdvbXBuL0RnOUlBOUZmRERyZTg4?=
 =?utf-8?B?UTJFME9ib05FRXJpcW5ucGJJK3REdWpiTVBDZGlFSGU1dUg5bllEU0JuYlpr?=
 =?utf-8?B?b1dydTZSMldGSE5TZ2F6RFhyWiszTEZUa2UrVTQ5RnU5My92dGMxYXR2TVlJ?=
 =?utf-8?B?VXZRdFBUQW41STc1Zm9nekpLNDJFZThLNitSa01YRWpEd1ZVRngvdVl0ZUVI?=
 =?utf-8?B?SjlqT0lIWGh0UndqdnIxWjltN1VNbUQ4ZEV1MDNJZC9IbGJxNlJFbEhxQkFD?=
 =?utf-8?B?WDVKenNxTTlhT3FNOUQvNG8wZDJaQ3daR0hDUFE1YVNFMVdkS2NvN3NzdThx?=
 =?utf-8?B?dWswRDhlVkFTcFZhRHJQZkJmdm9zMkdtbWcvMzdZSW9wOGNKTE40bmZCWXBU?=
 =?utf-8?B?UmtEQkQwa3E3UUp4SUtXbWNTY1gydE1uby9vYjM2VW1xdGZld3BaY1F0cjlQ?=
 =?utf-8?B?RC9tU3pXYllVZFc3bm55T0YwUWx3WExVTWpWSHhwVldMK0IxdnJhSFhyUWFt?=
 =?utf-8?B?NFByK3Irck5meWdiWEpBelVDYUNQYkJmQ2JRaHJJSkhYbE5oVWZWRkRqNURq?=
 =?utf-8?B?bjVsRU54di9EWWtBdUxiR0Q0ai94OWVadXZHUHBucFNiU0k2UzZmRzBDSTVO?=
 =?utf-8?B?bnRlTGlCb0FlckhBRC9ybHhlcHpvV2VUdHBINzFDUnZ4b0hwUUdldm5jWEpZ?=
 =?utf-8?B?R3ovQzdsWFN1aERvR2ZzaHZLZnJ5RDBNNEU4dE9YVGhDKzRhVjJkWFM2RE5Y?=
 =?utf-8?B?em82bHo3OUtZT3piMTJYa3pHZjZjaUZ3QlA3QlBMbTRacWdQWmFBaEg5VHpH?=
 =?utf-8?B?aDFDaG95S0M4ZVdmL1M3YnJ0bWJPVnppWTFPV3phejJnTXNSTlI4a014cXcy?=
 =?utf-8?B?bEpuemtOWExKNG9lZGxaN21JbU9UTXcwNG5IUjhUSlhXdzZvNmxXODFhR0t4?=
 =?utf-8?B?OWN3SmdkL2FDTlJsR1VXc1V4MWpqcSthWlg3ZWxkWFBZVUZSRXNYTVFuUXoy?=
 =?utf-8?B?Y3k0Ti95aEkwUlJtRjFLSGxLUkNGZVZkTVRTaVRXelhiMlU5UUNWTE5JeXNW?=
 =?utf-8?B?L0pleXB0aExiQ0RKR054eWhSV3RFanRPSkEycnczMk55Vk5mb04rcWFJMXl5?=
 =?utf-8?B?RVhzV2R1U1NERUpTZUJxYy9ycS83S1hPSmpjN1FWTVFWVUdGWWQ2SnBYNFF2?=
 =?utf-8?B?YXFRNG8zK1lSVzAxMUlWQUN5RmlNRndlUDJGbTNzdjJxUGNOd0JvS2FQK1ky?=
 =?utf-8?B?WDlQMnUvTmVMZFZ0U090WTAyMWtIV0pTVEVUbTZCYmpMUjFack5HNkZUYlAw?=
 =?utf-8?B?ajJoM3hQU0dQWXB0c2RacG5MbmxDQnBqRUF5RVR6RnVrVUFuNEhtRHpyN0kw?=
 =?utf-8?B?YXV5eDZOY1MxMmtDbzFJUEpHM2JDU3lUYjFkYUdzSmFCRmVaZG51RDYxS2Ex?=
 =?utf-8?B?QVZFeWdOVkdtUzRuMExoSEkrMG1yUEczSklwa0ZCWTRHdXhWZ04rRTVxcHRE?=
 =?utf-8?B?b2NLWWZGSFVRVU9zRnFRNFZHOEZzWmhzUEhMdVpGbWRyS3hGeUkvVXBmY2ZK?=
 =?utf-8?B?SUdGVERDREhjZkV4T1ZaemF0NkhQaHBEMEdSZWVtTEtxWGI2WUJnMDgwamNF?=
 =?utf-8?B?cktJazJlVTVYYzgwcVVhMlpjZ3lnMWU3eTZqc0h2bHF4c2pVcS9qNHlyUTBM?=
 =?utf-8?B?bEkvZk9hRUhUbCtXdnQvQjVlR05HNi94T0ZBSXk2TnNqNytScWtqUG5pTGdt?=
 =?utf-8?B?d3ppZWdUQWQ5RXBUOFRsdFNlMG5nNlZaN3FIOWpTeEJlcVE9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4516.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?WHh4MzYySnd5Q05oRTdyTjlGY2lob3lReCs3ZzN3ZFR3dE1jcG5vSlovOWV0?=
 =?utf-8?B?R0dqVXJza2VQUzR3Umtvc0RUdE15cktFeEhBRi9qTFR1YnRVNi9xVE8xUmg1?=
 =?utf-8?B?bFRSZElBZkcwdlpNYUdPMWZZOGkyd0FFU0tra203eXZFSS9xZXFkejVMT1lR?=
 =?utf-8?B?NlBHbVUyWXYvVllZYkVmQzZVNU16VFpkSDVqVDNsMHkvQXByOXplcXIyNmRn?=
 =?utf-8?B?cTBDc2VteTN1eXNWUG1kblhBajFKeWNKQ0tvekxhb3FTWndzL0ZuOXpXK3B0?=
 =?utf-8?B?Zk4xbzRDVk43czV4ZElvUkNRVTNPTWN0dVUxQk9WbnRKRHAzVVo3WmxHSVdG?=
 =?utf-8?B?SitIaG43bTZRZGU0d2xaa016OXV2eThycXdiRi9LZ1phMlhqby9WaW5od3dG?=
 =?utf-8?B?Mlc2YlV6UFVsbXkyaWJLRFgvM1BHNmVUMEU0ZitMbTJqeW1pdThMbTVld3Z5?=
 =?utf-8?B?VngwQU9zOVJ4SUtLSFZFNUZ6UmNYM0FMajZRWVUxOGQxVG5mZDAxT2REalEr?=
 =?utf-8?B?cW01cGhtYklucHNnVTFHeTJyWWFKVTdaa0FZZlNTRFZTdFZkQlpZTXlVVWJE?=
 =?utf-8?B?SkZwUWw5T2dPeElYU2p6aFN1S29TR08vMXpQTzBJai9ZZXhyWEJpZ2NBNURp?=
 =?utf-8?B?bHkySldYVGRyY0UwZmRwbEl4c2FGN01wQVR0RkdxRG8rbDUzVzhoV1dtdXBt?=
 =?utf-8?B?NjZzWHNEV25WQ0dONmhRNTFVdEZlbFFUZzR4V1BxOUpQRkdvcXY5d3FNNUNG?=
 =?utf-8?B?bm1EbDcxbFc2a1VBQkhBRUd6aDU1QVBhTllKQVNHM1lxQU5ja2dMSEU3Nkdt?=
 =?utf-8?B?VUxnVjZjUDduNFFvdHlwTnFaSTc0M1UxRU9QS2tBRy9ZVXBBNDU2L2MwSmg3?=
 =?utf-8?B?amVPd3BMRm5NL3A1RkkxR3JDbC82ZjZ6UU5jKzd5SUFvOXhIa2dsQjVDUklh?=
 =?utf-8?B?anlnTjFEK3JNR3VuV003bFZLVEV3Y3dCWm50Y1VoTm82S3ZsS0ROdFNycG1x?=
 =?utf-8?B?QnR5Z2JweDBHWlNSZjI0dDMzeTFzSkd3ZzV2NEZ3Qmt1SEtYeVdhdTlKNkR3?=
 =?utf-8?B?ZTBZQjJUVVc4bUtIQm91NlB6RDUrdUNtUHExcU4zN0w1aWtxWnMyMnI0SHZR?=
 =?utf-8?B?WDFFT2cxbURwaENxbU1NVkpzTnBIdlc4YWd2QSswYUpDbm1WV3J5VHlGWm1F?=
 =?utf-8?B?SW9zNHMrM1pXWTFLT2MxQ0JwRjBQUUlzcE96TEhydjllaVRJRlJKamFJOVpG?=
 =?utf-8?B?R3JMVm9vbjd5alZkRHkvN1VpRGxDNTY5WmwvWTU2VjVvNGhOZ1h4ZXBEK1l5?=
 =?utf-8?B?M3hQUWFUTFVZVUdEcXp1SlFIQlVGa3c3ZGZheE5zNTlmL1J1NTFsczBJemZm?=
 =?utf-8?B?bFpXeXU0ZDlWUjcrdlpadnVTVXhMdGIvd0RicHEzYURaSm0zOTV0K0dRS0lP?=
 =?utf-8?B?dlFPa3o1Y25RZDV6YTIyZjVxSWZYUW5hV0N5NWtqQUtRa3k3YUZMdWRRT2VF?=
 =?utf-8?B?SXFMcHZLT2o1eFhEVFUrQ3o2NnljWE5HRXVqdTRLT1ZGRzBNNnRPTGhodUU3?=
 =?utf-8?B?bkp3ZEV0clZEUzRXWHQwZmoyeUFFZ3NFNjNIb0pmMnhxSjdTc1MzVFpzUDY2?=
 =?utf-8?B?RlM0WXNsSEpaa0hHN0F4Z29SVjlyUGxKYk8ycmxEL0xoQkp2bzFUdWxOcUIy?=
 =?utf-8?B?SFhBUUtQWm83ZWFyckZWRlQweUd0VWYyckhyNnI0Q0pLaDUvQVNUcXU5a2Yy?=
 =?utf-8?B?bHZzQ3lSNXF3MDJITEpOMkVGOWVwb2RGRHhrOVN1am5HVFlmeklFNXBOY2M1?=
 =?utf-8?B?UXNiMFlxazEyUTlydk9OQ25hT0xrb3cwMjNKQTl4S3dCS2p1bDk4Q2l2SWhM?=
 =?utf-8?B?RmNoRWtBZVozU1IrYlFPdnpoeVljcjlKM0h2VThBblkvaThjN2YvRTU5QjV6?=
 =?utf-8?B?QitMQ3Z3ZThTeXhpWlRwaElFZjBkRjZYNUdSSk84WTZDUTB2bVd4c3lydU5H?=
 =?utf-8?B?aUN5a09Gblc5UTNWWHhUQzVmMEd0VFFjUVEyVHZYODRlTFJFWHZJTE4wRkhG?=
 =?utf-8?B?WkhjNmpFTTFOMU5NMFB2b2N0NkxXQjdzbmQvcmwvRnhVOENmdDJYVjJpc3ll?=
 =?utf-8?Q?1/VbqXXIPYvEdYlJOOO6t93lb?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4516.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a2f9b981-e5ad-4180-651b-08dcb085b3e1
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jul 2024 10:52:27.4740
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0mS0pTDkkOpGzRPrkOEtll702mDD6wGzj4Un/ojtvhZh7LRN/Iz3D3PSpZclOKbiuaa45ZYlqGAlh7F/QZS37A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4479

SGksDQoNCkkgaGF2ZW7igJl0IGdvdHRlbiBhbnkgY29tbWVudCBvbiB0aGlzIHBhdGNoc2V0IHll
dCwgY291bGQgeW91IHBsZWFzZSB0YWtlIGEgbG9vayBhdCBpdD8NCg0KVGhhbmtzLA0KRGFuaWVs
bGUNCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBEYW5pZWxsZSBSYXRz
b24gPGRhbmllbGxlckBudmlkaWEuY29tPg0KPiBTZW50OiBUdWVzZGF5LCAxNiBKdWx5IDIwMjQg
MTY6MTENCj4gVG86IG5ldGRldkB2Z2VyLmtlcm5lbC5vcmcNCj4gQ2M6IG1rdWJlY2VrQHN1c2Uu
Y3o7IG1seHN3IDxtbHhzd0BudmlkaWEuY29tPjsgRGFuaWVsbGUgUmF0c29uDQo+IDxkYW5pZWxs
ZXJAbnZpZGlhLmNvbT4NCj4gU3ViamVjdDogW1BBVENIIGV0aHRvb2wtbmV4dCAwLzRdIEFkZCBh
YmlsaXR5IHRvIGZsYXNoIG1vZHVsZXMnIGZpcm13YXJlDQo+IA0KPiBDTUlTIGNvbXBsaWFudCBt
b2R1bGVzIHN1Y2ggYXMgUVNGUC1ERCBtaWdodCBiZSBydW5uaW5nIGEgZmlybXdhcmUgdGhhdA0K
PiBjYW4gYmUgdXBkYXRlZCBpbiBhIHZlbmRvci1uZXV0cmFsIHdheSBieSBleGNoYW5naW5nIG1l
c3NhZ2VzIGJldHdlZW4gdGhlDQo+IGhvc3QgYW5kIHRoZSBtb2R1bGUgYXMgZGVzY3JpYmVkIGlu
IHNlY3Rpb24gNy4yLjIgb2YgcmV2aXNpb24NCj4gNC4wIG9mIHRoZSBDTUlTIHN0YW5kYXJkLg0K
PiANCj4gQWRkIGFiaWxpdHkgdG8gZmxhc2ggdHJhbnNjZWl2ZXIgbW9kdWxlcycgZmlybXdhcmUg
b3ZlciBuZXRsaW5rLg0KPiANCj4gRXhhbXBsZSBvdXRwdXQ6DQo+IA0KPiAgIyBldGh0b29sIC0t
Zmxhc2gtbW9kdWxlLWZpcm13YXJlIGV0aDAgZmlsZSB0ZXN0LmltZw0KPiANCj4gVHJhbnNjZWl2
ZXIgbW9kdWxlIGZpcm13YXJlIGZsYXNoaW5nIHN0YXJ0ZWQgZm9yIGRldmljZSBzd3AyMyBUcmFu
c2NlaXZlcg0KPiBtb2R1bGUgZmlybXdhcmUgZmxhc2hpbmcgaW4gcHJvZ3Jlc3MgZm9yIGRldmlj
ZSBzd3AyMw0KPiBQcm9ncmVzczogOTklDQo+IFRyYW5zY2VpdmVyIG1vZHVsZSBmaXJtd2FyZSBm
bGFzaGluZyBjb21wbGV0ZWQgZm9yIGRldmljZSBzd3AyMw0KPiANCj4gSW4gYWRkaXRpb24sIGFk
ZCBzb21lIGZpcm13YXJlIGFuZCBDREIgbWVzc2FnaW5nIGluZm9ybWF0aW9uIHRvIGV0aHRvb2wn
cw0KPiBvdXRwdXQgZm9yIG9ic2VydmFiaWxpdHkuDQo+IA0KPiBQYXRjaHNldCBvdmVydmlldzoN
Cj4gUGF0Y2hlcyAjMS0jMjogYWRkcyBmaXJtd2FyZSBpbmZvIHRvIGV0aHRvb2wncyBvdXRwdXQu
DQo+IFBhdGNoICMzOiB1cGRhdGVzIGhlYWRlcnMuDQo+IFBhdGNoICM0OiBhZGRzIGFiaWxpdHkg
dG8gZmxhc2ggbW9kdWxlcycgZmlybXdhcmUuDQo+IA0KPiBEYW5pZWxsZSBSYXRzb24gKDIpOg0K
PiAgIFVwZGF0ZSBVQVBJIGhlYWRlciBjb3BpZXMNCj4gICBldGh0b29sOiBBZGQgYWJpbGl0eSB0
byBmbGFzaCB0cmFuc2NlaXZlciBtb2R1bGVzJyBmaXJtd2FyZQ0KPiANCj4gSWRvIFNjaGltbWVs
ICgyKToNCj4gICBjbWlzOiBQcmludCBhY3RpdmUgYW5kIGluYWN0aXZlIGZpcm13YXJlIHZlcnNp
b25zDQo+ICAgY21pczogUHJpbnQgQ0RCIG1lc3NhZ2luZyBzdXBwb3J0IGFkdmVydGlzZW1lbnQN
Cj4gDQo+ICBjbWlzLmMgICAgICAgICAgICAgICAgICAgICAgICB8IDEyNSArKysrKysrKysrKysr
KysrKysrKysrKw0KPiAgY21pcy5oICAgICAgICAgICAgICAgICAgICAgICAgfCAgMTkgKysrKw0K
PiAgZXRodG9vbC44LmluICAgICAgICAgICAgICAgICAgfCAgMjkgKysrKysrDQo+ICBldGh0b29s
LmMgICAgICAgICAgICAgICAgICAgICB8ICAgNyArKw0KPiAgbmV0bGluay9kZXNjLWV0aHRvb2wu
YyAgICAgICAgfCAgMTMgKysrDQo+ICBuZXRsaW5rL2V4dGFwaS5oICAgICAgICAgICAgICB8ICAg
MiArDQo+ICBuZXRsaW5rL21vZHVsZS5jICAgICAgICAgICAgICB8IDE4MyArKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrDQo+ICBuZXRsaW5rL25ldGxpbmsuaCAgICAgICAgICAgICB8
ICAxNiArKysNCj4gIG5ldGxpbmsvcHJldHR5bXNnLmMgICAgICAgICAgIHwgICA1ICsNCj4gIG5l
dGxpbmsvcHJldHR5bXNnLmggICAgICAgICAgIHwgICAyICsNCj4gIHNoZWxsLWNvbXBsZXRpb24v
YmFzaC9ldGh0b29sIHwgIDI3ICsrKysrDQo+ICB1YXBpL2xpbnV4L2V0aHRvb2wuaCAgICAgICAg
ICB8ICAxOCArKysrDQo+ICB1YXBpL2xpbnV4L2V0aHRvb2xfbmV0bGluay5oICB8ICAxOSArKysr
DQo+ICAxMyBmaWxlcyBjaGFuZ2VkLCA0NjUgaW5zZXJ0aW9ucygrKQ0KPiANCj4gLS0NCj4gMi40
NS4wDQoNCg==

