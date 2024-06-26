Return-Path: <netdev+bounces-107056-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8ED369198C3
	for <lists+netdev@lfdr.de>; Wed, 26 Jun 2024 22:10:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E6B57B211B4
	for <lists+netdev@lfdr.de>; Wed, 26 Jun 2024 20:10:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AFC0192B62;
	Wed, 26 Jun 2024 20:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="houzdNzW"
X-Original-To: netdev@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2076.outbound.protection.outlook.com [40.107.102.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4CDD190679
	for <netdev@vger.kernel.org>; Wed, 26 Jun 2024 20:10:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719432648; cv=fail; b=XPnnYHFA3YG29sCBvD/19QCwPAMmBuAhUx9UfXacQtJPUjuoSyTlzy/T15vCSpv2KsKZNYrCCHjS20GRM0rmgh/MDEpHABjVQd5oXfCYkQg5z1u9XdYUfcXIzP/o7zHJV35sL6chrbYSwZCTpmemcCyVeX8imS5d5gSQserEr5k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719432648; c=relaxed/simple;
	bh=+XBuQtEXRj+sGSLhnoWfXrsn/1wE+w6+orPCU6TeVBE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=UYDUeE4lVIYtq/5OK31vFnPHmN48AY9ESygbEdRta32l5CxEn4sGjYoh1BUrF4ENZ50zKAaAXrIzX3+6+yUtqkAPhs23bHYM2i9SP5xOMPNq9TBdEYNnldvpMCMB0lGrubd2oDvntNKCAUXAxb5k0swSI/fYeGxtxFYNisOD8vI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=houzdNzW; arc=fail smtp.client-ip=40.107.102.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KpmktlJWteYw4eld5+Ymzh1TRSNe6zjbgDxUUTgvHogxk2OTRXOrzX0V8Cn+jzPF7uv6cyKFxKv1hQj5sA0eP7wuu94Dg8V+hvA/O/KkI/TeDfT6dlktaeRFWdb9BZYNKe93Q8edvXncZ4O6h865gToign1TT+33Dh5eN40F/OLlApWyXuZ8MdEO/hCseS0wXmvnsKUVkd4r/8LwppO+Re/2VbuKoGppokDKE0EHJ7J69JJHje+RF9UC7Dg2r02Y864XkYTJi5PjsS+ZHxOBSnbFYwzjXFk2vaYFPPJ2heroAX8DStNtCxVq2Gj7WH6S2ej5nYIzKOF30pgfm4YX6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+XBuQtEXRj+sGSLhnoWfXrsn/1wE+w6+orPCU6TeVBE=;
 b=Ajyczs6cFXnMoP1yRsqR/EVYlyU5lftUy2z02IXUN4nkJXyQZw51WbmkoYXzklly0xqWNUSbnEznfRckoqRMigHVJskyca8JhI9kIU03bopzys0PY1PBb4OnS1+50VgGwSBbeTEElQoWHvRJWycoqqoiGO8ULEco8Cw22w8rOikdNEPlqxrzyt7tBaWJONDkOet0HGiCob00LaTABY83GtfY+E++fDKMG7H4FDQtmA3rj1Oj+IbG44VdeRlVf2VHU81RJc2cNA4NO02B60KsH3qhAVjK03sAR2AEiLlRsjbsdHWPz0+CwZX7KifJCVAyV297Yy4CaniQIREyKNDmqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+XBuQtEXRj+sGSLhnoWfXrsn/1wE+w6+orPCU6TeVBE=;
 b=houzdNzWNSp+pd4lrfo25T2jitw1BN2MdtGJzClwCyQYrPoiRziEpMfVRplVucvwiPktkZTHd0MmlLtrHfQ7bkITVvm+xFvf6WMV8TXu2YdtbClyNoYQ+Ctc5UAcGjd9WTh6SdhHtOCzfENOkFvGO05ZhfLyeEq0oLxf+47KwLw/9vqgNfCq1ccXirzAy7311cTaVnrnigIEm7h8srU09aYU3ZgdyuaySAMth96+Z9A9x0uEcn9/NjRCY2w30eawi4IIypwj813ueKckYQN6dQsU8zbbJiWEJauz0I16T76mVahtW9o1yfOl6lG3BwU6RnfD9bZUkzlQNy0A2+wUWA==
Received: from LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9)
 by MN0PR12MB6223.namprd12.prod.outlook.com (2603:10b6:208:3c1::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.30; Wed, 26 Jun
 2024 20:10:41 +0000
Received: from LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b]) by LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b%5]) with mapi id 15.20.7698.025; Wed, 26 Jun 2024
 20:10:41 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: Sagi Grimberg <sagi@grimberg.me>, "linux-nvme@lists.infradead.org"
	<linux-nvme@lists.infradead.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "hch@lst.de" <hch@lst.de>, "kbusch@kernel.org"
	<kbusch@kernel.org>, "axboe@fb.com" <axboe@fb.com>, "davem@davemloft.net"
	<davem@davemloft.net>, Shai Malin <smalin@nvidia.com>, "malin1024@gmail.com"
	<malin1024@gmail.com>, Yoray Zack <yorayz@nvidia.com>, Jason Gunthorpe
	<jgg@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>, Max Gurtovoy
	<mgurtovoy@nvidia.com>, Gal Shalom <galshalom@nvidia.com>, Boris Pismenny
	<borisp@nvidia.com>, Or Gerlitz <ogerlitz@nvidia.com>, Aurelien Aptel
	<aaptel@nvidia.com>
