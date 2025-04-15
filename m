Return-Path: <netdev+bounces-183010-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E55AA8AA2C
	for <lists+netdev@lfdr.de>; Tue, 15 Apr 2025 23:34:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 364AC3B04E3
	for <lists+netdev@lfdr.de>; Tue, 15 Apr 2025 21:33:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 749CB250BFA;
	Tue, 15 Apr 2025 21:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="FQ+/X3lM";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="fvJuY/b8"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B43A2566F4
	for <netdev@vger.kernel.org>; Tue, 15 Apr 2025 21:33:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744752841; cv=fail; b=SWFPgEYwv9k+7rMetuB/YhKYSPe9a4RYShRLffC0PGsHYUCqUM2X8Us1hdxwdyfXefBLWPECrDbv9D8E3HURISLs/XcCx4q/FtxZ8KhCxokFWLgfeVYIEryAi2cf80DI4lp9inrVaY97wgR3H0L58HRVbeZ2ePjcUHZihpc0g1Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744752841; c=relaxed/simple;
	bh=XmQYUThhkGffOJ52TM9ldO17eRoPY+e7/OWP6II6UgE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=VzxzUROhKamxRrZhUHUmro+jVy5+6FMl09P03gR9MrC3Ku/AaJhDQXjYiLZ1RsBzM5AnuJ6/3kzZ8ZmLnffLZeiG/qszRoAOr2jgT4Hv02kUcgipUIsqfN+txaBCaadaWGtl2hHoc09ugkVICaBIwZhDvIqfoCtiP6bwCUG6rOM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=FQ+/X3lM; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=fvJuY/b8; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53FKu7JA025536;
	Tue, 15 Apr 2025 21:33:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=XmQYUThhkGffOJ52TM9ldO17eRoPY+e7/OWP6II6UgE=; b=
	FQ+/X3lMM8cMmGo2GKoL65o6zcsB+qvbrx92IG1sIo1BrCGuuI8KMOpH5zR9ctKH
	ZbeGZtvTWSm8ZU8tz80RLzNyA6mqiWnhEPDSqCo7yVHAEJsMMSnuj9lEjuT8gAOA
	Rc/QRDjQTISiLlFVOOtJE+N2i5xVSXFTTE0ItKMYh7SLBltNAsPP+4ijnxXQ9peZ
	k3Hay3Amu+y1rWj6o7SG9u5Tuz186+wWAsOZXMz0IImz4wEReFdzOGoTon3I1F9g
	MuvXjRSyGoWUtBDmWYKiaMg02648PYro/T77b3tOphEFDx7SrlZHG2JEOwhknpmd
	l9j36vr4Q8ztdDXTc5236w==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4618rd2nsg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 15 Apr 2025 21:33:55 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 53FKJHfs038867;
	Tue, 15 Apr 2025 21:33:53 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2042.outbound.protection.outlook.com [104.47.56.42])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 460d4s020k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 15 Apr 2025 21:33:53 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kLlqd8zyduao0cZkzJsTVqLtAnvq+JJXJCLd3MCH0QP9w1bKafBN65T3GnQ47vsaFAmzXmWXbuOGxDxvhp5XuDou87HdAXpsH2TDaVcpDX6PIMoZvdz4QhIQAoDCt1cXcXiQrLHj4giqJSZCLcZCDxxBEQxJU9RkefFzSWvlBhS+p0trtobtxAwCzAiOsbJwgjMM5HWyU2BsCePhQXKEQgzJR4jlBxCaH6dOLujC2PEsPevi0XO+wzDuH0vy0b8MdsHsMA5bNHvR1uUJo7Eaxv8IEYXNcVarJbMsFcdJWHPihRdQ0n9oRYWQSOR+NbxK1x+hJogJtAWAQ1wdQhsxhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XmQYUThhkGffOJ52TM9ldO17eRoPY+e7/OWP6II6UgE=;
 b=aLjTd7b7aU6mvb+/SjlZQGX0epjFwcE1mfas1UK/U7yw7PzfLHUounZpSgTsG7eAp0y+cXujzucl3Ku2AREvJlcfXQNyyNNb3v1nwLbKV03V41MUSBg7RNuvZT1jt9V2WdaUsH/SMEO7S932zZSzqsIph0TXZoUM3e77vZr7Z+/6ify5PyiI2yodWVD550ZDWQgVbou9LKqjTE9ZZz2OhCseFTB7gAwy7+fA1VV016+UwrUamM8hmS2PfxtMHjg0D4dxLTchwG4EX4l1e7EG14nvoMaC9cZj36VQIl2hdUPNHMvy5i+7Q8VfZuf46LwCgl5s79p5Jm23uhKQmNfJnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XmQYUThhkGffOJ52TM9ldO17eRoPY+e7/OWP6II6UgE=;
 b=fvJuY/b8lMVlcke8CBXKDIvITkeZE6DkxEZc9+O4a8A65yWE9Cc5Tt29SflfH35/wCrbD+pCxYq/YUALIs3NpDNu+jhHDXfLfxFKFkAuiBUD0xxWqlPF0TS+ACDgauP6f39E77tQlKBfhZfz4WDSbMpB6RCZDriO6aGs1YJjKqg=
