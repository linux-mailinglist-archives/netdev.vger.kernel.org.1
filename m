Return-Path: <netdev+bounces-225896-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67F78B98EF5
	for <lists+netdev@lfdr.de>; Wed, 24 Sep 2025 10:40:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DB0627A8C3D
	for <lists+netdev@lfdr.de>; Wed, 24 Sep 2025 08:38:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6E452882DE;
	Wed, 24 Sep 2025 08:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="ckwqclxa"
X-Original-To: netdev@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013066.outbound.protection.outlook.com [40.107.159.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C20A28A1F3;
	Wed, 24 Sep 2025 08:39:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758703194; cv=fail; b=jSyuf1IpDzYTHYhD+UdIRmWjlWCyb4dEC7X+KXa0OPLbJ7LsT6XqJPXYlRJopUTnOZD7g8Aw/Og17qBrQ6xAFTuA9Fv1PLqfQ289ZdFzMqfc4W86LkraX/mdnFv4M6DMoLxUMSP1REtCxOgmqk+xyLT7i/fcIevEIIEHOGK2DKw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758703194; c=relaxed/simple;
	bh=ui/M004we8LQ+szHMq2OZ/1wfI/IqMVtn7fAOkEYU40=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=frtx1dUrcnUF1p/IHTButPFYOzPfxefLTZJeJP4QL43fLT9gmwmJm3dqd188htVe+KW/X3dzXqrUDWasWUQNG6Fhg1Tbr68MPaRPTgxsn8VD963LGaAnCUI5spWoFQ6/Oj3gHBee0G4eQVuR84cmnm6dRQ9qHr1TLJ0lvbnbbgw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=ckwqclxa; arc=fail smtp.client-ip=40.107.159.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N5neNI08OTvooxd9CoBG6zVmdlYxmO+utPaAEISvOTgKnWY/p5T5tnyChw2u+mMMrDIcZPiJUkZ68HTT/x2AYnFVhV4hCSOsQgaHfbsZ4fYxEg9BgR7QrGQG4zJ8J9hqVL1O6A6nCRrRkqWhhDC18fmNuT7bup8Am36AZOz8/TMtIcQpVy80Uv+/SjSjQbBvJWh0sM5gi36fCHo98dOQLZMExaYe8vlrUlwxZns1t26Dfvs68mpqA4mdh6KygcSLYhxpyhs5CqeG6sEE1LXwSH1ARiQChJmp39YIHR/eVdRSIfhNFZFFcJd2X7IA04Kx1mELBrkGAv8WokKDQnLsKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ouDXIbVCq+4BtEbNIoZDP0uV7RlsVEFli145MyUH9MA=;
 b=KnEWggcVnFIecDfaKrVJLDo3oNDiVIkMwgt+GNU4nHTUnolTMXgittS99FY2yG+Glte0uHSYyO9O18QRUUME3+DLwDHk/Hq1rea8FZsAQ5sbawbCVKG2IUHXx/xowuXt9Bzmjydvg2CZlrzRdiM+SFNICKSGHcwxjV7e5279ta4wwzqHCQGQjdxbbhaxLFpUqUuVRNVwFkyXyIC1yzisTFzpl5bhW0Hwg5lJvwN7Te/bAvnM6zg5JyvOS6SRS8db/VJQZ5rElBWprnr/3rfAdM9F6P/ZnVGEkK2KvHSoV8BokPi+WuVjaVQV/m84caJEwVxtKjZeP4CvhRmTDuBxKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ouDXIbVCq+4BtEbNIoZDP0uV7RlsVEFli145MyUH9MA=;
 b=ckwqclxapjVmoUgNidHa2WFeUqHcIdkWktjJeBSCtfxdXjzXkA/ThOFbdjCvEYF+KE66ypLIWvXQFiELH4jHW9yH4eLuSqQ+qHMjevF+zc8Nr7Z74Xa7a7UVibhSigi0LgE5hX5EAFa4YDlqK2tS7+WSZQkNAlpkgLgAhnj8HoUs4jLDUGLOA6cBpk2iW8lPCZGUlXazzOYx75v66IRPtWZsfbXr21eJXUQPTRBOkrxDNdXkM7IdYZhkcyoZllKvYkshmfdCMs9UCJU/gq/oGjDQyudq0AqvNDN+3IG1PtZG1E+Csbohs5Hrr/hOMizHu4Ncry32mK+3YMf+RI3Sfw==
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by VI0PR04MB11844.eurprd04.prod.outlook.com (2603:10a6:800:2eb::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.9; Wed, 24 Sep
 2025 08:39:47 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%4]) with mapi id 15.20.9160.008; Wed, 24 Sep 2025
 08:39:47 +0000
