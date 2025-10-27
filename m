Return-Path: <netdev+bounces-233149-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id BE630C0D2F3
	for <lists+netdev@lfdr.de>; Mon, 27 Oct 2025 12:39:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 730C24F2DDE
	for <lists+netdev@lfdr.de>; Mon, 27 Oct 2025 11:37:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 328322FB635;
	Mon, 27 Oct 2025 11:37:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="mUOovC8H"
X-Original-To: netdev@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010068.outbound.protection.outlook.com [52.101.69.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20E382FB607;
	Mon, 27 Oct 2025 11:37:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761565068; cv=fail; b=nng065AebrrEo8RFs7WKA4XCStYPEYWfO0r/0jejuihyXwx61t7FIA7cX2VigwVwJcxymRzcsC3CZEtXwwz8+fxbto6PlrBh2Y6VR9kErjG0xwTB1YhlaEycscskgvfxKCSBnJyR9VNlbaqwRma8vE19TaB3T/KkIP48OXjTxFg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761565068; c=relaxed/simple;
	bh=Q4BEKzAPslsayYTsU0rXP/p/8y3Lswj/wtFFQnUKMl0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=QI7B3sPcdsS54Z6kkg/1ikUByJoScCX6Ht+u7DZZCuACFzJjj20dBeDhYsILycxe6NLGaGIbxZWfFbPBPKnrRRMvjfK2B8JoJ1nII4HFkLHAl+cIXarJtutQlX1leQo4WG7/SJ/vx09YCL9cXUm2RMFu4cwBCGT2x2hsbV+oIBs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=mUOovC8H; arc=fail smtp.client-ip=52.101.69.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=poyrf6qVfRMc2nHA7naIXWw4rG/iTUGnxJH5NnhrP/r4yBoU6jKxjalr2lSTHLmbwQI/bZIY5KxsCJ5nabP6nsewEtCHH8FtDMZ39/cBvsv5QIBdchTbClXBjVURyoMRUgTxPw+IZmH2yG+g14Gfsz10gPVBf93xfjRKw9lHqNM6ET6KYsBwVr5nTN5JCJVuTwM9b8uxftEG3Jn9vy+sPgnENt78Yq1wbU4jHAIoLiOdm8Xo3JAv8+NMEuhxXhZ4FJZHrZGUZ21tmL4M/WQFS/IvyhHUyeNiuXzBqMb0lmqwNOIsAXhnuqu5p3RaVxb2sxWf8IGlKaQEm12mn9Vuaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q4BEKzAPslsayYTsU0rXP/p/8y3Lswj/wtFFQnUKMl0=;
 b=dE00rKnCyqnDLQuADLKWq8GjJKTnsVXEjCAAXC2zJ7bm/BKNe/oqVYSVfVmZodwyfyZjOr6HK8Ooc6AxvUDzgV6qwlOYOqzL6/FGjBoy3rBmWDuwLSS7/A5TEU9InSEEzqyQC6gzK05WSyASBtqQnG/3n2s/q5lCuO4XpfInIgdFYSqXQw34dOgjz3rlAxeItHuEy33UwWvsDnlHAt3lXO4fs0u6wNLelCVSQvJ7cSimZUjPrpNsg+ROlMj7VBALKZBo5UvKbHI5Gn7rNKRCR670JLxxXhvfpB2sa9pmU7t+L1cTljw1ybSNTyUKxL7bZ3COyM3LAsU29pWaknK9mw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q4BEKzAPslsayYTsU0rXP/p/8y3Lswj/wtFFQnUKMl0=;
 b=mUOovC8HSsWgfwUH6Kswi2nEiG1xQi7wVrXbM1Dw4sRUzQII6UANTjf45NLRojpA92rbl5Yis9cdRFDeODkANReJOYD/5N3PBOaKvh0l01oL11LWvIx9JFsa8GWe4/ryNbXkJWjKVfALiif5NTeZ+sQvbt2niuT6J/qKxahUcDifAVnBcJQBvyw4t3GX2ns/iCltmz+A0WiPQQMOzgNGVz9UzEI46R01D5EESTft65+DsQtPKYye7hJMsWJtMcT0Km3EoRqyNZhj4S9QfH404ZonK+E+Fq8pTzk10fwwX+csSZojR14NaYW+647/owVSeHL5mw9Lk8g8+0iwo0xGxQ==
Received: from AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:5b6::22)
 by DU0PR10MB6929.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:414::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.18; Mon, 27 Oct
 2025 11:37:43 +0000