Subject: Re: [PATCH v25 00/20] nvme-tcp receive offloads
Thread-Topic: [PATCH v25 00/20] nvme-tcp receive offloads
Thread-Index:
 AQHaseFnKTBtfKTbY0Wl/k9rKbX3hrGwkuMAgBBFaYCAADaUAIAZRoMAgAAH74CAAD69AIAAAkmAgAAHugA=
Date: Wed, 26 Jun 2024 20:10:41 +0000
Message-ID: <475934b5-4e41-44c9-92c7-50ad04fa70d6@nvidia.com>
References: <20240529160053.111531-1-aaptel@nvidia.com>
 <20240530183906.4534c029@kernel.org>
 <9ed2275c-7887-4ce1-9b1d-3b51e9f47174@grimberg.me>
 <SJ1PR12MB60759C892F32A1E4F3A36CCEA5C62@SJ1PR12MB6075.namprd12.prod.outlook.com>
 <253v81vpw4t.fsf@nvidia.com> <20240626085017.553f793f@kernel.org>
 <d23e80c9-1109-4c1a-b013-552986892d40@nvidia.com>
 <20240626124301.38bfa047@kernel.org>
In-Reply-To: <20240626124301.38bfa047@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9404:EE_|MN0PR12MB6223:EE_
x-ms-office365-filtering-correlation-id: 36dda7be-20a1-4d4d-6da4-08dc961c0de7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230038|1800799022|366014|376012|38070700016;
x-microsoft-antispam-message-info:
 =?utf-8?B?UVR2YkZlQ2NlV2hqK2p0cFA3ZUFOTk5jSVcydHFGbnErNmpvUHRtckhaVXhM?=
 =?utf-8?B?NS83ZEZHZkdib1ZNQzFMdmFhWmNCMWtPNmQ2VEQ4emhuRVlFUWQ4MEx0c2dh?=
 =?utf-8?B?OGxrd0o1OHhOdXFlMjZ0SWdYMEQ1WkdXZGxJZGpoMll2cUE0aVNYOHIyY0Q0?=
 =?utf-8?B?T3AvdVI1SThHMGJ0SnVCQzhnV1JDMnppdGpwejZoMEVzOXBBY3VpV0h1cTlJ?=
 =?utf-8?B?eEFPWUJGYzBLUlJ6K3p1SUVoOWRhNXpER2VnbUVaaXRDcnErMXBGQnJQL1lV?=
 =?utf-8?B?L1g1RDE3RDNYVGRFQmNOWGloYTJaV0xFRG5HQ0U1azdPb1EwZFBVcGZ1ZURX?=
 =?utf-8?B?bW9BZlJtVTJDSU94RmRUNWVTa0RZeFNTTHEza3ZVWU1jMm9UcE16cXhBNVhj?=
 =?utf-8?B?cWxrQ1J1R001TnRwODFsbjB3c1hMR0ZyL2JWVG9rWlFaRXBuWnZOdzNmTy9U?=
 =?utf-8?B?WVYxemxpTERERGxEZ3dNa045Q3NpWWZkMW5EUWlwR3MvcjhMa2dESFhWRTVa?=
 =?utf-8?B?M2JKZkxxMUxjUFRzZ1lRcERHM0pPSXIrVVZzTjMrcUtORDROYm52aFJxUVk0?=
 =?utf-8?B?TVdwcFdjZzlMeVNNTEJMajJVV1dpclJ0QXB6bHdJb003d2N6dUpPSm5iZEp0?=
 =?utf-8?B?YTF6LzU3TVdhN0FrUG1HM2lmRllXcVpVdUtNYWE4NmtFVjJxNEl6UFoxemFV?=
 =?utf-8?B?UEx5Tjd5Qnp1YWlENjVlNERQd1d2QU51R2JGRlUvdzB4T2xhcnRQaG0xcHVu?=
 =?utf-8?B?RDlFTFJXNjV5VEwwZHJhQkh3WVZHNnFGcURDaTZPZWI5bXdDa1JZT2JCcEhF?=
 =?utf-8?B?K0UvcWtBS0hGUXp0VDdrSXNiV0RIVE0vdlNNOXV6S09aY2pIWkdzdytaUUJB?=
 =?utf-8?B?eUtqQlFsam5sRUZpRXovQkxCU2QyQnBnSHJDa3EwZlpCcXFxSkgxRVFrUGJR?=
 =?utf-8?B?dklCcG80NFF3QUs0UTNRSklYbVJIZlI0RXVia1lJS09qRDY5bWQ2ZnY2N1BF?=
 =?utf-8?B?VDNHdytvQWdCNWRrMzNlbDBIZkxyaXFML2gya3FJUkdHY2x1MlI1WkdaZjRp?=
 =?utf-8?B?Wm5JejNGMVdRNFRxMUxrdzJNY0JOME85M1hheC9ibkk0bEJRbDhJN0dGV0h5?=
 =?utf-8?B?ZFhYUThCb05ZaUJIN1llZXFzM2h2ZndLekxzdmhRcW0yOHhTQUhOcXAyRHZX?=
 =?utf-8?B?QWxPMVp0RHh1emVUc3RwY0sxa0h2LzdXN0UyKy85MVFUUFhBdi9HK29JTzYz?=
 =?utf-8?B?elg3cFg0alc1V3F4ZWVlY3hScCtJRm03cEFDTDJFdmQwSVRaSmtJTUdYT2dZ?=
 =?utf-8?B?aE9IN05ZaXgzajBHdlpsNG9SNDQzYWxOdENVMWR6dk5OYld6SU9mNW5xM1Mr?=
 =?utf-8?B?bUVIZWFNSXJEb2tzSHk0WHN1V0pvZlc1MWhuS01ZdkhEdmU4VHZHWVpPYnJC?=
 =?utf-8?B?VXFGeWpyMW4zT1V2a2V6dTBnQlRNVVVmMmpia2Z4YWlKU09Ndm9COHhmY09s?=
 =?utf-8?B?cnkvMEJybHdiTDNFems1SUZ5R2tCanhnREh3NGJhZkYvb20rYkhvUGxlMUhN?=
 =?utf-8?B?dGpXRDRNQUM5SHdjQnljMDdYdm9NSFZOcFdVdzBxc2kwd1lzUG1FNWxZczBU?=
 =?utf-8?B?K1dqR09iK3VTNkhFV2R3UFVPYU0zN3hNUWt2SnJWL0tZWndtaWNHRUl6YUtH?=
 =?utf-8?B?VnZ1cE43RmhyWWc2d3RoZDVpUGdwNzcyUkczako0cUZQVVBqelVDTkxrYTRS?=
 =?utf-8?B?Ty9NZVBRbFFiMi9VaU03eFcvU2FwZWlGY1pGTUtzWFVkMEFZT2tLZTBHanV1?=
 =?utf-8?B?Z2hMUHo2amJqWTJHN1h2ZTJ4Vk1XanRYTFNmbHg5UkNXak5Sd1ZuNjBuZDcx?=
 =?utf-8?B?RjVIejJHdzB5K3o2S2s0RFdZK0pyNmROZURiOGJzOGVGWlE9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9404.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230038)(1800799022)(366014)(376012)(38070700016);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?bEFXNy9qZVJ1aWxCN1A1MkZWNkVHV1JiK0Y5L0hNNkl3cVFxQ3VzaTk3WW93?=
 =?utf-8?B?S0hxTVU4SkN6aUxrc1pBZWg0S0VxeTY5Y2w0QmVYOGtHSi90MDZjZVJlMk5v?=
 =?utf-8?B?aHhES2cxcnRTczU5THNmcDUwM3dEMmRHSkNHNm9XR25wMzBOdFBpVEJkdlF0?=
 =?utf-8?B?R05iLytVd3BRUzRaeldRaW1IQzZUcGxTR2tSRXpoeVlqTkdRbEkvUTMrZW5C?=
 =?utf-8?B?Tlp3bW1Xek81bmE5Y2R6c2h2OENVM1Nsc3pMaHBVOExOOWZFTkpDTWtZOW1G?=
 =?utf-8?B?YVVOMWZMbkxsRmFlaUI4Q1FWMFJuTDIyZS9XVkJwTktUbk5kbTlHbVUwbVMx?=
 =?utf-8?B?Wjd3cy9PYzJSSHM4VkxiNGhrUUdiMThPVk55Uzh0Y3VsYmEyaktia251d1gw?=
 =?utf-8?B?OGp0cDl3OFArWTE3cDUzYkR6UW5TVGdyLy9PZHpvNnFsNG9MREo2UGRiK0JF?=
 =?utf-8?B?MUhjY0FuNzRIUjFjaEpWbW5xWjFoa1hkMjNWTy9tWHY2N0ErODU0Nm0wQVNl?=
 =?utf-8?B?NTV1ejhPVUxqR3ljc2xwdDN1L3V2VnRLWkdGUnV2WjhrNVZOQWFNODloZjVG?=
 =?utf-8?B?UFVxVkpGRy81d0J1VWFST1VUYm4wdlpXRWRNM1hhekdjdmpJSmcrZldEUTZS?=
 =?utf-8?B?Y3AzZlAxZzF6SitrRnh1ajhMTXhFdWs4NUtLcGRJWjQwemY2aWVLRmlCYlEz?=
 =?utf-8?B?SFhLcGM0YWZBeE16aGZoZjN2REd0OEt0R1FiVjd2dzdXUUFzNWNDUDBhb0E1?=
 =?utf-8?B?d0N2VnZ2QXJwMjZUVUxSWi8xOFBsem0wU2FDUTlGa1I5VG1ibHdZbWh5Sytl?=
 =?utf-8?B?aVUxaEtoeTJqMHl6MnZ3ZWFXb3FhbXcxNExnZ095dXZyTlBaaE1laWt0eVVr?=
 =?utf-8?B?SDBhWEZRZTRzV0V4WGZQMXQ0ZkxEOWpUWVdtZzM4Y0IvNVVGZ1ZqRklyNS82?=
 =?utf-8?B?RmFCTVA5Z3orMGkwY2tRQ21oVVhNOUJLaklTellXd2Z5RGRZTFh4V1RZWi9O?=
 =?utf-8?B?a3dyWkJpcEFtMUxqODJpd0NOSXdSVlhIUm91ekdEVU83aUJmMDI1NzdaOEo2?=
 =?utf-8?B?WVgrNGQrWm0wVHZoS0dwZGtRempIcGxmTWRFV3UwTlloVDl5VzY5OHR6aXJG?=
 =?utf-8?B?eFlEK3I0ODIrUWZnSFBhMUlKOU9ldm03SGtUWVF5QVhIM1hOUlExemJxbHc0?=
 =?utf-8?B?RlhGcTRzVExIcWtRUXY1N2FSdStqbXJHT09KV0xzV1lYTmZ3bktvOEhaK2w4?=
 =?utf-8?B?RXk5VHBHK2hoMkxKSkdRb1NubndGUy9TK2xCc2xSdTNUeGRqV2srUVdkQ0N0?=
 =?utf-8?B?Nmt2MVpZSHQwWjVFZUJHdU04MnA1bitLQmZPUVE1NytkeThsT1lVVHVabU0r?=
 =?utf-8?B?UGg4bkRVNjN4VFdMS2M5OGtvZ09RUG9NN2hjMldmbGZKNHlkY1pNSlJ0UEw4?=
 =?utf-8?B?QXpTc2R3SmpnOUx3MytLeFlCYUJpb0puUEg3Ull6enh2UEttOENFc3RsZlIv?=
 =?utf-8?B?QmlQZ0lmL3lueC9kOGpWMGNTdlhGcjBHT1phNUU5cEZFMWJVWFdreXJySmpL?=
 =?utf-8?B?WFh6OUxEckRWWUlkdCtWeG5mYnE5TVFvUzk3Tm0zOTkwWEVRN21SS1ZpQWZP?=
 =?utf-8?B?WEJGeFk5eUtiYUJuVyt2WHV6ZTBvRzlqZFlra2tSRUVQbEEvbWN0ckdEMHhn?=
 =?utf-8?B?UjF1Rmh1M2hLamljRWhobDM2TTljVTVBK0VMTmJBOEdoOGtacHJOT2RPbTFX?=
 =?utf-8?B?dytGcWpHTmFmSGEvUE1UVGRpRjZKTmhGeDRINmN3dndsV1N4ZkxOMXhuSkpQ?=
 =?utf-8?B?RFpvb2FQdDV6SDNtd3BxWWxOcGlmUnVmYkd4dnJ4aTUzWkRwcjQvM3UxaWwx?=
 =?utf-8?B?OFZvdVV5WGQxQWVWL29icXdlMXZpczR4T21PWU5VUDdIcXBpbVN6MEt4NzdC?=
 =?utf-8?B?ZjBJTXVFcnhSdE0wZ1ZOVkJlbzRJZU5UaE5udDRVSTczVHJaY0hHdFA4Tys5?=
 =?utf-8?B?VjNROGRlUUFUNm9icHdRdkR0OE5YWkZqM3VuR0dlYlhxQXZ1TDVkRW54a2JS?=
 =?utf-8?B?ejJNUzc2YnlpME5lb1g2MDMwQnlQRWFhTHNHckNmVHRRVGxOemR6bXZkcEti?=
 =?utf-8?Q?FKGTlzeqiAwjq0aT4oGUAqvaN?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B188F801EBECF84483766BCFC1B99FBC@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9404.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 36dda7be-20a1-4d4d-6da4-08dc961c0de7
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jun 2024 20:10:41.5756
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vuR7BBUY+HrVJmgN+88z+wf8ePdYWhtuTf87vkVW0ViY7WHDqugmC94aP76YSfRd8lsw1dEcW9tavqjtwGIfJw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6223

