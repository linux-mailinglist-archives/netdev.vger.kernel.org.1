Return-Path: <netdev+bounces-94376-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B0BD8BF4AE
	for <lists+netdev@lfdr.de>; Wed,  8 May 2024 04:41:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2E136280E3D
	for <lists+netdev@lfdr.de>; Wed,  8 May 2024 02:41:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D22310A31;
	Wed,  8 May 2024 02:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="pJxfC8Kj"
X-Original-To: netdev@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2048.outbound.protection.outlook.com [40.107.21.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D3CD107B6;
	Wed,  8 May 2024 02:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715136088; cv=fail; b=XUblWToVsogTvGUHd55v90gUMDRvzBxvPJyHZl/JIG3ASYVIV9gFI3rAwd+2IMj4absnS4a52wXIyo3s6VUeAgPazEbfBjQjqwKUjhb4etq2gIcrhjfPMNNJHVJT794sGhBxQ3jKh4OkhfQNi9+Ao1cCGTVyAVmS9tW9tNvp9Iw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715136088; c=relaxed/simple;
	bh=BKuvexpjoQthtIwFQ/rcvTGD7IVW06kyXvY6Bmxk7OI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=EdPf6n4RkvX5u5lVGjy30zC9wCVPk9UgUCwHqlzX3JDNnIs06iwh83IvBGnv8vnnj/l627hN5gltPWuWfP+MvvMJxaneJYLKlyiAqE4Z8Az8aNEKJoJg2aZD3oRspzr+dibQjALeiPOw7X4gTAy9JVjZxqNbKWeNVh5HXOoegtw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=pJxfC8Kj; arc=fail smtp.client-ip=40.107.21.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lUqM+WgM40kFotM+1SLUCoPxdBweSaSXHNJfSUddWhlODkdSkwPEtvLRxXVAlpVyrtkbhzsRMu9BUim8OdX92twlLFLIfwcirnPzqBFHfue5Bjq0oWzxFjIiNKAUe1cPzMIwFp8I+h1WRrS99gVZBwus6dOdEcFesXqlDcTe7BPAI2Bqu3I8Gk+Kxx/o5qtJTcFXQDhMsZm8ieUlknlSxn51myZ46nohjj4jNL5bAus/D6+aOFHQ2VC03tdEFXlI9iwY/MOfM15My5L4nSZ2goVWTZJ2vGe8ZDXkQV0jF81UQj23tkOnryZKCvavhS8ueCiccyf7VxPYyK01kT9V2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BKuvexpjoQthtIwFQ/rcvTGD7IVW06kyXvY6Bmxk7OI=;
 b=j/BS2bRByiSvnNVu5HSa/+XNOHg54pQaXvB8WpRSQ29MY312UwNSFLQtmAG5TFvohsf541R2o/s70WwtmM/aZWKajkCZrygSlW9aWk9szayXLdPK2/59UcuOKZUHsXXW2guzVKHtJ5fKuueWoRuHDwWqQLtMGkl1jum0L+lWrrAWry9X5hpslpcmKeBtKiRCE66gB/1cgiPpO+aOg4Wqx3c2XU/zXPvjVZMCr4FAt/JlVZSFz84AHiI+/2WoIUMpM/j5poGva1NBR2p1FYAGIgpkEu2OIXvRW8AFnpE2QkCjG8tH/Whtz8hpcjl5U3ypNkmef7a3pMcpzkAY82Zq+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BKuvexpjoQthtIwFQ/rcvTGD7IVW06kyXvY6Bmxk7OI=;
 b=pJxfC8KjbcVxY40Z+vhDBSxAAMpQC+yBX3TDF81TdXZM9p+LURoUVkyOwKovptjov+I110EUKdL8QOMvP444euwrXWI0b45+RB0NSwo1M+5dewaDCta9EiNcNnXYNXCZ/V7keiaxZorVB5DgFDpmF9W2c+pA5pcrailgcal1Mvg=
Received: from AM0PR0402MB3891.eurprd04.prod.outlook.com (2603:10a6:208:f::23)
 by DB9PR04MB8234.eurprd04.prod.outlook.com (2603:10a6:10:25d::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.30; Wed, 8 May
 2024 02:41:23 +0000
Received: from AM0PR0402MB3891.eurprd04.prod.outlook.com
 ([fe80::6562:65a4:3e00:d0ed]) by AM0PR0402MB3891.eurprd04.prod.outlook.com
 ([fe80::6562:65a4:3e00:d0ed%7]) with mapi id 15.20.7544.041; Wed, 8 May 2024
 02:41:22 +0000
From: Wei Fang <wei.fang@nxp.com>
To: Eric Dumazet <edumazet@google.com>
CC: "davem@davemloft.net" <davem@davemloft.net>, "kuba@kernel.org"
	<kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>, Shenwei Wang
	<shenwei.wang@nxp.com>, Clark Wang <xiaoning.wang@nxp.com>,
	"richardcochran@gmail.com" <richardcochran@gmail.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>
Subject: RE: [PATCH net-next] net: fec: Convert fec driver to use lock guards
Thread-Topic: [PATCH net-next] net: fec: Convert fec driver to use lock guards
Thread-Index: AQHaoF87FjdcCM/rFkC270r3dj6/NrGLlQwAgAELR8A=
Date: Wed, 8 May 2024 02:41:22 +0000
Message-ID:
 <AM0PR0402MB3891613D11CC97D5D5EEC80988E52@AM0PR0402MB3891.eurprd04.prod.outlook.com>
References: <20240507090520.284821-1-wei.fang@nxp.com>
 <CANn89iJuEubWMu4Jg3rAac=HM95U3yS9PSq1eSx+-JC6rhOdbA@mail.gmail.com>
In-Reply-To:
 <CANn89iJuEubWMu4Jg3rAac=HM95U3yS9PSq1eSx+-JC6rhOdbA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM0PR0402MB3891:EE_|DB9PR04MB8234:EE_
x-ms-office365-filtering-correlation-id: 3fb56ece-065f-4111-a398-08dc6f085954
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|376005|1800799015|366007|38070700009;
x-microsoft-antispam-message-info:
 =?utf-8?B?Tk5tQldWRlJyM0NDS2gxQ2JzZTFjRTliWHR0UjJFQy9aS2RVdkFOUm41Tk42?=
 =?utf-8?B?Qy9hS2l4cElIV2UwMVR2YVM4ZFcyQitwNS93amZDTU8yN1ZvUlhBc3YvS0da?=
 =?utf-8?B?bm9SU0hqZDRwVGV5OUJkb0w4cVRIMFZoTmI3N0FFclhDOWlyNE0xcnNZTldl?=
 =?utf-8?B?TWl6d2J2ZkhDckRtRWxwZUhEM1VGVUVQY3pYdDd2RjNIaXh5b1Vzb0Z1dVN3?=
 =?utf-8?B?QUtBTnhSemhoMjBpVjRtR3pFYnFYS0ZINFMySUNLNjJBeWJZeWlWc29TYXZw?=
 =?utf-8?B?SHBoUDBlUG5tbTRuR2tDbzFwZGp0V2FqSTJHdkFXNUI0ODM2M2JLb3VIRllR?=
 =?utf-8?B?UlN3c3Y0ZC9oTHJnb2NIanJFdkNPMmw1WjhNUTl0bWpBWUNLWjJHZFZ5ZFBu?=
 =?utf-8?B?VHZHeHNudytOMUI3blp2RmFVOEh0ekNDUURJemdGQ2wvODhyQmN4TDIyeUZU?=
 =?utf-8?B?REh0YTZOZUxGMTR5cFphaGFxQ0RXMTI3MXdRUGtzcFZVL1RNczIrZ25QTHlG?=
 =?utf-8?B?K3lDL0NvaUpUcEpGamhVTVhSOVdBaFJmSFp6b1k3b0VhaDBMdVh6UnBhbkNa?=
 =?utf-8?B?YlgyTmE5NUpEV1QxZTVoU3V0bjNRZmwzNTREMlQ3T09HSWJGUGthNEt6OFEw?=
 =?utf-8?B?cnhQejJ4K05NcVlDYk1JZXBVK3FKc1ZucDBuVmUxcm5ySkt2U3MzR3R5TjU5?=
 =?utf-8?B?QWpVeU5kTjZiWE5WV1k0UXpNOFd4Z2I0azJjaFlWL1pUL2txZDZlZmhqMzk2?=
 =?utf-8?B?allMNnZpSHp3TzJPaFN6VTZqVUo5QkkwMXR5MGVWSlgyN2NML0haV0IwUHNo?=
 =?utf-8?B?MHRUT3VJY0RKU1F4UjBNTHkvUkxIQUVwREdVV0N1NWZXRTZpSERHWExIZ2NY?=
 =?utf-8?B?dFFjQWJxajVoNUEzQ0ZpcWc3NmUrYVFsSGVrZk00Ni9Ba0cxdkRRT0hWQ3dK?=
 =?utf-8?B?TXRmQ3BINTBGY0pzTStCTDArU2p6cnpDRVZtZm01WEtWNGwwSktiMkorYmMv?=
 =?utf-8?B?dUI2UjZ2SzZzSnppS1pUbjNtWFA2a1BFRzVwbzQyd0ppWXM2ekE0cW1ZeGt3?=
 =?utf-8?B?VnpGaGp1NEtSYkg2b0xIaXBtMXN0WVVYaURReDVhS1hCOGJXVWVXdlJER0VB?=
 =?utf-8?B?dnFWZ1VLZk96VS8xTWdVVGZNZUFxNnR5WndxWnJNRFQ2NTgva3g0WktYZkl2?=
 =?utf-8?B?T2VaL29CSG1wbHIrZFoxTTh5ZE0yMzZHOStwSW5YRTZlYXJTL29pV1BUVUxY?=
 =?utf-8?B?Mkxpbjg4WGxSTmhZd29GNWprZE1UcU9DMlZsOU01R1ZLbUVaN2wyVlJIUStr?=
 =?utf-8?B?cU9RUXpMVFNqdFBoZFBLUjBpR1J0REkvWUczdks2QmcxWWVXeUMvOXVSdUxE?=
 =?utf-8?B?NzlVcG85ajlQYjNGWGZvSzNjb2RzZGxHaVgrZjBENEpkK0lLQ1lGM3oxN242?=
 =?utf-8?B?a3ZwbnQzRmhmdGxwSVhodTF2MGVydCtnckZlSUdIbjdxeldPVG5XVlhkdmhF?=
 =?utf-8?B?S3plMXhKOWJSZVJpVTlqdGVqNXkxemRKR2NVK0ZOR0ltQjRYVDFGRlRjSC94?=
 =?utf-8?B?clpTeVFLTDRGWGtRcXRibWxSWVhiS1RLczAyWHpyYXBTSnFSQW9xS1JZRG12?=
 =?utf-8?B?MW9QMlU5cXphanlkNStSRkJvK0FpMVBGaHMxOE50cXpQS2I5YSt0WXVpd1dZ?=
 =?utf-8?B?NFd0R3liK2R1YStvaFpRMGx1UFR6VWdYTWdhT2xDbW15SHVncGpHSDhOU2lw?=
 =?utf-8?B?YlVpQlF5SXArcnVrQ2VUb2hjTkxoZXlFcy9RMmw4a2dQTjdoVFBIMkxxSWxR?=
 =?utf-8?B?QWJzZDB2NTN5R2JKc01Fdz09?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR0402MB3891.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Rk03RGdybkF3R1JrdHZGUWhqZDJNN0hmdVdzcXFZZ254bFRwTVh3MURhWnB6?=
 =?utf-8?B?bjFjc3JpWkdlOXVib00ya0NNKzNUQ2Zkd1JQd1hPd1hHcjZJZ21DMHVCcEt2?=
 =?utf-8?B?dmtBcmpBaFpyZWtFZXI4VXBOYlBHRlBPQkd2em9GRTVBOThzbUYrZWkrYmph?=
 =?utf-8?B?VVk0K2lnWVR4dCtHQmoyNVl0eWJXTmxSampJdUovRUtiU2puYnhMdisvejg3?=
 =?utf-8?B?KzJOTngvdGlFbm16N0xvVW94NTYxYlBidTBaTTNpY3NKemRxMG4xcHFtN2R6?=
 =?utf-8?B?WTZpeTJ3Z0Vsc3Yxdm9ZeHVIS2h3c1ZhbytUUFp1djJiMjZmL05xdXp2L3gx?=
 =?utf-8?B?dDY3eDdhUjJ0KzE5Rnc4Rm9oVWtXcFRLbG9KSmJZcHpLbmlwcnpaQS9RWU5T?=
 =?utf-8?B?Y1Z3Um9qQzJCVCtXUjYvUGhwKzZEYzltR3AvUkhMYjdtNjBXOVhsbVNtR0Fj?=
 =?utf-8?B?MVI5MitUcWpILzdic000TUc4eUczeXJPaEdaM21MeWExOStaa29RL2daSWYx?=
 =?utf-8?B?ZklyVWp6NFFSZlZOWEhoNUcxRGRqMUMxVXJhN25TcDJWdnVPK211ZGpxNlRo?=
 =?utf-8?B?amdyMUY4bHFOQjAyQktvcTRyTUNhSWZjQ3pqY0hUUmd6SjBXV0RjeStmUDR6?=
 =?utf-8?B?VW9tcnZpMUZsREFQTnQxaitZUk92dW11TDMzZFRuUjl6U2l2UWV5SjY3TzdD?=
 =?utf-8?B?cmcrZG5vVUpVa1VMeHdkVkRadUpmTll6ejFsdjZmRFhYbEJGeXVQZGNrM1ZI?=
 =?utf-8?B?aEUwUTZ1a3JET0NiNk44dTZNOW5hMFovLzVwcFlSb0NvdFpVRWtuTUNDZUZQ?=
 =?utf-8?B?dVVJTXRGQTNmcG1ocDNCd1ViUjE4bk80YlEyVWd5QUo2VW5GUWd3THlyWE16?=
 =?utf-8?B?VXEwRVFaWC9md0VmM29PTTVhT3BuQ25OdHh5RHVCOUswNGM3QkZBTVMrNTht?=
 =?utf-8?B?cEZLMERkc3A1UzhUSGtkT0ZmMElOZ2wxSVFtOEZiOVhualhKNU5MK1lsVERN?=
 =?utf-8?B?NWhLYlhiblZsNFpRb1BoT2hTZ2g2bzE0VlhmRU9XRGtiVU5ZWXozSjUxOExl?=
 =?utf-8?B?RVlTQVVOd1JNQk4wVnJINTZEVGtXNVAvR2QxNUQ2L3dPL1ZvYWQ0Ukt1MGFq?=
 =?utf-8?B?MmZSUEgrL2x3UXBFemc0YVFQaW1iQ0xEMnhiZzBzQ25CWUY4Qk53SDRwN1BK?=
 =?utf-8?B?L0VXczFodE5PRWZlK0lBR3Zrd004b3lhaDErM0xlYXRwL1VXclcvajlpcFFZ?=
 =?utf-8?B?UE1kVzFwYXMrb0p6MHNSaHRDbE14elY1RkM1THlWaFIzRVc2QzdDek5UblBD?=
 =?utf-8?B?cTJGOFYrZE12N1lnaW52R3E1bDNxcFRqV0ZzeEF6c0RlYkI0V0JBOHRiVHhx?=
 =?utf-8?B?RlNoT3pVY0V5K25BejVGdWNucm5xQ08rSWRUaXBiQUxCLzdCQTloaEhtWTJD?=
 =?utf-8?B?THJmWWVMNmRLQXZUeVJhUHR0ZXZGWndnOTJRVXpzbU5oMFB0Nk0xSlJZNzMx?=
 =?utf-8?B?cEdkSXRxQ0RrZ1k0TjhINXhZdTAyM2xGQStLY3pGNXBTbFIwLzZodXp1QkN6?=
 =?utf-8?B?MURCOHkxalF2Z3RDdHdTMnRGU0I4cHB3alZneTJwcnRvbWRNb1NxZFdYTDNH?=
 =?utf-8?B?RVkrYlZJT2xlNlE2dW9IS3BsZ3lEMHlPRy9rQUlpc0xaVTFXcmg2M1FIejN1?=
 =?utf-8?B?Z2YwSnlQVXZHMXRmZDdZajF3M2tHSm5pOWhsT3dTaGNxVmN6TStNc0wyWDRo?=
 =?utf-8?B?NnV3T1pYeUhXQlVHQmtyNnkzVGlYcjlGQWFwQWZUWFNlUlU4ZUp1SnorZ2JB?=
 =?utf-8?B?V0FCY00xZUhUeVNqR2xmMUZKWE9aLzNrZ05XTmdsMURWT0NTTjZlaUpWbU5h?=
 =?utf-8?B?OVUxZlRaU1pSYlhJdkJZcnJibzR3RjduYWlUbFJBYlR0TEd0TjdDd0F5bnMv?=
 =?utf-8?B?c3luZTRIcXM0RFYwRXE2UW96MVU5NFRsVVVqenE0eUxRNS9MeDlTdnhTSGdT?=
 =?utf-8?B?c1JPUmJpbnZBNWw0S2NlR1dTU1NidHIrY1VJWS9wOURHeCtqZnRuV3ZUNjFq?=
 =?utf-8?B?cGlZbGR3QmFOKy9VTnR2UWdNTkh5ME5pbkYwc0M5Tk1nb3pZQTUwZTBvMlRM?=
 =?utf-8?Q?yO0Q=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM0PR0402MB3891.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3fb56ece-065f-4111-a398-08dc6f085954
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 May 2024 02:41:22.8557
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: f5zrnC89/0cPHABw6gWfXZn/em9MpWRqpwLo5sP7q0g/VsepGZ5/nYkpAz9uSGRFPtuMZgurN86cRx0LkRnJCA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8234

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBFcmljIER1bWF6ZXQgPGVkdW1h
emV0QGdvb2dsZS5jb20+DQo+IFNlbnQ6IDIwMjTlubQ15pyIN+aXpSAxODo0MA0KPiBUbzogV2Vp
IEZhbmcgPHdlaS5mYW5nQG54cC5jb20+DQo+IENjOiBkYXZlbUBkYXZlbWxvZnQubmV0OyBrdWJh
QGtlcm5lbC5vcmc7IHBhYmVuaUByZWRoYXQuY29tOyBTaGVud2VpDQo+IFdhbmcgPHNoZW53ZWku
d2FuZ0BueHAuY29tPjsgQ2xhcmsgV2FuZyA8eGlhb25pbmcud2FuZ0BueHAuY29tPjsNCj4gcmlj
aGFyZGNvY2hyYW5AZ21haWwuY29tOyBuZXRkZXZAdmdlci5rZXJuZWwub3JnOw0KPiBsaW51eC1r
ZXJuZWxAdmdlci5rZXJuZWwub3JnOyBpbXhAbGlzdHMubGludXguZGV2DQo+IFN1YmplY3Q6IFJl
OiBbUEFUQ0ggbmV0LW5leHRdIG5ldDogZmVjOiBDb252ZXJ0IGZlYyBkcml2ZXIgdG8gdXNlIGxv
Y2sgZ3VhcmRzDQo+IA0KPiBPbiBUdWUsIE1heSA3LCAyMDI0IGF0IDExOjE24oCvQU0gV2VpIEZh
bmcgPHdlaS5mYW5nQG54cC5jb20+IHdyb3RlOg0KPiA+DQo+ID4gVXNlIGd1YXJkKCkgYW5kIHNj
b3BlZF9ndWFyZCgpIGRlZmluZWQgaW4gbGludXgvY2xlYW51cC5oIHRvIGF1dG9tYXRlDQo+ID4g
bG9jayBsaWZldGltZSBjb250cm9sIGluIGZlYyBkcml2ZXIuDQo+ID4NCj4gPiBTaWduZWQtb2Zm
LWJ5OiBXZWkgRmFuZyA8d2VpLmZhbmdAbnhwLmNvbT4NCj4gPg0KPiANCj4gVG8gbWUsIHRoaXMg
bG9va3MgbGlrZSBhIG5pY2UgcmVjaXBlIGZvciBmdXR1cmUgZGlzYXN0ZXJzIHdoZW4gZG9pbmcg
YmFja3BvcnRzLA0KPiBiZWNhdXNlIEkgYW0gcHJldHR5IHN1cmUgdGhlICJnb3RvIC4uLiIgdGhh
dCBhc3N1bWVzIHRoZSBsb2NrIGlzIG1hZ2ljYWxseQ0KPiByZWxlYXNlZCB3aWxsIGZhaWwgaG9y
cmlibHkuDQo+IA0KPiBJIHdvdWxkIHVzZSBzY29wZWRfZ3VhcmQoKSBvbmx5IGZvciBuZXcgY29k
ZS4NCg0KTm93IHRoYXQgdGhlIGtlcm5lbCBhbHJlYWR5IHN1cHBvcnRzIHNjb3BlLWJhc2VkIHJl
c291cmNlIG1hbmFnZW1lbnQsDQpJIHRoaW5rIHdlIHNob3VsZCBhY3RpdmVseSB1c2UgdGhpcyBu
ZXcgbWVjaGFuaXNtLiBBdCBsZWFzdCB0aGUgcmVzdWx0IGNvdWxkDQpiZSBzYWZlciByZXNvdXJj
ZSBtYW5hZ2VtZW50IGluIHRoZSBrZXJuZWwgYW5kIGEgbG90IGZld2VyIGdvdG9zLg0K

