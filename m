Return-Path: <netdev+bounces-160696-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B6560A1AE3D
	for <lists+netdev@lfdr.de>; Fri, 24 Jan 2025 02:40:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2C8F01882A63
	for <lists+netdev@lfdr.de>; Fri, 24 Jan 2025 01:39:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DB5D1CEADA;
	Fri, 24 Jan 2025 01:39:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="jyg6gGl5"
X-Original-To: netdev@vger.kernel.org
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2054.outbound.protection.outlook.com [40.107.249.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ABE3282F5;
	Fri, 24 Jan 2025 01:39:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.249.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737682791; cv=fail; b=EyUdi809oIJbHY/xti25tACd1eu7HNjs4ZccFVhN49c0BU+K/rHrK5ujB4sMcK0rspqEr1a/5o7xiBKrmHL3JyF/MU2/kbjRXnORP0/jRnVD0Ia9fz4VoQ0PsAKAZBUHmWSH4EIPwNNuAjXMfKSloFKIG0VDIPQPGU+2Lpf+JfA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737682791; c=relaxed/simple;
	bh=69UmwL4RyzFWzEWryvyPyyUZbCBiBimCu6sxD2qmflU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=hAVgWg/AWGFB1xjiuDsIMkG18THSe+cQCwa+YB6MjzShGXyzvbpNWdhNeKA2DoE3dPkjkPLvY4gLmOu0Ry+jyod0l4xSNQ4mqMw4Ai8zrMRiIFsqv6yZEEn0azbD67u8gSuR+A7iivNESBFyQkvj92C8Y3Da321swKXUXKN1vK0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=jyg6gGl5; arc=fail smtp.client-ip=40.107.249.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YKyiyLyvgyi3WpZ2gd/009gXlh3l7WmW4DByxFBI7C2vYcB2/x1pGKe9TitmBDN9pkNRe6d/RRNlr70Kz3+Ozjv8WhViRHouF0HMU5ow+Y2emD3/2WFVU/YHwjg+VDJD4R6LbFI8Pg13Y/TSUTqlvvO+up0xXA02GEds8lx+j3qTSwyiJxQ3ZEjT7yz3mkjfcR406qIVtzT+ERHdKLhAFgOrSkNt1VTUYSf+goQOGjCdZRGxYlwGY+ObSOGrgzpvfxTiR5M7xAd4lul6+P09Xw1Au2tKWaB4yHhEUEygca7jujrqYNz3z5sptbfp2En+b96sSw65wx/pvrimAE/0CA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PIWwMxbnfZdhOHrmWLQ8+uNEhXJO5UXZqRp4scCKuU0=;
 b=SHaxJTXz0aqxmtqtc+pT7cO2IYPTcYoHeRu2/YR1aOfiEre32p9DYgyyeKgiCZAd/qOsax3DM8OL/ioailGEjdvKS9yDkmpOiwSR9xvakWH53iDmlu6jnWEXxWwz0jdf4oqiI9evoWFm2Kr5nRXQsUeRGyjOwev1mjSUabisREY6EfqNPNEZBS7vO8D2EtRUrCRruAw+rdL/IyLIdIzJWorQaNQ+7d+uOPtT8JBD/XlfDuWMJy0N0/dix8FVqzicqmYqSYtXhVVYjgwEUqmGfT6OHmcUQIW5SkYXXb93BQ3WGZ1gkRYsgWp4rj/0GHHQlKtIm/XM6zNQqYJRY02Yng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PIWwMxbnfZdhOHrmWLQ8+uNEhXJO5UXZqRp4scCKuU0=;
 b=jyg6gGl5nfpqk6yqTxoXx5gctxTyuD9bJh1JW67CpoDZPUb4w4HM3ssfJsGQxLDFEtxqUMLDNQnqFL0OencPAnCBabBdE34JFGVpeTQ3Evtp0RWgAEKF4v6u/UtgXU4djZgTEmnoCB1KYUbGiHd+MFc9j5reOAfheLAjzM2GyVaG/dgoaqUJ8zb+fnpkHfvOlCS4Hlr9X5563RGUtZ45J0reEhZlup3hC/ELyp0/k7Ve1dAsZitoC4dtaDBNggoYjV/iuNub0p6RXXN2/MC6eEIJ1JBSuUhJf/xzDBMs4qh5ZGu1aIPcEqop51psElaiOCdnTN4iAIn3BHpaY1MBAQ==
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by AS5PR04MB9854.eurprd04.prod.outlook.com (2603:10a6:20b:673::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.18; Fri, 24 Jan
 2025 01:39:47 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%6]) with mapi id 15.20.8356.020; Fri, 24 Jan 2025
 01:39:46 +0000
