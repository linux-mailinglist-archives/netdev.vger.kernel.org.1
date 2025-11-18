Return-Path: <netdev+bounces-239679-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 694AEC6B57D
	for <lists+netdev@lfdr.de>; Tue, 18 Nov 2025 20:05:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 63CA535C8D9
	for <lists+netdev@lfdr.de>; Tue, 18 Nov 2025 19:05:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D2302DC333;
	Tue, 18 Nov 2025 19:05:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="VOYKzFZK"
X-Original-To: netdev@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013015.outbound.protection.outlook.com [40.107.159.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7678E27B4E1;
	Tue, 18 Nov 2025 19:05:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763492753; cv=fail; b=Fy93aYHANJDvvHTEpBdQ9ld69VWIeWzqhBQRp57JAYYLn1vn30HlyGa8flwi+mUNyGkdxoxlz0d2JOiCQ83Uv3DIAUzJs/ZPQ16//6c2Fg3SVoTITnq0rX8ErYBGRJEBEhRba+QitC0C6sAHVUs+ZFRuXEnWKY1YU+5/IilWvis=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763492753; c=relaxed/simple;
	bh=TqICrTgn5xI4xJSoHrkTSoOE01tel/kozpIusZoFcZE=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=CL7IrLIm7cUgS0EUVBWPAUK6HHyr7oxx+gYfyuOIAqbxmk8dN44qX5wdHSoYDgOmGEUxMaPVooGUvMWIGMp/KfdwuWpx95MgOnJxw2FxhghX3WH6t1DCPmL5ZHY0cFtmuEPrnZ1lQr4AJXhk18NT+h94jQvJP6Oa2pC5LpK1I+M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=VOYKzFZK; arc=fail smtp.client-ip=40.107.159.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=O2jUbiaOCGJnF0eIiPQrJUPo2QMBVpRMVsWAqFDb5OBarRfQ0zxZUc0/LiEFWsSG9Qow9k8C7LrWMa+DqViLWpIONvCCrrsxBAbV+9wDi4MzXpHjyqQhzI3+5SB7F9sPlXJ5EFOZGYYbrls/Lj9Atvd4TQJxkR1PYbYFw64wlsvrtnpjFoo+dTm1+TPFhQaevZ3n2dGISzuEV9s23dkaj1i6+EWkBxv+iGOsjS/FnLEtz2E3ZVX4UzIXslXWeGq3LHSsJgAprVQWr69DAyUKwLFoHGofV4E6tMWajsDtG9OlnE79nMmeL9Zp/V9sje2EGl3KJjdZD0kZpJ+taTCOXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xzBSrKHJgTX3iBCjJsNyOyiLusjjQgb3k1mVYj/ievo=;
 b=c7xhj7N0Vy8yjpf7PeNY755z40lrLgX4YT1wXJIorjy2quRdQYwV6ueL36vLs9l6kBj1acjqmxCnwIm/l87NmhQAtUKflqquhM8K1fh7CvcUPQm2ei8y6oUFGycu6Hu4dInB/1N833YIEvG1GVfl4YxM6qYLbFu02HGfZfkMMbrTY2jQjIgBJdBXK1/qNMB9yVfeOY91tZmbKzqknhTEkh8/emvARKZqilONm5LICNuQvX5m3fhXH7EoZYzdnAP/fgnfODEp2ZQOymwT2r7v+sKMlIgmt1FxMlsltqbBXJE1KkhEHgep/1OpNQeposTqIppPMlGZLZXFhoLY2vNgBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xzBSrKHJgTX3iBCjJsNyOyiLusjjQgb3k1mVYj/ievo=;
 b=VOYKzFZK7daStuFKaKzrSF5KRPHXQgWGreV9LZI4jauPGfp5STsPqOUi2ZotLFCjV/lVHQABUJI1TyoS9WeuUFI6EJZWVumHVmxuX1x9s8VumvHBaD1bZZxebCqeQt51A50CT+1YkNuwIyTAINj5lGIhoF+pYG2mLwnYi2JlJfDb2bVyCRYWRwxk3hQAFWDTTOIqxFDzPrNmEj5PqBtdgR3SB0aat0UGi6Udx4VBXb9EpQpcEZPcyE878flnlt2DKfDKRhqAe3ZWbCIAGHH3aj1LiWLQg9Ukz9Hf9lmTzzmPRBBMFRgGPZ0KJeG0PbaVrwyuxPp+rYtZ14jVeRXFGQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DBBPR04MB7497.eurprd04.prod.outlook.com (2603:10a6:10:204::9)
 by PA4PR04MB7695.eurprd04.prod.outlook.com (2603:10a6:102:e3::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.10; Tue, 18 Nov
 2025 19:05:47 +0000
Received: from DBBPR04MB7497.eurprd04.prod.outlook.com
 ([fe80::503f:b388:6d07:adff]) by DBBPR04MB7497.eurprd04.prod.outlook.com
 ([fe80::503f:b388:6d07:adff%4]) with mapi id 15.20.9343.009; Tue, 18 Nov 2025
 19:05:47 +0000
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: netdev@vger.kernel.org
Cc: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Herve Codina <herve.codina@bootlin.com>,
	Mark Brown <broonie@kernel.org>,
	Serge Semin <fancer.lancer@gmail.com>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Lee Jones <lee@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	devicetree@vger.kernel.org
Subject: [PATCH net-next 00/15] Probe SJA1105 DSA children using MFD and dynamic OF nodes
Date: Tue, 18 Nov 2025 21:05:15 +0200
Message-Id: <20251118190530.580267-1-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM0P190CA0022.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:208:190::32) To DBBPR04MB7497.eurprd04.prod.outlook.com
 (2603:10a6:10:204::9)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DBBPR04MB7497:EE_|PA4PR04MB7695:EE_
X-MS-Office365-Filtering-Correlation-Id: 863040f1-3049-4298-79f0-08de26d57b69
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|10070799003|366016|7416014|376014|52116014|19092799006;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?OGdtemhIcDRvdUkyTUI3Zlo2czZmRFprWjVzallmYkFsamdYZDdHU3ZUaktu?=
 =?utf-8?B?ZmNmN0hGeUZzT0l0VVc5T3gzQUp0aGRJbWJPMityMWJ4eVQ2bHlaejZkY1Fy?=
 =?utf-8?B?U05zMFZjOWNUS2tTNWpxTVlpUW90S01aMGgzQVUzVVkvYWJkMjA1NFArU2lk?=
 =?utf-8?B?b2MxVjF4bXpLbHljRUFkTU40T3FEajRheFA2OHRJTEtLVGdQMktuL1U4RlJC?=
 =?utf-8?B?bVJvM3BrRGlZdjYzZkxBK2srK0NmUDhadWlJR1N0TzhUbE05alhFUzRUUUFB?=
 =?utf-8?B?bXY0OXVaTUZINitUKzdIZDUva0lsQ3Raa3dLR3hienAzS3RjTmdUSE9KMW53?=
 =?utf-8?B?cjY0b2lZQ055YlRMM3AyejVVb1N2UFdFSDZxT3F6ZVBVbXhsRDBydTlWSHJJ?=
 =?utf-8?B?bEx3aGRxOEY1YmFHclNlYkwwdVhJUCtZb2hIUmtTb0JTQnNnU0c5Mk81d3E3?=
 =?utf-8?B?Y3kxdkwxV3FRQkpiaUk1VFRqbTRzK1RoNlExNDRuM0RsTEZocHhXREwxNnIw?=
 =?utf-8?B?dWJ4YlllY3gwN3g4RzBobU9BMmIrTFFZbnNFYnl1aEtRTlJOeUpoQ1Qwdjdn?=
 =?utf-8?B?SzdwZXdMc1Y1dWdGVk1rdmtGQzkxRGMyeW5VWDZVckRGV0RuK25NMzVua041?=
 =?utf-8?B?STlXRnRjMFJoWnM3ZWl6WEpjaDMxeTF1QnZXTEs3UkJUaWZqNnVwVWVMVFFZ?=
 =?utf-8?B?N2oyc1JhclBYZjVvZXVRKzNtQTRCQ0NTRXBoWUZnNElXcS9NOWttWXFyMnNo?=
 =?utf-8?B?THNGS0w2dGtNRnVBTEJmOUlhbElqUFhTelBhQ3oweFFiVE1xUEdyVHJXQ3pH?=
 =?utf-8?B?RXplbzVia1J2RjFIbXBHdGZyT3o1T1duZ2JkUXVCbjJqTnBSTHNOcytCRXBk?=
 =?utf-8?B?cys0U0s4ZytQelFLMXRra21sNTFvN2xmWWhSRk56T1RRVTI4aC9VYnNwTFJS?=
 =?utf-8?B?S0ZhNm9BNTZieko1STNOVWY4SHZmaTR1TzJoeDZYYll4RHBSQWdHQkJvWFJa?=
 =?utf-8?B?SlBNNndxTXc1aTF3UlZFUExlSlk1SHVLSTdzbnRiSkFVaEZvNWZneVZuMktu?=
 =?utf-8?B?a0VqUHpLazd3Q2VoTndpQTdjSXp1aXF3VENOMTJaZHArcVBINFlHVHpJVFBQ?=
 =?utf-8?B?MGhLYXhva09EdDNxc0hwR3Q4WXpsR2orL3NycnFsbG5wUlZPZ0xkYzJDOTlh?=
 =?utf-8?B?VmlFODREcWd0K0ZpQkhnN044WWw0aVdFUEJrcWdsQ09JVFgxcVUzQVJTUWlv?=
 =?utf-8?B?eWw5bCtYYXZQWnI1NjZNMExhWGJnWjRwTEh2SWRMYUY5enRDa3dJby9NOERj?=
 =?utf-8?B?RCtYY1M0eHV4K2kwWnVqUTdneEphSCs3Mk9ZL00ySEw2RGlWNFhadXRVYW40?=
 =?utf-8?B?MSsxTStvZVhKQTRWSVd4WVlnYUYyYW14Q1RQL0c0UVNtRkZ5UDNRdkFlQ3RM?=
 =?utf-8?B?cVFiS0tTS3BQRG1lNnJTMzBrNHpzdkNMZDdXeVZRNjJZVENFbTRlNHNWUzdE?=
 =?utf-8?B?OFBGcmVzVXVHbE13RUZrMTlrN09OR0FRS0JEck54dTNKZk5FNjljeStON0Yx?=
 =?utf-8?B?VnZERDRRbE4wWnM2dTFRNjVhbnZQeVQ5WWlaK2FmTTYrNXV1V2pYLzc3RUNH?=
 =?utf-8?B?ZHlraGluS082YkcyK2tBeGNZVUNtem9neHR1NTRBQXRwRHNEQXFPd0liakhY?=
 =?utf-8?B?NXpacHBVcG1hWDF1cWdYNFBOdEpHbnZVR3ZRR0FDbi9tTm4zWFFPeE1TSXc0?=
 =?utf-8?B?c3R3SndlelBPUzFzMWNiYXVPSkJMQSs5UWtGNURZUnFrSGJJbmM2dUF5RUMx?=
 =?utf-8?B?akt1cXJMTHhwaG9hbFFiYXgzSkhlcDBOcFZoSFBWN1R6eDk3RGptb2ljdzk5?=
 =?utf-8?B?elJhWlhkMWppNjhaYWJkWHl6NzA5RTZHYUFHcUV5ank2ZmZka05zTXdPajhX?=
 =?utf-8?Q?o3ywwL9YQRzfNwo4mkI0HRadl+yZCd1W?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBBPR04MB7497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(10070799003)(366016)(7416014)(376014)(52116014)(19092799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MVd3cmFTRm5FRlpMQVkrYXJqWWFEcFlyQ2xJMERPelIzRmNDYXJSTmRIeHYy?=
 =?utf-8?B?ekVGZC83QlNLWWRjeFEreWZzYnlIMllXeC9nV0lIc0xYV0FHOWhaclFNRUhK?=
 =?utf-8?B?d1BYakxLdUNnSW5NSTRyYStJb25NUHdDSkRDLzVCelFjUGtuVXpYVzBrRGN4?=
 =?utf-8?B?VFRXZ2YyMUIvbFN5TEN6enM2bnQvRUFMZkRkdEFnV2RSenlXRGlWSmV1OWRN?=
 =?utf-8?B?eDVFMHc3UkhzdGZhUUlrTDNNTk5ZcGtQTmFPdzZaU0tjeXhWZmlWeklSak14?=
 =?utf-8?B?V0VRdmFFR0RRZHBSbUIvdXhTSXhzS1IrcnpsWi9hYWdsQUoxdDRESmtWMGxG?=
 =?utf-8?B?RWcrWW4vZ3BqWEhVdE1HaDlqbFdoS24xdlQ5NFI1bTJPZG4xYS9JRlg5S3Bo?=
 =?utf-8?B?WDZTL1pPNHpsV2tOZk0xL3JMMTJadWpVUnJQY1pSN24vUzNYeHBiSkc0ZndS?=
 =?utf-8?B?WVdOWWZhVGM0c0pMSmFQZ3pETitmVmpMOUc2SVBZVmYyL3ZHSVJvV2cyMGs2?=
 =?utf-8?B?dXRWZ1ZhWDZ5RjVPdTNuZ2hFNkNSS2k5L0xrZHFWQ0U5bkdUeVIxRzBEc3BO?=
 =?utf-8?B?d3pBbmwzSmJONTl2WWpFUVBxTmtxaE9YTStHQlJrckttaHJsQ1BpSGlhcDA1?=
 =?utf-8?B?R0hUM1pMdDI0VjlzWW40cmMybzhOMWpJd1NhVVdQNUxZKzNxcWdQb1Y5WUMr?=
 =?utf-8?B?WTJRWDlheXlybHBvaWZOOTVoQ1Y1QktxbXBCWUJzK2U4Rk9NK3JYWDV2Y2sw?=
 =?utf-8?B?Mk1uR3RJNm81eGJSU0ttZWZiejJNZXNQY1RPOUk5M0FSMG9BRFVvOVJKQnRj?=
 =?utf-8?B?V0F6b29UMWdEblZQVTBjQ2lzdFdOc1I1NFQwRm1IL0VvTEVyYURxQXVRb1NG?=
 =?utf-8?B?NTlXQTNuR1FSb1lrdXVlZGthNmI5UHZINGFvQmZXQzlwRTZyTERKYVJrdGNm?=
 =?utf-8?B?ZThZU3hFT3YzTVFVUWsxZjBuQjNrVlJXUUVVUHVPbmQ1Y2NnNGc0SnFzTmwy?=
 =?utf-8?B?TGMwNnQxY05ybmo0SmgyczFDMlVWak1PT3l2VGR3WU1OekNncHZUcGNTYkp4?=
 =?utf-8?B?MXBicStPVmc3K2RPV1VUM3BPQTFoSjVFQy9zNmdDRFoySlkxVXNKUllDQjlI?=
 =?utf-8?B?YkdFVFpzaDVlTjlFRVE2Nmd3UTdpMXErSkJ4aGMxUWZ6dDM5eWl2elhRS0p6?=
 =?utf-8?B?Q3MvS08wTVljVExlS0tIZ3dDQktQZEhHLzQyQVRWYnR0K0VWdXM2ZTNxR0E3?=
 =?utf-8?B?N3dDalh2K0NLUncyclZHVWExWE9ZZTJzSVFKV29JUmhFdU5zK0dJUDZhWWlB?=
 =?utf-8?B?b0VocFlmQUZXZ3R0SFdlK2Rwd0hud095QVJSTDJsVm9EeElSQXgwOEwyd01v?=
 =?utf-8?B?Q0ZRczRTbStZb1BOV3J6NXdZc1liVTllTzVmNVYwUW9YTHFUbzRIeWhxdzV2?=
 =?utf-8?B?blp3V0tkWmg1ZHA3Q3N2QmZvM2FQNkNENnBVdmpydUt2Y0MwZFdFZDJsZzJS?=
 =?utf-8?B?djRXVzlEcHBqSEo3SGQ1L1B4SlNuZHNybFU1SUxibU9jeGRZMk1GNGJKS3RR?=
 =?utf-8?B?QVBHK0FHalFCcm8wNFpmcXB2dUp2RzJzRHZCdVJrVXF5SjQ5MHFpZGtpd2JI?=
 =?utf-8?B?OC9nbmJTc0RFTk5RVFhlc2lMenFpR2tnTW4vVzhFdjM3V25NVldHMlBidnda?=
 =?utf-8?B?cks0eWxIYWZxR1JiYUdCN3QwbUpXK3lEeXVYZjN5emlwcVVIYmpZWjRtUFRt?=
 =?utf-8?B?VEo4SWZMOVR3VHpTWWtNZ2Q1UHI5Y2tDN2JEOHRQcG5vWWZ1MWNZNTg3Zy9M?=
 =?utf-8?B?c2ZOVjgydmd1V1J3YkplSTBDL1MyZFNQM1Q4YThvWWJMdk9RZkFRT1d4TXNw?=
 =?utf-8?B?K1hGMWhYL29xOUhWdXFUdEg0WndxU3kwWVo0K2NGNDkwTjZ6WVVjVWdzOTdh?=
 =?utf-8?B?U3p1MWtHQmJHNWJsZWRWZ3h0SGxzK1FEN2h6TGtoMGlVN210SlRVekJvZkVr?=
 =?utf-8?B?U0NrSEZyUG1aV1Vtbmx3STJnZFRuaU5wSC9Qd3hiZ3Jvc256SWdobUVGa2JK?=
 =?utf-8?B?N1huZnhXSDZZMGs2Y1JoSHQrMjJYM2RmbDJzWGNLWWw1OHRpdWs1VjhHdWdh?=
 =?utf-8?B?WlFUaTRtWnZWWkJaVzdJK29FdTFHRUxCSXF1amh0aUZGWkdlaUVFZGUvNGRw?=
 =?utf-8?Q?YrflgIMBMdEv/fm+LOMF/hI=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 863040f1-3049-4298-79f0-08de26d57b69
X-MS-Exchange-CrossTenant-AuthSource: DBBPR04MB7497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2025 19:05:47.5394
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ni5H9/9vYa25KPm+ZDpyAkrOJXbJFHGGdbiErSD84mXrA7BiL+yUA6MRdJTi6j9gkiN7P/edobXb5XM57/guGg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7695

This series prepares the SJA1105 driver for a goal covered in upcoming
patches: customize the XPCS with extra device tree properties for board
specific settings (specifically lane polarity).

The XPCS handles conversion of internal parallel Ethernet MAC data onto
a SGMII serial interface. This block can be memory-mapped or it can be
accessed over MDIO. Its driver (drivers/net/pcs/pcs-xpcs.c) always
expects it to be on an MDIO bus, so if memory-mapped, the code creates a
fake MDIO bus whose reads and writes go to the memory addresses. Note
that in the case of the SPI-controlled SJA1105 switches, memory-mapped
means accessible through the same device-specific SPI transfer protocol
that reads and writes any other switch register.

The status at present date in this DSA driver is that the XPCS is
implicitly created and used by the driver despite not described in the
device tree at all. The code which creates a fake MDIO bus for the XPCS
is itself a subset of the more general logic implemented in
drivers/net/pcs/pcs-xpcs-plat.c, and the latter already has DT bindings.

So we have to modify SJA1105's DT schema to allow XPCS children, and
modify the XPCS schema to allow SJA1105 compatibles (patch 12/15).

To retain compatibility with XPCS not being described in the device, we
use the dynamic OF API to create implicit XPCS nodes based on resources
hardcoded in the driver, when those nodes are missing (patch 13/15).

To probe the XPCS platform driver using its standard bindings but
adapted to sitting behind a SPI bus, the former needs to be converted
to regmap, as done in patch 11/15, and also needs to be aware of its
specific compatible string (patch 10/15). The SJA1105 also has to
provide a regmap for its child, in patch 05/15.

We use the MFD framework to probe the XPCS children. Actually, the XPCS
bindings want "reg" to denote the base address in the switch address
space, and the DSA ethernet-switch root node is not structured to be
able to provide that (other children need #address-cells = <0>). So we
create an intermediary "regs" node between the top-level ethernet-switch
node and the new ethernet-pcs node. This solves the device tree
hierarchy issue but results in the need for patch 07/15.

To use the MFD framework for XPCS, the SJA1105 driver must be decoupled
with it, interacting only through standard interfaces rather than
accessing it directly. Patch 01/15 replaces sja1105_static_config_reload()
interaction with generic phylink helpers for replaying link events after
a reset. Patch 10/15 and 15/15 obtain a simple phylink_pcs reference in
the SJA1105 driver based on the standard 'pcs-handle' device tree
property (phandle).

The work to use MFD for XPCS triggered a chain reaction where the other
MDIO buses implemented in the SJA1105 driver were also migrated to
standalone drivers and probed using MFD. This is the topic of patches
03/15, 04/15 and 08/15. This helps increase the separation of concerns
and makes the SJA1105 DSA driver more focused on switching stuff.

The rest (patches 02/15, 06/15, 09/15) are minor "glue" changes.

Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Herve Codina <herve.codina@bootlin.com>
Cc: Mark Brown <broonie@kernel.org>
Cc: Serge Semin <fancer.lancer@gmail.com>
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: Lee Jones <lee@kernel.org>
Cc: Rob Herring <robh@kernel.org>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>
Cc: Conor Dooley <conor+dt@kernel.org>
Cc: devicetree@vger.kernel.org

Vladimir Oltean (15):
  net: dsa: sja1105: let phylink help with the replay of link callbacks
  net: mdio-regmap: permit working with non-MMIO regmaps
  net: mdio: add driver for NXP SJA1110 100BASE-T1 embedded PHYs
  net: mdio: add generic driver for NXP SJA1110 100BASE-TX embedded PHYs
  net: dsa: sja1105: prepare regmap for passing to child devices
  net: dsa: sja1105: include spi.h from sja1105.h
  mfd: core: add ability for cells to probe on a custom parent OF node
  net: dsa: sja1105: transition OF-based MDIO drivers to standalone
  net: dsa: sja1105: remove sja1105_mdio_private
  net: pcs: xpcs: introduce xpcs_create_pcs_fwnode()
  net: pcs: xpcs-plat: convert to regmap
  dt-bindings: net: dsa: sja1105: document the PCS nodes
  net: pcs: xpcs-plat: add NXP SJA1105/SJA1110 support
  net: dsa: sja1105: replace mdiobus-pcs with xpcs-plat driver
  net: dsa: sja1105: permit finding the XPCS via pcs-handle

 .../bindings/net/dsa/nxp,sja1105.yaml         |  28 +
 .../bindings/net/pcs/snps,dw-xpcs.yaml        |   8 +
 MAINTAINERS                                   |   2 +
 drivers/mfd/mfd-core.c                        |  11 +-
 drivers/net/dsa/sja1105/Kconfig               |   2 +
 drivers/net/dsa/sja1105/Makefile              |   2 +-
 drivers/net/dsa/sja1105/sja1105.h             |  42 +-
 drivers/net/dsa/sja1105/sja1105_main.c        | 169 +++---
 drivers/net/dsa/sja1105/sja1105_mdio.c        | 507 ------------------
 drivers/net/dsa/sja1105/sja1105_mfd.c         | 293 ++++++++++
 drivers/net/dsa/sja1105/sja1105_mfd.h         |  11 +
 drivers/net/dsa/sja1105/sja1105_spi.c         | 113 +++-
 drivers/net/mdio/Kconfig                      |  21 +-
 drivers/net/mdio/Makefile                     |   2 +
 drivers/net/mdio/mdio-regmap-simple.c         |  77 +++
 drivers/net/mdio/mdio-regmap.c                |   7 +-
 drivers/net/mdio/mdio-sja1110-cbt1.c          | 173 ++++++
 drivers/net/pcs/pcs-xpcs-plat.c               | 146 +++--
 drivers/net/pcs/pcs-xpcs.c                    |  12 +
 drivers/net/phy/phylink.c                     |  75 ++-
 include/linux/mdio/mdio-regmap.h              |   2 +
 include/linux/mfd/core.h                      |   7 +
 include/linux/pcs/pcs-xpcs.h                  |   1 +
 include/linux/phylink.h                       |   5 +
 24 files changed, 1033 insertions(+), 683 deletions(-)
 delete mode 100644 drivers/net/dsa/sja1105/sja1105_mdio.c
 create mode 100644 drivers/net/dsa/sja1105/sja1105_mfd.c
 create mode 100644 drivers/net/dsa/sja1105/sja1105_mfd.h
 create mode 100644 drivers/net/mdio/mdio-regmap-simple.c
 create mode 100644 drivers/net/mdio/mdio-sja1110-cbt1.c

-- 
2.34.1


