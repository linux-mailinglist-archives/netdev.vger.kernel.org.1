Return-Path: <netdev+bounces-244932-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D2F9CC3294
	for <lists+netdev@lfdr.de>; Tue, 16 Dec 2025 14:23:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 1E714300887F
	for <lists+netdev@lfdr.de>; Tue, 16 Dec 2025 13:23:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 516FC3BCC5D;
	Tue, 16 Dec 2025 13:15:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="caUaHN1U"
X-Original-To: netdev@vger.kernel.org
Received: from OS8PR02CU002.outbound.protection.outlook.com (mail-japanwestazolkn19012061.outbound.protection.outlook.com [52.103.66.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AC183BCC24;
	Tue, 16 Dec 2025 13:15:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.66.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765890954; cv=fail; b=S3fLjTfqPGZZgnnXANWWGQ18y2trhA1WaBHeNhX7IxAMP+JuCwiGkcmr+MymzBFM76QJzJSsvPdX6yMLyMtx/bruReuR8YYr7blANctWiHcFcj2WV4lqYJy7aNzJnSpgF1AKAMRsigYgLuXh0ueKwBYJ8QRkXa0M70/qOcG8fRo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765890954; c=relaxed/simple;
	bh=28L+OnKJ+A923OLqpiJ4aX3eifGbtCWcCnd7sKMlkz0=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=DoUz9UaBgSMaUWxC9diuH2lnRKOwarYz8BvxjewtUcWLHY6doIjZr54F3ZLvK/S8TlmKViiqCt+8QDj7TU54Ky3zshHhUPw1UR3T4nbp0dYHSW6GSmxms7J+CflzEtTrqY4DFE4YBG+0Qdjmszs7H9iNINgy9GqtSEk79Fu7OKQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=caUaHN1U; arc=fail smtp.client-ip=52.103.66.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pIJacfvix9OsYPRi72f3LMbfYPrRXfdzkKRLejbpViZJY9oC4mpqUG8/yPRWDbXs6gun3Qk1XqRWBQ/ePAJO7xXG2E471vErrAfog6B3iCibLyOOl5UzurVUjYnUvankyVf/BglplqlM69U2uREbHg2TE231ZAsCMe5aaOHs74kkYdSjl5NKjGYdOraVXUc9PXI1Tn72fSj9bIppohEudl0VG8hAQnzEsFjS3/OnRKzy+NA50vx14OkHtV8tsJgghBJTs7Wk20oE1wuinsqKtBmQ9sL4YfNsaoeZ5jmMaJksx/9yCbWlBJjpJ0ln+m7LzXibwvt/r3yCyF13zWL0nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=28L+OnKJ+A923OLqpiJ4aX3eifGbtCWcCnd7sKMlkz0=;
 b=doDqQ9AFXYyjSO8Xc/jk9QVRjlH9Mfj5v9EhR5s0bg/A8Qgga+IkwELCfa56DlRcVEYHvbxDX8X/wu5x+EPEwBQS0UIqR3odda4kZKH1Q5HgdLARmcdfWf8U63Er+vgDCJKBzMt5aMCCNVL8ohF09lY15SHdAyUh8KcT3oqLM9audgixS+bDkwcqix4BkAzqe8MJe+lQgFezLrKFifoXfuoVn4AjJEGZsMhbLoLdcHm/ZfbQPRp0pjHSxxZT8fDlrt62EP2nic6z+uwsOkx/jqJ13Hg4SkAOJB00tYpeap+3Krs3RLa7Ed9u3m5uf5bKNoneO7ZUxJ5mxJEsCRhuTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=28L+OnKJ+A923OLqpiJ4aX3eifGbtCWcCnd7sKMlkz0=;
 b=caUaHN1USA9iDAOLlMyJRdNYlovYRpToJe7jlN9eBIhXaYltIeZR+kUxVZ0KYxBvX/vxs7DX+EbSjvA+jGX+6VVQBs+dEOUA+WL82jghx4rnjhdkmURHox4scBCrDI/4bDmxZD/OfTsNuXeans4VFNgLNy5TYNNglur1I9y51vpDeDoJLjwzsbWJub/k/Lylj+7zhcFK3m4wbIfpAqgGX45nclFiXiQL7SQMUVENFoZy2PYye4rAlKBHw9rBiUNXADrnxjRFcYf9ePrDLp9lMvevcVfQDdGRaWWDg8dZucXJa6Ilhmn8/u+z/KCkxJobqK9/DoOwXoc5A5RZ09kjow==
Received: from SEYPR06MB6523.apcprd06.prod.outlook.com (2603:1096:101:172::5)
 by TY0PR06MB5529.apcprd06.prod.outlook.com (2603:1096:400:27b::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.16; Tue, 16 Dec
 2025 13:15:47 +0000
Received: from SEYPR06MB6523.apcprd06.prod.outlook.com
 ([fe80::4f9d:bbfb:647d:e75f]) by SEYPR06MB6523.apcprd06.prod.outlook.com
 ([fe80::4f9d:bbfb:647d:e75f%3]) with mapi id 15.20.9412.005; Tue, 16 Dec 2025
 13:15:47 +0000
From: Abdullah Alomani <the.omania@outlook.com>
To: "davem@davemloft.net" <davem@davemloft.net>, "edumazet@google.com"
	<edumazet@google.com>, "kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>, "horms@kernel.org"
	<horms@kernel.org>, "corbet@lwn.net" <corbet@lwn.net>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH] net: docs: fix grammar in ARCnet option description
Thread-Topic: [PATCH] net: docs: fix grammar in ARCnet option description
Thread-Index: AQHcbo2JmIxljV+VPEKpkghv2TswDw==
Date: Tue, 16 Dec 2025 13:15:47 +0000
Message-ID:
 <SEYPR06MB6523D44E490FF177C47BEEBA8EAAA@SEYPR06MB6523.apcprd06.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEYPR06MB6523:EE_|TY0PR06MB5529:EE_
x-ms-office365-filtering-correlation-id: 664c276c-a161-4d2a-a751-08de3ca53a2a
x-ms-exchange-slblob-mailprops:
 WaIXnCbdHrPy8Gg0T1tV+ubdyTLMpos/snyI24PheMoMBlZKszerqKs2iN4XOwDa97X+Ax9Ox1enI8GaqjuT/QFTHzCjC1NoMXslBeu/FLvT+uHBCsDVVPjhi4mSuLFGAJKcEG/NXACHOmoinl1KzczX0QxObuklMo7zieV2Nfngg97qJ2bNnKNUeQb0xP9ljf8S+Jwhadn3KMv5iFLi+uOLcoQoZINHREEVT1AFVVDUPxsRpFd3tcuORBr2NhrkEkBEUWJD9Ez+Sajeb4TTFdQE6URc4ytY8OFhHsxG7FJ2Q7QpD3vxx1ANe2uMMHZQyQM1SjBDxW6izQprZjUBhPwGXg+hXaxpbIUuvvyKuERtYazIYpgE01HsAbNmgd95YUqFB46SEB92UnrAHJdm8Y6HjdwFnIMP5ngZfVgd4KT6ifdsLq1Ogaic6XfO8zEgVXmbZbWa5osfHIsPAk5fzUZlcRN5YDXlSfeq+ZPFC1O/teUVjaC38b1TPZq8lvRzfQX8H9tayWDac3E15is8vRDDcYxcTkjrd/sx5xnk2Hoi5Z7GIv0ceZtDqy/WxaxEoEm6rSsvXpn3omZajoOCI9LVntp4jjmf9vbGp3ev2ZqzGg+cg1Bj+Mi6ASJyuzgM1/VZ2vgn8uQGKijOLFAgfDuygjJJISb9RHdu5udPknPPVjEDfOrd97mxE+ITJXPPrDcZYsttj5GDWAtkV/HYureYeYL2trC8InD9TvAlT6HSM5MuAr2+UkRP4uGpbC60jrIjS/4qNbQ=
x-microsoft-antispam:
 BCL:0;ARA:14566002|51005399006|19110799012|31061999003|461199028|15080799012|15030799006|8060799015|8062599012|440099028|3412199025|40105399003|102099032;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?UtMJSBqnEfqNq6lsBed8lwC4fugOqPLdoe0kEzdMU5XRDo//AyhdSybpCN?=
 =?iso-8859-1?Q?YRf4rt/TcJ1JD8rB8jqAYaPkj4tZGTxOF655gs9Gm1dsUyU2pJsBTcy83u?=
 =?iso-8859-1?Q?yYT9dGgo5kXe2cZ1pesvBDx1E3hkhFtYELdx9uPc0SCqQHXzzd2Rd921KG?=
 =?iso-8859-1?Q?NhCecQA+RszhUoDdr768i2lghOPlJyceRRq+JzbZsF4NldnJB7p6kGnrsF?=
 =?iso-8859-1?Q?c8jl139s6oShzvBbE4f9QC2JS1odFV52r9F8WfZnjIWal5BPIWLqTqqh1q?=
 =?iso-8859-1?Q?XP3LHLeLpDK6gexuLYPoREhUjro+p5t8KypQGj4kycpm94YlYCzOSyumS5?=
 =?iso-8859-1?Q?XHSizCDVfVYrJx24N6BP4BbeZNmzjM0BjPZgZM2Tic5e2oGPUOPssbZa2R?=
 =?iso-8859-1?Q?4G6wRctSJ+Ws8h03yqoYJn/nmQo2CmT/mzO6BWJ6kXEBT5rKDbZ8OstDNh?=
 =?iso-8859-1?Q?rUvnncxYZUAR2AeMaTbQ1b0BTBCqZQqkE+pwXNkg3iYDu4KLxmU1jvR4Pz?=
 =?iso-8859-1?Q?KnRUbj7xL5xH80A+rQldgAuf3QEeF2HB9KjUvc/vRJxi3X5AN+1XBSzjKa?=
 =?iso-8859-1?Q?HbMgjsDgcferIK62ZbJn9o1w2TytTAYbu+zN5fZ0/dKv/XXoi/lwTNCr8o?=
 =?iso-8859-1?Q?6AWePOvO5GnDVczpDS98kpMynpvPyK0gSfnpF7E0b8IKk6+acvM67snIMQ?=
 =?iso-8859-1?Q?DNLKXyzLYlmsTI1ld3ISuuN7M7/MnIvw2BWVLyG9rDQh55fgK+HpGRgzlT?=
 =?iso-8859-1?Q?SThpDhQvJOwUMzsFuX909ljnXQLjGsW17aLRp+AQKXkq3aV2AtCiFi7Toa?=
 =?iso-8859-1?Q?JM8Z4QgD11lgJ54rXTpHBmeEAhbj+IEI5RV+ly2/3LrJLUz7m5QdrIdJrk?=
 =?iso-8859-1?Q?ZCbSaSi/DxfHAcuLlDdr09SIQLwVNXVA+X1SUx5ZVvnxq+qbnR6gtxQIS/?=
 =?iso-8859-1?Q?BHLxWktoi3iSc0p6RCy5bUDAGHxJ8WJ/sddm1yEQnyyuEimQYhAizxaSRG?=
 =?iso-8859-1?Q?8cYJuriTfiqHqKSLN5tZ7hXaZyLlBySUupVQ6SzqYm1vtEYOEouVIcn7Sb?=
 =?iso-8859-1?Q?H5Agp9H0hAIvy6lU2oGAp9cqj/Ev9aUCxsD7XaXL3ZtDfljvZs/Qca5Ec1?=
 =?iso-8859-1?Q?JAqGQOZbiBYNO5VCXocRIgLAWGxGQUzm2eUz9fGlSbWgzlRn3xc4XB9tDz?=
 =?iso-8859-1?Q?Sk2d4aaZeGyhlDSkfWzp3FNKqrKpjTYaz030XjL5z2FLBM+LSdMJPsuhel?=
 =?iso-8859-1?Q?BGTIzLBexWp4LdktEAmw=3D=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?hWpwDh4Z0O8yuLpLVUZ5lih03EQ9w7x3PLBdb0KJiiuLcD8uDS0+vhWRZb?=
 =?iso-8859-1?Q?6BQSeRAd1Zr0oSWYmw1StcYDtdvc+urqiuDhCskOV+j2bXGTIeRedp2GFw?=
 =?iso-8859-1?Q?ruJQ8pdT5VBQhhU1GtY6cVfsnRVOtnb64z/FnjB3R1GV2H7FR86MEBSMes?=
 =?iso-8859-1?Q?N65y1prqtMkzOyGZdv/RBtviccXoZ1aUtQZgem9MbWaV+k2Fg/SUtfaM4h?=
 =?iso-8859-1?Q?SlrWdyfpvAEmGurxOghHZYy5/o5Aef4+O8zyAIpl/y358pPv7bfikfbC7G?=
 =?iso-8859-1?Q?cJeowiN8zyIr5CLS747LQOe/eyAljW14HlnDP3b97RuKKRp+not9pc2h96?=
 =?iso-8859-1?Q?NQecpC5EWDbyeFrxMK6ei1J2AgJVJn5AfRbkVNY5DP3WtZEskHWmz7AH20?=
 =?iso-8859-1?Q?jYUZaeJgwNS/afDPgwcAvwpo7kbRO8IKL/cycstvsNHOe7Vz1d5H3eAYZF?=
 =?iso-8859-1?Q?0IZYD851khk7Fx32wfr40IHOxfbuXkBBDwfQzCVjYTX71zqg2raGkI0Iny?=
 =?iso-8859-1?Q?8yk976r85OuzUciui5rA9y83Ts1TFQYuGx1iwviX6gIFz4PfbvwGPhIrlI?=
 =?iso-8859-1?Q?ef1QhKw0tK+b3SouEnxjUI4R3RiSB8pl2o5w+JgbVm4tQQ6ieGh23pKDRu?=
 =?iso-8859-1?Q?+zAEE6yoW3shH9WHIKEiEpJJlyMj8rZu9z9R/+dhJgCjXr01Nn3/CF/drT?=
 =?iso-8859-1?Q?vTv0NuqAmg4seCRVDhqOOLqNFHwoyyGHefLziPZNLT2aDYYJ8GMaqs1OL+?=
 =?iso-8859-1?Q?kRQzX6bgzhz9aJS3L6HuIvRsHmGJO0+HaNHm0Ebkf6TAM2oMyV+KD0aldU?=
 =?iso-8859-1?Q?pJwURHYLTJ8MiEDQvSOLUpzcBJAusXBCPPT39CyBdRYtba290Qu+MHHP9/?=
 =?iso-8859-1?Q?40TkRdiSDFVjd3kRGWfrBEKkrVBu06oCCRC77a/1FPw4yI8EeQi6jh769F?=
 =?iso-8859-1?Q?H8toLiTOZLMXuzPwAHbr7aZXGvWrrtr9UrhQB0FC5UdCzFHa0OP7VwTlnC?=
 =?iso-8859-1?Q?X+3AEBOFSkcQlUUhSapHparxCHx8uzJuZ7GKE8LIaVnBmQfXpBevA9caGH?=
 =?iso-8859-1?Q?ZL/HhpB9UFAbVBoY6W2r5B9BQ2V58qS+4fi57xeMmNo4nM0uXIq1X95gK7?=
 =?iso-8859-1?Q?7WyfwtSh6KJoF74W0+wsTZitR3GOaXcpxLLV6wHrADVcH2Z5OlptEJ68V7?=
 =?iso-8859-1?Q?TU1ZuabfLs8d3eQtWkNagipvKB2IreQMdWraEE2bUpp54D7h1BV6J5erq9?=
 =?iso-8859-1?Q?wnx1iqq2wSY7RirPxjZXRoh3XR9SDfM1pYpKPqbQ3O3ZoNQ4AOvgaeErsi?=
 =?iso-8859-1?Q?SF24cEgkXqkr+wuSxvJaqBVaAeVH/kPm6H4JEs7I8FQm6XM=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEYPR06MB6523.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 664c276c-a161-4d2a-a751-08de3ca53a2a
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Dec 2025 13:15:47.6258
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR06MB5529

From daadb4f6826bf2d5369acbca57b570269010c761 Mon Sep 17 00:00:00 2001=0A=
From: Abdullah Alomani <the.omania@outlook.com>=0A=
Date: Tue, 16 Dec 2025 16:00:35 +0300=0A=
Subject: [PATCH] net: docs: fix grammar in ARCnet documentation=0A=
=0A=
The sentence "It following options on the command line" is missing a verb.=
=0A=
Fix it by changing to "It has the following options on the command line",=
=0A=
making the documentation grammatically correct and easier to read.=0A=
=0A=
Signed-off-by: Abdullah Alomani <the.omania@outlook.com>=0A=
---=0A=
Documentation/networking/arcnet.rst | 2 +-=0A=
1 file changed, 1 insertion(+), 1 deletion(-)=0A=
=0A=
diff --git a/Documentation/networking/arcnet.rst b/Documentation/networking=
/arcnet.rst=0A=
index cd43a18ad149..8a817cf22239 100644=0A=
--- a/Documentation/networking/arcnet.rst=0A=
+++ b/Documentation/networking/arcnet.rst=0A=
@@ -112,7 +112,7 @@ There are four chipset options:=0A=
=0A=
 This is the normal ARCnet card, which you've probably got. This is the onl=
y=0A=
 chipset driver which will autoprobe if not told where the card is.=0A=
-It following options on the command line::=0A=
+It has the following options on the command line::=0A=
=0A=
 com90xx=3D[<io>[,<irq>[,<shmem>]]][,<name>] | <name>=0A=
=0A=
--=0A=
2.52.0=0A=

