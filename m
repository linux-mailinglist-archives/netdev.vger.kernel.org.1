Return-Path: <netdev+bounces-109324-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D97C4927F31
	for <lists+netdev@lfdr.de>; Fri,  5 Jul 2024 01:51:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3173EB21103
	for <lists+netdev@lfdr.de>; Thu,  4 Jul 2024 23:51:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEB791442E8;
	Thu,  4 Jul 2024 23:51:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b="fYPkFOok"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-002e3701.pphosted.com (mx0b-002e3701.pphosted.com [148.163.143.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F5F4405F8
	for <netdev@vger.kernel.org>; Thu,  4 Jul 2024 23:51:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.143.35
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720137102; cv=fail; b=q9zZve324SXpkBE9UFAihdO71CTBdna8OUAu4zOlhw47hVJsv6vzEuugqXlnRjYxW0gElkJC3o/iMlT9N/lupEUcXyIsdzPvRGZma0llxHvkWq11uOjF3742YAze17imYOorroQO7Ng2fLMesvYNE2DacFY/KqKi6DxXLK1FZlQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720137102; c=relaxed/simple;
	bh=Tu7R4iMoiBcUqLAEyOG2GwQ0jmuM48yVrtbqtHHDlzU=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=V1z+SYnhvb1JT9i4mYsWFI7CtNQE2tv0qBLmWJqh36O8YBJIxzMF+I6n/C+iGdDiQ7la3gPaJVoO8fy6u50A3yIRczqOlRKZ4O4QbMEphgKFzVCv6uedhPXHQdVwpUKZy5jGsLhgW+W+B1i6L6Ijmch7EdRqwkMatNCJ1fUogXo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hpe.com; spf=pass smtp.mailfrom=hpe.com; dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b=fYPkFOok; arc=fail smtp.client-ip=148.163.143.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hpe.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hpe.com
Received: from pps.filterd (m0134424.ppops.net [127.0.0.1])
	by mx0b-002e3701.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 464Mf8xv009352
	for <netdev@vger.kernel.org>; Thu, 4 Jul 2024 23:51:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from
	:to:subject:date:message-id:content-type
	:content-transfer-encoding:mime-version; s=pps0720; bh=TGMVl1I4T
	ZpOrDKvkB82YxxdJqaVkU0lkOYfrYYZCFA=; b=fYPkFOokaoiOIx1g7AHdgJlC4
	NUNSBkGw4jsYbr2Xwkr86nyi2s9QHm/Lh5Da6tEydekatB1ZSr/v46d2pN4YPvyF
	RX0o/+2l7fhcYJZrMc2UYtF9dNaDmWMxzX50J/b4eblJKUjwyI/CLSSjgUzkL9Wx
	LQnvA5GT7Mj+OLaXYy33359jU+/59I8XmLwLsuT6UTzUEs8FgW1USJIqPXMTnxIc
	aLyfjZMQkQ/XQKvVGwG8PGdfRBlXh7jbvUTFUOlK+6fnTur+oD/59G1oIkunpXOn
	mUdgYDxdzvgL7s+dcHp0SHHRrPzrSxuibWx19PEEqNQlH3b8ROw/BwlFH7GtQ==
Received: from p1lg14879.it.hpe.com ([16.230.97.200])
	by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 405vy5twsh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <netdev@vger.kernel.org>; Thu, 04 Jul 2024 23:51:34 +0000 (GMT)
Received: from p1wg14925.americas.hpqcorp.net (unknown [10.119.18.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by p1lg14879.it.hpe.com (Postfix) with ESMTPS id EB6D61304D
	for <netdev@vger.kernel.org>; Thu,  4 Jul 2024 23:51:33 +0000 (UTC)
Received: from p1wg14927.americas.hpqcorp.net (10.119.18.117) by
 p1wg14925.americas.hpqcorp.net (10.119.18.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Thu, 4 Jul 2024 11:50:57 -1200
Received: from p1wg14924.americas.hpqcorp.net (10.119.18.113) by
 p1wg14927.americas.hpqcorp.net (10.119.18.117) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Thu, 4 Jul 2024 11:50:59 -1200
Received: from p1wg14921.americas.hpqcorp.net (16.230.19.124) by
 p1wg14924.americas.hpqcorp.net (10.119.18.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42
 via Frontend Transport; Thu, 4 Jul 2024 11:51:04 -1200
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (192.58.206.35)
 by edge.it.hpe.com (16.230.19.124) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Thu, 4 Jul 2024 11:51:06 -1200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Jetzk1bs9yt1fKnC3rxsjQJMudsCwv6pOeN7GI1JegG/v9mOmiGr7lIHzkVOYo3TuW7UVdJDdle/+TwY2ByBBnSmHhuM92a94chOCDxxmZMYouXckNVlgr2eqiCfx0rFWd3NSNozDtE7tY0fX6WF0N6tvV+0RNCwLlX0fdnkHrgrA4qrQMlYF/iXHiIyb0pD+fDoQDEqGeLisuoZj0Ngihvpbbg6jCjvavgsGO422p5eJ/seb2y46lqCMWUDYC+9XcmF4dFsoWCdK/Ok+V6hSbY1rUVAYhJzRXq04xACmqnhiZ86T5xHAmOOkqC6gkod14QdVhlmU3hxehf4i+OVjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TGMVl1I4TZpOrDKvkB82YxxdJqaVkU0lkOYfrYYZCFA=;
 b=GiEDBxlobDED+gxyS19HGxeve8r9tuPShxS9ETvnQM5dv5fTR1vg3DY/hV54Xj1k2waQJA7vr33a/Ult7Ahs4LS2ux0lhZulap+fSre/JabuBS2Kaa8jmSb88U76k5kPN++PTLj5vC1m82vHWURB9MeG8KiIiP/Zqr0TrxQrsZYibU1ngVSSUyV9JvRlNTDnzvPR15I3Fufijz+v/Ahdxm+0eV39dU9jJc1tCtBzev1SFPo/acNfiPuH2S//ZUKBuopGhPvpz1UzbOTzPxf90WV/u+7MRj+E/EwAmwD6fjM+LcytXyTLibjMh01ejYuc/1CTh5TOqIvhEvSPXsdZ9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hpe.com; dmarc=pass action=none header.from=hpe.com; dkim=pass
 header.d=hpe.com; arc=none
Received: from SJ0PR84MB2088.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:a03:437::8)
 by MW5PR84MB2249.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:303:1c7::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.29; Thu, 4 Jul
 2024 23:51:00 +0000
Received: from SJ0PR84MB2088.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::8cc2:658d:eae8:3d8d]) by SJ0PR84MB2088.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::8cc2:658d:eae8:3d8d%5]) with mapi id 15.20.7741.025; Thu, 4 Jul 2024
 23:50:59 +0000
From: "Muggeridge, Matt" <matt.muggeridge2@hpe.com>
To: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: iproute2 ECMP should display expiry for each nexthop
Thread-Topic: iproute2 ECMP should display expiry for each nexthop
Thread-Index: AdrObOvlCpIT08NaSkaSbp4oK68tqg==
Date: Thu, 4 Jul 2024 23:50:59 +0000
Message-ID: <SJ0PR84MB2088CF4614829F0A130DDE60D8DE2@SJ0PR84MB2088.NAMPRD84.PROD.OUTLOOK.COM>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR84MB2088:EE_|MW5PR84MB2249:EE_
x-ms-office365-filtering-correlation-id: fc178c9e-ece4-4b59-c421-08dc9c8427dd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?Nz/ab1YRmkWAT3hGBRP6XUjOkbFuKLwXy7DE4WmXCVv6Ury6c2LA+6cJbxS4?=
 =?us-ascii?Q?hCEpckJJPj2RXk203ZbJm7vKQkyiDQwZUO0El0+zwm0R+TXSXQNNcsllTo/r?=
 =?us-ascii?Q?ONxBwzNA/bJymXWHd17ECKBJpBAR7hPP9U90t93DBgjXp0s1yKHZQyxBMQx2?=
 =?us-ascii?Q?R+aDWJLYU6L58Tg5Tla7HV3dJHwteWtInVd3y+z97fs1gIiBFipv4pYNHdcJ?=
 =?us-ascii?Q?d60Mc8gYb8D/lsfYsumxj8W2dD4DcUDln8au4+ZQQHVHD2QeXRtp0185bs7o?=
 =?us-ascii?Q?a2qY8FIyOtoZpgti+1cz7Xu67juz6kpuKz3kkg+rabK6JPidJHwMahbOVkYs?=
 =?us-ascii?Q?PsEFan7n3SHZ3PVlFwn/3xaVb7dYO8HJEsZbDxd7q6wI7bRfA7V8aisw/AeL?=
 =?us-ascii?Q?dF0mkRCJubkucrnmcPFV0RqhkiUSQgL4Su5B0j15ls86wm/GcE+UjkU9Yr1F?=
 =?us-ascii?Q?tU7pLRxVp4eWc4hViV1/V3ZzP3yETxRQO52OA6ba6KM3K2RV7ew2nARdxqDK?=
 =?us-ascii?Q?beGzz4585l867NmjcitNjdi1TPDD5LFUGr75qMvcEMEL6zt6UcKfjAQs0KvM?=
 =?us-ascii?Q?TnAdeD/OnX8RPkI9GRYcu8fZCFdwKaJ7/keOOqZZqKowlqiaNRmftnZ2deHT?=
 =?us-ascii?Q?UO7X7hdED2/+eokITyG79YwvyMJdCuH+eDEcKHvu9YxC36JaI9Cwn8Mjipc2?=
 =?us-ascii?Q?8HPeFRZYle7ZZdZVlfPNUyH9iZ8SFpb5wjiX+5OvHaMN30RVoT6yklw9jlC3?=
 =?us-ascii?Q?6XW/YP+/hb4MkwKSqpflJxqJWvit7jWNDg+in6dyLgeRzK7oGPPScrawFJTc?=
 =?us-ascii?Q?yA3Hd7lz+xhwL0djvNKo2DVbybuNF2zUELX2vLRBvA/9OpKjXghofpbcIQwd?=
 =?us-ascii?Q?6xD91Rpgvcajo69Yyg4KB6VAzAALqu7DqyqJm5RBfvhXTlN5QdlNtvFF4TwP?=
 =?us-ascii?Q?b4IMN+vL6L2t6lP/xw4ONQucYkmBZi6qXQUHujTT71kP+d9hAicWrgFiPaCr?=
 =?us-ascii?Q?nbU3FgRPXfXyZImI3j88QZYEyHlngnbn0D89mRftG7hexMqIR2A0CGbJUxX8?=
 =?us-ascii?Q?IV72lNrr+geAmT/AoCTjugbWC2CRi8fYeaOz6lQJDPYyz29OS4T2SN5vjGQz?=
 =?us-ascii?Q?vVkPNqqI3iTTo0BiYzbUJKbFWdnZ9n7PEwt9a4p66G6Lyh8jii0TrX9jy2gU?=
 =?us-ascii?Q?R0bLfDNxafsF6fw9XXKkstpHbF1S3JxOVYHc/uMKgDKiEVg55nfdh59KuCIQ?=
 =?us-ascii?Q?AAV4D/GF1NID4dLXOpee2Hktind1VId8qIUvfqGKv7IUYsohh2b75hjsNs1L?=
 =?us-ascii?Q?nKUz+5tS4Rcf97YnjvrNk8PFCmFF5XRm0ot2J46yKoz6IrTdbawsegM7J0Xm?=
 =?us-ascii?Q?cr85UC0LucR9vUqSiDCbss7Y2hrHAHbMEGXLS8tMrLqQ7R/IYA=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR84MB2088.NAMPRD84.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?W7FSncmc9vMyxgS0DOfF2yHUgC2rBTx/H7v5jmOyMmUNAoPOzdO4eA8d4fi4?=
 =?us-ascii?Q?UEZ+Kj+3ZIPk7i/ZERx/rX5YtOt75cndgfXprgjqMZoEO/bQohJy+fUSyaLB?=
 =?us-ascii?Q?nx/7fQVup1KCVj2G5MmzVz2uFSBH8Hj7iE87Ole4vGsiykuI24dpQ4ESZ4R7?=
 =?us-ascii?Q?VJVkwbYnLy4w0Zidk7yjNJZgUJFFt058Aj/PyGjRchvBTx3fQ2G+N/i+0NW1?=
 =?us-ascii?Q?uUPT6rwFo8Q0xyfZlbTQKvl4l5nIzbPBjXswtfAFeszWYFzhCpKzkVK05Esv?=
 =?us-ascii?Q?eqr0KxPSxyzHXRneAdq0vQBVuV7ClyP4PeWMMB4g8xGdjt2gu97dmOQiHr1X?=
 =?us-ascii?Q?lnUkcm3vA4mnEgkS7z0mCWDVPRjqMXJWylew9ykospvEhIhhkisf0WfIOAW7?=
 =?us-ascii?Q?Xo1szrptO3J0AVHJ0cw3GMMaYlskQ8fB21MnNqA1P1Pmuwy+IOjopptvxD9Q?=
 =?us-ascii?Q?DA63DAbUwotLE6Js9krFC5s8zSsNTtcuIYgs6/1x9mQMYLcH2n1LCdrPQKt0?=
 =?us-ascii?Q?ajGxnjQD73Jkaiv4lT6BgqFEiBiKU73ggWYV1lcmWn5GtiPMVNje2ICyxnAH?=
 =?us-ascii?Q?uy+oV7KwZIqmMViorYfE9vNoR+rgPhyAXOpKRJRrPjM5aStqyMOZUf58b01F?=
 =?us-ascii?Q?jeBKTubwh1COzEUSEF8DFfw9S2FMRFIfsZtDajvsPW4/zsYMvsViZY+9S42y?=
 =?us-ascii?Q?26Wx41Qld8tarHYgORp55l68+pQkRKygu2TZ/pe7LSuioi39XVt/eA9Ih5Ij?=
 =?us-ascii?Q?TOaSePY+M1y2RCFfcMCeJkAy12or92CIHfszwmfjYmisFA2hXZpnFqorqDuH?=
 =?us-ascii?Q?V0OVrkQg//py87l6rNVw+eymr1t+AtfZHIvjNrEB4PaulSqqqXnbj00FhYbQ?=
 =?us-ascii?Q?uln53cPR8cVbt1EwtS2vQfqWdMDvFbR+QH55AUVIgBMDkhsauiOjfR6rQ1IF?=
 =?us-ascii?Q?6VMu5+btT6iwmVlNTLhN6MT2gc/HuBoxH2pJBXmkRfz1bymUYWryTX8ukzBj?=
 =?us-ascii?Q?0cb9Jjz6ldby+5IDfir823HXcwaCdwOjvln+s7KbwyPA+nVeoeobIUwMi7hd?=
 =?us-ascii?Q?r7Y14BOiFP0wIhii/Ps22+XRhpsiURYb6DDghClNWTso4ZNSUDuLsWslHd1I?=
 =?us-ascii?Q?xKOFTn3jSO5rOTkMmjiKk+RLJ9bJsy0MJWP/SiPXPOTbORllHMx39ATLmFWU?=
 =?us-ascii?Q?HJkUYUn83hU+Dpk4ZW7WmZboErDgijMJYiyDkFZ9cLd94WiXfD3qj36duqkH?=
 =?us-ascii?Q?rp2nSVAqV8/bXz79jeZHTMJT1+YAUclOQIgsQoCUTKrgJwNzAJel6fKsKesp?=
 =?us-ascii?Q?OlICWLbJcpWhr5GDWqCGtHKVIzds7W5AQLa4SK2Kc/zXc4LGeVDNgbpfthyK?=
 =?us-ascii?Q?SxqPxnZdz7Fk+Qs4K/Ps4WgUDq6zwTDAOTP1ofGq1hwK17eUbls5EcJeWhvR?=
 =?us-ascii?Q?s6wjWjIIk3TjsGTF1hEAqjMElRThn4Sm+YFb4QshnUOGLR1SaRg+3AO3WS8i?=
 =?us-ascii?Q?Q8BRxOmDTEm1xdGVBlzWoBaUCTueG9JkFu8eemHMFS8b432nxudBFZ8O0Zmb?=
 =?us-ascii?Q?zIq5GlXrNO8bIsCLbRBzyOu955VAb3uo4Dy70v1j?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: fc178c9e-ece4-4b59-c421-08dc9c8427dd
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jul 2024 23:50:59.8090
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Xl0Cs1iHpN73zAt4ZYQsQJJ2FALNvpago9C+vUlVofijUhzY2p5i9naQ4X9dBbERHCExZNJTfmftiq2IXCTJtW1iQzHLGr+2fuGp7QhEkqE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR84MB2249
X-OriginatorOrg: hpe.com
X-Proofpoint-ORIG-GUID: i61tqjeM08g9fGVh0uYyOqHcSOEKedcl
X-Proofpoint-GUID: i61tqjeM08g9fGVh0uYyOqHcSOEKedcl
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-04_19,2024-07-03_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 phishscore=0
 adultscore=0 malwarescore=0 suspectscore=0 lowpriorityscore=0
 priorityscore=1501 mlxlogscore=920 clxscore=1031 impostorscore=0
 bulkscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2407040174

The output from iproute2 is misleading. It shows an expiry time in the head=
er
of the nexthop list, which suggests all nexthops are goverened by the same
expiry time. However, my testing proves that is not the case. Each nexthop
expires according to its own expiration.

E.g. imagine a host receives an RA with lifetime=3D10s from TR1. Then 5 sec=
onds
later, it receives an RA with lifetime=3D10s from TR2. iproute2 displays th=
em as:


$ ip -6 route
default proto ra metric 2048 expires 6sec pref medium
        nexthop via fe80::200:10ff:fe10:1061 dev enp0s9 weight 1
        nexthop via fe80::200:10ff:fe10:1060 dev enp0s9 weight 1


From the output, you would be forgiven for thinking that both nexthops will
expire in 6 seconds. However, they expire according to their own lifetimes.
In this example, TR2 expires 5s after TR1, since that's when they were rece=
ived.

FWIW, my Ubuntu 24.04 system uses networkd, which configures routes via Net=
Link.

Matt.