From: Wei Fang <wei.fang@nxp.com>
To: Jianpeng Chang <jianpeng.chang.cn@windriver.com>
CC: "imx@lists.linux.dev" <imx@lists.linux.dev>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Claudiu Manoil <claudiu.manoil@nxp.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>, Clark Wang
	<xiaoning.wang@nxp.com>, "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
	"davem@davemloft.net" <davem@davemloft.net>, "edumazet@google.com"
	<edumazet@google.com>, "kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>, Alexandru Marginean
	<alexandru.marginean@nxp.com>
Subject: RE: [PATCH] net: enetc: fix the deadlock of enetc_mdio_lock
Thread-Topic: [PATCH] net: enetc: fix the deadlock of enetc_mdio_lock
Thread-Index: AQHcLRa4p93zS5zz2UC/+ImNSDj9z7Sh+w1Q
Date: Wed, 24 Sep 2025 08:39:47 +0000
Message-ID:
 <PAXPR04MB851022A10BB676DBCEBF66BC881CA@PAXPR04MB8510.eurprd04.prod.outlook.com>
References: <20250924054704.2795474-1-jianpeng.chang.cn@windriver.com>
In-Reply-To: <20250924054704.2795474-1-jianpeng.chang.cn@windriver.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8510:EE_|VI0PR04MB11844:EE_
x-ms-office365-filtering-correlation-id: 6cef7815-1c35-4e31-a10e-08ddfb45eb6c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|19092799006|1800799024|38070700021;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?/+/+u1EU4W1JJAX+xhW8e59f8lCzoZmrg4fSYlR0wBpN5jON8UbBQ2qhsjcI?=
 =?us-ascii?Q?rRf3cCz13K1UGxPRrZt8SWHSQzoXHZo7S93DqQAEejb/3c7qwwbxpe60Qpm5?=
 =?us-ascii?Q?KDZzUyors8O9BR3UzbCH9R+7flPj3UvPbaxDqKdm0XYyKbWc2D1ORMj+HCIZ?=
 =?us-ascii?Q?3bgkLZ1ccVcx5OdlYsrPAhP3FcHyJn4wRAXMNUijS9Z2g6DweKJCjUnecP16?=
 =?us-ascii?Q?DvOb7BiNA95YGnR7PormYGmtfI2fDrwKHapNOE0Ycp3YR2MHQ7gBJ8fMamnx?=
 =?us-ascii?Q?XZRXnuVubYick4O+CINR9m8ysOTFAoLgZGIlts7zg6+UFBzaxJrpj756JxfI?=
 =?us-ascii?Q?vH7YcnnMr970HNpNWKxnddLm5S2DDZF9BPFuv9u1t11UJfc3owGnwFGd+gpM?=
 =?us-ascii?Q?N+N8jp1ckbtS+NXrdvHQlZnVvhj38zAfo/r6N/qtj1tPA0gtPV15+0wKAtdN?=
 =?us-ascii?Q?eCQG+y5jT9Bynw1EQxws8Ij/pHyUiQrGk2uR5CIpCc+lZEk8iesgFTGwJBn7?=
 =?us-ascii?Q?kWYxXoXJTVcLLw9PrxVMkFLu2b/qxYxf3PBgDz7C48+bxyVbQn6e3BSbCk2R?=
 =?us-ascii?Q?Jy8QgPP//delEUgNrpHKI1igeWDrZCsH8vox5APthh4NRN+d4p35E9iGtB+6?=
 =?us-ascii?Q?ydrnmnCBUbgm7Y7TCnyvfE8acdVtaDXkwh4QW3QV1pvpchePDUv4AsqeRPmT?=
 =?us-ascii?Q?oRFXmQHDG7jK22sKQTTUR8ZaXQJB2slEVNnajTJjhP1XWPfS4gDQWXHj54zZ?=
 =?us-ascii?Q?XeI87NpZo0IKO62dLpBeorrlAlSgal9WPMjKrLiVisAvAR4JBEgCeoEM56W1?=
 =?us-ascii?Q?HKAsdob7Ig+/yLrLNV0JMB4Ue1GKHS9gueM4mSdfny3G7L9zC0ONl9vsL6rL?=
 =?us-ascii?Q?lNygUD7TDHMrhpcZBlDBHLE+AfSBPfdc8c45FiUnSLFr50GkSSPzFeOpl3TE?=
 =?us-ascii?Q?K41YBX+SGfp2nnI3tUwRDy/kGM4ZIPDk0tZ+pKAO2Ry4hHcku8TDOZdUCPcu?=
 =?us-ascii?Q?IGc12AaHiCRW8f5T2xZB40DFvS0vRKMIVe7qk5fxpSvWK/Pne5nqbGQOU9ru?=
 =?us-ascii?Q?wEwTd2TQYOQ6sgSrBhdoAAGwI6EE7Y1BWXejh1ngAw+CZdHqG3jnH3b7F9rt?=
 =?us-ascii?Q?ZVjX2TPS6xi3kgxZsLFgODdsmONhnHzPZVCqxT1TBgzdsjZqKYr0P8PaX5BA?=
 =?us-ascii?Q?JNSkIwTA4DjrR+p6gk2/LQ4uLfzOzFLDcv/JaPET7dMgxJ+pAE1n/6uw6fcs?=
 =?us-ascii?Q?MUdl7N0XPvwiDlQ5KByK4Z4YmZK6jEmKuGRpjQJSqg15EL2M+b/hxE5MegBE?=
 =?us-ascii?Q?IWy9BvIIqHRkWP1N/H1vFpKXis8kKI9T2FdYXxcfp58104kyYMZeoFzpWFg3?=
 =?us-ascii?Q?B6ZtUlhPHC77udD3dCQWn9q4tyaU/9nlTfpT7OMrGtFbYWEKT+VYIncAKe1q?=
 =?us-ascii?Q?cS0KoNpjCM5knhNZjjJmTO+kpsh/D7um/Vk5CtrkpiokLpE7pV+xWA=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(19092799006)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?etkEY9IYuCnzlKds9rfDP8Pi3n/YQlPQa3mexIzpgE+qtGUcJ4JsNdfGV9XE?=
 =?us-ascii?Q?L3VRc4grbOdSUlmu8laHt3fO0PDLA0TfvL+bvwjR1ZFA9YTAib/EG+ZclqFX?=
 =?us-ascii?Q?7LDzNHqRFdsjRS/Navcu6n+0ftV/HdgAPptt1PYsu3sD5OSDR5PsYl+Iv+Td?=
 =?us-ascii?Q?WE9y9cQQdlgoNg4BvKcxW9//usOBDhjHjJt5zhH3JUP/70hgRu11ltGvdNTX?=
 =?us-ascii?Q?kz2URtN/8eFtMgPFPHHv97FFeV5IZ6cg7lONIXTVyn4fhEzpx7iKxZ+hJ5Dl?=
 =?us-ascii?Q?eu2GXyMoqxruoeYDD1wdHvljJ/HW8gbPVkKAVtmSjhrxEAp8CNAjHLifHVs+?=
 =?us-ascii?Q?Ddz6mgN3pwk5Q95456ytWNgKGWgStI7EVn9bX0TN2dTd+lX0/QRtaph9tYDx?=
 =?us-ascii?Q?9FY1n9aEFZY/OdBhcXO/KNeSbhP6IrGFqQdJEDvfc2gco2FAjpNBMqMji3g/?=
 =?us-ascii?Q?CdXSfMc/pXcteNMW6/ZOB2M8u8xReVSZAPYb/HLagTI5Sj6nBJxwvm0Rego+?=
 =?us-ascii?Q?Qs4AmagcuXas0i7yzy6fey25G90tlpJUARt/BZJDJuzD3F8NRmhzvbjvet1e?=
 =?us-ascii?Q?mqA8mRkWZq21e8Plh4MOQzKjvd+SZbVsEM7UJod/cW+lyWUs1OQk1KivFr81?=
 =?us-ascii?Q?P/ViOetw8xlV+fB1l2oZO3QUVpwC/fMI1Ib82xLt7+6TmnKo3NtBKZTn/CH9?=
 =?us-ascii?Q?0EVmWaqJXUVKtgxbo+uG1iqRZjjO3z5jiCkAcZsOpt7MIqiAnlwnj2Z/Ovu4?=
 =?us-ascii?Q?VB09hod9H5U/Ejti+IVsTB1eodowG2K6Nez9vGP2pjTaSb4MoaP0iiHRLMZc?=
 =?us-ascii?Q?y8h3YiZ1ik+nMlpPI807Ht1adHTmpBmk297ilFUAoDRICnlrklmjRwV7qPFn?=
 =?us-ascii?Q?VqQl8xRatCqlMzBcJqa8imW3sz3jtCkJIFT5jxlUqmcDwbzsKz2o8ILzaJ7v?=
 =?us-ascii?Q?Y35C9g7Iovix46J2mRqNr6ahpiMqgBDP/uam5ISjVguKm1qCyIWFDnCl6sj3?=
 =?us-ascii?Q?Ko53O2X7YF2giW6ULs9G79quYZnjYG8TMPzN6MN3kbh5307M5QNC2mrm/oqr?=
 =?us-ascii?Q?Q/SLK2TnE5ge39TF09SKBH04MZPfxV7k2DbHPz7BFslBUtBmaU/EbowXlTDY?=
 =?us-ascii?Q?dLRHAEFn85Vht3aXBwBJ7KxDf+jH7QpHJ9yXqiNww8FS9BWf9vGpOlftdmmS?=
 =?us-ascii?Q?vtLUilT6PpaYyBiI7kMeFhYhGKf8t0BBvxHIzcN2WXmZkzbVZMOoYJMBdMWF?=
 =?us-ascii?Q?R8DPgs1LlHLuO9z1bfkbF1nkbj8U8UxgdZ1wbPfH5UGdZEme1U/buQG2jUfM?=
 =?us-ascii?Q?9BJDmIBDbcwuK7w0lZbk8T0g2L5Fcm+o5SX8lM2WS1kWPO0YlgjwHooV6P6q?=
 =?us-ascii?Q?XPwqwUJPY1sy85BkrB9HkuYwVP6Fok1AFa1U9EbD5IYOrRpsZTtE5Jm2Q5QV?=
 =?us-ascii?Q?W3OgMK8Yto6E7Cp3l7G9UdtahzhpOxchh7+s+l9Vd6KmPiaRj4qDmY91aEiT?=
 =?us-ascii?Q?CWy40VdApljUamliu/lJMrQYLk/ozqI2oxSFym/ptUPUbw1UvNQ9RAOxAitC?=
 =?us-ascii?Q?YAB37C5rAdTrG78ZYT0=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 6cef7815-1c35-4e31-a10e-08ddfb45eb6c
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Sep 2025 08:39:47.7352
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: khtYUa2KxbUZk4WNzPmFGsBciXgAuDtX96TRk2DQg7aeB1q7NOwNtCOd+KdHXpPsJaA3EfrgqqBJ2W5hhDP2OA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB11844

