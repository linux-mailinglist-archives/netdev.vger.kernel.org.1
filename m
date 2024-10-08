Return-Path: <netdev+bounces-133131-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B28E499511D
	for <lists+netdev@lfdr.de>; Tue,  8 Oct 2024 16:09:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CC6321C25078
	for <lists+netdev@lfdr.de>; Tue,  8 Oct 2024 14:09:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C121A1DF98B;
	Tue,  8 Oct 2024 14:08:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="CEVxFvfG"
X-Original-To: netdev@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2078.outbound.protection.outlook.com [40.107.102.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 048CD1DF977;
	Tue,  8 Oct 2024 14:08:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728396537; cv=fail; b=Jlu4/W9CiUM7PqW8Dza1tl8PrfYQdgwcRb/9dLjs/JR6cmOELCLmD6JTKRHkSjFEkVzE+GXir0TphWWhaOvbTpndxthZ8hOId++PR8M9xZEHH4cMBhY/z80iPzFBUl647ppLKvJNA8JWLe9vjm4IR31F/bzERw8bCWbFHlSdpak=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728396537; c=relaxed/simple;
	bh=xrCReafkqGVYoFHLq3+MBsq4NAlnjgZeeQs3MARiq+o=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=WRotWNAytAd+7YMxSd+Rm3JPVCtAlfebG9pdNzJyi7ysK5cmBKoYj7+qXXjfLavb9Kynkmc2P+Ac2LTdgVo0X48Y7KMV09ouDPqN8eahtxBhk0ZuWgStlQ5ca/WbQrkhmxFqpr/uZQDrmG8u9nAG17Y0eaJ5UgAzx5F2oFEzUW0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=CEVxFvfG; arc=fail smtp.client-ip=40.107.102.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Nw3P8DWOhj1YI2GLmvXXEQPET3j1Qtpdgxk8szySmUCyz0b4gcjHh3tT2Slm7zF35OrUOk2Ut/bbNI/p3jjMX0Dxtf7Zecw6Hl6gYKrGGdgAULVfb39xjy5fXBqv7iK2iG25egTJIP+UoY80hwyTGylciUsHuObPlaa8v6z4sndMK6x2uKffE7qUJuVOH1W9Kxm8JgAHfzNBUJ954dNKY47MtCZSWOz/TOgC8F8gXmEytqAMWtfMc1inEkT+TXtTH6cV5JCBMmeyubG8zBsoZojFNELQAX/1cA66dvlZuuqbYu1RfLAvMgQzmwHy7/RUVvuRe1IL7qE6tGA9NEjOJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xrCReafkqGVYoFHLq3+MBsq4NAlnjgZeeQs3MARiq+o=;
 b=eAOXLpcPMXm57HAjDjdP2J6ujuJmVtFifCh0qeckOf5baq+YA9eF7muwQj6xOYBaFp4+1tNRClsgQ2vG3lv6CXD5GdFrr3Za5mFcTni9RKccKPApAuS2Uz3VI7odiSuGdCZeZV7XZmGEUscDG04d6dkhJNlHbahwAiSHE+3A9rlzGHptcgkS4xes/l+bzudxZPoFquPxTfsSnQWEUsO0Q21oYO+ID+xQ7FmSpSBrmZOGA2EXbpEA5HdeJGVJnFg6omN/mVQMKSfsq1F0n5gBKvpqVQ3BThmUmwyEosaNDzKjhI/NmBg4yUKqNJn2ifKo6bnK3xBujJV0xxHM0u8Y8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xrCReafkqGVYoFHLq3+MBsq4NAlnjgZeeQs3MARiq+o=;
 b=CEVxFvfGnmvzOyVYY7l2Y0ak5rVHhM/QhaYMr1LcECsHUTDmfHvkACbNDTW/DHM8nkHoQtNHRT01nolGgnCUL9HVQoTaFqpi6+gZnHxLV6DRYsO119Dm1j2Wlc0l+9uFgrCfKgsnPXW+ZcK2x2faQkLD6aZ6kLerKQw6ESrESLE=
Received: from MN0PR12MB5953.namprd12.prod.outlook.com (2603:10b6:208:37c::15)
 by MN0PR12MB6270.namprd12.prod.outlook.com (2603:10b6:208:3c2::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.16; Tue, 8 Oct
 2024 14:08:51 +0000
Received: from MN0PR12MB5953.namprd12.prod.outlook.com
 ([fe80::6798:13c6:d7ba:e01c]) by MN0PR12MB5953.namprd12.prod.outlook.com
 ([fe80::6798:13c6:d7ba:e01c%4]) with mapi id 15.20.8026.020; Tue, 8 Oct 2024
 14:08:51 +0000
From: "Pandey, Radhey Shyam" <radhey.shyam.pandey@amd.com>
To: Kalesh Anakkur Purayil <kalesh-anakkur.purayil@broadcom.com>
CC: "davem@davemloft.net" <davem@davemloft.net>, "edumazet@google.com"
	<edumazet@google.com>, "kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>, "robh@kernel.org" <robh@kernel.org>,
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>, "conor+dt@kernel.org"
	<conor+dt@kernel.org>, "Simek, Michal" <michal.simek@amd.com>, "Katakam,
 Harini" <harini.katakam@amd.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "git (AMD-Xilinx)" <git@amd.com>,
	"Joseph, Abin" <Abin.Joseph@amd.com>
Subject: RE: [PATCH net-next v2 3/3] net: emaclite: Adopt clock support
Thread-Topic: [PATCH net-next v2 3/3] net: emaclite: Adopt clock support
Thread-Index: AQHbGMqHh7K04uxr5UWxDSmMFcENS7J8NoOAgACsS1A=
Date: Tue, 8 Oct 2024 14:08:50 +0000
Message-ID:
 <MN0PR12MB5953C52D657847AD5F089B90B77E2@MN0PR12MB5953.namprd12.prod.outlook.com>
References: <1728313563-722267-1-git-send-email-radhey.shyam.pandey@amd.com>
 <1728313563-722267-4-git-send-email-radhey.shyam.pandey@amd.com>
 <CAH-L+nMoKyY26XD+oLXD3-JWGRW91=FdRFQSazKJEM_XxRk_AA@mail.gmail.com>
In-Reply-To:
 <CAH-L+nMoKyY26XD+oLXD3-JWGRW91=FdRFQSazKJEM_XxRk_AA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR12MB5953:EE_|MN0PR12MB6270:EE_
x-ms-office365-filtering-correlation-id: 3d7c12fa-74a4-43a8-1e51-08dce7a2bc52
x-ld-processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|7416014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?anFRTkFrenNlS1gyZVZEVjBlTjRxdGFqV2dHaDAxcEk4OGpLdDJxSXhOWXVS?=
 =?utf-8?B?cm1ReDF2bHZ5Uld6T2ZZTFcvS2svNVZTK2VXMGZuNzRpRzhJaHhoTG1MRjR0?=
 =?utf-8?B?eHZyZ2Jwd0NkSGFqNk9JdGJLcFI4NVEzOGJyV2pnYXZhODRrN2FZSkZyRHNk?=
 =?utf-8?B?TFVUejIyMmVkNGdvN1dSMlQxbERIVFkwTHVzejl6UHRIOXo2aTVyalowd3JM?=
 =?utf-8?B?Z3V3U3VxOHhWMUp6UDVJdmdOU0lWMXQ3N0ZjcEsxT0RKbnZhRXE1b25Uckdz?=
 =?utf-8?B?djVUNzhTNmxUUmxCT1h1cm5WUjVvOFEvSmh5cFhPTUtVSXpqYmdTQmROeE8w?=
 =?utf-8?B?ZUxqTmJ5d3k2cEc2dkorbWdweWJFcGlnUDFyYUlXeHdMeStGOTBacmhhVDZZ?=
 =?utf-8?B?TEsvT094TU5SVGxqMkNmSmVycVNaVG1ES1gzTUk3eFd5L0tkM3ZGRlpSUFNN?=
 =?utf-8?B?dHgwOEtuNWw4ZUJLSFB1RFczZVBTTWoyZjhzR3ExRkw0Yis2ZFNsQnp2aG5Q?=
 =?utf-8?B?c3dzbG14WnE4ak5UaGU3L3l6NHFySlpNdGczOENmZG1halBoTlRndHRxOE5S?=
 =?utf-8?B?clc5VFZFTGRHczdndjE0dHFrTXpWaFVVQTdlaldya0pPQ0V2TGdsTUZScWxE?=
 =?utf-8?B?clRoMnloaFdxd2xuR25ENC9oTlpyR2VjMndBL2ZzSkkvVDV0dmVnNzg5aXNT?=
 =?utf-8?B?TzJBZ0xOSFJBVmxOd0lVODllNmhLWmJmLzNGMEJQSGhoKys1RXVNQU5USWIv?=
 =?utf-8?B?RitTRldtbE9WNmdoaVhjSy84SWFjRnRJWng5eVkyYmlXVHp1bXljR2RlMnA2?=
 =?utf-8?B?R2Jkazl3eTBsZXRoZy9YZENFUzFIbTNDeDUyRWZlQk5RRElpb0lJdVg4eHdZ?=
 =?utf-8?B?YXBLVXQ4Vk9mZ045eXRWSW9LbWc3eDlJcHB4SDh4c1ZSZnU3Q2x6bHdEdkJa?=
 =?utf-8?B?VjZMOVBiTTBraGVOMHZGNmlBc2dockpselcrbldKbVNNVWJDR3JZczg2alh5?=
 =?utf-8?B?UXJQa29NRkJpb3BFZ3FTTjQrR2JGWGM2WlprbkpCN2Zob3kzQVZNYlMrekZi?=
 =?utf-8?B?ZmZHeS9taXowN0lOS21nazBQdVJ2UDRyUVBTYyt0eUg4UElQeW5ZR1dDOS9k?=
 =?utf-8?B?NzhMcTFjM0NIL0dqbXpNY1l1M1BjKzFrNUF3aERVTzJ0QlpBNHpoZ25WK0U3?=
 =?utf-8?B?WnVPdjcybmRBcVljb1RvZk14ais4UVQwSXcyUTNFQ2hKVlFLbjJBQllCRFZ0?=
 =?utf-8?B?eDdrYkZYNitZWWFuSVZvNWtsb1VhWHpXODNNclV5QzV6RCsxYm9UeWc1MFpj?=
 =?utf-8?B?emRTemQzdFNBYStHVXRwL2VNYTRQL29SRHYzejZNZ0UwMEVPM1hIbUpQMGFG?=
 =?utf-8?B?VUJBNkFxdkNiL1BCYTVqcFpTZnBPNFJvRDhnMzhjdXJzNE9RQWFIQ1lKeUd4?=
 =?utf-8?B?d1IwYUhiSFZKTXBMdnhvc3VWUWxFR1JtbEM3L2FVNENFOHg4WVFaYkhyNG9x?=
 =?utf-8?B?K0ppUDFjYVk5WTIzNWZRVncvRGpCQTZWcm9COXVRbVY1emRJeXZyNXBmOUJX?=
 =?utf-8?B?VXh4Z3UrdVFzdmVLajZQZjhnUXBQVW9SeGRvMmJlUmpIeGtTZkwxcEdpNG9T?=
 =?utf-8?B?Qm80d0NHOFNBc20yWnBpOWhTb0hDbGRuUEczM3pvNTlSUnlqSXpLTVYveldM?=
 =?utf-8?B?WktVVThNUU43L2FlL2lqOEl6WXdzcC9JU2thQzl6S3R4a2lSTHVjMzlXclZa?=
 =?utf-8?B?emhwbjVMeTZFRVREZjg5eVUzUm1tZ3Q2cGZwbklpRjZGM1VIUHRIR0ttRlg3?=
 =?utf-8?B?Z1BKenVES0dydFFQeTMvdz09?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB5953.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?VXdTS0J4WFUyRG8vUklwRzNtUENDWnF3RnViWkRnTS9MNUcxbHRiRXIxVmw5?=
 =?utf-8?B?dXBabGl6alJYVlViTFNUeDByM1FreUpuc29sTGlPbndxK3hHZC8zRjdLWTVU?=
 =?utf-8?B?cldpOFRwNzdVTDlyY1pxaG9kVkkzSXorRmNZQWFSVmNEQVIvUHR2L2N2dDBO?=
 =?utf-8?B?TkRaMktEeWVxd0szUXRGb1VVbGdOTjdpVDVOUEcvYTI5MXRYRXdyeWxUQnVr?=
 =?utf-8?B?L1RnMDJ5NTA0RGxRc29NaG1vQkd1VW55QzhxZ1BIZVNrS25DWnZSdk5IYjJI?=
 =?utf-8?B?Y0U4ckhuWEdrQ29DUXkveFNTeXhUYWVRcTgzOTRDeDdlWWU1ZU1QOEpPZnli?=
 =?utf-8?B?NTZ4d3dYNmw3WjZGWDRJaVN2UmtlN3ZFWmZMVUpZa2dJV250NWUzUGNUT2hW?=
 =?utf-8?B?RG9tY2xTYW9tcWtTRFRNNzJjQms0OFhWSUwrb1d0Q2ZFdUJTdElDMHlUYmgv?=
 =?utf-8?B?dzkyVWRKdXNWMGFoYklyTURQVTUxem5TbSt1R2g1YXMzc1ZzeklkdG5rUWxY?=
 =?utf-8?B?SVlubmQ3Q1VMNjFtRlF5aGFUYnVyWkQzYllNem02MVBYbGp4MXRxOCs5bVF6?=
 =?utf-8?B?QzRNS0Z6MDJvcVZtYzNtUjM5aElDOFJBVFI5K29yQWlhZ0lXbFcvdUNDMEZn?=
 =?utf-8?B?T3ZHK3hiREdZeWtRa3B0dEh4em04dzN2SWlDRjkvamJ0N0ZKdFFabDJLZ3B5?=
 =?utf-8?B?Vk1hYTZ3MHBJVytTMzRTWG9ocWRVNFJqUS9WSm5aeEt1eW1uWFlycHlvNXBJ?=
 =?utf-8?B?bHNsY284OFUrY3R6LzJOYkRNUkgwQ2Q0UjgwRjVJand6eVpZbm44QU5WM01x?=
 =?utf-8?B?cUtxR1U5MXMvVmZTSmhPK3E3OFRaRnRzWmkrazA3YVFMUzlCMFdSNDJLYjM1?=
 =?utf-8?B?bFNYZ2hyWUxCVVBQR3Z5SG83WUJXNlpVanpvZ3RzdldJbCtHZDA4Yi91OVpN?=
 =?utf-8?B?Y1hoYzlsTEZsVzJES3V2WVB5MFV1cXMwNG1jc2pidmRjZ3lLUHllSWpYdHl2?=
 =?utf-8?B?QUFLRW5MSEhIY3N4b2VTQXVINFVGY00yZ3IrdVFGMGYvVnJNeW9KeUE2Yzg4?=
 =?utf-8?B?VUhPd0lMd0FjYmMyL1JrdmQ0V1ZhdXNtT0trQVFSTjcxbWJUYlZnQmEyQnVn?=
 =?utf-8?B?ZGxDTXBmY2dYcDcxMmNKVk15Qnp6NU8xMGZueVB4Z2pWYitCZkpKejhjb3Qy?=
 =?utf-8?B?SFRNekcwdjFCQThDM0NYOC9jK2xWbzI5ZkUvRngveHkxYm1UZ3JTaHh5cEo3?=
 =?utf-8?B?dmVnVTBnbHNzOHk5WHEvdEF6VU9JRksvWGEvNnZ6VndhQUhkL2g2OG1laGtE?=
 =?utf-8?B?OWZ3MVZLYStvQm1qTDNrL2NxVlpUcWMyR1JzSlF0Z0R0eThkU2pNYksyeCtN?=
 =?utf-8?B?YzZkTWFVWDN2TmJSS2hFQWVNUjU0QmhqbE1kRnVjR25mWWxWbFg5OE1Cak90?=
 =?utf-8?B?ZTdFTktNZTNMdkVVczR1SmpEZGFFWjYwMEVEM2k0eUNhOTZuV0xqWWJVU09V?=
 =?utf-8?B?QS9NN2hqd0gwRkhNTG93ZUwyRXhvSEtteTB2SkV5QjdWUTFUQXRqYWlHNG9w?=
 =?utf-8?B?YnZ4MTNMelZvNGpmWnQ4N050OTJtTjlSM1ByUTRZb2xpa0I0ZlZ4NHU5T0Nu?=
 =?utf-8?B?b3pMT0d5NEJjQ0pmMC9YKzVubWpKQ0ZUbzJORmVBNGJCYTJsWW8wK3A1dG9p?=
 =?utf-8?B?em5XdFZORHRjaVdPSmdKRkdQa3hhRTF0bHkyaWZLaWZmK0xKWmJQMWE4L3pk?=
 =?utf-8?B?K0FlUzlKTkgwS0dJMXRIVkFxS0R3ckQrMEpBTFZIaFpudUcxYTFhTUEyeE9w?=
 =?utf-8?B?RUx5Q1NFam1FMENrUzhqVUM5UjEyODY0dWthdWVPK0IyZUxnK0xUOVNidVly?=
 =?utf-8?B?R1ZNcjNQdHZKbGVQVjc1akViUE9EZFhPQW54VFhDY2hhUmxCNU1rRTBDVzAw?=
 =?utf-8?B?aDdZTDJLYkw4Q1J6emVnT3RTMkNldFJ0TDZNL3dQb01VVzd6TkRBR3NPS1hJ?=
 =?utf-8?B?VkNGVGRXbTl5T205Q1M1UHFvYnhDRWU4K0tLYnljSWRpQ2puL3BaWFVRNE1J?=
 =?utf-8?B?bExDdDYvN1Z6YXBzUTViem5DRGZYZlpNTGxHbTlhcFMzZXpaUmJRcEl3dVpa?=
 =?utf-8?Q?Ow1Y=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB5953.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d7c12fa-74a4-43a8-1e51-08dce7a2bc52
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Oct 2024 14:08:50.9697
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bOMtSahrj+qKaA5YgaKUzWNJU+pCil4vINgMZt/WlgAWCBo/rfBcQOpTI06MTKwA
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6270

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBLYWxlc2ggQW5ha2t1ciBQdXJh
eWlsIDxrYWxlc2gtYW5ha2t1ci5wdXJheWlsQGJyb2FkY29tLmNvbT4NCj4gU2VudDogVHVlc2Rh
eSwgT2N0b2JlciA4LCAyMDI0IDk6MTIgQU0NCj4gVG86IFBhbmRleSwgUmFkaGV5IFNoeWFtIDxy
YWRoZXkuc2h5YW0ucGFuZGV5QGFtZC5jb20+DQo+IENjOiBkYXZlbUBkYXZlbWxvZnQubmV0OyBl
ZHVtYXpldEBnb29nbGUuY29tOyBrdWJhQGtlcm5lbC5vcmc7DQo+IHBhYmVuaUByZWRoYXQuY29t
OyByb2JoQGtlcm5lbC5vcmc7IGtyemsrZHRAa2VybmVsLm9yZzsgY29ub3IrZHRAa2VybmVsLm9y
ZzsNCj4gU2ltZWssIE1pY2hhbCA8bWljaGFsLnNpbWVrQGFtZC5jb20+OyBLYXRha2FtLCBIYXJp
bmkNCj4gPGhhcmluaS5rYXRha2FtQGFtZC5jb20+OyBuZXRkZXZAdmdlci5rZXJuZWwub3JnOyBk
ZXZpY2V0cmVlQHZnZXIua2VybmVsLm9yZzsNCj4gbGludXgta2VybmVsQHZnZXIua2VybmVsLm9y
ZzsgbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnOyBnaXQgKEFNRC1YaWxpbngp
DQo+IDxnaXRAYW1kLmNvbT47IEpvc2VwaCwgQWJpbiA8QWJpbi5Kb3NlcGhAYW1kLmNvbT4NCj4g
U3ViamVjdDogUmU6IFtQQVRDSCBuZXQtbmV4dCB2MiAzLzNdIG5ldDogZW1hY2xpdGU6IEFkb3B0
IGNsb2NrIHN1cHBvcnQNCj4gDQo+IE9uIE1vbiwgT2N0IDcsIDIwMjQgYXQgODozOeKAr1BNIFJh
ZGhleSBTaHlhbSBQYW5kZXkNCj4gPHJhZGhleS5zaHlhbS5wYW5kZXlAYW1kLmNvbT4gd3JvdGU6
DQo+ID4NCj4gPiBGcm9tOiBBYmluIEpvc2VwaCA8YWJpbi5qb3NlcGhAYW1kLmNvbT4NCj4gPg0K
PiA+IEFkYXB0IHRvIHVzZSB0aGUgY2xvY2sgZnJhbWV3b3JrLiBBZGQgc19heGlfYWNsayBjbG9j
ayBmcm9tIHRoZSBwcm9jZXNzb3INCj4gPiBidXMgY2xvY2sgZG9tYWluIGFuZCBtYWtlIGNsayBv
cHRpb25hbCB0byBrZWVwIERUQiBiYWNrd2FyZCBjb21wYXRpYmlsaXR5Lg0KPiA+DQo+ID4gU2ln
bmVkLW9mZi1ieTogQWJpbiBKb3NlcGggPGFiaW4uam9zZXBoQGFtZC5jb20+DQo+ID4gU2lnbmVk
LW9mZi1ieTogUmFkaGV5IFNoeWFtIFBhbmRleSA8cmFkaGV5LnNoeWFtLnBhbmRleUBhbWQuY29t
Pg0KPiA+IC0tLQ0KPiA+IGNoYW5nZXMgZm9yIHYyOg0KPiA+IC0gTm9uZS4NCj4gPiAtLS0NCj4g
PiAgZHJpdmVycy9uZXQvZXRoZXJuZXQveGlsaW54L3hpbGlueF9lbWFjbGl0ZS5jIHwgOCArKysr
KysrKw0KPiA+ICAxIGZpbGUgY2hhbmdlZCwgOCBpbnNlcnRpb25zKCspDQo+ID4NCj4gPiBkaWZm
IC0tZ2l0IGEvZHJpdmVycy9uZXQvZXRoZXJuZXQveGlsaW54L3hpbGlueF9lbWFjbGl0ZS5jDQo+
IGIvZHJpdmVycy9uZXQvZXRoZXJuZXQveGlsaW54L3hpbGlueF9lbWFjbGl0ZS5jDQo+ID4gaW5k
ZXggNDE4NTg3OTQyNTI3Li5mZTkwMWFmNWRkZmEgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9u
ZXQvZXRoZXJuZXQveGlsaW54L3hpbGlueF9lbWFjbGl0ZS5jDQo+ID4gKysrIGIvZHJpdmVycy9u
ZXQvZXRoZXJuZXQveGlsaW54L3hpbGlueF9lbWFjbGl0ZS5jDQo+ID4gQEAgLTcsNiArNyw3IEBA
DQo+ID4gICAqIENvcHlyaWdodCAoYykgMjAwNyAtIDIwMTMgWGlsaW54LCBJbmMuDQo+ID4gICAq
Lw0KPiA+DQo+ID4gKyNpbmNsdWRlIDxsaW51eC9jbGsuaD4NCj4gPiAgI2luY2x1ZGUgPGxpbnV4
L21vZHVsZS5oPg0KPiA+ICAjaW5jbHVkZSA8bGludXgvcGxhdGZvcm1fZGV2aWNlLmg+DQo+ID4g
ICNpbmNsdWRlIDxsaW51eC91YWNjZXNzLmg+DQo+ID4gQEAgLTEwOTEsNiArMTA5Miw3IEBAIHN0
YXRpYyBpbnQgeGVtYWNsaXRlX29mX3Byb2JlKHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UNCj4gKm9m
ZGV2KQ0KPiA+ICAgICAgICAgc3RydWN0IG5ldF9kZXZpY2UgKm5kZXYgPSBOVUxMOw0KPiA+ICAg
ICAgICAgc3RydWN0IG5ldF9sb2NhbCAqbHAgPSBOVUxMOw0KPiA+ICAgICAgICAgc3RydWN0IGRl
dmljZSAqZGV2ID0gJm9mZGV2LT5kZXY7DQo+ID4gKyAgICAgICBzdHJ1Y3QgY2xrICpjbGtpbjsN
Cj4gPg0KPiA+ICAgICAgICAgaW50IHJjID0gMDsNCj4gPg0KPiA+IEBAIC0xMTI3LDYgKzExMjks
MTIgQEAgc3RhdGljIGludCB4ZW1hY2xpdGVfb2ZfcHJvYmUoc3RydWN0IHBsYXRmb3JtX2Rldmlj
ZQ0KPiAqb2ZkZXYpDQo+ID4gICAgICAgICBscC0+dHhfcGluZ19wb25nID0gZ2V0X2Jvb2wob2Zk
ZXYsICJ4bG54LHR4LXBpbmctcG9uZyIpOw0KPiA+ICAgICAgICAgbHAtPnJ4X3BpbmdfcG9uZyA9
IGdldF9ib29sKG9mZGV2LCAieGxueCxyeC1waW5nLXBvbmciKTsNCj4gPg0KPiA+ICsgICAgICAg
Y2xraW4gPSBkZXZtX2Nsa19nZXRfb3B0aW9uYWxfZW5hYmxlZCgmb2ZkZXYtPmRldiwgTlVMTCk7
DQo+ID4gKyAgICAgICBpZiAoSVNfRVJSKGNsa2luKSkgew0KPiA+ICsgICAgICAgICAgICAgICBy
ZXR1cm4gZGV2X2Vycl9wcm9iZSgmb2ZkZXYtPmRldiwgUFRSX0VSUihjbGtpbiksDQo+ID4gKyAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAiRmFpbGVkIHRvIGdldCBhbmQgZW5hYmxlIGNs
b2NrIGZyb20gRGV2aWNlIFRyZWVcbiIpOw0KPiA+ICsgICAgICAgfQ0KPiBbS2FsZXNoXSBCcmFj
ZXMgYXJlIG5vdCBuZWVkZWQgaGVyZSBmb3IgYSBzaW5nbGUgc3RhdGVtZW50IGJsb2NrLg0KDQpZ
ZXMsIGJyYWNlcyBub3QgcmVxdWlyZWQuIFdpbGwgZml4IHRoYXQgaW4gbmV4dCB2ZXJzaW9uLg0K
DQo+IA0KPiBBbHNvLCBJIGRvIG5vdCBzZWUgd2hlcmUgeW91IHVzZSB0aGlzICJjbGtpbiIgaW4g
dGhpcyBkcml2ZXIuIEkgbWF5IGJlDQo+IG1pc3Npbmcgc29tZXRoaW5nIGFzIEkgYW0gbm90IGFu
IGV4cGVydCBpbiB0aGlzIGFyZWEuDQoNCmRldm1fY2xrX2dldF9vcHRpb25hbF9lbmFibGVkKCkg
LT4gcmV0dXJuZWQgY2xrIChpZiB2YWxpZCkgaXMgcHJlcGFyZWQgDQphbmQgZW5hYmxlZC4gDQoN
CldoZW4gdGhlIGRldmljZSBpcyB1bmJvdW5kIGZyb20gdGhlIGJ1cyB0aGUgY2xvY2sgd2lsbCAN
CmF1dG9tYXRpY2FsbHkgYmUgZGlzYWJsZWQsIHVucHJlcGFyZWQgYW5kIGZyZWVkLg0KDQpTbyBj
bGtpbiBpcyBub3QgdXNlZCBsYXRlciBvbi4NCg0KPiA+ICsNCj4gPiAgICAgICAgIHJjID0gb2Zf
Z2V0X2V0aGRldl9hZGRyZXNzKG9mZGV2LT5kZXYub2Zfbm9kZSwgbmRldik7DQo+ID4gICAgICAg
ICBpZiAocmMpIHsNCj4gPiAgICAgICAgICAgICAgICAgZGV2X3dhcm4oZGV2LCAiTm8gTUFDIGFk
ZHJlc3MgZm91bmQsIHVzaW5nIHJhbmRvbVxuIik7DQo+ID4gLS0NCj4gPiAyLjM0LjENCj4gPg0K
PiA+DQo+IA0KPiANCj4gLS0NCj4gUmVnYXJkcywNCj4gS2FsZXNoIEEgUA0K

