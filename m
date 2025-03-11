Return-Path: <netdev+bounces-173945-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7372AA5C71F
	for <lists+netdev@lfdr.de>; Tue, 11 Mar 2025 16:31:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CB3FC3B92E8
	for <lists+netdev@lfdr.de>; Tue, 11 Mar 2025 15:26:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 214FB25E83E;
	Tue, 11 Mar 2025 15:25:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="PgsK8uPn"
X-Original-To: netdev@vger.kernel.org
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2081.outbound.protection.outlook.com [40.107.249.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E96CB846D;
	Tue, 11 Mar 2025 15:25:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.249.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741706744; cv=fail; b=QlOPrvzIgjN5zzW9vTWenRr925zpzGofNBrlMdzL7A/MjXvZXYB0XUGGNZZ0iDrjn++k85YEylBffnjNrFmvOiKkXe7uKLHAHJ6a8kqkJV5+Fj8m/lltiTViBvrR71flajsPbctPUA2jf3tM1ZaJJc6tRwwN6DN+Sld5jEJTok4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741706744; c=relaxed/simple;
	bh=Pp1Zxy+hFRG2MTzVctcg08ZvW87PkOKKA95G+Zgm86g=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ajnm6QG+dYwsZt527C+z/Ue8LJPEFsxscmG0C9xAsVqArA2gOrFEwW002cMD6pIwYSlJ211327KQrgXTaLSU2JnUm5aBQZfI0YMoI5phJRKLuTlE/j9Lv4lnrg9p21scZX3WgmsgwfQtcAVnVDJ/65Iu0GGzZa28bQk8vh9JJ7w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=PgsK8uPn; arc=fail smtp.client-ip=40.107.249.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Tk0CVMsxrVABTsDiQmtwGSCregK9BcWyOtqlhgCXoz8RakuQyg71bauIX8zfo7Os4uMU9ahQX6h4mU/6vumg5Ju/k5I3Ma6PlVj4N3pO7Q50phGhmK9D4fXje/g0RPjFukyLO9vZP3n2LcJuYabgLtF2YHFq8PlV55YQuRH/R5vKfCZHZzGrVnNXPzG/jViXw2g+SQqsYaORDksI2vY2FWQauCQx+fIjhHnt4loLXS10Z3GMUVWqCiNqxNaf+B4tUiNAJzBixkgRis05M93EL+MCq2EDTB1M09rM4HtaaFqJN1h/Zf4aahvFf4mrOlqvPwd5LLyzULridtyTWC4sCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Pp1Zxy+hFRG2MTzVctcg08ZvW87PkOKKA95G+Zgm86g=;
 b=oOTxnaiPZAxH+OKPhMmNKHLbGP51mRax7LbAuMwCXr6J9RRJsQJTewWWomYbttlq/dWpUZdZUcMhL9PkXQzbrefC2ysSma1HaDO/XSOpiAPq91HevlqIcuagivaT34OyU+zvx65P+Frbn5jYE92ojUD3Z1pQbyDUv/8ilT+cDS8CZdePAM6hefBKfckFcYN9jnlOHnVwSr6qi0bOQ4kP4HEtvqOWtlsdqwR0/a5/ixUH6Zi0gzpgacDH1g4h+Zx8JI/JEtWtlmHOASJ2wGs8cR49uAZQStiqs1xwWAY+ATNZ3fzlBZae+0xgzOJQMaBHJ1+epcdc1eZ3TwyfghRxJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Pp1Zxy+hFRG2MTzVctcg08ZvW87PkOKKA95G+Zgm86g=;
 b=PgsK8uPnDIVK5OqI4PWZ+b1Res5X9es+g4DvP1hEfCL8iuI5VV+Y6x7VSI21O83B2UIHWMcu9XsItZslQuk8Wy2zzPVklNyMA4ScEgybho+dopC8ejWDsdXdCrOWfC+F77JYJC0uwfOCEQE9CbdQTlVi5JlBpP8vx0C7blPD/lu/4p1eyXlwMaBjR6974YFswQ5n79XARhIjPgqtGjrHt9LBXAZBkGnKUNCY3kMCFFvVpvq4oQMeSyrlSrV1OuibwQA0I26bhYbq8kGOJpBPriNq+iEgZ0CbnSDiwxFRdcmyMO0R4fRlbDgu0sZVIghskxN5/v8zEbtZnhhMfCAA7g==
Received: from AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:5b6::22)
 by PAXPR10MB7631.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:289::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Tue, 11 Mar
 2025 15:25:36 +0000
