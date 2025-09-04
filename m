Return-Path: <netdev+bounces-219782-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B7B9B42F46
	for <lists+netdev@lfdr.de>; Thu,  4 Sep 2025 03:55:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C69E63BE78B
	for <lists+netdev@lfdr.de>; Thu,  4 Sep 2025 01:55:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DA341DF247;
	Thu,  4 Sep 2025 01:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="lNdPSrdg"
X-Original-To: netdev@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013047.outbound.protection.outlook.com [40.107.162.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 030B51CEAB2;
	Thu,  4 Sep 2025 01:55:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756950950; cv=fail; b=rmBFSpNoCxLOKybYS1wWf2hquOUHqk2qa5S2vSWodW37sDR25/Hu7qquRL7i/bWr5qs/3fCoGUpt5yuofadGQ2unV3OtoVghH/+u42TTFOBsLQslPyU5YCQu0Cxh3eJUFcQqV5aQ/hpXEZL4wN9SfNWlgdH7GaVfmcKq9GO2vUg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756950950; c=relaxed/simple;
	bh=3HAYQnTZyZrZJInGpiBgEQEo8jyELP9DFQO9P044HOU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=nct82t1xe6jx1VLO8FaedDbWURAuTB0j+K6+JPAw4V40egke3ey0ywZDmlj4n7pVKVe7Z32BGmOGtGskce0cZ9KOCywykE9VgKPx+dSSWQX0/evNfLI+ScQGtkBbsHlio7vrVKZ+vWx6kTIybyWcdwQu65A1MVanJ4ktWLdEEzU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=lNdPSrdg; arc=fail smtp.client-ip=40.107.162.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=arAT9KpvVleg0KCathKqD5/htFENemCrmWpQlYcN3yOfCRvNqrd6nDBPaGhjbmBhi9JrCYHI27fTgdYy/mMEzgw2n9u7XAbB17NvCzwNk4CglXgi5X1Pf7pk4pjgX0RgDcFnlklEDJeyK56WbGzwokfw8ieh4sm+IQRTEjao7p0K4gp10GHI7RhJYzlRJaAVfkclI0m1In0OL2VFWuXDLzDu8bipcRd7jK42mQ1I+IufMTYmwZunTglLw5xQAwq4BNnso4DAjHgEX0LaswL+pOisoIv0Vs3pGv7Z1NJNWt08EDi3akosTFoUBMo8FL6o0VWitm6kBBGa1PcoD2JH9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3HAYQnTZyZrZJInGpiBgEQEo8jyELP9DFQO9P044HOU=;
 b=wQzGWq6DPe/eJAwODZYQrgIrfNIvCrRfrJvN7lMiS1INwOZZtSyaPXWENM5c+P/jN3u88daNfhaHkKSGvu+MPWiZlZQRHnpPa2FlUk/HJGw+al9tnjffq767SB7Pfcv5PtHIklQkBAd8v0/cVBd0/Xc+PUtz78AIO5j/2tV7eWCBI2vu1NkgV+mcNaCJJ363E2O+VBef65+JVyPSClU0VKCBajmt93zT7t8b5xnPzPPXWK9KsaWOEq3mRl0odEEnkC+GiolPf0dH9/5eeMw7gp/WSFdoGjoJHEHkUcJA5hRXA2AM6PaLY4wqQJ2zo0tuBgpUd9LYwJnyB8kzypHhNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3HAYQnTZyZrZJInGpiBgEQEo8jyELP9DFQO9P044HOU=;
 b=lNdPSrdgelg9S33wWPkdtVY/GLuc5VcCIM4VzMFZwaRFYukunloe8IygmIH2UCC4KshbN+95XHpOlrx1sInkrOBgw9RB2Bi0uTurpSLseyJShcQidbeOnomk7kZC6b80o9aZhS3dTHbCB0/3t0RdgWVzoShHPqckc1cHmv/6TioJ+STEuHJid7xKpv4QkI5k9ACNs6pMmg4VMv0B6C0cmJXJXCa+9PExZUraoe2DBqtc2Q8945IZ3Ehf3TwwQV26/X8SP77Vd7Icz6Z3JUEzYKgC6BfxKZO2T8dHkvk6i0U/bHuGXEl+7NoMfZFXjoctI/qqb1Z0zOa/4SNm74HvLg==
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by PA1PR04MB11529.eurprd04.prod.outlook.com (2603:10a6:102:4e2::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.16; Thu, 4 Sep
 2025 01:55:44 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%5]) with mapi id 15.20.9094.017; Thu, 4 Sep 2025
 01:55:43 +0000
