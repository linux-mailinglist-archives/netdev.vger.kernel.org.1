Return-Path: <netdev+bounces-203731-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 83E37AF6E6A
	for <lists+netdev@lfdr.de>; Thu,  3 Jul 2025 11:19:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2F5047AA53B
	for <lists+netdev@lfdr.de>; Thu,  3 Jul 2025 09:18:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A860F2D46C7;
	Thu,  3 Jul 2025 09:19:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amlogic.com header.i=@amlogic.com header.b="fyyAHKh0"
X-Original-To: netdev@vger.kernel.org
Received: from OS8PR02CU002.outbound.protection.outlook.com (mail-japanwestazon11022137.outbound.protection.outlook.com [40.107.75.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B80912D3236;
	Thu,  3 Jul 2025 09:19:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.75.137
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751534376; cv=fail; b=hGiP4QA4YE/gTaEwJrslT7Icr8NVLai7GvkKL2xP4JfBEVCD4aSAMqa4+w2sxMZBTV2H9Qx0q0dFqqbOiyFITtJtDQd+rjseMXD/TQCp1fR6hz8CM/YWnahN7dgsF7JgwadXbu0zfEbHcWFqThouOarllVHuq72qE+h+iA4MvnY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751534376; c=relaxed/simple;
	bh=Geotadv90K3tYJ7RCaHNyKAuYN/Eo4nmowVz+RgTeNs=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=MG6YcWYhKz6Z9Ew6Y5WksoclBNvfmMlGu9FGOq10L1to7Y1K4l1MWk0bpRGrlpjG/mW6C6TdHRl0nLYZWTDHopsYVze0e6LKdHyVfWYaeObVW3FzyRwCZocsWc2fqCd6nT36JuTpIIGSmP/bAHYQLHR5qQmxmII6SfdliyzLEl0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amlogic.com; spf=pass smtp.mailfrom=amlogic.com; dkim=pass (2048-bit key) header.d=amlogic.com header.i=@amlogic.com header.b=fyyAHKh0; arc=fail smtp.client-ip=40.107.75.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amlogic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amlogic.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OL9KWbp59zlZAhU/cZECnKV30dcsiQpyocb1rh1tUNNQY17PPiMCkbJtTCLjquTiCkvDPuz32ODsFFJNrGJSoEe04ba7C6a66YnZQzQMHen6uEjtQPPKsU2IMogaOoqipQnrujGltvfvsqoPtS4uf/ufpO3Il3SLipVBVKiXp1WwOr5BLXwo4EynuPSFxfITEvc8mNOYB2SOhaXlbTaYvvXCnFS050Cq81LFqB9J+7+Egs9Tvj3aYxhJAEPPIR7wp2WAUKdL9ok8XE7Qi8EDmu62ODXv1YqIA9u5BFhKePkI0CUwlNRdrwkGcr8GJ6PRC1uZKHPo2Sh6bzvfYMEzMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LfdoD8S7mQSGB+u4V+Mc7gfwWT21M1Zuabvl6ta++/w=;
 b=uy0E7M6Z0vhhvKAFZKIkSBBl1A/bmlG2ZYSISpXiKJABzh4zsNTgNMV93EKJhl1BaRr4C60iCdQUPXli5B1Zgwr3Mcr6nQSnndythiyFek1gTPPH6CkxBfqVH+2o0MjEEXJldan953kXgVLsNWrIFZutDhtkrJgjEhHaPMDvNYFiRF58eJeQUr4RYeUJ4Vhhz8Nvlkxi+mX+5TnGLSeV/b99yATIS9zwzMohpDcBxT9c0kkdOg8O7VgGYe7ge8oCKc/Hj4xtn77sk2m3tT+naJEnAQrnc6Bju205LoFhjsMIG1jO5rsTxXttoVheW1vwxSHIUGkEbbud8k+RSXAr5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amlogic.com; dmarc=pass action=none header.from=amlogic.com;
 dkim=pass header.d=amlogic.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amlogic.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LfdoD8S7mQSGB+u4V+Mc7gfwWT21M1Zuabvl6ta++/w=;
 b=fyyAHKh0PbdiFEAXHYG+4vD/IX0YePr1vUzb02AuCqc/gz54bd2A/OuewYm7fcMDezjCZUhs4sUcqQa8ZgRANr7/jb7MpdO1eHhHKLCCj7WZ2/9kYp6YMOiMD1qf7leiI4CImiZ5HAIdxPGxNPYQT7PSXZVy8IIU30WHr4ICQiM/vo8JvRqKLh6+qHdsR70JZDEPE4vacK37oGlV6yv8Vu7/HKwDQ7nvdffsXqAxe3v+HDpQFbVJzdoDhVXJi39n+OXKLTqI26CCfPW3vNYW1Zoqw+BWTCXkn+yHttMfBuEBWuSpWBkleymPWCD7HD67/Qq7hEO5RTuJQH6mAFXqmA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amlogic.com;
Received: from JH0PR03MB7468.apcprd03.prod.outlook.com (2603:1096:990:16::12)
 by SEZPR03MB7701.apcprd03.prod.outlook.com (2603:1096:101:128::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.28; Thu, 3 Jul
 2025 09:19:30 +0000
Received: from JH0PR03MB7468.apcprd03.prod.outlook.com
 ([fe80::4128:9446:1a0f:11fd]) by JH0PR03MB7468.apcprd03.prod.outlook.com
 ([fe80::4128:9446:1a0f:11fd%7]) with mapi id 15.20.8880.021; Thu, 3 Jul 2025
 09:19:29 +0000
Message-ID: <6bed0cff-c2be-4111-a1d3-14ce0e3309db@amlogic.com>
Date: Thu, 3 Jul 2025 17:19:05 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Bluetooth: hci_core: lookup pa sync need check BIG sync
 state
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Marcel Holtmann <marcel@holtmann.org>,
 Johan Hedberg <johan.hedberg@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, linux-bluetooth@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250702-pa_sync-v1-1-7a96f5c2d012@amlogic.com>
 <CABBYNZJCsiKVD4F0WkRmES4RXANNSPK1jvfRs-r9J-15fhN7Gg@mail.gmail.com>
Content-Language: en-US
From: Yang Li <yang.li@amlogic.com>
In-Reply-To: <CABBYNZJCsiKVD4F0WkRmES4RXANNSPK1jvfRs-r9J-15fhN7Gg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI1PR02CA0028.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::6) To JH0PR03MB7468.apcprd03.prod.outlook.com
 (2603:1096:990:16::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: JH0PR03MB7468:EE_|SEZPR03MB7701:EE_
X-MS-Office365-Filtering-Correlation-Id: ff496fe0-da50-4648-9f98-08ddba12b6c2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NXBkb2hTQVZQWVZTbHhyU0t3di8xOWVZWEFVTGxkUDB1RERKdDl4ZWJJQkMv?=
 =?utf-8?B?NVlGOGE4QWROWCtUZ3JNS2FpOG1vdXQvemQ1WHpURDdQSzYweWgvTFYrNmlx?=
 =?utf-8?B?VjRKTTY1d2l0U0w1UWgvalA1cnFsOUFWRStDeU9abkdmc3Z2enNyVkh2YTg0?=
 =?utf-8?B?Y2E4bmMwSlc0aEE1QVdFYTk1aGVLdVc4blRveFdjazJpUXljTzcxeWdLeVJX?=
 =?utf-8?B?Ny80dUZ2THB5a3JPdnBKQ0N4UlU0enk4T0JsVkJuNkpBZEVtMkR4NE1HNFJz?=
 =?utf-8?B?aUxSSGxtRGZydXF1ZnRMTHpQMnJLOG50TnhPWjNXalIweU1BOU9Oeld0Skt2?=
 =?utf-8?B?Umxkdk96ekhHUGw4QmdXZTlPakQ2dlBIdlNnZEFwRW5ZaW0vaU5FN3BmOWhU?=
 =?utf-8?B?MHRIL3FUbGRPWjhqK05mQzlrSHMwT2pvU0M0cVJOTHowRGE4L0dUU1lLdmE2?=
 =?utf-8?B?RHVUc20xLy9POXlJRW41M0dTelhEK3dOWlRrQjBpZUJ3RXRZOVVFOEdvZHFk?=
 =?utf-8?B?RC8vQ3lDSTNCTk5rVlc4UFJLc3lTVjNTZUZCcDdwWnRsQ05rTWZTellJWVY0?=
 =?utf-8?B?MDM3bnFHTldCV0FlREJEbHlCZkFxRGViNTh4QVNjOUI5VUROS1RjL01KZm82?=
 =?utf-8?B?aVhyZkJldUpISmtMV1M1akl5aWJsQnpoU0U1NmZQTnU2NVBBRUdoZ3g4eTBk?=
 =?utf-8?B?WFpOODg2S3owbXN3UmIrSnpiTEEzdkQ0OC83dzBFUm9GTysrUmt3eHF1TDJC?=
 =?utf-8?B?UEw2NVJkYzRLQXpxdEZYdWR1K2FTeStSVVB1YUlWVXRjY3N0a2hzNW9SQjEy?=
 =?utf-8?B?RDRmUERCSjFIRS9pNllEenVOeEV2VVFWRDNMc3BIa2FXeHdUNkZaQ0dhNmow?=
 =?utf-8?B?SUVZbDFTeWo3SDhpK0JXRFcwb1g3c05SQnlac05YL1REbEs4cTZ0SzVRcjV6?=
 =?utf-8?B?Wkk5M3lKcjVycHdtTzVFQlU3SDF0NzlEajczL0JTUGJHOVhJTko1OEZNNEpU?=
 =?utf-8?B?K09mK3lUamx1Wk1LZ0hSTHRGYjZzZzlCTHZyTVZtRzkxNEZ4d1Nsd0Q4emc2?=
 =?utf-8?B?dGtUNytoN2FOT29pN21PckZYRHNjRDZBbkRlSlNxSGo1YmVxTHRSM3FVTTBI?=
 =?utf-8?B?UjEvS3hzSExKSisxNDJURnplRmFaYUMwRGJkRnl6aUVHT2lwWVVJWGJ0c1pD?=
 =?utf-8?B?ZFpQRmhxQjh6RnNkdHN0QUQ0RFRubytCQzZDQ2U5bHR2QTMwc2IxN2hNWEZD?=
 =?utf-8?B?Mm1qR2Z1TzZqMi9Bd3FKTnovS0VJeTNyM3l2V29HS2l0K2JycXE5NDAvdVNo?=
 =?utf-8?B?aTV0L3RiZ3hDMU5rWGUyLzIxQ0Z0cGU3TTVXOHdEekFIUmNTbnJ4MDRWRVoz?=
 =?utf-8?B?Z25oakFDeHZhM01YR0haRVR4VzV0bXBnL0lLeDFpbkU4ZEFnQnFlYUdSMEZi?=
 =?utf-8?B?cmJPbDdsOXFuMFI2Q2Urb0p2K3dkVjNBQzFPejBmWFlvWDVvSHhnOXdGZnlR?=
 =?utf-8?B?NllRdmdzWTNzbVVrR2NDVy9kamZZSWp3WWF6R3NZYlhKVnA3aFl6UVNrZE9Z?=
 =?utf-8?B?V3g3QXZPcGZCZi9KZzY3d2F2RjAxZ3l0K1czRng4a1NBL1NLSStablhBR2ZV?=
 =?utf-8?B?RE9DMkpidGZKZkNFdGtDMm0vZW1LZU9GbGhBeVNFd2dYTFFIM2tQYWY0MzRu?=
 =?utf-8?B?SDVhem40bmJyQ1M2cWFjb20zd05IS2FxT3E2dHplWWltSzJZOG02dkVTSm9F?=
 =?utf-8?B?WkFiejN4MFFVS0QyS3hKclp6WW1Td25OTUFHTDBrVWZPajJvdlFuOGU4SlMv?=
 =?utf-8?B?b0NYTnVTcm1rTnBmSWhBeFc0S3dvWEpVb1VKaUhJbUkrUXJYaXJCd25Da0g3?=
 =?utf-8?B?RDJhaW1aVS9UYWoyUXFOUzRRaUJ0NHZTVWRHaytCNjNTYlV4c3plTDhVeEhL?=
 =?utf-8?Q?P+xfIp/Use0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:JH0PR03MB7468.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?V284WXhiY2RLNzJla0VJTXpLcnV3aXJRWmg1bXBIY3NPRm5FbUdLM3pkUC9t?=
 =?utf-8?B?YVBVbTNObWFqdWJhcnRPVmVkR3dPa2Q1eUtRZTRNc0RtdkplWDhtZnB1V1ov?=
 =?utf-8?B?N2sxeVFDQ2NUcEUvcWVKbVdoZUFINTVXL2phdTYvV1YrMUhRRnh3bTBsOWNY?=
 =?utf-8?B?dmhhZzIrQmVHM3l1ZTlUcGErTUcvL0hjMkQvZFlIYnhuSmx4SFMvRG5iam1X?=
 =?utf-8?B?RERKeXBPU1ZySTNXVWNCQmQ5SkZzQlZoUEdtSHBMMmdxQURLdWlnSG5NaFJj?=
 =?utf-8?B?c0VBUlFEVFpueU5pMGo1cjFLVHVXamI4SzFVak1oNFc4dDlRcmJ1YXhxck5Z?=
 =?utf-8?B?ekpYck16eWZPMldHNXJ2LzREYXc5Z0ljV1pPUTVhOW9YSzRKMWFlTnlEalJ4?=
 =?utf-8?B?aktFZTZRMk5NOEVpTkdjc2xBY1N4ekdHR2JOL1BiQkQzSnJGWG5BU1RUbGdl?=
 =?utf-8?B?cFIraFNGSkhTK0JHa0dhclR3MHlyQmhubGprUzNnY2hXREdyQW1UQlA5bFhX?=
 =?utf-8?B?aUpzUzE3Q2hVemZoMStMK0FxMmw3NWNKQnBGekcvbUgyeFV3TUZSOSs3d2Vv?=
 =?utf-8?B?aFU1RlBaL0M3Szc0RlpDd1cwTnEyUmxrdTZCTVNaalp2MlhDRnNJay9sOThS?=
 =?utf-8?B?bEQ5YzVsQ2FaUCt6YTkwTHNJSlJ5cU9LNzJtZ1JCWDdmMWRsOC82Zis1MmV6?=
 =?utf-8?B?S1dCbHZLamlscDZ2Q1hEUHZHZ1Axb2N3MEVZU0ZUVGtaU2ZDS2pFcGNVOWpY?=
 =?utf-8?B?L1NaZWZ3VUJaZjFxbUhRR09sRzl1dW1VN01INUJGK0Uwb3RGa2tpOWJaN0Ix?=
 =?utf-8?B?UFBEVnA0RGp1VFpFbVFUUmlkelp0ZndoUDJTbzZ3R2NSTlFvY0lKOVhQdm1H?=
 =?utf-8?B?Ump3SE9SaWo4VFBaZDJ4N3dFNWh1cGZTU241Z2F0czFpeWxZNTZyNmFqYzkx?=
 =?utf-8?B?Y1VCcWlON0dEUldsalVibmNJK3dmQUtNQjdoaUM3elI2ZnJlQXBrSzJlWENR?=
 =?utf-8?B?TnpQK3B6Vk9OMXkxU3VZY09LR0VUa0EydmRJRmt0WElqelNmWVRLbURPbUM0?=
 =?utf-8?B?L1l3T2ZzUzdUMmhXdDFoNnVXcEV3OFY1cmYwcjR5SjR1L2k1VGdFU3ZWRnlB?=
 =?utf-8?B?U05GNitvRW4vbFc0c1E0MlNrSmVFejFOWFhEd1ZzM3Q0V1dBeForZWVvUTZX?=
 =?utf-8?B?dFkxc2p2K0ZvMjJ5WElBS3lsYTM1VlptekNzV3BSLzBsUHp0R2g2dUFPWTVo?=
 =?utf-8?B?R2V4MVA0UWNxTEwraTdUczdRd2hFeVNpeHoxN1pzc3lDUFRYK2Y3bEoyaDdG?=
 =?utf-8?B?cmVNUmFFRSszVUt2N0xOcDNtMEZBNjR5VmhwRHIrNDVEMTB2bi9SR2E4a0wy?=
 =?utf-8?B?WEpyRFB0STJ1ZER6djFxOHJEdzI2N0d0WHgva3pPeTdtK2p0c3FteEtLdGw0?=
 =?utf-8?B?cWxGRGxhblNXaHJtbjNqMkRVZWF6alNpRGJuYXMzL3pjbmhXTUNMTExOZWFk?=
 =?utf-8?B?K1AxZ040Q0dCd0dSS3QvdGc2QWc2WWY2VzFYa2NJaERhOTZXYk5TRUt0Qm94?=
 =?utf-8?B?ZG1PTWI5SVg5TW84WTIwT2M4SFcxSVk2Z2p3NDBpQTM5WlpudGpDaFVOTm1u?=
 =?utf-8?B?d1lXQWYwWVlpVHFLa3h3NHpLM0pDNHZoSm5YbE9ZNUdkNStLcXovOFNlOUR2?=
 =?utf-8?B?d2dDaGtIb2xCU3pnSWhLYjcyK1d1NDZqMHB0aTNCS2hIKzdFOUhGY0RYS2hQ?=
 =?utf-8?B?SUM2TkNEa3BwTmZzMFJsTXRtMms2K05xVWU5NTBEUnBwTGhZTnBpNGlkazVK?=
 =?utf-8?B?Y3pYMnY5dmdib09lNmF2M0JNZWxZWGQ1LzdkS0pJTythQnNubVlxa29NdGJ3?=
 =?utf-8?B?RzdNemZWYjFvbVI3MDF4QkVUUVRmVlc3TzM0TGJ0K29GeDRTM3pMNmg1dHlS?=
 =?utf-8?B?VXJjSzRhMWJJaW1KZEpweitaQmt4Z3p4SXlUMWF0UlNibUxvOWRyajdyWFBm?=
 =?utf-8?B?ZGU1bHV1ZlU2bEMxK3VpMy92bHp4NVduQXRGM2ZYdWtxTXRqSjhKTlBHemJ6?=
 =?utf-8?B?Mlp0MFZHTFFJZG1rNXM1TlNZTTduME8vN2ltMjdxdkh5VDhMd2VqTGhTTi9I?=
 =?utf-8?Q?iWseGrtMCXVAGxXMQgeIorXJ1?=
X-OriginatorOrg: amlogic.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ff496fe0-da50-4648-9f98-08ddba12b6c2
X-MS-Exchange-CrossTenant-AuthSource: JH0PR03MB7468.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2025 09:19:29.6431
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0df2add9-25ca-4b3a-acb4-c99ddf0b1114
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NjSqczcTcb0/BP5LadTXyqJ+Pzk1lazOtAi6KhSKjsrTdYBd95f9eVnoevPYen2YQCEFJwujsoqrWKSPpqz3jw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR03MB7701

Hi luiz,

> [ EXTERNAL EMAIL ]
>
> Hi,
>
> On Tue, Jul 1, 2025 at 9:18 PM Yang Li via B4 Relay
> <devnull+yang.li.amlogic.com@kernel.org> wrote:
>> From: Yang Li <yang.li@amlogic.com>
>>
>> Ignore the big sync connections, we are looking for the PA
>> sync connection that was created as a result of the PA sync
>> established event.
> Were you seeing an issue with this, if you do please describe it and
> add the traces, debug logs, etc.

connect list:

[   61.826679][2 T1974  d.] list conn: conn 00000000a6e8ac83 handle 
0x0f01 state 1, flags 0x40000220

pa_sync_conn.flags = HCI_CONN_PA_SYNC

[   61.827155][2 T1974  d.] list conn: conn 0000000073b03cb6 handle 
0x0100 state 1, flags 0x48000220
[   61.828254][2 T1974  d.] list conn: conn 00000000a7e091c9 handle 
0x0101 state 1, flags 0x48000220

big_sync_conn.flags = HCI_CONN_PA_SYNC | HCI_CONN_BIG_SYNC


If the PA sync connection is deleted, then when hci_le_big_sync_lost_evt 
is executed, hci_conn_hash_lookup_pa_sync_handle should return NULL, 
However, it currently returns the BIS1 connection instead, because bis 
conn also has HCI_CONN_PA_SYNC set.

Therefore, I added an HCI_CONN_BIG_SYNC check in 
hci_conn_hash_lookup_pa_sync_handle to filter out BIS connections.

>
>> Signed-off-by: Yang Li <yang.li@amlogic.com>
>> ---
>>   include/net/bluetooth/hci_core.h | 7 +++++++
>>   1 file changed, 7 insertions(+)
>>
>> diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
>> index 3ce1fb6f5822..646b0c5fd7a5 100644
>> --- a/include/net/bluetooth/hci_core.h
>> +++ b/include/net/bluetooth/hci_core.h
>> @@ -1400,6 +1400,13 @@ hci_conn_hash_lookup_pa_sync_handle(struct hci_dev *hdev, __u16 sync_handle)
>>                  if (c->type != BIS_LINK)
>>                          continue;
>>
>> +               /* Ignore the big sync connections, we are looking
>> +                * for the PA sync connection that was created as
>> +                * a result of the PA sync established event.
>> +                */
>> +               if (test_bit(HCI_CONN_BIG_SYNC, &c->flags))
>> +                       continue;
>> +
> hci_conn_hash_lookup_pa_sync_big_handle does:
>
>          if (c->type != BIS_LINK ||
>              !test_bit(HCI_CONN_PA_SYNC, &c->flags))


Please forgive my misunderstanding.

>
>>                  /* Ignore the listen hcon, we are looking
>>                   * for the child hcon that was created as
>>                   * a result of the PA sync established event.
>>
>> ---
>> base-commit: 3bc46213b81278f3a9df0324768e152de71eb9fe
>> change-id: 20250701-pa_sync-2fc7fc9f592c
>>
>> Best regards,
>> --
>> Yang Li <yang.li@amlogic.com>
>>
>>
>
> --
> Luiz Augusto von Dentz

