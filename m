Return-Path: <netdev+bounces-136388-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 794519A1941
	for <lists+netdev@lfdr.de>; Thu, 17 Oct 2024 05:20:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A7935B252AB
	for <lists+netdev@lfdr.de>; Thu, 17 Oct 2024 03:20:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01D7813A88A;
	Thu, 17 Oct 2024 03:19:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="S6yy6ZHU"
X-Original-To: netdev@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2068.outbound.protection.outlook.com [40.107.22.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D3751CF8B;
	Thu, 17 Oct 2024 03:19:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729135188; cv=fail; b=LXKl2SCIWkN2t4NBsNyX9qXW080syOugvoVfkgdlG2v9QG4ZyPetbykmLZyw2jJZ+rnxkRZnz45/mAGnvgGt1Kyb1a8abshWaqAtpuUQ96HlYA3/yVaaxkhl0vCZVbDcjo0Lnvnwf5EmNsA2rzXFIp15NXQobUnRUeG0Ao3a5u0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729135188; c=relaxed/simple;
	bh=Wq3Yl08MNLiWmTIBwJ2xFQfYERtHOawR8mYgGcp1VZ8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=V1QSEbusKdL0yHKibkEqu34s3NeXpmrZxKMnKMiWIfFP3nk399R7MUeUC2SnZk5/A+tR2yoF9YIipLxgATExoZ0K9tIEDTMol0T0NeaLnz1fSQNsg1zkEEAy7OIRmgAk1xWbsMMC5rvut3nMIoU4KZ2yTMAmb99xFsiSeCrcmDA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=S6yy6ZHU; arc=fail smtp.client-ip=40.107.22.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KDN1ewro7bSeMNVQ+8PXyTb4mDYSUkapqittGeKdf9fgQhwRqQs98vuylFTMfU0HEItZfs8nb6fq/L+Uz8uk40w6BdnRr8BlLj0x1EG5rbYhvXHb+T2O5qO6N0glD0CXVzVooYKtdm0N29aVJaEiHVebj9lC/3F2ODq8SP5XYCKbopn/lEHQhWakQJdY+kFWK3+wElff0Sd4VNcuSI+s0UkHmvssiEH7fgy0YbUZIu4rc36wgxi+DhiyvAWjZDQP03zSA5Df8hXXqi8eeicVPVsu/dvQsxDmgOGIijjU7pTWpKaC7zwAcMUNn/SQ9faX1ISv3H2oslqbbs+U1oTZww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Wq3Yl08MNLiWmTIBwJ2xFQfYERtHOawR8mYgGcp1VZ8=;
 b=EpGxhAha6DEMXcD2QbZCqhEX6HezyQGRseE+2NtBphDLtLWGaBVjihqEXkkVmUwyNpKsIZvvElgs399QvJ7xFsQS6y8LjUu1zqhleetdApRi25iLbQ80O4o2+fl5VtC2cGKQU+l9Dmq5F5IA4X7iTeN4n2CdUMxEQ83xnRY/iSVOoQAT9v2ekRGqSmu1zyhIeKQd9ZTbz7xWzPuSuBaXDwWOBIym+8+SotlRFndbC6n/+7yE6WYSqv0nAtIeTowGvLxgcOXDWz6J2OX1Xw6mq0KQfCGNp/a5Tspg/mbKFYYAu44rxYpHO0AIw2XXW5+ARAvNlZINrUv4jYdvZUXU9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wq3Yl08MNLiWmTIBwJ2xFQfYERtHOawR8mYgGcp1VZ8=;
 b=S6yy6ZHUMpqp+KulhXlMYcNiGTrMkgdDsh6bvvZD9PBli+AcBtfFhfsAon2CErDZwMkDuK9szWDtzSLh1DWj4UZtHiRALW2kjIqb/uiIuaDks1a8yZD7GJvekAS1T1UkpvPK4FQo+WaUcRlsUqWtMgFI58VeIUKwvVJItCaPAWx4xbaRS4Avql0R/r/4pwnbHeqH/Mzw1eqSA47gqmDdDI9V8BpBfupiNPq5cQkwAfvmHvxugtGJDnYpCavZAwTKsxhf0HYSH6/t12Gs7hfDEj//slNg9OwiuVbItdWHke76lUmhL4CWzk2LRBjTzg/qNn8MIo4Dqm/u5zZm+bDzmA==
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by DB9PR04MB9329.eurprd04.prod.outlook.com (2603:10a6:10:36f::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.18; Thu, 17 Oct
 2024 03:19:42 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%7]) with mapi id 15.20.8048.020; Thu, 17 Oct 2024
 03:19:42 +0000
