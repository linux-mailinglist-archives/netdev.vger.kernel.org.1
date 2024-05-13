Return-Path: <netdev+bounces-96024-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 69DBA8C408B
	for <lists+netdev@lfdr.de>; Mon, 13 May 2024 14:18:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 20357285F05
	for <lists+netdev@lfdr.de>; Mon, 13 May 2024 12:18:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E350714F116;
	Mon, 13 May 2024 12:18:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="W6KCe4MX"
X-Original-To: netdev@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2063.outbound.protection.outlook.com [40.107.20.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FDA614F126;
	Mon, 13 May 2024 12:18:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715602713; cv=fail; b=PWMScbaokQVCr/arV2+G3q2W1rr95k0bhFLOT+MTt1oMJzbW5LxbjF0w9MoY8e7bHPX5CphdXT59tgMygS5QHmFtNxmkYOiCTTl/8oQEggOau1jgr1Cs5AhQgFe9/305a4ulwGE6JcdyoJTCTTX8kPIYAA3k0ZCCSENK/eqcPv4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715602713; c=relaxed/simple;
	bh=f58VkIooV+K02zBEqd790A5GThYDvD/e2GwYHfRCS80=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=JY2RnVvqPpGQD2jktflC7YHknUh/SNOQrCs4ybty0WXI4Q6D43vyjTn2DH+DFXpmPuFG9naKZJQzN2rG43jPwaXBCa6z2PX4EkUMg7IS8qo7DxRSCHX246IRjxr88X2VhzIpHwdIVXuWEJtzHQBzbqDO4KKjTB3VlWGwqKeCoxs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=W6KCe4MX; arc=fail smtp.client-ip=40.107.20.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R9FnCWAxYB+4j9kHcaxPnHA+OChgS2Tnqg2TOgdAoW1U/IUltwegbrpM00lbGthNP2FhlxZV/CBMgW0rNzrwVt8Q/DKze+cm1hylSf4Dbqlhv5TkvzoFDGaHix9PgZuiJFLiruJ62PtAKuP9QsAaoWPUnXLlIVAlfVqltAblxgz2+PmyzNu6WpULGbaBiYg18NusfUCycebD/8Y+E6Hcg5oiBcbIkfDUw5BIwSzvb9ySIY4/NpdGEuaAzJgcksYNzEJhWILIZj3fKIa+ZN8FNAqA8k/L5HSEItRlmABtMWU+GRmo6DDFDLYnSN/MBLFETGcDVJClsTax+bPFd2cgWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f58VkIooV+K02zBEqd790A5GThYDvD/e2GwYHfRCS80=;
 b=jYq+U8CK68E1BzVoBlAWfhm7cNGtnu7HEWwouJG5/g6Mz4PM71fJONGl7FqeqgxsimUJ+/0LmUQ1IDuXw9SXT41eLFYqSR5UzvydGhYPGFb/7+9yCUzR8YlW3ntBrqsvEcDmWfp76YAqFIjwMltCwLpJ6lOpkAxs7kobcue3bXth2LvsqViB8Qz2vcVxjuRqd+HTJjj7blbiKEo5dBhKPWLZMLUTONiBVhlyPtaMxi4geRM7+aZ4cRITPT/X2CNJ+7vCkBfF5lUBEgBfT5uShiD+Z6z+WH8pjKfNH3i+pbB4JPxJmQv3/CUgTIBmFObCeXJ9/ZNFOkfSNnfuQ3HEVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f58VkIooV+K02zBEqd790A5GThYDvD/e2GwYHfRCS80=;
 b=W6KCe4MXTAUmEwhCGkCrjAN8Y9ou/FNBga9xGQlFd+kdi3LzEIJn29uMLd8oJyqa4bhDOXVz/lCGctE7wDZSInzEnqkUCrFY+RjcRQ9W7g/X8btoqMNgZUmpdy0zDWfaYb++Yc1ziLXn6A+bsu5SXDEMhAgt6uSaCRD9PIhjx5o=
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by AS8PR04MB7653.eurprd04.prod.outlook.com (2603:10a6:20b:299::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.55; Mon, 13 May
 2024 12:18:29 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::baed:1f6d:59b4:957]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::baed:1f6d:59b4:957%5]) with mapi id 15.20.7544.052; Mon, 13 May 2024
 12:18:29 +0000
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
Thread-Index: AQHapNmrkXK8ZZdjQEWnp7p3Tpjf6LGUxN8AgAADp7CAABBFAIAAPKWg
Date: Mon, 13 May 2024 12:18:29 +0000
Message-ID:
 <PAXPR04MB8510867173CB0A11998D875E88E22@PAXPR04MB8510.eurprd04.prod.outlook.com>
