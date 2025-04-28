Return-Path: <netdev+bounces-186451-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C919BA9F292
	for <lists+netdev@lfdr.de>; Mon, 28 Apr 2025 15:42:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EC54D17FD42
	for <lists+netdev@lfdr.de>; Mon, 28 Apr 2025 13:42:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78A6926B2C4;
	Mon, 28 Apr 2025 13:42:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=est.tech header.i=@est.tech header.b="m/NuiIBn"
X-Original-To: netdev@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2070.outbound.protection.outlook.com [40.107.20.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82D3426B0BF;
	Mon, 28 Apr 2025 13:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745847754; cv=fail; b=KkPCK5E9380xRbGptaSngqFYGe+k5HkSZomPob+eYb7Xj0hOh26TC11U47oyAtgK4/cvKaCdgpab81h5C2MGZqW1IvLrRrsBAG6eMxxrUmMSPtEw17kElkDYSthrecObH2PZxChmLVANoVIVOhQwBRAqmsFlGEmyBl6bI4tfCGE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745847754; c=relaxed/simple;
	bh=tFQVMpGtqeR9dk9u2Vd4U3+SDZQQLF58mjKRb4420/Q=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=SZ/fRL+mZFIWTQyzNPY7aq5yXBXNaoxTuTn3PcnrNyeHq1ET6qXduyn0fR+aonIhx+p6Slo37vA2L2Qb27zvQ5D2mFXJ3Y8hbBCuWXnPVolgSsnvGyFZUjOIhWBe6bAJ8J/VB8+LQMxO+etiUCnFMikIXh8WQWE7RYrk5mG3fX4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=est.tech; spf=pass smtp.mailfrom=est.tech; dkim=pass (2048-bit key) header.d=est.tech header.i=@est.tech header.b=m/NuiIBn; arc=fail smtp.client-ip=40.107.20.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=est.tech
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=est.tech
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=awHwTad/F1jysvNDw0W7Eekxat6dr0OVVvEHc2UxmT+sUjt3D4oDmKBUn5udrZUdzKELIzjKYu2bLXCxZUHSAZOEBcQq8W8DSt4klKzpgMhaVeKIaICEehiMmrCXS/hVYvyRfnc60KCwAqRR3zS3BtijrVEMC6aLbn1aGZjhfKMD+oitDALFO0AbG3eWlHrmZsuQNeEfVaDPooAJ3RJCeJx5lWp4urBYYFtBp07/YjlDfEES3svZ06XrrrcAw2b3QInjmstS+zzTKGzBhjGXJrpYboz6se75WtGyiPi+UfkrHGbiIYGvHCe4mwdMfSt/cXNUZ8Wkvo6xdCmiXQTQtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tFQVMpGtqeR9dk9u2Vd4U3+SDZQQLF58mjKRb4420/Q=;
 b=v3/gKZGRC58mT2vSC/V5zcrz4pj4lChT+yk7Wdk6dPJmAR8GuE+PpmBgvyQgQTMsrXtdIIjcGrp2MKlJGXbAEtLZ7UrmXAoVMfkWDHYfRvwR19OiEsFLyKi3JAVXmuKBkI7ynqmZ5w4zCSuvyvFTC4V8Equ3lWMq/fWIcAaxbryFpR97HNDNoeosJgbxqFsu5caEb8scc2Zy7X/knas6hqqmWubn+V+DMviBCQhT4nToiIWmFKCmnzNQehlLe+VURJQmV83AT3er08BMsiv+yGIn6ZFtjuaz5iKJFuDTHrU8cY+k4jHcjtFWuMYnthRYaHm29wahI7OCCvk6JOuwQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=est.tech; dmarc=pass action=none header.from=est.tech;
 dkim=pass header.d=est.tech; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=est.tech; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tFQVMpGtqeR9dk9u2Vd4U3+SDZQQLF58mjKRb4420/Q=;
 b=m/NuiIBngpFo6/tnGtORGg9MpEHHfWk62pLOkZVz60X3HgnSVJMS7bJumiVcuUBKF4l8e2RStwJGfCa6okadKP7DeFPTqAoP+9HKhX+dHqi2GlkHE6KuITLJx3E8l0wzfx07FCb3uWNUEBAZNf14wKbbcIUkf6sQ6yiiIPBLuGttvg4kcKhXmuiv2G9FEyaCxTh+Wk0+sab0NdTihfy1mUKanb4rPRNIQR1QCoJUSlClsXdc4v6o6yUl3gM7EE4kjZyKr5pzt4u0DRkZld1Y0BVRnvmBiuONoBozv6UFm2sJSMPaJw6W4rjc3yeBrrLrOiobB4yNo1Np8QT6uMy8ZA==
Received: from GVXP189MB2079.EURP189.PROD.OUTLOOK.COM (2603:10a6:150:7::14) by
 DU4P189MB2840.EURP189.PROD.OUTLOOK.COM (2603:10a6:10:570::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8678.29; Mon, 28 Apr 2025 13:42:28 +0000
Received: from GVXP189MB2079.EURP189.PROD.OUTLOOK.COM
 ([fe80::e733:a9e4:d1f5:1db5]) by GVXP189MB2079.EURP189.PROD.OUTLOOK.COM
 ([fe80::e733:a9e4:d1f5:1db5%4]) with mapi id 15.20.8678.027; Mon, 28 Apr 2025
 13:42:28 +0000
From: Tung Quang Nguyen <tung.quang.nguyen@est.tech>
To: Thorsten Blum <thorsten.blum@linux.dev>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"tipc-discussion@lists.sourceforge.net"
	<tipc-discussion@lists.sourceforge.net>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Jon Maloy <jmaloy@redhat.com>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
	<horms@kernel.org>
Subject: Re: [PATCH net-next] tipc: Replace msecs_to_jiffies() with
 secs_to_jiffies()
Thread-Topic: [PATCH net-next] tipc: Replace msecs_to_jiffies() with
 secs_to_jiffies()
Thread-Index: AQHbtpLJHkOz0hgtOUCgqJKVpBPwbrO4V/VggAC8a4CAAAR+nw==
Date: Mon, 28 Apr 2025 13:42:28 +0000
Message-ID:
 <GVXP189MB2079CF3E3057516046B4CA69C6812@GVXP189MB2079.EURP189.PROD.OUTLOOK.COM>
References: <20250426100445.57221-1-thorsten.blum@linux.dev>
 <GVXP189MB2079DD4E21D809DD70082B15C6812@GVXP189MB2079.EURP189.PROD.OUTLOOK.COM>
 <183272C9-A50F-427D-8492-A474E72E97E0@linux.dev>
In-Reply-To: <183272C9-A50F-427D-8492-A474E72E97E0@linux.dev>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=est.tech;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: GVXP189MB2079:EE_|DU4P189MB2840:EE_
x-ms-office365-filtering-correlation-id: c87ea790-a32f-4d4a-be29-08dd865a8477
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|7416014|376014|10070799003|366016|38070700018;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?czkxg0zf87IHSbpPKY4jssy0UiiL9/IxOKTbmdPt0EgXRemTotTQnVTzvI?=
 =?iso-8859-1?Q?bRBDMFh5OJRUkDF+Cham5hnpA0bekbOWVU794Z3FxBI1v/1K6+l2KotTU7?=
 =?iso-8859-1?Q?mi7vptoLribW35qtKjYuTSou088HDPaqAcYUTZFifpYoMtkIOaUu2WZSwe?=
 =?iso-8859-1?Q?5YC8sZU5z7NW7/aVDgnYgu73fCpvQzknv003xohiIkKJPuIuU79GZLhHJb?=
 =?iso-8859-1?Q?/0EtnhTn1ZJd++SXfs7twbIyR+k1EiP4anh+WXL7sR61D0CetP4Ii+oRQn?=
 =?iso-8859-1?Q?pSx2gCELjxWrUtwwOw1yGPJwecNOyBdZgbQabsZ18exmJ4sWG1ZMVh1/IB?=
 =?iso-8859-1?Q?I8pFSL9Qn5ZZZw4BYcY8cfPWSlOvzjnxKSMLbSNg3sROtxs5KshtMr1y03?=
 =?iso-8859-1?Q?wPBhVQvQW6JjgnyOB++My1QGLFA7iFbtqnjXKY0kOQp9HREConfM/KByXI?=
 =?iso-8859-1?Q?R/uU59Vrz9XpVKUkI5IT4SjkVC1te8ufDzLx0tJNV2nWHhZ1XIjV53/QJ1?=
 =?iso-8859-1?Q?s6wHo2jhXAdmiUnny7gnrc+uYv/ZNRHe3ELSuXbT7VNmCuPkIbcpQz8bbK?=
 =?iso-8859-1?Q?f0Qwnw925sJFwas9dCt/tHuGLjF1m4KXsDJP5IW7b5vY51i2H+wfR2Q81t?=
 =?iso-8859-1?Q?y4GcfzrHYAQ0Je65hFkeXH9zK2salEW+nlB3p00BcJ/EfBMHfusC0FXO6R?=
 =?iso-8859-1?Q?IbueZa9whhnSTIj1JYr4ZX2VnRQyn/D/fCsQ6qb/8l13l5w/wGfrGuJ5jo?=
 =?iso-8859-1?Q?Zy5xUPFhPXDmfxvvZCv3j44k6AJHOt17CZAaAqMk81Rs/uxDuSxmX66KZ0?=
 =?iso-8859-1?Q?tzI9A6f1mKAtv/rrb9eGwId7PfSA5zXioFe18tNA3iyRgRC4fYbwPJ077a?=
 =?iso-8859-1?Q?HHPz/TDA/rLKaXNbzql8D3XUVDSsOV3mtTm/zqz2AuwaBBJ/7kLjxqnsxM?=
 =?iso-8859-1?Q?yTqYUbG4v1XwUa5xX4Q8yxDCYEz4P9LIcubx7tVlQ6EyRT96cvp8wEeZ+5?=
 =?iso-8859-1?Q?CJhSv7duCtuhe3ChjMjCgNsH1PtnYmnTZBvFjV3s0DiBKJnHOuUF6A/XXO?=
 =?iso-8859-1?Q?qZYFzW5Ch57gp5QWYgLDJURpbnZyXcUGaHma3/lRZPYmWP/e19UNRdMxJd?=
 =?iso-8859-1?Q?Kbiw0sc+QyzrvhTcwZOhwlkbQDCGQRQg38CdC0aHeEictJpn66/6sUrfgr?=
 =?iso-8859-1?Q?HTgA5ltel9iBjnDCBz80LK5aQA4sWZutyTQ+BMXfLesOHnWKgsluWR7Jtr?=
 =?iso-8859-1?Q?tpAomd25dQ6u39yUGxG/Ce9J5M+KKXrt98bEkUXyMNNehtBXiKfB8rmpLW?=
 =?iso-8859-1?Q?cx7RUvuP6B/sOSELXQqivMT5+RrJzjDkvSvgKxS4/1lJ9fxg2TftT5rYp2?=
 =?iso-8859-1?Q?81g6oLin1DZ8fJdB752jbeS9v08zJeDONeM/1t+gfYMBc/5v2PT8Akm11A?=
 =?iso-8859-1?Q?yEkDatRDvdzENX9RvA6W7//bWIW25IxKdBhjygQlj5P177wQLM7KxMc4y3?=
 =?iso-8859-1?Q?JLuxmweTmoqopK6lL/3sIjcTQo3JP+8cBKv/r45WiVcw=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GVXP189MB2079.EURP189.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(10070799003)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?LQeI85HBO14b+xydqQD6ePrDGlyjQXHfsE3GmhfYyQxoigkVocAxAA9fVb?=
 =?iso-8859-1?Q?NCm5OHv0HCjqH9xt+fmi7lFaRNmJiawjlFAmn0Cu75W4+vF76xxNxTou9k?=
 =?iso-8859-1?Q?CGzrUISIckxIfeYLBQlIF3vV6CJ4axQdml1nUnR9zRsoun1IGPeFp9IlbN?=
 =?iso-8859-1?Q?phQILl86kMtsf4k4l+oCccG725Ik+IpaLFJpAk2UuR39kc5wADxO3H7jzY?=
 =?iso-8859-1?Q?AmRRkZQ0PU+4BFGrKmL50sMz19vqhCBtHJkVb75qV0lO/R9Ff+dmSCaZ1B?=
 =?iso-8859-1?Q?0vJitVMwBOpd2vuqnc+AK7nVjb27cxSAvWpd84hbO3Aarx5yPD8zn8bebD?=
 =?iso-8859-1?Q?GLQ6OIB+R3uvI1g//WdLtcJpF3t//JNfqcRBFIQk7pZ+XRVMzLM1uKMICt?=
 =?iso-8859-1?Q?d2G8lHL2aAFpK/GQo/txtpRNL5N4Af9YBh5TBSvGPd2uYZc8ko5WVhCMA7?=
 =?iso-8859-1?Q?ywkmg7qAzXEBMIDJV8ASCM0phG1+qFzw+gAnztTDuFlww5TM4IWQ1qDlE1?=
 =?iso-8859-1?Q?+oE5IVop0GcfMsTCkQJNZbJ4rScDt3Qemmf7Royw1j5UZNpv2YXhnnnnK+?=
 =?iso-8859-1?Q?4CRkGZxp+anzXHzIvP0pXsJ1dwRu58/ynqbUUJnPqBZZBWl9KAgDnpSeQh?=
 =?iso-8859-1?Q?btEUTos84sv9RbAwoTo9T317KzWotTfB7igX4UyGVOOMLrqh+3JTINiMZr?=
 =?iso-8859-1?Q?cOk79ZWeDczgvs5phxw//Q7Dm4/v32xt63S5905NhGEuQOmvxaflUZkw30?=
 =?iso-8859-1?Q?G60FsUn8pyuuweezWsKJekLElj2DwYU2nGXYwtibQxWw71rsNbx+Qv0oEP?=
 =?iso-8859-1?Q?MuV8bhcHeav0c0Yz/tv953+iLsyovjMUWdKlYR/wAUuYIIWrJTQnuhD3MR?=
 =?iso-8859-1?Q?6u/oDiFQ1zZfN64E0dDRVDeG2reB2boonwh1v5Lz0bEfqxY3/EQXk+yWOg?=
 =?iso-8859-1?Q?TjWzNi0x/clIH+PuK3b8Dw0r2HiE4YveBKqvEft7g5oB/zdF+axInCnJuK?=
 =?iso-8859-1?Q?wzhgHt3Mv1kqGJaQLCefi5W8dITRR6AT8Itpyz1Qaw0WCCBw+T77BKdCuP?=
 =?iso-8859-1?Q?efa8nlS91E8790kihS+aehI5XJYkjCfWJ5+gZgrkgsTew1BeLiwh3Zghh1?=
 =?iso-8859-1?Q?6h6rdT3ICaBBQGZ8xTlsX1NpbLNeCKVQWYlAneTNjGYFF1BqICZHS2gPrQ?=
 =?iso-8859-1?Q?CbjlHNfnOXp5PlKUpNly0Z/9BSvNZENXensZaiha+WOM3L/U143I3nceZK?=
 =?iso-8859-1?Q?b0Q6hvW+JonNHISPBFGBL5Mp8DXKikZ5VGCsXddpiyKIhjMWV70PNI25yE?=
 =?iso-8859-1?Q?YCvJK9TKleGTMmR+AQm4Bge4GBu3K4NLPXetLimlk9jy6L6lDffSqMofJ3?=
 =?iso-8859-1?Q?vzsSl7W6kVPaDoP6bdzuprXaH/l5DJwL9SQjtbZLK5yUn0Vg0SCkS2Qdgi?=
 =?iso-8859-1?Q?nU3V/Ouc4y7aR6F4Gg5J6dTJwgYjjyptNhhg/KdYArjOfRLPOVhT2vXOe7?=
 =?iso-8859-1?Q?qrwUBwm8eRcGjBNXprteDZg3Np8S30nbGKIh9vd1dGWOAkz1Jye9XKgRFO?=
 =?iso-8859-1?Q?llXLy+7bWp7culneNzbdeQcL/IC36vQmZOi77a5et0GzXDWZQ3V1ck9uw7?=
 =?iso-8859-1?Q?8BhpTWX8zoxGhrQTO1O2L6rqGQqaIIGymrmZTNCU796r5owM/C8jTtqFwU?=
 =?iso-8859-1?Q?u2mbL7L+4DTShpjRaYaNGqg00ywoeuoRq1Rv/YpU?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: est.tech
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: GVXP189MB2079.EURP189.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: c87ea790-a32f-4d4a-be29-08dd865a8477
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Apr 2025 13:42:28.3550
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d2585e63-66b9-44b6-a76e-4f4b217d97fd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +myHC1XE0F6iXuU9Sf4yvKOnh55CIZVC7IfwEFOMoVd1G/WmW7sFsbgHFLuB0LmzY6qHsqaB7OC2HgrYjNFIdjReniGcYR5gTFD9Y8wL4JU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4P189MB2840

> Which architecture and config did you use?=0A=
It is x86_64, gcc, CONFIG_TIPC=3Dm, CONFIG_TIPC_CRYPTO=3Dy=0A=
=0A=

