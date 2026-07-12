Return-Path: <netdev+bounces-306982-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id FLtbN0j9U2qXggMAu9opvQ
	(envelope-from <netdev+bounces-306982-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 12 Jul 2026 22:47:04 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AF7F745E13
	for <lists+netdev@lfdr.de>; Sun, 12 Jul 2026 22:47:04 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=hotmail.com header.s=selector1 header.b=jh8ENvLT;
	dmarc=pass (policy=none) header.from=hotmail.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-306982-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-306982-lists+netdev=lfdr.de@vger.kernel.org";
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0D883300AB0E
	for <lists+netdev@lfdr.de>; Sun, 12 Jul 2026 20:47:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A31F5352C28;
	Sun, 12 Jul 2026 20:47:02 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azolkn19010000.outbound.protection.outlook.com [52.103.12.0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44AA27E0E4
	for <netdev@vger.kernel.org>; Sun, 12 Jul 2026 20:47:01 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783889222; cv=fail; b=UCqeeE2JmoglwJL0M8AvkVuMxzT+r11M1uODBGePSw0nMUUZEoINZFJxGxNaX4pokrReOPK9CKynydYde+sJBKiGPXiZzx8JOs6fs7rNCrtS/1YzrHbdWnpEGJ6N0GiVPnFrTlK3ya4TGVjR1yLq5kg4lgLuOPOuMg3DlY67QJY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783889222; c=relaxed/simple;
	bh=9Sa/OEWVmcKwAZV5eNlsHfDGpSeYrChKty+2lMiGTF8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=JPDUoWKRrRm7qiFwEPIluLSn2GkcpRmt6Cre7+K2GvaC0YbxJrglJqzZiuNtKPcdKLqUV6TLK+RHq77CgYD1CJ2alqjghrmXSuo/AY7p0jcdm7ShO/NtD6pddg+1eDEFwR1rn62LHBhY45tqCsAy/0FGNyuG+FpJ0LIrfdi9afs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com; spf=pass smtp.mailfrom=hotmail.com; dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b=jh8ENvLT; arc=fail smtp.client-ip=52.103.12.0
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hLvJgvisFdx4REAbjpokQxe7eOj6Yk3tYGlQx/3g/z3F0mm8bu4ffOLG1v1G/lJb69O0kdECI2aJlcEnKzdv72yjzW53KOQnEhiunINHGQbADiqG0ZjbxiP3OjiDS0RWpO24XLf2V9jGXtTVlK42H+E84cM5Au8oMNutcnN0gy8+u1mQigfws06ntz0SKia3/m42X+37FW/hm9XAOeVN5XF16Tl4mCkLqHa6jMLA6m/e7RfpiXfNWfHsWbxkZTrihlwzQGBexpafruux8sSX4XdM1j/zn2hV8/AA6LH7ZaAYzKkVlg+0b8e1cGMt0yrXB23V2IHclLzY4WXZjO026Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9Sa/OEWVmcKwAZV5eNlsHfDGpSeYrChKty+2lMiGTF8=;
 b=zN+5Q4YWpVA1yJklI4X5dSthXIhLoDeF0Vp+zOooUKET1iu56+jxy23bBVf9h9mhtewA8BZW0gT1UdAcDecioMFDY1sALKJmtpYkZ3v3J+x7Koo74Y/cv/YIIszg6JxMGiBKwdNFWpOdK29fSPv+JJn37YmjomLxGLEok0iAwL1REKSUVhQYxkxn8z7LQbxUneVokCWVwqYBDYLxFia7BxKFINI+X7S3odYxUSTMAFCAITJjctfjf2NwK+zhijrbXgT1elNSfrovsZ6JCvrRVvUJ+vZiL08plLU9UeoEx6aTrwium+SR7/OtGMsT98PmOMWQpb9ELfvaOZCa1/eU0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9Sa/OEWVmcKwAZV5eNlsHfDGpSeYrChKty+2lMiGTF8=;
 b=jh8ENvLTp2hO5o7eup1EVFFiXw7FOwNn1QH1ZEsPDPzxfYmCe1TXeknxGCOd11A6GQfoBFv3e9ddOiH2hfjlSAq4anOGLxUTlSeRoihQ/RckMJfvQN1YePCYWBVljbEwzeWj59RTjIh2VDqrXzeL9460s4umfXhb4y0C7O/VoIAzApn4OEniw7kJT20s7jtYD8JxmAi96umhKUt3sTAGexBVHmM2U3HfyQJKc2aPzzET/nM1i3kfekHEL6K8emhQWgxSorbf3t40YYwERKkMYsYzGka52W36VUoETjuXPwA0+SQMwZnEaDDHX76pOuJvkioz6UhOGRsDLNcLAQyNhg==
Received: from BL3PR17MB6067.namprd17.prod.outlook.com (2603:10b6:208:3b6::20)
 by SA1PR17MB5508.namprd17.prod.outlook.com (2603:10b6:806:1c7::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.202.18; Sun, 12 Jul
 2026 20:46:58 +0000
Received: from BL3PR17MB6067.namprd17.prod.outlook.com
 ([fe80::dac:354f:6da2:b3f7]) by BL3PR17MB6067.namprd17.prod.outlook.com
 ([fe80::dac:354f:6da2:b3f7%6]) with mapi id 15.21.0181.019; Sun, 12 Jul 2026
 20:46:58 +0000
From: Jack Ma <jack4it@hotmail.com>
To: Ido Schimmel <idosch@nvidia.com>
CC: David Ahern <dsahern@kernel.org>, Roopa Prabhu <roopa@nvidia.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, Nikolay Aleksandrov
	<razor@blackwall.org>
Subject: Re: VXLAN FDB nexthop groups: per-nexthop UDP dst port / VNI
 feasibility
Thread-Topic: VXLAN FDB nexthop groups: per-nexthop UDP dst port / VNI
 feasibility
Thread-Index: AQHdECzKntl94UH4t06XCxWyGsMDVrZpeVuAgADiiMo=
Date: Sun, 12 Jul 2026 20:46:58 +0000
Message-ID:
 <BL3PR17MB606794E6EF4AC33FC3A67B72E5FB2@BL3PR17MB6067.namprd17.prod.outlook.com>
References:
 <BL3PR17MB6067BF1D5802A6B1822452EEE5FD2@BL3PR17MB6067.namprd17.prod.outlook.com>
 <20260712070543.GA126372@shredder>
In-Reply-To: <20260712070543.GA126372@shredder>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL3PR17MB6067:EE_|SA1PR17MB5508:EE_
x-ms-office365-filtering-correlation-id: c0ee4c38-4001-4526-f578-08dee056b7a5
x-microsoft-antispam:
 BCL:0;ARA:14566002|15080799012|15030799006|51005399006|24021099003|8060799015|19110799012|8062599012|31061999003|41001999006|37011999003|25010399006|25031999004|10035399007|40105399003|1602099012|102099032|440099028|3412199025|4302099013|26104999009;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?BVlzlvU7GVPpMGRyL6fC91rU0g/6T2Ahwwq2mTXcoURrf/4x+S3rUzvvba?=
 =?iso-8859-1?Q?187PRVUtdcgCopm3mFBoVwBW9/gPyiHBGd/DtRkl7cKuwGwYfw0c4XFLK7?=
 =?iso-8859-1?Q?VaPleNmElNSA6+TAOaeWRlSorY0CLgRPpz82C4AVbBXrd/gxf2ZMT94x2N?=
 =?iso-8859-1?Q?WzmG439oJZwLhZ9PzcwxlWDBKu8q/b3Pp3Ge3peN42/IWFwlSgBF4Dkwu0?=
 =?iso-8859-1?Q?RQiA5oEZshaR4Yu8FYeoqqFLAWSb1XlGtbYZU5IDa9c2VXcGRp6Sj6pb0k?=
 =?iso-8859-1?Q?tCHjke+fXbE3nBSE7WLuu6PJD4TLPvvLwdPbGoe14RP3beaoLB2ziJBvmG?=
 =?iso-8859-1?Q?8IUqrw6CGX6/7SQdNfXYV8jwuoo4VEiz3wTJAGrwG5v/m2ETz0eyh4HT+a?=
 =?iso-8859-1?Q?C209xPD6Z4ezLGes4V8heBserg6EbhdT/4vvg8aYQwdBFG1x/o5Qum1rgo?=
 =?iso-8859-1?Q?/LeV00ODRJg7nC/qWnUJ4RjnOMX/GtXzfjAnIUH1crMvO8rIHqyEqUwqVZ?=
 =?iso-8859-1?Q?0zTCBjG/UgY/PX/OO8R4zwLe7urnu4rzUavenoCmsgFUZ0gbEOfNucWfDd?=
 =?iso-8859-1?Q?TY3cm7O5ev2ZR5xkuRvclM2er/G8xtFtn6Q9D2ulqMMzbPCY/D1735b2FH?=
 =?iso-8859-1?Q?RNijxgD0AAf2vnGb/nBy8nqBjPrel5uWC1ucmNzj3nfpINUH2afc8juYkL?=
 =?iso-8859-1?Q?6t042mpjgg6K9tRpGKNWuOX71sKxEmLw442eMotjsI1AA5TMOuWxRCdsPq?=
 =?iso-8859-1?Q?QKDYqFY6Isl0mWAqjx6IXc92fTXGA92CDnPz5+pffxCiRdOQrR1xgliVd9?=
 =?iso-8859-1?Q?ZCSmcNYYrkm725FB1nc/W72/z9oQ2noLv7KVcu3OLL/T4ZbR5dogFrCpqk?=
 =?iso-8859-1?Q?B+LcefZBdxfbW2SKGKEDSTpFX6G8ju2bC9o/Hre2BadjvJPwE4voQ2hinR?=
 =?iso-8859-1?Q?Yg4RSHAaUWqfQH5uWEa1gY87+JUKXJGqquWVtGH5kxSNcJzy5WLLUa0+4D?=
 =?iso-8859-1?Q?eyOPJkYKVxmM3MKzEpPTkqMCQ1Ocz86EUd67QrAA4aBdDeMuQbMpf+SwTi?=
 =?iso-8859-1?Q?PwYlIFNQeRG3r/Ciw1beVabCiEKzZ0BV+ZZcbU7f2PABLAmHWu9nCLBc+A?=
 =?iso-8859-1?Q?iEI8bBVJliR3nQKd6jD7gbqKTvWZM=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?iHJwg9d5ypsfJMd2DcX/sEcZQS5+wumZ4NfaV80A/PXu1Hkxm0uwWRAI1p?=
 =?iso-8859-1?Q?ob6Ire7SiAPhA/AN1e2ZCvygaEfq4WdDmHx0a1KcGyAOEAuonVvcZ99EO7?=
 =?iso-8859-1?Q?us13KN8Vm+eDaD24nxIzIjMcfqT+kB2Dc6vgp0nLiWXborH1P83pr0iiLz?=
 =?iso-8859-1?Q?ztY7oGsdC6eRvsBpx2zUdP68jtvCVkBgmBuukRoEXh6k5GTU75kMXzFzMQ?=
 =?iso-8859-1?Q?N98MyY90MCBy2CBoSo8R88IPN1kYJjGR1mj5RVytk3wv+/zyk601LMaTPk?=
 =?iso-8859-1?Q?YNyAryBz2o6tro41ts908++5NF4la5JjZThZYfz0sWX+b6BKQBw4/+CxVw?=
 =?iso-8859-1?Q?6rBLmg552MmxjXgw4PvwpUEOzDI0CzuH0gYoN/sMC550JGJHcXPcTrIIL7?=
 =?iso-8859-1?Q?GmIEcOxJOvvld0rfBUE+lJpEc62tsuOEp54JbfwhMGyxeA4qfcwJVczL8e?=
 =?iso-8859-1?Q?T4jc7CSwCrzUQ5pv2DrHZLneKDogrH0q5AGAfqVsLlc2MiD2iyCUKGNfrG?=
 =?iso-8859-1?Q?TLzfBD9pQ7E+KFbc6KMa2OhM4QI6r848p8xgG8Qn7ch3goc3UqHlDbXbxR?=
 =?iso-8859-1?Q?YeeO168e1qe7OrwDwc0XJqB6ms0cKLEEEpIUNnedoyO5A4NGLoTVSRKgpV?=
 =?iso-8859-1?Q?GyZQKWEBjwdeYVRsHGA8FlfIs1JNq9CvW7oLjZA3dsD+U74MSJx0mGagPq?=
 =?iso-8859-1?Q?zB3meYISMqZi1T+sZRuCpqYbu55WccyGB0uWE0Ih56Eu7pja/TyDAlTjo8?=
 =?iso-8859-1?Q?U6eyiDKd+SnsYZJmI7QssOaPsoLgGQ2MmpmyklkVNKVt83V3N5H0YAFjyg?=
 =?iso-8859-1?Q?rHG2epRXGoxoyHl01KThYSgYFOU1KU1Akk6NGQ4XtD657D34+MO9uda4Vd?=
 =?iso-8859-1?Q?D2WVyMXEfahePgaoOAkiM3q+rbhieHc5NxyuSt6+seuDvVu8NPuwauxGZz?=
 =?iso-8859-1?Q?rI2Bnq4oG5Q0Zy0T/ZGBUJOpmRF7xL8tw+L4oEp6lKZNWSracV4uxtHrfb?=
 =?iso-8859-1?Q?xwfp+kX+TwRE6jfOyzkhP/xn36UR88d4Xp3/T8A/w4GDtbix+8/+CZIGXK?=
 =?iso-8859-1?Q?lu01dN1fZK8c8z3NuuQCCaJmnAR3JG3MAbKb/8BgZZyMLSC+IuQSyGZlQF?=
 =?iso-8859-1?Q?gwY+ad5S5C61RZkS+jphGllvvz46i/to54YwoTHGr6yNrodIiybsIKb4Wf?=
 =?iso-8859-1?Q?1kOPLElHO/dnbPNfWR/T2uA62QF8kKr82r52fTpWOtqZIf1pZkLeEad3KE?=
 =?iso-8859-1?Q?lxXxV92LvN56dggK/cgD3lPHAg5h0xPL3NYEy+cdRa0pX0YuT+MpHh4pxs?=
 =?iso-8859-1?Q?biMpmwHg9Zl6vIZOuZWMKN7CHtQMqT41Kehaxl2D7cFDm5ig5wNMbcsdMC?=
 =?iso-8859-1?Q?6wRZ6mXefZ0m/abQEThrmAPLfUmvJHg/6K+PT0qZIFYjdKiBkKy/E=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: sct-15-20-9412-3-msonline-outlook-e4558.templateTenant
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL3PR17MB6067.namprd17.prod.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: c0ee4c38-4001-4526-f578-08dee056b7a5
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jul 2026 20:46:58.5645
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR17MB5508
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[hotmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[hotmail.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:idosch@nvidia.com,m:dsahern@kernel.org,m:roopa@nvidia.com,m:netdev@vger.kernel.org,m:razor@blackwall.org,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-306982-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_FROM(0.00)[hotmail.com];
	FORGED_SENDER(0.00)[jack4it@hotmail.com,netdev@vger.kernel.org];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[hotmail.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jack4it@hotmail.com,netdev@vger.kernel.org];
	RCPT_COUNT_FIVE(0.00)[5];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,BL3PR17MB6067.namprd17.prod.outlook.com:mid,blackwall.org:email,nvidia.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3AF7F745E13

Thank you, Ido, for the comments. I'm new to this side of the work, so plea=
se excuse my plain-text email handling!

I have submitted the patch here: https://lore.kernel.org/netdev/20260712191=
218.236-1-jack4it@gmail.com/. I also switched to my Gmail address for easie=
r git and email workflow. Thanks to David as well!

To give some context on my approach: I am implementing a multi-tenant VXLAN=
 overlay where we pack multiple VTEPs onto a shared pool of machines. Becau=
se we can't assign a directly routable IP to each individual VTEP, I am try=
ing to route traffic from the shared host IP to a specific VTEP using uniqu=
e port mappings. This is running in a Kubernetes/pod-based environment, if =
that helps clarify the use case.

Thank you so much, and I hope the patch can be reviewed.

Best,
-Jack
________________________________________
From: Ido Schimmel <idosch@nvidia.com>
Sent: Sunday, July 12, 2026 12:05 AM
To: Jack Ma <jack4it@hotmail.com>
Cc: David Ahern <dsahern@kernel.org>; Roopa Prabhu <roopa@nvidia.com>; netd=
ev@vger.kernel.org <netdev@vger.kernel.org>; Nikolay Aleksandrov <razor@bla=
ckwall.org>
Subject: Re: VXLAN FDB nexthop groups: per-nexthop UDP dst port / VNI feasi=
bility

On Fri, Jul 10, 2026 at 05:30:40AM +0000, Jack Ma wrote:
> Thanks very much for any pointers.

I already commented here:

https://lore.kernel.org/netdev/20260709102247.GA1536940@shredder/

