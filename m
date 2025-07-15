Return-Path: <netdev+bounces-207129-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CCA2B05DCA
	for <lists+netdev@lfdr.de>; Tue, 15 Jul 2025 15:47:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7BFCD1888205
	for <lists+netdev@lfdr.de>; Tue, 15 Jul 2025 13:41:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFBB62E3378;
	Tue, 15 Jul 2025 13:34:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="Z2yri7fz"
X-Original-To: netdev@vger.kernel.org
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013058.outbound.protection.outlook.com [40.93.201.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F930263F52;
	Tue, 15 Jul 2025 13:34:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752586454; cv=fail; b=kahnqGKKPZdqEsOvsd0xW8nd+lFnNq0tJSxdtOJV/EMJ7Osqbreb6F2VoLYqd496jctrjmPS7fUx/DdWRz35u6mgVcnjJO8/n2VsH2rzxdKEgfSujsnsgK02FcKBT7hAcPUrx8ndyYl6sRXGNGt2pJFXUcXlNDbLbEP9nGmsYEg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752586454; c=relaxed/simple;
	bh=DvM0uoFiOg92v9sRQaDMp3My+0juhnVQrQ4RtYMY/3A=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=n6JlsbRbfrTpacfxOUJ0ZgthttbNAP9l760WK45kJtQaHe4zj5b4NtlfbHSDx3TgMhAS9Y4YgsnhveVwFxNbejYbMf2M75D23Wmlxgi4wju/g7LOl4ro8YR/SxOkMxY5Oq/1CFUaK1tz7eicvFT1PtazLGd2p/snzqke6LjIBFs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=Z2yri7fz; arc=fail smtp.client-ip=40.93.201.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GL8g7FWiCWKl8c+ReX1+yscy43pCQR3yQ/nFXXmYTAmK2aot/n6M1zm/H6T2wJHWAiX8wZWDQ9BOSqhm6K/S44ISG0CbTdHc+qIn6n/GupB5mcVlQyeo9TE/kGnY8G9ea0ClEhBNbX9liiwswpMzTxUoTXxGSFQDV/bYOKomIBjZBLvM1XpD1KFDxitrIFM8Y/Q6nQvD9ZTx1ebOCUxRVcV4lLI5QMTvdYGgexgcWRLyv+erMRdESQMfIG5g5UzdCcRz/Mkw0YaRKJtzWtQBhWdYfb3JMw+rzP1QxO8ztpSi6Goef9tOt9IrO32jP5Dd9xYMJ2qtCuZ0ab8EU0Y/Ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OUS4vVRFsMyoKyw9BaG/INYZX2t88yB+C/doWjBqt8A=;
 b=Lg4OQrKBxQrp+jvQjEE7i6RzySWtP5SMWTFWQmZyDCvZVs7CjLBUbPwbyAW+iC3RBmG75PBugcx+JjV4Z6e/0g/7a/SyP6xt0WEeRpjUZvftve1a7+Gb4dqwAVP4FZ9f5EttCSNF8VpGI6jpanvw2m9oBd0i1+ijhrVhBk+SRIW0FUyGHgeMm5Si71w9bRMbZpCW4SdhTNihReW/1h/WlRdThQn1l8rfIArjcdI1qquHm9QxokF+ZoHWynaUM3JKIkpRM2lFaC5Hus9pfeXzMNKuoUUrMu9UM/KQIvQ/5sZB1xVrJyG3mSgyZFnb0BHdDgAL/PPS5EVm/BHVTfQvXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OUS4vVRFsMyoKyw9BaG/INYZX2t88yB+C/doWjBqt8A=;
 b=Z2yri7fzCyRSp96he2oTMfHuY0CGoizysdDYgpVHXURNJIcPPwUyQ9U8xZcp6RmKMKmulo++Tm32/t3XwUybwj38HhFufmozi5f3QpLqdpHt58ZlKYYhpLYTyMLmmVIyFTh/T/7UAg68MMI5qClflKajBohgG734Hv+Ozo/3jVWKjztiuRVl+KkuZqQaXW2+X67qiZR2NQ5YtypduQjK+m4lM+rsuz7bIyMWA0Q3hvG1GOq7c4tayVkEi4uarcJTNLXzYYgLosairB5lrAASCZwQepijLx1rht/MvTNc+M4svRDXY3AvGKhMRoBJ/AaSUTdmRuSmcgs/oavYQEtR3Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from DM6PR03MB5371.namprd03.prod.outlook.com (2603:10b6:5:24c::21)
 by DS1PR03MB7989.namprd03.prod.outlook.com (2603:10b6:8:21b::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.16; Tue, 15 Jul
 2025 13:34:09 +0000
Received: from DM6PR03MB5371.namprd03.prod.outlook.com
 ([fe80::8d3c:c90d:40c:7076]) by DM6PR03MB5371.namprd03.prod.outlook.com
 ([fe80::8d3c:c90d:40c:7076%3]) with mapi id 15.20.8922.025; Tue, 15 Jul 2025
 13:34:09 +0000
Message-ID: <e903cb0f-3970-4ad2-a0a2-ee58551779dc@altera.com>
Date: Tue, 15 Jul 2025 19:03:58 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 2/3] net: stmmac: xgmac: Correct supported speed
 modes
To: Andrew Lunn <andrew@lunn.ch>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Serge Semin <fancer.lancer@gmail.com>,
 Romain Gantois <romain.gantois@bootlin.com>, netdev@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 Matthew Gerlach <matthew.gerlach@altera.com>
References: <20250714-xgmac-minor-fixes-v1-0-c34092a88a72@altera.com>
 <20250714-xgmac-minor-fixes-v1-2-c34092a88a72@altera.com>
 <b192c96a-2989-4bdf-ba4f-8b7bcfd09cfa@lunn.ch>
Content-Language: en-US
From: "G Thomas, Rohan" <rohan.g.thomas@altera.com>
In-Reply-To: <b192c96a-2989-4bdf-ba4f-8b7bcfd09cfa@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA0PR01CA0001.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:80::14) To DM6PR03MB5371.namprd03.prod.outlook.com
 (2603:10b6:5:24c::21)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR03MB5371:EE_|DS1PR03MB7989:EE_
