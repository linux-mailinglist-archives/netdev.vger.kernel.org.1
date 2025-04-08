Return-Path: <netdev+bounces-180202-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AE48FA80674
	for <lists+netdev@lfdr.de>; Tue,  8 Apr 2025 14:27:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 628821B837A6
	for <lists+netdev@lfdr.de>; Tue,  8 Apr 2025 12:22:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B72826A1A0;
	Tue,  8 Apr 2025 12:19:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="OwhIXLrE"
X-Original-To: netdev@vger.kernel.org
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2083.outbound.protection.outlook.com [40.107.95.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FB6126A0E9;
	Tue,  8 Apr 2025 12:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744114783; cv=fail; b=DRJvXP82894hAycE7/8QfzvgrmrXePojzy77Ee+QizfgfExTpG7xeWYAH0v+8pNFaXi5phCwxneTi/W917rCxjZ2nSZBEPRjW6ZM35IyF8VpQCdUInL4yq8IekLvnLI/+MlYDtmBhFpwgU4K0QRFaHNF+03QHIvDk0HdAWRbvHk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744114783; c=relaxed/simple;
	bh=KNrZNTwCTxsn2CZO3nu6NAnOYXHO1XAX9g0I/E903d0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=aL/ATr3BZobqn+8bbcH7CFrWTuWiLHcAkiJKWTZsk3jx/Q3dhctr/FxDq8kaCCN2Jn62t4u5mQwMrybOn7rGExMt5ysymOOLTvKQSpv6ZnKCeyzDOe8P4fmleLjg1jCyYvjE2FtGHDaERxASLRRRxLa/kFaAnqtxvW269x0E860=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=OwhIXLrE; arc=fail smtp.client-ip=40.107.95.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Szof/sW09PQ7GXxqaFpgE3WXo5jnhNubQ3QUO7O3l/9d8MRPknLnjDLHLR1L2H4gb5EFACXO2s3SoKfRzsRMFq0IK5vg9HhPa2W8sgiupQRLsoW6JGry1MmDiZG1iZvQ4l3DvcWMhufqfWCx32sO/kxqQFp8RsHfJWlh887EhWHvU9SVtQO7AxS/His6HqE03q5K3dS2li2V3R8eyDSJBgLDNzOQxsGYsARpOm5ZVJHwEcVpnVAXe0/y8bNvnxQ6wBeExmIfCLVOex7nT+eCcLSdIqMy0Fig2gix2Wbg4K1SU5CYtQMtVztZqG40y8G7OfoqhSuglvM0N9CNQDTNcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i8RLi4KuvGUj+e3EEZcBcXQr5Vs+45ffY64j8rWUxxg=;
 b=QO7YmRHJl3b32eldZ74KQR5ZmwzHRCNJnEIfisKgy4DoF3M4nhpwQEqYSYkMyfWX2FlEjWmBx3BMFn+IOUVX2R5oKnJADxy8ulGEBoCd/RZyBxIwhcmK8yrMwd2KKMT0Rurd3gHzags+gTZAjY97hKp+QKX19apZT41P9xBjbFJRJb4j8TK5mOkvUDz10NLbFM8IGQmK/womX3A3wj6wCZk0pDTwHCVtEmkyMZCBiGR2ZTZpa+c5kb6Jni8czkRC6tw2kAS4cZS+3nfreBL+C56LpxoKjw5GsiCPhYa/tUR5dHQ0boK91moyTEFUFygl5GtWrqZPZ6t54uF4KFhpAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i8RLi4KuvGUj+e3EEZcBcXQr5Vs+45ffY64j8rWUxxg=;
 b=OwhIXLrERvPjxKplzE5oqSTcCAMfWfFOqJNtQihOcTql63p3zkHLt1W/I8AGTV9Ws6k2emcWrZONGbCDnM3itM11utWFoUWC+GE51Qapj6gk87H3JqBbUGP731VIKIT3kqj8XcIwzL/LcaR/of52skm+zo21mUFC2b4fJKLioLo=
Received: from BL3PR12MB6571.namprd12.prod.outlook.com (2603:10b6:208:38e::18)
 by CY8PR12MB7414.namprd12.prod.outlook.com (2603:10b6:930:5e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.29; Tue, 8 Apr
 2025 12:19:37 +0000
Received: from BL3PR12MB6571.namprd12.prod.outlook.com
 ([fe80::4cf2:5ba9:4228:82a6]) by BL3PR12MB6571.namprd12.prod.outlook.com
 ([fe80::4cf2:5ba9:4228:82a6%3]) with mapi id 15.20.8606.029; Tue, 8 Apr 2025
 12:19:37 +0000
From: "Gupta, Suraj" <Suraj.Gupta2@amd.com>
To: Sean Anderson <sean.anderson@linux.dev>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S .
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Russell King
	<linux@armlinux.org.uk>
CC: Heiner Kallweit <hkallweit1@gmail.com>, "upstream@airoha.com"
	<upstream@airoha.com>, Kory Maincent <kory.maincent@bootlin.com>, Christian
 Marangi <ansuelsmth@gmail.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "Simek, Michal" <michal.simek@amd.com>,
	"Pandey, Radhey Shyam" <radhey.shyam.pandey@amd.com>, Robert Hancock
	<robert.hancock@calian.com>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>
Subject: RE: [net-next PATCH v2 11/14] net: axienet: Convert to use PCS
 subsystem
Thread-Topic: [net-next PATCH v2 11/14] net: axienet: Convert to use PCS
 subsystem
Thread-Index: AQHbqBQpOkeBdCgtTkqJNnqbURiuX7OZrO8g
Date: Tue, 8 Apr 2025 12:19:36 +0000
Message-ID:
 <BL3PR12MB65713BB652BE4E0E3FAAEF7BC9B52@BL3PR12MB6571.namprd12.prod.outlook.com>
References: <20250407231746.2316518-1-sean.anderson@linux.dev>
 <20250407232058.2317056-1-sean.anderson@linux.dev>
In-Reply-To: <20250407232058.2317056-1-sean.anderson@linux.dev>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=fa066623-83f3-4d16-8124-552b78775809;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-04-08T12:05:40Z;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Tag=10,
 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL3PR12MB6571:EE_|CY8PR12MB7414:EE_
x-ms-office365-filtering-correlation-id: 0154b607-ffa3-4485-63fd-08dd7697a121
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?fiYgqeQyfsvowlnU6duu755harcw1yml2UdwdwBCHvHFxCWRs4FoByHnmseH?=
 =?us-ascii?Q?6qc2NKhAyOA/Mr7zzeMJwiD8KSiemk5G2AnYxOouVJ8gUhzj5jNH7bpeGtrN?=
 =?us-ascii?Q?4VerVhhVdWUbG6kuMnpjBykws0vB7k24zAE0KjnhaMF4lA0rvMH1GhACn2Rl?=
 =?us-ascii?Q?v2V7PWLDj+XY0pg1dO8IMbeH1n7IZfQbIil1ZuvqjaiVNN35ZKc8QIIMIH3I?=
 =?us-ascii?Q?SAYaigJXjETEPrwc14Tpb0NYQiYhfI78WViFa9+zksjoUQBCMNf+O7kBplxl?=
 =?us-ascii?Q?UJVaDvqqAYYV/CLJm8k0ASoRWpkmxnHkMdro3O4TxMvgG9xCWTIgl0q3ZnZa?=
 =?us-ascii?Q?/WYTTKJjDODIlrn7CqpWPRN7SdHMRKpQN3DiuHXHJ6MQWW4nrGT9lMm7BbxK?=
 =?us-ascii?Q?PJ8nKT/n3aPJoxfsj58j1sGwYfu2f6JLM55Zk/KHr4pCT43HMw7MCZLouHPT?=
 =?us-ascii?Q?LAUsv22TKCchtpY9ySsMDL/nEbQ+O6N/XH5viviE3s+KUABNZMtfvc2ozCZJ?=
 =?us-ascii?Q?LsEXYHhlDC9JyAO1uzxQmBbV7t6IvmthmFOldzm0z2UpGWEabX+oR03p1iC9?=
 =?us-ascii?Q?kIkzo2g9J90BSUzizDru0haT3O04SNijwrzCzxlW327Nsp8neLBKYN2ZRjj4?=
 =?us-ascii?Q?hIWIgvuDRs3JkCH3s0iydHrzlXRCkhcg45F1Cid4eGfMdafYcGUjHeVEVeRE?=
 =?us-ascii?Q?zNVxi8OXkjXIaqOkxe611L4v3Dn+bILWiOGW0NlFruViwCltwozpLGh8ioIT?=
 =?us-ascii?Q?L6mmywWm8LhGc1vv27DC4FFfNbI9csTixMvK7tHQXfF1hY8q13v6uiCVcvcO?=
 =?us-ascii?Q?NYImRXr3NPZ6d/sOXxGCsK3X8CAwF/tnuz8RDiaW/n3k2nTY2t2aWSJAJVId?=
 =?us-ascii?Q?JvQHvbZRYCGoHnqIV4ku6oL70BhZyqZriW9HyBSgsIfVlHsDYd8kgt8ldE+3?=
 =?us-ascii?Q?DZnyyYnC/UxxO/qRLipHLc0l7KBm+7Q+6gcjJdN0wvPUuDTuAwoD7aEHWutu?=
 =?us-ascii?Q?inrfObouPaHb0aqiw4juiA6hgIWb+xwBZw+IXH+3iwun1tc4kZ+ERQTlN4LY?=
 =?us-ascii?Q?aF93U36RkVCvxjXa/38nJ7c5sV0X61nP5f2YGgZhb0MC6mRaT5aP09eh9I+O?=
 =?us-ascii?Q?wPcR2kt6Ewjr/Ty9c8wNSPACXFwgrzyXHPdpgrZGUwliPKJXIlHYQhndsdpK?=
 =?us-ascii?Q?5iVRLdhwvLaZn8EAB3jqnMJXYEdxtV9NYmZtMK49z9ck80pZ4G6C4KatsDxx?=
 =?us-ascii?Q?lrRkm01UlVTEbNj8JF6Ghj6XfLQMDq7dvmEx5SH1mHenCmKrCPitpB4Ij5tP?=
 =?us-ascii?Q?8v8Wj7V+4LCTCROtUSO/OjhSAyhVWKJEvvp3bJHAlSoF/WTuEoOrg+ImD/C7?=
 =?us-ascii?Q?qNdZgwwPnom98nB8PjMcce+4JYm26iWNuISjTavg82D6MOhXfREIQSMuXjGp?=
 =?us-ascii?Q?lJXM1prW5szpA+kur1+voYBoWlRtWp+Q?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL3PR12MB6571.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?3NcWqm/2tkKwcV6Tb6gLTN1v2dtc3z3wVQOork1PQxsrVoQimoFRNVdyjJ1N?=
 =?us-ascii?Q?480KIy5aXXP05O68nujxy2laOxEh5YiX9ErFunVgTFiHPSORJPk4CTtL5dpC?=
 =?us-ascii?Q?cgD/UTCNGjvR+0bhIXTXkbbrdXmC+SaJy+PcH8Rom2QDjbJ+qk7KVjbyt0S5?=
 =?us-ascii?Q?BhoN1F0g/WdHERuiJlQT7oEg2xaVUbONdt0iUztGkjnwtOZHNnbyZq+scZfw?=
 =?us-ascii?Q?XBAFWOdttXZF7a6eLKUg/XiMm5PCxQqxW0EV+6zRx4Hf45gp297ILmYheChv?=
 =?us-ascii?Q?dQvrZ1sj1tCXo+bsEyK3JM15rQKzJrCTq9+yCgvI/z34CrwKoMXIMYrDHQVr?=
 =?us-ascii?Q?4q3ZGM1VpsECUbU4TF1PGrOOTixJ3wOEY71NCBruK+HuZ0gCNquAlydw3EO/?=
 =?us-ascii?Q?qrJgzkQzt1Yz7WzIoEQmRVJT/anrCGNRMDDaJQ9/2t2ymiwgHzu7fI085Ek9?=
 =?us-ascii?Q?h/v7R0hpaMqQAhv/Zc8POc1QsxbIRnTaMIEFnesJSc58dIP7WF8KtOTZGTq3?=
 =?us-ascii?Q?SzS6Mh9KzUShNm+BxlyoWxsTIPKWGVIeg3qBw3DioBtBFv5TaPhhh9RyEjya?=
 =?us-ascii?Q?DihNHpRUIMk07TXH0/Zwi781DAurpCwakEuzLZhJCdSJjk3eyjgGpTSq7L1b?=
 =?us-ascii?Q?k6fkRcyjkxdbUaRmT8uimoblnUPSkkBddC2+UgnTDX7H6RqeH4p6bIf7AMTh?=
 =?us-ascii?Q?8Ivy/DbYb31pH5/TGYJwGk2tSeof0X5d1/rGmr/UgYf9bPzAcozj5rlJ8SmS?=
 =?us-ascii?Q?HRpSjaHPUqr85O20czs0cGKVXcwUj1b5AYwdDX6jqCgtM+hsrfAK8l+YnWS9?=
 =?us-ascii?Q?Dbub2BYcyYLe4dNG2HAKQZKC/7AhlDEsz7fYWHA7Xf8YLS5RDBcuKiZVGA1p?=
 =?us-ascii?Q?4gYF+8iTnEzYkX+A8YCjfLUZjJGksLOLipKUX3LW8hZw2KVES0b97/VJ7kQi?=
 =?us-ascii?Q?Vap3RFKzGQ/83oGD/tlpEfxu8hlAx5DefzRK0H1Kev8gXG6yrMlPATJWJcjI?=
 =?us-ascii?Q?8khis9sfaZnbTcJxUPEfTJmSfwSVy1FGK2p2MEsxJ1QSub+nQdCJjsmLAbjE?=
 =?us-ascii?Q?mYEP68LjY1axBAlKUNIqkMMU+JfdghfUJGRtvcKK/s9mBqwfsWMaLbuFwzC4?=
 =?us-ascii?Q?4/csRrRkg43B8XlaHYOIRSZCajmj4GSgLIRPW+aLhExPNilbuT3cKMyzMg2R?=
 =?us-ascii?Q?eU5yon0h3NJPUoHOemgDiO5z6AhzDR/9iU4CbmdkXHhNXv5fmFBCYL4+eoPp?=
 =?us-ascii?Q?VP8BUxKd7gj0aOtJcbAcFyrq4P0GwyZwsUX7DTmxLpc8gHkGZl9zTDCMg67M?=
 =?us-ascii?Q?xhB30emMymVI5c/skVRJ4ZnWUUcxZVUJkvawBqPEpH2n0oDwy7icO0kDrU39?=
 =?us-ascii?Q?ouHuiyjbgHy+aRWVhdBsttvo2/+XuIyQCZ1StLK3JHsuUnN04XtRUWnf5O3u?=
 =?us-ascii?Q?wLLtwfcmtlOA7IwS3jZue5/pF5zZ4fgwlwBoQwGEqVMAaTwoa19oHeCeV3z9?=
 =?us-ascii?Q?T18hMFyvh3LqEtKt63dm+xqH6XGJ8ZVlsEFYyXxAm+Wn1PrbToSZfF9fHQ5j?=
 =?us-ascii?Q?K+mTp9HJ/8p06ENwptQ=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL3PR12MB6571.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0154b607-ffa3-4485-63fd-08dd7697a121
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Apr 2025 12:19:37.1725
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BytMVzc4f6bk3i8MqQBVHf4yTV+lHKtKK3cts4JQuXi9tvx0g7RNaxdR/IqeP5fFCctrhqOzDQAVq84Bbf4fmw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7414

[AMD Official Use Only - AMD Internal Distribution Only]

> -----Original Message-----
> From: Sean Anderson <sean.anderson@linux.dev>
> Sent: Tuesday, April 8, 2025 4:51 AM
> To: netdev@vger.kernel.org; Andrew Lunn <andrew+netdev@lunn.ch>; David S =
.
> Miller <davem@davemloft.net>; Eric Dumazet <edumazet@google.com>; Jakub
> Kicinski <kuba@kernel.org>; Paolo Abeni <pabeni@redhat.com>; Russell King
> <linux@armlinux.org.uk>
> Cc: Heiner Kallweit <hkallweit1@gmail.com>; upstream@airoha.com; Kory
> Maincent <kory.maincent@bootlin.com>; Christian Marangi
> <ansuelsmth@gmail.com>; linux-kernel@vger.kernel.org; Simek, Michal
> <michal.simek@amd.com>; Pandey, Radhey Shyam
> <radhey.shyam.pandey@amd.com>; Robert Hancock
> <robert.hancock@calian.com>; linux-arm-kernel@lists.infradead.org; Sean
> Anderson <sean.anderson@linux.dev>
> Subject: [net-next PATCH v2 11/14] net: axienet: Convert to use PCS subsy=
stem
>
> Caution: This message originated from an External Source. Use proper caut=
ion
> when opening attachments, clicking links, or responding.
>
>
> Convert the AXI Ethernet driver to use the PCS subsystem, including the n=
ew Xilinx
> PCA/PMA driver. Unfortunately, we must use a helper to work with bare MDI=
O
> nodes without a compatible.
>

AXI ethernet changes looks fine to me, except one minor nit mentioned below=
. Using DT changesets for backward compatibility is impressive :)
I'll try reviewing pcs/pma patch also and test it with our setups.
> Signed-off-by: Sean Anderson <sean.anderson@linux.dev>

Reviewed-by: Suraj Gupta <suraj.gupta2@amd.com>
> ---
>
> (no changes since v1)
>
>  drivers/net/ethernet/xilinx/Kconfig           |   1 +
>  drivers/net/ethernet/xilinx/xilinx_axienet.h  |   4 +-
>  .../net/ethernet/xilinx/xilinx_axienet_main.c | 104 ++++--------------
>  drivers/net/pcs/Kconfig                       |   1 -
>  4 files changed, 22 insertions(+), 88 deletions(-)
>
> diff --git a/drivers/net/ethernet/xilinx/Kconfig b/drivers/net/ethernet/x=
ilinx/Kconfig
> index 7502214cc7d5..2eab64cf1646 100644
> --- a/drivers/net/ethernet/xilinx/Kconfig
> +++ b/drivers/net/ethernet/xilinx/Kconfig
> @@ -27,6 +27,7 @@ config XILINX_AXI_EMAC
>         tristate "Xilinx 10/100/1000 AXI Ethernet support"
>         depends on HAS_IOMEM
>         depends on XILINX_DMA
> +       select OF_DYNAMIC if PCS_XILINX
>         select PHYLINK
>         select DIMLIB
>         help
> diff --git a/drivers/net/ethernet/xilinx/xilinx_axienet.h
> b/drivers/net/ethernet/xilinx/xilinx_axienet.h
> index 5ff742103beb..f46e862245eb 100644
> --- a/drivers/net/ethernet/xilinx/xilinx_axienet.h
> +++ b/drivers/net/ethernet/xilinx/xilinx_axienet.h
> @@ -473,7 +473,6 @@ struct skbuf_dma_descriptor {
>   * @dev:       Pointer to device structure
>   * @phylink:   Pointer to phylink instance
>   * @phylink_config: phylink configuration settings
> - * @pcs_phy:   Reference to PCS/PMA PHY if used
>   * @pcs:       phylink pcs structure for PCS PHY
>   * @switch_x_sgmii: Whether switchable 1000BaseX/SGMII mode is enabled i=
n
> the core
>   * @axi_clk:   AXI4-Lite bus clock
> @@ -553,8 +552,7 @@ struct axienet_local {
>         struct phylink *phylink;
>         struct phylink_config phylink_config;
>
> -       struct mdio_device *pcs_phy;
> -       struct phylink_pcs pcs;
> +       struct phylink_pcs *pcs;
>
>         bool switch_x_sgmii;
>
> diff --git a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
> b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
> index 054abf283ab3..07487c4b2141 100644
> --- a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
> +++ b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
> @@ -35,6 +35,8 @@
>  #include <linux/platform_device.h>
>  #include <linux/skbuff.h>
>  #include <linux/math64.h>
> +#include <linux/pcs.h>
> +#include <linux/pcs-xilinx.h>
>  #include <linux/phy.h>
>  #include <linux/mii.h>
>  #include <linux/ethtool.h>
> @@ -2519,63 +2521,6 @@ static const struct ethtool_ops axienet_ethtool_op=
s =3D {
>         .get_rmon_stats =3D axienet_ethtool_get_rmon_stats,  };
>
> -static struct axienet_local *pcs_to_axienet_local(struct phylink_pcs *pc=
s) -{
> -       return container_of(pcs, struct axienet_local, pcs);
> -}
> -
> -static void axienet_pcs_get_state(struct phylink_pcs *pcs,
> -                                 unsigned int neg_mode,
> -                                 struct phylink_link_state *state)
> -{
> -       struct mdio_device *pcs_phy =3D pcs_to_axienet_local(pcs)->pcs_ph=
y;
> -
> -       phylink_mii_c22_pcs_get_state(pcs_phy, neg_mode, state);
> -}
> -
> -static void axienet_pcs_an_restart(struct phylink_pcs *pcs) -{
> -       struct mdio_device *pcs_phy =3D pcs_to_axienet_local(pcs)->pcs_ph=
y;
> -
> -       phylink_mii_c22_pcs_an_restart(pcs_phy);
> -}
> -
> -static int axienet_pcs_config(struct phylink_pcs *pcs, unsigned int neg_=
mode,
> -                             phy_interface_t interface,
> -                             const unsigned long *advertising,
> -                             bool permit_pause_to_mac)
> -{
> -       struct mdio_device *pcs_phy =3D pcs_to_axienet_local(pcs)->pcs_ph=
y;
> -       struct net_device *ndev =3D pcs_to_axienet_local(pcs)->ndev;
> -       struct axienet_local *lp =3D netdev_priv(ndev);
> -       int ret;
> -
> -       if (lp->switch_x_sgmii) {
> -               ret =3D mdiodev_write(pcs_phy, XLNX_MII_STD_SELECT_REG,
> -                                   interface =3D=3D PHY_INTERFACE_MODE_S=
GMII ?
> -                                       XLNX_MII_STD_SELECT_SGMII : 0);
> -               if (ret < 0) {
> -                       netdev_warn(ndev,
> -                                   "Failed to switch PHY interface: %d\n=
",
> -                                   ret);
> -                       return ret;
> -               }
> -       }
> -
> -       ret =3D phylink_mii_c22_pcs_config(pcs_phy, interface, advertisin=
g,
> -                                        neg_mode);
> -       if (ret < 0)
> -               netdev_warn(ndev, "Failed to configure PCS: %d\n", ret);
> -
> -       return ret;
> -}
> -
> -static const struct phylink_pcs_ops axienet_pcs_ops =3D {
> -       .pcs_get_state =3D axienet_pcs_get_state,
> -       .pcs_config =3D axienet_pcs_config,
> -       .pcs_an_restart =3D axienet_pcs_an_restart,
> -};
> -
>  static struct phylink_pcs *axienet_mac_select_pcs(struct phylink_config =
*config,
>                                                   phy_interface_t interfa=
ce)  { @@ -2583,8 +2528,8
> @@ static struct phylink_pcs *axienet_mac_select_pcs(struct phylink_confi=
g
> *config,
>         struct axienet_local *lp =3D netdev_priv(ndev);
>
>         if (interface =3D=3D PHY_INTERFACE_MODE_1000BASEX ||
> -           interface =3D=3D  PHY_INTERFACE_MODE_SGMII)
> -               return &lp->pcs;
> +           interface =3D=3D PHY_INTERFACE_MODE_SGMII)

nit: unchanged check.

> +               return lp->pcs;
>
>         return NULL;
>  }
> @@ -3056,28 +3001,23 @@ static int axienet_probe(struct platform_device *=
pdev)
>
>         if (lp->phy_mode =3D=3D PHY_INTERFACE_MODE_SGMII ||
>             lp->phy_mode =3D=3D PHY_INTERFACE_MODE_1000BASEX) {
> -               np =3D of_parse_phandle(pdev->dev.of_node, "pcs-handle", =
0);
> -               if (!np) {
> -                       /* Deprecated: Always use "pcs-handle" for pcs_ph=
y.
> -                        * Falling back to "phy-handle" here is only for
> -                        * backward compatibility with old device trees.
> -                        */
> -                       np =3D of_parse_phandle(pdev->dev.of_node, "phy-h=
andle", 0);
> -               }
> -               if (!np) {
> -                       dev_err(&pdev->dev, "pcs-handle (preferred) or ph=
y-handle required
> for 1000BaseX/SGMII\n");
> -                       ret =3D -EINVAL;
> -                       goto cleanup_mdio;
> -               }
> -               lp->pcs_phy =3D of_mdio_find_device(np);
> -               if (!lp->pcs_phy) {
> -                       ret =3D -EPROBE_DEFER;
> -                       of_node_put(np);
> +               DECLARE_PHY_INTERFACE_MASK(interfaces);
> +
> +               phy_interface_zero(interfaces);
> +               if (lp->switch_x_sgmii ||
> +                   lp->phy_mode =3D=3D PHY_INTERFACE_MODE_SGMII)
> +                       __set_bit(PHY_INTERFACE_MODE_SGMII, interfaces);
> +               if (lp->switch_x_sgmii ||
> +                   lp->phy_mode =3D=3D PHY_INTERFACE_MODE_1000BASEX)
> +                       __set_bit(PHY_INTERFACE_MODE_1000BASEX,
> + interfaces);
> +
> +               lp->pcs =3D axienet_xilinx_pcs_get(&pdev->dev, interfaces=
);
> +               if (IS_ERR(lp->pcs)) {
> +                       ret =3D PTR_ERR(lp->pcs);
> +                       dev_err_probe(&pdev->dev, ret,
> +                                     "could not get PCS for
> + 1000BASE-X/SGMII\n");
>                         goto cleanup_mdio;
>                 }
> -               of_node_put(np);
> -               lp->pcs.ops =3D &axienet_pcs_ops;
> -               lp->pcs.poll =3D true;
>         }
>
>         lp->phylink_config.dev =3D &ndev->dev; @@ -3115,8 +3055,6 @@ stat=
ic int
> axienet_probe(struct platform_device *pdev)
>         phylink_destroy(lp->phylink);
>
>  cleanup_mdio:
> -       if (lp->pcs_phy)
> -               put_device(&lp->pcs_phy->dev);
>         if (lp->mii_bus)
>                 axienet_mdio_teardown(lp);
>  cleanup_clk:
> @@ -3139,9 +3077,7 @@ static void axienet_remove(struct platform_device
> *pdev)
>         if (lp->phylink)
>                 phylink_destroy(lp->phylink);
>
> -       if (lp->pcs_phy)
> -               put_device(&lp->pcs_phy->dev);
> -
> +       pcs_put(&pdev->dev, lp->pcs);
>         axienet_mdio_teardown(lp);
>
>         clk_bulk_disable_unprepare(XAE_NUM_MISC_CLOCKS, lp->misc_clks); d=
iff
> --git a/drivers/net/pcs/Kconfig b/drivers/net/pcs/Kconfig index
> 261d2fd29fc7..90ca0002600b 100644
> --- a/drivers/net/pcs/Kconfig
> +++ b/drivers/net/pcs/Kconfig
> @@ -57,7 +57,6 @@ config PCS_XILINX
>         depends on PCS
>         select MDIO_DEVICE
>         select PHYLINK
> -       default XILINX_AXI_EMAC
>         tristate "Xilinx PCS driver"
>         help
>           PCS driver for the Xilinx 1G/2.5G Ethernet PCS/PMA or SGMII dev=
ice.
> --
> 2.35.1.1320.gc452695387.dirty
>


