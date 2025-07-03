Return-Path: <netdev+bounces-203708-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 47121AF6CE9
	for <lists+netdev@lfdr.de>; Thu,  3 Jul 2025 10:30:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 445F91C2552B
	for <lists+netdev@lfdr.de>; Thu,  3 Jul 2025 08:31:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8AEF2C3274;
	Thu,  3 Jul 2025 08:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amlogic.com header.i=@amlogic.com header.b="rfTpL9Z1"
X-Original-To: netdev@vger.kernel.org
Received: from TYPPR03CU001.outbound.protection.outlook.com (mail-japaneastazon11022126.outbound.protection.outlook.com [52.101.126.126])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA9252882B2;
	Thu,  3 Jul 2025 08:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.126.126
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751531435; cv=fail; b=eX40j3W2D/gew56+oZtO/1z1ZU9MaOEhUEyr3F13HGnB3g+IXZp5KvLbJNoytTGLtzlCuQCuRJ2UjIf+xYl6aq7JcV5hKa5ygBnJS/4GbGEDLyS8ufIJHURWeB91WmvdcxJYF+yw8k8MI4fSLqi2+wSHyeWl0J7qPhLg9Yo/8Lk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751531435; c=relaxed/simple;
	bh=yZ7JBnMgonTSoj9se7iKFUcgsTEEMfpmX+J7KylPZoM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=I2AWf0LoUQ98PKtF3XXQpB5StLoaM0QyBmKXM3vjRjEDtsJ4DbbsC2tA9Mu1grYsYvYhMg5b7DMqgklSbheKg5COCGJxCetHwqnzNiLDwi0N2K3lzma9+VtUIqr0YR8kqLu0pG95Sl4mDC06aUG0yciOmW2e8ehRtvmFbJegjRI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amlogic.com; spf=pass smtp.mailfrom=amlogic.com; dkim=pass (2048-bit key) header.d=amlogic.com header.i=@amlogic.com header.b=rfTpL9Z1; arc=fail smtp.client-ip=52.101.126.126
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amlogic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amlogic.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SZCuCkKxNnEbcbs42a2EpEOlCBwlq0I6Uzan8dNhtYhR86ELgdrSwbRHKqrS+33NwsrhPFiIh1Wl65HPA86kzb7RC3zCubofjoSICngpFKMOoPQCJ06YLpsrs2g4Gsl0quTA0BlF8+S5IoGBENVlGltfNWtPpm5FVE5nf4HkvE9czEMNkbLDpyOplAISyyK+Kxiq6cep0lCHrVUvuMhk6WNRNrxVXjNlemB9qxrtOqu4lojcB4unFh5mAPPw58ozK+aIMy2MmZ1EMgaAwfEIUQRY0clJSba8iAR0jmJSh7nWSB+D6acYkceNzGayDNtvySplNFGY6HBEccixva1usw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EJOfDObCIwy/6BneaPPTf/pv8gsfSyVkCZyovy0odik=;
 b=gKhJxX7wm1dCNhuXYiF5oK0Q7yDf5YD71p4KIDOmia88TOOyTl1Ow9dlXDs3FA0F6vlMYnWFJTzUq6oFkd+fvxIzIbalfWTZPukZJooKtAccyUd8yDuDMGie1x1kaWZLTtO3SS6CfJFbIbOKjEeZusOBMJyXAec7kS4ideCQoojaLWu6S/Mi3sZqofvwO7ad6YYB2KY7zNehEaPH7jySjaIZWTr6Obbxy9+FAdUuPWx9+F2V6lLphpRsh5HLsANJY/pE/GkkKVQvyxX5bL/Em4FEiYKnS10LgEBs8ybNkKOlNs+QPoma4lP4DQ4USY2ZzvLf6BiOAGdaIj1oky8HfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amlogic.com; dmarc=pass action=none header.from=amlogic.com;
 dkim=pass header.d=amlogic.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amlogic.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EJOfDObCIwy/6BneaPPTf/pv8gsfSyVkCZyovy0odik=;
 b=rfTpL9Z1CwLr2WH7kTV7gm4X3cyRhovWupGUEIDjM+ai+vLH0EfO6fuiaAne1LKt4LexL+veURZaJy6kOJcis9ZMSsfUBQuzFPdT5G/6IfYmxZJetMVJjATpLcVjW0R6YhV1bVX2PFE2WwL2xx0gS0kCMrzLnLhepNI+bEEyw8gqBGKih1T72CBHITDdh2L6hfV0lme2MecVVifJ59tCJf9Xf/OjYlD9NxAxSZhr/y7X4sOQrFzE+fcL49nMfL6txjiEjXO7Hm6K22MgOi+hgGN7mO/DV8FdSj/1WCs/OqwSUIMCvjvSjm7/73tayRPnZVbSmZrveaotoH4CSoElDw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amlogic.com;