SmFrdWIsDQoNCk9uIDYvMjYvMjQgMTI6NDMsIEpha3ViIEtpY2luc2tpIHdyb3RlOg0KPiBPbiBX
ZWQsIDI2IEp1biAyMDI0IDE5OjM0OjUwICswMDAwIENoYWl0YW55YSBLdWxrYXJuaSB3cm90ZToN
Cj4+PiBJJ20gbm90IHN1cmUgd2UncmUgb24gdGhlIHNhbWUgcGFnZS4gVGhlIGFzayBpcyB0byBy
dW4gdGhlIHRlc3RzIG9uDQo+Pj4gdGhlIG5ldGRldiB0ZXN0aW5nIGJyYW5jaCwgYXQgMTJoIGNh
ZGVuY2UsIGFuZCBnZW5lcmF0ZSBhIHNpbXBsZSBKU09ODQo+Pj4gZmlsZSB3aXRoIHJlc3VsdHMg
d2UgY2FuIGluZ2VzdCBpbnRvIG91ciByZXBvcnRpbmcuIEV4dHJhIHBvaW50cyB0bw0KPj4+IHJl
cG9ydGluZyBpdCB0byBLQ0lEQi4gWW91IG1lbnRpb24gImZyYW1ld29yayB0aGF0IGlzIGZvY3Vz
ZWQgb24NCj4+PiBuZXRkZXYiLCBJREsgd2hhdCB5b3UgbWVhbi4NCj4+IGp1c3QgdG8gY2xhcmlm
eSBhcmUgeW91IHNheWluZyB0aGF0IHlvdSBhcmUgd2FudCB1cyB0byA6LQ0KPj4NCj4+IDEuIFB1
bGwgdGhlIGxhdGVzdCBjaGFuZ2VzIGZyb20gbmV0ZGV2IGN1cnJlbnQgZGV2ZWxvcG1lbnQgYnJh
bmNoDQo+PiAgIMKgwqAgZXZlcnkgMTIgaG91cnMuDQo+IFNtYWxsIGJ1dCBpbXBvcnRhbnQgZGlm
ZmVyZW5jZSAtIHRlc3RpbmcgYnJhbmNoLCBub3QgZGV2ZWxvcG1lbnQgYnJhbmNoLg0KPiBUaGVy
ZSBtYXkgYmUgbWFsaWNpb3VzIGNvZGUgaW4gdGhhdCBicmFuY2gsIHNpbmNlIGl0cyBub3QgZnVs
bHkNCj4gcmV2aWV3ZWQuDQo+DQoNCmluZGVlZCwgd2Ugd2lsbCBhc2sgeW91IGZvciBhIHJpZ2h0
IGJyYW5jaCBvbmNlIHdlIGhhdmUgdGhpbmdzIGluIHBsYWNlIC4uLg0KDQo+PiAyLiBSdW4gYmxr
dGVzdHMgb24gdGhlIEhFQUQgb2YgdGhhdCBicmFuY2guDQo+IE9yIHNvbWUgc3Vic2V0IG9mIGJs
a3Rlc3QsIGlmIHRoZSB3aG9sZSBydW4gdGFrZXMgdG9vIGxvbmcuDQoNCndlIG5lZWQgdG8gdGFy
Z2V0IG52bWUtdGNwIGJsa3Rlc3RzLCBJIGJlbGlldmUgd2UgY2FuJ3Qgc2tpcCBhbnkgb2YgdGhv
c2UNCnRlc3RzLCBpZiBuZWVkZWQgd2UgY2FuIGRvIHNvbWUgb3B0aW1pemF0aW9ucyBvbiB0ZXN0
aW5nIHNpZGUgdG8gc3BlZWQgdXANCnRoaW5ncyAuLg0KDQo+PiAzLiBHYXRoZXIgdGhvc2UgcmVz
dWx0cyBpbnRvIEpBU09OIGZpbGUuDQo+PiA0LiBQb3N0IGl0IHB1YmxpY2x5IGFjY2Vzc2libGUg
dG8geW91Lg0KPiBZZXMuDQoNCnNvdW5kcyBnb29kIC4uDQoNCj4+IEkgZGlkbid0IHVuZGVyc3Rh
bmQgdGhlICJpbmdlc3QgaW50byBvdXIgcmVwb3J0aW5nIHBhcnQiLCBjYW4geW91DQo+PiBwbGVh
c2UgY2xhcmlmeSA/DQo+IFlvdSBqdXN0IG5lZWQgdG8gcHVibGlzaCB0aGUgSlNPTiBmaWxlcyB3
aXRoIHJlc3VsdHMsIHBlcmlvZGljYWxseQ0KPiAocHVibGlzaCA9IGV4cG9zZSBzb21ld2hlcmUg
d2UgY2FuIGZldGNoIGZyb20gb3ZlciBIVFRQKS4NCj4gVGhlIGluZ2VzdGlvbiBwYXJ0IGlzIG9u
IG91ciBlbmQuDQoNClRoYW5rcyBmb3IgdGhlIGNsYXJpZmljYXRpb24sIHdlIHdpbGwgZ2V0IGJh
Y2sgdG8geW91IGJlZm9yZSBtaWQgbmV4dCB3ZWVrLg0KDQpXZSBhcmUgYWN0aXZlbHkgYnVpbGRp
bmcgYW5kIHJ1bm5pbmcgYmxrdGVzdHMgc28gd2UgYXJlIGNvbW1pdHRlZCB0bw0KdGVzdGluZy4N
Cg0KTXkgb3RoZXIgcXVlc3Rpb24gaXMgaG93IGNhbiB3ZSBtYWtlIHByb2dyZXNzIG9uIGdldHRp
bmcgdGhpcw0KY29kZSBtZXJnZSA/IChhc3N1bWluZyB0aGF0IHdlIGRvIGFsbCB0aGUgYWJvdmUs
IGJ1dCBpdCB3aWxsIHRha2Ugc29tZSB0aW1lDQp0byBidWlsZCB0aGUgaW5mcmEpIElPVywgY2Fu
IHdlIGdldCB0aGlzIGNvZGUgbWVyZ2UgYmVmb3JlIHdlIGJ1aWxkIGFib3ZlDQppbmZyYXN0cnVj
dHVyZSA/DQoNCklmIHdlIGNhbiwgd2hpY2ggcmVwbyBpdCBzaG91bGQgZ28gdGhyb3VnaCA/IG52
bWUgb3IgbmV0ZGV2ID8NCg0KLWNrDQoNCg0K

