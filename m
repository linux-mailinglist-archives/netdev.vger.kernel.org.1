Return-Path: <netdev+bounces-174272-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D68C7A5E174
	for <lists+netdev@lfdr.de>; Wed, 12 Mar 2025 17:08:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ECFE83BC991
	for <lists+netdev@lfdr.de>; Wed, 12 Mar 2025 16:07:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 444C01B85FD;
	Wed, 12 Mar 2025 16:08:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="jOpZMlxK"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2062.outbound.protection.outlook.com [40.107.94.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FB6A1DFF7;
	Wed, 12 Mar 2025 16:08:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741795688; cv=fail; b=Gyw6YNAFdoi3vLVsZics6Rt9VNWR27mKJkeVxlyPQAxOKIlOjuWv3ze9rVpzUWW3tkTnTgRBlmtY6LkFDv0AxyNRpQ8tSiKJxN7nXXiRXvgRUZL4RB5XAxKSi/ne5YGMFcRi+7/z5IYkjp1LjLoaAH5r6ZHIhXxmeqwaSzxv63I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741795688; c=relaxed/simple;
	bh=JSg7rHw1yvg5iGprVK8Lt932OSkzpnyS1YM/KIcL/Rw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=uFWfSF7M8Ht3fuNQuKngO1fO2nbxLk57sz0b9fc0gt4f1g9ptexafXQ/nGjTBTer3R+T1GEV5A9/ZuY05EVlFpdLqO0jyw1WUQIu6xnsQeN6VIbWXwTdFI4Hs4KZkkq/g6yh/f6UtTbsTLF9XFjSJqHX9fQBD6ZchUjgCzqCb7E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=jOpZMlxK; arc=fail smtp.client-ip=40.107.94.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dHVuVklrTJxKGgK5KB75OXGcki7slHrcCafHgEl7d5uwc7T6G0JxNA+jRiJvkSSHkEWbTsBcmnQrzFcbjwE7pLaXn7oEoHKQM8ibJT37TT2VKffZP88xKqRq0JRtT8AzvhnVdFcgc3fJyNfqoTj7ELI615pMEEL7cCfsgTMtd2Ay8PbmVTKkhR+SLh7qUsDNH+0gypdWxR/EPWoR7rNkLDTbdoDNv2to7JJLJqLfkoKlYoUAkgooU8ebQuTcYnDngwfy8z04Pcs6c4jNKGUdmTgBqfmm9JMNtYBGxsZb+wrlTXe4/37b48E4lq11MhqsoiBKrxFrISdwyBHn6TICPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IHkw6DpAMkbKYIrBQSV4RJFtlvzeEGASsn58rLZV1lQ=;
 b=sYlfNxzY65mVANlvTqov3xkd5TdnYUnpAh0BUm8nwoKCzg848ZBneMvSIpZMIfAcBpPU/BqkqQaSKORYOISAFrxAB/2gtXXasU3Qi5gVOyy0KIvuaAEnX4CwvK7iLCOjVFZRxbI7KQWIY5KPFF9nYGn7ZtR6vHw/EYJkKcTdtCxb4pFf2alg0uX5QSAZgwdx/7BSkIEq5jBd4dx5+7geYnrgQa62PM/vOyNqdWVCWxwqtirg2S1dy5fticyS5MQCVg/J+tC3xOj65pt2l/U6WwUl2sxrU3nS8iqhkciddyy4kIgTje6CQa8kDaNTAcdx3ilKfgeqcE4bJOuxOl9zFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IHkw6DpAMkbKYIrBQSV4RJFtlvzeEGASsn58rLZV1lQ=;
 b=jOpZMlxKDj4jFLUactWP3VC7K0mPAaFgqD3I6VAlqMf7i8GViJuWq9vpI1p2DxFz8sHVF6uZqrguVOhxLujxlr2yBOBLjBUeEuF6YBj5WsakgEYJqQAL4uhWpkDYnCAZ/l+kJn0xF5TKhGHaE6UoguMAyMJtuxPONv9IWjq7xI4=
Received: from BL3PR12MB6571.namprd12.prod.outlook.com (2603:10b6:208:38e::18)
 by DS0PR12MB9421.namprd12.prod.outlook.com (2603:10b6:8:1a1::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Wed, 12 Mar
 2025 16:08:02 +0000
Received: from BL3PR12MB6571.namprd12.prod.outlook.com
 ([fe80::4cf2:5ba9:4228:82a6]) by BL3PR12MB6571.namprd12.prod.outlook.com
 ([fe80::4cf2:5ba9:4228:82a6%5]) with mapi id 15.20.8511.026; Wed, 12 Mar 2025
 16:08:02 +0000
From: "Gupta, Suraj" <Suraj.Gupta2@amd.com>
To: Andrew Lunn <andrew@lunn.ch>
CC: Russell King <linux@armlinux.org.uk>, "Pandey, Radhey Shyam"
	<radhey.shyam.pandey@amd.com>, "andrew+netdev@lunn.ch"
	<andrew+netdev@lunn.ch>, "davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>, "kuba@kernel.org"
	<kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>, "robh@kernel.org"
	<robh@kernel.org>, "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>, "Simek, Michal"
	<michal.simek@amd.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "git (AMD-Xilinx)" <git@amd.com>,
	"Katakam, Harini" <harini.katakam@amd.com>
Subject: RE: [PATCH net-next V2 2/2] net: axienet: Add support for 2500base-X
 only configuration.
Thread-Topic: [PATCH net-next V2 2/2] net: axienet: Add support for 2500base-X
 only configuration.
Thread-Index:
 AQHbkzTKsOmRASZLiU2r8QNuR6Yh/7NvfgWAgAANigCAAAd4EIAABRmAgAABiVCAAAgAAIAABycA
Date: Wed, 12 Mar 2025 16:08:02 +0000
Message-ID:
 <BL3PR12MB6571959081FC8DDC5D509560C9D02@BL3PR12MB6571.namprd12.prod.outlook.com>
References: <20250312095411.1392379-1-suraj.gupta2@amd.com>
 <20250312095411.1392379-3-suraj.gupta2@amd.com>
 <ad1e81b5-1596-4d94-a0fa-1828d667b7a2@lunn.ch>
 <Z9GWokRDzEYwJmBz@shell.armlinux.org.uk>
 <BL3PR12MB6571795DA783FD05189AD74BC9D02@BL3PR12MB6571.namprd12.prod.outlook.com>
 <34ed11e7-b287-45c6-8ff4-4a5506b79d17@lunn.ch>
 <BL3PR12MB6571540090EE54AC9743E17EC9D02@BL3PR12MB6571.namprd12.prod.outlook.com>
 <fd686050-e794-4b2f-bfb8-3a0769abb506@lunn.ch>
In-Reply-To: <fd686050-e794-4b2f-bfb8-3a0769abb506@lunn.ch>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=fae5cb38-054a-458d-befd-33b13373d8d2;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-03-12T15:58:36Z;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Tag=10,
 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL3PR12MB6571:EE_|DS0PR12MB9421:EE_
x-ms-office365-filtering-correlation-id: 889169e3-fd71-4e46-cdf8-08dd618010fd
x-ld-processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|7416014|376014|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?kVOfS6EEALdQc+4/u4F9AArcdw9lrlFkDCgZWEv1hse7s9WE3ySG8rZP9tn1?=
 =?us-ascii?Q?VVuFcbKtjx4SuvhTnYRVyybp0q6TrN2z5Nd0Amn94n+Exe6+4aHLGJgzW4a3?=
 =?us-ascii?Q?MzpM9vs2TFY0xdH9yV5n0vm0ywk1ajmFnvd0VPxjrpoNoywPLo1+uZHt/Xw+?=
 =?us-ascii?Q?308xSTloT2rRrq8JMy4GMwI3eRkKLmmJkNMmfFAZ5xOpvEViu7/9JUcDD5XK?=
 =?us-ascii?Q?mumdaOaetsg5S+h3P/auN47N7WXykEHA0bToEDxdrtQJDYmXTCENF12jHspK?=
 =?us-ascii?Q?uA+fMTSza1vJcd7ywJKr0f8zSau+ZKdtkW19tx6o43A/+dkRiIHo476//Hwr?=
 =?us-ascii?Q?6i5Om/a5fp2YVwl1wr81Q5qJjOvU8NV7WuY4GWVoyvL0DC129307GTNDTBRv?=
 =?us-ascii?Q?k2vOl1XL3DzSbZaByhi/RaaKiV+sHgH/LBjSERhLtckagWeVI4+VcJwqG0XJ?=
 =?us-ascii?Q?LsDeUnPG+2MIix8T8lSNjHR+OPP9Kzwhlt77RMujet72SuZ/F3zF4XjfkUJ0?=
 =?us-ascii?Q?SBgxQ8ZKyZA573oK+6Hhog0RH/+5NwBXTAI7YtHG16Gs3uN/g/qRd9rfWIAp?=
 =?us-ascii?Q?UJwry138f6RL1QX50EnVktqqOZJI9isqyPyKvnbu89xlNccIHGkjjZMufecq?=
 =?us-ascii?Q?RK+eu6kGrHLJ0KSFVqSXolYXze01/ej4BKEBnvoa4AhWiJVyAwg4elVJsHyn?=
 =?us-ascii?Q?L19w7DRxwqQpxnFdeCRNyUkiHUJjaiKZYlCPp+vmzG3PMnh00QnAIfX1H3fl?=
 =?us-ascii?Q?HhIuVyXLUhH2DVl49IaU5XGJxISqERsu4yqDrigoaTAgKuP5/zCiYx3H5RP4?=
 =?us-ascii?Q?KaeuLDlOIZWtOG3WAiq9TWv4Yjnv8Nbk7bTpqDQjBOm3wKmhdUDzJHDqpHfE?=
 =?us-ascii?Q?0VzZe7awBUErh58TKPtQMgWPXVC53ZdkLRe17+i4/oS1CorlMPtl+ZbSV4YP?=
 =?us-ascii?Q?Ry04svI4fx/YSFGGhKz40xWdC78FwiR2HD1oWLIOFULQGvnpe+tTvpABLwwt?=
 =?us-ascii?Q?TROeBMTgHilVHTBQPAqiF6jIhD5KwWWOFbVGDx4cUF5ZEpJWBAaQWArgcyqH?=
 =?us-ascii?Q?rx04Z3P/qCEjmw162IxTase/xavnxH9k7Cbk/RDuUFC4NS+rYH4Dy76W3RtN?=
 =?us-ascii?Q?bqkpscGnDh7UkSESyfsNW6EHNvVmY0Nzd6JmYekPFJVPdm6PtLnq6HTk40W0?=
 =?us-ascii?Q?tfwfm1MjBEfc/Yk3rOVoif7shya7NjcyoNzbBlh0DBq/4PRng7Z40MP5Tr2E?=
 =?us-ascii?Q?U+0spJIiVvcEEBRNca99KQZKeyu1m2un77gTgQKOieVVGIoNaHn2mqcHE7/9?=
 =?us-ascii?Q?kn6NZz7RTUxEGwdpTxH4SQBIl72nTLgI7vC+hZR35vHTg+fUp9uXCI40mt9x?=
 =?us-ascii?Q?CFsj+uOgROhwYpzylTeshzYGfHJDTf60yfMohbRAYd92/XehWo+QPCyPRrfw?=
 =?us-ascii?Q?t4jirKE5WqlefxyeOBE00ARPhpUke5+E?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL3PR12MB6571.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?eghS+3nzfXeZ6u/DLi+ExyTWXuw+lwm+M6nO7du7AedVjEERDaSIhc+sY5gO?=
 =?us-ascii?Q?KsMJT4NvyYBoRt6Lm/+I3thGncUwioXG+FtBCP1RqLvcs2XABFzBpxxN6bRk?=
 =?us-ascii?Q?MwDEDflE0EUNXOEkScd156tZGv0gkFgw6BZXMGbTyfDJOCGsPXv6UHYs9j4p?=
 =?us-ascii?Q?ayIs+f7mGKx6S6MKxS8nPKI1oFFzrD+R6iRZEVpYtk4velrYf+oteIKYZ7hI?=
 =?us-ascii?Q?7zIAsZhvHjFX7k+f29KxJ2XiUYX2Qye3qXRqrwzJxuUb4+RTcbcn5lN7c8CA?=
 =?us-ascii?Q?rANVRFdM3mGip44TmmpcBvRI+XnxnT40fe06fpD8yit5ZBtCOU3iy1LJX0Oq?=
 =?us-ascii?Q?37Gi4mqqSJdxzloAkkhhmeu+qQ3XCVRIZxlaNkr+foM2t5m244ehFmnuXEPX?=
 =?us-ascii?Q?1p7qFzOy3/8m7uH3elTIrJlzS01h2U1t/f+fykZD+xpJC2sTGW6q68uCrCAB?=
 =?us-ascii?Q?KMvdUZYeqixvR9rgtsFRGXPPJsgOXvqA4kRY5zXRa/wT3Z2SLdyWGIpqQYSa?=
 =?us-ascii?Q?eulkla45K+49+MRZQRfs8BLNpx0WJcH5+Cuk52jw8qxabhPs7HZwyUXrqSBb?=
 =?us-ascii?Q?VeZAyZYubaRfUTNqohieaRYQl/7TAGayDEIt84PXhEmdydfFqNhmJ4hTw5oD?=
 =?us-ascii?Q?9IQ9Jx7w69LnNNah7tdZPiaZ5rjJJaL9edG/VTn1o+Fb75+Glhy3f0f9+yDC?=
 =?us-ascii?Q?uPv7DODQJuhrgK7RtrDn906j3WC34TzSbbpCFHoSTK87HJSRnZYChp75BD/+?=
 =?us-ascii?Q?mMEtxg9wdtj9ozyVQwCfjPhCz4NwM//5IxleWqL5aQY1s59fFB94OdmWv4Aa?=
 =?us-ascii?Q?8Gn7PxMwt+t0PRDtD157qJ8T9aAzTak1/c8QSyvXZ0bA3IG8IYM8OWku7d5e?=
 =?us-ascii?Q?IDyIWWtfTzsfhfJV4ZlgzKMkSjciBqcqeT2lvuDsfaEmdAsnuw8fXpufcaVS?=
 =?us-ascii?Q?o3jmToKFInPUzypfogByPZgl9v4r9aIIf397f5rWqggA2RxHXJD5eJtHW1IP?=
 =?us-ascii?Q?WsUlNVauTK5LGSh2o60TnEjZt+RutX0IV4P/6RMFnhuXG2p2PFMkCN1/IhvN?=
 =?us-ascii?Q?WBu80j3obToLZDjTPsDwQitP76x68bp+gqH8COshs549tXh2wlgPnSb4tHlE?=
 =?us-ascii?Q?hXTzBdVtiF+g6sLXv9SwY+f51y+NvkJ/L7+4+ArPf3ktko3M5dQsyh7f3yqp?=
 =?us-ascii?Q?LSJGcshXKT6KSdxIaq5fwjazHzpGWnNsoumQ03zM0tOsce5n96oPhPtzpQDz?=
 =?us-ascii?Q?J2wgsMSeU0J/QGa+q5wuEftwcchEbb7JqCjfGT30EfVcZaiyC6G/MBSCLAGq?=
 =?us-ascii?Q?2VTyd6ILKh/RkQeD6HLhgFdlc7mN28ZZMzpqeLhb8F3tVpc2oWKevBe7qA0T?=
 =?us-ascii?Q?kokUFd3KBzgbJB5ozQjAnGKuHz5lfF4TQhy8+vkUap3DcTkItBDZ6c9C0dlN?=
 =?us-ascii?Q?3touj60CybtpUuin2oKQW4c0u7Pe0BCM+T56H3/KBd/Vod4wi1iMVtcuHr0l?=
 =?us-ascii?Q?sZlSvB8njUb45vbUwU3Z38uPL41xsana7BEaN0uBhrs1sIGZ//PfY7F8Lj2i?=
 =?us-ascii?Q?+m5oIM0OH1EnHarGAlI=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 889169e3-fd71-4e46-cdf8-08dd618010fd
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Mar 2025 16:08:02.5076
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NMjf7lo/gv9M4X0Sfvy6PJpFLHpj/hy1QQC0AjiatOz0YsHoSapY6o4/ZyXLYBG00oGZz2WlKlHZveRW8c6uEg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9421

[AMD Official Use Only - AMD Internal Distribution Only]

> -----Original Message-----
> From: Andrew Lunn <andrew@lunn.ch>
> Sent: Wednesday, March 12, 2025 9:03 PM
> To: Gupta, Suraj <Suraj.Gupta2@amd.com>
> Cc: Russell King <linux@armlinux.org.uk>; Pandey, Radhey Shyam
> <radhey.shyam.pandey@amd.com>; andrew+netdev@lunn.ch;
> davem@davemloft.net; edumazet@google.com; kuba@kernel.org;
> pabeni@redhat.com; robh@kernel.org; krzk+dt@kernel.org; conor+dt@kernel.o=
rg;
> Simek, Michal <michal.simek@amd.com>; netdev@vger.kernel.org;
> devicetree@vger.kernel.org; linux-kernel@vger.kernel.org; linux-arm-
> kernel@lists.infradead.org; git (AMD-Xilinx) <git@amd.com>; Katakam, Hari=
ni
> <harini.katakam@amd.com>
> Subject: Re: [PATCH net-next V2 2/2] net: axienet: Add support for 2500ba=
se-X only
> configuration.
>
> Caution: This message originated from an External Source. Use proper caut=
ion
> when opening attachments, clicking links, or responding.
>
>
> On Wed, Mar 12, 2025 at 03:06:32PM +0000, Gupta, Suraj wrote:
> > [AMD Official Use Only - AMD Internal Distribution Only]
> >
> > > -----Original Message-----
> > > From: Andrew Lunn <andrew@lunn.ch>
> > > Sent: Wednesday, March 12, 2025 8:29 PM
> > > To: Gupta, Suraj <Suraj.Gupta2@amd.com>
> > > Cc: Russell King <linux@armlinux.org.uk>; Pandey, Radhey Shyam
> > > <radhey.shyam.pandey@amd.com>; andrew+netdev@lunn.ch;
> > > davem@davemloft.net; edumazet@google.com; kuba@kernel.org;
> > > pabeni@redhat.com; robh@kernel.org; krzk+dt@kernel.org;
> > > conor+dt@kernel.org; Simek, Michal <michal.simek@amd.com>;
> > > netdev@vger.kernel.org; devicetree@vger.kernel.org;
> > > linux-kernel@vger.kernel.org; linux-arm- kernel@lists.infradead.org;
> > > git (AMD-Xilinx) <git@amd.com>; Katakam, Harini
> > > <harini.katakam@amd.com>
> > > Subject: Re: [PATCH net-next V2 2/2] net: axienet: Add support for
> > > 2500base-X only configuration.
> > >
> > > Caution: This message originated from an External Source. Use proper
> > > caution when opening attachments, clicking links, or responding.
> > >
> > >
> > > > > On Wed, Mar 12, 2025 at 02:25:27PM +0100, Andrew Lunn wrote:
> > > > > > > +   /* AXI 1G/2.5G ethernet IP has following synthesis option=
s:
> > > > > > > +    * 1) SGMII/1000base-X only.
> > > > > > > +    * 2) 2500base-X only.
> > > > > > > +    * 3) Dynamically switching between (1) and (2), and is n=
ot
> > > > > > > +    * implemented in driver.
> > > > > > > +    */
> > >
> > > > - Keeping previous discussion short, identification of (3) depends
> > > > on how user implements switching logic in FPGA (external GT or RTL
> > > > logic). AXI 1G/2.5G IP provides only static speed selections and
> > > > there is no standard register to communicate that to software.
> > >
> > > So if anybody has synthesised it as 3) this change will break their s=
ystem?
> > >
> > >         Andrew
> >
> > It will just restrict their system to (2)
>
> Where as before, it was doing SGMII/1000base-X only. So such systems brea=
k?
>
>         Andrew

If the user wants (3), they need to add their custom FPGA logic which anywa=
y will require additional driver changes. (3) was not completely supported =
by existing driver.

