Return-Path: <netdev+bounces-209916-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 07A8AB11515
	for <lists+netdev@lfdr.de>; Fri, 25 Jul 2025 02:17:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DC8051CE4D45
	for <lists+netdev@lfdr.de>; Fri, 25 Jul 2025 00:17:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA5EA1096F;
	Fri, 25 Jul 2025 00:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="hEDFMjUI"
X-Original-To: netdev@vger.kernel.org
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2070.outbound.protection.outlook.com [40.107.100.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3C7B1362;
	Fri, 25 Jul 2025 00:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753402653; cv=fail; b=lzzsEZmILZTxbRNkeHULbPhlxcgt9UXdBGFO3ekLNLgwM4incIFCHWkq4FbyjA2Lje9p197lVsVHFADOMe+ktm87hJIOHFOjnT7f9dbLVkM794AnoeW63e2VfOS7VhBTL3/j1xReCJoj1hzAGfSr3RG0OUd2OEeYFKF22wCehV8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753402653; c=relaxed/simple;
	bh=HcgEYhbHumBVIIGYv+kT/nPcw4iMSpU5MamwfLFiD1E=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=tiw+shz6mWXZIFox7yRMV4v3KhdFS7TXS+3MRitCN8dk9qUcrqY1dats0nrQBM+MnopQ9MNeeNWhrwcHy2z8ULasEW4XGfyZYIqnF/SgM6dIlIEqK92PaLJcLjcUxaiVkzAbJ90rE2w/pRHudbqaMMeElR9GDNoj1GYJ7kdzkX4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=hEDFMjUI; arc=fail smtp.client-ip=40.107.100.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Y4z1Ce4mEj3pqSMX8BlLmNJIDhFpnJxJ1+DyVLy19WCrjRdriOvDscbDSf04MI3eHpgNMjhNCSsh+70O8JHftMUNwyyD9Rcz0QCxiF2XzuvvAXyoGCFpjT5jx43pWRm8MdfeCVHXbW+on25FhxpTAHl9m1d7yfZbJ5Txm84V3pk6cougjrdwteXnkhF5r1FHVCnkHPuFulP5CjuEpOIhB8M5FpU6Qv4YuMNJXFwuzt/0FERfdWyl0osTWhZOv5svPoYFK7ZpNMlik35Yn1OwhEJILtrKFD2LwuX8jxBTqirsPFqMWP9SkvS7tgCcmuAUAF1s6jxJbFEvHWGxvCOmBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7C9pYEMRnMf97J1Zk6uTbXTCyub+/MpvvyBl6fx93PI=;
 b=NckPWEPGvbSUBXHObT70KhlRt+6tMuiFBeVS7MaYSxkX6OGzzDEisMjIaaOWgJi/irfqKDGh8JUvwNPwz1tvewQ12VsAX9STuHOF3Azpzoo0Wqcaqm5FgTC2z65TsToxysiU4Bb6//ZVUwgSahoz2wfWBtnDJyrBcKFjqS4QMCMUnqkPWqAOri2xeY5jyVfgATbnRQhdWL7ETKtAjx1X+eMXuBNQRX/PeyHoMzWk5BDn45aS1Ue09SRZHb8rK9cyj+cl20BfP6Q2lj96SBDNP9MHo7m/8cKXcQVxbNOOSSsY16SMR55KXQcL9KmkLou9+/FziRUt+ReBRLn3vczu0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7C9pYEMRnMf97J1Zk6uTbXTCyub+/MpvvyBl6fx93PI=;
 b=hEDFMjUIeFxb0iPcXXdUmyfnhaYiYYaGwk6dUHJgYJslF9kluzMiJSoS8vtlqhbJ9+qgJBfIq0vz+n+ihsG6+sM0Bmj7d66VRTZnCydigFiUZa+oQT1X0ExOZDPE8ZDXotlxz5X3GCBXkgTLmi+ArJNt13vGlSv57gUJtO+RKVIN0amFcVXKxmOvpnmFopghKA/VvJTnVlTobz5gySdcKKWQLQMT3UPnyxidqy3tWSNi0vfQbnJNEt1qFG2DfFp9VMqCmUyH8z3JjoA255gUsqYXlUsGpCglyOH9fcvxt3p6fbKZALtLq7XHBXv+sWR1NmguNT7qmsaUNHSqbZZfYA==
Received: from DM3PR11MB8736.namprd11.prod.outlook.com (2603:10b6:0:47::9) by
 LV8PR11MB8747.namprd11.prod.outlook.com (2603:10b6:408:206::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8922.39; Fri, 25 Jul 2025 00:17:27 +0000
Received: from DM3PR11MB8736.namprd11.prod.outlook.com
 ([fe80::b929:8bd0:1449:67f0]) by DM3PR11MB8736.namprd11.prod.outlook.com
 ([fe80::b929:8bd0:1449:67f0%5]) with mapi id 15.20.8901.028; Fri, 25 Jul 2025
 00:17:27 +0000
From: <Tristram.Ha@microchip.com>
To: <horms@kernel.org>
CC: <Woojung.Huh@microchip.com>, <andrew@lunn.ch>, <olteanv@gmail.com>,
	<kuba@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>, <maxime.chevallier@bootlin.com>,
	<davem@davemloft.net>, <edumazet@google.com>, <pabeni@redhat.com>,
	<marex@denx.de>, <UNGLinuxDriver@microchip.com>,
	<devicetree@vger.kernel.org>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH net-next v4 4/7] net: dsa: microchip: Use different
 registers for KSZ8463
Thread-Topic: [PATCH net-next v4 4/7] net: dsa: microchip: Use different
 registers for KSZ8463
Thread-Index:
 AQHb+Et23Zt1PEXlIkK/NsvHKZPcN7Q6zkiAgAABfwCABDF2wIAA6f4AgACpFhCAAUD4AIAALLEQ
Date: Fri, 25 Jul 2025 00:17:26 +0000
Message-ID:
 <DM3PR11MB87360DB5CDD47DF4A64FC33BEC59A@DM3PR11MB8736.namprd11.prod.outlook.com>
References: <20250719012106.257968-1-Tristram.Ha@microchip.com>
 <20250719012106.257968-5-Tristram.Ha@microchip.com>
 <20250720101703.GQ2459@horms.kernel.org>
 <20250720102224.GR2459@horms.kernel.org>
 <DM3PR11MB873641FBBF2A79E787F13877EC5FA@DM3PR11MB8736.namprd11.prod.outlook.com>
 <20250723162158.GJ1036606@horms.kernel.org>
 <DM3PR11MB87369E36CA76C1BB7C78CEB7EC5EA@DM3PR11MB8736.namprd11.prod.outlook.com>
 <20250724213556.GG1266901@horms.kernel.org>
In-Reply-To: <20250724213556.GG1266901@horms.kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM3PR11MB8736:EE_|LV8PR11MB8747:EE_
x-ms-office365-filtering-correlation-id: 4c3b19f0-213e-455c-7384-08ddcb10a2ee
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|7416014|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?50FnVfED95o0lWBwdzEtlJm1vprKyNNpZKFW7ED+m6Tp3bmIBhKHAQBbc5hh?=
 =?us-ascii?Q?MFOGWqTvfiIvbeaCYm0f4NVhHHAm1p6KEFcrvPBYa1cF9aOnRJpdcEE768iR?=
 =?us-ascii?Q?2AYQ/e1/oHxpYGpKK0sWvnKFSPsK1pUnB1dwM94U27sMekGjzCHzeodDMWgY?=
 =?us-ascii?Q?Z41OhvyyeD0C8TSJjAdSqt2v5ki84/kky4EzqKEwPz7YVLMZoa6sbAJUaoyB?=
 =?us-ascii?Q?hIlZVSzuobMI3/tY8ObZuD/HRlK9vj2825VeitmP0Qy4i21LlPvZKmJMHGQy?=
 =?us-ascii?Q?crawJaIm28oWLBudqKYCfbjvvU2YFMYSg7Jn/3nly81ylQ9C3KDlNzEvmv1D?=
 =?us-ascii?Q?ekDpV6R+4sXS8v2fz3HDjm1I/KB70XeBUCQM3+/sQ+0akkKKnRMah+io846g?=
 =?us-ascii?Q?Y/pPNehujZ0/GNKlwYwCRTJglmkbY6rYkgBsEPnQoQTlh9UqhpyJCZhbktq+?=
 =?us-ascii?Q?+1L5TzWAHXCRP4frfZn9kqw0fRZLYPjrQFAE2I4VLIr5UCzBNeX+CzVk0DTX?=
 =?us-ascii?Q?O50b05H/GLkRTgu3SMy0ToO0zwM0Rb+TX4hfVT2EvaAuMQA4h/I+LkRestOL?=
 =?us-ascii?Q?0l5eIOrIgQuUSFG60Kj3Uj80AK3oms52oYP4+zMCDGslpkNin+ws70EhCDzo?=
 =?us-ascii?Q?Wy9cXz//6gKdgxBsQ90wbK8wACiuU63FpPac+dPU6L56KtreLwl3IG06welI?=
 =?us-ascii?Q?8v/wr62RoYV65nvbdJiQFNZdpzu4rhemRo2CzOmhACkzctM+MtcDvqh+61pF?=
 =?us-ascii?Q?mEpyAGz87J4W7NNFJWzaOIautSLFkdTbbtPyDg6l8JHRRfAZshJY93c/mkt+?=
 =?us-ascii?Q?3Bwq7C5JYvNTkw5kXytVnJEF1oGBIbhqpw8DqP/l7jeJEkdjPmCrx6uDyDAP?=
 =?us-ascii?Q?zpsvJRg++lq2ugCYfesbGWdcVH5DOSC8PaER0oyKh6b6Xc01uTtT2K8oIUj+?=
 =?us-ascii?Q?ePM1mZ2U2g1DC+WTCP3xCduG0yKm4YeleS4o/iDWXlO9+KQAP+xaQnSiuXUd?=
 =?us-ascii?Q?WzzRkPHsofFEfcDyDLadVaaNavjbioXeiL5mlW92a1ALYEJ4dJH/1xCgQ5tp?=
 =?us-ascii?Q?D8X+3t5L+WvYxocopAzYnq0zk3Ids0ZMxZROu1srr+vNA5pgSE21+a1u44nf?=
 =?us-ascii?Q?pMuz1Mv1s05UYV6dj0F8DJiQX0Jq0VCmuCiTngBfx+uWfZ7GLW9Xl2w0vDp5?=
 =?us-ascii?Q?I3TtZmnvAonrCGkYiOwGWNmozPkYm1NA0YEiJCjEcsaMkeCdez8+tix+vxN/?=
 =?us-ascii?Q?vkIBLdoAM7aJGMxASiyVwBOKEPmwIX6ddeeijF4BTaybjpXXnx7XxYujIOe4?=
 =?us-ascii?Q?hxF9UEhACj5d0jQSYhG9Ms69RhhAyekLE3z7rQbjm5HftoZrykMAD4uyEgyV?=
 =?us-ascii?Q?XjCYoUAoxhkyf8AIIfyWtlEOUu+4gdhUNidIfMpvl/F+n7tN4MhVrMA0DTiH?=
 =?us-ascii?Q?IoQqIGC7txLKq7XgKyp0h76Pp9sROoeughaJP2vagVGkZmUt1Q8ZzObX0U9y?=
 =?us-ascii?Q?0JW3D3A7iSNDwv0=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM3PR11MB8736.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?gnJBvaHmXfkcVYOvD23OLE9twczTLrtmDtzdPyEz2YzG/Ogm+YCpLuQBKiEu?=
 =?us-ascii?Q?D81Krn37o2mkZGdXPKivmfwjACjpmEs/onmr8mB5/o+YA2xqreBdbgQd/lS7?=
 =?us-ascii?Q?D8xU9upvJGZ5DGfJwuHPjabAUa4uZoZU8KcNqjUSmrvjDYCnp/JgsbBhIPJU?=
 =?us-ascii?Q?LdAWTOXKQoL08+neJtI6ZScNyztAM0xEDvEwotyc7GkevAs9icjPw5R7cDvf?=
 =?us-ascii?Q?wYnRMSDsVheDdANmC/7jTnwYISnysDbL9kCSqO5s3S6KS0FYw4a8rkzJYFAf?=
 =?us-ascii?Q?GWOmXuvetPB4Pw9ctLPBn0orZZbR4I2dTfttBOj+ZbuahwC/IDdUl0klHhbi?=
 =?us-ascii?Q?qUXkARfl1P1cqEzyQTF31Y1BoVD5Ligjk71EgRW58GfFn5tECRex0zuCDzOW?=
 =?us-ascii?Q?pxnWfcpFpQqqg93sMSbdq7ybY2Nvg//ffj9SgQjvSMgnc0EPcr/MieVoq35N?=
 =?us-ascii?Q?+vAv688sUhhiU+RV9Oq4/Tkp3dlqpPITmeYMJRr+nViReba7mJLjXR0+tFiA?=
 =?us-ascii?Q?++G/aibfS582Zcb3v0ocsQOlDXsBABLSGsIoq0FgAClU6mL1QcesW02TOsbi?=
 =?us-ascii?Q?fKMULDf80nHOfx+fTbu5l0vUgALvkKttLN0lWZ9JJMFhXW6FRq9ZfolkS1Bh?=
 =?us-ascii?Q?axseGzSdcj9MBivHrxbkmDRQbECHctJYjEfREM6Gr4mOsFVmhScVtM6HofkB?=
 =?us-ascii?Q?IBsGG7E08omiaLsvurpCa+s4cCGZLOmxwSSX05hBgTWqI/lRmdqoJm6NHh4w?=
 =?us-ascii?Q?a1RpR4utX7KmXDGd2nkWFm/FGxsvLVIwqE5Y2QeTEnC0qjoZW1kQZHGLfWnH?=
 =?us-ascii?Q?2y0qezZT6Wn/+mRYQ7BYSw8Ar7++3fPqKdJDe1n56h+W964aZo1guesrvGWx?=
 =?us-ascii?Q?OmsSg/B6cJ5Pg5+C6DVQr6Wzbt14STHtvBHh2LVdix92mNlVxADN9dudRkH1?=
 =?us-ascii?Q?HVeCYuzjTzEIb5M5gDgAZW69ptSLhiOOgJRwaIqcySJz1he82TnkV31V9N1c?=
 =?us-ascii?Q?wETK+DLO2bb2xEzh8YBxjxJYp5J7H3x2LWJO3cZ2r4ShcGmPg/SxPu6Z7BhH?=
 =?us-ascii?Q?brbYgt04UgW6TzVEKNimsErg5gRpxXFBTG8f36J/p4Ci325ba9M7O+PVBYg9?=
 =?us-ascii?Q?RJ4WvxGHQ+l44zVS6IycXBuH3uV+8hDoHdknskvuXJPW/nJ0+n1DGwjCaglu?=
 =?us-ascii?Q?nM/LerbybBl4EmvVralh0v0KQW+R7mOp+9uD2XD39mEv59KC8Y7OIi8neBez?=
 =?us-ascii?Q?xitRYJ0t7IzvSpkBOp4p3nEZrUa3LSwrkVbwvBNTLqTp9SWaJzvSBHvVYSZJ?=
 =?us-ascii?Q?SkntCwRF+UfGttkhAAVGndXtBA3SdnNrdnoKOKFZ+UBn/QrTP3TpPAZRrMTC?=
 =?us-ascii?Q?rpM7iuRcw3Tezo1XQyyNWay5CjgP0Lj5Sw3Q2MpsLi2MGix865vOBCFR/dX+?=
 =?us-ascii?Q?Ts4I3VWBQXkoRz2Ad4jSTnxEYrKXBHQVBDuFqHfL931oBKXKaghIwdPC4zth?=
 =?us-ascii?Q?FUd97fB47IW/Fonvz2FxPx5kqoXL4MY/ZV1MGGy0vL2BhW7XyIlSkzkHQcmw?=
 =?us-ascii?Q?qXixlmUkgiIfCYNKsnPZEh3NWe+Gix+HW68jvU0q?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c3b19f0-213e-455c-7384-08ddcb10a2ee
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jul 2025 00:17:26.9609
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DDzHYRvOqT6op9lpuTAaiQb7sAWhcee80Fglds3NWjNK9IuKbncwecH/uDGvHemKPx3OtCf7wOtqnXei0zAuT3zsfNFszmU+tOMhpssG0+c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR11MB8747

> On Thu, Jul 24, 2025 at 02:28:56AM +0000, Tristram.Ha@microchip.com wrote=
:
> > > On Wed, Jul 23, 2025 at 02:25:27AM +0000, Tristram.Ha@microchip.com w=
rote:
> > > > > On Sun, Jul 20, 2025 at 11:17:03AM +0100, Simon Horman wrote:
> > > > > > On Fri, Jul 18, 2025 at 06:21:03PM -0700, Tristram.Ha@microchip=
.com
> wrote:
> > > > > > > From: Tristram Ha <tristram.ha@microchip.com>
> > > > > > >
> > > > > > > KSZ8463 does not use same set of registers as KSZ8863 so it i=
s necessary
> > > > > > > to change some registers when using KSZ8463.
> > > > > > >
> > > > > > > Signed-off-by: Tristram Ha <tristram.ha@microchip.com>
> > > > > > > ---
> > > > > > > v3
> > > > > > > - Replace cpu_to_be16() with swab16() to avoid compiler warni=
ng
> > > > > >
> > > > > > ...
> > > > > >
> > > > > > > diff --git a/drivers/net/dsa/microchip/ksz_common.c
> > > > > b/drivers/net/dsa/microchip/ksz_common.c
> > > > > >
> > > > > > ...
> > > > > >
> > > > > > > @@ -2980,10 +2981,15 @@ static int ksz_setup(struct dsa_switc=
h *ds)
> > > > > > >     }
> > > > > > >
> > > > > > >     /* set broadcast storm protection 10% rate */
> > > > > > > -   regmap_update_bits(ksz_regmap_16(dev), regs[S_BROADCAST_C=
TRL],
> > > > > > > -                      BROADCAST_STORM_RATE,
> > > > > > > -                      (BROADCAST_STORM_VALUE *
> > > > > > > -                      BROADCAST_STORM_PROT_RATE) / 100);
> > > > > > > +   storm_mask =3D BROADCAST_STORM_RATE;
> > > > > > > +   storm_rate =3D (BROADCAST_STORM_VALUE *
> > > > > BROADCAST_STORM_PROT_RATE) / 100;
> > > > > > > +   if (ksz_is_ksz8463(dev)) {
> > > > > > > +           storm_mask =3D swab16(storm_mask);
> > > > > > > +           storm_rate =3D swab16(storm_rate);
> > > > > > > +   }
> > > > > > > +   regmap_update_bits(ksz_regmap_16(dev),
> > > > > > > +                      reg16(dev, regs[S_BROADCAST_CTRL]),
> > > > > > > +                      storm_mask, storm_rate);
> > > > > >
> > > > > > Hi Tristram,
> > > > > >
> > > > > > I am confused by the use of swab16() here.
> > > > > >
> > > > > > Let us say that we are running on a little endian host (likely)=
.
> > > > > > Then the effect of this is to pass big endian values to regmap_=
update_bits().
> > > > > >
> > > > > > But if we are running on a big endian host, the opposite will b=
e true:
> > > > > > little endian values will be passed to regmap_update_bits().
> > > > > >
> > > > > >
> > > > > > Looking at KSZ_REGMAP_ENTRY() I see:
> > > > > >
> > > > > > #define KSZ_REGMAP_ENTRY(width, swp, regbits, regpad, regalign)=
         \
