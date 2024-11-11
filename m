Return-Path: <netdev+bounces-143693-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 55DC09C3AAB
	for <lists+netdev@lfdr.de>; Mon, 11 Nov 2024 10:15:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 14629281C86
	for <lists+netdev@lfdr.de>; Mon, 11 Nov 2024 09:15:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3555815687D;
	Mon, 11 Nov 2024 09:15:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b="I219qV68"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 620094A3E;
	Mon, 11 Nov 2024 09:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.156.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731316536; cv=fail; b=PMzwaEzxyIbPpH5D+/VjpKzLV9OdjehS6sr5obZJgoCqrdIR8DrvuXuPgbFIYF+73Gj541cqAuGtTetXzGH50Vk5TcXaTvlhRHeNyChZSU3IqncDltBA+gs7iZRUlxrhen/k8xdgtqFNkbWHtK2yXT3ymbP4xZhFi3Pi5rgI+FQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731316536; c=relaxed/simple;
	bh=o4lu4sqUWwCGfa+F8KW53MRkbZbH7xE7khRC+2zI4EI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=fwPd5wFYl5bxxT2mHC92dKity4Jg4hUUMsoIwwYe5p10Ws6GsMsZyvNxods7B+QbrRW613TywPdjnn98f7XhJ4CuzZEFTlyn0ZZ+OZmbbjtm8cGyOCsG6FfZ8YWcd2OzMsd+x8ULpp39/xf05FilHS93VlhRVWCbiQ2Nu+/op/A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b=I219qV68; arc=fail smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AB8JWlp028707;
	Mon, 11 Nov 2024 01:15:25 -0800
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2169.outbound.protection.outlook.com [104.47.59.169])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 42t84pjm36-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 11 Nov 2024 01:15:25 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GkdtGDGhZdCXPy92A8fcqiywTUCamNZbkkjOylXeH/+hmUukOL2F7xfKsF502HqTaK1qy9ufST0hYOJBZiVCFxoGAb1IfIGGMWskKzXLB602M3WlYwC+VCnwtBQJkb4qwrZNKh54mSEjb7FGCYcp1xaiM8WhOVzg4oAJNPpcwpfJKEAvJWOuIdneELznsuDeOfsgulCsJincFSlVMT9XQWtB/yjyvP0qVzYyJz0AJJ6pWI68TG3T3Dfe+x4/l3m8JZSGEdybkk42sg1/nsRIRKmhFFea0IKtR5NB4wviAXJh6uqG+oWwR2zVMZNauE0mQn+bsp4fvJbsd52M/9RehA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o4lu4sqUWwCGfa+F8KW53MRkbZbH7xE7khRC+2zI4EI=;
 b=cuZccgxQno868h42Eds9OcQefYQlH5tP+Z10GzZUydXgYA2LywUvYd2QmUNlEsdx2N3t6iGjPMpKE4pPm35J6ppBmffLrLPaFiR2iwjbrsJF2ZECIIMWYTRi5ptL97GBBT+ZuVgsiN7yVrs68JA1jt32A5AjePYMEcL99dLye9mu4+Ht1wo7sC+ZcIrwqD/ZGu2pCs5kjQHElrRhqT57j6saULRLs8Ki6UmXo5rhIvzdce7kZOeun7qFwY0vQhgeTL+HTUmZgkkl3HdEIAbhy00YbLAmIHK2nyGtHeEFZzu2RhUmRLsM8t20KI4Ry/mmlgYq6QAl34Z/ZuagdVKa7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o4lu4sqUWwCGfa+F8KW53MRkbZbH7xE7khRC+2zI4EI=;
 b=I219qV68F7pqJijhYU3MHkR6/hCO26yLxZlhCCBr0+2HyQro8OzDIA0g7LE1KjkgRy3V2mbeP6zPQOisYAxGW7HpvW/XkifKzpsfAHsMVT087s3hEbM3AvE805gUjo0uJlJs6Ycdgi6Cg6ZoUBcUg/9RGMZBofE4c3B9ExRzgAA=