Received: from BY5PR10MB4306.namprd10.prod.outlook.com (2603:10b6:a03:211::7)
 by DS0PR10MB8152.namprd10.prod.outlook.com (2603:10b6:8:1fd::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.32; Tue, 15 Apr
 2025 21:33:51 +0000
Received: from BY5PR10MB4306.namprd10.prod.outlook.com
 ([fe80::b78:9645:2435:cf1b]) by BY5PR10MB4306.namprd10.prod.outlook.com
 ([fe80::b78:9645:2435:cf1b%6]) with mapi id 15.20.8632.025; Tue, 15 Apr 2025
 21:33:51 +0000
From: Allison Henderson <allison.henderson@oracle.com>
To: "kuba@kernel.org" <kuba@kernel.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [PATCH v2 2/8] net/rds: Introduce a pool of worker threads for
 connection management
Thread-Topic: [PATCH v2 2/8] net/rds: Introduce a pool of worker threads for
 connection management
Thread-Index: AQHbqwvaJfH6s24q4E2h3AnIlDWBc7Oj6Z+AgAFccAA=
Date: Tue, 15 Apr 2025 21:33:51 +0000
Message-ID: <8a1d5c373c1443b71ab398c618f9ba4eaca60e44.camel@oracle.com>
References: <20250411180207.450312-1-allison.henderson@oracle.com>
	 <20250411180207.450312-3-allison.henderson@oracle.com>
	 <20250414174643.1447bbe7@kernel.org>
In-Reply-To: <20250414174643.1447bbe7@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.52.3-0ubuntu1 
autocrypt: addr=allison.henderson@oracle.com; prefer-encrypt=mutual;
 keydata=mQGNBGMrSUYBDADDX1fFY5pimVrKxscCUjLNV6CzjMQ/LS7sN2gzkSBgYKblSsCpzcbO/
 qa0m77Dkf7CRSYJcJHm+euPWh7a9M/XLHe8JDksGkfOfvGAc5kkQJP+JHUlblt4hYSnNmiBgBOO3l
 O6vwjWfv99bw8t9BkK1H7WwedHr0zI0B1kFoKZCqZ/xs+ZLPFTss9xSCUGPJ6Io6Yrv1b7xxwZAw0
 bw9AA1JMt6NS2mudWRAE4ycGHEsQ3orKie+CGUWNv5b9cJVYAsuo5rlgoOU1eHYzU+h1k7GsX3Xv8
 HgLNKfDj7FCIwymKeir6vBQ9/Mkm2PNmaLX/JKe5vwqoMRCh+rbbIqAs8QHzQPsuAvBVvVUaUn2XD
 /d42XjNEDRFPCqgVE9VTh2p1Ge9ovQFc/zpytAoif9Y3QGtErhdjzwGhmZqbAXu1EHc9hzrHhUF8D
 I5Y4v3i5pKjV0hvpUe0OzIvHcLzLOROjCHMA89z95q1hcxJ7LnBd8wbhwN39r114P4PQiixAUAEQE
 AAbQwQWxsaXNvbiBIZW5kZXJzb24gPGFsbGlzb24uaGVuZGVyc29uQG9yYWNsZS5jb20+iQHOBBMB
 CgA4AhsDBQsJCAcCBhUKCQgLAgQWAgMBAh4BAheAFiEElfnzzkkP0cwschd6yD6kYDBH6bMFAme1o
 KoACgkQyD6kYDBH6bO6PQv/S0JX125/DVO+mI3GXj00Bsbb5XD+tPUwo7qtMfSg5X80mG6GKao9hL
 ZP22dNlYdQJidNRoVew3pYLKLFcsm1qbiLHBbNVSynGaJuLDbC5sqfsGDmSBrLznefRW+XcKfyvCC
 sG2/fomT4Dnc+8n2XkDYN40ptOTy5/HyVHZzC9aocoXKVGegPwhnz70la3oZfzCKR3tY2Pt368xyx
 jbUOCHx41RHNGBKDyqmzcOKKxK2y8S69k1X+Cx/z+647qaTgEZjGCNvVfQj+DpIef/w6x+y3DoACY
 CfI3lEyFKX6yOy/enjqRXnqz7IXXjVJrLlDvIAApEm0yT25dTIjOegvr0H6y3wJqz10jbjmIKkHRX
 oltd2lIXs2VL419qFAgYIItuBFQ3XpKKMvnO45Nbey1zXF8upDw0s9r9rNDykG7Am2LDUi7CQtKeq
 p9Hjoueq8wWOsPDIzZ5LeRanH/UNYEzYt+MilFukg9btNGoxDCo9rwipAHMx6VGgNER6bVDER
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY5PR10MB4306:EE_|DS0PR10MB8152:EE_
x-ms-office365-filtering-correlation-id: 39a79263-b305-49c5-4023-08dd7c6536fd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?V003WGJWcmFhL0IxeFZFWXRUVDQ4TWlkMkVBQmZha2xuZmlLRnU2RUJ5d3Bj?=
 =?utf-8?B?Q1hmaytFOGZzeGdxSXcvWWhxNUx0aWZ5cGNRZlVGaE9CV0ttM1V0Ukl2WUNI?=
 =?utf-8?B?dG5TY21SV1pldWlaKzVKbHZJY0wwMC94M0MvQ1V6cGsyWG5BU1lKQk5IL3I3?=
 =?utf-8?B?bGZOSFdUa05ueG41RWRDSWhnUWd4d3M1Z0ZlQ2RzYk1qWDgrbjRMZlB0bHJ6?=
 =?utf-8?B?QU0rem4rT0FtdGswR0tJaUlCbWJydVFmb2xsZXQ2a2R3OFh4WWlJby9tY3Nv?=
 =?utf-8?B?WXBjODMzQWNsY0x2MzVON3FiQVZQZE10ekoxaklXMXBhc3Q4cnFPL2xJZkRs?=
 =?utf-8?B?RGhFWEFCZkVLbDdWd2w3QUdxbXlXc21EN1ZINDBsalJtY0RVcys5NkRJdndX?=
 =?utf-8?B?UUpOTmpwWHN1U3ZjN0EwakhGTi83aVJFL3F3dXdTcnZSUXJhejR2dmJITVBP?=
 =?utf-8?B?SkVZYjA4eXN5UEt3SUJYeVhISC9PZ2ozWjVLbVpOUmpTRGcvQW5ZVmwrQ1dE?=
 =?utf-8?B?V1luclJwRzEwZ1h0b3JldTdhZVFJek5sZTFKelMxdHZ3dHZjNkd5VXJ4MU0x?=
 =?utf-8?B?R3J2dXltSGVSMXJEKzIwaWUwcUNNRW1CakhGSGdUd1FGa1ZuclhMamhNdVkv?=
 =?utf-8?B?YUlSZ3phZlhBbzBFWUtDMi92QkdNcnJoSytPTE1aQm95d1JYczgxODNlUGhL?=
 =?utf-8?B?M2ZYcnYrc29uSXBZNVpRbUpFOWZTUXlwQXFUaElZY1BPeTJsVGVOdUV3TVd1?=
 =?utf-8?B?eTRRWDUxdWw3WnNMMXhxRXh2OXYraDM3V21QY3dkTGMrRkZNR1BEWGp2OHlB?=
 =?utf-8?B?WE9hMlFWQTRFYXRseEJtakcxWUdESmN4R2pwVjUzYXVqUGk0U3c3RkhTOGdw?=
 =?utf-8?B?L2xXOFp4Ynp3dzlyTDdaQlFaMWI1V1VPblFQVmlIby9FMWpnQkFCNGJ5RGpC?=
 =?utf-8?B?QWF3ZWc1VDhiQWg1aTJvWmpCckVkYVo0WU9VSUl5ck9zeDE5L1BnRUpBYTlh?=
 =?utf-8?B?NDJicGdhRzVjSmU1bEtxMk9RMWhZSXhsU0YxRG82NGVkajlNL0VEYzhWZjdl?=
 =?utf-8?B?bVBBTWQzWnNjVGlOcGZ2MW9xTElpVmpYcUc3NnRDR3BuR28wRWhCc3RBUm5Y?=
 =?utf-8?B?U0lOZVloOFNqUFJBeE03a3pQLzY4SlhPekxZVzlFajVpVjJvdW05WHhWUzBj?=
 =?utf-8?B?SENSS3dmK2t1em9FZHBGbCtoc1hUZWl0TGREclhRekVIUk0xV3oxTVVoU1NK?=
 =?utf-8?B?RlZaNlE0YjFuYWVFTW9LYnlhd0xiRWJGUkVtR2dmb3cyY2p3YXpxaXpOa1Ja?=
 =?utf-8?B?V29pWXZzSnJEQ1kxODJMZ0QyZVVJaTdiaEZvWFRycWxEV2NGUkFUc25aalRL?=
 =?utf-8?B?bm95ZmUwbTEwMlNaYUpPNzY3V1l5RU1vSVU3aHJHb2xsS1N0b3ZITWNVdXBH?=
 =?utf-8?B?Q0FsTFhvamNBN1FBcFBadjhOMTlNeGpveThFWi9GZXlaUWxielIzMktuRUJB?=
 =?utf-8?B?SDlFZURUMGwvQUV6VGFNYmc1bU1rWnFwK2twUFNMT0NOYmFkYjh4bU1OTG1i?=
 =?utf-8?B?VTFnSHNJajV0UkNIcmJ2L0xEcmFvNVpWVG9FYzNVN1NPRDdRenN5RGVMSkE1?=
 =?utf-8?B?M2dBVHpBai9XOVdoMkxuTm13R2ZkOGRhUFdYdFBVRDRMVjViaGIxeFRmZEZH?=
 =?utf-8?B?cEtOYkNRaDhmZmpDRFdwTU00aDk4bTQ2QXRvQjNZNUlKTmVJU2syTGpqNXB1?=
 =?utf-8?B?T2UzemFWVnJoZFJ4ZkxBYS85MVcyc3k1NlJzOFE2b29JbTVhY0J0WGdtbzd4?=
 =?utf-8?B?bGxCdElEOXNuMk9JeVZUeUlTT29WWnN1dTdnWld5dGk4a2RXMmVZa09hR3BP?=
 =?utf-8?B?dG9LeWhpU3RUdFV6OU9CUERjVWt3Q2c2amJHSXphNWNXOXZRMnp3UkhRck4x?=
 =?utf-8?B?YTU0NXNJWEpVTlpnclhhSmo3Uk9Rd1dYTVNjZUJBdWVBWTRCSDZrUk9ubjJ5?=
 =?utf-8?B?MzZIYUpLOVFRPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4306.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?ZUhqSlZiOG13eTdjMW9xaWlkNjBNR1NlOWk1YUhTbDRQMHV5Z21hc0lDL3Y3?=
 =?utf-8?B?WTlFTStGeVA4SGxrYktMdDZKK2pMazdGWmgyZ0dnVTdYOTIxcXhPNVpqT1Bz?=
 =?utf-8?B?OGFLd1hHME1kUnZSa0ZHNmFQbnBtclJIQVdlOFZpSGJUM0JmQ2oxU3k5Q1Vn?=
 =?utf-8?B?dlZZNS9wdmd5ODlueiswVjZUVDc0KzhpVUpEeDkyNFJUbXJielVHbEhieDdv?=
 =?utf-8?B?VXFkdTd6QkltQWh1L0p3TzZBRWdKMEZEMGNxTCszdks4cTdRaUlPMlFsS3FI?=
 =?utf-8?B?UTFGTlhVWTJSaXV4c2p4TmRoSzE4NkVLclZjWjdNY2JkK3IySW1LZmM0Wldy?=
 =?utf-8?B?c2xPWkFMRkovTmJjNDFXNGNHWTBqWjRjeUk2d1MwcFRQOHgrUnpwdHRlTk1u?=
 =?utf-8?B?UzFodUxPOC8rNXBkeStwWis4empsbW1ScW5iYmh1MFZiMWFVcGNrbmRwbVhk?=
 =?utf-8?B?TXBFUm4vMEZKNXhUVEZVNXZFdldsSEdjTWE5WldOTE85SkIya2tCQ3lnMTg3?=
 =?utf-8?B?ZTBMaFZZdTJwVi90TFl0QjZNZmEwUHNybSs5Qm9GRWtpaVBtYVI2bkxrRWc5?=
 =?utf-8?B?WUt5YThpOEo2MjhHdk8wYjgvdDJjVWRYWDl5VFRQaXRLYUlKUkEza1d3ZGdD?=
 =?utf-8?B?d0ZQWFI5SWIvcDE2YWhKMjBZR2toR2w3TmtzanA1cnRJNVVIcys0K3NDMis3?=
 =?utf-8?B?NnF4WG1CYm5EUzFTNW5uWS9ia0VQQjd3VlZUNk1JVDVxN0VWYlJDYkF6R2Fk?=
 =?utf-8?B?UW5BNFBJZlpwbjZLUElHemlVeTNmV1RYK09Wa3B2cVVuVjg5ZGxnbENsaG50?=
 =?utf-8?B?THdpNkRoM0dlbVFqamRaeUQ2c0dGTm5uYVRlVWdxSmZ5TmpHVVg4cnNVc2dy?=
 =?utf-8?B?L3ErYUdwc2hKRE5UVG0vR05hM09qMnNOTjZXbXBxSHcvc3Faam9qWWtpcHl2?=
 =?utf-8?B?VmcrOWo5RmRPcUtHR1cxeVFEbnNUTHBSYk9wMCttUVFxeU5ZOFd3K1BrZXF4?=
 =?utf-8?B?NnkyUk1zTUQyU0F6SnlkcDgrU2hVQTA4SWZMTnFaWWpBb0tUZmxpeGVoaDhM?=
 =?utf-8?B?dFJDNUVERUxNSWUycTR5djJwZ3BaUUVveWlRYlNsL0RZd0tkMjJuMzVhVTly?=
 =?utf-8?B?ZkcyYVhaMi9Wb2x0RUxyditkMEhkQnVaRlhYejhPeXU2QUIydU4wYUFnWHBt?=
 =?utf-8?B?b1FnTkRTT3pmZHpzdkV3am5PcHM0OE9CMSt5WEorM2FONmZlYVNIclZmWlJp?=
 =?utf-8?B?blBsbGVycllLVkNMRDNPaFk1K1JtQzZuTGtHQ1FsVExwZGV3b0VUQmR4VGpE?=
 =?utf-8?B?aVdmVTA5K040clJVUEJBN21zTElWR0lPbEwwMFRrL1NXRE9LSVMxT25EeGVD?=
 =?utf-8?B?Mi9IcjBkMGsxMTZObWNZbzBuZHdqaTA4THk3NW5sY3d3cHpTL21KU3R5UXZN?=
 =?utf-8?B?bi96M1hVMkNuTW5ZOW1zVjlQWWNpanJUKzhZaXhPMTBwVXJyY09jdkZ6dTJa?=
 =?utf-8?B?dk1tNkxFdnI1bWtOYjNjcTZyOHIrK0tqWG5hcUcvZXJtNGxuNVkxRWM1RXhT?=
 =?utf-8?B?S3djTnFPUUhTellBL2h2bFJkc2NRRzRVaVhHV1Fqc2ozdk9wLzI0MEFzbVVC?=
 =?utf-8?B?UnF1Z0dERDhRZzFHVmNuWE51YnYrSkN1U1piUGhCUXkvbm9lV1NRa3ZwUGZx?=
 =?utf-8?B?aURLZ3F2dEpJMHVJcGh5Vkg1SFlTL1UrUU1XS3VKODhZa1hHNVJlNTVjcUVF?=
 =?utf-8?B?MWk5bXgveUNQVTF0UGl5K3ZHL1BqMlJUVE5HOUtLWTZWYkpwSzRrNVdaM2tW?=
 =?utf-8?B?OUM4WGYyczU5SzFoa3pQa3Z5dWppSWpxbzZvaFVpWEx0K25SNEtQV0plUEFl?=
 =?utf-8?B?b1pGMGROajhFNXN3NENKSm1rLzVYUTRUNzU5dVhwSU84aTVBc3BSVG0yRnFw?=
 =?utf-8?B?MmQwcXdNUDJDS2lBNGRKSTBYQkVXY2dZL3R1TmlNS1hVMytUYW5iRFZPSjdZ?=
 =?utf-8?B?S1FXVGNCOXVVZ3RpRXo1VUpNeUJYU3JWZ2ZycHZCTXdzbHFXK01SVGpockpn?=
 =?utf-8?B?aExPSktjaFJ4NGZlUm5kelEyWVpUTGxBem1zaVZCcmZUaTBSV2FlU0tkdmJO?=
 =?utf-8?B?VURzbUxrd21seVhlUU1GMWw3UjRzMkZUZW1KTk9UM2NiZUFMQU5HYUtQRW1X?=
 =?utf-8?B?QWc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <34F416186017B54E9187DEE66AB66BAC@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Sk8L/GJofY0oPpQgqZjRhGGHmQ5Rukr6VhpFnNzg7PVkkhzt0mKwJfMF1OYzFFe4ee4V/f+5g4N+kBkp6EnPsItN8uAohFBs7sWTla+Ds7vZa3JtUz86PYu0Q1TK2X2I3USfU06GgeIxFPheDbzTCIj0kbQ1niRfKjOrLL8p+B9ZnT5z9wk0gL7/XQFxMiiiG+GmrxC1wpy1VASaF7FRusbBZvHc73YZ2p380GJaWO+dO2eYAie6s9RdJv25PGe6BRP63kWRTayqmMxAQBjWKUEjCazmN91K1GBeVlwEnqgA1js22mZe8BhGXqhwWANdoUvAisVDz57Vjapx76wz6dcXSKO0vpa8QUL1XG7RGg7KuIGevaQpP7H1p5GjsniWltzb4mMpIICnRl5EKUqpj2xz+PhNqvNB7cCAR6CfThJHoH2pZBvRaubqlyrj7a9//To9RTtJJ0ZKHJtVW/9u8sg2yKhwRIU5tl7QZF2JQEP6g0niFf2Yp40afAZPnG5lPdO+70lpOLX5/uiULhjdJ6qWurdRAV/yKKYOGyocULI6uCWuPWdr2O2xU03IXYxhIyd8TrVF8cM4e8tUZhTpSfPe+4MAaJ9FxEu1ghmy+bc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4306.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 39a79263-b305-49c5-4023-08dd7c6536fd
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Apr 2025 21:33:51.2310
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jk4dLrrty9wGZh6ab63Rjog1Uge1kBKv+zmDq8UaJCTAFGEwvmNvxYRUfW8eval6AjcxhnaOGNFGomF5rzB+iDuQYriEL2aDcDgDAB5Yohs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB8152
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-15_08,2025-04-15_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=0 spamscore=0
 bulkscore=0 mlxscore=0 phishscore=0 malwarescore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502280000
 definitions=main-2504150153
X-Proofpoint-ORIG-GUID: gQL0RiTXyLh8z5ddmozAlF3r6xo20YTI
X-Proofpoint-GUID: gQL0RiTXyLh8z5ddmozAlF3r6xo20YTI

T24gTW9uLCAyMDI1LTA0LTE0IGF0IDE3OjQ2IC0wNzAwLCBKYWt1YiBLaWNpbnNraSB3cm90ZToN
Cj4gT24gRnJpLCAxMSBBcHIgMjAyNSAxMTowMjowMSAtMDcwMCBhbGxpc29uLmhlbmRlcnNvbkBv
cmFjbGUuY29tIHdyb3RlOg0KPiA+IFJEUyB1c2VzIGEgc2luZ2xlIHRocmVhZGVkIHdvcmsgcXVl
dWUgZm9yIGNvbm5lY3Rpb24gbWFuYWdlbWVudC4gVGhpcw0KPiA+IGludm9sdmVzIGNyZWF0aW9u
IGFuZCBkZWxldGlvbiBvZiBRUHMgYW5kIENRcy4gT24gY2VydGFpbiBIQ0FzLCBzdWNoDQo+ID4g
YXMgQ1gtMywgdGhlc2Ugb3BlcmF0aW9ucyBhcmUgcGFyYS12aXJ0dWFsaXplZCBhbmQgc29tZSBw
YXJ0IG9mIHRoZQ0KPiA+IHdvcmsgaGFzIHRvIGJlIGNvbmR1Y3RlZCBieSB0aGUgUGh5c2ljYWwg
RnVuY3Rpb24gKFBGKSBkcml2ZXIuDQo+ID4gDQo+ID4gSW4gZmFpbC1vdmVyIGFuZCBmYWlsLWJh
Y2sgc2l0dWF0aW9ucywgdGhlcmUgbWlnaHQgYmUgMTAwMHMgb2YNCj4gPiBjb25uZWN0aW9ucyB0
byB0ZWFyIGRvd24gYW5kIHJlLWVzdGFibGlzaC4gSGVuY2UsIGV4cGFuZCB0aGUgbnVtYmVyDQo+
ID4gd29yayBxdWV1ZXMuDQo+IA0KPiBzcGFyc2Ugd2FybmluZ3MgaGVyZSAoQz0xKToNCj4gDQo+
IG5ldC9yZHMvY29ubmVjdGlvbi5jOjE3NDo1NTogd2FybmluZzogaW5jb3JyZWN0IHR5cGUgaW4g
YXJndW1lbnQgMSAoZGlmZmVyZW50IGJhc2UgdHlwZXMpDQo+IG5ldC9yZHMvY29ubmVjdGlvbi5j
OjE3NDo1NTogICAgZXhwZWN0ZWQgdW5zaWduZWQgaW50IFt1c2VydHlwZV0gYQ0KPiBuZXQvcmRz
L2Nvbm5lY3Rpb24uYzoxNzQ6NTU6ICAgIGdvdCByZXN0cmljdGVkIF9fYmUzMiBjb25zdA0KPiBu
ZXQvcmRzL2Nvbm5lY3Rpb24uYzoxNzU6NTU6IHdhcm5pbmc6IGluY29ycmVjdCB0eXBlIGluIGFy
Z3VtZW50IDIgKGRpZmZlcmVudCBiYXNlIHR5cGVzKQ0KPiBuZXQvcmRzL2Nvbm5lY3Rpb24uYzox
NzU6NTU6ICAgIGV4cGVjdGVkIHVuc2lnbmVkIGludCBbdXNlcnR5cGVdIGINCj4gbmV0L3Jkcy9j
b25uZWN0aW9uLmM6MTc1OjU1OiAgICBnb3QgcmVzdHJpY3RlZCBfX2JlMzIgY29uc3QNCg0KQWxy
aWdodHksIHdpbGwgZml4IHRoZXNlLiAgVGhhbmtzIGZvciB0aGUgY2F0Y2ghDQoNCkFsbGlzb24N
Cg==

