Return-Path: <netdev+bounces-105975-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DFC8E914019
	for <lists+netdev@lfdr.de>; Mon, 24 Jun 2024 03:35:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 681261F21512
	for <lists+netdev@lfdr.de>; Mon, 24 Jun 2024 01:35:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68873139D;
	Mon, 24 Jun 2024 01:35:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="DeeO1Fss"
X-Original-To: netdev@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2064.outbound.protection.outlook.com [40.107.20.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA5A94683;
	Mon, 24 Jun 2024 01:35:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719192930; cv=fail; b=jSL7LDmhd7TDLHzik+SEAnsiYJQULJp3bYSpX4b/+iGKXfHDA0q9QDf2C/0Ujvv77nHrhv+h8eLYI+ByN8owlKVbtb8dq6WKu1ApCF1CPPa6Xd/UJHvShBxZXcxtyFzNd0S8fXfqKKo0dKTVr9c8osQYKVTEav6pISMGe/MYDDo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719192930; c=relaxed/simple;
	bh=VptHa/psXEOEs7v5pokP6wdKRuXDGwrhoL9x6yR6bUU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=pCpagoCWP4cLiNE3qZlmaD2HCirISjFZ90Bci7PMU8R815nfbQoAH6rW/0SGRD0sEnPq7QYfDd9D//+Ky4oEpUoLwSgso0rPqpT2E4Dm+bHmfGMi8BEaSX94z2zWKZ5LNWrMYSdpSwTlut9WnhD0FTlMjn+DpN5qVUnx32Bwi2E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=DeeO1Fss; arc=fail smtp.client-ip=40.107.20.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KQRvaOJw9StOxSRQ/H2K6ADtjk5ugC+3kpWt/vTYKQiLQa012yygo8M9WK5V7pOjUYgn6emBp91WMmAgM/t02CggU3d1o4PZaLPlx16pnHKDQH7m+c0ZZsYHuFX4xbGMmYgxVHHOCXMW+5qMB/NaJCKRQNzaZCKKu9RlW/u0nT3/wZwihzJNuWSZ3n/a98i4/psjPFWvSxLk39AtMm7vpmdi1NWbp3uDn4KNdtv8DT6A5q6oHm7duSM8vuyp3Mdqd5+SY88dEgcyon1MlaXU+dHmCTH72SROBC4K34NIL0fTYDbsZHzVxcDruAFaj6bjNTPelzrS6mgS0puB48SbXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VptHa/psXEOEs7v5pokP6wdKRuXDGwrhoL9x6yR6bUU=;
 b=n99nc2Haj2e3HoiZfMmLS7A6nJluNWm52GXy2tRKmHLLQ6bUBPDj79tEGbU6CW0UzE5rxy9c4lVFe82vdhY5Up2U0dY/wQaj74bNzKSDIIdxtHn6cnFU6C7mf9uYa+W5rdhRPTcfta/eOprGe27MGpfqtqjDERNQnFYUM5EtDeW72x7X1qnCRv5V8PRT5h2f98cnUcduZ9kGZ0wMPHcs+znRaL9TsELUDSRRW9aNbIjIv8TLIdyxaUcI94bq3jJVcQkcArPGUqKLWV0AUBqoPfuHLMphZkuJmCzJjTkdSWf7SKfqBv99q1AfeQBdg2ivQmXIUNuu6oQU1e18vU+7dA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VptHa/psXEOEs7v5pokP6wdKRuXDGwrhoL9x6yR6bUU=;
 b=DeeO1FssC0Jx7gtSezP9/Rf0YkpCKO/uWxM9/0VvbFXdnKe9um5kTo20I+JfvIU8yaXH4tDVxJEwqnOjEuDERSTMerUjQUU9DQ9ZXdJQoq6JYfouRJ9iVXGrUxu88FkSrci5GTWIpKRbGS7ycRsEwYkVTXs2ccfhAzY5AH4FAjk=
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by DU2PR04MB8695.eurprd04.prod.outlook.com (2603:10a6:10:2de::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.25; Mon, 24 Jun
 2024 01:35:25 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%5]) with mapi id 15.20.7698.025; Mon, 24 Jun 2024
 01:35:24 +0000
