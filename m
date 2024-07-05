Return-Path: <netdev+bounces-109352-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C16AA92813E
	for <lists+netdev@lfdr.de>; Fri,  5 Jul 2024 06:33:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 53F02282C63
	for <lists+netdev@lfdr.de>; Fri,  5 Jul 2024 04:33:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 282935FEE5;
	Fri,  5 Jul 2024 04:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b="VI5NOaOu"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-002e3701.pphosted.com (mx0a-002e3701.pphosted.com [148.163.147.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D75411DFFD
	for <netdev@vger.kernel.org>; Fri,  5 Jul 2024 04:33:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.147.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720154032; cv=fail; b=JMObJ6Tg/hYs1G1txKwDiGRpTVL1t+UotwMpe9YTI1Dmc/qvIqDeJNShKFsZmy0dpggsk4s+9KrqmWpvtxzj7jLvBAuo7Ey6VozAeezewQ3Nj1UiHnDbJxk1qPcaqYRDfeyM/xxuS33+pyTZ8XFQA+9JpmOFuZr3mjEttb8Dk4E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720154032; c=relaxed/simple;
	bh=miANxXYSt+pGJ+d9VtABX5aJahXTSwZPxXGsRxVwRms=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=OPAfdvEUcyDPT59s6vp0PlD0TM67HAFPkzwrkhvVKMrCiXO8d0RUKx/IzD1SeuhesTnVae2vYjMVTaHAMePhzprrrxsDrMkCgR/GT/ZkBk3FTwz/H3QAZde7a/R+3p9u3Lh032MdQdUegFaXjdLAwg6cg0LSPJZdUMaaTdgu0/A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hpe.com; spf=pass smtp.mailfrom=hpe.com; dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b=VI5NOaOu; arc=fail smtp.client-ip=148.163.147.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hpe.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hpe.com
Received: from pps.filterd (m0134420.ppops.net [127.0.0.1])
	by mx0b-002e3701.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 464EHG1u023944
	for <netdev@vger.kernel.org>; Fri, 5 Jul 2024 04:33:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from
	:to:subject:date:message-id:references:in-reply-to:content-type
	:content-transfer-encoding:mime-version; s=pps0720; bh=0m2gyfJZg
	V10mhv75V108G27HKf4CFkrMytwW2o8Mzc=; b=VI5NOaOulbNfYzjgV7VuVzSwN
	MEWvxuJmzgcSXW9OqoZx9jj9YH71OaKXjUyu9YHd7xqqGWKdEkPXa3LwXpT3ldB9
	Bzsd/bFL81l5WrV20j67orN+6exOMatY85Vdl4pcb9CA9yO+CFS+ZOPyAf8Gn3uG
	N8jQVaCqLTVOkkYmNLG2s8YN1wBGJ+HGv+rLHvaeMmZmvsvX4nvVqKeeheIO5t35
	fRBwVMsO6HVAidMAxvIZQxW8oiCr32rgUopCJfC41Qf6uLewcrW/9HWX4sgQXDJu
	8h36IGi+V7DtMs//R6eZbvgwmplQRqCLpX/zyI2DoV7NWkv7NfQ4n1Wbnez+w==
Received: from p1lg14881.it.hpe.com ([16.230.97.202])
	by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 405v9mvef9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <netdev@vger.kernel.org>; Fri, 05 Jul 2024 04:33:41 +0000 (GMT)
Received: from p1wg14924.americas.hpqcorp.net (unknown [10.119.18.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by p1lg14881.it.hpe.com (Postfix) with ESMTPS id CB2318059FE
	for <netdev@vger.kernel.org>; Fri,  5 Jul 2024 04:33:40 +0000 (UTC)
Received: from p1wg14926.americas.hpqcorp.net (10.119.18.115) by
 p1wg14924.americas.hpqcorp.net (10.119.18.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Thu, 4 Jul 2024 16:33:34 -1200
Received: from p1wg14920.americas.hpqcorp.net (16.230.19.123) by
 p1wg14926.americas.hpqcorp.net (10.119.18.115) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42
 via Frontend Transport; Thu, 4 Jul 2024 16:33:35 -1200
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (192.58.206.38)
 by edge.it.hpe.com (16.230.19.123) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Thu, 4 Jul 2024 16:33:37 -1200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mCepYZKOGSgbf1y49F1a7EzDpeO2FSKusPge+2pv2jdeAh28mZVqxjsJXclDJeVaKRmSST4II53UY8YfLHzYCm6OKky9ldsamqE0iCEL4YUDiXYxqJDviFoATVxM7qYgFqpsoXQU2waa384++H7SagXU39QpE6NZuH6GagLRRutliRwAxQ6ELCi1zTiwOorNQbLLUhWJL5NlSV0WT/iVmf69m8b525YAbgqMave9s1svDVHhOC4D16o9zc3O4/tv0p5EvSENxJpGJPdkuEw5iE6Xa1GKOWIhA4fBqYn+7xZjb/UNCFrTN3YlXLBIVUQpBqll1zh8Ph7VWoFFG93Uxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0m2gyfJZgV10mhv75V108G27HKf4CFkrMytwW2o8Mzc=;
 b=IzuIbGcaaYh/yZ0gOtuKFKmWjnOE2Sdp26jV9N4FeyIwl40hs3Ra/c1kBMukgHbdT6I0VIck4jF4GF0JhQIRrjfrPXm0zBYUo3IKokg+2HG1JYWSNo4cumeXCAj+VlALo6STg8T/+k/HU8fbgaRjASN9o0SGyrpjhlEd1fihGfksL5A4KX81ytkUXuv2l/VnLVC01sDQDazijaecAtTcyPznCtUG6tWFcXD8cfLbbm6seYSScvTXkNwnYbqxA/8/cVARnGyQ6nsPcGTr9gs7WTzEVLrfrAf0GxMYV/Y9pW0jUeGktTIYWQ8cO6Ybosm2KSXZB9eqlpcNft6JzP/pdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hpe.com; dmarc=pass action=none header.from=hpe.com; dkim=pass
 header.d=hpe.com; arc=none
Received: from SJ0PR84MB2088.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:a03:437::8)
 by SJ0PR84MB1968.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:a03:436::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.26; Fri, 5 Jul
 2024 04:33:35 +0000
Received: from SJ0PR84MB2088.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::8cc2:658d:eae8:3d8d]) by SJ0PR84MB2088.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::8cc2:658d:eae8:3d8d%5]) with mapi id 15.20.7741.025; Fri, 5 Jul 2024
 04:33:35 +0000