From: Wei Fang <wei.fang@nxp.com>
To: Richard Cochran <richardcochran@gmail.com>
CC: "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>, "davem@davemloft.net"
	<davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>, Clark Wang
	<xiaoning.wang@nxp.com>, Frank Li <frank.li@nxp.com>, "Y.B. Lu"
	<yangbo.lu@nxp.com>, "christophe.leroy@csgroup.eu"
	<christophe.leroy@csgroup.eu>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linuxppc-dev@lists.ozlabs.org"
	<linuxppc-dev@lists.ozlabs.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "imx@lists.linux.dev"
	<imx@lists.linux.dev>
Subject: RE: [PATCH net-next 0/3] ptp: add pulse signal loopback support for
 debugging
Thread-Topic: [PATCH net-next 0/3] ptp: add pulse signal loopback support for
 debugging
Thread-Index: AQHcHLD5iK57qqmEXUuEFtuGvb40JbSBd4YAgADLQNA=
Date: Thu, 4 Sep 2025 01:55:43 +0000
Message-ID:
 <PAXPR04MB8510785442793740E5237AFA8800A@PAXPR04MB8510.eurprd04.prod.outlook.com>
References: <20250903083749.1388583-1-wei.fang@nxp.com>
 <aLhFiqHoUnsBAVR7@hoboy.vegasvil.org>
