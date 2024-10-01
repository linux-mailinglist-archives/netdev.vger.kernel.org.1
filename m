Return-Path: <netdev+bounces-130806-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AB40598B9D3
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 12:40:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C2647282D44
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 10:40:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47CD31A08DB;
	Tue,  1 Oct 2024 10:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="h26DaXi5"
X-Original-To: netdev@vger.kernel.org
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2086.outbound.protection.outlook.com [40.107.104.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6058413D281;
	Tue,  1 Oct 2024 10:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.104.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727779211; cv=fail; b=SMERxoMLhcsdzbGp+Vrw3YjqpXVgANhAmsFwWSHVe4CdNKn3UI5upDhbQKplFRt3RagxMOPrMIsUNqOQkss+ELJc07uyvZPcHtYKPVVwIKNDsPv7SlSv1LLXfdW6LSdNlTZ7n1GHTtTxj8NkgjrZrZEfs+RmsQehjXEbA5PpT5E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727779211; c=relaxed/simple;
	bh=d77DVXQgAwFFmdIzSL5yXdqihDJLhbQWoejSnrktaLg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=jS5K+wztCHbb/7iyLeZoQ4Ta7rP+n1x7asaQU+TWY0YZjocftGJPgSuA9PO4jscWgV5eEwWJHknt4Cpvdv4t3mVYTrIxwXmewgWoM0q/HrYmyst/yLsmw8Wwf88kybiG1b+zs3d6X+GqVtz2K+HtBkeDQb2UsPWcTzgmGMMM2wQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=h26DaXi5; arc=fail smtp.client-ip=40.107.104.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=S4Lt1hT1u5VbBUtVlsem/OJJ006EhAxwYZpG6VQhcRFdD9lFjIIIPU9PKAOuOdSmLWD02RVpOF45I8GXWOLFX5kH9IIbY6q/jSsWCEDmRIutnw7cQWt7yEsVegWEVDkx5GdrVeDGQnVv/kybYlfvmUGVojyXF8g3mUNE2YpZyDgM48Ud/YJTW3TnZznIzjIqdk062o2SMRAkbLZzRteG4KGqnlCJ1V75DfvmppkmdOE/BKJ7FFYBZxfy1dVfdYN+0ZUm2cZzAyOD1QwiENLcFaF3X+TE9jtA8H5jEahqOs6wXrsWO/9DBYcVgxQLL1ic1pzKZL1wZIYNoXEhw6izEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d77DVXQgAwFFmdIzSL5yXdqihDJLhbQWoejSnrktaLg=;
 b=gHSgBbm+0mYqtnT5hfnWnECNhxlXGjC9chXBa7KgUZ9MgZsJzBTxxyv/n+4NvpfO5XYLB5KQ7XXuM74+Id2NT/MRmmDo+zZmXQpQW+2/P8PE6Dz0gA3IgHhhcxUFdVA0xzzB2hIOfru4xlmBmo4YC3iz3yJsByvzQdi8CcZ5PhAmUNehULoLIyPYkCYLfjSntUV6DtpMUwh6bMW9q/RklgIruGmrRf1gGtYmO6OKUQtc0e/jNUi4BN5bwBFeWe3usIpq/uIcodMb9LVtYliIP6GD1KVKvOeRWVlMdTmCdSoFoe6oEg92U7vrVrHd9woC53WBnqP7CvwQGn2V7sn/Ww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d77DVXQgAwFFmdIzSL5yXdqihDJLhbQWoejSnrktaLg=;
 b=h26DaXi5mLZp+H0XU1XburBpig2YZQm8bN1/dsOxFZAG6sftK1tcPNXavJVuy3fBgJpPff5joi1Clgkrbfwkke9AWPZImhwGO7VH/qGEO2wsXIht7Eq2uNzilmVFRE7dVbwpllsR9sA5CpaMwVbNcBtwJprFN9E/TTKLl95+mpeiGC+sv7Aijb4+NfzPYipV/kTUcPvMyv+UJCiJQa1LoqncBU/f2PzXZCoCPgjJJ2intvcHktEjBS88xTjZlmE4+V9zgf/kSWUkPFf6bIe6IJXH70U9SIZz0Po3FiZxZCqWUHtJzhPvxSYQe4Whzo6/SsURJ9IL12Mlbkx6gaP2gw==
Received: from AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:5b6::22)
 by DU0PR10MB7611.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:34f::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.15; Tue, 1 Oct
 2024 10:40:05 +0000
