Return-Path: <netdev+bounces-128870-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8BBE97C2D7
	for <lists+netdev@lfdr.de>; Thu, 19 Sep 2024 04:24:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 84DE428276A
	for <lists+netdev@lfdr.de>; Thu, 19 Sep 2024 02:24:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00D631EA84;
	Thu, 19 Sep 2024 02:23:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b="KiMRv7Rm"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-002e3701.pphosted.com (mx0a-002e3701.pphosted.com [148.163.147.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 424D6179BB
	for <netdev@vger.kernel.org>; Thu, 19 Sep 2024 02:23:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.147.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726712635; cv=fail; b=lJ18hMqKD5wEaXGOsqhdZtAN6RznfYKndGJRllEo2zI/+bVLhBmjLP2zyp1uPLeWyBsaxmu2Tr4XyhEHujNflVD6DCaGMsS9cGWOoGF/rT47LzyZgn4H9Rk15SMOPXy/Dv9/aBXNdMIRWDmtWM83qWoz9hzeqUSjVcTg7bIRsqo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726712635; c=relaxed/simple;
	bh=HnAcRieC5itfbHTpoZXIMGBtsXoiz0w+vjYDmtBDM5w=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=FcAVgTXzurvgkh1JtqTuGhxH4rX2koh0oICow07cg7Ra1PgejbIVSWF5q4NuhbH/6d20yJZ3SyXkgo8Gi2+iBQNDIM/KB69tQoNt2yzGN1E2i2IbVdjpM2RoubVu3y3QsqdGAQ+9nu2CWE5T0B94kAxpkin1ZsvNT7MpAnkr6+s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hpe.com; spf=pass smtp.mailfrom=hpe.com; dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b=KiMRv7Rm; arc=fail smtp.client-ip=148.163.147.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hpe.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hpe.com
Received: from pps.filterd (m0150242.ppops.net [127.0.0.1])
	by mx0a-002e3701.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48ILRw4w017378
	for <netdev@vger.kernel.org>; Thu, 19 Sep 2024 02:23:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from
	:to:subject:date:message-id:content-type
	:content-transfer-encoding:mime-version; s=pps0720; bh=l6kd6aAh5
	KZiEnSRjBYHMDe56I8wr9XB3RRPpeHlylc=; b=KiMRv7Rm6oc+OTB497OpQiyCI
	R748SMIMDw5OYrKAZbcSG6WBY7yP4rUT9fSkHGOXY7q1HPNKL6kLYTZa0R3uk9VS
	tb+PVOGxIuumLaD9KTJvgGf5sTB3/pLCL3fBQLxIdYtiu1ANja8xlgs0PeEoupKH
	vzcyKky/WgySbbWrlZ/xZbD7Pxy2/LD2LvKc9Ut7V6hIPDXcdD3kY7IQkv9LHxi/
	B8lQGdisF+PSMB+xNf77oWTfWBTu+Lh1GOzOratsKD1diQHtdzwf2wO3DnUQzc5a
	ZxXFk9chAjRHX3dogRRbBBR0Qw6dGtwDxIMeCpHoKLE7KywCyqsfq9YtZ06JQ==
Received: from p1lg14880.it.hpe.com ([16.230.97.201])
	by mx0a-002e3701.pphosted.com (PPS) with ESMTPS id 41r6t5hcp7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <netdev@vger.kernel.org>; Thu, 19 Sep 2024 02:23:51 +0000 (GMT)
Received: from p1wg14923.americas.hpqcorp.net (unknown [10.119.18.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by p1lg14880.it.hpe.com (Postfix) with ESMTPS id D9B94801701
	for <netdev@vger.kernel.org>; Thu, 19 Sep 2024 02:23:50 +0000 (UTC)
Received: from p1wg14925.americas.hpqcorp.net (10.119.18.114) by
 p1wg14923.americas.hpqcorp.net (10.119.18.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Wed, 18 Sep 2024 14:23:26 -1200
Received: from P1WG14918.americas.hpqcorp.net (16.230.19.121) by
 p1wg14925.americas.hpqcorp.net (10.119.18.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42
 via Frontend Transport; Wed, 18 Sep 2024 14:23:25 -1200
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (192.58.206.35)
 by edge.it.hpe.com (16.230.19.121) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Thu, 19 Sep 2024 02:23:26 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=af+n63BS1hTvs/t1GjF9sT31C08g4vCI0arBIJH1ODt6+C05jYRtg0Ka0VKEk3Q/MAoo4rc+TOABf32dNGfomcimH4Y9NeEnYi4Rfx1rbKR1NOqfX35Olhi/rFVYh5EG+M5ZKiMFFr8lr6S6zxA8qTLhWD8xVcd2NK0VdZheYBE9/uTNDRrVvox+Mfwyc/xfTZyVFfk7WLZfCqfgzrQpMbfZpLC18wSjNpQDeNdToJ6hVQv8GBL1skzSPhw/wmfOX7fwkPjsaeEBiJTZP0Mgb5ybV9o2f2s4OzkuqHjVAo77LVt/UwQYpTsY0wNKLwHuhrJMAMmbkIr6WPHgyUrOmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l6kd6aAh5KZiEnSRjBYHMDe56I8wr9XB3RRPpeHlylc=;
 b=fckT5huo8JaC/NakSL7t/Ku6G9ZGw1d4MdqiaZCvk+n+t8FbosQfWQuwoT0V2fbtPZZVKKIQd6Q2QoKgZWyIJW8f+SThT6Oree1IwpVjOWGto/AUHEgT0y5/wnLsMAdSUzvS8QNjEui7IKyju2CtbH7mNTTQJXyz7lUPSSliGh5BGPw5IPZy1dzEFJljN0Adq8Rl7nyyS1pvquu9ZEvWd4T3ngV+y20IaGZ28wizQIB2H/bcTo8JUfsHxi1FiftPxAc7PTrS1cnZH4vmvm9AfuWj8uPcmmAnsS1iAh954BZQWmio9PKTbWDUQQc8bEujdtx9xJ8udp/KDHqean3rTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hpe.com; dmarc=pass action=none header.from=hpe.com; dkim=pass
 header.d=hpe.com; arc=none
Received: from SJ0PR84MB2088.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:a03:437::8)
 by CYXPR84MB3741.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:930:dd::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.21; Thu, 19 Sep
 2024 02:23:24 +0000
Received: from SJ0PR84MB2088.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::8cc2:658d:eae8:3d8d]) by SJ0PR84MB2088.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::8cc2:658d:eae8:3d8d%5]) with mapi id 15.20.7982.012; Thu, 19 Sep 2024
 02:23:24 +0000
From: "Muggeridge, Matt" <matt.muggeridge2@hpe.com>
To: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Submitted a patch, got error "Patch does not apply to net-next-0"
Thread-Topic: Submitted a patch, got error "Patch does not apply to
 net-next-0"
Thread-Index: AdsKN4cQPqFaBe0nSyiFGCTE3NqYjQ==
Date: Thu, 19 Sep 2024 02:23:24 +0000
Message-ID: <SJ0PR84MB208883688BD13CC7AA8F880ED8632@SJ0PR84MB2088.NAMPRD84.PROD.OUTLOOK.COM>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR84MB2088:EE_|CYXPR84MB3741:EE_
x-ms-office365-filtering-correlation-id: 8cebb767-8aac-4626-1280-08dcd8520a1b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?k9lEK4By7unHBrQTQoGutuqJOSo0QU2JEGc1mmp1Bx5vUoZoStP53y9yEzQq?=
 =?us-ascii?Q?DiUKN6nBUodfxlw5j1gzp5CchP2FcRwi/RzPWfXVniWK/Vk0YRPpKZ9PpoHm?=
 =?us-ascii?Q?Hl5WE9d3Iw2c0mAod5W5XFz0HmmcvMjuF3pS3CYOImx+jjX4xhKi0WgTkSVs?=
 =?us-ascii?Q?ehbHsEiC/lcVGICibKYYqzlEDIqxWGaMa544qVmDHqXKnktlpr9wuw1l6yiY?=
 =?us-ascii?Q?ju2JZafo4J+JPwi4xS6p/yqXZ/qMuINBVxZNG3+tyDPK23JdA1/dNj5C4fRx?=
 =?us-ascii?Q?PwBb17Bm14OEfqmBwlb9ZvqDzBDHQgiDvbEL8kgyqxx3qEYGGiisFzYk77h7?=
 =?us-ascii?Q?lpOYm1Q91XqHX16L7gXHAi3d4asnQ8l3nHvRt9LbEnYV6Es3ywhnSgaQuua3?=
 =?us-ascii?Q?tyjs5fAYpph+iZEaJGFbW2u6e0jt+285mr1HuqqPVPAJpty/kY/LSAyZmx3d?=
 =?us-ascii?Q?HhC4hEqnphr3UvBeByF4TtGG+uM0cnqwMLrWsIYP+HkHjNG38uF/+cbOOBUm?=
 =?us-ascii?Q?ot2Uacu5ukx5JgE5DFZdJjzUBuFC7fXJaVPAwY/MrA6Xxi+5F5OgdbbVsryI?=
 =?us-ascii?Q?7BHHYM5sMwVEJn2HAfiwwlx0Bop09gKVpD3uv/jrjDAfKwsoTY+/qa5m2vOJ?=
 =?us-ascii?Q?5TaYIixR0ktPqP5xRPIL3RSTEzPhJQSwMRtWlUeYIgRhpzNp8cJwrSieRA1L?=
 =?us-ascii?Q?j3o9vBh9mhO3Dgs3y80+7452TAlmRefrtjYnguEXNUqlEk3uXxudSl+Gd7zI?=
 =?us-ascii?Q?imKrgwhvXIMO0veeSS3Qd64U58f2prtDU+hctecr+bOFUx3pz7bpZk77SYn4?=
 =?us-ascii?Q?P/bw+DrCEKMu+LUtbsytFOL0Knp2LBWhzOkDGEYpE3IIisF5U8eKxi5sg+rx?=
 =?us-ascii?Q?zOMkzX+Tfk7bCcMziNa3ST75VQvIpnxsSxgp8moaoiw6cjbneMb85OVg50cb?=
 =?us-ascii?Q?jzK4hWWVDJy2Ukh8LII2pB4GH7Ro6uKf+rnD/Rnc9o20F87/2z+eYaMXOKzs?=
 =?us-ascii?Q?b4F0je5rHocM37T2GoV7z+PNhT5yIEdC41W4Yynq2AoyaEQ7BBJuFFQ4tP1X?=
 =?us-ascii?Q?LxnfUbrOrG+E2VcxJm5ELTLzn9MiAMkvmNmxN2zq1552IEYo5mFuii2Gm5Ip?=
 =?us-ascii?Q?0IGee3zuEJY5E/T3E8PTg8XIDGOhxNOvW3Z6GUcQGPSmQkOhx7iVAxNtcV1v?=
 =?us-ascii?Q?CsqZ3YPOWPOrHb6vcQAGYiIBmfMNgffjIWA/5vaFKdYq1k3ggr4u/wOwhqhq?=
 =?us-ascii?Q?MAK/x2MTOoxgJQULx4J82hsXU7HmfRW/TY7gLmYx8vzK5fLGA43wF+TPBPdP?=
 =?us-ascii?Q?LDUR/GiKDgobztayKvRBTDd1gN4tvqHc+08tRWtZZaShTKyjjvJWtsV59xx/?=
 =?us-ascii?Q?EI23FpsiFQrctjyCHhR8uM6de5YM07P4C58aoNUWEy2q7yeu/A=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR84MB2088.NAMPRD84.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?D9dkTlRB20MC/bMh3Kj9wottfm5kc4thIB7QBcoDcapbnrs0CfAf/gvpI5bg?=
 =?us-ascii?Q?KJZJz/vEkSylRDDTO4ykSGWiM/okIQHgKEsyxD7O4akpcdJ76tIrvIYl5iq0?=
 =?us-ascii?Q?jm5qcZK1CFM41OYCAf3TdLwDtxJbq0efehj7Ag6xKZ10EW+2jUoai2dE54dj?=
 =?us-ascii?Q?aWoRs31zXxDGZcwcoLSckL46qF1j+iB3muk8bArd1g+1fVXOHKdzx2Ut3DJ8?=
 =?us-ascii?Q?v5gBt7tT7k/8O2gPisHAVCce2DZrcvIM/XDNtwSvu+yMyCJPbHmBH4IjA8y4?=
 =?us-ascii?Q?UjJH1XlA3/wrTFQJv5JwuH/K5grCZctmS4cJzCUMPjfiYgBCG9xXI6tvcNxf?=
 =?us-ascii?Q?NhqYCscJ9JVSZAff/N5NgnlnAVXUMkiSsT/og40L8DmP5o3I9ZZ9xlrkf7XI?=
 =?us-ascii?Q?wUq8mkPJOgkSS74b/nWGEfMPJtGCKTPmF3Yoqc3CzS1RY6nLOt4TgtkeRqBP?=
 =?us-ascii?Q?+swFoYn2y8U1p3fXxl38w5bBpuwBiTz9Ydv24qlcLSur9El077F1TREoRAhc?=
 =?us-ascii?Q?lzB448gVw5gvvNflKvUVvwXEu6tvbezmvO58AeZW57QEfpIZb/YtXnDxYG/q?=
 =?us-ascii?Q?JqtTT22sNaoyYyx+MI1eDU3snovPKtqzo5FLtqaX/NbZ2Z7oEn7Iu6RMpuVY?=
 =?us-ascii?Q?gauFVG5kmVl8cASYAVMF9RaDKnc97gqB0ulxokrjv3hezF1Y+EjmmgkFj5Uh?=
 =?us-ascii?Q?DtEsQt4dn/eeeFEOsc0VIv907qDqLy0lWQwd/jQC56FRXN6FSBFyna13fRBD?=
 =?us-ascii?Q?4oN2mombAH+zq466qkdk3M5GfbJFyM7ZPa1iDBinlWC++Zqpvx3ItYrDCQ0n?=
 =?us-ascii?Q?+JlItZ5GrixBpMiJoVywWc0KMi7w3Mer3E8WhtWLTQL/Qti1+eT6MjCrqplu?=
 =?us-ascii?Q?v6jFGtJhgEJhOKzxM/rvU5wnSJ1fsgV3Zwh6Efrl2dPzxsafggMsW1OdU0W+?=
 =?us-ascii?Q?ZBS9fe7bHDtc1OHpzPbKSnFArOmeD/BLZkdk+nEdb1lPh3ruv0dbKLZ2y9ds?=
 =?us-ascii?Q?Ar5hoUV5gOacQKwQuW2Phc+UvED2V4igdKjedNkGAvtaqAt1QSq6T5cWlQ+i?=
 =?us-ascii?Q?JvTe1PYqYUvNVPeljvDotYJxNtqkyIvIePR9dTOrK5EXW5SBUu/+qVN3R9HX?=
 =?us-ascii?Q?V5yJYfZHaeGiJfXFSXQLTjkoHUcecA5XlNqGtD7Q0qSdFtWSxWeFwJnEITgP?=
 =?us-ascii?Q?z4VwZD3pFvu99xRzahZvDecVkpoB2oHFsAuHp0awq1xWQJ5OH3LyiPJVoI3S?=
 =?us-ascii?Q?K/4WdqkGaX+lnb6HCc5w99L1fx9sSdYEHjOrpDBrZyUOsOoMBIwvWL2RIZme?=
 =?us-ascii?Q?coKHggroe73oSR1SHodQDuKEs2oWW7UCu1Z77EfsCpDC/V/+VVOCS5lmy3c5?=
 =?us-ascii?Q?xc5y55iRAR3mIaaxSJOdtQpRCQz6JEpJvjKMDQJCuv76/eIb/z7NA/pTuJIZ?=
 =?us-ascii?Q?+T+5Tq8IoTZdfCSk67kqOQUL2n2o9cmvV0SVvsGK/J4fGfyjvFAU7kaWTDLg?=
 =?us-ascii?Q?ua/clbdvcVJK0bS3/b0IeCfP5ftGU5IsveTfjMFuhkGXj56H4lNwEe8P4ZpR?=
 =?us-ascii?Q?4X5LrpgwMxh7fPcjpymbJiAq/9FO4KkodXX2a/cX?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 8cebb767-8aac-4626-1280-08dcd8520a1b
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Sep 2024 02:23:24.8201
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: W24mQ/N0p5svqw2Mzne0wEMKboiBQrrclqnQiBPZbfOUoQEXjKN1h5k7J9ZwDqKCwRxPzKIEZW7NsjrBeONABJH1X4m1h31ZQ5okdz9+C2k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR84MB3741
X-OriginatorOrg: hpe.com
X-Proofpoint-GUID: 4AD1-dF0upx49R91oUcFhupxN1Sj-JWw
X-Proofpoint-ORIG-GUID: 4AD1-dF0upx49R91oUcFhupxN1Sj-JWw
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-19_01,2024-09-18_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 clxscore=1015
 malwarescore=0 phishscore=0 priorityscore=1501 suspectscore=0 spamscore=0
 adultscore=0 mlxlogscore=963 impostorscore=0 lowpriorityscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2408220000
 definitions=main-2409190015

Hi,

First time submitter and it seems I did something wrong, as I got the error=
 "Patch does not apply to net-next-0". I suspected it was complaining about=
 a missing end-of-line, so I resubmitted and get the error "Patch does not =
apply to net-next-1". So now I'm unsure how to correct this.

My patch is: Netlink flag for creating IPv6 Default Routes (https://patchwo=
rk.kernel.org/project/netdevbpf/patch/SJ0PR84MB2088B1B93C75A4AAC5B90490D863=
2@SJ0PR84MB2088.NAMPRD84.PROD.OUTLOOK.COM/).

I followed the instructions at https://www.kernel.org/doc/html/v5.12/networ=
king/netdev-FAQ.html.

Here's my local repo:

$ git remote -v
origin  https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git=
 (fetch)
origin  https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git=
 (push)

After committing my changes, I ran:

$ git format-patch --subject-prefix=3D'PATCH net-next' -1 95c6e5c898d3

It produced the file "0001-Netlink-flag-for-creating-IPv6-Default-Routes.pa=
tch".  I emailed the contents of that file to this list.

How do I correct this?

Thanks,
Matt.