Hi Jianpeng,

This patch should target to net tree, please add the target tree to the
subject, for example, "[PATCH net]".

> After applying the workaround for err050089, the LS1028A platform
> experiences RCU stalls on RT kernel. This issue is caused by the
> recursive acquisition of the read lock enetc_mdio_lock. Here list some
> of the call stacks identified under the enetc_poll path that may lead to
> a deadlock:
>=20
> enetc_poll
>   -> enetc_lock_mdio
>   -> enetc_clean_rx_ring OR napi_complete_done
>      -> napi_gro_receive
>         -> enetc_start_xmit
>            -> enetc_lock_mdio
>            -> enetc_map_tx_buffs
>            -> enetc_unlock_mdio
>   -> enetc_unlock_mdio
>=20
> After enetc_poll acquires the read lock, a higher-priority writer attempt=
s
> to acquire the lock, causing preemption. The writer detects that a
> read lock is already held and is scheduled out. However, readers under
> enetc_poll cannot acquire the read lock again because a writer is already
> waiting, leading to a thread hang.
>=20
> Currently, the deadlock is avoided by adjusting enetc_lock_mdio to preven=
t
> recursive lock acquisition.
>=20
> Fixes: fd5736bf9f23 ("enetc: Workaround for MDIO register access issue")

Thanks for catching this issue, we also found the similar issue on i.MX95, =
but
i.MX95 does not have the hardware issue, so we removed the lock for i.MX95,
see 86831a3f4cd4 ("net: enetc: remove ERR050089 workaround for i.MX95").
We also supposed that the LS1028A should have the same issue, but we did
not reproduce it on LS1028A and did not debug the issue further.

