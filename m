Return-Path: <netdev+bounces-95890-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B2D6E8C3CB0
	for <lists+netdev@lfdr.de>; Mon, 13 May 2024 09:54:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 65CA928608D
	for <lists+netdev@lfdr.de>; Mon, 13 May 2024 07:54:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73045146D7A;
	Mon, 13 May 2024 07:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Roheoovc"
X-Original-To: netdev@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2072.outbound.protection.outlook.com [40.107.22.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3BB9146D6A;
	Mon, 13 May 2024 07:53:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715586826; cv=fail; b=EW4MhR4yy3qXGfucHYDYq89oruZXP95UTjU8d1hQ5EaW025WxzOaIe3tchvEnZTfn2xMqog4Haz7Xi+KlLgZ0ILoJeA+PNM4+Dwgeya04DSDXUfukrjR17XkRO+ENUVR1wfMF81YlL5GbsZpkCrVskmTWRccZZc+BNsOm4vxPqk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715586826; c=relaxed/simple;
	bh=nNSnpz5vNJB3WTVzdeiJZrPo+HmIZlvZWLC7bW8teRQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=DU+8rvWLnE3GrOzHNH0eNH3JdPz5YBakKie1rFHsEU/FueRNjr6FCviuUxws07ctxOSknM4Bbj1hXP10yzUNUIjGnIkYhmYMN3kMHMHsRRdur9Ttjsq18YHlZbGzYeWfbbMAojBr3+N1pcjK6Wj1Gjkl3gpjAy6tKUeIbSiGJwg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=Roheoovc; arc=fail smtp.client-ip=40.107.22.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jPKcxaYSd8bk/VTdet2jLfIT10tKOMteoHwcypAkRFSgi4tfa5Lb7tkNtiO6r2SPRMciNHSbwEjHbOmUYiSNhpcw2nkqGyBB48znBXHCE1XCm7jc5I+jGXznkEiD4ftWnKU0zu/a8Uvmf5JXYLUxS7mySKTaIHqC5zuzkb7ySumlY/8+qhm9Ch+hqme1cG4wVOhzy0nWyrSraCFcKNHg8p2Pvny9QCLlaQ7tMGOEGh5iAK6mqhTFLsDJXzx281ESj9JMqOFa8Mnr2dLnM+3U7kLON+6zUTPM8IUNWlJAzPkxJSMydPb54un4StnG4B5O+Fou1ruK9Qi/7JhV4wHRQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nNSnpz5vNJB3WTVzdeiJZrPo+HmIZlvZWLC7bW8teRQ=;
 b=dnCjAW+ShI+rXsBn3T02Lc+i9oWbFdhhrFGcO1k5YQg3NRW54XuuGa84P3jCFHBST7xCBPR3n9hHvmSTobuWYGJ8wRqomH4LqI4KPVlu/pUqtknmZfpVjFV3QRBVvA8QwFd2/3EKB1/rSuTJgb3dlkeP6D5yZphzu29ZPge9jwTm+h1ij5Y3aR9IPjkBsGp9YMfxc9R7kcUG68aITdo8YHyR8YqMJYBYzC/upeIqdxMPn0SUoQJ6aNH0MmcC1SgymwzHP62O4AeRqC56kHN6d/LRbxjE3KzRSzh/5LEOjVL/hDg4lv/4w9rldxAP+ZBmDuDyw4MTDpEcJvoZwRHfiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nNSnpz5vNJB3WTVzdeiJZrPo+HmIZlvZWLC7bW8teRQ=;
 b=RoheoovcPu3mgNhwYvIwc+c30dDJpK4B5jDYDBKSNRKmCa9tnF0eteS6DMRkgsiiIy4ncNFWSaHJhxyrzLMWTB6MOVx4tYqngTeOHJRgxKbmG1zn2gEEn7bULUG7+GZmmJxwQgpDU5BuUBy7ZPkMTAM8VkGKEKkvKUASz7pWono=
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by DB9PR04MB9259.eurprd04.prod.outlook.com (2603:10a6:10:371::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.55; Mon, 13 May
 2024 07:53:38 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::baed:1f6d:59b4:957]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::baed:1f6d:59b4:957%5]) with mapi id 15.20.7544.052; Mon, 13 May 2024
 07:53:38 +0000
