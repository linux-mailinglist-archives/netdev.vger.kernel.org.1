Return-Path: <netdev+bounces-117180-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F152294CFC9
	for <lists+netdev@lfdr.de>; Fri,  9 Aug 2024 14:07:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 031E21C210E0
	for <lists+netdev@lfdr.de>; Fri,  9 Aug 2024 12:07:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 590B519309A;
	Fri,  9 Aug 2024 12:07:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="s2GIwA7P";
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="d9q1DUZM"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D36D18E021;
	Fri,  9 Aug 2024 12:07:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.153.233
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723205228; cv=fail; b=OvBKuuyFzzck9W3hC818+0gcmTwpJSl4Q4XMvrtAQ/v0M9jCkK0pas62f4u/MV1qMbjngB6kTHCSWcTkFbpR6hL48VTiXPVd/5G2KD176FkjC5fDPj/gChI6vlnPJL5C504bfLRbAPJk1s/plRqEDt5U0uxSmxNE5x1NCmOvr3g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723205228; c=relaxed/simple;
	bh=VC2OQdS80VfVqRUnEqaxU9YAs+zT2b+0k2ttMqAHncE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=hRD1fYoMpPL7uGBwZKkGTOHrRBjz+7+CFtp8zpAG2Y2mMQhJyT9qd8bigK00McbcFAPk+sfdR7uVcb5yZIp+Udwqcok53Ph+FHLTXTTkqsP/nnlpNh3h5zPKmMLVgQsoXSyjoRA/G+5PF7Ndi6kJfSbdIekdoPRVxjqh2AHeX+E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=s2GIwA7P; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=d9q1DUZM; arc=fail smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1723205225; x=1754741225;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=VC2OQdS80VfVqRUnEqaxU9YAs+zT2b+0k2ttMqAHncE=;
  b=s2GIwA7PSmFrce48HgASCaVbu5gGS2AM2ZPE0DYEeLq+MThmgtoKI1DM
   whgRiWECyTL/TJZxtiPo9unF+WnXTkpJIXfc/g+iJZUJrh3pMeuwNOr9r
   nTt025HzbpyyITPwzFQwFNiuF5OUchc7DEzwZpzigCtWxHTt/DBPRCFB9
   TANu86yKmxOD4o8kKTx/iMup4951DBDen2ZrDI2NjoSWA+BiFugCpDByt
   DfAkjo9vRlgufE7fpO/EpuH7yIXhd1qPWj1h7QZP/9CoaJeCnLI8TZDhF
   vGcUrIvm2X6H8FvWdv3PAlzaKgn4TDhENYzHaBg2u8N9/hCeLFHL466r4
   A==;
