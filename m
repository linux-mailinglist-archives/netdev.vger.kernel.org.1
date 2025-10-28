Return-Path: <netdev+bounces-233549-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 84837C154ED
	for <lists+netdev@lfdr.de>; Tue, 28 Oct 2025 16:03:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 09BC154001D
	for <lists+netdev@lfdr.de>; Tue, 28 Oct 2025 14:59:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1C5433EB05;
	Tue, 28 Oct 2025 14:58:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="NUELoR7J"
X-Original-To: netdev@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013043.outbound.protection.outlook.com [40.107.162.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD91A33A00C;
	Tue, 28 Oct 2025 14:58:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761663514; cv=fail; b=B0CoKzR/ak/pMzzY6hNsXiGLeKGLREmHM50AqNqPZJPh54KVP/DI8TUDKCmnyoX22GSh5zKaG/97rKs1xu6vwBIdu2EB4RbiFZYua6tL60hlq8M/SyBxpWBsN7+qpYf8rk565xLFxHt0afhxHYPIvC5WVcIKg1eNlK79Bv6Qn+M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761663514; c=relaxed/simple;
	bh=iwGl+18jVLbBbIv/PDLk8CfuZ5vzB111UfqNT/Nknv8=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=V3u+DkqLql9DsTGRa4x13dfLKcIdNmR0A8m0Vcr8+k9Ac0ntjMqlwRxSERMThuO5wGX057gM5nw+9PpnM6EmCzar3P2ZMMvDA3XE4M5s1cMj6EPaEk6l9/kNeEQCvZaK+s8zyab/IJms2BA/Z1cwopm30xJd9EAhu3O6stWDK30=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=NUELoR7J; arc=fail smtp.client-ip=40.107.162.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eZkPvbdPiL6dMgOFbGKYXIxzS1Kv3rA1v6VgkbnRSMZl5BYKJ9dCaXOD9Li0hnCLhM1TED5uu1fkTh20w029azE89qTqlkvT/0V8xJznh/o6h7CdWU6SvkVdGsgH9s67Si3oERXMQX4Zd59k5R8L8OQiask+brbNGlMYn7S26loAzMHczXBIBb9TJtnP9xNsLI9y5qehQPj8ZVpdgO1VytRqJYaYtUAJRHO/UtK4yKdjQjwmBskYxLOwNWRpSnRBvcX+cHNfJM2/DsJHydjRfw7v6XH6oZse76TrDP6DcVZx28k1eVZT3odbxNxw8xsKhKlIFob/Czby5ZoF3h7Y/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T+gNOO8w+lFQz6y56emdNhXguNz5OTRZANTeEbX+1vU=;
 b=kaczGcT17YazLTzkwzphLHsifho6BxhxaW51Pk1/o9z2Bv4Lcmn2yP1+TmjguA5OYPLOizGKDD0iTLDxZqyqWmEffUmQBL13Q1Ul8PnbhCu9g/ZilyvBlcWLntp8BKaXOBMLxjtBkcnVG6iIykWZUw0+mgix/rcaDp2cqZmBtTxabzOyENnyUaQV05fyQLdUm+GIG3hCaJf+OZpwpD0Al6mNUNwrAvR7sKWyHLpmI886yLK4zfRLWUx2icr/V6zqgr13wXNqY3AfK6w1TpI22rak5Y8+c7g/KcWeD6D8pWXx9caQOSOuwUpIhaJI/m4awuq/5LzfDuxEe8Fo4WD4Cw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T+gNOO8w+lFQz6y56emdNhXguNz5OTRZANTeEbX+1vU=;
 b=NUELoR7Jku0xiOsOAWA19MZVQ472VBqZON3JtEqm4eAZYvIFOg5zcIUxdkmIWcnfNfjPblfKSU1VRo3p6UeeU/EZFM6n0ySBpiQ4D+vrAPqoRj68HrkmUZuAHHUIT2OuHyL8aggj415A7y48E2QH6gbpKDWj8+VRhO1eoVZM/A2CyRbjiPLVkoC2t9jtlKBqAj19hY+dcgIFJ3oUf2CKiSdeKuPQaQza/9/YLprPV9Yosd+4NmgXvK9Hy/93xpz5OPAA0SZort5LlnbUElwoWBHhtKKLJPdHc6Inpx2spdQFKlNlZP97VUEkYxhKkCbD4TmvlMp+SfJSnMsGzkvW3g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com (2603:10a6:102:23f::21)
 by DU2PR04MB9097.eurprd04.prod.outlook.com (2603:10a6:10:2f0::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.18; Tue, 28 Oct
 2025 14:58:27 +0000
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15]) by PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15%6]) with mapi id 15.20.9275.011; Tue, 28 Oct 2025
 14:58:27 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Tue, 28 Oct 2025 10:57:54 -0400