From: Wei Fang <wei.fang@nxp.com>
To: Eric Dumazet <edumazet@google.com>
CC: "davem@davemloft.net" <davem@davemloft.net>, "kuba@kernel.org"
	<kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>, Shenwei Wang
	<shenwei.wang@nxp.com>, Clark Wang <xiaoning.wang@nxp.com>,
	"richardcochran@gmail.com" <richardcochran@gmail.com>, "andrew@lunn.ch"
	<andrew@lunn.ch>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>
Subject: RE: [PATCH net] net: fec: avoid lock evasion when reading pps_enable
Thread-Topic: [PATCH net] net: fec: avoid lock evasion when reading pps_enable
Thread-Index: AQHapNmrkXK8ZZdjQEWnp7p3Tpjf6LGUxN8AgAADp7A=
Date: Mon, 13 May 2024 07:53:38 +0000
Message-ID:
 <PAXPR04MB85100C1A06253C0AE1EB36C288E22@PAXPR04MB8510.eurprd04.prod.outlook.com>
References: <20240513015127.961360-1-wei.fang@nxp.com>
 <CANn89i+EQDCFrhC3mN8g2k=KFpaKtrDusgaUo9zBvv0JCw8eYg@mail.gmail.com>
In-Reply-To:
 <CANn89i+EQDCFrhC3mN8g2k=KFpaKtrDusgaUo9zBvv0JCw8eYg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8510:EE_|DB9PR04MB9259:EE_
