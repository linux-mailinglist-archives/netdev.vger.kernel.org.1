Return-Path: <netdev+bounces-133012-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5548D994427
	for <lists+netdev@lfdr.de>; Tue,  8 Oct 2024 11:24:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 792131C21634
	for <lists+netdev@lfdr.de>; Tue,  8 Oct 2024 09:24:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7A4715B12F;
	Tue,  8 Oct 2024 09:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="bIyxRnKO"
X-Original-To: netdev@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2042.outbound.protection.outlook.com [40.107.21.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B117413AA4E;
	Tue,  8 Oct 2024 09:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728379482; cv=fail; b=Ah4cLwuiqXnnoJwpeg9zgIbryn5fy4X8cY+rOksgQSsDcV5EguT1NrTZ3xyHMi0gNvVmMjepGVUBuUKu4W51Ez2oaCFrtF65vlZteT+pXzVBBax/fPwcqH3qSFENLXQLLkKUzjmkxmgkqFuDsRREhmeq1hUtEB4oYwBF+iaDhuE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728379482; c=relaxed/simple;
	bh=UHzSPOfQUHN1tuTp1QPWT5EfUm3ssIubSu9N5O/zEfw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=b8JqJamOyg5wQ58lIYuP71PH0qAJKixcvnFEc9SmdNWMQPqvUUOyjPu46fnNahed5uzoWq75/u5UDANjToCQ/6K+P5puy4R5d+sILQqpyG2bXQhZ9mzsQ98ot1PmZvMgg8A+qxbt89QZycVVd1F3yJZSlzUckhsMRu2NEfGI9rs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=bIyxRnKO; arc=fail smtp.client-ip=40.107.21.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jZOp4Fhv22CLPQrfkZ64bO1cJziLEoIucvIkseN2IQmTYwK2GwAIfH6IDZ24rJdcaDWnGDlypmgPPZbPXDnqtm3W+4nM8dafJ5/Z5rjNHpG06ckoqh2QgDI+7vtUPJKBYqJG96uXfdJBVytT8SEkhJk7p993xrjZxke+C+UuM28bvVVTHvnIkdQoWljZXrDBy/8WYHvJDw9diZfqSk+Jj4JuI836T7ePChAwvJLOACv3Yjm98DF4nkZUfwVs5GcLojxmwRyd+oMcPlVkBtV4umuCzF1nC5shkoRFdJtYx55u+4mcT78bvV90AduCUkNldaXGxcjIL5ISJ44W2J3e9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UHzSPOfQUHN1tuTp1QPWT5EfUm3ssIubSu9N5O/zEfw=;
 b=XZA2KMcNHn8KtcAHeLG23sy9n2QfBVg1DtXYmWc1W2C5vmSq6NIiQ97nVZfETde+qn7rMklmLJf7TTFdk5tWYl7chQM+5dv5s0Ww91mNp1OYgRVpXa/kaSg91rJ+MFrlfABXys4YJ+rDJdslLs5vQ3pgvevVEkVfJXoTHzam7gxmOKcAgMaa2+qA1Y8KADznRQmMHDkzLmFzJ3fsUoWtRY9qUocS2YOZ2xzWrQ40Aa5mnz9S7OldERPCw18o2n6946nOwVjHH6z8FLM1AEfSbytjRoMX/9stX/CfadvMJzlCkVi9ZTN+4RynuK+TxVvBvGOAV2rlIOHXmshQbzPxHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UHzSPOfQUHN1tuTp1QPWT5EfUm3ssIubSu9N5O/zEfw=;
 b=bIyxRnKOVLQ8icoWTIyfslbAxhu6ZbIsLaWFAaQH3P96weIzBlp9aKEVOyBGtGNJjoQonv40YmX8MTEQcf2UZ05lfps995d+lW0GMRHFZquNAnnnv9pfur7L7ngVBgVEf5wQguNgTVW290xgtAklI2lQ/KMVLnj9Fmh23PoOVTeDPOYLFn5ovem4rTxiw2kL591eim/FZKIJDTWGJSGGqnCCZ/lli0rzOY53OQhOAzDZv9Cn3CP1h5XHrwMX5v9pt3N0u+n+O6mGWu3Fx4lqF20WGTEeTiSIrsMfcG0oIUfHhDfL+wkc2rdL1rSJvl9PfkjGXwT2XUjwVlJBLVm5EQ==
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by AM8PR04MB7746.eurprd04.prod.outlook.com (2603:10a6:20b:235::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.22; Tue, 8 Oct
 2024 09:24:37 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%7]) with mapi id 15.20.8026.019; Tue, 8 Oct 2024
 09:24:37 +0000
