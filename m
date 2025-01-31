Return-Path: <netdev+bounces-161718-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 67029A238F3
	for <lists+netdev@lfdr.de>; Fri, 31 Jan 2025 03:21:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7BBAC1889856
	for <lists+netdev@lfdr.de>; Fri, 31 Jan 2025 02:21:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 908F533991;
	Fri, 31 Jan 2025 02:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="5+DaqbKz"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2079.outbound.protection.outlook.com [40.107.237.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D03EBA48;
	Fri, 31 Jan 2025 02:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738290103; cv=fail; b=b4dtpqGGNsSSMGLITnxtGQ5tbOB2RkP7gxmybfQJNNjeNLfid1sdM2B5hN6XWTPvBKYbcP70nXjvCT1mtB+T4QN2mfod4KmObM18ECq/B55vSSQ97c6jJoXUivzmeH4BV2bldFFMq+NDGAmzlpH8piAjLoSXMR5T8zFdFwC3szY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738290103; c=relaxed/simple;
	bh=lTz8CSQ+gI38O4YFX/NCnKq9XdDG34Rt+E3zwPGVhyw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=qs25deGLfuHs2aB/dgoeTeAmgyQ9Xeiv/WWu0kbrR3P3SJMyMGN4Lj8PTmmpXbBavzBG5hjW8pD/0u/uWQ8I7DJbfNeDLlCRF9ndq3IxGxFkuce4umBRMlX1QewqnwE9gp5fkAxnmKUGXPyfpHCIRJTh2jcbigl56jIQzs2mPEE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=5+DaqbKz; arc=fail smtp.client-ip=40.107.237.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VBokNzp/VcowviwEIBtPfKVGdO93nQVUPvdMUlGrDEdx8cUQasompvVGibIzO+SGb/KX0pZ1A8e88k2XPW+PKcyk7uY4KhW/V6GebG+sx+9cAIj/+uiPzB9B+zWojjNRfXd/7iQRafU9LwNcCC3VHXQjWEV2M1nW43SlsoOkqF60CV0vSt8v2CaJ0mMD/k5MOF7gjTYhzsWp3ncZ06DfonSCxeotGG1iIMR1W0gWuLVAfZJEXTNLcBvpDf9LBLphGGGqF7iyl7iaNygU0j7TzklezC5scyJVHhP3Z8+q9UKuKOvwxmaqtxbMLE7fOPFTMfmSRqCEi4+WtGY5ux0ygw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lTz8CSQ+gI38O4YFX/NCnKq9XdDG34Rt+E3zwPGVhyw=;
 b=C6CHZ0qdh2I4isF9DxtXncG0z29JdBRBlNHDP12oljaSX7rPgtxQqf5B3mQBHOEQxhmQ2y/ctLtMthJG+05VyOD7IQ55A/YrF+/DXfL4xkZHQnsxxVjYT3R29WFOnd/5NLnb61Z6CAmw8A6W6sH5sYGtG+SuwuhejM2zCKX8rP0o/SPsrb54FXIKUhpNYVWd9h7kki54rtYC0w2LCAbk4YCSec+YoFwAZlWB1F+JHQj0vneihy/Ew/aZ/9MX0SD24e6rUGjiW1/xIr1A5BXNgU5PgSiei+lcLcGgv1ZkW2MyDEr4oTzkfrwjXfr1ucGFDS8rCsmrUjevR9kkJnyDOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lTz8CSQ+gI38O4YFX/NCnKq9XdDG34Rt+E3zwPGVhyw=;
 b=5+DaqbKzYgW03z+pbrnnrrH1v582un//2nPJ4lCun4e146G0So5deWSr/tvs6IFk86kNruYbHJ/maZE7NroOQEWpwlLHPV3It7/1SEiwpoETcd8D5qYOwzFb+GfaQQEJNdtC6Tkd3IiqmO2IgDlr4gTR/RJGeGX7v8Bb2dsNEH8CB4dXLbctxivqxDHKvsEb4Pny/CYovDZwJN93xMQgcE0HDdOAM7WZAGM9GsANLZWG0Lg2RP/idpvIp+L18BqM4xVvZoP8CZNHcI+hRCkLhVXJPHDChsCp1p0wVF0K48Dv76DaWlrCAXKlHZpa89GM6yg7+taL3KCBWYgip1e1iA==
Received: from DM3PR11MB8736.namprd11.prod.outlook.com (2603:10b6:0:47::9) by
 SA3PR11MB7536.namprd11.prod.outlook.com (2603:10b6:806:320::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.18; Fri, 31 Jan
 2025 02:21:38 +0000
Received: from DM3PR11MB8736.namprd11.prod.outlook.com
 ([fe80::b929:8bd0:1449:67f0]) by DM3PR11MB8736.namprd11.prod.outlook.com
 ([fe80::b929:8bd0:1449:67f0%6]) with mapi id 15.20.8398.018; Fri, 31 Jan 2025
 02:21:38 +0000
From: <Tristram.Ha@microchip.com>
To: <andrew@lunn.ch>
CC: <olteanv@gmail.com>, <Woojung.Huh@microchip.com>, <hkallweit1@gmail.com>,
	<maxime.chevallier@bootlin.com>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<linux@armlinux.org.uk>, <UNGLinuxDriver@microchip.com>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH RFC net-next 1/2] net: pcs: xpcs: Add special code to
 operate in Microchip KSZ9477 switch
Thread-Topic: [PATCH RFC net-next 1/2] net: pcs: xpcs: Add special code to
 operate in Microchip KSZ9477 switch
Thread-Index:
 AQHbcTVTuivbdfDuaUSUZ/9LsKZxAbMr6oWAgAAP2ACAACTNgIAAL48AgACPMRCAAWS5zoAAa21wgACkGACAAMJ9kA==
Date: Fri, 31 Jan 2025 02:21:38 +0000
Message-ID:
 <DM3PR11MB8736E9F1A872A0E483E6328EECE82@DM3PR11MB8736.namprd11.prod.outlook.com>
References: <20250128033226.70866-1-Tristram.Ha@microchip.com>
 <20250128033226.70866-2-Tristram.Ha@microchip.com>
 <Z5iiXWkhm2OvbjOx@shell.armlinux.org.uk>
 <20250128102128.z3pwym6kdgz4yjw4@skbuf>
 <Z5jOhzmQAGkv9Jlw@shell.armlinux.org.uk>
 <20250128152324.3p2ccnxoz5xta7ct@skbuf>
 <DM3PR11MB8736F7C3A021CAE9AB92F84EECEE2@DM3PR11MB8736.namprd11.prod.outlook.com>
 <DM3PR11MB8736F7C3A021CAE9AB92F84EECEE2@DM3PR11MB8736.namprd11.prod.outlook.com>
 <20250129211226.cfrhv4nn3jomooxc@skbuf>
 <DM3PR11MB87365B3AD3C360B0EF0432F3ECE92@DM3PR11MB8736.namprd11.prod.outlook.com>
 <dd2e35c7-0bfd-4679-8ee9-5c69244acb8f@lunn.ch>
In-Reply-To: <dd2e35c7-0bfd-4679-8ee9-5c69244acb8f@lunn.ch>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM3PR11MB8736:EE_|SA3PR11MB7536:EE_
x-ms-office365-filtering-correlation-id: 1100704d-bec0-4dd8-2793-08dd419dfde0
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM3PR11MB8736.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?hXUXf4KLy8QgxRVy5NZ3og/D6oGBfcd+B41q1BzUnYqnHQ2Ds4Yx2WhnZ4uv?=
 =?us-ascii?Q?p3Q+fBDWmAkVr8Aey20y1ETjRkJm63l/SI/dlrTqGsMguNeVpyO6Ucy9hJgS?=
 =?us-ascii?Q?4ntqq8hDbMDxYBIj6RfWvqk6q7mIWdc2YCsZQJaKBMFo+rZiah52LWiC2wma?=
 =?us-ascii?Q?vatM+v3UF0e6mOKgSNUkMz3gpn2cR2ZUdNxXuMMO/xjRh2AukDeAIDluLwcI?=
 =?us-ascii?Q?uublsOZI80/VRXf/5AJnhb9PcFNgm5o3Ruke8O/hmLwQM4I7CvIyOc8Z8lc5?=
 =?us-ascii?Q?RiYLCM6VdVWO+leXyZGa26+Y2qr/db+JZ/6zVVNgM8dEGJQVTlqpw36QtfQ2?=
 =?us-ascii?Q?esvVPuZDwQhxOT3TL9R/Up3fsmJxCVy1OYTZ5Vp8Ywlfx/rc5EBtmRPAeipK?=
 =?us-ascii?Q?++JHGfStDVX3ov/hj1dXK4lr/j1Vc1rWKLGgqya/2Z8fh3OwP8wm5c5sqAaK?=
 =?us-ascii?Q?KMDzGrxbzRnu1+P6GGYsQ/eeu7CKynQo+P4ouznUYU9A10RlG7sIhlkxA5H1?=
 =?us-ascii?Q?68VrktzaCXaIuNlID2UDrpwiJQfANnXon2XdIIDwsTU2oHNKqAUpXKyGQKUc?=
 =?us-ascii?Q?czy9bPshUW32edVHuXrIBpE1htHKmsvV3bIwZXQAqBho+olx1c9lNVwWAxfu?=
 =?us-ascii?Q?E6T4nru0p0EnMBUF+9v/ZBJ+8gFIQp+kZBkLyKzC/0u+k+fRlA3j6arWPYCY?=
 =?us-ascii?Q?9de8KpWHnwqGcDlo1runbkCRGcnV9N6sQaWKFvPkyYDkNUvhkAJmQUDQd8Kc?=
 =?us-ascii?Q?6J36MxxwuQM6PXydhT0BwbcIt2Bc6TUTGiNIv85SOydovvqBaIwyunALeWk1?=
 =?us-ascii?Q?fcCUzvHUF05Rt346Y9+sW309ZAsLjdl9oRNSQC0++9QisIFwbzEl/iVS5Q0K?=
 =?us-ascii?Q?1/Xyt6D+WPkznaa14vXMQkfDNu9idYTnistA6/75wL/v0g69nE7MJabd3cVo?=
 =?us-ascii?Q?JJ+INHRcy5RhYXBfl4nR0WW26eXq/XDGZNNkQoTg+Lhq0PD/9Ddj1u1e0Cpp?=
 =?us-ascii?Q?U5DVZ9zrtk77ApPQQAzt0tftfjdHI//CECs/1B6i6kwJtozZ9obKLsxUOPO6?=
 =?us-ascii?Q?be84eBsNFTTxu5wg8psz/IZdRrAJpkEIhqxDEeIkpcTe8u/kA2V7kV/4sG84?=
 =?us-ascii?Q?eBKuLp1gfl7r6hqvZaYkekRtNVWJiOkQaVy5M5yznIoLKafx5CKra1JZUkEE?=
 =?us-ascii?Q?j5NG0BX/xGxqND/S6LF+eZQg9uolLAtC6NfGWkc8Pc1x2BE0iQ/z8/NA2Mw0?=
 =?us-ascii?Q?xSr2m40qcItDO/1AGMqE3Z94sxnwqpK4XnuKnhEU5ek+wW+pqTBV6tdBwhiA?=
 =?us-ascii?Q?CRWs6YFAPeM1TZVh/WcauZSMZpmt+rJ2bzOYJ69RfTS/2Rc+iBcZLG2rHTUV?=
 =?us-ascii?Q?LycLYTvkWf0uIkAs6RVQEHk1bcE5mi9wAQyetqJHqydbrUPEQXiVHOjSXKAb?=
 =?us-ascii?Q?ImwFv3WmNXqasgg2FQ9NNQvVm14iH3q0?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?p/7jkmu+itI+DYg+YyO1zFm7P1H3eqrnWmt/5nZ3pS9zrf+jVq84lD94nswJ?=
 =?us-ascii?Q?1ZKyVRf4ynXU4Ai11y6KB8+UOVqz5pR4n9XC6FZ/I51I4IsK4mhDcujyycgf?=
 =?us-ascii?Q?QPZRhoG6/QQeF0YeSmrwLpO6mAA4GZJTN9eFlZK8dIHyR+rXsTSXDJnOUVe8?=
 =?us-ascii?Q?asaD+cxwSQ0k+GRUEaAuYcysscywsfoc74K9SE1ehc2tOYaVkXMgconER6R0?=
 =?us-ascii?Q?rFJaW9m3wapx6eaiGek5IvEA/vU79RIlXV/8uotq3xVlUp9WUa/KJbfQGf9m?=
 =?us-ascii?Q?Org32J6kCU8Vtl94E67RloLudFyEMrSxE2SMrkLZHjcqom0WqNKmh0DsvWqS?=
 =?us-ascii?Q?rOR4SwzmUOomra+bAx4O9SLKEhowrdNgDTEEH2iDvZdoV/JcRILaJaLeT01S?=
 =?us-ascii?Q?ylQdDK4mubKL31USBUh0EhI7Kk2laOp0YoWzCQO0rlFWH1beD3Il1/E3LCDU?=
 =?us-ascii?Q?a4VADAV+zxmQEH0RPHCqjBgAT0hgFEMWghSh67ksve9HllYVjYM5xHullag7?=
 =?us-ascii?Q?ErHvXYBrqewlp1UKu1iqfEi97G6eDH1DHS1lpjlN59YfNR5ByR4MT0WNCH1D?=
 =?us-ascii?Q?8fG4f2/JVXlJBIzdRC5HtXzASY766Xo6+UUNaInfcqZYrlAc6QrvOSRinPGj?=
 =?us-ascii?Q?jL0BcXf4PSeZRRl+qgiuQaa+3J+pqWcpGnRmH7ibq4Zgtma9jQT71RK5SwrI?=
 =?us-ascii?Q?EOFDonTaQn48wHX7etgtwloHVxHxLkTbDUNwOPkyDkJndeptA95sf3BgAXuS?=
 =?us-ascii?Q?MvogQB5WjWrFkY8KGwS50aaHY4uzE7ZV5BFMbfTxi5qBPiOVqgH0U0BRPwsk?=
 =?us-ascii?Q?aFwDX+8K/mTNFMI+vmhAZ1HE0cmX1y6j7hQX4KkN2Jal9zVkkxE7sYQLw0LS?=
 =?us-ascii?Q?r+aaID4y2JCMG0TzUIkGjr4tWqGN/wd242hGQrPKWv4bWmPjVcvbb2SNwZ8c?=
 =?us-ascii?Q?lVNI+tbIr/cPWkssDYZXjhaFstU3VgB4rR0v4A7dCDTmFEiCBpofQjMXJ5uM?=
 =?us-ascii?Q?en1+OTlF55pvdQaOzBOzqBw1UucWRdkCGqrmZ8QkWHDTx3dMZzoGuMQHQOyD?=
 =?us-ascii?Q?OzSyPh2webzRwPPNHYgaeq/3x2/bD+9atsLaZKGMy5bk+qUvFCLI1e/fIw8k?=
 =?us-ascii?Q?0MpOvdo3bpR0IR4vqzManKJQ/RCLur1yxE0Z2WO15cQ8XxZE1l0VE2KJlOoZ?=
 =?us-ascii?Q?4EJgiQaPNdL462xtBfS3/ex9lIx2s/yWp/3CmeTOvsNu1Ifao9XG6l5TGYR9?=
 =?us-ascii?Q?85iQzm5LH2zVZpE+AcDbmerrj470YkLS19kLb2VVcoKqtsTGKzm9byUQmpM7?=
 =?us-ascii?Q?DjgjO+0DYTOtl/YSUvAIxdn639L31DvHaK/Wb7krEWJBauz9iwxYXDJiUTne?=
 =?us-ascii?Q?xJeKmK1uUhEzXwqJHI6N3O92VVO4gwQQYkQslgT03tc7panMWYj0f5oYD9z8?=
 =?us-ascii?Q?2itnesUxD1tiWxaqnbfhIYvVvJAsc3OHRhs6krpPCBlKwBFwuwzP88rTi8Z5?=
 =?us-ascii?Q?uaMCVboKtVMUS2LLBObyjR0jhvQE34zs1wojA9XMho+KUEJzMJgCfDg/8KAG?=
 =?us-ascii?Q?VI5uem4bSYxo+mWIloiYB3uZ9tvhc4Rn4TlRD4x9?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: microchip.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM3PR11MB8736.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1100704d-bec0-4dd8-2793-08dd419dfde0
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jan 2025 02:21:38.1217
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qqhIRpDalYX5cUL4nargVCu5CdBgwmxzsoKIOufo9YaMs089TS8mIQdSurqBKvc4fEH60C/DziEFSfOzF7DBda8+G523d13Pkn6aup6G8WE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB7536

> > As I mentioned before, the IP used in KSZ9477 is old and so may not mat=
ch
> > the behavior in current DesignWare specifications.
>=20
> Can you tell us the exact revision? Now that Synopsys have said they
> will try to answer questions, they should have access to all the
> versions of the data book, and can do comparisons between revisions.
=20
I will try to get the information from hardware designers.


