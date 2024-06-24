Return-Path: <netdev+bounces-106157-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 19F69914FFC
	for <lists+netdev@lfdr.de>; Mon, 24 Jun 2024 16:32:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3C6EC1C21D7A
	for <lists+netdev@lfdr.de>; Mon, 24 Jun 2024 14:32:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64F6D19AD5C;
	Mon, 24 Jun 2024 14:32:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=silabs.com header.i=@silabs.com header.b="OSTu6s6C";
	dkim=pass (1024-bit key) header.d=silabs.com header.i=@silabs.com header.b="eIIltfhT"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0024c301.pphosted.com (mx0a-0024c301.pphosted.com [148.163.149.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D77C219AA75;
	Mon, 24 Jun 2024 14:32:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.149.154
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719239558; cv=fail; b=M0vEabnBvqvUREy5phD8jndA61GZDjUc9H53wzjOcy6K/pmoClQK/tw+T+j/MxS2whfaziu4HqnB8P2S3TQCs4tPCmvOmFwaHbzKxVAIu4iaOZvCFl9bb8jE0/EZum5BZ32CtThfaMKWGUiuwHsFMzTn1obIdkUYLwhGfzDzctg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719239558; c=relaxed/simple;
	bh=QqtdTgNKDbGi8f3sjq6SGjA6IAg+4fwges695fR2Y8A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=jY1l3lzFrlkW6pfN3KLhp58XSJ80myB0YcYpXwzGTt9M09fMyqFNe1cbEW2Nuxu5GhlWlo7g8FHRFGhE735NUxXxCE0lMlOCfICXxj6GVfjos/aIVrCjUDpWBOv4CgTov4OB9WoGULc21EPwmYCOsge8DkL5/cDHxpMXqXzZbRE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=silabs.com; spf=pass smtp.mailfrom=silabs.com; dkim=pass (2048-bit key) header.d=silabs.com header.i=@silabs.com header.b=OSTu6s6C; dkim=pass (1024-bit key) header.d=silabs.com header.i=@silabs.com header.b=eIIltfhT; arc=fail smtp.client-ip=148.163.149.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=silabs.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=silabs.com
Received: from pps.filterd (m0101743.ppops.net [127.0.0.1])
	by mx0a-0024c301.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45ODYZZr011774;
	Mon, 24 Jun 2024 09:16:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=silabs.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps12202023;
	 bh=QqtdTgNKDbGi8f3sjq6SGjA6IAg+4fwges695fR2Y8A=; b=OSTu6s6CTwqz
	mm/shboKOOxR0rY2RUYjZ3sus8a/SN2NSvhnN/g+7w8A6xhQp770lmhsdVHGw/ZR
	+Hsq1eteUrjQzDB+J+wJLUsSiH4lep+vIrqMpXEcrZ52xBE3T6bXwP07e5Dm9QI8
	hf3sZA8EWUjKEs054x0nzX5WXcejiv7yZutX3SNghQFjNfnD3b/caKHOSTutPbK0
	s/nEQBypQcspDj9jlhgUA+5T8lKyLc9AEqVKiYKvefldAxytlX7iZI5H73UlYE2n
	jEugDFYin6Sdd8u+NayzmkI0e9Wq0wq0igN492RA+Cm9YcGIC2irVOggFUmvckwz
	70grcoiQvw==
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2169.outbound.protection.outlook.com [104.47.56.169])
	by mx0a-0024c301.pphosted.com (PPS) with ESMTPS id 3ywtx92e3d-3
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 24 Jun 2024 09:16:58 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O/0Y9GyAT7/FGT0aGalTE0hEea3U5VFV6I0fUD66xpNEg688/6AL0BOWAbUpHNWBjSxia0i8A7ZO3XIW/irklaVmz2Go6HKxWRJQAwazJb5geyggj/oxEP9on//OpO1SFKDuEQ04WsFWrz3PPBlcv0Krg87d+Feqgx4cvlP9Zjy+sQs6fBC03jy5tJ8fuAhjVbavONDo3A3POykpF+rd6QFtLOkY1SdzibGKidrGotpM9Z+S7ZDJlrXdJGg2BxogdqlfSL1nEY0gvubRItt0zzMehzO7HV5Sk3LzxcW7d2WAMCCDLTFv+aJgFgpDfRYGwg1i+UbegNunWitNr5/Drw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QqtdTgNKDbGi8f3sjq6SGjA6IAg+4fwges695fR2Y8A=;
 b=ZFwoSVsLldoeOvPkDArLLGCYoC0NDiDg+3KFOoDwbuu1t4QkFtZrpRfe0jLa+4py7zTNRWlo/Ja+k0i6FHeA7xFLUu39SvAm2pvIAeUVkRTia/NCDl7nA69O0Br2eoVwl3TVhlb7Yt1Qoq70i3KCiVxSq61HyOW8d2/aslnXZswl9uUWi0lpoAtJ+XkzbXYGSuOQ88BvNiqoI7dka/YMnxIJhsPjTdE12zTE2+WyTCQVIeeA5f3WsY9eFekS0+MM759JwHPUBIlSXRg+4q0U3s8VRwteI1iDST9Bb/ep3fpZOx4eO7n9XG4MhRHy10tGffF9jnedNR7o69JHgYNLKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=silabs.com; dmarc=pass action=none header.from=silabs.com;
 dkim=pass header.d=silabs.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=silabs.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QqtdTgNKDbGi8f3sjq6SGjA6IAg+4fwges695fR2Y8A=;
 b=eIIltfhTqMmIntWi+4M7Ab6ktc3p7cYuGz1ksCRlcynNE6pObBhypAM6Hl5bPO99MfeIJJnIyyIqMnXJIQLytPML/eqWAL5qY8Irt+EyRzsqOG317ZzNoF8ybPoVa1LJ7lJ2O6FjRmdUtNz+doK0PmPoUfwHeplZ+MmtConle14=
Received: from MN2PR11MB4711.namprd11.prod.outlook.com (2603:10b6:208:24e::13)
 by LV3PR11MB8765.namprd11.prod.outlook.com (2603:10b6:408:21d::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.28; Mon, 24 Jun
 2024 14:16:55 +0000
Received: from MN2PR11MB4711.namprd11.prod.outlook.com
 ([fe80::592e:a53b:e0b4:5da7]) by MN2PR11MB4711.namprd11.prod.outlook.com
 ([fe80::592e:a53b:e0b4:5da7%5]) with mapi id 15.20.7698.025; Mon, 24 Jun 2024
 14:16:55 +0000
From: Mathis Marion <Mathis.Marion@silabs.com>
To: "David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?J=C3=A9r=C3=B4me=20Pouiller?= <jerome.pouiller@silabs.com>,
        Kylian Balan <kylian.balan@silabs.com>,
        Alexander Aring <alex.aring@gmail.com>,
        Mathis Marion <mathis.marion@silabs.com>
Subject: [PATCH v1 2/2] ipv6: always accept routing headers with 0 segments left
Date: Mon, 24 Jun 2024 16:15:33 +0200
Message-ID: <20240624141602.206398-3-Mathis.Marion@silabs.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240624141602.206398-1-Mathis.Marion@silabs.com>
References: <20240624141602.206398-1-Mathis.Marion@silabs.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain
X-ClientProxiedBy: LO4P265CA0273.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:37a::10) To MN2PR11MB4711.namprd11.prod.outlook.com
 (2603:10b6:208:24e::13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR11MB4711:EE_|LV3PR11MB8765:EE_
X-MS-Office365-Filtering-Correlation-Id: 284320b9-0cda-4ecc-1a9e-08dc94584d3a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230037|366013|52116011|376011|1800799021|38350700011;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?4JWu0cNAExAuYGbp0ejJX3nQmQzRfaGzilxWJiihPNgjrbHi4LrPh40a1vhb?=
 =?us-ascii?Q?CYH5solMtsz3echFxBIpGaN354ibRIb1TEVkarcoT9FSPsUwVBuTG3/YBqN1?=
 =?us-ascii?Q?IEVAV5m2WtTVbWsTsjdx7wl0Jta07//+yF8vNG5IFVlv4kvYw7tov/djrHh7?=
 =?us-ascii?Q?+I54Vek4NBjgf/lrgDKS5KB6PGgwl/vl0wqy9cBfWPe06yj1YxdEmgaC4NIw?=
 =?us-ascii?Q?WkmBXQ0D9RpdJoIwz8sU4rsDkTAKMZf2XFkfh6buRA6ZEAqiYJH57bMY69Gy?=
 =?us-ascii?Q?0VfRkPI20NKhw8bjA7oJeg4yx1tY9F7IETzxaf9sT0ysOSXXfWEKoLNX/vAB?=
 =?us-ascii?Q?PKTWTlv+INrk0lSE2bbaCdEcPrQ57AwNBLWTd7Q01e1qNeicLsxarfElvsQs?=
 =?us-ascii?Q?BBaRCwSw/n7M2zCIKjO7sSCnon1AyQam1GzcEu7LVvkDPX/CHDe399HjHtWC?=
 =?us-ascii?Q?saypJhU7sK0zo099lGBNx4gk0HJ8wNzoIOhYfptM/JtU6q1PNvs4gfAfD13a?=
 =?us-ascii?Q?wKmsg5gw5AudrNTCu/yrscnSrkmJa9T4o2uc/lLjxKq0Hm0s3lmWJKtz27Y/?=
 =?us-ascii?Q?ppepooz0b3fQCZDCB2VEpbArqBJJx33hGesBW7ZJS2lV5NiWuPGq1arbCWnz?=
 =?us-ascii?Q?wg3EkP9XebSdobEvUQT+c9Ij4SwOCL+mRtA/Be4gzVZeJjdHjAeM2Sdn+Wkf?=
 =?us-ascii?Q?8X62fy66pr9XbQY3HpJw2SY6ZpoewvPk2BkJCfVrTi8dK1edOahg9aSjpPFr?=
 =?us-ascii?Q?KnemPiunbBNPPoiNvAW7dAL32+KKrYAHMEGBoizTBy9pLorh5t/5Ka+BLIEP?=
 =?us-ascii?Q?kSRtRaZgsYHHpaSbyRrHgg+wN87tdLn21XUoPcuhIG8N+zuZerKxOLDCMcae?=
 =?us-ascii?Q?eE74lXobUcy5Z3tPfYL2jFAaxw3QCcaHi3M3atby8PuMsyjLcyHRul7mpl+F?=
 =?us-ascii?Q?XBKJDPqIxoKdzBPlxnBlGBD3lf/0V2v3yhpHoYKCK3bBklzfoXwNq/ANvPxK?=
 =?us-ascii?Q?In000WBBlEnXjH3TQlTxzN8Jx+CiTPjLreZgFHC4w1WYpUsTPPoBmIuPsoj9?=
 =?us-ascii?Q?/tcAX1poHW6HL31l2YQZ5vHDMf1TCLCgojkY2xJY3np5cHFPmbok8hdB/KDz?=
 =?us-ascii?Q?qR6a3NppFQGWshB0d8a7WaJOFDSuD2dysstw1fWlbplo8p6ipkQp8RbPUxtn?=
 =?us-ascii?Q?MqLTeiXBvV2zR9F0TL75KetJrUsrGObPmZKovG06WC2XBsiHWeAHIjfvkBgn?=
 =?us-ascii?Q?3DbkrTn4h1YENt/2ZMbMT1GXM9kh4OjmBgtYWB7QkJr0XKr7iyMxQLMj2y+Z?=
 =?us-ascii?Q?z+pXrwOcVlwc/1Sx0wanJlBzHFCxOqQEHqEtf6P7qlYIl47K/lZ93bhEETUA?=
 =?us-ascii?Q?dWCK4rA=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR11MB4711.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(366013)(52116011)(376011)(1800799021)(38350700011);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?S+VpGuHl36j4HQHPSbu8q4HbD4mgWb1geQxrMi3vt9cRFOml2Cf7Q3kQbmNR?=
 =?us-ascii?Q?xpsBNcFRSDDQmT+fKrEnBHpjIj2GGzWhT7S0VZDDKeUDa5p0JCp2V16LpMHL?=
 =?us-ascii?Q?LZt3UqtCsWcYo5mAU4XhcZSXMJhGQoClbFs0TV5m4ufpErLdPr7twA61bcsH?=
 =?us-ascii?Q?s64dtEGLooXuLhEhyTrnBZSpi32UnjwF0EfLftrtI91/a/1RKm6hz+Ir4k5r?=
 =?us-ascii?Q?0yVM9JGPw5lGr8mi51a0tJWvkBhIg9v1+1cBF+fmnLDTQQKY3I3T2XpwdLE9?=
 =?us-ascii?Q?biyD0YpHPYlDL5A6RYtJls9ooI2PXdxy+Fa4/zLLyaWuY8c9RbWAEZFbmDft?=
 =?us-ascii?Q?uX6Wf4JKUAaFMn5tGzZfy/P7tmNWhYQfzAYq9Dh5VD4gkM4B/PbYP1Lv5OJk?=
 =?us-ascii?Q?XwKlnKwo2a0x02TcojKQjI0g/rs1xBjqSAlx4l93jt5dTLUIzZlDsFwB4bvq?=
 =?us-ascii?Q?EOqlGKAG/OzMct5xwRQTllcUH1vfgB6Ult6FkyHTtZUE9AwOZo0tvhaGfEts?=
 =?us-ascii?Q?/Fxc5YsXgVImVs1jW54CmRHA7IwzF1hQ4IBsP1BuhTaqhGBss6SDzVwwUk35?=
 =?us-ascii?Q?GfAID0dQI6//lliD+a96hO4bxxftRU7+XbNZ+di7xCteFTlLMpnL+MGaOn1D?=
 =?us-ascii?Q?SiAxiUZzxHTI9txMAQCfbxzZw6OjiBOqru5J9Z9nogo5pX9or0E9jAiBhPbH?=
 =?us-ascii?Q?kgrGuHM9uSfsZYVU3IoXnVpJXrDcaShaQScDWxaEgfhTBgxICNDgDqikX04R?=
 =?us-ascii?Q?ghfuAjBXZUIPy7SRvOfNdfS1Hvy5A/GWHkvp5iDZ7pda4I7/ATEcZnM+5v0P?=
 =?us-ascii?Q?r2IrYxak8nih+Vpwva5MVGnXmTWxBflHTg8iKQzYo8APiBkTryrlG5Rb9MWV?=
 =?us-ascii?Q?PaAtzZaDDbZ8sfn9SLwLGIkfGEXIlfBzYOlXXhMV6sMX+v8o28lOBj8g0NuO?=
 =?us-ascii?Q?caotSiZ4RuZ8AtOn7wktAiELhyHyFBd+vL425TJVz5BpH7AOQW1PG4NrMCND?=
 =?us-ascii?Q?V4t1lU5pzwp19qSCx+MWFXRVZ8cgCqSlPao7WYR910uW/In+73rsg/X2a58j?=
 =?us-ascii?Q?PRYV9TKUmacpzmCoM7ccWj5IVgnaV+WQIrtg5pkLdFy1muqOQShF2vdAnEMs?=
 =?us-ascii?Q?Rgb1xj9UTPqqYPe2bm9CJZb7zSwqm3dhHz93VXqyrHcWIh9g3gBPtwtvY7tm?=
 =?us-ascii?Q?rI0EZORnXOpXpSQaUu31VEHmSYRC21fnTV3VvmoxDLP1Cj0wzBc+zwscPi8/?=
 =?us-ascii?Q?uSU/Agv61f/H05NhtCHj7mFxizGBlN9dehfOFGNb0nMSm08xnKukXt6MGjpP?=
 =?us-ascii?Q?2Q7MR05LAbCryMilczMcbimBZzQfXYfKGKBn+pQmQbsKiH0P1EE5xqSWpmkW?=
 =?us-ascii?Q?4/Se4+fNRszRoxoqFgj+205FpAcIigwMDuV8h5g836IGsNjktkZSBnTdNNRz?=
 =?us-ascii?Q?nmZ77Z7sKhVmP8+ayMYmbKIqYIfZO1vufb5kGli/I4uvmY6X6uEppk6/113R?=
 =?us-ascii?Q?vYiZwvOvP1sJYHq4ED1JtgRNuOb0riGKSt6ZoJQJjmsKdrb+fqZ8s7W8VH+C?=
 =?us-ascii?Q?kCDA5QHUM/50umKaKKa1H/kqj+Zt8LDgvI/Wd2Co?=
X-OriginatorOrg: silabs.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 284320b9-0cda-4ecc-1a9e-08dc94584d3a
X-MS-Exchange-CrossTenant-AuthSource: MN2PR11MB4711.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2024 14:16:55.4769
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 54dbd822-5231-4b20-944d-6f4abcd541fb
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nce6Jk3nMYImjMDIRfEniXSpzC5nueeX5OERQ/qIemS6aLbYtGwJds/26aeQC5RLtcDb9J/zCKZKUW8eifNR9g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR11MB8765
X-Proofpoint-GUID: DGy_j0N5su2MPzWiPPzvS90sb2zP7eiO
X-Proofpoint-ORIG-GUID: DGy_j0N5su2MPzWiPPzvS90sb2zP7eiO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-24_11,2024-06-24_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 clxscore=1015
 priorityscore=1501 lowpriorityscore=0 mlxlogscore=999 mlxscore=0
 suspectscore=0 bulkscore=0 phishscore=0 adultscore=0 malwarescore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2406240114

RnJvbTogTWF0aGlzIE1hcmlvbiA8bWF0aGlzLm1hcmlvbkBzaWxhYnMuY29tPgoKUm91dGluZyBo
ZWFkZXJzIG9mIHR5cGUgMyBhbmQgNCB3b3VsZCBiZSByZWplY3RlZCBldmVuIGlmIHNlZ21lbnRz
IGxlZnQKd2FzIDAsIGluIHRoZSBjYXNlIHRoYXQgdGhleSB3ZXJlIGRpc2FibGVkIHRocm91Z2gg
c3lzdGVtIGNvbmZpZ3VyYXRpb24uCgpSRkMgODIwMCBzZWN0aW9uIDQuNCBzcGVjaWZpZXM6Cgog
ICAgICBJZiBTZWdtZW50cyBMZWZ0IGlzIHplcm8sIHRoZSBub2RlIG11c3QgaWdub3JlIHRoZSBS
b3V0aW5nIGhlYWRlcgogICAgICBhbmQgcHJvY2VlZCB0byBwcm9jZXNzIHRoZSBuZXh0IGhlYWRl
ciBpbiB0aGUgcGFja2V0LCB3aG9zZSB0eXBlCiAgICAgIGlzIGlkZW50aWZpZWQgYnkgdGhlIE5l
eHQgSGVhZGVyIGZpZWxkIGluIHRoZSBSb3V0aW5nIGhlYWRlci4KClNpZ25lZC1vZmYtYnk6IE1h
dGhpcyBNYXJpb24gPG1hdGhpcy5tYXJpb25Ac2lsYWJzLmNvbT4KLS0tCiBuZXQvaXB2Ni9leHRo
ZHJzLmMgfCAxNyArKysrKystLS0tLS0tLS0tLQogMSBmaWxlIGNoYW5nZWQsIDYgaW5zZXJ0aW9u
cygrKSwgMTEgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvbmV0L2lwdjYvZXh0aGRycy5jIGIv
bmV0L2lwdjYvZXh0aGRycy5jCmluZGV4IDA4M2RiYmFmYjE2Ni4uOTEzMTYwYjBmZTEzIDEwMDY0
NAotLS0gYS9uZXQvaXB2Ni9leHRoZHJzLmMKKysrIGIvbmV0L2lwdjYvZXh0aGRycy5jCkBAIC02
NjIsMTcgKzY2Miw2IEBAIHN0YXRpYyBpbnQgaXB2Nl9ydGhkcl9yY3Yoc3RydWN0IHNrX2J1ZmYg
KnNrYikKIAkJcmV0dXJuIC0xOwogCX0KIAotCXN3aXRjaCAoaGRyLT50eXBlKSB7Ci0JY2FzZSBJ
UFY2X1NSQ1JUX1RZUEVfNDoKLQkJLyogc2VnbWVudCByb3V0aW5nICovCi0JCXJldHVybiBpcHY2
X3NyaF9yY3Yoc2tiKTsKLQljYXNlIElQVjZfU1JDUlRfVFlQRV8zOgotCQkvKiBycGwgc2VnbWVu
dCByb3V0aW5nICovCi0JCXJldHVybiBpcHY2X3JwbF9zcmhfcmN2KHNrYik7Ci0JZGVmYXVsdDoK
LQkJYnJlYWs7Ci0JfQotCiBsb29wZWRfYmFjazoKIAlpZiAoaGRyLT5zZWdtZW50c19sZWZ0ID09
IDApIHsKIAkJc3dpdGNoIChoZHItPnR5cGUpIHsKQEAgLTcwOCw2ICs2OTcsMTIgQEAgc3RhdGlj
IGludCBpcHY2X3J0aGRyX3JjdihzdHJ1Y3Qgc2tfYnVmZiAqc2tiKQogCQl9CiAJCWJyZWFrOwog
I2VuZGlmCisJY2FzZSBJUFY2X1NSQ1JUX1RZUEVfMzoKKwkJLyogcnBsIHNlZ21lbnQgcm91dGlu
ZyAqLworCQlyZXR1cm4gaXB2Nl9ycGxfc3JoX3Jjdihza2IpOworCWNhc2UgSVBWNl9TUkNSVF9U
WVBFXzQ6CisJCS8qIHNlZ21lbnQgcm91dGluZyAqLworCQlyZXR1cm4gaXB2Nl9zcmhfcmN2KHNr
Yik7CiAJZGVmYXVsdDoKIAkJZ290byB1bmtub3duX3JoOwogCX0KLS0gCjIuNDMuMAoK