From: "Muggeridge, Matt" <matt.muggeridge2@hpe.com>
To: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: RE: iproute2 ECMP should display expiry for each nexthop
Thread-Topic: iproute2 ECMP should display expiry for each nexthop
Thread-Index: AdrObOvlCpIT08NaSkaSbp4oK68tqgAJ2M8Q
Date: Fri, 5 Jul 2024 04:33:35 +0000
Message-ID: <SJ0PR84MB20889CA976BE6C8DFD2C864FD8DF2@SJ0PR84MB2088.NAMPRD84.PROD.OUTLOOK.COM>
References: <SJ0PR84MB2088CF4614829F0A130DDE60D8DE2@SJ0PR84MB2088.NAMPRD84.PROD.OUTLOOK.COM>
In-Reply-To: <SJ0PR84MB2088CF4614829F0A130DDE60D8DE2@SJ0PR84MB2088.NAMPRD84.PROD.OUTLOOK.COM>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR84MB2088:EE_|SJ0PR84MB1968:EE_
x-ms-office365-filtering-correlation-id: ae6584c2-1e23-4209-31d7-08dc9caba20e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?KVB5EUMJJYmeR0Q29ir1ihVqqV/YgDT0gflpJd7kwhfWcGANcv+pR/1AWsrF?=
 =?us-ascii?Q?Ot37rXDoeyIYf2jQQy0f1r+IadLoQQ4iLM+E1nWqbBeRa+/kWSQ4S0Odu9IH?=
 =?us-ascii?Q?wUQ6zu1od39nLIzpzqNvLT7pFEew6vB56AFP8g1+kIm7UcOfz4+Nri7dPdBj?=
 =?us-ascii?Q?F0pfuwza1bzydRH+vNXuBSOBik/jB6YlYvTao2ZUQi0DfdkLwUNn/KhnEz6f?=
 =?us-ascii?Q?6sMHH50EXP9DFJF/EaBndjem3fI5BrLZYl9JjrqIlj7Ztw9MNC0c2OQiGmN9?=
 =?us-ascii?Q?w9ZmKsne0PUd+cyEyvpLmNYaWMuuMNGnwjHvNpwN0lhglI5EdMJ7Mqag20Yy?=
 =?us-ascii?Q?/28SNgGAJbwk/cu5DiXp9Eaeid7KXv2anEyWJs/QRSntZxcjfrcmUDQM+BWA?=
 =?us-ascii?Q?CN2/1wsw3z/djal9Kk9ITk4S5yA0b15Pjhb0lRwu+HDmu79+LVW00fPfKxCU?=
 =?us-ascii?Q?YSzeS9OXhL6BIjhDGIDqzA+8c8TyHhl0spM9cJW+PpPPuHA8SSJmDXJTD4fk?=
 =?us-ascii?Q?/e3d29Z0NE/dnDUzIfjKymoDOx+F5YLX1i2VASIWXgVtHdyPab4SQZx1xzl4?=
 =?us-ascii?Q?qvcUBCXP97u6uYJn7TojZfO5q51jLbruvn7aFk5UeVyL2B9AQym6asLBQFFN?=
 =?us-ascii?Q?9qPb3Fv56TgRnOZVppq7hnvMlOvZmhiuoBMkIMCRM1R/+XPxxfxcpmG5hN7F?=
 =?us-ascii?Q?y7eymAvZXcYNxpVccEwDCCM8i36IkqOaqoaT8PFqpCdwGODJJ9EKXYTUEPJA?=
 =?us-ascii?Q?OnqMql5sYQXUj5NnJPCY9R2YQkx3/V7ufr14CaJtaDEOVsMGUMxFnxTZdIVs?=
 =?us-ascii?Q?EvGQzQTPpUEpoNfjrFATXst8PuCQI7NStf2j9OyPgFgmi448JsTDihXDfL9F?=
 =?us-ascii?Q?ZZ8zvP44XUn17CAMXRXEy0zMh9RkEA7yVR1Nw9T8X6MMQSQgB3nBRpZZN0YO?=
 =?us-ascii?Q?OAHJbawBpRNDD7YE36tRPbXv10wvCkKMTC+fCc9yanRa4E7kZr4TiJutOScY?=
 =?us-ascii?Q?v0KCFoy2y5UzWEmXJHe/4rkUlqDZq19SWDD4hujuKu9qKB6xQcTw1CjBEE9G?=
 =?us-ascii?Q?6kBWUA2fEeChm6GS2PlkDqk9h8QNiB5zn1NKjVMac43g+XHh6WZnNIyw/G2w?=
 =?us-ascii?Q?jWz1UgSnNNTNUh1A4bm56qsavTHV4nc4KHskweLVIySSnZIAdOs7X1c42gal?=
 =?us-ascii?Q?WEMHWn2AN6PFR1wnQ6GoALE2cVX4NkyM/ksaH1ZQShe5/8+fgT6upIWxsjo9?=
 =?us-ascii?Q?XDtnjwhI2Xu4owhN8J7EuvOAuOLNf7smiGjlgBP9qZO+6FsEWq4HOnESqE9L?=
 =?us-ascii?Q?JLSVYrwabwXQetCXlmUmSOhCnr2da5+W4uZD7jPs8D5M3b2V21ZDhugsAPIk?=
 =?us-ascii?Q?3QgGs7fpX1gecp+eh5crJ9nF+qNSmCCQ20gP6QLncVKPHZafsw=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR84MB2088.NAMPRD84.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?9EjSNRSBlk9HouIX5GE33cwO8+TceSgMQI8XdoP9Ha6YTIgbRF+1T2R8yVe+?=
 =?us-ascii?Q?q066oBuIjEEbCzbtsOONPSSMHnzg/GktdbOEL/MTujhArHZRhATGT2B6TXAl?=
 =?us-ascii?Q?R+I7l8HFjJMjBsRSbFRKni/fqjxxYbb0uOPiorlgb0UmLb+ia4ECH6wjG2Qt?=
 =?us-ascii?Q?xoE48B8ZRbrBzKvtaMZQuFr4UhXXTS/E0p8Ef6vnImbxjgIruYppGGHbS19o?=
 =?us-ascii?Q?LI+3rjVJY54TEM17Jtdlq3/WJQeRdw+/GhBy/XAnsCD9gITOaRhYusYPIX2D?=
 =?us-ascii?Q?5V0DQspZCTj58X6ORpcS4EJN1aXzSPwboebmTvKQGhxh+NPhOlnl5dt0jzx3?=
 =?us-ascii?Q?wad54EgAzr3SvBbD8VK32Mruq8gABoeFyOBGnSrx1HCbVORv/M+eGuAX2F63?=
 =?us-ascii?Q?/y4pbJhP9B3KBz4RVikqME9+RJLncyb6KiwJwJ1OjR5ZdLO4d04RbZojR/Fw?=
 =?us-ascii?Q?S841/k++6tlqx/sKrbN/UWJCEcDfWGWjM/eDlN9wGW/IWoFnMsgZkcTTlQZS?=
 =?us-ascii?Q?VhgaIh1R5fQx8fOn9BwbyHsT+NlqFJueEsNb5LTmy6hU5O7EpLEBCxHQNtoE?=
 =?us-ascii?Q?cEjn02hSs8K3AgVkVe/J/qR13KJOPaIHxXvhnL2wZ+craq7CpaQEKfeJfL9G?=
 =?us-ascii?Q?HT3zUGYIud/WiSOJxF8DoC9gW8aCgFpB7+IJZQqdCu89oVjPM4R1NDJyPCoq?=
 =?us-ascii?Q?8bgCVZ5vBlNje4h/fVT1S4Yw+WeVcAu6wUoUHLln6l065LYKV7rIx4hny4CJ?=
 =?us-ascii?Q?32rHQvGcy3oB6VwnyGLA950gHdH3PbDga9R0m0JB/XzZm1cTqANp//5BGpMI?=
 =?us-ascii?Q?uMo/saGLY5QI756/LK93Ovy1Bh3ATIf0ThrY0vfEc7+7XvRNu3GMGp9fQyKh?=
 =?us-ascii?Q?20CCA3+TPYDglDPVz9TIa70YW6NO/2IgIL0utp0ngkyhCuDkluBmZck+iWXN?=
 =?us-ascii?Q?B3KC8nMC9a65vufvnCdIetefXW4rl9sNv+xSzcrem/3Ij+6vhk0ndQcqzRSQ?=
 =?us-ascii?Q?TafChjbw5UwBtHmQSK/AaMtuCb4+ZmvM+ckqJauI5wna3sngoU3Ga6XgLTc5?=
 =?us-ascii?Q?7Tb76oab8SxbkketmxBhhauyyJggWYAkvbzIvA+hu8MzcM2vp3RQ6oolDh9J?=
 =?us-ascii?Q?EuqqEblUS6e9nVAj5oytvrcEtLkgLnVj0/jMGLnXeuVuZHZnq273sx8J+18U?=
 =?us-ascii?Q?pT49E5NzZGJQQxTTWC6gO7ui4zsTj4bWQ5HthP0RjBFucGMVKUKoIZkiZCZu?=
 =?us-ascii?Q?xSNJZWUbq55ryTzaqI4BQ5w2RiAOX94oIUYoZTtnd3gArUEAETAxTQoY2IJx?=
 =?us-ascii?Q?Kq+QZYkUNvwFvqt4DHWOuNrvyXTMKGfLeK4UI5h9+PuICVgq//thJoIPwSDA?=
 =?us-ascii?Q?onOq3G1HezXhyknrmTOF047bIPBQUhHO/xuW6ArQMF6zMs7bf9NRX6G8XcIu?=
 =?us-ascii?Q?BMt4oLnnG6wMErXPHA/IaY1xmslkrP3Rs+PeIcBQy7JsgnjbVKJ6wg086rPV?=
 =?us-ascii?Q?lbuVkuDYdrim+xYH2qqwmAwyoPOk9bX052WT/d2F+khM+/iVO/gcnHc+ToYA?=
 =?us-ascii?Q?4rKyI/4JgTzJ0Jujd0qKIBEPdGpy0Vev7ucr1M4k?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR84MB2088.NAMPRD84.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: ae6584c2-1e23-4209-31d7-08dc9caba20e
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jul 2024 04:33:35.1654
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qXsW/WZYmZU2TklHkty3AxB/niQ/W878ALi5qTdScHQTJDLCvHMXmt0ExdEIMbBm8P5dc4/afz186skz+10IdEezn+mmjo3fJvRIUTz8J0I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR84MB1968
X-OriginatorOrg: hpe.com
X-Proofpoint-GUID: oY8q2r1qz2lAp80VznJ-uYIimNXzcVK6
X-Proofpoint-ORIG-GUID: oY8q2r1qz2lAp80VznJ-uYIimNXzcVK6
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-05_01,2024-07-03_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0
 priorityscore=1501 lowpriorityscore=0 mlxlogscore=999 impostorscore=0
 bulkscore=0 adultscore=0 mlxscore=0 phishscore=0 malwarescore=0
 clxscore=1031 suspectscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2406140001 definitions=main-2407050031