References: <20240513015127.961360-1-wei.fang@nxp.com>
 <CANn89i+EQDCFrhC3mN8g2k=KFpaKtrDusgaUo9zBvv0JCw8eYg@mail.gmail.com>
 <PAXPR04MB85100C1A06253C0AE1EB36C288E22@PAXPR04MB8510.eurprd04.prod.outlook.com>
 <CANn89i+0xtG5hg2LsGvNOueCAkOac_UccXWq-Eeqt1a40EkqBA@mail.gmail.com>
In-Reply-To:
 <CANn89i+0xtG5hg2LsGvNOueCAkOac_UccXWq-Eeqt1a40EkqBA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8510:EE_|AS8PR04MB7653:EE_
x-ms-office365-filtering-correlation-id: 8dcf0518-6e58-4683-3f7f-08dc7346cc69
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|366007|1800799015|376005|38070700009;
x-microsoft-antispam-message-info:
 =?utf-8?B?L3JPUjJGYUhmMlBNUFRqNnIvMlV4L1dZYXZpSjlzZVNjQmJIMDQ3ZDhZTWJS?=
 =?utf-8?B?Wk12WlNiZkdVVGE2N0hkL29lUWpZWjVaOTFwY2xNNWNQdW1tTm9icytJYnVU?=
 =?utf-8?B?L091MWVNSlhaTE9DdmJGMEJIcG8rd1g1eE4wUG52Y1VubWtwN1JUT1NTVWpx?=
 =?utf-8?B?ckZ1ZW43aDNySTFQVTd0T3N6Mnh4N21HUGhGTDNnZ0ZCQXdlYXMrenRxbkdr?=
 =?utf-8?B?NEJUbENlUytGVEdiYVBqNUs4Z2RkUEtHanRqZXZ5WmVIUlVaWFhrRUJSTTho?=
 =?utf-8?B?VHYwZjNsOG1mbnlmNWFtLzArNDRWRGVFZXJEVy9xejVreklaNXFadHhOQjZC?=
 =?utf-8?B?Vkd4TXl1SHU2YnhIV2RkWTRoS1J2c1JFNElmeWs4bWdmOWNGYnNsbjNzT3hz?=
 =?utf-8?B?dkg0WmVxVU1XaENMQzdhVVJlRU9qZ1JIY09USFdmZjRRWmUyTnRpSDJsdi9m?=
 =?utf-8?B?NHRJdHJYV0x4WVlHanRvSnF6RnFTZURFaXp0UFJtY3h3TENLUzE4WmtYTTJE?=
 =?utf-8?B?Y3FyTkpNQ1hXZkVpek4vZmQ3UUFwT25KRFo4alkwa3pUcmZhRzRsL1NnSFJI?=
 =?utf-8?B?allwRmNvY3hxMTJzWU85UVk5NUdacmE0ck13Q1ZCQS9UTWRiL1M0dC9ZaUtU?=
 =?utf-8?B?RGhRMm9lNStYeitaZzhZcEJJNVRLRERYdWZiejNPSE4wbUlJcVMyZGtUaHF0?=
 =?utf-8?B?dHZTQm9pc1owajd3eHhwY0w1MTBmQWtIUDR4WHphMm1qdjVLb0lIcnRTWUxJ?=
 =?utf-8?B?QVJMZGc2Q1BzTXJUUHFjeHdFSEZqSmR6ZVhkK2lVZStrU0dZMGRXZEtKbUVr?=
 =?utf-8?B?ZE5PZnU0a1dmb0xvRVIxTmVSME9ibG15YU5ZYmw5Y3B6Q3BtUzJJZWFLaUN0?=
 =?utf-8?B?SHlkNmtEMldYQVZGdGtLVC9vTExYV3UzTVBlOXpieE9STE5ZcHRMZmpzYTg2?=
 =?utf-8?B?UmRIcWdOY3V2Ny9kdlJkRUxtYjF6ZXJXYXJnRHZzWDh3QWNpR0NaT3FTa1NM?=
 =?utf-8?B?bXowV1Yzak1pNHFvQnBnZW9kMTdIS1BtZU1sOG1EL250dUh0TnoyMTg1SDZz?=
 =?utf-8?B?WGVHclpoVy9JZkNUekYrZ3RUcURqWnRxM3lyK1lIdVdsTVRoUEVodHQ1ZW9v?=
 =?utf-8?B?Y3RVeGF0S0FoUzhkVXpvUGZpUTc3MmFmZW56eGJjWVJ3UGRzUnRXQXppOTZZ?=
 =?utf-8?B?WjVrM2RLUFRTQ1JNai84bXFPbWVMZ09GRGxXWWNncFEyWVBmaDVrbkZPSzdN?=
 =?utf-8?B?emRNbWFVcVVtU0Fob3lZVFpNY2wzM2NmM2JzbnN0bm9CWFZuZ0ZNL29waUpS?=
 =?utf-8?B?Zkl5bExGczVFaWlDQWNTUVIvZ29LQTVWY1FhUWdmYUphOUJpR0FMZ3ZhWGRh?=
 =?utf-8?B?WnRqNVdIRnJqOS9vY3U4UmxTamZDZExiQms1ZE5qTXpUaUlQaEhvVGdPUHR5?=
 =?utf-8?B?ajE2QzlrcXRKU3hhZTRVMUlqakJBeEhQUlFRd0VqV3JsZ2lBQm9oaTB2dWxa?=
 =?utf-8?B?d251aUhjUG8wa3BBaEMvWEJTRDBmSm05UVJwaVExTktGNUVvaXRPTjFQRGl2?=
 =?utf-8?B?VlFKWmNHWGh4QTJYTEVsTCsycHh1TmcrbXVWcHQ0U2ZkZk9XRHJsYXl1RkFF?=
 =?utf-8?B?WUVKaytFTDE2c3FKb3hwbDl3ampYRnk1WXIreDl2MUk5UXY4TWFNcmdCS2dN?=
 =?utf-8?B?WXMwS01abGVwdE40dVFLRmNkV1NpWllGd1BIUDNHQWp4THM2Vks0bmJzRGhs?=
 =?utf-8?B?OFhJR1ZYREc5TmxvYXZsQTU2Sk9aNFJBQVovcVlGdnN2TUt4U1VCUC9zQ09U?=
 =?utf-8?B?ZnhUdE0vRU1aaGp6NG9kdz09?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Sy9YM3RCa01pa0hvdUo5a0txZHRvRFpTaVZoSjhxK3dvS1FMMllWZVRMSXFp?=
 =?utf-8?B?Tk9qd0pTL0J0MHRSNkMvNkpJNlFSMWo0UytEVC9MNSt4cnJLcy95akRwdWhB?=
 =?utf-8?B?L2lpZURzRkZKZ2p4ZzJCOXRueG5veHNPRUc2MjF4MmszdjBmYVhQMmg3MUZy?=
 =?utf-8?B?UGxqV0ptcGgrZUdQSkliQXUreVFSbVN3eGdpNTZoR2ZkRGZyTW45amtwWno0?=
 =?utf-8?B?Z1NIYndtUFpJZVpyQmlmYnlIbFY0Mkttb2NCcjZPb3BKMnFiLzhucFZaRTVi?=
 =?utf-8?B?SUJRajFCOElRVXBkUGNVR1RSaHgycytrS1Vld2xNUFByMXQ1eUhVaXAyZVln?=
 =?utf-8?B?akMxa29YREFlc0hQRGE4MHNDNDQrdHdnQzlvR2FjOFhEaHd2dmw5ZHdGRlRJ?=
 =?utf-8?B?YWE5OForS2xWUFljd2ZCakdyQU9UeFphY2REZHU1NVZjclRTUmtreFdlNkR2?=
 =?utf-8?B?aSt1NWlSWTVRYU9waTQwMzk2VmtqTDdvQ3lsOVFrdjR5VUZNOHROTHpORjFy?=
 =?utf-8?B?UmVHbitCS2NqbHNsV0lDV2YwWnluemxUT3BrRjczSGhGd0NZZXNTaGxMZlJ6?=
 =?utf-8?B?MmcxbHVNN1UwdTA2djkzbW5MWkpnaWQ1OWpuSnRnL3NRb0VsMEtOQXhzdzBG?=
 =?utf-8?B?UCtscThrM01yR1owc1h6OStreE9McmJzNWVMeGUreHY5VXFvTWY4Vm5HMzlF?=
 =?utf-8?B?YUY1aWhtcWVFZEdMcWNXcFBQbTdOaUpDZEZMR2hlWmVrakpqYXN6ajlUUmhw?=
 =?utf-8?B?K1ZJY1dqUEkxV1BUNnd3VVVJNFlYODRQOFYvN3ZYUlN4dEIySFVvSG1iTHJo?=
 =?utf-8?B?RE51alk0MWxSOHdUNGgzZTh5YzJGbENYemswYVZBQTFnVkUzOHFwcnVnYTVC?=
 =?utf-8?B?TStJTTNZcUhPbEZ0QmEzK1pRclJrdkwzU2tXNmJHeWZHaGg0YkNqYVhvdzFy?=
 =?utf-8?B?Sk9ZTlJpNDhEVVdjcjRXd091aUpWVXpIT2FHREtDb084TFVhTmt4M3h1dEkx?=
 =?utf-8?B?Ti9TbU4wTDBUMktmZHkrM0JYN09NajExcWE2SlJ1cjNMa0V0empVOWNQbGxH?=
 =?utf-8?B?M2lvOTEvSGp3MGg5WXU4Mjh5MGlFMGRVdXZFWG5TYk84L045Z0NmeThvTmhU?=
 =?utf-8?B?cW14K3lvdVBFRkViamhxYmJuWE1Xc1lZWDFzM0FrOG9kbVBQS2xVSVBkSTdJ?=
 =?utf-8?B?Q05wYzF5K0tQOStMUHF1THhUZUY1c1Q2UTU0VkhBOFN2dUl4NkMyNW9Nd25L?=
 =?utf-8?B?UGlyOWFnbzgvL28ydlkzZ1ZVMy9HVmVpVjJhZFZSZG1VZDBFSE56cVFqcXFW?=
 =?utf-8?B?WFppcUExOVJWSi9nV20zVjdJNExDN0RBUndsWjU4alhmYUlNUmtldDNyVVMy?=
 =?utf-8?B?UHRFLy9LOVdQMkZpTDZZdStqVkUySmFtSXZzV0NLU0hYYy9Yc3lMTU5raGFw?=
 =?utf-8?B?bnkxV0YxMDU0MDVuTk5kUUZoWmphdnk4Z2RSclBrRUx5QW1pa2NzM1VsQ21K?=
 =?utf-8?B?bE83cjUvc3NxYnRVSDV5WWRKQStweVF2NFNuVmZNTStVTmR6VWNkUm5Rcmxz?=
 =?utf-8?B?UHRENGZHTE5ROGlqZnk5NXNJSytSQy83ZlVQKy9YUE9uSkdNOGpvdE5wVjV6?=
 =?utf-8?B?eEgxZ3R0OTVBYkdXaTErcTdMMlNPYzIvQ1lmRGphUUpYTWtpdjVuaVVTQWxC?=
 =?utf-8?B?SG55VE8ySHZRWGMwVmpaaFpNbXYwWXU2aFB0WXdONUIyZFJJekFNTXJSejFw?=
 =?utf-8?B?bHZWVWZiVnU2YWUwbFBZeUpzL0pOcStmUnRPa0FLQnAyMTNmaGVEcE1zcTRn?=
 =?utf-8?B?NkwreDR3Q280bjY4eUtEZVBQY1pmeEZlaG5lcyt1R1VQQUp3eDQ4WkRPK2Zm?=
 =?utf-8?B?N3hPWTh4T0RMN2NxM0c2YXUxV2dCT01ucUtRa1lPeS82eUdVekFZeUlJTE5O?=
 =?utf-8?B?R0VWK3J1dCtlYnlqaGF6bFd0NUorbUFCeHYzb0M1aDlXSW51YmU0Nk81WG01?=
 =?utf-8?B?azFoYjBPYmtGSldmSC9QSkpFK1drVGRxMStNaDAvd2ZmVE13aFFOeU82QkU1?=
 =?utf-8?B?Z0F0bktNRGp1MnVvbzJxRzNxZEJkNkJqc3djYVlHZFl6SVNFYmptejNrbS9T?=
 =?utf-8?Q?OdPI=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 8dcf0518-6e58-4683-3f7f-08dc7346cc69
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 May 2024 12:18:29.4035
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BYsdrwZqkJxQZtTKqtDGoy7dg4vks3m6KvAJ8yDm9Q6hUgZ6ThjkS5p+CoYIJW7Ue+iCo/FOOTnykf79LmfLeg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7653

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBFcmljIER1bWF6ZXQgPGVkdW1h
emV0QGdvb2dsZS5jb20+DQo+IFNlbnQ6IDIwMjTlubQ15pyIMTPml6UgMTY6NDENCj4gVG86IFdl
aSBGYW5nIDx3ZWkuZmFuZ0BueHAuY29tPg0KPiBDYzogZGF2ZW1AZGF2ZW1sb2Z0Lm5ldDsga3Vi
YUBrZXJuZWwub3JnOyBwYWJlbmlAcmVkaGF0LmNvbTsgU2hlbndlaQ0KPiBXYW5nIDxzaGVud2Vp
LndhbmdAbnhwLmNvbT47IENsYXJrIFdhbmcgPHhpYW9uaW5nLndhbmdAbnhwLmNvbT47DQo+IHJp
Y2hhcmRjb2NocmFuQGdtYWlsLmNvbTsgYW5kcmV3QGx1bm4uY2g7IG5ldGRldkB2Z2VyLmtlcm5l
bC5vcmc7DQo+IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IGlteEBsaXN0cy5saW51eC5k
ZXYNCj4gU3ViamVjdDogUmU6IFtQQVRDSCBuZXRdIG5ldDogZmVjOiBhdm9pZCBsb2NrIGV2YXNp
b24gd2hlbiByZWFkaW5nDQo+IHBwc19lbmFibGUNCj4gDQo+IE9uIE1vbiwgTWF5IDEzLCAyMDI0
IGF0IDk6NTPigK9BTSBXZWkgRmFuZyA8d2VpLmZhbmdAbnhwLmNvbT4gd3JvdGU6DQo+ID4NCj4g
PiA+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+ID4gPiBGcm9tOiBFcmljIER1bWF6ZXQg
PGVkdW1hemV0QGdvb2dsZS5jb20+DQo+ID4gPiBTZW50OiAyMDI05bm0NeaciDEz5pelIDE1OjI5
DQo+ID4gPiBUbzogV2VpIEZhbmcgPHdlaS5mYW5nQG54cC5jb20+DQo+ID4gPiBDYzogZGF2ZW1A
ZGF2ZW1sb2Z0Lm5ldDsga3ViYUBrZXJuZWwub3JnOyBwYWJlbmlAcmVkaGF0LmNvbTsNCj4gU2hl
bndlaQ0KPiA+ID4gV2FuZyA8c2hlbndlaS53YW5nQG54cC5jb20+OyBDbGFyayBXYW5nDQo+IDx4
aWFvbmluZy53YW5nQG54cC5jb20+Ow0KPiA+ID4gcmljaGFyZGNvY2hyYW5AZ21haWwuY29tOyBh
bmRyZXdAbHVubi5jaDsgbmV0ZGV2QHZnZXIua2VybmVsLm9yZzsNCj4gPiA+IGxpbnV4LWtlcm5l
bEB2Z2VyLmtlcm5lbC5vcmc7IGlteEBsaXN0cy5saW51eC5kZXYNCj4gPiA+IFN1YmplY3Q6IFJl
OiBbUEFUQ0ggbmV0XSBuZXQ6IGZlYzogYXZvaWQgbG9jayBldmFzaW9uIHdoZW4gcmVhZGluZw0K
PiA+ID4gcHBzX2VuYWJsZQ0KPiA+ID4NCj4gPiA+IE9uIE1vbiwgTWF5IDEzLCAyMDI0IGF0IDQ6
MDLigK9BTSBXZWkgRmFuZyA8d2VpLmZhbmdAbnhwLmNvbT4NCj4gd3JvdGU6DQo+ID4gPiA+DQo+
ID4gPiA+IFRoZSBhc3NpZ25tZW50IG9mIHBwc19lbmFibGUgaXMgcHJvdGVjdGVkIGJ5IHRtcmVn
X2xvY2ssIGJ1dCB0aGUNCj4gPiA+ID4gcmVhZCBvcGVyYXRpb24gb2YgcHBzX2VuYWJsZSBpcyBu
b3QuIFNvIHRoZSBDb3Zlcml0eSB0b29sIHJlcG9ydHMNCj4gPiA+ID4gYSBsb2NrIGV2YXNpb24g
d2FybmluZyB3aGljaCBtYXkgY2F1c2UgZGF0YSByYWNlIHRvIG9jY3VyIHdoZW4NCj4gPiA+ID4g
cnVubmluZyBpbiBhIG11bHRpdGhyZWFkIGVudmlyb25tZW50LiBBbHRob3VnaCB0aGlzIGlzc3Vl
IGlzDQo+ID4gPiA+IGFsbW9zdCBpbXBvc3NpYmxlIHRvIG9jY3VyLCB3ZSdkIGJldHRlciBmaXgg
aXQsIGF0IGxlYXN0IGl0IHNlZW1zDQo+ID4gPiA+IG1vcmUgbG9naWNhbGx5IHJlYXNvbmFibGUs
IGFuZCBpdCBhbHNvIHByZXZlbnRzIENvdmVyaXR5IGZyb20gY29udGludWluZw0KPiB0byBpc3N1
ZSB3YXJuaW5ncy4NCj4gPiA+ID4NCj4gPiA+ID4gRml4ZXM6IDI3OGQyNDA0Nzg5MSAoIm5ldDog
ZmVjOiBwdHA6IEVuYWJsZSBQUFMgb3V0cHV0IGJhc2VkIG9uDQo+ID4gPiA+IHB0cA0KPiA+ID4g
PiBjbG9jayIpDQo+ID4gPiA+IFNpZ25lZC1vZmYtYnk6IFdlaSBGYW5nIDx3ZWkuZmFuZ0BueHAu
Y29tPg0KPiA+ID4gPiAtLS0NCj4gPiA+ID4gIGRyaXZlcnMvbmV0L2V0aGVybmV0L2ZyZWVzY2Fs
ZS9mZWNfcHRwLmMgfCA4ICsrKysrLS0tDQo+ID4gPiA+ICAxIGZpbGUgY2hhbmdlZCwgNSBpbnNl
cnRpb25zKCspLCAzIGRlbGV0aW9ucygtKQ0KPiA+ID4gPg0KPiA+ID4gPiBkaWZmIC0tZ2l0IGEv
ZHJpdmVycy9uZXQvZXRoZXJuZXQvZnJlZXNjYWxlL2ZlY19wdHAuYw0KPiA+ID4gPiBiL2RyaXZl
cnMvbmV0L2V0aGVybmV0L2ZyZWVzY2FsZS9mZWNfcHRwLmMNCj4gPiA+ID4gaW5kZXggMTgxZDli
ZmJlZTIyLi44ZDM3Mjc0YTNmYjAgMTAwNjQ0DQo+ID4gPiA+IC0tLSBhL2RyaXZlcnMvbmV0L2V0
aGVybmV0L2ZyZWVzY2FsZS9mZWNfcHRwLmMNCj4gPiA+ID4gKysrIGIvZHJpdmVycy9uZXQvZXRo
ZXJuZXQvZnJlZXNjYWxlL2ZlY19wdHAuYw0KPiA+ID4gPiBAQCAtMTA0LDE0ICsxMDQsMTYgQEAg
c3RhdGljIGludCBmZWNfcHRwX2VuYWJsZV9wcHMoc3RydWN0DQo+ID4gPiBmZWNfZW5ldF9wcml2
YXRlICpmZXAsIHVpbnQgZW5hYmxlKQ0KPiA+ID4gPiAgICAgICAgIHN0cnVjdCB0aW1lc3BlYzY0
IHRzOw0KPiA+ID4gPiAgICAgICAgIHU2NCBuczsNCj4gPiA+ID4NCj4gPiA+ID4gLSAgICAgICBp
ZiAoZmVwLT5wcHNfZW5hYmxlID09IGVuYWJsZSkNCj4gPiA+ID4gLSAgICAgICAgICAgICAgIHJl
dHVybiAwOw0KPiA+ID4gPiAtDQo+ID4gPiA+ICAgICAgICAgZmVwLT5wcHNfY2hhbm5lbCA9IERF
RkFVTFRfUFBTX0NIQU5ORUw7DQo+ID4gPiA+ICAgICAgICAgZmVwLT5yZWxvYWRfcGVyaW9kID0g
UFBTX09VUFVUX1JFTE9BRF9QRVJJT0Q7DQo+ID4gPg0KPiA+ID4gV2h5IGFyZSB0aGVzZSB3cml0
ZXMgbGVmdCB3aXRob3V0IHRoZSBzcGlubG9jayBwcm90ZWN0aW9uID8NCj4gPiBGb3IgZmVjIGRy
aXZlciwgdGhlIHBwc19jaGFubmVsIGFuZCB0aGUgcmVsb2FkX3BlcmlvZCBvZiBQUFMgcmVxdWVz
dA0KPiA+IGFyZSBhbHdheXMgZml4ZWQsIGFuZCB0aGV5IHdlcmUgYWxzbyBub3QgcHJvdGVjdGVk
IGJ5IHRoZSBsb2NrIGluIHRoZQ0KPiA+IG9yaWdpbmFsIGNvZGUuDQo+IA0KPiBJZiB0aGlzIGlz
IHRoZSBjYXNlLCBwbGVhc2UgbW92ZSB0aGlzIGluaXRpYWxpemF0aW9uIGVsc2V3aGVyZSwgc28g
dGhhdCB3ZSBjYW4gYmUNCj4gYWJzb2x1dGVseSBzdXJlIG9mIHRoZSAgY2xhaW0uDQo+IA0KQWNj
ZXB0LCB0aGFua3MNCg0KDQo+IEkgc2VlIGZlcC0+cmVsb2FkX3BlcmlvZCBiZWluZyBvdmVyd3Jp
dHRlbiBpbiB0aGlzIGZpbGUsIEkgZG8gbm90IHNlZSBjbGVhcg0KPiBldmlkZW5jZSB0aGlzIGlz
IGFsbCBzYWZlLg0K

