Return-Path: <netdev+bounces-241903-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 77838C89ECF
	for <lists+netdev@lfdr.de>; Wed, 26 Nov 2025 14:07:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id CF749359172
	for <lists+netdev@lfdr.de>; Wed, 26 Nov 2025 13:07:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 906A8238D5A;
	Wed, 26 Nov 2025 13:05:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hitachienergy.com header.i=@hitachienergy.com header.b="WVwtaeTG"
X-Original-To: netdev@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012042.outbound.protection.outlook.com [52.101.66.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EE972135C5;
	Wed, 26 Nov 2025 13:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764162324; cv=fail; b=unCqZkqn9ca5rfp/0GYlQGny/3XJLbmmxuefAwC8g3jCDXIV+Gdw/pHd2Qiq1a0aX671UMogizeO055aJPWpqJKZtyoSeYZ5oELx8Omivcmxg5KVD/14jBP2qsS3FK4+Ca4JXs3eF+1dCRxbmx1oN7/zH76q3g0XYN9DE3MbIhg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764162324; c=relaxed/simple;
	bh=Ae6EFurkm/pvLuBAt6zwTk0KH++VwfBH0SqQ1ZfAjeM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=eKk1EX+vXuFZUMSEjHzs72Oga1vrqwPZtRpsUWLa8mg6Mf9zGcTZTOPdoqupUMTowb7EbkuDOe9muMtxNIAQXDDzGaSHYvFmNf0UMR2G3F2yEStxctCYa+ZI+/rBIR72ZWAMa6gE4mqqNu/TcuOV49PQU9jAlqPw+a91osDDRt0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hitachienergy.com; spf=pass smtp.mailfrom=hitachienergy.com; dkim=pass (2048-bit key) header.d=hitachienergy.com header.i=@hitachienergy.com header.b=WVwtaeTG; arc=fail smtp.client-ip=52.101.66.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hitachienergy.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hitachienergy.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=A4YAuGdEe8p7XkaFBmQAZZuduO8OR9MZXB3jwsVkaMrs8Glr7zEQzmWOtVkE/50kIQ5xmHFTJZQlmVVatBzc/Db3yCXORN9QFY3NpsOfTuj48ir4XpHV4RqrNNq0R2FABdgTjkbsHsS0Sy6hPWQw+6Qya2bQu10hh9YAyom2dPe5Mw4svWmMovl3jFWXCg7lBlZwxdWIE48zDVCi/UWHy2ArM7UCXf9M1WK5xjyIeysC8A51NRySKyaLtCU9012cHfKuLQaf5oN2jDt/lda+52sSLt1Uh+KXP33sT7q6PMTvk3f/7XWjg+T85O2HcGDNRLfsgqEe/j9BY74Pfy98rA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rs03IUE6Yhq8Ts+5w43cE8/L0xi1DVYwpv7khh1IoCk=;
 b=k9Y0Vz/38ZwiCoNyyroFatUe0yZvPsYh7o77OI02uUTuOrHC+f/1YO4TCA1mB7prB24hOEsFU83PiieJnS9yRYxABZxU4QSq5ocr8EAQcmVcmIVXk2LVk1HDHreNi2O0+MhYAuDzixs3yQNKJCSIGjFAXsxRnfr/CrAHJnh44KRTsIPH/FZ/JvosNRfFOMpWXBB47iVfSNS4Bq8196Ncw//ypsGamb1Zv8V5dO6aVBBrtJ+hf+q4Gb8pr73u0Mc9D2T1v+Jd+95rzzKUY0lgDXXedFiiAGLRmXOlTUdRjhy0BGacQ6mdRyWNoLjkdxoDcBuNZQnDIWG3XO+twLmVTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hitachienergy.com; dmarc=pass action=none
 header.from=hitachienergy.com; dkim=pass header.d=hitachienergy.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hitachienergy.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rs03IUE6Yhq8Ts+5w43cE8/L0xi1DVYwpv7khh1IoCk=;
 b=WVwtaeTGrZjrXkGT2wpNNtIoi+OIbz8O5ywPrOTQkCkTV8moYPJpVMKHw/4BLg1O55NJ7GNU6GRVSH+okPxKSanf2bHFG4EZJQoKSo1quLYlOGTDBCZDN0ugNgcvCSPKPKNaf7wZS6pZ+FxjBFblVdW7QRDn3KvEm+Yt1VOoEx6VoUieYm0erXq6lljquASSTk8eG4s+Izg8IDM4WI80pxI+ZwIuEdHPmc19rf0T0J7sg/bbw+YGpvFQPsdiz4ML1EqVJY7ISAbrlTT5+ab0l32uZmUCmYOZ5Y/J3k+NDVveDgqsX7XURx38XheI86iyGOK/p18PFXrU7Dr4smdb0A==
Received: from AM0PR06MB10396.eurprd06.prod.outlook.com (2603:10a6:20b:6fd::9)
 by AS8PR06MB7877.eurprd06.prod.outlook.com (2603:10a6:20b:3c1::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.12; Wed, 26 Nov
 2025 13:05:19 +0000
Received: from AM0PR06MB10396.eurprd06.prod.outlook.com
 ([fe80::f64e:6a20:6d85:183f]) by AM0PR06MB10396.eurprd06.prod.outlook.com
 ([fe80::f64e:6a20:6d85:183f%6]) with mapi id 15.20.9366.009; Wed, 26 Nov 2025
 13:05:19 +0000
From: Holger Brunck <holger.brunck@hitachienergy.com>
To: Vladimir Oltean <vladimir.oltean@nxp.com>
CC: Andrew Lunn <andrew@lunn.ch>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-phy@lists.infradead.org"
	<linux-phy@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-mediatek@lists.infradead.org"
	<linux-mediatek@lists.infradead.org>, Daniel Golle <daniel@makrotopia.org>,
	Horatiu Vultur <horatiu.vultur@microchip.com>, Heiner Kallweit
	<hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>, Vinod Koul <vkoul@kernel.org>, Kishon Vijay Abraham I
	<kishon@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Eric
 Woudstra <ericwouds@gmail.com>,
	=?iso-2022-jp?B?TWFyZWsgQmVoGyRCImUiaRsoQm4=?= <kabel@kernel.org>, Lee Jones
	<lee@kernel.org>, Patrice Chotard <patrice.chotard@foss.st.com>, Maxime
 Chevallier <maxime.chevallier@bootlin.com>
Subject: RE: [PATCH net-next 1/9] dt-bindings: phy: rename
 transmit-amplitude.yaml to phy-common-props.yaml
Thread-Topic: [PATCH net-next 1/9] dt-bindings: phy: rename
 transmit-amplitude.yaml to phy-common-props.yaml
Thread-Index: AQHcXqYGtlM98xQGlkSgPr5ML7/KzbUEqGywgAAalgCAAADHsIAABB0AgAAfPYA=
Date: Wed, 26 Nov 2025 13:05:18 +0000
Message-ID:
 <AM0PR06MB10396BBF8B568D77556FC46F8F7DEA@AM0PR06MB10396.eurprd06.prod.outlook.com>
References: <20251122193341.332324-1-vladimir.oltean@nxp.com>
 <20251122193341.332324-2-vladimir.oltean@nxp.com>
 <0faccdb7-0934-4543-9b7f-a655a632fa86@lunn.ch>
 <20251125214450.qeljlyt3d27zclfr@skbuf>
 <b4597333-e485-426d-975e-3082895e09f6@lunn.ch>
 <20251126072638.wqwbhhab3afxvm7x@skbuf>
 <AM0PR06MB10396D06E6F06F6B8AB3CFCBEF7DEA@AM0PR06MB10396.eurprd06.prod.outlook.com>
 <20251126103350.el6mzde47sg5v6od@skbuf>
 <AM0PR06MB10396E5D3A14C7B32BFAEB264F7DEA@AM0PR06MB10396.eurprd06.prod.outlook.com>
 <20251126105120.c7jtuy7rvbu4pqnv@skbuf>
In-Reply-To: <20251126105120.c7jtuy7rvbu4pqnv@skbuf>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hitachienergy.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM0PR06MB10396:EE_|AS8PR06MB7877:EE_
x-ms-office365-filtering-correlation-id: 48f75d09-3a03-47bb-9161-08de2cec7333
x-he-o365-outbound: HEO365Out
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|7416014|376014|366016|38070700021;
x-microsoft-antispam-message-info:
 =?iso-2022-jp?B?Tk15c0hRZ2NrQU1zclg1RjRHNUJheFEvcC9adlkwT2hXQStVK3d2VWNv?=
 =?iso-2022-jp?B?QmNEZGRES1JwYVprbXkvenA4YWRYZTRQZy9mWGVxdGZLc3VWSWoyUlNV?=
 =?iso-2022-jp?B?cUNoV0xXQUdyU2x6a3hOM0RvYTFmMmo3SDV0UzMzaG9KU2NGTWdaTXBF?=
 =?iso-2022-jp?B?aHhveDhmWG44alBSRDUwcHd6Wlcxd1BZYUZlcXRCMGlxWCtBVzNCeFkv?=
 =?iso-2022-jp?B?UHpuS2lpdk5RREI2bW43OENVdTRObXdHT2RRSTlSQlZaUXozVWdoTlhO?=
 =?iso-2022-jp?B?U0tyUXJBQTcvZkJlTmhVS0JtQmVmdXFsRWcwYldsSEpDUzJYQlJ4Umw4?=
 =?iso-2022-jp?B?NGVRV2g5VVZmZUJIdjlMbERDNDF5RzRoUmUwcU1OQ0xNQ3ZoL1YyODNG?=
 =?iso-2022-jp?B?ZDRKakJIZk5PWGlkZzdvZFdZN0hsYWwxS0FoNmxEeUdsUTdHblRvcURi?=
 =?iso-2022-jp?B?aUVZUjl5YU83cFlBYUdOcFZOS09hR2dqREt1L1cvUWZaVzBXSVROSjhR?=
 =?iso-2022-jp?B?M3Bnc2hIME9tdi83TnlMN3dxeVcxNUkyL0pPYnZJT0U0UkFyY0ZDSnEw?=
 =?iso-2022-jp?B?UDlEZ1UxOVc1TGVpTEZBc2FKUkJkaC9aK3pMVnJ0TUg1TGwvWFJCL0h4?=
 =?iso-2022-jp?B?Wld5dVZaalZudHpVREk2ci8rZmxmQTNNcW1FYWlHYXBQRGxxWGdSbXZ0?=
 =?iso-2022-jp?B?b1NpZVBmcXliS2ZEbDBYWFZzZmxzZHN4RnVGdUI2WnhGbDJRME5GVGE4?=
 =?iso-2022-jp?B?Yy9idjJ0d0hXNzk0T25IMTlqZU5lYWdRZWp4Y3ljOXBaS0JnNklkdjhp?=
 =?iso-2022-jp?B?VTdTcTVhVXF4RTg2S01td3hUS2RsU21WcEVBdkNGakhVb2tCdFhFV2g0?=
 =?iso-2022-jp?B?Qk5GaHkxMExyOUgrMk5HcVU4NStKZ2ZPRFpFb0lwdDY1blZRUDd0NUUr?=
 =?iso-2022-jp?B?VnptaGhrU25yM0F3d1YzRXBvREJtUXJJajVxMW1sc081OGFkbVZoVDFH?=
 =?iso-2022-jp?B?UzYzVzJYU0NDTXM1aHJlUHdiRisyZVJzQXVIcE9hNDNrNTdQYnZpQTNa?=
 =?iso-2022-jp?B?WW1jeWcwVytGOTl2eDIwb2JIdjlNV3p4WVVDbkp1Q29XS1ZQKyt0SEZy?=
 =?iso-2022-jp?B?anB5ekNlb0hHaGc1aXhMdmFva2o3cUlBdit6aXcySHJpVnlpcjJ4ak9K?=
 =?iso-2022-jp?B?YlozSG9YQnFJeWMwSVE1c0JMN0xJbkxuZUVtdDRMVXVhenROTHBVdVZT?=
 =?iso-2022-jp?B?Um1QUDNVdSs3aERNcXphNmdPVG40b0Q5NmpWZjVBalorSER4QmswK1dB?=
 =?iso-2022-jp?B?Y0Z2MUJ1dHlLZkJ5THNnZWFLYkxGWVNHZUt3TjFXOWtSdzVIcENyRjdl?=
 =?iso-2022-jp?B?ZUdvVmJlbDg1VzJUMlQwQ010UHY4ZFNueTlJNGVySjBqSlhXR3QvaHZm?=
 =?iso-2022-jp?B?R3BkdGo3ODJvRTNSTzdxbjJpY2xvTVVHL2h2Ums4VWdLL0xGUnpiZ0FH?=
 =?iso-2022-jp?B?YlNrTHd2S2Q3eUVoK3hCRXJPdFpwalRVYXRFZFFVWWRoczZMZU9jTHgv?=
 =?iso-2022-jp?B?MlZWdURaUldwZXBtSVZUSEcwWlFkbDE5Vm1sRmFhWTB1OEduSUtsd0gx?=
 =?iso-2022-jp?B?c2FxT1c2azZJbkRwQjcxUnlGVlJ3MHQzTTZTNTFjWkJVR2lNWDZ6cTJy?=
 =?iso-2022-jp?B?bk1PTC9uRCtIazdNT2psa0tQZWdTNnI4U2dxam5qM1pDK0JKSDhzWGJD?=
 =?iso-2022-jp?B?OWVWSkdxVzZkdjZnTUw2eWVDdmhUdThqZHVhKytiMmVodk5qUFVDcFd5?=
 =?iso-2022-jp?B?YW1Tb1lWSy8xcm5kT2M3eVMydTA2UFQ0VHY1aW5LRHluMlZKcXJwY2tn?=
 =?iso-2022-jp?B?V2l3TThPQWZnbGs1Uk9OWmk5SjFjeUpRYzU2M2hEb0FQelltRWFjMHRy?=
 =?iso-2022-jp?B?NS9XSkE2VE5SbkpOWFVCZWszY2c5UFJXS2pkbGNEZGM1c1N1ak5aQ1E1?=
 =?iso-2022-jp?B?ak1NOHdTYTRNZDNSVDdDczZ0ZkdOQUl0QXB0ZU0zVDJJTVo3aXlKUDV1?=
 =?iso-2022-jp?B?bGFVYmJQYVlBN1hucXFwMnBKTHpBblpYTmduVVpWc0xQenpvSUhlOEtU?=
 =?iso-2022-jp?B?bXNGV29henlqME83djVkSThBTWY4NkQxT3dBQVV4STJFT2hHYy80dlUx?=
 =?iso-2022-jp?B?d25kVjJhb3BUNllYcGZvbUpCRkdRMHlJ?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR06MB10396.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-2022-jp?B?Y09VRzlFV1VoOFI4aVJ6SWh6MldIOXRVbXVEOHc4MkVsUGVraXFpMEFT?=
 =?iso-2022-jp?B?enp1SUZhNHBTMXFEb0xOdzB1Ynd4U08yQ0Ywd1BVSHVJK1JxUzhVYjN4?=
 =?iso-2022-jp?B?dkYyd2dQemxrK3NGUXZKVGxNWDcyMVhuR2l3ODBKNFZhTm9LV1FDVS9p?=
 =?iso-2022-jp?B?cXhWR2M4eitRZCs1WWhnVVA2ajJBelRVQ0FScFlzb0pIdlRORzFLWkRV?=
 =?iso-2022-jp?B?VUZPVmJrNkN5M1FpT1pnQXRkMW1aVHk0UU9pWWJzRDlHS0o3cFZ6RXdr?=
 =?iso-2022-jp?B?Y2FISzdWOFdWSWMzVlY4NmdDMWRZQ3BNRTJ2ZWx0aHc4dnlMUWQxeFY2?=
 =?iso-2022-jp?B?eGdlSHhsTi9mMFBldGVnaFVmb0NCVGw2OHdWSmgwZ3NiTTdjcTI4Ykxp?=
 =?iso-2022-jp?B?NTR6Wi8xMWc2ankrZVZnR1JxZWxxbkloZlhYMnlIZ2ZuY2lkT1RjdzMx?=
 =?iso-2022-jp?B?SUZ3aHRHdkpwcy82blV4Y2tPM2JPRit2SU9oM2N5UkNXTVRwQVpSMHl4?=
 =?iso-2022-jp?B?SjkrS05PRFBpb1VSbUZDWk5VTEljaHhUM3N3SUdGbjArRS9WNXBtY3F0?=
 =?iso-2022-jp?B?YkcyVEpaenpYK3RkV0NreCt1cEVLYTM3VElHYmlJZ09oK1N1cWQ2WCs2?=
 =?iso-2022-jp?B?NUp0SkhNYXI3aG1pTDBrWmx5WVloUDVKVWNCNHFVVmYrNnhzbDFyaXB1?=
 =?iso-2022-jp?B?YXBla2p4S3BMR0o3UjN3WlcxcnJMN1dqdVgyVmJidk9FWnoxZWJQVDZ5?=
 =?iso-2022-jp?B?MkpuSGRBWWUyMnpZUWxvdWFsNzBuWCtlYzFZcVV1SVVoajVOQ2VTWHph?=
 =?iso-2022-jp?B?ZXVNYVRnOTRDN1l1M3lpNmlRZjJmSXN3c2pDcVk4UnA0bUpMdTZxK2ps?=
 =?iso-2022-jp?B?SXh1YXBOVkVyMTdEd2tnaHNxYzBYYndjUTRhTWpHblpBWnhjeVlWZnNY?=
 =?iso-2022-jp?B?ek9OOERKc2VnMHFCZ1RjajkyQlFoZ0NIVnJNVHdhUVlQdnhkY2hIZXRR?=
 =?iso-2022-jp?B?UStMOUZOS2RXUEhPaUxzeGFjTU16M0VlZVA2TG1hbmxCbEtGN0lIN3RM?=
 =?iso-2022-jp?B?VFlGb0JxNkhKNm5leW53Z2lOVzZORS94SVVISFh1UmZXKzJvUU5IWm4w?=
 =?iso-2022-jp?B?cVNqWlNkRlhNQkdFajNLbE10NHBFQjJzc3NmSUNlOUkwczJGdXp5QVFz?=
 =?iso-2022-jp?B?NCt0YVNzaU5pdk9qSWYrbnE3V081dTVNNnZsbXJFOXdFLzZ5VDlUYTlP?=
 =?iso-2022-jp?B?YXFLVWc0cUVGNzBPT1g4T0dzTHp2eTBCTFJKNkltNmJINS9QRE1LbGF3?=
 =?iso-2022-jp?B?VHNDUk1ZNGQ2MmNzQXJpNzEyeEpncGJNaUtVQ05uS0YwOTMxVmYwZXA5?=
 =?iso-2022-jp?B?WFltalZmQWgxQmwxWVQ1Z0VNTmMvOXBndHRVSGM2VWM2Z2kvZ1BKdlJ4?=
 =?iso-2022-jp?B?WVhLYTMyczBLZlRzaEV2dnFwdlFQd3c4Z3V6WTg0eXAwWW1EdWloaHZN?=
 =?iso-2022-jp?B?ZjdmTEFSb3hMalRaeWxWQVZtZjJOK2hYZHhZZHZLbHFVK0IrN3hWc1pm?=
 =?iso-2022-jp?B?Q3NSWG01UnhESlVSUDhsRVNjUzFuM3c4b1NZMTUzS1NjcTFISmVZd1JQ?=
 =?iso-2022-jp?B?VWJhQ3ZIdVBYaHNHajBxbGJuWkhsV21Ub0pEZ1BsaXY5NFZDVlVqM0gz?=
 =?iso-2022-jp?B?QW5YM0RnbVcySmFHbHR2eHE1Y2FoRm9LNEhwWWc3Sm9HR09EYjFoRUYr?=
 =?iso-2022-jp?B?Yk8rRkI5V2l4dXE2Y0RIZEIzVUVRWUJIWmdoUk5hRzgxazZKQ0NWR29x?=
 =?iso-2022-jp?B?bitWL0JFQytRTVE2OWp5Q1dkeis0aUJkWktiRUhrN25USXRzckZGbTRD?=
 =?iso-2022-jp?B?ZUdNcTZpamIxOUxkc25JYlAySTRBL2lKWDFPc3RCNXROME0ydW9EOHU1?=
 =?iso-2022-jp?B?M3AyZkN0NytDU2EyU2hFL1ZpMkJpMkM3dmxscFEwYjZCaWt0QUJCNW5a?=
 =?iso-2022-jp?B?MDhJdVh0WVVrZTZkNzExSkJDL3dzYWVEbGFNODAvcDlQeFEyR3IxQmxJ?=
 =?iso-2022-jp?B?bHk3UEtzT2J5K3NmODJLV1p5eWkza2w0V25kc0Nma0dua3pEemdaY09o?=
 =?iso-2022-jp?B?VHE5c3lQWUwrR01DRkh4VE5sbEN1NGp4RnVIV3l4T3VEYnZIRDJ5YzZy?=
 =?iso-2022-jp?B?S0MrOGFqdVBDWXAxTnA5dFpoL1psREVYVlJKMzE1S2NDSFdnRzliWnI4?=
 =?iso-2022-jp?B?cm1rcFYzR3dVckhoVXhGeUNmZTBreFQ0aWJEOUhDQ2hyRzZRaitXMWpI?=
 =?iso-2022-jp?B?UmdzNUU0TDBOc2psek5ob21oQWR3YmZiMnc9PQ==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: hitachienergy.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM0PR06MB10396.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 48f75d09-3a03-47bb-9161-08de2cec7333
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Nov 2025 13:05:18.9806
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7831e6d9-dc6c-4cd1-9ec6-1dc2b4133195
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2oKWyXVQrstq0mhME5I6yOrgOuevhlcd2YNbK3MRWsaFjgCO4rNuYRKpzmf6B3lkOmCgrsBU8dUu9jzGgTwkCr0uMrsOXwJ36hpYTf7XAEs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR06MB7877

>=20
> On Wed, Nov 26, 2025 at 10:45:31AM +0000, Holger Brunck wrote:
> > the Kirkwood based board in question was OOT. Due to the patch we were
> > able to use the mainline driver without patching it to configure the
> > value we wanted.
> >
> > The DTS node looked like this:
> >
> > &mdio {
> >         status =3D "okay";
> >
> >         switch@10 {
> >                 compatible =3D "marvell,mv88e6085";
> >                 #address-cells =3D <1>;
> >                 #size-cells =3D <0>;
> >                 reg =3D <0x10>;
> >                 ports {
> >                         #address-cells =3D <1>;
> >                         #size-cells =3D <0>;
> >                         port@4 {
> >                                 reg =3D <4>;
> >                                 label =3D "port4";
> >                                 phy-connection-type =3D "sgmii";
> >                                 tx-p2p-microvolt =3D <604000>;
> >                                 fixed-link {
> >                                         speed =3D <1000>;
> >                                         full-duplex;
> >                                 };
> >                         };
> >       };
> > };
>=20
> Perhaps there is some bit I'm missing, but let me try and run the code on=
 your
> sample device tree.
>=20
> mv88e6xxx_setup_port()
>         if (chip->info->ops->serdes_set_tx_amplitude) {
>                 dp =3D dsa_to_port(ds, port);
>                 if (dp)
>                         phy_handle =3D of_parse_phandle(dp->dn, "phy-hand=
le", 0);
>=20
>                 if (phy_handle && !of_property_read_u32(phy_handle,
>                                                         "tx-p2p-microvolt=
",
>                                                         &tx_amp))
>                         err =3D chip->info->ops->serdes_set_tx_amplitude(=
chip,
>                                                                 port, tx_=
amp);
>                 if (phy_handle) {
>                         of_node_put(phy_handle);
>                         if (err)
>                                 return err;
>                 }
>         }
>=20
> dp->dn is the "port@4" node.
> phy_handle is NULL, because the "port@4" node has no "phy-handle" propert=
y.
> of_property_read_u32(phy_handle, "tx-p2p-microvolt") does not run so chip=
-
> >info->ops->serdes_set_tx_amplitude() is never called
>=20
> I'm unable to reconcile the placement of the "tx-p2p-microvolt" property =
in the
> port OF node with the code that searches for it exclusively in the networ=
k PHY
> node.

you are right I double checked it and it cannot work without a phy-handle. =
Not
sure, about the history of this patch anymore, but the board did run a 5.4 =
kernel
at that time.

So I agree that the use case I had does not work as it is implemented here.=
 So the code
should be either removed or reworked.