In-Reply-To: <aLhFiqHoUnsBAVR7@hoboy.vegasvil.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8510:EE_|PA1PR04MB11529:EE_
x-ms-office365-filtering-correlation-id: 4a9bfd32-2a03-4c22-cf36-08ddeb5628a8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|19092799006|1800799024|7416014|376014|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?L9K6MPgbF9q7kBYT95X1ZPDB8xrvvtp1Wqsp71YClB3GLks0tjLxnjNYRy7y?=
 =?us-ascii?Q?a/F8NskFwegcrx2hRrmPIXEZ+3yAgY6klK4HCR9rDk3WcaQIJazl+kDxhYdj?=
 =?us-ascii?Q?SaepwnWUKgQj7F4S/uCKk4+Pxjd4LwuXf2UOhhSyTMTUcA6bDnC+vcOwRhwc?=
 =?us-ascii?Q?uE37Huzd8EindlnLpA9bHJT1RuL+jxrV7yFkX6JHB0UpQQ+ZegZIwA19bzla?=
 =?us-ascii?Q?T9se2jXeJ3U3F3Uacz2FRT6itWOHM0nWF99/g1nB5h90f0//zTHZPRQWAXFD?=
 =?us-ascii?Q?64slkYfydKnUmxSl9QBO6NPbkr7qxugLjeqEbwfgIXske6tlw7dK/qZnAeSO?=
 =?us-ascii?Q?wShS9oMgrqwciYLTUeEZSdUYwm2fRE7vlxx7Y2YY+WR/v5oHU65V1MqmdDN3?=
 =?us-ascii?Q?R4iH65KIsZAMt2bYWVp5fEV8KCJFpppmhrAOgBz4lqIu7b2hcpJhRBZZbX0D?=
 =?us-ascii?Q?le1Hs/IiG1ptuRGp8mwp0trhozfCzIwn9nbRNhorFmygdzeuotxbXCG4KglO?=
 =?us-ascii?Q?Jos5AKfzCb6a7MEdUxKfhBM3i4/2GKtqt6X1THGSaDlNbP2oZLVAR9dSawFN?=
 =?us-ascii?Q?y83b+IpdZ9MllHFEPi2H8VpP89Q8RRMy/iwdiQrTrlXJwiYtvbvEGWFPeQbl?=
 =?us-ascii?Q?gAYGD+exQYLzaqjgUVGx2HHALUT+ulv4lSiO6Z4wLmVEe4oJORH4XRDBSdGk?=
 =?us-ascii?Q?uQyC7gi3ahOFoXwbRpkASgyFSPTp5357q9QOiTl12g1GJyg5m9PR4mjQ/WBf?=
 =?us-ascii?Q?3S1BAJBda5mALUyWrFp5ox1751Pwzfse25W4osDX3GKxB3QR0jPO8j3/4IL4?=
 =?us-ascii?Q?6us43i1HwMZlSMg+NnpQCGnavtFvE5WUwy7Jf3D5pVCR54ukMpRf/Nr5px+H?=
 =?us-ascii?Q?VQSJnZ4kv6Vk9do50bEcbsN8YfxnBZGQ5nPsc2XfvycmckzE1GW6wLpNL6zW?=
 =?us-ascii?Q?/bGrdYo84WijyTlO+rjhR91EQOdlmUeWyRSXAU78oyS9SwruJwdjPBjMQEWV?=
 =?us-ascii?Q?wzqVgzIYIZwLRE99D17y0TFzap4LHYs3ZyO8WQoomtGjue9GEtZxkjFoZorr?=
 =?us-ascii?Q?o4Dd8d3CJCsvHRZBtqUzbzh+MKAObFBYlORefbiHxAs9JjzI7L2r9DZikTJS?=
 =?us-ascii?Q?J4pg1gKroar3vndbVBuu9wfOCHOtNqQbpOWxv6iLQWtl5DX8tvun1QumTkg9?=
 =?us-ascii?Q?EUcnwOnjPT6xdznAHPz/GTSEKML+333z8w0+H9jSMspqOkYGTihWfz3n4a61?=
 =?us-ascii?Q?xCKnwzJCNjr+Wf8DGQRHUJILnYIdAlUI5EX34PF+3NpEZTd24Zu1U1XeG88E?=
 =?us-ascii?Q?iI6KY20zxJZ19xRUqe7P1z0rBzLLPp0fkQIMR53pBvVcpfNteCifmBlapzN7?=
 =?us-ascii?Q?YwvzV7CpDtjPRS+w55vcrytqzAJR12Q5Hr9ReXFNsXPuariwyQwrsSv11DMH?=
 =?us-ascii?Q?iuQ7wwuYk1gm0MQdj2S6vN35RkJKzSrHA4JFGYym/VqLKmtNz24kqQ=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(1800799024)(7416014)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?JxrgnMMi11RsiDXp24Ln5IcwIO3eHXY77CCOeVAwY9qfuDF9+qTGze4ikP8R?=
 =?us-ascii?Q?wxWDDAnZDr3EuVhqG0OvOfJO0Q/UDRw5Nt4bR98GT0uc7G+aNrNfHcp653SG?=
 =?us-ascii?Q?3rrULId6H12UI69KojQcE70pYqzB9C60Xa/LfiDbYh81bo1Q6akLe7iuUDAG?=
 =?us-ascii?Q?aI73A+PPAkq/1ASPtpSRinKDnKjSYGoK0054f0cVxbzS610agZywriPdBF/A?=
 =?us-ascii?Q?bInE+gNgkAHLP3oO71CIy8vEF3PGnkc38RsoOgAO8hrxZxYupjTG5TqH84uK?=
 =?us-ascii?Q?IQd4n2pgF2AJr9jdX/8MsFMFqwaQbuf6Nso90wik8bB+X5XIE6TtQF5LayJv?=
 =?us-ascii?Q?s/E6DCwkfs0yaO+JhZWDg8fk8dl/2Oncm6KE9gW0T4bvc+hg298zf/cKaBGk?=
 =?us-ascii?Q?yX9Y25P4B8DQHfiLNUZ5cuM/XY2Ze+WDeHqlWePtg3iLtbCMwBC2lgn4np1n?=
 =?us-ascii?Q?41Ie0ezAWMeKFqZ86coH9FUJ/7hghN6QqrlmOCw6++mO2CEHri1xRy+t2C6Q?=
 =?us-ascii?Q?4P6Gww7glBawfNcT6TME267TiQLkoe0FikzKEJthT3REqNOFscBc24JvTMDU?=
 =?us-ascii?Q?4Sfe9RBt6psBAHmZZinEiSVhPbkbbEA1l1MdQ8DWoMkijNZ5DB0PWkzRN87Q?=
 =?us-ascii?Q?coAZyaG8J71bwQ7iPIHqjb+Fcj+onSucnEex3LrGBJrvNIeNhPZeL3eJs7GB?=
 =?us-ascii?Q?/qaMOI9/dvkaLOt0veOA3u+8WUgcxRBuMswS3nBOXOaA0ORBTsLf3CGkfTLx?=
 =?us-ascii?Q?mrwwb1VP8SZVaAaEFf/PTC2sM5fkt4dP++MKsnup8MX47WPlXkZGrU/NDcEf?=
 =?us-ascii?Q?VupWmPtNZmHnhMsN3l5YDt4NPLSIgtSsmNPv9bE6z7obIY6YFfYuz0jk/AcM?=
 =?us-ascii?Q?pwyAY6BXQa+3c0jmlxpxx9vJg3JtuiQ+G5Rae4VJD5yXaTl/ssYSfFUzD7/r?=
 =?us-ascii?Q?Dtt1pMCwIXdqfqvvdqHplVt3Erk5lDwGpp8i9e2O0n86JHhp0cIqesJ+HfX9?=
 =?us-ascii?Q?cNrHu/oHUI4ByP9h6TWdwwFGY+XXF4jwbp2Xmju8jHNtqs3j9e3lUzH/bJ8H?=
 =?us-ascii?Q?JNV1OFRiL7+N5ObpMww/Fdaq2dqvhFVkx/lIGGf9CABybtAwpJ9d52zKLrCC?=
 =?us-ascii?Q?Xhl9Yjyx6+MRDaXNx9hzRDG8mz40K6X7BpbH7rb8kqPKj00Pct8ZnsTt6ZQK?=
 =?us-ascii?Q?Xw1IvOwoM8SSOcWCtiOv03T24aqBi0xWg9R5Dfvg6Sk7kXKCKEBdzezPFrYM?=
 =?us-ascii?Q?+1elEOLy7jOFwYppkfpJ4S/PXEe+f7MFX4Gy5IoNfQ16puGKCgl+KHrmEzxR?=
 =?us-ascii?Q?8QzPBAMxBi80ufbHrui0k2tuqCuEIAeS0dchBVHDKZaXtcp3RQPpR+B0iqK5?=
 =?us-ascii?Q?q/PpePm4VsRzLz88fKKBrs9A/c5y6+YlJn0/i7T3RQHcOhrB/BAYHbNvSKIf?=
 =?us-ascii?Q?b3/TnnMBnzrmivv03e5BVTNG9q8vqT8xvov2H8OtWAdj/i8d5V/xOU3Q0BJh?=
 =?us-ascii?Q?2hNEHxtZLeHfmbZ1co1g1MkSilYZ3XdQedr00hBwsfi/XaLQ2QyMwrH5yRXf?=
 =?us-ascii?Q?XSC94x5wdQ22x2OuPNs=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a9bfd32-2a03-4c22-cf36-08ddeb5628a8
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Sep 2025 01:55:43.8162
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NWWytu1O/8sSzan0/X2Eui70qckoT1yntCenx7oKbM6e7Gn5ynYk5BuBD9bnfl3XVeC4dzWkpfStP6PjemFpvQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB11529

> On Wed, Sep 03, 2025 at 04:37:46PM +0800, Wei Fang wrote:
> > Some PTP devices support looping back the periodic pulse signal for
> > debugging,
>=20
> What kinds of debugs can be resolved by this loopback feature?
>=20
> It seems pointless to me...


Vladimir helped explain its purpose in the thread, do you still think
it is pointless? If so, then I can only add a custom debugfs interface
to the ptp_netc driver, at least this will be a better debugging feature
for the NETC Timer. :)


