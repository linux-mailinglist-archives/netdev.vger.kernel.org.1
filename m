Return-Path: <netdev+bounces-108714-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 43E2E9250CB
	for <lists+netdev@lfdr.de>; Wed,  3 Jul 2024 06:06:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 32AA5B2B8EE
	for <lists+netdev@lfdr.de>; Wed,  3 Jul 2024 04:04:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF8F14501E;
	Wed,  3 Jul 2024 04:00:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b="gk7U7Ioq"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-002e3701.pphosted.com (mx0a-002e3701.pphosted.com [148.163.147.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F78E3CF74
	for <netdev@vger.kernel.org>; Wed,  3 Jul 2024 04:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.147.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719979257; cv=fail; b=Nd6Ki9BXFb7uSJ2sT3N0y79QH+IFvLX8nVMX3ZJJTDQ8d8vZ7KXzvr5llhD8MEjYVMVC7S02EAJBRzJteZQ3YJ1LYuRdHz+4f7VIfnbleqj9TTS1ddyispx+8eG86O3jtvZpfcC+i/e4WFnbnz2sumOoQWAtVm8TLwDy6qLs79c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719979257; c=relaxed/simple;
	bh=oLAeFXZaoM/E2Rf+hXxqGOR2/cyYH+5G2yuqU3jZ0dg=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=HhHSc3io1CW8EY3CebzrqCfwzPcx3usw85IMbI/FmUFMeOS7u/GVUxMCYCdmgYzyixtOUrj6xZeEU20Ea1ZfXAnwpLass4BSpRA5AElGWYaLThKB8otZhlNjN+bGE3ZTV7ZnLHx5GnjPZkL0hAVYr/yanEvf4zYbQSm2bWEAOYo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hpe.com; spf=pass smtp.mailfrom=hpe.com; dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b=gk7U7Ioq; arc=fail smtp.client-ip=148.163.147.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hpe.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hpe.com
Received: from pps.filterd (m0148663.ppops.net [127.0.0.1])
	by mx0a-002e3701.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4633Mh5R008304
	for <netdev@vger.kernel.org>; Wed, 3 Jul 2024 04:00:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from
	:to:subject:date:message-id:content-type
	:content-transfer-encoding:mime-version; s=pps0720; bh=UbrYEct4c
	A02Pr+v1drbD/mED3zd+c1LP54gzRmbefA=; b=gk7U7Ioqm7Qv8DYL2+8VKFdow
	XGdShUBrJst7Dwi0P4sH70niE305o5ZUMX99xnKqssSvrpBXF7sQxgqKV0fCDW3S
	oqVfOx4KrA9uFVuBKPDNCxcuNpnOTQqZVOmzGvfFr5LXuk/vlivZjYIcam8aznYT
	K+RQyvneyGZsEGfBId8Teyk00/T42TQwvX51OFmTW3TnGRu0PT9Vggr4U1VSgAuT
	5yRhudVIpYkKMgBOSJRQ9EWkQ+hIALH2bNdzGIWo7HiuROxOtDPHopQM+y11NVrO
	ZmQ+uxZn4CaimTbzx+Oz46ANaHB3S8Q6sorEDhOoQm4ki+ZeQrXRk89Y3uUsw==
Received: from p1lg14881.it.hpe.com ([16.230.97.202])
	by mx0a-002e3701.pphosted.com (PPS) with ESMTPS id 404xp506q0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <netdev@vger.kernel.org>; Wed, 03 Jul 2024 04:00:47 +0000 (GMT)
Received: from p1wg14926.americas.hpqcorp.net (unknown [10.119.18.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by p1lg14881.it.hpe.com (Postfix) with ESMTPS id C99FB8059E9
	for <netdev@vger.kernel.org>; Wed,  3 Jul 2024 04:00:46 +0000 (UTC)
Received: from p1wg14928.americas.hpqcorp.net (10.119.18.116) by
 p1wg14926.americas.hpqcorp.net (10.119.18.115) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Tue, 2 Jul 2024 16:00:52 -1200
Received: from p1wg14919.americas.hpqcorp.net (16.230.19.122) by
 p1wg14928.americas.hpqcorp.net (10.119.18.116) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42
 via Frontend Transport; Tue, 2 Jul 2024 16:00:39 -1200
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (192.58.206.35)
 by edge.it.hpe.com (16.230.19.122) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Tue, 2 Jul 2024 16:00:46 -1200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SVeYS7iv3F1PTxSKxRNeii/hTLnDekUz7PI2SrPiVitIN0Gg0Bir/NSg2UE1pG/308ej3VjlRJ1ApP4ONPM26z6f6khFDOYXmNlH9+pfA18thbv51nzYa9ow/twvcGromfBApum5G/0ckKosfor6y26Em7rmqu1SXCtxnqZxaQoSEZkDQcQRTLdmmDdYiHrHxDccHeekWz19wiPJFW5ipiI4cua1/8jQ6mb+8zARx6sDozYOrxKM0gJyWw1nNQakZMQu9CFxshVWL+WOPEKeXqLV9bFJt7pFmS+8WJP/xLg9SS7i5fR5MLo/SyGPdy/ovWoMjSk/593XYOlBU5Wn6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UbrYEct4cA02Pr+v1drbD/mED3zd+c1LP54gzRmbefA=;
 b=BoCc7rHEwBjPk2nXOv7y0bARtkSgRBF6kDR1HwAQgrvYWHhZGAI9+C7NbW3dmQpkrMkEN8rufpgrKORh5qB/o51vraZJVb9MibzCsIJWaFlKnm9z1e2g1+Os8N8SpnjFxJWyPKRiLFLuP24VoFYZDP87EScBNONaQ1J/W5EdLK8nDsPRg26lMvC1p4okpan3xB//0m0G1bwasMIxoU2A9gjXu8JyvbewMLy0LfLaJMZUeM1Nu94O4mc2F3LXZPs7CHjtuCAsbzVEi0lPAFKoGG1NvNDJVnzJPbvbGt+xO6tPqCKk+c6t8ejWBu6e1DmO1pQYrgo0bYjN0oPdQ0liJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hpe.com; dmarc=pass action=none header.from=hpe.com; dkim=pass
 header.d=hpe.com; arc=none
Received: from SJ0PR84MB2088.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:a03:437::8)
 by PH7PR84MB1488.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:510:153::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.25; Wed, 3 Jul
 2024 04:00:44 +0000
Received: from SJ0PR84MB2088.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::8cc2:658d:eae8:3d8d]) by SJ0PR84MB2088.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::8cc2:658d:eae8:3d8d%5]) with mapi id 15.20.7719.028; Wed, 3 Jul 2024
 04:00:44 +0000