X-CSE-ConnectionGUID: BEc6i3SKS2OMBIf3VpIbhw==
X-CSE-MsgGUID: zfwaurRUSCStGJtdzK0S/A==
X-IronPort-AV: E=Sophos;i="6.09,276,1716274800"; 
   d="scan'208";a="33201045"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 09 Aug 2024 05:07:05 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 9 Aug 2024 05:06:25 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (10.10.215.250)
 by email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 9 Aug 2024 05:06:24 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AuHvd6cKbgTnC+OrYYBHv/fmUaKFHS5gYKa6gQlqGNXNnZeNBlN2pSOwJwYElS7cYO3UalATInf8tuDwzwKoYbPQZ04fG/a1hreN3ff/TIdf2s3bLFOdXCx//L4TucXN58c/x8zba/m0tY/XGtL1KxXwGSVo62hQohXB0G8DFzrjGL73zD1S9cdTblgtN25rwZzppN5Koevh0aJPXZ3Ik2AEMsfdNnGvicrx/7pH+uBbn/4cpbqvnF+988458da/0Fz7crXK6rfj8/XfjEhty3cnAvYdko9OItm7SfKr6oFqOhH+i5eOZ5XG8irhgvF4VteJ9JZaCesrs2uWNuHYIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zhxZgcM246Nqad2t0kbep1DeLJ27UvBXeERfR1RNSxo=;
 b=PvGHgFQirR/+9VIE3P4d+YuHDKzszqKqhknoWV/BfHtaTVob2LHOYFUAlS7142xa0xYCjLVAB85whZND4nIa0IrkiqaI4PvSWr2/DHvLpDTEDhH7vNo5YtvTEKvjDgLKSNkadFXns4ZQ3VbLx5Hq7mmeY9GFC7yvElwoefNbLDgVPiOImnPTzVTNORZFW4Bld552b1KGirxB68XzLobmJk7pLZ32/34+mwoZdiOS/zWtUIkld8Oil1WF1k0t0hnQvTTVRPg6mh6h8/DLW/6fOkIQYXPA9smep8DTNAF4GADrm6vtn7WI03uvmmSwp2yD1W6+ZoxjoE+2wO3ycvJTbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zhxZgcM246Nqad2t0kbep1DeLJ27UvBXeERfR1RNSxo=;
 b=d9q1DUZMRs8s0nBqpx4lkWf4y0Tfgej3N2L4KMYyrJyqTKZMmz1wZQwgTjqsjl7lEaukJgRYy5FQt8Qkl0uIVx9Xm21HoRaZgrgXMYjTFlQD3lr80YTbfyo8r9xDREl8PzTe9tMPMAieMLoG7gd5OV5ejSVwPMk4mLbMf/SeTDUmQB1fOYs4oPOQ7feXwNkoNXpGyFdSJCtzVDLS5HogZ7NcMWO7B2mnyBdWJssflJB4OpmNxPiBWdsVOftP3LhdUdPD9bGB/KkP49xr+uM1UC9WrpETQh9g0Qn3KKDsDdg635aLmXGXcPEYt+/yIle0WOlB4iH5+2fYHaWFj50+YQ==
Received: from CO1PR11MB4771.namprd11.prod.outlook.com (2603:10b6:303:9f::9)
 by IA0PR11MB8333.namprd11.prod.outlook.com (2603:10b6:208:491::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.27; Fri, 9 Aug
 2024 12:06:20 +0000
Received: from CO1PR11MB4771.namprd11.prod.outlook.com
 ([fe80::bfb9:8346:56a5:e708]) by CO1PR11MB4771.namprd11.prod.outlook.com
 ([fe80::bfb9:8346:56a5:e708%4]) with mapi id 15.20.7828.021; Fri, 9 Aug 2024
 12:06:20 +0000
From: <Divya.Koppera@microchip.com>
To: <andrew@lunn.ch>
CC: <Arun.Ramadoss@microchip.com>, <UNGLinuxDriver@microchip.com>,
	<hkallweit1@gmail.com>, <linux@armlinux.org.uk>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH net-next] net: phy: microchip_t1: Adds support for LAN887x
 phy
Thread-Topic: [PATCH net-next] net: phy: microchip_t1: Adds support for
 LAN887x phy
Thread-Index: AQHa6Yq368FyCB2W40W0fvYzUDQ2srIdZrEAgAFtRsA=
Date: Fri, 9 Aug 2024 12:06:19 +0000
Message-ID: <CO1PR11MB4771194F65E48759711A25F7E2BA2@CO1PR11MB4771.namprd11.prod.outlook.com>
References: <20240808145916.26006-1-Divya.Koppera@microchip.com>
 <e9fdc9f6-8c89-4c2a-ba38-d927d0a52d78@lunn.ch>
