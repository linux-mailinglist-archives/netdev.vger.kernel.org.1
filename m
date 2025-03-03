Return-Path: <netdev+bounces-171304-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B55B1A4C720
	for <lists+netdev@lfdr.de>; Mon,  3 Mar 2025 17:31:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AD8857A8F12
	for <lists+netdev@lfdr.de>; Mon,  3 Mar 2025 16:24:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 520C4218589;
	Mon,  3 Mar 2025 16:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="TUvWnQFy"
X-Original-To: netdev@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2076.outbound.protection.outlook.com [40.107.21.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B81132147FD
	for <netdev@vger.kernel.org>; Mon,  3 Mar 2025 16:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741018852; cv=fail; b=oEpCnGwajYFGtNrxamAIVMQxSX6DMi1EK2bOegZ0MRWNpfrOP1k134VhbR+zuupVvI/bWSrRzQIlhP2A1wS+8hDLPNo6WPWzgzrpHbyU1V+vj80Zl22ClfIZHgZClDe6X9uU51R/VMUEV+Q16HiKs7294Wn0766fCuCliya2MlM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741018852; c=relaxed/simple;
	bh=pbQD+YGJYZPf5tIbfjD8+S8iTvejjgTfRZNOKHJXu2w=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=LXLeIa3rFz/NmpVysmKWQRvDLtMVGSQq1aeLTHDgMg2YJzMYzYoFk2oHR3LjdNOHcC8HMi3OJfaOKVRqVYQknmn5wFDd1dPJz4oIicCx65D9PMGD+alwci/ZE6JcwjPYo5LAX5oMF7BxSefish8sHsWScM2qKMA8L4yqx6Td6pg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=TUvWnQFy; arc=fail smtp.client-ip=40.107.21.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T1vclD/vI08pQ/lAzPzCytD79xWpMyJ1rW/k8kgZhOQfrQwp0xZGTkSu2uHBGKb+yfmKIVXpCqQjnqJW/po1Oevfx4yMXqThN5fYQ8SLoWVJ97LSl62Rsz0pgAB+Qf8UAjrjtKarymwQzsSDjmCxMNvvA3+WRVDyC5LPssP++dCG75kvqn/G67gsJwg7yu+Aw1nxeENCtYKtDnb9AFdu09s6jW8Wer61/5fq9PvBXlrjoFJPgIytUZVtz7zq5nHDLmznYyFxiTTnkuVe2rBdyEyyAqevAYBY8gBUVyG2WyQ9CRkAOWO6DOvUMqmUn3JqYD4lzrmSWyHAYH6PsZn/vQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pbQD+YGJYZPf5tIbfjD8+S8iTvejjgTfRZNOKHJXu2w=;
 b=nE8pcIroFhawAnU2BXbI/K2G7etKZaUMxqhuwBTm38Lsc0FFSRjBr7yu8T2WriJ40TFWEKHZQ8LrXjjuEB+V+zeCIaOJ9UN5FsAR5wNi8Zr97Uf6Rnvd80WlWhhXUDpivSsyUFw8HkZixaqAzVHd/yG13tJSr++DgNy2Gd9wJKTUIx1Q/t2n9XAGSokxzr7AISrI1oNfxcQtOodbQGGNoR30GLRuUmWXX6NhdnR4xBDOVbFk7irgKnyDLP45h4I81XqN6pBwB33Yxm5TzO9z2aWk8ZzRakG/HBS6gLGNsxRHtVc8MyK/xcsgjyv/S2R/VQ7ownNtT+OAmH/MRKTpKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nokia-bell-labs.com; dmarc=pass action=none
 header.from=nokia-bell-labs.com; dkim=pass header.d=nokia-bell-labs.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pbQD+YGJYZPf5tIbfjD8+S8iTvejjgTfRZNOKHJXu2w=;
 b=TUvWnQFy4KaordvMFXaWX29a6ZRbesrCF9PJ04E80ooJMgYFaa78cpv1nSnw3lyytPYxcGnTJFpDplmNlsVEi7yidScEdQm6kKbDAYA3ei0P2fnglxgLc2ouL3IRoWhPq9L9QS+Nslw6WMdyfXONN4xB16iYwfBc2uGpEOnAQ+37oZ7kXOVWB+ZbpDWYjSkEy6b6jMS8EP/z+Nin/LQbUlr+XM09hl9vB1eJHwbng394fhA2V87IZmJG5fB/10y1wINHrm0K4G9WtOU/XRKL09l+PPB4WRtoXGT5c/JsB4lzK7sgjr3VJwBBgg+mFlP2mGixAPj1zqr/SF4MVH9grQ==
Received: from AM6PR07MB4456.eurprd07.prod.outlook.com (2603:10a6:20b:17::31)
 by DBAPR07MB6888.eurprd07.prod.outlook.com (2603:10a6:10:194::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.28; Mon, 3 Mar
 2025 16:20:46 +0000
Received: from AM6PR07MB4456.eurprd07.prod.outlook.com
 ([fe80::9dad:9692:c2c3:1598]) by AM6PR07MB4456.eurprd07.prod.outlook.com
 ([fe80::9dad:9692:c2c3:1598%4]) with mapi id 15.20.8489.025; Mon, 3 Mar 2025
 16:20:46 +0000
From: "Koen De Schepper (Nokia)" <koen.de_schepper@nokia-bell-labs.com>
To: "Chia-Yu Chang (Nokia)" <chia-yu.chang@nokia-bell-labs.com>, Alex Burr
	<alex.burr@ealdwulf.org.uk>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "dave.taht@gmail.com"
	<dave.taht@gmail.com>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"jhs@mojatatu.com" <jhs@mojatatu.com>, "kuba@kernel.org" <kuba@kernel.org>,
	"stephen@networkplumber.org" <stephen@networkplumber.org>, "jiri@resnulli.us"
	<jiri@resnulli.us>, "davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>, "horms@kernel.org"
	<horms@kernel.org>, "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
	"ij@kernel.org" <ij@kernel.org>, "ncardwell@google.com"
	<ncardwell@google.com>, g.white <g.white@cablelabs.com>,
	"ingemar.s.johansson@ericsson.com" <ingemar.s.johansson@ericsson.com>,
	"mirja.kuehlewind@ericsson.com" <mirja.kuehlewind@ericsson.com>,
	"cheshire@apple.com" <cheshire@apple.com>, "rs.ietf@gmx.at" <rs.ietf@gmx.at>,
	"Jason_Livingood@comcast.com" <Jason_Livingood@comcast.com>,
	"vidhi_goel@apple.com" <vidhi_goel@apple.com>, Olga Albisser
	<olga@albisser.org>, "Olivier Tilmans (Nokia)" <olivier.tilmans@nokia.com>,
	Henrik Steen <henrist@henrist.net>, Bob Briscoe <research@bobbriscoe.net>,
	Cong Wang <xiyou.wangcong@gmail.com>
Subject: RE: [PATCH v5 net-next 1/1] sched: Add dualpi2 qdisc
Thread-Topic: [PATCH v5 net-next 1/1] sched: Add dualpi2 qdisc
Thread-Index: AQHbhRGphj7HJUjGiECHExRVgQ6fp7NYxDQAgAc7ENCAABaQAIAAi5yAgAEB+XA=
Date: Mon, 3 Mar 2025 16:20:45 +0000
Message-ID:
 <AM6PR07MB44560A0CF279F7D4DC601667B9C92@AM6PR07MB4456.eurprd07.prod.outlook.com>
References: <20250222100725.27838-1-chia-yu.chang@nokia-bell-labs.com>
 <20250222100725.27838-2-chia-yu.chang@nokia-bell-labs.com>
 <Z75jOFUVWNht/JO0@pop-os.localdomain>
 <PAXPR07MB79844B87A8573E4CFF7F6993A3CE2@PAXPR07MB7984.eurprd07.prod.outlook.com>
 <s6XvSuJ8nXItuCMN4KLwbJvYh8P3pAtM4TpVWLomsju1tts9T7CGMmmuWSJcIhkC-aXOZndLLoB8jIfDCwdkVH6POUi86FIO5jfkcUhI2nw=@ealdwulf.org.uk>
 <PAXPR07MB7984FC1BD619D9F667DD9A00A3C92@PAXPR07MB7984.eurprd07.prod.outlook.com>
In-Reply-To:
 <PAXPR07MB7984FC1BD619D9F667DD9A00A3C92@PAXPR07MB7984.eurprd07.prod.outlook.com>
Accept-Language: nl-BE, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nokia-bell-labs.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM6PR07MB4456:EE_|DBAPR07MB6888:EE_
x-ms-office365-filtering-correlation-id: f72cb8d6-1a05-403e-14f4-08dd5a6f5a51
x-ld-processed: 5d471751-9675-428d-917b-70f44f9630b0,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|10070799003|376014|7416014|38070700018;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?VTP3HhhObE7Pc2gyQ4OvyCvQZpOAnBOkXFc3Pycr+BHm6PuI7KiCjcqmZ+?=
 =?iso-8859-1?Q?k/gkXT5xjCtq9heWRWdugMXv1xBEQ6bMbob4QKf+YT8K/uCQQsZVpwhlXG?=
 =?iso-8859-1?Q?XtOemc/DUxU0BwdO8DGzWWlHAP1kVgX61mAglmQMne34GXy/Q1aKF/j3P8?=
 =?iso-8859-1?Q?ILCNOZWXcM5T/HMWvQ7EdYWs0LMq4pSFaI+SVes1DMiJltqBlryis5JMPb?=
 =?iso-8859-1?Q?cggMNC7wUm+jDIbeQ3coyrZAylD2BV0sEm6hPr2YH1YVoMpgYcZL3kNeHb?=
 =?iso-8859-1?Q?XLi14XzalgOLQTNu774cL3TGd6GAmK2/D6y95mK6RFHp4LBh7FNpIqrVY6?=
 =?iso-8859-1?Q?QY/czYGQEAqHafeROJBpNqvH81EP9ACHAgE9HfJBBqQHi0DyCk5Xr/jjhI?=
 =?iso-8859-1?Q?NS0xOCKJfjdZg/liu8Ku8kzroircYB1iz5oD1DPYd+BLqSs8uQ+kZOBVhn?=
 =?iso-8859-1?Q?4b+QChZBv2Wd5KKAwGPNDEo+XQCiotU0nPLTERX8e1GYLTP6FniAwWbr+m?=
 =?iso-8859-1?Q?JL97EkM/lskgPzW2Ap9nrRhkDlDQCZfIfxWN+nl9XsjMq2tv7wN9siEAzt?=
 =?iso-8859-1?Q?8I6ivBCPL5VzgVMjjG3VhBYdNJdWHVmJc1hsLANXTIhBNTaox9D9UNHJfA?=
 =?iso-8859-1?Q?+4POvssRA64KLMz3PVrPkmreGZgBfmOZYtHRvsW33+VbahkaXWepdZ0JBd?=
 =?iso-8859-1?Q?sEKaZ9yoPkSbTMuOIjWc3d8mydu3gGLuIdga6C0hQ2mDLH52PUP9j2O39E?=
 =?iso-8859-1?Q?UH5zTmg3AcVwBoFAtWeb5HlkN8DrXWbGzn4ZfbkWwuobr1MsH5RGC8bVhw?=
 =?iso-8859-1?Q?NNSA7SUqfxOkz/FgP1SQp2aLcAjB1xxc5XlbR8Pzl4ZFnWzwmMSZ4a/SVt?=
 =?iso-8859-1?Q?fnum+aSfPBACwtcspfFAK9bh0HY3kM0U5mC7yppbDILB9ZGWR25nkDfqd2?=
 =?iso-8859-1?Q?VoV5yroNU/jgl3fs+sm9xWgZHgk5/oLJbTIJgv5o21Ck7oDzVAyefW+Jc9?=
 =?iso-8859-1?Q?wiz0088gBH4qzNdUXWOILEvNIgtu/LX9xolqSHlcU1BOULqv63ZA3t3Q/x?=
 =?iso-8859-1?Q?g4JNuDI/YV/vwnRoZeHq+NpOScwXGEtszFCCVy9fmBavkrPM7O/KuNbjou?=
 =?iso-8859-1?Q?JDW0aKLa1Oh0wIo1r4UZaSXS/nWsFq7ruXzg7mR4XjiE6TYNFsoIH4DZU4?=
 =?iso-8859-1?Q?dQc9bGNIYxTBEGihJVzEhTHd8vLqC8blQtmvUv39t2AAShZAi7NOtC8iaK?=
 =?iso-8859-1?Q?K8v4cOhVUAjeY4mZ6wG2bdMKZFi8YA4QRAojjPRpmUF/DTcD3ldHc4OPsA?=
 =?iso-8859-1?Q?dZkL9RLhZLwruiZKQt9F/VT68n3bC1mmx2QFKkiiceGvZx3Xv7REkwHctm?=
 =?iso-8859-1?Q?W0/wH9xqbw6x1hk3L/BHZwDCZ5RQQ12GDW0kw8514IT/Uh13eBoWKcX+rp?=
 =?iso-8859-1?Q?x0NpKYO7xjxB+gZF?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR07MB4456.eurprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(10070799003)(376014)(7416014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?0l1l3Dj2VL/DCJn/yTijExdRojdip3HiBaMYBO1CWB28NbdHOdIwffp0Z0?=
 =?iso-8859-1?Q?+kPQkuBrHc8ubnAH5Mwu63amRJxAvriYcGLmiXfx2XxYisxR0Wr70dIb2o?=
 =?iso-8859-1?Q?p0eCyHUhf74n2QpxmDtuxn0D9LKwZbWUDE1WmIjBJDvl3PgOod/v1vSAan?=
 =?iso-8859-1?Q?JP3E/6RDcxm7vxbZETp2MVtqlLWro7gd2aEYP7yjdkYoGNJFUdKcN7AmAN?=
 =?iso-8859-1?Q?2nftGkoaQYWuWGMF4sPTQqTkYUmrHU59ymbnBTdRAMpRmMqPRPKJwEHFTx?=
 =?iso-8859-1?Q?K+NSYxl8TZj1F6QbNhzDzBP1TOnXesmdGglK52hRKbPmOtNtSfOQkh8ayH?=
 =?iso-8859-1?Q?Hn4qHcoEmK9GTJf4j23pvuupo4qaDzAWtrVbuZVL+XSynvhJFtJYUDfwoh?=
 =?iso-8859-1?Q?ZqiYvQYBY+u8/q6/Ez/LtFIlSkcTSf5f8sQ1eq0GWN4UlIWBWySfqM9ZMY?=
 =?iso-8859-1?Q?9UVx7rRxq9NC/ybmZ4KcrHdMejEshNJQW1Wps/m97xd4p6uLPNjN9WSLn9?=
 =?iso-8859-1?Q?NFY9TBTsJwASff02Y30fY2s5KttNUh4KRbT6Bi+hf02Nh6bZMSkjMAbj3b?=
 =?iso-8859-1?Q?r4DgT3oSm5x4ajSC4euLgGcbS+61ywnzsCnuDRsuJi3Xk1AE7g9ZXUbUfM?=
 =?iso-8859-1?Q?plVJISBhH5MvQwSFYcR0PGKTTWl/zXqGh921kKWm8jUSaiyJKNVdQmDP7A?=
 =?iso-8859-1?Q?3Yavgq+36vwjDkRCYIUyx2acG4ZkrwREpflKRaBEOXOJIpWwKY8wFAgPIJ?=
 =?iso-8859-1?Q?SscZCIPVVWfnXbWa9zg9bIJmmlf2g0jkzaF0d7aDmmKauDJeCvxcMz8uRP?=
 =?iso-8859-1?Q?53z8YPh7rmreT4cCApIxM+8ujtAx4GDyntR1jcbBZzGYW+XKGBrfHgBmN3?=
 =?iso-8859-1?Q?FrsnsJgnQjq+Ra1iqSdc7NDvVvOWVno6K+sdCM7A0b6I9I0+3ZOmtQC3QM?=
 =?iso-8859-1?Q?1UVnQBb1gqcoYs5ueQlynRkdEIi1vH5TzG7DMUv0DFqAfEbkSlrG1fwu57?=
 =?iso-8859-1?Q?laMhF2sd7YQS4DgmVEEIKG71iwYUkAbgSDMaQBS4aVHIs0+Au+SuI4UP+B?=
 =?iso-8859-1?Q?ei017t/baTpgLFyRowvKmo4lFXJ5Gdl+hc0L+85nlN0LeTz4VnnrYw9yyE?=
 =?iso-8859-1?Q?V8dQaIgV/R+jQQhGU+hkVn/zUcC7Qs2YS8+PHHBpCtpej3e85ZFY1tXUgg?=
 =?iso-8859-1?Q?/6M1Q7JNpV9OYVp4OXTkjP2fZlfo8Q5UXJcrRMvj1j7jBEHNXk8ZKBti4t?=
 =?iso-8859-1?Q?vrKmUAOnvBEjScbsWh5UMfcNp0C3UVLuZ0WF6xReb1UqruMXfguFGemS7b?=
 =?iso-8859-1?Q?oi5YtGAnkMjhhFPAvaYRYSTZqc1OuM8ta7B8infIf7a/ODqdMXketgdPr1?=
 =?iso-8859-1?Q?pygjlRiTw0ciIUVmp8OfOAqT0OsHntDOFtnG+C8XzFsBhwJW03wrbrDL0R?=
 =?iso-8859-1?Q?gFu8Dkm/RpRQoTHpMOEc9TBcf8e5hr6Pw0UKrcXQH1z1pGchLhUd/as5vI?=
 =?iso-8859-1?Q?18OovQBuXAlglVCVXriXui3b+nPnsTLEgZQEgP52Q5M1y+NYyxl7A1NUjM?=
 =?iso-8859-1?Q?EUocXfQNzLDV1OxffqvRdyHzT33Yw1uGL9JA4cPlT6OmC+6h83gp8rEgjZ?=
 =?iso-8859-1?Q?xibAXOaeDjrV1VRP4qKwDr3a4g7YcZae4KonV8QI2S8wTmbQaaiSxXPaoQ?=
 =?iso-8859-1?Q?5p7CK+3P0FMerBpcuzwa12VdcUqcADMTZMPkctrQMIlpSybwai+KvLFZfh?=
 =?iso-8859-1?Q?Tko7FfcxaRdRaLoYQYoNwrXGY=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM6PR07MB4456.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f72cb8d6-1a05-403e-14f4-08dd5a6f5a51
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2025 16:20:45.9076
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fVHe2lCTNbwIZsaw38qUpZ8pd2elt4Vt0t1wbUazbx1Wdh08qNLaG8UpGx0MMvxOKhPNbV7QWWsLuEDRORAze2dL18WJYc002A86b6agwXLFBV0PO5c/F5U6bzdjlzrM
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR07MB6888

Hi all,

Thanks for suggesting the idea, but we stopped supporting Curvy-RED because=
 it had quite some disadvantages (queue grows with more flows, creating ext=
ra RTT dependencies, difficult to tune, etc...). For research purposes, you=
 can always copy and update the DualPI2 qdisc and change the classic AQM co=
de. It will be too much work to adapt to any AQM (qdiscs)... (for instance =
how do we extract the native non-squared probability, or do we always assum=
e p=B2 and need to squareroot, ...). So, as long as there is no benefit, I =
don't see the need to complicate things and make a plug-in framework for ot=
her classic AQMs (qdiscs).

Regards,
Koen.

-----Original Message-----
From: Chia-Yu Chang (Nokia) <chia-yu.chang@nokia-bell-labs.com>=20
Sent: Monday, March 3, 2025 2:11 AM
To: Alex Burr <alex.burr@ealdwulf.org.uk>
Cc: netdev@vger.kernel.org; dave.taht@gmail.com; pabeni@redhat.com; jhs@moj=
atatu.com; kuba@kernel.org; stephen@networkplumber.org; jiri@resnulli.us; d=
avem@davemloft.net; edumazet@google.com; horms@kernel.org; andrew+netdev@lu=
nn.ch; ij@kernel.org; ncardwell@google.com; Koen De Schepper (Nokia) <koen.=
de_schepper@nokia-bell-labs.com>; g.white <g.white@cablelabs.com>; ingemar.=
s.johansson@ericsson.com; mirja.kuehlewind@ericsson.com; cheshire@apple.com=
; rs.ietf@gmx.at; Jason_Livingood@comcast.com; vidhi_goel@apple.com; Olga A=
lbisser <olga@albisser.org>; Olivier Tilmans (Nokia) <olivier.tilmans@nokia=
.com>; Henrik Steen <henrist@henrist.net>; Bob Briscoe <research@bobbriscoe=
.net>; Cong Wang <xiyou.wangcong@gmail.com>
Subject: RE: [PATCH v5 net-next 1/1] sched: Add dualpi2 qdisc

Hi Alex,

Thanks for your prompt feedback, please see below.

> Hi Chia-yu,
> Please see inline
>=20
> On Sunday, 2 March 2025 at 15:37, Chia-Yu Chang (Nokia) <chia-yu.chang@no=
kia-bell-labs.com> wrote:
>=20
> >
> >
> > Please see below inline
> >
> > Regards,
> > Chia-Yu
> >
> > > -----Original Message-----
> > > From: Cong Wang xiyou.wangcong@gmail.com
> > > Sent: Wednesday, February 26, 2025 1:41 AM
> > > To: Chia-Yu Chang (Nokia) chia-yu.chang@nokia-bell-labs.com
> > > Cc: netdev@vger.kernel.org; dave.taht@gmail.com;=20
> > > pabeni@redhat.com; jhs@mojatatu.com; kuba@kernel.org;=20
> > > stephen@networkplumber.org; jiri@resnulli.us; davem@davemloft.net;=20
> > > edumazet@google.com; horms@kernel.org; andrew+netdev@lunn.ch;=20
> > > ij@kernel.org; ncardwell@google.com; Koen De Schepper (Nokia)=20
> > > koen.de_schepper@nokia-bell-labs.com; g.white=20
> > > g.white@cablelabs.com; ingemar.s.johansson@ericsson.com;=20
> > > mirja.kuehlewind@ericsson.com; cheshire@apple.com; rs.ietf@gmx.at;=20
> > > Jason_Livingood@comcast.com; vidhi_goel@apple.com; Olga Albisser=20
> > > olga@albisser.org; Olivier Tilmans (Nokia)=20
> > > olivier.tilmans@nokia.com; Henrik Steen henrist@henrist.net; Bob=20
> > > Briscoe research@bobbriscoe.net
> > > Subject: Re: [PATCH v5 net-next 1/1] sched: Add dualpi2 qdisc
> > >
> > > CAUTION: This is an external email. Please be very careful when click=
ing links or opening attachments. See the URL nok.it/ext for additional inf=
ormation.
> > >
> > > On Sat, Feb 22, 2025 at 11:07:25AM +0100, chia-yu.chang@nokia-bell-la=
bs.com wrote:
> > >
> > > > From: Koen De Schepper koen.de_schepper@nokia-bell-labs.com
> > > >
> > > > DualPI2 provides L4S-type low latency & loss to traffic that=20
> > > > uses a scalable congestion controller (e.g. TCP-Prague, DCTCP)=20
> > > > without degrading the performance of 'classic' traffic (e.g.=20
> > > > Reno, Cubic etc.). It is intended to be the reference=20
> > > > implementation of the IETF's DualQ Coupled AQM.
> > > >
> > > > The qdisc provides two queues called low latency and classic. It=20
> > > > classifies packets based on the ECN field in the IP headers. By=20
> > > > default it directs non-ECN and ECT(0) into the classic queue and
> > > > ECT(1) and CE into the low latency queue, as per the IETF spec.
> > >
> > > Thanks for your work!
> > >
> > > I have a naive question here: Why not using an existing multi-queue Q=
disc (e.g. pfifo has 3 bands/queues) with a filter which is capable of clas=
sifying packets with ECN field.
> >
> >
> > Making two independent queues without "coupling" cannot meet the goal o=
f DualPI2 mentioned in RFC9332: "...to preserve fairness between ECN-capabl=
e and non-ECN-capable traffic."
> > Further, it might even starve Classic traffic, which also does not fulf=
ill the requirements in RFC9332: "...although priority MUST be bounded in o=
rder not to starve Classic traffic."
>=20
>=20
> Nevertheless, RFC9332 allows the use of different AQMs. It might help to =
get this work past netdev, if you can show how the PI2 part could be split =
out if, eg, someone wants Curvy-RED instead.
>=20
> Alex
>=20
Yes, you are indeed correct, RFC9332 allows for alternative queue managemen=
t.

First, the dualpi2 formulas can be found at https://www.bobbriscoe.net/proj=
ects/latency/dualpi2_netdev0x13.pdf which may be useful to see its performa=
nce and people to develop based on pseudo code on particular hardware when =
L4S traffic is needed.
Also, in sch_dualpi2.c, the must_drop() function is the place we decide whe=
ther we are using dualpi2_scalable_marking() for L4S (i.e., the marking pro=
bability is 2 times the Base PI probability) or dualpi2_classic_marking() f=
or classic (i.e., the dropping probability is the square of the Base PI pro=
bability as PI2).

However, related to split it out, I need to restructure dualpi2_sched_data =
because now it is particular to dualpi2 data structure.
I am now thinking about elaborating it in the function comments and can mak=
e it more general in the future if we see other really wants to try another=
 AQM.
Any other ideas?

Best regards,
Chia-Yu
> >
> > DualPI2 is to maintain approximate per-flow fairness on L-queue and C-q=
ueue, and a single qdisc is made with a coupling factor (i.e., ECN marking =
probability and non-ECN dropping probability) and a scheduler between two q=
ueues.
> >
> > I would modify commit message to reflect the above points, and hope thi=
s if fine for you.
> >

