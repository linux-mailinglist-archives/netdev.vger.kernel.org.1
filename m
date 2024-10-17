Return-Path: <netdev+bounces-136755-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 317F09A2F03
	for <lists+netdev@lfdr.de>; Thu, 17 Oct 2024 22:49:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 487511C211A5
	for <lists+netdev@lfdr.de>; Thu, 17 Oct 2024 20:49:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 919851D1757;
	Thu, 17 Oct 2024 20:49:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kyndryl.com header.i=@kyndryl.com header.b="TDpMPIHO"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0066f901.pphosted.com (mx0b-0066f901.pphosted.com [205.220.172.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 017431DF24F
	for <netdev@vger.kernel.org>; Thu, 17 Oct 2024 20:49:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.172.220
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729198156; cv=fail; b=TgQx68GtPa9xnL3q8ySQ34xwLLeDiV1hu7VMetDAtmazHcEiK/zPOtTD20J+tvgg4S+U+wx42NbHavPoniS/6VCIOM/eedzxhIyicE9cJGvYhsz0I7QemnzpuMWxQ/LcFqaRpLM1jQK88JJSSJ92U1/0AdvLRJoEIS0kJwllBjk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729198156; c=relaxed/simple;
	bh=0jJcfDsv8wMyyqJF6mbyhGOw/nIT19yzZoureQjDLok=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=jd6w17lihzR/wiR/KfeYJBCZg2t9xCXmEqjAH+A6jYIWBWQmdy+ABfDgdjfeRXl9SXwXMO7woPP/zW+FIgVXvGi46LYzPR398IWJD47DzkF9c5NvBMMZtQgTAW4K072OcAJh4sMSZaJsFmaHge61efYowvWGLzyvfSEE8aVoI5s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kyndryl.com; spf=pass smtp.mailfrom=kyndryl.com; dkim=pass (2048-bit key) header.d=kyndryl.com header.i=@kyndryl.com header.b=TDpMPIHO; arc=fail smtp.client-ip=205.220.172.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kyndryl.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kyndryl.com
Received: from pps.filterd (m0281385.ppops.net [127.0.0.1])
	by mx0b-0066f901.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49HJYDVd028484
	for <netdev@vger.kernel.org>; Thu, 17 Oct 2024 20:49:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kyndryl.com; h=
	content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pp1; bh=0jJcfDsv8wMyyqJF6mbyhGOw/nIT
	19yzZoureQjDLok=; b=TDpMPIHO2B7RHVj5zQcFdJM4dnJ3jTwNY0KQoAKKAjfs
	iRcNqPGzxf+6vQq0iUnylBjNIp4fI70YJaV7KmJdrR6VDarjKrdD317nbJdGjH+h
	/pJjENSz/KdakVneTKhud/Ss+VqtBqEZtzIgVlDpSiIeLx9IFByGNWtlGSLJnctk
	0RIRvbn8mbUlIzl8P7SmVADv3M1YpBbEbK8m9ij6HKqYoT417FMH7iVQkIo3IMxQ
	nK1udI4AMf86Ks8S7OXFKSkDedJ1k3lwvSqei4Or3bgje1fLggDuOJY4da36rYng
	+FKUH/LXlT+ni9z80JZSFrKrXVcNXJ6L1z6ERAqhuQ==
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2169.outbound.protection.outlook.com [104.47.73.169])
	by mx0b-0066f901.pphosted.com (PPS) with ESMTPS id 42b8ums4pq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <netdev@vger.kernel.org>; Thu, 17 Oct 2024 20:49:13 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=THzOL56Yo7poQ37IL8UIiYSnqnP7CQbmlHr+iCV7CarHFVKU0QHVInQcqkSW1ny9ns7EMHpdEh2i0MwnIsF2qoSMiVSVnoM7jO6b3aExAxQNOodrI193/XVlZivQAFCh0xImSXDInrbNSUQIvg8AhGEIJWusnjpCyNC+IL9uwfHS1NXHop9LLHYPCRdQNJ8Nzr3PiTcikhouXGbWm6sSejqY5hqh6WrZ8/yAto2MPJjbBvSPnK4EwQ3XG5N6KDBe7PsENH5glDIwsKdQs/i/9ZFRWWMoCpVY1VXD6SMoGunhJq0nT+8JW/tAxp6apz09rtndZlTgkTB2SFF8LaULvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0jJcfDsv8wMyyqJF6mbyhGOw/nIT19yzZoureQjDLok=;
 b=P5rAeDb7L6c51zfjNWakInEtORH8Ajwgroy9x2vN1PctuLyMthw9Urnrt75bekpWaTIOoLh7J0pTCpA9juXZirofX50N37e+7qWFean5Thyqv/eopZGA8jvfOMvXDPXsMaGQLQHThVKXuMcaY1vckgDajxpzaXTueZztDR69jSya2GFpaFfsX1J+AffJWTMRxbpjpGYzGbMrqHDFEfiySUSsJ6lwkZCvC441Hu+ekgkqyye8oxnT8eCwXkZsOuv+zjm9m5o6nseaZk3k9kT1wpiqxy+5Gb1ZU6+N2uoYnSYo7eaRtTGAyu7KE4v3jUUxCYD00ZDtvuiAIpzlj/+r8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kyndryl.com; dmarc=pass action=none header.from=kyndryl.com;
 dkim=pass header.d=kyndryl.com; arc=none
Received: from CY8PR14MB5931.namprd14.prod.outlook.com (2603:10b6:930:61::6)
 by MN2PR14MB4078.namprd14.prod.outlook.com (2603:10b6:208:199::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.18; Thu, 17 Oct
 2024 20:49:06 +0000
Received: from CY8PR14MB5931.namprd14.prod.outlook.com
 ([fe80::37cb:92e1:b56:8b5c]) by CY8PR14MB5931.namprd14.prod.outlook.com
 ([fe80::37cb:92e1:b56:8b5c%5]) with mapi id 15.20.8048.020; Thu, 17 Oct 2024
 20:49:05 +0000
From: SCOTT FIELDS <Scott.Fields@kyndryl.com>
To: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Support for JSON output in 'ss' command
Thread-Topic: Support for JSON output in 'ss' command
Thread-Index: AQHbINWSGTLLtHe93UOVbiEwZbJnfQ==
Date: Thu, 17 Oct 2024 20:49:05 +0000
Message-ID:
 <CY8PR14MB5931F3815D306862800B6A178A472@CY8PR14MB5931.namprd14.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR14MB5931:EE_|MN2PR14MB4078:EE_
x-ms-office365-filtering-correlation-id: 50e729c0-890d-4c2d-9897-08dceeed240d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?Gd6UyXGxr+Oi8fWMj+1QqJocSctA+yT2UL0brpeoDxxkTchqs+KUZyv+SI?=
 =?iso-8859-1?Q?ExwILqyWwFoHit2TzuRsBfVEcnl5pqi5l0xYKLHwH+OzGClMijSCsxFJqq?=
 =?iso-8859-1?Q?1VCQizH9UtbmIsEyxw42Bm/kySb7uUQM3lM9Q9To8T3GYzugOfyfbt67MX?=
 =?iso-8859-1?Q?XZykPvEnL7W15fUqNZVyYxsBszLDXfiMthFUxnUgFJ+IgWE8m9bSw6AJlU?=
 =?iso-8859-1?Q?BcfYwJ3BOHyIYRYLn1hHTCeTedkbbf1wrpDUxHVntEaYwMct9WWPfxOmrZ?=
 =?iso-8859-1?Q?1b2FO3dXWt+u3H+zTdQUEXZvcLZGa5QGg7K7B+vSPuEhbQQC9Zp3kylPYB?=
 =?iso-8859-1?Q?2G16Ka43jj0OBj/mpvkhSGIrYhbPfP/09o58T3nwMcbR3UlTN5qhW4iOjT?=
 =?iso-8859-1?Q?PemIGnVo8OBCAnw/qrrMDkq5jXUdPZS4QCZeXO05YZtY/AVB5/0cSWNvkT?=
 =?iso-8859-1?Q?3V1hihHOFiPItf1VjVcy6C//4Bp6V4D0LTMBDYWBkiUwyZacf639rl2JD3?=
 =?iso-8859-1?Q?FUWpTpF7js6wQZI/rxiDVKL4hbLXBogaptPvPbR54P+YsJkcKP4ua7NfFH?=
 =?iso-8859-1?Q?iaecXekeNzGySzu+fvzZhAeVI60Mh14DJZGe/ISFaBT5nL3jraMSJzWQVj?=
 =?iso-8859-1?Q?ePhHpm1Bd9KcOiQplVWI6Srgmv35JqWHXnH85RZ0P5RysTSziu2fT8sDif?=
 =?iso-8859-1?Q?ehlJAVKsFmKwAsBJiCPbBLRNbi7zMhTa5K+1XFZBpfMrqJ4PXxJXLk+ofh?=
 =?iso-8859-1?Q?25GXODLRSQWo2ZjKr+g41CFOZzDDxkNK2grk1F4ajrkRI6KUKNRnRhsGh4?=
 =?iso-8859-1?Q?zJElBPJnpnqeRMIjGjJCW7zh0G1E3OdKjoeSK4BL80Kh+yhbj1mLbhGDPu?=
 =?iso-8859-1?Q?7JrqUZFivIpmACcVjMucrIpCsSEx8QkWuPiA/Ze4vwBHOccf8zs1e8wckm?=
 =?iso-8859-1?Q?6mZskclYy3YH1Z6l8p/8qYAU/ITPwwhoHKEfpS0h5ONd9bEYKDZ7lfl3XT?=
 =?iso-8859-1?Q?UlWazHPLhJyXBjihoz+vZjaA1cnt4cdX43hpb/1FnQbx97msUwX3s35c4o?=
 =?iso-8859-1?Q?ytcX1MiV4V3UmlKAMGTgS7V6ItJM6IBD+/+AhrYK+g1EaCnyQ/npa9ZLVp?=
 =?iso-8859-1?Q?cq481LhQLtuV8wYTI/Kqq13QEUr/7BmaBXX8ejkHs/e97d7EZMlI87tvHC?=
 =?iso-8859-1?Q?MvgIKI9T+aa9tPCZaT94tgLT13tRgdp5UD2ckF190BLcwyOal1r0x6qren?=
 =?iso-8859-1?Q?ScHPF5fFVrk+uLSu1qEbNkOLC713rS91BRU43cOQecFGOWIqxsqo0JoCIk?=
 =?iso-8859-1?Q?odTQJ8ZPhX34QxpbxoP1mvJKNIF2tadfduPtnpygpb8hp/vxfqA0vp30Ja?=
 =?iso-8859-1?Q?wJcPtpDGfNSP1Ut7XvuRzKxkWUF3TGOZRTVk+1B+mVBdKQVU/xA/A=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR14MB5931.namprd14.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?mK6q+9UG1gtlkhalKKcjEskJjkC3djC0rJ1mh7qsOvhRZPlu08WgpyAts8?=
 =?iso-8859-1?Q?nh3jH0UQ04hFmISpzBkMIuHcQcwSKVDUp3gJlb+bwD+nc0fTW3BuqDzsOq?=
 =?iso-8859-1?Q?p+MeVroKHBFRuJ1vd74apzrlKBG7f25UoN0GbeJ75b60tJaeEeU8AQ9tDC?=
 =?iso-8859-1?Q?m2q3DErGHzq0F8UE0xgwA8O+cndbMBJl4bUb2ula8K6WX3fdXYrBNdu9o7?=
 =?iso-8859-1?Q?W+fRml/FDODk9RfC17LQAQTpyyeI2waLElIaeuBEe/rI6o9frL4C3hvmOy?=
 =?iso-8859-1?Q?Na7ubSLx0ZXGTmeEOoJEG5sbIEfHMtH9QAhFseKtSUUsSVTKMLiosKDbDm?=
 =?iso-8859-1?Q?oFZarUWl6035PGGiiSq1la3dnGcD6yABUqz627AYAhgfsbLgJ6R3fSuyTp?=
 =?iso-8859-1?Q?/OtxvidsP7XeVaL1rR94ggqHlOHBp/7wcXQESIWMFYafMMONaJIcT+ojZY?=
 =?iso-8859-1?Q?jjCDsHpWV0/IDZ6/QCOjS7pXuLi9la965G1KAUrbIpwICy6bUXSBc6y0WB?=
 =?iso-8859-1?Q?Pfbl05CcXZRql7g5Opwm8ySPSBvpjYeZUZjFsXlV5mKGeiRLJzBH0OpzS6?=
 =?iso-8859-1?Q?jn+TAzifcceK2FxNcH6kPEtQ+YYA+tv+DifBCsDQDltyRfsMTQzYqQrS0n?=
 =?iso-8859-1?Q?WsTDxpM9su2LbIWANG6PHoCT0IaUaeQs5skp2wtqBvH8fcRxmX6Lnr5Frb?=
 =?iso-8859-1?Q?V5C/MoH+OqufAKgfEjtfd+DPQiNKlizsadG60gZYqP2Qfhn2sAjZ5R3CDj?=
 =?iso-8859-1?Q?5RaEIM4eC6upgQri/6zQJHDMvazd+7XXbEGhdcMqlRASZSAYj+mq21giEc?=
 =?iso-8859-1?Q?d6EvcgUuKPmiAM/BVdI/Nd/wSDFsatX9Qozv9d72vwlG8PbWdf9Wx2k/gS?=
 =?iso-8859-1?Q?bPRInQfIzvhYn3JyhivDz9tsh/TEUK+PtyGnU8NEriPiJ0TJqjDCwhDAS8?=
 =?iso-8859-1?Q?mZyB/KxMwsSx3d6ogzfOrObipgy/W+hgxSWHixm1jsUrJlhLTzbWFmFPYq?=
 =?iso-8859-1?Q?2OLgI5Mz8QfZ453DgZ/SV3w1KyFopTtFk3c/s7xtjLfS+TBhtC8u7OPmQX?=
 =?iso-8859-1?Q?lrRtWLCf2dKwlDTpSXi7QTKorHlQ1K1d0k8GwgRpqrKshnaxXTJ6xrOYlk?=
 =?iso-8859-1?Q?drucly7Wdg1q5ysi8IoUDGLyBJGQt2VYvZPFNslN4ebXUyTtXPvWDGHXmz?=
 =?iso-8859-1?Q?WUCjd2zvyEIHIeSZOxJ/H/iHsBTUDf08fGql2AVi55LlyeXFCsWwPikapp?=
 =?iso-8859-1?Q?v4dsZ/8OjIY+I4DSBJzxb1YXKZUDcsKhWIfS6As/ILtn2yzDj2qXz96UIp?=
 =?iso-8859-1?Q?MV96Kq0oxFNa5/dlvt4FokfIW7A9OTUeZR4r3imXvHpnOEK/SxkmYbAAOM?=
 =?iso-8859-1?Q?nx34JA/Ww4Ml9DJsyQsuq+NbkX6UPRhMp/TxovRYUDUMDxh4/eqMgAzmmF?=
 =?iso-8859-1?Q?ZjzphjVrZy6Ono/D201NqNUjzD7/RRutPg/dmEoSikWKKKjDceF102vNct?=
 =?iso-8859-1?Q?zNBHBRINKHwFc7R+YiWbZyGRt/E5mrV3IxMqd5N1MR9keua9RiRO4dtCkb?=
 =?iso-8859-1?Q?nyoDsKzIRrgCQuA028mEgJseOvPkZDKqos0YHb9HRjcQ+pjTdzMK/ta8jh?=
 =?iso-8859-1?Q?cRI4rEh4+I79jSHYN/lZDhJM3ZDzwX+JCQ?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: kyndryl.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY8PR14MB5931.namprd14.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 50e729c0-890d-4c2d-9897-08dceeed240d
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Oct 2024 20:49:05.8810
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f260df36-bc43-424c-8f44-c85226657b01
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hzwST/pmRmTvrcYasT0x6UhTmizRPgDCjg8geMiF11ytwwwj9RnNUMfP/6MBDQs5WA6OHowzaYq/uN8W4e/f/3oswIKUGsmQ8IDZoXoBSuw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR14MB4078
X-Proofpoint-GUID: R8dXJGuIgYNYYLvdoR-nE7CspDcXaQYJ
X-Proofpoint-ORIG-GUID: R8dXJGuIgYNYYLvdoR-nE7CspDcXaQYJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-05_02,2024-10-04_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 bulkscore=0
 suspectscore=0 clxscore=1011 priorityscore=1501 impostorscore=0
 lowpriorityscore=0 mlxlogscore=633 adultscore=0 malwarescore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410170139

I've not seen any clear indication if there are plans to have a JSON output=
 option for the 'ss' command.=0A=
=0A=
I would be very interested in that option existing.=0A=
=0A=
Scott Fields=0A=
Kyndryl=0A=
=0A=