Subject: [PATCH 3/4] regmap: i3c: switch to use i3c_xfer from i3c_priv_xfer
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251028-lm75-v1-3-9bf88989c49c@nxp.com>
References: <20251028-lm75-v1-0-9bf88989c49c@nxp.com>
In-Reply-To: <20251028-lm75-v1-0-9bf88989c49c@nxp.com>
To: Guenter Roeck <linux@roeck-us.net>, 
 Jeremy Kerr <jk@codeconstruct.com.au>, 
 Matt Johnston <matt@codeconstruct.com.au>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Mark Brown <broonie@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>, 
 Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org, 
 netdev@vger.kernel.org, linux-i3c@lists.infradead.org, 
 Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1761663488; l=1848;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=iwGl+18jVLbBbIv/PDLk8CfuZ5vzB111UfqNT/Nknv8=;
 b=gck1NoMfUebFP+oF00qXLysN2Rs8lkib3oodEBSQtiJphhKz5sPwKL8Oid7CawcjxW8m8ScGk
 Sm0TZjwSmG+C/EaXA6uVAKK/Nlfk2y2cKnQC4C9VwPjAY5YE8IG9O7G
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: PH7P223CA0007.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:510:338::8) To PAXSPRMB0053.eurprd04.prod.outlook.com
 (2603:10a6:102:23f::21)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXSPRMB0053:EE_|DU2PR04MB9097:EE_
