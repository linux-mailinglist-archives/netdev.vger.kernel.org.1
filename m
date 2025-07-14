Return-Path: <netdev+bounces-206686-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A5683B04117
	for <lists+netdev@lfdr.de>; Mon, 14 Jul 2025 16:11:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EC31416BA1E
	for <lists+netdev@lfdr.de>; Mon, 14 Jul 2025 14:11:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16438255222;
	Mon, 14 Jul 2025 14:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="GEm8JLWu"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D432722FAF4;
	Mon, 14 Jul 2025 14:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752502309; cv=fail; b=dXzg9ioJKDWT8PHwWszhAPAe7mucMvtgyyx8ma1zHf0kCmXVJJttJs7Y96oCT/BZZd2FMQXF1rHTdtXQBdUwenlfEjgwqYvc/J6DXnQQM9+b9G79/6Qt64nzCGuTW0sc7bHii/gGb9Qfs5rv8LvU079LxQffkllTRp3epzJ+tEY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752502309; c=relaxed/simple;
	bh=mwqbxWy0wnwaifa4iW8+oUpW+rBY53Lj/bH2/GPOVYU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=BB89iUoyceu3XABOhoVLRNtSfYtX/qr29mN3iSnt4vBuIy1YoQ2e8HqJ9DHKzlf/yormpIcmS4n7RH6F86X4InELu6UBONeASmBY2HXMH2h+A5gboHnWLAP4baa4vrJ8U144cejB8Xt6rC74e7RJFVXpC3ke7g/Qi8PXuQfvTYM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=GEm8JLWu; arc=fail smtp.client-ip=40.107.236.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Sh+X2PHC+CqtbTl0mFZZxlAy54mOeUTTWj6AwuJ9vUDs5jbrLe3BVLFzV2a2SJwy0s7R7a2RX85XT5tvoo8k8yOJYCffNc2vL6mDwJTpQES6GGXzqvSP+zUht5AEm/xnF1dQIfvD9Kgd9kA6qTqE2/JnJ4wU3oJPXFKOcZlZxgCRkSyJBwfZLr4Zg5CLgfW2+qdSVU2ZdGwTuqhuY7mofHKiXmTA/uSWBBO8CKCCv4PyWK/wwKat1fYaiYVkaslPGjTFcQZu6pAcB2Ti1hYFDmH5LP6pDTfqLpEyfTcUWwzJDMGSipN/hadmRYqWZDoo/e8GsBPYbZ6f9Tg+jxJFEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mwqbxWy0wnwaifa4iW8+oUpW+rBY53Lj/bH2/GPOVYU=;
 b=LhAjnwxFIHPmMpRda1GHgeivOLN0Y356FzMre25Ak79kISjIGQ6bWqLKMV4HQgndUXUdrhkbW/vSDXpIGJ+DNTOSlc0rnjs6OwKl2xJWPLMkPfiWWCLZDNTCxs9vpDUGE66YQlLusf1UZgY8k3sPcppmeisZgQeeO1e+FQi85AzrlVAzhXJoZSmpgykUC+HYkfj0ZFHU9v1j0TFikXZ042jsDGRJZnF5NzZc9NHKVpEy/8aF2GgIRETrKduZjwWeAuKuke39anmfJNs96thSn45JQt62rSVcUPtL3y2YllQ8/9nCXeSJVbcKKHExNsUoWtWf4HW0QRXs7rndFpSRtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mwqbxWy0wnwaifa4iW8+oUpW+rBY53Lj/bH2/GPOVYU=;
 b=GEm8JLWuqH1ZNJQy+bwj7CRe/QKShDFsu5LWEZV027XKz2oysmbM6dpUghNTLOc/p3LEsbB4xDbu+6P4ex6/wENcWqGgFothPo+c+E7P9kIa1bpHq2QJkX+Z+rJ8+Y8JUoznqxMNGxwxNiSBsgyn+ycuZEW/v28KScRB6koXJlLaK00F+toc+zItr6U2g0hKBOB3jgWfCVFaF3w6YC9WFeQnel3TYNec/T9mv4Dust/YPEDHeG/WpMz79R+Oc63TFLVmsOstICHS+cuUfxKZi+rTRisfl69V+9jZVPQzMmUoz/uQsPZ7KhklbQ+n5z0SdAnRO0IQWf0i33hr01W2yA==