From: Wei Fang <wei.fang@nxp.com>
To: "dillon.minfei@gmail.com" <dillon.minfei@gmail.com>
CC: "imx@lists.linux.dev" <imx@lists.linux.dev>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Shenwei Wang <shenwei.wang@nxp.com>, Clark
 Wang <xiaoning.wang@nxp.com>, "davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>, "kuba@kernel.org"
	<kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"u.kleine-koenig@baylibre.com" <u.kleine-koenig@baylibre.com>,
	"csokas.bence@prolan.hu" <csokas.bence@prolan.hu>
Subject: RE: [PATCH v1] net: ethernet: fix NULL pointer dereference at
 fec_ptp_save_state()
Thread-Topic: [PATCH v1] net: ethernet: fix NULL pointer dereference at
 fec_ptp_save_state()
Thread-Index: AQHbGWMI+FGh0Hm7Ok6LJ+s1+D0S47J8lKlw
Date: Tue, 8 Oct 2024 09:24:37 +0000
Message-ID:
 <PAXPR04MB85106420DA87BA00EF755A85887E2@PAXPR04MB8510.eurprd04.prod.outlook.com>
References: <20241008091817.977999-1-dillon.minfei@gmail.com>
In-Reply-To: <20241008091817.977999-1-dillon.minfei@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8510:EE_|AM8PR04MB7746:EE_
x-ms-office365-filtering-correlation-id: ab38b7ea-6e43-47b0-560c-08dce77b078e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?gb2312?B?cEppMmtpSjN6QW50SS9wMkc1aEZJUmV0UkFkNDEwa2lqUlhkdGk2MmZTQU55?=
 =?gb2312?B?ZVoyOGJXQzc3YmwvM0FQMXNBV2hQRXVWWUthMjJ3V0haOHZVa0lTZjh0VEd2?=
 =?gb2312?B?K05PcjJFcXJDK3VyZmtPSWtxaFRDRldXR3Z5K3FVUkRrWG5zbmZFd0s5QXRG?=
 =?gb2312?B?M3pLMElPOENlSlozUnY1TUgyWi9ON3haMVJ2SERoWnU1V2IwUkE3aHROTXpo?=
 =?gb2312?B?V29Ybk12ZERjeTBDRTdUaDJobzEvaGc4eG5jNGQ1bDEyR0o0REo2NzRCeEE1?=
 =?gb2312?B?aWR1S3FDSzdoNDFDUlFLbDBpeUtQZ2U1WDhpalhnaTV0S0doZ01QWEF4SVNV?=
 =?gb2312?B?clBlbzJMNE5SNXQ1YTVVcjV2SVFRaWNBSUJEeWpyMmRPTE1vTGZXYlZuZm0v?=
 =?gb2312?B?Mnh3SWhKM0h5a2J4Vm4xYThCUlJObjl2MzNmbWFSeCs3RUowbWNnNnU3MlZJ?=
 =?gb2312?B?amtPV1Y3VFh3RHFaV1RlWnJGYWkwZzA3MVRWclIzcUpQL012eXVFOHY3RnJL?=
 =?gb2312?B?QXdyL3NmaHk5dHdBRVo5ZUZRNWZ2UWtQODdnK0R3U3pXMG5Dc0xVbHk4UFdI?=
 =?gb2312?B?Ym9vS1M5ellUSDZIQWtZRzBPQ0QvUEUzTlZ3KzlsdS9yZVh1L1ZpN012a0FP?=
 =?gb2312?B?SGdLVTluY0pBWnJHZmUyRTZ0Ukc3Qm52UStKOXVUQWVrelZveHB2eDhwSStN?=
 =?gb2312?B?YXpockNBRkN1ZENiWGtRYkFKK2NmUDdIRVk1NWJ4aU9KMmU1emhpdktNWFJq?=
 =?gb2312?B?am1uSXpsZ2FueVlEYUJuM2Q0eGpkTHFZVTg4QW1ZMXFjVCtXc0N6U25nS0k2?=
 =?gb2312?B?SVM0bVlsTm9DZ2kxTkZSR2pKN09ZcG85TVVabGVxZmw3Z0FKOFFNL1ZvUFBv?=
 =?gb2312?B?YUZUcm84clF4d2xiL0VacU9OZVNJbTJ2dTlsSS9jWk1LZWVzbnZEdTBUdUJZ?=
 =?gb2312?B?dUhFVTg5dTFEdy83dlhoTDhWWGQ1SkpyVzlFQkdmUi90SE05MkNMSzdTRm1J?=
 =?gb2312?B?TDlqTE5OUlRDWC9QNTJZa0pNOFhqNjFicDI4ajl0MURUWmRsdjU0djEwUjBk?=
 =?gb2312?B?T3BjYmRPUVU1dVNUMHBjZjQ2YS9ONXc4NTJEckI2c2g2Vit6SWFIMUJXamhF?=
 =?gb2312?B?SXA2MndiVlNKOStaWEN1bW1EV0hlOHFYeEozSDhzdnNhNFVzT1hvaWRjT3lj?=
 =?gb2312?B?QU8yWjlWb0EwOGQrNmMrN1JHMHZoYkgvSWtUdXpQMnNNSHI3TXVUOTk3YnpF?=
 =?gb2312?B?RzY5S1NPQ3RCbmVhaXMrdDkwZVJWQWttV1RsSkdlTUhEV0J5aVZ5YThjc0c0?=
 =?gb2312?B?N0NRQk1yMndxTDJabHRJRzR5eTVyZnYyWStVeVIrQ04xR1FFQkcra3Nncmxl?=
 =?gb2312?B?eWJVZTFWTSt4UThmRDU4c1U1b0VsR0gyUE9vREtZaDlGMlczTElXMlBPRDNH?=
 =?gb2312?B?WjlZbWYwemowV0lidGsyNUlJSjJjdnJsbVU5bGN1bUtWcmlORkJybTQrMmw5?=
 =?gb2312?B?RTlxME0wNlZTNU14ZCtNWW1PQWhISE1aUEw5cTAyZFlLUXlZcndTNEtSMzRx?=
 =?gb2312?B?UHBzTFpzWE9GTXh5MUErWTYwTHNLREE4RnFDZUZ0RVBheGthYUlkWlg4SjNQ?=
 =?gb2312?B?YzcyUUIvanU5MTdtWmo1OUswU0Q2ell2aStkOXNheWRmeWJjeEZEZVNuMEhx?=
 =?gb2312?B?bDU2RVpNd2cwTnN2c3NCSFFZaGlhOXNmUHhNZCtqVXlpUlBaNFlaSUNjWEJi?=
 =?gb2312?B?ZXZvcW1GYkpqZUg1eTFab0JOUko0dWdQUWI1Z1dVaDFKT2dkRzc3VE1UQ2xo?=
 =?gb2312?B?dGIvTG14ZVRYN09taGcvUT09?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?gb2312?B?UHcwTXphclhJaGdyQkMrYUl3M0dCNVM5M0loYzBBb3pSTjZUeHRkZVRYZ2V2?=
 =?gb2312?B?OW5CaVIwOHpPdy9xaS83UENEaGJ0bFFJNjJwbnNOUWNpeU0vWnhIWmVtcEhh?=
 =?gb2312?B?bG1DMFFZbjNBc2JLelE1NzlpK1NRK2cwazVRSWZTa1Y0M3Vrc1huRG9nWU10?=
 =?gb2312?B?Szd5T1h6MW1KeFZTMXZFVVhkVlBzcWpwZ1AweTNoY0Y3SEUvZlo4SXRKalY0?=
 =?gb2312?B?NmcvTmtnMktJbXEyc0IvY3kvdU1iZUp5TVZBWnBXWkhMRG9VRkdFVzRpeFA3?=
 =?gb2312?B?ajJpeUJOVGsxVTVNbDJTQVhnOEtYaEVCZTVWbk91RUhsSWFYMWZZTnVqTlJN?=
 =?gb2312?B?UEZjVVI3LyttR29xanFFaEFOUWdIZjdZbkI1N0VWa1NRZ1JSN0I4SHZML2JP?=
 =?gb2312?B?WlpJckIyZjlHaFhBbHoyVXRpZWZwT2xrR3k3SDNXQTJIbXFlMmhNdi9uejZQ?=
 =?gb2312?B?NHBGUmRndVI4dHdoY21SVkZsQWMvSkFDb3NNZE90U1hxUUdCUTFlcmVIVXc3?=
 =?gb2312?B?K3ZhZS9JSmFiSlE4bGc4NHVIN0lRalJJeWxYdW01STM4R1cybGVNbis5dVhN?=
 =?gb2312?B?U09BZ0k3UUx2SVFiZFZITnRVSXR4elRPREVpc2tsUWlEeDZ2bDBsRHZlUW9h?=
 =?gb2312?B?KytFZ0hqUUVPRUs2cDY0UUFNRGc5bzZ1TitFVTVIVnV6UytPWk5lSFp4Rm85?=
 =?gb2312?B?YXB1TlE5cTdodnVld2tFR3cyaDhuMll1dHU4Skhva2N6YTcxcjIrT3Y5aUFY?=
 =?gb2312?B?Sk80KzFoN1drWlg5ZnFlKzh1N1F3YVl2SEluVDJ4bkJiVWpNTnlPL25venpq?=
 =?gb2312?B?VkY4WTFvMjV5aFlQbmNjZ1dQd05Lak9JYk5CMmlJNUZETHNaS3I0Z3UySmdR?=
 =?gb2312?B?dGcwRzNaTjF1RXhnK0gzaWVvclpGRjRSZlhqWmdiN1Z1cFdvZ3lnL3pmZStJ?=
 =?gb2312?B?RU8rOTljOFduMjN5ZnI3akxlNXl0bmVMWGJiT0FwN3o2U1BBRmFQUTFFekh5?=
 =?gb2312?B?Zi91eGlsZ0JFdkkvbnA2YzdNUjZZRU5RTUFxVXdSUFV2UGNRUXNEb0E4SUNU?=
 =?gb2312?B?SlFCd0hGSlN5NDhFbDRRUkwrZEloc2V6dEI1Zzh2OXUwcGtaOHdiWXNzRits?=
 =?gb2312?B?cUJCTFd5YytyZVF1cnhRYWUvZldsc1BBM0tnelI3cloxZWNFTlFoMHhDZVJW?=
 =?gb2312?B?aXlsVXB3NVBTUnU5N0RiNEcxQjhLMkxLbW41WTRFOVkzMU53c1RuQVJOY1Fr?=
 =?gb2312?B?QklTa0VLRGVsblR6dzJkTmZFZ2cwOXRiWHVVOGRZTlZ0dXJaZ0R3T2JBckhx?=
 =?gb2312?B?RzJkd2tEN3BKYmdKWXRSNXQ1bGhwdTdtTFN2bk1vTEIvMzlWU0UxMCtFS3Fz?=
 =?gb2312?B?REI0eWwvTjdGRzlGdFo0ZE1lQ2xMZGRRMU1STStqcjR5NWFoL01wMzZUcGxj?=
 =?gb2312?B?T0pCL2ZWcGlLVGxzZnB2WVJqdHJzdnBBUGNReHNoNUpuUkdTbkZMKzBBQWly?=
 =?gb2312?B?eDdaTEorMHk1U0lUQi94ZDN5ejhQQjIwNVUrZnBRb0VraVpHem9NdWJPR1pR?=
 =?gb2312?B?QmliSUlVNEtVbmVSNk83dG9PenVTVjkvS09wd2R3TS93VkpFRFpvNEtPbytN?=
 =?gb2312?B?dFUzMWVTaWdlWUxWR29BbElEY1UyRnZ2UE9tNXV1dElOTmE5em9FbVdvK0Yw?=
 =?gb2312?B?R3BYbHU0K05YUEt6c1ZwUjE3ZkRKQWFOalRDQU9LSWpxMERYemovOGJmNDYz?=
 =?gb2312?B?dkxsTnJVeE01MWpkUDlXSWFOaklJQUNuR2plZ2hzUVRjSzlvYkhnZnYzMTF4?=
 =?gb2312?B?UG1paENReGtUOVRJMll2eTZnRy9COEhUcmhTZEY0RDlvZ1EzTHhGM3lyY2t5?=
 =?gb2312?B?NU5QVHNFUGdHV0dBSVFEYzVSaEIxVlZPd1o2dXdsWHFsWFJneTJBTnFaMVRu?=
 =?gb2312?B?bWtsaGtXcnAveWNrdmZKb2ZpQ1RVMmFvOEcvY1ZjU0s3amUxOVlEbzYrd2du?=
 =?gb2312?B?WlhYeHVmdy9Dc0t0R09iUUN5Vld1M1JJd3VOa05oUmhHdzZZdDRvWUVoeVB0?=
 =?gb2312?B?amcrYXZ6bG00UW16Y3VDaVJKSWtGaVFtcmU5UkJ6VU1wRTNvQlQwUlplTWRP?=
 =?gb2312?Q?wFkI=3D?=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ab38b7ea-6e43-47b0-560c-08dce77b078e
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Oct 2024 09:24:37.3170
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: c2WK5yALrkO3LwbS8Fil/jfe8MakUwr0W388E3kEabREHBz51PzvAGnarA4lk2QXeHD2gnhZCg+XP5NXW8Uw4A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7746

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBkaWxsb24ubWluZmVpQGdtYWls
LmNvbSA8ZGlsbG9uLm1pbmZlaUBnbWFpbC5jb20+DQo+IFNlbnQ6IDIwMjTE6jEw1MI4yNUgMTc6
MTgNCj4gVG86IFdlaSBGYW5nIDx3ZWkuZmFuZ0BueHAuY29tPjsgU2hlbndlaSBXYW5nIDxzaGVu
d2VpLndhbmdAbnhwLmNvbT47DQo+IENsYXJrIFdhbmcgPHhpYW9uaW5nLndhbmdAbnhwLmNvbT47
IGRhdmVtQGRhdmVtbG9mdC5uZXQ7DQo+IGVkdW1hemV0QGdvb2dsZS5jb207IGt1YmFAa2VybmVs
Lm9yZzsgcGFiZW5pQHJlZGhhdC5jb207DQo+IHUua2xlaW5lLWtvZW5pZ0BiYXlsaWJyZS5jb207
IGNzb2thcy5iZW5jZUBwcm9sYW4uaHUNCj4gQ2M6IGlteEBsaXN0cy5saW51eC5kZXY7IG5ldGRl
dkB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7DQo+IERpbGxv
biBNaW4gPGRpbGxvbi5taW5mZWlAZ21haWwuY29tPg0KPiBTdWJqZWN0OiBbUEFUQ0ggdjFdIG5l
dDogZXRoZXJuZXQ6IGZpeCBOVUxMIHBvaW50ZXIgZGVyZWZlcmVuY2UgYXQNCj4gZmVjX3B0cF9z
YXZlX3N0YXRlKCkNCj4gDQo+IEZyb206IERpbGxvbiBNaW4gPGRpbGxvbi5taW5mZWlAZ21haWwu
Y29tPg0KPiANCj4gZmVjX3B0cF9pbml0KCkgY2FsbGVkIGF0IHByb2JlIHN0YWdlIHdoZW4gJ2J1
ZmRlc2NfZXgnIGlzIHRydWUuDQo+IHNvLCBuZWVkIGFkZCAnYnVmZGVzY19leCcgY2hlY2sgYmVm
b3JlIGNhbGwgZmVjX3B0cF9zYXZlX3N0YXRlKCksIGVsc2UNCj4gJ3RtcmVnX2xvY2snIHdpbGwg
bm90IGJlIGluaXQgYnkgc3Bpbl9sb2NrX2luaXQoKS4NCj4gDQo+IHJ1biBpbnRvIGtlcm5lbCBw
YW5pYzoNCj4gWyAgICA1LjczNTYyOF0gSGFyZHdhcmUgbmFtZTogRnJlZXNjYWxlIE1YUyAoRGV2
aWNlIFRyZWUpDQo+IFsgICAgNS43NDA4MTZdIENhbGwgdHJhY2U6DQo+IFsgICAgNS43NDA4NTNd
ICB1bndpbmRfYmFja3RyYWNlIGZyb20gc2hvd19zdGFjaysweDEwLzB4MTQNCj4gWyAgICA1Ljc0
ODc4OF0gIHNob3dfc3RhY2sgZnJvbSBkdW1wX3N0YWNrX2x2bCsweDQ0LzB4NjANCj4gWyAgICA1
Ljc1Mzk3MF0gIGR1bXBfc3RhY2tfbHZsIGZyb20gcmVnaXN0ZXJfbG9ja19jbGFzcysweDgwYy8w
eDg4OA0KPiBbICAgIDUuNzYwMDk4XSAgcmVnaXN0ZXJfbG9ja19jbGFzcyBmcm9tIF9fbG9ja19h
Y3F1aXJlKzB4OTQvMHgyYjg0DQo+IFsgICAgNS43NjYyMTNdICBfX2xvY2tfYWNxdWlyZSBmcm9t
IGxvY2tfYWNxdWlyZSsweGUwLzB4MmUwDQo+IFsgICAgNS43NzE2MzBdICBsb2NrX2FjcXVpcmUg
ZnJvbSBfcmF3X3NwaW5fbG9ja19pcnFzYXZlKzB4NWMvMHg3OA0KPiBbICAgIDUuNzc3NjY2XSAg
X3Jhd19zcGluX2xvY2tfaXJxc2F2ZSBmcm9tIGZlY19wdHBfc2F2ZV9zdGF0ZSsweDE0LzB4NjgN
Cj4gWyAgICA1Ljc4NDIyNl0gIGZlY19wdHBfc2F2ZV9zdGF0ZSBmcm9tIGZlY19yZXN0YXJ0KzB4
MmMvMHg3NzgNCj4gWyAgICA1Ljc4OTkxMF0gIGZlY19yZXN0YXJ0IGZyb20gZmVjX3Byb2JlKzB4
YzY4LzB4MTVlMA0KPiBbICAgIDUuNzk0OTc3XSAgZmVjX3Byb2JlIGZyb20gcGxhdGZvcm1fcHJv
YmUrMHg1OC8weGIwDQo+IFsgICAgNS44MDAwNTldICBwbGF0Zm9ybV9wcm9iZSBmcm9tIHJlYWxs
eV9wcm9iZSsweGM0LzB4MmNjDQo+IFsgICAgNS44MDU0NzNdICByZWFsbHlfcHJvYmUgZnJvbSBf
X2RyaXZlcl9wcm9iZV9kZXZpY2UrMHg4NC8weDE5Yw0KPiBbICAgIDUuODExNDgyXSAgX19kcml2
ZXJfcHJvYmVfZGV2aWNlIGZyb20NCj4gZHJpdmVyX3Byb2JlX2RldmljZSsweDMwLzB4MTEwDQo+
IFsgICAgNS44MTgxMDNdICBkcml2ZXJfcHJvYmVfZGV2aWNlIGZyb20gX19kcml2ZXJfYXR0YWNo
KzB4OTQvMHgxOGMNCj4gWyAgICA1LjgyNDIwMF0gIF9fZHJpdmVyX2F0dGFjaCBmcm9tIGJ1c19m
b3JfZWFjaF9kZXYrMHg3MC8weGM0DQo+IFsgICAgNS44Mjk5NzldICBidXNfZm9yX2VhY2hfZGV2
IGZyb20gYnVzX2FkZF9kcml2ZXIrMHhjNC8weDFlYw0KPiBbICAgIDUuODM1NzYyXSAgYnVzX2Fk
ZF9kcml2ZXIgZnJvbSBkcml2ZXJfcmVnaXN0ZXIrMHg3Yy8weDExNA0KPiBbICAgIDUuODQxNDQ0
XSAgZHJpdmVyX3JlZ2lzdGVyIGZyb20gZG9fb25lX2luaXRjYWxsKzB4NGMvMHgyMjQNCj4gWyAg
ICA1Ljg0NzIwNV0gIGRvX29uZV9pbml0Y2FsbCBmcm9tIGtlcm5lbF9pbml0X2ZyZWVhYmxlKzB4
MTk4LzB4MjI0DQo+IFsgICAgNS44NTM1MDJdICBrZXJuZWxfaW5pdF9mcmVlYWJsZSBmcm9tIGtl
cm5lbF9pbml0KzB4MTAvMHgxMDgNCj4gWyAgICA1Ljg1OTM3MF0gIGtlcm5lbF9pbml0IGZyb20g
cmV0X2Zyb21fZm9yaysweDE0LzB4MzgNCj4gWyAgICA1Ljg2NDUyNF0gRXhjZXB0aW9uIHN0YWNr
KDB4YzQ4MTlmYjAgdG8gMHhjNDgxOWZmOCkNCj4gWyAgICA1Ljg2OTY1MF0gOWZhMDogICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgMDAwMDAwMDANCj4gMDAwMDAwMDAgMDAwMDAw
MDAgMDAwMDAwMDANCj4gWyAgICA1Ljg3NzkwMV0gOWZjMDogMDAwMDAwMDAgMDAwMDAwMDAgMDAw
MDAwMDAgMDAwMDAwMDAgMDAwMDAwMDANCj4gMDAwMDAwMDAgMDAwMDAwMDAgMDAwMDAwMDANCj4g
WyAgICA1Ljg4NjE0OF0gOWZlMDogMDAwMDAwMDAgMDAwMDAwMDAgMDAwMDAwMDAgMDAwMDAwMDAg
MDAwMDAwMTMNCj4gMDAwMDAwMDANCj4gWyAgICA1Ljg5MjgzOF0gODwtLS0gY3V0IGhlcmUgLS0t
DQo+IFsgICAgNS44OTU5NDhdIFVuYWJsZSB0byBoYW5kbGUga2VybmVsIE5VTEwgcG9pbnRlciBk
ZXJlZmVyZW5jZSBhdCB2aXJ0dWFsDQo+IGFkZHJlc3MgMDAwMDAwMDAgd2hlbiByZWFkDQo+IA0K
PiBGaXhlczogYTE0NzdkYzg3ZGM0ICgibmV0OiBmZWM6IFJlc3RhcnQgUFBTIGFmdGVyIGxpbmsg
c3RhdGUgY2hhbmdlIikNCj4gU2lnbmVkLW9mZi1ieTogRGlsbG9uIE1pbiA8ZGlsbG9uLm1pbmZl
aUBnbWFpbC5jb20+DQo+IC0tLQ0KPiAgZHJpdmVycy9uZXQvZXRoZXJuZXQvZnJlZXNjYWxlL2Zl
Y19tYWluLmMgfCA2ICsrKystLQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDQgaW5zZXJ0aW9ucygrKSwg
MiBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL25ldC9ldGhlcm5ldC9m
cmVlc2NhbGUvZmVjX21haW4uYw0KPiBiL2RyaXZlcnMvbmV0L2V0aGVybmV0L2ZyZWVzY2FsZS9m
ZWNfbWFpbi5jDQo+IGluZGV4IDYwZmI1NDIzMWVhZC4uMWI1NTA0N2MwMjM3IDEwMDY0NA0KPiAt
LS0gYS9kcml2ZXJzL25ldC9ldGhlcm5ldC9mcmVlc2NhbGUvZmVjX21haW4uYw0KPiArKysgYi9k
cml2ZXJzL25ldC9ldGhlcm5ldC9mcmVlc2NhbGUvZmVjX21haW4uYw0KPiBAQCAtMTA3Nyw3ICsx
MDc3LDggQEAgZmVjX3Jlc3RhcnQoc3RydWN0IG5ldF9kZXZpY2UgKm5kZXYpDQo+ICAJdTMyIHJj
bnRsID0gT1BUX0ZSQU1FX1NJWkUgfCAweDA0Ow0KPiAgCXUzMiBlY250bCA9IEZFQ19FQ1JfRVRI
RVJFTjsNCj4gDQo+IC0JZmVjX3B0cF9zYXZlX3N0YXRlKGZlcCk7DQo+ICsJaWYgKGZlcC0+YnVm
ZGVzY19leCkNCj4gKwkJZmVjX3B0cF9zYXZlX3N0YXRlKGZlcCk7DQo+IA0KPiAgCS8qIFdoYWNr
IGEgcmVzZXQuICBXZSBzaG91bGQgd2FpdCBmb3IgdGhpcy4NCj4gIAkgKiBGb3IgaS5NWDZTWCBT
T0MsIGVuZXQgdXNlIEFYSSBidXMsIHdlIHVzZSBkaXNhYmxlIE1BQyBAQCAtMTM0MCw3DQo+ICsx
MzQxLDggQEAgZmVjX3N0b3Aoc3RydWN0IG5ldF9kZXZpY2UgKm5kZXYpDQo+ICAJCQluZXRkZXZf
ZXJyKG5kZXYsICJHcmFjZWZ1bCB0cmFuc21pdCBzdG9wIGRpZCBub3QgY29tcGxldGUhXG4iKTsN
Cj4gIAl9DQo+IA0KPiAtCWZlY19wdHBfc2F2ZV9zdGF0ZShmZXApOw0KPiArCWlmIChmZXAtPmJ1
ZmRlc2NfZXgpDQo+ICsJCWZlY19wdHBfc2F2ZV9zdGF0ZShmZXApOw0KPiANCj4gIAkvKiBXaGFj
ayBhIHJlc2V0LiAgV2Ugc2hvdWxkIHdhaXQgZm9yIHRoaXMuDQo+ICAJICogRm9yIGkuTVg2U1gg
U09DLCBlbmV0IHVzZSBBWEkgYnVzLCB3ZSB1c2UgZGlzYWJsZSBNQUMNCj4gLS0NCj4gMi4yNS4x
DQoNCkhpIERpbGxvbiwNCg0KSSBoYXZlIHNlbnQgdGhlIHNhbWUgcGF0Y2ggdGhpcyBtb3JuaW5n
Lg0KaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbGttbC8yMDI0MTAwODA2MTE1My4xOTc3OTMwLTEt
d2VpLmZhbmdAbnhwLmNvbS8NCg==