X-MS-Office365-Filtering-Correlation-Id: 44f916ab-afc7-4a6a-73a0-08de16327176
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|19092799006|52116014|1800799024|7416014|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?M1l1M0F0TnVodTFHbFg2ZWJMZzhvYXlmbG8vY2M0S1hTZDJSWitCYTdvWnVn?=
 =?utf-8?B?aFZzQ2pRZ2dXdWJiTkNpTE51TkxKL1k5QkJHckh5cjJmUXkxSVhkZGRuQyts?=
 =?utf-8?B?aENCOUhINzlrUHJwWlE2YlFXaC9Wa0kwRWNUL3VobzdsOGV0SU1uUUs4S2M0?=
 =?utf-8?B?TFFjT1o2b1Q4anY4TlJwMDFyVUFMTi9YTFFlcyt4eTlEWkJBWWZ4RmVEdmlO?=
 =?utf-8?B?NFdLSXJXdzZHc2g1bmVHTUwvaUF3K3pNNGtESFh4TUxjTlZXQlE1c2s0bVhV?=
 =?utf-8?B?eDhRNWY0NmZhMjdNMW9vMVJPVnRCaEJwbDYwUG5nYTN4R29CUjJCSlhKZWlF?=
 =?utf-8?B?SnlQdklmVG1Tc1Fac0Q2V0JaU2EzZ1JPQUVOMUhFSkovaUtsdmhZbmh5TkU2?=
 =?utf-8?B?UXR0S0pwa095TjRnRTJ5MUdDZGI2NmJkaHkrTkQ5cUNnckNCcUZmRklmcGdq?=
 =?utf-8?B?eUg2QXRwYmUxTlhQUXFkRy9TNW9ITFRyRm9yc1Z6Y1ZLZ3c3NTRYZnJUNnZX?=
 =?utf-8?B?U3ozbmFMM0l2SS9OcHJLdFpGWldwVXJKMGpQSVU4SC9qRms4YXpyU0pRVHkw?=
 =?utf-8?B?VnE3ZDNEOUNvRkxXOGNwTG44cGNoV0hVSWZvbmdhZGZGL0FueDB6bGgzTk10?=
 =?utf-8?B?UGNNLy93YkJyRXlRcXVHSnRhTkFLWUg2eENvUWdWdjFlUnBWOWtBR2l5dmI0?=
 =?utf-8?B?d2tmblE0WjI5ZlNSTGV2SVZGNmlSV0FRNVVMdEFOdkNtZThOTUF0bmpBOXB2?=
 =?utf-8?B?T1I1RG9ITUZwNVhsYUxZRlNiN0tLdE1QZG9mNzduS2xiKzhaMUhDMklvYlNm?=
 =?utf-8?B?bDlRK3JnMFRUcDVjaSt5OFZGNysvZnZSYVdzelFkcTFiSGZHQTdoRzhWNCth?=
 =?utf-8?B?a0VWNlIrbTBiMEk1aUVGZmtnT0paWG8yL1B1MGNhaXpTV0xuQzgyWVRoZ1c5?=
 =?utf-8?B?amUvWlBLd2dvUlFtaWliSmpzN24xd1hCQU5xUExzREkvajN2K3dBR08vOG4x?=
 =?utf-8?B?VUJRZ1hEeFdhbG1KdUp0VDQ0OTRrOTBmeW5SOVdwVll0UkdoTjMwTjJmNDQ3?=
 =?utf-8?B?LzFiYXNsWERmdE9TSllhbUpsZ3FjVGkyZDc0NEZncU5WTWZlT280aVptY01R?=
 =?utf-8?B?MllEMWVvZXgrTWw5UUxPY0tOTjNhSkhzRklJQS9XcUdQekhDZFJVWkN1N3lj?=
 =?utf-8?B?emRaYWhxMkJwZm0zZSsyaFZyYVRUZUJKNEFyWS9PaXg3RjE4SER1cGpTazdN?=
 =?utf-8?B?YU5LNmxuNW1MTGt4ZUc4YkhMV2dLQm5VeFdBY3h3R0N1eU1OZnpzd2FzV0li?=
 =?utf-8?B?bUcyTUpiRXJINmNpdGVwaHJ1UXdNR1UzQnRvc2krYU4rZy9xVXJNUTljUm9i?=
 =?utf-8?B?c0pDUHNGT0hqUTVCc3Z6cjUvc2tKM3AvYVNMYTRVVENjcThNVCtHdndqZ0Vv?=
 =?utf-8?B?Y0FFQURRcGFhUUM2U0RwZUtJNjNKc20vYmo4VnVuTWVMQzdERHM3RmV6cnAw?=
 =?utf-8?B?UXVRRU1jUHdxejhjdmowdzRFcGh3c2x1VVViMHNrZmFvWGxsYlBzUkFyeCtq?=
 =?utf-8?B?bWkzMXdGMHBhSmYzWGx3aUw1YVczTXh4bGx5U253WTNOQlg0aURIMUpPY3M4?=
 =?utf-8?B?cE8yd04xeVovbWtLQ29aZHVEb1htZ1NhOXpwNjJGb3Q5bjVndE53RUJPbXBD?=
 =?utf-8?B?Q2V4aW5OUVVJSDgzakE4N0Z5emp3ME5ra3R4QUcvVGJUY3QyVXo1NGM1VDVh?=
 =?utf-8?B?dktveHlBbDBCU2drVlJuN05iL01NOHczWVlDYVhuOFpCVSt2VGJlTVA3Qlk3?=
 =?utf-8?B?ZHlTUzd5anQvbEJKNFpCU0RsVGY4c2R5Y3ExT0VtS2Q5TGNPODVmT2JwMkZq?=
 =?utf-8?B?K25pb2NXQ0VwZTg1VmJzZ21NNmE1MGJuMWtwMWlUcmVLV2krRzZITVdnZmgx?=
 =?utf-8?B?Vm45djhGdDhhc2thVDVzelpOcytIVHdDL0RwMDVGa21MWTU3Qi9tODNQRkx4?=
 =?utf-8?B?NnYrZ2g4b0xaU2FnQmdMQmxkNkdiUDUvd3JWNWY1eXI2WUdBMFB3b0pmOC9K?=
 =?utf-8?B?M3d0VXI5bHV6Uy8yM2UrWHE2Zk5aMU1JNnZlUT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXSPRMB0053.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(19092799006)(52116014)(1800799024)(7416014)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?V2JzOHJ2ZDI3UDdYRFgySzJESmE2UjNCcTlmTGVndDlxcU1Vayt3cTJ4ZlN5?=
 =?utf-8?B?eThtYnN2eTlzeHR2eFpmektqaWdoU3JkcG5TczZUdHQ5bDVsaXV5UXlkWGUx?=
 =?utf-8?B?b3RHd2dLZGtVK2lzSDVmb0RGVmVqYy8rNzlXblJaOGVleWFtMzhSTU5LcEpS?=
 =?utf-8?B?RGpVbUg0N2x1KzlTRHk4VmJ4OXVPd29paXZRNER3elJ1N3ZzNG1EQkZ6TTZB?=
 =?utf-8?B?U1BDeFNYbUpwbDV6OEpkUEN6Wk4zZ2pkT0haZ2Q4aUZrR0VyaDhub04wdlFD?=
 =?utf-8?B?aTdNUnJKTHVxU3U5ZjNuM2JiVzNvbllOdHd1REJQWS9aL05OYWlqcnp1Uk5R?=
 =?utf-8?B?ZXlXK2JaUkRZdW13eVV2dlk0RW1KUWM0TlFadzZyZ2FMOE8xS29WYzB4ZXUr?=
 =?utf-8?B?dlgxRGZsNmR2YzFpKzUybTNHd0ZWNWx0cEd2V1FGbzFJcHg2OW5nK1RFaFdN?=
 =?utf-8?B?NkpJMWJXRFBGTUtiR0sycmQzVEZBQU5ZMG5YZ1grWmhlNUliNTRXTFpQaW5r?=
 =?utf-8?B?TTMwMkhRdXVUQzlvRVJXZHk5ZW5hOU1oY0liOUF2WDkxVUxWRTBkOTR2bUlo?=
 =?utf-8?B?Y3FPV1FZcUtSbWV0RkhScWl0MUlKSGh3T052NUEwdklPYzVJc0dKRVpMTTh0?=
 =?utf-8?B?K0JjSFkwQ2xyTEU5a1c3ZFJNT0h1ZzRGenFOeHZnT0NydTBiZjhpVFZxZmlj?=
 =?utf-8?B?RjU3dTRnYWV1bTVub0wrZ2s0T1NwVUVYdHFPOThHM0hqc1VNcUREYVZzdGxp?=
 =?utf-8?B?TWxUUFpkSDZLdXdiaHJGNEgxTnpDZ2FiWHlSSzQ3N2NUWGg2UFljZllmM2ZQ?=
 =?utf-8?B?enE1YlFJN01rQloyQlZjdDN1M2hvWnQzNlZBWkl2cWdJUE9TM0VCV3RXblNH?=
 =?utf-8?B?N3lHUUgrOXUwd2VTTjRvbEErdSt2SXhVWFVWWW5jOEZtNTZzVXl0eDlhTjFk?=
 =?utf-8?B?STZGVFA5SHAwOTlycjZwT3Eybkxpck1FL1RvbFJBSjB5SHNnVlJXL3RjbkZK?=
 =?utf-8?B?UnU5ck5WMmljS0Q3K3lHSmExZzN4N1Y3N2JRQ2xDbFRQSFE2OXJNMEE5KzB1?=
 =?utf-8?B?ZW0yQXBkYVVSYnRTTGk0enlGejdtY1d2OXloa1R6aEUzbzAwaXRmUVg5elRj?=
 =?utf-8?B?OUwwYlNvRFpiTjRGL05IRXZkUGtLM0dkNjdwcFpvbm13YVNzSUFIOTBxVG1y?=
 =?utf-8?B?bHFiWWR0TkRCN3lSR3FyOEdVMURBay9tbTV0ZVdMdk9uNE54cFRnVEZncy9S?=
 =?utf-8?B?VDdaSDJjZ3lvWEhhL25KMVNjeU1hbGJuZHFjeEF5eHIyUTVRZTBkNERZZHNa?=
 =?utf-8?B?alhoa2UvRTl5aldDVTd5MDJML2dCNVhGUTJrd0cvVU5CVUNyVFQ2aTVGVE9w?=
 =?utf-8?B?ZnZxZ3YrT3p4cTg1cmtYcWQrazBzbHJFQnY2NkRWR0dvWUVRS05hY0NyZ2pk?=
 =?utf-8?B?TW9HNUx0RTNmVS91c0dTclZOZkY2QkxjZkFWckFQREx3cTMxVUFFUE5ZQXdU?=
 =?utf-8?B?RzNuMkdQZXR1OUJoY1NGaUFaMnJqZVNYd3Y3TjQzOElYR0hpc1dSMFNhbDJN?=
 =?utf-8?B?ZUdBcy9qcGhNeDdNK0JwZnQrTUdXWFZmZnRnYmhERitLb3Q0Rlp2R2VXOW9C?=
 =?utf-8?B?a3p0Y29oY1pyOFNtelo5RWtXbTlYd1EvZUVXMUJGOS81cFJBR202dDZ2OFRm?=
 =?utf-8?B?R0g4dWVNTkViRUxqYkx6ZzI0MjhwQ2JzTkpJV2FFdXRtMWowSEt3Q2RTaVE1?=
 =?utf-8?B?WTNGeVk5SFpCVmc5ZmxpczlYdlluQnQ5eEtHeU00cmFkYUNuWXh5SlpsR0pn?=
 =?utf-8?B?NHo5ODV4WDFuM20xWWJrTUpzVk8zVnUrTlc4TVhnSitFeVdQOFhjRDI3QlU5?=
 =?utf-8?B?aDhjVlpxQmZLNzZCZGZxZzBFaFF4Vzl4aUFreHNTWWxiczFtSzB6a3BCNFlt?=
 =?utf-8?B?SVZRa3FpSnEzUVRBSEF0enZhdUdBYlVYWFdYajZoVUorSExqK2FleWJ0MTFt?=
 =?utf-8?B?eW9BMlpkdDBFL3FhaEpiRzFIVEpqZ1RRdUozNFFUNGU5ck1kWWFnR1FZUjJw?=
 =?utf-8?B?TjU5bmZtOW4xZElmZVZzRWNtRURuV3YxZ0JmQnpSMFNDM05UQ0hiZXRZNk51?=
 =?utf-8?Q?9Nh8=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 44f916ab-afc7-4a6a-73a0-08de16327176