Received: from AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::baa6:3ada:fbe6:98f4]) by AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::baa6:3ada:fbe6:98f4%3]) with mapi id 15.20.8005.026; Tue, 1 Oct 2024
 10:40:05 +0000
From: "Sverdlin, Alexander" <alexander.sverdlin@siemens.com>
To: "inguin@gmx.de" <inguin@gmx.de>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>
CC: "dmurphy@ti.com" <dmurphy@ti.com>
Subject: Re: [PATCH] net: phy: dp83869: fix memory corruption when enabling
 fiber
Thread-Topic: [PATCH] net: phy: dp83869: fix memory corruption when enabling
 fiber
Thread-Index: AQHbE9r2Doq2VGEaREuQkQ81wCcCNbJxtNYA
Date: Tue, 1 Oct 2024 10:40:04 +0000
Message-ID: <c9baa43edbde4a6aab7ec32a25eec4dae7031443.camel@siemens.com>
References: <20241001075733.10986-1-inguin@gmx.de>
In-Reply-To: <20241001075733.10986-1-inguin@gmx.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR10MB6867:EE_|DU0PR10MB7611:EE_
x-ms-office365-filtering-correlation-id: 9c173b09-74c4-49c7-5284-08dce2056967
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?c3E1SmtCYXZudUpGaXdqa05lSStzV2duM3o5cTZCT1pFdXFGUzVlam5hM3A4?=
 =?utf-8?B?aEhEUDJwMWl1VUhPcEc0VTZXQld3b01WdSt5OTdQSkNGblhxbTk1ay93NXlB?=
 =?utf-8?B?c3IyTnZIU2tuVzlOeG1sTUF1MzhtNnhvUERUYjVySUJ0TXROOVFSN0xZSGYr?=
 =?utf-8?B?MDdSWUo0c2t3R3ZjQWNoNW9Ub1dUTWJJcVVQK2Jld0hQWkV3SUsxYWJkMSti?=
 =?utf-8?B?Y2t0dko2L0RMb3dkNXYzd0RpcGo2eEZ2SzkraWljSkdWR2xmM2pPVXNoZzBI?=
 =?utf-8?B?WHlHbWNKVWt5bjdTcFlZWFRKMnVibC9FaW5VR0ZvUnQvRlViNEozSUpjelRZ?=
 =?utf-8?B?Tm82Zzh0ZmtMQVhWc0k5ekV6bno1dXlhT01FU3p2VHUrZW9aWUEwRUZvc3J4?=
 =?utf-8?B?bkR1ZUI3Wm1DSHFTNlR3d2xEeEFGMTZPakFwL2lMY1pIZW51WndNemNuZjVq?=
 =?utf-8?B?OUxUQ0FodGVtK0U0TXlVNG9tdlQrZFhWbjRsWHNVSjJRd0lIKzlkeFNVVS9P?=
 =?utf-8?B?TkFFdEFkVnRaTU5SQUFWUFVSQnFwL0hQdnpRb29ZSWpOelNGMVRXWmR1cyt2?=
 =?utf-8?B?dmRxdFZDaWtIOTc2clFiZFZaWkFxMVJ3d2JzYU9zd0JhUWx5dFA4RDhVcFZS?=
 =?utf-8?B?TXgzbFpRRDBnT0VWdUQvSXJ4cEJIb0llQmRjdEs4QWFtRjdlcXh0eUFhR21v?=
 =?utf-8?B?a3J1bk95VzQ5bkZoZHlCWkxkeTJhUTEydDVpdXlyTWN2VTFtY2taM1lXSnZC?=
 =?utf-8?B?WDJjb2ZnL1ROVWMvT0RJelpGc0dKVitNSWYzOUQzUVVnUE1oSHlvY2tWMTJ2?=
 =?utf-8?B?RG0wOTZGMWUxbys3WXZMT1NBS1pISGdtSEVRZEZEYjQwTGVrMk9XREdCM1o3?=
 =?utf-8?B?aUhjS0xwK056eXp3bHBZKzJUcm5JNGU5MGhyNmZRR0luVS9BSExoaHo5NnJH?=
 =?utf-8?B?VnpYbTQ2YmFLdk04NjRVTXVBVkh2L1RrbWJTWHMwTkkrR1l3K2dCTW5pTlRT?=
 =?utf-8?B?cDJ4ZzNiTVJYOW5yMngzbHFXbm4zdE9xVXZFbWxNbUpYK0NkVUI3YzZiLzNG?=
 =?utf-8?B?UzcvcTdma2M3VzhMcWtOTTJiRmxSVy9RVEpJRW44VFdJUW1rOHdPMkJIazk0?=
 =?utf-8?B?VE1rQ0tvZitlNCtZaW5DbTZzSXp2RE9xY1ZhWGtVeHdhSVhzOEFobzhoTmdy?=
 =?utf-8?B?b292bWNBdlhuTmN0VCtod2lHc3BNMk92VDJ4L0hGemNNUmNWR1RMWVRKNElK?=
 =?utf-8?B?M2pzZGVvL09SM1g1ZnN1YTBMaWZIUXlWVEdUWEQ3cTdkTTVSUTJUeUkwUm0r?=
 =?utf-8?B?SUJQa05RcWpUNEZiMVBuWDFaSkZIOFlGa3Bic01kbkJmaHR5YVVzT1YxOC9z?=
 =?utf-8?B?SkpLU0JmU2tNNVB0Ui96VjNDNjRHdkJBa1lTM01qZnpIUzdzWE5TQ0dsVEc5?=
 =?utf-8?B?bFZDSWdvOEZKZ1R1Q3pNMUs3NmFkZ3R2eGZkQmpuN0ZpSEpyV012T1RJK3RU?=
 =?utf-8?B?OWpXdHdNcUF4UzRTQWpSMGRvT01KaXh4b0gvTzVhREhqckxWSGZ3c2RIcDdI?=
 =?utf-8?B?QitMRHVzOXNpYkgzMGZTMDFmNThuUkd6eE4wS244cXl0K1NYdkxlTHZ4eGpz?=
 =?utf-8?B?a2MvcjBHSGFnRDZVU2NHYXd3QWpQTlB5anp0bVBzb211WXVPUHBYMVBiZmpu?=
 =?utf-8?B?WFhQK1Bla3pZN3dBbTZVZkZQMm5xOHBjZFBsU2VTRStmcGtRQ1VvV2RBPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?R0YxMnBnaTgwbXRmTVdTMmxYSi9LdjJEbXFkb09ybndZNXVSTEttL3dKK2Vz?=
 =?utf-8?B?QkZYV3JwTHo1T09uZDRtWlNCaG9oY1o2KzcwbTFPSlcwZmFtT3VZSEVTTlNZ?=
 =?utf-8?B?VVU5VytGUkhxTWFhNjN2aXIrOXMzMlpjT2sveHd3YnV6WkZUMUFOYXBFQmVQ?=
 =?utf-8?B?eWtwU0pJRDZ5ZzFQUndzYUk5VzlvWEVENG9SNE5rdzFlb1NhUWU3YU9MQkNC?=
 =?utf-8?B?VG5XRGFNdDJuWENwS0pvdVpuSHAvRHFJV0crUXFhVkcyZk94N2hEekFjbUor?=
 =?utf-8?B?aGVzTHFodzRUMWMxTzFncm9CR1AvT1EvVU53anFuUVJteE1TNGwzNDdGUkJs?=
 =?utf-8?B?YVRhVVlqNkxDenpSdk5iVzlHdWhoSTUyeCtCWE44RGNSdStMZkI5Q1lZa2ZZ?=
 =?utf-8?B?YlhLZzh4blJGUmthTE5mOXorYkI2NWZic1ZiWmtjRkVCVnlYUlB3UDh6cTA3?=
 =?utf-8?B?MEd0L0NvVDBwMitxMmpodlZCeVN1VTRjY2dpOVptZWpaMXNpOUFOZkw4WW5v?=
 =?utf-8?B?WHJFcGgzbWdvZHBDV2xJMXFMSlNqaTh4WFg4SEZGQnNSN085clQ0bzVXMDNU?=
 =?utf-8?B?OU14eDBXRFNUV0daUldOSVNESExhVWUyOWJ1aFlKNGtuWUNQYVcvSC80RjF2?=
 =?utf-8?B?MlZ0dnRRdHB5VEVjRGRtSjZMUmdaNy91S2RlWFZ5bXU2SXJFUG1oWC92V3o1?=
 =?utf-8?B?L2UrMmZGNnBUbGxXTnpSc1UzcmJSRnRBdjFHdXdWQThka1NBenRJZk9pVWMz?=
 =?utf-8?B?WkZ6cjZsRjVRRnF1S2h5cmtNQVY3a2dHcVZlSkNkNUs5ZEFKRlh6VzZDWFRO?=
 =?utf-8?B?MlpINXc3NnNjMUM5b1pLUTg3NGtIMG1nMkJWUXVQcHVQczRSeEhxcjgwNXpS?=
 =?utf-8?B?QVdleEdjTEdUbTNURWc3MUhJY085SjY1Yzh1MnZSdDRuNmxaM3RWd1lVOGF0?=
 =?utf-8?B?cUcwSzBrWWMyV0YrcTRQQ21KTVV1NW5KSDF3dUcrYUZvT3pCRzMxdWhrWjhS?=
 =?utf-8?B?ekVyLy9aR2l4TU5CdDFKRjAvSmlUQWVxRlZoVjd2bVlISmp5U0pDMHRtK0p4?=
 =?utf-8?B?UEtsVEpYRHZCU2xQR3Y3SlRPQ1BBWTE3US8weUhzMnJpQUtXOS9jcXhuNHQr?=
 =?utf-8?B?OVR4OUdwTmlEd3FhbzdVWlBkclBXQ2xwZmdXamRidTV0ZHFHdzRHeXc0RDNw?=
 =?utf-8?B?VklidFRGWlNDMWl4SUNUanJZRmdEeXBrMXVETnoyZFVKaHVFZjVMRDVNVVhm?=
 =?utf-8?B?czJQOEovWVpaK0ljUU45NXVmRk4wRzNyTlZsdjVITm5ZZzdUS1RUK3JWVWdx?=
 =?utf-8?B?N2ZxYkRKN3ZWcS9PeVZySlJWL2tpNnhTbnhnMFFyNitoclY2OHhUVXVhYms1?=
 =?utf-8?B?d3FpdmJXUHFrRU1tcDFwcHczU3MxaFJtOFdYSWdQbkJQL2diU3NIWjBZcEsw?=
 =?utf-8?B?eDJReWVnaUZoc3prWlpFVnI0SzJQR0NCMHAzZUNqemgzZ2RDMnBUb08xSXND?=
 =?utf-8?B?TjJiNWkvaTNNaU1CYkNFWXZidDNkakQ3YjR4QmIyRFFMR25VckpNb0VHUGRi?=
 =?utf-8?B?a1B1TU9ubWwxQlh0YkFjUU1vNEVEN1FTekNLUjdtRENGQzh5MzdGRzczYUFC?=
 =?utf-8?B?VHdheVBJQmJZOWx2Tlg3SWNmaStrT2s0KzQzckV2amVGdHZXS1JrMkkwb0hp?=
 =?utf-8?B?WHRRaXdHYWg2RjFOdWR1a1RQZmJqY0I4VkttcnhjUW53YUw0M2lWTitQYi9L?=
 =?utf-8?B?VVdPc1NYVjlQZzNZUFRlc1FoODVGWUtCaU96RWQ3azgzZ2RlWDh0Y3RmL1Zi?=
 =?utf-8?B?ejk4VWU1aUN3a0VhUnJONTJVaGUrbDJwN1g4UDBJN0lsbS9ZWEo2bEJLelBN?=
 =?utf-8?B?ZDgySWZ2OVNwdW41YitkVm1CaHRpamM0emRONEhIZ0Fid2dZblBOSC8vZXJn?=
 =?utf-8?B?MjJMWHRqUTluRW9ObTQvWTNDL3FqTjVBMy9ZUUk5elArUUlVMTNtUjUwNFp4?=
 =?utf-8?B?bDFtanRweWNiZUVnNEJEaVVIUlJDQUU3UGs3MnpZZ3NNWUNuc3d0WWF1NVhS?=
 =?utf-8?B?TkY5TjJBcGJVbXFtMkJ0Q0UzVkwyV01yWHJYQitXUDFGcmphNnhtekEreFZq?=
 =?utf-8?B?OGgyc0RMMHdxQmZRSFFEeTFEZElPck10cjB2U3hEb0o3ak01WGRMVHZ5dDRZ?=
 =?utf-8?Q?xtwVps7P2eaknmOT9CGvpZQ=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <7B2AA1883C5D6D48983DC1C97116E388@EURPRD10.PROD.OUTLOOK.COM>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c173b09-74c4-49c7-5284-08dce2056967
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Oct 2024 10:40:05.0281
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dBMwpPqAC9HrTU7GiLtpEy2G/Y+094MeWNEVXWnRRRtwrpgTixwqhPM20fm0PbI9BN5HnfuszlUH10Qdh7zl1IsMN1VnACNWuXq/44PNeH8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB7611

