Return-Path: <netdev+bounces-137225-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E498A9A4F8A
	for <lists+netdev@lfdr.de>; Sat, 19 Oct 2024 17:59:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8ED4E286009
	for <lists+netdev@lfdr.de>; Sat, 19 Oct 2024 15:59:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37C8754658;
	Sat, 19 Oct 2024 15:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="X/Qvatyc"
X-Original-To: netdev@vger.kernel.org
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2088.outbound.protection.outlook.com [40.107.104.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF46D256F
	for <netdev@vger.kernel.org>; Sat, 19 Oct 2024 15:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.104.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729353584; cv=fail; b=Ee3EA4ODNbZ0SjA9Hj3UjaFyUUgd8CM/1kPS6nPsLX7O1jVkGEMTi7xPRzXxcsfTQUlKPf2SPY7BQVO4f0j0pDTTCq34jeN8TET5iWRMiof+MyW1/fclFLpmgdHHFGD4gp43VxNTn4RPCShWOYKhDt8FiBSDe/EZAhVfWJWBXZA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729353584; c=relaxed/simple;
	bh=C2aly+U4yE9EVCU2u6oFDrI1LlPZjSYoziCDSaWsGts=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=DFKIzKTg+DIrbgxSXlLyGggscGd+kIw+LqowlPoSHtsyr7Xx23AWGDo2SCD1T6kosb5yzu5713Mej9L/AJWhEwtwNo0OQ4pHxZQxQUmNJxeDu2gxQDBaeFncL0KRmZHKkygtJagzo/At7ZK8VmJwIt4AA+dqSBzf5BuvR3B6fGU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=X/Qvatyc; arc=fail smtp.client-ip=40.107.104.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YzKrOAY/lbiF0zm6ruwqwaG+LZs8O1/08s9EEdd1tDUADqPX5nnMthK050OzcpK5t63dj0BkvpRV0kVz8BXd5rjYU+pGO94WGwf/9oRud+FO4BcHybqTq9HDTTJttQ0XmMzm+/+uoOEwV4aq7UWzmW+AO0uqy9nXyIP+dcskJMIAGuWzFFbnmFz/+BD1YqphEUuhHp1kEG0UMzozCXJg5m0EuYg7VhSS+novEgovBHVyrS+O3J0YXV2mqntBOEhbfG1nGY3FYn4cGUmenAei3p7Qz82OYUVIJkdADkS62h6z4tzN8fxo53qIF12h50fUTU1sZaa51WFWIkxkvgLL8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Agjz1lFE2BIPKEIWgV0CD5FmtdPyruejd1CbOakKU1g=;
 b=usGQnYW7vcskmuHN6sEhEwub4olaqKgFAmL+tAkXm+fTzGPubafzjLcek8D3n/0axyfFNLIjcvbHXJoxB+no23csxmssczh1CfxBPuJL+q3rhZrepWOr4mYyazSfV0IbBk8EHmYNDQZEh5sa7oXj2hdn1MKvu87ERPH1VLWVY1SgdB8eLRyHVfE6yn/PKJHqGAdjbJ1N89YmqoBUtsrPV4e/4yLYgvmAmMjAoUxosqqaXL2lwoQeV0PryGfNnu4W49Pm6uFz7GAQsxKz99Xf766PYe1t+Y3KVqSKOxZ17e4Qgh0TdLnt7e5CGh2fgjGw/5Kaf0bUqnBLJyDXF5excg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nokia-bell-labs.com; dmarc=pass action=none
 header.from=nokia-bell-labs.com; dkim=pass header.d=nokia-bell-labs.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Agjz1lFE2BIPKEIWgV0CD5FmtdPyruejd1CbOakKU1g=;
 b=X/QvatycMvf/RYYRN+szjfGGbZL+e6KWo2WCTDl3zqElCgSAft+OTAojz5II2D0rs3ZYouFyi3vyvdjVUwBpumGXG43QRtSR5WB/lhTENLuSdXYaQGafilN7tyAiQYCVgLgQYJPHAYfYUKs07PkfAT4UWa51nV53bOPxoTHEzCu9y17jaNOBpyDD4YPmygF1LfwXXDMsrzRCJYlLWiDqg902eZzY6/M2v9TzZmUbCiW6j5fcRHMPuQFtWgNElvbevGe0NmkKMTwEZN5/r9HGIrCjsOmATgeKozYZ6zKtQZ4HUeC8YKHPaX99JZhRc/AUEdbjJb8PP7CdJlbKE5gCeg==
Received: from PAXPR07MB7984.eurprd07.prod.outlook.com (2603:10a6:102:133::12)
 by AM8PR07MB8229.eurprd07.prod.outlook.com (2603:10a6:20b:324::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.27; Sat, 19 Oct
 2024 15:59:38 +0000
Received: from PAXPR07MB7984.eurprd07.prod.outlook.com
 ([fe80::b7f8:dc0a:7e8d:56]) by PAXPR07MB7984.eurprd07.prod.outlook.com
 ([fe80::b7f8:dc0a:7e8d:56%6]) with mapi id 15.20.8069.024; Sat, 19 Oct 2024
 15:59:37 +0000
From: "Chia-Yu Chang (Nokia)" <chia-yu.chang@nokia-bell-labs.com>
To: Stephen Hemminger <stephen@networkplumber.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "davem@davemloft.net"
	<davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"dsahern@kernel.org" <dsahern@kernel.org>, "ij@kernel.org" <ij@kernel.org>,
	"ncardwell@google.com" <ncardwell@google.com>, "Koen De Schepper (Nokia)"
	<koen.de_schepper@nokia-bell-labs.com>, "g.white@CableLabs.com"
	<g.white@CableLabs.com>, "ingemar.s.johansson@ericsson.com"
	<ingemar.s.johansson@ericsson.com>, "mirja.kuehlewind@ericsson.com"
	<mirja.kuehlewind@ericsson.com>, "cheshire@apple.com" <cheshire@apple.com>,
	"rs.ietf@gmx.at" <rs.ietf@gmx.at>, "Jason_Livingood@comcast.com"
	<Jason_Livingood@comcast.com>, "vidhi_goel@apple.com" <vidhi_goel@apple.com>,
	Olga Albisser <olga@albisser.org>, "Olivier Tilmans (Nokia)"
	<olivier.tilmans@nokia.com>, Henrik Steen <henrist@henrist.net>, Bob Briscoe
	<research@bobbriscoe.net>
Subject: RE: [PATCH v3 net-next 1/1] sched: Add dualpi2 qdisc
Thread-Topic: [PATCH v3 net-next 1/1] sched: Add dualpi2 qdisc
Thread-Index: AQHbIbOQiMGHLYed1kOOIHB+N39wU7KOOSoAgAAB4oA=
Date: Sat, 19 Oct 2024 15:59:37 +0000
Message-ID:
 <PAXPR07MB7984195B7980F92B26571777A3412@PAXPR07MB7984.eurprd07.prod.outlook.com>
References: <20241018231419.46523-1-chia-yu.chang@nokia-bell-labs.com>
	<20241018231419.46523-2-chia-yu.chang@nokia-bell-labs.com>
 <20241019084804.59309c7a@hermes.local>
In-Reply-To: <20241019084804.59309c7a@hermes.local>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nokia-bell-labs.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR07MB7984:EE_|AM8PR07MB8229:EE_
x-ms-office365-filtering-correlation-id: a880ee31-ca56-44a5-c755-08dcf0570898
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|7416014|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?nwLZAVdlmCgiZb4jVhEmG7VplASOpm/RJsltpmuBB4cuRqAd/+uKTmemyyTX?=
 =?us-ascii?Q?osKcAPOu1beoHYqiaZdSIPmf0Oi+Bm5GWopKIYLUpNUfo6CbeCicgj6eviNS?=
 =?us-ascii?Q?yYujiFYMGkkagIcERQS36VASSFFeV9H+8g3VfFxX7WjYzt3k9RPVPU58WEq4?=
 =?us-ascii?Q?Nh0kbNcbaqjbjpBeasc7v3/c9UQ7csev+Rkl+vwegZ84Q1rOfKuOam7tTTfw?=
 =?us-ascii?Q?Iqh7nNrm9I+2+CVZSTem7zpL0BOwHdM2thRQAbSDGcLNYSa06+zfFKEO51OS?=
 =?us-ascii?Q?NgFeYJAk+wycaaN3+UWD+wfFVNnxo2A2oyFWWRq8RPcRVHm6O+8Cn9La/3nf?=
 =?us-ascii?Q?d5TkFXS0wrLq+yZWcKHuhC7OCqjm58slPhgDEltAQZgtcTeIMV2wpGaiBQzp?=
 =?us-ascii?Q?UqDeJdAGY/NjGrdC1xgTulQN3IDnUJmwKm4T0a4KFBlS6KiYbK7RyPtzkd89?=
 =?us-ascii?Q?ygbbpCv1guKBBmkCpHIT48lCUu3QWDSGRkMF5FLwQ/vWE6cCkQsJn9+6Gh1K?=
 =?us-ascii?Q?cssHkRWZaT4PUTptLnHFABbQ1+fC8tWQjH9IAj0Hw2tOtCTqvx7ps/zOxE8G?=
 =?us-ascii?Q?+xd1HjdFGRuhq/2ONwiqm1InZH0TpKUUAaojm+KUcY+KuU7Kg19Pq1uvkatc?=
 =?us-ascii?Q?QkZWmJhV3wYzO4fDar71EuMZClcP8J+3ZYzQOTLdrc9p8bqiTjK+IGUN3uf+?=
 =?us-ascii?Q?3v1FtdEE3KDuEVuLWhr00e8zaAoxstt74sz6FpjRqnliEArD/qzz32xZP2f+?=
 =?us-ascii?Q?w7yiBLoXHekBOddSlUNV+iQiQ8hKbBZcPHYOUqiCpVJarfMSlzOcDsV8oMZu?=
 =?us-ascii?Q?TAi/GZCOSgpBf0aAOeqKJqXoz52aC0NHoroMPY83/2/RJwSy5Q6MRwLzGty0?=
 =?us-ascii?Q?tVhsu9qUc9q5ayRJGTPGYitGdOyAFn1hleqQ1NDoAYRy8qJlzqyls+0Beot0?=
 =?us-ascii?Q?GvJl3QdMtF3dTZthJaOCoXePDDtSsAGi8d69GJ8oD7ifG+foSKHKcXEl1Qzx?=
 =?us-ascii?Q?cotbR2ZNQ7VF3ykUUYjdMKWTUtCvToFVgXLUo0QreRlvnLVHoEh+U7+cQuNs?=
 =?us-ascii?Q?GLtfpK3moKgYGn7kuBxx6LYHnvDEVt6y1AM4kd9d0Jtu1drxMTEFRIO78lfy?=
 =?us-ascii?Q?dGTKxaE75dPhU7KCWpthycJX0riGhTgsvb6yfIs2BsDLijSg/Saok8acSdk+?=
 =?us-ascii?Q?YvgFDq1e+E4l5CGVfFtyuMdK8V6O5ve7kVe1ulOKGAk4gLNnliUtml/tGF40?=
 =?us-ascii?Q?PvS11g4Db4iVCSrXm9STbOALwNgCSW5IIloliRXe1NHR3GQ7nI3WUY4Jnp/o?=
 =?us-ascii?Q?tChcaGUFFvqJd5CHClIju1RP?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR07MB7984.eurprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?x+CzjY0reMFlElK7lVkW3vlZHiVb+9yyk+9X+WPvbBdtE8bn9AslJUyDsCxQ?=
 =?us-ascii?Q?tNVj7mEwBoP2iomrieR2R07r8eNdMYDdtbJHaVHriM4i1eNon0frebuoHk9p?=
 =?us-ascii?Q?WB3ycu0FL5EBYNSoAQdK4hb720pPaJNGguOgYpeDfwyHAyWkRgnehYGBLJOF?=
 =?us-ascii?Q?BqD7rlos5Cngt7g0j61wQKz4z1ZQ097/KB7nthpUVJpzheSnxYCoIkCnu3tX?=
 =?us-ascii?Q?MF0q+roGAOUVeNelwUHnUNzaxcDj9jtwXQQLMvig3WNGV4+GlH4z0vUSjr66?=
 =?us-ascii?Q?jvp/O6lTXw+EUd5wMnW12aSR5amiOXKryJV1mRD+5VVGxygODtfKVzoyO+02?=
 =?us-ascii?Q?msLkVplJDJr+v/iXrecllyJM8LkFGmP35BQqk0hgju6G6rdhyzhO+dTiOtQ0?=
 =?us-ascii?Q?fF8WcVfPGWdOwuZZp2ubED41VqChN1t57ukEdRPLj/JO75e5Zyz4qN3j5/XT?=
 =?us-ascii?Q?oSEaPuc4g9BNcfzLw4YdxZgZHni3aw/5BLj98Dxj4+bKXEbHaK8CmMC9mCLW?=
 =?us-ascii?Q?NbLrP+5yF9BDhiU5p9pMwo1HWDwRzQ+qh3pRvRte8t4qbfwr/7McRuiGaY6W?=
 =?us-ascii?Q?V5p6GC47P05AnHJsKq3jFG//uJIi2581xYkd0hqkMVNf9YxJKnZnxDm/qvST?=
 =?us-ascii?Q?1mTQj7AN/7oXFR1x2ki5fKMH0z9fwQAWIJ/VTztUHfA0ABBtlhq2ZfVamBh/?=
 =?us-ascii?Q?xYBKuSEY+72TKH3TXfJN6OIu6k3eTdTrUchLhVjmWV1iLMbIkXO5VbhZUTv6?=
 =?us-ascii?Q?R5WFw8wefSwdustT6WvjSzstLnW2cFvBBisxxQPvoX2f6K39ChwLtanX768a?=
 =?us-ascii?Q?JDML/0dc9XxcrKGaFfi15QyqSWO8YfgpsGf24Ng065TeQFSohyd99pjnwJ83?=
 =?us-ascii?Q?pQwpny3hZdGyUMljLXVYFBoYHJTTb3cleoVfC7J92eAqJah/s9mLLiePUPIO?=
 =?us-ascii?Q?TiKmSwBPzkLOk/hychFd/Pk05uN2xdhlwQKm8WOpCZuzEnVZtS1UNtfpMm1/?=
 =?us-ascii?Q?xbmlDj4D8BGLmyW2XdUOi+V/HWIfUGA6mRToolnCSGbVJmk+T/x7aMr8FApp?=
 =?us-ascii?Q?ez6Ba2o5psM2SAXs/E5jlu7ZR6DhcsP+WJsWgPRNrZ5hwE0G91tp6qMw+Nxx?=
 =?us-ascii?Q?ycdodjBIIMSofTvtoVspfE7JdexRqOrBJaVQfUMsMnnkwO9MEcuUtcJnMhmk?=
 =?us-ascii?Q?1SBRA5fj1CjsC09LczbG5/249+hD/q8tk6EgoCHL6YQILbPyuEPDXaqHrIlu?=
 =?us-ascii?Q?AxFjiTl9y5vfLeTkAjblo5aoZmcQ/tWAuzhtAwiUYv8SjjxIauiGB0jaKcg6?=
 =?us-ascii?Q?nOvVRtH8YutAH6NqBWGDTBoyqDo7xr6tYSC2GcxpDtVH0V7qZUj3VSurVJwj?=
 =?us-ascii?Q?BN1XS3tCjMXBbz8kTRgCfqT6+IjK3JLrrPJQ4VNMOySQ5vdKeY9rdQ/WC8Zy?=
 =?us-ascii?Q?t37gmL6PrW2rFgbsrt4T/aS37Z8r4VAELcKL3uE/8Xyz2p/HEdPwb1MltPmq?=
 =?us-ascii?Q?jXo3gT6lS7pppKLJkTx2qCw14P0wycLXoweQ+wI6U3UUoEcZIg9QsDy9CydQ?=
 =?us-ascii?Q?WDuz3xZnu95xB74Sgm6zvqDu+0LJ8iP12GgUe4eDCCSTHl7bmRoTaJyy20hK?=
 =?us-ascii?Q?gg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR07MB7984.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a880ee31-ca56-44a5-c755-08dcf0570898
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Oct 2024 15:59:37.6592
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LSMMZ1jBaCTECKhNWYH+yfE94GVsRZTT4JShK9WClkNc8DmdXso1tkHfAoopxt1xzmWYw0eaTA9q6NfgqpXLlr/wOv068ItLirpYWJn6ATopnXcTHKQgvq2T+yBvsYis
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR07MB8229

Hi Stephen,

	I will update patch to add blank line after each #define.

	I also prepared one corresponding patch for iprout2-next, and that patch w=
ill be submitted after this patch is in net-next.
	The detail of that corresponding patch is at https://github.com/L4STeam/ip=
route2-next/commit/c9b160b8a02c75a3284b3aa41bf4173060fa5ee1

Brs,
Chia-Yu

-----Original Message-----
From: Stephen Hemminger <stephen@networkplumber.org>=20
Sent: Saturday, October 19, 2024 5:48 PM
To: Chia-Yu Chang (Nokia) <chia-yu.chang@nokia-bell-labs.com>
Cc: netdev@vger.kernel.org; davem@davemloft.net; edumazet@google.com; kuba@=
kernel.org; pabeni@redhat.com; dsahern@kernel.org; ij@kernel.org; ncardwell=
@google.com; Koen De Schepper (Nokia) <koen.de_schepper@nokia-bell-labs.com=
>; g.white@CableLabs.com; ingemar.s.johansson@ericsson.com; mirja.kuehlewin=
d@ericsson.com; cheshire@apple.com; rs.ietf@gmx.at; Jason_Livingood@comcast=
.com; vidhi_goel@apple.com; Olga Albisser <olga@albisser.org>; Olivier Tilm=
ans (Nokia) <olivier.tilmans@nokia.com>; Henrik Steen <henrist@henrist.net>=
; Bob Briscoe <research@bobbriscoe.net>
Subject: Re: [PATCH v3 net-next 1/1] sched: Add dualpi2 qdisc

[You don't often get email from stephen@networkplumber.org. Learn why this =
is important at https://aka.ms/LearnAboutSenderIdentification ]

CAUTION: This is an external email. Please be very careful when clicking li=
nks or opening attachments. See the URL nok.it/ext for additional informati=
on.



On Sat, 19 Oct 2024 01:14:19 +0200
chia-yu.chang@nokia-bell-labs.com wrote:

> +config NET_SCH_DUALPI2
> +     tristate "Dual Queue Proportional Integral Controller Improved with=
 a Square (DUALPI2) scheduler"
> +     help
> +       Say Y here if you want to use the DualPI2 AQM.
> +       This is a combination of the DUALQ Coupled-AQM with a PI2 base-AQ=
M.
> +       The PI2 AQM is in turn both an extension and a simplification of =
the
> +       PIE AQM. PI2 makes quite some PIE heuristics unnecessary, while b=
eing
> +       able to control scalable congestion controls like DCTCP and
> +       TCP-Prague. With PI2, both Reno/Cubic can be used in parallel wit=
h
> +       DCTCP, maintaining window fairness. DUALQ provides latency separa=
tion
> +       between low latency DCTCP flows and Reno/Cubic flows that need a
> +       bigger queue.
> +       For more information, please see
> +       https://datatracker.ietf.org/doc/html/rfc9332

The wording here is awkward and reads a little like a marketing statement.
Please keep it succinct.

> +
> +       To compile this code as a module, choose M here: the module
> +       will be called sch_dualpi2.
> +
> +       If unsure, say N.
> +

> +/* 32b enable to support flows with windows up to ~8.6 * 1e9 packets
> + * i.e., twice the maximal snd_cwnd.
> + * MAX_PROB must be consistent with the RNG in dualpi2_roll().
> + */
> +#define MAX_PROB U32_MAX
> +/* alpha/beta values exchanged over netlink are in units of 256ns */=20
> +#define ALPHA_BETA_SHIFT 8
> +/* Scaled values of alpha/beta must fit in 32b to avoid overflow in=20
> +later
> + * computations. Consequently (see and dualpi2_scale_alpha_beta()),=20
> +their
> + * netlink-provided values can use at most 31b, i.e. be at most=20
> +(2^23)-1
> + * (~4MHz) as those are given in 1/256th. This enable to tune=20
> +alpha/beta to
> + * control flows whose maximal RTTs can be in usec up to few secs.
> + */
> +#define ALPHA_BETA_MAX ((1U << 31) - 1)
> +/* Internal alpha/beta are in units of 64ns.
> + * This enables to use all alpha/beta values in the allowed range=20
> +without loss
> + * of precision due to rounding when scaling them internally, e.g.,
> + * scale_alpha_beta(1) will not round down to 0.
> + */
> +#define ALPHA_BETA_GRANULARITY 6
> +#define ALPHA_BETA_SCALING (ALPHA_BETA_SHIFT -=20
> +ALPHA_BETA_GRANULARITY)
> +/* We express the weights (wc, wl) in %, i.e., wc + wl =3D 100 */=20
> +#define MAX_WC 100

For readability put a blank line after each #define please.

There are lots of parameters in this qdisc, and it would be good to have so=
me advice on best settings. Like RED the problem is that it is too easy to =
get it wrong.

Also, need a patch to iproute-next to support this qdisc.

