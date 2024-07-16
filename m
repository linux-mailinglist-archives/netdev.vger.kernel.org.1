Return-Path: <netdev+bounces-111758-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D077193277B
	for <lists+netdev@lfdr.de>; Tue, 16 Jul 2024 15:29:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 596E91F2335E
	for <lists+netdev@lfdr.de>; Tue, 16 Jul 2024 13:29:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5839D19AD78;
	Tue, 16 Jul 2024 13:29:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=endava.com header.i=@endava.com header.b="V111EsEH"
X-Original-To: netdev@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2107.outbound.protection.outlook.com [40.107.20.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24C1719AD6A;
	Tue, 16 Jul 2024 13:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.107
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721136555; cv=fail; b=jMBdUDmqoG189jJnlcMNu2NwZ97ItwpAchjmhcp/mUcJ9iifi92SvhuwOfm04R+KuJIEXMD0f+RDqbSZOztPp9Y9cDIn6DUrLyv7kyRDtsEJ7FtDEt3XlGLscc1FEOCgVHaPi5VRRSqva80Rk9AyD0CjG7GarFyTwubqoTxV6xE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721136555; c=relaxed/simple;
	bh=Bhw6DPgPgIQo7XhDxRZDIOyPETT9BsXDd6FjxRoIjd4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=bTRVwO7Homgt8K2kTGBrK0dartUWtOcZJcSrfAQ0WLEA1xfWjNxYUyktg6PhiPH4+ISgQnSbo2tGSRaIkRaoEdEomCp7XN8jFRKSjZTdE2ty3eW2jBBISfkna67ldmirH3VSdCPxSM+iItYYqDy4cfVa9979cbDehNRLLYMqgrk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=endava.com; spf=pass smtp.mailfrom=endava.com; dkim=pass (2048-bit key) header.d=endava.com header.i=@endava.com header.b=V111EsEH; arc=fail smtp.client-ip=40.107.20.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=endava.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=endava.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tSIyXA0xs/5p4nb+dNQyZQlRftbL0ufax2eyiqUFzFwfN05LQFHXUZMBhJUxMYYz7wFh6K2P5reqB0S7O2zCXqGEplTbLTJYYxdpI+j+HopULoVAXFrGMvDwlrCzvxKy+ahi10SWYOovBJ0FGbeUDWOTSasuLM50kJ9xf6Kr8T7z94kqFpxqX5hjnbexdzvfC8SQy6uCs2Cxukw0x53mxRCE+rNi/FAkLBqBdrDiqEiF2h+iHj/OCsS6paMYUBQMFepjxcWfK4mjw6b+Rzmd/Rx2XGsf4IEezEL3YKJ2pdwRSX7q69RuKvKE2Er2oKipVw1gAigWNDkyDZ34WtWRKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Bhw6DPgPgIQo7XhDxRZDIOyPETT9BsXDd6FjxRoIjd4=;
 b=d8xkdaFhqpGPDBWSEda0jgLDFvQm+1E055bkVT4evBRiYVrnxs3s10JdBHYHHF2DFiOahJUmK/DR/hsP6a1sUzmyDCCXppdmwNfaUag4FjA/eRH0SmSIiZr7f/8korSi7NqrVwZK+/dPdH8FAAGwW/f4XgbyoN71cZGi3JsCqMbgvyliAuD+eDg7TYzDHSc8f6kKsYMOfnA50hqpPRAz8x5Oan84tpVeMLTeMNwwdXgtr2t4+jiKpE2SRbRoJycE967MHOuqsCUpIcPytzxXIWz7oaNq/Y1e1yUutNzaGNOjH6Oy5mgV5YkODp0vyBJ5I/gz+azs4o+nsa0p2D8WxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=endava.com; dmarc=pass action=none header.from=endava.com;
 dkim=pass header.d=endava.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=endava.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bhw6DPgPgIQo7XhDxRZDIOyPETT9BsXDd6FjxRoIjd4=;
 b=V111EsEH8kDtjWr7jw+6ot6y3O0Mf5xwLfhcVfNAm1dwVPXFDKB+QJlVhXm5h47PNixCmY3LirForm9NU8eL7bpEY63dQjjJVvBCbK4k+vsry2am8vdLFsgiapLJ2yBxfaObyhRZVj7dzaxDtEsdXeL4648gxl7H9JA+HnFhoqWjcnMQfBHAStxt4Pk0C1eXc9zr2NX7uEKGtQt47r3+gKlh0yOrlTYG9J68ji3NMOAdQOodUMEbzFM+8XyGM9dbhyxbGh8lTJy/wQR13UwJhDX3dtGNjFYu7la/FdHnukja4bFQ+OxdGYgwp0hcSqawsbcYE+OJm3EwhzkGesRHhg==
Received: from AS5PR06MB8752.eurprd06.prod.outlook.com (2603:10a6:20b:67d::20)
 by GV1PR06MB9140.eurprd06.prod.outlook.com (2603:10a6:150:1af::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.29; Tue, 16 Jul
 2024 13:29:08 +0000
Received: from AS5PR06MB8752.eurprd06.prod.outlook.com
 ([fe80::72f2:c654:1827:9c41]) by AS5PR06MB8752.eurprd06.prod.outlook.com
 ([fe80::72f2:c654:1827:9c41%3]) with mapi id 15.20.7784.013; Tue, 16 Jul 2024
 13:29:08 +0000
From: Tung Nguyen <tung.q.nguyen@endava.com>
To: Paolo Abeni <pabeni@redhat.com>, Shigeru Yoshida <syoshida@redhat.com>
CC: "jmaloy@redhat.com" <jmaloy@redhat.com>, "ying.xue@windriver.com"
	<ying.xue@windriver.com>, "davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>, "kuba@kernel.org"
	<kuba@kernel.org>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"tipc-discussion@lists.sourceforge.net"
	<tipc-discussion@lists.sourceforge.net>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH net] tipc: Return non-zero value from tipc_udp_addr2str()
 on error
Thread-Topic: [PATCH net] tipc: Return non-zero value from tipc_udp_addr2str()
 on error
Thread-Index:
 AQHa1yUvQPqLAGQ2A0GB9aoYG5W6f7H49WZwgAAEmICAAD0xAIAAA3+wgAAaDgCAAAO9YA==
Date: Tue, 16 Jul 2024 13:29:08 +0000
Message-ID:
 <AS5PR06MB8752EA2E98654061F6A24073DBA22@AS5PR06MB8752.eurprd06.prod.outlook.com>
References: <20240716020905.291388-1-syoshida@redhat.com>
 <AS5PR06MB8752BF82AFB1C174C074547DDBA22@AS5PR06MB8752.eurprd06.prod.outlook.com>
 <20240716.164535.1952205982608398288.syoshida@redhat.com>
 <596fd758-11ad-46c0-b6f1-2c04aeba5e06@redhat.com>
 <AS5PR06MB875264DC53F4C10ACA87D227DBA22@AS5PR06MB8752.eurprd06.prod.outlook.com>
 <c87f411c-ad0e-4c14-b437-8191db438531@redhat.com>
In-Reply-To: <c87f411c-ad0e-4c14-b437-8191db438531@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=endava.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS5PR06MB8752:EE_|GV1PR06MB9140:EE_
x-ms-office365-filtering-correlation-id: d17d0f4e-cd9d-4949-15b0-08dca59b459f
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?cUFCNVk0T0xMcjFHaGt2dEk1Vm1rdmxYanp2Tkhya09weGVxTitZaWxVcmRX?=
 =?utf-8?B?U21hVE84OWVOWGFEcHhqbHBJN2cvUnhuSU4zb1hkVWMrZkFrWVRTUGs3LzU5?=
 =?utf-8?B?Mnp3ODlnUHNnQzYrL2xMMjZ3eXdENlJFUGx1TGZIZjE1NzhIL0MvOGZvZE16?=
 =?utf-8?B?NHdBVFF3YkQvTjhZYWpNY25ML2N0TGRxaUR3Y1M0cVIrbnZmbE9aYWtZUUZH?=
 =?utf-8?B?dnc4UkZCM01xM3ZueDRhM09JWmQ4ZFF1bjBHY04yZXVaNmorV3FTcGhFM3oz?=
 =?utf-8?B?eUkybnBXekU4T2VUUURFb0xNQUUyak5DcFhmQ3dteCsxR3JaMUdOV2NZZFRN?=
 =?utf-8?B?T1dTSWdmS3lqMW1FUXNDNXpKcWJ4QlpSK0ZzTmlGNnlGcEZ6QkQwZHRneURF?=
 =?utf-8?B?NlhLMXJicDRkVUhRM1NuZm9tTytHcnNTQ0ljU0g5QStwVUY5V1BBb2JOdG5j?=
 =?utf-8?B?S0QzbkxDQmtYSmhOZmc5N2JUSVJhdCtMOWQ3Z0ZlZVFLMlZ6WG9MNjVpMnU0?=
 =?utf-8?B?MkVhSmF5QkNnaXdaM05tL1lidHlWSSswSTdsMEorMHFnLzcvakJPSDZnbjdH?=
 =?utf-8?B?SlNyTVp6UjlIK3RIZE9nUzZiRnBtQWpPOTlYUUllSzFRZTl5Y3k4VEwwQlMw?=
 =?utf-8?B?S0wzekpRb2NxS1pqeXN2V1dlS2lYU0FhSUFWaG9kNmE2RS9ZWmk4YlcrcDRY?=
 =?utf-8?B?S3hqU2VaTmF5djBSV0NnTkFML3FsaXJrRWtiTWJaMU8wMnA0cnNCa1UwVkpK?=
 =?utf-8?B?VzNHTGhTRUlVR2krUE5ia1F4SS94RlEvbFV4YUxqMXBkZGd3aUtCTEdCdVBt?=
 =?utf-8?B?MTRWU0l4RmZaNVhMdEVFU2FNSUoweGdEenlsenVXaHcrdHYxRnA3TXQzZFpw?=
 =?utf-8?B?U2Y1RWJITFBJTkl4SlpiVzJaZ3ZHR0poVDV5VUNPWkFvQ3VzR0Rodk5id0U1?=
 =?utf-8?B?ZXF4RDhQTFN1Q2M1Ti85cUlTSnJlTzdoS3I2RWlmcE0wVXIxSUFheHhXZzlq?=
 =?utf-8?B?NXZoUzMvUWZaVVlOWkVmTkhjeFk2ZzhVZ2RCUHRJd1Z3aW91a2NLNXlMZUVh?=
 =?utf-8?B?L2RCYk52a3F3VWxZcGtqcXdkcE5wSzRzbnBxYWZISkZzaGM3b1lWTVlVdXRS?=
 =?utf-8?B?dGhoQ09FR2dBU3JuOWRuR0lPb1FwSzYwTEtjcXFtR3I2YUNqbFNPVXl5Zjcx?=
 =?utf-8?B?ZnlnTTdVTXdwR1djOW9pZXFYK2g5dCtndXIzcm1pTXN4SSsxRGg1c1UxelNT?=
 =?utf-8?B?Zjc1QzY2aWsvOWo4ZUdFUUNZNlV4ZENxZ3B6ekx6Z3lsRTdSdWxGMjRhTHdP?=
 =?utf-8?B?bzVKOFRTdlY2MVJxaitzOXBqYldXL1FUbzMxdkxObDZWb3BBaENsdHB4STI3?=
 =?utf-8?B?K2pFQ1FKVVVLellocEZBdkNGY3RWWXdsdWZqNS9IbEIwL3dnSnh1UDl0VThG?=
 =?utf-8?B?NnFsblE1ZWdKOG9ZU1FwU3RWUDNHV0cvZ2hmbUhWajdNR3NkRkYvWnMvd2l2?=
 =?utf-8?B?cDh0UHZNSXAvUUVtV3hIdGVnN2JvM0V1U1FQMkVNQzc0SjRMamhTMXp6cC9T?=
 =?utf-8?B?UndvdWd4WlF5ZWtITmt0WU5CVmpUTFJUY0hMYkZJUWZLVFB0eXI1eGJXNm5u?=
 =?utf-8?B?bTdENktpZHl3SXc5anRwdlgrZVBkSDduRE8vdGYwVHNqSEdXK09FWHc0eHZ4?=
 =?utf-8?B?Zzk4Y0VwamZkRnVPNlZJTEs5MTVZckZpWCt0MDNhSmI5OUtFWjR0dzFUblNZ?=
 =?utf-8?B?WCs4QUxwbCtjcGxxaHZjdzE4bERjWTJSb3hvckVnQjZsOWoyRXJBZHBaWlhu?=
 =?utf-8?B?MEMxM240T0V6MzRQczlraFoyTEhyN3pNYzJBNUVpSGFSYXdCVTZKZ09EYmZL?=
 =?utf-8?B?OHJ1WlkrQWJFTUxDM2x0TmMzUEpjTGJNR0FUeEpTZVZEV3c9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS5PR06MB8752.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?TlpuUlMvVWtvcmlTSUhkUE1tQ0xUTDVUUmc5T1NSQVVjZVo2MjFkQTEwUzdr?=
 =?utf-8?B?QkZMV2tWRGVIYzZwZFBhckRhaDAwVzhxc2MwZnAxTHMxemRGN0VWaDd5QjU4?=
 =?utf-8?B?ZnVqSXVCMG8vc1RxNlIvZXkrTWdIbFByazhMNVUvKzlycExIYXF4bG12MCtO?=
 =?utf-8?B?NDlQT01rSzIwTEtIM09FYy83NVZGSURCemxQVVdPQUMxUS8rUUtVWWs4anRh?=
 =?utf-8?B?SGJ5SHQ2N1VSdjFOZnZpdjk1dDdBRzM4Mm1IclhsRkJYRmZXL2xxYTRIVW5Y?=
 =?utf-8?B?TEt4Zjg1VGtkNzloQ0lxQ1dsQk9HSC9QQTJLMHR2OHMzTnVOUWhqa2Uwcngr?=
 =?utf-8?B?QU02YndzSVNBNXJDUDZ0dElaTkdFTk5TRnJkeFgyMzd3ZlAwWUdsODBCVHRw?=
 =?utf-8?B?aGVLaS9WQ2x4dWpFc0g5clN0RHUxcmYwenNpOWhocDkrSG5MazE2Qm12akY4?=
 =?utf-8?B?OFhlMVBnb2NnVkFWRWtRY1plZ2hkajdLNGRNWUgvS0dWUTVrR2hEazJPYWhx?=
 =?utf-8?B?OXMydFpJcGdJWFN0eE43Y3RXZHk5UUlpT1N1VU96YXV6cnVrTmVSeXVMR01Z?=
 =?utf-8?B?SExUQmdtc1VrSWRITjNITFd0aGhMY2RMVzVSeW9zc2FCT0dGOWwzY2UxWlMy?=
 =?utf-8?B?VE16Mm9MRngyVGFZekdyWGJ1a2tuRk9UU3ZxMjlTSyszNzlSM3BsMStRb0ZG?=
 =?utf-8?B?MGRwSmZWeUh5M0RLL2ZRTnFpbzA0M0lnTkZrY084ZWo5dW5LdXJ6eXIzOFIz?=
 =?utf-8?B?cS9CcXhWSXQwT0NMOXlzdDJOb0ZuRHdudkZjRUx0eTFZYjhYSGIyL25pbnNi?=
 =?utf-8?B?ZlBhTllBYUFOaWp6YVhyNVM4Sm1MNCtKWGs5TGlsUTR1M3Npdm9LbllhQTgx?=
 =?utf-8?B?dlhwdDRwMWVZY1JzcTI4M2paaDliMmhDbmRla1B0MUliN0tmWHRUYnNSb0FR?=
 =?utf-8?B?KzBnVnB0UDJGa1RvMy9oSTR6Zmk5NWFPTzdKSTdrSnNMWXZwSmVlT3NnQVdO?=
 =?utf-8?B?a1hBTy9IMGE1T3htUHoxUDhsWFFCQk9IOXYvYU4wQXo3d3Y0d08zUDdjQ2pU?=
 =?utf-8?B?OHQrSzd4N2xySmJTLzU5d2w0YWNjSnpFaDY0NVd3bGxTYm5LbXI0WDNIMXBR?=
 =?utf-8?B?VUpPb0hzLy9QbVBzVzZwVHhYSGlhOEhSTVBsSVJmclVCbXpKM2FtQ2dISFNB?=
 =?utf-8?B?THpoOUNVK2tjenB5TExOaFIxa1EydEI3QkRlNVZpWWF5WExwdFdDYWYwYUFJ?=
 =?utf-8?B?ajJHT3VDVk1DRE5rMnRGSnpITU1yRWFLU3h3UkpGSEVTZG4vd3o4eEhnQnNK?=
 =?utf-8?B?NnJldG9KTkJCbmExVXdvcU5LZHN4czV1cWJvZXBaN0RyOC9zNVJkR1VKOGVj?=
 =?utf-8?B?eExDcm5UN1hCaVBCK3drVmlTd1lGeGNVRTVqdEplZEpKaEhyc2lTNW9NQnYy?=
 =?utf-8?B?U21ocXVYTFlFYmNEVUwzdDFRMVB1Y0owUFRhNE9XbzVJSzFHZTlqZ0loR0da?=
 =?utf-8?B?VVhvbCsvK1VLdkd3RmxFT0pwZUdNaXAyTnB0cnFkZEwwbnphSlRIbGhlRWFZ?=
 =?utf-8?B?NWZIcXNnd09YeUZZeDZZSHFZdXFVdDdLMDNsWXFHSm5CTnpiUHlSSERMV0RK?=
 =?utf-8?B?OUdWMFhWOTBXWWMybEwvR3F4VVdyNkp0Tm45TlZBY1VaU3lPU0RBcjZCWWhU?=
 =?utf-8?B?VkZObEZ2ZUN4bjlBaEQ1K0QyQ1YyMit0L2psNVVZeW9yUGxlNFdnM3BObit6?=
 =?utf-8?B?ZGt1ZXR1bkdGMjFFTTMyMjhSNTQ0c0FCRG1QTVJSUXV5dTYwRlBNVys2M1hB?=
 =?utf-8?B?UDdHSFpXOWhmRm40ZmtBRW5iR2VxNDVSTTR2cVBjZXhZMHN1bm5RVks5N0V3?=
 =?utf-8?B?OFZDR0g3bHlUdTRad040ZWswOHZtOUZtK05iUC9oMkFJS1FnaCtYNDZ5ZEVn?=
 =?utf-8?B?SnR3K2xMZGUxYWRPdEZSTlo1aXpNS2RnOUQzNE5pSTQvRytXSmFHNDNRTnRI?=
 =?utf-8?B?ZVJnMkQza2hYdm1maUxXOHVtbi94aVdGS0xHdUsxblhkK0RJRy9yUGkybHo1?=
 =?utf-8?B?QUtDQ3ArOXAvZVN6NFNzVWc3KzlzYVpuOG5EdzVWWjVuVUdjQUlqRXlnQ3R3?=
 =?utf-8?Q?fU27WQoz+fp5YvtPuOFM12ctE?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: endava.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS5PR06MB8752.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d17d0f4e-cd9d-4949-15b0-08dca59b459f
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jul 2024 13:29:08.6306
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0b3fc178-b730-4e8b-9843-e81259237b77
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: A/afcV28DlhoZGLAStCBjKfrzw0/PnfoaH4x0gWzawSqsVNf3petmRrEb66IbqmuIfz70oPlHplIbid1jSTM4BZl9ZpNnQ9RU/q3IspUfkk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR06MB9140

PklmIG9ubHkgdGhpcyBvbmUgcmV0dXJucyBhIG5lZ2F0aXZlIGVycm9yLCBtb2RpZmljYXRpb24g
dG8gdGhlIGZ1bmN0aW9uIHBvaW50ZXIgY2FsbHNpdGUgd2lsbCBiZWNvbWUgcHJvbmUgdG8gZXJy
b3JzIChhbmQgc3RhYmxlIGJhY2twb3J0cw0KPm1vcmUNCj5mcmFnaWxlcykNCj4NCkkgcmVhbGx5
IGRvIG5vdCBzZWUgYW55IGlzc3VlIHdpdGggcmV0dXJuaW5nIGEgbmVnYXRpdmUgZXJyb3Igd2hp
Y2ggaXMgdGhlIGNvcnJlY3QgdGhpbmcgdG8gZG8uIFRoZSBmdW5jdGlvbiBwb2ludGVyIGNhbGwg
cmV0dXJucyAwIG9uIHN1Y2Nlc3MsIG5vbi16ZXJvIG9uIGVycm9yIGFzIGV4cGVjdGVkLg0KSSBk
byBub3Qgc2VlICJwcm9uZS10by1lcnJvciIgd2hlbiBpdCBjb21lcyB0byBiYWNrcG9ydC4NCkFz
IHNhaWQsIHByb2JsZW0gaXMgcmV0dXJuaW5nIDEgaW4gaW5maW5pYmFuZCBhbmQgZXRoZXJuZXQg
bWVkaWEgdGhhdCBzaG91bGQgYmUgY29ycmVjdGVkLg0KDQpUaGUgaW5mb3JtYXRpb24gaW4gdGhp
cyBlbWFpbCBpcyBjb25maWRlbnRpYWwgYW5kIG1heSBiZSBsZWdhbGx5IHByaXZpbGVnZWQuIEl0
IGlzIGludGVuZGVkIHNvbGVseSBmb3IgdGhlIGFkZHJlc3NlZS4gQW55IG9waW5pb25zIGV4cHJl
c3NlZCBhcmUgbWluZSBhbmQgZG8gbm90IG5lY2Vzc2FyaWx5IHJlcHJlc2VudCB0aGUgb3Bpbmlv
bnMgb2YgdGhlIENvbXBhbnkuIEVtYWlscyBhcmUgc3VzY2VwdGlibGUgdG8gaW50ZXJmZXJlbmNl
LiBJZiB5b3UgYXJlIG5vdCB0aGUgaW50ZW5kZWQgcmVjaXBpZW50LCBhbnkgZGlzY2xvc3VyZSwg
Y29weWluZywgZGlzdHJpYnV0aW9uIG9yIGFueSBhY3Rpb24gdGFrZW4gb3Igb21pdHRlZCB0byBi
ZSB0YWtlbiBpbiByZWxpYW5jZSBvbiBpdCwgaXMgc3RyaWN0bHkgcHJvaGliaXRlZCBhbmQgbWF5
IGJlIHVubGF3ZnVsLiBJZiB5b3UgaGF2ZSByZWNlaXZlZCB0aGlzIG1lc3NhZ2UgaW4gZXJyb3Is
IGRvIG5vdCBvcGVuIGFueSBhdHRhY2htZW50cyBidXQgcGxlYXNlIG5vdGlmeSB0aGUgRW5kYXZh
IFNlcnZpY2UgRGVzayBvbiAoKzQ0ICgwKTg3MCA0MjMgMDE4NyksIGFuZCBkZWxldGUgdGhpcyBt
ZXNzYWdlIGZyb20geW91ciBzeXN0ZW0uIFRoZSBzZW5kZXIgYWNjZXB0cyBubyByZXNwb25zaWJp
bGl0eSBmb3IgaW5mb3JtYXRpb24sIGVycm9ycyBvciBvbWlzc2lvbnMgaW4gdGhpcyBlbWFpbCwg
b3IgZm9yIGl0cyB1c2Ugb3IgbWlzdXNlLCBvciBmb3IgYW55IGFjdCBjb21taXR0ZWQgb3Igb21p
dHRlZCBpbiBjb25uZWN0aW9uIHdpdGggdGhpcyBjb21tdW5pY2F0aW9uLiBJZiBpbiBkb3VidCwg
cGxlYXNlIHZlcmlmeSB0aGUgYXV0aGVudGljaXR5IG9mIHRoZSBjb250ZW50cyB3aXRoIHRoZSBz
ZW5kZXIuIFBsZWFzZSByZWx5IG9uIHlvdXIgb3duIHZpcnVzIGNoZWNrZXJzIGFzIG5vIHJlc3Bv
bnNpYmlsaXR5IGlzIHRha2VuIGJ5IHRoZSBzZW5kZXIgZm9yIGFueSBkYW1hZ2UgcmlzaW5nIG91
dCBvZiBhbnkgYnVnIG9yIHZpcnVzIGluZmVjdGlvbi4NCg0KRW5kYXZhIHBsYyBpcyBhIGNvbXBh
bnkgcmVnaXN0ZXJlZCBpbiBFbmdsYW5kIHVuZGVyIGNvbXBhbnkgbnVtYmVyIDU3MjI2Njkgd2hv
c2UgcmVnaXN0ZXJlZCBvZmZpY2UgaXMgYXQgMTI1IE9sZCBCcm9hZCBTdHJlZXQsIExvbmRvbiwg
RUMyTiAxQVIsIFVuaXRlZCBLaW5nZG9tLiBFbmRhdmEgcGxjIGlzIHRoZSBFbmRhdmEgZ3JvdXAg
aG9sZGluZyBjb21wYW55IGFuZCBkb2VzIG5vdCBwcm92aWRlIGFueSBzZXJ2aWNlcyB0byBjbGll
bnRzLiBFYWNoIG9mIEVuZGF2YSBwbGMgYW5kIGl0cyBzdWJzaWRpYXJpZXMgaXMgYSBzZXBhcmF0
ZSBsZWdhbCBlbnRpdHkgYW5kIGhhcyBubyBsaWFiaWxpdHkgZm9yIGFub3RoZXIgc3VjaCBlbnRp
dHkncyBhY3RzIG9yIG9taXNzaW9ucy4NCg==

