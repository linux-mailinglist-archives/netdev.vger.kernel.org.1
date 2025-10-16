Return-Path: <netdev+bounces-229930-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 48A03BE224D
	for <lists+netdev@lfdr.de>; Thu, 16 Oct 2025 10:28:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id C34933505AB
	for <lists+netdev@lfdr.de>; Thu, 16 Oct 2025 08:28:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0C7B304BBA;
	Thu, 16 Oct 2025 08:28:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="X+/DgH4+"
X-Original-To: netdev@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012024.outbound.protection.outlook.com [52.101.66.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DED40304BCA;
	Thu, 16 Oct 2025 08:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.24
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760603327; cv=fail; b=qQC1q5fRJsmnz8R0zXmW1+8xkCYspESFaoXvN13rCTeUgKBhr9cXxgaJ+oX5lfy9ZwkA6+5lfOFo0JyJFpZBT2Qcyp3mHjnKe145zVgBhyS8Byck1vBw7dc7ADLeBYIKaGrv6vwJOPQgpaytKG18itdj/rYbVBDwZk/LJCEn+2Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760603327; c=relaxed/simple;
	bh=M0vAbIOumqvBdgKeK7eGBGkrfYDl1VnBlzK5Lq6VSys=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=n+Cw2lXK2JlE8ioZEM1/BWLucHUiHnagWyLTe1YxmQtJdieZtTamcl1UgvNB0ICTZZpv7BDwDYvgmJdEklm6n9WY1hGN3FQyhE7ygynMLRCySYGc5POFZbEORxTUS2dCoPi6hIq6F02b4KsAdoWUPrplho6UeMBRF2dbQVyd1qU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=X+/DgH4+; arc=fail smtp.client-ip=52.101.66.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zSJNzKMKZyyAzU/D7x+Q/kr+fQgAAk/gt/tbgrRnDbFqkUTmessWb13zZwAqhawvmVmhq1+Ruc+469uY04wiYuWMxnxKwMRv2O7X0gh5ySdk3VaecJjr3cDYY/Nih8/bAfD1LfZMoXcRwrBEUfetwnESpOjgh/37iOHcknN18P3ZNHcCePGyky/gA3e1qPJy/B8m3eiaIarA80sYEHxc7e+qkZsjRGimxf3l/k+WOLPa9IfciabRdq0my1ZD4/RGA+jU/oaBlE7X4pMmowE+njsQEgSf36p19iHY/l7/g1ScPr9QTDzpPSWtTU1YNZYF6qFmbmVsIkSTOpOar9jaVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C/0zRoltC2T+t7VQLgk6nyEmIpwWFEdsZfuo8oWQWw8=;
 b=HpU5F+jguQB7bPtLvtILJiFA6KmE1DW/MmIMvTJc3MvYHIXosOMAtoUjJG9Q2P9BUmclU1LecClJ7bB5S6Ui1IUV5dlwKcovnnGl9itfTwN7dT8N/BKwhiJ56ZYIvsNCc05bt+Egb+P193/5XzF4093tVnLr3eoeYsglrBy3rI9Vgi4Ji9tNT9BfnokHKRPOylzPABYwoKJKswITuuDMhuwV5nPw4KmzyHVvn9Gp7LxKpQW1WvI5oHtR5Le/TNqFBLvwak2rIaD7+IBqjCT3eIcxsr1uYz8vaxHLA1LQUl4yj5jEOb4IkORaVAeLHk4JkHQhht4wzKbypQZsdlgZtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C/0zRoltC2T+t7VQLgk6nyEmIpwWFEdsZfuo8oWQWw8=;
 b=X+/DgH4+eKxvi5DzeaND/8676QDBKtoWOdmZ0az7vztOpsTKhczHF/0i+XwIuVfiAdjYcVP35gJwv9ZzjSyp8UoOZu3DZ+EM6ZJInPfe0h6uqf8VusQGyishk2+3kezDk632wKbXA3sZoNCDbqCODNWAKi9glr2GGpevd1QD6GWIvpagERHM8UR54ltbRMDa8CPR15W7KauZOzgBfEuQS/algGAKbbaJy6gPiWmsJhZwANvdUzhuBz77r+Lv1rl9pQckM+t20+PanKPzH5U5YW8UQhGznQxZEZjce6dgFC87oue3fQIQynLlPjJ/lW14pST9+OoePRGsch6TwsDmuw==
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by VI2PR04MB11002.eurprd04.prod.outlook.com (2603:10a6:800:280::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.9; Thu, 16 Oct
 2025 08:28:39 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%4]) with mapi id 15.20.9228.011; Thu, 16 Oct 2025
 08:28:39 +0000
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
Subject: RE: [v4 PATCH net] net: enetc: fix the deadlock of enetc_mdio_lock
Thread-Topic: [v4 PATCH net] net: enetc: fix the deadlock of enetc_mdio_lock
Thread-Index: AQHcPXl+4gOh3lJGnkazrFvku0OWBLTEcqFA
Date: Thu, 16 Oct 2025 08:28:39 +0000
Message-ID:
 <PAXPR04MB8510BB8856CB343601102A9988E9A@PAXPR04MB8510.eurprd04.prod.outlook.com>