X-MS-Office365-Filtering-Correlation-Id: 66b50192-e650-47ee-379f-08ddc3a4475f
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WFdKb0FzTmVlSGFncm5Ody9WNy9WdXpDQU5OU0Yxb2hraEJQU1cxdTFxTnRv?=
 =?utf-8?B?SzRNbDVCZXI1M1lNcTY0VlI3MWIrZTVKelloZkpvUkNFdFdMZHd5MVlXY1Zs?=
 =?utf-8?B?aUExT2tucTZTUWloZlZETkpiYlRZR3R3MVpoNXd4NXV0TXIxZ29Wem5kZWQx?=
 =?utf-8?B?YkFwNmwxaStCUDR5MlRXdC80R0pwQlFsaG0wN1B6OUJqREtQZ2lvUUN6K1dD?=
 =?utf-8?B?ZWh4eVZmWFNYb3VjMnlsSFh6NlRvWER1M1FtYURGV1piQ2N5OHNiVlc3WDBl?=
 =?utf-8?B?K2N4TUFDVFJLTVl0NkNzZkd4KzZzL2piSmFYSkdBZmlBYmhHc21vYTBEWHph?=
 =?utf-8?B?N001bEJWNkd3WGJhbksvSk50dFRpVkluVVBwSkxBT2o2OGkrOEhyaWpLQUNB?=
 =?utf-8?B?eEdlRHpMQXR6ZkN0NDNEYzRuVld2WlVkOC9iRkdaaHNUWjY5VndHeDQ3MS94?=
 =?utf-8?B?SU55ZkcycEtZMUVibGQzTHlsQ0VBc0NCcGxuc3BJU0VIZ3lSSWN6bnZ3aG9l?=
 =?utf-8?B?d1ZWOUNNdXdmTU15SzZPN0gzd1UvWnVCOXhqcVhBOGg0YnB5RDNxeU5CNnd2?=
 =?utf-8?B?cXYxVEZqem9tVDFKM2F5ZWlhbHZPVEVWZFlTSld1N2RjbThFTS9IOUl5aGhx?=
 =?utf-8?B?ZVB3cDFTdnJrNUlueFlVTm9HT2pyTkFEb3FtOGZPcmhWc1RsdG0zZUh5UWha?=
 =?utf-8?B?NjM2ZU5IK21GaENUQXhqOXNNM29vZklPYTF5NUtic0ViKy9ydjdhTEh0RGNY?=
 =?utf-8?B?Z3J2N29udHZzUTNhcVBCQmhlR1BDZFVRZ0Jhc2RzdkR2U1JEZ0czeTVtRUk4?=
 =?utf-8?B?NnBHVXBqR1NoUGNDMGxUZjdtOTlaT242cGZ4SG53QlJ5dk4vSE1GdFZ3Smxl?=
 =?utf-8?B?akhJZmVCUFI5NGpHbDI1VlVlRW9Qam0veHdEVjNkY0pzNTNWRmV6U2RYbTFq?=
 =?utf-8?B?d0JzYUxUVWhYa0h5aWo0VU90Zk8vSWhWTU1sOWdjUUlqdWoxbHVPMTdrWHcy?=
 =?utf-8?B?emkzMlFBZ09SdGNSalNHUktKOE9KTUhhTGxKNjV6RnhINmQ0YjJaTG5pWDVl?=
 =?utf-8?B?NXZvV2pac0V3VVJHK2ZxZ200clNYMEQ2VWdQVy9zeVRDT0E3SlZlQWcvTnRV?=
 =?utf-8?B?WWFJbDMzdXR3OFgycnQzNTFYdVlmSE9CZkFHQS9uN1FYTXpvaWRJK1lKNmZ5?=
 =?utf-8?B?RHByc1duRGZldmVpZnBodHduU1dTYW5vcXVXZkpSRndFSUkrWDU2TTdabUJQ?=
 =?utf-8?B?UC84ajEvT3lGMzVsOWVaamNBL1dick5KRjFtSWFJTXdWMUxGNUZXR0dnKzN1?=
 =?utf-8?B?ZWtRU3pHYjdDSU5ENFRJQTFwV2o4TTdxaFYrRFIwOU9pYWNnUzN3YmZPUTgr?=
 =?utf-8?B?V1RHS0trVW5jbWtpaDg1c2ROb1pCRmtiQlFCWitGWlM4dDQweVo0Wm9hTFF2?=
 =?utf-8?B?SndPVWxuRlI3Y0tnZ2pkQlZRWUh0OFpCZ3RoUFJId1ZRak9XdEZzaENPOVhi?=
 =?utf-8?B?bzExWUd1VU1HanNiVWxVRkhDK3NuUVVGQm1pTUtnRzUvaSt6QUh6VG9uQXgr?=
 =?utf-8?B?N2hLSUVqZ1FYTHRDYVZPV2g2aDRlejh5RStxMmkrTHE5dDhTbk00cVZrOS9p?=
 =?utf-8?B?cys2L2szWVpPRFdUakZBbmVnU1R5VHZaSWZiR1dkT3RvL080OS9GakNoYTl2?=
 =?utf-8?B?VDF4QjVGaTNxR1Azc3AyYWM3bkVHSEFqSnY4S2JTWWFKcVc4WEVuY3ZueXhp?=
 =?utf-8?B?cURNWDlRc3dVQ0JTR1hpUEdWRDNXTGZYZUlhekF0OTNiSE9jbm9wVW5lUThX?=
 =?utf-8?B?VWZDQUF0Um5RRVJQVGI4Q0lCVEZFQWUvZHZwSFJRN1NSRjJZUldlWVk0c1Mr?=
 =?utf-8?B?RmM1THBYRVhYWEdmYVZRQVlPWEJ2em9LdHVBb0NlNXpnelZHUDhaZ056eXpE?=
 =?utf-8?Q?IhUHwZgvdQk=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR03MB5371.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NXNweVZoSktzY1R1Ym5sWVA3aE1UekNiaCszRENjT3RIRk5SOHdLbGw2Tm5N?=
 =?utf-8?B?dG52L2tKK2loaGwyWWcwaDJHMzFhTVdtMnlDajVTY0t6VUdFZmU5VUk0MUww?=
 =?utf-8?B?YWptT3ZlNkVaRXdXZ2lvK1BPN25aK3d4MlFiYzRMMjRJWVoydUZQdGVIenBr?=
 =?utf-8?B?YWVpRktpMEl0eXRxNGM3RzhaVEt6VURocm9aY1UxVjZYU1YwKzRVTThLbE9r?=
 =?utf-8?B?YUZqaENWUlRCVkNSTncrOGpUQzVvTHZmWEpydGpISWxrMW5ReUlxQ3NHcEZN?=
 =?utf-8?B?czRpejJKODR0b01vU1ZnaFVLa1VpdEZHQ2FBaC9SdWU2RGdUWm1vQmlPbCsy?=
 =?utf-8?B?RmIrRzhZOUdtcGcyaE5MUjRzSlZES0hHeXJmWFVCcmdyeTJGMmtnMG5NdU9R?=
 =?utf-8?B?WlQvZ284cEtZUjh1VFlKdVRaTTNpbEF2Uk5kYVhLQmlnMmVmVnREVTlRamN3?=
 =?utf-8?B?MHhVQWhOSnBRdXh4WjN4Nnh1UysvK3Q4RndrWTB1Vm5NRzFvQ29peG9LK2Fl?=
 =?utf-8?B?R1pEelRma2RpMDFFb3hibmZXK3NrdkFuSjE3cEZWdXRDR3d0My9lRGRWVk9U?=
 =?utf-8?B?ZzgvNHFSRVFBQTdxRnNENzBiTTNIVDJuVnprb1ZzMURNOFhCVWxJdERWTVpI?=
 =?utf-8?B?bjI3c3c1U3AzSkV2RExaTTJJeW5JQWMzN0pKTnJrSzhFb3d4YVlEL3VLMUg1?=
 =?utf-8?B?blViT01DVXd2c2JYUWdWV0FNRWRtUEZ1aCtsN1VRcFpnV2w5T2FsVjV2OGR6?=
 =?utf-8?B?TU1rd2YzRHZVWEd2UDNjbWE5UHVKN3ZhSEtPN2Z5UDM3d3NyZk00K3M5TkNO?=
 =?utf-8?B?SVErb3M0MUk5aTQrSWlpdWVhaU5ENFUxN3BvWXFYZGxBRVZSa3MrQ3RGZnhp?=
 =?utf-8?B?eFpKUit5QmpncDE5MjhOU1NlTDhxT01wQWptaFlMRkEvZFlKRm5TbGxwc1hE?=
 =?utf-8?B?MGlRTVkrN0F5QUdKM2hMTUJpcUt6ZHJSbDcvelZ1U1lQdGJlaG5yRWNkbTRN?=
 =?utf-8?B?b0RDRkxTUmc0S0VDYVRrK3F3Ri9nTVNPQXBmZThXRkdpUkJTOHkxRmYwZ2Fo?=
 =?utf-8?B?b3crR2pwcURFem9yWVk0dG9xM0NVU0xXcm9BQVdmRkZrOVE5Q1VsbmRrTWdF?=
 =?utf-8?B?eTFqR0FXL21yQ3VvK0tGc3lxM2s3di90WFZtK3AxaTVrTk43YTVoUGlYd2tE?=
 =?utf-8?B?OU9ybG1OTlN4WmxKVFBvRlovc3Q4MXplSER1U0ZXcUIvNE1sMU1DM0hMRzBX?=
 =?utf-8?B?TkFnNW4zQUVuWGJGYWVrWWRCTDFtdWhIakNrbEJudTh1ekZKOEtTOUEwV3B4?=
 =?utf-8?B?SFlWMXltajZvNC9YUEE0RVBlUEFEM2czbjNCMUcrYXhYZHhnM3ZuT3U2N3BC?=
 =?utf-8?B?blUzZ1JmU3hQUG1wU3pGUWI2TWEzVm5yUUNOQXRwQ00zRmk0ZUFHVGxkbndI?=
 =?utf-8?B?RVFqZ2ZhU2V3ZTBldVVUSDVIdTh2T0IxWFZiOFpUMUlFamxKTm42VUppQWFD?=
 =?utf-8?B?WTRRak5Uc0dTcmEyN0hwaHFOdUZWejFuVjZFMkNYUWFkQ2JqRS9admJXUDJn?=
 =?utf-8?B?R2kxYnBmRFFDRGVzcmpZU3NhbHYzQUZzZzFzOFAwOHNONE5xMzZNZmpxbEtq?=
 =?utf-8?B?bXc2S2dRKzlYWFFCNENrcjRHakVkSFY1ejFwVlh0MmdOd2RSM0NqdVBGVmY0?=
 =?utf-8?B?U0hGY1NMQjBJZHcwVnVtTVdYS05iTlJpaXQ1aW5CN3hYTGVvVFFQczg3YTRS?=
 =?utf-8?B?N0Y0UTF1OG0wdW83RnZlS1RBaHlxT21JS0JjWkMxVE40c1k5bTBUaG50NU5O?=
 =?utf-8?B?akI2SGE4ZWF2ek5rQ3dBbTNtRDA3VmUzTFkyQlR0TE5BR1p6cGhRcnM5Qng5?=
 =?utf-8?B?YWZFRlpQd2N3c0Y0dTlmYXphUlRCMDh3ajJ2cjlSOVJBK091TEp6VkJrVTAx?=
 =?utf-8?B?RGxQSFQvbVB0c3B4Vk12ZVJoampxMjl1RUs1dHM0cHA1VlFNb1d3VXc5bU1q?=
 =?utf-8?B?N0tGTm9VaEpPbzh1elBrV0laTklEcFByUEtneXdWSEl3cmFXMk1CYXhZWjFF?=
 =?utf-8?B?Ym43b25OMjhpNlExV2pXb3FUR2tHc3ZVZEtVeGlWQlgvU0pTenMzV1MwekRR?=
 =?utf-8?B?QUt6emR1SWx0VHFxYlpSOXVDTTd4N1hVOG56M3BMUUZ1bWJrK20yVjlQM25t?=
 =?utf-8?B?T0E9PQ==?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 66b50192-e650-47ee-379f-08ddc3a4475f