Claudiu previously suspected that this issue was introduced by 6d36ecdbc441
("net: enetc: take the MDIO lock only once per NAPI poll cycle"). Your patc=
h
is basically the same as the one after reverting it. Therefore, the blamed
commit may be the commit 6d36ecdbc441 not the commit fd5736bf9f23,
please help check it.

> Signed-off-by: Jianpeng Chang <jianpeng.chang.cn@windriver.com>
> ---
>  drivers/net/ethernet/freescale/enetc/enetc.c | 13 ++++++++++++-
>  1 file changed, 12 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/net/ethernet/freescale/enetc/enetc.c
> b/drivers/net/ethernet/freescale/enetc/enetc.c
> index e4287725832e..164d2e9ec68c 100644
> --- a/drivers/net/ethernet/freescale/enetc/enetc.c
> +++ b/drivers/net/ethernet/freescale/enetc/enetc.c
> @@ -1558,6 +1558,8 @@ static int enetc_clean_rx_ring(struct enetc_bdr
> *rx_ring,
>         /* next descriptor to process */
>         i =3D rx_ring->next_to_clean;
>=20
> +       enetc_lock_mdio();
> +
>         while (likely(rx_frm_cnt < work_limit)) {
>                 union enetc_rx_bd *rxbd;
>                 struct sk_buff *skb;
> @@ -1593,7 +1595,9 @@ static int enetc_clean_rx_ring(struct enetc_bdr
> *rx_ring,
>                 rx_byte_cnt +=3D skb->len + ETH_HLEN;
>                 rx_frm_cnt++;
>=20
> +               enetc_unlock_mdio();
>                 napi_gro_receive(napi, skb);
> +               enetc_lock_mdio();
>         }
>=20
>         rx_ring->next_to_clean =3D i;
> @@ -1601,6 +1605,7 @@ static int enetc_clean_rx_ring(struct enetc_bdr
> *rx_ring,
>         rx_ring->stats.packets +=3D rx_frm_cnt;
>         rx_ring->stats.bytes +=3D rx_byte_cnt;
>=20
> +       enetc_unlock_mdio();

Nit: please add a blank line before "return".

>         return rx_frm_cnt;
>  }
>=20
> @@ -1910,6 +1915,8 @@ static int enetc_clean_rx_ring_xdp(struct enetc_bdr
> *rx_ring,
>         /* next descriptor to process */
>         i =3D rx_ring->next_to_clean;
>=20
> +       enetc_lock_mdio();
> +
>         while (likely(rx_frm_cnt < work_limit)) {
>                 union enetc_rx_bd *rxbd, *orig_rxbd;
>                 struct xdp_buff xdp_buff;
> @@ -1973,7 +1980,9 @@ static int enetc_clean_rx_ring_xdp(struct enetc_bdr
> *rx_ring,
>                          */
>                         enetc_bulk_flip_buff(rx_ring, orig_i, i);
>=20
> +                       enetc_unlock_mdio();
>                         napi_gro_receive(napi, skb);
> +                       enetc_lock_mdio();
>                         break;
>                 case XDP_TX:
>                         tx_ring =3D priv->xdp_tx_ring[rx_ring->index];
> @@ -2038,6 +2047,7 @@ static int enetc_clean_rx_ring_xdp(struct enetc_bdr
> *rx_ring,
>                 enetc_refill_rx_ring(rx_ring, enetc_bd_unused(rx_ring) -
>                                      rx_ring->xdp.xdp_tx_in_flight);
>=20
> +       enetc_unlock_mdio();

Nit: same as above.

>         return rx_frm_cnt;
>  }