Received: from CY5PR11MB6462.namprd11.prod.outlook.com (2603:10b6:930:32::10)
 by PH7PR11MB7049.namprd11.prod.outlook.com (2603:10b6:510:20c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.17; Mon, 14 Jul
 2025 14:11:43 +0000
Received: from CY5PR11MB6462.namprd11.prod.outlook.com
 ([fe80::640:1ea2:fff1:a643]) by CY5PR11MB6462.namprd11.prod.outlook.com
 ([fe80::640:1ea2:fff1:a643%4]) with mapi id 15.20.8901.023; Mon, 14 Jul 2025
 14:11:43 +0000
From: <Prathosh.Satish@microchip.com>
To: <ivecera@redhat.com>, <netdev@vger.kernel.org>
CC: <arkadiusz.kubalewski@intel.com>, <jiri@resnulli.us>,
	<davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<linux-kernel@vger.kernel.org>, <mschmidt@redhat.com>, <poros@redhat.com>
Subject: Re: [PATCH net-next 0/5] dpll: zl3073x: Add misc features
Thread-Topic: [PATCH net-next 0/5] dpll: zl3073x: Add misc features
Thread-Index: AQHb8bDCb7Rox8U0ZEyddiyYQWAYiLQxrxAA
Date: Mon, 14 Jul 2025 14:11:42 +0000
Message-ID: <bc221fdb-d674-4111-8bb7-e2eadda60b35@microchip.com>
References: <20250710153848.928531-1-ivecera@redhat.com>
In-Reply-To: <20250710153848.928531-1-ivecera@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY5PR11MB6462:EE_|PH7PR11MB7049:EE_
x-ms-office365-filtering-correlation-id: 7f594d4e-767b-4e3a-4b32-08ddc2e05c1e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?Ui9QanBySlhHMEhscFpaQXQrbWw5RXlHNkcwUWdsenZyMnBYY1phQ245YlR0?=
 =?utf-8?B?UkdieW1BcUFBK01lc1QzNGV4ODRReXR0N2hYRW5XQ3JqLzlGNWpUUWEvSnlT?=
 =?utf-8?B?dzhJRndNM0JQTlhxeFhkL2JCQzJDeS9ob3JDR2VGVnBUUjEzb3REQlJzazlB?=
 =?utf-8?B?aGJXREMwZnBmQWdxb1piYmpEazh6UWFJU291bHdMUHNRR1ZORFM1MEtkck9L?=
 =?utf-8?B?TzFXN3FmaDYwWkZLR09FMDlHdmorMTkrUFNtN0ZTMFFNQWxya0FCRXNHL0tj?=
 =?utf-8?B?am8xM1RLWEQvVG10cVVnWHUwbzB2MEl5L0lhSXlDR3NSM1BFZStGdjMyL25p?=
 =?utf-8?B?MWE0M0t4djVjcHcxd2M5NHBqYjArY2xGUm1hdEFQdkduZzNwdnZDR21Zbzhn?=
 =?utf-8?B?aTJES2ZldDFwNnhRZGFocnR0bW41WUt2UzNWZHJEWEk3cmVBSzRDcGxHRjJ2?=
 =?utf-8?B?aExKRmhEeEpaZFBlV3gvM0QxZ1JXbTZkeEtuV3dHSVAzdGFxdjV4Zzc4OEpC?=
 =?utf-8?B?UzJMSGQzMktXSjdEZ3JrKzhMdDJCV3UrTGtLWUxlYXVxY2QvSFFJb2tYVjhZ?=
 =?utf-8?B?dkdhM2NORGJSV0pCV0xYcm5iUzBLRWZ0YmNDNUhFazRZZUNMR29QU0pRUHJY?=
 =?utf-8?B?L0gvUmNRYXoyaWd1c2FsL0lLcnMxcEhOS0piZ1hLTEV1bWl2T29FanpSQ0xF?=
 =?utf-8?B?SG8wcG5EbEJtZDVuNS9hL1FOZDNpM0kyTHVTWm1SL2lXZHRYV3R0SDRzV0Rz?=
 =?utf-8?B?MkRmN09XMjFKVkFwQ00rSjJWd21lQXpQUGdqS3Azc3lBWjJFUmoxVFFKYnBw?=
 =?utf-8?B?UHpTcW96U1NMVVQ3bWR0M25OL0R5QkVrRTdIM1RXYzlLSDBtTXRwV1dobjg0?=
 =?utf-8?B?anNWYXhodzVNQUF1SHJXdU44VTFGWWVCK2ZUd1pBdFBIWVVoelVBR1hJeDVa?=
 =?utf-8?B?U1UrNFpLNTRHQTlhV2NoeGE1cHZEQm9ydnZoWHY5U05LMmlTT3ltNEVrL1Nk?=
 =?utf-8?B?aGJyRVZzNTVkTTd4bGt0K1crR0d2TER4YWwvVFRPRld0NFJoei84K1lFbXFs?=
 =?utf-8?B?bmwzM0VSVlVOcGVPcEJveTNGUnFwRU8yVWhDamNNK1JwM3BzU3ZVc2gvTE1M?=
 =?utf-8?B?V0pZRzMvSXNINkxQSEhOcVNjS2xCMjBDVjhBdlhsY0d6SnFxL2dYb3dKblRG?=
 =?utf-8?B?b0JSbjE0WTQ5VW9KQllLMW5MQVk4Qzl5eDdra1pUZWdUbGNDdUhYTm9EMjRx?=
 =?utf-8?B?UGlRWjlLV3U2djV1VWh1V3Zvd1c5UzcyZHVrZk42am1zeE00WGlmVXp2Vjhk?=
 =?utf-8?B?V2RuakpOTXdZaVJyUGNpYzd6MUhXTDNYaDEwV1gwQVY4MGVyQkdodmtGVHVi?=
 =?utf-8?B?aWlHcCtqRG9jVCsxZFRiMnUvRG5qV0IvQzBwaFVPR1Q5cXM3Z1dUVWx3aGJM?=
 =?utf-8?B?KzlOZzBuQ1liM3UySnNUTkdTWVpmK2MrTHZycFBHcmtkaDJQV2RqS1gxNE1a?=
 =?utf-8?B?N0p5dURRd3JsRk5zb09oZkhOc1V2RkNMbHc5WUJpTjc1QnlaTGRIVU1OaVdh?=
 =?utf-8?B?MnV5bXlDcFdUM3Vwcyt3UHkrbmZHWjlYcWNZUTl3TGhzRFl2RktYdEI1QVN0?=
 =?utf-8?B?ZlhpbHRmbjM4djAyUUZsVkkyMjdKNTcrVzlwdEUvUzFxQmQ2V2tWODVGTm9i?=
 =?utf-8?B?S3VKb2laQU1Nb0YybDJScGxWL3h4RWY5bEk5WE4vTFEzbmZnZXJiN2M0ZFJ2?=
 =?utf-8?B?K0huekJOYUxZWXJpRzZNdURBTW4rMi9yRXlucUJhNThIbUkwbVZVNEJHUEhV?=
 =?utf-8?B?TlpaVHFmSFFpOVhwOVZQWkFVSWJLTTBtWm0yMVJSOG9JUDM1ZnJZN3BvdFZo?=
 =?utf-8?B?WjhxNHhsVVpmSmpEaU4zT0tMeUFmSHRlc0o4NnhtZi9idCtSVzF0Q2FwWXdh?=
 =?utf-8?B?N0FDTXpDbStsWExzS01zeUNpcFg4K2dwNnZjTUFJYS9md3Q0NFVyQkxDczRo?=
 =?utf-8?B?ZG95UlNBVWRnPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR11MB6462.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?VU5IQkkvS2FyRCtJRXd2WitkaEFTSWlGWkpFY2pldFVYWlVZRVJMZHE0RkFz?=
 =?utf-8?B?REZhcDBJaXpyWTcyK1oxVG9wWlBLbnRNTTc0allSNGhtcmQyMi9iWlhPUUhZ?=
 =?utf-8?B?MFRQajJHNllXWDBkRHdac25TMGg4czBsRTlDYXhUNk5nUTE5RWZlN255Mmpr?=
 =?utf-8?B?UFZYa1NsVEdUMVNETnp6Q0dPdXpibGszckcxK2w5UXFTejBSbTBxK0p4N3VG?=
 =?utf-8?B?L1NCSjhoZEtyVnVQbEVaVG43Y3RXZVAzMEJ3eTI2ZitCUHN6Mng0MkZtaE1G?=
 =?utf-8?B?TmU1OHdib3JJeXFrYjc0dnVHWDlSRXJrRkd5SVd0ODF1ZUdjd25leVFBWkVx?=
 =?utf-8?B?VlhaRUZ5MmpkZ2pna0pmUnRWNi9YSkQ4RC8xZ212OFBaOUdaUGtyMGYyWk1k?=
 =?utf-8?B?NEpjdjRsUU5KdDFUQ1FzWTRGM3RocDk4S1hvMHJkVCtxblFSMFYxSFU3TE1H?=
 =?utf-8?B?Q2pVRHdPeENYRGdxVGtRdDk0N0NUZytpUG9zZDM5MUpMZDFGeUk1N0xVMWwz?=
 =?utf-8?B?TlRqeTdqTlBCMUZ4Mm1LODJ2RURHWWF1eERUempVZGFVQjJCOXRyOWdOWVVF?=
 =?utf-8?B?Y1lQS1orTkJXZmVCeGRXRkM0NU56b21JNTVLZXBKZmdDbmJJeDlkZXVBV0Zt?=
 =?utf-8?B?MVRHa0hHUlZScnlCR0lMWXE2cU42Z2EvdklLaU9xMlVhOWpwVFgwaVA3Vk1N?=
 =?utf-8?B?clgxYnVOYThDK2xBTzhqeG90ZTE5eEpBTTdZbzB6T3U0bTZ1UnJiN3FVaUd4?=
 =?utf-8?B?UDNaRHFHdk5XNW5QRy95L3YzdlNVYyt2SVQvRjNsYXpQS1ovV3VqRk1wc2Ex?=
 =?utf-8?B?N0pNeW5NZHRZTnl1VUN5MmJaN3doV2w5OUFMSkFyQi85T05JNnpqbXBqV05I?=
 =?utf-8?B?S1IxT0oyaUFGdkxNSE92OVNMMmdLM2JXWm1jbUc1ZXZRRlRDVW40NzFycFFn?=
 =?utf-8?B?VFp4WmxoVTVoYUFNRk5nQnhLRGxtRTEyZTY2VklNQlI3MFd2bzU3N25PMGpH?=
 =?utf-8?B?Zm8zRi9adzFTOVpOaTBjbTJUbUUzRjZtSXZJMzB2dDFKdjVBL2F4djdLeEpH?=
 =?utf-8?B?aCtwZzVSVkZEY250Z0I0L3BWS3lxb0ZMM2duVzdXRjdxbEh4dC9Lclc5dFl0?=
 =?utf-8?B?aXNJRUpCdTBzeHV5V1AweWR0NUxUVEl6aUVleDVSR3hOU3NiazdMUWsvQUY4?=
 =?utf-8?B?L3RmZFcrZ24reklISGRGZVVLYXZjUHcyMzcrcVlJdnEvcmRnQ1h4d3ZLWndI?=
 =?utf-8?B?UmxmZnU5UHExb3pqUlo2OVdnYWIwckZaZ1E2NU9zdzdVY2xoVzN6dWdsK3g4?=
 =?utf-8?B?TFR0R0lmSjNac3dlZHZ5M0NuV0dSK1A5d2JjL3VkT1VacWFIRWs1L2hYajV0?=
 =?utf-8?B?SmY4ejhiUTllZ0R2VW92aGhIRWphbHJXV1J5d25WLzhQVEJVejBrV2c5VG0v?=
 =?utf-8?B?aXNDbVdFeU1jVEdGZTdQaXpOQ1VMQVFyRG9FY0pFSnl2RVhXOGNxdEpUV2hx?=
 =?utf-8?B?Yi80WkxQWW9tRzB5WDNjTlYxeTdmZlJ4eTVkaWROWnZXZzBLVTJnVm9EVFN3?=
 =?utf-8?B?V1Z6OXpuL0FEZUNIMVpsc0kyaU9WUUdwejV3RXFnSy9QWnlLT1pmOTc5RVZO?=
 =?utf-8?B?emNlVkJOeEhuS3lRRnp2blNQaFNiT1lGSXJ6ejRjSXNXK0YxTXhlQnVCeG52?=
 =?utf-8?B?ZVQ5V2JGSVlkY0txSnFIVXptenNycDNKdlZJNjBWSmRaRDFJdlpveTFBZk5w?=
 =?utf-8?B?V2tLRTlwUk9nR3J3WjRtWHhzN1BTa0hpQVJGYkpMT2s5eXROSktkSGhlMG5G?=
 =?utf-8?B?NXhHbVAvZDB6NmQrQk1pRnZQeHVlanRaR1BsVUdObTQydFJxOWd6WEMxRnlh?=
 =?utf-8?B?NGlFN2t3RXVxYkNvaVFqOVcvd01IQ3Q5RmhNSHJBWDhFUW81bGRXdERTZGNO?=
 =?utf-8?B?UHkrRzFBRGtiSUdsK1hqYm9aN0p3ZjFuYmFmT2Zkbm1CQXNIckUzMGw5bHdi?=
 =?utf-8?B?Si9ManVhbTVtV01wOE5NZGUrVC9GaDRqNGFjZm8vaWVwSE5Xd2NNN2grM01U?=
 =?utf-8?B?d3NoWlBvWW5UekMyYzNabWVzdGw5R09PaEpLejlsTlFLc3FUekNMWE1WSHIy?=
 =?utf-8?B?eVV2dThYQzBEWXVlQzhDUExtZ0FsbjVlRkhDZWhXVjlJdWhUdzVVNEhuV2lB?=
 =?utf-8?B?ZlE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <24833D10EF81CE438F4202EE0F3BE20E@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: microchip.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY5PR11MB6462.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f594d4e-767b-4e3a-4b32-08ddc2e05c1e
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jul 2025 14:11:43.0361
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Th9+C49VAAZIA5Pv8AvqyohcPw5fdDjZIJvrIxC9LxMqYfmXul6tdqgDgv19gemJNwt4+KJ/zK2ZuGJSyvM8hXwczgku0JT+8tkye8TMpqc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7049

T24gMTAvMDcvMjAyNSAxNjozOCwgSXZhbiBWZWNlcmEgd3JvdGU6DQo+IEVYVEVSTkFMIEVNQUlM
OiBEbyBub3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBhdHRhY2htZW50cyB1bmxlc3MgeW91IGtub3cg
dGhlIGNvbnRlbnQgaXMgc2FmZQ0KPg0KPiBBZGQgc2V2ZXJhbCBuZXcgZmVhdHVyZXMgbWlzc2lu
ZyBpbiBpbml0aWFsIHN1Ym1pc3Npb246DQo+DQo+ICogRW1iZWRkZWQgc3luYyBmb3IgYm90aCBw
aW4gdHlwZXMNCj4gKiBQaGFzZSBvZmZzZXQgcmVwb3J0aW5nIGZvciBjb25uZWN0ZWQgaW5wdXQg
cGluDQo+ICogU2VsZWN0YWJsZSBwaGFzZSBvZmZzZXQgbW9uaXRvcmluZyAoYWthIGFsbCBpbnB1
dHMgcGhhc2UgbW9uaXRvcikNCj4gKiBQaGFzZSBhZGp1c3RtZW50cyBmb3IgYm90aCBwaW4gdHlw
ZXMNCj4gKiBGcmFjdGlvbmFsIGZyZXF1ZW5jeSBvZmZzZXQgcmVwb3J0aW5nIGZvciBpbnB1dCBw
aW5zDQo+DQo+IEV2ZXJ5dGhpbmcgd2FzIHRlc3RlZCBvbiBNaWNyb2NoaXAgRVZCLUxBTjk2Njgg
RURTMiBkZXZlbG9wbWVudCBib2FyZC4NCj4NCj4gSXZhbiBWZWNlcmEgKDUpOg0KPiAgICBkcGxs
OiB6bDMwNzN4OiBBZGQgc3VwcG9ydCB0byBnZXQvc2V0IGVzeW5jIG9uIHBpbnMNCj4gICAgZHBs
bDogemwzMDczeDogQWRkIHN1cHBvcnQgdG8gZ2V0IHBoYXNlIG9mZnNldCBvbiBjb25uZWN0ZWQg
aW5wdXQgcGluDQo+ICAgIGRwbGw6IHpsMzA3M3g6IEltcGxlbWVudCBwaGFzZSBvZmZzZXQgbW9u
aXRvciBmZWF0dXJlDQo+ICAgIGRwbGw6IHpsMzA3M3g6IEFkZCBzdXBwb3J0IHRvIGFkanVzdCBw
aGFzZQ0KPiAgICBkcGxsOiB6bDMwNzN4OiBBZGQgc3VwcG9ydCB0byBnZXQgZnJhY3Rpb25hbCBm
cmVxdWVuY3kgb2Zmc2V0DQo+DQo+ICAgZHJpdmVycy9kcGxsL3psMzA3M3gvY29yZS5jIHwgMTcx
ICsrKysrKysrDQo+ICAgZHJpdmVycy9kcGxsL3psMzA3M3gvY29yZS5oIHwgIDE2ICsNCj4gICBk
cml2ZXJzL2RwbGwvemwzMDczeC9kcGxsLmMgfCA4MDUgKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKystDQo+ICAgZHJpdmVycy9kcGxsL3psMzA3M3gvZHBsbC5oIHwgICA0ICsNCj4g
ICBkcml2ZXJzL2RwbGwvemwzMDczeC9yZWdzLmggfCAgNTUgKysrDQo+ICAgNSBmaWxlcyBjaGFu
Z2VkLCAxMDQ5IGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pDQo+DQo+IC0tDQo+IDIuNDku
MA0KPg0KVGVzdGVkLWJ5OiBQcmF0aG9zaCBTYXRpc2ggPHByYXRob3NoLnNhdGlzaEBtaWNyb2No
aXAuY29tPg0KDQo=

