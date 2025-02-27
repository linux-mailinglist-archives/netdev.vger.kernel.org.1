Return-Path: <netdev+bounces-170341-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BD9AA48463
	for <lists+netdev@lfdr.de>; Thu, 27 Feb 2025 17:12:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E3A2B18924C8
	for <lists+netdev@lfdr.de>; Thu, 27 Feb 2025 16:07:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7F961B982C;
	Thu, 27 Feb 2025 16:01:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="adRi5tFM"
X-Original-To: netdev@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2087.outbound.protection.outlook.com [40.107.20.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A95331B6D11;
	Thu, 27 Feb 2025 16:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740672095; cv=fail; b=oa2EaFBxcFkVAsh8QS2OHkZZud3HSiJY8Dz4Iro6PnbCcFgLpIW8AnaYqTmqo+tAnoadlnwULPz/ipsKvpQKz6wIXtHRA8YDpkJLt6u9RlCi/yPbrPEAfT/abRGslMiik+7qaOsyiiU7OssH91xa1p/h7oYSCZwG4aOGg4PRB4Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740672095; c=relaxed/simple;
	bh=D6G38t2+gyGfHIr9jb80oFhs+nzd/fSqSocaP2fWc9c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=KwuhXtkJF/yVZFe0d76qltkg2dZCGtiygSmDyo2TEN9jyUnPTxBuw6GLj03fUvGG+HHkpUwiWvdCXrc6Puwx3FWw8rCdJGuaDxIaqBMbU2j7nFxS0zYQEJlS+srPWaJ8tiBv/2QAziHQqnTuzsO+fyo5eZERd6BArLxEE1R82NY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=adRi5tFM; arc=fail smtp.client-ip=40.107.20.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=p5L6FvoKkDPUCS9SgfRYNHFkRgbZtBxkXpcVe6Q2SLTnyTh7xHPpk2mD9XkpcpRTH15djWOKRfwimH3/SYMt5kj0btzSFQQMI26TT4H+ToofLrc6/6s6IwrYHKtFHfDQf5mhAifDlcs8aF3AdZBlYdYNXmaktEle958uHtLZsBETFt/uWGauxMMD2Un1AWIUv5TGDLZJ6BGIShOn0OnF4LQJVEUazYzsBxMXYWvZ/PRiCpHSHgO46puhWppQXfRaKUR/x9u+gK+Di4ckxLsOFDbo0K8JkcN5Yy3hBDa+/xit5RQ4RLXCnrYzLK7UwS20vaZw2w1vSI2dQS1m1g5P0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mBnaSNSMCRzlPrRdSI/ml5Nvf874rRR6AmHmEtxxu3o=;
 b=mmfjnxoZhxtfBJfpuqSWsZsF7uuMb1eH0SWnOLzd1RDl2DzyZB1dDeR8naSL3IljZnFlX0ldwiSQNhPVf6lvp13f0AEgWzGYMIfzx0xKo/e7BPg+VQ9K6C9fmzKHpMaN65f4fpnqfU86uxJpTOBLzDBLlrDcDmEKAoe3Mx3HRis3RP2bCWIKhGNXE10iWqtP8kDuWIEUrRCj0GXC2Jh3+FPOxkepUrOpwJaWYeKaScYf4zQTlSA2zzvwjXCFOxW/dKpy1hKTHDTp1Kot5WrjOgGrX121YkPagu0LB7HOyVMCGnFxQSQMizWo5FWCs6WmqRoTeWgrD+pbcr/QtJhY3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mBnaSNSMCRzlPrRdSI/ml5Nvf874rRR6AmHmEtxxu3o=;
 b=adRi5tFMk1o+UFr7dwJiA7ItIiPru1x5Ee0R9kLk+KxVN5PbqdGP/FiTwzuzefyQSPf1/zGF82ZJrJdnJyatEqhhSJwrOxl2+23ahi+I4HulJPPlEHMhRi/R4WLMMKOHl4qGjGfFCQmEj1nF5EQ++2zwUoodjH7KRaMOliQKs2vyS2gIwKvwaMK/pmYCeHeMiX6rGVfOmG4IoemET2ddv8MZMqnjNUORFqqC2vCTeQTFBB5tZrY+vOCDW+S0zp+k5AfikVYLyiUNFeZ8lu3hm8WwW9/g7T2Y9iwXBqPRc7vYYSUbl12XPhuskRL0nGleJwL405YSgYYzSXoyuDilSw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AS8PR04MB8216.eurprd04.prod.outlook.com (2603:10a6:20b:3f2::22)
 by AS4PR04MB9266.eurprd04.prod.outlook.com (2603:10a6:20b:4e1::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.20; Thu, 27 Feb
 2025 16:01:31 +0000
Received: from AS8PR04MB8216.eurprd04.prod.outlook.com
 ([fe80::f1:514e:3f1e:4e4a]) by AS8PR04MB8216.eurprd04.prod.outlook.com
 ([fe80::f1:514e:3f1e:4e4a%5]) with mapi id 15.20.8489.018; Thu, 27 Feb 2025
 16:01:31 +0000
From: Andrei Botila <andrei.botila@oss.nxp.com>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	s32@nxp.com,
	Christophe Lizzi <clizzi@redhat.com>,
	Alberto Ruiz <aruizrui@redhat.com>,
	Enric Balletbo <eballetb@redhat.com>,
	Andrei Botila <andrei.botila@oss.nxp.com>
Subject: [PATCH 2/3] net: phy: nxp-c45-tja11xx: add TJA112X PHY configuration errata
Date: Thu, 27 Feb 2025 18:00:55 +0200
Message-ID: <20250227160057.2385803-3-andrei.botila@oss.nxp.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250227160057.2385803-1-andrei.botila@oss.nxp.com>
References: <20250227160057.2385803-1-andrei.botila@oss.nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AS4P191CA0006.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d5::17) To AS8PR04MB8216.eurprd04.prod.outlook.com
 (2603:10a6:20b:3f2::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8216:EE_|AS4PR04MB9266:EE_
X-MS-Office365-Filtering-Correlation-Id: 0997fac8-bf3b-4e21-c845-08dd57480018
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UU5qM280Qk5ZbnlZams4RFg1UDdLdWl0T0RYYWpBMkF2d1YvRFZYWHkycUdj?=
 =?utf-8?B?ckplQ0M1M1RubjdEaU1WLzJIM0tLZmVvaWlXR3dzMDhlcEpZRTc3TFdReHoy?=
 =?utf-8?B?d3IzejVkWC9Bdm5EdHFPQVd2UEMvMndvL3MwTkxPeXg3T2FITHAyd3FuN0d2?=
 =?utf-8?B?VDF4ZGhQMSt3cmhnRGxiWWNDQ0tYbVgyNEVWZXlUTUR6OERPYVVHbFRTUkJs?=
 =?utf-8?B?Znp3Y1BKdjhxUWZXOTZiM0laVThHVWI0czhkV29NTDhNc2t3Tk5hditOTU1T?=
 =?utf-8?B?V0RaZ1dOZWJUb0FNVUZPNWxEczFOV2FLWXdYYXgvNjg3cGo2TU1ON0FUenAw?=
 =?utf-8?B?WFhjWHBscXZVa3F2YU9UKzBiZEUvVkZBcWNtTTlTZHQ1ZXhJTWhHZ0ViZG9O?=
 =?utf-8?B?UDJydDRpUVp3S2l4V0ZvdXlLU001NDkzOHd4aXRWUWlMdkt1eER3b0gvbVFs?=
 =?utf-8?B?cUVZMGFaVTcvQzNTOGpOVllWR0NacHhXR285b3pTSlVZRWNDOEpHNElaZSta?=
 =?utf-8?B?KzdHNjV5aVpvRklSQ1J2TmdDWE4vYStwekFYcXRRVnFPL0RyUFlOcW9RL2l3?=
 =?utf-8?B?c2JZT1BNV1RGT2duWndPN1pVaWZRNXg5NDl6b3JVY0JGaktEbmFNSTRCRE41?=
 =?utf-8?B?bjUvZnZHSFVZVVN0cVQzK1psZXpCcjZod3dHWUVuT3ZvS3U0eEdMNkVmSTNn?=
 =?utf-8?B?VDY1dTdYcWRKZ2RGclZzWkYrblk3ZUJYZmVxZjZGWUprZVNyK2RpV3JDdGg4?=
 =?utf-8?B?RTR2ZytCYjhLdHYyTDI1Qno2MUxjRlZFclVNcXFTWldrTVVZUWhRV01mNkxh?=
 =?utf-8?B?T01YQ1dTRkJBV2FqRjNIdy82Z2xWWVg2TCtDZzZkOVB6dHhTUndWQkxFV2JZ?=
 =?utf-8?B?b1JBVzFpdG9kOGpkaTNpK0t2dTRKMDFkYnhMdEZlVEU1NFhtVDFxdDRKU25k?=
 =?utf-8?B?OE5MOGhtVGl0VXpGMWl4TFhCWjVidWZrM2VtRzJzc0VjSkREMmc1TWNMVzFO?=
 =?utf-8?B?QWxSdGpmZi85OFRmaU1OZk4rUW93MHdpT0ZSNUZaUkFiR1RINlVtM1JpeGxN?=
 =?utf-8?B?NmJwNXp6S1lXdkVnbjRSeitlTVJxa0NXcndZOTRhaXo2NXJmOURUay9yRFMr?=
 =?utf-8?B?RUt6YmtaeG9pVFpZVGkvL1pLN1hCRGRRc1VnNDlERStNNFdrd3d1QmNFS1g3?=
 =?utf-8?B?SThlcGgxWDg3b09MczEzWkk4dFdvUFRoR250ZjZES0hnaWV2WUZQRGZyNU5p?=
 =?utf-8?B?bGJMeEFETjdkL2ZwMlpMSDQ0OUd1S1JqS2hYL2ZqeVlNRUtEdVhwamV5YmVi?=
 =?utf-8?B?dWRSeThGUi83b1lPd1RrTzgxVStpVVRuaSs3aldpc296Y2YwUFJFaWh4ZEVo?=
 =?utf-8?B?SDVWWlUrNmluV3ZqTk16b2hXTDBpRW11Nm0vczlCcU03aXlZaVJnQU5JTDgr?=
 =?utf-8?B?UVk2K2NvbFRwM0Q1WHhaVUx1amV3NWY3K2FHcEFOZ3JQMkl4SE5Oc0NTYmt0?=
 =?utf-8?B?RytqRWtDdTBwWW1ZQjl5SzAvait4UzZtaGNtc3NwSzNScHhqM0E5UGZXd2Fs?=
 =?utf-8?B?OUhSbzV4RDVTNnJSQlJlSXJhV0JUbkd2M0k5a1JZNVFndVNNckJsRGV4OXpk?=
 =?utf-8?B?bitYNGZIZWxPQUZNTzJSdVNSZU1TTElxaUxzUHZ3Q05STW5FbE1lQWI2QU1K?=
 =?utf-8?B?ZE03ell0dGZBaGJVOTgvZWdXYnk2V3VGbjJpQitZVWtjdkNrZzBDRUFibXlm?=
 =?utf-8?B?VU1RLytReml3akp4Rnp2RGU5dWJaWmtHREYwWkF4emRVeDg1MTRCMUF1SHY0?=
 =?utf-8?B?WU1iOGN2NndyNlRBYVVGZTVDSXRmbktiWnB6UDhzdVJPOXJtZk0xOFZHdDdu?=
 =?utf-8?Q?y0Z2Vg+RWX8iF?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8216.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NDBFTEcybzFRQ3Q3TFNMeWxuUGV2RTBHUkhZSzVzdVlNZ2dMdnBiN2lnQXcv?=
 =?utf-8?B?OGFpSEMzUnNKVDhsczNjcWJtU3UyR2RsZ3lYL25rQnZCT0NSZ2g4QmFaaGVC?=
 =?utf-8?B?RzI5ZnFJZlBzSGoxRXZ1RVRTUjdGaDlDek8xcmozcGpVdkN6cGRRUWxja3lP?=
 =?utf-8?B?azFnOTB0RGl4cW9DRG9Lc3B1RkVOQjcwNmZDVjUzMDBBSkxGSk52LzFBdk03?=
 =?utf-8?B?VFFYbHBLZXBNM1BSbzVNcFdPcHFxeEtFWTdFK2hpOGZYSEJvS0lkd1Y1Qmpu?=
 =?utf-8?B?VGR1cGlSQnFwNTdzSmpVNWFEa2c2ditDNW8yRmdZVGNNNytMTUwvUjZ1aVZN?=
 =?utf-8?B?bU8rNUoxajBxcDZVeUNmNThKa1N0dkxSTWhrK2hJU2YxR0NxOTNCU2R5a2E1?=
 =?utf-8?B?M2EweE1YcDQ0cHRJZFpzWFFnS0taeFYySEIrb280anNDR1lRRGU3ZUxZcHlC?=
 =?utf-8?B?RW15ZlMxaHlDWElha21IYmFiMWZTSW5RVjF5MnRXSmpoWWNZMHB3V2piSkJZ?=
 =?utf-8?B?NGZUVTMxRktpTm4zaWFDRzRTSkgrTGJYc3ZOclRNSDhZWG04MUVnU2xhTkQ2?=
 =?utf-8?B?V240eDBuUyt6bzM1RVdzcC9IL0NQS01uTmJjVkUvd1MxUjZTWFAreVdITTNz?=
 =?utf-8?B?bnMwOFM5US9MUzJrYVM2ZVM3U2pBT2Y5Sk5IWXRLNWZ2ZXhvWWhuSWZxem1w?=
 =?utf-8?B?R3FxclkvK2hST1o1U1NaeTF0Y2s4VFVkWDJ3TGhSeDJIbXJNTDJsZ0Fyc0F2?=
 =?utf-8?B?REVVU0tEaXZMVk04TzVQNWVkMUcwQ3lzUm5LQUFuakJBOGJGTTJMZFozeU5P?=
 =?utf-8?B?b2VOSXZjNThqcTEwYnh3TmFsVGQxUGxKTE41T1lUOUdKU0pSK1V3amdqRzYz?=
 =?utf-8?B?cHVtc1NYUUQybHVZM0tBNTRyRllZUU5XUVhKZG41RzN3bTRqanJjZHVGWWhK?=
 =?utf-8?B?dm9kWkdiQmErY3VJUlZmZnJxNEVncEFhN2hHSlFLRjltc2VRWENpMklKS3dp?=
 =?utf-8?B?NVhSU0NoMFpWMkFZMDN0dUtvSDZheHkrR3J4MGZzMWNYWVdadmFlWUdGdnNN?=
 =?utf-8?B?OXFnTGpLdEhMMDB6SDcxTURFL2gxaW1KNXF5QTUvalplaE9wQWE0ZlFGMjcy?=
 =?utf-8?B?MkZ1ZmdJeHZiNGpSSFpCTzdOa2I0ZEhOeVhPZWRMWnA5TTQvRDBKZ2tDVzBW?=
 =?utf-8?B?YVhFQ1RGSERDMzV6eDZzYWhqWjJmVnlRWkF5SmJWaDJjNkgwaHhXOHZ5NzRo?=
 =?utf-8?B?YXdQbUk0NFBJUzFZUGZqNDF1TjVTdU41TEJMamlwb29ncEFhdC9QRXNudlFM?=
 =?utf-8?B?SDM5cG1WeFlBYktsS0xUQmxvMWZySldxajU5OGhLS2d0Ym1zbXVha2VLcG9z?=
 =?utf-8?B?d1g2amovWHExUGtvU3k2V0VsNVVzV3hvdGdYcDBjc3o1UmlOQ1dSWWUyWXR4?=
 =?utf-8?B?SzlCdlFWOVpUMVAyZnpXYmFiWjVFUE5adTdkblRpS3BvWGJWVEdSRTQ0cy9V?=
 =?utf-8?B?Uy9lelFLcmVTTXJhd1AwcmczemI4VXN5NGFpRDFBWjc4QjVuZ1U2eHl4cFB2?=
 =?utf-8?B?NXN6c3h6RStuUXQyaVMzYWpkN3JWWXBDQnZHdld6UEFCZEVOdm1SQWhkMHdx?=
 =?utf-8?B?akFBZEMrRnB3cjk5ajB1aWRBK0cwby9qbkUxNTZkVlVRdWUwUGM2bHVmaEJs?=
 =?utf-8?B?RjdEWndPZHd6L2o4ZlIySXltOUtuanRQTXNIMWt3a1MxS2p4SElLNVl2cjFk?=
 =?utf-8?B?cG1MeWttV3dUWFk2ZlEvbm9CWjZzb2txeERnL3VJTFM0RWV5NFVYZlJPYklT?=
 =?utf-8?B?UEdOd3ZTbUEwS2Y0UTZYRlBrNjRJbm9ocm9SSEhRZzdVbERUaTBIclVOWEFK?=
 =?utf-8?B?WHJTM0taK1BMRkJDRFNwTnF2QTFuZVIwUkp3blFGeGd3Z1FCT1BPNGhaTGdo?=
 =?utf-8?B?UE54WThUampsMVBzTzVRUHlaOC9rNW5wcVZxcFdXMmc0cC8zYlVLd0lWNnNw?=
 =?utf-8?B?MHgxSFFWTENPcTRKQlNiSGVYY1ZOb0ROdTVvaVZ4Q1ZTMXRVYm0wd3M4ZDVj?=
 =?utf-8?B?cDg2dHZCTk5WNXMwSzRrdlpNTGU2SmdpSzlqNXhoUm00bDF2MEVkVk1lbThs?=
 =?utf-8?Q?rorniR4SfRqzgsmdBuXvB/2zj?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0997fac8-bf3b-4e21-c845-08dd57480018
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8216.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2025 16:01:30.9192
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: S+33ZUGi06YBMpZPJ5402mrMu9HUzvbUPcrs10CDk3SLS8zyxtED3ffMQ9y+IT+2RXqtnVhNOhHq8XfASc6eDg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR04MB9266

The most recent sillicon versions of TJA1120 and TJA1121 can achieve
full silicon performance by putting the PHY in managed mode.

It is necessary to apply this SMI write sequence before link
gets established. Application of this fix is required after restart
of device and wakeup from sleep.

Signed-off-by: Andrei Botila <andrei.botila@oss.nxp.com>
---
 drivers/net/phy/nxp-c45-tja11xx.c | 52 +++++++++++++++++++++++++++++++
 1 file changed, 52 insertions(+)

diff --git a/drivers/net/phy/nxp-c45-tja11xx.c b/drivers/net/phy/nxp-c45-tja11xx.c
index 244b5889e805..2607289b4cd3 100644
--- a/drivers/net/phy/nxp-c45-tja11xx.c
+++ b/drivers/net/phy/nxp-c45-tja11xx.c
@@ -24,6 +24,11 @@
 /* Same id: TJA1120, TJA1121 */
 #define PHY_ID_TJA_1120			0x001BB031
 
+#define VEND1_DEVICE_ID3		0x0004
+#define TJA1120_DEV_ID3_SILICON_VERSION	GENMASK(15, 12)
+#define TJA1120_DEV_ID3_SAMPLE_TYPE	GENMASK(11, 8)
+#define DEVICE_ID3_SAMPLE_TYPE_R	0x9
+
 #define VEND1_DEVICE_CONTROL		0x0040
 #define DEVICE_CONTROL_RESET		BIT(15)
 #define DEVICE_CONTROL_CONFIG_GLOBAL_EN	BIT(14)
@@ -1595,6 +1600,50 @@ static int nxp_c45_set_phy_mode(struct phy_device *phydev)
 	return 0;
 }
 
+/* Errata: ES_TJA1120 and ES_TJA1121 Rev. 1.0 — 28 November 2024 Section 3.1 */
+static void nxp_c45_tja1120_errata(struct phy_device *phydev)
+{
+	int silicon_version, sample_type;
+	bool macsec_ability;
+	int phy_abilities;
+	int ret = 0;
+
+	ret = phy_read_mmd(phydev, MDIO_MMD_VEND1, VEND1_DEVICE_ID3);
+	if (ret < 0)
+		return;
+
+	sample_type = FIELD_GET(TJA1120_DEV_ID3_SAMPLE_TYPE, ret);
+	if (sample_type != DEVICE_ID3_SAMPLE_TYPE_R)
+		return;
+
+	silicon_version = FIELD_GET(TJA1120_DEV_ID3_SILICON_VERSION, ret);
+
+	phy_abilities = phy_read_mmd(phydev, MDIO_MMD_VEND1,
+				     VEND1_PORT_ABILITIES);
+	macsec_ability = !!(phy_abilities & MACSEC_ABILITY);
+	if ((!macsec_ability && silicon_version == 2) ||
+	    (macsec_ability && silicon_version == 1)) {
+		/* TJA1120/TJA1121 PHY configuration errata workaround.
+		 * Apply SMI sequence before link up.
+		 */
+		if (!macsec_ability) {
+			phy_write_mmd(phydev, MDIO_MMD_VEND1, 0x01F8, 0x4b95);
+			phy_write_mmd(phydev, MDIO_MMD_VEND1, 0x01F9, 0xf3cd);
+		} else {
+			phy_write_mmd(phydev, MDIO_MMD_VEND1, 0x01F8, 0x89c7);
+			phy_write_mmd(phydev, MDIO_MMD_VEND1, 0x01F9, 0x0893);
+		}
+
+		phy_write_mmd(phydev, MDIO_MMD_VEND1, 0x0476, 0x58a0);
+
+		phy_write_mmd(phydev, MDIO_MMD_PMAPMD, 0x8921, 0xa3a);
+		phy_write_mmd(phydev, MDIO_MMD_PMAPMD, 0x89F1, 0x16c1);
+
+		phy_write_mmd(phydev, MDIO_MMD_VEND1, 0x01F8, 0x0);
+		phy_write_mmd(phydev, MDIO_MMD_VEND1, 0x01F9, 0x0);
+	}
+}
+
 static int nxp_c45_config_init(struct phy_device *phydev)
 {
 	int ret;
@@ -1611,6 +1660,9 @@ static int nxp_c45_config_init(struct phy_device *phydev)
 	phy_write_mmd(phydev, MDIO_MMD_VEND1, 0x01F8, 1);
 	phy_write_mmd(phydev, MDIO_MMD_VEND1, 0x01F9, 2);
 
+	if (phydev->drv->phy_id == PHY_ID_TJA_1120)
+		nxp_c45_tja1120_errata(phydev);
+
 	phy_set_bits_mmd(phydev, MDIO_MMD_VEND1, VEND1_PHY_CONFIG,
 			 PHY_CONFIG_AUTO);
 
-- 
2.48.1