From: Wei Fang <wei.fang@nxp.com>
To: Dheeraj Reddy Jonnalagadda <dheeraj.linuxdev@gmail.com>
CC: Shenwei Wang <shenwei.wang@nxp.com>, Clark Wang <xiaoning.wang@nxp.com>,
	"andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>, "davem@davemloft.net"
	<davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Simon Horman <horms@kernel.org>
Subject: RE: [PATCH net] net: fec: remove unnecessary DMA mapping of TSO
 header
Thread-Topic: [PATCH net] net: fec: remove unnecessary DMA mapping of TSO
 header
Thread-Index: AQHbbLqLupyHdAm0+EG/wIJk3lnmObMjn2OAgACL04CAAPgZQA==
Date: Fri, 24 Jan 2025 01:39:46 +0000
Message-ID:
 <PAXPR04MB8510FA96CB9A5DE5288902A088E32@PAXPR04MB8510.eurprd04.prod.outlook.com>
References: <20250122104307.138659-1-dheeraj.linuxdev@gmail.com>
 <PAXPR04MB85106CE97288D52A04EB685388E02@PAXPR04MB8510.eurprd04.prod.outlook.com>
 <Z5IbIeOxrkMoASdJ@HOME-PC>
In-Reply-To: <Z5IbIeOxrkMoASdJ@HOME-PC>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8510:EE_|AS5PR04MB9854:EE_
x-ms-office365-filtering-correlation-id: 028c3e71-ac84-42c2-6127-08dd3c17fc26
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|366016|7416014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?y/hrxx8Zvlo2vHqEJCTE4Yu9BesDcz+PSV58YTv1UEeMpbFdrInDn1VtIFjc?=
 =?us-ascii?Q?qlDQjnt+sbKo0gPnjMMIaigLd1/lfhtgJKgsZLCFIvs5CETB31rY4QYC+b8s?=
 =?us-ascii?Q?ED3RR6GlK00sXhqXhqTSuNOPFEvEQnoiRPh3Q5sd5FEEyErcjfWjgHRcInC3?=
 =?us-ascii?Q?s0SYDU2/p9cahZENzJFSS8I/D+YOOCSFioEzssFghpAIJqO6HCD3Ymt9T8uk?=
 =?us-ascii?Q?H7o7O1gvPXd3HQ756+Zki1ju0ZZcqrLiPyn4Y5wCWTbgjaHWCb/8KnSDsBb4?=
 =?us-ascii?Q?AQolNnZGi4GL9NT7J39IV7tMuP3PRjpftlgXDc3B+YUG9zNUekRFWFURj5AU?=
 =?us-ascii?Q?MInGy1ZNTQQf0mhqWeSuklRbonjqgB8LptEEOsalGd/7Yi702ZmE92ObmRNQ?=
 =?us-ascii?Q?ZB+s5xZf7l8+sFVnimffcAlZ9hXY46yIV/5HZKfj4y8dhXKUjqPkZHTlfDLc?=
 =?us-ascii?Q?FeItnRXhe0X7X9tmmknjw4FVtNZm5twEM8WAlI9nZY/j93zMEBs7ZZi++YUM?=
 =?us-ascii?Q?5EYZlemDsvKsFFhn1QWtBwFlTqagARXtzBCF+Y/GEZb0VOf7xPqzZy27qLi9?=
 =?us-ascii?Q?C2EPIfO09niPgtQM8iPiXMYZ5GoStfohUp9fcgs3mQDgguPoTcnpN0dj9xnl?=
 =?us-ascii?Q?qZEMQp4mm5IJxkNmzgPTyxVSWWFtMFf0/3yLLqJZPQm2WYUkkTa2LZUgZeHs?=
 =?us-ascii?Q?/uUIwjcXcLLIizCeIcCooCtq5YQa12AbA4LRixRZIgPl/1mQza+rd2iteGyn?=
 =?us-ascii?Q?pYBMrU6HnT+98mLqjknLIxBeCxhG1WVLh3IIQXhLpysB7a2cqsXlJv+PCh87?=
 =?us-ascii?Q?9vQj5zs0sTMXjKBnuZOwGiTZofeY1KqiWDCcClzeJ1lybYDSwBr99l675M+B?=
 =?us-ascii?Q?2jUboyzqFEhYut0wajGAy/6BqyV+BFHu6xPALXxb4peR6bXH2pbjTCDGldv6?=
 =?us-ascii?Q?DtyE7llBmaKaQjhGCWy3Mz+rQbhvTsBN2Gs12Gbi4wXfEamVrNFmriFpl5Ob?=
 =?us-ascii?Q?P9Ez+Uqx+3NZohXYw1X7psUrDJR8u5TlaGDR+7gNH+F+zjZygryW8zBRPMGa?=
 =?us-ascii?Q?dHbMZL0oeU9i8ByTXUOJ4quBGd96qPy4bA1meJsZXvIQmTnveVUlML5t7EHx?=
 =?us-ascii?Q?tJ15L0nL/+az6KyMhfWLnle9RCbwBP3z68zWzK7syvC9OrcxEv4wW00L/6Wq?=
 =?us-ascii?Q?tcfGG3R98OJ9GftxLJxq/QsPesCR/19RycsyaS3NV8+awpZ89Mft1M1IGHpe?=
 =?us-ascii?Q?MQ6bam66AJbREqtiFCz0tTu233r5qiJBXEz+Oa/KKDA5cBESm+odfNymd3VU?=
 =?us-ascii?Q?M9n53M9BUajDpUzCV7QiS0tI67+24lb3nSlneQuiaQBrcwLGtf09ohOcH4Ur?=
 =?us-ascii?Q?HUXMTp4D22ko65p5Nuljbslb/Y57XJbII1GrEgFqEPgTwEuj76esWDAvjRPJ?=
 =?us-ascii?Q?RD2OcUh7MUO6zFkPSsM1Y+9+Mz/pGbP/?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(7416014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?eFZxog32wHqFq6AkeraJb7P+T7WETj9x42pEEmr6mGQQ12KfPOau0yRB6SE8?=
 =?us-ascii?Q?WX29pAl456cLoaINCAeXyDh98qEmnZUPWkRJEByDGmlcMlVGC+gkGKm+NaOR?=
 =?us-ascii?Q?Zq2hcRPb/eYV90BiNhu+3FU2dv5QtvmosCzMxi2JjeV24lNN5C9WDyDJGSpy?=
 =?us-ascii?Q?Zsir2rRgtSSTNUE6ziv+jUS4hMQ9KVYynbF+EPMeRINg/fB9VfzsZxEW7Lkf?=
 =?us-ascii?Q?ZOekIRlxosE0E4suPkcdALaPn2RJC38rDM9DUFmkqtA0BtOUjJ9c8UCcUGTz?=
 =?us-ascii?Q?bcOLf/NxF/b5RBxLAbEVo7CFeDhzTFUMxDjB6kkySnfy1MHMOf3kNvp1samQ?=
 =?us-ascii?Q?vRpkBHH1iZDzpqcJSptDE0s8kw0iQC3GEbeT3BlvsH3mdI8nITgAkXkZ6ufZ?=
 =?us-ascii?Q?PxlYqQVn9PfoMR8WMI8tSXp5LPxlSSq9LZCv0OqPfMy5elrz4P9dULULYrY+?=
 =?us-ascii?Q?TkihHpvHCJY8fMfrX8ml1jKC1DVzn/Pn/BtECcvycexJ0RM2nBWqBwVy7J0k?=
 =?us-ascii?Q?GVnli008x0aJXZ9zNB2vS+RQ9Z+FzO19BZN8WZpatMvpe+PylfJduYx6khhP?=
 =?us-ascii?Q?mpytRb8mVR4CuYn+pKe/I1mCmdozPrsVl4krD5F8yRKH25a/hquSaLRrR93K?=
 =?us-ascii?Q?zjT9cmulBz+kGdXXB7k96G9gnRUrZbvhqQCFT0iQ+VpJYSQfkJ3vdtp9zfSf?=
 =?us-ascii?Q?0nFXF3+NlmkC3ipzuVS7CeJMbBLNl+pv1dK2zg9T4aDpO2lc4CX+jANFzC+G?=
 =?us-ascii?Q?CK/N0b9aazz/VNFHHINr1VyGdU7dmIPlnqfbyM3RA7jwTdexVgDNPrXv0+H+?=
 =?us-ascii?Q?sJwNJIxXNxc+KCWKL8U7sSgCLpwAddTQ4s02XxCooNn0GQM1kwuQu2zIFVGE?=
 =?us-ascii?Q?z7994Oo8IMG7NcbYCaOQPNQ1BWmKzdTmS2gktQCUCV+u6htwVwLqkToHOeL+?=
 =?us-ascii?Q?0zbnmSSMk2I3Iz/geZBYj2EqmNjGuoyg8MXKlTclZuoPCygGYOyl+CaPtCiu?=
 =?us-ascii?Q?n2fMQ8rbh+bd2JF0U3XM4HAMPq5qe+3QPAg5TbTBn11RBkdCi0i1hj4Kh6li?=
 =?us-ascii?Q?sqzHYPWMXg+uK4v4M+SaJ/Kh195VlWAtFPhwzO2hfDMM8YYz1dZEj2Ludvxl?=
 =?us-ascii?Q?eDypC+DF0E0N0Vs7XJ6J9Ugb8ZVu2sgTHMr/dSVZEUSqeKCDAVqoh+E1leBd?=
 =?us-ascii?Q?6OtmvUSEoSd6BprfSL5J6p/eJXxJ7wChB7bDh/mBDxJgyIXr0mMaxanmLrON?=
 =?us-ascii?Q?riiKhpV213a4a7uaOTW99uPNWNfXSicnobDJ/nfsrGPmoM8kpJMXR2CKfkDV?=
 =?us-ascii?Q?fRtEmvEvbK1d1RXytXPuJ5loGnEb4ZK1k2fALFxKhGW1EuL2ZvhH0oEwjP5p?=
 =?us-ascii?Q?Xd9cL4LQYFUQXsnYoYSm6JCzA+7qSIBjaw9dZL6mBLeahBCIkyMQppZnNmt9?=
 =?us-ascii?Q?5KtyYtUCgJ1exnUhRwhpHi3kO4AVSvHGs+0OjjPL+jCM2Y0oNxsbHLBYP4je?=
 =?us-ascii?Q?ELUCXQ33Tzym5qAhRt+8tBW9i1gDFUAZ2cpNuuQKHnrWYkQaoL6wjpYlkSb5?=
 =?us-ascii?Q?02YkpxpAnFiUOsv7wcY=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 028c3e71-ac84-42c2-6127-08dd3c17fc26
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jan 2025 01:39:46.8363
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NanT2oKKYCZnf6osiwbCxXlHOCKgcr6xYxDWEvBes4vl5mGtAIv4v1yvSg5fVfzMv3NdymUDJsI8CBLIWIha1Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS5PR04MB9854

> > Hi Dheeraj,
> >
> > I must admit that I misread it too. There is another case in the TSO
> > header where txq->tx_bounce may be used in some cases. I think
> > the most correct fix is to make txq->tso_hdrs aligned to 32/64 bytes
> > when allocating tso_hdrs, then we do not need to use txq->tx_bounce
> > in fec_enet_txq_put_hdr_tso(), because (bufaddr) & fep->tx_align)
> > will not be true. This way we can safely remove dma_map_single()
> > from fec_enet_txq_put_hdr_tso().
>=20
> Hi Fang, Simon,
>=20
> Thank you for the feedback. I have a clarification question regarding
> the alignment of txq->tso_hdrs.
>=20
> In the current code, txq->tso_hdrs is allocated using fec_dma_alloc(),
> which internally calls dma_alloc_coherent(). As I understand it,
> dma_alloc_coherent() guarantees that the allocated buffer is properly ali=
gned.
>=20
> Given this, should we remove the alignment check
> ((unsigned long)bufaddr) & fep->tx_align and the associated dma_map_singl=
e()
> logic entirely from fec_enet_txq_put_hdr_tso() as you have suggested?
>=20

The maximum of fep->tx_align is 0xf, so we need to ensure the buffer
allocated by dma_alloc_coherent() is at least 16-byte aligned, but I'm
not sure whether dma_alloc_coherent() guarantees this alignment.
A safe approach is to apply for a memory block longer than expected,
for example, if we want the alignment is 32-byte, we can apply for a
memory block that is 32 bytes longer than the expected length. Then
use ALGIN and PTR_ALIGN to get the aligned addr.

txq->tso_hdrs_base =3D fec_dma_alloc(&fep->pdev->dev,
					     	  txq->bd.ring_size * TSO_HEADER_SIZE + 32,
					     	  &txq->tso_hdrs_dma_base, GFP_KERNEL);
txq->tso_hdrs =3D PTR_ALIGN(txq->tso_hdrs_base, 32);
txq->tso_hdrs_dma =3D ALIGN(txq->tso_hdrs_dma_base, 32);

This is just my personal experience, if you have a better way that would
be great.