In-Reply-To: <e9fdc9f6-8c89-4c2a-ba38-d927d0a52d78@lunn.ch>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO1PR11MB4771:EE_|IA0PR11MB8333:EE_
x-ms-office365-filtering-correlation-id: 97618ec8-ed33-4eab-3b86-08dcb86badfd
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4771.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?8mfKbi41BZ/Z+1fGsuN+t8iC+PubGLRqrpPUs7PxPYkD6ZbY6qXzJkJNd1RV?=
 =?us-ascii?Q?GKdC0HvzpWjniAGprK9YtMGcj4/4RmAfK4RQpJGNbSYVWY3Abjwf8UAylCE9?=
 =?us-ascii?Q?EsRg9fSjx7bJxTCG5xMDLyOfPylTK6K5SAZycNgTYJ6cMNHXbtUd+QtDSFdG?=
 =?us-ascii?Q?CZ2Vg4FyxmKYaHanzDk2CZ9JLBTpSySP9rTFirwfQxSREoEjRgL7PMOwGw3m?=
 =?us-ascii?Q?orzJEDbY+Scomi/Amu7UmjuYg8Dmph18k18CKFG0/iYA4TpZgi/QCNSIB/Iu?=
 =?us-ascii?Q?ygpCzygG3qm1N5KI3kiDAjRvqecIA0GTEQmbWx8Gtjy3SG/ffIxIptWZsrTL?=
 =?us-ascii?Q?xz/SfFCHEMdhRGXQFLdGS3eYyTII4VgX8+tW3hMsPyGrxxYkSl3DL88uqhoN?=
 =?us-ascii?Q?Noah2wktMteFLqHSXShVFRII7C6fAdXQ3ntXTbzD7olrE0ACteSv07vP3Ip+?=
 =?us-ascii?Q?qMAPD5seOb2SfAH4UEGm0/VNQNuAFYUpla7KnVzZHez9abuG4Ob5k0/wRuMP?=
 =?us-ascii?Q?nRot83XOgp78aUgOhzWW9Tr/6DuVm3ZovxAh4cbyxZ4nl+3z58Jv5Vj8Q42u?=
 =?us-ascii?Q?7ODj1baWW3swETe7A55Uv6Rxyx0SziPWcxUIcKoD7TuyCEBJ9+H+br2LKtCw?=
 =?us-ascii?Q?DNNt7UEas/s1tBx6/03/Dpz/dP9fJFHjMk2Ze12U7CDbfB7R3yrxg3VpBTqf?=
 =?us-ascii?Q?n0ewOhLExJVFN/aDtEogLoaZhga4DIM0tkE172+1W+7E+dRMOvM0o7huAtN0?=
 =?us-ascii?Q?JDiaBUzjZIx2Fa9qCAFCAg43UnYKVnExz9HQZa3B9Csaotl3ZnUVD9D3wtKM?=
 =?us-ascii?Q?laSsJz3pi44sIAm1GQ5xWbANmJ3ae2lNM0ZYzCmWmSTXNp3PXtMeEDUJI/7j?=
 =?us-ascii?Q?zoRIa/J7Jo1F15nfBL8x45k9lps2KqE3Ks2PwuepOGnhsHF7jKXPKTSTSOZX?=
 =?us-ascii?Q?hFrSe6wyB/TLRWedqx7rrw9SdwiZ5M8GjSrLtGmFqJ/9F/g/gPQTiDA+2G4u?=
 =?us-ascii?Q?K66J5EOyGgVnbpg/VY5eDTFPA0RCQnnJuKAqzGCqaZQfRZqQtVZAjdDsVMOi?=
 =?us-ascii?Q?GuWYb1Qlm40bDlD9dI3ZVmCEJdYiQYo+YBKLjCFGT8PA55KKky+k6SKYl0t9?=
 =?us-ascii?Q?wRBVGjxS3gSfvf9blEBKXK2EV94AuYXQHfZItmOK4Bjq3W0iKMtRp1ZD3fra?=
 =?us-ascii?Q?7maVQdm5DbXzGqh0jnM26mg9ZVWQyG2M9ODBUIJ+vtPlBIZJfIQQXyH24S7F?=
 =?us-ascii?Q?j07P8x+uuapux8BBHnNeWQJVhqke5e3KSzBi2Cv0mb2YFuqovwBcGeBUvMua?=
 =?us-ascii?Q?Nij2HpUZVMSTWhQ4xBD7uXLVMJH9DSqcqisTHWs3La27SxZEJDD9j2WXVM2b?=
 =?us-ascii?Q?4xEN+7tCaF9C2nvjhnyp/sY9DDAz2gL7BulYtwvj49TjM9KVfg=3D=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?SNScwYXHflWa5He3IMnf/aUaohHmTrUVty5o+Xuiw0o2fLCBTRhdgFOeeed2?=
 =?us-ascii?Q?SQh/p1g1TO3Nde2WHLen2nYO046ETvfACrla6oiweg7AkTloNMmV0P1tiOwJ?=
 =?us-ascii?Q?a6pJ4Fio79vLIXQ3FkyQFJl1MN94s7GkdY2IIPyh779p9OeN/8u+NcFNEJQN?=
 =?us-ascii?Q?/fyvXtudoG6fMvpRStglfpFA4cmC9kogKEnFKIAJai4CHxMMm2BoeZBPOjh2?=
 =?us-ascii?Q?s+4wS9OIxQ86GpcO+tGti/rchvz3Go2grrD8nZbJu90wPofeghjJl7JdrUU2?=
 =?us-ascii?Q?6keRNXxFV83wFqsgCKgiopyUnOOhzhODHYYdclsOFE+jqQFzMqeaCXZ7RQO9?=
 =?us-ascii?Q?R7l2Z+t63bl9Yse7Mn8EzUeia6rha7MMKaXiRuFVq5Ukg0JQndw66bTlXPxe?=
 =?us-ascii?Q?BxUIxb91/pwaScr7/7XsmbOFmmzHIUZWUb/U80FnoFgMJm+hHTeVzXBucVCq?=
 =?us-ascii?Q?knWhd+lkK7laaOJ+7FTJGF1e45SVjnWcDSgym3V1IVugLJYM7is/GjzuxIyU?=
 =?us-ascii?Q?k4CCUx09HdWohHb2wxfTOoNDXk28jTzTmiHm7myJDNpVH4vrozSH3QDsc1EC?=
 =?us-ascii?Q?D7WGVJdIrYuLbCdHcvYTIfgreLnrIOYBtUyWOOpIhCgald5ToCkjIdy75K0e?=
 =?us-ascii?Q?gYut3ttIxdcCrSdAPJkvz7irUJymWibvUCsBRhrD0jHSQ5xyjC88uAu+lukM?=
 =?us-ascii?Q?P/TFh7aovmlQmq0OwS3+v3n/Y2aykXjmUyI6/ADdGjOJ5QjczRSNg8eGarVA?=
 =?us-ascii?Q?jg6fBKTZSZno6/mfyCN6528PMNFQfp6gfwB5flfClklBBL6HA8L2EGNPWOGq?=
 =?us-ascii?Q?4A3sXpPmVUZxS9q5j2DZBir3HdNJxYyn3bGOXORy9JNxS+xVnai3+IY7CK9m?=
 =?us-ascii?Q?2bFCQ62z14Qz+IxXpvZj8iXIuQP/vzqJByKkDCzhRAzdgA+Zsdx6H2/MHQXv?=
 =?us-ascii?Q?913Qk8rtoXZKLuLfMLaDHsgzeIpu/XI1X89cguf3P/wD5rFxYt+wY+70m6Zb?=
 =?us-ascii?Q?4mOSaUr/dY+dBXdTq2UHpzaSpjBgcP2+ZGRSkyNr4NVc1HM0/+HH2mtPSnSh?=
 =?us-ascii?Q?kKZ1fCdrTB7lJKkwdkWzCo9+230IUuWbT1gpHkdnR8Q7OhhLlfpx9OrVPs6Q?=
 =?us-ascii?Q?xSuUg4UWQYM32KARBlf4KgMgs+tqpkXKZLTU0/ZH11QtMw3s4W7ZQoQbJbre?=
 =?us-ascii?Q?DI4TxsXCe/c4xetfSkMiD+VEJPMX9miLoruc4AAm9JA7ehR1zBAGQgv6BshD?=
 =?us-ascii?Q?OuuobBwbcRzopSo/8NASIcSV7Jpm5O6ovIu7LNvPaOnt4K54JmmGULRQDNEi?=
 =?us-ascii?Q?R3S9xqLZdOkCXOE9R6v/TCK66M6Eztwz+Ou3sgIIukA0WOOqM8fXoS+g2mSZ?=
 =?us-ascii?Q?AKXbGenaqalIwocvQSkL5w3RJcT6h+d80IOFf5fsVv4ZYJqywt1LgPIX1JO6?=
 =?us-ascii?Q?isg+53ECL7wO7GmQTPi2Y1aZ/nAnhh3YOR0AwEu5/NwMQPbSFaUinx2xsBgH?=
 =?us-ascii?Q?0WLsDHIoUOGOLXxrYcVz90LT7aAe4+r2qtsa144sLaMGhMbw1bO6e+K2BO66?=
 =?us-ascii?Q?WodmN4+aNXr9ujPV+vPYu1+HR9Q+S0okX2EHtCyy5W3HVeh18o3m7P5+iwto?=
 =?us-ascii?Q?aQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4771.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 97618ec8-ed33-4eab-3b86-08dcb86badfd
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Aug 2024 12:06:19.9556
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Y9kGGpO0t1tpJ5NwnRSSi3wR3tK8e0Q0y5w7ukDGL6UGbLfc8s0TGoNaEM1wHo78YnIddfX5uOpkHs+BpK4TPr4YH1CZc9XjdmfRdQoiyDc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB8333

