Return-Path: <netdev+bounces-247921-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B1258D008EC
	for <lists+netdev@lfdr.de>; Thu, 08 Jan 2026 02:32:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A6FC03038F79
	for <lists+netdev@lfdr.de>; Thu,  8 Jan 2026 01:31:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EFB42222C9;
	Thu,  8 Jan 2026 01:31:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aspeedtech.com header.i=@aspeedtech.com header.b="FFT1ddNQ"
X-Original-To: netdev@vger.kernel.org
Received: from TYPPR03CU001.outbound.protection.outlook.com (mail-japaneastazon11022084.outbound.protection.outlook.com [52.101.126.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64F1414A62B;
	Thu,  8 Jan 2026 01:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.126.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767835872; cv=fail; b=XT5Y49baZ/XBwCXRs1m2PUqEnXV/t4LjeIKCPn33/mg8rQ93Twj8l7Oq8UfRaB4xFxo6NCSVnQzZKKyWwzXI/mVSD2aHu9lGW+XULhLb3oHTlj4jtoD0EG1SeAqBZzw+uligXFzet8gAEWNS3/Ymg3JKuW/lpBztl7CpF3wNfP0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767835872; c=relaxed/simple;
	bh=atu7Fz/Za1sKD3lZDc5tCbpgZF2RmS2oy1Cki9WtMkM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=JJn4VWskOlpkEqT9D1cAu3bdxIPtWlBYUNSbtIx+C36d7L2LcIfg0D7lqdxRDxRp+fIMUCC0PWDgqcFRURYEZYIiJx96VrOlpivIZdpyd3BFxV2wjc6WOlfuGZBRXlFBSohBdkxBQYequ0MfpGbGB1xRvufi15XxeKTS/rReUUI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass smtp.mailfrom=aspeedtech.com; dkim=pass (2048-bit key) header.d=aspeedtech.com header.i=@aspeedtech.com header.b=FFT1ddNQ; arc=fail smtp.client-ip=52.101.126.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aspeedtech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bIK7SbttZXf9PZIBUUz/v7WC8zvHHIHP34NbZOR+yp453zN3C6jGKLuASC30Y+Zqp05maTRpZrshjaB/+NDOA3LECabuoREEaNddT+7koAJ1nC+JVZaJMvyPJANROiVWwnQxW5r2WjBd+CVYVWuXG0PJqoiCvPvVcdTePuJnVyE0jg0NKCREXTi65BGnPUWzvZVVtppAnUIZGeqGEFCOCwgAUgSkADIEkPVHI5hSRzHKe/l4lia7fqTf0IhbXcT9Zvnc7voH9BAaM6oXGInxzgtkCD+yZdWuOvoIJgfd/LUDnuMJRExVVufNeZgkgnB6PomJPYzbVIfhZ8oSl0Pabg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fLCKP/rjzm2xgf0bvJr/Tt7ZaTe7wdsx6aUVpUbsrrE=;
 b=h47uVH7xdDzTCzRXAlIEdTq+Lk+Ly1MAR6gYOmAuNVpr91LiGqUp/hlqGu/RnlKqrhOimCwfB0Xv2SlmFEqEa+pshz4mfYlY+ZTPYpuuNxPGDsClg/+uPXMxB2rwiJr30I+VgXzJHShIF6RA6s03pPZl6XaIwgczac6hVlYP/eEmcEz80XZdNbebCSMJ1bxIAvHPT4D9XacMXpgjDr36QtjRAV4rbx1W3NAApSaHzgDMmvfM2Z4JzqN4dS0vF+ZQclS5bOM1mguZAcq0WIsixDmD1it1Pb2rK1hUPjw45GN5Jt5uemxI+0Q5k9bg11j6a7D/QJsBS12/ouT8loZL7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fLCKP/rjzm2xgf0bvJr/Tt7ZaTe7wdsx6aUVpUbsrrE=;
 b=FFT1ddNQ/LmxOz+vxDczEFxmdT2AlOUBI7VM+sOChH+h+r5kGvd+W7JKQVxQLshbD48QWHc9bd2hS/bHC8QXMhXue07Zll2j9edFFCxCB9NIYNLbPOmq2AJ0oDhjK8c4jX7OUvmUEH1T/ISqJXWphV6eBJPSEpFc/RDxmvAwBBu471ikyKRp7FZ5oue+y5hLlLZCw0dyePfPoYLeJVn519903Y0cKsXjgZMEae7fZ0rjuJTWA/Yut2d9nZRA+UrD8krXr+LK6DMwvMyGMSlRDVKOV3HboBV1s3O+su05gYSIdGoytl0dmBGgBwxy+4FzddR4WQ5auS9onZJk3mIEaw==
Received: from SEYPR06MB5134.apcprd06.prod.outlook.com (2603:1096:101:5a::12)
 by KL1PR06MB5941.apcprd06.prod.outlook.com (2603:1096:820:df::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.2; Thu, 8 Jan
 2026 01:31:03 +0000
Received: from SEYPR06MB5134.apcprd06.prod.outlook.com
 ([fe80::f53d:547a:8c11:fc6c]) by SEYPR06MB5134.apcprd06.prod.outlook.com
 ([fe80::f53d:547a:8c11:fc6c%4]) with mapi id 15.20.9499.002; Thu, 8 Jan 2026
 01:31:03 +0000
From: Jacky Chou <jacky_chou@aspeedtech.com>
To: Simon Horman <horms@kernel.org>
CC: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Andrew Lunn <andrew@lunn.ch>
Subject: [PATCH 04/15] net: ftgmac100: Use devm_alloc_etherdev()
Thread-Topic: [PATCH 04/15] net: ftgmac100: Use devm_alloc_etherdev()
Thread-Index: AQHcfhIolygJOmR1TkOkSAnZgjsAzLVG3+SAgACgD/A=
Date: Thu, 8 Jan 2026 01:31:02 +0000
Message-ID:
 <SEYPR06MB5134F69965192166B1C631259D85A@SEYPR06MB5134.apcprd06.prod.outlook.com>
References: <20260105-ftgmac-cleanup-v1-0-b68e4a3d8fbe@aspeedtech.com>
 <20260105-ftgmac-cleanup-v1-4-b68e4a3d8fbe@aspeedtech.com>
 <20260107155517.GC345651@kernel.org>
In-Reply-To: <20260107155517.GC345651@kernel.org>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEYPR06MB5134:EE_|KL1PR06MB5941:EE_
x-ms-office365-filtering-correlation-id: 0e14c60f-c692-4645-2887-08de4e55960c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700021;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?6/4NPJxuicKnjhQM9I0PqN/A/rhk0D3lIcN0dsqvuN8uH4raaEMX/FTOLsvo?=
 =?us-ascii?Q?p3hygHFCzDjCOO+5Osjv2TYqVz6EI8As0W9SPEuB+A0+5YCKWwetwGXpIHBO?=
 =?us-ascii?Q?H8RivF/Wfmm3XAzTpBWjXfAGtjpl7ughwyL059cRdG6SAzupT2QqZVRqsLCI?=
 =?us-ascii?Q?u4NX81ur5JAZz7dcOP/k28ls/kaMqsdVbtZoAwHkcHj7ud1dpi+4FKZ9N7x5?=
 =?us-ascii?Q?PSGiYBz0vDtx7M670xMAKUFOR+Pq1Q3lFQZbc1QKAwch4PkEo5zMVRpF8Bj0?=
 =?us-ascii?Q?dsOmhnt6H2V1mF4QI59hOck6Cz9DnmumxW+eWps1N1d+iaI+iNdfqCVD+SaL?=
 =?us-ascii?Q?Cl4dJ2oJb+mKo6MeLbJtGHxpf/mmcahs56yNLAIVSsgQqG9OfNc7MDtLIUod?=
 =?us-ascii?Q?atPDDNHEURMKGF8qgNPMDhd/ZGH+S0GCIB4EDtw+/wygEZY9kIw/pSX49Wa2?=
 =?us-ascii?Q?FNXG1o8Q2haR6OUvTRkJ/twP8OngVsI9ox6/DqWASjDh4DttLTLJ6XWY7WAl?=
 =?us-ascii?Q?lrSz5nMoBjPe1cN6A58bHIK0EQDYkfGnjkkOq8dRmM8jxvmwxyWCCm1QxSNs?=
 =?us-ascii?Q?m152w5ncOJgXzhkLX3EG2V7RvN7+A+jcMVf0VVsCt/2o4UZ2af2AylbHqfMN?=
 =?us-ascii?Q?U+zuVyljPa9hlkrDdaY0CcxirjURLH95YyDt6Umpx4QuuPiMmP1r/MXqzKEB?=
 =?us-ascii?Q?qQfshZbHH367eMXAK69tp6bWPribzZZ8jHk6t82cDz3zLafBBnr1pJEAWKTh?=
 =?us-ascii?Q?5/LPQLBIlYpKw4mEBJPTnpHTRLJQADjuqZRlUTbjVBz3XnIufKgFTo4JpTnj?=
 =?us-ascii?Q?6h8qXgnGfGO5e95yEIKtJGBj8apYc7pjB4EAuTXKGi0ofB40L8LMKWmeGOgi?=
 =?us-ascii?Q?IKRNG6DMinPr+J78uD+tJ4Zm6gMsK+svgLfo899YbAn/CksT23Ocn09YVa45?=
 =?us-ascii?Q?t27EsVd+gn7Szlr2EeAgRgRivMvfEuPH3frrZ35c2v1elcsC0WNI/+o+MokF?=
 =?us-ascii?Q?sf0Z5dvkjSPk5RyEpJkQvAByiuTOAfgn/lOA3Vn546R2rBOW70StzvEYK/0V?=
 =?us-ascii?Q?G5zeuS+DIxdur3Hxm22pmzSvi4kzK2wVgRnJjwFcf1UmlCQ8hCIn9bArLB+D?=
 =?us-ascii?Q?0naA/n5Qa49ygDqquo+xSrQq5/+VKTpOzRbQaJX2F28sjgM/Fa1BYuMh08bT?=
 =?us-ascii?Q?zmOlnTNR2gTIIhEgSzksded9WndO58u/k6yKmzMHvw53kO494lbZhezJHkNi?=
 =?us-ascii?Q?FQhYRKhvg4+1ViGANbydPaPScAXk+3QxzY5RR9aVVqardPhin83GvrnB2gRY?=
 =?us-ascii?Q?M8OiIYy6E3vwLRygbOVVqzdQBDCY9eDixrUJ0kX/Cd2W7aIenGHnMG44tXQ/?=
 =?us-ascii?Q?5LkxGHBClPBG6RfrRHfESSwS4EwJNizBsD7y7q+vdOn+ljGzJlAX6QR9riPs?=
 =?us-ascii?Q?/Cs8BhkR/nRSsB1/vRIRFwFdlUXh7n7oP3Bp7PG+WHHirogswCdq45VgmASo?=
 =?us-ascii?Q?91+pZPhDGEY8D0UWJjRU+EdIiPzzxc7ijLz/?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEYPR06MB5134.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700021);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?a78WIzEjZEAz4+V9+MEDTRjUScBlgn28KOkw7Zq8PwqxnUPvjwhFkMGorxoA?=
 =?us-ascii?Q?GccHXymL0OeVwiGddsfLeiuRH/5pgtY2vIDG63X4gRxrVv8maMPAi/cJ6OGe?=
 =?us-ascii?Q?2N1jq2oLTHRuxJvvmjsdm9yw8B5Iqnb13E1X0ZUXopCzs8mcAiLcMplWlC3U?=
 =?us-ascii?Q?RgE1s5KSiKdiwC+Oxup+PjCe4FaXMDBBzxH+hx95gSntk0uMnqrmXR/t7vF7?=
 =?us-ascii?Q?/TqcmxqmMqfI+jJndN340c+gMBhmiLLPUu/MnOspaPljzj8ARUeOr+KfCBBA?=
 =?us-ascii?Q?nRybYC0OBC3lTFYFEQeAIlj/0qMnKboe8mU/JUpCnQHLO6ITqdWaVnTzLr+K?=
 =?us-ascii?Q?B5dLHvkwVNa3Vu2320ZbQA5KjvyL1MzpAdSwzUmfshNfLU33ofvvraMaQGDI?=
 =?us-ascii?Q?9YRyxsO2wy8+MS6gPsTfhxgUegR7uu/tv+KzeWIX7mPrD6py6f+QJeuJz40A?=
 =?us-ascii?Q?C8iiWGSY9Nc/3n+zGBfWFVUuaHhUcFvceMTuO1eD6t8vCW10cPDoBxOJmI5m?=
 =?us-ascii?Q?LBtsY5biwxTTsUDiPEzLcwsrfS850wLkzgKj15x+bHr9fxhEBRi0QTG2Ha3r?=
 =?us-ascii?Q?LPA+DAbjcGcTXc6gNjcZjO2HMMWdsgTGV/g5I9Yk+D9+8kp5FBv7y+TPnOEY?=
 =?us-ascii?Q?+Nv5B/Raceogo2jTjTOZMeiX21/WiLb61nXhtY8OqFjzo1p1KmOj/+qmpQ/a?=
 =?us-ascii?Q?FJhXoR48DiSrMunwadthOOt0SfOhBgIce63Sya86W3ntLLYMqEQJGctCawZE?=
 =?us-ascii?Q?De5xxVb5Ly/bsRhJjKrdRD9srZkofGhQ3lnYKLMRInwc0rPulUFbH2gWXjhU?=
 =?us-ascii?Q?Y0NrLOGfDafEoSpbOr5QCJV6FU46sptzDDQMCAe3qczgdKyBthnSgJJHSs20?=
 =?us-ascii?Q?Oah+tsWkoD5jYHoLJQIvql9qZzVMBZOk4dKk+T9Hk92oU4E+cGGe2MQnSUe9?=
 =?us-ascii?Q?IBuQxYDxQ/8lm480xZpahhEE32gjZIVSSz7QhutL6WTTbTE6wiCl89bJdr2o?=
 =?us-ascii?Q?lzMbfRgPeyX8BnJU2S8IVh51KDN2iYTOwcVPgW8leuEoa5tg19Wxih5mPa30?=
 =?us-ascii?Q?aq+zdovNbiUehLT6ZuIr+zg5zDip93J5uU9iubjG+CanRqTFoBnX1GHhfGpt?=
 =?us-ascii?Q?r7ykMSjHok2u0IQc7yJN3n/eWwhiZu55OcPhJLBLBJpDwmRMGA8lds6DGm+m?=
 =?us-ascii?Q?C2yH3mDRxCqCEQ910eRgANJefIBdicmAaD7HyZ1BLJ5Ial5k00d6eSWuFCPB?=
 =?us-ascii?Q?6Ex1NOjrPRoXrBUOQPfzCc+gwhJtEiEwB+ouAcgWdCT36C/rj1JwXrSnaUG+?=
 =?us-ascii?Q?p4I4PWNJCdzStVEomr9YCZkUlWclLzMOS5pnSAgzvRGb8CYi60CydASmAKO5?=
 =?us-ascii?Q?xAkJ99MmklmjvSL4v5BkE6eRaY2YEjuMPO1xk3sOWN6clYEpOAAD/W899wXg?=
 =?us-ascii?Q?bjod84F6FThJtkvudeh83PjZUS+NhLzxgPBAJXnIa6ENy7mLSytmrfFOgPLT?=
 =?us-ascii?Q?oBAhECKkSh6PMjQpJZ258BC5/Bfqtefy2duCTzNLFhh4HQS9J9c9LBw4itzQ?=
 =?us-ascii?Q?zpNKCMI7gyRHzAo1igHY+SBBeeMqzr3spSTKRAFDbVTBvnw5nCC+KbpuPoJ9?=
 =?us-ascii?Q?Lea3YMIGqOaFTBxg+7GW+fq8GE6PdWdw+eACgXqXuPWJuUGC4D5g/qW2jb7C?=
 =?us-ascii?Q?lCuV+S3HuTbcgu72dhwR48Aw1pnkPDjxxmKm9r0OBoJ/adiQGvsVQ4Tc0w9l?=
 =?us-ascii?Q?N9oaiSThuA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEYPR06MB5134.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e14c60f-c692-4645-2887-08de4e55960c
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jan 2026 01:31:02.8793
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wqIoWgrJQPKfOI+XUD7ZpLgc9HhkdDe1Sv7/FeX2VgXvBCPvrbZv2dfFGvppHIm2IyBQSz5FIpW5bmkJ/owi/dpvzPZjTfAqsg+fZrMAdkE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR06MB5941

> >  	/* setup net_device */
> > -	netdev =3D alloc_etherdev(sizeof(*priv));
> > +	netdev =3D devm_alloc_etherdev(&pdev->dev, sizeof(*priv));
> >  	if (!netdev) {
> > -		err =3D -ENOMEM;
> > -		goto err_alloc_etherdev;
> > +		return -ENOMEM;
> >  	}
>=20
> nit: There is no longer any need for {} here.
>=20

Thank you for your reply.
Agreed. After modification,
it becomes a single-run code, no need for curly braces {}.
I will remove it in next version.

Thanks,
Jacky

