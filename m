Return-Path: <netdev+bounces-251017-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D626BD3A287
	for <lists+netdev@lfdr.de>; Mon, 19 Jan 2026 10:12:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id A904530087B4
	for <lists+netdev@lfdr.de>; Mon, 19 Jan 2026 09:12:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D085E352C43;
	Mon, 19 Jan 2026 09:12:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="ZVe9od1B"
X-Original-To: netdev@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013044.outbound.protection.outlook.com [52.101.72.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 021CC34D4D3;
	Mon, 19 Jan 2026 09:12:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768813956; cv=fail; b=C+emmhtDTKj0p9oFFWBe3t1WGCYsdfElF8xnM84EFrVhEBMG4BcIasT7JLriVnbiIKeP8asJPaxnn64eRWQISEAgRhIcDmH1VZsjgIHMGf8ig5EdSVlMU3egZaobH0G6rD6Nj7Pzlcnu1QY/QpuA/jUdim+aGp5nE2hfz6qqfmU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768813956; c=relaxed/simple;
	bh=B1JlWI47z6z87KD4bhX1lqJUYuht5TYddKYK2DE800U=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=uTvehQDi4atZep91RJ/Bmn795fmGGiXcjE0/AUQnjZiBsKipTJgYODAd6kzuiAGzWXtg60YO2f1Rq1LlfCAFdPYTpSivC/Rtcr91S+IkDcDmLSH6N6fw4jek9lNASQICQySZD5lyFxkHBZp9JoF4Kua7WGIPiaW/Ah8K92k0Do0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=ZVe9od1B; arc=fail smtp.client-ip=52.101.72.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rtqWd6BBVAU5e5WGwmebxlC1wBaOF7s92rfTpQBKWzaikiwP00PoZyR4XPp7/fvKGDiqfGAETUmkrK/WiuNfr5/a7kba7TV5ExvY/7LmKmzuR7VLfqfkHa1gnx+t9hX1lHe5Gh6zGlaWUERqqLPKJ6AowP4jiqgBE2vYfsmXOgwSq04foZcLejXtozrF37XqsS5ESMnzok1SRPLY6jrZp3MMxfciPZvkihcJs0rZiYRU7UZ3p+CrbmszZ5foWJN8/EOORlek0qah8K8j/k43/5AKVXjAiVLEfV+FrXnWFarWlK2ZljDqqUKtHUIXpnSX2aFkeW7n1HehT2MZ64ZXgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6mGO8vAOuUQb1ffEkG7xSkwq8RQyte0djlp92yaWP4M=;
 b=fojlNdxVFVjMFSO+/l7WjHynN5u9iA65be3mCUYzPiNopWXRWfdrvGNVxzvaZd38oUm5iuQHDrPVklTet22cPNJ7+wUVrKnWEpoAaWiOMqGV8A8kO5w5k7alXR5mvFOq8OtJD/pJeVBNm16nPQZsEb5yQiAJEc8BE6fU7sFyQ+3MTSGYJVprsaXo93x60uzRP/C+q6i8bUYAQoq/ShWHHe2ZEqZ5osUiVUZ4aPMUp/TtFolsY/M9NPqb71hPvgErcMHbklV4TkbPsIkatQ5z4zeRpvZmqGmDLn3PubNJDOakASK+Ur+nMnw65x8Qb0bBtS04pydbFKDp2lQ1tgL/lQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6mGO8vAOuUQb1ffEkG7xSkwq8RQyte0djlp92yaWP4M=;
 b=ZVe9od1Bm2qad4hp9rK9hphEvhGQGzC73bE1o/wUXPorfRlpXyFkWQBBs7z/xjN3hK9wFXvV7Kxy7rgCrtT3Yp4mUC9tb5CKfsf+t2ddiKlJLJiBguMDIg6l/gu3xh1OW9z/BuXtENg8ijK42QGwqq0A4sHq0qgYVHep2rbOliaMQGtw5SQz/pNl4pLfQaRQwVBFsFSOWZ2JTP5OP1/AkeHnvugtr0/fnKUJ8cRVNJcHnn7TihiiMZL5SFYO4Iry0Q1l7X2jSBA3zUZanBMPrMFBf5VL+hW3vM1GYTdQfg+VfQCL5zFN+CVIuQqhH8ANSqTy7CpkKE5rklu4QaiWZA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com (2603:10a6:20b:438::13)
 by VI2PR04MB10762.eurprd04.prod.outlook.com (2603:10a6:800:26e::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.11; Mon, 19 Jan
 2026 09:12:31 +0000
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::f010:fca8:7ef:62f4]) by AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::f010:fca8:7ef:62f4%4]) with mapi id 15.20.9520.011; Mon, 19 Jan 2026
 09:12:31 +0000
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: netdev@vger.kernel.org,
	devicetree@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	Daniel Golle <daniel@makrotopia.org>,
	Horatiu Vultur <horatiu.vultur@microchip.com>,
	=?UTF-8?q?Bj=C3=B8rn=20Mork?= <bjorn@mork.no>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Eric Woudstra <ericwouds@gmail.com>,
	Alexander Couzens <lynxis@fe80.eu>,
	"Chester A. Unal" <chester.a.unal@arinc9.com>,
	DENG Qingfang <dqfext@gmail.com>,
	Sean Wang <sean.wang@mediatek.com>,
	Felix Fietkau <nbd@nbd.name>
