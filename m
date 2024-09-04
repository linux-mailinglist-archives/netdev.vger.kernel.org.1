Return-Path: <netdev+bounces-125061-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5252096BD0C
	for <lists+netdev@lfdr.de>; Wed,  4 Sep 2024 14:52:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 736D51C24823
	for <lists+netdev@lfdr.de>; Wed,  4 Sep 2024 12:52:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCAA41DA10C;
	Wed,  4 Sep 2024 12:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="vX7euJWJ"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2050.outbound.protection.outlook.com [40.107.92.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FD551D9D96;
	Wed,  4 Sep 2024 12:51:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725454316; cv=fail; b=RwXeCpYfB5dyQDBismf6NbqO34/7fiwNCDh7fZg6Q3EUqLxADwyHZEeuCdj+6K7YICM55vlsdGKs2KGZ5F7DZBlh71EnFxnDKflQ9Xy6IvAqTxHzM/DC/aoraA7aJr0Pihtnl1FYYqgX+qCXIY1NJEOfGxbcNccfcbxPCFrsNDE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725454316; c=relaxed/simple;
	bh=TT2sGgd3LuqliVffMZwVuwNFjFdyox+GlMMEQ1m+3qY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=howomkFRqqkK6wEB+MMG0ztZIMcTeFwX/eUozx6bBNR0Z7xkUjFNeJdjfcjxQY93jGgkqBN4fjRAKkodwlXwv+3/SCPnAIE/OCLU3K37n4PGU1QoluKp+5NW8aoKa6COFTu6MBydwuCAesOGkpBcywVafEMT1Jaji989hNtumJU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=vX7euJWJ; arc=fail smtp.client-ip=40.107.92.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=i5nbWo10vFfQoDyPDc9Tk3/Gx2mi4NuiyO2lUFVAHw+eVV38PdHdSigTByRAKCuw7SrbMgOziggIv+3Gnctq/c09DHKt5BhtFY4vdsN5pKzFqqasLsONvujqGi24WDyshp234i6gHxH9DvDCkP97LYyWNdk26bpTBipXRw3bCcZADWWHLN9fCBmd/QqDfwbZUcAfCBMcxW3tPG2pkQWsDdUPTWAjGUQxcIVwpI99fQ8P/N0+ANvTTydixhAHugxti9qlE77ne4M9rCqhlIK211OMdFmT3vdX+R5X+LqnRuQQCJuDDWSdONxyNC76dg6lJ6VCY6wVDA/i58A7sZzJ+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TT2sGgd3LuqliVffMZwVuwNFjFdyox+GlMMEQ1m+3qY=;
 b=WEe2r5fQ1Ctm0CopV5E/5a+1UkgRtzXetAkDQCFmrCdkyoOWynEESUROMoLcXvFxbbmlfrHzyoTwLy6ahqGqjXXQUJLGnhSP5mZ8ZZL+JukjZlXD1H4/Tf04OfzmVSIGkn4NUQL+GBsh6/X4oEoaxgCnxs/RZNqHVD0avwa952mTR26tTpli2KFQryatBKMFC93tNXGb49+AQop/yGTDPJTJJlHkiyit9uMtgFcZKvd0nNS86/ng6Eid+LVwlXO8XDElsEQcIYZu4poZjkK6JLMQg1enyXVhCVaGZGdjl4ZgqyFn6CYMUA5qVWSBEtyyE0QvANsEKmTZImTNqrd8KA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TT2sGgd3LuqliVffMZwVuwNFjFdyox+GlMMEQ1m+3qY=;
 b=vX7euJWJ7zp7BrWe8OAnzYLLwd+z33OUdWzep7zntWPVJ5HD37y8zTAhRKqmPfWKQin69HYbDeKfAL8XBMZG4bER8BEg2uW9x2swtfs9jowp+i29SDVO/h0nhtIOeY+AwFN7UmstkqxIAHSV5A/4oB0ZFfuum3fv0o/CKlnmQW2mBjib689sdUm0jOO0kug22xvTb+2hy67AI3J/cVqdyDrgsI1Wlf90WxTNRQq/XVCiwz6Bec1xH0DuShvXj2foyEJTnpemKka7Xu3kPT0/nJL4HJ/sFKkKQbxJaH+qaobY1xPpl9FDwfyL04tCupP98bJAG9dCjXDpOQ+5vAGSuQ==
Received: from SA1PR11MB8278.namprd11.prod.outlook.com (2603:10b6:806:25b::19)
 by SN7PR11MB7020.namprd11.prod.outlook.com (2603:10b6:806:2af::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.24; Wed, 4 Sep
 2024 12:51:50 +0000
Received: from SA1PR11MB8278.namprd11.prod.outlook.com
 ([fe80::84fa:e267:e389:fa9]) by SA1PR11MB8278.namprd11.prod.outlook.com
 ([fe80::84fa:e267:e389:fa9%5]) with mapi id 15.20.7918.024; Wed, 4 Sep 2024
 12:51:49 +0000
From: <Parthiban.Veerasooran@microchip.com>
To: <robh@kernel.org>
CC: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <horms@kernel.org>, <saeedm@nvidia.com>,
	<anthony.l.nguyen@intel.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <andrew@lunn.ch>, <corbet@lwn.net>,
	<linux-doc@vger.kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
	<conor+dt@kernel.org>, <devicetree@vger.kernel.org>,
	<Horatiu.Vultur@microchip.com>, <ruanjinjie@huawei.com>,
	<Steen.Hegelund@microchip.com>, <vladimir.oltean@nxp.com>,
	<masahiroy@kernel.org>, <alexanderduyck@fb.com>, <krzk+dt@kernel.org>,
	<rdunlap@infradead.org>, <hkallweit1@gmail.com>, <linux@armlinux.org.uk>,
	<UNGLinuxDriver@microchip.com>, <Thorsten.Kummermehr@microchip.com>,
	<Pier.Beruto@onsemi.com>, <Selvamani.Rajagopal@onsemi.com>,
	<Nicolas.Ferre@microchip.com>, <benjamin.bigler@bernformulastudent.ch>,
	<linux@bigler.io>, <markku.vorne@kempower.com>, <Conor.Dooley@microchip.com>
Subject: Re: [PATCH net-next v7 14/14] dt-bindings: net: add Microchip's
 LAN865X 10BASE-T1S MACPHY
Thread-Topic: [PATCH net-next v7 14/14] dt-bindings: net: add Microchip's
 LAN865X 10BASE-T1S MACPHY
Thread-Index: AQHa/e8JrxNrngEsD0Ga0vs263TR2LJGI42AgAFy/oA=
Date: Wed, 4 Sep 2024 12:51:49 +0000
Message-ID: <5deb6cc9-a3fb-4e5d-9750-bd7e39215e17@microchip.com>
References: <20240903104705.378684-1-Parthiban.Veerasooran@microchip.com>
 <20240903104705.378684-15-Parthiban.Veerasooran@microchip.com>
 <20240903144359.GA981887-robh@kernel.org>
In-Reply-To: <20240903144359.GA981887-robh@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR11MB8278:EE_|SN7PR11MB7020:EE_
x-ms-office365-filtering-correlation-id: 0e1987de-fb0f-45ef-fb33-08dccce057d7
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB8278.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|7416014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?b2ZWMXI2Y1hVNGx2TE1TYXJQRmU2SUpBcHZOZzRxWm9nSlBmdTRab0JYcUdE?=
 =?utf-8?B?RVBNSXNzMDIrTjZTR1hZK3Z4WnQrZkg1MFkxdkJ5aDVkdVorNFlPVDByaGZz?=
 =?utf-8?B?L2ZDWFpINXYvc0QrOFhhMmNZTEJpZEk4UG5ZLzNPNFNabGdGYkVRZnhGZ01r?=
 =?utf-8?B?RDRGWi8zbzJOMTNPN2UvTTVxVi8wUWpaeWN5Z3NQUFFkNFM5eldpWnJJNS83?=
 =?utf-8?B?YXM3dktuV0JUdlk3UGlXSUdWYmNaTVpvOFJQRkd0a3J0dTZEbGR5cWRpbzJX?=
 =?utf-8?B?R2lXWTd1ckQrZ1Z1OFVHZDUwdWpDekdwQjNtTm11RmV3a21jdU1RQ1dza0M0?=
 =?utf-8?B?c3pRYTNQN056bnhuOGtHQVYyZEVFWHR6U29WS1M4cjE1TUlQOE5RcW5aL01j?=
 =?utf-8?B?ZzJDWDQvNWdDMDlVQ3BEMmtwUFhKWUN2VDB1Um5wOUJFcnRCT1RTc2JIZ3VG?=
 =?utf-8?B?TlpMOUhrVk9IZ2szcVlhc25TZ0ZYMWorME9vdlBkUjhZell3a0w4aTN1M0RM?=
 =?utf-8?B?ZGl3WkFOeXRnTDdMYURrVFdaR0NZZ0ZRelh0ZjlWSnVBUjRPbmdES3lHa3dG?=
 =?utf-8?B?Sis2cTB0SU04bFkrS1FpWHhRbFlxNUtXM1dYV2djQ2xSVkh5aGhvay9QUjBW?=
 =?utf-8?B?aXJGbzF3NWZJWmhwejNoQ3pMNEdqRFhVSmo3ckxMSnNKVlhNWXZlcTRGVFI0?=
 =?utf-8?B?Zkw5czFpeEcyWitGakVTSG44TVpwSmtldENDUlZyLzRtaFFFNlIvZ245SW1Z?=
 =?utf-8?B?MytUb1JwOUJZZVBpUnlHaVpUY0VZc25CelIwalBPWUF5ZVlPY3pBNUtVZzBS?=
 =?utf-8?B?RlY4K0I3QVJtN2o3WExUYU1SamtZQVV1NTN1RTE0VjR4eGRPQmY1dG4vYkNU?=
 =?utf-8?B?SmdyZEEzQ09oL1QyMUNwYSttU3MvZDdIYnByZTIycThQMFZqaFhkN1hCeUhx?=
 =?utf-8?B?V0Fsb3RybFpuUmp2eHkxWHNQbEIycHQxeE1MNzYyQlJpaDRISElPVFFVRDRs?=
 =?utf-8?B?WUVPWUJFZ0QyWlBPY3hDekc3T1hkTVRoUUhicjZVT0tUcWNkYnNzWEJCblZD?=
 =?utf-8?B?TG1xM0tXTVRiZ3djQ1lOZFRsVTQzbGFWMUhmTnhCalpGcGJ0OXVGMDNGb0VR?=
 =?utf-8?B?Ui9abnRUWklBdk82NEZaY0xrbzViM3cwNGFCZnVmQ3g0N3o2TGFqQU02RS9D?=
 =?utf-8?B?YitLRGFLQllSazFKQlJaOW4zN0ZRd2FwWHhDbDE2UjI4NnNLaEFMcnY1Q1l5?=
 =?utf-8?B?UmE5Ump5SGZGTnRDWGo0WXBWeWVUYzFTZUJZT1NEU1hGUW5UQ09IM2cxT2Rx?=
 =?utf-8?B?Zjl6S2FYeW5TV0R2VzNXRDJFK0ZrN3hISjltNGVrM0IyemtZbEI1NFd2S2pi?=
 =?utf-8?B?MUQ4eEl3Vzl3WnhnZHNhd1VLMXZHenR4bDhrdzhjUUN3QUMzdmlha2VOdWZS?=
 =?utf-8?B?ZXVhOWt2cnB4eGxBeFNjMnJuaGpTeGdyM3hxYWZ6citKRUUrRVZ0VzZ5cUFk?=
 =?utf-8?B?Z2pnMlFzbW5NNW8yN2VKUjU3aExOL0NHUElKNmtWUjQzd2hSTC93N1AweWxU?=
 =?utf-8?B?NEdGa2YrdFFsLzhPMmJaWFBuTTNhVUFqaXh0S0VhbGZ0UW80Ukl2N3p4SlAz?=
 =?utf-8?B?MGlvRlErdE5VTUZMQ2xDNzZHZU10TTNrYVY3L2hQTnJqa3E5QVYwQWg0Mm1r?=
 =?utf-8?B?WkNqS3VOcWJtOTN1Mnd2M1hscG5IYWxJZWM5amFMMzJ2bG1IRTNzaUVyL3Nr?=
 =?utf-8?B?dEo3bkdzT09ST2prNnlnOVVrblRERHlaZHRwN3RyQWpHQVZ3aS9BTHcwcXY5?=
 =?utf-8?Q?piBtmRsQqwJmCaVkYWkLQKba6xqUi26M8VZRY=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?K1BPdGc2TUVJQWRSSHBWRExBSDVuMk16MUtOUzJ2UTZhVnpHSW1lYmU4NnY4?=
 =?utf-8?B?MTk2bXhvUlllTDl1Uk9IcUgzUXI2RnBDbVBnS1FWME1lMUpJc3hKOXYvNGxK?=
 =?utf-8?B?WjFlVFoyenhQMXlGNmY3dEp0QWMxams2MTdHVklQVjJQSC92b2ljNmd0ZDhH?=
 =?utf-8?B?V1dzcFp5RDdaTW5INE02cDZReVpYOU9keXhYckRKSExCVXNVSTZ2eHJ5OHVt?=
 =?utf-8?B?NVllM2VROXhlWmFyVmE4SHNEWnVlakVKWUYxeEZwOU9nd1YyYUFhUS9RdWJK?=
 =?utf-8?B?QUxCSEpEblJ2dHdJY2plTmEyT2FYK2lKWm9sS3ZSU2ZpbmU2TnBIeU5Ndmc1?=
 =?utf-8?B?Z2M4V2w1czg2SUlkb3plUnhGNkxDbFlDM2FwN0o4Vlh6WFZWanBrcGZqbVZK?=
 =?utf-8?B?a3ZsZ2tkalF6U05FVGtWRkZLcGxNeFBzaGJ5Zkx1RGIxTW94QSsxRDVvSElZ?=
 =?utf-8?B?KzlQa2lpb1ZCY3hwQmtOak1sRnlkV1hlWk9ieVNkaWRsb0k5TklrZWtMczZR?=
 =?utf-8?B?TTYwKys2bVRKNTB0LzQ5dGtJNmhZN3E4cnE0UEh5OHczazkxMDYyTHkyYjcy?=
 =?utf-8?B?ZGh2Wkl6VUNjVzZrbUZKZTdNcEdReXl3eWNLQS8yVG5BUmJ6bXV0WFlKU21r?=
 =?utf-8?B?NlplMDd0TS83eXdxOXlwcUZoa0ZIRkxQMkZJdktLSFJvYzkxanl2OEwyQTlV?=
 =?utf-8?B?dCt5cW9XNUp2SUJnTXZoc2Z6SzlQRUx0Q1VhUENzamhsQ0NGNXZ0T0trVkVW?=
 =?utf-8?B?d3RaWld0Ykp1dmhGaGx1cGVQQmdnTVpmWndmNW96ZXVhYWRqMGxtRzVqZDdZ?=
 =?utf-8?B?b1I2MHZ6OXpmWkthUENETnZHRU44VU90RE5EUzFMOGJYZlNIb3RFbmJxaEIy?=
 =?utf-8?B?dHFBK0ZOWEg4aEFzT3UyZHpsem8vTXFQMGpaNUlaTFlFOHJ5eWEwWlQyYld4?=
 =?utf-8?B?SXAvR09yQVR1WlN5a0ZGTUhwZTVheitVYmRyZnNWdXBMOExxS3U0bW16aDJG?=
 =?utf-8?B?Y1dPaU5NalExZlUxY3M1Rkx4THBPWXdPbFJ2Y2N1akcyQ3VDMmpWY3FpOEp0?=
 =?utf-8?B?SHAycTBjdTRlVStnNDNDd0dkVnJRQ29VUmFCR0FzVlZYOXRJdHJvbE05TGR6?=
 =?utf-8?B?bDl3SzBySmhDZmxjanNMTGkrVEFJTnZ5RnhUb3ZlV3hzT2xweGg5WFh3dERr?=
 =?utf-8?B?Ty94RS9ucUd5cy9xazBwSC9jcEJ0K3BLK2UvWE5UWnR2VFYwUy96SW9xbDgv?=
 =?utf-8?B?ZkJVLzNIcTBSNW9xZEhBaGhRbjJYNjRHdXVOQkpOUDV5MWhDOUhNWXZIcnI4?=
 =?utf-8?B?Y1l0aGk4czV2Rjlkd1BOUUdEOHZPcU5teDFjM2dOTVo3Vko5dVhsNHBLMGxj?=
 =?utf-8?B?Q2Z2ZDRxalRpRXIzQmovcHFmcVpER0lrdFE4ckV6UGdNTmdwOGFGbE5CMEpG?=
 =?utf-8?B?MFhMSWd0ODRqeXJMOTBjbGcvV3Yrd1Q0Uy80MXFhRElNd3FIYkFTOEh2Sjlr?=
 =?utf-8?B?ZnNBT3k4TnBiWW42Q1Vnc0R1c2hLMkZjZ0pnZUp6bWtxYmFxcmw1TDF6MnRN?=
 =?utf-8?B?UWFhbFpEOWFhUXF5MjkwZzV0WFVET0hCeEVJbHVkcEtvMFR0dFNMaWhaYjdp?=
 =?utf-8?B?Vnl0amcyNDRMN1NRSkRKTTN4MUtIVEdES09raGZaeFczNktNSE1lenJ5dVJM?=
 =?utf-8?B?clJWVEtzc1BWVnZlZlZYS1VwQ2NrbGw2UnJ0ek10eDU1VmdzV1Q4UVg2Wk9x?=
 =?utf-8?B?cEVqbm5YbStOWHlBTWcvUTVtYnIzYjFsa05wN2JSRktaQXIydGhZLy9lck5M?=
 =?utf-8?B?QitMRUJUdkxselk1aHhhaDlCWWRrRk9sMjErQlAya2xtaTZZLy81UGJXLzgr?=
 =?utf-8?B?SE5COUgrcFRZa2d4a2ltVjJpcDJqNE4zazkyOUtxTTJGZlNCeG1WZGg4VWd6?=
 =?utf-8?B?dVNMbGRtTTZ6SitsQlJyK2ZYS0Jud0lGSm5tNmU0QkpUak96YmdkY0g3bFpt?=
 =?utf-8?B?NTVhcm9RWmF2dFllaXZ0TVM4eXNrcnFhZ2ZlRmNkSmtPY0NYTVZReVNQRkk2?=
 =?utf-8?B?MjhNbXpmaW1pc0RWY1VxazJOUGcxc3MrRXFpVis1Y1dMeWwzVVQ3ak5iN3R3?=
 =?utf-8?B?RERVcFk0T0tlUitzUi82ZytQMlQ5SGYvQmdVTWZpaGJmQjQvQkw3bWM4V0lB?=
 =?utf-8?B?aVE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <68A6606BB6C2EC42B218B0C8B33B3F7D@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: microchip.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB8278.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e1987de-fb0f-45ef-fb33-08dccce057d7
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Sep 2024 12:51:49.7947
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IhQV/DLXRQnAwnn7NebJt8nPFf2oGGHXcRLzuU7JI/DWV6r3DqAz5kOnKBQdmRwxVtGQP2IdtSPzEMxhMlWWh4HPaK5yDVaG9tB6wDuzJKUfV+hfNZrunj/tykMdabta
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7020

SGkgUm9iLA0KDQpPbiAwMy8wOS8yNCA4OjEzIHBtLCBSb2IgSGVycmluZyB3cm90ZToNCj4gRVhU
RVJOQUwgRU1BSUw6IERvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVubGVz
cyB5b3Uga25vdyB0aGUgY29udGVudCBpcyBzYWZlDQo+IA0KPiBPbiBUdWUsIFNlcCAwMywgMjAy
NCBhdCAwNDoxNzowNVBNICswNTMwLCBQYXJ0aGliYW4gVmVlcmFzb29yYW4gd3JvdGU6DQo+PiBU
aGUgTEFOODY1MC8xIGNvbWJpbmVzIGEgTWVkaWEgQWNjZXNzIENvbnRyb2xsZXIgKE1BQykgYW5k
IGFuIEV0aGVybmV0DQo+PiBQSFkgdG8gZW5hYmxlIDEwQkFTRS1UMVMgbmV0d29ya3MuIFRoZSBF
dGhlcm5ldCBNZWRpYSBBY2Nlc3MgQ29udHJvbGxlcg0KPj4gKE1BQykgbW9kdWxlIGltcGxlbWVu
dHMgYSAxMCBNYnBzIGhhbGYgZHVwbGV4IEV0aGVybmV0IE1BQywgY29tcGF0aWJsZQ0KPj4gd2l0
aCB0aGUgSUVFRSA4MDIuMyBzdGFuZGFyZCBhbmQgYSAxMEJBU0UtVDFTIHBoeXNpY2FsIGxheWVy
IHRyYW5zY2VpdmVyDQo+PiBpbnRlZ3JhdGVkIGludG8gdGhlIExBTjg2NTAvMS4gVGhlIGNvbW11
bmljYXRpb24gYmV0d2VlbiB0aGUgSG9zdCBhbmQgdGhlDQo+PiBNQUMtUEhZIGlzIHNwZWNpZmll
ZCBpbiB0aGUgT1BFTiBBbGxpYW5jZSAxMEJBU0UtVDF4IE1BQ1BIWSBTZXJpYWwNCj4+IEludGVy
ZmFjZSAoVEM2KS4NCj4+DQo+PiBSZXZpZXdlZC1ieTogQ29ub3IgRG9vbGV5IDxjb25vci5kb29s
ZXlAbWljcm9jaGlwLmNvbT4NCj4+IFJldmlld2VkLWJ5OiBBbmRyZXcgTHVubiA8YW5kcmV3QGx1
bm4uY2g+DQo+PiBTaWduZWQtb2ZmLWJ5OiBQYXJ0aGliYW4gVmVlcmFzb29yYW4gPFBhcnRoaWJh
bi5WZWVyYXNvb3JhbkBtaWNyb2NoaXAuY29tPg0KPj4gLS0tDQo+PiAgIC4uLi9iaW5kaW5ncy9u
ZXQvbWljcm9jaGlwLGxhbjg2NTAueWFtbCAgICAgICB8IDgwICsrKysrKysrKysrKysrKysrKysN
Cj4+ICAgTUFJTlRBSU5FUlMgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHwgIDEg
Kw0KPj4gICAyIGZpbGVzIGNoYW5nZWQsIDgxIGluc2VydGlvbnMoKykNCj4+ICAgY3JlYXRlIG1v
ZGUgMTAwNjQ0IERvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9uZXQvbWljcm9jaGlw
LGxhbjg2NTAueWFtbA0KPj4NCj4+IGRpZmYgLS1naXQgYS9Eb2N1bWVudGF0aW9uL2RldmljZXRy
ZWUvYmluZGluZ3MvbmV0L21pY3JvY2hpcCxsYW44NjUwLnlhbWwgYi9Eb2N1bWVudGF0aW9uL2Rl
dmljZXRyZWUvYmluZGluZ3MvbmV0L21pY3JvY2hpcCxsYW44NjUwLnlhbWwNCj4+IG5ldyBmaWxl
IG1vZGUgMTAwNjQ0DQo+PiBpbmRleCAwMDAwMDAwMDAwMDAuLmI3Yjc1NWIyN2I3OA0KPj4gLS0t
IC9kZXYvbnVsbA0KPj4gKysrIGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL25l
dC9taWNyb2NoaXAsbGFuODY1MC55YW1sDQo+PiBAQCAtMCwwICsxLDgwIEBADQo+PiArIyBTUERY
LUxpY2Vuc2UtSWRlbnRpZmllcjogKEdQTC0yLjAtb25seSBPUiBCU0QtMi1DbGF1c2UpDQo+PiAr
JVlBTUwgMS4yDQo+PiArLS0tDQo+PiArJGlkOiBodHRwOi8vZGV2aWNldHJlZS5vcmcvc2NoZW1h
cy9uZXQvbWljcm9jaGlwLGxhbjg2NTAueWFtbCMNCj4+ICskc2NoZW1hOiBodHRwOi8vZGV2aWNl
dHJlZS5vcmcvbWV0YS1zY2hlbWFzL2NvcmUueWFtbCMNCj4+ICsNCj4+ICt0aXRsZTogTWljcm9j
aGlwIExBTjg2NTAvMSAxMEJBU0UtVDFTIE1BQ1BIWSBFdGhlcm5ldCBDb250cm9sbGVycw0KPj4g
Kw0KPj4gK21haW50YWluZXJzOg0KPj4gKyAgLSBQYXJ0aGliYW4gVmVlcmFzb29yYW4gPHBhcnRo
aWJhbi52ZWVyYXNvb3JhbkBtaWNyb2NoaXAuY29tPg0KPj4gKw0KPj4gK2Rlc2NyaXB0aW9uOg0K
Pj4gKyAgVGhlIExBTjg2NTAvMSBjb21iaW5lcyBhIE1lZGlhIEFjY2VzcyBDb250cm9sbGVyIChN
QUMpIGFuZCBhbiBFdGhlcm5ldA0KPj4gKyAgUEhZIHRvIGVuYWJsZSAxMEJBU0XigJFUMVMgbmV0
d29ya3MuIFRoZSBFdGhlcm5ldCBNZWRpYSBBY2Nlc3MgQ29udHJvbGxlcg0KPj4gKyAgKE1BQykg
bW9kdWxlIGltcGxlbWVudHMgYSAxMCBNYnBzIGhhbGYgZHVwbGV4IEV0aGVybmV0IE1BQywgY29t
cGF0aWJsZQ0KPj4gKyAgd2l0aCB0aGUgSUVFRSA4MDIuMyBzdGFuZGFyZCBhbmQgYSAxMEJBU0Ut
VDFTIHBoeXNpY2FsIGxheWVyIHRyYW5zY2VpdmVyDQo+PiArICBpbnRlZ3JhdGVkIGludG8gdGhl
IExBTjg2NTAvMS4gVGhlIGNvbW11bmljYXRpb24gYmV0d2VlbiB0aGUgSG9zdCBhbmQNCj4+ICsg
IHRoZSBNQUMtUEhZIGlzIHNwZWNpZmllZCBpbiB0aGUgT1BFTiBBbGxpYW5jZSAxMEJBU0UtVDF4
IE1BQ1BIWSBTZXJpYWwNCj4+ICsgIEludGVyZmFjZSAoVEM2KS4NCj4+ICsNCj4+ICthbGxPZjoN
Cj4+ICsgIC0gJHJlZjogL3NjaGVtYXMvbmV0L2V0aGVybmV0LWNvbnRyb2xsZXIueWFtbCMNCj4+
ICsgIC0gJHJlZjogL3NjaGVtYXMvc3BpL3NwaS1wZXJpcGhlcmFsLXByb3BzLnlhbWwjDQo+PiAr
DQo+PiArcHJvcGVydGllczoNCj4+ICsgIGNvbXBhdGlibGU6DQo+PiArICAgIG9uZU9mOg0KPj4g
KyAgICAgIC0gY29uc3Q6IG1pY3JvY2hpcCxsYW44NjUwDQo+PiArICAgICAgLSBpdGVtczoNCj4+
ICsgICAgICAgICAgLSBjb25zdDogbWljcm9jaGlwLGxhbjg2NTENCj4+ICsgICAgICAgICAgLSBj
b25zdDogbWljcm9jaGlwLGxhbjg2NTANCj4+ICsNCj4+ICsgIHJlZzoNCj4+ICsgICAgbWF4SXRl
bXM6IDENCj4+ICsNCj4+ICsgIGludGVycnVwdHM6DQo+PiArICAgIGRlc2NyaXB0aW9uOg0KPj4g
KyAgICAgIEludGVycnVwdCBmcm9tIE1BQy1QSFkgYXNzZXJ0ZWQgaW4gdGhlIGV2ZW50IG9mIFJl
Y2VpdmUgQ2h1bmtzDQo+PiArICAgICAgQXZhaWxhYmxlLCBUcmFuc21pdCBDaHVuayBDcmVkaXRz
IEF2YWlsYWJsZSBhbmQgRXh0ZW5kZWQgU3RhdHVzDQo+PiArICAgICAgRXZlbnQuDQo+PiArICAg
IG1heEl0ZW1zOiAxDQo+PiArDQo+PiArICBzcGktbWF4LWZyZXF1ZW5jeToNCj4+ICsgICAgbWlu
aW11bTogMTUwMDAwMDANCj4+ICsgICAgbWF4aW11bTogMjUwMDAwMDANCj4+ICsNCj4gDQo+PiAr
ICAiI2FkZHJlc3MtY2VsbHMiOg0KPj4gKyAgICBjb25zdDogMQ0KPj4gKw0KPj4gKyAgIiNzaXpl
LWNlbGxzIjoNCj4+ICsgICAgY29uc3Q6IDANCj4gDQo+IFdoYXQgYXJlIHRoZXNlIGZvcj8gVGhl
eSBhcHBseSB0byBjaGlsZCBub2RlcywgeWV0IHlvdSBoYXZlIG5vIGNoaWxkDQo+IG5vZGVzIGRl
ZmluZWQuDQpBaCB5ZXMsIHRoYW5rcyBmb3IgcG9pbnRpbmcgaXQgb3V0LiBCeSBtaXN0YWtlIHRo
ZXkgYXJlIGFkZGVkIGJ5IA0KcmVmZXJyaW5nIHNwaSBub2RlLiBJIHdpbGwgcmVtb3ZlIHRoZW0g
aW4gdGhlIG5leHQgdmVyc2lvbi4NCg0KQmVzdCByZWdhcmRzLA0KUGFydGhpYmFuIFYNCj4gDQo+
IFJvYg0KDQo=

