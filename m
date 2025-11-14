Return-Path: <netdev+bounces-238577-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 65417C5B61C
	for <lists+netdev@lfdr.de>; Fri, 14 Nov 2025 06:19:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0934C4E1F5F
	for <lists+netdev@lfdr.de>; Fri, 14 Nov 2025 05:19:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96CB12BE053;
	Fri, 14 Nov 2025 05:19:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="HN9eIsaz"
X-Original-To: netdev@vger.kernel.org
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011004.outbound.protection.outlook.com [52.101.52.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A23F518AFD;
	Fri, 14 Nov 2025 05:19:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.4
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763097560; cv=fail; b=WQcAFYUpv3I7ad6yKZ5avROoc/K9mSSc1OQsEVCkfNbOalReWdgEZouoByj+wB6Of5dMYnySdRPCXsYyDQ1UcUvT3kHZL7nbnurzKeyxDeNrbN0ibKqNnJVbh0EO5Sk/BQdqDQ/3IvC4nuG00VG55vdKvnVu1kutrdfv40u71Lg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763097560; c=relaxed/simple;
	bh=PbOKEA1TQc5VJb9aSYvG1fAR3/yGMX+gJ+r1DUHHNY8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Q7+G2fky4gJxL9sjvuAGkZFSzCeU4Io+ZZvVgS5rssBr3eEkN1bdcWKYCdjPos6DcnBUt3b+X3X1CbRB7sHzMtCTqisNnzjh3BWQJjoUzNroDUAQ4kXsmB6a159d7MBZFwv2iwCdlLjryW9Q4y9Y+PNgazcWNEt4yQ41w6O9Hyc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=HN9eIsaz; arc=fail smtp.client-ip=52.101.52.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vZ0pGkT/Cys9iXh6z7UyUmSMCNsIHv3Dq0H5qZySTAoQh0DNaqacRWLJKAvdlpq3be4lKWln/oaKGC0G+r67GwFICpyi/Jmsv+qplgYpELiwcskJwFb+8nLI+fJAkfRgsT/qFm6JJjsc1s1b5l2t0Dh9fXpkGJSgtz2WCYXFOt1gHxwtGu2KVwERPzraoL76zoHFzCup1dTPSdLjAPC4xKxZVL01A7dMBfFnoBSC2hFo8hGZ47gWlGILZiP2W4UPi2Q0KHg4v0S77HtSgI4mx2DxnPKfJtb/SPRIDztFx6mBNU5Wv02M/nrUuTJeswjQKatGLHiEQii0s60IyrIfgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PbOKEA1TQc5VJb9aSYvG1fAR3/yGMX+gJ+r1DUHHNY8=;
 b=UfOCkuGs3YvqNlDL4+C0GQ9ZW2box1AcuPqMaa+XV87om2ISt7+/+sP9R+LutLPvX9aNW9OnpAi1stm2xBc5f7UFFpWie4afFfnay35V7gLISohIgDXjNOJjbu6IbGcZmK2rX0UX2nYafGEu0vpQW+zc9caO47PTFuLjJ+zM6V7tLuebMlMApwgMeZNlEUmdXVB6T1FrqMrHdUsxyxiceT32mfMfOgQryw0KJ0PtC8//qtOJj8t89e3wvwpMoPdLG+XVExz4QdMASew30NztUEfmXiOtmV8K3UPIzRlzMD5YAsRoIxWeTN/301AC/5jdVvUtfmXHzLFppvF40troFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PbOKEA1TQc5VJb9aSYvG1fAR3/yGMX+gJ+r1DUHHNY8=;
 b=HN9eIsazivqbuGtdVI7r2lbZtLfiOj9MYO3+Sr91qCWG+X286yMi4rQNhWgSRpwSR3iCPy7ndYMVuEyFE8l9jx8YeLw/2LqAD4yuYwj52g2+lYZprQFX2C2lM0y6aBrW07ZRn4XRht5h33aW1GzEz3DJ63GHHvjaCXwozDJ3UqY/iv6NEiYOaC6x8Wkgtt627hrCTNUjjC8nsH9ZnbPDYtghjDM2PjIqTFxncf0rGzyr4j8mlgS/OfVu9LBljQ9f+XBOwrElXWFPTkRWoAbvEoAq6IV8KwGU5MB+xZSuFP5ruOIBBok6YPSFeGMhLS0NzehxoZCCFjRiBhItkGAZrw==
Received: from SA1PR11MB8278.namprd11.prod.outlook.com (2603:10b6:806:25b::19)
 by SJ2PR11MB8513.namprd11.prod.outlook.com (2603:10b6:a03:56e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.17; Fri, 14 Nov
 2025 05:19:13 +0000
Received: from SA1PR11MB8278.namprd11.prod.outlook.com
 ([fe80::84fa:e267:e389:fa9]) by SA1PR11MB8278.namprd11.prod.outlook.com
 ([fe80::84fa:e267:e389:fa9%5]) with mapi id 15.20.9320.013; Fri, 14 Nov 2025
 05:19:11 +0000
From: <Parthiban.Veerasooran@microchip.com>
To: <andrew@lunn.ch>
CC: <piergiorgio.beruto@gmail.com>, <hkallweit1@gmail.com>,
	<linux@armlinux.org.uk>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next 0/2] Add SQI and SQI+ support for OATC14
 10Base-T1S PHYs and Microchip T1S driver
Thread-Topic: [PATCH net-next 0/2] Add SQI and SQI+ support for OATC14
 10Base-T1S PHYs and Microchip T1S driver
Thread-Index: AQHcVJP9alko1AG3OECj+T2qZ1Gto7TwnNkAgAEGaoA=
Date: Fri, 14 Nov 2025 05:19:11 +0000
Message-ID: <fb697284-001d-4433-a05a-d96b335f27c4@microchip.com>
References: <20251113115206.140339-1-parthiban.veerasooran@microchip.com>
 <7e3ccf4d-f046-427e-8ad8-85cfc850a3cc@lunn.ch>
In-Reply-To: <7e3ccf4d-f046-427e-8ad8-85cfc850a3cc@lunn.ch>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR11MB8278:EE_|SJ2PR11MB8513:EE_
x-ms-office365-filtering-correlation-id: 3478f0af-65d9-43d7-db89-08de233d588b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|366016|1800799024|376014|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?QVlicC9LMFkySU9HZG9GeERCSGc0b2YwTWUvUG9LVEpNQ3p1N1V0UFNMWjJK?=
 =?utf-8?B?U2FuM1Z4L0J5Z2J3Ykl2enM4a3hWOHJMSkFHS0VPZ1RGQVBJUHZ3RmM1UThW?=
 =?utf-8?B?cWZoVWVzV3p3eDBoK0RJR1VXV0NzRFVKUmhTMFdtdXcrUENpcEkvKy9VTGJl?=
 =?utf-8?B?bUNoZ3ltMzFnZlRUOHBrRHJGWkk4dVBVN0V5OURFUCttWmlKTTFBT2w5V1FB?=
 =?utf-8?B?aUVZYk1lSk5tSmVoN3JGK0tWdHNmQ2cyZjhKTmprb05UcmJSZ2pKLzdIVmV2?=
 =?utf-8?B?R3U2QnBIeWk5dnVpMkhBSmdFYnlYTzE1R2x0c2NkWTF5OEduRzZ2UzdpVDB3?=
 =?utf-8?B?RUMrd2Via3JTTHI1N3VNa3FydlAwa0U4Q3VRUWhtaHJzU1cvSFFvU1JRRHM1?=
 =?utf-8?B?RC9mT1RjY3YxUVpvSkxoZElpdUVwYzNMam5TTjhXVE5YUE12YnBoZ256UWN4?=
 =?utf-8?B?YjRsVlVjTnpPQW9Sb3RKRGtwQVIvL2NNVmtuVDNUNTVabmFnUjlZQWo5eE9O?=
 =?utf-8?B?bkgvKzNPV242M281L2VGM004MDlNSEd2T2M3eXpibFpXOVM4akMzRnhYUjBy?=
 =?utf-8?B?MTBMbVhGL2Z3WS9aQnlSSkt4dkt4WEkvZ2hNdUQyeWphS2tIUVFBb0lWaHo0?=
 =?utf-8?B?TkZPN1VTcy9MYURyWUMvVkZHcE14ZFRlcWRSYXlwR1ZTSHBmWHRyR2I4R0NV?=
 =?utf-8?B?cWNoMUl1bHkvOFVkZlJoVVFoNVh5TThBeFMvSThKRCsyaDdTM1FWUVlIZFdk?=
 =?utf-8?B?MXhDN1VZbmd1Qkk4RW42WGxyZS9KOXIwNkFic3RvdUZTUW5IY0JMZ1o3SlNi?=
 =?utf-8?B?SDJjTVA1UUZPaGE3QjVGUkpyK1RmMTVkbXVoTk83ZkZ4L1dLUVRwL2JoNGNv?=
 =?utf-8?B?WUFoTW1NWXNJZzk0ekQ3Y0Rac1djRkxkeUlpYnUyNUtpdnE1UHp1Qi8ybUhy?=
 =?utf-8?B?YnNWRTh3UHVydUpxVldPVFRrWERHZE9QRys2Y3BWWDJtRHVhR0hZTWRXejZK?=
 =?utf-8?B?cGpoTWR3T240NHpQYUNxSzBVZnllbC9jYkZjOUdWbDdjSURKUHZwOUR5WStS?=
 =?utf-8?B?aTA0RklNQVU0cE44QUFoWFloY3I1UURlV0Z5VnpVNDJNaUxlejJ6MW1sSUdT?=
 =?utf-8?B?cWpndFpDaHp3aXJQRmt5T0ZhblJGZE1Zb1dqY3lENEd1UmViQnBWc0I4Mk42?=
 =?utf-8?B?OHkxWkRpd2RIKyswQ3VINzZ4N0FUUXNETnhzeHlRN0FJeWxEUU1xRUhQYmpW?=
 =?utf-8?B?S3o0VGFoUFl0S2N6SVlhWEJzbGpia3hpcmZvZTZDVlRtR2c4cUtzb3hIbDhZ?=
 =?utf-8?B?d1VzaHhURDhSMG1YcE40aEJOb1p0SGJaTEVkdlpJWXNKQjVNNjFZRndtT3lz?=
 =?utf-8?B?Z1p2NWQvQlBwdlcvUTg2dVdnOWNDODg0OFMwTm85VnlwVVdDUGJMNE9MT1ZS?=
 =?utf-8?B?bnB6akhHVytqSUtNZW9iQVVURVh2ZFpCS3dYS1dOWTB0VThMbDBNRHpZbTY1?=
 =?utf-8?B?OGMwQXcxZnpPcWRjSHBhWThycDhjczV1T2ZWQmhBRVFzNi8wb210bkorSWFO?=
 =?utf-8?B?RkR4STd4NkM0Z3ZzbmlvR0U3UUxPWHNxcTlHSDAvTFdrR3dleFRSbjJqNUN0?=
 =?utf-8?B?ODljeGh2UGF2bmdNNkFJV0J1ZWl2RDV5TEhoeDYxZmZLRk81ZzM3aFJoMzJm?=
 =?utf-8?B?cC9FSE1FbDFFUDJlY1U4KzlqQ3J1akNhV1hWYTBEUGM4bUZ4VDJJYkUzVGZF?=
 =?utf-8?B?NFEvNUNKell4R0xqOHdkc2J5aVFvcEdockFHNzlXVUF5emQvaXpIdUJ4Tmwv?=
 =?utf-8?B?clYrb3BEdTVrK3l6Z2Q4OHU0MUZkanZqOUlVKzVtNkFEZmJtSnM0aXd0NXYy?=
 =?utf-8?B?aHZxN2kwQy9zMFcrYXNQa25iYXR4d1JFRmtlYVp1RkFiZC9pL3VkMWZnaE9T?=
 =?utf-8?B?ZDZDSzhhVDQxQzBTZnlhVlRCMTIxZk1oalQ4a1VmZ0hTd05pbmIwRmp4dUlm?=
 =?utf-8?B?d3pudllkQzg3cWpycVF0d0RlYWdROHN1am1rd2dUQTJMLzV4R21jN3NnNEFB?=
 =?utf-8?Q?KAr6n/?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB8278.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(1800799024)(376014)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?dExMc1Iyb0hYK1RQNUJVaThkY1J2eWF4K1V2ZzhHdGpIK3VOc0lrMTdYZmhu?=
 =?utf-8?B?VWJsQjZtNVY3R0hhOEx5ZitFU1hTNndFOEN1ekY1djRSVnp2SFZlYXpiYXRl?=
 =?utf-8?B?MXRVM0hpT2hDSUZ2YkZ5a2lPM09sS3NkY3RTZlM0Z0JMdGtybFhHVU1pb2JL?=
 =?utf-8?B?OWtjdXZMdWxMUmZSbzB5QkFMcW9ZQTE3V2tGYWNkeDBJYlQ0NjF3UGowbDR1?=
 =?utf-8?B?Rk1YOVF3eXRGZitTVzJmQ0JheXF2cHc2ckc1WFc3MXZUT0hTRTl5RmhoUFVw?=
 =?utf-8?B?b0lnaGhBWlJRU2tTWkhRTHh0eVdZZHdqSGphcUJwZzBTQkFqTXhrYkJYbFpi?=
 =?utf-8?B?THBBMnlFWm13RE1xRUNsd2w5ZlY1ZURwUlk3LzFtMUR3WXNmMWVyOHd4eFFE?=
 =?utf-8?B?N2FqRG5maTBNR0Nqalhya1Mwc0xadDJ6ZFdBTldmcGJrcTNqd01wNHBLcVdG?=
 =?utf-8?B?RXVMcU1KNVhYdkJGRXhUNnZ1bDNPTHpTckY2amtwYks0ZnVsZjJtUkh5SWZL?=
 =?utf-8?B?S3piZHNKZFdKb1B6VGlEZ2JTRFNrbHR1V0Z2ZUpzU2dncFltVzBaeGxzVkVy?=
 =?utf-8?B?RzZ5RmJWWk1VbDNUTzBRc2ZSNVAyNHBKSlQvdy9GcGt5ZysrVzlQMTBnQmdJ?=
 =?utf-8?B?aFlBQmtxRmJlNXFrVHBGUVhRZExrZkRmUmtlSTVuY2ZGeDNNT1l1RVpjKzFv?=
 =?utf-8?B?VEFJYmo4eE5GM1ZNMjl5UVVONEh4bEo4V0V4Qk5CaGVYbC84VG1GajB2L0NV?=
 =?utf-8?B?TFdMVm83VU1PaTNIZmtjOGQxMzR1a01HMWJzL29mUHRQU1dVTFJQWHlZaVYx?=
 =?utf-8?B?NlB6cVRRR3dnR3o5dXlEaktURG9RNVMvQStna0xHbjB2RC9oYzJZRE0xTzlR?=
 =?utf-8?B?WkJIbmRETndpN2VXMXZsL293a0M3RGZDVkJpZXk3ZHNYRGR0Nm14U1EvUVB6?=
 =?utf-8?B?UGtRS2ZNWG82YWo4SnIwVk5kTXRwb2hMN1U5ZDZ5aUVFSGMwVnhHUjhKTVdN?=
 =?utf-8?B?MjhndVlhZVNJaG5Fa0J6TUJMWmNWS0J2OGhEZ2JpOE5LT096amhYNjUrU1ZD?=
 =?utf-8?B?cDdBMFllZjVJTzUzR0JleFhBa3RtZ0RTNnRhek9qNTYwY1haYzBpeXd2ZVFr?=
 =?utf-8?B?b3hUNHpyL2VSN1I5OEhKUFA5ZUZMaTFjelc2eWxBRDl6L2cwYndubnhKd2pr?=
 =?utf-8?B?SVB3MVAvdlVnektmQk0xVDRBR0h3QnpMWG00bUhqUUROK3lmZisrbzVmNDVs?=
 =?utf-8?B?M0RhS0k2b2hXSGp4ek5vT0NxSWRpUnBiMmFldE5YR2s2N1VYVmtzQXBjbmtZ?=
 =?utf-8?B?L0xuRlhVcWJPblFNTktReTZwWC80a3FGQU9iaU9VUmQ1TEI1c3kxZ0tObHFn?=
 =?utf-8?B?akpzZmtiMkdjcXp2OVY0OWwrQldYMTd5Uk1PVVR2TWZoeHhSUCtxSEhJbHdP?=
 =?utf-8?B?d2srN2w2bVlBbk10Q3lpbzhPYjdUWlR0N0RhT2Zkam9YS1NvakNyWWRJM3Bm?=
 =?utf-8?B?Mk1zN2Q3MEFHNmFRK0VOWStXSDNLSGhnYVZrRFEzanh5MGFGQnZVb0NWdVpV?=
 =?utf-8?B?UjlnNnFPTGttcWpReWxRZ2piaDlUVkxQMkZXK0dBQ0lpKzJLWXRKL3dHN1JL?=
 =?utf-8?B?NUMwdUcxTnlLWXJJeTdYQnh5eklxSzlvTytaQ0NId3cwWTNQekplalVWa3pw?=
 =?utf-8?B?RTdSenhmcVFJbHZlMXBoYTMrdko1MUtOZzJDSWQzbGNLenEzMGQ3T2VSZk5x?=
 =?utf-8?B?Mk5FYVlGKzk3MzIrMzJwbXFmU1lqUHBRb1FUVUpqYlA5dXFOTE9BSkJndEV4?=
 =?utf-8?B?VlBZMWhJYmU2cjBsakQwcFp2RFozWU1KenBzWU02RVZtbE5rSWcyOVNiWXlH?=
 =?utf-8?B?STl0TkJucFJyaVRmMm4zaWpaRlh6U05vSVBXN0g5VnhZQ1ZHUU55b2s3d2VL?=
 =?utf-8?B?ZkxYR2lBWnJaQ21lV1k4RGltOE9uRWtidVZuVnZoMlU5RTlhSFJkcks3TmFK?=
 =?utf-8?B?aTllS1hCZFNuVnRCSUI4VGxBOG9KajgrSmhpOFlJK0JyejQrTDVIaEJ3dDlw?=
 =?utf-8?B?eXJEUU5IUUhoTjlNUE1qYjlyNnI3bS9TaURMUjc0RjhlM3J5d3NSMUNhdmdT?=
 =?utf-8?B?RmlHeHV0b0ZJenI2SUhKbUZjU2RWV25zbk9SVTVYVk9tZDdDd1JHMDcvOEtn?=
 =?utf-8?B?RGc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <7360B357DE5EB243AD0449C269C725FC@namprd11.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 3478f0af-65d9-43d7-db89-08de233d588b
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Nov 2025 05:19:11.8367
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: p7/npW16PEdNRdSDF3NaXuJKnb5MH66uINr9DPcmrBxFFeenR4kuxm40WoMd/cY3DEbrfI5OQWAToRqCVxS2aS5YKNRpH5grYR6sD54YIyNtObYhQ/kM7AJIKx4rvaW8
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB8513

SGkgQW5kcmV3LA0KDQpUaGFuayB5b3UgZm9yIHJldmlld2luZyB0aGUgcGF0Y2hlcy4NCg0KT24g
MTMvMTEvMjUgNzowOSBwbSwgQW5kcmV3IEx1bm4gd3JvdGU6DQo+IEVYVEVSTkFMIEVNQUlMOiBE
byBub3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBhdHRhY2htZW50cyB1bmxlc3MgeW91IGtub3cgdGhl
IGNvbnRlbnQgaXMgc2FmZQ0KPiANCj4gT24gVGh1LCBOb3YgMTMsIDIwMjUgYXQgMDU6MjI6MDRQ
TSArMDUzMCwgUGFydGhpYmFuIFZlZXJhc29vcmFuIHdyb3RlOg0KPj4gVGhpcyBwYXRjaCBzZXJp
ZXMgYWRkcyBTaWduYWwgUXVhbGl0eSBJbmRpY2F0b3IgKFNRSSkgYW5kIGVuaGFuY2VkIFNRSSsN
Cj4+IHN1cHBvcnQgZm9yIE9BVEMxNCAxMEJhc2UtVDFTIFBIWXMsIGFsb25nIHdpdGggaW50ZWdy
YXRpb24gaW50byB0aGUNCj4+IE1pY3JvY2hpcCBUMVMgUEhZIGRyaXZlci4gVGhlc2UgY2hhbmdl
cyBlbmFibGUgaGlnaGVyLWxheWVyIGRyaXZlcnMgYW5kDQo+PiBkaWFnbm9zdGljIHRvb2xzIHRv
IGFzc2VzcyBsaW5rIHF1YWxpdHkgbW9yZSBhY2N1cmF0ZWx5Lg0KPiANCj4gSGlnaGVyLWxheWVy
IGRyaXZlcnM/IEkgZG9uJ3Qga25vdyBvZiBhbnkgZXhhbXBsZXMgYXQgdGhlIG1vbWVudC4gIEFy
ZQ0KPiB5b3UgdGhpbmtpbmcgb2YgYSBuZXcgYm9uZCBtb2RlLCB3aGVyZSBpdCB3aWxsIGRvIGFj
dGl2ZS1iYWNrdXAgYmFzZWQNCj4gb24gdGhlIGJlc3QgU1FJIHZhbHVlcz8NCkkgdGhpbmsgSSBt
aXNzdGF0ZWQgaXQgaGVyZS4gSSBtZWFudCB0aGF0IHRoZSBoaWdoZXItbGF5ZXIgZHJpdmVycyBh
cmUgDQp0aGUgT0FUQzE0IDEwQmFzZS1UMVMgUEhZIGRyaXZlcnMsIHdoaWNoIGNhbiB1c2UgdGhl
IGdlbmVyaWMgQVBJcyANCmltcGxlbWVudGVkIGluIFBIWUxJQiB0byBvYnRhaW4gU1FJIHZhbHVl
LiBDdXJyZW50bHksIHRoaXMgcGF0Y2ggc2VyaWVzIA0KaXMgaW50ZW5kZWQgb25seSBmb3IgZXRo
dG9vbC4NCg0KSSBzaG91bGQgaGF2ZSBkZXNjcmliZWQgdGhlIHBhdGNoIHNlcmllcyBtb3JlIHNw
ZWNpZmljYWxseSBhcyBmb2xsb3dzOg0KDQpUaGlzIHBhdGNoIHNlcmllcyBhZGRzIFNpZ25hbCBR
dWFsaXR5IEluZGljYXRvciAoU1FJKSBhbmQgZW5oYW5jZWQgU1FJKyANCnN1cHBvcnQgZm9yIE9B
VEMxNCAxMEJhc2UtVDFTIFBIWXMsIGFsb25nIHdpdGggaW50ZWdyYXRpb24gaW50byB0aGUgDQpN
aWNyb2NoaXAgVDFTIFBIWSBkcml2ZXIuIFRoaXMgZW5hYmxlcyBldGh0b29sIHRvIHJlcG9ydCB0
aGUgU1FJIHZhbHVlIA0KZm9yIE9BVEMxNCAxMEJhc2UtVDFTIFBIWXMuDQoNCklmIHRoaXMgZXhw
bGFuYXRpb24gY2xhcmlmaWVzIHRoaW5ncywgSSB3aWxsIHVwZGF0ZSBpdCBpbiB0aGUgbmV4dCB2
ZXJzaW9uLg0KDQpCZXN0IHJlZ2FyZHMsDQpQYXJ0aGliYW4gVg0KPiANCj4gICAgICAgICAgQW5k
cmV3DQoNCg==