> > > > > >         {                                                      =
         \
> > > > > >               ...
> > > > > >                 .reg_format_endian =3D REGMAP_ENDIAN_BIG,      =
           \
> > > > > >                 .val_format_endian =3D REGMAP_ENDIAN_BIG       =
           \
> > > > > >         }
> > > > >
> > > > > Update; I now see this in another patch of the series:
> > > > >
> > > > > +#define KSZ8463_REGMAP_ENTRY(width, swp, regbits, regpad, regali=
gn)    \
> > > > > +       {                                                        =
       \
> > > > >                 ...
> > > > > +               .reg_format_endian =3D REGMAP_ENDIAN_BIG,        =
         \
> > > > > +               .val_format_endian =3D REGMAP_ENDIAN_LITTLE      =
         \
> > > > > +       }
> > > > >
> > > > > Which I understand to mean that the hardware is expecting little =
endian
> > > > > values. But still, my concerns raised in my previous email of thi=
s
> > > > > thread remain.
> > > > >
> > > > > And I have a question: does this chip use little endian register =
values
> > > > > whereas other chips used big endian register values?
> > > > >
> > > > > >
> > > > > > Which based on a skimming the regmap code implies to me that
> > > > > > regmap_update_bits() should be passed host byte order values
> > > > > > which regmap will convert to big endian when writing out
> > > > > > these values.
> > > > > >
> > > > > > It is unclear to me why changing the byte order of storm_mask
> > > > > > and storm_rate is needed here. But it does seem clear that
> > > > > > it will lead to inconsistent results on big endian and little
> > > > > > endian hosts.
> > > >
> > > > The broadcast storm value 0x7ff is stored in registers 6 and 7 in K=
SZ8863
> > > > where register 6 holds the 0x7 part while register 7 holds the 0xff=
 part.