From: Wei Fang <wei.fang@nxp.com>
To: Marc Kleine-Budde <mkl@pengutronix.de>, Shenwei Wang
	<shenwei.wang@nxp.com>, Clark Wang <xiaoning.wang@nxp.com>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Richard Cochran
	<richardcochran@gmail.com>
CC: "imx@lists.linux.dev" <imx@lists.linux.dev>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "kernel@pengutronix.de"
	<kernel@pengutronix.de>
Subject: RE: [PATCH net-next 11/13] net: fec: fec_enet_rx_queue(): reduce
 scope of data
Thread-Topic: [PATCH net-next 11/13] net: fec: fec_enet_rx_queue(): reduce
 scope of data
Thread-Index: AQHbIBW0TvJIGXaZq0aRwSNc4YPKcLKKRpPA
Date: Thu, 17 Oct 2024 03:19:42 +0000
Message-ID:
 <PAXPR04MB8510AA11AD9BDD5CD94FCC8D88472@PAXPR04MB8510.eurprd04.prod.outlook.com>
References: <20241016-fec-cleanups-v1-0-de783bd15e6a@pengutronix.de>
 <20241016-fec-cleanups-v1-11-de783bd15e6a@pengutronix.de>
In-Reply-To: <20241016-fec-cleanups-v1-11-de783bd15e6a@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8510:EE_|DB9PR04MB9329:EE_
x-ms-office365-filtering-correlation-id: 5677ae70-2353-47ce-f27f-08dcee5a8ae4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?anZIL2Y3YnplR2tMbEcyOVdnRGVLNXJCNWhZQkwrdE5KeVhGcmxQRStlcGFz?=
 =?utf-8?B?dWd1MGUyNEJ5Y1JyS1MwdzZnZkVHNVVNa1BnZGlLVlBVOWhubXJEWk1oeDl0?=
 =?utf-8?B?NFFpRTIrc2dXeGNUQlhKdTZDSlhaaW9VbSswQWE5TTY2R1ROZXZyazJGNGZ2?=
 =?utf-8?B?cldMcE9xK0tzUEM3a01hTHY3c01MZ2hWek16Q3cyWGZvM09pWGc4Wi9obkNr?=
 =?utf-8?B?bnhyWmRBd0VIYU4ycFpSQ3hKRHZzZEM3WFc1YnEvb1JXQW1RUTV0ZmhZalNK?=
 =?utf-8?B?M0tocmZUbkRpRFJ2WVRWWlFwaFZrYkllK0ZKbGgzbm1wU0FGN0wyeHhaR2dm?=
 =?utf-8?B?bUlhNjM4K3dmMjRqVG5wU0NzYUZ1TVI3WHljT1JxRjJDMEpTNlpiZERwdG5C?=
 =?utf-8?B?eDVzZExYd0piL1B6QW5ycEJDeEhoNXcvVTBrbHBZcTNQb25iSWV1VmZaZlpp?=
 =?utf-8?B?emU2MjRULzZhZ1Job0RXdkNlbWFUTmIrUDA1OEorK0hiN2FDTythbU1KUHJa?=
 =?utf-8?B?YXJkbWtHMUFGcCtNQjJmMlJodk4yWlQxa1MwblllUURNeTdqTEFIamw1VWtu?=
 =?utf-8?B?SG1LOW5PL2hHV3JDSkdUcndvT0VlMkt3ckExbEhxbW0rUHo2d2xtUXJsTG1R?=
 =?utf-8?B?UlIwY040RkpWQVJwTzZiMjY4cXVPZE1uOStad2tTTWNPeEw1NDZGUmtaYjlN?=
 =?utf-8?B?UlZXZ0hBZHVYQTZGWUhSSnZJY0RKQUJQQ3AwL3NzR1hJdDVGa0hNRy9OOGU0?=
 =?utf-8?B?QmJ1SjU0RTFocHFnQnpsb1lkUEdrNStNMFFnZDBNMEgvV0F4R2ZHQy9XemFu?=
 =?utf-8?B?enBKOHJoaXpHbGY3ZytNSGpuQmdqT3BhOEN4SzV6eDR3MDhDMFV5aWJQcTdq?=
 =?utf-8?B?cHlzUEQxM3VBR3BrZ0RNbUc2MkFpS2JwRHlTdENBWGo1a2F6UUl2ZkxpOG04?=
 =?utf-8?B?eStVVEJSTGp3R241QmVGYVpDOTRCUms2QWFjN25IVld6bGhVdTNPaGF1NERH?=
 =?utf-8?B?MWVqZndQZ2lySWc3WVZGdC9sczJzQkRQSlZpbS9YZzR5dWZIVEc4Tk5TcCs5?=
 =?utf-8?B?Nm95YnVsa3h1WC82cEFFT1JJUjBYaEpieEkyVjNOMHRkOVhTMGVaMERrMGR3?=
 =?utf-8?B?VkhXZkJnajFTS29jM09QVzdtTVRrYWdCcWxnMCsvNzV1REJnZVRIeVFCTEZn?=
 =?utf-8?B?MDdEYW9aeFN5M2xzRy9qRmxTSWRrNGxmcjZpNnY5UkFPK3YxbUVhblFDazU5?=
 =?utf-8?B?WE1ZQnp3UnZwY0FkOFVBRVhIU0xNNi9SYXY3Uy9INE9YRFhBTEJyTFdQOEVL?=
 =?utf-8?B?QXpTamRIWi9zWE91cnVoMnRCWmM1eEV4SVYxeVpWZzNwSmNtblRkQ3pLNkdN?=
 =?utf-8?B?Y05sYmFCMkczdStBaHYyRjhjU0lSRWFnQWNmb05aV2FoK0pSSjJPKzdZM2Vz?=
 =?utf-8?B?dU13Vm1WNXc5eW1VRnVYQmp2MDdpMDkvWWxQNEdBNUcwMkRiN3BIM2MvdUFH?=
 =?utf-8?B?YVRvNDBSeFRZUzkvRnhVcS93V0l1RTg0UXBLZjAraVdKcEFYUVlmMFpYK2ZV?=
 =?utf-8?B?S3BmTC9OYWZhSHhXazZWUW1OL1pxOTdVbzdXeU9GMHBka3JnSUUvWkdzdkJ1?=
 =?utf-8?B?SmtBdFNNOXJtZHRZZVlSektuY2k5NzVXNmpYZkwzZWdqZnYwNFYyd0hENTZu?=
 =?utf-8?B?NVlsRGNtSTYvREM1SUlUYmFNMDJ5a3lYV29tNTlmTUx6YVF0RGxkS3pKL0s0?=
 =?utf-8?B?cGRvbmRkejRJOUF0OTJqbFh4T041WUZ5UVl6OEo2UUNzekNRN3FpTVpESjdL?=
 =?utf-8?Q?SUOk7dyCI2vTIG6pY4N2YpFE05zAy2Ekntcjw=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?bEZad1VEaGNHc2tPYm9iczdsWC9YMW5na3U1S0llQ29IRkZRS2FUb05UYUwx?=
 =?utf-8?B?L3BtVCsrVjE2TDhqUVBjV0xsUTZKT1FHSlNxN0liRElpOWY5UGtpdXc5dzNs?=
 =?utf-8?B?cEU2ZGNYQUl4dkh4d2hvczRZWGVDakJzS1g2ZU1kV1kyY2lFM2Y4eWNEcmN5?=
 =?utf-8?B?cHI5N0t5ZU90TDFzVmlKTnh1Vk4yeFN3RlFqUmYvQlYzaTR6Tlp3UWZMRWRC?=
 =?utf-8?B?dFdlSzdMLzViWldvUndEWnphaVdCdUhwYVFEdDBycW94dDlHbkJzcmw0MjFX?=
 =?utf-8?B?YW9sTFM1MU92clArUkxWaWRYZDY3U21PcngzR2NaSE5rU0xYR1I3UTZsbEZV?=
 =?utf-8?B?dGRnRTdHdkVGa1Nvdzh1L1NTRmdrSkdVblZnZzQwMTRqWW1DYTNVUUZwMmRG?=
 =?utf-8?B?dWJiM0pkZGExZ01YOEhzZnJBZE5iQlJRekMrOFBJRUFUUG5OZ25QY0JkNnhG?=
 =?utf-8?B?Q2Z0L1VINEpjTFZnYTI4ZjBrNWRiVjlVU3ZtUGlYUUYvMEMrSUVhYzN0Qjdm?=
 =?utf-8?B?dS9YeVdlKzlYVloyN09hSHJnMjU0VWsyZVlRSTB3RUlGQWNpYmdJU0x0MHUy?=
 =?utf-8?B?RVFFSzBpYmxsM1BqOWNSVVFFbmJMWGZtc2w2UENyMUpMbkQzdStZdmQwcGNI?=
 =?utf-8?B?QjlxZnQ5MWx6eVlSMzZYVmRaN1VYSnV0SzlYbzN4VU1KbmJuUktOOHc4WGRY?=
 =?utf-8?B?NE9IUXVpRk5OVVB2K2NYR1VZMWt0ZUxpQlJIZzhvSDFyL1g4aUZSOFpYTkxi?=
 =?utf-8?B?VjdzNTYrOHN1cWY2eTQ2MVFUR2liR05JUTdQLzZmL1NvQzR1dTZJT2haaDBM?=
 =?utf-8?B?ckNyVWQ2ZTY0WFFhRzBlRXVidDY3bjlHUHpldU5VWjhGaVIvam9objh4TVNp?=
 =?utf-8?B?TmZ3NTlJbW91NmRxaUJ4TTJMM29wR1pjeVg5VUQwaEdBNHR0bjFOTXNsb0lZ?=
 =?utf-8?B?UTFSUFQ5aVA2NTJsakVlWVJyZVNrbmRWMEdGSEI1OU01dTByZUhqR1hKb2tM?=
 =?utf-8?B?dUpYc0k5bEVJd25HdVN0VnorR0VxZFdoU3gxV2R4b3ZkSkZYa3E5Vno0NVBF?=
 =?utf-8?B?RFczTFNWT0FDZTlPM2g5dUsyY2Fabnh3OFM1akdkc0xpb05iUXFQWUtBM0RN?=
 =?utf-8?B?czBNcU56TGw3UjlJSEgrRlJuQlcybUtsNnRBQXEzSVpnYzFFY2NETncwK3oz?=
 =?utf-8?B?UXVBeE9zSTFDS2hEY0Q5WCtyUm9ocTNnbFk3eXJLRjFMU0pjdmxkSHU0M1F5?=
 =?utf-8?B?L2xya0hHZHBVSHk1T0RybGYxbThBWUZPcGFxclFFMlA2K0FSU1FONi9GWmhL?=
 =?utf-8?B?YSt5VmpDKyt2WWc1cFBDcDYrODlnbUNUcU9BQXM2b2oxNHNIRW1mS2hWVHhK?=
 =?utf-8?B?OWwrMTlzMHNxTWFNMi9URm0vSVZGam41M3J3UERzM2VPZUNYUy8rK3RWTDAz?=
 =?utf-8?B?M2llRzF0QVlyWVdFNmNFU0QvVjZzR20zaE5QcmdlMGpqazRtbVFGaEQ4VnNi?=
 =?utf-8?B?dHBIQk5wbS9EVmpqdVkvVTZoaDJBTVZ1N0hSV3kzT3IraDVaY0xraTZCQldB?=
 =?utf-8?B?NWd3a25tc0xzVDRiRXpJMkxVeFNYNmVrLzdHei9uK1VWa3RGOUFaTnV2VmlX?=
 =?utf-8?B?OEdTY21LcEtxdWNHTUlycmpXVEpLVDQ1UGNOUTVnczJWYmkwRGNsb28rVzJo?=
 =?utf-8?B?UlovcDlIbjlvLy9PTmlzRVVCTnJqZHp6YXNhb1YwY2lHSGg4eWJ6UFE4NU5a?=
 =?utf-8?B?ZjM1SWNRS3pMeVMwUitOY0RYQU80MnVpNHlwL1RqVUFkODNwc3JpbzErdjM3?=
 =?utf-8?B?bFVIemNTUzRlUHJmWHI5Sm5naUtpZVovSk14VGxnenJGQkJnSzd6QlpJdVZ2?=
 =?utf-8?B?dGJWSlJwNzZIMlREMTFyRnJnRjhGOE44MUQrT3pQb2pUS0V0dE1ET3BLS0lj?=
 =?utf-8?B?OVVmeDg1S0k4Rzl3ZHZUNDRHMFVtdDZtZjZCcG52SWQ1dm0xa3hmMktFcDd0?=
 =?utf-8?B?TzBrd2t1Q0h4S3dreXFaUHdOOC9acm9SbC9MQ3Y0RDdPWEJia1dNUHcvWmpG?=
 =?utf-8?B?RUwxMVRucUJBL0tRQVpJaTRGTGVXVVI1aG9UMDIzWmxDUkY1WkJ5RHpSRGQz?=
 =?utf-8?Q?4p2U=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5677ae70-2353-47ce-f27f-08dcee5a8ae4
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Oct 2024 03:19:42.4218
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dDa2+L3suFzbHFaYY+K2lK8mHuXLhnx218qDjSyWZZPT7KWVvA2aN9+9hl9ajol8afF4w/piXdIaLRMh2VTr/A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9329

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBNYXJjIEtsZWluZS1CdWRkZSA8
bWtsQHBlbmd1dHJvbml4LmRlPg0KPiBTZW50OiAyMDI05bm0MTDmnIgxN+aXpSA1OjUyDQo+IFRv
OiBXZWkgRmFuZyA8d2VpLmZhbmdAbnhwLmNvbT47IFNoZW53ZWkgV2FuZyA8c2hlbndlaS53YW5n
QG54cC5jb20+Ow0KPiBDbGFyayBXYW5nIDx4aWFvbmluZy53YW5nQG54cC5jb20+OyBEYXZpZCBT
LiBNaWxsZXINCj4gPGRhdmVtQGRhdmVtbG9mdC5uZXQ+OyBFcmljIER1bWF6ZXQgPGVkdW1hemV0
QGdvb2dsZS5jb20+OyBKYWt1Yg0KPiBLaWNpbnNraSA8a3ViYUBrZXJuZWwub3JnPjsgUGFvbG8g
QWJlbmkgPHBhYmVuaUByZWRoYXQuY29tPjsgUmljaGFyZA0KPiBDb2NocmFuIDxyaWNoYXJkY29j
aHJhbkBnbWFpbC5jb20+DQo+IENjOiBpbXhAbGlzdHMubGludXguZGV2OyBuZXRkZXZAdmdlci5r
ZXJuZWwub3JnOyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOw0KPiBrZXJuZWxAcGVuZ3V0
cm9uaXguZGU7IE1hcmMgS2xlaW5lLUJ1ZGRlIDxta2xAcGVuZ3V0cm9uaXguZGU+DQo+IFN1Ympl
Y3Q6IFtQQVRDSCBuZXQtbmV4dCAxMS8xM10gbmV0OiBmZWM6IGZlY19lbmV0X3J4X3F1ZXVlKCk6
IHJlZHVjZSBzY29wZSBvZg0KPiBkYXRhDQo+IA0KPiBJbiBvcmRlciB0byBjbGVhbiB1cCBvZiB0
aGUgVkxBTiBoYW5kbGluZywgcmVkdWNlIHRoZSBzY29wZSBvZiBkYXRhLg0KPiANCj4gU2lnbmVk
LW9mZi1ieTogTWFyYyBLbGVpbmUtQnVkZGUgPG1rbEBwZW5ndXRyb25peC5kZT4NCj4gLS0tDQo+
ICBkcml2ZXJzL25ldC9ldGhlcm5ldC9mcmVlc2NhbGUvZmVjX21haW4uYyB8IDYgKysrLS0tDQo+
ICAxIGZpbGUgY2hhbmdlZCwgMyBpbnNlcnRpb25zKCspLCAzIGRlbGV0aW9ucygtKQ0KPiANCj4g
ZGlmZiAtLWdpdCBhL2RyaXZlcnMvbmV0L2V0aGVybmV0L2ZyZWVzY2FsZS9mZWNfbWFpbi5jDQo+
IGIvZHJpdmVycy9uZXQvZXRoZXJuZXQvZnJlZXNjYWxlL2ZlY19tYWluLmMNCj4gaW5kZXgNCj4g
ZmQ3YTc4ZWM1ZmE4YWMwZjdkMTQxNzc5OTM4YTQ2OTA1OTRkYmVmMS4uNjQwZmJkZTEwODYxMDA1
ZTdlMmViMjMNCj4gMzU4YmZlYWFjNDllYzE3OTIgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvbmV0
L2V0aGVybmV0L2ZyZWVzY2FsZS9mZWNfbWFpbi5jDQo+ICsrKyBiL2RyaXZlcnMvbmV0L2V0aGVy
bmV0L2ZyZWVzY2FsZS9mZWNfbWFpbi5jDQo+IEBAIC0xNjg2LDcgKzE2ODYsNiBAQCBmZWNfZW5l
dF9yeF9xdWV1ZShzdHJ1Y3QgbmV0X2RldmljZSAqbmRldiwgdTE2DQo+IHF1ZXVlX2lkLCBpbnQg
YnVkZ2V0KQ0KPiAgCXVuc2lnbmVkIHNob3J0IHN0YXR1czsNCj4gIAlzdHJ1Y3QgIHNrX2J1ZmYg
KnNrYjsNCj4gIAl1c2hvcnQJcGt0X2xlbjsNCj4gLQlfX3U4ICpkYXRhOw0KPiAgCWludAlwa3Rf
cmVjZWl2ZWQgPSAwOw0KPiAgCXN0cnVjdAlidWZkZXNjX2V4ICplYmRwID0gTlVMTDsNCj4gIAli
b29sCXZsYW5fcGFja2V0X3JjdmQgPSBmYWxzZTsNCj4gQEAgLTE4MDMsMTAgKzE4MDIsMTEgQEAg
ZmVjX2VuZXRfcnhfcXVldWUoc3RydWN0IG5ldF9kZXZpY2UgKm5kZXYsIHUxNg0KPiBxdWV1ZV9p
ZCwgaW50IGJ1ZGdldCkNCj4gIAkJc2tiX21hcmtfZm9yX3JlY3ljbGUoc2tiKTsNCj4gDQo+ICAJ
CWlmICh1bmxpa2VseShuZWVkX3N3YXApKSB7DQo+ICsJCQl1OCAqZGF0YTsNCj4gKw0KPiAgCQkJ
ZGF0YSA9IHBhZ2VfYWRkcmVzcyhwYWdlKSArIEZFQ19FTkVUX1hEUF9IRUFEUk9PTTsNCj4gIAkJ
CXN3YXBfYnVmZmVyKGRhdGEsIHBrdF9sZW4pOw0KPiAgCQl9DQo+IC0JCWRhdGEgPSBza2ItPmRh
dGE7DQo+IA0KPiAgCQkvKiBFeHRyYWN0IHRoZSBlbmhhbmNlZCBidWZmZXIgZGVzY3JpcHRvciAq
Lw0KPiAgCQllYmRwID0gTlVMTDsNCj4gQEAgLTE4MjQsNyArMTgyNCw3IEBAIGZlY19lbmV0X3J4
X3F1ZXVlKHN0cnVjdCBuZXRfZGV2aWNlICpuZGV2LCB1MTYNCj4gcXVldWVfaWQsIGludCBidWRn
ZXQpDQo+IA0KPiAgCQkJdmxhbl9wYWNrZXRfcmN2ZCA9IHRydWU7DQo+IA0KPiAtCQkJbWVtbW92
ZShza2ItPmRhdGEgKyBWTEFOX0hMRU4sIGRhdGEsIEVUSF9BTEVOICogMik7DQo+ICsJCQltZW1t
b3ZlKHNrYi0+ZGF0YSArIFZMQU5fSExFTiwgc2tiLT5kYXRhLCBFVEhfQUxFTiAqIDIpOw0KPiAg
CQkJc2tiX3B1bGwoc2tiLCBWTEFOX0hMRU4pOw0KPiAgCQl9DQo+IA0KPiANCj4gLS0NCj4gMi40
NS4yDQo+IA0KVGhhbmtzDQoNClJldmlld2VkLWJ5OiBXZWkgRmFuZyA8d2VpLmZhbmdAbnhwLmNv
bT4NCg0K