From: "Muggeridge, Matt" <matt.muggeridge2@hpe.com>
To: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: "ip route show dev enp0s9" does not show all routes for enp0s9
Thread-Topic: Re: "ip route show dev enp0s9" does not show all routes for
 enp0s9
Thread-Index: AdrM/ZOI0POuNnJMRMKxe+DaRgIebw==
Date: Wed, 3 Jul 2024 04:00:44 +0000
Message-ID: <SJ0PR84MB2088D9C951AF8B39C631950DD8DD2@SJ0PR84MB2088.NAMPRD84.PROD.OUTLOOK.COM>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR84MB2088:EE_|PH7PR84MB1488:EE_
x-ms-office365-filtering-correlation-id: 7f5c16e8-6bbc-420b-b5d1-08dc9b14b6b8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?TmOEEBSAy8U1TV3zbvXAp368MpnXoHIv706n4q6OBj3NhAu19ILgYA6z6Eww?=
 =?us-ascii?Q?akZ7K7cJplTO3V27lKlZ5welUdHQBzwlQurwIQpvwAYG7+R6gRPATrkk5ujp?=
 =?us-ascii?Q?d4+Tc3fp1nV6TxyQyMMpzjzaS0fnYpMY+moUAFoNG+QGibXbzyj45Uo0MmNw?=
 =?us-ascii?Q?YlhIkDQRG6wd1ToKie0LRSIuq1otdDJBp1Xis3j9Fnhf8faWmtv5eb5IG8ew?=
 =?us-ascii?Q?Ej31A8zhmcr5zXEjqdy8EZQcbVmxpcdPLn8MXoM1BS7W5xLxQx5syplfrvpg?=
 =?us-ascii?Q?Jyw29WytVO05qHhzkbqUQyQK5hntIcKw4HA/iJP1jYierqCdeeo70dVsMeU7?=
 =?us-ascii?Q?CIAVKRVMH6/oN1u/pMDO/NUkjPboVe+nLNJoJ1DHoRIqnuU4+0CVzfwVYrxj?=
 =?us-ascii?Q?/R3k/8YVtqe7QTrKXjOkMLO3wEDFsDiUUhUOgMJ1vhBbJazPkFmN0VZiZVVe?=
 =?us-ascii?Q?jX34JwsrdIr8BdEmYny56J/v9UaQuTt4w9nsggd2YQQNn5cpdlPTmagFr4s1?=
 =?us-ascii?Q?MbZOD/lAGLCSjOcs+Mg3iTbvmSmrf/dRTGfBe8t+bCmfp670HT8wIeX9J0+r?=
 =?us-ascii?Q?7mXsv9qEGZywhAs5ajaC2pndAoDaMkE+BTkkoP00YsdjQE8wDS3YF/SmYn+w?=
 =?us-ascii?Q?H4H+mEq+/36JCMM7dhsRaQDMcBZs3iJWs55DII5G5NTjnWiVuYzihMZEoh/P?=
 =?us-ascii?Q?rDnrG7WuUU+wfkK6bwWPlO6vIkcepiLOpk8nFBMBCsFdVgguBQUKTw4E+DWx?=
 =?us-ascii?Q?mwjJZeKLafeCV2gNogXM3YMPlo7wWt77iVdqyxSrnDQJmGG4/lq6+8jUSVg7?=
 =?us-ascii?Q?7KIVWLajV/KMv/wlxP6vRNJtrFwI9KmxLDUeGdSgn9mbMScIz6pBasJt1Lzb?=
 =?us-ascii?Q?XhZ158BjmLDrDRy8ZEDTW2uTYTOF23ncoTXphe7rE2gpRXsUuhgBMBTwMvpy?=
 =?us-ascii?Q?gesWYJHe0p2au8HazihnZtJ1y0j+FK0nGCrYvBFc/j+zAaZYkKzyZlEIaUq+?=
 =?us-ascii?Q?eSNcJ9i/xz+p9VQQ3QI5cHQwBwPoKzoTTU3T9ZIXsvDuTpR8TqMUwf7H7mWM?=
 =?us-ascii?Q?Cgj97Tf6hd/SYI+6KmQF8o1FKxJQrtIbepOwWEOv30qTl7Q31ZTLH9FpTMo5?=
 =?us-ascii?Q?sJ+4gDG8q3K20eMxcw/4GqKT4e0aCBvtS5TzGQhCHfD3vIv0NgnlFPX/cxdZ?=
 =?us-ascii?Q?F/J2TjFL7oeCmV0SIepFKsgZnxYZlw0tXNoD9HHOvyumk165/oDGSBR0eFAH?=
 =?us-ascii?Q?tPMWZmtZfWsuo5huadq6O31HG3PpoF6EFKm8RvsINLn10FucpeCN2NfQzIr3?=
 =?us-ascii?Q?VQ6Px761so74tsWZgvRfg4X07x0+fgaC/TCYHndcbO3p3FVMHdQqrcX9UusE?=
 =?us-ascii?Q?BqX8B3v5gqrwqQbdQv3ykWCa3ftzsp9poCv4hykyi8xmR9pbsw=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR84MB2088.NAMPRD84.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?kOeCfKmJ/VZZJgLSR8A9Mq0WUM0lAu7hMLkcrNmDGL9mc238JOdxrJWQUdbc?=
 =?us-ascii?Q?aG4ASgVVsouuyhm7zxT5TDIBbkSJUf0x1DlU33EwOXIR9Sc5v50B8/dT3M8t?=
 =?us-ascii?Q?S87+XDgqqysEJvrlbUi1/z7nue+NVY3kJzYtA+SDEnG2HhopAooOFhvVFH46?=
 =?us-ascii?Q?wLNiehofKT1NW/WdMELN1XiqfvEExyytN4uOgCHY3q1Aiy3+vmTIJoa5LuNf?=
 =?us-ascii?Q?Jg+mKpjtZtpWt0ksO7loc1CIrTCTpU96SwC5qNGzH5/BlWx5wdwVjoUAzbdr?=
 =?us-ascii?Q?/zv2KQh5Tu+4NAQ60ADQqNnR+0dCE6DkR/6O7y8JqbaliwoeutLZPezhV854?=
 =?us-ascii?Q?uY4ISPIYc3mAuz86zqKB+4N6FqcJkyUQRr0WG6Vpn1Cl3iPfPCYUAn0L1RK+?=
 =?us-ascii?Q?y3eKinCwyYVVukDZ3teHf7Kf2n1rXE7nmnHHN4JK5YPLjK7+Z1RK/dAU2Pqh?=
 =?us-ascii?Q?GYGXuZ75dMJHx63SGVDa/+dmt/tlhCOMVTzMx3YuOcwAy490ShbW+m9DniIa?=
 =?us-ascii?Q?3hflnuwOsnTJpexKJ5OPOkwV5TTkkeZ9Bq1z9F06jG5kd9dj23eL31B5l5VG?=
 =?us-ascii?Q?P1lQ1NGbGcvG72s0mc4/YT4Ehadq/JZupG+ph855JWHeE60RpEwXPm5e/Zip?=
 =?us-ascii?Q?q0DVdBITcmYoxl8gyzpnXF76XsFFUxlj8QXab80zEAzzc+AH6hzThxS+4sMz?=
 =?us-ascii?Q?t/SUwO/4Iqg8hKTifTBkzNcj0spGt+2j5ISGgaoz44NoCra39/W4aPHQM+bT?=
 =?us-ascii?Q?tRxYPh6RQ+VHgPuogypFamMZPksj6MJt/dGfEsD2L8KMLx3U5Sw3jbFeKBJ/?=
 =?us-ascii?Q?z396xzOBtR/eUbPyE+hM8eChI3jH3r6BWhiZBaECXBauIO1p9L34f44HS9Jx?=
 =?us-ascii?Q?I/sasqkZl/EHrGUc7J+20I9Bhy/fz5uzLrxmRaj9u4a6DPcT6GE9eF0YwPWn?=
 =?us-ascii?Q?0uj5snD9zFhgPu196TwbEhdieNqZV2PqknWMGV1yU1oXrfLDGVE8jQIRjszD?=
 =?us-ascii?Q?/YOHBIY+nXAHE/zRMIWQ8xYrldbo2Y9u8hRtCgq2QzxocSzO68kSPzYfIQU+?=
 =?us-ascii?Q?r7rotgZURsN14WJHIc/keLKH7cXC+tMvVyyKAbHl2qQX5ndot1yLu4rvrUS+?=
 =?us-ascii?Q?K/QNo6OEBdO1uCLok44Hp1vwJaCA+Nxj7WU3uwl8vCeU6n4f8vwGgYEFRieC?=
 =?us-ascii?Q?hbgGA89B1lD8XcZOjmFIoedkgVYKeFc1aOvKKnh4wBrem3XA/r5/fzzGJDBk?=
 =?us-ascii?Q?Gv/MefwOEQ+bcgzFrhaWCRDasSQibvMIOSQvqMxSs742ycUfEYoIEDLmlwD0?=
 =?us-ascii?Q?W+z0BEgWWHZw3m6BOh7J2AXBK1Ch3zIrP96koJU8Y0o4L7szrzGyGZi1a8vV?=
 =?us-ascii?Q?T72bwVoBjY7hYZdx1hAmO56AIE8n2NIrkxzkPCchpyyIi98pDSCo6ebMlMbl?=
 =?us-ascii?Q?wHHHBHPcZPGgUqS+S5GaV+AT3vxP3kgKM9lW1a+dJEKBvXHbq5zU5v0oV3Iq?=
 =?us-ascii?Q?ALVUBYzOUbsQtHSfbW/JZlqT9Jj71N/hfL9E5mR+A7mmlqgJuSi/nySVO10L?=
 =?us-ascii?Q?2zRjyzyATK/Yn3l50YA4KCXNA4Eqm6wLdQeRl9P8?=
