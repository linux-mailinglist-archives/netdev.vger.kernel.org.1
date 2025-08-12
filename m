Return-Path: <netdev+bounces-212874-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A549B22597
	for <lists+netdev@lfdr.de>; Tue, 12 Aug 2025 13:15:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 64D383B78E6
	for <lists+netdev@lfdr.de>; Tue, 12 Aug 2025 11:11:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A2FF2EBB9B;
	Tue, 12 Aug 2025 11:11:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=adtran.com header.i=@adtran.com header.b="Dg7FuRMb"
X-Original-To: netdev@vger.kernel.org
Received: from FR5P281CU006.outbound.protection.outlook.com (mail-germanywestcentralazon11022082.outbound.protection.outlook.com [40.107.149.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CD0E2EA748;
	Tue, 12 Aug 2025 11:11:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.149.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754997080; cv=fail; b=i1qG+1+RZ9e8ErYmAUUELB91BZW0luavLuOz2YMYaxQVVQS8xv2DMOIr9XQ71MXj61SCCDuIv7GsM+vFVquAHWNE6xoZudYgh5K2Xmli9Ft4eVD1JRnFUm70HSzx9egiyXHVINJxeJD7eVsYLOPdkClWyXdurTdjsEs1FSjMaF4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754997080; c=relaxed/simple;
	bh=vl1stIvmmSzN5y3byqgWr4aPodvU84pg5bGnHVbtsng=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=rWmE/epMYzzxQqJHRrLG9pGa/OxXYi8VPSM918dKsqmHQogKpGrrsoSnSS/lHzyGUR9e4KmRHWdAgZvF4BMm+pgeN/hu0M9jEYbdGmemwm/K/YsyOIlLuakeSUbV7kfBVse4hjGgkf0GCSxxpPj2QyxLd8b1oB0w8EL59YwSS4E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=adtran.com; spf=pass smtp.mailfrom=adtran.com; dkim=pass (1024-bit key) header.d=adtran.com header.i=@adtran.com header.b=Dg7FuRMb; arc=fail smtp.client-ip=40.107.149.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=adtran.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=adtran.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E/ZkjeDsp69nKXlrHL60Z03j1qqqgfomKRMlzm8hzZUpp3t+UJOY1L897dXH3B/t32XzN2kKpzkgGJYmrXG1gUlOEBu7ci0VNUqC/GAgXL6DtQ2x0wvXR4mCuz/xFjyoRvGtnxo4BLoqsNzQgAZQ6W501uEe6A9tBqN5r+G39foku6G/N4eL29OYa8mF4e9G3Ao8kiybihM74sAcftSdT2E4iRQ2GisFfJYMIPgGszkWwLyWl7v2vNcp9nVAAM5kInciOnwhoW/8iEZrBsu2jcMbbUq7PZOtNdS5FLaWc/GacggCHnn8nb/qoaqz6y9zEVsYiESaF33AgcnWvIxlPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vl1stIvmmSzN5y3byqgWr4aPodvU84pg5bGnHVbtsng=;
 b=nkw3S9+hKLVEPhvnimGEAcjvEcQ3PcRiEbAjLzfukM9JN4yawnH/1rENF/KV4zEvN18ltCMMHiFVG9JDWoVryju9OEOC/9Tvo/GN2VIFXD2LjlIsoO2pNoASF9aw81xLwtuPmGShjpg8B4VN6alNK1vyWm+gvq38Ir2UWdoXPNLKr5sV0YE9NmC58Ff4OmDoWrDUeoa6MO/ayWN5GS0UAl4UQ2Hg5uHv37bc2dj+dGPkuyBUtBnei78E5UHLUuaGim/ohzlZDTD6pZDmR5Gbia5HlZ/2Sx+CvnDIXozKTYWMnx4SZuZFE4UTULzY+kD6Xp1JwKBD/LUEAFKNXInvNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=adtran.com; dmarc=pass action=none header.from=adtran.com;
 dkim=pass header.d=adtran.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=adtran.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vl1stIvmmSzN5y3byqgWr4aPodvU84pg5bGnHVbtsng=;
 b=Dg7FuRMbkat9O8DoRm7U37UP/NQ2Uw6J780MgSfVG9rma8QwmbccsbNOK+T5HblHiYXS4OCl/C6f0k7XKBntAO5Zlk0rNR1dqSmi0gDaaHU0r9Z01OKcxxHhqjzCF0W/fMGNqScOILHqYh+EloI4Lvr+6GQCP7cBlo43k+262Y4=
Received: from FR3PPF3200C8D6F.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d18:2::126)
 by FR1PPF75A2935B5.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d18::f5d) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.22; Tue, 12 Aug
 2025 11:11:10 +0000