Received: from BY3PR18MB4707.namprd18.prod.outlook.com (2603:10b6:a03:3ca::23)
 by PH0PR18MB4507.namprd18.prod.outlook.com (2603:10b6:510:e2::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.28; Mon, 11 Nov
 2024 09:15:21 +0000
Received: from BY3PR18MB4707.namprd18.prod.outlook.com
 ([fe80::e225:5161:1478:9d30]) by BY3PR18MB4707.namprd18.prod.outlook.com
 ([fe80::e225:5161:1478:9d30%5]) with mapi id 15.20.8137.022; Mon, 11 Nov 2024
 09:15:21 +0000
From: Sai Krishna Gajula <saikrishnag@marvell.com>
To: Simon Horman <horms@kernel.org>
CC: "davem@davemloft.net" <davem@davemloft.net>,
        "edumazet@google.com"
	<edumazet@google.com>,
        "kuba@kernel.org" <kuba@kernel.org>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        Sunil Kovvuri Goutham <sgoutham@marvell.com>,
        Geethasowjanya Akula <gakula@marvell.com>,
        Linu Cherian
	<lcherian@marvell.com>, Jerin Jacob <jerinj@marvell.com>,
        Hariprasad Kelam
	<hkelam@marvell.com>,
        Subbaraya Sundeep Bhatta <sbhatta@marvell.com>,
        "kalesh-anakkur.purayil@broadcom.com" <kalesh-anakkur.purayil@broadcom.com>
Subject: Re: [net-next PATCH v2 1/6] octeontx2: Set appropriate PF, VF masks
 and shifts based on silicon
Thread-Topic: [net-next PATCH v2 1/6] octeontx2: Set appropriate PF, VF masks
 and shifts based on silicon
Thread-Index: AQHbNBo7QkaTQvWHAUaT/ZPryKno0Q==
Date: Mon, 11 Nov 2024 09:15:20 +0000
Message-ID:
 <BY3PR18MB4707E791EAA647BA866D7722A0582@BY3PR18MB4707.namprd18.prod.outlook.com>
References: <20241022185410.4036100-1-saikrishnag@marvell.com>
 <20241022185410.4036100-2-saikrishnag@marvell.com>
 <20241101100832.GC1838431@kernel.org>
In-Reply-To: <20241101100832.GC1838431@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY3PR18MB4707:EE_|PH0PR18MB4507:EE_
x-ms-office365-filtering-correlation-id: 95d45375-be0b-40dc-3546-08dd02315df6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?OEJkRUxzMzJjQnY2WnI0WjM0L1c3WTFxTmNabVdmN0h5aTg2eEhqRnFweXlX?=
 =?utf-8?B?YWZLY2R1YnVmRTVyOHMxeFUzcSs2ckp4ZExtYzNNVWcyRE1LWDBoSkNqUFlZ?=
 =?utf-8?B?OGVkTG94YkY2anhoWkdFNWxudDFER2VHeEVsWlBtc2RuSUxqV0Evem0zbllh?=
 =?utf-8?B?b3RhdTVrZUlMWEMvR3FqaGg4SjZwcTlreU9xc2JIalQ2WFpwTVZUbnphR01B?=
 =?utf-8?B?SThDWUZZWWJrK0hHM1dwUkVWNHpBZHVKSXRTeTkrM2FrU0NoZVFKUTcxVVlF?=
 =?utf-8?B?bDhyc2FFQ2hQM01pbWVPbVZRaGcvUDVyNTZXWWZoa3Rua0lLMDZIRnljaVov?=
 =?utf-8?B?eGMzaTdkOVBldnFBME9WVHo4Y2Y3MFV2bkp0MFVKalVBT2x0K1ozOEJ4eVRp?=
 =?utf-8?B?bWlOMlF3TVdvRXRmSWc0TEQzd0o2c01RUWx6L1FoRFZpUjYzUFBRUGluOHYz?=
 =?utf-8?B?UUhqVWFKdldnUEFkZlMxbERoMVlUaUErM3BoZGgzVHVLVC9zMjZNTVM5ZVRM?=
 =?utf-8?B?V2ZZem5mZW80Ky84R2pSNlBqNVBHL0hhN3JNME5zS3I1N3MwTStRdDVWdGZO?=
 =?utf-8?B?bE1nbUlOT3AwSStjUUMyYmZOcHo5MHlXUEE5NTdoSGwwcU1kTTFlZDNxc1Mr?=
 =?utf-8?B?Z0k1c3RyVGU0WVZwbGI1OGUzVGJKeXpKWk9ORzlyU1UrSEM5aG1pWlhzZU9Q?=
 =?utf-8?B?UjZHR2xNN2dHUUtOK0ZkTU5kQ3ZneE9CMUZ1cUszeXRSUUNReXV5OTV4Ym91?=
 =?utf-8?B?TVdIQit1Y21zNFZLRnZiZmx5dGtmV3RpaVUyUlh3R2JzOFFmZ0ZMaTlTZnli?=
 =?utf-8?B?a2ZydE5FNXhUZHVXNG1Edlk3c1ZyQmRNTzlVNXFlTExvL2diVHlIY09UVXlC?=
 =?utf-8?B?OFlCVVRwNnQxSnNldGJJSDNzVUR2ZE91NVQ1NUdVZFhJd1ArS1prZml6Skwr?=
 =?utf-8?B?YmdIQmFmVnVQR29CeDhoWERsbE96a1JnUFR4V0dUYklNbXBQNFFTc1pVQ2JE?=
 =?utf-8?B?RFY4VWF3UmtnNFFwSWNNYm5Dc2ttbnJFVXlQa3BxOGF2NzhKRVBodXV4SGhi?=
 =?utf-8?B?TWpBTHhkM200Unp1a0FiUlVxQ1A0cmRycEY0VzhRTFRkSjNsemhMUkxFZFdr?=
 =?utf-8?B?bkJCNEFuS210ZkFTbFpHN2xaQy9DTWJhQ2NjN0VjZms5ajRKL3cwbC95cVhO?=
 =?utf-8?B?dGQxdERHYXIyTFM2OEZJV3BkVm55TjYzWkpsU0pNL1ZaTk5pR3lnVThhSURr?=
 =?utf-8?B?Z3pGUUVqam5Fc280MmJqZUJpZ1lkSmtrZEJteEMvTEwzanlzT2xmaWxFbTZY?=
 =?utf-8?B?VEV4L1plM29XcERqV1hSQnpCMjI1clNJend5R3MySHdMREpWY1dmUWFQdWJp?=
 =?utf-8?B?THpoSVdDNkNnYkZ3WkdJR2pmWGlFTXFIQ2NvRXJiU0YzTUlqSG9Hd1g2cXFQ?=
 =?utf-8?B?UHVEUmZtd0FjUGNreXIvUHlzUm5XU05wOEFQZFNwNTZhL3FZWWtQTnJSamc3?=
 =?utf-8?B?NzZtS0crRkxCdUVyeG5lMTBsNFh6MWliNERidnNGclZFVDZUN3RBQ2ZIY2RF?=
 =?utf-8?B?V2QwTW9GTXpGRlp6TTFiQ2J3UjJIM2kvNkVLZXUvajdmTFlPWEpuTCswZzV4?=
 =?utf-8?B?Y1BNTFMyOVhCcUl6cGcrVGE2Z3lHSjVhd0pQdWN6VHR4bHM2UGlvdExYakR1?=
 =?utf-8?B?UFo3OE1qY0p0MTJGZWZCSkZOL1Fza1lWSFNnWHlKbjlIVzljaTFsVkphMFln?=
 =?utf-8?B?OTlwU0I0dnBUMy8vdlZBRFFEUTN0dFp1WFpJNVhBdUl4TytyVmVZOVdyb3VI?=
 =?utf-8?Q?X31zGL7KfutjL1KBVEJHrklwg9a1kS6qRnQ6k=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY3PR18MB4707.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?OUZrSmQ4R3FRajAySG9UMXp0YlhYZUlvNnNqTUIzRk5WVmIwTFRWeUNlMXA1?=
 =?utf-8?B?QW1FTWlXVEhKOUtjMFoyalpwMkFVakpYWE9CVGptWlgvRkVBZXd5ODJ6eEVw?=
 =?utf-8?B?NGN0djVCa25VOWpwVTM4WS9INEMrMGdlamlTckF3dGxmamhqUnpvNE9SRk5k?=
 =?utf-8?B?TGFlUHVtbzdmRnBYTVE0anB0S3ZadHZncm40aDZlbkFuUUtqellHdjRmN3du?=
 =?utf-8?B?NlVGU2hxcnBBVWRNdVJubnNuMVJSd0Q4emtLdG1Gdm9mckFtc21zUm1nQ3hR?=
 =?utf-8?B?U2lSY1BsQWhmdHQ0L20reGJIakh6WDVHMzVubUxSVk13UVFBaVF0LzB1N2tr?=
 =?utf-8?B?ZzNGY0N6VVRuRHl4ZnhiZmI0U0ZFRmlWYnBvcENxRnZaeFdad3ZQVytHS3BR?=
 =?utf-8?B?cThUMmVhSkVLYkJyMC9RWk1uZGtoeU1FWGxiVXNEUUhVREt6aERrNmF2eUJj?=
 =?utf-8?B?YzRLTjRNVmgybjZMMTFtWmt6aUNjdmNJcFNzR0x2ZzNSWUx4bXg1OUdlT3pP?=
 =?utf-8?B?NkxXdkVTMG85ZXdkeGpRNk1hbUVYRjRuUlVaeWpSL1VnV0hTRUN6VExiT3pB?=
 =?utf-8?B?NEE4WkZTVW9IOHJrMC95NWJ6NTYxSENKT2M1a1pBRmhFNStvQzhNM2o4YUR5?=
 =?utf-8?B?eE9OY1FUbndSdWNTUHpKbzRPZ2RjTmxTcmY1VVA2djhtNGMxS28rU1BtZ21X?=
 =?utf-8?B?blJ3SnQybmkzZXFnaE9jRjVmYVQrTlc2bU95QkxVaWxMRTA0R250Q01IaGRY?=
 =?utf-8?B?UWNvR0hWbkpSYzFzZHhHam5WU3BxdmJhL3dGdWJLK1ZJdlB6SWZER0NPTTZa?=
 =?utf-8?B?WmJTdm8ranRYZXNuaFB3Y003eTduWTd6RGhXYmFIenR1MGQ5WUV2S2VQS2Va?=
 =?utf-8?B?c1VtOHp6NEFiYm1maGtoMmpLdGg5WUVVZ1BvODYyMFJkR2luSjM3NW5BTy9x?=
 =?utf-8?B?MGhKYkFIR2lYZWo4aFhQQlJNSi9hR1JRcDhTbXRwcm8yVTVPSVJJb0x2bnpW?=
 =?utf-8?B?UU1uUjBVbkVKNnYycG9VUFdZUTduZGM1RW1FZXBTUlhsdGRSempkdjk3ZGtY?=
 =?utf-8?B?QktxMGZ1Y1pzckFyb2tRM1dyNDBmMUNkNnp1VU9EeVpYeURBODdKUW9FdzNr?=
 =?utf-8?B?U054Y3BHbnNVV09nT3B5enptUWJCcFllcXRmUHoxNVI5Y0RvSlVWRXdXZE5D?=
 =?utf-8?B?K1JQYjdJYjFRSmY4NmtNRWFjcTBTN1pnSlR0WnhFVTVmbFRaZXBMaTZ2M1FF?=
 =?utf-8?B?bVJCRUNoRmQ5YkV4VENrbjZpUFZicTQvTWhyMWdiYXhLNXV5M1RaMi9lbGpJ?=
 =?utf-8?B?Ym9td002cmtKSTY0QnAzREFpczFFQWxDSzZRSXp2VWxjSFl6UDFkdEMvL2dq?=
 =?utf-8?B?YlU0Qk5CelpHeHRNWndDWTdIbXRjWVNSc0F3VEZHazR0cGJEYll4N2s0K044?=
 =?utf-8?B?S2N1MjMwbGREd1BSclhwalFvRmMyMEN4ZHJDVHFCTWxwZElHUnlMUHNWTWJT?=
 =?utf-8?B?Nlczclk3cjhwNTZlYVZ0UmxNSUhlbS80b2ltYUdzV1F4RXIrUTBXMjY5cVhK?=
 =?utf-8?B?UWdYbjJLMTVsTlJRa1V5N25zWk9UcEl5T3FJODYxMjZ4aFJhSjd4dTJuQmhS?=
 =?utf-8?B?eE9xRXRnS2kwQlpOczR1SUEzc1FOQXl0dzVORUJVM2wxUlJqQ201eEt6bVBU?=
 =?utf-8?B?OGxQTE1VY3JxeWpOcld4eFZLWlkrWFRFdEI1OXhCMlRvcTRoNWhsRU0zZ3RV?=
 =?utf-8?B?QVI5ckFxWWNUK3YzN2lnaDRmcXhqcVNUR0NLUDFwVzErMkpHYWRORGVaVVBM?=
 =?utf-8?B?NUlmNnN3OHExcDRPT0Fsakg4ZmFLUFF2c0I1VDNWeXM4UjdScW1TL1NzY1R2?=
 =?utf-8?B?Z2pndmNWa3Y0NG5MblN4TTdldWhtbHF6ci9ta2RnNzJ2WW1TQldMV0hHakha?=
 =?utf-8?B?VktWRVp6L0dYWmE3dU5OUHZ1Qjk1RXY1Wld1bG9iekRya0hzbTVzL2VCMXp2?=
 =?utf-8?B?d3ljdnhIOG13ZHRIQUhaTFFjUjdGZXNmTGV2NVNOSFlGOGx6L2l1NTVqMjZk?=
 =?utf-8?B?cGZRZTN6UGx2YlIrZkx0NzNaVWU4N25CK3I2NkIvSWhVNWV4aDEwQ0s5NENG?=
 =?utf-8?Q?kAjFwqA/LR3LHBIm0CoI9HEa8?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY3PR18MB4707.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 95d45375-be0b-40dc-3546-08dd02315df6
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Nov 2024 09:15:20.9325
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: x1oafo5ktJknV62KcgRLi7RG9QYJ5s+Ax7lFRaPbE+lh3WQUO1JEP4aYdM+AXuhmP1Y//VdTn4J+RnSodjpDRQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR18MB4507
X-Proofpoint-ORIG-GUID: AH4IDovJ9msdKRInCvCL13g4C6a0nkOf
X-Proofpoint-GUID: AH4IDovJ9msdKRInCvCL13g4C6a0nkOf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBTaW1vbiBIb3JtYW4gPGhvcm1z
QGtlcm5lbC5vcmc+DQo+IFNlbnQ6IEZyaWRheSwgTm92ZW1iZXIgMSwgMjAyNCAzOjM5IFBNDQo+
IFRvOiBTYWkgS3Jpc2huYSBHYWp1bGEgPHNhaWtyaXNobmFnQG1hcnZlbGwuY29tPg0KPiBDYzog
ZGF2ZW1AZGF2ZW1sb2Z0Lm5ldDsgZWR1bWF6ZXRAZ29vZ2xlLmNvbTsga3ViYUBrZXJuZWwub3Jn
Ow0KPiBwYWJlbmlAcmVkaGF0LmNvbTsgbmV0ZGV2QHZnZXIua2VybmVsLm9yZzsgbGludXgta2Vy
bmVsQHZnZXIua2VybmVsLm9yZzsNCj4gU3VuaWwgS292dnVyaSBHb3V0aGFtIDxzZ291dGhhbUBt
YXJ2ZWxsLmNvbT47IEdlZXRoYXNvd2phbnlhIEFrdWxhDQo+IDxnYWt1bGFAbWFydmVsbC5jb20+
OyBMaW51IENoZXJpYW4gPGxjaGVyaWFuQG1hcnZlbGwuY29tPjsgSmVyaW4gSmFjb2INCj4gPGpl
cmluakBtYXJ2ZWxsLmNvbT47IEhhcmlwcmFzYWQgS2VsYW0gPGhrZWxhbUBtYXJ2ZWxsLmNvbT47
IFN1YmJhcmF5YQ0KPiBTdW5kZWVwIEJoYXR0YSA8c2JoYXR0YUBtYXJ2ZWxsLmNvbT47IGthbGVz
aC0NCj4gYW5ha2t1ci5wdXJheWlsQGJyb2FkY29tLmNvbQ0KPiBTdWJqZWN0OiBSZTogW25ldC1u
ZXh0IFBBVENIIHYyIDEvNl0gb2N0ZW9udHgyOiBTZXQgYXBwcm9wcmlhdGUNCj4gUEYsIFZGIG1h
c2tzIGFuZCBzaGlmdHMgYmFzZWQgb24gc2lsaWNvbg0KPiANCj4gT24gV2VkLCBPY3QgMjMsIDIw
MjQgYXQgMTI64oCKMjQ64oCKMDVBTSArMDUzMCwgU2FpIEtyaXNobmEgd3JvdGU6ID4gRnJvbToN
Cj4gU3ViYmFyYXlhIFN1bmRlZXAgPHNiaGF0dGFA4oCKbWFydmVsbC7igIpjb20+ID4gPiBOdW1i
ZXIgb2YgUlZVIFBGcyBvbg0KPiBDTjIwSyBzaWxpY29uIGhhdmUgaW5jcmVhc2VkIHRvIDk2IGZy
b20gbWF4aW11bSA+IG9mIDMyIHRoYXQgd2VyZQ0KPiBzdXBwb3J0ZWQgb24gZWFybGllciBzaWxp
Y29ucy4NCj4gT24gV2VkLCBPY3QgMjMsIDIwMjQgYXQgMTI6MjQ6MDVBTSArMDUzMCwgU2FpIEty
aXNobmEgd3JvdGU6DQo+ID4gRnJvbTogU3ViYmFyYXlhIFN1bmRlZXAgPHNiaGF0dGFAbWFydmVs
bC5jb20+DQo+ID4NCj4gPiBOdW1iZXIgb2YgUlZVIFBGcyBvbiBDTjIwSyBzaWxpY29uIGhhdmUg
aW5jcmVhc2VkIHRvIDk2IGZyb20gbWF4aW11bQ0KPiA+IG9mIDMyIHRoYXQgd2VyZSBzdXBwb3J0
ZWQgb24gZWFybGllciBzaWxpY29ucy4gRXZlcnkgUlZVIFBGIGFuZCBWRiBpcw0KPiA+IGlkZW50
aWZpZWQgYnkgSFcgdXNpbmcgYSAxNmJpdCBQRl9GVU5DIHZhbHVlLiBEdWUgdG8gdGhlIGNoYW5n
ZSBpbiBNYXgNCj4gPiBudW1iZXIgb2YgUEZzIGluIENOMjBLLCB0aGUgYml0IGVuY29kaW5nIG9m
IHRoaXMgUEZfRlVOQyBoYXMgY2hhbmdlZC4NCj4gPg0KPiA+IFRoaXMgcGF0Y2ggaGFuZGxlcyB0
aGUgY2hhbmdlIGJ5IGV4cG9ydGluZyBQRixWRiBtYXNrcyBhbmQgc2hpZnRzDQo+ID4gcHJlc2Vu
dCBpbiBtYWlsYm94IG1vZHVsZSB0byBhbGwgb3RoZXIgbW9kdWxlcy4NCj4gPg0KPiA+IEFsc28g
bW92ZWQgdGhlIE5JWCBBRiByZWdpc3RlciBvZmZzZXQgbWFjcm9zIHRvIG90aGVyIGZpbGVzIHdo
aWNoIHdpbGwNCj4gPiBiZSBwb3N0ZWQgaW4gY29taW5nIHBhdGNoZXMuDQo+ID4NCj4gPiBTaWdu
ZWQtb2ZmLWJ5OiBTdWJiYXJheWEgU3VuZGVlcCA8c2JoYXR0YUBtYXJ2ZWxsLmNvbT4NCj4gPiBT
aWduZWQtb2ZmLWJ5OiBTYWkgS3Jpc2huYSA8c2Fpa3Jpc2huYWdAbWFydmVsbC5jb20+DQo+IA0K
PiAuLi4NCj4gDQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbmV0L2V0aGVybmV0L21hcnZlbGwv
b2N0ZW9udHgyL2FmL3J2dS5oDQo+ID4gYi9kcml2ZXJzL25ldC9ldGhlcm5ldC9tYXJ2ZWxsL29j
dGVvbnR4Mi9hZi9ydnUuaA0KPiA+IGluZGV4IDUwMTZiYTgyZTE0Mi4uOTM4YTkxMWNiZjFjIDEw
MDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvbmV0L2V0aGVybmV0L21hcnZlbGwvb2N0ZW9udHgyL2Fm
L3J2dS5oDQo+ID4gKysrIGIvZHJpdmVycy9uZXQvZXRoZXJuZXQvbWFydmVsbC9vY3Rlb250eDIv
YWYvcnZ1LmgNCj4gPiBAQCAtNDEsMTAgKzQxLDEwIEBADQo+ID4gICNkZWZpbmUgTUFYX0NQVF9C
TEtTCQkJCTINCj4gPg0KPiA+ICAvKiBQRl9GVU5DICovDQo+ID4gLSNkZWZpbmUgUlZVX1BGVkZf
UEZfU0hJRlQJMTANCj4gPiAtI2RlZmluZSBSVlVfUEZWRl9QRl9NQVNLCTB4M0YNCj4gPiAtI2Rl
ZmluZSBSVlVfUEZWRl9GVU5DX1NISUZUCTANCj4gPiAtI2RlZmluZSBSVlVfUEZWRl9GVU5DX01B
U0sJMHgzRkYNCj4gPiArI2RlZmluZSBSVlVfUEZWRl9QRl9TSElGVAlydnVfcGNpZnVuY19wZl9z
aGlmdA0KPiA+ICsjZGVmaW5lIFJWVV9QRlZGX1BGX01BU0sJcnZ1X3BjaWZ1bmNfcGZfbWFzaw0K
PiA+ICsjZGVmaW5lIFJWVV9QRlZGX0ZVTkNfU0hJRlQJcnZ1X3BjaWZ1bmNfZnVuY19zaGlmdA0K
PiA+ICsjZGVmaW5lIFJWVV9QRlZGX0ZVTkNfTUFTSwlydnVfcGNpZnVuY19mdW5jX21hc2sNCj4g
DQo+IEhpIFN1YmJhcmF5YSBhbmQgU2FpLA0KPiANCj4gSSBzZWUgdGhhdCB0aGlzIGlzIGluIGtl
ZXBpbmcgd2l0aCB0aGUgaW1wbGVtZW50YXRpb24gcHJpb3IgdG8gdGhpcyBwYXRjaC4NCj4gQnV0
LCBGV0lJVywgaWYgRklFTERfUFJFUCgpIGFuZCBmcmllbmRzIHdlcmUgdXNlZCB0aGVuIEkgZXhw
ZWN0IHRoZSBfU0hJRlQNCj4gZGVmaW5lcyBjb3VsZCBiZSByZW1vdmVkIGVudGlyZWx5Lg0KPiAN
Cj4gUGxlYXNlIGNvbnNpZGVyIGFzIGEgZm9sbG93LXVwIGF0IHNvbWUgcG9pbnQuDQpBY2ssIFdp
bGwgaW1wbGVtZW50IHRoZSBzdWdnZXN0aW9uIGluIGZ1dHVyZSBwYXRjaGVzLg0KPiANCj4gPg0K
PiA+ICAjaWZkZWYgQ09ORklHX0RFQlVHX0ZTDQo+ID4gIHN0cnVjdCBkdW1wX2N0eCB7DQo+IA0K
PiAuLi4NCg0K

