Return-Path: <netdev+bounces-183715-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C6E5A91A3C
	for <lists+netdev@lfdr.de>; Thu, 17 Apr 2025 13:13:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 301497A4A60
	for <lists+netdev@lfdr.de>; Thu, 17 Apr 2025 11:12:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2F482376F4;
	Thu, 17 Apr 2025 11:13:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=adtran.com header.i=@adtran.com header.b="M07o7Oyy"
X-Original-To: netdev@vger.kernel.org
Received: from FR6P281CU001.outbound.protection.outlook.com (mail-germanywestcentralazon11020124.outbound.protection.outlook.com [52.101.171.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8F3823716F;
	Thu, 17 Apr 2025 11:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.171.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744888399; cv=fail; b=WzKYr95OC+HO1M6jK2ilhjHXrluTMdhgUOt+L2cvFlrw2D9/kcH18xkpsHK+T+QC7jTvlUXEOPn+EBg8IlehGEeAfbW3IsMvdb1b3dVZnDl7bKB35QWEFp9UAO7tNxQIrwZduOk2FO7w41kkfx7WGnpHVxYDz/8l1Pursm+QLuY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744888399; c=relaxed/simple;
	bh=q4GtU8FGs52YbPBOStdQPkNCtkAdZJg8kXU+8v9Qduk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=iKyvLcQoH58cF/hreB/FGkj6EWPm4xERdaE1f5D1PkROj+LvgLwojB8NNhpHAnwbMQ7GKlutCIsSb0dRVhyzhFlm0r4VqBHOqOnuCP8fRHLvvCF9WL9beYFBoyK3TGbb5ndglZjd2ym2pHr3YQrDdg/3gEBrQyseQ6Q1Bc2Njsg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=adtran.com; spf=pass smtp.mailfrom=adtran.com; dkim=pass (1024-bit key) header.d=adtran.com header.i=@adtran.com header.b=M07o7Oyy; arc=fail smtp.client-ip=52.101.171.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=adtran.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=adtran.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VpMOHQFa1jmijcA/rmj4qpr79I0YucF+OcvRpUSMWj1QREoSIx9Dm/eo0ZpIk50dbSP8qxWhTFTyLg6U9F5mYTEO78gxavfQQwDVFfaRL/jHyutzZXipgcUU6UOlaDSnGpWdxyL8V6ti55YwgphJMWa5d0aGyhLBFgCpemsyCKmGqfm3sYo/hJlQF+Ur7Zq22QRd1OLqM6UHu1unWKj5Es8ZyYCVKo3iilYrOT5SwSPLD0Yhn1uU8ZIcRFu4eCGcpS7jf4uCdFzVKPj8umVPCkOSo59Ii76rQdIeBpxwxvo58rFO3b0QqyCr9LydcgrImA+Y0qCa3sHWNugvU7X+7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q4GtU8FGs52YbPBOStdQPkNCtkAdZJg8kXU+8v9Qduk=;
 b=N9utp4IrSuYR4lZq+zvvEjJx1eS6FMkAuC0xn7RItRyBiAqCsBdZ4IZpbnWslW8A9qsAGGg3p5OyxZHO/96+pUT91AdNBpmLB1OeveoSGt8pBwflLDYZbx+IyIEDjllxogKZKnmAJbX22tu/Cx5e1iWkjUDSVhga9cAH3xg7SRraQAB1Fx1ItRMYXBaRJdtAGAzI6qMoS9dq8WE0yJxoDkdt+4OSVz0XFU95OJ2rVaJctQzpnf5sgZqPewwPWJblyPeiPaopaVH8QTsVgLACBbb76ftgR1+nnDGwuoNDAWovONGTFne9yfe69lJXbrnDERhSoD5bnQoJzPyOGt9VwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=adtran.com; dmarc=pass action=none header.from=adtran.com;
 dkim=pass header.d=adtran.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=adtran.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q4GtU8FGs52YbPBOStdQPkNCtkAdZJg8kXU+8v9Qduk=;
 b=M07o7Oyyj5c1syuDr/4Gr5aG5vAy1k42V0q7cmbV63PNrcku/4QOVsB0mQAXrUyBiIvSUZyeDazS50NICI60aHg1r0njgAgVkRO4KGNN3+0Cjc79i01WICnCB7D9pR2NkYLvXK2w7e7/pJCCi5zGbOsoNmFDIe5ZIX9fZ3jnYIM=
Received: from FRYP281MB2224.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:43::5) by
 FRYP281MB0286.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:5::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8655.22; Thu, 17 Apr 2025 11:13:09 +0000
Received: from FRYP281MB2224.DEUP281.PROD.OUTLOOK.COM
 ([fe80::8232:294d:6d45:7192]) by FRYP281MB2224.DEUP281.PROD.OUTLOOK.COM
 ([fe80::8232:294d:6d45:7192%5]) with mapi id 15.20.8655.022; Thu, 17 Apr 2025
 11:13:09 +0000
From: Piotr Kubik <piotr.kubik@adtran.com>
To: Kory Maincent <kory.maincent@bootlin.com>
CC: Oleksij Rempel <o.rempel@pengutronix.de>, Andrew Lunn
	<andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
	<krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [EXTERNAL]Re: [PATCH 0/2] Add Si3474 PSE controller driver
Thread-Topic: [EXTERNAL]Re: [PATCH 0/2] Add Si3474 PSE controller driver
Thread-Index: AQHbrrvjSWutWTTyyUq4wzGUDmBh1rOmOdKAgAF8GwA=
Date: Thu, 17 Apr 2025 11:13:09 +0000
Message-ID: <3207c04c-cb35-4949-bdc3-e149abafe754@adtran.com>
References: <a92be603-7ad4-4dd3-b083-548658a4448a@adtran.com>
 <20250416143241.73418fc6@kmaincent-XPS-13-7390>
In-Reply-To: <20250416143241.73418fc6@kmaincent-XPS-13-7390>
Accept-Language: pl-PL, en-US
Content-Language: pl-PL
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=adtran.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: FRYP281MB2224:EE_|FRYP281MB0286:EE_
x-ms-office365-filtering-correlation-id: 35fedec9-653d-4a0f-5832-08dd7da0d5c8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?KzZ1RHRyRi94d1E1OTA4VjU2WWhudFhXS2JCQU9sQlEvYUU2dTJxZFQ3T01S?=
 =?utf-8?B?L25SOTBIeVBudS9SSUd6Si9FV0tqdGlmeFFoTFBINEJ6emVvdTRKU0tkbHB2?=
 =?utf-8?B?TzJ6b0c0SFpSVUJVNHpDR0F3QWFXRXJhS3hCOWx6NEFBU01tc2cvVUcwcFRk?=
 =?utf-8?B?ZEl4ekU4SkVVSUNrTnViRlZ5TU53c0dPTlNMNVhHMUhiSU9YZFl4SkJNVHZ6?=
 =?utf-8?B?NXNENUpUaUt3blRrNWNzMlZFTGhlNExwQXhoSFRFNlp6VkkzK0dRYk9Fdjhp?=
 =?utf-8?B?RzZFMTVudzFzMGY2NUIzd3gza2RTcEo2K2dBSUs1S1BRendmWlp5Vjg2UmRM?=
 =?utf-8?B?eXVTbUNSVjk0Vmt1RnFvWkRPcGo1dWxYTGt6TFlyVWNLLzhrcUprSm04WnN6?=
 =?utf-8?B?dXMvK1A1bHVxYituS3hHTTRrVm9QUmtXdFVoUHBIM3BSRU4rNjUvTUlFSml4?=
 =?utf-8?B?NUEzMksxZjdlUEtzOE04dWNiaWFzZkhuZ0lkS1hhNngrSXVLcTJEeVZNYm8z?=
 =?utf-8?B?SHVPUzNiWHFtU0FBTHFCaTA4VFpaTmZyT0VRaXVrcnJPVjMwUGRERmRlR2hw?=
 =?utf-8?B?UFRrdG9PYlBlWXBjME4wM3dPeTV2RTB0NHhPbS9nTG1FY1FLRkZMMWpyNVdn?=
 =?utf-8?B?NFFxSGxwdHAzQk4rTmtwei9DQjA2SGFjOURFUXNXT2FBTXgrN25RRmpKUER3?=
 =?utf-8?B?am11Sm5ycDAxTEpDWlpDVld0VGdxQnkxdElPTHJpUURXRjhQQ2lZZ3VRS1JU?=
 =?utf-8?B?YmR0S1VGZlB2VHJmemlJMlFmK1BsemJFUWk1eHRIbGsycWRYR3luT2MvZDBW?=
 =?utf-8?B?Y2lrczNsT2YyekhxcmNLWkMxWVUwb252VW9td3B3a3BVUlUvaWlkOEFjdmNq?=
 =?utf-8?B?Vm96Vzg2VVl1bmNnbzE1cnEvZUgwYmEvVnY1N296bjFCQkJGUUtaQjlBZk1C?=
 =?utf-8?B?VGZlblV4bEtWM2ZKckJjTVVEVW82MkxkcUhVTkZpdkNuVlIzRjZYRmp1OVNr?=
 =?utf-8?B?LzNTTEZVWTJsdlZaYktva0xDRm5lZWJOMzZ3K01lcUhBa05kN1VGcS8yd3A1?=
 =?utf-8?B?S0R4QlFjUUhpSlZqTUpZWGRRM0ZkczlZdU9nQzgwdXovRGxzYkl4WFIxWCtm?=
 =?utf-8?B?eTFySG9yVGNYZnBPNjcya28wdmlhalRxbEhOcVRnRkNCNGo4OG9GYmtPU2xQ?=
 =?utf-8?B?Z3VlWDA2bjcvV3hNVHp3M05aM09RbTVTeHIrMW1mODhmMDFMMmRWVEFBSG56?=
 =?utf-8?B?VzN6U1JrVllTbjNhRjFYYkZkZkdKSjUrTE1LS25zdkFFN0YxczRMUzRZTEcz?=
 =?utf-8?B?T1ZnSndCMXVVNzFrbVFUL0M1TGl4TEZSRlB4b2NkMkVyZ0MxaXJ2dm5VWklH?=
 =?utf-8?B?TVppKzZ6ZUt1SGNVV2tFZW9TbHE4WmZkV3VJbG8rSVByYVhOcEJ3dzl4Tjd0?=
 =?utf-8?B?Z01TTmdsQ0FlOXVlSXdTRUZpNmRFZndEdTFjcWlXT1J1QktTZjZSN1RvTVdN?=
 =?utf-8?B?QnlrclJMVnlTVGlMZ29DcFgrVlZOTTkrNlBBYjNiWmZxM2cwVUZ1WmFIbUJo?=
 =?utf-8?B?V0JRMW94MDZnN0Q0NW5odmdyS0crM205am8yalpwZmZXZDF2RE8vUHpYekNy?=
 =?utf-8?B?RzA2Ny9kZnJtWldxZnNLUE8rNDViMVFjMUM3WnFHNGFZOHd2NlpKNUZvSFdp?=
 =?utf-8?B?K0VLaHFxay9lS0NtMXdmOFN2bEx6QVNOM1NJWEY1NTFjTlVNeHJqYW9KZU0x?=
 =?utf-8?B?MGVZOWFvV2hSUmlLRlpZUnVoeHFYaHZtODlad2p2ZVJ2ZWtqZkdWVWpWeFpk?=
 =?utf-8?B?ZG5DTFZoRjBPaG1wRE5YMTdremxoSjNXRUFJa2w4WW9DMFQ3aHdUVE1hb1Jp?=
 =?utf-8?B?b3REYnNmSVVQZ0hKMGJycEFZbklxdzAzaTBtYzM5dysvOUYxaDk3L1FYYzh4?=
 =?utf-8?Q?tnHpevqOfsk=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:FRYP281MB2224.DEUP281.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?WWY4aXdyajRJdXRtTkkwM0hXZGh4SEJpN2Mrc3FsN1h1bjN3eFJxODhkQWV4?=
 =?utf-8?B?WGlKNmRHN3lUUHFkMGFNOFB1SVB1bENBR0l0Mys4Vk8vamUvQ0pPeDVidzFv?=
 =?utf-8?B?ZldsdFRCc1RCU0VDcG44enZjRjFsSC80djZMcngyZFhXSk5UK0pQL2J4cS93?=
 =?utf-8?B?MXVlTXUvVWJTaTN6U2s2QVJ3YTJyYUUxNTBCa3hmaXduODRSZ2NSak9ZRHYw?=
 =?utf-8?B?WUw5NUxLTHNqTTgxMmRlUmpUNDFQaDZFUDVRQnR2aE1TRGFWNjZMNTJyR2F3?=
 =?utf-8?B?TXdlMytkUjYrWkVOUEFmTlllcUp4bVZqYkxOU3ZSVnFPQXYwZjJvdWFLVnBo?=
 =?utf-8?B?UjM0MVEvMVAvY3R4QUp1czM2bDhaWG1PWmUwVHMyZm5LUVpxdUsvSGxQZWhE?=
 =?utf-8?B?a2FQRitJUHVueGF3MkQyNWpzSXRrbTZ3ZHRNbys0blI3TjBnSFFYU2U5cERK?=
 =?utf-8?B?T3dvYjIrNElaVG03YTZneXZuZE1DWW5oUm9FeHh2aFVKOXN5OFNTeU1wb2Qw?=
 =?utf-8?B?b1FGdWtJZFNwM2pRdkVhTDIyUlQ1NS9MV2lQYW1iNi9JYmJBRlQ4ekw1NTJP?=
 =?utf-8?B?LzEzeEo5OTBEUGVsME8yY2d4bTEzay9Od1VMVVkzOUswcjkvSVQyQ3pOY2Ra?=
 =?utf-8?B?ZlREeXdrTW42VldmSUllcW5wNkNPdjNOQ3lVaDhpVWxDZ05ENU5MUnh1VW9N?=
 =?utf-8?B?L25uSEZCV3pRbVBPRWtZOXlZQ05uL0w3b3o0RnFQenp3UXNBYkNIWnV4OXJw?=
 =?utf-8?B?S1NFYUZISTBqR0k0RDUrS01ybGM2ekVZbUNIaFBZTExDVzBMRmd6S0drbkll?=
 =?utf-8?B?KytVMzlYdHB2SklHdnJQZ2lzaG05ZGFENkpWeWtHcUxMaVZuZjVDTlJkSHlq?=
 =?utf-8?B?Yi9Wdlo4RThXOVBiK1JsZmMyaldWTmdWVUkrWkNoaXlrQndCak5EdElFbHFQ?=
 =?utf-8?B?MDFkTXZMdWtJc0hTYk94c1hnaGtsMDZVNVNhQmxCcWx6dTZGU0lwVVJXcW1X?=
 =?utf-8?B?S3JGVkRnRUkzRy9YamZvTUdJUUdzUGlFcFQxd1ptaUxZZkE1NWRWU1ZqU0Nj?=
 =?utf-8?B?ZFYzQkxJUUVYSytpbk40eklma0lyLys3YituM1RxR1Vqc2J4bWNCcUpuKzdt?=
 =?utf-8?B?NVZIZnlJMzBXQmtoNk1pTEZuM3pOc3pNdVBtckVDZS9kNXFnU0NYVU1LU3Bj?=
 =?utf-8?B?Q1UxRE9YSmVIWVV0WHYxZHNzSHcwdHE4Yk5FTUw1dWY0MllhUWEyTTc4QmNH?=
 =?utf-8?B?d3MxK21hNlFWRDRrdXoxdHFDR3BYc01rNUNiUmg1RmRyeG5hQktNcHpZNTZp?=
 =?utf-8?B?UUw2R1RZZmJRd080NlAyZmlQLzJ2Y2hPQllNREtKRHFCcVRGT1FHcW40Vms2?=
 =?utf-8?B?WnhHdCtKVmllQ3RJcUVIQ3J1Nmp3elRXL1lJYk9saXJ0OTRuM0RmS0RMUWVO?=
 =?utf-8?B?Z0JhWTNQUWlNUEp1THhYYnNIc0gxeWp3RkhPVjd2VU9BbHkzRW1CdDI5SmYz?=
 =?utf-8?B?Y2w3ZFJTNTNodUhxRkhCZWVOdHJRcnZjdWFoT2NNRGt5bVU5YUcvaUdEV3J5?=
 =?utf-8?B?MFBMNDcxbmZ0REprVHZsT1BTYUZKdXFvck51V21hMzZ5dnVzeG1HdEVDdkpL?=
 =?utf-8?B?cGIzMTNQRDVBRDdFTHJUVmJBaXRWa3M1c1RjdFVudXNLc0psUXRUd0NqT0RE?=
 =?utf-8?B?SCs4N3dqckpaYTA0Vm02eXpHT3hJZkVCMXk0VUVSQ2pEOElXYXNnZXVGaGZS?=
 =?utf-8?B?RHJ0bysxNDE2OGFHYXlKUGl2YVg5NmRsN1FNQXZnMHpUWEtOREJucnp0Yjdy?=
 =?utf-8?B?RHJiZW5RVE8yU21oMDhUdG5zcHljUjZ2WjVJK2NKS09ESVlOMUg3eFBWelJI?=
 =?utf-8?B?dkptamV6QUNSVGZraHJmM0xzTHZxOWFSMGlILzlmZHFyNGlwdTE5bkpmaXV3?=
 =?utf-8?B?djRIRWZGSWxmMmc5clBCc3VlWWNUU1UrdHJQbzVsSXliRFk0eWRta0hGU1E3?=
 =?utf-8?B?TEFnU2FSS1FNb1U3RVZMbG5CYzR6ZjJBZ2NWZWc3elRMTGRWb2NXTlB4dHRU?=
 =?utf-8?B?bjVkend6WWRqMDU5ZkRPcWhzZ1psMWVXb2pQUnpKWEVvQ0hydVEyS2tEb2k0?=
 =?utf-8?Q?vwVjOlaFKFvbDZxbzki3byzzH?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3BDBD476709D034AAABF137E80BD75B3@DEUP281.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: adtran.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: FRYP281MB2224.DEUP281.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 35fedec9-653d-4a0f-5832-08dd7da0d5c8
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Apr 2025 11:13:09.1213
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 423946e4-28c0-4deb-904c-a4a4b174fb3f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: f1AQ9bGCfwzYf45x2kztOdESBqkYHLwA33ZRdzqlnNoauY6zBFxsd35TsvTOICjVwSti97f2xZWTFWBnLDky5g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FRYP281MB0286

T24gNC8xNi8yNSAxNDozMiwgS29yeSBNYWluY2VudCB3cm90ZToNCj4gT24gV2VkLCAxNiBBcHIg
MjAyNSAxMDo0NzoxMiArMDAwMA0KPiBQaW90ciBLdWJpayA8cGlvdHIua3ViaWtAYWR0cmFuLmNv
bT4gd3JvdGU6DQo+IA0KPj4gRnJvbTogUGlvdHIgS3ViaWsgPHBpb3RyLmt1YmlrQGFkdHJhbi5j
b20+DQo+Pg0KPj4gVGhlc2UgcGF0Y2ggc2VyaWVzIHByb3ZpZGUgc3VwcG9ydCBmb3IgU2t5d29y
a3MgU2kzNDc0IEkyQyBQb3dlcg0KPj4gU291cmNpbmcgRXF1aXBtZW50IGNvbnRyb2xsZXIuDQo+
Pg0KPj4gQmFzZWQgb24gdGhlIFRQUzIzODgxIGRyaXZlciBjb2RlLg0KPj4NCj4+IFN1cHBvcnRl
ZCBmZWF0dXJlcyBvZiBTaTM0NzQ6DQo+PiAtIGdldCBwb3J0IHN0YXR1cywNCj4+IC0gZ2V0IHBv
cnQgcG93ZXIsDQo+PiAtIGdldCBwb3J0IHZvbHRhZ2UsDQo+PiAtIGVuYWJsZS9kaXNhYmxlIHBv
cnQgcG93ZXINCj4gDQo+IE5pY2UgdG8gc2VlIGEgbmV3IFBTRSBkcml2ZXIhDQo+IA0KPiBJbiBu
ZXQgc3Vic3lzdGVtIHdlIGFkZCB0aGUgIm5ldC1uZXh0IiBwcmVmaXggdG8gdGhlIHN1YmplY3Qg
d2hlbiBpdCBpcyBub3QgYQ0KPiBmaXguIFBsZWFzZSBzZWUNCj4gaHR0cHM6Ly9lbGl4aXIuYm9v
dGxpbi5jb20vbGludXgvdjYuMTQtcmM2L3NvdXJjZS9Eb2N1bWVudGF0aW9uL3Byb2Nlc3MvbWFp
bnRhaW5lci1uZXRkZXYucnN0I0w2MSANCj4gUmVnYXJkcywNCg0KSGkgS29yeSwgDQpUaGFua3Mg
dG8geW91ciBwcmV2aW91cyBnb29kIHdvcmsgaW4gdGhpcyBhcmVhIG1ha2luZyB3cml0aW5nIHRo
ZXNlIGRyaXZlcnMgcG9zc2libGUuIA0KSSdsbCB1cGRhdGUgdGhlIHByZWZpeCBpbiB0aGUgbmV4
dCBwYXRjaC4NCg0KUmVnYXJkcw0KUGlvdHINCg==