Subject: [PATCH v4 net-next 0/5] PHY polarity inversion via generic device tree properties
Date: Mon, 19 Jan 2026 11:12:15 +0200
Message-Id: <20260119091220.1493761-1-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM0PR02CA0170.eurprd02.prod.outlook.com
 (2603:10a6:20b:28e::7) To AM9PR04MB8585.eurprd04.prod.outlook.com
 (2603:10a6:20b:438::13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8585:EE_|VI2PR04MB10762:EE_
X-MS-Office365-Filtering-Correlation-Id: 040d617e-1276-41d4-7359-08de573ae043
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|1800799024|366016|52116014|7416014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?S2VVUUErQ0RNbE5vWUdBb3ErREFrVGx4dmhYUDI2V3h5MzVEYnN5RHpmcVk3?=
 =?utf-8?B?NEF0RCtiSkZZb0VoQzhJeS9SNVMwaVJtZ3VDaVRqU2hma3hiSGVhWWxTQ0s0?=
 =?utf-8?B?eDN4MGx2V0ZSWjgzczhKQzlwdWVtbWpuMkdjMUtacGV1TEpsOVJQTDF3bGs0?=
 =?utf-8?B?aU85dmNVTHYybnpFYU1qblhPdWZ4eGZYSk1ZNTVRK2g0clA1YmJvd01YZm5v?=
 =?utf-8?B?dnYyb1RUdytKR2dCQlNEdUxKOTNNM2g3MnlVMytQenU3N0F5Y3Qwb09sblVy?=
 =?utf-8?B?WDJueDdEYyt4NDJYaEpESEM3OUxickpEZzdVQTYvL0FqOFd5TTB4NTNJYWR0?=
 =?utf-8?B?THcvMXlOU3Y4NFZKVFNiWERyL2JOdlFYd3g3T2dqWFVITUF6Y1FDRWRZa1dx?=
 =?utf-8?B?c2RUWjBoUDBXa08yYW1aUExXeGlHb2FiTnRlYTVhRWNCRlVhQ2s0R0JUTHZ5?=
 =?utf-8?B?a1FNcjdUZkZWQkJveWFjTWc3VFREam9LRE5tc2tNRGY1MVlvVWUxWUpiNVQv?=
 =?utf-8?B?SCthMkdqVm5NUTM1SlFOVFRxcmJmM2l0K2txMzBoRkxmSUE2L3ZoMThhQTBw?=
 =?utf-8?B?Sk5sbHdSRzdoRHJRdXk3N2N3Q3J3SjlycWtPVG9lM3l5aU9yTVdvZ0FRN2hI?=
 =?utf-8?B?N21GN3AwZXRoS3lQbnJZMm40bUw1bVcwNXJCNXN1WjlIUUNtQzZCazhaalZy?=
 =?utf-8?B?WjVkSXlrbmJJOURva3ZUTHgzYXNEYjBRL1pHcXE4Z294TGlpYkpRYnJUYjZa?=
 =?utf-8?B?RXBFdHZCUmVwT3NsNm92Q0Vob3BobERodUpFaXdhM2lNcEhCTWlldi9PMjly?=
 =?utf-8?B?WEhmbkVDdXAvZlN1UTJBOEszSWo2K0MwSklKWWozb1BjdWNNa0VpV0E4NGUr?=
 =?utf-8?B?R2UxNnNOVURzMEgzSVJUTTRuOG1BUUpUc1pDYmx0RkgzYXVEUWpFaWJWL1ZN?=
 =?utf-8?B?SWNPOUQ3QUFZRzFYR08ydEk2ck5VaXJhVXROMU8zdFlzTWsxVUNaVTZFelR3?=
 =?utf-8?B?b2x4SHhjZDJJbTNxTWh6NXpYR2pQTmZIUWVUSk5wVFVqZXlhRmNCeXhBSm9z?=
 =?utf-8?B?Tng3L0pmYnNScnllTTZDZWp4NG9ENEp3TTB2d3hYTUtwWXpsT05HMUlIZFFE?=
 =?utf-8?B?ZkxDRWcvWExYUXhsVHVLd3dqNjgwOWt3RUVSL0x6aEg4MEYzZGY4WC9IYVFP?=
 =?utf-8?B?RXV3Y29aeGF2eExPb3ZXRytMdEpPMjBSQmpFdzIzdGVIZHdzRDRXV0lFS2Ra?=
 =?utf-8?B?UndObzhLQVRLVDRlWlEzUlVmZGd5V0crbEpqekpoT3V6dkZMM1ZBOVhJT0JG?=
 =?utf-8?B?Y1o1ZEU4Z3F4Q3R3ZCt5dHB3azNiWDhpM3lEYmYySFg2c00ySHR4QU52YVgv?=
 =?utf-8?B?RkpCNVlXYVN1bTMrZzgvTmVIYktuWklkeXViUWNTR2VTcTM2MDViVGFIb294?=
 =?utf-8?B?YjZDYnNCcjFBYWk0RS9qV3pVY3libERGQUlBTmYySnBMS1ZMSXZ3WENBLzA4?=
 =?utf-8?B?b0xSUnZ2MWZwVk01RFExMGRVQzNSd3F5Q2lSUk5SeDNPOGMxVklEbU9jaFQ0?=
 =?utf-8?B?RmFDOU9WN2xvTlp4c09wV1RGd2txZUFHWktDWVYwakNkMndORDJDbGZLVUYr?=
 =?utf-8?B?WnJ1WC9wQ2tyNFBUN0o4L1V1dHpwQ1I4TG1wNnV4dVl4d1VQZ2l2TitWNlF3?=
 =?utf-8?B?S1VscTAwTXhRMktaeG1YTk9QUFhhdGowK1g0WTBZTEpqTnhKOFNwVE9GdjVM?=
 =?utf-8?B?NE43RmlJcjV2S1ZHd2dYWVhlVnZ4SDVwVkRZRytRWitXZ215VWljQjBkRnRx?=
 =?utf-8?B?ZWZqYys3MFZEYXBsZStxLzdXWk5rc3RPcnlFMytuQ1NuSWMvc3dzVHBvOXor?=
 =?utf-8?B?Z2UwSUwralVqaUFjZ0Q5VSsxd2hEVXZwelRvRnNDdFVlSHdjbTBkVTlPaURp?=
 =?utf-8?B?MHZGRXZNZGQrbXJVZTZYOU1JdjQ2MmtncGN6Q05PcHZVbHBrdWh5WUFqeFdK?=
 =?utf-8?B?Ni8zSjF4UndCM2FaZjd0K2RrV2ExSEliQ1dyVEljQkljVlIxQm1vU3lHRWxZ?=
 =?utf-8?B?YkRLTGdNSXVXNWNwTXlDeWI4S0NSVlFzRHU1azM1SjYzeVlXdkxBaW5HVW10?=
 =?utf-8?B?TkNpMW9zY2FzS2lremNsTzROOVdoMlJYYW0wT01RdGU1OG1aTUpmWDVnYVFE?=
 =?utf-8?Q?ui/wLhJSEj3fLPozmnmHFfI=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8585.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(1800799024)(366016)(52116014)(7416014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dmVzczVieHc1ZURONHFtYjZ4TUE2K20yU1RXMGV6VHRpdkFNc2VrMXJXeTBK?=
 =?utf-8?B?VlF4K1J3cjFoazJqcUcyYUZjNHV6T01IY3hnV2psRmhXZEdtK3ZzTmVuNmZQ?=
 =?utf-8?B?QWZ0Q29HWm1IL1ZjR2lIYjFUZlhpQjNHZVdDN25DOUJxZTV1SGNLY3h2VWZU?=
 =?utf-8?B?b2xnYlVVOVFHa25DU1RRRnI5blJycXFaSHBGTFIzNmduZm91ZjY2SDh4SFhW?=
 =?utf-8?B?UDluU1FXQ2w2Q0YyVENtZGxoOWdMbXQ1c29SMGg5MDFpUERSbmltV3FGYmtZ?=
 =?utf-8?B?K3djb2x3cFdDZUNmR0VhT1VSQlpvOWlPRy8xRlhVMmcyejJQVm4rQk85N0V2?=
 =?utf-8?B?cjQ0V0d3NWdyYlFpbVVuaXhjbUlaS1V5aUcvOUcrODk1d0ZpdHFiYzBsd3VN?=
 =?utf-8?B?MEs4aDV5WDZKV0NZdE9JcUpEdHNhZjZuWm1IUTVKaEtHTmMzV01XQktac3p1?=
 =?utf-8?B?NXk4VGZERWl6QlFpWXJvVUFMQmQ2NjRhdmw4YjJkQ2dXdDc5UkRSMmVuMjlD?=
 =?utf-8?B?ZFd1OStWeFhKUkNCUmpCSnRPeEFjbXFyRHNod3libkt2bmZwY3ZSN1BybHpm?=
 =?utf-8?B?MkU1RTVYY3k3R1ZyRElaSWpyMmJIcXpHS2FWVXRMUjA5RnRocDBvb0FMR1Vm?=
 =?utf-8?B?ZFkvU1ZDZmRDcjE0N21xREZxeFJjTmtTWW1abjlLVXhnSHJYdk1yRlBFNEx1?=
 =?utf-8?B?enNUcjRoNXl6NStLWjVSZkg3dWg3cG1TOWVsK0FYWDVLb0FJcGw2UnlWWHox?=
 =?utf-8?B?N0J5VG9NNzU1dTBvOHJtOUR0bTFFUWd0MGYzWFd3ejhtZS83V0hFRkUrdVF3?=
 =?utf-8?B?L3ovUERsS1lGQ2RUMGZZWFFVUjlzQzFaZjBKZFppcXFPYVRWYzgrUjk1aWJ2?=
 =?utf-8?B?VUgxQmtQdzZMMzFhRzNiVG0vTE1KZnNxL2xFSHZ2MWlIUzFBajREWWtwQW9S?=
 =?utf-8?B?dWhQd3pJendQRjVWNHU2bVppNnFUTnR4QWprWkRXa1ZRdlU2NEFmenFiVDBt?=
 =?utf-8?B?dVhhL2tNYkNHQmNHUFRpanVjeTlXcEZscXNQd2VWdzdyczlCVFVKNlpiL3pE?=
 =?utf-8?B?RXA5UGZmbG9ZaTE3YzBEOW4zc3JPRFoxSUE3OFlxNUl4c1Q2KzVIZGpoRzFW?=
 =?utf-8?B?UlFCbmdnSXg0Mk9BOFhISFZKclcwUW04WU13MTByZXV2a0V6Q2tSRGY5cE9W?=
 =?utf-8?B?c0xPdGRNOEwzQWJxdk9wd0FXZXI1TkxWb0hwVUtjbUMrYkRGRWJTSlFlc21Z?=
 =?utf-8?B?bHkvdklCamtMMk9kU1dWVjAxYlZrY01pSS9OY25xVDRBdk10c292bjgyU0xM?=
 =?utf-8?B?OUxjYzdCWGhLdmkwVHhtME5jRnUzRW0vQ3l1SlVSd1RCUjJJc3gzZm56cmow?=
 =?utf-8?B?VERjNWVZRXM0bFNISWE3dWNob1lDTGxZVkpoUEhubEdXSkpyUUtkcGxQTTdK?=
 =?utf-8?B?TzZyZlkrWkorb3VnZ01CRmU0aUNnVDBwQm1JVDBpMVlCS1cvR01EWHdXdnUx?=
 =?utf-8?B?dGFtT2lwRGR6OFpTKzdwUXhTb05tTndlRE5iM21qQklYSERNNXRaaDNxNzBV?=
 =?utf-8?B?RUpxS09QRVRSaVZkbU5ON3R1ZXhCWU9TVUt3VUVCT2YveTFyUUhKNFhtbmNT?=
 =?utf-8?B?VDdmV2UvZ01Db2hocjNHNHJXM0NBRm5mdXZuOGtaaUVvL2h3aDZybDZldncy?=
 =?utf-8?B?aTBBRTl5T3dTSzUvNTZ4cDFWUm5zTDBHK0FoMkdzeThmbWNtcU0zNi9sbU5z?=
 =?utf-8?B?djh6Sm5aREdKRGlZbXNWNGYrdHI5UngzSjZ0dVNSYjkwQUJzKzZ4KzZFWGdz?=
 =?utf-8?B?azJVVXBpVUhUTm5MT1JQU1dZL0MvZWxkYWJFcDhBTy9mTUI3Mks3UFF1QS91?=
 =?utf-8?B?cGRQUHFRRnhEeUdLL3M0TXRpN0d0TnFHR3V6N2RXNExOaEoyeFlrZ1RnZkV2?=
 =?utf-8?B?dWMwaEd6cEdac3pRc1BwbmttSU1RUzI5ZVcwV09QTVZhM3hzMlRPbXZIbXBI?=
 =?utf-8?B?RlJYQ3IzQ3h4ek1yajZwUHV1VnExRlJBMlNSUnJRNmlYYk1WTnBmQStZU3hY?=
 =?utf-8?B?K0FsV1M3RHdrd1BLTnJtQjFvVTc2djRCRHFjWmI3eGJHNTBNUjlhQm5tY3py?=
 =?utf-8?B?QXhiWmwzaUtIeUc5R1gxRkx0MCs1dFdOeHJMTFlhb29RZ3IzTGZhdDBKbGlN?=
 =?utf-8?B?dlJISnEwNmFUSGM1YWdCVFRVT3ZKWkxRT1QvMmV6SEhmekFuVkNETEtyREpJ?=
 =?utf-8?B?cjZjWFNEeGg0cXJJRkVwZExPSFBXNGlqdlNyQlNsRCs2UkxkdjU2OTRHK2h6?=
 =?utf-8?B?K2QxSXhTaVB6eGFXYkVKN2VpTTdIdWtraThjZVd5V3ArdXFwVnVzUT09?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 040d617e-1276-41d4-7359-08de573ae043
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8585.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2026 09:12:31.7394
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: v2ppTGwi/fZLyxyB+sCqJJQiyeKbPO/haKrouTPvnA8+oWn1vS6eLnNDini7uhvzgKGA3U02u0x6oAq7JXm5Fg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR04MB10762

Using the "rx-polarity" and "tx-polarity" device tree properties
introduced in linux-phy and merged into net-next in
https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git/commit/?id=96a2d53f24787df907e8bab388cc3e8f180a2314
we convert here two existing networking use cases - the EN8811H Ethernet
PHY and the Mediatek LynxI PCS.

v3 at:
https://lore.kernel.org/netdev/20260111093940.975359-1-vladimir.oltean@nxp.com/
Changes since v3:
It was requested that v3 be resent with just the networking parts, there
is no change.

v2 at:
https://lore.kernel.org/netdev/20260103210403.438687-1-vladimir.oltean@nxp.com/
Changes since v2:
- fix bug with existing fwnode which is missing polarity properties.
  This is supposed to return the default value, not an error. (thanks to
  Bjørn Mork).
- fix inconsistency between PHY_COMMON_PROPS and GENERIC_PHY_COMMON_PROPS
  Kconfig options by using PHY_COMMON_PROPS everywhere (thanks to Bjørn
  Mork).

v1 at:
https://lore.kernel.org/netdev/20251122193341.332324-1-vladimir.oltean@nxp.com/
Changes since v1:
- API changes: split error code from returned value; introduce two new
  helpers for simple driver cases
- Add KUnit tests
- Bug fixes in core code and in drivers
- Defer XPCS patches for later (*)
- Convert Mediatek LynxI PCS
- Logical change: rx-polarity and tx-polarity refer to the currently
  described block, and not necessarily to device pins
- Apply Rob's feedback
- Drop the "joint maintainership" idea.

(*) To simplify the generic XPCS driver, I've decided to make
"tx-polarity" default to <PHY_POL_NORMAL>, rather than <PHY_POL_NORMAL>
OR <PHY_POL_INVERT> for SJA1105. But in order to avoid breakage, it
creates a hard dependency on this patch set being merged *first*:
https://lore.kernel.org/netdev/20251118190530.580267-1-vladimir.oltean@nxp.com/
so that the SJA1105 driver can provide an XPCS fwnode with the right
polarity specified. All patches in context can be seen at:
https://github.com/vladimiroltean/linux/tree/phy-polarity-inversion

Original cover letter:

Polarity inversion (described in patch 4/10) is a feature with at least
4 potential new users waiting for a generic description:
- Horatiu Vultur with the lan966x SerDes
- Daniel Golle with the MaxLinear GSW1xx switches
- Bjørn Mork with the AN8811HB Ethernet PHY
- Me with a custom SJA1105 board, switch which uses the DesignWare XPCS

I became interested in exploring the problem space because I was averse
to the idea of adding vendor-specific device tree properties to describe
a common need.

This set contains an implementation of a generic feature that should
cater to all known needs that were identified during my documentation
phase.

Apart from what is converted here, we also have the following, which I
did not touch:
- "st,px_rx_pol_inv" - its binding is a .txt file and I don't have time
  for such a large detour to convert it to dtschema.
- "st,pcie-tx-pol-inv" and "st,sata-tx-pol-inv" - these are defined in a
  .txt schema but are not implemented in any driver. My verdict would be
  "delete the properties" but again, I would prefer not introducing such
  dependency to this series.

Vladimir Oltean (5):
  dt-bindings: net: airoha,en8811h: deprecate "airoha,pnswap-rx" and
    "airoha,pnswap-tx"
  net: phy: air_en8811h: deprecate "airoha,pnswap-rx" and
    "airoha,pnswap-tx"
  dt-bindings: net: pcs: mediatek,sgmiisys: deprecate "mediatek,pnswap"
  net: pcs: pcs-mtk-lynxi: pass SGMIISYS OF node to PCS
  net: pcs: pcs-mtk-lynxi: deprecate "mediatek,pnswap"

 .../bindings/net/airoha,en8811h.yaml          | 11 +++-
 .../bindings/net/pcs/mediatek,sgmiisys.yaml   |  7 ++-
 drivers/net/dsa/mt7530-mdio.c                 |  4 +-
 drivers/net/ethernet/mediatek/mtk_eth_soc.c   | 19 +++---
 drivers/net/pcs/Kconfig                       |  1 +
 drivers/net/pcs/pcs-mtk-lynxi.c               | 63 ++++++++++++++++---
 drivers/net/phy/Kconfig                       |  1 +
 drivers/net/phy/air_en8811h.c                 | 53 +++++++++++-----
 include/linux/pcs/pcs-mtk-lynxi.h             |  5 +-
 9 files changed, 121 insertions(+), 43 deletions(-)

-- 
2.34.1


