Return-Path: <netdev+bounces-64426-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E98B833106
	for <lists+netdev@lfdr.de>; Fri, 19 Jan 2024 23:57:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 728CE1C20F7A
	for <lists+netdev@lfdr.de>; Fri, 19 Jan 2024 22:57:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 137675821D;
	Fri, 19 Jan 2024 22:57:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="M2zkQw/q"
X-Original-To: netdev@vger.kernel.org
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2049.outbound.protection.outlook.com [40.107.95.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47D0F56B7B
	for <netdev@vger.kernel.org>; Fri, 19 Jan 2024 22:57:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705705035; cv=fail; b=HYonLxpyCFFRltADUq1Bw3NamMeJYW3voMWVj4zQBoOpoT5CH+U2YRF9elJNwX6ZlVbpWBNokm7Yinp8OkoL+DxdYRbiSTicAHKUrXHZ2MYDS9koqmi8XmT1D9RQWxG71FzdPSj7eilVRhrKbgvo3HKfGEC5eqUd9AVC+QkaITc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705705035; c=relaxed/simple;
	bh=J0DaujI94ivPA8ea+Sve7HFynTIKlQc7Tl/NLvbOoVI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=N6Rr6THvT4uUtT58LMK1urGy6rNQgVbUvr7uYRi0o59kGakCo9ayyt/Id4QsxcyrbJWOw9PEH1YS2qdn2tmYGW8v4+At7iwIN2F0moh8lAk3R8wm0xIAOy86zmx4jZwJR2yTbE/cRaNVpfN4TfrcPdLR6IuaAkth3S55VgCWLT4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=M2zkQw/q; arc=fail smtp.client-ip=40.107.95.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K7ocPDKWEcK/IVKrGPJapBlzN0enX8JIP/XeJAUNVSx+ceYAXLXxYIE4wiNjRQJHJsme9/4D157eQw7Ol4dSSvqzcuBo21wv4BKli/UuwXh4+JTnzTt9mAvjD5QEE7LJAfUCdjWfLCqiMnTPgRu5uGq7rJwGzoUQTtO3O99Z/PFd+6ezw8iH0xCjEjExnXoIGr0RWUWYOXxzAwK2ijK7KymxJEy13eqVytEx1OyEHWnuzHxbveBn8w+Fg5qe64+IK92OwbMZJkaTIv8RATUYozAt5yMgrDn49SOPWXRn2C+NHmOj6HyUSiBhep/1Znx2X2JxUqshWZEWN5/6ymGKGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J0DaujI94ivPA8ea+Sve7HFynTIKlQc7Tl/NLvbOoVI=;
 b=n+XFXMs67/FX7S/AWKlm4NJGPpi2ryOH/97QktsMfcwF1njVznMbRKypiNWgGfR67uMf/ySFUa2WhS0SD2OcuDxornoVbo4D15Fj8pjFhSjInkQHh08TqOV9d6UnX2bGdMjc9QXewXjiCX5CKQXdvABGsx3yYXbhhWrZqHtPnz1gu35b1vch0uWesW3+BboaI14ozjdFgODh1GSBY03r9tFr/XcRNe6rQCCTdJTsGWejg5VMJ9LkiBzaPtMdA08doTODFCsqu3pWZXubRQm/j/cY647WDphDP4eZde70bwYFx0iYfSKarQ/d4oIF2+af3srxaiA9HfyhdahBlpMG1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J0DaujI94ivPA8ea+Sve7HFynTIKlQc7Tl/NLvbOoVI=;
 b=M2zkQw/qbMORyNwSkXMpy6Pm2IoXhUNbiwLFucWsPc803+onQ+Goafd2/y0DFbH5vy5ndYbRDjTNAgTxX4l4ALCCsHclIKY0xta2BEsEPvEscvgbdUh0Nv4E94Ln3F5Qi71hs/zCvnUUuKzulNQDsYRyTHGud9hRXah+2hG5YN6d45ECWdknZnOkexfBlTN5HDbw8MM9ECrpIr0yQC0oO54xEb+jvFvvjVpr9vVHIBGikZ7oS+1nSeSnmuHCDjcGPiq0mNY1HE9YrAbdh/J2nrQ8vflNy44m1Cwpfq8SbhpDoOqta8nOn0/JthPBVNGo0ZchTPO3mAvCU0kq7VyhJA==
Received: from PH7PR12MB7282.namprd12.prod.outlook.com (2603:10b6:510:209::7)
 by BL1PR12MB5032.namprd12.prod.outlook.com (2603:10b6:208:30a::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.26; Fri, 19 Jan
 2024 22:57:10 +0000
Received: from PH7PR12MB7282.namprd12.prod.outlook.com
 ([fe80::f245:9cfe:fe84:ae14]) by PH7PR12MB7282.namprd12.prod.outlook.com
 ([fe80::f245:9cfe:fe84:ae14%4]) with mapi id 15.20.7202.026; Fri, 19 Jan 2024
 22:57:10 +0000
From: Asmaa Mnebhi <asmaa@nvidia.com>
To: Andrew Lunn <andrew@lunn.ch>
CC: "Russell King (Oracle)" <linux@armlinux.org.uk>, "davem@davemloft.net"
	<davem@davemloft.net>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	David Thompson <davthompson@nvidia.com>
Subject: RE: [PATCH v1 1/1] net: phy: micrel: Add workaround for incomplete
 autonegotiation
Thread-Topic: [PATCH v1 1/1] net: phy: micrel: Add workaround for incomplete
 autonegotiation
Thread-Index:
 AQHaOAaE4SV+OFEcQEq30M+e72jYobDG55uAgABwPwCAGjhxMIAAH2YAgAAEHpCAACx6AIAAAv9Q
Date: Fri, 19 Jan 2024 22:57:10 +0000
Message-ID:
 <PH7PR12MB7282CE51CB37C0D67EC6DA7DD7702@PH7PR12MB7282.namprd12.prod.outlook.com>
References: <20231226141903.12040-1-asmaa@nvidia.com>
 <ZZRZvRKz6X61eUaH@shell.armlinux.org.uk>
 <99a49ad0-911b-4320-9222-198a12a1280e@lunn.ch>
 <PH7PR12MB7282DEEE85BE8A6F9E558339D7702@PH7PR12MB7282.namprd12.prod.outlook.com>
 <a6487dbc-8f86-447a-ba12-21652f3313e8@lunn.ch>
 <PH7PR12MB7282617140D3D2F2F84869DBD7702@PH7PR12MB7282.namprd12.prod.outlook.com>
 <f35fa6b9-ed6f-461b-a62d-326fa401bc88@lunn.ch>
In-Reply-To: <f35fa6b9-ed6f-461b-a62d-326fa401bc88@lunn.ch>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB7282:EE_|BL1PR12MB5032:EE_
x-ms-office365-filtering-correlation-id: 8103fddd-a5e4-4b6b-8499-08dc1941f7d4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 97xVUuxbiUJtclSM/RO6GizAGnUraGR4+xBJZrOBGiDo8lxN4kFC+DYeXv6LS7bZqsusuQZoP6M9hU/KaVPfxfRExSxQZijWtkhUAT1j+RZHOZ+iv3F4pbuCAD+5K6aNIJwgHkG5vhBfUomQRnB4gxIWWIx7x0Afp5E/Bp2Q8aJxoB5/dht52P5mhhBkdeINudl3jQ4q2aFbp6xLYuX84iWjlw+fT3ovX7ohKjbwCCKNnT8AwRtYp5WXYTr162etnaq2/0MTq7YTGhNKAXAD3ZvT5xeWChvR8sKKoT31dWF2RMZci3O9jnzkTmbdp7Fvl0j5NJJUCi82CaRpCYGlcg1Tuw+l5xn1SBZ4d5kG5V6jN3UNiQS2HUDLWYPlM475a+SO7VyjH+74ZelJ13c3Pff2tCqB4Ouo/Q1SGoHUhIgGh+MpmCNYrpTUHt8RiX7G+EOMIugGDE5VeVUdVub8ZqZNVjboaBBN6PoVcEVr+uD0ffbrT7Z2yuepn5d0FchwQwO/S5ntnlVLR/4I6WnV2tJn1XNSO2zf3Hv2UeH3+imo1W8iZWeWc5lP1/m3xFDo8smcMtyRAksvPW/0kV2cCtkLutoW+X7B0xMySZ3Qn2MtZWCYuOx0e+eSVsEi5AjL
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB7282.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(366004)(136003)(376002)(396003)(39860400002)(230922051799003)(186009)(64100799003)(451199024)(1800799012)(122000001)(41300700001)(33656002)(86362001)(38100700002)(83380400001)(478600001)(4326008)(64756008)(7696005)(6506007)(71200400001)(8676002)(8936002)(316002)(76116006)(6916009)(66446008)(66946007)(66476007)(66556008)(54906003)(26005)(5660300002)(2906002)(9686003)(52536014)(107886003)(38070700009)(55016003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?TmtwVmdocVNpYnJCNU05dXhYVzRkbDduSVRWYzVZcE5kVUM0d3VVamY0YzJr?=
 =?utf-8?B?cUtLSkhkQXlJaThkZXpTVmpKNXA5d2g4bkpqQmZGNHpkVm85YlJ2RDlzRUtU?=
 =?utf-8?B?VURKVlVXWFAweExNZDBscldpeGtiSDZYTG1wL1ZYbFdScDN3NDVjY242OXdz?=
 =?utf-8?B?dHZVYnlwR0t6b2VEUGE3M29STlpJYTBSU3RpS0FZWE5kc2hLME5haDF6SHVG?=
 =?utf-8?B?UmEvK0tKOTNJalNlbkpGSTd5Z3NWak9HSDlwU2FDMDNHNDBHbHVxSElhOFEw?=
 =?utf-8?B?bkZZeXlaQ1Nha0Y3NzVDb0lMVTJTay93bFV1TXc3T2pGRlUwNDQ3WnBvVFNC?=
 =?utf-8?B?UXE5ZUd4dzBEcmFEQ24yT1BTOG5SZUVJejRGT3Yzdnh5Y0JVYm9BcmNMd3ky?=
 =?utf-8?B?Z210dGFBUWZLN3dDeEdocmV1TW5sMzZQYzVSZzN6WEpyeStyemJtZm9Hb3FU?=
 =?utf-8?B?T1R5ME1aK0hZZExnYXU2N3BSZXlOUnlCbnp1K0JkeTBxWUl5OWxGcTUrWjdX?=
 =?utf-8?B?U3JWUzF6ZThvMjBrT2ZTS0x4Mmw1VjdzQzEvUDFHNHFYV01pbkxrZ0xvQlBW?=
 =?utf-8?B?Y2dCT2FVNU5pUk9mL3lBSVBxcFBCNzFsVGVjSkhsVGVzT3AxaHNSaFlId3VM?=
 =?utf-8?B?c1c5MW9FdlBoN1AwVDdNdElVL1ZIbVlTV045T2g3VHR1czZxcWt6bHNIODZB?=
 =?utf-8?B?NWlSa2FCdXpJQ2ZJVXVBRXNndnB1VS9Vd0Q4Y0lvUCtVdzZYTllRSXE4Snp5?=
 =?utf-8?B?VVJhaTNEVnhhR1hYR1M1b2lxekhrRmhRVjY3ajNUL0JBaUhncG5waWdTMW9G?=
 =?utf-8?B?Z25ZaWVrNkc4dExidWp3S2Zpd0lEeWJDMms4eVBZTlNWb0V3V1VxbGRxY1BS?=
 =?utf-8?B?Q1dia21qa1RDVE9TSExFWUtZc3RqYXo4THRTYWtRNkVWNEdpVW9ialJSKzdL?=
 =?utf-8?B?UE5UVnBrWFlZbW94NG1NQ3lPR2NhNkIxeTZVWjFFNGdsUmtxOGdqa2lsTjQ3?=
 =?utf-8?B?djRDdTZYeWRpaVlURzFIeDRqOHpwWWV4a3oyTjdHc0ZxM3NmMmFNWFU4M00v?=
 =?utf-8?B?ZUN6RDhKcUl5QitSakViNmpReXV1OTNHT1dqWmdvWC9ETmt6R3FEdGdscFVR?=
 =?utf-8?B?NmtlQzZvYkc1aWdrNFU1WitLMy9WUjM2YnNWTHMwRm5mb01nalZhdjF1bWJm?=
 =?utf-8?B?cFNCVlNDK09ySGVHb1VOMEhaNGNSVTFBN0xkSm4weENwQ2pNMDNVOUhkMnZJ?=
 =?utf-8?B?VGMySGJPUmNISmZ6MGlRT1F2NnRuSkhLNVo2RmRMNjg3UUVUSEIxeHZIUi90?=
 =?utf-8?B?MERIUlVib0VMU1p6c2RtR25uUXBpQVJ5SVBMNGFONHZZWnRjZ0J4cmU1ck5G?=
 =?utf-8?B?SWJPbVgwSUtHRkxVNS9nUDhyTEdFNnZ6aUlQb21vYmNNc0JMbFp0M2U0d3F5?=
 =?utf-8?B?U01Id1loTUUxdTNyaCtWNGYrd1NlVHY0a0ZsdTNyZ2htRyt2VUQ5QndWUzR2?=
 =?utf-8?B?eGJTN3hacktFYnp6WjFDWDBxWEkrdnByZG1YeEsxYU1OK1RRdEZ6cU9rZDhC?=
 =?utf-8?B?QUVRMGtPM1FydmpOZDdVcFJKRUdMY2ZCaVJjT0ZGc1QzbjlKRWhqdW9ud0cv?=
 =?utf-8?B?ZXBCd1NkdVlGWFVVbm5DQmc3UlBoVU11Nmp2RG5RMnlNbVNWYi9tRU9TOXhl?=
 =?utf-8?B?S3pmeUlHVGYwOWRRdXQvMzQ3Wjg3ckdVN1NVd3BFNGZMc0RGV0s4UENPSTFi?=
 =?utf-8?B?M2djeDFoYzY4Zk1uenl4VXh2V3drWUVRbWRzRUVoeGdEWWZNdnZrbHIwNnlI?=
 =?utf-8?B?OXVlRTh6UFkrYXVyekhBWUNuQkhvUnlUVHpzSFpkTTRkcGlncFM1UHBKcFhq?=
 =?utf-8?B?K09ZM0J1ajRiUTVjY2FjNHdhcEpMajJIa3o0ZEFxRmphelExWmlYRVRzenlY?=
 =?utf-8?B?akc3Qkd2c1d2UFU2bXR2RzFROVZTL0FWWFpnSlIvS2t2bW1VMHd1M0hqbzEx?=
 =?utf-8?B?TzRMaGRWT1NVOWdnbGd3a0dlNVF0K3Uvck9oYysxRGg5ZEc1dnB1WHY5Yjkr?=
 =?utf-8?B?M1hBb1h0dnBvVDd0aU1nSWQ4MEFBVFY1MjdKVEV5enpUSHNXR2F1WHNTWllD?=
 =?utf-8?Q?iFH4=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB7282.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8103fddd-a5e4-4b6b-8499-08dc1941f7d4
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jan 2024 22:57:10.0616
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8x4ltoO1V7kcsIqWLhMcNvLUXiMzL83uvIq0NmAs2kIQWnCFrXoU26dUSd+AWNy7Z2ggXiI2jMJXA2TnHj2u+Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5032

PiANCj4gPiBUaGUgYWJvdmUgcHJpbnRzIHByb3ZlZCB0aGF0IHRoZSBtaWNyZWwgUEhZIHN0YXJ0
ZWQgYXV0b25lZ290aWF0aW9uDQo+ID4gYnV0IHRoZSByZXN1bHQgaXMgdGhhdCBpdCBmYWlsZWQg
dG8gY29tcGxldGUgaXQuIEkgYWxzbyBub3RpY2VkIHRoYXQNCj4gPiB0aGUgS1NaOTAzMSBQSFkg
dGFrZXMgfjUgZnVsbCBzZWNvbmRzIHRvIGNvbXBsZXRlIGFuZWcgd2hpY2ggaXMgbXVjaA0KPiA+
IGxvbmdlciB0aGFuIG90aGVyIFBIWXMgbGlrZSBWU0M4MjIxICh3aGljaCB3ZSB1c2Ugd2l0aCBC
bHVlRmllbGQtMw0KPiA+IHN5c3RlbXMpLg0KPiANCj4gV2hhdCBpcyB0aGUgbGluayBwYXJ0bmVy
PyBGcm9tIHRoZSBkYXRhc2hlZXQNCj4gDQo+IE1NRCBBZGRyZXNzIDFoLCBSZWdpc3RlciA1QWgg
4oCTIDEwMDBCQVNFLVQgTGluay1VcCBUaW1lIENvbnRyb2wNCj4gDQo+IFdoZW4gdGhlIGxpbmsg
cGFydG5lciBpcyBhbm90aGVyIEtTWjkwMzEgZGV2aWNlLCB0aGUgMTAwMEJBU0UtVCBsaW5rLXVw
IHRpbWUNCj4gY2FuIGJlIGxvbmcuIFRoZXNlIHRocmVlIGJpdHMgcHJvdmlkZSBhbiBvcHRpb25h
bCBzZXR0aW5nIHRvIHJlZHVjZSB0aGUNCj4gMTAwMEJBU0UtVCBsaW5rLXVwIHRpbWUuDQo+IDEw
MCA9IERlZmF1bHQgcG93ZXItdXAgc2V0dGluZw0KPiAwMTEgPSBPcHRpb25hbCBzZXR0aW5nIHRv
IHJlZHVjZSBsaW5rLXVwIHRpbWUgd2hlbiB0aGUgbGluayBwYXJ0bmVyIGlzIGEgS1NaOTAzMQ0K
PiBkZXZpY2UuDQo+IA0KPiBNaWdodCBiZSB3b3J0aCBzZXR0aW5nIGl0IGFuZCBzZWUgd2hhdCBo
YXBwZW5zLg0KPiANCj4gSGF2ZSB5b3UgdHJpZWQgcGxheWluZyB3aXRoIHRoZSBwcmVmZXIgbWFz
dGVyL3ByZWZlciBzbGF2ZSBvcHRpb25zPyBJZiB5b3UgaGF2ZQ0KPiBpZGVudGljYWwgUEhZcyBv
biBlYWNoIGVuZCwgaXQgY291bGQgYmUgdGhleSBhcmUgZ2VuZXJhdGluZyB0aGUgc2FtZSAncmFu
ZG9tJw0KPiBudW1iZXIgdXNlZCB0byBkZXRlcm1pbmUgd2hvIHNob3VsZCBiZSBtYXN0ZXIgYW5k
IHdobyBzaG91bGQgYmUgc2xhdmUuIElmDQo+IHRoZXkgYm90aCBwaWNrIHRoZSBzYW1lIG51bWJl
ciwgdGhleSBhcmUgc3VwcG9zZWQgdG8gcGljayBhIGRpZmZlcmVudCByYW5kb20NCj4gbnVtYmVy
IGFuZCB0cnkgYWdhaW4uIFRoZXJlIGhhdmUgYmVlbiBzb21lIFBIWXMgd2hpY2ggYXJlIGJyb2tl
biBpbiB0aGlzDQo+IHJlc3BlY3QuIHByZWZlciBtYXN0ZXIvcHJlZmVyIHNsYXZlIHNob3VsZCBp
bmZsdWVuY2UgdGhlIHJhbmRvbSBudW1iZXIsDQo+IGJpYXNpbmcgaXQgaGlnaGVyL2xvd2VyLg0K
PiANCj4gYXV0by1uZWcgc2hvdWxkIHR5cGljYWxseSB0YWtlIGEgbGl0dGxlIG92ZXIgMSBzZWNv
bmQuIDUgc2Vjb25kcyBpcyB3YXkgdG9vIGxvbmcsDQo+IHNvbWV0aGluZyBpcyBub3QgY29ycmVj
dC4gWW91IG1pZ2h0IHdhbnQgdG8gc25pZmYgdGhlIGZhc3QgbGluayBwdWxzZXMsIHRyeSB0bw0K
PiBkZWNvZGUgdGhlIHZhbHVlcyBhbmQgc2VlIHdoYXQgaXMgZ29pbmcgb24uDQo+IA0KPiBJIHdv
dWxkIG5vdCBiZSBzdXJwcmlzZWQgaWYgeW91IGZpbmQgb3V0IHRoaXMgNSBzZWNvbmQgY29tcGxl
dGUgdGltZSBpcyBzb21laG93DQo+IHJlbGF0ZWQgdG8gaXQgbm90IGNvbXBsZXRpbmcgYXQgYWxs
Lg0KPg0KDQpUaGUgbGluayBwYXJ0bmVyIGlzIGEgc3dpdGNoIChLU1o5ODkzUikgc28gSSBhbSBu
b3Qgc3VyZSBzZXR0aW5nIHRoZSA1QWggcmVnaXN0ZXIgdG8gMDExIHdvdWxkIGhlbHAuIA0K