References: <20251015021427.180757-1-jianpeng.chang.cn@windriver.com>
In-Reply-To: <20251015021427.180757-1-jianpeng.chang.cn@windriver.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8510:EE_|VI2PR04MB11002:EE_
x-ms-office365-filtering-correlation-id: 5a51d4ce-af20-4e9b-69fd-08de0c8e0203
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|19092799006|376014|38070700021;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?t/zxJ6pgXUGWPtWq0yPnm4eVWuZBXRbsPTGxBIc91LK7yaz8DlrWycg4IPuY?=
 =?us-ascii?Q?pQgT3hrcC5btZlnUS0wPtuXd4Eaa3tkCC6AbCCQGceQik/wvvJZ1gF1uDrJL?=
 =?us-ascii?Q?8AwsKO1RgIrv7QjRlbvd1JoS+Mf9nFtHxK8BXpD3aloyfpsoAZSxr5/iVSFp?=
 =?us-ascii?Q?AlDbqmQlq4IA+j7s5HSIdxG8TWdK/v7jZsxOiy33zFlA/BHoHtSpKm3wZvqK?=
 =?us-ascii?Q?as7L1dUXoO7CBqkLqB6yQmp2cuPXF/e1kHc7RiG/UJ7wIG/g/DbElRTySUCF?=
 =?us-ascii?Q?dBh39SxwC79eRNKqUW3RqAkjgPbicz19JLQmEQQ3ghsnRbLtZB7mbektTdbm?=
 =?us-ascii?Q?Q8/mSIGPTdPUYqO5EmrZlQVKJzBgWPoRtVK/WAo+sRuk8G5t/K3yyignLWZJ?=
 =?us-ascii?Q?z1QkwRfggDjPQ490VHydVvcDz2TYhH1/hQbUqK7k9jzL8jhZNjyxW+nbK7u3?=
 =?us-ascii?Q?yle1EsHFicYo7R5aBOEvzmWD8PErcmRXDxSULSW3nneF9Bxv7oVFSxV7yIN5?=
 =?us-ascii?Q?iSv7Vh1vR8leYT5+s9w5T58LnKnc4zNnmS+kY678mhPsGUZGEprRSRJZMKy4?=
 =?us-ascii?Q?uya+nKTIvxiYmSgvt1gq9SxyFWcVoOmPAKZRWNDpQImQIr+V8bKheejYgUPb?=
 =?us-ascii?Q?e5yxIgwNx81wMIRQ3LkbmkALgPjyo2ckAgq3EXyoPj45p8j1FNSSRLfD7dWM?=
 =?us-ascii?Q?ymWTMy8a2VJaniouyawh0PNvB88g0iq8zqBezJxLWK0vSwq4QVbc2MVwHlTu?=
 =?us-ascii?Q?Jw1Ba5BMnJawJJUkcuP286uTO7oL+DKsh85fIjYEJrqaRZR/fourVxCDc9rS?=
 =?us-ascii?Q?4TGtZf+6HFvo2FoSV489Hs/tVZ1mebL5hB4YflghawW3Oy3vDHotAFDiXyLn?=
 =?us-ascii?Q?1du5rlc8KzDP1fIhIGf1b1YMv3Kr8klUaP/Ay/Bb8CnJ+LLIAsjNkLwYr31j?=
 =?us-ascii?Q?ATU5Ns+q11fSc1p39sqEd9Eapzis34azAEH1tbeTCZwmR9kYdQV+rZGtUCF8?=
 =?us-ascii?Q?H7SLfZnS7hAry7XmEicMeXV4vCioxv8g14JqYC466426Cw53YVv2J1qwa4It?=
 =?us-ascii?Q?puzo25V0/XqJ2qjDyO3VeswE+aSZLBDKHwtIXUqNFXpP74rGNFZyJanVfoxA?=
 =?us-ascii?Q?YmbcIMkHkn48KAesSjBj2r+jmDc5BMtbcJeuTAWx82prxRo8Szfr8rl3cfi8?=
 =?us-ascii?Q?9lhnXydl9eICQq2yOCRnpmHuvpPlzH4f1VAqSeNXN0q7MtViMsHamjr7P8Xd?=
 =?us-ascii?Q?v9Z5jkmgjNrVw5ZBsP9yDJIYqWujHVrBxqxxKWSazJBE08R6BT+qj2tfP+8Z?=
 =?us-ascii?Q?98SZjPuUkqS5TAuLgGOm1p/HG1j7Yp5LPZwNpSOg4h2a8Nl1vW14uomvzfJF?=
 =?us-ascii?Q?jJIYHScSkuJuh9qfz8BotYQwlFTD+qRsirRcbQw7bIPFTlVWGMZM2WOYhsur?=
 =?us-ascii?Q?Sc3ETT/nj45mx6dLiuYsz7giToQE9Q/KV9yn0C28XkzA2CQfO3alVETbxELC?=
 =?us-ascii?Q?wlWyfK0s7hJ3DFGLmfOEYTFpyzq3pZnyn9en?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(19092799006)(376014)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?nmint0F3WioqFPLusD58w8K28UejHSNFCNPcSrM7sUEPRFkl0R3db7drw7Ve?=
 =?us-ascii?Q?7eB2TOhFiuLOveq/j6eLKmEKWPwpQoG0DNQyWlOZAsq/LJsG1dAQ8oc5huQe?=
 =?us-ascii?Q?Iw6ouXHoauzutA7sNAsRywCrcxd//O0lYOSAc8rAhm4IFtIgd9E2YnYI0roE?=
 =?us-ascii?Q?AwOdZnzn3mYlg3M6R+8K+t+hDtQIQJ9xwD+Ec0WOukKfuqGUyZycEpVgurVa?=
 =?us-ascii?Q?cs9PE3prxDpPnJP1CNrU7TOZPgqAJN6t26gDu/oVa3B1O6B2vkxsKXfaR0tP?=
 =?us-ascii?Q?+0/TFQu/huN1m4ge9CH1Ax7+ZAA4ZodlN2z+ohEUiYoRlXozyZ8kEsqPtKz9?=
 =?us-ascii?Q?OEKhB2sk1NTZ1Phtn6CBmb7Q6S/9vSJONTKbNo3HYcqSwPpJ/xCJqp6mcSvy?=
 =?us-ascii?Q?3+7uWwGa15Jt+WWLqYVh50ghK6w2c7I/E4cJMYMnacrXqyAKPes9aY7OQgQT?=
 =?us-ascii?Q?JZ4GAlgNYRbQRlOmE+pdRO2eHCTicvQFVqeMSAm7AhQPiEt6kZXpgMXcYBgG?=
 =?us-ascii?Q?9LEgxsljWNoaGR4RQA7Z7MwRw+aAYcqRvzBp+vTKqE/uQC1jS7g4TvV4GGXI?=
 =?us-ascii?Q?uncVaPt1dhaeM62yq/nzkMn+98mcPw6e5oNDCqbZQ/FXeen6M4CPN6F1f7b+?=
 =?us-ascii?Q?+MMMX+UPTnJJGhr8h49B0ZOl6a3E45H3WUCTqjlZzQKxOJ7Fi7A55iJ8IFdn?=
 =?us-ascii?Q?oSkfd2pK84sxWFH969BELz/pNPBsTg2SSCv3Vk4E96EGl0yvZy9adKDRdcv0?=
 =?us-ascii?Q?9AmQtp8DeXRJqSsEAQWWTOp8aNbPupbVUas0HZTUsHvhcrCXfbT/R0ijwm1x?=
 =?us-ascii?Q?l21cwLeEdfZAtif5oC4/CPIEz+4wnWKpApiLGUcrpdSOa/L+DUurLfCbCqo+?=
 =?us-ascii?Q?a5yT0KzZ1SjY9vqHrbeLXyni6aCzo1rbLzwtD9erDKdxOiQ67ujdzDiWGpkw?=
 =?us-ascii?Q?8MTdCekMFeMjo4FnAJFez4kQkfP8c3rMNJZP7Phi0Y3CpQid15I+PJg8JdbK?=
 =?us-ascii?Q?Ti3qfpVQ2wWnerLFusR4WhKFk38nDm/Kl1w4TRbQL1ZYWfFbmdx5CxVxxIo9?=
 =?us-ascii?Q?hI5w33Q4X6heDecqb9j9InFb6dYxjIIUKgHh5SdSWCFTHDOmkTwvvaE7mQ29?=
 =?us-ascii?Q?lvJZYMqyFQ6qYFMjoig85iCPz8ePwNrQDoHgpqYPsftML9KsH3PVfDcisVug?=
 =?us-ascii?Q?iNGJxwKSoNh3VC2M9jFhNT3xBbAQxFKqlcR52C0CzXmxl8TSp4qaBVBYDfKa?=
 =?us-ascii?Q?7bb78vuABOBICv3OOjCm0AQpYwxxty3vLayOG5C32MNTZL+z+wvUCwAUfB58?=
 =?us-ascii?Q?s0mveRicF0SfB0TsVB0FH4rp9SBIWhpt0djDOMkkzYtmEbQyx8qLB0B9BVPj?=
 =?us-ascii?Q?QNn4kJ7ZtDZUqPTPgeOsZl97GJ2n+F+QU0sGSE/IMDSamJjPQ19mIR1BHzBv?=
 =?us-ascii?Q?S1ZuJlf4jxzrqP1teTd464Y/t+CE9nQFg43eyF3lrntT9dk6/GPzIvs0Fz9Y?=
 =?us-ascii?Q?iaR7oe2ddpbbtCtr5n3QznKv4vsm5TboHbDlCOky/KKf3TMwbzLqNG1tz+gq?=
 =?us-ascii?Q?IK7oH6ZbE1p6wuxRt+M=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a51d4ce-af20-4e9b-69fd-08de0c8e0203
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Oct 2025 08:28:39.1431
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xHlUIpKNd7aDsxawPS1PF4wLXvW4hRS5eQkTXR51orYDUrYxE5AuopWKVMFtGdnggG9xVZesvU2mxsvCFE25CA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR04MB11002

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
> Fixes: 6d36ecdbc441 ("net: enetc: take the MDIO lock only once per NAPI p=
oll
> cycle")
> Signed-off-by: Jianpeng Chang <jianpeng.chang.cn@windriver.com>

Thanks.

Acked-by: Wei Fang <wei.fang@nxp.com>