Received: from FR3PPF3200C8D6F.DEUP281.PROD.OUTLOOK.COM
 ([fe80::92f0:48d2:2be9:13c6]) by FR3PPF3200C8D6F.DEUP281.PROD.OUTLOOK.COM
 ([fe80::92f0:48d2:2be9:13c6%2]) with mapi id 15.20.9009.021; Tue, 12 Aug 2025
 11:11:10 +0000
From: Piotr Kubik <piotr.kubik@adtran.com>
To: Oleksij Rempel <o.rempel@pengutronix.de>, Kory Maincent
	<kory.maincent@bootlin.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH net-next v6 0/2] Add Si3474 PSE controller driver
Thread-Topic: [PATCH net-next v6 0/2] Add Si3474 PSE controller driver
Thread-Index: AQHcC3nOrHbQNyrG50O7qUQvSQ2T/A==
Date: Tue, 12 Aug 2025 11:11:10 +0000
Message-ID: <2378ee79-db60-45fb-9077-f21e8f7571eb@adtran.com>
Accept-Language: pl-PL, en-US
Content-Language: pl-PL
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=adtran.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: FR3PPF3200C8D6F:EE_|FR1PPF75A2935B5:EE_
x-ms-office365-filtering-correlation-id: 147f0b16-37fa-47a9-e2b0-08ddd990f171
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|366016|7416014|38070700018|921020;
x-microsoft-antispam-message-info:
 =?utf-8?B?ZFNIMFBXWWNiUVBRcW1IM2VKOWRFNzNON1crVHpueERzU2VjbmZBSHU3REh0?=
 =?utf-8?B?Snl2eDVXRS9GN3JiTGpVMW5oS0dmMklYNmlGNW41N1lIaFh0VkhRcXNlUnVF?=
 =?utf-8?B?ZzJnMnBBeWdkaENJR25YRnBVVEZLRWZqeGxvK081eFdoRzkzdnVDSkx6RlpW?=
 =?utf-8?B?UVlSTTVjcFRLckdVaGNaZ1pGRnl0T2Y3cVJ4REtzbGpkRHpPV08zMWpvNmdl?=
 =?utf-8?B?N28rNm0vK3lURTI2cVkwWHFzUW96SUw3elBVMXNyQUhteFVmZGt5ekltR08r?=
 =?utf-8?B?UWNMWHN4UzYxTGVtekt0UVBwTnBVVCtEZWxWajRKbllxTkQvRmtZNEZKaExl?=
 =?utf-8?B?WDlybS81cG1obnlsOGhRVXFuQ1FxTjNtbWM4U0pjbys4YVhCU0JVK3loVzc3?=
 =?utf-8?B?NDJqeDViODBPaUNYZHNUSllxQmpZNDNMOXI2TE0wM2dXSnZyT3NkSExBOWRB?=
 =?utf-8?B?L0JmYm84WXNTbFBwcG9iUTNOUVRMUlcrSDdMMjVBbkV6eTZxb0ZURFJ6UDhy?=
 =?utf-8?B?SmRaUFFTa0ZFZnRXdUR1Zm93aTdhTzFyVVRERkplVnRhUVJKUVdTa0FLZXdJ?=
 =?utf-8?B?alBmZjMwYllIM3VsV1llTHpWVWFPbjhhbzlTVGtwNG5nTml4WFQ5ZFg4QXZl?=
 =?utf-8?B?MkkvYUtoMWdmN3k5QnM0R0ZFWlNNbEhIMm1aZ05XaG8yMjlENmVHQjFaZHc0?=
 =?utf-8?B?TU9ObVBTTzJvZE9zckl4emFxRmM2YmRLUGJQNlBpbEhtbTlBdEFZL0RKejJu?=
 =?utf-8?B?MHIrakR0cCt2OEttdVFjLytSUm9xQzFBeGsxUlVycElPZkYwRnVnTFZHanVZ?=
 =?utf-8?B?L2poYS9KbkNIOE83WU92QTR5NGliSHdKWnhaNmtPVEFGQ3dSS1dQRjkxc0Nz?=
 =?utf-8?B?YXplTkhac0cwZEJDWjFQbG5iQnZlQTRqSGtBVmFzL1Q4eWQvMFMvN1ExSm4v?=
 =?utf-8?B?VzJ1aUVpV0FmQmdnU2hvSittYW95U1RWQytxVGl5YkVCNytHcnMzSTdQTkEw?=
 =?utf-8?B?QVhPQ2EwTk9IMlpDdW9zQ2QzTU0raWtDOVgwQWl4NW4wckhMVTFxSWhHa2lK?=
 =?utf-8?B?MzNyZXliMjNmbEg4VWxvSDBGZXdjMlNUbTdBOHl3MG9HSDhJczlsUExUVGs5?=
 =?utf-8?B?blJmdWN5UlFqMDBncHFBR2NFQ0xjV0k5UGd5UnR0eGVJY2xyUGVvbks3dXN6?=
 =?utf-8?B?SFRJV0QrNVpRVlZjTmtBWWpqTkNaem91Tyt3THZEUy9SZnBLbGx0T0Uxb3RM?=
 =?utf-8?B?Tk9NVXFqMFppWm9wM2JWSm41aStUZmRyU1FrZi9IQlBSZ2lWS01zMWh1Qk1s?=
 =?utf-8?B?NXVwYUZOa09JUGdpUHQ4WFpBNDVGMXBDWkJiRXlqZ2RSeUJwOTRJL29rWWRq?=
 =?utf-8?B?QnNkNWlQMU5EWkZZdURING9BUHRCSi9OTlVyc256Mjd5QlJEM3NDYm42bzI1?=
 =?utf-8?B?Yld2djFGS05Vb0o1dTZENzF2R1dLQmVUbytweS8zMlFWREp0M0FrUnBsS3Fw?=
 =?utf-8?B?RUZTZEgvby9MWTFJMkh2Wkg3YnU2R1NRUXl1RkpucEl1bDdYejhIclpiNTFQ?=
 =?utf-8?B?VXVpekRBcGpmQlBjRG5oUFdKbVlXZE5DTHo4eWZKVlJxc0NsOUZvQmhzWlJQ?=
 =?utf-8?B?N280N1NpcE9nek84M1E3R21YUFlBZnQ1Si9qdS8wMkZDUUlMRUlSeGFuWWhP?=
 =?utf-8?B?SDNncnhRUHBNVm5wQmtWVTNIYU1nMGhYUjhsT1NBNnYvdk9tMy9WQWZSellm?=
 =?utf-8?B?SjlhbHVzWWZ4Nnh5b0NWZDhsVGViVjFLNTNCYlpvdXMrYWNYbGlHRUtLbTV0?=
 =?utf-8?B?allkN0RXcG1xaFYwMm5nUVJGWEdJQzlqZDJpZVdRSklUTFJEN3ZzUVNPSVMy?=
 =?utf-8?B?QTIzUXZLaEhIakU0VFQ5RWUrcHR3MWhDcUVNeUt5dHJ4SHlvc3FlQ2F3WGxh?=
 =?utf-8?B?Q3JqNTBBVFFPYjBRY1JrbDA4aklucHBNSWNLVmJ6TDFPdTUwUXEvVzdIQlRp?=
 =?utf-8?B?SmwrZ0VyUE1wS0djNGU3Znc0T082bEdiNjRJMVZxU3RXRjBBUmh5Z3pOSCth?=
 =?utf-8?Q?gDCHeD?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:FR3PPF3200C8D6F.DEUP281.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7416014)(38070700018)(921020);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?cW11Ky9uK010blVvazhTdXdMV1RvaWszc05qUG1pcWluMy81SWVjc2txRllI?=
 =?utf-8?B?cmpWWXRVcHJHY3pjMDBuUms5TUlmRVhvM0NDRXcxSzFiVTlCVFpvTEpJcGNt?=
 =?utf-8?B?blA5Yk1GOHkzRU5CclZESEtRY2NzR0xyL3VpVVlIanUwL3NRUGN5cjBEbTZt?=
 =?utf-8?B?L3ZHWUtKc0MvV0Z4a3VTaTMrOGJDSnRWb0YzMWxQWmRhdDR3Njdla0tCcHlY?=
 =?utf-8?B?cGxrdkFEVjVwb0hQNi9lSk5mNTJRLzU2ODVTS2dGaFlrWm8zVUlyaFdmV2Fj?=
 =?utf-8?B?MDk0cmRwTTlnZ3VDZ1JnaVRDVnNoSkdYTjcrRkx6ODBsUWFZclkrMjNrY3c2?=
 =?utf-8?B?SzR1b29rcEJ5L3RtcGY3Y2dpbXRuM29MT0NsdkphMmlQZ21PeDlWM2lNVWlr?=
 =?utf-8?B?U0V6MDYyQTBwUjdKMlprT2RXclVmVWE5bmNzbGY5TjhnaStzeTdScXZBN1pJ?=
 =?utf-8?B?REFOV1NxbWZMUm1hSFdZSHNoTDZDZUg1dGt4L2djTy92cGFITk90OEQ1amFT?=
 =?utf-8?B?OEJTemJFakRpSTVPR1hEeGhlZlN4RmZqbndJTzlxcTVzUnRUOVRHcGJpY3Zx?=
 =?utf-8?B?Ny9IeDVkRWJTMERhbmxESHphWjNVR0MrUllmYXpwdmFEQVFTNFJTa3M0Y05k?=
 =?utf-8?B?VnVnZUplVXV3MzFlK3ZQaVhjY29XYmphM3ZFNlFNdTJ4QTY3azRYUXpZeGxO?=
 =?utf-8?B?VkJYa1JvbnRWWDdLdm9zY2tqeXpGNzVQem1CN2xMbXBwcnREZUxVY2dUTlNv?=
 =?utf-8?B?WVQ0T0crRW1YS3hyM0hzZld1bEJxenVhK3hjOG9lS3ZMdEhrYnNLSHpDclZu?=
 =?utf-8?B?TENma0RvYWVldjV3bWRkeE55V2ZnSE1zMGpkcDlVc0w5QkVlTnkvbnRRQm5v?=
 =?utf-8?B?dHc5V3drcVJMOE1iYkpwdmlLTU5kWkh2MHpSVy9HRDlaUE5DRklpc29sRzRE?=
 =?utf-8?B?ZnFvRWF6VmNHOUtwMXhISVFaU1RBWm1CTGxoamlDV2NzWTdyVCs5dlJaZUph?=
 =?utf-8?B?Y1lNNCtKU2UvK0FvYmo2eElDNXRkemk4WnUxblB4K1o2cjJRd2pUc3J1TkFv?=
 =?utf-8?B?SzdTWkNDbG1jUHBoZFo1Ti82T093cURJYlhPU3lVdFRTdktMMU9kSUtJMUo3?=
 =?utf-8?B?OWIrYUpLTEtQNFpIZ1VZbThIQXJwMDQrVkhRa09vU05Rd2NIcmlLbmg1b1hk?=
 =?utf-8?B?U3E4aGdmY3Y3QjQ0R2M2SCtBcU96K00wQ3Y4WVFXcS9GYTFXL0ZJVGEzcXhS?=
 =?utf-8?B?V2JGdG9oMjRyU1JYR1ZFQlIzN1Vmc29MSmdKL1hRc0lkZm43d1k2c3E2MDBK?=
 =?utf-8?B?RmlmaEtKNDVWUHp2aG5ORWRsSmJ2WE8rTUtQdnlqclZGaDRKbTNPUUR6dUpX?=
 =?utf-8?B?QUV1d1dvTDdTWHpYR0k5UHlLWTZaLzNqQStyYW4wS3pLUFdlVnJERi9KdXRi?=
 =?utf-8?B?NzNUY1lmM3FjS2NNazlSQlh5Uy9nTERwZC82aG01cm4rcG1UQllqdjVCMGgz?=
 =?utf-8?B?akxHczVpV1pBVkM3a2pHSyt5TTE5b2hVcm81ZHJiZVlRaG0xN0N3TXloY3Nj?=
 =?utf-8?B?M3dhbGxIYlNMdTdtZ3BWNS8wQXptQkFoQ05FZnhnRWV4aDR3QzZkRlhFRXZL?=
 =?utf-8?B?cW5LRTg3S09OQ3JlcWZIYnJ6UHU0eGtVcnJPa2I3MGdRWXpKVEFFcTM0U0Ew?=
 =?utf-8?B?QnNxV2EyajVDK3VkSVFKM1VPaTA4YWpuamRaZWQ2NWVFZS9ZSWRLSnFaa1pt?=
 =?utf-8?B?eStRaFU1Yk55c0RNQmwrb2pMWTRqc0w2ZWN2RXhLV0ZsdW5tTGtVOHBOUUk0?=
 =?utf-8?B?NHZMNnZ4TmxIMk9rMDZHaGFIU1M3NFNvRElpc2x2UVgvMnR1NkV4Y1JiYlkx?=
 =?utf-8?B?ZkhRWnA0bWJ0dEw0VWFYN2dhZGdYZm9PalVWQmlWSE0wbjFoQzRKU3RhVWl2?=
 =?utf-8?B?cGZiby9wd3NnNzR1Uk9Vdk9BczZxazk1NHo1eXRJMmh5UHFhbHRNZUM5UGhF?=
 =?utf-8?B?bEVyZDBZZlovVnVESE83QTYvcVdQbTFqb283ZjhEcDdZNjFTVUs1S0pRYjFS?=
 =?utf-8?B?L3RRd0xweVF2UHh2WURFUXlxTUJxNm90OHNWWTVIM3VnWU9WNXdaT0h2NjhF?=
 =?utf-8?Q?+OF2Z9D1q+NCUL0GfJaazGv4m?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <45144DEEA9AB1B4F974DF768E8898E76@DEUP281.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: adtran.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: FR3PPF3200C8D6F.DEUP281.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 147f0b16-37fa-47a9-e2b0-08ddd990f171
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Aug 2025 11:11:10.5163
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 423946e4-28c0-4deb-904c-a4a4b174fb3f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ed/wr48Lj5zCvueb3KmShT6/2qDR/VPsKfVJF6EQ7J53ZFi7Mzgc21TJCoHxHTLfisQi3drbEUxMWNtC6lfK3g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FR1PPF75A2935B5