x-ms-office365-filtering-correlation-id: b6bc0cb4-c074-47a7-f377-08dc7321cccb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|376005|366007|1800799015|38070700009;
x-microsoft-antispam-message-info:
 =?utf-8?B?ZlRTTy9RUUZJOFBVamNpNG9QMmxVUkdKV293YzF6WElpdlNiUkFoQ1dHRHJ3?=
 =?utf-8?B?UVA3N0kyOWV4VXNtWW9yVW1jRVN6QUxEUGlxTFpIOTNWNktxSzJNS05zKzBr?=
 =?utf-8?B?RFVjRUVMNC9NNitBU1k3QUNZK0F1WHhZTU5yNWZZZnltNmhtejNTc3JaMTFD?=
 =?utf-8?B?YmtEZDF2VjNtZDlvN2JnQVJWV0Y4blZ3eUZkOU5VUjFuR0wyb2ZuL3h1aEt3?=
 =?utf-8?B?dlFTM3p5cndacVRnQndpc1c1VmhHSG04NTQzQ2sxcjV3N0hLblBpSkR5WEds?=
 =?utf-8?B?TFFQN0NNREFGYUUrZzhWSXlqTzlsU29hbHlCaFV3TFB1QzhSYTF6NzlLcm9N?=
 =?utf-8?B?eDREL1F4NmRyazNXSFNsdmhpVk8randaYnJ0d21wbDU2T00rL2l6VDYrWWtU?=
 =?utf-8?B?QWx4WGpsdHVhdFRlcncrREc1eUV3U3B4Nnk3c2N5UzZmL2NwZVdBUGg4SnUy?=
 =?utf-8?B?Y3J6Z2NBbHZhQVRHTm54N0RPNnVJR0NBWEtwbDlneU1SSXFOcmtPbGFkcVJ2?=
 =?utf-8?B?bWYzN3ZFQmFxeHNKenFaY0pkWTdKdTRJZnlqQm9UQjI4aW5sQTZtYk1NZExx?=
 =?utf-8?B?S0hxVkdjYU90T2hZM0FZNzVodmloUGViWmRPVUdReWxlSThzMnpsN3VVc0tv?=
 =?utf-8?B?ZDJwOGw1Uk5GVVRNQW12K3ArL1owd2J4cENiS0ZCVGVldW5ZWk9aZm94VjRS?=
 =?utf-8?B?U1hiOFptVDRsdUhScnhtbWNKamZjOWdkK3BBTjBDZTExMU1BczVOL1lPd3kv?=
 =?utf-8?B?QUlMUUdsNkp0R3BGdUhONnE0R2JzZnhGZ0xrS3FhSXQ0cWg0R3N0Z1hCR1JS?=
 =?utf-8?B?dmszVlJ1N0JZVFNCRGNkZlhFTzFyV2pwaFo3R2JYWU43QXA0dnFsUFpDTm5P?=
 =?utf-8?B?RDI0ZnQ4eW1xZ3ltNHI4NlJzTGNtZ1hJaVk5WFZrbjZuS2hkWXNzek9NSlpW?=
 =?utf-8?B?TnA2UE9LQk9CVXUvS3kvODhhVVFaSjRxT2hWZzlQVFRSSWRTcHVHYURDOEx4?=
 =?utf-8?B?QlFqalZzSHYvVnErT2c5Y1hXUmtGMlhENWs0V3dkaXBvT2ZtWnhtTU1MZEhm?=
 =?utf-8?B?ZWhubG1Bd2kxQk9TeVJzQ3J0ZUQzczh4SGZRblpNYWljWjlHaE1QOVByUUY2?=
 =?utf-8?B?ZS9CR0kyVnowdlk5VTEzdjVZOVA2QjNvQktmRHZaZmVmd2NidU9kRGN5LzYr?=
 =?utf-8?B?YlJha0kyQzlzRmFlc0lGVjZiaFVoYUtmWUU2WjN2aTZCa2Q4Zno3dXBtL2Vl?=
 =?utf-8?B?ZndjT0xJZkYvTlRacHVhelVSQ2UvSCswYTJ4cEFVK0J1TS83VXNGM3BRd3hz?=
 =?utf-8?B?c2x1bk1vNnBUd21MWWNkSmVxaGNxOXQyRVlEUFRoc0t4WTJlckpNWVhiY2d6?=
 =?utf-8?B?c3A5V1g5L1ZlOFpqQVQ1MUxsNHNMN3VkdmJLTC81NzJMaklLVVlrUHJkMnMw?=
 =?utf-8?B?Zkh6NWZoUEYrNGd5MHBQWXJUU0FQY3loRVphQTVSeXdGMVRTT2lxKzI1ODBm?=
 =?utf-8?B?YWNaV3ZmOXoyYWZSY2ZTTlRzKytVM2JhREpEU0VKZHNoMUt2RDRwMnNldjdG?=
 =?utf-8?B?NW1KT2Z1MnhyWkVISnUzRzN3VjNiRFU0L2IvTmpocTZOc0NJWmdac2Z4Mmgv?=
 =?utf-8?B?dnpycURHZHJNYnkyQ1V1eXZzZk9qYkFJMG5BcjVaeWs0T0FicXpDTXQvL1Jx?=
 =?utf-8?B?ek1qb0ptckJIRVd1aWdQdUNneGp5N244YWk1ZCtjc2VsWmdTT1A5SlpsaGZo?=
 =?utf-8?B?R2F5d1NTcXNVdTF4Q3ZuNUd2aFJnMFNPbU8vaWdtRmlVblBOQ0tjN0RqeEtW?=
 =?utf-8?B?V3JuMERnd1QxT3pWU3Y0dz09?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?WTZ0MkxJVEJUYkl0c1pWRXRRcTBELzhOaG1PMlN6SWR0QmNGN2JObzJGK3py?=
 =?utf-8?B?YVlaSVdZTjRGeGVwKy91R3U4QW85RzlQODVxRzJkeFBjaEZpaDhleXlLY0xO?=
 =?utf-8?B?T2dMY1Rlb3BCRG5oMmhNTDB3Ny9mamZkL3JTV3hlbVh2M1R2bHpHZ3ZlbTRp?=
 =?utf-8?B?YUdEVlBFVWpSUjNrcTV3djk4b09IWURYMDUrT1Zidi83REpTejhoT3pwdmJW?=
 =?utf-8?B?eTM0NkhQTEd5VUJwOVRIUWtiZTBqNDZRQXZ3Q2xqQ0xya2daYnBPaUszM3Jt?=
 =?utf-8?B?dktHR01rQ2dmOFN4Rnd1YVlBdVAyQSsrRzlxNGhNZUxOL0IxbVdOZE9sZ2p6?=
 =?utf-8?B?SGNRM0FTakdycTZ0RVZxbXkvc0xEUWhDNzkzcklCOGZTTVorcFYzUjByQm9X?=
 =?utf-8?B?STFrd2ZrRFdvZnI1RWptQlVlcGdYOHpVUktRVEVUd1YrNW85dnhVN0w4TFRP?=
 =?utf-8?B?alU1U1lMdDRLMFZrRHNuTTlkNVJJUkExSUtPbEdpd1pTVytkOElkMzE1UnZQ?=
 =?utf-8?B?Z29DTWdUbHFOdk92Ym9JV2FZcjRzZytJeEc0c2pUKytBbDFDV0Q5V2xvcCtS?=
 =?utf-8?B?TDdiN093MlJhZlBTU05IVHF0cUpSdUZhMTlicUdCdWFPT1N2eFh4eHN6R3lt?=
 =?utf-8?B?YXFDWDljbWh5c3RycFdSSmczcG4ydkh0elh2YVJXaTVNTWlOSGluUlNZMkNR?=
 =?utf-8?B?L3ZHN3NKdTNETWRzR1BVa3kxM2FuSEJyNVVGQUluU2ZEKzZxYkNVbGV0ZnA4?=
 =?utf-8?B?Q2hsb0F5Y2xnSVhxNHRia3FkdEZnWGYzNGhzZ0t6SmJZT2tkSXB3Tlg3NHRj?=
 =?utf-8?B?ZHdzaitYc0JnYWludzJDSC9yWHpJK0JwQ3JKOFFRQVFqYlNWb29wZ0dOOVhC?=
 =?utf-8?B?dGxaQ1RHaW5abWNXRjFRK0w4UnBVMTNMYlpFbkRjZlViUVBWbGxOa3A4Titm?=
 =?utf-8?B?c2NSYmkzamJIaVo0YXVaUWFuem5mbjF0QXRsbno1dTFXbzJxb3M4R25NVTMv?=
 =?utf-8?B?Um5oZzMwbTdxMGxtNEtQRUw5dzJpeXFHeWRzc2p6MWRSdXQvYVZLTzRLMTRR?=
 =?utf-8?B?ODAzVVc3dVI2U1dGYUNsSHhnQzF6eW0zNWFhVDZERUFsVkRSVm1WaTM4aVBn?=
 =?utf-8?B?NlF6cXEveHY1cVdOL3FSWTZjYnlTeFVwMUJXSU5sZnhkdEdGTmVFSSs5TWtD?=
 =?utf-8?B?SWxHZ1lJeEpUNUxBNE1DSDBPYU9JbGNkNTI0SC9xYUgwWm5HNjV0VnZVekY3?=
 =?utf-8?B?WFVhejFTTzFkc0ZsWmVWK0RVZzZtemZidENMWGk4UjZIYXd3OWQrRDVHYS9o?=
 =?utf-8?B?NDhaZHVUa3ZHMjM1ZDBldm0xVURYSlFtTlNXUG5EVjY5cURUMmlNbFV2NEpk?=
 =?utf-8?B?T1U2MTFTczlxTFdFa3kyaG5QUk0yK2hyNUpmN0VNeWYzN0s2eUhPRDRXSUFt?=
 =?utf-8?B?ejFEQWhQd1VWU05kZ2tvTk44dnZHUmVkZ2dyUDZpNlJpampsMjJOMkhmK0lY?=
 =?utf-8?B?Rm1kYytUV01FV245V1VYNHZLanFyNTBhVmdocEZUNGxVRld3dVZ3OWR1T2xx?=
 =?utf-8?B?eGh2Q0JiTVFzSG15NkMvSVhqSWMyOU5NaC81M0llYWVUWklFNWxSc0s3T2Mz?=
 =?utf-8?B?eEZNY0p4VURSUmZ2NXljYmwzMXIwVElnUnFEaysrNGFsT3YwU1JGV1lTQ2Vi?=
 =?utf-8?B?UWtNSmlrV1NlT1MzYlZjTGIxYTQ0OUZIQnVwNXM4eW1CZkRMdGhsS1pBVnd1?=
 =?utf-8?B?dmFmaW82VGtTSFd1S2JXcnNEd0pEWXdMMFNLenRJdm9iWmh1anhqazJ3S0dQ?=
 =?utf-8?B?amFWalJnVmIxMDE5cHBTTHBmZVE1RG9QdVJCd0lBZGtaZDZ4Mld3MlQzcURE?=
 =?utf-8?B?S2k3MnZ0M051cHRDRGQ1OTJjUGNLYzR4bS9ZVmJIaVpTTnRhTnRqZDRkYm8r?=
 =?utf-8?B?RzdmU1p0RjRoRW9kdkxSWEpLRkpBWklmT3FDT1VaL0k0b3BkUWlXNHhENVE0?=
 =?utf-8?B?UERwaWhiRjF2MENBcWgrTktKMWRoZFd1WG9WZjg1TmUxMFZvOHQvY3pCa3Ry?=
 =?utf-8?B?NTlYYThsV0w1RFA5RGROTm5FTXdHQUdJQ2xtL0szYTBUSGwvWElNU1FtU1pD?=
 =?utf-8?Q?mCSI=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b6bc0cb4-c074-47a7-f377-08dc7321cccb
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 May 2024 07:53:38.6581
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XkoHPDpHLPy1yAkBUuHfIo+u4Dlmq5j07Yo6cGq8JexJw7Q0lBuDp/bJiDKYy7skCOZN1IIaP33RPzKVdIJjXg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9259

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBFcmljIER1bWF6ZXQgPGVkdW1h
emV0QGdvb2dsZS5jb20+DQo+IFNlbnQ6IDIwMjTlubQ15pyIMTPml6UgMTU6MjkNCj4gVG86IFdl
aSBGYW5nIDx3ZWkuZmFuZ0BueHAuY29tPg0KPiBDYzogZGF2ZW1AZGF2ZW1sb2Z0Lm5ldDsga3Vi
YUBrZXJuZWwub3JnOyBwYWJlbmlAcmVkaGF0LmNvbTsgU2hlbndlaQ0KPiBXYW5nIDxzaGVud2Vp
LndhbmdAbnhwLmNvbT47IENsYXJrIFdhbmcgPHhpYW9uaW5nLndhbmdAbnhwLmNvbT47DQo+IHJp
Y2hhcmRjb2NocmFuQGdtYWlsLmNvbTsgYW5kcmV3QGx1bm4uY2g7IG5ldGRldkB2Z2VyLmtlcm5l
bC5vcmc7DQo+IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IGlteEBsaXN0cy5saW51eC5k
ZXYNCj4gU3ViamVjdDogUmU6IFtQQVRDSCBuZXRdIG5ldDogZmVjOiBhdm9pZCBsb2NrIGV2YXNp
b24gd2hlbiByZWFkaW5nIHBwc19lbmFibGUNCj4gDQo+IE9uIE1vbiwgTWF5IDEzLCAyMDI0IGF0
IDQ6MDLigK9BTSBXZWkgRmFuZyA8d2VpLmZhbmdAbnhwLmNvbT4gd3JvdGU6DQo+ID4NCj4gPiBU
aGUgYXNzaWdubWVudCBvZiBwcHNfZW5hYmxlIGlzIHByb3RlY3RlZCBieSB0bXJlZ19sb2NrLCBi
dXQgdGhlIHJlYWQNCj4gPiBvcGVyYXRpb24gb2YgcHBzX2VuYWJsZSBpcyBub3QuIFNvIHRoZSBD
b3Zlcml0eSB0b29sIHJlcG9ydHMgYSBsb2NrDQo+ID4gZXZhc2lvbiB3YXJuaW5nIHdoaWNoIG1h
eSBjYXVzZSBkYXRhIHJhY2UgdG8gb2NjdXIgd2hlbiBydW5uaW5nIGluIGENCj4gPiBtdWx0aXRo
cmVhZCBlbnZpcm9ubWVudC4gQWx0aG91Z2ggdGhpcyBpc3N1ZSBpcyBhbG1vc3QgaW1wb3NzaWJs
ZSB0bw0KPiA+IG9jY3VyLCB3ZSdkIGJldHRlciBmaXggaXQsIGF0IGxlYXN0IGl0IHNlZW1zIG1v
cmUgbG9naWNhbGx5DQo+ID4gcmVhc29uYWJsZSwgYW5kIGl0IGFsc28gcHJldmVudHMgQ292ZXJp
dHkgZnJvbSBjb250aW51aW5nIHRvIGlzc3VlIHdhcm5pbmdzLg0KPiA+DQo+ID4gRml4ZXM6IDI3
OGQyNDA0Nzg5MSAoIm5ldDogZmVjOiBwdHA6IEVuYWJsZSBQUFMgb3V0cHV0IGJhc2VkIG9uIHB0
cA0KPiA+IGNsb2NrIikNCj4gPiBTaWduZWQtb2ZmLWJ5OiBXZWkgRmFuZyA8d2VpLmZhbmdAbnhw
LmNvbT4NCj4gPiAtLS0NCj4gPiAgZHJpdmVycy9uZXQvZXRoZXJuZXQvZnJlZXNjYWxlL2ZlY19w
dHAuYyB8IDggKysrKystLS0NCj4gPiAgMSBmaWxlIGNoYW5nZWQsIDUgaW5zZXJ0aW9ucygrKSwg
MyBkZWxldGlvbnMoLSkNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL25ldC9ldGhlcm5l
dC9mcmVlc2NhbGUvZmVjX3B0cC5jDQo+ID4gYi9kcml2ZXJzL25ldC9ldGhlcm5ldC9mcmVlc2Nh
bGUvZmVjX3B0cC5jDQo+ID4gaW5kZXggMTgxZDliZmJlZTIyLi44ZDM3Mjc0YTNmYjAgMTAwNjQ0
DQo+ID4gLS0tIGEvZHJpdmVycy9uZXQvZXRoZXJuZXQvZnJlZXNjYWxlL2ZlY19wdHAuYw0KPiA+
ICsrKyBiL2RyaXZlcnMvbmV0L2V0aGVybmV0L2ZyZWVzY2FsZS9mZWNfcHRwLmMNCj4gPiBAQCAt
MTA0LDE0ICsxMDQsMTYgQEAgc3RhdGljIGludCBmZWNfcHRwX2VuYWJsZV9wcHMoc3RydWN0DQo+
IGZlY19lbmV0X3ByaXZhdGUgKmZlcCwgdWludCBlbmFibGUpDQo+ID4gICAgICAgICBzdHJ1Y3Qg
dGltZXNwZWM2NCB0czsNCj4gPiAgICAgICAgIHU2NCBuczsNCj4gPg0KPiA+IC0gICAgICAgaWYg
KGZlcC0+cHBzX2VuYWJsZSA9PSBlbmFibGUpDQo+ID4gLSAgICAgICAgICAgICAgIHJldHVybiAw
Ow0KPiA+IC0NCj4gPiAgICAgICAgIGZlcC0+cHBzX2NoYW5uZWwgPSBERUZBVUxUX1BQU19DSEFO
TkVMOw0KPiA+ICAgICAgICAgZmVwLT5yZWxvYWRfcGVyaW9kID0gUFBTX09VUFVUX1JFTE9BRF9Q
RVJJT0Q7DQo+IA0KPiBXaHkgYXJlIHRoZXNlIHdyaXRlcyBsZWZ0IHdpdGhvdXQgdGhlIHNwaW5s
b2NrIHByb3RlY3Rpb24gPw0KRm9yIGZlYyBkcml2ZXIsIHRoZSBwcHNfY2hhbm5lbCBhbmQgdGhl
IHJlbG9hZF9wZXJpb2Qgb2YgUFBTIHJlcXVlc3QNCmFyZSBhbHdheXMgZml4ZWQsIGFuZCB0aGV5
IHdlcmUgYWxzbyBub3QgcHJvdGVjdGVkIGJ5IHRoZSBsb2NrIGluIHRoZQ0Kb3JpZ2luYWwgY29k
ZS4NCg0KPiANCj4gDQo+ID4NCj4gPiAgICAgICAgIHNwaW5fbG9ja19pcnFzYXZlKCZmZXAtPnRt
cmVnX2xvY2ssIGZsYWdzKTsNCj4gPg0KPiA+ICsgICAgICAgaWYgKGZlcC0+cHBzX2VuYWJsZSA9
PSBlbmFibGUpIHsNCj4gPiArICAgICAgICAgICAgICAgc3Bpbl91bmxvY2tfaXJxcmVzdG9yZSgm
ZmVwLT50bXJlZ19sb2NrLCBmbGFncyk7DQo+ID4gKyAgICAgICAgICAgICAgIHJldHVybiAwOw0K
PiA+ICsgICAgICAgfQ0KPiA+ICsNCj4gPiAgICAgICAgIGlmIChlbmFibGUpIHsNCj4gPiAgICAg
ICAgICAgICAgICAgLyogY2xlYXIgY2FwdHVyZSBvciBvdXRwdXQgY29tcGFyZSBpbnRlcnJ1cHQg
c3RhdHVzIGlmDQo+IGhhdmUuDQo+ID4gICAgICAgICAgICAgICAgICAqLw0KPiA+IC0tDQo+ID4g
Mi4zNC4xDQo+ID4NCg==