Received: from JH0PR03MB7468.apcprd03.prod.outlook.com (2603:1096:990:16::12)
 by SEZPR03MB8230.apcprd03.prod.outlook.com (2603:1096:101:18e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.20; Thu, 3 Jul
 2025 08:30:30 +0000
Received: from JH0PR03MB7468.apcprd03.prod.outlook.com
 ([fe80::4128:9446:1a0f:11fd]) by JH0PR03MB7468.apcprd03.prod.outlook.com
 ([fe80::4128:9446:1a0f:11fd%7]) with mapi id 15.20.8880.021; Thu, 3 Jul 2025
 08:30:30 +0000
Message-ID: <73cfbf68-21e5-4a3e-aa30-a8b08e9ca1a7@amlogic.com>
Date: Thu, 3 Jul 2025 16:30:04 +0800
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
X-ClientProxiedBy: SI2PR02CA0023.apcprd02.prod.outlook.com
 (2603:1096:4:195::11) To JH0PR03MB7468.apcprd03.prod.outlook.com
 (2603:1096:990:16::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: JH0PR03MB7468:EE_|SEZPR03MB8230:EE_
X-MS-Office365-Filtering-Correlation-Id: 951e9a71-d773-4717-6d98-08ddba0bde9d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?STFWUHllQ2lIb2p4dWxCQjhsQWtjdGswL1ExaEhzaTVmaEhpUC9abkpkYTRx?=
 =?utf-8?B?NStOY1RtcllzbDFhbzYvdkgxTG43bDhQVEdzWHZHcXhmTEJBQjE2ZDRoL0Ri?=
 =?utf-8?B?aWNLNkpCZ1RnNzdLN3hyc3pXZUFHTTFQOGNZZGhBMldtUUJjbFFFQnk4SW9F?=
 =?utf-8?B?TEJ5QmdrUTRsSVI1VGptVWRGTjhtNUtKanY0U2ZXMDd2dVNSNlc4SnlPZWEx?=
 =?utf-8?B?U1kxTnlPL1JNTEIvblNtcWZWeWhOdHU1VUdRUnd0Tjd0SUZvQTFqQ3RGV3dX?=
 =?utf-8?B?Uy9mT0xRTms5UnRiTi90bXVsdVIzUVlVMzVZdngzVlFFVk9aZW1wdTEwL2I5?=
 =?utf-8?B?NGZRV0FNKzRYT3gra29Xb1I4L3cxRDQ1QUVzNk1KOGNlcFdJK0EvSGRzUG9W?=
 =?utf-8?B?enlHdUV1d0ZzVEpxMExPWDhVbUFsWmJndmVRUFZyeTNXWGNjS1R2Y25lMWhv?=
 =?utf-8?B?ZENiZ0dSOGFrV3l2Sy9teUc4c3pzeEFxK05XQnFZenNsUXBpQjZIYjhtcFla?=
 =?utf-8?B?V2hPTFpYQ0xOTkJEaGZGWFY0UlRUVHh1OHk3R2NPbEl6VW5UTllBRWFPb2xx?=
 =?utf-8?B?RTBxeldEMFEwMk10VkRNVjk4NzF4MXRwRkV4NkE1NEtNMFY1Q1VOMEdLU3o1?=
 =?utf-8?B?UElHNFZ0TnBRWGxKTG1HZm5wOXZ4aUZCMHl3eDlFK1ZHdkVibFdmYXlEV25Z?=
 =?utf-8?B?aUx5eFFGOUl4VnQ1WnZXbTlOdVVYWFJxeXliaTdjcFBLeFlYdEx6Z044UmxU?=
 =?utf-8?B?Nys2MHdRS1hpcHBackpmNXBhQ2JkUkRKNGVxMDl3alpaVGVFK1V6MTJiWWlX?=
 =?utf-8?B?ek1uc0NMdSthNXU4NXVReUVZQkxmN1Vkd1l6YnhZTEF2NSs5aGdWTVlzODBM?=
 =?utf-8?B?dTZzUlJqSTNoSENPdDVObGlGZGUrTU5pUll3a2NEdndxWjhyZUlBRVlQTkdG?=
 =?utf-8?B?YXBzWnEzM1pGTVB2YXpMOHhjOTFoSm0yNGN6Mnc3QzYvelMzdHNvc0xSa0Fk?=
 =?utf-8?B?VGxrSXREb2QxY3cvaDVTamFjNy8vN3NwSjFVcm1WOFdzaHdGZXByMUZYL1ZO?=
 =?utf-8?B?OFNuSWdaZlhrNEhPdXgrZkVEeHdqdGJEKzE0a3grN1RMOE9VcTFnZmNkL205?=
 =?utf-8?B?Wm9IVFRDaUJpTjRSZ09id28xV0d1YVZLL01lbTZTcE9GbUlMSE9zL3U5Skp5?=
 =?utf-8?B?VWhtaXI5aXJFOGxIRzlERlpSMkl0Qk01dlBaeVgwT0RRQXJlVlV2YzIwZnM5?=
 =?utf-8?B?ZUxSdjNLb2trT0hHa0lvWFVXN0dwRlA4bktUU3BPMGRLUlI3Zll6dGZoTXN6?=
 =?utf-8?B?THdVeEZIbmE0WXorc1ZNZ1ZFRm1BcUhFdTRiTmtzQkN6WlQ4ZEZWNlg1ekpZ?=
 =?utf-8?B?WE1oUXJjNFpJbkRvU01YUm9LTTBwSDA1blZXYXNzbFhJVDJkRkFydkVGVWht?=
 =?utf-8?B?b1FTb1cxWWpaMVAwb0pEUjlTaUcrQ0dUbEtEWGVDeUxHUFEwbC9tNCs0RXoz?=
 =?utf-8?B?czc2YmdmcUtPc3BjUEtyQUxhSm5aTnJmQzh5KyswV2YwSjdORG5GWmYrdFdO?=
 =?utf-8?B?VVU1VWtPaVlObUNMQWNUSEJRN3dOdk1hUTh1NWE3T1ZyV01waFpZWGlOdmsy?=
 =?utf-8?B?UjhSbzNBQWdVTytqbXRLZFN0ZldibUsvaE1KMDRtV3hOaU9tTVFaN0ZXbzVa?=
 =?utf-8?B?bW5xUHJ4ZHp0dDRBbkFQc0J4amFORFlWVU5Sd1NvVGJhTThCT2RPcTEzRThN?=
 =?utf-8?B?UkhoQ093WlRNRExUS01SNVA5a3pVeXhlNzRsWjRNNEk4RzIvQmhEd2xJQnIy?=
 =?utf-8?B?V0dFa2VTbCtTa1J3b25lQXFlaDJJRUlNSlhYOFVoL0d4MUVEUlVVWHBtSi9z?=
 =?utf-8?B?ajVxdmVHSDh6NUlpaTJTclV4bnhiWC9LdGEyTzZuc2s2dnA4M0p3eWVaV29X?=
 =?utf-8?Q?8h73au89IG0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:JH0PR03MB7468.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Sml0L3lHQTQrOE91b0JnY0xYeCtESkNld1hXZFFPbUxoelZ5enk5YkJEOWlO?=
 =?utf-8?B?dmhjOWg2d0E4Z0VEbkpYcTIrY2tBTVo5NTRubHhyRVQvWVhZa2R4UXBjUldO?=
 =?utf-8?B?L3V0M3Zjcmp1dkhHemlIN0hVMnRmWGh1T1N6Y0Y4ek9IR1hYVmw1bVJOVFY0?=
 =?utf-8?B?WWh2UDhrSmpodVdjd1pWeEZhOHQ1WE16SnBEcmE1T3NTdTNxM3pta2hQUmw2?=
 =?utf-8?B?VFlZaCtxZ0xEWHJKQVY3Wit6d25FTkEvS0ZubDFMbWZYcm05TW5WNlpaUEFE?=
 =?utf-8?B?cDZSeWFBWGFjSm5QT2djRzZkWVg1U3ZrM2xoV25nUVowd0s4eU1GSWVLYVBv?=
 =?utf-8?B?THB4eEwzd08vc2pENDRJWHJIM3BhMmVVM0ZyQ1BWRkdlUWtHL3hPeXRFRG9V?=
 =?utf-8?B?ZUdiVVVSdUNnMHBBNFJnOHh4cDBVcStuVzd1a1pCWXlVVmQxNlZCTjJyb2sr?=
 =?utf-8?B?RTJKclFmTVVjbGcxT3RyNG96OVBlclFWNGhtTXR2Y29rbERSNncxcExMZXlP?=
 =?utf-8?B?WitOcUhhQnI4bHVhTTVBT2xOMzM3RVdlUHJjV3JWN1B6bWVFMkJFNDljRmNC?=
 =?utf-8?B?c3M1T2pRb0Y3bFRQV3M1cGx2TXhZSnQwbHVFUWxjSXh2RDRjQmI4Qkx2WWFs?=
 =?utf-8?B?ZG8yZHhva3NJYWUxdlhIMFVnbzdkZEJ5UDBLY29jYmxVYkJJcjEvK1FoczJo?=
 =?utf-8?B?YkQ5S1NsKzVLZEk3L011a05mS3dLNTU1akw0UDRxaHYwOFc3RExSTnFjMFl5?=
 =?utf-8?B?N3k5Qm1jV0NBWTc5dGtBdVJ3TUJkUFhEZWJNSHp3cFkwMGl1TkhXZlk4QTB3?=
 =?utf-8?B?Nk5Wd1hnakVBYlVvR20rTjdoemlnMmJ6djY0WUpCVVpYK1crQWg4ZWF3djht?=
 =?utf-8?B?anFicGQ2aEF4S29GVVBjcm84OEIyNm1EOHdRNUYycWZLYTY3eXBWeUZjMkdI?=
 =?utf-8?B?N1V3NTNrMnBsdnZqdmVxbU9IeEQ4ZFBjRkxlSDExZzVFZnVxeTRBOURhZkxK?=
 =?utf-8?B?YXlNcnZDVjJXUHJnVWFkczdiNnAzOW95UUVVeFBIY0tJTUxuMlNzUmZCMWk1?=
 =?utf-8?B?V3EvSWFtRnkyN0xXRXNaTmk5SFZSKzBHbnRQeXl5YURSVjFWVUJPTHoxQkpo?=
 =?utf-8?B?Qm8yNG5XUWRHTjNUWXdxTzRST3hHQUppbzZ1d2syL2xKTkVOellVazZOVEVm?=
 =?utf-8?B?SnY3eUdGeUZ5UVhxSkJyVTNLZTdua0RTWFV6cDJpOHpDcmNnRWhsUE5jMkpZ?=
 =?utf-8?B?aENCVThFOGhqL0pHNTR2NW8wUzlRQy9HU1M0QlJwdjJsbXFSaXFTd0xNVHdJ?=
 =?utf-8?B?UkpTWXlFT3ZkNlYwTHhxRVBwS0JEZncwNFNzQ1Zid011eHdsNWxrTnQvUUNt?=
 =?utf-8?B?MUlSRVZYK2NNekRGOTlRV0pTdWpVMEhpeUpseEdaU3RiSGhQRVV3ZmJwY3I3?=
 =?utf-8?B?U0tjcXI0ck10K1lJMDlldzJtRFI5UENaL2hWS3M0ZE5kbHc4OXFkS29pMk4r?=
 =?utf-8?B?Y1pZMVhhZmlJcFRld1lMR2xrSXJHK2JkZTZlOUozeC9hV3JzVFpSaHA5U3pt?=
 =?utf-8?B?SVVSYkdES2taZk9MaWdwTExZV0xCcyswckhBeGlNTEFwa1hqczBzeEhyL0pv?=
 =?utf-8?B?RWtUR0ZtRlNCSEloZWJ4c3pja3lRZ3dYNlBOSlFZQXRuTGtRMFpSKzVRU2Mr?=
 =?utf-8?B?QkpJWmo5NUh6V0NoYVNCTWdYakRIWlNrRHdXb0JCckpmRXA0VlZoMkpxMSs1?=
 =?utf-8?B?SnFPZHdLdnNyLy82V0N2MTFNSXVOQitIdFRYODVaQk9hYlEwUkwrOXdZa0cw?=
 =?utf-8?B?SmVyOGFiZ05FeVBIQlI3Yk9BNFVCbVlEQ1pGNGRpZnF4Ny9TU093K1NDcUty?=
 =?utf-8?B?VWFGdHlXd0Q3N3BDb0FEK1l0T3dwT05IWGE5ZUJxZ1lFdzQ1cVVybmpROENF?=
 =?utf-8?B?S3hqY0VmUFZwSU1tSCtncVlrMlU4NTRDemFPeGpNbnhhK2M4R2hFaDI3SnRT?=
 =?utf-8?B?d2xuMDY3bStzeGMvK0hoTi9hV2UwazU0ZWJUTm5KTnJKN3pxQ1ZyMzUrSEJL?=
 =?utf-8?B?UWFYaU1xNnlmenVMZjlRdjIwa1BScG9jcVFrNk1aSXlsVllDQUR0QjJUWnBE?=
 =?utf-8?Q?UoGDgia5feI//ItBAXamu03wN?=
X-OriginatorOrg: amlogic.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 951e9a71-d773-4717-6d98-08ddba0bde9d
X-MS-Exchange-CrossTenant-AuthSource: JH0PR03MB7468.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2025 08:30:30.0112
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0df2add9-25ca-4b3a-acb4-c99ddf0b1114
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: k94DfY+UGKuAhv/KRsfFtpRO2GQSUmE8KCH2LkU9wSKTpfKAyDSX/nd4TDO2snQ+zvi/rbhxtFJLNrFHtllcZw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR03MB8230

Hi Luiz,
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

Since the PA sync connection is set to BT_CONNECTED in 
hci_le_big_sync_established_evt, if its status is BT_CONNECTED when 
hci_abort_conn_sync is called, hci_disconnect_sync() will be executed, 
which will cause the PA sync connection to be deleted.

int hci_abort_conn_sync(struct hci_dev *hdev, struct hci_conn *conn, u8 
reason)
{
...
     switch (conn->state) {
     case BT_CONNECTED:
     case BT_CONFIG:
         err = hci_disconnect_sync(hdev, conn, reason);
         break;
...

stack trace as below:

[   55.154495][0 T1966  d.] CPU: 0 PID: 1966 Comm: kworker/u9:0 Tainted: 
G           O       6.6.77 #104
[   55.155721][0 T1966  d.] Hardware name: Amlogic (DT)
[   55.156336][0 T1966  d.] Workqueue: hci0 hci_cmd_sync_work
[   55.157018][0 T1966  d.] Call trace:
[   55.157461][0 T1966  d.]  dump_backtrace+0x94/0xec
[   55.158056][0 T1966  d.]  show_stack+0x18/0x24
[   55.158607][0 T1966  d.]  dump_stack_lvl+0x48/0x60
[   55.159205][0 T1966  d.]  dump_stack+0x18/0x24
[   55.159756][0 T1966  d.]  hci_conn_del+0x1c/0x12c
[   55.160341][0 T1966  d.]  hci_conn_failed+0xdc/0x150
[   55.160958][0 T1966  d.]  hci_abort_conn_sync+0x204/0x388
[   55.161630][0 T1966  d.]  abort_conn_sync+0x58/0x80
[   55.162237][0 T1966  d.]  hci_cmd_sync_work+0x94/0x100
[   55.162877][0 T1966  d.]  process_one_work+0x168/0x444
[   55.163516][0 T1966  d.]  worker_thread+0x378/0x3f4
[   55.164122][0 T1966  d.]  kthread+0x108/0x10c
[   55.164664][0 T1966  d.]  ret_from_fork+0x10/0x20
[   55.165408][0 T1966  d.] hci0 hcon 000000004f36962c handle 3841 #PA 
sync connection


btmon trace:

< HCI Command: Disconnect (0x01|0x0006) plen 3             #75 [hci0] 
14.640630
         Handle: 3841
         Reason: Remote User Terminated Connection (0x13)
 > HCI Event: Command Status (0x0f) plen 4                  #76 [hci0] 
14.642103
       Disconnect (0x01|0x0006) ncmd 1
         Status: Invalid HCI Command Parameters (0x12)


So the current question is whether the PA sync connection, which is 
marked as BT_CONNECTED, really needs to be disconnected.
If it does need to be disconnected, then the PA sync terminate command 
must be executed.
However, in my opinion, the PA sync connection should not be disconnected.

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