SGkgSW5nbyENCg0KT24gVHVlLCAyMDI0LTEwLTAxIGF0IDA5OjU3ICswMjAwLCBJbmdvIHZhbiBM
aWwgd3JvdGU6DQo+IFdoZW4gY29uZmlndXJpbmcgdGhlIGZpYmVyIHBvcnQsIHRoZSBEUDgzODY5
IFBIWSBkcml2ZXIgaW5jb3JyZWN0bHkNCj4gY2FsbHMgbGlua21vZGVfc2V0X2JpdCgpIHdpdGgg
YSBiaXQgbWFzayAoMSA8PCAxMCkgcmF0aGVyIHRoYW4gYSBiaXQNCj4gbnVtYmVyICgxMCkuIFRo
aXMgY29ycnVwdHMgc29tZSBvdGhlciBtZW1vcnkgbG9jYXRpb24gLS0gaW4gY2FzZSBvZg0KPiBh
cm02NCB0aGUgcHJpdiBwb2ludGVyIGluIHRoZSBzYW1lIHN0cnVjdHVyZS4NCj4gDQo+IFNpZ25l
ZC1vZmYtYnk6IEluZ28gdmFuIExpbCA8aW5ndWluQGdteC5kZT4NCj4gLS0tDQo+IMKgZHJpdmVy
cy9uZXQvcGh5L2RwODM4NjkuYyB8IDIgKy0NCj4gwqAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRp
b24oKyksIDEgZGVsZXRpb24oLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL25ldC9waHkv
ZHA4Mzg2OS5jIGIvZHJpdmVycy9uZXQvcGh5L2RwODM4NjkuYw0KPiBpbmRleCBkN2FhZWZiNTIy
NmIuLjljNWFjNWQ2YTlmZCAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9uZXQvcGh5L2RwODM4Njku
Yw0KPiArKysgYi9kcml2ZXJzL25ldC9waHkvZHA4Mzg2OS5jDQo+IEBAIC02NDUsNyArNjQ1LDcg
QEAgc3RhdGljIGludCBkcDgzODY5X2NvbmZpZ3VyZV9maWJlcihzdHJ1Y3QgcGh5X2RldmljZSAq
cGh5ZGV2LA0KPiDCoAkJwqDCoMKgwqAgcGh5ZGV2LT5zdXBwb3J0ZWQpOw0KPiANCj4gwqAJbGlu
a21vZGVfc2V0X2JpdChFVEhUT09MX0xJTktfTU9ERV9GSUJSRV9CSVQsIHBoeWRldi0+c3VwcG9y
dGVkKTsNCj4gLQlsaW5rbW9kZV9zZXRfYml0KEFEVkVSVElTRURfRklCUkUsIHBoeWRldi0+YWR2
ZXJ0aXNpbmcpOw0KPiArCWxpbmttb2RlX3NldF9iaXQoRVRIVE9PTF9MSU5LX01PREVfRklCUkVf
QklULCBwaHlkZXYtPmFkdmVydGlzaW5nKTsNCg0KQXJlIHlvdSBzdXJlIHRoaXMgbGlua21vZGVf
c2V0X2JpdCgpIGlzIHJlcXVpcmVkIGF0IGFsbD8NCg0KSWYgd2UgY29uc2lkZXIgdGhlIGZvbGxv
d2luZyBjb2RlIGF0IHRoZSB2ZXJ5IGVuZCBvZiB0aGUgc2FtZSBmdW5jdGlvbj8NCg0KICAgICAg
ICAvKiBVcGRhdGUgYWR2ZXJ0aXNpbmcgZnJvbSBzdXBwb3J0ZWQgKi8NCiAgICAgICAgbGlua21v
ZGVfb3IocGh5ZGV2LT5hZHZlcnRpc2luZywgcGh5ZGV2LT5hZHZlcnRpc2luZywNCiAgICAgICAg
ICAgICAgICAgICAgcGh5ZGV2LT5zdXBwb3J0ZWQpOw0KDQo+IA0KPiDCoAlpZiAoZHA4Mzg2OS0+
bW9kZSA9PSBEUDgzODY5X1JHTUlJXzEwMDBfQkFTRSkgew0KPiDCoAkJbGlua21vZGVfc2V0X2Jp
dChFVEhUT09MX0xJTktfTU9ERV8xMDAwYmFzZVhfRnVsbF9CSVQsDQoNCi0tIA0KQWxleGFuZGVy
IFN2ZXJkbGluDQpTaWVtZW5zIEFHDQp3d3cuc2llbWVucy5jb20NCg==