> > > > In KSZ8463 register 6 is defined as 16-bit where the 0x7 part is he=
ld in
> > > > lower byte and the 0xff part is held in higher byte.  It is necessa=
ry to
> > > > swap the bytes when the value is passed to the 16-bit write functio=
n.
> > >
> > > Perhaps naively, I would have expected
> > >
> > >         .val_format_endian =3D REGMAP_ENDIAN_LITTLE
> > >
> > > to handle writing the 16-bit value 0x7ff such that 0x7 is in
> > > the lower byte, while 0xff is in the upper byte. Is that not the case=
?
> > >
> > > If not, do you get the desired result by removing the swab16() calls
> > > and using
> > >
> > >         .val_format_endian =3D REGMAP_ENDIAN_BIG
> > >
> > > But perhaps I misunderstand how .val_format_endian works.
> > >
> > > >
> > > > All other KSZ switches use 8-bit access with automatic address incr=
ease
> > > > so a write to register 0 with value 0x12345678 means 0=3D0x12, 1=3D=
0x34,
> > > > 2=3D0x56, and 3=3D0x78.
> >
> > It is not about big-endian or little-endian.  It is just the presentati=
on
> > of this register is different between KSZ8863 and KSZ8463.  KSZ8863 use=
s
> > big-endian for register value as the access is 8-bit and the address is
> > automatically increased by 1.  Writing a value 0x03ff to register 6 mea=
ns
> > 6=3D0x03 and 7=3D0xff.  The actual SPI transfer commands are "02 06 03 =
ff."
> > KSZ8463 uses little-endian for register value as the access is fixed at
> > 8-bit, 16-bit, or 32-bit.  Writing 0x03ff results in the actual SPI
> > transfer commands "80 70 ff 03" where the correct commands are
> > "80 70 03 ff."
>=20
> The difference between expressing a 16-bit value as "ff 03" and "03 ff"
> sounds a lot like endianness to me.
>=20
> "ff 03" is the little endian representation of 0x3ff.
> "03 ff" is the big endian representation of 0x3ff.
>=20
> I am very confused as to why you say "KSZ8463 uses little-endian for
> register value". And then go on to say that the correct transfer command =
is
> "02 06 03 ff", where the value in that command is "03 ff." That looks lik=
e
> a big endian value to me.
>=20
>=20
> In my reading of your code, it takes a host byte order value, and swappin=
g
> it's byte order. It is then passing it to an API that expects a host byte
> order value. I think it would be much better to avoid doing that. This is
> my main point.
>=20
> Let us consider the (likely) case that the host is little endian.  The
> value (and mask) are byte swapped, becoming big endian.  Thisbig endian
> value (and mask) is passed to regmap_update_bits().
>=20
> Now let us assume that, because REGMAP_ENDIAN_LITTLE is used,
> they then pass through something like cpu_to_le16().
> That's a noop on a little endian system. So the value remains big endian.
>=20
> Next, let us consider a big endian host.
> The value (and mask) are byte swapped, becoming little endian.
> This little endian value (and mask) is passed to regmap_update_bits().
>=20
> Then, let us assume that, because REGMAP_ENDIAN_LITTLE is used,
> they then pass through something like cpu_to_le16().
> This is a byte-swap on big endian hosts.
> So the value (and mask) become big endian.
>=20
> The result turns out to be the same for little endian and big endian host=
s,
> which is nice. But now let us assume that instead of passing byte-swapped
> values to APIs that expect host byte order values, we instead pass host
> byte order values and use REGMAP_ENDIAN_BIG.
>=20
> In this case the host byte order values are passed to regmap_update_bits(=
).
> Then, as per our earlier assumptions, because REGMAP_ENDIAN_BIG is used,
> the value (and mask) pass through cpu_to_be16 or similar. After which the=
y
> are big endian. The same result as above. But without passing byte-swappe=
d
> values to APIs that expect host byte order values.
>=20
> Is my understanding of the effect of REGMAP_ENDIAN_LITTLE and
> REGMAP_ENDIAN_BIG incorrect? Is some other part of my reasoning faulty?
>=20
>=20
> I feel that we are talking past each other.
> Let's try to find a common understanding.

It is really about the register definition of this specific register.
In KSZ8863 when presenting in 16-bit the value is 0x07ff, but in KSZ8463
it is 0xff07.  It is the fault of the hardware to define such value.

Note that in the new patch KSZ8463 SPI driver implements its own access
functions, so native mode is used instead and there is no automatic
swapping depending on the big-endian or little-endian format.  Still this
code is needed to program the register correctly.