Received: from AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::baa6:3ada:fbe6:98f4]) by AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::baa6:3ada:fbe6:98f4%7]) with mapi id 15.20.8511.026; Tue, 11 Mar 2025
 15:25:36 +0000
From: "Sverdlin, Alexander" <alexander.sverdlin@siemens.com>
To: "s-vadapalli@ti.com" <s-vadapalli@ti.com>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "srk@ti.com"
	<srk@ti.com>
Subject: Re: [PATCH net v2] net: ethernet: ti: am65-cpsw: Fix NAPI
 registration sequence
Thread-Topic: [PATCH net v2] net: ethernet: ti: am65-cpsw: Fix NAPI
 registration sequence
Thread-Index: AQHbkoW344hKP7+HDEmX75IUaoS7jLNt9MsAgAAX3YCAAAH3gA==
Date: Tue, 11 Mar 2025 15:25:36 +0000
Message-ID: <373ae7ef7ff20aa6dccefcb40e2312e9510132b3.camel@siemens.com>
References: <20250311130103.68971-1-s-vadapalli@ti.com>
	 <02d685e2aa8721a119f528bde2f4ec9533101663.camel@siemens.com>
	 <20250311151833.v3gymfqao4y2zls7@uda0492258>
In-Reply-To: <20250311151833.v3gymfqao4y2zls7@uda0492258>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.52.4 (3.52.4-2.fc40) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR10MB6867:EE_|PAXPR10MB7631:EE_
x-ms-office365-filtering-correlation-id: 0ff965e9-2260-4dd2-9ab4-08dd60b0f91f
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|366016|1800799024|7053199007|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?ajdaREoyalM0ckw1NW00WW90UEJuc01obHlNeklrNDFsVFovVVErcStJcWx6?=
 =?utf-8?B?c0ZJN0NHZzJsbGg3TnhFYkwvT3dxYzJZVFNhMXJ3MjVQL3llUlhiSXF1UnR2?=
 =?utf-8?B?Rks4UjVHdUhtM2tNMUZuQnA3bnBMQlhtUDZjU3g2M3poTjUyYXpqd3N5bXYw?=
 =?utf-8?B?a1lteFQzTXNXWWF1R1RUN1JtTWRKU0VCS3NJOFJzYzVBeEtBZTltdGdzak9J?=
 =?utf-8?B?V2V4Qm4xWm5xOUdQaFE5RXk2ekpGM1ZxaXJadDBSOXptenA4dlpNTnBBOGsw?=
 =?utf-8?B?SHJIZG1MOHphWVZqUUEzc1ZrSE5uNzZTMWd0bTd0WGE2anJlVVBUb3pnTjFK?=
 =?utf-8?B?NFRGU0ZTaGpadzRsYjF5MkNWUWJvZ1Vsc3hCVDlDams0bFBWL1JIQWhGbWVl?=
 =?utf-8?B?VEgzRjBMbHNBbzhvbWliOW40NkE4emFaZnlDd2NkeGtJaGRjeFl4NnRtUkpz?=
 =?utf-8?B?TlRCc3NpVUl1OXMweXlYeDBMRjg1eXJnZm04MFBadDZuOU8zNWI0clRCSGQ3?=
 =?utf-8?B?WjFTM0lRSUt1NGg2OE94S2lpai83UEdQRlZHNGZBMHVvSCtQckxKdE1CYWZF?=
 =?utf-8?B?c29QUWU1YnpCSElZM0hqS2MxV1g0SUJLT25GbUpjVFBBS214eGxsUEhQNzBy?=
 =?utf-8?B?RkpUUE16QmdsQWNxSW02ZXRFNUxqaDBhNWVGeUc3NkhSc3VuY3d5NU4rZVFF?=
 =?utf-8?B?UzByaWV6Kzk0QjN0SllaKyt1aXY0a3g0RDczbmxZZDNoQnJ4SEx5NHAxczhm?=
 =?utf-8?B?OTU0S0NFcCtLR0ZkUnEweDJpUEdTeWxsQWxReUxWK1dlSUNMd1NLSHBZRE1R?=
 =?utf-8?B?bGtKb1RiVUwwZVR0a2VPd09rMy9CelNOV2VBNVlMaWFIZDRsVkh5YmhYVjVn?=
 =?utf-8?B?b05IQ2g3M0ZuRXgxYkNEMC9RVTVISWhSSk5GTExzbm5MS1djZWRkR1d0WWY5?=
 =?utf-8?B?d0VZUk9LT0xIWEVDQXl2WXVreFYvOGhYdlBRbUpsTDhDcHlicnR6VHc5Z3Qr?=
 =?utf-8?B?eXQ1L3VGV1lKR1I5b0VQYVpnVUR4R2ljM2dkbXJvUFVCVmNjOGlkcTlIaVFC?=
 =?utf-8?B?QzNFbmM3Z2c1OXJGRThHYXRPMWVYNUtyQnRUZ0xXQnRadmxZV0lETkJKZFBw?=
 =?utf-8?B?SkZMc2w2UFVWZXk4NzVIVUhZcnZzLzdtUFQwa1JLTG1Ld3VDKytnaFdCVVpQ?=
 =?utf-8?B?NVNEOGZrQzh2K3pYWURxMTVJbmxXeUQzR0FER2l2YzF2VWFST0IrejkvVDFl?=
 =?utf-8?B?NXpUUHFMTG9pdmdnOExoQ29BQWlzUTZ6L0l0bkRjMDV4UnVvZmhNOGd4T3NS?=
 =?utf-8?B?YkVKcHRVZXEzRmY4RklPZ0V6S2wrV2tlVU9TcmxWWVlpOERLM1RWQ3RzWUZt?=
 =?utf-8?B?L1R6UkwxYmVDRHN3UnlPQjg4MzRuUkxZMGlBWEFQN3g5ZHZCVnM0cXdkNVdE?=
 =?utf-8?B?R2tJSFp0QWJBVHV6NUFQdkd2UTE2WGFXSEQzeThEclVqR25kV0RhTXJ2S2N0?=
 =?utf-8?B?cEw2QmpmcElYc0FkL1YzL1UyYXR2TnU1UWF1TWM4dVgrMDdhaGd3OFRCTzNE?=
 =?utf-8?B?VEFIdVp2RTlobyttL2FacEgrcGVhV21HL2J6SURHQ1dZV1ZKeGNLUzRGekdj?=
 =?utf-8?B?VitEcXkybm1UR1RYTHVGY094QUJtSHFvU3gwK2FRSGY4L2I3NUl3YnViUHFE?=
 =?utf-8?B?VmlJc0Z5VE5YRUpzeDZOaTJ5QyswenNDVy8wQlgwYlNzZTd2R2s5ZzRUanBy?=
 =?utf-8?B?dTlsa1hSRHVkY29vc2ZoRzFIem9WeHljYWVwWWlFeXhvN0FsaUlncEZFZ21a?=
 =?utf-8?B?VSsrZnZkd1B6RGdHYm5qalBUMjlhMmFVeFRIenVrV0d4VG9JbHFHMERKZ3NS?=
 =?utf-8?Q?FZuezJog3S04w?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7053199007)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?NkFMQXlQejl0MkdKWmJ2TmxVSzBWYkc0ZDVvVjZRaUxKbGdDUU9BZGUvOHdr?=
 =?utf-8?B?SWY2cFFYcHNUZS8wMksxWVhEdWdJRkpNYVVJQUVJQWpNNEVReGh6MWJvMGVN?=
 =?utf-8?B?cVh2aWtQN2VZSzY0eWQxWWMxUFhCSW9UZ1ZaaDJhRFg3ZmZ6ZUJ5UlpRdDFD?=
 =?utf-8?B?UW04RTVneVRwZWtocE5UMDl6WFluMFl2eTRUZ1BxUzFKdHhVU1kzTnRlYlAz?=
 =?utf-8?B?NFhlWG1PQVUxSVZlUjV1RS9qTmFiUlhoK3Y4Q2ZLdnYwaTQ0NER2NXVCNU1t?=
 =?utf-8?B?RmowcllQWkhoZ3JJRmVLNlBiQm9tYTBvNXlTblhYakFiMmhicmhPV2Fqa0l4?=
 =?utf-8?B?UXpNRHBMUnlFQ1FxbnRmNHJ2aU95Qkl3S3FadDJRM2RxaWNoaVZ5VFVvNS9p?=
 =?utf-8?B?RlV2SFhkVUUxRjBFelRhL1I0SkRkQ2Q1RTdHZUhHNmlVQ0Y2NS8rUlRPYmpN?=
 =?utf-8?B?U1hrcEpjV2VKK1NQQUs4Q3FXcG9tZFFUelY5WVlZN1R1WEphSzFicndqekwr?=
 =?utf-8?B?S00yVERlK0RPM1Zhc0cyV2F0aFd1UHZCSk5mdzYvNmlqdEN0aW00N3V0UDMy?=
 =?utf-8?B?bWMxemYrbFJsYkUvbENzTXFIQ2dsZ1ZhcDdyVkpWeFpHY3o3Qk5HMUZ3bXc5?=
 =?utf-8?B?dTV3dXR6ZzNYNmR1NVNPTnhheTJrdjFPL2Y2YlVaRFRlcUpKMEJGaW03SEFI?=
 =?utf-8?B?TVNORkZMb1RPNEZ0ZWR1UTgzaTE1THNzYldmVU9pRE5XWjMyK1IvOUlsWjNT?=
 =?utf-8?B?S1BDRVFZdXZleWxmS1NnYkZxa0UzUkJidkUwZTYvT29PODZOSWZPZXhjbm9w?=
 =?utf-8?B?VnBHcWNXa2JtNWhvMlR6SXVvOStRZHVOdExDWnU5VkxycjNEOStQanUxRnFo?=
 =?utf-8?B?Nld3QUpqRUlHS1REOEZHS0Y1dWN0d2FhbXhOTXlldGEwZTNFOTg5QWV6cXR6?=
 =?utf-8?B?ZHhZTFp6dzJFdTdrQTZDUE05QUlLT084OE9tMnhOR3ZWZFp2azN2eGY4YlJa?=
 =?utf-8?B?akhVUWZucjVqVXczMFRoblE4YUhDNFJkOUFvOXkxQ2RQZzhwaGlwZWxoaDBR?=
 =?utf-8?B?cXpFOFkwaFhpVWVTV2Y0OFhvYTY1U1FNZDl5V25mSjk1b3BDOW1EZWN4dGx2?=
 =?utf-8?B?WDB2M0lUNVZYaW1NaW0xT0ZJNU44b2RGaDlTeS9wVUFabUJhcW5JMHZaT0tW?=
 =?utf-8?B?SkN4NmFmTndhcUpOT3YvNU1qL29pdVpqdUU0ZTgvOFViWUtEcGtwWnpWbTRq?=
 =?utf-8?B?VnM3bHhJdFZaaDhicTV3QWFiTnBCUE8zWkRYUXdpTFpmSGlEc0ZDWm8vbXR5?=
 =?utf-8?B?RmljdUpJRTB3UW8yVDdHbUVjdjcwOFZ3bkYxSm1oR0F1SXdtby9vR1pZK2xs?=
 =?utf-8?B?MXM3WTZMMzdKem5sdVhSeTE3cUg2eFp4aEFtOHB3cjFYMWhuOGQyZzVOc2JX?=
 =?utf-8?B?L0hldkp3ZDhaZVpSLzBBZkYxKzV2QnpvL3dMWE1uekZKRlhrbFVvemJBOTdz?=
 =?utf-8?B?MW5qQVpySzd1cDZsM3NPMGMzUktETmFtOWRnVjNyZ2xDN3lvYVppTkIrN2RR?=
 =?utf-8?B?c1MzSSt6WUZPQ01kL2FuS2hZc2xlcFNiMjBXRWpXVENPTjYxemlQSDh1M2tp?=
 =?utf-8?B?MDg0RnBYN1hZSERiYU1Sek1UWVlFQnhRZ0NUQXNTN2l4bThzbGdyV1E5dk50?=
 =?utf-8?B?OWVpNm9BZWd4NEdMdGVTTGVyNVBjYlhhalJyL2lib0tZdzNaRS9Vak1jYjJH?=
 =?utf-8?B?ZXhIcTNNU3pycDl5YXhGZUplVU02dHNkM09yVDRBTFdUQUtxbGh0bG80Q0N2?=
 =?utf-8?B?OWUrWmozQm5mK3dUbGlQdTJQTEdKMTNzRXIwL3dCY1Z2RGJqSzh1ckdBaHlH?=
 =?utf-8?B?U3NyclRwM2huUWEzNDJKZmZUa055OElBRXBpTVBCTFFrSUlZc0dJVzR4QWI5?=
 =?utf-8?B?ZHFDYkdENWJ5VERSRXlrOEI4L0pZdERVQmZlUFRsMlYreVNzQVpINy84TlNh?=
 =?utf-8?B?K1dpK2JrT3Y0bzhtbHZyWFY4aU1iR0Y1R01vMGhpUngxQUFGc1J5WEtMb0cz?=
 =?utf-8?B?WVl6VFN6WHlOaktId0FLUTZQUGMyRWUrbUNBVTVyUE8wRFRsci9ZbTF6a3di?=
 =?utf-8?B?ZHkzS0FOMytpSTR4UHd2WXp5N3hsUzJid0dsek42Z2h3U1hkOE8wRS85UnlL?=
 =?utf-8?Q?KjF2HoZJ5NNLlWSu4lmLfbw=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <823B6A849BD53940B4A261AA2F26EF00@EURPRD10.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ff965e9-2260-4dd2-9ab4-08dd60b0f91f
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Mar 2025 15:25:36.6520
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aNIkuTFBk4LupUnb12sjPWhX6pWlKLEDbVsWMXw4n03gQv/q7hANEPCVx2ntQZ2YWiR6o+DbW0ftgSbrzy4CFjQTwKP8ctRwDDMw6EYPvsg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR10MB7631