Content-Type: text/plain; charset="us-ascii"
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR84MB2088.NAMPRD84.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f5c16e8-6bbc-420b-b5d1-08dc9b14b6b8
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jul 2024 04:00:44.6789
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 69I7VrycoY/OtnGE5tEPAZZFp/IPo0NFD5CgNjZfXyxuWSmNPFS2Hqp2crcbhISKWYb//q7qHOlZzdzn3p67nlcD/KqN2o1ACXQy3Wq9XT8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR84MB1488
X-OriginatorOrg: hpe.com
X-Proofpoint-GUID: 5Z1vGzwFrCLBnQ1LnRmFcoDMNEk4CVKU
X-Proofpoint-ORIG-GUID: 5Z1vGzwFrCLBnQ1LnRmFcoDMNEk4CVKU
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-02_18,2024-07-02_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 suspectscore=0
 mlxscore=0 priorityscore=1501 clxscore=1031 spamscore=0 lowpriorityscore=0
 bulkscore=0 adultscore=0 mlxlogscore=488 impostorscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2406140001
 definitions=main-2407030028

> On Sun, Jun 30, 2024 at 09:23:08AM -0700, Stephen Hemminger wrote:
> >  Good catch, original code did not handle multipath in filtering.
> > =20
> >  Suggest moving the loop into helper function for clarity
>=20
> Thanks, looks good. Do you want to submit it?
>=20
> You can add:
>=20
> Reviewed-by: Ido Schimmel mailto:idosch@nvidia.com

Just wondering which repo this will find its way into.  I sleuthed
your repos and the iproute2 repo but could not find it.

Thanks,
Matt.


