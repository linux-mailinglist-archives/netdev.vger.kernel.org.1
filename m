Return-Path: <netdev+bounces-203324-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 350BAAF159C
	for <lists+netdev@lfdr.de>; Wed,  2 Jul 2025 14:27:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 675D44E1267
	for <lists+netdev@lfdr.de>; Wed,  2 Jul 2025 12:27:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B10923C51D;
	Wed,  2 Jul 2025 12:27:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amlogic.com header.i=@amlogic.com header.b="SNsEP5+o"
X-Original-To: netdev@vger.kernel.org
Received: from SEYPR02CU001.outbound.protection.outlook.com (mail-koreacentralazon11023089.outbound.protection.outlook.com [40.107.44.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1FD91DF27F;
	Wed,  2 Jul 2025 12:27:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.44.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751459267; cv=fail; b=Q+kIF7Zu/F6t/+AylynhB3sIV5Xj6Nxa1C25/Sxs90OTjt29r5wDPtSEi6pI9P5cv/hiCYOAFY7G6D6i7iY38+4yyAZ3zTRDsZ/NdHD32ZBN1F7qcw3F3y8rju+fS3RigPLx1QjM90RQyxszzb719HRrIfH4Q4986e3Q+elx4Ew=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751459267; c=relaxed/simple;
	bh=7tbRJT3Fbryq3bjehishczd63kQrLfPG3npJt/aiPKs=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=RVurc9c5BhGIrVJ3LY9LJ4jiaBLDNkuLm2awssl9M3dzGDfQWyTGpDROYu+bN8Pbj2I8gTxH07E87L39dOc+g8uA02rgB2zllJT90rJqWuUHXlWOsbxfAUVRoRO1/2DvxjwARBRn973CRGKTfqVEPIK2IfjY8PPQ0DCvx8zz0Pw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amlogic.com; spf=pass smtp.mailfrom=amlogic.com; dkim=pass (2048-bit key) header.d=amlogic.com header.i=@amlogic.com header.b=SNsEP5+o; arc=fail smtp.client-ip=40.107.44.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amlogic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amlogic.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Zeb98d/nufw5MMBHzChSt5gTtMmZBgkOqQS0JtqohYnl9pn9jVaZXTq3PlT2hJ5iw67+4n8LppI/ifNyvKkn1dJDggmWYVSDFtAVrH6RwEG+Wf7OnHHJp0n+2xyjbL+EKc1/arAUPHqV/urDjgFMlIA/3xnhos3cWfLxK5qYApOC7tsFPwOo4gStELw8f3dXpPa73KAaVkIcaxhiM2+LAOCG+dJkuMzcwPqRBHfhjva5G7rlvLj6eiR5awR80lfVyqAlN0FQNhNjDrVXpQzN514zE20PUZNGELc0To5Uk5tQjUZGS6FyA9KdoGZR1xCJgCUAmmXDaI6GXTQbbdMRIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ycPJ6ev5M/IzBO0stOEGagVqa3Pf6bhIC1WdWIQrQck=;
 b=BEE7RNp21RVfD56qmQC5wM9RTvE6iOiFdyNKqA1Lslb6iIv9aZgDYDEtGzOVIsSgL/n1nSMVYWrvJzPzIsi3NL8VfFhsUCyzegvCZ1HKSE/1D/REemotlTXDvcne/LFHXD1RlnvtCp38R+odxib0UOjGURxyqftnNKX/h/83aGrR05dDScAaf37xGKpBKb/TkGcH2B4Ft2u5nFqBrOHw3be6JapAquhsJ5jBjenLzaJ6i6TTvggO2LGylNwQR/Zh4Gxld0wbZiAV9A/W9HVY0obg4mh/3gGU2bui/gcdOkRu/InFv3jQ8LwEukCbk43lx5D9sHIqIqxVL7eCVPuwhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amlogic.com; dmarc=pass action=none header.from=amlogic.com;
 dkim=pass header.d=amlogic.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amlogic.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ycPJ6ev5M/IzBO0stOEGagVqa3Pf6bhIC1WdWIQrQck=;
 b=SNsEP5+onpKSmEU4Ns5xGKqGco4vP1RHBGoetJzMBPl35/m3POxiXABMKFNoLGBKQ+ifhwRSjzXY5O6eXAnSIMREZrbhq5yCQHgcZb2AuUpB6SUavS65RXNCWFUMP9xkY+80FfDdwsxwg8/zoed3x4vNJYOUfPEsdVxsMHrUFaFmjcm1q+cpwkI9+4oPRqH64BmBFnnJnCYM1QCD1gycLRsR7WeS4R4cZoPhFZe1bQ8dv7V2hqePxkJpbOar6C4h2Xjsb2+0Uq+zDIGpyB4j44QBycoHxJQZ+CnIqVF9FjiSTpH6Q7QIdKdnHhVOggFIe6aJQIhnf8nubewiM/qCmQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amlogic.com;
Received: from JH0PR03MB7468.apcprd03.prod.outlook.com (2603:1096:990:16::12)
 by KL1PR03MB8353.apcprd03.prod.outlook.com (2603:1096:820:10b::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.30; Wed, 2 Jul
 2025 12:27:38 +0000
Received: from JH0PR03MB7468.apcprd03.prod.outlook.com
 ([fe80::4128:9446:1a0f:11fd]) by JH0PR03MB7468.apcprd03.prod.outlook.com
 ([fe80::4128:9446:1a0f:11fd%7]) with mapi id 15.20.8880.021; Wed, 2 Jul 2025
 12:27:38 +0000
Message-ID: <dd4b4ddc-649b-4ac6-9bb3-6f88c84df467@amlogic.com>
Date: Wed, 2 Jul 2025 20:27:13 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] Bluetooth: ISO: Support SOCK_RCVTSTAMP via CMSG for
 ISO sockets
To: Paul Menzel <pmenzel@molgen.mpg.de>
Cc: Marcel Holtmann <marcel@holtmann.org>,
 Johan Hedberg <johan.hedberg@gmail.com>,
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, linux-bluetooth@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250702-iso_ts-v2-1-723d199c8068@amlogic.com>
 <2684a01d-58e4-437d-a031-08054ec00455@molgen.mpg.de>
Content-Language: en-US
From: Yang Li <yang.li@amlogic.com>
In-Reply-To: <2684a01d-58e4-437d-a031-08054ec00455@molgen.mpg.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2PR04CA0013.apcprd04.prod.outlook.com
 (2603:1096:4:197::6) To JH0PR03MB7468.apcprd03.prod.outlook.com
 (2603:1096:990:16::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: JH0PR03MB7468:EE_|KL1PR03MB8353:EE_
X-MS-Office365-Filtering-Correlation-Id: b5e37dfe-85d4-4b5c-a1ed-08ddb963d4e4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cmdmb0F4bVdScFZqajFZbkErcnR1cUhGd2h0MTFWTk5lOHdkTmRmYzBVbmNr?=
 =?utf-8?B?bUZsZk9RVzZSejQ2cXFoeHhZNDRUVGpLL3Y4UGhqS1h2aGVMZ1hiWGF1ekVS?=
 =?utf-8?B?VUVOcnFWY2psQ0g0WGhieXJkZGFnNldBbVZ4VkdnUmRrL0trTnV0V2wrd0lQ?=
 =?utf-8?B?REtuOGRDMmsrQU9MZ2JOcnRPbXhRbUY0VVRldWhpY0VSb0FFNWExdkF4S3ZX?=
 =?utf-8?B?N0FOQmtYT3R3OStuUGVRRWh2Uk1rSVdQYi9qQ0Y0M3lFOHYrS0VQSEoyK3BV?=
 =?utf-8?B?Q1BqaWs0dC8rRVh0MmFhUVhLSjhqTTJYd1ZLUUZ4RXhKN05ZWWcrT2IwR1gr?=
 =?utf-8?B?OVVqRGgyQ1hiQ0J1Skk0Qk1rVnFQdGtyZnpwdWtHbUFuVDk3NXBmeXdhNENQ?=
 =?utf-8?B?UnJVNGdXNVZCc1Y0QkVydktHVEdwclhGbHVDVkYxTEhhOWNPUVZldjZWQzU0?=
 =?utf-8?B?SDVWYlJUNkNSZXIwQXVCM2JJZDNHQVZrL2xJMldwYU03Q2t1VDJaMzdVQmxv?=
 =?utf-8?B?cjcwVldsZ2JKQ3J3OEkvZGZRK1A0RFVneU9ueTdERVF5SlVYNmFnNGU4ZnhB?=
 =?utf-8?B?WENoZlRqUmtMUTIydlhaSENaMXN2TDZYN2JTNnF6YWYyeEtWVUJMT2VuQXVY?=
 =?utf-8?B?YzZSZU93c0VEUWErWVo3UzhONjdlRDhHL2lha0MwejNFeFBPaVRpWlVNenJx?=
 =?utf-8?B?U3l1cnR6Rzd6TzRmV1dwNDJSNmFhNTZLTmJxUnBvM0NjUGozUWJoOXRCMk5L?=
 =?utf-8?B?NFJrU0ZHcyt0elRBdUs5d0xGU3JvOTBLM1I0V0MzbWgvcG5Temc4UTVrRlFM?=
 =?utf-8?B?TlpHaHh6Tjk5R3VySDBVbFFxUHBBSVhEZjE3Ny84VW8xeXFLbU11NFFzbnFo?=
 =?utf-8?B?ZThRWWc1ZUs5ODMwRjZSWk9iK2NFQ0JHWmI2K0t5TklpUlZRcjlyMGp2WEFH?=
 =?utf-8?B?RWVJRlNHL245N1NyRXl4OTJoaXBBTFMzMEM3aCtudndwZitUcHBXY2VTOTQ3?=
 =?utf-8?B?ajNWQ1Y0MmxxN2VKZGNRek1rVXRaKzR3NGV0a0FJQzRkQWtKUTZSYmRGUlo1?=
 =?utf-8?B?T05LKzJaRXpBTkVSR2VtVDdiandGTzZmZDNlNzBFSUlvd3QxdzZ6V2FPcmtK?=
 =?utf-8?B?a1BZSUFrbk5IeFRwTzcvKzl0NHhiSVF0eHhpcVh6NWlHOXY2bGVtNlFITS9n?=
 =?utf-8?B?bVBnK2dzL1g1RDhDZWNOMTZGSklwUmtxODhEYzNyR1pGc0NIbEtnWGw5TVQv?=
 =?utf-8?B?L0QxN01meWpyQUJXKzlrK05KaTVmS0VXTysrQVRYLzlUT2tWaVlscVZPdzJU?=
 =?utf-8?B?OXFhYjIzazBrMFgydHBUTStjUmhkcnZYTzM5eGtLVnBtUVFJUFRaRWtSWVZS?=
 =?utf-8?B?SFQxUmlhdmI2dXdoMjR3WXVzOWRHTlpINXZaT1QvSjB4R3M0UFkzNjRmQndJ?=
 =?utf-8?B?ODd1U1Z3a1B3cVVYclFEZDJ0aUpCdTc5Vnl5dHJnVzVIcVRidGJnLzlSbnF0?=
 =?utf-8?B?NFk3a1dDSnhreVRrangvSFdCVlZuOTVZTlJpYTBvdW1PRjN2TGhxQ2ZoVlJW?=
 =?utf-8?B?WXdUbm9uRmJTZ1k5eFlkUDFuZGFWN0hvVnZoRmxQSHREYk1yVzh2aktHaVFO?=
 =?utf-8?B?enE5QTdTU0hIRXkvTVhRTkhFRENFT1JxMzYvV0VnOUpZa3VCbjljUS8yTWFp?=
 =?utf-8?B?cmhiRnVaSkFKZ2FSd0NUR2VkMFpOMXREakdhcTB0bzREbnEvNkVWUjd6eHpS?=
 =?utf-8?B?MjBZOExnNHVaZkxxalhGN09ORVdIbTF5UElkZkRjUHdaZXM1NGNuemdEOGkr?=
 =?utf-8?B?UTRkTHZ0K1loUW42OXdYanZHWTFKejFaWUVDQ3lzK01NUGx6Zm84WndlUmg3?=
 =?utf-8?B?SkNxTm5jM2ZLeG1SUmFsZWRoRDRJc3Ewd1QxelRjS1JRY2tNOTFrcityTzMr?=
 =?utf-8?Q?iiaLkMwm+iA=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:JH0PR03MB7468.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Z1pvTXNmMTNRdU90bWNaMnZNM1h2b1pCdkJDd3dGZDIraEhSdWRMbjRvZXhV?=
 =?utf-8?B?cmtSRXlEUEhiamRMK1BLa0czQzdxZ1RFcHVDdFdBYVpoOU5lVG9JZER0bVNh?=
 =?utf-8?B?eHM5QUsvS3RZOExrR05sdmU2V3kvYi81SVloOHRJb1dlTUhCSFRCcjY0bUJ5?=
 =?utf-8?B?bm9mbUMwNWRQT3hHYXBKVkFuREFpMDFkbFVBeG1WVWorSmR3Y0dTOWduQUNr?=
 =?utf-8?B?dktqSTUrdkVEWWNLSFdqdjlDYzE4ejJyRWFLUjNXdEViT1o2djRPTURFL1A5?=
 =?utf-8?B?RktUVk5BY3RubU9CUlJ4TjVsTUJtRkxDcnhzOFVQREM2WE42N1VDSUQ1ZDZm?=
 =?utf-8?B?SWFERkk0TnE0dHhPME5GZFJlK0YzRTZscVdnNTNxNDg2K0RWelRkYzNQYzR1?=
 =?utf-8?B?TUlOWXJ4eTNWaHNySG43RWFzU3UyZ0p6SmlZdTdkQ0hTVU8wS1V4ZEh2eE9n?=
 =?utf-8?B?TW5XZjRxUVAwdGtndmdkYXBoR2ZQV1Z3TXhoZUoyUG10UWxVZ0JOR1NQbnVr?=
 =?utf-8?B?OS9OelZST0dIUDhOOC9STnVCaHZKeFdhS0ZRcktKbHY5YUordHIwS1VvTzMv?=
 =?utf-8?B?aTdzNWlURitCYnUwaUNKT1RhYVVKMkJPVDcrS2RlMm02NDdpciswQk1ZMmFT?=
 =?utf-8?B?cTBVQmc2T09iNFVqOVpvaWNKZDZxTTRKMlRQRC9YazAvMmdteC95ZStPREwv?=
 =?utf-8?B?ZVNOdThFaE8wbGp4U0EyV01pam5XN2hqWG1CMDkxN1F0QVA2SE83dmxKVVI0?=
 =?utf-8?B?cmFLUlh3NlNDdVYyQUxoZHpIKzBjbXdlWm96QVExaFprbTlqOFFhWUxnM01S?=
 =?utf-8?B?dXVRVlh2d0pqV2ZyZVBZK2Z2M0xWVUlQN2svSVg3Z1diWkVaWCt3a2pWSjRU?=
 =?utf-8?B?Rkg0VG1KSnlEcFVwaUdMYkFEc1g3Y0ZOU1d6UHNrWmVwZWlDcDF1VUJJOTlB?=
 =?utf-8?B?cHg5d200MUNlUElMMHgzMEJCQnlyNFM2cmdjbmMxTTdFMmxRd1l0K2dvSjk3?=
 =?utf-8?B?SEF0OEROTkxlK0NUOFFpWVVER0w3TkVQeUtCQlA3VTNuTGZVYVZSRXR3SEdj?=
 =?utf-8?B?elB0ZWhPd2Z3b0dlK01rbW9uWWpGdExUZ0pEWS9RYnYydFRBbGxQSXh4bmxw?=
 =?utf-8?B?YW1VWHI4K0h6cWdoVmp1TFJSKzFuOGFhNG1oQTgvd3RCRzd3YWdUbi9veklz?=
 =?utf-8?B?YVpOaXF6bTVUTFhXd212aTBmRllzajBMTHBPMlRQd0hFUWdmSlBRK2FKUnM0?=
 =?utf-8?B?aG1QMFJaL0djM1lFdjIwenFXRTcxOXdmMjFWRzE5clBlL09pYmFDM2IyN29V?=
 =?utf-8?B?Z3dKVTVKQkxKNkVldE1rcFFIS25XajU4SGhudno0aGFSblRYRzIya3l2R2xZ?=
 =?utf-8?B?RU9pQy9kOHpFODF0MWJQN1B2dVp3VTNGMkV0a1BwVzZFa3lKLzhzRDlPc1l3?=
 =?utf-8?B?WjI2ZXNrbFMxRmNweDJKVm9ZS0MrNGFiQ0FnWUFuMTZOL1ViVkZ3T3ZoUEFz?=
 =?utf-8?B?T2Q4QWZNcWhqRExSV3pJZTc2YmNlTEo2RWVnTGxNdjVQMlRQdlpsTUN4aVc5?=
 =?utf-8?B?bHNlaGFRZXF6UXc0WUVFa0pHYTl4OGF3c244NkZXSkVXd1BiWUF1MTgyYllV?=
 =?utf-8?B?ZjBIdFZkWHpBY0JGdjNvZFFkUThxMHhkWmRuUWNrWk10Vk5taW9lS2dQaHFw?=
 =?utf-8?B?Q1kxMWdsSzY5UlRwdXJkRUZIVlFwMmoxOGlVOXVUOXJWTzdFNkhKWUtWR3pn?=
 =?utf-8?B?VFhFOXVYaEpMbHFqdGhDdzZORkxid0lnVm1tYjUvTnF2b1NhNEVNa0VNVDF4?=
 =?utf-8?B?UkZVRDM4SHg5TzJHRXBDYXZncFVIR3NYYlNhUnN2dFN6eW5mc1FmRURRTkx5?=
 =?utf-8?B?Ym8rczJqdUN0RDBtSzN5NzBVeGM1bktKSURRT2FlMzJhOUsrV3JMb2ZWa2l5?=
 =?utf-8?B?NGF6dUx6ZjRYOWNpWG9IM0hwVUlyYzVNWmRSTnVjemVrQTh0YXhaYjd4MlZy?=
 =?utf-8?B?K1pTZVJEWmlIdXRmb3MwVlhWQjRXODlPYnNvQlMxeEpFMDVLMzMrSElGT3E5?=
 =?utf-8?B?enNnY0ZncVJWNmtRUTRuV2JCa3QxbnRIdEFpWWtXajN4WnhlaDhneUpxaWVp?=
 =?utf-8?Q?5q+ue5V8cBYsIBcOOAH7U7CBg?=
X-OriginatorOrg: amlogic.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b5e37dfe-85d4-4b5c-a1ed-08ddb963d4e4
X-MS-Exchange-CrossTenant-AuthSource: JH0PR03MB7468.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2025 12:27:38.3473
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0df2add9-25ca-4b3a-acb4-c99ddf0b1114
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: piZLof8q6tdkApPBVYVd5Ld61Z59BB+fOhuOJ2tHjzCuakf+DHQFq2QJVN2/VpJrSt7rx3b1vvxDURGyDrDzlg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR03MB8353

Hi Paul,
> [ EXTERNAL EMAIL ]
>
> Dear Li,
>
>
> Thank you for your patch.
>
>
> Am 02.07.25 um 13:35 schrieb Yang Li via B4 Relay:
>> From: Yang Li <yang.li@amlogic.com>
>>
>> User-space applications (e.g., PipeWire) depend on
>> ISO-formatted timestamps for precise audio sync.
>
> Does PipeWire log anything? It’d be great if you could add how to
> reproduce the issue including the PipeWire version.


Pipewire version: 1.2.7

I have modified the patch as follows:

diff --git a/spa/plugins/bluez5/media-source.c 
b/spa/plugins/bluez5/media-source.c
index 488cf49..2fe08b8 100644
--- a/spa/plugins/bluez5/media-source.c
+++ b/spa/plugins/bluez5/media-source.c
@@ -404,9 +404,22 @@ static int32_t read_data(struct impl *this) {
      const ssize_t b_size = sizeof(this->buffer_read);
      int32_t size_read = 0;

+    struct msghdr msg = {0};
+    struct iovec iov;
+    char control[128];
+    struct timespec *ts = NULL;
+
+    iov.iov_base = this->buffer_read;
+    iov.iov_len = b_size;
+
+    msg.msg_iov = &iov;
+    msg.msg_iovlen = 1;
+    msg.msg_control = control;
+    msg.msg_controllen = sizeof(control);
+
  again:
-    /* read data from socket */
-    size_read = recv(this->fd, this->buffer_read, b_size, MSG_DONTWAIT);
+    /* read data from socket, with timestamp */
+    size_read = recvmsg(this->fd, &msg, MSG_DONTWAIT);

      if (size_read == 0)
          return 0;
@@ -417,13 +430,26 @@ again:

          /* return socket has no data */
          if (errno == EAGAIN || errno == EWOULDBLOCK)
-            return 0;
+            return 0;

          /* go to 'stop' if socket has an error */
          spa_log_error(this->log, "read error: %s", strerror(errno));
          return -errno;
      }

+    struct cmsghdr *cmsg;
+    for (cmsg = CMSG_FIRSTHDR(&msg); cmsg != NULL; cmsg = 
CMSG_NXTHDR(&msg, cmsg)) {
+#ifdef SO_TIMESTAMPNS
+        /* Check for timestamp */
+        if (cmsg->cmsg_level == SOL_SOCKET && cmsg->cmsg_type == 
SO_TIMESTAMPNS) {
+            ts = (struct timespec *)CMSG_DATA(cmsg);
+            spa_log_trace(this->log, "%p: received timestamp %ld.%09ld",
+                    this, (long)ts->tv_sec, (long)ts->tv_nsec);
+            break;
+        }
+#endif
+    }
+
      return size_read;
  }

@@ -700,6 +726,12 @@ static int transport_start(struct impl *this)
      if (setsockopt(this->fd, SOL_SOCKET, SO_PRIORITY, &val, 
sizeof(val)) < 0)
          spa_log_warn(this->log, "SO_PRIORITY failed: %m");

+    val = 1;
+    if (setsockopt(this->fd, SOL_SOCKET, SO_TIMESTAMPNS, &val, 
sizeof(val)) < 0) {
+        spa_log_warn(this->log, "SO_TIMESTAMPNS failed: %m");
+        /* don't fail if timestamping is not supported */
+    }
+
      reset_buffers(port);

      spa_bt_decode_buffer_clear(&port->buffer);


Pipewire log as below:

03:40:00.850312 spa.bluez5.source. 
../spa/plugins/bluez5/media-source.c:450:read_data: received timestamp: 
0.017361972
03:40:00.850571 spa.bluez5.source. 
../spa/plugins/bluez5/media-source.c:450:read_data: received timestamp: 
0.017361972
03:40:00.860241 spa.bluez5.source. 
../spa/plugins/bluez5/media-source.c:450:read_data: received timestamp: 
0.017371972
03:40:00.860430 spa.bluez5.source. 
../spa/plugins/bluez5/media-source.c:450:read_data: received timestamp: 
0.017371972
03:40:00.870166 spa.bluez5.source. 
../spa/plugins/bluez5/media-source.c:450:read_data: received timestamp: 
0.017381972
03:40:00.870343 spa.bluez5.source. 
../spa/plugins/bluez5/media-source.c:450:read_data: received timestamp: 
0.017381972
03:40:00.880197 spa.bluez5.source. 
../spa/plugins/bluez5/media-source.c:450:read_data: received timestamp: 
0.017391972
03:40:00.880370 spa.bluez5.source. 
../spa/plugins/bluez5/media-source.c:450:read_data: received timestamp: 
0.017391972
03:40:00.890405 spa.bluez5.source. 
../spa/plugins/bluez5/media-source.c:450:read_data: received timestamp: 
0.017401972
03:40:00.890642 spa.bluez5.source. 
../spa/plugins/bluez5/media-source.c:450:read_data: received timestamp: 
0.017401972
03:40:00.900201 spa.bluez5.source. 
../spa/plugins/bluez5/media-source.c:450:read_data: received timestamp: 
0.017411972
03:40:00.900652 spa.bluez5.source. 
../spa/plugins/bluez5/media-source.c:450:read_data: received timestamp: 
0.017411972
03:40:00.910391 spa.bluez5.source. 
../spa/plugins/bluez5/media-source.c:450:read_data: received timestamp: 
0.017421972
03:40:00.910694 spa.bluez5.source. 
../spa/plugins/bluez5/media-source.c:450:read_data: received timestamp: 
0.017421972
03:40:00.920198 spa.bluez5.source. 
../spa/plugins/bluez5/media-source.c:450:read_data: received timestamp: 
0.017431972
03:40:00.920352 spa.bluez5.source. 
../spa/plugins/bluez5/media-source.c:450:read_data: received timestamp: 
0.017431972
03:40:00.930438 spa.bluez5.source. 
../spa/plugins/bluez5/media-source.c:450:read_data: received timestamp: 
0.017441972
03:40:00.930699 spa.bluez5.source. 
../spa/plugins/bluez5/media-source.c:450:read_data: received timestamp: 
0.017441972
03:40:00.940171 spa.bluez5.source. 
../spa/plugins/bluez5/media-source.c:450:read_data: received timestamp: 
0.017451972
03:40:00.940331 spa.bluez5.source. 
../spa/plugins/bluez5/media-source.c:450:read_data: received timestamp: 
0.017451972
03:40:00.950427 spa.bluez5.source. 
../spa/plugins/bluez5/media-source.c:450:read_data: received timestamp: 
0.017461972
03:40:00.950678 spa.bluez5.source. 
../spa/plugins/bluez5/media-source.c:450:read_data: received timestamp: 
0.017461972
03:40:00.960447 spa.bluez5.source. 
../spa/plugins/bluez5/media-source.c:450:read_data: received timestamp: 
0.017471972
03:40:00.960703 spa.bluez5.source. 
../spa/plugins/bluez5/media-source.c:450:read_data: received timestamp: 
0.017471972
03:40:00.970154 spa.bluez5.source. 
../spa/plugins/bluez5/media-source.c:450:read_data: received timestamp: 
0.017481972
03:40:00.970308 spa.bluez5.source. 
../spa/plugins/bluez5/media-source.c:450:read_data: received timestamp: 
0.017481972
03:40:00.980443 spa.bluez5.source. 
../spa/plugins/bluez5/media-source.c:450:read_data: received timestamp: 
0.017491972
03:40:00.980667 spa.bluez5.source. 
../spa/plugins/bluez5/media-source.c:450:read_data: received timestamp: 
0.017491972
03:40:00.990455 spa.bluez5.source. 
../spa/plugins/bluez5/media-source.c:450:read_data: received timestamp: 
0.017501972
03:40:00.990706 spa.bluez5.source. 
../spa/plugins/bluez5/media-source.c:450:read_data: received timestamp: 
0.017501972

>
>> Signed-off-by: Yang Li <yang.li@amlogic.com>
>> ---
>> Changes in v2:
>> - Support SOCK_RCVTSTAMPNS via CMSG for ISO sockets
>> - Link to v1: 
>> https://lore.kernel.org/r/20250429-iso_ts-v1-1-e586f30de6cb@amlogic.com
>> ---
>>   net/bluetooth/iso.c | 3 +++
>>   1 file changed, 3 insertions(+)
>>
>> diff --git a/net/bluetooth/iso.c b/net/bluetooth/iso.c
>> index fc22782cbeeb..6927c593a1d6 100644
>> --- a/net/bluetooth/iso.c
>> +++ b/net/bluetooth/iso.c
>> @@ -2308,6 +2308,9 @@ void iso_recv(struct hci_conn *hcon, struct 
>> sk_buff *skb, u16 flags)
>>                               goto drop;
>>                       }
>>
>> +                     /* Record the timestamp to skb*/
>> +                     skb->skb_mstamp_ns = le32_to_cpu(hdr->ts);
>> +
>>                       len = __le16_to_cpu(hdr->slen);
>>               } else {
>>                       struct hci_iso_data_hdr *hdr;
>
> Kind regards,
>
> Paul