RnJvbTogUGlvdHIgS3ViaWsgPHBpb3RyLmt1YmlrQGFkdHJhbi5jb20+DQoNClRoZXNlIHBhdGNo
IHNlcmllcyBwcm92aWRlIHN1cHBvcnQgZm9yIFNreXdvcmtzIFNpMzQ3NCBJMkMgUG93ZXINClNv
dXJjaW5nIEVxdWlwbWVudCBjb250cm9sbGVyLg0KDQpCYXNlZCBvbiB0aGUgVFBTMjM4ODEgZHJp
dmVyIGNvZGUuDQoNClN1cHBvcnRlZCBmZWF0dXJlcyBvZiBTaTM0NzQ6DQotIGdldCBwb3J0IHN0
YXR1cywNCi0gZ2V0IHBvcnQgcG93ZXIsDQotIGdldCBwb3J0IHZvbHRhZ2UsDQotIGVuYWJsZS9k
aXNhYmxlIHBvcnQgcG93ZXINCg0KU2lnbmVkLW9mZi1ieTogUGlvdHIgS3ViaWsgPHBpb3RyLmt1
YmlrQGFkdHJhbi5jb20+DQotLS0NCg0KUmVwb3N0IGR1ZSB0byBjbG9zZWQgbWVyZ2Ugd2luZG93
LCBubyBjaGFuZ2VzLg0KDQpDaGFuZ2VzIGluIHY2Og0KICAtIFJlbW92ZSB1bm5lY2Vzc2FyeSBj
aGFuIGlkIHJhbmdlIGNoZWNrcy4NCiAgLSBGaXggcmV0dXJuIHZhbHVlIGZvciBpbmNvcnJlY3Qg
RFQgY2hhbm5lbHMgcGFyc2UuDQogIC0gU2ltcGxpZnkgYml0IGxvZ2ljIGZvciAnaXNfZW5hYmxl
ZCcgYXNzaWdubWVudC4NCiAgLSBSZW1vdmUgdW5uZWNlc3NhcnkgaW5pdCB2YWx1ZXMgYXNzaWdu
bWVudC4NCiAgLSBGaXggY29kZSBzdHlsZSBpc3N1ZXMgKGFwcGx5IGNvcnJlY3QgcmV2ZXJzZSB4
bWFzIHRyZWUgbm90YXRpb24sIHJlbW92ZSBleHRyYSBicmFja2V0cykuDQogIC0gTGluayB0byB2
NTogaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbmV0ZGV2L2JlMGZiMzY4LTc5YjYtNGI5OS1hZDZi
LTAwZDc4OTdjYThiMEBhZHRyYW4uY29tDQoNCkNoYW5nZXMgaW4gdjU6DQogIC0gUmVtb3ZlIGlu
bGluZSBmdW5jdGlvbiBkZWNsYXJhdGlvbnMuDQogIC0gRml4IGNvZGUgc3R5bGUgaXNzdWVzIChh
cHBseSByZXZlcnNlIHhtYXMgdHJlZSBub3RhdGlvbiwgcmVtb3ZlIGV4dHJhIGJyYWNrZXRzKS4N
CiAgLSBSZW1vdmUgdW5uZWNlc3NhcnkgIiE9IDAiIGNoZWNrLg0KICAtIExpbmsgdG8gdjQ6IGh0
dHBzOi8vbG9yZS5rZXJuZWwub3JnL25ldGRldi9jMGMyODRiOC02NDM4LTQxNjMtYTYyNy1iYmY1
ZjRiY2M2MjRAYWR0cmFuLmNvbQ0KDQpDaGFuZ2VzIGluIHY0Og0KICAtIFJlbW92ZSBwYXJzaW5n
IG9mIHBzZS1waXMgbm9kZTsgbm93IHJlbGllcyBzb2xlbHkgb24gdGhlIHBjZGV2LT5waVt4XSBw
cm92aWRlZCBieSB0aGUgZnJhbWV3b3JrLg0KICAtIFNldCB0aGUgREVURUNUX0NMQVNTX0VOQUJM
RSByZWdpc3RlciwgZW5zdXJpbmcgcmVsaWFibGUgUEkgcG93ZXItdXAgd2l0aG91dCBhcnRpZmlj
aWFsIGRlbGF5cy4NCiAgLSBJbnRyb2R1Y2UgaGVscGVyIG1hY3JvcyBmb3IgYml0IG1hbmlwdWxh
dGlvbiBsb2dpYy4NCiAgLSBBZGQgc2kzNDc0X2dldF9jaGFubmVscygpIGFuZCBzaTM0NzRfZ2V0
X2NoYW5fY2xpZW50KCkgaGVscGVycyB0byByZWR1Y2UgcmVkdW5kYW50IGNvZGUuDQogIC0gS2Nv
bmZpZzogQ2xhcmlmeSB0aGF0IG9ubHkgNC1wYWlyIFBTRSBjb25maWd1cmF0aW9ucyBhcmUgc3Vw
cG9ydGVkLg0KICAtIEZpeCBzZWNvbmQgY2hhbm5lbCB2b2x0YWdlIHJlYWQgaWYgdGhlIGZpcnN0
IG9uZSBpcyBpbmFjdGl2ZS4NCiAgLSBBdm9pZCByZWFkaW5nIGN1cnJlbnRzIGFuZCBjb21wdXRp
bmcgcG93ZXIgd2hlbiBQSSB2b2x0YWdlIGlzIHplcm8uDQogIC0gTGluayB0byB2MzogaHR0cHM6
Ly9sb3JlLmtlcm5lbC5vcmcvbmV0ZGV2L2Y5NzVmMjNlLTg0YTctNDhlNi1hMmIyLTE4Y2ViOTE0
ODY3NUBhZHRyYW4uY29tDQoNCkNoYW5nZXMgaW4gdjM6DQogIC0gVXNlIF9zY29wZWQgdmVyc2lv
biBvZiBmb3JfZWFjaF9jaGlsZF9vZl9ub2RlKCkuDQogIC0gUmVtb3ZlIHJlZHVuZGFudCByZXR1
cm4gdmFsdWUgYXNzaWdubWVudHMgaW4gc2kzNDc0X2dldF9vZl9jaGFubmVscygpLg0KICAtIENo
YW5nZSBkZXZfaW5mbygpIHRvIGRldl9kYmcoKSBvbiBzdWNjZXNzZnVsIHByb2JlLg0KICAtIFJl
bmFtZSBhbGwgaW5zdGFuY2VzIG9mICJzbGF2ZSIgdG8gInNlY29uZGFyeSIuDQogIC0gUmVnaXN0
ZXIgZGV2bSBjbGVhbnVwIGFjdGlvbiBmb3IgYW5jaWxsYXJ5IGkyYywgc2ltcGxpZnlpbmcgY2xl
YW51cCBsb2dpYyBpbiBzaTM0NzRfaTJjX3Byb2JlKCkuDQogIC0gQWRkIGV4cGxpY2l0IHJldHVy
biAwIG9uIHN1Y2Nlc3NmdWwgcHJvYmUuDQogIC0gRHJvcCB1bm5lY2Vzc2FyeSAucmVtb3ZlIGNh
bGxiYWNrLg0KICAtIFVwZGF0ZSBjaGFubmVsIG5vZGUgZGVzY3JpcHRpb24gaW4gZGV2aWNlIHRy
ZWUgYmluZGluZyBkb2N1bWVudGF0aW9uLg0KICAtIFJlb3JkZXIgcmVnIGFuZCByZWctbmFtZXMg
cHJvcGVydGllcyBpbiBkZXZpY2UgdHJlZSBiaW5kaW5nIGRvY3VtZW50YXRpb24uDQogIC0gUmVu
YW1lIGFsbCAic2xhdmUiIHJlZmVyZW5jZXMgdG8gInNlY29uZGFyeSIgaW4gZGV2aWNlIHRyZWUg
YmluZGluZ3MgZG9jdW1lbnRhdGlvbi4NCiAgLSBMaW5rIHRvIHYyOiBodHRwczovL2xvcmUua2Vy
bmVsLm9yZy9uZXRkZXYvYmY5ZTVjNzctNTEyZC00ZWZiLWFkMWQtZjE0MTIwYzRlMDZiQGFkdHJh
bi5jb20NCg0KQ2hhbmdlcyBpbiB2MjoNCiAgLSBIYW5kbGUgYm90aCBJQyBxdWFkcyB2aWEgc2lu
Z2xlIGRyaXZlciBpbnN0YW5jZQ0KICAtIEFkZCBhcmNoaXRlY3R1cmUgJiB0ZXJtaW5vbG9neSBk
ZXNjcmlwdGlvbiBjb21tZW50DQogIC0gQ2hhbmdlIHBpX2VuYWJsZSwgcGlfZGlzYWJsZSwgcGlf
Z2V0X2FkbWluX3N0YXRlIHRvIHVzZSBQT1JUX01PREUgcmVnaXN0ZXINCiAgLSBSZW5hbWUgcG93
ZXIgcG9ydHMgdG8gJ3BpJw0KICAtIFVzZSBpMmNfc21idXNfd3JpdGVfYnl0ZV9kYXRhKCkgZm9y
IHNpbmdsZSBieXRlIHJlZ2lzdGVycw0KICAtIENvZGluZyBzdHlsZSBpbXByb3ZlbWVudHMNCiAg
LSBMaW5rIHRvIHYxOiBodHRwczovL2xvcmUua2VybmVsLm9yZy9uZXRkZXYvYTkyYmU2MDMtN2Fk
NC00ZGQzLWIwODMtNTQ4NjU4YTQ0NDhhQGFkdHJhbi5jb20NCg0KLS0tDQpQaW90ciBLdWJpayAo
Mik6DQogIGR0LWJpbmRpbmdzOiBuZXQ6IHBzZS1wZDogQWRkIGJpbmRpbmdzIGZvciBTaTM0NzQg
UFNFIGNvbnRyb2xsZXINCiAgbmV0OiBwc2UtcGQ6IEFkZCBTaTM0NzQgUFNFIGNvbnRyb2xsZXIg
ZHJpdmVyDQoNCiAuLi4vYmluZGluZ3MvbmV0L3BzZS1wZC9za3l3b3JrcyxzaTM0NzQueWFtbCAg
fCAxNDQgKysrKysNCiBkcml2ZXJzL25ldC9wc2UtcGQvS2NvbmZpZyAgICAgICAgICAgICAgICAg
ICAgfCAgMTEgKw0KIGRyaXZlcnMvbmV0L3BzZS1wZC9NYWtlZmlsZSAgICAgICAgICAgICAgICAg
ICB8ICAgMSArDQogZHJpdmVycy9uZXQvcHNlLXBkL3NpMzQ3NC5jICAgICAgICAgICAgICAgICAg
IHwgNTY4ICsrKysrKysrKysrKysrKysrKw0KIDQgZmlsZXMgY2hhbmdlZCwgNzI0IGluc2VydGlv
bnMoKykNCiBjcmVhdGUgbW9kZSAxMDA2NDQgRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRp
bmdzL25ldC9wc2UtcGQvc2t5d29ya3Msc2kzNDc0LnlhbWwNCiBjcmVhdGUgbW9kZSAxMDA2NDQg
ZHJpdmVycy9uZXQvcHNlLXBkL3NpMzQ3NC5jDQoNCi0tIA0KMi40My4wDQoNCg==

