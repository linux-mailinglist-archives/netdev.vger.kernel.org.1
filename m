Return-Path: <netdev+bounces-131472-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 637FE98E92C
	for <lists+netdev@lfdr.de>; Thu,  3 Oct 2024 06:40:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 18FC9287107
	for <lists+netdev@lfdr.de>; Thu,  3 Oct 2024 04:40:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9702D22F19;
	Thu,  3 Oct 2024 04:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="eKFBm9qp"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2060.outbound.protection.outlook.com [40.107.237.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3999D139D;
	Thu,  3 Oct 2024 04:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727930402; cv=fail; b=P1VJotGWN5hMrWMpRAspR4m0ZQdqUBb9BwqeSSr4nhhBM5Oy3KuUhMKY3Nx7wSaCesxpctvFUqVAqHq3UHOaGTpocga8XWU9i+gdEOsDsoxCdpKjw+CUcsQcnshyCiOD5RipQo3q2D0+iecLf3U5yu9PeAd4Y4ZI/u+jnKv1ftM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727930402; c=relaxed/simple;
	bh=tsS0fGQbjFCEnxKCAliC8zg7UpTOnqR0kQ6MAHVAth0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=gSpwb5JuG7bAxH/vOTY7qn1RPffDKpwEKWQ4FP+8zx+YUOQPBPRPxwox+YLyjfNpw8j3zHvo4Fkvc3lflpHF7HUu0U+Acr3JVTfgCgQAK1xk7iEXlbFghmrSJ8qE4z6E1q+0guR4iSXcBfdC+lVENfaMMeGTtabAbIOHQ4WwicI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=eKFBm9qp; arc=fail smtp.client-ip=40.107.237.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YcX4lvWK/LIALBeAtFCmV0eMWh/J8uiTNIWgy1oglyLKKnH5P21C3MI8xMHY6wgMzgfROFVwUaKAGCttpbrni7n6SGvtW1lt9GHWSDVGBCqcBtlcp/rV5aHives2KOrssMYN7FJgL4GPaIAukelxaE7pkhxTOscPOqXxr2EBf4GJT7vmf8iUdZHiETGIvCLsOpt8RotbInolP9PTtXmSEDzSSxv9y/N7RZS1nKp5OwIlvN3VwSnFPezvH9/ELFNSg3c5nNN2HRB2wyzdDUfhBSN8Q+WGHSRWWoXghv5Qnztyjk78mYiWqA1+MpaFlVLW+P67kseQLqYlfyjVximsZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tsS0fGQbjFCEnxKCAliC8zg7UpTOnqR0kQ6MAHVAth0=;
 b=R9wllocKiz96xSdGmw/iigugSpuJf3AJYCcl69OE504ByNgyibu5MGsIkncQotkjjUkTCzFtcIx0FDKXSeXWWgSuodIEN9xyqvwwC11AmOz51AroCSQZXvbKXqPYxtcu0tatYSsPyCMKkDyJreH/TiM+wI90evrYMYn0eHxV56YfqbLDXcOwTrKCf62ZercyyL04dB060Nh1V0k0YOcB1V5OfP1w5DyTiSOz3Henx39dqHZZDscclblLKj2kvjJAazUYoWGJ4i1K22GKvg1Ow4HoEtZh9TJsXd6rvLYaqC6n5C9g533pTSMRt0RWW2PLDEOerSH4r8BJG5XUSaYWpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tsS0fGQbjFCEnxKCAliC8zg7UpTOnqR0kQ6MAHVAth0=;
 b=eKFBm9qpb9z0xIDbvwcuE3uAixQc92ophnLHkrxIIDcXTxmYZ89YByWCeUR/Szp/77WeeJqa4Kxi3RCP6NWiUBV/9OgsmarYoCZafVe0s2xk2JZWTpOamAZEYmSdq91MADPKpgcJ4YDQdSZod8/uLgXf1b6gfATOqhLh2KpoEQEuuUYHAvMrsjpmRHK7bgTbAY6h2rbkywlX4q/LCtYICHUvcpBqaUzp5VGmA78qszCd2xBALagVrFpO+6qGOpAwaSrjHc3MVAdIU5BHa8BzG/inQnk7Be9BIMXKbnRSLc2RMsqYuOBc2qJN5DULk8mich9qod6LkMSi/mQlL3gSFA==
Received: from SA1PR11MB8278.namprd11.prod.outlook.com (2603:10b6:806:25b::19)
 by PH8PR11MB6927.namprd11.prod.outlook.com (2603:10b6:510:225::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.16; Thu, 3 Oct
 2024 04:39:56 +0000
Received: from SA1PR11MB8278.namprd11.prod.outlook.com
 ([fe80::84fa:e267:e389:fa9]) by SA1PR11MB8278.namprd11.prod.outlook.com
 ([fe80::84fa:e267:e389:fa9%5]) with mapi id 15.20.8005.026; Thu, 3 Oct 2024
 04:39:56 +0000
From: <Parthiban.Veerasooran@microchip.com>
To: <qingtao.cao.au@gmail.com>
CC: <qingtao.cao@digi.com>, <andrew@lunn.ch>, <hkallweit1@gmail.com>,
	<linux@armlinux.org.uk>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/1] net: phy: marvell: avoid bringing down fibre link
 when autoneg is bypassed
Thread-Topic: [PATCH 1/1] net: phy: marvell: avoid bringing down fibre link
 when autoneg is bypassed
Thread-Index: AQHbFTuSWh7N7+Pz4UGB4y4i0laF/7J0ciAA
Date: Thu, 3 Oct 2024 04:39:56 +0000
Message-ID: <020586e1-d832-4ef5-be99-459519eb005f@microchip.com>
References: <20241003022512.370600-1-qingtao.cao@digi.com>
In-Reply-To: <20241003022512.370600-1-qingtao.cao@digi.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR11MB8278:EE_|PH8PR11MB6927:EE_
x-ms-office365-filtering-correlation-id: 650ce269-e17a-4767-8ccf-08dce3656e9c
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB8278.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|1800799024|7416014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?Qk1La3lQL3g1VitUVGU1ZmlvN1BpRVZKeTB5Umk2c3o4MDVPYm4xckdwQnNG?=
 =?utf-8?B?dWxxZjNIQkNlQS9WMmlIbjNXZXFlRVNCQ0RxTXBVZzF0b2FJVjNUU25NUjdE?=
 =?utf-8?B?MmhrN1pSRWNpSk5aOGRRLy8zak5ucGdsTy95dE1Pc2hqZlpFRG5XdENoZTI3?=
 =?utf-8?B?TmdkenE0OGpLcWlITWlwQkpPTjBIM05vM1dWa2p2WGMyTWhnLzRsQ0dvcjlt?=
 =?utf-8?B?Q3V1aUpURG5EYjdrbTBmMkhGNTdIbzZCWEN3VjA1bzJxbmVMdTdsaDExRlQ5?=
 =?utf-8?B?anZrdy9rN1g1Q3Y1M21wZzNSL1FUdWh2SksrK3lWZ0NpV1NNeENQZzlmRHdn?=
 =?utf-8?B?blk3K1dCYlpnTWFhWGc2NzF0UHdWejBzRHBTeVZFQkZnOVVzaHhHTWR3VUdP?=
 =?utf-8?B?MWhUWlZudlNjYkFEdWllemV5SGlHTzNjaHBoaHZUdElnNVMxbkRxdzlDbVMr?=
 =?utf-8?B?NGY2MHlNNjZyMERGYmlUNWpEOXg2cHlaRkNCbE93NG9LSk1TZlJXTURBUWdq?=
 =?utf-8?B?RDJ5SEdEOUIvVXhvRHlWRHp6cEFKUnlrSG8zVDZCcWF6djdMZGs5dnJMRkh1?=
 =?utf-8?B?U2o1NVVrTko5LzhqOGJxclhwY1FJVnRiZlhzZ1N6TFBmVnUrVFJ2S0lGaks3?=
 =?utf-8?B?cmE0WlBQeTYyY2lFODBTYU5RYXVqOWhEZVNKczdTemhTc2xFNmJmUHl0QnJN?=
 =?utf-8?B?NVVITWdnVVBqbElBRFlQRjVRY0tJYmtXazhjZUpnRUdoaHFoN2FBYlNTNzla?=
 =?utf-8?B?RVJHeDMxMkZPT2IybVVrNm5kejJ1UzEyUXhRa1c0L0xKVksrcy9RZ1Q3bHRh?=
 =?utf-8?B?dWxrZFlyeUNwbFBqcnpxSnZuQkxacTBqei9KQWdYRm5PaFY5blN4NFFvbTB4?=
 =?utf-8?B?cWhRRTF5Q2RXWDdVYjlhV1dya2k3MVhGbE1GaUpoa2RzZTBIVmk1YTZQNlBh?=
 =?utf-8?B?dk5kRFV2RUdvRzkwOHUxTjNtcGNxbzZMd0k3bHUrem4rNTZzR05QS0lZV0Yy?=
 =?utf-8?B?MEVTQjZGT0RLc0lDVDlIWTZJQlE3NDhCRWpVU0NOcmhWWW1nQmo0NWdPWUhv?=
 =?utf-8?B?V252ejlJOTdsYzN3STIxQVhISk8vMlY0WWdQWE5TVU8zdElDN2UvaXdpNEsx?=
 =?utf-8?B?WnF3OUZEbnNhb25Fd0ZuV0hFSk1yS2JoN3ZhRk1wMjVubGFsRU1UK1lpR3FX?=
 =?utf-8?B?RkZDYjZEL1BpSkU1N2FMY01nQytnUEhTT2FqSU4rN3JVUkJsUE1aWHJGOThs?=
 =?utf-8?B?RVVQOU4raUpxWXZkMVY1SW9ORkIvdnpVNDFMUWdNc3A1dU91b3NkZWl1NE9S?=
 =?utf-8?B?K2JoUXo3NmI4OUZDMzVpSDNhellLNnFaTzM5SWZ2Q0x3TzVMN0prNUxLSXY5?=
 =?utf-8?B?TW9meFVSb2RnRU9TcHIzR00zVWpvMXBVWFR4dVpnaWxzOTlnVXV6RkRiaU5M?=
 =?utf-8?B?VUZqeFd6UXRiNkJYYzFUZkdBUFVjVVpEc1hDZWJSS01ESEVLWjZlNGpTZGt3?=
 =?utf-8?B?RmJ2UVBkNWdrcW1mT0l0MitKSnhOSkUvakRka0xPUStXQTZYbGpEZ29PdXpa?=
 =?utf-8?B?SXFiSG1xeG5TUktNa2s2dG5ieEIzOG4rR2lhWjJBNjBHQkRjOGJyWXVjRjU3?=
 =?utf-8?B?SXdKeDI1MlFtRzhwdXJFV1J0S1pieUpZakQ5R1JEQW5NV29wRG5MdDNtUTJa?=
 =?utf-8?B?MmJjZXJDUDdvNFpXUEY5Y1FWVnpocDNpLzkrbVBlK3FIdkE2ZDBwQjhxK0xN?=
 =?utf-8?B?bFF6Tktudytqb08xMHo1aEFrZHJibkQ1dlFxV0krTUd2UU1VOWdOODEvNkdy?=
 =?utf-8?B?ZnY4czV1SmtYVis4UlMxQT09?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?bHVRRmdCd012dVN0eFAwd3lBQVQ2QnFCVU5GY1JJNEttd2FPdi9qYlcwMWVS?=
 =?utf-8?B?TTVncSszcllrN2Fnc0gxK2NuVVQyMmNjNGFiK2tyY3BJU0lZRERMWVg2VzQw?=
 =?utf-8?B?LytzVkpONFd4QlBwRDFCVDJ1YS8yb3FrOS9NcW14Z0xnZ1Qwanp1eVZJOEFB?=
 =?utf-8?B?L0MxajJ0eGloV3lmRmJvTmJpVVAvQ2Qwb3YvK0JVMUorZ3NlZTYraFltbldt?=
 =?utf-8?B?SEpFNVQ1WlZ3UVArVU5NVU1qODYvMkpDZWxGYmtETDRwSTFFYXBjalVXUnFp?=
 =?utf-8?B?ajg5SHE5dDNXTG05M1EvdW9IZDJjcUpZdzZiMnlmQ0h5NGNteUNhNU0xOXFD?=
 =?utf-8?B?SFNlZ0pJcStBc1VjY3VLZlUyN3phRnZEbzJFZWJrUkk0QkJnQklabDYzUFN4?=
 =?utf-8?B?T09LWTY1TzNQa08yMEVXZjdBMitrRk1LQmY2NHE1Vk9iZ1hBUHZBb1hDazM4?=
 =?utf-8?B?L2RMSHR0aDY5TTZCR3V6dlJRb3JpVldiby9kQXFYYURaMHdSaWY3bXBnVHhk?=
 =?utf-8?B?TXRzamYvZWsvckF1WHdqM3h2dlR6NEM1R0p3S2pwdS94UVhUOGt0WjlEMUVr?=
 =?utf-8?B?Y2RFdm8yUUZpQ0VMUEtvdTlIQnN2dEVvTW5kQmhlbW5rNVJoRkZjYlBPU3R1?=
 =?utf-8?B?MENiSzdpTXhLc0VNMmw0WjBRWk5NR1h1amlqTzVpcU9vUk82TStoUWFmOHNX?=
 =?utf-8?B?SHp1N3YrbzR2T0xUWTJ4U24vaXU2OS9UWlpKVW9TUFd0VDNSNVpuUnVXS3Jp?=
 =?utf-8?B?dTlsWFc0anl2MDUrTXBSbnZVNTN1SHNUZStvVFVVcFcyeXdGanc5R2Z0eUlo?=
 =?utf-8?B?a0JmY0ltWVRrbkl5Nzk5MEtHU3oxV0VyczNNRHBMdzZWeVNHODl5K0kzMG9H?=
 =?utf-8?B?N0pqMEg1SUo5TWJialFVSHkyWkw3bFpsbkFEOHMxTEFwa3RoRG42QWVONkF3?=
 =?utf-8?B?QnRqMVRVU1QrVkFqcnk2V0V0QlEyRWpob0lNRDdFQmVsY3RiU1lNNWdjbkhz?=
 =?utf-8?B?RlZFelU2Uk1acnNmNFFKSFc3NmJnNFpkRm1oZXBiMW1mcjBGUS9BZktoQVM5?=
 =?utf-8?B?UWh0REdHNTZ4eVJPZVAvc0NmZWYwdTBLazJ3cUZGSFRWMUNSR21taFV3a2Zm?=
 =?utf-8?B?YVIvSm9Zb2c1UGc2bkNTQlNhMUY5RlFiYlZMUWRDZVBuWXkwWGdMT3dsdHVP?=
 =?utf-8?B?NXFhT0tDMHpNSHo4TmJFVTY4VjVsMUdKamlXMmo5bHpXYU16N3F3U0NHaXEr?=
 =?utf-8?B?ekx3R0N1UHU2MjE2ZnMxMHlqOEVPQlZrbjIwT1pUbzN2NUYrNTJpMUZQQnJS?=
 =?utf-8?B?dVFIRVFuc2RJcVBiZG1GLzZlalprZW5xYVJzQlBhYWdBMy95UHZVcmFjYkVp?=
 =?utf-8?B?a3I2OFAva2t0ZktPN1pUU2V1blo3OVhLWUtZSFo5ZlBXRnF3UGo1QUZIcXhF?=
 =?utf-8?B?SThqcXhLSDBHeEVCQ2M0cXZDYWpTeDNySnNEc1hMZjN4Mkt4SDQ4TXd0YkVx?=
 =?utf-8?B?SXBzeU1TU2VOZ0d6czFseXJjcU1xalgxRjRGQ2FrdHFNTzFqZ1VMcmovTVFC?=
 =?utf-8?B?THpGWWIvc2tNeFNpL1U0dk9FcGprQ2ZIZ3JmZXNPQm54djNQeDZaV3Y4WmV1?=
 =?utf-8?B?bExMaDg0b1JhNVB5Y3BYZjlYRXRwdW8vcUNyUFROOUgreDE5cFBaUStJOXdV?=
 =?utf-8?B?Ni80a1dFTEV6eUpuMzU3MjB1akJERGhSMDVDQmRyeXFYY250d2tobmdobEJW?=
 =?utf-8?B?Y3BXZVFZR2x2eFJuV29jNFQ4MTA3SjgvTzBZNEQwRTFpTlhOWGJhWWNELzFx?=
 =?utf-8?B?TEdWS1BoUi9taVZQc1lsd29HaWtYVTUveHBuMU1YcWwwZENMWnJKaDRlVTdX?=
 =?utf-8?B?Uis1ZHlkNTZFU29CZ1hPeU1GdEFCM3ZIVTRsOVdkcXVDZDYxZ2kvSFNpS3Y1?=
 =?utf-8?B?SFNQZlJOUzFhK3daOFozM05VWnJjVWtyaCtRSTNKbG9ZTENkM3YxL1M5cUR5?=
 =?utf-8?B?Z05yeUdwZ2FJeU5Zb1p2UnFnS3FkWldUd3ZrRm4wOEk1b3ZZcDM5Tm1LdXU4?=
 =?utf-8?B?NmFNYVpXM2lBTnMzbFNMeElXQjg0RDZOOU1waTh6N1J4T2lvQTJ6ZEllMnRh?=
 =?utf-8?B?TDlqUFpwS1NVU0UxYmowTkhaQ250RWxwOTRyOEFkNzBHSXY4d2VDT3ZBNEcr?=
 =?utf-8?B?RVE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0A72F310E92566488D31FEECDED80984@namprd11.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 650ce269-e17a-4767-8ccf-08dce3656e9c
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Oct 2024 04:39:56.6501
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ICoAFzPTjsbYOie+hhxm5/9ltoqX+kXp/eK3h+2He5fSXfMkldyP3aTTZDVMKF3dPq9t4R1VYwhDvDA5mzU8wS/WYmJ68hd+3BBddax8riL+e/EjAGB3niCgSbdb+RzX
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB6927

SGksDQoNCk9uIDAzLzEwLzI0IDc6NTUgYW0sIFFpbmd0YW8gQ2FvIHdyb3RlOg0KPiBbWW91IGRv
bid0IG9mdGVuIGdldCBlbWFpbCBmcm9tIHFpbmd0YW8uY2FvLmF1QGdtYWlsLmNvbS4gTGVhcm4g
d2h5IHRoaXMgaXMgaW1wb3J0YW50IGF0IGh0dHBzOi8vYWthLm1zL0xlYXJuQWJvdXRTZW5kZXJJ
ZGVudGlmaWNhdGlvbiBdDQo+IA0KPiBFWFRFUk5BTCBFTUFJTDogRG8gbm90IGNsaWNrIGxpbmtz
IG9yIG9wZW4gYXR0YWNobWVudHMgdW5sZXNzIHlvdSBrbm93IHRoZSBjb250ZW50IGlzIHNhZmUN
Cj4gDQo+IE9uIDg4RTE1MXggdGhlIFNHTUlJIGF1dG9uZWcgYnlwYXNzIG1vZGUgZGVmYXVsdHMg
dG8gYmUgZW5hYmxlZC4gV2hlbiBpdCBpcw0KPiBhY3RpdmF0ZWQsIHRoZSBkZXZpY2UgYXNzdW1l
cyBhIGxpbmstdXAgc3RhdHVzIHdpdGggZXhpc3RpbmcgY29uZmlndXJhdGlvbg0KPiBpbiBCTUNS
LCBhdm9pZCBicmluZ2luZyBkb3duIHRoZSBmaWJyZSBsaW5rIGluIHRoaXMgY2FzZQ0KPiANCj4g
VGVzdCBjYXNlOg0KPiAxLiBUd28gODhFMTUxeCBjb25uZWN0ZWQgd2l0aCBTRlAsIGJvdGggZW5h
YmxlIGF1dG9uZWcsIGxpbmsgaXMgdXAgd2l0aCBzcGVlZA0KPiAgICAgMTAwME0NCj4gMi4gRGlz
YWJsZSBhdXRvbmVnIG9uIG9uZSBkZXZpY2UgYW5kIGV4cGxpY2l0bHkgc2V0IGl0cyBzcGVlZCB0
byAxMDAwTQ0KPiAzLiBUaGUgZmlicmUgbGluayBjYW4gc3RpbGwgdXAgd2l0aCB0aGlzIGNoYW5n
ZSwgb3RoZXJ3aXNlIG5vdC4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IFFpbmd0YW8gQ2FvIDxxaW5n
dGFvLmNhb0BkaWdpLmNvbT4NCj4gLS0tDQo+ICAgZHJpdmVycy9uZXQvcGh5L21hcnZlbGwuYyB8
IDIzICsrKysrKysrKysrKysrKysrKysrKystDQo+ICAgMSBmaWxlIGNoYW5nZWQsIDIyIGluc2Vy
dGlvbnMoKyksIDEgZGVsZXRpb24oLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL25ldC9w
aHkvbWFydmVsbC5jIGIvZHJpdmVycy9uZXQvcGh5L21hcnZlbGwuYw0KPiBpbmRleCA5OTY0YmYz
ZGVhMmYuLjUzNWM2ZTY3OWZmNyAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9uZXQvcGh5L21hcnZl
bGwuYw0KPiArKysgYi9kcml2ZXJzL25ldC9waHkvbWFydmVsbC5jDQo+IEBAIC0xOTUsNiArMTk1
LDEwIEBADQo+IA0KPiAgICNkZWZpbmUgTUlJXzg4RTE1MTBfTVNDUl8yICAgICAgICAgICAgIDB4
MTUNCj4gDQo+ICsjZGVmaW5lIE1JSV84OEUxNTEwX0ZTQ1IyICAgICAgICAgICAgICAweDFhDQo+
ICsjZGVmaW5lIE1JSV84OEUxNTEwX0ZTQ1IyX0JZUEFTU19FTkFCTEUgICAgICAgICgxPDw2KQ0K
SSB0aGluayB5b3UgY2FuIHVzZSBCSVQoNikNCj4gKyNkZWZpbmUgTUlJXzg4RTE1MTBfRlNDUjJf
QllQQVNTX1NUQVRVUyAgICAgICAgKDE8PDUpDQpIZXJlIGFzIHdlbGwgQklUKDUpDQo+ICsNCj4g
ICAjZGVmaW5lIE1JSV9WQ1Q1X1RYX1JYX01ESTBfQ09VUExJTkcgICAweDEwDQo+ICAgI2RlZmlu
ZSBNSUlfVkNUNV9UWF9SWF9NREkxX0NPVVBMSU5HICAgMHgxMQ0KPiAgICNkZWZpbmUgTUlJX1ZD
VDVfVFhfUlhfTURJMl9DT1VQTElORyAgIDB4MTINCj4gQEAgLTE2MjUsOSArMTYyOSwyNiBAQCBz
dGF0aWMgaW50IG1hcnZlbGxfcmVhZF9zdGF0dXNfcGFnZV9hbihzdHJ1Y3QgcGh5X2RldmljZSAq
cGh5ZGV2LA0KPiAgIHsNCj4gICAgICAgICAgaW50IGxwYTsNCj4gICAgICAgICAgaW50IGVycjsN
Cj4gKyAgICAgICBpbnQgZnNjcjI7DQpGb2xsb3cgcmV2ZXJzZSB4bWFzIHRyZWUgb3JkZXJpbmcu
DQoNCmh0dHBzOi8vd3d3Lmtlcm5lbC5vcmcvZG9jL0RvY3VtZW50YXRpb24vcHJvY2Vzcy9tYWlu
dGFpbmVyLW5ldGRldi5yc3QjOn46dGV4dD1Mb2NhbCUyMHZhcmlhYmxlJTIwb3JkZXJpbmclMjAo
JTIycmV2ZXJzZSUyMHhtYXMlMjB0cmVlJTIyJTJDJTIwJTIyUkNTJTIyKQ0KDQpCZXN0IHJlZ2Fy
ZHMsDQpQYXJ0aGliYW4gVg0KPiANCj4gICAgICAgICAgaWYgKCEoc3RhdHVzICYgTUlJX00xMDEx
X1BIWV9TVEFUVVNfUkVTT0xWRUQpKSB7DQo+IC0gICAgICAgICAgICAgICBwaHlkZXYtPmxpbmsg
PSAwOw0KPiArICAgICAgICAgICAgICAgaWYgKCFmaWJlcikgew0KPiArICAgICAgICAgICAgICAg
ICAgICAgICBwaHlkZXYtPmxpbmsgPSAwOw0KPiArICAgICAgICAgICAgICAgfSBlbHNlIHsNCj4g
KyAgICAgICAgICAgICAgICAgICAgICAgZnNjcjIgPSBwaHlfcmVhZChwaHlkZXYsIE1JSV84OEUx
NTEwX0ZTQ1IyKTsNCj4gKyAgICAgICAgICAgICAgICAgICAgICAgaWYgKGZzY3IyID4gMCkgew0K
PiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGlmICgoZnNjcjIgJiBNSUlfODhFMTUx
MF9GU0NSMl9CWVBBU1NfRU5BQkxFKSAmJg0KPiArICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAoZnNjcjIgJiBNSUlfODhFMTUxMF9GU0NSMl9CWVBBU1NfU1RBVFVTKSkgew0KPiAr
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgaWYgKGdlbnBoeV9yZWFkX3N0
YXR1c19maXhlZChwaHlkZXYpIDwgMCkNCj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgcGh5ZGV2LT5saW5rID0gMDsNCj4gKyAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICB9IGVsc2Ugew0KPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgcGh5ZGV2LT5saW5rID0gMDsNCj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICB9DQo+ICsgICAgICAgICAgICAgICAgICAgICAgIH0gZWxzZSB7DQo+ICsgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgcGh5ZGV2LT5saW5rID0gMDsNCj4gKyAgICAgICAgICAgICAg
ICAgICAgICAgfQ0KPiArICAgICAgICAgICAgICAgfQ0KPiArDQo+ICAgICAgICAgICAgICAgICAg
cmV0dXJuIDA7DQo+ICAgICAgICAgIH0NCj4gDQo+IC0tDQo+IDIuMzQuMQ0KPiANCj4gDQoNCg==