Received: from AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::9126:d21d:31c4:1b9f]) by AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::9126:d21d:31c4:1b9f%3]) with mapi id 15.20.9253.017; Mon, 27 Oct 2025
 11:37:43 +0000
From: "Sverdlin, Alexander" <alexander.sverdlin@siemens.com>
To: "daniel@makrotopia.org" <daniel@makrotopia.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: "andrew@lunn.ch" <andrew@lunn.ch>, "olteanv@gmail.com"
	<olteanv@gmail.com>, "robh@kernel.org" <robh@kernel.org>, "lxu@maxlinear.com"
	<lxu@maxlinear.com>, "john@phrozen.org" <john@phrozen.org>,
	"davem@davemloft.net" <davem@davemloft.net>, "yweng@maxlinear.com"
	<yweng@maxlinear.com>, "bxu@maxlinear.com" <bxu@maxlinear.com>,
	"edumazet@google.com" <edumazet@google.com>, "pabeni@redhat.com"
	<pabeni@redhat.com>, "conor+dt@kernel.org" <conor+dt@kernel.org>,
	"fchan@maxlinear.com" <fchan@maxlinear.com>, "ajayaraman@maxlinear.com"
	<ajayaraman@maxlinear.com>, "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
	"hauke@hauke-m.de" <hauke@hauke-m.de>, "horms@kernel.org" <horms@kernel.org>,
	"kuba@kernel.org" <kuba@kernel.org>, "jpovazanec@maxlinear.com"
	<jpovazanec@maxlinear.com>, "linux@armlinux.org.uk" <linux@armlinux.org.uk>
Subject: Re: [PATCH net-next v3 01/12] net: dsa: lantiq_gswip: split into
 common and MMIO parts
Thread-Topic: [PATCH net-next v3 01/12] net: dsa: lantiq_gswip: split into
 common and MMIO parts
Thread-Index: AQHcRtJyU1mfs/d8w0WzKXQFekKhS7TV3pAA
Date: Mon, 27 Oct 2025 11:37:43 +0000
Message-ID: <fecc717a054dda53fd057f3a785f4e7280ec2889.camel@siemens.com>
References: <cover.1761521845.git.daniel@makrotopia.org>
	 <ab056e0761db65483e30c0830ba919c09bc101aa.1761521845.git.daniel@makrotopia.org>
In-Reply-To:
 <ab056e0761db65483e30c0830ba919c09bc101aa.1761521845.git.daniel@makrotopia.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.54.3 (3.54.3-2.fc41) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR10MB6867:EE_|DU0PR10MB6929:EE_