X-MS-Exchange-CrossTenant-AuthSource: DM6PR03MB5371.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2025 13:34:09.7188
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5pbYlZfDLpfSHeOAgOydc9Cckh1arIATDOKSpSY3+NT3nIilln4aSzpMf2r+adgvaghjnSq0jUMGR/qGv8v91iWgAynotnCl8v+gsr9oRqY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS1PR03MB7989

Hi Andrew,

Thanks for reviewing the patch.

On 7/14/2025 7:12 PM, Andrew Lunn wrote:
> On Mon, Jul 14, 2025 at 03:59:18PM +0800, Rohan G Thomas via B4 Relay wrote:
>> From: Rohan G Thomas <rohan.g.thomas@altera.com>
>>
>> Correct supported speed modes as per the XGMAC databook.
>> Commit 9cb54af214a7 ("net: stmmac: Fix IP-cores specific
>> MAC capabilities") removes support for 10M, 100M and
>> 1000HD. 1000HD is not supported by XGMAC IP, but it does
>> support 10M and 100M FD mode, and it also supports 10M and
>> 100M HD mode if the HDSEL bit is set in the MAC_HW_FEATURE0
>> reg. This commit adds support for 10M and 100M speed modes
>> for XGMAC IP.
> 
>> +++ b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_dma.c
>> @@ -405,6 +405,7 @@ static int dwxgmac2_get_hw_feature(void __iomem *ioaddr,
>>   	dma_cap->sma_mdio = (hw_cap & XGMAC_HWFEAT_SMASEL) >> 5;
>>   	dma_cap->vlhash = (hw_cap & XGMAC_HWFEAT_VLHASH) >> 4;
>>   	dma_cap->half_duplex = (hw_cap & XGMAC_HWFEAT_HDSEL) >> 3;
>> +	dma_cap->mbps_10_100 = (hw_cap & XGMAC_HWFEAT_GMIISEL) >> 1;
> 
> The commit message does not mention this change.

Agreed. Will do in the next version.

> 
> What does XGMAC_HWFEAT_GMIISEL mean? That a SERDES style interface is
> not being used? Could that be why Serge removed these speeds? He was
> looking at systems with a SERDES, and they don't support slower
> speeds?
> 
> 	Andrew
As per the XGMAC databook ver 3.10a, GMIISEL bit of MAC_HW_Feature_0
register indicates whether the XGMAC IP on the SOC is synthesized with
DWCXG_GMII_SUPPORT. Specifically, it states:
"1000/100/10 Mbps Support. This bit is set to 1 when the GMII Interface
option is selected."

So yes, it’s likely that Serge was working with a SERDES interface which
doesn't support 10/100Mbps speeds. Do you think it would be appropriate
to add a check for this bit before enabling 10/100Mbps speeds?

Best Regards,
Rohan


