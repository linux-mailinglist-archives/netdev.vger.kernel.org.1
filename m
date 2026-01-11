Return-Path: <netdev+bounces-248857-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id EDF38D101DC
	for <lists+netdev@lfdr.de>; Mon, 12 Jan 2026 00:00:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8C2563031CF3
	for <lists+netdev@lfdr.de>; Sun, 11 Jan 2026 23:00:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBF4B242D9B;
	Sun, 11 Jan 2026 23:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=psu.edu header.i=@psu.edu header.b="o2y4afha"
X-Original-To: netdev@vger.kernel.org
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010029.outbound.protection.outlook.com [40.93.198.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E0F0208961
	for <netdev@vger.kernel.org>; Sun, 11 Jan 2026 23:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.29
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768172448; cv=fail; b=sKde9pGwVLxVULiwt3dWWAQ496mE7sw1TW46wYKnBWPxPVxaa23n4IsiqZxhj/Ksg8pGbg0tFyT6H+o3TfiiBAhsW/AWqdnQnAd6j6dz8luJIXKo5USTtc8ArKfhobeMlrMCJrN4tsQ/nxXB8yCvyc/GR5EYTupF1q82EQHPLig=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768172448; c=relaxed/simple;
	bh=Spyb5YLdUUUhruylSHtqjiuiENrV7opVBP1SvzuvT94=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=BiQBfVOUR6iuLGDJDnwCqsm9/dOKB16C0WbXMwvoX5QPYNlEVoGUFerQT/06WIw/4Su8GrON8dwHbMgwgBVsb3mbZtclkeZY36kG8LzYG43PwXium5GcIrziMP0riSOleeCfl+AaSCtOz2pDlwhiaLzrmfTkqVmnxfaBIkt+j9U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=PSU.EDU; spf=pass smtp.mailfrom=PSU.EDU; dkim=pass (2048-bit key) header.d=psu.edu header.i=@psu.edu header.b=o2y4afha; arc=fail smtp.client-ip=40.93.198.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=PSU.EDU
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=PSU.EDU
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Hj++R9bQ9kMPZ9uGSk+fVvBjnQ4NkKtxBi3jWgymy0pB8u4ttvl+pkOQh74E0x6ESkTRIAOubrshBx6U9kQTt2C5Un5oXplfGhOiJRZLN4xtCsWbCOXq0WtwzW7MV7fwHdFTTw+SGaD9RWyrZiNKZrr0cVEfT9FJw01KHzJf9qkgE3IziNuVrrx+ZY+uzp9ZSoCsC6n4U/vcRN54HSGSqXuYB8dwFggwxxmtomTKV9SqRWXMW6Isx4vIqH1WexkIgeF7dit3wt5Ei3dSeWRTfC4j3UIhimON/NCAxGh976ZL+hZq9zrqUuUgAkV1DhjMmwJ9Lw+X/BCn2Cxq8Yq/mA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eMS5eotwngBHL7fEqID5ryJ8usRtfY8bV1eUOIdMxns=;
 b=LDIyKW+8GdPXMBtC646CRQuXMuYE4DryZTAX+k88dY2Ytgci6AgpwEhCqmIo7iht0VJlBS///1FObGzmftKeHJhEr2R44pUZ65SK+aDQmqAjjpEh0adbyUlTSgKGf90c4bJHnmNDba3eUy0eiWUAGy9/Jml0m2M5FG+HROyF4ycUNzmAZuzpT8gYDljfJf6CWGRV3ph2aeqaRzX8E9HtYy63N334HK45kmf4V4E/iQYIqltMhXgfgl9Go2zo5WgZYJXL7KfICes0gaAZ0Ls1UiFCXN5X7cxI5BRsuOEjfGZ/bdufqIPCUXK0PNwCCGRg20n7KYUUaVdn807b763YjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=psu.edu; dmarc=pass action=none header.from=psu.edu; dkim=pass
 header.d=psu.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=psu.edu; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eMS5eotwngBHL7fEqID5ryJ8usRtfY8bV1eUOIdMxns=;
 b=o2y4afhat3s3So2RLPOaf1XAChthIDWcOwqfQiatLpSAkPMWBeZSTHyXX9abGDyvgMH0fYGGZnOQu1RHLcdCebpIHJyYDIYnEe2B/YcXG4NSNbRmSRWYw9CxCjG/d2rf8I1j/U6OXxQvIvVQZzYDgUrxw2Wt381UsjOt90mm25RKBiq8pb8GsFInunB1xia2lfxFGJcgAV4yC6iO65S0imwGTvty/iThTOIu8xKt1kZ2pENscHaMS/K1CsN3Wz0UznjLk9GVDtgrgVohtS4fcH8r5rDdzXLg8wwEYvBIDfuXtaSaoTAoNXe8hcTEG5RU/g99ly0C6rEF7qgFsC0m8w==
Received: from SA0PR02MB7276.namprd02.prod.outlook.com (2603:10b6:806:e6::17)
 by IA0PR02MB9265.namprd02.prod.outlook.com (2603:10b6:208:436::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.7; Sun, 11 Jan
 2026 23:00:45 +0000
Received: from SA0PR02MB7276.namprd02.prod.outlook.com
 ([fe80::e6ab:3830:2755:fa66]) by SA0PR02MB7276.namprd02.prod.outlook.com
 ([fe80::e6ab:3830:2755:fa66%7]) with mapi id 15.20.9499.005; Sun, 11 Jan 2026
 23:00:43 +0000
From: "Bai, Shuangpeng" <SJB7183@PSU.EDU>
To: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
CC: "jirislaby@kernel.org" <jirislaby@kernel.org>
Subject: [caif_serial] Question: ldisc_close() drops tty ref but keeps
 ser->tty published
Thread-Topic: [caif_serial] Question: ldisc_close() drops tty ref but keeps
 ser->tty published
Thread-Index: AQHcg04dnA7obUThkkOxURH/NFfi5g==
Date: Sun, 11 Jan 2026 23:00:43 +0000
Message-ID: <3510D1C9-7B5B-4A44-ADD1-0C4CC48CF3C7@psu.edu>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=PSU.EDU;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA0PR02MB7276:EE_|IA0PR02MB9265:EE_
x-ms-office365-filtering-correlation-id: f92a4829-0df9-4bb3-d313-08de51653fd0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|10070799003|786006|376014|1800799024|38070700021;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?uFTVuZr774CE1PMW88ZfVdL2Qc6hhvwcc6TT4PoTAguN2rbL+fjCU0oRUvXe?=
 =?us-ascii?Q?rkgo37Sdm3PWKYXNcrVdvlzPPmTRLmYnAIcH3HaPy/v1BjUZmm2eNcMObdBs?=
 =?us-ascii?Q?bf3m8BWqxB5b5Q6sjAebQynRX6/jfj56l9FHXxf5RRNk9OBH/dPjzIXYXH6+?=
 =?us-ascii?Q?mFg0K1lTzXSSiRb1FE9tofzfXe5AtJd9QV8C3BXux6yFGxXMoFY892HtMEnd?=
 =?us-ascii?Q?G5m0RVwL3dLPoP0gQAPAQn/Km1yivsr4nfdvlJD+cTbCP1ObalfrSnTabZKS?=
 =?us-ascii?Q?Kokra/HXZ/BoXNK6ew2pF6b31IvoakNT/4dmm2eHRV+J3S7VFi/ISSXti8Gv?=
 =?us-ascii?Q?17ffX1YdKGI/WOyibXyijM5r5vUqB4zCH1UR3xLqrZh5yKhs60Nor8BxuNI/?=
 =?us-ascii?Q?nthM//g4oPbak+uB41H5GJ3PE7ym7agSxorlDA5uAuQEVklu3bvmNbCEyVtn?=
 =?us-ascii?Q?sKSlqlTUWbHxNmXBNmuT2cxZhM2ZxA0m8UTSuUW3AV8KkAW7WbfGrOtpjkIM?=
 =?us-ascii?Q?nmjnNFDoiiSbADmOAGg2M3DeQfEqv5sVQGCyg1HmlyHcBaHs08WwTvHtoKGE?=
 =?us-ascii?Q?sc9O8e4a20hWqevTmgHRVz7+amL5AAuUB0WPxp6gLFe8og+u1ZCYpoOeRHZ4?=
 =?us-ascii?Q?fnizzG3nWpvCx/KTuHULIEOf/mf5t4X/hqVeqFaoKYIqZnrBeC0JEgmanJwj?=
 =?us-ascii?Q?YyxkuuNFPQjAk0oEHLdjetWrDWBskflMx7x0PdbKNBN68JPK3mOT1oBRiKw2?=
 =?us-ascii?Q?Me9GTwgyVyzYW5JhkX7FkkN/2rA0+hFC+ocfs6Zhzp29MaeZq4Qa3OuS6+lt?=
 =?us-ascii?Q?L8dubu4H7LS2eUqhEWKyxjaQFuqI/XcJHEmNZR5hBlgpSH39/cqbOCTOT1XH?=
 =?us-ascii?Q?YuJDev82f/0THNBl/EhgJ2ioVOziy41lFBAoyabLEFqW6+RjZEcZBRtVG9eW?=
 =?us-ascii?Q?hZdt9S9uTfLfwrbkblOyvjVhz6txawVpRNAcVPAHS8XYYAdPO0DXj4C5k96e?=
 =?us-ascii?Q?QdIhsxyooXhIeXRrge8tntUj9PSVxO//Luixv4XLMhFoMIBw8mfHSKsEPbpw?=
 =?us-ascii?Q?TWeVNkrZkhPySATjBeFYKAbxNwQyI0ZQlLnf86YVQnU8m2iaap7+wss4Lfws?=
 =?us-ascii?Q?byLV0vyvQA4+C6zcS1fLMwqVYucz9kFdBYkuFgtbGlFCKP3p1gK29ookSHBw?=
 =?us-ascii?Q?8iVrD42akY8FNGu/Z9b22b6DFE9pRrWRH7VRLz0y9U5Tt8cKGUPtldexnaVP?=
 =?us-ascii?Q?UIsvYdM+SyvjTGOjMkTP4ceVw15Txgkq4LOLTk78DcvTfinJDMiw0BlTHduI?=
 =?us-ascii?Q?DQoZ92qsf4yQ/E6uFyOvLbM1kc2ZCmgI1fPBy83VzpVmWfkMc2pu+NkMk75g?=
 =?us-ascii?Q?uQLTDXhHjZxhOfzbk/IbMVnZQfug4szxY76lC1ht/09isLRaeGGK+uyW7PfZ?=
 =?us-ascii?Q?V7C235IpNsftkCDVZs33zCKnjuIhDolyBLY/QpkTowjhw2tqGzX/p/eXKkJN?=
 =?us-ascii?Q?Ha7Qp5mYHRWDMflpl2sC+HMXyBCN6ieVQLu7?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR02MB7276.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(10070799003)(786006)(376014)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?Bp2bUN9FZmkIxF2l4KjHNku++8kL8Bx7sWchCQtxcFEpEvald5kvqB/3DpBI?=
 =?us-ascii?Q?KtLK6ZSQ2iLfELFMH2J4o9D6pSeOyYAPa1QLJeLyfmbOHOCMNN2JQ3NT5DjA?=
 =?us-ascii?Q?Y9cxkihtygsODZ04dXFyjrZDFHkg/Z8yhAzBsGBDskTIQ5INzyAAG0Y8/gVO?=
 =?us-ascii?Q?Mr43fPlwcD/N3A2agHex8atNUyCw9RxGjj901P/iLoXaMrfXb92I1A5iWV0t?=
 =?us-ascii?Q?j3kO9172mzaMWKWCjjPHxiFMUU4wbNErw68WTdPG3XuGqvQvV0SQYsFV49RP?=
 =?us-ascii?Q?ZxuxyqRMNZF8f3qG++6DJVKdO+EXrmk7uGGAzjzs8xx+fuZxLXKPfUYJwGvk?=
 =?us-ascii?Q?rCj35kR7oZvG4IhqZlr0O2NhfMdUDkXGsixu0jKMRDOoLfeBQxWpkVADUohp?=
 =?us-ascii?Q?JDwFczziHnft4rUSb/Aj8Y11ikijyX+bAim4NjUxzm64IlpPO9FjZ/Mia7eN?=
 =?us-ascii?Q?at6P0Cpafg/5cUCMB7vIRUtHndyBzENzgEzIvWllLCMm8HeegrUqBO0wtRS5?=
 =?us-ascii?Q?nycfB3btOXX4N6sgwvgOmUa4CmgacwRuhYF/7P5IZL8qRVACcZU2sH3adOAA?=
 =?us-ascii?Q?l9VBn+yEbyzTUq1FYTvUb/S9zX4sHY50I8F+0P0Uhv9V/+my1+TTdRjSkeBQ?=
 =?us-ascii?Q?lnlf9hmHOflPQK4b5um5h3xiya8idQdWOAl31g2vt1ftEzxt20nG4yFs8krF?=
 =?us-ascii?Q?JWaCJYc8z7XsIgr49qn2j4CnJ5JQBCwi7L2bklOA/z8lIFaM3hDBD1f2Xrk7?=
 =?us-ascii?Q?zUvmZRUAGe1LcPpJaPfAFBmH5b6NmefPOJeg7fcWbP8jOymfbUD5LhQHrCcA?=
 =?us-ascii?Q?XeMeRdsLnUQu+LBn9sTGdMr7L0k40N5kzwNu3/+RCvwvugK4slR1vnaZcaPH?=
 =?us-ascii?Q?f6pk4Cc93HfrkBQ55cH7gT+tLQsvpgk2xEk3XP6lPJMoTy8L9BOadDUKvTzp?=
 =?us-ascii?Q?6HGvpm07sDSUjLxiTYHpZ+oJmchXlW0T2qHoq3HUu/QoHSf8Z6eqtk2LzZPn?=
 =?us-ascii?Q?0GYGKdmKP8eTf1BFKPykiLlqHLlc3VMtuKvFkXiS6Yb3TbXEWheX/9hktZqp?=
 =?us-ascii?Q?HfU1yhklzb7u8L03fz+n2xPPR27rC+OpaK22SjmHi3yUzWjQAt5R30a6wMDW?=
 =?us-ascii?Q?YGg2k1j1uebimCEVm4f9sRZ3yUzX1qLN121LU5d3dDoI6tELVt2ysoieyZ1P?=
 =?us-ascii?Q?U6w+WLAbjcUeGllbi3HEbmd/R2rwV7MISvpw6l6WOHIG8Vz2zLnIWTAMPVsn?=
 =?us-ascii?Q?Od63VYl/1MZD8eRf9rlRPVF4QigpdcVrI0l43n0MCzu6SkcslI6mpmC7IVZX?=
 =?us-ascii?Q?ljOedMic6OFja802SrtIBQX/LXQCBeYh8AczisV7LXJMlVnAIKa71sGFrd6t?=
 =?us-ascii?Q?CDDKgouMLVmB7/TSsKN7i3Ri+IZEvx8q1OyC/27WuWEigmj2+isacIgCdN+/?=
 =?us-ascii?Q?GXAulGJHzWM5Fg5yOAOfdZRzy9Yk59qW5AchT65+JI3tDWi9CrxOtrMMbkmb?=
 =?us-ascii?Q?x9HqN8ogq4oILTqaleeFm9CywnADI/8YDKmgEWFTrDdUPb/WSqOdWGuiLfka?=
 =?us-ascii?Q?TxGWw3OE6cQcsaJjN6Hj3hQw+cpP/Yhcf2kDKYyQr4QPWJYOEHBhz09wR29T?=
 =?us-ascii?Q?B7R7vyW7VMuPmJnOdQLoPN5/8WIfr8zMmpdiieN6bUlSXhRyNdc2CnV3crOt?=
 =?us-ascii?Q?Lugy05E0ba0jhOjgnsi5ZlE+545xK7PN1nlqaKba/MExK2dbaGCcHH9qRYlK?=
 =?us-ascii?Q?1YYYkUQmvExrP+nqgi4GFeACMlqLi+rb5+PSaeBcEBUor0sXkyzwJhjhJ/1/?=
x-ms-exchange-antispam-messagedata-1: DElrZUWd1XFk+w==
Content-Type: text/plain; charset="us-ascii"
Content-ID: <FD007401F94432469FB3842040D6A7A7@namprd02.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: psu.edu
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA0PR02MB7276.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f92a4829-0df9-4bb3-d313-08de51653fd0
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jan 2026 23:00:43.6933
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7cf48d45-3ddb-4389-a9c1-c115526eb52e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aQQ8jOEyQxxummv05yiBYiawXLT6ktDn4aJ4qnJj2UnRgR1nTpGGsPokW1oD1GXK
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR02MB9265

Hi netdev/TTY maintainers,

I am looking at drivers/net/caif/caif_serial.c: ldisc_close():

static void ldisc_close(struct tty_struct *tty)
{
    struct ser_device *ser =3D tty->disc_data;
    tty_kref_put(ser->tty);

    spin_lock(&ser_lock);
    list_move(&ser->node, &ser_release_list);
    spin_unlock(&ser_lock);
    schedule_work(&ser_release_work);
}

In ldisc_open(), ser->tty is set by taking a reference:

    ser->tty =3D tty_kref_get(tty);

In ldisc_close(), tty_kref_put(ser->tty) drops the tty reference while
ser->tty remains published. This can create a window where other CPUs may
still observe a non-NULL ser->tty pointer after the reference has been
dropped, which could be unsafe under concurrency if any reader
dereferences ser->tty without first taking its own reference.

In addition, the ser object itself is released asynchronously via
ser_release_work, so the struct (and thus ser->tty) can remain accessible
for a relatively long time after ldisc_close(). This extends the lifetime
of the published stale pointer and widens the potential race window.
Would it make sense to clear/unpublish ser->tty in ldisc_close(), so that
other CPUs will not observe a non-NULL ser->tty after the reference has
been dropped?

Thanks,
Shuangpeng Bai