X-MS-Exchange-CrossTenant-AuthSource: PAXSPRMB0053.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2025 14:58:24.2555
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iwQ/ideJih2YVooI8ZT/uOmKy0nbaP8XWJ64O8uAaJjXd+ArBqsszt6/knWOh2WM9WahRGNFITCCGSOq1+C4tg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB9097

Switch to use i3c_xfer instead of i3c_priv_xfer because framework will
update to support HDR mode. i3c_priv_xfer is now an alias of i3c_xfer.

Replace i3c_device_do_priv_xfers() with i3c_device_do_xfers(..., I3C_SDR)
to align with the new API.

Prepare for removal of i3c_priv_xfer and i3c_device_do_priv_xfers().

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/base/regmap/regmap-i3c.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/base/regmap/regmap-i3c.c b/drivers/base/regmap/regmap-i3c.c
index b5300b7c477e45668e303560739f8db13124275b..4482e64f26eba969e8eef3e60edb089b22aa99cd 100644
--- a/drivers/base/regmap/regmap-i3c.c
+++ b/drivers/base/regmap/regmap-i3c.c
@@ -10,7 +10,7 @@ static int regmap_i3c_write(void *context, const void *data, size_t count)
 {
 	struct device *dev = context;
 	struct i3c_device *i3c = dev_to_i3cdev(dev);
-	struct i3c_priv_xfer xfers[] = {
+	struct i3c_xfer xfers[] = {
 		{
 			.rnw = false,
 			.len = count,
@@ -18,7 +18,7 @@ static int regmap_i3c_write(void *context, const void *data, size_t count)
 		},
 	};
 
-	return i3c_device_do_priv_xfers(i3c, xfers, 1);
+	return i3c_device_do_xfers(i3c, xfers, 1, I3C_SDR);
 }
 
 static int regmap_i3c_read(void *context,
@@ -27,7 +27,7 @@ static int regmap_i3c_read(void *context,
 {
 	struct device *dev = context;
 	struct i3c_device *i3c = dev_to_i3cdev(dev);
-	struct i3c_priv_xfer xfers[2];
+	struct i3c_xfer xfers[2];
 
 	xfers[0].rnw = false;
 	xfers[0].len = reg_size;
@@ -37,7 +37,7 @@ static int regmap_i3c_read(void *context,
 	xfers[1].len = val_size;
 	xfers[1].data.in = val;
 
-	return i3c_device_do_priv_xfers(i3c, xfers, 2);
+	return i3c_device_do_xfers(i3c, xfers, 2, I3C_SDR);
 }
 
 static const struct regmap_bus regmap_i3c = {

-- 
2.34.1


