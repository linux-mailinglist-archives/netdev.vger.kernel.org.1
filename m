Return-Path: <netdev+bounces-213208-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E081AB24207
	for <lists+netdev@lfdr.de>; Wed, 13 Aug 2025 08:58:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D545F3B0EC6
	for <lists+netdev@lfdr.de>; Wed, 13 Aug 2025 06:57:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6616D2D29DF;
	Wed, 13 Aug 2025 06:57:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="d/ooMlpi"
X-Original-To: netdev@vger.kernel.org
Received: from OS8PR02CU002.outbound.protection.outlook.com (mail-japanwestazon11012055.outbound.protection.outlook.com [40.107.75.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B85A12C08D9;
	Wed, 13 Aug 2025 06:57:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.75.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755068228; cv=fail; b=puaZvZ1qI33sXxjUyD0DmcbDYgUtOZEteOo0WV7h7F8vMlBlwmLjJFQloEAoHnyeaxOa40bZkdz1EBdYB9CxEEAJcQkWfIM3Bx4tEKjSvDmM6orZnJDkHBY4m9X2lqpoIZgaXayWlkrH+gSSwONdvxngEc489dTiZD2K5xyH3qU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755068228; c=relaxed/simple;
	bh=v2mwaqtFvEm+hZmtUgBTc3qZxDcGAyL+aa348e3exN8=;
	h=Message-ID:Date:Subject:To:References:Cc:From:In-Reply-To:
	 Content-Type:MIME-Version; b=T6ouIVZTc8YLv24WV4MNZLt2u/XVtwvkw9s8JlPzJR3GwgjM00ZvATj4ig+jskKNTnHdJxDJ/gO+Hfd0Mz+iARydXLVxC2jIWlQ3Jc75CXyTjmosIkppUwDh6s19dKKddwBVJ5RL5qDnk0nuZI1lzqiv4hkt0SbCHOYzSWuP4EE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=d/ooMlpi; arc=fail smtp.client-ip=40.107.75.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oAWAHk13sQYCngh0sRa2pS1Hd1wuuxGXxLl4O1EiC7mUNhUU9D+g0RhWcyRwyb+yzAPpWfRIXO5wTkSjYpcwEOzZkmObplSp+DztWHJNGKcTbGmquiC+hAXKbI2jRpGZFsPeZ5h1YtmzHEjBrkEn1GiDDPuG1DQ56lZx4C3fFK3O2XeNHtv2l1W/l22kY4LvL3qKqlYatZIvxazCLGfNEIb1cm9qTkMaYWaDFwqO2tQRVCgQKgIt3xMd+z7Zv49DZW6RCN+2XnsoENsPsePP/px8e9DdZomdDt2Kw93uBCTEOG2OjlOHmJrohIy1XgZ/7guhVfe/FfzO1FCuw5Rerg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lAdtOss42sx8u2gp9ZTam8KAjBRxTJ+nQZlO4wqsQZA=;
 b=fzv2oBt23AldCsLiwIBVeBq9luvvv2HS/U3dAZLcBrHv0PlflCpWNV/f9jVS1l/lk0kA7TDB9HpHpnz86RCkBYJ/eqnLMb7VM8E/YWbVjfPkxjOdAvANwZojIZIChUDYEll+9tPuzCelHc3yhHO/fEyLQQqjTLwOqITZ+UBFO/2cgHBI86Gm73jA3TJypWifn9BXG4lDV+dlYcKFSxRt6CegwAsNyzeNrz3IqGvra7M062z4gafaPaUL0FHnnx23MW6HVlgGWDR4itS5DUQqekNYffy2UmM2c5XgShiqvnHD4BtP0rOoxronoacudrvK5fnoLdqWA+ARWLndBh75Zw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lAdtOss42sx8u2gp9ZTam8KAjBRxTJ+nQZlO4wqsQZA=;
 b=d/ooMlpiZ1vAISCuLmRT9GIm9xQr7bVk/9dJ70+S4rtkawL9merb2MDogpgxtnCqVVY7o+eL5soJh0bRS5mfExt0eh3CVzuzaHKleM8nQfIR4dSAus+sxZo2LOVQNf549jslavIZQLYQXTWrjRagF4q347PNJWya8IXDoE8mUQpPpVMfbk45QaVV7MMVJfHiUQlbV6wPno/YHkr44Q8VW8P40FIWbN3mWYKlz7vpBPHj/VZCfEuvAIaZP7nrIw3rYy4UhNPw8FmrfuuhdIA6PDNGHeSt1KTxAcVD2mIC/RjzZm8vjIf6noiWWBIElh7x41kxjJgQwu7ZjnDpVkB3Vg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5576.apcprd06.prod.outlook.com (2603:1096:101:c9::14)
 by KL1PR06MB7011.apcprd06.prod.outlook.com (2603:1096:820:11b::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.15; Wed, 13 Aug
 2025 06:57:03 +0000
Received: from SEZPR06MB5576.apcprd06.prod.outlook.com
 ([fe80::5c0a:2748:6a72:99b6]) by SEZPR06MB5576.apcprd06.prod.outlook.com
 ([fe80::5c0a:2748:6a72:99b6%5]) with mapi id 15.20.9031.014; Wed, 13 Aug 2025
 06:57:03 +0000
Message-ID: <a161ad99-8941-4213-95e3-86c5ef948215@vivo.com>
Date: Wed, 13 Aug 2025 14:56:58 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] vsock/test: Remove redundant semicolons
To: Joe Damato <joe@dama.to>
References: <20250812040115.502956-1-liaoyuanhong@vivo.com>
 <aJt91SSkBO486bg5@MacBook-Air.local>
Content-Language: en-US
Cc: Stefano Garzarella <sgarzare@redhat.com>, Paolo Abeni
 <pabeni@redhat.com>, Konstantin Shkolnyy <kshk@linux.ibm.com>,
 "open list:VM SOCKETS (AF_VSOCK)" <virtualization@lists.linux.dev>,
 "open list:VM SOCKETS (AF_VSOCK)" <netdev@vger.kernel.org>,
 open list <linux-kernel@vger.kernel.org>
From: Liao Yuanhong <liaoyuanhong@vivo.com>
In-Reply-To: <aJt91SSkBO486bg5@MacBook-Air.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2P153CA0053.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c6::22)
 To SEZPR06MB5576.apcprd06.prod.outlook.com (2603:1096:101:c9::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5576:EE_|KL1PR06MB7011:EE_
X-MS-Office365-Filtering-Correlation-Id: 95f537b9-5865-4481-c38e-08ddda369b42
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NG9uMk9rTGErUys3bk52NWpEMVZvMDBRSlhtWmdrb0F6clo4dk9RT1E1Rlpu?=
 =?utf-8?B?WElnbXdseDlzWksweTVveFFUYk8reUJwM2ZDaVQ4SkxOUk9wTUNCdjhWS0Fk?=
 =?utf-8?B?V3hYRklUS0pwb1dxZG1wWDNuZ2pMcEJqdURRQmxkdU44ZEt4N1ljL1RIdkVu?=
 =?utf-8?B?VUpHdDBaWW00d21XajlERU1ybjdldStrQndkY3FUZktzeXBpdkJuMGFkY3lU?=
 =?utf-8?B?RmNLWUZIc0pxYUZuSTVPV1BRa2g4ZTVwZXlTT3BHTVdiYXo0NnpOa2ZUYVZ4?=
 =?utf-8?B?Y3RJZmVMczNHQk1Da2IrQkZMa2NhazRxdDNlRFpiMGptT3JVcHdTZnZXMWZa?=
 =?utf-8?B?SURINHd2YjFOZVAzaEpaeUlndWVZS0FVQlRaaVFncFU5ZTRiYXkvVkNMYXJS?=
 =?utf-8?B?NmhaNXc5M3FVdjBEaEFCSjBSRDFWUjUxZTBKZ3hEdVFYdU0zcTQwb2d0eTYw?=
 =?utf-8?B?b3M1QWRabVNheFlxTlJXZ3YzZkdOSXFIZi8xYnJGeEUyQ2Rod3ZsNERscEhv?=
 =?utf-8?B?OHdLOHllM0lZd3hRNU1jR3p0VkIydUJWQ2Nmd25nRm9pTWtVSzdIei9oZXJz?=
 =?utf-8?B?WUJWSExGeXRJRkgycGl6OUFJM2tWdVcrN0VSU1ZnSTJwODBlcUhRWmp3Mi9m?=
 =?utf-8?B?dFMzc3pPMkpTZ3pLSWlLc0tTb25LOGhTcVpIWUdQNlRRMDVKK0x3YWhvclVR?=
 =?utf-8?B?Ykp4eVBuMnI2RFlSSksvSnFTOXpTemNoN3ZIUEZJVTM0bGRoeFRJSUhlMjRS?=
 =?utf-8?B?cjNJVDV2RHNUdERJSUQwc080RlY4YUZUalNxK2FSejJ6NjNIZVliWXVIOE8y?=
 =?utf-8?B?ZzQvaENsVVhtcXpGM2FYQzBOWHprNEY5a25QL0l5RWoyUm8vcnduYWh5ODVD?=
 =?utf-8?B?bnU1NWFoNEljd25NSlVXU2lwcHN0VlIrdHloUUd3Vm53N05GOTFySVlHY0sx?=
 =?utf-8?B?a3U2c0IwaWRYR24xa1A3cjZ3TktBSEFkdVpNRkhQUHE3SXhaTnVFM1FDUXd1?=
 =?utf-8?B?bUJCY2VET21GNkt5bUF1eDZlaTBMWnFJVHdwZ3dWbVh4QXNvMzZxSTUyOHhq?=
 =?utf-8?B?eTVDcEVkVlV2Ly9tOFdxWWR4cS9ROG93V0Q5ZXluNGdyKytxRW15NnJsTHZS?=
 =?utf-8?B?aHpVenJYcjlsWS9lVFZURWRPdlNCam42VGVLb1d1SmtzTjNnSU1FaC80NUgv?=
 =?utf-8?B?cUF2U3RCaUtsalFNZHIxMEhxbGFQZVNjeHJPekQ0K0FmU0dSZE9hbk9iTWR3?=
 =?utf-8?B?SWt2T2RqUWF4LzJMak1BNFlTZE5SUDNyRU11L0tsWDJOSldSOUVJUnpWNkNk?=
 =?utf-8?B?MXE1empuQktyYkt3WlIvOHlNanlXaWVzQUU1WmRoVDdIaFB3NTc2Q1QzeVlu?=
 =?utf-8?B?bzBYaGJRQ0Rsb3Z5TEdMV2ZsREZERjNUc1NZMkkyWjRrUXgxdkZIU1Jtbmph?=
 =?utf-8?B?amk2UFRGTURuOWdFTU5uR254YThXR3BrS3NkUDF2aHJWWXFFVE5jbWwrUnR0?=
 =?utf-8?B?TWtNTnE5dmR0NWR6N2FJS2VLS2ZXMzdqTTFmMUNLdzRkMVVOeHJ2TkpsdFQr?=
 =?utf-8?B?K2Y1ZXpmTGZlVDhYa1JEUGVqN1ZoMDVPUlFHNFBlNkc4VzNsL1hpN0VhT2hm?=
 =?utf-8?B?dGpSK1V4V3RtKzcyR3d1YUxBdk5BdkhRemRVS0YrZkI4bHlJVEREazJkSzBt?=
 =?utf-8?B?WHk3eUo3aHBGVS81WEppRGVqMU53cXFSeXBndHJRNkp1V2dDVEJrS2ZBbVZJ?=
 =?utf-8?B?djg2UEtmOWdkeEZPUWFXMnJWZ0UxdVc0a1BsU0cwYjdQZXc5SVBJTFRseDFU?=
 =?utf-8?B?K1p4TkczWWdmQjNYLzdYOWYvWFE5NklmQ21DQmkvQXRlTjg1YUN5dWtNVFV3?=
 =?utf-8?B?bVNZaTM0YjQ3b0VaTmZWbEZhejBpd01YaG1rVm5FdVZPaklNd2VqeVNGR3g0?=
 =?utf-8?Q?rBHMHj3+tNE=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5576.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TXJHUlQzak45NFhHYTU5My9GUnZtT0sxeERnY1BkU0ZjVGJlalNRdkpWc1Nt?=
 =?utf-8?B?NDRNYnpCSkpScG9EdmpoOHBRUW5KWnF6NklzandDYU9VOExuZ0cxNnVrSDRB?=
 =?utf-8?B?RDI5RFpOTklCYWhRYkpKM0lieGZaUS8xUDJsbGI0RlhHNWo5ZG82KzVIbmVK?=
 =?utf-8?B?a2NLajF6ZVFSWWV6QVgraGNpcjFKcTdIL0JrbjA3R1dpa3loUkJ2eGJ3M2pY?=
 =?utf-8?B?RkkzVnVtNWlTUjhxSzJ5dnV0ZUxCd0RhalBLNEQzeWZUcHBNMm5iTXdEdFFL?=
 =?utf-8?B?RnBLQVBhT0RScVpUVWRJdWdJT0lWRm9STzBaclB5MmxBaUZVWjgrdEoybEFZ?=
 =?utf-8?B?RkFOTk40MDI0THVzVTBTRWdPNGJpRVU2OVdZclhtM3FLV0xtcXNsTW94SDk2?=
 =?utf-8?B?QUVkT0tTUG4zdUQ5UkxuMTJQcTc2ZGlGWGJHaG9sSG16QVh2S0VFbVNHQVNL?=
 =?utf-8?B?ZWRMYitkclVNTFgxeFNQNGNmcXl5bWxIYVEzdlB5aUhLNk9uL05FNVpSaUl5?=
 =?utf-8?B?MGtPMUxGMG1LMmoxM1RFankzcDdVNU1vZHlkZnZDdXFUeFVQQlp4V2lOVHZM?=
 =?utf-8?B?bVl3aEFPbEFzTlYzbDlIWmllM2syT3JaRVdhV29PLzBINVBuTEhmWHhuRmtN?=
 =?utf-8?B?UW1ncThyazVhY2FGa2V1dHp5NlRiTHJQTHNNWndGSTE3NHFIVTBpTExrYWZy?=
 =?utf-8?B?WlZYSmxRUDVvbTFiTDZ1TnNiSHNqeVUwNEpUa2VYYUFoSTRXaG8rZlNmUXRT?=
 =?utf-8?B?YU1LWU9kU0hVRkMxYnAzY3UyVEU3WWJjYnJsYUF0azExdllMR3p3R2pLNThz?=
 =?utf-8?B?MW5PTmo0VWExc2xEcHFTYlU2RzNXWjA4T1Rzc0FjR0lkWEJGTm4xendFck5Q?=
 =?utf-8?B?ZC9TMWhGenlUR0w1bjhMdGpnTVV4ZWhWNkRLTi94ekF6RDhMK0tNS2NxOFBa?=
 =?utf-8?B?U2szcjlkSDhLbk12ZEZuQkMwdGcvVHFZVHN0ZFpUWkVhd2JrZUMwRDg4RVN2?=
 =?utf-8?B?VkRvS1JuVjk1ekdHVzU3NktySTV2SVVTQXBTcWg4WWVLSFpMc041MENiUXAz?=
 =?utf-8?B?Z1J0STJHazhLRWJHRWcreDV1N3hiZWo1VVFBM1cxOVRsYkhUUUg2QzJsZ1FF?=
 =?utf-8?B?MDZ3RERaWncrUkVZSUJ0dzZLakRqUGhYbWZUR1RnTm0zSWJzdnk3b01iOVNU?=
 =?utf-8?B?Tzh2OVg4d0V2T2NDVllQVXVSUDFOcjZmSGpBTmk4bllRR2N3S1BoNnh2K2F3?=
 =?utf-8?B?aVNwUC9FSHBQMXZhbUYxM3EvMGFRZ0YyRFIvWElhTTJ4M09EWGhUK2IzTE9Y?=
 =?utf-8?B?NmJwcCtGVEd2Q0FmNWFSbWUvcldMb3B3ZVJadG9pZnRzVnBmQXBzWDRZeWJ2?=
 =?utf-8?B?NnRXTkpwOWJXZWNFUzQ5bkdnQ1oyOExWQWVMNjJZSGE1OU9RWXBhTVpaTnl5?=
 =?utf-8?B?ajQzMGJrNExrVEtEaUlEUU9RSmFTYjVkZ1NYQXpLcXFDZHU4Y2YxK1VKUHRx?=
 =?utf-8?B?Y05WZURLQmkxYWdUaWhoby9VNURzTU9PdmZWK1NsUDRGWXdWRmFCckYyemda?=
 =?utf-8?B?MzM1WCt4eElUaVd1aE5MeTRUVlNxVVJWZHE1OFQxelh2UUdxcVNHOVhEckdR?=
 =?utf-8?B?U0p5VitRY0FlK1F4OEppa0Z6WVlZeTQwN2tkWnkwdGVqN3ozWkJMbnpUbFN6?=
 =?utf-8?B?RUtRMGVVb0pjREJaU1kwdWU5VFZGeVhOSFJPWHVuNWdycXZPaXdIZmJ4c1pa?=
 =?utf-8?B?Q1JZbU5YaEx5ejJUR3hBMm4zYXlmUTB4REdWZ0FSUVYySDViL3Q1N0RqUW1x?=
 =?utf-8?B?QTBpWkFsMkR1RTUrVVlkZXJ5bUZMaUI3V0p5dFZnWGZ6TnpMbllFUUc2SDJi?=
 =?utf-8?B?UXhoSHNSQXlOWlVsTTNYbnNvSTRDTEdzRFZYWFl3QUJ4UzlJNk4vQmVwTytC?=
 =?utf-8?B?WlAwZWVZVXF0UGVoQlRtMFlrYkFhOGNlQ3VtRUtMaUt1V0VqeXg1d0tQVUlK?=
 =?utf-8?B?Y0VWZ0ZLNnE0RVFVSGppU2J3aVJWOG56UlNtWjVjWkJlOXBEaGdEakdSdVBn?=
 =?utf-8?B?Z2ZSSTNWRFlUcVJoY2FxcXJnTEdDajBBQWNlZFEwUnNuQkFZcnJKaXZ6azlV?=
 =?utf-8?Q?QXs1t8pZmThYvvDk1wT2lPq9A?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 95f537b9-5865-4481-c38e-08ddda369b42
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5576.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2025 06:57:02.6995
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KPQMgki7aqDx3UpxW771pj3Um8/8t8oOdcH3qaSl++91mLJgwlhMM5WQSPLJ6ZR+kSYh8vn8lubYNzoyo3f4fg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR06MB7011

On 8/13/2025 1:45 AM, Joe Damato wrote:

> [You don't often get email from joe@dama.to. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
>
> On Tue, Aug 12, 2025 at 12:01:15PM +0800, Liao Yuanhong wrote:
>> Remove unnecessary semicolons.
>>
>> Fixes: 86814d8ffd55f ("vsock/test: verify socket options after setting them")
>> Signed-off-by: Liao Yuanhong <liaoyuanhong@vivo.com>
>> ---
>>   tools/testing/vsock/util.c | 1 -
>>   1 file changed, 1 deletion(-)
>>
>> diff --git a/tools/testing/vsock/util.c b/tools/testing/vsock/util.c
>> index 7b861a8e997a..d843643ced6b 100644
>> --- a/tools/testing/vsock/util.c
>> +++ b/tools/testing/vsock/util.c
>> @@ -756,7 +756,6 @@ void setsockopt_ull_check(int fd, int level, int optname,
>>   fail:
>>        fprintf(stderr, "%s  val %llu\n", errmsg, val);
>>        exit(EXIT_FAILURE);
>> -;
>>   }
> This isn't a fixes since it doesn't fix a bug; it's cleanup so I'd probably
> target net-next and drop the fixes tag.

Do you need me to resend the v2 version without the fixes tag?


Thanks,

Liao