Hi Andrew,

Thanks for the review, please find my reply inline.

> -----Original Message-----
> From: Andrew Lunn <andrew@lunn.ch>
> Sent: Thursday, August 8, 2024 7:42 PM
> To: Divya Koppera - I30481 <Divya.Koppera@microchip.com>
> Cc: Arun Ramadoss - I17769 <Arun.Ramadoss@microchip.com>;
> UNGLinuxDriver <UNGLinuxDriver@microchip.com>; hkallweit1@gmail.com;
> linux@armlinux.org.uk; davem@davemloft.net; edumazet@google.com;
> kuba@kernel.org; pabeni@redhat.com; netdev@vger.kernel.org; linux-
> kernel@vger.kernel.org
> Subject: Re: [PATCH net-next] net: phy: microchip_t1: Adds support for
> LAN887x phy
>=20
> EXTERNAL EMAIL: Do not click links or open attachments unless you know th=
e
> content is safe
>=20
> > +     if (!IS_ENABLED(CONFIG_OF_MDIO)) {
> > +             /* Configure default behavior of led to link and activity=
 for any
> > +              * speed
> > +              */
> > +             ret =3D phy_modify_mmd(phydev, MDIO_MMD_VEND1,
> > +                                  LAN887X_COMMON_LED3_LED2,
> > +                                  LAN887X_COMMON_LED2_MODE_SEL_MASK,
> > +                                  LAN887X_LED_LINK_ACT_ANY_SPEED);
>=20
> This is unusual. What has OF_MDIO got to do with LEDs?
>=20

As of now there is no device tree support for lan887x, in future if the sup=
port is added we have to implement
led framework for phy, that is why we are using this flag to configure leds=
 on non device tree supported platforms.

> Since this is a new driver, you can default the LEDs to anything you want=
. You
> however cannot change the default once merged. Ideally you will follow up
> with some patches to add support for controlling the LEDs via /sys/class/=
leds.
>=20

Sure, we will make it default without flag in next series.

> > +static void lan887x_get_strings(struct phy_device *phydev, u8 *data)
> > +{
> > +     for (int i =3D 0; i < ARRAY_SIZE(lan887x_hw_stats); i++) {
> > +             strscpy(data + i * ETH_GSTRING_LEN,
> > +                     lan887x_hw_stats[i].string, ETH_GSTRING_LEN);
> > +     }
>=20
> There has been a general trend of replacing code like this with ethtool_p=
uts().
>=20

We will change in next series.

>         Andrew

/Divya