x-ms-office365-filtering-correlation-id: ea430eba-0239-4b90-80f4-08de154d3e0f
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|1800799024|366016|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?TUJkdHpRQ0ticUZLVlF0dFZyRzZkOXJVbzNhcGpPcTVXZko4MzRQTlBxRWh1?=
 =?utf-8?B?ZGN6R1M0YXlrei82Q0kwTmxZN1JER2VzVit3ZlZPMEFYclV5Wmx5OVdTMkxS?=
 =?utf-8?B?SjgzclNJMXZFQW1acncwR21KMk1WV0QyRGVoak01Q05JTWtGMmI4bUFTZGlr?=
 =?utf-8?B?QXVNOFJnbFpqbk5yOXJWcGlabGkyWmI2T0JRMGQzZE5weDBWRmFROUdQZ3dQ?=
 =?utf-8?B?ZFhITHJuczlvdXRxUTg4R3RCOStsRytEK3dTSUFLOGZLa3QrZHBJbUMrQzFV?=
 =?utf-8?B?aytmcGlRU0cyenBobWNZeFF3ZExCUERCUHdpSWgrbVREM0ZpTU01VXp3Rmgw?=
 =?utf-8?B?TEhnVjBuKzMvVS9UTThtQVJrOWR4RUF5NTBNVnVwSHVpcmZqWFh5MW0zbUth?=
 =?utf-8?B?eWwvc0ZObHIzMVZsaDNsQ3MyT0FZWXFpZFhYNEFidkkyRUNDMHdpRVJQNnFw?=
 =?utf-8?B?YmtocWpNZ1FTUlFvK0w2TWJLcW5DRWxydG5pQ0JyNHZCL3BQOXJBSkNhbVA2?=
 =?utf-8?B?MDZqanlMbjcwOWZaNnZmbDlXWmdLUkd2V0xqeFpNQzRaOCtSV2duZ3hRUHRO?=
 =?utf-8?B?UUlrTEFUTW1oY09Ic280NWlqZWFhSHN5cHhhT2QrdVpyNGxyNGVBcmxFUWIx?=
 =?utf-8?B?dDhUN3d6U1hORkxUQTdBdWljbWhCUFVJMWpCTmoxODVJbzFYOHFRTjZ5SitN?=
 =?utf-8?B?eEZyMm1CTjNIbll2YWRjNCtpUXhsbjZRTzMwcU5sOFJ5L25WeGEveHhRbElC?=
 =?utf-8?B?Q0RNTklvNHd5amhDWWxEaTEreG5EcWZZcUhtRE1DVzZCQitMRmVBQ3ZmQmNV?=
 =?utf-8?B?THBSblRvemhNbWNGYVRGTkFVQmQrWTlwVGtpdlRxMXZ1NnR5ZzNrM3NSaFFn?=
 =?utf-8?B?S2FKdFN2eWVkQ2s4ajhMVVZWNzhlMzVGN0E2c1dYWmxES3J0Z3ZUeCsyK3hy?=
 =?utf-8?B?clM2UXFXb0hpN0tjMzRVbkdCSzAvdk1RZG55U0JOKzJkLytYNXlYdjVITHJP?=
 =?utf-8?B?clA0MGs0UUIwbU5RWWs5c3c5Ti9kQzlDOHFZekVLODROem93VDR1cEs5bjFV?=
 =?utf-8?B?TG9wZ3NSUTc0T2tSU1VObkYxNnRSOS8vaXZRaGpqcGVkQmRrOUpXeHgvQXVr?=
 =?utf-8?B?TG1XZm9xK3VMb3JheFR1dGJObDl0TkYxRWhIOGdVY3AvQ2pOWk45cmVkdy9v?=
 =?utf-8?B?eHhDNDBiSVVoOG5jcUVneW1DYlN3UTY3NjFRUmY4YWJEZTdZME1weStSTDBz?=
 =?utf-8?B?dTlTRjFQME5zR3B1VUNFNnplQklYVHNiZDhMeUk0eWFnNzVsQjhJUXRWWE91?=
 =?utf-8?B?aVJESzFTMGlBeGdNOEtxaU1CV3ZoSDVhYTdjM3lkMUxEbVlMWVV6YUxNc2dJ?=
 =?utf-8?B?emI1bnZEK1FhOEIweHZHSEp4Uy82UWtjSnJ1T1ZRS0QwcndXU3poazRkeGVC?=
 =?utf-8?B?UGdJNytoK1NyRnBRamx6WldoZ2p4L0RWR29XSkY5WjJqVkhEdHBQNlN5VDNk?=
 =?utf-8?B?M3VRdEZ3NFJlNjZTK0diTmJUK3REMDlVbFZKSDNzejBDdDY2ZVRPNEcwN0Er?=
 =?utf-8?B?RDYyb1kyVXdJZ2NQYnFsb3krL3lpM01Sd1RMZ1VIUGpwTGdjSmFBTlVEVklo?=
 =?utf-8?B?c2pSSkFXY1ZPNUtJN1FOVncrL0dURDlSWndkVlhIVFB2L0NzbGpnU2hrZGRn?=
 =?utf-8?B?MUI0cjUra01WaGkxOWFmSGZva3FyaVRhUndXSnh0dFM0b2lBcTFhb3Z6dnFH?=
 =?utf-8?B?bWJNZnYvenBaZXNlT205ZGE3RXF0UDh2TlN4Qm8xRkFTZVQrZWR4MGh0NDJE?=
 =?utf-8?B?aFJVQ2tKcDlKYVVURjNUQnJLbzZFVFZmaXUxeXZ1aGY0UXJHUFgxZ05hTWtk?=
 =?utf-8?B?b051SUdZSkJ6RENIczVaUDBXbUovUnIvREt2NjZZcWk2QkNnNlNqQk9aZ29z?=
 =?utf-8?B?SXJGbnFXY3lsSnJ0eFlvcWZTK2h5YlBkdXZyNHdFd0FHTW91R2lsZG5oczVK?=
 =?utf-8?B?am1BYXY5cTdIZW1YUHZySXMwTjNRUVg0MThQYWtwbUpWTWxWb1ZOYTVxNTdB?=
 =?utf-8?Q?tgPl7Y?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Tm9zRHpjdU5VbjdBeUxBNkxNbnY1dGZCYzdzNTN1M0xVNkJra3RzK2FvWEtM?=
 =?utf-8?B?UXl3bmd1aFZtV2Q5eHRPZXJ3V25CdHJHZVhDV0paYXhkWVdpWmpoaHRmTVhn?=
 =?utf-8?B?UVFBYXBXNDJ5Qkc2NURVenkyd3FGTEJmZDdqanhXdXdWSFc5RnhNeHZKVGZT?=
 =?utf-8?B?SWxxWWpyUndXcDlWOC8zQWRzQTJJK2tyWlFRdnVDdVRMelVsNVdiakhxbUw5?=
 =?utf-8?B?eFd5TXpXdi93RUJGQTljeHV6clBjd0RDdjZrd1AzL3d3aUgvbTVMcmhVQTFo?=
 =?utf-8?B?TjRKY1p3ZFNBQlhzVG1OdzdZcFUyMU9ESW4vZUFGN1lLclM3YWNMUzZQWFcz?=
 =?utf-8?B?MHg5Tm5CdHhCNURCRTB1ZFQ0RmZLbFM3WUJDdkttT1BDMi9hL0VRYnNtajJ1?=
 =?utf-8?B?N1RqV0ttL3ZINlppclBJWFJpYmE5bStqTWNqL0VaTzkrMXluaU9RbWdSS1Vu?=
 =?utf-8?B?eFpYMU1iUXNSVXovZVhDdVUvRkJDNDdNUHdFTGdmbzRTV3hRdm00dkRiWTRs?=
 =?utf-8?B?US93Q1VOTS9tanRYMlZ1Y1h6ellCZ2krSjk3dGdnVFYzZ3VVL0tlZGt3SzVC?=
 =?utf-8?B?bTc5OHUxK1UycUsrelhTam4yWndxZ0t3VjZLMTBXTVA5VzdMQjlaMDJvVEw0?=
 =?utf-8?B?ZDV6NlpMUTFoR2ZYUmlKZUYwRktYR0l2V0JwdGdlQlY4c3VvRm83UlNOOXdj?=
 =?utf-8?B?RUZzcWVDamkvY3RFczR3WEY4M29PeXAvcjJnMVZnOWZoZkVtc1JQa2t6NU9h?=
 =?utf-8?B?RDZxM2NiK3BGMGE4Y3hvWkJYMEpLd3Y4OXlTQlBtVEgvdnExNU90blFXbW95?=
 =?utf-8?B?VFN3K1JUUzBaU1QvdWVEWjJ4RS9SMlFEMEt5OWljd0tiakhVcld3TU9KNVQr?=
 =?utf-8?B?SDhVVWJiY2NuMEprZWlpeHNpU0xUUlZ6TytBajlxSVNVK285emlvem5OUTlx?=
 =?utf-8?B?WkVEYlRZOEFUemE3Ykk4UmhMcHppQWoxS1ZVZkM0aDBNZWtrRW1iN2xVQXZS?=
 =?utf-8?B?NFpLY1lQczdodlFuRlBjMDFkeVdRbG9FOGxXYzgrQ245T1lzVUcvdHBtbUdu?=
 =?utf-8?B?MTl4cWxtK2RzaklyQ2ROMlhPYVprd0hHc0pxQ05IdEJzL0drendWYmNLcFR6?=
 =?utf-8?B?dzB0enJKRGl0SU1hWGttK1dxY1pZZ3FvN3hXejMvdThOcmNqVzJNOTBWR2ti?=
 =?utf-8?B?TTRJSWlDNy9pbDBxRFhyMDNMbnE5a1NOVFd5SjhRLzNkcUJUa0pPM1B0UHg0?=
 =?utf-8?B?VnZqYlEzQ1BlSCtmRkVtNXRyMjFWYjNMdjlDTG1XTk5hclI1TXM4V0ZYR3RU?=
 =?utf-8?B?ZnlPRFcxOVRJNmZuM0NFZEZSQTNjUlpnQ1QrYk9oSWxSQ2dxeGJTWkI1clMx?=
 =?utf-8?B?THlEY0U4bTdzbDh6NE94cHFNM2V3KzJveWxRL3R6SDFzTlRGK04zWURvNW04?=
 =?utf-8?B?eFcrWGV6ZURrb2F4ekxndytYKzNrY2l2WEtpbjJDWWZ2YUJtUmRMd1FscVBR?=
 =?utf-8?B?UHlIR0gyTmYrVUNpSHBpb0dsZnMzTXhQc01HZnc3UC9KMmlGeUQwWmFYMXBm?=
 =?utf-8?B?MGpKaTh5MUFQQjBhR0lqd2N1UDhCaTdrOFNCNHBoTnh1ZFlncmhBckFiVk11?=
 =?utf-8?B?d3ZFQ2F1WWZhVEs1OHQzTlpmUUhaU1ZvV3N5V3ZkZUlpUlhHc1dnMEMrL3Vh?=
 =?utf-8?B?RDRxM0taNkx4SEo2aFZxZWhNVUxxRTlHQzVuL2x6WmQ3NzVMMDJwUkZobkgz?=
 =?utf-8?B?RitoUmwxMkxsR21IcnlRZThNajRkcG9iUVcwcjFpSEdORmFvRW1JOTYybXVz?=
 =?utf-8?B?a2pSZlc5MWdTMTNxaEY1TDJoUEtqbTJOYVNaa3BzVmV3VU1EZ05LbWIyRHRS?=
 =?utf-8?B?clNCdS9KVzlPbFRmeXlwWTZGWlZIMHVSanJOZUlLd1BTSDB1Q1hVZWd3eFdO?=
 =?utf-8?B?YUhQNWNQWlhwaFBKL0VzbEd4V3hMcXVNL2FUNGY0Wm1jK25ycVl5WVhTYkdQ?=
 =?utf-8?B?eXVGeHpDQktUaE85V29ZNHhGakF4REpLZmdzU0psUWRwTkJhSGk5MmJVUnhl?=
 =?utf-8?B?TVZGRG0wekJMU09YNTg4MjdvbGdoZm0zdHdXak81bHdvVGxpcGZpcldsdFZB?=
 =?utf-8?B?elJ2Tm1rQ2dnU2tOMU1ieW03SmtIK2lsaFRuWkgxVmpGaTdpNEJSS3RzQ2l4?=
 =?utf-8?Q?CpC1IJPCkC3ppI/gjR9ggHU=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <567CD15EFDF21D42A4E7DC6FB802A79D@EURPRD10.PROD.OUTLOOK.COM>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: ea430eba-0239-4b90-80f4-08de154d3e0f
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Oct 2025 11:37:43.0865
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: m8pxfw6sD8FpWTsj0gfOK2DkO0tu/EFxJOh+zUqCaUyeeEhEWhiagc+F/K72vHC+lrP5P7DVuMkkiJoRaxUPO5+eJUD/Xc5rXUg0f/46Wzo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB6929