SGkgU2lkZGhhcnRoIQ0KDQpPbiBUdWUsIDIwMjUtMDMtMTEgYXQgMjA6NDggKzA1MzAsIHMtdmFk
YXBhbGxpQHRpLmNvbSB3cm90ZToNCj4gPiA+IFJlZ2lzdGVyaW5nIHRoZSBpbnRlcnJ1cHRzIGZv
ciBUWCBvciBSWCBETUEgQ2hhbm5lbHMgcHJpb3IgdG8gcmVnaXN0ZXJpbmcNCj4gPiA+IHRoZWly
IHJlc3BlY3RpdmUgTkFQSSBjYWxsYmFja3MgY2FuIHJlc3VsdCBpbiBhIE5VTEwgcG9pbnRlciBk
ZXJlZmVyZW5jZS4NCj4gPiA+IFRoaXMgaXMgc2VlbiBpbiBwcmFjdGljZSBhcyBhIHJhbmRvbSBv
Y2N1cnJlbmNlIHNpbmNlIGl0IGRlcGVuZHMgb24gdGhlDQo+ID4gPiByYW5kb21uZXNzIGFzc29j
aWF0ZWQgd2l0aCB0aGUgZ2VuZXJhdGlvbiBvZiB0cmFmZmljIGJ5IExpbnV4IGFuZCB0aGUNCj4g
PiA+IHJlY2VwdGlvbiBvZiB0cmFmZmljIGZyb20gdGhlIHdpcmUuDQo+ID4gPiANCj4gPiA+IEZp
eGVzOiA2ODFlYjJiZWIzZWYgKCJuZXQ6IGV0aGVybmV0OiB0aTogYW02NS1jcHN3OiBlbnN1cmUg
cHJvcGVyIGNoYW5uZWwgY2xlYW51cCBpbiBlcnJvciBwYXRoIikNCj4gPiA+IFNpZ25lZC1vZmYt
Ynk6IFZpZ25lc2ggUmFnaGF2ZW5kcmEgPHZpZ25lc2hyQHRpLmNvbT4NCj4gPiA+IENvLWRldmVs
b3BlZC1ieTogU2lkZGhhcnRoIFZhZGFwYWxsaSA8cy12YWRhcGFsbGlAdGkuY29tPg0KPiA+ID4g
U2lnbmVkLW9mZi1ieTogU2lkZGhhcnRoIFZhZGFwYWxsaSA8cy12YWRhcGFsbGlAdGkuY29tPg0K
PiA+IA0KPiA+IC4uLg0KPiA+IA0KPiA+IA0KPiA+ID4gQEAgLTI1OTAsMTAgKzI1OTEsMTEgQEAg
c3RhdGljIGludCBhbTY1X2Nwc3dfbnVzc19pbml0X3J4X2NobnMoc3RydWN0IGFtNjVfY3Bzd19j
b21tb24gKmNvbW1vbikNCj4gPiA+IMKgCXJldHVybiAwOw0KPiA+ID4gwqANCj4gPiA+IMKgZXJy
X2Zsb3c6DQo+ID4gPiAtCWZvciAoLS1pOyBpID49IDAgOyBpLS0pIHsNCj4gPiA+ICsJbmV0aWZf
bmFwaV9kZWwoJmZsb3ctPm5hcGlfcngpOw0KPiA+IA0KPiA+IFRoZXJlIGFyZSB0b3RhbGx5IDMg
ImdvdG8gZXJyX2Zsb3c7IiBpbnN0YW5jZXMsIHNvIGlmIGszX3VkbWFfZ2x1ZV9yeF9mbG93X2lu
aXQoKSBvcg0KPiA+IGszX3VkbWFfZ2x1ZV9yeF9nZXRfaXJxKCkgd291bGQgZmFpbCBvbiB0aGUg
Zmlyc3QgaXRlcmF0aW9uLCB3ZSB3b3VsZCBjb21lIGhlcmUgd2l0aG91dA0KPiA+IGEgc2luZ2xl
IGNhbGwgdG8gbmV0aWZfbmFwaV9hZGQoKS4NCj4gDQo+IFRoZSBmb2xsb3dpbmcgc2hvdWxkIGFk
ZHJlc3MgdGhpcyByaWdodD8NCg0KTG9va3MgZ29vZCB0byBtZSENCg0KPiAtLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0NCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbmV0L2V0
aGVybmV0L3RpL2FtNjUtY3Bzdy1udXNzLmMgYi9kcml2ZXJzL25ldC9ldGhlcm5ldC90aS9hbTY1
LWNwc3ctbnVzcy5jDQo+IGluZGV4IGI4OGVkZjJkZDhmNC4uYmVmNzM0YzZlNWMyIDEwMDY0NA0K
PiAtLS0gYS9kcml2ZXJzL25ldC9ldGhlcm5ldC90aS9hbTY1LWNwc3ctbnVzcy5jDQo+ICsrKyBi
L2RyaXZlcnMvbmV0L2V0aGVybmV0L3RpL2FtNjUtY3Bzdy1udXNzLmMNCj4gQEAgLTI1ODEsNyAr
MjU4MSw3IEBAIHN0YXRpYyBpbnQgYW02NV9jcHN3X251c3NfaW5pdF9yeF9jaG5zKHN0cnVjdCBh
bTY1X2Nwc3dfY29tbW9uICpjb21tb24pDQo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqAgZGV2X2VycihkZXYsICJmYWlsdXJlIHJlcXVlc3RpbmcgcnggJWQg
aXJxICV1LCAlZFxuIiwNCj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgaSwgZmxvdy0+aXJxLCByZXQpOw0KPiDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGZsb3ctPmlycSA9IC1FSU5WQUw7
DQo+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBnb3RvIGVy
cl9mbG93Ow0KPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAg
Z290byBlcnJfcmVxdWVzdF9pcnE7DQo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB9
DQo+IMKgwqDCoMKgwqDCoMKgIH0NCj4gDQo+IEBAIC0yNTkwLDggKzI1OTAsMTAgQEAgc3RhdGlj
IGludCBhbTY1X2Nwc3dfbnVzc19pbml0X3J4X2NobnMoc3RydWN0IGFtNjVfY3Bzd19jb21tb24g
KmNvbW1vbikNCj4gDQo+IMKgwqDCoMKgwqDCoMKgIHJldHVybiAwOw0KPiANCj4gLWVycl9mbG93
Og0KPiArZXJyX3JlcXVlc3RfaXJxOg0KPiDCoMKgwqDCoMKgwqDCoCBuZXRpZl9uYXBpX2RlbCgm
Zmxvdy0+bmFwaV9yeCk7DQo+ICsNCj4gK2Vycl9mbG93Og0KPiDCoMKgwqDCoMKgwqDCoCBmb3Ig
KC0taTsgaSA+PSAwOyBpLS0pIHsNCj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGZs
b3cgPSAmcnhfY2huLT5mbG93c1tpXTsNCj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
IGRldm1fZnJlZV9pcnEoZGV2LCBmbG93LT5pcnEsIGZsb3cpOw0KPiAtLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0NCj4gDQo+IGVycl9yZXF1ZXN0X2lycSA9PiBXZSBoYXZl
IGFuIGV4dHJhIG5ldGlmX25hcGlfYWRkKCkgd2hpY2ggbmVlZHMgdG8gYmUNCj4gY2xlYW5lZCB1
cC4NCj4gZXJyX2Zsb3cgPT4gRXF1YWwgY291bnQgb2YgbmV0aWZfbmFwaV9hZGQoKSBhbmQgZGV2
bV9yZXF1ZXN0X2lycSgpIHRoYXQNCj4gc2hvdWxkIGJlIGNsZWFuZWQgdXAuDQoNCi0tIA0KQWxl
eGFuZGVyIFN2ZXJkbGluDQpTaWVtZW5zIEFHDQp3d3cuc2llbWVucy5jb20NCg==

