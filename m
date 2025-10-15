Return-Path: <netdev+bounces-229563-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 39AC9BDE40F
	for <lists+netdev@lfdr.de>; Wed, 15 Oct 2025 13:24:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E3382400DC4
	for <lists+netdev@lfdr.de>; Wed, 15 Oct 2025 11:24:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CF483203AB;
	Wed, 15 Oct 2025 11:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b="hboWjAOh"
X-Original-To: netdev@vger.kernel.org
Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazon11010027.outbound.protection.outlook.com [52.101.228.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86A9330DD15
	for <netdev@vger.kernel.org>; Wed, 15 Oct 2025 11:24:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.228.27
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760527481; cv=fail; b=Z5PK663WIB4NzCKlQYEMYfHLla0PWBlMukyq0HkSG2k8JTvGNg+FQanok2p05+5SWltNwzUN/62Js/BIr64vIr5y5JGDcDmcMP4EUCBOog49cq0aC7EXXMSLTzxb5t8lY0z1Sl3hig9txlANLaeUATS/14YlEknhiAb4D0rerro=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760527481; c=relaxed/simple;
	bh=zMLT/Zg/JOX2SY5fX3f/wFvJEJme6AzUGNJO5CzhRUc=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=hkUWRSSoTsLzSrd82i2ztxsMlZ7yPGjH3s3o+qMzP29il1YAU81nXFOkMAeRldx2PeYfp66xa/3he4NvYuP913qIzASBzFNm1ZTG6+0Tj8xzyUyHbFSFbv6hQqhMqEjRzrWvWDEOj9a1vs3J6IzBc9Kv9l3g8TJWqAW4f83rcpg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b=hboWjAOh; arc=fail smtp.client-ip=52.101.228.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=te0fSxSMPetQgfV5DpQwKDKSX+RDKo/vOLTWimStgF6UPecePV1pnI8D+Voz55oLrcE23kIr6CkvAXneknkW1f8dPQ1+Q0NQ6HtbWEUJpaRVqANZ8PNPEB2b0H+Xrk2xBvzFHzejwkKAWa2vUW+etkVEkyiK7cqudSE4CjW+WIVRhnFwViWS0hjHy6az/6EWnKppPNlTHRmcs8LuTM3Oe7+5umMMHF7Viy51bsePqSSjFlLv3sQdRyRFxcZUlsU1P/aUD8sXHwbVTS7g5wJGTs83c8GtqH1v3H4rFcMRO6Rj/X9wgn6rU5vZihkt+j8YFx2N6DquxZ2qiDCWqeGBZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zMLT/Zg/JOX2SY5fX3f/wFvJEJme6AzUGNJO5CzhRUc=;
 b=rF1fzhs8+vgYg4Pffl1XkN8Wm6gIa+bvZoFOZTVG8XOMoGVQ7ftCKuVyEul1DaZ0uCNmBLt509IocAkEw+TvBY1BuFoj65kYx7Rnz+F+8FQv/YO/r7Qh4cPV0/9O9aFSl7e41R5gdtz9ua6hMjoEaYgVI8y1tcRLTpKEa/dqUWHWstvQ9Sgrf1WiIQBDSO07sJl+BqE2lCPBwLunFxBgaTK1Mq/dJgX64bDYVzR8K5OjRt2iiz1+1Uj6gL6hL0XUyb/jOyM+pbFeMDNTeMLPp3KReE63KNKS7MZ8YK2CxcRBnkAhr9mCjiLZ5fy/9JT07saHHlF2+6pZ05F3xQHXTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zMLT/Zg/JOX2SY5fX3f/wFvJEJme6AzUGNJO5CzhRUc=;
 b=hboWjAOhwUGUtjtCRQ+bNplT5iX+Fen9k3Bz+HvNLYrjtxLp7eji/3Y3kcldOUdUmUzmAOLeZJPzyBxNnMnw5dTQdotoO4zYIlJwrEFg1ZoKgH2qV44ojHjb1YLXGkc5pztSMUqmCoJ2Ol/eHgVT0ImRDdIj1yVZf7e66xCbV8U=
Received: from TYCPR01MB12093.jpnprd01.prod.outlook.com (2603:1096:400:448::7)
 by TY7PR01MB15391.jpnprd01.prod.outlook.com (2603:1096:405:23f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.10; Wed, 15 Oct
 2025 11:24:36 +0000
Received: from TYCPR01MB12093.jpnprd01.prod.outlook.com
 ([fe80::439:42dd:2bf:a430]) by TYCPR01MB12093.jpnprd01.prod.outlook.com
 ([fe80::439:42dd:2bf:a430%4]) with mapi id 15.20.9228.009; Wed, 15 Oct 2025
 11:24:36 +0000
From: Fabrizio Castro <fabrizio.castro.jz@renesas.com>
To: "davem@davemloft.net" <davem@davemloft.net>, "edumazet@google.com"
	<edumazet@google.com>, "kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>, "andrew@lunn.ch" <andrew@lunn.ch>,
	"bigeasy@linutronix.de" <bigeasy@linutronix.de>, "clrkwllms@kernel.org"
	<clrkwllms@kernel.org>, "rostedt@goodmis.org" <rostedt@goodmis.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-rt-devel@lists.linux.dev" <linux-rt-devel@lists.linux.dev>
Subject: Query about the impact of using CONFIG_PREEMPT_RT on locking
 mechanisms within networking drivers
Thread-Topic: Query about the impact of using CONFIG_PREEMPT_RT on locking
 mechanisms within networking drivers
Thread-Index: Adw9xY/b5NfpgJ5gTyajqPRxZdkzng==
Date: Wed, 15 Oct 2025 11:24:35 +0000
Message-ID:
 <TYCPR01MB12093B8476E1B9EC33CBA4953C2E8A@TYCPR01MB12093.jpnprd01.prod.outlook.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYCPR01MB12093:EE_|TY7PR01MB15391:EE_
x-ms-office365-filtering-correlation-id: 71113ba1-4c9e-45d5-6c90-08de0bdd6bf5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|7416014|376014|1800799024|38070700021;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?HwUJmvYl0IH/KOhJCIJHQNEto5LlAyM5dI/ZnU6Uux5Kh4Rm70+OCXprb9qe?=
 =?us-ascii?Q?BU+abkb8NruAr9p+Xaa2E9SGbk1QzpukDM1tgQV+koy7zHElUCmMbXwzFem1?=
 =?us-ascii?Q?hXbDI6e+mNaZG8j7n8JwcWZSsSxiV4zjfWjTlSUsJsD0HU1qi8fqsLtKbFU2?=
 =?us-ascii?Q?3DXvvRQOBk8jcdhCI67KekZDcb/rcevPp1P0XzOPYZzrzXDm14Pd6EYUGqjk?=
 =?us-ascii?Q?ZKCsqIiMcG2xDzCIXHz9BwsbaVsR87PSoz8FlgkuflCyq/+NknCHWFcBUNFp?=
 =?us-ascii?Q?iGTVVGFZ/9BlbUvG527ZFy5IQdT4rAuqscmpzZJatIBBPyi+OzbbV85LJpx3?=
 =?us-ascii?Q?oYZYjGxsqcl1Qn9Uu7J74EISw1QfoZpvB3CpOCIurpHb7WP4owmuSxcaewbq?=
 =?us-ascii?Q?pqBISLd96wR3zS3iNzUqLKrfkoB+xuqGMDLupXxNSp5wGIJk97fNRCJ3zfHL?=
 =?us-ascii?Q?JE8nCjPBTO0jtPfFwvHFfTYU7oTExbgElAqB8ZKNN+UMoWo+0mwBmQfk8rB5?=
 =?us-ascii?Q?wgcbWTsF++WUhXt/q+0gzotPtlvSwsXHMnPDbbGQFDHoi+2NXUbw7nRsJUV6?=
 =?us-ascii?Q?BVRxsdmHOp4E2u9AxfxC1IGQBZet3GHgzOPPEQp+kset7pcOQ4FKeWtlbU1R?=
 =?us-ascii?Q?1brTdYJV5/BixjQ6e7P5iHhrbqHhnbwrIDcaYh45gOs5UeNevO8mrw8fwKgS?=
 =?us-ascii?Q?E8nfWZ/o4TCD1oWFJO2Ub95zCAPCQdC9SepriexPs08vgren6hgKWaLhh4Ao?=
 =?us-ascii?Q?gvCRKJjA3JT+hhxPVzx9M0mg5bsVlLQs46e9VobJz7IAZyJcKjCY6g2EOLmj?=
 =?us-ascii?Q?k8bPGJcFVaE86IRTqnG2wx+5a42fSib42qV3rTnhYOLJsavEP/fL5ALO3ctc?=
 =?us-ascii?Q?OqG5CnNvob3NmtJau8hhiYJphE46HLnIbPdaTX6WOvcZ2haTWM4N/G31cX5d?=
 =?us-ascii?Q?bqtkVAEBzxq7YNx5BhGAbsn2k80CDKQMFlXXMbqBVSMnowQ+IKegwdcc/YW2?=
 =?us-ascii?Q?ApI1lwOCSewvAW3EKN2y1c+V9+XGwQD0YIKLp8ZOCmKBbjHit8xZzTsUkz/G?=
 =?us-ascii?Q?DBdekGq0Ntc0DccoGW+88c8ee8NVkE3x5gXVtMp+a+sl2O90a/96tHHqcBPr?=
 =?us-ascii?Q?lnDYXm+pmKJGFvGVkL9b7QgyIaKwqaSQm5IWtW9pq/1fTr+ZAWyH2jNpzhhc?=
 =?us-ascii?Q?3gcQ/0GG90eKQ5Uzd5+TvZWs+Zv3/OM/zt5hoRwzYF3YeeGeJSokHof2zxd2?=
 =?us-ascii?Q?+heYxkamv5pGfVnUarpytkva8RUuOiNL4EUncP6d5e3Gk8z1V8x0qg9MKNCL?=
 =?us-ascii?Q?E2UICF0zADza6q9QxeO4UeiG3213UqUbr6uW/LOZNWrZxDCabKWeeXffD5u0?=
 =?us-ascii?Q?XsGmZNTjPOlJDaxLYkf8tF5l3wn4LqvJPwAZqGk5R+g+4cHX5UGfGsYM1Cte?=
 =?us-ascii?Q?YMQcDYAehkcWvuPPWQTsvdly7zX8Gagqtasbovb0nV1PIvutrXQ3vDNa4mKJ?=
 =?us-ascii?Q?yy10CojWdW1gtnAw+lKhV4lNELicZF8ZasV1?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB12093.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?Mr9sYV7tQApDRNaS6XK8zdhtelN9v0V1/uCPOj3MoWYNHqRhtg+HL2x30JjW?=
 =?us-ascii?Q?m99Wf057FrfSszTvOojNyu1IJV3wgDvty43xPNl3C7l7IIMAiqQwjcGqeHj+?=
 =?us-ascii?Q?CaQO4QpCegHbaZN+Ouer7x+OgeymIO5pabVXcjYMPjjvDi58pdt0blHAiB/2?=
 =?us-ascii?Q?iLPoM9/TUl3T3zLgSncMbGjZ8ze34pdflhnl4oi+d/tJVj0uHeXylKg6TCRA?=
 =?us-ascii?Q?ZpkNGV7EejuIvWeK8xWxl0/emOvx/xO2UfDT9v3AfepSk/jL+ZfBZZ/ohmFg?=
 =?us-ascii?Q?qkPoU6jHlryNF3aDIcJL8eQg7cPMBYgX3PrZ8bW/4yHmJ65gMHDp+HDIOg8Z?=
 =?us-ascii?Q?/ol5nsEAc4Rcb5MxNro+AAwaCPatyxEqPuxtxuov5HeZZyKoYLe2u9Xccv16?=
 =?us-ascii?Q?wfyDaEA/w0hKQwzH0P9GEtZLWQvhxz3Gg1CVH4h9KGf6FB/31twR9r8TxNFZ?=
 =?us-ascii?Q?2Ke2hwUVEF6RavgWMMOgpnm9MP2d6OpguX5vOCDTBVwCr1BFG/oCUX7FcF5f?=
 =?us-ascii?Q?CCtt06QAubbQgWE3h8GaFfFHfePmPVHBN5z+rdQo0Zk+YXLFUcF0oHlF7ogG?=
 =?us-ascii?Q?zBGtF0hsfMbnI0X2QCzhAoBLG7ahGmkLajKmE31ra3aXwyO9TwBIwuFsxXKk?=
 =?us-ascii?Q?vwgmn0sKSdBwoGM7oRmZGbb4x9GraHywAevScniP2UZi+1X5wBHADxhQVt7/?=
 =?us-ascii?Q?2gu/AchSsTXvzWU08Zv+fVTqs7hnDg2+AMWw6/kh4mrw9RAi34AygM9gfFew?=
 =?us-ascii?Q?D40WRaVlLBDUTjCAAbMmRHIz7LE9reABygLxLSraF9cbWvcuq8K07X/rCWP9?=
 =?us-ascii?Q?i66DFiqpF9xmlGQc+kSariu3MErizKaSYFaVH788Gtvvs1cjsF+Lf8hcQ2w/?=
 =?us-ascii?Q?2RExRaffz73WtFwvOqJ+FcX0eEtQus9JKoj+Y2u2YP1QoxeYzLlaHssrgq+H?=
 =?us-ascii?Q?xyWVF4qlLR+p9BIY0edqYRY/VQd4i7OQS6dSMOsT1L7rLy3yib2+38b5XliH?=
 =?us-ascii?Q?9QXvCoAmRHiei/EqJkX+gY9NTMbQ1M9myQXzzqP8ahDZdeoqZNnxhHeA46ka?=
 =?us-ascii?Q?0wWJQBm4aAyMJmAWEayK5QY0+cLfdfHKgtDSH4IUQ+KIWSfM6qXNi3Tgr96a?=
 =?us-ascii?Q?Mx1a8o1JKYA96vRqSAyMGbt21LkEFpqZF6HFklp37MaaSuiaD7w2oyasxeVU?=
 =?us-ascii?Q?pmPXDMWNxm2EOE7AkSQJJkuMYdbqJOIXAfecnlmjYlZhkQsvgynJTD6moiJI?=
 =?us-ascii?Q?RdHMMKaCAGOYytvSYmEDK3nJzR0zJCaazcsgKX13DKiVZflYFaKQLWBnX7f/?=
 =?us-ascii?Q?sREYHZN0dYDKiZG0oyvND8eGPUnDv2gHBX2xo4TgGBiOO6ImpcQGEtXkTqrK?=
 =?us-ascii?Q?8/NmtvMMwE6PkgUevhmdm/Z1NJNB+qcF45Eb8i7HKQheaj0xfrLXl2axTUgd?=
 =?us-ascii?Q?oaJrERD2DVVOIntjgqtgm8LOPJrbP49fB9mPdvi64nZt1BL/+2eT0IpvsXJ2?=
 =?us-ascii?Q?ED4OwhcHrJpSVFHv8zN+15xl1Bgbgjs7nO2dDZtWvrorlo2tf+Qlkajubb4Z?=
 =?us-ascii?Q?W3pp2XWBJa8XtgEJpNyMIwQQ7yqpMi5LxTXN48LEvWW1ryTHsFLVv8Brb1XY?=
 =?us-ascii?Q?pA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB12093.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 71113ba1-4c9e-45d5-6c90-08de0bdd6bf5
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Oct 2025 11:24:35.9968
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gimPtM8QDiY8/XWDNQnj1v+lIyDTdYKN7MRCqqHP6vXEc2IVdBP2PawDtN3SznRAEFYAr//gy+ohXvNucvxMHTqYcUepJyrXbki8q7BesPM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY7PR01MB15391

Dear All,

We have recently started debugging some issues that only show up
with the kernel built with CONFIG_PREEMPT_RT=3Dy, and we have noticed
some differences w.r.t. the non-RT version.

One of the major differences that we have noticed is that spin locks
basically become rtmutexes with the RT kernel, whereas they are mapped
to raw spin locks in non-RT kernels.

When is using raw spin locks directly in networking drivers considered
acceptable (if ever)?

Thank you for taking the time for reading this email, comments welcome.

Kind regards,
Fab