From: Wei Fang <wei.fang@nxp.com>
To: Markus Elfring <Markus.Elfring@web.de>
CC: Julia Lawall <julia.lawall@inria.fr>, Peter Zijlstra
	<peterz@infradead.org>, Simon Horman <horms@kernel.org>, Waiman Long
	<longman@redhat.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>, Andrew Lunn <andrew@lunn.ch>,
	Clark Wang <xiaoning.wang@nxp.com>, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>, Richard Cochran <richardcochran@gmail.com>,
	Shenwei Wang <shenwei.wang@nxp.com>
Subject: RE: [PATCH v2 net-next] net: fec: Convert fec driver to use lock
 guards
Thread-Topic: [PATCH v2 net-next] net: fec: Convert fec driver to use lock
 guards
Thread-Index: AQHao1E3Rn7FvRcfoU2u3mKYC6d4drHVcqoAgADyUPA=
Date: Mon, 24 Jun 2024 01:35:24 +0000
Message-ID:
 <PAXPR04MB85106653965E0694C2C84E4C88D42@PAXPR04MB8510.eurprd04.prod.outlook.com>
References: <20240511030229.628287-1-wei.fang@nxp.com>
 <657b4098-60b8-4522-8ea0-f10aa338e1b6@web.de>
In-Reply-To: <657b4098-60b8-4522-8ea0-f10aa338e1b6@web.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8510:EE_|DU2PR04MB8695:EE_
x-ms-office365-filtering-correlation-id: 7ed3003d-7cf7-485a-d969-08dc93edeb94
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230037|376011|366013|1800799021|7416011|38070700015;
x-microsoft-antispam-message-info:
 =?gb2312?B?akxvbzN1MDRGNTdlTUc0NzR6N1Q2RlJKSVdNMEdtNjREWlY0VzF3MmtNWlFj?=
 =?gb2312?B?TTdOKzExbTZSMmVzRm9aYkR4dWk5QkZEdWNhYndpT3dEQ0xxblVIWUtZSjRk?=
 =?gb2312?B?UUZNNGZERzVVeXphMDhTL0tubEhTbW40S3UzdlgyZTcvWXRsVGc2NVVjRGMy?=
 =?gb2312?B?ZXc0Qk5pa3dJWnVkWjc3SzM0OGplUlFVSnI4bXZXMGdnWTFrL3NRNFZnaHh3?=
 =?gb2312?B?enRqNFRqc2o1d1N2N1ZhKzc1TXVyeWtJOTJYaWlLbUs5YXdIcUpURzR4VzRY?=
 =?gb2312?B?SE85VVNxVHZuVFZnM3U5RTV1bVpoTkk2U29zcll3VkVFZkVQd0h5SS95ajgz?=
 =?gb2312?B?WXZRZHkrTzV3N1B3S1FTRGR6am0vN2dRT2J5aldBVmw4TXlkdGxZMUZ2K3Jr?=
 =?gb2312?B?cGNpdEk3d2NzcFBBUTMzR29NRWRSMWVzcjJDaFYzWkpIMmdWZ3BsK2d6SWtm?=
 =?gb2312?B?UENqTWtCRkx6blZmUU0wQzgyNStTYVRuK2Q0QTZ4WXFiZU1sMWhYWm1RZWdM?=
 =?gb2312?B?MEdCSXFkM3FUeEtMcnYvOW5peE5pRk9IcXhHYzA0bUVlZlArTjlqV2dibE5N?=
 =?gb2312?B?NFFMTWhVUFpMekRXanBRdmpNaDVaa21IWUdRcnAyL0lxcTJ6TlRiMU02V2Rw?=
 =?gb2312?B?ZFhlZFE4STVJSjRidk9ZM05qOW1JanlPV1hHY05YbWZZdERxbVlFZCt6L3Rz?=
 =?gb2312?B?SXpXNktoUjlyQXMvczdQWEpaYkdEby9WVXZhWFdxWDUzTWphcnpGNmRsOXhT?=
 =?gb2312?B?bld6M0JoNTV3SStVeDdWUzlvRnA4UkFjd0FxekJOKzNZVXBPQXVSVy82UDJW?=
 =?gb2312?B?TFlFQWpFQnlJTW9Cb1BDTXBmZmt5akd5N1ZldmJmYW8vRjRiVWFid2huNnVV?=
 =?gb2312?B?eGFBNlB1QXRiVXIwZXZtaEJJR1M5N00wcW9sU090cFZCZ1dMdjdaVlNHSmN4?=
 =?gb2312?B?R3BoeWVUdW01Q3M4eG1NMzIvQ3RlRS80T3lSTklWOE9HZkZibXh5dU9RL015?=
 =?gb2312?B?M09WNEJDSm5taW1mNllwUUZiUVRQSmw2Qmp1NjJCWG92aWpNSGdyY0thZUxn?=
 =?gb2312?B?SFJzL09Fd2QxcHZlK08xV0RpWE9CWEZXeGorR0o4Z3BSdDlqbXB6TVI3bS9U?=
 =?gb2312?B?R1FtcWRhdTR6NC9tbE4wTUxzUEs4SDBDRkM4MExueFN2KytvVi8xcERuQkI2?=
 =?gb2312?B?WEZYZFJ1R0ExeEdBS0tSbzIyWHJJUHhQNXdCbEEvZUpnbUtIVzc0QmNDWlpB?=
 =?gb2312?B?N2l0M1Q2SHNOKzM1N2xTQ3lSTEwrV0ZxbzRZWWQ3bStHdnFQd0VSVkgzZFZ5?=
 =?gb2312?B?VURlY2gwbm0zOXd5eG1HVTRMY0c4MHp2aHZZejJadFkwNnpWdmFSZWt4aEdE?=
 =?gb2312?B?WnMvV1VNaWUvdjlwRU1nY0EyTDBjZTlKdlZlR0srZ29vZHh1RWUvRzVQOE9O?=
 =?gb2312?B?azdiWkpCMkJSK1lTSTZwdEtaS1VScVIrRE85L2J1bmZGSnR1VUNMYmRKRFpz?=
 =?gb2312?B?VElibVVob3VTQXFSdU9aU0FTNFE3cSt4dTIxL2FvVk5BZ0FYR0hpNkpVL1V4?=
 =?gb2312?B?S1RYSUtWUlkweGF3bzBkcGF1bFlYcExORkFSVnYvNEhvYjgvNnRxMEs5Z01u?=
 =?gb2312?B?SklLNGRCTFcvMFFXK3VlRW9sUThJQXY4NmQxUVYzTmVwUXBBRlc0MTNZWjVD?=
 =?gb2312?B?OEt5SXh6SXZtbitRbjZPTjNKbEJjT2ZEUWJFK2lDcHJWZCtqR2ZHbmhSTk96?=
 =?gb2312?Q?Eh9Fq4c+66PtT+XPCNNuQx6EKMPMxp+tMW/swwa?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(376011)(366013)(1800799021)(7416011)(38070700015);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?gb2312?B?T3lLZUFYc2NOZjQwWkRDR2JtZjdwdVBsTlhwaEZYTUlvTmVHVkgxblpWcW9D?=
 =?gb2312?B?NW8xbkpkNTlubHQxdFVOaThCakk3WGE5RWxWMWVvQW5SaGJYeVBoNE5heXZI?=
 =?gb2312?B?dUNHOHJKejJlSUg1eXoyWXRBZVcwcm5tMlJUZ29HQ0FJV2JSTW90MjYyaTQy?=
 =?gb2312?B?WW9TdXlaYld0b2VxQ1pFWTlqVzZPSWRsUUp3WGcvOGlIdEJqVFZnSlMrbnoz?=
 =?gb2312?B?YWFsY3d1cGdxSHk5UHhyOUE3NEl0ME9wTFFwU1VwMGpWaERtbEtwSXpJSEd3?=
 =?gb2312?B?YlFFZXFUTmRnZUZ1NWkvSE8rS25tZUE5ZlpXYk1zVEZXTU5KZitKS1NMM212?=
 =?gb2312?B?cmlNNm9CekVmcXlJRTE1ZWpFbTZwcUMxaExFS2Vrbk9UaThsR2drVUQ3cytn?=
 =?gb2312?B?UXhSenlId3J3QWM1YWc5ZTEvUW9YRnFkUnNNOWl6UThjU096ZE5od1ZKdnA3?=
 =?gb2312?B?U0EwUE9nZGVYR1N4elN3QVE3bEs1N1V4UTJZbmVYWldhcHFYNmF6VGlBSGhh?=
 =?gb2312?B?cHJFNkpLMFY1cW5waWFGRVZMK3RmUjBXOHptUTJZeG5xTjJKalFFa3RzdENo?=
 =?gb2312?B?VjRzZC9zY0g2VjgzaFY0a0NHRGk4eEduMHZLMVBMWkxlTXk4RWs5MFpzSjRD?=
 =?gb2312?B?Uk1pYlMzSXFUaXRpdCtYbGkxVUVpTlV0RjdhQlVhUUlEc2JKWjNCSEJ4TXFB?=
 =?gb2312?B?TU8weUVNZGxJZ2c3RVZEMlZHc2NMSktlNzdRTEtnUDhPclFUVklkMExqb0RK?=
 =?gb2312?B?bmJlVG5oNDVRU0d3OVhBZzZRMHl4dHdaYnFPK29CTExlTDFrcWxBeFgxdzBJ?=
 =?gb2312?B?a0JET01GS0NPNFBPZzBZek5zb1lyN3pkTW9UZnFxNHRVMTVTbWcralQzMm1l?=
 =?gb2312?B?dTJ1bGN0eUgrditkck5WNHJVRmo1SEZFL1U5V01xOE5XVEU0b0FHbTNrb3NZ?=
 =?gb2312?B?dEMrWXdxM1p6MkZEMlhmRUdzb1VTQzFxMk1vQ3Njd0JoNnZVRFdINVo4LzZB?=
 =?gb2312?B?MFNSQ201TDcyRGM4MHZJVU13R1pDckN3SzFBS3c3cUlNenZmQk9iMDc0czN1?=
 =?gb2312?B?akplNTdUYTM5cXlRRHJZS1V5VXRITlRyU0k2TFlkQm1FaS91UGNiRjFldmlk?=
 =?gb2312?B?Zm8wL1dHSXhKSVkrVjg1dlFab2pOUUtFVG9JZnlIN29vck9NOVZIYWZXV2RQ?=
 =?gb2312?B?MDdtWWJsNzVkQzlxTDZoZG9GaXg1TW90NkR6L0hWc0F0MXRHWXJoM24xRGd1?=
 =?gb2312?B?QjBHeGRvT0VjSXV5SHArdERWOUJZd2FETWpGcjBRODVMRGwybjByU29PMnRN?=
 =?gb2312?B?TWh6dWNVUEQydDdFQ1J0RUxmMDlmSjdEaCtPcm9BRmN3cVBCTWs4TDBMZ1Nw?=
 =?gb2312?B?RTJqc3QvOVczN0NDSlB2VE9oQXNwTm9yRmNWSHFlYkRWYzBTemtoNWZuTG5z?=
 =?gb2312?B?YllFZ3ZPN0EzY0hXWDVmaGM1Yzk5Q2tuOC8wczdYWU50Y1JyQXZrMWI2ZUNj?=
 =?gb2312?B?RzIxRHZHMmFZUjg4eHJ3T3NNVTdUWUszYXBKOGhicHNFc2V0cE84TFdLdmYy?=
 =?gb2312?B?b1ZmRHJiMjZmL2QwczRYK2FDOFNwOWVhcWVZdnFKMWRBVE1NTCt5ODB5NFdB?=
 =?gb2312?B?TmdVMWd0YUtWUkNWem5aTGdmV1FnanluZ2dxa1BRdEp6RDVHOHpRV2dZRUsw?=
 =?gb2312?B?TGE3NDROR0RMcUY1Z3d5YVJVQjhCUzMzZEZoQXUxWEo2WFIraG5vckh4MlUr?=
 =?gb2312?B?aU1xS3MxSUp6SmNNdytFTncwQVRoOXdVajRTWG1EYlFnbjZ3bHdlUUIva0dl?=
 =?gb2312?B?REQrMlRjeTZ4Z1BGZEdLWDIyb0FwR1lkSk5pYXgxTWFLeTFGYnBBaCtNdXNx?=
 =?gb2312?B?akVqOE1lWjFnaWp4MDV0Uy93N05nT1hCVHl5QjN1QlBRa2w0YnFSN2dTZlRt?=
 =?gb2312?B?MFJHS3l0NW5VamEzTkFabDVKMmhERGM4bjFQRVpoN0xjQ1FlUXc1Tmc3N1gy?=
 =?gb2312?B?YXpBd0JmaDN4OXNLSXdCZTdrSVd0TW54N1RObGVGSStaMmJtbWtGT3VlNjRm?=
 =?gb2312?B?VVg2eGExb0xsUk0yc1Z3TVI5Qy9oOTBzOExRekltd3lSelFMZ0o5aDVYOFZo?=
 =?gb2312?Q?0eF0=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ed3003d-7cf7-485a-d969-08dc93edeb94
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jun 2024 01:35:24.8234
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PkWUfPfnkbsrERK85cDju8+wUf1fN/EmR+mR4Cen5wf0EWxhTkXRwowZn458iBy3rpBgPH1PTpoFnWmTXkjtRQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8695

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBNYXJrdXMgRWxmcmluZyA8TWFy
a3VzLkVsZnJpbmdAd2ViLmRlPg0KPiBTZW50OiAyMDI0xOo21MIyM8jVIDE5OjAxDQo+IFRvOiBX
ZWkgRmFuZyA8d2VpLmZhbmdAbnhwLmNvbT47IG5ldGRldkB2Z2VyLmtlcm5lbC5vcmc7DQo+IGtl
cm5lbC1qYW5pdG9yc0B2Z2VyLmtlcm5lbC5vcmc7IGlteEBsaXN0cy5saW51eC5kZXY7IEFuZHJl
dyBMdW5uDQo+IDxhbmRyZXdAbHVubi5jaD47IENsYXJrIFdhbmcgPHhpYW9uaW5nLndhbmdAbnhw
LmNvbT47IERhdmlkIFMuIE1pbGxlcg0KPiA8ZGF2ZW1AZGF2ZW1sb2Z0Lm5ldD47IEVyaWMgRHVt
YXpldCA8ZWR1bWF6ZXRAZ29vZ2xlLmNvbT47IEpha3ViDQo+IEtpY2luc2tpIDxrdWJhQGtlcm5l
bC5vcmc+OyBQYW9sbyBBYmVuaSA8cGFiZW5pQHJlZGhhdC5jb20+OyBSaWNoYXJkDQo+IENvY2hy
YW4gPHJpY2hhcmRjb2NocmFuQGdtYWlsLmNvbT47IFNoZW53ZWkgV2FuZw0KPiA8c2hlbndlaS53
YW5nQG54cC5jb20+DQo+IENjOiBKdWxpYSBMYXdhbGwgPGp1bGlhLmxhd2FsbEBpbnJpYS5mcj47
IFBldGVyIFppamxzdHJhIDxwZXRlcnpAaW5mcmFkZWFkLm9yZz47DQo+IFNpbW9uIEhvcm1hbiA8
aG9ybXNAa2VybmVsLm9yZz47IFdhaW1hbiBMb25nIDxsb25nbWFuQHJlZGhhdC5jb20+DQo+IFN1
YmplY3Q6IFJlOiBbUEFUQ0ggdjIgbmV0LW5leHRdIG5ldDogZmVjOiBDb252ZXJ0IGZlYyBkcml2
ZXIgdG8gdXNlIGxvY2sNCj4gZ3VhcmRzDQo+DQo+ID4gVGhlIFNjb3BlLWJhc2VkIHJlc291cmNl
IG1hbmFnZW1lbnQgbWVjaGFuaXNtIGhhcyBiZWVuIGludHJvZHVjZWQNCj4gaW50bw0KPiChrQ0K
PiAgICAgICBzY29wZT8gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB3YXM/DQo+
DQo+DQo+IKGtDQo+ID4gKysrIGIvZHJpdmVycy9uZXQvZXRoZXJuZXQvZnJlZXNjYWxlL2ZlY19w
dHAuYw0KPiA+IEBAIC05OSwxOCArOTksMTcgQEANCj4gPiAgICovDQo+ID4gIHN0YXRpYyBpbnQg
ZmVjX3B0cF9lbmFibGVfcHBzKHN0cnVjdCBmZWNfZW5ldF9wcml2YXRlICpmZXAsIHVpbnQNCj4g
PiBlbmFibGUpICB7DQo+ID4gLSAgIHVuc2lnbmVkIGxvbmcgZmxhZ3M7DQo+ID4gICAgIHUzMiB2
YWwsIHRlbXB2YWw7DQo+ID4gICAgIHN0cnVjdCB0aW1lc3BlYzY0IHRzOw0KPiA+ICAgICB1NjQg
bnM7DQo+ID4NCj4gPiAtICAgaWYgKGZlcC0+cHBzX2VuYWJsZSA9PSBlbmFibGUpDQo+ID4gLSAg
ICAgICAgICAgcmV0dXJuIDA7DQo+ID4gLQ0KPiA+ICAgICBmZXAtPnBwc19jaGFubmVsID0gREVG
QVVMVF9QUFNfQ0hBTk5FTDsNCj4gPiAgICAgZmVwLT5yZWxvYWRfcGVyaW9kID0gUFBTX09VUFVU
X1JFTE9BRF9QRVJJT0Q7DQo+ID4NCj4gPiAtICAgc3Bpbl9sb2NrX2lycXNhdmUoJmZlcC0+dG1y
ZWdfbG9jaywgZmxhZ3MpOw0KPiA+ICsgICBndWFyZChzcGlubG9ja19pcnFzYXZlKSgmZmVwLT50
bXJlZ19sb2NrKTsNCj4gPiArDQo+ID4gKyAgIGlmIChmZXAtPnBwc19lbmFibGUgPT0gZW5hYmxl
KQ0KPiA+ICsgICAgICAgICAgIHJldHVybiAwOw0KPiA+DQo+ID4gICAgIGlmIChlbmFibGUpIHsN
Cj4gPiAgICAgICAgICAgICAvKiBjbGVhciBjYXB0dXJlIG9yIG91dHB1dCBjb21wYXJlIGludGVy
cnVwdCBzdGF0dXMgaWYgaGF2ZS4NCj4goa0NCj4NCj4gV2FzIHRoaXMgc291cmNlIGNvZGUgYWRq
dXN0bWVudCBpbmZsdWVuY2VkIGFsc28gYnkgYSBoaW50IGFib3V0IKGwTE9DSw0KPiBFVkFTSU9O
obENCj4gZnJvbSB0aGUgYW5hbHlzaXMgdG9vbCChsENvdmVyaXR5obE/DQo+IGh0dHBzOi8vbG9y
ZS5rLw0KPiBlcm5lbC5vcmclMkZsaW51eC1rZXJuZWwlMkZBTTBQUjA0MDJNQjM4OTEwREIyM0E2
REFCRjFDMDc0RUYxRA0KPiA4OEU1MiU0MEFNMFBSMDQwMk1CMzg5MS5ldXJwcmQwNC5wcm9kLm91
dGxvb2suY29tJTJGJmRhdGE9MDUlNw0KPiBDMDIlN0N3ZWkuZmFuZyU0MG54cC5jb20lN0NkNmJm
Yjk3ZDVmODU0YzUxMWEzYzA4ZGM5MzczZDA2NCU3DQo+IEM2ODZlYTFkM2JjMmI0YzZmYTkyY2Q5
OWM1YzMwMTYzNSU3QzAlN0MwJTdDNjM4NTQ3MzcyODI1NDU1NQ0KPiA1MCU3Q1Vua25vd24lN0NU
V0ZwYkdac2IzZDhleUpXSWpvaU1DNHdMakF3TURBaUxDSlFJam9pVjJsdU0NCj4geklpTENKQlRp
STZJazFoYVd3aUxDSlhWQ0k2TW4wJTNEJTdDMCU3QyU3QyU3QyZzZGF0YT1tOW9SeCUyRkkNCj4g
eiUyRkx1MSUyQmxjUU1SVWxIc0RmTnpuZlZsSmdiVndQcmFtaUVkQSUzRCZyZXNlcnZlZD0wDQo+
IGh0dHBzOi8vbGttbC5vLw0KPiByZyUyRmxrbWwlMkYyMDI0JTJGNSUyRjglMkY3NyZkYXRhPTA1
JTdDMDIlN0N3ZWkuZmFuZyU0MG54cC5jDQo+IG9tJTdDZDZiZmI5N2Q1Zjg1NGM1MTFhM2MwOGRj
OTM3M2QwNjQlN0M2ODZlYTFkM2JjMmI0YzZmYTkyY2QNCj4gOTljNWMzMDE2MzUlN0MwJTdDMCU3
QzYzODU0NzM3MjgyNTQ2NTg3MSU3Q1Vua25vd24lN0NUV0ZwDQo+IGJHWnNiM2Q4ZXlKV0lqb2lN
QzR3TGpBd01EQWlMQ0pRSWpvaVYybHVNeklpTENKQlRpSTZJazFoYVd3aUxDSlhWQw0KPiBJNk1u
MCUzRCU3QzAlN0MlN0MlN0Mmc2RhdGE9eUVtRGFQMzNTczRGelVIdjJJRmttR0xWOHVkbjl6MQ0K
PiBrQUZ6aTAxaWRzc1UlM0QmcmVzZXJ2ZWQ9MA0KPg0KPiBXaWxsIGFueSB0YWdzIChsaWtlIKGw
Rml4ZXOhsSBhbmQgobBDY6GxKSBiZWNvbWUgcmVsZXZhbnQgaGVyZT8NCj4NCj4gSG93IGRvIHlv
dSB0aGluayBhYm91dCB0byB0YWtlIHRoZSBrbm93biBhZHZpY2UgobBTb2x2ZSBvbmx5IG9uZSBw
cm9ibGVtDQo+IHBlciBwYXRjaKGxDQo+IGJldHRlciBpbnRvIGFjY291bnQ/DQo+IGh0dHBzOi8v
Z2l0Lmtlci8NCj4gbmVsLm9yZyUyRnB1YiUyRnNjbSUyRmxpbnV4JTJGa2VybmVsJTJGZ2l0JTJG
dG9ydmFsZHMlMkZsaW51eC5naXQlMg0KPiBGdHJlZSUyRkRvY3VtZW50YXRpb24lMkZwcm9jZXNz
JTJGc3VibWl0dGluZy1wYXRjaGVzLnJzdCUzRmglM0R2Ni4NCj4gMTAtcmM0JTIzbjgxJmRhdGE9
MDUlN0MwMiU3Q3dlaS5mYW5nJTQwbnhwLmNvbSU3Q2Q2YmZiOTdkNWY4NTQNCj4gYzUxMWEzYzA4
ZGM5MzczZDA2NCU3QzY4NmVhMWQzYmMyYjRjNmZhOTJjZDk5YzVjMzAxNjM1JTdDMCU3Qw0KPiAw
JTdDNjM4NTQ3MzcyODI1NDcyNDEzJTdDVW5rbm93biU3Q1RXRnBiR1pzYjNkOGV5SldJam9pTUM0
DQo+IHdMakF3TURBaUxDSlFJam9pVjJsdU16SWlMQ0pCVGlJNklrMWhhV3dpTENKWFZDSTZNbjAl
M0QlN0MwJTdDJQ0KPiA3QyU3QyZzZGF0YT1MYzJCc1lITXpHa0FnU3NaM3BOZG52bDhPbER0VEw3
cGIwQ05oRCUyQnoyZmclM0QmDQo+IHJlc2VydmVkPTANCj4NCj4gVW5kZXIgd2hpY2ggY2lyY3Vt
c3RhbmNlcyB3aWxsIGRldmVsb3BtZW50IGludGVyZXN0cyBncm93IGZvciBmdXJ0aGVyDQo+IGFw
cHJvYWNoZXMgYWNjb3JkaW5nIHRvIHRoZSBwcmVzZW50YXRpb24gb2Ygc2ltaWxhciBjaGFuZ2Ug
Y29tYmluYXRpb25zPw0KPg0KDQpIaSBNYXJrdXMsDQoNClRoaXMgcGF0Y2ggaGFzIGJlZW4gcmVq
ZWN0ZWQgYmVjYXVzZSBuZXRkZXYgcGVvcGxlIGRvbid0IHdhbnQgdGhlc2Ugc29ydCBvZg0KY29u
dmVyc2lvbnMgYXQgcHJlc2VudCB3aGljaCB3aWxsIG1ha2UgYmFja3BvcnRpbmcgbW9yZSBkaWZm
aWN1bHQuDQpUaGUgTE9DSyBFVkFTSU9OIGlzc3VlIGhhcyBiZWVuIGZpeGVkIGJ5IGFub3RoZXIg
cGF0Y2guDQo=

