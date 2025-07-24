Return-Path: <netdev+bounces-209714-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CDB57B10838
	for <lists+netdev@lfdr.de>; Thu, 24 Jul 2025 12:55:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DBDA05A5428
	for <lists+netdev@lfdr.de>; Thu, 24 Jul 2025 10:55:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A61426B2A5;
	Thu, 24 Jul 2025 10:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="QzwmZoZL"
X-Original-To: netdev@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011005.outbound.protection.outlook.com [52.101.70.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1209326AA93;
	Thu, 24 Jul 2025 10:54:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753354501; cv=fail; b=l2/UY8wszid7Qhy6iW+EpeCUI5MBpiNeLQHPx7or8nhkVCYFJq7Hm7IzYPloWeg5OkyOpT117zS7ycwuCdhYGkfilTyMvk6dvPOLTP/0hqfptdQ/jj+wHrM6HaAslWArfNDM6y08yLYnDDEt/rRq1zNyf2bN23er/26vAvE0Crs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753354501; c=relaxed/simple;
	bh=Q4DTZwJaf0KWwkpI/KIZ+k02pnIhAWbe573hSfBx+m8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=IYlzJ7oXGJTgWayewuU0AVz8193HcX3o9lNDd7HWeP0WGjN1Qrhn7pBWx9UIE0Ub+dO3JC/2iK6rpRqKjCdLL30r6VH2AUlB056G/uzjCcN3RO5xbS2xN9SAz+y7VdF8SpvDmmdXAPc1k0TGAPXS7/+3CXH2wWDztXEMoRVT8JY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=QzwmZoZL; arc=fail smtp.client-ip=52.101.70.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Dj4xAwLfV5u/ikIbYm8EvrOLUBNPHTv6bMd/j0Y/Dr+eWGfV+7muz6MB5yjtOQjspoivULawAzWIBi4NEPxLwmQdjAQu0ow0PE9p+k9NHCavjCU4vbfqatCx+zNSSTPqk+mrRESr6HvCKCffJZ/XyZgo19O43/uHs0Vu5Wif6w/94wyHQKnN1W9+XJW+qMlL2jR2TP6TmhmhMkpIv/sa4CcNTgRhY85cBqejvY6NX0owUxFLy7JWaAf9KUBnSI9dZKt7fh/ExNrflgFOHl9fjDdA92r3Hdz2Wq91zAlLWbHE7eqqgMEcKTAGFQk9S4INheIfTfEtdTH7sfNYj3BLiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M2mwPNRTirp7Dn8BAXf+bXZZBS0PLyvWBJuY7ZcAstA=;
 b=C1AQ6EZTSa1QMFvArQa9FDcv8Dn4L8P+5TCEd+8YobcrDBOYVwKFzc/SytTwzo09H/UU4fIGNK9Fac1CQEWzO/agZu2L31+5ZYXosZ15ew+k5QnT8wHHOWpSm2hjymlsM0wpML3F8TWoPnhYGFxFRTSjKNn2eiKucNhcEvfaP7tax8HFE/V9LipjGoTacrTSADfu1INFW9bJQSdTEUgalCOd7ELdss4GLNxMknVSlrS46UgURaq60hOYEGSszCr5hGChfFK2eQ6m9FdODw9AUBQj19dHfTj24faco3aUkLUaSCRIENl2CUwfwb1V+qk6AtGHSzVCu9epDnvYh6c6AQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M2mwPNRTirp7Dn8BAXf+bXZZBS0PLyvWBJuY7ZcAstA=;
 b=QzwmZoZL7zAQHEVFCMA4VSBr2KmoDAx/5Ce75inYuXccXeJCqU6jvhA6hyzJ6FJU5Xzcs9NTiRY3sdEQuZ5g5/lPFy+gjtERG2X9cZpTJdL4QG6nmmnDT05J69h7PQSvNpRq3iBQMiqr18Gxg/66Iztc9kKo6nb0pWT77IMzDwfHnhuZwd3fEGXQZm33Vla50ZIfNWLYb5F7ctIaXN2uYVf/9CpSG+Yy1/RqDQXTTAVGTxxOrxb3J9laT45U3beSHh3batz0Cnh/dGdGd5BMdBZbue93THH2RPOp5QNdpqUKXjIcZCfoipMUJ48BFAkdM391NpOVNRwQGiRamUQZbA==
Received: from DB9PR04MB9259.eurprd04.prod.outlook.com (2603:10a6:10:371::5)
 by AM8PR04MB7249.eurprd04.prod.outlook.com (2603:10a6:20b:1d0::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.22; Thu, 24 Jul
 2025 10:54:52 +0000
Received: from DB9PR04MB9259.eurprd04.prod.outlook.com
 ([fe80::dd45:32bc:a31f:33a4]) by DB9PR04MB9259.eurprd04.prod.outlook.com
 ([fe80::dd45:32bc:a31f:33a4%5]) with mapi id 15.20.8964.021; Thu, 24 Jul 2025
 10:54:52 +0000
From: Xiaoliang Yang <xiaoliang.yang_1@nxp.com>
To: Lukasz Majewski <lukma@denx.de>
CC: "davem@davemloft.net" <davem@davemloft.net>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "kuba@kernel.org" <kuba@kernel.org>,
	"n.zhandarovich@fintech.ru" <n.zhandarovich@fintech.ru>,
	"edumazet@google.com" <edumazet@google.com>, "pabeni@redhat.com"
	<pabeni@redhat.com>, "horms@kernel.org" <horms@kernel.org>,
	"m-karicheri2@ti.com" <m-karicheri2@ti.com>, Vladimir Oltean
	<vladimir.oltean@nxp.com>
Subject: RE: [EXT] Re: [RFC PATCH net-next] net: hsr: create an API to get hsr
 port type
Thread-Topic: [EXT] Re: [RFC PATCH net-next] net: hsr: create an API to get
 hsr port type
Thread-Index: AQHb+73A58Wzw4lvh0O6GXqWtDJIerQ/n0yAgAFywgA=
Date: Thu, 24 Jul 2025 10:54:51 +0000
Message-ID:
 <DB9PR04MB92591B3DA0F1CB9CBDE83C24F05EA@DB9PR04MB9259.eurprd04.prod.outlook.com>
References: <20250723104754.29926-1-xiaoliang.yang_1@nxp.com>
 <20250723141451.314b9b77@wsk>
In-Reply-To: <20250723141451.314b9b77@wsk>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB9PR04MB9259:EE_|AM8PR04MB7249:EE_
x-ms-office365-filtering-correlation-id: 32df4d04-2dca-4a73-79b8-08ddcaa0845b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|7416014|19092799006|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?5nQ4XbdScEJdAoV3DKQMMyFksMOOgPoyoL2uLmqqLnHxw9IoWDhSagQPYI7i?=
 =?us-ascii?Q?EBMRLhq6fLTUBXvSJO6Lsu7c/2xE/dz1fQUCyjj9tD5X3aak1pWnoK1V7cmW?=
 =?us-ascii?Q?wppv+1glHdV6WABJBbcwpJVF68+pfWu8mP9EB9jQTO7o0tuWIkLlGTsCRPtS?=
 =?us-ascii?Q?Ff25B5KmVUdK1eEKy2NF4H/Yr0EqwCYfiSR/idO/sL/eyJnONVK56v44JfO5?=
 =?us-ascii?Q?vaXg8vDudXj0OsfPT9NZfP859iCuC+v4Rxc98H3+LnE2PkVaY/Z5ZnsSn/Cj?=
 =?us-ascii?Q?+WdGE8S6A59T1IJFPolNZV+CYfGnOcdYuR9b8Q6eIlsnZXVzE0Lf8n4zXsLF?=
 =?us-ascii?Q?n2ewHBJXTkafGRy6f9Qg0nC377xMhpA7ciaoInbDOddueRb3Xsu9G7WruXj6?=
 =?us-ascii?Q?7M7x1mibfp8v4JjGtv3R+6zEryQbWDKhi039153ItDJ92LgPJ98gCnipp9p+?=
 =?us-ascii?Q?lFzRpxF0L1wHgAivU9s0VBAqDNDWHlXcCqhw/d1gvJ2EfBcaZbvu0CuguN5G?=
 =?us-ascii?Q?v4Je0VWC8hI9Ou/hlNZ2vhcLrAgyeyhwTLztqxVBa1d/Jl8nP7gJXG4MBjN1?=
 =?us-ascii?Q?E0KoIRSBUoQDSAFUjzHU75C74OQdU5NlqywLLg4mP09IKw62ntXe/UvfXDas?=
 =?us-ascii?Q?kffE5sbZRTpt/XeX97TS6nkHqwFYx1n0SIzdW5mG4v7hViFloohhE8/SbDlN?=
 =?us-ascii?Q?CM8ZJdS9jyfrvsVwfo2kLKkddTdUs2ngA+gTqA4WAzhpGcmMn1X9SEGrN2yU?=
 =?us-ascii?Q?FxnA08PKZFPJU7IKChUcRIla4gAOxiqPcXQIfOVQRzPGKdMjk4HNYnpg1hHK?=
 =?us-ascii?Q?zFEEMRzk91CuOHG7pG1RYajnApDoMh683G1yI5enQ6k9iyzY1plEm3g2TYyu?=
 =?us-ascii?Q?vucK8jNhqlGmqMIMDdXlU67QdqZo88yCOactEstCQMX39uM9OdISSmIfZWMc?=
 =?us-ascii?Q?qBEgV05DPgtPKFvaEwT2VeljOf96brRc1i0PJekijGxxVOyW8D++vYZsl83r?=
 =?us-ascii?Q?dIiONSjfSPCWoAfvzyN2UugzEQ6KRGbm6a0AxUK5/40W5z7SBJTxEy2ARYsZ?=
 =?us-ascii?Q?Qg9UBTHLfyPvPoAbKAKcMhW/gUGPYhh3VQkNdxI9yB9elHQdFNUov2RxMucp?=
 =?us-ascii?Q?A7TDoRZFK9Y/d8LcnRvyEhfz+WkzWIitVNK8d0cd6wSKWgjFrrI/ce71Xb9V?=
 =?us-ascii?Q?d4QE823owQQG/V++gMhRnV0FaJNNlN15q+3sjzAxEbJlJEAhqh5zFBVm8zpa?=
 =?us-ascii?Q?q709OtrKlKdtiToJBwV67/bynaBadzdvyWh4tAFfOo1KgenCZxU5/Gek0LHM?=
 =?us-ascii?Q?lKsCMIbUPRLyZu6XGqg/Pz06E3VH6eUrp3LfWBDU83Kb4NGGBuEBrlRi0eJI?=
 =?us-ascii?Q?4rQT96yYRtVYEJz39/j2ugQOeLLCWrjFh7ysg9YSUsobe/0HXUNyelkUrJkL?=
 =?us-ascii?Q?Z34a2cYAd/M=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB9259.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(19092799006)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?jvlHfUKy4RpdBQDtDy0GLXAfufXM1sM2k3lkmWLryseyb8e6hCCfyYT2gVQx?=
 =?us-ascii?Q?dNk5YsKwSfCP96y7mHbTVrbZpRcMi8/q0oQ1EFF8n9Y8XtQEMbPNLgWlLtU8?=
 =?us-ascii?Q?YnbLnt0MC/Gf0WTwznCnpBYVNpcpoJ3LDL6h5ThpBZqDf9pJEUhH16t02kpB?=
 =?us-ascii?Q?HCjkXPQs+NFxwoTopjAmT6VFaapUV4KHVDwkQDXCTaZRplY2ShB8qtQi5Yph?=
 =?us-ascii?Q?CWg/N/FfjH599C+eaZ39mH5rJdNTyBjrkDq9lu0O+umoYKkI19X7sp2GmrL7?=
 =?us-ascii?Q?SB4fpUXviurTIuosufcaXyIG1zUprST/a9VRbyTf0KQwhRRTEJ2EBupONnzq?=
 =?us-ascii?Q?RMlbIJuWNd9ox0AE8nlHXwqZGk5grfzwUqibxnsv3UzOf2zjnJJ3O/V6x1YU?=
 =?us-ascii?Q?A8+PHqAhBLSr0SAR3sUK8d9Yiym3zidd8JETAe7G/+m0am63Z3T5vtZjbnAc?=
 =?us-ascii?Q?xWDFMJ/ZlF64lxt3It/5TU5DpecJotOCLObCas3bLjgRfPU4DYFisYSkMJtc?=
 =?us-ascii?Q?8h2C0czuuTr38kIogyEyiCIMz2pgea04W4U6vAKbs9hhpsJuULvz56iQ0mi+?=
 =?us-ascii?Q?HtppDoMCIpihV9LraQRP6SbBRiNC2c9g614ZFG62RgEs8bQE/SRdDBBmF3aL?=
 =?us-ascii?Q?nVsLzaLV5fn8KH+itTEY28Di9xdxqM9bMWoy8w89xJC8x21+QYYYoTIIXBp/?=
 =?us-ascii?Q?yK/3cOYr3RsX/xlN2GE0yrAb/nqLumTGEdC+K2aDVBO1Xw0qby2rm9I2yrFb?=
 =?us-ascii?Q?UPpEQxzPezKxV898k0yhXulljMDiIZsyIy//Wr8A3OwndMEA1eb/yeist8YF?=
 =?us-ascii?Q?v+srcBBIdvsu3dYKDv888yxbQoKu2TiZW/UFlAZxxbe+U4ZrZR/Dx6aDOVix?=
 =?us-ascii?Q?yQJr+wDpyRI6MlSrSn3J6y5rgnLmkg6nwTfwAEV0dhdoDjhV7b3hDJ2UI1tz?=
 =?us-ascii?Q?rsf5Xnc/vhq6V6W1QzokFTlkkfefZAkGnldbVGi4b6+PATPkGMktFMtKNw5c?=
 =?us-ascii?Q?wb5KDGWi+FYdSd2mMUeAZ/AuRVue1tX9L6YK0eG5cHknxmIBycjOd2PIzTgT?=
 =?us-ascii?Q?cImhsepxDf6aSEekr2UIo+iNZt9ymPyqlvnr9rXrXrCQGFbpAZyf1imWIYWl?=
 =?us-ascii?Q?3i5Nhp9lIBAWAZdRHYWS+003srxrcF49gBT6vEwn0XgCsBZoL0h7LUXDzId4?=
 =?us-ascii?Q?d1EMPcjwVALQrtX/LU7tBqynq/oopMcqajAnIMMJJbCOqhrcWxVXUJXLHy3s?=
 =?us-ascii?Q?bsrUKFpf+d+J0GgNIa66+JK5xzamkxhaoyXFUIJH7o+XE8eZEIApziG9vfdv?=
 =?us-ascii?Q?9KwQXOyA4XXvqyI2IPdoiWtyncaQaxFTtScbW2lB2DVWQxIZIH3MN6Ytgh3r?=
 =?us-ascii?Q?kYQNwDQcHBBHD8I+cPhGJYTtFnzqYAXCDfO8j3PMpoby4q0Sa8nHdPoaVBDA?=
 =?us-ascii?Q?j81ntWNv+Pe03ZBr1tGB2dOw3rER40blvoUqOUj8IPWEbm+yCcYQSJV11elX?=
 =?us-ascii?Q?udpY0qzzwfF/jLACW2StM/mj3oLlJG/hf/GVY5B2rfouXQcez2FAkwY3Jay6?=
 =?us-ascii?Q?vZ4rBPKoIp8gT6pqB5s6rLBoRBBme/U1yqtPoSCX?=
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
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB9259.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 32df4d04-2dca-4a73-79b8-08ddcaa0845b
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jul 2025 10:54:52.0379
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: //6yAehxVYaL0ZSLVnImbyMGdGab2u9k7mmIRmHPjhC3/NTngaKBSEQ7CMeqaZNdl7/fxw0vw9qSf3h8PsSgzNuipXEZg4+MKNBBrhcw/zk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7249

Hi Lukasz,

>=20
> Hi Xiaoliang,
>=20
> > If a switch device has HSR hardware ability and HSR configuration
> > offload to hardware. The device driver needs to get the HSR port type
> > when joining the port to HSR. Different port types require different
> > settings for the hardware, like HSR_PT_SLAVE_A, HSR_PT_SLAVE_B, and
> > HSR_PT_INTERLINK. Create the API hsr_get_port_type() and export it.
> >
>=20
> Could you describe the use case in more detail - as pointed out by Vladim=
ir?
>=20
> In my use case - when I use the KSZ9477 switch I just provide correct arg=
uments
> for the iproute2 configuration:
>=20
> # Configuration - RedBox (EVB-KSZ9477):
> if link set lan1 down;ip link set lan2 down ip link add name hsr0 type hs=
r slave1
> lan1 slave2 lan2 supervision 45
> 	 version 1
> ip link add name hsr1 type hsr slave1 lan4 slave2 lan5 interlink lan3
> 	supervision 45 version 1
> ip link set lan4 up;ip link set lan5 up
> ip link set lan3 up
> ip addr add 192.168.0.11/24 dev hsr1
> ip link set hsr1 up
>=20
> # Configuration - DAN-H (EVB-KSZ9477):
> ip link set lan1 down;ip link set lan2 down ip link add name hsr0 type hs=
r slave1
> lan1 slave2 lan2 supervision 45
> 	version 1
> ip link add name hsr1 type hsr slave1 lan4 slave2 lan5 supervision 45
> 	version 1
> ip link set lan4 up;ip link set lan5 up
> ip addr add 192.168.0.12/24 dev hsr1
> ip link set hsr1 up
>=20
> More info (also regarding HSR testing with QEMU) can be found from:
> https://lpc.events/event/18/contributions/1969/attachments/1456/3092/lpc-
> 2024-HSR-v1.0-e26d140f6845e94afea.pdf
>=20
>=20
> As fair as I remember - the Node Table can be read from debugfs.
>=20
> However, such approach has been regarded as obsolete - by the community.
>=20
> In the future development plans there was the idea to use netlink (or ipr=
oute
> separate program) to get the data now available in debugfs and extend it =
to also
> print REDBOX node info (not only DANH).
>=20
I need to offload the NETIF_F_HW_HSR_TAG_INS and NETIF_F_HW_HSR_TAG_RM
to hardware. The hardware needs to know which ports are slave ports, which =
is
interlink port.

Hardware remove HSR tag on interlink port if it is egress port, keep the HS=
R tag=20
on HSR slave ports. The frames from ring network are removed HSR tag and=20
forwarded to interlink port in hardware, not received in HSR stack.

Thanks,
Xiaoliang