> From: Muggeridge, Matt
> Sent: Friday, July 5, 2024 9:51 AM
> To: netdev@vger.kernel.org
> Subject: iproute2 ECMP should display expiry for each nexthop
>=20
> The output from iproute2 is misleading. It shows an expiry time in the he=
ader
> of the nexthop list, which suggests all nexthops are goverened by the sam=
e
> expiry time. However, my testing proves that is not the case. Each nextho=
p
> expires according to its own expiration.
>=20
> E.g. imagine a host receives an RA with lifetime=3D10s from TR1. Then 5 s=
econds
> later, it receives an RA with lifetime=3D10s from TR2. iproute2 displays =
them as:
>=20
>=20
> $ ip -6 route
> default proto ra metric 2048 expires 6sec pref medium
>         nexthop via fe80::200:10ff:fe10:1061 dev enp0s9 weight 1
>         nexthop via fe80::200:10ff:fe10:1060 dev enp0s9 weight 1
>=20
>=20
> From the output, you would be forgiven for thinking that both nexthops wi=
ll
> expire in 6 seconds. However, they expire according to their own lifetime=
s.
> In this example, TR2 expires 5s after TR1, since that's when they were re=
ceived.
>=20
> FWIW, my Ubuntu 24.04 system uses networkd, which configures routes via
> NetLink.
>=20
> Matt.

After reading through the iproute2 source and kernel source that processes =
the
RTM_GETROUTE ip6_fib.c:inet6_dump_fib(), it seems the kernel does not store=
 an
expiry timer with the nexthop. So now, I'm thinking networkd must be managi=
ng
the timers for each nexthop. I'll turn my attention back toward it.