SGkgRGFuaWVsLA0KDQpPbiBTdW4sIDIwMjUtMTAtMjYgYXQgMjM6NDMgKzAwMDAsIERhbmllbCBH
b2xsZSB3cm90ZToNCj4gTW92ZSBhbGwgcGFydHMgc3BlY2lmaWMgZm9yIHRoZSBNTUlPL1NvQyBk
cml2ZXIgaW50byBhIG1vZHVsZSBvZiBpdHMgb3duDQo+IHRvIHByZXBhcmUgZm9yIHN1cHBvcnRp
bmcgTURJTy1jb25uZWN0ZWQgc3dpdGNoIElDcy4NCj4gTW9kaWZ5IGdzd2lwX3Byb2JlKCkgZnVu
Y3Rpb25zIGJ5IHNwbGl0dGluZyBpdCBpbnRvIGEgY29tbW9uIGZ1bmN0aW9uDQo+IGdzd2lwX3By
b2JlX2NvbW1vbigpIHdoaWNoIGNvdmVycyBhbGxvY2F0aW5nLCBpbml0aWFsaXppbmcgYW5kIHJl
Z2lzdGVyaW5nDQo+IHRoZSBEU0Egc3dpdGNoLCB3aGlsZSBrZWVwaW5nIHRyYW5zcG9ydC1zcGVj
aWZpYyByZWdtYXAgaW5pdGlhbGl6YXRpb24gYXMNCj4gd2VsbCBhcyBQSFkgZmlybXdhcmUgbG9h
ZGluZyBpbiB0aGUgbmV3IE1NSU8vU29DLXNwZWNpZmljIGdzd2lwX3Byb2JlKCkNCj4gZnVuY3Rp
b24uDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBEYW5pZWwgR29sbGUgPGRhbmllbEBtYWtyb3RvcGlh
Lm9yZz4NCg0KdGhhbmtzIGZvciB0aGUgcGF0Y2ghDQoNClRlc3RlZC1ieTogQWxleGFuZGVyIFN2
ZXJkbGluIDxhbGV4YW5kZXIuc3ZlcmRsaW5Ac2llbWVucy5jb20+DQoNCih3aXRoIEdTVzE0NSkN
Cg0KPiAtLS0NCj4gwqBkcml2ZXJzL25ldC9kc2EvbGFudGlxL0tjb25maWfCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgIHzCoMKgwqAgNiArLQ0KPiDCoGRyaXZlcnMvbmV0L2RzYS9sYW50aXEv
TWFrZWZpbGXCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB8wqDCoMKgIDEgKw0KPiDCoGRyaXZl
cnMvbmV0L2RzYS9sYW50aXEvbGFudGlxX2dzd2lwLmPCoMKgwqDCoMKgwqDCoCB8IDE2MTcgKy0t
LS0tLS0tLS0tLS0tLS0NCj4gwqBkcml2ZXJzL25ldC9kc2EvbGFudGlxL2xhbnRpcV9nc3dpcC5o
wqDCoMKgwqDCoMKgwqAgfMKgwqDCoCA0ICsNCj4gwqBkcml2ZXJzL25ldC9kc2EvbGFudGlxL2xh
bnRpcV9nc3dpcF9jb21tb24uYyB8IDE2MjIgKysrKysrKysrKysrKysrKysrDQo+IMKgNSBmaWxl
cyBjaGFuZ2VkLCAxNjU4IGluc2VydGlvbnMoKyksIDE1OTIgZGVsZXRpb25zKC0pDQo+IMKgY3Jl
YXRlIG1vZGUgMTAwNjQ0IGRyaXZlcnMvbmV0L2RzYS9sYW50aXEvbGFudGlxX2dzd2lwX2NvbW1v
bi5jDQoNCi0tIA0KQWxleGFuZGVyIFN2ZXJkbGluDQpTaWVtZW5zIEFHDQp3d3cuc2llbWVucy5j
b20NCg==

